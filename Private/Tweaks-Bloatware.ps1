function Remove-WGBloatware {
    <#
    .SYNOPSIS
        Gereksiz UWP uygulamalarını ve şişkinlikleri kaldırır.
    .DESCRIPTION
        Xbox uygulamaları, Microsoft bloatware'leri, OneDrive,
        Candy Crush ve önerilen uygulamaları kaldırır.
    #>
    
    Write-Host "`n===== UYGULAMA TEMİZLİĞİ =====" -ForegroundColor Cyan
    
    # Xbox Uygulamalarını Kaldır
    Write-Host "Xbox uygulamaları kaldırılıyor..." -ForegroundColor Yellow
    $xboxApps = @(
        "Microsoft.XboxApp",
        "Microsoft.XboxGameCallableUI",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.Xbox.TCUI",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxGameOverlay",
        "Microsoft.XboxGamingOverlay"
    )
    foreach ($app in $xboxApps) {
        Remove-WGUWPApp -PackageName $app
    }
    
    # Gereksiz Uygulamaları Kaldır
    Write-Host "Gereksiz uygulamalar kaldırılıyor..." -ForegroundColor Yellow
    $bloatwareApps = @(
        "Microsoft.3DBuilder",
        "Microsoft.BingFinance",
        "Microsoft.BingNews",
        "Microsoft.BingSports",
        "Microsoft.BingWeather",
        "Microsoft.Getstarted",
        "Microsoft.MicrosoftOfficeHub",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.Office.OneNote",
        "Microsoft.People",
        "Microsoft.SkypeApp",
        "Microsoft.WindowsAlarms",
        "Microsoft.WindowsCamera",
        "microsoft.windowscommunicationsapps",
        "Microsoft.WindowsMaps",
        "Microsoft.WindowsPhone",
        "Microsoft.WindowsSoundRecorder",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo",
        "Microsoft.Paint3D",
        "Microsoft.MixedReality.Portal",
        "Microsoft.Wallet",
        "Microsoft.YourPhone",
        "Microsoft.OneConnect",
        "Microsoft.MicrosoftStickyNotes",
        "Microsoft.MSPaint",
        "Microsoft.Windows.Photos",
        "Microsoft.WindowsCalculator",
        "Microsoft.WindowsFeedbackHub",
        "Microsoft.Microsoft3DViewer",
        "Microsoft.MixedReality.Portal",
        "Microsoft.ScreenSketch",
        "Microsoft.Whiteboard",
        "Microsoft.StorePurchaseApp",
        "Microsoft.WebMediaExtensions",
        "Microsoft.WebpImageExtension",
        "Microsoft.WinJS.2.0"
    )
    foreach ($app in $bloatwareApps) {
        Remove-WGUWPApp -PackageName $app
    }
    
    # OneDrive'ı Tamamen Kaldır
    Write-Host "OneDrive kaldırılıyor..." -ForegroundColor Yellow
    try {
        Stop-Process -Name OneDrive -Force -ErrorAction SilentlyContinue
        
        if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
            Start-Process "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait -NoNewWindow
        }
        if (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
            Start-Process "$env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait -NoNewWindow
        }
        
        Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1
        
        # OneDrive klasörünü sil
        Remove-Item "$env:USERPROFILE\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
        
        Write-Host "  [+] OneDrive başarıyla kaldırıldı" -ForegroundColor Green
    }
    catch {
        Write-Host "  [-] OneDrive kaldırma hatası: $_" -ForegroundColor Yellow
    }
    
    # Candy Crush ve Önerilen Uygulamaları Engelle
    Write-Host "Önerilen uygulamalar engelleniyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Value 0
    
    # Microsoft Store otomatik güncellemeleri kapat
    Write-Host "Store otomatik güncellemeleri kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "AutoDownload" -Value 2
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost" -Name "EnableWebContentEvaluation" -Value 0
    
    # Edge masaüstü kısayolunu kaldır
    Remove-Item "$env:PUBLIC\Desktop\Microsoft Edge.lnk" -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:USERPROFILE\Desktop\Microsoft Edge.lnk" -Force -ErrorAction SilentlyContinue
    
    Write-Host "Uygulama temizliği tamamlandı." -ForegroundColor Green
}