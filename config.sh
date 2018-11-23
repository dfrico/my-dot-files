# Homebrew installation
if hash brew 2>/dev/null; then
    echo "Brew is already installed"
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# brew files
if hash autojump 2>/dev/null; then
    echo "Brewfile apps already installed ?"
else
    brew bundle
fi

if [ "$ZSH_CUSTOM" == "" ]; then
    ZSH_CUSTOM="~/.oh-my-zsh/custom"
fi

# zsh plugins
if [ "$0" == "zsh" ]; then
    echo "Installing plugins to" $ZSH_CUSTOM
    # https://github.com/denysdovhan/spaceship-prompt/
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
    brew install zsh-syntax-highlighting

    # https://github.com/zsh-users/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# https://github.com/powerline/fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

brew tap caskroom/fonts && brew cask install font-iosevka

# pip apps
if hash rtv 2>/dev/null; then
    echo "Pip apps already installed"
else
    pip3 install rtv haxor-news
fi

# ADD THIS TO .ZSHRC PLUGINS:
# plugins=(zsh-autosuggestions)
