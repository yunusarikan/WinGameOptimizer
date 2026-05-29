function Optimize-WGEssential {
    <#
    .SYNOPSIS
        Temel optimizasyonları uygular.
    .DESCRIPTION
        Telemetri, reklam kimliği, WiFi Sense, aktivite geçmişi,
        Cortana, Copilot, Recall, Widget ve yapışkan tuşları kapatır.
    #>
    
    Write-Host "`n===== TEMEL OPTIMIZASYONLAR =====" -ForegroundColor Cyan
    
    # Telemetriyi Kapat
    Write-Host "Telemetri kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0
    Stop-WGService -ServiceName "DiagTrack"
    Stop-WGService -ServiceName "dmwappushservice"
    
    # Reklam Kimliğini Kapat
    Write-Host "Reklam kimliği kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Value 1
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0
    
    # WiFi Sense'i Kapat
    Write-Host "WiFi Sense kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "value" -Value 0
    Set-WGRegistry -Path "HKLM:\Software\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Value 0
    
    # Etkinlik Geçmişini Kapat
    Write-Host "Etkinlik geçmişi kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0
    
    # Cihazımı Bul'u Kapat
    Write-Host "Cihazımı Bul kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\FindMyDevice" -Name "AllowFindMyDevice" -Value 0
    
    # Cortana'yı Kapat
    Write-Host "Cortana kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortanaAboveLock" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowSearchToUseLocation" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWeb" -Value 0
    
    # Copilot'u Kapat
    Write-Host "Copilot kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1
    
    # Recall'ı Kapat
    Write-Host "Recall kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" -Name "AllowRecall" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsAI" -Name "AllowRecall" -Value 0
    
    # Widget'ları Kapat
    Write-Host "Widget'lar kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0
    
    # Tüketici Özelliklerini Kapat
    Write-Host "Tüketici özellikleri kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableSoftLanding" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightFeatures" -Value 1
    
    # Kilit Ekranı Önerilerini Kapat
    Write-Host "Kilit ekranı önerileri kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightFeatures" -Value 1
    Set-WGRegistry -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableThirdPartySuggestions" -Value 1
    Set-WGRegistry -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Value 1
    
    # Yapışkan Tuşları Kapat
    Write-Host "Yapışkan tuşlar kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "506" -Type "String"
    Set-WGRegistry -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value "58" -Type "String"
    Set-WGRegistry -Path "HKCU:\Control Panel\Accessibility\FilterKeys" -Name "Flags" -Value "122" -Type "String"
    
    Write-Host "Temel optimizasyonlar tamamlandı." -ForegroundColor Green
}