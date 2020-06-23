# generated using `code --list-extensions`
# install with | xargs -L 1 echo code --install-extension
extensions=(
atomiks.moonlight
axiomaticstudios.one-monokai-80s
be5invis.vscode-custom-css
CoenraadS.bracket-pair-colorizer-2
dbaeumer.vscode-eslint
deerawan.vscode-dash
eamodio.gitlens
esbenp.prettier-vscode
juanmnl.vscode-theme-1984
mikestead.dotenv
naumovs.color-highlight
PKief.material-icon-theme
RobbOwen.synthwave-vscode
teabyii.ayu
vscode-icons-team.vscode-icons
vscodevim.vim
whizkydee.material-palenight-theme
zhuangtongfa.material-theme
)

for e in ${extensions[@]}; do
  code --install-extension $e
done

