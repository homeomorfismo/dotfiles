export SYSTEM=$(uname)
export MACOS="Darwin"
export LINUX="Linux"

autoload -Uz vcs_info
precmd_vcs_info() {
  vcs_info
}
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f%F{red}%u%f%F{green}%c%f'
zstyle ':vcs_info:git:*' actionformats '%F{yellow}(%b|%a)%f%F{red}%u%f%F{green}%c%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '●'
zstyle ':vcs_info:*' stagedstr '✓'

RPROMPT='${vcs_info_msg_0_}'
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export PS1="%F{green}%n@%m%f %F{yellow}%D{%Y-%m-%d}%f %F{magenta}%D{%H:%M:%S}%f %F{blue}%~%f"$'\n'"$ "


if [[ ! -d "${HOME}/.zsh/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "${HOME}/.zsh/zsh-autosuggestions"
fi
if [[ ! -d "${HOME}/.zsh/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "${HOME}/.zsh/zsh-syntax-highlighting"
fi
source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

function get_python_version() {
  python3 -c 'import sys; print(f"python{sys.version_info.major}.{sys.version_info.minor}")'
}

function activate() {
  local env_dir="${HOME}/Env/$1"
  local python_version=$(get_python_version)      
  if [[ -z "$1" ]]; then
    echo "Usage: activate <environment_name>"
    echo "Available environments:"
    ls -1 "${HOME}/Env" 2>/dev/null || echo "No environments found"
    return 1
  fi
  if [[ ! -d "${env_dir}" ]]; then
    echo "Error: Environment '$1' not found in ${HOME}/Env"
    return 1
  fi

  source "${env_dir}/bin/activate"
  [[ -d "${env_dir}/lib/${python_version}/site-packages" ]] && \
    export PYTHONPATH="${env_dir}/lib/${python_version}/site-packages:${PYTHONPATH}"
}

function mkvenv() {
  local env_name="$1"
  local env_dir="${HOME}/Env/${env_name}"
  
  if [[ -z "${env_name}" ]]; then
    echo "Usage: mkvenv <environment_name>"
    return 1
  fi

  if [[ -d "${env_dir}" ]]; then
    echo "Error: Environment '${env_name}' already exists"
    return 1
  fi

  mkdir -p "${HOME}/Env"
  python3 -m venv "${env_dir}"
  echo "Created virtual environment: ${env_name} using $(get_python_version)"
  echo "To activate, run: activate ${env_name}"
}

[[ ! -d "${HOME}/Env" ]] && mkdir -p "${HOME}/Env"

if [[ "${SYSTEM}" == "${MACOS}" ]]; then
  [[ -f "${HOME}/.macconfig" ]] && source "${HOME}/.macconfig"
elif [[ "${SYSTEM}" == "${LINUX}" ]]; then
  [[ -f "${HOME}/.linuxconfig" ]] && source "${HOME}/.linuxconfig"
fi
