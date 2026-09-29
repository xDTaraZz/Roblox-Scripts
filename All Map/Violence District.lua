if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local environment = getgenv and getgenv() or _G
if type(environment.ViolenceDistrictUnload) == "function" then
    pcall(environment.ViolenceDistrictUnload)
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local vector3New, cframeNew, cframeLookAt = Vector3.new, CFrame.new, CFrame.lookAt
local vectorZero = Vector3.zero
local osClock, mathHuge = os.clock, math.huge

if game.GameId ~= 6739698191 then
    LocalPlayer:Kick("Mario Hub: this script is for Violence District only")
    return
end

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    Discord = "https://discord.gg/FHVfmeSceA",
    SaveFolder = "Violence District",
    Intro = true,
    LoadTimeout = 10,
    StatusInterval = 1,
    RepairTick = 0.25,
    GenDone = 100,
    SpareGens = 1,
    AttackReach = 2,
    LungeDelay = 0.21,
    AuraCooldown = 1.1,
    CarryDelay = 0.8,
    Settle = 0.55,
    FinishFirst = 85,
    ArriveRadius = 4,
    DriftLimit = 12,
    DangerKeep = 2,
    DangerPick = 2.5,
    DistanceWeight = 0.05,
    HealMax = 15,
    HealMinUseful = 3,
    HelpBan = 8,
    UnhookReach = 10,
    GuardTick = 0.05,
    FarmDodge = 24,
    SwingTail = 0.4,
    LegitReach = 9,
    ServerReach = 4.2,
    ParryRange = 14,
    ParryPanic = 6,
    ParryClosing = 12,
    ParryRetry = 1,
    ParryFast = 0.25,
    ParryScan = 5,
    LegitAngle = 0.5,
    HookRest = 1,
    UnhookHold = 2.5,
    StallTime = 8,
    StallBan = 30,
    HookTween = 0.2,
    GenBreakTime = 2,
    KickRegress = 25,
    SelfUnhookRetry = 1,
    SelfUnhookMax = 12,
    DodgeCooldown = 1.5,
    RolePending = 8,
    JumpVelocity = 50,
    AlertRadius = 60,
    ShopDelay = 0.6,
    FirstLevelCost = 750,
    EscapeRetry = 6,
    ShopInterval = 10,
    SurvivorSpeed = 21,
    KillerSpeed = 18.7,
    ObjectEspRefresh = 1,
    ModelRescan = 10,
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
}

