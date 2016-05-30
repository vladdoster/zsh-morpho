## Introduction

Terminal screen saver for Zshell. Implements morphogenesis and Mandelbrot
images. Written in pure Zshell (possible thanks to floating point numbers
and to `zsh/mathfunc` module). Supports running external commands, for
example `cmatrix`.

Screen saver will start after configured time, in last terminal in which
a command has been executed.

Video – view on [asciinema](https://asciinema.org/a/47242). You can resize the video by pressing `Ctrl-+` or `Cmd-+`.

[![asciicast](https://asciinema.org/a/47242.png)](https://asciinema.org/a/47242)

## Configuration

There are 4 zstyles:

```zsh
zstyle ":morpho" screen-saver "zmorpho" # select screen saver "zmorpho"; available: zmorpho, zmandelbrot, zblank
                                        # this  can also be a command, e.g. "cmatrix"
zstyle ":morpho" delay "310"            # 5 minutes before screen saver starts
zstyle ":morpho" check-interval "60"    # check every 1 minute if to run screen saver
zstyle ":morpho" redraw-delay "300"     # how often screen saver redraws
```

To test screen savers run them directly from command line, e.g. issue "`zmorpho`".

## Installation

Recommended plugin manager is `Zplugin`, but you can use any other too, and also
install with `Oh My Zsh` (by copying directory to `~/.oh-my-zsh/custom/plugins`).

### [Zplugin](https://github.com/psprint/zplugin)

Add `zplugin load psprint/zsh-morpho` to `.zshrc`.
The plugin will be loaded next time you start `Zsh`.
To update issue `zplugin update psprint/zsh-morpho` from command line.

### Zgen

Add `zgen load psprint/zsh-morpho` to `.zshrc` and issue a `zgen reset` (this
assumes that there is a proper `zgen save` construct in `.zshrc`).

### Antigen

Add `antigen bundle psprint/zsh-morpho` to `.zshrc`. There also should be
`antigen apply`.

### Oh-My-Zsh

1. `cd ~/.oh-my-zsh/custom/plugins`
2. `git clone https://github.com/psprint/zsh-morpho.git`
3. Add `zsh-morpho` to your plugin list
