#!/bin/bash
set -uo pipefail  # No -e to support write to canary file after cancel

. "$EXTENSION_PATH/shared.sh"

HAS_SELECTION=${HAS_SELECTION:-}
RESUME_SEARCH=${RESUME_SEARCH:-}
CANARY_FILE=${CANARY_FILE:-'/tmp/canaryFile'}
QUERY=''

if [[ "$RESUME_SEARCH" -eq 1 ]]; then
    # ... or we resume the last search if that is desired
    if [[ -f "$LAST_QUERY_FILE" ]]; then
        QUERY="$(tail -n 1 "$LAST_QUERY_FILE")"
    fi
elif [[ "$HAS_SELECTION" -eq 1 ]]; then
    QUERY="$(cat "$SELECTION_FILE")"
fi

callfzf () {
    ${FZF_DEFAULT_COMMAND} \
        2> /dev/null \
    | fzf \
        --cycle \
        --multi \
        --history $LAST_QUERY_FILE \
        --query "${QUERY}"
}

VAL=$(callfzf)

if [[ -z "$VAL" ]]; then
    echo canceled
    echo "1" > "$CANARY_FILE"
    exit 1
else
    # Convert relative paths to absolute paths
    TMP=$(mktemp)
    echo "$VAL" > "$TMP"
    while IFS= read -r line; do
        if [[ "$line" = /* ]]; then
            echo "$line"
        else
            echo "$PWD/$line"
        fi
    done < "$TMP" > "$CANARY_FILE"
    rm "$TMP"
fi
