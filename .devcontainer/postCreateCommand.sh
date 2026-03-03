#!/bin/bash

##################################
# System install and permissions #
##################################

# Ensure the Docker socket is available
sudo chmod 777 /var/run/docker.sock

# Add the vscode user to the docker group
# sudo usermod -aG docker vscode
sudo usermod -aG docker codespace

# Add the vscode user to the sudo group
# sudo usermod -aG sudo vscode
sudo usermod -aG sudo codespace

# Update the package list
sudo apt-get update

#############
# Oh My zsh #
#############

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

######################
# Common zsh plugins #
######################\

git clone https://github.com/bobthecow/git-flow-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-flow-completion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp ./.devcontainer/.zshrc ~/.zshrc

#################
# Configure VIM #
#################

cd vim
./config_vim.sh
cd ..

##############################
# Installing Python and Node #
##############################

curl -LsSf https://astral.sh/uv/install.sh | sh

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

#########################################
# Install common tools and dependencies #
#########################################

sudo add-apt-repository universe

sudo apt install -y software-properties-common

sudo apt install -y coreutils wget curl openssl cmake jq grc tree gcc unzip nano build-essential cmake tmux figlet

############
# Firacode #
############

sudo apt install -y fonts-firacode

#######
# Eza #
#######

sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

##################
# OpenSSH Server #
##################

sudo apt install -y openssh-server

########
# Nmap #
########

sudo apt install -y nmap

#######
# Fzf #
#######

sudo apt install -y fzf

###########################################
# Configure Nano with syntax highlighting #
###########################################

mkdir configure_nano
cd ./configure_nano
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh)"
cd ..
rm -R configure_nano