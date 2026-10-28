Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Configurações - PandaX Button Cloud"
$form.Size = New-Object System.Drawing.Size(850, 600)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(32, 32, 32)
$form.ForeColor = [System.Drawing.Color]::White
$form.Font = New-Object System.Drawing.Font("Segoe UI", 11)

$title = New-Object System.Windows.Forms.Label
$title.Text = "🎮  Button Cloud"
$title.Font = New-Object System.Drawing.Font("Segoe UI", 24)
$title.Location = New-Object System.Drawing.Point(30, 25)
$title.AutoSize = $true
$form.Controls.Add($title)

$description = New-Object System.Windows.Forms.Label
$description.Text = "Personalização dos controles PandaX para jogos."
$description.Location = New-Object System.Drawing.Point(35, 85)
$description.AutoSize = $true
$form.Controls.Add($description)

$enabled = New-Object System.Windows.Forms.CheckBox
$enabled.Text = "Ativar interface Button Cloud"
$enabled.Checked = $true
$enabled.Location = New-Object System.Drawing.Point(35, 135)
$enabled.AutoSize = $true
$form.Controls.Add($enabled)

$sizeLabel = New-Object System.Windows.Forms.Label
$sizeLabel.Text = "Tamanho dos botões"
$sizeLabel.Location = New-Object System.Drawing.Point(35, 190)
$sizeLabel.AutoSize = $true
$form.Controls.Add($sizeLabel)

$size = New-Object System.Windows.Forms.TrackBar
$size.Minimum = 50
$size.Maximum = 120
$size.Value = 80
$size.Location = New-Object System.Drawing.Point(35, 220)
$size.Width = 350
$form.Controls.Add($size)

$preview = New-Object System.Windows.Forms.Label
$preview.Text = "A      B      X      Y"
$preview.Font = New-Object System.Drawing.Font("Segoe UI", 22)
$preview.Location = New-Object System.Drawing.Point(40, 290)
$preview.AutoSize = $true
$form.Controls.Add($preview)

$size.Add_ValueChanged({
    $preview.Font = New-Object System.Drawing.Font(
        "Segoe UI",
        [Math]::Max(12, [Math]::Min(32, $size.Value / 3))
    )
})

$open = New-Object System.Windows.Forms.Button
$open.Text = "Abrir controle"
$open.Location = New-Object System.Drawing.Point(35, 390)
$open.Size = New-Object System.Drawing.Size(180, 45)
$form.Controls.Add($open)

$open.Add_Click({
    if ($enabled.Checked) {
        [System.Windows.Forms.MessageBox]::Show(
            "A interface está ativada. A integração com jogos precisa ser configurada separadamente.",
            "PandaX Button Cloud"
        )
    }
})

$save = New-Object System.Windows.Forms.Button
$save.Text = "Salvar configurações"
$save.Location = New-Object System.Drawing.Point(235, 390)
$save.Size = New-Object System.Drawing.Size(220, 45)
$form.Controls.Add($save)

$save.Add_Click({
    $config = @{
        Enabled = $enabled.Checked
        ButtonSize = $size.Value
    } | ConvertTo-Json

    $path = Join-Path $env:LOCALAPPDATA "PandaX"
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    Set-Content -Path (Join-Path $path "button-cloud.json") -Value $config

    [System.Windows.Forms.MessageBox]::Show(
        "Configurações salvas!",
        "PandaX"
    )
})

[void]$form.ShowDialog()
