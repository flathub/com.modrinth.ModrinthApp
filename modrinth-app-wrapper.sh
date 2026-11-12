#!/bin/bash

# Discord RPC
for i in {0..9}; do
    test -S "$XDG_RUNTIME_DIR"/discord-ipc-"$i" || ln -sf {app/com.discordapp.Discord,"$XDG_RUNTIME_DIR"}/discord-ipc-"$i";
done

# Minecraft 26.3+ fails to create a window under gamescope (https://github.com/ValveSoftware/gamescope) unless SDL is forced onto EGL.
if [ "$(uname -m)" = "aarch64" ] && [ "$XDG_CURRENT_DESKTOP" = "gamescope" ] && [ -z "${SDL_VIDEO_FORCE_EGL+x}" ]; then
    export SDL_VIDEO_FORCE_EGL=1
fi

# argv[0] becomes the Wayland app_id, which must match the desktop file name
exec -a "$FLATPAK_ID" /app/bin/modrinth-app-wrapped "$@"
