function Invoke-WGOptimize {
    <#
    .SYNOPSIS
        Tüm oyun ve performans optimizasyonlarını uygular.
    .DESCRIPTION
        Windows'u oyunlar için optimize eder, gereksiz servisleri kapatır,
        görsel efektleri azaltır, ağ ayarlarını iyileştirir ve
        UWP şişkinliklerini temizler.
    .PARAMETER Profile
        Optimizasyon profili: "Gaming" (tümü), "Essential" (temel), "Privacy" (gizlilik).
    .PARAMETER WhatIf
        Değişiklik yapmadan nelerin uygulanacağını gösterir.
    .EXAMPLE
        Invoke-WGOptimize -Profile "Gaming"
    .EXAMPLE
        Invoke-WGOptimize -Profile "Essential"
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [ValidateSet("Gaming", "Essential", "Privacy", "Performance")]
        [string]$Profile = "Gaming",
        
        [switch]$WhatIf
    )
    
    # Yönetici kontrolü
    if (-not (Test-WGAdmin)) {
        Write-Host "HATA: Bu script yönetici yetkisi gerektirir!" -ForegroundColor Red
        Write-Host "PowerShell'i Yönetici olarak çalıştırın." -ForegroundColor Yellow
        return
    }
    
    Write-Host @"
============================================
  Windows Oyun ve Performans Optimizer
  v1.0.0
============================================
"@ -ForegroundColor Cyan
    
    Write-Host "Profil: $Profile" -ForegroundColor Magenta
    Write-Host ""
    
    if ($WhatIf) {
        Write-Host "WHATIF MODU: Hiçbir değişiklik yapılmayacak." -ForegroundColor Yellow
        return
    }
    
    # Yedek oluştur
    Write-Host "Önce yedek oluşturuluyor..." -ForegroundColor Yellow
    $backupDir = New-WGBackup
    
    Write-Host ""
    Write-Host "Optimizasyon başlıyor...`n" -ForegroundColor Green
    
    $startTime = Get-Date
    
    try {
        switch ($Profile) {
            "Gaming" {
                # Tüm optimizasyonlar
                Optimize-WGEssential
                Optimize-WGPrivacy
                Optimize-WGUI
                Optimize-WGVisual
                Optimize-WGTaskbar
                Optimize-WGServices
                Optimize-WGPower
                Optimize-WGGPU
                Optimize-WGNetwork
                Optimize-WGGameMode
                Remove-WGBloatware
            }
            "Essential" {
                # Sadece temel optimizasyonlar
                Optimize-WGEssential
                Optimize-WGServices
                Optimize-WGPower
            }
            "Privacy" {
                # Gizlilik odaklı
                Optimize-WGEssential
                Optimize-WGPrivacy
                Remove-WGBloatware
            }
            "Performance" {
                # Performans odaklı
                Optimize-WGVisual
                Optimize-WGServices
                Optimize-WGPower
                Optimize-WGGPU
                Optimize-WGNetwork
                Optimize-WGGameMode
            }
        }
    }
    catch {
        Write-Host "`nOptimizasyon sırasında hata oluştu: $_" -ForegroundColor Red
        Write-Host "Yedekleriniz şurada: $backupDir" -ForegroundColor Yellow
        Write-Host "Geri almak için: Invoke-WGRestore" -ForegroundColor Yellow
        return
    }
    
    $endTime = Get-Date
    $duration = $endTime - $startTime
    
    Write-Host "`n============================================" -ForegroundColor Green
    Write-Host "  OPTİMİZASYON TAMAMLANDI!" -ForegroundColor Green
    Write-Host "============================================`n" -ForegroundColor Green
    Write-Host "Süre: $($duration.TotalSeconds) saniye" -ForegroundColor Cyan
    Write-Host "Yedek klasörü: $backupDir" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "ÖNERİLEN: Değişikliklerin tam etkisi için bilgisayarı yeniden başlatın." -ForegroundColor Yellow
    Write-Host "Geri almak için: Invoke-WGRestore" -ForegroundColor Yellow
}