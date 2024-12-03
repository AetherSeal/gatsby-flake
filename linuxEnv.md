# 🐧🪟 Debian configuration in WSL

## 🏗️ Base

Go to the microsoft store and download the debian image

```bash
# update system
sudo apt update
# install curl wget xz-utils & git
sudo apt install wget curl xz-utils git
```

## 🧑‍💻Terminal

Configure Git

```bash
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

# clone the remote flake
nix develop github:aetherseal/gatsby-flake --no-write-lock-file
```
