#!/usr/bin/env bash
set -euo pipefail

BINARY="$HOME/.local/bin/cosmic-app-switcher"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "cosmic-app-switcher status"
echo "──────────────────────────"

# Binary
if [ -f "$BINARY" ]; then
    echo "Binary:    installed ($BINARY)"
else
    echo "Binary:    NOT installed (run 'make install')"
fi

# Shortcuts config
CONFIG=$("$SCRIPT_DIR/find-config.sh" 2>/dev/null) || CONFIG=""
if [ -z "$CONFIG" ]; then
    echo "Config:    COSMIC shortcuts config not found"
else
    echo "Config:    $CONFIG"
    if grep -q "cosmic-app-switcher" "$CONFIG" 2>/dev/null; then
        echo "Shortcuts: enabled"
    else
        echo "Shortcuts: disabled"
    fi
fi

# Build
if [ -f "$(dirname "$SCRIPT_DIR")/target/release/cosmic-app-switcher" ]; then
    echo "Build:     present (target/release/)"
else
    echo "Build:     not built (run 'make build')"
fi
