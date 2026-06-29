default:
  just --list

starling:
  sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake ~/Documents/git/flake#starling --impure 2>&1 | nix run nixpkgs#nix-output-monitor --extra-experimental-features "nix-command flakes"
  # sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake ~/Documents/git/flake#starling --impure
  # - sudo yabai --load-sa

alias a-sd := anemone-sd
[group('anemone')]
anemone-sd:
  nix build ".#nixosConfigurations.anemone.config.system.build.sdImage" \
  --verbose \
  --log-format internal-json -v \
  |& nix run nixpkgs#nix-output-monitor -- --json

alias a-dep := anemone-deploy
[group('anemone')]
anemone-deploy:
  nix run nixpkgs#nixos-rebuild-ng -- test \
  --no-reexec \
  --flake .#anemone \
  --target-host root@10.10.1.245 \
  --use-substitutes \
  --verbose \
  --log-format internal-json -v \
  |& nix run nixpkgs#nix-output-monitor -- --json

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
