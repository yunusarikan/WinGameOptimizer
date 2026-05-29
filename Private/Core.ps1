# Çekirdek yardımcı fonksiyonlar

function Test-WGAdmin {
    <#
    .SYNOPSIS
        Yönetici yetkisi kontrolü yapar.
    #>
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function New-WGBackup {
    <#
    .SYNOPSIS
        Sistem geri yükleme noktası ve registry yedeği oluşturur.
    #>
    param(
        [string]$BackupName = "WinGameOptimizer_Backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    )
    
    $backupDir = Join-Path -Path $script:BackupPath -ChildPath $BackupName
    New-Item -Path $backupDir -ItemType Directory -Force | Out-Null
    
    # Sistem geri yükleme noktası oluştur
    try {
        Checkpoint-Computer -Description $BackupName -RestorePointType MODIFY_SETTINGS
        Write-Host "Sistem geri yükleme noktası oluşturuldu." -ForegroundColor Green
    }
    catch {
        Write-Host "Sistem geri yükleme noktası oluşturulamadı: $_" -ForegroundColor Yellow
    }
    
    # Registry yedeği al
    $regBackupFile = Join-Path -Path $backupDir -ChildPath "RegistryBackup.reg"
    try {
        reg export "HKCU\Software\Microsoft\Windows\CurrentVersion" "$backupDir\HKCU_CurrentVersion.reg" /y | Out-Null
        reg export "HKCU\Control Panel" "$backupDir\HKCU_ControlPanel.reg" /y | Out-Null
        reg export "HKCU\System" "$backupDir\HKCU_System.reg" /y | Out-Null
        reg export "HKLM\SYSTEM\CurrentControlSet\Control\Power" "$backupDir\HKLM_Power.reg" /y | Out-Null
        reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia" "$backupDir\HKLM_Multimedia.reg" /y | Out-Null
        reg export "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" "$backupDir\HKLM_Graphics.reg" /y | Out-Null
        
        # Servis durumlarını yedekle
        Get-Service | Select-Object Name, StartType, Status | Export-Clixml -Path "$backupDir\Services.xml"
        
        Write-Host "Registry ve servis yedekleri alındı: $backupDir" -ForegroundColor Green
    }
    catch {
        Write-Host "Yedekleme sırasında hata: $_" -ForegroundColor Red
    }
    
    return $backupDir
}

function Set-WGRegistry {
    <#
    .SYNOPSIS
        Registry değeri ayarlar, hata durumunda loglar.
    #>
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [string]$Type = "DWORD"
    )
    
    try {
        # Klasör yolunun var olduğundan emin ol
        if (-not (Test-Path $Path)) {
            New-Item -Path $Path -Force | Out-Null
        }
        
        switch ($Type) {
            "DWORD" {
                Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type DWord -Force -ErrorAction Stop
            }
            "String" {
                Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type String -Force -ErrorAction Stop
            }
            "Binary" {
                Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type Binary -Force -ErrorAction Stop
            }
            "Remove" {
                Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
            }
        }
        Write-Host "  [+] $Path\$Name = $Value" -ForegroundColor Gray
    }
    catch {
        Write-Host "  [-] Registry hatası: $Path\$Name - $_" -ForegroundColor Red
    }
}

function Stop-WGService {
    <#
    .SYNOPSIS
        Bir servisi durdurur ve devre dışı bırakır.
    #>
    param(
        [string]$ServiceName
    )
    
    try {
        $service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
        if ($service) {
            if ($service.Status -eq 'Running') {
                Stop-Service -Name $ServiceName -Force -ErrorAction Stop
            }
            Set-Service -Name $ServiceName -StartupType Disabled -ErrorAction Stop
            Write-Host "  [+] Servis devre dışı: $ServiceName" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "  [-] Servis hatası: $ServiceName - $_" -ForegroundColor Red
    }
}

function Start-WGService {
    <#
    .SYNOPSIS
        Bir servisi eski haline döndürür.
    #>
    param(
        [string]$ServiceName,
        [string]$OriginalStartType = "Manual"
    )
    
    try {
        Set-Service -Name $ServiceName -StartupType $OriginalStartType -ErrorAction Stop
        Start-Service -Name $ServiceName -ErrorAction SilentlyContinue
        Write-Host "  [+] Servis geri yüklendi: $ServiceName -> $OriginalStartType" -ForegroundColor Gray
    }
    catch {
        Write-Host "  [-] Servis geri yükleme hatası: $ServiceName - $_" -ForegroundColor Red
    }
}

function Remove-WGUWPApp {
    <#
    .SYNOPSIS
        UWP uygulamasını kaldırır.
    #>
    param(
        [string]$PackageName
    )
    
    try {
        $package = Get-AppxPackage -Name $PackageName -ErrorAction SilentlyContinue
        if ($package) {
            Remove-AppxPackage -Package $package.PackageFullName -ErrorAction Stop
            Write-Host "  [+] UWP kaldırıldı: $PackageName" -ForegroundColor Gray
        }
        
        # Provisioned package'ı da kaldır
        $provisioned = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $PackageName }
        if ($provisioned) {
            Remove-AppxProvisionedPackage -Online -PackageName $provisioned.PackageName -ErrorAction Stop
            Write-Host "  [+] Provisioned package kaldırıldı: $PackageName" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "  [-] UWP kaldırma hatası: $PackageName - $_" -ForegroundColor Red
    }
}

function Invoke-WGCommand {
    <#
    .SYNOPSIS
        Harici komut çalıştırır, hataları yakalar.
    #>
    param(
        [string]$Command
    )
    
    try {
        Invoke-Expression $Command -ErrorAction Stop
        Write-Host "  [+] Komut çalıştırıldı: $Command" -ForegroundColor Gray
    }
    catch {
        Write-Host "  [-] Komut hatası: $Command - $_" -ForegroundColor Red
    }
}