if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local environment = getgenv and getgenv() or _G
if type(environment.SniperArenaUnload) == "function" then
    pcall(environment.SniperArenaUnload)
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local vector3New, cframeNew = Vector3.new, CFrame.new
local vectorZero = Vector3.zero
local osClock, mathHuge = os.clock, math.huge

if game.GameId ~= 9534705677 then
    LocalPlayer:Kick("Mario Hub: this script is for Sniper Arena only")
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
    SaveFolder = "Sniper Arena",
    Intro = true,
    LoadTimeout = 10,
    EconomyInterval = 1,
    StatusInterval = 1,
    OpenDelay = 0.6,
    SellDelay = 0.8,
    ClaimDelay = 0.5,
    FireInterval = 0.12,
    TriggerRange = 2000,
    RespawnRetry = 1,
    FlagRetry = 1,
    JoinRetry = 3,
    FarmMinDash = 14,
    AimRenderPriority = Enum.RenderPriority.Camera.Value + 5,
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Status = "Idle",
}

xDTaraZ.Options = {
    AntiAfk = false,

    Speed = false,
    SpeedValue = 32,
    Jump = false,
    JumpValue = 60,
    Fly = false,
    Noclip = false,
    InfiniteJump = false,
    InfiniteDash = false,
    AutoFlag = false,
    AutoFarm = false,

    AutoOpenCases = false,
    OpenCount = 1,
    AutoSell = false,
    SellRarities = {},
    MaxSellPrice = 500,
    KeepPerRarity = 0,
    AutoClaimQuest = false,

    Aimbot = false,
    AimMode = "Hold",
    TriggerBot = false,
    KillAura = false,
    NoRecoil = false,
    NoSpread = false,
    AimTeamCheck = true,
    AimWallCheck = true,
    AimSmooth = 1,
    AimPrediction = 0,
    ShowFov = false,
    AimFov = 150,
    AimPriority = "Crosshair",
    AimMaxDistance = 1000,
    AimBone = "Head",
}

xDTaraZ.Util = {}
local Util = xDTaraZ.Util

---@return function?  first argument that is callable
local function Resolve(...)
    for index = 1, select("#", ...) do
        local candidate = select(index, ...)
        if type(candidate) == "function" then
            return candidate
        end
    end
    return nil
end

Util.Request = Resolve(request, http_request, syn and syn.request, http and http.request)
Util.SetClipboard = Resolve(setclipboard, toclipboard)
Util.QueueTeleport = Resolve(queue_on_teleport, queueonteleport, syn and syn.queue_on_teleport)
Util.GetHui = Resolve(gethui, get_hidden_gui)
Util.WriteFile = Resolve(writefile)
Util.ReadFile = Resolve(readfile)
Util.IsFile = Resolve(isfile)
Util.GetGc = Resolve(getgc, get_gc_objects)
Util.HookMeta = Resolve(hookmetamethod)
Util.GetConnections = Resolve(getconnections, get_signal_cons)
Util.HookFunction = Resolve(hookfunction, replaceclosure)
Util.RestoreFunction = Resolve(restorefunction)
Util.FireTouch = Resolve(firetouchinterest)
xDTaraZ.Caps = {
    Hook = Util.HookMeta ~= nil,
    HookFunction = Util.HookFunction ~= nil,
    Connections = Util.GetConnections ~= nil,
    Gc = Util.GetGc ~= nil,
    Drawing = type(Drawing) == "table" and type(Drawing.new) == "function",
    FileSystem = Util.WriteFile ~= nil and Util.ReadFile ~= nil,
    Clipboard = Util.SetClipboard ~= nil,
    QueueTeleport = Util.QueueTeleport ~= nil,
}

---@return string  response body, throws if every transport fails
function Util.HttpGet(url)
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if ok and type(body) == "string" then
        return body
    end
    if Util.Request then
        local response = Util.Request({ Url = url, Method = "GET" })
        if type(response) == "table" and type(response.Body) == "string" then
            return response.Body
        end
    end
    error("HttpGet failed: " .. url)
end

function Util.Copy(text)
    if Util.SetClipboard then
        Util.SetClipboard(text)
        return true
    end
    return false
end

function Util.Hui()
    if Util.GetHui then
        local ok, gui = pcall(Util.GetHui)
        if ok and gui then return gui end
    end
    return LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
end

function Util.FormatNumber(value)
    local text = tostring(math.floor(value or 0))
    local formatted = text:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    return (formatted:gsub("^,", ""))
end

---@return string[]  sorted keys, stable dropdown order
function Util.SortedKeys(map)
    local keys = {}
    for key in pairs(map or {}) do
        keys[#keys + 1] = tostring(key)
    end
    table.sort(keys)
    return keys
end

function Util.SetFromList(list)
    local set = {}
    for key, value in pairs(list or {}) do
        if type(key) == "number" then
            set[value] = true
        elseif value then
            set[key] = true
        end
    end
    return set
end

function xDTaraZ:Connect(signal, handler)
    local connection = signal:Connect(handler)
    table.insert(self.State.Connections, connection)
    return connection
end

function xDTaraZ:SetStatus(text)
    self.State.Status = text
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
    return setmetatable({ Handlers = {} }, Signal)
end

function Signal:Connect(handler)
    table.insert(self.Handlers, handler)
    return {
        Disconnect = function()
            local index = table.find(self.Handlers, handler)
            if index then table.remove(self.Handlers, index) end
        end,
    }
end

function Signal:Fire(...)
    for _, handler in ipairs(table.clone(self.Handlers)) do
        task.spawn(handler, ...)
    end
end

xDTaraZ.Signal = Signal

xDTaraZ.GameLib = { Config = {}, Service = {} }
local GameLib = xDTaraZ.GameLib

local function RequireChild(parent, name)
    local child = parent and parent:FindFirstChild(name)
    if not child then return nil end
    local ok, module = pcall(require, child)
    if not ok then
        warn("[SniperArena] require " .. name .. ": " .. tostring(module))
        return nil
    end
    return module
end

do
    local configFolder = ReplicatedStorage:FindFirstChild("Config")
    local remoteFolder = ReplicatedStorage:FindFirstChild("Remote")
    local constantFolder = ReplicatedStorage:FindFirstChild("Constant")

    local configNames = {
        "Config", "WeaponConfig", "GachaConfig", "WeaponCraftConfig", "WeaponSellConfig",
        "RewardsConfig", "BattlepassConfig", "RankingConfig", "QuestConfig", "SpinConfig",
        "RaffleConfig", "ShopConfig", "CustomShopConfig", "AuctionConfig", "ItemConfig",
        "CollectionRewardConfig", "CashPendingConfig", "MinipassConfig", "WrapConfig",
    }
    for _, name in ipairs(configNames) do
        GameLib.Config[name] = RequireChild(configFolder, name)
    end

    local serviceNames = {
        "StatusService", "GachaService", "WeaponService", "QuestService", "EntityService",
        "CombatService", "GameService", "BattlepassService", "RaffleService",
    }
    for _, name in ipairs(serviceNames) do
        GameLib.Service[name] = RequireChild(remoteFolder, name)
    end
    GameLib.CameraController = RequireChild(ReplicatedStorage:FindFirstChild("Client"), "CameraController")
    local gameService = remoteFolder and remoteFolder:FindFirstChild("GameService")
    GameLib.RoomManager = RequireChild(gameService, "RoomManager")
    GameLib.Any = RequireChild(remoteFolder, "Any")
    GameLib.Status = RequireChild(constantFolder, "Status")
    GameLib.Constant = constantFolder
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

---@return number  server-side status counter, 0 when unavailable
function xDTaraZ.Player:Status(key)
    local service = GameLib.Service.StatusService
    if not service or not key then return 0 end
    local ok, value = pcall(function() return service.GetStatus(key) end)
    return ok and tonumber(value) or 0
end

function xDTaraZ.Player:Coin()
    local key = GameLib.Status and GameLib.Status.Eco_Coin or "Eco_Coin"
    return self:Status(key)
end

xDTaraZ.Entity = {}

function xDTaraZ.Entity.Service()
    return GameLib.Service.EntityService
end

---@return table  focused combatant entities (empty in lobby / combat paused)
function xDTaraZ.Entity.List()
    local service = xDTaraZ.Entity.Service()
    if not service then return {} end
    local ok, focused = pcall(function() return service.WorldManager:GetFocusedEntities() end)
    if not ok or type(focused) ~= "table" then return {} end
    return focused._items or focused.Items or focused
end

function xDTaraZ.Entity.Local()
    local service = xDTaraZ.Entity.Service()
    if not service then return nil end
    local ok, entity = pcall(function() return service.GetLocalEntity() end)
    if ok and entity then return entity end
    ok, entity = pcall(function() return service:GetLocalEntity() end)
    return ok and entity or nil
end

local function TryCall(object, method)
    if type(object) ~= "table" and typeof(object) ~= "Instance" then return nil, false end
    local fn = object[method]
    if type(fn) ~= "function" then return nil, false end
    local ok, value = pcall(fn, object)
    if ok then return value, true end
    return nil, false
end

function xDTaraZ.Entity.IsLocal(entity)
    local value, called = TryCall(entity, "IsLocalEntity")
    if called then return value == true end
    return entity == xDTaraZ.Entity.Local()
end

---@return string?  per-round team tag, unique per player in FFA/Duel
function xDTaraZ.Entity.Team(entity)
    local inst = entity and entity.Instance
    if typeof(inst) == "Instance" then
        local team = inst:GetAttribute("Team")
        if team ~= nil then return tostring(team) end
    end
    local char = xDTaraZ.Entity.Character(entity)
    local team = char and char:GetAttribute("Team")
    return team ~= nil and tostring(team) or nil
end

function xDTaraZ.Entity.Friendly(entity)
    local char = xDTaraZ.Entity.Character(entity)
    local marks = Workspace:FindFirstChild("Highlight")
    if char and marks then
        local friendly = marks:FindFirstChild("Friendly")
        if friendly and char:IsDescendantOf(friendly) then return true end
        if char:IsDescendantOf(marks) then return false end
    end

    if xDTaraZ.Match.ModeSet() ~= "TDM" then return false end
    local mine = xDTaraZ.Entity.Team(xDTaraZ.Entity.Local())
    local theirs = xDTaraZ.Entity.Team(entity)
    return mine ~= nil and mine == theirs
end

function xDTaraZ.Entity.Health(entity)
    if not entity then return 0, 0 end
    local health = entity.Health or select(1, TryCall(entity, "GetHealth")) or 0
    local maxHealth = entity.MaxHealth or select(1, TryCall(entity, "GetMaxHealth")) or 0
    return health, maxHealth
end

function xDTaraZ.Entity.Character(entity)
    local humanoid = entity and entity.Humanoid
    if humanoid and humanoid.Parent then return humanoid.Parent end
    return entity and entity.Character or nil
end

function xDTaraZ.Entity.Root(entity)
    local character = xDTaraZ.Entity.Character(entity)
    if not character then return nil end
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head") or character.PrimaryPart
end

xDTaraZ.Match = {}

---@return string?, string?  mode, map — nil outside a room
function xDTaraZ.Match.Info()
    local rooms = GameLib.RoomManager
    local ok, room = pcall(function() return rooms and rooms.GetFocusedRoom() end)
    if not ok or type(room) ~= "table" then return nil, nil end
    return room.Mode, room.Map
end

---@return string?  FFA / TDM / Duel / Boss
function xDTaraZ.Match.ModeSet()
    local rooms = GameLib.RoomManager
    local ok, room = pcall(function() return rooms and rooms.GetFocusedRoom() end)
    return ok and type(room) == "table" and room.ModeSet or nil
end

function xDTaraZ.Match.InRound()
    return LocalPlayer:GetAttribute("combatPaused") == false
end
xDTaraZ.Scheduler = { Jobs = {}, Booted = false }

function xDTaraZ.Scheduler.Every(name, interval, fn)
    xDTaraZ.Scheduler.Jobs[name] = { Interval = interval, Fn = fn, Last = 0, Running = false }
end

function xDTaraZ.Scheduler.Step()
    local now = osClock()
    for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
        if not job.Running and now - job.Last >= job.Interval then
            job.Last = now
            job.Running = true
            task.spawn(function()
                local ok, err = pcall(job.Fn)
                job.Running = false
                if not ok then
                    warn("[SniperArena] job " .. name .. ": " .. tostring(err))
                end
            end)
        end
    end
end

function xDTaraZ.Scheduler.Boot()
    if xDTaraZ.Scheduler.Booted then return end
    xDTaraZ.Scheduler.Booted = true
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Scheduler.Step)
end

