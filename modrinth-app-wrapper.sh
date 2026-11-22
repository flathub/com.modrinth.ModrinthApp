#!/bin/bash

# Discord RPC
for i in {0..9}; do
    test -S "$XDG_RUNTIME_DIR"/discord-ipc-"$i" || ln -sf {app/com.discordapp.Discord,"$XDG_RUNTIME_DIR"}/discord-ipc-"$i";
done

# Minecraft 26.3+ fails to create a window under gamescope (https://github.com/ValveSoftware/gamescope) unless SDL is forced onto EGL.
if [ "$(uname -m)" = "aarch64" ] && [ "$XDG_CURRENT_DESKTOP" = "gamescope" ] && [ -z "${SDL_VIDEO_FORCE_EGL+x}" ]; then
    export SDL_VIDEO_FORCE_EGL=1
fi

# Expose the Flathub gamescope and MangoHud extensions for use as instance wrapper commands
export PATH="${PATH}${PATH:+:}/usr/lib/extensions/vulkan/gamescope/bin:/usr/lib/extensions/vulkan/MangoHud/bin"
export VK_LAYER_PATH="/usr/lib/extensions/vulkan/share/vulkan/implicit_layer.d/"

# argv[0] becomes the Wayland app_id, which must match the desktop file name
exec -a "$FLATPAK_ID" /app/bin/modrinth-app-wrapped "$@"
