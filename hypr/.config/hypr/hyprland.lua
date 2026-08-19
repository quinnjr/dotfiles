----------------------------------------------
--  Hyprland — Windows 11 Fluent Design Rice --
--  (converted from hyprland.conf to Lua)    --
----------------------------------------------

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun -theme ~/.config/rofi/win11.rasi"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    -- nm-applet is not installed (`pacman -S network-manager-applet`); uncomment after installing.
    -- hl.exec_cmd("nm-applet --indicator")
    -- NOTE: no `wl-clipboard` binary exists (package ships wl-copy/wl-paste).
    -- For clipboard history, install `cliphist` and use:
    --   hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP XDG_DATA_DIRS")
end)

-----------------------
---- NVIDIA / ENV  ----
-----------------------
hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- Without XDG_CURRENT_DESKTOP, KIO filters out OnlyShowIn=KDE desktop files and
-- never resolves ${desktop}-mimeapps.list, so Dolphin loses its default apps.
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
-- ksycoca is cached per XDG_DATA_DIRS hash; pin it so Dolphin always hits the
-- same (complete) cache instead of a stunted one built without /usr/share.
hl.env("XDG_DATA_DIRS", "/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:" .. os.getenv("HOME") .. "/.local/share/flatpak/exports/share")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("XCURSOR_THEME", "Fluent-dark-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Fluent-dark-cursors")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    cursor = {
        no_hardware_cursors = 0,
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,

        border_size = 1,

        col = {
            -- Win11 accent blue (active) / subtle border (inactive)
            active_border   = { colors = { "rgba(0067C0ff)", "rgba(1976D2ff)" }, angle = 45 },
            inactive_border = "rgba(3a3a3aaa)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.97,

        shadow = {
            enabled        = true,
            range          = 20,
            render_power   = 3,
            color          = "rgba(00000066)",
            color_inactive = "rgba(00000033)",
            offset         = { 0, 4 },
        },

        blur = {
            enabled           = true,
            size              = 8,
            passes            = 3,
            noise             = 0.02,
            contrast          = 1.0,
            brightness        = 0.9,
            vibrancy          = 0.15,
            vibrancy_darkness = 0.0,
            xray              = false,
            special           = true,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Win11-style: snappy, with a tiny overshoot
hl.curve("win11",    { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winClose", { type = "bezier", points = { { 0.4,  0.0 }, { 1.0, 1.0  } } })
hl.curve("winFade",  { type = "bezier", points = { { 0.0,  0.0 }, { 0.2, 1.0  } } })

hl.animation({ leaf = "windows",          enabled = true, speed = 4,  bezier = "win11",    style = "slide" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4,  bezier = "win11",    style = "slide" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3,  bezier = "winClose", style = "slide" })
hl.animation({ leaf = "border",           enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",             enabled = true, speed = 5,  bezier = "winFade" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 5,  bezier = "win11",    style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5,  bezier = "win11",    style = "slidevert" })

hl.config({
    dwindle = {
        -- `pseudotile` was removed as a config option; the `pseudo` dispatcher
        -- (bound to SUPER+P below) still works.
        preserve_split = true,
        smart_split    = false,
        smart_resizing = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper      = 0,
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        mouse_move_enables_dpms      = true,
        key_press_enables_dpms       = true,
        animate_manual_resizes       = true,
        animate_mouse_windowdragging = true,
        enable_swallow               = true,
        swallow_regex                = "^(kitty)$",
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
            tap_to_click   = true,
            drag_lock      = 1,
        },
    },

    gestures = {
        workspace_swipe_distance           = 300,
        workspace_swipe_invert             = true,
        workspace_swipe_min_speed_to_force = 30,
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

----------------------
---- WINDOW RULES ----
----------------------

-- Float common dialogs / tools
hl.window_rule({ match = { class = "pavucontrol" },          float = true, center = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true, center = true })
hl.window_rule({ match = { class = "org.kde.dolphin", title = "(Copying|Moving|Progress)" }, float = true })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, float = true })

-- Blur for special windows
hl.window_rule({ match = { class = "kitty" },            opacity = "0.90 override" })
hl.window_rule({ match = { class = "dolphin" },          opacity = "0.95 override" })
hl.window_rule({ match = { class = "code-url-handler" }, opacity = "0.95 override" })

-- No rounding for fullscreen
hl.window_rule({ match = { fullscreen = true }, rounding = 0 })

--------------------------
---- WORKSPACES/RULES ----
--------------------------
hl.workspace_rule({ workspace = "1", default = true })

----------------------
---- KEYBINDINGS  ----
----------------------
local mainMod = "SUPER"

-- Apps
hl.bind(mainMod .. " + Return",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Space",       hl.dsp.exec_cmd(menu))
hl.bind("ALT + F4",                  hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q",   hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M",   hl.dsp.exit())
hl.bind(mainMod .. " + V",           hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",           hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P",           hl.dsp.window.pseudo())
-- Moved off SUPER+J: that key is the vim-style "focus down" bind below.
hl.bind(mainMod .. " + S",           hl.dsp.layout("togglesplit"))

-- Screenshot
hl.bind("Print",                hl.dsp.exec_cmd('grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'))
hl.bind("SHIFT + Print",        hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'))
hl.bind(mainMod .. " + Print",  hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))

-- Focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",     hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + H",     hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L",     hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",     hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",     hl.dsp.window.move({ direction = "down" }))

-- Resize
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x =  30, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -30, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x =   0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x =   0, y =  30, relative = true }), { repeating = true })

-- Workspaces — Win+1-5 like Win11 virtual desktops
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through workspaces on mouse over taskbar
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume & brightness (media keys)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pamixer -i 5"),            { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pamixer -d 5"),            { repeating = true, locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pamixer -t"),              { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"),   { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"),   { repeating = true, locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"))
