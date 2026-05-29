function Optimize-WGVisual {
    <#
    .SYNOPSIS
        Görsel efekt ve animasyon optimizasyonlarını uygular.
    .DESCRIPTION
        Tüm görsel efektleri en iyi performansa ayarlar, saydamlık,
        animasyonlar, yapış yardımcısı ve bildirim efektlerini kapatır.
    #>
    
    Write-Host "`n===== GÖRSEL PERFORMANS OPTİMİZASYONLARI =====" -ForegroundColor Cyan
    
    # Görsel Efektleri En İyi Performansa Ayarla
    Write-Host "Görsel efektler optimize ediliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2
    Set-WGRegistry -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0" -Type "String"
    
    # UserPreferencesMask - Tüm animasyonları kapat
    $binaryValue = [byte[]]@(144, 18, 3, 128, 16, 0, 0, 0)
    Set-WGRegistry -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value $binaryValue -Type "Binary"
    
    # Saydamlık Efektlerini Kapat
    Write-Host "Saydamlık efektleri kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0
    
    # Görev Çubuğu Animasyonlarını Kapat
    Write-Host "Görev çubuğu animasyonları kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value 0
    
    # Yapış Yardımcısını Kapat
    Write-Host "Yapış yardımcısı kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SnapFill" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "SnapAssist" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "JointResize" -Value 0
    
    # Bildirim Balon İpuçlarını Kapat
    Write-Host "Bildirim balonları kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableBalloonTips" -Value 0
    
    # Menü açılış animasyonlarını kapat
    Set-WGRegistry -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Type "String"
    
    # Pencere animasyonları
    Set-WGRegistry -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0" -Type "String"
    
    # Combo box animasyonu
    Set-WGRegistry -Path "HKCU:\Control Panel\Desktop" -Name "ComboBoxAnimation" -Value "0" -Type "String"
    
    # İmleç gölgesi
    Set-WGRegistry -Path "HKCU:\Control Panel\Cursors" -Name "CursorShadow" -Value 0
    
    # Masaüstü arka plan slayt gösterisi
    Set-WGRegistry -Path "HKCU:\Control Panel\Personalization\Desktop Slideshow" -Name "Interval" -Value "0" -Type "String"
    
    # Başlangıç animasyonu
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DelayedDesktopSwitchTimeout" -Value 0
    
    # Pencere içeriğini sürüklerken göster
    Set-WGRegistry -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Value "0" -Type "String"
    
    # Yazı tipi yumuşatma
    Set-WGRegistry -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothing" -Value "0" -Type "String"
    
    Write-Host "Görsel performans optimizasyonları tamamlandı." -ForegroundColor Green
}