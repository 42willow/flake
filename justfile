switch:
  nh os switch
  # sudo nixos-rebuild switch --flake /etc/nixos#earthy

anemone:
  sudo nom build ".#nixosConfigurations.anemone.config.system.build.sdImage"

clean:
  nh clean all

update:
  NIX_CONFIG="access-tokens = github.com=$(gh auth token)" nix flake update

repair:
  sudo nix-store --verify --check-contents --repair

boot:
  nh os boot

[group('lint')]
alejandra:
  alejandra .

[group('lint')]
statix:
  statix check .

[group('lint')]
deadnix:
  deadnix -eq .

[group('lint')]
deadnix-scan:
  deadnix .
