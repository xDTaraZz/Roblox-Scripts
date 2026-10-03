-- Mario Hub UI V2 · made by xDTaraZ · discord.gg/FHVfmeSceA
-- (c) xDTaraZ. Do not reupload or rebrand without credit. build 2026-10-03
---@author xDTaraZ  Mario Hub UI V2
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local Library = {
    Version = "2.0",
    Author = "xDTaraZ",
    Credit = "Mario Hub UI V2 by xDTaraZ · discord.gg/FHVfmeSceA",
    Options = {},
    Toggles = {},
    Unloaded = false,
    Window = nil,
}

local Config = {
    GuiAttribute = "MarioHubUIV2",
    Root = "mariohub",
    AssetDir = "mariohub/assets",
    ConfigRoot = "mariohub/configs",
    KeyCache = "mariohub/key.txt",
    DefaultAssets = { logo = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/main/logo.png" },
    FontDir = "mariohub/fonts",
    HttpTimeout = 8,
    AssetWait = 0.25,
    FontTimeout = 20,
    PreloadTimeout = 5,
    ThaiFont = {
        Family = "MarioKanit",
        Source = "https://raw.githubusercontent.com/google/fonts/main/ofl/kanit/Kanit-%s.ttf",
        Weights = { [400] = "Regular", [500] = "Medium", [600] = "SemiBold" },
    },
    ThaiSizeBonus = { Body = 2, Desc = 2, Display = 1, Strong = 1 },
    Text = { Title = 26, Header = 22, Group = 16, Label = 15, Desc = 13, Small = 12, Button = 15, Watermark = 13, Section = 13 },
    TextBonus = { Desktop = 0, Tablet = 1, Phone = 1 },
    Platform = { PhoneMinSide = 500, PhoneMaxWidth = 640, Debounce = 0.2 },
    Metrics = {
        Desktop = {
            Row = 32, Box = 30, Item = 30, Track = 8, Knob = 18, Switch = Vector2.new(42, 22), SwitchKnob = 16,
            Tab = 38, Check = 20, Pad = 12, Gap = 6, Icon = 18, Depth = 3, Radius = 8,
            Hit = 0, Control = 26, Key = 38, Swatch = 34, Stepper = 30, Header = 36, Link = 22, TableHeader = 26, Preset = 22,
        },
        Tablet = {
            Row = 44, Box = 44, Item = 44, Track = 10, Knob = 22, Switch = Vector2.new(48, 26), SwitchKnob = 20,
            Tab = 48, Check = 24, Pad = 14, Gap = 8, Icon = 20, Depth = 3, Radius = 10,
            Hit = 44, Control = 44, Key = 44, Swatch = 44, Stepper = 44, Header = 44, Link = 44, TableHeader = 44, Preset = 30,
        },
        Phone = {
            Row = 44, Box = 44, Item = 44, Track = 10, Knob = 24, Switch = Vector2.new(52, 28), SwitchKnob = 22,
            Tab = 48, Check = 26, Pad = 12, Gap = 8, Icon = 22, Depth = 3, Radius = 10,
            Hit = 44, Control = 44, Key = 44, Swatch = 44, Stepper = 44, Header = 44, Link = 44, TableHeader = 44, Preset = 30,
        },
    },
    Window = {
        Width = 820, Height = 560, MinWidth = 520, MinHeight = 360,
        TouchMinWidth = 320, TouchMinHeight = 260,
        Topbar = 56, Sidebar = 196, SidebarCompact = 64, Header = 62, Ground = 24, UserCard = 58,
        TabBar = 60, TabBarMax = 4, TwoColumnMin = 540, Margin = 24, TouchMargin = 10,
        Radius = 12, Stroke = 3, Shadow = 6,
    },
    Group = { PadX = 12, PadY = 10, Shadow = 4, Radius = 12, Stroke = 2 },
    Gap = { X = 8, Y = 6, Column = 12 },
    Page = { Pad = 14, ScrollBar = 6 },
    Dropdown = { MaxVisible = 7, SearchThreshold = 8, MinWidth = 170 },
    ColorPicker = { Field = 150, Hue = 14 },
    Notify = { Width = 300, TouchWidth = 260, Duration = 4, Gap = 8 },
    Motion = {
        Speed = { Fast = 28, Normal = 18, Soft = 12 },
        Damping = 1,
        MaxStep = 1 / 120,
        MaxDelta = 0.1,
        Epsilon = 0.001,
        Ripple = { Grow = 2.2, Alpha = 0.75 },
        Pop = { From = 0.9, Damping = 0.5, Speed = "Fast" },
        Shake = { Impulse = 220, Damping = 0.22, Speed = "Fast" },
        Coin = { Size = 20, Rise = 42 },
    },
    Click = { LongPress = 0.45, DragCancel = 8 },
    Button = {
        PadX = 14, IconGap = 6, Hover = 0.08,
        Styles = {
            Default = { Face = "Element", Shade = "Pressed", Text = "Text" },
            Primary = { Face = "Accent", Shade = "AccentDark", Text = "AccentText" },
            Success = { Face = "Good", Shade = "GoodDark", Text = "White" },
            Danger = { Face = "Bad", Shade = "BadDark", Text = "White" },
            Warning = { Face = "Warn", Shade = "WarnDark", Text = "Ink" },
            Ghost = { Text = "Text" },
        },
    },
    Selectable = { PadX = 10, Bar = 3, HoverAlpha = 0.35 },
    Z = { Back = 1, Text = 2, Body = 3, Detail = 4, Raised = 5, Top = 6, Note = 7, Hit = 8, Pop = 9, Border = 20 },
    Layer = { Window = 10, Nav = 12, Watermark = 30, Float = 40, QuickBar = 42, Overlay = 50, Sheet = 52, Dialog = 54, Tooltip = 56, Notify = 60, Intro = 70, Kit = 90, Gui = 100 },
    LayoutPasses = 12,
    MeasureCacheLimit = 4000,
    DragThreshold = 6,
    ConfirmWindow = 2,
    TooltipDelay = 0.45,
    TitleWaveInterval = 9,
    ScaleRange = { Min = 0.7, Max = 1.4 },
    Particles = { Count = 10, MinTime = 7, MaxTime = 13 },
    MouseNames = {
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
    },
    TitleColors = { "Accent", "Coin", "Good", "Info" },
}

local Themes = { Order = { "Overworld", "Light", "Dark", "Underground", "Castle", "Star Road" } }

do
    local function FromHex(hex)
        return Color3.fromRGB(tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16))
    end

    local derived = { "Good", "Warn", "Bad", "Info", "Coin" }

    ---@param spec table  hex per token; Particle = { glyph, falls, hex }, Decor = { kind, glyph, hex }
    local function Palette(spec)
        local palette = {}
        for token, value in pairs(spec) do
            if token == "Particle" then
                palette.ParticleGlyph, palette.ParticleFall, palette.ParticleColor = value[1], value[2], FromHex(value[3])
            elseif token == "Decor" then
                palette.Decor, palette.DecorGlyph, palette.DecorColor = value[1], value[2] or "✦", FromHex(value[3] or "FFFFFF")
            elseif type(value) == "string" then
                palette[token] = FromHex(value)
            else
                palette[token] = value
            end
        end
        for _, token in ipairs(derived) do
            local dark = token .. "Dark"
            if not palette[dark] and palette[token] then
                palette[dark] = palette[token]:Lerp(Color3.new(0, 0, 0), 0.24)
            end
        end
        return palette
    end

    Themes.Shared = Palette({ White = "FFFFFF", Black = "000000", Ink = "2E2838", HeroInk = "2E2838", Knob = "FFFFFF" })

    Themes.Overworld = Palette({
        Backdrop = "C9DAEE", BackdropAlt = "E4EBF4", Topbar = "7896CC", TopbarText = "FFFFFF",
        Sidebar = "9A5D44", SidebarAlt = "844E39", SidebarText = "FCF2E6", SidebarMuted = "E3C7B3",
        TabActive = "FBF5EA", TabActiveText = "B8463A",
        Panel = "FAF6EE", PanelHeader = "F1E8D6", Element = "FFFCF7", Hover = "F0E4CE", Pressed = "DCCDB2",
        Outline = "40394B", Shadow = "7E86A4", Text = "3A3028", SubText = "76685A", Muted = "A29684", Track = "DFD5C5",
        Accent = "D45446", AccentDark = "A23A30", AccentText = "FFFFFF",
        Good = "62A964", Warn = "E2A447", Bad = "D45446", Info = "5A8FC6",
        Coin = "EEC452", Cloud = "FFFFFF", CloudAlpha = 0.25, Grass = "78B460", GrassDark = "548A44",
        Brick = "A66446", BrickDark = "6A3D2A", Glow = "FFF0C2",
        Decor = { "Clouds" }, Particle = { "✦", false, "F3D88A" },
    })

    Themes.Light = Palette({
        Backdrop = "F2EEE7", BackdropAlt = "FAF8F4", Topbar = "ECE4D6", TopbarText = "4A3F35", HeroInk = "FFFFFF",
        Sidebar = "E9E2D5", SidebarAlt = "DDD4C4", SidebarText = "4A3F35", SidebarMuted = "9B8F80",
        TabActive = "D45446", TabActiveText = "FFFFFF",
        Panel = "FFFFFF", PanelHeader = "F6F2EA", Element = "FBF9F6", Hover = "F1EADD", Pressed = "E3D9C8",
        Outline = "4C4659", Shadow = "D0C8BC", Text = "3A3028", SubText = "7C6F61", Muted = "ACA193", Track = "E6DFD3",
        Accent = "D45446", AccentDark = "A23A30", AccentText = "FFFFFF",
        Good = "5FA762", Warn = "D99A3E", Bad = "CF4F42", Info = "4E86BE",
        Coin = "E4B743", Cloud = "CCDAEC", CloudAlpha = 0, Grass = "8EC47C", GrassDark = "66A156",
        Brick = "D7B590", BrickDark = "AE8B66", Glow = "FFE7B8",
        Decor = { "Clouds" }, Particle = { "•", false, "E08C82" },
    })

    Themes.Dark = Palette({
        Backdrop = "1E1F26", BackdropAlt = "25262F", Topbar = "18191F", TopbarText = "ECEAF4",
        Sidebar = "22232B", SidebarAlt = "1B1C22", SidebarText = "E8E6F0", SidebarMuted = "8D8A9C",
        TabActive = "D85A4E", TabActiveText = "FFFFFF",
        Panel = "2A2B34", PanelHeader = "31323C", Element = "353743", Hover = "3E404D", Pressed = "2B2C36",
        Outline = "0F0F13", Shadow = "0F0F13", Text = "ECEAF4", SubText = "A9A6B8", Muted = "7B788C", Track = "454756",
        Accent = "DE5E52", AccentDark = "A63F35", AccentText = "FFFFFF",
        Good = "67B06A", Warn = "DDA04A", Bad = "DE5E52", Info = "6C9AD2",
        Coin = "EDC350", Cloud = "FFFFFF", CloudAlpha = 0.9, Grass = "5A5C6E", GrassDark = "3E3F4C",
        Brick = "2F3039", BrickDark = "18191F", Glow = "F3D27A",
        Decor = { "Stars", "✦", "EFC75A" }, Particle = { "✦", false, "EFC75A" },
    })

    Themes.Underground = Palette({
        Backdrop = "161C36", BackdropAlt = "1F2850", Topbar = "10152F", TopbarText = "ECF0FF",
        Sidebar = "24337A", SidebarAlt = "1C2863", SidebarText = "ECF0FF", SidebarMuted = "9AA9DE",
        TabActive = "EEC452", TabActiveText = "1E1B2E",
        Panel = "202849", PanelHeader = "28315A", Element = "2D3765", Hover = "374279", Pressed = "232B52",
        Outline = "06070F", Shadow = "06070F", Text = "F2F4FF", SubText = "AEB6E0", Muted = "7D87B6", Track = "3D4880",
        Accent = "6390EE", AccentDark = "3F66BE", AccentText = "FFFFFF",
        Good = "5DB38A", Warn = "E2AE52", Bad = "E0665C", Info = "7FA3F2",
        Coin = "EEC452", Cloud = "98ABFA", CloudAlpha = 0.8, Grass = "3D5CC4", GrassDark = "2C479C",
        Brick = "3149A4", BrickDark = "162159", Glow = "A9BEFF",
        Decor = { "Stars", "✦", "93AAFA" }, Particle = { "✦", false, "93AAFA" },
    })

    Themes.Castle = Palette({
        Backdrop = "1F1919", BackdropAlt = "31211D", Topbar = "161010", TopbarText = "FFF1E6",
        Sidebar = "4A4040", SidebarAlt = "3A3232", SidebarText = "FFF1E6", SidebarMuted = "C8B1A5",
        TabActive = "E2774A", TabActiveText = "FFFFFF",
        Panel = "2B2424", PanelHeader = "352C2C", Element = "3D3333", Hover = "4A3E3E", Pressed = "2F2727",
        Outline = "0B0808", Shadow = "0B0808", Text = "FFF1E6", SubText = "D7BFB1", Muted = "9E867A", Track = "524343",
        Accent = "E2774A", AccentDark = "AD5130", AccentText = "FFFFFF",
        Good = "79AE68", Warn = "E6A24E", Bad = "D9584A", Info = "8A9FD0",
        Coin = "EBBE52", Cloud = "F09466", CloudAlpha = 0.85, Grass = "EB8448", GrassDark = "B85628",
        Brick = "5A5050", BrickDark = "2B2323", Glow = "FFB37A",
        Decor = { "Stars", "•", "F59A5C" }, Particle = { "•", false, "F59A5C" },
    })

    Themes["Star Road"] = Palette({
        Backdrop = "1D1436", BackdropAlt = "2C1E52", Topbar = "150D2A", TopbarText = "FFF7FF",
        Sidebar = "3A2672", SidebarAlt = "2D1C5A", SidebarText = "FFF7FF", SidebarMuted = "CBBAEE",
        TabActive = "EEC452", TabActiveText = "26144A",
        Panel = "261849", PanelHeader = "2F1F59", Element = "35245F", Hover = "412C71", Pressed = "2A1B50",
        Outline = "08040F", Shadow = "08040F", Text = "FFF7FF", SubText = "CBBAEE", Muted = "9583C2", Track = "4A3680",
        Accent = "DE6AAE", AccentDark = "A84882", AccentText = "FFFFFF",
        Good = "68B88E", Warn = "E8B354", Bad = "E0645E", Info = "8EA2F0",
        Coin = "F0C858", Cloud = "FBE38C", CloudAlpha = 0.8, Grass = "EEC452", GrassDark = "B88E2E",
        Brick = "5B3AA6", BrickDark = "2B1A58", Glow = "FFE59A",
        Decor = { "Stars", "★", "F8D86A" }, Particle = { "★", false, "F8D86A" },
    })
end

local State = {
    Gui = nil,
    Stage = nil,
    Window = nil,
    Popup = nil,
    Sheet = nil,
    Drag = nil,
    Binding = nil,
    MenuKey = "LeftControl",
    ThemeName = "Overworld",
    Language = "EN",
    UserScale = 1,
    Touch = false,
    KeyPickers = {},
    Connections = {},
    Tasks = {},
    UnloadHooks = {},
    Fps = 60,
    StartTime = os.clock(),
}

local Platform = { Mode = "Desktop", Touch = false, Landscape = false, Console = false, Viewport = Vector2.new(1280, 720), Listeners = {}, ViewportListeners = {} }
local Util = {}
local Lang = { Bound = {}, Listeners = setmetatable({}, { __mode = "k" }), InstanceListeners = {} }
local Fonts = { Texts = {}, Thai = nil }
local Assets = { Overrides = {}, Cache = {}, Jobs = {} }
local Sprite = {}
local Theme = { Colors = {}, Bound = {}, Renderers = setmetatable({}, { __mode = "k" }), InstanceRenderers = {}, Chain = {} }
local Draw = { Pools = {} }
local Motion = { Reduced = false, UserReduced = false }
local Fx = { Homes = {} }
local Layout = { Dirty = {}, All = setmetatable({}, { __mode = "k" }), Measured = {}, MeasuredCount = 0, Visible = {}, Batch = {}, WarmBatch = {} }
local Gui = { Stack = {} }

local WidgetHost = {}
local Container = setmetatable({}, { __index = WidgetHost })
Container.__index = Container

local Widget = {}
Widget.__index = Widget
local Row = {}
Row.__index = Row

local Toggle = setmetatable({}, { __index = Widget })
Toggle.__index = Toggle
local Checkbox = setmetatable({}, { __index = Widget })
Checkbox.__index = Checkbox
local Slider = setmetatable({}, { __index = Widget })
Slider.__index = Slider
local Dropdown = setmetatable({}, { __index = Widget })
Dropdown.__index = Dropdown
local ListBox = setmetatable({}, { __index = Widget })
ListBox.__index = ListBox
local Input = setmetatable({}, { __index = Widget })
Input.__index = Input
local KeyPicker = setmetatable({}, { __index = Widget })
KeyPicker.__index = KeyPicker
local ColorPicker = setmetatable({}, { __index = Widget })
ColorPicker.__index = ColorPicker
local Selectable = setmetatable({}, { __index = Widget })
Selectable.__index = Selectable
local Segmented = setmetatable({}, { __index = Widget })
Segmented.__index = Segmented
local Stepper = setmetatable({}, { __index = Widget })
Stepper.__index = Stepper
local RangeSlider = setmetatable({}, { __index = Widget })
RangeSlider.__index = RangeSlider
local MultiChips = setmetatable({}, { __index = Widget })
MultiChips.__index = MultiChips
local PriorityList = setmetatable({}, { __index = Widget })
PriorityList.__index = PriorityList
local Table = setmetatable({}, { __index = Widget })
Table.__index = Table
local Status = setmetatable({}, { __index = Widget })
Status.__index = Status
local Stat = setmetatable({}, { __index = Widget })
Stat.__index = Stat
local TeleportList = setmetatable({}, { __index = Widget })
TeleportList.__index = TeleportList
local Feature = setmetatable({}, { __index = Widget })
Feature.__index = Feature
local Button = {}
Button.__index = Button
local ConfirmButton = setmetatable({}, { __index = Button })
ConfirmButton.__index = ConfirmButton
local Label = {}
Label.__index = Label
local Progress = {}
Progress.__index = Progress
local Divider = {}
Divider.__index = Divider

local Popup = {}
local Sheet = {}
local Tooltip = {}
local Notify = {}
local Dialog = {}
local Float = {}
local QuickBar = {}
local Watermark = {}
local KeybindList = {}

local Window = {}
Window.__index = Window
local Tab = {}
Tab.__index = Tab
local Groupbox = setmetatable({}, { __index = Container })
Groupbox.__index = Groupbox
local Search = {}
local Palette = {}

local Intro = {}
local KeyGate = {}
local Decor = {}
local Particles = { Pool = {}, Enabled = true }
local Keybinds = {}
local Configs = { Folder = Config.ConfigRoot .. "/default" }
local Settings = {}
local Kit = {}

---@author xDTaraZ  Mario Hub UI V2

---@return Vector2
function Platform.ReadViewport()
    local camera = Workspace.CurrentCamera
    return camera and camera.ViewportSize or Platform.Viewport
end

---@param viewport Vector2
---@return string  "Desktop" | "Tablet" | "Phone"
function Platform.Classify(viewport)
    if Platform.Forced == "Desktop" then
        return "Desktop"
    end
    if Platform.Forced == "Mobile" or Platform.Forced == "Phone" then
        return "Phone"
    end
    if Platform.Forced == "Tablet" then
        return "Tablet"
    end
    if not Platform.Touch then
        return Platform.Console and "Tablet" or "Desktop"
    end
    local limits = Config.Platform
    if math.min(viewport.X, viewport.Y) < limits.PhoneMinSide or viewport.X < limits.PhoneMaxWidth then
        return "Phone"
    end
    return "Tablet"
end

---Phone held sideways: the short side is the height, so chrome moves to a side dock.
---@return boolean
function Platform.IsLandscape(mode, viewport)
    return mode == "Phone" and viewport.X > viewport.Y and viewport.Y < Config.Platform.PhoneMinSide
end

---@param forced string?  "Mobile" | "Phone" | "Tablet" | "Desktop" | nil (auto)
---@return string  mode
function Platform.Detect(forced)
    if forced ~= nil then
        Platform.Forced = forced ~= "Auto" and forced or nil
    end
    local touch = UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled)
    local consoleOk, console = pcall(GuiService.IsTenFootInterface, GuiService)
    Platform.Console = consoleOk and console == true
    Platform.Touch = touch or Platform.Forced == "Mobile" or Platform.Forced == "Phone" or Platform.Forced == "Tablet"
    Platform.Viewport = Platform.ReadViewport()
    Platform.Mode = Platform.Classify(Platform.Viewport)
    Platform.Landscape = Platform.IsLandscape(Platform.Mode, Platform.Viewport)
    State.Touch = Platform.Touch
    Platform.Watch()
    return Platform.Mode
end

function Platform.Watch()
    if Platform.Watching then
        return
    end
    Platform.Watching = true
    Util.Connect(Workspace:GetPropertyChangedSignal("CurrentCamera"), Platform.BindCamera)
    Platform.BindCamera()
end

---Games swap CurrentCamera on respawn or cutscenes; the old camera's ViewportSize never fires again.
function Platform.BindCamera()
    Platform.UnbindCamera()
    local camera = Workspace.CurrentCamera
    if not camera then
        return
    end
    Platform.ViewportConn = camera:GetPropertyChangedSignal("ViewportSize"):Connect(Platform.OnResize)
    Platform.OnResize()
end

function Platform.UnbindCamera()
    local conn = Platform.ViewportConn
    Platform.ViewportConn = nil
    if conn then
        conn:Disconnect()
    end
end

function Platform.OnResize()
    Platform.Viewport = Platform.ReadViewport()
    if Platform.Pending then
        return
    end
    Platform.Pending = true
    task.delay(Config.Platform.Debounce, Platform.Settle)
end

function Platform.Settle()
    Platform.Pending = false
    if Library.Unloaded then
        return
    end
    local viewport = Platform.ReadViewport()
    Platform.Viewport = viewport
    for _, listener in ipairs(Platform.ViewportListeners) do
        Util.Try(listener, viewport)
    end
    local mode = Platform.Classify(viewport)
    local landscape = Platform.IsLandscape(mode, viewport)
    if mode == Platform.Mode and landscape == Platform.Landscape then
        return
    end
    Platform.Mode, Platform.Landscape = mode, landscape
    for _, listener in ipairs(Platform.Listeners) do
        Util.Try(listener, mode)
    end
end

---Fires when the mode or the phone landscape flag changes.
---@param callback fun(mode: string)
function Platform.OnChange(callback)
    table.insert(Platform.Listeners, callback)
end

---Fires on every settled viewport change, including resizes that keep the same mode.
---@param callback fun(viewport: Vector2)
function Platform.OnViewport(callback)
    table.insert(Platform.ViewportListeners, callback)
end

---@return any  number or Vector2 for the current mode
function Platform.Metric(name)
    return Config.Metrics[Platform.Mode][name]
end

---@return number  smallest side a tappable control may have: the finger size on touch, 0 with a mouse
function Platform.TouchMin()
    return Platform.Touch and Config.Metrics[Platform.Mode].Hit or 0
end

table.insert(State.UnloadHooks, Platform.UnbindCamera)

---@author xDTaraZ  Mario Hub UI V2
function Util.Try(callback, ...)
    if type(callback) ~= "function" then
        return false
    end
    local ok, message = pcall(callback, ...)
    if not ok then
        warn("[Mario Hub] " .. tostring(message))
    end
    return ok, message
end

function Util.Connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(State.Connections, connection)
    return connection
end

---Library-internal jobs never yield, so they run inline instead of paying for a fresh coroutine every tick.
function Util.Every(interval, callback)
    table.insert(State.Tasks, { Interval = interval, Elapsed = 0, Run = callback, Inline = true })
end

Util.Metric = Platform.Metric

function Util.TextSize(kind)
    return Config.Text[kind] + Config.TextBonus[Platform.Mode]
end

function Util.IsPointer(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end

function Util.IsMove(input)
    return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
end

function Util.InputName(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        return input.KeyCode.Name
    end
    return Config.MouseNames[input.UserInputType]
end

function Util.KeyName(key)
    if typeof(key) == "EnumItem" then
        return key.Name
    end
    return type(key) == "string" and key or nil
end

function Util.Inside(guiObject, position)
    local origin, size = guiObject.AbsolutePosition, guiObject.AbsoluteSize
    return position.X >= origin.X and position.X <= origin.X + size.X and position.Y >= origin.Y and position.Y <= origin.Y + size.Y
end

function Util.GuiParent()
    if type(gethui) == "function" then
        local ok, hidden = pcall(gethui)
        if ok and typeof(hidden) == "Instance" then
            return hidden
        end
    end
    local ok = pcall(function()
        return CoreGui:GetChildren()
    end)
    return ok and CoreGui or LocalPlayer:WaitForChild("PlayerGui", 10) or LocalPlayer:FindFirstChildOfClass("PlayerGui")
end

---@return boolean finished, any ...  false if it errored or ran past the deadline
function Util.Await(timeout, callback, ...)
    local box = { done = false }
    local args = table.pack(...)
    task.spawn(function()
        box.values = table.pack(pcall(callback, table.unpack(args, 1, args.n)))
        box.done = true
    end)
    local started = os.clock()
    while not box.done and os.clock() - started < timeout do
        task.wait(0.05)
    end
    if not box.done or not box.values[1] then
        return false
    end
    return true, table.unpack(box.values, 2, box.values.n)
end

function Util.FetchBody(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then
        return body
    end
    local requester = (type(request) == "function" and request) or (type(http_request) == "function" and http_request) or (syn and syn.request)
    if not requester then
        return nil
    end
    local sent, response = pcall(requester, { Url = url, Method = "GET" })
    return sent and type(response) == "table" and response.Body or nil
end

---@return string?  nil on failure or after Config.HttpTimeout
function Util.HttpGet(url)
    local finished, body = Util.Await(Config.HttpTimeout, Util.FetchBody, url)
    return finished and type(body) == "string" and body or nil
end

---@return string?  nil if the executor can't serve the file
function Util.CustomAsset(path)
    if type(getcustomasset) ~= "function" then
        return nil
    end
    local finished, asset = Util.Await(Config.HttpTimeout, getcustomasset, path)
    return finished and type(asset) == "string" and asset:find("^rbxasset") and asset or nil
end

function Util.SafeFile(fn, ...)
    if type(fn) ~= "function" then
        return nil
    end
    local ok, value = pcall(fn, ...)
    if not ok then
        return nil
    end
    return value == nil and true or value
end

function Util.Clipboard(text)
    local setter = setclipboard or toclipboard or (syn and syn.write_clipboard)
    if type(setter) ~= "function" then
        return false
    end
    return (pcall(setter, text))
end

function Util.FileApi()
    return type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function"
end

function Util.EnsureFolder(path)
    if type(makefolder) ~= "function" or type(isfolder) ~= "function" then
        return
    end
    local built = ""
    for part in path:gmatch("[^/]+") do
        built = built == "" and part or built .. "/" .. part
        if not isfolder(built) then
            makefolder(built)
        end
    end
end

---@return string  keeps UTF-8 (Thai ok), strips path-illegal chars
function Util.Sanitize(name)
    local clean = tostring(name):gsub('[%c/\\:%*%?"<>|]', ""):gsub("^%s+", ""):gsub("%s+$", "")
    return clean ~= "" and clean or "config"
end

function Util.Round(value, decimals)
    local factor = 10 ^ (decimals or 0)
    return math.floor(value * factor + 0.5) / factor
end

function Util.ToSet(value)
    local set = {}
    if type(value) ~= "table" then
        return set
    end
    for key, entry in pairs(value) do
        if type(key) == "number" then
            set[entry] = true
        elseif entry then
            set[key] = true
        end
    end
    return set
end

function Util.PlayerNames()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    table.sort(names)
    return names
end

function Util.Lighten(color, amount)
    return color:Lerp(Color3.new(1, 1, 1), amount)
end

function Util.Hex(color)
    return string.format("#%02X%02X%02X", math.floor(color.R * 255 + 0.5), math.floor(color.G * 255 + 0.5), math.floor(color.B * 255 + 0.5))
end

function Util.FromHex(text)
    local hex = tostring(text):gsub("#", "")
    if not hex:match("^%x%x%x%x%x%x$") then
        return nil
    end
    return Color3.fromRGB(tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16))
end

Lang.Strings = {
    Search = { EN = "Search...", TH = "ค้นหา..." },
    Confirm = { EN = "Click again to confirm", TH = "กดอีกครั้งเพื่อยืนยัน" },
    None = { EN = "None", TH = "ไม่มี" },
    NoResults = { EN = "No matches", TH = "ไม่พบรายการ" },
    Settings = { EN = "Settings", TH = "ตั้งค่า" },
    SettingsDesc = { EN = "Interface, language and configs", TH = "หน้าตา ภาษา และคอนฟิก" },
    Interface = { EN = "Interface", TH = "หน้าตา" },
    Language = { EN = "Language", TH = "ภาษา" },
    ThemeName = { EN = "Theme", TH = "ธีม" },
    Scale = { EN = "UI scale", TH = "ขนาด UI" },
    MenuKey = { EN = "Menu key", TH = "ปุ่มเปิดเมนู" },
    Watermark = { EN = "Watermark", TH = "วอเตอร์มาร์ก" },
    WatermarkDesc = { EN = "Hub name, FPS, ping and play time", TH = "ชื่อฮับ FPS ปิง และเวลาที่เล่น" },
    FloatButton = { EN = "Mobile button", TH = "ปุ่มลอยมือถือ" },
    FloatDesc = { EN = "Floating block that opens the menu", TH = "กล่อง ? ลอยสำหรับเปิดปิดเมนู" },
    Configs = { EN = "Configs", TH = "คอนฟิก" },
    ConfigName = { EN = "Config name", TH = "ชื่อคอนฟิก" },
    SavedConfigs = { EN = "Saved configs", TH = "คอนฟิกที่บันทึกไว้" },
    Save = { EN = "Save", TH = "บันทึก" },
    Load = { EN = "Load", TH = "โหลด" },
    Delete = { EN = "Delete", TH = "ลบ" },
    Refresh = { EN = "Refresh", TH = "รีเฟรช" },
    ResetAll = { EN = "Reset All", TH = "รีเซ็ตทั้งหมด" },
    ResetTab = { EN = "Reset Tab", TH = "รีเซ็ตแท็บนี้" },
    ResetDone = { EN = "Options reset: %d", TH = "รีเซ็ตแล้ว %d ค่า" },
    SetAutoload = { EN = "Load on start", TH = "โหลดอัตโนมัติ" },
    Autoload = { EN = "Autoload: %s", TH = "โหลดอัตโนมัติ: %s" },
    PickConfig = { EN = "Type or select a config name first", TH = "พิมพ์หรือเลือกชื่อคอนฟิกก่อน" },
    NoFileApi = { EN = "This executor cannot save files", TH = "executor นี้บันทึกไฟล์ไม่ได้" },
    ConfigMissing = { EN = "Config not found", TH = "ไม่พบคอนฟิก" },
    ConfigBroken = { EN = "Config file is damaged", TH = "ไฟล์คอนฟิกเสีย" },
    About = { EN = "About", TH = "เกี่ยวกับ" },
    Unload = { EN = "Unload hub", TH = "ปิดสคริปต์" },
    Rejoin = { EN = "Rejoin", TH = "เข้าเซิร์ฟใหม่" },
    KeyTitle = { EN = "ENTER KEY", TH = "ใส่คีย์" },
    KeyNote = { EN = "Paste your key to start the adventure.", TH = "วางคีย์เพื่อเริ่มผจญภัย" },
    KeyPlaceholder = { EN = "Paste key here", TH = "วางคีย์ที่นี่" },
    GetKey = { EN = "Get key", TH = "รับคีย์" },
    CheckKey = { EN = "Check key", TH = "ตรวจคีย์" },
    KeyCopied = { EN = "Key link copied", TH = "คัดลอกลิงก์รับคีย์แล้ว" },
    KeyChecking = { EN = "Checking...", TH = "กำลังตรวจ..." },
    KeyInvalid = { EN = "Invalid key", TH = "คีย์ไม่ถูกต้อง" },
    KeyValid = { EN = "Key accepted", TH = "คีย์ถูกต้อง" },
    IntroSteps = {
        EN = { "Warming up the warp pipe...", "Collecting coins...", "Building the castle...", "Let's-a go!" },
        TH = { "กำลังอุ่นท่อวาร์ป...", "กำลังเก็บเหรียญ...", "กำลังสร้างปราสาท...", "ลุยกันเลย!" },
    },
    Ready = { EN = "Ready. Press %s to toggle the menu.", TH = "พร้อมแล้ว กด %s เพื่อเปิดปิดเมนู" },
    ReadyTouch = { EN = "Ready. Tap the ? block to toggle the menu.", TH = "พร้อมแล้ว แตะกล่อง ? เพื่อเปิดปิดเมนู" },
    Hidden = { EN = "Menu hidden. Press %s to open.", TH = "ซ่อนเมนูแล้ว กด %s เพื่อเปิด" },
    Session = { EN = "TIME", TH = "เวลา" },
    Empty = { EN = "Nothing here yet", TH = "ยังไม่มีรายการ" },
    Particles = { EN = "Ambient particles", TH = "ละอองตกแต่ง" },
    ParticlesDesc = { EN = "Floating sparkles behind the menu", TH = "ประกายลอยด้านหลังเมนู" },
    Device = { EN = "Device: %s", TH = "อุปกรณ์: %s" },
}

function Lang.HasThai(text)
    return text:find("\224[\184\185]") ~= nil
end

---@param spec any     string, { EN, TH } or "English · ไทย"
---@return string     text in the current language
function Lang.Resolve(spec)
    if type(spec) == "table" then
        return spec[State.Language] or spec.EN or spec.TH or ""
    end
    if type(spec) ~= "string" then
        return spec == nil and "" or tostring(spec)
    end
    local english, thai = spec:match("^(.-)%s+·%s+(.+)$")
    if english and Lang.HasThai(thai) then
        return State.Language == "TH" and thai or english
    end
    return spec
end

function Lang.Get(key, ...)
    local text = Lang.Resolve(Lang.Strings[key] or key)
    if select("#", ...) > 0 then
        return string.format(text, ...)
    end
    return text
end

function Lang.SearchText(spec)
    if type(spec) == "table" then
        return ((spec.EN or "") .. " " .. (spec.TH or "")):lower()
    end
    return tostring(spec or ""):lower()
end

---@param transform function?  applied before display (e.g. string.upper)
function Lang.Bind(inst, spec, property, transform)
    local binding = { Spec = spec, Property = property or "Text", Transform = transform }
    Lang.Bound[inst] = binding
    Lang.Apply(inst, binding)
end

function Lang.Apply(inst, binding)
    local text = Lang.Resolve(binding.Spec)
    inst[binding.Property] = binding.Transform and binding.Transform(text) or text
end

function Lang.OnChange(owner, callback)
    local registry = typeof(owner) == "Instance" and Lang.InstanceListeners or Lang.Listeners
    registry[owner] = callback
end

function Lang.Set(code)
    if code ~= "EN" and code ~= "TH" then
        return
    end
    State.Language = code
    if code == "TH" then
        Fonts.LoadThaiAsync()
    end
    Theme.Prune()
    for inst, binding in pairs(Lang.Bound) do
        Lang.Apply(inst, binding)
    end
    Fonts.ApplyAll()
    for _, registry in ipairs({ Lang.Listeners, Lang.InstanceListeners }) do
        for _, callback in pairs(registry) do
            Util.Try(callback, code)
        end
    end
    Layout.MarkAll()
end

Fonts.Latin = {
    Display = Enum.Font.LuckiestGuy, Body = Enum.Font.FredokaOne, Desc = Enum.Font.BuilderSansMedium,
    Strong = Enum.Font.BuilderSansBold, Logo = Enum.Font.LuckiestGuy, Glyph = Enum.Font.BuilderSansBold,
}
Fonts.ThaiWeights = { Display = Enum.FontWeight.SemiBold, Body = Enum.FontWeight.Medium, Desc = Enum.FontWeight.Regular, Strong = Enum.FontWeight.SemiBold }
Fonts.ThaiFallback = { Display = Enum.Font.BuilderSansBold, Body = Enum.Font.BuilderSansBold, Desc = Enum.Font.BuilderSansMedium, Strong = Enum.Font.BuilderSansBold }
Fonts.Faces = {}

---@return Font  Kanit for Thai once loaded
function Fonts.Face(kind)
    local thai = State.Language == "TH" and Fonts.ThaiWeights[kind] ~= nil
    local key = (thai and (Fonts.Thai and "TH" or "THF") or "EN") .. kind
    local cached = Fonts.Faces[key]
    if cached then
        return cached
    end
    local face
    if thai and Fonts.Thai then
        face = Font.new(Fonts.Thai, Fonts.ThaiWeights[kind])
    elseif thai then
        face = Font.fromEnum(Fonts.ThaiFallback[kind])
    else
        face = Font.fromEnum(Fonts.Latin[kind] or Fonts.Latin.Body)
    end
    Fonts.Faces[key] = face
    return face
end

function Fonts.Size(kind, base)
    return base + (State.Language == "TH" and Config.ThaiSizeBonus[kind] or 0)
end

function Fonts.Style(label, kind, base)
    Fonts.Texts[label] = { Kind = kind, Base = base }
    label.FontFace = Fonts.Face(kind)
    label.TextSize = Fonts.Size(kind, base)
end

function Fonts.ApplyAll()
    table.clear(Layout.Measured)
    Layout.MeasuredCount = 0
    for label, style in pairs(Fonts.Texts) do
        label.FontFace = Fonts.Face(style.Kind)
        label.TextSize = Fonts.Size(style.Kind, style.Base)
    end
end

function Fonts.FetchFace(weight, name)
    local path = Config.FontDir .. "/kanit-" .. weight .. ".ttf"
    local cached = Util.SafeFile(isfile, path) == true and Util.SafeFile(readfile, path)
    if type(cached) ~= "string" or cached:sub(1, 4) ~= "\0\1\0\0" then
        local body = Util.HttpGet(string.format(Config.ThaiFont.Source, name))
        if type(body) ~= "string" or body:sub(1, 4) ~= "\0\1\0\0" then
            return nil
        end
        Util.SafeFile(writefile, path, body)
        local check = Util.SafeFile(readfile, path)
        if type(check) ~= "string" or #check ~= #body then
            Fonts.Disable("binary write")
            return nil
        end
    end
    local asset = Util.CustomAsset(path)
    if not asset then
        Fonts.Disable("getcustomasset ttf")
        return nil
    end
    return string.format('{"name":"W%d","weight":%d,"style":"normal","assetId":"%s"}', weight, weight, asset)
end

function Fonts.Disable(reason)
    Fonts.Broken = true
    Util.SafeFile(writefile, Config.FontDir .. "/disabled", tostring(reason))
    warn("[Mario Hub] Thai font off: " .. tostring(reason))
end

function Fonts.LoadThai()
    if Fonts.Thai or Fonts.Broken or not Util.FileApi() or type(getcustomasset) ~= "function" then
        return Fonts.Thai ~= nil
    end
    if Util.SafeFile(isfile, Config.FontDir .. "/disabled") == true then
        Fonts.Broken = true
        return false
    end
    Util.EnsureFolder(Config.FontDir)
    local faces = {}
    for weight, name in pairs(Config.ThaiFont.Weights) do
        if Fonts.Broken or Library.Unloaded then
            return false
        end
        table.insert(faces, Fonts.FetchFace(weight, name))
    end
    if #faces == 0 then
        return false
    end
    local descriptor = Config.FontDir .. "/kanit.font"
    if Util.SafeFile(isfile, descriptor) == true then
        Util.SafeFile(delfile, descriptor)
    end
    Util.SafeFile(writefile, descriptor, '{"name":"' .. Config.ThaiFont.Family .. '","faces":[' .. table.concat(faces, ",") .. "]}")
    local family = Util.CustomAsset(descriptor)
    if not family then
        Fonts.Disable("getcustomasset family")
        return false
    end
    Fonts.Thai = family
    table.clear(Fonts.Faces)
    if State.Language == "TH" and State.Gui then
        Fonts.ApplyAll()
        Layout.MarkAll()
    end
    task.spawn(Fonts.Preload)
    return true
end

function Fonts.LoadThaiAsync()
    if Fonts.Thai or Fonts.Broken or Fonts.Loading then
        return
    end
    Fonts.Loading = true
    task.spawn(function()
        local finished = Util.Await(Config.FontTimeout, Fonts.LoadThai)
        Fonts.Loading = false
        if not finished and not Fonts.Thai and not Fonts.Broken and not Library.Unloaded then
            Fonts.Disable("timeout")
        end
    end)
end

function Fonts.Preload()
    local provider = game:GetService("ContentProvider")
    local probes = {}
    for _, weight in pairs(Fonts.ThaiWeights) do
        table.insert(probes, Draw.New("TextLabel", { Text = "ก", FontFace = Font.new(Fonts.Thai, weight) }))
    end
    Util.Await(Config.PreloadTimeout, provider.PreloadAsync, provider, probes)
    for _, probe in ipairs(probes) do
        probe:Destroy()
    end
end

function Assets.Configure(map)
    if type(map) ~= "table" then
        return
    end
    for name, source in pairs(map) do
        local key = tostring(name):lower()
        Assets.Overrides[key] = source
        Assets.Cache[key] = nil
        Assets.Jobs[key] = nil
    end
end

function Assets.Download(name, url)
    if type(getcustomasset) ~= "function" or not Util.FileApi() then
        return nil
    end
    local path = Config.AssetDir .. "/" .. Util.Sanitize(name) .. ".png"
    if Util.SafeFile(isfile, path) ~= true then
        local body = Util.HttpGet(url)
        if type(body) ~= "string" or #body < 8 then
            return nil
        end
        Util.EnsureFolder(Config.AssetDir)
        Util.SafeFile(writefile, path, body)
    end
    return Util.CustomAsset(path)
end

function Assets.Load(key, source)
    if source:match("^https?://") then
        return Assets.Download(key, source)
    end
    if Util.SafeFile(isfile, source) == true then
        return Util.CustomAsset(source)
    end
    return nil
end

---Downloads and getcustomasset can stall for seconds on a slow executor; the build waits AssetWait at most and the rest lands later.
---@return table  job { Done, Content, Waiters }
function Assets.Fetch(key, source)
    local job = Assets.Jobs[key]
    if not job then
        job = { Done = false, Waiters = {} }
        Assets.Jobs[key] = job
        task.spawn(function()
            local ok, content = pcall(Assets.Load, key, source)
            content = ok and type(content) == "string" and content or nil
            job.Done, job.Content = true, content
            if Assets.Jobs[key] == job then
                Assets.Cache[key] = content or false
            end
            local waiters = job.Waiters
            job.Waiters = {}
            for _, waiter in ipairs(waiters) do
                if content and not Library.Unloaded then
                    Util.Try(waiter, content)
                end
            end
        end)
    end
    local started = os.clock()
    while not job.Done and os.clock() - started < Config.AssetWait do
        task.wait()
    end
    return job
end

---@return string?  override content id, nil = draw built-in
---@return table?   pending job when the image is still loading; pass it to Assets.Later
function Assets.Resolve(name)
    local key = tostring(name):lower()
    local cached = Assets.Cache[key]
    if cached ~= nil then
        return cached or nil
    end
    local source = Assets.Overrides[key]
    if type(source) == "number" then
        Assets.Cache[key] = "rbxassetid://" .. source
    elseif type(source) == "string" and source:find("^rbxasset") then
        Assets.Cache[key] = source
    elseif type(source) == "string" then
        local job = Assets.Fetch(key, source)
        if not job.Done then
            return nil, job
        end
    else
        Assets.Cache[key] = false
    end
    return Assets.Cache[key] or nil
end

---Swaps a built-in drawing for the image once a slow asset arrives.
function Assets.Later(job, holder)
    if not job then
        return
    end
    table.insert(job.Waiters, function(image)
        if not holder.Parent then
            return
        end
        for _, child in ipairs(holder:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Visible = false
            elseif child:IsA("UIStroke") then
                child.Enabled = false
            end
        end
        holder.BackgroundTransparency = 1
        Draw.New("ImageLabel", { BackgroundTransparency = 1, Image = image, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Fit, Parent = holder })
    end)
end

Sprite.Palette = {
    k = Color3.fromRGB(24, 20, 30), w = Color3.fromRGB(255, 255, 255), r = Color3.fromRGB(229, 37, 33),
    s = Color3.fromRGB(252, 216, 168), y = Color3.fromRGB(252, 208, 0), Y = Color3.fromRGB(196, 132, 0),
    q = Color3.fromRGB(248, 184, 0), Q = Color3.fromRGB(184, 104, 0), o = Color3.fromRGB(255, 140, 26),
    g = Color3.fromRGB(67, 176, 71), G = Color3.fromRGB(38, 116, 44), l = Color3.fromRGB(150, 226, 122),
    n = Color3.fromRGB(154, 160, 166), N = Color3.fromRGB(46, 46, 58), B = Color3.fromRGB(200, 86, 28),
    m = Color3.fromRGB(90, 42, 14), b = Color3.fromRGB(4, 156, 216),
}

Sprite.Art = {
    mushroom = {
        "....kkkk....", "..kkrrwwkk..", ".krrrrwwwrk.", ".kwwrrwwrrk.",
        "kwwwwrrrrrrk", "kwwwwrrrwwrk", "krwwrrrwwwwk", "krrrrrrwwwrk",
        "kkkkkkkkkkkk", ".kssksskssk.", ".kssksskssk.", "..kkkkkkkk..",
    },
    star = {
        ".....kk.....", "....kyyk....", "....kyyk....", "kkkkkyykkkkk",
        "kyyyyyyyyyyk", ".kyykyykyyk.", "..kykyykyk..", "...kyyyyk...",
        "..kyyyyyyk..", "..kyykkyyk..", ".kyyk..kyyk.", ".kkk....kkk.",
    },
    coin = {
        "....kkkk....", "...kyyyyk...", "..kyywwyyk..", "..kywyyYyk..",
        ".kywyyyYyyk.", ".kywyyyYyyk.", ".kywyyyYyyk.", ".kywyyyYyyk.",
        "..kyyyyYyk..", "..kyyYYYyk..", "...kyyyyk...", "....kkkk....",
    },
    qblock = {
        "kkkkkkkkkkkk", "kqqqqqqqqqqk", "kqkqqqqqqkQk", "kqqqwwwwqqQk",
        "kqqwwQQwwqQk", "kqqQQqqwwqQk", "kqqqqqwwQqQk", "kqqqqwwQqqQk",
        "kqqqqQQqqqQk", "kqkqqwwqqkQk", "kqQQQQQQQQQk", "kkkkkkkkkkkk",
    },
    brick = {
        "BBBBBmBBBBBm", "BBBBBmBBBBBm", "mmmmmmmmmmmm", "BBmBBBBBmBBB",
        "BBmBBBBBmBBB", "mmmmmmmmmmmm", "BBBBBmBBBBBm", "BBBBBmBBBBBm",
        "mmmmmmmmmmmm", "BBmBBBBBmBBB", "BBmBBBBBmBBB", "mmmmmmmmmmmm",
    },
    pipe = {
        "kkkkkkkkkkkk", "klgggggggGGk", "klgggggggGGk", "klgggggggGGk",
        "kkkkkkkkkkkk", ".klggggggGk.", ".klggggggGk.", ".klggggggGk.",
        ".klggggggGk.", ".klggggggGk.", ".klggggggGk.", ".kkkkkkkkkk.",
    },
    flower = {
        "...kkkkkk...", "..krrrrrrk..", ".krryyyyrrk.", ".kryywwyyrk.",
        ".krryyyyrrk.", "..krrrrrrk..", "...kkggkk...", ".kgk.gg.kgk.",
        ".kggkggkggk.", "..kggggggk..", "...kkggkk...", ".....kk.....",
    },
    shell = {
        "....kkkk....", "..kkggggkk..", ".kggGGGGggk.", ".kgGggggGgk.",
        "kggGggggGggk", "kggGGGGGGggk", "kggggggggggk", "kwwwwwwwwwwk",
        "kwkwwkkwwkwk", ".kyyyyyyyyk.", "..kyyyyyyk..", "...kkkkkk...",
    },
    boo = {
        "....kkkk....", "..kkwwwwkk..", ".kwwwwwwwwk.", ".kwwkwwkwwk.",
        "kwwwkwwkwwwk", "kwwwwwwwwwwk", "kwwkrrrrkwwk", "kwwwkrrkwwwk",
        "kwwwwkkwwwwk", "kwwwwwwwwwwk", "kwwwkwwkwwwk", "kkk.kkkk.kkk",
    },
    flag = {
        ".yy.........", ".yy.........", "..nkkkkkkk..", "..nkgggggk..",
        "..nkggwggk..", "..nkgwwwgk..", "..nkggggk...", "..nkgggk....",
        "..nkkkk.....", "..n.........", "..n.........", "kkkkk.......",
    },
    key = {
        "...kkkk.....", "..kyyyyk....", ".kyykkyyk...", ".kyk..kyk...",
        ".kyykkyyk...", "..kyyyyk....", "...kyyk.....", "...kyyk.....",
        "...kyykk....", "...kyyyyk...", "...kyykk....", "...kkkk.....",
    },
    gear = {
        "....kkkk....", ".kk.knnk.kk.", ".knkknnkknk.", "..knnnnnnk..",
        "kkknnkknnkkk", "knnnk..knnnk", "knnnk..knnnk", "kkknnkknnkkk",
        "..knnnnnnk..", ".knkknnkknk.", ".kk.knnk.kk.", "....kkkk....",
    },
    heart = {
        "............", ".kkk....kkk.", "kwrrrkkrrrrk", "kwrrrrrrrrrk",
        "krrrrrrrrrrk", ".krrrrrrrrk.", "..krrrrrrk..", "...krrrrk...",
        "....krrk....", ".....kk.....", "............", "............",
    },
    bomb = {
        "........o.y.", ".......n.o..", "......n.....", "...kkkkkk...",
        "..kNNNNNNk..", ".kNwwNNNNNk.", ".kNwNNwNwNk.", ".kNNNNwNwNk.",
        ".kNNNNNNNNk.", "..kNNNNNNk..", "..kyykkyyk..", "..kkk..kkk..",
    },
    used = {
        "kkkkkkkkkkkk", "kBBBBBBBBBBk", "kBmBBBBBBmBk", "kBBBBBBBBBBk",
        "kBBBBBBBBBBk", "kBBBBBBBBBBk", "kBBBBBBBBBBk", "kBBBBBBBBBBk",
        "kBBBBBBBBBBk", "kBmBBBBBBmBk", "kBBBBBBBBBBk", "kkkkkkkkkkkk",
    },
    castle = {
        "....B..B....", "....BBBB....", "....BkkB....", "B.B.BBBB.B.B",
        "BBBBBBBBBBBB", "BBBBBBBBBBBB", "mmmmmmmmmmmm", "BBBBBkkBBBBB",
        "BBBBkkkkBBBB", "mmmmkkkkmmmm", "BBBBkkkkBBBB", "BBBBkkkkBBBB",
    },
}

Sprite.Alias = {
    house = "castle", home = "castle", user = "oneup", player = "oneup", globe = "pipe", map = "pipe",
    teleport = "pipe", eye = "boo", visuals = "boo", swords = "flower", combat = "flower", target = "bomb",
    crosshair = "bomb", shield = "shell", zap = "star", settings = "gear", ["sliders-horizontal"] = "gear",
    bell = "coin", shop = "coin", code = "qblock", info = "qblock", key = "key", play = "flag",
    quest = "flag", heart = "heart", cookie = "mushroom", ["trash-2"] = "bomb", terminal = "brick",
    ["refresh-cw"] = "pipe", link = "pipe", copy = "brick", check = "star", save = "qblock",
    download = "qblock", upload = "qblock", search = "boo", misc = "qblock", troll = "shell",
}

Sprite.Swaps = {
    oneup = { base = "mushroom", swap = { r = "g" } },
}

Sprite.Templates = {}

function Sprite.Resolve(name)
    name = tostring(name or "qblock"):lower():gsub("^lucide%-", "")
    name = Sprite.Alias[name] or name
    if Sprite.Art[name] or Sprite.Swaps[name] then
        return name
    end
    return "qblock"
end

function Sprite.Template(name)
    if Sprite.Templates[name] then
        return Sprite.Templates[name]
    end
    local swap = Sprite.Swaps[name]
    local rows = Sprite.Art[swap and swap.base or name]
    local recolor = swap and swap.swap or {}
    local height, width = #rows, #rows[1]
    local holder = Draw.New("Frame", { Name = "Sprite", BackgroundTransparency = 1 })
    for y, line in ipairs(rows) do
        local x = 1
        while x <= width do
            local char = line:sub(x, x)
            local stop = x
            while stop < width and line:sub(stop + 1, stop + 1) == char do
                stop += 1
            end
            if char ~= "." then
                Draw.New("Frame", {
                    BackgroundColor3 = Sprite.Palette[recolor[char] or char] or Sprite.Palette.k,
                    Position = UDim2.fromScale((x - 1) / width, (y - 1) / height),
                    Size = UDim2.fromScale((stop - x + 1) / width, 1 / height),
                    Parent = holder,
                })
            end
            x = stop + 1
        end
    end
    Sprite.Templates[name] = holder
    return holder
end

---@param size number  px, multiples of 12 stay crisp
function Sprite.New(parent, name, size)
    local key = Sprite.Resolve(name)
    local image, pending = Assets.Resolve(tostring(name):lower())
    if not image and not pending then
        image, pending = Assets.Resolve(key)
    end
    local sprite
    if image then
        sprite = Draw.New("ImageLabel", { BackgroundTransparency = 1, Image = image, ScaleType = Enum.ScaleType.Fit, ResampleMode = Enum.ResamplerMode.Pixelated })
    else
        sprite = Sprite.Template(key):Clone()
        Assets.Later(pending, sprite)
    end
    sprite.Size = UDim2.fromOffset(size, size)
    sprite.Parent = parent
    return sprite
end

---@author xDTaraZ  Mario Hub UI V2
Sprite.Palette.A = Color3.fromRGB(190, 60, 110)
Sprite.Palette.C = Color3.fromRGB(0, 92, 164)
Sprite.Palette.O = Color3.fromRGB(196, 84, 0)
Sprite.Palette.P = Color3.fromRGB(198, 156, 255)
Sprite.Palette.R = Color3.fromRGB(150, 18, 24)
Sprite.Palette.S = Color3.fromRGB(214, 160, 110)
Sprite.Palette.T = Color3.fromRGB(14, 120, 104)
Sprite.Palette.V = Color3.fromRGB(88, 40, 150)
Sprite.Palette.Z = Color3.fromRGB(52, 60, 170)
Sprite.Palette.a = Color3.fromRGB(255, 128, 176)
Sprite.Palette.c = Color3.fromRGB(130, 214, 255)
Sprite.Palette.e = Color3.fromRGB(206, 212, 222)
Sprite.Palette.h = Color3.fromRGB(255, 128, 112)
Sprite.Palette.j = Color3.fromRGB(255, 240, 150)
Sprite.Palette.t = Color3.fromRGB(40, 196, 168)
Sprite.Palette.v = Color3.fromRGB(150, 84, 222)
Sprite.Palette.z = Color3.fromRGB(88, 101, 242)

Sprite.Art.aimbot = {
    "....kkkk....", "..kkhhhrkk..", ".khhwwwwhrk.", ".krwwrrwwRk.",
    "khwwrwwrwwrk", "krwrwrrwrwRk", "krwrwrrwrwRk", "krwwrwwrwwRk",
    ".krwwrrwwRk.", ".krRwwwwRRk.", "..kkrRRRkk..", "....kkkk....",
}
Sprite.Art.ammo = {
    "..kk....kk..", ".kyok..kyok.", "kyoookkyoook", "koooOkkoooOk",
    "kqqqQkkqqqQk", "kqqqQkkqqqQk", "kqqqQkkqqqQk", "kqqqQkkqqqQk",
    "kQQQQkkQQQQk", "kqqqQkkqqqQk", "kqQQQkkqQQQk", ".kkkk..kkkk.",
}
Sprite.Art.antiafk = {
    "....kkkk....", "...khhhrk...", "..khrrrrrk..", "..ksssssSk..",
    "..ksksskssk.", "..ksssssSk..", "..kkrrrRkk..", ".krhbbbbhrk.",
    "..kbbCCbCk..", "..kbCkkbCk..", ".kBmk..kBBk.", "..kk....kk..",
}
Sprite.Art.autofarm = {
    "....k..k....", "...kgkkgk...", "..kgGklGk...", "...kglgGk...",
    ".kkkkgGkkkk.", "kooooBmBBBBk", "kmmmmmkkkkk.", "kBBBmkennnk.",
    "kmmmkeNkknnk", "kBmmknknnknk", ".kkkknnkknNk", ".....kk..kk.",
}
Sprite.Art.axe = {
    ".....kkkk...", "...kkeeenk..", "..keennnBBk.", ".kennnnnBmk.",
    ".knnnnnnBmk.", "..knNNNBmk..", "...kkkkBmk..", ".....komk...",
    ".....kBmk...", "....komk....", "....kBmk....", ".....kk.....",
}
Sprite.Art.bell = {
    ".....kk.....", "....kjyk....", "...kjyyyk...", "..kjyyyyyk..",
    "..kyyyyyYk..", "..kyyyyyYk..", ".kjyyyyyyyk.", "kyYYYYYYYYyk",
    ".kkkkkkkkkk.", "....kyyk....", ".....kk.....", "............",
}
Sprite.Art.boss = {
    ".k.k..k.k...", "kykykkykyk..", "kyjyjjyjYk..", ".kgggggGkk..",
    "klggwgwglgk.", "kggkwgkwgggk", "kgggggggggGk", "kgwkwkwkwgGk",
    "kgggGGggGGk.", ".koOkkoOkk..", "koOOokoOook.", ".kkkk.kkkk..",
}
Sprite.Art.bow = {
    "...kk.......", ".kkBBk......", "kwkkBBk.....", "kwk.kBBk....",
    "kwkkkkBkkkk.", "knnnnnnnnnwk", "kwkkkkBkkkk.", "kwk.komk....",
    "kwkkomk.....", ".kkBmk......", "...kk.......", "............",
}
Sprite.Art.box = {
    ".kkkk..kkkk.", "khrrrkkrrrrk", "krkkk..kkkrk", "krk..kk..krk",
    "krk.kwsk.krk", ".k.kwsssk.k.", ".k.ksssSk.k.", "krk.kbCk.krk",
    "krkkbCCbkkrk", "krkkkkkkkkrk", "krrrrkkrrrRk", ".kkkk..kkkk.",
}
Sprite.Art.bug = {
    "...k....k...", "..kkk..kkk..", "...kkkkkk...", "..kkgllGkk..",
    ".kllgggglgk.", "kkgggkgggkkk", ".kgggkggGkk.", "kkgggkgggkkk",
    ".kgGggggGkk.", "..kkgGGGkk..", ".kkkkkkkkkk.", "..k......k..",
}
Sprite.Art.bulletbill = {
    "............", "....kkkkk...", "..kknnnnNk..", ".kkkNNwwNNk.",
    "knknNNwkNNNk", "kNkNNNNNNNNk", "kNkNNNNNNNNk", "kNkNNwwwNNNk",
    ".kkkNNNNNNk.", "..kkNNNNNk..", "....kkkkk...", "............",
}
Sprite.Art.buy = {
    ".....kkkkkk.", "....kyyyyyqk", "...kyqqqqqQk", "..kyqqkkqqQk",
    ".kyqqqkkqqQk", "kyqqqqqqqQk.", "kqqqqqqqQk..", "kqqqqqqQk...",
    "kqqqqqQk....", "kqqqqQk.....", "kqQQQk......", ".kkkk.......",
}
Sprite.Art.camera = {
    "............", "...kkk......", ".kkeenkkkkk.", "keennneeeenk",
    "knnnwwwwnnNk", "knnwbbbbwnNk", "knnwbkkbwnNk", "knnwbkkbwnNk",
    "knnnwwwwnnNk", "knNNNNNNNNNk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.cart = {
    ".kk.........", "knnk........", ".knkkkkkkkk.", ".kneeeeeeenk",
    ".knnnnnnnNk.", "..knnnnnnNk.", "..knnnnnNk..", "..knnNNNNk..",
    "...knkkknk..", "..krRkkrRk..", "...kk..kk...", "............",
}
Sprite.Art.chams = {
    "....kkkk....", "...kPPPvk...", "..kPvvvvvk..", "..kvvvvvVk..",
    "..kkvvvVkk..", ".kPPvvvvPvk.", "kPvVvvvvVvvk", "kvVkvvvVkvVk",
    ".kkkvvVVkkk.", "...kvVkvvk..", "..kvVVkvVvk.", "...kkk.kkk..",
}
Sprite.Art.chart = {
    "........kk..", ".......kcbk.", ".....kkkbCk.", "....klgkbCk.",
    "....kgGkbCk.", "..kkkgGkbCk.", ".khrkgGkbCk.", ".krRkgGkbCk.",
    ".krRkgGkbCk.", ".kkkkkkkkkk.", "knnnnnnnnnnk", ".kkkkkkkkkk.",
}
Sprite.Art.check = {
    "............", ".........kk.", "........klgk", ".......klgGk",
    ".kk...klgGk.", "klgk.klgGk..", "kgggklgGk...", ".kgglgGk....",
    "..kggGk.....", "...kgk......", "....k.......", "............",
}
Sprite.Art.chest = {
    "..kkkkkkkk..", ".koooooooBk.", "koBBBBBBBBBk", "kBmmmmmmmmmk",
    "kBBBBqqBBBmk", "kqqqqkqqqqQk", "kBBBBqqBBBmk", "kBBBBBBBBBmk",
    "kBmmmmmmmmmk", "kBmmmmmmmmmk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.chomp = {
    "...kkkkkk...", "..knnnnnNk..", ".knNNNNNNNk.", "knNNwkNNNNNk",
    "kNNNkkNNNNNk", "kNNNNNNNNkk.", "kNNNNNNweknk", "kNNNNNNNwwk.",
    ".kNNNNNNNNnk", "..kNNNNNNkk.", "...kkkkkkknk", "..........k.",
}
Sprite.Art.clock = {
    "....kkkk....", "..kkwwwwkk..", ".kwwwkwwwwk.", ".kwwwkwwwek.",
    "kwwwwkwwwwwk", "kwwwwkwwwwek", "kwwwwkkkkwek", "kwwwwwwwwwek",
    ".kwwwwwwwek.", ".kwewwwweek.", "..kkweeekk..", "....kkkk....",
}
Sprite.Art.close = {
    "............", "..kk....kk..", ".khrk..khrk.", ".krrrkkhrRk.",
    "..krrhhrRk..", "...krrrRk...", "...krrrRk...", "..khrRRrrk..",
    ".khrRkkrrrk.", ".krRk..krRk.", "..kk....kk..", "............",
}
Sprite.Art.code = {
    "............", "...k....k...", "..kgk..kgk..", ".klGkk.kggk.",
    "klGkkgk.kggk", "kgk.kgk..kgk", "kgk..kgk.kgk", "kggk.kgkklGk",
    ".kggk.kklGk.", "..kgk..kgk..", "...k....k...", "............",
}
Sprite.Art.collapse = {
    "....k..k....", "...kqkkqk...", ".kkkqkkqkkk.", "kqqqQkkqqqqk",
    ".kkkk..kkkk.", "............", "............", ".kkkk..kkkk.",
    "kqqqqkkyqqqk", ".kkkqkkqkkk.", "...kqkkqk...", "....k..k....",
}
Sprite.Art.collect = {
    "..k..k..k...", ".kykkykkyk..", "..kkkk.kk...", "..kjykkjykk.",
    ".kyyyykyyyyk", "..kyYkkyYkk.", ".kkkk..kkkk.", "kccbkkkkccbk",
    "kbbbccccbbCk", ".kbbbbbbbCk.", "..kbCCCCCk..", "...kkkkkk...",
}
Sprite.Art.config = {
    ".kkkkkkk....", "kwwwwwwwk...", "kwwwwwwwwk..", "kwkkkwwwwwk.",
    "kwwwwwwwwek.", "kwkkkkknNk..", "kwwwwwnnnnk.", "kwkkknnkknnk",
    "kwwwwnnkknNk", "kweeeeNNnNk.", ".kkkkkkknNk.", "........kk..",
}
Sprite.Art.cooldown = {
    "....kkkk....", "..kkcccbkk..", ".kccbkbbcbk.", ".kbbbkbbbCk.",
    "kcbbbkbbbbbk", "kbbbbkkkbbCk", "kbbbbbbbbbCk", "kbbbbbbbbbCk",
    ".kbbbbbbbCk.", ".kbCbbbbCCk.", "..kkbCCCkk..", "....kkkk....",
}
Sprite.Art.copy = {
    ".kkkkkk.....", "kwwwwwwk....", "kwkkkkekkk..", "kwwwwwwwwwk.",
    "kwkkkwwwwwwk", "kwwwwwkkkkek", "kweewwwwwwek", ".kkkwwkkkkek",
    "...kwwwwwwek", "...kwwkkkwek", "...kweeeeeek", "....kkkkkkk.",
}
Sprite.Art.craft = {
    "...kkkkk....", "..keeeenk...", ".kennnnnnk..", "knnnnnnnNk..",
    ".knNnnNNNk..", "..kkBmkkk...", "...kBmk.....", ".kkkBmkkkkk.",
    "koooBBooooBk", "kmmmmmmmmmmk", ".kBmkkkkBmk.", "..kk....kk..",
}
Sprite.Art.credit = {
    "....kkkk....", "...kwwwwk...", "..kwwwwwwk..", "..kwwwwwek..",
    "..kkwwwekk..", ".kyyqqqqyqk.", "kyqqqqqqqqqk", "kqqyqqqqqqQk",
    "kqqqqqyqqqQk", ".kqQQQQQQQk.", "..kkkkkkkk..", "............",
}
Sprite.Art.crosshair = {
    ".....kk.....", "....khrk....", "....krRk....", "....krRk....",
    ".kkk.kk.kkk.", "khhrkhrkhhrk", "krRRkrRkrRRk", ".kkk.kk.kkk.",
    "....khrk....", "....krRk....", "....krRk....", ".....kk.....",
}
Sprite.Art.crown = {
    ".k...kk...k.", "kyk.kjyk.kyk", "kyykkyYkkjYk", "kyyykyYkjyYk",
    "kyyyjyyjyyYk", "kyyyyyyyyyYk", "kyryyyyybyYk", "kyyyyyyyyyYk",
    "kyyyyyyyyyYk", "kqQQQQQQQQQk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.damage = {
    ".k...kk...k.", "kok.kyok.kok", ".kokyyyokok.", ".kkyyyyyokk.",
    "koyoyrryoyok", ".koyrrrryOk.", ".koyrrrryOk.", "koOoyrryoOok",
    ".kkoyyyyOkk.", ".kokoyyOkok.", "kok.koOk.kok", ".k...kk...k.",
}
Sprite.Art.debug = {
    "....kkkk....", "...khhhrk...", "..khrrrrrk..", ".kwrrrrrrwk.",
    ".krrkrrkrRk.", ".krrkrrkrRk.", ".krrrrrrrRk.", "..krrrrrRk..",
    "..ksSSSSSk..", ".ksSkkkkssk.", "..kk....kk..", "............",
}
Sprite.Art.discord = {
    "............", "..kk....kk..", ".kPzkkkkPzk.", "kPzzPPPPzzzk",
    "kzzzzzzzzzZk", "kzzwwzzwwzZk", "kzzwwzzwwzZk", "kzzzzzzzzzZk",
    "kzzzZZZZzzZk", ".kzZkkkkzZk.", "..kk....kk..", "............",
}
Sprite.Art.distance = {
    "............", "............", ".k........k.", "kyk......kyk",
    "kyykkkkkkjYk", "kyyjjjjjjyYk", "kyyYYYYYYyYk", "kyYkkkkkkyYk",
    "kyk......kyk", ".k........k.", "............", "............",
}
Sprite.Art.down = {
    "............", "....kkkk....", "...kcccbk...", "...kbbbCk...",
    "...kbbbCk...", ".kkkbbbCkkk.", "kbccbbbbccbk", ".kbbbbbbbCk.",
    "..kbbbbbCk..", "...kbbbCk...", "....kbCk....", ".....kk.....",
}
Sprite.Art.edit = {
    "........kk..", ".......khrk.", "......khrrrk", ".....kjyrRk.",
    "....kjyyYk..", "...kjyyYk...", "..kjyyYk....", ".kwyyYk.....",
    ".kssSk......", "kkSSk.......", ".kkk........", "............",
}
Sprite.Art.egg = {
    ".....kk.....", "....kwwk....", "...kwwwwk...", "..kwwgggwk..",
    "..kwwgggek..", ".kwwwwwwwwk.", ".kwggwwwwek.", ".kwggwwggek.",
    ".kwwwwwggek.", "..kwwwwwek..", "...kweeek...", "....kkkk....",
}
Sprite.Art.error = {
    "....kkkk....", "..kkhhhrkk..", ".khhrrrrhrk.", ".krwrrrrwRk.",
    "khrwwrrwwrrk", "krrrwwwwrrRk", "krrrrwwrrrRk", "krrrwwwwrrRk",
    ".krwwrrwwRk.", ".krRrrrrRRk.", "..kkrRRRkk..", "....kkkk....",
}
Sprite.Art.esp = {
    "............", "...kkkkkk...", "..kwwwwwwk..", ".kwwwbbwwwk.",
    "kwwwbkkbwwwk", "kwwwbkkbwwek", ".kwwwbbwwek.", "..kweeeeek..",
    ".k.kkkkkkk..", "krkrkrkrkrk.", ".k.k.k.k.k..", "............",
}
Sprite.Art.event = {
    ".....kk.....", "...kkjykk...", "..krkyYkbk..", ".kkkhRCbkkk.",
    "kyykrkkbkyyk", ".kkkgkkvkkk.", "..kgGkkvvk..", ".kgkkkkkkvk.",
    "..k.kook.k..", "...kokkok...", "..kok..kok..", "...k....k...",
}
Sprite.Art.expand = {
    ".kkkk..kkkk.", "kyyyqkkqyyqk", "kqqQk..kqqQk", "kqQk....kqQk",
    "kqk......kqk", ".k........k.", ".k........k.", "kqk......kqk",
    "kqqk....kyQk", "kqqqk..kyqQk", "kqQQqkkqQQQk", ".kkkk..kkkk.",
}
Sprite.Art.export = {
    ".....kk.....", "....kyqk....", "...kyqqqk...", "..kqQqqQqk..",
    "...kkqQkk...", ".kkkkqQkkkk.", "keenkqQknenk", "knNk.kk.knNk",
    "knNkkkkkknNk", "knNnnnnnnNNk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.eye = {
    "............", "...kkkkkk...", "..kwwwwwwk..", ".kwwwwwwwwk.",
    "kwwwwbbwwwwk", "kwwwbkkbwwek", "kwwwbkkbwwek", "kwwwwbbwwwek",
    ".kwwwwwwwek.", "..kweeeeek..", "...kkkkkk...", "............",
}
Sprite.Art.eyeoff = {
    "..........k.", "...kkkkkkkrk", "..kwwwwwhrk.", ".kwwwwwrrek.",
    "kwwwwbrrwwwk", "kwwwbrrbwwek", "kwwwrrkbwwek", "kwwrrbbwwwek",
    ".krrwwwweek.", "khReeeeekk..", "krkkkkkk....", ".k..........",
}
Sprite.Art.farm = {
    "............", "....k..k....", "...kgkkgk...", "..kgGklGk...",
    "...kglgGk...", ".kkkkgGkkkk.", "kooooBBoooBk", "kmmmmmmmmmmk",
    "kBBBBBBBBBmk", "kmmmmmmmmmmk", "kBmmmmmmmmmk", ".kkkkkkkkkk.",
}
Sprite.Art.favorite = {
    "..kkk..kkk..", ".khhrkkhhrk.", "khrrrhhrrrrk", "krwrrrrrrrRk",
    "krwrrrrrrrRk", "krrrrrrrrrRk", ".krrrrrrrRk.", "..krrrrrRk..",
    "...krrrRk...", "....krRk....", ".....kk.....", "............",
}
Sprite.Art.feather = {
    "........kk..", ".......kjyk.", "......kjyyyk", ".....kjyyyek",
    "....kjyyyek.", "...kjyyyek..", "..kjyyyek...", ".kjyyyek....",
    ".kyyYek.....", ".kwekk......", "kwkk........", ".k..........",
}
Sprite.Art.filter = {
    ".kkkkkkkkkk.", "kyyyyyyyyyqk", "kqqqqqqqqqQk", ".kqqqqqqqQk.",
    "..kqqqqqQk..", "...kqqqQk...", "...kqqqQk...", "...kqqqQk...",
    "...kqqqQk...", "....kqqQk...", ".....kqQk...", "......kk....",
}
Sprite.Art.fire = {
    ".....k......", "....krk.....", "...khRk..k..", "...krrrkkrk.",
    "..khrorrkrk.", ".khrooorhRk.", ".krroyyorRk.", "khroyyyyorrk",
    "krroyyyyorRk", ".krroyyorRk.", "..krRRRRRk..", "...kkkkkk...",
}
Sprite.Art.fish = {
    "............", "......kk....", "....kkcbk.k.", "...kccbbbkbk",
    "..kcbbbbbcCk", ".kcwkbbbbbCk", ".kbkkbbbbbCk", "..kbbbbbbCCk",
    "...kbCbbCkbk", "....kkbCk.k.", "......kk....", "............",
}
Sprite.Art.fling = {
    "........k...", ".......krk..", "......khRk..", ".....khrrrk.",
    "....khssRRk.", "...khsSSkk..", "..kcbCkk....", ".kcbCCk.....",
    ".kbCkk......", "kyOk........", "koOk........", ".kk.........",
}
Sprite.Art.fly = {
    "............", ".kk......kk.", "kwwk....kwwk", "kwwwk..kwwek",
    "kwwwwkkwwwek", ".kwwwhhwwek.", "..kwrrrrek..", "...krrrRk...",
    "....krRk....", ".....kk.....", "............", "............",
}
Sprite.Art.fog = {
    "............", "....kkkk....", "...kwwwwk...", ".kkwwwwwwkk.",
    "kwweeeeeewwk", ".kkkkkkkkkk.", ".kwwwwwwwwwk", ".kkkkkkkkkk.",
    "kwwwwwwwwk..", ".kkkkkkkkkk.", "..kwwwwwwwwk", "...kkkkkkkk.",
}
Sprite.Art.folder = {
    ".kkkk.......", "kyyyqk......", "kqqqqqkkkkk.", "kqqqqqyyyyqk",
    "kqqqqqqqqqQk", "kqqqqqqqqqQk", "kqqqqqqqqqQk", "kqqqqqqqqqQk",
    "kqqqqqqqqqQk", "kqQQQQQQQQQk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.follow = {
    "............", "...kkk...kk.", "..khhrk.klgk", ".khrrrrklgGk",
    ".ksssSkkssSk", ".krbbRkkgbGk", ".kbCCCkkbCCk", ".kbkkbkkbkbk",
    ".kk.kk.kk.k.", "kookookook..", ".kk.kk.kk...", "............",
}
Sprite.Art.fov = {
    ".kkkkkkkkkk.", "kbccccccccbk", ".kbbbbbbbCk.", ".kbbbbbbbCk.",
    "..kbbbbbCk..", "..kbbbbbCk..", "...kbbbCk...", "...kbbbCk...",
    "....kbCk....", "....krRk....", "....krRk....", ".....kk.....",
}
Sprite.Art.fpsboost = {
    ".kkkkkkkkkk.", "keeeeeeeeenk", "knNNNNyyNNNk", "knNNNyyNNNNk",
    "knNNyyyyyNNk", "knNNNNyyNNNk", "knNNNyyNNNNk", "knNNNyNNNNNk",
    "knNNnnnnNNNk", ".kkknnnNkkk.", ".knnNNNNnnk.", "..kkkkkkkk..",
}
Sprite.Art.freeze = {
    ".....kk.....", "..k.kcbk.k..", ".kbkkbCkkbk.", "..kbkbCkbk..",
    ".kkkcbbbkkk.", "kcccbwwbccbk", "kbCCbwwbCCCk", ".kkkbbbCkkk.",
    "..kbkbCkbk..", ".kbkkbCkkbk.", "..k.kbCk.k..", ".....kk.....",
}
Sprite.Art.fullauto = {
    "..kk.kk.kk..", ".kyokyokyok.", ".koOkoOkoOk.", ".kqQkqQkqQk.",
    ".kqQkqQkqQk.", ".kqQkqQkqQk.", "knNNnNNnNNNk", "kNNNNNNNNNNk",
    ".kqQkqQkqQk.", ".kqQkqQkqQk.", "..kk.kk.kk..", "............",
}
Sprite.Art.fullbright = {
    ".....kk.....", "...kkjykk...", "..kykyYkyk..", "...kjyyyk...",
    ".kkjyyyyykk.", "kjjyyyyyyjyk", "kyYyyyyyyYYk", ".kkyyyyyYkk.",
    "...kyyyYk...", "..kykyYkyk..", "...kkyYkk...", ".....kk.....",
}
Sprite.Art.gamepad = {
    "............", "..kkkkkkkk..", ".keeeeeeenk.", "kennnnnnnnnk",
    "knkknnnnrnNk", "kkkkknnbnyNk", "knkknnnngnNk", "knnnNNNNnnNk",
    "knnNkkkknnNk", "knNk....knNk", ".kk......kk.", "............",
}
Sprite.Art.gem = {
    "...kkkkkk...", "..kcccccbk..", ".kcwbbbbbbk.", "kcwwbbbbbbbk",
    "kbbbbbbbbbCk", ".kbbbbbbbCk.", "..kbbbbbCk..", "...kbbbCk...",
    "....kbCk....", ".....kk.....", "............", "............",
}
Sprite.Art.goomba = {
    "....kkkk....", "...koooBk...", "..koBBBBBk..", ".kowkBBkwBk.",
    "koBwkBBkwBBk", "kBBBBBBBBBmk", ".kBmBBBBmmk.", "..kksssSkk..",
    "..kwsSSssk..", ".kmmmkkmmmk.", "kmmmmkkmmmmk", ".kkkk..kkkk.",
}
Sprite.Art.gravity = {
    ".....k......", "....kvk.....", "...kPvvk....", "..kvVvVvk...",
    "...kkvkk....", "...kkvkkk...", "..keeneenk..", ".kennnnnnnk.",
    "kennnnnnnnnk", "knnnnnnnnnNk", ".knNNNNNNNk.", "..kkkkkkkk..",
}
Sprite.Art.grid = {
    ".kkkk..kkkk.", "kyyyqkkyyyqk", "kqqqQkkqqqQk", "kqqqQkkqqqQk",
    "kqQQQkkqQQQk", ".kkkk..kkkk.", ".kkkk..kkkk.", "kyyyqkkyyyqk",
    "kqqqQkkqqqQk", "kqqqQkkqqqQk", "kqQQQkkqQQQk", ".kkkk..kkkk.",
}
Sprite.Art.gun = {
    "............", "..........k.", ".kkkkkkkkknk", "keeeeeeeeeNk",
    "knnnnnnnNNNk", ".kBBBNkkkkk.", ".kBBmkkkk...", "koBBmk.k....",
    "kBBmk.......", "kBmmk.......", ".kkk........", "............",
}
Sprite.Art.headshot = {
    "...kkkkkk...", "..kwwwwwwk..", ".kwwwwwwwwk.", "kwwwwrrwwwwk",
    "kwwwwrrwwwek", "kwkkwwwwkkek", "kwkkwwwwkkek", "kwwwwkkwwwek",
    ".kwwwwwwwek.", "..kwkwkwkk..", "..kweeeeek..", "...kkkkkk...",
}
Sprite.Art.heal = {
    "....kkkk....", "...kwwwwk...", "...kwrrek...", ".kkkwrrekkk.",
    "kwwwwrrwwwwk", "kwrrrrrrrrek", "kwrrrrrrrrek", "kweewrrweeek",
    ".kkkwrrekkk.", "...kwrrek...", "...kweeek...", "....kkkk....",
}
Sprite.Art.health = {
    "..kkk..kkk..", ".khhrkkhhrk.", "khrrrhhrrrrk", "krrrrwwrrrRk",
    "krrrrwwrrrRk", "krrwwwwwwrRk", ".krwwwwwwRk.", "..krrwwrRk..",
    "...krwwRk...", "....krRk....", ".....kk.....", "............",
}
Sprite.Art.highlight = {
    "....kkkk....", "...kjjjyk...", "..kjssssyk..", "..kyssssYk..",
    "..kkyssYkk..", ".kjjbbbbjyk.", "kjbbCbbCbbyk", "kyCYkbCkyCYk",
    "kykycbCcYkyk", ".kkybYkybyk.", "..kyYYkyYYk.", "...kkk.kkk..",
}
Sprite.Art.hitchance = {
    ".kkkkkkkkkk.", "kwwwwwwwwwwk", "kwkkwwwwkkek", "kwkkwwwwkkek",
    "kwwwwwwwwwek", "kwwwwkkwwwek", "kwwwwkkwwwek", "kwwwwwwwwwek",
    "kwkkwwwwkkek", "kwkkwwwwkkek", "kweeeeeeeeek", ".kkkkkkkkkk.",
}
Sprite.Art.home = {
    ".....kk.....", "....khrk....", "...khrrrk...", "..khrrrrrk..",
    ".khrrrrrrrk.", "krrrrrrrrrrk", ".kwwwwwwwek.", ".kwbbwBBBek.",
    ".kwbbwBBBek.", ".kwwwwBBBek.", ".kweeemmmek.", "..kkkkkkkk..",
}
Sprite.Art.hop = {
    "....kkkk....", "...klllgk...", "..klgggggk..", ".klgggggggk.",
    ".kgggggggGk.", "..kggGGgGk..", "...kgkkgk...", "...kgkkgk...",
    "..kgGkkggk..", ".kkkkkkkkkk.", "kyyyyyyyyyyk", ".kkkkkkkkkk.",
}
Sprite.Art.ice = {
    "..kkkkkkkk..", ".kcccccccbk.", "kcwwbbbbbbbk", "kbwbbbbbbbCk",
    "kbbbbbbbbbCk", "kbbbbbbbbbCk", "kbbbbbbbbbCk", "kbbbbbbbbwCk",
    "kbbbbbbbwwCk", ".kbCCCCCCCk.", "..kkkkkkkk..", "............",
}
Sprite.Art.import = {
    "....kkkk....", "...klllgk...", "..kkgggGkk..", ".kglgggglgk.",
    "..kgggggGk..", ".kkkgggGkkk.", "koBkkgGkkoBk", "kBBBkkkkoBmk",
    "kBBBooooBBmk", "kBmmmmmmmmmk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.infjump = {
    "............", "............", "..kkk..kkk..", ".kgggkkgggk.",
    "kgkkklgkkkgk", "kgk.kgGk.kgk", "kgkkkgGkkkgk", ".kgggkkgggk.",
    "..kkkkkkkk..", "...kwwwwk...", "....kkkk....", "............",
}
Sprite.Art.info = {
    "....kkkk....", "..kkcccbkk..", ".kccbwwbcbk.", ".kbbbwwbbCk.",
    "kcbbbbbbbbbk", "kbbbwwwbbbCk", "kbbbbwwbbbCk", "kbbbbwwbbbCk",
    ".kbbwwwwbCk.", ".kbCbbbbCCk.", "..kkbCCCkk..", "....kkkk....",
}
Sprite.Art.jump = {
    "....kkk.....", "...khhrkk...", "..khrrrhrk..", "..kssssSk...",
    ".khrrrrRkk..", "krRbbbbrrsk.", ".kkbCCbCkk..", ".kcCkkbCk...",
    "kbCk..kbbk..", ".kkkkkkkk...", "..kyyyyyyk..", "...kkkkkk...",
}
Sprite.Art.keybind = {
    ".kkkkkkkkkk.", "kwwwwwwwwwwk", "kwwwwwwwwwek", "kwwwkkkkwwek",
    "kwwkwwwwkwek", "kwwkwwwwkwek", "kwwkkkkkkwek", "kwwkwwwwkwek",
    "kwwkwwwwkwek", "kwwwwwwwwwek", "knNNNNNNNNNk", ".kkkkkkkkkk.",
}
Sprite.Art.keyboard = {
    "............", ".kkkkkkkkkk.", "kwwwwwwwwwwk", "kwkwkwkwkwek",
    "kwwwwwwwwwek", "kwwkwkwkwkek", "kwwwwwwwwwek", "kwwkkkkkkwek",
    "kwwwwwwwwwek", "knNNNNNNNNNk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.killaura = {
    "...kkkkkk...", "..kooooook..", ".kokkkkkkok.", "kok....kwkok",
    "kok...kwkkok", "kokk.kwk.kok", "kokNkwk..kok", "kokkNk...kok",
    "kokNONk..kok", ".kokkkkkkok.", "..kooooook..", "...kkkkkk...",
}
Sprite.Art.knife = {
    "..........k.", ".........kwk", "........kwek", ".......kwek.",
    "......kwek..", ".....kwek...", "...kkwek....", "..kqyek.....",
    "...kqk......", "..komk......", ".kBmk.......", "..kk........",
}
Sprite.Art.language = {
    "....kkkk....", "..kkcccbkk..", ".kccgggbcbk.", ".kbggggbbCk.",
    "kcbbggbgggbk", "kbbbbbbgggCk", "kbbbbbbbggCk", "kbggbbbbbbCk",
    ".kbgggbbbCk.", ".kbCggbbCCk.", "..kkbCCCkk..", "....kkkk....",
}
Sprite.Art.left = {
    ".....k......", "....kbk.....", "...kcCk.....", "..kcbCkkkk..",
    ".kcbbbcccbk.", "kcbbbbbbbCk.", "kbbbbbbbbCk.", ".kbbbbCCCCk.",
    "..kbbCkkkk..", "...kbCk.....", "....kbk.....", ".....k......",
}
Sprite.Art.lightning = {
    "......kkkk..", ".....kjjjyk.", "....kjyyYk..", "...kjyyYk...",
    "..kjyyYkk...", ".kyYYyyjyk..", "..kkkyyyYk..", "...kjyYYk...",
    "..kjYYkk....", ".kyYkk......", "kykk........", ".k..........",
}
Sprite.Art.link = {
    "............", "..kkkk......", ".kennnk.....", "keNkknnkk...",
    "knNkknNnnk..", ".knenNkknnk.", ".knNkkenNNk.", "..knneNkknnk",
    "...kknNkknNk", ".....knnnNk.", "......kkkk..", "............",
}
Sprite.Art.list = {
    "............", ".kk.kkkkkkk.", "kqqkwwwwwwwk", ".kk.kkkkkkk.",
    "kqqkwwwwwwwk", ".kk.kkkkkkk.", "kqqkwwwwwwwk", ".kk.kkkkkkk.",
    "kqqkwwwwwwwk", ".kk.kkkkkkk.", "............", "............",
}
Sprite.Art.load = {
    ".....kk.....", "....klgk....", "....kgGk....", "...kkgGkk...",
    "..kglgglgk..", "...kgggGk...", "....kgGk....", ".kkkkkkkkkk.",
    "keennnnnnenk", "knNkkkkkknNk", "knNnnnnnnNNk", ".kkkkkkkkkk.",
}
Sprite.Art.lock = {
    "....kkkk....", "...kennnk...", "..keNkknnk..", "..knk..knk..",
    ".kknkkkknkk.", "kyyqyyyyqyqk", "kqqqqkkqqqQk", "kqqqqkkqqqQk",
    "kqqqqqkqqqQk", "kqqqqqqqqqQk", "kqQQQQQQQQQk", ".kkkkkkkkkk.",
}
Sprite.Art.loot = {
    "....kkkk....", "...kneenk...", "...kknNkk...", "..kooBBoBk..",
    ".koBBBBBBBk.", "koBBByyBBBBk", "kBBByyyyBBmk", "kBBByyyyBBmk",
    "kBBBByyBBBmk", ".kBBBBBBBmk.", "..kBmmmmmk..", "...kkkkkk...",
}
Sprite.Art.lowfps = {
    ".kkkkkkkkkk.", "keeeeeeeeenk", "knNNNrrNNNNk", "knNNNrrNNNNk",
    "knNNNrrNNNNk", "knNrrrrrrNNk", "knNNrrrrNNNk", "knNNNrrNNNNk",
    "knNNnnnnNNNk", ".kkknnnNkkk.", ".knnNNNNnnk.", "..kkkkkkkk..",
}
Sprite.Art.magnet = {
    "..kkk..kkk..", ".khhrkkhhrk.", ".krrRkkrrRk.", ".krrRkkrrRk.",
    ".krrRkkrrRk.", ".krrRkkrrRk.", ".krrrhhrrRk.", "..krRRRRRk..",
    "...kkkkkk...", "............", "............", "............",
}
Sprite.Art.main = {
    "............", "..k..k...k..", ".kykkyk.kyk.", ".kyykyykjYk.",
    ".kyyjyyjyYk.", ".kyCYYYYRYk.", "..kkkkkkkk..", ".khhhhhhhrk.",
    ".krwwwwwwRk.", ".krwwwwwwRk.", ".krRRRRRRRk.", "..kkkkkkkk..",
}
Sprite.Art.map = {
    "............", ".kkk.kkk.kk.", "kjjykjjykjyk", "kyyyjyyyjyYk",
    "kyyryyyyyyYk", "kyryryyygyYk", "kyyyrrrgggYk", "kyyyyyyygyYk",
    "kyyYyyyYyyYk", "kyYkyYYkyYYk", ".kk.kkk.kkk.", "............",
}
Sprite.Art.menu = {
    "............", ".kkkkkkkkkk.", "kyyyyyyyyyqk", "kqQQQQQQQQQk",
    ".kkkkkkkkkk.", "kyyyyyyyyyqk", "kqQQQQQQQQQk", ".kkkkkkkkkk.",
    "kyyyyyyyyyqk", "kqQQQQQQQQQk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.mine = {
    "....kkkk....", "...keeenk...", "..kennnnnk..", ".kenyynnnnk.",
    ".knnyyNnbbnk", "kennnNnnbbNk", "knnbbnnnnnNk", "knnbbnNnyyNk",
    "knnnnNnnyyNk", ".knNNNNNNNk.", "..kkkkkkkk..", "............",
}
Sprite.Art.minus = {
    "............", "............", "............", "..kkkkkkkk..",
    ".khhhhhhhrk.", ".krrrrrrrRk.", ".krRRRRRRRk.", "..kkkkkkkk..",
    "............", "............", "............", "............",
}
Sprite.Art.misc = {
    "...kkkkkk...", "..kjjjjjyk..", ".kjyyyyyyyk.", "kjyrryyyyyyk",
    "kyyrryyggyYk", "kyyyyyyggyYk", "kyyyyyyyyyYk", "kyybbyyyyyYk",
    "kyybbyyvvyYk", ".kyyyyyvvYk.", "..kyYYYYYk..", "...kkkkkk...",
}
Sprite.Art.mobile = {
    "...kkkkkk...", "..keeeeenk..", "..knwwwwNk..", "..knbbbbNk..",
    "..knbbbbNk..", "..knbbbbNk..", "..knbbbbNk..", "..knbbbbNk..",
    "..knwwwwNk..", "..knnwwnNk..", "..knNNNNNk..", "...kkkkkk...",
}
Sprite.Art.money = {
    "............", ".kkkkkkkkkk.", "klllllllllgk", "kgwggggggwGk",
    "kggggwwgggGk", "kgggwggwggGk", "kggggwwgggGk", "kgwggggggwGk",
    "kgGGGGGGGGGk", ".kkkkkkkkkk.", "............", "............",
}
Sprite.Art.moon = {
    "....kkk.....", "...kjjyk....", "..kjyYk.....", ".kjyYk......",
    "kjyyYk......", "kyyyYk......", "kyyyYk......", "kyyyyykk..k.",
    ".kyyyyjykkyk", "..kyyyyyyyk.", "...kyYYYkk..", "....kkkk....",
}
Sprite.Art.more = {
    "............", "............", "............", ".kk..kk..kk.",
    "kyqkkyqkkyqk", "kqQkkqQkkqQk", "kqQkkqQkkqQk", ".kk..kk..kk.",
    "............", "............", "............", "............",
}
Sprite.Art.mouse = {
    "....kkkk....", "...kwwwwk...", "..kwwkwwwk..", ".kwwwkwwwwk.",
    ".kwwwkwwwek.", ".kkkkkkkkkk.", ".kwwwwwwwek.", ".kwwwwwwwek.",
    ".kwwwwwwwek.", "..kwwwwwek..", "...kweeek...", "....kkkk....",
}
Sprite.Art.music = {
    ".....kkkkkk.", "....keeeeenk", "....knNNNNNk", "....knkkkknk",
    "....knk..knk", "....knk..knk", "..kkknk.kknk", ".kPPPNkkPPNk",
    "kPvvvNkPvvNk", "kvvvVkkvvvVk", ".kvVk..kvVk.", "..kk....kk..",
}
Sprite.Art.mute = {
    "......k.....", ".....knk....", ".kkkkeNk....", "keeeenNk..k.",
    "knnnnnnrkkrk", "knnnnnNkhrk.", "knnnnnNkrRk.", "knNNNnnrkkrk",
    ".kkkknNk..k.", ".....knk....", "......k.....", "............",
}
Sprite.Art.nametag = {
    "............", ".kkkkkkkkkk.", "kwwwwwwwwwwk", "kwkkwkwkkwek",
    "kwwwwwwwwwek", "kwkkkwkkkwek", "kweeewweeeek", ".kkkkwekkkk.",
    "...kwsssk...", "...ksssSk...", "...kbCCCk...", "....kkkk....",
}
Sprite.Art.noclip = {
    ".kkkkk.kkkk.", "koomoBkmooBk", "kBBmBmkmBBmk", "kmmmmmkmmmmk",
    "kBBBmkkBBBmk", "kBBBmkwBBBmk", "kmmmmksmmmmk", "kBBBBrrBBBmk",
    "kBBmmkbBmBmk", "kmmmmkbmmmmk", "kBmmmbCmmmmk", ".kkkkkkkkkk.",
}
Sprite.Art.nofall = {
    ".....kk.....", "...kkhrkk...", "..khhrrhrk..", ".khrwwwwrrk.",
    "khRwewwewRrk", "krkkkkkkkkrk", ".kkkkkkkkkk.", "...kkkkkk...",
    "....kwsk....", "....kbCk....", "...kbkkbk...", "....k..k....",
}
Sprite.Art.notify = {
    "..kkkkkkkk..", ".khhhhhhhrk.", "khrrrrrrrrrk", "krrrrwwrrrRk",
    "krrrrwwrrrRk", "krrrrwwrrrRk", "krrrrrrrrrRk", "krrrrwwrrrRk",
    ".krRrrRRRRk.", "..kkrRkkkk..", "...krk......", "....k.......",
}
Sprite.Art.orbit = {
    "....kk......", "...kyykk....", "..kykkyyk...", ".kykkkkkyk..",
    "kykkcccbkyk.", "kykcbbbbcYk.", ".kybbbbbbYk.", "..kybbbbYk..",
    "...kyYYYkk..", "....kkkkyyk.", "........kyk.", ".........k..",
}
Sprite.Art.palette = {
    "...kkkkkk...", "..kwwwwwwk..", ".kwwwwwwwwk.", "kwwrwwbwwwwk",
    "kwwwwwwwgwek", "kwwywwweeeek", "kwwwwwekkkk.", "kwwwvwek....",
    ".kwwwwwwk...", "..kweeeewk..", "...kkkkkk...", "............",
}
Sprite.Art.paste = {
    "....kkkk....", "..kkeeenkk..", ".kyynnnnyqk.", ".kqqqqqqqQk.",
    ".kqwwwwwwQk.", ".kqwkkkkwQk.", ".kqwwwwwwQk.", ".kqwkkkwwQk.",
    ".kqwwwwwwQk.", ".kqwkkkkwQk.", ".kqQQQQQQQk.", "..kkkkkkkk..",
}
Sprite.Art.pause = {
    "............", "..kkk..kkk..", ".kyyqkkyyqk.", ".kqqQkkqqQk.",
    ".kqqQkkqqQk.", ".kqqQkkqqQk.", ".kqqQkkqqQk.", ".kqqQkkqqQk.",
    ".kqqQkkqqQk.", ".kqQQkkqQQk.", "..kkk..kkk..", "............",
}
Sprite.Art.pc = {
    ".kkkkkkkkkk.", "keeeeeeeeenk", "knbbbbbbbbNk", "knbbbbbbbbNk",
    "knbbbbbbbbNk", "knbbbbbbbbNk", "knNNNnnNNNNk", ".kkkknNkkkk.",
    "...kknNkk...", "..knnNNnnk..", "...kkkkkk...", "............",
}
Sprite.Art.pet = {
    "..kk....kk..", ".koBk..koBk.", "koBBBkkoBBBk", "kBBBBooBBBmk",
    ".kBBBBBBBmk.", ".kBkBBBBkmk.", ".kBBBBBBBmk.", ".kBBBkkBBmk.",
    "..kBBrrBmk..", "...kBmmmk...", "....kkkk....", "............",
}
Sprite.Art.pickaxe = {
    "...kkkkkk...", "..keeeeenk..", ".kenNnnNnnk.", "kenNkBmknnnk",
    "knNkkBmkknNk", ".kk.kBmk.kk.", "....kBmk....", "....kBmk....",
    "....kBmk....", "....kBmk....", "....kBmk....", ".....kk.....",
}
Sprite.Art.pin = {
    "....kkkk....", "...khhhrk...", "..khrrrrrk..", "..krwrrrRk..",
    "..krrrrrRk..", "...krrrRk...", "....knNk....", "....knNk....",
    "....knNk....", "....knk.....", ".....k......", "............",
}
Sprite.Art.plant = {
    "..kk....kk..", ".klgk..klgk.", "kggggkklgggk", ".kgGGllGGGk.",
    "..kkkgGkkk..", "..kkkgGkkk..", ".koooBBooBk.", ".krrrrrrrRk.",
    "..krrrrrRk..", "..krrrrrRk..", "...krRRRk...", "....kkkk....",
}
Sprite.Art.play = {
    "..k.........", ".kgkk.......", ".kglgkk.....", ".kggglgkk...",
    ".kggggglgkk.", ".kggggggglgk", ".kgggggggGGk", ".kgggggGGkk.",
    ".kgggGGkk...", ".kgGGkk.....", ".kgkk.......", "..k.........",
}
Sprite.Art.player = {
    "....kkkk....", "...khhhrkk..", "..khrrrRrrk.", "..ksssSkkk..",
    "..ksssssk...", "...ksssSk...", "..khbbbbrk..", ".krrbbbbrrk.",
    "..kbbCCbCk..", "..kbCkkbCk..", ".kBmmkkBmBk.", "..kkk..kkk..",
}
Sprite.Art.players = {
    "...kkk......", "..khhrkkkk..", ".khrrRhllgk.", ".kssSkgggggk",
    ".kssssksssSk", ".krbbRkssSk.", "krrbbrlgbbgk", ".kbCCbgbbbCk",
    ".kbkkbbbCbCk", "kBmkkBbCkbCk", ".kk..kBmkBmk", "......kk.kk.",
}
Sprite.Art.plus = {
    "............", "....kkkk....", "...klllgk...", "..kkgggGkk..",
    ".kllgggglgk.", ".kgggggggGk.", ".kgggggggGk.", ".kgGggggGGk.",
    "..kkgggGkk..", "...kgGGGk...", "....kkkk....", "............",
}
Sprite.Art.pow = {
    ".kkkkkkkkkk.", "kcccccccccbk", "kbwwwwwwwwCk", "kbwbbbbbbwCk",
    "kbwbkkkbbwCk", "kbwbkbkbbwCk", "kbwbkkkbbwCk", "kbwbkbbbbwCk",
    "kbwbbbbbbwCk", "kbwwwwwwwwCk", "kbCCCCCCCCCk", ".kkkkkkkkkk.",
}
Sprite.Art.power = {
    ".....kk.....", "..k.khrk.k..", ".krkkrRkkrk.", "khRkkrRkkrrk",
    "krk.krRk.krk", "krk..kk..krk", "krk......krk", "krrk....khRk",
    ".krrkkkkhRk.", "..krrrrrRk..", "...kkkkkk...", "............",
}
Sprite.Art.pswitch = {
    "............", "............", "...kkkkkk...", "..kcccccbk..",
    ".kcbwwwwbbk.", ".kbbwbbwbCk.", ".kbbwwwwbCk.", ".kbbwbbbbCk.",
    "kennnnnnnnnk", "knNNNNNNNNNk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.quest = {
    "..kkkkkkkk..", ".kwwwwwwwwk.", "kwwwwwwwwwwk", "kwwkkkkkkwek",
    "kwwwwwwwwwek", "kwwkkkkwwwek", "kwwwwwwwwwek", "kwwkkkkkwwek",
    "kwwwwwwwwwek", "kwwwwwwwwwek", ".kweeeeeeek.", "..kkkkkkkk..",
}
Sprite.Art.quickbar = {
    "............", "............", ".kkkkkkkkkk.", "keeeeeeeeenk",
    "knyynggnrrNk", "knyynggnrrNk", "knyynggnrrNk", "knNNNNNNNNNk",
    ".kkkkkkkkkk.", "............", "............", "............",
}
Sprite.Art.radar = {
    "....kkkk....", "..kklllgkk..", ".kllGGGGlgk.", ".kgGGgGGGGk.",
    "klGGGgGGlGgk", "kgGgggGGGGGk", "kgGGGlgGGGGk", "kgGGGGGgGGGk",
    ".kgGlGGGGGk.", ".kgGGGGGGGk.", "..kkgGGGkk..", "....kkkk....",
}
Sprite.Art.ragebot = {
    "..k..k..k...", ".kokkykkok..", ".kookyokook.", "..kojoyyOk..",
    ".kwwwwwwwwk.", "kwrwwwwwwrwk", "kwrrwwwwrrek", "kwwwwkkwwwek",
    ".kwwwwwwwek.", "..kwkwkwkk..", "..kweeeeek..", "...kkkkkk...",
}
Sprite.Art.rapidfire = {
    "...kkkkkk...", ".kkyyyyyok..", "kwkqQQQOOok.", ".k.kkkkkkk..",
    ".kkyyyyyok..", "kwkqQQQOOok.", ".k.kkkkkkk..", ".kkyyyyyok..",
    "kwkqQQQOOok.", ".k.kkkkkkk..", "............", "............",
}
Sprite.Art.rebirth = {
    "....kkkk....", "..kklllgk...", ".klgGGGGgk..", "klGkkkkkkgk.",
    "kgk....k.k..", "kgk...kgk...", "kgk..klggk..", "kggkklgGGgk.",
    ".kgglgGkkk..", "..kkgGGk....", "....kkk.....", "............",
}
Sprite.Art.recoil = {
    "..kkkkkkkk..", ".khhhhhhhrk.", "krRRRrrRRRrk", ".kkkknNkkkk.",
    "...knNk.....", "....knnk....", "...knNk.....", "..kkknnkkk..",
    ".khhhrrhhrk.", "krRRRRRRRRrk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.refresh = {
    "....kkkk....", "..kkggggkk..", ".klgkkkkggk.", "klGk....kggk",
    "kgk.....kkk.", "kgk....kglgk", "kgk.....kgGk", "kggk...kgkgk",
    ".kggkkkkggk.", "..kkggggkk..", "....kkkk....", "............",
}
Sprite.Art.rejoin = {
    "......kkkkk.", ".....kooooBk", ".....kBmmmmk", "....klBmmmmk",
    ".kkkkggmmmmk", "kllllgggmymk", "kgGGGgggmmmk", ".kkkkggmmmmk",
    "....kgBmmmmk", ".....kBmmmmk", ".....kBmmmmk", "......kkkkk.",
}
Sprite.Art.right = {
    "......k.....", ".....kbk....", ".....kbbk...", "..kkkkbbbk..",
    ".kccccbbbbk.", ".kbbbbbbbbbk", ".kbbbbbbbbCk", ".kbCCCbbbCk.",
    "..kkkkbbCk..", ".....kbCk...", ".....kbk....", "......k.....",
}
Sprite.Art.save = {
    ".kkkkkkkkk..", "kccccccccbk.", "kbbwwwwwbbbk", "kbbwwwwwbbCk",
    "kbbwwwwwbbCk", "kbbbbbbbbbCk", "kbbbbbbbbbCk", "kbbnnnnnnbCk",
    "kbbnnnnnnbCk", "kbbnnnnnnbCk", "kbCCCCCCCCCk", ".kkkkkkkkkk.",
}
Sprite.Art.search = {
    "...kkkk.....", "..keeenk....", ".kewwwwnk...", "kewwbbbwnk..",
    "knwbbbbbNk..", "knwbbbbbNk..", "knwwbbbwNk..", ".knwwwwnNk..",
    "..knNNNNnnk.", "...kkkkknnnk", "........knNk", ".........kk.",
}
Sprite.Art.seed = {
    "......kk....", ".....klgk...", "..kkklgGgk..", ".klgkgGkk...",
    "kgggggGk....", ".kgGkgk.....", "..kkkgkk....", "...koBoBk...",
    "..koBBBBBk..", "..kBBBBBmk..", "...kBmmmk...", "....kkkk....",
}
Sprite.Art.sell = {
    "....kkkkkk..", "...klllllgk.", "..klgggggggk", ".klgkgggggGk",
    "klggggyyggGk", "kggggyggggGk", ".kggggyyggGk", "..kgggggygGk",
    "...kgyyyggGk", "....kgggggGk", ".....kgGGGGk", "......kkkkk.",
}
Sprite.Art.server = {
    ".kkkkkkkkkk.", "keeeeeeeeenk", "knkkkkkkgnNk", "knNNNNNNNNNk",
    ".kkkkkkkkkk.", "keeeeeeeeenk", "knkkkkkkgnNk", "knNNNNNNNNNk",
    ".kkkkkkkkkk.", "keeeeeeeeenk", "knkkkkkkRNNk", ".kkkkkkkkkk.",
}
Sprite.Art.settings = {
    ".....kk.....", "..k.kenk.k..", ".knkennnknk.", "..kennnnnk..",
    ".kennkknnnk.", "kennkkkknnnk", "knnnkkkknnNk", ".knnnkknnNk.",
    "..knnnnnNk..", ".knknnnNknk.", "..k.knNk.k..", ".....kk.....",
}
Sprite.Art.shield = {
    ".kkkkkkkkkk.", "kcccccccccbk", "kbwwwwwwwwCk", "kbwwwyywwwCk",
    "kbwwyyyywwCk", "kbwwwyywwwCk", "kbwwwwwwwwCk", ".kbwwwwwwCk.",
    "..kbwwwwCk..", "...kbwwCk...", "....kbCk....", ".....kk.....",
}
Sprite.Art.shop = {
    ".kkkkkkkkkk.", "khwhwhwhwhwk", "krwrwrwrwrek", "krwrwrwrwrek",
    ".kBBBBBBBmk.", ".kBwwwwwwmk.", ".kBwwwwwwmk.", ".kBBBmBBBmk.",
    ".kBwekBBBmk.", ".kBwekBqBmk.", ".kBmmkBmmmk.", "..kkk.kkkk..",
}
Sprite.Art.silentaim = {
    "............", "....kkkkk...", "..kkPPPPvk..", ".kkkvvwwvvk.",
    "knknvvwkvvvk", "kNkNvvvvvvVk", "kNkNvvvvvvVk", "kNkNvwwwvvVk",
    ".kkkvvvvvVk.", "..kkvVVVVk..", "....kkkkk...", "............",
}
Sprite.Art.skeleton = {
    "....kkkk....", "...kwwwwk...", "...kwkkek...", "...kwwwek...",
    "..kkkwekkk..", ".kwwwwwwwwk.", "kwkkkwekkkwk", ".k..kwek..k.",
    "...kwkkwk...", "..kwk..kwk..", ".kwek..kwwk.", "..kk....kk..",
}
Sprite.Art.sky = {
    ".......kk...", "......kjyk..", ".....kjyyyk.", "...kkyyyyyyk",
    "..kwwkyyyYk.", ".kwwwwwyYk..", "kwwwwwwwek..", "kwwwwwwwwwk.",
    ".kweeeeeeek.", "..kkkkkkkk..", "............", "............",
}
Sprite.Art.sort = {
    "...k........", "..kbk..kkkk.", ".kcbbkkrrrrk", "kbCbCbkkkkk.",
    ".kkbkkkrrrk.", "..kbk..kkk..", "..kbk.krrk..", "..kbk..kk...",
    "..kbk.krk...", "...k...k....", "............", "............",
}
Sprite.Art.sound = {
    "......k.....", ".....knk.k..", ".kkkkeNkkbk.", "keeeenNkkkbk",
    "knnnnnNkbkbk", "knnnnnNkbkbk", "knnnnnNkbkbk", "knNNNnNkkkbk",
    ".kkkknNkkbk.", ".....knk.k..", "......k.....", "............",
}
Sprite.Art.spectate = {
    ".....kk.....", "....kenk....", ".kkkennnkkk.", "keennnnnnnnk",
    "knNknnnNkknk", "knncbkbbeeNk", "knnbkkkbnnNk", "knnbbkbbnnNk",
    "knNNNNNNNNNk", ".kkkkkkkkkk.", "............", "............",
}
Sprite.Art.speed = {
    "............", "......kkkk..", ".....khhhrk.", ".kkkkhrrrrrk",
    "kwwwkrwrrrRk", ".kkkkrrrrRk.", "kwwwwksssSk.", ".kkkksssSk..",
    ".kwwwkBmmk..", "..kkkBmkBBk.", ".....kk.kk..", "............",
}
Sprite.Art.spread = {
    ".........kk.", "........kyqk", "......kkkqQk", ".....kyqkkk.",
    ".kkk.kqQkkk.", "keenk.kkkyqk", "knNNk.kkkqQk", ".kkk.kyqkkk.",
    ".....kqQkkk.", "......kkkyqk", "........kqQk", ".........kk.",
}
Sprite.Art.stats = {
    "........kkk.", ".......kglgk", "........kgGk", ".......kgkgk",
    "...k..kgk.k.", "..krkkgk....", ".krkrgk.....", "krk.kgk.....",
    ".kkkkkkkkkk.", "knnnnnnnnnnk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.stop = {
    "............", "..kkkkkkkk..", ".khhhhhhhrk.", ".krrrrrrrRk.",
    ".krrrrrrrRk.", ".krrrrrrrRk.", ".krrrrrrrRk.", ".krrrrrrrRk.",
    ".krrrrrrrRk.", ".krRRRRRRRk.", "..kkkkkkkk..", "............",
}
Sprite.Art.success = {
    "....kkkk....", "..kklllgkk..", ".kllgggglgk.", ".kgggggggek.",
    "klggggggwwgk", "kgggggwwwgGk", "kgwwgwwwggGk", "kggwwwwgggGk",
    ".kggwwgggGk.", ".kgGggggGGk.", "..kkgGGGkk..", "....kkkk....",
}
Sprite.Art.sun = {
    ".....kk.....", "..k.kyok.k..", ".kokkoOkkok.", "..kkjyyykk..",
    ".kkjyyyyykk.", "kyyyyyyyyyok", "koOyyyyyyOOk", ".kkyyyyyYkk.",
    "..kkyyyYkk..", ".kokkoOkkok.", "..k.koOk.k..", ".....kk.....",
}
Sprite.Art.sword = {
    ".........kk.", "........kwwk", ".......kwwek", "......kwwek.",
    "...k.kwwek..", "..kqkwwek...", "...kqwek....", "....kqQk....",
    "...kBkkqk...", "..kBk..k....", ".kBk........", "..k.........",
}
Sprite.Art.table = {
    ".kkkkkkkkkk.", "kcccccccccbk", "kbbbbbbbbbCk", "kwwwkwwwkwek",
    "kwwwkwwwkwek", "kkkkkkkkkkkk", "kwwwkwwwkwek", "kwwwkwwwkwek",
    "kkkkkkkkkkkk", "kwwwkwwwkwek", "kweekeeekeek", ".kkkkkkkkkk.",
}
Sprite.Art.teleport = {
    "...k....k...", "..kvkkkkvk..", ".kvkkvvkkvk.", ".kkkvkkvkkk.",
    "klllgllgllgk", "kgggggggggGk", ".kgggggggGk.", ".kgggggggGk.",
    ".kgggggggGk.", ".kgggggggGk.", ".kgGGGGGGGk.", "..kkkkkkkk..",
}
Sprite.Art.terminal = {
    ".kkkkkkkkkk.", "keeeeeeeeenk", "knNNNNNNNNNk", "knNgNNNNNNNk",
    "knNNgNNNNNNk", "knNNNgNNNNNk", "knNNgNNNNNNk", "knNgNNggggNk",
    "knNNNNNNNNNk", "knNNNNNNNNNk", ".kkkkkkkkkk.", "............",
}
Sprite.Art.theme = {
    ".....kk.....", "....kkkk....", "...kkkk.....", "..kkkkkkk...",
    ".khrrrhhrk..", ".krrrrrrrrk.", ".kyyyyyyyYk.", ".kyyyyyyYk..",
    ".kggggggggk.", ".kbCCCCCCCk.", "..kkkkkkkk..", "............",
}
Sprite.Art.thwomp = {
    "..k.k..k.k..", ".knknkknknk.", "keneneenennk", "knkknnnnkkNk",
    "knwkknnkkwNk", "knwwknnkwwNk", "knnnnnnnnnNk", "knkwkwkwkkNk",
    "knkkkkkkkkNk", "knnNnNNnNnNk", ".knknkknknk.", "..k.k..k.k..",
}
Sprite.Art.timer = {
    ".kkkkkkkkkk.", "kyjjjjjjjjyk", ".kyyyyyyyYk.", "..kwqqqqek..",
    "...kwqqek...", "....kqQk....", "....kwek....", "...kwwwwk...",
    "..kwwqqwwk..", ".kwqqqqqqwk.", "kyYYYYYYYYyk", ".kkkkkkkkkk.",
}
Sprite.Art.touch = {
    "...kkk......", "..ksssk.....", ".kskkksk....", "..kswsk.....",
    "...ksSkkk...", "...ksswwskk.", "..kkssssswsk", ".kwwsssssSk.",
    ".kssssssSk..", "..ksssssSk..", "...ksSSSk...", "....kkkk....",
}
Sprite.Art.tracer = {
    "....kk......", "...kwsk.....", "..kssssk....", "...kbCk.....",
    "..kbbCbk....", "...kykk.....", "....kyk.....", ".....kyk....",
    "......kyk...", "......kkykk.", ".....kyyYyyk", "......kkkkk.",
}
Sprite.Art.trash = {
    "....kkkk....", ".kkkeeenkkk.", "keeennnneenk", "knNNNNNNNNNk",
    ".kkkkkkkkkk.", ".keeeeeeenk.", ".knnknnknNk.", ".knnknnknNk.",
    ".knnknnknNk.", ".knnknnknNk.", "..knNNNNNk..", "...kkkkkk...",
}
Sprite.Art.tree = {
    "....kkkk....", "...klllgk...", "..klgggggk..", ".klgggggggk.",
    "klgggggggggk", "kgggggggggGk", ".kgggggggGk.", "..kgGggGGk..",
    "...kkBmkk...", "....kBmk....", "...kBmmBk...", "....kkkk....",
}
Sprite.Art.triggerbot = {
    ".....kk.....", "....kjyk....", "..kkkkkkkk..", ".keeenneenk.",
    ".knrrnnrrNk.", ".knrrnnrrNk.", ".knnnnnnnNk.", ".knkwkwkwNk.",
    ".knnnNNnnNk.", "..knNkknNk..", "...kk..kk...", "............",
}
Sprite.Art.troll = {
    ".kkkkkkkkkk.", "kwwwwwwwwwwk", "kwkwwwwwwkek", "kwwkkwwkkwek",
    "kwwwkwwkwwek", "kwkwwwwwwkek", "kwwkkkkkkwek", "kwwkwwwwkwek",
    "kwwwkkkkwwek", ".kwwwwwwwek.", "..kweeeeek..", "...kkkkkk...",
}
Sprite.Art.trophy = {
    ".kkkkkkkkkk.", "kjyjjjjjjyyk", "kykyyyyyYkyk", "kykyyyyyYkyk",
    ".kyyyyyyyyk.", "..kyYyyYYk..", "...kkyYkk...", "....kyYk....",
    "...kjyyyk...", "..koBBBBBk..", "..kBmmmmmk..", "...kkkkkk...",
}
Sprite.Art.unlock = {
    "......kkkk..", ".....kennnk.", "....keNkknnk", "....knk..knk",
    ".kkkknkkkkk.", "kyyyyqyyyqk.", "kqqqqkkqqQk.", "kqqqqkkqqQk.",
    "kqqqqqkqqQk.", "kqqqqqqqqQk.", "kqQQQQQQQQk.", ".kkkkkkkkk..",
}
Sprite.Art.unpin = {
    "....kkkk..k.", "...khhhrkknk", "..khrrrrhnk.", "..krwrrrNk..",
    "..krrrrNk...", "...krrNk....", "....knk.....", "...knnnk....",
    "..knknNk....", ".knkknk.....", "knk..k......", ".k..........",
}
Sprite.Art.up = {
    ".....kk.....", "....kcbk....", "...kcbbbk...", "..kcbbbbbk..",
    ".kcbbbbbbbk.", "kbCCbbbbCCbk", ".kkkbbbCkkk.", "...kbbbCk...",
    "...kbbbCk...", "...kbCCCk...", "....kkkk....", "............",
}
Sprite.Art.upgrade = {
    ".....kk.....", "....klgk....", "...klgggk...", "..klgggggk..",
    ".klgggggggk.", "kgGGggggGGgk", ".kkkgggGkkk.", "...kgggGk...",
    "...kgggGk...", "...kgggGk...", "...kgGGGk...", "....kkkk....",
}
Sprite.Art.walkwater = {
    ".....kk.....", "....khrk....", "...khrrrk...", "...ksssSk...",
    "...krbbRk...", "...kbCCCk...", ".kkkbkkbkkk.", "kcccbccbccbk",
    "kbwbbbwbbbek", "kbbbbbbbbbCk", "kbCCCCCCCCCk", ".kkkkkkkkkk.",
}
Sprite.Art.warn = {
    ".....kk.....", "....kjyk....", "....kyYk....", "...kjyyyk...",
    "...kykkYk...", "..kjykkyyk..", "..kyykkyYk..", ".kjyyyyyyyk.",
    ".kyyykkyyYk.", "kjyyyyyyyyyk", "kyYYYYYYYYYk", ".kkkkkkkkkk.",
}
Sprite.Art.water = {
    ".....kk.....", "....kcbk....", "....kbCk....", "...kcbbbk...",
    "..kcbbbbbk..", ".kcbwbbbbbk.", ".kbwbbbbbCk.", ".kbwbbbbbCk.",
    ".kbbbbbbbCk.", "..kbbbbbCk..", "...kbCCCk...", "....kkkk....",
}
Sprite.Art.waypoint = {
    "....kkkk....", "...khhhrk...", "..khrrrrrk..", ".khrrwwrrrk.",
    ".krrwwwwrRk.", ".krrrwwrrRk.", "..krrrrrRk..", "...krrrRk...",
    "....krRk....", "...kkkkkk...", "..knnnnnnk..", "...kkkkkk...",
}
Sprite.Art.webhook = {
    "....kkkk....", "...kPvvvk...", "..kPVkkvvk..", "..kvVkkvVk..",
    "...kvkkvVk..", "..kPVkPVk...", ".kPVkkvk....", "kPVkkkkkkk..",
    "kvvPPPPPPvk.", ".kvVVVVVVk..", "..kkkkkkk...", "............",
}
Sprite.Art.wind = {
    "............", "......kkk...", ".kkkkkwwwk..", "kwwwwwekkwk.",
    ".kkkkkkkwk..", "kwwwwwwwek..", ".kkkkkkkkk..", "kwwwwwwwwwk.",
    ".kkkkkkkkkwk", ".....kwkkwk.", "......kwwk..", ".......kk...",
}
Sprite.Art.wingcap = {
    ".k........k.", "kwk.kkkk.kwk", "kwwkhhhrkwek", "kwwhrrrrhwek",
    ".krrrwwrrRk.", ".krrrwwrrRk.", "krRRRRRRRRrk", ".kkkkkkkkkk.",
    "............", "............", "............", "............",
}
Sprite.Art.zoom = {
    "...kkkk.....", "..kwwwwk....", ".kwwbbwwk...", "kwwbbbbwwk..",
    "kwbbbbbbek..", "kwbbbbbbek..", "kwwbbbbwek..", ".kwwbbwek...",
    "..kweeennk..", "...kkkknnnk.", ".......knNnk", "........kkk.",
}

Sprite.Alias["home"] = nil
Sprite.Alias["player"] = nil
Sprite.Alias["map"] = nil
Sprite.Alias["teleport"] = nil
Sprite.Alias["eye"] = nil
Sprite.Alias["crosshair"] = nil
Sprite.Alias["shield"] = nil
Sprite.Alias["settings"] = nil
Sprite.Alias["bell"] = nil
Sprite.Alias["shop"] = nil
Sprite.Alias["code"] = nil
Sprite.Alias["info"] = nil
Sprite.Alias["key"] = nil
Sprite.Alias["play"] = nil
Sprite.Alias["quest"] = nil
Sprite.Alias["heart"] = nil
Sprite.Alias["terminal"] = nil
Sprite.Alias["link"] = nil
Sprite.Alias["copy"] = nil
Sprite.Alias["check"] = nil
Sprite.Alias["save"] = nil
Sprite.Alias["search"] = nil
Sprite.Alias["misc"] = nil
Sprite.Alias["troll"] = nil
Sprite.Alias["1-up"] = "oneup"
Sprite.Alias["1up"] = "oneup"
Sprite.Alias["about"] = "info"
Sprite.Alias["accept"] = "check"
Sprite.Alias["access"] = "key"
Sprite.Alias["account"] = "player"
Sprite.Alias["achievement"] = "trophy"
Sprite.Alias["achievements"] = "trophy"
Sprite.Alias["activity"] = "stats"
Sprite.Alias["add"] = "plus"
Sprite.Alias["admin"] = "crown"
Sprite.Alias["afk"] = "antiafk"
Sprite.Alias["afkfarm"] = "autofarm"
Sprite.Alias["aim"] = "aimbot"
Sprite.Alias["aim bot"] = "aimbot"
Sprite.Alias["aim-assist"] = "aimbot"
Sprite.Alias["aim-bot"] = "aimbot"
Sprite.Alias["aim-part"] = "headshot"
Sprite.Alias["aimassist"] = "aimbot"
Sprite.Alias["aimpart"] = "headshot"
Sprite.Alias["air"] = "wind"
Sprite.Alias["air-jump"] = "infjump"
Sprite.Alias["airjump"] = "infjump"
Sprite.Alias["alarm"] = "bell"
Sprite.Alias["alarm-clock"] = "cooldown"
Sprite.Alias["alert"] = "notify"
Sprite.Alias["alert-circle"] = "notify"
Sprite.Alias["alert-triangle"] = "warn"
Sprite.Alias["alerts"] = "bell"
Sprite.Alias["align-justify"] = "menu"
Sprite.Alias["analytics"] = "chart"
Sprite.Alias["anchor"] = "gravity"
Sprite.Alias["anchored"] = "freeze"
Sprite.Alias["android"] = "mobile"
Sprite.Alias["angry"] = "ragebot"
Sprite.Alias["announcement"] = "notify"
Sprite.Alias["annoy"] = "troll"
Sprite.Alias["anti afk"] = "antiafk"
Sprite.Alias["anti-afk"] = "antiafk"
Sprite.Alias["anti-ragdoll"] = "nofall"
Sprite.Alias["antiragdoll"] = "nofall"
Sprite.Alias["anvil"] = "craft"
Sprite.Alias["api"] = "webhook"
Sprite.Alias["app-window"] = "pc"
Sprite.Alias["appearance"] = "theme"
Sprite.Alias["apps"] = "grid"
Sprite.Alias["archery"] = "bow"
Sprite.Alias["archive"] = "folder"
Sprite.Alias["area"] = "map"
Sprite.Alias["areas"] = "map"
Sprite.Alias["armor"] = "shield"
Sprite.Alias["arrow"] = "bow"
Sprite.Alias["arrow-down"] = "down"
Sprite.Alias["arrow-down-from-line"] = "import"
Sprite.Alias["arrow-down-to-line"] = "load"
Sprite.Alias["arrow-down-up"] = "sort"
Sprite.Alias["arrow-left"] = "left"
Sprite.Alias["arrow-right"] = "right"
Sprite.Alias["arrow-up"] = "up"
Sprite.Alias["arrow-up-circle"] = "upgrade"
Sprite.Alias["arrow-up-down"] = "sort"
Sprite.Alias["arrow-up-from-line"] = "export"
Sprite.Alias["ascend"] = "rebirth"
Sprite.Alias["ascend-arrow"] = "up"
Sprite.Alias["atm"] = "money"
Sprite.Alias["atmosphere"] = "fog"
Sprite.Alias["attach"] = "follow"
Sprite.Alias["attack"] = "sword"
Sprite.Alias["attract"] = "magnet"
Sprite.Alias["audio"] = "music"
Sprite.Alias["audio-off"] = "mute"
Sprite.Alias["audio-on"] = "sound"
Sprite.Alias["aura"] = "killaura"
Sprite.Alias["author"] = "credit"
Sprite.Alias["auto"] = "autofarm"
Sprite.Alias["auto buy"] = "buy"
Sprite.Alias["auto farm"] = "autofarm"
Sprite.Alias["auto sell"] = "sell"
Sprite.Alias["auto-buy"] = "buy"
Sprite.Alias["auto-claim"] = "loot"
Sprite.Alias["auto-clicker"] = "mouse"
Sprite.Alias["auto-collect"] = "collect"
Sprite.Alias["auto-farm"] = "autofarm"
Sprite.Alias["auto-fire"] = "triggerbot"
Sprite.Alias["auto-fish"] = "fish"
Sprite.Alias["auto-gun"] = "fullauto"
Sprite.Alias["auto-hatch"] = "egg"
Sprite.Alias["auto-heal"] = "heal"
Sprite.Alias["auto-kill"] = "killaura"
Sprite.Alias["auto-load"] = "load"
Sprite.Alias["auto-mine"] = "mine"
Sprite.Alias["auto-plant"] = "plant"
Sprite.Alias["auto-rejoin"] = "rejoin"
Sprite.Alias["auto-sell"] = "sell"
Sprite.Alias["auto-shoot"] = "triggerbot"
Sprite.Alias["auto-start"] = "play"
Sprite.Alias["auto-water"] = "water"
Sprite.Alias["autobuy"] = "buy"
Sprite.Alias["autoclaim"] = "loot"
Sprite.Alias["autoclick"] = "mouse"
Sprite.Alias["autoclicker"] = "mouse"
Sprite.Alias["autocollect"] = "collect"
Sprite.Alias["autofire"] = "triggerbot"
Sprite.Alias["autofish"] = "fish"
Sprite.Alias["autograb"] = "autofarm"
Sprite.Alias["autohatch"] = "egg"
Sprite.Alias["autoheal"] = "heal"
Sprite.Alias["autokill"] = "killaura"
Sprite.Alias["autoload"] = "load"
Sprite.Alias["automatic"] = "fullauto"
Sprite.Alias["automine"] = "mine"
Sprite.Alias["autoplant"] = "plant"
Sprite.Alias["autorejoin"] = "rejoin"
Sprite.Alias["autosell"] = "sell"
Sprite.Alias["autoshoot"] = "triggerbot"
Sprite.Alias["autostart"] = "play"
Sprite.Alias["autowater"] = "water"
Sprite.Alias["avatar"] = "player"
Sprite.Alias["awake"] = "antiafk"
Sprite.Alias["award"] = "trophy"
Sprite.Alias["back"] = "left"
Sprite.Alias["backpack"] = "chest"
Sprite.Alias["backup"] = "export"
Sprite.Alias["badge"] = "trophy"
Sprite.Alias["badge-check"] = "success"
Sprite.Alias["bag"] = "chest"
Sprite.Alias["bait"] = "fish"
Sprite.Alias["balance"] = "money"
Sprite.Alias["ban"] = "error"
Sprite.Alias["bank"] = "money"
Sprite.Alias["banknote"] = "money"
Sprite.Alias["banned"] = "error"
Sprite.Alias["bar-chart"] = "chart"
Sprite.Alias["bar-chart-2"] = "chart"
Sprite.Alias["base"] = "home"
Sprite.Alias["basket"] = "cart"
Sprite.Alias["bean"] = "seed"
Sprite.Alias["begin"] = "play"
Sprite.Alias["bell-ring"] = "bell"
Sprite.Alias["belt"] = "fullauto"
Sprite.Alias["berserk"] = "ragebot"
Sprite.Alias["best"] = "crown"
Sprite.Alias["bills"] = "money"
Sprite.Alias["bin"] = "trash"
Sprite.Alias["bind"] = "keybind"
Sprite.Alias["binds"] = "keybind"
Sprite.Alias["binoculars"] = "spectate"
Sprite.Alias["bird"] = "fly"
Sprite.Alias["bite"] = "chomp"
Sprite.Alias["blacklist"] = "filter"
Sprite.Alias["blade"] = "knife"
Sprite.Alias["block"] = "shield"
Sprite.Alias["bob-omb"] = "bomb"
Sprite.Alias["bobomb"] = "bomb"
Sprite.Alias["bolt"] = "lightning"
Sprite.Alias["bombs"] = "bomb"
Sprite.Alias["bone"] = "skeleton"
Sprite.Alias["bones"] = "skeleton"
Sprite.Alias["bookmark"] = "favorite"
Sprite.Alias["boom"] = "damage"
Sprite.Alias["boombox"] = "music"
Sprite.Alias["boost"] = "upgrade"
Sprite.Alias["boostfps"] = "fpsboost"
Sprite.Alias["bosses"] = "boss"
Sprite.Alias["bot"] = "triggerbot"
Sprite.Alias["bot-farm"] = "autofarm"
Sprite.Alias["bot-message-square"] = "triggerbot"
Sprite.Alias["bounce"] = "fling"
Sprite.Alias["bounding"] = "box"
Sprite.Alias["bounty"] = "quest"
Sprite.Alias["bowser"] = "boss"
Sprite.Alias["box-esp"] = "box"
Sprite.Alias["box-open"] = "chest"
Sprite.Alias["boxes"] = "box"
Sprite.Alias["boxesp"] = "box"
Sprite.Alias["braces"] = "code"
Sprite.Alias["breakable"] = "brick"
Sprite.Alias["breeze"] = "wind"
Sprite.Alias["brick-wall"] = "noclip"
Sprite.Alias["bricks"] = "brick"
Sprite.Alias["bright"] = "fullbright"
Sprite.Alias["brightness"] = "fullbright"
Sprite.Alias["bring"] = "teleport"
Sprite.Alias["bring-items"] = "magnet"
Sprite.Alias["bringitems"] = "magnet"
Sprite.Alias["brush"] = "theme"
Sprite.Alias["bugs"] = "bug"
Sprite.Alias["build"] = "craft"
Sprite.Alias["bullet"] = "ammo"
Sprite.Alias["bullet-bill"] = "bulletbill"
Sprite.Alias["bullets"] = "ammo"
Sprite.Alias["bullettp"] = "silentaim"
Sprite.Alias["burn"] = "fire"
Sprite.Alias["burst"] = "rapidfire"
Sprite.Alias["button"] = "pswitch"
Sprite.Alias["cam"] = "camera"
Sprite.Alias["camlock"] = "aimbot"
Sprite.Alias["cancel"] = "stop"
Sprite.Alias["cap"] = "wingcap"
Sprite.Alias["cape"] = "feather"
Sprite.Alias["cape-feather"] = "feather"
Sprite.Alias["cash"] = "coin"
Sprite.Alias["cast"] = "fish"
Sprite.Alias["cat"] = "pet"
Sprite.Alias["caution"] = "warn"
Sprite.Alias["cave"] = "mine"
Sprite.Alias["cctv"] = "spectate"
Sprite.Alias["cd"] = "cooldown"
Sprite.Alias["celebrate"] = "event"
Sprite.Alias["chain"] = "link"
Sprite.Alias["chain-chomp"] = "chomp"
Sprite.Alias["chainchomp"] = "chomp"
Sprite.Alias["chance"] = "hitchance"
Sprite.Alias["char"] = "player"
Sprite.Alias["character"] = "player"
Sprite.Alias["chart-bar"] = "chart"
Sprite.Alias["chart-line"] = "stats"
Sprite.Alias["chase"] = "follow"
Sprite.Alias["chat"] = "discord"
Sprite.Alias["check-circle"] = "success"
Sprite.Alias["check-square"] = "check"
Sprite.Alias["checkbox"] = "check"
Sprite.Alias["checkmark"] = "check"
Sprite.Alias["checkout"] = "cart"
Sprite.Alias["checkpoint"] = "waypoint"
Sprite.Alias["checkpoint-flag"] = "flag"
Sprite.Alias["chests"] = "chest"
Sprite.Alias["chevron-down"] = "down"
Sprite.Alias["chevron-left"] = "left"
Sprite.Alias["chevron-right"] = "right"
Sprite.Alias["chevron-up"] = "up"
Sprite.Alias["chevrons-down"] = "down"
Sprite.Alias["chevrons-left"] = "left"
Sprite.Alias["chevrons-right"] = "right"
Sprite.Alias["chevrons-up"] = "up"
Sprite.Alias["chop"] = "axe"
Sprite.Alias["circle"] = "orbit"
Sprite.Alias["circle-check"] = "success"
Sprite.Alias["circle-help"] = "info"
Sprite.Alias["circle-minus"] = "minus"
Sprite.Alias["circle-plus"] = "plus"
Sprite.Alias["circle-x"] = "error"
Sprite.Alias["claim"] = "loot"
Sprite.Alias["clear"] = "trash"
Sprite.Alias["click"] = "mouse"
Sprite.Alias["clicker"] = "mouse"
Sprite.Alias["clip"] = "noclip"
Sprite.Alias["clipboard"] = "copy"
Sprite.Alias["clipboard-copy"] = "paste"
Sprite.Alias["clipboard-list"] = "quest"
Sprite.Alias["clipboard-paste"] = "paste"
Sprite.Alias["clock-3"] = "clock"
Sprite.Alias["clone"] = "copy"
Sprite.Alias["cloud"] = "fog"
Sprite.Alias["cloud-sun"] = "sky"
Sprite.Alias["clouds"] = "sky"
Sprite.Alias["cloudy"] = "fog"
Sprite.Alias["cmd"] = "terminal"
Sprite.Alias["code-2"] = "code"
Sprite.Alias["codes"] = "code"
Sprite.Alias["coffee"] = "antiafk"
Sprite.Alias["cog"] = "settings"
Sprite.Alias["coins"] = "collect"
Sprite.Alias["coins-stack"] = "coin"
Sprite.Alias["cold"] = "freeze"
Sprite.Alias["color"] = "palette"
Sprite.Alias["color-picker"] = "palette"
Sprite.Alias["colorpicker"] = "palette"
Sprite.Alias["colors"] = "palette"
Sprite.Alias["colour"] = "palette"
Sprite.Alias["colours"] = "palette"
Sprite.Alias["columns"] = "table"
Sprite.Alias["combat"] = "sword"
Sprite.Alias["command"] = "keybind"
Sprite.Alias["commands"] = "terminal"
Sprite.Alias["community"] = "discord"
Sprite.Alias["compact"] = "collapse"
Sprite.Alias["companion"] = "pet"
Sprite.Alias["compass"] = "map"
Sprite.Alias["complete"] = "success"
Sprite.Alias["computer"] = "pc"
Sprite.Alias["configs"] = "config"
Sprite.Alias["configure"] = "settings"
Sprite.Alias["confirm"] = "check"
Sprite.Alias["console"] = "gamepad"
Sprite.Alias["console-log"] = "terminal"
Sprite.Alias["consumable"] = "mushroom"
Sprite.Alias["contributors"] = "credit"
Sprite.Alias["controller"] = "gamepad"
Sprite.Alias["cookie"] = "mushroom"
Sprite.Alias["copy-discord"] = "copy"
Sprite.Alias["copy-link"] = "copy"
Sprite.Alias["copylink"] = "copy"
Sprite.Alias["countdown"] = "timer"
Sprite.Alias["crafting"] = "craft"
Sprite.Alias["crate"] = "chest"
Sprite.Alias["crates"] = "chest"
Sprite.Alias["create"] = "plus"
Sprite.Alias["credits"] = "credit"
Sprite.Alias["creep"] = "goomba"
Sprite.Alias["crop"] = "farm"
Sprite.Alias["crops"] = "farm"
Sprite.Alias["cross"] = "heal"
Sprite.Alias["crosshair-2"] = "crosshair"
Sprite.Alias["crown-main"] = "main"
Sprite.Alias["crystal"] = "gem"
Sprite.Alias["crystals"] = "gem"
Sprite.Alias["currency"] = "coin"
Sprite.Alias["cursor"] = "mouse"
Sprite.Alias["dagger"] = "knife"
Sprite.Alias["danger"] = "warn"
Sprite.Alias["dark"] = "moon"
Sprite.Alias["dark-mode"] = "moon"
Sprite.Alias["darkmode"] = "moon"
Sprite.Alias["dash"] = "speed"
Sprite.Alias["dashboard"] = "main"
Sprite.Alias["data-table"] = "table"
Sprite.Alias["database"] = "server"
Sprite.Alias["day"] = "sun"
Sprite.Alias["daytime"] = "clock"
Sprite.Alias["dealer"] = "shop"
Sprite.Alias["decline"] = "lowfps"
Sprite.Alias["decrease"] = "minus"
Sprite.Alias["defense"] = "shield"
Sprite.Alias["defense-tower"] = "castle"
Sprite.Alias["delay"] = "timer"
Sprite.Alias["delete"] = "trash"
Sprite.Alias["desktop"] = "pc"
Sprite.Alias["destroy"] = "trash"
Sprite.Alias["detect"] = "radar"
Sprite.Alias["dev"] = "debug"
Sprite.Alias["developer"] = "debug"
Sprite.Alias["device"] = "mobile"
Sprite.Alias["devtools"] = "debug"
Sprite.Alias["diamond"] = "gem"
Sprite.Alias["dice"] = "hitchance"
Sprite.Alias["dice-5"] = "hitchance"
Sprite.Alias["dices"] = "hitchance"
Sprite.Alias["dig"] = "pickaxe"
Sprite.Alias["directory"] = "folder"
Sprite.Alias["disable"] = "power"
Sprite.Alias["discard"] = "trash"
Sprite.Alias["disk"] = "save"
Sprite.Alias["dismiss"] = "close"
Sprite.Alias["display"] = "pc"
Sprite.Alias["dmg"] = "damage"
Sprite.Alias["document"] = "config"
Sprite.Alias["dog"] = "pet"
Sprite.Alias["dog-chain"] = "chomp"
Sprite.Alias["dollar"] = "sell"
Sprite.Alias["dollar-sign"] = "coin"
Sprite.Alias["done"] = "success"
Sprite.Alias["door"] = "rejoin"
Sprite.Alias["door-open"] = "rejoin"
Sprite.Alias["dots"] = "more"
Sprite.Alias["double-jump"] = "infjump"
Sprite.Alias["doublejump"] = "infjump"
Sprite.Alias["download"] = "load"
Sprite.Alias["drill"] = "pickaxe"
Sprite.Alias["drop"] = "loot"
Sprite.Alias["droplet"] = "water"
Sprite.Alias["droplets"] = "water"
Sprite.Alias["drops"] = "loot"
Sprite.Alias["dungeon"] = "boss"
Sprite.Alias["dungeons"] = "boss"
Sprite.Alias["duplicate"] = "copy"
Sprite.Alias["duration"] = "timer"
Sprite.Alias["dye"] = "palette"
Sprite.Alias["dynamite"] = "bomb"
Sprite.Alias["earth"] = "map"
Sprite.Alias["earth-lock"] = "language"
Sprite.Alias["east"] = "right"
Sprite.Alias["eat"] = "mushroom"
Sprite.Alias["edit-2"] = "edit"
Sprite.Alias["edit-3"] = "edit"
Sprite.Alias["eggs"] = "egg"
Sprite.Alias["electric"] = "lightning"
Sprite.Alias["elite"] = "boss"
Sprite.Alias["ellipsis"] = "more"
Sprite.Alias["empty"] = "used"
Sprite.Alias["enable"] = "power"
Sprite.Alias["end"] = "stop"
Sprite.Alias["enemies"] = "goomba"
Sprite.Alias["enemy"] = "boss"
Sprite.Alias["energy"] = "lightning"
Sprite.Alias["enhance"] = "upgrade"
Sprite.Alias["enlarge"] = "expand"
Sprite.Alias["entries"] = "list"
Sprite.Alias["erase"] = "trash"
Sprite.Alias["etc"] = "more"
Sprite.Alias["events"] = "event"
Sprite.Alias["evolve"] = "rebirth"
Sprite.Alias["exclude"] = "filter"
Sprite.Alias["execute"] = "terminal"
Sprite.Alias["executor"] = "terminal"
Sprite.Alias["exit"] = "rejoin"
Sprite.Alias["exit-close"] = "close"
Sprite.Alias["exp"] = "upgrade"
Sprite.Alias["explode"] = "damage"
Sprite.Alias["exploit"] = "bug"
Sprite.Alias["explosion"] = "damage"
Sprite.Alias["external-link"] = "link"
Sprite.Alias["extra"] = "misc"
Sprite.Alias["extra-life"] = "oneup"
Sprite.Alias["extras"] = "misc"
Sprite.Alias["eye-off"] = "eyeoff"
Sprite.Alias["fail"] = "error"
Sprite.Alias["failed"] = "error"
Sprite.Alias["faq"] = "info"
Sprite.Alias["farming"] = "farm"
Sprite.Alias["fast"] = "speed"
Sprite.Alias["fastmode"] = "lightning"
Sprite.Alias["fatal"] = "error"
Sprite.Alias["fav"] = "favorite"
Sprite.Alias["favorites"] = "favorite"
Sprite.Alias["favourite"] = "favorite"
Sprite.Alias["feather-fall"] = "nofall"
Sprite.Alias["festival"] = "event"
Sprite.Alias["field-of-view"] = "fov"
Sprite.Alias["fight"] = "sword"
Sprite.Alias["file"] = "config"
Sprite.Alias["file-cog"] = "config"
Sprite.Alias["file-text"] = "config"
Sprite.Alias["files"] = "folder"
Sprite.Alias["filters"] = "filter"
Sprite.Alias["find"] = "search"
Sprite.Alias["finger"] = "touch"
Sprite.Alias["finish"] = "flag"
Sprite.Alias["fire-flower"] = "flower"
Sprite.Alias["fire-rate"] = "rapidfire"
Sprite.Alias["fireball"] = "fire"
Sprite.Alias["fireflower"] = "flower"
Sprite.Alias["firerate"] = "rapidfire"
Sprite.Alias["first-aid"] = "heal"
Sprite.Alias["fishing"] = "fish"
Sprite.Alias["fishing-rod"] = "fish"
Sprite.Alias["flag-th"] = "language"
Sprite.Alias["flag-triangle-right"] = "flag"
Sprite.Alias["flame"] = "fire"
Sprite.Alias["flames"] = "fire"
Sprite.Alias["flask"] = "debug"
Sprite.Alias["flight"] = "fly"
Sprite.Alias["float"] = "fly"
Sprite.Alias["floppy"] = "save"
Sprite.Alias["flowerpot"] = "plant"
Sprite.Alias["flying"] = "fly"
Sprite.Alias["folder-open"] = "folder"
Sprite.Alias["folders"] = "folder"
Sprite.Alias["food"] = "mushroom"
Sprite.Alias["footprints"] = "speed"
Sprite.Alias["forest"] = "tree"
Sprite.Alias["forge"] = "craft"
Sprite.Alias["fortress"] = "castle"
Sprite.Alias["forward"] = "right"
Sprite.Alias["fov-camera"] = "camera"
Sprite.Alias["fov-circle"] = "fov"
Sprite.Alias["fovcircle"] = "fov"
Sprite.Alias["fps"] = "fpsboost"
Sprite.Alias["fps-boost"] = "fpsboost"
Sprite.Alias["fps-drop"] = "lowfps"
Sprite.Alias["fps-unlock"] = "fpsboost"
Sprite.Alias["fpsunlock"] = "fpsboost"
Sprite.Alias["frame"] = "box"
Sprite.Alias["free-cam"] = "camera"
Sprite.Alias["freecam"] = "camera"
Sprite.Alias["friends"] = "players"
Sprite.Alias["frost"] = "ice"
Sprite.Alias["frozen"] = "freeze"
Sprite.Alias["full-auto"] = "fullauto"
Sprite.Alias["full-bright"] = "fullbright"
Sprite.Alias["fullscreen"] = "expand"
Sprite.Alias["fun"] = "troll"
Sprite.Alias["funnel"] = "filter"
Sprite.Alias["fuse"] = "craft"
Sprite.Alias["gallery"] = "grid"
Sprite.Alias["game"] = "gamepad"
Sprite.Alias["gamepad-2"] = "gamepad"
Sprite.Alias["games"] = "gamepad"
Sprite.Alias["garden"] = "farm"
Sprite.Alias["gather"] = "collect"
Sprite.Alias["gauge"] = "speed"
Sprite.Alias["gems"] = "gem"
Sprite.Alias["general"] = "main"
Sprite.Alias["gesture"] = "touch"
Sprite.Alias["ghost"] = "eyeoff"
Sprite.Alias["gift"] = "event"
Sprite.Alias["glacier"] = "ice"
Sprite.Alias["glide"] = "feather"
Sprite.Alias["glitch"] = "bug"
Sprite.Alias["globe"] = "map"
Sprite.Alias["glow"] = "chams"
Sprite.Alias["go"] = "play"
Sprite.Alias["go-to"] = "teleport"
Sprite.Alias["goal"] = "flag"
Sprite.Alias["god"] = "shield"
Sprite.Alias["god-mode"] = "shield"
Sprite.Alias["godmode"] = "shield"
Sprite.Alias["gold"] = "coin"
Sprite.Alias["goto"] = "teleport"
Sprite.Alias["grab"] = "collect"
Sprite.Alias["graph"] = "chart"
Sprite.Alias["grind"] = "autofarm"
Sprite.Alias["group"] = "players"
Sprite.Alias["grow"] = "farm"
Sprite.Alias["guide"] = "info"
Sprite.Alias["gun-mods"] = "gun"
Sprite.Alias["gunmods"] = "gun"
Sprite.Alias["guns"] = "gun"
Sprite.Alias["halt"] = "stop"
Sprite.Alias["halt-pause"] = "pause"
Sprite.Alias["hamburger"] = "menu"
Sprite.Alias["hammer"] = "craft"
Sprite.Alias["hammer-pick"] = "pickaxe"
Sprite.Alias["hand"] = "touch"
Sprite.Alias["hand-pointer"] = "touch"
Sprite.Alias["harvest"] = "farm"
Sprite.Alias["hat"] = "wingcap"
Sprite.Alias["hatch"] = "egg"
Sprite.Alias["haunt"] = "boo"
Sprite.Alias["haze"] = "fog"
Sprite.Alias["head"] = "headshot"
Sprite.Alias["heart-fav"] = "favorite"
Sprite.Alias["heart-icon"] = "heart"
Sprite.Alias["heart-pulse"] = "health"
Sprite.Alias["hearts"] = "heart"
Sprite.Alias["heat"] = "fire"
Sprite.Alias["heist"] = "money"
Sprite.Alias["help"] = "info"
Sprite.Alias["help-circle"] = "info"
Sprite.Alias["hidden"] = "eyeoff"
Sprite.Alias["hide"] = "eyeoff"
Sprite.Alias["high-jump"] = "jump"
Sprite.Alias["higher"] = "up"
Sprite.Alias["highjump"] = "jump"
Sprite.Alias["highlighter"] = "highlight"
Sprite.Alias["histogram"] = "chart"
Sprite.Alias["hit"] = "damage"
Sprite.Alias["hit-chance"] = "hitchance"
Sprite.Alias["hit-part"] = "headshot"
Sprite.Alias["hitbox"] = "damage"
Sprite.Alias["hitbox-expander"] = "damage"
Sprite.Alias["hitboxes"] = "damage"
Sprite.Alias["hitpart"] = "headshot"
Sprite.Alias["hold"] = "pause"
Sprite.Alias["homing"] = "bulletbill"
Sprite.Alias["hook"] = "webhook"
Sprite.Alias["hopper"] = "hop"
Sprite.Alias["host"] = "server"
Sprite.Alias["hot"] = "fire"
Sprite.Alias["hot-bar"] = "quickbar"
Sprite.Alias["hotbar"] = "quickbar"
Sprite.Alias["hotkey"] = "keybind"
Sprite.Alias["hotkeys"] = "keybind"
Sprite.Alias["hour"] = "clock"
Sprite.Alias["hourglass"] = "timer"
Sprite.Alias["house"] = "home"
Sprite.Alias["house-plus"] = "home"
Sprite.Alias["hp"] = "health"
Sprite.Alias["hub"] = "home"
Sprite.Alias["hyperlink"] = "link"
Sprite.Alias["ice-cube"] = "ice"
Sprite.Alias["id-card"] = "nametag"
Sprite.Alias["idle"] = "antiafk"
Sprite.Alias["ignore"] = "filter"
Sprite.Alias["impact"] = "damage"
Sprite.Alias["important"] = "star"
Sprite.Alias["inbox"] = "import"
Sprite.Alias["include"] = "filter"
Sprite.Alias["income"] = "sell"
Sprite.Alias["increase"] = "plus"
Sprite.Alias["incubate"] = "egg"
Sprite.Alias["inf-ammo"] = "ammo"
Sprite.Alias["inf-jump"] = "infjump"
Sprite.Alias["infammo"] = "ammo"
Sprite.Alias["infinite-ammo"] = "ammo"
Sprite.Alias["infinite-jump"] = "infjump"
Sprite.Alias["infinitejump"] = "infjump"
Sprite.Alias["infinity"] = "infjump"
Sprite.Alias["information"] = "info"
Sprite.Alias["input"] = "keyboard"
Sprite.Alias["inspect"] = "debug"
Sprite.Alias["instance"] = "server"
Sprite.Alias["instant"] = "lightning"
Sprite.Alias["integration"] = "webhook"
Sprite.Alias["interface"] = "settings"
Sprite.Alias["interval"] = "timer"
Sprite.Alias["inventory"] = "chest"
Sprite.Alias["invincible"] = "shield"
Sprite.Alias["invis"] = "eyeoff"
Sprite.Alias["invisible"] = "eyeoff"
Sprite.Alias["invite"] = "discord"
Sprite.Alias["ios"] = "mobile"
Sprite.Alias["island"] = "map"
Sprite.Alias["islands"] = "map"
Sprite.Alias["issue"] = "bug"
Sprite.Alias["item"] = "mushroom"
Sprite.Alias["items"] = "mushroom"
Sprite.Alias["jesus"] = "walkwater"
Sprite.Alias["jewel"] = "gem"
Sprite.Alias["job-id"] = "server"
Sprite.Alias["jobid"] = "server"
Sprite.Alias["join"] = "rejoin"
Sprite.Alias["join-discord"] = "discord"
Sprite.Alias["joints"] = "skeleton"
Sprite.Alias["joke"] = "troll"
Sprite.Alias["joystick"] = "gamepad"
Sprite.Alias["jp"] = "jump"
Sprite.Alias["jump-height"] = "jump"
Sprite.Alias["jump-power"] = "jump"
Sprite.Alias["jumpheight"] = "jump"
Sprite.Alias["jumppower"] = "jump"
Sprite.Alias["kaitun"] = "autofarm"
Sprite.Alias["katana"] = "sword"
Sprite.Alias["keep"] = "pin"
Sprite.Alias["key-round"] = "keybind"
Sprite.Alias["key-system"] = "key"
Sprite.Alias["keybinds"] = "keybind"
Sprite.Alias["keys"] = "keyboard"
Sprite.Alias["keys-system"] = "key"
Sprite.Alias["keysystem"] = "key"
Sprite.Alias["kick"] = "recoil"
Sprite.Alias["kill"] = "killaura"
Sprite.Alias["kill aura"] = "killaura"
Sprite.Alias["kill-all"] = "killaura"
Sprite.Alias["kill-aura"] = "killaura"
Sprite.Alias["kill-switch"] = "power"
Sprite.Alias["killall"] = "killaura"
Sprite.Alias["king"] = "crown"
Sprite.Alias["kingdom"] = "castle"
Sprite.Alias["knockback"] = "fling"
Sprite.Alias["koopa"] = "shell"
Sprite.Alias["label"] = "nametag"
Sprite.Alias["lag"] = "lowfps"
Sprite.Alias["lamp"] = "fullbright"
Sprite.Alias["lang"] = "language"
Sprite.Alias["languages"] = "language"
Sprite.Alias["languages-alt"] = "language"
Sprite.Alias["laptop"] = "pc"
Sprite.Alias["laugh"] = "troll"
Sprite.Alias["launch"] = "fling"
Sprite.Alias["lava"] = "fire"
Sprite.Alias["layout"] = "grid"
Sprite.Alias["layout-grid"] = "grid"
Sprite.Alias["leaderboard"] = "trophy"
Sprite.Alias["leaf"] = "tree"
Sprite.Alias["leash"] = "chomp"
Sprite.Alias["leave"] = "rejoin"
Sprite.Alias["leaves"] = "tree"
Sprite.Alias["level"] = "upgrade"
Sprite.Alias["level-up"] = "upgrade"
Sprite.Alias["levels"] = "upgrade"
Sprite.Alias["levelup"] = "upgrade"
Sprite.Alias["lever"] = "pswitch"
Sprite.Alias["levitate"] = "fly"
Sprite.Alias["license"] = "key"
Sprite.Alias["life"] = "health"
Sprite.Alias["light"] = "fullbright"
Sprite.Alias["lightbulb"] = "fullbright"
Sprite.Alias["lighting"] = "sun"
Sprite.Alias["lights"] = "fullbright"
Sprite.Alias["like"] = "favorite"
Sprite.Alias["limited"] = "event"
Sprite.Alias["line"] = "tracer"
Sprite.Alias["line-chart"] = "stats"
Sprite.Alias["lines"] = "tracer"
Sprite.Alias["link-2"] = "link"
Sprite.Alias["links"] = "link"
Sprite.Alias["liquid"] = "water"
Sprite.Alias["list-menu"] = "menu"
Sprite.Alias["list-ordered"] = "list"
Sprite.Alias["lists"] = "list"
Sprite.Alias["lives"] = "health"
Sprite.Alias["loader"] = "load"
Sprite.Alias["loading"] = "load"
Sprite.Alias["lobby"] = "home"
Sprite.Alias["local"] = "player"
Sprite.Alias["locale"] = "language"
Sprite.Alias["localplayer"] = "player"
Sprite.Alias["locate"] = "crosshair"
Sprite.Alias["locate-fixed"] = "crosshair"
Sprite.Alias["location"] = "waypoint"
Sprite.Alias["lock-keyhole"] = "lock"
Sprite.Alias["lock-on"] = "aimbot"
Sprite.Alias["lock-open"] = "unlock"
Sprite.Alias["locked"] = "lock"
Sprite.Alias["lockon"] = "aimbot"
Sprite.Alias["log"] = "webhook"
Sprite.Alias["log-in"] = "rejoin"
Sprite.Alias["log-out"] = "rejoin"
Sprite.Alias["logs"] = "webhook"
Sprite.Alias["logs-list"] = "list"
Sprite.Alias["look"] = "eye"
Sprite.Alias["lookup"] = "search"
Sprite.Alias["loop"] = "orbit"
Sprite.Alias["love"] = "favorite"
Sprite.Alias["low-fps"] = "lowfps"
Sprite.Alias["low-gravity"] = "gravity"
Sprite.Alias["lower"] = "down"
Sprite.Alias["lowgravity"] = "gravity"
Sprite.Alias["luck"] = "hitchance"
Sprite.Alias["lumber"] = "axe"
Sprite.Alias["made-by"] = "credit"
Sprite.Alias["magic-bullet"] = "silentaim"
Sprite.Alias["magicbullet"] = "silentaim"
Sprite.Alias["magnifier"] = "search"
Sprite.Alias["magnify"] = "zoom"
Sprite.Alias["map-pin"] = "waypoint"
Sprite.Alias["map-pinned"] = "map"
Sprite.Alias["marker"] = "waypoint"
Sprite.Alias["market"] = "shop"
Sprite.Alias["material"] = "chams"
Sprite.Alias["max-zoom"] = "zoom"
Sprite.Alias["maximize"] = "expand"
Sprite.Alias["maximize-2"] = "expand"
Sprite.Alias["maxzoom"] = "zoom"
Sprite.Alias["me"] = "player"
Sprite.Alias["medal"] = "trophy"
Sprite.Alias["medkit"] = "heal"
Sprite.Alias["megaphone"] = "notify"
Sprite.Alias["melee"] = "sword"
Sprite.Alias["meme"] = "troll"
Sprite.Alias["merchant"] = "shop"
Sprite.Alias["merge"] = "craft"
Sprite.Alias["message"] = "notify"
Sprite.Alias["message-circle"] = "discord"
Sprite.Alias["message-square"] = "notify"
Sprite.Alias["messages"] = "discord"
Sprite.Alias["metrics"] = "stats"
Sprite.Alias["mini-map"] = "radar"
Sprite.Alias["minigame"] = "gamepad"
Sprite.Alias["minimap"] = "radar"
Sprite.Alias["minimize"] = "collapse"
Sprite.Alias["minimize-2"] = "collapse"
Sprite.Alias["mining"] = "mine"
Sprite.Alias["minus-circle"] = "minus"
Sprite.Alias["miscellaneous"] = "misc"
Sprite.Alias["missile"] = "bulletbill"
Sprite.Alias["mission"] = "quest"
Sprite.Alias["missions"] = "quest"
Sprite.Alias["mist"] = "fog"
Sprite.Alias["mob"] = "goomba"
Sprite.Alias["mobs"] = "goomba"
Sprite.Alias["modify"] = "edit"
Sprite.Alias["mods"] = "gun"
Sprite.Alias["monitor"] = "pc"
Sprite.Alias["monster"] = "goomba"
Sprite.Alias["monsters"] = "goomba"
Sprite.Alias["moon-star"] = "moon"
Sprite.Alias["more-horizontal"] = "more"
Sprite.Alias["more-plus"] = "plus"
Sprite.Alias["more-vertical"] = "more"
Sprite.Alias["mount"] = "pet"
Sprite.Alias["mouse-pointer"] = "mouse"
Sprite.Alias["mouse-pointer-click"] = "mouse"
Sprite.Alias["move"] = "speed"
Sprite.Alias["move-horizontal"] = "distance"
Sprite.Alias["movement"] = "speed"
Sprite.Alias["multiplayer"] = "players"
Sprite.Alias["music-2"] = "music"
Sprite.Alias["mystery"] = "qblock"
Sprite.Alias["name"] = "nametag"
Sprite.Alias["names"] = "nametag"
Sprite.Alias["nametags"] = "nametag"
Sprite.Alias["nature"] = "tree"
Sprite.Alias["nav"] = "menu"
Sprite.Alias["navigation"] = "menu"
Sprite.Alias["network"] = "server"
Sprite.Alias["new"] = "plus"
Sprite.Alias["next"] = "right"
Sprite.Alias["night"] = "moon"
Sprite.Alias["night-vision"] = "fullbright"
Sprite.Alias["nightvision"] = "fullbright"
Sprite.Alias["no-clip"] = "noclip"
Sprite.Alias["no-cooldown"] = "cooldown"
Sprite.Alias["no-fall"] = "nofall"
Sprite.Alias["no-fall-damage"] = "nofall"
Sprite.Alias["no-fog"] = "fog"
Sprite.Alias["no-recoil"] = "recoil"
Sprite.Alias["no-reload"] = "ammo"
Sprite.Alias["no-sound"] = "mute"
Sprite.Alias["no-spread"] = "spread"
Sprite.Alias["nocooldown"] = "cooldown"
Sprite.Alias["nofalldamage"] = "nofall"
Sprite.Alias["nofog"] = "fog"
Sprite.Alias["noidle"] = "antiafk"
Sprite.Alias["norecoil"] = "recoil"
Sprite.Alias["noreload"] = "ammo"
Sprite.Alias["north"] = "up"
Sprite.Alias["nosound"] = "mute"
Sprite.Alias["nospread"] = "spread"
Sprite.Alias["note"] = "music"
Sprite.Alias["notes"] = "edit"
Sprite.Alias["notification"] = "bell"
Sprite.Alias["notifications"] = "bell"
Sprite.Alias["notifier"] = "webhook"
Sprite.Alias["npc"] = "goomba"
Sprite.Alias["npcs"] = "goomba"
Sprite.Alias["nuke"] = "bomb"
Sprite.Alias["nut"] = "seed"
Sprite.Alias["objective"] = "quest"
Sprite.Alias["off"] = "power"
Sprite.Alias["ok"] = "success"
Sprite.Alias["on"] = "power"
Sprite.Alias["one-up"] = "oneup"
Sprite.Alias["op"] = "star"
Sprite.Alias["open"] = "load"
Sprite.Alias["open-full"] = "expand"
Sprite.Alias["open-lock"] = "unlock"
Sprite.Alias["optimize"] = "fpsboost"
Sprite.Alias["option"] = "settings"
Sprite.Alias["options"] = "settings"
Sprite.Alias["order"] = "sort"
Sprite.Alias["ore"] = "mine"
Sprite.Alias["ores"] = "mine"
Sprite.Alias["other"] = "misc"
Sprite.Alias["others"] = "players"
Sprite.Alias["others-tab"] = "misc"
Sprite.Alias["outline"] = "highlight"
Sprite.Alias["outlines"] = "highlight"
Sprite.Alias["overview"] = "main"
Sprite.Alias["owner"] = "credit"
Sprite.Alias["owner-crown"] = "crown"
Sprite.Alias["p-switch"] = "pswitch"
Sprite.Alias["package"] = "chest"
Sprite.Alias["paint"] = "theme"
Sprite.Alias["paintbrush"] = "theme"
Sprite.Alias["panic"] = "power"
Sprite.Alias["parachute"] = "nofall"
Sprite.Alias["parry"] = "shield"
Sprite.Alias["party"] = "players"
Sprite.Alias["party-popper"] = "event"
Sprite.Alias["passed"] = "success"
Sprite.Alias["password"] = "lock"
Sprite.Alias["paw"] = "pet"
Sprite.Alias["paw-print"] = "pet"
Sprite.Alias["pen"] = "edit"
Sprite.Alias["pen-line"] = "edit"
Sprite.Alias["pencil"] = "edit"
Sprite.Alias["people"] = "players"
Sprite.Alias["performance"] = "fpsboost"
Sprite.Alias["person"] = "player"
Sprite.Alias["pets"] = "pet"
Sprite.Alias["phantom"] = "boo"
Sprite.Alias["phase"] = "noclip"
Sprite.Alias["phone"] = "mobile"
Sprite.Alias["photo"] = "camera"
Sprite.Alias["physics"] = "gravity"
Sprite.Alias["pick"] = "pickaxe"
Sprite.Alias["pick-up"] = "collect"
Sprite.Alias["pickup"] = "collect"
Sprite.Alias["pin-off"] = "unpin"
Sprite.Alias["pin-on"] = "pin"
Sprite.Alias["pinned"] = "pin"
Sprite.Alias["pipe-teleport"] = "teleport"
Sprite.Alias["pipette"] = "palette"
Sprite.Alias["pistol"] = "gun"
Sprite.Alias["plane"] = "fly"
Sprite.Alias["plants"] = "plant"
Sprite.Alias["plot"] = "home"
Sprite.Alias["plus-circle"] = "plus"
Sprite.Alias["pointer"] = "mouse"
Sprite.Alias["pointer-hand"] = "touch"
Sprite.Alias["pointer-tap"] = "touch"
Sprite.Alias["popup"] = "notify"
Sprite.Alias["portal"] = "teleport"
Sprite.Alias["pos"] = "waypoint"
Sprite.Alias["position"] = "waypoint"
Sprite.Alias["pot"] = "plant"
Sprite.Alias["potato"] = "lowfps"
Sprite.Alias["potion"] = "heal"
Sprite.Alias["potted"] = "plant"
Sprite.Alias["pouch"] = "loot"
Sprite.Alias["pow-block"] = "pow"
Sprite.Alias["power-off"] = "power"
Sprite.Alias["power-star"] = "star"
Sprite.Alias["power-up"] = "lightning"
Sprite.Alias["powerup"] = "lightning"
Sprite.Alias["preferences"] = "settings"
Sprite.Alias["premium"] = "gem"
Sprite.Alias["preset"] = "config"
Sprite.Alias["presets"] = "config"
Sprite.Alias["press"] = "pswitch"
Sprite.Alias["prestige"] = "rebirth"
Sprite.Alias["prev"] = "left"
Sprite.Alias["previous"] = "left"
Sprite.Alias["price"] = "buy"
Sprite.Alias["priority"] = "sort"
Sprite.Alias["private"] = "lock"
Sprite.Alias["prize"] = "trophy"
Sprite.Alias["profile"] = "player"
Sprite.Alias["profiles"] = "config"
Sprite.Alias["projectile"] = "bow"
Sprite.Alias["promo"] = "code"
Sprite.Alias["protect"] = "shield"
Sprite.Alias["public"] = "unlock"
Sprite.Alias["pull"] = "magnet"
Sprite.Alias["purchase"] = "buy"
Sprite.Alias["push"] = "fling"
Sprite.Alias["pvp"] = "sword"
Sprite.Alias["query"] = "search"
Sprite.Alias["question"] = "info"
Sprite.Alias["question-block"] = "qblock"
Sprite.Alias["quests"] = "quest"
Sprite.Alias["queue"] = "list"
Sprite.Alias["quick-bar"] = "quickbar"
Sprite.Alias["quickbar-pin"] = "quickbar"
Sprite.Alias["quit"] = "close"
Sprite.Alias["race"] = "flag"
Sprite.Alias["radio"] = "radar"
Sprite.Alias["radio-music"] = "music"
Sprite.Alias["rage"] = "ragebot"
Sprite.Alias["rage bot"] = "ragebot"
Sprite.Alias["rage-bot"] = "ragebot"
Sprite.Alias["raid"] = "boss"
Sprite.Alias["raids"] = "boss"
Sprite.Alias["rain"] = "water"
Sprite.Alias["rainbow"] = "theme"
Sprite.Alias["random"] = "hitchance"
Sprite.Alias["random-box"] = "qblock"
Sprite.Alias["range"] = "distance"
Sprite.Alias["rank"] = "sort"
Sprite.Alias["ranking"] = "sort"
Sprite.Alias["rapid"] = "rapidfire"
Sprite.Alias["rapid-fire"] = "rapidfire"
Sprite.Alias["rare"] = "gem"
Sprite.Alias["rarity"] = "gem"
Sprite.Alias["rating"] = "star"
Sprite.Alias["re-join"] = "rejoin"
Sprite.Alias["reach"] = "distance"
Sprite.Alias["readme"] = "info"
Sprite.Alias["rebirths"] = "rebirth"
Sprite.Alias["receive"] = "import"
Sprite.Alias["reconnect"] = "rejoin"
Sprite.Alias["record"] = "camera"
Sprite.Alias["redeem"] = "code"
Sprite.Alias["redeem-codes"] = "code"
Sprite.Alias["redeemcodes"] = "code"
Sprite.Alias["redo"] = "refresh"
Sprite.Alias["reel"] = "fish"
Sprite.Alias["refresh-ccw"] = "refresh"
Sprite.Alias["refresh-cw"] = "refresh"
Sprite.Alias["regen"] = "heal"
Sprite.Alias["region"] = "map"
Sprite.Alias["reload"] = "ammo"
Sprite.Alias["reload-list"] = "refresh"
Sprite.Alias["remove"] = "minus"
Sprite.Alias["rename"] = "edit"
Sprite.Alias["render"] = "esp"
Sprite.Alias["repeat"] = "refresh"
Sprite.Alias["report"] = "bug"
Sprite.Alias["reset"] = "rebirth"
Sprite.Alias["reset-character"] = "oneup"
Sprite.Alias["respawn"] = "oneup"
Sprite.Alias["restore"] = "import"
Sprite.Alias["restore-size"] = "collapse"
Sprite.Alias["resume"] = "play"
Sprite.Alias["reticle"] = "crosshair"
Sprite.Alias["retry"] = "refresh"
Sprite.Alias["revive"] = "oneup"
Sprite.Alias["reward"] = "loot"
Sprite.Alias["rewards"] = "loot"
Sprite.Alias["ring"] = "bell"
Sprite.Alias["risk"] = "warn"
Sprite.Alias["risky"] = "warn"
Sprite.Alias["rng"] = "hitchance"
Sprite.Alias["rob"] = "money"
Sprite.Alias["rock"] = "mine"
Sprite.Alias["rocket"] = "bulletbill"
Sprite.Alias["rod"] = "fish"
Sprite.Alias["rotate"] = "orbit"
Sprite.Alias["rotate-ccw"] = "rebirth"
Sprite.Alias["rotate-cw"] = "orbit"
Sprite.Alias["rotate-cw-square"] = "refresh"
Sprite.Alias["rows"] = "list"
Sprite.Alias["royal"] = "crown"
Sprite.Alias["ruby"] = "gem"
Sprite.Alias["ruler"] = "distance"
Sprite.Alias["run"] = "speed"
Sprite.Alias["run-play"] = "play"
Sprite.Alias["sack"] = "loot"
Sprite.Alias["safe"] = "shield"
Sprite.Alias["safe-mode"] = "shield"
Sprite.Alias["safemode"] = "shield"
Sprite.Alias["sapling"] = "plant"
Sprite.Alias["save-all"] = "save"
Sprite.Alias["savefile"] = "save"
Sprite.Alias["saves"] = "save"
Sprite.Alias["scale"] = "zoom"
Sprite.Alias["scan"] = "radar"
Sprite.Alias["scan-eye"] = "fov"
Sprite.Alias["scanner"] = "radar"
Sprite.Alias["scatter"] = "spread"
Sprite.Alias["schedule"] = "clock"
Sprite.Alias["scope"] = "crosshair"
Sprite.Alias["screen"] = "pc"
Sprite.Alias["screenshot"] = "camera"
Sprite.Alias["script"] = "code"
Sprite.Alias["scripts"] = "code"
Sprite.Alias["scroll"] = "quest"
Sprite.Alias["scroll-text"] = "quest"
Sprite.Alias["seasonal"] = "event"
Sprite.Alias["secure"] = "lock"
Sprite.Alias["seeds"] = "seed"
Sprite.Alias["self"] = "player"
Sprite.Alias["sell-all"] = "sell"
Sprite.Alias["sellall"] = "sell"
Sprite.Alias["send"] = "export"
Sprite.Alias["server hop"] = "hop"
Sprite.Alias["server-cog"] = "server"
Sprite.Alias["server-hop"] = "hop"
Sprite.Alias["serverhop"] = "hop"
Sprite.Alias["servers"] = "server"
Sprite.Alias["session"] = "stats"
Sprite.Alias["setting"] = "settings"
Sprite.Alias["sfx"] = "sound"
Sprite.Alias["shadows"] = "sun"
Sprite.Alias["share"] = "export"
Sprite.Alias["share-2"] = "export"
Sprite.Alias["sheet"] = "table"
Sprite.Alias["shell-cmd"] = "terminal"
Sprite.Alias["shells"] = "shell"
Sprite.Alias["shield-check"] = "shield"
Sprite.Alias["shock"] = "lightning"
Sprite.Alias["shockwave"] = "pow"
Sprite.Alias["shoot"] = "gun"
Sprite.Alias["shopping-bag"] = "shop"
Sprite.Alias["shopping-cart"] = "cart"
Sprite.Alias["shortcut"] = "keybind"
Sprite.Alias["shortcuts"] = "quickbar"
Sprite.Alias["shotgun"] = "spread"
Sprite.Alias["show"] = "eye"
Sprite.Alias["shrink"] = "collapse"
Sprite.Alias["shuffle"] = "hitchance"
Sprite.Alias["shutdown"] = "power"
Sprite.Alias["sidebar"] = "menu"
Sprite.Alias["silence"] = "mute"
Sprite.Alias["silent"] = "silentaim"
Sprite.Alias["silent aim"] = "silentaim"
Sprite.Alias["silent-aim"] = "silentaim"
Sprite.Alias["silhouette"] = "chams"
Sprite.Alias["skin"] = "theme"
Sprite.Alias["skull"] = "headshot"
Sprite.Alias["skybox"] = "sky"
Sprite.Alias["slam"] = "pow"
Sprite.Alias["slash"] = "knife"
Sprite.Alias["sleep"] = "moon"
Sprite.Alias["sliders"] = "settings"
Sprite.Alias["sliders-horizontal"] = "settings"
Sprite.Alias["sliders-vertical"] = "settings"
Sprite.Alias["small-server"] = "hop"
Sprite.Alias["smallserver"] = "hop"
Sprite.Alias["smartphone"] = "mobile"
Sprite.Alias["smile"] = "troll"
Sprite.Alias["smile-plus"] = "troll"
Sprite.Alias["smith"] = "craft"
Sprite.Alias["smooth"] = "fpsboost"
Sprite.Alias["snapline"] = "tracer"
Sprite.Alias["snaplines"] = "tracer"
Sprite.Alias["snow"] = "freeze"
Sprite.Alias["snowflake"] = "freeze"
Sprite.Alias["social"] = "discord"
Sprite.Alias["song"] = "music"
Sprite.Alias["songs"] = "music"
Sprite.Alias["sorting"] = "sort"
Sprite.Alias["sounds"] = "sound"
Sprite.Alias["south"] = "down"
Sprite.Alias["sow"] = "seed"
Sprite.Alias["sparkle"] = "highlight"
Sprite.Alias["sparkles"] = "highlight"
Sprite.Alias["spawn"] = "waypoint"
Sprite.Alias["spawnpoint"] = "waypoint"
Sprite.Alias["speaker"] = "sound"
Sprite.Alias["spec"] = "spectate"
Sprite.Alias["special"] = "star"
Sprite.Alias["spin"] = "orbit"
Sprite.Alias["spooky"] = "boo"
Sprite.Alias["spreadsheet"] = "table"
Sprite.Alias["spring"] = "recoil"
Sprite.Alias["sprint"] = "speed"
Sprite.Alias["sprout"] = "farm"
Sprite.Alias["square"] = "box"
Sprite.Alias["square-stop"] = "stop"
Sprite.Alias["stab"] = "knife"
Sprite.Alias["stalk"] = "follow"
Sprite.Alias["stars"] = "star"
Sprite.Alias["start"] = "main"
Sprite.Alias["statistics"] = "stats"
Sprite.Alias["status"] = "stats"
Sprite.Alias["stealth"] = "eyeoff"
Sprite.Alias["stick"] = "follow"
Sprite.Alias["stick-pin"] = "pin"
Sprite.Alias["stomp"] = "pow"
Sprite.Alias["stone"] = "mine"
Sprite.Alias["stop-circle"] = "stop"
Sprite.Alias["storage"] = "chest"
Sprite.Alias["store"] = "shop"
Sprite.Alias["storm"] = "wind"
Sprite.Alias["studs"] = "distance"
Sprite.Alias["stun"] = "freeze"
Sprite.Alias["style"] = "theme"
Sprite.Alias["subtract"] = "minus"
Sprite.Alias["sunny"] = "sun"
Sprite.Alias["sunrise"] = "sun"
Sprite.Alias["suspend"] = "pause"
Sprite.Alias["swim"] = "walkwater"
Sprite.Alias["switch"] = "hop"
Sprite.Alias["swords"] = "sword"
Sprite.Alias["sync"] = "refresh"
Sprite.Alias["tables"] = "table"
Sprite.Alias["tablet"] = "mobile"
Sprite.Alias["tag"] = "nametag"
Sprite.Alias["tags"] = "buy"
Sprite.Alias["tail"] = "follow"
Sprite.Alias["tap"] = "touch"
Sprite.Alias["target"] = "aimbot"
Sprite.Alias["task"] = "quest"
Sprite.Alias["tasks"] = "quest"
Sprite.Alias["td"] = "castle"
Sprite.Alias["team"] = "players"
Sprite.Alias["teams"] = "players"
Sprite.Alias["terminal-square"] = "terminal"
Sprite.Alias["test"] = "debug"
Sprite.Alias["testing"] = "debug"
Sprite.Alias["text"] = "nametag"
Sprite.Alias["thanks"] = "credit"
Sprite.Alias["themes"] = "theme"
Sprite.Alias["thunder"] = "lightning"
Sprite.Alias["tick"] = "check"
Sprite.Alias["ticket"] = "buy"
Sprite.Alias["tiles"] = "grid"
Sprite.Alias["time"] = "clock"
Sprite.Alias["time-of-day"] = "clock"
Sprite.Alias["timer-reset"] = "cooldown"
Sprite.Alias["tnt"] = "bomb"
Sprite.Alias["toast"] = "notify"
Sprite.Alias["toggle"] = "power"
Sprite.Alias["tool"] = "pickaxe"
Sprite.Alias["toolbox"] = "misc"
Sprite.Alias["tools"] = "pickaxe"
Sprite.Alias["tornado"] = "wind"
Sprite.Alias["tower"] = "castle"
Sprite.Alias["towers"] = "castle"
Sprite.Alias["tp"] = "teleport"
Sprite.Alias["tracers"] = "tracer"
Sprite.Alias["tracker"] = "stats"
Sprite.Alias["trade"] = "sell"
Sprite.Alias["train"] = "upgrade"
Sprite.Alias["translate"] = "language"
Sprite.Alias["trash-2"] = "trash"
Sprite.Alias["trash2"] = "trash"
Sprite.Alias["treasure"] = "chest"
Sprite.Alias["tree-pine"] = "tree"
Sprite.Alias["trees"] = "tree"
Sprite.Alias["trees-pine"] = "tree"
Sprite.Alias["trending-down"] = "lowfps"
Sprite.Alias["trending-up"] = "fpsboost"
Sprite.Alias["triangle-alert"] = "warn"
Sprite.Alias["trigger"] = "triggerbot"
Sprite.Alias["trigger bot"] = "triggerbot"
Sprite.Alias["trigger-bot"] = "triggerbot"
Sprite.Alias["trigger-switch"] = "pswitch"
Sprite.Alias["trolling"] = "troll"
Sprite.Alias["tunnel"] = "pipe"
Sprite.Alias["turtle"] = "shell"
Sprite.Alias["tutorial"] = "info"
Sprite.Alias["tween"] = "teleport"
Sprite.Alias["type"] = "nametag"
Sprite.Alias["type-text"] = "keyboard"
Sprite.Alias["typing"] = "keyboard"
Sprite.Alias["ui"] = "settings"
Sprite.Alias["unknown"] = "qblock"
Sprite.Alias["unload"] = "power"
Sprite.Alias["unlocked"] = "unlock"
Sprite.Alias["unlockfps"] = "fpsboost"
Sprite.Alias["unmute"] = "mute"
Sprite.Alias["unpinned"] = "unpin"
Sprite.Alias["update"] = "refresh"
Sprite.Alias["upgrades"] = "upgrade"
Sprite.Alias["upload"] = "export"
Sprite.Alias["url"] = "link"
Sprite.Alias["use"] = "mushroom"
Sprite.Alias["used-block"] = "used"
Sprite.Alias["user"] = "player"
Sprite.Alias["user-round"] = "player"
Sprite.Alias["users"] = "players"
Sprite.Alias["users-round"] = "players"
Sprite.Alias["utilities"] = "misc"
Sprite.Alias["utility"] = "misc"
Sprite.Alias["vacuum"] = "magnet"
Sprite.Alias["various"] = "misc"
Sprite.Alias["vendor"] = "shop"
Sprite.Alias["verified"] = "success"
Sprite.Alias["video"] = "camera"
Sprite.Alias["view"] = "eye"
Sprite.Alias["view-player"] = "spectate"
Sprite.Alias["vip"] = "crown"
Sprite.Alias["visibility"] = "eye"
Sprite.Alias["visible"] = "eye"
Sprite.Alias["visual"] = "esp"
Sprite.Alias["visuals"] = "esp"
Sprite.Alias["volume"] = "sound"
Sprite.Alias["volume-2"] = "sound"
Sprite.Alias["volume-x"] = "mute"
Sprite.Alias["vuln"] = "bug"
Sprite.Alias["wait"] = "timer"
Sprite.Alias["walk-on-water"] = "walkwater"
Sprite.Alias["walk-speed"] = "speed"
Sprite.Alias["walk-water"] = "walkwater"
Sprite.Alias["walkonwater"] = "walkwater"
Sprite.Alias["walkspeed"] = "speed"
Sprite.Alias["wall"] = "noclip"
Sprite.Alias["wall-hack"] = "esp"
Sprite.Alias["wallet"] = "money"
Sprite.Alias["wallhack"] = "esp"
Sprite.Alias["walls"] = "noclip"
Sprite.Alias["warning"] = "warn"
Sprite.Alias["warp"] = "teleport"
Sprite.Alias["warps"] = "teleport"
Sprite.Alias["watch"] = "eye"
Sprite.Alias["watch-player"] = "spectate"
Sprite.Alias["waves"] = "walkwater"
Sprite.Alias["waypoints"] = "waypoint"
Sprite.Alias["weapon"] = "gun"
Sprite.Alias["weapons"] = "gun"
Sprite.Alias["weather"] = "sky"
Sprite.Alias["web"] = "link"
Sprite.Alias["webhooks"] = "webhook"
Sprite.Alias["website"] = "link"
Sprite.Alias["weight"] = "gravity"
Sprite.Alias["welcome"] = "main"
Sprite.Alias["west"] = "left"
Sprite.Alias["wh"] = "esp"
Sprite.Alias["whitelist"] = "filter"
Sprite.Alias["win"] = "trophy"
Sprite.Alias["window"] = "pc"
Sprite.Alias["wing-cap"] = "wingcap"
Sprite.Alias["wings"] = "fly"
Sprite.Alias["wins"] = "trophy"
Sprite.Alias["wipe"] = "trash"
Sprite.Alias["wood"] = "axe"
Sprite.Alias["woodcut"] = "axe"
Sprite.Alias["world"] = "map"
Sprite.Alias["wrench"] = "settings"
Sprite.Alias["write"] = "edit"
Sprite.Alias["ws"] = "speed"
Sprite.Alias["x"] = "close"
Sprite.Alias["x-circle"] = "error"
Sprite.Alias["x-ray"] = "esp"
Sprite.Alias["x-square"] = "close"
Sprite.Alias["xbox"] = "gamepad"
Sprite.Alias["xp"] = "upgrade"
Sprite.Alias["xray"] = "esp"
Sprite.Alias["yeet"] = "fling"
Sprite.Alias["yes"] = "check"
Sprite.Alias["yoshi"] = "egg"
Sprite.Alias["zap"] = "lightning"
Sprite.Alias["zone"] = "map"
Sprite.Alias["zones"] = "map"
Sprite.Alias["zoom-in"] = "zoom"
Sprite.Alias["zoom-out"] = "zoom"

Sprite.Scoped = {}

---@param name string
---@return boolean  true when name (or its alias) has art
function Sprite.Has(name)
    name = tostring(name or ""):lower():gsub("^lucide%-", "")
    name = Sprite.Alias[name] or name
    return Sprite.Art[name] ~= nil or Sprite.Swaps[name] ~= nil
end

---@param name    string
---@param rows    string[]                  equal-width rows, "." = clear
---@param palette table<string, Color3>?    extra chars, only for this icon
---@return boolean                          false when the art was rejected
function Sprite.Register(name, rows, palette)
    if type(name) ~= "string" or name == "" or type(rows) ~= "table" or #rows == 0 then
        warn("[MarioHubUI] AddIcon: need a name and a list of rows")
        return false
    end
    name = name:lower()
    local scoped = {}
    for char, color in pairs(palette or {}) do
        if type(char) ~= "string" or #char ~= 1 or typeof(color) ~= "Color3" then
            warn("[MarioHubUI] AddIcon " .. name .. ": palette entries must be one char = Color3")
            return false
        end
        scoped[char] = color
    end
    local width = type(rows[1]) == "string" and #rows[1] or 0
    for index, line in ipairs(rows) do
        if type(line) ~= "string" or #line ~= width or width == 0 then
            warn(("[MarioHubUI] AddIcon %s: row %d is %s wide, expected %d"):format(name, index, type(line) == "string" and #line or "not", width))
            return false
        end
        for char in line:gmatch(".") do
            if char ~= "." and not scoped[char] and not Sprite.Palette[char] then
                warn(("[MarioHubUI] AddIcon %s: unknown color '%s' on row %d"):format(name, char, index))
                return false
            end
        end
    end
    Sprite.Art[name] = table.clone(rows)
    Sprite.Scoped[name] = next(scoped) and scoped or nil
    Sprite.Swaps[name] = nil
    Sprite.Alias[name] = nil
    local cached = Sprite.Templates[name]
    Sprite.Templates[name] = nil
    if cached then
        cached:Destroy()
    end
    return true
end

function Sprite.Template(name)
    if Sprite.Templates[name] then
        return Sprite.Templates[name]
    end
    local swap = Sprite.Swaps[name]
    local rows = Sprite.Art[swap and swap.base or name]
    local recolor = swap and swap.swap or {}
    local scoped = Sprite.Scoped[name] or {}
    local height, width = #rows, #rows[1]
    local holder = Draw.New("Frame", { Name = "Sprite", BackgroundTransparency = 1 })
    for y, line in ipairs(rows) do
        local x = 1
        while x <= width do
            local char = line:sub(x, x)
            local stop = x
            while stop < width and line:sub(stop + 1, stop + 1) == char do
                stop += 1
            end
            if char ~= "." then
                local key = recolor[char] or char
                Draw.New("Frame", {
                    BackgroundColor3 = scoped[key] or Sprite.Palette[key] or Sprite.Palette.k,
                    Position = UDim2.fromScale((x - 1) / width, (y - 1) / height),
                    Size = UDim2.fromScale((stop - x + 1) / width, 1 / height),
                    Parent = holder,
                })
            end
            x = stop + 1
        end
    end
    Sprite.Templates[name] = holder
    return holder
end

---@param name    string
---@param rows    string[]
---@param palette table<string, Color3>?
---@return boolean
function Library:AddIcon(name, rows, palette)
    return Sprite.Register(name, rows, palette)
end

function Library:HasIcon(name)
    return Sprite.Has(name)
end

---@author xDTaraZ  Mario Hub UI V2
Theme.Tokens = {
    "Backdrop", "BackdropAlt", "Topbar", "TopbarText", "Sidebar", "SidebarAlt", "SidebarText", "SidebarMuted",
    "TabActive", "TabActiveText", "Panel", "PanelHeader", "Element", "Hover", "Pressed", "Outline", "Shadow",
    "Text", "SubText", "Muted", "Track", "Accent", "AccentDark", "AccentText", "Good", "Warn", "Bad", "Info",
    "Coin", "Cloud", "Grass", "GrassDark", "Brick", "BrickDark", "Glow",
}

---@return string[]  tokens the theme is missing (empty = complete)
function Theme.Missing(name)
    local palette = Themes[name]
    local missing = {}
    if type(palette) ~= "table" then
        return Theme.Tokens
    end
    for _, token in ipairs(Theme.Tokens) do
        if typeof(palette[token]) ~= "Color3" then
            table.insert(missing, token)
        end
    end
    return missing
end

function Theme.Apply(name)
    if name == "Order" or name == "Shared" or type(Themes[name]) ~= "table" then
        name = "Overworld"
    end
    State.ThemeName = name
    local colors = Theme.Colors
    for token, color in pairs(Themes.Shared) do
        colors[token] = color
    end
    for token, color in pairs(Themes[name]) do
        colors[token] = color
    end
    Theme.Prune()
    for inst, map in pairs(Theme.Bound) do
        Theme.Paint(inst, map)
    end
    for _, render in pairs(Theme.Renderers) do
        Util.Try(render)
    end
    for _, render in pairs(Theme.InstanceRenderers) do
        Util.Try(render)
    end
end

---@return Color3
function Theme.Color(token)
    return Theme.Colors[token] or Themes.Shared.Black
end

---@param registry table  Instance-keyed, drops entries no longer under root
---@return table<Instance, true>  pages and rows a window parked outside the ScreenGui; they come back, so their bindings must stay
function Theme.ParkedRoots()
    local roots = {}
    local window = State.Window
    if type(window) ~= "table" then
        return roots
    end
    for _, page in ipairs(window.Pages or {}) do
        roots[page] = true
    end
    for _, view in ipairs(window.Tabs or {}) do
        if view.Page then
            roots[view.Page] = true
        end
        for frame in pairs(view.Detached or {}) do
            roots[frame] = true
        end
    end
    return roots
end

---Walks up from inst until a node with a known verdict, then stamps that verdict on the whole chain,
---so a prune visits every ancestor once instead of once per bound descendant.
---@return boolean  inst sits under the ScreenGui or a parked page or row
function Theme.Reachable(inst, root, parked, memo)
    local chain, depth, node = Theme.Chain, 0, inst
    local alive = memo[node]
    while alive == nil do
        if node == root or parked[node] then
            alive = true
            break
        end
        depth += 1
        chain[depth] = node
        node = node.Parent
        if not node then
            alive = false
            break
        end
        alive = memo[node]
    end
    for index = 1, depth do
        memo[chain[index]] = alive
        chain[index] = nil
    end
    return alive
end

function Theme.PruneRegistry(registry, root, parked, memo)
    for inst in pairs(registry) do
        if not Theme.Reachable(inst, root, parked, memo) then
            registry[inst] = nil
        end
    end
end

function Theme.Prune()
    local root = State.Gui
    if not root then
        return
    end
    local parked, memo = Theme.ParkedRoots(), {}
    Theme.PruneRegistry(Theme.Bound, root, parked, memo)
    Theme.PruneRegistry(Theme.InstanceRenderers, root, parked, memo)
    Theme.PruneRegistry(Lang.Bound, root, parked, memo)
    Theme.PruneRegistry(Lang.InstanceListeners, root, parked, memo)
    Theme.PruneRegistry(Fonts.Texts, root, parked, memo)
end

function Theme.Paint(inst, map)
    local colors = Theme.Colors
    for property, token in pairs(map) do
        local color = colors[token]
        if color ~= nil then
            inst[property] = color
        end
    end
end

---@param map table<string, string>  property -> token
function Theme.Bind(inst, map)
    local existing = Theme.Bound[inst]
    if existing then
        for property, token in pairs(map) do
            existing[property] = token
        end
    else
        Theme.Bound[inst] = map
    end
    Theme.Paint(inst, map)
    return inst
end

function Theme.Unbind(inst)
    Theme.Bound[inst] = nil
    Theme.InstanceRenderers[inst] = nil
end

---@param owner any  Instance (pruned with the gui) or any table key
function Theme.OnRender(owner, render)
    local registry = typeof(owner) == "Instance" and Theme.InstanceRenderers or Theme.Renderers
    registry[owner] = render
    Util.Try(render)
end

---@author xDTaraZ  Mario Hub UI V2
function Draw.New(className, props)
    local inst = Instance.new(className)
    local parent = props and props.Parent
    if props then
        for property, value in pairs(props) do
            if property ~= "Parent" then
                inst[property] = value
            end
        end
    end
    if inst:IsA("GuiObject") then
        inst.BorderSizePixel = 0
    end
    inst.Parent = parent
    return inst
end

function Draw.Corner(parent, radius)
    return Draw.New("UICorner", { CornerRadius = typeof(radius) == "UDim" and radius or UDim.new(0, radius or 8), Parent = parent })
end

function Draw.Stroke(parent, token, thickness, border)
    local stroke = Draw.New("UIStroke", {
        Thickness = thickness or 2,
        ApplyStrokeMode = border and Enum.ApplyStrokeMode.Border or Enum.ApplyStrokeMode.Contextual,
        LineJoinMode = Enum.LineJoinMode.Round,
        Parent = parent,
    })
    Theme.Bind(stroke, { Color = token or "Outline" })
    return stroke
end

function Draw.Padding(parent, top, right, bottom, left)
    return Draw.New("UIPadding", {
        PaddingTop = UDim.new(0, top or 0),
        PaddingRight = UDim.new(0, right or top or 0),
        PaddingBottom = UDim.new(0, bottom or top or 0),
        PaddingLeft = UDim.new(0, left or right or top or 0),
        Parent = parent,
    })
end

function Draw.List(parent, gap, horizontal, alignX, alignY)
    return Draw.New("UIListLayout", {
        Padding = UDim.new(0, gap or 0),
        FillDirection = horizontal and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical,
        HorizontalAlignment = alignX or Enum.HorizontalAlignment.Left,
        VerticalAlignment = alignY or Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = parent,
    })
end

---@param spec any?  text spec, bound to the language system
function Draw.Text(props, font, size, token, spec)
    props.BackgroundTransparency = 1
    props.Text = props.Text or ""
    props.TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left
    props.RichText = props.RichText or false
    local className = props.ClassName or "TextLabel"
    props.ClassName = nil
    local label = Draw.New(className, props)
    Fonts.Style(label, font or "Body", size or Util.TextSize("Label"))
    Theme.Bind(label, { TextColor3 = token or "Text" })
    if spec ~= nil then
        Lang.Bind(label, spec)
    end
    return label
end

function Draw.Box(className, props, fill, stroke, radius, thickness)
    local box = Draw.New(className, props)
    if fill then
        Theme.Bind(box, { BackgroundColor3 = fill })
    elseif props.BackgroundTransparency == nil then
        box.BackgroundTransparency = 1
    end
    if radius then
        Draw.Corner(box, radius)
    end
    if stroke then
        Draw.Stroke(box, stroke, thickness or 2, true)
    end
    if box:IsA("GuiButton") then
        box.AutoButtonColor = false
        if box:IsA("TextButton") then
            box.Text = ""
        end
    end
    return box
end

---@return Frame holder, Frame face, Frame shade, number depth  raised block, face sinks onto shade when pressed
function Draw.Block(parent, faceToken, shadeToken, radius, depth)
    depth = depth or Platform.Metric("Depth")
    local holder = Draw.New("Frame", { BackgroundTransparency = 1, Parent = parent })
    local shade = Draw.Box("Frame", {
        Position = UDim2.fromOffset(0, depth),
        Size = UDim2.new(1, 0, 1, -depth),
        Parent = holder,
    }, shadeToken, "Outline", radius, 2)
    local face = Draw.Box("Frame", { Size = UDim2.new(1, 0, 1, -depth), Parent = holder }, faceToken, "Outline", radius, 2)
    return holder, face, shade, depth
end

function Draw.Cloud(parent, width, token)
    local cloud = Draw.New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(width, width * 0.5), Parent = parent })
    local puffs = { { 0, 0.35, 0.42 }, { 0.24, 0, 0.55 }, { 0.55, 0.18, 0.45 } }
    for _, puff in ipairs(puffs) do
        local ball = Draw.New("Frame", {
            Position = UDim2.fromScale(puff[1], puff[2]),
            Size = UDim2.fromScale(puff[3], puff[3] * 2),
            Parent = cloud,
        })
        Draw.Corner(ball, UDim.new(1, 0))
        Theme.Bind(ball, { BackgroundColor3 = token or "Cloud" })
        Theme.OnRender(ball, function()
            ball.BackgroundTransparency = Theme.Colors.CloudAlpha or 0
        end)
    end
    local base = Draw.New("Frame", { Position = UDim2.fromScale(0.08, 0.6), Size = UDim2.fromScale(0.86, 0.4), Parent = cloud })
    Draw.Corner(base, UDim.new(1, 0))
    Theme.Bind(base, { BackgroundColor3 = token or "Cloud" })
    Theme.OnRender(base, function()
        base.BackgroundTransparency = Theme.Colors.CloudAlpha or 0
    end)
    return cloud
end

function Draw.Emblem(parent, size)
    local image, pending = Assets.Resolve("logo")
    if image then
        return Draw.New("ImageLabel", { BackgroundTransparency = 1, Image = image, Size = UDim2.fromOffset(size, size), ScaleType = Enum.ScaleType.Fit, Parent = parent })
    end
    local emblem = Draw.Box("Frame", { Size = UDim2.fromOffset(size, size), Parent = parent }, "Accent", "Outline", UDim.new(1, 0), 2)
    local ring = Draw.New("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.7, 0.7),
        Parent = emblem,
    })
    Draw.Corner(ring, UDim.new(1, 0))
    Theme.Bind(ring, { BackgroundColor3 = "White" })
    local letter = Draw.Text({
        Text = "M",
        Size = UDim2.fromScale(1, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
        Position = UDim2.fromOffset(0, 1),
        Parent = ring,
    }, "Logo", math.floor(size * 0.5), "Accent")
    letter.TextScaled = false
    Assets.Later(pending, emblem)
    return emblem
end

function Draw.Bricks(parent, columns, token)
    local mortar = {}
    for row = 0, 1 do
        local shift = row == 0 and 0 or 0.5 / columns
        for column = 0, columns do
            table.insert(mortar, Draw.New("Frame", {
                Position = UDim2.new(column / columns + shift, 0, row * 0.5, 0),
                Size = UDim2.new(0, 2, 0.5, 0),
                Parent = parent,
            }))
        end
    end
    local seam = Draw.New("Frame", { Position = UDim2.new(0, 0, 0.5, -1), Size = UDim2.new(1, 0, 0, 2), Parent = parent })
    table.insert(mortar, seam)
    for _, line in ipairs(mortar) do
        Theme.Bind(line, { BackgroundColor3 = token or "BrickDark" })
    end
end

function Draw.PoolHolder()
    local holder = Draw.Holder
    if holder and holder.Parent then
        return holder
    end
    holder = Draw.New("Frame", { Name = "Pool", BackgroundTransparency = 1, Visible = false, Parent = State.Stage })
    Draw.Holder = holder
    return holder
end

---@param factory fun(): Instance
---@return table  { Acquire(): Instance, Release(inst) }
function Draw.Pool(key, factory)
    local existing = Draw.Pools[key]
    if existing then
        return existing
    end
    local pool = { Free = {}, Factory = factory }

    function pool.Acquire()
        local free = pool.Free
        local count = #free
        if count == 0 then
            return pool.Factory()
        end
        local inst = free[count]
        free[count] = nil
        return inst
    end

    function pool.Release(inst)
        if not inst or Library.Unloaded then
            return
        end
        Motion.Cancel(inst)
        if inst.Parent == nil then
            return
        end
        inst.Parent = Draw.PoolHolder()
        table.insert(pool.Free, inst)
    end

    Draw.Pools[key] = pool
    return pool
end

---@author xDTaraZ  Mario Hub UI V2
Motion.Springs = {}
Motion.ByInst = {}
Motion.Free = {}
Motion.Homes = {}
Motion.Shown = {}
Motion.Finished = {}
Motion.Sizes = { number = 1, Vector2 = 2, Color3 = 3, UDim2 = 4 }

---@param out number[]  filled in place
function Motion.Pack(kind, value, out)
    if kind == "number" then
        out[1] = value
    elseif kind == "UDim2" then
        out[1], out[2], out[3], out[4] = value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset
    elseif kind == "Vector2" then
        out[1], out[2] = value.X, value.Y
    else
        out[1], out[2], out[3] = value.R, value.G, value.B
    end
end

function Motion.Unpack(kind, values)
    if kind == "number" then
        return values[1]
    elseif kind == "UDim2" then
        return UDim2.new(values[1], values[2], values[3], values[4])
    elseif kind == "Vector2" then
        return Vector2.new(values[1], values[2])
    end
    return Color3.new(math.clamp(values[1], 0, 1), math.clamp(values[2], 0, 1), math.clamp(values[3], 0, 1))
end

---@return number  angular speed for a Config.Motion.Speed key or raw number
function Motion.SpeedOf(speedKey)
    if type(speedKey) == "number" then
        return speedKey
    end
    local speeds = Config.Motion.Speed
    return speeds[speedKey or "Normal"] or speeds.Normal
end

function Motion.Get(inst, prop)
    local props = Motion.ByInst[inst]
    return props and props[prop]
end

function Motion.Create(inst, prop, kind)
    local spring = table.remove(Motion.Free) or { Pos = {}, Vel = {}, Goal = {} }
    spring.Inst, spring.Prop, spring.Kind, spring.Count = inst, prop, kind, Motion.Sizes[kind]
    Motion.Pack(kind, inst[prop], spring.Pos)
    for index = 1, spring.Count do
        spring.Vel[index] = 0
    end
    local props = Motion.ByInst[inst]
    if not props then
        props = {}
        Motion.ByInst[inst] = props
    end
    props[prop] = spring
    table.insert(Motion.Springs, spring)
    spring.Index = #Motion.Springs
    return spring
end

---@param keepCallback boolean?  run OnDone (normal finish) instead of dropping it
function Motion.Remove(spring, keepCallback)
    local springs = Motion.Springs
    local last = springs[#springs]
    springs[spring.Index] = last
    last.Index = spring.Index
    springs[#springs] = nil
    local props = Motion.ByInst[spring.Inst]
    if props then
        props[spring.Prop] = nil
        if next(props) == nil then
            Motion.ByInst[spring.Inst] = nil
        end
    end
    local onDone, inst = spring.OnDone, spring.Inst
    spring.Inst, spring.OnDone = nil, nil
    table.insert(Motion.Free, spring)
    if keepCallback and onDone then
        Util.Try(onDone, inst)
    end
end

---@param target any  number | UDim2 | Vector2 | Color3
---@param speedKey any?  Config.Motion.Speed key or number
---@param options table?  { Damping, OnDone(inst) }
function Motion.Spring(inst, prop, target, speedKey, options)
    local kind = typeof(target)
    if Motion.Reduced or not Motion.Sizes[kind] then
        Motion.Set(inst, prop, target)
        if options and options.OnDone then
            Util.Try(options.OnDone, inst)
        end
        return
    end
    local spring = Motion.Get(inst, prop) or Motion.Create(inst, prop, kind)
    Motion.Pack(kind, target, spring.Goal)
    spring.Speed = Motion.SpeedOf(speedKey)
    spring.Damping = options and options.Damping or Config.Motion.Damping
    spring.OnDone = options and options.OnDone
    Motion.Start()
end

---@param velocity number[]  per-component velocity added to the spring (target = current goal)
function Motion.Impulse(inst, prop, velocity, speedKey, damping)
    if Motion.Reduced then
        return
    end
    local spring = Motion.Get(inst, prop)
    if not spring then
        local kind = typeof(inst[prop])
        if not Motion.Sizes[kind] then
            return
        end
        spring = Motion.Create(inst, prop, kind)
        Motion.Pack(kind, inst[prop], spring.Goal)
        spring.OnDone = nil
    end
    for index = 1, spring.Count do
        spring.Vel[index] += velocity[index] or 0
    end
    spring.Speed = Motion.SpeedOf(speedKey)
    spring.Damping = damping or Config.Motion.Damping
    Motion.Start()
end

function Motion.Set(inst, prop, value)
    local spring = Motion.Get(inst, prop)
    if spring then
        Motion.Remove(spring, false)
    end
    inst[prop] = value
end

---@return any  where the property is heading (goal if springing, else current)
function Motion.Target(inst, prop)
    local spring = Motion.Get(inst, prop)
    if spring then
        return Motion.Unpack(spring.Kind, spring.Goal)
    end
    return inst[prop]
end

function Motion.Cancel(inst)
    local props = Motion.ByInst[inst]
    if not props then
        return
    end
    for _, spring in pairs(props) do
        Motion.Remove(spring, false)
    end
end

---Springs are stepped by the single services frame loop while this flag is set.
function Motion.Start()
    Motion.Running = #Motion.Springs > 0
end

function Motion.Stop()
    Motion.Running = false
end

---@return boolean  true once position and velocity are inside epsilon
function Motion.Advance(spring, step, substeps)
    local pos, vel, goal = spring.Pos, spring.Vel, spring.Goal
    local omega, zeta = spring.Speed, spring.Damping
    local stiffness, friction = omega * omega, 2 * zeta * omega
    local epsilon = Config.Motion.Epsilon
    local settled = true
    for index = 1, spring.Count do
        local offset, speed = pos[index] - goal[index], vel[index]
        for _ = 1, substeps do
            speed += (-stiffness * offset - friction * speed) * step
            offset += speed * step
        end
        pos[index], vel[index] = goal[index] + offset, speed
        if math.abs(offset) > epsilon or math.abs(speed) > epsilon * omega then
            settled = false
        end
    end
    return settled
end

function Motion.Step(deltaTime)
    local motion = Config.Motion
    deltaTime = math.min(deltaTime, motion.MaxDelta)
    local substeps = math.max(1, math.ceil(deltaTime / motion.MaxStep))
    local step = deltaTime / substeps
    local springs = Motion.Springs
    for index = #springs, 1, -1 do
        local spring = springs[index]
        if spring then
            local settled = Motion.Advance(spring, step, substeps)
            local inst, prop = spring.Inst, spring.Prop
            if settled then
                inst[prop] = Motion.Unpack(spring.Kind, spring.Goal)
                local onDone = spring.OnDone
                if onDone then
                    table.insert(Motion.Finished, { onDone, inst })
                end
                Motion.Remove(spring, false)
            else
                inst[prop] = Motion.Unpack(spring.Kind, spring.Pos)
            end
        end
    end
    Motion.Flush()
    if #springs == 0 then
        Motion.Stop()
    end
end

---Runs OnDone callbacks queued by Step after the sweep, so callbacks that add or cancel springs never reorder the live list mid-iteration.
function Motion.Flush()
    local finished = Motion.Finished
    if #finished == 0 then
        return
    end
    Motion.Finished = {}
    for _, entry in ipairs(finished) do
        Util.Try(entry[1], entry[2])
    end
end

function Motion.FinishAll()
    local springs = Motion.Springs
    for index = #springs, 1, -1 do
        local spring = springs[index]
        if spring then
            spring.Inst[spring.Prop] = Motion.Unpack(spring.Kind, spring.Goal)
            Motion.Remove(spring, true)
        end
    end
    Motion.Stop()
end

function Motion.Refresh()
    local reduced = Motion.UserReduced
    if reduced == Motion.Reduced then
        return
    end
    Motion.Reduced = reduced
    if reduced then
        Motion.FinishAll()
    end
end

function Motion.SetReduced(enabled)
    Motion.UserReduced = enabled == true
    Motion.Refresh()
end

---Call once per rendered frame (services loop); keeps State.Fps for the watermark.
function Motion.ReportFps(deltaTime)
    if deltaTime <= 0 then
        return
    end
    State.Fps = State.Fps * 0.92 + (1 / deltaTime) * 0.08
end

---@return UIScale
function Motion.ScaleOf(frame)
    local scale = frame:FindFirstChild("MotionScale")
    if not scale then
        scale = Draw.New("UIScale", { Name = "MotionScale", Parent = frame })
    end
    return scale
end

function Motion.SetHome(frame, position)
    Motion.Homes[frame] = position
    if Motion.Shown[frame] ~= false then
        Motion.Set(frame, "Position", position)
    end
end

---@return UDim2  offset applied while hidden
function Motion.PresenceOffset(from, distance)
    if from == "Top" then
        return UDim2.fromOffset(0, -distance)
    elseif from == "Left" then
        return UDim2.fromOffset(-distance, 0)
    elseif from == "Right" then
        return UDim2.fromOffset(distance, 0)
    elseif from == "Scale" then
        return UDim2.new()
    end
    return UDim2.fromOffset(0, distance)
end

function Motion.HideDone(frame)
    if Motion.Shown[frame] == false then
        frame.Visible = false
    end
end

Motion.HideOptions = { OnDone = Motion.HideDone }

---@param options table?  { From = "Bottom"|"Top"|"Left"|"Right"|"Scale", Distance, Speed }
function Motion.Presence(frame, shown, options)
    options = options or {}
    local from = options.From or "Bottom"
    local home = Motion.Homes[frame]
    if not home then
        home = frame.Position
        Motion.Homes[frame] = home
    end
    if Motion.Shown[frame] == shown and frame.Visible == shown then
        return
    end
    Motion.Shown[frame] = shown
    local hidden = home + Motion.PresenceOffset(from, options.Distance or 16)
    local canvas = frame:IsA("CanvasGroup")
    local scale = from == "Scale" and Motion.ScaleOf(frame)
    if shown and not frame.Visible then
        Motion.Set(frame, "Position", hidden)
        if canvas then
            Motion.Set(frame, "GroupTransparency", 1)
        end
        if scale then
            Motion.Set(scale, "Scale", 0.92)
        end
        frame.Visible = true
    end
    local speed = options.Speed or "Normal"
    local doneOptions = not shown and Motion.HideOptions or nil
    local fadeDone = canvas and doneOptions or nil
    local scaleDone = not canvas and scale and doneOptions or nil
    local moveDone = not canvas and not scale and doneOptions or nil
    if canvas then
        Motion.Spring(frame, "GroupTransparency", shown and 0 or 1, speed, fadeDone)
    end
    if scale then
        Motion.Spring(scale, "Scale", shown and 1 or 0.92, speed, scaleDone)
    end
    Motion.Spring(frame, "Position", shown and home or hidden, speed, moveDone)
end

function Motion.Forget(frame)
    Motion.Homes[frame] = nil
    Motion.Shown[frame] = nil
    Motion.Cancel(frame)
end

function Motion.MakeRipple()
    local circle = Draw.New("Frame", {
        Name = "Ripple",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        ZIndex = Config.Z.Hit,
    })
    Draw.Corner(circle, UDim.new(1, 0))
    return circle
end

function Motion.RippleDone(circle)
    Draw.Pool("Ripple", Motion.MakeRipple).Release(circle)
end

Motion.RippleOptions = { OnDone = Motion.RippleDone }

---@param position Vector2?  screen point (input.Position); nil = center
function Motion.Ripple(button, position)
    if Motion.Reduced or not button.Parent then
        return
    end
    local size = button.AbsoluteSize
    local localPos = position and (Vector2.new(position.X, position.Y) - button.AbsolutePosition) or size / 2
    local circle = Draw.Pool("Ripple", Motion.MakeRipple).Acquire()
    local settings = Config.Motion.Ripple
    local diameter = math.max(size.X, size.Y) * settings.Grow
    circle.Position = UDim2.fromOffset(localPos.X, localPos.Y)
    circle.Size = UDim2.new()
    circle.BackgroundTransparency = settings.Alpha
    circle.Parent = button
    Motion.Spring(circle, "Size", UDim2.fromOffset(diameter, diameter), "Soft")
    Motion.Spring(circle, "BackgroundTransparency", 1, "Soft", Motion.RippleOptions)
end

function Motion.Pop(frame)
    if Motion.Reduced then
        return
    end
    local pop = Config.Motion.Pop
    local scale = Motion.ScaleOf(frame)
    Motion.Set(scale, "Scale", pop.From)
    Motion.Spring(scale, "Scale", 1, pop.Speed, pop)
end

function Motion.Shake(frame)
    local shake = Config.Motion.Shake
    Motion.Impulse(frame, "Position", { 0, shake.Impulse, 0, 0 }, shake.Speed, shake.Damping)
end

function Motion.MakeCoin()
    local size = Config.Motion.Coin.Size
    local coin = Sprite.New(nil, "coin", size)
    coin.AnchorPoint = Vector2.new(0.5, 1)
    coin.ZIndex = Config.Z.Pop
    return coin
end

function Motion.CoinDone(coin)
    Draw.Pool("Coin", Motion.MakeCoin).Release(coin)
end

Motion.CoinShrinkOptions = { OnDone = Motion.CoinDone }

function Motion.CoinRisen(coin)
    Motion.Spring(coin, "Size", UDim2.fromOffset(0, Config.Motion.Coin.Size), "Fast", Motion.CoinShrinkOptions)
end

Motion.CoinRiseOptions = { OnDone = Motion.CoinRisen }

---@param origin UDim2  spawn point inside parent
function Motion.CoinPop(parent, origin)
    if Motion.Reduced or not Particles.Enabled then
        return
    end
    local coin = Draw.Pool("Coin", Motion.MakeCoin).Acquire()
    local settings = Config.Motion.Coin
    coin.Size = UDim2.fromOffset(settings.Size, settings.Size)
    coin.Position = origin
    coin.Parent = parent
    Motion.Spring(coin, "Position", origin - UDim2.fromOffset(0, settings.Rise), "Normal", Motion.CoinRiseOptions)
end

table.insert(State.UnloadHooks, Motion.Stop)

---@author xDTaraZ  Mario Hub UI V2
function Fx.MakeSpark()
    return Draw.Text({ Name = "Spark", AnchorPoint = Vector2.new(0.5, 0.5), TextXAlignment = Enum.TextXAlignment.Center }, "Glyph", 12, "Coin")
end

function Fx.SparkDone(spark)
    Draw.Pool("FxSpark", Fx.MakeSpark).Release(spark)
end

Fx.SparkOptions = { OnDone = Fx.SparkDone }

---Small star burst used on presses (dock, header blocks). Pooled, skipped when motion or particles are off.
---@param origin UDim2  burst centre inside parent
---@param count number?
function Fx.Burst(parent, origin, count)
    if Motion.Reduced or not Particles.Enabled or not parent.Parent then
        return
    end
    local burst = Config.Decor.Burst
    local pool = Draw.Pool("FxSpark", Fx.MakeSpark)
    count = count or burst.Count
    local turn = math.random() * math.pi * 2
    for index = 1, count do
        local spark = pool.Acquire()
        local angle = turn + index / count * math.pi * 2
        local reach = burst.Reach * (0.7 + math.random() * 0.5)
        spark.Text = burst.Glyph
        spark.TextSize = math.random(burst.Size[1], burst.Size[2])
        spark.Size = UDim2.fromOffset(spark.TextSize + 4, spark.TextSize + 4)
        spark.TextTransparency, spark.Rotation, spark.Position = 0, 0, origin
        spark.ZIndex = Config.Chrome.Z.Fx
        spark.Parent = parent
        Motion.Spring(spark, "Position", origin + UDim2.fromOffset(math.cos(angle) * reach, math.sin(angle) * reach), "Normal")
        Motion.Spring(spark, "Rotation", math.random(-90, 90), "Normal")
        Motion.Spring(spark, "TextTransparency", 1, burst.Fade, Fx.SparkOptions)
    end
end

---Block bump: kicks the frame up and lets its spring bring it home.
function Fx.Bump(frame)
    local bump = Config.Decor.Bump
    Motion.Impulse(frame, "Position", { 0, 0, 0, -bump.Velocity }, "Fast", bump.Damping)
end

---Hover rise; home is the first position seen for the frame.
function Fx.Lift(frame, lifted)
    local home = Fx.Homes[frame]
    if not home then
        home = frame.Position
        Fx.Homes[frame] = home
        frame.Destroying:Once(function()
            Fx.Homes[frame] = nil
        end)
    end
    Motion.Spring(frame, "Position", lifted and home - UDim2.fromOffset(0, Config.Decor.Lift) or home, "Fast")
end

---Runs fn(value) for each value, gap seconds apart. Instant for everything when motion is reduced.
function Fx.Stagger(values, gap, fn)
    for index, value in ipairs(values) do
        if index == 1 or Motion.Reduced then
            fn(value)
        else
            task.delay((index - 1) * gap, fn, value)
        end
    end
end

---@return table  { X: NumberValue, Y: NumberValue }  drives frame.Size as a scale pair, so X and Y spring separately
function Fx.Axis(frame)
    local axis = { Frame = frame, X = Draw.New("NumberValue", { Value = 1 }), Y = Draw.New("NumberValue", { Value = 1 }) }
    local function Apply()
        frame.Size = UDim2.fromScale(axis.X.Value, axis.Y.Value)
    end
    Util.Connect(axis.X.Changed, Apply)
    Util.Connect(axis.Y.Changed, Apply)
    return axis
end

function Fx.SetAxis(axis, x, y)
    Motion.Set(axis.X, "Value", x)
    Motion.Set(axis.Y, "Value", y)
end

---Squash and stretch: different speeds per axis make the frame stretch thin then bulge wide.
---@param options table  { SpeedX, SpeedY, Damping, OnDone() }  OnDone fires when Y settles
function Fx.Warp(axis, x, y, options)
    local onDone = options.OnDone
    Motion.Spring(axis.X, "Value", x, options.SpeedX, { Damping = options.Damping })
    Motion.Spring(axis.Y, "Value", y, options.SpeedY, {
        Damping = options.Damping,
        OnDone = onDone and function()
            onDone()
        end,
    })
end

---@return UIScale
function Fx.ScaleOf(frame)
    local scale = frame:FindFirstChild("FxScale")
    if not scale then
        scale = Draw.New("UIScale", { Name = "FxScale", Parent = frame })
    end
    return scale
end

---Puts a card below its slot and slightly small, ready for Fx.Rise.
function Fx.Prime(frame)
    local cards = Config.Chrome.Cards
    Motion.Set(frame, "Position", UDim2.fromOffset(0, cards.Rise))
    Motion.Set(Fx.ScaleOf(frame), "Scale", cards.Scale)
end

Fx.RiseOptions = {}

function Fx.Rise(frame)
    if not frame.Parent then
        return
    end
    local cards = Config.Chrome.Cards
    Fx.RiseOptions.Damping = cards.Damping
    Motion.Spring(frame, "Position", UDim2.new(), "Normal", Fx.RiseOptions)
    Motion.Spring(Fx.ScaleOf(frame), "Scale", 1, "Normal", Fx.RiseOptions)
end

---@author xDTaraZ  Mario Hub UI V2
function Container.New(host, options)
    options = options or {}
    local self = setmetatable({
        Host = host,
        Items = {},
        Parent = nil,
        Depth = 0,
        PadX = options.PadX or 0,
        PadY = options.PadY or 0,
        GapX = options.GapX or Config.Gap.X,
        GapY = options.GapY or Config.Gap.Y,
        Width = 0,
        ContentHeight = 0,
        Scroll = host:IsA("ScrollingFrame"),
        OnHeight = options.OnHeight,
        IndentX = 0,
        PendingSameLine = nil,
        Window = options.Window,
        Tab = options.Tab,
    }, Container)
    if options.Parent then
        self:SetParent(options.Parent)
    end
    Layout.All[self] = true
    return self
end

function Container:SetParent(parent)
    self.Parent = parent
    self.Depth = parent and parent.Depth + 1 or 0
    self.Window = self.Window or (parent and parent.Window)
    self.Tab = self.Tab or (parent and parent.Tab)
end

---Containers of a parked view wait in its own Parked set, so Flush never walks them.
function Container:MarkDirty()
    local view = self.Tab
    if view and view.Dormant then
        view.Parked = view.Parked or {}
        view.Parked[self] = true
        return
    end
    Layout.Dirty[self] = true
end

function Container:SetWidth(width)
    width = math.max(0, math.floor(width))
    if width == self.Width then
        return
    end
    self.Width = width
    self:MarkDirty()
end

---@param spec table?  { Width, Height = number|fun(width), Child, ChildInset, OnLayout, AutoWidth, Fill, After, Search, Label, Widget }
---@return table      layout item; Width nil = rest, 0..1 = share, >1 = px, <0 = rest minus px
function Container:Add(frame, spec)
    spec = spec or {}
    local item = {
        Frame = frame,
        Width = spec.Width,
        Height = spec.Height or Util.Metric("Row"),
        Indent = self.IndentX,
        Child = spec.Child,
        ChildInset = spec.ChildInset,
        OnLayout = spec.OnLayout,
        AutoWidth = spec.AutoWidth,
        Fill = spec.Fill,
        Search = spec.Search,
        Label = spec.Label,
        Widget = spec.Widget,
        Hidden = false,
        Filtered = false,
    }
    if self.PendingSameLine then
        item.SameLine = true
        item.Gap = self.PendingSameLine.Gap
        self.PendingSameLine = nil
    end
    frame.Parent = self.Host
    self:Insert(item, spec.After)
    if spec.Child then
        spec.Child:SetParent(self)
    end
    self:MarkDirty()
    return item
end

function Container:Insert(item, after)
    for index, existing in ipairs(self.Items) do
        if existing == after then
            table.insert(self.Items, index + 1, item)
            return
        end
    end
    table.insert(self.Items, item)
end

function Container:Remove(item)
    local index = table.find(self.Items, item)
    if index then
        table.remove(self.Items, index)
    end
    if item.Child then
        item.Child:Destroy()
    end
    self:Forget(item.Frame)
    Motion.Forget(item.Frame)
    item.Frame:Destroy()
    self:MarkDirty()
end

function Container:Clear()
    for index = #self.Items, 1, -1 do
        self:Remove(self.Items[index])
    end
end

function Container:Destroy()
    if self.Destroyed then
        return
    end
    self.Destroyed = true
    for _, item in ipairs(self.Items) do
        self:Forget(item.Frame)
        if item.Child then
            item.Child:Destroy()
        end
    end
    self.Ids = nil
    Layout.All[self] = nil
    Layout.Dirty[self] = nil
    if self.Tab and self.Tab.Parked then
        self.Tab.Parked[self] = nil
    end
end

---Drops a frame from its view's detached set so a parked page never re-attaches a destroyed row.
function Container:Forget(frame)
    local detached = self.Tab and self.Tab.Detached
    if detached then
        detached[frame] = nil
    end
end

function Container:SameLine(gap)
    self.PendingSameLine = { Gap = gap }
    return self
end

function Container:NewLine()
    self.PendingSameLine = nil
    return self:Spacing(0)
end

function Container:Spacing(height)
    local spacer = Draw.New("Frame", { Name = "Spacing", BackgroundTransparency = 1 })
    self:Add(spacer, { Height = height or Config.Gap.Y })
    return self
end

function Container:Indent(width)
    self.IndentX += width or 16
    return self
end

function Container:Unindent(width)
    self.IndentX = math.max(0, self.IndentX - (width or 16))
    return self
end

function Layout.ResolveWidth(spec, available, used, gap)
    local remaining = math.max(0, available - used)
    if spec == nil or spec == 0 then
        return remaining
    end
    if spec < 0 then
        return math.max(0, remaining + spec)
    end
    if spec <= 1 then
        return math.min(remaining, math.floor((available + gap) * spec - gap + 0.5))
    end
    return math.min(spec, remaining)
end

---Items joined by SameLine with no width fit their content instead of stretching.
function Layout.ItemWidth(item, joined, available, used, gap)
    if item.Width == nil and item.AutoWidth and not item.Fill and (joined or item.SameLine) then
        return math.min(item.AutoWidth(), math.max(0, available - used))
    end
    return Layout.ResolveWidth(item.Width, available, used, gap)
end

function Container:Place(item, cursor, available, joined)
    if item.SameLine and cursor.EndX then
        cursor.X = cursor.EndX + (item.Gap or self.GapX)
    else
        if cursor.EndX then
            cursor.Y += cursor.LineHeight + self.GapY
        end
        cursor.X = self.PadX + item.Indent
        cursor.LineHeight = 0
    end
    local width = Layout.ItemWidth(item, joined, available, cursor.X - self.PadX, self.GapX)
    local height = type(item.Height) == "function" and item.Height(width) or item.Height
    local position, size = UDim2.fromOffset(cursor.X, cursor.Y), UDim2.fromOffset(width, height)
    if item.Frame.Position ~= position or Motion.Get(item.Frame, "Position") then
        Motion.Set(item.Frame, "Position", position)
    end
    if item.Frame.Size ~= size then
        item.Frame.Size = size
    end
    if item.Child then
        item.Child:SetWidth(width - (item.ChildInset or 0))
    end
    if item.OnLayout then
        item.OnLayout(width, height)
    end
    cursor.EndX = cursor.X + width
    cursor.LineHeight = math.max(cursor.LineHeight, height)
end

---Containers of a parked tab lay out when the tab is warmed or shown.
function Container:Layout()
    Layout.Dirty[self] = nil
    if self.Destroyed then
        return
    end
    local view = self.Tab
    if view and view.Dormant and not view.Warming then
        self:MarkDirty()
        return
    end
    if self.Width <= 0 then
        return
    end
    local available = math.max(0, self.Width - self.PadX * 2)
    local cursor = self.Cursor
    if not cursor then
        cursor = {}
        self.Cursor = cursor
    end
    cursor.X, cursor.Y, cursor.LineHeight, cursor.EndX = self.PadX, self.PadY, 0, nil
    local visible = Layout.Visible
    table.clear(visible)
    for _, item in ipairs(self.Items) do
        local shown = not item.Hidden and not item.Filtered
        if item.Frame.Visible ~= shown then
            item.Frame.Visible = shown
        end
        if shown then
            visible[#visible + 1] = item
        end
    end
    for index, item in ipairs(visible) do
        local following = visible[index + 1]
        self:Place(item, cursor, available, following ~= nil and following.SameLine == true)
    end
    table.clear(visible)
    local height = cursor.EndX and (cursor.Y + cursor.LineHeight + self.PadY) or 0
    self:Commit(height)
end

function Container:Commit(height)
    if self.Scroll then
        self.Host.CanvasSize = UDim2.fromOffset(0, height)
    end
    if height == self.ContentHeight then
        return
    end
    self.ContentHeight = height
    if self.OnHeight then
        Util.Try(self.OnHeight, height)
    end
    if self.Parent then
        self.Parent:MarkDirty()
    end
end

function Layout.ByDepth(left, right)
    return left.Depth < right.Depth
end

function Layout.Flush()
    local batch = Layout.Batch
    for _ = 1, Config.LayoutPasses do
        if next(Layout.Dirty) == nil then
            return
        end
        table.clear(batch)
        for container in pairs(Layout.Dirty) do
            batch[#batch + 1] = container
        end
        table.sort(batch, Layout.ByDepth)
        for _, container in ipairs(batch) do
            if Layout.Dirty[container] then
                container:Layout()
            end
        end
    end
    table.clear(batch)
end

---Hands a view's parked containers back to Flush once it is shown.
function Layout.Wake(view)
    local parked = view.Parked
    if not parked then
        return
    end
    for container in pairs(parked) do
        Layout.Dirty[container] = true
    end
    table.clear(parked)
end

---Lays out a dormant view until the clock passes deadline.
---@return boolean  true once nothing of the view is left to lay out
function Layout.Warm(view, deadline)
    local parked = view.Parked
    if not parked or next(parked) == nil then
        return true
    end
    local batch = Layout.WarmBatch
    view.Warming = true
    for _ = 1, Config.LayoutPasses do
        if next(parked) == nil or os.clock() >= deadline then
            break
        end
        table.clear(batch)
        for container in pairs(parked) do
            batch[#batch + 1] = container
        end
        table.sort(batch, Layout.ByDepth)
        for _, container in ipairs(batch) do
            if os.clock() >= deadline then
                break
            end
            if parked[container] then
                parked[container] = nil
                container:Layout()
            end
        end
    end
    view.Warming = false
    table.clear(batch)
    return next(parked) == nil
end

function Layout.MarkAll()
    for container in pairs(Layout.All) do
        container:MarkDirty()
    end
end

---@return Vector2  text bounds wrapped at width (cached)
function Layout.Measure(text, size, fontKind, width)
    width = math.max(1, math.floor(width))
    local key = table.concat({ text, size, fontKind, width, State.Language }, "\0")
    local cached = Layout.Measured[key]
    if cached then
        return cached
    end
    if Layout.MeasuredCount > Config.MeasureCacheLimit then
        table.clear(Layout.Measured)
        Layout.MeasuredCount = 0
    end
    local face = Fonts.Face(fontKind)
    local font = Layout.EnumFont(face)
    local bounds
    if font then
        bounds = Layout.TextService:GetTextSize(text, size, font, Vector2.new(width, 100000))
    else
        local probe = Layout.Probe()
        probe.FontFace = face
        probe.TextSize = size
        probe.Size = UDim2.fromOffset(width, 100000)
        probe.Text = text
        bounds = probe.TextBounds
        if probe.AbsoluteSize.X ~= width then
            local fallback = Fonts.ThaiFallback[fontKind] or Enum.Font.BuilderSansBold
            return Layout.TextService:GetTextSize(text, size, fallback, Vector2.new(width, 100000))
        end
    end
    if bounds.X == 0 and text ~= "" then
        return bounds
    end
    Layout.Measured[key] = bounds
    Layout.MeasuredCount += 1
    return bounds
end

Layout.TextService = game:GetService("TextService")
Layout.EnumFonts = {}

---@return Enum.Font?  the enum behind a built-in face; nil for a custom face (Thai), which needs the probe label
function Layout.EnumFont(face)
    local cache = Layout.EnumFonts
    local key = face.Family .. "|" .. face.Weight.Name .. "|" .. face.Style.Name
    local cached = cache[key]
    if cached == nil then
        cached = false
        for _, font in ipairs(Enum.Font:GetEnumItems()) do
            if font ~= Enum.Font.Unknown and Font.fromEnum(font) == face then
                cached = font
                break
            end
        end
        cache[key] = cached
    end
    return cached or nil
end

---Off-screen TextLabel: GetTextSize only takes Enum.Font, so custom Thai faces need a real label.
function Layout.Probe()
    local host = Layout.ProbeHost()
    local probe = Layout.ProbeLabel
    if probe and probe.Parent then
        if probe.Parent ~= host then
            probe.Parent = host
            Layout.DropProbeGui()
        end
        return probe
    end
    probe = Draw.New("TextLabel", {
        Name = "Probe",
        BackgroundTransparency = 1,
        TextTransparency = 1,
        TextWrapped = true,
        Position = UDim2.fromOffset(-20000, -20000),
        Parent = host,
    })
    Layout.ProbeLabel = probe
    return probe
end

---TextBounds stays 0 outside a ScreenGui, so measuring before the window exists needs a private one.
---@return Instance  State.Gui once built, else a hidden ScreenGui owned by Layout
function Layout.ProbeHost()
    if State.Gui and State.Gui.Parent then
        return State.Gui
    end
    local gui = Layout.ProbeGui
    if gui and gui.Parent then
        return gui
    end
    gui = Draw.New("ScreenGui", {
        Name = "MeasureProbe",
        ResetOnSpawn = false,
        DisplayOrder = -1,
        Parent = Util.GuiParent(),
    })
    Layout.ProbeGui = gui
    return gui
end

function Layout.DropProbeGui()
    local gui = Layout.ProbeGui
    Layout.ProbeGui = nil
    if gui then
        gui:Destroy()
    end
end

function Layout.ScrollFrame(props)
    props.BackgroundTransparency = 1
    props.ScrollBarThickness = Config.Page.ScrollBar
    props.VerticalScrollBarInset = Enum.ScrollBarInset.Always
    props.ScrollingDirection = Enum.ScrollingDirection.Y
    props.CanvasSize = UDim2.new()
    props.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
    local frame = Draw.New("ScrollingFrame", props)
    Theme.Bind(frame, { ScrollBarImageColor3 = "Muted" })
    return frame
end

function Container:ColumnCount(width)
    local columns = self.ColumnSpec
    if columns.Count <= 1 or width < columns.Count * columns.MinWidth then
        return 1
    end
    for _, child in ipairs(columns.Children) do
        if #child.Items == 0 then
            return 1
        end
    end
    return columns.Count
end

---@return number  holder height for the current column arrangement
function Container:ColumnsHeight(width)
    local spec = self.ColumnSpec
    local count = self:ColumnCount(width)
    local total, tallest = 0, 0
    for index, child in ipairs(spec.Children) do
        total += child.ContentHeight + (index > 1 and self.GapY or 0)
        tallest = math.max(tallest, child.ContentHeight)
    end
    return count == 1 and total or tallest
end

function Container:ColumnsLayout(width)
    local spec = self.ColumnSpec
    local count = self:ColumnCount(width)
    local gap = Config.Gap.Column
    local columnWidth = count == 1 and width or math.floor((width - gap * (count - 1)) / count)
    local y = 0
    spec.Collapsed = count == 1
    for index, child in ipairs(spec.Children) do
        local x = count == 1 and 0 or (index - 1) * (columnWidth + gap)
        child.Host.Position = UDim2.fromOffset(x, count == 1 and y or 0)
        child.Host.Size = UDim2.fromOffset(columnWidth, child.ContentHeight)
        child:SetWidth(columnWidth)
        y += child.ContentHeight + self.GapY
    end
end

---@param count number      columns wanted
---@param minWidth number?  px per column before collapsing to one
---@return table[]          child Containers; .Holder is the shared layout item
function Container:Columns(count, minWidth)
    local holder = Draw.New("Frame", { Name = "Columns", BackgroundTransparency = 1 })
    local proxy = setmetatable({ Host = holder, GapY = self.GapY }, Container)
    local spec = { Count = count, MinWidth = minWidth or Config.Window.TwoColumnMin / 2, Children = {} }
    proxy.ColumnSpec = spec
    local item = self:Add(holder, {
        Height = function(width)
            return proxy:ColumnsHeight(width)
        end,
        OnLayout = function(width)
            proxy:ColumnsLayout(width)
        end,
    })
    for index = 1, count do
        local host = Draw.New("Frame", { Name = "Column" .. index, BackgroundTransparency = 1, Parent = holder })
        spec.Children[index] = Container.New(host, { Parent = self, GapX = self.GapX, GapY = self.GapY })
    end
    spec.Children.Holder = item
    return spec.Children
end

table.insert(State.UnloadHooks, Layout.DropProbeGui)
Platform.OnViewport(Layout.MarkAll)

---@author xDTaraZ  Mario Hub UI V2
Gui.TextKinds = { Body = "Label", Desc = "Desc", Strong = "Label", Display = "Header" }
Gui.Press = { Active = false, Token = 0 }

---@return table?  handle registered under id in this container
function Gui.Lookup(container, id)
    local ids = container.Ids
    return id ~= nil and ids and ids[id] or nil
end

function Gui.Remember(container, id, handle)
    if id == nil then
        return
    end
    container.Ids = container.Ids or {}
    container.Ids[id] = handle
end

function Gui.Current()
    return Gui.Stack[#Gui.Stack]
end

---@param options table?  { Width, Height, Scroll, PadX, PadY, Fill, Stroke, Radius, Clip }
---@return table  child Container (.Frame host, .Item parent layout item); drop with parent:Remove(child.Item)
function Gui.BeginChild(parent, id, options)
    local existing = Gui.Lookup(parent, id)
    if existing then
        table.insert(Gui.Stack, existing)
        return existing
    end
    options = options or {}
    local host
    if options.Scroll then
        host = Layout.ScrollFrame({ Name = tostring(id or "Child") })
        if options.Fill then
            host.BackgroundTransparency = 0
            Theme.Bind(host, { BackgroundColor3 = options.Fill })
        end
    else
        host = Draw.Box("Frame", { Name = tostring(id or "Child"), ClipsDescendants = options.Clip == true }, options.Fill, options.Stroke, options.Radius, 2)
    end
    local child = Container.New(host, { PadX = options.PadX, PadY = options.PadY, Parent = parent })
    local fixed = options.Height
    child.Frame = host
    child.Item = parent:Add(host, {
        Width = options.Width,
        Height = fixed or function()
            return child.ContentHeight
        end,
        Child = child,
    })
    Gui.Remember(parent, id, child)
    table.insert(Gui.Stack, child)
    return child
end

function Gui.EndChild()
    Gui.Stack[#Gui.Stack] = nil
    return Gui.Current()
end

function Gui.EnsureInput()
    if Gui.InputBound then
        return
    end
    Gui.InputBound = true
    Util.Connect(UserInputService.InputChanged, Gui.OnMove)
    Util.Connect(UserInputService.InputEnded, Gui.OnEnd)
end

function Gui.SetPressed(binder, pressed)
    local onPress = binder.Handlers.OnPress
    if onPress then
        Util.Try(onPress, pressed)
    end
end

function Gui.OnBegin(binder, input)
    if binder.Disabled or not Util.IsPointer(input) then
        return
    end
    local press = Gui.Press
    local touch = Enum.UserInputType.Touch
    if press.Active and press.Type == touch and input.UserInputType == touch and input ~= press.Input then
        return
    end
    if press.Active and press.Binder ~= binder then
        Gui.SetPressed(press.Binder, false)
    end
    press.Active, press.Binder, press.Input, press.Type = true, binder, input, input.UserInputType
    press.Start, press.Long = input.Position, false
    press.Token += 1
    Gui.SetPressed(binder, true)
    if binder.Handlers.OnLongPress then
        task.delay(Config.Click.LongPress, Gui.OnLongCheck, press.Token)
    end
end

function Gui.OnLongCheck(token)
    local press = Gui.Press
    if not press.Active or press.Token ~= token or Library.Unloaded then
        return
    end
    local binder = press.Binder
    if binder.Disabled or not binder.Frame.Parent then
        press.Active = false
        return
    end
    press.Long = true
    Gui.SetPressed(binder, false)
    Util.Try(binder.Handlers.OnLongPress)
end

function Gui.OnMove(input)
    local press = Gui.Press
    if not press.Active or press.Long then
        return
    end
    if input ~= press.Input and input.UserInputType ~= Enum.UserInputType.MouseMovement then
        return
    end
    local delta = input.Position - press.Start
    if Vector2.new(delta.X, delta.Y).Magnitude <= Config.Click.DragCancel then
        return
    end
    press.Active = false
    Gui.SetPressed(press.Binder, false)
end

function Gui.OnEnd(input)
    local press = Gui.Press
    if not press.Active then
        return
    end
    local mouse = press.Type == Enum.UserInputType.MouseButton1 and input.UserInputType == press.Type
    if input ~= press.Input and not mouse then
        return
    end
    press.Active = false
    local binder = press.Binder
    if press.Long then
        return
    end
    Gui.SetPressed(binder, false)
    local frame = binder.Frame
    if binder.Disabled or not frame.Parent or not Util.Inside(frame, input.Position) then
        return
    end
    Util.Try(binder.Handlers.OnClick, input)
end

function Gui.OnHoverChange(binder, hovered)
    if binder.Hovered == hovered or Platform.Touch then
        return
    end
    binder.Hovered = hovered
    local onHover = binder.Handlers.OnHover
    if onHover then
        Util.Try(onHover, hovered and not binder.Disabled)
    end
end

Gui.Binder = {}
Gui.Binder.__index = Gui.Binder

function Gui.Binder:SetDisabled(disabled)
    self.Disabled = disabled == true
    if self.Disabled and self.Hovered then
        self.Hovered = false
        Gui.OnHoverChange(self, false)
    end
end

function Gui.Binder:Disconnect()
    for _, conn in ipairs(self.Connections) do
        conn:Disconnect()
    end
    table.clear(self.Connections)
    local press = Gui.Press
    if press.Binder == self then
        press.Active, press.Binder, press.Input = false, nil, nil
    end
end

---@param handlers table  { OnClick(input), OnHover(bool), OnPress(bool), OnLongPress() }
---@return table          binder with :SetDisabled(bool), :Disconnect()
function Gui.Clickable(frame, handlers)
    Gui.EnsureInput()
    local binder = setmetatable({ Frame = frame, Handlers = handlers, Disabled = false, Hovered = false }, Gui.Binder)
    frame.Active = true
    binder.Connections = {
        frame.InputBegan:Connect(function(input)
            Gui.OnBegin(binder, input)
        end),
        frame.MouseEnter:Connect(function()
            Gui.OnHoverChange(binder, true)
        end),
        frame.MouseLeave:Connect(function()
            Gui.OnHoverChange(binder, false)
        end),
    }
    return binder
end

---@return number  px width of a text spec in one line
function Gui.TextWidth(spec, size, fontKind)
    return Layout.Measure(Lang.Resolve(spec), Fonts.Size(fontKind, size), fontKind, 100000).X
end

function Gui.Hitbox(name)
    return Draw.New("TextButton", { Name = name, Text = "", AutoButtonColor = false, BackgroundTransparency = 1 })
end

---@return Frame face, Frame? shade
function Gui.BuildBlock(holder, style, depth, radius)
    local tokens = Config.Button.Styles[style] or Config.Button.Styles.Default
    if not tokens.Face then
        local face = Draw.Box("Frame", { Name = "Face", Size = UDim2.fromScale(1, 1), ClipsDescendants = true, Parent = holder }, nil, nil, radius)
        return face, nil
    end
    local shade = Draw.Box("Frame", {
        Name = "Shade",
        Position = UDim2.fromOffset(0, depth),
        Size = UDim2.new(1, 0, 1, -depth),
        Parent = holder,
    }, tokens.Shade, "Outline", radius, 2)
    local face = Draw.Box("Frame", { Name = "Face", Size = UDim2.new(1, 0, 1, -depth), ClipsDescendants = true, Parent = holder }, tokens.Face, "Outline", radius, 2)
    return face, shade
end

function Gui.BuildContent(face, spec, icon, token)
    local content = Draw.New("Frame", { Name = "Content", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = face })
    Draw.List(content, Config.Button.IconGap, true, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    if icon then
        local sprite = Sprite.New(content, icon, Platform.Metric("Icon"))
        sprite.LayoutOrder = 1
    end
    local label = Draw.Text({
        Name = "Label",
        LayoutOrder = 2,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromScale(0, 1),
        TextXAlignment = Enum.TextXAlignment.Center,
    }, "Body", Util.TextSize("Button"), token, spec)
    label.Parent = content
    return label
end

Gui.ButtonHandle = {}
Gui.ButtonHandle.__index = Gui.ButtonHandle

function Gui.ButtonHandle:Set(spec)
    self.Spec = spec
    Lang.Bind(self.Label, spec)
    self.Container:MarkDirty()
end

function Gui.ButtonHandle:SetDisabled(disabled)
    self.Binder:SetDisabled(disabled)
    local alpha = disabled and 0.45 or 0
    self.Label.TextTransparency = alpha
    self.Face.BackgroundTransparency = self.Shade and alpha or 1
    if self.Shade then
        self.Shade.BackgroundTransparency = alpha
    end
end

function Gui.ButtonHandle:SetStyle(style)
    local tokens = Config.Button.Styles[style] or Config.Button.Styles.Default
    self.Style = style
    if self.Shade and tokens.Face then
        Theme.Bind(self.Face, { BackgroundColor3 = tokens.Face })
        Theme.Bind(self.Shade, { BackgroundColor3 = tokens.Shade })
    end
    Theme.Bind(self.Label, { TextColor3 = tokens.Text })
end

function Gui.ButtonHandle:Destroy()
    self.Binder:Disconnect()
    self.Container:Remove(self.Item)
end

function Gui.ButtonHandle:OnHover(hovered)
    local tokens = Config.Button.Styles[self.Style] or Config.Button.Styles.Default
    if not tokens.Face then
        Theme.Bind(self.Face, { BackgroundColor3 = "Hover" })
        Motion.Spring(self.Face, "BackgroundTransparency", hovered and 0 or 1, "Fast")
        return
    end
    local base = Theme.Color(tokens.Face)
    Motion.Spring(self.Face, "BackgroundColor3", hovered and Util.Lighten(base, Config.Button.Hover) or base, "Fast")
end

function Gui.ButtonHandle:OnPress(pressed)
    if not self.Shade then
        return
    end
    Motion.Spring(self.Face, "Position", UDim2.fromOffset(0, pressed and self.Depth - 1 or 0), "Fast")
end

---@param options table  { Text, Icon, Style, Width, Height, Callback, Id }
---@return table         handle { Frame, Item, Face, Label, Set, SetDisabled, SetStyle, Destroy }
function Gui.Button(container, options)
    local existing = Gui.Lookup(container, options.Id)
    if existing then
        return existing
    end
    local style = options.Style or "Default"
    local tokens = Config.Button.Styles[style] or Config.Button.Styles.Default
    local depth = tokens.Face and Platform.Metric("Depth") or 0
    local holder = Gui.Hitbox("Button")
    local face, shade = Gui.BuildBlock(holder, style, depth, Platform.Metric("Radius"))
    local handle = setmetatable({ Frame = holder, Face = face, Shade = shade, Depth = depth, Style = style, Spec = options.Text, Container = container }, Gui.ButtonHandle)
    handle.Label = Gui.BuildContent(face, options.Text, options.Icon, tokens.Text)
    local iconWidth = options.Icon and Platform.Metric("Icon") + Config.Button.IconGap or 0
    handle.Item = container:Add(holder, {
        Width = options.Width,
        Height = options.Height or Platform.Metric("Box") + depth,
        AutoWidth = function()
            return Gui.TextWidth(handle.Spec, Util.TextSize("Button"), "Body") + iconWidth + Config.Button.PadX * 2
        end,
    })
    handle.Binder = Gui.Clickable(holder, {
        OnHover = function(hovered)
            handle:OnHover(hovered)
        end,
        OnPress = function(pressed)
            handle:OnPress(pressed)
        end,
        OnClick = function(input)
            Motion.Ripple(face, input.Position)
            Util.Try(options.Callback, handle)
        end,
    })
    Gui.Remember(container, options.Id, handle)
    return handle
end

Gui.SelectableHandle = {}
Gui.SelectableHandle.__index = Gui.SelectableHandle

function Gui.SelectableHandle:SetSelected(selected)
    self.Selected = selected == true
    local frame = self.Frame
    Theme.Bind(frame, { BackgroundColor3 = selected and "TabActive" or "Hover" })
    Theme.Bind(self.Label, { TextColor3 = selected and "TabActiveText" or self.Token })
    Motion.Spring(frame, "BackgroundTransparency", selected and 0 or 1, "Fast")
    Motion.Spring(self.Bar, "Size", UDim2.new(0, Config.Selectable.Bar, selected and 0.6 or 0, 0), "Normal")
end

function Gui.SelectableHandle:Set(spec)
    self.Spec = spec
    Lang.Bind(self.Label, spec)
    self.Container:MarkDirty()
end

function Gui.SelectableHandle:Destroy()
    self.Binder:Disconnect()
    self.Container:Remove(self.Item)
end

function Gui.SelectableHandle:OnHover(hovered)
    if self.Selected then
        return
    end
    Motion.Spring(self.Frame, "BackgroundTransparency", hovered and Config.Selectable.HoverAlpha or 1, "Fast")
end

---@param options table  { Text, Icon, Selected, Width, Height, Callback(handle), Token, Id }
---@return table         handle { Frame, Item, Label, Set, SetSelected, Destroy }
function Gui.Selectable(container, options)
    local existing = Gui.Lookup(container, options.Id)
    if existing then
        return existing
    end
    local settings = Config.Selectable
    local frame = Draw.Box("TextButton", { Name = "Selectable", BackgroundTransparency = 1, ClipsDescendants = true }, "Hover", nil, Platform.Metric("Radius"))
    local handle = setmetatable({ Frame = frame, Spec = options.Text, Token = options.Token or "Text", Container = container }, Gui.SelectableHandle)
    handle.Bar = Draw.New("Frame", { Name = "Bar", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, settings.Bar, 0, 0), Parent = frame })
    Theme.Bind(handle.Bar, { BackgroundColor3 = "Accent" })
    local textX = settings.PadX
    if options.Icon then
        local iconSize = Platform.Metric("Icon")
        local sprite = Sprite.New(frame, options.Icon, iconSize)
        sprite.AnchorPoint = Vector2.new(0, 0.5)
        sprite.Position = UDim2.new(0, settings.PadX, 0.5, 0)
        textX += iconSize + Config.Button.IconGap
    end
    handle.Label = Draw.Text({ Name = "Label", Position = UDim2.fromOffset(textX, 0), Size = UDim2.new(1, -textX - settings.PadX, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd }, "Body", Util.TextSize("Label"), handle.Token, options.Text)
    handle.Label.Parent = frame
    handle.Item = container:Add(frame, {
        Width = options.Width,
        Height = options.Height or Platform.Metric("Item"),
        AutoWidth = function()
            return Gui.TextWidth(handle.Spec, Util.TextSize("Label"), "Body") + textX + settings.PadX
        end,
    })
    handle.Binder = Gui.Clickable(frame, {
        OnHover = function(hovered)
            handle:OnHover(hovered)
        end,
        OnClick = function(input)
            Motion.Ripple(frame, input.Position)
            Util.Try(options.Callback, handle)
        end,
    })
    handle:SetSelected(options.Selected)
    Gui.Remember(container, options.Id, handle)
    return handle
end

Gui.TextHandle = {}
Gui.TextHandle.__index = Gui.TextHandle

function Gui.TextHandle:Set(spec)
    Lang.Bind(self.Label, spec)
    self.Container:MarkDirty()
end

function Gui.TextHandle:Destroy()
    self.Container:Remove(self.Item)
end

---@param options table?  { Kind = "Body"|"Desc"|"Strong"|"Display", Wrap, Token, Size, Align, Id }
---@return table          handle { Frame, Label, Item, Set, Destroy }
function Gui.Text(container, spec, options)
    options = options or {}
    local existing = Gui.Lookup(container, options.Id)
    if existing then
        return existing
    end
    local kind = options.Kind or "Body"
    local size = options.Size or Util.TextSize(Gui.TextKinds[kind] or "Label")
    local wrap = options.Wrap ~= false
    local label = Draw.Text({
        Name = "Text",
        TextWrapped = wrap,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextXAlignment = options.Align or Enum.TextXAlignment.Left,
        TextTruncate = wrap and Enum.TextTruncate.None or Enum.TextTruncate.AtEnd,
    }, kind, size, options.Token or (kind == "Desc" and "SubText" or "Text"), spec)
    local handle = setmetatable({ Frame = label, Label = label, Container = container }, Gui.TextHandle)
    handle.Item = container:Add(label, {
        Height = function(width)
            return Layout.Measure(label.Text, label.TextSize, kind, wrap and width or 100000).Y
        end,
        AutoWidth = function()
            return Layout.Measure(label.Text, label.TextSize, kind, 100000).X
        end,
    })
    Gui.Remember(container, options.Id, handle)
    return handle
end

---@param spec any?  optional centered caption between the lines
function Gui.Separator(container, spec)
    local holder = Draw.New("Frame", { Name = "Separator", BackgroundTransparency = 1 })
    local left = Draw.New("Frame", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1), Parent = holder })
    Theme.Bind(left, { BackgroundColor3 = "Track" })
    local handle = { Frame = holder }
    if spec == nil then
        handle.Item = container:Add(holder, { Height = Config.Gap.Y * 2 + 1 })
        return handle
    end
    local right = left:Clone()
    right.AnchorPoint, right.Position, right.Parent = Vector2.new(1, 0.5), UDim2.fromScale(1, 0.5), holder
    Theme.Bind(right, { BackgroundColor3 = "Track" })
    local size = Util.TextSize("Section")
    local caption = Draw.Text({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, TextXAlignment = Enum.TextXAlignment.Center }, "Strong", size, "Muted", spec)
    caption.Parent = holder
    handle.Label = caption
    handle.Item = container:Add(holder, {
        Height = size + Config.Gap.Y * 2,
        OnLayout = function(width)
            local half = math.max(0, (width - Gui.TextWidth(spec, size, "Strong")) / 2 - Config.Gap.X)
            left.Size, right.Size = UDim2.new(0, half, 0, 1), UDim2.new(0, half, 0, 1)
        end,
    })
    return handle
end

function Gui.Icon(container, name, size)
    size = size or Platform.Metric("Icon")
    local holder = Draw.New("Frame", { Name = "Icon", BackgroundTransparency = 1 })
    local sprite = Sprite.New(holder, name, size)
    return { Frame = holder, Sprite = sprite, Item = container:Add(holder, { Width = size, Height = size }) }
end

---@author xDTaraZ  Mario Hub UI V2
Config.Widget = {
    HoverPad = 6,
    HoverAlpha = 0.5,
    TextGap = 2,
    RowPadY = 8,
    RightGap = 8,
    LineExtra = 6,
    Badge = { Height = 16, PadX = 6, Gap = 6, Size = 11 },
    Veil = 0.35,
    Knob = { Inset = 3, Damping = 0.62, Squash = 90, SquashDamping = 0.42, Shade = 2 },
    Check = { Stroke = 0.15, MinStroke = 3, Strokes = { { Vector2.new(0.26, 0.52), Vector2.new(0.43, 0.69) }, { Vector2.new(0.43, 0.69), Vector2.new(0.75, 0.33) } } },
    Slider = { Reset = 20, Notch = 2, NotchHeight = 5, Grab = 1.22, Slop = 8 },
    List = { Pad = 4, Gap = 2, Rows = 7, Mark = 18 },
    Key = { Min = 36, Pad = 16, Dot = 6, Menu = 300 },
    Alpha = 14,
    Presets = { "Accent", "Warn", "Coin", "Good", "Info", "Brick", "Text", "White" },
    Progress = 14,
    Shine = 0.6,
    Child = { Pad = 8, Radius = 10, Fill = 0.4 },
    MultiPreview = 3,
    DefaultIcons = { Keybind = "keybind", ColorPicker = "palette", ConfirmButton = "warn" },
    ModeTokens = { Toggle = "Good", Hold = "Info", Always = "Coin" },
    Modes = { "Toggle", "Hold", "Always" },
    BadgeTokens = { Risky = "Bad", NEW = "Good", New = "Good", Beta = "Info", Hot = "Warn", Pro = "Coin" },
    KeyShort = {
        LeftControl = "LCtrl", RightControl = "RCtrl", LeftShift = "LShift", RightShift = "RShift",
        LeftAlt = "LAlt", RightAlt = "RAlt", Backquote = "`", Return = "Enter", Escape = "Esc",
        CapsLock = "Caps", PageUp = "PgUp", PageDown = "PgDn", Insert = "Ins", None = "—",
        MouseButton1 = "MB1", MouseButton2 = "MB2", MouseButton3 = "MB3",
    },
}

Lang.Strings.All = { EN = "All", TH = "ทั้งหมด" }
Lang.Strings.Invert = { EN = "Invert", TH = "สลับ" }
Lang.Strings.Reset = { EN = "Reset to default", TH = "คืนค่าเริ่มต้น" }
Lang.Strings.Risky = { EN = "Risky", TH = "เสี่ยง" }
Lang.Strings.Locked = { EN = "Working...", TH = "กำลังทำงาน..." }
Lang.Strings.ModeToggle = { EN = "Toggle", TH = "กดสลับ" }
Lang.Strings.ModeHold = { EN = "Hold", TH = "กดค้าง" }
Lang.Strings.ModeAlways = { EN = "Always", TH = "ตลอดเวลา" }
Lang.Strings.KeyMode = { EN = "Key mode", TH = "โหมดปุ่ม" }
Lang.Strings.Keybind = { EN = "Keybind", TH = "ปุ่มลัด" }
Lang.Strings.SetKey = { EN = "Change key", TH = "เปลี่ยนปุ่ม" }
Lang.Strings.ClearKey = { EN = "Remove key", TH = "ลบปุ่ม" }
Lang.Strings.ModeToggleHint = { EN = "Toggle · press to turn on / off", TH = "กดสลับ · กดเพื่อเปิด / ปิด" }
Lang.Strings.ModeHoldHint = { EN = "Hold · on while the key is held", TH = "กดค้าง · ทำงานตอนกดค้างไว้" }
Lang.Strings.ModeAlwaysHint = { EN = "Always · always on", TH = "ตลอดเวลา · เปิดตลอด" }
Lang.Strings.DuplicateKey = { EN = "Key already in use", TH = "ปุ่มนี้ถูกใช้แล้ว" }
Lang.Strings.DuplicateKeyText = { EN = "%s is also bound to %s", TH = "%s ผูกกับ %s อยู่แล้ว" }
Lang.Strings.MaxPicked = { EN = "Up to %d selections", TH = "เลือกได้สูงสุด %d รายการ" }
Lang.Strings.PickColor = { EN = "Pick a color", TH = "เลือกสี" }
Lang.Strings.Selected = { EN = "%d selected", TH = "เลือก %d รายการ" }
Lang.Strings.TapConfirm = { EN = "Tap again to confirm", TH = "แตะอีกครั้งเพื่อยืนยัน" }

Widget.Waiting = {}
Widget.Drag = {}
Widget.NoBinders = {}
Widget.PopOnShow = true

function Widget.Normalize(idx, info)
    if type(idx) == "table" and info == nil then
        info = idx
        idx = info.Idx or info.Flag
    end
    return idx, Widget.Aliases(info or {})
end

---Folds V1 spellings into one key each: Func -> Callback, Save = false -> NoSave, Title/Label -> Text, Content -> Description.
function Widget.Aliases(info)
    info.Callback = info.Callback or info.Func
    info.NoSave = info.NoSave == true or info.Save == false
    info.Text = info.Text or info.Title or info.Label
    info.Description = info.Description or info.Content
    return info
end

---@param option table  widget object with Row/Frame, Item, Container already set
function Widget.Register(option, idx, info)
    Widget.Aliases(info)
    option.Idx = idx
    option.Info = info
    option.Callback = option.Callback or info.Callback
    option.Changed = option.Changed or {}
    option.NoSave = option.NoSave == true or info.NoSave or idx == nil
    if idx ~= nil then
        Library.Options[idx] = option
    end
    local owner = option.Item.Widget
    local ownsRow = owner == nil or owner == false or owner == option
    if ownsRow then
        option.Item.Widget, option.Item.Label = option, info.Text or option.Item.Label
    end
    local anchor = option.Row and option.Row.Holder or option.Frame
    if info.Tooltip and anchor and Tooltip.Attach then
        Tooltip.Attach(anchor, info.Tooltip)
    end
    if info.Disabled then
        option:SetDisabled(true, info.Disabled ~= true and info.Disabled or nil)
    end
    if info.Visible == false then
        option:SetVisible(false)
    end
    if info.DependsOn then
        Widget.Depend(option, info.DependsOn)
    end
    if not option.NoSave and option.DefaultValue == nil and type(option.Serialize) == "function" then
        local ok, value = pcall(option.Serialize, option)
        option.DefaultValue = ok and value or nil
    end
    Widget.Resolve(idx)
end

---@param dep table  { idx, value? } or { Idx, Value }; value nil = master truthy, table = any of
function Widget.Matches(value, dep)
    local expected = dep[2]
    if expected == nil then
        expected = dep.Value
    end
    if expected == nil then
        return type(value) == "table" and next(value) ~= nil or (type(value) ~= "table" and value ~= nil and value ~= false)
    end
    if type(expected) ~= "table" then
        return value == expected or (type(value) == "table" and value[expected] == true)
    end
    for _, wanted in ipairs(expected) do
        if value == wanted or (type(value) == "table" and value[wanted] == true) then
            return true
        end
    end
    return false
end

---@param target table  anything with :SetVisible(bool)
function Widget.Depend(target, dep)
    local masterIdx = dep[1] or dep.Idx
    local master = Library.Options[masterIdx]
    if not master then
        table.insert(Widget.Waiting, { Target = target, Dep = dep, Idx = masterIdx })
        return
    end
    local function Sync()
        target:SetVisible(Widget.Matches(master.Value, dep))
    end
    master:OnChanged(Sync)
    target.InstantShow = true
    Sync()
    target.InstantShow = nil
end

function Widget.Resolve(idx)
    if idx == nil then
        return
    end
    local waiting = Widget.Waiting
    for index = #waiting, 1, -1 do
        local entry = waiting[index]
        if entry.Idx == idx then
            table.remove(waiting, index)
            Widget.Depend(entry.Target, entry.Dep)
        end
    end
end

---@return any  stable compare/save key: a T() table collapses to its English text
function Widget.Key(value)
    if type(value) == "table" then
        return value.EN or value.TH or value[1]
    end
    return value
end

---@param values table  array of values or text specs
---@return number?      index of the entry equal to value by key
function Widget.IndexOf(values, value)
    if value == nil then
        return nil
    end
    local key = Widget.Key(value)
    for index, entry in ipairs(values) do
        if entry == value or Widget.Key(entry) == key then
            return index
        end
    end
    return nil
end

---@return any  the entry of values matching value by key (the caller's own table), nil when absent
function Widget.Canonical(values, value)
    local index = Widget.IndexOf(values, value)
    return index and values[index] or nil
end

---@param picks any     array of values/keys, or a set { [value] = true }, or one T() spec
---@param max number?   cap on selections, earlier Values win
---@return table        set keyed by entries of values
function Widget.SelectSet(values, picks, max)
    local set = {}
    if type(picks) ~= "table" then
        return set
    end
    if type(picks.EN) == "string" or type(picks.TH) == "string" then
        picks = { picks }
    end
    local wanted = {}
    for key, entry in pairs(picks) do
        if type(key) == "number" then
            wanted[Widget.Key(entry)] = true
        elseif entry then
            wanted[Widget.Key(key)] = true
        end
    end
    local count = 0
    for _, entry in ipairs(values) do
        if max and count >= max then
            break
        end
        if wanted[Widget.Key(entry)] then
            set[entry] = true
            count += 1
        end
    end
    return set
end

---@return table  array of save keys for every selected entry of a set
function Widget.KeysOf(set)
    local keys = {}
    for entry, on in pairs(set) do
        if on then
            keys[#keys + 1] = Widget.Key(entry)
        end
    end
    return keys
end

function Widget.SameSet(left, right)
    local keys, count = {}, 0
    for entry in pairs(left) do
        keys[Widget.Key(entry)] = true
        count += 1
    end
    for entry in pairs(right) do
        if not keys[Widget.Key(entry)] then
            return false
        end
        count -= 1
    end
    return count == 0
end

function Widget.SameOrder(left, right)
    if #left ~= #right then
        return false
    end
    for index, entry in ipairs(left) do
        if Widget.Key(entry) ~= Widget.Key(right[index]) then
            return false
        end
    end
    return true
end

function Widget:OnChanged(callback)
    table.insert(self.Changed, callback)
    return self
end

---Table values (RangeSlider, PriorityList) go out as a copy so a callback cannot corrupt widget state.
function Widget:Fire()
    local value = self.Value
    if self.CloneOnFire and type(value) == "table" then
        value = table.clone(value)
    end
    Util.Try(self.Callback, value)
    for _, callback in ipairs(self.Changed) do
        Util.Try(callback, value)
    end
end

function Widget:Serialize()
    return self.Value
end

function Widget:Deserialize(saved)
    self:SetValue(saved)
end

function Widget:SetVisible(visible)
    visible = visible ~= false
    self.Visible = visible
    local item = self.Item
    if item.Hidden == not visible then
        return
    end
    item.Hidden = not visible
    self.Container:MarkDirty()
    if visible and not self.InstantShow and Widget.PopOnShow then
        Motion.Pop(item.Frame)
    end
end

function Widget:AddBinder(binder)
    self.Binders = self.Binders or {}
    table.insert(self.Binders, binder)
    if self.Disabled or self.Locked then
        binder:SetDisabled(true)
    end
    return binder
end

---@param reason any?  text spec shown under the title while disabled
function Widget:SetDisabled(disabled, reason)
    self.Disabled = disabled == true
    self.Reason = self.Disabled and reason or nil
    self:ApplyBlocked()
    return self
end

---Blocks input while a long action runs; independent of SetDisabled.
function Widget:Lock(locked)
    self.Locked = locked ~= false
    self:ApplyBlocked()
    return self
end

function Widget:ApplyBlocked()
    local blocked = self.Disabled == true or self.Locked == true
    for _, binder in ipairs(self.Binders or Widget.NoBinders) do
        binder:SetDisabled(blocked)
    end
    local reason = self.Reason or (self.Locked and Lang.Strings.Locked or nil)
    if self.Row then
        self.Row:SetBlocked(blocked, blocked and reason or nil)
    end
end

function Widget:IsBlocked()
    return self.Disabled == true or self.Locked == true
end

function Widget:Flash()
    if self.Row then
        self.Row:Flash()
    elseif self.Frame then
        Motion.Pop(self.Frame)
    end
    return self
end

function Widget:SetBadge(spec)
    if self.Row then
        self.Row:SetBadge(spec)
    end
    return self
end

function Widget:SetText(spec)
    if self.Row then
        self.Row:SetTitle(spec)
    end
    return self
end

function Widget:SetDescription(spec)
    if self.Row then
        self.Row:SetDescription(spec)
    end
    return self
end

function Widget:AddKeyPicker(idx, info)
    KeyPicker.New(self.Row, idx, info or {}, self.Type == "Toggle" and self or nil)
    return self
end

function Widget:AddColorPicker(idx, info)
    ColorPicker.New(self.Row, idx, info or {})
    return self
end

---@param kind string  key of Config.Widget.DefaultIcons
---@return table        info with Icon filled unless set (false opts out)
function Widget.DefaultIcon(info, kind)
    if info.Icon == nil then
        info.Icon = Config.Widget.DefaultIcons[kind]
    end
    return info
end

Widget.Paints = {}

---Theme-aware color that may animate between tokens; the map lives until the instance is destroyed.
function Widget.Paint(_, inst, prop, token, animate)
    local map = Widget.Paints[inst]
    if not map then
        map = {}
        Widget.Paints[inst] = map
        inst.Destroying:Once(function()
            Widget.Paints[inst] = nil
        end)
        Theme.OnRender(inst, function()
            for property, name in pairs(map) do
                Motion.Set(inst, property, Theme.Color(name))
            end
        end)
    end
    map[prop] = token
    if animate then
        Motion.Spring(inst, prop, Theme.Color(token), "Normal")
    else
        Motion.Set(inst, prop, Theme.Color(token))
    end
end

---Closes whichever picker surface is open (popup on desktop, sheet on phone).
function Widget.ClosePopup()
    if Popup.CloseTop then
        Popup.CloseTop()
    elseif Popup.Close then
        Popup.Close()
    end
end

function Widget.MoveAfter(container, item, after)
    local index = table.find(container.Items, item)
    if index then
        table.remove(container.Items, index)
    end
    container:Insert(item, after)
    container:MarkDirty()
end

function Widget.EnsureDrag()
    if Widget.DragBound then
        return
    end
    Widget.DragBound = true
    Util.Connect(UserInputService.InputChanged, Widget.OnDragMove)
    Util.Connect(UserInputService.InputEnded, Widget.OnDragEnd)
end

---@param owner table   receives owner:OnDrag(position) and owner:OnDragEnd()
---@param frame Instance?  touch drags freeze the nearest ScrollingFrame so the page stays put
function Widget.BeginDrag(input, owner, frame)
    Widget.EnsureDrag()
    local drag = Widget.Drag
    if drag.Owner then
        Widget.EndDrag()
    end
    drag.Owner, drag.Input, drag.Type = owner, input, input.UserInputType
    if input.UserInputType ~= Enum.UserInputType.Touch or not frame then
        return
    end
    local scroller = frame:FindFirstAncestorWhichIsA("ScrollingFrame")
    if scroller and scroller.ScrollingEnabled then
        drag.Scroller = scroller
        scroller.ScrollingEnabled = false
    end
end

function Widget.OnDragMove(input)
    local drag = Widget.Drag
    if not drag.Owner then
        return
    end
    local touch = drag.Type == Enum.UserInputType.Touch
    if input ~= drag.Input and (touch or input.UserInputType ~= Enum.UserInputType.MouseMovement) then
        return
    end
    Util.Try(drag.Owner.OnDrag, drag.Owner, input.Position)
end

function Widget.OnDragEnd(input)
    local drag = Widget.Drag
    if not drag.Owner or (input ~= drag.Input and input.UserInputType ~= drag.Type) then
        return
    end
    Widget.EndDrag()
end

function Widget.EndDrag()
    local drag = Widget.Drag
    local owner = drag.Owner
    drag.Owner, drag.Input = nil, nil
    if drag.Scroller then
        drag.Scroller.ScrollingEnabled = true
        drag.Scroller = nil
    end
    if owner and owner.OnDragEnd then
        Util.Try(owner.OnDragEnd, owner)
    end
end

---@return TextBox, Frame field  recessed text field used by Input, search and hex boxes
function Widget.Field(parent, placeholder)
    local field = Draw.Box("Frame", { Name = "Field", Size = UDim2.fromScale(1, 1), Parent = parent }, "Element", nil, Platform.Metric("Radius"))
    local stroke = Draw.Stroke(field, "Outline", 2, true)
    local lip = Draw.Box("Frame", { Name = "Lip", Size = UDim2.new(1, 0, 0, 3), BackgroundTransparency = 0.82, Parent = field }, "Shadow", nil, Platform.Metric("Radius"))
    lip.ZIndex = Config.Z.Back
    local box = Draw.Text({
        ClassName = "TextBox",
        Name = "Box",
        ClearTextOnFocus = false,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -20, 1, 0),
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = Config.Z.Text,
        Parent = field,
    }, "Body", Util.TextSize("Label"), "Text")
    Lang.Bind(box, placeholder or "", "PlaceholderText")
    Theme.Bind(box, { PlaceholderColor3 = "Muted" })
    local focus = {}
    box.Focused:Connect(function()
        Widget.Paint(focus, stroke, "Color", "Accent", true)
    end)
    box.FocusLost:Connect(function()
        Widget.Paint(focus, stroke, "Color", "Outline", true)
    end)
    return box, field
end

---@return number  px of one line of Body text at the label size
function Row.LineHeight(kind)
    return Fonts.Size("Body", Util.TextSize(kind or "Label")) + Config.Widget.LineExtra
end

function Row.SearchText(info)
    return Lang.SearchText(info.Text) .. " " .. Lang.SearchText(info.Description)
end

---@param options table?  { Control = px (stacked: title line + full-width control), Font, Size, Token, MinHeight }
---Set row.MeasureControl = fn(width) -> px for a control whose height depends on width.
---@return table          row { Holder, Item, Title, Desc?, Right items, Control?, Aside? }
function Row.New(container, info, options)
    options = options or {}
    local settings = Config.Widget
    local holder = Draw.New("Frame", { Name = "Row", BackgroundTransparency = 1 })
    local row = setmetatable({
        Holder = holder, Container = container, Info = info, Rights = {}, RightWidth = 0, AsideWidth = 0,
        Font = options.Font or "Body", ControlHeight = options.Control, MinHeight = options.MinHeight,
    }, Row)
    row.Hover = Draw.Box("Frame", {
        Name = "Hover",
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(-settings.HoverPad, 0),
        Size = UDim2.new(1, settings.HoverPad * 2, 1, 0),
        Parent = holder,
    }, "Hover", nil, Platform.Metric("Radius"))
    local token = options.Token or (info.Risky and "Bad" or "Text")
    row.Title = Draw.Text({ Name = "Title", TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = Config.Z.Text, Parent = holder }, row.Font, options.Size or Util.TextSize("Label"), token, info.Text or "")
    if info.Description then
        row:SetDescription(info.Description)
    end
    if info.Icon then
        row:SetIcon(info.Icon)
    end
    local badge = info.Badge or (info.Risky and Lang.Strings.Risky or nil)
    if badge then
        row:SetBadge(badge)
    end
    if row.ControlHeight then
        row.Aside = Draw.New("Frame", { Name = "Aside", BackgroundTransparency = 1, ZIndex = Config.Z.Body, Parent = holder })
        row.Control = Draw.New("Frame", { Name = "Control", BackgroundTransparency = 1, ZIndex = Config.Z.Body, Parent = holder })
    end
    row.Item = container:Add(holder, {
        Height = function(width)
            return row:Measure(width)
        end,
        OnLayout = function(width, height)
            row:Arrange(width, height)
        end,
        Search = Row.SearchText(info),
        Label = info.Text,
    })
    return row
end

function Row:SetTitle(spec)
    Lang.Bind(self.Title, spec)
    self.Item.Search = Lang.SearchText(spec) .. " " .. Lang.SearchText(self.Info.Description)
    self.Item.Label = spec
    self.Container:MarkDirty()
end

function Row:SetDescription(spec)
    if not self.Desc then
        self.Desc = Draw.Text({ Name = "Desc", TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = Config.Z.Text, Parent = self.Holder }, "Desc", Util.TextSize("Desc"), "SubText")
    end
    Lang.Bind(self.Desc, spec or "")
    self.Container:MarkDirty()
end

---@param token string?  theme token for the note text (default Warn)
function Row:SetNote(spec, token)
    if spec == nil then
        if self.Note then
            self.Note.Visible = false
            self.Container:MarkDirty()
        end
        return
    end
    if not self.Note then
        self.Note = Draw.Text({ Name = "Note", TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = Config.Z.Note, Parent = self.Holder }, "Desc", Util.TextSize("Desc"), "Warn")
    end
    Theme.Bind(self.Note, { TextColor3 = token or "Warn" })
    Lang.Bind(self.Note, spec)
    self.Note.Visible = true
    self.Container:MarkDirty()
end

function Row:SetIcon(name)
    if self.IconSprite then
        self.IconSprite:Destroy()
    end
    self.IconSprite = Sprite.New(self.Holder, name, Platform.Metric("Icon"))
    self.IconSprite.ZIndex = Config.Z.Text
    self.Container:MarkDirty()
end

function Row:SetBadge(spec)
    if spec == nil then
        if self.Badge then
            self.Badge:Destroy()
            self.Badge = nil
            self.Container:MarkDirty()
        end
        return
    end
    local settings = Config.Widget.Badge
    if not self.Badge then
        self.Badge = Draw.Box("Frame", { Name = "Badge", ZIndex = Config.Z.Text, Parent = self.Holder }, "Accent", "Outline", UDim.new(1, 0), 1)
        self.BadgeLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = Config.Z.Body, Parent = self.Badge }, "Strong", settings.Size, "White")
    end
    local key = type(spec) == "table" and spec.EN or spec
    local token = Config.Widget.BadgeTokens[key] or "Warn"
    Theme.Bind(self.Badge, { BackgroundColor3 = token })
    Theme.Bind(self.BadgeLabel, { TextColor3 = token == "Coin" and "Ink" or "White" })
    Lang.Bind(self.BadgeLabel, spec, "Text", string.upper)
    self.Container:MarkDirty()
end

---@param width number  reserved px at the right edge of the row
function Row:AddRight(frame, width)
    table.insert(self.Rights, { Frame = frame, Width = width })
    frame.AnchorPoint = Vector2.new(0, 0.5)
    frame.ZIndex = math.max(frame.ZIndex, Config.Z.Detail)
    frame.Parent = self.Holder
    self:RecalcRight()
end

function Row:SetRightWidth(frame, width)
    for _, right in ipairs(self.Rights) do
        if right.Frame == frame and right.Width ~= width then
            right.Width = width
            self:RecalcRight()
        end
    end
end

function Row:RecalcRight()
    local total = 0
    for index, right in ipairs(self.Rights) do
        total += right.Width + (index > 1 and Config.Widget.RightGap or 0)
    end
    self.RightWidth = total
    self.Container:MarkDirty()
end

function Row:SetAsideWidth(width)
    if self.AsideWidth == width then
        return
    end
    self.AsideWidth = width
    self.Container:MarkDirty()
end

---@return number left, number textWidth
function Row:TextColumn(width)
    local settings = Config.Widget
    local left = self.IconSprite and Platform.Metric("Icon") + settings.Badge.Gap or 0
    local right = 0
    if not self.ControlHeight and self.RightWidth > 0 then
        right = self.RightWidth + settings.RightGap
    end
    return left, math.max(20, width - left - right)
end

function Row:LabelHeight(label, width)
    if not label or not label.Visible or label.Text == "" then
        return 0
    end
    return Layout.Measure(label.Text, label.TextSize, "Desc", width).Y
end

function Row:Measure(width)
    local settings = Config.Widget
    if self.MeasureControl then
        self.ControlHeight = self.MeasureControl(width)
    end
    local left, textWidth = self:TextColumn(width)
    local titleWidth = textWidth
    if self.Badge then
        self.BadgeWidth = Layout.Measure(self.BadgeLabel.Text, self.BadgeLabel.TextSize, "Strong", 1000).X + settings.Badge.PadX * 2
        titleWidth -= self.BadgeWidth + settings.Badge.Gap
    end
    if self.ControlHeight and self.AsideWidth > 0 then
        titleWidth -= self.AsideWidth + settings.RightGap
    end
    titleWidth = math.max(20, titleWidth)
    local title = self.Title
    self.TitleHeight = title.Text == "" and 0 or Layout.Measure(title.Text, title.TextSize, self.Font, titleWidth).Y
    if self.ControlHeight and (self.AsideWidth > 0 or self.Badge) then
        self.TitleHeight = math.max(self.TitleHeight, Row.LineHeight())
    end
    self.TitleWidth, self.TextLeft, self.TextWidth = titleWidth, left, textWidth
    self.DescHeight = self:LabelHeight(self.Desc, textWidth)
    self.NoteHeight = self:LabelHeight(self.Note, textWidth)
    local content = self.TitleHeight
    content += self.DescHeight > 0 and self.DescHeight + settings.TextGap or 0
    content += self.NoteHeight > 0 and self.NoteHeight + settings.TextGap or 0
    self.TextHeight = content
    if self.ControlHeight then
        self.ControlTop = content > 0 and content + settings.RowPadY / 2 or 0
        return self.ControlTop + self.ControlHeight + 2
    end
    return math.max(self.MinHeight or Platform.Metric("Row"), content + settings.RowPadY)
end

function Row:Arrange(width, height)
    local settings = Config.Widget
    local top = self.ControlHeight and 0 or math.floor((height - self.TextHeight) / 2)
    local left, gap = self.TextLeft, settings.TextGap
    self.Title.Position = UDim2.fromOffset(left, top)
    self.Title.Size = UDim2.fromOffset(self.TitleWidth, self.TitleHeight)
    local y = top + self.TitleHeight
    if self.Desc then
        self.Desc.Position = UDim2.fromOffset(left, y + gap)
        self.Desc.Size = UDim2.fromOffset(self.TextWidth, self.DescHeight)
        y += self.DescHeight > 0 and self.DescHeight + gap or 0
    end
    if self.Note then
        self.Note.Position = UDim2.fromOffset(left, y + gap)
        self.Note.Size = UDim2.fromOffset(self.TextWidth, self.NoteHeight)
    end
    self:ArrangeDecor(top)
    self:ArrangeRights(width)
    if self.ControlHeight then
        local lineHeight = math.max(self.TitleHeight, Row.LineHeight())
        local asideHeight = Platform.Touch and math.max(lineHeight, Platform.Metric("Hit")) or lineHeight
        self.Aside.Position = UDim2.fromOffset(width - self.AsideWidth, math.floor((lineHeight - asideHeight) / 2))
        self.Aside.Size = UDim2.fromOffset(self.AsideWidth, asideHeight)
        self.Control.Position = UDim2.fromOffset(0, self.ControlTop)
        self.Control.Size = UDim2.fromOffset(width, self.ControlHeight)
    end
    if self.Hit then
        local hitWidth = self.ControlHeight and width or left + self.TextWidth + settings.RightGap
        self.Hit.Size = UDim2.fromOffset(hitWidth + (self.HitExtra or 0), height)
    end
    if self.OnArranged then
        self.OnArranged(width, height)
    end
end

function Row:ArrangeDecor(top)
    local lineHeight = Row.LineHeight()
    if self.IconSprite then
        local size = Platform.Metric("Icon")
        self.IconSprite.Position = UDim2.fromOffset(0, top + math.floor((math.min(lineHeight, math.max(self.TitleHeight, size)) - size) / 2))
    end
    if not self.Badge then
        return
    end
    local settings = Config.Widget.Badge
    local title = self.Title
    local lineWidth = Layout.Measure(title.Text, title.TextSize, self.Font, 100000).X
    local x = self.TextLeft + math.min(lineWidth, self.TitleWidth) + settings.Gap
    self.Badge.Position = UDim2.fromOffset(x, top + math.floor((lineHeight - settings.Height) / 2) - 2)
    self.Badge.Size = UDim2.fromOffset(self.BadgeWidth, settings.Height)
end

function Row:ArrangeRights(width)
    local x = width
    for _, right in ipairs(self.Rights) do
        right.Frame.Position = UDim2.new(0, x - right.Width, 0.5, 0)
        x -= right.Width + Config.Widget.RightGap
    end
end

function Row:SetHover(hovered)
    Motion.Spring(self.Hover, "BackgroundTransparency", hovered and Config.Widget.HoverAlpha or 1, "Fast")
end

---@param onClick fun(input)  full-row tap target (text area; right controls keep their own input)
---@return table              binder
function Row:Bind(onClick)
    local hit = Gui.Hitbox("Hit")
    hit.ZIndex = Config.Z.Body
    hit.Position = UDim2.fromOffset(-Config.Widget.HoverPad, 0)
    hit.Parent = self.Holder
    self.Hit = hit
    self.HitExtra = Config.Widget.HoverPad
    return Gui.Clickable(hit, {
        OnHover = function(hovered)
            self:SetHover(hovered)
        end,
        OnPress = function(pressed)
            if Platform.Touch then
                self:SetHover(pressed)
            end
        end,
        OnClick = onClick,
    })
end

Row.VeilDone = {
    OnDone = function(veil)
        if veil.BackgroundTransparency > 0.95 then
            veil.Visible = false
        end
    end,
}

function Row:SetBlocked(blocked, reason)
    if not self.Veil then
        self.Veil = Draw.Box("TextButton", {
            Name = "Veil",
            BackgroundTransparency = 1,
            Visible = false,
            ZIndex = Config.Z.Top,
            Position = UDim2.fromOffset(-Config.Widget.HoverPad, 0),
            Size = UDim2.new(1, Config.Widget.HoverPad * 2, 1, 0),
            Parent = self.Holder,
        }, "Panel", nil, Platform.Metric("Radius"))
    end
    if blocked then
        self.Veil.Visible = true
    end
    Motion.Spring(self.Veil, "BackgroundTransparency", blocked and Config.Widget.Veil or 1, "Fast", Row.VeilDone)
    self:SetNote(reason)
end

Row.FlashDone = {
    OnDone = function(hover)
        Theme.Bind(hover, { BackgroundColor3 = "Hover" })
    end,
}

function Row:Flash()
    local hover = self.Hover
    Theme.Bind(hover, { BackgroundColor3 = "Glow" })
    Motion.Set(hover, "BackgroundTransparency", 0)
    Motion.Spring(hover, "BackgroundTransparency", 1, "Soft", Row.FlashDone)
    if self.Badge then
        Motion.Pop(self.Badge)
    end
end

Toggle.KnobSpring = { Damping = Config.Widget.Knob.Damping }

function WidgetHost:AddToggle(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local toggle = setmetatable({ Type = "Toggle", Value = info.Default == true, Style = info.Style or "Switch", Container = self }, Toggle)
    toggle.Row = Row.New(self, info)
    toggle.Item = toggle.Row.Item
    local function Click()
        toggle:SetValue(not toggle.Value)
        if toggle.Value then
            toggle:Celebrate()
        end
    end
    toggle:AddBinder(toggle.Row:Bind(Click))
    if toggle.Style == "Checkbox" then
        toggle:BuildCheckbox()
    else
        toggle:BuildSwitch()
    end
    toggle:AddBinder(Gui.Clickable(toggle.Hit, {
        OnHover = function(hovered)
            toggle.Row:SetHover(hovered)
        end,
        OnClick = Click,
    }))
    Widget.Register(toggle, idx, info)
    if idx ~= nil then
        Library.Toggles[idx] = toggle
    end
    toggle:Render(true)
    return toggle
end

function WidgetHost:AddCheckbox(idx, info)
    idx, info = Widget.Normalize(idx, info)
    info.Style = "Checkbox"
    return self:AddToggle(idx, info)
end

function Toggle:BuildSwitch()
    local size, knobSize = Platform.Metric("Switch"), Platform.Metric("SwitchKnob")
    local settings = Config.Widget.Knob
    local track = Draw.Box("TextButton", { Name = "Switch", Size = UDim2.fromOffset(size.X, size.Y), BackgroundTransparency = 0 }, nil, "Outline", UDim.new(1, 0), 2)
    local groove = Draw.Box("Frame", { Name = "Groove", Size = UDim2.new(1, 0, 0.5, 0), BackgroundTransparency = 0.85, Parent = track }, "Shadow", nil, UDim.new(1, 0))
    groove.ZIndex = track.ZIndex
    local knob = Draw.New("Frame", { Name = "Knob", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(knobSize, knobSize), Parent = track })
    local shade = Draw.Box("Frame", { Name = "Shade", Position = UDim2.fromOffset(0, settings.Shade), Size = UDim2.fromScale(1, 1), Parent = knob }, "Shadow", nil, UDim.new(1, 0))
    local face = Draw.Box("Frame", { Name = "Face", Size = UDim2.fromScale(1, 1), Parent = knob }, "Knob", "Outline", UDim.new(1, 0), 2)
    shade.ZIndex, face.ZIndex = Config.Z.Raised, Config.Z.Top
    self.Star = Draw.Text({ Text = "★", Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = Config.Z.Note, Parent = face }, "Glyph", knobSize - 4, "Coin")
    self.Track, self.Knob, self.KnobSize, self.Travel = track, knob, knobSize, size.X - knobSize - settings.Inset
    self.Row:AddRight(track, size.X)
    self:BuildHit(track, size.X, size.Y)
end

function Toggle:BuildCheckbox()
    local size = Platform.Metric("Check")
    local depth = Config.Widget.Knob.Shade
    local holder = Gui.Hitbox("Checkbox")
    holder.Size = UDim2.fromOffset(size, size + depth)
    local face, shade = Gui.BuildBlock(holder, "Default", depth, 6)
    Theme.Unbind(face)
    self.Face, self.Shade = face, shade
    self.Mark = Toggle.BuildCheckMark(face, size)
    self.Track = holder
    self.Row:AddRight(holder, size)
    self:BuildHit(holder, size, size + depth)
end

---Two rounded strokes instead of a font glyph, so the tick stays crisp and centered at any size.
---@return CanvasGroup
---@param token string?  stroke color, White by default
function Toggle.BuildCheckMark(face, size, token)
    local check = Config.Widget.Check
    local mark = Draw.New("CanvasGroup", { Name = "Mark", BackgroundTransparency = 1, GroupTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = face.ZIndex + 1, Parent = face })
    local thickness = math.max(check.MinStroke, math.floor(size * check.Stroke + 0.5))
    for _, stroke in ipairs(check.Strokes) do
        local from, to = stroke[1] * size, stroke[2] * size
        local delta = to - from
        local bar = Draw.New("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset((from.X + to.X) / 2, (from.Y + to.Y) / 2),
            Size = UDim2.fromOffset(delta.Magnitude + thickness, thickness),
            Rotation = math.deg(math.atan2(delta.Y, delta.X)),
            BorderSizePixel = 0,
            ZIndex = face.ZIndex + 1,
            Parent = mark,
        })
        Draw.Corner(bar, UDim.new(1, 0))
        Theme.Bind(bar, { BackgroundColor3 = token or "White" })
    end
    return mark
end

---Pads the tap area to the platform's minimum hit size without growing the visual.
function Toggle:BuildHit(target, width, height)
    local minimum = Platform.Metric("Hit")
    if width >= minimum and height >= minimum then
        self.Hit = target
        return
    end
    self.Hit = Draw.New("TextButton", {
        Name = "Hit",
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(math.max(width, minimum), math.max(height, minimum)),
        ZIndex = Config.Z.Note,
        Parent = target,
    })
end

function Toggle:Render(instant)
    local on = self.Value
    local animate = not instant
    if self.Knob then
        Widget.Paint(self, self.Track, "BackgroundColor3", on and "Good" or "Track", animate)
        local position = UDim2.new(0, on and self.Travel or Config.Widget.Knob.Inset, 0.5, 0)
        if instant then
            Motion.Set(self.Knob, "Position", position)
        else
            Motion.Spring(self.Knob, "Position", position, "Fast", Toggle.KnobSpring)
            self:Squash()
        end
        Motion.Spring(self.Star, "TextTransparency", on and 0 or 1, "Fast")
        return
    end
    Widget.Paint(self, self.Face, "BackgroundColor3", on and "Good" or "Element", animate)
    Widget.Paint(self, self.Shade, "BackgroundColor3", on and "GoodDark" or "Pressed", animate)
    Motion.Spring(self.Mark, "GroupTransparency", on and 0 or 1, "Fast")
    if on and animate then
        Motion.Pop(self.Mark)
    end
end

function Toggle:Squash()
    local settings = Config.Widget.Knob
    local direction = self.Value and 1 or -1
    Motion.Set(self.Knob, "Size", UDim2.fromOffset(self.KnobSize, self.KnobSize))
    Motion.Impulse(self.Knob, "Size", { 0, settings.Squash, 0, -settings.Squash * 0.5 }, "Fast", settings.SquashDamping)
    Motion.Impulse(self.Knob, "Position", { 0, direction * settings.Squash * 0.25, 0, 0 }, "Fast", Config.Widget.Knob.Damping)
end

function Toggle:Celebrate()
    local holder = self.Row.Holder
    local track = self.Track
    local offset = track.AbsolutePosition - holder.AbsolutePosition
    local x = offset.X + (self.Knob and self.Travel + self.KnobSize / 2 or track.AbsoluteSize.X / 2)
    Motion.CoinPop(holder, UDim2.fromOffset(x, offset.Y + 2))
end

---A Feature's Now button follows the toggle: locked while it is blocked, hidden with it.
function Toggle:ApplyBlocked()
    Widget.ApplyBlocked(self)
    if self.Now then
        self.Now:Lock(self:IsBlocked())
    end
end

function Toggle:SetVisible(visible)
    Widget.SetVisible(self, visible)
    if self.Now then
        self.Now:SetVisible(visible)
    end
end

function Toggle:SetValue(value)
    value = value == true
    if value == self.Value then
        return
    end
    self.Value = value
    self:Render(false)
    self:Fire()
end

Slider.GrabSpring = { Damping = 0.55 }

function WidgetHost:AddSlider(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local knob = Platform.Metric("Knob")
    local slider = setmetatable({
        Type = "Slider",
        Step = info.Step,
        Rounding = info.Rounding or Slider.Decimals(info.Step),
        Prefix = info.Prefix or "",
        Suffix = info.Suffix or "",
        FinishedOnly = info.Finished == true,
        Marks = info.Marks,
        Container = self,
    }, Slider)
    slider.Min, slider.Max = Slider.Bounds(info.Min, info.Max)
    slider.Value = slider:Quantize(tonumber(info.Default) or slider.Min)
    slider.Default = slider.Value
    slider.Row = Row.New(self, info, { Control = knob + Config.Widget.Knob.Shade + 4 })
    slider.Item = slider.Row.Item
    slider:Build(knob)
    slider:BuildAside()
    Widget.Register(slider, idx, info)
    slider:MeasureAside()
    slider:Render(false)
    Lang.OnChange(slider, function()
        slider:MeasureAside()
        slider:Render(false)
    end)
    return slider
end

---@return number  decimal places implied by a step like 0.25
function Slider.Decimals(step)
    if not step then
        return 0
    end
    local fraction = tostring(step):match("%.(%d+)$")
    return fraction and #fraction or 0
end

---@return number, number  min/max with defaults, ordered so math.clamp never sees min > max
function Slider.Bounds(min, max)
    min, max = tonumber(min) or 0, tonumber(max) or 100
    if min ~= min then
        min = 0
    end
    if max ~= max then
        max = min
    end
    return math.min(min, max), math.max(min, max)
end

function Slider:Quantize(value)
    if value ~= value then
        value = self.Min
    end
    value = math.clamp(value, self.Min, self.Max)
    if self.Step and self.Step > 0 then
        value = self.Min + math.floor((value - self.Min) / self.Step + 0.5) * self.Step
    end
    return Util.Round(math.clamp(value, self.Min, self.Max), self.Rounding)
end

function Slider:Build(knob)
    local control = self.Row.Control
    local depth = Config.Widget.Knob.Shade
    local track = Draw.Box("Frame", {
        Name = "Track",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, knob / 2, 0.5, -depth / 2),
        Size = UDim2.new(1, -knob, 0, Platform.Metric("Track")),
        ZIndex = Config.Z.Body,
        Parent = control,
    }, "Track", "Outline", UDim.new(1, 0), 2)
    self.Fill = Draw.Box("Frame", { Name = "Fill", Size = UDim2.fromScale(0, 1), ZIndex = Config.Z.Body, Parent = track }, "Accent", nil, UDim.new(1, 0))
    local shine = Draw.Box("Frame", { Position = UDim2.new(0, 3, 0, 1), Size = UDim2.new(1, -6, 0.35, 0), BackgroundTransparency = Config.Widget.Shine, ZIndex = Config.Z.Detail, Parent = self.Fill }, "White", nil, UDim.new(1, 0))
    shine.Name = "Shine"
    self:BuildMarks(track)
    local holder = Draw.New("Frame", { Name = "Knob", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(knob, knob), ZIndex = Config.Z.Raised, Parent = track })
    Draw.Box("Frame", { Name = "Shade", Position = UDim2.fromOffset(0, depth), Size = UDim2.fromScale(1, 1), ZIndex = Config.Z.Raised, Parent = holder }, "CoinDark", "Outline", UDim.new(1, 0), 2)
    local face = Draw.Box("Frame", { Name = "Face", Size = UDim2.fromScale(1, 1), ZIndex = Config.Z.Top, Parent = holder }, "Coin", "Outline", UDim.new(1, 0), 2)
    Draw.Box("Frame", { Name = "Slit", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0, 3, 0.45, 0), ZIndex = Config.Z.Note, Parent = face }, "CoinDark", nil, 2)
    self.Track, self.Knob = track, holder
    self.KnobScale = Draw.New("UIScale", { Parent = holder })
    local hit = Gui.Hitbox("Hit")
    hit.Position = UDim2.fromOffset(0, -Config.Widget.Slider.Slop)
    hit.Size = UDim2.new(1, 0, 1, Config.Widget.Slider.Slop * 2)
    hit.ZIndex = Config.Z.Hit
    hit.Active = true
    hit.Parent = control
    hit.InputBegan:Connect(function(input)
        if Util.IsPointer(input) then
            self:BeginDrag(input)
        end
    end)
end

function Slider:BuildMarks(track)
    if type(self.Marks) ~= "table" then
        return
    end
    local settings = Config.Widget.Slider
    local span = self.Max - self.Min
    for _, mark in ipairs(self.Marks) do
        local value = type(mark) == "table" and (mark.Value or mark[1]) or mark
        local fraction = span > 0 and math.clamp((value - self.Min) / span, 0, 1) or 0
        Draw.Box("Frame", {
            Name = "Notch",
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(fraction, 0, 1, 3),
            Size = UDim2.fromOffset(settings.Notch, settings.NotchHeight),
            ZIndex = Config.Z.Body,
            Parent = track,
        }, "Muted", nil, 1)
    end
end

function Slider:BuildAside()
    local aside = self.Row.Aside
    local settings = Config.Widget.Slider
    self.ValueBox = Draw.Text({
        ClassName = "TextBox",
        Name = "Value",
        ClearTextOnFocus = false,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.new(1, -settings.Reset - 4, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = Config.Z.Detail,
        Parent = aside,
    }, "Strong", Util.TextSize("Label"), "Accent")
    self.ValueBox.Focused:Connect(function()
        self.ValueBox.Text = tostring(self.Value)
    end)
    self.ValueBox.FocusLost:Connect(function()
        local typed = tonumber(self.ValueBox.Text)
        if typed and not self:IsBlocked() then
            self:SetValue(typed)
        end
        self:Render(false)
    end)
    local reset = Draw.Text({ ClassName = "TextButton", Name = "Reset", Text = "↺", Size = UDim2.fromOffset(settings.Reset, settings.Reset), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = Config.Z.Detail, Parent = aside }, "Glyph", Util.TextSize("Label"), "SubText")
    reset.AutoButtonColor = false
    self.Reset = reset
    self.ResetBinder = self:AddBinder(Gui.Clickable(reset, {
        OnClick = function()
            self:SetValue(self.Default)
            Motion.Pop(reset)
        end,
    }))
    if Tooltip.Attach then
        Tooltip.Attach(reset, Lang.Strings.Reset)
    end
end

function Slider:MeasureAside()
    local widest = 0
    local size = self.ValueBox.TextSize
    for _, value in ipairs({ self.Min, self.Max, (self.Min + self.Max) / 2 }) do
        widest = math.max(widest, Layout.Measure(self:Format(value), size, "Strong", 1000).X)
    end
    self.Row:SetAsideWidth(math.max(widest + 6, Platform.TouchMin()) + Config.Widget.Slider.Reset + 4)
end

function Slider:Format(value)
    value = value or self.Value
    local text = self.Rounding > 0 and string.format("%." .. self.Rounding .. "f", value) or tostring(math.floor(value + 0.5))
    return Lang.Resolve(self.Prefix) .. text .. Lang.Resolve(self.Suffix)
end

function Slider:BeginDrag(input)
    if self:IsBlocked() then
        return
    end
    self.Dragging = true
    Motion.Spring(self.KnobScale, "Scale", Config.Widget.Slider.Grab, "Fast", Slider.GrabSpring)
    Widget.BeginDrag(input, self, self.Row.Holder)
    self:OnDrag(input.Position)
end

function Slider:OnDrag(position)
    local left, width = self.Track.AbsolutePosition.X, self.Track.AbsoluteSize.X
    local fraction = width > 0 and math.clamp((position.X - left) / width, 0, 1) or 0
    self:SetValue(self.Min + (self.Max - self.Min) * fraction)
end

function Slider:OnDragEnd()
    Motion.Spring(self.KnobScale, "Scale", 1, "Fast", Slider.GrabSpring)
    self.Dragging = false
    if self.PendingFire then
        self.PendingFire = false
        self:Fire()
    end
end

function Slider:Render(animated)
    local span = self.Max - self.Min
    local fraction = span > 0 and (self.Value - self.Min) / span or 0
    local speed = self.Dragging and "Fast" or "Normal"
    if animated then
        Motion.Spring(self.Fill, "Size", UDim2.fromScale(fraction, 1), speed)
        Motion.Spring(self.Knob, "Position", UDim2.fromScale(fraction, 0.5), speed)
    else
        Motion.Set(self.Fill, "Size", UDim2.fromScale(fraction, 1))
        Motion.Set(self.Knob, "Position", UDim2.fromScale(fraction, 0.5))
    end
    if not self.ValueBox:IsFocused() then
        self.ValueBox.Text = self:Format()
    end
    local dirty = self.Value ~= self.Default
    Motion.Spring(self.Reset, "TextTransparency", dirty and 0 or 1, "Fast")
    self.Reset.Active = dirty
end

function Slider:SetValue(value)
    value = tonumber(value)
    if not value then
        return
    end
    value = self:Quantize(value)
    if value == self.Value then
        return
    end
    self.Value = value
    self:Render(true)
    if self.FinishedOnly and self.Dragging then
        self.PendingFire = true
        return
    end
    self:Fire()
end

function Slider:SetRange(min, max)
    self.Min, self.Max = Slider.Bounds(min, max)
    local clamped = self:Quantize(self.Value)
    local changed = clamped ~= self.Value
    self.Value = clamped
    self.Default = self:Quantize(self.Default)
    self:MeasureAside()
    self:Render(false)
    if changed then
        self:Fire()
    end
end

function Slider:SetMax(max)
    self:SetRange(self.Min, max)
end

function Slider:SetMin(min)
    self:SetRange(min, self.Max)
end

Gui.ListHandle = {}
Gui.ListHandle.__index = Gui.ListHandle

---Virtualized list: only visible rows exist, recycled on scroll.
---@param container table?  nil = parent into options.Parent at full size
---@param options table     { RowHeight, Rows?, MaxRows?, Count(), Render(parts, index), OnClick(index, input)?, Make()?, Parent?, Width?, Fill?, Bare? (no outline) }
---@return table            { Frame, Scroll, Item?, Refresh(force), ScrollTo(index) }
function Gui.VirtualList(container, options)
    local settings = Config.Widget.List
    local box = Draw.Box("Frame", { Name = "List", ClipsDescendants = true, BackgroundTransparency = 0 }, options.Fill or "Element", options.Bare and nil or "Outline", Platform.Metric("Radius"), 2)
    local scroll = Layout.ScrollFrame({ Name = "Scroll", Size = UDim2.fromScale(1, 1), Parent = box })
    local list = setmetatable({ Frame = box, Scroll = scroll, Options = options, Container = container, Pool = {}, First = -1, Count = -1, Step = options.RowHeight + settings.Gap }, Gui.ListHandle)
    scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        list:Refresh(false)
    end)
    scroll:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        if list:Slots() > #list.Pool then
            list:Refresh(true)
        end
    end)
    if container then
        list.Item = container:Add(box, {
            Width = options.Width,
            Height = function()
                return list:Height()
            end,
        })
    else
        box.Size = UDim2.fromScale(1, 1)
        box.Parent = options.Parent
    end
    list:Refresh(true)
    return list
end

function Gui.ListHandle:Height()
    local settings = Config.Widget.List
    local options = self.Options
    local rows = options.Rows or math.clamp(options.Count(), 1, options.MaxRows or settings.Rows)
    return rows * self.Step - settings.Gap + settings.Pad * 2
end

---Window warps and resizes stream AbsoluteSize every frame; rows only need a redraw when more slots become visible.
function Gui.ListHandle:Slots()
    return math.ceil(self.Scroll.AbsoluteSize.Y / self.Step) + 2
end

function Gui.ListHandle:Refresh(force)
    local settings = Config.Widget.List
    local count = self.Options.Count()
    local scroll = self.Scroll
    local first = math.max(0, math.floor((scroll.CanvasPosition.Y - settings.Pad) / self.Step))
    if not force and first == self.First and count == self.Count then
        return
    end
    if count ~= self.Count and self.Container and not self.Options.Rows then
        self.Container:MarkDirty()
    end
    self.First, self.Count = first, count
    scroll.CanvasSize = UDim2.fromOffset(0, math.max(0, count * self.Step - settings.Gap + settings.Pad * 2))
    self:Grow(self:Slots())
    for slot, parts in ipairs(self.Pool) do
        self:Place(parts, first + slot, count)
    end
end

function Gui.ListHandle:Grow(needed)
    local options = self.Options
    while #self.Pool < needed do
        local parts = (options.Make or Gui.MakeListRow)()
        parts.Frame.Parent = self.Scroll
        parts.Binder = Gui.Clickable(parts.Frame, {
            OnHover = function(hovered)
                Gui.HoverListRow(parts, hovered)
            end,
            OnClick = function(input)
                if parts.Index and options.OnClick and not parts.Header then
                    options.OnClick(parts.Index, input, parts)
                end
            end,
        })
        table.insert(self.Pool, parts)
    end
end

function Gui.ListHandle:Place(parts, index, count)
    local frame = parts.Frame
    if index > count then
        frame.Visible = false
        parts.Index = nil
        return
    end
    local pad = Config.Widget.List.Pad
    parts.Index = index
    frame.Position = UDim2.fromOffset(pad, pad + (index - 1) * self.Step)
    frame.Size = UDim2.new(1, -pad * 2, 0, self.Options.RowHeight)
    frame.Visible = true
    self.Options.Render(parts, index)
end

function Gui.ListHandle:ScrollTo(index)
    self.Scroll.CanvasPosition = Vector2.new(0, math.max(0, (index - 1) * self.Step))
end

---@return table  { Frame, Label, Mark, Sub? } pooled list row
function Gui.MakeListRow()
    local frame = Draw.Box("TextButton", { Name = "Entry", BackgroundTransparency = 1 }, "Hover", nil, Platform.Metric("Radius") - 2)
    local label = Draw.Text({ Name = "Label", Position = UDim2.fromOffset(Config.Selectable.PadX, 0), Size = UDim2.new(1, -Config.Selectable.PadX * 2 - Config.Widget.List.Mark, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = frame }, "Body", Util.TextSize("Label"), "Text")
    local size = Config.Widget.List.Mark
    local slot = Draw.New("Frame", { Name = "MarkSlot", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(size, size), Parent = frame })
    local mark = Toggle.BuildCheckMark(slot, size, "TabActiveText")
    return { Frame = frame, Label = label, Mark = mark }
end

function Gui.HoverListRow(parts, hovered)
    if parts.Header or parts.Selected then
        return
    end
    Motion.Spring(parts.Frame, "BackgroundTransparency", hovered and Config.Selectable.HoverAlpha or 1, "Fast")
end

---@param state table  { Text, Selected, Header, Icon, Token }
function Gui.PaintListRow(parts, state)
    local frame, label = parts.Frame, parts.Label
    parts.Header, parts.Selected = state.Header, state.Selected
    label.Text = Lang.Resolve(state.Text)
    if state.Header then
        Widget.Paint(parts, label, "TextColor3", "Muted", false)
        Motion.Set(frame, "BackgroundTransparency", 1)
        parts.Mark.GroupTransparency = 1
        Gui.SetListIcon(parts, nil)
        return
    end
    Widget.Paint(parts, frame, "BackgroundColor3", state.Selected and "TabActive" or "Hover", false)
    Widget.Paint(parts, label, "TextColor3", state.Selected and "TabActiveText" or (state.Token or "Text"), false)
    Motion.Set(frame, "BackgroundTransparency", state.Selected and 0 or 1)
    parts.Mark.GroupTransparency = state.Selected and 0 or 1
    Gui.SetListIcon(parts, state.Icon, state.Reserve)
end

---@param reserve boolean?  keep the icon column empty so text lines up with rows that have one
function Gui.SetListIcon(parts, icon, reserve)
    local key = icon or (reserve and "" or nil)
    if parts.IconName == key then
        return
    end
    parts.IconName = key
    if parts.Icon then
        parts.Icon:Destroy()
        parts.Icon = nil
    end
    local padX = Config.Selectable.PadX
    local textX = padX
    local size = Platform.Metric("Icon")
    if icon then
        parts.Icon = Sprite.New(parts.Frame, icon, size)
        parts.Icon.AnchorPoint = Vector2.new(0, 0.5)
        parts.Icon.Position = UDim2.new(0, padX, 0.5, 0)
    end
    if icon or reserve then
        textX += size + Config.Button.IconGap
    end
    parts.Label.Position = UDim2.fromOffset(textX, 0)
    parts.Label.Size = UDim2.new(1, -textX - padX - Config.Widget.List.Mark, 1, 0)
end

---@return TextBox
function Widget.SearchField(container, onChanged)
    local holder = Draw.New("Frame", { Name = "Search", BackgroundTransparency = 1 })
    local box = Widget.Field(holder, Lang.Strings.Search)
    box:GetPropertyChangedSignal("Text"):Connect(function()
        onChanged(box.Text)
    end)
    container:Add(holder, { Height = Platform.Metric("Box") })
    return box
end

function WidgetHost:AddDropdown(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local dropdown = setmetatable({
        Type = "Dropdown",
        Multi = info.Multi == true,
        AllowNull = info.AllowNull == true,
        Searchable = info.Searchable,
        Placeholder = info.Placeholder,
        SpecialType = info.SpecialType,
        Icons = info.Icons,
        Max = info.Max,
        Values = info.Values or {},
        Entries = {},
        Query = "",
        Container = self,
    }, Dropdown)
    dropdown:SetGroups(info.Groups)
    if dropdown.SpecialType == "Player" then
        dropdown.Values = Util.PlayerNames()
    end
    dropdown.Value = dropdown.Multi and {} or nil
    local depth = Platform.Metric("Depth")
    dropdown.Row = Row.New(self, info, { Control = Platform.Metric("Box") + depth })
    dropdown.Item = dropdown.Row.Item
    dropdown:Build(depth)
    dropdown:ApplyDefault(info.Default)
    Widget.Register(dropdown, idx, info)
    dropdown:WatchPlayers()
    Lang.OnChange(dropdown, function()
        dropdown:Render()
    end)
    return dropdown
end

---@param groups table?  { { Text = spec, Values = {...} }, ... } shown as headers in the list
function Dropdown:SetGroups(groups)
    self.Groups = groups
    if type(groups) ~= "table" then
        return
    end
    local flat = {}
    for _, group in ipairs(groups) do
        group.HeaderEntry = group.HeaderEntry or { Header = group.Text or group.Name or "" }
        for _, value in ipairs(group.Values or {}) do
            table.insert(flat, value)
        end
    end
    self.Values = flat
end

function Dropdown:Build(depth)
    local holder = Gui.Hitbox("Field")
    holder.Size = UDim2.fromScale(1, 1)
    holder.ZIndex = Config.Z.Body
    holder.Parent = self.Row.Control
    local face, shade = Gui.BuildBlock(holder, "Default", depth, Platform.Metric("Radius"))
    self.Holder, self.Face, self.Shade, self.Depth = holder, face, shade, depth
    local box = Platform.Metric("Box")
    self.Display = Draw.Text({ Name = "Display", Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -box - 14, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = face.ZIndex + 1, Parent = face }, "Body", Util.TextSize("Label"), "Text")
    local cap = Draw.Box("Frame", { Name = "Cap", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -4, 0.5, 0), Size = UDim2.new(0, box - 10, 1, -8), ZIndex = face.ZIndex + 1, Parent = face }, "Accent", "Outline", 6, 2)
    self.Chevron = Draw.Text({ Text = "▼", Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = cap.ZIndex + 1, Parent = cap }, "Glyph", Util.TextSize("Small"), "AccentText")
    self.Count = Draw.Box("Frame", { Name = "Count", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -box, 0.5, 0), Visible = false, ZIndex = face.ZIndex + 1, Parent = face }, "Coin", "Outline", UDim.new(1, 0), 1)
    self.CountLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = self.Count.ZIndex + 1, Parent = self.Count }, "Strong", Config.Widget.Badge.Size, "Ink")
    self:AddBinder(Gui.Clickable(holder, {
        OnHover = function(hovered)
            local base = Theme.Color("Element")
            Motion.Spring(face, "BackgroundColor3", hovered and Theme.Color("Hover") or base, "Fast")
        end,
        OnPress = function(pressed)
            Motion.Spring(face, "Position", UDim2.fromOffset(0, pressed and depth - 1 or 0), "Fast")
        end,
        OnClick = function()
            self:Open()
        end,
    }))
end

---Sets the starting selection without firing; a number Default on a single select is an index into Values.
function Dropdown:ApplyDefault(default)
    if not self.Multi and type(default) == "number" and self.Values[default] ~= nil and not Widget.IndexOf(self.Values, default) then
        default = self.Values[default]
    end
    self.Value = self:Normalize(default)
    self:Render()
end

---@return any  Multi: set of Values entries capped at Max; single: the matching entry, else current/first when AllowNull is off
function Dropdown:Normalize(value)
    if self.Multi then
        return Widget.SelectSet(self.Values, value, self.Max)
    end
    if type(value) == "table" and value.EN == nil and value.TH == nil then
        value = value[1]
    end
    local entry = Widget.Canonical(self.Values, value)
    if entry ~= nil or self.AllowNull then
        return entry
    end
    return Widget.Canonical(self.Values, self.Value) or self.Values[1]
end

---Stores a normalized selection and fires only when it differs (by key) from the current one.
function Dropdown:Commit(value)
    local same
    if self.Multi then
        same = Widget.SameSet(value, self.Value)
    else
        same = Widget.Key(value) == Widget.Key(self.Value)
    end
    self.Value = value
    self:Render()
    if not same then
        self:Fire()
    end
end

function Dropdown:WatchPlayers()
    if self.SpecialType ~= "Player" then
        return
    end
    local function Refresh()
        if not Library.Unloaded then
            self:SetValues(Util.PlayerNames())
        end
    end
    Util.Connect(Players.PlayerAdded, Refresh)
    Util.Connect(Players.PlayerRemoving, function()
        task.defer(Refresh)
    end)
end

function Dropdown:IsSelected(value)
    if self.Multi then
        return self.Value[value] == true
    end
    return self.Value == value
end

function Dropdown:GetActiveValues()
    local active = {}
    if not self.Multi then
        if self.Value ~= nil then
            active[1] = self.Value
        end
        return active
    end
    for _, value in ipairs(self.Values) do
        if self.Value[value] then
            table.insert(active, value)
        end
    end
    return active
end

function Dropdown:Summary(active)
    local count = #active
    if count == 0 then
        return Lang.Resolve(self.Placeholder or Lang.Strings.None)
    end
    local shown = {}
    for index = 1, math.min(count, Config.Widget.MultiPreview) do
        shown[index] = Lang.Resolve(active[index])
    end
    return table.concat(shown, ", ")
end

function Dropdown:Render()
    local active = self:GetActiveValues()
    self.Display.Text = self:Summary(active)
    Theme.Bind(self.Display, { TextColor3 = #active > 0 and "Text" or "Muted" })
    local extra = self.Multi and #active > Config.Widget.MultiPreview
    self.Count.Visible = extra
    local box = Platform.Metric("Box")
    self.Display.Size = UDim2.new(1, -box - 14 - (extra and 34 or 0), 1, 0)
    if extra then
        self.CountLabel.Text = "+" .. (#active - Config.Widget.MultiPreview)
        self.Count.Size = UDim2.fromOffset(30, Config.Widget.Badge.Height + 2)
    end
    if self.List then
        self.List:Refresh(true)
    end
end

function Dropdown:SetValue(value)
    self:Commit(self:Normalize(value))
end

---Picks that vanish from the new Values are dropped (fires when that changes the selection).
function Dropdown:SetValues(values, groups)
    local previous = self.Multi and Widget.KeysOf(self.Value) or self.Value
    if groups then
        self:SetGroups(groups)
    else
        self.Groups = nil
        self.Values = values or {}
    end
    self:BuildEntries()
    if self.Multi then
        self:Commit(Widget.SelectSet(self.Values, previous, self.Max))
        return
    end
    local entry = Widget.Canonical(self.Values, previous)
    if entry == nil and not self.AllowNull then
        entry = self.Values[1]
    end
    self:Commit(entry)
end

---@return any  save keys (T() tables saved as their English text), mapped back by Deserialize
function Dropdown:Serialize()
    if self.Multi then
        local keys = {}
        for index, value in ipairs(self:GetActiveValues()) do
            keys[index] = Widget.Key(value)
        end
        return keys
    end
    return Widget.Key(self.Value)
end

function Dropdown:IsSearchable()
    if self.Searchable ~= nil then
        return self.Searchable == true
    end
    return #self.Values > Config.Dropdown.SearchThreshold
end

function Dropdown.Match(value, query)
    return query == "" or Lang.SearchText(value):find(query, 1, true) ~= nil
end

function Dropdown:BuildEntries()
    local entries, query = self.Entries, self.Query
    table.clear(entries)
    if not self.Groups then
        for _, value in ipairs(self.Values) do
            if Dropdown.Match(value, query) then
                entries[#entries + 1] = value
            end
        end
        return
    end
    for _, group in ipairs(self.Groups) do
        local header = group.HeaderEntry
        for _, value in ipairs(group.Values or {}) do
            if Dropdown.Match(value, query) then
                entries[#entries + 1] = header
                header = nil
                entries[#entries + 1] = value
            end
        end
    end
    for index = #entries, 1, -1 do
        if entries[index] == nil then
            table.remove(entries, index)
        end
    end
end

Dropdown.State = {}

function Dropdown:EntryLabel(entry)
    if entry == nil then
        return (self.Query or "") ~= "" and Lang.Strings.NoResults or Lang.Strings.Empty, true
    end
    if type(entry) == "table" and entry.Header then
        return entry.Header, true
    end
    return entry, false
end

function Dropdown:RenderEntry(parts, index)
    local entry = self.Entries[index]
    local state = Dropdown.State
    local text, header = self:EntryLabel(entry)
    state.Text = text
    state.Header = header
    state.Selected = not header and self:IsSelected(entry)
    state.Icon = not header and self.Icons and self.Icons[entry] or nil
    state.Reserve = not header and self.Icons ~= nil and next(self.Icons) ~= nil
    Gui.PaintListRow(parts, state)
end

function Dropdown:PickEntry(index, parts)
    local value = self.Entries[index]
    if value == nil or (type(value) == "table" and value.Header) or self:IsBlocked() then
        return
    end
    if self.Multi and not self.Value[value] and self.Max and #self:GetActiveValues() >= self.Max then
        Motion.Shake(parts.Frame)
        if Notify.Push then
            Notify.Push(self.Info.Text or "", Lang.Get("MaxPicked", self.Max), 2, "Warn")
        end
        return
    end
    self:Pick(value)
    Motion.Pop(parts.Mark)
    if not self.Multi then
        Widget.ClosePopup()
    end
end

function Dropdown:Pick(value)
    if not self.Multi then
        self:Commit(if self.Value == value and self.AllowNull then nil else value)
        return
    end
    local picked = table.clone(self.Value)
    picked[value] = not picked[value] or nil
    self:Commit(picked)
end

---@param mode string  "All" | "None" | "Invert"
function Dropdown:Bulk(mode)
    local picked = {}
    for _, value in ipairs(self.Values) do
        local on = mode == "All" or (mode == "Invert" and not self.Value[value])
        if on and (not self.Max or #picked < self.Max) then
            picked[#picked + 1] = value
        end
    end
    self:SetValue(picked)
end

function Dropdown:BuildToolbar(container)
    for index, mode in ipairs({ "All", "None", "Invert" }) do
        if index > 1 then
            container:SameLine()
        end
        Gui.Button(container, {
            Text = Lang.Strings[mode],
            Width = index < 3 and 1 / 3 or nil,
            Height = Platform.Metric("Item"),
            Callback = function()
                self:Bulk(mode)
            end,
        })
    end
end

function Dropdown:BuildPopup(container)
    self.Query = ""
    if self:IsSearchable() then
        Widget.SearchField(container, function(text)
            self.Query = text:lower()
            self:BuildEntries()
            if self.List then
                self.List:ScrollTo(1)
                self.List:Refresh(true)
            end
        end)
    end
    if self.Multi then
        self:BuildToolbar(container)
    end
    self:BuildEntries()
    self.List = Gui.VirtualList(container, {
        RowHeight = Platform.Metric("Item"),
        MaxRows = Config.Dropdown.MaxVisible,
        Bare = true,
        Fill = "Panel",
        Count = function()
            return math.max(1, #self.Entries)
        end,
        Render = function(parts, index)
            self:RenderEntry(parts, index)
        end,
        OnClick = function(index, _, parts)
            self:PickEntry(index, parts)
        end,
    })
    local selected = not self.Multi and table.find(self.Entries, self.Value)
    if selected then
        self.List:ScrollTo(math.max(1, selected - 2))
    end
end

function Dropdown:Open()
    if self:IsBlocked() then
        return
    end
    Motion.Spring(self.Chevron, "Rotation", 180, "Normal")
    Popup.Open(self.Holder, function(container)
        self:BuildPopup(container)
    end, {
        Width = math.max(self.Holder.AbsoluteSize.X, Config.Dropdown.MinWidth),
        Title = self.Info.Text,
        OnClose = function()
            self.List = nil
            self.Query = ""
            Motion.Spring(self.Chevron, "Rotation", 0, "Normal")
        end,
    })
end

function WidgetHost:AddListBox(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local rows = info.Height or 5
    local listbox = setmetatable({
        Type = "Dropdown",
        Multi = info.Multi == true,
        AllowNull = info.AllowNull ~= false,
        Max = info.Max,
        Values = info.Values or {},
        Icons = info.Icons,
        Entries = {},
        Query = "",
        Container = self,
    }, ListBox)
    listbox.Value = listbox.Multi and {} or nil
    local settings = Config.Widget.List
    local itemHeight = Platform.Metric("Item")
    listbox.Row = Row.New(self, info, { Control = rows * (itemHeight + settings.Gap) - settings.Gap + settings.Pad * 2 })
    listbox.Item = listbox.Row.Item
    Dropdown.BuildEntries(listbox)
    listbox.List = Gui.VirtualList(nil, {
        Parent = listbox.Row.Control,
        RowHeight = itemHeight,
        Rows = rows,
        Count = function()
            return math.max(1, #listbox.Entries)
        end,
        Render = function(parts, index)
            Dropdown.RenderEntry(listbox, parts, index)
        end,
        OnClick = function(index, _, parts)
            Dropdown.PickEntry(listbox, index, parts)
        end,
    })
    listbox:ApplyDefault(info.Default)
    Widget.Register(listbox, idx, info)
    return listbox
end

ListBox.IsSelected = Dropdown.IsSelected
ListBox.EntryLabel = Dropdown.EntryLabel
ListBox.GetActiveValues = Dropdown.GetActiveValues
ListBox.Serialize = Dropdown.Serialize
ListBox.Pick = Dropdown.Pick
ListBox.BuildEntries = Dropdown.BuildEntries
ListBox.ApplyDefault = Dropdown.ApplyDefault
ListBox.Normalize = Dropdown.Normalize
ListBox.Commit = Dropdown.Commit
ListBox.SetValue = Dropdown.SetValue

function ListBox:Render()
    self.List:Refresh(true)
end

ListBox.SetValues = Dropdown.SetValues

function WidgetHost:AddInput(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local input = setmetatable({
        Type = "Input",
        Value = tostring(info.Default or ""),
        Numeric = info.Numeric,
        Finished = info.Finished,
        MaxLength = info.MaxLength,
        Container = self,
    }, Input)
    input.Row = Row.New(self, info, { Control = Platform.Metric("Box") })
    input.Item = input.Row.Item
    local box, field = Widget.Field(input.Row.Control, info.Placeholder)
    field.ZIndex = Config.Z.Body
    box.Text = input.Value
    box.ClearTextOnFocus = info.ClearTextOnFocus == true
    input.Box, input.Field = box, field
    input:Bind()
    Widget.Register(input, idx, info)
    return input
end

function Input:Bind()
    local box = self.Box
    box:GetPropertyChangedSignal("Text"):Connect(function()
        local clean = self:Sanitize(box.Text)
        if clean ~= box.Text then
            box.Text = clean
            return
        end
        if not self.Finished then
            self:Commit(clean)
        end
    end)
    box.FocusLost:Connect(function(enter)
        self:Commit(box.Text)
        if enter then
            Motion.Pop(self.Field)
        end
    end)
end

function Input:ApplyBlocked()
    Widget.ApplyBlocked(self)
    self.Box.TextEditable = not self:IsBlocked()
end

function Input:Sanitize(text)
    if self.Numeric then
        text = text:gsub("[^%d%.%-]", "")
    end
    if self.MaxLength and #text > self.MaxLength then
        text = text:sub(1, self.MaxLength)
    end
    return text
end

function Input:Commit(text)
    if text == self.Value then
        return
    end
    self.Value = text
    self:Fire()
end

function Input:SetValue(text)
    text = self:Sanitize(tostring(text or ""))
    self.Box.Text = text
    self:Commit(text)
end

function WidgetHost:AddButton(info, callback)
    return Button.Create(self, info, callback)
end

---@return table  info table with Callback resolved (Callback, then V1 Func, then the positional callback)
function Button.Normalize(info, callback)
    if type(info) ~= "table" or info.EN or info.TH then
        info = { Text = info }
    end
    info.Callback = info.Callback or info.Func or callback
    return info
end

---@param after table?  layout item to insert behind (chained :AddButton)
---@param class table?  metatable for subclasses (ConfirmButton); default Button
function Button.Create(container, info, callback, after, class)
    info = Button.Normalize(info, callback)
    local button = setmetatable({ Type = "Button", Container = container, Info = info, Callback = info.Callback, Armed = false }, class or Button)
    local handle = Gui.Button(container, {
        Text = info.Text or "",
        Icon = info.Icon,
        Style = info.Style,
        Width = info.Width,
        Callback = function()
            button:Click()
        end,
    })
    button.Handle, button.Frame, button.Item = handle, handle.Frame, handle.Item
    handle.Item.Search, handle.Item.Label = Lang.SearchText(info.Text), info.Text
    if after then
        handle.Item.SameLine = true
        Widget.MoveAfter(container, handle.Item, after)
    end
    button.Group = { button }
    if info.Tooltip and Tooltip.Attach then
        Tooltip.Attach(handle.Frame, info.Tooltip)
    end
    if info.Disabled then
        button:SetDisabled(true)
    end
    if info.DependsOn then
        Widget.Depend(button, info.DependsOn)
    end
    return button
end

function Button:Click()
    if self.Disabled or self.Locked then
        return
    end
    if self.Info.DoubleClick and not self.Armed then
        self:Arm()
        return
    end
    self:Disarm()
    Util.Try(self.Callback)
end

function Button:Arm()
    self.Armed = true
    local token = os.clock()
    self.ArmToken = token
    self.Handle.Label.Text = Lang.Resolve(Platform.Touch and Lang.Strings.TapConfirm or Lang.Strings.Confirm)
    self.Handle:SetStyle("Warning")
    Motion.Shake(self.Handle.Face)
    task.delay(Config.ConfirmWindow, Button.Expire, self, token)
end

function Button.Expire(button, token)
    if button.ArmToken == token then
        button:Disarm()
    end
end

function Button:Disarm()
    if not self.Armed then
        return
    end
    self.Armed = false
    self.Handle:SetStyle(self.Info.Style or "Default")
    Lang.Bind(self.Handle.Label, self.Info.Text or "")
end

function Button:AddButton(info, callback)
    local last = self.Group[#self.Group]
    local sibling = Button.Create(self.Container, info, callback, last.Item)
    sibling.Group = self.Group
    table.insert(self.Group, sibling)
    local count = #self.Group
    for index, member in ipairs(self.Group) do
        member.Item.Width = index < count and 1 / count or nil
        member.Item.Fill = true
    end
    self.Container:MarkDirty()
    return sibling
end

function Button:SetText(spec)
    self.Info.Text = spec
    self.Handle:Set(spec)
    self.Item.Search, self.Item.Label = Lang.SearchText(spec), spec
end

function Button:SetDisabled(disabled)
    self.Disabled = disabled == true
    self.Handle:SetDisabled(self.Disabled or self.Locked == true)
    return self
end

function Button:Lock(locked)
    self.Locked = locked ~= false
    self.Handle:SetDisabled(self.Locked or self.Disabled == true)
    return self
end

function Button:Flash()
    Motion.Pop(self.Handle.Face)
    return self
end

Button.SetVisible = Widget.SetVisible

function KeyPicker.Short(name)
    return Config.Widget.KeyShort[name] or tostring(name)
end

---@param linked table?  toggle driven by this key (nil = standalone keybind)
function KeyPicker.New(row, idx, info, linked)
    Widget.Aliases(info)
    local picker = setmetatable({
        Type = "KeyPicker",
        Value = Util.KeyName(info.Default) or "None",
        Mode = table.find(Config.Widget.Modes, info.Mode) and info.Mode or "Toggle",
        Linked = linked,
        Toggled = false,
        Held = false,
        Row = row,
        Item = row.Item,
        Container = row.Container,
        Text = info.Text or (linked and linked.Row.Info.Text) or row.Info.Text,
        ChangedCallback = info.ChangedCallback,
        SyncToggleState = info.SyncToggleState,
    }, KeyPicker)
    picker:Build()
    Widget.Register(picker, idx, info)
    if linked and not info.Callback then
        picker.Callback = nil
    end
    table.insert(State.KeyPickers, picker)
    picker:Render()
    Lang.OnChange(picker, function()
        picker:Render()
    end)
    if info.FloatButton and Platform.Touch and linked and linked.Idx and QuickBar.Add then
        QuickBar.Add(linked.Idx)
    end
    return picker
end

function KeyPicker:Build()
    local depth = Config.Widget.Knob.Shade
    local height, width = Platform.Metric("Control"), Platform.Metric("Key")
    local holder = Gui.Hitbox("Key")
    holder.Size = UDim2.fromOffset(width, height)
    local face, shade = Gui.BuildBlock(holder, "Default", depth, 6)
    self.Holder, self.Face, self.Shade, self.Depth = holder, face, shade, depth
    self.Label = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = face.ZIndex + 1, Parent = face }, "Strong", Util.TextSize("Small") + 1, "Text")
    local dotSize = Config.Widget.Key.Dot
    self.Dot = Draw.Box("Frame", { Name = "Mode", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -3, 0, 3), Size = UDim2.fromOffset(dotSize, dotSize), ZIndex = face.ZIndex + 2, Parent = face }, nil, nil, UDim.new(1, 0))
    self.Dot.BackgroundTransparency = 0
    self.Row:AddRight(holder, width)
    self:AddBinder(Gui.Clickable(holder, {
        OnPress = function(pressed)
            Motion.Spring(face, "Position", UDim2.fromOffset(0, pressed and depth - 1 or 0), "Fast")
        end,
        OnClick = function()
            self:OpenMenu()
        end,
    }))
    holder.MouseButton2Click:Connect(function()
        if not self:IsBlocked() then
            self:OpenMenu()
        end
    end)
end

function KeyPicker:Render()
    local listening = State.Binding == self
    if not listening then
        self.Capturing = nil
    end
    local text = listening and "..." or KeyPicker.Short(self.Value)
    self.Label.Text = text
    local settings = Config.Widget.Key
    local width = math.max(settings.Min, Platform.TouchMin(), Layout.Measure(text, self.Label.TextSize, "Strong", 1000).X + settings.Pad)
    if width ~= self.Holder.Size.X.Offset then
        Motion.Spring(self.Holder, "Size", UDim2.fromOffset(width, self.Holder.Size.Y.Offset), "Fast")
        self.Row:SetRightWidth(self.Holder, width)
    end
    Widget.Paint(self, self.Face, "BackgroundColor3", listening and "Coin" or "Element", true)
    Widget.Paint(self, self.Shade, "BackgroundColor3", listening and "CoinDark" or "Pressed", true)
    Widget.Paint(self, self.Dot, "BackgroundColor3", Config.Widget.ModeTokens[self.Mode] or "Muted", true)
end

---Arms capture; the next input is taken by Keybinds.Capture (60), the single capture path.
function KeyPicker:Listen()
    local previous = State.Binding
    State.Binding = self
    self.Capturing = true
    if previous and previous ~= self then
        previous:Render()
    end
    self:Render()
    Motion.Pop(self.Holder)
end

---Duplicate warning only fires for a key the user just captured, not for code/config loads.
function KeyPicker:SetKey(name)
    name = name or "None"
    local captured = self.Capturing
    self.Capturing = nil
    if name == self.Value then
        self:Render()
        return
    end
    self.Value = name
    self:Render()
    if captured then
        self:WarnDuplicate()
    end
    Util.Try(self.ChangedCallback, name)
    for _, callback in ipairs(self.Changed) do
        Util.Try(callback, name)
    end
end

---@return boolean  row still lives in its container (rows on tabs not drawn yet count; removed rows do not)
function KeyPicker:IsMounted()
    local container = self.Container
    if not container or container.Destroyed then
        return false
    end
    return table.find(container.Items, self.Item) ~= nil
end

function KeyPicker:WarnDuplicate()
    if self.Value == "None" then
        return
    end
    for _, other in ipairs(State.KeyPickers) do
        if other ~= self and not other.Destroyed and other.Value == self.Value and other:IsMounted() then
            other:Flash()
            self:Flash()
            if Notify.Push then
                Notify.Push(Lang.Strings.DuplicateKey, Lang.Get("DuplicateKeyText", KeyPicker.Short(self.Value), Lang.Resolve(other.Text or other.Idx or "?")), 3, "Warn")
            end
            return
        end
    end
end

---@param down boolean  key pressed (true) or released (false); dispatched by Keybinds/QuickBar
function KeyPicker:Press(down)
    if self.Mode == "Always" or self:IsBlocked() or (self.Linked and self.Linked:IsBlocked()) then
        return
    end
    if self.Mode == "Hold" then
        self.Held = down
        if self.Linked then
            self.Linked:SetValue(down)
        end
        Util.Try(self.Callback, down)
        return
    end
    if not down then
        return
    end
    self.Toggled = not self.Toggled
    if self.Linked then
        self.Linked:SetValue(not self.Linked.Value)
    end
    Util.Try(self.Callback, self:GetState())
end

function KeyPicker:GetState()
    if self.Mode == "Always" then
        return true
    end
    if self.Mode == "Hold" then
        return self.Held
    end
    return self.Linked and self.Linked.Value or self.Toggled
end

function KeyPicker:SetValue(value)
    if type(value) == "table" then
        self:SetMode(value.Mode or value[2] or self.Mode, true)
        value = value.Key or value[1]
    end
    self:SetKey(Util.KeyName(value) or "None")
end

function KeyPicker:Serialize()
    return { Key = self.Value, Mode = self.Mode }
end

---@param silent boolean?  true (code/config load) = leave the linked toggle alone; only the mode menu drives it
function KeyPicker:SetMode(mode, silent)
    if not table.find(Config.Widget.Modes, mode) then
        return
    end
    self.Mode = mode
    self.Held, self.Toggled = false, false
    if silent or (self.Linked and self.Linked:IsBlocked()) then
        self:Render()
        return
    end
    if self.Linked and mode == "Always" then
        self.Linked:SetValue(true)
    elseif self.Linked and mode == "Hold" then
        self.Linked:SetValue(false)
    end
    self:Render()
    Motion.Pop(self.Dot)
end

---One menu for everything a key can do, so nobody has to discover right-click or long-press.
function KeyPicker:OpenMenu()
    Popup.Open(self.Holder, function(container)
        Gui.Button(container, {
            Text = Lang.Strings.SetKey,
            Icon = "keyboard",
            Style = "Primary",
            Callback = function()
                Widget.ClosePopup()
                self:Listen()
            end,
        })
        Gui.Separator(container, Lang.Strings.KeyMode)
        for _, mode in ipairs(Config.Widget.Modes) do
            Gui.Selectable(container, {
                Text = Lang.Strings["Mode" .. mode .. "Hint"],
                Selected = self.Mode == mode,
                Callback = function()
                    self:SetMode(mode)
                    Widget.ClosePopup()
                end,
            })
        end
        if self.Value ~= "None" then
            Gui.Button(container, {
                Text = Lang.Strings.ClearKey,
                Icon = "trash",
                Style = "Ghost",
                Callback = function()
                    Widget.ClosePopup()
                    self:SetKey("None")
                end,
            })
        end
    end, { Width = Config.Widget.Key.Menu, Title = Lang.Strings.Keybind })
end

function KeyPicker:Flash()
    Motion.Shake(self.Face)
    if self.Row then
        self.Row:Flash()
    end
    return self
end

function ColorPicker.New(row, idx, info)
    local picker = setmetatable({
        Type = "ColorPicker",
        Value = typeof(info.Default) == "Color3" and info.Default or Util.FromHex(info.Default or "") or Theme.Color("White"),
        Transparency = info.Transparency,
        Row = row,
        Item = row.Item,
        Container = row.Container,
    }, ColorPicker)
    picker.Hue, picker.Sat, picker.Vib = picker.Value:ToHSV()
    local depth = Config.Widget.Knob.Shade
    local height, width = Platform.Metric("Control"), Platform.Metric("Swatch")
    local holder = Gui.Hitbox("Swatch")
    holder.Size = UDim2.fromOffset(width, height)
    local face = Gui.BuildBlock(holder, "Default", depth, 6)
    Theme.Unbind(face)
    picker.Holder, picker.Swatch = holder, face
    row:AddRight(holder, width)
    picker:AddBinder(Gui.Clickable(holder, {
        OnPress = function(pressed)
            Motion.Spring(face, "Position", UDim2.fromOffset(0, pressed and depth - 1 or 0), "Fast")
        end,
        OnClick = function()
            picker:Open()
        end,
    }))
    Widget.Register(picker, idx, info)
    picker:Render()
    return picker
end

function ColorPicker:Fire()
    Util.Try(self.Callback, self.Value, self.Transparency)
    for _, callback in ipairs(self.Changed) do
        Util.Try(callback, self.Value, self.Transparency)
    end
end

function ColorPicker:Render()
    Motion.Spring(self.Swatch, "BackgroundColor3", self.Value, "Fast")
    self.Swatch.BackgroundTransparency = (self.Transparency or 0) * 0.8
    local view = self.View
    if not view then
        return
    end
    view.Field.BackgroundColor3 = Color3.fromHSV(self.Hue, 1, 1)
    view.Cursor.Position = UDim2.fromScale(self.Sat, 1 - self.Vib)
    view.HueCursor.Position = UDim2.fromScale(0.5, self.Hue)
    view.Preview.BackgroundColor3 = self.Value
    view.Preview.BackgroundTransparency = self.Transparency or 0
    if view.Alpha then
        view.AlphaBar.BackgroundColor3 = self.Value
        view.AlphaCursor.Position = UDim2.fromScale(0.5, self.Transparency or 0)
    end
    if not view.Hex:IsFocused() then
        view.Hex.Text = Util.Hex(self.Value)
    end
end

function ColorPicker:Commit()
    self.Value = Color3.fromHSV(self.Hue, self.Sat, self.Vib)
    self:Render()
    self:Fire()
end

function ColorPicker:SetValueRGB(color, transparency)
    self.Value = color
    if transparency ~= nil then
        self.Transparency = transparency
    end
    self.Hue, self.Sat, self.Vib = color:ToHSV()
    self:Render()
    self:Fire()
end

function ColorPicker:SetValue(value, transparency)
    if type(value) == "table" then
        value, transparency = value.Hex or value[1], value.Transparency or value[2]
    end
    local color = typeof(value) == "Color3" and value or Util.FromHex(value or "")
    if color then
        self:SetValueRGB(color, transparency)
    end
end

function ColorPicker:Serialize()
    if self.Transparency == nil then
        return Util.Hex(self.Value)
    end
    return { Hex = Util.Hex(self.Value), Transparency = self.Transparency }
end

function ColorPicker:BeginDrag(input, kind)
    if not Util.IsPointer(input) then
        return
    end
    self.DragKind = kind
    Widget.BeginDrag(input, self, self.View and self.View.Root)
    self:OnDrag(input.Position)
end

function ColorPicker:OnDrag(position)
    local view = self.View
    if not view then
        return
    end
    local target = self.DragKind == "Field" and view.Field or (self.DragKind == "Hue" and view.HueBar or view.AlphaBar)
    local origin, extent = target.AbsolutePosition, target.AbsoluteSize
    local x = math.clamp((position.X - origin.X) / math.max(1, extent.X), 0, 1)
    local y = math.clamp((position.Y - origin.Y) / math.max(1, extent.Y), 0, 1)
    if self.DragKind == "Field" then
        self.Sat, self.Vib = x, 1 - y
    elseif self.DragKind == "Hue" then
        self.Hue = math.min(y, 0.999)
    else
        self.Transparency = Util.Round(y, 2)
    end
    self:Commit()
end

function ColorPicker:BuildField(root)
    local field = Draw.Box("Frame", { Name = "Field", BackgroundTransparency = 0, Parent = root }, nil, "Outline", 6, 2)
    local white = Draw.Box("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0, Parent = field }, "White", nil, 6)
    Draw.New("UIGradient", { Transparency = NumberSequence.new(0, 1), Parent = white })
    local black = Draw.Box("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0, Parent = field }, "Black", nil, 6)
    Draw.New("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0), Parent = black })
    local cursor = Draw.Box("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(12, 12), ZIndex = Config.Z.Body, Parent = field }, nil, "White", UDim.new(1, 0), 2)
    field.InputBegan:Connect(function(input)
        self:BeginDrag(input, "Field")
    end)
    return field, cursor
end

function ColorPicker:BuildBar(root, name, kind)
    local bar = Draw.Box("Frame", { Name = name, BackgroundTransparency = 0, Parent = root }, "White", "Outline", 4, 2)
    local cursor = Draw.Box("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(1, 6, 0, 4), ZIndex = Config.Z.Body, Parent = bar }, "Knob", "Outline", 2, 1)
    bar.InputBegan:Connect(function(input)
        self:BeginDrag(input, kind)
    end)
    return bar, cursor
end

function ColorPicker:BuildHue(root)
    local bar, cursor = self:BuildBar(root, "Hue", "Hue")
    local keys = {}
    for step = 0, 6 do
        table.insert(keys, ColorSequenceKeypoint.new(step / 6, Color3.fromHSV(step / 6 % 1, 1, 1)))
    end
    Draw.New("UIGradient", { Rotation = 90, Color = ColorSequence.new(keys), Parent = bar })
    return bar, cursor
end

function ColorPicker:BuildAlpha(root)
    local bar, cursor = self:BuildBar(root, "Alpha", "Alpha")
    Theme.Unbind(bar)
    Draw.New("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(0, 0.9), Parent = bar })
    return bar, cursor
end

function ColorPicker:BuildPresets(root)
    local strip = Draw.New("Frame", { Name = "Presets", BackgroundTransparency = 1, Parent = root })
    Draw.List(strip, 6, true, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    local size = Platform.Metric("Preset")
    for order, token in ipairs(Config.Widget.Presets) do
        local chip = Draw.Box("TextButton", { Name = token, LayoutOrder = order, Size = UDim2.fromOffset(size, size), BackgroundTransparency = 0 }, token, "Outline", UDim.new(1, 0), 2)
        chip.Parent = strip
        Gui.Clickable(chip, {
            OnClick = function()
                Motion.Pop(chip)
                self:SetValueRGB(Theme.Color(token))
            end,
        })
    end
    return strip
end

function ColorPicker:BuildHexRow(root)
    local hexHolder = Draw.New("Frame", { Name = "Hex", BackgroundTransparency = 1, Parent = root })
    local hex = Widget.Field(hexHolder, "#FFFFFF")
    hex.TextXAlignment = Enum.TextXAlignment.Center
    hex.FocusLost:Connect(function()
        local color = Util.FromHex(hex.Text)
        if color then
            self:SetValueRGB(color)
        else
            Motion.Shake(hexHolder)
            self:Render()
        end
    end)
    local preview = Draw.Box("Frame", { Name = "Preview", BackgroundTransparency = 0, Parent = root }, nil, "Outline", 8, 2)
    return hexHolder, hex, preview
end

function ColorPicker:LayoutView(width)
    local view = self.View
    local settings, gap = Config.ColorPicker, Config.Gap.X
    local size, box = settings.Field, Platform.Metric("Box")
    local bars = settings.Hue + gap + (view.Alpha and Config.Widget.Alpha + gap or 0)
    local fieldWidth = math.max(60, width - bars)
    view.Field.Position, view.Field.Size = UDim2.new(), UDim2.fromOffset(fieldWidth, size)
    view.HueBar.Position, view.HueBar.Size = UDim2.fromOffset(fieldWidth + gap, 0), UDim2.fromOffset(settings.Hue, size)
    if view.Alpha then
        view.AlphaBar.Position = UDim2.fromOffset(fieldWidth + gap * 2 + settings.Hue, 0)
        view.AlphaBar.Size = UDim2.fromOffset(Config.Widget.Alpha, size)
    end
    local rowY = size + gap
    view.HexHolder.Position, view.HexHolder.Size = UDim2.fromOffset(0, rowY), UDim2.fromOffset(width - box - gap, box)
    view.Preview.Position, view.Preview.Size = UDim2.fromOffset(width - box, rowY), UDim2.fromOffset(box, box)
    view.Presets.Position = UDim2.fromOffset(0, rowY + box + gap)
    view.Presets.Size = UDim2.fromOffset(width, Platform.Metric("Preset"))
end

function ColorPicker:BuildView(container)
    local settings, gap = Config.ColorPicker, Config.Gap.X
    local root = Draw.New("Frame", { Name = "Picker", BackgroundTransparency = 1 })
    local view = { Root = root, Alpha = self.Transparency ~= nil }
    view.Field, view.Cursor = self:BuildField(root)
    view.HueBar, view.HueCursor = self:BuildHue(root)
    if view.Alpha then
        view.AlphaBar, view.AlphaCursor = self:BuildAlpha(root)
    end
    view.HexHolder, view.Hex, view.Preview = self:BuildHexRow(root)
    view.Presets = self:BuildPresets(root)
    self.View = view
    container:Add(root, {
        Height = settings.Field + Platform.Metric("Box") + Platform.Metric("Preset") + gap * 2 + 2,
        OnLayout = function(width)
            self:LayoutView(width)
        end,
    })
    self:Render()
end

function ColorPicker:Open()
    if self:IsBlocked() then
        return
    end
    local settings = Config.ColorPicker
    Popup.Open(self.Holder, function(container)
        self:BuildView(container)
    end, {
        Width = settings.Field + settings.Hue + Config.Widget.Alpha + Config.Gap.X * 2 + 60,
        Title = self.Row and self.Row.Info.Text or Lang.Strings.PickColor,
        OnClose = function()
            self.View = nil
        end,
    })
end

function WidgetHost:AddLabel(text, wrap)
    local info = type(text) == "table" and text.Text and text or { Text = text }
    local label = setmetatable({ Type = "Label", Container = self, Wrap = wrap }, Label)
    label.Row = Row.New(self, info, { Font = "Desc", Size = Util.TextSize("Label") - 1, Token = "SubText", MinHeight = Row.LineHeight() })
    label.Item = label.Row.Item
    if info.DependsOn then
        Widget.Depend(label, info.DependsOn)
    end
    return label
end

function Label:SetText(spec)
    self.Row:SetTitle(spec)
end

Label.SetVisible = Widget.SetVisible
Label.AddColorPicker = Widget.AddColorPicker
Label.AddKeyPicker = Widget.AddKeyPicker
Label.Flash = Widget.Flash

function WidgetHost:AddParagraph(info)
    info = Widget.Aliases(info or {})
    local paragraph = setmetatable({ Type = "Label", Container = self }, Label)
    paragraph.Row = Row.New(self, { Text = info.Text, Description = info.Description or "", Icon = info.Icon })
    paragraph.Item = paragraph.Row.Item
    if info.DependsOn then
        Widget.Depend(paragraph, info.DependsOn)
    end
    return paragraph
end

function Label:SetContent(spec)
    self.Row:SetDescription(spec)
end

function Label:SetTitle(spec)
    self.Row:SetTitle(spec)
end

function WidgetHost:AddDivider()
    Gui.Separator(self)
    return self
end

WidgetHost.Separator = WidgetHost.AddDivider

function WidgetHost:AddSeparatorText(spec)
    Gui.Separator(self, spec)
    return self
end

function WidgetHost:AddProgressBar(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local progress = setmetatable({ Type = "Progress", Value = 0, Max = info.Max or 1, Suffix = info.Suffix, Container = self, NoSave = true }, Progress)
    progress.Row = Row.New(self, info, { Control = Config.Widget.Progress })
    progress.Item = progress.Row.Item
    local bar = Draw.Box("Frame", { Name = "Bar", Size = UDim2.fromScale(1, 1), ZIndex = Config.Z.Body, Parent = progress.Row.Control }, "Track", "Outline", UDim.new(1, 0), 2)
    progress.Fill = Draw.Box("Frame", { Name = "Fill", Size = UDim2.fromScale(0, 1), ZIndex = Config.Z.Body, Parent = bar }, info.Token or "Good", nil, UDim.new(1, 0))
    Draw.Box("Frame", { Name = "Shine", Position = UDim2.new(0, 4, 0, 2), Size = UDim2.new(1, -8, 0.3, 0), BackgroundTransparency = Config.Widget.Shine, ZIndex = Config.Z.Detail, Parent = progress.Fill }, "White", nil, UDim.new(1, 0))
    progress.AsideLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Right, ZIndex = Config.Z.Detail, Parent = progress.Row.Aside }, "Strong", Util.TextSize("Label"), "SubText")
    Widget.Register(progress, idx, info)
    progress:SetValue(info.Default or info.Value or 0)
    return progress
end

function Progress:SetValue(value)
    self.Value = math.clamp(tonumber(value) or 0, 0, self.Max)
    local fraction = self.Max > 0 and self.Value / self.Max or 0
    Motion.Spring(self.Fill, "Size", UDim2.fromScale(fraction, 1), "Soft")
    local text = self.Suffix and (tostring(Util.Round(self.Value, 2)) .. Lang.Resolve(self.Suffix)) or (math.floor(fraction * 100 + 0.5) .. "%")
    self.AsideLabel.Text = text
    self.Row:SetAsideWidth(Layout.Measure(text, self.AsideLabel.TextSize, "Strong", 1000).X + 6)
end

function Progress:SetMax(max)
    self.Max = math.max(0, tonumber(max) or 1)
    self:SetValue(self.Value)
end

function Progress:SetText(spec)
    self.Row:SetTitle(spec)
end

Progress.SetVisible = Widget.SetVisible
Progress.OnChanged = Widget.OnChanged
Progress.Fire = Widget.Fire
Progress.Serialize = Widget.Serialize
Progress.Deserialize = Widget.Deserialize
Progress.SetDisabled = Widget.SetDisabled
Progress.Lock = Widget.Lock
Progress.ApplyBlocked = Widget.ApplyBlocked
Progress.IsBlocked = Widget.IsBlocked
Progress.Flash = Widget.Flash

function WidgetHost:AddSelectable(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local selectable = setmetatable({ Type = "Selectable", Value = info.Default == true or info.Selected == true, Container = self }, Selectable)
    local handle = Gui.Selectable(self, {
        Text = info.Text or "",
        Icon = info.Icon,
        Selected = selectable.Value,
        Width = info.Width,
        Callback = function()
            if not selectable:IsBlocked() then
                selectable:SetValue(not selectable.Value)
            end
        end,
    })
    selectable.Handle, selectable.Frame, selectable.Item = handle, handle.Frame, handle.Item
    handle.Item.Search = Row.SearchText(info)
    selectable:AddBinder(handle.Binder)
    Widget.Register(selectable, idx, info)
    return selectable
end

function Selectable:SetValue(value)
    value = value == true
    if value == self.Value then
        return
    end
    self.Value = value
    self.Handle:SetSelected(value)
    self:Fire()
end

---@param info table?  { Height = px (scrolls), Border = true, Id }
function WidgetHost:AddChild(info)
    info = info or {}
    local settings = Config.Widget.Child
    local bordered = info.Border ~= false
    local child = Gui.BeginChild(self, info.Id, {
        Height = info.Height,
        Scroll = info.Height ~= nil,
        PadX = settings.Pad,
        PadY = settings.Pad,
        Fill = bordered and "Element" or nil,
        Stroke = bordered and "Track" or nil,
        Radius = settings.Radius,
    })
    Gui.EndChild()
    if bordered and not info.Height then
        child.Frame.BackgroundTransparency = settings.Fill
    end
    return child
end

function WidgetHost:AddKeybind(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local row = Row.New(self, Widget.DefaultIcon(info, "Keybind"))
    return KeyPicker.New(row, idx, info, nil)
end

WidgetHost.AddKeyPicker = WidgetHost.AddKeybind

function WidgetHost:AddColorPicker(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local row = Row.New(self, Widget.DefaultIcon(info, "ColorPicker"))
    return ColorPicker.New(row, idx, info)
end

---@author xDTaraZ  Mario Hub UI V2
Config.Widget.Segment = { Damping = 0.72, Inset = 3 }
Config.Widget.Stepper = { Value = 54, Big = 10 }
Config.Widget.Chip = { Height = 28, TouchHeight = 44, PadX = 10, Gap = 6, Dot = 8, Depth = 2 }
Config.Widget.Priority = { Rank = 22, Handle = 28, Arrow = 44, Gap = 4 }
Config.Widget.Table = { Rows = 6, CellPad = 8 }
Config.Widget.Status = { Dot = 10, Halo = 18, Gap = 8, Tokens = {
    Idle = "Muted", Off = "Muted", Stopped = "Muted", Running = "Good", Active = "Good", On = "Good", Done = "Good",
    Busy = "Info", Travel = "Info", Waiting = "Warn", Warn = "Warn", Error = "Bad", Failed = "Bad",
} }
Config.Widget.Stat = { Size = 26, MinWindow = 10, Speed = 9 }
Config.Widget.Teleport = { Rows = 6, Chip = 30, TouchChip = 52, Pill = 40, ChipInset = 4 }
Config.Widget.Confirm = { Hold = 0.9, Style = "Danger" }

Lang.Strings.RunNow = { EN = "Run now", TH = "ทำเลย" }
Lang.Strings.Mode = { EN = "Mode", TH = "โหมด" }
Lang.Strings.HoldConfirm = { EN = "Hold to confirm", TH = "กดค้างเพื่อยืนยัน" }
Lang.Strings.Teleport = { EN = "TP", TH = "วาร์ป" }
Lang.Strings.PerHour = { EN = "%s/h", TH = "%s/ชม." }

---@return string  "Ink" or "White", whichever reads better on the color
function Widget.InkFor(color)
    local luminance = color.R * 0.299 + color.G * 0.587 + color.B * 0.114
    return luminance > 0.6 and "Ink" or "White"
end

---@return Frame holder, Frame face, Frame shade  small raised block with its own press sink
function Widget.SmallBlock(style, size, radius)
    local depth = Config.Widget.Chip.Depth
    local holder = Gui.Hitbox("Block")
    holder.Size = size
    local face, shade = Gui.BuildBlock(holder, style or "Default", depth, radius or 6)
    return holder, face, shade, depth
end

function Widget.SinkOnPress(face, depth)
    return function(pressed)
        Motion.Spring(face, "Position", UDim2.fromOffset(0, pressed and depth - 1 or 0), "Fast")
    end
end

Segmented.Spring = { Damping = Config.Widget.Segment.Damping }

function WidgetHost:AddSegmented(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local values = info.Values or {}
    local segmented = setmetatable({ Type = "Segmented", Values = values, Container = self, Segments = {} }, Segmented)
    segmented.Value = Widget.Canonical(values, info.Default) or values[1]
    local depth = Platform.Metric("Depth")
    segmented.Row = Row.New(self, info, { Control = Platform.Metric("Box") + depth })
    segmented.Item = segmented.Row.Item
    segmented.Depth = depth
    segmented:Build()
    segmented.Row.OnArranged = function(width)
        segmented:Arrange(width)
    end
    Widget.Register(segmented, idx, info)
    segmented:Paint(false)
    return segmented
end

function Segmented:Build()
    local control = self.Row.Control
    local radius = Platform.Metric("Radius")
    self.Track = Draw.Box("Frame", { Name = "Track", Size = UDim2.new(1, 0, 1, -self.Depth), BackgroundTransparency = 0, ZIndex = Config.Z.Body, Parent = control }, "Track", "Outline", radius, 2)
    local indicator = Draw.New("Frame", { Name = "Indicator", BackgroundTransparency = 1, ZIndex = Config.Z.Detail, Parent = control })
    self.Shade = Draw.Box("Frame", { Name = "Shade", Position = UDim2.fromOffset(0, self.Depth), Size = UDim2.fromScale(1, 1), ZIndex = Config.Z.Detail, Parent = indicator }, "AccentDark", "Outline", radius - 2, 2)
    self.Face = Draw.Box("Frame", { Name = "Face", Size = UDim2.fromScale(1, 1), ZIndex = Config.Z.Raised, Parent = indicator }, "Accent", "Outline", radius - 2, 2)
    self.Indicator = indicator
    self:BuildSegments()
end

function Segmented:BuildSegments()
    for _, segment in ipairs(self.Segments) do
        segment.Binder:Disconnect()
        segment.Hit:Destroy()
    end
    table.clear(self.Segments)
    for index, value in ipairs(self.Values) do
        local hit = Gui.Hitbox("Segment")
        hit.ZIndex = Config.Z.Top
        hit.Parent = self.Row.Control
        local label = Draw.Text({ Size = UDim2.new(1, 0, 1, -self.Depth), TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = Config.Z.Top, Parent = hit }, "Body", Util.TextSize("Label"), "SubText", value)
        local segment = { Hit = hit, Label = label, Value = value }
        segment.Binder = self:AddBinder(Gui.Clickable(hit, {
            OnClick = function(input)
                Motion.Ripple(self.Track, input.Position)
                self:SetValue(value)
            end,
        }))
        self.Segments[index] = segment
    end
end

function Segmented:Arrange(width)
    local count = math.max(1, #self.Segments)
    local segmentWidth = width / count
    local height = Platform.Metric("Box")
    for index, segment in ipairs(self.Segments) do
        segment.Hit.Position = UDim2.fromOffset(math.floor((index - 1) * segmentWidth), 0)
        segment.Hit.Size = UDim2.fromOffset(math.floor(segmentWidth), height + self.Depth)
    end
    self.SegmentWidth = segmentWidth
    self:Place(false)
end

function Segmented:Place(animate)
    local index = Widget.IndexOf(self.Values, self.Value)
    local width = self.SegmentWidth
    if not width then
        return
    end
    local inset = Config.Widget.Segment.Inset
    local height = Platform.Metric("Box") - inset * 2
    self.Indicator.Visible = index ~= nil
    if not index then
        return
    end
    local position = UDim2.fromOffset(math.floor((index - 1) * width) + inset, inset)
    local size = UDim2.fromOffset(math.floor(width) - inset * 2, height)
    if animate then
        Motion.Spring(self.Indicator, "Position", position, "Fast", Segmented.Spring)
        Motion.Spring(self.Indicator, "Size", size, "Fast", Segmented.Spring)
    else
        Motion.Set(self.Indicator, "Position", position)
        Motion.Set(self.Indicator, "Size", size)
    end
end

function Segmented:Paint(animate)
    for _, segment in ipairs(self.Segments) do
        Widget.Paint(segment, segment.Label, "TextColor3", segment.Value == self.Value and "AccentText" or "SubText", animate)
    end
end

function Segmented:SetValue(value)
    local entry = Widget.Canonical(self.Values, value)
    if entry == nil or Widget.Key(entry) == Widget.Key(self.Value) then
        return
    end
    self.Value = entry
    self:Place(true)
    self:Paint(true)
    self:Fire()
end

function Segmented:SetValues(values)
    self.Values = values or {}
    local previous = self.Value
    self.Value = Widget.Canonical(self.Values, previous) or self.Values[1]
    self:BuildSegments()
    self.Container:MarkDirty()
    self:Paint(false)
    if Widget.Key(self.Value) ~= Widget.Key(previous) then
        self:Fire()
    end
end

function Segmented:Serialize()
    return Widget.Key(self.Value)
end

function WidgetHost:AddStepper(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local stepper = setmetatable({
        Type = "Stepper",
        Step = info.Step or 1,
        Rounding = info.Rounding or Slider.Decimals(info.Step),
        Prefix = info.Prefix or "",
        Suffix = info.Suffix or "",
        Container = self,
    }, Stepper)
    stepper.Min, stepper.Max = Slider.Bounds(info.Min, info.Max)
    stepper.Value = stepper:Quantize(tonumber(info.Default) or stepper.Min)
    stepper.Row = Row.New(self, info)
    stepper.Item = stepper.Row.Item
    stepper:Build()
    Widget.Register(stepper, idx, info)
    stepper:Render(false)
    return stepper
end

Stepper.Quantize = Slider.Quantize
Stepper.Format = Slider.Format

function Stepper:Build()
    local settings = Config.Widget.Stepper
    local height = Platform.Metric("Control")
    local size = math.max(Platform.Metric("Stepper"), height)
    local holder = Draw.New("Frame", { Name = "Stepper", BackgroundTransparency = 1, Size = UDim2.fromOffset(size * 2 + settings.Value, height + Config.Widget.Chip.Depth) })
    self.Minus = self:BuildButton(holder, "−", -1, UDim2.fromOffset(0, 0), size, height)
    self.Plus = self:BuildButton(holder, "+", 1, UDim2.fromOffset(size + settings.Value, 0), size, height)
    self.Box = Draw.Text({
        ClassName = "TextBox",
        Name = "Value",
        ClearTextOnFocus = false,
        Position = UDim2.fromOffset(size, 0),
        Size = UDim2.fromOffset(settings.Value, height),
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = Config.Z.Raised,
        Parent = holder,
    }, "Strong", Util.TextSize("Label"), "Accent")
    self.Box.FocusLost:Connect(function()
        local typed = tonumber(self.Box.Text)
        if typed and not self:IsBlocked() then
            self:SetValue(typed)
        end
        self:Render(false)
    end)
    self.Row:AddRight(holder, size * 2 + settings.Value)
end

function Stepper:BuildButton(parent, glyph, direction, position, size, height)
    local holder, face, _, depth = Widget.SmallBlock("Default", UDim2.fromOffset(size, height + Config.Widget.Chip.Depth))
    holder.Position = position
    holder.AnchorPoint = Vector2.zero
    holder.ZIndex = Config.Z.Raised
    holder.Parent = parent
    Draw.Text({ Text = glyph, Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = face.ZIndex + 1, Parent = face }, "Glyph", Util.TextSize("Header"), "Text")
    self:AddBinder(Gui.Clickable(holder, {
        OnPress = Widget.SinkOnPress(face, depth),
        OnClick = function(input)
            Motion.Ripple(face, input.Position)
            self:Nudge(direction)
        end,
        OnLongPress = function()
            self:Nudge(direction * Config.Widget.Stepper.Big)
        end,
    }))
    return face
end

function Stepper:Nudge(steps)
    local before = self.Value
    self:SetValue(self.Value + self.Step * steps)
    if self.Value == before then
        Motion.Shake(steps > 0 and self.Plus or self.Minus)
    end
end

function Stepper:Render(animate)
    if not self.Box:IsFocused() then
        self.Box.Text = self:Format()
    end
    if animate then
        Motion.Pop(self.Box)
    end
    Widget.Paint(self, self.Minus, "BackgroundColor3", self.Value <= self.Min and "Pressed" or "Element", animate)
    Widget.Paint(self, self.Plus, "BackgroundColor3", self.Value >= self.Max and "Pressed" or "Element", animate)
end

function Stepper:SetValue(value)
    value = tonumber(value)
    if not value then
        return
    end
    value = self:Quantize(value)
    if value == self.Value then
        return
    end
    self.Value = value
    self:Render(true)
    self:Fire()
end

function WidgetHost:AddRangeSlider(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local knob = Platform.Metric("Knob")
    local range = setmetatable({
        Type = "RangeSlider",
        Step = info.Step,
        Rounding = info.Rounding or Slider.Decimals(info.Step),
        Prefix = info.Prefix or "",
        Suffix = info.Suffix or "",
        FinishedOnly = info.Finished == true,
        Container = self,
        Knobs = {},
        CloneOnFire = true,
    }, RangeSlider)
    range.Min, range.Max = Slider.Bounds(info.Min, info.Max)
    local default = type(info.Default) == "table" and info.Default or {}
    range.Value = { range:Quantize(default[1] or default.Min or range.Min), range:Quantize(default[2] or default.Max or range.Max) }
    range.Row = Row.New(self, info, { Control = knob + Config.Widget.Knob.Shade + 4 })
    range.Item = range.Row.Item
    range:Build(knob)
    Widget.Register(range, idx, info)
    range:MeasureAside()
    range:Render(false)
    return range
end

RangeSlider.Quantize = Slider.Quantize
RangeSlider.Format = Slider.Format

function RangeSlider:Build(knob)
    local control = self.Row.Control
    local depth = Config.Widget.Knob.Shade
    local track = Draw.Box("Frame", {
        Name = "Track",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, knob / 2, 0.5, -depth / 2),
        Size = UDim2.new(1, -knob, 0, Platform.Metric("Track")),
        ZIndex = Config.Z.Body,
        Parent = control,
    }, "Track", "Outline", UDim.new(1, 0), 2)
    self.Fill = Draw.Box("Frame", { Name = "Fill", ZIndex = Config.Z.Body, Parent = track }, "Accent", nil, UDim.new(1, 0))
    self.Track = track
    for index = 1, 2 do
        local holder = Draw.New("Frame", { Name = "Knob" .. index, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(knob, knob), ZIndex = Config.Z.Raised, Parent = track })
        Draw.Box("Frame", { Name = "Shade", Position = UDim2.fromOffset(0, depth), Size = UDim2.fromScale(1, 1), ZIndex = Config.Z.Raised, Parent = holder }, "CoinDark", "Outline", UDim.new(1, 0), 2)
        Draw.Box("Frame", { Name = "Face", Size = UDim2.fromScale(1, 1), ZIndex = Config.Z.Top, Parent = holder }, "Coin", "Outline", UDim.new(1, 0), 2)
        self.Knobs[index] = { Frame = holder, Scale = Draw.New("UIScale", { Parent = holder }) }
    end
    self.ValueLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Right, ZIndex = Config.Z.Detail, Parent = self.Row.Aside }, "Strong", Util.TextSize("Label"), "Accent")
    local hit = Gui.Hitbox("Hit")
    hit.Position = UDim2.fromOffset(0, -Config.Widget.Slider.Slop)
    hit.Size = UDim2.new(1, 0, 1, Config.Widget.Slider.Slop * 2)
    hit.ZIndex = Config.Z.Hit
    hit.Parent = control
    hit.InputBegan:Connect(function(input)
        if Util.IsPointer(input) then
            self:BeginDrag(input)
        end
    end)
end

function RangeSlider:Fraction(value)
    local span = self.Max - self.Min
    return span > 0 and (value - self.Min) / span or 0
end

function RangeSlider:ValueAt(screenX)
    local left, width = self.Track.AbsolutePosition.X, self.Track.AbsoluteSize.X
    local fraction = width > 0 and math.clamp((screenX - left) / width, 0, 1) or 0
    return self.Min + (self.Max - self.Min) * fraction
end

function RangeSlider:BeginDrag(input)
    if self:IsBlocked() then
        return
    end
    local value = self:ValueAt(input.Position.X)
    local low, high = self.Value[1], self.Value[2]
    local grabHigh = math.abs(value - high) < math.abs(value - low) or (low == high and value > high)
    self.Active = grabHigh and 2 or 1
    self.Dragging = true
    Motion.Spring(self.Knobs[self.Active].Scale, "Scale", Config.Widget.Slider.Grab, "Fast", Slider.GrabSpring)
    Widget.BeginDrag(input, self, self.Row.Holder)
    self:OnDrag(input.Position)
end

function RangeSlider:OnDrag(position)
    local value = self:Quantize(self:ValueAt(position.X))
    local low, high = self.Value[1], self.Value[2]
    if self.Active == 1 then
        low = math.min(value, high)
    else
        high = math.max(value, low)
    end
    self:SetValue({ low, high })
end

function RangeSlider:OnDragEnd()
    if self.Active then
        Motion.Spring(self.Knobs[self.Active].Scale, "Scale", 1, "Fast", Slider.GrabSpring)
    end
    self.Dragging, self.Active = false, nil
    if self.PendingFire then
        self.PendingFire = false
        self:Fire()
    end
end

function RangeSlider:Text()
    return self:Format(self.Value[1]) .. " – " .. self:Format(self.Value[2])
end

function RangeSlider:MeasureAside()
    local size = self.ValueLabel.TextSize
    local widest = Layout.Measure(self:Format(self.Max) .. " – " .. self:Format(self.Max), size, "Strong", 1000).X
    self.Row:SetAsideWidth(widest + 6)
end

function RangeSlider:Render(animate)
    local low, high = self:Fraction(self.Value[1]), self:Fraction(self.Value[2])
    local speed = self.Dragging and "Fast" or "Normal"
    local targets = {
        { self.Fill, "Position", UDim2.fromScale(low, 0) },
        { self.Fill, "Size", UDim2.fromScale(high - low, 1) },
        { self.Knobs[1].Frame, "Position", UDim2.fromScale(low, 0.5) },
        { self.Knobs[2].Frame, "Position", UDim2.fromScale(high, 0.5) },
    }
    for _, target in ipairs(targets) do
        if animate then
            Motion.Spring(target[1], target[2], target[3], speed)
        else
            Motion.Set(target[1], target[2], target[3])
        end
    end
    self.ValueLabel.Text = self:Text()
end

function RangeSlider:SetValue(value)
    if type(value) ~= "table" then
        return
    end
    local low = self:Quantize(tonumber(value[1] or value.Min) or self.Min)
    local high = self:Quantize(tonumber(value[2] or value.Max) or self.Max)
    low, high = math.min(low, high), math.max(low, high)
    if low == self.Value[1] and high == self.Value[2] then
        return
    end
    self.Value = { low, high }
    self:Render(true)
    if self.FinishedOnly and self.Dragging then
        self.PendingFire = true
        return
    end
    self:Fire()
end

function RangeSlider:Serialize()
    return { self.Value[1], self.Value[2] }
end

function WidgetHost:AddMultiChips(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local chips = setmetatable({
        Type = "MultiChips",
        Multi = true,
        Values = info.Values or {},
        Colors = info.Colors or {},
        Max = info.Max,
        Container = self,
        Chips = {},
    }, MultiChips)
    chips.Value = Widget.SelectSet(chips.Values, info.Default, chips.Max)
    chips.Row = Row.New(self, info, { Control = MultiChips.ChipHeight() })
    chips.Item = chips.Row.Item
    chips.Row.MeasureControl = function(width)
        return chips:Flow(width, false)
    end
    chips.Row.OnArranged = function(width)
        chips:Flow(width, true)
    end
    chips:BuildBulk()
    chips:BuildChips()
    Widget.Register(chips, idx, info)
    chips:Paint(false)
    return chips
end

MultiChips.IsSelected = Dropdown.IsSelected
MultiChips.GetActiveValues = Dropdown.GetActiveValues
MultiChips.Serialize = Dropdown.Serialize

function MultiChips:BuildBulk()
    local aside = self.Row.Aside
    self.BulkLinks = {}
    for _, mode in ipairs({ "All", "None" }) do
        local link = Draw.Text({ ClassName = "TextButton", Name = mode, AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0), TextXAlignment = Enum.TextXAlignment.Right, ZIndex = Config.Z.Detail, Parent = aside }, "Strong", Util.TextSize("Small"), "Accent", Lang.Strings[mode])
        table.insert(self.BulkLinks, { link, Lang.Strings[mode] })
        self:AddBinder(Gui.Clickable(link, {
            OnClick = function()
                Motion.Pop(link)
                self:SetValue(mode == "All" and self:Capped(self.Values) or {})
            end,
        }))
    end
    self:SizeBulk()
    Lang.OnChange(self, function()
        self:SizeBulk()
    end)
end

---Re-measures the All / None links, since their words change width with the language.
function MultiChips:SizeBulk()
    local size = Util.TextSize("Small")
    local width = 0
    for index, pair in ipairs(self.BulkLinks) do
        local link, spec = pair[1], pair[2]
        local linkWidth = math.max(Gui.TextWidth(spec, size, "Strong") + 8, Platform.TouchMin())
        link.Position = UDim2.new(1, -width, 0, 0)
        link.Size = UDim2.new(0, linkWidth, 1, 0)
        width += linkWidth + (index == 1 and 4 or 0)
    end
    self.Row:SetAsideWidth(width)
end

function MultiChips:Capped(values)
    if not self.Max then
        return values
    end
    local capped = {}
    for index = 1, math.min(#values, self.Max) do
        capped[index] = values[index]
    end
    return capped
end

function MultiChips:BuildChips()
    for _, chip in pairs(self.Chips) do
        chip.Binder:Disconnect()
        chip.Holder:Destroy()
    end
    table.clear(self.Chips)
    local settings = Config.Widget.Chip
    for _, value in ipairs(self.Values) do
        local holder, face, shade, depth = Widget.SmallBlock("Default", UDim2.fromOffset(0, MultiChips.ChipHeight()), UDim.new(1, 0))
        holder.ZIndex = Config.Z.Detail
        holder.Parent = self.Row.Control
        Theme.Unbind(face)
        Theme.Unbind(shade)
        local dot = Draw.Box("Frame", { Name = "Dot", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, settings.PadX, 0.5, 0), Size = UDim2.fromOffset(settings.Dot, settings.Dot), BackgroundTransparency = 0, ZIndex = face.ZIndex + 1, Parent = face }, nil, "Outline", UDim.new(1, 0), 1)
        local textX = settings.PadX + settings.Dot + 6
        local label = Draw.Text({ Position = UDim2.fromOffset(textX, 0), Size = UDim2.new(1, -textX - settings.PadX, 1, 0), ZIndex = face.ZIndex + 1, Parent = face }, "Body", Util.TextSize("Small") + 1, "Text", value)
        local chip = { Holder = holder, Face = face, Shade = shade, Dot = dot, Label = label, Value = value, TextX = textX }
        chip.Binder = self:AddBinder(Gui.Clickable(holder, {
            OnPress = Widget.SinkOnPress(face, depth),
            OnClick = function()
                self:Pick(value, chip)
            end,
        }))
        self.Chips[value] = chip
    end
    self.Container:MarkDirty()
end

---@return number  chip height, taller for fingers
function MultiChips.ChipHeight()
    local settings = Config.Widget.Chip
    return Platform.Touch and settings.TouchHeight or settings.Height
end

---@param apply boolean  false = measure only
---@return number        control height for the wrapped chips
function MultiChips:Flow(width, apply)
    local settings = Config.Widget.Chip
    local height = MultiChips.ChipHeight()
    local size = Util.TextSize("Small") + 1
    local x, y = 0, 0
    for _, value in ipairs(self.Values) do
        local chip = self.Chips[value]
        if not chip then
            continue
        end
        local chipWidth = math.min(width, math.max(Gui.TextWidth(value, size, "Body") + chip.TextX + settings.PadX, Platform.TouchMin()))
        if x > 0 and x + chipWidth > width then
            x, y = 0, y + height + settings.Gap
        end
        if apply then
            chip.Holder.Position = UDim2.fromOffset(x, y)
            chip.Holder.Size = UDim2.fromOffset(chipWidth, height)
        end
        x += chipWidth + settings.Gap
    end
    return y + height
end

function MultiChips:ColorOf(value)
    local color = self.Colors[value]
    if typeof(color) == "Color3" then
        return color
    end
    return Theme.Color(type(color) == "string" and color or "Accent")
end

function MultiChips:PaintChip(chip, animate)
    local on = self.Value[chip.Value] == true
    local color = self:ColorOf(chip.Value)
    local face = on and color or Theme.Color("Element")
    local speed = animate and "Fast" or nil
    for _, target in ipairs({ { chip.Face, face }, { chip.Shade, on and color:Lerp(Theme.Color("Black"), 0.25) or Theme.Color("Pressed") }, { chip.Dot, on and Theme.Color("White") or color } }) do
        if speed then
            Motion.Spring(target[1], "BackgroundColor3", target[2], speed)
        else
            Motion.Set(target[1], "BackgroundColor3", target[2])
        end
    end
    Widget.Paint(chip, chip.Label, "TextColor3", on and Widget.InkFor(color) or "Text", animate)
end

function MultiChips:Paint(animate)
    for _, chip in pairs(self.Chips) do
        self:PaintChip(chip, animate)
    end
    if not self.Themed then
        self.Themed = true
        Theme.OnRender(self, function()
            self:Paint(false)
        end)
    end
end

function MultiChips:Pick(value, chip)
    if not self.Value[value] and self.Max and #self:GetActiveValues() >= self.Max then
        Motion.Shake(chip.Face)
        return
    end
    self.Value[value] = not self.Value[value] or nil
    self:PaintChip(chip, true)
    if self.Value[value] then
        Motion.Pop(chip.Holder)
    end
    self:Fire()
end

function MultiChips:SetValue(value)
    local picked = Widget.SelectSet(self.Values, value, self.Max)
    if Widget.SameSet(picked, self.Value) then
        return
    end
    self.Value = picked
    self:Paint(true)
    self:Fire()
end

---Picks missing from the new Values are dropped (fires when that changes the selection).
function MultiChips:SetValues(values, colors)
    local previous = self.Value
    self.Values = values or {}
    self.Colors = colors or self.Colors
    self.Value = Widget.SelectSet(self.Values, Widget.KeysOf(previous), self.Max)
    self:BuildChips()
    self:Paint(false)
    if not Widget.SameSet(previous, self.Value) then
        self:Fire()
    end
end

PriorityList.Spring = { Damping = 0.8 }

function WidgetHost:AddPriorityList(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local list = setmetatable({ Type = "PriorityList", Container = self, Entries = {}, Values = info.Values or {}, CloneOnFire = true }, PriorityList)
    list.Value = list:Normalize(info.Default or list.Values)
    list.Row = Row.New(self, info, { Control = 0 })
    list.Item = list.Row.Item
    list.Row.MeasureControl = function()
        return #list.Value * list:Step() - Config.Widget.Priority.Gap
    end
    list.Row.OnArranged = function()
        list:PlaceAll(false)
    end
    list:BuildEntries()
    Widget.Register(list, idx, info)
    return list
end

---@return table  Values entries in the given order (matched by key), unknown dropped, missing appended
function PriorityList:Normalize(order)
    local result, seen = {}, {}
    for _, value in ipairs(type(order) == "table" and order or {}) do
        local entry = Widget.Canonical(self.Values, value)
        local key = Widget.Key(entry)
        if entry ~= nil and not seen[key] then
            seen[key] = true
            result[#result + 1] = entry
        end
    end
    for _, entry in ipairs(self.Values) do
        if not seen[Widget.Key(entry)] then
            seen[Widget.Key(entry)] = true
            result[#result + 1] = entry
        end
    end
    return result
end

function PriorityList:Step()
    return PriorityList.EntryHeight() + Config.Widget.Priority.Gap
end

---@return number  row height; on touch the face minus its shade still fits a full finger-size arrow
function PriorityList.EntryHeight()
    return math.max(Platform.Metric("Item"), Platform.TouchMin() + Config.Widget.Chip.Depth + 2)
end

function PriorityList:BuildEntries()
    for _, entry in pairs(self.Entries) do
        entry.Holder:Destroy()
    end
    table.clear(self.Entries)
    for _, value in ipairs(self.Values) do
        self.Entries[value] = self:BuildEntry(value)
    end
    self.Container:MarkDirty()
end

function PriorityList:BuildEntry(value)
    local settings = Config.Widget.Priority
    local height = PriorityList.EntryHeight()
    local holder, face = Widget.SmallBlock("Default", UDim2.new(1, 0, 0, height))
    holder.ZIndex = Config.Z.Detail
    holder.Parent = self.Row.Control
    local rank = Draw.Box("Frame", { Name = "Rank", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, -1), Size = UDim2.fromOffset(settings.Rank, settings.Rank), ZIndex = face.ZIndex + 1, Parent = face }, "Coin", "Outline", UDim.new(1, 0), 1)
    local rankLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = rank.ZIndex + 1, Parent = rank }, "Strong", Config.Widget.Badge.Size, "Ink")
    local controls = Platform.Touch and settings.Arrow * 2 + 4 or settings.Handle
    local textX = settings.Rank + 14
    Draw.Text({ Position = UDim2.fromOffset(textX, 0), Size = UDim2.new(1, -textX - controls - 6, 1, -2), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = face.ZIndex + 1, Parent = face }, "Body", Util.TextSize("Label"), "Text", value)
    local entry = { Holder = holder, Face = face, RankLabel = rankLabel, Value = value }
    if Platform.Touch then
        self:BuildArrows(entry, face)
    else
        self:BuildHandle(entry, face)
    end
    return entry
end

function PriorityList:BuildHandle(entry, face)
    local settings = Config.Widget.Priority
    local handle = Draw.Text({ ClassName = "TextButton", Name = "Handle", Text = "≡", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, settings.Handle, 1, -2), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = face.ZIndex + 2, Parent = face }, "Glyph", Util.TextSize("Header"), "Muted")
    handle.InputBegan:Connect(function(input)
        if Util.IsPointer(input) and not self:IsBlocked() then
            self:BeginDrag(input, entry)
        end
    end)
    handle.MouseEnter:Connect(function()
        Widget.Paint(entry, handle, "TextColor3", "Accent", true)
    end)
    handle.MouseLeave:Connect(function()
        Widget.Paint(entry, handle, "TextColor3", "Muted", true)
    end)
end

function PriorityList:BuildArrows(entry, face)
    local settings = Config.Widget.Priority
    for index, glyph in ipairs({ "▲", "▼" }) do
        local arrow = Draw.Text({ ClassName = "TextButton", Name = glyph, Text = glyph, AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -(2 - index) * (settings.Arrow + 4), 0, 0), Size = UDim2.new(0, settings.Arrow, 1, -2), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = face.ZIndex + 2, Parent = face }, "Glyph", Util.TextSize("Small"), "SubText")
        self:AddBinder(Gui.Clickable(arrow, {
            OnClick = function()
                self:Move(entry.Value, index == 1 and -1 or 1)
            end,
        }))
    end
end

function PriorityList:PlaceAll(animate, skip)
    local step = self:Step()
    for index, value in ipairs(self.Value) do
        local entry = self.Entries[value]
        if entry and entry ~= skip then
            entry.RankLabel.Text = tostring(index)
            local position = UDim2.fromOffset(0, (index - 1) * step)
            if animate then
                Motion.Spring(entry.Holder, "Position", position, "Fast", PriorityList.Spring)
            else
                Motion.Set(entry.Holder, "Position", position)
            end
        end
    end
end

function PriorityList:Move(value, offset)
    local from = Widget.IndexOf(self.Value, value)
    if not from then
        return
    end
    local to = math.clamp(from + offset, 1, #self.Value)
    if to == from then
        Motion.Shake(self.Entries[value].Face)
        return
    end
    table.remove(self.Value, from)
    table.insert(self.Value, to, value)
    self:PlaceAll(true)
    Motion.Pop(self.Entries[value].Holder)
    self:Fire()
end

function PriorityList:BeginDrag(input, entry)
    self.DragEntry = entry
    self.DragStart = Widget.IndexOf(self.Value, entry.Value)
    self.GrabOffset = input.Position.Y - entry.Holder.AbsolutePosition.Y
    entry.Holder.ZIndex = Config.Z.Top
    Motion.Pop(entry.Holder)
    Widget.BeginDrag(input, self, self.Row.Holder)
end

function PriorityList:OnDrag(position)
    local entry = self.DragEntry
    if not entry then
        return
    end
    local step = self:Step()
    local top = self.Row.Control.AbsolutePosition.Y
    local y = math.clamp(position.Y - top - self.GrabOffset, 0, (#self.Value - 1) * step)
    Motion.Set(entry.Holder, "Position", UDim2.fromOffset(0, y))
    local slot = math.clamp(math.floor(y / step + 0.5) + 1, 1, #self.Value)
    local current = Widget.IndexOf(self.Value, entry.Value)
    if slot ~= current then
        table.remove(self.Value, current)
        table.insert(self.Value, slot, entry.Value)
        self:PlaceAll(true, entry)
    end
end

function PriorityList:OnDragEnd()
    local entry = self.DragEntry
    if not entry then
        return
    end
    self.DragEntry = nil
    entry.Holder.ZIndex = Config.Z.Detail
    self:PlaceAll(true)
    if Widget.IndexOf(self.Value, entry.Value) ~= self.DragStart then
        self:Fire()
    end
end

function PriorityList:SetValue(order)
    local normalized = self:Normalize(order)
    if Widget.SameOrder(normalized, self.Value) then
        return
    end
    self.Value = normalized
    self:PlaceAll(true)
    self:Fire()
end

function PriorityList:SetValues(values)
    local previous = self.Value
    self.Values = values or {}
    self.Value = self:Normalize(previous)
    self:BuildEntries()
    self:PlaceAll(false)
    if not Widget.SameOrder(previous, self.Value) then
        self:Fire()
    end
end

function PriorityList:Serialize()
    local keys = {}
    for index, entry in ipairs(self.Value) do
        keys[index] = Widget.Key(entry)
    end
    return keys
end

---@param info table  { Text, Columns = { { Key, Text, Width, Align, Format(value, row) } }, Rows, Sort = { Key, Desc }, Height = rows, OnSelect(row) }
function WidgetHost:AddTable(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local settings = Config.Widget.Table
    local columns = Table.NormalizeColumns(info.Columns)
    local sort = type(info.Sort) == "table" and info.Sort or (info.Sort == true and columns[1] and { columns[1].Key }) or nil
    local grid = setmetatable({
        Type = "Table",
        Columns = columns,
        Rows = info.Rows or {},
        View = {},
        SortKey = sort and (sort.Key or sort[1]),
        SortDesc = sort ~= nil and (sort.Desc or sort[2]) == true,
        Container = self,
        NoSave = true,
        Widths = {},
        Offsets = {},
    }, Table)
    local rows = info.Height or settings.Rows
    local list = Config.Widget.List
    local listHeight = rows * (Platform.Metric("Item") + list.Gap) - list.Gap + list.Pad * 2
    grid.Row = Row.New(self, info, { Control = Platform.Metric("TableHeader") + 4 + listHeight })
    grid.Item = grid.Row.Item
    grid.OnSelect = info.OnSelect
    grid:BuildHeader()
    grid:BuildBody(rows)
    grid.Row.OnArranged = function(width)
        grid:Arrange(width)
    end
    Widget.Register(grid, idx, info)
    grid:Sort()
    return grid
end

---@param columns table?  column specs; a plain string or T() spec becomes { Key = index, Text = spec }
---@return table
function Table.NormalizeColumns(columns)
    local normalized = {}
    for index, column in ipairs(columns or {}) do
        local shorthand = type(column) ~= "table" or column.EN ~= nil or column.TH ~= nil
        normalized[index] = shorthand and { Key = index, Text = column } or column
    end
    return normalized
end

function Table:BuildHeader()
    local header = Draw.New("Frame", { Name = "Header", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Platform.Metric("TableHeader")), ZIndex = Config.Z.Body, Parent = self.Row.Control })
    self.HeaderCells = {}
    for index, column in ipairs(self.Columns) do
        local cell = Draw.Text({ ClassName = "TextButton", Name = "Column", AutoButtonColor = false, TextXAlignment = column.Align or Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = Config.Z.Detail, Parent = header }, "Strong", Util.TextSize("Small"), "Muted")
        self.HeaderCells[index] = cell
        Gui.Clickable(cell, {
            OnClick = function()
                self:SetSort(column.Key, self.SortKey == column.Key and not self.SortDesc)
            end,
        })
    end
    self.Header = header
    self:PaintHeader()
    Lang.OnChange(self, function()
        self:PaintHeader()
    end)
end

function Table:PaintHeader()
    for index, column in ipairs(self.Columns) do
        local cell = self.HeaderCells[index]
        local sorted = column.Key == self.SortKey
        local arrow = sorted and (self.SortDesc and " ▼" or " ▲") or ""
        cell.Text = string.upper(Lang.Resolve(column.Text or column.Key)) .. arrow
        Widget.Paint(cell, cell, "TextColor3", sorted and "Accent" or "Muted", true)
    end
end

function Table:BuildBody(rows)
    local body = Draw.New("Frame", { Name = "Body", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, Platform.Metric("TableHeader") + 4), Size = UDim2.new(1, 0, 1, -Platform.Metric("TableHeader") - 4), ZIndex = Config.Z.Body, Parent = self.Row.Control })
    self.List = Gui.VirtualList(nil, {
        Parent = body,
        RowHeight = Platform.Metric("Item"),
        Rows = rows,
        Count = function()
            return #self.View
        end,
        Make = function()
            return self:MakeRow()
        end,
        Render = function(parts, index)
            self:RenderRow(parts, index)
        end,
        OnClick = function(index)
            if self.OnSelect and self.View[index] then
                Util.Try(self.OnSelect, self.View[index])
            end
        end,
    })
end

function Table:MakeRow()
    local frame = Draw.Box("TextButton", { Name = "Row", BackgroundTransparency = 1 }, "Hover", nil, Platform.Metric("Radius") - 2)
    local parts = { Frame = frame, Cells = {}, Label = nil }
    for index, column in ipairs(self.Columns) do
        parts.Cells[index] = Draw.Text({ Name = "Cell", TextXAlignment = column.Align or Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = frame }, index == 1 and "Body" or "Desc", Util.TextSize("Label") - (index == 1 and 0 or 1), index == 1 and "Text" or "SubText")
    end
    return parts
end

function Table:Arrange(width)
    local settings = Config.Widget.Table
    local fixed, flexible, shares = 0, 0, 0
    local available = width - Config.Page.ScrollBar - Config.Widget.List.Pad * 2
    for _, column in ipairs(self.Columns) do
        local spec = column.Width
        if type(spec) == "number" and spec > 1 then
            fixed += spec
        else
            flexible += 1
            shares += type(spec) == "number" and spec or 1 / math.max(1, #self.Columns)
        end
    end
    local remaining = math.max(0, available - fixed)
    local x = Config.Widget.List.Pad
    for index, column in ipairs(self.Columns) do
        local spec = column.Width
        local cellWidth = (type(spec) == "number" and spec > 1) and spec or remaining * ((type(spec) == "number" and spec or 1 / math.max(1, #self.Columns)) / math.max(shares, 0.0001))
        self.Offsets[index], self.Widths[index] = x, math.floor(cellWidth)
        local cell = self.HeaderCells[index]
        cell.Position = UDim2.fromOffset(x + settings.CellPad, 0)
        cell.Size = UDim2.new(0, math.max(0, cellWidth - settings.CellPad * 2), 1, 0)
        x += cellWidth
    end
    self.List:Refresh(true)
end

function Table:RenderRow(parts, index)
    local entry = self.View[index]
    local pad = Config.Widget.Table.CellPad
    for column, cell in ipairs(parts.Cells) do
        local spec = self.Columns[column]
        local raw = entry and entry[spec.Key]
        local text = spec.Format and spec.Format(raw, entry) or raw
        cell.Text = Lang.Resolve(text)
        cell.Position = UDim2.fromOffset((self.Offsets[column] or 0) - Config.Widget.List.Pad + pad, 0)
        cell.Size = UDim2.new(0, math.max(0, (self.Widths[column] or 0) - pad * 2), 1, 0)
    end
end

function Table:Sort()
    local view = self.View
    table.clear(view)
    for index, entry in ipairs(self.Rows) do
        view[index] = entry
    end
    local key, desc = self.SortKey, self.SortDesc
    if key then
        table.sort(view, function(left, right)
            local a, b = left[key], right[key]
            if type(a) ~= type(b) then
                a, b = tostring(a), tostring(b)
            end
            if a == b then
                return false
            end
            if desc then
                return a > b
            end
            return a < b
        end)
    end
    self.List:Refresh(true)
end

function Table:SetSort(key, desc)
    self.SortKey, self.SortDesc = key, desc == true
    self:PaintHeader()
    self:Sort()
end

function Table:SetRows(rows)
    self.Rows = rows or {}
    self.Value = self.Rows
    self:Sort()
end

Table.SetValue = Table.SetRows

function Table:Serialize()
    return nil
end

function WidgetHost:AddStatus(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local status = setmetatable({ Type = "Status", Container = self, NoSave = true, Value = "" }, Status)
    status.Row = Row.New(self, info)
    status.Item = status.Row.Item
    local settings = Config.Widget.Status
    local holder = Draw.New("Frame", { Name = "Status", BackgroundTransparency = 1, Size = UDim2.fromOffset(settings.Halo, Platform.Metric("Item")) })
    status.Halo = Draw.Box("Frame", { Name = "Halo", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(settings.Halo, settings.Halo), BackgroundTransparency = 0.7, ZIndex = Config.Z.Detail, Parent = holder }, nil, nil, UDim.new(1, 0))
    status.Dot = Draw.Box("Frame", { Name = "Dot", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(settings.Dot, settings.Dot), BackgroundTransparency = 0, ZIndex = Config.Z.Raised, Parent = status.Halo }, nil, "Outline", UDim.new(1, 0), 1)
    status.Label = Draw.Text({ AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -settings.Halo - settings.Gap, 0, 0), Size = UDim2.new(0, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Right, ZIndex = Config.Z.Detail, Parent = holder }, "Strong", Util.TextSize("Label"), "Text")
    status.Holder = holder
    status.Row:AddRight(holder, settings.Halo)
    Widget.Register(status, idx, info)
    local default = info.Default
    status:SetValue(type(default) == "table" and (default.Text or default[1]) or default or "Idle", type(default) == "table" and (default.State or default[2]) or nil)
    return status
end

---@param kind string?  Idle|Running|Busy|Waiting|Warn|Error (default: guessed from the text)
function Status:SetValue(text, kind)
    text = text == nil and "" or text
    local settings = Config.Widget.Status
    local resolved = Lang.Resolve(text)
    local token = settings.Tokens[kind or resolved] or settings.Tokens[kind or ""] or (kind and "Info") or "Good"
    if resolved == "" then
        token = "Muted"
    end
    local changed = token ~= self.Token
    self.Value, self.Kind, self.Token = text, kind, token
    self.Label.Text = resolved
    local width = Layout.Measure(resolved, self.Label.TextSize, "Strong", 1000).X
    self.Label.Size = UDim2.new(0, width, 1, 0)
    self.Row:SetRightWidth(self.Holder, settings.Halo + settings.Gap + width)
    Widget.Paint(self, self.Dot, "BackgroundColor3", token, true)
    Widget.Paint(self, self.Halo, "BackgroundColor3", token, true)
    Widget.Paint(self, self.Label, "TextColor3", token == "Muted" and "SubText" or token, true)
    if changed then
        Motion.Pop(self.Halo)
    end
end

function Status:Fire() end

function Status:Serialize()
    return nil
end

function WidgetHost:AddStat(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local settings = Config.Widget.Stat
    local stat = setmetatable({ Type = "Stat", Container = self, NoSave = true, Value = 0, Format = info.Format, Suffix = info.Suffix or "" }, Stat)
    stat.Row = Row.New(self, info, { Control = Fonts.Size("Display", settings.Size) + 6 })
    stat.Item = stat.Row.Item
    local control = stat.Row.Control
    stat.Number = Draw.Text({ Name = "Number", Size = UDim2.fromScale(0.6, 1), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = Config.Z.Detail, Parent = control }, "Display", settings.Size, info.Token or "Text")
    if info.Token and info.Token ~= "Text" then
        Draw.Stroke(stat.Number, "Ink", 2)
    end
    stat.Delta = Draw.Text({ Name = "Delta", AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.4, 1), TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = Config.Z.Detail, Parent = control }, "Strong", Util.TextSize("Label"), "SubText")
    stat.Roll = Draw.New("NumberValue", { Name = "Roll", Parent = control })
    stat.Roll.Changed:Connect(function(value)
        stat.Number.Text = stat:Text(value)
    end)
    Widget.Register(stat, idx, info)
    stat.Number.Text = stat:Text(0)
    stat:SetValue(tonumber(info.Default) or 0)
    return stat
end

---@return string  1234567 -> 1.23M
function Stat.Abbreviate(value)
    local absolute = math.abs(value)
    local suffixes = { { 1e12, "T" }, { 1e9, "B" }, { 1e6, "M" }, { 1e3, "K" } }
    for _, entry in ipairs(suffixes) do
        if absolute >= entry[1] then
            return string.format("%.2f", value / entry[1]):gsub("%.?0+$", "") .. entry[2]
        end
    end
    return tostring(Util.Round(value, absolute < 10 and 2 or 0))
end

function Stat:Text(value)
    local text = Stat.Abbreviate(value)
    if type(self.Format) == "string" then
        return string.format(self.Format, text)
    elseif self.Format then
        return tostring(self.Format(value))
    end
    return text .. Lang.Resolve(self.Suffix)
end

function Stat:SetValue(value)
    value = tonumber(value)
    if not value then
        return
    end
    local now = os.clock()
    if not self.BaseTime then
        self.BaseTime, self.BaseValue = now, value
    end
    self.Value = value
    Motion.Spring(self.Roll, "Value", value, Config.Widget.Stat.Speed)
    if Motion.Reduced then
        self.Number.Text = self:Text(value)
    end
    self:RenderRate(now)
end

function Stat:RenderRate(now)
    local elapsed = now - self.BaseTime
    if elapsed < Config.Widget.Stat.MinWindow then
        self.Delta.Text = ""
        return
    end
    local rate = (self.Value - self.BaseValue) / elapsed * 3600
    local sign = rate > 0 and "+" or ""
    self.Delta.Text = Lang.Get("PerHour", sign .. Stat.Abbreviate(rate))
    Widget.Paint(self, self.Delta, "TextColor3", rate > 0 and "Good" or (rate < 0 and "Bad" or "SubText"), true)
end

function Stat:Reset()
    self.BaseTime, self.BaseValue = os.clock(), self.Value
    self.Delta.Text = ""
end

function Stat:Fire() end

function Stat:Serialize()
    return nil
end

---@return number  category bar height, taller for fingers
function TeleportList.ChipBar()
    local settings = Config.Widget.Teleport
    return Platform.Touch and settings.TouchChip or settings.Chip
end

---@param info table  { Text, Source = fn() -> entries | entries, Callback(entry), Refresh = fn()?, Height = rows }
function WidgetHost:AddTeleportList(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local settings = Config.Widget.Teleport
    local tp = setmetatable({ Type = "TeleportList", Container = self, NoSave = true, Source = info.Source, RefreshFn = info.Refresh, Entries = {}, Shown = {}, Query = "", Category = nil, Chips = {} }, TeleportList)
    tp.Callback = info.Callback or info.Teleport
    local list = Config.Widget.List
    local rows = info.Height or settings.Rows
    local box, gap = Platform.Metric("Box"), Config.Gap.Y
    tp.ListTop = box + gap + TeleportList.ChipBar() + gap
    local listHeight = rows * (Platform.Metric("Item") + list.Gap) - list.Gap + list.Pad * 2
    tp.Row = Row.New(self, info, { Control = tp.ListTop + listHeight })
    tp.Item = tp.Row.Item
    tp:BuildTop()
    tp:BuildList(listHeight)
    Widget.Register(tp, idx, info)
    tp:Reload()
    return tp
end

function TeleportList:BuildTop()
    local control = self.Row.Control
    local box = Platform.Metric("Box")
    local searchHolder = Draw.New("Frame", { Name = "Search", BackgroundTransparency = 1, Size = UDim2.new(1, -box - 8, 0, box), ZIndex = Config.Z.Body, Parent = control })
    local search = Widget.Field(searchHolder, Lang.Strings.Search)
    search:GetPropertyChangedSignal("Text"):Connect(function()
        self.Query = search.Text:lower()
        self:Filter()
    end)
    local holder, face, _, depth = Widget.SmallBlock("Primary", UDim2.fromOffset(box, box))
    holder.AnchorPoint, holder.Position, holder.ZIndex = Vector2.new(1, 0), UDim2.fromScale(1, 0), Config.Z.Detail
    holder.Parent = control
    local glyph = Draw.Text({ Text = "⟳", Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = face.ZIndex + 1, Parent = face }, "Glyph", Util.TextSize("Header"), "AccentText")
    self:AddBinder(Gui.Clickable(holder, {
        OnPress = Widget.SinkOnPress(face, depth),
        OnClick = function()
            Motion.Set(glyph, "Rotation", 0)
            Motion.Spring(glyph, "Rotation", 360, "Soft")
            self:RunRefresh()
        end,
    }))
    if Tooltip.Attach then
        Tooltip.Attach(holder, Lang.Strings.Refresh)
    end
    local chips = Layout.ScrollFrame({ Name = "Categories", Position = UDim2.fromOffset(0, box + Config.Gap.Y), Size = UDim2.new(1, 0, 0, TeleportList.ChipBar()), ZIndex = Config.Z.Body, Parent = control })
    chips.ScrollingDirection = Enum.ScrollingDirection.X
    chips.ScrollBarThickness = 0
    chips.AutomaticCanvasSize = Enum.AutomaticSize.X
    Draw.List(chips, 6, true, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    local inset = Config.Widget.Teleport.ChipInset
    Draw.Padding(chips, 0, inset, 0, inset)
    self.ChipStrip = chips
end

function TeleportList:BuildList(height)
    local body = Draw.New("Frame", { Name = "Body", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, self.ListTop), Size = UDim2.new(1, 0, 0, height), ZIndex = Config.Z.Body, Parent = self.Row.Control })
    self.List = Gui.VirtualList(nil, {
        Parent = body,
        RowHeight = Platform.Metric("Item"),
        Rows = math.floor((height + Config.Widget.List.Gap) / (Platform.Metric("Item") + Config.Widget.List.Gap)),
        Count = function()
            return math.max(1, #self.Shown)
        end,
        Make = TeleportList.MakeRow,
        Render = function(parts, index)
            self:RenderRow(parts, index)
        end,
        OnClick = function(index, input, parts)
            self:Teleport(index, input, parts)
        end,
    })
end

function TeleportList.MakeRow()
    local parts = Gui.MakeListRow()
    local pillWidth = Config.Widget.Teleport.Pill
    parts.Mark.Parent.Visible = false
    parts.Sub = Draw.Text({ Name = "Category", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -pillWidth - 14, 0, 0), Size = UDim2.new(0.35, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parts.Frame }, "Desc", Util.TextSize("Small"), "Muted")
    local pill = Draw.Box("Frame", { Name = "Pill", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.new(0, pillWidth, 1, -10), BackgroundTransparency = 0 }, "Accent", "Outline", UDim.new(1, 0), 1)
    pill.Parent = parts.Frame
    parts.PillLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Parent = pill }, "Strong", Config.Widget.Badge.Size, "AccentText", Lang.Strings.Teleport)
    parts.Pill = pill
    return parts
end

---@return table  { Name, Category?, Icon? } from a source entry (string or table)
function TeleportList.Shape(entry)
    if type(entry) ~= "table" then
        return { Name = tostring(entry), Raw = entry }
    end
    entry.Name = entry.Name or entry.Text or entry[1] or "?"
    entry.CategoryKey = TeleportList.CategoryKey(entry.Category)
    return entry
end

---@return string?  same key for equal categories even when each entry built its own T() table
function TeleportList.CategoryKey(spec)
    if type(spec) == "table" then
        return tostring(spec.EN) .. "|" .. tostring(spec.TH)
    end
    return spec ~= nil and tostring(spec) or nil
end

function TeleportList:Reload()
    local source = self.Source
    local ok, list = true, source
    if type(source) == "function" then
        ok, list = pcall(source)
    end
    table.clear(self.Entries)
    if ok and type(list) == "table" then
        for _, entry in ipairs(list) do
            self.Entries[#self.Entries + 1] = TeleportList.Shape(entry)
        end
    elseif not ok then
        warn("[Mario Hub] teleport source:", list)
    end
    self:BuildChips()
    self:Filter()
end

function TeleportList:RunRefresh()
    if self.Refreshing then
        return
    end
    self.Refreshing = true
    task.spawn(function()
        if self.RefreshFn then
            Util.Try(self.RefreshFn)
        end
        self.Refreshing = false
        if not Library.Unloaded then
            self:Reload()
        end
    end)
end

function TeleportList:Categories()
    local seen, order = {}, {}
    for _, entry in ipairs(self.Entries) do
        local key = entry.CategoryKey
        if key ~= nil and not seen[key] then
            seen[key] = true
            order[#order + 1] = entry.Category
        end
    end
    return order, seen
end

function TeleportList:BuildChips()
    for _, chip in ipairs(self.Chips) do
        chip.Frame:Destroy()
    end
    table.clear(self.Chips)
    local categories, keys = self:Categories()
    self.ChipStrip.Visible = #categories > 0
    if self.Category ~= nil and not keys[self.Category] then
        self.Category = nil
    end
    self:AddChip(nil, 0)
    for order, category in ipairs(categories) do
        self:AddChip(category, order)
    end
    self:PaintChips()
end

function TeleportList:AddChip(category, order)
    local spec = category or Lang.Strings.All
    local size = Util.TextSize("Small")
    local chip = Draw.Box("TextButton", { Name = "Chip", LayoutOrder = order, Size = UDim2.fromOffset(math.max(Gui.TextWidth(spec, size, "Strong") + 20, Platform.TouchMin()), TeleportList.ChipBar() - Config.Widget.Teleport.ChipInset * 2), BackgroundTransparency = 0 }, "Element", "Outline", UDim.new(1, 0), 1)
    chip.Parent = self.ChipStrip
    local label = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Parent = chip }, "Strong", size, "Text", spec)
    local entry = { Frame = chip, Label = label, Category = TeleportList.CategoryKey(category) }
    Gui.Clickable(chip, {
        OnClick = function()
            self.Category = entry.Category
            Motion.Pop(chip)
            self:PaintChips()
            self:Filter()
        end,
    })
    table.insert(self.Chips, entry)
end

function TeleportList:PaintChips()
    for _, chip in ipairs(self.Chips) do
        local on = chip.Category == self.Category
        Widget.Paint(chip, chip.Frame, "BackgroundColor3", on and "Accent" or "Element", true)
        Widget.Paint(chip, chip.Label, "TextColor3", on and "AccentText" or "Text", true)
    end
end

function TeleportList:Filter()
    local shown, query, category = self.Shown, self.Query, self.Category
    table.clear(shown)
    for _, entry in ipairs(self.Entries) do
        local inCategory = category == nil or entry.CategoryKey == category
        if inCategory and (query == "" or Lang.SearchText(entry.Name):find(query, 1, true)) then
            shown[#shown + 1] = entry
        end
    end
    self.List:ScrollTo(1)
    self.List:Refresh(true)
end

TeleportList.RowState = {}

function TeleportList:RenderRow(parts, index)
    local entry = self.Shown[index]
    local state = TeleportList.RowState
    state.Text = entry and entry.Name or Lang.Strings.NoResults
    state.Header, state.Selected = entry == nil, false
    state.Icon = entry and entry.Icon or nil
    Gui.PaintListRow(parts, state)
    parts.Sub.Text = entry and entry.Category and Lang.Resolve(entry.Category) or ""
    parts.Pill.Visible = entry ~= nil
end

function TeleportList:Teleport(index, input, parts)
    local entry = self.Shown[index]
    if not entry or self:IsBlocked() then
        return
    end
    Motion.Ripple(parts.Frame, input and input.Position)
    Motion.Pop(parts.Pill)
    self.Value = entry.Name
    Util.Try(self.Callback, entry.Raw ~= nil and entry.Raw or entry)
    for _, callback in ipairs(self.Changed) do
        Util.Try(callback, entry.Raw ~= nil and entry.Raw or entry)
    end
end

function TeleportList:SetSource(source)
    self.Source = source
    self:Reload()
end

TeleportList.SetValues = TeleportList.SetSource

function TeleportList:SetValue(name)
    self.Value = name
end

function TeleportList:Serialize()
    return nil
end

---@param info table  { Text, Callback, Style = "Danger", HoldTime, Tooltip, Icon, Width, DependsOn, Disabled }
function WidgetHost:AddConfirmButton(info, callback)
    info = Widget.DefaultIcon(Button.Normalize(info, callback), "ConfirmButton")
    local settings = Config.Widget.Confirm
    info.Style = info.Style or settings.Style
    local button = Button.Create(self, info, nil, nil, ConfirmButton)
    button.Type, button.Hold, button.Token = "ConfirmButton", info.HoldTime or settings.Hold, 0
    local handle = button.Handle
    button.Face, button.Shade, button.Depth, button.Label = handle.Face, handle.Shade, handle.Depth, handle.Label
    local tokens = Config.Button.Styles[info.Style] or Config.Button.Styles.Default
    button.Fill = Draw.Box("Frame", { Name = "Progress", Size = UDim2.fromScale(0, 1), BackgroundTransparency = 0.35, ZIndex = handle.Face.ZIndex, Parent = handle.Face }, tokens.Shade or "Pressed", nil, Platform.Metric("Radius"))
    button.Label.Parent.ZIndex = handle.Face.ZIndex + 1
    button.Label.ZIndex = handle.Face.ZIndex + 1
    handle.OnPress = function(_, pressed)
        Gui.ButtonHandle.OnPress(handle, pressed)
        button:OnPress(pressed)
    end
    if not info.Tooltip and Tooltip.Attach then
        Tooltip.Attach(button.Frame, Platform.Touch and Lang.Strings.TapConfirm or Lang.Strings.HoldConfirm)
    end
    return button
end

function ConfirmButton:OnPress(pressed)
    if Platform.Touch or self.Disabled or self.Locked then
        return
    end
    self.Token += 1
    if not pressed then
        Motion.Spring(self.Fill, "Size", UDim2.fromScale(0, 1), "Fast")
        return
    end
    Motion.Set(self.Fill, "Size", UDim2.fromScale(0, 1))
    Motion.Spring(self.Fill, "Size", UDim2.fromScale(1, 1), 4.6 / self.Hold)
    task.delay(self.Hold, ConfirmButton.Complete, self, self.Token)
end

function ConfirmButton.Complete(button, token)
    if button.Token ~= token or Library.Unloaded or button.Disabled or button.Locked then
        return
    end
    button.Token += 1
    Motion.Set(button.Fill, "Size", UDim2.fromScale(1, 1))
    Motion.Spring(button.Fill, "Size", UDim2.fromScale(0, 1), "Soft")
    button:Run()
end

function ConfirmButton:Run()
    Motion.Pop(self.Frame)
    Util.Try(self.Callback)
end

---Desktop confirms by holding (OnPress); touch taps once to arm, again to run.
function ConfirmButton:Click()
    if not Platform.Touch or self.Disabled or self.Locked then
        return
    end
    if self.Armed then
        self:Cancel()
        self:Run()
        return
    end
    self.Armed = true
    local token = os.clock()
    self.ArmToken = token
    Lang.Bind(self.Label, Lang.Strings.TapConfirm)
    Motion.Spring(self.Fill, "Size", UDim2.fromScale(1, 1), "Normal")
    Motion.Shake(self.Face)
    task.delay(Config.ConfirmWindow, ConfirmButton.Expire, self, token)
end

function ConfirmButton.Expire(button, token)
    if button.ArmToken == token and button.Armed then
        button:Cancel()
    end
end

---Drops a pending hold or tap-arm and resets the fill and label.
function ConfirmButton:Cancel()
    if not self.Fill then
        return
    end
    self.Token += 1
    self.Armed = false
    Lang.Bind(self.Label, self.Info.Text or "")
    Motion.Spring(self.Fill, "Size", UDim2.fromScale(0, 1), "Fast")
end

function ConfirmButton:SetDisabled(disabled)
    Button.SetDisabled(self, disabled)
    if self.Disabled then
        self:Cancel()
    end
    return self
end

function ConfirmButton:Lock(locked)
    Button.Lock(self, locked)
    if self.Locked then
        self:Cancel()
    end
    return self
end

---Toggle + Now button + keybind + mode selector + nested options (shown only while on) in one call.
---@param info table  { Text, Description, Default, Callback, Risky, Badge, Icon, Tooltip,
---                    Now = fn | { Text, Func, Style }, Keybind = "Q" | { Default, Mode, FloatButton },
---                    Modes = { Values, Default, Text, Callback }, Options = fn(container) }
---@return table      the toggle; .Now, .Key, .Mode, .Options attached
function WidgetHost:AddFeature(idx, info)
    idx, info = Widget.Normalize(idx, info)
    local toggle = self:AddToggle(idx, {
        Text = info.Text, Description = info.Description, Default = info.Default, Callback = info.Callback,
        Risky = info.Risky, Badge = info.Badge, Icon = info.Icon, Tooltip = info.Tooltip, Disabled = info.Disabled,
        DependsOn = info.DependsOn, NoSave = info.NoSave,
    })
    Feature.AttachKey(toggle, idx, info.Keybind)
    Feature.AttachNow(self, toggle, info.Now)
    if info.Modes and idx ~= nil then
        local modes = info.Modes
        toggle.Mode = self:AddSegmented(idx .. "Mode", {
            Text = modes.Text or Lang.Strings.Mode,
            Values = modes.Values or modes,
            Default = modes.Default,
            Callback = modes.Callback,
            DependsOn = { idx, true },
        })
    end
    if type(info.Options) == "function" then
        toggle.Options = Feature.BuildOptions(self, idx, info.Options)
    end
    return toggle
end

function Feature.AttachKey(toggle, idx, keybind)
    if keybind == nil or idx == nil then
        return
    end
    local spec = type(keybind) == "table" and keybind or { Default = keybind }
    toggle:AddKeyPicker(idx .. "Key", {
        Default = spec.Default or spec[1] or "None",
        Mode = spec.Mode or "Toggle",
        Text = toggle.Row.Info.Text,
        FloatButton = spec.FloatButton ~= false,
    })
    toggle.Key = Library.Options[idx .. "Key"]
end

function Feature.AttachNow(container, toggle, now)
    if now == nil then
        return
    end
    local spec = now
    if type(now) == "function" then
        spec = { Func = now }
    elseif type(now) ~= "table" or now.EN or now.TH then
        spec = { Text = now }
    end
    toggle.Now = Button.Create(container, {
        Text = spec.Text or Lang.Strings.RunNow,
        Callback = spec.Callback or spec.Func or function()
            Util.Try(toggle.Callback, true)
        end,
        Style = spec.Style or "Primary",
        Icon = spec.Icon,
        DoubleClick = spec.DoubleClick,
    })
    toggle.Now:Lock(toggle:IsBlocked())
    if toggle.Visible == false then
        toggle.Now:SetVisible(false)
    end
end

---@return table  child container shown only while the toggle is on
function Feature.BuildOptions(container, idx, build)
    local child = Gui.BeginChild(container, idx and (idx .. "Options") or nil, { PadX = Config.Widget.Child.Pad * 2, PadY = 2 })
    Gui.EndChild()
    local rail = Draw.Box("Frame", { Name = "Rail", Position = UDim2.fromOffset(Config.Widget.Child.Pad / 2, 4), Size = UDim2.new(0, 3, 1, -8) }, "Track", nil, UDim.new(1, 0))
    rail.BackgroundTransparency = 0
    rail.Parent = child.Frame
    local target = {
        SetVisible = function(_, visible)
            if child.Item.Hidden == not visible then
                return
            end
            child.Item.Hidden = not visible
            container:MarkDirty()
        end,
    }
    if idx ~= nil then
        Widget.Depend(target, { idx, true })
    end
    Util.Try(build, child)
    return child
end

---@author xDTaraZ  Mario Hub UI V2
Config.Overlay = {
    Margin = 12, Shadow = 4, Stroke = 3, Radius = 12, Dim = 0.45,
    PopupGap = 6, PopupPad = 6, PopupMaxHeight = 320, PopupMin = 96,
    SheetMaxWidth = 560, SheetHeight = 0.6, SheetMin = 160, SheetHeader = 52, SheetRadius = 16,
    SheetHandle = Vector2.new(40, 5), SheetClose = 0.3, SheetFling = 900, SheetRubber = 0.25, SheetPad = 14,
    DialogWidth = 380, DialogHeader = 48, DialogPad = 16,
    TooltipWidth = 240, TooltipOffset = Vector2.new(14, 18), TooltipHold = 2.5,
    NotifyMax = { Desktop = 5, Tablet = 4, Phone = 3 }, NotifyBar = 6, NotifyTimer = 3, NotifyPad = 10,
    NotifyIcon = { Desktop = 28, Tablet = 28, Phone = 22 }, NotifyAction = 28, NotifyEnter = 40,
    Float = { Desktop = 48, Tablet = 52, Phone = 56, HopEvery = 5, Hop = 150, Sink = 2 },
    QuickBar = { Width = 136, Height = { Desktop = 36, Tablet = 44, Phone = 48 }, Gap = 8, Lamp = 10, Sync = 0.25 },
    Watermark = { Height = 30, Every = 0.5, Gap = 10, PadX = 12, Coin = 18 },
    KeybindList = { Width = 220, Header = 30, Row = 24, Every = 0.25, Max = 12 },
    Store = "mariohub/overlay.json", SaveDelay = 1,
}

Lang.Strings.OK = { EN = "OK", TH = "ตกลง" }
Lang.Strings.Cancel = Lang.Strings.Cancel or { EN = "Cancel", TH = "ยกเลิก" }
Lang.Strings.PromptNumber = { EN = "Enter a number", TH = "ใส่ตัวเลข" }
Lang.Strings.PromptPick = { EN = "Pick one first", TH = "เลือกก่อน" }
Lang.Strings.Keybinds = { EN = "KEYBINDS", TH = "ปุ่มลัด" }
Lang.Strings.NoKeybinds = { EN = "No keys bound", TH = "ยังไม่ได้ตั้งปุ่ม" }

Popup.Layers = {}
Popup.Presence = { From = "Top", Distance = 8, Speed = "Fast" }
Popup.Drag = { Active = nil, Bound = false }
Popup.DimDone = { OnDone = function(dim)
    if dim:GetAttribute("Open") ~= true then
        dim.Visible = false
    end
end }

---@param key string  Config.Layer name
---@return Frame      full-screen transparent layer under State.Stage
function Popup.Layer(key)
    local layer = Popup.Layers[key]
    if layer and layer.Parent then
        return layer
    end
    layer = Draw.New("Frame", { Name = "Layer" .. key, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = Config.Layer[key] or 1, Parent = State.Stage })
    Popup.Layers[key] = layer
    return layer
end

---@return number top, number bottom  safe px inside a layer (topbar/notch, home bar)
function Popup.Insets(layer)
    local top = math.max(0, -layer.AbsolutePosition.Y)
    local ok, _, bottomRight = pcall(GuiService.GetGuiInset, GuiService)
    return top, ok and bottomRight.Y or 0
end

---@param point Vector2  UserInputService:GetMouseLocation() space
function Popup.ScreenToLocal(layer, point)
    local ok, topLeft = pcall(GuiService.GetGuiInset, GuiService)
    local inset = ok and topLeft or Vector2.zero
    return point - inset - layer.AbsolutePosition
end

---@return Frame holder, Frame face  chunky outlined panel with a hard drop shadow (size the holder)
---Extra size a CanvasGroup card needs so its outline is not clipped by the group bounds.
function Popup.Edge()
    return Config.Overlay.Stroke * 2
end

function Popup.Card(parent, className, fill, radius)
    local settings = Config.Overlay
    local shadow = settings.Shadow
    radius = radius or settings.Radius
    local inset = className == "CanvasGroup" and settings.Stroke or 0
    local holder = Draw.New(className or "Frame", { Name = "Card", BackgroundTransparency = 1, Parent = parent })
    Draw.Box("Frame", { Name = "Shadow", Position = UDim2.fromOffset(inset + shadow, inset + shadow), Size = UDim2.new(1, -(shadow + inset * 2), 1, -(shadow + inset * 2)), Parent = holder }, "Shadow", nil, radius)
    local face = Draw.Box("Frame", { Name = "Face", Position = UDim2.fromOffset(inset, inset), Size = UDim2.new(1, -(shadow + inset * 2), 1, -(shadow + inset * 2)), ClipsDescendants = true, Parent = holder }, fill or "Panel", "Outline", radius, settings.Stroke)
    return holder, face
end

---@return TextButton  full-screen dim that swallows input; click runs onClick
function Popup.Dim(layer, onClick)
    local dim = Gui.Hitbox("Dim")
    dim.Size = UDim2.fromScale(1, 1)
    dim.Visible = false
    dim.Parent = layer
    Theme.Bind(dim, { BackgroundColor3 = "Black" })
    Gui.Clickable(dim, { OnClick = onClick })
    return dim
end

function Popup.ShowDim(dim, shown)
    dim:SetAttribute("Open", shown)
    if shown then
        dim.Visible = true
        Motion.Spring(dim, "BackgroundTransparency", Config.Overlay.Dim, "Normal")
        return
    end
    Motion.Spring(dim, "BackgroundTransparency", 1, "Fast", Popup.DimDone)
end

---@return TextButton  44px close target with an X drawn from two bars (the glyph renders unevenly)
function Popup.CloseButton(parent, onClick)
    local hit = Gui.Hitbox("Close")
    hit.AnchorPoint = Vector2.new(1, 0.5)
    hit.Position = UDim2.new(1, -6, 0.5, 2)
    hit.Size = UDim2.fromOffset(44, 44)
    hit.Parent = parent
    local face = Draw.Box("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(30, 30), Parent = hit }, "Element", "Outline", 8, 2)
    for _, angle in ipairs({ 45, -45 }) do
        local bar = Draw.New("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(14, 3), Rotation = angle, Parent = face })
        Draw.Corner(bar, UDim.new(1, 0))
        Theme.Bind(bar, { BackgroundColor3 = "Text" })
    end
    Gui.Clickable(hit, {
        OnClick = onClick,
        OnHover = function(hovered)
            Motion.Spring(face, "BackgroundColor3", Theme.Color(hovered and "Hover" or "Element"), "Fast")
        end,
    })
    return hit
end

---@return table  fresh Container on host; the previous one on owner is cleared
function Popup.Renew(owner, host, padX, padY, onHeight)
    local old = owner.Content
    if old then
        old:Clear()
        old:Destroy()
    end
    local content = Container.New(host, { PadX = padX, PadY = padY, OnHeight = onHeight })
    owner.Content = content
    return content
end

function Popup.EnsureDrag()
    if Popup.Drag.Bound then
        return
    end
    Popup.Drag.Bound = true
    Util.Connect(UserInputService.InputChanged, Popup.DragMove)
    Util.Connect(UserInputService.InputEnded, Popup.DragEnd)
end

---Shared drag tracker for overlays (sheet handle, float, quick bar, watermark).
---@param handlers table  { OnStart(), OnMove(delta: Vector2), OnEnd(moved: boolean, velocity: Vector2) }
---@return RBXScriptConnection
function Popup.Track(frame, handlers)
    Popup.EnsureDrag()
    frame.Active = true
    return Util.Connect(frame.InputBegan, function(input)
        if not Util.IsPointer(input) or Popup.Drag.Active then
            return
        end
        local start = Vector2.new(input.Position.X, input.Position.Y)
        Popup.Drag.Active = { Handlers = handlers, Input = input, Type = input.UserInputType, Start = start, Last = start, Time = os.clock(), Velocity = Vector2.zero, Moved = false }
        if handlers.OnStart then
            Util.Try(handlers.OnStart)
        end
    end)
end

function Popup.DragMatches(drag, input)
    return input == drag.Input or (drag.Type == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)
end

function Popup.DragMove(input)
    local drag = Popup.Drag.Active
    if not drag or not Popup.DragMatches(drag, input) then
        return
    end
    local point = Vector2.new(input.Position.X, input.Position.Y)
    local delta = point - drag.Start
    if not drag.Moved and delta.Magnitude < Config.Click.DragCancel then
        return
    end
    drag.Moved = true
    local now = os.clock()
    local elapsed = math.max(now - drag.Time, 1 / 240)
    drag.Velocity = drag.Velocity:Lerp((point - drag.Last) / elapsed, 0.5)
    drag.Last, drag.Time = point, now
    Util.Try(drag.Handlers.OnMove, delta)
end

function Popup.DragEnd(input)
    local drag = Popup.Drag.Active
    if not drag or (input ~= drag.Input and input.UserInputType ~= drag.Type) then
        return
    end
    Popup.Drag.Active = nil
    if os.clock() - drag.Time > 0.08 then
        drag.Velocity = Vector2.zero
    end
    if drag.Handlers.OnEnd then
        Util.Try(drag.Handlers.OnEnd, drag.Moved, drag.Velocity)
    end
end

function Popup.Build()
    if Popup.Frame and Popup.Frame.Parent then
        return
    end
    local pad = Config.Overlay.PopupPad
    local layer = Popup.Layer("Overlay")
    local catcher = Gui.Hitbox("Dismiss")
    catcher.Size = UDim2.fromScale(1, 1)
    catcher.Visible = false
    catcher.Parent = layer
    Gui.Clickable(catcher, { OnClick = function()
        Popup.Close()
    end })
    local card, face = Popup.Card(layer, "CanvasGroup")
    card.Visible = false
    card.ZIndex = Config.Z.Text
    local scroll = Layout.ScrollFrame({ Name = "Scroll", Position = UDim2.fromOffset(pad, pad), Size = UDim2.new(1, -pad * 2, 1, -pad * 2), Parent = face })
    Popup.Catcher, Popup.Frame, Popup.Face, Popup.Scroll = catcher, card, face, scroll
end

---@return UDim2 position, number height, boolean flipped  card placement under (or above) the anchor
function Popup.Place(anchor, width, height)
    local settings = Config.Overlay
    local layer = Popup.Layer("Overlay")
    local view = layer.AbsoluteSize
    local top, bottom = Popup.Insets(layer)
    local margin, gap = settings.Margin, settings.PopupGap
    local origin, size = anchor.AbsolutePosition - layer.AbsolutePosition, anchor.AbsoluteSize
    local x = math.clamp(origin.X, margin, math.max(margin, view.X - width - margin))
    local below = view.Y - bottom - margin - (origin.Y + size.Y + gap)
    local above = origin.Y - gap - top - margin
    local flipped = below < height and above > below
    height = math.min(height, math.max(flipped and above or below, settings.PopupMin))
    local y = flipped and origin.Y - gap - height or origin.Y + size.Y + gap
    return UDim2.fromOffset(x, y), height, flipped
end

function Popup.Fit()
    local anchor, content = Popup.Anchor, Popup.Content
    if not State.Popup or not content then
        return
    end
    if not anchor or not anchor.Parent then
        Popup.Close()
        return
    end
    local settings = Config.Overlay
    local edge = settings.Shadow + Popup.Edge()
    local wanted = math.min(content.ContentHeight + settings.PopupPad * 2, Popup.MaxHeight) + edge
    local position, height, flipped = Popup.Place(anchor, Popup.Width + edge, wanted)
    Popup.Frame.Size = UDim2.fromOffset(Popup.Width + edge, height)
    Popup.Presence.From = flipped and "Bottom" or "Top"
    Motion.SetHome(Popup.Frame, position)
end

---Anchored dropdown panel; on Phone it opens as a bottom sheet instead.
---@param build fun(container: table)
---@param options table?  { Width, MaxHeight, Title, OnClose, SheetHeight }
---@return table  { Container, Close, Fit }
function Popup.Open(anchor, build, options)
    options = options or {}
    if Platform.Mode == "Phone" then
        return Sheet.Open(options.Title, build, { Height = options.SheetHeight or "Auto", OnClose = options.OnClose })
    end
    Popup.Close()
    Popup.Build()
    local settings = Config.Overlay
    Popup.Anchor = anchor
    Popup.Width = math.floor(options.Width or math.max(anchor.AbsoluteSize.X, Config.Dropdown.MinWidth))
    Popup.MaxHeight = options.MaxHeight or settings.PopupMaxHeight
    local content = Popup.Renew(Popup, Popup.Scroll, 2, 2, Popup.Fit)
    content:SetWidth(Popup.Width - settings.PopupPad * 2 - Config.Page.ScrollBar)
    State.Popup = { Close = Popup.Close, OnClose = options.OnClose, Content = content }
    Util.Try(build, content)
    Layout.Flush()
    Popup.Scroll.CanvasPosition = Vector2.zero
    Popup.Fit()
    Popup.Catcher.Visible = true
    Motion.Presence(Popup.Frame, true, Popup.Presence)
    return { Container = content, Close = Popup.Close, Fit = Popup.Fit }
end

function Popup.Close()
    local popup = State.Popup
    if not popup then
        return
    end
    State.Popup = nil
    Popup.Anchor = nil
    Popup.Catcher.Visible = false
    Motion.Presence(Popup.Frame, false, Popup.Presence)
    Util.Try(popup.OnClose)
end

---Escape / back: closes the topmost overlay.
---@return boolean  true if something closed
function Popup.CloseTop()
    if State.Dialog then
        Dialog.Dismiss()
    elseif State.Sheet then
        Sheet.Close()
    elseif State.Popup then
        Popup.Close()
    else
        return false
    end
    return true
end

function Sheet.Build()
    if Sheet.Panel and Sheet.Panel.Parent then
        return
    end
    local settings = Config.Overlay
    local layer = Popup.Layer("Sheet")
    Sheet.Dim = Popup.Dim(layer, function()
        Sheet.Close()
    end)
    local panel = Draw.Box("Frame", { Name = "Sheet", AnchorPoint = Vector2.new(0.5, 0), Visible = false, ZIndex = Config.Z.Text, Parent = layer }, "Panel", "Outline", settings.SheetRadius, settings.Stroke)
    local header = Gui.Hitbox("Header")
    header.Size = UDim2.new(1, 0, 0, settings.SheetHeader)
    header.Parent = panel
    local grip = settings.SheetHandle
    Draw.Box("Frame", { Name = "Handle", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 7), Size = UDim2.fromOffset(grip.X, grip.Y), Parent = header }, "Muted", nil, UDim.new(1, 0))
    Sheet.Title = Draw.Text({ Position = UDim2.fromOffset(settings.SheetPad + 2, 12), Size = UDim2.new(1, -72, 1, -12), TextTruncate = Enum.TextTruncate.AtEnd, Parent = header }, "Display", Util.TextSize("Group") + 2, "Text")
    Popup.CloseButton(header, function()
        Sheet.Close()
    end)
    Draw.Box("Frame", { Name = "Rule", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 2), Parent = header }, "Track")
    Sheet.Body = Layout.ScrollFrame({ Name = "Body", Position = UDim2.fromOffset(0, settings.SheetHeader), Parent = panel })
    Sheet.Panel, Sheet.Header = panel, header
    Popup.Track(header, Sheet.DragHandlers)
end

---@param spec any  fraction of screen height, or "Auto" to fit content
function Sheet.Measure(spec, contentHeight)
    local settings = Config.Overlay
    local layer = Popup.Layer("Sheet")
    local view = layer.AbsoluteSize
    local top, bottom = Popup.Insets(layer)
    local maxHeight = math.max(view.Y - top - settings.Margin, 1)
    local wanted: number = 0
    if spec == "Auto" then
        wanted = settings.SheetHeader + (tonumber(contentHeight) or 0) + bottom + settings.Margin
    else
        wanted = view.Y * (tonumber(spec) or settings.SheetHeight)
    end
    local height = math.clamp(wanted :: number, math.min(settings.SheetMin, maxHeight), maxHeight)
    local width = math.min(view.X, settings.SheetMaxWidth)
    Sheet.Width, Sheet.Height = width, height
    Sheet.Panel.Size = UDim2.fromOffset(width, height + settings.SheetRadius)
    Sheet.Body.Size = UDim2.new(1, 0, 0, height - settings.SheetHeader - bottom)
    Sheet.Home = UDim2.new(0.5, 0, 1, -height)
    Sheet.Hidden = UDim2.new(0.5, 0, 1, settings.Shadow + 8)
end

function Sheet.Refit()
    if not State.Sheet or Sheet.Spec ~= "Auto" or Popup.Drag.Active then
        return
    end
    Sheet.Measure("Auto", Sheet.Content.ContentHeight)
    Motion.Spring(Sheet.Panel, "Position", Sheet.Home, "Normal")
end

---Bottom sheet: drag the header down or tap the dim to close.
---@param build fun(container: table)
---@param options table?  { Height = 0.6 | "Auto", OnClose }
---@return table  { Container, Close, SetTitle }
function Sheet.Open(titleSpec, build, options)
    options = options or {}
    Popup.Close()
    Sheet.Build()
    local settings = Config.Overlay
    Lang.Bind(Sheet.Title, titleSpec or "")
    Sheet.Spec = options.Height or settings.SheetHeight
    Sheet.Measure(Sheet.Spec, 0)
    local content = Popup.Renew(Sheet, Sheet.Body, settings.SheetPad, 10, Sheet.Refit)
    content:SetWidth(Sheet.Width - Config.Page.ScrollBar)
    local wasOpen = State.Sheet ~= nil
    State.Sheet = { Close = Sheet.Close, OnClose = options.OnClose, Content = content }
    Util.Try(build, content)
    Layout.Flush()
    Sheet.Measure(Sheet.Spec, content.ContentHeight)
    Sheet.Body.CanvasPosition = Vector2.zero
    if not wasOpen or not Sheet.Panel.Visible then
        Motion.Set(Sheet.Panel, "Position", Sheet.Hidden)
    end
    Sheet.Panel.Visible = true
    Popup.ShowDim(Sheet.Dim, true)
    Motion.Spring(Sheet.Panel, "Position", Sheet.Home, "Normal", Sheet.OpenSpring)
    return { Container = content, Close = Sheet.Close, SetTitle = Sheet.SetTitle }
end

function Sheet.SetTitle(spec)
    Lang.Bind(Sheet.Title, spec or "")
end

function Sheet.HideDone(panel)
    if not State.Sheet then
        panel.Visible = false
    end
end

Sheet.OpenSpring = { Damping = 0.82 }
Sheet.CloseSpring = { OnDone = Sheet.HideDone }

---@param velocity number?  px/s fling carried into the close spring
function Sheet.Close(velocity)
    local sheet = State.Sheet
    if not sheet then
        return
    end
    State.Sheet = nil
    Popup.ShowDim(Sheet.Dim, false)
    Motion.Spring(Sheet.Panel, "Position", Sheet.Hidden, "Normal", Sheet.CloseSpring)
    if type(velocity) == "number" and velocity > 0 then
        Motion.Impulse(Sheet.Panel, "Position", { 0, 0, 0, velocity }, "Normal")
    end
    Util.Try(sheet.OnClose)
end

function Sheet.OnDragStart()
    Motion.Cancel(Sheet.Panel)
    Motion.Cancel(Sheet.Dim)
end

function Sheet.OnDragMove(delta)
    if not State.Sheet then
        return
    end
    local settings = Config.Overlay
    local offset = delta.Y < 0 and delta.Y * settings.SheetRubber or delta.Y
    Sheet.Panel.Position = Sheet.Home + UDim2.fromOffset(0, offset)
    local progress = math.clamp(offset / Sheet.Height, 0, 1)
    Sheet.Dim.BackgroundTransparency = settings.Dim + (1 - settings.Dim) * progress
end

function Sheet.OnDragEnd(moved, velocity)
    if not moved or not State.Sheet then
        return
    end
    local settings = Config.Overlay
    local offset = Sheet.Panel.Position.Y.Offset - Sheet.Home.Y.Offset
    if offset > Sheet.Height * settings.SheetClose or velocity.Y > settings.SheetFling then
        Sheet.Close(math.max(velocity.Y, 0))
        return
    end
    Motion.Spring(Sheet.Panel, "Position", Sheet.Home, "Normal", Sheet.OpenSpring)
    Motion.Spring(Sheet.Dim, "BackgroundTransparency", settings.Dim, "Fast")
end

Sheet.DragHandlers = { OnStart = Sheet.OnDragStart, OnMove = Sheet.OnDragMove, OnEnd = Sheet.OnDragEnd }

function Dialog.Build()
    if Dialog.Card and Dialog.Card.Parent then
        return
    end
    local settings = Config.Overlay
    local layer = Popup.Layer("Dialog")
    Dialog.Dim = Popup.Dim(layer, function()
        Dialog.Dismiss()
    end)
    local card, face = Popup.Card(layer, "CanvasGroup")
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Position = UDim2.fromScale(0.5, 0.5)
    card.Visible = false
    card.ZIndex = Config.Z.Text
    local header = Draw.Box("Frame", { Name = "Header", Size = UDim2.new(1, 0, 0, settings.DialogHeader), Parent = face }, "PanelHeader")
    Draw.Box("Frame", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 2), Parent = header }, "Outline")
    local iconSize = Platform.Metric("Icon") + 6
    Dialog.IconSlot = Draw.New("Frame", { Name = "Icon", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, settings.DialogPad, 0.5, -1), Size = UDim2.fromOffset(iconSize, iconSize), Parent = header })
    local textX = settings.DialogPad + iconSize + 10
    Dialog.Title = Draw.Text({ Position = UDim2.fromOffset(textX, 0), Size = UDim2.new(1, -textX - settings.DialogPad - 44, 1, -2), TextTruncate = Enum.TextTruncate.AtEnd, Parent = header }, "Display", Util.TextSize("Group") + 2, "Text")
    Popup.CloseButton(header, function()
        Dialog.Dismiss()
    end)
    Dialog.Host = Draw.New("Frame", { Name = "Body", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, settings.DialogHeader), Size = UDim2.new(1, 0, 1, -settings.DialogHeader), Parent = face })
    Dialog.Card = card
end

function Dialog.SetIcon(name)
    if Dialog.IconName == name then
        return
    end
    Dialog.IconName = name
    Dialog.IconSlot:ClearAllChildren()
    Sprite.New(Dialog.IconSlot, name, Dialog.IconSlot.Size.X.Offset)
end

---Body text + a row of buttons (stacked full width on Phone); a button closes unless its Callback returns false.
function Dialog.Fill(container, options, close)
    if options.Content then
        Gui.Text(container, options.Content, { Kind = "Desc", Size = Util.TextSize("Label"), Token = "Text" })
        container:Spacing(Config.Gap.Y * 2)
    end
    if options.Body then
        options.Body(container)
        container:Spacing(Config.Gap.Y * 2)
    end
    local buttons = options.Buttons or { { Text = Lang.Strings.OK, Style = "Primary" } }
    local stacked = Platform.Mode == "Phone"
    for index, spec in ipairs(buttons) do
        if index > 1 and not stacked then
            container:SameLine()
        end
        Gui.Button(container, {
            Text = spec.Text or spec.Title,
            Icon = spec.Icon,
            Style = spec.Style or (index == #buttons and "Primary" or "Default"),
            Width = not stacked and 1 / #buttons or nil,
            Callback = function()
                local callback = spec.Callback or spec.Func
                local keep = callback and select(2, Util.Try(callback))
                if keep ~= false then
                    close()
                end
            end,
        })
    end
end

function Dialog.Fit()
    local content = Dialog.Content
    if not content then
        return
    end
    local settings = Config.Overlay
    Dialog.Card.Size = UDim2.fromOffset(Dialog.Width + settings.Shadow + Popup.Edge(), settings.DialogHeader + content.ContentHeight + settings.Shadow + settings.Stroke + Popup.Edge())
end

---Modal confirm/choice; Phone shows it as a bottom sheet.
---@param options table  { Title, Content, Icon, Body(container)?, Buttons = { { Text, Style, Callback } }, Dismissable = true, OnClose }
---@return table  { Close }
function Dialog.Open(options)
    options = options or {}
    if Platform.Mode == "Phone" then
        Sheet.Open(options.Title or "Mario Hub", function(container)
            Dialog.Fill(container, options, Sheet.Close)
        end, { Height = "Auto", OnClose = options.OnClose })
        return { Close = Sheet.Close }
    end
    Popup.Close()
    Dialog.Build()
    local settings = Config.Overlay
    local view = Popup.Layer("Dialog").AbsoluteSize
    Dialog.Width = math.min(options.Width or settings.DialogWidth, view.X - settings.Margin * 2)
    Lang.Bind(Dialog.Title, options.Title or "Mario Hub")
    Dialog.SetIcon(options.Icon or "qblock")
    local content = Popup.Renew(Dialog, Dialog.Host, settings.DialogPad, 14, Dialog.Fit)
    content:SetWidth(Dialog.Width - settings.Stroke)
    State.Dialog = { Close = Dialog.Close, OnClose = options.OnClose, Dismissable = options.Dismissable ~= false }
    Dialog.Fill(content, options, Dialog.Close)
    Layout.Flush()
    Dialog.Fit()
    Popup.ShowDim(Dialog.Dim, true)
    Motion.Presence(Dialog.Card, true, Dialog.Presence)
    return { Close = Dialog.Close }
end

Dialog.Presence = { From = "Scale", Speed = "Fast" }

---Text field for Prompt; Numeric strips everything but a number as the user types.
---@return TextBox
function Dialog.PromptField(container, ask)
    local field = Draw.Box("Frame", { Name = "Field" }, "Element", "Outline", Platform.Metric("Radius"), 2)
    local box = Draw.Text({ ClassName = "TextBox", ClearTextOnFocus = false, Text = ask.Default ~= nil and tostring(ask.Default) or "", Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), Parent = field }, "Body", Util.TextSize("Label"), "Text")
    Lang.Bind(box, ask.Placeholder or "", "PlaceholderText")
    Theme.Bind(box, { PlaceholderColor3 = "Muted" })
    if ask.Numeric then
        Util.Connect(box:GetPropertyChangedSignal("Text"), function()
            local cleaned = box.Text:gsub("[^%d%.%-]", "")
            if cleaned ~= box.Text then
                box.Text = cleaned
            end
        end)
    end
    container:Add(field, { Height = Platform.Metric("Box") })
    return box
end

---One Selectable per choice; tapping one marks it as the answer.
function Dialog.PromptChoices(container, ask, answer)
    local handles = {}
    for index, choice in ipairs(ask.Choices) do
        handles[index] = Gui.Selectable(container, {
            Text = choice,
            Selected = answer.Index == index,
            Callback = function()
                answer.Index = index
                for other, handle in ipairs(handles) do
                    handle:SetSelected(other == index)
                end
            end,
        })
    end
end

---@return any, string?  the answer, or nil and why it is not acceptable yet
function Dialog.PromptValue(ask, answer)
    if ask.Choices then
        local choice = answer.Index and ask.Choices[answer.Index]
        return choice, choice == nil and Lang.Resolve(Lang.Strings.PromptPick) or nil
    end
    local text = answer.Box and answer.Box.Text or ""
    if not ask.Numeric then
        return text
    end
    local number = tonumber(text)
    if number == nil or number ~= number then
        return nil, Lang.Resolve(Lang.Strings.PromptNumber)
    end
    return number
end

---Asks for text, a number or one of Choices; Callback(value) runs on OK only. Phone = sheet.
---@param ask table  { Title, Content, Icon, Placeholder, Default, Numeric, Choices, Callback(value), OnClose }
---@return table     { Close }
function Dialog.Prompt(ask)
    ask = ask or {}
    local answer = {}
    if ask.Choices and ask.Default ~= nil then
        answer.Index = Widget.IndexOf(ask.Choices, ask.Default)
    end
    local function Confirm()
        local value, problem = Dialog.PromptValue(ask, answer)
        if problem then
            Notify.Push(ask.Title or "Mario Hub", problem, 2, "Warning")
            return false
        end
        if ask.Callback then
            Util.Try(ask.Callback, value)
        end
        return true
    end
    return Dialog.Open({
        Title = ask.Title or "Mario Hub",
        Content = ask.Content,
        Icon = ask.Icon or (ask.Choices and "list" or "edit"),
        OnClose = ask.OnClose,
        Body = function(container)
            if ask.Choices then
                Dialog.PromptChoices(container, ask, answer)
                return
            end
            answer.Box = Dialog.PromptField(container, ask)
        end,
        Buttons = {
            { Text = Lang.Strings.Cancel, Style = "Ghost" },
            { Text = Lang.Strings.OK, Style = "Primary", Callback = Confirm },
        },
    })
end

function Dialog.Dismiss()
    local dialog = State.Dialog
    if not dialog or not dialog.Dismissable then
        if dialog then
            Motion.Shake(Dialog.Card)
        end
        return
    end
    Dialog.Close()
end

function Dialog.Close()
    local dialog = State.Dialog
    if not dialog then
        return
    end
    State.Dialog = nil
    Popup.ShowDim(Dialog.Dim, false)
    Motion.Presence(Dialog.Card, false, Dialog.Presence)
    Util.Try(dialog.OnClose)
end

Tooltip.Bound = {}
Tooltip.Token = 0

function Tooltip.Build()
    if Tooltip.Frame and Tooltip.Frame.Parent then
        return
    end
    local card, face = Popup.Card(Popup.Layer("Tooltip"), "Frame", "Panel", 8)
    card.Visible = false
    Tooltip.Label = Draw.Text({ TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Position = UDim2.fromOffset(10, 6), Size = UDim2.new(1, -20, 1, -12), Parent = face }, "Desc", Util.TextSize("Desc") + 1, "Text")
    Tooltip.Frame = card
end

---Hover tip on desktop, long-press on touch. Calling again on the same frame swaps the text.
---@return table  binding { Spec, Disconnect() }
function Tooltip.Attach(frame, spec)
    local existing = Tooltip.Bound[frame]
    if existing then
        existing.Spec = spec
        return existing
    end
    local binding = { Spec = spec, Frame = frame }
    binding.Connections = {
        frame.MouseEnter:Connect(function()
            Tooltip.Hover(binding)
        end),
        frame.MouseLeave:Connect(Tooltip.Hide),
        frame.MouseMoved:Connect(function()
            Tooltip.Follow(binding)
        end),
        frame.InputBegan:Connect(function(input)
            Tooltip.TouchBegan(binding, input)
        end),
        frame.Destroying:Connect(function()
            binding:Disconnect()
        end),
    }
    binding.Disconnect = Tooltip.Detach
    Tooltip.Bound[frame] = binding
    return binding
end

function Tooltip.Detach(binding)
    for _, conn in ipairs(binding.Connections) do
        conn:Disconnect()
    end
    table.clear(binding.Connections)
    Tooltip.Bound[binding.Frame] = nil
    if Tooltip.Owner == binding then
        Tooltip.Hide()
    end
end

function Tooltip.Hover(binding)
    if Platform.Touch or Library.Unloaded then
        return
    end
    Tooltip.Token += 1
    task.delay(Config.TooltipDelay, Tooltip.HoverDue, binding, Tooltip.Token)
end

function Tooltip.HoverDue(binding, token)
    if Tooltip.Token ~= token or Library.Unloaded or not binding.Frame.Parent then
        return
    end
    local layer = Popup.Layer("Tooltip")
    Tooltip.Show(binding, Popup.ScreenToLocal(layer, UserInputService:GetMouseLocation()), false)
end

function Tooltip.TouchBegan(binding, input)
    if input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    Tooltip.Token += 1
    local start = Vector2.new(input.Position.X, input.Position.Y)
    task.delay(Config.Click.LongPress, Tooltip.LongPressDue, binding, input, start, Tooltip.Token)
end

function Tooltip.LongPressDue(binding, input, start, token)
    if Tooltip.Token ~= token or Library.Unloaded or input.UserInputState == Enum.UserInputState.End then
        return
    end
    local point = Vector2.new(input.Position.X, input.Position.Y)
    if (point - start).Magnitude > Config.Click.DragCancel then
        return
    end
    local press = Gui.Press
    if press.Active and press.Input == input then
        press.Long = true
        Gui.SetPressed(press.Binder, false)
    end
    local layer = Popup.Layer("Tooltip")
    Tooltip.Show(binding, point - layer.AbsolutePosition, true)
    task.delay(Config.Overlay.TooltipHold, Tooltip.HideIf, Tooltip.Token)
end

---@param point Vector2  layer-local anchor point
---@param above boolean  place above the point (finger) instead of below the cursor
function Tooltip.Show(binding, point, above)
    Tooltip.Build()
    local text = Lang.Resolve(binding.Spec)
    if text == "" then
        return
    end
    local label = Tooltip.Label
    label.Text = text
    local bounds = Layout.Measure(text, label.TextSize, "Desc", Config.Overlay.TooltipWidth)
    local shadow = Config.Overlay.Shadow
    Tooltip.Frame.Size = UDim2.fromOffset(math.ceil(bounds.X) + 20 + shadow, math.ceil(bounds.Y) + 12 + shadow)
    Tooltip.Owner, Tooltip.Above = binding, above
    Tooltip.Place(point)
    Tooltip.Frame.Visible = true
    Motion.Pop(Tooltip.Frame)
end

function Tooltip.Place(point)
    local frame = Tooltip.Frame
    local layer = Popup.Layer("Tooltip")
    local view, size = layer.AbsoluteSize, frame.AbsoluteSize
    local offset = Config.Overlay.TooltipOffset
    local margin = Config.Overlay.Margin
    local x = point.X + offset.X
    local y = Tooltip.Above and point.Y - size.Y - offset.Y * 2 or point.Y + offset.Y
    x = math.clamp(x, margin, math.max(margin, view.X - size.X - margin))
    y = math.clamp(y, margin, math.max(margin, view.Y - size.Y - margin))
    frame.Position = UDim2.fromOffset(x, y)
end

function Tooltip.Follow(binding)
    if Tooltip.Owner ~= binding or not Tooltip.Frame or not Tooltip.Frame.Visible or Tooltip.Above then
        return
    end
    Tooltip.Place(Popup.ScreenToLocal(Popup.Layer("Tooltip"), UserInputService:GetMouseLocation()))
end

function Tooltip.HideIf(token)
    if Tooltip.Token == token then
        Tooltip.Hide()
    end
end

function Tooltip.Hide()
    Tooltip.Token += 1
    Tooltip.Owner = nil
    if Tooltip.Frame then
        Tooltip.Frame.Visible = false
    end
end

Notify.Kinds = {
    Info = { Icon = "qblock", Token = "Info" },
    Success = { Icon = "star", Token = "Good" },
    Warn = { Icon = "bomb", Token = "Warn" },
    Error = { Icon = "boo", Token = "Bad" },
}
Notify.Aliases = { Warning = "Warn", Danger = "Error", Coin = "Success", Power = "Success" }
Notify.Active = {}
Notify.Entries = {}
Notify.Serial = 0
Notify.SlotSpring = { Damping = 0.78 }
Notify.Corner = "BottomRight"
Notify.Corners = { BottomRight = Vector2.new(1, 1), TopRight = Vector2.new(1, 0), BottomLeft = Vector2.new(0, 1), TopLeft = Vector2.new(0, 0) }

---@return Vector2  card anchor: the chosen corner, top-center on Phone
function Notify.Anchor()
    if Platform.Mode == "Phone" then
        return Vector2.new(0.5, 0)
    end
    return Notify.Corners[Notify.Corner]
end

---@param corner string  "BottomRight" | "TopRight" | "BottomLeft" | "TopLeft" (Phone always stacks top-center)
function Notify.SetPosition(corner)
    if not Notify.Corners[corner] then
        return
    end
    Notify.Corner = corner
    if not Notify.Host then
        return
    end
    for _, entry in ipairs(Notify.Active) do
        entry.Frame.AnchorPoint = Notify.Anchor()
    end
    Notify.Reflow()
end

function Notify.Build()
    Notify.Host = Popup.Layer("Notify")
end

function Notify.IsOptions(value)
    return type(value) == "table" and (value.Title ~= nil or value.Content ~= nil or value.Kind ~= nil or value.Action ~= nil)
end

---@return table  { Title, Content, Duration, Kind, Action }
function Notify.Options(title, content, duration, kind, action)
    local source = Notify.IsOptions(title) and title or { Title = title, Content = content, Duration = duration, Kind = kind, Action = action }
    local kindName = Notify.Aliases[source.Kind] or source.Kind
    return {
        Title = source.Title or "Mario Hub",
        Content = source.Content or "",
        Duration = tonumber(source.Duration) or Config.Notify.Duration,
        Kind = Notify.Kinds[kindName] and kindName or "Info",
        Action = type(source.Action) == "table" and source.Action or nil,
    }
end

function Notify.MakeCard()
    local settings = Config.Overlay
    local card, face = Popup.Card(nil, "CanvasGroup")
    card.Name = "Notification"
    local entry = { Frame = card, Face = face }
    entry.Bar = Draw.New("Frame", { Name = "Bar", Size = UDim2.new(0, settings.NotifyBar, 1, 0), Parent = face })
    entry.Icon = Draw.New("Frame", { Name = "Icon", BackgroundTransparency = 1, Parent = face })
    entry.Title = Draw.Text({ Name = "Title", TextTruncate = Enum.TextTruncate.AtEnd, Parent = face }, "Body", Util.TextSize("Label"), "Text")
    entry.Body = Draw.Text({ Name = "Body", TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Parent = face }, "Desc", Util.TextSize("Desc"), "SubText")
    entry.Badge = Draw.Box("Frame", { Name = "Badge", AnchorPoint = Vector2.new(1, 0), Visible = false, Parent = face }, "Coin", "Outline", UDim.new(1, 0), 2)
    entry.BadgeLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Parent = entry.Badge }, "Strong", Util.TextSize("Small"), "Ink")
    entry.Action = Draw.Box("Frame", { Name = "Action", Visible = false, Parent = face }, "Element", "Outline", 6, 2)
    entry.ActionLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Parent = entry.Action }, "Strong", Util.TextSize("Small") + 1, "Text")
    entry.Timer = Draw.New("Frame", { Name = "Timer", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Parent = face })
    Gui.Clickable(card, {
        OnClick = function(input)
            Notify.Clicked(entry, input)
        end,
        OnHover = function(hovered)
            entry.Hovered = hovered
        end,
    })
    Notify.Entries[card] = entry
    return card
end

function Notify.Clicked(entry, input)
    local action = entry.ActionSpec
    if action and entry.Action.Visible and Util.Inside(entry.Action, input.Position) then
        Util.Try(action.Callback or action.Func)
    end
    Notify.Dismiss(entry)
end

function Notify.SetIcon(entry, kindName)
    if entry.KindName == kindName then
        return
    end
    entry.KindName = kindName
    entry.Icon:ClearAllChildren()
    local size = Config.Overlay.NotifyIcon[Platform.Mode]
    Sprite.New(entry.Icon, Notify.Kinds[kindName].Icon, size)
end

---@return number  card width for the current mode
function Notify.Width()
    local view = Notify.Host.AbsoluteSize
    local width = Platform.Mode == "Phone" and Config.Notify.TouchWidth or Config.Notify.Width
    return math.min(width, view.X - Config.Overlay.Margin * 2)
end

function Notify.Measure(entry)
    local settings = Config.Overlay
    local pad, shadow = settings.NotifyPad, settings.Shadow + Popup.Edge()
    local icon = settings.NotifyIcon[Platform.Mode]
    local width = Notify.Width()
    local textX = settings.NotifyBar + pad + icon + pad
    local textWidth = width - shadow - textX - pad
    local titleHeight = entry.Title.TextSize + 4
    local body = entry.Body.Text
    local bodyHeight = body ~= "" and Layout.Measure(body, entry.Body.TextSize, "Desc", textWidth).Y or 0
    local actionHeight = entry.ActionSpec and settings.NotifyAction + 6 or 0
    local inner = pad + titleHeight + (bodyHeight > 0 and bodyHeight + 2 or 0) + actionHeight + pad + settings.NotifyTimer
    local height = math.max(inner, icon + pad * 2 + settings.NotifyTimer)
    entry.Icon.Position, entry.Icon.Size = UDim2.fromOffset(settings.NotifyBar + pad, pad), UDim2.fromOffset(icon, icon)
    local badgeWidth = entry.Badge.Visible and 34 + pad or 0
    local alone = bodyHeight == 0 and actionHeight == 0
    local titleY = alone and math.floor((height - settings.NotifyTimer - titleHeight) / 2) or pad - 2
    entry.Title.Position, entry.Title.Size = UDim2.fromOffset(textX, titleY), UDim2.fromOffset(textWidth - badgeWidth, titleHeight)
    entry.Body.Position, entry.Body.Size = UDim2.fromOffset(textX, pad + titleHeight), UDim2.fromOffset(textWidth, bodyHeight)
    entry.Badge.Position, entry.Badge.Size = UDim2.new(1, -pad, 0, titleY + 1), UDim2.fromOffset(34, titleHeight - 2)
    entry.Action.Position = UDim2.fromOffset(textX, pad + titleHeight + (bodyHeight > 0 and bodyHeight + 4 or 2))
    entry.Action.Size = UDim2.fromOffset(math.min(textWidth, entry.ActionLabel.TextBounds.X + 24), settings.NotifyAction)
    entry.Timer.Size = UDim2.new(1, 0, 0, settings.NotifyTimer)
    entry.Frame.Size = UDim2.fromOffset(width, height + shadow)
    entry.Height = height + shadow
end

function Notify.Fill(entry, options)
    local token = Notify.Kinds[options.Kind].Token
    Notify.Serial += 1
    entry.Serial, entry.Key, entry.Count = Notify.Serial, Notify.Key(options), 1
    entry.Duration, entry.Remaining, entry.Closing, entry.Hovered, entry.Fresh = options.Duration, options.Duration, false, false, true
    entry.ActionSpec = options.Action
    Theme.Bind(entry.Bar, { BackgroundColor3 = token })
    Theme.Bind(entry.Timer, { BackgroundColor3 = token })
    Notify.SetIcon(entry, options.Kind)
    entry.Title.Text = Lang.Resolve(options.Title)
    entry.Body.Text = Lang.Resolve(options.Content)
    entry.Badge.Visible = false
    entry.Action.Visible = options.Action ~= nil
    entry.ActionLabel.Text = options.Action and Lang.Resolve(options.Action.Text or options.Action.Title) or ""
    entry.Frame.AnchorPoint = Notify.Anchor()
    entry.Frame.GroupTransparency = 1
    Notify.Measure(entry)
end

function Notify.Key(options)
    return table.concat({ options.Kind, Lang.Resolve(options.Title), Lang.Resolve(options.Content) }, "\0")
end

function Notify.Find(key)
    for _, entry in ipairs(Notify.Active) do
        if entry.Key == key and not entry.Closing then
            return entry
        end
    end
    return nil
end

function Notify.Bump(entry, options)
    entry.Count += 1
    entry.Duration = math.max(entry.Duration, options.Duration)
    entry.Remaining = entry.Duration
    entry.BadgeLabel.Text = "x" .. entry.Count
    entry.Badge.Visible = true
    Notify.Measure(entry)
    Motion.Pop(entry.Badge)
    Motion.Impulse(entry.Frame, "Position", { 0, 0, 0, Notify.Anchor().Y == 1 and -90 or 90 }, "Fast", 0.45)
end

---@return UDim2  where a card sits off-screen before entering / after leaving
function Notify.Offscreen(entry)
    local enter = Config.Overlay.NotifyEnter
    if Platform.Mode == "Phone" then
        return entry.Slot - UDim2.fromOffset(0, entry.Height + enter)
    end
    local side = Notify.Anchor().X == 1 and 1 or -1
    return entry.Slot + UDim2.fromOffset(side * (Notify.Width() + enter), 0)
end

---@return UDim2  stack slot at offset px from the anchored edge
function Notify.SlotAt(offset, top, bottom)
    local margin = Config.Overlay.Margin
    if Platform.Mode == "Phone" then
        return UDim2.new(0.5, 0, 0, top + margin + offset)
    end
    local anchor = Notify.Anchor()
    local x = anchor.X == 1 and UDim2.new(1, -margin, 0, 0) or UDim2.fromOffset(margin, 0)
    local y = anchor.Y == 1 and UDim2.new(0, 0, 1, -(bottom + margin + offset)) or UDim2.fromOffset(0, top + margin + offset)
    return x + y
end

---The watermark is a floating card too; a stack anchored on its edge starts past it instead of covering it.
---@return number  px the stack must skip from its anchored edge
function Notify.Clearance(top, bottom)
    local mark = Watermark.Frame
    if not (mark and mark.Parent and mark.Visible and mark.Parent.Visible) then
        return 0
    end
    local layer, margin = Notify.Host, Config.Overlay.Margin
    local view, width = layer.AbsoluteSize, Notify.Width()
    local anchor = Notify.Anchor()
    local left = anchor.X == 1 and view.X - margin - width or anchor.X == 0 and margin or (view.X - width) / 2
    local origin = mark.AbsolutePosition - layer.AbsolutePosition
    local size = mark.AbsoluteSize
    if origin.X > left + width or origin.X + size.X < left then
        return 0
    end
    if anchor.Y == 1 then
        local edge = view.Y - bottom - margin
        return origin.Y + size.Y > view.Y / 2 and math.max(0, edge - origin.Y + Config.Notify.Gap) or 0
    end
    local edge = top + margin
    return origin.Y < view.Y / 2 and math.max(0, origin.Y + size.Y - edge + Config.Notify.Gap) or 0
end

function Notify.Reflow()
    local layer = Notify.Host
    local top, bottom = Popup.Insets(layer)
    local offset = Notify.Clearance(top, bottom)
    for index = #Notify.Active, 1, -1 do
        local entry = Notify.Active[index]
        entry.Slot = Notify.SlotAt(offset, top, bottom)
        if entry.Fresh then
            entry.Fresh = false
            entry.Frame.Position = Notify.Offscreen(entry)
        end
        Motion.Spring(entry.Frame, "Position", entry.Slot, "Normal", Notify.SlotSpring)
        offset += entry.Height + Config.Notify.Gap
    end
end

---@param title any  text spec, or an options table { Title, Content, Duration, Kind, Action = { Text, Callback } }
---@param kind string?  "Info" | "Success" | "Warn" | "Error"
---@return table?  { Dismiss() }
function Notify.Push(title, content, duration, kind, action)
    if Library.Unloaded or not State.Gui then
        return nil
    end
    Notify.Build()
    local options = Notify.Options(title, content, duration, kind, action)
    local entry = Notify.Find(Notify.Key(options))
    if entry then
        Notify.Bump(entry, options)
        return Notify.Handle(entry)
    end
    entry = Notify.Entries[Draw.Pool("Notify", Notify.MakeCard).Acquire()]
    Notify.Fill(entry, options)
    entry.Frame.Parent = Notify.Host
    table.insert(Notify.Active, entry)
    local limit = Config.Overlay.NotifyMax[Platform.Mode]
    while #Notify.Active > limit do
        Notify.Dismiss(Notify.Active[1])
    end
    Notify.Reflow()
    Motion.Spring(entry.Frame, "GroupTransparency", 0, "Fast")
    Motion.Pop(entry.Icon)
    Notify.StartClock()
    return Notify.Handle(entry)
end

function Notify.Handle(entry)
    local serial = entry.Serial
    return {
        Dismiss = function()
            if entry.Serial == serial then
                Notify.Dismiss(entry)
            end
        end,
    }
end

function Notify.Released(card)
    Draw.Pool("Notify", Notify.MakeCard).Release(card)
end

Notify.ExitSpring = { OnDone = Notify.Released }

function Notify.Dismiss(entry)
    if entry.Closing then
        return
    end
    entry.Closing = true
    local index = table.find(Notify.Active, entry)
    if index then
        table.remove(Notify.Active, index)
    end
    Notify.Reflow()
    Motion.Spring(entry.Frame, "Position", Notify.Offscreen(entry), "Normal")
    Motion.Spring(entry.Frame, "GroupTransparency", 1, "Fast", Notify.ExitSpring)
end

---Timers are ticked by the single services frame loop while this flag is set.
function Notify.StartClock()
    Notify.Ticking = true
end

function Notify.StopClock()
    Notify.Ticking = false
end

function Notify.Tick(deltaTime)
    local active = Notify.Active
    local timerHeight = Config.Overlay.NotifyTimer
    for index = #active, 1, -1 do
        local entry = active[index]
        if entry and not entry.Hovered then
            entry.Remaining -= deltaTime
            entry.Timer.Size = UDim2.new(math.max(entry.Remaining / entry.Duration, 0), 0, 0, timerHeight)
            if entry.Remaining <= 0 then
                Notify.Dismiss(entry)
            end
        end
    end
    if #active == 0 then
        Notify.StopClock()
    end
end

table.insert(State.UnloadHooks, Notify.StopClock)

Float.Store = { Data = nil, Pending = false }
Float.Placed = {}

---@return table  saved overlay positions + pins (file, or memory when the executor can't write)
function Float.ReadStore()
    local store = Float.Store
    if store.Data then
        return store.Data
    end
    store.Data = {}
    local path = Config.Overlay.Store
    local raw = Util.FileApi() and Util.SafeFile(isfile, path) == true and Util.SafeFile(readfile, path)
    if type(raw) ~= "string" then
        return store.Data
    end
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
    if ok and type(decoded) == "table" then
        store.Data = decoded
    end
    return store.Data
end

function Float.Recall(key)
    return Float.ReadStore()[key]
end

function Float.Remember(key, value)
    Float.ReadStore()[key] = value
    if Float.Store.Pending then
        return
    end
    Float.Store.Pending = true
    task.delay(Config.Overlay.SaveDelay, Float.FlushStore)
end

function Float.FlushStore()
    Float.Store.Pending = false
    if not Util.FileApi() then
        return
    end
    local ok, encoded = pcall(HttpService.JSONEncode, HttpService, Float.Store.Data or {})
    if not ok then
        return
    end
    Util.EnsureFolder(Config.Root)
    Util.SafeFile(writefile, Config.Overlay.Store, encoded)
end

---Moves a center-anchored overlay frame, clamped inside the safe area.
function Float.MoveTo(frame, center)
    local layer = frame.Parent
    if not layer then
        return
    end
    local view, half = layer.AbsoluteSize, frame.AbsoluteSize / 2
    local top, bottom = Popup.Insets(layer)
    local x = math.clamp(center.X, half.X, math.max(half.X, view.X - half.X))
    local y = math.clamp(center.Y, top + half.Y, math.max(top + half.Y, view.Y - bottom - half.Y))
    frame.Position = UDim2.fromOffset(math.floor(x + 0.5), math.floor(y + 0.5))
end

---@param fallback Vector2  default center as a fraction of the layer
function Float.Place(frame, key, fallback)
    Float.Placed[frame] = { Key = key, Fallback = fallback }
    Float.EnsureReclamp(frame.Parent)
    local saved = Float.Recall(key)
    local fraction = type(saved) == "table" and tonumber(saved[1]) and Vector2.new(saved[1], tonumber(saved[2]) or fallback.Y) or fallback
    Float.MoveTo(frame, fraction * frame.Parent.AbsoluteSize)
end

function Float.EnsureReclamp(layer)
    if not layer or layer:GetAttribute("Reclamp") then
        return
    end
    layer:SetAttribute("Reclamp", true)
    Util.Connect(layer:GetPropertyChangedSignal("AbsoluteSize"), Float.Reclamp)
end

function Float.Reclamp()
    for frame, placed in pairs(Float.Placed) do
        if not frame.Parent then
            Float.Placed[frame] = nil
            continue
        end
        Float.Place(frame, placed.Key, placed.Fallback)
    end
end

---@return table  drag handlers that move frame and remember it under key
function Float.Mover(frame, key)
    local mover = {}
    function mover.OnStart()
        local layer = frame.Parent
        mover.From = frame.AbsolutePosition - layer.AbsolutePosition + frame.AbsoluteSize / 2
        Motion.Set(frame, "Position", frame.Position)
    end
    function mover.OnMove(delta)
        Float.MoveTo(frame, mover.From + delta)
    end
    function mover.OnEnd(moved)
        if not moved or not frame.Parent then
            return
        end
        local center = frame.AbsolutePosition - frame.Parent.AbsolutePosition + frame.AbsoluteSize / 2
        local view = frame.Parent.AbsoluteSize
        Float.Remember(key, { Util.Round(center.X / view.X, 4), Util.Round(center.Y / view.Y, 4) })
    end
    return mover
end

function Float.Build()
    if Float.Button and Float.Button.Parent then
        return Float.Button
    end
    local settings = Config.Overlay.Float
    local size = Float.SizeOverride or settings[Platform.Mode]
    local layer = Popup.Layer("Float")
    local button = Gui.Hitbox("Float")
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.Size = UDim2.fromOffset(size, size)
    button.Visible = Float.Wanted == nil and Platform.Touch or Float.Wanted == true
    button.Parent = layer
    Draw.Box("Frame", { Name = "Shadow", Position = UDim2.fromOffset(4, 4), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0.35, Parent = button }, "Shadow", nil, 4)
    Float.Slot = Draw.New("Frame", { Name = "Slot", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = button })
    Float.Button, Float.Size = button, size
    Float.Sync()
    Float.Place(button, "Float", Vector2.new((18 + size / 2) / math.max(layer.AbsoluteSize.X, 1), 0.45))
    Gui.Clickable(button, { OnPress = Float.OnPress, OnClick = Float.OnClick })
    Popup.Track(button, Float.Mover(button, "Float"))
    task.delay(settings.HopEvery, Float.Hop)
    return button
end

---Shows the ?-block while the menu is closed and the used block while it's open.
function Float.Sync()
    local window = State.Window or Library.Window
    local open = window ~= nil and window.Visible ~= false and not window.Minimized
    QuickBar.Apply(open)
    if not Float.Slot then
        return
    end
    local art = open and "used" or "qblock"
    if Float.Art == art then
        return
    end
    Float.Art = art
    Float.Slot:ClearAllChildren()
    Sprite.New(Float.Slot, art, Float.Size)
end

function Float.OnPress(pressed)
    Motion.Spring(Float.Slot, "Position", UDim2.fromOffset(0, pressed and Config.Overlay.Float.Sink or 0), "Fast")
end

function Float.OnClick()
    Motion.Impulse(Float.Slot, "Position", { 0, 0, 0, -Config.Overlay.Float.Hop }, "Fast", 0.4)
    Motion.CoinPop(Float.Button, UDim2.fromScale(0.5, 0))
    local window = State.Window or Library.Window
    if window and window.Toggle then
        window:Toggle()
    end
    Float.Sync()
end

function Float.Hop()
    local button = Float.Button
    if Library.Unloaded or not button or not button.Parent then
        return
    end
    local settings = Config.Overlay.Float
    task.delay(settings.HopEvery, Float.Hop)
    Float.Sync()
    if not button.Visible or Motion.Reduced or Float.Art ~= "qblock" or Popup.Drag.Active then
        return
    end
    Motion.Impulse(Float.Slot, "Position", { 0, 0, 0, -settings.Hop * 0.6 }, "Normal", 0.35)
end

---@param size number  px (clamped 44-96)
function Float.SetSize(size)
    Float.SizeOverride = math.clamp(math.floor(tonumber(size) or Config.Overlay.Float[Platform.Mode]), 44, 96)
    local button = Float.Button
    if not button then
        return
    end
    Float.Size = Float.SizeOverride
    button.Size = UDim2.fromOffset(Float.Size, Float.Size)
    Float.Art = nil
    Float.Sync()
    Float.Reclamp()
end

function Float.SetVisible(visible)
    Float.Wanted = visible == true
    if Float.Button then
        Float.Button.Visible = Float.Wanted
        Float.Sync()
    end
end

QuickBar.Pins = {}
QuickBar.Order = {}

function QuickBar.OptionOf(idx)
    return Library.Toggles[idx] or Library.Options[idx]
end

function QuickBar.LabelOf(option, idx)
    local spec = option.Text or (type(option.Info) == "table" and option.Info.Text)
    if type(spec) == "string" or type(spec) == "table" then
        return spec
    end
    return tostring(idx)
end

function QuickBar.Build(idx, option)
    local settings = Config.Overlay.QuickBar
    local height = settings.Height[Platform.Mode]
    local depth = Platform.Metric("Depth")
    local chip = Gui.Hitbox("Pin_" .. tostring(idx))
    chip.AnchorPoint = Vector2.new(0.5, 0.5)
    chip.Size = UDim2.fromOffset(settings.Width, height + depth)
    chip.Parent = Popup.Layer("QuickBar")
    local face, shade = Gui.BuildBlock(chip, "Default", depth, Platform.Metric("Radius"))
    local lamp = Draw.Box("Frame", { Name = "Lamp", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(settings.Lamp, settings.Lamp), Parent = face }, "Track", "Outline", UDim.new(1, 0), 2)
    local textX = 14 + settings.Lamp
    local label = Draw.Text({ Position = UDim2.fromOffset(textX, 0), Size = UDim2.new(1, -textX - 8, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = face }, "Body", Util.TextSize("Small") + 1, "Text", QuickBar.LabelOf(option, idx))
    return { Idx = idx, Frame = chip, Face = face, Shade = shade, Lamp = lamp, Label = label, Depth = depth }
end

---Pins a toggle as a floating on/off chip (draggable, remembered).
---@return table?  entry, nil if idx isn't a registered option
function QuickBar.Add(idx)
    if QuickBar.Pins[idx] then
        return QuickBar.Pins[idx]
    end
    local option = QuickBar.OptionOf(idx)
    if not option then
        return nil
    end
    local entry = QuickBar.Build(idx, option)
    QuickBar.Pins[idx] = entry
    table.insert(QuickBar.Order, idx)
    Gui.Clickable(entry.Frame, {
        OnPress = function(pressed)
            Motion.Spring(entry.Face, "Position", UDim2.fromOffset(0, pressed and entry.Depth - 1 or 0), "Fast")
        end,
        OnClick = function(input)
            QuickBar.Flip(entry, input)
        end,
    })
    Popup.Track(entry.Frame, Float.Mover(entry.Frame, QuickBar.Key(idx)))
    Float.Place(entry.Frame, QuickBar.Key(idx), QuickBar.DefaultSpot(#QuickBar.Order))
    QuickBar.Render(entry, true)
    QuickBar.SavePins()
    QuickBar.EnsureSync()
    return entry
end

---@return Vector2  default center fraction: columns on the right edge, wrapping leftward when one is full
function QuickBar.DefaultSpot(slot)
    local settings = Config.Overlay.QuickBar
    local view = Popup.Layer("QuickBar").AbsoluteSize
    local height = settings.Height[Platform.Mode] + Platform.Metric("Depth")
    local margin, top = Config.Overlay.Margin, view.Y * 0.3
    local perColumn = math.max(1, math.floor((view.Y - top - margin + settings.Gap) / (height + settings.Gap)))
    local column, row = (slot - 1) // perColumn, (slot - 1) % perColumn
    local x = view.X - margin - settings.Width / 2 - column * (settings.Width + settings.Gap)
    local y = top + height / 2 + row * (height + settings.Gap)
    return Vector2.new(x / math.max(view.X, 1), y / math.max(view.Y, 1))
end

function QuickBar.Flip(entry, input)
    local option = QuickBar.OptionOf(entry.Idx)
    if not option or type(option.SetValue) ~= "function" then
        return
    end
    Motion.Ripple(entry.Face, input and input.Position)
    option:SetValue(not option.Value)
    QuickBar.Render(entry)
end

function QuickBar.Render(entry, instant)
    local option = QuickBar.OptionOf(entry.Idx)
    local on = option ~= nil and option.Value == true
    if entry.On == on and not instant then
        return
    end
    entry.On = on
    Theme.Bind(entry.Face, { BackgroundColor3 = on and "Good" or "Element" })
    Theme.Bind(entry.Shade, { BackgroundColor3 = on and "GoodDark" or "Pressed" })
    Theme.Bind(entry.Label, { TextColor3 = on and "White" or "Text" })
    Theme.Bind(entry.Lamp, { BackgroundColor3 = on and "Coin" or "Track" })
    if not instant then
        Motion.Pop(entry.Lamp)
    end
end

function QuickBar.EnsureSync()
    if QuickBar.Syncing then
        return
    end
    QuickBar.Syncing = true
    Util.Every(Config.Overlay.QuickBar.Sync, QuickBar.Sync)
end

function QuickBar.Sync()
    for idx, entry in pairs(QuickBar.Pins) do
        if not entry.Frame.Parent or not QuickBar.OptionOf(idx) then
            QuickBar.Remove(idx)
            continue
        end
        QuickBar.Render(entry)
    end
end

function QuickBar.Remove(idx)
    local entry = QuickBar.Pins[idx]
    if not entry then
        return
    end
    QuickBar.Pins[idx] = nil
    local index = table.find(QuickBar.Order, idx)
    if index then
        table.remove(QuickBar.Order, index)
    end
    Float.Placed[entry.Frame] = nil
    entry.Frame:Destroy()
    Float.Remember(QuickBar.Key(idx), nil)
    QuickBar.SavePins()
end

function QuickBar.Has(idx)
    return QuickBar.Pins[idx] ~= nil
end

---@return boolean  pinned after the call
function QuickBar.Toggle(idx)
    if QuickBar.Pins[idx] then
        QuickBar.Remove(idx)
        return false
    end
    return QuickBar.Add(idx) ~= nil
end

---Pins belong to one game's hub: keyed by its config folder so another script never shows them.
---@param idx any?  nil = the pin list key
function QuickBar.Key(idx)
    local scope = Configs.Folder or "default"
    return idx == nil and ("Pins:" .. scope) or ("Pin:" .. scope .. ":" .. tostring(idx))
end

function QuickBar.SavePins()
    local pins = table.clone(QuickBar.Order)
    for index, idx in ipairs(pins) do
        pins[index] = tostring(idx)
    end
    Float.Remember(QuickBar.Key(), pins)
end

---Re-pins what the user pinned last session; call once options exist (after OnUnlocked).
function QuickBar.Restore()
    local pins = Float.Recall(QuickBar.Key())
    if type(pins) ~= "table" then
        return
    end
    for _, idx in ipairs(pins) do
        QuickBar.Add(idx)
    end
end

QuickBar.Wanted = true

function QuickBar.SetVisible(visible)
    QuickBar.Wanted = visible ~= false
    Float.Sync()
end

---A phone menu covers the whole screen, so pins and the watermark step aside while it is open.
function QuickBar.Apply(menuOpen)
    if not State.Gui then
        return
    end
    local covered = menuOpen and Platform.Mode == "Phone"
    Popup.Layer("QuickBar").Visible = QuickBar.Wanted and not covered
    Popup.Layer("Watermark").Visible = not covered
end

Watermark.Buckets = { { 50, "Good" }, { 30, "Warn" }, { 0, "Bad" } }

function Watermark.Build(title)
    if Watermark.Frame and Watermark.Frame.Parent then
        Watermark.SetTitle(title)
        return Watermark.Frame
    end
    local settings = Config.Overlay.Watermark
    local card, face = Popup.Card(Popup.Layer("Watermark"), "Frame", "Topbar", 10)
    card.Name = "Watermark"
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Size = UDim2.fromOffset(200, settings.Height + Config.Overlay.Shadow)
    local row = Draw.New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = face })
    Draw.Padding(row, 0, settings.PadX, 0, settings.PadX - 2)
    Draw.List(row, settings.Gap, true, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    local coin = Sprite.New(row, "coin", settings.Coin)
    coin.LayoutOrder = 1
    Watermark.Title = Draw.Text({ AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), LayoutOrder = 2, Parent = row }, "Logo", Util.TextSize("Watermark") + 1, "Coin")
    Draw.Stroke(Watermark.Title, "Ink", 1.5)
    Watermark.Stats = {}
    for index, key in ipairs({ "Fps", "Ping", "Time" }) do
        Watermark.Stats[key] = Draw.Text({ AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), LayoutOrder = 2 + index, Parent = row }, "Body", Util.TextSize("Watermark"), "TopbarText")
    end
    Watermark.Frame, Watermark.Row = card, row
    Watermark.SetTitle(title)
    Popup.Track(card, Float.Mover(card, "Watermark"))
    Util.Every(settings.Every, Watermark.Update)
    return card
end

---Default spot is top-left under the Roblox topbar, clear of centered game HUDs; a dragged spot is remembered.
function Watermark.SetTitle(title)
    if not Watermark.Frame then
        return
    end
    Watermark.Title.Text = Lang.Resolve(title or "Mario Hub"):upper()
    Watermark.Update()
    Watermark.Resize()
    local layer = Popup.Layer("Watermark")
    local ok, inset = pcall(GuiService.GetGuiInset, GuiService)
    local top = math.max(Popup.Insets(layer), ok and inset.Y or 0)
    local size, view = Watermark.Frame.Size, layer.AbsoluteSize
    local margin = Config.Overlay.Margin
    local center = Vector2.new(margin + size.X.Offset / 2, top + margin + size.Y.Offset / 2)
    Float.Place(Watermark.Frame, "Watermark", center / Vector2.new(math.max(view.X, 1), math.max(view.Y, 1)))
end

---@return string  theme token for the current FPS
function Watermark.FpsToken(fps)
    for _, bucket in ipairs(Watermark.Buckets) do
        if fps >= bucket[1] then
            return bucket[2]
        end
    end
    return "Bad"
end

function Watermark.Update()
    local frame = Watermark.Frame
    if not frame or not frame.Parent or not frame.Visible then
        return
    end
    local ok, ping = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    local fps = math.floor(State.Fps + 0.5)
    local elapsed = math.floor(os.clock() - State.StartTime)
    local stats = Watermark.Stats
    stats.Fps.Text = string.format("FPS %d", fps)
    stats.Ping.Text = ok and string.format("%dms", math.floor(ping + 0.5)) or "--ms"
    stats.Time.Text = string.format("%s %02d:%02d", Lang.Get("Session"), math.floor(elapsed / 60) % 100, elapsed % 60)
    local token = Watermark.FpsToken(fps)
    if Watermark.FpsTone ~= token then
        Watermark.FpsTone = token
        Theme.Bind(stats.Fps, { TextColor3 = token })
    end
    Watermark.Resize()
end

function Watermark.Resize()
    local settings = Config.Overlay.Watermark
    local width = settings.PadX * 2 + settings.Coin
    for _, child in ipairs(Watermark.Row:GetChildren()) do
        if child:IsA("TextLabel") then
            width += child.TextBounds.X + settings.Gap
        end
    end
    local size = UDim2.fromOffset(math.ceil(width) + Config.Overlay.Shadow + Config.Overlay.Stroke, settings.Height + Config.Overlay.Shadow)
    if Watermark.Frame.Size ~= size then
        Watermark.Frame.Size = size
    end
end

function Watermark.SetVisible(visible)
    if not Watermark.Frame then
        return
    end
    Watermark.Frame.Visible = visible ~= false
    Watermark.Update()
end

KeybindList.Rows = {}

function KeybindList.Build()
    if KeybindList.Frame and KeybindList.Frame.Parent then
        return KeybindList.Frame
    end
    local settings = Config.Overlay.KeybindList
    local layer = Popup.Layer("Watermark")
    local card, face = Popup.Card(layer, "Frame", "Panel", 10)
    card.Name = "Keybinds"
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Visible = false
    card.Size = UDim2.fromOffset(settings.Width + Config.Overlay.Shadow, settings.Header + settings.Row + 10)
    local header = Draw.Box("Frame", { Name = "Header", Size = UDim2.new(1, 0, 0, settings.Header), Parent = face }, "PanelHeader")
    Draw.Box("Frame", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 2), Parent = header }, "Outline")
    local icon = Sprite.New(header, "key", 16)
    icon.AnchorPoint, icon.Position = Vector2.new(0, 0.5), UDim2.new(0, 10, 0.5, -1)
    Draw.Text({ Position = UDim2.fromOffset(32, 0), Size = UDim2.new(1, -40, 1, -2), Parent = header }, "Display", Util.TextSize("Section") + 1, "Text", Lang.Strings.Keybinds)
    KeybindList.List = Draw.New("Frame", { Name = "List", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, settings.Header + 4), Size = UDim2.new(1, 0, 1, -settings.Header - 4), Parent = face })
    KeybindList.Empty = Draw.Text({ Size = UDim2.new(1, -20, 0, settings.Row), Position = UDim2.fromOffset(10, 0), Parent = KeybindList.List }, "Desc", Util.TextSize("Desc"), "Muted", Lang.Strings.NoKeybinds)
    KeybindList.Frame = card
    Float.Place(card, "Keybinds", Vector2.new((Config.Overlay.Margin + settings.Width / 2) / math.max(layer.AbsoluteSize.X, 1), 0.42))
    Popup.Track(card, Float.Mover(card, "Keybinds"))
    Util.Every(settings.Every, KeybindList.Refresh)
    return card
end

function KeybindList.MakeRow()
    local settings = Config.Overlay.KeybindList
    local row = Draw.New("Frame", { Name = "Row", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, settings.Row) })
    Draw.Box("Frame", { Name = "Lamp", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(8, 8), Parent = row }, "Track", "Outline", UDim.new(1, 0), 1)
    Draw.Text({ Name = "Caption", Position = UDim2.fromOffset(28, 0), Size = UDim2.new(1, -96, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = row }, "Desc", Util.TextSize("Desc"), "Text")
    local key = Draw.Box("Frame", { Name = "Key", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(56, settings.Row - 6), Parent = row }, "Element", "Outline", 5, 1)
    Draw.Text({ Name = "Label", Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Parent = key }, "Strong", Util.TextSize("Small"), "SubText")
    return row
end

function KeybindList.LabelOf(picker)
    local linked = type(picker.Linked) == "table" and picker.Linked or nil
    for _, spec in ipairs({ picker.Text, linked and linked.Text, picker.Idx }) do
        if type(spec) == "string" or type(spec) == "table" then
            return Lang.Resolve(spec)
        end
    end
    return "Key"
end

function KeybindList.StateOf(picker)
    if type(picker.GetState) ~= "function" then
        return false
    end
    return picker:GetState() == true
end

---@return table[]  bound pickers still alive, in registration order
function KeybindList.Collect()
    local bound = {}
    for _, picker in ipairs(State.KeyPickers) do
        local key = picker.Value
        if type(key) == "string" and key ~= "None" and key ~= "" and not picker.Destroyed then
            bound[#bound + 1] = picker
        end
        if #bound >= Config.Overlay.KeybindList.Max then
            break
        end
    end
    return bound
end

function KeybindList.Refresh()
    local frame = KeybindList.Frame
    if not frame or not frame.Parent or not frame.Visible then
        return
    end
    local pickers = KeybindList.Collect()
    local pool = Draw.Pool("KeyRow", KeybindList.MakeRow)
    local rows = KeybindList.Rows
    while #rows > #pickers do
        pool.Release(table.remove(rows))
    end
    local settings = Config.Overlay.KeybindList
    for index, picker in ipairs(pickers) do
        local row = rows[index]
        if not row then
            row = pool.Acquire()
            rows[index] = row
        end
        row.Parent = KeybindList.List
        row.Position = UDim2.fromOffset(0, (index - 1) * settings.Row)
        KeybindList.Paint(row, picker)
    end
    KeybindList.Empty.Visible = #pickers == 0
    local count = math.max(#pickers, 1)
    frame.Size = UDim2.fromOffset(settings.Width + Config.Overlay.Shadow, settings.Header + 10 + count * settings.Row + Config.Overlay.Shadow)
end

function KeybindList.Paint(row, picker)
    local short = Keybinds.Short(picker.Value)
    local on = KeybindList.StateOf(picker)
    local mode = picker.Mode ~= "Toggle" and picker.Mode or nil
    row.Caption.Text = mode and string.format("%s  (%s)", KeybindList.LabelOf(picker), mode) or KeybindList.LabelOf(picker)
    row.Key.Label.Text = short
    if row:GetAttribute("On") ~= on then
        row:SetAttribute("On", on)
        Theme.Bind(row.Lamp, { BackgroundColor3 = on and "Good" or "Track" })
        Theme.Bind(row.Caption, { TextColor3 = on and "Text" or "SubText" })
    end
end

function KeybindList.SetVisible(visible)
    KeybindList.Build()
    KeybindList.Frame.Visible = visible == true
    KeybindList.Refresh()
end

---@author xDTaraZ  Mario Hub UI V2

Config.Chrome = {
    Z = {
        Pop = 1, Pipe = 2,
        Shadow = 1, Body = 2,
        Ambient = 1, Pages = 2, Ground = 3, Header = 4, Dock = 5, TabBar = 5, DockTip = 6, Grip = 7,
        HeaderBase = 0, Sky = 1, HeaderContent = 2, HeaderLine = 3,
        Bubble = 1, DockIcon = 2, Raised = 2, SkyFar = 1, SkyNear = 2, Walker = 2, Particles = 2, Fx = 10, Flash = 5,
    },
    Emblem = 26, Brand = 18, LetterGap = 1, PillHeight = 22, PillPad = 10, PillAlpha = 0.45,
    LangPill = Vector2.new(78, 28), Pad = 16, Gap = 8, BlockInset = 3,
    Header = { Desktop = 112, Tablet = 100, Phone = 58, Landscape = 52 }, HeaderPadY = 10, HeroGap = 4,
    Hero = { Desktop = 32, Tablet = 26 }, HeroStagger = 0.03, HeroDrop = { Height = 14, Damping = 0.5 }, HeroSpace = 0.32,
    DescKick = 14, DescDamping = 0.6,
    Dock = {
        Desktop = { Width = 58, Item = 44, Icon = 26, Bubble = 40 },
        Tablet = { Width = 66, Item = 52, Icon = 30, Bubble = 46 },
        Phone = { Width = 52, Item = 44, Icon = 24, Bubble = 40 },
    },
    DockGap = 12, DockPad = 7, DockSpacing = 4, DockShadow = 4, DockStroke = 2, DockRadius = 22, BubbleRadius = 12,
    SectionHeight = 14, SectionDot = 6,
    Magnify = { 1.28, 1.1 }, MagnifySpring = { Damping = 0.6 },
    BubbleSpring = { Damping = 0.7 }, SquashSpring = { Damping = 0.45 }, Stretch = 6, StretchMax = 900,
    Tip = { Gap = 10, PadX = 10, Height = 28, Frame = 7, Slide = 10, Spring = { Damping = 0.75 } },
    PageRight = 10, PageSlide = 28, PagePadY = 10,
    Park = { Delay = 0.25, Tries = 12 },
    Pages = { Budget = 0.003, Idle = 0.0015, Quiet = 0.4, Chunk = 60, Recheck = 0.25 },
    Cards = { Max = 8, Stagger = 0.035, Rise = 18, Scale = 0.95, Damping = 0.62 },
    Bar = { Height = 62, Gap = 8, Pad = 6, Shadow = 4, Icon = 24, Label = 11, ListGap = 2, Inset = 4 },
    Ground = 26, Grass = 6, GrassEdge = 2, BrickColumns = 28,
    Grip = { Desktop = 22, Tablet = 44 }, GripGlyph = 16, GripInset = 2,
    Warp = { From = Vector2.new(0.16, 0.02), OpenX = 13, OpenY = 19, OpenDamping = 0.5, CloseX = 24, CloseY = 15, CloseDamping = 0.95 },
    Pipe = { Width = 76, Lip = 18, LipOut = 8, Body = 30, Rise = 40, Stroke = 3, Shine = 0.55 },
    MinimizeSpring = { Damping = 0.55 },
    SearchWidth = { Desktop = 220, Tablet = 168 }, SearchIcon = 16, SearchPad = 10, Hint = "Ctrl K",
    PhoneMargin = 6,
    ResultLimit = 40, ResultRow = 40,
    Palette = { Width = 480, Rows = 8, Top = 0.2, Dim = 0.45, Pad = 12, MinScore = 6 },
    ThemeCard = { Columns = 3, Preview = 62, Gap = 4, Label = 16, Sky = 0.36, Ground = 0.12 },
    Wave = { Velocity = 420, Stagger = 0.045, Damping = 0.35 },
    FlashAlpha = 0.35,
    BuildTimeout = 30,
    KnobDamping = 0.6,
    ChevronDamping = 0.6,
}


Lang.Strings.SearchResults = { EN = "Search results", TH = "ผลการค้นหา" }
Lang.Strings.SearchDesc = { EN = "Tap a result to jump to it", TH = "แตะผลลัพธ์เพื่อไปยังตัวเลือกนั้น" }
Lang.Strings.More = { EN = "More", TH = "เพิ่มเติม" }
Lang.Strings.MoreTabs = { EN = "More tabs", TH = "แท็บอื่น" }
Lang.Strings.PaletteHint = { EN = "Type a feature, Enter to run", TH = "พิมพ์ชื่อฟีเจอร์ แล้วกด Enter" }
Lang.Strings.On = { EN = "ON", TH = "เปิด" }
Lang.Strings.Off = { EN = "OFF", TH = "ปิด" }
Lang.Strings.Transparency = { EN = "Window transparency", TH = "ความโปร่งใสหน้าต่าง" }
Lang.Strings.ReduceMotion = { EN = "Reduce motion", TH = "ลดแอนิเมชัน" }
Lang.Strings.ReduceMotionDesc = { EN = "Snap instead of springing", TH = "ขยับทันทีไม่เด้ง" }
Lang.Strings.FloatSize = { EN = "Mobile button size", TH = "ขนาดปุ่มลอย" }
Lang.Strings.NotifyPosition = { EN = "Notification corner", TH = "มุมการแจ้งเตือน" }
Lang.Strings.KeybindList = { EN = "Keybind list", TH = "รายการปุ่มลัด" }
Lang.Strings.Overlays = { EN = "Overlays", TH = "ส่วนแสดงบนจอ" }
Lang.Strings.QuickBar = { EN = "Quick bar", TH = "แถบลัด" }
Lang.Strings.QuickBarDesc = { EN = "Floating buttons for toggles you pick", TH = "ปุ่มลอยสำหรับ toggle ที่เลือก" }
Lang.Strings.Export = { EN = "Export", TH = "ส่งออก" }
Lang.Strings.Import = { EN = "Import", TH = "นำเข้า" }
Lang.Strings.ImportString = { EN = "Config string", TH = "ข้อความคอนฟิก" }
Lang.Strings.ImportPlaceholder = { EN = "Paste an exported config", TH = "วางคอนฟิกที่ส่งออกไว้" }
Lang.Strings.Exported = { EN = "Config copied to clipboard", TH = "คัดลอกคอนฟิกแล้ว" }
Lang.Strings.Imported = { EN = "Config imported", TH = "นำเข้าคอนฟิกแล้ว" }
Lang.Strings.ImportBroken = { EN = "That config string is not valid", TH = "ข้อความคอนฟิกไม่ถูกต้อง" }
Lang.Strings.NoClipboard = { EN = "Clipboard is not available", TH = "คัดลอกไม่ได้บน executor นี้" }
Lang.Strings.ConfirmUnload = { EN = "Tap again to unload", TH = "แตะอีกครั้งเพื่อปิด" }
Lang.Strings.NotifyCorners = {
    EN = { "Bottom right", "Top right", "Bottom left", "Top left" },
    TH = { "ขวาล่าง", "ขวาบน", "ซ้ายล่าง", "ซ้ายบน" },
}
Lang.Strings.Version = { EN = "Version", TH = "เวอร์ชัน" }

Window.Corners = { "BottomRight", "TopRight", "BottomLeft", "TopLeft" }

---@param move fun(begin: any, delta: Vector3?): any  called with nil on press to capture the start state
---@param exclude GuiObject[]?  zones that never start a drag
function Gui.Draggable(handle, move, exclude)
    return Util.Connect(handle.InputBegan, function(input)
        if not Util.IsPointer(input) then
            return
        end
        for _, zone in ipairs(exclude or {}) do
            if zone.Visible and Util.Inside(zone, input.Position) then
                return
            end
        end
        local begin = move(nil)
        if begin == nil then
            return
        end
        local start = input.Position
        State.Drag = {
            Input = input,
            Move = function(moved)
                move(begin, moved.Position - start)
            end,
        }
    end)
end

function Window.New(options)
    local size = options.Size or Vector2.new(Config.Window.Width, Config.Window.Height)
    if typeof(size) == "UDim2" then
        size = Vector2.new(size.X.Offset, size.Y.Offset)
    end
    local self = setmetatable({
        Title = options.Title or "Mario Hub",
        SubTitle = options.SubTitle or "",
        Desired = size,
        Size = size,
        Tabs = {},
        Sections = {},
        TopButtons = {},
        Letters = {},
        HeroLetters = {},
        Visible = false,
        Minimized = false,
        Query = "",
        Mode = Platform.Mode,
        PageWidth = 0,
        DockRight = 0,
    }, Window)
    State.Window = self
    State.MenuKey = Util.KeyName(options.MenuKey or options.ToggleKey or options.MinimizeKey) or State.MenuKey
    self:BuildFrame()
    self:BuildAmbient()
    self:BuildPages()
    self:BuildHeader()
    self:BuildDock()
    self:BuildGround()
    self:BuildTabBar()
    Platform.OnChange(function(mode)
        self:ApplyMode(mode)
        Float.Sync()
    end)
    Util.Connect(State.Stage:GetPropertyChangedSignal("AbsoluteSize"), function()
        self:Fit()
    end)
    Util.Every(Config.TitleWaveInterval, function()
        if self:IsShown() then
            self:WaveTitle()
        end
    end)
    table.insert(State.UnloadHooks, function()
        self:DestroyPages()
    end)
    self:ApplyMode(Platform.Mode)
    return self
end

function Window:IsShown()
    return self.Visible and not self.Minimized
end

---Runs fn(window) after show/hide, minimize, tab change and platform mode change.
function Window:OnState(fn)
    self.StateListeners = self.StateListeners or {}
    table.insert(self.StateListeners, fn)
end

function Window:EmitState()
    self:HideTip()
    for _, listener in ipairs(self.StateListeners or {}) do
        Util.Try(listener, self)
    end
end

function Window:BuildFrame()
    local z, shadow, radius = Config.Chrome.Z, Config.Window.Shadow, Config.Window.Radius
    self.Root = Draw.New("Frame", { Name = "Window", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), ZIndex = Config.Layer.Window, Parent = State.Stage })
    self.Scale = Draw.New("UIScale", { Parent = self.Root })
    self.Pop = Draw.New("Frame", { Name = "Pop", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = z.Pop, Parent = self.Root })
    self.Warp = Fx.Axis(self.Pop)
    Draw.Box("Frame", { Name = "Shadow", Position = UDim2.fromOffset(shadow, shadow), Size = UDim2.new(1, -shadow, 1, -shadow), ZIndex = z.Shadow, Parent = self.Pop }, "Shadow", nil, radius)
    self.Body = Draw.New("Frame", {
        Name = "Body",
        Size = UDim2.new(1, -shadow, 1, -shadow),
        BackgroundColor3 = Color3.new(1, 1, 1),
        ClipsDescendants = true,
        ZIndex = z.Body,
        Parent = self.Pop,
    })
    Draw.Corner(self.Body, radius)
    local fill = Draw.New("UIGradient", { Rotation = 90, Parent = self.Body })
    Theme.OnRender(fill, function()
        fill.Color = ColorSequence.new(Theme.Color("Backdrop"), Theme.Color("BackdropAlt"))
    end)
    self:BuildOutline()
    self:BuildPipe()
end

function Window:BuildOutline()
    Draw.Stroke(self.Body, "Outline", Config.Window.Stroke, true)
end

function Window:BuildPipe()
    local pipe, z = Config.Chrome.Pipe, Config.Chrome.Z
    local edge = pipe.Stroke
    local holder = Draw.New("CanvasGroup", {
        Name = "Pipe",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.fromOffset(pipe.Width + pipe.LipOut * 2 + edge * 2, pipe.Lip + pipe.Body + edge),
        GroupTransparency = 1,
        Visible = false,
        ZIndex = z.Pipe,
        Parent = self.Root,
    })
    Draw.Box("Frame", { Name = "Tube", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, edge + pipe.Lip - edge), Size = UDim2.fromOffset(pipe.Width, pipe.Body + edge), Parent = holder }, "Good", "Outline", 0, edge)
    local lip = Draw.Box("Frame", { Name = "Lip", Position = UDim2.fromOffset(edge, edge), Size = UDim2.new(1, -edge * 2, 0, pipe.Lip), ZIndex = Config.Chrome.Z.Raised, Parent = holder }, "Good", "Outline", 4, edge)
    Draw.Box("Frame", { Name = "Shine", Position = UDim2.fromOffset(pipe.LipOut, edge), Size = UDim2.fromOffset(edge * 2, pipe.Lip - edge * 2), BackgroundTransparency = pipe.Shine, Parent = lip }, "White", nil, UDim.new(1, 0))
    self.Pipe = holder
    self.PipeHideOptions = { OnDone = function(frame)
        if not self.PipeShown then
            frame.Visible = false
        end
    end }
end

function Window:ShowPipe(shown)
    local pipe, settings = self.Pipe, Config.Chrome.Pipe
    local down = UDim2.new(0.5, 0, 1, settings.Rise)
    self.PipeShown = shown
    if Motion.Reduced then
        pipe.Visible = false
        return
    end
    if not shown then
        Motion.Spring(pipe, "Position", down, "Normal")
        Motion.Spring(pipe, "GroupTransparency", 1, "Normal", self.PipeHideOptions)
        return
    end
    if not pipe.Visible then
        pipe.Position, pipe.GroupTransparency, pipe.Visible = down, 1, true
    end
    Motion.Spring(pipe, "Position", UDim2.new(0.5, 0, 1, -math.floor(settings.Lip / 2)), "Fast")
    Motion.Spring(pipe, "GroupTransparency", 0, "Fast")
end

---Stretches the window up out of the pipe, overshooting into a squash.
function Window:WarpIn()
    local warp = Config.Chrome.Warp
    if not self.Pop.Visible then
        Fx.SetAxis(self.Warp, warp.From.X, warp.From.Y)
        self.Pop.Visible = true
    end
    self:ShowPipe(true)
    Fx.Warp(self.Warp, 1, 1, {
        SpeedX = warp.OpenX, SpeedY = warp.OpenY, Damping = warp.OpenDamping,
        OnDone = function()
            if self.Visible then
                self:ShowPipe(false)
            end
        end,
    })
end

function Window:WarpOut()
    local warp = Config.Chrome.Warp
    self:ShowPipe(true)
    Fx.Warp(self.Warp, warp.From.X, warp.From.Y, {
        SpeedX = warp.CloseX, SpeedY = warp.CloseY, Damping = warp.CloseDamping,
        OnDone = function()
            if self.Visible then
                return
            end
            self.Pop.Visible = false
            self:ShowPipe(false)
        end,
    })
end

function Window:BuildAmbient()
    local ambient = Draw.New("Frame", { Name = "Ambient", BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = Config.Chrome.Z.Ambient, Parent = self.Body })
    self.Ambient = ambient
    self.Backdrop = Decor.AttachBackdrop(ambient)
    Particles.Build(ambient)
end

function Window:BuildPages()
    self.PageHost = Draw.New("Frame", { Name = "Pages", BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = Config.Chrome.Z.Pages, Parent = self.Body })
    self.SearchView = Tab.BuildPage(self, nil)
    self.SearchView.Dormant = true
    self.Parking = {}
    Util.Every(0, function()
        self:PageTick()
    end)
end

function Window:HeaderHeight()
    local header = Config.Chrome.Header
    if self.Landscape then
        return header.Landscape
    end
    return header[self.Mode] or header.Desktop
end

---@return boolean  tabs live in the side dock (desktop, tablet, phone held sideways)
function Window:Docked()
    return self.Mode ~= "Phone" or self.Landscape == true
end

function Window:GroundHeight()
    return self.Mode == "Phone" and 0 or Config.Chrome.Ground
end

function Window:HeroSize()
    return Config.Chrome.Hero[self.Mode] or Config.Chrome.Hero.Desktop
end

---@return table  { Width, Item, Icon, Bubble } dock sizes for the current mode
function Window:DockMetrics()
    return Config.Chrome.Dock[self.Mode] or Config.Chrome.Dock.Desktop
end

function Window:BuildHeader()
    local z = Config.Chrome.Z
    local radius = Config.Window.Radius
    local header = Draw.Box("Frame", { Name = "Header", BackgroundTransparency = 0, ZIndex = z.Header, Parent = self.Body }, "Topbar", nil, radius)
    Draw.Box("Frame", { Name = "SquareBottom", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, radius), ZIndex = z.HeaderBase, Parent = header }, "Topbar")
    local sky = Draw.New("Frame", { Name = "Sky", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, ZIndex = z.Sky, Parent = header })
    self.Sky = Decor.Attach(sky)
    Draw.Box("Frame", { Name = "Line", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, Config.Window.Stroke), ZIndex = z.HeaderLine, Parent = header }, "Outline")
    self.Header = header
    self.TopRow = Draw.New("Frame", { Name = "Top", BackgroundTransparency = 1, ZIndex = z.HeaderContent, Parent = header })
    self.LeftCluster = Window.Cluster(self.TopRow, false)
    self.RightCluster = Window.Cluster(self.TopRow, true)
    self:BuildBrand()
    self:BuildHero(header)
    self:BuildTopButtons()
    Gui.Draggable(header, function(begin, delta)
        return self:DragWindow(begin, delta)
    end, self.TopButtons)
end

---@return Frame  full-size horizontal strip, right-aligned when right
function Window.Cluster(parent, right)
    local cluster = Draw.New("Frame", { Name = right and "Right" or "Left", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = parent })
    Draw.List(cluster, Config.Chrome.Gap, true, right and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    return cluster
end

function Window:DragWindow(begin, delta)
    if self.Mode == "Phone" then
        return nil
    end
    if not delta then
        return self.Root.Position
    end
    self.Root.Position = begin + UDim2.fromOffset(delta.X, delta.Y)
    return begin
end

function Window:BuildBrand()
    local chrome = Config.Chrome
    local left = self.LeftCluster
    local slot = Draw.New("Frame", { Name = "Emblem", BackgroundTransparency = 1, Size = UDim2.fromOffset(chrome.Emblem, chrome.Emblem), LayoutOrder = 1, Parent = left })
    self.Emblem = Draw.Emblem(slot, chrome.Emblem)
    self:BuildTitle(left)
    self:BuildPill(left)
    local label = Draw.Text({ Name = "TabTitle", TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = 4, Visible = false, Parent = left }, "Display", Util.TextSize("Group"), "TopbarText")
    Draw.Stroke(label, "Ink", 1.5)
    self.PhoneTitle = label
end

function Window:BuildTitle(parent)
    local chrome = Config.Chrome
    local size = chrome.Brand
    local holder = Draw.New("Frame", { Name = "Title", BackgroundTransparency = 1, LayoutOrder = 2, Parent = parent })
    Draw.List(holder, chrome.LetterGap, true, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    local colors = Config.TitleColors
    local width, colorIndex = 0, 0
    for char in self.Title:upper():gmatch(utf8.charpattern) do
        local slotWidth = char == " " and math.floor(size * chrome.HeroSpace) or Layout.Measure(char, size, "Logo", 200).X
        local slot = Draw.New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(slotWidth, size + 4), LayoutOrder = #self.Letters + 1, Parent = holder })
        local letter = Draw.Text({ Text = char, Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Parent = slot }, "Logo", size, colors[colorIndex % #colors + 1])
        Draw.Stroke(letter, "Ink", 2)
        table.insert(self.Letters, letter)
        width += slotWidth + chrome.LetterGap
        colorIndex += char == " " and 0 or 1
    end
    holder.Size = UDim2.fromOffset(width, size + 4)
    self.TitleHolder, self.TitleWidth = holder, width
end

function Window:WaveTitle()
    if Motion.Reduced then
        return
    end
    local wave = Config.Chrome.Wave
    for index, letter in ipairs(self.Letters) do
        task.delay(index * wave.Stagger, Motion.Impulse, letter, "Position", { 0, 0, 0, -wave.Velocity }, "Fast", wave.Damping)
    end
end

function Window:BuildPill(parent)
    local chrome = Config.Chrome
    local size = Util.TextSize("Small")
    local width = Gui.TextWidth(self.SubTitle, size, "Body") + chrome.PillPad * 2
    local pill = Draw.Box("Frame", { Name = "Subtitle", Size = UDim2.fromOffset(width, chrome.PillHeight), BackgroundTransparency = chrome.PillAlpha, LayoutOrder = 3, Parent = parent }, "Shadow", nil, UDim.new(1, 0))
    Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Parent = pill }, "Body", size, "TopbarText", self.SubTitle)
    self.PillSlot, self.PillWidth = pill, width
end

function Window:BuildHero(header)
    local chrome, z = Config.Chrome, Config.Chrome.Z
    local hero = Draw.New("Frame", { Name = "Hero", BackgroundTransparency = 1, ZIndex = z.HeaderContent, Parent = header })
    Draw.List(hero, 0, true, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Bottom)
    self.Hero = hero
    self.HeroText = Draw.Text({ Name = "HeroText", Size = UDim2.fromScale(1, 1), TextTruncate = Enum.TextTruncate.AtEnd, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, Parent = hero }, "Display", chrome.Hero.Desktop, "TopbarText")
    Draw.Stroke(self.HeroText, "HeroInk", 2)
    self.HeaderDesc = Draw.Text({ Name = "Desc", TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = 0.15, ZIndex = z.HeaderContent, Parent = header }, "Desc", Util.TextSize("Desc"), "TopbarText")
    Lang.OnChange(hero, function()
        self:RenderHero(false)
    end)
end

---@return Frame  pooled letter slot with a Glyph label
function Window.MakeLetter()
    local slot = Draw.New("Frame", { Name = "Letter", BackgroundTransparency = 1 })
    local glyph = Draw.Text({ Name = "Glyph", Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Bottom, Parent = slot }, "Logo", Config.Chrome.Hero.Desktop, "TopbarText")
    Draw.Stroke(glyph, "HeroInk", 2)
    return slot
end

---Tab name in the bouncy title font, one frame per letter so they can drop in one by one.
---Thai has no Logo glyphs, so it falls back to one Display label.
function Window:RenderHero(animate)
    local pool = Draw.Pool("HeroLetter", Window.MakeLetter)
    for _, slot in ipairs(self.HeroLetters) do
        Motion.Cancel(slot.Glyph)
        pool.Release(slot)
    end
    table.clear(self.HeroLetters)
    local text = Lang.Resolve(self.HeroSpec or "")
    local size = self:HeroSize()
    local thai = Lang.HasThai(text)
    self.HeroText.Visible = thai
    if thai then
        self.HeroText.Text = text
        Fonts.Style(self.HeroText, "Display", size)
        return
    end
    for char in text:gmatch(utf8.charpattern) do
        local slot = pool.Acquire()
        local width = char == " " and math.floor(size * Config.Chrome.HeroSpace) or Layout.Measure(char, size, "Logo", 400).X
        slot.Size = UDim2.fromOffset(width, size + 6)
        slot.LayoutOrder = #self.HeroLetters + 1
        local glyph = slot.Glyph
        glyph.Text = char
        Fonts.Style(glyph, "Logo", size)
        glyph.Position = UDim2.new()
        glyph.TextTransparency = (animate and not Motion.Reduced) and 1 or 0
        slot.Parent = self.Hero
        table.insert(self.HeroLetters, slot)
    end
    if animate then
        Fx.Stagger(self.HeroLetters, Config.Chrome.HeroStagger, Window.DropLetter)
    end
end

function Window.DropLetter(slot)
    if not slot.Parent or slot.Parent.Name ~= "Hero" then
        return
    end
    local glyph = slot.Glyph
    local drop = Config.Chrome.HeroDrop
    Motion.Set(glyph, "Position", UDim2.fromOffset(0, -drop.Height))
    Motion.Spring(glyph, "Position", UDim2.new(), "Fast", drop)
    Motion.Spring(glyph, "TextTransparency", 0, "Fast")
end

function Window:BuildTopButtons()
    local right = self.RightCluster
    self:BuildSearchSlot(right)
    self:BuildLanguagePill(right)
    self.SearchButton = self:BlockButton("SearchButton", "search", 3, function()
        Search.OpenSheet(self)
    end)
    self.MinimizeButton = self:BlockButton("Minimize", "qblock", 4, function()
        self:SetMinimized(not self.Minimized)
    end)
    Window.SetArt(self.MinimizeButton, "used")
    Window.SetArt(self.MinimizeButton, "qblock")
    self.CloseButton = self:BlockButton("Close", "pipe", 5, function()
        self:Hide()
    end)
end

function Window:BuildSearchSlot(parent)
    local chrome = Config.Chrome
    local field, box = Search.Field()
    field.LayoutOrder = 1
    field.Parent = parent
    local hintSize = Util.TextSize("Small")
    local hintWidth = Gui.TextWidth(chrome.Hint, hintSize, "Strong")
    local hint = Draw.Text({ Name = "Hint", Text = chrome.Hint, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -chrome.SearchPad, 0.5, 0), Size = UDim2.fromOffset(hintWidth, hintSize + 4), TextXAlignment = Enum.TextXAlignment.Right, Parent = field }, "Strong", hintSize, "Muted")
    local textX = chrome.SearchPad + chrome.SearchIcon + Config.Button.IconGap
    box.Size = UDim2.new(1, -(textX + chrome.SearchPad * 2 + hintWidth), 1, 0)
    self.SearchBox, self.SearchField, self.SearchHint = box, field, hint
    table.insert(self.TopButtons, field)
    Util.Connect(box:GetPropertyChangedSignal("Text"), function()
        hint.Visible = box.Text == "" and self.Mode == "Desktop"
        self:SetQuery(box.Text)
    end)
end

---@return table  { Frame, Slot, Art, Sprite }  header block button: rises on hover, bumps and sparkles on press
function Window:BlockButton(name, art, order, callback)
    local button = Gui.Hitbox(name)
    button.LayoutOrder = order
    button.Parent = self.RightCluster
    local slot = Draw.New("Frame", { Name = "Slot", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = button })
    local entry = { Frame = button, Slot = slot }
    Window.SetArt(entry, art)
    Gui.Clickable(button, {
        OnHover = function(hovered)
            Fx.Lift(slot, hovered)
        end,
        OnClick = function()
            Fx.Bump(slot)
            Fx.Burst(button, UDim2.fromScale(0.5, 0))
            callback()
        end,
    })
    table.insert(self.TopButtons, button)
    return entry
end

---Sprites are kept per art, so swapping back and forth (minimize ?-block / used block) never rebuilds pixels.
function Window.SetArt(entry, art)
    if entry.Art == art then
        return
    end
    entry.Art = art
    entry.Sprites = entry.Sprites or {}
    local sprite = entry.Sprites[art]
    if not sprite then
        local inner = (entry.Size or Platform.Metric("Box")) - Config.Chrome.BlockInset * 2
        sprite = Sprite.New(entry.Slot, art, inner)
        sprite.AnchorPoint, sprite.Position = Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5)
        entry.Sprites[art] = sprite
    end
    for name, other in pairs(entry.Sprites) do
        other.Visible = name == art
    end
    entry.Sprite = sprite
end

function Window.SizeBlock(entry, size)
    if entry.Size == size then
        return
    end
    entry.Size = size
    entry.Frame.Size = UDim2.fromOffset(size, size)
    local inner = size - Config.Chrome.BlockInset * 2
    for _, sprite in pairs(entry.Sprites) do
        sprite.Size = UDim2.fromOffset(inner, inner)
    end
end

function Window:BuildLanguagePill(parent)
    local size = Config.Chrome.LangPill
    local pill = Draw.Box("Frame", { Name = "Language", Size = UDim2.fromOffset(size.X, size.Y), BackgroundTransparency = Config.Chrome.PillAlpha, LayoutOrder = 2, Parent = parent }, "Shadow", "Outline", UDim.new(1, 0), 2)
    local knob = Draw.Box("Frame", { Name = "Knob", Size = UDim2.fromScale(0.5, 1), Parent = pill }, "Coin", "Outline", UDim.new(1, 0), 2)
    local labels = {}
    for index, code in ipairs({ "EN", "TH" }) do
        labels[code] = Draw.Text({
            Text = code,
            Position = UDim2.fromScale((index - 1) * 0.5, 0),
            Size = UDim2.fromScale(0.5, 1),
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = Config.Chrome.Z.Raised,
            Parent = pill,
        }, "Body", Util.TextSize("Small"), "TopbarText")
    end
    local spring = { Damping = Config.Chrome.KnobDamping }
    local function Render()
        Motion.Spring(knob, "Position", UDim2.fromScale(State.Language == "TH" and 0.5 or 0, 0), "Fast", spring)
        for code, label in pairs(labels) do
            Theme.Bind(label, { TextColor3 = State.Language == code and "Ink" or "TopbarText" })
        end
    end
    Gui.Clickable(pill, {
        OnClick = function(input)
            local left = input.Position.X - pill.AbsolutePosition.X < pill.AbsoluteSize.X / 2
            Library:SetLanguage(left and "EN" or "TH")
        end,
    })
    Lang.OnChange(pill, Render)
    knob.Position = UDim2.fromScale(State.Language == "TH" and 0.5 or 0, 0)
    Render()
    self.LangPill = pill
    table.insert(self.TopButtons, pill)
end

function Window:BuildDock()
    local chrome, z = Config.Chrome, Config.Chrome.Z
    local radius = UDim.new(0, chrome.DockRadius)
    local dock = Draw.New("Frame", { Name = "Dock", BackgroundTransparency = 1, ZIndex = z.Dock, Parent = self.Body })
    Draw.Box("Frame", { Name = "Shadow", Position = UDim2.fromOffset(chrome.DockShadow, chrome.DockShadow), Size = UDim2.new(1, -chrome.DockShadow, 1, -chrome.DockShadow), ZIndex = z.Shadow, Parent = dock }, "Shadow", nil, radius)
    local face = Draw.Box("Frame", { Name = "Face", Size = UDim2.new(1, -chrome.DockShadow, 1, -chrome.DockShadow), BackgroundTransparency = 0, ClipsDescendants = true, ZIndex = z.Body, Parent = dock }, "Sidebar", "Outline", radius, chrome.DockStroke)
    local scroll = Layout.ScrollFrame({ Name = "Tabs", Size = UDim2.fromScale(1, 1), Parent = face })
    scroll.ScrollBarThickness = 0
    self.Bubble = Draw.Box("Frame", { Name = "Bubble", AnchorPoint = Vector2.new(0.5, 0.5), Visible = false, ZIndex = z.Bubble, Parent = scroll }, "TabActive", "Outline", UDim.new(0, chrome.BubbleRadius), 2)
    self.Dock, self.NavScroll = dock, scroll
    self.TabList = Container.New(scroll, {
        PadX = 0,
        PadY = chrome.DockPad,
        GapY = chrome.DockSpacing,
        Window = self,
        OnHeight = function()
            self:LayoutDock()
        end,
    })
    self:BuildTip()
    self:WatchTip()
end

function Window:BuildTip()
    local tip, z = Config.Chrome.Tip, Config.Chrome.Z
    local frame = Draw.New("CanvasGroup", { Name = "DockTip", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), GroupTransparency = 1, Visible = false, ZIndex = z.DockTip, Parent = self.Body })
    Draw.Box("Frame", { Name = "Shadow", Position = UDim2.fromOffset(tip.Frame - 2, tip.Frame - 2), Size = UDim2.new(1, -tip.Frame, 1, -tip.Frame), ZIndex = z.Shadow, Parent = frame }, "Shadow", nil, Platform.Metric("Radius"))
    local face = Draw.Box("Frame", { Name = "Face", Position = UDim2.fromOffset(2, 2), Size = UDim2.new(1, -tip.Frame, 1, -tip.Frame), BackgroundTransparency = 0, ZIndex = z.Body, Parent = frame }, "Panel", "Outline", Platform.Metric("Radius"), 2)
    self.TipLabel = Draw.Text({ Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, Parent = face }, "Body", Util.TextSize("Small") + 1, "Text")
    self.Tip = frame
    self.TipHideOptions = { OnDone = function(tipFrame)
        if not self.TipShown then
            tipFrame.Visible = false
        end
    end }
end

---Dock label sliding out to the right of anchor. Pointer only.
---Hover-out is not reported when the window moves, hides or the pointer jumps, so the tip checks the pointer itself.
function Window:WatchTip()
    Util.Connect(UserInputService.InputChanged, function(input)
        if not self.TipShown or input.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end
        local anchor = self.TipAnchor
        if not anchor or not anchor.Parent or not Util.Inside(anchor, UserInputService:GetMouseLocation()) then
            self:HideTip()
        end
    end)
end

function Window:ShowTip(anchor, spec)
    if Platform.Touch or self.Mode == "Phone" or not self.Visible then
        return
    end
    local tip, frame = Config.Chrome.Tip, self.Tip
    local text = Lang.Resolve(spec)
    self.TipLabel.Text = text
    local width = Gui.TextWidth(text, Util.TextSize("Small") + 1, "Body") + tip.PadX * 2 + tip.Frame
    local y = (anchor.AbsolutePosition.Y + anchor.AbsoluteSize.Y / 2 - self.Body.AbsolutePosition.Y) / State.UserScale
    local home = UDim2.fromOffset(self.DockRight + tip.Gap, math.floor(y))
    frame.Size = UDim2.fromOffset(width, tip.Height + tip.Frame)
    self.TipShown, self.TipAnchor = true, anchor
    if not frame.Visible then
        frame.Visible = true
        Motion.Set(frame, "Position", home - UDim2.fromOffset(tip.Slide, 0))
    end
    Motion.Spring(frame, "Position", home, "Fast", tip.Spring)
    Motion.Spring(frame, "GroupTransparency", 0, "Fast")
end

function Window:HideTip()
    if not self.TipShown then
        return
    end
    self.TipShown = false
    Motion.Spring(self.Tip, "GroupTransparency", 1, "Fast", self.TipHideOptions)
end

---@return table[]  tabs shown in the dock, in dock order
function Window:DockTabs()
    local shown = {}
    for _, tab in ipairs(self.Tabs) do
        if not tab.NavItem.Hidden then
            shown[#shown + 1] = tab
        end
    end
    return shown
end

function Window:DockHover(tab, hovered)
    if hovered then
        self.HoverTab = tab
        self:ShowTip(tab.Nav.Frame, tab.Name)
    elseif self.HoverTab == tab then
        self.HoverTab = nil
        self:HideTip()
    end
    self:Magnify()
end

---macOS-dock swell: hovered icon grows most, its neighbours a little.
function Window:Magnify()
    local chrome = Config.Chrome
    local shown = self:DockTabs()
    local center = self.HoverTab and table.find(shown, self.HoverTab)
    for index, tab in ipairs(shown) do
        local scale = center and chrome.Magnify[math.abs(index - center) + 1] or 1
        Motion.Spring(tab.Nav.Scale, "Scale", scale, "Fast", chrome.MagnifySpring)
    end
end

function Window:LayoutDock()
    if not self:Docked() then
        return
    end
    local chrome, dock = Config.Chrome, self:DockMetrics()
    local top = self:HeaderHeight() + chrome.DockGap
    local room = self.Size.Y - top - self:GroundHeight() - chrome.DockGap
    local height = math.max(0, math.min(self.TabList.ContentHeight, room))
    self.Dock.Position = UDim2.fromOffset(chrome.DockGap, top)
    self.Dock.Size = UDim2.fromOffset(dock.Width + chrome.DockShadow, height + chrome.DockShadow)
    self.DockRight = chrome.DockGap + dock.Width
end

function Window:BuildGround()
    local chrome, z = Config.Chrome, Config.Chrome.Z
    local radius = Config.Window.Radius
    local ground = Draw.New("CanvasGroup", { Name = "Ground", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), BackgroundTransparency = 1, ZIndex = z.Ground, Parent = self.Body })
    Draw.Corner(ground, radius)
    local strip = Draw.Box("Frame", { Name = "Strip", Position = UDim2.fromOffset(0, radius), Size = UDim2.new(1, 0, 1, -radius), BackgroundTransparency = 0, ClipsDescendants = true, Parent = ground }, "Brick")
    local bricks = Draw.New("Frame", { Name = "Bricks", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, chrome.Grass), Size = UDim2.new(1, 0, 1, -chrome.Grass), Parent = strip })
    Draw.Bricks(bricks, chrome.BrickColumns, "BrickDark")
    Draw.Box("Frame", { Name = "Grass", Size = UDim2.new(1, 0, 0, chrome.Grass), Parent = strip }, "Grass")
    Draw.Box("Frame", { Name = "GrassEdge", Position = UDim2.fromOffset(0, chrome.Grass), Size = UDim2.new(1, 0, 0, chrome.GrassEdge), Parent = strip }, "GrassDark")
    Draw.Box("Frame", { Name = "Line", Size = UDim2.new(1, 0, 0, Config.Window.Stroke), Parent = strip }, "Outline")
    self.Ground = ground
    self.Walker = Decor.AttachGround(strip)
    local grip = Draw.Text({
        ClassName = "TextButton",
        Text = "◢",
        AutoButtonColor = false,
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -chrome.GripInset, 1, -chrome.GripInset),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = z.Grip,
        Parent = self.Body,
    }, "Glyph", chrome.GripGlyph, "White")
    Draw.Stroke(grip, "Ink", 1.5)
    self.Grip = grip
    Gui.Draggable(grip, function(begin, delta)
        if not delta then
            return { Size = self.Size, Position = self.Root.Position }
        end
        self:ResizeFrom(begin, Vector2.new(delta.X, delta.Y))
        return begin
    end)
end

---Root is anchored top-center, so it shifts by half the growth to keep the left edge still.
function Window:ResizeFrom(begin, delta)
    if self.Minimized or self.Mode == "Phone" then
        return
    end
    self.Desired = begin.Size + delta / State.UserScale
    self:Fit()
    local grown = (self.Size.X - begin.Size.X) * State.UserScale
    self.Root.Position = begin.Position + UDim2.fromOffset(math.floor(grown / 2), 0)
end

function Window:BuildTabBar()
    local bar, z = Config.Chrome.Bar, Config.Chrome.Z
    local holder = Draw.New("Frame", { Name = "TabBar", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 1), Visible = false, ZIndex = z.TabBar, Parent = self.Body })
    Draw.Box("Frame", { Name = "Shadow", Position = UDim2.fromOffset(bar.Shadow, bar.Shadow), Size = UDim2.new(1, -bar.Shadow, 1, -bar.Shadow), ZIndex = z.Shadow, Parent = holder }, "Shadow", nil, UDim.new(1, 0))
    local face = Draw.Box("Frame", { Name = "Face", Size = UDim2.new(1, -bar.Shadow, 1, -bar.Shadow), BackgroundTransparency = 0, ZIndex = z.Body, Parent = holder }, "Sidebar", "Outline", UDim.new(1, 0), 2)
    self.BarPill = Draw.Box("Frame", { Name = "Bubble", AnchorPoint = Vector2.new(0.5, 0.5), Visible = false, ZIndex = z.Bubble, Parent = face }, "TabActive", "Outline", UDim.new(1, 0), 2)
    self.BarRow = Container.New(face, { PadX = bar.Pad, PadY = bar.Pad, GapX = 0 })
    self.TabBar, self.BarButtons = holder, {}
end

function Window:LayoutBar()
    local bar = Config.Chrome.Bar
    local barred = not self:Docked()
    self.TabBar.Visible = barred
    if not barred then
        return
    end
    local width = self.Size.X - bar.Gap * 2
    self.TabBar.Position = UDim2.new(0.5, 0, 1, -bar.Gap)
    self.TabBar.Size = UDim2.fromOffset(width + bar.Shadow, bar.Height + bar.Shadow)
    self.BarRow:SetWidth(width)
end

function Window:BarTabs()
    local shown, overflow = {}, {}
    local limit = Config.Window.TabBarMax
    local visible = self:DockTabs()
    for index, tab in ipairs(visible) do
        local fits = #visible <= limit + 1 or index <= limit
        table.insert(fits and shown or overflow, tab)
    end
    return shown, overflow
end

function Window:RenderTabBar()
    if self:Docked() then
        return
    end
    self.BarRow:Clear()
    table.clear(self.BarButtons)
    local shown, overflow = self:BarTabs()
    self.Overflow = overflow
    local count = #shown + (#overflow > 0 and 1 or 0)
    for index, tab in ipairs(shown) do
        self:AddBarButton(tab, tab.Name, tab.Icon, count, index > 1)
    end
    if #overflow > 0 then
        self.MoreButton = self:AddBarButton("More", Lang.Strings.More, "more-horizontal", count, #shown > 0)
    end
    self:RenderBarActive()
end

function Window:AddBarButton(key, text, icon, count, sameLine)
    local bar = Config.Chrome.Bar
    local button = Gui.Hitbox("BarButton")
    button.ZIndex = Config.Chrome.Z.DockIcon
    local list = Draw.New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = button })
    Draw.List(list, bar.ListGap, false, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    local iconSlot = Draw.New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(bar.Icon, bar.Icon), LayoutOrder = 1, Parent = list })
    local sprite = Sprite.New(iconSlot, icon, bar.Icon)
    local label = Draw.Text({ Size = UDim2.new(1, 0, 0, bar.Label + 3), TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = 2, Parent = list }, "Body", bar.Label, "SidebarText", text)
    if sameLine then
        self.BarRow:SameLine(0)
    end
    local entry = { Key = key, Frame = button, Icon = iconSlot, Sprite = sprite, Label = label }
    entry.Item = self.BarRow:Add(button, {
        Width = 1 / count,
        Height = bar.Height - bar.Pad * 2,
        OnLayout = function(width, height)
            entry.Width, entry.Height = width, height
            if entry.Active then
                self:MoveBarPill(entry, false)
            end
        end,
    })
    Gui.Clickable(button, {
        OnClick = function()
            Fx.Bump(sprite)
            Fx.Burst(button, UDim2.fromScale(0.5, 0.3))
            if key == "More" then
                self:OpenMore()
            else
                self:SelectTab(key)
            end
        end,
    })
    table.insert(self.BarButtons, entry)
    return entry
end

function Window:MoveBarPill(entry, animate)
    local chrome = Config.Chrome
    local inset = chrome.Bar.Inset
    local frame, pill = entry.Frame, self.BarPill
    local target = UDim2.fromOffset(frame.Position.X.Offset + math.floor(entry.Width / 2), frame.Position.Y.Offset + math.floor(entry.Height / 2))
    local size = UDim2.fromOffset(entry.Width - inset * 2, entry.Height - inset)
    pill.Visible = true
    if not animate then
        Motion.Set(pill, "Position", target)
        Motion.Set(pill, "Size", size)
        return
    end
    local distance = math.abs(target.X.Offset - Motion.Target(pill, "Position").X.Offset)
    local stretch = math.min(distance * chrome.Stretch, chrome.StretchMax)
    Motion.Spring(pill, "Position", target, "Normal", chrome.BubbleSpring)
    Motion.Spring(pill, "Size", size, "Fast", chrome.SquashSpring)
    Motion.Impulse(pill, "Size", { 0, stretch, 0, -stretch * 0.5 }, "Fast", chrome.SquashSpring.Damping)
end

function Window:RenderBarActive()
    local active = self.ActiveTab
    local inOverflow = active ~= nil and table.find(self.Overflow or {}, active) ~= nil
    for _, entry in ipairs(self.BarButtons) do
        local isActive = entry.Key == active or (entry.Key == "More" and inOverflow)
        local changed = entry.Active ~= isActive
        entry.Active = isActive
        Theme.Bind(entry.Label, { TextColor3 = isActive and "TabActiveText" or "SidebarText" })
        if isActive and changed and entry.Width then
            self:MoveBarPill(entry, true)
            Motion.Pop(entry.Sprite)
        end
    end
end

function Window:OpenMore()
    Sheet.Open(Lang.Strings.MoreTabs, function(container)
        for _, tab in ipairs(self.Overflow or {}) do
            Gui.Selectable(container, {
                Text = tab.Name,
                Icon = tab.Icon,
                Selected = tab == self.ActiveTab,
                Callback = function()
                    Sheet.Close()
                    self:SelectTab(tab)
                end,
            })
        end
    end, { Height = 0.6 })
end

function Window:ApplyMode(mode)
    self.Mode = mode
    self.Landscape = Platform.Landscape == true
    local phone = mode == "Phone"
    self.Dock.Visible = self:Docked()
    self.Ground.Visible = not phone
    local grip = Config.Chrome.Grip[mode] or Config.Chrome.Grip.Desktop
    self.Grip.Size = UDim2.fromOffset(grip, grip)
    self.Grip.Visible = not phone and not self.Minimized
    for _, tab in ipairs(self.Tabs) do
        tab:ApplyDock()
    end
    if phone and self.Minimized then
        self:SetMinimized(false)
    end
    self:HideTip()
    self.Placed = false
    self:Fit()
    self:RenderHero(false)
    self:RenderTabBar()
    Layout.MarkAll()
    self:EmitState()
end

function Window:LayoutBody()
    local chrome = Config.Chrome
    local docked = self:Docked()
    local header, ground = self:HeaderHeight(), self:GroundHeight()
    local bottom = docked and ground or chrome.Bar.Height + chrome.Bar.Gap * 2
    local left = docked and chrome.DockGap * 2 + self:DockMetrics().Width + chrome.DockShadow or 0
    local pageWidth = math.max(0, self.Size.X - left - (docked and chrome.PageRight or 0))
    self.Header.Size = UDim2.new(1, 0, 0, header)
    self.Ambient.Position = UDim2.fromOffset(0, header)
    self.Ambient.Size = UDim2.new(1, 0, 1, -header - ground)
    self.Ground.Size = UDim2.new(1, 0, 0, ground + Config.Window.Radius)
    self.PageHost.Position = UDim2.fromOffset(left, header)
    self.PageHost.Size = UDim2.fromOffset(pageWidth, math.max(0, self.Size.Y - header - bottom))
    self.TabList:SetWidth(self:DockMetrics().Width)
    self:LayoutHeader()
    self:LayoutDock()
    self:LayoutBar()
    self:OnPageWidth(pageWidth)
end

function Window:LayoutHeader()
    local chrome = Config.Chrome
    local phone = self.Mode == "Phone"
    local row = Platform.Metric("Box")
    local padY = phone and math.floor((self:HeaderHeight() - row) / 2) or chrome.HeaderPadY
    local heroSize = self:HeroSize()
    local heroY = padY + row + chrome.HeroGap
    local descSize = Util.TextSize("Desc")
    self.TopRow.Position = UDim2.fromOffset(chrome.Pad, padY)
    self.TopRow.Size = UDim2.new(1, -chrome.Pad * 2, 0, row)
    self.Hero.Position = UDim2.fromOffset(chrome.Pad, heroY)
    self.Hero.Size = UDim2.new(1, -chrome.Pad * 2, 0, heroSize + 6)
    self.HeaderDesc.Position = UDim2.fromOffset(chrome.Pad, heroY + heroSize + 6)
    self.HeaderDesc.Size = UDim2.new(1, -chrome.Pad * 2, 0, descSize + 4)
    self.Hero.Visible = not phone
    self.HeaderDesc.Visible = not phone and self.HasDesc == true
    self:LayoutTopRow()
end

---Fits the control row first, then drops the subtitle pill and brand title when space runs out.
function Window:LayoutTopRow()
    local chrome, mode = Config.Chrome, self.Mode
    local phone = mode == "Phone"
    local box, gap = Platform.Metric("Box"), chrome.Gap
    self.SearchField.Visible = not phone
    self.SearchField.Size = UDim2.fromOffset(chrome.SearchWidth[mode] or chrome.SearchWidth.Desktop, box)
    self.SearchHint.Visible = mode == "Desktop" and self.SearchBox.Text == ""
    self.LangPill.Visible = not phone
    self.SearchButton.Frame.Visible = phone
    self.MinimizeButton.Frame.Visible = not phone
    for _, entry in ipairs({ self.SearchButton, self.MinimizeButton, self.CloseButton }) do
        Window.SizeBlock(entry, box)
    end
    local rightWidth = 0
    for _, child in ipairs(self.RightCluster:GetChildren()) do
        if child:IsA("GuiObject") and child.Visible then
            rightWidth += child.Size.X.Offset + gap
        end
    end
    local room = self.Size.X - chrome.Pad * 2 - rightWidth
    local used = chrome.Emblem + gap
    self.PhoneTitle.Visible = phone
    if phone then
        self.PhoneTitle.Size = UDim2.fromOffset(math.max(0, room - used), box)
        self.TitleHolder.Visible, self.PillSlot.Visible = false, false
        return
    end
    local titleFits = used + self.TitleWidth <= room
    self.TitleHolder.Visible = titleFits
    used += self.TitleWidth + gap
    self.PillSlot.Visible = titleFits and mode == "Desktop" and self.SubTitle ~= "" and used + self.PillWidth <= room
end

function Window:MinSize()
    if Platform.Touch then
        return Config.Window.TouchMinWidth, Config.Window.TouchMinHeight
    end
    return Config.Window.MinWidth, Config.Window.MinHeight
end

function Window:Fit()
    local viewport = State.Stage.AbsoluteSize
    if viewport.X <= 0 then
        return
    end
    local scale = State.UserScale
    self.Scale.Scale = scale
    if self.Mode == "Phone" then
        self:FitPhone(viewport, scale)
        return
    end
    local margin = (Platform.Touch and Config.Window.TouchMargin or Config.Window.Margin) * 2
    local minWidth, minHeight = self:MinSize()
    local maxWidth = math.max(minWidth, (viewport.X - margin) / scale)
    local maxHeight = math.max(minHeight, (viewport.Y - margin) / scale)
    self.Size = Vector2.new(math.floor(math.clamp(self.Desired.X, minWidth, maxWidth)), math.floor(math.clamp(self.Desired.Y, minHeight, maxHeight)))
    self:Commit()
    if not self.Placed then
        self.Placed = true
        local height = (self.Size.Y + Config.Window.Shadow) * scale
        self.Root.Position = UDim2.new(0.5, 0, 0.5, -math.floor(height / 2))
    end
end

---Fills the screen minus the Roblox topbar inset; the notch is handled by ScreenGui.ScreenInsets.
function Window:FitPhone(viewport, scale)
    local inset = GuiService:GetGuiInset()
    local margin, shadow = Config.Chrome.PhoneMargin, Config.Window.Shadow
    local width = math.floor((viewport.X - margin * 2) / scale) - shadow
    local height = math.floor((viewport.Y - inset.Y - margin * 2) / scale) - shadow
    self.Size = Vector2.new(math.max(Config.Window.TouchMinWidth, width), math.max(Config.Window.TouchMinHeight, height))
    self.Root.Position = UDim2.new(0.5, 0, 0, inset.Y + margin)
    self:Commit()
end

function Window:Commit()
    local shadow = Config.Window.Shadow
    local height = self.Minimized and self:HeaderHeight() or self.Size.Y
    Motion.Set(self.Root, "Size", UDim2.fromOffset(self.Size.X + shadow, height + shadow))
    self:LayoutBody()
end

function Window:OnPageWidth(width)
    if width == self.PageWidth then
        return
    end
    self.PageWidth = width
    for _, tab in ipairs(self.Tabs) do
        tab.PendingWidth = width
    end
    if self.ActiveTab then
        self.ActiveTab:ApplyWidth()
    end
    self.SearchView.Root:SetWidth(width - Config.Page.ScrollBar)
end

---Dock divider: a small dot that shows the section name on hover.
function Window:AddTabSection(text)
    local chrome = Config.Chrome
    local holder = Draw.New("Frame", { Name = "Section", BackgroundTransparency = 1, ZIndex = chrome.Z.DockIcon })
    local dot = Draw.Box("Frame", { Name = "Dot", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(chrome.SectionDot, chrome.SectionDot), BackgroundTransparency = 0, Parent = holder }, "SidebarMuted", nil, UDim.new(1, 0))
    local item = self.TabList:Add(holder, { Height = chrome.SectionHeight })
    Gui.Clickable(holder, {
        OnHover = function(hovered)
            if hovered then
                self:ShowTip(holder, text)
            else
                self:HideTip()
            end
        end,
    })
    local section = { Item = item, Dot = dot, Text = text }
    table.insert(self.Sections, section)
    return section
end

function Window:AddTab(name, icon, description)
    local tab = Tab.New(self, name, icon, description)
    table.insert(self.Tabs, tab)
    tab.PendingWidth = self.PageWidth > 0 and self.PageWidth or nil
    if not self.ActiveTab then
        self:SelectTab(tab)
    end
    self:RenderTabBar()
    return tab
end

---@return table?  tab matched by object, resolved name or raw name spec
function Window:FindTab(tab)
    if type(tab) == "table" and getmetatable(tab) == Tab then
        return tab
    end
    for _, candidate in ipairs(self.Tabs) do
        if candidate.Name == tab or Lang.Resolve(candidate.Name) == tab then
            return candidate
        end
    end
    return nil
end

function Window:SelectTab(target)
    local tab = self:FindTab(target)
    if not tab or tab == self.ActiveTab then
        return
    end
    Popup.Close()
    local previous = self.ActiveTab
    local forward = not previous or table.find(self.Tabs, tab) >= (table.find(self.Tabs, previous) or 0)
    self.ActiveTab = tab
    if previous then
        previous:SetShown(false, forward)
        previous:RenderNav()
    end
    tab:ApplyWidth()
    if self.Query == "" then
        tab:SetShown(true, forward)
    end
    tab:RenderNav()
    tab:MoveIndicator(previous ~= nil)
    self:SetHeading(tab.Name, tab.Description)
    local shown = self:DockTabs()
    Decor.Shift(self.Sky, ((table.find(shown, tab) or 1) - 1) / math.max(1, #shown - 1))
    self:RenderBarActive()
    if tab.OnSelected then
        tab.OnSelected(tab)
    end
    self:EmitState()
end

function Window:SetHeading(title, description)
    local chrome = Config.Chrome
    self.HeroSpec = title
    self.HasDesc = description ~= nil and description ~= ""
    Lang.Bind(self.HeaderDesc, description or "")
    self.HeaderDesc.Visible = self.HasDesc and self.Mode ~= "Phone"
    Lang.Bind(self.PhoneTitle, title)
    self:RenderHero(self.Visible)
    local home = Motion.Target(self.HeaderDesc, "Position")
    Motion.Set(self.HeaderDesc, "Position", home + UDim2.fromOffset(chrome.DescKick, 0))
    Motion.Spring(self.HeaderDesc, "Position", home, "Normal", { Damping = chrome.DescDamping })
end

function Window:SetQuery(text)
    local query = Search.Normalize(text)
    if self.SearchBox.Text ~= text and query == "" then
        self.SearchBox.Text = ""
    end
    if query == self.Query then
        return
    end
    local wasSearching = self.Query ~= ""
    self.Query = query
    local view, active = self.SearchView, self.ActiveTab
    if query == "" then
        self:PresentPage(view, false, "Bottom")
        if active then
            active:SetShown(true, false)
        end
        self:SetHeading(active and active.Name or "", active and active.Description)
        return
    end
    Search.Render(view.Root, self, query, function(entry)
        Search.Jump(self, entry)
    end)
    if not wasSearching then
        if active then
            active:SetShown(false, true)
        end
        self:PresentPage(view, true, "Bottom")
        self:SetHeading(Lang.Strings.SearchResults, Lang.Strings.SearchDesc)
    end
end

---Hides a page at once; showing one goes through StepPrepare, so it stays hidden until it is whole.
---@param view table  tab or search view ({ Page, Dormant })
function Window:PresentPage(view, shown, from)
    if shown and not view.Dormant then
        return
    end
    view.Want, view.From = shown, from
    if shown then
        self.Parking[view] = nil
        self.Preparing = view
        self:StepPrepare(os.clock() + Config.Chrome.Pages.Budget)
        return
    end
    view.Dormant = true
    if self.Preparing == view then
        self.Preparing = nil
    end
    Motion.Presence(view.Page, false, { From = from, Distance = Config.Chrome.PageSlide })
    task.delay(Config.Chrome.Park.Delay, Window.Park, self, view, 1)
end

---Lays out, attaches and then slides in the page being shown, stopping at deadline to go on next frame.
function Window:StepPrepare(deadline)
    local view = self.Preparing
    if view.ApplyWidth then
        view:ApplyWidth()
    end
    if not Layout.Warm(view, deadline) or not self:Attach(view, deadline) then
        return
    end
    self.Preparing = nil
    view.Dormant = false
    Layout.Wake(view)
    Layout.Flush()
    view.Page.Visible = false
    Motion.Presence(view.Page, true, { From = view.From, Distance = Config.Chrome.PageSlide })
    if view.EnterCards then
        view:EnterCards()
    end
end

---@return Instance[]  every row frame of a view, outermost first
function Window.PageChunks(view)
    local containers = {}
    for container in pairs(Layout.All) do
        if container.Tab == view and not container.Destroyed then
            containers[#containers + 1] = container
        end
    end
    table.sort(containers, Layout.ByDepth)
    local chunks = {}
    for _, container in ipairs(containers) do
        for _, item in ipairs(container.Items) do
            if item.Child then
                chunks[#chunks + 1] = item.Frame
            else
                Window.AddChunk(chunks, item.Frame)
            end
        end
    end
    return chunks
end

---A big row (lists, tables) is split into its children so no single chunk costs a whole frame.
function Window.AddChunk(chunks, frame)
    chunks[#chunks + 1] = frame
    if #frame:GetDescendants() <= Config.Chrome.Pages.Chunk then
        return
    end
    for _, child in ipairs(frame:GetChildren()) do
        Window.AddChunk(chunks, child)
    end
end

---Pulls a page apart innermost rows first, so putting it back costs a few rows per frame instead of one big frame.
---@param deadline number?  nil runs to the end (only for a page outside the DataModel)
---@return boolean          true once every row is detached
function Window.Detach(view, deadline)
    if view.Phase ~= "Detach" then
        view.Chunks = Window.PageChunks(view)
        view.Detached = view.Detached or {}
        view.Cursor, view.Phase = #view.Chunks, "Detach"
    end
    local chunks, detached, page = view.Chunks, view.Detached, view.Page
    while view.Cursor >= 1 do
        if deadline and os.clock() >= deadline then
            return false
        end
        local frame = chunks[view.Cursor]
        view.Cursor -= 1
        local parent = frame.Parent
        if parent and frame:IsDescendantOf(page) then
            detached[frame] = parent
            frame.Parent = nil
        end
    end
    view.Phase = "Detached"
    return true
end

---Puts a page into the window and its rows back, outermost first, until deadline.
---@return boolean  true once the page is whole
function Window:Attach(view, deadline)
    local page = view.Page
    if page.Parent ~= self.PageHost then
        if view.Phase ~= "Detached" and view.Phase ~= "Attach" then
            Window.Detach(view)
        end
        page.GroupTransparency, page.Visible = 1, true
        page.Parent = self.PageHost
    end
    if not view.Detached then
        return true
    end
    if view.Phase ~= "Attach" then
        view.Cursor, view.Phase = 1, "Attach"
    end
    local chunks, detached = view.Chunks, view.Detached
    while view.Cursor <= #chunks do
        if os.clock() >= deadline then
            return false
        end
        local frame = chunks[view.Cursor]
        view.Cursor += 1
        local parent = detached[frame]
        if parent then
            detached[frame] = nil
            frame.Parent = parent
        end
    end
    view.Chunks, view.Detached, view.Phase = nil, nil, nil
    return true
end

---Queues a hidden page for detaching once its hide spring has finished.
function Window.Park(window, view, tries)
    local page = view.Page
    if not view.Dormant or view.Want or not page.Parent or Library.Unloaded then
        return
    end
    if page.Visible and tries < Config.Chrome.Park.Tries then
        task.delay(Config.Chrome.Park.Delay, Window.Park, window, view, tries + 1)
        return
    end
    page.Visible = false
    window.Parking[view] = true
end

---Per-frame page work under a time budget: the page being shown first, then parking, then idle prewarm.
function Window:PageTick()
    local pages = Config.Chrome.Pages
    if self.Preparing then
        self:StepPrepare(os.clock() + pages.Budget)
        return
    end
    local deadline = os.clock() + pages.Idle
    for view in pairs(self.Parking) do
        if os.clock() >= deadline then
            return
        end
        if not view.Dormant or view.Want then
            self.Parking[view] = nil
        elseif Window.Detach(view, deadline) then
            view.Page.Parent = nil
            self.Parking[view] = nil
        end
    end
    self:Prewarm(deadline)
end

---@return boolean  tab is parked, laid out and detached, so prewarm has nothing left to do for it
function Window.Warmed(tab)
    local parked = tab.Parked
    return tab.Phase == "Detached" and not tab.PendingWidth and (not parked or next(parked) == nil)
end

---Lays out parked tabs while the user is idle, so a first visit only has to attach the page.
function Window:Prewarm(deadline)
    if not self.Ready or not self.Visible or self.Minimized or Motion.Get(self.Warp.Y, "Value") then
        return
    end
    local pages, now = Config.Chrome.Pages, os.clock()
    if now - (State.LastInput or 0) < pages.Quiet or now < (self.WarmRest or 0) then
        return
    end
    self.WarmRest = now + pages.Recheck
    for _, tab in ipairs(self.Tabs) do
        if not tab.Dormant or Window.Warmed(tab) then
            continue
        end
        self.WarmRest = nil
        if os.clock() >= deadline then
            return
        end
        if not self.Parking[tab] and not tab.Page.Parent then
            tab:ApplyWidth()
            if Layout.Warm(tab, deadline) and tab.Phase ~= "Detached" then
                Window.Detach(tab, deadline)
            end
        end
    end
end

---Parked pages are outside the ScreenGui, so unload has to destroy them itself.
function Window:DestroyPages()
    for _, view in ipairs(self.Tabs or {}) do
        for frame in pairs(view.Detached or {}) do
            frame:Destroy()
        end
    end
    for _, page in ipairs(self.Pages or {}) do
        page:Destroy()
    end
    table.clear(self.Pages or {})
end

function Window:Show()
    if self.Visible then
        return
    end
    self.Visible = true
    self:WarpIn()
    Float.Sync()
    self:WaveTitle()
    Particles.Resume()
    self:EmitState()
end

function Window:Hide()
    if not self.Visible then
        return
    end
    self.Visible = false
    Popup.Close()
    Palette.Close()
    self:HideTip()
    self:WarpOut()
    Float.Sync()
    self:EmitState()
    if not Platform.Touch then
        Notify.Push(self.Title, Lang.Format("Hidden", Keybinds.Short(State.MenuKey)), 3, "Info")
    end
end

function Window:SetVisible(visible)
    if visible then
        self:Show()
    else
        self:Hide()
    end
end

function Window:Toggle()
    if not self.Ready then
        return
    end
    self:SetVisible(not self.Visible)
end

---Shrinks to the header with a bounce; the ?-block turns into a used block while folded.
function Window:SetMinimized(minimized)
    if self.Minimized == minimized or (minimized and self.Mode == "Phone") then
        return
    end
    self.Minimized = minimized
    Popup.Close()
    self:HideTip()
    local shadow = Config.Window.Shadow
    local height = minimized and self:HeaderHeight() or self.Size.Y
    Motion.Spring(self.Root, "Size", UDim2.fromOffset(self.Size.X + shadow, height + shadow), "Normal", Config.Chrome.MinimizeSpring)
    Window.SetArt(self.MinimizeButton, minimized and "used" or "qblock")
    self.Grip.Visible = not minimized and self.Mode ~= "Phone"
    Float.Sync()
    self:EmitState()
end

function Window:SetScale(scale)
    State.UserScale = math.clamp(tonumber(scale) or 1, Config.ScaleRange.Min, Config.ScaleRange.Max)
    self:Fit()
end

function Window:SetTransparency(alpha)
    self.Body.BackgroundTransparency = math.clamp(tonumber(alpha) or 0, 0, 0.9)
end

function Tab.New(window, name, icon, description)
    local tab = setmetatable({ Window = window, Name = name, Icon = icon, Description = description, Groupboxes = {} }, Tab)
    tab:BuildNav()
    local view = Tab.BuildPage(window, tab)
    tab.Page, tab.Scroll, tab.Root, tab.Dormant = view.Page, view.Scroll, view.Root, true
    local columns = tab.Root:Columns(2, Config.Window.TwoColumnMin / 2)
    tab.Left, tab.Right, tab.Columns = columns[1], columns[2], columns
    return tab
end

---Pages start parked (Parent = nil): widgets register at once, but hidden pages stay out of the
---window's layout tree so warp/resize only re-lays out the page on screen.
---@param tab table?  nil builds the search results page
---@return table      { Page: CanvasGroup, Scroll, Root: Container }
function Tab.BuildPage(window, tab)
    local page = Draw.New("CanvasGroup", { Name = tab and "Page" or "SearchPage", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
    window.Pages = window.Pages or {}
    table.insert(window.Pages, page)
    local scroll = Layout.ScrollFrame({ Name = "Scroll", Size = UDim2.fromScale(1, 1), Parent = page })
    local root = Container.New(scroll, { PadX = Config.Page.Pad, PadY = Config.Chrome.PagePadY, GapY = tab and Config.Gap.Column or Config.Gap.Y, Window = window, Tab = tab })
    return { Page = page, Scroll = scroll, Root = root }
end

function Tab:BuildNav()
    local window = self.Window
    local dock = window:DockMetrics()
    local button = Gui.Hitbox("DockButton")
    button.ZIndex = Config.Chrome.Z.DockIcon
    local slot = Draw.New("Frame", { Name = "Icon", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(dock.Icon, dock.Icon), Parent = button })
    local scale = Draw.New("UIScale", { Name = "Magnify", Parent = slot })
    local sprite = Sprite.New(slot, self.Icon, dock.Icon)
    self.Nav = { Frame = button, Slot = slot, Scale = scale, Sprite = sprite }
    self.NavItem = window.TabList:Add(button, {
        Height = function()
            return window:DockMetrics().Item
        end,
        OnLayout = function()
            if window.ActiveTab == self then
                self:MoveIndicator(window.BubblePlaced == true)
            end
        end,
    })
    self.Nav.Binder = Gui.Clickable(button, {
        OnHover = function(hovered)
            window:DockHover(self, hovered)
        end,
        OnClick = function()
            Fx.Bump(slot)
            Fx.Burst(button, UDim2.fromScale(0.5, 0.5))
            window:SelectTab(self)
        end,
    })
end

function Tab:ApplyDock()
    local icon = self.Window:DockMetrics().Icon
    self.Nav.Slot.Size = UDim2.fromOffset(icon, icon)
    self.Nav.Sprite.Size = UDim2.fromOffset(icon, icon)
end

function Tab:RenderNav()
    if self.Window.ActiveTab == self then
        Motion.Pop(self.Nav.Sprite)
    end
end

---Moves the dock bubble; it stretches along the travel and squashes when it lands.
function Tab:MoveIndicator(animate)
    local window, frame = self.Window, self.Nav.Frame
    if frame.Size.X.Offset <= 0 then
        return
    end
    local chrome = Config.Chrome
    local bubble, side = window.Bubble, window:DockMetrics().Bubble
    local target = UDim2.fromOffset(frame.Position.X.Offset + math.floor(frame.Size.X.Offset / 2), frame.Position.Y.Offset + math.floor(frame.Size.Y.Offset / 2))
    local size = UDim2.fromOffset(side, side)
    bubble.Visible = true
    window.BubblePlaced = true
    if not animate then
        Motion.Set(bubble, "Position", target)
        Motion.Set(bubble, "Size", size)
        return
    end
    local distance = math.abs(target.Y.Offset - Motion.Target(bubble, "Position").Y.Offset)
    local stretch = math.min(distance * chrome.Stretch, chrome.StretchMax)
    Motion.Spring(bubble, "Position", target, "Normal", chrome.BubbleSpring)
    Motion.Spring(bubble, "Size", size, "Fast", chrome.SquashSpring)
    Motion.Impulse(bubble, "Size", { 0, -stretch * 0.5, 0, stretch }, "Fast", chrome.SquashSpring.Damping)
end

function Tab:ApplyWidth()
    local width = self.PendingWidth
    if not width then
        return
    end
    self.PendingWidth = nil
    self.Root:SetWidth(width - Config.Page.ScrollBar)
end

---@param forward boolean  slide direction follows tab order
function Tab:SetShown(shown, forward)
    local from
    if shown then
        from = forward and "Right" or "Left"
    else
        from = forward and "Left" or "Right"
    end
    self.Window:PresentPage(self, shown, from)
end

---Cards spring up one after another when the page comes in.
function Tab:EnterCards()
    if Motion.Reduced then
        return
    end
    local lifts = {}
    for index, box in ipairs(self.Groupboxes) do
        if index > Config.Chrome.Cards.Max then
            break
        end
        lifts[index] = box.Lift
        Fx.Prime(box.Lift)
    end
    Fx.Stagger(lifts, Config.Chrome.Cards.Stagger, Fx.Rise)
end

---@param info any  name spec or { Name, Side = "Left"|"Right"|nil (full width), Icon, Collapsed }
function Tab:AddGroupbox(info, icon)
    if type(info) ~= "table" or info.EN or info.TH then
        local side = (icon == "Left" or icon == "Right") and icon or nil
        info = { Name = info, Icon = side == nil and icon or nil, Side = side }
    end
    local column = (info.Side == "Left" and self.Left) or (info.Side == "Right" and self.Right) or self.Root
    return Groupbox.New(self, column, info)
end

function Tab:AddLeftGroupbox(name, icon)
    return self:AddGroupbox({ Name = name, Side = "Left", Icon = icon })
end

function Tab:AddRightGroupbox(name, icon)
    return self:AddGroupbox({ Name = name, Side = "Right", Icon = icon })
end

---@return number  header bar height; touch layouts get a full 44 px tap row
function Groupbox.HeaderHeight()
    return Platform.Metric("Header")
end

function Groupbox.New(tab, column, info)
    local group, z = Config.Group, Config.Chrome.Z
    local holder = Draw.New("Frame", { Name = "Groupbox", BackgroundTransparency = 1 })
    local lift = Draw.New("Frame", { Name = "Lift", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = holder })
    Draw.Box("Frame", { Name = "Shadow", Position = UDim2.fromOffset(group.Shadow, group.Shadow), Size = UDim2.new(1, -group.Shadow, 1, -group.Shadow), ZIndex = z.Shadow, Parent = lift }, "Shadow", nil, group.Radius)
    local card = Draw.Box("Frame", { Name = "Card", Size = UDim2.new(1, -group.Shadow, 1, -group.Shadow), ZIndex = z.Body, Parent = lift }, "Panel", "Outline", group.Radius, group.Stroke)
    local body = Draw.New("Frame", { Name = "Body", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, Groupbox.HeaderHeight()), Size = UDim2.new(1, 0, 1, -Groupbox.HeaderHeight()), ClipsDescendants = true, Parent = card })
    local box = Container.New(body, { PadX = group.PadX, PadY = group.PadY, Window = tab.Window, Tab = tab })
    setmetatable(box, Groupbox)
    box.Name, box.Icon, box.Column, box.Card, box.Holder, box.Lift = info.Name, info.Icon, column, card, holder, lift
    box.SearchTitle = Lang.SearchText(info.Name)
    box.Collapsed = info.Collapsed == true
    box.Open = Draw.New("NumberValue", { Value = box.Collapsed and 0 or 1 })
    box:BuildHeader(card)
    box.Item = column:Add(holder, {
        Height = function()
            return Groupbox.HeaderHeight() + math.floor(box.ContentHeight * box.Open.Value + 0.5) + group.Shadow
        end,
        Child = box,
        ChildInset = group.Shadow,
        Label = info.Name,
    })
    Util.Connect(box.Open.Changed, function()
        box:PaintSeam()
        column:MarkDirty()
    end)
    box.OnHeight = function()
        box:PaintSeam()
    end
    box:PaintSeam()
    table.insert(tab.Groupboxes, box)
    return box
end

function Groupbox:BuildHeader(card)
    local group = Config.Group
    local bar = Draw.Box("TextButton", { Name = "Header", Size = UDim2.new(1, 0, 0, Groupbox.HeaderHeight()) }, "PanelHeader", nil, group.Radius)
    bar.Parent = card
    self.Patch = Draw.Box("Frame", { Name = "Patch", Position = UDim2.new(0, 0, 1, -group.Radius), Size = UDim2.new(1, 0, 0, group.Radius), Parent = bar }, "PanelHeader")
    self.Seam = Draw.Box("Frame", { Name = "Line", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, group.Stroke), ZIndex = Config.Chrome.Z.Raised, Parent = bar }, "Outline")
    local textX = group.PadX
    if self.Icon then
        local iconSize = Platform.Metric("Icon")
        local icon = Sprite.New(bar, self.Icon, iconSize)
        icon.AnchorPoint, icon.Position, icon.ZIndex = Vector2.new(0, 0.5), UDim2.new(0, group.PadX, 0.5, 0), Config.Chrome.Z.Raised
        textX += iconSize + Config.Button.IconGap
    end
    local chevronSize = Util.TextSize("Small")
    Draw.Text({ Name = "Title", Position = UDim2.fromOffset(textX, 0), Size = UDim2.new(1, -(textX + group.PadX + chevronSize), 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = Config.Chrome.Z.Raised, Parent = bar }, "Body", Util.TextSize("Group"), "Text", self.Name or "")
    self.Chevron = Draw.Text({
        Text = "▼",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -group.PadX, 0.5, 0),
        Size = UDim2.fromOffset(chevronSize, chevronSize),
        TextXAlignment = Enum.TextXAlignment.Center,
        Rotation = self.Collapsed and -90 or 0,
        ZIndex = Config.Chrome.Z.Raised,
        Parent = bar,
    }, "Glyph", chevronSize - 1, "Muted")
    self.HeaderBar = bar
    Gui.Clickable(bar, {
        OnHover = function(hovered)
            local base = Theme.Color("PanelHeader")
            Motion.Spring(bar, "BackgroundColor3", hovered and base:Lerp(Theme.Color("Hover"), 0.6) or base, "Fast")
        end,
        OnClick = function()
            self:SetCollapsed(not self.Collapsed)
        end,
    })
end

---Header patch and divider shrink with the open body so no square corner ever pokes past the rounded card.
function Groupbox:PaintSeam()
    local radius = Config.Group.Radius
    local shown = math.clamp(self.ContentHeight * self.Open.Value, 0, radius)
    self.Patch.Size = UDim2.new(1, 0, 0, shown)
    self.Seam.BackgroundTransparency = 1 - shown / radius
end

function Groupbox:SetCollapsed(collapsed)
    self.Collapsed = collapsed == true
    Motion.Spring(self.Open, "Value", self.Collapsed and 0 or 1, "Normal")
    Motion.Spring(self.Chevron, "Rotation", self.Collapsed and -90 or 0, "Fast", { Damping = Config.Chrome.ChevronDamping })
end

function Search.Normalize(text)
    return tostring(text or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
end

---@return Frame field, TextBox box  rounded input with the search icon
function Search.Field()
    local chrome = Config.Chrome
    local field = Draw.Box("Frame", { Name = "SearchField" }, "Element", "Outline", UDim.new(1, 0), 2)
    local icon = Sprite.New(field, "search", chrome.SearchIcon)
    icon.AnchorPoint, icon.Position = Vector2.new(0, 0.5), UDim2.new(0, chrome.SearchPad, 0.5, 0)
    local textX = chrome.SearchPad + chrome.SearchIcon + Config.Button.IconGap
    local box = Draw.Text({
        ClassName = "TextBox",
        ClearTextOnFocus = false,
        Position = UDim2.fromOffset(textX, 0),
        Size = UDim2.new(1, -(textX + chrome.SearchPad), 1, 0),
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = field,
    }, "Body", Util.TextSize("Label"), "Text")
    Lang.Bind(box, Lang.Strings.Search, "PlaceholderText")
    Theme.Bind(box, { PlaceholderColor3 = "Muted" })
    local stroke = field:FindFirstChildOfClass("UIStroke")
    box.Focused:Connect(function()
        Theme.Bind(stroke, { Color = "Accent" })
    end)
    box.FocusLost:Connect(function()
        Theme.Bind(stroke, { Color = "Outline" })
    end)
    return field, box
end

---@return table[]  { Tab, Box, Item } every searchable layout item, walking child containers
function Search.Entries(window)
    local entries = {}
    for _, tab in ipairs(window.Tabs) do
        for _, box in ipairs(tab.Groupboxes) do
            Search.Walk(entries, tab, box, box, 0)
        end
    end
    return entries
end

function Search.Walk(entries, tab, box, container, depth)
    for _, item in ipairs(container.Items) do
        if item.Search then
            table.insert(entries, { Tab = tab, Box = box, Item = item })
        end
        if item.Child and depth < 3 then
            Search.Walk(entries, tab, box, item.Child, depth + 1)
        end
    end
end

---@return table?  option that owns a layout item, cached on the item
function Search.WidgetOf(item)
    if item.Widget == nil then
        for _, option in pairs(Library.Options) do
            if option.Item == item or (type(option.Row) == "table" and option.Row.Item == item) then
                item.Widget = option
                break
            end
        end
        item.Widget = item.Widget or false
    end
    return item.Widget or nil
end

function Search.LabelOf(item)
    if item.Label ~= nil then
        return Lang.Resolve(item.Label)
    end
    local widget = Search.WidgetOf(item)
    if widget and widget.Text ~= nil then
        return Lang.Resolve(widget.Text)
    end
    return item.Search or ""
end

function Search.PathOf(entry)
    return string.format("%s › %s › %s", Lang.Resolve(entry.Tab.Name), Lang.Resolve(entry.Box.Name), Search.LabelOf(entry.Item))
end

---@return table[]  entries whose search text contains query, capped at Config.Chrome.ResultLimit
function Search.Collect(window, query)
    local found = {}
    for _, entry in ipairs(Search.Entries(window)) do
        if entry.Item.Search:find(query, 1, true) or entry.Box.SearchTitle:find(query, 1, true) then
            table.insert(found, entry)
            if #found >= Config.Chrome.ResultLimit then
                break
            end
        end
    end
    return found
end

function Search.Render(container, window, query, onPick)
    container:Clear()
    query = Search.Normalize(query)
    if query == "" then
        return
    end
    local found = Search.Collect(window, query)
    if #found == 0 then
        Gui.Text(container, Lang.Strings.NoResults, { Kind = "Desc" })
        return
    end
    for _, entry in ipairs(found) do
        Gui.Selectable(container, {
            Text = Search.PathOf(entry),
            Height = Config.Chrome.ResultRow,
            Callback = function()
                onPick(entry)
            end,
        })
    end
end

---@return number  y offset of frame inside the scrolling canvas
function Search.CanvasY(frame, scroll)
    local y = 0
    local node = frame
    while node and node ~= scroll do
        if node:IsA("GuiObject") then
            y += node.Position.Y.Offset
        end
        node = node.Parent
    end
    return y
end

function Search.Jump(window, entry)
    window:SetQuery("")
    window:SelectTab(entry.Tab)
    local box = entry.Box
    if box.Collapsed then
        box:SetCollapsed(false)
    end
    Layout.Flush()
    local scroll = entry.Tab.Scroll
    local maxY = math.max(0, scroll.AbsoluteCanvasSize.Y - scroll.AbsoluteWindowSize.Y)
    local target = math.clamp(Search.CanvasY(entry.Item.Frame, scroll) - Config.Page.Pad * 2, 0, maxY)
    Motion.Spring(scroll, "CanvasPosition", Vector2.new(0, target), "Soft")
    Search.Flash(entry.Item)
end

function Search.Flash(item)
    local widget = Search.WidgetOf(item)
    if widget then
        widget:Flash()
        return
    end
    local glow = Draw.Box("Frame", { Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = Config.Chrome.Z.Flash, Parent = item.Frame }, "Glow", "Coin", Platform.Metric("Radius"), 2)
    local stroke = glow:FindFirstChildOfClass("UIStroke")
    if not stroke then
        glow:Destroy()
        return
    end
    stroke.Transparency = Config.Chrome.FlashAlpha
    Motion.Spring(stroke, "Transparency", 1, "Soft", { OnDone = Search.FlashDone })
end

function Search.FlashDone(stroke)
    if stroke.Parent then
        stroke.Parent:Destroy()
    end
end

function Search.OpenSheet(window)
    Sheet.Open(Lang.Strings.Search, function(container)
        local field, box = Search.Field()
        container:Add(field, { Height = Platform.Metric("Box") })
        local results = Gui.BeginChild(container, "Results", {})
        Gui.EndChild()
        box:GetPropertyChangedSignal("Text"):Connect(function()
            Search.Render(results, window, box.Text, function(entry)
                Sheet.Close()
                Search.Jump(window, entry)
            end)
        end)
        task.defer(box.CaptureFocus, box)
    end, { Height = 0.8 })
end

---@return boolean  index starts a word: after space/_/-, or a lower-to-upper change
function Palette.WordStart(raw, index)
    if index == 1 then
        return true
    end
    local before, here = raw:sub(index - 1, index - 1), raw:sub(index, index)
    return before == " " or before == "_" or before == "-" or (before:match("%l") ~= nil and here:match("%u") ~= nil)
end

---@return number?  fuzzy score, nil when the query only hits mid-word letters
function Palette.Score(raw, query)
    local text, settings = raw:lower(), Config.Chrome.Palette
    query = query:lower()
    if #query == 0 then
        return nil
    end
    if text == query then
        return 1000
    end
    local plain = text:find(query, 1, true)
    if plain == 1 then
        return 800 - #text / 100
    end
    if plain then
        return (Palette.WordStart(raw, plain) and 600 or 400) - plain
    end
    local score, from, last, first = 0, 1, 0, nil
    for index = 1, #query do
        local found = text:find(query:sub(index, index), from, true)
        while found and found ~= last + 1 and not Palette.WordStart(raw, found) do
            found = text:find(query:sub(index, index), found + 1, true)
        end
        if not found or (index == 1 and not Palette.WordStart(raw, found)) then
            return nil
        end
        score += found == last + 1 and index > 1 and 6 or 10
        score -= index > 1 and (found - last - 1) or 0
        first = first or found
        last, from = found, found + 1
    end
    if score < #query * settings.MinScore then
        return nil
    end
    return score
end

function Palette.Toggle(window)
    if Palette.Frame and Palette.Frame.Visible then
        Palette.Close()
    else
        Palette.Open(window)
    end
end

function Palette.Open(window)
    if not window or Library.Unloaded then
        return
    end
    Palette.Window = window
    if not Palette.Frame then
        Palette.Build()
    end
    Palette.Fit()
    Palette.Box.Text = ""
    Palette.Refresh()
    Palette.Frame.Visible = true
    Motion.Set(Palette.Frame, "BackgroundTransparency", 1)
    Motion.Spring(Palette.Frame, "BackgroundTransparency", Config.Chrome.Palette.Dim, "Fast")
    Motion.Pop(Palette.Card)
    task.defer(Palette.Box.CaptureFocus, Palette.Box)
end

function Palette.Close()
    if not Palette.Frame or not Palette.Frame.Visible then
        return
    end
    Palette.Frame.Visible = false
    if Palette.Box:IsFocused() then
        Palette.Box:ReleaseFocus()
    end
end

function Palette.Build()
    local settings = Config.Chrome.Palette
    local dim = Draw.New("TextButton", { Name = "Palette", Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 0, Visible = false, Parent = Popup.Layer("Dialog") })
    dim.Activated:Connect(Palette.Close)
    local holder, face = Draw.Block(dim, "Panel", "Shadow", Config.Group.Radius, Config.Group.Shadow)
    holder.AnchorPoint, holder.Position = Vector2.new(0.5, 0), UDim2.fromScale(0.5, settings.Top)
    holder.Size = UDim2.fromOffset(Palette.Width(), Platform.Metric("Box"))
    Draw.New("UIScale", { Name = "MotionScale", Parent = holder })
    Draw.New("TextButton", { Name = "Sink", Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = face })
    local body = Container.New(face, {
        PadX = settings.Pad,
        PadY = settings.Pad,
        OnHeight = function(height)
            holder.Size = UDim2.fromOffset(Palette.Width(), height + Config.Group.Shadow)
        end,
    })
    local field, box = Search.Field()
    body:Add(field, { Height = Platform.Metric("Box") })
    Gui.Text(body, Lang.Strings.PaletteHint, { Kind = "Desc", Token = "Muted" })
    Palette.Results = Gui.BeginChild(body, "Results", {})
    Gui.EndChild()
    Palette.Frame, Palette.Card, Palette.Box, Palette.Body = dim, holder, box, body
    Palette.Fit()
    Util.Connect(State.Stage:GetPropertyChangedSignal("AbsoluteSize"), Palette.Fit)
    box:GetPropertyChangedSignal("Text"):Connect(Palette.Refresh)
    box.FocusLost:Connect(function(enter)
        if enter then
            Palette.Run(Palette.Matches[Palette.Index])
        end
        task.defer(Palette.Close)
    end)
    Util.Connect(UserInputService.InputBegan, Palette.OnKey)
end

---@return number  card width, clamped inside the viewport margins
function Palette.Width()
    return math.min(Config.Chrome.Palette.Width, State.Stage.AbsoluteSize.X - Config.Overlay.Margin * 2)
end

function Palette.Fit()
    if not Palette.Card then
        return
    end
    local width = Palette.Width()
    Palette.Card.Size = UDim2.fromOffset(width, Palette.Card.Size.Y.Offset)
    Palette.Body:SetWidth(width - Config.Group.Shadow)
end

function Palette.OnKey(input)
    if not Palette.Frame or not Palette.Frame.Visible then
        return
    end
    local step = (input.KeyCode == Enum.KeyCode.Down and 1) or (input.KeyCode == Enum.KeyCode.Up and -1) or 0
    if step == 0 or #Palette.Matches == 0 then
        return
    end
    Palette.Index = (Palette.Index - 1 + step) % #Palette.Matches + 1
    Palette.Highlight()
end

function Palette.Refresh()
    local query = Search.Normalize(Palette.Box.Text)
    local scored = {}
    if query ~= "" then
        for _, entry in ipairs(Search.Entries(Palette.Window)) do
            local score = Palette.Score(Search.LabelOf(entry.Item), query) or Palette.Score(entry.Item.Search, query)
            if score then
                entry.Score = score
                table.insert(scored, entry)
            end
        end
        table.sort(scored, function(left, right)
            return left.Score > right.Score
        end)
    end
    Palette.Matches, Palette.Index, Palette.Rows = scored, 1, {}
    local results = Palette.Results
    results:Clear()
    for index = 1, math.min(#scored, Config.Chrome.Palette.Rows) do
        local entry = scored[index]
        Palette.Rows[index] = Gui.Selectable(results, {
            Text = Palette.Describe(entry),
            Callback = function()
                Palette.Run(entry)
                Palette.Close()
            end,
        })
    end
    Palette.Highlight()
end

function Palette.Describe(entry)
    local widget = Search.WidgetOf(entry.Item)
    local state = ""
    if widget and (widget.Type == "Toggle" or widget.Type == "Checkbox") then
        state = "  [" .. Lang.Resolve(widget.Value and Lang.Strings.On or Lang.Strings.Off) .. "]"
    end
    return Search.PathOf(entry) .. state
end

function Palette.Highlight()
    for index, row in ipairs(Palette.Rows or {}) do
        row:SetSelected(index == Palette.Index)
    end
end

---Toggles flip in place; anything else jumps to the widget and focuses its text box if it has one.
function Palette.Run(entry)
    if not entry then
        return
    end
    local widget = Search.WidgetOf(entry.Item)
    if widget and (widget.Type == "Toggle" or widget.Type == "Checkbox") then
        widget:SetValue(not widget.Value)
        return
    end
    Search.Jump(Palette.Window, entry)
    local box = widget and (widget.Box or widget.TextBox)
    if typeof(box) == "Instance" and box:IsA("TextBox") then
        task.defer(box.CaptureFocus, box)
    end
end

function Window:AddSettingsTab()
    local tab = self:AddTab(Lang.Strings.Settings, "settings", Lang.Strings.SettingsDesc)
    self:BuildThemeGroup(tab:AddLeftGroupbox(Lang.Strings.ThemeName, "theme"))
    self:BuildInterfaceGroup(tab:AddLeftGroupbox(Lang.Strings.Interface, "pc"))
    self:BuildOverlayGroup(tab:AddLeftGroupbox(Lang.Strings.Overlays, "eye"))
    Window.BuildConfigGroup(tab:AddRightGroupbox(Lang.Strings.Configs, "config"))
    self:BuildQuickBarGroup(tab:AddRightGroupbox(Lang.Strings.QuickBar, "pin"))
    self:BuildAboutGroup(tab:AddRightGroupbox(Lang.Strings.About, "info"))
    self.SettingsTab = tab
    return tab
end

function Window:BuildThemeGroup(group)
    local columns = Config.Chrome.ThemeCard.Columns
    local cards = {}
    for index, name in ipairs(Themes.Order) do
        if (index - 1) % columns ~= 0 then
            group:SameLine()
        end
        cards[name] = Window.ThemeCard(group, name, columns)
    end
    Theme.OnRender(cards, function()
        for name, stroke in pairs(cards) do
            local active = name == State.ThemeName
            stroke.Thickness = active and 3 or 2
            Theme.Bind(stroke, { Color = active and "Accent" or "Outline" })
        end
    end)
    group.ThemeCards = cards
end

---@return UIStroke  outline that marks the active theme
function Window.ThemeCard(group, name, columns)
    local palette, card = Themes[name], Config.Chrome.ThemeCard
    local cell = Draw.New("Frame", { Name = name, BackgroundTransparency = 1 })
    local preview = Draw.Box("Frame", { Name = "Preview", BackgroundColor3 = palette.Backdrop, BackgroundTransparency = 0, ClipsDescendants = true, Size = UDim2.new(1, 0, 0, card.Preview), Parent = cell }, nil, nil, Platform.Metric("Radius"))
    local stroke = Draw.Stroke(preview, "Outline", 2, true)
    Window.ThemeScene(preview, palette, card)
    local label = Draw.Text({ Text = name, Position = UDim2.fromOffset(0, card.Preview + card.Gap), Size = UDim2.new(1, 0, 0, card.Label), TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, Parent = cell }, "Strong", Util.TextSize("Small"), "Text")
    group:Add(cell, { Width = 1 / columns, Height = card.Preview + card.Gap + card.Label, Search = "theme " .. name:lower(), Label = name })
    Gui.Clickable(cell, {
        OnClick = function()
            Motion.Pop(preview)
            Library:SetTheme(name)
            Settings.Set("Theme", name)
        end,
    })
    Theme.OnRender(label, function()
        label.TextColor3 = Theme.Color(name == State.ThemeName and "Accent" or "SubText")
    end)
    return stroke
end

---Miniature of the real window in a theme's colors: header sky, dock, a card with a switch, ground strip.
function Window.ThemeScene(preview, palette, card)
    local function Block(parent, color, position, size, round)
        local block = Draw.New("Frame", { BackgroundColor3 = color, BorderSizePixel = 0, Position = position, Size = size, Parent = parent })
        if round then
            Draw.Corner(block, round)
        end
        return block
    end
    local sky = Block(preview, palette.Topbar, UDim2.new(), UDim2.fromScale(1, card.Sky))
    Block(sky, palette.Grass, UDim2.fromScale(0.58, 0.7), UDim2.fromScale(0.34, 0.7), UDim.new(1, 0))
    Block(sky, palette.Cloud, UDim2.fromScale(0.12, 0.3), UDim2.fromScale(0.16, 0.22), UDim.new(1, 0))
    Block(sky, palette.Cloud, UDim2.fromScale(0.4, 0.18), UDim2.fromScale(0.12, 0.18), UDim.new(1, 0))
    Block(preview, palette.Outline, UDim2.fromScale(0, card.Sky), UDim2.new(1, 0, 0, 1))
    local ground = Block(preview, palette.Brick, UDim2.fromScale(0, 1 - card.Ground), UDim2.fromScale(1, card.Ground))
    Block(ground, palette.Grass, UDim2.new(), UDim2.new(1, 0, 0, 2))
    local bodyTop, bodyHeight = card.Sky + 0.07, 1 - card.Sky - card.Ground - 0.14
    local dock = Block(preview, palette.Sidebar, UDim2.fromScale(0.05, bodyTop), UDim2.fromScale(0.11, bodyHeight), UDim.new(0, 4))
    Block(dock, palette.TabActive, UDim2.fromScale(0.18, 0.1), UDim2.fromScale(0.64, 0.28), UDim.new(0, 2))
    Block(dock, palette.SidebarMuted, UDim2.fromScale(0.3, 0.56), UDim2.fromScale(0.4, 0.14), UDim.new(1, 0))
    local panel = Block(preview, palette.Panel, UDim2.fromScale(0.22, bodyTop), UDim2.fromScale(0.72, bodyHeight), UDim.new(0, 4))
    Block(panel, palette.PanelHeader, UDim2.new(), UDim2.fromScale(1, 0.34), UDim.new(0, 4))
    Block(panel, palette.Muted, UDim2.fromScale(0.08, 0.56), UDim2.fromScale(0.4, 0.14), UDim.new(1, 0))
    local switch = Block(panel, palette.Good, UDim2.fromScale(0.64, 0.48), UDim2.fromScale(0.26, 0.32), UDim.new(1, 0))
    Block(switch, Color3.new(1, 1, 1), UDim2.fromScale(0.52, 0.12), UDim2.fromScale(0.36, 0.76), UDim.new(1, 0))
end

function Window:BuildInterfaceGroup(group)
    group:AddDropdown("MarioLanguage", {
        Text = Lang.Strings.Language,
        Values = { "English", "ไทย" },
        Default = State.Language == "TH" and "ไทย" or "English",
        NoSave = true,
        Callback = function(value)
            local code = value == "ไทย" and "TH" or "EN"
            Library:SetLanguage(code)
            Settings.Set("Language", code)
        end,
    })
    group:AddSlider("MarioScale", {
        Text = Lang.Strings.Scale, Min = Config.ScaleRange.Min * 100, Max = Config.ScaleRange.Max * 100,
        Default = State.UserScale * 100, Suffix = "%", Finished = true, NoSave = true,
        Callback = function(value)
            self:SetScale(value / 100)
            Settings.Set("Scale", State.UserScale)
        end,
    })
    group:AddSlider("MarioTransparency", {
        Text = Lang.Strings.Transparency, Min = 0, Max = 60, Default = math.floor((Settings.Get("Transparency", 0)) * 100), Suffix = "%", NoSave = true,
        Callback = function(value)
            self:SetTransparency(value / 100)
            Settings.Set("Transparency", value / 100)
        end,
    })
    group:AddToggle("MarioReduceMotion", {
        Text = Lang.Strings.ReduceMotion, Description = Lang.Strings.ReduceMotionDesc, Default = Motion.UserReduced, NoSave = true,
        Callback = function(enabled)
            Motion.SetReduced(enabled)
            Settings.Set("ReduceMotion", enabled)
        end,
    })
    group:AddToggle("MarioParticles", {
        Text = Lang.Strings.Particles, Description = Lang.Strings.ParticlesDesc, Default = Particles.Enabled, NoSave = true,
        Callback = function(enabled)
            Particles.SetEnabled(enabled)
            Settings.Set("Particles", enabled)
        end,
    })
    group:AddKeybind("MarioMenuKey", {
        Text = Lang.Strings.MenuKey, Default = State.MenuKey, Mode = "Always", NoSave = true,
        ChangedCallback = function(name)
            State.MenuKey = name
            Settings.Set("MenuKey", name)
        end,
    })
end

function Window:BuildOverlayGroup(group)
    group:AddToggle("MarioWatermark", {
        Text = Lang.Strings.Watermark, Description = Lang.Strings.WatermarkDesc, Default = Settings.Get("Watermark", true) == true, NoSave = true,
        Callback = function(enabled)
            Watermark.SetVisible(enabled)
            Settings.Set("Watermark", enabled)
        end,
    })
    group:AddToggle("MarioKeybindList", {
        Text = Lang.Strings.KeybindList, Default = Settings.Get("KeybindList", false) == true, NoSave = true,
        Callback = function(enabled)
            KeybindList.SetVisible(enabled)
            Settings.Set("KeybindList", enabled)
        end,
    })
    group:AddToggle("MarioFloat", {
        Text = Lang.Strings.FloatButton, Description = Lang.Strings.FloatDesc, Default = Settings.Get("Float", Platform.Touch) == true, NoSave = true,
        Callback = function(enabled)
            Float.SetVisible(enabled)
            Settings.Set("Float", enabled)
        end,
    })
    group:AddSlider("MarioFloatSize", {
        Text = Lang.Strings.FloatSize, Min = 40, Max = 80, Default = Settings.Get("FloatSize", 56), Suffix = "px", Finished = true, NoSave = true,
        Callback = function(value)
            Float.SetSize(value)
            Settings.Set("FloatSize", value)
        end,
    })
    local corners = Lang.Strings.NotifyCorners
    group:AddDropdown("MarioNotifyCorner", {
        Text = Lang.Strings.NotifyPosition,
        Values = corners[State.Language] or corners.EN,
        Default = table.find(Window.Corners, Settings.Get("NotifyCorner", "BottomRight")) or 1,
        NoSave = true,
        Callback = function(value)
            local index = table.find(corners.EN, value) or table.find(corners.TH, value) or 1
            Notify.SetPosition(Window.Corners[index])
            Settings.Set("NotifyCorner", Window.Corners[index])
        end,
    })
end

---@return string[] names, table<string, string> nameToIdx  every toggle the user can put on the quick bar
function Window.ToggleChoices()
    local names, lookup = {}, {}
    for idx, option in pairs(Library.Toggles) do
        if type(idx) == "string" and not idx:find("^Mario") then
            local name = Lang.Resolve(option.Text or idx)
            if lookup[name] then
                name = name .. " (" .. idx .. ")"
            end
            lookup[name] = idx
            table.insert(names, name)
        end
    end
    table.sort(names)
    return names, lookup
end

function Window:BuildQuickBarGroup(group)
    local choices = {}
    choices.Names, choices.Lookup = Window.ToggleChoices()
    local dropdown = group:AddDropdown("MarioQuickBar", {
        Text = Lang.Strings.QuickBar, Description = Lang.Strings.QuickBarDesc, Values = choices.Names, Multi = true, NoSave = true,
        Callback = function(selected)
            Window.ApplyQuickBar(selected, choices)
        end,
    })
    Gui.Button(group, {
        Text = Lang.Strings.Refresh,
        Icon = "refresh",
        Width = 1,
        Callback = function()
            choices.Names, choices.Lookup = Window.ToggleChoices()
            dropdown:SetValues(choices.Names)
        end,
    })
end

---Pins follow the dropdown's value order; QuickBar persists its own pins.
---@param selected table  dropdown multi value (set of names)
---@param choices table   { Names, Lookup = name -> idx }
function Window.ApplyQuickBar(selected, choices)
    local wanted = {}
    for _, name in ipairs(choices.Names) do
        local idx = choices.Lookup[name]
        if idx and selected and selected[name] then
            wanted[idx] = true
        end
    end
    for _, idx in pairs(choices.Lookup) do
        if not wanted[idx] and QuickBar.Has(idx) then
            QuickBar.Remove(idx)
        end
    end
    for _, name in ipairs(choices.Names) do
        local idx = choices.Lookup[name]
        if wanted[idx] and not QuickBar.Has(idx) then
            QuickBar.Add(idx)
        end
    end
end

function Window.BuildConfigGroup(group)
    local nameInput = group:AddInput("MarioConfigName", { Text = Lang.Strings.ConfigName, Placeholder = "default", NoSave = true })
    local list = group:AddListBox("MarioConfigList", { Text = Lang.Strings.SavedConfigs, Values = Configs.List(), Height = 4, NoSave = true })
    local autoload = group:AddLabel(Lang.Format("Autoload", Configs.GetAutoload() or Lang.Get("None")))
    local ui = { Name = nameInput, List = list, Autoload = autoload }
    local actions = {
        { "Save", "Primary", Configs.Save, "save" }, { "Load", "Success", Configs.Load, "load" },
        { "Delete", "Danger", Configs.Delete, "trash" }, { "SetAutoload", "Warning", Configs.SetAutoload, "bookmark" },
    }
    for index, action in ipairs(actions) do
        if index % 2 == 0 then
            group:SameLine()
        end
        Gui.Button(group, {
            Text = Lang.Strings[action[1]],
            Icon = action[4],
            Style = action[2],
            Width = 0.5,
            Callback = function()
                Window.RunConfig(ui, action[1], action[3])
            end,
        })
    end
    local importInput = group:AddInput("MarioConfigImport", { Text = Lang.Strings.ImportString, Placeholder = Lang.Strings.ImportPlaceholder, NoSave = true })
    Gui.Button(group, { Text = Lang.Strings.Export, Icon = "export", Width = 0.5, Callback = function()
        Window.ExportConfig()
    end })
    group:SameLine()
    Gui.Button(group, { Text = Lang.Strings.Import, Icon = "import", Style = "Primary", Width = 0.5, Callback = function()
        Window.ImportConfig(importInput)
    end })
    Gui.Button(group, { Text = Lang.Strings.Refresh, Icon = "refresh", Width = 1, Callback = function()
        list:SetValues(Configs.List())
    end })
    Gui.Button(group, { Text = Lang.Strings.ResetTab, Icon = "refresh", Width = 0.5, Callback = function()
        Window.ResetOptions(Library.Window and Library.Window.ActiveTab)
    end })
    group:SameLine()
    Gui.Button(group, { Text = Lang.Strings.ResetAll, Icon = "warn", Style = "Danger", Width = 0.5, Callback = function()
        Window.ResetOptions("All")
    end })
end

function Window.ResetOptions(scope)
    local count = Library:ResetConfig(scope or "All")
    Library:Notify(Lang.Strings.Configs, Lang.Get("ResetDone", count or 0), 3, "Success")
end

function Window.SelectedConfig(ui)
    local typed = tostring(ui.Name.Value or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if typed ~= "" then
        return typed
    end
    local picked = ui.List.Value
    return type(picked) == "string" and picked ~= "" and picked or nil
end

function Window.RunConfig(ui, actionKey, handler)
    local name = Window.SelectedConfig(ui)
    if not name then
        Library:Notify(Lang.Strings.Configs, Lang.Strings.PickConfig, 3, "Warning")
        return
    end
    local ok, reason = handler(name)
    local action = Lang.Strings[actionKey]
    local message = ok and { EN = action.EN .. ": " .. name, TH = action.TH .. ": " .. name }
        or { EN = action.EN .. " failed: " .. tostring(reason), TH = action.TH .. " ไม่สำเร็จ: " .. tostring(reason) }
    Library:Notify(Lang.Strings.Configs, message, 3, ok and "Success" or "Error")
    if ok and actionKey == "SetAutoload" then
        ui.Autoload:SetText(Lang.Format("Autoload", name))
    end
    ui.List:SetValues(Configs.List())
end

function Window.ExportConfig()
    local copied = Util.Clipboard(Configs.Export())
    Library:Notify(Lang.Strings.Configs, copied and Lang.Strings.Exported or Lang.Strings.NoClipboard, 3, copied and "Success" or "Warning")
end

function Window.ImportConfig(input)
    local ok = Configs.Import(tostring(input.Value or ""))
    Library:Notify(Lang.Strings.Configs, ok and Lang.Strings.Imported or Lang.Strings.ImportBroken, 3, ok and "Success" or "Error")
end

function Window:BuildAboutGroup(group)
    group:AddLabel(string.format("%s · %s %s", self.Title, Lang.Get("Version"), Library.Version))
    group:AddLabel(Lang.Format("Device", Platform.Mode))
    local armed = 0
    Gui.Button(group, {
        Text = Lang.Strings.Unload,
        Icon = "power",
        Style = "Danger",
        Width = 1,
        Callback = function(handle)
            if os.clock() - armed > Config.ConfirmWindow then
                armed = os.clock()
                handle:Set(Lang.Strings.ConfirmUnload)
                Motion.Shake(handle.Face)
                task.delay(Config.ConfirmWindow, function()
                    if handle.Label.Parent then
                        handle:Set(Lang.Strings.Unload)
                    end
                end)
                return
            end
            Library:Unload()
        end,
    })
end

---@author xDTaraZ  Mario Hub UI V2
Config.Intro = {
    Width = 440, Height = 236, Margin = 16, MaxScale = 1.35, Scrim = 0.12,
    MinShow = 1.5, MaxShow = 2.2, Exit = 0.32, Flourish = 0.12, Hold = 0, StepTimeout = 15,
    Block = 56, BlockY = 62, Bump = 0.24, Open = 0.5,
    Coin = 30, CoinRise = 58, CoinSpin = 520,
    Letter = 62, LogoY = 20, LetterRise = 18, Drop = 5, Stagger = 0.04,
    SubY = 104, SubSize = 18,
    BarY = 186, BarHeight = 12, BarInset = 26, Runner = 28, Flag = 52,
    StatusSize = 15,
}

Lang.Strings.IntroSkip = { EN = "Click to skip", TH = "คลิกเพื่อข้าม" }
Lang.Strings.IntroSkipTouch = { EN = "Tap to skip", TH = "แตะเพื่อข้าม" }

Intro.PopIn = { Damping = 0.45 }
Intro.LetterPop = { Damping = 0.42 }
Intro.Settle = { Damping = 0.55 }
Intro.CoinSpinOptions = { Damping = 0.12 }

---Mario level loader. Yields at most Config.Intro.MaxShow (+ Hold); steps still running then finish in the background.
---@param settings table  { Title, SubTitle, Steps = { { Label, Run } }, OnDone, Enabled = true }
function Intro.Play(settings)
    settings = settings or {}
    settings.Started = os.clock()
    Intro.Skipped = false
    if settings.Enabled == false or Motion.Reduced or not State.Gui then
        task.spawn(Intro.RunSteps, settings, nil)
        Intro.Wait(settings, 0)
    else
        local scene = Intro.Build(settings)
        local ok = Util.Try(Intro.Show, settings, scene)
        Intro.Teardown(scene)
        if not ok and not settings.Ran then
            Intro.Wait(settings, 0)
        end
    end
    Intro.Finish(settings)
end

---Fires OnDone once; the exit calls it early so the window opens under the iris.
function Intro.Finish(settings)
    if settings.Finished or Library.Unloaded then
        return
    end
    settings.Finished = true
    Util.Try(settings.OnDone)
end

---@return number  seconds left before the hard cap
function Intro.Left(settings, reserve)
    return Config.Intro.MaxShow + Config.Intro.Hold - reserve - (os.clock() - settings.Started)
end

function Intro.Wait(settings, reserve)
    local minimum = Config.Intro.MinShow + Config.Intro.Hold
    while not Library.Unloaded and not Intro.Skipped and Intro.Left(settings, reserve) > 0 do
        if settings.Ran and os.clock() - settings.Started >= minimum then
            return
        end
        task.wait(0.05)
    end
end

---@param track table?  nil = run without drawing
function Intro.RunSteps(settings, track)
    local steps = settings.Steps or {}
    local fallback = Lang.Strings.IntroSteps
    for index, step in ipairs(steps) do
        if Library.Unloaded then
            return
        end
        if step.Started then
            continue
        end
        step.Started = true
        local labels = fallback[State.Language] or fallback.EN
        Intro.Status(track, step.Label or labels[math.min(index, #labels)])
        if step.Run then
            Util.Await(Config.Intro.StepTimeout, step.Run)
        end
        Intro.Progress(track, index / #steps)
    end
    settings.Ran = true
    Intro.Progress(track, 1)
end

function Intro.Status(track, spec)
    if track and track.Alive then
        track.Status.Text = Lang.Resolve(spec)
    end
end

function Intro.Progress(track, value)
    if not track or not track.Alive then
        return
    end
    Motion.Spring(track.Value, "Value", value, "Soft")
    Motion.Impulse(track.Body, "Position", { 0, 0, 0, -90 }, "Fast", 0.35)
end

---@return number  stage scale that fits the viewport inside the safe area
function Intro.Fit(layer)
    local intro = Config.Intro
    local top, bottom = Popup.Insets(layer)
    local view = layer.AbsoluteSize
    local room = math.min((view.X - intro.Margin * 2) / intro.Width, (view.Y - top - bottom - intro.Margin * 6) / intro.Height)
    return math.clamp(room, 0.5, intro.MaxScale)
end

function Intro.Build(settings)
    local intro = Config.Intro
    local layer = Popup.Layer("Intro")
    local screen = Gui.Hitbox("Loader")
    screen.Size = UDim2.fromScale(1, 1)
    screen.BackgroundTransparency = 1
    screen.Parent = layer
    Theme.Bind(screen, { BackgroundColor3 = "Black" })
    local stage = Draw.New("CanvasGroup", { Name = "Stage", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(intro.Width, intro.Height), BackgroundTransparency = 1, GroupTransparency = 1, Parent = screen })
    local fit = Intro.Fit(layer)
    local parts = { Screen = screen, Stage = stage, Fit = fit, Layer = layer }
    parts.Scale = Draw.New("UIScale", { Scale = fit * 0.9, Parent = stage })
    parts.Block = Intro.Block(stage)
    parts.Coin = Intro.Coin(stage)
    parts.Letters = Intro.Logo(stage, settings.Title or "Mario Hub")
    parts.Sub = Intro.Subtitle(stage, settings.SubTitle)
    parts.Track = Intro.Track(stage)
    parts.Skip = Intro.SkipHint(screen, layer)
    Intro.BindSkip(screen)
    return parts
end

function Intro.SkipHint(screen, layer)
    local _, bottom = Popup.Insets(layer)
    local spec = Platform.Touch and Lang.Strings.IntroSkipTouch or Lang.Strings.IntroSkip
    local hint = Draw.Text({ AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -(bottom + Config.Intro.Margin * 2)), Size = UDim2.fromOffset(240, 18), TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = Config.Z.Top, Parent = screen }, "Desc", Util.TextSize("Small"), "White", spec)
    return hint
end

function Intro.BindSkip(screen)
    Intro.Skipped = false
    Gui.Clickable(screen, { OnClick = function()
        Intro.Skipped = true
    end })
    Intro.KeyConnection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.Gamepad1 then
            Intro.Skipped = true
        end
    end)
end

---@return table  { Holder, Scale, Sprite }  ?-block that pops in, gets hit, then opens into the logo
function Intro.Block(stage)
    local intro = Config.Intro
    local holder = Draw.New("Frame", { Name = "Block", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(intro.Width / 2, intro.BlockY), Size = UDim2.fromOffset(intro.Block, intro.Block), ZIndex = Config.Z.Raised, Parent = stage })
    local scale = Draw.New("UIScale", { Scale = 0, Parent = holder })
    local sprite = Sprite.New(holder, "qblock", intro.Block)
    sprite.ZIndex = Config.Z.Raised
    return { Holder = holder, Scale = scale, Sprite = sprite }
end

function Intro.Coin(stage)
    local intro = Config.Intro
    local coin = Sprite.New(stage, "coin", intro.Coin)
    coin.AnchorPoint = Vector2.new(0.5, 0.5)
    coin.Position = UDim2.fromOffset(intro.Width / 2, intro.BlockY)
    coin.Size = UDim2.fromOffset(intro.Coin, 0)
    coin.ZIndex = Config.Z.Body
    coin.Visible = false
    return coin
end

---@return table[]  { Label, Scale } per glyph; Thai or non-Latin titles become one label
function Intro.Logo(stage, title)
    local intro = Config.Intro
    local text = Lang.Resolve(title):upper()
    local size = intro.Letter
    local row = Draw.New("Frame", { Name = "Logo", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(intro.Width / 2, intro.LogoY), Size = UDim2.fromOffset(intro.Width - 16, size + 16), ZIndex = Config.Z.Raised, Parent = stage })
    Draw.List(row, 1, true, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    local glyphs = text:find("[\128-\255]") and { text } or {}
    if #glyphs == 0 then
        for char in text:gmatch(utf8.charpattern) do
            glyphs[#glyphs + 1] = char
        end
    end
    local width = 0
    for _, glyph in ipairs(glyphs) do
        width += glyph == " " and size * 0.3 or Layout.Measure(glyph, size, "Logo", 1000).X
    end
    local shrink = math.min(1, (intro.Width - 24) / math.max(width, 1))
    local letters, colorIndex = {}, 0
    for index, glyph in ipairs(glyphs) do
        local tint = Config.TitleColors[colorIndex % #Config.TitleColors + 1]
        letters[#letters + 1] = Intro.Letter(row, glyph, index, math.floor(size * shrink), tint)
        colorIndex += glyph == " " and 0 or 1
    end
    return letters
end

function Intro.Letter(row, glyph, order, size, tint)
    local intro = Config.Intro
    local font = #glyph > 1 and "Display" or "Logo"
    local bounds = Layout.Measure(glyph, size, font, 1000)
    local slot = Draw.New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(glyph == " " and size * 0.3 or bounds.X + 4, size + 12), LayoutOrder = order, ZIndex = Config.Z.Raised, Parent = row })
    local holder = Draw.New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, intro.LetterRise), Size = UDim2.fromScale(1, 1), ZIndex = Config.Z.Raised, Parent = slot })
    local scale = Draw.New("UIScale", { Scale = 0.4, Parent = holder })
    local drop = Draw.Text({ Text = glyph, Position = UDim2.fromOffset(0, intro.Drop), Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = Config.Z.Body, Parent = holder }, font, size, "Ink")
    local label = Draw.Text({ Text = glyph, Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = Config.Z.Raised, Parent = holder }, font, size, tint)
    local stroke = Draw.Stroke(label, "Ink", math.max(2, math.floor(size / 14)))
    stroke.Transparency = 1
    return { Holder = holder, Label = label, Scale = scale, Stroke = stroke, Drop = drop }
end

function Intro.Subtitle(stage, subTitle)
    local intro = Config.Intro
    local text = Lang.Resolve(subTitle or "")
    local label = Draw.Text({ Text = text, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(intro.Width / 2, intro.SubY + 8), Size = UDim2.fromOffset(intro.Width - 32, intro.SubSize + 8), TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = 1, ZIndex = Config.Z.Top, Parent = stage }, "Display", intro.SubSize, "White")
    local stroke = Draw.Stroke(label, "Ink", 2)
    stroke.Transparency = 1
    return { Label = label, Stroke = stroke, Empty = text == "" }
end

---Level timeline: bar from start to the flag, a mushroom runs along it as steps finish.
function Intro.Track(stage)
    local intro = Config.Intro
    local inset, length = intro.BarInset, intro.Width - intro.BarInset * 2 - intro.Flag
    local bar = Draw.Box("Frame", { Name = "Bar", Position = UDim2.fromOffset(inset, intro.BarY), Size = UDim2.fromOffset(length, intro.BarHeight), ZIndex = Config.Z.Body, Parent = stage }, "Track", "Ink", UDim.new(0, 4), 2)
    local fill = Draw.Box("Frame", { Size = UDim2.fromScale(0, 1), ZIndex = Config.Z.Detail, Parent = bar }, "Coin", nil, UDim.new(0, 4))
    local flag = Sprite.New(stage, "flag", intro.Flag)
    flag.AnchorPoint, flag.Position, flag.ZIndex = Vector2.new(0.5, 1), UDim2.fromOffset(inset + length + intro.Flag * 0.55, intro.BarY + intro.BarHeight + 2), Config.Z.Raised
    local runner = Draw.New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromOffset(inset, intro.BarY - 1), Size = UDim2.fromOffset(intro.Runner, intro.Runner), ZIndex = Config.Z.Top, Parent = stage })
    local body = Sprite.New(runner, "mushroom", intro.Runner)
    body.ZIndex = Config.Z.Top
    local textY = intro.BarY + intro.BarHeight + 8
    local status = Draw.Text({ Position = UDim2.fromOffset(inset, textY), Size = UDim2.fromOffset(length - 60, intro.StatusSize + 6), TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = Config.Z.Top, Parent = stage }, "Body", intro.StatusSize, "White")
    local percent = Draw.Text({ AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromOffset(inset + length, textY), Size = UDim2.fromOffset(60, intro.StatusSize + 6), TextXAlignment = Enum.TextXAlignment.Right, Text = "0%", ZIndex = Config.Z.Top, Parent = stage }, "Logo", intro.StatusSize + 2, "Coin")
    Draw.Stroke(percent, "Ink", 2)
    local value = Draw.New("NumberValue", { Value = 0 })
    local track = { Status = status, Percent = percent, Flag = flag, Runner = runner, Body = body, Fill = fill, Value = value, Alive = true }
    value.Changed:Connect(function(progress)
        if not track.Alive then
            return
        end
        fill.Size = UDim2.fromScale(progress, 1)
        percent.Text = math.floor(progress * 100 + 0.5) .. "%"
        runner.Position = UDim2.fromOffset(inset + (length - intro.Runner) * progress, intro.BarY - 1)
    end)
    return track
end

function Intro.Show(settings, parts)
    local intro = Config.Intro
    Motion.Spring(parts.Screen, "BackgroundTransparency", intro.Scrim, "Normal")
    Motion.Spring(parts.Stage, "GroupTransparency", 0, "Normal")
    Motion.Spring(parts.Scale, "Scale", parts.Fit, "Normal", Intro.Settle)
    Motion.Spring(parts.Block.Scale, "Scale", 1, "Normal", Intro.PopIn)
    Motion.Spring(parts.Skip, "TextTransparency", 0.35, "Soft")
    task.spawn(Intro.RunSteps, settings, parts.Track)
    task.wait(intro.Bump)
    Intro.HitBlock(parts)
    task.wait(intro.Open - intro.Bump)
    Intro.OpenLogo(parts)
    Intro.Wait(settings, intro.Exit + intro.Flourish)
    if settings.Ran and not Intro.Skipped then
        Intro.ReachFlag(parts)
    end
    Intro.Exit(settings, parts)
end

function Intro.HitBlock(parts)
    local intro = Config.Intro
    local block = parts.Block
    block.Sprite:Destroy()
    block.Sprite = Sprite.New(block.Holder, "used", intro.Block)
    block.Sprite.ZIndex = Config.Z.Raised
    Motion.Impulse(block.Holder, "Position", { 0, 0, 0, -320 }, "Fast", 0.4)
    local coin = parts.Coin
    coin.Visible = true
    Motion.Spring(coin, "Position", UDim2.fromOffset(intro.Width / 2, intro.BlockY - intro.CoinRise), "Normal", Intro.Settle)
    Motion.Set(coin, "Size", UDim2.fromOffset(intro.Coin, intro.Coin))
    Motion.Impulse(coin, "Size", { 0, intro.CoinSpin, 0, 0 }, "Fast", Intro.CoinSpinOptions.Damping)
end

function Intro.OpenLogo(parts)
    local intro = Config.Intro
    local center = UDim2.fromOffset(intro.Width / 2, intro.BlockY)
    Motion.Spring(parts.Block.Scale, "Scale", 0, "Fast")
    Motion.Spring(parts.Coin, "Size", UDim2.fromOffset(0, intro.Coin), "Fast")
    Motion.Spring(parts.Coin, "Position", center - UDim2.fromOffset(0, intro.CoinRise + 12), "Fast")
    Fx.Burst(parts.Stage, center, 10)
    Fx.Stagger(parts.Letters, intro.Stagger, Intro.RevealLetter)
    local sub = parts.Sub
    task.delay(#parts.Letters * intro.Stagger * 0.6, function()
        if not sub.Label.Parent or sub.Empty then
            return
        end
        Motion.Spring(sub.Label, "TextTransparency", 0, "Soft")
        Motion.Spring(sub.Stroke, "Transparency", 0.2, "Soft")
        Motion.Spring(sub.Label, "Position", UDim2.fromOffset(intro.Width / 2, intro.SubY), "Soft", Intro.Settle)
    end)
end

function Intro.RevealLetter(letter)
    if not letter.Holder.Parent then
        return
    end
    Motion.Spring(letter.Label, "TextTransparency", 0, "Fast")
    Motion.Spring(letter.Stroke, "Transparency", 0, "Fast")
    Motion.Spring(letter.Drop, "TextTransparency", 0, "Fast")
    Motion.Spring(letter.Scale, "Scale", 1, "Normal", Intro.LetterPop)
    Motion.Spring(letter.Holder, "Position", UDim2.fromScale(0.5, 0.5), "Normal", Intro.LetterPop)
end

function Intro.ReachFlag(parts)
    local track = parts.Track
    Motion.Impulse(track.Flag, "Position", { 0, 0, 0, -260 }, "Fast", 0.35)
    Fx.Burst(parts.Stage, track.Flag.Position - UDim2.fromOffset(0, Config.Intro.Flag * 0.6), 8)
    for index, letter in ipairs(parts.Letters) do
        task.delay(index * 0.02, Motion.Impulse, letter.Holder, "Position", { 0, 0, 0, -160 }, "Fast", 0.4)
    end
    task.wait(Config.Intro.Flourish)
end

---Iris opens from the stage centre while the stage zooms past the camera; the window shows underneath.
function Intro.Exit(settings, parts)
    local intro = Config.Intro
    local view = parts.Layer.AbsoluteSize
    local reach = math.ceil(view.Magnitude) + 8
    local iris = Draw.New("Frame", { Name = "Iris", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1, Parent = parts.Screen })
    Draw.Corner(iris, UDim.new(1, 0))
    local ring = Draw.New("UIStroke", { Thickness = reach, Color = Theme.Color("Black"), Transparency = parts.Screen.BackgroundTransparency, Parent = iris })
    Motion.Set(parts.Screen, "BackgroundTransparency", 1)
    Intro.Finish(settings)
    Motion.Spring(iris, "Size", UDim2.fromOffset(reach * 2, reach * 2), "Normal")
    Motion.Spring(ring, "Transparency", 1, "Soft")
    Motion.Spring(parts.Scale, "Scale", parts.Fit * 1.35, "Normal")
    Motion.Spring(parts.Stage, "GroupTransparency", 1, "Fast")
    Motion.Spring(parts.Skip, "TextTransparency", 1, "Fast")
    task.wait(intro.Exit)
end

function Intro.Teardown(parts)
    parts.Track.Alive = false
    if Intro.KeyConnection then
        Intro.KeyConnection:Disconnect()
        Intro.KeyConnection = nil
    end
    Motion.Cancel(parts.Track.Value)
    parts.Track.Value:Destroy()
    for _, inst in ipairs(parts.Screen:GetDescendants()) do
        Motion.Cancel(inst)
    end
    Motion.Cancel(parts.Screen)
    parts.Screen:Destroy()
end

function KeyGate.ReadSaved()
    if not Util.FileApi() or Util.SafeFile(isfile, Config.KeyCache) ~= true then
        return nil
    end
    local raw = Util.SafeFile(readfile, Config.KeyCache)
    local key = type(raw) == "string" and raw:gsub("%s", "") or ""
    return key ~= "" and key or nil
end

---@return boolean valid, string? message
function KeyGate.Verify(settings, key)
    local ok, valid, message = pcall(settings.Verify, key)
    if not ok then
        return false, tostring(valid)
    end
    return valid == true, message
end

---Key prompt in front of the menu; onUnlocked runs once a key passes (or a saved key still passes).
---@param settings table  { Title, Note, Link, Verify(key) -> valid, message, SaveKey = true }
function KeyGate.Show(settings, onUnlocked)
    local saved = settings.SaveKey ~= false and KeyGate.ReadSaved()
    if saved and KeyGate.Verify(settings, saved) then
        onUnlocked()
        return
    end
    local overlay = Config.Overlay
    local layer = Popup.Layer("Dialog")
    local dim = Popup.Dim(layer, function() end)
    Popup.ShowDim(dim, true)
    local width = math.min(Platform.Mode == "Phone" and 300 or 360, layer.AbsoluteSize.X - overlay.Margin * 2)
    local card, face = Popup.Card(layer, "CanvasGroup")
    card.AnchorPoint, card.Position, card.ZIndex = Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5), 3
    card.Size = UDim2.fromOffset(width + overlay.Shadow + Popup.Edge(), 200)
    local header = KeyGate.BuildHeader(face, settings)
    local host = Draw.New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, header), Size = UDim2.new(1, 0, 1, -header), Parent = face })
    local body = Container.New(host, { PadX = 16, PadY = 12, OnHeight = function(height)
        card.Size = UDim2.fromOffset(width + overlay.Shadow + Popup.Edge(), header + height + overlay.Shadow + overlay.Stroke + Popup.Edge())
    end })
    body:SetWidth(width - overlay.Stroke)
    local gate = { Card = card, Dim = dim, Settings = settings, OnUnlocked = onUnlocked }
    KeyGate.BuildBody(body, gate)
    Layout.Flush()
    card.Visible = false
    Motion.Presence(card, true, Dialog.Presence)
end

---@return number  header height
function KeyGate.BuildHeader(face, settings)
    local height = 58
    local bar = Draw.Box("Frame", { Size = UDim2.new(1, 0, 0, height), Parent = face }, "Accent")
    Draw.Box("Frame", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 3), Parent = bar }, "Outline")
    local key = Sprite.New(bar, "key", 36)
    key.Position = UDim2.fromOffset(14, 10)
    local title = Draw.Text({ Position = UDim2.fromOffset(60, 0), Size = UDim2.new(1, -70, 1, -3), Parent = bar }, "Display", 24, "White", settings.Title or Lang.Strings.KeyTitle)
    Draw.Stroke(title, "Ink", 2)
    return height
end

---@return TextBox
function KeyGate.Field(body)
    local field = Draw.Box("Frame", { Name = "Field" }, "Element", "Outline", Platform.Metric("Radius"), 2)
    local box = Draw.Text({ ClassName = "TextBox", ClearTextOnFocus = false, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), Parent = field }, "Body", Util.TextSize("Label"), "Text")
    Lang.Bind(box, Lang.Strings.KeyPlaceholder, "PlaceholderText")
    Theme.Bind(box, { PlaceholderColor3 = "Muted" })
    body:Add(field, { Height = Platform.Metric("Box") })
    return box
end

function KeyGate.BuildBody(body, gate)
    local settings = gate.Settings
    Gui.Text(body, settings.Note or Lang.Strings.KeyNote, { Kind = "Desc" })
    gate.Box = KeyGate.Field(body)
    Gui.Button(body, { Text = Lang.Strings.GetKey, Style = "Warning", Width = 0.5, Callback = function()
        KeyGate.CopyLink(gate)
    end })
    body:SameLine()
    Gui.Button(body, { Text = Lang.Strings.CheckKey, Style = "Success", Width = 0.5, Callback = function()
        KeyGate.Check(gate)
    end })
    gate.Status = Gui.Text(body, "", { Kind = "Desc", Token = "SubText" })
end

function KeyGate.CopyLink(gate)
    local link = gate.Settings.Link
    if type(link) == "function" then
        local ok, value = pcall(link)
        link = ok and value or nil
    end
    if link and Util.Clipboard(tostring(link)) then
        gate.Status:Set(Lang.Strings.KeyCopied)
        return
    end
    gate.Status:Set(tostring(link or "-"))
end

function KeyGate.Check(gate)
    if gate.Checking then
        return
    end
    gate.Checking = true
    gate.Status:Set(Lang.Strings.KeyChecking)
    local key = gate.Box.Text:gsub("%s", "")
    task.spawn(function()
        local valid, message = KeyGate.Verify(gate.Settings, key)
        gate.Status:Set(message or Lang.Strings[valid and "KeyValid" or "KeyInvalid"])
        if not valid then
            gate.Checking = false
            Motion.Shake(gate.Card)
            return
        end
        if gate.Settings.SaveKey ~= false and Util.FileApi() then
            Util.EnsureFolder(Config.Root)
            Util.SafeFile(writefile, Config.KeyCache, key)
        end
        KeyGate.Pass(gate)
    end)
end

function KeyGate.Pass(gate)
    Popup.ShowDim(gate.Dim, false)
    Motion.Presence(gate.Card, false, Dialog.Presence)
    task.delay(Config.Intro.Exit, function()
        Motion.Forget(gate.Card)
        gate.Card:Destroy()
        gate.Dim:Destroy()
        if not Library.Unloaded then
            Util.Try(gate.OnUnlocked)
        end
    end)
end

---@author xDTaraZ  Mario Hub UI V2
Config.Decor = {
    Tick = 0.5, MinWidth = 420, MinHeight = 80, DriftEvery = 8, Drift = 18, DriftSpeed = 1.1,
    TwinkleSpeed = 3, TwinkleAlpha = 0.85, StarAlpha = 0.2, Twinkles = 2,
    Parallax = { Pad = 48, Far = 0.45, Speed = "Soft", Spring = { Damping = 0.85 } },
    Scenes = {
        Overworld = { Clouds = true, Hills = true },
        Light = { Clouds = true, Hills = true },
        Dark = { Stars = true },
        Underground = { Ceiling = true, Stars = true },
        Castle = { Torches = true, Lava = true },
        ["Star Road"] = { Stars = true, Shooting = true },
    },
    Clouds = { { 0.46, 50, 44, "Near" }, { 0.62, 58, 30, "Far" }, { 0.78, 48, 38, "Near" }, { 0.92, 60, 26, "Far" } },
    Hills = { { 0.5, 96, 20, "Far" }, { 0.66, 120, 28, "Near" }, { 0.86, 90, 16, "Far" } },
    HillEye = Vector2.new(3, 7), HillEyeGap = 6, HillAlpha = 0.3,
    Stars = { { 0.44, 50, 12 }, { 0.5, 72, 9 }, { 0.57, 56, 14 }, { 0.64, 80, 10 }, { 0.7, 48, 11 }, { 0.77, 70, 8 }, { 0.84, 54, 12 }, { 0.92, 76, 9 } },
    Torches = { 0.5, 0.86 }, TorchY = 0.68, Torch = Vector2.new(6, 14), Flame = Vector2.new(10, 14), Flicker = 60,
    Ceiling = 10, CeilingAlpha = 0.35, CeilingColumns = 24,
    Shooting = { Every = 28, Size = 14, Speed = 2.2, Travel = 0.3 },
    Lava = { Height = 90, Alpha = 0.55, Pulse = 0.2, Every = 6, Speed = 1.5 },
    Walker = { Size = 14, Every = 12, Speed = 0.8, Hop = 120, HopDamping = 0.45, Margin = 0.06, Art = "mushroom", MinWidth = 360 },
    Burst = { Count = 5, Reach = 22, Glyph = "✦", Size = { 9, 13 }, Fade = "Soft" },
    Bump = { Velocity = 260, Damping = 0.4 },
    Lift = 3,
}
Config.Particles.Spawn = 0.8
Config.Particles.Size = { 9, 16 }
Config.Particles.Settle = 6.6
Config.Particles.PhoneCount = 6
Config.Particles.Themes = {
    Underground = { Glyph = "•", Fall = true },
    Castle = { Glyph = "•", Fall = false },
}

Decor.Handles = {}
Decor.Backdrops = {}
Decor.Walkers = {}
Decor.Ticks = 0
Decor.TwinkleBack = { OnDone = function(star)
    Motion.Spring(star, "TextTransparency", Config.Decor.StarAlpha, Config.Decor.TwinkleSpeed)
end }

---@return boolean  menu is on screen (decor and particles only animate then)
function Decor.WindowShown()
    local window = State.Window or Library.Window
    return window ~= nil and window.Visible ~= false and not window.Minimized
end

---@return table  scene flags for the active theme
function Decor.Scene()
    return Config.Decor.Scenes[State.ThemeName] or Config.Decor.Scenes.Overworld
end

function Decor.EnsureTicking()
    if Decor.Ticking then
        return
    end
    Decor.Ticking = true
    Util.Every(Config.Decor.Tick, Decor.Step)
end

---Parallax sky inside host (the header banner): far and near planes, per-theme pieces.
---Pieces sit below the header control row, so nothing ever covers a button.
---@return table  handle for Decor.Shift
function Decor.Attach(host)
    local pad = Config.Decor.Parallax.Pad
    local handle = { Host = host, Clouds = {}, Stars = {}, Hills = {}, Torches = {} }
    handle.Far = Draw.New("Frame", { Name = "Far", BackgroundTransparency = 1, Size = UDim2.new(1, pad * 2, 1, 0), ZIndex = Config.Chrome.Z.SkyFar, Parent = host })
    handle.Near = Draw.New("Frame", { Name = "Near", BackgroundTransparency = 1, Size = UDim2.new(1, pad * 2, 1, 0), ZIndex = Config.Chrome.Z.SkyNear, Parent = host })
    Decor.BuildHills(handle)
    Decor.BuildClouds(handle)
    Decor.BuildStars(handle)
    Decor.BuildTorches(handle)
    Decor.BuildCeiling(handle)
    Decor.BuildShooting(handle)
    Decor.Handles[#Decor.Handles + 1] = handle
    Util.Connect(host:GetPropertyChangedSignal("AbsoluteSize"), function()
        Decor.Render(handle)
    end)
    Theme.OnRender(handle.Far, function()
        Decor.Render(handle)
    end)
    Decor.EnsureTicking()
    return handle
end

---V1 name.
function Decor.Build(host)
    return Decor.Attach(host)
end

function Decor.Plane(handle, name)
    return name == "Far" and handle.Far or handle.Near
end

function Decor.BuildClouds(handle)
    for _, spot in ipairs(Config.Decor.Clouds) do
        local cloud = Draw.Cloud(Decor.Plane(handle, spot[4]), spot[3])
        cloud.Position = UDim2.new(spot[1], 0, 0, spot[2])
        handle.Clouds[#handle.Clouds + 1] = { Frame = cloud, Home = cloud.Position, Out = false }
    end
end

function Decor.BuildHills(handle)
    local decor = Config.Decor
    for _, spot in ipairs(decor.Hills) do
        local far = spot[4] == "Far"
        local diameter = spot[2]
        local hill = Draw.Box("Frame", {
            Name = "Hill",
            Position = UDim2.new(spot[1], -diameter / 2, 1, -spot[3]),
            Size = UDim2.fromOffset(diameter, diameter),
            BackgroundTransparency = far and decor.HillAlpha or 0,
            Parent = Decor.Plane(handle, spot[4]),
        }, far and "GrassDark" or "Grass", not far and "GrassDark" or nil, UDim.new(1, 0), 2)
        if not far then
            for side = -1, 1, 2 do
                Draw.Box("Frame", {
                    AnchorPoint = Vector2.new(0.5, 0),
                    Position = UDim2.new(0.5, side * decor.HillEyeGap / 2, 0, decor.HillEye.Y),
                    Size = UDim2.fromOffset(decor.HillEye.X, decor.HillEye.Y),
                    Parent = hill,
                }, "Outline", nil, UDim.new(1, 0))
            end
        end
        handle.Hills[#handle.Hills + 1] = hill
    end
end

function Decor.BuildStars(handle)
    local decor = Config.Decor
    for _, spot in ipairs(decor.Stars) do
        handle.Stars[#handle.Stars + 1] = Draw.Text({
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(spot[1], 0, 0, spot[2]),
            Size = UDim2.fromOffset(spot[3] + 4, spot[3] + 4),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextTransparency = decor.StarAlpha,
            Parent = handle.Far,
        }, "Glyph", spot[3], "DecorColor")
    end
end

function Decor.BuildTorches(handle)
    local decor = Config.Decor
    for _, x in ipairs(decor.Torches) do
        local torch = Draw.New("Frame", { Name = "Torch", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(x, decor.TorchY), Size = UDim2.fromOffset(decor.Flame.X, decor.Flame.Y + decor.Torch.Y), Parent = handle.Near })
        Draw.Box("Frame", { AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromOffset(decor.Torch.X, decor.Torch.Y), Parent = torch }, "BrickDark", "Outline", 2, 1)
        local flame = Draw.Box("Frame", { Name = "Flame", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -decor.Torch.Y + 2), Size = UDim2.fromOffset(decor.Flame.X, decor.Flame.Y), Parent = torch }, "Accent", nil, UDim.new(0.5, 0))
        Draw.Box("Frame", { AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.5, 0.6), Parent = flame }, "Glow", nil, UDim.new(0.5, 0))
        handle.Torches[#handle.Torches + 1] = { Frame = torch, Flame = flame }
    end
end

function Decor.BuildCeiling(handle)
    local decor = Config.Decor
    local strip = Draw.Box("Frame", { Name = "Ceiling", Size = UDim2.new(1, 0, 0, decor.Ceiling), BackgroundTransparency = decor.CeilingAlpha, Parent = handle.Far }, "Brick")
    local mortar = Draw.New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = strip })
    Draw.Bricks(mortar, decor.CeilingColumns, "BrickDark")
    handle.Ceiling = strip
end

function Decor.BuildShooting(handle)
    local size = Config.Decor.Shooting.Size
    handle.Shooting = Draw.Text({ Name = "Shooting", Text = "★", AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(size + 4, size + 4), TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, Visible = false, Parent = handle.Far }, "Glyph", size, "Coin")
end

function Decor.Render(handle)
    local host = handle.Host.AbsoluteSize
    local roomy = host.X >= Config.Decor.MinWidth and host.Y >= Config.Decor.MinHeight
    local scene = Decor.Scene()
    for _, cloud in ipairs(handle.Clouds) do
        cloud.Frame.Visible = roomy and scene.Clouds == true
    end
    for _, hill in ipairs(handle.Hills) do
        hill.Visible = roomy and scene.Hills == true
    end
    for _, star in ipairs(handle.Stars) do
        star.Text = Theme.Colors.DecorGlyph or "✦"
        star.Visible = roomy and scene.Stars == true
    end
    for _, torch in ipairs(handle.Torches) do
        torch.Frame.Visible = roomy and scene.Torches == true
    end
    handle.Ceiling.Visible = scene.Ceiling == true
    handle.Shooting.Visible = roomy and scene.Shooting == true
end

---Parallax shift on tab change; ratio 0..1 is the tab's place in the dock.
function Decor.Shift(handle, ratio)
    if not handle then
        return
    end
    local parallax = Config.Decor.Parallax
    local near = -parallax.Pad * 2 * math.clamp(ratio, 0, 1)
    Motion.Spring(handle.Near, "Position", UDim2.fromOffset(near, 0), parallax.Speed, parallax.Spring)
    Motion.Spring(handle.Far, "Position", UDim2.fromOffset(near * parallax.Far, 0), parallax.Speed, parallax.Spring)
end

---Castle lava glow along the bottom of host (the ambient layer behind the pages).
function Decor.AttachBackdrop(host)
    local lava = Config.Decor.Lava
    local glow = Draw.Box("Frame", { Name = "Lava", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, lava.Height), BackgroundTransparency = 0, Parent = host }, "Accent")
    Draw.New("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, lava.Alpha) }),
        Parent = glow,
    })
    local handle = { Glow = glow, Out = false }
    Theme.OnRender(glow, function()
        glow.Visible = Decor.Scene().Lava == true
    end)
    Decor.Backdrops[#Decor.Backdrops + 1] = handle
    Decor.EnsureTicking()
    return handle
end

---Little mushroom wandering across host (the ground strip).
function Decor.AttachGround(host)
    local walker = Config.Decor.Walker
    local frame = Draw.New("Frame", { Name = "Walker", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.3, 0, 1, -2), Size = UDim2.fromOffset(walker.Size, walker.Size), ZIndex = Config.Chrome.Z.Walker, Parent = host })
    local hop = Draw.New("Frame", { Name = "Hop", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = frame })
    Sprite.New(hop, walker.Art, walker.Size)
    local handle = { Host = host, Frame = frame, Hop = hop }
    Decor.Walkers[#Decor.Walkers + 1] = handle
    Decor.EnsureTicking()
    return handle
end

function Decor.Step()
    if Motion.Reduced then
        return
    end
    if not Decor.WindowShown() then
        if not Decor.Resting then
            Decor.Resting = true
            Decor.Rest()
        end
        return
    end
    Decor.Resting = false
    Decor.Ticks += 1
    local ticks = Decor.Ticks
    for index = #Decor.Handles, 1, -1 do
        local handle = Decor.Handles[index]
        if not handle.Host.Parent then
            table.remove(Decor.Handles, index)
            continue
        end
        Decor.Animate(handle, ticks)
    end
    for _, backdrop in ipairs(Decor.Backdrops) do
        Decor.Pulse(backdrop, ticks)
    end
    for _, walker in ipairs(Decor.Walkers) do
        Decor.Walk(walker, ticks)
    end
end

---@return boolean  inst belongs to a sky, lava or walker scene
function Decor.Owns(inst)
    for _, handle in ipairs(Decor.Handles) do
        if inst:IsDescendantOf(handle.Host) then
            return true
        end
    end
    for _, backdrop in ipairs(Decor.Backdrops) do
        if inst == backdrop.Glow then
            return true
        end
    end
    for _, walker in ipairs(Decor.Walkers) do
        if inst:IsDescendantOf(walker.Host) then
            return true
        end
    end
    return false
end

---Snaps scene springs to their goals once the menu is hidden, so the frame loop goes idle instead of drifting clouds nobody sees.
function Decor.Rest()
    local springs = Motion.Springs
    for index = #springs, 1, -1 do
        local spring = springs[index]
        if spring and Decor.Owns(spring.Inst) then
            spring.Inst[spring.Prop] = Motion.Unpack(spring.Kind, spring.Goal)
            Motion.Remove(spring, false)
        end
    end
    if #springs == 0 then
        Motion.Stop()
    end
end

function Decor.Animate(handle, ticks)
    local decor = Config.Decor
    local stars = handle.Stars
    if stars[1] and stars[1].Visible then
        for _ = 1, decor.Twinkles do
            Motion.Spring(stars[math.random(#stars)], "TextTransparency", decor.TwinkleAlpha, decor.TwinkleSpeed, Decor.TwinkleBack)
        end
    end
    for _, torch in ipairs(handle.Torches) do
        if torch.Frame.Visible then
            Motion.Impulse(torch.Flame, "Size", { 0, 0, 0, math.random(-decor.Flicker, decor.Flicker) }, "Fast", 0.3)
        end
    end
    if handle.Shooting.Visible and ticks % decor.Shooting.Every == 0 then
        Decor.Shoot(handle.Shooting)
    end
    if ticks % decor.DriftEvery ~= 0 then
        return
    end
    for _, cloud in ipairs(handle.Clouds) do
        if cloud.Frame.Visible then
            cloud.Out = not cloud.Out
            Motion.Spring(cloud.Frame, "Position", cloud.Home + UDim2.fromOffset(cloud.Out and decor.Drift or 0, 0), decor.DriftSpeed)
        end
    end
end

function Decor.Shoot(star)
    local shooting = Config.Decor.Shooting
    local x = 0.55 + math.random() * 0.35
    Motion.Set(star, "Position", UDim2.fromScale(x, 0.1))
    Motion.Set(star, "TextTransparency", 0)
    Motion.Spring(star, "Position", UDim2.fromScale(x - shooting.Travel, 0.9), shooting.Speed)
    Motion.Spring(star, "TextTransparency", 1, shooting.Speed)
end

function Decor.Pulse(backdrop, ticks)
    local lava = Config.Decor.Lava
    if not backdrop.Glow.Visible or ticks % lava.Every ~= 0 then
        return
    end
    backdrop.Out = not backdrop.Out
    Motion.Spring(backdrop.Glow, "BackgroundTransparency", backdrop.Out and lava.Pulse or 0, lava.Speed)
end

function Decor.Walk(walker, ticks)
    local settings = Config.Decor.Walker
    local wide = walker.Host.AbsoluteSize.X >= settings.MinWidth
    walker.Frame.Visible = wide
    if not wide then
        return
    end
    if ticks % settings.Every == 0 then
        local x = settings.Margin + math.random() * (1 - settings.Margin * 2)
        Motion.Spring(walker.Frame, "Position", UDim2.new(x, 0, 1, -2), settings.Speed)
    end
    if Motion.Get(walker.Frame, "Position") then
        Motion.Impulse(walker.Hop, "Position", { 0, 0, 0, -settings.Hop }, "Fast", settings.HopDamping)
    end
end

Particles.Live = {}
Particles.LiveCount = 0
Particles.Paused = false

function Particles.Make()
    return Draw.Text({ Name = "Particle", AnchorPoint = Vector2.new(0.5, 0.5), TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1 }, "Glyph", 12, "ParticleColor")
end

function Particles.Released(label)
    if not Particles.Live[label] then
        return
    end
    Particles.Live[label] = nil
    Particles.LiveCount -= 1
    Draw.Pool("Particle", Particles.Make).Release(label)
end

Particles.DoneOptions = { OnDone = Particles.Released }

---Ambient sparkles on the layer behind the pages. Spawns only while the window is shown.
function Particles.Build(parent)
    if Particles.Layer and Particles.Layer.Parent then
        Particles.Layer.Parent = parent
        return Particles.Layer
    end
    Particles.Layer = Draw.New("Frame", { Name = "Particles", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, ZIndex = Config.Chrome.Z.Particles, Visible = Particles.Enabled, Parent = parent })
    if not Particles.Ticking then
        Particles.Ticking = true
        Util.Every(Config.Particles.Spawn, Particles.Step)
    end
    return Particles.Layer
end

---@return boolean
function Particles.Active()
    local layer = Particles.Layer
    return Particles.Enabled and not Particles.Paused and not Motion.Reduced and layer ~= nil and layer.Parent ~= nil and Decor.WindowShown()
end

function Particles.Limit()
    return Platform.Mode == "Phone" and Config.Particles.PhoneCount or Config.Particles.Count
end

function Particles.Step()
    if not Particles.Active() then
        if Particles.LiveCount > 0 then
            Particles.Clear()
        end
        return
    end
    if Particles.LiveCount < Particles.Limit() then
        Particles.Launch()
    end
end

---@return string glyph, boolean falls
function Particles.Style()
    local override = Config.Particles.Themes[State.ThemeName]
    if override then
        return override.Glyph, override.Fall
    end
    return Theme.Colors.ParticleGlyph or "✦", Theme.Colors.ParticleFall == true
end

function Particles.Launch()
    local settings = Config.Particles
    local label = Draw.Pool("Particle", Particles.Make).Acquire()
    local glyph, fall = Particles.Style()
    local size = math.random(settings.Size[1], settings.Size[2])
    local x = math.random()
    local duration = settings.MinTime + math.random() * (settings.MaxTime - settings.MinTime)
    local speed = settings.Settle / duration
    label.Text = glyph
    label.TextSize = size
    label.Size = UDim2.fromOffset(size + 4, size + 4)
    label.Rotation = 0
    label.TextTransparency = 0.35 + math.random() * 0.4
    label.Position = UDim2.new(x, 0, fall and -0.06 or 1.06, 0)
    label.Parent = Particles.Layer
    Particles.Live[label] = true
    Particles.LiveCount += 1
    Motion.Spring(label, "Position", UDim2.new(x + (math.random() - 0.5) * 0.15, 0, fall and 1.08 or -0.08, 0), speed, Particles.DoneOptions)
    Motion.Spring(label, "Rotation", fall and 0 or math.random(-120, 120), speed)
    Motion.Spring(label, "TextTransparency", 1, speed * 0.8)
end

function Particles.Clear()
    for label in pairs(Particles.Live) do
        Particles.Released(label)
    end
end

function Particles.Pause()
    Particles.Paused = true
    Particles.Clear()
end

function Particles.Resume()
    Particles.Paused = false
end

function Particles.SetEnabled(enabled)
    Particles.Enabled = enabled ~= false
    if Particles.Layer then
        Particles.Layer.Visible = Particles.Enabled
    end
    if not Particles.Enabled then
        Particles.Clear()
    end
end

Library.Visuals = { Enabled = false, Preview = false }

---V1 targets `{ Model, Name, Color? }` or Players/Models; nil = every player.
function Library.Visuals.Source()
    local provider = Library.Visuals.Provider
    if not provider then
        return Kit.Esp.PlayerSource()
    end
    local ok, targets = pcall(provider)
    if not ok or type(targets) ~= "table" then
        return {}
    end
    local models = table.create(#targets)
    for _, target in ipairs(targets) do
        local model = type(target) == "table" and target.Model or target
        if typeof(model) == "Instance" then
            models[#models + 1] = model
        end
    end
    return models
end

function Library.Visuals.Category()
    if not Kit.Esp.Categories.Visuals then
        Kit.Esp.AddCategory("Visuals", { Text = Library:T("Targets", "เป้าหมาย"), Color = Color3.fromRGB(240, 92, 80), Source = Library.Visuals.Source, Enabled = true })
    end
    return Kit.Esp.Categories.Visuals
end

function Library.Visuals:SetEnabled(enabled)
    self.Enabled = enabled == true
    self.Category()
    if self.Enabled then Kit.Esp.Start() else Kit.Esp.Stop() end
end

function Library.Visuals:SetPreview(enabled)
    self.Preview = enabled == true
    local option = Library.Options.MarioEspPreview
    if option and option.Value ~= self.Preview then
        option:SetValue(self.Preview)
    end
    Library.Visuals.Sync()
end

---@param provider function?  returns V1 targets; nil = every player
function Library.Visuals:SetProvider(provider)
    self.Provider = provider
    self.Category()
end

function Library.Visuals:Set(key, value)
    Kit.Esp.Set(key, value)
end

function Library.Visuals:Get(key)
    return Kit.Esp.Settings[key]
end

Config.Layer.Preview = Config.Layer.Window + 1
Config.Preview = {
    Width = 230, MinHeight = 260, Gap = 8, Margin = 8, Slide = 24, Pad = 10, Title = 30, Radius = 8,
    InlineHeight = 240, Tick = 1 / 30, Spin = 0.6, Fov = 40, Fit = 1.3, Tint = 0.45, Distance = 24,
    Ambient = Color3.fromRGB(170, 170, 185), Light = Vector3.new(-1, -1, 1), Font = Enum.Font.GothamBold, Stroke = 0.4,
    Fallback = Color3.fromRGB(240, 92, 80),
}
Library.Visuals.Panel = {}

---@return Frame  title + viewport + overlay; Mount() moves it between the side card and the phone group
function Library.Visuals.BuildView()
    local settings = Config.Preview
    local holder = Draw.New("Frame", { Name = "EspPreview", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
    Draw.Text({ Name = "Title", Position = UDim2.fromOffset(settings.Pad, 2), Size = UDim2.new(1, -settings.Pad * 2, 0, settings.Title - 2), Parent = holder }, "Display", Util.TextSize("Group"), "Text", Library:T("ESP Preview", "ตัวอย่าง ESP"))
    local view = Draw.Box("ViewportFrame", {
        Name = "View",
        Position = UDim2.fromOffset(settings.Pad, settings.Title),
        Size = UDim2.new(1, -settings.Pad * 2, 1, -settings.Title - settings.Pad),
        BackgroundTransparency = 0,
        Ambient = settings.Ambient,
        LightColor = Color3.new(1, 1, 1),
        LightDirection = settings.Light,
        Parent = holder,
    }, "Element", "Outline", settings.Radius, 2)
    local camera = Draw.New("Camera", { FieldOfView = settings.Fov, Parent = view })
    view.CurrentCamera = camera
    local overlay = Draw.New("Frame", { Name = "Overlay", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, ZIndex = 2, Parent = view })
    local box = Draw.New("Frame", { Name = "Box", BackgroundTransparency = 1, Visible = false, Parent = overlay })
    local panel = Library.Visuals.Panel
    panel.Holder, panel.View, panel.Camera, panel.Overlay = holder, view, camera, overlay
    panel.Box, panel.BoxStroke = box, Draw.New("UIStroke", { Thickness = 1, Parent = box })
    panel.Tracer = Draw.New("Frame", { Name = "Tracer", AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, Visible = false, Parent = overlay })
    panel.Label = Draw.New("TextLabel", {
        Name = "Label", AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, Size = UDim2.fromOffset(200, 18),
        Font = settings.Font, TextStrokeTransparency = settings.Stroke, Visible = false, Parent = overlay,
    })
    Util.Connect(view:GetPropertyChangedSignal("AbsoluteSize"), Library.Visuals.Render)
    return holder
end

---@return Model?  own character clone, or a plain R15 dummy when there is none
function Library.Visuals.NewRig()
    local char = LocalPlayer.Character
    if char then
        local archivable = char.Archivable
        char.Archivable = true
        local ok, clone = pcall(char.Clone, char)
        char.Archivable = archivable
        if ok and clone then
            return clone
        end
    end
    local ok, rig = pcall(Players.CreateHumanoidModelFromDescription, Players, Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15)
    return ok and rig or nil
end

---Strips everything live from the rig and keeps each part's own color for the chams tint.
function Library.Visuals.Strip(rig, colors)
    for _, part in ipairs(rig:GetDescendants()) do
        if part:IsA("LuaSourceContainer") or part:IsA("Sound") or part:IsA("ForceField") or part:IsA("BillboardGui") or part:IsA("Highlight") then
            part:Destroy()
        elseif part:IsA("BasePart") then
            part.Anchored, part.CanCollide = true, false
            if part.Transparency < 1 then
                colors[part] = part.Color
            end
        elseif part:IsA("Humanoid") then
            part.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            part.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        end
    end
end

---Built once on first show; centers the rig on the origin and points the camera at its face.
function Library.Visuals.EnsureModel()
    local panel = Library.Visuals.Panel
    if panel.Model and panel.Model.Parent then return panel.Model end
    local rig = Library.Visuals.NewRig()
    if not rig then return nil end
    panel.Colors, panel.Tinted = {}, nil
    Library.Visuals.Strip(rig, panel.Colors)
    rig:PivotTo(CFrame.new())
    local center, size = rig:GetBoundingBox()
    panel.Base, panel.Angle = CFrame.new(-center.Position), 0
    rig:PivotTo(panel.Base)
    local anchor = rig:FindFirstChild("HumanoidRootPart") or rig.PrimaryPart
    panel.Anchor = anchor and anchor.Position or Vector3.zero
    panel.Extents = Vector2.new(math.max(size.X, 1), math.max(size.Y, Kit.Config.Esp.MinHeight))
    panel.Humanoid = rig:FindFirstChildOfClass("Humanoid")
    rig.Parent = panel.View
    panel.Model = rig
    return rig
end

---@return Vector2  pixel point inside the viewport frame, number  depth
function Library.Visuals.Project(position, size)
    local camera = Library.Visuals.Panel.Camera
    local relative = camera.CFrame:PointToObjectSpace(position)
    local depth = math.max(-relative.Z, 0.01)
    local half = math.tan(math.rad(camera.FieldOfView) / 2)
    local x = (0.5 + relative.X / depth / (2 * half * size.X / size.Y)) * size.X
    local y = (0.5 - relative.Y / depth / (2 * half)) * size.Y
    return Vector2.new(x, y), depth
end

---@return Color3  what Kit.Esp would paint: team color, first enabled category, else the first one
function Library.Visuals.Color()
    if Kit.Esp.Settings.TeamColor and LocalPlayer.Team then
        return LocalPlayer.TeamColor.Color
    end
    local first
    for _, name in ipairs(Kit.Esp.Order) do
        local category = Kit.Esp.Categories[name]
        first = first or category
        if category.Enabled then return category.Color end
    end
    return first and first.Color or Config.Preview.Fallback
end

function Library.Visuals.Tint(color)
    local panel = Library.Visuals.Panel
    if panel.Tinted == color then return end
    panel.Tinted = color
    for part, base in pairs(panel.Colors) do
        part.Color = color and base:Lerp(color, Config.Preview.Tint) or base
    end
end

---Same caption, box, tracer and chams Kit.Esp draws, from its live Settings.
function Library.Visuals.Render()
    local panel = Library.Visuals.Panel
    if not panel.Shown or not panel.Model then return end
    local size = panel.View.AbsoluteSize
    if size.X <= 0 or size.Y <= 0 then return end
    Library.Visuals.Frame(size)
    local tuning, show = Kit.Esp.Settings, Kit.Esp.Settings.Show or {}
    local drawing = (Kit.Esp.Mode or (Kit.Caps.Drawing and "Drawing" or "Gui")) == "Drawing"
    local color = Library.Visuals.Color()
    local point, depth = Library.Visuals.Project(panel.Anchor, size)
    local focal = size.Y / (2 * math.tan(math.rad(panel.Camera.FieldOfView) / 2))
    local width, height = panel.Extents.X * focal / depth, panel.Extents.Y * focal / depth
    local top = point.Y - height / 2
    panel.Box.Visible = drawing and show.Box == true
    panel.Box.Position, panel.Box.Size = UDim2.fromOffset(point.X - width / 2, top), UDim2.fromOffset(width, height)
    panel.BoxStroke.Color = color
    Library.Visuals.Tint(not drawing and show.Box == true and color or nil)
    local caption = Kit.Esp.Caption({ Category = {}, Model = panel.Model, Player = LocalPlayer, Humanoid = panel.Humanoid }, Config.Preview.Distance)
    local label = panel.Label
    label.Text, label.TextColor3, label.TextSize, label.Visible = caption, color, tuning.TextSize, caption ~= ""
    if drawing then
        label.Position = UDim2.fromOffset(point.X, top - 2)
    else
        local above = Library.Visuals.Project(panel.Anchor + Vector3.new(0, Kit.Config.Esp.LabelOffset, 0), size)
        label.Position = UDim2.fromOffset(above.X, above.Y + label.Size.Y.Offset / 2)
    end
    Library.Visuals.Line(drawing and show.Tracer == true, Vector2.new(size.X / 2, size.Y), Vector2.new(point.X, top + height), color)
end

---Backs the camera off until the whole rig fits both the height and the (often narrow) width.
function Library.Visuals.Frame(size)
    local panel = Library.Visuals.Panel
    local half = math.tan(math.rad(Config.Preview.Fov) / 2)
    local fitY = panel.Extents.Y / 2 / half
    local fitX = panel.Extents.X / 2 / (half * size.X / size.Y)
    local distance = math.max(fitX, fitY) * Config.Preview.Fit
    panel.Camera.CFrame = CFrame.lookAt(Vector3.new(0, 0, -distance), Vector3.zero)
end

function Library.Visuals.Line(shown, from, to, color)
    local tracer = Library.Visuals.Panel.Tracer
    tracer.Visible = shown
    if not shown then return end
    local delta = to - from
    tracer.Position = UDim2.fromOffset((from.X + to.X) / 2, (from.Y + to.Y) / 2)
    tracer.Size = UDim2.fromOffset(delta.Magnitude, 1)
    tracer.Rotation = math.deg(math.atan2(delta.Y, delta.X))
    tracer.BackgroundColor3 = color
end

---@return boolean  preview on, menu open and unfolded, Visuals tab active
function Library.Visuals.Wanted()
    local visuals, window = Library.Visuals, State.Window
    return visuals.Preview and visuals.Tab ~= nil and window ~= nil and window:IsShown() and window.ActiveTab == visuals.Tab
end

---Docks the card beside the window, flipping to the left side when the right has no room.
function Library.Visuals.Place()
    local panel, window = Library.Visuals.Panel, State.Window
    if not panel.Card or not window then return end
    local settings, scale = Config.Preview, State.UserScale
    local stage, origin = State.Stage.AbsoluteSize, State.Stage.AbsolutePosition
    local position, size = window.Root.AbsolutePosition - origin, window.Root.AbsoluteSize
    local width, height = settings.Width * scale, math.max(size.Y, settings.MinHeight * scale)
    local gap, margin = settings.Gap * scale, settings.Margin
    local x = position.X + size.X + gap
    panel.Flipped = x + width > stage.X - margin
    if panel.Flipped then
        x = position.X - gap - width
    end
    x = math.clamp(x, margin, math.max(margin, stage.X - width - margin))
    local y = math.clamp(position.Y, margin, math.max(margin, stage.Y - height - margin))
    panel.Scale.Scale = scale
    panel.Card.Size = UDim2.fromOffset(settings.Width, height / scale)
    Motion.SetHome(panel.Card, UDim2.fromOffset(math.floor(x), math.floor(y)))
end

function Library.Visuals.Mount(parent)
    local holder = Library.Visuals.Panel.Holder
    if holder.Parent ~= parent then
        holder.Parent = parent
    end
end

function Library.Visuals.Spin()
    local panel = Library.Visuals.Panel
    local model = panel.Model
    if not model or not model.Parent or Motion.Reduced then return end
    local now = os.clock()
    panel.Angle = (panel.Angle + Config.Preview.Spin * math.min(now - (panel.Spun or now), 0.1) * math.pi) % (math.pi * 2)
    panel.Spun = now
    model:PivotTo(CFrame.Angles(0, panel.Angle, 0) * panel.Base)
end

function Library.Visuals.SetSpinning(spinning)
    local panel = Library.Visuals.Panel
    if spinning == (panel.Job ~= nil) then return end
    if not spinning then
        panel.Job.Stopped, panel.Job = true, nil
        return
    end
    panel.Spun = nil
    panel.Job = { Interval = Config.Preview.Tick, Elapsed = 0, Run = Library.Visuals.Spin, Inline = true }
    table.insert(State.Tasks, panel.Job)
end

---Single place that decides where the preview lives; runs on window, tab, mode, toggle and resize changes.
function Library.Visuals.Sync()
    local visuals, panel = Library.Visuals, Library.Visuals.Panel
    if not panel.Card then return end
    local phone = Platform.Mode == "Phone"
    local wanted = visuals.Wanted()
    if panel.Inline.Hidden ~= not (phone and visuals.Preview) then
        panel.Inline.Hidden = not (phone and visuals.Preview)
        panel.Group:MarkDirty()
    end
    local docked = wanted and not phone
    if wanted then
        visuals.Mount(phone and panel.InlineFrame or panel.Face)
        visuals.EnsureModel()
    end
    if docked then
        visuals.Place()
    end
    Motion.Presence(panel.Card, docked, { From = panel.Flipped and "Right" or "Left", Distance = Config.Preview.Slide })
    panel.Shown = wanted
    visuals.SetSpinning(wanted)
    visuals.Render()
end

function Library.Visuals.Follow()
    local panel = Library.Visuals.Panel
    if panel.Shown and Platform.Mode ~= "Phone" then
        Library.Visuals.Place()
    end
end

---Side card on its own layer (above the window, under every popup) plus the phone slot in `group`.
function Library.Visuals.BuildPanel(window, group)
    local panel = Library.Visuals.Panel
    if panel.Card then return end
    local card, face = Popup.Card(Popup.Layer("Preview"), "CanvasGroup", "Panel")
    card.Visible = false
    panel.Card, panel.Face = card, face
    panel.Scale = Draw.New("UIScale", { Parent = card })
    face.ClipsDescendants = true
    Library.Visuals.BuildView()
    panel.InlineFrame = Draw.New("Frame", { Name = "PreviewSlot", BackgroundTransparency = 1 })
    panel.Inline = group:Add(panel.InlineFrame, { Height = Config.Preview.InlineHeight })
    panel.Inline.Hidden = true
    panel.Group = group
    window:OnState(Library.Visuals.Sync)
    Kit.Esp.OnChanged(Library.Visuals.Render)
    Util.Connect(window.Root:GetPropertyChangedSignal("AbsolutePosition"), Library.Visuals.Follow)
    Util.Connect(window.Root:GetPropertyChangedSignal("AbsoluteSize"), Library.Visuals.Follow)
    Util.Connect(State.Stage:GetPropertyChangedSignal("AbsoluteSize"), Library.Visuals.Follow)
    table.insert(State.UnloadHooks, Library.Visuals.Teardown)
end

function Library.Visuals.Teardown()
    local panel = Library.Visuals.Panel
    Library.Visuals.SetSpinning(false)
    if panel.Model then
        panel.Model:Destroy()
    end
    if panel.Card then
        Motion.Forget(panel.Card)
        panel.Card:Destroy()
    end
    table.clear(panel)
end

---V1 shim: one tab with the Kit ESP groups fed by `Provider`, plus the live ESP preview.
---@param options table?  { Name, Icon, Provider, Preview }
function Window:AddVisualsTab(options)
    options = options or {}
    Library.Visuals.Provider = options.Provider
    Library.Visuals.Preview = options.Preview == true
    local tab = self:AddTab(options.Name or Library:T("Visuals", "การมองเห็น"), options.Icon or "eye")
    Library.Visuals.Tab = tab
    if options.Provider then
        Library.Visuals.Category()
    end
    local _, look = Kit.Esp.Build(tab, { Players = options.Provider == nil })
    look:AddToggle("MarioEspPreview", {
        Text = Library:T("Show Preview", "แสดงตัวอย่าง"),
        Default = Library.Visuals.Preview,
        Callback = function(on) Library.Visuals:SetPreview(on) end,
    })
    Library.Visuals.BuildPanel(self, look)
    Library.Visuals.Sync()
    return tab
end

---@author xDTaraZ  Mario Hub UI V2

Config.Settings = { File = Config.Root .. "/settings.json", SaveDelay = 0.5, PruneInterval = 20 }
Config.ExportPrefix = "MH2:"

Keybinds.Modifiers = { LeftControl = true, RightControl = true, LeftShift = true, RightShift = true, LeftAlt = true, RightAlt = true }

---@return {EN: string, TH: string}  Lang.Strings[key] formatted in both languages
function Lang.Format(key, ...)
    local spec = Lang.Strings[key] or { EN = key, TH = key }
    local args = table.pack(...)
    return {
        EN = string.format(spec.EN, table.unpack(args, 1, args.n)),
        TH = string.format(spec.TH or spec.EN, table.unpack(args, 1, args.n)),
    }
end

function Gui.ClearPrevious(parent)
    local env = type(getgenv) == "function" and getgenv() or nil
    if env and type(env.MarioHub) == "table" and env.MarioHub ~= Library and not env.MarioHub.Unloaded then
        Util.Try(env.MarioHub.Unload, env.MarioHub)
    end
    if env then
        env.MarioHub = Library
    end
    for _, child in ipairs(parent:GetChildren()) do
        if child:GetAttribute(Config.GuiAttribute) then
            child:Destroy()
        end
    end
end

function Gui.Setup()
    if State.Gui then
        return
    end
    local parent = Util.GuiParent()
    Gui.ClearPrevious(parent)
    State.Gui = Draw.New("ScreenGui", {
        Name = "MarioHub",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = Config.Layer.Gui,
        Parent = parent,
    })
    pcall(function()
        State.Gui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    end)
    State.Stage = Draw.New("Frame", { Name = "Stage", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = State.Gui })
    State.Gui:SetAttribute(Config.GuiAttribute, Library.Version)
    State.Gui:SetAttribute("Author", Library.Author)
    State.Gui:SetAttribute("Credit", Library.Credit)
    Notify.Build()
    Tooltip.Build()
    Util.Connect(UserInputService.InputBegan, Gui.OnInputBegan)
    Util.Connect(UserInputService.InputChanged, Gui.OnInputChanged)
    Util.Connect(UserInputService.InputEnded, Gui.OnInputEnded)
    Util.Connect(RunService.RenderStepped, Gui.OnFrame)
    Util.Every(Config.Settings.PruneInterval, Theme.Prune)
end

---The only per-frame callback: fps budget, springs, notify timers, dirty layout, due tasks.
function Gui.OnFrame(deltaTime)
    Motion.ReportFps(deltaTime)
    if Motion.Running then
        Motion.Step(deltaTime)
    end
    if Notify.Ticking then
        Notify.Tick(deltaTime)
    end
    if next(Layout.Dirty) ~= nil then
        Layout.Flush()
    end
    local tasks = State.Tasks
    for index = #tasks, 1, -1 do
        local job = tasks[index]
        if job.Stopped then
            table.remove(tasks, index)
        else
            job.Elapsed += deltaTime
            if job.Elapsed >= job.Interval then
                job.Elapsed = 0
                Gui.RunJob(job)
            end
        end
    end
end

---Library jobs run inline; every user job run gets its own coroutine, so one that starts yielding later never stalls the frame loop.
---A job seen yielding once is handed to the task scheduler for good and skipped while its last run is still parked.
function Gui.RunJob(job)
    if job.Inline then
        Util.Try(job.Run)
        return
    end
    local thread = job.Thread
    if thread and coroutine.status(thread) ~= "dead" then
        return
    end
    if job.Yielded then
        job.Thread = task.spawn(Util.Try, job.Run)
        return
    end
    thread = coroutine.create(Util.Try)
    coroutine.resume(thread, job.Run)
    if coroutine.status(thread) ~= "dead" then
        job.Thread, job.Yielded = thread, true
    end
end

function Gui.OnInputBegan(input, processed)
    State.LastInput = os.clock()
    if State.Binding then
        Keybinds.Capture(input)
        return
    end
    local name = Util.InputName(input)
    if not name then
        return
    end
    if name ~= State.MenuKey then
        State.MenuArmed = false
    end
    if processed or UserInputService:GetFocusedTextBox() then
        return
    end
    if name == "Escape" and Popup.CloseTop() then
        return
    end
    if Keybinds.IsPalette(input) then
        Palette.Toggle(State.Window)
        return
    end
    if name == State.MenuKey then
        Keybinds.MenuDown()
    end
    Keybinds.Dispatch(name, true)
end

function Gui.OnInputChanged(input)
    local drag = State.Drag
    if not drag or not Util.IsMove(input) then
        return
    end
    if input.UserInputType == Enum.UserInputType.Touch and drag.Input.UserInputType == Enum.UserInputType.Touch and input ~= drag.Input then
        return
    end
    drag.Move(input)
end

function Gui.OnInputEnded(input)
    if Util.IsPointer(input) and State.Drag then
        local drag = State.Drag
        State.Drag = nil
        Util.Try(drag.Stop)
    end
    local name = Util.InputName(input)
    if not name then
        return
    end
    if name == State.MenuKey and State.MenuArmed then
        State.MenuArmed = false
        Library:Toggle()
    end
    Keybinds.Dispatch(name, false)
end

function Keybinds.Short(name)
    return Config.Widget.KeyShort[name] or tostring(name)
end

function Keybinds.IsPalette(input)
    if input.KeyCode ~= Enum.KeyCode.K or Platform.Mode ~= "Desktop" then
        return false
    end
    return UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
end

---A modifier menu key toggles on release so Ctrl+K and other combos don't flip the menu.
function Keybinds.MenuDown()
    if Keybinds.Modifiers[State.MenuKey] then
        State.MenuArmed = true
        return
    end
    Library:Toggle()
end

function Keybinds.Capture(input)
    local picker = State.Binding
    if input.UserInputType == Enum.UserInputType.Touch then
        State.Binding = nil
        Util.Try(picker.Render, picker)
        return
    end
    local name = Util.InputName(input)
    if not name then
        return
    end
    State.Binding = nil
    if name == "Escape" then
        Util.Try(picker.Render, picker)
        return
    end
    if name == "Backspace" or name == "Delete" then
        name = "None"
    end
    Util.Try(picker.SetKey, picker, name)
end

---Pickers live in State.KeyPickers with { Value, Press(down), Destroyed?, Button? }.
function Keybinds.Dispatch(name, down)
    local pickers = State.KeyPickers
    for index = #pickers, 1, -1 do
        local picker = pickers[index]
        local frame = picker.Button or picker.Frame
        if picker.Destroyed or (typeof(frame) == "Instance" and not frame.Parent) then
            table.remove(pickers, index)
        elseif picker.Value == name then
            Util.Try(picker.Press, picker, down)
        end
    end
end

---Configs live in ConfigFolder/<GameId>; the bare ConfigFolder from older builds stays readable as a fallback.
function Configs.SetFolder(name)
    local place = game.GameId ~= 0 and game.GameId or game.PlaceId
    Configs.Legacy = Config.ConfigRoot .. "/" .. Util.Sanitize(name)
    Configs.Folder = Configs.Legacy .. "/" .. tostring(place)
    if Util.FileApi() then
        Util.EnsureFolder(Configs.Folder)
    end
end

function Configs.Path(name)
    return Configs.Folder .. "/" .. Util.Sanitize(name) .. ".json"
end

---@return string?  path of file in the game folder, else the legacy folder, nil if neither has it
function Configs.Find(file)
    if not Util.FileApi() then
        return nil
    end
    for _, folder in ipairs({ Configs.Folder, Configs.Legacy }) do
        local path = folder and folder .. "/" .. file
        if path and Util.SafeFile(isfile, path) == true then
            return path
        end
    end
    return nil
end

---@return boolean  tab matches a name given as plain text, either language, or a "EN · TH" spec
function Configs.TabNamed(tab, name)
    if type(tab) ~= "table" or tab.Name == nil then
        return false
    end
    local wanted = name:lower()
    local spec = tab.Name
    if type(spec) == "table" then
        return (spec.EN or ""):lower() == wanted or (spec.TH or ""):lower() == wanted
    end
    return tostring(spec):lower() == wanted or Lang.Resolve(spec):lower() == wanted
end

---@return table?  the container an option was built in (widgets keep it on themselves or their row)
function Configs.HomeOf(option)
    return option.Container or (type(option.Row) == "table" and option.Row.Container) or nil
end

---@return boolean  option sits inside scope (a tab object, tab name, groupbox or nested container)
function Configs.InScope(option, scope)
    local container = Configs.HomeOf(option)
    while container do
        local tab = container.Tab
        if container == scope or tab == scope then
            return true
        end
        if type(scope) == "string" and Configs.TabNamed(tab, scope) then
            return true
        end
        container = container.Parent
    end
    return false
end

---Records each option's first-seen value (nil included, so an empty pick resets back to empty); DefaultValue wins over the capture.
function Configs.CaptureDefaults()
    Configs.Defaults = Configs.Defaults or {}
    for idx, option in pairs(Library.Options) do
        if Configs.Defaults[idx] == nil and not option.NoSave and type(option.Serialize) == "function" then
            local ok, value = pcall(option.Serialize, option)
            if option.DefaultValue ~= nil then
                ok, value = true, option.DefaultValue
            end
            if ok then
                Configs.Defaults[idx] = { Type = option.Type, Value = value }
            end
        end
    end
end

---@param scope any  nil or "all" (any case) for everything, a tab (object or name) or a groupbox
---@return number    options restored
function Configs.Reset(scope)
    Configs.CaptureDefaults()
    local whole = scope == nil or (type(scope) == "string" and scope:lower() == "all")
    local restored = {}
    for idx, saved in pairs(Configs.Defaults) do
        local option = Library.Options[idx]
        if option and (whole or Configs.InScope(option, scope)) then
            restored[idx] = saved
        end
    end
    Configs.Apply(restored)
    local count = 0
    for _ in pairs(restored) do
        count += 1
    end
    return count
end

---@return table  idx -> { Type, Value } for every saveable option
function Configs.Snapshot()
    local snapshot = {}
    for idx, option in pairs(Library.Options) do
        if not option.NoSave and type(option.Serialize) == "function" then
            local ok, value = pcall(option.Serialize, option)
            if ok then
                snapshot[idx] = { Type = option.Type, Value = value }
            end
        end
    end
    return snapshot
end

function Configs.Apply(snapshot)
    Configs.CaptureDefaults()
    for idx, saved in pairs(snapshot) do
        local option = Library.Options[idx]
        if option and not option.NoSave and type(saved) == "table" and option.Type == saved.Type then
            Util.Try(option.Deserialize, option, saved.Value)
        end
    end
end

function Configs.Save(name)
    if not Util.FileApi() then
        return false, Lang.Get("NoFileApi")
    end
    Util.EnsureFolder(Configs.Folder)
    local written = Util.SafeFile(writefile, Configs.Path(name), HttpService:JSONEncode(Configs.Snapshot()))
    return written ~= nil, written == nil and Lang.Get("NoFileApi") or nil
end

function Configs.Load(name)
    local path = Configs.Find(Util.Sanitize(name) .. ".json")
    if not path then
        return false, Lang.Get("ConfigMissing")
    end
    local ok, snapshot = pcall(HttpService.JSONDecode, HttpService, Util.SafeFile(readfile, path) or "")
    if not ok or type(snapshot) ~= "table" then
        return false, Lang.Get("ConfigBroken")
    end
    Configs.Apply(snapshot)
    return true
end

function Configs.Delete(name)
    local path = Configs.Find(Util.Sanitize(name) .. ".json")
    if type(delfile) ~= "function" or not path then
        return false, Lang.Get("ConfigMissing")
    end
    return Util.SafeFile(delfile, path) ~= nil
end

function Configs.List()
    if type(listfiles) ~= "function" or not Util.FileApi() then
        return {}
    end
    local names, seen = {}, {}
    for _, folder in ipairs({ Configs.Folder, Configs.Legacy }) do
        local files = Util.SafeFile(listfiles, folder)
        for _, path in ipairs(type(files) == "table" and files or {}) do
            local name = tostring(path):match("([^/\\]+)%.json$")
            if name and not seen[name] then
                seen[name] = true
                table.insert(names, name)
            end
        end
    end
    table.sort(names)
    return names
end

function Configs.SetAutoload(name)
    if not Util.FileApi() then
        return false, Lang.Get("NoFileApi")
    end
    Util.EnsureFolder(Configs.Folder)
    return Util.SafeFile(writefile, Configs.Folder .. "/autoload.txt", name) ~= nil
end

function Configs.GetAutoload()
    local path = Configs.Find("autoload.txt")
    if not path then
        return nil
    end
    local name = Util.SafeFile(readfile, path)
    return type(name) == "string" and name ~= "" and name or nil
end

---@return string  prefixed JSON of the current options, safe to paste anywhere
function Configs.Export()
    return Config.ExportPrefix .. HttpService:JSONEncode(Configs.Snapshot())
end

---@return boolean  false if the string is not an export
function Configs.Import(text)
    text = tostring(text or ""):gsub("^%s+", ""):gsub("%s+$", "")
    local prefix = Config.ExportPrefix
    if text:sub(1, #prefix) ~= prefix then
        return false
    end
    local ok, snapshot = pcall(HttpService.JSONDecode, HttpService, text:sub(#prefix + 1))
    if not ok or type(snapshot) ~= "table" then
        return false
    end
    Configs.Apply(snapshot)
    return true
end

function Settings.Load()
    State.Settings = {}
    if not Util.FileApi() or Util.SafeFile(isfile, Config.Settings.File) ~= true then
        return
    end
    local ok, saved = pcall(HttpService.JSONDecode, HttpService, Util.SafeFile(readfile, Config.Settings.File) or "")
    if ok and type(saved) == "table" then
        State.Settings = saved
    end
end

function Settings.Get(key, fallback)
    local value = State.Settings and State.Settings[key]
    if value == nil then
        return fallback
    end
    return value
end

function Settings.Set(key, value)
    State.Settings = State.Settings or {}
    State.Settings[key] = value
    Settings.Token = (Settings.Token or 0) + 1
    task.delay(Config.Settings.SaveDelay, Settings.Flush, Settings.Token)
end

function Settings.Flush(token)
    if token ~= nil and token ~= Settings.Token then
        return
    end
    if not Util.FileApi() or not State.Settings then
        return
    end
    Util.EnsureFolder(Config.Root)
    Util.SafeFile(writefile, Config.Settings.File, HttpService:JSONEncode(State.Settings))
end

---Saved user choices win over the script's CreateWindow defaults.
function Settings.ApplyBoot(options)
    State.UserScale = math.clamp(tonumber(Settings.Get("Scale", options.Scale or 1)) or 1, Config.ScaleRange.Min, Config.ScaleRange.Max)
    State.MenuKey = Settings.Get("MenuKey", Util.KeyName(options.MenuKey or options.ToggleKey or options.MinimizeKey) or State.MenuKey)
    Motion.SetReduced(Settings.Get("ReduceMotion", false) == true)
    if Settings.Get("Particles") ~= nil then
        Particles.SetEnabled(Settings.Get("Particles") == true)
    end
    return Settings.Get("Theme", options.Theme or "Overworld"), Settings.Get("Language")
end

function Settings.ApplyOverlays(window, options)
    window:SetTransparency(Settings.Get("Transparency", 0))
    Watermark.SetVisible(Settings.Get("Watermark", options.Watermark ~= false) == true)
    KeybindList.SetVisible(Settings.Get("KeybindList", false) == true)
    Float.SetVisible(Settings.Get("Float", Platform.Touch) == true)
    Float.SetSize(Settings.Get("FloatSize"))
    Notify.SetPosition(Settings.Get("NotifyCorner", "BottomRight"))
end

function Gui.Teardown()
    for _, callback in ipairs(State.UnloadHooks) do
        Util.Try(callback)
    end
    Settings.Flush()
    for _, connection in ipairs(State.Connections) do
        connection:Disconnect()
    end
    table.clear(State.Connections)
    table.clear(State.KeyPickers)
    table.clear(State.Tasks)
    table.clear(Layout.Dirty)
    for _, registry in ipairs({ Theme.Bound, Theme.InstanceRenderers, Theme.Renderers, Lang.Bound, Lang.InstanceListeners, Lang.Listeners, Fonts.Texts }) do
        table.clear(registry)
    end
    State.Drag, State.Binding, State.Popup, State.Sheet, State.Dialog, State.Window = nil, nil, nil, nil, nil, nil
    Palette.Frame = nil
    if State.Gui then
        State.Gui:Destroy()
        State.Gui, State.Stage = nil, nil
    end
    local env = type(getgenv) == "function" and getgenv() or nil
    if env and env.MarioHub == Library then
        env.MarioHub = nil
    end
end

---@author xDTaraZ  Mario Hub UI V2
Kit.Lib = { Config = { LogFolder = "mariohub/logs", RetryBase = 0.5, RetryMax = 8, FindTimeout = 5 } }
Library.Lib = Kit.Lib

Kit.Lib.Maid = {}
Kit.Lib.Maid.__index = Kit.Lib.Maid

---New cleanup bag; everything given to it dies on :Cleanup() or library unload.
function Kit.Lib.Maid.new(parent)
    local maid = setmetatable({ Tasks = {} }, Kit.Lib.Maid)
    if parent then
        parent:Give(maid)
    end
    return maid
end

---@param task any  RBXScriptConnection | Instance | function | thread | Maid | table with Destroy/Disconnect
---@return any  the same task, for chaining
function Kit.Lib.Maid:Give(job)
    if job ~= nil then
        self.Tasks[#self.Tasks + 1] = job
    end
    return job
end

function Kit.Lib.Maid.Drop(job)
    local kind = typeof(job)
    if kind == "RBXScriptConnection" then
        job:Disconnect()
    elseif kind == "Instance" then
        job:Destroy()
    elseif kind == "function" then
        job()
    elseif kind == "thread" then
        if job ~= coroutine.running() then
            task.cancel(job)
        end
    elseif kind == "table" then
        local method = job.Cleanup or job.Destroy or job.Disconnect or job.Remove
        if method then
            method(job)
        end
    end
end

---Cleans in reverse order; one failing task is logged and the rest still run.
function Kit.Lib.Maid:Cleanup()
    local tasks = self.Tasks
    self.Tasks = {}
    for index = #tasks, 1, -1 do
        local ok, err = pcall(Kit.Lib.Maid.Drop, tasks[index])
        if not ok then
            warn("[Mario Lib] maid:", err)
        end
    end
end

Kit.Lib.Maid.Destroy = Kit.Lib.Maid.Cleanup
Kit.Lib.Root = Kit.Lib.Maid.new()
table.insert(State.UnloadHooks, function()
    Kit.Lib.Root:Cleanup()
end)

Kit.Lib.Signal = {}
Kit.Lib.Signal.__index = Kit.Lib.Signal

function Kit.Lib.Signal.new()
    return setmetatable({ Handlers = {} }, Kit.Lib.Signal)
end

---@return table  connection with :Disconnect()
function Kit.Lib.Signal:Connect(handler)
    local signal = self
    local conn = { Connected = true, Handler = handler }
    function conn.Disconnect()
        conn.Connected = false
        local index = table.find(signal.Handlers, conn)
        if index then
            table.remove(signal.Handlers, index)
        end
    end
    self.Handlers[#self.Handlers + 1] = conn
    return conn
end

function Kit.Lib.Signal:Once(handler)
    local conn
    conn = self:Connect(function(...)
        conn.Disconnect()
        handler(...)
    end)
    return conn
end

function Kit.Lib.Signal:Fire(...)
    for _, conn in ipairs(table.clone(self.Handlers)) do
        if conn.Connected then
            task.spawn(conn.Handler, ...)
        end
    end
end

---@return boolean fired, any ...  false after `timeout` seconds
function Kit.Lib.Signal:Wait(timeout)
    local thread = coroutine.running()
    local done = false
    local conn = self:Once(function(...)
        if done then return end
        done = true
        task.spawn(thread, true, ...)
    end)
    if timeout then
        task.delay(timeout, function()
            if done then return end
            done = true
            conn.Disconnect()
            task.spawn(thread, false)
        end)
    end
    return coroutine.yield()
end

function Kit.Lib.Signal:DisconnectAll()
    for _, conn in ipairs(self.Handlers) do
        conn.Connected = false
    end
    table.clear(self.Handlers)
end

Kit.Lib.Signal.Destroy = Kit.Lib.Signal.DisconnectAll

Kit.Lib.StoreClass = {}
Kit.Lib.StoreClass.__index = Kit.Lib.StoreClass

---Reactive state: `:Watch(key, fn(new, old))` runs whenever `:Set` changes that key.
function Kit.Lib.Store(initial)
    local values = {}
    for key, value in pairs(initial or {}) do
        values[key] = value
    end
    return setmetatable({ Values = values, Watchers = {} }, Kit.Lib.StoreClass)
end

function Kit.Lib.StoreClass:Get(key)
    return self.Values[key]
end

function Kit.Lib.StoreClass:Set(key, value)
    local old = self.Values[key]
    if old == value then
        return
    end
    self.Values[key] = value
    for _, watcher in ipairs(self.Watchers[key] or {}) do
        task.spawn(watcher, value, old)
    end
end

---@return function  stop watching
function Kit.Lib.StoreClass:Watch(key, watcher)
    local list = self.Watchers[key] or {}
    self.Watchers[key] = list
    list[#list + 1] = watcher
    return function()
        local index = table.find(list, watcher)
        if index then
            table.remove(list, index)
        end
    end
end

---Runs `fn` only after `wait` seconds pass with no new call.
function Kit.Lib.Debounce(wait, fn)
    local token = 0
    return function(...)
        token += 1
        local mine = token
        local args = table.pack(...)
        task.delay(wait, function()
            if mine == token then
                fn(table.unpack(args, 1, args.n))
            end
        end)
    end
end

---Runs `fn` at most once per `gap` seconds; extra calls are dropped.
function Kit.Lib.Throttle(gap, fn)
    local last = -math.huge
    return function(...)
        local now = os.clock()
        if now - last < gap then return end
        last = now
        return fn(...)
    end
end

function Kit.Lib.Defer(fn, ...)
    return task.defer(fn, ...)
end

Kit.Lib.AsyncClass = {}
Kit.Lib.AsyncClass.__index = Kit.Lib.AsyncClass

---Promise-lite: `Lib.Async(fn, ...):Timeout(5):Then(ok):Catch(err)`; `:Await()` yields for the result.
function Kit.Lib.Async(fn, ...)
    local job = setmetatable({ Status = "Pending", Done = Kit.Lib.Signal.new() }, Kit.Lib.AsyncClass)
    local args = table.pack(...)
    job.Thread = task.spawn(function()
        local results = table.pack(pcall(fn, table.unpack(args, 1, args.n)))
        if results[1] then
            job:Settle("Resolved", table.pack(table.unpack(results, 2, results.n)))
        else
            job:Settle("Rejected", table.pack(results[2]))
        end
    end)
    return job
end

function Kit.Lib.AsyncClass:Settle(status, values)
    if self.Status ~= "Pending" then return end
    self.Status, self.Values = status, values
    self.Done:Fire()
end

function Kit.Lib.AsyncClass:Timeout(seconds)
    task.delay(seconds, function()
        if self.Status ~= "Pending" then return end
        if self.Thread and self.Thread ~= coroutine.running() then
            pcall(task.cancel, self.Thread)
        end
        self:Settle("Rejected", table.pack("timeout"))
    end)
    return self
end

function Kit.Lib.AsyncClass:On(status, handler)
    if self.Status == status then
        task.spawn(handler, table.unpack(self.Values, 1, self.Values.n))
    elseif self.Status == "Pending" then
        self.Done:Once(function()
            if self.Status == status then
                handler(table.unpack(self.Values, 1, self.Values.n))
            end
        end)
    end
    return self
end

function Kit.Lib.AsyncClass:Then(handler)
    return self:On("Resolved", handler)
end

function Kit.Lib.AsyncClass:Catch(handler)
    return self:On("Rejected", handler)
end

---@return boolean ok, any ...
function Kit.Lib.AsyncClass:Await()
    if self.Status == "Pending" then
        self.Done:Wait()
    end
    return self.Status == "Resolved", table.unpack(self.Values, 1, self.Values.n)
end

---Waits on an RBXScriptSignal, Lib.Signal or function with a deadline.
---@return boolean ok, any ...  false on timeout or error
function Kit.Lib.Await(target, timeout, ...)
    if type(target) == "function" then
        return Util.Await(timeout, target, ...)
    end
    if getmetatable(target) == Kit.Lib.Signal then
        return target:Wait(timeout)
    end
    local box = Kit.Lib.Signal.new()
    local conn = target:Once(function(...)
        box:Fire(...)
    end)
    local results = table.pack(box:Wait(timeout))
    conn:Disconnect()
    return table.unpack(results, 1, results.n)
end

---Calls `fn` until it succeeds, doubling the wait each time (capped).
---@return boolean ok, any ...
function Kit.Lib.Retry(fn, attempts, base)
    local wait = base or Kit.Lib.Config.RetryBase
    local results
    for attempt = 1, attempts or 3 do
        results = table.pack(pcall(fn, attempt))
        if results[1] then
            return table.unpack(results, 1, results.n)
        end
        if attempt < (attempts or 3) then
            task.wait(math.min(wait, Kit.Lib.Config.RetryMax))
            wait *= 2
        end
    end
    return table.unpack(results, 1, results.n)
end

Kit.Lib.Logger = {}
Kit.Lib.Logger.__index = Kit.Lib.Logger

---@param toFile boolean?  also append lines to mariohub/logs/<name>.log
function Kit.Lib.Log(name, toFile)
    return setmetatable({ Name = name, File = toFile and (Kit.Lib.Config.LogFolder .. "/" .. Util.Sanitize(name) .. ".log") or nil }, Kit.Lib.Logger)
end

function Kit.Lib.Logger:Write(level, ...)
    local parts = table.pack(...)
    for index = 1, parts.n do
        parts[index] = tostring(parts[index])
    end
    local line = string.format("[%s] %s: %s", self.Name, level, table.concat(parts, " ", 1, parts.n))
    if level == "INFO" then
        print(line)
    else
        warn(line)
    end
    if self.File and Util.FileApi() then
        Util.SafeFile(Util.EnsureFolder, Kit.Lib.Config.LogFolder)
        local stamped = os.date("%H:%M:%S ") .. line .. "\n"
        if type(appendfile) == "function" and Util.SafeFile(isfile, self.File) then
            Util.SafeFile(appendfile, self.File, stamped)
        else
            Util.SafeFile(writefile, self.File, (Util.SafeFile(readfile, self.File) or "") .. stamped)
        end
    end
end

function Kit.Lib.Logger:Info(...) self:Write("INFO", ...) end
function Kit.Lib.Logger:Warn(...) self:Write("WARN", ...) end
function Kit.Lib.Logger:Error(...) self:Write("ERROR", ...) end

Kit.Lib.Logs = Kit.Lib.Log("Mario Lib")

---Instance builder: `Lib.New("Part", { Anchored = true }, { Lib.New("Attachment") })`; Parent is set last.
function Kit.Lib.New(class, props, children)
    local inst = Instance.new(class)
    local parent
    for key, value in pairs(props or {}) do
        if key == "Parent" then
            parent = value
        elseif typeof(inst[key]) == "RBXScriptSignal" then
            inst[key]:Connect(value)
        else
            inst[key] = value
        end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    inst.Parent = parent
    return inst
end

---Follows "a.b.c" from root, waiting up to `timeout` for each missing child.
---@return Instance?
function Kit.Lib.Find(root, path, timeout)
    local node = root
    local deadline = os.clock() + (timeout or 0)
    for segment in path:gmatch("[^%.]+") do
        local child = node:FindFirstChild(segment)
        if not child and timeout then
            child = node:WaitForChild(segment, math.max(deadline - os.clock(), 0.05))
        end
        if not child then
            return nil
        end
        node = child
    end
    return node
end

---Memoizes `fn(key)` per key for `ttl` seconds; `.Clear()` empties it.
function Kit.Lib.Memo(ttl, fn)
    local cache = {}
    local memo = setmetatable({}, {
        __call = function(_, key)
            local hit = cache[key]
            if hit and os.clock() < hit.Expires then
                return hit.Value
            end
            local value = fn(key)
            cache[key] = { Value = value, Expires = os.clock() + ttl }
            return value
        end,
    })
    function memo.Clear()
        table.clear(cache)
    end
    return memo
end

Kit.Lib.Cache = Kit.Lib.Memo

Kit.Lib.RemoteClass = {}
Kit.Lib.RemoteClass.__index = Kit.Lib.RemoteClass

---Cached remote handle; Fire/Invoke respect the measured cooldown, Invoke has a deadline.
function Kit.Lib.Remote(path, cooldown)
    local handle = setmetatable({ Path = path }, Kit.Lib.RemoteClass)
    if cooldown then
        Kit.Remote.SetCooldown(path, cooldown)
    end
    return handle
end

function Kit.Lib.RemoteClass:Get()
    return Kit.Remote.Find(self.Path)
end

function Kit.Lib.RemoteClass:Fire(...)
    return Kit.Remote.Fire(self.Path, ...)
end

function Kit.Lib.RemoteClass:Invoke(...)
    return Kit.Remote.Invoke(self.Path, ...)
end

function Kit.Lib.RemoteClass:Report(accepted, floor)
    Kit.Remote.Report(self.Path, accepted, floor)
end

function Kit.Lib.Option(idx)
    local option = Library.Options[idx]
    if not option then
        Kit.Lib.Logs:Warn("no option named", idx)
    end
    return option
end

---Runs `fn` now and on every change of option `idx`.
function Kit.Lib.Bind(idx, fn)
    local option = Kit.Lib.Option(idx)
    if not option then return end
    option:OnChanged(fn)
    task.spawn(fn, option.Value)
end

---Runs `fn(value)` whenever option `idx` becomes `value`.
function Kit.Lib.When(idx, value, fn)
    local option = Kit.Lib.Option(idx)
    if not option then return end
    option:OnChanged(function(current)
        if current == value then
            fn(current)
        end
    end)
end

---Toggle on = `fn(maid, dt)` every `interval` on the shared scheduler; off = stop + maid:Cleanup(). Errors are logged.
function Kit.Lib.Loop(idx, interval, fn, options)
    local maid = Kit.Lib.Root:Give(Kit.Lib.Maid.new())
    local job = "Loop:" .. idx
    local log = Kit.Lib.Log(idx)
    local spec = { Interval = interval, Lane = options and options.Lane, Async = not options or options.Async ~= false }
    Kit.Lib.Bind(idx, function(on)
        if not on then
            Kit.Scheduler.Remove(job)
            maid:Cleanup()
            return
        end
        if Kit.Scheduler.Has(job) then return end
        Kit.Scheduler.Add(job, function(deltaTime)
            local ok, err = pcall(fn, maid, deltaTime)
            if not ok then
                log:Error(err)
            end
        end, spec)
    end)
    return maid
end

---Pushes `fn()` into the Status/Label/Stat widget `idx` every `interval` seconds.
function Kit.Lib.Status(idx, fn, interval)
    local job = "Status:" .. idx
    Kit.Scheduler.Add(job, function()
        local option = Library.Options[idx]
        if not option then
            Kit.Scheduler.Remove(job)
            return
        end
        local text, kind = fn()
        if option.SetValue then
            option:SetValue(text, kind)
        elseif option.SetText then
            option:SetText(text)
        end
    end, { Interval = interval or 1 })
end

---@author xDTaraZ  Mario Hub UI V2
Library.Kit = Kit

---Same table as the UI's `Platform` ({ Mode, Touch, Console, Viewport }), exposed so hub scripts branch PC/mobile without reaching into UI internals.
Kit.Platform = Platform
Kit.Maid = Kit.Lib.Root:Give(Kit.Lib.Maid.new())
Kit.Log = Kit.Lib.Log("Mario Kit")
Kit.Modules = {}

Kit.Config = {
    ProbeTimeout = 1,
    InvokeTimeout = 8,
    ProbeFile = "mariohub/.kitprobe",
    RenderStep = "MarioKitRender",
    MaxJobErrors = 5,
    JobTimeout = 30,
    StatsInterval = 5,
    RemoteBackoff = 1.25,
    RemoteShrink = 0.95,
    Esp = {
        Rate = 0.25, TouchRate = 0.75, MaxDistance = 1500, TouchMaxDistance = 600,
        TextSize = 13, TouchTextSize = 11, HighlightCap = 30, MinHeight = 2, LabelOffset = 3, TextStroke = 0.4, HighlightFill = 0.8,
    },
    Aim = {
        Fov = 120, TouchFov = 160, SilentFov = 160, MaxDistance = 1000, MinRay = 30, ShotRadius = 20,
        TriggerGap = 0.1, TriggerDelay = 0.05, RageGap = 0.1, Smoothness = 0.3, HitChance = 100, HeadChance = 50,
        CircleSides = 64, AimbotColor = Color3.fromRGB(238, 196, 82), SilentColor = Color3.fromRGB(212, 84, 70),
    },
    Player = {
        WalkSpeed = 50, MaxWalkSpeed = 250, JumpPower = 100, MaxJumpPower = 350, FlySpeed = 80, MaxFlySpeed = 400,
        FallLimit = -60, FallSoft = -12, FallProbe = 14, WaterProbe = 40, WaterPlate = Vector3.new(14, 1, 14),
        BindTimeout = 10, FlyUp = { "Space", "E" }, FlyDown = { "Q" },
    },
    Guns = { RapidScale = 4, MinKick = 0.0015, FireWindow = 0.3, RateAsDelay = 2 },
    World = { Brightness = 2, Ambient = Color3.fromRGB(178, 178, 178), FogEnd = 1e6, Time = 14, ScanBatch = 400 },
    Teleport = { TweenSpeed = 180, StreamTimeout = 4, GroundProbe = 250, GroundLift = 3, ProbeAbove = 8, TweenSlack = 2 },
    Server = {
        RejoinDelay = 3, HopPages = 3,
        ServersUrl = "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&excludeFullGames=true&limit=100%s",
    },
    Webhook = { MinGap = 2, QueueLimit = 20, Color = 0xD45446, Name = "Mario Hub" },
    Discord = "https://discord.gg/FHVfmeSceA",
    DiscordNotify = 8,
}

do
    local resolved = {
        Request = request or http_request or (syn and syn.request),
        QueueOnTeleport = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport),
        GetConnections = getconnections or get_signal_cons,
        HookFunction = hookfunction or replaceclosure,
        HookMetamethod = hookmetamethod,
        RestoreFunction = restorefunction,
        IsFunctionHooked = isfunctionhooked,
        GetNamecallMethod = getnamecallmethod,
        CheckCaller = checkcaller,
        NewCClosure = newcclosure,
        GetRawMetatable = getrawmetatable,
        SetReadonly = setreadonly,
        GetGc = getgc,
        FilterGc = filtergc,
        GetUpvalue = getupvalue or (debug and debug.getupvalue),
        SetUpvalue = setupvalue or (debug and debug.setupvalue),
        FireSignal = firesignal,
        FirePrompt = fireproximityprompt,
        FireTouch = firetouchinterest,
        MouseClick = mouse1click,
        Restores = {},
    }
    for name, value in pairs(resolved) do
        Util[name] = value
    end
end


function Kit.T(english, thai)
    return Library:T(english, thai)
end

function Kit.Connect(signal, handler)
    return Kit.Maid:Give(signal:Connect(handler))
end

---@return table?  response { StatusCode, Body }, nil if no request API or past the deadline
function Util.Send(options)
    if not Util.Request then
        return nil
    end
    local finished, response = Util.Await(Config.HttpTimeout, Util.Request, options)
    return finished and type(response) == "table" and response or nil
end

---Undoes a hook on `target`: the executor's own `restorefunction` first (leaves `isfunctionhooked` false), else hooks `original` back in.
---@param rehook function  fallback that reinstalls `original`
function Util.Unhook(target, rehook)
    local api = Util
    if target and api.RestoreFunction and pcall(api.RestoreFunction, target) then
        if not api.IsFunctionHooked then return end
        local ok, still = pcall(api.IsFunctionHooked, target)
        if ok and not still then return end
    end
    rehook()
end

---Hooks one metamethod; the original is restored on unload or by the returned restore.
---@return function?  original, nil if the executor can't hook
---@return function?  restore, puts the original back now and drops it from the unload list
function Util.HookMeta(object, method, handler)
    local api = Util
    local wrapped = api.NewCClosure and api.NewCClosure(handler) or handler
    local original, putBack
    if api.HookMetamethod then
        local ok, previous = pcall(api.HookMetamethod, object, method, wrapped)
        if ok and type(previous) == "function" then
            original = previous
            local meta = api.GetRawMetatable and api.GetRawMetatable(object)
            local hooked = meta and rawget(meta, method)
            putBack = function()
                api.Unhook(hooked, function()
                    api.HookMetamethod(object, method, original)
                end)
            end
        end
    end
    if not original then
        if not (api.GetRawMetatable and api.SetReadonly) then
            return nil
        end
        local meta = api.GetRawMetatable(object)
        original = meta[method]
        api.SetReadonly(meta, false)
        meta[method] = wrapped
        api.SetReadonly(meta, true)
        putBack = function()
            api.SetReadonly(meta, false)
            meta[method] = original
            api.SetReadonly(meta, true)
        end
    end
    table.insert(api.Restores, putBack)
    local function restore()
        local index = table.find(api.Restores, putBack)
        if not index then return end
        table.remove(api.Restores, index)
        Util.Try(putBack)
    end
    return original, restore
end

function Util.RestoreAll()
    for index = #Util.Restores, 1, -1 do
        Util.Try(Util.Restores[index])
    end
    table.clear(Util.Restores)
end

function Util.ReadFile(path)
    if not Util.FileApi() or not Util.SafeFile(isfile, path) then
        return nil
    end
    local text = Util.SafeFile(readfile, path)
    return type(text) == "string" and text or nil
end

function Util.WriteFile(path, text)
    if not Util.FileApi() then
        return false
    end
    local folder = path:match("^(.*)/[^/]+$")
    if folder then
        Util.SafeFile(Util.EnsureFolder, folder)
    end
    return Util.SafeFile(writefile, path, text) ~= nil
end

Kit.Caps = setmetatable({ Probes = {} }, {
    __index = function(caps, name)
        local probe = rawget(caps, "Probes")[name]
        if not probe then
            return nil
        end
        local finished, works = Util.Await(Kit.Config.ProbeTimeout, probe)
        local has = finished and works == true
        rawset(caps, name, has)
        return has
    end,
})

Kit.Caps.Probes.Hook = function()
    local api = Util
    if not (api.HookFunction and api.GetNamecallMethod and (api.HookMetamethod or api.GetRawMetatable)) then
        return false
    end
    local target = function()
        return "plain"
    end
    local original = api.HookFunction(target, function()
        return "hooked"
    end)
    local works = target() == "hooked"
    if type(original) == "function" then
        pcall(api.HookFunction, target, original)
    end
    return works
end

Kit.Caps.Probes.Connections = function()
    if not Util.GetConnections then
        return false
    end
    local event = Instance.new("BindableEvent")
    local conn = event.Event:Connect(function() end)
    local list = Util.GetConnections(event.Event)
    conn:Disconnect()
    event:Destroy()
    return type(list) == "table" and #list >= 1
end

Kit.Caps.Probes.Gc = function()
    if not Util.GetGc then
        return false
    end
    local found = Util.GetGc()
    return type(found) == "table" and #found > 0
end

Kit.Caps.Probes.Upvalues = function()
    if not Util.GetUpvalue then
        return false
    end
    local marker = {}
    local function Holder()
        return marker
    end
    return Util.GetUpvalue(Holder, 1) == marker
end

Kit.Caps.Probes.Drawing = function()
    if type(Drawing) ~= "table" and type(Drawing) ~= "userdata" then
        return false
    end
    local line = Drawing.new("Line")
    local remove = line.Remove or line.Destroy
    remove(line)
    return true
end

Kit.Caps.Probes.FileSystem = function()
    local stamp = tostring(os.clock())
    return Util.WriteFile(Kit.Config.ProbeFile, stamp) and Util.ReadFile(Kit.Config.ProbeFile) == stamp
end

Kit.Caps.Probes.Hui = function()
    return type(gethui) == "function" and typeof(gethui()) == "Instance"
end

Kit.Caps.Probes.Http = function()
    return Util.Request ~= nil
end

Kit.Caps.Probes.Queue = function()
    return Util.QueueOnTeleport ~= nil
end

Kit.Caps.Probes.Clipboard = function()
    return type(setclipboard or toclipboard) == "function"
end

Kit.Caps.Probes.Signals = function()
    return Util.FireSignal ~= nil
end

Kit.Caps.Probes.Prompt = function()
    return Util.FirePrompt ~= nil
end

Kit.Caps.Probes.Touch = function()
    return Util.FireTouch ~= nil
end

---Flips a toggle back off with a notice when the executor lacks `cap`.
---@param option table|string  widget or its idx
function Kit.Caps.NeedCap(option, cap)
    option = type(option) == "string" and Library.Options[option] or option
    if type(option) ~= "table" or type(option.OnChanged) ~= "function" then
        return
    end
    option:OnChanged(function(value)
        if value ~= true or Kit.Caps[cap] then
            return
        end
        local feature = Lang.Resolve(option.Info and option.Info.Text or option.Idx)
        Library:Notify("Mario Hub", Kit.T(feature .. " is not supported on this executor", feature .. " ใช้กับ executor นี้ไม่ได้"), 4, "Warn")
        task.defer(option.SetValue, option, false)
    end)
end

Kit.Override = { Groups = {} }

function Kit.Override.Write(entry, value)
    entry.Writing = true
    local ok = pcall(function()
        entry.Instance[entry.Property] = value
    end)
    entry.Writing = false
    return ok
end

---Sets a property and remembers the value it had first, so Restore puts back exactly that.
---@param enforce boolean?  re-apply whenever the game changes it
function Kit.Override.Set(group, inst, prop, value, enforce)
    local entries = Kit.Override.Groups[group]
    if not entries then
        entries = {}
        Kit.Override.Groups[group] = entries
    end
    local entry
    for _, existing in ipairs(entries) do
        if existing.Instance == inst and existing.Property == prop then
            entry = existing
            break
        end
    end
    if not entry then
        local ok, original = pcall(function()
            return inst[prop]
        end)
        if not ok then
            return false
        end
        entry = { Instance = inst, Property = prop, Original = original }
        entries[#entries + 1] = entry
        entry.Gone = inst.Destroying:Connect(function()
            Kit.Override.Drop(entries, entry)
        end)
    end
    entry.Value = value
    local written = Kit.Override.Write(entry, value)
    if enforce and not entry.Conn then
        entry.Conn = inst:GetPropertyChangedSignal(prop):Connect(function()
            if entry.Writing or inst[prop] == entry.Value then return end
            Kit.Override.Write(entry, entry.Value)
        end)
    end
    return written
end

function Kit.Override.Release(entry)
    for _, key in ipairs({ "Conn", "Gone", "Return" }) do
        if entry[key] then
            entry[key]:Disconnect()
            entry[key] = nil
        end
    end
end

---Forgets a destroyed instance; one that is only unparented keeps its entry so it still restores.
function Kit.Override.Drop(entries, entry)
    Kit.Override.Release(entry)
    local index = table.find(entries, entry)
    if index then
        table.remove(entries, index)
    end
end

---Puts the original back; an instance the game has pulled out of the tree gets it the moment it is re-parented.
function Kit.Override.PutBack(entry)
    Kit.Override.Release(entry)
    local inst = entry.Instance
    if inst.Parent ~= nil and Kit.Override.Write(entry, entry.Original) then return end
    Kit.Override.Write(entry, entry.Original)
    entry.Return = inst.AncestryChanged:Connect(function(_, parent)
        if parent == nil then return end
        Kit.Override.Release(entry)
        Kit.Override.Write(entry, entry.Original)
    end)
    entry.Gone = inst.Destroying:Connect(function()
        Kit.Override.Release(entry)
    end)
end

function Kit.Override.Restore(group)
    local entries = Kit.Override.Groups[group]
    if not entries then
        return
    end
    Kit.Override.Groups[group] = nil
    for index = #entries, 1, -1 do
        Kit.Override.PutBack(entries[index])
    end
end

function Kit.Override.RestoreAll()
    for group in pairs(Kit.Override.Groups) do
        Kit.Override.Restore(group)
    end
end

Kit.Scheduler = { Jobs = {}, Lanes = { Tick = {}, Render = {}, Physics = {} }, Snapshots = { Tick = {}, Render = {}, Physics = {} }, Bound = {} }

---@param options table?  { Interval = 0, Lane = "Tick"|"Render"|"Physics", Priority = 0, Async = false, Timeout = 30 }
---@return table  job; Render runs after the camera, Physics before the physics step
function Kit.Scheduler.Add(name, run, options)
    options = options or {}
    Kit.Scheduler.Remove(name)
    local job = {
        Name = name, Run = run, Next = 0, Errors = 0,
        Interval = options.Interval or 0,
        Lane = Kit.Scheduler.Lanes[options.Lane] and options.Lane or "Tick",
        Priority = options.Priority or 0,
        Async = options.Async == true,
        Timeout = options.Timeout or Kit.Config.JobTimeout,
    }
    Kit.Scheduler.Jobs[name] = job
    local lane = Kit.Scheduler.Lanes[job.Lane]
    lane[#lane + 1] = job
    table.sort(lane, function(left, right)
        return left.Priority > right.Priority
    end)
    Kit.Scheduler.Bind(job.Lane)
    return job
end

function Kit.Scheduler.Remove(name)
    local job = Kit.Scheduler.Jobs[name]
    if not job then
        return
    end
    Kit.Scheduler.Jobs[name] = nil
    job.Removed = true
    local lane = Kit.Scheduler.Lanes[job.Lane]
    local index = table.find(lane, job)
    if index then
        table.remove(lane, index)
    end
    if job.Thread and job.Thread ~= coroutine.running() then
        pcall(task.cancel, job.Thread)
    end
    if #lane == 0 then
        Kit.Scheduler.Unbind(job.Lane)
    end
end

function Kit.Scheduler.Has(name)
    return Kit.Scheduler.Jobs[name] ~= nil
end

function Kit.Scheduler.SetInterval(name, interval)
    local job = Kit.Scheduler.Jobs[name]
    if job then
        job.Interval = interval
    end
end

function Kit.Scheduler.Bind(laneName)
    local bound = Kit.Scheduler.Bound
    if bound[laneName] then
        return
    end
    if laneName == "Render" then
        RunService:BindToRenderStep(Kit.Config.RenderStep, Enum.RenderPriority.Camera.Value + 1, function(deltaTime)
            Kit.Scheduler.Step("Render", deltaTime)
        end)
        bound.Render = true
    elseif laneName == "Physics" then
        bound.Physics = RunService.Stepped:Connect(function(_, deltaTime)
            Kit.Scheduler.Step("Physics", deltaTime)
        end)
    else
        bound.Tick = RunService.Heartbeat:Connect(function(deltaTime)
            Kit.Scheduler.Step("Tick", deltaTime)
        end)
    end
end

function Kit.Scheduler.Unbind(laneName)
    local bound = Kit.Scheduler.Bound[laneName]
    if not bound then
        return
    end
    Kit.Scheduler.Bound[laneName] = nil
    if laneName == "Render" then
        RunService:UnbindFromRenderStep(Kit.Config.RenderStep)
    else
        bound:Disconnect()
    end
end

function Kit.Scheduler.Step(laneName, deltaTime)
    local lane = Kit.Scheduler.Lanes[laneName]
    local snapshot = Kit.Scheduler.Snapshots[laneName]
    local now = os.clock()
    table.clear(snapshot)
    table.move(lane, 1, #lane, 1, snapshot)
    for _, job in ipairs(snapshot) do
        if job.Removed or now < job.Next then continue end
        job.Next = now + job.Interval
        if job.Async then
            Kit.Scheduler.Spawn(job, deltaTime, now)
        else
            Kit.Scheduler.Call(job, deltaTime)
        end
    end
end

function Kit.Scheduler.Spawn(job, deltaTime, now)
    local thread = job.Thread
    if thread and coroutine.status(thread) ~= "dead" then
        if now - job.Started < job.Timeout then return end
        pcall(task.cancel, thread)
        Kit.Log:Warn(job.Name, "timed out, restarted")
    end
    job.Started = now
    job.Thread = task.spawn(Kit.Scheduler.Call, job, deltaTime)
end

function Kit.Scheduler.Call(job, deltaTime)
    local ok, err = pcall(job.Run, deltaTime)
    if ok then
        job.Errors = 0
        return
    end
    job.Errors += 1
    Kit.Log:Error(job.Name, err)
    if job.Errors >= Kit.Config.MaxJobErrors and not job.Removed then
        Kit.Log:Warn(job.Name, "stopped after repeated errors")
        Kit.Scheduler.Remove(job.Name)
    end
end

function Kit.Scheduler.Status()
    local count = 0
    for _ in pairs(Kit.Scheduler.Jobs) do
        count += 1
    end
    return count == 0 and "Idle" or (count .. " jobs")
end

function Kit.Scheduler.Stop()
    for name in pairs(Kit.Scheduler.Jobs) do
        Kit.Scheduler.Remove(name)
    end
    for laneName in pairs(Kit.Scheduler.Lanes) do
        Kit.Scheduler.Unbind(laneName)
    end
end

Kit.Fsm = {}
Kit.Fsm.__index = Kit.Fsm

---@param spec table  { Name, Initial = "Idle", States = { [name] = { Enter(fsm), Step(fsm, dt) -> next?, note?, Exit(fsm, next), Timeout, OnTimeout } } }
function Kit.Fsm.new(spec)
    local machine = setmetatable({
        Name = spec.Name or "Fsm",
        States = spec.States,
        Initial = spec.Initial or "Idle",
        Context = spec.Context or {},
    }, Kit.Fsm)
    machine:Go(machine.Initial)
    return machine
end

function Kit.Fsm:Go(name, note)
    local state = self.States[name]
    if not state then
        Kit.Log:Warn(self.Name, "unknown state", name)
        return false
    end
    local current = self.State and self.States[self.State]
    if current and current.Exit then
        Util.Try(current.Exit, self, name)
    end
    self.State, self.Entered, self.Note = name, os.clock(), note
    if state.Enter then
        Util.Try(state.Enter, self)
    end
    return true
end

function Kit.Fsm:Elapsed()
    return os.clock() - self.Entered
end

function Kit.Fsm:Step(deltaTime)
    local state = self.States[self.State]
    if state.Timeout and self:Elapsed() > state.Timeout then
        return self:Go(state.OnTimeout or self.Initial, "timeout")
    end
    if not state.Step then
        return false
    end
    local ok, nextState, note = pcall(state.Step, self, deltaTime)
    if not ok then
        Kit.Log:Error(self.Name .. "." .. self.State, nextState)
        return self:Go(self.Initial, "error")
    end
    if nextState and nextState ~= self.State then
        return self:Go(nextState, note)
    end
    if note ~= nil then
        self.Note = note
    end
    return false
end

function Kit.Fsm:Reset()
    self:Go(self.Initial)
end

function Kit.Fsm:Status()
    return self.Note and (self.State .. " · " .. tostring(self.Note)) or self.State
end

Kit.Arbiter = {
    Claims = {},
    Sequence = 0,
    Priority = { Escape = 100, Heal = 100, Event = 80, Boss = 80, Quest = 60, Farm = 40, Collect = 20 },
}

---@param claim table  { Name, Priority = number|"Event", Return = true, OnPause(claim), OnResume(claim) }
---@return boolean  true when this claim now drives the character
function Kit.Arbiter.Request(claim)
    local claims = Kit.Arbiter.Claims
    if table.find(claims, claim) then
        return claims[1] == claim
    end
    if type(claim.Priority) ~= "number" then
        claim.Priority = Kit.Arbiter.Priority[claim.Priority] or 0
    end
    Kit.Arbiter.Sequence += 1
    claim.Sequence = Kit.Arbiter.Sequence
    local previous = claims[1]
    claims[#claims + 1] = claim
    table.sort(claims, function(left, right)
        if left.Priority ~= right.Priority then
            return left.Priority > right.Priority
        end
        return left.Sequence < right.Sequence
    end)
    if claims[1] ~= claim then
        return false
    end
    claim.Origin = Kit.Player and Kit.Player.Root and Kit.Player.Root.CFrame or nil
    claim.Preempted = previous ~= nil
    if previous then
        Util.Try(previous.OnPause, previous)
    end
    return true
end

---Drops a claim; a claim that cut in walks the character back before the paused task resumes.
function Kit.Arbiter.Release(claim)
    local claims = Kit.Arbiter.Claims
    local index = table.find(claims, claim)
    if not index then
        return
    end
    table.remove(claims, index)
    if index ~= 1 then
        return
    end
    if claim.Preempted and claim.Return ~= false and claim.Origin and Kit.Teleport then
        Kit.Teleport.To(claim.Origin, { Ground = false, Stream = false, Mode = "Instant" })
    end
    local resumed = claims[1]
    if resumed then
        Util.Try(resumed.OnResume, resumed)
    end
end

function Kit.Arbiter.Owns(claim)
    return Kit.Arbiter.Claims[1] == claim
end

function Kit.Arbiter.Current()
    return Kit.Arbiter.Claims[1]
end

function Kit.Arbiter.Status()
    local top = Kit.Arbiter.Claims[1]
    return top and tostring(top.Name) or "Idle"
end

function Kit.Arbiter.Stop()
    table.clear(Kit.Arbiter.Claims)
end

Kit.Game = { Modules = {} }

---@param path string  "ReplicatedStorage.Remotes.Buy" or "Remotes/Buy" (from ReplicatedStorage)
function Kit.Game.Resolve(path, root)
    local node = root
    for segment in path:gmatch("[^%./]+") do
        if not node then
            local ok, service = pcall(game.FindService, game, segment)
            node = ok and service or game:GetService("ReplicatedStorage"):FindFirstChild(segment)
        else
            node = node:FindFirstChild(segment)
        end
        if not node then
            return nil
        end
    end
    return node
end

---@return table?  nil if it isn't a ModuleScript or require errored (cached either way)
function Kit.Game.Require(target)
    if type(target) == "string" then
        target = Kit.Game.Resolve(target)
    end
    if typeof(target) ~= "Instance" or not target:IsA("ModuleScript") then
        return nil
    end
    local cached = Kit.Game.Modules[target]
    if cached ~= nil then
        return cached or nil
    end
    local ok, value = pcall(require, target)
    if not ok then
        Kit.Log:Error("require", target:GetFullName(), value)
    end
    Kit.Game.Modules[target] = ok and value or false
    return ok and value or nil
end

function Kit.Game.HasKeys(candidate, keys)
    for _, key in ipairs(keys) do
        if rawget(candidate, key) == nil then
            return false
        end
    end
    return true
end

---@param keys string[]  every key must be present
---@return table?  first live table in the GC with all keys
function Kit.Game.FindTable(keys)
    if Util.FilterGc then
        local ok, found = pcall(Util.FilterGc, "table", { Keys = keys }, true)
        if ok and type(found) == "table" then
            return found
        end
    end
    if not Kit.Caps.Gc then
        return nil
    end
    for _, value in ipairs(Util.GetGc(true)) do
        if type(value) == "table" and Kit.Game.HasKeys(value, keys) then
            return value
        end
    end
    return nil
end

---@return function?  first Luau function in the GC with this debug name
function Kit.Game.FindFunction(name)
    if Util.FilterGc then
        local ok, found = pcall(Util.FilterGc, "function", { Name = name, IgnoreExecutor = true }, true)
        if ok and type(found) == "function" then
            return found
        end
    end
    if not Kit.Caps.Gc then
        return nil
    end
    for _, value in ipairs(Util.GetGc()) do
        if type(value) == "function" and debug.info(value, "s") ~= "[C]" and debug.info(value, "n") == name then
            return value
        end
    end
    return nil
end

function Kit.Game.Upvalue(fn, index)
    if not Util.GetUpvalue then
        return nil
    end
    local ok, value = pcall(Util.GetUpvalue, fn, index)
    return ok and value or nil
end

function Kit.Game.SetUpvalue(fn, index, value)
    if not Util.SetUpvalue then
        return false
    end
    return (pcall(Util.SetUpvalue, fn, index, value))
end

Kit.Remote = { Cache = {}, Gates = {}, Classes = { RemoteEvent = true, RemoteFunction = true, UnreliableRemoteEvent = true } }

---@param query string|Instance  remote name (searched under ReplicatedStorage) or dotted path
function Kit.Remote.Find(query, root)
    if typeof(query) == "Instance" then
        return query
    end
    local cached = Kit.Remote.Cache[query]
    if cached and cached.Parent then
        return cached
    end
    local found
    if query:find("[%./]") then
        found = Kit.Game.Resolve(query, root)
    else
        found = Kit.Remote.Search(query, root or game:GetService("ReplicatedStorage"))
    end
    if found and not Kit.Remote.Classes[found.ClassName] then
        found = nil
    end
    Kit.Remote.Cache[query] = found
    return found
end

function Kit.Remote.Search(name, root)
    local quick = root:FindFirstChild(name, true)
    if quick and Kit.Remote.Classes[quick.ClassName] then
        return quick
    end
    for _, descendant in ipairs(root:GetDescendants()) do
        if descendant.Name == name and Kit.Remote.Classes[descendant.ClassName] then
            return descendant
        end
    end
    return nil
end

function Kit.Remote.Gate(remote)
    local gate = Kit.Remote.Gates[remote]
    if not gate then
        gate = { Cooldown = 0, Floor = 0, Last = 0, LastAccepted = 0 }
        Kit.Remote.Gates[remote] = gate
    end
    return gate
end

function Kit.Remote.SetCooldown(query, seconds)
    local remote = Kit.Remote.Find(query)
    if not remote then
        return
    end
    local gate = Kit.Remote.Gate(remote)
    gate.Cooldown, gate.Floor = seconds, seconds
end

function Kit.Remote.Ready(query)
    local remote = Kit.Remote.Find(query)
    local gate = remote and Kit.Remote.Gates[remote]
    return not gate or os.clock() - gate.Last >= gate.Cooldown
end

---Feed back whether the server accepted the last call; the cooldown backs off on rejects and creeps down on accepts.
---@param floor number?  never go below this
function Kit.Remote.Report(query, accepted, floor)
    local remote = Kit.Remote.Find(query)
    if not remote then
        return
    end
    local gate = Kit.Remote.Gate(remote)
    local now = os.clock()
    if floor then
        gate.Floor = floor
    end
    if accepted then
        gate.LastAccepted = now
        gate.Cooldown = math.max(gate.Floor, gate.Cooldown * Kit.Config.RemoteShrink)
        return
    end
    gate.Cooldown = math.max(gate.Cooldown * Kit.Config.RemoteBackoff, now - gate.LastAccepted, gate.Floor)
end

---@return boolean ok, string? reason  "missing" | "cooldown" | error text
function Kit.Remote.Fire(query, ...)
    local remote = Kit.Remote.Find(query)
    if not remote then
        return false, "missing"
    end
    if not Kit.Remote.Ready(remote) then
        return false, "cooldown"
    end
    Kit.Remote.Gate(remote).Last = os.clock()
    local ok, err = pcall(remote.FireServer, remote, ...)
    return ok, not ok and tostring(err) or nil
end

---@return boolean ok, any ...  false on missing remote, cooldown, error or deadline
function Kit.Remote.Invoke(query, ...)
    local remote = Kit.Remote.Find(query)
    if not remote or not remote:IsA("RemoteFunction") then
        return false, "missing"
    end
    if not Kit.Remote.Ready(remote) then
        return false, "cooldown"
    end
    Kit.Remote.Gate(remote).Last = os.clock()
    return Util.Await(Kit.Config.InvokeTimeout, remote.InvokeServer, remote, ...)
end

Kit.Stats = { Tracked = {} }

function Kit.Stats.Entry(name)
    local entry = Kit.Stats.Tracked[name]
    if not entry then
        entry = { Value = 0, Start = 0, StartTime = os.clock() }
        Kit.Stats.Tracked[name] = entry
    end
    return entry
end

---Samples `read()` every few seconds for a per-hour rate; pass the AddStat widget to keep it live.
function Kit.Stats.Track(name, read, widget)
    local entry = Kit.Stats.Entry(name)
    entry.Read, entry.Widget = read, widget
    local ok, value = pcall(read)
    if ok and type(value) == "number" then
        entry.Value, entry.Start, entry.StartTime = value, value, os.clock()
    end
    if not Kit.Scheduler.Has("KitStats") then
        Kit.Scheduler.Add("KitStats", Kit.Stats.Sample, { Interval = Kit.Config.StatsInterval })
    end
    Kit.Stats.Push(entry)
end

function Kit.Stats.Add(name, amount, widget)
    local entry = Kit.Stats.Entry(name)
    entry.Widget = widget or entry.Widget
    entry.Value += amount
    Kit.Stats.Push(entry)
end

function Kit.Stats.Push(entry)
    if entry.Widget and entry.Widget.SetValue then
        Util.Try(entry.Widget.SetValue, entry.Widget, entry.Value)
    end
end

function Kit.Stats.Sample()
    for _, entry in pairs(Kit.Stats.Tracked) do
        if not entry.Read then continue end
        local ok, value = pcall(entry.Read)
        if ok and type(value) == "number" and value ~= entry.Value then
            entry.Value = value
            Kit.Stats.Push(entry)
        end
    end
end

---@return number value, number gained, number perHour
function Kit.Stats.Get(name)
    local entry = Kit.Stats.Tracked[name]
    if not entry then
        return 0, 0, 0
    end
    local gained = entry.Value - entry.Start
    local hours = math.max(os.clock() - entry.StartTime, 1) / 3600
    return entry.Value, gained, gained / hours
end

function Kit.Stats.Reset(name)
    local entry = Kit.Stats.Tracked[name]
    if entry then
        entry.Start, entry.StartTime = entry.Value, os.clock()
    end
end

function Kit.Stats.Stop()
    table.clear(Kit.Stats.Tracked)
end

Kit.Overlay = {}

function Kit.Overlay.Screen()
    local screen = Kit.Overlay.Gui
    if screen and screen.Parent then
        return screen
    end
    screen = Instance.new("ScreenGui")
    screen.Name = "MarioKit"
    screen.IgnoreGuiInset = true
    screen.ResetOnSpawn = false
    screen.DisplayOrder = Config.Layer.Kit
    screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screen.Parent = Util.GuiParent()
    Kit.Overlay.Gui = screen
    return screen
end

function Kit.Overlay.Folder()
    local folder = Kit.Overlay.Holder
    if folder and folder.Parent then
        return folder
    end
    folder = Instance.new("Folder")
    folder.Name = "MarioKitWorld"
    folder.Parent = Util.GuiParent()
    Kit.Overlay.Holder = folder
    return folder
end

function Kit.Overlay.Stop()
    for _, key in ipairs({ "Gui", "Holder" }) do
        if Kit.Overlay[key] then
            Kit.Overlay[key]:Destroy()
            Kit.Overlay[key] = nil
        end
    end
end

Kit.Ui = {}

---Tab → new groupbox on `side`; groupbox → itself, with a heading once it already holds a Kit section.
function Kit.Ui.Group(target, side, name, icon)
    if type(target.AddLeftGroupbox) ~= "function" then
        if target.KitUsed then
            target:AddSeparatorText(name)
        end
        target.KitUsed = true
        return target
    end
    return side == "Right" and target:AddRightGroupbox(name, icon) or target:AddLeftGroupbox(name, icon)
end

function Kit.Ui.Notify(english, thai, kind)
    Library:Notify("Mario Hub", Kit.T(english, thai), 3, kind or "Info")
end

---Adds the standard Toggle/Hold/Always keybind; touch screens get a floating button instead of a key.
function Kit.Ui.Key(toggle, idx, default)
    toggle:AddKeyPicker(idx, { Default = Platform.Touch and "None" or (default or "None"), Mode = "Toggle", FloatButton = true })
    return toggle
end

---Installs Set/Refresh/Stop/Status on a module with `Features[name] = { Enable, Disable }` and `Active`.
function Kit.Switchable(module)
    module.Active = module.Active or {}

    function module.Set(name, enabled)
        local feature = module.Features[name]
        if not feature then
            Kit.Log:Warn("unknown feature", name)
            return false
        end
        enabled = enabled == true
        if (module.Active[name] == true) == enabled then
            return true
        end
        module.Active[name] = enabled or nil
        if enabled and module.Ready and not module.Ready() then
            return true
        end
        local ok = Util.Try(enabled and feature.Enable or feature.Disable)
        return ok
    end

    function module.Refresh(name)
        local feature = module.Features[name]
        if feature and module.Active[name] and (not module.Ready or module.Ready()) then
            Util.Try(feature.Enable)
        end
    end

    function module.Stop()
        for name in pairs(module.Active) do
            Util.Try(module.Features[name].Disable)
        end
        table.clear(module.Active)
    end

    function module.Status()
        local names = {}
        for name in pairs(module.Active) do
            names[#names + 1] = name
        end
        table.sort(names)
        return #names == 0 and "Idle" or table.concat(names, ", ")
    end

    table.insert(Kit.Modules, module)
    return module
end

function Kit.Cleanup()
    for _, module in ipairs(Kit.Modules) do
        Util.Try(module.Stop)
    end
    Kit.Scheduler.Stop()
    Kit.Arbiter.Stop()
    Kit.Stats.Stop()
    Kit.Override.RestoreAll()
    Util.RestoreAll()
    Kit.Maid:Cleanup()
    Kit.Overlay.Stop()
end

Kit.Lib.Root:Give(Kit.Cleanup)

---@author xDTaraZ  Mario Hub UI V2
Kit.Player = {
    Parts = {},
    CharConns = {},
    RespawnHandlers = {},
    NoclipSaved = {},
    Values = {
        WalkSpeed = Kit.Config.Player.WalkSpeed,
        JumpPower = Kit.Config.Player.JumpPower,
        FlySpeed = Kit.Config.Player.FlySpeed,
    },
}

function Kit.Player.Ensure()
    if Kit.Player.Bound then
        return
    end
    Kit.Player.Bound = true
    if LocalPlayer.Character then
        Kit.Player.Bind(LocalPlayer.Character, false)
    end
    Kit.Connect(LocalPlayer.CharacterAdded, function(char)
        Kit.Player.Bind(char, true)
    end)
end

---@param wait boolean  wait for Humanoid/root (respawn) instead of reading what exists now
function Kit.Player.Bind(char, wait)
    local player = Kit.Player
    player.Character = char
    player.Humanoid, player.Root = nil, nil
    for _, conn in ipairs(player.CharConns) do
        conn:Disconnect()
    end
    table.clear(player.CharConns)
    table.clear(player.Parts)
    table.clear(player.NoclipSaved)
    local timeout = Kit.Config.Player.BindTimeout
    local hum = wait and char:WaitForChild("Humanoid", timeout) or char:FindFirstChildOfClass("Humanoid")
    local root = wait and char:WaitForChild("HumanoidRootPart", timeout) or char:FindFirstChild("HumanoidRootPart")
    if player.Character ~= char or not hum or not root then return end
    player.Humanoid, player.Root = hum, root
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            player.Parts[#player.Parts + 1] = part
        end
    end
    player.CharConns[1] = char.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then
            player.Parts[#player.Parts + 1] = part
        end
    end)
    for name in pairs(player.Active) do
        player.Refresh(name)
    end
    for _, handler in ipairs(player.RespawnHandlers) do
        task.spawn(Util.Try, handler, char, hum, root)
    end
end

---@return function  call to stop listening
function Kit.Player.OnRespawn(handler)
    Kit.Player.Ensure()
    table.insert(Kit.Player.RespawnHandlers, handler)
    return function()
        local index = table.find(Kit.Player.RespawnHandlers, handler)
        if index then
            table.remove(Kit.Player.RespawnHandlers, index)
        end
    end
end

function Kit.Player.Ready()
    Kit.Player.Ensure()
    return Kit.Player.Humanoid ~= nil and Kit.Player.Humanoid.Parent ~= nil
end

function Kit.Player.Alive()
    local hum = Kit.Player.Humanoid
    return hum ~= nil and hum.Parent ~= nil and hum.Health > 0
end

function Kit.Player.SetValue(name, value)
    Kit.Player.Values[name] = value
    if name == "WalkSpeed" or name == "JumpPower" then
        Kit.Player.Refresh(name)
    end
end

function Kit.Player.Typing()
    return UserInputService:GetFocusedTextBox() ~= nil
end

function Kit.Player.KeysDown(names)
    for _, name in ipairs(names) do
        if UserInputService:IsKeyDown(Enum.KeyCode[name]) then
            return true
        end
    end
    return false
end

function Kit.Player.FlyStep()
    local root, hum = Kit.Player.Root, Kit.Player.Humanoid
    if not root or not hum then return end
    local camera = Workspace.CurrentCamera
    local look, right = camera.CFrame.LookVector, camera.CFrame.RightVector
    local move = hum.MoveDirection
    local flatLook = Vector3.new(look.X, 0, look.Z)
    local flatRight = Vector3.new(right.X, 0, right.Z)
    local velocity = Vector3.zero
    if move.Magnitude > 0 and flatLook.Magnitude > 0 and flatRight.Magnitude > 0 then
        velocity = look * move:Dot(flatLook.Unit) + right * move:Dot(flatRight.Unit)
    end
    if not Kit.Player.Typing() then
        local config = Kit.Config.Player
        local vertical = (Kit.Player.KeysDown(config.FlyUp) and 1 or 0) - (Kit.Player.KeysDown(config.FlyDown) and 1 or 0)
        velocity += Vector3.yAxis * vertical
    end
    root.AssemblyLinearVelocity = velocity.Magnitude > 0 and velocity.Unit * Kit.Player.Values.FlySpeed or Vector3.zero
end

function Kit.Player.NoclipStep()
    local saved = Kit.Player.NoclipSaved
    for _, part in ipairs(Kit.Player.Parts) do
        if part.CanCollide and part.Parent then
            if saved[part] == nil then
                saved[part] = true
            end
            part.CanCollide = false
        end
    end
end

function Kit.Player.NoclipRestore()
    for part, collide in pairs(Kit.Player.NoclipSaved) do
        if part.Parent then
            part.CanCollide = collide
        end
    end
    table.clear(Kit.Player.NoclipSaved)
end

function Kit.Player.DownParams()
    local params = Kit.Player.Params
    if not params then
        params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        Kit.Player.Params = params
        Kit.Player.Ignore = {}
    end
    Kit.Player.Ignore[1] = Kit.Player.Character
    Kit.Player.Ignore[2] = Kit.Player.Plate
    params.FilterDescendantsInstances = Kit.Player.Ignore
    return params
end

function Kit.Player.WaterStep()
    local root = Kit.Player.Root
    local plate = Kit.Player.Plate
    if not root or not plate then return end
    if plate.Parent ~= Workspace.CurrentCamera then
        plate.Parent = Workspace.CurrentCamera
    end
    local params = Kit.Player.DownParams()
    params.IgnoreWater = false
    local hit = Workspace:Raycast(root.Position, Vector3.new(0, -Kit.Config.Player.WaterProbe, 0), params)
    if hit and hit.Material == Enum.Material.Water then
        plate.CFrame = CFrame.new(hit.Position - Vector3.new(0, plate.Size.Y / 2, 0))
    else
        plate.CFrame = CFrame.new(0, -1e5, 0)
    end
end

function Kit.Player.FallStep()
    local root = Kit.Player.Root
    if not root then return end
    local config = Kit.Config.Player
    local velocity = root.AssemblyLinearVelocity
    if velocity.Y > config.FallLimit then return end
    local params = Kit.Player.DownParams()
    params.IgnoreWater = true
    if Workspace:Raycast(root.Position, Vector3.new(0, -config.FallProbe, 0), params) then
        root.AssemblyLinearVelocity = Vector3.new(velocity.X, config.FallSoft, velocity.Z)
    end
end

Kit.Player.Features = {
    WalkSpeed = {
        Enable = function()
            Kit.Override.Set("KitWalkSpeed", Kit.Player.Humanoid, "WalkSpeed", Kit.Player.Values.WalkSpeed, true)
        end,
        Disable = function()
            Kit.Override.Restore("KitWalkSpeed")
        end,
    },
    JumpPower = {
        Enable = function()
            local hum = Kit.Player.Humanoid
            local power = Kit.Player.Values.JumpPower
            if hum.UseJumpPower then
                Kit.Override.Set("KitJumpPower", hum, "JumpPower", power, true)
            else
                Kit.Override.Set("KitJumpPower", hum, "JumpHeight", power * power / (2 * Workspace.Gravity), true)
            end
        end,
        Disable = function()
            Kit.Override.Restore("KitJumpPower")
        end,
    },
    Fly = {
        Enable = function()
            Kit.Scheduler.Add("KitFly", Kit.Player.FlyStep, { Lane = "Physics", Priority = 10 })
        end,
        Disable = function()
            Kit.Scheduler.Remove("KitFly")
            local root = Kit.Player.Root
            if root then
                root.AssemblyLinearVelocity = Vector3.zero
            end
        end,
    },
    Noclip = {
        Enable = function()
            Kit.Scheduler.Add("KitNoclip", Kit.Player.NoclipStep, { Lane = "Physics" })
        end,
        Disable = function()
            Kit.Scheduler.Remove("KitNoclip")
            Kit.Player.NoclipRestore()
        end,
    },
    InfJump = {
        Enable = function()
            if Kit.Player.JumpConn then return end
            Kit.Player.JumpConn = Kit.Connect(UserInputService.JumpRequest, function()
                local hum = Kit.Player.Humanoid
                if hum and hum.Health > 0 then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end,
        Disable = function()
            if Kit.Player.JumpConn then
                Kit.Player.JumpConn:Disconnect()
                Kit.Player.JumpConn = nil
            end
        end,
    },
    WalkOnWater = {
        Enable = function()
            if not Kit.Player.Plate then
                local plate = Instance.new("Part")
                plate.Name = "MarioKitPlate"
                plate.Size = Kit.Config.Player.WaterPlate
                plate.Anchored, plate.CanQuery, plate.CanTouch = true, false, false
                plate.Transparency = 1
                plate.CFrame = CFrame.new(0, -1e5, 0)
                plate.Parent = Workspace.CurrentCamera
                Kit.Player.Plate = plate
            end
            Kit.Scheduler.Add("KitWater", Kit.Player.WaterStep, { Lane = "Physics" })
        end,
        Disable = function()
            Kit.Scheduler.Remove("KitWater")
            if Kit.Player.Plate then
                Kit.Player.Plate:Destroy()
                Kit.Player.Plate = nil
            end
        end,
    },
    NoFall = {
        Enable = function()
            Kit.Scheduler.Add("KitNoFall", Kit.Player.FallStep, { Lane = "Physics" })
        end,
        Disable = function()
            Kit.Scheduler.Remove("KitNoFall")
        end,
    },
}

Kit.Switchable(Kit.Player)

function Kit.Player.Build(target)
    local T = Kit.T
    local config = Kit.Config.Player
    local move = Kit.Ui.Group(target, "Left", T("Movement", "การเคลื่อนที่"), "speed")

    Kit.Ui.Key(move:AddToggle("KitWalkSpeed", {
        Text = T("WalkSpeed", "ความเร็วเดิน"), Icon = "speed",
        Callback = function(on) Kit.Player.Set("WalkSpeed", on) end,
    }), "KitWalkSpeedKey")
    move:AddSlider("KitWalkSpeedValue", {
        Text = T("Speed", "ความเร็ว"), Icon = "speed", Min = 16, Max = config.MaxWalkSpeed, Default = config.WalkSpeed, Step = 1,
        Callback = function(value) Kit.Player.SetValue("WalkSpeed", value) end,
    })

    Kit.Ui.Key(move:AddToggle("KitJumpPower", {
        Text = T("JumpPower", "พลังกระโดด"), Icon = "jump",
        Callback = function(on) Kit.Player.Set("JumpPower", on) end,
    }), "KitJumpPowerKey")
    move:AddSlider("KitJumpPowerValue", {
        Text = T("Power", "พลัง"), Icon = "jump", Min = 50, Max = config.MaxJumpPower, Default = config.JumpPower, Step = 1,
        Callback = function(value) Kit.Player.SetValue("JumpPower", value) end,
    })

    Kit.Ui.Key(move:AddToggle("KitFly", {
        Text = T("Fly", "บิน"), Icon = "fly",
        Description = T("Space/E up, Q down", "Space/E ขึ้น, Q ลง"),
        Callback = function(on) Kit.Player.Set("Fly", on) end,
    }), "KitFlyKey", "F")
    move:AddSlider("KitFlySpeed", {
        Text = T("Fly Speed", "ความเร็วบิน"), Icon = "fly", Min = 10, Max = config.MaxFlySpeed, Default = config.FlySpeed, Step = 5,
        Callback = function(value) Kit.Player.SetValue("FlySpeed", value) end,
    })

    Kit.Ui.Key(move:AddToggle("KitNoclip", {
        Text = T("Noclip", "ทะลุกำแพง"), Icon = "noclip",
        Callback = function(on) Kit.Player.Set("Noclip", on) end,
    }), "KitNoclipKey")
    move:AddToggle("KitInfJump", {
        Text = T("Infinite Jump", "กระโดดไม่จำกัด"), Icon = "infjump",
        Callback = function(on) Kit.Player.Set("InfJump", on) end,
    })

    local body = Kit.Ui.Group(target, "Right", T("Character", "ตัวละคร"), "player")
    body:AddToggle("KitWalkOnWater", {
        Text = T("Walk on Water", "เดินบนน้ำ"), Icon = "walkwater",
        Callback = function(on) Kit.Player.Set("WalkOnWater", on) end,
    })
    body:AddToggle("KitNoFall", {
        Text = T("No Fall Damage", "ไม่เจ็บตอนตก"), Icon = "nofall",
        Callback = function(on) Kit.Player.Set("NoFall", on) end,
    })
    body:AddToggle("KitAntiAfk", {
        Text = T("Anti AFK", "กันหลุด AFK"), Icon = "antiafk",
        Callback = function(on)
            if on then Kit.AntiAfk.Start() else Kit.AntiAfk.Stop() end
        end,
    })
    return move, body
end

Kit.World = { Values = { Time = Kit.Config.World.Time }, Effects = {} }

function Kit.World.Lighting()
    return game:GetService("Lighting")
end

function Kit.World.Atmosphere()
    return Kit.World.Lighting():FindFirstChildOfClass("Atmosphere")
end

Kit.World.EffectClasses = { ParticleEmitter = true, Trail = true, Beam = true, Smoke = true, Fire = true, Sparkles = true }

---Turns off particle-style effects a batch at a time so a big map never stalls a frame.
function Kit.World.QuietEffects()
    local batch = Kit.Config.World.ScanBatch
    local list = Workspace:GetDescendants()
    for index, inst in ipairs(list) do
        if not Kit.World.Active.FpsBoost then return end
        if Kit.World.EffectClasses[inst.ClassName] then
            Kit.Override.Set("KitFpsEffects", inst, "Enabled", false, false)
        end
        if index % batch == 0 then
            task.wait()
        end
    end
end

Kit.World.Features = {
    Fullbright = {
        Enable = function()
            local lighting = Kit.World.Lighting()
            local config = Kit.Config.World
            Kit.Override.Set("KitFullbright", lighting, "Brightness", config.Brightness, true)
            Kit.Override.Set("KitFullbright", lighting, "Ambient", config.Ambient, true)
            Kit.Override.Set("KitFullbright", lighting, "OutdoorAmbient", config.Ambient, true)
            Kit.Override.Set("KitFullbright", lighting, "GlobalShadows", false, true)
        end,
        Disable = function()
            Kit.Override.Restore("KitFullbright")
        end,
    },
    NoFog = {
        Enable = function()
            local lighting = Kit.World.Lighting()
            Kit.Override.Set("KitNoFog", lighting, "FogEnd", Kit.Config.World.FogEnd, true)
            local atmosphere = Kit.World.Atmosphere()
            if atmosphere then
                Kit.Override.Set("KitNoFog", atmosphere, "Density", 0, true)
                Kit.Override.Set("KitNoFog", atmosphere, "Haze", 0, true)
            end
        end,
        Disable = function()
            Kit.Override.Restore("KitNoFog")
        end,
    },
    TimeLock = {
        Enable = function()
            Kit.Override.Set("KitTimeLock", Kit.World.Lighting(), "ClockTime", Kit.World.Values.Time, true)
        end,
        Disable = function()
            Kit.Override.Restore("KitTimeLock")
        end,
    },
    FpsBoost = {
        Enable = function()
            local terrain = Workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                Kit.Override.Set("KitFpsBoost", terrain, "Decoration", false, false)
                Kit.Override.Set("KitFpsBoost", terrain, "WaterWaveSize", 0, false)
                Kit.Override.Set("KitFpsBoost", terrain, "WaterReflectance", 0, false)
            end
            for _, effect in ipairs(Kit.World.Lighting():GetChildren()) do
                if effect:IsA("PostEffect") then
                    Kit.Override.Set("KitFpsBoost", effect, "Enabled", false, false)
                end
            end
            Kit.Override.Set("KitFpsBoost", settings().Rendering, "QualityLevel", Enum.QualityLevel.Level01, false)
            task.spawn(Kit.World.QuietEffects)
        end,
        Disable = function()
            Kit.Override.Restore("KitFpsBoost")
            Kit.Override.Restore("KitFpsEffects")
        end,
    },
}

Kit.Switchable(Kit.World)

function Kit.World.SetTime(hour)
    Kit.World.Values.Time = hour
    Kit.World.Refresh("TimeLock")
end

function Kit.World.Build(target)
    local T = Kit.T
    local group = Kit.Ui.Group(target, "Right", T("World", "โลก"), "sun")
    group:AddToggle("KitFullbright", { Text = T("Fullbright", "สว่างทั้งแมพ"), Icon = "fullbright", Callback = function(on) Kit.World.Set("Fullbright", on) end })
    group:AddToggle("KitNoFog", { Text = T("No Fog", "ไม่มีหมอก"), Icon = "fog", Callback = function(on) Kit.World.Set("NoFog", on) end })
    group:AddToggle("KitFpsBoost", {
        Text = T("FPS Boost", "เพิ่ม FPS"), Icon = "fpsboost",
        Description = T("Lower graphics and effects", "ลดกราฟิกและเอฟเฟกต์"),
        Callback = function(on) Kit.World.Set("FpsBoost", on) end,
    })
    group:AddToggle("KitTimeLock", { Text = T("Lock Time", "ล็อกเวลา"), Icon = "clock", Callback = function(on) Kit.World.Set("TimeLock", on) end })
    group:AddSlider("KitTimeValue", {
        Text = T("Time", "เวลา"), Icon = "clock", Min = 0, Max = 24, Default = Kit.Config.World.Time, Step = 0.5, Suffix = "h",
        Callback = Kit.World.SetTime,
    })
    return group
end

---Usable without the UI: `Kit.AntiAfk.Start()` silences the game's own Idled kick handlers and nudges input on idle; `Kit.AntiAfk.Stop()` reconnects them; `Kit.AntiAfk.Status()` → "On"/"Off".
Kit.AntiAfk = { Disabled = {} }

function Kit.AntiAfk.Start()
    if Kit.AntiAfk.Running then
        return
    end
    Kit.AntiAfk.Running = true
    if Kit.Caps.Connections then
        for _, conn in ipairs(Util.GetConnections(LocalPlayer.Idled)) do
            if type(conn.Disable) == "function" and pcall(conn.Disable, conn) then
                table.insert(Kit.AntiAfk.Disabled, conn)
            end
        end
    end
    Kit.AntiAfk.Conn = Kit.Connect(LocalPlayer.Idled, function()
        local virtualUser = game:GetService("VirtualUser")
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.zero)
    end)
end

function Kit.AntiAfk.Stop()
    Kit.AntiAfk.Running = false
    for _, conn in ipairs(Kit.AntiAfk.Disabled) do
        pcall(conn.Enable, conn)
    end
    table.clear(Kit.AntiAfk.Disabled)
    if Kit.AntiAfk.Conn then
        Kit.AntiAfk.Conn:Disconnect()
        Kit.AntiAfk.Conn = nil
    end
end

function Kit.AntiAfk.Status()
    return Kit.AntiAfk.Running and "On" or "Off"
end

table.insert(Kit.Modules, Kit.AntiAfk)

Kit.Server = {}

function Kit.Server.TeleportService()
    return game:GetService("TeleportService")
end

---Script to run again after the next teleport (rejoin/hop); needs queue_on_teleport.
function Kit.Server.Queue(source)
    Kit.Server.Source = source
end

function Kit.Server.Prepare()
    if Kit.Server.Source and Util.QueueOnTeleport then
        pcall(Util.QueueOnTeleport, Kit.Server.Source)
    end
end

function Kit.Server.Rejoin()
    Kit.Server.Prepare()
    local teleport = Kit.Server.TeleportService()
    if #Players:GetPlayers() <= 1 or game.JobId == "" then
        teleport:Teleport(game.PlaceId, LocalPlayer)
    else
        teleport:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end

---@return table?  public servers that still have room, current one excluded
function Kit.Server.List()
    local found, cursor = {}, nil
    for _ = 1, Kit.Config.Server.HopPages do
        local url = Kit.Config.Server.ServersUrl:format(game.PlaceId, cursor and ("&cursor=" .. cursor) or "")
        local body = Util.HttpGet(url)
        local ok, page = pcall(HttpService.JSONDecode, HttpService, body or "")
        if not ok or type(page) ~= "table" or type(page.data) ~= "table" then break end
        for _, server in ipairs(page.data) do
            if server.id ~= game.JobId and tonumber(server.playing) and server.playing < (server.maxPlayers or 0) then
                found[#found + 1] = server
            end
        end
        cursor = page.nextPageCursor
        if not cursor then break end
    end
    return #found > 0 and found or nil
end

---@param mode string?  "Low" (fewest players) or "Random"
---@return boolean  false when no other server was found
function Kit.Server.Hop(mode)
    local servers = Kit.Server.List()
    if not servers then
        Kit.Ui.Notify("No other server found", "ไม่เจอเซิร์ฟอื่น", "Warn")
        return false
    end
    local pick
    if mode == "Random" then
        pick = servers[math.random(#servers)]
    else
        table.sort(servers, function(left, right)
            return left.playing < right.playing
        end)
        pick = servers[1]
    end
    Kit.Server.Prepare()
    local teleport = Kit.Server.TeleportService()
    local ok, err = pcall(teleport.TeleportToPlaceInstance, teleport, game.PlaceId, pick.id, LocalPlayer)
    if not ok then
        Kit.Log:Warn("hop:", err)
    end
    return ok
end

function Kit.Server.Start()
    if Kit.Server.KickConn then
        return
    end
    Kit.Server.KickConn = Kit.Connect(GuiService.ErrorMessageChanged, function(message)
        if message == "" or not Kit.Server.KickConn or Kit.Server.Pending then return end
        Kit.Server.Pending = true
        task.delay(Kit.Config.Server.RejoinDelay, function()
            Kit.Server.Pending = false
            if Kit.Server.KickConn then
                Util.Try(Kit.Server.Rejoin)
            end
        end)
    end)
end

function Kit.Server.Stop()
    if Kit.Server.KickConn then
        Kit.Server.KickConn:Disconnect()
        Kit.Server.KickConn = nil
    end
end

function Kit.Server.Status()
    return Kit.Server.KickConn and "Auto rejoin" or "Idle"
end

table.insert(Kit.Modules, Kit.Server)

function Kit.Server.Build(target)
    local T = Kit.T
    local group = Kit.Ui.Group(target, "Right", T("Server", "เซิร์ฟเวอร์"), "server")
    group:AddToggle("KitAutoRejoin", {
        Text = T("Auto Rejoin", "เข้าใหม่อัตโนมัติ"), Icon = "rejoin",
        Description = T("Rejoins after a kick or disconnect", "เข้าใหม่เองเมื่อโดนเตะหรือหลุด"),
        Callback = function(on)
            if on then Kit.Server.Start() else Kit.Server.Stop() end
        end,
    })
    group:AddDropdown("KitHopMode", {
        Text = T("Hop To", "ย้ายไป"), Icon = "hop",
        Values = { "Low", "Random" },
        Default = "Low",
    })
    group:AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Icon = "hop" }, function()
        local mode = Library.Options.KitHopMode and Library.Options.KitHopMode.Value
        task.spawn(Kit.Server.Hop, mode)
    end):AddButton({ Text = T("Rejoin", "เข้าใหม่"), Icon = "rejoin" }, Kit.Server.Rejoin)
    group:AddButton({ Text = T("Copy Job ID", "คัดลอก Job ID"), Icon = "copy" }, function()
        if not Util.Clipboard(game.JobId) then
            Kit.Ui.Notify(game.JobId, game.JobId)
        end
    end)
    return group
end

---@author xDTaraZ  Mario Hub UI V2
Kit.Esp = {
    Categories = {},
    Order = {},
    Entries = {},
    Pool = {},
    Seen = {},
    Running = false,
    Highlights = 0,
    Listeners = {},
    Settings = {
        Show = { Name = true, Distance = true },
        MaxDistance = Kit.Config.Esp.MaxDistance,
        TeamCheck = false,
        TeamColor = false,
        TextSize = Kit.Config.Esp.TextSize,
        Rate = Kit.Config.Esp.Rate,
    },
}

---@param spec table  { Text, Color, Source = fn() -> Instances|Players | Folder | { Tag = "x" }, Label = fn(model) -> string? }
function Kit.Esp.AddCategory(name, spec)
    spec = spec or {}
    if not Kit.Esp.Categories[name] then
        table.insert(Kit.Esp.Order, name)
    end
    Kit.Esp.Categories[name] = {
        Name = name,
        Text = spec.Text or name,
        Color = spec.Color or Color3.fromRGB(255, 255, 255),
        Source = spec.Source,
        Label = spec.Label,
        Enabled = spec.Enabled == true,
    }
    return Kit.Esp.Categories[name]
end

---Runs fn() after any look change (settings, category toggle or color).
function Kit.Esp.OnChanged(fn)
    table.insert(Kit.Esp.Listeners, fn)
end

function Kit.Esp.Changed()
    for _, listener in ipairs(Kit.Esp.Listeners) do
        Util.Try(listener)
    end
end

function Kit.Esp.PlayerSource()
    return Players:GetPlayers()
end

function Kit.Esp.SetCategory(name, enabled)
    local category = Kit.Esp.Categories[name]
    if category then
        category.Enabled = enabled == true
    end
    Kit.Esp.Changed()
end

function Kit.Esp.SetColor(name, color)
    local category = Kit.Esp.Categories[name]
    if category then
        category.Color = color
    end
    Kit.Esp.Changed()
end

function Kit.Esp.Set(key, value)
    Kit.Esp.Settings[key] = value
    if key == "Rate" then
        Kit.Scheduler.SetInterval("KitEspScan", value)
    end
    Kit.Esp.Changed()
end

function Kit.Esp.Gather(category)
    local source = category.Source
    if type(source) == "function" then
        local ok, list = pcall(source)
        return ok and type(list) == "table" and list or {}
    end
    if typeof(source) == "Instance" then
        return source:GetChildren()
    end
    if type(source) == "table" and source.Tag then
        return game:GetService("CollectionService"):GetTagged(source.Tag)
    end
    return type(source) == "table" and source or {}
end

---@return Instance? model, Player? player
function Kit.Esp.Resolve(target)
    if typeof(target) ~= "Instance" then
        return nil
    end
    if target:IsA("Player") then
        if target == LocalPlayer then return nil end
        return target.Character, target
    end
    if target:IsA("Model") or target:IsA("BasePart") then
        return target, Players:GetPlayerFromCharacter(target)
    end
    return nil
end

function Kit.Esp.Anchor(model)
    if model:IsA("BasePart") then
        return model
    end
    return model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
end

function Kit.Esp.Hostile(player)
    if not player or not Kit.Esp.Settings.TeamCheck then
        return true
    end
    return player.Team == nil or player.Team ~= LocalPlayer.Team
end

function Kit.Esp.Start()
    if Kit.Esp.Running then
        return
    end
    Kit.Esp.Running = true
    Kit.Esp.Mode = Kit.Caps.Drawing and "Drawing" or "Gui"
    Kit.Scheduler.Add("KitEspScan", Kit.Esp.Scan, { Interval = Kit.Esp.Settings.Rate })
    if Kit.Esp.Mode == "Drawing" then
        Kit.Scheduler.Add("KitEspDraw", Kit.Esp.Draw, { Lane = "Render", Priority = -10 })
    end
end

function Kit.Esp.Stop()
    Kit.Esp.Running = false
    Kit.Scheduler.Remove("KitEspScan")
    Kit.Scheduler.Remove("KitEspDraw")
    for model, entry in pairs(Kit.Esp.Entries) do
        Kit.Esp.Release(entry)
        Kit.Esp.Entries[model] = nil
    end
    for _, entry in ipairs(Kit.Esp.Pool) do
        Kit.Esp.Destroy(entry)
    end
    table.clear(Kit.Esp.Pool)
end

function Kit.Esp.Status()
    local count = 0
    for _ in pairs(Kit.Esp.Entries) do
        count += 1
    end
    return Kit.Esp.Running and (count .. " shown") or "Off"
end

function Kit.Esp.NewVisuals()
    if Kit.Esp.Mode == "Drawing" then
        local box = Drawing.new("Square")
        box.Thickness, box.Filled = 1, false
        local tracer = Drawing.new("Line")
        tracer.Thickness = 1
        local label = Drawing.new("Text")
        label.Center, label.Outline = true, true
        return { Mode = "Drawing", Box = box, Tracer = tracer, Label = label }
    end
    local billboard = Instance.new("BillboardGui")
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.fromOffset(200, 36)
    billboard.StudsOffset = Vector3.new(0, Kit.Config.Esp.LabelOffset, 0)
    billboard.Enabled = false
    local text = Instance.new("TextLabel")
    text.BackgroundTransparency = 1
    text.Size = UDim2.fromScale(1, 1)
    text.Font = Enum.Font.GothamBold
    text.TextStrokeTransparency = Kit.Config.Esp.TextStroke
    text.Parent = billboard
    billboard.Parent = Kit.Overlay.Folder()
    local highlight = Instance.new("Highlight")
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = Kit.Config.Esp.HighlightFill
    highlight.Enabled = false
    highlight.Parent = Kit.Overlay.Folder()
    return { Mode = "Gui", Billboard = billboard, Text = text, Highlight = highlight }
end

function Kit.Esp.Acquire(model)
    local pool = Kit.Esp.Pool
    local entry = table.remove(pool)
    while entry and entry.Mode ~= Kit.Esp.Mode do
        Kit.Esp.Destroy(entry)
        entry = table.remove(pool)
    end
    entry = entry or Kit.Esp.NewVisuals()
    entry.Model = model
    entry.Humanoid = model:FindFirstChildOfClass("Humanoid")
    local size = model:IsA("Model") and model:GetExtentsSize() or model.Size
    entry.Size = Vector2.new(math.max(size.X, 1), math.max(size.Y, Kit.Config.Esp.MinHeight))
    if entry.Mode == "Gui" then
        entry.Billboard.Adornee = model
        entry.Billboard.Enabled = true
    end
    return entry
end

function Kit.Esp.Hide(entry)
    if entry.Mode == "Drawing" then
        Kit.Esp.Show(entry, false, false, false)
        return
    end
    entry.Billboard.Enabled = false
    if entry.Highlight.Enabled then
        entry.Highlight.Enabled = false
        Kit.Esp.Highlights -= 1
    end
end

---Writes Drawing visibility only when it changes; each write crosses the executor bridge.
function Kit.Esp.Show(entry, box, label, tracer)
    local shown = entry.Shown
    if not shown then
        shown = {}
        entry.Shown = shown
    end
    if shown.Box ~= box then
        shown.Box, entry.Box.Visible = box, box
    end
    if shown.Label ~= label then
        shown.Label, entry.Label.Visible = label, label
    end
    if shown.Tracer ~= tracer then
        shown.Tracer, entry.Tracer.Visible = tracer, tracer
    end
end

function Kit.Esp.Release(entry)
    Kit.Esp.Hide(entry)
    if entry.Mode == "Gui" then
        entry.Billboard.Adornee, entry.Highlight.Adornee = nil, nil
    end
    entry.Model, entry.Part, entry.Humanoid, entry.Player = nil, nil, nil, nil
    table.insert(Kit.Esp.Pool, entry)
end

function Kit.Esp.Destroy(entry)
    if entry.Mode == "Drawing" then
        for _, key in ipairs({ "Box", "Tracer", "Label" }) do
            local object = entry[key]
            local remove = object.Remove or object.Destroy
            pcall(remove, object)
        end
        return
    end
    entry.Billboard:Destroy()
    entry.Highlight:Destroy()
end

function Kit.Esp.Caption(entry, distance)
    local show = Kit.Esp.Settings.Show
    local parts = {}
    if show.Name then
        local category, model = entry.Category, entry.Model
        local custom
        if category.Label then
            local ok, text = Util.Try(category.Label, model)
            custom = ok and type(text) == "string" and text or nil
        end
        parts[#parts + 1] = custom or (entry.Player and entry.Player.DisplayName) or model.Name
    end
    if show.Distance then
        parts[#parts + 1] = "[" .. math.floor(distance) .. "m]"
    end
    local hum = entry.Humanoid
    if show.Health and hum and hum.Parent then
        parts[#parts + 1] = math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
    end
    return table.concat(parts, " ")
end

function Kit.Esp.Paint(entry, distance)
    local tuning = Kit.Esp.Settings
    local player = entry.Player
    local color = tuning.TeamColor and player and player.Team and player.TeamColor.Color or entry.Category.Color
    local caption = Kit.Esp.Caption(entry, distance)
    if entry.Mode == "Drawing" then
        entry.Label.Text, entry.Label.Color, entry.Label.Size = caption, color, tuning.TextSize
        entry.Box.Color, entry.Tracer.Color = color, color
        return
    end
    entry.Text.Text, entry.Text.TextColor3, entry.Text.TextSize = caption, color, tuning.TextSize
    entry.Text.Visible = caption ~= ""
    local highlight = entry.Highlight
    local wantBox = tuning.Show.Box == true
    if wantBox and not highlight.Enabled and Kit.Esp.Highlights < Kit.Config.Esp.HighlightCap then
        highlight.Adornee, highlight.Enabled = entry.Model, true
        Kit.Esp.Highlights += 1
    elseif not wantBox and highlight.Enabled then
        highlight.Enabled = false
        Kit.Esp.Highlights -= 1
    end
    highlight.OutlineColor, highlight.FillColor = color, color
end

function Kit.Esp.Track(category, target, origin, seen)
    local model, player = Kit.Esp.Resolve(target)
    if not model or seen[model] or not Kit.Esp.Hostile(player) then return end
    local part = Kit.Esp.Anchor(model)
    if not part then return end
    local distance = (part.Position - origin).Magnitude
    if distance > Kit.Esp.Settings.MaxDistance then return end
    seen[model] = true
    local entry = Kit.Esp.Entries[model]
    if not entry then
        entry = Kit.Esp.Acquire(model)
        Kit.Esp.Entries[model] = entry
    end
    entry.Part, entry.Player, entry.Category = part, player, category
    Kit.Esp.Paint(entry, distance)
end

function Kit.Esp.Scan()
    local camera = Workspace.CurrentCamera
    if not camera then return end
    local origin = camera.CFrame.Position
    local seen = Kit.Esp.Seen
    table.clear(seen)
    for _, name in ipairs(Kit.Esp.Order) do
        local category = Kit.Esp.Categories[name]
        if not category.Enabled then continue end
        for _, target in ipairs(Kit.Esp.Gather(category)) do
            Kit.Esp.Track(category, target, origin, seen)
        end
    end
    for model, entry in pairs(Kit.Esp.Entries) do
        if not seen[model] then
            Kit.Esp.Release(entry)
            Kit.Esp.Entries[model] = nil
        end
    end
end

function Kit.Esp.Draw()
    local camera = Workspace.CurrentCamera
    if not camera then return end
    local viewport = camera.ViewportSize
    local show = Kit.Esp.Settings.Show
    local focal = viewport.Y / (2 * math.tan(math.rad(camera.FieldOfView / 2)))
    local tracerFrom = Vector2.new(viewport.X / 2, viewport.Y)
    for _, entry in pairs(Kit.Esp.Entries) do
        local part = entry.Part
        if not part or not part.Parent then
            Kit.Esp.Hide(entry)
            continue
        end
        local point, onScreen = camera:WorldToViewportPoint(part.Position)
        if not onScreen then
            Kit.Esp.Hide(entry)
            continue
        end
        local box, label, tracer = show.Box == true, entry.Label.Text ~= "", show.Tracer == true
        local scale = focal / point.Z
        local width, height = entry.Size.X * scale, entry.Size.Y * scale
        local top = point.Y - height / 2
        if box then
            entry.Box.Position, entry.Box.Size = Vector2.new(point.X - width / 2, top), Vector2.new(width, height)
        end
        if label then
            entry.Label.Position = Vector2.new(point.X, top - entry.Label.Size - 2)
        end
        if tracer then
            entry.Tracer.From, entry.Tracer.To = tracerFrom, Vector2.new(point.X, top + height)
        end
        Kit.Esp.Show(entry, box, label, tracer)
    end
end

function Kit.Esp.Defaults()
    local config = Kit.Config.Esp
    local touch = Platform.Touch
    Kit.Esp.Settings.Rate = touch and config.TouchRate or config.Rate
    Kit.Esp.Settings.MaxDistance = touch and config.TouchMaxDistance or config.MaxDistance
    Kit.Esp.Settings.TextSize = touch and config.TouchTextSize or config.TextSize
end

table.insert(Kit.Modules, Kit.Esp)

function Kit.Esp.Id(name)
    return "KitEsp" .. tostring(name):gsub("[^%w]", "")
end

---@param options table?  { Categories = { { Name, Text, Color, Source, Label } }, Players = true }
function Kit.Esp.Build(target, options)
    options = options or {}
    local T = Kit.T
    Kit.Esp.Defaults()
    if options.Players ~= false and not Kit.Esp.Categories.Players then
        Kit.Esp.AddCategory("Players", { Text = T("Players", "ผู้เล่น"), Color = Color3.fromRGB(240, 92, 80), Source = Kit.Esp.PlayerSource })
    end
    for _, spec in ipairs(options.Categories or {}) do
        Kit.Esp.AddCategory(spec.Name, spec)
    end
    local tuning = Kit.Esp.Settings
    local main = Kit.Ui.Group(target, "Left", T("ESP", "ESP"), "eye")
    Kit.Ui.Key(main:AddToggle("KitEsp", {
        Text = T("ESP", "มองทะลุ"),
        Callback = function(on)
            if on then Kit.Esp.Start() else Kit.Esp.Stop() end
        end,
    }), "KitEspKey")
    for _, name in ipairs(Kit.Esp.Order) do
        local category = Kit.Esp.Categories[name]
        local id = Kit.Esp.Id(name)
        main:AddToggle(id, {
            Text = category.Text,
            Callback = function(on) Kit.Esp.SetCategory(name, on) end,
        }):AddColorPicker(id .. "Color", {
            Default = category.Color,
            Callback = function(color) Kit.Esp.SetColor(name, color) end,
        })
    end

    local look = Kit.Ui.Group(target, "Right", T("ESP Settings", "ตั้งค่า ESP"), "sliders-horizontal")
    local show = look:AddDropdown("KitEspShow", {
        Text = T("Show", "แสดง"),
        Values = { "Name", "Distance", "Health", "Box", "Tracer" },
        Multi = true,
        Default = { "Name", "Distance" },
        Callback = function(value)
            if value.Tracer and not Kit.Caps.Drawing then
                Kit.Ui.Notify("Tracers are not supported on this executor", "เส้นชี้ใช้กับ executor นี้ไม่ได้", "Warn")
            end
            tuning.Show = value
            Kit.Esp.Changed()
        end,
    })
    tuning.Show = show.Value
    look:AddToggle("KitEspTeamCheck", { Text = T("Team Check", "ไม่แสดงทีมเดียวกัน"), Callback = function(on) tuning.TeamCheck = on end })
    look:AddToggle("KitEspTeamColor", { Text = T("Team Colors", "ใช้สีทีม"), Callback = function(on) tuning.TeamColor = on Kit.Esp.Changed() end })
    look:AddSlider("KitEspDistance", {
        Text = T("Max Distance", "ระยะสูงสุด"), Min = 50, Max = 5000, Step = 50, Default = tuning.MaxDistance, Suffix = "m",
        Callback = function(value) Kit.Esp.Set("MaxDistance", value) end,
    })
    look:AddSlider("KitEspTextSize", {
        Text = T("Text Size", "ขนาดตัวอักษร"), Min = 8, Max = 24, Step = 1, Default = tuning.TextSize,
        Callback = function(value) Kit.Esp.Set("TextSize", value) end,
    })
    look:AddSlider("KitEspRate", {
        Text = T("Update Rate", "อัปเดตทุก"), Min = 0.05, Max = 2, Step = 0.05, Default = tuning.Rate, Suffix = "s",
        Callback = function(value) Kit.Esp.Set("Rate", value) end,
    })
    return main, look
end

Kit.Aim = {
    Players = {},
    Ignore = {},
    Parts = { Head = { "Head" }, Torso = { "UpperTorso", "Torso", "HumanoidRootPart" }, Root = { "HumanoidRootPart" } },
    Aimbot = {
        Settings = {
            Enabled = false, Part = "Head", Priority = "Crosshair", VisibleOnly = false, TeamCheck = false,
            Fov = Kit.Config.Aim.Fov, ShowFov = true, FovColor = Kit.Config.Aim.AimbotColor,
            Smoothness = Kit.Config.Aim.Smoothness, Sticky = false, MaxDistance = Kit.Config.Aim.MaxDistance,
        },
    },
    Silent = {
        Settings = {
            Enabled = false, HitChance = Kit.Config.Aim.HitChance, HeadChance = Kit.Config.Aim.HeadChance, Priority = "Crosshair", VisibleOnly = false, TeamCheck = false,
            Fov = Kit.Config.Aim.SilentFov, ShowFov = true, FovColor = Kit.Config.Aim.SilentColor, MaxDistance = Kit.Config.Aim.MaxDistance,
            Method = "Both",
        },
    },
    Trigger = {
        Settings = { Enabled = false, Delay = Kit.Config.Aim.TriggerDelay, Chance = Kit.Config.Aim.HitChance, TeamCheck = false, MaxDistance = Kit.Config.Aim.MaxDistance },
    },
    Rage = {
        Settings = {
            Enabled = false, Part = "Head", Priority = "Distance", VisibleOnly = false, TeamCheck = false,
            MaxDistance = Kit.Config.Aim.MaxDistance, FireGap = Kit.Config.Aim.RageGap,
        },
    },
}

function Kit.Aim.Track()
    if Kit.Aim.Tracking then
        return
    end
    Kit.Aim.Tracking = true
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(Kit.Aim.Players, player)
        end
    end
    Kit.Connect(Players.PlayerAdded, function(player)
        table.insert(Kit.Aim.Players, player)
    end)
    Kit.Connect(Players.PlayerRemoving, function(player)
        local index = table.find(Kit.Aim.Players, player)
        if index then
            table.remove(Kit.Aim.Players, index)
        end
    end)
end

function Kit.Aim.Center()
    local camera = Workspace.CurrentCamera
    if Platform.Touch or UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        return camera.ViewportSize / 2
    end
    return UserInputService:GetMouseLocation()
end

function Kit.Aim.Params()
    local params = Kit.Aim.RayParams
    if not params then
        params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.IgnoreWater = true
        Kit.Aim.RayParams = params
    end
    Kit.Aim.Ignore[1] = LocalPlayer.Character
    Kit.Aim.Ignore[2] = Workspace.CurrentCamera
    params.FilterDescendantsInstances = Kit.Aim.Ignore
    return params
end

function Kit.Aim.Visible(part, char)
    local origin = Workspace.CurrentCamera.CFrame.Position
    local hit = Workspace:Raycast(origin, part.Position - origin, Kit.Aim.Params())
    return hit == nil or hit.Instance:IsDescendantOf(char)
end

function Kit.Aim.PickPart(char, kind)
    for _, name in ipairs(Kit.Aim.Parts[kind] or Kit.Aim.Parts.Head) do
        local part = char:FindFirstChild(name)
        if part then
            return part
        end
    end
    return nil
end

function Kit.Aim.Hostile(tuning, player)
    if not tuning.TeamCheck then
        return true
    end
    return player.Team == nil or player.Team ~= LocalPlayer.Team
end

---@return number?  lower is better; nil when the player isn't a valid target
function Kit.Aim.Score(tuning, player, center, camera)
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 or not Kit.Aim.Hostile(tuning, player) then return nil end
    local part = Kit.Aim.PickPart(char, tuning.Part or "Head")
    if not part then return nil end
    local distance = (part.Position - camera.CFrame.Position).Magnitude
    if distance > tuning.MaxDistance then return nil end
    local point, onScreen = camera:WorldToViewportPoint(part.Position)
    if not onScreen and tuning.Fov then return nil end
    local offset = (Vector2.new(point.X, point.Y) - center).Magnitude
    if tuning.Fov and offset > tuning.Fov then return nil end
    if tuning.VisibleOnly and not Kit.Aim.Visible(part, char) then return nil end
    if tuning.Priority == "Distance" then
        return distance, part
    elseif tuning.Priority == "Health" then
        return hum.Health, part
    end
    return offset, part
end

---@return Player?, BasePart?
function Kit.Aim.Find(tuning, sticky)
    local camera = Workspace.CurrentCamera
    local center = Kit.Aim.Center()
    if sticky and sticky.Parent then
        local score, part = Kit.Aim.Score(tuning, sticky, center, camera)
        if score then
            return sticky, part
        end
    end
    local bestPlayer, bestPart, bestScore = nil, nil, math.huge
    for _, player in ipairs(Kit.Aim.Players) do
        local score, part = Kit.Aim.Score(tuning, player, center, camera)
        if score and score < bestScore then
            bestPlayer, bestPart, bestScore = player, part, score
        end
    end
    return bestPlayer, bestPart
end

---Without a bound key a system fires only when its Settings.KeyMode is "Always".
function Kit.Aim.KeyDown(system)
    local key = system.Key
    if not key or type(key.GetState) ~= "function" then
        return system.Settings.KeyMode == "Always"
    end
    return key:GetState() == true
end

function Kit.Aim.Circle(system)
    local circle = system.Circle
    if circle then
        return circle
    end
    if Kit.Caps.Drawing then
        circle = Drawing.new("Circle")
        circle.Thickness, circle.NumSides, circle.Filled, circle.Transparency = 1.5, Kit.Config.Aim.CircleSides, false, 1
        system.Circle = { Drawing = circle }
        return system.Circle
    end
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = frame
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.5
    stroke.Parent = frame
    frame.Parent = Kit.Overlay.Screen()
    system.Circle = { Frame = frame, Stroke = stroke }
    return system.Circle
end

function Kit.Aim.DrawCircle(system, visible)
    local tuning = system.Settings
    if not visible and not system.Circle then return end
    local circle = Kit.Aim.Circle(system)
    local center = Kit.Aim.Center()
    if circle.Drawing then
        local drawing = circle.Drawing
        drawing.Visible, drawing.Position, drawing.Radius, drawing.Color = visible, center, tuning.Fov, tuning.FovColor
        return
    end
    circle.Frame.Visible = visible
    circle.Frame.Position = UDim2.fromOffset(center.X, center.Y)
    circle.Frame.Size = UDim2.fromOffset(tuning.Fov * 2, tuning.Fov * 2)
    circle.Stroke.Color = tuning.FovColor
end

function Kit.Aim.DropCircle(system)
    local circle = system.Circle
    if not circle then return end
    system.Circle = nil
    if circle.Drawing then
        local remove = circle.Drawing.Remove or circle.Drawing.Destroy
        pcall(remove, circle.Drawing)
    else
        circle.Frame:Destroy()
    end
end

function Kit.Aim.AimbotStep(deltaTime)
    local system = Kit.Aim.Aimbot
    local tuning = system.Settings
    Kit.Aim.DrawCircle(system, tuning.ShowFov)
    if not Kit.Aim.KeyDown(system) then
        system.Target = nil
        return
    end
    local player, part = Kit.Aim.Find(tuning, tuning.Sticky and system.Target or nil)
    system.Target = player
    if not part then return end
    local camera = Workspace.CurrentCamera
    local goal = CFrame.lookAt(camera.CFrame.Position, part.Position)
    local alpha = tuning.Smoothness <= 0 and 1 or 1 - tuning.Smoothness ^ (deltaTime * 60)
    camera.CFrame = camera.CFrame:Lerp(goal, math.clamp(alpha, 0, 1))
end

function Kit.Aim.SilentStep()
    local system = Kit.Aim.Silent
    local tuning = system.Settings
    Kit.Aim.DrawCircle(system, tuning.ShowFov)
    system.Shot = nil
    if not Kit.Aim.KeyDown(system) then return end
    local player = Kit.Aim.Find(tuning, nil)
    if not player or math.random(100) > tuning.HitChance then return end
    local kind = math.random(100) <= tuning.HeadChance and "Head" or "Torso"
    system.Shot = Kit.Aim.PickPart(player.Character, kind)
end

function Kit.Aim.FromShooter(origin)
    local camera = Workspace.CurrentCamera
    local root = Kit.Player.Root
    local radius = Kit.Config.Aim.ShotRadius
    return (origin - camera.CFrame.Position).Magnitude <= radius or (root ~= nil and (origin - root.Position).Magnitude <= radius)
end

---Bends only shot-like rays: long, starting at the camera or the character.
function Kit.Aim.Redirect(origin, direction)
    local shot = Kit.Aim.Silent.Shot
    if not shot or not shot.Parent or typeof(origin) ~= "Vector3" or typeof(direction) ~= "Vector3" then return nil end
    if direction.Magnitude < Kit.Config.Aim.MinRay or not Kit.Aim.FromShooter(origin) then return nil end
    return (shot.Position - origin).Unit * direction.Magnitude
end

---@return Ray?  the bent ray, nil when it isn't a shot
function Kit.Aim.RedirectRay(ray)
    if typeof(ray) ~= "Ray" then return nil end
    local bent = Kit.Aim.Redirect(ray.Origin, ray.Direction)
    return bent and Ray.new(ray.Origin, bent) or nil
end

Kit.Aim.RayMethods = { FindPartOnRay = true, FindPartOnRayWithIgnoreList = true, FindPartOnRayWithWhitelist = true }

---Hooks one C function in place; restored on unload or by the returned restore.
---@return function?  original, nil if the executor refused
---@return function?  restore
function Kit.Aim.HookExact(target, handler)
    local api = Util
    local wrapped = api.NewCClosure and api.NewCClosure(handler) or handler
    local ok, original = pcall(api.HookFunction, target, wrapped)
    if not ok or type(original) ~= "function" then return nil end
    local function putBack()
        api.Unhook(target, function()
            pcall(api.HookFunction, target, original)
        end)
    end
    table.insert(api.Restores, putBack)
    return original, function()
        local index = table.find(api.Restores, putBack)
        if not index then return end
        table.remove(api.Restores, index)
        putBack()
    end
end

function Kit.Aim.Bypass()
    local checkCaller = Util.CheckCaller
    return Kit.Aim.Silent.Shot == nil or (checkCaller ~= nil and checkCaller())
end

---Direct calls and cached method references (`local cast = workspace.Raycast`) never pass __namecall.
function Kit.Aim.HookRayFunctions(unhooks)
    local original
    original, unhooks[#unhooks + 1] = Kit.Aim.HookExact(Workspace.Raycast, function(self, origin, direction, ...)
        local bent = self == Workspace and not Kit.Aim.Bypass() and Kit.Aim.Redirect(origin, direction)
        if bent then
            return original(self, origin, bent, ...)
        end
        return original(self, origin, direction, ...)
    end)
    for method in pairs(Kit.Aim.RayMethods) do
        local legacy
        legacy, unhooks[#unhooks + 1] = Kit.Aim.HookExact(Workspace[method], function(self, ray, ...)
            local bent = self == Workspace and not Kit.Aim.Bypass() and Kit.Aim.RedirectRay(ray)
            return legacy(self, bent or ray, ...)
        end)
    end
    return original ~= nil
end

---`workspace:Raycast()` dispatches by name, so a hooked C function can't see it; this exits on the first compare for anything but Workspace.
function Kit.Aim.HookRayNamecall(unhooks)
    local api = Util
    local namecall
    namecall, unhooks[#unhooks + 1] = api.HookMeta(game, "__namecall", function(self, ...)
        if self ~= Workspace or Kit.Aim.Bypass() then
            return namecall(self, ...)
        end
        local method = api.GetNamecallMethod()
        if method == "Raycast" then
            local origin, direction = ...
            local bent = Kit.Aim.Redirect(origin, direction)
            if bent then
                return namecall(self, origin, bent, select(3, ...))
            end
        elseif Kit.Aim.RayMethods[method] then
            local bent = Kit.Aim.RedirectRay((...))
            if bent then
                return namecall(self, bent, select(2, ...))
            end
        end
        return namecall(self, ...)
    end)
    return namecall ~= nil
end

---Mouse.Hit/Target are properties, readable only through __index; the handler lets every other object through on the first compare.
function Kit.Aim.HookMouse(unhooks)
    local mouse = LocalPlayer:GetMouse()
    local index
    index, unhooks[#unhooks + 1] = Util.HookMeta(game, "__index", function(self, key)
        if self ~= mouse or (key ~= "Hit" and key ~= "Target") or Kit.Aim.Bypass() then
            return index(self, key)
        end
        local shot = Kit.Aim.Silent.Shot
        return key == "Hit" and CFrame.new(shot.Position) or shot
    end)
    return index ~= nil
end

---Installs only what the chosen Method needs, and only while Silent Aim is on.
function Kit.Aim.InstallSilent()
    local system = Kit.Aim.Silent
    if system.Installed then return true end
    if not Kit.Caps.Hook then return false end
    local method = system.Settings.Method
    local unhooks = {}
    local hooked = false
    if method ~= "Mouse" then
        local direct = Kit.Aim.HookRayFunctions(unhooks)
        hooked = Kit.Aim.HookRayNamecall(unhooks) or direct
    end
    if method ~= "Raycast" then
        hooked = Kit.Aim.HookMouse(unhooks) or hooked
    end
    system.Unhooks, system.Installed = unhooks, hooked
    if not hooked then
        Kit.Aim.RemoveSilent()
    end
    return hooked
end

function Kit.Aim.RemoveSilent()
    local system = Kit.Aim.Silent
    for _, unhook in pairs(system.Unhooks or {}) do
        unhook()
    end
    system.Unhooks, system.Installed = nil, false
end

function Kit.Aim.SetSilentMethod(method)
    local system = Kit.Aim.Silent
    system.Settings.Method = method
    if not system.Installed then return end
    Kit.Aim.RemoveSilent()
    Kit.Aim.InstallSilent()
end

---@param preferTool boolean?  activate the held tool first, mouse click only as fallback
function Kit.Aim.Click(preferTool)
    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool")
    local canClick = Util.MouseClick ~= nil and not Platform.Touch
    if tool and (preferTool or not canClick) then
        tool:Activate()
    elseif canClick then
        Util.MouseClick()
    end
end

function Kit.Aim.TriggerStep()
    local system = Kit.Aim.Trigger
    local tuning = system.Settings
    if not Kit.Aim.KeyDown(system) then
        system.Since = nil
        return
    end
    local camera = Workspace.CurrentCamera
    local center = Kit.Aim.Center()
    local ray = camera:ViewportPointToRay(center.X, center.Y)
    local hit = Workspace:Raycast(ray.Origin, ray.Direction * tuning.MaxDistance, Kit.Aim.Params())
    local model = hit and hit.Instance:FindFirstAncestorOfClass("Model")
    local player = model and Players:GetPlayerFromCharacter(model)
    local hum = model and model:FindFirstChildOfClass("Humanoid")
    if not player or not hum or hum.Health <= 0 or not Kit.Aim.Hostile(tuning, player) then
        system.Since = nil
        return
    end
    local now = os.clock()
    system.Since = system.Since or now
    if now - system.Since < tuning.Delay or now < (system.Next or 0) then return end
    system.Next = now + Kit.Config.Aim.TriggerGap
    if math.random(100) <= tuning.Chance then
        Kit.Aim.Click()
    end
end

---Snaps to the best target anywhere in range (no FOV) and fires the held weapon.
function Kit.Aim.RageStep()
    local system = Kit.Aim.Rage
    local tuning = system.Settings
    if not Kit.Aim.KeyDown(system) then
        system.Target = nil
        return
    end
    local player, part = Kit.Aim.Find(tuning, system.Target)
    system.Target = player
    if not part then return end
    local camera = Workspace.CurrentCamera
    camera.CFrame = CFrame.lookAt(camera.CFrame.Position, part.Position)
    local now = os.clock()
    if now < (system.Next or 0) then return end
    system.Next = now + tuning.FireGap
    Kit.Aim.Click(true)
end

Kit.Aim.Steps = { Aimbot = Kit.Aim.AimbotStep, Silent = Kit.Aim.SilentStep, Trigger = Kit.Aim.TriggerStep, Rage = Kit.Aim.RageStep }

---@param which string  "Aimbot" | "Silent" | "Trigger" | "Rage"
---@return boolean  false when the executor can't run it
function Kit.Aim.Set(which, enabled)
    local system = Kit.Aim[which]
    if not system then
        return false
    end
    local job = "KitAim" .. which
    system.Settings.Enabled = enabled == true
    if not enabled then
        Kit.Scheduler.Remove(job)
        system.Target, system.Shot, system.Since = nil, nil, nil
        Kit.Aim.DropCircle(system)
        if which == "Silent" then
            Kit.Aim.RemoveSilent()
        end
        return true
    end
    if which == "Silent" and not Kit.Aim.InstallSilent() then
        system.Settings.Enabled = false
        return false
    end
    Kit.Aim.Track()
    Kit.Player.Ensure()
    Kit.Scheduler.Add(job, Kit.Aim.Steps[which], { Lane = "Render", Priority = 5 })
    return true
end

function Kit.Aim.Stop()
    for which in pairs(Kit.Aim.Steps) do
        Kit.Aim.Set(which, false)
    end
end

function Kit.Aim.Status()
    local on = {}
    for _, which in ipairs({ "Aimbot", "Silent", "Trigger", "Rage" }) do
        if Kit.Aim[which].Settings.Enabled then
            on[#on + 1] = which
        end
    end
    return #on == 0 and "Off" or table.concat(on, ", ")
end

table.insert(Kit.Modules, Kit.Aim)

function Kit.Aim.Bind(system, option)
    return function(value)
        system.Settings[option] = value
    end
end

---Common rows for a targeting system: toggle + aim key + who to target.
function Kit.Aim.BuildBase(group, which, text, extra)
    local T = Kit.T
    local system = Kit.Aim[which]
    local tuning = system.Settings
    local id = "Kit" .. which
    local toggle = group:AddToggle(id, { Text = text, Risky = extra and extra.Risky, Callback = function(on) Kit.Aim.Set(which, on) end })
    if extra and extra.Cap then
        Kit.Caps.NeedCap(toggle, extra.Cap)
    end
    system.Key = group:AddKeybind(id .. "Key", {
        Text = T("Aim Key", "ปุ่มเล็ง"),
        Default = "None",
        Mode = "Always",
        FloatButton = true,
    })
    group:AddToggle(id .. "TeamCheck", { Text = T("Team Check", "ไม่เล็งทีมเดียวกัน"), Callback = Kit.Aim.Bind(system, "TeamCheck") })
    if tuning.VisibleOnly ~= nil then
        group:AddToggle(id .. "Visible", { Text = T("Visible Only", "เฉพาะที่มองเห็น"), Callback = Kit.Aim.Bind(system, "VisibleOnly") })
    end
    if tuning.Priority then
        group:AddDropdown(id .. "Priority", {
            Text = T("Priority", "เลือกเป้าตาม"), Values = { "Crosshair", "Distance", "Health" }, Default = tuning.Priority,
            Callback = Kit.Aim.Bind(system, "Priority"),
        })
    end
    group:AddSlider(id .. "Distance", {
        Text = T("Max Distance", "ระยะสูงสุด"), Min = 50, Max = 3000, Step = 50, Default = tuning.MaxDistance, Suffix = "m",
        Callback = Kit.Aim.Bind(system, "MaxDistance"),
    })
    return toggle
end

function Kit.Aim.BuildFov(group, which)
    local T = Kit.T
    local system = Kit.Aim[which]
    local tuning = system.Settings
    local id = "Kit" .. which
    group:AddToggle(id .. "ShowFov", {
        Text = T("Show FOV", "แสดงวง FOV"),
        Callback = Kit.Aim.Bind(system, "ShowFov"),
    }):AddColorPicker(id .. "FovColor", { Default = tuning.FovColor, Callback = Kit.Aim.Bind(system, "FovColor") })
    group:AddSlider(id .. "Fov", {
        Text = T("FOV", "ขนาด FOV"), Min = 20, Max = 600, Step = 5, Default = tuning.Fov, Suffix = "px",
        Callback = Kit.Aim.Bind(system, "Fov"),
    })
end

function Kit.Aim.BuildPart(group, which)
    group:AddDropdown("Kit" .. which .. "Part", {
        Text = Kit.T("Aim Part", "จุดเล็ง"), Values = { "Head", "Torso" }, Default = Kit.Aim[which].Settings.Part,
        Callback = Kit.Aim.Bind(Kit.Aim[which], "Part"),
    })
end

---@param options table?  { Silent = true } adds Silent Aim (needs hook support); Trigger = false / Rage = false hide those
---@return table, table?, table?, table?  aimbot, silent, trigger, rage groups
function Kit.Aim.Build(target, options)
    options = options or {}
    local T = Kit.T
    if Platform.Touch then
        Kit.Aim.Aimbot.Settings.Fov = Kit.Config.Aim.TouchFov
    end
    Kit.Aim.Aimbot.Settings.ShowFov, Kit.Aim.Silent.Settings.ShowFov = false, false

    local aimbot = Kit.Ui.Group(target, "Left", T("Aimbot", "ล็อกเป้า"), "aimbot")
    Kit.Aim.BuildBase(aimbot, "Aimbot", T("Aimbot", "ล็อกเป้า"))
    Kit.Aim.BuildPart(aimbot, "Aimbot")
    aimbot:AddSlider("KitAimbotSmooth", {
        Text = T("Smoothness", "ความนุ่ม"), Min = 0, Max = 0.95, Step = 0.05, Default = Kit.Aim.Aimbot.Settings.Smoothness,
        Callback = Kit.Aim.Bind(Kit.Aim.Aimbot, "Smoothness"),
    })
    aimbot:AddToggle("KitAimbotSticky", { Text = T("Sticky Target", "ล็อกเป้าเดิม"), Callback = Kit.Aim.Bind(Kit.Aim.Aimbot, "Sticky") })
    Kit.Aim.BuildFov(aimbot, "Aimbot")

    local silent
    if options.Silent then
        silent = Kit.Ui.Group(target, "Right", T("Silent Aim", "ยิงเข้าเป้า"), "silentaim")
        Kit.Aim.BuildBase(silent, "Silent", T("Silent Aim", "ยิงเข้าเป้า"), { Cap = "Hook", Risky = true })
        silent:AddDropdown("KitSilentMethod", {
            Text = T("Method", "วิธี"), Values = { "Both", "Raycast", "Mouse" }, Default = Kit.Aim.Silent.Settings.Method,
            Callback = Kit.Aim.SetSilentMethod,
        })
        silent:AddSlider("KitSilentHit", {
            Text = T("Hit Chance", "โอกาสโดน"), Min = 0, Max = 100, Step = 1, Default = 100, Suffix = "%",
            Callback = Kit.Aim.Bind(Kit.Aim.Silent, "HitChance"),
        })
        silent:AddSlider("KitSilentHead", {
            Text = T("Headshot Chance", "โอกาสเข้าหัว"), Min = 0, Max = 100, Step = 1, Default = 50, Suffix = "%",
            Callback = Kit.Aim.Bind(Kit.Aim.Silent, "HeadChance"),
        })
        Kit.Aim.BuildFov(silent, "Silent")
    end

    local trigger
    if options.Trigger ~= false then
        trigger = Kit.Ui.Group(target, options.Silent and "Left" or "Right", T("Triggerbot", "ยิงอัตโนมัติ"), "triggerbot")
        Kit.Aim.BuildBase(trigger, "Trigger", T("Triggerbot", "ยิงอัตโนมัติ"))
        trigger:AddSlider("KitTriggerDelay", {
            Text = T("Reaction Delay", "หน่วงก่อนยิง"), Min = 0, Max = 0.5, Step = 0.01, Default = 0.05, Suffix = "s",
            Callback = Kit.Aim.Bind(Kit.Aim.Trigger, "Delay"),
        })
        trigger:AddSlider("KitTriggerChance", {
            Text = T("Fire Chance", "โอกาสยิง"), Min = 0, Max = 100, Step = 1, Default = 100, Suffix = "%",
            Callback = Kit.Aim.Bind(Kit.Aim.Trigger, "Chance"),
        })
    end

    local rage
    if options.Rage ~= false then
        rage = Kit.Ui.Group(target, "Right", T("Ragebot", "ยิงล็อกทุกทิศ"), "ragebot")
        Kit.Aim.BuildBase(rage, "Rage", T("Ragebot", "ยิงล็อกทุกทิศ"), { Risky = true })
        Kit.Aim.BuildPart(rage, "Rage")
        rage:AddSlider("KitRageGap", {
            Text = T("Fire Interval", "ยิงทุก"), Min = 0.02, Max = 1, Step = 0.01, Default = Kit.Aim.Rage.Settings.FireGap, Suffix = "s",
            Callback = Kit.Aim.Bind(Kit.Aim.Rage, "FireGap"),
        })
    end
    return aimbot, silent, trigger, rage
end

Kit.Guns = {
    Settings = { NoRecoil = false, NoSpread = false, FullAuto = false, RapidFire = false, RapidScale = Kit.Config.Guns.RapidScale },
    Originals = { NoRecoil = {}, NoSpread = {}, FullAuto = {}, RapidFire = {} },
    Watched = setmetatable({}, { __mode = "k" }),
    Rules = {
        NoRecoil = {
            recoil = "Zero", recoilmin = "Zero", recoilmax = "Zero", recoilx = "Zero", recoily = "Zero", recoilpower = "Zero",
            camerarecoil = "Zero", verticalrecoil = "Zero", horizontalrecoil = "Zero", kick = "Zero", camerakick = "Zero", camshake = "Zero",
        },
        NoSpread = {
            spread = "Zero", minspread = "Zero", maxspread = "Zero", spreadangle = "Zero", hipspread = "Zero", aimspread = "Zero",
            bloom = "Zero", inaccuracy = "Zero",
        },
        FullAuto = { auto = "True", automatic = "True", fullauto = "True", isauto = "True", firemode = "Auto", mode = "Auto" },
        RapidFire = {
            firerate = "Rate", firedelay = "Delay", shotdelay = "Delay", firecooldown = "Delay", cooldown = "Delay", delay = "Delay",
            rpm = "Rpm", rateoffire = "Rpm", shootrate = "Rpm",
        },
    },
}

---@return any?  the patched value, nil when the type doesn't fit the rule
function Kit.Guns.Patch(rule, current)
    local kind = typeof(current)
    local scale = Kit.Guns.Settings.RapidScale
    if rule == "True" then
        return kind == "boolean" and true or nil
    elseif rule == "Auto" then
        return kind == "string" and "Auto" or nil
    elseif kind == "number" then
        if rule == "Zero" then return 0 end
        local isDelay = rule == "Delay" or (rule == "Rate" and current <= Kit.Config.Guns.RateAsDelay)
        return isDelay and current / scale or current * scale
    elseif rule == "Zero" and kind == "Vector3" then
        return Vector3.zero
    elseif rule == "Zero" and kind == "Vector2" then
        return Vector2.zero
    elseif rule == "Zero" and kind == "NumberRange" then
        return NumberRange.new(0)
    end
    return nil
end

function Kit.Guns.Write(target, field, value)
    if field == "Value" then
        target.Value = value
    else
        target:SetAttribute(field, value)
    end
end

function Kit.Guns.Apply(mod, target, field, name)
    local rule = Kit.Guns.Rules[mod][name:lower():gsub("[^%a]", "")]
    if not rule then return end
    local saved = Kit.Guns.Originals[mod]
    saved[target] = saved[target] or {}
    local original = saved[target][field]
    if original == nil then
        original = field == "Value" and target.Value or target:GetAttribute(field)
    end
    local patched = Kit.Guns.Patch(rule, original)
    if patched == nil then return end
    saved[target][field] = original
    Kit.Guns.Write(target, field, patched)
end

function Kit.Guns.PatchObject(mod, target)
    if target:IsA("ValueBase") then
        Kit.Guns.Apply(mod, target, "Value", target.Name)
    end
    for name in pairs(target:GetAttributes()) do
        Kit.Guns.Apply(mod, target, name, name)
    end
end

function Kit.Guns.Watch(tool)
    if Kit.Guns.Watched[tool] then return end
    Kit.Guns.Watched[tool] = true
    Kit.Connect(tool.Activated, function()
        Kit.Guns.FiredAt = os.clock()
    end)
end

function Kit.Guns.Tools()
    local tools = {}
    for _, holder in ipairs({ LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack") }) do
        for _, child in ipairs(holder and holder:GetChildren() or {}) do
            if child:IsA("Tool") then
                tools[#tools + 1] = child
            end
        end
    end
    return tools
end

function Kit.Guns.Scan()
    local settings = Kit.Guns.Settings
    for _, tool in ipairs(Kit.Guns.Tools()) do
        Kit.Guns.Watch(tool)
        for mod in pairs(Kit.Guns.Originals) do
            if not settings[mod] then continue end
            Kit.Guns.PatchObject(mod, tool)
            for _, child in ipairs(tool:GetDescendants()) do
                Kit.Guns.PatchObject(mod, child)
            end
        end
    end
end

function Kit.Guns.Restore(mod)
    local saved = Kit.Guns.Originals[mod]
    for target, fields in pairs(saved) do
        for field, original in pairs(fields) do
            Util.Try(Kit.Guns.Write, target, field, original)
        end
    end
    table.clear(saved)
end

function Kit.Guns.Firing()
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        return true
    end
    return os.clock() - (Kit.Guns.FiredAt or 0) < Kit.Config.Guns.FireWindow
end

---Undoes upward camera kick between frames while shooting, unless the player is aiming up themselves.
function Kit.Guns.RecoilStep()
    local camera = Workspace.CurrentCamera
    local pitch = math.asin(math.clamp(camera.CFrame.LookVector.Y, -1, 1))
    local last = Kit.Guns.Pitch
    Kit.Guns.Pitch = pitch
    if not last or not Kit.Guns.Firing() then return end
    local rise = pitch - last
    if rise <= Kit.Config.Guns.MinKick or UserInputService:GetMouseDelta().Y < 0 then return end
    camera.CFrame = camera.CFrame * CFrame.Angles(-rise, 0, 0)
    Kit.Guns.Pitch = last
end

function Kit.Guns.Sync()
    local settings = Kit.Guns.Settings
    local any = settings.NoRecoil or settings.NoSpread or settings.FullAuto or settings.RapidFire
    if any then
        Kit.Scheduler.Add("KitGunsScan", Kit.Guns.Scan, { Interval = 1 })
    else
        Kit.Scheduler.Remove("KitGunsScan")
    end
    if settings.NoRecoil then
        Kit.Scheduler.Add("KitGunsRecoil", Kit.Guns.RecoilStep, { Lane = "Render", Priority = 1 })
    else
        Kit.Scheduler.Remove("KitGunsRecoil")
        Kit.Guns.Pitch = nil
    end
end

---@param mod string  "NoRecoil" | "NoSpread" | "FullAuto" | "RapidFire"
function Kit.Guns.Set(mod, enabled)
    if Kit.Guns.Originals[mod] == nil then return end
    Kit.Guns.Settings[mod] = enabled == true
    if enabled then
        Kit.Guns.Scan()
    else
        Kit.Guns.Restore(mod)
    end
    Kit.Guns.Sync()
end

function Kit.Guns.SetRapidScale(scale)
    Kit.Guns.Settings.RapidScale = scale
    if not Kit.Guns.Settings.RapidFire then return end
    Kit.Guns.Restore("RapidFire")
    Kit.Guns.Scan()
end

function Kit.Guns.Stop()
    for mod in pairs(Kit.Guns.Originals) do
        Kit.Guns.Settings[mod] = false
        Kit.Guns.Restore(mod)
    end
    Kit.Guns.Sync()
end

function Kit.Guns.Status()
    local on = {}
    for _, mod in ipairs({ "NoRecoil", "NoSpread", "FullAuto", "RapidFire" }) do
        if Kit.Guns.Settings[mod] then
            on[#on + 1] = mod
        end
    end
    return #on == 0 and "Off" or table.concat(on, ", ")
end

table.insert(Kit.Modules, Kit.Guns)

function Kit.Guns.Build(target)
    local T = Kit.T
    local group = Kit.Ui.Group(target, "Left", T("Gun Mods", "ปรับปืน"), "fullauto")
    local mods = {
        { "NoRecoil", T("No Recoil", "ไม่มีแรงถีบ") },
        { "NoSpread", T("No Spread", "กระสุนไม่กระจาย") },
        { "FullAuto", T("Full Auto", "ยิงรัว") },
        { "RapidFire", T("Rapid Fire", "ยิงเร็ว") },
    }
    for _, mod in ipairs(mods) do
        group:AddToggle("KitGuns" .. mod[1], { Text = mod[2], Risky = true, Callback = function(on) Kit.Guns.Set(mod[1], on) end })
    end
    group:AddSlider("KitGunsRapidScale", {
        Text = T("Fire Rate Boost", "เร่งอัตรายิง"), Min = 1.5, Max = 10, Step = 0.5, Default = Kit.Guns.Settings.RapidScale, Suffix = "x",
        Callback = Kit.Guns.SetRapidScale,
    })
    return group
end

---@author xDTaraZ  Mario Hub UI V2
Kit.Teleport = { Mode = "Instant", Speed = Kit.Config.Teleport.TweenSpeed, Ignore = {} }

---@param target any  Vector3 | CFrame | BasePart | Model | Attachment | Player
---@return CFrame?
function Kit.Teleport.Resolve(target)
    local kind = typeof(target)
    if kind == "CFrame" then
        return target
    elseif kind == "Vector3" then
        return CFrame.new(target)
    elseif kind ~= "Instance" then
        return nil
    end
    if target:IsA("Player") then
        local char = target.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        return root and root.CFrame or nil
    elseif target:IsA("BasePart") then
        return target.CFrame
    elseif target:IsA("Model") then
        return target:GetPivot()
    elseif target:IsA("Attachment") then
        return target.WorldCFrame
    end
    return nil
end

function Kit.Teleport.Stream(position)
    if not Workspace.StreamingEnabled then
        return
    end
    local timeout = Kit.Config.Teleport.StreamTimeout
    Util.Await(timeout, LocalPlayer.RequestStreamAroundAsync, LocalPlayer, position, timeout)
end

---@return CFrame  goal moved onto the real floor, unchanged if nothing is below
function Kit.Teleport.Ground(goal, exclude)
    local config = Kit.Config.Teleport
    local params = Kit.Teleport.Params
    if not params then
        params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        Kit.Teleport.Params = params
    end
    local ignore = Kit.Teleport.Ignore
    table.clear(ignore)
    ignore[1] = Kit.Player.Character
    ignore[2] = typeof(exclude) == "Instance" and not exclude:IsA("Player") and exclude or nil
    params.FilterDescendantsInstances = ignore
    local start = goal.Position + Vector3.new(0, config.ProbeAbove, 0)
    local hit = Workspace:Raycast(start, Vector3.new(0, -config.GroundProbe, 0), params)
    if not hit then
        return goal
    end
    return CFrame.new(hit.Position + Vector3.new(0, config.GroundLift, 0)) * goal.Rotation
end

function Kit.Teleport.Tween(root, goal)
    local distance = (root.Position - goal.Position).Magnitude
    local duration = distance / math.max(Kit.Teleport.Speed, 1)
    local tween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), { CFrame = goal })
    Kit.Scheduler.Add("KitTeleportHold", function()
        if root.Parent then
            root.AssemblyLinearVelocity = Vector3.zero
        end
    end, { Lane = "Physics" })
    tween:Play()
    local deadline = os.clock() + duration + Kit.Config.Teleport.TweenSlack
    while tween.PlaybackState == Enum.PlaybackState.Playing and os.clock() < deadline do
        task.wait()
    end
    tween:Cancel()
    Kit.Scheduler.Remove("KitTeleportHold")
end

---@param options table?  { Mode = "Instant"|"Tween", Ground = true, Stream = true }
---@return boolean ok, string? reason
function Kit.Teleport.To(target, options)
    options = options or {}
    Kit.Player.Ensure()
    local root = Kit.Player.Root
    if not root or not root.Parent then
        return false, "no character"
    end
    local goal = Kit.Teleport.Resolve(target)
    if not goal then
        return false, "no target"
    end
    Kit.Teleport.Last = root.CFrame
    if options.Stream ~= false then
        Kit.Teleport.Stream(goal.Position)
    end
    if options.Ground ~= false then
        goal = Kit.Teleport.Ground(goal, target)
    end
    if (options.Mode or Kit.Teleport.Mode) == "Tween" then
        Kit.Teleport.Tween(root, goal)
    else
        root.CFrame = goal
        root.AssemblyLinearVelocity = Vector3.zero
    end
    return true
end

function Kit.Teleport.Back()
    local last = Kit.Teleport.Last
    if not last then
        return false, "nowhere to return"
    end
    return Kit.Teleport.To(last, { Ground = false })
end

function Kit.Teleport.Entry(name, category, target)
    return { Name = name, Category = category, Target = target }
end

function Kit.Teleport.FromFolder(folder, category)
    return function()
        local entries = {}
        for _, child in ipairs(folder:GetChildren()) do
            if child:IsA("BasePart") or child:IsA("Model") or child:IsA("Attachment") then
                entries[#entries + 1] = Kit.Teleport.Entry(child.Name, category, child)
            end
        end
        return entries
    end
end

function Kit.Teleport.FromTag(tag, category)
    return function()
        local entries = {}
        for _, inst in ipairs(game:GetService("CollectionService"):GetTagged(tag)) do
            entries[#entries + 1] = Kit.Teleport.Entry(inst.Name, category, inst)
        end
        return entries
    end
end

---Every instance under `root` carrying `attribute`; the attribute value becomes the name when it is a string.
function Kit.Teleport.FromAttribute(attribute, category, root)
    return function()
        local entries = {}
        for _, inst in ipairs((root or Workspace):GetDescendants()) do
            local value = inst:GetAttribute(attribute)
            if value ~= nil then
                entries[#entries + 1] = Kit.Teleport.Entry(type(value) == "string" and value or inst.Name, category, inst)
            end
        end
        return entries
    end
end

function Kit.Teleport.FromPlayers(category)
    return function()
        local entries = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                entries[#entries + 1] = Kit.Teleport.Entry(player.DisplayName, category, player)
            end
        end
        return entries
    end
end

---@param places table  { [name] = Vector3|CFrame } fixed fallbacks for spots that aren't streamed in
function Kit.Teleport.FromList(places, category)
    return function()
        local entries = {}
        for name, position in pairs(places) do
            entries[#entries + 1] = Kit.Teleport.Entry(name, category, position)
        end
        table.sort(entries, function(left, right)
            return left.Name < right.Name
        end)
        return entries
    end
end

function Kit.Teleport.Collect(providers)
    local entries = {}
    for _, provider in ipairs(providers) do
        local ok, list = true, provider
        if type(provider) == "function" then
            ok, list = pcall(provider)
        end
        if not ok then
            Kit.Log:Error("teleport provider", list)
            continue
        end
        for _, entry in ipairs(type(list) == "table" and list or {}) do
            entries[#entries + 1] = entry
        end
    end
    return entries
end

function Kit.Teleport.Stop()
    Kit.Scheduler.Remove("KitTeleportHold")
end

table.insert(Kit.Modules, Kit.Teleport)

---@param providers table?  provider functions or entry lists; players are added unless providers.Players == false
function Kit.Teleport.Build(target, providers)
    local T = Kit.T
    providers = providers or {}
    local list = {}
    for _, provider in ipairs(providers) do
        list[#list + 1] = provider
    end
    if providers.Players ~= false then
        list[#list + 1] = Kit.Teleport.FromPlayers(T("Players", "ผู้เล่น"))
    end
    local group = Kit.Ui.Group(target, "Left", T("Teleport", "วาร์ป"), "teleport")
    group:AddTeleportList("KitTeleport", {
        Text = T("Places", "สถานที่"), Icon = "waypoint",
        Source = function()
            return Kit.Teleport.Collect(list)
        end,
        Refresh = function() end,
        Callback = function(entry)
            local target = entry and (entry.Target or (entry.Raw and entry.Raw.Target))
            task.spawn(Kit.Teleport.To, target)
        end,
    })
    group:AddDropdown("KitTeleportMode", {
        Text = T("Mode", "รูปแบบ"), Icon = "teleport",
        Values = { "Instant", "Tween" },
        Default = Kit.Teleport.Mode,
        Callback = function(mode) Kit.Teleport.Mode = mode end,
    })
    group:AddSlider("KitTeleportSpeed", {
        Text = T("Tween Speed", "ความเร็วเคลื่อน"), Icon = "speed", Min = 30, Max = 600, Step = 10, Default = Kit.Teleport.Speed,
        DependsOn = { "KitTeleportMode", "Tween" },
        Callback = function(speed) Kit.Teleport.Speed = speed end,
    })
    group:AddButton({ Text = T("Go Back", "กลับจุดเดิม"), Icon = "waypoint" }, function()
        task.spawn(Kit.Teleport.Back)
    end)
    return group
end

Kit.Webhook = { Queue = {}, Url = "", Enabled = false }

function Kit.Webhook.Valid(url)
    return type(url) == "string" and (url:match("^https://[%w%.]*discord%.com/api/webhooks/") or url:match("^https://[%w%.]*discordapp%.com/api/webhooks/")) ~= nil
end

---@param embed table  { Title, Description, Fields = { { Name, Value, Inline } }, Color }
---@return boolean  false when the URL is invalid or the executor has no request API
function Kit.Webhook.Send(embed, url)
    url = url or Kit.Webhook.Url
    if not Kit.Webhook.Valid(url) or not Util.Request then
        return false
    end
    local config = Kit.Config.Webhook
    local fields = {}
    for _, field in ipairs(embed.Fields or {}) do
        fields[#fields + 1] = { name = tostring(field.Name or field[1]), value = tostring(field.Value or field[2]), inline = field.Inline ~= false }
    end
    local body = HttpService:JSONEncode({
        username = config.Name,
        embeds = { {
            title = embed.Title,
            description = embed.Description,
            color = embed.Color or config.Color,
            fields = fields,
            footer = { text = config.Name },
            timestamp = DateTime.now():ToIsoDate(),
        } },
    })
    local queue = Kit.Webhook.Queue
    queue[#queue + 1] = { Url = url, Body = body }
    if #queue > config.QueueLimit then
        table.remove(queue, 1)
    end
    if not Kit.Webhook.Pumping then
        Kit.Webhook.Pumping = true
        task.spawn(Kit.Webhook.Pump)
    end
    return true
end

---Sends only while the Webhook toggle is on; use it from features for drop/level alerts.
function Kit.Webhook.Notify(title, description, fields)
    if not Kit.Webhook.Enabled then
        return false
    end
    return Kit.Webhook.Send({ Title = title, Description = description, Fields = fields })
end

function Kit.Webhook.Pump()
    local queue = Kit.Webhook.Queue
    local gap = Kit.Config.Webhook.MinGap
    while queue[1] and not Library.Unloaded do
        local wait = gap - (os.clock() - (Kit.Webhook.LastSent or 0))
        if wait > 0 then
            task.wait(wait)
        end
        local message = table.remove(queue, 1)
        Kit.Webhook.LastSent = os.clock()
        local response = Util.Send({
            Url = message.Url,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = message.Body,
        })
        if response and response.StatusCode == 429 and not message.Retried then
            message.Retried = true
            table.insert(queue, 1, message)
            task.wait(gap)
        end
    end
    Kit.Webhook.Pumping = false
end

function Kit.Webhook.Stop()
    table.clear(Kit.Webhook.Queue)
    Kit.Webhook.Enabled = false
end

function Kit.Webhook.Status()
    return Kit.Webhook.Enabled and (#Kit.Webhook.Queue .. " queued") or "Off"
end

table.insert(Kit.Modules, Kit.Webhook)

function Kit.Webhook.Build(target)
    local T = Kit.T
    local group = Kit.Ui.Group(target, "Right", T("Webhook", "เว็บฮุค"), "webhook")
    local toggle = group:AddToggle("KitWebhook", {
        Text = T("Webhook", "เว็บฮุค"), Icon = "webhook",
        Description = T("Send alerts to your Discord channel", "ส่งแจ้งเตือนเข้าห้อง Discord"),
        Callback = function(on) Kit.Webhook.Enabled = on end,
    })
    Kit.Caps.NeedCap(toggle, "Http")
    group:AddInput("KitWebhookUrl", {
        Text = T("Webhook URL", "ลิงก์เว็บฮุค"), Icon = "link",
        Placeholder = T("https://discord.com/api/webhooks/...", "https://discord.com/api/webhooks/..."),
        Finished = true,
        Callback = function(url)
            Kit.Webhook.Url = url
            if url ~= "" and not Kit.Webhook.Valid(url) then
                Kit.Ui.Notify("That is not a Discord webhook link", "ลิงก์นี้ไม่ใช่เว็บฮุค Discord", "Warn")
            end
        end,
    })
    group:AddButton({ Text = T("Send Test", "ส่งทดสอบ"), Icon = "webhook" }, function()
        local sent = Kit.Webhook.Send({ Title = "Mario Hub", Description = "Webhook test from " .. LocalPlayer.Name })
        if not sent then
            Kit.Ui.Notify("Check the link and executor support", "เช็คลิงก์และ executor อีกครั้ง", "Warn")
        end
    end)
    return group
end

Kit.Discord = {}

function Kit.Discord.Copy(link)
    link = link or Kit.Config.Discord
    if Util.Clipboard(link) then
        Kit.Ui.Notify("Discord link copied", "คัดลอกลิงก์ Discord แล้ว", "Success")
    else
        Library:Notify("Discord", link, Kit.Config.DiscordNotify, "Info")
    end
end

function Kit.Discord.Build(target, link)
    local T = Kit.T
    link = link or Kit.Config.Discord
    local group = Kit.Ui.Group(target, "Right", "Discord", "discord")
    group:AddLabel((link:gsub("^https://", "")))
    group:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Icon = "copy" }, function()
        Kit.Discord.Copy(link)
    end)
    return group
end

---@author xDTaraZ  Mario Hub UI V2

function Library:CreateWindow(options)
    options = options or {}
    Settings.Load()
    local themeName, savedLanguage = Settings.ApplyBoot(options)
    local language = savedLanguage or options.Language
    if language == "Auto" then
        language = tostring(LocalPlayer.LocaleId):sub(1, 2) == "th" and "TH" or "EN"
    end
    State.Language = language == "TH" and "TH" or "EN"
    Platform.Detect(options.Layout)
    Assets.Configure(Config.DefaultAssets)
    Assets.Configure(options.Assets)
    Gui.Setup()
    Theme.Apply(themeName)
    if State.Language == "TH" then
        Fonts.LoadThaiAsync()
    end
    Configs.SetFolder(options.ConfigFolder or options.Title or "Mario Hub")
    local window = Window.New(options)
    self.Window = window
    Float.Build()
    Watermark.Build(options.WatermarkTitle or window.Title)
    Settings.ApplyOverlays(window, options)
    local keySystem = options.KeySystem
    local function Open()
        Library.Boot(window, options)
    end
    if keySystem and keySystem.Enabled ~= false and type(keySystem.Verify) == "function" then
        KeyGate.Show(keySystem, Open)
    else
        Open()
    end
    return window
end

function Library.Build(window, options)
    if Library.Unloaded then
        return
    end
    Util.Try(options.OnUnlocked)
    Configs.CaptureDefaults()
    QuickBar.Restore()
    Layout.Flush()
end

function Library.Reveal(window)
    if Library.Unloaded then
        return
    end
    window.Ready = true
    window:Show()
    local key = Platform.Touch and "ReadyTouch" or "Ready"
    Library:Notify(window.Title, Lang.Format(key, Keybinds.Short(State.MenuKey)), 5, "Success")
end

---Builds the tabs behind the intro so the reveal never waits on a blank window.
function Library.Boot(window, options)
    if Library.Unloaded then
        return
    end
    if options.Intro == false or type(Intro.Play) ~= "function" then
        Library.Build(window, options)
        Library.Reveal(window)
        return
    end
    local built = false
    task.spawn(function()
        Library.Build(window, options)
        built = true
    end)
    local function WaitBuilt()
        local started = os.clock()
        while not built and not Library.Unloaded and os.clock() - started < Config.Chrome.BuildTimeout do
            task.wait()
        end
    end
    local steps = Lang.Strings.IntroSteps
    task.spawn(Intro.Play, {
        Title = window.Title,
        SubTitle = window.SubTitle,
        Steps = {
            { Label = { EN = steps.EN[1], TH = steps.TH[1] } },
            { Label = { EN = steps.EN[2], TH = steps.TH[2] } },
            { Label = { EN = steps.EN[3], TH = steps.TH[3] }, Run = WaitBuilt },
            { Label = { EN = steps.EN[4], TH = steps.TH[4] } },
        },
        OnDone = function()
            Library.Reveal(window)
        end,
    })
end

function Library:T(english, thai)
    return { EN = english, TH = thai or english }
end

function Library:SetLanguage(code)
    if code ~= "EN" and code ~= "TH" then
        return
    end
    Lang.Set(code)
    local option = self.Options.MarioLanguage
    local label = code == "TH" and "ไทย" or "English"
    if option and option.Value ~= label and type(option.SetValue) == "function" then
        option.Silent = true
        Util.Try(option.SetValue, option, label)
        option.Silent = nil
    end
end

function Library:GetLanguage()
    return State.Language
end

function Library:SetTheme(name)
    Theme.Apply(name)
    local option = self.Options.MarioTheme
    if option and option.Value ~= State.ThemeName and type(option.SetValue) == "function" then
        Util.Try(option.SetValue, option, State.ThemeName)
    end
end

function Library:SetAssets(map)
    Assets.Configure(map)
end

---@param info any        title spec, or { Title, Content|Description, Duration, Kind|Type|Icon, Action }
---@param action table?    { Text, Callback } button on the card
---@return table?          { Dismiss }
function Library:Notify(info, content, duration, kind, action)
    if type(info) == "table" and not info.EN and not info.TH then
        info, content, duration, kind, action = info.Title, info.Content or info.Description, info.Duration, info.Kind or info.Type or info.Icon, info.Action
    end
    if self.Unloaded or type(Notify.Push) ~= "function" then
        return nil
    end
    return Notify.Push(info, content, duration, kind, action)
end

---@param options table  { Title, Content, Icon, Width, Buttons = { { Text, Style, Icon, Callback -> false keeps it open } }, Dismissable, OnClose }
---@return table?        { Close }
function Library:Dialog(options)
    if self.Unloaded then return nil end
    return Dialog.Open(options)
end

---@param ask table  { Title, Content, Placeholder, Default, Numeric, Choices, Callback(value) }  Callback runs on OK only
---@return table?    { Close }
function Library:Prompt(ask)
    if self.Unloaded then return nil end
    return Dialog.Prompt(ask)
end

---@param build fun(container: table)  add widgets to the sheet body
---@param options table?               { Height = 0.6 | "Auto", OnClose }
---@return table?                      { Container, Close, SetTitle }
function Library:Sheet(title, build, options)
    if self.Unloaded then return nil end
    return Sheet.Open(title, build, options)
end

---@param anchor any     Instance, a button (.Frame) or any row widget (.Row.Control)
---@param build fun(container: table)
---@param options table? { Width, MaxHeight, Title, OnClose, SheetHeight }
---@return table?        { Container, Close, Fit }; a bottom sheet on Phone
function Library:Popup(anchor, build, options)
    if self.Unloaded then return nil end
    local frame = typeof(anchor) == "Instance" and anchor or (type(anchor) == "table" and (anchor.Frame or (anchor.Row and anchor.Row.Control)))
    if typeof(frame) ~= "Instance" then
        warn("[Mario Hub] Popup: anchor needs a GuiObject or a widget with .Frame")
        return nil
    end
    return Popup.Open(frame, build, options)
end

function Library:ClosePopups()
    Popup.Close()
    Sheet.Close()
    Dialog.Close()
end

---@param pinned boolean?  nil flips
---@return boolean         pinned now
function Library:Pin(idx, pinned)
    if pinned == nil then
        pinned = not QuickBar.Has(idx)
    end
    if pinned then
        QuickBar.Add(idx)
    else
        QuickBar.Remove(idx)
    end
    return QuickBar.Has(idx)
end

Library.OverlayToggles = { Watermark = "MarioWatermark", KeybindList = "MarioKeybindList", Float = "MarioFloat" }

---Goes through the Settings toggle when it exists so the menu and the saved choice stay in sync.
---@param name string  Watermark | KeybindList | Float
function Library:SetOverlay(name, visible)
    local option = self.Options[Library.OverlayToggles[name] or ""]
    if option then
        option:SetValue(visible == true)
        return
    end
    local overlay = ({ Watermark = Watermark, KeybindList = KeybindList, Float = Float })[name]
    if overlay then
        overlay.SetVisible(visible == true)
    end
end

function Library:SetWatermarkTitle(title)
    Watermark.SetTitle(title)
end

function Library:Toggle()
    if self.Window then
        self.Window:Toggle()
    end
end

function Library:SetScale(scale)
    if self.Window then
        self.Window:SetScale(scale)
    end
end

---@return table  job; set job.Stopped = true to cancel
function Library:Every(interval, callback)
    local job = { Interval = interval, Elapsed = 0, Run = callback }
    table.insert(State.Tasks, job)
    return job
end

function Library:SaveConfig(name)
    return Configs.Save(name)
end

function Library:LoadConfig(name)
    return Configs.Load(name)
end

---@param scope any  nil / "all" (any case), a tab (object or name) or a groupbox
---@return number    options put back to their defaults
function Library:ResetConfig(scope)
    return Configs.Reset(scope)
end

---@return string  "MH2:" + JSON of every saved option; paste it into ImportConfig
function Library:ExportConfig()
    return Configs.Export()
end

---@return boolean  false if the text is not an export
function Library:ImportConfig(text)
    return Configs.Import(text)
end

---Goes through the Settings controls when they exist so the menu and the saved choice stay in sync.
function Library:SetReduceMotion(enabled)
    local option = self.Options.MarioReduceMotion
    if option then
        option:SetValue(enabled == true)
        return
    end
    Motion.SetReduced(enabled == true)
end

---@param corner string  BottomRight | TopRight | BottomLeft | TopLeft
function Library:SetNotifyPosition(corner)
    local index = table.find(Window.Corners, corner)
    if not index then
        return
    end
    local option = self.Options.MarioNotifyCorner
    if option then
        option:SetValue(option.Values[index])
        return
    end
    Notify.SetPosition(corner)
end

---@return table[]  the window's tabs in sidebar order (a copy; adding goes through Window:AddTab)
function Library:GetTabs()
    return self.Window and table.clone(self.Window.Tabs) or {}
end

function Library:LoadAutoloadConfig()
    local name = Configs.GetAutoload()
    if not name then
        return
    end
    local ok, reason = Configs.Load(name)
    local message = ok and { EN = "Autoloaded: " .. name, TH = "โหลดอัตโนมัติ: " .. name }
        or { EN = "Autoload failed: " .. tostring(reason), TH = "โหลดอัตโนมัติไม่สำเร็จ: " .. tostring(reason) }
    self:Notify(Lang.Strings.Configs, message, 3, ok and "Success" or "Error")
end

function Library:OnUnload(callback)
    table.insert(State.UnloadHooks, callback)
end

function Library:Unload()
    if self.Unloaded then
        return
    end
    self.Unloaded = true
    Gui.Teardown()
    self.Window = nil
end

Library.Themes = Themes.Order
Library.Util = Util

return Library