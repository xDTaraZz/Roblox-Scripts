if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

if game.GameId ~= 7633926880 then
    LocalPlayer:Kick("Mario Hub: this script is for BloxStrike only")
    return
end

---@return function  the game's own print when the executor exposes it
local function RuntimePrint()
    local ok, renv = pcall(getrenv)
    return ok and type(renv) == "table" and type(renv.print) == "function" and renv.print or print
end

local MarioBanner = {
    Print = RuntimePrint(),
    Started = os.clock(),
    Last = os.clock(),
    Done = 0,
    Total = 4,
}

function MarioBanner.Show()
    local ok, executor = pcall(identifyexecutor)
    if not ok or type(executor) ~= "string" then executor = "Unknown" end
    local rule = string.rep("=", 54)
    MarioBanner.Print(table.concat({
        "",
        [[
                                                                     @%@
                                                                    @*-#@
                                          @@@@@@@@@@@@@          @@#+.:-*%@@      @@
                                   @@@@@%##***********##%@@@@@   @*--:-==+*@@@@#*+==+*%@@
                              @@@@#+=+==---==++++++++++++**+++#@@@@@%==+@@@@#:.......:::=%@@
                          @@%#+---::-=++++++++++************+***++#%@%+@@@#:..-+*****+-:::+%@
                      @@@#=-::.:-==++++++++++*************************#@@+::=*-:.:+-::-+:.:=#@
                    @@%-:...:-===+++++**#################****************%%*+::::+*++::-+..:=#@
                 @@%*-:...:--==++*########**+==--===+**#######************+#%+::-*==-:::=-::=+@@
               @@%+=-::---===+*###%#+-:...................:=+#####***********#@+++==----==:-+*@@
             @@%++=-======+*###%+:............................::+####**********#@*+=----=---**@@
            @%=++=++++++*####=:...................................:+###**********%@==--==--+**@@
          @@*+++++++++*###*:........................................:-*##**********%*==+--=**@@@
         @%+++++++++*##%+:............................................::*##*********%%+--=##%@+%@
       @@#+++++++++###*:.....-+==+*#-......................:**+**#+:....:=###********%%+*##%@*:+@@
      @@*++++++++*###:......-+:.:-=*#*-..................:+*--+**#%*:.....:+##********#@#%%+:.:--+#@
     @@+++++++++*##+:......-*::-=++++*##:...............=#=-++****#%*:.....:-##********#@@@%+=-++#@@
    @@+=-=+++++*##+.......:*-:==++++++*##+............-*+-=+*******#%+:.....:-##********#@  @#=#@@
    @*=:.=++++*##-.......:*=:=++++++++*+*##=........:**==+**********##=:.....::*#********%@  @#@
   @#+-.-++*+*##=........*+-++++++*********##-....:+*==+*************#%-:.....:-**********%@
  @@++-=++***##+........*+-++++++***********#%*::=#+-+****************#%-:.....:=**********@@
 @@*++=++***###........+*-+++++***************###+-=+*****************###-:.....:+*********%@
 @%++=+*****#%:.......=*-++++*******************==+********************#%*-:....:-#********#@@
@@**+++****##+.......=*=+++*********************************************#%+::....:+*********@@
@%**++*****##-......=#=++**********#%#********************%%*************#%+:....:-#********%@
@%**++*****#*:.....-*=++**********#%%%#*****************#%%%**************#%=:....-********##@@
@#**++*****#*:....:*++************%%%%%%#*************#%%%%%#**************##-:...-+*******#*@@
@#**+******#+:...:#++************#%%%@@%%##*********#%%%%%@%#**************#%#-:..:+*+*****#*@@
@#**+******#+:..:#+=************#%%%%%*%%%##*******%%%%%%#%%##**************#%#::.-+*+*****#*@@
@#*********#+:.:+*=*************%%%%%+==*%%###***#%%%%%#++*%##***************#%*::-+*+*****#*@@
@%*#*******#*:.+*=*************%%%%%*=----*%###%%%%%%#+====*###**************##%+--*++****###@@
@%*#********#-:####***********#%%%%#=-::.::=###%%%%#+==--:::####************#%%%#==*+*****###@@
@@##********#+:#%%%%#********#%%%%%=--:....::=%%%%+==--::..:-%###********#%%%%%%#=#++*****##%@
@@###********#-=#%%%%%%##****%%%%%*=-:.......::-==---::.....:+###*****##%%%%%%%#++#++****###@@
 @%###*******##::=+%%%%%%%##%%%%%#=-:...........:::::........:####*#%%%%%%%%%*+=+*+=*****##%@
 @@###********#+:.:-=*%%%%%%%%%%%+--:.........................=###%%%%%%%%*+====*=.=****###@@
  @@###********#+:..::-=*%%%%%%%*=-:..:::-------------::::...::*#%%%%%%*+==---=*+-=+***###%@
   @%###*******#%#*+-..::-=#%@@%#**++==----------------===+++**#%@@@#+===---+*#*++****####@@
    @%###**#%#=::-=+##*##+-:...:::-=+**---*###*=--++++=--=++++=--:::-=+#%**#-:..:=#%##%##@@
    @@%#%#+:...:-=++=:..::=*####+#=:..=@#%:....%@*....*%%#...:--=*##+------=+=:::::-=#%%@@
     @@%*=--::::-*::::::-%=...:%@#:...:@@#.....%@+....=@@=.........:*#=-----=+=:::-==++%@@
  @@%+--+==--:::-#=-::::-%+....+%%-....%@#....:@@+....+@@:...:%%....-@*---==+*+:::-=+++*=+#@@
 @%-:-==*+==-:::-+*--:::-*#:...........*@#....:@@+....+@%..........-%%+---==+*=::-=+++#*=-:-*@@
 @@#+===+*+==-::-=*=--::-=%-......:....+@%:....:-....:#@*....=+:...-%#=--==+**-:--=++#*+=-=*%@
   @@#*=++#+=-:::-+*------#+....+@%....-@@#:.......::*@@+....+#=.:::=%+-===+#+-:-=++***++*%@@
     @@#+++*==-::-=*=-----+%:...-@@-::-=@%%@#+=--==*%@%%=:::::::::::#%+===+**----=++#**#%@@
     @@*-=+*+=-::-=*+=----=%#+*#%@%@@@@@#+-=*%%@@@%#*==*@@%%%##*+*#@@*====+#+-:-=++***++%@
    @@*--=+++===++*#*=------#%%#+=-----===============----==+*#%%%#+=-===+*#*+++=++**+==*@@
    @%=:-==+***%%@@@#=-=====++*##%%%@@@@@@@@@@%%@@@@@@@@@%%%##**++=======+*@@@@%#*+#+=--=#@
    @*:---==+*###%@@@#*#%%@%%%%%%######*****++++++++***######%%%%%%%%%%#*#%@@@####**+=---+@@
   @@+--=**#%@@@@@  @@@%%%%%%%#*******************************####%%%%%%@@@  @@@@@%#**=--+%@
    @@%%@@@@@          @@@@%%%%%%###**********************####%%%%%%%@@@          @@@@@%%%@@
      @@                  @@@@@%%%%%%%%%###############%%%%%%%%%@@@@@                  @@@
                               @@@@@@%%%%%%%%%%%%%%%%%%%%%%@@@@@
                                    @@@@@@@@@@@@@@@@@@@@@@@
]],
        [[
  __  __    _    ____  ___ ___    _   _ _   _ ____
 |  \/  |  / \  |  _ \|_ _/ _ \  | | | | | | | __ )
 | |\/| | / _ \ | |_) || | | | | | |_| | | | |  _ \
 | |  | |/ ___ \|  _ < | | |_| | |  _  | |_| | |_) |
 |_|  |_/_/   \_\_| \_\___\___/  |_| |_|\___/|____/
]],
        rule,
        "   BLOXSTRIKE  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
        "   executor: " .. executor .. "   //   player: " .. game:GetService("Players").LocalPlayer.Name,
        rule,
    }, "\n"))
end

---@param label string  what just finished loading
function MarioBanner.Step(label)
    local now = os.clock()
    MarioBanner.Done = math.min(MarioBanner.Done + 1, MarioBanner.Total)
    local filled = math.floor(MarioBanner.Done / MarioBanner.Total * 20 + 0.5)
    MarioBanner.Print(string.format("[Mario Hub] [%s] %3d%%  %-24s +%dms",
        string.rep("#", filled) .. string.rep(".", 20 - filled),
        math.floor(MarioBanner.Done / MarioBanner.Total * 100), label, math.floor((now - MarioBanner.Last) * 1000)))
    MarioBanner.Last = now
end

function MarioBanner.Ready()
    local rule = string.rep("=", 54)
    MarioBanner.Print(table.concat({
        rule,
        string.format("   >> READY in %dms", math.floor((os.clock() - MarioBanner.Started) * 1000)),
        rule,
    }, "\n"))
end

pcall(MarioBanner.Show)
pcall(MarioBanner.Step, "Core")

local environment = getgenv and getgenv() or _G
if environment.BloxStrikeUnload then pcall(environment.BloxStrikeUnload) end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local vector2New = Vector2.new
local cframeLookAt = CFrame.lookAt
local osClock = os.clock

local Library, T

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    Discord = "https://discord.gg/FHVfmeSceA",
    UpdateLog = {
        { "2026-10-10", "Fixed the game crashing when you shoot\nFixed ESP Team Check showing your own team\nSkin pictures and rarity colors in skin lists" },
        { "2026-10-03", "Classic Mario Hub UI is back\nBetter executor support\nImproved Combat & Movement" },
    },
    SaveFolder = "BloxStrike",
    StatusInterval = 1,
    AimRenderPriority = Enum.RenderPriority.Camera.Value + 1,
    RefireGap = 0.12,
    TriggerRay = 2000,
    MinShotDistance = 0.05,
    RedeemGap = 1.1,
    RebuyGap = 0.25,
    AlertTries = 20,
    AlertGap = 0.5,
    RequireTimeout = 5,
    MaxFails = 5,
    FailWindow = 10,
    CombatToggles = { "Aimbot", "Triggerbot", "Ragebot", "AimbotShowFov", "SilentShowFov" },
    ModuleFeatures = {
        Net = { "SilentAim", "Ragebot", "AutoRebuy" },
        Character = { "BunnyHop" },
        Skins = { "SkinChanger" },
    },
    Codes = {
        "1MGROUPMEMBERS", "MYFAULTYALL", "RIANOMINATED2026", "LORE", "DUST_II", "MICHAELSRETURN",
        "FREEDOM", "HAPPYBDAYYUUTO", "GAMEBROKE318", "OHNEPIXEL", "NEBULA", "REACTORDELAY", "BUTTERFLYCASE", "TRADEUPS",
    },
    BoneParts = {
        Head = { "Head" },
        Torso = { "UpperTorso", "Torso", "HumanoidRootPart" },
    },
    BuyStates = { ["Buy Period"] = true, ["Warmup"] = true },
    StickySlack = 1.5,
    HopGap = 0.05,
    HookSettle = 1,
    SkinFile = "BloxStrike/skins.json",
    SkinWears = { "Factory New", "Minimal Wear", "Field-Tested", "Well-Worn", "Battle-Scarred" },
    SkinKinds = { Melee = "Knives", Glove = "Gloves", Grenade = "Grenades", C4 = "Gear", ["Zeus x27"] = "Gear" },
    SkinOrder = { "Pistol", "SMG", "Rifle", "Sniper", "Heavy", "Shotgun", "Machine Gun", "Knives", "Gloves", "Grenades", "Gear" },
    SkinRanks = { Forbidden = 9, Special = 8, Red = 7, Pink = 6, Purple = 5, Blue = 4, LightBlue = 3, Gray = 2, White = 1 },
    SkinMainRows = 5,
    SkinArms = { ["Left Arm"] = true, ["Right Arm"] = true },
    GloveKey = "@Glove",
    FovColors = {
        Aimbot = Color3.fromRGB(232, 160, 76),
        Silent = Color3.fromRGB(110, 170, 255),
    },
    EspFocusColor = Color3.fromRGB(255, 214, 64),
    FovLayer = 50,
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Halted = {},
    Notices = {},
    AimTarget = nil,
    AimPart = nil,
    RageTarget = nil,
    RagePart = nil,
    SilentTarget = nil,
    Firing = false,
    PressedAt = 0,
    LastShot = 0,
    Shots = 0,
    Redirected = 0,
    Bought = {},
    LastRebuyRound = nil,
    LightSaved = nil,
    Hooks = {},
    TriggerWarned = false,
    HopAt = 0,
    HopCrouched = false,
    SpaceHeld = false,
    FovBound = false,
    FovBase = 0,
}

