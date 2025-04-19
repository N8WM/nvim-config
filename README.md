# nvim-config
Configuration files for my personal NVIM setup

<div align="center">
    <img src="https://raw.githubusercontent.com/N8WM/nvim-config/refs/heads/main/nvim.png" alt="Example Screenshot" width="100%" />
</div>

*Inspired by [@typecraft](https://www.youtube.com/@typecraft_dev)*

> Old screenshot, need to update it

## Background
This is an attempt at making my own NVIM configuration. My goal is to be able to install this configuration on any machine in place of an IDE, without the hassle of manual configuration. The project is actively in development, but most of the essential IDE features are already present, making it more than suitable for regular use.

You may notice this project is lacking in documentation. I hope to change that soon, but for the time being, you'll find most user-customizable options, keybinds, and utilities conveniently (dis)organized under [`lua/custom/`](https://github.com/N8WM/nvim-config/tree/main/lua/custom).

Suggestions and contributions are always welcome! If you'd like to propose improvements or notice any issues, please [create a GitHub issue](https://github.com/N8WM/nvim-config/issues/new/choose). Keep in mind that since this primarily a personal project, very specific feature requests like "add the glorb theme" or "right-justify the tabs in the bufferline" may not be prioritized unless they enhance the overall configurability or align with common best practices.

## Important Information

Feel free to read through these first, but they are all included in the installation section through relative links

<details>
<summary>Terminal Emulator Compatibility</summary>
<div style="margin-left: 20px" id="emulator">
<h4>Tested and Recommended Terminal Emulators</h4>

It is important to note that many default terminal emulators are simply not compatible with NVIM. This is often the case with older terminal emulators that do not implement some of the advanced features NVIM requires. One of the most notable of these is the MacOS default Terminal application. Compatibility with NVIM can be checked with a simple Google search, but I have listed a few popular ones I am familiar with.

I recommend finding a third-party terminal emulator that supports advanced terminal color features. I use [iTerm2](https://iterm2.com/) which is exclusive to MacOS, but [Kitty](https://sw.kovidgoyal.net/kitty/) and [Alacritty](https://alacritty.org/) work well, and are also available on Windows and Linux. On Windows, I use [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701) app (wt.exe) for both PowerShell and WSL-Bash.

---
</div>
</details>

<details>
<summary>Shell Compatibility</summary>
<div style="margin-left: 20px" id="shell">

<h4>Tested Shells</h4>

NVIM is advertised to work with most shells, but I have listed a few popular ones I have tested my config with as well as the machines I used.

<div style="margin-left: 20px">

**[Bash](https://www.gnu.org/software/bash/)**  
MacOS | Linux | WSL

**[Zsh](https://www.zsh.org/)**  
MacOS | Linux

**[PowerShell 5.1 & 7.5](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell)**  
Windows 11

</div>

---
</div>
</details>

<details>
<summary>NVIM Installation</summary>
<div style="margin-left: 20px" id="nvim-installation">
<h4>NVIM Version</h4>

I am running NVIM v0.11.0, but this config should work on >=0.10.0.

<h4>Installation Methods</h4>

To install Neovim, you can:
- install from pre-built **package** on the official [Releases](https://github.com/neovim/neovim/releases/) page (use latest stable release)
- install from **source** following the official [Build](https://github.com/neovim/neovim/blob/master/BUILD.md) page
- install using system **package manager** (recommended for non-linux users)...

**Valid package managers for installing NVIM include:**
| OS | Source |
| - | - |
| MacOS | [Homebrew](https://brew.sh/) - `brew install neovim` |
| Windows 10/11 | [Scoop](https://scoop.sh/) - `scoop install main/neovim` <br/> or [Chocolatey](https://community.chocolatey.org/) - `choco install neovim` |
| Linux/WSL | Generally better to avoid using a PM \* |

*\* Linux package managers like `apt`, `yum`, `yay`, and `nix` frequently provide outdated versions of NVIM (<0.10.0). It is highly advised for Linux users to follow one of the other installation methods above.*

---
</div>
</details>

<details>
<summary>Nerd Font Installation</summary>
<div style="margin-left: 20px" id="nerdfonts">
<h4>Install a Nerd Font Typeface</h4>

Install a *Nerd Font* typeface on your terminal emulator. Without a nerd font typeface, many of the niche symbols used in NVIM will likely not display correctly.

My go-to is **JetBrainsMono Nerd Font** ([download link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip)), but you can find others at [nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads).



---
</div>
</details>

<details>
<summary>Required Dependencies</summary>
<div style="margin-left: 20px" id="dependencies">

<h4>Required Dependencies</h4>

Each of these dependencies must be installed on-device for full functionality of the NVIM configuration.

| Program | Version | Notes |
| - | - | - |
| [Neovim](https://neovim.io/) | >= 0.10.0 | needs to be built with LuaJIT<br/><b>See [NVIM Installation](#nvim-installation) for help installing</b> |
| [Git](https://git-scm.com/) | >= 2.19.0 | for partial clones support |
| [NPM](https://nodejs.org/) | *recent* | for language servers |
| [fd](https://github.com/sharkdp/fd) | *recent* | for [Telescope](https://github.com/nvim-telescope/telescope.nvim) and potentially other plugins<ul><li>[`scoop install main/fd`](https://scoop.sh/#/apps?q=fd&id=8cb4a6c7a5e3a16f8c2b227d8a163806cbdaf46f) for Windows</li><li>[`brew install fd`](https://formulae.brew.sh/formula/fd#default) for MacOS</li></ul> |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | *recent* | for [Telescope](https://github.com/nvim-telescope/telescope.nvim) and potentially other plugins<ul><li>[`scoop install main/ripgrep`](https://scoop.sh/#/apps?q=ripgrep&id=ebbf0e99a88e30daac571268174c9289b58ca39b) for Windows</li><li>[`brew install ripgrep`](https://formulae.brew.sh/formula/ripgrep#default) for MacOS</li></ul> |
| C compiler & libstdc++ | *recent* | for [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) and potentially other plugins <br/>e.g., install [GCC](https://gcc.gnu.org/install/index.html):<ul><li>[`scoop install main/gcc`](https://scoop.sh/#/apps?q=gcc&id=fd50c09a38b69bd72e3483de086df59b976dcfbd) for Windows</li><li>[`brew install gcc`](https://formulae.brew.sh/formula/gcc#default) for MacOS</li></ul> |

The following are optional.

| Program | Notes |
| - | - |
| [GitHub CLI](https://cli.github.com/) | Hover context for assigned TODO's, issues, and PR's. <ul><li>[`scoop install main/gh`](https://scoop.sh/#/apps?q=gh&id=c8cf6e5f7b3162d4cd0297d380c36f9b68e07f08)</li><li>[`brew install gh`](https://formulae.brew.sh/formula/gh#default)</li></ul> |
| [Jira CLI](https://github.com/ankitpokhrel/jira-cli) | Hover context for Jira issues<ul><li>[`scoop install extras/jira-cli`](https://scoop.sh/#/apps?q=jira&id=ff27aa7406291fe431c61dfbd643daaacec9e853)</li><li>[`brew install jira-cli`](https://formulae.brew.sh/formula/jira-cli#default)</li></ul>

---
</div>
</details>

## Installation

### Step 0: Compatibility Information
If you are new to Neovim, read the info on [Tested and Recommended Terminal Emulators](#emulator), as not all terminal apps will work.

I presume your terminal has a shell (lol), but feel free to glance through the info on [Shell Compatibility](#shell) if you are unsure of whether it is compatible, or are deciding what shell to use for your device.

---

### Step 1: Installing Nerd Font and Dependencies
Before you install the NVIM configuration files:
- [Install a Nerd Font Typeface](#nerdfonts) -- surprisingly important
- [Install All Required Dependencies](#dependencies) -- includes info on installing NVIM

---
### Step 2: Downloading the Config
This step is different depending on your operating system...
#### For Mac/Linux/WSL (Bash, Zsh, etc.):

<div style="margin-left: 20px">

First, save a backup of your previous NVIM configuration if desired. Then delete the configuration directory if it exists, with:
```sh
rm -rf ~/.config/nvim
```
Now you can download the repository.
```sh
git clone https://github.com/N8WM/nvim-config.git ~/.config/nvim
```

</div>

#### For Windows (PowerShell 5.1+):

<div style="margin-left: 20px">

First, save a backup of your previous NVIM configuration if desired. Then delete the configuration directory if it exists, with:
```powershell
rm -r -fo ~\AppData\Local\nvim
```
Now you can download the repository.
```powershell
git clone https://github.com/N8WM/nvim-config.git ~\AppData\Local\nvim
```

</div>

---
### Step 3: Booting Up for the First Time
The first time running `nvim` after this command should install all dependencies and packages. If you have GitHub Copilot, the only thing left to do is to register your account (if you have one) with the command `:Copilot auth` with NVIM running. Other than that, the installation should be complete.

<br/><br/>
## TODOs
- [ ] Set up [nvim-dap](https://github.com/mfussenegger/nvim-dap), an NVIM debugging tool
- [ ] Implement `pcall(...)` around each `require`  
  (to prevent unwanted error propagation)
- [ ] Add documentation for keybinds, options, configuration
- [ ] Refactor! :/
