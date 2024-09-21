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

```.\install_apps.ps1```

5. Dump the configuration json file to the given folder
C:\Users\patri\AppData\Local\Programs\oh-my-posh\themes

6. Dump the contents of the settings.json in this repo to the Terminal's settings.json to get the required terminal settings and Material theme

7. Run this to install git Posh

```PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force```

9. Add the following lines to the file by executing the command ```notepad $PROFILE```

```
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/abhishek_pc_ohmyposhconfig.omp.json" | Invoke-Expression
conda activate py-env
function lsa{eza -al --icons}
function winget_update{winget update --all --silent --accept-package-agreements --accept-source-agreements}
Import-Module posh-git
```
