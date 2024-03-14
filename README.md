# Dotfiles

See [this nice video](https://www.youtube.com/watch?v=y6XCebnB9gs).

## Requirements

We require `git` and `stow`. If using Mac, use `brew`.
Consider installing:

- `tldr`
- `fzf`
- `zoxide`
- `tree`
- `prettier`
- `black`

Clone/fork/shallow-clone this repo and do `cd dotfiles && stow .`.

## Vim/Neo-vim

You can either build [Vim](https://github.com/vim/vim) from scratch.
I prefer [neo-vim](https://github.com/neovim/neovim), as the setting and some small search features are superior.
Nothing you can't improve with plugins.

### Vim

Check [this tutotial](https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/) for
more details on how to modify `.vimrc`.

- I usually like `fzf` and it's vim plugin, but `telescope` is far superior.

### Neo-vim

The structure of Neo-vim is far more complicated but also more clean.
It is based on Lua. See [this tutorial](https://www.youtube.com/watch?v=J9yqSdvAKXY&pp=ygUKbmVvdmltIGx1YQ%3D%3D).

- LSP and cmp [see this](https://github.com/hrsh7th/nvim-cmp)
- Telescope
- Obsidian (I removed this because it felt obnoxious)
- Linters
  - Pylint, flake8
  - Cpplint

## Git

The .gitconfig is simple, but _who doesn't like instant ramen?_

- Please, look `git adog`. It means _all branches, decorate, one-line, graphic_.
- I implemented similar aliases: `git dog`, `git dg`

## Nerd Fonts

I am trying to make this a submodule!
