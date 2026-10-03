if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if game.GameId ~= 10031505426 then
    LocalPlayer:Kick("Mario Hub: this script is for FPS AirDrop Arena only")
    return
end

local MarioBanner = {
    Print = type(getrenv) == "function" and getrenv().print or print,
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
        "   AIRDROP ARENA  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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

MarioBanner.Show()
MarioBanner.Step("Core")

local environment = getgenv and getgenv() or _G
if type(environment.AirDropArenaUnload) == "function" then
    pcall(environment.AirDropArenaUnload)
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local osClock = os.clock
local vector3New, cframeLookAt = Vector3.new, CFrame.lookAt

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui_v2.lua",
    Discord = "https://discord.gg/FHVfmeSceA",
    SaveFolder = "AirDrop Arena",
    Intro = true,
    StatusInterval = 1,
    DefaultRange = 1000,
    RefireGap = 0.15,
    AimRenderPriority = Enum.RenderPriority.Camera.Value + 1,
    GunScanInterval = 8,
    ModProps = { 70, 72, 73, 82 },
    AdsSpeed = 1000,
    RespawnGap = 0.5,
    LootRetry = 15,
    StatScanGap = 2,
    LobbyRejoin = 5,
    HealGap = 0.4,
    HealUrgent = 35,
    CurrencyType = 1,
    HuntIdle = 0.6,
    HuntDistance = 15,
    HuntLift = 10,
    TrackedCurrency = { "Gold", "Ore", "Crystal" },
    GearSlots = {
        [4] = { "Primary", 1 },
        [5] = { "Pistol", 4 },
        [8] = { "Helmet", 5 },
        [9] = { "Armor", 6 },
    },
    LootColors = {
        AirDrop = Color3.fromRGB(255, 80, 80),
        Crate = Color3.fromRGB(80, 170, 255),
        Item = Color3.fromRGB(255, 196, 64),
    },
    FallbackProto = {
        Blaster_ShootReq = 27001,
        DropItem_PickWorldItemReq = 26002,
        Battlefield_DeployReq = 25001,
        Blaster_BulletHitNotify = 27505,
        Battlefield_S2CCustomSyncNotify = 25507,
        Battlefield_EntityDeathNotify = 25508,
    },
    BoneParts = {
        Head = { "Head" },
        Torso = { "UpperTorso", "Torso", "HumanoidRootPart" },
    },
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Target = nil,
    AimPart = nil,
    AimEntity = nil,
    Firing = false,
    LastShot = 0,
    Kills = 0,
    LastRespawn = 0,
    Hits = 0,
    Tried = {},
    AirDrops = 0,
    AirDropAt = 0,
    Looted = 0,
    Valuables = 0,
    LastLoot = "-",
}

xDTaraZ.Options = {
    Hunt = false,
    SilentAim = false,
    Ragebot = false,
    TargetBots = true,
    AimBone = "Head",
    AimPriority = "Crosshair",
    AimFov = 200,
    ShowFov = false,
    AimMaxDistance = 1000,
    Aimbot = false,
    AimSmooth = 1,
    InstantRespawn = false,
    AutoRejoin = false,
    AutoHeal = false,
    HealAt = 70,
    RapidFire = false,
    FireRateMult = 2,
    NoSpread = false,
    NoRecoil = false,
    InstantAds = false,
    AutoGear = false,
    LootGear = { Primary = true, Pistol = true, Helmet = true, Armor = true },
    AutoValuables = false,
    AutoAirDrop = false,
    LootEspAirDrop = false,
    LootEspCrate = false,
    LootEspItem = false,
    LootEspRange = 400,
    SuperSlide = false,
    SlideSpeed = 120,
    Speed = false,
    SpeedValue = 40,
    InfiniteJump = false,
    Noclip = false,
    Fly = false,
    FlySpeed = 60,
    Fullbright = false,
    CameraFov = false,
    CameraFovValue = 90,
    AntiAfk = false,
}

xDTaraZ.Util = {}
local Util = xDTaraZ.Util

---@return function?  first argument that is callable
local function Resolve(...)
    for index = 1, select("#", ...) do
        local candidate = select(index, ...)
        if type(candidate) == "function" then return candidate end
    end
    return nil
end

Util.Request = Resolve(request, http_request, syn and syn.request, http and http.request)
Util.SetClipboard = Resolve(setclipboard, toclipboard)
Util.HookMeta = Resolve(hookmetamethod)
Util.GetNamecall = Resolve(getnamecallmethod)
Util.NewCClosure = Resolve(newcclosure) or function(fn) return fn end
Util.GetGc = Resolve(getgc)
Util.GetHui = Resolve(gethui, get_hidden_gui)
xDTaraZ.Caps = {
    Hook = Util.HookMeta ~= nil and Util.GetNamecall ~= nil,
    Gc = Util.GetGc ~= nil,
    Drawing = type(Drawing) == "table" and type(Drawing.new) == "function",
}

---@return string  response body, throws if every transport fails
function Util.HttpGet(url)
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if ok and type(body) == "string" then return body end
    if Util.Request then
        local response = Util.Request({ Url = url, Method = "GET" })
        if type(response) == "table" and type(response.Body) == "string" then return response.Body end
    end
    error("HttpGet failed: " .. url)
end

function Util.Hui()
    if Util.GetHui then
        local ok, gui = pcall(Util.GetHui)
        if ok and gui then return gui end
    end
    return LocalPlayer:FindFirstChildOfClass("PlayerGui")
end

function Util.Copy(text)
    if not Util.SetClipboard then return false end
    Util.SetClipboard(text)
    return true
end

function xDTaraZ:Connect(signal, handler)
    local conn = signal:Connect(handler)
    table.insert(self.State.Connections, conn)
    return conn
end

xDTaraZ.GameLib = {}
local GameLib = xDTaraZ.GameLib

local function RequireModule(module)
    if not module then return nil end
    local ok, loaded = pcall(require, module)
    if not ok then
        warn("[AirDropArena] require " .. module.Name .. ":", loaded)
        return nil
    end
    return loaded
end

do
    local remotes = ReplicatedStorage:WaitForChild("RemoteEvent", 10)
    local scripts = ReplicatedStorage:WaitForChild("Scripts", 10)
    GameLib.Main = remotes and remotes:WaitForChild("Main", 10)
    GameLib.ProtoId = RequireModule(scripts and scripts:FindFirstChild("ProtoId", true)) or {}
    GameLib.Configs = RequireModule(scripts and scripts:FindFirstChild("ConfigManager", true)) or {}
end

xDTaraZ.Proto = setmetatable({}, {
    __index = function(self, name)
        local id = GameLib.ProtoId[name] or xDTaraZ.Config.FallbackProto[name]
        rawset(self, name, id)
        return id
    end,
})

xDTaraZ.ItemNames = setmetatable({}, {
    __index = function(self, itemId)
        local items = GameLib.Configs.ItemConfig
        local ok, cfg = pcall(function() return items:GetItemConfigById(itemId) end)
        local name = ok and type(cfg) == "table" and (cfg.name or cfg.Name) or tostring(itemId)
        rawset(self, itemId, tostring(name))
        return self[itemId]
    end,
})

xDTaraZ.Net = {}

---@param payload table  proto argument table
function xDTaraZ.Net.Send(name, payload)
    local id = xDTaraZ.Proto[name]
    if not (id and GameLib.Main) then return false end
    GameLib.Main:FireServer({ id, payload })
    return true
end

xDTaraZ.Player = {}

function xDTaraZ.Player.Root()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

function xDTaraZ.Player.Humanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

function xDTaraZ.Player.EntityId()
    local char = LocalPlayer.Character
    return char and char:GetAttribute("EntityId") or LocalPlayer.UserId
end

function xDTaraZ.Player.InBattle()
    local char = LocalPlayer.Character
    return char ~= nil and char:GetAttribute("EntityState") == 1
end

---@return boolean  true while dead or spectating a match
function xDTaraZ.Player.IsSoul()
    local char = LocalPlayer.Character
    local state = char and char:GetAttribute("EntityState")
    return state == 2 or state == 4
end

xDTaraZ.Target = {}

local losParams = RaycastParams.new()
losParams.FilterType = Enum.RaycastFilterType.Exclude
local losFilter = table.create(3)

