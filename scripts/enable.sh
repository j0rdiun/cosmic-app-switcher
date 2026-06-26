#!/usr/bin/env bash
set -euo pipefail

BINARY="$HOME/.local/bin/cosmic-app-switcher"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG=$("$SCRIPT_DIR/find-config.sh") || exit 1

if grep -q "cosmic-app-switcher" "$CONFIG"; then
    echo "Already enabled."
    exit 0
fi

if [ ! -f "$BINARY" ]; then
    echo "Warning: binary not found at $BINARY — run 'make install' first to deploy the binary."
fi

TMPFILE=$(mktemp)
sed "s|}|    WindowSwitcher: \"$BINARY\",\n    WindowSwitcherPrevious: \"$BINARY --reverse\",\n}|" "$CONFIG" > "$TMPFILE"
mv "$TMPFILE" "$CONFIG"

echo "Enabled. cosmic-comp will reload shortcuts automatically."
