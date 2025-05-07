import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "willow's flake",
  description: "documentation for my nix flake",
  markdown: {
    theme: {
      light: "catppuccin-latte",
      dark: "catppuccin-macchiato",
    },
  },
  base: "/flake/",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    // nav: [
    //   { text: "Home", link: "/" },
    //   { text: "Examples", link: "/markdown-examples" },
    // ],

    sidebar: [
      {
        text: "Examples",
        items: [
          { text: "Install", link: "/install" },
          { text: "Configure", link: "/config" },
          { text: "Cheatsheet", link: "/cheetsheet" },
        ],
      },
    ],

    socialLinks: [
      { icon: "github", link: "https://github.com/42willow/flake" },
    ],
  },
});
