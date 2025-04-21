default:
  just --list

alias a-sd := anemone-deploy
[group('anemone')]
anemone-sd:
  sudo nom build ".#nixosConfigurations.anemone.config.system.build.sdImage"

alias a-dep := anemone-deploy
[group('anemone')]
anemone-deploy:
  nixos-rebuild switch --flake .#anemone --target-host root@10.10.1.245 --verbose

[group('nixos')]
clean:
  nh clean all --keep 3

[group('nixos')]
update:
  NIX_CONFIG="access-tokens = github.com=$(gh auth token)" nix flake update

[group('nixos')]
repair:
  sudo nix-store --verify --check-contents --repair

[group('lint')]
alejandra:
  alejandra .

[group('lint')]
statix:
  statix check .

[group('lint')]
deadnix:
  deadnix -eq .
