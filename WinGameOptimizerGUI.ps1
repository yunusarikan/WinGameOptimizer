# WinGameOptimizer GUI
# Basit ve etkili kullanıcı arayüzü

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Ana form
$form = New-Object System.Windows.Forms.Form
$form.Text = "WinGameOptimizer v1.0.0"
$form.Size = New-Object System.Drawing.Size(600, 700)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(32, 32, 32)
$form.ForeColor = [System.Drawing.Color]::White
$form.Font = New-Object System.Drawing.Font("Segoe UI", 9)

# Başlık
$title = New-Object System.Windows.Forms.Label
$title.Text = "Windows Oyun ve Performans Optimizer"
$title.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$title.ForeColor = [System.Drawing.Color]::Cyan
$title.Size = New-Object System.Drawing.Size(550, 40)
$title.Location = New-Object System.Drawing.Point(20, 20)
$title.TextAlign = "MiddleCenter"
$form.Controls.Add($title)

# Profil seçimi
$profileLabel = New-Object System.Windows.Forms.Label
$profileLabel.Text = "Profil Seçin:"
$profileLabel.Location = New-Object System.Drawing.Point(30, 80)
$profileLabel.Size = New-Object System.Drawing.Size(100, 25)
$form.Controls.Add($profileLabel)

$profileCombo = New-Object System.Windows.Forms.ComboBox
$profileCombo.Location = New-Object System.Drawing.Point(130, 80)
$profileCombo.Size = New-Object System.Drawing.Size(200, 25)
$profileCombo.Items.AddRange(@("Gaming (Tüm Optimizasyonlar)", "Essential (Temel)", "Privacy (Gizlilik)", "Performance (Performans)"))
$profileCombo.SelectedIndex = 0
$profileCombo.DropDownStyle = "DropDownList"
$form.Controls.Add($profileCombo)

# Kategoriler
$categoryGroup = New-Object System.Windows.Forms.GroupBox
$categoryGroup.Text = "Optimizasyon Kategorileri"
$categoryGroup.Location = New-Object System.Drawing.Point(30, 120)
$categoryGroup.Size = New-Object System.Drawing.Size(530, 350)
$categoryGroup.ForeColor = [System.Drawing.Color]::Yellow
$form.Controls.Add($categoryGroup)

$yPos = 25
$checkboxes = @{}

$categories = @(
    @{Name="chkEssential"; Text="Temel Optimizasyonlar (Telemetri, Cortana, Widget vb.)"; Tag="Essential"},
    @{Name="chkPrivacy"; Text="Gizlilik (Konum, Arka Plan, Bildirimler)"; Tag="Privacy"},
    @{Name="chkUI"; Text="Arayüz (Sağ Tık, Dosya Gezgini)"; Tag="UI"},
    @{Name="chkVisual"; Text="Görsel Efektler (Animasyonlar, Saydamlık)"; Tag="Visual"},
    @{Name="chkTaskbar"; Text="Görev Çubuğu (Bing, Sohbet, Teams)"; Tag="Taskbar"},
    @{Name="chkServices"; Text="Servisler (GameDVR, Superfetch, Print)"; Tag="Services"},
    @{Name="chkPower"; Text="Güç Planı (Ultimate Performance)"; Tag="Power"},
    @{Name="chkGPU"; Text="GPU Optimizasyonu (GPU Zamanlama, MSI)"; Tag="GPU"},
    @{Name="chkNetwork"; Text="Ağ Optimizasyonu (TCP, DNS, Nagle)"; Tag="Network"},
    @{Name="chkGameMode"; Text="Oyun Modu (Timer, HPET, MMCSS)"; Tag="GameMode"},
    @{Name="chkBloatware"; Text="Uygulama Temizliği (Xbox, OneDrive, Bloatware)"; Tag="Bloatware"}
)

foreach ($category in $categories) {
    $check = New-Object System.Windows.Forms.CheckBox
    $check.Text = $category.Text
    $check.Location = New-Object System.Drawing.Point(15, $yPos)
    $check.Size = New-Object System.Drawing.Size(500, 25)
    $check.Checked = $true
    $check.ForeColor = [System.Drawing.Color]::White
    $categoryGroup.Controls.Add($check)
    $checkboxes[$category.Tag] = $check
    $yPos += 28
}

# İlerleme çubuğu
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(30, 490)
$progressBar.Size = New-Object System.Drawing.Size(530, 25)
$progressBar.Style = "Marquee"
$progressBar.Visible = $false
$form.Controls.Add($progressBar)

# Durum etiketi
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Hazır..."
$statusLabel.Location = New-Object System.Drawing.Point(30, 525)
$statusLabel.Size = New-Object System.Drawing.Size(530, 25)
$statusLabel.ForeColor = [System.Drawing.Color]::LightGray
$form.Controls.Add($statusLabel)

# Optimize Et butonu
$optimizeButton = New-Object System.Windows.Forms.Button
$optimizeButton.Text = "OPTİMİZE ET"
$optimizeButton.Location = New-Object System.Drawing.Point(30, 560)
$optimizeButton.Size = New-Object System.Drawing.Size(200, 45)
$optimizeButton.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$optimizeButton.ForeColor = [System.Drawing.Color]::White
$optimizeButton.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$optimizeButton.FlatStyle = "Flat"
$optimizeButton.FlatAppearance.BorderSize = 0
$form.Controls.Add($optimizeButton)

