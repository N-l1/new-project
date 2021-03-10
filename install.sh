#!/bin/bash
#=================================
# Install script for macOS & Linux
# WARNING! This will replace your old config files!
#==================================================

# Change to dotfiles location
dotfiles=$HOME/dotfiles

# Only install Homebrew if on Mac
if [ "$(uname)" == "Darwin" ]; then
    echo "Installing Homebrew 🍺"
    if ! brew --version &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Successfully installed Homebrew"
    else
        echo "Homebrew already installed"
    fi
fi

printf "\nInstalling Wget 🛒\n"
if ! wget --version &>/dev/null; then
    if [ "$(uname)" == "Darwin" ]; then
        brew install wget
    else
        sudo apt update
        sudo apt install wget
    fi
    echo "Successfully installed Wget"
else
    echo "Wget already installed"
fi

printf "\nInstalling ZSH 💤\n"
if ! zsh --version &>/dev/null; then
    if [ "$(uname)" == "Darwin" ]; then
        brew install zsh
    else
        sudo apt install zsh
    fi
    chsh -s /usr/local/bin/zsh
    echo "Successfully installed ZSH"
else
    echo "ZSH already installed"
fi

printf "\nInstalling Neovim 🍃\n"
if ! nvim --version &>/dev/null; then
    if [ "$(uname)" == "Darwin" ]; then
        brew install neovim
    else
        sudo apt install neovim
    fi
    echo "Successfully installed Neovim"
else
    echo "Neovim already installed"
fi

printf "\nSymlinking·files·🗂\n"
# Create .config if it does not exist
if [ ! -d .config ]; then
    mkdir .config
fi
rm ~/.zshrc
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
rm -rf ~/.config/alacritty
ln -s ~/dotfiles/alacritty ~/.config/alacritty

echo "Symlink done"

printf "\nInstalling Oh My Zsh theme & plugins 🎡\n"

# Remove old theme & plugins, if any
rm -rf "$dotfiles/zsh/themes"
rm -rf "$dotfiles/zsh/plugins"
mkdir "$dotfiles/zsh/themes"
mkdir "$dotfiles/zsh/plugins"

# Update and download newest versions
wget -O "$dotfiles/zsh/themes/common.zsh-theme" https://raw.githubusercontent.com/jackharrisonsherlock/common/master/common.zsh-theme
git clone https://github.com/zsh-users/zsh-autosuggestions "$dotfiles/zsh/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$dotfiles/zsh/plugins/zsh-syntax-highlighting"
echo "Successfully installed theme & plugins"

printf "\nInstalling Oh My Zsh 🤩\n"
if ! [ -d "$ZSH" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Successfully installed Oh My Zsh"
else
    echo "Oh My Zsh already installed"
fi

printf "\nSetup complete 🎉\n"
