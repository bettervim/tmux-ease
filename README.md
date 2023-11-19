# tmux-ease
Simplify your tmux life with TOML and JSON configuration. Less fuss, more coding.
> 💡 Work in progress—like that side project you swear you'll finish someday.

## Installation
Run the following command in your terminal:
```sh
curl -sSL https://raw.githubusercontent.com/bettervim/tmux-ease/main/scripts/install.sh | bash
```

## Basic usage
1. Create a `~/tmux.toml` file (or `.json` if you want):
```sh
touch ~/tmux.toml
```
2. Paste the following TOML config into this file:
```toml
prefix = ["ctrl", "b"]

[options]
  history-limit = 10000
  set-titles = "on"
  set-titles-string = "λ"

[[binds]]
  key = ["h"]
  command = "select-pane -L"

[[binds]]
  key = ["L"]
  command = "resize-pane -R 15"
```
> Feel free to modify these options.

3. Paste the following command at the bottom of you `tmux.conf`:
```sh
run-shell "tmux-ease ~/tmux.toml ~/tmux-ease.conf"
source-file ~/tmux-ease.conf
```
4. Reload your tmux, and there you have it!

## Uninstalling
```
curl -sSL https://raw.githubusercontent.com/bettervim/tmux-ease/main/scripts/uninstall.sh | bash
```

## License
MIT
