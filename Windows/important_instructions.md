# Important Instructions

On the **Windows host**, open **PowerShell** with administrative privileges.

## 0. Install Powershell

```powershell
winget install --id Microsoft.PowerShell --source winget
```

## 1. Install UV (Preferred) / Miniconda

```powershell
winget install --id=astral-sh.uv  -e
uv python install 3.12 --default
```

```powershell
winget install Anaconda.Miniconda3
conda init --all -y -y
```

## 2. Configure UV (Preferred) / Miniconda

```powershell
cd $env:USERPROFILE
uv init py-env
cd py-env
uv venv --clear
uv sync
```

```powershell
conda create --name py-env python=3.12
conda activate py-env
conda config --add channels conda-forge
conda install pandas numpy scikit-learn scipy matplotlib jupyterlab notebook
exit
```

## 3. Install all software using the install software script by running the following command in Powershell

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
cd "C:\Path\To\Your\Script"
.\install_apps.ps1
```

## 4. Terminal Configuration

   1. Download the FiraCode Nerd Font from `https://www.nerdfonts.com/font-downloads` and install them
   1. Install git Posh

      ```powershell
      PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
      ```
   1. Copy the file `abhishek_pc_ohmyposhconfig.omp.json` to the directory shown by running the following command in PowerShell: 
      ```powershell
      "$env:POSH_THEMES_PATH"
      ```
   1. Install PSReadLine
      ```powershell
      Install-Module PSReadLine
      ```
   1. Install History Plugin
      ```powershell
      Set-PSReadLineOption -PredictionSource HistoryAndPlugin
      ```
   1. Install Figlet
      ```powershell
      Install-PSResource -Name Figlet
      ```
   1. Copy the contents of the settings.json in this repo to the Terminal's settings.json to get the required terminal settings and Material theme
      - Only copy the ```scheme``` and ```profile``` sections.
      - Ensure that you have changed the font to the right font family.
   1. Open the Powershell configuration using ```notepad $PROFILE``` and add the following lines

      ```powershell
      oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/abhishek_pc_ohmyposhconfig.omp.json" | Invoke-Expression
      # If installing Python with Miniconda
      conda activate py-env
      # If installing Python with UV
      Join-Path -Path $env:USERPROFILE -ChildPath "py-env\.venv\Scripts\activate.ps1" | Invoke-Expression
      Import-Module posh-git
      Import-Module Figlet
      function lsa{eza -al --icons}
      function winget_update{winget update --all --silent --accept-package-agreements --accept-source-agreements}
      function update_system{

          # If configuring Python with UV
          Write-Figlet "System Python via UV"
          cd "$env:USERPROFILE\py-env"
          uv sync
          cd "$env:USERPROFILE"

          # If configuring Python with Miniconda
          Write-Figlet "System Conda"
          conda update --all -y -y
          conda clean --all -y -y -y
      
          Write-Figlet "Apps"
          winget_update
      }
      
      ```

## 5. Setup RDP

   1. Ensure that Tailscale is installed and running in unattended mode
   1. `cd "C:\Path\To\Your\Script"`
   1. Replace `<Enter-Desired-Port>` with desired RDP Port Number in the file configure_rdp.ps1
   1. Run `.\configure_rdp.ps1`

## 6. Setup SSH as Host

   1. Ensure that OpenSSH Server and OpenSSH Client are installed using Optional Features in the settings
   1. `cd "C:\Path\To\Your\Script"`
   1. Replace `<Enter-Desired-Port>` with desired SSH Port Number in the file 
   1. Run `.\configure_ssh_host.ps1`

