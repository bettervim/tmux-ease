# tmux-ease
Simplify your tmux life with TOML and JSON configuration. Less fuss, more coding.
> 💡 Work in progress—like that side project you swear you'll finish someday.

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

2. Paste the following command at the bottom of you `tmux.conf`:
```sh
tmux-ease ~/tmux.toml ~/tmux-ease.conf
source ~/tmux-ease.conf
```
3. Reload your tmux, and there you have it!

## License
MIT
