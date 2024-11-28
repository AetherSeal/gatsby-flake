# 🐧🪟 Debian configuration in WSL

## 🏗️ Base

Go to the microsoft store and download the debian image

```bash
# install curl wget & xz-utils
sudo apt install wget curl xz-utils git
```

## 📦 Enviroment

Follow the commands

```bash
# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon
# modify nix.conf to enable nix flake
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
# use my flake

```

- install and configure git

```bash
brew install git
git config --global user.name "Alejandro Castro"
git config --global user.email "Alejandro Castro"
```
