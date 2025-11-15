# Copy all keys from mods located in "server"
find ./server/ -path "./server/keys" -prune -o -type f -name "*.bikey" -exec cp {} ./server/keys/ \;
