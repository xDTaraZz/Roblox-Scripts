if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

if game.GameId ~= 7633926880 then
    LocalPlayer:Kick("Mario Hub: this script is for BloxStrike only")
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

MarioBanner.Show()
MarioBanner.Step("Core")

local environment = getgenv and getgenv() or _G
if environment.BloxStrikeUnload then pcall(environment.BloxStrikeUnload) end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local vector2New, vector3New = Vector2.new, Vector3.new
local cframeLookAt = CFrame.lookAt
local osClock = os.clock

local Library, T

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui_v2.lua",
    Discord = "https://discord.gg/FHVfmeSceA",
    SaveFolder = "BloxStrike",
    StatusInterval = 1,
    AimRenderPriority = Enum.RenderPriority.Camera.Value + 1,
    RefireGap = 0.12,
    TriggerRay = 2000,
    RedeemGap = 1.1,
    RebuyGap = 0.25,
    Codes = { "FREEDOM", "MICHAELSRETURN", "HAPPYBDAYYUUTO", "GAMEBROKE318", "OHNEPIXEL", "NEBULA", "REACTORDELAY", "BUTTERFLYCASE", "TRADEUPS" },
    BoneParts = {
        Head = { "Head" },
        Torso = { "UpperTorso", "Torso", "HumanoidRootPart" },
    },
    BuyStates = { ["Buy Period"] = true, ["Warmup"] = true },
    StickySlack = 1.5,
    GroundRay = 3.6,
    HopGap = 0.05,
    SkinFile = "BloxStrike/skins.json",
    SkinWears = { "Factory New", "Minimal Wear", "Field-Tested", "Well-Worn", "Battle-Scarred" },
    SkinKinds = { Melee = "Knives", Glove = "Gloves", Grenade = "Grenades", C4 = "Gear", ["Zeus x27"] = "Gear" },
    SkinOrder = { "Pistol", "SMG", "Rifle", "Sniper", "Heavy", "Shotgun", "Machine Gun", "Knives", "Gloves", "Grenades", "Gear" },
    SkinRanks = { Forbidden = 9, Special = 8, Red = 7, Pink = 6, Purple = 5, Blue = 4, LightBlue = 3, Gray = 2, White = 1 },
    SkinArms = { ["Left Arm"] = true, ["Right Arm"] = true },
    GloveKey = "@Glove",
    FovColors = {
        Aimbot = Color3.fromRGB(232, 160, 76),
        Silent = Color3.fromRGB(110, 170, 255),
    },
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
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
    WeaponSaved = {},
    Hooks = {},
    HopAt = 0,
    HopCrouched = false,
    SpaceHeld = false,
    HopEcho = { [true] = 0, [false] = 0 },
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
    RecoilKeep = 0,
    NoSpread = false,
    FullAuto = false,
    RapidFire = false,
    FireRateMult = 1.5,
    WeaponSpeed = false,
    WeaponSpeedMult = 1.3,
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

xDTaraZ.Caps = {
    Hook = type(hookfunction) == "function",
    Restore = type(restorefunction) == "function",
    Gc = type(getgc) == "function",
    Drawing = type(Drawing) == "table" and type(Drawing.new) == "function",
}

xDTaraZ.Util = {}

function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then return body end
    local req = request or http_request or (syn and syn.request)
    if not req then error("no http") end
    return req({ Url = url, Method = "GET" }).Body
end

function xDTaraZ.Util.Copy(text)
    local fn = setclipboard or toclipboard
    if not fn then return false end
    return pcall(fn, text)
end

function xDTaraZ.Util.Hook(key, fn, replacement)
    if not xDTaraZ.Caps.Hook or type(fn) ~= "function" or xDTaraZ.State.Hooks[key] then return end
    local original = hookfunction(fn, replacement)
    xDTaraZ.State.Hooks[key] = { Fn = fn, Original = original }
    return original
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

xDTaraZ.GameLib = {}
do
    local controllers = ReplicatedStorage:FindFirstChild("Controllers")
    local function load(inst)
        if not inst then return nil end
        local ok, mod = pcall(require, inst)
        return ok and mod or nil
    end
    xDTaraZ.GameLib.Net = load(ReplicatedStorage:FindFirstChild("Database") and ReplicatedStorage.Database.Security:FindFirstChild("Remotes"))
    xDTaraZ.GameLib.Camera = load(controllers and controllers:FindFirstChild("CameraController"))
    xDTaraZ.GameLib.WeaponFolder = ReplicatedStorage:FindFirstChild("Database") and ReplicatedStorage.Database.Custom:FindFirstChild("Weapons")
end

xDTaraZ.Weapons = {}
do
    local folder = xDTaraZ.GameLib.WeaponFolder
    if folder then
        for _, module in ipairs(folder:GetChildren()) do
            if module:IsA("ModuleScript") then
                local ok, data = pcall(require, module)
                if ok and type(data) == "table" and data.FireRate then xDTaraZ.Weapons[module.Name] = data end
            end
        end
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

function xDTaraZ.Target.IsEnemy(model)
    if tostring(model:GetAttribute("Dead")) == "true" then return false end
    local owner = xDTaraZ.Target.Owner(model)
    if not owner then return false end
    local mine = LocalPlayer:GetAttribute("Team")
    return mine == nil or owner:GetAttribute("Team") ~= mine
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
    for _, bullet in ipairs(payload.Bullets) do
        local origin = typeof(bullet.Origin) == "Vector3" and bullet.Origin or Workspace.CurrentCamera.CFrame.Position
        local offset = part.Position - origin
        local unit = offset.Unit
        bullet.Direction = unit
        bullet.Hits = { { Instance = part, Position = part.Position, Normal = -unit, Material = "Plastic", Distance = offset.Magnitude, Exit = false } }
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

