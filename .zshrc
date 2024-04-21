# .zshrc
# This file is sourced by zsh when it starts. It sets up the shell environment
# and defines some useful functions and aliases.
# Author: Gabriel Pinochet-Soto

### Environment
# Define operating system
export SYSTEM=$(uname)
export MACOS="Darwin"
export LINUX="Linux"

### Standard settings
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

### Standard paths
# Add some binaries
export PATH=/usr/local/bin:$PATH

# Define software paths
export SOFTWARE=${HOME}/Software
if [ ! -d ${SOFTWARE} ]; then
    echo "Creating ${SOFTWARE}"
    mkdir -p ${SOFTWARE}
fi

# PSU clusters
export ODIN=gpin2
export COEUS="${ODIN}"@login1.coeus.rc.pdx.edu

### Non-standard settings
# Add homebrew in macOS
if [ $SYSTEM = $MACOS ]; then
    export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# Add TeX
case $SYSTEM in
    $MACOS)
        if [ -d /Library/TeX/texbin ]; then
            export PATH=/Library/TeX/texbin:$PATH
        fi
        ;;
    $LINUX)
        # TODO: Add TeX path for Linux
        if [ -d /usr/local/texlive/2021/bin/x86_64-linux ]; then
            export PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH
        fi
        ;;
esac

# Add CMake
if [ $SYSTEM = $MACOS ]; then
    export PATH=/Applications/CMake.app/Contents/bin:$PATH
fi

# Add ngsolve, feast paths
# Must be activated with ngs function, in .zsh_aliases
export NGS_DIR=${SOFTWARE}/ngs
case $SYSTEM in
    $MACOS)
        # TODO
        export NETGENDIR=/Applications/Netgen.app/Contents/MacOS
        export PYTHONPATH=/Applications/Netgen.app/Contents/Resources/lib/python3.8/site-packages:.:${PYTHONPATH}
        ;;
    $LINUX)
        export NETGENDIR=${NGS_DIR}/install/bin
        export PYTHONPATH=${NGS_DIR}/install/lib/python3.8/site-packages:.:${PYTHONPATH}
        ;;
esac

# Add petsc, slepc paths
# Must be activated with petsc function, in .zsh_aliases
export PETSC_DIR=${SOFTWARE}/petsc
export SLEPC_DIR=${SOFTWARE}/slepc
case $SYSTEM in
    $MACOS)
        export PETSC_ARCH_DEBUG=osx-debug
        export PETSC_ARCH_RELEASE=osx-release
        ;;
    $LINUX)
        export PETSC_ARCH_DEBUG=linux-debug
        export PETSC_ARCH_RELEASE=linux-release
        ;;
esac

# add FEAST
export FEASTROOT=${SOFTWARE}/FEAST/4.0

# Astyle
if [ -d ${SOFTWARE}/astyle-code ]; then
    case $SYSTEM in
        $MACOS)
            export PATH=${SOFTWARE}/astyle-code/AStyle/build/mac/bin:$PATH
            export ASTYLE=${SOFTWARE}/astyle-code/AStyle/build/mac/bin/AStyle
            ;;
        $LINUX)
            export PATH=${SOFTWARE}/astyle-code/AStyle/build/linux/bin:$PATH
            export ASTYLE=${SOFTWARE}/astyle-code/AStyle/build/linux/bin/astyle
            ;;
    esac
fi

# ruby
case $SYSTEM in
    $MACOS)
        export PATH=/opt/homebrew/opt/ruby/bin:$PATH
        if [ -d /opt/homebrew/opt/chruby ]; then
            source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
            source /opt/homebrew/opt/chruby/share/chruby/auto.sh
        fi
        ;;
    $LINUX)
        export PATH=/usr/local/ruby/bin:$PATH
        if [ -d /usr/local/chruby ]; then
            source /usr/local/chruby/share/chruby/chruby.sh
            source /usr/local/chruby/share/chruby/auto.sh
        fi
        ;;
esac
[ $(command -v chruby) ] && chruby ruby-3.1.3

# Add WSTP C/C++ library
case $SYSTEM in
    $MACOS)
        export WSTP_DIR=/Applications/Wolfram\ Engine.app/Contents/Resources/Wolfram\ Player.app/Contents/SystemFiles/Links/WSTP/DeveloperKit/MacOSX-x86-64/CompilerAdditions
        ;;
    $LINUX)
        # TODO: Add WSTP_DIR for Linux
        export WSTP_DIR=/usr/local/Wolfram/WolframEngine/13.0/SystemFiles/Links/WSTP/DeveloperKit/Linux-x86-64/CompilerAdditions
        ;;
esac

### Run last
# Aliases (some reused variables are defined above)
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add zoxide
[ -f $(command -v zoxide) ] && eval "$(zoxide init zsh)"

# Add python (see .zprofile)
if [ $SYSTEM = $MACOS ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Add library paths
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$(brew --prefix)/lib"
