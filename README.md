# 🎮 WinGameOptimizer

Windows işletim sistemini oyunlar için optimize eden, gecikmeyi düşüren, performansı artıran, gereksiz uygulamaları kaldıran ve gizliliği iyileştiren kapsamlı bir PowerShell modülü.

## ⚡ Özellikler

### Temizlik & Gizlilik
- Windows telemetrisini tamamen kapatır
- Reklam kimliğini ve kişiselleştirilmiş reklamları engeller
- Konum, mikrofon, kamera izlemini durdurur
- Arka plan uygulamalarını devre dışı bırakır
- Cortana, Copilot, Recall ve Widget'ları kapatır

### Performans Artışı
- Ultimate Performance güç planını etkinleştirir
- CPU çekirdek park etmeyi devre dışı bırakır
- Tüm görsel efektleri en iyi performansa ayarlar
- Gereksiz Windows servislerini kapatır
- Oyun modunu optimize eder

### Gecikme Azaltma
- GPU donanım hızlandırmalı zamanlamayı açar
- Tam ekran iyileştirmelerini devre dışı bırakır
- Nagle algoritmasını kapatır (TCPNoDelay)
- Ağ kısıtlamasını kaldırır
- Zamanlayıcı çözünürlüğünü artırır

### Şişkinlik Temizliği
- Xbox uygulamalarını kaldırır
- OneDrive'ı tamamen siler
- Gereksiz UWP uygulamalarını temizler
- Candy Crush ve önerilen uygulamaları engeller

## 🚀 Kurulum

```powershell
# Repoyu klonla
git clone https://github.com/kullaniciadi/WinGameOptimizer.git

# Modülü içe aktar
Import-Module "WinGameOptimizer\WinGameOptimizer.psd1"