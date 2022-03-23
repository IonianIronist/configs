Ok so it was second time that I was re-figuring out how to setup everything to work,
so I decided to make a few notes here

# Dependεncies:

- Should install [packer](https://github.com/wbthomason/packer.nvim) first.
- For the lsp servers node is needed, so [nvm](https://github.com/nvm-sh/nvm) on linux and [nvs](https://github.com/jasongin/nvs) for windows

python:

``` npm install -g pyright ```

javascript:

``` npm install -g typescript typescript-language-server ```

php:

``` npm install -g intelephense ```

The terminal should be using one of the [patched fonts](https://github.com/ryanoasis/nerd-fonts) so that plugins that use special charactes work correctly.

---

After all that is done just

``` :PackerInstall ```

and hope for the best.
