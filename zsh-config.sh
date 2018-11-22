# https://github.com/powerline/fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# https://github.com/denysdovhan/spaceship-prompt/
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
brew install zsh-syntax-highlighting

# https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# ADD THIS TO .ZSHRC PLUGINS:
# plugins=(zsh-autosuggestions)

pip3 install rtv haxor-news

