# 1. Homebrew installation
if hash brew 2>/dev/null; then
    echo "Brew is already installed"
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Installing apps
./brewapps.sh

# 3. Migrating basic configs
stow nvim
stow vim
stow zsh
# TODO: finish config bee, iTerm...

if [ "$ZSH_CUSTOM" == "" ]; then
    ZSH_CUSTOM="~/.oh-my-zsh/custom"
fi

# 4. oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# 5. oh-my-zsh plugins
echo "Installing plugins to" $ZSH_CUSTOM
# https://github.com/spaceship-prompt/spaceship-prompt 
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
brew install zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
brew install zsh-autosuggestions

# https://github.com/powerline/fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# 6. Goodies
curl https://bun.sh/install | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
