function Optimize-WGGameMode {
    <#
    .SYNOPSIS
        Oyun modu ve düşük gecikme optimizasyonlarını uygular.
    .DESCRIPTION
        Oyun modu, CPU önceliği, zamanlayıcı çözünürlüğü
        ve HPET yönetimi.
    #>
    
    Write-Host "`n===== OYUN MODU OPTİMİZASYONLARI =====" -ForegroundColor Cyan
    
    # Oyun Modunu Etkinleştir
    Write-Host "Oyun modu etkinleştiriliyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1
    Set-WGRegistry -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1
    
    # Oyun modu için ek ayarlar
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" -Name "ActivationType" -Value 0
    
    # Zamanlayıcı Çözünürlüğünü Artır
    Write-Host "Zamanlayıcı çözünürlüğü ayarlanıyor..." -ForegroundColor Yellow
    try {
        # NtSetTimerResolution API çağrısı
        $timerScript = @"
using System;
using System.Runtime.InteropServices;
public class TimerResolution {
    [DllImport("ntdll.dll", SetLastError = true)]
    private static extern int NtSetTimerResolution(int DesiredResolution, bool SetResolution, out int CurrentResolution);
    
    public static void SetMaximumResolution() {
        int currentRes;
        NtSetTimerResolution(5000, true, out currentRes);
    }
}
"@
        Add-Type -TypeDefinition $timerScript -ErrorAction SilentlyContinue
        [TimerResolution]::SetMaximumResolution()
        Write-Host "  [+] Zamanlayıcı çözünürlüğü maksimuma ayarlandı" -ForegroundColor Green
    }
    catch {
        Write-Host "  [-] Zamanlayıcı çözünürlüğü ayarlanamadı: $_" -ForegroundColor Yellow
    }
    
    # HPET Yönetimi (İleri Seviye)
    Write-Host "HPET durumu kontrol ediliyor..." -ForegroundColor Yellow
    try {
        $hpetStatus = bcdedit /enum | Select-String "useplatformclock"
        if ($hpetStatus) {
            Write-Host "  [!] HPET şu anda aktif. Devre dışı bırakmak için: bcdedit /deletevalue useplatformclock" -ForegroundColor Yellow
        }
        else {
            Write-Host "  [i] HPET zaten devre dışı veya ayarlı değil" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  [-] HPET kontrolü yapılamadı" -ForegroundColor Yellow
    }
    
    # MMCSS oyun profili
    Write-Host "MMCSS oyun profili yapılandırılıyor..." -ForegroundColor Yellow
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Affinity" -Value 0
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Background Only" -Value "False" -Type "String"
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Clock Rate" -Value 10000
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Value 8
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Latency Sensitive" -Value "True" -Type "String"
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Value 6
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Value "High" -Type "String"
    Set-WGRegistry -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "SFIO Priority" -Value "High" -Type "String"
    
    # Oyunlar için ek MMCSS görevleri
    $gameTasks = @("DisplayPostProcessing", "Audio")
    foreach ($task in $gameTasks) {
        $taskPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\$task"
        Set-WGRegistry -Path $taskPath -Name "Scheduling Category" -Value "High" -Type "String"
        Set-WGRegistry -Path $taskPath -Name "SFIO Priority" -Value "High" -Type "String"
        Set-WGRegistry -Path $taskPath -Name "Priority" -Value 6
    }
    
    # Oyun FSE (Full Screen Exclusive) iyileştirmeleri
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Value 1
    Set-WGRegistry -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureState" -Value 0
    
    Write-Host "Oyun modu optimizasyonları tamamlandı." -ForegroundColor Green
    Write-Host "NOT: HPET ayarı için yeniden başlatma gereklidir. Manuel olarak: bcdedit /deletevalue useplatformclock" -ForegroundColor Yellow
}