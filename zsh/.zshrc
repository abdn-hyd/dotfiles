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

zinit snippet OMZL::git.zsh
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZP::git
zinit snippet OMZP::web-search
zinit snippet OMZT::gentoo
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
autoload -Uz compinit && compinit
zinit cdreplay -q
