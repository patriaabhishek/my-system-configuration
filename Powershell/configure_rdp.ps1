# 🛡️ Ensure the script is run with administrative privileges
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "⚠️ Please run this script as an Administrator."
    Exit
}

# 🔍 Function to get the current RDP port
Function Get-RDPPort {
    Write-Host "🔍 Fetching current RDP port..."
    Write-Host ("-" * 100)
    Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "PortNumber"
    Write-Host ("-" * 100)
}

# ✏️ Function to set a new RDP port in the registry
Function Set-RDPPort {
    Param (
        [Parameter(Mandatory = $true)]
        [int]$NewPort
    )

    Write-Host "⚙️ Changing RDP port to $NewPort..."

    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "PortNumber" -Value $NewPort

    Write-Host "✅ RDP port changed to $NewPort. 🔁 Please restart the system for changes to take effect."
}

# 🔥 Function to add a firewall rule for the new RDP port
Function Add-RDPFirewallRule {
    Param (
        [Parameter(Mandatory = $true)]
        [int]$NewPort
    )

    Write-Host "🧱 Adding firewall rules for TCP and UDP port $NewPort..."

    Write-Host ("-" * 100)
    New-NetFirewallRule -DisplayName 'RDP-Custom-TCP-In' -Name 'RDP-Custom-TCP-In' -Profile 'Public' -Direction Inbound -Action Allow -Protocol TCP -LocalPort $NewPort 
    Write-Host ("-" * 100)
    New-NetFirewallRule -DisplayName 'RDP-Custom-UDP-In' -Name 'RDP-Custom-UDP-In' -Profile 'Public' -Direction Inbound -Action Allow -Protocol UDP -LocalPort $NewPort
    Write-Host ("-" * 100)


    Write-Host "`n✅ Firewall rule added for port $NewPort."

    # Restart Remote Desktop Services
    Write-Host "🔄 Restarting Remote Desktop Services (TermService)..."

    Stop-Service -Name TermService -Force
    Start-Service -Name TermService
    
    Write-Host "🎉 Done!"
}

# 🌐 Function to restrict RDP access to Tailscale IP range
Function Restrict-RDPToTailscale {
    Write-Host "🔒 Restricting RDP access to Tailscale IP range (100.64.0.0/10)..."

    $tailscaleIPRange = "100.64.0.0/10"
    $ruleNames = @("RDP-Custom-TCP-In", "RDP-Custom-UDP-In")
    
    foreach ($ruleName in $ruleNames) {
        Set-NetFirewallRule -Name $ruleName -RemoteAddress $tailscaleIPRange
        Write-Host "✅ Updated $ruleName with Tailscale IP restriction."
    }

    Write-Host "✅ RDP access restricted to Tailscale IP range."
}

# 🚀 Combo function to run everything together
function Set-RDPPortWithFirewallAndTailscale {
    param (
        [Parameter(Mandatory = $true)]
        [int]$NewPort
    )

    Write-Host "🧾 Current RDP Port:"
    Get-RDPPort

    Write-Host "`n⚙️ Setting new RDP port to $NewPort..."
    Set-RDPPort -NewPort $NewPort

    Write-Host "`n🛡️ Adding firewall rule for port $NewPort..."
    Add-RDPFirewallRule -NewPort $NewPort

    Write-Host "`n🛡️ Adding firewall rule for Tailscale..."
    Restrict-RDPToTailscale

    Write-Host "`n🚀 RDP port changed and firewall rule added successfully with Tailscale!"
}

Set-RDPPortWithFirewallAndTailscale -NewPort <Enter-Desired-Port>