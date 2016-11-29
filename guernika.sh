mkdir scripts && cd scripts

wget -O zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download
mkdir zsh && tar -xvzf.tar.gz -C zsh --strip-components 1
cd zsh

./configure --prefix=$HOME
make
make install

cd ~

export PATH=$PATH:$HOME/bin

# Copy this into .bash_profile and .profile:
export SHELL=$HOME/bin/zsh
exec /bin/zsh -l

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# note: delete zsh check or make it =1