function xDTaraZ.Combat.Circle(key, show, radius)
    local circle = xDTaraZ.Combat.Circles[key]
    if not show then
        if circle then circle.Visible = false end
        return
    end
    if not circle then
        circle = Drawing.new("Circle")
        circle.Thickness, circle.NumSides, circle.Filled = 1.5, 64, false
        circle.Color = xDTaraZ.Config.FovColors[key]
        xDTaraZ.Combat.Circles[key] = circle
    end
    circle.Position = Workspace.CurrentCamera.ViewportSize / 2
    circle.Radius = radius
    circle.Visible = true
end

function xDTaraZ.Combat.Step()
    local o, state = xDTaraZ.Options, xDTaraZ.State
    if xDTaraZ.Caps.Drawing then
        xDTaraZ.Combat.Circle("Aimbot", o.AimbotShowFov, o.AimbotFov)
        xDTaraZ.Combat.Circle("Silent", o.SilentShowFov, o.SilentFov)
    end
    if not xDTaraZ.Player.Alive() then
        state.AimTarget, state.AimPart, state.RageTarget, state.RagePart = nil, nil, nil, nil
        xDTaraZ.Trigger.Fire(false)
        return
    end
    xDTaraZ.Aimbot.Step()
    local rage = xDTaraZ.Rage.Step()
    xDTaraZ.Trigger.Fire(rage or xDTaraZ.Trigger.Wanted())
end

function xDTaraZ.Combat.Start()
    xDTaraZ.Silent.InstallHook()
    RunService:BindToRenderStep("xDTaraZAim", xDTaraZ.Config.AimRenderPriority, xDTaraZ.Aimbot.Lock)
    xDTaraZ:Connect(RunService.Heartbeat, function()
        local ok, err = pcall(xDTaraZ.Combat.Step)
        if not ok then warn("[BloxStrike] combat:", err) end
    end)
end

function xDTaraZ.Combat.Unload()
    xDTaraZ.Trigger.Fire(false)
    pcall(RunService.UnbindFromRenderStep, RunService, "xDTaraZAim")
    for key, circle in pairs(xDTaraZ.Combat.Circles) do
        pcall(function() circle:Remove() end)
        xDTaraZ.Combat.Circles[key] = nil
    end
end

xDTaraZ.Guns = { Signature = nil }

function xDTaraZ.Guns.Save(name, data)
    local saved = xDTaraZ.State.WeaponSaved
    if saved[name] then return saved[name] end
    local spread = type(data.Spread) == "table" and table.clone(data.Spread) or nil
    local recoil = type(data.Recoil) == "table" and table.clone(data.Recoil) or nil
    saved[name] = { FireRate = data.FireRate, Automatic = data.Automatic, WalkSpeed = data.WalkSpeed, Spread = spread, Recoil = recoil }
    return saved[name]
end

function xDTaraZ.Guns.Unfreeze(data)
    if not setreadonly then return end
    for _, section in pairs({ data = data, spread = data.Spread, recoil = data.Recoil }) do
        if type(section) == "table" and table.isfrozen(section) then pcall(setreadonly, section, false) end
    end
end

function xDTaraZ.Guns.AnyActive()
    local opts = xDTaraZ.Options
    return opts.NoSpread or opts.NoRecoil or opts.FullAuto or opts.RapidFire or opts.WeaponSpeed
end

function xDTaraZ.Guns.ApplyOne(name, data)
    local opts = xDTaraZ.Options
    xDTaraZ.Guns.Unfreeze(data)
    local base = xDTaraZ.Guns.Save(name, data)
    if base.Spread then
        for key, value in pairs(base.Spread) do
            data.Spread[key] = (opts.NoSpread and type(value) == "number") and 0 or value
        end
    end
    if base.Recoil then
        for key, value in pairs(base.Recoil) do
            local scaled = opts.NoRecoil and type(value) == "number" and key ~= "RecoverySpeed" and key ~= "Damper"
            data.Recoil[key] = scaled and value * opts.RecoilKeep / 100 or value
        end
    end
    data.Automatic = opts.FullAuto or base.Automatic
    data.FireRate = opts.RapidFire and base.FireRate / math.max(opts.FireRateMult, 1) or base.FireRate
    if base.WalkSpeed then data.WalkSpeed = opts.WeaponSpeed and base.WalkSpeed * opts.WeaponSpeedMult or base.WalkSpeed end
end

function xDTaraZ.Guns.Key()
    local o = xDTaraZ.Options
    return table.concat({ tostring(o.NoSpread), tostring(o.NoRecoil), o.RecoilKeep, tostring(o.FullAuto), tostring(o.RapidFire), o.FireRateMult, tostring(o.WeaponSpeed), o.WeaponSpeedMult }, "|")
end

function xDTaraZ.Guns.Step()
    local signature = xDTaraZ.Guns.Key()
    if signature == xDTaraZ.Guns.Signature then return end
    xDTaraZ.Guns.Signature = signature
    if not xDTaraZ.Guns.AnyActive() and not next(xDTaraZ.State.WeaponSaved) then return end
    for name, data in pairs(xDTaraZ.Weapons) do
        local ok, err = pcall(xDTaraZ.Guns.ApplyOne, name, data)
        if not ok then warn("[BloxStrike] gun:", name, err) end
    end
end

function xDTaraZ.Guns.HookRecoil()
    local cam = xDTaraZ.GameLib.Camera
    if not cam then return end
    local kick
    kick = xDTaraZ.Util.Hook("Kick", cam.weaponKick, function(...)
        local o = xDTaraZ.Options
        if o.NoRecoil and o.RecoilKeep <= 0 then return end
        return kick(...)
    end)
    local fov
    fov = xDTaraZ.Util.Hook("Fov", cam.getTargetFOV, function(...)
        if xDTaraZ.Options.CameraFov then return xDTaraZ.Options.CameraFovValue end
        return fov(...)
    end)
