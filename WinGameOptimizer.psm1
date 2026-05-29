# WinGameOptimizer - Ana Modül
# Windows Oyun ve Performans Optimizer
# Lisans: MIT

$script:ModuleRoot = $PSScriptRoot
$script:BackupPath = Join-Path -Path $script:ModuleRoot -ChildPath 'Backup'
$script:DataPath = Join-Path -Path $script:ModuleRoot -ChildPath 'Data'
$script:ConfigPath = Join-Path -Path $script:DataPath -ChildPath 'Tweaks.json'

# Yedekleme klasörünü oluştur
if (-not (Test-Path $script:BackupPath)) {
    New-Item -Path $script:BackupPath -ItemType Directory -Force | Out-Null
}

# Tüm Private fonksiyonları yükle
Get-ChildItem -Path "$script:ModuleRoot\Private" -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}

# Tüm Public fonksiyonları yükle
Get-ChildItem -Path "$script:ModuleRoot\Public" -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}

# Modül yüklendiğinde çalışacak
$script:ModuleLoaded = $true

Write-Host "WinGameOptimizer v1.0.0 yüklendi." -ForegroundColor Green
Write-Host "Kullanım: Invoke-WGOptimize -Profile 'Gaming'" -ForegroundColor Cyan
Write-Host "Yardım: Get-Help Invoke-WGOptimize" -ForegroundColor Cyan