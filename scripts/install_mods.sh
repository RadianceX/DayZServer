#!/usr/bin/env bash
set -euo pipefail

print_help() {
    echo 'DayZ mod installer — downloads mods via steamcmd and rsyncs them to destination directory'
    echo 'Usage: ./install_mods.sh "<semicolon-separated mod ids> "<destination directory>"'
    echo 'Env expected: STEAM_CMD_USER, STEAM_CMD_PASSWORD'
}

WORKSHOP_APP_ID=${WORKSHOP_APP_ID:-221100}

# Accept mod IDs and installation root as arguments
RAW_IDS=${1:-}
DST_ROOT=${2:-}

# Skip if no mods to install
if [ -z "$RAW_IDS" ]; then
  echo "No mods to install. Skipping..."
  exit 0
fi

# Fail if target dir does not exist
if [ ! -d "$DST_ROOT" ]; then
  print_help
  exit 1
fi

# Normalize separators: turn semicolons into spaces, then split into array
RAW_IDS="${RAW_IDS//;/ }"
read -ra MOD_IDS <<< "$RAW_IDS"

echo "Installing ${#MOD_IDS[@]} mods..."

# Build steamcmd arguments
STEAMCMD_CMD=(+login "${STEAM_CMD_USER}")
for MOD_ID in "${MOD_IDS[@]}"; do
  STEAMCMD_CMD+=(+workshop_download_item ${WORKSHOP_APP_ID} ${MOD_ID})
done
STEAMCMD_CMD+=(+quit)

# Run steamcmd
steamcmd ${STEAMCMD_CMD[*]}

# Rsync downloaded mods into the destination root
mkdir -p "$DST_ROOT"

for MOD_ID in "${MOD_IDS[@]}"; do
  SRC="/root/.steam/SteamApps/workshop/content/${WORKSHOP_APP_ID}/${MOD_ID}"
  
  if [ ! -d "$SRC" ]; then
    echo "Error: Mod directory not found: $SRC"
    exit 1
  fi
  
  DEST="$DST_ROOT/$MOD_ID"
  mkdir -p "$DEST"
  rsync -a --delete -- "$SRC/" "$DEST/"
  
  # Set ownership for container user
  chown -R 1000:1000 "$DEST" 2>/dev/null || true
done

echo "Mods installed successfully"
exit 0
