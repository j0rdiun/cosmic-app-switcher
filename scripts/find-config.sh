#!/usr/bin/env bash
# Prints the path to the COSMIC system_actions shortcuts config, or exits 1 if not found.
# Searches all versioned directories so it works across COSMIC updates (v1, v2, ...).

SHORTCUTS_DIR="$HOME/.config/cosmic/com.system76.CosmicSettings.Shortcuts"

if [ ! -d "$SHORTCUTS_DIR" ]; then
    echo "Error: COSMIC shortcuts directory not found: $SHORTCUTS_DIR" >&2
    echo "Is COSMIC desktop installed and has it been opened at least once?" >&2
    exit 1
fi

# Pick the highest versioned system_actions file present
CONFIG=$(find "$SHORTCUTS_DIR" -name "system_actions" 2>/dev/null | sort -V | tail -1)

if [ -z "$CONFIG" ]; then
    echo "Error: No system_actions file found under $SHORTCUTS_DIR" >&2
    exit 1
fi

echo "$CONFIG"