xDTaraZ.Player.AntiAfk = { Connection = nil, Status = "Off" }

function xDTaraZ.Player.AntiAfk.OnIdled()
    if not xDTaraZ.Options.AntiAfk then return end
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.zero)
end

function xDTaraZ.Player.AntiAfk.Start()
    xDTaraZ.Options.AntiAfk = true
    if not xDTaraZ.Player.AntiAfk.Connection then
        xDTaraZ.Player.AntiAfk.Connection = xDTaraZ:Connect(LocalPlayer.Idled, xDTaraZ.Player.AntiAfk.OnIdled)
    end
    xDTaraZ.Player.AntiAfk.Status = "Armed"
end

function xDTaraZ.Player.AntiAfk.Stop()
    xDTaraZ.Options.AntiAfk = false
    xDTaraZ.Player.AntiAfk.Status = "Off"
end

function xDTaraZ.Player.AntiAfk.Step()
    if xDTaraZ.Options.AntiAfk and not xDTaraZ.Player.AntiAfk.Connection then
        xDTaraZ.Player.AntiAfk.Connection = xDTaraZ:Connect(LocalPlayer.Idled, xDTaraZ.Player.AntiAfk.OnIdled)
    end
end

function xDTaraZ.Player.AntiAfk.GetStatus()
    return xDTaraZ.Player.AntiAfk.Status
end

xDTaraZ.Player.Respawn = { Status = "Off", Count = 0, LastFire = 0 }

function xDTaraZ.Player.Respawn.IsDead()
    local state = LocalPlayer:GetAttribute("State")
    if state == "Dead" or state == "Died" then return true end
    local humanoid = xDTaraZ.Player.Humanoid
    return humanoid ~= nil and humanoid.Health <= 0
end

function xDTaraZ.Player.Respawn.Fire()
    local gs = xDTaraZ.GameLib.Service.GameService
    if gs and gs.FastRespawn then pcall(gs.FastRespawn) end
    local remote = xDTaraZ.GameLib.Service.GameService and ReplicatedStorage.Remote.GameService:FindFirstChild("Respawn")
    if remote then pcall(function() remote:FireServer() end) end
end

function xDTaraZ.Player.Respawn.Step()
    if not xDTaraZ.Options.AutoRespawn then
        xDTaraZ.Player.Respawn.Status = "Off"
        return
    end
    local gs = xDTaraZ.GameLib.Service.GameService
    if not (gs and gs.IsJoined and gs.IsJoined()) then
        xDTaraZ.Player.Respawn.Status = "Not in game"
        return
    end
    if not xDTaraZ.Player.Respawn.IsDead() then
        xDTaraZ.Player.Respawn.Status = "Alive · respawns " .. xDTaraZ.Player.Respawn.Count
        return
    end

    local now = os.clock()
    if now - xDTaraZ.Player.Respawn.LastFire < xDTaraZ.Config.RespawnRetry then
        xDTaraZ.Player.Respawn.Status = "Respawning"
        return
    end
    xDTaraZ.Player.Respawn.LastFire = now
    xDTaraZ.Player.Respawn.Count += 1
    xDTaraZ.Player.Respawn.Fire()
    xDTaraZ.Player.Respawn.Status = "Respawning"
end

function xDTaraZ.Player.Respawn.GetStatus()
    return xDTaraZ.Player.Respawn.Status
end

xDTaraZ.Movement = {
    Booted = false,
    Status = "Off",
    OriginalWalk = nil,
    OriginalJump = nil,
    OriginalPlatform = nil,
    Collide = {},
    FlyKeys = {
        [Enum.KeyCode.W] = "Forward", [Enum.KeyCode.S] = "Back",
        [Enum.KeyCode.A] = "Left", [Enum.KeyCode.D] = "Right",
        [Enum.KeyCode.Space] = "Up", [Enum.KeyCode.LeftControl] = "Down",
    },
}

---@return table?, Humanoid?  local combat entity and character humanoid
local function LocalRig()
    local entity = xDTaraZ.Entity.Local()
    local humanoid = xDTaraZ.Player.Humanoid
    return entity, humanoid
end

function xDTaraZ.Movement.ApplySpeed(entity, humanoid)
    local target = xDTaraZ.Options.SpeedValue
    if entity then
        if xDTaraZ.Movement.OriginalWalk == nil then
            xDTaraZ.Movement.OriginalWalk = entity.WalkSpeed or entity.CurrentWalkSpeed
        end
        entity.CurrentWalkSpeed = target
        if type(entity.WalkSpeedMultipliers) == "table" then
            entity.WalkSpeedMultipliers.MarioHub = target / math.max(entity.WalkSpeed or target, 1)
        end
    end
    if humanoid then
        humanoid.WalkSpeed = target
    end
end

function xDTaraZ.Movement.RestoreSpeed()
    local entity, humanoid = LocalRig()
    if entity then
        entity.CurrentWalkSpeed = entity.WalkSpeed or xDTaraZ.Movement.OriginalWalk or 16
        if type(entity.WalkSpeedMultipliers) == "table" then
            entity.WalkSpeedMultipliers.MarioHub = nil
        end
    end
    if humanoid then
        humanoid.WalkSpeed = xDTaraZ.Movement.OriginalWalk or 16
    end
    xDTaraZ.Movement.OriginalWalk = nil
end

