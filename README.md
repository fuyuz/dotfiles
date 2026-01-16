# Dotfiles

このリポジトリには、macOS用の個人的なdotfilesが含まれており、様々なツールやアプリケーションの設定ファイルが含まれています。

## 概要

このdotfilesリポジトリは、macOSでの開発環境を以下の点に焦点を当てて素早くセットアップするために設計されています：

- ターミナルの生産性（zsh、neovim、fzfなど）
- ウィンドウ管理（yabai、skhd）
- 開発ツール（git、docker、clojureツールなど）
- アプリケーション設定（WezTermなど）

## コンポーネント

このリポジトリには以下の設定が含まれています：

- **シェル**: sheldonプラグインマネージャーを使用したzsh
- **ターミナル**: WezTerm
- **エディタ**: Neovim
- **ウィンドウ管理**: yabai、skhd、borders
- **プロンプト**: Starship
- **パッケージマネージャー**: Homebrew
- **バージョン管理**: mise
- **開発ツール**: git、docker、clojure-lspなど
- **アプリケーション**: Google Chrome、Obsidian、Slack、JetBrains Toolbox

## 前提条件

- macOS
- Git

## インストール

1. リポジトリをクローンします：

```bash
git clone https://github.com/fuyuz/dotfiles
cd dotfiles
```

2. セットアップスクリプトを実行します：

```bash
./setup.sh
```

これにより以下が行われます：
- Homebrewと`homebrew/Brewfile`で定義されたパッケージのインストール
- 含まれるすべてのツールの設定
- リポジトリから適切な場所へのシンボリックリンクの作成

## 個別のコンポーネント

各コンポーネントには独自のセットアップスクリプトがあり、個別に実行できます：

```bash
# 例えば、Neovimのみをセットアップする場合
./nvim/setup.nvim.sh
```

## ライセンス

[MITライセンス](LICENSE)の下で利用可能です。
