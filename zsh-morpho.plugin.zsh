#
# No plugin manager is needed to use this file. All that is needed is adding:
#   source {where-zsh-morpho-is}/zsh-morpho.plugin.zsh
#
# to ~/.zshrc.
#

REPO_DIR="${0%/*}"

#
# Update FPATH if:
# 1. Not loading with Zplugin
# 2. Not having fpath already updated (that would equal: using other plugin manager)
#

if [[ -z "$ZPLG_CUR_PLUGIN" && "${fpath[(r)$REPO_DIR]}" != $REPO_DIR ]]; then
    fpath+=( "$REPO_DIR" )
fi

autoload morlib morpho
zle -N morpho
bindkey '^t' morpho
