1. Install Miniconda

```
winget install Anaconda.Miniconda3
conda init --all -y -y
```

2. Configure Miniconda 

```
conda create --name py-env python=3.12
conda activate py-env
conda config --add channels conda-forge
conda install pandas numpy scikit-learn scipy matplotlib jupyterlab notebook
```

3. Restart the terminal

4. Install all software using the install software script by running the following command in Powershell 

```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
cd "C:\Path\To\Your\Script"
.\install_apps.ps1
```

5. Dump the configuration json file to the given folder
C:\Users\patri\AppData\Local\Programs\oh-my-posh\themes

6. Dump the contents of the settings.json in this repo to the Terminal's settings.json to get the required terminal settings and Material theme.
   * Try to only copy the ```scheme``` and ```profile``` sections.
   * Ensure that you have changed the font to the right font family.

7. Run this to install git Posh

```PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force```

8. Run this to install PSReadline that helps provide completions in PowerShell

```Install-Module PSReadLine```

9. Run the following line to set the prediction source

```Set-PSReadLineOption -PredictionSource HistoryAndPlugin```

10. Download the FiraCode Nerd Font from ```https://www.nerdfonts.com/font-downloads```

11. Copy the file ```abhishek_pc_ohmyposhconfig.omp.json``` to the directory shown by running the following command in PowerShell:  ``` "$env:POSH_THEMES_PATH"``` 

12. Add the following lines to the file by executing the command ```notepad $PROFILE```

```
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/abhishek_pc_ohmyposhconfig.omp.json" | Invoke-Expression
conda activate py-env
function lsa{eza -al --icons}
function winget_update{winget update --all --silent --accept-package-agreements --accept-source-agreements}
Import-Module posh-git
```
13. Setup RDP and SSH
   * Ensure that Tailscale is installed and running in unattended mode
   * `cd "C:\Path\To\Your\Script"`
   * Replace `<Enter-Desired-Port>` with desired RDP Port Number
   * Run `.\configure_rdp_ssh.ps1`
