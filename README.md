# nvim-config

Neovim config using lazy.nvim, Mason, nvim-lspconfig, nvim-cmp, Telescope,
Treesitter, Neo-tree and nvim-ufo.

**Requires Neovim 0.11 or newer.**

## Install

```sh
git clone https://github.com/jajo2520/nvim-config.git ~/.config/nvim
nvim   # plugins install on first launch
```

## Newer Neovim without admin rights (e.g. DICE)

```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
mkdir -p ~/.local && tar -xzf nvim-linux-x86_64.tar.gz -C ~/.local && rm nvim-linux-x86_64.tar.gz
echo 'export PATH="$HOME/.local/nvim-linux-x86_64/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
nvim --version
```

## Notes

- Telescope live grep (`<leader>ff`) needs `ripgrep` on your `PATH`.
- Mason installs `lua_ls`, `pyright`, `clangd` and `hls`; `hls` is large, so
  drop it from `lua/plugins/lsp.lua` if disk quota is tight.