---@return Model[]  every character and bot that could be shot
function xDTaraZ.Target.Candidates()
    local list = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then table.insert(list, player.Character) end
    end
    local fx = xDTaraZ.Options.TargetBots and Workspace:FindFirstChild("Fx")
    if fx then
        for _, model in ipairs(fx:GetChildren()) do
            if model:IsA("Model") and model:GetAttribute("EntityId") then list[#list + 1] = model end
        end
    end
    return list
end

function xDTaraZ.Target.IsEnemy(model)
    if model == LocalPlayer.Character or not model:GetAttribute("EntityId") then return false end
    local hum = model:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    local state = model:GetAttribute("EntityState")
    if state ~= nil and state ~= 1 then return false end

    local mine = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("TeamId")
    local theirs = model:GetAttribute("TeamId")
    if mine and mine ~= -1 and mine == theirs then return false end
    return true
end

function xDTaraZ.Target.Part(model, bone)
    for _, name in ipairs(xDTaraZ.Config.BoneParts[bone] or xDTaraZ.Config.BoneParts.Head) do
        local part = model:FindFirstChild(name)
        if part and part:IsA("BasePart") then return part end
    end
    return model:FindFirstChild("HumanoidRootPart")
end

function xDTaraZ.Target.Visible(from, model, point)
    losFilter[1], losFilter[2], losFilter[3] = LocalPlayer.Character, model, Workspace.CurrentCamera
    losParams.FilterDescendantsInstances = losFilter
    return Workspace:Raycast(from, point - from, losParams) == nil
end

---@param useFov boolean  restrict to the FOV circle
---@return Model?, BasePart?
function xDTaraZ.Target.Pick(useFov)
    local cam = Workspace.CurrentCamera
    local origin = cam.CFrame.Position
    local center = cam.ViewportSize / 2
    local opts = xDTaraZ.Options
    local best, bestPart, bestScore

    for _, model in ipairs(xDTaraZ.Target.Candidates()) do
        if not xDTaraZ.Target.IsEnemy(model) then continue end
        local part = xDTaraZ.Target.Part(model, opts.AimBone)
        if not part then continue end
        local dist = (part.Position - origin).Magnitude
        if dist > opts.AimMaxDistance then continue end

        local screen, onScreen = cam:WorldToViewportPoint(part.Position)
        local screenDist = (Vector2.new(screen.X, screen.Y) - center).Magnitude
        if useFov and (not onScreen or screenDist > opts.AimFov) then continue end
        if not xDTaraZ.Target.Visible(origin, model, part.Position) then continue end

        local score = dist
        if opts.AimPriority == "Crosshair" then score = onScreen and screenDist or 1e6 + dist end
        if not bestScore or score < bestScore then
            best, bestPart, bestScore = model, part, score
        end
    end
    return best, bestPart
end

function xDTaraZ.Target.Label(model)
    local player = Players:GetPlayerFromCharacter(model)
    return player and player.DisplayName or ("[Bot] " .. model.Name)
end

xDTaraZ.Combat = { Hooked = false, PressedAt = 0 }

---@param shot table  27001 payload, edited in place; must not namecall
function xDTaraZ.Combat.Rewrite(shot)
    local part, entityId = xDTaraZ.State.AimPart, xDTaraZ.State.AimEntity
    if not (part and entityId and part.Parent) then return end
    local dirs = shot.rayDirections
    if type(dirs) ~= "table" or #dirs == 0 then return end

    local origin = typeof(shot.origin) == "CFrame" and shot.origin.Position or Workspace.CurrentCamera.CFrame.Position
    local offset = part.Position - origin
    local dist = offset.Magnitude
    local range = typeof(dirs[1]) == "Vector3" and dirs[1].Magnitude or xDTaraZ.Config.DefaultRange
    if dist > range or dist < 1e-3 then return end

    local unit = offset.Unit
    local results = table.create(#dirs)
    for index, dir in ipairs(dirs) do
        dirs[index] = unit * (typeof(dir) == "Vector3" and dir.Magnitude or range)
        results[index] = { instance = part, normal = -unit, distance = dist, taggedEntityId = entityId, isTeammate = false }
    end
    shot.rayResults = results
end

function xDTaraZ.Combat.Aiming()
    local opts = xDTaraZ.Options
    return opts.SilentAim or opts.Ragebot
end

function xDTaraZ.Combat.InstallHook()
    if xDTaraZ.Combat.Hooked or not (xDTaraZ.Caps.Hook and GameLib.Main) then return end
    xDTaraZ.Combat.Hooked = true
    local main, getMethod = GameLib.Main, Util.GetNamecall
    local old
    old = Util.HookMeta(game, "__namecall", Util.NewCClosure(function(self, ...)
        if self == main and xDTaraZ.State.Alive and xDTaraZ.Combat.Aiming() and getMethod() == "FireServer" then
            local packet = ...
            if type(packet) == "table" and packet[1] == xDTaraZ.Proto.Blaster_ShootReq and type(packet[2]) == "table" then
                xDTaraZ.State.LastShot = osClock()
                local ok, err = pcall(xDTaraZ.Combat.Rewrite, packet[2])
                if not ok then warn("[AirDropArena] rewrite:", err) end
            end
        end
        return old(self, ...)
    end))
end

---@return table?  the game's input behaviour for your character (BeginFire/EndFire)
function xDTaraZ.Combat.Behavior()
    local combat = xDTaraZ.Combat
    if combat.Input and rawget(combat.Input, "owner") then return combat.Input end
    combat.Input = nil
    if not xDTaraZ.Caps.Gc or osClock() - (combat.LastScan or 0) < xDTaraZ.Config.StatScanGap then return nil end
    combat.LastScan = osClock()
    for _, entry in ipairs(Util.GetGc(true)) do
        if type(entry) == "table" and rawget(entry, "owner") and type(entry.BeginFire) == "function" and type(entry.FastKnife) == "function" then
            combat.Input = entry
            return entry
        end
    end
    return nil
end

function xDTaraZ.Combat.Press(down)
    xDTaraZ.State.Firing = down
    if down then xDTaraZ.Combat.PressedAt = osClock() end
    local input = xDTaraZ.Combat.Behavior()
    if input then
        local ok = pcall(down and input.BeginFire or input.EndFire, input)
        if ok then return end
    end
    local center = Workspace.CurrentCamera.ViewportSize / 2
    pcall(VirtualInputManager.SendMouseButtonEvent, VirtualInputManager, center.X, center.Y, 0, down, game, 0)
end

---@param want boolean  keeps auto guns held and re-clicks semi-auto ones
function xDTaraZ.Combat.Fire(want)
    local state, now = xDTaraZ.State, osClock()
    if not want then
        if state.Firing then xDTaraZ.Combat.Press(false) end
        return
    end
    if not state.Firing then
        xDTaraZ.Combat.Press(true)
        return
    end
    local gap = xDTaraZ.Config.RefireGap
    if now - xDTaraZ.Combat.PressedAt > gap and now - state.LastShot > gap then xDTaraZ.Combat.Press(false) end
end

function xDTaraZ.Combat.UpdateCircle()
    if not xDTaraZ.Caps.Drawing then return end
    local circle = xDTaraZ.Combat.Circle
    if not xDTaraZ.Options.ShowFov then
        if circle then circle.Visible = false end
        return
    end
    if not circle then
        circle = Drawing.new("Circle")
        circle.Thickness, circle.NumSides, circle.Filled = 1.5, 64, false
        circle.Color = Color3.fromRGB(232, 160, 76)
        xDTaraZ.Combat.Circle = circle
    end
    circle.Position = Workspace.CurrentCamera.ViewportSize / 2
    circle.Radius = xDTaraZ.Options.AimFov
    circle.Visible = true
end

function xDTaraZ.Combat.Step()
    local opts = xDTaraZ.Options
    local state = xDTaraZ.State
    xDTaraZ.Combat.UpdateCircle()

    if not ((xDTaraZ.Combat.Aiming() or opts.Aimbot) and xDTaraZ.Player.InBattle()) then
        state.Target, state.AimPart, state.AimEntity = nil, nil, nil
        xDTaraZ.Combat.Fire(false)
        return
    end

    local target, part = xDTaraZ.Target.Pick(not opts.Ragebot)
    state.Target, state.AimPart = target, part
    state.AimEntity = target and target:GetAttribute("EntityId")
    xDTaraZ.Combat.Fire(target ~= nil and opts.Ragebot)
end

function xDTaraZ.Combat.OnServer(packet)
    if type(packet) ~= "table" or type(packet[2]) ~= "table" then return end
    local id, body = packet[1], packet[2]
    if id == xDTaraZ.Proto.Blaster_BulletHitNotify then
        if body.killerEntityId == xDTaraZ.Player.EntityId() then xDTaraZ.State.Hits += 1 end
    elseif id == xDTaraZ.Proto.Battlefield_EntityDeathNotify then
        if body.killerEntityId == xDTaraZ.Player.EntityId() then xDTaraZ.State.Kills += 1 end
    elseif id == xDTaraZ.Proto.Battlefield_S2CCustomSyncNotify then
        xDTaraZ.Loot.OnSync(body)
    end
end

function xDTaraZ.Combat.LockCamera()
    local part = xDTaraZ.State.AimPart
    if not (xDTaraZ.Options.Aimbot and part and part.Parent) then return end
    local cam = Workspace.CurrentCamera
    local origin = cam.CFrame.Position
    local want = (part.Position - origin).Unit
    local smooth = math.max(xDTaraZ.Options.AimSmooth, 1)
    local look = smooth <= 1 and want or cam.CFrame.LookVector:Lerp(want, 1 / smooth).Unit
    cam.CFrame = cframeLookAt(origin, origin + look)
end

function xDTaraZ.Combat.Start()
    xDTaraZ.Combat.InstallHook()
    RunService:BindToRenderStep("xDTaraZAim", xDTaraZ.Config.AimRenderPriority, xDTaraZ.Combat.LockCamera)
    xDTaraZ:Connect(RunService.Heartbeat, function()
        local ok, err = pcall(xDTaraZ.Combat.Step)
        if not ok then warn("[AirDropArena] combat:", err) end
    end)
    if GameLib.Main then xDTaraZ:Connect(GameLib.Main.OnClientEvent, xDTaraZ.Combat.OnServer) end
end

function xDTaraZ.Combat.Unload()
    xDTaraZ.Combat.Fire(false)
    pcall(RunService.UnbindFromRenderStep, RunService, "xDTaraZAim")
    if xDTaraZ.Combat.Circle then
        pcall(function() xDTaraZ.Combat.Circle:Remove() end)
        xDTaraZ.Combat.Circle = nil
    end
end

function xDTaraZ.Combat.GetStatus()
    local state = xDTaraZ.State
    local target = state.Target and xDTaraZ.Target.Label(state.Target) or "none"
    return string.format("Target: %s | Hits %d | Kills %d | Guns %d",
        target, state.Hits, state.Kills, xDTaraZ.Guns.Count)
end

xDTaraZ.Guns = {
    Known = setmetatable({}, { __mode = "k" }),
    Saved = setmetatable({}, { __mode = "k" }),
    Count = 0,
    LastScan = 0,
    Signature = "",
}

function xDTaraZ.Guns.Wanted()
    local opts = xDTaraZ.Options
    return opts.RapidFire or opts.NoSpread or opts.NoRecoil or opts.InstantAds
end

function xDTaraZ.Guns.Scan()
    if not xDTaraZ.Caps.Gc then return end
    local known, count = xDTaraZ.Guns.Known, 0
    for _, entry in ipairs(Util.GetGc(true)) do
        if type(entry) == "table" and rawget(entry, "islocalplayer") == true and type(rawget(entry, "propMap")) == "table" then
            known[entry] = true
            count += 1
        end
    end
    xDTaraZ.Guns.Count = count
    xDTaraZ.Guns.LastScan = osClock()
end

---@return string  changes whenever the held loadout changes
function xDTaraZ.Guns.LoadoutSignature()
    local char = LocalPlayer.Character
    local folder = char and char:FindFirstChild("Blaster")
    if not folder then return "" end
    local names = {}
    for _, child in ipairs(folder:GetChildren()) do names[#names + 1] = child.Name end
    return table.concat(names, "|")
end

---@return number?  nil keeps the original value
function xDTaraZ.Guns.Desired(id, base)
    local opts = xDTaraZ.Options
    if id == 70 and opts.RapidFire then return base * opts.FireRateMult end
    if (id == 72 or id == 73) and opts.NoSpread then return 0 end
    if id == 82 and opts.InstantAds then return xDTaraZ.Config.AdsSpeed end
    return nil
end

local function NoRecoilRate() return 0 end
local function NoRecoil() end

function xDTaraZ.Guns.ApplyRecoil(blaster, saved)
    if xDTaraZ.Options.NoRecoil then
        if saved.Recoil then return end
        saved.Recoil = { rawget(blaster, "GetRecoilRate") or false, rawget(blaster, "Recoil") or false }
        rawset(blaster, "GetRecoilRate", NoRecoilRate)
        rawset(blaster, "Recoil", NoRecoil)
    elseif saved.Recoil then
        rawset(blaster, "GetRecoilRate", saved.Recoil[1] or nil)
        rawset(blaster, "Recoil", saved.Recoil[2] or nil)
        saved.Recoil = nil
    end
end

function xDTaraZ.Guns.Apply()
    local savedAll = xDTaraZ.Guns.Saved
    for blaster in pairs(xDTaraZ.Guns.Known) do
        local map = rawget(blaster, "propMap")
        if type(map) ~= "table" then continue end
        local saved = savedAll[blaster] or {}
        savedAll[blaster] = saved

        for _, id in ipairs(xDTaraZ.Config.ModProps) do
            local base = saved[id] or map[id]
            if type(base) ~= "number" then continue end
            local want = xDTaraZ.Guns.Desired(id, base)
            if want then
                saved[id], map[id] = base, want
            elseif saved[id] then
                map[id], saved[id] = saved[id], nil
            end
        end
        xDTaraZ.Guns.ApplyRecoil(blaster, saved)
    end
end

function xDTaraZ.Guns.Step()
    if not xDTaraZ.Guns.Wanted() and next(xDTaraZ.Guns.Saved) == nil then return end
    local signature = xDTaraZ.Guns.LoadoutSignature()
    if xDTaraZ.Guns.Wanted() and (signature ~= xDTaraZ.Guns.Signature or osClock() - xDTaraZ.Guns.LastScan > xDTaraZ.Config.GunScanInterval) then
        xDTaraZ.Guns.Signature = signature
        xDTaraZ.Guns.Scan()
    end
    xDTaraZ.Guns.Apply()
end

function xDTaraZ.Guns.Restore()
    for _, key in ipairs({ "RapidFire", "NoSpread", "NoRecoil", "InstantAds" }) do
        xDTaraZ.Options[key] = false
    end
    xDTaraZ.Guns.Apply()
    table.clear(xDTaraZ.Guns.Saved)
end

xDTaraZ.Loot = { Marks = {} }

function xDTaraZ.Loot.Folder()
    return Workspace:FindFirstChild("DropItemFloder")
end

---@return string?  "AirDrop", "Crate" or "Item"
function xDTaraZ.Loot.Kind(model)
    if model.Name == "AirDrop" or model:GetAttribute("AirDropClientModel") then return "AirDrop" end
    local bagType = model:GetAttribute("BagType")
    if bagType == 20000 then return "Crate" end
    if bagType == 10000 or model:GetAttribute("ItemId") then return "Item" end
    return nil
end

function xDTaraZ.Loot.Label(model, kind)
    if kind == "Item" then return xDTaraZ.ItemNames[model:GetAttribute("ItemId")] end
    return kind == "AirDrop" and "Air Drop" or "Crate"
end

---@return table?  the game's drop manager, holds every bag the client knows about
function xDTaraZ.Loot.Manager()
    local cached = xDTaraZ.Loot.DropManager
    if cached or not xDTaraZ.Caps.Gc then return cached end
    for _, entry in ipairs(Util.GetGc(true)) do
        if type(entry) == "table" and rawget(entry, "dropItems") and type(rawget(entry, "BagController")) == "table" then
            xDTaraZ.Loot.DropManager = entry
            return entry
        end
    end
    return nil
end

function xDTaraZ.Loot.ItemConfig(configId)
    local items = GameLib.Configs.ItemConfig
    local ok, cfg = pcall(items.GetItemConfigById, items, configId)
    return ok and type(cfg) == "table" and cfg or nil
end

function xDTaraZ.Loot.Score(cfg)
    return (cfg.quality or 0) * 1e7 + (cfg.value or 0)
end

---@return number  score of what is worn in that slot, 0 when empty
function xDTaraZ.Loot.WornScore(slot)
    local char = LocalPlayer.Character
    local worn = char and char:GetAttribute("EPos_" .. slot)
    local id = type(worn) == "string" and tonumber(worn:match("^I_(%d+)"))
    local cfg = id and id > 0 and xDTaraZ.Loot.ItemConfig(id)
    return cfg and xDTaraZ.Loot.Score(cfg) or 0
end

---@return table[]  { bagUid, itemUid, name } for every slot that has a better item lying around
function xDTaraZ.Loot.Upgrades()
    local manager = xDTaraZ.Loot.Manager()
    local bags = manager and manager.BagController.bagMap
    if type(bags) ~= "table" then return {} end
    local wanted, slots = xDTaraZ.Options.LootGear, xDTaraZ.Config.GearSlots
    local best = {}
    for bagUid, bag in pairs(bags) do
        for itemUid, item in pairs(type(bag.itemMap) == "table" and bag.itemMap or {}) do
            local cfg = xDTaraZ.Loot.ItemConfig(item.configId)
            local gear = cfg and slots[cfg.type]
            if not (gear and wanted[gear[1]]) then continue end
            local tried = xDTaraZ.State.Tried[itemUid]
            if tried and osClock() - tried < xDTaraZ.Config.LootRetry then continue end
            local score = xDTaraZ.Loot.Score(cfg)
            local top = best[cfg.type]
            if not top or score > top[4] then best[cfg.type] = { bagUid, itemUid, cfg.name, score } end
        end
    end

    local list = {}
    for itemType, pick in pairs(best) do
        if pick[4] > xDTaraZ.Loot.WornScore(slots[itemType][2]) then list[#list + 1] = pick end
    end
    return list
end

---@return number  items requested
function xDTaraZ.Loot.TakeUpgrades()
    if not xDTaraZ.Player.InBattle() then return 0 end
    local got = 0
    for _, pick in ipairs(xDTaraZ.Loot.Upgrades()) do
        if xDTaraZ.Loot.Pick(pick[1], pick[2], pick[3]) then got += 1 end
    end
    xDTaraZ.State.Looted += got
    return got
end

---@return number  currency items requested from every bag on the map
function xDTaraZ.Loot.TakeValuables()
    local manager = xDTaraZ.Loot.Manager()
    local bags = manager and manager.BagController.bagMap
    if not (type(bags) == "table" and xDTaraZ.Player.InBattle()) then return 0 end
    local got = 0
    for bagUid, bag in pairs(bags) do
        for itemUid, item in pairs(type(bag.itemMap) == "table" and bag.itemMap or {}) do
            local cfg = xDTaraZ.Loot.ItemConfig(item.configId)
            if not (cfg and cfg.type == xDTaraZ.Config.CurrencyType) then continue end
            if xDTaraZ.Loot.Pick(bagUid, itemUid, cfg.name) then got += 1 end
        end
    end
    xDTaraZ.State.Valuables += got
    return got
end

function xDTaraZ.Loot.ValuablesStep()
    if xDTaraZ.Options.AutoValuables then xDTaraZ.Loot.TakeValuables() end
end

function xDTaraZ.Loot.GearStep()
    if not xDTaraZ.Options.AutoGear then return end
    xDTaraZ.Loot.TakeUpgrades()
end

---@return boolean  false when skipped or not sent
function xDTaraZ.Loot.Pick(bagUid, itemUid, name)
    local tried = xDTaraZ.State.Tried
    if tried[itemUid] and osClock() - tried[itemUid] < xDTaraZ.Config.LootRetry then return false end
    tried[itemUid] = osClock()
    if not xDTaraZ.Net.Send("DropItem_PickWorldItemReq", { bagUid = bagUid, itemUid = itemUid }) then return false end
    xDTaraZ.State.LastLoot = name or xDTaraZ.State.LastLoot
    return true
end

---@return number  items requested from every air drop on the map; gear only when it beats what you wear
function xDTaraZ.Loot.EmptyAirDrops()
    local manager, folder = xDTaraZ.Loot.Manager(), xDTaraZ.Loot.Folder()
    local bags = manager and manager.BagController.bagMap
    if not (type(bags) == "table" and folder and xDTaraZ.Player.InBattle()) then return 0 end
    local got, taken = 0, {}
    for _, model in ipairs(folder:GetChildren()) do
        local bagUid = model:GetAttribute("BagUid")
        local bag = xDTaraZ.Loot.Kind(model) == "AirDrop" and bagUid and bags[bagUid]
        if not bag then continue end
        for itemUid, item in pairs(bag.itemMap) do
            local cfg = xDTaraZ.Loot.ItemConfig(item.configId)
            local gear = cfg and xDTaraZ.Config.GearSlots[cfg.type]
            if gear and (taken[cfg.type] or xDTaraZ.Loot.Score(cfg) <= xDTaraZ.Loot.WornScore(gear[2])) then continue end
            if xDTaraZ.Loot.Pick(bagUid, itemUid, cfg and cfg.name) then
                got += 1
                if gear then taken[cfg.type] = true end
            end
        end
    end
    xDTaraZ.State.AirDrops += got
    return got
end

function xDTaraZ.Loot.AirDropStep()
    if xDTaraZ.Options.AutoAirDrop then xDTaraZ.Loot.EmptyAirDrops() end
end

function xDTaraZ.Loot.OnSync(body)
    local timer = body.airdptime
    if type(timer) == "table" and type(timer.endstamp) == "number" then xDTaraZ.State.AirDropAt = timer.endstamp end
end

function xDTaraZ.Loot.Mark(model, kind)
    local gui = Instance.new("BillboardGui")
    gui.Name, gui.AlwaysOnTop, gui.Size, gui.StudsOffset = "xDTaraZLoot", true, UDim2.fromOffset(180, 20), vector3New(0, 2, 0)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency, label.Size, label.Font, label.TextSize = 1, UDim2.fromScale(1, 1), Enum.Font.GothamBold, 12
    label.TextColor3, label.TextStrokeTransparency = xDTaraZ.Config.LootColors[kind], 0.3
    label.Parent = gui
    gui.Adornee = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
    gui.Parent = Util.Hui()
    return { Gui = gui, Label = label }
end

function xDTaraZ.Loot.EspStep()
    local opts = xDTaraZ.Options
    local marks = xDTaraZ.Loot.Marks
    local folder = xDTaraZ.Loot.Folder()
    local hrp = xDTaraZ.Player.Root()
    local show = { AirDrop = opts.LootEspAirDrop, Crate = opts.LootEspCrate, Item = opts.LootEspItem }
    local seen = {}

    if folder and hrp then
        for _, model in ipairs(folder:GetChildren()) do
            local kind = xDTaraZ.Loot.Kind(model)
            if not (kind and show[kind]) then continue end
            local dist = (model:GetPivot().Position - hrp.Position).Magnitude
            if dist > opts.LootEspRange and kind ~= "AirDrop" then continue end
            seen[model] = true
            marks[model] = marks[model] or xDTaraZ.Loot.Mark(model, kind)
            local opened = kind == "AirDrop" and model:GetAttribute("AirDropOpened") and " (opened)" or ""
            marks[model].Label.Text = string.format("%s%s [%dm]", xDTaraZ.Loot.Label(model, kind), opened, math.floor(dist))
        end
    end
    for model, mark in pairs(marks) do
        if not seen[model] then
            mark.Gui:Destroy()
            marks[model] = nil
        end
    end
end

xDTaraZ.Slide = { Skill = nil, LastScan = 0, Dir = nil }

---@return table?  the game's slide skill object for you
function xDTaraZ.Slide.Find()
    local slide = xDTaraZ.Slide
    if slide.Skill then return slide.Skill end
    if not xDTaraZ.Caps.Gc or osClock() - slide.LastScan < xDTaraZ.Config.StatScanGap then return nil end
    slide.LastScan = osClock()
    for _, entry in ipairs(Util.GetGc(true)) do
        if type(entry) == "table" and rawget(entry, "slideRequestId") ~= nil and rawget(entry, "owner") and getmetatable(entry) then
            slide.Skill = entry
            return entry
        end
    end
    return nil
end

function xDTaraZ.Slide.OnHeartbeat()
    local slide = xDTaraZ.Slide
    local skill = xDTaraZ.Options.SuperSlide and xDTaraZ.Slide.Find()
    local hrp, hum = xDTaraZ.Player.Root(), xDTaraZ.Player.Humanoid()
    if not (skill and hrp and hum and rawget(skill, "slideActive")) then
        slide.Dir = nil
        return
    end
    if not slide.Dir then
        local move = hum.MoveDirection * vector3New(1, 0, 1)
        local look = Workspace.CurrentCamera.CFrame.LookVector * vector3New(1, 0, 1)
        slide.Dir = move.Magnitude > 0.1 and move.Unit or look.Unit
    end
    local vel, speed = hrp.AssemblyLinearVelocity, xDTaraZ.Options.SlideSpeed
    hrp.AssemblyLinearVelocity = vector3New(slide.Dir.X * speed, vel.Y, slide.Dir.Z * speed)
end

xDTaraZ.Movement = { Collided = {} }

function xDTaraZ.Movement.OnHeartbeat(dt)
    local opts = xDTaraZ.Options
    if not (opts.Speed or opts.Fly) then return end
    local hrp, hum = xDTaraZ.Player.Root(), xDTaraZ.Player.Humanoid()
    if not (hrp and hum) or hum.Health <= 0 then return end

    if opts.Fly then
        local vertical = 0
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vertical += 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vertical -= 1 end
        local dir = hum.MoveDirection + vector3New(0, vertical, 0)
        hrp.AssemblyLinearVelocity = dir.Magnitude > 0 and dir.Unit * opts.FlySpeed or Vector3.zero
        return
    end

    local extra = opts.SpeedValue - hum.WalkSpeed
    if extra > 0 and hum.MoveDirection.Magnitude > 0 then
        hrp.CFrame += hum.MoveDirection * extra * dt
    end
end

function xDTaraZ.Movement.OnStepped()
    local saved = xDTaraZ.Movement.Collided
    local char = LocalPlayer.Character
    if not xDTaraZ.Options.Noclip then
        if next(saved) == nil then return end
        for part in pairs(saved) do
            if part.Parent then part.CanCollide = true end
        end
        table.clear(saved)
        return
    end
    if not char then return end
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.CanCollide then
            saved[part] = true
            part.CanCollide = false
        end
    end
end

function xDTaraZ.Movement.OnJumpRequest()
    if not xDTaraZ.Options.InfiniteJump then return end
    local hum = xDTaraZ.Player.Humanoid()
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end

function xDTaraZ.Movement.Start()
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Movement.OnHeartbeat)
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Slide.OnHeartbeat)
    xDTaraZ:Connect(RunService.Stepped, xDTaraZ.Movement.OnStepped)
    xDTaraZ:Connect(UserInputService.JumpRequest, xDTaraZ.Movement.OnJumpRequest)
end

function xDTaraZ.Movement.StopFly()
    local hrp = xDTaraZ.Player.Root()
    if hrp then hrp.AssemblyLinearVelocity = Vector3.zero end
end

xDTaraZ.World = { Saved = nil, FovSaved = nil }

function xDTaraZ.World.Step()
    local saved = xDTaraZ.World.Saved
    if xDTaraZ.Options.Fullbright then
        if not saved then
            xDTaraZ.World.Saved = { Lighting.Brightness, Lighting.ClockTime, Lighting.FogEnd, Lighting.GlobalShadows, Lighting.Ambient }
        end
        Lighting.Brightness, Lighting.ClockTime, Lighting.FogEnd = 2, 14, 1e6
        Lighting.GlobalShadows, Lighting.Ambient = false, Color3.fromRGB(178, 178, 178)
    elseif saved then
        Lighting.Brightness, Lighting.ClockTime, Lighting.FogEnd, Lighting.GlobalShadows, Lighting.Ambient = table.unpack(saved)
        xDTaraZ.World.Saved = nil
    end
end

function xDTaraZ.World.OnRender()
    local cam = Workspace.CurrentCamera
    if xDTaraZ.Options.CameraFov then
        xDTaraZ.World.FovSaved = xDTaraZ.World.FovSaved or cam.FieldOfView
        cam.FieldOfView = xDTaraZ.Options.CameraFovValue
    elseif xDTaraZ.World.FovSaved then
        cam.FieldOfView = xDTaraZ.World.FovSaved
        xDTaraZ.World.FovSaved = nil
    end
end

function xDTaraZ.World.OnIdled()
    if not xDTaraZ.Options.AntiAfk then return end
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.zero)
end

function xDTaraZ.World.Rejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end

function xDTaraZ.World.Hop()
    local body = Util.HttpGet(("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100"):format(game.PlaceId))
    local ok, list = pcall(HttpService.JSONDecode, HttpService, body)
    for _, server in ipairs(ok and list.data or {}) do
        if server.id ~= game.JobId and server.playing < server.maxPlayers then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
            return true
        end
    end
    return false
end

xDTaraZ.Respawn = {}

function xDTaraZ.Respawn.Now()
    local state = xDTaraZ.State
    if osClock() - state.LastRespawn < xDTaraZ.Config.RespawnGap then return false end
    state.LastRespawn = osClock()
    return xDTaraZ.Net.Send("Battlefield_DeployReq")
end

function xDTaraZ.Respawn.Step()
    if not xDTaraZ.Options.InstantRespawn or not xDTaraZ.Player.IsSoul() then return end
    xDTaraZ.Respawn.Now()
end

function xDTaraZ.Respawn.Rejoin()
    local char = LocalPlayer.Character
    if not xDTaraZ.Options.AutoRejoin or not (char and char:GetAttribute("EntityState") == 0) then
        xDTaraZ.Farm.LobbySince = nil
        return
    end
    xDTaraZ.Farm.LobbySince = xDTaraZ.Farm.LobbySince or osClock()
    if osClock() - xDTaraZ.Farm.LobbySince > xDTaraZ.Config.LobbyRejoin then xDTaraZ.Respawn.Now() end
end

function xDTaraZ.Respawn.Watch(char)
    xDTaraZ:Connect(char:GetAttributeChangedSignal("EntityState"), function()
        xDTaraZ.Heal.Stats, xDTaraZ.Slide.Skill, xDTaraZ.Combat.Input = nil, nil, nil
        xDTaraZ.Respawn.Step()
    end)
end

xDTaraZ.Heal = { Stats = nil, LastScan = 0, LastHeal = 0, Healed = 0 }

---@return table?  the game's live stat table for you (curHp, maxHp)
function xDTaraZ.Heal.Player()
    local heal = xDTaraZ.Heal
    if heal.Stats and type(rawget(heal.Stats, "curHp")) == "number" then return heal.Stats end
    if not xDTaraZ.Caps.Gc or osClock() - heal.LastScan < xDTaraZ.Config.StatScanGap then return nil end
    heal.LastScan = osClock()
    for _, entry in ipairs(Util.GetGc(true)) do
        if type(entry) == "table" and type(rawget(entry, "curHp")) == "number" and rawget(entry, "maxSp") ~= nil then
            heal.Stats = entry
            return entry
        end
    end
    return nil
end

---@return number?, number?
function xDTaraZ.Heal.Health()
    local stats = xDTaraZ.Heal.Player()
    if not stats then return nil end
    return stats.curHp, stats.maxHp
end

---@return table  configId -> hp restored
function xDTaraZ.Heal.Values()
    local cached = xDTaraZ.Heal.Cache
    if cached then return cached end
    local medicine = GameLib.Configs.MedicineConfig
    local values = {}
    for id, entry in pairs(type(medicine) == "table" and type(medicine.datamap) == "table" and medicine.datamap or {}) do
        if type(entry) == "table" and type(entry.value) == "number" then values[id] = entry.value end
    end
    xDTaraZ.Heal.Cache = values
    return values
end

---@param missing number  hp to fill
---@param urgent boolean  take the biggest one
---@return table?  { bagUid, itemUid, name }
function xDTaraZ.Heal.PickMed(missing, urgent)
    local manager = xDTaraZ.Loot.Manager()
    local bags = manager and manager.BagController.bagMap
    if type(bags) ~= "table" then return nil end
    local values, tried = xDTaraZ.Heal.Values(), xDTaraZ.State.Tried
    local best, bestScore
    for bagUid, bag in pairs(bags) do
        for itemUid, item in pairs(type(bag.itemMap) == "table" and bag.itemMap or {}) do
            local heal = values[item.configId]
            if not heal or (tried[itemUid] and osClock() - tried[itemUid] < xDTaraZ.Config.LootRetry) then continue end
            local score = urgent and -heal or math.abs(missing - heal)
            if not bestScore or score < bestScore then best, bestScore = { bagUid, itemUid, item.configId }, score end
        end
    end
    if best then best[3] = xDTaraZ.ItemNames[best[3]] end
    return best
end

---@return boolean  a med was taken
function xDTaraZ.Heal.Now()
    local hp, maxHp = xDTaraZ.Heal.Health()
    if not (hp and maxHp and hp < maxHp and xDTaraZ.Player.InBattle()) then return false end
    local urgent = hp / maxHp * 100 <= xDTaraZ.Config.HealUrgent
    local med = xDTaraZ.Heal.PickMed(maxHp - hp, urgent)
    if not (med and xDTaraZ.Loot.Pick(med[1], med[2], med[3])) then return false end
    xDTaraZ.Heal.LastHeal = osClock()
    xDTaraZ.Heal.Healed += 1
    return true
end

function xDTaraZ.Heal.Step()
    if not xDTaraZ.Options.AutoHeal then return end
    if osClock() - xDTaraZ.Heal.LastHeal < xDTaraZ.Config.HealGap then return end
    local hp, maxHp = xDTaraZ.Heal.Health()
    if not (hp and maxHp) or hp / maxHp * 100 > xDTaraZ.Options.HealAt then return end
    xDTaraZ.Heal.Now()
end

function xDTaraZ.Heal.GetStatus()
    local hp, maxHp = xDTaraZ.Heal.Health()
    if not hp then return "HP unknown" end
    return string.format("HP %d/%d | Meds used %d", math.floor(hp), math.floor(maxHp), xDTaraZ.Heal.Healed)
end

xDTaraZ.Hunt = { LastSeen = 0, Jumps = 0 }

---@return Model?  closest living enemy anywhere on the map
function xDTaraZ.Hunt.Nearest()
    local hrp = xDTaraZ.Player.Root()
    if not hrp then return nil end
    local best, bestDist
    for _, model in ipairs(xDTaraZ.Target.Candidates()) do
        local root = xDTaraZ.Target.IsEnemy(model) and model:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        local dist = (root.Position - hrp.Position).Magnitude
        if not bestDist or dist < bestDist then best, bestDist = model, dist end
    end
    return best
end

function xDTaraZ.Hunt.Step()
    if not (xDTaraZ.Options.Hunt and xDTaraZ.Player.InBattle()) then return end
    if xDTaraZ.State.Target then
        xDTaraZ.Hunt.LastSeen = osClock()
        return
    end
    if osClock() - xDTaraZ.Hunt.LastSeen < xDTaraZ.Config.HuntIdle then return end
    local enemy, hrp = xDTaraZ.Hunt.Nearest(), xDTaraZ.Player.Root()
    if not (enemy and hrp) then return end
    local root = enemy.HumanoidRootPart
    local back = root.CFrame.LookVector * vector3New(1, 0, 1)
    back = back.Magnitude > 0.1 and back.Unit or vector3New(1, 0, 0)
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.CFrame = CFrame.lookAt(root.Position - back * xDTaraZ.Config.HuntDistance + vector3New(0, xDTaraZ.Config.HuntLift, 0), root.Position)
    xDTaraZ.Hunt.LastSeen = osClock()
    xDTaraZ.Hunt.Jumps += 1
end

xDTaraZ.Farm = { Bag = nil, Start = nil, Totals = {}, LobbySince = nil }

---@return table?  your persistent currency bag (gold, ore, crystals)
function xDTaraZ.Farm.CurrencyBag()
    local farm = xDTaraZ.Farm
    if farm.Bag and type(rawget(farm.Bag, "itemMap")) == "table" then return farm.Bag end
    if not xDTaraZ.Caps.Gc then return nil end
    for _, entry in ipairs(Util.GetGc(true)) do
        if type(entry) == "table" and rawget(entry, "bagType") == xDTaraZ.Config.CurrencyType and type(rawget(entry, "itemMap")) == "table" and rawget(entry, "controller") then
            farm.Bag = entry
            return entry
        end
    end
    return nil
end

function xDTaraZ.Farm.Sample()
    local bag = xDTaraZ.Farm.CurrencyBag()
    if not bag then return end
    local totals = {}
    for _, item in pairs(bag.itemMap) do totals[xDTaraZ.ItemNames[item.configId]] = item.num end
    xDTaraZ.Farm.Totals = totals
    if not xDTaraZ.Farm.Start then xDTaraZ.Farm.Start = { osClock(), table.clone(totals), xDTaraZ.State.Kills } end
end

---@return string  gains per hour since the script started
function xDTaraZ.Farm.GetStatus()
    local start = xDTaraZ.Farm.Start
    if not start then return "-" end
    local hours = math.max(osClock() - start[1], 60) / 3600
    local parts = {}
    for _, name in ipairs(xDTaraZ.Config.TrackedCurrency) do
        local gained = (xDTaraZ.Farm.Totals[name] or 0) - (start[2][name] or 0)
        parts[#parts + 1] = string.format("%s +%d (%d/h)", name, gained, math.floor(gained / hours))
    end
    local kills = xDTaraZ.State.Kills - start[3]
    parts[#parts + 1] = string.format("Kills %d (%d/h)", kills, math.floor(kills / hours))
    return table.concat(parts, " | ")
end

xDTaraZ.Esp = { Count = 0 }

---@return table[]  targets in the shape Library.Visuals expects
function xDTaraZ.Esp.Targets()
    local list = {}
    for _, model in ipairs(xDTaraZ.Target.Candidates()) do
        local hum = model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        list[#list + 1] = {
            Model = model,
            Name = xDTaraZ.Target.Label(model),
            Health = hum.Health,
            MaxHealth = hum.MaxHealth > 0 and hum.MaxHealth or 100,
            Friendly = not xDTaraZ.Target.IsEnemy(model),
            Root = model:FindFirstChild("HumanoidRootPart"),
        }
    end
    xDTaraZ.Esp.Count = #list
    return list
end

function xDTaraZ.Esp.GetStatus()
    local visuals = xDTaraZ.Library and xDTaraZ.Library.Visuals
    if not (visuals and visuals:Get("Enabled")) then return "Off" end
    return xDTaraZ.Esp.Count .. " targets"
end

xDTaraZ.Scheduler = { Jobs = {}, Booted = false }

function xDTaraZ.Scheduler.Every(name, interval, fn)
    xDTaraZ.Scheduler.Jobs[name] = { Interval = interval, Fn = fn, Last = 0, Running = false }
end

function xDTaraZ.Scheduler.Step()
    local now = osClock()
    for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
        if job.Running or now - job.Last < job.Interval then continue end
        job.Last, job.Running = now, true
        task.spawn(function()
            local ok, err = pcall(job.Fn)
            job.Running = false
            if not ok then warn("[AirDropArena] job " .. name .. ":", err) end
        end)
    end
end

function xDTaraZ.Scheduler.Boot()
    if xDTaraZ.Scheduler.Booted then return end
    xDTaraZ.Scheduler.Booted = true
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Scheduler.Step)
end

xDTaraZ.UI = {}
local Library, T

function xDTaraZ.UI.Detach(fn)
    return function(...)
        local packed = table.pack(...)
        task.defer(function()
            local ok, err = pcall(fn, table.unpack(packed, 1, packed.n))
            if not ok then warn("[AirDropArena] ui:", err) end
        end)
    end
end

function xDTaraZ.UI.Bind(widget, key)
    local function Apply(value) xDTaraZ.Options[key] = value end
    Apply(widget.Value)
    widget:OnChanged(Apply)
end

---@return string  status kind for AddStatus
function xDTaraZ.UI.Kind(text)
    if text == nil or text == "" or text == "-" or text == "Off" then return "Idle" end
    if string.find(text, "unknown", 1, true) then return "Waiting" end
    return "Running"
end

---@param got number   items taken
---@param none string  shown when nothing was taken
function xDTaraZ.UI.Report(title, got, done, none)
    if got > 0 then
        Library:Notify(title, done:format(got), 4, "Success")
    else
        Library:Notify(title, none, 4, "Info")
    end
end

function xDTaraZ.UI.LootStatus()
    local state = xDTaraZ.State
    local wait = math.max(0, math.floor(state.AirDropAt - Workspace:GetServerTimeNow()))
    local eta = wait > 0 and ("next in %ds"):format(wait) or "-"
    return string.format("Gear %d | Valuables %d | Air drop %d (%s) | Last: %s", state.Looted, state.Valuables, state.AirDrops, eta, state.LastLoot)
end

function xDTaraZ.UI.RegisterIcons()
    if Library:HasIcon("airdrop") then return end
    Library:AddIcon("airdrop", {
        "..WWWWW..",
        ".WWRWRWW.",
        "W.R.W.R.W",
        ".R..W..R.",
        "..R.W.R..",
        "...RWR...",
        "..BBBBB..",
        "..BYBYB..",
        "..BBBBB..",
    }, {
        W = Color3.fromRGB(240, 240, 232),
        R = Color3.fromRGB(226, 60, 52),
        B = Color3.fromRGB(120, 84, 44),
        Y = Color3.fromRGB(238, 196, 82),
    })
end

function xDTaraZ.UI.BuildMain(window)
    window:AddTabSection(T("Main", "หลัก"))
    local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and links", "สถานะและลิงก์"))

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "stats")
    status:AddStatus("StatusCombat", { Text = T("Combat", "การต่อสู้"), Icon = "crosshair" })
    status:AddStatus("StatusHeal", { Text = T("Health", "เลือด"), Icon = "heal" })
    status:AddStatus("StatusLoot", { Text = T("Loot", "ของดรอป"), Icon = "airdrop" })
    status:AddStatus("StatusEsp", { Text = T("ESP", "ESP"), Icon = "esp" })

    local live = tab:AddLeftGroupbox(T("Live", "ตัวเลขสด"), "chart")
    live:AddStat("StatKills", { Text = T("Kills", "ฆ่า"), Icon = "skull", Format = "%s" })
    for _, name in ipairs(xDTaraZ.Config.TrackedCurrency) do
        live:AddStat("Stat" .. name, { Text = name, Icon = "coin", Format = "%s", Token = "Coin" })
    end

    local quick = tab:AddRightGroupbox(T("Quick", "ด่วน"), "lightning")
    quick:AddButton({ Text = T("Panic - All Off", "ฉุกเฉิน ปิดทั้งหมด"), Icon = "stop", Style = "Danger", Callback = xDTaraZ.UI.Detach(function()
        for _, toggle in pairs(Library.Toggles) do
            if toggle.Value == true then toggle:SetValue(false) end
        end
    end) })

    Library.Kit.Discord.Build(tab, xDTaraZ.Config.Discord)
end

function xDTaraZ.UI.BuildAim(tab)
    local aim = tab:AddLeftGroupbox(T("Aimbot", "เล็งอัตโนมัติ"), "aimbot")
    aim:AddFeature("Aimbot", {
        Text = T("Aimbot", "เล็งอัตโนมัติ"),
        Description = T("Locks your view onto the closest enemy in the FOV", "ล็อคกล้องไปที่ศัตรูในวงเล็ง"),
        Icon = "aimbot",
        Keybind = { Default = "X", Mode = "Hold" },
        Options = function(options)
            options:AddSlider("AimSmooth", { Text = T("Smoothness", "ความนุ่ม"), Icon = "sliders-horizontal", Min = 1, Max = 20, Default = 1, Rounding = 0 })
        end,
    })

    local targeting = tab:AddLeftGroupbox(T("Targeting", "การเลือกเป้า"), "crosshair")
    targeting:AddSegmented("AimBone", { Text = T("Hit part", "จุดที่ยิง"), Icon = "headshot", Values = { "Head", "Torso" }, Default = "Head" })
    targeting:AddSegmented("AimPriority", { Text = T("Priority", "เลือกเป้าตาม"), Icon = "sort", Values = { "Crosshair", "Distance" }, Default = "Crosshair" })
    targeting:AddCheckbox("TargetBots", { Text = T("Include bots", "รวมบอท"), Icon = "triggerbot", Default = true })
    targeting:AddSlider("AimFov", { Text = T("FOV", "วงเล็ง"), Icon = "fov", Min = 20, Max = 800, Default = 200, Suffix = "px" })
    targeting:AddToggle("ShowFov", { Text = T("Show FOV circle", "แสดงวงเล็ง"), Icon = "eye" })
    targeting:AddSlider("AimMaxDistance", { Text = T("Max distance", "ระยะสูงสุด"), Icon = "distance", Min = 50, Max = 2000, Default = 1000, Suffix = "m" })

    local rage = tab:AddRightGroupbox(T("Rage", "เรจ"), "ragebot")
    rage:AddFeature("SilentAim", {
        Text = T("Silent Aim", "ไซเลนต์เอม"),
        Description = T("Every shot you fire hits the target in the FOV", "ทุกนัดที่ยิงโดนเป้าในวงเล็ง"),
        Icon = "silentaim",
        Risky = true,
        Keybind = { Default = "None", Mode = "Toggle" },
    })
    rage:AddFeature("Ragebot", {
        Text = T("Ragebot", "เรจบอท"),
        Description = T("Shoots every reachable enemy on its own", "ยิงศัตรูทุกตัวที่ยิงถึงเอง"),
        Icon = "ragebot",
        Risky = true,
        Badge = T("Risky", "เสี่ยง"),
        Keybind = { Default = "None", Mode = "Toggle" },
    })
    rage:AddFeature("Hunt", {
        Text = T("Hunt", "ล่าศัตรู"),
        Description = T("Jumps behind the closest enemy when nobody is in sight", "ไปโผล่หลังศัตรูที่ใกล้สุดเมื่อไม่เห็นใคร"),
        Icon = "target",
        Risky = true,
        Badge = T("Risky", "เสี่ยง"),
        Keybind = { Default = "None", Mode = "Toggle" },
    })

    Library.Kit.Caps.NeedCap("SilentAim", "Hook")
    Library.Kit.Caps.NeedCap("Ragebot", "Hook")
    Library.Kit.Caps.NeedCap("ShowFov", "Drawing")
end

function xDTaraZ.UI.BuildGunMods(tab)
    local weapon = tab:AddLeftGroupbox(T("Weapon", "อาวุธ"), "gun")
    weapon:AddFeature("RapidFire", {
        Text = T("Rapid Fire", "ยิงรัว"),
        Icon = "rapidfire",
        Risky = true,
        Options = function(options)
            options:AddSlider("FireRateMult", { Text = T("Fire rate", "ความเร็วยิง"), Icon = "speed", Min = 1, Max = 10, Default = 2, Rounding = 1, Suffix = "x" })
        end,
    })
    weapon:AddToggle("NoSpread", { Text = T("No Spread", "ยิงไม่กระจาย"), Icon = "spread" })
    weapon:AddToggle("NoRecoil", { Text = T("No Recoil", "ไม่มีแรงถีบ"), Icon = "recoil" })

    local scope = tab:AddRightGroupbox(T("Scope", "ศูนย์เล็ง"), "scope")
    scope:AddToggle("InstantAds", { Text = T("Instant ADS", "เล็งศูนย์ทันที"), Description = T("Sights are up the moment you aim", "ยกศูนย์เล็งทันทีที่กดเล็ง"), Icon = "scope" })

    for _, idx in ipairs({ "RapidFire", "NoSpread", "NoRecoil", "InstantAds" }) do
        Library.Kit.Caps.NeedCap(idx, "Gc")
    end
end

function xDTaraZ.UI.BuildSurvival(tab)
    local heal = tab:AddLeftGroupbox(T("Healing", "ฮีล"), "heal")
    heal:AddFeature("AutoHeal", {
        Text = T("Auto Heal", "ฮีลอัตโนมัติ"),
        Description = T("Uses a med kit from anywhere on the map when you get hurt", "ใช้ยาจากทุกที่ในแมพทันทีที่เลือดลด"),
        Icon = "heal",
        Risky = true,
        Now = { Text = T("Heal Now", "ฮีลตอนนี้"), Icon = "heart", Style = "Success", Callback = xDTaraZ.UI.Detach(function()
            if not xDTaraZ.Heal.Now() then Library:Notify("Heal", "No med on the map or HP is full", 3, "Info") end
        end) },
        Options = function(options)
            options:AddSlider("HealAt", { Text = T("Heal below", "ฮีลเมื่อเลือดต่ำกว่า"), Icon = "heart", Min = 10, Max = 99, Default = 70, Rounding = 0, Suffix = "%" })
        end,
    })
    Library.Kit.Caps.NeedCap("AutoHeal", "Gc")

    local life = tab:AddRightGroupbox(T("Respawn", "เกิดใหม่"), "rebirth")
    life:AddFeature("InstantRespawn", {
        Text = T("Auto Respawn", "เกิดใหม่อัตโนมัติ"),
        Description = T("Back in the fight as soon as the game allows", "กลับเข้าสนามทันทีที่เกมอนุญาต"),
        Icon = "rebirth",
        Now = { Text = T("Respawn Now", "เกิดใหม่ตอนนี้"), Icon = "play", Callback = xDTaraZ.UI.Detach(function()
            xDTaraZ.State.LastRespawn = 0
            xDTaraZ.Respawn.Now()
        end) },
    })
    life:AddToggle("AutoRejoin", { Text = T("Auto Rejoin Match", "เข้าแมตช์ใหม่อัตโนมัติ"), Description = T("Jumps back into a match when you sit in the lobby", "กลับเข้าแมตช์เองเมื่อค้างอยู่ในล็อบบี้"), Icon = "rejoin" })
end

function xDTaraZ.UI.BuildCombat(window)
    window:AddTabSection(T("Combat", "การต่อสู้"))
    xDTaraZ.UI.BuildAim(window:AddTab(T("Aim", "เล็ง"), "aimbot", T("Aimbot, silent aim and rage", "เล็ง ไซเลนต์ และเรจ")))
    xDTaraZ.UI.BuildGunMods(window:AddTab(T("Gun Mods", "ม็อดปืน"), "gun", T("Fire rate, spread and recoil", "ความเร็วยิง การกระจาย แรงถีบ")))
    xDTaraZ.UI.BuildSurvival(window:AddTab(T("Survival", "เอาตัวรอด"), "heart", T("Healing and respawn", "ฮีลและเกิดใหม่")))
end

function xDTaraZ.UI.BuildLoot(window)
    window:AddTabSection(T("Farming", "ฟาร์ม"))
    local tab = window:AddTab(T("Loot", "ของดรอป"), "loot", T("Gear, valuables and air drops from anywhere", "ของ ของมีค่า และแอร์ดรอปจากทุกที่"))

    local gear = tab:AddLeftGroupbox(T("Best Gear", "ของดีที่สุด"), "crown")
    gear:AddFeature("AutoGear", {
        Text = T("Auto Loot Best Gear", "เก็บของดีสุดอัตโนมัติ"),
        Description = T("Takes better guns and armor from any crate on the map", "เก็บปืนและเกราะที่ดีกว่าจากกล่องทุกใบในแมพ"),
        Icon = "shield",
        Risky = true,
        Now = { Text = T("Loot Best Now", "เก็บของดีสุดตอนนี้"), Icon = "loot", Callback = xDTaraZ.UI.Detach(function()
            xDTaraZ.UI.Report("Loot", xDTaraZ.Loot.TakeUpgrades(), "Took %d upgrades", "Nothing better on the map")
        end) },
        Options = function(options)
            options:AddMultiChips("LootGear", {
                Text = T("Gear types", "ประเภทของ"),
                Icon = "filter",
                Values = { "Primary", "Pistol", "Helmet", "Armor" },
                Default = { "Primary", "Pistol", "Helmet", "Armor" },
            })
        end,
    })

    local money = tab:AddLeftGroupbox(T("Valuables", "ของมีค่า"), "coin")
    money:AddFeature("AutoValuables", {
        Text = T("Auto Loot Valuables", "เก็บของมีค่าอัตโนมัติ"),
        Description = T("Takes ore, crystals and gold from every crate on the map", "เก็บแร่ คริสตัล และทองจากกล่องทุกใบในแมพ"),
        Icon = "coin",
        Risky = true,
        Now = { Text = T("Loot Valuables Now", "เก็บของมีค่าตอนนี้"), Icon = "money", Callback = xDTaraZ.UI.Detach(function()
            xDTaraZ.UI.Report("Loot", xDTaraZ.Loot.TakeValuables(), "Took %d valuables", "No valuables on the map")
        end) },
    })

    local drop = tab:AddRightGroupbox(T("Air Drop", "แอร์ดรอป"), "airdrop")
    drop:AddFeature("AutoAirDrop", {
        Text = T("Auto Air Drop", "แอร์ดรอปอัตโนมัติ"),
        Description = T("Takes air drop loot from anywhere on the map", "เก็บของในแอร์ดรอปได้จากทุกที่ในแมพ"),
        Icon = "airdrop",
        Risky = true,
        Now = { Text = T("Loot Air Drops Now", "เก็บแอร์ดรอปตอนนี้"), Icon = "chest", Callback = xDTaraZ.UI.Detach(function()
            xDTaraZ.UI.Report("Air Drop", xDTaraZ.Loot.EmptyAirDrops(), "Took %d items", "Nothing to take")
        end) },
    })

    for _, idx in ipairs({ "AutoGear", "AutoValuables", "AutoAirDrop" }) do
        Library.Kit.Caps.NeedCap(idx, "Gc")
    end
end

function xDTaraZ.UI.BuildVisuals(window)
    window:AddTabSection(T("Visuals", "การมองเห็น"))
    window:AddVisualsTab({ Icon = "esp", Provider = xDTaraZ.Esp.Targets, Preview = true })

    local tab = window:AddTab(T("Loot ESP", "มองเห็นของ"), "chest", T("Air drops, crates and items", "แอร์ดรอป กล่อง และไอเทม"))
    local esp = tab:AddLeftGroupbox(T("Loot ESP", "มองเห็นของ"), "eye")
    esp:AddToggle("LootEspAirDrop", { Text = T("Air Drops", "แอร์ดรอป"), Icon = "airdrop" })
    esp:AddToggle("LootEspCrate", { Text = T("Crates", "กล่อง"), Icon = "box" })
    esp:AddToggle("LootEspItem", { Text = T("Items", "ไอเทม"), Icon = "loot" })
    esp:AddSlider("LootEspRange", { Text = T("Range", "ระยะ"), Description = T("Air drops show at any range", "แอร์ดรอปแสดงทุกระยะ"), Icon = "distance", Min = 50, Max = 2000, Default = 400, Suffix = "m" })
end

function xDTaraZ.UI.BuildMovement(tab)
    local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "speed")
    move:AddFeature("SuperSlide", {
        Text = T("Slide Boost", "สไลด์ไกล"),
        Description = T("Faster and longer slides", "สไลด์เร็วและไกลขึ้น"),
        Icon = "dash",
        Options = function(options)
            options:AddSlider("SlideSpeed", { Text = T("Slide speed", "ความเร็วสไลด์"), Icon = "speed", Min = 60, Max = 300, Default = 120, Rounding = 0 })
        end,
    })
    Library.Kit.Caps.NeedCap("SuperSlide", "Gc")

    move:AddFeature("Speed", {
        Text = T("Speed", "วิ่งเร็ว"),
        Icon = "speed",
        Keybind = { Default = "None", Mode = "Toggle" },
        Options = function(options)
            options:AddSlider("SpeedValue", { Text = T("Walk speed", "ความเร็ว"), Icon = "speed", Min = 16, Max = 120, Default = 40, Rounding = 0 })
        end,
    })
    move:AddFeature("Fly", {
        Text = T("Fly", "บิน"),
        Description = T("Space up, Ctrl down", "Space ขึ้น Ctrl ลง"),
        Icon = "fly",
        Keybind = { Default = "None", Mode = "Toggle" },
        Callback = function(on)
            if not on then xDTaraZ.Movement.StopFly() end
        end,
        Options = function(options)
            options:AddSlider("FlySpeed", { Text = T("Fly speed", "ความเร็วบิน"), Icon = "speed", Min = 20, Max = 200, Default = 60, Rounding = 0 })
        end,
    })
    move:AddToggle("InfiniteJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด"), Icon = "infjump" })
    move:AddFeature("Noclip", { Text = T("Noclip", "ทะลุกำแพง"), Icon = "noclip", Keybind = { Default = "None", Mode = "Toggle" } })
