# Efficienvchad

## Description

Efficienvchad Is the NVCHADification of Efficienvim. Basically Efficienvim is a neovim configuration that aims to be as minimal as possible, being highly customizable. While Efficienvchad is just Efficienvim partially integrated with nvchad-ui, to increase the aesthetics.

## Installation

Simply clone this repo into your `$HOME/.config/nvim` directory. (If you are using linux/MacOS)
```bash
git clone https://github.com/Debajyati/Efficienvchad.git ~/.config/nvim
```
If you are using windows, you have to clone this repo into your `%LOCALAPPDATA%\nvim` directory.
For cmd.exe users:
```batch
git clone https://github.com/Debajyati/Efficienvchad.git %LOCALAPPDATA%\nvim
```
For PowerShell users:
```pwsh
git clone https://github.com/Debajyati/Efficienvchad.git $env:LOCALAPPDATA\nvim
```

## TREE STRUCTURE OF THE REPO

### DIRECTORIES

```
├───after
│   └───ftplugin
└───lua
    ├───config
    ├───extras
    └───plugins
```

### FULL TREE STRUCTURE
```
 .
├──  after
│   └──  ftplugin
│       └──  markdown.lua
├──  lua
│   ├──  config
│   │   ├──  autocmds.lua
│   │   ├──  keymaps.lua
│   │   ├──  lazy.lua
│   │   ├──  lspsettings.lua
│   │   ├──  noicesettings.lua
│   │   ├──  notify-settings.lua
│   │   ├──  options.lua
│   │   ├──  telescope.lua
│   │   └──  terminal.lua
│   ├──  extras
│   │   ├──  firenvim.lua
│   │   └──  supermaven.lua
│   ├──  plugins
│   │   ├──  base.lua
│   │   └──  nvui.lua
│   ├──  chadrc.lua
│   └──  nvconfig.lua
└──  init.lua
```
* The `├──  after` directory is for all the files that must be loaded after the `init.lua` file.
* The `├──  after/ftplugin` directory is for all the different filetype specific configurations, must be loaded after the `init.lua` file.
* The `├──  lua` directory contains all the lua files that are sourced by the `init.lua` file.
* The `├──  chadrc.lua` file is the place to store your custom nvchad ui configurations.
* The `├──  nvconfig.lua` file is where your default nvchad configurations are stored. It's better not to edit this file directly if you are not sure, instead use the `chadrc.lua` file.
* The `├──  init.lua` file is the main file that is loaded by neovim. It's where you can `require('module-name')` your custom configurations.
* The `├──  lua/config` directory is where the Efficienvim's configurations are stored.
* The `├──  lua/extras` directory is where you must put all the extra plugins, your own custom modules that you want Efficienvim to load.
* The `├──  lua/plugins` directory is where Efficienvim's default plugins are stored. It's better not to edit this directory directly, instead use the `├──  lua/extras` directory. Trying to alter the files inside can break the config.
* The `├──  lua/plugins/base.lua` file contains the base plugins ( and configurations ) for Efficienvim.
* The `├──  lua/plugins/nvui.lua` file contains the nvchad-ui plugins ( and configurations ) for Efficienvim that make the UI partially look like the one of nvchad.
## License

MIT
