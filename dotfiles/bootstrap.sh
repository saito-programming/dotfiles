#!/usr/bin/env bash
set -e

# ==========================================
# 設定: GitHubのリポジトリ情報
# ==========================================
REPO_URL="https://github.com/saito-programming/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "=== 1. システムパッケージの更新とインストール ==="
sudo apt update
sudo apt install -y \
  git \
  curl \
  zsh \
  tmux \
  ripgrep \
  fd-find \
  stow \
  tree \
  bat \
  zoxide \
  build-essential

echo "=== 2. 個別ツールの追加・最新版セットアップ ==="
mkdir -p ~/.local/bin

# PATHの追加確認
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
fi

# fd-find のエイリアス作成 (fdfind -> fd)
if [ ! -f ~/.local/bin/fd ] && command -v fdfind &> /dev/null; then
  ln -s $(which fdfind) ~/.local/bin/fd
fi

# bat のエイリアス作成 (batcat -> bat)
if [ ! -f ~/.local/bin/bat ] && command -v batcat &> /dev/null; then
  ln -s $(which batcat) ~/.local/bin/bat
fi

# micro (最新版バイナリを取得)
echo "Installing latest micro..."
cd ~/.local/bin
curl https://getmic.ro | bash
cd "$HOME"

# fzf (公式リポジトリから最新版を取得・ビルド)
if [ ! -d "$HOME/.fzf" ]; then
  echo "Installing latest fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all --no-bash --no-fish
else
  echo "Updating fzf..."
  cd ~/.fzf && git pull && ./install --all --no-bash --no-fish
  cd "$HOME"
fi

echo "=== 3. dotfiles リポジトリの準備 ==="
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles repository from $REPO_URL..."
  git clone "$REPO_URL" "$DOTFILES_DIR"
else
  echo "dotfiles repository already exists at $DOTFILES_DIR"
fi

echo "=== 4. 既存設定ファイルのバックアップ & GNU Stow の全自動適用 ==="
cd "$DOTFILES_DIR"

# Stow 実行時のコンフリクト（競合）を防ぐため、実体ファイルが存在すれば .bak にリネーム
backup_if_exists() {
  local target="$1"
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing $target to ${target}.bak"
    mv "$target" "${target}.bak"
  fi
}

backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.tmux.conf"

# dotfiles ディレクトリ内のすべてのフォルダ（ディレクトリ）を対象にして stow -R を実行
for dir in */; do
  pkg="${dir%/}"
  # .git などの隠しディレクトリを除外
  if [[ "$pkg" != .* ]]; then
    echo "Stowing $pkg..."
    stow -R "$pkg"
  fi
done

echo "=== セットアップ完了 ==="
echo "主要ツールのバージョン確認:"
echo "- micro:  $(~/.local/bin/micro -version 2>/dev/null || echo 'Not found')"
echo "- fzf:    $(~/.fzf/bin/fzf --version 2>/dev/null || echo 'Not found')"
echo "- zoxide: $(zoxide --version 2>/dev/null || echo 'Not found')"
echo ""
echo "デフォルトシェルを zsh に変更する場合は以下を実行してください:"
echo "  chsh -s \$(which zsh)"
