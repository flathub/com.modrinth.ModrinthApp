#!/bin/bash

# Discord RPC
for i in {0..9}; do
    test -S "$XDG_RUNTIME_DIR"/discord-ipc-"$i" || ln -sf {app/com.discordapp.Discord,"$XDG_RUNTIME_DIR"}/discord-ipc-"$i";
done

# argv[0] becomes the Wayland app_id, which must match the desktop file name
exec -a "$FLATPAK_ID" /app/bin/modrinth-app-wrapped "$@"
