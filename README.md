# nvim-config
Configuration files for my personal nvim setup

<div align="center">
    <img src="./nvim.png?raw=true" alt="DAC connections" width="100%" />
</div>

*Inspired by [@typecraft](https://www.youtube.com/@typecraft_dev)*

## Requirements
I am running NVIM v0.9.4, but dependencies could change in the future. If using a Mac, `brew install neovim` is a good option for sourcing nvim.

I was unsuccessful in getting this configuration to work in the default Mac Terminal (in an acceptible state), so I recommend using a third-party terminal emulator that supports advanced terminal color features. I use [iTerm2](https://iterm2.com/), but [Kitty](https://sw.kovidgoyal.net/kitty/) and [Alacritty](https://alacritty.org/) should work as well (untested).

## Installation
Before installing, save a backup of your previous nvim configuration if desired, and then delete the directory if it exists.
```sh
rm -rf ~/.config/nvim
```
Now you can download the repository.
```sh
git clone https://github.com/N8WM/nvim-config.git ~/.config/nvim
```
The first time running nvim after this command should install all dependencies and packages. The only thing left to do is to register your GitHub Copilot account (if you have one) with the command `:Copilot auth`.

## Note
I recommend using [DroidSansMono NerdFont](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DroidSansMono.zip) (from [nerdfonts.com](https://www.nerdfonts.com/font-downloads)) in your terminal emulator.