xDTaraZ.Options = {
    Aimbot = false,
    AimbotSmooth = 1,
    AimbotBone = "Head",
    AimbotPriority = "Crosshair",
    AimbotFov = 150,
    AimbotShowFov = false,
    AimbotVisible = true,
    AimbotSticky = true,
    AimbotMaxDistance = 1500,
    SilentAim = false,
    SilentHitChance = 100,
    SilentHeadChance = 100,
    SilentPriority = "Crosshair",
    SilentFov = 220,
    SilentShowFov = false,
    SilentVisible = true,
    SilentMaxDistance = 2000,
    Triggerbot = false,
    TriggerDelay = 0,
    TriggerHitChance = 100,
    Ragebot = false,
    RageVisible = true,
    RageMaxDistance = 2000,
    NoRecoil = false,
    NoSpread = false,
    Fullbright = false,
    NoFlash = false,
    NoSmoke = false,
    CameraFov = false,
    CameraFovValue = 100,
    InfiniteJump = false,
    BunnyHop = false,
    BunnyCrouch = true,
    SkinChanger = false,
    AutoRebuy = false,
    AntiAfk = false,
}

xDTaraZ.Caps = setmetatable({}, {
    __index = function(_, name)
        return Library ~= nil and Library.Compat.Caps[name] == true
    end,
})

xDTaraZ.Util = {}

function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then return body end
    local req = request or http_request or (syn and syn.request)
    if not req then error("no http") end

    local sent, response = pcall(req, { Url = url, Method = "GET" })
    if not sent then error(response) end
    local status = type(response) == "table" and tonumber(response.StatusCode)
    if status ~= 200 or type(response.Body) ~= "string" then error("http status " .. tostring(status)) end
    return response.Body
end

---@param detail any  extra context for the warn; the player only sees `text`
function xDTaraZ.Util.Alert(text, detail)
    warn("[BloxStrike] menu:", detail or text)
    task.spawn(function()
        for _ = 1, xDTaraZ.Config.AlertTries do
            if pcall(StarterGui.SetCore, StarterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 }) then return end
            task.wait(xDTaraZ.Config.AlertGap)
        end
    end)
end

---@return table?  nil after the player was told on screen
function xDTaraZ.Util.LoadLibrary(url)
    local got, source = pcall(xDTaraZ.Util.HttpGet, url)
    local whole = got and type(source) == "string" and source:sub(-64):find("return Library%s*$") ~= nil
    if not whole then
        xDTaraZ.Util.Alert("Could not download the menu. Check your connection and run it again.", got and "truncated or not the menu" or source)
        return nil
    end
    local chunk, err = loadstring(source)
    if type(chunk) ~= "function" then
        xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(err))
        return nil
    end
    local ran, loaded = pcall(chunk)
    if ran and type(loaded) == "table" then return loaded end
    xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(loaded))
    return nil
end