# Geri Al butonu
$restoreButton = New-Object System.Windows.Forms.Button
$restoreButton.Text = "GERİ AL"
$restoreButton.Location = New-Object System.Drawing.Point(250, 560)
$restoreButton.Size = New-Object System.Drawing.Size(150, 45)
$restoreButton.BackColor = [System.Drawing.Color]::FromArgb(200, 50, 50)
$restoreButton.ForeColor = [System.Drawing.Color]::White
$restoreButton.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$restoreButton.FlatStyle = "Flat"
$restoreButton.FlatAppearance.BorderSize = 0
$form.Controls.Add($restoreButton)

# Durum butonu
$statusButton = New-Object System.Windows.Forms.Button
$statusButton.Text = "DURUM"
$statusButton.Location = New-Object System.Drawing.Point(420, 560)
$statusButton.Size = New-Object System.Drawing.Size(140, 45)
$statusButton.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 60)
$statusButton.ForeColor = [System.Drawing.Color]::White
$statusButton.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$statusButton.FlatStyle = "Flat"
$statusButton.FlatAppearance.BorderSize = 0
$form.Controls.Add($statusButton)

# Optimize Et butonu tıklama
$optimizeButton.Add_Click({
    $profileMap = @{
        0 = "Gaming"
        1 = "Essential"
        2 = "Privacy"
        3 = "Performance"
    }
    
    $selectedProfile = $profileMap[$profileCombo.SelectedIndex]
    
    $progressBar.Visible = $true
    $optimizeButton.Enabled = $false
    $restoreButton.Enabled = $false
    $statusButton.Enabled = $false
    $statusLabel.Text = "Optimizasyon başlatılıyor... Lütfen bekleyin."
    $statusLabel.ForeColor = [System.Drawing.Color]::Yellow
    
    # Arka planda çalıştır
    $job = Start-Job -ScriptBlock {
        param($profile)
        Import-Module "$using:script:ModuleRoot\WinGameOptimizer.psm1" -Force
        Invoke-WGOptimize -Profile $profile
    } -ArgumentList $selectedProfile
    
    # İş bitince kontrol et
    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 500
    $timer.Add_Tick({
        if ($job.State -eq 'Completed') {
            $timer.Stop()
            $timer.Dispose()
            
            $progressBar.Visible = $false
            $optimizeButton.Enabled = $true
            $restoreButton.Enabled = $true
            $statusButton.Enabled = $true
            $statusLabel.Text = "Optimizasyon tamamlandı! Bilgisayarı yeniden başlatın."
            $statusLabel.ForeColor = [System.Drawing.Color]::Green
            
            Receive-Job $job | Out-Null
            Remove-Job $job
            
            [System.Windows.Forms.MessageBox]::Show(
                "Optimizasyon tamamlandı!`n`nDeğişikliklerin tam etkisi için bilgisayarı yeniden başlatmanız önerilir.",
                "WinGameOptimizer",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        }
    })
    $timer.Start()
})

# Geri Al butonu tıklama
$restoreButton.Add_Click({
    $result = [System.Windows.Forms.MessageBox]::Show(
        "Tüm optimizasyonları geri almak istediğinize emin misiniz?",
        "Geri Al",
        [System.Windows.Forms.MessageBoxButtons]::YesNo,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    )
    
    if ($result -eq 'Yes') {
        $progressBar.Visible = $true
        $statusLabel.Text = "Geri yükleme yapılıyor..."
        $statusLabel.ForeColor = [System.Drawing.Color]::Yellow
        
        $job = Start-Job -ScriptBlock {
            Import-Module "$using:script:ModuleRoot\WinGameOptimizer.psm1" -Force
            Invoke-WGRestore
        }
        
        $timer = New-Object System.Windows.Forms.Timer
        $timer.Interval = 500
        $timer.Add_Tick({
            if ($job.State -eq 'Completed') {
                $timer.Stop()
                $timer.Dispose()
                
                $progressBar.Visible = $false
                $statusLabel.Text = "Geri yükleme tamamlandı!"
                $statusLabel.ForeColor = [System.Drawing.Color]::Green
                
                Receive-Job $job | Out-Null
                Remove-Job $job
            }
        })
        $timer.Start()
    }
})

# Durum butonu tıklama
$statusButton.Add_Click({
    $statusLabel.Text = "Durum kontrol ediliyor..."
    $statusLabel.ForeColor = [System.Drawing.Color]::Yellow
    
    $job = Start-Job -ScriptBlock {
        Import-Module "$using:script:ModuleRoot\WinGameOptimizer.psm1" -Force
        Get-WGStatus
    }
    
    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 500
    $timer.Add_Tick({
        if ($job.State -eq 'Completed') {
            $timer.Stop()
            $timer.Dispose()
            
            $statusLabel.Text = "Hazır - Durum konsola yazdırıldı"
            $statusLabel.ForeColor = [System.Drawing.Color]::LightGray
            
            Receive-Job $job | Out-Null
            Remove-Job $job
        }
    })
    $timer.Start()
})

# Form kapanırken
$form.Add_FormClosing({
    $form.Dispose()
})

# Formu göster
$form.Add_Shown({$form.Activate()})
[void] $form.ShowDialog()