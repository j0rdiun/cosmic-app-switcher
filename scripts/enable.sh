#!/usr/bin/env bash
set -euo pipefail

BINARY="$HOME/.local/bin/cosmic-app-switcher"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_CONFIG="$HOME/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/system_actions"

CONFIG=$("$SCRIPT_DIR/find-config.sh" 2>/dev/null) || CONFIG=""

if [ ! -f "$BINARY" ]; then
    echo "Warning: binary not found at $BINARY — run 'make install' first to deploy the binary."
fi

if [ -z "$CONFIG" ]; then
    mkdir -p "$(dirname "$DEFAULT_CONFIG")"
    printf '{\n    WindowSwitcher: "%s",\n    WindowSwitcherPrevious: "%s --reverse",\n}\n' "$BINARY" "$BINARY" > "$DEFAULT_CONFIG"
    echo "Created $DEFAULT_CONFIG and enabled. cosmic-comp will reload shortcuts automatically."
    exit 0
fi

if grep -q "cosmic-app-switcher" "$CONFIG"; then
    echo "Already enabled."
    exit 0
fi

TMPFILE=$(mktemp)
sed "s|}|    WindowSwitcher: \"$BINARY\",\n    WindowSwitcherPrevious: \"$BINARY --reverse\",\n}|" "$CONFIG" > "$TMPFILE"
mv "$TMPFILE" "$CONFIG"

echo "Enabled. cosmic-comp will reload shortcuts automatically."
