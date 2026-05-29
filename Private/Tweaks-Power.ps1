function Optimize-WGPower {
    <#
    .SYNOPSIS
        Güç planı ve CPU optimizasyonlarını uygular.
    .DESCRIPTION
        Yüksek/Ultimate performans güç planı, çekirdek park etme
        devre dışı bırakma ve PCI Express güç yönetimi.
    #>
    
    Write-Host "`n===== GÜÇ PLANI OPTİMİZASYONLARI =====" -ForegroundColor Cyan
    
    # Ultimate Performance Güç Planını Etkinleştir
    Write-Host "Ultimate Performance güç planı etkinleştiriliyor..." -ForegroundColor Yellow
    try {
        $ultimatePlan = powercfg /list | Select-String "Ultimate Performance"
        if (-not $ultimatePlan) {
            Invoke-WGCommand -Command "powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61"
        }
        Invoke-WGCommand -Command "powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61"
    }
    catch {
        # Ultimate yoksa Yüksek Performans'a geç
        Write-Host "Ultimate Performance bulunamadı, Yüksek Performans'a geçiliyor..." -ForegroundColor Yellow
        Invoke-WGCommand -Command "powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
    }
    
    # Çekirdek Park Etmeyi Devre Dışı Bırak
    Write-Host "Çekirdek park etme devre dışı bırakılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" -Name "Attributes" -Value 0
    
    # PCI Express Güç Yönetimini Kapat
    Write-Host "PCI Express güç yönetimi kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\501a4d13-42af-4429-9fd1-a8218c268e20\ee12f906-d277-404b-b6da-e5fa1a576df5" -Name "Attributes" -Value 2
    
    # İşlemci performans artış modu
    Write-Host "İşlemci performans modu ayarlanıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" -Name "Attributes" -Value 2
    
    # İşlemci performans çekirdek park etme minimum çekirdek sayısı
    powercfg /setacvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100
    powercfg /setdcvalueindex scheme_current sub_processor 0cc5b647-c1df-4637-891a-dec35c318583 100
    
    # İşlemci frekansı maksimumda tut
    powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMAX 100
    powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 100
    
    # Aktif güç planını uygula
    powercfg /setactive scheme_current
    
    # Depolama algısını kapat
    Write-Host "Depolama algısı kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Value 0
    
    # USB seçici askıya alma
    Write-Host "USB askıya alma kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\48e6b7a6-50f5-4782-a5d4-53bb8f07e226" -Name "Attributes" -Value 2
    
    # Ekran zaman aşımı (performans modunda uzun tut)
    powercfg /change monitor-timeout-ac 0
    powercfg /change standby-timeout-ac 0
    
    Write-Host "Güç planı optimizasyonları tamamlandı." -ForegroundColor Green
}