# System configuration

My preferred configuration for unix based systems

The scripts could be used for configuring:
1. Terminal
2. Vim
3. Anaconda 

## Installation Instructions:

*Ensure that your terminal supports 256-color, otherwise expect erratic behaviour*

*Check that the scripts are executables and run in the order presented below*

### MacOS
1. `configuration-osx.sh`
2. `homebrew.sh`
3. `config_zsh.sh`
4. `config_vim`
5. `config_nano.sh`
6. `conda-env/config_conda.sh`
7. `conda-env/config_conda_envs.sh`

### Linux
1. `config_zsh.sh`
2. `config_vim`
3. `config_nano.sh`
4. `conda-env/config_conda.sh`
5. `conda-env/config_conda_envs.sh`

### Notes:
- Above scripts have been tested on an Anaconda Docker Image
- Relevant testing scripts could be found in the repo
- Check shebangs, if for some reason the scripts don't work
