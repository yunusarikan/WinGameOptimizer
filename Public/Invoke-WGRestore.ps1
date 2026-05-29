function Invoke-WGRestore {
    <#
    .SYNOPSIS
        Optimizasyonları geri alır ve varsayılan ayarlara döndürür.
    .DESCRIPTION
        Yedeklenen registry dosyalarını geri yükler ve servisleri
        varsayılan başlangıç durumuna getirir.
    .PARAMETER BackupPath
        Geri yüklenecek yedek klasörü yolu.
    .EXAMPLE
        Invoke-WGRestore
    .EXAMPLE
        Invoke-WGRestore -BackupPath "C:\Backup\WinGameOptimizer_20250101_120000"
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [string]$BackupPath
    )
    
    if (-not (Test-WGAdmin)) {
        Write-Host "HATA: Bu script yönetici yetkisi gerektirir!" -ForegroundColor Red
        return
    }
    
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "  GERİ YÜKLEME İŞLEMİ" -ForegroundColor Cyan
    Write-Host "============================================`n" -ForegroundColor Cyan
    
    if (-not $BackupPath) {
        # En son yedeği bul
        $backups = Get-ChildItem -Path $script:BackupPath -Directory | Sort-Object LastWriteTime -Descending
        if ($backups.Count -eq 0) {
            Write-Host "Hiç yedek bulunamadı!" -ForegroundColor Red
            return
        }
        $BackupPath = $backups[0].FullName
        Write-Host "En son yedek kullanılıyor: $BackupPath" -ForegroundColor Yellow
    }
    
    if (-not (Test-Path $BackupPath)) {
        Write-Host "Yedek klasörü bulunamadı: $BackupPath" -ForegroundColor Red
        return
    }
    
    Write-Host "Yedek geri yükleniyor...`n" -ForegroundColor Yellow
    
    # Registry dosyalarını geri yükle
    $regFiles = Get-ChildItem -Path $BackupPath -Filter "*.reg"
    foreach ($regFile in $regFiles) {
        Write-Host "Registry geri yükleniyor: $($regFile.Name)..." -ForegroundColor Gray
        try {
            reg import $regFile.FullName | Out-Null
            Write-Host "  [+] $($regFile.Name) geri yüklendi" -ForegroundColor Green
        }
        catch {
            Write-Host "  [-] $($regFile.Name) geri yükleme hatası: $_" -ForegroundColor Red
        }
    }
    
    # Servisleri geri yükle
    $servicesFile = Join-Path -Path $BackupPath -ChildPath "Services.xml"
    if (Test-Path $servicesFile) {
        Write-Host "Servisler geri yükleniyor..." -ForegroundColor Yellow
        $savedServices = Import-Clixml -Path $servicesFile
        foreach ($savedService in $savedServices) {
            try {
                $currentService = Get-Service -Name $savedService.Name -ErrorAction SilentlyContinue
                if ($currentService) {
                    Set-Service -Name $savedService.Name -StartupType $savedService.StartType -ErrorAction Stop
                    if ($savedService.Status -eq 'Running') {
                        Start-Service -Name $savedService.Name -ErrorAction SilentlyContinue
                    }
                }
            }
            catch {
                Write-Host "  [-] Servis geri yükleme hatası: $($savedService.Name)" -ForegroundColor Red
            }
        }
        Write-Host "  [+] Servisler geri yüklendi" -ForegroundColor Green
    }
    
    # Güç planını varsayılana al
    Write-Host "Güç planı varsayılana alınıyor..." -ForegroundColor Yellow
    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
    
    Write-Host "`n============================================" -ForegroundColor Green
    Write-Host "  GERİ YÜKLEME TAMAMLANDI!" -ForegroundColor Green
    Write-Host "============================================`n" -ForegroundColor Green
    Write-Host "Değişikliklerin tam etkisi için yeniden başlatma önerilir." -ForegroundColor Yellow
}