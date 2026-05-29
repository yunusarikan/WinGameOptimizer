function Optimize-WGGPU {
    <#
    .SYNOPSIS
        GPU ve ekran kartı optimizasyonlarını uygular.
    .DESCRIPTION
        Donanım hızlandırmalı GPU zamanlaması, MSI modu,
        tam ekran iyileştirmeleri ve düşük gecikme ayarları.
    #>
    
    Write-Host "`n===== GPU OPTİMİZASYONLARI =====" -ForegroundColor Cyan
    
    # Donanım Hızlandırmalı GPU Zamanlamasını Aç
    Write-Host "GPU zamanlaması etkinleştiriliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2
    
    # Tam Ekran İyileştirmelerini Kapat
    Write-Host "Tam ekran iyileştirmeleri kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Value 1
    
    # GPU önceliğini oyunlar için yükselt
    Write-Host "GPU öncelik modu ayarlanıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Value 8
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Value 6
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Value "High"
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "SFIO Priority" -Value "High"
    
    # MMCSS (Multimedia Class Scheduler Service) ayarları
    Write-Host "MMCSS ayarları yapılandırılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NoLazyMode" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "AlwaysOn" -Value 1
    
    # Oyunlar için GPU iş öğesi önceliği
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Latency Sensitive" -Value "True" -Type "String"
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Background Only" -Value "False" -Type "String"
    
    # MSI Mode (GPU için) - İleri seviye, opsiyonel
    Write-Host "MSI Mode kontrol ediliyor..." -ForegroundColor Yellow
    $gpuDevices = Get-PnpDevice -Class Display -ErrorAction SilentlyContinue
    foreach ($gpu in $gpuDevices) {
        try {
            $instanceId = $gpu.InstanceId
            $regPath = "HKLM:\SYSTEM\CurrentControlSet\Enum\$instanceId\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties"
            Set-WGRegistry -Path $regPath -Name "MSISupported" -Value 1
        }
        catch {
            Write-Host "  [-] MSI Mode ayarlanamadı: $($gpu.FriendlyName)" -ForegroundColor Yellow
        }
    }
    
    # DWM (Desktop Window Manager) performans iyileştirmeleri
    Write-Host "DWM performans ayarları yapılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AlwaysHibernateThumbnails" -Value 0
    
    Write-Host "GPU optimizasyonları tamamlandı." -ForegroundColor Green
    Write-Host "NOT: GPU zamanlaması ve MSI modu için yeniden başlatma gerekebilir." -ForegroundColor Yellow
}