function xDTaraZ.Movement.ApplyJump(entity, humanoid)
    local target = xDTaraZ.Options.JumpValue
    if entity then
        if xDTaraZ.Movement.OriginalJump == nil then
            xDTaraZ.Movement.OriginalJump = entity.JumpHeight
        end
        entity.JumpHeight = target
    end
    if humanoid then
        humanoid.UseJumpPower = false
        humanoid.JumpHeight = target
    end
end

function xDTaraZ.Movement.RestoreJump()
    local entity, humanoid = LocalRig()
    if entity and xDTaraZ.Movement.OriginalJump ~= nil then
        entity.JumpHeight = xDTaraZ.Movement.OriginalJump
    end
    if humanoid and xDTaraZ.Movement.OriginalJump ~= nil then
        humanoid.JumpHeight = xDTaraZ.Movement.OriginalJump
    end
    xDTaraZ.Movement.OriginalJump = nil
end

function xDTaraZ.Movement.ApplyNoclip()
    local character = xDTaraZ.Player.Character
    if not character then return end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            if xDTaraZ.Movement.Collide[part] == nil then
                xDTaraZ.Movement.Collide[part] = true
            end
            part.CanCollide = false
        end
    end
end

function xDTaraZ.Movement.RestoreNoclip()
    for part in pairs(xDTaraZ.Movement.Collide) do
        if part and part.Parent then
            part.CanCollide = true
        end
    end
    table.clear(xDTaraZ.Movement.Collide)
end

function xDTaraZ.Movement.FlyVelocity()
    local root = xDTaraZ.Player.Root
    local camera = Workspace.CurrentCamera
    if not root or not camera then return end

    local direction = vectorZero
    for key, tag in pairs(xDTaraZ.Movement.FlyKeys) do
        if UserInputService:IsKeyDown(key) then
            if tag == "Forward" then direction += camera.CFrame.LookVector
            elseif tag == "Back" then direction -= camera.CFrame.LookVector
            elseif tag == "Left" then direction -= camera.CFrame.RightVector
            elseif tag == "Right" then direction += camera.CFrame.RightVector
            elseif tag == "Up" then direction += Vector3.yAxis
            elseif tag == "Down" then direction -= Vector3.yAxis
            end
        end
    end

    if direction.Magnitude > 0 then
        direction = direction.Unit * xDTaraZ.Options.FlySpeed
    end
    root.AssemblyLinearVelocity = direction
end

function xDTaraZ.Movement.SetFly(on)
    local humanoid = xDTaraZ.Player.Humanoid
    if on then
        if humanoid and xDTaraZ.Movement.OriginalPlatform == nil then
            xDTaraZ.Movement.OriginalPlatform = humanoid.PlatformStand
            humanoid.PlatformStand = true
        end
    else
        if humanoid and xDTaraZ.Movement.OriginalPlatform ~= nil then
            humanoid.PlatformStand = xDTaraZ.Movement.OriginalPlatform
        end
        xDTaraZ.Movement.OriginalPlatform = nil
        if xDTaraZ.Player.Root then
            xDTaraZ.Player.Root.AssemblyLinearVelocity = vectorZero
        end
    end
    xDTaraZ.Options.Fly = on
end

function xDTaraZ.Movement.DashHelper()
    if xDTaraZ.Movement.Dash ~= nil then return xDTaraZ.Movement.Dash end
    local client = ReplicatedStorage:FindFirstChild("Client")
    local helper = client and client:FindFirstChild("CombatHelper")
    local dash = helper and helper:FindFirstChild("Dash")
    local ok, module = pcall(require, dash)
    xDTaraZ.Movement.Dash = ok and module or false
    return xDTaraZ.Movement.Dash
end

function xDTaraZ.Movement.RefreshDash()
    local dash = xDTaraZ.Movement.DashHelper()
    if dash and dash.RefreshNextDashTime then
        pcall(dash.RefreshNextDashTime)
    end
end

function xDTaraZ.Movement.OnStepped()
    if not xDTaraZ.Player:IsAlive() then return end
    local entity, humanoid = LocalRig()

    if xDTaraZ.Options.Speed then xDTaraZ.Movement.ApplySpeed(entity, humanoid) end
    if xDTaraZ.Options.Jump then xDTaraZ.Movement.ApplyJump(entity, humanoid) end
    if xDTaraZ.Options.Noclip then xDTaraZ.Movement.ApplyNoclip() end
    if xDTaraZ.Options.Fly then xDTaraZ.Movement.FlyVelocity() end
    if xDTaraZ.Options.InfiniteDash then xDTaraZ.Movement.RefreshDash() end
end

function xDTaraZ.Movement.OnJumpRequest()
    if not xDTaraZ.Options.InfiniteJump then return end
    local humanoid = xDTaraZ.Player.Humanoid
    if humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

function xDTaraZ.Movement.SetSpeed(on)
    xDTaraZ.Options.Speed = on
    if not on then xDTaraZ.Movement.RestoreSpeed() end
end

function xDTaraZ.Movement.SetJump(on)
    xDTaraZ.Options.Jump = on
    if not on then xDTaraZ.Movement.RestoreJump() end
end

function xDTaraZ.Movement.SetNoclip(on)
    xDTaraZ.Options.Noclip = on
    if not on then xDTaraZ.Movement.RestoreNoclip() end
end

function xDTaraZ.Movement.Start()
    if xDTaraZ.Movement.Booted then return end
    xDTaraZ.Movement.Booted = true
    xDTaraZ:Connect(RunService.Stepped, xDTaraZ.Movement.OnStepped)
    xDTaraZ:Connect(UserInputService.JumpRequest, xDTaraZ.Movement.OnJumpRequest)
end

function xDTaraZ.Movement.Release()
    xDTaraZ.Movement.RestoreSpeed()
    xDTaraZ.Movement.RestoreJump()
    xDTaraZ.Movement.RestoreNoclip()
    xDTaraZ.Movement.SetFly(false)
    xDTaraZ.Options.Speed = false
    xDTaraZ.Options.Jump = false
    xDTaraZ.Options.Noclip = false
    xDTaraZ.Options.InfiniteJump = false
    xDTaraZ.Options.InfiniteDash = false
end

function xDTaraZ.Movement.Stop()
    xDTaraZ.Movement.Release()
    xDTaraZ.Movement.Status = "Off"
end

