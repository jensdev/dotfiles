#!/bin/sh
printf "%.s=" $(seq 1 $(tput cols))
echo
echo "Installing nerd fonts and symbols:"
echo
for font in NerdFontsSymbolsOnly CascadiaCode CodeNewRoman FiraCode JetBrainsMono Meslo SourceCodePro UbuntuMono VictorMono
do
    if [ ! -d "$HOME/.local/share/fonts/$font" ] ; then
        wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" --directory-prefix ~/.local/share/fonts
        unzip ~/.local/share/fonts/$font.zip -d ~/.local/share/fonts/$font/ > /dev/null
        rm ~/.local/share/fonts/$font.zip -f
        rm ~/.local/share/fonts/$font/*Windows* -f
        echo "Installed $font."
        echo
    else
        echo "$font already installed."
        echo
    fi
done

printf "%.s=" $(seq 1 $(tput cols))
echo
echo "Setting up ZSH as the default shell:"
chsh -s /usr/bin/zsh


