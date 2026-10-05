# dotfiles

Raspberry Pi OS（Debian）向けの自動環境構築 ＆ GNU Stow ドットファイル管理リポジトリ。

## 管理ツール一覧

- **zsh**: 拡張シェル (`apt`)
- **tmux**: ターミナルマルチプレクサ (`apt`)
- **fzf**: ファジーファインダー (`git clone` 最新版)
- **micro**: テキストエディタ (公式バイナリ 最新版)
- **ripgrep**: 高速検索 (`apt`)
- **fd-find**: 検索ツール (`apt`, エイリアス: `fd`)
- **bat**: シンタックスハイライト付き cat (`apt`, エイリアス: `bat`)
- **zoxide**: ディレクトリ高速移動 (`apt`)
- **tree**: ディレクトリ階層表示 (`apt`)
- **stow**: ドットファイル管理 (`apt`)

## クイックスタート

```bash
curl -fsSL https://raw.githubusercontent.com/saito-programming/dotfiles/main/bootstrap.sh | bash
```

## ディレクトリ構成

```text
~/dotfiles/
├── bootstrap.sh
├── README.md
├── zsh/
│   └── .zshrc
├── tmux/
│   └── .tmux.conf
├── micro/
│   └── .config/micro/
├── fzf/
├── ripgrep/
├── fd/
├── bat/
├── zoxide/
├── tree/
└── stow/
```
