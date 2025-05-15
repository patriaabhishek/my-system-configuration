# 🛡️ Ensure the script is run with administrative privileges
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "⚠️ Please run this script as an Administrator."
    Exit

    ########################################################################################
    ############################# 💡 FUNCTION DEFINITIONS #################################
    ########################################################################################

    function Generate-SSHKey {
        param (
            [string]$KeyPath
        )
        if (!(Test-Path "$KeyPath")) {
            ssh-keygen -t ed25519 -f "$KeyPath" -N ""
            Write-Host "🔐 SSH key generated at: $KeyPath"
        }
        else {
            Write-Host "🔑 SSH key already exists at: $KeyPath"
        }
    }

    function Add-SSHConfigEntry {
        param (
            [string]$Alias,
            [string]$HostName,
            [string]$User,
            [string]$Port,
            [string]$IdentityFile
        )
        $configPath = "$HOME\.ssh\config"

        $entry = @"
Host $Alias
    HostName $HostName
    User $User
    IdentityFile $IdentityFile
    Port $Port
"@

        if (!(Test-Path "$HOME\.ssh")) {
            New-Item -Path "$HOME\.ssh" -ItemType Directory -Force | Out-Null
        }

        if (!(Test-Path $configPath)) {
            New-Item -Path $configPath -ItemType File -Force | Out-Null
        }

        if (-not (Select-String -Path $configPath -Pattern "Host $Alias")) {
            Add-Content -Path $configPath -Value "`n$entry"
            Write-Host "📄 SSH config entry added for: $Alias"
        }
        else {
            Write-Host "📘 SSH config entry for $Alias already exists"
        }
    }

    function Add-PubKeyToWindowsHost {
        param (
            [string]$Alias,
            [string]$PublicKeyPath
        )
        Write-Host "🪟 Adding public key to Windows remote host..."
        Get-Content $PublicKeyPath | Out-String | ssh $Alias 'powershell -Command "Add-Content -Force -Path `$Env:PROGRAMDATA\ssh\administrators_authorized_keys"'
    }

    function Add-PubKeyToUnixHost {
        param (
            [string]$Alias,
            [string]$PublicKeyPath
        )
        Write-Host "🐧 Adding public key to Unix-like remote host..."
        $pubKey = Get-Content $PublicKeyPath -Raw
        ssh $Alias "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '$pubKey' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
    }

    ########################################################################################
    ############################# 🚀 MAIN SCRIPT START #####################################
    ########################################################################################

    # 🔧 User Configuration
    $manufacturer = "Asus" # 🔄 Change depending on remote host manufacturer
    $model = "GL552VW" # 🔄 Change depending on remote host model
    $remoteOS = "windows"  # 🔄 Change to "unix" if needed

    $hostAlias = "$manufacturer-$model-$remoteOS"
    $hostName = "<ip-address-of-router-by-ISP>"
    $sshUser = "<username-on-host-machine>"
    $sshPort = "<port-configured-for-SSH-on-router>"

    # 📁 File Paths
    $keyPathBase = "$HOME\.ssh\id_ed25519-$hostAlias-server-ssh"
    $pubKeyPath = "$keyPathBase.pub"

    # 🔨 Run Setup Steps
    Generate-SSHKey -KeyPath $keyPathBase
    Add-SSHConfigEntry -Alias $hostAlias -HostName $hostName -User $sshUser -Port $sshPort -IdentityFile $keyPathBase

    # 🧠 Choose correct method to copy public key based on remote OS
    switch ($remoteOS.ToLower()) {
        "windows" {
            Add-PubKeyToWindowsHost -Alias $hostAlias -PublicKeyPath $pubKeyPath
        }
        "unix" {
            Add-PubKeyToUnixHost -Alias $hostAlias -PublicKeyPath $pubKeyPath
        }
        default {
            Write-Host "❌ Unknown remote OS: $remoteOS. Use 'windows' or 'unix'."
        }
    }

    Write-Host "✅ SSH setup completed for $remoteOS host!"
