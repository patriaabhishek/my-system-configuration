#!/usr/bin/zsh
export PATH="/usr/bin":$PATH

#Setting up folders for nano configuration
mkdir configure_nano
cd ./configure_nano

#Downloading & installing improved nanorc files for syntax detection
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh)"

#Cleaning up
cd ..
rm -R configure_nano