end

function xDTaraZ.UI.BuildMisc(window)
    window:AddTabSection(T("Misc", "อื่นๆ"))
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "player", T("Movement, world, server", "การเคลื่อนที่ โลก เซิร์ฟเวอร์"))
    xDTaraZ.UI.BuildMovement(tab)

    local world = tab:AddRightGroupbox(T("World", "โลก"), "globe")
    world:AddToggle("Fullbright", { Text = T("Fullbright", "สว่างทั้งแมพ"), Icon = "fullbright" })
    world:AddToggle("CameraFov", { Text = T("Camera FOV", "มุมกล้อง"), Icon = "fov" })
    world:AddSlider("CameraFovValue", { Text = T("FOV", "มุมกล้อง"), Icon = "fov", Min = 50, Max = 120, Default = 90, Rounding = 0, DependsOn = { "CameraFov", true } })

    local server = tab:AddRightGroupbox(T("Server", "เซิร์ฟเวอร์"), "castle")
    server:AddToggle("AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK"), Icon = "antiafk" })
    server:AddButton({ Text = T("Rejoin", "เข้าใหม่"), Icon = "rejoin", Style = "Ghost", Callback = xDTaraZ.UI.Detach(xDTaraZ.World.Rejoin) })
    server:AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Icon = "globe", Style = "Ghost", Callback = xDTaraZ.UI.Detach(function()
        if not xDTaraZ.World.Hop() then Library:Notify(T("Server", "เซิร์ฟเวอร์"), T("No other server found", "ไม่เจอเซิร์ฟอื่น"), 4, "Warning") end
    end) })
