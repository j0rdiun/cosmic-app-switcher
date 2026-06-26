#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG=$("$SCRIPT_DIR/find-config.sh") || exit 1

if ! grep -q "cosmic-app-switcher" "$CONFIG"; then
    echo "Already disabled."
    exit 0
fi

TMPFILE=$(mktemp)
grep -v "cosmic-app-switcher" "$CONFIG" > "$TMPFILE"
mv "$TMPFILE" "$CONFIG"

echo "Disabled. COSMIC default switcher restored."
