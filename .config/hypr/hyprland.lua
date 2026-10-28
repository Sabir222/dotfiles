-- =============================================================
--  Hyprland 0.57 config (Lua)
--  Port of ~/dotfiles/.config/sway/config
--  Keybinds, monitors, colors, borders, rules: 1:1 where the
--  compositors allow it. Differences are marked [DIFF].
-- =============================================================

------------------
---- MONITORS ----
------------------
-- sway: output DP-1  resolution 1920x1080 position 0,0
--       output HDMI-A-1 resolution 1920x1080 position 1920,0
hl.monitor({ output = "DP-1",     mode = "1920x1080@144", position = "0x0",    scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60",  position = "1920x0", scale = 1 })

----------------------------------
---- WORKSPACE -> MONITOR MAP ----
----------------------------------
-- sway: ws 1,2 -> DP-1 ; ws 3..9 -> HDMI-A-1 (0 = ws 10)
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", default = true })
for i = 4, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1" })
end

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "ghostty"
local fileManager = "flatpak run org.kde.dolphin"
local menu        = "wofi --show drun"
local browser     = "brave-browser"
local browserInc  = "brave-browser --incognito"

-- [DIFF] sway used bare `dolphin` and `brave`, neither of which exist
--        as commands here (dolphin is a flatpak, brave is brave-browser).
--        These are the working equivalents.

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "Adwaita-dark")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        -- sway has `# gaps inner 5` / `# gaps outer 1` commented out => no gaps
        gaps_in  = 0,
        gaps_out = 0,
        border_size = 1,

        -- client.focused #0B192C / client.unfocused #2c2c2c
        col = {
            active_border   = "rgba(0b192cff)",
            inactive_border = "rgba(2c2c2cff)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        -- flat, square, opaque: matches sway's pixel borders exactly
        rounding         = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = { enabled = false },
        blur   = { enabled = false },
    },

    -- sway has no animations
    animations = { enabled = false },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo   = true,
        force_default_wallpaper = 0,
        focus_on_activate       = true,
    },
})

hl.config({
    cursor = { no_hardware_cursors = true },
})

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    -- sway: exec lxpolkit
    hl.exec_cmd("lxpolkit")

    -- sway: exec wl-paste --watch cliphist store
    -- [DIFF] wl-clipboard + cliphist are not installed, so this was a
    --        no-op in sway too. Uncomment after installing them.
    -- hl.exec_cmd("wl-paste --watch cliphist store")

    -- sway: gnome-keyring-daemon
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")

    -- sway: kwalletd5
    hl.exec_cmd("kwalletd5")

    -- export the session into the systemd/dbus activation environment so
    -- DBusActivatable apps launched from wofi do not fail with
    -- "Gtk: Failed to open display" (this is what sway's
    -- `include /etc/sway/config.d/*` did)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")

    -- sway: exec_always ... workspace 1; exec $terminal
    hl.exec_cmd("sleep 0.4 && " .. terminal)

    -- sway: swaybg random wallpaper
    hl.exec_cmd([[swaybg -i "$(find ~/Pictures/wallpapers/ -maxdepth 1 -type f | shuf -n1)" -m fill]])

    -- sway: swayidle -w timeout 600 'swaylock -f'
    hl.exec_cmd([[swayidle -w timeout 600 'swaylock -f']])

    -- status bar (waybar, same config as sway, hyprland workspace module)
    hl.exec_cmd("waybar -c /home/sabir/.config/waybar/config-hyprland.jsonc -s /home/sabir/.config/waybar/style-hyprland.css")

    -- sway: exec mako
    hl.exec_cmd("mako")
end)

----------------
---- INPUT ----
----------------
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = { natural_scroll = false },
    },
})

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

----------------------
---- KEYBINDINGS ----
----------------------
local mainMod = "SUPER"

-- Terminal
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))

-- Kill focused window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- File manager / browser
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(browserInc))

-- Toggle floating  (sway: $mod+Shift+v)
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))

-- Focus movement (vim-like)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Workspace switching / moving windows to workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Split orientation
-- [DIFF] Hyprland's dwindle has no explicit "split h"/"split v";
--        togglesplit is the closest equivalent.
hl.bind(mainMod .. " + G", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit"))

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Layout switching
-- [DIFF] no true tabbed/stacking layouts. t = window group (tabbed),
--        y = master layout, u = toggle split direction.
hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("hyprctl keyword general:layout master"))
hl.bind(mainMod .. " + U", hl.dsp.layout("togglesplit"))

-- Reload config (sway: restart)
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Launch / wallpaper / exit
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd([[pkill -x swaybg; swaybg -i "$(find ~/Pictures/wallpapers/ -maxdepth 1 -type f | shuf -n1)" -m fill]]))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd([[sh -c 'printf "Yes\nNo\n" | wofi --show dmenu -p "Exit Hyprland?" | grep -qx Yes && hyprctl dispatch exit']]))

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media (spotify, as in sway)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -p spotify play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl -p spotify next"),       { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl -p spotify previous"),   { locked = true })

-- Mouse: $mod + drag moves, $mod + right-drag resizes (floating_modifier)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------
---- RESIZE MODE ----
--------------------
hl.define_submap("resize", function()
    hl.bind("H", hl.dsp.window.resize({ x = -5, y = 0 }))
    hl.bind("J", hl.dsp.window.resize({ x = 0, y = 5 }))
    hl.bind("K", hl.dsp.window.resize({ x = 0, y = -5 }))
    hl.bind("L", hl.dsp.window.resize({ x = 5, y = 0 }))

    hl.bind("Return", hl.dsp.submap("default"))
    hl.bind("Escape", hl.dsp.submap("default"))
    hl.bind(mainMod .. " + R", hl.dsp.submap("default"))
end)

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

----------------------------
---- WINDOWS AND RULES ----
----------------------------
-- sway: for_window [class="Pavucontrol"] floating enable
hl.window_rule({ match = { class = "^(pavucontrol)$" },            float = true })
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })

-- sway: window_role=pop-up / task_dialog -> floating
hl.window_rule({ match = { title = "^(Open File|Open Folder|Save File|File Upload|Open)$" }, float = true })

-- Bitwarden popup in Brave. Class captured live:
--   brave-nngceckbapebfimnlniiiahkandclblb-Default
-- (title starts as _crx_<extension-id>, becomes "Bitwarden" ~1s later,
--  so match class, not title). 400x600 parked at the right edge of the
-- monitor so it does not cover the page's login form.
hl.window_rule({
    match = { class = "^brave-nngceckbapebfimnlniiiahkandclblb.*$" },
    float  = true,
    size   = "400 600",
    move   = "monitor_w-420 80",
})