end

function xDTaraZ.UI.Live()
    local interval = xDTaraZ.Config.StatusInterval
    local feeds = {
        StatusCombat = xDTaraZ.Combat.GetStatus,
        StatusHeal = xDTaraZ.Heal.GetStatus,
        StatusLoot = xDTaraZ.UI.LootStatus,
        StatusEsp = xDTaraZ.Esp.GetStatus,
    }
    for idx, read in pairs(feeds) do
        Library.Lib.Status(idx, function()
            local text = read()
            return text, xDTaraZ.UI.Kind(text)
        end, interval)
    end

    Library.Lib.Status("StatKills", function() return xDTaraZ.State.Kills end, interval)
    for _, name in ipairs(xDTaraZ.Config.TrackedCurrency) do
        Library.Lib.Status("Stat" .. name, function()
            local start = xDTaraZ.Farm.Start
            return start and (xDTaraZ.Farm.Totals[name] or 0) - (start[2][name] or 0) or 0
        end, interval)
    end
end

function xDTaraZ.UI.Build()
    local window = Library.Window
    xDTaraZ.UI.RegisterIcons()
    for _, build in ipairs({ xDTaraZ.UI.BuildMain, xDTaraZ.UI.BuildCombat, xDTaraZ.UI.BuildLoot, xDTaraZ.UI.BuildVisuals, xDTaraZ.UI.BuildMisc }) do
        local ok, err = pcall(build, window)
        if not ok then warn("[AirDropArena] build:", err) end
    end
    window:AddSettingsTab()

    for key in pairs(xDTaraZ.Options) do
        local widget = Library.Options[key]
        if widget then xDTaraZ.UI.Bind(widget, key) end
    end
    xDTaraZ.UI.Live()