xDTaraZ.Options = {
    AntiAfk = false,
    RoleMode = "Any",
    Speed = false,
    SpeedValue = 24,
    Noclip = false,
    NoSlow = false,
    NoFall = false,
    FreeTurn = false,
    AntiShake = false,
    AntiBlind = false,
    SmartHitbox = false,
    SlashMode = "Rage",
    InfiniteJump = false,
    Fullbright = false,
    NoFog = false,

    AutoRepair = false,
    PerfectSkillCheck = false,
    InstantEscape = false,
    EscapeDelay = 0,
    AutoHeal = false,
    AutoUnhook = false,
    AutoDodge = false,
    DodgeRadius = 20,
    AutoSelfUnhook = false,
    AutoParry = false,
    NoParryCooldown = false,
    KillerAlert = false,

    AutoBuyPerks = false,
    AutoLevelPerks = false,
    KeepScrews = 0,

    KillAura = false,
    AuraRange = 500,
    AutoHook = false,
    AutoBreakGens = false,
    AntiStun = false,

    EspGenerators = false,
    EspHooks = false,
    EspGates = false,
    EspPallets = false,
    EspWindows = false,
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
Util.GetHui = Resolve(gethui, get_hidden_gui)
Util.GetConnections = Resolve(getconnections, get_signal_cons)
Util.FireTouch = Resolve(firetouchinterest)
Util.HookMeta = Resolve(hookmetamethod)
Util.GetGc = Resolve(getgc, get_gc_objects)
Util.NameCallMethod = Resolve(getnamecallmethod)

---@return string  response body, throws if every transport fails
function Util.HttpGet(url)
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if ok and type(body) == "string" then return body end
    if Util.Request then
        local response = Util.Request({ Url = url, Method = "GET" })
        if type(response) == "table" and type(response.Body) == "string" then
            return response.Body
        end
    end
    error("HttpGet failed: " .. url)
end

function Util.Copy(text)
    if not Util.SetClipboard then return false end
    Util.SetClipboard(text)
    return true
end

function Util.Hui()
    if Util.GetHui then
        local ok, gui = pcall(Util.GetHui)
        if ok and gui then return gui end
    end
    return LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
end

function xDTaraZ:Connect(signal, handler)
    local connection = signal:Connect(handler)
    table.insert(self.State.Connections, connection)
    return connection
end

xDTaraZ.GameLib = {}
local GameLib = xDTaraZ.GameLib

do
    local remotes = ReplicatedStorage:WaitForChild("Remotes", xDTaraZ.Config.LoadTimeout)
    local function Remote(folder, name)
        local parent = remotes and remotes:FindFirstChild(folder)
        return parent and parent:FindFirstChild(name)
    end

    GameLib.Remote = {
        Repair = Remote("Generator", "RepairEvent"),
        GenCheck = Remote("Generator", "SkillCheckEvent"),
        GenResult = Remote("Generator", "SkillCheckResultEvent"),
        Heal = Remote("Healing", "HealEvent"),
        HealCheck = Remote("Healing", "SkillCheckEvent"),
        HealResult = Remote("Healing", "SkillCheckResultEvent"),
        Unhook = Remote("Carry", "UnHookEvent"),
        SelfUnhook = Remote("Carry", "SelfUnHookEvent"),
        Fall = Remote("Mechanics", "Fall"),
        Carry = Remote("Carry", "CarrySurvivorEvent"),
        Hook = Remote("Carry", "HookEvent"),
        HookCommit = Remote("Carry", "HookCommit"),
        BreakGen = Remote("Generator", "BreakGenEvent"),
        BreakGenCommit = Remote("Generator", "BreakGenCommit"),
        Lunge = Remote("Attacks", "Lunge"),
        Stun = remotes and remotes.Pallet:FindFirstChild("Jason") and remotes.Pallet.Jason:FindFirstChild("Stun"),
        StunOver = remotes and remotes.Pallet:FindFirstChild("Jason") and remotes.Pallet.Jason:FindFirstChild("Stunover"),
        Attack = Remote("Attacks", "BasicAttack"),
    }
end

xDTaraZ.Player = { Client = LocalPlayer }

function xDTaraZ.Player:Bind(character)
    self.Character = character
    self.Humanoid = character:WaitForChild("Humanoid", xDTaraZ.Config.LoadTimeout)
    self.Root = character:WaitForChild("HumanoidRootPart", xDTaraZ.Config.LoadTimeout)
end

function xDTaraZ.Player:IsAlive()
    return self.Humanoid ~= nil and self.Humanoid.Health > 0 and self.Root ~= nil and self.Root.Parent ~= nil
end

---@return string?  "Survivors" / "Killer" / "Spectator"
function xDTaraZ.Player.Role(player)
    local team = (player or LocalPlayer).Team
    return team and team.Name or nil
end

---@return boolean  downed, hooked or carried
function xDTaraZ.Player.Disabled(character)
    if not character then return true end
    return character:GetAttribute("Knocked") == true
        or character:GetAttribute("IsHooked") == true
        or character:GetAttribute("IsCarried") == true
end

function xDTaraZ.Player.Killer()
    local team = Teams:FindFirstChild("Killer")
    local killer = team and team:GetPlayers()[1]
    return killer and killer.Character
end

function xDTaraZ.Player.Survivors()
    local team = Teams:FindFirstChild("Survivors")
    local list = {}
    if not team then return list end
    for _, player in ipairs(team:GetPlayers()) do
        local char = player.Character
        if player ~= LocalPlayer and char and char:FindFirstChild("HumanoidRootPart") then
            list[#list + 1] = char
        end
    end
    return list
end

function xDTaraZ.Player.Teleport(cframe)
    local hrp = xDTaraZ.Player.Root
    if not hrp then return end
    hrp.CFrame = cframe
    hrp.AssemblyLinearVelocity = vectorZero
end

xDTaraZ.Map = {}

function xDTaraZ.Map.Root()
    return Workspace:FindFirstChild("Map")
end

function xDTaraZ.Map.Tagged(tag)
    local map = xDTaraZ.Map.Root()
    local list = {}
    if not map then return list end
    for _, part in ipairs(CollectionService:GetTagged(tag)) do
        if part:IsA("BasePart") and part:IsDescendantOf(map) then
            list[#list + 1] = part
        end
    end
    return list
end

xDTaraZ.Map.Cache = { Map = nil, Models = {}, Scanned = {} }

---@return Model[]  every model with this name in the current map, cached per round
function xDTaraZ.Map.Models(name)
    local map = xDTaraZ.Map.Root()
    local cache = xDTaraZ.Map.Cache
    if not map then return {} end
    if cache.Map ~= map then
        cache.Map, cache.Models, cache.Scanned = map, {}, {}
    end
    local list = cache.Models[name]
    local fresh = osClock() - (cache.Scanned[name] or 0) < xDTaraZ.Config.ModelRescan
    if list and fresh and (not list[1] or list[1]:IsDescendantOf(map)) then return list end
    cache.Scanned[name] = osClock()
    list = {}
    for _, inst in ipairs(map:GetDescendants()) do
        if inst.Name == name and inst:IsA("Model") then list[#list + 1] = inst end
    end
    cache.Models[name] = list
    return list
end

---@return Model[]  every generator on the map, finished ones included
function xDTaraZ.Map.Generators()
    return xDTaraZ.Map.Models("Generator")
end

---@return BasePart[]  GeneratorPoint parts of one generator, cached per round
function xDTaraZ.Map.PointsOf(gen)
    local cache = xDTaraZ.Map.Cache
    cache.Points = cache.Points or setmetatable({}, { __mode = "k" })
    local list = cache.Points[gen]
    if list and list[1] and list[1].Parent then return list end
    list = {}
    for _, point in ipairs(xDTaraZ.Map.Tagged("GeneratorPoint")) do
        if point:IsDescendantOf(gen) then list[#list + 1] = point end
    end
    cache.Points[gen] = list
    return list
end

function xDTaraZ.Map.GenProgress(model)
    return tonumber(model:GetAttribute("RepairProgress")) or 0
end

---@return number  gens still needed before the exits power (one gen is spare)
function xDTaraZ.Map.GensLeft()
    local gens = xDTaraZ.Map.Generators()
    local cache = xDTaraZ.Map.Cache
    local map = xDTaraZ.Map.Root()
    if cache.TotalMap ~= map then cache.TotalMap, cache.Total = map, 0 end
    cache.Total = math.max(cache.Total, #gens)
    local done = 0
    for _, gen in ipairs(gens) do
        if xDTaraZ.Map.GenProgress(gen) >= xDTaraZ.Config.GenDone then done += 1 end
    end
    return math.max(cache.Total - xDTaraZ.Config.SpareGens - done, 0)
end

---@return BasePart?, number  closest part to pos
function xDTaraZ.Map.Nearest(parts, pos, filter)
    local best, bestDist = nil, mathHuge
    for _, part in ipairs(parts) do
        if filter and not filter(part) then continue end
        local dist = (part.Position - pos).Magnitude
        if dist < bestDist then best, bestDist = part, dist end
    end
    return best, bestDist
end

xDTaraZ.Scheduler = { Jobs = {}, Booted = false }

function xDTaraZ.Scheduler.Every(name, interval, fn)
    xDTaraZ.Scheduler.Jobs[name] = { Interval = interval, Fn = fn, Last = 0, Running = false }
end

function xDTaraZ.Scheduler.Step()
    local now = osClock()
    for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
        if job.Running or now - job.Last < job.Interval then continue end
        job.Last = now
        job.Running = true
        task.spawn(function()
            local ok, err = pcall(job.Fn)
            job.Running = false
            if not ok then warn("[ViolenceDistrict] job " .. name .. ": " .. tostring(err)) end
        end)
    end
end

function xDTaraZ.Scheduler.Boot()
    if xDTaraZ.Scheduler.Booted then return end
    xDTaraZ.Scheduler.Booted = true
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Scheduler.Step)
end

xDTaraZ.Player.AntiAfk = { Connection = nil }

function xDTaraZ.Player.AntiAfk.OnIdled()
    if not xDTaraZ.Options.AntiAfk then return end
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.zero)
end

function xDTaraZ.Player.AntiAfk.Arm()
    if xDTaraZ.Player.AntiAfk.Connection then return end
    xDTaraZ.Player.AntiAfk.Connection = xDTaraZ:Connect(LocalPlayer.Idled, xDTaraZ.Player.AntiAfk.OnIdled)
end

xDTaraZ.Role = { Pending = 0 }

function xDTaraZ.Role.Step()
    local mode = xDTaraZ.Options.RoleMode
    if mode ~= "Survivor only" and mode ~= "Prefer killer" then return end
    if LocalPlayer:GetAttribute("AllowKiller") == (mode == "Prefer killer") or osClock() < xDTaraZ.Role.Pending then return end
    local settings = LocalPlayer.PlayerGui:FindFirstChild("Settings", true)
    local button = settings and settings:FindFirstChild("chance", true)
    button = button and button:FindFirstChildWhichIsA("GuiButton")
    if not (button and Util.GetConnections) then return end
    xDTaraZ.Role.Pending = osClock() + xDTaraZ.Config.RolePending
    for _, conn in ipairs(Util.GetConnections(button.MouseButton1Click)) do
        conn:Fire()
    end
end

xDTaraZ.Movement = { Collide = {}, JumpConn = nil, Walk = nil }

function xDTaraZ.Movement.Frame()
    local hum, char = xDTaraZ.Player.Humanoid, xDTaraZ.Player.Character
    if not hum or not char then return end

    if xDTaraZ.Options.Speed then
        if not xDTaraZ.Movement.Walk then xDTaraZ.Movement.Walk = hum.WalkSpeed end
        hum.WalkSpeed = xDTaraZ.Options.SpeedValue
    elseif xDTaraZ.Movement.Walk then
        hum.WalkSpeed = xDTaraZ.Movement.Walk
        xDTaraZ.Movement.Walk = nil
    end
    if xDTaraZ.Options.NoSlow and not xDTaraZ.Options.Speed and hum.WalkSpeed > 0 then
        local base = xDTaraZ.Movement.BaseSpeed(char)
        if hum.WalkSpeed < base then hum.WalkSpeed = base end
    end

    if xDTaraZ.Options.FreeTurn and not hum.AutoRotate and not char:GetAttribute("overridelookscript") and not char:GetAttribute("Immobile") then
        local root = xDTaraZ.Player.Root
        local look = Workspace.CurrentCamera.CFrame.LookVector
        local flat = vector3New(look.X, 0, look.Z)
        if root and flat.Magnitude > 0 then root.CFrame = cframeLookAt(root.Position, root.Position + flat) end
    end

    if xDTaraZ.Options.Noclip then
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide then
                xDTaraZ.Movement.Collide[part] = true
                part.CanCollide = false
            end
        end
    elseif next(xDTaraZ.Movement.Collide) then
        xDTaraZ.Movement.RestoreCollide()
    end
end

---@return number  normal run speed for the current role
function xDTaraZ.Movement.BaseSpeed(char)
    if xDTaraZ.Player.Role() == "Killer" then
        return tonumber(char:GetAttribute("Speed")) or xDTaraZ.Config.KillerSpeed
    end
    return xDTaraZ.Config.SurvivorSpeed
end

function xDTaraZ.Movement.RestoreCollide()
    for part in pairs(xDTaraZ.Movement.Collide) do
        if part.Parent then part.CanCollide = true end
    end
    table.clear(xDTaraZ.Movement.Collide)
end

function xDTaraZ.Movement.OnJump()
    if not xDTaraZ.Options.InfiniteJump then return end
    local hrp = xDTaraZ.Player.Root
    if not hrp then return end
    local vel = hrp.AssemblyLinearVelocity
    hrp.AssemblyLinearVelocity = vector3New(vel.X, xDTaraZ.Config.JumpVelocity, vel.Z)
end

function xDTaraZ.Movement.Start()
    xDTaraZ:Connect(RunService.Stepped, xDTaraZ.Movement.Frame)
    xDTaraZ:Connect(UserInputService.JumpRequest, xDTaraZ.Movement.OnJump)
end

function xDTaraZ.Movement.Release()
    xDTaraZ.Movement.RestoreCollide()
    local hum = xDTaraZ.Player.Humanoid
    if hum and hum.Parent and xDTaraZ.Movement.Walk then hum.WalkSpeed = xDTaraZ.Movement.Walk end
    xDTaraZ.Movement.Walk = nil
end

xDTaraZ.World = { Saved = nil }

function xDTaraZ.World.Save()
    if xDTaraZ.World.Saved then return end
    xDTaraZ.World.Saved = {
        Brightness = Lighting.Brightness,
        Ambient = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ClockTime = Lighting.ClockTime,
        GlobalShadows = Lighting.GlobalShadows,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart,
        Atmosphere = {},
    }
    for _, atmo in ipairs(Lighting:GetChildren()) do
        if atmo:IsA("Atmosphere") then xDTaraZ.World.Saved.Atmosphere[atmo] = atmo.Density end
    end
end

function xDTaraZ.World.Step()
    local bright, fog = xDTaraZ.Options.Fullbright, xDTaraZ.Options.NoFog
    if not bright and not fog then
        xDTaraZ.World.Restore()
        return
    end
    xDTaraZ.World.Save()
    local saved = xDTaraZ.World.Saved

    if bright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        Lighting.Brightness, Lighting.ClockTime = saved.Brightness, saved.ClockTime
        Lighting.GlobalShadows, Lighting.Ambient, Lighting.OutdoorAmbient = saved.GlobalShadows, saved.Ambient, saved.OutdoorAmbient
    end

    Lighting.FogEnd = fog and 1e6 or saved.FogEnd
    Lighting.FogStart = fog and 1e6 or saved.FogStart
    for atmo, density in pairs(saved.Atmosphere) do
        if atmo.Parent then atmo.Density = fog and 0 or density end
    end
end

function xDTaraZ.World.Restore()
    local saved = xDTaraZ.World.Saved
    if not saved then return end
    xDTaraZ.World.Saved = nil
    Lighting.Brightness, Lighting.ClockTime = saved.Brightness, saved.ClockTime
    Lighting.GlobalShadows, Lighting.Ambient, Lighting.OutdoorAmbient = saved.GlobalShadows, saved.Ambient, saved.OutdoorAmbient
    Lighting.FogEnd, Lighting.FogStart = saved.FogEnd, saved.FogStart
    for atmo, density in pairs(saved.Atmosphere) do
        if atmo.Parent then atmo.Density = density end
    end
end

xDTaraZ.Block = { Muted = {}, Own = {}, Hooked = false }

---@return RBXScriptSignal?  game signal a rule silences
local function RemoteSignal(folder, ...)
    local node = ReplicatedStorage:FindFirstChild("Remotes")
    for _, name in ipairs({ folder, ... }) do
        node = node and node:FindFirstChild(name)
    end
    if not node then return nil end
    return node:IsA("BindableEvent") and node.Event or node.OnClientEvent
end

xDTaraZ.Block.Rules = {
    { Option = "PerfectSkillCheck", Signals = { RemoteSignal("Generator", "SkillCheckEvent"), RemoteSignal("Healing", "SkillCheckEvent") } },
    { Option = "AntiStun", Signals = { RemoteSignal("Pallet", "Jason", "Stun") } },
    { Option = "AntiBlind", Signals = { RemoteSignal("Items", "Flashlight", "GotBlinded") } },
    { Option = "AntiShake", Signals = { RemoteSignal("Game", "shake") } },
}

function xDTaraZ.Block.Keep(fn)
    xDTaraZ.Block.Own[fn] = true
end

function xDTaraZ.Block.Mute(rule)
    local muted = xDTaraZ.Block.Muted[rule] or {}
    xDTaraZ.Block.Muted[rule] = muted
    for _, signal in ipairs(rule.Signals) do
        for _, conn in ipairs(Util.GetConnections(signal)) do
            if conn.Enabled and not xDTaraZ.Block.Own[conn.Function] then
                pcall(function() conn:Disable() end)
                muted[#muted + 1] = conn
            end
        end
    end
end

function xDTaraZ.Block.Unmute(rule)
    local muted = xDTaraZ.Block.Muted[rule]
    if not muted then return end
    for _, conn in ipairs(muted) do pcall(function() conn:Enable() end) end
    xDTaraZ.Block.Muted[rule] = nil
end

function xDTaraZ.Block.Step()
    if not Util.GetConnections then return end
    for _, rule in ipairs(xDTaraZ.Block.Rules) do
        if xDTaraZ.Options[rule.Option] then xDTaraZ.Block.Mute(rule) else xDTaraZ.Block.Unmute(rule) end
    end
    if xDTaraZ.Options.NoFall and not xDTaraZ.Block.Hooked then xDTaraZ.Block.HookFall() end
end

function xDTaraZ.Block.Release()
    for _, rule in ipairs(xDTaraZ.Block.Rules) do xDTaraZ.Block.Unmute(rule) end
end

function xDTaraZ.Block.HookFall()
    local fall = GameLib.Remote.Fall
    if not (fall and Util.HookMeta and Util.NameCallMethod) then return end
    xDTaraZ.Block.Hooked = true
    local original
    original = Util.HookMeta(game, "__namecall", function(self, ...)
        if self == fall and xDTaraZ.Options.NoFall and xDTaraZ.State.Alive and Util.NameCallMethod() == "FireServer" then return nil end
        return original(self, ...)
    end)
end

xDTaraZ.Survivor = {
    Job = nil,
    Gen = nil,
    Banned = {},
    Map = nil,
    Status = "Off",
    RoundStart = 0,
    Escapes = 0,
    LastEscape = 0,
}

xDTaraZ.Survivor.Rank = { Unhook = 3, Heal = 2, Repair = 1 }

---@param kind string    Repair / Heal / Unhook
---@param target Instance  point or teammate root the remote takes
function xDTaraZ.Survivor.NewJob(kind, target, remote)
    return { Kind = kind, Target = target, Remote = remote, Since = osClock(), Fired = false, Progress = 0, Checked = osClock() }
end

function xDTaraZ.Survivor.Finish()
    local job = xDTaraZ.Survivor.Job
    xDTaraZ.Survivor.Job = nil
    if not (job and job.Fired) or job.Kind == "Unhook" or not job.Target.Parent then return end
    pcall(function() job.Remote:FireServer(job.Target, false) end)
end

---@param locked boolean  action already started, only re-warp if we drifted far
function xDTaraZ.Survivor.Hold(target, locked)
    local hrp = xDTaraZ.Player.Root
    if not hrp then return end
    local teammate = target.Name == "HumanoidRootPart"
    local spot = teammate and (target.CFrame * cframeNew(0, 0, 2.5)).Position or target.Position
    local flat = vector3New(hrp.Position.X - spot.X, 0, hrp.Position.Z - spot.Z).Magnitude
    if flat <= (locked and xDTaraZ.Config.DriftLimit or xDTaraZ.Config.ArriveRadius) then return end
    local look = teammate and target.Position or spot + target.CFrame.LookVector
    xDTaraZ.Player.Teleport(cframeLookAt(spot, look))
end

---@param scale number?  radius multiplier, larger when picking new work
---@return boolean        too close to the killer while Auto Dodge is on
function xDTaraZ.Survivor.Danger(pos, scale)
    local opts = xDTaraZ.Options
    if not opts.AutoDodge then return false end
    local killer = xDTaraZ.Player.Killer()
    local root = killer and killer:FindFirstChild("HumanoidRootPart")
    return root ~= nil and (root.Position - pos).Magnitude <= opts.DodgeRadius * (scale or xDTaraZ.Config.DangerKeep)
end

function xDTaraZ.Survivor.GenUsable(gen)
    if not gen or not gen.Parent then return false end
    if xDTaraZ.Map.GenProgress(gen) >= xDTaraZ.Config.GenDone then return false end
    return osClock() >= (xDTaraZ.Survivor.Banned[gen] or 0)
end

---@return BasePart?  a free, safe point on this generator
function xDTaraZ.Survivor.PointOn(gen)
    local job = xDTaraZ.Survivor.Job
    for _, point in ipairs(xDTaraZ.Map.PointsOf(gen)) do
        local mine = job and job.Target == point
        if not mine and CollectionService:HasTag(point, "doing action") then continue end
        if xDTaraZ.Survivor.Danger(point.Position, xDTaraZ.Config.DangerPick) then continue end
        return point
    end
    return nil
end

---@param peek boolean?  don't change the committed generator
---@return BasePart?      keeps the committed generator until it is done or unsafe
function xDTaraZ.Survivor.PickGenPoint(pos, peek)
    local gen = xDTaraZ.Survivor.Gen
    local point = xDTaraZ.Survivor.GenUsable(gen) and xDTaraZ.Survivor.PointOn(gen)
    if point then return point end

    local best, bestScore = nil, mathHuge
    for _, candidate in ipairs(xDTaraZ.Map.Generators()) do
        if not xDTaraZ.Survivor.GenUsable(candidate) then continue end
        local spot = xDTaraZ.Survivor.PointOn(candidate)
        if not spot then continue end
        local score = (xDTaraZ.Config.GenDone - xDTaraZ.Map.GenProgress(candidate)) + (spot.Position - pos).Magnitude * xDTaraZ.Config.DistanceWeight
        if score < bestScore then best, bestScore = spot, score end
    end
    if not peek then xDTaraZ.Survivor.Gen = best and best:FindFirstAncestor("Generator") end
    return best
end

---@param downedOnly boolean  only teammates who are on the floor
---@return BasePart?            closest teammate worth healing, downed first
function xDTaraZ.Survivor.HealTarget(downedOnly)
    local me = xDTaraZ.Player.Root
    local best, bestScore = nil, mathHuge
    for _, char in ipairs(xDTaraZ.Player.Survivors()) do
        local hrp = char.HumanoidRootPart
        if hrp:GetAttribute("CanGetHealed") ~= true or char:GetAttribute("IsHooked") or char:GetAttribute("IsCarried") then continue end
        if char:GetAttribute("IsBeingHealed") or osClock() < (xDTaraZ.Survivor.Banned[char] or 0) then continue end
        local downed = char:GetAttribute("Knocked") == true
        if downedOnly and not downed then continue end
        if xDTaraZ.Survivor.Danger(hrp.Position, xDTaraZ.Config.DangerPick) then continue end
        local score = (downed and 0 or 1000) + (me and (hrp.Position - me.Position).Magnitude or 0)
        if score < bestScore then best, bestScore = hrp, score end
    end
    return best
end

function xDTaraZ.Survivor.UnhookTarget()
    local points = xDTaraZ.Map.Tagged("UnhookPoint")
    for _, char in ipairs(xDTaraZ.Player.Survivors()) do
        if char:GetAttribute("IsHooked") ~= true or osClock() < (xDTaraZ.Survivor.Banned[char] or 0) then continue end
        local point, dist = xDTaraZ.Map.Nearest(points, char.HumanoidRootPart.Position)
        if point and dist < xDTaraZ.Config.UnhookReach and not xDTaraZ.Survivor.Danger(point.Position, xDTaraZ.Config.DangerPick) then
            return point, char
        end
    end
    return nil
end

---@return boolean  current job still has something to do
function xDTaraZ.Survivor.JobAlive(job)
    local target = job.Target
    if not target.Parent or xDTaraZ.Survivor.Danger(target.Position) then return false end
    local age = osClock() - job.Since
    if job.Kind == "Heal" then
        local ok = age <= xDTaraZ.Config.HealMax and target:GetAttribute("CanGetHealed") == true
        if not ok and age < xDTaraZ.Config.HealMinUseful then
            xDTaraZ.Survivor.Banned[target.Parent] = osClock() + xDTaraZ.Config.HelpBan
        end
        return ok
    end
    if job.Kind == "Unhook" then
        if age < xDTaraZ.Config.UnhookHold then return true end
        if job.Char then xDTaraZ.Survivor.Banned[job.Char] = osClock() + xDTaraZ.Config.HelpBan end
        return false
    end
    return xDTaraZ.Survivor.GenUsable(target:FindFirstAncestor("Generator")) and xDTaraZ.Map.GensLeft() > 0
end

---@return table?  best new job, only if it should replace the current one
function xDTaraZ.Survivor.Candidate(pos)
    local opts, remote = xDTaraZ.Options, GameLib.Remote
    local job = xDTaraZ.Survivor.Job
    local rank = job and xDTaraZ.Survivor.Rank[job.Kind] or 0
    local finishing = job and job.Kind == "Repair"
        and xDTaraZ.Map.GenProgress(job.Target:FindFirstAncestor("Generator")) >= xDTaraZ.Config.FinishFirst

    if opts.AutoUnhook and rank < 3 and not finishing then
        local point, char = xDTaraZ.Survivor.UnhookTarget()
        if point then
            local job = xDTaraZ.Survivor.NewJob("Unhook", point, remote.Unhook)
            job.Char = char
            return job
        end
    end
    if opts.AutoHeal and rank < 2 and not finishing then
        local hrp = xDTaraZ.Survivor.HealTarget(true)
        if hrp then return xDTaraZ.Survivor.NewJob("Heal", hrp, remote.Heal) end
    end
    if job then return nil end
    if opts.AutoRepair and xDTaraZ.Map.GensLeft() > 0 then
        local point = xDTaraZ.Survivor.PickGenPoint(pos)
        if point then return xDTaraZ.Survivor.NewJob("Repair", point, remote.Repair) end
    end
    if opts.AutoHeal then
        local hrp = xDTaraZ.Survivor.HealTarget(false)
        if hrp then return xDTaraZ.Survivor.NewJob("Heal", hrp, remote.Heal) end
    end
    return nil
end

function xDTaraZ.Survivor.Watchdog(job)
    if job.Kind ~= "Repair" or osClock() - job.Checked < xDTaraZ.Config.StallTime then return end
    local gen = job.Target:FindFirstAncestor("Generator")
    local progress = xDTaraZ.Map.GenProgress(gen)
    job.Checked = osClock()
    if progress > job.Progress then
        job.Progress = progress
        return
    end
    xDTaraZ.Survivor.Banned[gen] = osClock() + xDTaraZ.Config.StallBan
    xDTaraZ.Survivor.Gen = nil
    xDTaraZ.Survivor.Finish()
end

function xDTaraZ.Survivor.Run(job)
    xDTaraZ.Survivor.Hold(job.Target, job.Fired and job.Kind ~= "Heal")
    if not job.Fired and osClock() - job.Since >= xDTaraZ.Config.Settle then
        job.Fired = true
        job.Progress = job.Kind == "Repair" and xDTaraZ.Map.GenProgress(job.Target:FindFirstAncestor("Generator")) or 0
        job.Checked = osClock()
        if job.Kind == "Unhook" then job.Remote:FireServer(job.Target) else job.Remote:FireServer(job.Target, true) end
    end
    if job.Fired then xDTaraZ.Survivor.Watchdog(job) end
    xDTaraZ.Survivor.Status = (job.Fired and job.Kind or "Moving to " .. job.Kind) .. " · gens left " .. xDTaraZ.Map.GensLeft()
end

---@return BasePart?  walk-through floor of the finish line
function xDTaraZ.Survivor.FinishLine()
    local hrp = xDTaraZ.Player.Root
    if not hrp then return nil end
    return xDTaraZ.Map.Nearest(xDTaraZ.Map.Tagged("EscapePart"), hrp.Position, function(part)
        return not part.CanCollide
    end)
end

function xDTaraZ.Survivor.EscapeNow()
    local line = xDTaraZ.Survivor.FinishLine()
    if not line then return false end
    xDTaraZ.Survivor.Finish()
    xDTaraZ.Player.Teleport(line.CFrame + vector3New(0, 3, 0))
    local hrp = xDTaraZ.Player.Root
    if Util.FireTouch and hrp then
        Util.FireTouch(hrp, line, 0)
        Util.FireTouch(hrp, line, 1)
    end
    return true
end

function xDTaraZ.Survivor.Enabled()
    local opts = xDTaraZ.Options
    return opts.AutoRepair or opts.AutoHeal or opts.AutoUnhook or opts.InstantEscape
end

---@return boolean  escaped this tick
function xDTaraZ.Survivor.TryEscape()
    local opts = xDTaraZ.Options
    local ready = opts.InstantEscape and (osClock() - xDTaraZ.Survivor.RoundStart >= opts.EscapeDelay or xDTaraZ.Map.GensLeft() == 0)
    if not ready then return false end
    if osClock() - xDTaraZ.Survivor.LastEscape < xDTaraZ.Config.EscapeRetry then return true end
    if not xDTaraZ.Survivor.EscapeNow() then return false end
    xDTaraZ.Survivor.LastEscape = osClock()
    xDTaraZ.Survivor.Escapes += 1
    xDTaraZ.Survivor.Status = "Escaped"
    return true
end

function xDTaraZ.Survivor.Step()
    if not xDTaraZ.Survivor.Enabled() then
        xDTaraZ.Survivor.Finish()
        xDTaraZ.Survivor.Status = "Off"
        return
    end
    local map = xDTaraZ.Map.Root()
    if map ~= xDTaraZ.Survivor.Map then
        xDTaraZ.Survivor.Map = map
        xDTaraZ.Survivor.RoundStart = osClock()
    end
    if not xDTaraZ.State.Alive or xDTaraZ.Player.Role() ~= "Survivors" or not xDTaraZ.Player:IsAlive() then
        xDTaraZ.Survivor.Gen = nil
        table.clear(xDTaraZ.Survivor.Banned)
        xDTaraZ.Survivor.Finish()
        xDTaraZ.Survivor.Status = "Not a survivor"
        return
    end
    if xDTaraZ.Player.Disabled(xDTaraZ.Player.Character) then
        xDTaraZ.Survivor.Finish()
        xDTaraZ.Survivor.Status = "Downed / hooked"
        return
    end
    if xDTaraZ.Survivor.TryEscape() then return end

    local job = xDTaraZ.Survivor.Job
    if job and not xDTaraZ.Survivor.JobAlive(job) then
        xDTaraZ.Survivor.Finish()
        job = nil
    end
    local better = xDTaraZ.Survivor.Candidate(xDTaraZ.Player.Root.Position)
    if better then
        xDTaraZ.Survivor.Finish()
        xDTaraZ.Survivor.Job = better
        job = better
    end
    if not job then
        xDTaraZ.Survivor.Status = "Waiting · gens left " .. xDTaraZ.Map.GensLeft()
        return
    end
    xDTaraZ.Survivor.Run(job)
end

xDTaraZ.Guard = { Dodges = 0, LastUnhook = 0, UnhookTries = 0, LastDodge = 0 }

---@return BasePart?  free point on the unfinished generator farthest from the killer
function xDTaraZ.Guard.SafeSpot(killerPos)
    local best, bestDist = nil, 0
    for _, gen in ipairs(xDTaraZ.Map.Generators()) do
        if not xDTaraZ.Survivor.GenUsable(gen) then continue end
        local point = xDTaraZ.Survivor.PointOn(gen)
        local dist = point and (point.Position - killerPos).Magnitude or 0
        if dist > bestDist then best, bestDist = point, dist end
    end
    return best
end

function xDTaraZ.Guard.Step()
    local opts = xDTaraZ.Options
    if not (opts.AutoDodge or opts.AutoSelfUnhook) or not xDTaraZ.State.Alive then return end
    if xDTaraZ.Player.Role() ~= "Survivors" or not xDTaraZ.Player:IsAlive() then return end
    local char, hrp = xDTaraZ.Player.Character, xDTaraZ.Player.Root

    if not char:GetAttribute("IsHooked") then xDTaraZ.Guard.UnhookTries = 0 end
    if opts.AutoSelfUnhook and char:GetAttribute("IsHooked") and xDTaraZ.Guard.UnhookTries < xDTaraZ.Config.SelfUnhookMax
        and osClock() - xDTaraZ.Guard.LastUnhook >= xDTaraZ.Config.SelfUnhookRetry then
        xDTaraZ.Guard.LastUnhook = osClock()
        xDTaraZ.Guard.UnhookTries += 1
        GameLib.Remote.SelfUnhook:FireServer()
        return
    end
    if not opts.AutoDodge or xDTaraZ.Player.Disabled(char) or osClock() - xDTaraZ.Guard.LastDodge < xDTaraZ.Config.DodgeCooldown then return end

    local killer = xDTaraZ.Player.Killer()
    local root = killer and killer:FindFirstChild("HumanoidRootPart")
    if not root or (root.Position - hrp.Position).Magnitude > opts.DodgeRadius then return end
    local spot = xDTaraZ.Guard.SafeSpot(root.Position)
    if not spot or (spot.Position - root.Position).Magnitude <= opts.DodgeRadius then return end
    xDTaraZ.Guard.LastDodge = osClock()
    xDTaraZ.Survivor.Finish()
    xDTaraZ.Survivor.Gen = spot:FindFirstAncestor("Generator")
    xDTaraZ.Player.Teleport(spot.CFrame + vector3New(0, 3, 0))
    xDTaraZ.Guard.Dodges += 1
end

xDTaraZ.Alert = { Near = false, Distance = nil }

function xDTaraZ.Alert.Step()
    local hrp = xDTaraZ.Player.Root
    local killer = xDTaraZ.Player.Killer()
    local root = killer and killer:FindFirstChild("HumanoidRootPart")
    if not (hrp and root) or xDTaraZ.Player.Role() ~= "Survivors" then
        xDTaraZ.Alert.Near, xDTaraZ.Alert.Distance = false, nil
        return
    end
    local dist = (root.Position - hrp.Position).Magnitude
    xDTaraZ.Alert.Distance = dist
    local near = dist <= xDTaraZ.Config.AlertRadius
    if near and not xDTaraZ.Alert.Near and xDTaraZ.Options.KillerAlert and xDTaraZ.Library then
        xDTaraZ.Library:Notify("Killer nearby", ("%d m away"):format(dist), 3, "Warning")
    end
    xDTaraZ.Alert.Near = near
end

xDTaraZ.SkillCheck = { Started = false, Checks = 0 }

function xDTaraZ.SkillCheck.OnGen(point, checkId)
    if not xDTaraZ.Options.PerfectSkillCheck then return end
    xDTaraZ.SkillCheck.Checks += 1
    GameLib.Remote.GenResult:FireServer("success", 1, point, checkId)
end

function xDTaraZ.SkillCheck.OnHeal(point)
    if not xDTaraZ.Options.PerfectSkillCheck then return end
    xDTaraZ.SkillCheck.Checks += 1
    GameLib.Remote.HealResult:FireServer("success", 1, point)
end

function xDTaraZ.SkillCheck.Start()
    local remote = GameLib.Remote
    if xDTaraZ.SkillCheck.Started or not (remote.GenCheck and remote.HealCheck and remote.GenResult and remote.HealResult) then return end
    xDTaraZ.SkillCheck.Started = true
    xDTaraZ.Block.Keep(xDTaraZ.SkillCheck.OnGen)
    xDTaraZ.Block.Keep(xDTaraZ.SkillCheck.OnHeal)
    xDTaraZ:Connect(remote.GenCheck.OnClientEvent, xDTaraZ.SkillCheck.OnGen)
    xDTaraZ:Connect(remote.HealCheck.OnClientEvent, xDTaraZ.SkillCheck.OnHeal)
end

function xDTaraZ.Survivor.Sacrifice()
    local hum = xDTaraZ.Player.Humanoid
    if not hum or xDTaraZ.Player.Role() ~= "Survivors" then return false end
    xDTaraZ.Survivor.Finish()
    hum.Health = 0
    return true
end

xDTaraZ.Parry = { Last = 0, Count = 0, Clients = setmetatable({}, { __mode = "k" }), Scanned = 0 }

function xDTaraZ.Parry.Remote()
    local items = ReplicatedStorage.Remotes:FindFirstChild("Items")
    local dagger = items and items:FindFirstChild("Parrying Dagger")
    return dagger and dagger:FindFirstChild("parry")
end

function xDTaraZ.Parry.Holding()
    return LocalPlayer:GetAttribute("EquippedItem") == "Parrying Dagger"
end

---@return boolean  killer is close and closing in fast
function xDTaraZ.Parry.Threat()
    local hrp = xDTaraZ.Player.Root
    local killer = xDTaraZ.Player.Killer()
    local root = killer and killer:FindFirstChild("HumanoidRootPart")
    if not (hrp and root) then return false end
    local offset = hrp.Position - root.Position
    if offset.Magnitude > xDTaraZ.Config.ParryRange then return false end
    local closing = root.AssemblyLinearVelocity:Dot(offset.Unit)
    return closing >= xDTaraZ.Config.ParryClosing or offset.Magnitude <= xDTaraZ.Config.ParryPanic
end

function xDTaraZ.Parry.FindClients()
    if not Util.GetGc or osClock() - xDTaraZ.Parry.Scanned < xDTaraZ.Config.ParryScan then return end
    xDTaraZ.Parry.Scanned = osClock()
    for _, obj in ipairs(Util.GetGc(true)) do
        if type(obj) == "table" and rawget(obj, "isParryOnCooldown") ~= nil and rawget(obj, "parryEvent") then
            xDTaraZ.Parry.Clients[obj] = true
        end
    end
end

function xDTaraZ.Parry.ClearCooldowns()
    xDTaraZ.Parry.FindClients()
    for client in pairs(xDTaraZ.Parry.Clients) do
        client.isParryOnCooldown = false
        client.isParryResolving = false
        client.cooldownToken = (client.cooldownToken or 0) + 1
    end
end

function xDTaraZ.Parry.Step()
    local opts = xDTaraZ.Options
    if not (opts.AutoParry or opts.NoParryCooldown) or not xDTaraZ.State.Alive then return end
    if xDTaraZ.Player.Role() ~= "Survivors" or not xDTaraZ.Parry.Holding() then return end
    if opts.NoParryCooldown then xDTaraZ.Parry.ClearCooldowns() end
    if not opts.AutoParry or xDTaraZ.Player.Disabled(xDTaraZ.Player.Character) then return end

    local retry = opts.NoParryCooldown and xDTaraZ.Config.ParryFast or xDTaraZ.Config.ParryRetry
    if osClock() - xDTaraZ.Parry.Last < retry or not xDTaraZ.Parry.Threat() then return end
    local remote = xDTaraZ.Parry.Remote()
    if not remote then return end
    xDTaraZ.Parry.Last = osClock()
    xDTaraZ.Parry.Count += 1
    remote:FireServer()
end

xDTaraZ.Killer = { Status = "Off", LastSwing = 0, Hits = 0, Breaks = 0, Kicked = {} }

function xDTaraZ.Killer.Behind(targetRoot)
    local pos = targetRoot.Position - targetRoot.CFrame.LookVector * xDTaraZ.Config.AttackReach
    return cframeLookAt(pos, targetRoot.Position)
end

---@return Model?  nearest survivor matching state, inside range
function xDTaraZ.Killer.Pick(knocked, range)
    local hrp = xDTaraZ.Player.Root
    local best, bestDist = nil, range
    for _, char in ipairs(xDTaraZ.Player.Survivors()) do
        if (char:GetAttribute("Knocked") == true) ~= knocked then continue end
        if char:GetAttribute("IsHooked") or char:GetAttribute("IsCarried") then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local dist = (char.HumanoidRootPart.Position - hrp.Position).Magnitude
        if dist < bestDist then best, bestDist = char, dist end
    end
    return best
end

function xDTaraZ.Killer.Swing(target)
    local root = target.HumanoidRootPart
    local remote = GameLib.Remote
    local stop = osClock() + xDTaraZ.Config.LungeDelay + xDTaraZ.Config.SwingTail
    local fired = false
    remote.Lunge:FireServer()
    local start = osClock()
    while osClock() < stop and root.Parent and xDTaraZ.State.Alive and xDTaraZ.Options.KillAura do
        xDTaraZ.Player.Teleport(xDTaraZ.Killer.Behind(root))
        if not fired and osClock() - start >= xDTaraZ.Config.LungeDelay then
            fired = true
            remote.Attack:FireServer()
        end
        RunService.Heartbeat:Wait()
    end
    if target:GetAttribute("Knocked") then xDTaraZ.Killer.Hits += 1 end
end

---@return boolean  still allowed to act after a yield
function xDTaraZ.Killer.Live(option, hrp)
    return xDTaraZ.State.Alive and xDTaraZ.Options[option] and xDTaraZ.Player:IsAlive() and xDTaraZ.Player.Root == hrp
end

function xDTaraZ.Killer.Carry(target)
    local hrp = xDTaraZ.Player.Root
    xDTaraZ.Player.Teleport(xDTaraZ.Killer.Behind(target.HumanoidRootPart))
    task.wait(xDTaraZ.Config.Settle)
    if not xDTaraZ.Killer.Live("AutoHook", hrp) or not target:GetAttribute("Knocked") then return end
    GameLib.Remote.Carry:FireServer(target)
    task.wait(xDTaraZ.Config.CarryDelay)
end

---@param offset Vector3  where the game stands you relative to the point
---@return boolean  false if the action was abandoned
function xDTaraZ.Killer.Commit(option, point, offset, remote, commit)
    local hrp = xDTaraZ.Player.Root
    if not hrp then return false end
    local seat = point.CFrame * cframeNew(offset)
    xDTaraZ.Player.Teleport(seat * cframeNew(0, 0, 3))
    task.wait(xDTaraZ.Config.Settle)
    if not xDTaraZ.Killer.Live(option, hrp) then return false end
    remote:FireServer(point)
    local tween = TweenService:Create(hrp, TweenInfo.new(xDTaraZ.Config.HookTween), { CFrame = seat })
    tween:Play()
    tween.Completed:Wait()
    if not xDTaraZ.Killer.Live(option, hrp) then return false end
    commit:FireServer(point)
    return true
end

function xDTaraZ.Killer.Hook()
    local hrp = xDTaraZ.Player.Root
    local point = hrp and xDTaraZ.Map.Nearest(xDTaraZ.Map.Tagged("HookPoint"), hrp.Position)
    if not point then return end
    if xDTaraZ.Killer.Commit("AutoHook", point, vector3New(0, 0.6, 0), GameLib.Remote.Hook, GameLib.Remote.HookCommit) then
        task.wait(xDTaraZ.Config.HookRest)
    end
end

---@return BasePart?  point on the most-repaired unfinished generator
function xDTaraZ.Killer.GenToBreak()
    local best, bestProgress = nil, 0
    for _, point in ipairs(xDTaraZ.Map.Tagged("GeneratorPoint")) do
        local gen = point:FindFirstAncestor("Generator")
        local progress = gen and xDTaraZ.Map.GenProgress(gen) or 0
        local fresh = gen and osClock() - (xDTaraZ.Killer.Kicked[gen] or 0) > xDTaraZ.Config.KickRegress
        if fresh and progress > bestProgress and progress < xDTaraZ.Config.GenDone then
            best, bestProgress = point, progress
        end
    end
    return best
end

function xDTaraZ.Killer.BreakGen(point)
    if not xDTaraZ.Killer.Commit("AutoBreakGens", point, vector3New(0, 0, 1), GameLib.Remote.BreakGen, GameLib.Remote.BreakGenCommit) then return end
    task.wait(xDTaraZ.Config.GenBreakTime)
    xDTaraZ.Killer.Kicked[point:FindFirstAncestor("Generator")] = osClock()
    xDTaraZ.Killer.Breaks += 1
end

xDTaraZ.AntiStun = { Count = 0 }

function xDTaraZ.AntiStun.OnStun()
    if not xDTaraZ.Options.AntiStun or xDTaraZ.Player.Role() ~= "Killer" then return end
    xDTaraZ.AntiStun.Count += 1
    GameLib.Remote.StunOver:FireServer()
end

function xDTaraZ.AntiStun.Start()
    if not (GameLib.Remote.Stun and GameLib.Remote.StunOver) then return end
    xDTaraZ.Block.Keep(xDTaraZ.AntiStun.OnStun)
    xDTaraZ:Connect(GameLib.Remote.Stun.OnClientEvent, xDTaraZ.AntiStun.OnStun)
end

---@return Model?  survivor right in front of us inside lunge reach
function xDTaraZ.Killer.InFront()
    local hrp = xDTaraZ.Player.Root
    local look = hrp.CFrame.LookVector
    for _, char in ipairs(xDTaraZ.Player.Survivors()) do
        if char:GetAttribute("Knocked") or char:GetAttribute("IsHooked") or char:GetAttribute("IsCarried") then continue end
        local offset = char.HumanoidRootPart.Position - hrp.Position
        if offset.Magnitude <= xDTaraZ.Config.LegitReach and look:Dot(offset.Unit) >= xDTaraZ.Config.LegitAngle then return char end
    end
    return nil
end

---@param target Model  survivor in front; closed in on when Smart Hitbox is on
function xDTaraZ.Killer.LegitSwing(target)
    local remote = GameLib.Remote
    local root = target.HumanoidRootPart
    local function Close()
        local hrp = xDTaraZ.Player.Root
        if not (xDTaraZ.Options.SmartHitbox and hrp and root.Parent) then return end
        local offset = root.Position - hrp.Position
        if offset.Magnitude <= xDTaraZ.Config.ServerReach then return end
        local spot = root.Position - offset.Unit * xDTaraZ.Config.AttackReach
        xDTaraZ.Player.Teleport(cframeLookAt(vector3New(spot.X, hrp.Position.Y, spot.Z), vector3New(root.Position.X, hrp.Position.Y, root.Position.Z)))
    end
    Close()
    remote.Lunge:FireServer()
    task.wait(xDTaraZ.Config.LungeDelay)
    Close()
    remote.Attack:FireServer()
end

function xDTaraZ.Killer.Enabled()
    local opts = xDTaraZ.Options
    return opts.KillAura or opts.AutoHook or opts.AutoBreakGens
end

function xDTaraZ.Killer.Step()
    if not xDTaraZ.Killer.Enabled() then xDTaraZ.Killer.Status = "Off" return end
    if not xDTaraZ.State.Alive or xDTaraZ.Player.Role() ~= "Killer" or not xDTaraZ.Player:IsAlive() then
        xDTaraZ.Killer.Status = "Not the killer"
        return
    end
    local char, opts = xDTaraZ.Player.Character, xDTaraZ.Options

    if char:GetAttribute("CarriedSurvivorId") then
        if opts.AutoHook then xDTaraZ.Killer.Hook() end
        xDTaraZ.Killer.Status = "Carrying"
        return
    end

    if opts.AutoHook then
        local downed = xDTaraZ.Killer.Pick(true, opts.AuraRange)
        if downed then
            xDTaraZ.Killer.Status = "Picking up " .. downed.Name
            xDTaraZ.Killer.Carry(downed)
            return
        end
    end

    if opts.KillAura and GameLib.Remote.Lunge and GameLib.Remote.Attack and osClock() - xDTaraZ.Killer.LastSwing >= xDTaraZ.Config.AuraCooldown then
        local legit = opts.SlashMode == "Legit"
        local target = legit and xDTaraZ.Killer.InFront() or not legit and xDTaraZ.Killer.Pick(false, opts.AuraRange)
        if target then
            xDTaraZ.Killer.LastSwing = osClock()
            xDTaraZ.Killer.Status = "Hitting " .. target.Name
            if legit then xDTaraZ.Killer.LegitSwing(target) else xDTaraZ.Killer.Swing(target) end
            return
        end
    end
    if opts.AutoBreakGens then
        local point = xDTaraZ.Killer.GenToBreak()
        if point then
            xDTaraZ.Killer.Status = "Breaking generator"
            xDTaraZ.Killer.BreakGen(point)
            return
        end
    end
    xDTaraZ.Killer.Status = ("Hunting · downs %d · gens kicked %d"):format(xDTaraZ.Killer.Hits, xDTaraZ.Killer.Breaks)
end

xDTaraZ.Teleport = {}

function xDTaraZ.Teleport.Places()
    local names = { "Nearest Generator", "Best Generator", "Exit Gate", "Nearest Hook", "Killer", "Farthest From Killer" }
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then names[#names + 1] = player.Name end
    end
    return names
end

---@return CFrame?  stand spot for a teleport choice
function xDTaraZ.Teleport.Resolve(choice)
    local hrp = xDTaraZ.Player.Root
    if not hrp then return nil end
    local pos = hrp.Position
    local function At(part) return part and part.CFrame + vector3New(0, 3, 0) end

    if choice == "Nearest Generator" then
        return At(xDTaraZ.Map.Nearest(xDTaraZ.Map.Tagged("GeneratorPoint"), pos, function(point)
            local gen = point:FindFirstAncestor("Generator")
            return gen and xDTaraZ.Map.GenProgress(gen) < xDTaraZ.Config.GenDone
        end))
    elseif choice == "Best Generator" then
        return At(xDTaraZ.Survivor.PickGenPoint(pos, true))
    elseif choice == "Exit Gate" then
        local gate = xDTaraZ.Map.Models("Gate")[1]
        local part = gate and (gate:FindFirstChild("ExitLever", true) or gate:FindFirstChildWhichIsA("BasePart", true))
        return part and (part:IsA("Model") and part:GetPivot() or part.CFrame) + vector3New(0, 3, 0)
    elseif choice == "Nearest Hook" then
        return At(xDTaraZ.Map.Nearest(xDTaraZ.Map.Tagged("HookPoint"), pos))
    elseif choice == "Killer" then
        local killer = xDTaraZ.Player.Killer()
        return killer and At(killer:FindFirstChild("HumanoidRootPart"))
    elseif choice == "Farthest From Killer" then
        local killer = xDTaraZ.Player.Killer()
        local root = killer and killer:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local best, bestDist = nil, 0
        for _, point in ipairs(xDTaraZ.Map.Tagged("GeneratorPoint")) do
            local dist = (point.Position - root.Position).Magnitude
            if dist > bestDist then best, bestDist = point, dist end
        end
        return At(best)
    end
    local player = Players:FindFirstChild(choice)
    return player and player.Character and At(player.Character:FindFirstChild("HumanoidRootPart"))
end

function xDTaraZ.Teleport.Go(choice)
    local cframe = xDTaraZ.Teleport.Resolve(choice)
    if not cframe then return false end
    xDTaraZ.Player.Teleport(cframe)
    return true
end

xDTaraZ.Esp = { Count = 0, Marks = {}, Folder = nil }

---@return table[]  players in the shape Library.Visuals expects
function xDTaraZ.Esp.Targets()
    local list = {}
    local mine = xDTaraZ.Player.Role()
    for _, player in ipairs(Players:GetPlayers()) do
        local char = player.Character
        local role = xDTaraZ.Player.Role(player)
        if player == LocalPlayer or not char or (role ~= "Survivors" and role ~= "Killer") then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local tag = role == "Killer" and "KILLER" or char:GetAttribute("IsHooked") and "Hooked"
            or char:GetAttribute("Knocked") and "Downed" or nil
        list[#list + 1] = {
            Model = char,
            Name = tag and (player.DisplayName .. " [" .. tag .. "]") or player.DisplayName,
            Health = hum.Health,
            MaxHealth = hum.MaxHealth > 0 and hum.MaxHealth or 100,
            Friendly = mine == role,
            Root = char:FindFirstChild("HumanoidRootPart"),
        }
    end
    xDTaraZ.Esp.Count = #list
    return list
end

xDTaraZ.Esp.Kinds = {
    { Option = "EspGenerators", Glow = true, Color = Color3.fromRGB(255, 196, 64), Find = xDTaraZ.Map.Generators, Label = function(model)
        local progress = xDTaraZ.Map.GenProgress(model)
        if progress >= xDTaraZ.Config.GenDone then return "Gen DONE" end
        return ("Gen %d%%"):format(progress)
    end },
    { Option = "EspHooks", Glow = true, Color = Color3.fromRGB(235, 70, 70), Find = function()
        local list = {}
        for _, point in ipairs(xDTaraZ.Map.Tagged("HookPoint")) do list[#list + 1] = point.Parent end
        return list
    end, Label = function() return "Hook" end },
    { Option = "EspGates", Glow = true, Color = Color3.fromRGB(90, 220, 120), Find = function() return xDTaraZ.Map.Models("Gate") end, Label = function() return "Exit Gate" end },
    { Option = "EspPallets", Color = Color3.fromRGB(200, 150, 90), Find = function()
        local list = {}
        for _, point in ipairs(xDTaraZ.Map.Tagged("PalletPoint")) do list[#list + 1] = point.Parent end
        return list
    end, Label = function() return "Pallet" end },
    { Option = "EspWindows", Color = Color3.fromRGB(110, 170, 255), Find = function()
        local list = {}
        for _, point in ipairs(xDTaraZ.Map.Tagged("VaultPoint")) do
            local model = point.Parent
            if model and model.Name == "Window" and not table.find(list, model) then list[#list + 1] = model end
        end
        return list
    end, Label = function() return "Window" end },
}

function xDTaraZ.Esp.Holder()
    local folder = xDTaraZ.Esp.Folder
    if folder and folder.Parent then return folder end
    folder = Instance.new("Folder")
    folder.Name = "MarioObjectEsp"
    folder.Parent = Util.Hui()
    xDTaraZ.Esp.Folder = folder
    return folder
end

function xDTaraZ.Esp.Make(model, kind)
    local holder = xDTaraZ.Esp.Holder()
    local light
    if kind.Glow then
        light = Instance.new("Highlight")
        light.Adornee = model
        light.FillColor = kind.Color
        light.FillTransparency = 0.75
        light.OutlineColor = kind.Color
        light.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        light.Parent = holder
    end

    local board = Instance.new("BillboardGui")
    board.Adornee = model:IsA("Model") and (model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)) or model
    board.Size = UDim2.fromOffset(120, 22)
    board.StudsOffset = vector3New(0, 3, 0)
    board.AlwaysOnTop = true
    board.Parent = holder

    local text = Instance.new("TextLabel")
    text.BackgroundTransparency = 1
    text.Size = UDim2.fromScale(1, 1)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 13
    text.TextColor3 = kind.Color
    text.TextStrokeTransparency = 0.3
    text.Parent = board
    return { Light = light, Board = board, Text = text }
end

function xDTaraZ.Esp.Drop(model)
    local mark = xDTaraZ.Esp.Marks[model]
    if not mark then return end
    if mark.Light then mark.Light:Destroy() end
    mark.Board:Destroy()
    xDTaraZ.Esp.Marks[model] = nil
end

function xDTaraZ.Esp.Step()
    local map = xDTaraZ.Map.Root()
    local seen = {}
    local hrp = xDTaraZ.Player.Root
    if map then
        for _, kind in ipairs(xDTaraZ.Esp.Kinds) do
            if not xDTaraZ.Options[kind.Option] then continue end
            for _, model in ipairs(kind.Find()) do
                seen[model] = true
                local mark = xDTaraZ.Esp.Marks[model] or xDTaraZ.Esp.Make(model, kind)
                xDTaraZ.Esp.Marks[model] = mark
                local label = kind.Label(model)
                local part = mark.Board.Adornee
                if hrp and part then label ..= (" · %dm"):format((part.Position - hrp.Position).Magnitude) end
                mark.Text.Text = label
            end
        end
    end
    for model in pairs(xDTaraZ.Esp.Marks) do
        if not seen[model] or not model.Parent then xDTaraZ.Esp.Drop(model) end
    end
end

function xDTaraZ.Esp.Clear()
    for model in pairs(xDTaraZ.Esp.Marks) do xDTaraZ.Esp.Drop(model) end
    if xDTaraZ.Esp.Folder then xDTaraZ.Esp.Folder:Destroy() end
    xDTaraZ.Esp.Folder = nil
end

function xDTaraZ.Esp.GetStatus()
    local visuals = xDTaraZ.Library and xDTaraZ.Library.Visuals
    local players = visuals and visuals:Get("Enabled") and (xDTaraZ.Esp.Count .. " players") or "players off"
    local objects = 0
    for _ in pairs(xDTaraZ.Esp.Marks) do objects += 1 end
    return players .. " · " .. objects .. " objects"
end

xDTaraZ.Shop = { Status = "Off", Maxed = {}, Owned = {}, LevelCost = {}, Bought = 0, Leveled = 0, Busy = false, LastWallet = nil }

function xDTaraZ.Shop.Remote(name)
    local shop = ReplicatedStorage.Remotes:FindFirstChild("Shop")
    return shop and shop:FindFirstChild(name)
end

---@return string[]  folder names under ReplicatedStorage.<folder>, dev entries skipped
function xDTaraZ.Shop.Names(folder)
    local list = {}
    local root = ReplicatedStorage:FindFirstChild(folder)
    for _, child in ipairs(root and root:GetChildren() or {}) do
        if not child.Name:find("^!") then list[#list + 1] = child.Name end
    end
    table.sort(list)
    return list
end

function xDTaraZ.Shop.Wallet()
    return tonumber(LocalPlayer:GetAttribute("Screws")) or 0, tonumber(LocalPlayer:GetAttribute("Gears")) or 0
end

---@return table?  { owned, level, price } from the server
function xDTaraZ.Shop.Info(getter, name)
    local remote = xDTaraZ.Shop.Remote(getter)
    if not remote then return nil end
    local ok, info = pcall(remote.InvokeServer, remote, name)
    return ok and type(info) == "table" and info or nil
end

---@return any  whatever fn returns, nil while another shop run is active
function xDTaraZ.Shop.Locked(fn, ...)
    if xDTaraZ.Shop.Busy then return 0 end
    xDTaraZ.Shop.Busy = true
    local ok, got = pcall(fn, ...)
    xDTaraZ.Shop.Busy = false
    if not ok then warn("[ViolenceDistrict] shop: " .. tostring(got)) return 0 end
    return got
end

function xDTaraZ.Shop.BuyPerks()
    local buy = xDTaraZ.Shop.Remote("PurchasePerk")
    if not buy then return 0 end
    local count = 0
    local _, gears = xDTaraZ.Shop.Wallet()
    for _, name in ipairs(xDTaraZ.Shop.Names("Perks")) do
        if not xDTaraZ.State.Alive then break end
        if xDTaraZ.Shop.Owned[name] then continue end
        local info = xDTaraZ.Shop.Info("GetPerkInfo", name)
        if info and info.owned then xDTaraZ.Shop.Owned[name] = true end
        if not info or info.owned or gears < (info.price or mathHuge) then continue end
        buy:FireServer(name)
        gears -= info.price
        count += 1
        task.wait(xDTaraZ.Config.ShopDelay)
    end
    xDTaraZ.Shop.Bought += count
    return count
end

function xDTaraZ.Shop.LevelPerks()
    local level = xDTaraZ.Shop.Remote("LevelUpPerk")
    if not level then return 0 end
    local count = 0
    for _, name in ipairs(xDTaraZ.Shop.Names("Perks")) do
        if xDTaraZ.Shop.Maxed[name] then continue end
        local screws = xDTaraZ.Shop.Wallet()
        local before = xDTaraZ.Shop.Info("GetPerkInfo", name)
        if not before or not before.owned then continue end
        if not xDTaraZ.State.Alive then break end
        local cost = xDTaraZ.Shop.LevelCost[name] or xDTaraZ.Shop.MaxCost()
        if screws - cost < xDTaraZ.Options.KeepScrews then continue end
        level:FireServer(name)
        task.wait(xDTaraZ.Config.ShopDelay)
        local after = xDTaraZ.Shop.Info("GetPerkInfo", name)
        local spent = screws - xDTaraZ.Shop.Wallet()
        if after and after.level ~= before.level then
            xDTaraZ.Shop.LevelCost[name] = math.max(spent, cost or 0)
            count += 1
        elseif spent == 0 and cost and screws > cost * 2 then
            xDTaraZ.Shop.Maxed[name] = true
        end
    end
    xDTaraZ.Shop.Leveled += count
    return count
end

---@param kind string  "Item" or "Killer"
function xDTaraZ.Shop.BuyList(kind, names)
    local buy = xDTaraZ.Shop.Remote("Purchase" .. kind)
    if not buy then return 0 end
    local count = 0
    for key, picked in pairs(names or {}) do
        local name = type(key) == "number" and picked or key
        if not picked or type(name) ~= "string" then continue end
        local owned
        if kind == "Killer" then
            local check = xDTaraZ.Shop.Remote("CheckKillerOwnership")
            local ok, got = pcall(function() return check and check:InvokeServer(name) end)
            owned = ok and got == true
        else
            local info = xDTaraZ.Shop.Info("GetItemInfo", name)
            owned = info and info.owned
        end
        local price = kind == "Killer" and xDTaraZ.Shop.KillerPrice(name) or (xDTaraZ.Shop.Info("GetItemInfo", name) or {}).price
        if owned or not price or xDTaraZ.Shop.Wallet() - price < xDTaraZ.Options.KeepScrews then continue end
        buy:FireServer(name)
        count += 1
        task.wait(xDTaraZ.Config.ShopDelay)
    end
    return count
end

---@return number  highest level-up cost seen so far, a safe guess for unknown perks
function xDTaraZ.Shop.MaxCost()
    local most = xDTaraZ.Config.FirstLevelCost
    for _, cost in pairs(xDTaraZ.Shop.LevelCost) do most = math.max(most, cost) end
    return most
end

function xDTaraZ.Shop.KillerPrice(name)
    local remote = xDTaraZ.Shop.Remote("GetKillerPrice")
    local ok, price = pcall(function() return remote and remote:InvokeServer(name) end)
    return ok and tonumber(price) or nil
end

function xDTaraZ.Shop.Step()
    local opts = xDTaraZ.Options
    if not (opts.AutoBuyPerks or opts.AutoLevelPerks) then
        xDTaraZ.Shop.Status = "Off"
        xDTaraZ.Shop.LastWallet = nil
        return
    end
    local wallet = table.concat({ xDTaraZ.Shop.Wallet() }, "/")
    if wallet == xDTaraZ.Shop.LastWallet then return end
    xDTaraZ.Shop.LastWallet = wallet
    if opts.AutoBuyPerks then xDTaraZ.Shop.Locked(xDTaraZ.Shop.BuyPerks) end
    if opts.AutoLevelPerks then xDTaraZ.Shop.Locked(xDTaraZ.Shop.LevelPerks) end
    local screws, gears = xDTaraZ.Shop.Wallet()
    xDTaraZ.Shop.Status = ("bought %d · leveled %d · %d screws · %d gears"):format(xDTaraZ.Shop.Bought, xDTaraZ.Shop.Leveled, screws, gears)
end

xDTaraZ.UI = { Labels = {} }
local Library, T

function xDTaraZ.UI.Detach(fn)
    return function(...)
        local packed = table.pack(...)
        task.defer(function()
            local ok, err = pcall(fn, table.unpack(packed, 1, packed.n))
            if not ok then warn("[ViolenceDistrict] ui: " .. tostring(err)) end
        end)
    end
end

---@param widget table  option whose value mirrors an Options key
function xDTaraZ.UI.Bind(widget, key)
    xDTaraZ.Options[key] = widget.Value
    widget:OnChanged(function(value) xDTaraZ.Options[key] = value end)
    return widget
end

function xDTaraZ.UI.BuildMain(window)
    window:AddTabSection(T("Main", "หลัก"))
    local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and links", "สถานะและลิงก์"))

    local farm = tab:AddLeftGroupbox(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "star")
    farm:AddToggle("AutoFarm", { Text = T("Auto farm (Kaitun)", "ฟาร์มอัตโนมัติ (Kaitun)"), Description = T("Plays both roles for you: repairs, escapes, hunts and hooks", "เล่นให้ทั้งสองฝั่ง ซ่อม หนี ล่า แขวน"), Risky = true, Callback = xDTaraZ.UI.Detach(xDTaraZ.UI.SetFarm) })
    farm:AddDropdown("RoleMode", { Text = T("Role", "บทบาท"), Description = T("Survivor only never gets killer; Prefer killer keeps you in the killer pool", "Survivor only ไม่ถูกสุ่มเป็นฆาตกร / Prefer killer อยู่ในกลุ่มสุ่มฆาตกรเสมอ"), Values = { "Any", "Survivor only", "Prefer killer" }, Default = "Any" })
    farm:AddSlider("FarmEscapeAfter", { Text = T("Survivor: escape after", "ผู้รอด: หนีหลัง"), Description = T("0 = never escape, stay and farm the whole round", "0 = ไม่หนี อยู่ฟาร์มจนจบรอบ"), Min = 0, Max = 900, Default = 0, Suffix = "s" })

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
    xDTaraZ.UI.Labels.Role = status:AddParagraph({ Title = T("Role", "บทบาท"), Content = "-" })
    xDTaraZ.UI.Labels.Survivor = status:AddParagraph({ Title = T("Survivor", "ผู้รอดชีวิต"), Content = "-" })
    xDTaraZ.UI.Labels.Killer = status:AddParagraph({ Title = T("Killer", "ฆาตกร"), Content = "-" })
    xDTaraZ.UI.Labels.Esp = status:AddParagraph({ Title = T("ESP", "ESP"), Content = "-" })
    xDTaraZ.UI.Labels.Shop = status:AddParagraph({ Title = T("Shop", "ร้านค้า"), Content = "-" })

    local panic = tab:AddLeftGroupbox(T("Quick", "ด่วน"), "bomb")
    panic:AddButton({ Text = T("Panic — all off", "ฉุกเฉิน ปิดทั้งหมด"), Style = "Danger", Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.FarmSaved = nil
        for _, toggle in pairs(Library.Toggles) do toggle:SetValue(false) end
    end) })

    local discord = tab:AddRightGroupbox(T("Discord", "ดิสคอร์ด"), "link")
    discord:AddLabel(xDTaraZ.Config.Discord)
    discord:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ดิสคอร์ด"), Func = xDTaraZ.UI.Detach(function()
        if Util.Copy(xDTaraZ.Config.Discord) then
            Library:Notify(T("Discord", "ดิสคอร์ด"), T("Link copied", "คัดลอกลิงก์แล้ว"), 3, "Success")
        else
            Library:Notify(T("Discord", "ดิสคอร์ด"), xDTaraZ.Config.Discord, 6, "Info")
        end
    end) })
end

xDTaraZ.UI.FarmKeys = {
    "AutoRepair", "PerfectSkillCheck", "AutoHeal", "AutoUnhook", "AutoDodge", "AutoSelfUnhook", "InstantEscape", "NoSlow",
    "KillAura", "AutoHook", "AutoBreakGens", "AntiStun", "AntiAfk",
}

xDTaraZ.UI.FarmSaved = nil

function xDTaraZ.UI.SetFarm(on)
    local options = Library.Options
    local tuned = { EscapeDelay = options.FarmEscapeAfter.Value, DodgeRadius = xDTaraZ.Config.FarmDodge }
    if on then
        if xDTaraZ.UI.FarmSaved then return end
        xDTaraZ.UI.FarmSaved = {}
        for key in pairs(tuned) do xDTaraZ.UI.FarmSaved[key] = options[key].Value end
        for _, key in ipairs(xDTaraZ.UI.FarmKeys) do xDTaraZ.UI.FarmSaved[key] = options[key].Value end
        for key, value in pairs(tuned) do options[key]:SetValue(value) end
        for _, key in ipairs(xDTaraZ.UI.FarmKeys) do options[key]:SetValue(true) end
        if options.FarmEscapeAfter.Value <= 0 then options.InstantEscape:SetValue(false) end
        return
    end
    local saved = xDTaraZ.UI.FarmSaved
    xDTaraZ.UI.FarmSaved = nil
    if not saved then return end
    for key, value in pairs(saved) do
        if options[key] then options[key]:SetValue(value) end
    end
end

function xDTaraZ.UI.BuildSurvivor(window)
    window:AddTabSection(T("Roles", "บทบาท"))
    local tab = window:AddTab(T("Survivor", "ผู้รอดชีวิต"), "heart", T("Generators, team and escape", "เครื่องปั่นไฟ ทีม และการหนี"))

    local work = tab:AddLeftGroupbox(T("Objectives", "ภารกิจ"), "gear")
    work:AddToggle("AutoRepair", { Text = T("Auto repair", "ซ่อมอัตโนมัติ"), Description = T("Repairs the best generator hands-free", "ซ่อมเครื่องที่ดีที่สุดให้เอง"), Risky = true })
    work:AddToggle("PerfectSkillCheck", { Text = T("Perfect skill checks", "สกิลเช็คผ่านทุกครั้ง") })
    work:AddToggle("AutoHeal", { Text = T("Auto heal teammates", "รักษาเพื่อนอัตโนมัติ"), Risky = true })
    work:AddToggle("AutoUnhook", { Text = T("Auto unhook teammates", "ปลดเพื่อนจากตะขอ"), Risky = true })

    local escape = tab:AddLeftGroupbox(T("Escape", "หนี"), "flag")
    escape:AddToggle("InstantEscape", { Text = T("Instant escape", "หนีออกทันที"), Description = T("Leaves the round without repairing anything", "ออกจากรอบโดยไม่ต้องซ่อม"), Risky = true })
    escape:AddSlider("EscapeDelay", { Text = T("Escape after", "หนีหลังเริ่มรอบ"), Min = 0, Max = 900, Default = 0, Suffix = "s" })
    escape:AddButton({ Text = T("Escape Now", "หนีออกตอนนี้"), Style = "Warning", Func = xDTaraZ.UI.Detach(function()
        if not xDTaraZ.Survivor.EscapeNow() then
            Library:Notify(T("Escape", "หนี"), T("No exit found this round", "ไม่พบทางออกในรอบนี้"), 3, "Warning")
        end
    end) })

    local safety = tab:AddRightGroupbox(T("Safety", "ความปลอดภัย"), "boo")
    safety:AddToggle("AutoDodge", { Text = T("Auto dodge killer", "หลบฆาตกรอัตโนมัติ"), Description = T("Teleports away when the killer gets close and keeps other jobs away from him", "วาร์ปหนีเมื่อฆาตกรเข้าใกล้ และไม่ไปทำงานใกล้ฆาตกร"), Risky = true })
    safety:AddSlider("DodgeRadius", { Text = T("Dodge distance", "ระยะหลบ"), Min = 6, Max = 40, Default = 20, Suffix = "m" })
    safety:AddToggle("AutoSelfUnhook", { Text = T("Auto self-unhook", "ปลดตัวเองจากตะขอ"), Risky = true })
    safety:AddToggle("AutoParry", { Text = T("Auto parry (beta)", "ปัดป้องอัตโนมัติ (beta)"), Description = T("Needs the Parrying Dagger equipped", "ต้องใส่ Parrying Dagger") })
    safety:AddToggle("NoParryCooldown", { Text = T("No parry cooldown (beta)", "ปัดป้องไม่มีคูลดาวน์ (beta)") })
    safety:AddToggle("KillerAlert", { Text = T("Killer alert", "เตือนฆาตกรเข้าใกล้") })
    safety:AddButton({ Text = T("Sacrifice Self", "สละชีพตัวเอง"), Style = "Danger", Func = xDTaraZ.UI.Detach(function()
        if not xDTaraZ.Survivor.Sacrifice() then
            Library:Notify(T("Sacrifice", "สละชีพ"), T("Only works as a survivor", "ใช้ได้ตอนเป็นผู้รอดเท่านั้น"), 3, "Warning")
        end
    end) })
end

function xDTaraZ.UI.BuildKiller(window)
    local tab = window:AddTab(T("Killer", "ฆาตกร"), "swords", T("Hunting and hooking", "ล่าและแขวน"))

    local hunt = tab:AddLeftGroupbox(T("Hunt", "ล่า"), "target")
    hunt:AddToggle("KillAura", { Text = T("Auto slash", "ฟันอัตโนมัติ"), Description = T("Rage jumps behind anyone in range, Legit only swings at whoever is in front of you", "Rage วาร์ปไปฟันทุกคนในระยะ / Legit ฟันเฉพาะคนตรงหน้า"), Risky = true })
    hunt:AddToggle("SmartHitbox", { Text = T("Smart hitbox", "ฮิตบ็อกซ์อัจฉริยะ"), Description = T("Legit swings still land on targets a few studs out of reach", "โหมด Legit ฟันโดนแม้เป้าอยู่เกินระยะนิดหน่อย"), Risky = true })
    hunt:AddDropdown("SlashMode", { Text = T("Slash mode", "โหมดฟัน"), Values = { "Rage", "Legit" }, Default = "Rage" })
    hunt:AddToggle("AutoHook", { Text = T("Auto carry + hook", "แบกและแขวนอัตโนมัติ"), Description = T("Picks up anyone downed and hooks them", "แบกคนล้มแล้วแขวนตะขอให้"), Risky = true })
    hunt:AddToggle("AutoBreakGens", { Text = T("Auto kick generators", "เตะเครื่องปั่นไฟอัตโนมัติ"), Description = T("Kicks the most repaired generator when nobody is in range", "เตะเครื่องที่ซ่อมไปเยอะสุดตอนไม่มีเป้า"), Risky = true })
    hunt:AddSlider("AuraRange", { Text = T("Range", "ระยะ"), Min = 10, Max = 500, Default = 500, Suffix = "m" })

    local defense = tab:AddRightGroupbox(T("Defense", "ป้องกัน"), "shield")
    defense:AddToggle("AntiStun", { Text = T("Anti pallet stun (beta)", "กันพาเลทสตัน (beta)") })
    defense:AddToggle("AntiBlind", { Text = T("Anti blind (beta)", "กันแสงไฟฉาย (beta)"), Description = T("Flashlights no longer blind you", "ไม่โดนไฟฉายแยงตา") })
    defense:AddToggle("FreeTurn", { Text = T("No turn limit", "หมุนตัวได้อิสระ"), Description = T("Keep turning while attacking or lunging", "หันตัวได้ตอนฟันและพุ่ง") })
end

function xDTaraZ.UI.BuildPlayer(window)
    window:AddTabSection(T("Player", "ผู้เล่น"))
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "player", T("Movement and world", "การเคลื่อนที่และโลก"))

    local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "zap")
    move:AddToggle("Speed", { Text = T("Speed", "วิ่งเร็ว"), Risky = true })
    move:AddSlider("SpeedValue", { Text = T("Walk speed", "ความเร็ว"), Min = 16, Max = 60, Default = 24 })
    move:AddToggle("NoSlow", { Text = T("No slow", "ไม่โดนสโลว์"), Description = T("Never drops below your normal run speed", "ความเร็วไม่ต่ำกว่าวิ่งปกติ") })
    move:AddToggle("NoFall", { Text = T("No fall (beta)", "ไม่เซตอนตก (beta)"), Description = T("No landing stumble after a drop", "ลงพื้นแล้วไม่เซ") })
    move:AddToggle("Noclip", { Text = T("Noclip", "เดินทะลุ") })
    move:AddToggle("InfiniteJump", { Text = T("Infinite jump", "กระโดดไม่จำกัด"), Description = T("Jump anywhere, even mid-air", "กระโดดได้ทุกที่ แม้กลางอากาศ") })

    local world = tab:AddRightGroupbox(T("World", "โลก"), "star")
    world:AddToggle("Fullbright", { Text = T("Fullbright", "สว่างทั้งแมพ") })
    world:AddToggle("AntiShake", { Text = T("Anti camera shake", "กันจอสั่น") })
    world:AddToggle("NoFog", { Text = T("No fog", "ไม่มีหมอก") })
    world:AddToggle("AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK"), Callback = xDTaraZ.UI.Detach(xDTaraZ.Player.AntiAfk.Arm) })
end

function xDTaraZ.UI.BuildShop(window)
    local tab = window:AddTab(T("Shop", "ร้านค้า"), "shop", T("Perks, items and killers", "เพิร์ค ไอเทม ฆาตกร"))

    local perks = tab:AddLeftGroupbox(T("Perks", "เพิร์ค"), "star")
    perks:AddToggle("AutoBuyPerks", { Text = T("Auto buy perks", "ซื้อเพิร์คอัตโนมัติ"), Description = T("Unlocks every perk you can afford with Gears", "ปลดล็อกเพิร์คทุกตัวที่ Gears พอ") })
    perks:AddToggle("AutoLevelPerks", { Text = T("Auto level perks", "อัปเลเวลเพิร์คอัตโนมัติ"), Description = T("Spends Screws to level owned perks", "ใช้ Screws อัปเลเวลเพิร์คที่มี") })
    perks:AddSlider("KeepScrews", { Text = T("Keep Screws", "เก็บ Screws ไว้"), Description = T("Never spends below this", "ไม่ใช้ต่ำกว่าจำนวนนี้"), Min = 0, Max = 20000, Default = 0 })
    perks:AddButton({ Text = T("Buy + Level Now", "ซื้อ + อัปตอนนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        local bought, leveled = xDTaraZ.Shop.Locked(xDTaraZ.Shop.BuyPerks), xDTaraZ.Shop.Locked(xDTaraZ.Shop.LevelPerks)
        Library:Notify(T("Perks", "เพิร์ค"), ("Bought %d, leveled %d"):format(bought, leveled), 4, "Success")
    end) })

    local store = tab:AddRightGroupbox(T("Items & Killers", "ไอเทมและฆาตกร"), "coin")
    local items = store:AddDropdown("ShopItems", { Text = T("Items", "ไอเทม"), Values = xDTaraZ.Shop.Names("Items"), Multi = true, Default = {}, AllowNull = true, Searchable = true })
    store:AddButton({ Text = T("Buy Selected Items", "ซื้อไอเทมที่เลือก"), Func = xDTaraZ.UI.Detach(function()
        Library:Notify(T("Shop", "ร้านค้า"), ("Bought %d items"):format(xDTaraZ.Shop.Locked(xDTaraZ.Shop.BuyList, "Item", items.Value)), 4, "Coin")
    end) })
    local killers = store:AddDropdown("ShopKillers", { Text = T("Killers", "ฆาตกร"), Values = xDTaraZ.Shop.Names("Killers"), Multi = true, Default = {}, AllowNull = true, Searchable = true })
    store:AddButton({ Text = T("Buy Selected Killers", "ซื้อฆาตกรที่เลือก"), Func = xDTaraZ.UI.Detach(function()
        Library:Notify(T("Shop", "ร้านค้า"), ("Bought %d killers"):format(xDTaraZ.Shop.Locked(xDTaraZ.Shop.BuyList, "Killer", killers.Value)), 4, "Coin")
    end) })
end

function xDTaraZ.UI.BuildTeleport(window)
    local tab = window:AddTab(T("Teleport", "วาร์ป"), "pipe", T("Jump anywhere on the map", "วาร์ปไปทุกจุดในแมพ"))
    local box = tab:AddLeftGroupbox(T("Teleport", "วาร์ป"), "pipe")
    local places = box:AddDropdown("TeleportTarget", { Text = T("Destination", "ปลายทาง"), Values = xDTaraZ.Teleport.Places(), Default = "Nearest Generator", Searchable = true })
    box:AddButton({ Text = T("Teleport Now", "วาร์ปตอนนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        if not xDTaraZ.Teleport.Go(places.Value) then
            Library:Notify(T("Teleport", "วาร์ป"), T("Destination not found this round", "ไม่พบปลายทางในรอบนี้"), 3, "Warning")
        end
    end) })
    box:AddButton({ Text = T("Refresh list", "รีเฟรชรายการ"), Func = xDTaraZ.UI.Detach(function()
        places:SetValues(xDTaraZ.Teleport.Places())
    end) })
end

function xDTaraZ.UI.BuildVisuals(window)
    window:AddTabSection(T("Visuals", "การมองเห็น"))
    local tab = window:AddVisualsTab({ Provider = xDTaraZ.Esp.Targets, Preview = true })
    local objects = tab:AddRightGroupbox(T("Objects", "วัตถุ"), "eye")
    objects:AddToggle("EspGenerators", { Text = T("Generators + progress", "เครื่องปั่นไฟ + ความคืบหน้า") })
    objects:AddToggle("EspHooks", { Text = T("Hooks", "ตะขอ") })
    objects:AddToggle("EspGates", { Text = T("Exit gates", "ประตูทางออก") })
    objects:AddToggle("EspPallets", { Text = T("Pallets", "พาเลท") })
    objects:AddToggle("EspWindows", { Text = T("Windows", "หน้าต่าง") })
end

function xDTaraZ.UI.RefreshStatus()
    local labels = xDTaraZ.UI.Labels
    if labels.Role then
        local dist = xDTaraZ.Alert.Distance
        labels.Role:SetText((xDTaraZ.Player.Role() or "-") .. " · gens left " .. xDTaraZ.Map.GensLeft() .. (dist and (" · killer %dm"):format(dist) or ""))
    end
    if labels.Survivor then
        labels.Survivor:SetText(("%s · checks %d · dodges %d · escapes %d"):format(xDTaraZ.Survivor.Status, xDTaraZ.SkillCheck.Checks, xDTaraZ.Guard.Dodges, xDTaraZ.Survivor.Escapes))
    end
    if labels.Killer then labels.Killer:SetText(xDTaraZ.Killer.Status .. " · stuns dodged " .. xDTaraZ.AntiStun.Count) end
    if labels.Esp then labels.Esp:SetText(xDTaraZ.Esp.GetStatus()) end
    if labels.Shop then labels.Shop:SetText(xDTaraZ.Shop.Status) end

end

function xDTaraZ.UI.Build()
    local window = Library.Window
    xDTaraZ.UI.BuildMain(window)
    xDTaraZ.UI.BuildSurvivor(window)
    xDTaraZ.UI.BuildKiller(window)
    xDTaraZ.UI.BuildPlayer(window)
    xDTaraZ.UI.BuildTeleport(window)
    xDTaraZ.UI.BuildShop(window)
    xDTaraZ.UI.BuildVisuals(window)
    window:AddTabSection(T("Other", "อื่นๆ"))
    window:AddSettingsTab()

    for key in pairs(xDTaraZ.Options) do
        local widget = Library.Options[key] or Library.Toggles[key]
        if widget then xDTaraZ.UI.Bind(widget, key) end
    end
end

local function BuildInterface()
    Library = loadstring(Util.HttpGet(xDTaraZ.Config.UiSource))()
    xDTaraZ.Library = Library
    T = function(en, th) return Library:T(en, th) end
    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Violence District by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = xDTaraZ.Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        Intro = xDTaraZ.Config.Intro,
        OnUnlocked = function()
            xDTaraZ.UI.Build()
            task.defer(xDTaraZ.Boot)
            Library:Every(xDTaraZ.Config.StatusInterval, xDTaraZ.UI.RefreshStatus)
            task.defer(function() Library:LoadAutoloadConfig() end)
        end,
    })
    Library:OnUnload(function()
        xDTaraZ:Unload()
    end)
