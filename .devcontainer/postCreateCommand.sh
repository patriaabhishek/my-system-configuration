#!/bin/bash

########################################
#### System install and permissions ####
########################################

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

########################
#### Configure zsh #####
########################

#Installing Oh My zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#Downloading plugins to install
git clone https://github.com/bobthecow/git-flow-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-flow-completion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
pip install thefuck
apt-get install -y tmux

cp ./.devcontainer/.zshrc ~/.zshrc

########################
#### Configure VIM #####
########################

cd vim
./config_vim.sh
cd ..


#####################################
#### Installing Python in Poetry ####
#####################################

# Install Python Packages
poetry config virtualenvs.in-project true
poetry new py-project
cd ./py-project
poetry add mypy black ruff pylint pytest isort flake8 pyright --group dev
poetry add fastapi pandas numpy scikit-learn matplotlib jupyterlab httpx openai
poetry source add --priority=explicit pytorch-gpu-src https://download.pytorch.org/whl/cu126
poetry add --source pytorch-gpu-src torch torchvision torchaudio

# Get the Poetry virtual environment path
venv_path=$(poetry env info --path)

# Check if the command succeeded
if [ $? -ne 0 ]; then
    echo "Failed to get the Poetry virtual environment path."
    exit 1
fi

# Determine the correct path for the Python interpreter
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    python_path="$venv_path/Scripts/python.exe"
else
    python_path="$venv_path/bin/python"
fi

# Get back to the project root
cd ..

# # Path to VS Code's settings.json
# vscode_settings_path=".vscode/settings.json"

# Create .vscode directory if it doesn't exist
mkdir -p ".vscode"

# Path to VS Code's launch.json
vscode_launch_path=".vscode/launch.json"

# Check if launch.json exists
if [ -f "$vscode_launch_path" ]; then
    launch_content=$(cat "$vscode_launch_path")
else
    echo "launch.json not found! Creating a new one..."
    launch_content='{
        "version": "0.2.0",
        "configurations": []
    }'
fi

# Use jq to update the python field for the "Python: FastAPI" configuration
updated_launch=$(echo "$launch_content" | sed '/^[[:blank:]]*\/\//d' | jq --arg python_path "$python_path" '
    (.configurations[] | select(.name == "Python: FastAPI")) |= . + {"python": $python_path}
')

# Save the updated launch.json
echo "$updated_launch" > "$vscode_launch_path"

echo "Updated Python path in launch.json to: $python_path"

# Add new repo
sudo add-apt-repository universe

# Install basic stuff
sudo apt install -y coreutils software-properties-common wget curl openssl cmake jq grc tree watchman libncurses-dev gcc unzip nano build-essential cmake figlet

# Firacode
sudo apt install -y fonts-firacode

#Eza
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# OpenSSH Server
sudo apt install -y openssh-server

# Nmap
sudo apt install -y nmap

# Fzf 
sudo apt install -y fzf

# Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

#Downloading plugins to install

git clone https://github.com/bobthecow/git-flow-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-flow-completion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# TheFUck
sudo apt update
sudo apt install -y python3-setuptools thefuck

# Configure Nano with syntax highlighting
mkdir configure_nano
cd ./configure_nano
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh)"
cd ..
rm -R configure_nano
