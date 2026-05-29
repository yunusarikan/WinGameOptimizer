function Get-WGStatus {
    <#
    .SYNOPSIS
        Sistem optimizasyon durumunu gösterir.
    .DESCRIPTION
        Hangi tweak'lerin uygulandığını, sistem durumunu
        ve yedekleri listeler.
    .EXAMPLE
        Get-WGStatus
    #>
    
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "  SİSTEM DURUM RAPORU" -ForegroundColor Cyan
    Write-Host "============================================`n" -ForegroundColor Cyan
    
    # Güç Planı
    $currentPlan = powercfg /getactivescheme
    Write-Host "GÜÇ PLANI:" -ForegroundColor Yellow
    Write-Host "  $currentPlan`n" -ForegroundColor White
    
    # Oyun Modu
    $gameMode = Get-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -ErrorAction SilentlyContinue
    Write-Host "OYUN MODU:" -ForegroundColor Yellow
    if ($gameMode.AllowAutoGameMode -eq 1) {
        Write-Host "  Etkin`n" -ForegroundColor Green
    }
    else {
        Write-Host "  Devre Dışı`n" -ForegroundColor Red
    }
    
    # GPU Zamanlaması
    $gpuScheduling = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -ErrorAction SilentlyContinue
    Write-Host "GPU ZAMANLAMASI:" -ForegroundColor Yellow
    if ($gpuScheduling.HwSchMode -eq 2) {
        Write-Host "  Etkin`n" -ForegroundColor Green
    }
    else {
        Write-Host "  Devre Dışı`n" -ForegroundColor Red
    }
    
    # Görsel Efektler
    $visualFX = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -ErrorAction SilentlyContinue
    Write-Host "GÖRSEL EFEKTLER:" -ForegroundColor Yellow
    if ($visualFX.VisualFXSetting -eq 2) {
        Write-Host "  En İyi Performans`n" -ForegroundColor Green
    }
    else {
        Write-Host "  Varsayılan`n" -ForegroundColor Yellow
    }
    
    # Hızlı Başlatma
    $fastStartup = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -ErrorAction SilentlyContinue
    Write-Host "HIZLI BAŞLATMA:" -ForegroundColor Yellow
    if ($fastStartup.HiberbootEnabled -eq 0) {
        Write-Host "  Kapalı`n" -ForegroundColor Green
    }
    else {
        Write-Host "  Açık`n" -ForegroundColor Yellow
    }
    
    # Ağ Optimizasyonu
    $networkThrottle = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -ErrorAction SilentlyContinue
    Write-Host "AĞ KISITLAMASI:" -ForegroundColor Yellow
    if ($networkThrottle.NetworkThrottlingIndex -eq 0xffffffff) {
        Write-Host "  Kapalı (Optimize)`n" -ForegroundColor Green
    }
    else {
        Write-Host "  Varsayılan`n" -ForegroundColor Yellow
    }
    
    # Yedekler
    Write-Host "YEDEKLER:" -ForegroundColor Yellow
    $backups = Get-ChildItem -Path $script:BackupPath -Directory -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending
    if ($backups.Count -gt 0) {
        foreach ($backup in $backups) {
            Write-Host "  $($backup.Name) - $($backup.LastWriteTime)" -ForegroundColor White
        }
    }
    else {
        Write-Host "  Hiç yedek bulunamadı" -ForegroundColor Red
    }
    Write-Host ""
    
    Write-Host "============================================" -ForegroundColor Cyan
}