end

function xDTaraZ.Boot()
    xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(character)
        xDTaraZ.Survivor.Job = nil
        xDTaraZ.Movement.Release()
        xDTaraZ.Player:Bind(character)
    end)

    xDTaraZ.Movement.Start()
    xDTaraZ.SkillCheck.Start()
    xDTaraZ.AntiStun.Start()

    xDTaraZ.Scheduler.Every("Survivor", xDTaraZ.Config.RepairTick, xDTaraZ.Survivor.Step)
    xDTaraZ.Scheduler.Every("Guard", xDTaraZ.Config.GuardTick, xDTaraZ.Guard.Step)
    xDTaraZ.Scheduler.Every("Block", 1, xDTaraZ.Block.Step)
    xDTaraZ.Scheduler.Every("Parry", xDTaraZ.Config.GuardTick, xDTaraZ.Parry.Step)
    xDTaraZ.Scheduler.Every("Killer", 0.1, xDTaraZ.Killer.Step)
    xDTaraZ.Scheduler.Every("World", 0.5, xDTaraZ.World.Step)
    xDTaraZ.Scheduler.Every("Role", 3, xDTaraZ.Role.Step)
    xDTaraZ.Scheduler.Every("Alert", 0.5, xDTaraZ.Alert.Step)
    xDTaraZ.Scheduler.Every("Shop", xDTaraZ.Config.ShopInterval, xDTaraZ.Shop.Step)
    xDTaraZ.Scheduler.Every("ObjectEsp", xDTaraZ.Config.ObjectEspRefresh, xDTaraZ.Esp.Step)
    xDTaraZ.Scheduler.Boot()
end

function xDTaraZ:Unload()
    self.State.Alive = false
    table.clear(xDTaraZ.Scheduler.Jobs)
    xDTaraZ.Survivor.Finish()
    xDTaraZ.Block.Release()
    xDTaraZ.Movement.Release()
    xDTaraZ.World.Restore()
    xDTaraZ.Esp.Clear()
    for _, connection in ipairs(self.State.Connections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(self.State.Connections)
end

environment.ViolenceDistrictUnload = function()
    if xDTaraZ.Library and not xDTaraZ.Library.Unloaded then
        xDTaraZ.Library:Unload()
    else
        xDTaraZ:Unload()
    end
end

if LocalPlayer.Character then
    xDTaraZ.Player:Bind(LocalPlayer.Character)
end

BuildInterface()