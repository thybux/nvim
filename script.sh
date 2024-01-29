#!/bin/bash

# Mise à jour des paquets
sudo apt update

# Installation de Neovim
sudo apt install neovim -y

# Installation de gestionnaires de plugins pour Neovim
# Exemple : vim-plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Afficher la version de Neovim pour confirmer l'installation
nvim --version


