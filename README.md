# Dotfiles

Personal dotfiles for my MacOS and Linux systems.

Intended usage is to clone this repository and symlink the files to the home directory:
this can be done with `stow` or manually.

## Stow

Install `stow` with your package manager and link the files:

```bash
# sudo apt install stow
# sudo pacman -S stow
# brew install stow
stow -v -R -t "${HOME}" dotfiles
```

## Manual (symlinks)

We can also symlink the files manually.
Run the provided script:

```bash
./linkmyfiles
# ./removemylinks
```

## Helix and Neovim

I prefer [neo-vim](https://github.com/neovim/neovim) instead of Vim,
as the setting and some small search features are superior.
Nothing you can't improve with plugins.

I also use [Helix](https://helix-editor.com) as it doesn't
have a plugin system: forced minimalism.

## Git

The `.gitconfig` is simple, but _who doesn't like instant ramen?_

- Please, look `git adog`. It means _all branches, decorate, one-line, graphic_.
- I implemented similar aliases: `git dog`, `git dg`...

## TODOs

- [ ] Check correctness for `stow` usage.
- [ ] Check correctness for manual install.
- [ ] Make a submodule for Nerdfonts...
- [ ] Write recovery scripts for:
    - [ ] MacOS
    - [ ] Arch Linux (`pacman` and `yay`)
    - [ ] `apt` based distros
