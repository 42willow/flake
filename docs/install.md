# Installation

1. Install via [graphical installer](https://nixos.org/download/) (I like to use the KDE Plasma installer)
2. Setup
```bash
nmtui # connect to network
nix-shell -p "git nh" --extra-experimental-features "nix-command flakes"
git clone https://github.com/42willow/flake
nh os switch -H earthy --flake ./flake/ -- --extra-experimental-features "nix-command flakes"
```
