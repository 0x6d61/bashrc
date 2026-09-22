# bashrc

共通の Bash 設定を管理するリポジトリです。リポジトリは隠しディレクトリ
`~/.bashrc.d` に clone し、`~/.bashrc` はここを読み込むだけの小さな
ローダーとして扱います。

## インストール

```bash
git clone https://github.com/0x6d61/bashrc.git ~/.bashrc.d
bash ~/.bashrc.d/install.sh
source ~/.bashrc
```

インストーラーは既存の `~/.bashrc` をローダーで直接置き換えます。

## 設定の置き場所

- `~/.bashrc.d/.bashrc`: Git で管理する、全マシン共通の設定
- `~/.bashrc.local`: Git 管理しない、マシン固有の設定

マシン固有の設定を始めるには、次を実行します。

```bash
cp ~/.bashrc.d/.bashrc.local.example ~/.bashrc.local
```

たとえば、仕事用の `PATH`、そのPCにしかないコマンドの alias、秘密情報を
参照する環境変数は `~/.bashrc.local` に置きます。共通設定は
`~/.bashrc.d/.bashrc` を編集して commit してください。以後は
`git -C ~/.bashrc.d pull` で共通設定を取り込めます。
