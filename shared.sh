#!/bin/bash

# ---------- execute immediately ----------
# Code below gets executed as soon as this script is sourced. Think wisely!

# ---------- Set up an array for type filtering in rg
IFS=: read -r -a TYPE_FILTER <<< "${TYPE_FILTER:-}"
TYPE_FILTER_ARR=()
for ENTRY in ${TYPE_FILTER[@]+"${TYPE_FILTER[@]}"}; do
    TYPE_FILTER_ARR+=("--type")
    TYPE_FILTER_ARR+=("$ENTRY")
done

# Parse fzf version
FZF_VER=$(fzf --version)
FZF_VER_NUM=$(echo "$FZF_VER" | awk '{print $1}') # get rid of "... (brew)", for example
# shellcheck disable=SC2034
FZF_VER_PT1=${FZF_VER:0:3}
# shellcheck disable=SC2034
FZF_VER_PT2=${FZF_VER:3:1}
