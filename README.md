<h3 align="center">
  <img src="docs/assets/flake.png" width="100" alt="Nix Logo" /><br />
  <img src="docs/assets/transparent.png" height="30" width="0px" alt="" />
  42willow's flake
  <img src="docs/assets/transparent.png" height="30" width="0px" alt="" />
</h3>

<h6 align="center">
  <a href="#hosts">Hosts</a>
  ·
  <a href="#installation">Installation</a>
  ·
  <a href="#credits">Credits</a>
</h6>

<p align="center">
  <img
    src="docs/assets/macchiato.png"
    width="400"
    alt="Catppuccin Macchiato Palette"
  />
</p>

<p align="center">
  <a href="https://github.com/42willow/flake/stargazers">
    <img
      alt="Stargazers"
      src="https://img.shields.io/github/stars/42willow/flake?style=for-the-badge&logo=starship&color=7dc4e4&logoColor=white&labelColor=363a4f"
  /></a>
  <a href="https://github.com/42willow/flake">
    <img
      alt="Repo Size"
      src="https://img.shields.io/github/repo-size/42willow/flake.svg?style=for-the-badge&logo=github&color=a6da95&logoColor=white&labelColor=363a4f"
  /></a>
  <a href="https://github.com/42willow/flake/issues">
    <img
      alt="Issues"
      src="https://img.shields.io/github/issues/42willow/flake?style=for-the-badge&logo=gitbook&color=f5a97f&logoColor=white&labelColor=363a4f"
  /></a>
  <a href="https://github.com/42willow/flake/tree/main/LICENSE">
    <img
      alt="GitHub License"
      src="https://img.shields.io/github/license/42willow/flake?style=for-the-badge&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgY2xhc3M9Imx1Y2lkZSBsdWNpZGUtc2NhbGUiPjxwYXRoIGQ9Im0xNiAxNiAzLTggMyA4Yy0uODcuNjUtMS45MiAxLTMgMXMtMi4xMy0uMzUtMy0xWiIvPjxwYXRoIGQ9Im0yIDE2IDMtOCAzIDhjLS44Ny42NS0xLjkyIDEtMyAxcy0yLjEzLS4zNS0zLTFaIi8%2BPHBhdGggZD0iTTcgMjFoMTAiLz48cGF0aCBkPSJNMTIgM3YxOCIvPjxwYXRoIGQ9Ik0zIDdoMmMyIDAgNS0xIDctMiAyIDEgNSAyIDcgMmgyIi8%2BPC9zdmc%2B&logoColor=%23cad3f5&labelColor=%23363a4f&color=%23c6a0f6"
    />
  </a>
</p>

<details>
<summary>Preview</summary>

https://github.com/42Willow/dotfiles/assets/70784752/c05e9d59-6c2d-466e-ab67-82bc5a7e0394

Preview last updated: `Feb 18, 2024`
</details>

---

> [!CAUTION]
> I do not know what I am doing!

These are my new dotfiles (migrating from arch over at https://github.com/42willow/dotfiles)

> [!WARNING]
> You should _not_ look at this for inspiration until it's complete, actually, you should probably never look at this for inspiration.
> If you are looking for inspiration, check out the [credits/configurations](#configurations) section, make sure to properly credit the original authors!

## Hosts

Hostnames are listed in this [gist](https://gist.github.com/42Willow/bd33bd408deced515cd05fd7512b2597).

Option defaults are all for `earthy`, which is my main machine.
- `earthy`: ThinkPad X1 Yoga Gen 4
- `anemone`: Raspberry Pi 3B+
- `lily`: Portable Recovery ISO

## Installation

1. Clone the repository

   ```bash
   nix run nixpkgs#git clone https://github.com/42willow/flake.git --extra-experimental-features "nix-command flakes"
   ```

## Credits

### People

Thank you to the following people for helping me get into nix (from [catppuccin](https://github.com/catppuccin/)):

- [HPSaucii](https://github.com/HPsaucii)
- [Isabel](https://github.com/isabelroses)
- [Getchoo](https://github.com/getchoo) for making [catppuccin/nix](https://github.com/catppuccin/nix)

... and everyone else in the [catppuccin](https://github.com/catppuccin) nix community for their continued support :)

### Configurations

- [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)
- [uncenter/flake](https://github.com/uncenter/flake)
- [getchoo/flake](https://github.com/getchoo/flake)
- [sofiedotcafe/luminarie](https://github.com/sofiedotcafe/luminarie)
- [sioodmy/dotfiles](https://github.com/sioodmy/dotfiles)
- [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config)
- [MatthiasBenaets/nix-config](https://github.com/MatthiasBenaets/nix-config)

... and more [here](https://github.com/stars/42Willow/lists/nix)

### Resources

- Vimjoyer: [YouTube](https://www.youtube.com/@vimjoyer/videos)
- Awesome Nix: [GitHub](https://github.com/nix-community/awesome-nix)
- Nix Pills: [EPUB](https://nixos.org/guides/nix-pills/nix-pills.epub) | [Web](https://nixos.org/guides/nix-pills/) | [GitHub](https://github.com/NixOS/nix-pills)
- nix.dev: [Web](https://nix.dev/) | [GitHub](https://github.com/NixOS/nix.dev)
- NixOS & Flakes Book: [PDF](https://github.com/ryan4yin/nixos-and-flakes-book/releases/latest) | [Web](https://nixos-and-flakes.thiscute.world/) | [Github](https://github.com/ryan4yin/nixos-and-flakes-book)

... and more [here](https://github.com/stars/42Willow/lists/nix)

<img src="https://github.com/user-attachments/assets/00dfccef-01fe-4bb2-81fa-98b948ba2d2c" width="400">
