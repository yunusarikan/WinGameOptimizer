function Optimize-WGServices {
    <#
    .SYNOPSIS
        Gereksiz Windows servislerini devre dışı bırakır.
    .DESCRIPTION
        GameDVR, SysMain, Windows Search, yazdırma biriktiricisi,
        BitLocker, Ev Grubu, hazırda bekletme ve hızlı başlatmayı kapatır.
    #>
    
    Write-Host "`n===== SERVİS OPTİMİZASYONLARI =====" -ForegroundColor Cyan
    
    # GameDVR ve Game Bar'ı Kapat
    Write-Host "GameDVR ve Game Bar kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value 0
    
    Stop-WGService -ServiceName "XblAuthManager"
    Stop-WGService -ServiceName "XblGameSave"
    Stop-WGService -ServiceName "XboxNetApiSvc"
    Stop-WGService -ServiceName "XboxGipSvc"
    
    # Xbox ile ilgili tüm servisler
    $xboxServices = @(
        "XboxGipSvc",
        "XblAuthManager",
        "XblGameSave",
        "XboxNetApiSvc",
        "XboxGipSvc"
    )
    foreach ($svc in $xboxServices) {
        Stop-WGService -ServiceName $svc
    }
    
    # SysMain (Superfetch) Kapat
    Write-Host "SysMain kapatılıyor..." -ForegroundColor Yellow
    Stop-WGService -ServiceName "SysMain"
    
    # Windows Search Kapat
    Write-Host "Windows Search kapatılıyor..." -ForegroundColor Yellow
    Stop-WGService -ServiceName "WSearch"
    
    # Yazdırma Biriktiricisini Kapat
    Write-Host "Yazdırma biriktiricisi kapatılıyor..." -ForegroundColor Yellow
    Stop-WGService -ServiceName "Spooler"
    
    # BitLocker Servisini Kapat
    Write-Host "BitLocker servisi kapatılıyor..." -ForegroundColor Yellow
    Stop-WGService -ServiceName "BDESVC"
    
    # Ev Grubu Servislerini Kapat
    Write-Host "Ev grubu servisleri kapatılıyor..." -ForegroundColor Yellow
    Stop-WGService -ServiceName "HomeGroupListener"
    Stop-WGService -ServiceName "HomeGroupProvider"
    
    # Faks servisi
    Write-Host "Faks servisi kapatılıyor..." -ForegroundColor Yellow
    Stop-WGService -ServiceName "Fax"
    
    # Hyper-V (isteğe bağlı)
    $hyperVServices = @(
        "vmcompute",
        "vmms",
        "HvHost",
        "VMAgent",
        "VMWare"
    )
    foreach ($svc in $hyperVServices) {
        Stop-WGService -ServiceName $svc
    }
    
    # Bluetooth (masaüstü için)
    Write-Host "Bluetooth servisleri kontrol ediliyor..." -ForegroundColor Yellow
    Stop-WGService -ServiceName "BluetoothUserService"
    Stop-WGService -ServiceName "BthAvctpSvc"
    
    # Windows Update'i bildir moduna al (tamamen kapatma)
    Write-Host "Windows Update ayarlanıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Value 2
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 0
    
    # Diğer gereksiz servisler
    $extraServices = @(
        "MapsBroker",
        "lfsvc",
        "PcaSvc",
        "PhoneSvc",
        "MessagingService",
        "WpcMonSvc",
        "WwanSvc",
        "SensorService",
        "SensrSvc",
        "SensorDataService",
        "DusmSvc",
        "WbioSrvc",
        "TabletInputService",
        "wisvc",
        "RetailDemo",
        "RemoteRegistry",
        "RemoteAccess",
        "shpamsvc",
        "SCPolicySvc",
        "ScDeviceEnum"
    )
    foreach ($svc in $extraServices) {
        Stop-WGService -ServiceName $svc
    }
    
    # Hazırda Bekletmeyi Kapat
    Write-Host "Hazırda bekletme kapatılıyor..." -ForegroundColor Yellow
    Invoke-WGCommand -Command "powercfg /hibernate off"
    
    # Hızlı Başlatmayı Kapat
    Write-Host "Hızlı başlatma kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0
    
    Write-Host "Servis optimizasyonları tamamlandı." -ForegroundColor Green
}