#!/bin/bash
set -e

echo "Installing required packages..."

# Update package list
sudo apt update

# Install Node.js (required for coc.nvim)
if ! command -v node >/dev/null; then
    echo "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
    sudo apt install -y nodejs
else
    echo "Node.js already installed."
fi

# Install vim if missing
if ! command -v vim >/dev/null; then
    echo "Installing Vim..."
    sudo apt install -y vim
fi

echo "Symlinking dotfiles..."
ln -sf "$PWD/.vimrc" "$HOME/.vimrc"
ln -sf "$PWD/.gitconfig" "$HOME/.gitconfig"

vim +PlugInstall +qall

echo "Installing packages..."
sudo apt update
sudo apt install -y php-fpm

echo "Setting up VSCode settings..."
mkdir -p ~/.config/Code/User
ln -sf "$PWD/vscode/settings.json" ~/.config/Code/User/settings.json
