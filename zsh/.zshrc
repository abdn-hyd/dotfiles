# ============================================================
# Basic environment
# ============================================================

# Global VPN settings
export http_proxy=http://127.0.0.1:7897
export https_proxy=http://127.0.0.1:7897

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Neovim / LazyVim
export NVIM_APPNAME=lazyVim
export EDITOR='nvim'


# ============================================================
# Zinit
# ============================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  print -P "%F{red}zinit not found at ${ZINIT_HOME}%f"
  print -P "%F{yellow}Run:%f git clone https://github.com/zdharma-continuum/zinit.git ${ZINIT_HOME}"
else
  source "${ZINIT_HOME}/zinit.zsh"
fi


# ============================================================
# History
# ============================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=200000
SAVEHIST=200000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY


# ============================================================
# Completion
# ============================================================

autoload -Uz compinit

# Use cached compdump for speed.
# Delete ~/.zcompdump* if completion behaves incorrectly.
if [[ -n "$HOME/.zcompdump" ]]; then
  compinit -d "$HOME/.zcompdump"
else
  compinit
fi


# ============================================================
# Theme: gentoo
# ============================================================

autoload -Uz colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'

zstyle ':vcs_info:*' actionformats '%F{5}(%F{2}%b%F{3}|%F{1}%a%c%u%m%F{5})%f '
zstyle ':vcs_info:*' formats '%F{5}(%F{2}%b%c%u%m%F{5})%f '
zstyle ':vcs_info:svn:*' branchformat '%b'
zstyle ':vcs_info:svn:*' actionformats '%F{5}(%F{2}%b%F{1}:%{3}%i%F{3}|%F{1}%a%c%u%m%F{5})%f '
zstyle ':vcs_info:svn:*' formats '%F{5}(%F{2}%b%F{1}:%F{3}%i%c%u%m%F{5})%f '
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:git*+set-message:*' hooks untracked-git

+vi-untracked-git() {
  if command git status --porcelain 2>/dev/null | command grep -q '??'; then
    hook_com[misc]='%F{red}?'
  else
    hook_com[misc]=''
  fi
}

gentoo_precmd() {
  vcs_info
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd gentoo_precmd

PROMPT='%(!.%B%F{red}.%B%F{green}%n@)%m %F{blue}%(!.%1~.%~) ${vcs_info_msg_0_}%F{blue}%(!.#.$)%k%b%f '


# ============================================================
# Plugins
# ============================================================

if (( ${+commands[zinit]} )); then
  # Oh My Zsh plugin snippets.
  # These do NOT require ~/.oh-my-zsh.
  # They are fetched and cached by zinit.
  zinit snippet OMZ::plugins/git/git.plugin.zsh
  zinit snippet OMZ::plugins/web-search/web-search.plugin.zsh

  # Upstream plugins.
  zinit ice wait lucid
  zinit light zsh-users/zsh-autosuggestions

  # zsh-syntax-highlighting should be loaded near the end.
  zinit ice wait lucid
  zinit light zsh-users/zsh-syntax-highlighting
fi


# ============================================================
# CLI integrations
# ============================================================

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# yazi: yy helper
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# micromamba
export MAMBA_EXE='/opt/homebrew/bin/micromamba'
export MAMBA_ROOT_PREFIX='/Users/gunneo/micromamba'

if [[ -x "$MAMBA_EXE" ]]; then
  __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
  else
    alias micromamba="$MAMBA_EXE"
  fi
  unset __mamba_setup
fi


# ============================================================
# Aliases
# ============================================================

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ......="cd ../../../.."
alias cls="clear"
alias nv="nvim"
alias rmds="$HOME/sh_scripts/rm_ds_store.sh"
alias sw="$HOME/.config/aerospace/scripts/swap-workspaces.sh"
alias mb="micromamba"
alias mba="micromamba activate"
alias mbd="micromamba deactivate"
alias ll="ls -l"
alias la="ls -la"
alias lg="lazygit"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=always"
fi