end

local function BuildInterface()
    Library = loadstring(Util.HttpGet(xDTaraZ.Config.UiSource))()
    MarioBanner.Step("UI library")
    xDTaraZ.Library = Library
    T = function(en, th) return Library:T(en, th) end
    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "FPS AirDrop Arena by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = xDTaraZ.Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        Intro = xDTaraZ.Config.Intro,
        OnUnlocked = function()
            xDTaraZ.UI.Build()
            task.defer(xDTaraZ.Boot)
            task.defer(function() Library:LoadAutoloadConfig() end)
        end,
    })
    Library:OnUnload(function()
        xDTaraZ:Unload()
    end)
end

function xDTaraZ.Boot()
    xDTaraZ.Combat.Start()
    xDTaraZ.Movement.Start()
    xDTaraZ:Connect(LocalPlayer.Idled, xDTaraZ.World.OnIdled)
    xDTaraZ:Connect(RunService.RenderStepped, xDTaraZ.World.OnRender)
    if LocalPlayer.Character then xDTaraZ.Respawn.Watch(LocalPlayer.Character) end
    xDTaraZ:Connect(LocalPlayer.CharacterAdded, xDTaraZ.Respawn.Watch)

    xDTaraZ.Scheduler.Every("Guns", 0.5, xDTaraZ.Guns.Step)
    xDTaraZ.Scheduler.Every("AirDrop", 1, xDTaraZ.Loot.AirDropStep)
    xDTaraZ.Scheduler.Every("LootEsp", 0.5, xDTaraZ.Loot.EspStep)
    xDTaraZ.Scheduler.Every("World", 0.5, xDTaraZ.World.Step)
    xDTaraZ.Scheduler.Every("Respawn", 0.5, xDTaraZ.Respawn.Step)
    xDTaraZ.Scheduler.Every("Gear", 0.5, xDTaraZ.Loot.GearStep)
    xDTaraZ.Scheduler.Every("Valuables", 1, xDTaraZ.Loot.ValuablesStep)
    xDTaraZ.Scheduler.Every("Heal", 0.1, xDTaraZ.Heal.Step)
    xDTaraZ.Scheduler.Every("Farm", 2, function()
        xDTaraZ.Farm.Sample()
        xDTaraZ.Respawn.Rejoin()
    end)
    xDTaraZ.Scheduler.Every("Hunt", 0.5, xDTaraZ.Hunt.Step)
    xDTaraZ.Scheduler.Boot()
end

function xDTaraZ:Unload()
    self.State.Alive = false
    xDTaraZ.Combat.Unload()
    xDTaraZ.Guns.Restore()
    for _, key in ipairs({ "Fullbright", "CameraFov", "LootEspAirDrop", "LootEspCrate", "LootEspItem", "Noclip", "Fly", "Speed" }) do
        xDTaraZ.Options[key] = false
    end
    pcall(xDTaraZ.Loot.EspStep)
    pcall(xDTaraZ.World.Step)
    pcall(xDTaraZ.World.OnRender)
    pcall(xDTaraZ.Movement.OnStepped)
    for _, conn in ipairs(self.State.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(self.State.Connections)
end

environment.AirDropArenaUnload = function()
    if xDTaraZ.Library and not xDTaraZ.Library.Unloaded then
        xDTaraZ.Library:Unload()
    else
        xDTaraZ:Unload()
    end
end

MarioBanner.Step("Systems")
BuildInterface()
MarioBanner.Step("Interface")
MarioBanner.Ready()