## 7. Setup SSH as Client

   1. Ensure that OpenSSH Server and OpenSSH Client are installed using Optional Features in the settings
   1. `cd "C:\Path\To\Your\Script"`
   1. Add the following params in the script

      | Variable        | Description                                                                                       | Example Value                           |
      | --------------- | ------------------------------------------------------------------------------------------------- | --------------------------------------- |
      | `$manufacturer` | **Manufacturer name** of the remote device. Used for identifying the host.                        | `"Asus"`                                |
      | `$model`        | **Model name/number** of the remote device. Helps uniquely identify machines from the same brand. | `"GL552VW"`                             |
      | `$remoteOS`     | Operating system running on the remote host. Acceptable values are `"windows"` or `"unix"`.       | `"windows"`                             |
      | `$hostAlias`    | **Computed alias** combining manufacturer, model, and OS. Used as a unique reference label.       | `"Asus-GL552VW-windows"`                |
      | `$hostName`     | **Public IP address or DDNS hostname** of the router assigned by the ISP.                         | `"<ip-address-of-router-by-ISP>"`       |
      | `$sshUser`      | **Username** on the remote machine (used for SSH login).                                          | `"<username-on-host-machine>"`          |
      | `$sshPort`      | **Port number** on which SSH is exposed by the router (forwarded internally).                     | `"<port-configured-for-SSH-on-router>"` |

   1. Run `.\configure_ssh_client.ps1`

## 8. Harden SSH Security on Host

   Only do this when the public key has been exchanged between the Host and the Client

   1. Open Terminal
   1. Edit the SSH Configuration File
      - For Windows Host
         ```powershell
         notepad "$env:ProgramData\ssh\sshd_config"
         ```
      - For Unix Host
         ```bash
         sudo nano /etc/ssh/sshd_config
         ```
   1. In the opened `sshd_config` file, add or update these settings:

         ```ini
         PasswordAuthentication no
         StrictModes yes
         ```
   1. Save and Restart the SSH Service
      - For Windows
         ```powershell
         Restart-Service sshd
         ```
      - For Unix
         ```bash
         sudo service ssh restart
         ```

## 9. Tailscale Configuration

   1. Whenever a new device is added to the Tailscale, ensure that the auth doesn't expire
   1. Go to the Tailscale console in web browser, then disable key expiry for the device

## 10. WSL Setup for Linux Development on Windows

   You do not need Docker Desktop — WSL alone is enough! It creates a lightweight VM where your Linux distro runs seamlessly. 
   
   Follow these steps to set it up:
   
   1. Enable WSL on Windows

      Make sure Windows Subsystem for Linux (WSL) is enabled:

      ```powershell
      # Run in PowerShell as Administrator
      wsl --install
      ```

   1. List Available Linux Distributions

   1. Check which Linux distros you can install:

      ```powershell
      wsl.exe --list --online
      ```
   
   1. Install Your Chosen Distro

      Install a specific Linux distro by name:

      ```powershell
      # Example: install Ubuntu
      wsl.exe --install <Distribution-Name>
      ```

      After installation, set up your username and password when prompted.

   1. Configure WSL Settings

      Open Windows Subsystem for Linux Settings from the Start menu and adjust the following:

            💾 File System: Reduce the VHD file size

            🌐 Networking: Change mode to Mirrored

            🔒 Hyper-V Firewall: Ensure it is enabled

            🌍 Localhost Forwarding: Ensure it is enabled

            ⏱️ Optional Features: Set VM Idle timeout to -1 ms (prevents auto shutdown)

            🖥️ Nested Virtualization: Ensure it is enabled

   1. Auto-Start WSL on Windows

      WSL does not start automatically. Use Task Scheduler to launch it at Windows startup:

      ```powershell
      # Run as Administrator
      schtasks /Create /TN "StartWSL" /TR "wsl.exe -u root echo WSL Started" /SC ONSTART /RL HIGHEST /F
      ```


   1. Install Required Packages

      Run the postCreate script from the .devcontainer folder inside your WSL distro to install all necessary packages:

      ```bash
      # Inside WSL
      ./.devcontainer/postCreate.sh
      ```

   1. Configure SSH Access

      1. Set up an SSH server inside WSL. The server port is directly accessible from Windows.

      1. Create a Windows Firewall rule to allow SSH traffic:

         ```powershell
         # Replace <Port-Number> with your SSH server port
         New-NetFirewallRule -DisplayName "SSH-WSL-Custom" -Direction Inbound -Protocol TCP -LocalPort <Port-Number> -Action Allow
         ```

   1. Enable NVIDIA GPU Support

      If your WSL needs GPU access (CUDA, nvidia-smi), add the following to your distro’s .zshrc or .bashrc:

      ```bash
      # Adding Nvidia Utilities exposed from Windows to Linux
      export PATH="${PATH}:/usr/lib/wsl/lib/"
      ```

      Then run ```nvidia-smi``` in the shell to get the device details