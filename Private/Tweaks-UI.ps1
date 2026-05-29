function Optimize-WGUI {
    <#
    .SYNOPSIS
        Kullanıcı arayüzü ve dosya gezgini iyileştirmelerini uygular.
    .DESCRIPTION
        Klasik sağ tık menüsü, dosya gezgini ayarları, gizli dosyalar,
        hızlı erişim, kilit ekranı, 3B nesneler ve galeri kaldırma.
    #>
    
    Write-Host "`n===== ARAYÜZ VE DOSYA GEZGİNİ İYİLEŞTİRMELERİ =====" -ForegroundColor Cyan
    
    # Klasik Sağ Tık Menüsü
    Write-Host "Klasik sağ tık menüsü ayarlanıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "" -Value "" -Type "String"
    
    # Dosya Gezginini Bu Bilgisayar'a Aç
    Write-Host "Dosya gezgini ayarlanıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1
    
    # Gizli Dosyaları Göster
    Write-Host "Gizli dosyalar gösteriliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
    
    # Dosya Uzantılarını Göster
    Write-Host "Dosya uzantıları gösteriliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
    
    # Süper gizli sistem dosyalarını göster
    Write-Host "Sistem dosyaları gösteriliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1
    
    # Boş sürücüleri gizleme
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideDrivesWithNoMedia" -Value 0
    
    # Hızlı Erişim Geçmişini Kapat
    Write-Host "Hızlı erişim geçmişi kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value 0
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0
    
    # Kilit Ekranını Kapat
    Write-Host "Kilit ekranı kapatılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1
    
    # Uzun Dosya Yollarını Etkinleştir
    Write-Host "Uzun dosya yolları etkinleştiriliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1
    
    # 3B Nesneler Klasörünü Gizle
    Write-Host "3B nesneler klasörü kaldırılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Name "" -Value "" -Type "Remove"
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Name "" -Value "" -Type "Remove"
    
    # Müzik, Resimler, Videolar klasörlerini Bu Bilgisayar'dan kaldır
    $foldersToRemove = @(
        "{1CF1260C-4DD0-4ebb-811F-33C572699FDE}",  # Müzik
        "{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}",  # Resimler
        "{A0953C92-50DC-43bf-BE83-3742FED03C9C}",  # Videolar
        "{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}",  # Belgeler
        "{374DE290-123F-4565-9164-39C4925E467B}",  # İndirilenler
        "{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}",  # Masaüstü
        "{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"   # 3B Nesneler
    )
    foreach ($folder in $foldersToRemove) {
        Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\$folder" -Name "" -Value "" -Type "Remove"
        Set-WGRegistry -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\$folder" -Name "" -Value "" -Type "Remove"
    }
    
    # Ana Sayfa Galerisini Kaldır
    Write-Host "Ana sayfa galerisi kaldırılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "HubMode" -Value 1
    
    # Görev Çubuğuna Görevi Sonlandır Ekle
    Write-Host "Görevi sonlandır özelliği ekleniyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "TaskbarSd" -Value 1
    
    # Ayrıntılı durum mesajları
    Write-Host "Ayrıntılı durum mesajları etkinleştiriliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value 1
    
    # Hızlı başlatma araç çubuğunu kapat
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0
    
    # OneDrive'ı Dosya Gezgini kenar çubuğundan kaldır
    Set-WGRegistry -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Name "System.IsPinnedToNameSpaceTree" -Value 0
    
    Write-Host "Arayüz iyileştirmeleri tamamlandı." -ForegroundColor Green
}