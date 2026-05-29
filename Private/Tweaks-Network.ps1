function Optimize-WGNetwork {
    <#
    .SYNOPSIS
        Ağ ve internet optimizasyonlarını uygular.
    .DESCRIPTION
        Ağ kısıtlaması, sistem duyarlılığı, Nagle algoritması,
        TCP ACK sıklığı, RSS, TCP Chimney, IPv6 ve DNS ayarları.
    #>
    
    Write-Host "`n===== AĞ OPTİMİZASYONLARI =====" -ForegroundColor Cyan
    
    # Ağ Kısıtlamasını Devre Dışı Bırak
    Write-Host "Ağ kısıtlaması kaldırılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value ([int]"0xffffffff")
    
    # Sistem Duyarlılığını Oyun İçin Ayarla
    Write-Host "Sistem duyarlılığı ayarlanıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0
    
    # Nagle Algoritmasını Kapat (TCPNoDelay)
    Write-Host "Nagle algoritması kapatılıyor..." -ForegroundColor Yellow
    $interfaces = Get-NetAdapter -Physical | Where-Object { $_.Status -eq 'Up' }
    foreach ($adapter in $interfaces) {
        $adapterKey = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}" -ErrorAction SilentlyContinue | 
            Where-Object { $_.Property -contains 'NetCfgInstanceId' -and (Get-ItemProperty -Path $_.PSPath -Name 'NetCfgInstanceId' -ErrorAction SilentlyContinue).NetCfgInstanceId -eq $adapter.InterfaceGuid }
        
        if ($adapterKey) {
            $regPath = $adapterKey.PSPath
            Set-WGRegistry -Path $regPath -Name "TCPNoDelay" -Value 1
        }
    }
    
    # TCP ACK Sıklığını 1 Yap
    Write-Host "TCP ACK sıklığı ayarlanıyor..." -ForegroundColor Yellow
    foreach ($adapter in $interfaces) {
        $tcpipPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$($adapter.InterfaceGuid)"
        if (Test-Path $tcpipPath) {
            Set-WGRegistry -Path $tcpipPath -Name "TCPAckFrequency" -Value 1
            Set-WGRegistry -Path $tcpipPath -Name "TCPNoDelay" -Value 1
            Set-WGRegistry -Path $tcpipPath -Name "TcpDelAckTicks" -Value 0
        }
    }
    
    # Receive Side Scaling Aç
    Write-Host "Receive Side Scaling etkinleştiriliyor..." -ForegroundColor Yellow
    Invoke-WGCommand -Command "netsh int tcp set global rss=enabled"
    
    # TCP Chimney Offload Aç
    Write-Host "TCP Chimney etkinleştiriliyor..." -ForegroundColor Yellow
    Invoke-WGCommand -Command "netsh int tcp set global chimney=enabled"
    
    # Auto-tuning seviyesi
    Write-Host "TCP auto-tuning ayarlanıyor..." -ForegroundColor Yellow
    Invoke-WGCommand -Command "netsh int tcp set global autotuninglevel=normal"
    
    # Congestion provider
    Invoke-WGCommand -Command "netsh int tcp set global congestionprovider=ctcp"
    
    # ECN Capability
    Invoke-WGCommand -Command "netsh int tcp set global ecncapability=enabled"
    
    # Timestamps
    Invoke-WGCommand -Command "netsh int tcp set global timestamps=disabled"
    
    # Initial RTO
    Invoke-WGCommand -Command "netsh int tcp set global initialRto=2000"
    
    # IPv6'yı Devre Dışı Bırak (Opsiyonel)
    Write-Host "IPv6 kontrol ediliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -Value ([int]"0xFFFFFFFF")
    
    # DNS'i Cloudflare Yap
    Write-Host "DNS ayarları yapılandırılıyor..." -ForegroundColor Yellow
    $adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }
    foreach ($adapter in $adapters) {
        try {
            Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses ("1.1.1.1", "1.0.0.1")
        }
        catch {
            Write-Host "  [-] DNS ayarlanamadı: $($adapter.Name)" -ForegroundColor Yellow
        }
    }
    
    # NetBIOS'u kapat
    Write-Host "NetBIOS kapatılıyor..." -ForegroundColor Yellow
    foreach ($adapter in $adapters) {
        $adapterKey = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces\Tcpip_$($adapter.InterfaceGuid)"
        Set-WGRegistry -Path $adapterKey -Name "NetbiosOptions" -Value 2
    }
    
    # DNS önbellek optimizasyonu
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "MaxCacheTtl" -Value 86400
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "MaxNegativeCacheTtl" -Value 0
    
    # QoS (Quality of Service) kapat
    Write-Host "QoS ayarları yapılandırılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Name "NonBestEffortLimit" -Value 0
    
    # Windows Update P2P paylaşımı
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Value 0
    
    Write-Host "Ağ optimizasyonları tamamlandı." -ForegroundColor Green
}