# ============================================================
# Basic environment
# ============================================================

# Global VPN settings
export http_proxy=http://127.0.0.1:7897
export https_proxy=http://127.0.0.1:7897

# Homebrew
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"

path=(
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  $path
)
export PATH

# Neovim / LazyVim
export NVIM_APPNAME=lazyVim
export EDITOR='nvim'

# zsh-defer
source ~/zsh-defer/zsh-defer.plugin.zsh

# ============================================================
# CLI integrations
# ============================================================

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  zsh-defer 'eval "$(fzf --zsh)"'
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

# micromamba lazy loading
export MAMBA_EXE='/opt/homebrew/bin/micromamba'
export MAMBA_ROOT_PREFIX="$HOME/micromamba"

micromamba() {
  unfunction micromamba 2>/dev/null

  if [[ -x "$MAMBA_EXE" ]]; then
    local __mamba_setup
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"

    if [[ $? -eq 0 ]]; then
      eval "$__mamba_setup"
      micromamba "$@"
    else
      "$MAMBA_EXE" "$@"
    fi
  else
    print -u2 "micromamba not found: $MAMBA_EXE"
    return 127
  fi
}


# ============================================================
# Aliases
# ============================================================

alias md="mkdir"
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
alias f="fastfetch"
alias sz="source $HOME/.zshrc"
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=always"
fi

# bindkey
_lazygit_widget() {
  zle -I
  lazygit
  zle reset-prompt
}

zle -N lazygit-widget _lazygit_widget
bindkey '^G' lazygit-widget


# ============================================================
# Zinit upgradation
# ============================================================
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


# ============================================================
# Zinit plugins / OMZ migration
# ============================================================

# Oh My Zsh libraries required by migrated OMZ plugins/themes.
zinit snippet OMZL::git.zsh
zinit snippet OMZL::theme-and-appearance.zsh

# Migrated Oh My Zsh plugins/theme.
zinit snippet OMZP::git
zinit snippet OMZP::web-search
zinit snippet OMZT::gentoo

# Completion system.
autoload -Uz compinit

ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump"
mkdir -p "${ZSH_COMPDUMP:h}"

# Fast path: reuse existing compdump.
# If completion behaves incorrectly, delete ~/.cache/zsh/.zcompdump* and restart zsh.
if [[ -f "$ZSH_COMPDUMP" ]]; then
  compinit -C -d "$ZSH_COMPDUMP"
else
  compinit -d "$ZSH_COMPDUMP"
fi

# Replay compdefs collected by zinit snippets before compinit.
zinit cdreplay -q

zinit ice wait'0' lucid
zinit light zsh-users/zsh-syntax-highlighting

# zinit ice wait'0' lucid
zinit light zsh-users/zsh-autosuggestions
