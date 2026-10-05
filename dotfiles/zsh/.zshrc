# ==============================================================================
# 1. 環境変数 & PATH
# ==============================================================================
export LANG=ja_JP.UTF-8
export EDITOR="micro"

# ~/.local/bin への PATH 通し
typeset -U path
path=($HOME/.local/bin $path)
export PATH

# ==============================================================================
# 2. 基本機能 & 履歴 (History) 設定
# ==============================================================================
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 履歴設定のカスタマイズ
setopt share_history           # 複数のターミナル間で履歴をリアルタイム共有
setopt hist_ignore_all_dups    # 重複するコマンド行は古い方を削除
setopt hist_ignore_space       # 先頭にスペースを入れたコマンドは履歴に残さない
setopt hist_reduce_blanks      # 余分な空白を詰めて保存
setopt hist_save_no_dups       # 重複するコマンドは保存しない

# ディレクトリ移動の快適化
setopt auto_cd                 # ディレクトリ名だけで cd
setopt auto_pushd              # cd 時に自動でディレクトリスタックに積む
setopt pushd_ignore_dups       # スタックの重複を防止

# ==============================================================================
# 3. 補完機能 (Completion)
# ==============================================================================
autoload -Uz compinit && compinit -C

# 補完時のメニュー選択を有効化（矢印キーで選べる）
zstyle ':completion:*' menu select
# 補完で小文字と大文字を区別しない（小文字を入力しても大文字にマッチ）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完リストの色付け
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ==============================================================================
# 4. エイリアス (Aliases)
# ==============================================================================
# 基本コマンドの置き換え（安全対策 & 高機能化）
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# インストール済みのモダンツールを活用
alias ls='ls --color=auto'
alias ll='ls -la'
alias cat='bat'

# zsh 固有の便利なショートカット
alias -g G='| grep'
alias -g L='| less'

# ==============================================================================
# 5. 外部ツール連携 (zoxide, fzf など)
# ==============================================================================
# zoxide
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ==============================================================================
# 6. プロンプト設定
# ==============================================================================
autoload -Uz colors && colors

# プロンプト定義: taro@my-debian:~
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f '
