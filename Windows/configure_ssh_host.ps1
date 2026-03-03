# 🛡️ Ensure the script is run with administrative privileges
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "⚠️ Please run this script as an Administrator."
    Exit
}

# 🚀 Function to set SSH service to start automatically
function Set-SshAutostart {
    Set-Service -Name sshd -StartupType 'Automatic'
    Write-Host "✅ Set sshd service to start automatically."
    Start-Service sshd
    Write-Host "✅ Started the sshd service."
}

function Get-NextBackupPath {
    param (
        [string]$basePath
    )

    $i = 1
    do {
        $backupPath = "$basePath.bak.$i"
        $i++
    } while (Test-Path $backupPath)

    return $backupPath
}

# 📝 Function to modify sshd_config to use a custom port
function Set-SshPort {
    param (
        [int]$NewPort
    )

    $sshdConfigPath = "C:\ProgramData\ssh\sshd_config"
    $sshdConfigBackupPath = Get-NextBackupPath -basePath $sshdConfigPath

    # Backup existing config with numbered suffix
    Copy-Item $sshdConfigPath $sshdConfigBackupPath -Force
    Write-Host "📁 Backed up sshd_config to $sshdConfigBackupPath"

    # Change or add Port line
    (Get-Content $sshdConfigPath) |
    ForEach-Object {
        if ($_ -match "^\s*#?\s*Port\s+\d+") {
            "Port $NewPort"
        }
        else {
            $_
        }
    } | Set-Content $sshdConfigPath

    Write-Host "🔧 Updated SSH port to $NewPort in sshd_config."
}


# 🛡️ Function to add a firewall rule for the SSH port
function Add-FirewallRuleForSsh {
    param (
        [int]$NewPort
    )

    Write-Host ("-" * 100)
    New-NetFirewallRule -DisplayName 'SSH-Custom' -Name 'SSH-Custom-TCP-In' -Profile 'Public' -Direction Inbound -Action Allow -Protocol TCP -LocalPort $NewPort 
    Write-Host ("-" * 100)
    Write-Host "🛡️ Added firewall rule for SSH TCP port $NewPort."
}

# 🔄 Function to restart SSH and Firewall services
function Restart-SshAndFirewall {
    Restart-Service sshd
    Write-Host "♻️ Restarted sshd service with new configuration."
}

# === Execution ===

# Set SSH to autostart
Set-SshAutostart

# Set custom port (pass the desired port here)
$customPort = <Enter-Desired-Custom-Port>
Set-SshPort -NewPort $customPort

# Add firewall rule for the custom port
Add-FirewallRuleForSsh -NewPort $customPort

# Restart SSH to apply changes
Restart-SshAndFirewall

Write-Host "`n✅ SSH is now configured to use port $customPort and set to autostart."