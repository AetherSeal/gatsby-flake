# 🐧🪟 Debian configuration in WSL

## 🏗️ Base

Go to the microsoft store and download the debian image

```bash
# update system
sudo apt update
# install curl wget xz-utils & git
sudo apt install wget curl xz-utils git
```

## 🧑‍💻Terminal (optional)

Install oh-my-bash

```bash
# download and run oh-my-bash install script
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
# substitute the theme name in ~/.bashrc
sed -i 's/OSH_THEME=".*"/OSH_THEME="powerbash10k"/' ~/.bashrc
# reloads the .bashrc file
source ~/.bashrc
```

Configure Git

```bash
brew install git
git config --global user.name "Alejandro Castro"
git config --global user.email "Alejandro Castro"
```

## 📦 Enviroment

Follow the commands in order to install and configure nix

```bash
# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon
# modify nix.conf to enable nix flake
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
```

Basic commands of nix flakes

```bash
# Updates all inputs of the flake to their latest versions.
nix flake update
# Runs an app from a remote flake without installing it.
nix run github:user/repo
# Opens a development environment from a remote flake.
nix develop github:user/repo
```
