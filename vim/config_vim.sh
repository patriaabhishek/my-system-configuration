#Installing Vim
sudo apt install -y vim

#Installing dependencies
sudo apt install -y mono-complete golang openjdk-17-jdk openjdk-17-jre

#Copy .vimrc
cp .vimrc ~/.vimrc

#Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Install Plugins
vim --clean '+source ~/.vimrc' +PluginInstall +qall

#Install YouCompleteMe
cd ~/.vim/bundle/youcompleteme
python3 install.py --all