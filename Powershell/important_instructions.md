# Important Instructions

On the **Windows host**, open **PowerShell** with administrative privileges.


## 1. Install Miniconda

```powershell
winget install Anaconda.Miniconda3
conda init --all -y -y
```

## 2. Configure Miniconda

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
      conda activate py-env
      Import-Module posh-git
      Import-Module Figlet
      function lsa{eza -al --icons}
      function winget_update{winget update --all --silent --accept-package-agreements --accept-source-agreements}
      function update_system{
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
