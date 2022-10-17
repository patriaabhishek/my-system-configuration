#!/usr/bin/zsh
export PATH="/usr/bin":$PATH


###############################
###### Configuring VIM ########
###############################

#Installing libncurses-dev as some distros might not have it
apt-get install -y libncurses-dev
apt-get install -y python3-dev

#Installing VIM by compiling and adding python3 support
git clone https://github.com/vim/vim.git
cd vim/src
./configure --with-features=huge --enable-python3interp=yes 
make
make install

cd ../..

#Copying base .vimrc
cp .vimrc ~/.vimrc

#Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Reading Vim Plugins to install
vim_plugins_names=""

while read -r line; do
   vim_plugins_names+="Plugin '"${line}"'\n"
   echo "Plugin to install: ${line}"
done < vim_plugins.txt

#Adding plugins to .vimrc
#Note that in this sed we are using | char to prevent a crappy error
#instead of /
sed -i -e "s|\"insert_plugins_from_file|${vim_plugins_names}|g" ~/.vimrc

#Installing Plugins
vim --clean '+source ~/.vimrc' +PluginInstall +qall

#Install you complete me
python3 ~/.vim/bundle/youcompleteme/install.py --force-sudo

echo pwd
