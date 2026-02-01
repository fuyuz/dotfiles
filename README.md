# Dotfiles

macOS用のdotfiles。**Nix Flakes** + **nix-darwin** + **home-manager**で宣言的に管理。

## 特徴

- 宣言的・再現可能な環境構築
- `nix flake update`で全依存関係を一括更新
- flake.lockによるバージョン固定
- symlinkスクリプト不要（Nixが管理）

## コンポーネント

- **シェル**: zsh + starship（home-manager管理）
- **ターミナル**: WezTerm
- **エディタ**: Neovim
- **ウィンドウ管理**: Hammerspoon
- **CLIツール**: fzf, eza, bat, ripgrep, fd, jq, lazygit, btop
- **開発ツール**: git, gh, delta
- **バージョン管理**: mise

## ディレクトリ構成

```
dotfiles/
├── flake.nix              # Flake定義（inputs/outputs）
├── flake.lock             # バージョンロックファイル
├── setup.sh               # セットアップスクリプト
│
├── nix/
│   ├── darwin/            # macOS固有設定（nix-darwin）
│   │   ├── default.nix    # システム設定
│   │   ├── homebrew.nix   # GUI casks管理
│   │   └── services/
│   │
│   └── home/              # ユーザー設定（home-manager）
│       ├── default.nix
│       ├── shell/         # zsh, starship
│       ├── programs/      # git, neovim, cli-tools
│       └── files/         # 設定ファイルsymlink
│
└── configs/               # 実際の設定ファイル
    ├── nvim/init.lua
    ├── wezterm/wezterm.lua
    └── ...
```

## インストール

### 1. Nixをインストール

```bash
sh <(curl -L https://nixos.org/nix/install)
```

### 2. リポジトリをクローン

```bash
git clone https://github.com/fuyuz/dotfiles ~/dotfiles
cd ~/dotfiles
```

### 3. セットアップ実行

```bash
./setup.sh
```

## 日常のコマンド

```bash
# 設定を再適用
sudo darwin-rebuild switch --flake ~/dotfiles

# 依存関係を更新
nix flake update

# ロールバック
sudo darwin-rebuild --rollback

# ガベージコレクション
nix-collect-garbage -d
```

## カスタマイズ

- **CLIツール追加**: `nix/home/programs/cli-tools.nix`
- **シェル設定**: `nix/home/shell/zsh.nix`
- **macOS設定**: `nix/darwin/default.nix`
- **GUI casks**: `nix/darwin/homebrew.nix`

## ライセンス

[MITライセンス](LICENSE)
