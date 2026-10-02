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
local osClock = os.clock

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
    LookSettle = 0.1,
    TriggerRange = 2000,
    RespawnRetry = 0.25,
    AimRenderPriority = Enum.RenderPriority.Camera.Value + 5,
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Status = "Idle",
}

xDTaraZ.Options = {
    AntiAfk = false,

    InfiniteDash = false,
    FastRespawn = false,
    SkinChanger = false,
    SkinRarities = {},

    AutoOpenCases = false,
    OpenCount = 1,
    AutoSell = false,
    SellRarities = {},
    MaxSellPrice = 500,
    KeepPerRarity = 0,
    AutoClaimQuest = false,

    Aimbot = false,
    AimMode = "Hold",
    SilentAim = false,
    Ragebot = false,
    InstantScope = false,
    HitChance = 100,
    HeadChance = 100,
    TriggerBot = false,
    NoRecoil = false,
    NoSpread = false,
    AimTeamCheck = true,
    AimWallCheck = true,
    AimSmooth = 1,
    AimPrediction = 60,
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
Util.GetUpvalue = Resolve(getupvalue, debug.getupvalue)
Util.GetUpvalues = Resolve(getupvalues, debug.getupvalues)
Util.GetRawMetatable = Resolve(getrawmetatable)
Util.HookMeta = Resolve(hookmetamethod)
Util.GetConnections = Resolve(getconnections, get_signal_cons)
Util.HookFunction = Resolve(hookfunction, replaceclosure)
Util.RestoreFunction = Resolve(restorefunction)
xDTaraZ.Caps = {
    Hook = Util.HookMeta ~= nil,
    HookFunction = Util.HookFunction ~= nil,
    Connections = Util.GetConnections ~= nil,
    Gc = Util.GetGc ~= nil,
    Upvalues = Util.GetUpvalue ~= nil,
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
    if not child or not child:IsA("ModuleScript") then return nil end
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
    GameLib.WeaponController = RequireChild(ReplicatedStorage:FindFirstChild("Client"), "WeaponController")
    local gameService = remoteFolder and remoteFolder:FindFirstChild("GameService")
    GameLib.RoomManager = RequireChild(gameService, "RoomManager")
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
    if gs and gs.CanFastRespawn and gs.CanFastRespawn() then
        gs.FastRespawn()
        return
    end
    local remote = ReplicatedStorage.Remote.GameService:FindFirstChild("Respawn")
    if remote then remote:FireServer() end
end

function xDTaraZ.Player.Respawn.Step()
    if not xDTaraZ.Options.FastRespawn then
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

xDTaraZ.Movement = { Booted = false, Dash = nil }

function xDTaraZ.Movement.DashHelper()
    if xDTaraZ.Movement.Dash ~= nil then return xDTaraZ.Movement.Dash end
    local client = ReplicatedStorage:FindFirstChild("Client")
    local helper = client and client:FindFirstChild("CombatHelper")
    local dash = helper and helper:FindFirstChild("Dash")
    local ok, module = pcall(require, dash)
    xDTaraZ.Movement.Dash = ok and module or false
    return xDTaraZ.Movement.Dash
end

function xDTaraZ.Movement.OnStepped()
    if not xDTaraZ.Options.InfiniteDash then return end
    local dash = xDTaraZ.Movement.DashHelper()
    if dash and dash.RefreshNextDashTime then pcall(dash.RefreshNextDashTime) end
end

function xDTaraZ.Movement.Start()
    if xDTaraZ.Movement.Booted then return end
    xDTaraZ.Movement.Booted = true
    xDTaraZ:Connect(RunService.Stepped, xDTaraZ.Movement.OnStepped)
end

function xDTaraZ.Movement.GetStatus()
    return xDTaraZ.Options.InfiniteDash and "Infinite dash" or "Off"
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

xDTaraZ.Combat = { State = "Idle", Status = "Off", Target = nil, Part = nil, Look = nil, Bound = false, LastShot = 0, Circle = nil, OriginFn = nil, OriginParams = nil, LookSource = nil, LookHolders = nil, LockedSince = 0 }

local aimParams = RaycastParams.new()
aimParams.FilterType = Enum.RaycastFilterType.Exclude

function xDTaraZ.Combat.AimActive()
    return xDTaraZ.Options.Aimbot == true
end

function xDTaraZ.Combat.SilentActive()
    return xDTaraZ.Options.SilentAim == true or xDTaraZ.Options.Ragebot == true
end

function xDTaraZ.Combat.Active()
    local o = xDTaraZ.Options
    return o.Aimbot or o.SilentAim or o.Ragebot or o.TriggerBot or o.ShowFov
end

---@return BasePart?  server hitbox for the chosen bone
function xDTaraZ.Combat.BonePart(entity, bone)
    local char = xDTaraZ.Entity.Character(entity)
    if not char then return nil end
    local collider = char:FindFirstChild("Collider")
    bone = bone or xDTaraZ.Options.AimBone or "Head"
    return collider and (collider:FindFirstChild(bone) or collider:FindFirstChild("Head"))
        or char:FindFirstChild("Head")
        or xDTaraZ.Entity.Root(entity)
end

function xDTaraZ.Combat.Filter()
    local cam = Workspace.CurrentCamera
    aimParams.FilterDescendantsInstances = { cam, xDTaraZ.Entity.Character(xDTaraZ.Entity.Local()) }
    return cam
end

---@return CFrame, any  where the game fires bullets from, detect tag
function xDTaraZ.Combat.Origin()
    local fn = xDTaraZ.Combat.OriginFn
    if not fn then
        local camCtrl = xDTaraZ.GameLib.CameraController
        fn = camCtrl and camCtrl.GetCombatOriginFn and camCtrl.GetCombatOriginFn()
        xDTaraZ.Combat.OriginFn = fn
    end
    if fn then
        local ok, origin, detect = pcall(fn)
        if ok and typeof(origin) == "CFrame" then return origin, detect end
    end
    return Workspace.CurrentCamera.CFrame, nil
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
    local inst = entity.Instance
    if typeof(inst) == "Instance" and inst:GetAttribute("State") == "Dead" then return false end
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
    if xDTaraZ.Options.Ragebot then return false end
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
        if (xDTaraZ.Options.AimWallCheck or xDTaraZ.Options.Ragebot) and not xDTaraZ.Combat.Visible(part, xDTaraZ.Entity.Character(entity)) then continue end
        best, bestPart, bestScore = entity, part, score
    end
    return best, bestPart
end

function xDTaraZ.Combat.BindCamera()
    if xDTaraZ.Combat.Bound then return end
    xDTaraZ.Combat.Bound = true
    RunService:BindToRenderStep("xDTaraZAim", xDTaraZ.Config.AimRenderPriority, function()
        local c = xDTaraZ.Combat
        local cam = Workspace.CurrentCamera
        local part = c.Part
        if not (c.AimActive() and part and part.Parent) then
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

    local _, shooter = xDTaraZ.Combat.Shooter()
    if not shooter then return false end

    local ok, fired = pcall(shooter.LocalShoot, shooter)
    if not ok then warn("[SniperArena] shoot:", fired) end
    return ok and fired ~= nil
end

function xDTaraZ.Combat.Shooter()
    local combat = xDTaraZ.GameLib.Service.CombatService
    local weapon = combat and combat.GetCurrentWeapon()
    return weapon, weapon and weapon._Shootable
end

xDTaraZ.Combat.SilentSaved = {}

---@return table?  the game's combat-origin override table
function xDTaraZ.Combat.OriginOverride()
    if xDTaraZ.Combat.OriginParams ~= nil then return xDTaraZ.Combat.OriginParams or nil end
    if not xDTaraZ.Caps.Upvalues then return nil end
    local camCtrl = xDTaraZ.GameLib.CameraController
    local ok, holder = pcall(function() return Util.GetUpvalue(camCtrl.GetCombatOriginFn(), 1) end)
    local params = ok and type(holder) == "table" and type(holder.TempParams) == "table" and holder.TempParams
    xDTaraZ.Combat.OriginParams = params or false
    return params or nil
end

---@return any  what the game's Shoot returns
function xDTaraZ.Combat.ShootAt(shooter, entity, part, opts)
    local params = xDTaraZ.Combat.OriginOverride()
    local start = xDTaraZ.Combat.Origin().Position
    local aim = xDTaraZ.Combat.Predict(part)
    opts = type(opts) == "table" and opts or {}
    opts.Target = entity.Instance
    opts.TargetHeadshot = part.Name == "Head" or nil
    local ok, localPos = pcall(function() return entity:GetPivot(true):PointToObjectSpace(aim) end)
    if ok then opts.TargetPos = localPos end

    local saved = { params.CameraCFrame, params.SubjectDistance, params.MouseLockOffset }
    params.CameraCFrame, params.SubjectDistance, params.MouseLockOffset = CFrame.lookAt(start, aim), 0, Vector3.zero
    local fired, shot = pcall(shooter.Shoot, shooter, start, (aim - start).Unit, opts)
    params.CameraCFrame, params.SubjectDistance, params.MouseLockOffset = saved[1], saved[2], saved[3]
    if not fired then warn("[SniperArena] silent:", shot) end
    return fired and shot or nil
end

---@return any  same as the game's LocalShoot, bullet sent at the locked target
function xDTaraZ.Combat.SilentShoot(shooter, opts)
    local c = xDTaraZ.Combat
    local saved = c.SilentSaved[shooter]
    local entity = c.Target
    if not (c.SilentActive() and entity and c.OriginOverride()) then return saved.Fn(shooter, opts) end
    if math.random(100) > xDTaraZ.Options.HitChance then return saved.Fn(shooter, opts) end

    local bone = math.random(100) <= xDTaraZ.Options.HeadChance and "Head" or "Body"
    local part = c.BonePart(entity, bone)
    if not (part and part.Parent) then return saved.Fn(shooter, opts) end
    return c.ShootAt(shooter, entity, part, opts)
end

---@return CFrame  camera the server is told we look through
function xDTaraZ.Combat.ReportedLook(...)
    local c = xDTaraZ.Combat
    local cf = c.LookSource(...)
    local part = c.Part
    if typeof(cf) ~= "CFrame" or not (c.SilentActive() and c.Target and part and part.Parent) then return cf end
    return CFrame.lookAt(cf.Position, c.Predict(part))
end

---@return table[]  tables that really hold CameraController's functions
function xDTaraZ.Combat.LookTables()
    local camCtrl = xDTaraZ.GameLib.CameraController
    local tables = {}
    if type(camCtrl) ~= "table" then return tables end
    if rawget(camCtrl, "GetCFrame") and not table.isfrozen(camCtrl) then tables[1] = camCtrl end
    local mt = Util.GetRawMetatable and Util.GetRawMetatable(camCtrl)
    local index = type(mt) == "table" and rawget(mt, "__index")
    if type(index) == "table" then index = { index } elseif type(index) == "function" and Util.GetUpvalues then index = Util.GetUpvalues(index) else index = {} end
    for _, holder in pairs(index) do
        if type(holder) == "table" and type(rawget(holder, "GetCFrame")) == "function" and not table.isfrozen(holder) then
            tables[#tables + 1] = holder
        end
    end
    return tables
end

function xDTaraZ.Combat.ApplyLook()
    local c = xDTaraZ.Combat
    if c.LookSource ~= nil then return end
    local tables = c.LookTables()
    if #tables == 0 then
        c.LookSource = false
        return
    end
    c.LookSource = rawget(tables[1], "GetCFrame")
    c.LookHolders = tables
    for _, holder in ipairs(tables) do rawset(holder, "GetCFrame", c.ReportedLook) end
end

function xDTaraZ.Combat.RestoreLook()
    local c = xDTaraZ.Combat
    if not c.LookSource then
        c.LookSource = nil
        return
    end
    for _, holder in ipairs(c.LookHolders or {}) do
        if rawget(holder, "GetCFrame") == c.ReportedLook then rawset(holder, "GetCFrame", c.LookSource) end
    end
    c.LookSource, c.LookHolders = nil, nil
end

function xDTaraZ.Combat.ApplySilent()
    local _, shooter = xDTaraZ.Combat.Shooter()
    if type(shooter) ~= "table" or rawget(shooter, "LocalShoot") == xDTaraZ.Combat.SilentShoot then return end
    if type(shooter.Shoot) ~= "function" then return end
    xDTaraZ.Combat.SilentSaved[shooter] = { Raw = rawget(shooter, "LocalShoot"), Fn = shooter.LocalShoot }
    rawset(shooter, "LocalShoot", xDTaraZ.Combat.SilentShoot)
end

function xDTaraZ.Combat.RestoreSilent()
    for shooter, saved in pairs(xDTaraZ.Combat.SilentSaved) do
        rawset(shooter, "LocalShoot", saved.Raw)
    end
    table.clear(xDTaraZ.Combat.SilentSaved)
end

xDTaraZ.Combat.ScopeSaved = {}

function xDTaraZ.Combat.ApplyInstantScope()
    local weapon = xDTaraZ.Combat.Shooter()
    local cfg = weapon and weapon.Config
    if type(cfg) ~= "table" or rawget(cfg, "AimTime") == 0 then return end
    if not xDTaraZ.Combat.ScopeSaved[cfg] then
        xDTaraZ.Combat.ScopeSaved[cfg] = { rawget(cfg, "AimTime"), rawget(cfg, "DelayTime") }
    end
    rawset(cfg, "AimTime", 0)
    rawset(cfg, "DelayTime", 0)
end

function xDTaraZ.Combat.RestoreScope()
    for cfg, saved in pairs(xDTaraZ.Combat.ScopeSaved) do
        rawset(cfg, "AimTime", saved[1])
        rawset(cfg, "DelayTime", saved[2])
    end
    table.clear(xDTaraZ.Combat.ScopeSaved)
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

function xDTaraZ.Combat.Patches()
    local o, c = xDTaraZ.Options, xDTaraZ.Combat
    if o.NoRecoil then
        c.ApplyNoRecoil()
    elseif next(c.RecoilSaved) or next(c.ZoomSaved) then
        c.RestoreRecoil()
    end
    if o.NoSpread then c.ApplyNoSpread() elseif next(c.SpreadSaved) then c.RestoreSpread() end
    if o.InstantScope or o.Ragebot then c.ApplyInstantScope() elseif next(c.ScopeSaved) then c.RestoreScope() end
    if c.SilentActive() then
        c.ApplySilent()
        c.ApplyLook()
    else
        if next(c.SilentSaved) then c.RestoreSilent() end
        c.RestoreLook()
    end
end

function xDTaraZ.Combat.Step()
    local c = xDTaraZ.Combat
    c.UpdateCircle()
    c.Patches()
    if not c.Active() then
        if c.State ~= "Idle" then c.Stop() end
        return
    end
    if not xDTaraZ.Match.InRound() then
        c.Target, c.Part = nil, nil
        c.State, c.Status = "Wait", "Waiting for round"
        return
    end

    local mode = xDTaraZ.Match.Info() or "?"
    if c.AimActive() then c.BindCamera() else c.UnbindCamera() end
    if c.AimActive() or c.SilentActive() then
        local target, part = c.SelectTarget()
        if target ~= c.Target then c.LockedSince = os.clock() end
        c.Target, c.Part = target, part
        c.State = target and "Locked" or "Acquire"
        local char = target and xDTaraZ.Entity.Character(target)
        c.Status = mode .. " · " .. (char and char.Name or "no target")
    else
        c.Target, c.Part = nil, nil
        c.State, c.Status = "Ready", mode .. " · aim idle"
    end

    local settled = c.Target ~= nil and os.clock() - c.LockedSince >= xDTaraZ.Config.LookSettle
    local shoot = (xDTaraZ.Options.Ragebot and settled) or (xDTaraZ.Options.TriggerBot and c.CrosshairOnEnemy())
    if shoot and c.Fire() then c.State = "Fired" end
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
    xDTaraZ.Combat.RestoreScope()
    xDTaraZ.Combat.RestoreSilent()
    xDTaraZ.Combat.RestoreLook()
    if xDTaraZ.Combat.Circle then
        xDTaraZ.Combat.Circle:Remove()
        xDTaraZ.Combat.Circle = nil
    end
end

function xDTaraZ.Combat.GetStatus()
    return xDTaraZ.Combat.Status
end

xDTaraZ.Skin = {
    Catalog = {},
    Types = {},
    Labels = {},
    Chosen = {},
    Saved = setmetatable({}, { __mode = "k" }),
    Status = "Off",
    RarityRank = { Common = 1, UnCommon = 2, Rare = 3, Epic = 4, Legendary = 5, Mystic = 6 },
    Hidden = { Charm = true },
}

---@return string?, string?  weapon type and family, nil for non-weapons
function xDTaraZ.Skin.Classify(cfg)
    if type(cfg) ~= "table" then return nil end
    local ok, kind, family = pcall(function() return cfg.WeaponType, cfg.Family end)
    if not ok or type(kind) ~= "string" or type(family) ~= "string" then return nil end
    if xDTaraZ.Skin.Hidden[kind] or family:find("^Base") then return nil end
    return kind, family
end

do
    local configs = xDTaraZ.GameLib.Config.WeaponConfig or {}
    for key, cfg in pairs(configs) do
        if type(key) ~= "string" then continue end
        local kind, family = xDTaraZ.Skin.Classify(cfg)
        if not kind then continue end
        local byFamily = xDTaraZ.Skin.Catalog[kind]
        if not byFamily then
            byFamily = {}
            xDTaraZ.Skin.Catalog[kind] = byFamily
            table.insert(xDTaraZ.Skin.Types, kind)
        end
        byFamily[family] = byFamily[family] or {}
        local rarity = cfg.Rarity or "Common"
        table.insert(byFamily[family], { key, rarity, type(cfg.Display) == "string" and cfg.Display or key })
    end
    table.sort(xDTaraZ.Skin.Types)
    for _, byFamily in pairs(xDTaraZ.Skin.Catalog) do
        for _, list in pairs(byFamily) do
            table.sort(list, function(a, b)
                local ra, rb = xDTaraZ.Skin.RarityRank[a[2]] or 0, xDTaraZ.Skin.RarityRank[b[2]] or 0
                if ra ~= rb then return ra > rb end
                return a[3] < b[3]
            end)
        end
    end
end

function xDTaraZ.Skin.Families(kind)
    return Util.SortedKeys(xDTaraZ.Skin.Catalog[kind])
end

---@param rarities table?  set of rarities to show, empty = all
---@return string[]  labels for the dropdown, best rarity first
function xDTaraZ.Skin.List(kind, family, rarities)
    local list = xDTaraZ.Skin.Catalog[kind] and xDTaraZ.Skin.Catalog[kind][family]
    local names = {}
    if not list then return names end
    local filter = rarities and next(rarities) and rarities
    for _, skin in ipairs(list) do
        if filter and not filter[skin[2]] then continue end
        local label = string.format("[%s] %s", skin[2], skin[3])
        if xDTaraZ.Skin.Labels[label] and xDTaraZ.Skin.Labels[label] ~= skin[1] then label = label .. " · " .. skin[1] end
        xDTaraZ.Skin.Labels[label] = skin[1]
        names[#names + 1] = label
    end
    return names
end

function xDTaraZ.Skin.Choose(family, label)
    xDTaraZ.Skin.Chosen[family] = label and xDTaraZ.Skin.Labels[label] or nil
end

function xDTaraZ.Skin.ClearAll()
    table.clear(xDTaraZ.Skin.Chosen)
end

---@return table[]  every weapon the local player carries
function xDTaraZ.Skin.Carried()
    local combat = xDTaraZ.GameLib.Service.CombatService
    local ok, weapons = pcall(function() return combat.GetWeapons() end)
    local list = {}
    if ok and type(weapons) == "table" then
        for _, weapon in pairs(weapons) do
            if type(weapon) == "table" and weapon.Name then list[#list + 1] = weapon end
        end
    end
    local held = combat and combat.GetCurrentWeapon()
    if held and not table.find(list, held) then list[#list + 1] = held end
    return list
end

function xDTaraZ.Skin.Rebuild(weapon)
    local controllers = xDTaraZ.GameLib.WeaponController
    local entity = xDTaraZ.GameLib.Service.EntityService.LocalEntity
    if not (controllers and entity and weapon.Controller) then return end
    weapon.Controller:Destroy()
    controllers.Create(entity, weapon)
end

function xDTaraZ.Skin.Apply(weapon, key)
    local cfg = xDTaraZ.GameLib.Config.WeaponConfig[key]
    if not cfg then return end
    if not xDTaraZ.Skin.Saved[weapon] then xDTaraZ.Skin.Saved[weapon] = { weapon.Name, weapon.Config } end
    weapon.Name, weapon.Config = key, cfg
    xDTaraZ.Skin.Rebuild(weapon)
end

function xDTaraZ.Skin.Revert(weapon)
    local saved = xDTaraZ.Skin.Saved[weapon]
    if not saved then return end
    weapon.Name, weapon.Config = saved[1], saved[2]
    xDTaraZ.Skin.Saved[weapon] = nil
    xDTaraZ.Skin.Rebuild(weapon)
end

function xDTaraZ.Skin.Restore()
    for weapon in pairs(xDTaraZ.Skin.Saved) do xDTaraZ.Skin.Revert(weapon) end
end

function xDTaraZ.Skin.Step()
    if not xDTaraZ.Options.SkinChanger then
        if next(xDTaraZ.Skin.Saved) then xDTaraZ.Skin.Restore() end
        xDTaraZ.Skin.Status = "Off"
        return
    end

    local applied = 0
    for _, weapon in ipairs(xDTaraZ.Skin.Carried()) do
        local saved = xDTaraZ.Skin.Saved[weapon]
        local originalCfg = saved and saved[2] or weapon.Config
        local _, family = xDTaraZ.Skin.Classify(originalCfg)
        local key = family and xDTaraZ.Skin.Chosen[family]
        if key then
            if weapon.Name ~= key then xDTaraZ.Skin.Apply(weapon, key) end
            applied += 1
        elseif saved then
            xDTaraZ.Skin.Revert(weapon)
        end
    end
    xDTaraZ.Skin.Status = applied > 0 and (applied .. " weapon(s) skinned") or "Pick a skin"
end

function xDTaraZ.Skin.GetStatus()
    return xDTaraZ.Skin.Status
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

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
    xDTaraZ.UI.Labels.Esp = status:AddParagraph({ Title = T("ESP", "ESP"), Content = "-" })
    xDTaraZ.UI.Labels.Combat = status:AddParagraph({ Title = T("Combat", "การต่อสู้"), Content = "-" })
    xDTaraZ.UI.Labels.Skin = status:AddParagraph({ Title = T("Skin", "สกิน"), Content = "-" })
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

    local rage = tab:AddLeftGroupbox(T("Rage", "เรจ"), "bomb")
    rage:AddToggle("Ragebot", { Text = T("Ragebot", "เรจบอท"), Description = T("Shoots every visible enemy on its own, view stays still", "ยิงศัตรูทุกตัวที่มองเห็นเอง กล้องไม่ขยับ"), Risky = true })
    rage:AddToggle("SilentAim", { Text = T("Silent aim", "ไซเลนต์เอม"), Description = T("Shots land on the target inside the FOV, your view never moves", "กระสุนเข้าเป้าในวง FOV กล้องไม่ขยับเลย") })
    rage:AddSlider("HitChance", { Text = T("Hit chance", "โอกาสยิงโดน"), Min = 0, Max = 100, Default = 100, Suffix = "%", Rounding = 0 })
    rage:AddSlider("HeadChance", { Text = T("Headshot chance", "โอกาสเข้าหัว"), Min = 0, Max = 100, Default = 100, Suffix = "%", Rounding = 0 })
    rage:AddToggle("InstantScope", { Text = T("Instant scope", "เปิดสโคปทันที"), Description = T("Scope is ready the moment you aim", "เปิดสโคปพร้อมยิงทันทีที่เล็ง") })

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
    aim:AddSlider("AimPrediction", { Text = T("Prediction", "เล็งดักหน้า"), Min = 0, Max = 200, Default = 60, Suffix = "ms", Rounding = 0 })
    aim:AddSlider("AimFov", { Text = T("FOV", "ระยะมอง"), Min = 20, Max = 600, Default = 150, Suffix = "px" })
    aim:AddToggle("ShowFov", { Text = T("Show FOV circle", "แสดงวงระยะมอง") })
    aim:AddToggle("AimWallCheck", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Default = true })
    aim:AddToggle("AimTeamCheck", { Text = T("Team check", "เช็คทีม"), Default = true })

    local fire = tab:AddRightGroupbox(T("Firing", "การยิง"), "swords")
    fire:AddToggle("TriggerBot", { Text = T("Trigger bot", "ยิงอัตโนมัติ"), Description = T("Fires the moment your crosshair is on an enemy", "ยิงทันทีเมื่อเป้าเล็งทับศัตรู"), Risky = true })
    fire:AddToggle("NoSpread", { Text = T("No spread", "ยิงไม่กระจาย"), Description = T("Shots stay accurate while moving or jumping", "ยิงแม่นแม้ตอนเดินหรือกระโดด") })
    fire:AddToggle("NoRecoil", { Text = T("No recoil", "ไม่มีแรงถีบ"), Description = T("Camera no longer kicks when firing", "กล้องไม่เด้งตอนยิง") })

    xDTaraZ.UI.NeedCap("Ragebot", "Upvalues")
    xDTaraZ.UI.NeedCap("SilentAim", "Upvalues")
    xDTaraZ.UI.NeedCap("ShowFov", "Drawing")
end

function xDTaraZ.UI.BuildPlayer(window)
    window:AddTabSection(T("Player", "ผู้เล่น"))
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "oneup", T("Respawn and utility", "เกิดใหม่และอรรถประโยชน์"))

    local util = tab:AddLeftGroupbox(T("Utility", "อรรถประโยชน์"), "gear")
    util:AddToggle("FastRespawn", { Text = T("Fast respawn", "เกิดใหม่เร็ว"), Description = T("Back in the fight the moment you die", "กลับเข้าสนามทันทีที่ตาย") })
    util:AddToggle("InfiniteDash", { Text = T("Infinite dash", "พุ่งไม่จำกัด"), Description = T("Dash again without waiting (FFA/TDM)", "พุ่งซ้ำได้ไม่ต้องรอ (FFA/TDM)") })
    util:AddToggle("AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK"), Callback = xDTaraZ.UI.StartStop(xDTaraZ.Player.AntiAfk) })
end

xDTaraZ.UI.SkinKinds = {
    Sniper = { "Snipers", "สไนเปอร์", "crosshair" },
    Rifle = { "Rifles", "ไรเฟิล", "target" },
    Melee = { "Knives", "มีด", "swords" },
    Glove = { "Gloves", "ถุงมือ", "shield" },
}

function xDTaraZ.UI.SkinRarities()
    return Util.SetFromList(xDTaraZ.Options.SkinRarities)
end

---@param kind string  WeaponType from the game config
function xDTaraZ.UI.BuildSkinGroup(tab, kind, left)
    local meta = xDTaraZ.UI.SkinKinds[kind] or { kind, kind, "star" }
    local group = left and tab:AddLeftGroupbox(T(meta[1], meta[2]), meta[3]) or tab:AddRightGroupbox(T(meta[1], meta[2]), meta[3])
    local families = xDTaraZ.Skin.Families(kind)
    local weaponIdx, skinIdx = "Skin" .. kind .. "Weapon", "Skin" .. kind .. "Pick"

    local function Refill()
        local family = Library.Options[weaponIdx] and Library.Options[weaponIdx].Value
        local picker = Library.Options[skinIdx]
        if picker then picker:SetValues(xDTaraZ.Skin.List(kind, family, xDTaraZ.UI.SkinRarities())) end
    end
    xDTaraZ.UI.SkinRefill[#xDTaraZ.UI.SkinRefill + 1] = Refill

    group:AddDropdown(weaponIdx, {
        Text = T("Weapon", "อาวุธ"),
        Values = families,
        Default = families[1],
        Searchable = true,
        Callback = function() Refill() end,
    })
    group:AddDropdown(skinIdx, {
        Text = T("Skin", "สกิน"),
        Values = xDTaraZ.Skin.List(kind, families[1], {}),
        Searchable = true,
        AllowNull = true,
        Callback = function(label)
            local family = Library.Options[weaponIdx] and Library.Options[weaponIdx].Value
            if family then xDTaraZ.Skin.Choose(family, label) end
        end,
    })
    group:AddButton({ Text = T("Use default skin", "ใช้สกินเดิม"), Func = function()
        local family = Library.Options[weaponIdx] and Library.Options[weaponIdx].Value
        if family then xDTaraZ.Skin.Choose(family, nil) end
        Library.Options[skinIdx]:SetValue(nil)
    end })
end

function xDTaraZ.UI.BuildSkins(window)
    xDTaraZ.UI.SkinRefill = {}
    local tab = window:AddTab(T("Skins", "สกิน"), "star", T("Every weapon, knife and glove skin", "สกินปืน มีด และถุงมือทุกแบบ"))

    local main = tab:AddLeftGroupbox(T("Skin Changer", "เปลี่ยนสกิน"), "star")
    main:AddToggle("SkinChanger", { Text = T("Skin changer", "เปลี่ยนสกิน"), Description = T("Pick any skin per weapon, only you see it", "เลือกสกินรายอาวุธได้ทุกแบบ เห็นแค่ตัวเอง") })
    local rarityValues = {}
    for rarity in pairs(xDTaraZ.Skin.RarityRank) do rarityValues[#rarityValues + 1] = rarity end
    table.sort(rarityValues, function(a, b) return xDTaraZ.Skin.RarityRank[a] > xDTaraZ.Skin.RarityRank[b] end)
    local filter = main:AddDropdown("SkinRarities", {
        Text = T("Show rarities", "แสดงเฉพาะ rarity"),
        Description = T("Empty shows everything", "ไม่เลือก = แสดงทั้งหมด"),
        Values = rarityValues,
        Multi = true,
        Default = {},
        AllowNull = true,
    })
    xDTaraZ.UI.Bind(filter, "SkinRarities")
    filter:OnChanged(function()
        for _, refill in ipairs(xDTaraZ.UI.SkinRefill) do refill() end
    end)
    main:AddButton({ Text = T("Reset all skins", "คืนสกินเดิมทั้งหมด"), Style = "Warning", Func = function()
        xDTaraZ.Skin.ClearAll()
        for _, kind in ipairs(xDTaraZ.Skin.Types) do
            local picker = Library.Options["Skin" .. kind .. "Pick"]
            if picker then picker:SetValue(nil) end
        end
    end })

    for index, kind in ipairs(xDTaraZ.Skin.Types) do
        xDTaraZ.UI.BuildSkinGroup(tab, kind, index % 2 == 0)
    end
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
    if xDTaraZ.UI.Labels.Skin then xDTaraZ.UI.Labels.Skin:SetText(xDTaraZ.Skin.GetStatus()) end
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
    xDTaraZ.UI.BuildSkins(window)
    xDTaraZ.UI.BuildEconomy(window)
    window:AddTabSection(T("Other", "อื่นๆ"))
    window:AddSettingsTab()

    for _, key in ipairs({ "AimFov", "AimMode", "AimBone", "AimPriority", "AimMaxDistance",
        "Aimbot", "AimSmooth", "AimPrediction", "ShowFov", "AimWallCheck", "AimTeamCheck",
        "SilentAim", "Ragebot", "InstantScope", "HitChance", "HeadChance", "TriggerBot", "NoRecoil", "NoSpread",
        "FastRespawn", "InfiniteDash", "SkinChanger", "OpenCount", "MaxSellPrice", "KeepPerRarity" }) do
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
        xDTaraZ.Player:Bind(character)
    end)

    xDTaraZ.Movement.Start()

    xDTaraZ.Scheduler.Every("Combat", 0.03, xDTaraZ.Combat.Step)
    xDTaraZ.Scheduler.Every("AntiAfk", 5, xDTaraZ.Player.AntiAfk.Step)
    xDTaraZ.Scheduler.Every("Respawn", 0.1, xDTaraZ.Player.Respawn.Step)
    xDTaraZ.Scheduler.Every("Skin", 0.5, xDTaraZ.Skin.Step)
    xDTaraZ.Scheduler.Every("Shop", xDTaraZ.Config.EconomyInterval, xDTaraZ.Shop.Step)
    xDTaraZ.Scheduler.Every("Sell", xDTaraZ.Config.EconomyInterval, xDTaraZ.Sell.Step)
    xDTaraZ.Scheduler.Every("Collect", xDTaraZ.Config.EconomyInterval, xDTaraZ.Collect.Step)
    xDTaraZ.Scheduler.Boot()
end

function xDTaraZ:Unload()
    self.State.Alive = false
    xDTaraZ.Combat.Unload()
    xDTaraZ.Skin.Restore()
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