end

function xDTaraZ.Guns.FindClass()
    if not xDTaraZ.Caps.Gc then return nil end
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

function xDTaraZ.Guns.Restore()
    for name, base in pairs(xDTaraZ.State.WeaponSaved) do
        local data = xDTaraZ.Weapons[name]
        if data then
            xDTaraZ.Guns.Unfreeze(data)
            if base.Spread then for k, v in pairs(base.Spread) do data.Spread[k] = v end end
            if base.Recoil then for k, v in pairs(base.Recoil) do data.Recoil[k] = v end end
            data.FireRate, data.Automatic = base.FireRate, base.Automatic
            if base.WalkSpeed then data.WalkSpeed = base.WalkSpeed end
        end
    end
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

---@return number?, string[]  armor left and status tags (C4, Kit, Helmet, Scoped)
function xDTaraZ.Esp.Status(owner)
    local flags = {}
    if not owner then return nil, flags end
    local armor = xDTaraZ.Esp.Attr(owner, "Armor")
    local bomb = xDTaraZ.Esp.Attr(owner, "Slot5")
    if bomb and bomb.Weapon == "C4" then flags[#flags + 1] = "C4" end
    if owner:GetAttribute("HasDefuseKit") == true then flags[#flags + 1] = "Kit" end
    if armor and type(armor.Type) == "string" and armor.Type:find("Helmet") then flags[#flags + 1] = "Helmet" end
    if owner:GetAttribute("IsSniperScoped") == true then flags[#flags + 1] = "Scoped" end
    return armor and tonumber(armor.Health), flags
end

---@return Model?  whatever aimbot, silent aim or ragebot is locked on
function xDTaraZ.Esp.Focus()
    local state = xDTaraZ.State
    return state.AimTarget or state.SilentTarget or state.RageTarget
end

function xDTaraZ.Esp.DroppedGuns()
    local list = {}
    for _, model in ipairs(CollectionService:GetTagged("WeaponDropped")) do
        if model:GetAttribute("CanPickup") ~= false then list[#list + 1] = model end
    end
    return list
end

---@return BasePart[]  one plant zone part per site (the largest), so each site gets a single label
function xDTaraZ.Esp.Sites()
    local best = {}
    for _, part in ipairs(CollectionService:GetTagged("PlantArea")) do
        local site = part:IsA("BasePart") and part:GetAttribute("Site")
        if not site then continue end
        local current = best[site]
        if not current or part.Size.Magnitude > current.Size.Magnitude then best[site] = part end
    end
    local list = {}
    for _, part in pairs(best) do list[#list + 1] = part end
    return list
end

---@return table[]  extra Visuals categories: planted bomb, dropped guns, bombsites
function xDTaraZ.Esp.Categories()
    return {
        { Name = "Bomb", Text = T("Planted C4", "C4 ที่ปักแล้ว"), Color = Color3.fromRGB(255, 70, 70), Characters = false, MaxDistance = math.huge, Source = { Tag = "Bomb" }, Label = function() return "C4" end },
        { Name = "DroppedGuns", Text = T("Dropped Guns", "ปืนที่ตกพื้น"), Color = Color3.fromRGB(238, 196, 82), Characters = false, Source = xDTaraZ.Esp.DroppedGuns, Label = function(model) return model:GetAttribute("Weapon") end },
        { Name = "Sites", Text = T("Bombsites", "จุดปักระเบิด"), Color = Color3.fromRGB(120, 200, 255), Characters = false, MaxDistance = math.huge, Source = xDTaraZ.Esp.Sites, Label = function(part) return "Site " .. tostring(part:GetAttribute("Site")) end },
    }
end

---@return table[]  targets in the shape Library.Visuals expects
function xDTaraZ.Esp.Targets()
    local list = {}
    for _, model in ipairs(xDTaraZ.Target.Candidates()) do
        if tostring(model:GetAttribute("Dead")) == "true" then continue end
        local owner = xDTaraZ.Target.Owner(model)
        local equipped = owner and xDTaraZ.Util.Decode(owner:GetAttribute("CurrentEquipped"))
        local mine = LocalPlayer:GetAttribute("Team")
        local armor, flags = xDTaraZ.Esp.Status(owner)
        list[#list + 1] = {
            Model = model,
            Player = owner,
            Name = owner and owner.DisplayName or model.Name,
            Kind = owner and "Player" or "Bot",
            Weapon = equipped and equipped.Name,
            Armor = armor,
            MaxArmor = 100,
            Flags = flags,
            Health = tonumber(model:GetAttribute("Health")) or 100,
            MaxHealth = tonumber(model:GetAttribute("MaxHealth")) or 100,
            Enemy = mine == nil or not owner or owner:GetAttribute("Team") ~= mine,
            Root = model:FindFirstChild("HumanoidRootPart"),
            Head = model:FindFirstChild("Head"),
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
    if not xDTaraZ.Options.InfiniteJump then return end
    local hum = xDTaraZ.Player.Humanoid()
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end

function xDTaraZ.World.Grounded(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local params = xDTaraZ.State.HopParams or RaycastParams.new()
    xDTaraZ.State.HopParams = params
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { Workspace:FindFirstChild("Characters") or char, Workspace.CurrentCamera }
    return Workspace:Raycast(hrp.Position, vector3New(0, -xDTaraZ.Config.GroundRay, 0), params) ~= nil and hrp.AssemblyLinearVelocity.Y <= 1
end

function xDTaraZ.World.SetCrouch(down)
    local state = xDTaraZ.State
    if state.HopCrouched == down then return end
    state.HopCrouched = down
    VirtualInputManager:SendKeyEvent(down, Enum.KeyCode.LeftControl, false, game)
end

function xDTaraZ.World.OnSpace(input, down)
    if input.KeyCode ~= Enum.KeyCode.Space then return end
    local echo = xDTaraZ.State.HopEcho
    if echo[down] > 0 then
        echo[down] -= 1
        return
    end
    xDTaraZ.State.SpaceHeld = down
end

function xDTaraZ.World.Hop()
    local opts, state = xDTaraZ.Options, xDTaraZ.State
    local holding = opts.BunnyHop and xDTaraZ.Player.Alive() and state.SpaceHeld and not UserInputService:GetFocusedTextBox()
    if not holding then
        state.HopEcho[true], state.HopEcho[false] = 0, 0
        xDTaraZ.World.SetCrouch(false)
        return
    end
    local grounded = xDTaraZ.World.Grounded(xDTaraZ.Player.Character())
    xDTaraZ.World.SetCrouch(opts.BunnyCrouch and not grounded)
    if not grounded or osClock() - state.HopAt < xDTaraZ.Config.HopGap then return end
    state.HopAt = osClock()
    state.HopEcho[false] += 1
    state.HopEcho[true] += 1
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
end

function xDTaraZ.World.Rejoin()
    pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, game.JobId, LocalPlayer)
end

function xDTaraZ.World.ServerHop()
    pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
end

xDTaraZ.Skins = { Map = {}, Applied = setmetatable({}, { __mode = "k" }), Catalog = nil, Rarity = {} }

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
        skins.Rarity[name] = {}
        for skin, entry in pairs(entries) do
            skins.Rarity[name][skin] = type(entry) == "table" and ranks[entry.rarity] or 0
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

xDTaraZ.Scheduler = { Jobs = {} }

function xDTaraZ.Scheduler.Every(name, interval, fn)
    xDTaraZ.Scheduler.Jobs[name] = { Interval = interval, Fn = fn, Next = 0 }
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ:Connect(RunService.Heartbeat, function()
        local now = osClock()
        for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
            if now >= job.Next then
                job.Next = now + job.Interval
                local ok, err = pcall(job.Fn)
                if not ok then warn("[BloxStrike] " .. name .. ":", err) end
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

---@param cap string  key in xDTaraZ.Caps
function xDTaraZ.UI.NeedCap(idx, cap)
    if xDTaraZ.Caps[cap] then return end
    local option = Library.Options[idx]
    if not option then return end
    option:OnChanged(function(on)
        if not on then return end
        local title = option.Row and option.Row.Title
        Library:Notify("Mario Hub", (title and title.Text or idx) .. " is not supported on this executor", 5, "Warning")
        task.defer(function() option:SetValue(false) end)
    end)
end

function xDTaraZ.UI.BuildMain(window)
    window:AddTabSection(T("Main", "หลัก"))
    local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and links", "สถานะและลิงก์"))

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "stats")
    status:AddStatus("StatusMatch", { Text = T("Match", "แมตช์"), Icon = "map" })
    status:AddStatus("StatusCombat", { Text = T("Target", "เป้า"), Icon = "crosshair" })
    status:AddStatus("StatusSpectators", { Text = T("Spectators", "คนดูเรา"), Icon = "spectate" })
    status:AddStatus("StatusEsp", { Text = T("ESP", "ESP"), Icon = "esp" })

    local live = tab:AddLeftGroupbox(T("Live", "ตัวเลขสด"), "chart")
    live:AddStat("StatKills", { Text = T("Kills", "คิล"), Icon = "damage", Format = "%s", Token = "Good" })
    live:AddStat("StatShots", { Text = T("Shots fired", "นัดที่ยิง"), Icon = "ammo", Format = "%s" })
    live:AddStat("StatAimed", { Text = T("Shots aimed", "นัดที่ช่วยเล็ง"), Icon = "silentaim", Format = "%s" })

    local quick = tab:AddRightGroupbox(T("Quick", "ด่วน"), "lightning")
    quick:AddButton({ Text = T("Panic - All Off", "ฉุกเฉิน ปิดทั้งหมด"), Icon = "stop", Style = "Danger", Callback = xDTaraZ.UI.Detach(function()
        for _, toggle in pairs(Library.Toggles) do
            if toggle.Value == true then toggle:SetValue(false) end
        end
    end) })

    Library.Kit.Discord.Build(tab, xDTaraZ.Config.Discord)
end

local priorities = { "Crosshair", "Distance", "Health" }

function xDTaraZ.UI.BuildAimbot(tab)
    local main = tab:AddLeftGroupbox(T("Aimbot", "เล็งอัตโนมัติ"), "aimbot")
    main:AddFeature("Aimbot", {
        Text = T("Aimbot", "เล็งอัตโนมัติ"),
        Description = T("Locks your view onto the enemy in the FOV", "ล็อคกล้องไปที่ศัตรูในวง FOV"),
        Icon = "aimbot",
        Keybind = { Default = "E", Mode = "Hold" },
        Options = function(options)
            options:AddSlider("AimbotSmooth", { Text = T("Smoothness", "ความนุ่ม"), Description = T("1 = instant snap", "1 = หันทันที"), Icon = "sliders-horizontal", Min = 1, Max = 20, Default = 1, Rounding = 0 })
            options:AddCheckbox("AimbotSticky", { Text = T("Sticky target", "ล็อคเป้าเดิม"), Description = T("Keeps the same enemy until it is lost", "ไม่สลับเป้าจนกว่าเป้าเดิมจะหลุด"), Icon = "lock", Default = true })
        end,
    })

    local target = tab:AddLeftGroupbox(T("Aimbot Targeting", "การเลือกเป้า (เล็ง)"), "crosshair")
    target:AddSegmented("AimbotBone", { Text = T("Aim part", "จุดที่เล็ง"), Icon = "headshot", Values = { "Head", "Torso" }, Default = "Head" })
    target:AddSegmented("AimbotPriority", { Text = T("Priority", "เลือกเป้าตาม"), Icon = "sort", Values = priorities, Default = "Crosshair" })
    target:AddCheckbox("AimbotVisible", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Icon = "eye", Default = true })
    target:AddSlider("AimbotFov", { Text = T("FOV", "ขนาดวง"), Icon = "fov", Min = 20, Max = 800, Default = 150, Suffix = "px" })
    target:AddToggle("AimbotShowFov", { Text = T("Show FOV circle", "แสดงวง FOV"), Icon = "eye" })
    target:AddSlider("AimbotMaxDistance", { Text = T("Max distance", "ระยะสูงสุด"), Icon = "distance", Min = 50, Max = 3000, Default = 1500, Suffix = "m" })
    xDTaraZ.UI.NeedCap("AimbotShowFov", "Drawing")
end

function xDTaraZ.UI.BuildSilent(tab)
    local main = tab:AddRightGroupbox(T("Silent Aim", "ไซเลนต์เอม"), "silentaim")
    main:AddFeature("SilentAim", {
        Text = T("Silent Aim", "ไซเลนต์เอม"),
        Description = T("Shots you fire go to the enemy in the FOV", "นัดที่ยิงพุ่งไปหาศัตรูในวง FOV"),
        Icon = "silentaim",
        Risky = true,
        Keybind = { Default = "None", Mode = "Toggle" },
        Options = function(options)
            options:AddSlider("SilentHitChance", { Text = T("Hit chance", "โอกาสโดน"), Description = T("Lower looks more legit", "ยิ่งต่ำยิ่งดูเนียน"), Icon = "hitchance", Min = 1, Max = 100, Default = 100, Rounding = 0, Suffix = "%" })
            options:AddSlider("SilentHeadChance", { Text = T("Headshot chance", "โอกาสเข้าหัว"), Description = T("The rest go to the body", "ที่เหลือเข้าลำตัว"), Icon = "headshot", Min = 0, Max = 100, Default = 100, Rounding = 0, Suffix = "%" })
        end,
    })
    xDTaraZ.UI.NeedCap("SilentAim", "Hook")

    local target = tab:AddRightGroupbox(T("Silent Targeting", "การเลือกเป้า (ไซเลนต์)"), "target")
    target:AddSegmented("SilentPriority", { Text = T("Priority", "เลือกเป้าตาม"), Icon = "sort", Values = priorities, Default = "Crosshair" })
    target:AddCheckbox("SilentVisible", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Description = T("Off = also through walls", "ปิด = ยิงทะลุกำแพงด้วย"), Icon = "eye", Default = true })
    target:AddSlider("SilentFov", { Text = T("FOV", "ขนาดวง"), Icon = "fov", Min = 20, Max = 1000, Default = 220, Suffix = "px" })
    target:AddToggle("SilentShowFov", { Text = T("Show FOV circle", "แสดงวง FOV"), Icon = "eye" })
    target:AddSlider("SilentMaxDistance", { Text = T("Max distance", "ระยะสูงสุด"), Icon = "distance", Min = 50, Max = 3000, Default = 2000, Suffix = "m" })
    xDTaraZ.UI.NeedCap("SilentShowFov", "Drawing")
end

function xDTaraZ.UI.BuildTrigger(window)
    local tab = window:AddTab(T("Trigger & Rage", "ยิงออโต้ & เรจ"), "triggerbot", T("Shoots for you", "ยิงให้อัตโนมัติ"))

    local trigger = tab:AddLeftGroupbox(T("Triggerbot", "ยิงอัตโนมัติ"), "triggerbot")
    trigger:AddFeature("Triggerbot", {
        Text = T("Triggerbot", "ยิงอัตโนมัติ"),
        Description = T("Fires the moment an enemy is under your crosshair", "ยิงทันทีที่ศัตรูอยู่ใต้เป้า"),
        Icon = "triggerbot",
        Keybind = { Default = "T", Mode = "Toggle" },
        Options = function(options)
            options:AddSlider("TriggerDelay", { Text = T("Reaction delay", "ดีเลย์ก่อนยิง"), Icon = "timer", Min = 0, Max = 400, Default = 0, Rounding = 0, Suffix = "ms" })
            options:AddSlider("TriggerHitChance", { Text = T("Fire chance", "โอกาสยิง"), Icon = "hitchance", Min = 1, Max = 100, Default = 100, Rounding = 0, Suffix = "%" })
        end,
    })

    local rage = tab:AddRightGroupbox(T("Ragebot", "เรจบอท"), "ragebot")
    rage:AddFeature("Ragebot", {
        Text = T("Ragebot", "เรจบอท"),
        Description = T("Snaps to and kills any enemy it can reach on its own", "หันไปยิงศัตรูที่ยิงถึงเองทันที"),
        Icon = "ragebot",
        Risky = true,
        Badge = T("Risky", "เสี่ยง"),
        Keybind = { Default = "None", Mode = "Toggle" },
        Options = function(options)
            options:AddCheckbox("RageVisible", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Description = T("Off = also through walls", "ปิด = ยิงทะลุกำแพงด้วย"), Icon = "eye", Default = true })
            options:AddSlider("RageMaxDistance", { Text = T("Max distance", "ระยะสูงสุด"), Icon = "distance", Min = 50, Max = 3000, Default = 2000, Suffix = "m" })
        end,
    })
    xDTaraZ.UI.NeedCap("Ragebot", "Hook")
end

function xDTaraZ.UI.BuildGuns(window)
    local tab = window:AddTab(T("Gun Mods", "ม็อดปืน"), "gun", T("Recoil, spread and fire rate", "แรงถีบ การกระจาย และอัตรายิง"))

    local mods = tab:AddLeftGroupbox(T("Gun Mods", "ม็อดปืน"), "gun")
    mods:AddToggle("NoRecoil", { Text = T("No Recoil", "ไม่มีแรงถีบ"), Description = T("Your view and bullets stay still while spraying", "จอและกระสุนนิ่งตอนกดยิงค้าง"), Icon = "recoil" })
    mods:AddSlider("RecoilKeep", { Text = T("Recoil left", "แรงถีบที่เหลือ"), Description = T("0 = none, 100 = normal", "0 = ไม่มีเลย, 100 = ปกติ"), Icon = "sliders-horizontal", Min = 0, Max = 100, Default = 0, Rounding = 0, Suffix = "%", DependsOn = { "NoRecoil", true } })
    mods:AddToggle("NoSpread", { Text = T("No Spread", "ไม่มีการกระจาย"), Description = T("Every bullet lands on the crosshair", "ทุกนัดลงกลางเป้า"), Icon = "spread" })
    mods:AddToggle("FullAuto", { Text = T("Full Auto", "ยิงรัวทุกปืน"), Description = T("Hold to spray with any gun", "กดค้างยิงรัวได้ทุกปืน"), Icon = "fullauto" })
    xDTaraZ.UI.NeedCap("NoSpread", "Hook")

    local rate = tab:AddRightGroupbox(T("Fire Rate", "อัตรายิง"), "rapidfire")
    rate:AddToggle("RapidFire", { Text = T("Rapid Fire", "ยิงเร็ว"), Description = T("Shoots faster than normal", "ยิงเร็วกว่าปกติ"), Icon = "rapidfire", Risky = true })
    rate:AddSlider("FireRateMult", { Text = T("Fire speed", "ความเร็วยิง"), Icon = "lightning", Min = 1, Max = 4, Default = 1.5, Rounding = 1, Suffix = "x", DependsOn = { "RapidFire", true } })
    rate:AddToggle("WeaponSpeed", { Text = T("Move Speed", "เดินเร็ว"), Description = T("Run faster with any weapon", "วิ่งเร็วขึ้นทุกอาวุธ"), Icon = "speed", Risky = true })
    rate:AddSlider("WeaponSpeedMult", { Text = T("Move speed", "ความเร็วเดิน"), Icon = "speed", Min = 1, Max = 2, Default = 1.3, Rounding = 1, Suffix = "x", DependsOn = { "WeaponSpeed", true } })
end

function xDTaraZ.UI.BuildCombat(window)
    window:AddTabSection(T("Combat", "การต่อสู้"))
    local aim = window:AddTab(T("Aim", "เล็ง"), "aimbot", T("Aimbot and silent aim", "เล็งอัตโนมัติและไซเลนต์เอม"))
    xDTaraZ.UI.BuildAimbot(aim)
    xDTaraZ.UI.BuildSilent(aim)
    xDTaraZ.UI.BuildTrigger(window)
    xDTaraZ.UI.BuildGuns(window)
end

function xDTaraZ.UI.BuildWorld(window)
    local tab = window:AddTab(T("World", "โลก"), "fullbright", T("Lighting, flash and smoke", "แสง แฟลช และควัน"))

    local world = tab:AddLeftGroupbox(T("World", "โลก"), "sun")
    world:AddToggle("Fullbright", { Text = T("Fullbright", "สว่างทั้งแมพ"), Icon = "fullbright" })
    world:AddToggle("NoFlash", { Text = T("No Flash", "กันแฟลช"), Description = T("Flashbangs do not blind you", "แฟลชไม่ทำให้ตาบอด"), Icon = "eyeoff" })
    world:AddToggle("NoSmoke", { Text = T("No Smoke", "ไม่มีควัน"), Description = T("See through smoke grenades", "มองทะลุควัน"), Icon = "fog" })

    local cam = tab:AddRightGroupbox(T("Camera", "กล้อง"), "camera")
    cam:AddToggle("CameraFov", { Text = T("Custom FOV", "ปรับมุมมอง"), Icon = "camera" })
    cam:AddSlider("CameraFovValue", { Text = T("FOV", "มุมมอง"), Icon = "fov", Min = 70, Max = 120, Default = 100, Rounding = 0, DependsOn = { "CameraFov", true } })
    xDTaraZ.UI.NeedCap("CameraFov", "Hook")
end

local skinTitles = {
    Pistol = { "Pistols", "ปืนพก", "gun" },
    SMG = { "SMGs", "ปืนกลมือ", "rapidfire" },
    Rifle = { "Rifles", "ปืนไรเฟิล", "fullauto" },
    Sniper = { "Snipers", "สไนเปอร์", "crosshair" },
    Heavy = { "Heavy", "ปืนหนัก", "pow" },
    Shotgun = { "Shotguns", "ลูกซอง", "spread" },
    ["Machine Gun"] = { "Machine Guns", "ปืนกล", "ammo" },
    Knives = { "Knives", "มีด", "knife" },
    Gloves = { "Gloves", "ถุงมือ", "shield" },
    Grenades = { "Grenades", "ระเบิด", "bomb" },
    Gear = { "Gear", "อุปกรณ์", "box" },
}

function xDTaraZ.UI.SkinGroup(tab, category, side)
    local title = skinTitles[category] or { category, category, "palette" }
    local group = side == "Left" and tab:AddLeftGroupbox(T(title[1], title[2]), title[3]) or tab:AddRightGroupbox(T(title[1], title[2]), title[3])
    for _, weapon in ipairs(xDTaraZ.Skins.Items(category)) do
        if weapon == "-" then continue end
        local values = { "Default" }
        for _, skin in ipairs(xDTaraZ.Skins.List(weapon)) do values[#values + 1] = skin end
        group:AddDropdown("Skin_" .. weapon, { Text = weapon, Icon = "palette", Values = values, Default = xDTaraZ.Skins.Map[weapon] or "Default", Searchable = true, Callback = function(skin)
            xDTaraZ.Skins.Set(weapon, skin)
        end })
    end
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
    local tab = window:AddTab(T("Skins", "สกิน"), "palette", T("Any skin, only on your screen", "ใส่สกินไหนก็ได้ เห็นแค่บนจอคุณ"))

    local main = tab:AddLeftGroupbox(T("Skin Changer", "เปลี่ยนสกิน"), "palette")
    main:AddToggle("SkinChanger", { Text = T("Skin Changer", "เปลี่ยนสกิน"), Description = T("Pick a skin below and it shows right away", "เลือกสกินด้านล่างแล้วขึ้นทันที"), Icon = "palette" })
    main:AddButton({ Text = T("Rarest On Everything", "หายากสุดทุกอัน"), Icon = "crown", Style = "Primary", Callback = xDTaraZ.UI.Detach(function()
        local count = xDTaraZ.Skins.SetAll(function(list) return list[1] end)
        xDTaraZ.UI.SyncSkins()
        Library:Notify("Skins", "Set " .. count .. " items", 3, "Success")
    end) })
    main:AddButton({ Text = T("Random", "สุ่ม"), Icon = "refresh", Style = "Ghost", Callback = xDTaraZ.UI.Detach(function()
        xDTaraZ.Skins.SetAll(function(list) return list[math.random(#list)] end)
        xDTaraZ.UI.SyncSkins()
    end) })
    main:AddButton({ Text = T("Reset All", "ล้างทั้งหมด"), Icon = "trash", Style = "Danger", Callback = xDTaraZ.UI.Detach(function()
        table.clear(xDTaraZ.Skins.Map)
        xDTaraZ.Skins.Save()
        xDTaraZ.UI.SyncSkins()
    end) })

    xDTaraZ.UI.SkinGroup(tab, "Knives", "Right")
    xDTaraZ.UI.SkinGroup(tab, "Gloves", "Left")
    xDTaraZ.UI.SkinGroup(tab, "Grenades", "Right")
    xDTaraZ.UI.SkinGroup(tab, "Gear", "Left")

    local guns = window:AddTab(T("Gun Skins", "สกินปืน"), "gun", T("Skins for every gun", "สกินปืนทุกกระบอก"))
    local side = "Left"
    for _, category in ipairs(xDTaraZ.Skins.Categories()) do
        if table.find({ "Knives", "Gloves", "Grenades", "Gear" }, category) then continue end
        xDTaraZ.UI.SkinGroup(guns, category, side)
        side = side == "Left" and "Right" or "Left"
    end
end

function xDTaraZ.UI.BuildVisuals(window)
    window:AddTabSection(T("Visuals", "การมองเห็น"))
    window:AddVisualsTab({ Icon = "esp", Provider = xDTaraZ.Esp.Targets, Focus = xDTaraZ.Esp.Focus, Categories = xDTaraZ.Esp.Categories(), Preview = true })
    xDTaraZ.UI.BuildWorld(window)
    xDTaraZ.UI.BuildSkins(window)
end

function xDTaraZ.UI.BuildMisc(window)
    window:AddTabSection(T("Misc", "อื่นๆ"))
    local tab = window:AddTab(T("Misc", "อื่นๆ"), "misc", T("Buying, codes and movement", "ซื้อของ โค้ด และการเคลื่อนที่"))

    local buy = tab:AddLeftGroupbox(T("Auto Buy", "ซื้ออัตโนมัติ"), "buy")
    buy:AddFeature("AutoRebuy", {
        Text = T("Auto Rebuy", "ซื้อซ้ำอัตโนมัติ"),
        Description = T("Buys your last loadout every round", "ซื้อชุดล่าสุดของคุณให้ทุกรอบ"),
        Icon = "buy",
        Now = { Text = T("Rebuy Now", "ซื้อซ้ำตอนนี้"), Icon = "cart", Callback = xDTaraZ.UI.Detach(function()
            local sent = xDTaraZ.Economy.Rebuy()
            Library:Notify("Auto Buy", sent > 0 and ("Bought " .. sent .. " items") or "Buy something once first", 3, sent > 0 and "Success" or "Info")
        end) },
    })
    xDTaraZ.UI.NeedCap("AutoRebuy", "Hook")
    buy:AddStatus("StatusLoadout", { Text = T("Saved loadout", "ชุดที่จำไว้"), Icon = "list" })
    buy:AddButton({ Text = T("Clear Loadout", "ล้างชุดที่จำ"), Icon = "trash", Style = "Ghost", Callback = xDTaraZ.UI.Detach(function()
        table.clear(xDTaraZ.State.Bought)
    end) })

    local codes = tab:AddLeftGroupbox(T("Codes", "โค้ด"), "code")
    codes:AddButton({ Text = T("Redeem All Codes", "แลกโค้ดทั้งหมด"), Icon = "code", Style = "Primary", Callback = xDTaraZ.UI.Detach(function()
        local sent = xDTaraZ.Economy.RedeemAll()
        Library:Notify("Codes", "Sent " .. sent .. " codes (level 5+ needed)", 4, "Coin")
    end) })

    local move = tab:AddRightGroupbox(T("Movement", "การเคลื่อนที่"), "jump")
    move:AddToggle("InfiniteJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด"), Icon = "infjump", Risky = true })
    move:AddToggle("BunnyHop", { Text = T("Bunny Hop", "บันนี่ฮอป"), Description = T("Hold Space to keep hopping and carry your speed", "กด Space ค้างเพื่อกระโดดต่อเนื่องและรักษาความเร็ว"), Icon = "jump", Risky = true })
    move:AddCheckbox("BunnyCrouch", { Text = T("Crouch jump", "ย่อตอนลอย"), Description = T("Crouches in the air like a CS crouch jump", "ย่อตัวกลางอากาศแบบ crouch jump ใน CS"), Icon = "down", Default = true, DependsOn = { "BunnyHop", true } })

    local server = tab:AddRightGroupbox(T("Server", "เซิร์ฟเวอร์"), "server")
    server:AddToggle("AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK"), Icon = "antiafk" })
    server:AddButton({ Text = T("Rejoin", "เข้าใหม่"), Icon = "rejoin", Callback = xDTaraZ.UI.Detach(xDTaraZ.World.Rejoin) })
    server:AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Icon = "hop", Callback = xDTaraZ.UI.Detach(xDTaraZ.World.ServerHop) })
end

---@return string  map | round state | money
---@return string  status kind
function xDTaraZ.UI.MatchText()
    local map = tostring(Workspace:GetAttribute("Map") or "-")
    local phase = tostring(Workspace:GetAttribute("GameState") or "-")
    return ("%s | %s | $%s"):format(map, phase, tostring(LocalPlayer:GetAttribute("Money") or 0)), "Running"
end

function xDTaraZ.UI.Live()
    local interval = xDTaraZ.Config.StatusInterval
    local state = xDTaraZ.State
    local status = Library.Lib.Status

    status("StatusMatch", xDTaraZ.UI.MatchText, interval)
    status("StatusCombat", function()
        local target = state.RageTarget or state.AimTarget or state.SilentTarget
        if not target then return "none", "Idle" end
        return target.Name, "Running"
    end, interval)
    status("StatusSpectators", function() return xDTaraZ.Spectators.Text(), "Idle" end, interval)
    status("StatusEsp", function()
        local visuals = Library.Visuals
        if not (visuals and visuals:Get("Enabled")) then return "Off", "Idle" end
        return xDTaraZ.Esp.Count .. " players", "Running"
    end, interval)
    status("StatusLoadout", function() return xDTaraZ.Economy.BoughtText(), "Idle" end, interval)

    status("StatKills", function() return LocalPlayer:GetAttribute("Kills") or 0 end, interval)
    status("StatShots", function() return state.Shots end, interval)
    status("StatAimed", function() return state.Redirected end, interval)
end

function xDTaraZ.UI.Build()
    local window = Library.Window
    for _, build in ipairs({ xDTaraZ.UI.BuildMain, xDTaraZ.UI.BuildCombat, xDTaraZ.UI.BuildVisuals, xDTaraZ.UI.BuildMisc }) do
        local ok, err = pcall(build, window)
        if not ok then warn("[BloxStrike] build:", err) end
    end
    window:AddSettingsTab()
    for key in pairs(xDTaraZ.Options) do
        local widget = Library.Options[key]
        if widget then xDTaraZ.UI.Bind(widget, key) end
    end
    xDTaraZ.UI.Live()
end

function xDTaraZ.Boot()
    xDTaraZ.Skins.Load()
    xDTaraZ.Combat.Start()
    xDTaraZ.Guns.HookRecoil()
    task.defer(xDTaraZ.Guns.HookSpread)
    xDTaraZ.Economy.HookBuys()
    xDTaraZ:Connect(LocalPlayer.Idled, xDTaraZ.World.OnIdled)
    xDTaraZ:Connect(UserInputService.JumpRequest, xDTaraZ.World.OnJump)
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.World.Hop)
    xDTaraZ:Connect(UserInputService.InputBegan, function(input) xDTaraZ.World.OnSpace(input, true) end)
    xDTaraZ:Connect(UserInputService.InputEnded, function(input) xDTaraZ.World.OnSpace(input, false) end)
    xDTaraZ:Connect(Workspace.DescendantAdded, xDTaraZ.World.OnDescendant)

    xDTaraZ.Scheduler.Every("Guns", 0.25, xDTaraZ.Guns.Step)
    xDTaraZ.Scheduler.Every("World", 0.2, xDTaraZ.World.Step)
    xDTaraZ.Scheduler.Every("Rebuy", 0.5, xDTaraZ.Economy.Step)
    xDTaraZ.Scheduler.Every("Skins", 0.15, xDTaraZ.Skins.Step)
    xDTaraZ.Scheduler.Boot()
end

function xDTaraZ:Unload()
    self.State.Alive = false
    xDTaraZ.Combat.Unload()
    for _, key in ipairs({ "NoRecoil", "NoSpread", "FullAuto", "RapidFire", "WeaponSpeed", "Fullbright", "CameraFov", "BunnyHop", "SkinChanger" }) do
        xDTaraZ.Options[key] = false
    end
    pcall(xDTaraZ.Guns.Restore)
    pcall(xDTaraZ.World.Step)
    pcall(xDTaraZ.World.SetCrouch, false)
    pcall(xDTaraZ.Skins.Step)
    for _, conn in ipairs(self.State.Connections) do pcall(function() conn:Disconnect() end) end
    table.clear(self.State.Connections)
    if xDTaraZ.Caps.Restore then
        for _, hook in pairs(self.State.Hooks) do pcall(restorefunction, hook.Fn) end
    end
    table.clear(self.State.Hooks)
end

local function BuildInterface()
    Library = loadstring(xDTaraZ.Util.HttpGet(xDTaraZ.Config.UiSource))()
    MarioBanner.Step("UI library")
    xDTaraZ.Library = Library
    T = function(en, th) return Library:T(en, th) end
    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "BloxStrike by xDTaraZ",
        MenuKey = Enum.KeyCode.RightControl,
        ConfigFolder = xDTaraZ.Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        Intro = true,
        OnUnlocked = function()
            xDTaraZ.UI.Build()
            task.defer(xDTaraZ.Boot)
            task.defer(function() Library:LoadAutoloadConfig() end)
        end,
    })
    Library:OnUnload(function() xDTaraZ:Unload() end)
end

environment.BloxStrikeUnload = function()
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