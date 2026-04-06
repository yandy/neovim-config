# 快速开始指南

## 安装

### 系统要求

- **Neovim 0.13+** (必须)
- Git

### 安装步骤

#### 1. 安装 Neovim

```bash
# Arch Linux
sudo pacman -S neovim-git wl-clipboard luarocks lazygit

# 其他发行版请参考官方安装指南
```

#### 2. 克隆配置

```bash
git clone https://github.com/yandy/neovim-config.git ~/.config/nvim
```

#### 3. 启动 Neovim

```bash
nvim
```

首次启动时插件将自动安装。

### 可选依赖

- **opencode CLI**: AI 辅助工具
- **lazygit**: 终端 Git 客户端 (已集成)

---

## 快捷键参考

### Leader 键

Leader 键设置为 **空格键** (`Space`)。所有以 `<leader>` 开头的快捷键都需要先按空格键。

### 文件导航

| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 打开/关闭文件浏览器 |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全文搜索 (grep) |
| `<leader>fb` | 查找缓冲区 |
| `<leader>fh` | 查找帮助 |

### LSP 快捷键

| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gr` | 显示引用 |
| `gI` | 跳转到实现 |
| `gy` | 跳转到类型定义 |
| `K` | 显示悬停文档 |
| `<leader>rn` | 重命名符号 |
| `<leader>ca` | 代码操作 |
| `<leader>f` | 格式化代码 (正常/可视模式) |
| `[d` | 上一个诊断 |
| `]d` | 下一个诊断 |
| `<leader>q` | 诊断列表 |

### DAP 调试快捷键

| 快捷键 | 功能 |
|--------|------|
| `<F5>` | 继续/开始调试 |
| `<F10>` | 单步跳过 (step over) |
| `<F11>` | 单步进入 (step into) |
| `<F12>` | 单步跳出 (step out) |
| `<leader>b` | 切换断点 |
| `<leader>B` | 设置条件断点 |
| `<leader>du` | 切换 DAP UI |
| `<leader>dt` | 终止调试 |
| `<leader>dh` | 调试变量悬停 |
| `<leader>dp` | 调试变量预览 |
| `<leader>dr` | 打开 DAP REPL |

### 布局切换

| 快捷键 | 功能 |
|--------|------|
| `<leader>lm` | 最大化编辑器 |
| `<leader>lt` | 终端主导布局 |
| `<leader>ld` | 调试模式布局 |
| `<leader>lr` | 恢复上一个布局 |

### AI 助手 (Opencode)

| 快捷键 | 功能 |
|--------|------|
| `<C-a>` | 询问当前上下文 |
| `<C-x>` | 打开操作选择器 |
| `<C-.>` | 切换 Opencode 界面 |
| `gO` | 操作符模式 (添加范围到上下文) |
| `<leader>ox` | 解释代码 |
| `<leader>of` | 修复代码 |
| `<leader>oi` | 实现功能 |
| `<leader>or` | 代码审查 |

### Git

| 快捷键 | 功能 |
|--------|------|
| `<leader>gg` | 打开 LazyGit |

### 终端

| 快捷键 | 功能 |
|--------|------|
| `<leader>tt` | 浮动终端 |
| `<leader>th` | 水平分割终端 |
| `<leader>tv` | 垂直分割终端 |

### 基础操作

| 快捷键 | 功能 |
|--------|------|
| `<leader>w` | 保存 |
| `<leader>q` | 退出 |
| `<leader>x` | 保存并退出 |
| `<leader>v` | 垂直分割 |
| `<leader>s` | 水平分割 |
| `<leader>h` | 清除搜索高亮 |
| `<leader>r` | 重新加载配置 |
| `<C-s>` | 保存 |
| `<C-q>` | 退出 |

### 窗口导航

| 快捷键 | 功能 |
|--------|------|
| `<C-h>` | 左侧窗口 |
| `<C-j>` | 下方窗口 |
| `<C-k>` | 上方窗口 |
| `<C-l>` | 右侧窗口 |

### 缓冲区导航

| 快捷键 | 功能 |
|--------|------|
| `<S-h>` | 上一个缓冲区 |
| `<S-l>` | 下一个缓冲区 |
| `<leader>bn` | 下一个缓冲区 |
| `<leader>bp` | 上一个缓冲区 |

---

## 功能概览

### LSP (语言服务器协议)

内置 LSP 支持，提供：
- 代码补全
- 跳转定义/引用/实现
- 悬停文档
- 代码诊断
- 重命名符号
- 代码格式化

支持的语言：Python、TypeScript/JavaScript、C/C++ 等。

### DAP (调试适配器协议)

集成调试功能：
- 断点管理
- 单步调试
- 变量查看
- REPL 交互
- 调试 UI

### 代码补全

使用 blink.cmp 提供智能代码补全，与 LSP 深度集成。

### AI 助手

Opencode.nvim 提供：
- 代码解释
- Bug 修复建议
- 功能实现辅助
- 代码审查
- 上下文感知 (@this, @buffer, @diagnostics)

### 文件浏览器

Snacks.nvim 集成的文件浏览器：
- 树状结构
- Git 状态显示
- 文件操作 (创建、删除、重命名)

### 搜索功能

快速搜索工具：
- 文件搜索
- 全文 grep
- 缓冲区搜索
- 帮助文档搜索

### Git 集成

LazyGit 终端 Git 客户端：
- 提交管理
- 分支操作
- 暂存/取消暂存
- 冲突解决

---

## 故障排除

### 常见问题

#### 插件安装失败

```bash
# 在 Neovim 中运行
:Lazy sync
```

#### LSP 无法启动

```bash
# 检查 LSP 服务器是否安装
:LspInfo

# 使用 Mason 安装 LSP 服务器
:Mason
```

#### 诊断信息不显示

```bash
# 检查诊断配置
:lua vim.diagnostic.config()

# 手动刷新诊断
:lua vim.diagnostic.enable()
```

#### AI 助手无法连接

确保 opencode 服务正在运行：
```bash
# 检查服务状态
# 根据 opencode 文档启动服务
```

### 健康检查

运行 Neovim 内置健康检查：
```bash
:checkhealth
```

### 重新加载配置

修改配置后无需重启：
```bash
<leader>r
```

### 获取帮助

- `:help` - 内置帮助
- `:help <主题>` - 特定主题帮助
- `:tutor` - Neovim 内置教程