function xDTaraZ.Movement.GetStatus()
    local active = {}
    if xDTaraZ.Options.Fly then active[#active + 1] = "Fly" end
    if xDTaraZ.Options.Speed then active[#active + 1] = "Speed " .. xDTaraZ.Options.SpeedValue end
    if xDTaraZ.Options.Jump then active[#active + 1] = "Jump" end
    if xDTaraZ.Options.Noclip then active[#active + 1] = "Noclip" end
    if xDTaraZ.Options.InfiniteJump then active[#active + 1] = "InfJump" end
    if xDTaraZ.Options.InfiniteDash then active[#active + 1] = "InfDash" end
    xDTaraZ.Movement.Status = #active > 0 and table.concat(active, ", ") or "Off"
    return xDTaraZ.Movement.Status
end

function xDTaraZ.Movement.Step()
    return xDTaraZ.Movement.GetStatus()
end

xDTaraZ.Esp = { Count = 0 }

---@return table[]  targets in the shape Library.Visuals expects
function xDTaraZ.Esp.Targets()
    local list = {}
    for _, entity in pairs(xDTaraZ.Entity.List()) do
        if type(entity) ~= "table" or xDTaraZ.Entity.IsLocal(entity) then continue end
        local char = xDTaraZ.Entity.Character(entity)
        local health, maxHealth = xDTaraZ.Entity.Health(entity)
        if not char or health <= 0 then continue end
        list[#list + 1] = {
            Model = char,
            Name = char.Name,
            Health = health,
            MaxHealth = maxHealth > 0 and maxHealth or 100,
            Friendly = xDTaraZ.Entity.Friendly(entity),
            Root = xDTaraZ.Entity.Root(entity),
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

local GameLib = xDTaraZ.GameLib

---@return table?  replicated client store for a Remote service
local function StoreData(service)
    if not service then return nil end
    local ok, store = pcall(function() return service.GetData() end)
    if ok and type(store) == "table" then return store end
    if type(service.Data) == "table" then return service.Data end
    ok, store = pcall(function() return service:GetData() end)
    return ok and type(store) == "table" and store or nil
end

xDTaraZ.Shop = { Status = "Off", LastResult = "" }

---@return string[]  case keys the player actually owns (from the gacha store)
function xDTaraZ.Shop.Cases()
    local service = GameLib.Service.GachaService
    local store = service and service.LocalGachaStore
    local data = store and store.Data
    if type(data) ~= "table" then return {} end
    local keys = {}
    for key, entry in pairs(data) do
        local owned = type(entry) == "table" and entry.Owned or entry
        if tonumber(owned) and owned > 0 then keys[#keys + 1] = tostring(key) end
    end
    table.sort(keys)
    return keys
end

function xDTaraZ.Shop.Owned(caseKey)
    local service = GameLib.Service.GachaService
    if not service then return 0 end
    local ok, owned = pcall(function() return service.GetGachaCount(caseKey) end)
    return ok and tonumber(owned) or 0
end

---@return boolean, string  server-authoritative roll result
function xDTaraZ.Shop.Open(caseKey, count)
    local service = GameLib.Service.GachaService
    if not service then return false, "no service" end
    count = math.min(count, xDTaraZ.Shop.Owned(caseKey))
    if count < 1 then return false, "none owned" end
    local ok, roll = pcall(function() return service.Gacha(caseKey, count) end)
    if not ok then return false, tostring(roll) end
    return true, string.format("%s x%d", caseKey, count)
end

function xDTaraZ.Shop.OpenAllNow()
    local opened = 0
    for _, caseKey in ipairs(xDTaraZ.Shop.Cases()) do
        local owned = xDTaraZ.Shop.Owned(caseKey)
        if owned > 0 then
            local ok = xDTaraZ.Shop.Open(caseKey, math.min(owned, math.max(xDTaraZ.Options.OpenCount, 1)))
            if ok then opened += 1 end
            task.wait(xDTaraZ.Config.OpenDelay)
        end
    end
    xDTaraZ.Shop.LastResult = opened > 0 and (opened .. " cases opened") or "no owned cases"
    return xDTaraZ.Shop.LastResult
end

function xDTaraZ.Shop.Start() xDTaraZ.Options.AutoOpenCases = true end
function xDTaraZ.Shop.Stop() xDTaraZ.Options.AutoOpenCases = false end

function xDTaraZ.Shop.Step()
    if not xDTaraZ.Options.AutoOpenCases then xDTaraZ.Shop.Status = "Off" return end
    xDTaraZ.Shop.Status = "Opening owned cases"
    xDTaraZ.Shop.OpenAllNow()
end

function xDTaraZ.Shop.GetStatus()
    return xDTaraZ.Options.AutoOpenCases and xDTaraZ.Shop.Status or "Off"
end

xDTaraZ.Sell = { Status = "Off", LastResult = "" }

---@return string?  skin rarity from WrapConfig, nil for base/unknown skins
function xDTaraZ.Sell.RarityOf(weaponName)
    local skin = tostring(weaponName):match("%.(.+)$")
    local wraps = GameLib.Config.WrapConfig
    local entry = skin and type(wraps) == "table" and wraps[skin]
    return type(entry) == "table" and entry.Rarity or nil
end

---@return string[]  rarity names present in WrapConfig
function xDTaraZ.Sell.Rarities()
    local wraps = GameLib.Config.WrapConfig
    if type(wraps) ~= "table" then return {} end
    local seen = {}
    for _, entry in pairs(wraps) do
        if type(entry) == "table" and entry.Rarity then seen[tostring(entry.Rarity)] = true end
    end
    return Util.SortedKeys(seen)
end

---@return table[]  owned weapons with uid, rarity, price, wear
function xDTaraZ.Sell.Inventory()
    local service = GameLib.Service.WeaponService
    local ok, content = pcall(function() return service and service.GetContent() end)
    if not ok or type(content) ~= "table" then return {} end

    local list = {}
    for uid, weapon in pairs(content) do
        if type(weapon) == "table" then
            list[#list + 1] = {
                Uid = uid,
                Name = weapon.Name or tostring(uid),
                Rarity = xDTaraZ.Sell.RarityOf(weapon.Name),
                Price = tonumber(weapon.Price) or 0,
                Wear = tonumber(weapon.WearFactor) or 0,
            }
        end
    end
    return list
end

---@return string[]  uids matching selected rarities under the price ceiling, keeping N per rarity
function xDTaraZ.Sell.Pick()
    local wanted = Util.SetFromList(xDTaraZ.Options.SellRarities)
    local ceiling = xDTaraZ.Options.MaxSellPrice
    local kept, uids = {}, {}
    for _, weapon in ipairs(xDTaraZ.Sell.Inventory()) do
        if weapon.Rarity and wanted[weapon.Rarity] and (ceiling <= 0 or weapon.Price <= ceiling) then
            kept[weapon.Rarity] = (kept[weapon.Rarity] or 0) + 1
            if kept[weapon.Rarity] > xDTaraZ.Options.KeepPerRarity then
                uids[#uids + 1] = weapon.Uid
            end
        end
    end
    return uids
end

function xDTaraZ.Sell.SellNow()
    local service = GameLib.Service.WeaponService
    if not service then xDTaraZ.Sell.LastResult = "no service" return xDTaraZ.Sell.LastResult end

    local uids = xDTaraZ.Sell.Pick()
    if #uids == 0 then
        xDTaraZ.Sell.LastResult = "nothing to sell"
        return xDTaraZ.Sell.LastResult
    end

    local ok, response = pcall(function() return service.Sell(uids) end)
    xDTaraZ.Sell.LastResult = ok and (#uids .. " sold") or ("sell failed: " .. tostring(response))
    return xDTaraZ.Sell.LastResult
end

function xDTaraZ.Sell.Start() xDTaraZ.Options.AutoSell = true end
function xDTaraZ.Sell.Stop() xDTaraZ.Options.AutoSell = false end

function xDTaraZ.Sell.Step()
    if not xDTaraZ.Options.AutoSell then xDTaraZ.Sell.Status = "Off" return end
    xDTaraZ.Sell.Status = xDTaraZ.Sell.SellNow()
end

function xDTaraZ.Sell.GetStatus()
    return xDTaraZ.Options.AutoSell and xDTaraZ.Sell.Status or "Off"
end

xDTaraZ.Collect = { Status = "Off", LastResult = "" }

---@return table[]  claimable quest descriptors; field mapping is a live seam
function xDTaraZ.Collect.Claimable()
    local store = StoreData(GameLib.Service.QuestService)
    if not store then return {} end
    local source = store.Quests or store.Active or store.Daily or store
    if type(source) ~= "table" then return {} end

    local list = {}
    for key, quest in pairs(source) do
        if type(quest) == "table" then
            local done = quest.Completed or quest.IsComplete or quest.Done
            local claimed = quest.Claimed or quest.IsClaimed
            if done and not claimed then
                list[#list + 1] = quest.Id or quest.QuestId or quest.Key or key
            end
        end
    end
    return list
end

function xDTaraZ.Collect.ClaimNow()
    local service = GameLib.Service.QuestService
    if not service then xDTaraZ.Collect.LastResult = "no service" return xDTaraZ.Collect.LastResult end

    local ids = xDTaraZ.Collect.Claimable()
    if #ids == 0 then
        xDTaraZ.Collect.LastResult = "nothing to claim"
        return xDTaraZ.Collect.LastResult
    end

    local claimed = 0
    for _, id in ipairs(ids) do
        local ok = pcall(function() return service.ClaimReward(id) end)
        if ok then claimed += 1 end
        task.wait(xDTaraZ.Config.ClaimDelay)
    end
    xDTaraZ.Collect.LastResult = claimed .. " quests claimed"
    return xDTaraZ.Collect.LastResult
end

function xDTaraZ.Collect.Start() xDTaraZ.Options.AutoClaimQuest = true end
function xDTaraZ.Collect.Stop() xDTaraZ.Options.AutoClaimQuest = false end

function xDTaraZ.Collect.Step()
    if not xDTaraZ.Options.AutoClaimQuest then xDTaraZ.Collect.Status = "Off" return end
    xDTaraZ.Collect.Status = xDTaraZ.Collect.ClaimNow()
end

function xDTaraZ.Collect.GetStatus()
    return xDTaraZ.Options.AutoClaimQuest and xDTaraZ.Collect.Status or "Off"
end

xDTaraZ.Flag = { Status = "Off", LastTouch = 0 }

local CollectionService = game:GetService("CollectionService")

---@return string?  CTF tag active for the current mode, nil when not a flag mode
function xDTaraZ.Flag.ModeTag()
    local mode = xDTaraZ.Match.Info()
    if type(mode) ~= "string" or not mode:find("CaptureFlag") then return nil end
    return mode:find("TDM") and "CTF_FlagSubmit" or "CTF_PickFlag_FFA"
end

function xDTaraZ.Flag.Touch(part)
    local hrp = xDTaraZ.Player.Root
    if not (hrp and part and Util.FireTouch) then return false end
    Util.FireTouch(hrp, part, 0)
    Util.FireTouch(hrp, part, 1)
    return true
end

function xDTaraZ.Flag.Step()
    if not xDTaraZ.Options.AutoFlag then
        xDTaraZ.Flag.Status = "Off"
        return
    end
    if not (xDTaraZ.Match.InRound() and xDTaraZ.Player:IsAlive()) then
        xDTaraZ.Flag.Status = "Waiting"
        return
    end
    local tag = xDTaraZ.Flag.ModeTag()
    if not tag then
        xDTaraZ.Flag.Status = "Not a flag mode"
        return
    end

    local now = os.clock()
    if now - xDTaraZ.Flag.LastTouch < xDTaraZ.Config.FlagRetry then return end
    xDTaraZ.Flag.LastTouch = now

    local myTeam = xDTaraZ.Entity.Team(xDTaraZ.Entity.Local())
    local touched = 0
    for _, part in ipairs(CollectionService:GetTagged(tag)) do
        if not part:IsA("BasePart") then continue end
        if tag == "CTF_FlagSubmit" and myTeam and part.Name ~= myTeam then continue end
        if xDTaraZ.Flag.Touch(part) then touched += 1 end
    end
    xDTaraZ.Flag.Status = touched > 0 and ("Touched " .. touched) or "No flags"
end

function xDTaraZ.Flag.GetStatus()
    return xDTaraZ.Flag.Status
end

xDTaraZ.Combat = { State = "Idle", Status = "Off", Target = nil, Part = nil, Look = nil, Bound = false, LastShot = 0, Circle = nil, Farm = false }

local aimParams = RaycastParams.new()
aimParams.FilterType = Enum.RaycastFilterType.Exclude

function xDTaraZ.Combat.AimActive()
    return xDTaraZ.Options.Aimbot == true or xDTaraZ.Options.KillAura == true or xDTaraZ.Combat.Farm == true
end

function xDTaraZ.Combat.FireActive()
    return xDTaraZ.Options.TriggerBot == true or xDTaraZ.Options.KillAura == true or xDTaraZ.Combat.Farm == true
end

function xDTaraZ.Combat.Active()
    return xDTaraZ.Combat.AimActive() or xDTaraZ.Combat.FireActive() or xDTaraZ.Options.ShowFov == true
end

---@return BasePart?  server hitbox for the chosen bone
function xDTaraZ.Combat.BonePart(entity)
    local char = xDTaraZ.Entity.Character(entity)
    if not char then return nil end
    local collider = char:FindFirstChild("Collider")
    local bone = xDTaraZ.Options.AimBone or "Head"
    return collider and (collider:FindFirstChild(bone) or collider:FindFirstChild("Head"))
        or char:FindFirstChild("Head")
        or xDTaraZ.Entity.Root(entity)
end

function xDTaraZ.Combat.Filter()
    local cam = Workspace.CurrentCamera
    aimParams.FilterDescendantsInstances = { cam, xDTaraZ.Entity.Character(xDTaraZ.Entity.Local()) }
    return cam
end

---@return CFrame  where the game fires bullets from
function xDTaraZ.Combat.Origin()
    local camCtrl = xDTaraZ.GameLib.CameraController
    local ok, origin = pcall(function() return camCtrl.GetCombatOrigin() end)
    if ok and typeof(origin) == "CFrame" then return origin end
    return Workspace.CurrentCamera.CFrame
end

function xDTaraZ.Combat.Visible(part, char)
    xDTaraZ.Combat.Filter()
    local origin = xDTaraZ.Combat.Origin().Position
    local hit = Workspace:Raycast(origin, part.Position - origin, aimParams)
    return hit ~= nil and hit.Instance:IsDescendantOf(char)
end

function xDTaraZ.Combat.IsEnemy(entity)
    if type(entity) ~= "table" or xDTaraZ.Entity.IsLocal(entity) then return false end
    if xDTaraZ.Options.AimTeamCheck and xDTaraZ.Entity.Friendly(entity) then return false end
    return xDTaraZ.Entity.Health(entity) > 0
end

---@return Vector3  part position led by its velocity
function xDTaraZ.Combat.Predict(part)
    local lead = (xDTaraZ.Options.AimPrediction or 0) / 1000
    if lead <= 0 then return part.Position end
    return part.Position + part.AssemblyLinearVelocity * lead
end

---@return table?, BasePart?  best target inside the FOV circle
---@return Vector2  screen point the FOV circle is centred on
function xDTaraZ.Combat.AimCenter(cam)
    if xDTaraZ.Options.AimPriority == "Mouse" then return UserInputService:GetMouseLocation() end
    return cam.ViewportSize / 2
end

function xDTaraZ.Combat.UsesFov()
    local mode = xDTaraZ.Options.AimPriority
    return mode == "Crosshair" or mode == "Mouse"
end

---@return number?  lower is better, nil when the target is filtered out
function xDTaraZ.Combat.Score(entity, part, cam, center, origin)
    local dist = (part.Position - origin).Magnitude
    if dist > xDTaraZ.Options.AimMaxDistance then return nil end

    if xDTaraZ.Combat.UsesFov() then
        local screen, onScreen = cam:WorldToViewportPoint(part.Position)
        if not onScreen then return nil end
        local gap = (Vector2.new(screen.X, screen.Y) - center).Magnitude
        if gap > xDTaraZ.Options.AimFov then return nil end
        return gap
    end
    if xDTaraZ.Options.AimPriority == "Health" then
        return xDTaraZ.Entity.Health(entity) * 10000 + dist
    end
    return dist
end

---@return table?, BasePart?  best target for the chosen priority mode
function xDTaraZ.Combat.SelectTarget()
    local cam = Workspace.CurrentCamera
    if not cam then return nil end
    local center = xDTaraZ.Combat.AimCenter(cam)
    local origin = cam.CFrame.Position
    local best, bestPart, bestScore

    for _, entity in pairs(xDTaraZ.Entity.List()) do
        if not xDTaraZ.Combat.IsEnemy(entity) then continue end
        local part = xDTaraZ.Combat.BonePart(entity)
        if not part then continue end
        local score = xDTaraZ.Combat.Score(entity, part, cam, center, origin)
        if not score or (bestScore and score >= bestScore) then continue end
        if xDTaraZ.Options.AimWallCheck and not xDTaraZ.Combat.Visible(part, xDTaraZ.Entity.Character(entity)) then continue end
        best, bestPart, bestScore = entity, part, score
    end
    return best, bestPart
end

function xDTaraZ.Combat.BindCamera()
    if xDTaraZ.Combat.Bound then return end
    xDTaraZ.Combat.Bound = true
    RunService:BindToRenderStep("xDTaraZAim", xDTaraZ.Config.AimRenderPriority, function()
        local part = xDTaraZ.Combat.Part
        local cam = Workspace.CurrentCamera
        if not (xDTaraZ.Combat.AimActive() and part and part.Parent) then
            xDTaraZ.Combat.Look = nil
            return
        end
        local origin = cam.CFrame.Position
        local want = (xDTaraZ.Combat.Predict(part) - origin).Unit
        local smooth = math.max(xDTaraZ.Options.AimSmooth or 1, 1)
        local look = xDTaraZ.Combat.Look or cam.CFrame.LookVector
        look = smooth <= 1 and want or look:Lerp(want, 1 / smooth).Unit
        xDTaraZ.Combat.Look = look
        cam.CFrame = CFrame.lookAt(origin, origin + look)
    end)
end

function xDTaraZ.Combat.UnbindCamera()
    if not xDTaraZ.Combat.Bound then return end
    xDTaraZ.Combat.Bound = false
    RunService:UnbindFromRenderStep("xDTaraZAim")
end

---@return boolean  crosshair currently on an enemy hitbox
function xDTaraZ.Combat.CrosshairOnEnemy()
    xDTaraZ.Combat.Filter()
    local origin = xDTaraZ.Combat.Origin()
    local hit = Workspace:Raycast(origin.Position, origin.LookVector * xDTaraZ.Config.TriggerRange, aimParams)
    if not hit then return false end
    for _, entity in pairs(xDTaraZ.Entity.List()) do
        local char = xDTaraZ.Entity.Character(entity)
        if char and hit.Instance:IsDescendantOf(char) then return xDTaraZ.Combat.IsEnemy(entity) end
    end
    return false
end

---@return boolean  true when the weapon accepted the shot
function xDTaraZ.Combat.Fire()
    local now = os.clock()
    if now - xDTaraZ.Combat.LastShot < xDTaraZ.Config.FireInterval then return false end
    xDTaraZ.Combat.LastShot = now

    local combat = xDTaraZ.GameLib.Service.CombatService
    local weapon = combat and combat.GetCurrentWeapon()
    local shooter = weapon and weapon._Shootable
    if not shooter then return false end

    local ok, fired = pcall(shooter.LocalShoot, shooter)
    if not ok then warn("[SniperArena] shoot:", fired) end
    return ok and fired ~= nil
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
    circle.Position = xDTaraZ.Combat.AimCenter(Workspace.CurrentCamera)
    circle.Radius = xDTaraZ.Options.AimFov
    circle.Visible = true
end

xDTaraZ.Combat.RecoilSaved = {}
xDTaraZ.Combat.ZoomSaved = {}

function xDTaraZ.Combat.ApplyNoRecoil()
    local combat = xDTaraZ.GameLib.Service.CombatService
    local weapon = combat and combat.GetCurrentWeapon()
    local cfg = weapon and weapon.Config
    if type(cfg) ~= "table" then return end
    if type(cfg.RecoilZoom) == "number" and cfg.RecoilZoom ~= 0 then
        xDTaraZ.Combat.ZoomSaved[cfg] = xDTaraZ.Combat.ZoomSaved[cfg] or cfg.RecoilZoom
        cfg.RecoilZoom = 0
    end
    for _, key in ipairs({ "Recoil", "RecoilAiming" }) do
        local recoil = cfg[key]
        if type(recoil) == "table" and recoil.Degree ~= 0 then
            if xDTaraZ.Combat.RecoilSaved[recoil] == nil then xDTaraZ.Combat.RecoilSaved[recoil] = recoil.Degree end
            recoil.Degree = 0
        end
    end
end

xDTaraZ.Combat.SpreadSaved = {}

function xDTaraZ.Combat.ZeroSpread()
    return 0
end

function xDTaraZ.Combat.ApplyNoSpread()
    local combat = xDTaraZ.GameLib.Service.CombatService
    local weapon = combat and combat.GetCurrentWeapon()
    local shooter = weapon and weapon._Shootable
    if type(shooter) ~= "table" or rawget(shooter, "GetCurrentSpread") == xDTaraZ.Combat.ZeroSpread then return end
    xDTaraZ.Combat.SpreadSaved[shooter] = { rawget(shooter, "GetCurrentSpread") }
    rawset(shooter, "GetCurrentSpread", xDTaraZ.Combat.ZeroSpread)
end

function xDTaraZ.Combat.RestoreSpread()
    for shooter, original in pairs(xDTaraZ.Combat.SpreadSaved) do
        rawset(shooter, "GetCurrentSpread", original[1])
    end
    table.clear(xDTaraZ.Combat.SpreadSaved)
end

function xDTaraZ.Combat.RestoreRecoil()
    for recoil, degree in pairs(xDTaraZ.Combat.RecoilSaved) do recoil.Degree = degree end
    for cfg, zoom in pairs(xDTaraZ.Combat.ZoomSaved) do cfg.RecoilZoom = zoom end
    table.clear(xDTaraZ.Combat.RecoilSaved)
    table.clear(xDTaraZ.Combat.ZoomSaved)
end

function xDTaraZ.Combat.Step()
    xDTaraZ.Combat.UpdateCircle()
    if xDTaraZ.Options.NoRecoil then
        xDTaraZ.Combat.ApplyNoRecoil()
    elseif next(xDTaraZ.Combat.RecoilSaved) or next(xDTaraZ.Combat.ZoomSaved) then
        xDTaraZ.Combat.RestoreRecoil()
    end
    if xDTaraZ.Options.NoSpread then
        xDTaraZ.Combat.ApplyNoSpread()
    elseif next(xDTaraZ.Combat.SpreadSaved) then
        xDTaraZ.Combat.RestoreSpread()
    end
    if not xDTaraZ.Combat.Active() then
        if xDTaraZ.Combat.State ~= "Idle" then xDTaraZ.Combat.Stop() end
        return
    end
    if not xDTaraZ.Match.InRound() then
        xDTaraZ.Combat.Target, xDTaraZ.Combat.Part = nil, nil
        xDTaraZ.Combat.State, xDTaraZ.Combat.Status = "Wait", "Waiting for round"
        return
    end

    local mode = xDTaraZ.Match.Info() or "?"
    if xDTaraZ.Combat.AimActive() then
        xDTaraZ.Combat.BindCamera()
        local target, part = xDTaraZ.Combat.SelectTarget()
        xDTaraZ.Combat.Target, xDTaraZ.Combat.Part = target, part
        xDTaraZ.Combat.State = target and "Locked" or "Acquire"
        local char = target and xDTaraZ.Entity.Character(target)
        xDTaraZ.Combat.Status = mode .. " · " .. (char and char.Name or "no target")
    else
        xDTaraZ.Combat.UnbindCamera()
        xDTaraZ.Combat.Target, xDTaraZ.Combat.Part = nil, nil
        xDTaraZ.Combat.State, xDTaraZ.Combat.Status = "Ready", mode .. " · aim idle"
    end

    if xDTaraZ.Combat.FireActive() and xDTaraZ.Combat.CrosshairOnEnemy() and xDTaraZ.Combat.Fire() then
        xDTaraZ.Combat.State = "Fired"
    end
end

function xDTaraZ.Combat.Stop()
    xDTaraZ.Combat.UnbindCamera()
    xDTaraZ.Combat.Target, xDTaraZ.Combat.Part = nil, nil
    xDTaraZ.Combat.State, xDTaraZ.Combat.Status = "Idle", "Off"
    if xDTaraZ.Combat.Circle then xDTaraZ.Combat.Circle.Visible = false end
end

function xDTaraZ.Combat.Unload()
    xDTaraZ.Combat.Stop()
    xDTaraZ.Combat.RestoreRecoil()
    xDTaraZ.Combat.RestoreSpread()
    if xDTaraZ.Combat.Circle then
        xDTaraZ.Combat.Circle:Remove()
        xDTaraZ.Combat.Circle = nil
    end
end

function xDTaraZ.Combat.GetStatus()
    return xDTaraZ.Combat.Status
end

xDTaraZ.Farm = { Status = "Off", Kills = 0, StartKills = 0, LastJoin = 0 }

function xDTaraZ.Farm.KillCount()
    local status = xDTaraZ.GameLib.Service.StatusService
    local key = xDTaraZ.GameLib.Status and xDTaraZ.GameLib.Status.Killed
    if not (status and key) then return 0 end
    local ok, value = pcall(function() return status.GetStatus(key) end)
    return ok and tonumber(value) or 0
end

function xDTaraZ.Farm.JoinPad()
    local start = Workspace:FindFirstChild("Lobby") and Workspace.Lobby:FindFirstChild("Start")
    local label = start and start:FindFirstChild("TextLabel", true)
    if not (start and label and label.Text:find("Touch")) then return false end
    local now = os.clock()
    if now - xDTaraZ.Farm.LastJoin < xDTaraZ.Config.JoinRetry then return true end
    xDTaraZ.Farm.LastJoin = now
    local touch = start:FindFirstChild("Touch")
    local hrp = xDTaraZ.Player.Root
    if touch and hrp and Util.FireTouch then
        Util.FireTouch(hrp, touch, 0)
        task.delay(0.1, Util.FireTouch, hrp, touch, 1)
    end
    return true
end

---@return table?, number  nearest enemy entity and distance, visible or not
function xDTaraZ.Farm.NearestEnemy()
    local root = xDTaraZ.Player.Root
    if not root then return nil end
    local best, bestDist
    for _, entity in pairs(xDTaraZ.Entity.List()) do
        if xDTaraZ.Combat.IsEnemy(entity) then
            local enemyRoot = xDTaraZ.Entity.Root(entity)
            if enemyRoot then
                local dist = (enemyRoot.Position - root.Position).Magnitude
                if not bestDist or dist < bestDist then best, bestDist = enemyRoot, dist end
            end
        end
    end
    return best, bestDist
end

function xDTaraZ.Farm.DashHelper()
    if xDTaraZ.Farm.Dash ~= nil then return xDTaraZ.Farm.Dash end
    local client = ReplicatedStorage:FindFirstChild("Client")
    local helper = client and client:FindFirstChild("CombatHelper")
    local dash = helper and helper:FindFirstChild("Dash")
    local config = ReplicatedStorage:FindFirstChild("Config") and ReplicatedStorage.Config:FindFirstChild("Config")
    local ffa = ReplicatedStorage.Remote.GameService.GameMode.FFA:FindFirstChild("Dash")
    local okD, dashModule = pcall(require, dash)
    local okC, configModule = pcall(require, config)
    if okD and okC and ffa then
        xDTaraZ.Farm.Dash = { Module = dashModule, Config = configModule.Movement, Remote = ffa, Entity = xDTaraZ.GameLib.Service.EntityService.LocalEntity }
    else
        xDTaraZ.Farm.Dash = false
    end
    return xDTaraZ.Farm.Dash
end

---@param dir Vector3  flattened world direction to dash toward
function xDTaraZ.Farm.DashTo(dir)
    local dash = xDTaraZ.Farm.DashHelper()
    if not dash then return false end
    dash.Module.RefreshNextDashTime()
    local entity = dash.Entity
    if not dash.Module.CanDash() or entity:InState(entity.State.Dash) then return false end
    if not entity:RequestState(entity.State.Dash) then return false end
    dash.Remote:FireServer(Workspace:GetServerTimeNow(), true, 0)
    dash.Module.Dash({
        GravityRecover = true, Up = 2, Direction = dir,
        Duration = dash.Config.DashDuration, Distance = dash.Config.DashDistance,
        DirectionForceEndPercent = dash.Config.DashForceEndPervcent,
        Style = Enum.EasingStyle.Quad, StyleDirection = Enum.EasingDirection.Out,
    })
    return true
end

function xDTaraZ.Farm.Navigate()
    local root = xDTaraZ.Player.Root
    local enemy, dist = xDTaraZ.Farm.NearestEnemy()
    if not (root and enemy) then return false end
    if dist < xDTaraZ.Config.FarmMinDash then return false end
    local flat = (enemy.Position - root.Position) * Vector3.new(1, 0, 1)
    if flat.Magnitude < 1 then return false end
    xDTaraZ.Farm.FaceTarget(enemy.Position)
    return xDTaraZ.Farm.DashTo(flat.Unit)
end

---@param pos Vector3  point the camera should look at before dashing
function xDTaraZ.Farm.FaceTarget(pos)
    local cam = Workspace.CurrentCamera
    if cam then cam.CFrame = CFrame.lookAt(cam.CFrame.Position, pos) end
end

function xDTaraZ.Farm.Respawn()
    local gs = xDTaraZ.GameLib.Service.GameService
    if not (gs and gs.CanFastRespawn) then return end
    local ok, ready = pcall(gs.CanFastRespawn)
    if ok and ready then pcall(gs.FastRespawn) end
end

function xDTaraZ.Farm.Step()
    if not xDTaraZ.Options.AutoFarm then
        if xDTaraZ.Combat.Farm then xDTaraZ.Farm.Stop() end
        return
    end
    xDTaraZ.Combat.Farm = true
    xDTaraZ.Farm.Kills = xDTaraZ.Farm.KillCount() - xDTaraZ.Farm.StartKills

    if not xDTaraZ.Match.InRound() then
        xDTaraZ.Farm.Status = xDTaraZ.Farm.JoinPad() and "Joining round" or "Waiting for round"
        return
    end
    if xDTaraZ.Player:IsAlive() then
        if not xDTaraZ.Combat.Target then xDTaraZ.Farm.Navigate() end
        xDTaraZ.Farm.Status = "Farming · " .. xDTaraZ.Farm.Kills .. " kills"
    else
        xDTaraZ.Farm.Respawn()
        xDTaraZ.Farm.Status = "Respawning"
    end
end

function xDTaraZ.Farm.Start()
    xDTaraZ.Options.AutoFarm = true
    xDTaraZ.Combat.Farm = true
    xDTaraZ.Farm.StartKills = xDTaraZ.Farm.KillCount()
    xDTaraZ.Farm.Kills = 0
end

function xDTaraZ.Farm.Stop()
    xDTaraZ.Options.AutoFarm = false
    xDTaraZ.Combat.Farm = false
    if not xDTaraZ.Combat.Active() then xDTaraZ.Combat.Stop() end
    xDTaraZ.Farm.Status = "Off"
end

function xDTaraZ.Farm.GetStatus()
    return xDTaraZ.Farm.Status
end

xDTaraZ.UI = { Labels = {} }
local Library, T

function xDTaraZ.UI.Detach(fn)
    return function(...)
        local packed = table.pack(...)
        task.defer(function()
            local ok, err = pcall(fn, table.unpack(packed, 1, packed.n))
            if not ok then warn("[SniperArena] ui: " .. tostring(err)) end
        end)
    end
end

---@param module table  feature with Start/Stop
function xDTaraZ.UI.StartStop(module)
    return xDTaraZ.UI.Detach(function(on)
        if on then module.Start() else module.Stop() end
    end)
end

---@param widget table  option whose value mirrors an Options key
function xDTaraZ.UI.Bind(widget, key, transform)
    local function Apply(value)
        if transform then value = transform(value) end
        xDTaraZ.Options[key] = value
    end
    Apply(widget.Value)
    widget:OnChanged(Apply)
    return widget
end

function xDTaraZ.UI.BuildMain(window)
    window:AddTabSection(T("Main", "หลัก"))
    local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and links", "สถานะและลิงก์"))

    local farm = tab:AddLeftGroupbox(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "star")
    farm:AddToggle("AutoFarm", { Text = T("Auto farm (Kaitun)", "ฟาร์มอัตโนมัติ"), Description = T("Joins rounds, aims, fires and respawns on its own", "เข้ารอบ เล็ง ยิง และเกิดใหม่เองทั้งหมด"), Risky = true, Callback = xDTaraZ.UI.StartStop(xDTaraZ.Farm) })
    xDTaraZ.UI.Labels.Farm = farm:AddParagraph({ Title = T("Status", "สถานะ"), Content = "-" })

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
    xDTaraZ.UI.Labels.Movement = status:AddParagraph({ Title = T("Movement", "การเคลื่อนที่"), Content = "-" })
    xDTaraZ.UI.Labels.Esp = status:AddParagraph({ Title = T("ESP", "ESP"), Content = "-" })
    xDTaraZ.UI.Labels.Combat = status:AddParagraph({ Title = T("Combat", "การต่อสู้"), Content = "-" })
    xDTaraZ.UI.Labels.Economy = status:AddParagraph({ Title = T("Economy", "เศรษฐกิจ"), Content = "-" })

    local panic = tab:AddLeftGroupbox(T("Quick", "ด่วน"), "bomb")
    panic:AddButton({ Text = T("Panic — all off", "ฉุกเฉิน ปิดทั้งหมด"), Style = "Danger", Func = xDTaraZ.UI.Detach(function()
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

function xDTaraZ.UI.BuildCombat(window)
    window:AddTabSection(T("Combat", "การต่อสู้"))
    local tab = window:AddTab(T("Combat", "การต่อสู้"), "target", T("Aimbot and firing", "เล็งอัตโนมัติและยิง"))

    local aim = tab:AddLeftGroupbox(T("Aimbot", "เล็งอัตโนมัติ"), "crosshair")
    aim:AddToggle("Aimbot", {
        Text = T("Aimbot", "เล็งอัตโนมัติ"),
        Description = T("Locks onto the enemy nearest your crosshair", "ล็อคศัตรูที่ใกล้เป้าเล็งที่สุด"),
    }):AddKeyPicker("AimbotKey", { Default = "E", Mode = "Hold" })
    aim:AddDropdown("AimMode", { Text = T("Key mode", "โหมดปุ่ม"), Values = { "Hold", "Toggle", "Always" }, Default = "Hold", Callback = function(mode)
        local picker = Library.Options.AimbotKey
        if picker then picker:SetValue({ picker.Value, mode }) end
    end })
    aim:AddDropdown("AimPriority", { Text = T("Target priority", "เลือกเป้าตาม"), Values = { "Crosshair", "Mouse", "Distance", "Health" }, Default = "Crosshair" })
    aim:AddSlider("AimMaxDistance", { Text = T("Max aim distance", "ระยะเล็งสูงสุด"), Min = 50, Max = 2000, Default = 1000, Suffix = "m" })
    aim:AddDropdown("AimBone", { Text = T("Aim part", "จุดเล็ง"), Values = { "Head", "Body", "Arm", "Leg" }, Default = "Head" })
    aim:AddSlider("AimSmooth", { Text = T("Smoothness", "ความนุ่ม"), Min = 1, Max = 20, Default = 1, Rounding = 0 })
    aim:AddSlider("AimPrediction", { Text = T("Prediction", "เล็งดักหน้า"), Min = 0, Max = 200, Default = 0, Suffix = "ms", Rounding = 0 })
    aim:AddSlider("AimFov", { Text = T("FOV", "ระยะมอง"), Min = 20, Max = 600, Default = 150, Suffix = "px" })
    aim:AddToggle("ShowFov", { Text = T("Show FOV circle", "แสดงวงระยะมอง") })
    aim:AddToggle("AimWallCheck", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Default = true })
    aim:AddToggle("AimTeamCheck", { Text = T("Team check", "เช็คทีม"), Default = true })

    local fire = tab:AddRightGroupbox(T("Firing", "การยิง"), "swords")
    fire:AddToggle("TriggerBot", { Text = T("Trigger bot", "ยิงอัตโนมัติ"), Description = T("Fires the moment your crosshair is on an enemy", "ยิงทันทีเมื่อเป้าเล็งทับศัตรู"), Risky = true })
    fire:AddToggle("KillAura", { Text = T("Kill aura", "ออร่าสังหาร"), Description = T("Auto aims and kills the nearest visible enemy, no key", "เล็งและฆ่าศัตรูที่เห็นใกล้สุดเอง ไม่ต้องกดปุ่ม"), Risky = true })
    fire:AddToggle("NoSpread", { Text = T("No spread", "ยิงไม่กระจาย"), Description = T("Shots stay accurate while moving or jumping", "ยิงแม่นแม้ตอนเดินหรือกระโดด") })
    fire:AddToggle("NoRecoil", { Text = T("No recoil", "ไม่มีแรงถีบ"), Description = T("Camera no longer kicks when firing", "กล้องไม่เด้งตอนยิง") })

    local obj = tab:AddRightGroupbox(T("Objective", "ภารกิจ"), "flag")
    obj:AddToggle("AutoFlag", { Text = T("Auto capture flag", "เก็บธงอัตโนมัติ"), Description = T("Grabs and returns flags in Capture Flag rounds", "เก็บและส่งธงในโหมด Capture Flag"), Risky = true })end

function xDTaraZ.UI.BuildPlayer(window)
    window:AddTabSection(T("Player", "ผู้เล่น"))
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "oneup", T("Movement and utility", "การเคลื่อนที่และอรรถประโยชน์"))

    local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "flag")
    move:AddToggle("Speed", { Text = T("Speed", "วิ่งเร็ว"), Callback = xDTaraZ.UI.Detach(xDTaraZ.Movement.SetSpeed) })
    move:AddSlider("SpeedValue", { Text = T("Walk speed", "ความเร็ว"), Min = 16, Max = 250, Default = 32 })
    move:AddToggle("Jump", { Text = T("High jump", "กระโดดสูง"), Callback = xDTaraZ.UI.Detach(xDTaraZ.Movement.SetJump) })
    move:AddSlider("JumpValue", { Text = T("Jump height", "ความสูงกระโดด"), Min = 7, Max = 300, Default = 60 })
    move:AddToggle("Fly", { Text = T("Fly", "บิน"), Callback = xDTaraZ.UI.Detach(xDTaraZ.Movement.SetFly) }):AddKeyPicker("FlyKey", { Default = "F", Mode = "Toggle" })
    move:AddSlider("FlySpeed", { Text = T("Fly speed", "ความเร็วบิน"), Min = 16, Max = 400, Default = 90 })
    move:AddToggle("Noclip", { Text = T("Noclip", "เดินทะลุ"), Callback = xDTaraZ.UI.Detach(xDTaraZ.Movement.SetNoclip) })
    move:AddToggle("InfiniteJump", { Text = T("Infinite jump", "กระโดดไม่จำกัด") })
    move:AddToggle("InfiniteDash", { Text = T("Infinite dash", "พุ่งไม่จำกัด"), Description = T("Removes the dash cooldown (FFA/TDM)", "ตัดคูลดาวน์การพุ่ง") })

    local util = tab:AddRightGroupbox(T("Utility", "อรรถประโยชน์"), "gear")
    util:AddToggle("AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK"), Callback = xDTaraZ.UI.StartStop(xDTaraZ.Player.AntiAfk) })
    util:AddToggle("AutoRespawn", { Text = T("Auto respawn", "เกิดใหม่อัตโนมัติ"), Description = T("Respawns right away after dying", "เกิดใหม่ทันทีหลังตาย") })
end

function xDTaraZ.UI.BuildVisuals(window)
    window:AddTabSection(T("Visuals", "การมองเห็น"))
    window:AddVisualsTab({ Provider = xDTaraZ.Esp.Targets, Preview = true })
end

function xDTaraZ.UI.BuildEconomy(window)
    window:AddTabSection(T("Economy", "เศรษฐกิจ"))
    local tab = window:AddTab(T("Economy", "เศรษฐกิจ"), "coin", T("Cases, selling, quests", "เปิดกล่อง ขาย เควสต์"))

    local cases = tab:AddLeftGroupbox(T("Cases", "กล่องสุ่ม"), "qblock")
    cases:AddToggle("AutoOpenCases", { Text = T("Auto open owned cases", "เปิดกล่องที่มีอัตโนมัติ"), Callback = xDTaraZ.UI.StartStop(xDTaraZ.Shop) })
    cases:AddSlider("OpenCount", { Text = T("Open per case", "เปิดต่อกล่อง"), Min = 1, Max = 10, Default = 1 })
    cases:AddButton({ Text = T("Open All Now", "เปิดทั้งหมดตอนนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        Library:Notify(T("Cases", "กล่องสุ่ม"), xDTaraZ.Shop.OpenAllNow(), 4, "Coin")
    end) })

    local sell = tab:AddRightGroupbox(T("Sell", "ขาย"), "shop")
    local rarities = sell:AddDropdown("SellRarities", {
        Text = T("Sell rarities", "rarity ที่จะขาย"),
        Description = T("Only selected rarities are sold", "ขายเฉพาะ rarity ที่เลือก"),
        Values = xDTaraZ.Sell.Rarities(),
        Multi = true,
        Default = {},
        AllowNull = true,
    })
    xDTaraZ.UI.Bind(rarities, "SellRarities")
    sell:AddToggle("AutoSell", { Text = T("Auto sell", "ขายอัตโนมัติ"), Risky = true, Callback = xDTaraZ.UI.StartStop(xDTaraZ.Sell) })
    sell:AddSlider("MaxSellPrice", { Text = T("Max price to sell", "ราคาสูงสุดที่ขาย"), Description = T("Keeps anything worth more (0 = no limit)", "ของแพงกว่านี้จะเก็บไว้ (0 = ไม่จำกัด)"), Min = 0, Max = 100000, Default = 500 })
    sell:AddSlider("KeepPerRarity", { Text = T("Keep per rarity", "เก็บต่อ rarity"), Min = 0, Max = 20, Default = 0 })
    sell:AddButton({ Text = T("Sell Now", "ขายตอนนี้"), Style = "Warning", Func = xDTaraZ.UI.Detach(function()
        Library:Notify(T("Sell", "ขาย"), xDTaraZ.Sell.SellNow(), 4, "Coin")
    end) })
    sell:AddButton({ Text = T("Refresh rarities", "รีเฟรช rarity"), Func = xDTaraZ.UI.Detach(function()
        rarities:SetValues(xDTaraZ.Sell.Rarities())
    end) })

    local quest = tab:AddLeftGroupbox(T("Quests", "เควสต์"), "key")
    quest:AddToggle("AutoClaimQuest", { Text = T("Auto claim quests", "รับรางวัลเควสต์อัตโนมัติ"), Callback = xDTaraZ.UI.StartStop(xDTaraZ.Collect) })
    quest:AddButton({ Text = T("Claim Now", "รับตอนนี้"), Style = "Success", Func = xDTaraZ.UI.Detach(function()
        Library:Notify(T("Quests", "เควสต์"), xDTaraZ.Collect.ClaimNow(), 4, "Success")
    end) })
end

function xDTaraZ.UI.RefreshStatus()
    if xDTaraZ.UI.Labels.Farm then xDTaraZ.UI.Labels.Farm:SetText(xDTaraZ.Farm.GetStatus()) end
    if xDTaraZ.UI.Labels.Movement then xDTaraZ.UI.Labels.Movement:SetText(xDTaraZ.Movement.GetStatus()) end
    if xDTaraZ.UI.Labels.Esp then xDTaraZ.UI.Labels.Esp:SetText(xDTaraZ.Esp.GetStatus()) end
    if xDTaraZ.UI.Labels.Combat then xDTaraZ.UI.Labels.Combat:SetText(xDTaraZ.Combat.GetStatus()) end
    if xDTaraZ.UI.Labels.Economy then
        xDTaraZ.UI.Labels.Economy:SetText(string.format("%s | %s | %s",
            xDTaraZ.Shop.GetStatus(), xDTaraZ.Sell.GetStatus(), xDTaraZ.Collect.GetStatus()))
    end
end

function xDTaraZ.UI.Build()
    local window = Library.Window
    xDTaraZ.UI.BuildMain(window)
    xDTaraZ.UI.BuildCombat(window)
    xDTaraZ.UI.BuildPlayer(window)
    xDTaraZ.UI.BuildVisuals(window)
    xDTaraZ.UI.BuildEconomy(window)
    window:AddTabSection(T("Other", "อื่นๆ"))
    window:AddSettingsTab()

    for _, key in ipairs({ "SpeedValue", "JumpValue", "FlySpeed", "AimFov", "AimMode", "AimBone", "AimPriority", "AimMaxDistance",
        "Aimbot", "AimSmooth", "AimPrediction", "ShowFov", "AimWallCheck",
        "AimTeamCheck", "TriggerBot", "KillAura", "NoRecoil", "NoSpread", "AutoRespawn", "InfiniteDash", "AutoFlag", "AutoFarm", "InfiniteJump", "OpenCount", "MaxSellPrice", "KeepPerRarity" }) do
        local widget = Library.Options[key]
        if widget then xDTaraZ.UI.Bind(widget, key) end
    end
end

local function BuildInterface()
    Library = loadstring(Util.HttpGet(xDTaraZ.Config.UiSource))()
    xDTaraZ.Library = Library
    T = function(en, th) return Library:T(en, th) end
    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Sniper Arena by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = xDTaraZ.Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        Intro = true,
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
        xDTaraZ.Movement.Release()
        xDTaraZ.Player:Bind(character)
    end)

    xDTaraZ.Movement.Start()

    xDTaraZ.Scheduler.Every("Combat", 0.03, xDTaraZ.Combat.Step)
    xDTaraZ.Scheduler.Every("AntiAfk", 5, xDTaraZ.Player.AntiAfk.Step)
    xDTaraZ.Scheduler.Every("Respawn", 0.5, xDTaraZ.Player.Respawn.Step)
    xDTaraZ.Scheduler.Every("Flag", 1, xDTaraZ.Flag.Step)
    xDTaraZ.Scheduler.Every("Farm", 0.5, xDTaraZ.Farm.Step)
    xDTaraZ.Scheduler.Every("Shop", xDTaraZ.Config.EconomyInterval, xDTaraZ.Shop.Step)
    xDTaraZ.Scheduler.Every("Sell", xDTaraZ.Config.EconomyInterval, xDTaraZ.Sell.Step)
    xDTaraZ.Scheduler.Every("Collect", xDTaraZ.Config.EconomyInterval, xDTaraZ.Collect.Step)
    xDTaraZ.Scheduler.Boot()
end

function xDTaraZ:Unload()
    self.State.Alive = false
    xDTaraZ.Movement.Release()
    xDTaraZ.Combat.Unload()
    for _, connection in ipairs(self.State.Connections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(self.State.Connections)
end

environment.SniperArenaUnload = function()
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