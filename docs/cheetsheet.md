# Nix cheat sheet

> [!warning]
> this is bad, improvements coming soon™


## `nix-env` package management

| action              | Ubuntu                       | Nix                          | notes                                                                   |
| :------------------ | :--------------------------- | :--------------------------- | :---------------------------------------------------------------------- |
| update package list | `sudo apt update`            | `sudo nix-channel --update`  |                                                                         |
| search              | `apt search <query>`         | `nix search <query>`         | also try [search.nixos.org/packages](https://search.nixos.org/packages) |
| install             | `sudo apt install <package>` | `nix-env -i <package>`       | no root, atomic, per user                                               |
| upgrade installed   | `sudo apt upgrade`           | `nix-env -u`                 | no root, atomic, per user                                               |
| remove              | `sudo apt remove <package>`  | `nix-env -e <package>`       | no root, atomic, per user                                               |
| undo last operation | ...                          | `nix-env --rollback`         | no root, atomic, per user                                               |
| list installed      | `dpkg -l`                    | `nix-env -q`                 | per user                                                                |
| show generations    | ...                          | `nix-env --list-generations` |                                                                         |

## `nix-shell` isolated build/dev/run environments

Nix Reference Manual: [nix.dev](https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-shell)

| command                   | result                                                                        |
| :------------------------ | :---------------------------------------------------------------------------- |
| `nix-shell -p <packages>` | start shell in env with `<packages>`                                          |
| `nix-shell`               | start shell in the env defined by `shell.nix` or `default.nix` in current dir |
| `nix-shell --pure`        | same, but outside env is inaccessible                                         |

## `nix run` run a nix application

Nix Reference Manual: [nix.dev](https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-run)

Examples:
nix run nixpkgs#vim
nix run nixpkgs#statix -- help
nix run github:astro/deadnix -- -eq .

## NixOS declarative operating system configuration management

| command                             | result                                                                | notes                                                                 |
| :---------------------------------- | :-------------------------------------------------------------------- | :-------------------------------------------------------------------- |
| edit `/etc/nixos/configuration.nix` | define new system configuration                                       | running system is unaffected                                          |
| `nixos-rebuild switch`              | switch to the configuration defined in `/etc/nixos/configuration.nix` | atomic\*                                                              |
| `nixos-rebuild switch --rollback`   | switch to previous configuration                                      | atomic\*                                                              |
| `nixos-option <option>`             | show option value and documentation                                   | also try [search.nixos.org/options](https://search.nixos.org/options) |

\*services can fail to start

## Useful linting commands

### Alejandra

[GitHub](https://github.com/kamadorueda/alejandra)

### Deadnix

[GitHub](https://github.com/astro/deadnix)

#### Check

```bash
nix run github:astro/deadnix -- .
```

#### Format

Remember to commit/stage to git first, as this command will change files.

```bash
nix run github:astro/deadnix -- -eq .
```
