#!/usr/bin/env bash
set -euo pipefail

print_help() {
    echo 'Copy .bikey files from source directory and subdirectories (excluding destination) to destination'
    echo 'Usage: ./install_keys.sh "<source dir>" "<destination dir>"'
    echo 'Example: ./install_keys.sh "/server" "/server/keys"'
}

# Get paths from args
SRC_DIR=${1:-}
DST_DIR=${2:-}

if [ -z "$SRC_DIR" ] || [ ! -d "$SRC_DIR" ] || [ -z "$DST_DIR" ] || [ ! -d "$DST_DIR" ]; then
	print_help
	exit 1
fi

echo "Extracting keys from mods in $SRC_DIR..."

FOUND=0
# Iterate source directories
for MOD_PATH in "$SRC_DIR"/*; do
	if [ -d "$MOD_PATH" ] && [ "$(basename "$MOD_PATH")" != "$(basename "$DST_DIR")" ]; then
		while IFS= read -r -d $'\0' file; do
			echo "Found key: $file" >&2
			cp -u -- "$file" "$DST_DIR/"
			FOUND=1
		done < <(find "$MOD_PATH" -type f -name "*.bikey" -print0)
	fi
done

if [ "$FOUND" -eq 0 ]; then
	echo "No .bikey files found"
else
	echo "Keys installed successfully"
fi

exit 0
