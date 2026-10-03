# imperative files

## age

to generate post quantum private keys:

`mkdir -p ~/.config/sops/age`

- user
  - nixos: `nix shell nixpkgs#age -c age-keygen -pq -o ~/.config/sops/age/keys.txt`
  - darwin: `nix shell nixpkgs#age -c age-keygen -pq -o ~/.config/sops/age/keys.txt`
- host
  - nixos: `nix shell nixpkgs#age -c age-keygen -pq -o /var/lib/sops-nix/key.txt`
  - darwin: `nix shell nixpkgs#age -c age-keygen -pq -o ~/Library/Application\ Support/sops/age/key.txt`

note: only need the user private key on trusted hosts

then, generate the public keys to copy paste into `~/flake/.sops.yaml`:

- user
  - nixos: `nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt`
  - darwin: `nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt`
- host
  - nixos: `nix shell nixpkgs#age -c age-keygen -y /var/lib/sops-nix/key.txt`
  - darwin: `nix shell nixpkgs#age -c age-keygen -y ~/Library/Application\ Support/sops/age/key.txt`

## home file structure

| name        | description   | earthy path           | starling path         | sync                     | backup |
| ----------- | ------------- | --------------------- | --------------------- | ------------------------ | ------ |
| shared      | e.g. password | `~/shared`            | `~/shared`            | earthy, starling, pigeon | yes    |
| docs        |               | `~/docs`              | `~/docs`              | earthy, starling         | yes    |
| music       | navidrome     | `~/media/music`       | `~/media/music`       | earthy, starling         | yes    |
| photos      | immich        | `~/media/photos`      | `~/media/photos`      | earthy, starling         | yes    |
| screenshots |               | `~/media/screenshots` | `~/media/screenshots` | earthy, starling         | -      |
| tmp         | downloads     | `~/tmp`               | `~/tmp`               | earthy, starling         | -      |
| flake       |               | `~/flake`             | `~/flake`             | earthy, starling         | -      |
| git         |               | `~/git`               | `~/git`               | -                        | -      |
| archive     |               | `~/archive`           |                       | -                        | yes    |
