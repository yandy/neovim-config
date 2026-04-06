# Neovim 配置

## 快速开始

### 安装 Neovim

```sh
# Arch
sudo pacman -S neovim-git wl-clipboard luarocks
```

### 安装配置

```sh
git clone https://github.com/yandy/neovim-config.git ~/.config/nvim
```

### 启动

```sh
nvim          # 启动 neovim
nvim <file>   # 打开文件
nvim -h       # 查看帮助
```

---

## 新手入门

### 三种核心模式

| 模式 | 进入方式 | 用途 |
|------|----------|------|
| **Normal** | `Esc` | 默认模式，用于导航和操作 |
| **Visual** | `v` | 可视模式，用于选中文本 |
| **Insert** | `i` | 输入模式，用于编辑文本 |
| **Command** | `:` | 命令模式，用于保存、退出等 |

**新手口诀：**
1. `i` 打字
2. `Esc` 停止打字
3. `:wq` 保存退出

### 基础操作速查

| 操作 | 命令 |
|------|------|
| 保存 | `:w` |
| 退出 | `:q` |
| 保存并退出 | `:wq` 或 `ZZ` |
| 强制退出（不保存） | `:q!` |
| 撤销 | `u` |
| 重做 | `Ctrl + r` |

---

## 核心概念：Buffer / Window / Tab

Neovim 的多任务处理基于三个层级：

```
Tab (标签页)
└── Window (窗口/分割)
    └── Buffer (缓冲区/文件)
```

### Buffer（缓冲区）

Buffer 是加载到内存中的文件内容。

| 操作 | 命令 |
|------|------|
| 打开文件 | `:e <文件名>` |
| 列出所有 buffer | `:ls` 或 `:buffers` |
| 切换到 buffer N | `:b N` |
| 切换到下一个 buffer | `:bnext` 或 `:bn` |
| 切换到上一个 buffer | `:bprev` 或 `:bp` |
| 关闭当前 buffer | `:bd` 或 `:bdelete` |
| 强制关闭（不保存） | `:bd!` |

### Window（窗口）

Window 是屏幕的分割区域，一个 Tab 内可以有多个 Window。

| 操作 | 命令 | 快捷键 |
|------|------|--------|
| 水平分割 | `:split` | `Ctrl + w` 然后 `s` |
| 垂直分割 | `:vsplit` | `Ctrl + w` 然后 `v` |
| 切换窗口 | `Ctrl + w` 然后方向键 | `Ctrl + w` + `h/j/k/l` |
| 关闭当前窗口 | `:close` 或 `:q` | `Ctrl + w` 然后 `c` 或 `q` |
| 关闭其他窗口 | `:only` | `Ctrl + w` 然后 `o` |
| 窗口等宽 | `Ctrl + w` 然后 `=` |
| 调整窗口高度 | `Ctrl + w` 然后 `+` / `-` |
| 调整窗口宽度 | `Ctrl + w` 然后 `>` / `<` |

### Tab（标签页）

Tab 是工作区，每个 Tab 可以有独立的窗口布局。

| 操作 | 命令 | 快捷键 |
|------|------|--------|
| 新建 Tab | `:tabnew` | `:tabn` |
| 关闭 Tab | `:tabclose` | `:tabc` |
| 切换到下一个 Tab | `:tabnext` 或 `:tabn` |`gt` |
| 切换到上一个 Tab | `:tabprev` 或 `:tabp` |
| 切换到第 N 个 Tab | `:tabm N` |
| 移动当前 Tab | `:tabm +1` / `:tabm -1` |
| 显示所有 Tab | `:tabs` |

---

## 快捷键速查

### 移动导航

| 操作 | 按键 |
|------|------|
| 左/下/上/右 | `h` / `j` / `k` / `l` |
| 前进/后退单词 | `w` / `b` |
| 行首/行尾 | `0` / `$` |
| 文件首/末行 | `gg` / `G` |
| 跳转到第 N 行 | `:N` 回车 或 `NgG` |
| 屏幕顶部/中间/底部 | `zt` / `zz` / `zb` |
| 匹配括号 | `%` |
| 向上/下翻屏 | `Ctrl + b` / `Ctrl + f` |
| 向上/下翻半屏 | `Ctrl + u` / `Ctrl + d` |

### 编辑操作

| 操作 | 按键 |
|------|------|
| 删除字符 | `x` |
| 删除整行 | `dd` |
| 删除到行尾 | `D` |
| 复制整行 | `yy` |
| 粘贴到下方 | `p` |
| 粘贴到上方 | `P` |
| 撤销 | `u` |
| 重做 | `Ctrl + r` |
| 重复上次操作 | `.` |

### 可视模式

| 操作 | 按键 |
|------|------|
| 字符选择 | `v` |
| 行选择 | `V` |
| 块选择 | `Ctrl + v` |
| 全选 | `ggVG` |
| 缩进 | `>` / `<` |
| 注释（需插件） | `gc` |

### 查找替换

| 操作 | 命令 |
|------|------|
| 向下查找 | `/关键词` 回车 |
| 向上查找 | `?关键词` 回车 |
| 下一个匹配 | `n` |
| 上一个匹配 | `N` |
| 取消高亮 | `:noh` 回车 |
| 替换当前行 | `:s/旧/新/g` |
| 替换全文 | `:%s/旧/新/g` |
| 替换前确认 | `:%s/旧/新/gc` |

### 其他实用命令

| 操作 | 命令 |
|------|------|
| 显示行号 | `:set nu` |
| 隐藏行号 | `:set nonu` |
| 显示相对行号 | `:set rnu` |
| 启用搜索忽略大小写 | `:set ic` |
| 显示当前配置 | `:set all` |
| 查看快捷键映射 | `:map` |
| 重新加载配置 | `:source $MYVIMRC` |

---

## Neovim 特性

### 内置功能

- **LSP 支持**: 内置 Language Server Protocol，支持代码补全、跳转定义等
- **Treesitter**: 更精准的语法高亮和代码解析
- **终端集成**: `:terminal` 或 `:term` 打开内置终端
- **健康检查**: `:checkhealth` 检查配置状态
---

## 帮助资源

- `:help` - 内置帮助文档
- `:help <主题>` - 查看特定主题帮助
- `:tutor` - Neovim 内置教程（强烈推荐新手）
- [Neovim 官方文档](https://neovim.io/doc/)
- [Learn Vim Script the Hard Way](https://learnvimscriptthehardway.stevelosh.com/)


## 插件

- [lspconfig.nvim](https://github.com/neovim/nvim-lspconfig)
- nvim-dap
- mason
- [snacks.nvim](https://github.com/folke/snacks.nvim) (picker, explorer)
- oil.nvim
- blink.cmp
- opencode.nvim
