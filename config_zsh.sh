#!/usr/bin/zsh
export PATH="/usr/bin":$PATH


################################
####### Configuring ZSH ########
################################


#Installing Oh My zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Installing fonts

#Downloading fonts for powerlevel10k
mkdir powerlevel10kfonts
cd ./powerlevel10kfonts
curl -fsSLOJ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -fsSLOJ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -fsSLOJ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -fsSLOJ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
cd ..

#Copying fonts to system directories

mkdir -p ~/.local/share/fonts
mkdir -p /usr/local/share/fonts
mkdir -p /usr/share/fonts

cp ./powerlevel10kfonts/* ~/.local/share/fonts
cp ./powerlevel10kfonts/* /usr/local/share/fonts
cp ./powerlevel10kfonts/* /usr/share/fonts

#Refreshing system font cache
fc-cache -f -v

#Installing powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i -e "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" ~/.zshrc

#Copy your existing p10k configuration
cp .p10k.zsh ~/.p10k.zsh

#Updating .zshrc with p10k configuration prompt handling
cat p10kheader.txt ~/.zshrc p10kfooter.txt > $$.tmp && mv $$.tmp ~/.zshrc 

#Downloading plugins to install
git clone https://github.com/bobthecow/git-flow-completion ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-flow-completion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
pip install thefuck
apt-get install -y tmux
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#Reading ZSH plugins to install
zsh_plugins_names=""

while read -r line; do
   zsh_plugins_names+="${line}\n"
    echo "Plugin to install: ${line}"
done < zsh_plugins.txt

#Adding plugins to install to .zshrc
sed -i -e "s/plugins=(git)/plugins=(${zsh_plugins_names})/g" ~/.zshrc 


#Adding aliases  to .zshrc

#Installing exa as a replacement of ls
echo "alias lsa=\"exa --long --all --group --icons\"" >> ~/.zshrc

#Adding option to activate preferred conda environment by default
echo "\n#Activate your preferred conda environment by default" >> ~/.zshrc
echo "#conda activate py-env" >> ~/.zshrc


##Setting terminal color to 256 if 8 colors
#if [ ${TERM}="xterm" ]; then
#    export TERM=xterm-256color
#fi

