#BASIC DEV TOOLS

sudo apt-get install vim git tree screenfetch
# wget -qO- https://raw.github.com/iknite/.vim/master/install.sh | sh
git clone https://github.com/iknite/.vim
./.vim/install.sh

# NUMIX THEME
sudo apt-add-repository ppa:numix/ppa
sudo apt-get update 
sudo apt-get install numix-icon-theme numix-icon-theme-circle unity-tweak-tool zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

chsh -s $(which zsh)


