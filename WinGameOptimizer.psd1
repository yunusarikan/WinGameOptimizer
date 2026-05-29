@{
    RootModule        = 'WinGameOptimizer.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
    Author            = 'Topluluk Projesi'
    CompanyName       = 'WinGameOptimizer'
    Copyright         = '(c) 2025. MIT License.'
    Description       = 'Windows Oyun ve Performans Optimizer - Windowsu oyunlar için optimize eden, gecikmeyi düşüren, gereksiz uygulamaları kaldıran ve gizliliği artıran kapsamlı PowerShell modülü.'
    PowerShellVersion = '5.1'
    RequiredModules   = @()
    FunctionsToExport = @(
        'Invoke-WGOptimize',
        'Invoke-WGRestore',
        'Get-WGStatus',
        'New-WGBackup',
        'Optimize-WGEssential',
        'Optimize-WGPrivacy',
        'Optimize-WGUI',
        'Optimize-WGVisual',
        'Optimize-WGTaskbar',
        'Optimize-WGServices',
        'Optimize-WGPower',
        'Optimize-WGGPU',
        'Optimize-WGNetwork',
        'Optimize-WGGameMode',
        'Remove-WGBloatware',
        'Restore-WGDefaults',
        'Test-WGAdmin'
    )
    FileList          = @(
        'WinGameOptimizer.psm1',
        'WinGameOptimizer.psd1',
        'Private/Core.ps1',
        'Private/Tweaks-Essential.ps1',
        'Private/Tweaks-Privacy.ps1',
        'Private/Tweaks-UI.ps1',
        'Private/Tweaks-Visual.ps1',
        'Private/Tweaks-Taskbar.ps1',
        'Private/Tweaks-Services.ps1',
        'Private/Tweaks-Power.ps1',
        'Private/Tweaks-GPU.ps1',
        'Private/Tweaks-Network.ps1',
        'Private/Tweaks-GameMode.ps1',
        'Private/Tweaks-Bloatware.ps1',
        'Public/Invoke-WGOptimize.ps1',
        'Public/Invoke-WGRestore.ps1',
        'Public/Get-WGStatus.ps1',
        'Public/New-WGBackup.ps1',
        'Data/Tweaks.json'
    )
    PrivateData       = @{
        PSData = @{
            Tags         = @('Windows', 'Optimization', 'Gaming', 'Performance', 'Latency', 'Debloat', 'Privacy')
            LicenseUri   = 'https://github.com/kullaniciadi/WinGameOptimizer/blob/main/LICENSE'
            ProjectUri   = 'https://github.com/kullaniciadi/WinGameOptimizer'
        }
    }
}