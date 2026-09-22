# homebrew-yunku

够快云库命令行工具 [yunku-cli](https://github.com/gokuai/yunku-cli)（`ykc`）的 Homebrew Tap。

## 安装

```sh
brew tap gokuai/yunku
brew install yunku-cli
```

或者直接安装：

```sh
brew install gokuai/yunku/yunku-cli
```

安装完成后验证：

```sh
ykc --help
```

## 安装内容

本 Formula 会完成以下工作：

1. 安装 `ykc` 二进制文件到 Homebrew 的 `bin` 目录。
2. 将 `ykc` 技能包安装到 `$(brew --prefix)/share/yunku-cli/skills/ykc`。
3. 在 `post_install` 阶段，自动把技能包复制到本机已存在的各类 AI 编程助手的技能目录，包括：

   - `~/.agents/skills/ykc`
   - `~/.claude/skills/ykc`
   - `~/.cursor/skills/ykc`
   - `~/.gemini/skills/ykc`
   - `~/.codex/skills/ykc`
   - `~/.github/skills/ykc`
   - `~/.windsurf/skills/ykc`
   - `~/.augment/skills/ykc`
   - `~/.cline/skills/ykc`
   - `~/.amp/skills/ykc`
   - `~/.kiro/skills/ykc`
   - `~/.trae/skills/ykc`
   - `~/.openclaw/skills/ykc`

   未创建的助手目录会被跳过（`~/.agents` 除外，始终安装）。

## 升级

```sh
brew upgrade yunku-cli
```

## 卸载

```sh
brew uninstall yunku-cli
brew untap gokuai/yunku   # 可选，移除本 Tap
```

注意：卸载不会自动清理已复制到各 AI 助手目录下的 `skills/ykc`，如需彻底移除请手动删除对应目录。

## 支持平台

目前仅提供 macOS x86_64（darwin-amd64）的预编译包。

## 相关链接

- CLI 源码与文档：<https://github.com/gokuai/yunku-cli>
- 问题反馈：<https://github.com/gokuai/homebrew-yunku/issues>

## 许可证

Apache-2.0