function xDTaraZ.Util.Try(label, fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[BloxStrike] " .. label .. ":", err) end
    return ok
end

function xDTaraZ.Util.Copy(text)
    local fn = setclipboard or toclipboard
    if not fn then return false end
    return pcall(fn, text)
end

---@return function?  original, nil when already hooked or the executor can't hook it
function xDTaraZ.Util.Hook(key, fn, replacement)
    if type(fn) ~= "function" or xDTaraZ.State.Hooks[key] or not xDTaraZ.Caps.HookFunction then return nil end
    local ok, original = pcall(hookfunction, fn, replacement)
    if not ok or type(original) ~= "function" then
        warn("[BloxStrike] hook " .. key .. ":", ok and "executor returned no original" or original)
        return nil
    end
    xDTaraZ.State.Hooks[key] = { Fn = fn, Original = original }
    return original
end

function xDTaraZ.Util.UnhookAll()
    for key, hook in pairs(xDTaraZ.State.Hooks) do
        local ok, err = pcall(Library.Compat.Unhook, hook.Fn, function() hookfunction(hook.Fn, hook.Original) end)
        if not ok then warn("[BloxStrike] unhook " .. key .. ":", err) end
    end
    table.clear(xDTaraZ.State.Hooks)
end

function xDTaraZ.Util.Decode(raw)
    if type(raw) ~= "string" then return nil end
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
    return ok and decoded or nil
end

function xDTaraZ:Connect(signal, handler)
    local conn = signal:Connect(handler)
    table.insert(self.State.Connections, conn)
    return conn
end

xDTaraZ.GameLib = { Missing = {} }

---@param parent Instance?     where it lives today
---@param home string          parent name a moved copy must still have
---@return Instance?           nil after a warning that names it
function xDTaraZ.GameLib.Find(parent, name, class, home)
    local found = parent and parent:FindFirstChild(name)
    if found and found:IsA(class) then return found end
    for _, desc in ipairs(ReplicatedStorage:GetDescendants()) do
        if desc.Name == name and desc:IsA(class) and desc.Parent and desc.Parent.Name == home then return desc end
    end
    xDTaraZ.GameLib.Missing[name] = "Absent"
    warn("[BloxStrike] " .. home .. "." .. name .. " not found, features that need it are blocked")
    return nil
end

---@return any  module, or nil when this executor can't require it (never throws)
function xDTaraZ.GameLib.Require(inst)
    if not (inst and inst:IsA("ModuleScript")) then return nil end
    local ok, mod = pcall(require, inst)
    if ok then return mod end

    local done, okAgain, again = false, false, nil
    task.spawn(function()
        pcall(setthreadidentity, 2)
        local read, identity = pcall(getthreadidentity)
        if read and identity == 2 then okAgain, again = pcall(require, inst) end
        done = true
    end)
    local deadline = osClock() + xDTaraZ.Config.RequireTimeout
    while not done and osClock() < deadline do task.wait() end
    if okAgain then return again end
    warn("[BloxStrike] require " .. inst.Name .. ":", mod)
    return nil
end

do
    local database = ReplicatedStorage:FindFirstChild("Database")
    local security = database and database:FindFirstChild("Security")
    local custom = database and database:FindFirstChild("Custom")
    local controllers = ReplicatedStorage:FindFirstChild("Controllers")
    local find = xDTaraZ.GameLib.Find
    xDTaraZ.GameLib.Net = xDTaraZ.GameLib.Require(find(security, "Remotes", "ModuleScript", "Security"))
    xDTaraZ.GameLib.Character = xDTaraZ.GameLib.Require(find(controllers, "CharacterController", "ModuleScript", "Controllers"))
    xDTaraZ.GameLib.Camera = xDTaraZ.GameLib.Require(find(controllers, "CameraController", "ModuleScript", "Controllers"))
    xDTaraZ.GameLib.WeaponFolder = find(custom, "Weapons", "Folder", "Custom")
    xDTaraZ.GameLib.Rarities = xDTaraZ.GameLib.Require(find(custom, "Rarities", "ModuleScript", "GameStats"))
end

xDTaraZ.Weapons = {}
do
    local folder = xDTaraZ.GameLib.WeaponFolder
    for _, module in ipairs(folder and folder:GetChildren() or {}) do
        local data = module:IsA("ModuleScript") and xDTaraZ.GameLib.Require(module)
        if type(data) == "table" and data.FireRate then xDTaraZ.Weapons[module.Name] = data end
    end
end

xDTaraZ.Player = {}

function xDTaraZ.Player.Character()
    local chars = Workspace:FindFirstChild("Characters")
    return (chars and chars:FindFirstChild(LocalPlayer.Name)) or LocalPlayer.Character
end

function xDTaraZ.Player.Alive()
    local char = xDTaraZ.Player.Character()
    return char ~= nil and char.Parent ~= nil and tostring(LocalPlayer:GetAttribute("Dead")) ~= "true"
end

function xDTaraZ.Player.Humanoid()
    local char = xDTaraZ.Player.Character()
    return char and char:FindFirstChildOfClass("Humanoid")
end

---@return table?  the game's own local character state; nil outside a round
function xDTaraZ.Player.Body()
    local controller = xDTaraZ.GameLib.Character
    if not controller then return nil end
    local ok, body = pcall(controller.getCurrentCharacter)
    return ok and body or nil
end

function xDTaraZ.Player.Equipped()
    return xDTaraZ.Util.Decode(LocalPlayer:GetAttribute("CurrentEquipped"))
end

xDTaraZ.Target = {}

local losParams = RaycastParams.new()
losParams.FilterType = Enum.RaycastFilterType.Exclude
local losFilter = table.create(3)

function xDTaraZ.Target.Candidates()
    local list = {}
    local chars = Workspace:FindFirstChild("Characters")
    if not chars then return list end
    for _, model in ipairs(chars:GetChildren()) do
        if model.Name ~= LocalPlayer.Name and model:IsA("Model") then list[#list + 1] = model end
    end
    return list
end

function xDTaraZ.Target.Owner(model)
    return Players:FindFirstChild(model.Name)
end

---@return string?  team of a character: owner's Team attribute, else the team that wears this character model
function xDTaraZ.Target.TeamOf(model)
    local owner = model and xDTaraZ.Target.Owner(model)
    local team = owner and owner:GetAttribute("Team")
    if team then return team end
    local look = model and model:GetAttribute("CharacterName")
    if not look then return nil end
    if look == Workspace:GetAttribute("CTCharacter") then return "Counter-Terrorists" end
    if look == Workspace:GetAttribute("TCharacter") then return "Terrorists" end
    return nil
end

function xDTaraZ.Target.MyTeam()
    return LocalPlayer:GetAttribute("Team") or xDTaraZ.Target.TeamOf(xDTaraZ.Player.Character())
end

function xDTaraZ.Target.IsEnemy(model)
    if tostring(model:GetAttribute("Dead")) == "true" then return false end
    if not xDTaraZ.Target.Owner(model) then return false end
    local mine = xDTaraZ.Target.MyTeam()
    return mine == nil or xDTaraZ.Target.TeamOf(model) ~= mine
end

function xDTaraZ.Target.Part(model, bone)
    for _, name in ipairs(xDTaraZ.Config.BoneParts[bone] or xDTaraZ.Config.BoneParts.Head) do
        local part = model:FindFirstChild(name)
        if part and part:IsA("BasePart") then return part end
    end
    return model:FindFirstChild("HumanoidRootPart")
end

function xDTaraZ.Target.Visible(from, model, point)
    losFilter[1], losFilter[2], losFilter[3] = xDTaraZ.Player.Character(), model, Workspace.CurrentCamera
    losParams.FilterDescendantsInstances = losFilter
    return Workspace:Raycast(from, point - from, losParams) == nil
end

---@param cfg table  { Bone, Fov?, Visible, MaxDistance, Priority }  Fov nil = whole map
---@return Model?, BasePart?
function xDTaraZ.Target.Pick(cfg)
    local cam = Workspace.CurrentCamera
    local origin = cam.CFrame.Position
    local center = cam.ViewportSize / 2
    local best, bestPart, bestScore

    for _, model in ipairs(xDTaraZ.Target.Candidates()) do
        if not xDTaraZ.Target.IsEnemy(model) then continue end
        local part = xDTaraZ.Target.Part(model, cfg.Bone)
        if not part then continue end
        local dist = (part.Position - origin).Magnitude
        if dist > cfg.MaxDistance then continue end

        local screen, onScreen = cam:WorldToViewportPoint(part.Position)
        local screenDist = (vector2New(screen.X, screen.Y) - center).Magnitude
        if cfg.Fov and (not onScreen or screenDist > cfg.Fov) then continue end
        if cfg.Visible and not xDTaraZ.Target.Visible(origin, model, part.Position) then continue end

        local score = dist
        if cfg.Priority == "Crosshair" then
            score = onScreen and screenDist or 1e6 + dist
        elseif cfg.Priority == "Health" then
            score = (tonumber(model:GetAttribute("Health")) or 100) * 1e4 + dist
        end
        if not bestScore or score < bestScore then best, bestPart, bestScore = model, part, score end
    end
    return best, bestPart
end

---@return boolean  still a valid lock, with a looser fov
function xDTaraZ.Target.StillValid(model, part, cfg)
    if not (model and part and part.Parent and xDTaraZ.Target.IsEnemy(model)) then return false end
    local cam = Workspace.CurrentCamera
    local origin = cam.CFrame.Position
    if (part.Position - origin).Magnitude > cfg.MaxDistance then return false end
    if cfg.Visible and not xDTaraZ.Target.Visible(origin, model, part.Position) then return false end
    if not cfg.Fov then return true end
    local screen, onScreen = cam:WorldToViewportPoint(part.Position)
    local center = cam.ViewportSize / 2
    return onScreen and (vector2New(screen.X, screen.Y) - center).Magnitude <= cfg.Fov * xDTaraZ.Config.StickySlack
end

---@return Model?  enemy under the crosshair right now
function xDTaraZ.Target.UnderCrosshair()
    local cam = Workspace.CurrentCamera
    losFilter[1], losFilter[2], losFilter[3] = xDTaraZ.Player.Character(), cam, nil
    losParams.FilterDescendantsInstances = losFilter
    local hit = Workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * xDTaraZ.Config.TriggerRay, losParams)
    if not hit then return nil end
    local chars = Workspace:FindFirstChild("Characters")
    local model = hit.Instance
    while model and model.Parent ~= chars do model = model.Parent end
    if model and model:IsA("Model") and xDTaraZ.Target.IsEnemy(model) then return model end
    return nil
end

local function roll(percent)
    return percent >= 100 or math.random() * 100 < percent
end

xDTaraZ.Aimbot = {}

function xDTaraZ.Aimbot.Config()
    local o = xDTaraZ.Options
    return { Bone = o.AimbotBone, Fov = o.AimbotFov, Visible = o.AimbotVisible, MaxDistance = o.AimbotMaxDistance, Priority = o.AimbotPriority }
end

function xDTaraZ.Aimbot.Step()
    local state, o = xDTaraZ.State, xDTaraZ.Options
    if not o.Aimbot then state.AimTarget, state.AimPart = nil, nil return end
    local cfg = xDTaraZ.Aimbot.Config()
    if o.AimbotSticky and xDTaraZ.Target.StillValid(state.AimTarget, state.AimPart, cfg) then return end
    state.AimTarget, state.AimPart = xDTaraZ.Target.Pick(cfg)
end

function xDTaraZ.Aimbot.Lock()
    local o, state = xDTaraZ.Options, xDTaraZ.State
    local part, smooth = nil, 1
    if o.Ragebot and state.RagePart and state.RagePart.Parent then
        part = state.RagePart
    elseif o.Aimbot and state.AimPart and state.AimPart.Parent then
        part, smooth = state.AimPart, math.max(o.AimbotSmooth, 1)
    end
    if not part then return end
    local cam = Workspace.CurrentCamera
    local origin = cam.CFrame.Position
    local want = (part.Position - origin).Unit
    local look = smooth <= 1 and want or cam.CFrame.LookVector:Lerp(want, 1 / smooth).Unit
    cam.CFrame = cframeLookAt(origin, origin + look)
end

xDTaraZ.Silent = {}

---@param forced boolean  ragebot shot: always hits, no fov
function xDTaraZ.Silent.Config(bone, forced)
    local o = xDTaraZ.Options
    if forced then return { Bone = bone, Visible = o.RageVisible, MaxDistance = o.RageMaxDistance, Priority = "Distance" } end
    return { Bone = bone, Fov = o.SilentFov, Visible = o.SilentVisible, MaxDistance = o.SilentMaxDistance, Priority = o.SilentPriority }
end

---@param payload table  ShootWeapon packet, edited in place
function xDTaraZ.Silent.Rewrite(payload)
    local o = xDTaraZ.Options
    local forced = o.Ragebot
    if not forced and not roll(o.SilentHitChance) then return end
    local bone = (forced or roll(o.SilentHeadChance)) and "Head" or "Torso"
    local target, part = xDTaraZ.Target.Pick(xDTaraZ.Silent.Config(bone, forced))
    xDTaraZ.State.SilentTarget = target
    if not part then return end
    local material = part.Material.Name
    for _, bullet in ipairs(payload.Bullets) do
        local origin = typeof(bullet.Origin) == "Vector3" and bullet.Origin or Workspace.CurrentCamera.CFrame.Position
        local offset = part.Position - origin
        local dist = offset.Magnitude
        if dist < xDTaraZ.Config.MinShotDistance then continue end
        local unit = offset / dist
        bullet.Direction = unit
        bullet.Hits = { { Instance = part, Position = part.Position, Normal = -unit, Material = material, Distance = dist, Exit = false } }
    end
    xDTaraZ.State.Redirected += 1
end

function xDTaraZ.Silent.InstallHook()
    local net = xDTaraZ.GameLib.Net
    local packet = net and net.Inventory and net.Inventory.ShootWeapon
    if not packet then return end
    local original
    original = xDTaraZ.Util.Hook("Shoot", packet.Send, function(payload, ...)
        if type(payload) == "table" and type(payload.Bullets) == "table" then
            xDTaraZ.State.LastShot = osClock()
            xDTaraZ.State.Shots += 1
            if xDTaraZ.Options.SilentAim or xDTaraZ.Options.Ragebot then
                local ok, err = pcall(xDTaraZ.Silent.Rewrite, payload)
                if not ok then warn("[BloxStrike] silent:", err) end
            end
        end
        return original(payload, ...)
    end)
end

xDTaraZ.Trigger = {}

function xDTaraZ.Trigger.Press(down)
    xDTaraZ.State.Firing = down
    if down then xDTaraZ.State.PressedAt = osClock() end
    local center = Workspace.CurrentCamera.ViewportSize / 2
    pcall(VirtualInputManager.SendMouseButtonEvent, VirtualInputManager, center.X, center.Y, 0, down, game, 0)
end

---@param want boolean  holds auto guns and re-clicks semi-auto ones
function xDTaraZ.Trigger.Fire(want)
    local state, now = xDTaraZ.State, osClock()
    if not want then
        if state.Firing then xDTaraZ.Trigger.Press(false) end
        return
    end
    if not state.Firing then
        xDTaraZ.Trigger.Press(true)
        return
    end
    local gap = xDTaraZ.Config.RefireGap
    if now - state.PressedAt > gap and now - state.LastShot > gap then xDTaraZ.Trigger.Press(false) end
end

function xDTaraZ.Trigger.Wanted()
    local o, state = xDTaraZ.Options, xDTaraZ.State
    if not o.Triggerbot then return false end
    local model = xDTaraZ.Target.UnderCrosshair()
    if model ~= state.TriggerModel then
        state.TriggerModel = model
        state.TriggerSeen = model and osClock() or nil
        state.TriggerRoll = model ~= nil and roll(o.TriggerHitChance)
    end
    if not model or not state.TriggerRoll then return false end
    return osClock() - state.TriggerSeen >= o.TriggerDelay / 1000
end

xDTaraZ.Rage = {}

function xDTaraZ.Rage.Step()
    local state = xDTaraZ.State
    if not xDTaraZ.Options.Ragebot then state.RageTarget, state.RagePart = nil, nil return false end
    state.RageTarget, state.RagePart = xDTaraZ.Target.Pick(xDTaraZ.Silent.Config("Head", true))
    return state.RageTarget ~= nil
end

xDTaraZ.Combat = { Circles = {} }

---@return ScreenGui  made once; hidden gui first, then CoreGui, then PlayerGui
function xDTaraZ.Combat.Screen()
    local screen = xDTaraZ.Combat.Gui
    if screen and screen.Parent then return screen end

    screen = Instance.new("ScreenGui")
    screen.Name = "MarioHubFov"
    screen.IgnoreGuiInset = true
    screen.ResetOnSpawn = false
    screen.DisplayOrder = xDTaraZ.Config.FovLayer

    local function Mount(parent) screen.Parent = parent end
    local okHui, hui = pcall(gethui)
    local mounted = okHui and hui ~= nil and pcall(Mount, hui)
    if not mounted then mounted = pcall(Mount, game:GetService("CoreGui")) end
    if not mounted then Mount(LocalPlayer:FindFirstChildOfClass("PlayerGui")) end

    xDTaraZ.Combat.Gui = screen
    return screen
end

---@return table  { Drawing = circle }, or { Frame = ring } drawn with Gui when Drawing is missing
function xDTaraZ.Combat.NewCircle(color)
    if xDTaraZ.Caps.Drawing then
        local circle = Drawing.new("Circle")
        circle.Thickness, circle.NumSides, circle.Filled, circle.Color = 1.5, 64, false, color
        return { Drawing = circle }
    end
    local frame = Instance.new("Frame")
    frame.AnchorPoint = vector2New(0.5, 0.5)
    frame.BackgroundTransparency = 1
    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(1, 0)
    round.Parent = frame
    local edge = Instance.new("UIStroke")
    edge.Thickness, edge.Color = 1.5, color
    edge.Parent = frame
    frame.Parent = xDTaraZ.Combat.Screen()
    return { Frame = frame }
end

function xDTaraZ.Combat.Circle(key, show, radius)
    local circle = xDTaraZ.Combat.Circles[key]
    if not circle then
        if not show then return end
        circle = xDTaraZ.Combat.NewCircle(xDTaraZ.Config.FovColors[key])
        xDTaraZ.Combat.Circles[key] = circle
    end
    local center = Workspace.CurrentCamera.ViewportSize / 2
    local drawing, frame = circle.Drawing, circle.Frame
    if drawing then
        drawing.Visible, drawing.Position, drawing.Radius = show, center, radius
        return
    end
    frame.Visible = show
    frame.Position = UDim2.fromOffset(center.X, center.Y)
    frame.Size = UDim2.fromOffset(radius * 2, radius * 2)
end

function xDTaraZ.Combat.Step()
    local o, state = xDTaraZ.Options, xDTaraZ.State
    xDTaraZ.Combat.Circle("Aimbot", o.AimbotShowFov, o.AimbotFov)
    xDTaraZ.Combat.Circle("Silent", o.SilentShowFov, o.SilentFov)
    if not xDTaraZ.Player.Alive() then
        state.AimTarget, state.AimPart, state.RageTarget, state.RagePart = nil, nil, nil, nil
        xDTaraZ.Trigger.Fire(false)
        return
    end
    xDTaraZ.Aimbot.Step()
    local rage = xDTaraZ.Rage.Step()
    xDTaraZ.Trigger.Fire(rage or xDTaraZ.Trigger.Wanted())
end

function xDTaraZ.Combat.Rest()
    local state = xDTaraZ.State
    state.AimTarget, state.AimPart, state.RageTarget, state.RagePart = nil, nil, nil, nil
    xDTaraZ.Trigger.Fire(false)
    for key in pairs(xDTaraZ.Combat.Circles) do
        xDTaraZ.Combat.Circle(key, false, 0)
    end
end

function xDTaraZ.Combat.Start()
    RunService:BindToRenderStep("xDTaraZAim", xDTaraZ.Config.AimRenderPriority, xDTaraZ.Aimbot.Lock)
    xDTaraZ:Connect(RunService.Heartbeat, function()
        local ok, err = pcall(xDTaraZ.Combat.Step)
        if ok then
            xDTaraZ.Faults.Clear("Combat")
        else
            xDTaraZ.Faults.Report("Combat", err, xDTaraZ.Config.CombatToggles, xDTaraZ.Combat.Rest)
        end
    end)
end

function xDTaraZ.Combat.Unload()
    xDTaraZ.Trigger.Fire(false)
    pcall(RunService.UnbindFromRenderStep, RunService, "xDTaraZAim")
    for key, circle in pairs(xDTaraZ.Combat.Circles) do
        xDTaraZ.Combat.Circles[key] = nil
        if circle.Frame then
            circle.Frame:Destroy()
        else
            pcall(function() circle.Drawing:Remove() end)
        end
    end
    if xDTaraZ.Combat.Gui then
        xDTaraZ.Combat.Gui:Destroy()
        xDTaraZ.Combat.Gui = nil
    end
end

xDTaraZ.Guns = { Signature = nil, Warned = false }

function xDTaraZ.Guns.HookKick()
    local cam = xDTaraZ.GameLib.Camera
    if not cam then return end
    local kick
    kick = xDTaraZ.Util.Hook("Kick", cam.weaponKick, function(...)
        local o = xDTaraZ.Options
        if o.NoRecoil then return end
        return kick(...)
    end)
end

---@return boolean  true while any scope or zoom is up
function xDTaraZ.Guns.Scoped()
    if LocalPlayer:GetAttribute("IsSniperScoped") == true then return true end
    local cam = xDTaraZ.GameLib.Camera
    local getter = cam and cam.getTargetFOV
    if type(getter) ~= "function" then return false end
    local ok, target = pcall(getter)
    if not ok or type(target) ~= "number" then return false end

    local state = xDTaraZ.State
    if target > state.FovBase then state.FovBase = target end
    return target < state.FovBase
end

function xDTaraZ.Guns.StepFov()
    if not xDTaraZ.Options.CameraFov or xDTaraZ.Guns.Scoped() then return end
    local camera = Workspace.CurrentCamera
    if camera then camera.FieldOfView = xDTaraZ.Options.CameraFovValue end
end

function xDTaraZ.Guns.BindFov()
    local state = xDTaraZ.State
    if state.FovBound then return end
    state.FovBound = true
    RunService:BindToRenderStep("xDTaraZFov", Enum.RenderPriority.Camera.Value + 3, xDTaraZ.Guns.StepFov)
end

function xDTaraZ.Guns.UnbindFov()
    xDTaraZ.State.FovBound = false
    pcall(RunService.UnbindFromRenderStep, RunService, "xDTaraZFov")
end

function xDTaraZ.Guns.FindClass()
    if not xDTaraZ.Caps.Gc or not xDTaraZ.Caps.HookFunction then return nil end
    for _, entry in ipairs(getgc(true)) do
        if type(entry) == "table" and rawget(entry, "getSpread") and rawget(entry, "shoot") and rawget(entry, "setupRecoil") then return entry end
    end
    return nil
end

function xDTaraZ.Guns.HookSpread()
    local class = xDTaraZ.Guns.FindClass()
    if not class then return end
    local spread
    spread = xDTaraZ.Util.Hook("Spread", class.getSpread, function(self, ...)
        if xDTaraZ.Options.NoSpread then return 0 end
        return spread(self, ...)
    end)
end

xDTaraZ.Esp = { Count = 0, Decoded = {} }

---@return table?  JSON attribute decoded once per distinct raw string
function xDTaraZ.Esp.Attr(owner, key)
    local raw = owner:GetAttribute(key)
    if type(raw) ~= "string" then return nil end
    local cache = xDTaraZ.Esp.Decoded
    if cache[raw] == nil then cache[raw] = xDTaraZ.Util.Decode(raw) or false end
    return cache[raw] or nil
end

---@return string  " C4 Kit Helmet Scoped" style tags, "" when none
function xDTaraZ.Esp.Flags(owner)
    if not owner then return "" end
    local flags = {}
    local armor = xDTaraZ.Esp.Attr(owner, "Armor")
    local bomb = xDTaraZ.Esp.Attr(owner, "Slot5")
    if bomb and bomb.Weapon == "C4" then flags[#flags + 1] = "C4" end
    if owner:GetAttribute("HasDefuseKit") == true then table.insert(flags, "Kit") end
    if armor and type(armor.Type) == "string" and armor.Type:find("Helmet") then flags[#flags + 1] = "Helmet" end
    if owner:GetAttribute("IsSniperScoped") == true then flags[#flags + 1] = "Scoped" end
    return #flags > 0 and " " .. table.concat(flags, " ") or ""
end

---@return Model?  whatever aimbot, silent aim or ragebot is locked on
function xDTaraZ.Esp.Focus()
    local state = xDTaraZ.State
    return state.AimTarget or state.SilentTarget or state.RageTarget
end

---@return table[]  targets in the shape Library.Visuals expects; bots count as enemies
function xDTaraZ.Esp.Targets()
    local list = {}
    local mine = xDTaraZ.Target.MyTeam()
    local focus = xDTaraZ.Esp.Focus()
    for _, model in ipairs(xDTaraZ.Target.Candidates()) do
        if tostring(model:GetAttribute("Dead")) == "true" then continue end
        local owner = xDTaraZ.Target.Owner(model)
        local equipped = owner and xDTaraZ.Util.Decode(owner:GetAttribute("CurrentEquipped"))
        local label = owner and owner.DisplayName or model.Name
        if equipped and equipped.Name then label = label .. " [" .. equipped.Name .. "]" end

        list[#list + 1] = {
            Model = model,
            Name = label .. xDTaraZ.Esp.Flags(owner),
            Health = tonumber(model:GetAttribute("Health")) or 100,
            MaxHealth = tonumber(model:GetAttribute("MaxHealth")) or 100,
            Friendly = mine ~= nil and xDTaraZ.Target.TeamOf(model) == mine,
            Root = model:FindFirstChild("HumanoidRootPart"),
            Color = model == focus and xDTaraZ.Config.EspFocusColor or nil,
        }
    end
    xDTaraZ.Esp.Count = #list
    return list
end

xDTaraZ.World = {}

function xDTaraZ.World.Step()
    local opts, state = xDTaraZ.Options, xDTaraZ.State
    if opts.Fullbright then
        state.LightSaved = state.LightSaved or { Lighting.Brightness, Lighting.ClockTime, Lighting.FogEnd, Lighting.GlobalShadows, Lighting.Ambient }
        Lighting.Brightness, Lighting.ClockTime, Lighting.FogEnd, Lighting.GlobalShadows = 2, 14, 1e6, false
        Lighting.Ambient = Color3.fromRGB(178, 178, 178)
    elseif state.LightSaved then
        Lighting.Brightness, Lighting.ClockTime, Lighting.FogEnd, Lighting.GlobalShadows, Lighting.Ambient = table.unpack(state.LightSaved)
        state.LightSaved = nil
    end
    if opts.NoFlash then xDTaraZ.World.ClearFlash() end
end

function xDTaraZ.World.ClearFlash()
    for _, effect in ipairs(Lighting:GetChildren()) do
        if effect.Name:lower():find("flash") and effect:IsA("PostEffect") then effect.Enabled = false end
    end
    local gui = LocalPlayer:FindFirstChild("PlayerGui")
    if not gui then return end
    for _, screen in ipairs(gui:GetChildren()) do
        if screen:IsA("ScreenGui") and screen.Name:lower():find("flash") then screen.Enabled = false end
    end
end

function xDTaraZ.World.OnDescendant(inst)
    if not xDTaraZ.Options.NoSmoke then return end
    if not (inst:IsA("ParticleEmitter") or inst:IsA("Smoke")) then return end
    local owner = inst:FindFirstAncestorOfClass("Model") or inst.Parent
    local name = (owner and owner.Name or ""):lower() .. inst.Name:lower()
    if name:find("smoke") then inst.Enabled = false end
end

function xDTaraZ.World.OnIdled()
    if not xDTaraZ.Options.AntiAfk then return end
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(vector2New())
    end)
end

function xDTaraZ.World.OnJump()
    if not xDTaraZ.Options.InfiniteJump or xDTaraZ.Player.Body() then return end
    local hum = xDTaraZ.Player.Humanoid()
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end

function xDTaraZ.World.SetCrouch(down)
    local state = xDTaraZ.State
    if state.HopCrouched == down then return end
    state.HopCrouched = down
    local controller = xDTaraZ.GameLib.Character
    if not controller then return end
    if not down and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then return end
    controller.crouch(down)
end

function xDTaraZ.World.OnSpace(input, down, processed)
    if input.KeyCode ~= Enum.KeyCode.Space then return end
    if down and (processed or UserInputService:GetFocusedTextBox()) then return end
    xDTaraZ.State.SpaceHeld = down
end

function xDTaraZ.World.Hop()
    local opts, state = xDTaraZ.Options, xDTaraZ.State
    local body = opts.BunnyHop and state.SpaceHeld and xDTaraZ.Player.Alive() and xDTaraZ.Player.Body()
    if not body or UserInputService:GetFocusedTextBox() then
        xDTaraZ.World.SetCrouch(false)
        return
    end
    local controller = xDTaraZ.GameLib.Character
    local grounded = body.OnGround == true
    xDTaraZ.World.SetCrouch(opts.BunnyCrouch and not grounded)
    controller.jump(false)
    if not grounded or osClock() - state.HopAt < xDTaraZ.Config.HopGap then return end
    state.HopAt = osClock()
    controller.jump()
end

function xDTaraZ.World.HopStep()
    local ok, err = pcall(xDTaraZ.World.Hop)
    if ok then
        xDTaraZ.Faults.Clear("Bunny Hop")
    else
        xDTaraZ.Faults.Report("Bunny Hop", err, { "BunnyHop" }, xDTaraZ.World.Hop)
    end
end

function xDTaraZ.World.Rejoin()
    pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, game.JobId, LocalPlayer)
end

function xDTaraZ.World.ServerHop()
    pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
end

xDTaraZ.Skins = { Map = {}, Applied = setmetatable({}, { __mode = "k" }), Catalog = nil, Rarity = {}, Images = {}, Colors = {} }

function xDTaraZ.Skins.Folder()
    local assets = ReplicatedStorage:FindFirstChild("Assets")
    return assets and assets:FindFirstChild("Skins")
end

---@return string?  category name, nil = not a weapon look
function xDTaraZ.Skins.CategoryOf(name, kind)
    local mapped = xDTaraZ.Config.SkinKinds[kind]
    if mapped then return mapped end
    if kind ~= "Weapon" then return nil end
    local gun = xDTaraZ.Weapons[name]
    return gun and gun.Type or "Other"
end

function xDTaraZ.Skins.Build()
    local skins = xDTaraZ.Skins
    local folder = skins.Folder()
    local listing = xDTaraZ.Util.Decode(ReplicatedStorage:GetAttribute("AvaiableSkins")) or {}
    local ranks = xDTaraZ.Config.SkinRanks
    local catalog = {}
    for name, entries in pairs(listing) do
        if type(entries) ~= "table" or not (folder and folder:FindFirstChild(name)) then continue end
        local _, first = next(entries)
        local category = skins.CategoryOf(name, type(first) == "table" and first.type)
        if not category then continue end
        catalog[category] = catalog[category] or {}
        table.insert(catalog[category], name)
        skins.Rarity[name], skins.Images[name], skins.Colors[name] = {}, {}, {}
        for skin, entry in pairs(entries) do
            if type(entry) ~= "table" then continue end
            skins.Rarity[name][skin] = ranks[entry.rarity] or 0
            local look = type(entry.wearImages) == "table" and entry.wearImages[1]
            skins.Images[name][skin] = look and look.assetId
            local rarity = xDTaraZ.GameLib.Rarities and xDTaraZ.GameLib.Rarities[entry.rarity]
            skins.Colors[name][skin] = type(rarity) == "table" and rarity.Color or nil
        end
    end
    for _, names in pairs(catalog) do table.sort(names) end
    skins.Catalog = catalog
end

---@return string[]  categories in display order
function xDTaraZ.Skins.Categories()
    if not xDTaraZ.Skins.Catalog then xDTaraZ.Skins.Build() end
    local list, seen = {}, {}
    for _, category in ipairs(xDTaraZ.Config.SkinOrder) do
        if xDTaraZ.Skins.Catalog[category] then list[#list + 1] = category seen[category] = true end
    end
    for category in pairs(xDTaraZ.Skins.Catalog) do
        if not seen[category] then list[#list + 1] = category end
    end
    if #list == 0 then list[1] = "-" end
    return list
end

function xDTaraZ.Skins.Items(category)
    if not xDTaraZ.Skins.Catalog then xDTaraZ.Skins.Build() end
    local names = xDTaraZ.Skins.Catalog[category or ""]
    return (names and #names > 0) and names or { "-" }
end

---@return string[]  rarest first
function xDTaraZ.Skins.List(weapon)
    local folder = xDTaraZ.Skins.Folder()
    local holder = folder and folder:FindFirstChild(weapon or "")
    if not holder then return { "-" } end
    local ranks = xDTaraZ.Skins.Rarity[weapon] or {}
    local names = {}
    for _, child in ipairs(holder:GetChildren()) do names[#names + 1] = child.Name end
    table.sort(names, function(a, b)
        local ra, rb = ranks[a] or 0, ranks[b] or 0
        if ra ~= rb then return ra > rb end
        return a < b
    end)
    return #names > 0 and names or { "-" }
end

---@param view string  "Camera" or "Character"
---@return Folder?     best wear available
function xDTaraZ.Skins.Source(weapon, skin, view)
    local folder = xDTaraZ.Skins.Folder()
    local paint = folder and folder:FindFirstChild(weapon) and folder[weapon]:FindFirstChild(skin)
    local side = paint and paint:FindFirstChild(view)
    if not side then return nil end
    for _, wear in ipairs(xDTaraZ.Config.SkinWears) do
        if side:FindFirstChild(wear) then return side[wear] end
    end
    return side:FindFirstChildOfClass("Folder")
end

function xDTaraZ.Skins.Paint(model, weapon, skin, view)
    local source = xDTaraZ.Skins.Source(weapon, skin, view)
    if not source then return false end
    local whole = source:FindFirstChild("SurfaceAppearance")
    local arms = xDTaraZ.Config.SkinArms
    for _, part in ipairs(model:GetDescendants()) do
        if not part:IsA("BasePart") then continue end
        local old = part:FindFirstChildOfClass("SurfaceAppearance")
        local look = source:FindFirstChild(part.Name)
        if not look and whole and old and not arms[part.Name] then look = whole end
        if not look then continue end
        if old then old:Destroy() end
        look:Clone().Parent = part
    end
    return true
end

function xDTaraZ.Skins.WeaponOf(model)
    local folder = xDTaraZ.Skins.Folder()
    if folder and folder:FindFirstChild(model.Name) then return model.Name end
    local equipped = xDTaraZ.Player.Equipped()
    return equipped and (equipped.Weapon or equipped.Name)
end

function xDTaraZ.Skins.Models()
    local list = {}
    for _, child in ipairs(Workspace.CurrentCamera:GetChildren()) do
        if child:IsA("Model") then list[#list + 1] = { child, "Camera" } end
    end
    local char = xDTaraZ.Player.Character()
    local folder = xDTaraZ.Skins.Folder()
    if char and folder then
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Model") and folder:FindFirstChild(child.Name) then list[#list + 1] = { child, "Character" } end
        end
    end
    return list
end

function xDTaraZ.Skins.Step()
    local skins = xDTaraZ.Skins
    local on = xDTaraZ.Options.SkinChanger
    local glove = on and skins.Map[xDTaraZ.Config.GloveKey]
    local gloveSkin = glove and skins.Map[glove]
    for _, entry in ipairs(skins.Models()) do
        local model, view = entry[1], entry[2]
        local weapon = skins.WeaponOf(model)
        local skin = weapon and (on and skins.Map[weapon] or (skins.Applied[model] and "Stock"))
        local key = tostring(weapon) .. "|" .. tostring(skin) .. "|" .. tostring(gloveSkin)
        if skins.Applied[model] == key or not (skin or gloveSkin) then continue end
        if skin then skins.Paint(model, weapon, skin, view) end
        if gloveSkin and view == "Camera" then skins.Paint(model, glove, gloveSkin, view) end
        skins.Applied[model] = on and key or nil
    end
end

function xDTaraZ.Skins.Set(weapon, skin, quiet)
    if not weapon or weapon == "-" or not skin or skin == "-" then return false end
    local map, gloveKey = xDTaraZ.Skins.Map, xDTaraZ.Config.GloveKey
    local isGlove = xDTaraZ.Skins.Catalog and table.find(xDTaraZ.Skins.Catalog.Gloves or {}, weapon)
    if skin == "Default" then
        if map[weapon] == nil then return false end
        map[weapon] = nil
        if map[gloveKey] == weapon then map[gloveKey] = nil end
    else
        if map[weapon] == skin then return false end
        map[weapon] = skin
        if isGlove then map[gloveKey] = weapon end
    end
    if not quiet then xDTaraZ.Skins.Save() end
    return true
end

---@param pick fun(list: string[]): string  chooses one skin per item
---@return number  items changed
function xDTaraZ.Skins.SetAll(pick)
    local count = 0
    for _, category in ipairs(xDTaraZ.Skins.Categories()) do
        if category == "Gloves" then continue end
        for _, weapon in ipairs(xDTaraZ.Skins.Items(category)) do
            xDTaraZ.Skins.Set(weapon, pick(xDTaraZ.Skins.List(weapon)), true)
            count += 1
        end
    end
    xDTaraZ.Skins.Save()
    return count
end

function xDTaraZ.Skins.Save()
    if type(writefile) ~= "function" then return end
    local ok, err = pcall(function()
        if type(isfolder) == "function" and not isfolder(xDTaraZ.Config.SaveFolder) then makefolder(xDTaraZ.Config.SaveFolder) end
        writefile(xDTaraZ.Config.SkinFile, HttpService:JSONEncode(xDTaraZ.Skins.Map))
    end)
    if not ok then warn("[BloxStrike] skins save:", err) end
end

function xDTaraZ.Skins.Load()
    if type(readfile) ~= "function" or type(isfile) ~= "function" then return end
    local ok, raw = pcall(function() return isfile(xDTaraZ.Config.SkinFile) and readfile(xDTaraZ.Config.SkinFile) end)
    local map = ok and xDTaraZ.Util.Decode(raw)
    if type(map) == "table" then xDTaraZ.Skins.Map = map end
end

xDTaraZ.Economy = {}

function xDTaraZ.Economy.RedeemAll()
    local net = xDTaraZ.GameLib.Net
    local packet = net and net.Dashboard and net.Dashboard.RedeemCode
    if not packet then return 0 end
    local sent = 0
    for _, code in ipairs(xDTaraZ.Config.Codes) do
        if pcall(packet.Send, code) then sent += 1 end
        task.wait(xDTaraZ.Config.RedeemGap)
    end
    return sent
end

function xDTaraZ.Economy.HookBuys()
    local net = xDTaraZ.GameLib.Net
    local packet = net and net.Inventory and net.Inventory.BuyMenuPurchase
    if not packet then return end
    local original
    original = xDTaraZ.Util.Hook("Buy", packet.Send, function(payload, ...)
        if type(payload) == "table" and payload.Name and not xDTaraZ.State.Replaying then
            local list = xDTaraZ.State.Bought
            for index, entry in ipairs(list) do
                if entry.Name == payload.Name then table.remove(list, index) break end
            end
            list[#list + 1] = { Equipment = payload.Equipment, Path = payload.Path, Name = payload.Name }
        end
        return original(payload, ...)
    end)
end

function xDTaraZ.Economy.Rebuy()
    local net = xDTaraZ.GameLib.Net
    local packet = net and net.Inventory and net.Inventory.BuyMenuPurchase
    if not packet or #xDTaraZ.State.Bought == 0 then return 0 end
    xDTaraZ.State.Replaying = true
    local sent = 0
    for _, entry in ipairs(xDTaraZ.State.Bought) do
        if pcall(packet.Send, { Equipment = entry.Equipment, Path = entry.Path, Name = entry.Name }) then sent += 1 end
        task.wait(xDTaraZ.Config.RebuyGap)
    end
    xDTaraZ.State.Replaying = false
    return sent
end

function xDTaraZ.Economy.Step()
    if not xDTaraZ.Options.AutoRebuy or not xDTaraZ.Player.Alive() then return end
    if not xDTaraZ.Config.BuyStates[Workspace:GetAttribute("GameState")] then return end
    local round = tostring(Workspace:GetAttribute("MatchSessionId")) .. ":" .. tostring((Workspace:GetAttribute("TScore") or 0) + (Workspace:GetAttribute("CTScore") or 0))
    if xDTaraZ.State.LastRebuyRound == round then return end
    xDTaraZ.State.LastRebuyRound = round
    task.spawn(xDTaraZ.Economy.Rebuy)
end

function xDTaraZ.Economy.BoughtText()
    local names = {}
    for _, entry in ipairs(xDTaraZ.State.Bought) do names[#names + 1] = entry.Name end
    return #names > 0 and table.concat(names, ", ") or "-"
end

xDTaraZ.Spectators = {}

function xDTaraZ.Spectators.Text()
    local count = tonumber(LocalPlayer:GetAttribute("Spectators")) or 0
    if count == 0 then return "None" end
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and tostring(player:GetAttribute("IsSpectating")) == "true" and tostring(player:GetAttribute("Dead")) == "true" then
            names[#names + 1] = player.DisplayName
        end
    end
    return count .. " watching" .. (#names > 0 and (" (dead: " .. table.concat(names, ", ") .. ")") or "")
end

xDTaraZ.Faults = { Streaks = {} }

function xDTaraZ.Faults.Clear(name)
    xDTaraZ.Faults.Streaks[name] = nil
end

function xDTaraZ.Faults.AnyOn(toggles)
    for _, key in ipairs(toggles) do
        if xDTaraZ.Options[key] then return true end
    end
    return false
end

---@param restore function?  the feature's own off path
function xDTaraZ.Faults.Halt(name, err, toggles, restore)
    warn("[BloxStrike] " .. name .. " stopped:", err)
    for _, key in ipairs(toggles) do
        xDTaraZ.Options[key] = false
    end
    if restore then xDTaraZ.Util.Try(name .. " restore", restore) end
    local halted = xDTaraZ.State.Halted
    halted[#halted + 1] = { name, tostring(err):match("^[^\n]*"), toggles }
end

---@param toggles string[]   turned off once the feature keeps failing; empty = keeps running, warns once per streak
---@param restore function?  run once when the feature is stopped
---@return boolean           true while the feature is stopped
function xDTaraZ.Faults.Report(name, err, toggles, restore)
    local now, streaks = osClock(), xDTaraZ.Faults.Streaks
    local streak = streaks[name]
    if not streak or (streak.Halted and xDTaraZ.Faults.AnyOn(toggles)) then
        streak = { Count = 0, First = now, Warned = false, Halted = false }
        streaks[name] = streak
    end
    streak.Count += 1
    if streak.Warned then return streak.Halted end
    if streak.Count < xDTaraZ.Config.MaxFails or now - streak.First < xDTaraZ.Config.FailWindow then return false end

    streak.Warned = true
    if #toggles == 0 then
        warn("[BloxStrike] " .. name .. " keeps failing:", err)
        return false
    end
    streak.Halted = true
    xDTaraZ.Faults.Halt(name, err, toggles, restore)
    return true
end

xDTaraZ.Scheduler = { Jobs = {} }

---@param toggles string[]   options the job serves; switched off if it keeps failing
---@param restore function?  the job's off path, run once if it gets stopped
function xDTaraZ.Scheduler.Every(name, interval, fn, toggles, restore)
    xDTaraZ.Scheduler.Jobs[name] = { Interval = interval, Fn = fn, Next = 0, Toggles = toggles, Restore = restore }
end

---@return boolean  a halted job runs again once one of its toggles is back on
function xDTaraZ.Scheduler.Resume(name, job)
    if not xDTaraZ.Faults.AnyOn(job.Toggles) then return false end
    job.Halted = false
    xDTaraZ.Faults.Clear(name)
    return true
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ:Connect(RunService.Heartbeat, function()
        local now = osClock()
        for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
            if now < job.Next then continue end
            job.Next = now + job.Interval
            if job.Halted and not xDTaraZ.Scheduler.Resume(name, job) then continue end

            local ok, err = pcall(job.Fn)
            if ok then
                xDTaraZ.Faults.Clear(name)
            else
                job.Halted = xDTaraZ.Faults.Report(name, err, job.Toggles, job.Restore)
            end
        end
    end)
end

xDTaraZ.UI = { Labels = {} }

function xDTaraZ.UI.Detach(fn)
    return function(...)
        local packed = table.pack(...)
        task.defer(function()
            local ok, err = pcall(fn, table.unpack(packed, 1, packed.n))
            if not ok then warn("[BloxStrike] ui:", err) end
        end)
    end
end

function xDTaraZ.UI.Bind(widget, key)
    local function Apply(value) xDTaraZ.Options[key] = value end
    Apply(widget.Value)
    widget:OnChanged(Apply)
end

function xDTaraZ.UI.AddKeyMode(group, toggleIdx, keyIdx, default)
    group:AddDropdown(toggleIdx .. "Mode", { Text = T("Key mode", "โหมดปุ่ม"), Values = { "Hold", "Toggle", "Always" }, Default = default, Callback = function(mode)
        local picker = Library.Options[keyIdx]
        if picker then picker:SetValue({ picker.Value, mode }) end
    end })
end

---Toggle that keeps its info, so the library's "not supported" / "not available" notices name the feature instead of the idx.
function xDTaraZ.UI.NamedToggle(group, idx, info)
    local toggle = group:AddToggle(idx, info)
    toggle.Info = toggle.Info or info
    return toggle
end

function xDTaraZ.UI.BuildMain(window)
    window:AddTabSection(T("Main", "หลัก"))
    local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and links", "สถานะและลิงก์"))

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
    xDTaraZ.UI.Labels.Match = status:AddParagraph({ Title = T("Match", "แมตช์"), Content = "-" })
    xDTaraZ.UI.Labels.Combat = status:AddParagraph({ Title = T("Combat", "การต่อสู้"), Content = "-" })
    xDTaraZ.UI.Labels.Spectators = status:AddParagraph({ Title = T("Spectators", "คนดูเรา"), Content = "-" })
    xDTaraZ.UI.Labels.Esp = status:AddParagraph({ Title = T("ESP", "ESP"), Content = "-" })

    local discord = tab:AddRightGroupbox(T("Discord", "ดิสคอร์ด"), "link")
    discord:AddLabel(xDTaraZ.Config.Discord)
    discord:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ดิสคอร์ด"), Func = xDTaraZ.UI.Detach(function()
        if xDTaraZ.Util.Copy(xDTaraZ.Config.Discord) then
            Library:Notify(T("Discord", "ดิสคอร์ด"), T("Link copied", "คัดลอกลิงก์แล้ว"), 3, "Success")
        else
            Library:Notify(T("Discord", "ดิสคอร์ด"), xDTaraZ.Config.Discord, 6, "Info")
        end
    end) })

    local logBox = tab:AddRightGroupbox(T("Update Log", "อัปเดตล่าสุด"), "bell")
    for i = 1, math.min(2, #xDTaraZ.Config.UpdateLog) do
        local entry = xDTaraZ.Config.UpdateLog[i]
        logBox:AddParagraph({ Title = entry[1], Content = entry[2] })
    end
end

local priorities = { "Crosshair", "Distance", "Health" }

function xDTaraZ.UI.BuildAimbot(window)
    window:AddTabSection(T("Combat", "การต่อสู้"))
    local tab = window:AddTab(T("Aimbot", "เล็งอัตโนมัติ"), "crosshair", T("Locks your camera onto enemies", "ล็อคกล้องไปที่ศัตรู"))

    local main = tab:AddLeftGroupbox(T("Aimbot", "เล็งอัตโนมัติ"), "crosshair")
    main:AddToggle("Aimbot", { Text = T("Aimbot", "เล็งอัตโนมัติ"), Description = T("Locks your view onto the enemy in the FOV", "ล็อคกล้องไปที่ศัตรูในวง FOV") })
        :AddKeyPicker("AimbotKey", { Default = "E", Mode = "Hold" })
    xDTaraZ.UI.AddKeyMode(main, "Aimbot", "AimbotKey", "Hold")
    main:AddSlider("AimbotSmooth", { Text = T("Smoothness", "ความนุ่ม"), Description = T("1 = instant snap", "1 = หันทันที"), Min = 1, Max = 20, Default = 1, Rounding = 0 })
    main:AddCheckbox("AimbotSticky", { Text = T("Sticky target", "ล็อคเป้าเดิม"), Description = T("Keeps the same enemy until it is lost", "ไม่สลับเป้าจนกว่าเป้าเดิมจะหลุด"), Default = true })

    local target = tab:AddRightGroupbox(T("Aimbot Targeting", "การเลือกเป้า (เล็ง)"), "target")
    target:AddDropdown("AimbotBone", { Text = T("Aim part", "จุดที่เล็ง"), Values = { "Head", "Torso" }, Default = "Head" })
    target:AddDropdown("AimbotPriority", { Text = T("Priority", "เลือกเป้าตาม"), Values = priorities, Default = "Crosshair" })
    target:AddCheckbox("AimbotVisible", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Default = true })
    target:AddSlider("AimbotFov", { Text = T("FOV", "ขนาดวง"), Min = 20, Max = 800, Default = 150, Suffix = "px" })
    target:AddToggle("AimbotShowFov", { Text = T("Show FOV circle", "แสดงวง FOV") })
    target:AddSlider("AimbotMaxDistance", { Text = T("Max distance", "ระยะสูงสุด"), Min = 50, Max = 3000, Default = 1500, Suffix = "m" })
end

function xDTaraZ.UI.BuildSilent(window)
    local tab = window:AddTab(T("Silent Aim", "ไซเลนต์เอม"), "bomb", T("Your shots find the enemy for you", "กระสุนวิ่งหาศัตรูเอง"))

    local main = tab:AddLeftGroupbox(T("Silent Aim", "ไซเลนต์เอม"), "bomb")
    xDTaraZ.UI.NamedToggle(main, "SilentAim", { Text = T("Silent aim", "ไซเลนต์เอม"), Description = T("Shots you fire go to the enemy in the FOV", "นัดที่ยิงพุ่งไปหาศัตรูในวง FOV"), Risky = true })
        :AddKeyPicker("SilentKey", { Default = "None", Mode = "Toggle" })
    main:AddSlider("SilentHitChance", { Text = T("Hit chance", "โอกาสโดน"), Description = T("Lower looks more legit", "ยิ่งต่ำยิ่งดูเนียน"), Min = 1, Max = 100, Default = 100, Rounding = 0, Suffix = "%" })
    main:AddSlider("SilentHeadChance", { Text = T("Headshot chance", "โอกาสเข้าหัว"), Description = T("The rest go to the body", "ที่เหลือเข้าลำตัว"), Min = 0, Max = 100, Default = 100, Rounding = 0, Suffix = "%" })
    Library.Compat.NeedCap("SilentAim", "HookFunction")

    local target = tab:AddRightGroupbox(T("Silent Targeting", "การเลือกเป้า (ไซเลนต์)"), "target")
    target:AddDropdown("SilentPriority", { Text = T("Priority", "เลือกเป้าตาม"), Values = priorities, Default = "Crosshair" })
    target:AddCheckbox("SilentVisible", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Description = T("Off = also through walls", "ปิด = ยิงทะลุกำแพงด้วย"), Default = true })
    target:AddSlider("SilentFov", { Text = T("FOV", "ขนาดวง"), Min = 20, Max = 1000, Default = 220, Suffix = "px" })
    target:AddToggle("SilentShowFov", { Text = T("Show FOV circle", "แสดงวง FOV") })
    target:AddSlider("SilentMaxDistance", { Text = T("Max distance", "ระยะสูงสุด"), Min = 50, Max = 3000, Default = 2000, Suffix = "m" })
end

function xDTaraZ.UI.BuildTrigger(window)
    local tab = window:AddTab(T("Trigger & Rage", "ยิงออโต้ & เรจ"), "zap", T("Shoots for you", "ยิงให้อัตโนมัติ"))

    local trigger = tab:AddLeftGroupbox(T("Triggerbot", "ยิงอัตโนมัติ"), "zap")
    trigger:AddToggle("Triggerbot", { Text = T("Triggerbot", "ยิงอัตโนมัติ"), Description = T("Fires the moment an enemy is under your crosshair", "ยิงทันทีที่ศัตรูอยู่ใต้เป้า") })
        :AddKeyPicker("TriggerKey", { Default = "T", Mode = "Toggle" })
    xDTaraZ.UI.AddKeyMode(trigger, "Triggerbot", "TriggerKey", "Toggle")
    trigger:AddSlider("TriggerDelay", { Text = T("Reaction delay", "ดีเลย์ก่อนยิง"), Min = 0, Max = 400, Default = 0, Rounding = 0, Suffix = "ms" })
    trigger:AddSlider("TriggerHitChance", { Text = T("Fire chance", "โอกาสยิง"), Min = 1, Max = 100, Default = 100, Rounding = 0, Suffix = "%" })

    local rage = tab:AddRightGroupbox(T("Ragebot", "เรจบอท"), "bomb")
    xDTaraZ.UI.NamedToggle(rage, "Ragebot", { Text = T("Ragebot", "เรจบอท"), Description = T("Snaps to and kills any enemy it can reach on its own", "หันไปยิงศัตรูที่ยิงถึงเองทันที"), Risky = true })
        :AddKeyPicker("RageKey", { Default = "None", Mode = "Toggle" })
    rage:AddCheckbox("RageVisible", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Description = T("Off = also through walls", "ปิด = ยิงทะลุกำแพงด้วย"), Default = true })
    rage:AddSlider("RageMaxDistance", { Text = T("Max distance", "ระยะสูงสุด"), Min = 50, Max = 3000, Default = 2000, Suffix = "m" })
    Library.Compat.NeedCap("Ragebot", "HookFunction")
end

function xDTaraZ.UI.BuildGuns(window)
    local tab = window:AddTab(T("Gun Mods", "ม็อดปืน"), "swords", T("Recoil and spread", "แรงถีบและการกระจาย"))

    local mods = tab:AddLeftGroupbox(T("Gun Mods", "ม็อดปืน"), "swords")
    xDTaraZ.UI.NamedToggle(mods, "NoRecoil", { Text = T("No recoil", "ไม่มีแรงถีบ"), Description = T("Your view stays still while spraying", "จอนิ่งตอนกดยิงค้าง") })
    xDTaraZ.UI.NamedToggle(mods, "NoSpread", { Text = T("No spread", "ไม่มีการกระจาย"), Description = T("Every bullet lands on the crosshair", "ทุกนัดลงกลางเป้า") })
    Library.Compat.NeedCap("NoRecoil", "HookFunction")
    Library.Compat.NeedCap("NoSpread", { "HookFunction", "Gc" })
end

function xDTaraZ.UI.BuildVisuals(window)
    window:AddTabSection(T("Visuals", "การมองเห็น"))
    xDTaraZ.Util.Try("visuals tab", function()
        window:AddVisualsTab({ Provider = xDTaraZ.Esp.Targets, Preview = true })
    end)

    local tab = window:AddTab(T("World", "โลก"), "globe", T("Lighting, flash and smoke", "แสง แฟลช และควัน"))
    local world = tab:AddLeftGroupbox(T("World", "โลก"), "flower")
    world:AddToggle("Fullbright", { Text = T("Fullbright", "สว่างทั้งแมพ") })
    world:AddToggle("NoFlash", { Text = T("No flash", "กันแฟลช"), Description = T("Flashbangs do not blind you", "แฟลชไม่ทำให้ตาบอด") })
    world:AddToggle("NoSmoke", { Text = T("No smoke", "ไม่มีควัน"), Description = T("See through smoke grenades", "มองทะลุควัน") })

    local cam = tab:AddRightGroupbox(T("Camera", "กล้อง"), "eye")
    xDTaraZ.UI.NamedToggle(cam, "CameraFov", { Text = T("Custom FOV", "ปรับมุมมอง") })
    cam:AddSlider("CameraFovValue", { Text = T("FOV", "มุมมอง"), Min = 70, Max = 120, Default = 100, Rounding = 0 })
end

local skinTitles = {
    Pistol = { "Pistols", "ปืนพก", "coin" },
    SMG = { "SMGs", "ปืนกลมือ", "zap" },
    Rifle = { "Rifles", "ปืนไรเฟิล", "crosshair" },
    Sniper = { "Snipers", "สไนเปอร์", "target" },
    Heavy = { "Heavy", "ปืนหนัก", "bomb" },
    Shotgun = { "Shotguns", "ลูกซอง", "bomb" },
    ["Machine Gun"] = { "Machine Guns", "ปืนกล", "zap" },
    Knives = { "Knives", "มีด", "swords" },
    Gloves = { "Gloves", "ถุงมือ", "shield" },
    Grenades = { "Grenades", "ระเบิด", "bomb" },
    Gear = { "Gear", "อุปกรณ์", "gear" },
}

function xDTaraZ.UI.SkinGroup(tab, category, side)
    local title = skinTitles[category] or { category, category, "star" }
    local group = side == "Left" and tab:AddLeftGroupbox(T(title[1], title[2]), title[3]) or tab:AddRightGroupbox(T(title[1], title[2]), title[3])
    for _, weapon in ipairs(xDTaraZ.Skins.Items(category)) do
        if weapon == "-" then continue end
        local values = { "Default" }
        for _, skin in ipairs(xDTaraZ.Skins.List(weapon)) do values[#values + 1] = skin end
        group:AddDropdown("Skin_" .. weapon, { Text = weapon, Values = values, Default = xDTaraZ.Skins.Map[weapon] or "Default", Searchable = true, Images = xDTaraZ.Skins.Images[weapon], Colors = xDTaraZ.Skins.Colors[weapon], Callback = function(skin)
            xDTaraZ.Skins.Set(weapon, skin)
        end })
    end
end

---@param heights table  rows used per side so far, updated in place
function xDTaraZ.UI.PlaceSkinGroup(tab, category, heights)
    local side = heights.Left <= heights.Right and "Left" or "Right"
    local rows = 1
    for _, weapon in ipairs(xDTaraZ.Skins.Items(category)) do
        if weapon ~= "-" then rows += 1 end
    end
    if rows == 1 then return end
    heights[side] += rows
    xDTaraZ.Util.Try("skins " .. category, xDTaraZ.UI.SkinGroup, tab, category, side)
end

function xDTaraZ.UI.SyncSkins()
    for _, category in ipairs(xDTaraZ.Skins.Categories()) do
        for _, weapon in ipairs(xDTaraZ.Skins.Items(category)) do
            local picker = Library.Options["Skin_" .. weapon]
            if picker then picker:SetValue(xDTaraZ.Skins.Map[weapon] or "Default") end
        end
    end
end

function xDTaraZ.UI.BuildSkins(window)
    local tab = window:AddTab(T("Skins", "สกิน"), "star", T("Any skin, only on your screen", "ใส่สกินไหนก็ได้ เห็นแค่บนจอคุณ"))

    local main = tab:AddLeftGroupbox(T("Skin Changer", "เปลี่ยนสกิน"), "star")
    main:AddToggle("SkinChanger", { Text = T("Skin changer", "เปลี่ยนสกิน"), Description = T("Pick a skin below and it shows right away", "เลือกสกินด้านล่างแล้วขึ้นทันที") })
    main:AddButton({ Text = T("Rarest On Everything", "หายากสุดทุกอัน"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        local count = xDTaraZ.Skins.SetAll(function(list) return list[1] end)
        xDTaraZ.UI.SyncSkins()
        Library:Notify("Skins", "Set " .. count .. " items", 3, "Success")
    end) })
    main:AddButton({ Text = T("Random", "สุ่ม"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.Skins.SetAll(function(list) return list[math.random(#list)] end)
        xDTaraZ.UI.SyncSkins()
    end) }):AddButton({ Text = T("Reset All", "ล้างทั้งหมด"), Style = "Danger", Func = xDTaraZ.UI.Detach(function()
        table.clear(xDTaraZ.Skins.Map)
        xDTaraZ.Skins.Save()
        xDTaraZ.UI.SyncSkins()
    end) })

    local gear = { Knives = true, Gloves = true, Grenades = true, Gear = true }
    local heights = { Left = xDTaraZ.Config.SkinMainRows, Right = 0 }
    for _, category in ipairs({ "Knives", "Gloves", "Grenades", "Gear" }) do
        xDTaraZ.UI.PlaceSkinGroup(tab, category, heights)
    end

    local guns = window:AddTab(T("Gun Skins", "สกินปืน"), "crosshair", T("Skins for every gun", "สกินปืนทุกกระบอก"))
    heights = { Left = 0, Right = 0 }
    local ok, categories = pcall(xDTaraZ.Skins.Categories)
    for _, category in ipairs(ok and categories or {}) do
        if gear[category] then continue end
        xDTaraZ.UI.PlaceSkinGroup(guns, category, heights)
    end
end

function xDTaraZ.UI.BuildMisc(window)
    window:AddTabSection(T("Misc", "อื่นๆ"))
    local tab = window:AddTab(T("Misc", "อื่นๆ"), "gear", T("Buying, codes and utility", "ซื้อของ โค้ด และอื่นๆ"))

    local buy = tab:AddLeftGroupbox(T("Auto Buy", "ซื้ออัตโนมัติ"), "shop")
    xDTaraZ.UI.NamedToggle(buy, "AutoRebuy", { Text = T("Auto rebuy", "ซื้อซ้ำอัตโนมัติ"), Description = T("Buys your last loadout every round", "ซื้อชุดล่าสุดของคุณให้ทุกรอบ") })
    Library.Compat.NeedCap("AutoRebuy", "HookFunction")
    xDTaraZ.UI.Labels.Bought = buy:AddParagraph({ Title = T("Saved loadout", "ชุดที่จำไว้"), Content = "-" })
    buy:AddButton({ Text = T("Rebuy Now", "ซื้อซ้ำตอนนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        local sent = xDTaraZ.Economy.Rebuy()
        Library:Notify("Auto Buy", sent > 0 and ("Bought " .. sent .. " items") or "Buy something once first", 3, sent > 0 and "Success" or "Info")
    end) }):AddButton({ Text = T("Clear", "ล้าง"), Func = xDTaraZ.UI.Detach(function()
        table.clear(xDTaraZ.State.Bought)
    end) })

    local codes = tab:AddLeftGroupbox(T("Codes", "โค้ด"), "key")
    codes:AddButton({ Text = T("Redeem All Codes", "แลกโค้ดทั้งหมด"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        local sent = xDTaraZ.Economy.RedeemAll()
        Library:Notify("Codes", "Sent " .. sent .. " codes (level 5+ needed)", 4, "Coin")
    end) })

    local util = tab:AddRightGroupbox(T("Utility", "อรรถประโยชน์"), "flower")
    util:AddToggle("InfiniteJump", { Text = T("Infinite jump", "กระโดดไม่จำกัด"), Description = T("Lobby only, use Bunny hop in rounds", "ใช้ได้เฉพาะล็อบบี้ ในรอบใช้บันนี่ฮอป"), Risky = true })
    util:AddToggle("BunnyHop", { Text = T("Bunny hop", "บันนี่ฮอป"), Description = T("Hold Space to keep hopping and carry your speed", "กด Space ค้างเพื่อกระโดดต่อเนื่องและรักษาความเร็ว"), Risky = true })
    util:AddCheckbox("BunnyCrouch", { Text = T("Crouch jump", "ย่อตอนลอย"), Description = T("Crouches in the air like a CS crouch jump", "ย่อตัวกลางอากาศแบบ crouch jump ใน CS"), Default = true })
    util:AddToggle("AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK") })
    util:AddButton({ Text = T("Rejoin", "เข้าใหม่"), Func = xDTaraZ.UI.Detach(xDTaraZ.World.Rejoin) })
        :AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Func = xDTaraZ.UI.Detach(xDTaraZ.World.ServerHop) })
end

function xDTaraZ.UI.RefreshStatus()
    local labels, state = xDTaraZ.UI.Labels, xDTaraZ.State
    if labels.Match then
        labels.Match:SetText(("%s | %s | $%s"):format(tostring(Workspace:GetAttribute("Map") or "-"), tostring(Workspace:GetAttribute("GameState") or "-"), tostring(LocalPlayer:GetAttribute("Money") or 0)))
    end
    if labels.Combat then
        local target = state.RageTarget or state.AimTarget or state.SilentTarget
        target = target and target.Name or "none"
        labels.Combat:SetText(("Target: %s | Kills %s | Shots %d | Aimed %d"):format(target, tostring(LocalPlayer:GetAttribute("Kills") or 0), state.Shots, state.Redirected))
    end
    if labels.Spectators then labels.Spectators:SetText(xDTaraZ.Spectators.Text()) end
    if labels.Esp then
        local visuals = Library.Visuals
        labels.Esp:SetText((visuals and visuals:Get("Enabled")) and (xDTaraZ.Esp.Count .. " players") or "Off")
    end
    if labels.Bought then labels.Bought:SetText(xDTaraZ.Economy.BoughtText()) end
end

---Turns off what the scheduler halted and shows queued notices; runs on the UI pump, never on a game thread.
function xDTaraZ.UI.Drain()
    local state = xDTaraZ.State
    if not (state.Halted[1] or state.Notices[1]) then return end
    local stopped, notices = table.clone(state.Halted), table.clone(state.Notices)
    table.clear(state.Halted)
    table.clear(state.Notices)

    for _, halt in ipairs(stopped) do
        for _, key in ipairs(halt[3]) do
            local toggle = Library.Options[key]
            if toggle and toggle.Value == true then xDTaraZ.Util.Try("halt " .. key, toggle.SetValue, toggle, false) end
        end
        Library:Notify("Mario Hub", halt[1] .. " stopped: " .. halt[2], 6, "Error")
    end
    for _, notice in ipairs(notices) do
        Library:Notify(notice[1], notice[2], 5, "Warning")
    end
end

---Hooks go in the first time a feature that needs them is switched on, never at load.
function xDTaraZ.UI.HookOnDemand()
    local installers = {
        SilentAim = xDTaraZ.Silent.InstallHook,
        Ragebot = xDTaraZ.Silent.InstallHook,
        Triggerbot = xDTaraZ.Silent.InstallHook,
        NoRecoil = xDTaraZ.Guns.HookKick,
        CameraFov = xDTaraZ.Guns.BindFov,
        NoSpread = xDTaraZ.Guns.HookSpread,
        AutoRebuy = xDTaraZ.Economy.HookBuys,
    }
    for idx, install in pairs(installers) do
        local toggle = Library.Options[idx]
        if not toggle then continue end
        toggle:OnChanged(function(on)
            if on then task.defer(xDTaraZ.Util.Try, "hook " .. idx, install) end
        end)
    end

    local trigger = Library.Options.Triggerbot
    if trigger then
        trigger:OnChanged(function(on)
            if on then task.delay(xDTaraZ.Config.HookSettle, xDTaraZ.UI.WarnReducedTrigger) end
        end)
    end
end

---Triggerbot fires without the shoot hook; only shot pacing is less exact, so say so once.
function xDTaraZ.UI.WarnReducedTrigger()
    local state = xDTaraZ.State
    if state.Hooks.Shoot or state.TriggerWarned then return end
    state.TriggerWarned = true
    table.insert(state.Notices, { T("Triggerbot", "ยิงอัตโนมัติ"), T("Running in reduced mode on this executor; shot pacing is less exact", "ทำงานแบบจำกัดบน executor นี้ จังหวะยิงอาจไม่แม่นเท่าที่ควร") })
end

function xDTaraZ.UI.BlockMissing()
    local absent = xDTaraZ.GameLib.Missing
    local missing = {
        Net = xDTaraZ.GameLib.Net == nil and (absent.Remotes or true),
        Character = xDTaraZ.GameLib.Character == nil and (absent.CharacterController or true),
        Skins = xDTaraZ.Skins.Folder() == nil and "Absent",
    }
    if missing.Skins then warn("[BloxStrike] Assets.Skins not found, the skin changer is blocked") end

    local unsupported = T("Not available on this executor", "ใช้กับ executor นี้ไม่ได้")
    local outdated = T("Changed by a game update, wait for a script update", "เกมอัปเดตแล้ว รอสคริปต์อัปเดต")
    for source, features in pairs(xDTaraZ.Config.ModuleFeatures) do
        local why = missing[source]
        if not why then continue end
        for _, idx in ipairs(features) do
            Library.Compat.Block(idx, why == "Absent" and outdated or unsupported)
        end
    end
end

function xDTaraZ.UI.Build()
    local window = Library.Window
    for _, build in ipairs({ xDTaraZ.UI.BuildMain, xDTaraZ.UI.BuildAimbot, xDTaraZ.UI.BuildSilent, xDTaraZ.UI.BuildTrigger, xDTaraZ.UI.BuildGuns, xDTaraZ.UI.BuildVisuals, xDTaraZ.UI.BuildSkins, xDTaraZ.UI.BuildMisc }) do
        xDTaraZ.Util.Try("build", build, window)
    end
    xDTaraZ.Util.Try("settings tab", function() window:AddSettingsTab() end)

    for key in pairs(xDTaraZ.Options) do
        local widget = Library.Options[key]
        if widget then xDTaraZ.Util.Try("bind " .. key, xDTaraZ.UI.Bind, widget, key) end
    end
    xDTaraZ.Util.Try("hooks", xDTaraZ.UI.HookOnDemand)
    xDTaraZ.Util.Try("missing modules", xDTaraZ.UI.BlockMissing)

    Library:Every(xDTaraZ.Config.StatusInterval, xDTaraZ.UI.RefreshStatus)
    Library:Every(xDTaraZ.Config.StatusInterval, xDTaraZ.UI.Drain)
end

function xDTaraZ.Boot()
    xDTaraZ.Util.Try("skins load", xDTaraZ.Skins.Load)
    xDTaraZ.Util.Try("combat", xDTaraZ.Combat.Start)
    xDTaraZ:Connect(LocalPlayer.Idled, xDTaraZ.World.OnIdled)
    xDTaraZ:Connect(UserInputService.JumpRequest, xDTaraZ.World.OnJump)
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.World.HopStep)
    xDTaraZ:Connect(UserInputService.InputBegan, function(input, processed) xDTaraZ.World.OnSpace(input, true, processed) end)
    xDTaraZ:Connect(UserInputService.InputEnded, function(input) xDTaraZ.World.OnSpace(input, false) end)
    xDTaraZ:Connect(Workspace.DescendantAdded, xDTaraZ.World.OnDescendant)

    xDTaraZ.Scheduler.Every("World", 0.2, xDTaraZ.World.Step, { "Fullbright", "NoFlash" }, xDTaraZ.World.Step)
    xDTaraZ.Scheduler.Every("Auto Rebuy", 0.5, xDTaraZ.Economy.Step, { "AutoRebuy" })
    xDTaraZ.Scheduler.Every("Skin Changer", 0.15, xDTaraZ.Skins.Step, { "SkinChanger" }, xDTaraZ.Skins.Step)
    xDTaraZ.Util.Try("scheduler", xDTaraZ.Scheduler.Boot)
end

function xDTaraZ:Unload()
    self.State.Alive = false
    xDTaraZ.Combat.Unload()
    for _, key in ipairs({ "NoRecoil", "NoSpread", "Fullbright", "CameraFov", "BunnyHop", "SkinChanger" }) do
        xDTaraZ.Options[key] = false
    end
    pcall(xDTaraZ.World.Step)
    pcall(xDTaraZ.World.SetCrouch, false)
    xDTaraZ.Guns.UnbindFov()
    pcall(xDTaraZ.Skins.Step)
    for _, conn in ipairs(self.State.Connections) do pcall(function() conn:Disconnect() end) end
    table.clear(self.State.Connections)
    if Library then xDTaraZ.Util.UnhookAll() end
    environment.BloxStrikeUnload = nil
end

---@return boolean  false when the menu could not be opened
local function BuildInterface()
    Library = xDTaraZ.Util.LoadLibrary(xDTaraZ.Config.UiSource)
    if not Library then return false end
    pcall(MarioBanner.Step, "UI library")
    xDTaraZ.Library = Library
    T = function(en, th) return Library:T(en, th) end
    local opened, err = pcall(Library.CreateWindow, Library, {
        Title = "Mario Hub",
        SubTitle = "BloxStrike by xDTaraZ",
        MenuKey = Enum.KeyCode.RightControl,
        ConfigFolder = xDTaraZ.Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        Intro = true,
        OnUnlocked = function()
            xDTaraZ.UI.Build()
            task.defer(xDTaraZ.Util.Try, "boot", xDTaraZ.Boot)
            task.defer(xDTaraZ.Util.Try, "autoload config", function() Library:LoadAutoloadConfig() end)
        end,
    })
    if not opened then
        xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(err):match("^[^\n]*"), err)
        return false
    end
    Library:OnUnload(function() xDTaraZ:Unload() end)
    return true
end

environment.BloxStrikeUnload = function()
    if xDTaraZ.Library and not xDTaraZ.Library.Unloaded then
        xDTaraZ.Library:Unload()
    else
        xDTaraZ:Unload()
    end
end

pcall(MarioBanner.Step, "Systems")
if not BuildInterface() then return end
pcall(MarioBanner.Step, "Interface")
pcall(MarioBanner.Ready)