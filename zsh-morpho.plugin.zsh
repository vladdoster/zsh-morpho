#
# No plugin manager is needed to use this file. All that is needed is adding:
#   source {where-zsh-morpho-is}/zsh-morpho.plugin.zsh
#
# to ~/.zshrc.
#
# Available zstyles. Given values are the defaults
# zstyle ":morpho" screen-saver "zmorpho" # select screen-saver "zmorpho"; available: zmorpho, zmandelbrot, zblank, pmorpho
#                                         # this  can also be a command, e.g. "cmatrix"
# zstyle ":morpho" delay "290"            # 5 minutes before screen-saver starts
# zstyle ":morpho" check-interval "60"    # check every 1 minute if to run screen-saver
# zstyle ":morpho" redraw-delay "300"     # how often screen-saver redraws

REPO_DIR="${0%/*}"

#
# Update FPATH if:
# 1. Not loading with Zplugin
# 2. Not having fpath already updated (that would equal: using other plugin manager)
#

if [[ -z "$ZPLG_CUR_PLUGIN" && "${fpath[(r)$REPO_DIR]}" != $REPO_DIR ]]; then
    fpath+=( "$REPO_DIR" )
fi

# Using sched module
zmodload zsh/sched

# Autoloads
autoload add-zsh-hook

# Extend path
path+=( "$REPO_DIR" )

# Global variables
typeset -g morpho_check_interval
zstyle -s ':morpho' check-interval morpho_check_interval || morpho_check_interval=60

# Marks a shell that runs a command (i.e. displays a prompt)
# as active, so that the screen saver will be run only there
-morpho-active() {
    echo "$$\\n$(date +%s)" > /tmp/morpho-active-shell
}

# Called periodically
-morpho-check-run-screen-saver() {
    typeset -a shell_data
    shell_data=( "${(@f)"$(</tmp/morpho-active-shell)"}" )

    # Only run screen-saver in last active shell
    # (in shell where prompt has been redrawn last)
    if [ "${shell_data[1]}" != "$$" ]; then
        sched +$morpho_check_interval -morpho-check-run-screen-saver
        return
    fi

    integer active_timestamp=${shell_data[2]}
    integer current_timestamp=$(date +%s)

    # Load expected delay
    integer delay
    zstyle -s ':morpho' delay delay || delay=290

    if (( current_timestamp - active_timestamp > delay )); then
        # Load wanted screen saver
        local screen_saver
        zstyle -s ':morpho' screen-saver screen_saver || screen_saver="zmorpho"
        "$screen_saver"
    fi

    sched +$morpho_check_interval -morpho-check-run-screen-saver
}

sched +$morpho_check_interval -morpho-check-run-screen-saver

# Redraw of prompt will trigger marking shell as active
add-zsh-hook precmd -morpho-active
