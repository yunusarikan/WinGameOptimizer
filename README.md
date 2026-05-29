# 🎮 WinGameOptimizer

<p align="center">
  <img src="https://img.shields.io/badge/Windows-10%2F11-blue?style=for-the-badge&logo=windows" alt="Windows">
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-blue?style=for-the-badge&logo=powershell" alt="PowerShell">
  <img src="https://img.shields.io/badge/Lisans-MIT-green?style=for-the-badge" alt="Lisans">
  <img src="https://img.shields.io/badge/Sürüm-1.0.0-orange?style=for-the-badge" alt="Sürüm">
</p>

<p align="center">
  <b>Windows'u oyunlar için optimize eden, gecikmeyi düşüren, performansı artıran,<br>
  gereksiz uygulamaları kaldıran ve gizliliği iyileştiren kapsamlı bir araç.</b>
</p>

---

## 📖 İçindekiler

- [Ne İşe Yarar?](#-ne-işe-yarar)
- [Özellikler](#-özellikler)
- [Gereksinimler](#-gereksinimler)
- [Hızlı Başlangıç](#-hızlı-başlangıç)
- [Kullanım Yöntemleri](#-kullanım-yöntemleri)
  - [Yöntem 1: GUI ile Kullanım (Önerilen)](#yöntem-1-gui-ile-kullanım-önerilen)
  - [Yöntem 2: Komut Satırı ile Kullanım](#yöntem-2-komut-satırı-ile-kullanım)
  - [Yöntem 3: Tek Kategoriler](#yöntem-3-tek-kategoriler)
- [Profiller](#-profiller)
- [Kategoriler Detaylı](#-kategoriler-detaylı)
- [Geri Alma (Restore)](#-geri-alma-restore)
- [Sık Sorulan Sorular](#-sık-sorulan-sorular)
- [Uyarılar](#-uyarılar)
- [Dosya Yapısı](#-dosya-yapısı)
- [Katkıda Bulunma](#-katkıda-bulunma)
- [Lisans](#-lisans)

---

## ❓ Ne İşe Yarar?

WinGameOptimizer, Windows işletim sisteminde oyun oynarken karşılaşılan şu sorunları çözmek için tasarlanmıştır:

| Sorun | Çözüm |
|-------|-------|
| 🐌 Yüksek gecikme (input lag) | GPU zamanlaması, timer optimizasyonu, tam ekran iyileştirmeleri |
| 📉 Düşük FPS | Görsel efektleri kapatma, güç planı optimizasyonu, servis temizliği |
| 📡 Yüksek ping | Nagle algoritması, TCP ACK, DNS, ağ kısıtlaması kaldırma |
| 👁️ Gizlilik ihlalleri | Telemetri, reklam kimliği, konum, Cortana, Recall kapatma |
| 💾 Gereksiz kaynak tüketimi | UWP bloatware, OneDrive, Xbox uygulamalarını kaldırma |
| 🔄 Arka plan şişkinliği | Gereksiz servisleri, arka plan uygulamalarını durdurma |

---

## ✨ Özellikler

### 🧹 Temizlik & Gizlilik (Debloat + Privacy)
- Windows telemetrisini tamamen kapatır (DiagTrack, dmwappushservice)
- Reklam kimliğini sıfırlar ve devre dışı bırakır
- Konum, mikrofon, kamera izlemini durdurur
- WiFi Sense şifre paylaşımını kapatır
- Etkinlik geçmişini temizler
- Cortana, Copilot, Recall ve Widget'ları kapatır
- Arka plan uygulamalarını tamamen devre dışı bırakır
- Bildirimleri ve rahatsız edici uyarıları susturur
- Kilit ekranı önerilerini ve Windows Spotlight'ı kapatır
- Deneyim paylaşımını (Tailored Experiences) engeller
- Dil listesi ve el yazısı veri toplamayı durdurur

### ⚡ Performans Artışı (Performance)
- **Ultimate Performance** güç planını etkinleştirir
- CPU çekirdek park etmeyi (Core Parking) devre dışı bırakır
- PCI Express güç yönetimini kapatır
- Tüm görsel efektleri **"En İyi Performans"** moduna alır
- Saydamlık ve animasyonları kapatır
- SysMain (Superfetch) ve Windows Search servislerini durdurur
- Hazırda bekletme (Hibernate) ve hızlı başlatmayı kapatır
- Yapışkan tuşlar, Snap Assist gibi rahatsız edici özellikleri kapatır
- Görev çubuğu animasyonlarını ve haber akışını kapatır

### 🔻 Gecikme Azaltma (Latency)
- **Donanım Hızlandırmalı GPU Zamanlaması**nı açar
- **MSI Mode** (GPU kesme optimizasyonu) - İleri seviye
- Tam ekran iyileştirmelerini devre dışı bırakır (input lag ↓)
- **Nagle Algoritması**nı kapatır (TCPNoDelay) - Küçük paket gecikmesi ↓
- **TCP ACK Sıklığı**nı 1 yapar - Onay paketleri anında gönderilir
- Ağ kısıtlamasını (NetworkThrottlingIndex) `ffffffff` yapar
- Sistem duyarlılığını (SystemResponsiveness) `0` yapar
- **Receive Side Scaling (RSS)** ve **TCP Chimney Offload** açar
- **Zamanlayıcı çözünürlüğünü** 1ms'ye çeker
- HPET yönetimi (isteğe bağlı, ileri seviye)
- MMCSS (Multimedia Class Scheduler) oyun profilini yapılandırır

### 🗑️ Şişkinlik Temizliği (Bloatware Removal)
- **Xbox** uygulamalarının tamamını kaldırır
- **OneDrive**'ı tamamen siler (dosyalar dahil)
- **Cortana** ve **Copilot**'u pasifize eder
- Gereksiz UWP uygulamalarını kaldırır:
  - 3D Builder, Bing uygulamaları, Office Hub
  - Solitaire, Skype, OneNote, Haritalar
  - Zune Müzik/Video, Paint 3D, Mixed Reality
  - Telefon, Kişiler, Fotoğraflar, Takvim, Posta
  - Ve daha fazlası...
- Candy Crush ve otomatik önerilen uygulamaları engeller
- Microsoft Store otomatik güncellemelerini kapatır

### 🖥️ Arayüz İyileştirmeleri (UI)
- **Klasik sağ tık menüsü**ne dönüş (Windows 11)
- Dosya Gezginini **Bu Bilgisayar**'a açar
- Gizli dosyaları ve uzantıları gösterir
- 3B Nesneler, Müzik, Resimler klasörlerini gizler
- Görev çubuğuna **"Görevi Sonlandır"** seçeneği ekler
- Bing aramasını başlat menüsünden kaldırır
- Uzun dosya yollarını etkinleştirir (260 karakter sınırı ↑)

---

## 📋 Gereksinimler

| Gereksinim | Detay |
|------------|-------|
| **İşletim Sistemi** | Windows 10 (sürüm 2004 ve üzeri) veya Windows 11 |
| **PowerShell** | 5.1 veya üzeri (Windows 10/11 ile varsayılan gelir) |
| **Yetki** | **Yönetici (Administrator)** - Zorunlu! |
| **İnternet** | Sadece GitHub'dan indirmek için (opsiyonel) |
| **Disk Alanı** | ~5 MB (yedekler için) |

---

## 🚀 Hızlı Başlangıç

### Adım 1: İndir

```powershell
# GitHub'dan klonla
git clone https://github.com/yunusarikan/WinGameOptimizer.git

# VEYA ZIP olarak indir:
# https://github.com/yunusarikan/WinGameOptimizer/archive/refs/heads/main.zip

Adım 2: Klasöre Git
cd WinGameOptimizer

Adım 3: Çalıştır
powershell -ExecutionPolicy Bypass -File "WinGameOptimizerGUI.ps1"

📂 Kategoriler

#	Kategori	Fonksiyon	            Değişiklik Sayısı	Risk
1	Temel	    Optimize-WGEssential	25+ registry, 2 servis	🟢 Düşük
2	Gizlilik	Optimize-WGPrivacy	    20+ registry, 3 servis	🟢 Düşük
3	Arayüz	    Optimize-WGUI	        15+ registry	    🟢 Düşük
4	Görsel	    Optimize-WGVisual	    12+ registry	    🟢 Düşük
5 Görev Çubuğu  Optimize-WGTaskbar	    10+ registry	    🟢 Düşük
6	Servisler	Optimize-WGServices	    25+ servis	        🟡 Orta
7	Güç Planı	Optimize-WGPower	    8+ registry, powercfg	🟡 Orta
8	GPU	        Optimize-WGGPU	        10+ registry	    🟡 Orta
9	Ağ	        Optimize-WGNetwork	    15+ registry, netsh	🟡 Orta
10	Oyun Modu	Optimize-WGGameMode	    8+ registry, timer	🔴 İleri
11	Bloatware	Remove-WGBloatware	    30+ uygulama	    🟡 Orta

🔄 Geri Alma

GUI ile:
GERİ AL butonuna tıklayın.

Komut satırı ile:
Invoke-WGRestore

Invoke-WGRestore -BackupPath "C:\...\WinGameOptimizer\Backup\WinGameOptimizer_Backup_20250101_120000"
Manuel geri alma:
Get-WGStatus

Get-ChildItem ".\Backup"
Yedeklenenler:

Registry anahtarları (HKCU, HKLM ilgili bölümler)
Servis başlangıç durumları
Sistem geri yükleme noktası



🤝 Katkıda Bulunma
Projeye katkıda bulunmak isterseniz:
1.Fork yapın
2.Yeni bir branch oluşturun (git checkout -b feature/yeni-ozellik)
3.Değişikliklerinizi commit edin (git commit -m 'Yeni özellik eklendi')
4.Push yapın (git push origin feature/yeni-ozellik)
5.Pull Request açın

İstek/öneri için: Issues sekmesini kullanın.