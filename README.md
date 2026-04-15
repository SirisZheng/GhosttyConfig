# Ghostty Config

我个人的 [Ghostty](https://ghostty.org) 终端配置，连同围绕它搭建的 zsh / prompt / 命令行现代化工具链。

> macOS 专属。Linux 大部分配置可复用，但毛玻璃、`macos-*` 系列选项需要去掉。

---

## 这里有什么

```
.
├── config/
│   ├── ghostty/config       # Ghostty 主配置（字体、主题、窗口、快捷键、Quick Terminal）
│   ├── starship.toml        # Starship prompt 配置（Nerd Font 图标 + 右侧时钟）
│   └── atuin/config.toml    # Atuin shell 历史配置
└── zshrc                    # ~/.zshrc，串起 starship / fzf / zoxide / eza / bat / atuin / 高亮插件
```

---

## 整体技术栈

| 层 | 工具 | 用途 |
|---|---|---|
| 终端 | **Ghostty** | GPU 加速、原生 macOS UI、毛玻璃背景 |
| 字体 | **Maple Mono NF CN** | 等宽 + Nerd Font 图标 + 中文字形 |
| Shell | zsh（macOS 自带） | — |
| Prompt | **Starship** | 跨 shell、快、Nerd Font 图标 |
| 历史搜索 | **Atuin** | SQLite 历史，按 git repo / 退出码过滤 |
| 模糊搜索 | **fzf** | `Ctrl+T` 文件、`Alt+C` 目录 |
| 智能 cd | **zoxide** | `z <关键字>` 跳转高频目录 |
| ls / cat | **eza / bat** | 带图标、颜色、git 状态、语法高亮 |
| zsh 增强 | **zsh-autosuggestions** | 灰字历史补全 |
| zsh 增强 | **zsh-syntax-highlighting** | 命令实时语法高亮 |

---

## 安装

### 1. Ghostty 本体

从 [ghostty.org](https://ghostty.org) 下载 macOS 安装包，或：

```bash
brew install --cask ghostty
```

### 2. 字体

```bash
brew install --cask font-maple-mono-nf-cn
```

> 想换其他字体只需在 `config/ghostty/config` 里改 `font-family` 这一行。

### 3. 命令行工具链

一次性装齐：

```bash
brew install \
  starship \
  fzf \
  zoxide \
  eza \
  bat \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  atuin
```

各工具说明：

- **starship** — Prompt
- **fzf** — 模糊搜索（`Ctrl+T` / `Alt+C` 等）
- **zoxide** — `z` 智能 cd
- **eza** — `ls` 替代，带图标、git 状态
- **bat** — `cat` 替代，带语法高亮
- **zsh-autosuggestions** — 灰字历史补全
- **zsh-syntax-highlighting** — 命令实时语法高亮
- **atuin** — 历史搜索 + 元数据 + 可选同步

### 4. 应用配置

```bash
# Ghostty
mkdir -p ~/.config/ghostty
cp config/ghostty/config ~/.config/ghostty/config

# Starship
cp config/starship.toml ~/.config/starship.toml

# Atuin
mkdir -p ~/.config/atuin
cp config/atuin/config.toml ~/.config/atuin/config.toml

# zsh
cp zshrc ~/.zshrc
```

或者用软链方便后续 `git pull` 自动生效：

```bash
ln -sf "$PWD/config/ghostty/config"    ~/.config/ghostty/config
ln -sf "$PWD/config/starship.toml"     ~/.config/starship.toml
ln -sf "$PWD/config/atuin/config.toml" ~/.config/atuin/config.toml
ln -sf "$PWD/zshrc"                    ~/.zshrc
```

### 5. 导入现有 zsh 历史到 Atuin

```bash
atuin import auto
```

### 6. 重启 shell

```bash
exec zsh
```

或者直接重启 Ghostty。

---

## 关键配置说明

### Ghostty (`config/ghostty/config`)

- **字体**：Maple Mono NF CN，13pt，连字（`+calt` `+liga`）+ 加粗渲染
- **主题**：跟随系统亮暗自动切换 — `light:Tomorrow,dark:Tomorrow Night`
- **窗口**：160×50 初始大小、毛玻璃（opacity 0.88 + blur 20）、原生 tab 栏
- **Quick Terminal**：`` Cmd+` `` 全局热键唤起下拉终端（首次使用需在系统设置中授予辅助功能权限）
- **Shell Integration**：`cursor,sudo,title,ssh-env,ssh-terminfo` —— SSH 时自动同步 terminfo 到远程
- **快捷键**：
  - `Cmd+T` 新 tab
  - `Cmd+D` / `Cmd+Shift+D` 右/下分屏
  - `Cmd+Alt+方向键` 切换 split
  - `Cmd+Shift+Enter` 临时全屏化当前 split
  - `Cmd+Shift+R` 重载配置

### Starship (`config/starship.toml`)

基于官方 `nerd-font-symbols` 预设，加了：

- 右侧实时时钟（`HH:MM:SS`，灰色）
- `cmd_duration` 阈值降到 500ms（更灵敏）

### Atuin (`config/atuin/config.toml`)

- **`Ctrl+R`** → 全局历史
- **`↑`** → 当前 git repo 内的命令（不在 repo 里 fallback 到当前目录）
- 完全本地，未启用云同步

### zshrc

干净的纯 zsh 配置，按顺序加载：

1. 历史去重 + 共享
2. 补全（`compinit`）
3. Starship prompt
4. fzf shell integration
5. zoxide
6. eza / bat 别名
7. zsh-autosuggestions
8. Atuin
9. zsh-syntax-highlighting（必须最后加载）

---

## 常用快捷键速查

### Ghostty

| 键 | 作用 |
|---|---|
| `Cmd+T` / `Cmd+W` | 新建 / 关闭 tab 或 split |
| `Cmd+D` / `Cmd+Shift+D` | 右 / 下 分屏 |
| `Cmd+Alt+←↑→↓` | 切换 split 焦点 |
| `Cmd+Shift+Enter` | 当前 split 临时全屏 |
| `Cmd+Shift+,` / `Cmd+Shift+R` | 重载配置 |
| `` Cmd+` ``（全局） | 召唤/隐藏 Quick Terminal |
| `Cmd+K` | 清屏 |

### Shell

| 键 | 作用 |
|---|---|
| `Ctrl+R` | Atuin 全局历史搜索 |
| `↑` | Atuin 按 git repo 范围历史搜索 |
| `Ctrl+T` | fzf 当前目录文件搜索 |
| `Alt+C` | fzf 子目录跳转 |
| `→` / `End` | 采纳 zsh-autosuggestions 灰字补全 |
| `z <关键字>` | zoxide 智能 cd |

---

## 备注

- `~/.zprofile` 不在此 repo 内（含个人 PATH、JAVA_HOME、代理等环境变量），按需自行管理
- Atuin 默认未开启云同步，需要的话跑 `atuin register -u <user> -e <email>` 然后 `atuin sync`
- Quick Terminal 全局热键首次使用需在 `系统设置 → 隐私与安全 → 辅助功能` 中授权 Ghostty
