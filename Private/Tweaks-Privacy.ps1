function Optimize-WGPrivacy {
    <#
    .SYNOPSIS
        Gizlilik ve izleyici karşıtı optimizasyonları uygular.
    .DESCRIPTION
        Konum izleme, arka plan uygulamaları, bildirimler,
        deneyim paylaşımı ve dil listesi erişimini kapatır.
    #>
    
    Write-Host "`n===== GİZLİLİK OPTİMİZASYONLARI =====" -ForegroundColor Cyan
    
    # Konum İzlemeyi Tamamen Kapat
    Write-Host "Konum izleme kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocationScripting" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Type "String"
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Deny" -Type "String"
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Deny" -Type "String"
    
    # Arka Plan Uygulamalarını Kapat
    Write-Host "Arka plan uygulamaları kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -Value 2
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BackgroundAppGlobalToggle" -Value 0
    
    # Bildirimleri Tamamen Kapat
    Write-Host "Bildirimler kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_CRITICAL" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_SUPRESS_TOASTS" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value 0
    
    # Deneyim Paylaşımını Kapat
    Write-Host "Deneyim paylaşımı kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0
    
    # Dil Listesi Erişimini Kapat
    Write-Host "Dil listesi erişimi kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Value 1
    
    # El Yazısı Paylaşımını Kapat
    Write-Host "El yazısı paylaşımı kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1
    
    # Kişiselleştirilmiş Reklamları Kapat
    Write-Host "Kişiselleştirilmiş reklamlar kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "LetAppsGetDiagnosticInfo" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0
    
    # Erişim kolaylığı verilerini kapat
    Write-Host "Erişim kolaylığı veri paylaşımı kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Accessibility" -Name "Configuration" -Value "" -Type "String"
    
    # Windows Defender telemetri kapat
    Write-Host "Defender telemetrisi kapatılıyor..." -ForegroundColor Yellow
    Stop-WGService -ServiceName "Wecsvc"
    Stop-WGService -ServiceName "WerSvc"
    Stop-WGService -ServiceName "WMPNetworkSvc"
    
    # Hata raporlamayı kapat
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1
    
    # Müşteri deneyimi iyileştirme programını kapat
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Value 0
    
    # Envanter toplayıcıyı kapat
    Stop-WGService -ServiceName "InventorySvc"
    
    # Telefon aramalarını kapat
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "AllowCrossDeviceClipboard" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableCdp" -Value 0
    
    Write-Host "Gizlilik optimizasyonları tamamlandı." -ForegroundColor Green
}