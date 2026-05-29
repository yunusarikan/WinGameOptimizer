function Optimize-WGTaskbar {
    <#
    .SYNOPSIS
        Görev çubuğu ve başlat menüsü optimizasyonlarını uygular.
    .DESCRIPTION
        Bing araması, sohbet simgesi, Teams, görev çubuğu hizalama
        ve son kullanılanlar özelliklerini yapılandırır.
    #>
    
    Write-Host "`n===== GÖREV ÇUBUĞU VE BAŞLAT MENÜSÜ OPTİMİZASYONLARI =====" -ForegroundColor Cyan
    
    # Başlat Menüsünde Bing Aramasını Kapat
    Write-Host "Bing araması kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Value 1
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWeb" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowSearchToUseLocation" -Value 0
    
    # Sohbet Simgesini Kapat
    Write-Host "Sohbet simgesi kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0
    
    # Teams'i Kapat
    Write-Host "Teams kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" -Name "ChatIcon" -Value 3
    
    # Görev Çubuğunda Ara Simgesini Gizle
    Write-Host "Ara simgesi gizleniyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 1
    
    # Görev Görünümü Düğmesini Gizle
    Write-Host "Görev görünümü gizleniyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0
    
    # Haberler ve İlgi Alanlarını Kapat
    Write-Host "Haberler ve ilgi alanları kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2
    
    # Başlat Menüsünde Son Kullanılanları Kapat
    Write-Host "Son kullanılanlar kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Value 1
    
    # Başlat menüsü önerilerini kapat
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 0
    
    # Görev çubuğu bildirim alanı
    Write-Host "Bildirim alanı temizleniyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0
    
    # Görev çubuğu kişileri
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0
    
    # Dokunmatik klavye simgesi
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 0
    
    # Windows Ink Çalışma Alanı
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Value 0
    
    Write-Host "Görev çubuğu ve başlat menüsü optimizasyonları tamamlandı." -ForegroundColor Green
}