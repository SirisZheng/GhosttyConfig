# Starship 交互式 shell 配置
# ---- 历史 ----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS      # 重复命令去重
setopt HIST_IGNORE_SPACE         # 空格开头不入历史
setopt SHARE_HISTORY             # 多终端共享历史
setopt EXTENDED_HISTORY          # 记录时间戳

# ---- 补全 ----
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ---- Prompt: Starship ----
eval "$(starship init zsh)"

# ---- fzf: 模糊搜索 (Ctrl+R 历史, Ctrl+T 文件, Alt+C 目录) ----
source <(fzf --zsh)

# ---- zoxide: 智能 cd (z <关键字> 跳转) ----
eval "$(zoxide init zsh)"

# ---- eza: ls 替代 ----
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first --git'
alias la='eza -lah --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons --group-directories-first'

# ---- bat: cat 替代 ----
alias cat='bat --style=plain --paging=never'
alias less='bat --paging=always'
export BAT_THEME='TwoDark'

# ---- zsh-autosuggestions: 灰字历史补全 ----
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ---- Atuin: 历史搜索 (Ctrl+R 接管, 上箭头保持原生) ----
eval "$(atuin init zsh)"

# ---- zsh-syntax-highlighting: 命令语法高亮 (必须放最后) ----
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
