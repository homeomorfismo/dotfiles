# Add homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Modify default output
export PS1="%B%F{cyan}%n%f%b %F{red}%D %* %~%f"$'\n'"%B$%b "

# Add color support
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Autocomplete for git
autoload -Uz compinit && compinit

# Branch for git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '
zstyle ':vcs_info:git:*' formats '%b'

# Add homebrew
# Not installed yet
# export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

# Add TeX
export PATH=/Library/TeX/texbin:$PATH

# Add some binaries
export PATH=/usr/local/bin:$PATH

# Add CMake
export PATH=/Applications/CMake.app/Contents/bin:${PATH}

# Add python (see .zprofile)
export PATH=/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}

# Add ngsolve, feast paths
# Must be activated with ngs function, in .zsh_aliases
export PYTHONPATH=/Applications/Netgen.app/Contents/Resources/lib/python3.8/site-packages:.:${PYTHONPATH}
export NETGENDIR=/Applications/Netgen.app/Contents/MacOS

# Add petsc, slepc paths
# Must be activated with petsc function, in .zsh_aliases
export PETSC_DIR=${HOME}/Software/petsc
export PETSC_ARCH_DEBUG=osx-debug
export PETSC_ARCH_RELEASE=osx-release
export SLEPC_DIR=${HOME}/Software/slepc

# ruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3

# Add WSTP C/C++ library
export WSTP_DIR=/Applications/Wolfram\ Engine.app/Contents/Resources/Wolfram\ Player.app/Contents/SystemFiles/Links/WSTP/DeveloperKit/MacOSX-x86-64/CompilerAdditions

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases (some reused variables are defined above)
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# Add zoxide
eval "$(zoxide init zsh)"

