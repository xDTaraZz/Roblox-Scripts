if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 9534705677 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Sniper Arena only")
    return
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
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local osClock = os.clock

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    Discord = "https://discord.gg/FHVfmeSceA",
    UpdateLog = {
        { "2026-10-10", "Auto Join Round: joins the next round from the lobby\nSkin pictures and rarity colors\nSmoother ESP, cleaner and faster menu\nAuto Sell never sells the guns you hold\nFixed Aimbot key and unloading" },
        { "2026-10-03", "Classic Mario Hub UI is back\nBetter executor support\nImproved Combat & Movement" },
    },
    SaveFolder = "Sniper Arena",
    LoadTimeout = 10,
    AlertTries = 20,
    AlertGap = 0.5,
    RequireTimeout = 5,
    RequireBudget = 15,
    MaxFails = 5,
    FailWindow = 10,
    FovColor = Color3.fromRGB(232, 160, 76),
    BannerCaps = { "HookFunction", "Namecall", "Gc", "Upvalues", "Drawing", "Connections", "FileSystem" },
    CombatToggles = { "Aimbot", "SilentAim", "Ragebot", "TriggerBot", "NoRecoil", "NoSpread", "InstantScope" },
    ModuleFeatures = {
        EntityService = { "Aimbot", "SilentAim", "Ragebot", "TriggerBot" },
        CombatService = { "SilentAim", "Ragebot", "TriggerBot", "NoRecoil", "NoSpread", "InstantScope", "SkinChanger" },
        CameraController = { "SilentAim", "Ragebot" },
        WeaponConfig = { "SkinChanger" },
        GachaService = { "AutoOpenCases" },
        WeaponService = { "AutoSell" },
        QuestService = { "AutoClaimQuest" },
        GameService = { "FastRespawn" },
    },
    SkinMainRows = 4,
    SkinGroupRows = 3,
    EconomyInterval = 1,
    JoinText = "Touch to Join",
    JoinRange = 400,
    JoinRetry = 3,
    StatusInterval = 1,
    OpenDelay = 0.6,
    ClaimDelay = 0.5,
    FireInterval = 0.12,
    LookSettle = 0.1,
    TriggerRange = 2000,
    EspInterval = 0.15,
    EspGrace = 1,
    ResultWait = 3,
    AimRenderPriority = Enum.RenderPriority.Camera.Value + 5,
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Halted = {},
    Notices = {},
    EspSnapshot = {},
}

xDTaraZ.Options = {
    AntiAfk = false,

    InfiniteDash = false,
    FastRespawn = false,
    AutoJoin = false,
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
Util.GetHui = Resolve(gethui, get_hidden_gui)
Util.GetUpvalue = Resolve(getupvalue, debug.getupvalue)
Util.GetUpvalues = Resolve(getupvalues, debug.getupvalues)
Util.GetRawMetatable = Resolve(getrawmetatable)

xDTaraZ.Probes = {}

---@return boolean  getrawmetatable and getupvalues both answer for real
function xDTaraZ.Probes.LookSpoof()
    if not (Util.GetRawMetatable and Util.GetUpvalues) then return false end
    local marker, meta = {}, { __metatable = "locked" }
    local proxy = setmetatable({}, meta)
    local function Holder() return marker end

    local ok, found = pcall(function()
        if Util.GetRawMetatable(proxy) ~= meta then return false end
        for _, value in pairs(Util.GetUpvalues(Holder)) do
            if value == marker then return true end
        end
        return false
    end)
    return ok and found == true
end

xDTaraZ.Caps = setmetatable({}, {
    __index = function(caps, name)
        local probe = xDTaraZ.Probes[name]
        if probe then
            local has = probe()
            rawset(caps, name, has)
            return has
        end
        local lib = xDTaraZ.Library
        if not (lib and lib.Compat) then return false end
        return lib.Compat.Caps[name] == true
    end,
})

---@return string  response body, throws if every transport fails
function Util.HttpGet(url)
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if ok and type(body) == "string" then
        return body
    end
    if not Util.Request then
        error("HttpGet failed: " .. url)
    end

    local sent, response = pcall(Util.Request, { Url = url, Method = "GET" })
    if not sent then error(response) end
    local status = type(response) == "table" and tonumber(response.StatusCode) or nil
    if status == 200 and type(response.Body) == "string" then
        return response.Body
    end
    error("HttpGet " .. url .. ": status " .. tostring(status))
end

---@param detail any  goes to the console, the player only sees text
function Util.Alert(text, detail)
    warn("[SniperArena] menu: " .. tostring(detail or text))
    task.spawn(function()
        for _ = 1, xDTaraZ.Config.AlertTries do
            local shown = pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                Title = "Mario Hub",
                Text = text,
                Duration = 10,
            })
            if shown then return end
            task.wait(xDTaraZ.Config.AlertGap)
        end
    end)
end

---@return table?  UI library, nil after the player was told why
function Util.LoadLibrary(url)
    local fetched, source = pcall(Util.HttpGet, url)
    if not fetched or type(source) ~= "string" or not source:sub(-64):find("return Library%s*$") then
        Util.Alert("Could not download the menu. Check your connection and run it again.", fetched and "response is not the full menu" or source)
        return nil
    end

    local chunk, problem = loadstring(source)
    if type(chunk) ~= "function" then
        Util.Alert("The menu failed to load on this executor: " .. tostring(problem))
        return nil
    end
    local ran, lib = pcall(chunk)
    if not ran or type(lib) ~= "table" then
        Util.Alert("The menu failed to load on this executor: " .. tostring(lib))
        return nil
    end
    if type(lib.Compat) ~= "table" then
        Util.Alert("The menu is out of date. Run the script again in a few minutes.", "ui.lua has no Compat layer")
        return nil
    end
    return lib
end

---@return boolean  false after warning with context
function Util.Try(label, callback, ...)
    local ok, err = pcall(callback, ...)
    if not ok then
        warn("[SniperArena] " .. label .. ": " .. tostring(err))
    end
    return ok
end

function Util.Copy(text)
    if Util.SetClipboard then
        Util.SetClipboard(text)
        return true
    end
    return false
end

---@return ScreenGui  script-owned layer, hidden gui first, PlayerGui last
function Util.Overlay()
    local screen = xDTaraZ.State.Overlay
    if screen and screen.Parent then return screen end

    screen = Instance.new("ScreenGui")
    screen.Name = "MarioHubOverlay"
    screen.IgnoreGuiInset = true
    screen.ResetOnSpawn = false
    screen.DisplayOrder = 50
    local mounts = { function() return game:GetService("CoreGui") end }
    if Util.GetHui then table.insert(mounts, 1, Util.GetHui) end
    for _, mount in ipairs(mounts) do
        if pcall(function() screen.Parent = mount() end) and screen.Parent then break end
    end
    if not screen.Parent then
        screen.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", xDTaraZ.Config.LoadTimeout)
    end
    xDTaraZ.State.Overlay = screen
    return screen
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

xDTaraZ.GameLib = { Config = {}, Service = {}, Missing = {}, LoadEnds = nil }
local GameLib = xDTaraZ.GameLib

---@param asGame boolean     retry from an identity-2 thread, skipped when the executor can't switch
---@return boolean, boolean, any  finished before the deadline, require ok, module
function GameLib.RequireWithin(module, asGame)
    local done, ok, loaded = false, false, nil
    task.spawn(function()
        if asGame then
            pcall(setthreadidentity, 2)
            local read, identity = pcall(getthreadidentity)
            if not (read and identity == 2) then
                done = true
                return
            end
        end
        ok, loaded = pcall(require, module)
        done = true
    end)

    local deadline = osClock() + xDTaraZ.Config.RequireTimeout
    if GameLib.LoadEnds then deadline = math.min(deadline, GameLib.LoadEnds) end
    while not done and osClock() < deadline do
        task.wait()
    end
    return done, ok, loaded
end

---@return any  nil when this executor can't require it (never throws)
function GameLib.Require(module)
    if GameLib.LoadEnds and osClock() >= GameLib.LoadEnds then
        GameLib.Missing[module.Name] = true
        warn("[SniperArena] require " .. module.Name .. ": load budget spent")
        return nil
    end

    local finished, ok, loaded = GameLib.RequireWithin(module, false)
    if ok then return loaded end
    if finished then
        local _, again, retried = GameLib.RequireWithin(module, true)
        if again then return retried end
    end
    GameLib.Missing[module.Name] = true
    warn("[SniperArena] require " .. module.Name .. ": " .. (finished and tostring(loaded) or "timed out"))
    return nil
end

---@param parent Instance?  expected folder; a moved module is still found anywhere in ReplicatedStorage
local function RequireChild(parent, name)
    local child = parent and parent:FindFirstChild(name)
    if not (child and child:IsA("ModuleScript")) then
        child = ReplicatedStorage:FindFirstChild(name, true)
    end
    if not (child and child:IsA("ModuleScript")) then
        GameLib.Missing[name] = "Absent"
        warn("[SniperArena] module " .. name .. " not found, features that need it are blocked")
        return nil
    end
    return GameLib.Require(child)
end

do
    local configFolder = ReplicatedStorage:FindFirstChild("Config")
    local remoteFolder = ReplicatedStorage:FindFirstChild("Remote")
    local constantFolder = ReplicatedStorage:FindFirstChild("Constant")
    GameLib.LoadEnds = osClock() + xDTaraZ.Config.RequireBudget

    for _, name in ipairs({ "WeaponConfig", "WrapConfig", "QuestConfig" }) do
        GameLib.Config[name] = RequireChild(configFolder, name)
    end
    GameLib.RarityColor = RequireChild(constantFolder, "RarityColor")

    local serviceNames = {
        "StatusService", "GachaService", "WeaponService", "QuestService", "EntityService",
        "CombatService", "GameService",
    }
    for _, name in ipairs(serviceNames) do
        GameLib.Service[name] = RequireChild(remoteFolder, name)
    end
    GameLib.CameraController = RequireChild(ReplicatedStorage:FindFirstChild("Client"), "CameraController")
    GameLib.WeaponController = RequireChild(ReplicatedStorage:FindFirstChild("Client"), "WeaponController")
    local gameService = remoteFolder and remoteFolder:FindFirstChild("GameService")
    GameLib.RoomManager = RequireChild(gameService, "RoomManager")
    GameLib.Status = RequireChild(constantFolder, "Status")
    GameLib.LoadEnds = nil
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

---@return number?  coin the server last replicated, nil when unreadable
function xDTaraZ.Player:Coin()
    local service = GameLib.Service.StatusService
    if not service then return nil end
    local key = GameLib.Status and GameLib.Status.Eco_Coin or "Eco_Coin"
    local ok, value = pcall(function() return service.GetStatus(key) end)
    return ok and tonumber(value) or nil
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
    local call = object[method]
    if type(call) ~= "function" then return nil, false end
    local ok, value = pcall(call, object)
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

xDTaraZ.Faults = { Streaks = {}, Said = {} }

---@param err any  the same error again stays quiet for FailWindow
function xDTaraZ.Faults.Say(name, err)
    local text, now = tostring(err), osClock()
    local last = xDTaraZ.Faults.Said[name]
    if last and last[1] == text and now - last[2] < xDTaraZ.Config.FailWindow then return end
    xDTaraZ.Faults.Said[name] = { text, now }
    warn("[SniperArena] " .. name .. ": " .. text)
end

function xDTaraZ.Faults.Clear(name)
    xDTaraZ.Faults.Streaks[name] = nil
end

function xDTaraZ.Faults.Wanted(toggles)
    for _, key in ipairs(toggles) do
        if xDTaraZ.Options[key] then return true end
    end
    return false
end

---@param restore function?  the feature's own off path
function xDTaraZ.Faults.Stop(name, err, toggles, restore)
    warn("[SniperArena] " .. name .. " stopped: " .. tostring(err))
    for _, key in ipairs(toggles) do
        xDTaraZ.Options[key] = false
    end
    if restore then Util.Try(name .. " restore", restore) end
    table.insert(xDTaraZ.State.Halted, { name, tostring(err):match("^[^\n]*"), toggles })
end

---@param toggles string[]   switched off when the feature keeps failing; empty = never stops, warns once per streak
---@param restore function?  run once when the feature is stopped
---@return boolean           true while the feature is stopped
function xDTaraZ.Faults.Report(name, err, toggles, restore)
    local now = osClock()
    local streak = xDTaraZ.Faults.Streaks[name]
    if not streak or (streak.Halted and xDTaraZ.Faults.Wanted(toggles)) then
        streak = { Count = 0, First = now, Warned = false, Halted = false }
        xDTaraZ.Faults.Streaks[name] = streak
    end
    streak.Count += 1
    if streak.Count == 1 then xDTaraZ.Faults.Say(name, err) end
    if streak.Warned then return streak.Halted end
    if streak.Count < xDTaraZ.Config.MaxFails or now - streak.First < xDTaraZ.Config.FailWindow then return false end

    streak.Warned = true
    if #toggles == 0 then
        warn("[SniperArena] " .. name .. " keeps failing: " .. tostring(err))
        return false
    end
    streak.Halted = true
    xDTaraZ.Faults.Stop(name, err, toggles, restore)
    return true
end

xDTaraZ.Scheduler = { Jobs = {}, Booted = false }

---@param toggles string[]?  options the job serves; turned off if it keeps failing
---@param restore function?  the job's off path, run once if it gets stopped
function xDTaraZ.Scheduler.Every(name, interval, work, toggles, restore)
    xDTaraZ.Scheduler.Jobs[name] = { Interval = interval, Fn = work, Last = 0, Running = false, Toggles = toggles or {}, Restore = restore }
end

---@return boolean  a stopped job comes back once one of its toggles is on again
function xDTaraZ.Scheduler.Revive(name, job)
    if not xDTaraZ.Faults.Wanted(job.Toggles) then return false end
    job.Halted = false
    xDTaraZ.Faults.Clear(name)
    return true
end

function xDTaraZ.Scheduler.Settle(name, job)
    local err = job.Error
    job.Error = nil
    if err then
        job.Halted = xDTaraZ.Faults.Report(name, err, job.Toggles, job.Restore)
    else
        xDTaraZ.Faults.Clear(name)
    end
end

function xDTaraZ.Scheduler.Step()
    if not xDTaraZ.State.Alive then return end
    local now = osClock()
    for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
        if job.Running then continue end
        if job.Error ~= nil then xDTaraZ.Scheduler.Settle(name, job) end
        if job.Halted and not xDTaraZ.Scheduler.Revive(name, job) then continue end
        if now - job.Last < job.Interval then continue end

        job.Last = now
        job.Running = true
        task.spawn(function()
            local ok, err = pcall(job.Fn)
            job.Error = (not ok) and tostring(err) or false
            job.Running = false
        end)
    end
end

function xDTaraZ.Scheduler.Boot()
    if xDTaraZ.Scheduler.Booted then return end
    xDTaraZ.Scheduler.Booted = true
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Scheduler.Step)
end

xDTaraZ.Banner = {
    Print = print,
    Started = osClock(),
    Last = osClock(),
    Done = 0,
    Total = 5,
    Art = [[
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
    Title = [[
  __  __    _    ____  ___ ___    _   _ _   _ ____
 |  \/  |  / \  |  _ \|_ _/ _ \  | | | | | | | __ )
 | |\/| | / _ \ | |_) || | | | | | |_| | | | |  _ \
 | |  | |/ ___ \|  _ < | | |_| | |  _  | |_| | |_) |
 |_|  |_/_/   \_\_| \_\___\___/  |_| |_|\___/|____/
]],
}

pcall(function()
    local renv = getrenv()
    if type(renv.print) == "function" then xDTaraZ.Banner.Print = renv.print end
end)

function xDTaraZ.Banner.Show()
    local ok, executor = pcall(identifyexecutor)
    if not ok or type(executor) ~= "string" then executor = "Unknown" end
    local rule = string.rep("=", 54)
    xDTaraZ.Banner.Print(table.concat({
        "",
        xDTaraZ.Banner.Art,
        xDTaraZ.Banner.Title,
        rule,
        "   SNIPER ARENA  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
        "   executor: " .. tostring(executor) .. "   //   player: " .. LocalPlayer.Name,
        rule,
    }, "\n"))
end

---@param label string  what just finished loading
function xDTaraZ.Banner.Step(label)
    local banner = xDTaraZ.Banner
    local now = osClock()
    banner.Done = math.min(banner.Done + 1, banner.Total)
    local filled = math.floor(banner.Done / banner.Total * 20 + 0.5)
    local bar = string.rep("#", filled) .. string.rep(".", 20 - filled)
    xDTaraZ.Banner.Print(string.format("[Mario Hub] [%s] %3d%%  %-24s +%dms",
        bar, math.floor(banner.Done / banner.Total * 100), label, math.floor((now - banner.Last) * 1000)))
    banner.Last = now
end

function xDTaraZ.Banner.Ready()
    local names = xDTaraZ.Config.BannerCaps
    local caps = 0
    for _, name in ipairs(names) do
        if xDTaraZ.Caps[name] then caps += 1 end
    end
    local rule = string.rep("=", 54)
    xDTaraZ.Banner.Print(table.concat({
        rule,
        string.format("   >> READY in %dms  //  caps %d/%d  //  LeftCtrl = menu",
            math.floor((osClock() - xDTaraZ.Banner.Started) * 1000), caps, #names),
        rule,
    }, "\n"))
end

pcall(xDTaraZ.Banner.Show)
pcall(xDTaraZ.Banner.Step, "Core")

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
    local conn = xDTaraZ.Player.AntiAfk.Connection
    xDTaraZ.Player.AntiAfk.Connection = nil
    if conn then conn:Disconnect() end
    xDTaraZ.Player.AntiAfk.Status = "Off"
end

function xDTaraZ.Player.AntiAfk.GetStatus()
    return xDTaraZ.Player.AntiAfk.Status
end

xDTaraZ.Player.Respawn = { Status = "Off", Count = 0, Fired = false }

function xDTaraZ.Player.Respawn.IsDead()
    local state = LocalPlayer:GetAttribute("State")
    if state == "Dead" or state == "Died" then return true end
    local hum = xDTaraZ.Player.Humanoid
    return hum ~= nil and hum.Health <= 0
end

function xDTaraZ.Player.Respawn.Fire()
    local gameService = xDTaraZ.GameLib.Service.GameService
    if gameService and gameService.CanFastRespawn and gameService.CanFastRespawn() then
        gameService.FastRespawn()
        return
    end
    local folder = ReplicatedStorage:FindFirstChild("Remote")
    local service = folder and folder:FindFirstChild("GameService")
    local remote = service and service:FindFirstChild("Respawn")
    if remote then remote:FireServer() end
end

function xDTaraZ.Player.Respawn.Reset()
    xDTaraZ.Player.Respawn.Fired = false
end

function xDTaraZ.Player.Respawn.Step()
    local respawn = xDTaraZ.Player.Respawn
    if not xDTaraZ.Options.FastRespawn then
        respawn.Status = "Off"
        return
    end
    local gameService = xDTaraZ.GameLib.Service.GameService
    if not (gameService and gameService.IsJoined and gameService.IsJoined()) then
        respawn.Status = "Not in game"
        return
    end
    if not respawn.IsDead() then
        respawn.Fired = false
        respawn.Status = "Alive · respawns " .. respawn.Count
        return
    end

    respawn.Status = "Respawning"
    if respawn.Fired then return end
    respawn.Fired = true
    respawn.Count += 1
    respawn.Fire()
end

function xDTaraZ.Player.Respawn.GetStatus()
    return xDTaraZ.Player.Respawn.Status
end

xDTaraZ.Player.Join = { Status = "Off", LastTry = 0 }

---@return BasePart?  the lobby pad that puts you in a round, while it says the round can be joined
function xDTaraZ.Player.Join.Pad()
    local lobby = Workspace:FindFirstChild("Lobby")
    local start = lobby and lobby:FindFirstChild("Start")
    local pad = start and start:FindFirstChild("Touch", true)
    if not (pad and pad:IsA("BasePart")) then return nil end
    for _, label in ipairs(start:GetDescendants()) do
        if label:IsA("TextLabel") and label.Text:find(xDTaraZ.Config.JoinText, 1, true) then return pad end
    end
    return nil
end

---Touches the lobby pad from where you stand, so you drop into the next round without walking there.
function xDTaraZ.Player.Join.Step()
    local join = xDTaraZ.Player.Join
    local root = xDTaraZ.Player.Root
    local pad = join.Pad()
    if not (root and root.Parent and pad) then
        join.Status = pad and "Waiting for character" or "In a round"
        return
    end
    if (root.Position - pad.Position).Magnitude > xDTaraZ.Config.JoinRange then
        join.Status = "In a round"
        return
    end
    if osClock() - join.LastTry < xDTaraZ.Config.JoinRetry then return end
    join.LastTry = osClock()
    join.Status = "Joining"
    firetouchinterest(root, pad, 0)
    task.wait(0.1)
    firetouchinterest(root, pad, 1)
end

xDTaraZ.Movement = { Booted = false, Dash = nil, Resolving = false }

---@return ModuleScript?  dash helper, searched by name if CombatHelper moved
function xDTaraZ.Movement.FindDash()
    local client = ReplicatedStorage:FindFirstChild("Client")
    local helper = client and client:FindFirstChild("CombatHelper")
    local dash = helper and helper:FindFirstChild("Dash")
    if dash and dash:IsA("ModuleScript") then return dash end
    helper = ReplicatedStorage:FindFirstChild("CombatHelper", true)
    dash = helper and helper:FindFirstChild("Dash")
    return dash and dash:IsA("ModuleScript") and dash or nil
end

function xDTaraZ.Movement.ResolveDash()
    local found = xDTaraZ.Movement.FindDash()
    xDTaraZ.Movement.Dash = found and GameLib.Require(found) or false
    xDTaraZ.Movement.Resolving = false
end

---@return table?  dash module once resolved, nil while the single require is still running
function xDTaraZ.Movement.DashHelper()
    local dash = xDTaraZ.Movement.Dash
    if dash ~= nil then return dash or nil end
    if xDTaraZ.Movement.Resolving then return nil end
    xDTaraZ.Movement.Resolving = true
    task.spawn(xDTaraZ.Movement.ResolveDash)
    return nil
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

xDTaraZ.Esp = { Count = 0, Rows = {} }

function xDTaraZ.Esp.Enabled()
    local visuals = xDTaraZ.Library and xDTaraZ.Library.Visuals
    return visuals ~= nil and visuals:Get("Enabled") == true
end

---@return any  stays the same while the entity lives, even when its model streams out
function xDTaraZ.Esp.KeyOf(entity, char)
    local inst = entity.Instance
    if typeof(inst) == "Instance" then return inst end
    return char or entity
end

---@return table?  row for Library.Visuals, nil for dead, local or missing entities
function xDTaraZ.Esp.Row(entity)
    if type(entity) ~= "table" or xDTaraZ.Entity.IsLocal(entity) then return nil end
    local char = xDTaraZ.Entity.Character(entity)
    local health, maxHealth = xDTaraZ.Entity.Health(entity)
    if not char or health <= 0 then return nil end

    local player = Players:GetPlayerFromCharacter(char)
    return {
        Model = char,
        Name = player and player.DisplayName or char.Name,
        Health = health,
        MaxHealth = maxHealth > 0 and maxHealth or 100,
        Friendly = xDTaraZ.Entity.Friendly(entity),
        Root = xDTaraZ.Entity.Root(entity),
    }
end

---@param now number  rows unseen for longer than EspGrace are dropped
function xDTaraZ.Esp.Expire(seen, now)
    local grace = xDTaraZ.Config.EspGrace
    for key, held in pairs(xDTaraZ.Esp.Rows) do
        if seen[key] then continue end
        local row = held.Row
        local alive = row.Model.Parent and row.Root and row.Root.Parent
        if now - held.Seen > grace or not alive then xDTaraZ.Esp.Rows[key] = nil end
    end
end

function xDTaraZ.Esp.Step()
    if not xDTaraZ.Esp.Enabled() then
        table.clear(xDTaraZ.Esp.Rows)
        xDTaraZ.State.EspSnapshot = {}
        xDTaraZ.Esp.Count = 0
        return
    end

    local now, seen = osClock(), {}
    for _, entity in pairs(xDTaraZ.Entity.List()) do
        local row = xDTaraZ.Esp.Row(entity)
        if not row then continue end
        local key = xDTaraZ.Esp.KeyOf(entity, row.Model)
        local held = xDTaraZ.Esp.Rows[key]
        if not row.Root and held then row.Root = held.Row.Root end
        seen[key] = true
        xDTaraZ.Esp.Rows[key] = { Row = row, Seen = now }
    end
    xDTaraZ.Esp.Expire(seen, now)

    local snapshot = {}
    for _, held in pairs(xDTaraZ.Esp.Rows) do
        table.insert(snapshot, held.Row)
    end
    xDTaraZ.State.EspSnapshot = snapshot
    xDTaraZ.Esp.Count = #snapshot
end

---@return table[]  last snapshot from the scheduler, never touches game modules
function xDTaraZ.Esp.Targets()
    return xDTaraZ.State.EspSnapshot
end

function xDTaraZ.Esp.GetStatus()
    if not xDTaraZ.Esp.Enabled() then return "Off" end
    return xDTaraZ.Esp.Count .. " targets"
end

---@param probe function  re-read until it differs from before or ResultWait runs out
---@return any             value after the wait
local function AwaitChange(before, probe)
    local deadline = osClock() + xDTaraZ.Config.ResultWait
    local now = probe()
    while now == before and osClock() < deadline do
        task.wait(0.2)
        now = probe()
    end
    return now
end

xDTaraZ.Shop = { Status = "Off", LastResult = "" }

---@return string[]  case keys the player actually owns (from the gacha store)
function xDTaraZ.Shop.Cases()
    local service = GameLib.Service.GachaService
    local store = service and service.LocalGachaStore
    local cases = store and store.Data
    if type(cases) ~= "table" then return {} end
    local keys = {}
    for key, entry in pairs(cases) do
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

---@return number  cases the owned count really dropped by
function xDTaraZ.Shop.Open(caseKey, count)
    local service = GameLib.Service.GachaService
    if not service then return 0 end
    local before = xDTaraZ.Shop.Owned(caseKey)
    count = math.min(count, before)
    if count < 1 then return 0 end

    local ok, err = pcall(function() return service.Gacha(caseKey, count) end)
    if not ok then
        warn("[SniperArena] open " .. caseKey .. ": " .. tostring(err))
        return 0
    end
    local after = AwaitChange(before, function() return xDTaraZ.Shop.Owned(caseKey) end)
    return math.max(before - after, 0)
end

function xDTaraZ.Shop.OpenAllNow()
    local opened = 0
    for _, caseKey in ipairs(xDTaraZ.Shop.Cases()) do
        local owned = xDTaraZ.Shop.Owned(caseKey)
        if owned < 1 then continue end
        opened += xDTaraZ.Shop.Open(caseKey, math.min(owned, math.max(xDTaraZ.Options.OpenCount, 1)))
        task.wait(xDTaraZ.Config.OpenDelay)
    end
    xDTaraZ.Shop.LastResult = opened > 0 and (opened .. " cases opened") or "no case opened"
    return xDTaraZ.Shop.LastResult
end

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

---@return table?  skin names of the weapons you hold (the loadout has no inventory id), nil when unknown
function xDTaraZ.Sell.Equipped()
    local combat = GameLib.Service.CombatService
    if not combat then return nil end
    local ok, weapons = pcall(function() return combat.GetWeapons() end)
    if not ok or type(weapons) ~= "table" then return nil end

    local set, count = {}, 0
    for _, weapon in pairs(weapons) do
        if type(weapon) == "table" and type(weapon.Name) == "string" then
            set[weapon.Name] = true
            count += 1
        end
    end
    return count > 0 and set or nil
end

---@return string[]?  uids to sell, the priciest KeepPerRarity of each rarity stay; nil when equipped is unknown
function xDTaraZ.Sell.Pick()
    local equipped = xDTaraZ.Sell.Equipped()
    if not equipped then return nil end
    local wanted = Util.SetFromList(xDTaraZ.Options.SellRarities)
    local ceiling = xDTaraZ.Options.MaxSellPrice

    local owned = xDTaraZ.Sell.Inventory()
    table.sort(owned, function(left, right) return left.Price > right.Price end)

    local kept, uids = {}, {}
    for _, weapon in ipairs(owned) do
        if not (weapon.Rarity and wanted[weapon.Rarity]) or equipped[weapon.Name] then continue end
        kept[weapon.Rarity] = (kept[weapon.Rarity] or 0) + 1
        if kept[weapon.Rarity] <= xDTaraZ.Options.KeepPerRarity then continue end
        if ceiling <= 0 or weapon.Price <= ceiling then table.insert(uids, weapon.Uid) end
    end
    return uids
end

function xDTaraZ.Sell.SellNow()
    local service = GameLib.Service.WeaponService
    if not service then xDTaraZ.Sell.LastResult = "no service" return xDTaraZ.Sell.LastResult end

    local uids = xDTaraZ.Sell.Pick()
    if not uids then
        xDTaraZ.Sell.LastResult = "equipped weapons unknown, nothing sold"
        return xDTaraZ.Sell.LastResult
    end
    if #uids == 0 then
        xDTaraZ.Sell.LastResult = "nothing to sell"
        return xDTaraZ.Sell.LastResult
    end

    local countBefore, coinBefore = #xDTaraZ.Sell.Inventory(), xDTaraZ.Player:Coin()
    local ok, err = pcall(function() return service.Sell(uids) end)
    if not ok then
        xDTaraZ.Sell.LastResult = "sell failed: " .. tostring(err)
        return xDTaraZ.Sell.LastResult
    end

    local countAfter = AwaitChange(countBefore, function() return #xDTaraZ.Sell.Inventory() end)
    local coinAfter = xDTaraZ.Player:Coin()
    local gained = (coinBefore and coinAfter) and (" · +" .. (coinAfter - coinBefore) .. " coin") or ""
    xDTaraZ.Sell.LastResult = math.max(countBefore - countAfter, 0) .. " sold" .. gained
    return xDTaraZ.Sell.LastResult
end

function xDTaraZ.Sell.Step()
    if not xDTaraZ.Options.AutoSell then xDTaraZ.Sell.Status = "Off" return end
    xDTaraZ.Sell.Status = xDTaraZ.Sell.SellNow()
end

function xDTaraZ.Sell.GetStatus()
    return xDTaraZ.Options.AutoSell and xDTaraZ.Sell.Status or "Off"
end

xDTaraZ.Collect = { Status = "Off", LastResult = "" }

---@return boolean  false when the game can't answer
function xDTaraZ.Collect.IsClaimed(questId)
    local service = GameLib.Service.QuestService
    local ok, claimed = pcall(function() return service.IsClaimed(questId) end)
    return ok and claimed == true
end

---@return any[]  quest ids the game marks finished and not yet claimed
function xDTaraZ.Collect.Claimable()
    local service = GameLib.Service.QuestService
    local quests = GameLib.Config.QuestConfig
    if not (service and type(quests) == "table") then return {} end

    local list = {}
    for questId in pairs(quests) do
        local asked, finished = pcall(function() return service.IsFinished(questId) end)
        if asked and finished and not xDTaraZ.Collect.IsClaimed(questId) then
            list[#list + 1] = questId
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
    for _, questId in ipairs(ids) do
        local ok, err = pcall(function() return service.ClaimReward(questId) end)
        if not ok then
            warn("[SniperArena] claim " .. tostring(questId) .. ": " .. tostring(err))
        elseif AwaitChange(false, function() return xDTaraZ.Collect.IsClaimed(questId) end) then
            claimed += 1
        end
        task.wait(xDTaraZ.Config.ClaimDelay)
    end
    xDTaraZ.Collect.LastResult = claimed .. "/" .. #ids .. " quests claimed"
    return xDTaraZ.Collect.LastResult
end

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
    local opts = xDTaraZ.Options
    return opts.Aimbot or opts.SilentAim or opts.Ragebot or opts.TriggerBot or opts.ShowFov
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
    local originFn = xDTaraZ.Combat.OriginFn
    if not originFn then
        local camCtrl = xDTaraZ.GameLib.CameraController
        originFn = camCtrl and camCtrl.GetCombatOriginFn and camCtrl.GetCombatOriginFn()
        xDTaraZ.Combat.OriginFn = originFn
    end
    if originFn then
        local ok, origin, detect = pcall(originFn)
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
        local cam = Workspace.CurrentCamera
        local part = xDTaraZ.Combat.Part
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

xDTaraZ.Combat.SilentSaved = setmetatable({}, { __mode = "k" })

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
    local saved = xDTaraZ.Combat.SilentSaved[shooter]
    local entity = xDTaraZ.Combat.Target
    if not (xDTaraZ.Combat.SilentActive() and entity and xDTaraZ.Combat.OriginOverride()) then return saved.Fn(shooter, opts) end
    if math.random(100) > xDTaraZ.Options.HitChance then return saved.Fn(shooter, opts) end

    local bone = math.random(100) <= xDTaraZ.Options.HeadChance and "Head" or "Body"
    local part = xDTaraZ.Combat.BonePart(entity, bone)
    if not (part and part.Parent) then return saved.Fn(shooter, opts) end
    return xDTaraZ.Combat.ShootAt(shooter, entity, part, opts)
end

---@return CFrame  camera the server is told we look through
function xDTaraZ.Combat.ReportedLook(...)
    local look = xDTaraZ.Combat.LookSource(...)
    local part = xDTaraZ.Combat.Part
    if typeof(look) ~= "CFrame" or not (xDTaraZ.Combat.SilentActive() and xDTaraZ.Combat.Target and part and part.Parent) then return look end
    return CFrame.lookAt(look.Position, xDTaraZ.Combat.Predict(part))
end

---@return table[]  tables that really hold CameraController's functions
function xDTaraZ.Combat.LookTables()
    local camCtrl = xDTaraZ.GameLib.CameraController
    local tables = {}
    if type(camCtrl) ~= "table" then return tables end
    if rawget(camCtrl, "GetCFrame") and not table.isfrozen(camCtrl) then tables[1] = camCtrl end
    local meta = Util.GetRawMetatable and Util.GetRawMetatable(camCtrl)
    local index = type(meta) == "table" and rawget(meta, "__index")
    if type(index) == "table" then index = { index } elseif type(index) == "function" and Util.GetUpvalues then index = Util.GetUpvalues(index) else index = {} end
    for _, holder in pairs(index) do
        if type(holder) == "table" and type(rawget(holder, "GetCFrame")) == "function" and not table.isfrozen(holder) then
            tables[#tables + 1] = holder
        end
    end
    return tables
end

function xDTaraZ.Combat.ApplyLook()
    if xDTaraZ.Combat.LookSource ~= nil then return end
    local tables = xDTaraZ.Combat.LookTables()
    if #tables == 0 then
        xDTaraZ.Combat.LookSource = false
        return
    end
    xDTaraZ.Combat.LookSource = rawget(tables[1], "GetCFrame")
    xDTaraZ.Combat.LookHolders = tables
    for _, holder in ipairs(tables) do rawset(holder, "GetCFrame", xDTaraZ.Combat.ReportedLook) end
end

function xDTaraZ.Combat.RestoreLook()
    local source = xDTaraZ.Combat.LookSource
    if not source then
        xDTaraZ.Combat.LookSource = nil
        return
    end
    for _, holder in ipairs(xDTaraZ.Combat.LookHolders or {}) do
        if rawget(holder, "GetCFrame") == xDTaraZ.Combat.ReportedLook then rawset(holder, "GetCFrame", source) end
    end
    xDTaraZ.Combat.LookSource, xDTaraZ.Combat.LookHolders = nil, nil
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

xDTaraZ.Combat.ScopeSaved = setmetatable({}, { __mode = "k" })

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

---@return table  { Drawing = circle }, or { Frame = ring } as a Gui circle when Drawing is missing
function xDTaraZ.Combat.MakeCircle()
    local color = xDTaraZ.Config.FovColor
    if xDTaraZ.Caps.Drawing then
        local circle = Drawing.new("Circle")
        circle.Thickness, circle.NumSides, circle.Filled = 1.5, 64, false
        circle.Color = color
        return { Drawing = circle }
    end

    local ring = Instance.new("Frame")
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.BackgroundTransparency = 1
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ring
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 1.5
    stroke.Parent = ring
    ring.Parent = Util.Overlay()
    return { Frame = ring }
end

function xDTaraZ.Combat.SetCircleVisible(visible)
    local circle = xDTaraZ.Combat.Circle
    if not circle then return end
    if circle.Drawing then circle.Drawing.Visible = visible else circle.Frame.Visible = visible end
end

function xDTaraZ.Combat.UpdateCircle()
    if not xDTaraZ.Options.ShowFov then
        xDTaraZ.Combat.SetCircleVisible(false)
        return
    end
    local circle = xDTaraZ.Combat.Circle
    if not circle then
        circle = xDTaraZ.Combat.MakeCircle()
        xDTaraZ.Combat.Circle = circle
    end

    local center = xDTaraZ.Combat.AimCenter(Workspace.CurrentCamera)
    local radius = xDTaraZ.Options.AimFov
    if circle.Drawing then
        circle.Drawing.Position, circle.Drawing.Radius, circle.Drawing.Visible = center, radius, true
        return
    end
    circle.Frame.Position = UDim2.fromOffset(center.X, center.Y)
    circle.Frame.Size = UDim2.fromOffset(radius * 2, radius * 2)
    circle.Frame.Visible = true
end

function xDTaraZ.Combat.DrawCircle()
    local ok, err = pcall(xDTaraZ.Combat.UpdateCircle)
    if ok then
        xDTaraZ.Faults.Clear("FOV circle")
    else
        xDTaraZ.Faults.Report("FOV circle", err, { "ShowFov" })
    end
end

xDTaraZ.Combat.RecoilSaved = setmetatable({}, { __mode = "k" })
xDTaraZ.Combat.ZoomSaved = setmetatable({}, { __mode = "k" })

function xDTaraZ.Combat.ApplyNoRecoil()
    local weapon = xDTaraZ.Combat.Shooter()
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

xDTaraZ.Combat.SpreadSaved = setmetatable({}, { __mode = "k" })

function xDTaraZ.Combat.ZeroSpread()
    return 0
end

function xDTaraZ.Combat.ApplyNoSpread()
    local _, shooter = xDTaraZ.Combat.Shooter()
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
    if not xDTaraZ.State.Alive then return end
    local opts = xDTaraZ.Options

    if opts.NoRecoil then
        xDTaraZ.Combat.ApplyNoRecoil()
    elseif next(xDTaraZ.Combat.RecoilSaved) or next(xDTaraZ.Combat.ZoomSaved) then
        xDTaraZ.Combat.RestoreRecoil()
    end
    if opts.NoSpread then
        xDTaraZ.Combat.ApplyNoSpread()
    elseif next(xDTaraZ.Combat.SpreadSaved) then
        xDTaraZ.Combat.RestoreSpread()
    end
    if opts.InstantScope or opts.Ragebot or opts.SilentAim then
        xDTaraZ.Combat.ApplyInstantScope()
    elseif next(xDTaraZ.Combat.ScopeSaved) then
        xDTaraZ.Combat.RestoreScope()
    end

    if xDTaraZ.Combat.SilentActive() then
        xDTaraZ.Combat.ApplySilent()
        xDTaraZ.Combat.ApplyLook()
        return
    end
    if next(xDTaraZ.Combat.SilentSaved) then xDTaraZ.Combat.RestoreSilent() end
    xDTaraZ.Combat.RestoreLook()
end

function xDTaraZ.Combat.Aim(mode)
    local target, part = xDTaraZ.Combat.SelectTarget()
    if target ~= xDTaraZ.Combat.Target then xDTaraZ.Combat.LockedSince = os.clock() end
    xDTaraZ.Combat.Target, xDTaraZ.Combat.Part = target, part
    xDTaraZ.Combat.State = target and "Locked" or "Acquire"
    local char = target and xDTaraZ.Entity.Character(target)
    xDTaraZ.Combat.Status = mode .. " · " .. (char and char.Name or "no target")
end

function xDTaraZ.Combat.Step()
    xDTaraZ.Combat.Patches()
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
    if xDTaraZ.Combat.AimActive() then xDTaraZ.Combat.BindCamera() else xDTaraZ.Combat.UnbindCamera() end
    if xDTaraZ.Combat.AimActive() or xDTaraZ.Combat.SilentActive() then
        xDTaraZ.Combat.Aim(mode)
    else
        xDTaraZ.Combat.Target, xDTaraZ.Combat.Part = nil, nil
        xDTaraZ.Combat.State, xDTaraZ.Combat.Status = "Ready", mode .. " · aim idle"
    end

    local settled = xDTaraZ.Combat.Target ~= nil and os.clock() - xDTaraZ.Combat.LockedSince >= xDTaraZ.Config.LookSettle
    local shoot = (xDTaraZ.Options.Ragebot and settled) or (xDTaraZ.Options.TriggerBot and xDTaraZ.Combat.CrosshairOnEnemy())
    if shoot and xDTaraZ.Combat.Fire() then xDTaraZ.Combat.State = "Fired" end
end

function xDTaraZ.Combat.Stop()
    xDTaraZ.Combat.UnbindCamera()
    xDTaraZ.Combat.Target, xDTaraZ.Combat.Part = nil, nil
    xDTaraZ.Combat.State, xDTaraZ.Combat.Status = "Idle", "Off"
end

function xDTaraZ.Combat.Rest()
    local undo = {
        xDTaraZ.Combat.Stop, xDTaraZ.Combat.RestoreRecoil, xDTaraZ.Combat.RestoreSpread,
        xDTaraZ.Combat.RestoreScope, xDTaraZ.Combat.RestoreSilent, xDTaraZ.Combat.RestoreLook,
    }
    for _, restore in ipairs(undo) do
        Util.Try("combat restore", restore)
    end
end

function xDTaraZ.Combat.Unload()
    xDTaraZ.Combat.Rest()
    local circle = xDTaraZ.Combat.Circle
    xDTaraZ.Combat.Circle = nil
    if not circle then return end
    if circle.Frame then
        circle.Frame:Destroy()
    else
        pcall(function() circle.Drawing:Remove() end)
    end
end

function xDTaraZ.Combat.GetStatus()
    return xDTaraZ.Combat.Status
end

xDTaraZ.Skin = {
    Catalog = {},
    Types = {},
    Rarities = {},
    Labels = {},
    Images = {},
    Colors = {},
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
        local rarity = tostring(cfg.Rarity or "Common")
        table.insert(byFamily[family], { key, rarity, type(cfg.Display) == "string" and cfg.Display or key, type(cfg.Image) == "string" and cfg.Image or nil })
        if not table.find(xDTaraZ.Skin.Rarities, rarity) then table.insert(xDTaraZ.Skin.Rarities, rarity) end
    end
    table.sort(xDTaraZ.Skin.Types)
    table.sort(xDTaraZ.Skin.Rarities, function(left, right)
        local rankLeft, rankRight = xDTaraZ.Skin.RarityRank[left] or 0, xDTaraZ.Skin.RarityRank[right] or 0
        if rankLeft ~= rankRight then return rankLeft > rankRight end
        return left < right
    end)
    for _, byFamily in pairs(xDTaraZ.Skin.Catalog) do
        for _, list in pairs(byFamily) do
            table.sort(list, function(left, right)
                local rankLeft, rankRight = xDTaraZ.Skin.RarityRank[left[2]] or 0, xDTaraZ.Skin.RarityRank[right[2]] or 0
                if rankLeft ~= rankRight then return rankLeft > rankRight end
                return left[3] < right[3]
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
    local filter = rarities and next(rarities) ~= nil and rarities or nil
    for _, skin in ipairs(list) do
        if filter and not filter[skin[2]] then continue end
        local label = string.format("[%s] %s", skin[2], skin[3])
        if xDTaraZ.Skin.Labels[label] and xDTaraZ.Skin.Labels[label] ~= skin[1] then label = label .. " · " .. skin[1] end
        xDTaraZ.Skin.Labels[label] = skin[1]
        xDTaraZ.Skin.Images[label] = skin[4]
        local colors = xDTaraZ.GameLib.RarityColor
        xDTaraZ.Skin.Colors[label] = type(colors) == "table" and typeof(colors[skin[2]]) == "Color3" and colors[skin[2]] or nil
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

xDTaraZ.UI = { Labels = {}, Shown = {}, Stats = { Cases = 0, Quests = 0 } }
local Library, T

function xDTaraZ.UI.Detach(handler)
    return function(...)
        local packed = table.pack(...)
        task.defer(function()
            local ok, err = pcall(handler, table.unpack(packed, 1, packed.n))
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

function xDTaraZ.UI.SampleStats()
    local cases = 0
    for _, caseKey in ipairs(xDTaraZ.Shop.Cases()) do
        cases += xDTaraZ.Shop.Owned(caseKey)
    end
    xDTaraZ.UI.Stats.Cases = cases
    xDTaraZ.UI.Stats.Quests = #xDTaraZ.Collect.Claimable()
end

---@param title table  T() pair; the UI pump shows it, game-module threads can't
function xDTaraZ.UI.Notice(title, text, kind)
    table.insert(xDTaraZ.State.Notices, { title, tostring(text), kind })
end

function xDTaraZ.UI.BuildMain(window)
    window:AddTabSection(T("Main", "หลัก"))
    local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and links", "สถานะและลิงก์"))

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
    xDTaraZ.UI.Labels.Esp = status:AddParagraph({ Title = T("ESP", "ESP"), Content = "-" })
    xDTaraZ.UI.Labels.Combat = status:AddParagraph({ Title = T("Combat", "การต่อสู้"), Content = "-" })
    xDTaraZ.UI.Labels.Skin = status:AddParagraph({ Title = T("Skin", "สกิน"), Content = "-" })
    xDTaraZ.UI.Labels.Economy = status:AddParagraph({ Title = T("Economy", "เศรษฐกิจ"), Content = "-" })

    local live = tab:AddRightGroupbox(T("Live", "ตัวเลขสด"), "coin")
    xDTaraZ.UI.Labels.Targets = live:AddParagraph({ Title = T("Enemies seen", "ศัตรูที่เห็น"), Content = "0" })
    xDTaraZ.UI.Labels.Cases = live:AddParagraph({ Title = T("Cases owned", "กล่องที่มี"), Content = "0" })
    xDTaraZ.UI.Labels.Quests = live:AddParagraph({ Title = T("Quests ready", "เควสต์รอรับ"), Content = "0" })

    local discord = tab:AddRightGroupbox(T("Discord", "ดิสคอร์ด"), "link")
    discord:AddLabel(xDTaraZ.Config.Discord)
    discord:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ดิสคอร์ด"), Func = xDTaraZ.UI.Detach(function()
        if Util.Copy(xDTaraZ.Config.Discord) then
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

function xDTaraZ.UI.GuardSilent()
    local reason = T("Not supported on this executor", "ใช้กับ executor นี้ไม่ได้")
    for _, idx in ipairs({ "SilentAim", "Ragebot" }) do
        Library.Compat.NeedCap(idx, "Upvalues")
        if not xDTaraZ.Caps.LookSpoof then Library.Compat.Block(idx, reason) end
    end
end

function xDTaraZ.UI.BuildCombat(window)
    window:AddTabSection(T("Combat", "การต่อสู้"))
    local tab = window:AddTab(T("Combat", "การต่อสู้"), "target", T("Aimbot and firing", "เล็งอัตโนมัติและยิง"))

    local aim = tab:AddLeftGroupbox(T("Aimbot", "เล็งอัตโนมัติ"), "crosshair")
    aim:AddToggle("Aimbot", {
        Text = T("Aimbot", "เล็งอัตโนมัติ"),
        Description = T("Locks onto the enemy nearest your crosshair", "ล็อคศัตรูที่ใกล้เป้าเล็งที่สุด"),
    }):AddKeyPicker("AimbotKey", { Default = "MB2", Mode = "Hold" })
    aim:AddDropdown("AimPriority", { Text = T("Target priority", "เลือกเป้าตาม"), Values = { "Crosshair", "Mouse", "Distance", "Health" }, Default = "Crosshair" })
    aim:AddSlider("AimMaxDistance", { Text = T("Max aim distance", "ระยะเล็งสูงสุด"), Min = 50, Max = 2000, Default = 1000, Suffix = "m" })
    aim:AddDropdown("AimBone", { Text = T("Aim part", "จุดเล็ง"), Values = { "Head", "Body", "Arm", "Leg" }, Default = "Head" })
    aim:AddSlider("AimSmooth", { Text = T("Smoothness", "ความนุ่ม"), Min = 1, Max = 20, Default = 1, Rounding = 0 })
    aim:AddSlider("AimPrediction", { Text = T("Prediction", "เล็งดักหน้า"), Min = 0, Max = 200, Default = 60, Suffix = "ms", Rounding = 0 })
    aim:AddSlider("AimFov", { Text = T("FOV", "ระยะมอง"), Min = 20, Max = 600, Default = 150, Suffix = "px" })
    aim:AddToggle("ShowFov", { Text = T("Show FOV circle", "แสดงวงระยะมอง") })
    aim:AddCheckbox("AimWallCheck", { Text = T("Visible only", "เฉพาะที่มองเห็น"), Default = true })
    aim:AddCheckbox("AimTeamCheck", { Text = T("Team check", "เช็คทีม"), Default = true })

    local rage = tab:AddRightGroupbox(T("Rage", "เรจ"), "bomb")
    rage:AddToggle("Ragebot", { Text = T("Ragebot", "เรจบอท"), Description = T("Shoots every visible enemy on its own, view stays still", "ยิงศัตรูทุกตัวที่มองเห็นเอง กล้องไม่ขยับ") })
        :AddKeyPicker("RagebotKey", { Default = "None", Mode = "Toggle" })
    rage:AddToggle("SilentAim", { Text = T("Silent aim", "ไซเลนต์เอม"), Description = T("Shots land on the target inside the FOV, your view never moves", "กระสุนเข้าเป้าในวง FOV กล้องไม่ขยับเลย") })
        :AddKeyPicker("SilentAimKey", { Default = "None", Mode = "Toggle" })
    rage:AddSlider("HitChance", { Text = T("Hit chance", "โอกาสยิงโดน"), Min = 0, Max = 100, Default = 100, Suffix = "%", Rounding = 0 })
    rage:AddSlider("HeadChance", { Text = T("Headshot chance", "โอกาสเข้าหัว"), Min = 0, Max = 100, Default = 100, Suffix = "%", Rounding = 0 })
    rage:AddToggle("InstantScope", { Text = T("Fast scope", "เปิดสโคปเร็ว"), Description = T("Cuts the wait before the scope is ready", "ลดเวลารอก่อนสโคปพร้อมยิง") })

    local fire = tab:AddRightGroupbox(T("Firing", "การยิง"), "swords")
    fire:AddToggle("TriggerBot", { Text = T("Trigger bot", "ยิงอัตโนมัติ"), Description = T("Fires the moment your crosshair is on an enemy", "ยิงทันทีเมื่อเป้าเล็งทับศัตรู") })
        :AddKeyPicker("TriggerBotKey", { Default = "None", Mode = "Toggle" })
    fire:AddToggle("NoSpread", { Text = T("No spread", "ยิงไม่กระจาย"), Description = T("Shots stay accurate while moving or jumping", "ยิงแม่นแม้ตอนเดินหรือกระโดด") })
    fire:AddToggle("NoRecoil", { Text = T("No recoil", "ไม่มีแรงถีบ"), Description = T("Camera no longer kicks when firing", "กล้องไม่เด้งตอนยิง") })

    xDTaraZ.UI.GuardSilent()
end

function xDTaraZ.UI.BuildPlayer(window)
    window:AddTabSection(T("Player", "ผู้เล่น"))
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "oneup", T("Respawn and utility", "เกิดใหม่และอรรถประโยชน์"))

    local util = tab:AddLeftGroupbox(T("Utility", "อรรถประโยชน์"), "gear")
    util:AddToggle("FastRespawn", { Text = T("Fast respawn", "เกิดใหม่เร็ว"), Description = T("Back in the fight the moment you die", "กลับเข้าสนามทันทีที่ตาย") })
    util:AddToggle("AutoJoin", { Text = T("Auto join round", "เข้ารอบอัตโนมัติ"), Description = T("Joins the next round from the lobby by itself", "เข้ารอบถัดไปจากล็อบบี้เอง") })
    Library.Compat.NeedCap("AutoJoin", "Touch")
    util:AddToggle("AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK"), Callback = xDTaraZ.UI.StartStop(xDTaraZ.Player.AntiAfk) })

    local move = tab:AddRightGroupbox(T("Movement", "การเคลื่อนที่"), "zap")
    move:AddToggle("InfiniteDash", { Text = T("Infinite dash", "พุ่งไม่จำกัด"), Description = T("Dash again without waiting (FFA/TDM)", "พุ่งซ้ำได้ไม่ต้องรอ (FFA/TDM)") })
end

xDTaraZ.UI.SkinKinds = {
    Sniper = { "Snipers", "สไนเปอร์", "crosshair" },
    Rifle = { "Rifles", "ไรเฟิล", "target" },
    Melee = { "Knives", "มีด", "swords" },
    Glove = { "Gloves", "ถุงมือ", "shield" },
}

---@param kind string  WeaponType from the game config
function xDTaraZ.UI.BuildSkinGroup(tab, kind, left)
    local meta = xDTaraZ.UI.SkinKinds[kind] or { kind, kind, "star" }
    local group = left and tab:AddLeftGroupbox(T(meta[1], meta[2]), meta[3]) or tab:AddRightGroupbox(T(meta[1], meta[2]), meta[3])
    local families = xDTaraZ.Skin.Families(kind)
    local weaponIdx, skinIdx = "Skin" .. kind .. "Weapon", "Skin" .. kind .. "Pick"

    local function Family()
        local picker = Library.Options[weaponIdx]
        return picker and picker.Value
    end

    local function Refill()
        local picker = Library.Options[skinIdx]
        if picker then picker:SetValues(xDTaraZ.Skin.List(kind, Family(), Util.SetFromList(xDTaraZ.Options.SkinRarities))) end
    end
    table.insert(xDTaraZ.UI.SkinRefill, Refill)

    group:AddDropdown(weaponIdx, { Text = T("Weapon", "อาวุธ"), Values = families, Default = families[1], Searchable = true, Callback = function() Refill() end })
    group:AddDropdown(skinIdx, {
        Text = T("Skin", "สกิน"),
        Values = xDTaraZ.Skin.List(kind, families[1], {}),
        Images = xDTaraZ.Skin.Images,
        Colors = xDTaraZ.Skin.Colors,
        Searchable = true,
        AllowNull = true,
        Callback = function(label)
            if Family() then xDTaraZ.Skin.Choose(Family(), label) end
        end,
    })
    group:AddButton({ Text = T("Use default skin", "ใช้สกินเดิม"), Func = function()
        if Family() then xDTaraZ.Skin.Choose(Family(), nil) end
        Library.Options[skinIdx]:SetValue(nil)
    end })
end

function xDTaraZ.UI.BuildSkins(window)
    xDTaraZ.UI.SkinRefill = {}
    local tab = window:AddTab(T("Skins", "สกิน"), "star", T("Every weapon, knife and glove skin", "สกินปืน มีด และถุงมือทุกแบบ"))

    local main = tab:AddLeftGroupbox(T("Skin Changer", "เปลี่ยนสกิน"), "star")
    main:AddToggle("SkinChanger", { Text = T("Skin changer", "เปลี่ยนสกิน"), Description = T("Pick any skin per weapon, only you see it", "เลือกสกินรายอาวุธได้ทุกแบบ เห็นแค่ตัวเอง") })
    local filter = main:AddDropdown("SkinRarities", {
        Text = T("Show rarities", "แสดงเฉพาะ rarity"),
        Description = T("Empty shows everything", "ไม่เลือก = แสดงทั้งหมด"),
        Values = xDTaraZ.Skin.Rarities,
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

    local leftRows, rightRows = xDTaraZ.Config.SkinMainRows, 0
    for _, kind in ipairs(xDTaraZ.Skin.Types) do
        local left = leftRows < rightRows
        Util.Try("skins " .. kind, xDTaraZ.UI.BuildSkinGroup, tab, kind, left)
        if left then
            leftRows += xDTaraZ.Config.SkinGroupRows
        else
            rightRows += xDTaraZ.Config.SkinGroupRows
        end
    end
end

function xDTaraZ.UI.BuildVisuals(window)
    window:AddTabSection(T("Visuals", "การมองเห็น"))
    Util.Try("visuals tab", function()
        window:AddVisualsTab({ Provider = xDTaraZ.Esp.Targets, Preview = true })
    end)
    Util.Try("skins tab", xDTaraZ.UI.BuildSkins, window)
end

---@return table  rarities to sell: every known rarity not kept
function xDTaraZ.UI.SellSet(keep)
    local kept, sell = Util.SetFromList(keep), {}
    for _, rarity in ipairs(xDTaraZ.Sell.Rarities()) do
        if not kept[rarity] then sell[rarity] = true end
    end
    return sell
end

---@param sold table  rarity list an older save picked to sell
---@return string[]   the same choice as rarities to keep
function xDTaraZ.UI.KeepFromSold(sold)
    local selling, keep = Util.SetFromList(sold), {}
    for _, rarity in ipairs(xDTaraZ.Sell.Rarities()) do
        if not selling[rarity] then table.insert(keep, rarity) end
    end
    return keep
end

---@param keep table  KeepRarities dropdown; old saves that only have SellRarities load into it
function xDTaraZ.UI.AdoptOldSellSave(group, keep)
    local old = group:AddDropdown("SellRarities", {
        Text = T("Sell rarities", "rarity ที่จะขาย"),
        Values = xDTaraZ.Sell.Rarities(),
        Multi = true,
        Default = {},
        AllowNull = true,
    })
    old:SetVisible(false)
    old.Serialize = false
    old.Deserialize = function(_, saved)
        keep:SetValue(xDTaraZ.UI.KeepFromSold(saved))
    end
end

function xDTaraZ.UI.BuildEconomy(window)
    window:AddTabSection(T("Economy", "เศรษฐกิจ"))
    local tab = window:AddTab(T("Economy", "เศรษฐกิจ"), "coin", T("Cases, selling, quests", "เปิดกล่อง ขาย เควสต์"))

    local cases = tab:AddLeftGroupbox(T("Cases", "กล่องสุ่ม"), "qblock")
    cases:AddToggle("AutoOpenCases", { Text = T("Auto open owned cases", "เปิดกล่องที่มีอัตโนมัติ") })
    cases:AddSlider("OpenCount", { Text = T("Open per case", "เปิดต่อกล่อง"), Min = 1, Max = 10, Default = 1 })
    cases:AddButton({ Text = T("Open All Now", "เปิดทั้งหมดตอนนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notice(T("Cases", "กล่องสุ่ม"), xDTaraZ.Shop.OpenAllNow(), "Coin")
    end) })

    local sell = tab:AddRightGroupbox(T("Sell", "ขาย"), "shop")
    local keep = sell:AddDropdown("KeepRarities", {
        Text = T("Never sell", "ไม่ขาย"),
        Description = T("Selected rarities are always kept", "rarity ที่เลือกจะเก็บไว้เสมอ"),
        Values = xDTaraZ.Sell.Rarities(),
        Multi = true,
        Default = {},
        AllowNull = true,
    })
    xDTaraZ.UI.Bind(keep, "SellRarities", xDTaraZ.UI.SellSet)
    xDTaraZ.UI.AdoptOldSellSave(sell, keep)
    sell:AddToggle("AutoSell", { Text = T("Auto sell", "ขายอัตโนมัติ") })
    sell:AddSlider("MaxSellPrice", { Text = T("Max price to sell", "ราคาสูงสุดที่ขาย"), Description = T("Keeps anything worth more (0 = no limit)", "ของแพงกว่านี้จะเก็บไว้ (0 = ไม่จำกัด)"), Min = 0, Max = 100000, Default = 500 })
    sell:AddSlider("KeepPerRarity", { Text = T("Keep per rarity", "เก็บต่อ rarity"), Min = 0, Max = 20, Default = 0 })
    sell:AddButton({ Text = T("Sell Now", "ขายตอนนี้"), Style = "Warning", Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notice(T("Sell", "ขาย"), xDTaraZ.Sell.SellNow(), "Coin")
    end) })
    sell:AddButton({ Text = T("Refresh rarities", "รีเฟรช rarity"), Func = xDTaraZ.UI.Detach(function()
        keep:SetValues(xDTaraZ.Sell.Rarities())
        xDTaraZ.Options.SellRarities = xDTaraZ.UI.SellSet(keep.Value)
    end) })

    local quest = tab:AddLeftGroupbox(T("Quests", "เควสต์"), "key")
    quest:AddToggle("AutoClaimQuest", { Text = T("Auto claim quests", "รับรางวัลเควสต์อัตโนมัติ") })
    quest:AddButton({ Text = T("Claim Now", "รับตอนนี้"), Style = "Success", Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notice(T("Quests", "เควสต์"), xDTaraZ.Collect.ClaimNow(), "Success")
    end) })
end

---@param key string  entry in UI.Labels, only redrawn when the text changes
function xDTaraZ.UI.Show(key, text)
    local label = xDTaraZ.UI.Labels[key]
    text = tostring(text)
    if not label or xDTaraZ.UI.Shown[key] == text then return end
    xDTaraZ.UI.Shown[key] = text
    label:SetContent(text)
end

function xDTaraZ.UI.RefreshStatus()
    xDTaraZ.UI.Show("Skin", xDTaraZ.Skin.GetStatus())
    xDTaraZ.UI.Show("Esp", xDTaraZ.Esp.GetStatus())
    xDTaraZ.UI.Show("Combat", xDTaraZ.Combat.GetStatus())
    xDTaraZ.UI.Show("Economy", string.format("%s | %s | %s", xDTaraZ.Shop.GetStatus(), xDTaraZ.Sell.GetStatus(), xDTaraZ.Collect.GetStatus()))

    xDTaraZ.UI.Show("Targets", xDTaraZ.Esp.Count)
    xDTaraZ.UI.Show("Cases", xDTaraZ.UI.Stats.Cases)
    xDTaraZ.UI.Show("Quests", xDTaraZ.UI.Stats.Quests)
end

function xDTaraZ.UI.ShowHalted()
    local queue = xDTaraZ.State.Halted
    if #queue == 0 then return end
    local stopped = table.clone(queue)
    table.clear(queue)

    for _, halt in ipairs(stopped) do
        local name, reason, toggles = halt[1], halt[2], halt[3]
        for _, key in ipairs(toggles) do
            local toggle = Library.Options[key]
            if toggle and toggle.Value == true then
                Util.Try("halt " .. key, toggle.SetValue, toggle, false)
            end
        end
        Library:Notify("Mario Hub", name .. " stopped: " .. reason, 6, "Error")
    end
end

function xDTaraZ.UI.ShowNotices()
    local queue = xDTaraZ.State.Notices
    if #queue == 0 then return end
    local pending = table.clone(queue)
    table.clear(queue)
    for _, notice in ipairs(pending) do
        Library:Notify(notice[1], notice[2], 4, notice[3])
    end
end

function xDTaraZ.UI.Pump()
    Util.Try("status", xDTaraZ.UI.RefreshStatus)
    Util.Try("halts", xDTaraZ.UI.ShowHalted)
    Util.Try("notices", xDTaraZ.UI.ShowNotices)
end

function xDTaraZ.UI.BlockMissing()
    local unsupported = T("Not available on this executor", "ใช้กับ executor นี้ไม่ได้")
    local outdated = T("Changed by a game update, wait for a script update", "เกมอัปเดตแล้ว รอสคริปต์อัปเดต")
    for module, features in pairs(xDTaraZ.Config.ModuleFeatures) do
        local missing = GameLib.Missing[module]
        if not missing then continue end
        for _, idx in ipairs(features) do
            Library.Compat.Block(idx, missing == "Absent" and outdated or unsupported)
        end
    end

    if not xDTaraZ.Movement.FindDash() then
        warn("[SniperArena] module CombatHelper.Dash not found, Infinite dash is blocked")
        Library.Compat.Block("InfiniteDash", outdated)
    end
end

function xDTaraZ.UI.Build()
    local window = Library.Window
    Util.Try("main tab", xDTaraZ.UI.BuildMain, window)
    Util.Try("combat tab", xDTaraZ.UI.BuildCombat, window)
    Util.Try("player tab", xDTaraZ.UI.BuildPlayer, window)
    Util.Try("visuals tabs", xDTaraZ.UI.BuildVisuals, window)
    Util.Try("economy tab", xDTaraZ.UI.BuildEconomy, window)
    Util.Try("settings tab", function()
        window:AddTabSection(T("Other", "อื่นๆ"))
        window:AddSettingsTab()
    end)

    for _, key in ipairs({ "AimFov", "AimBone", "AimPriority", "AimMaxDistance",
        "Aimbot", "AimSmooth", "AimPrediction", "ShowFov", "AimWallCheck", "AimTeamCheck",
        "SilentAim", "Ragebot", "InstantScope", "HitChance", "HeadChance", "TriggerBot", "NoRecoil", "NoSpread",
        "FastRespawn", "InfiniteDash", "SkinChanger", "OpenCount", "MaxSellPrice", "KeepPerRarity",
        "AutoOpenCases", "AutoSell", "AutoClaimQuest" }) do
        local widget = Library.Options[key]
        if widget then Util.Try("bind " .. key, xDTaraZ.UI.Bind, widget, key) end
    end
    Util.Try("missing modules", xDTaraZ.UI.BlockMissing)
    xDTaraZ:Connect(RunService.RenderStepped, xDTaraZ.Combat.DrawCircle)

    xDTaraZ.Scheduler.Every("Live stats", xDTaraZ.Config.EconomyInterval, xDTaraZ.UI.SampleStats)
    Library:Every(xDTaraZ.Config.StatusInterval, xDTaraZ.UI.Pump)
end

---@return boolean  false when the menu could not be opened
local function BuildInterface()
    Library = Util.LoadLibrary(xDTaraZ.Config.UiSource)
    if not Library then return false end
    xDTaraZ.Library = Library
    pcall(xDTaraZ.Banner.Step, "UI library")
    T = function(en, th) return Library:T(en, th) end
    local opened, err = pcall(Library.CreateWindow, Library, {
        Title = "Mario Hub",
        SubTitle = "Sniper Arena by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = xDTaraZ.Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        Intro = true,
        OnUnlocked = function()
            xDTaraZ.UI.Build()
            pcall(xDTaraZ.Banner.Step, "Interface")
            task.defer(Util.Try, "boot", xDTaraZ.Boot)
            task.defer(Util.Try, "autoload config", function() Library:LoadAutoloadConfig() end)
        end,
    })
    if not opened then
        Util.Alert("The menu failed to load on this executor: " .. tostring(err):match("^[^\n]*"), err)
        return false
    end
    Library:OnUnload(function()
        xDTaraZ:Unload()
    end)
    return true
end

function xDTaraZ.Boot()
    xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(character)
        xDTaraZ.Player.Respawn.Reset()
        xDTaraZ.Player:Bind(character)
    end)

    Util.Try("movement", xDTaraZ.Movement.Start)

    xDTaraZ.Scheduler.Every("Combat", 0.03, xDTaraZ.Combat.Step, xDTaraZ.Config.CombatToggles, xDTaraZ.Combat.Rest)
    xDTaraZ.Scheduler.Every("ESP", xDTaraZ.Config.EspInterval, xDTaraZ.Esp.Step)
    xDTaraZ.Scheduler.Every("Fast Respawn", 0.1, xDTaraZ.Player.Respawn.Step, { "FastRespawn" })
    xDTaraZ.Scheduler.Every("Auto Join", 1, xDTaraZ.Player.Join.Step, { "AutoJoin" })
    xDTaraZ.Scheduler.Every("Skin Changer", 0.5, xDTaraZ.Skin.Step, { "SkinChanger" }, xDTaraZ.Skin.Restore)
    xDTaraZ.Scheduler.Every("Auto Open Cases", xDTaraZ.Config.EconomyInterval, xDTaraZ.Shop.Step, { "AutoOpenCases" })
    xDTaraZ.Scheduler.Every("Auto Sell", xDTaraZ.Config.EconomyInterval, xDTaraZ.Sell.Step, { "AutoSell" })
    xDTaraZ.Scheduler.Every("Auto Claim Quests", xDTaraZ.Config.EconomyInterval, xDTaraZ.Collect.Step, { "AutoClaimQuest" })
    Util.Try("scheduler", xDTaraZ.Scheduler.Boot)
    pcall(xDTaraZ.Banner.Step, "Combat + economy online")
    pcall(xDTaraZ.Banner.Ready)
end

function xDTaraZ:Unload()
    self.State.Alive = false
    for key, value in pairs(self.Options) do
        if value == true then self.Options[key] = false end
    end
    xDTaraZ.Combat.Unload()
    xDTaraZ.Skin.Restore()
    for _, connection in ipairs(self.State.Connections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(self.State.Connections)

    local overlay = self.State.Overlay
    self.State.Overlay = nil
    if overlay then overlay:Destroy() end
    if environment.SniperArenaUnload == xDTaraZ.UnloadHook then environment.SniperArenaUnload = nil end
end

function xDTaraZ.UnloadHook()
    if xDTaraZ.Library and not xDTaraZ.Library.Unloaded then
        xDTaraZ.Library:Unload()
    else
        xDTaraZ:Unload()
    end
end

environment.SniperArenaUnload = xDTaraZ.UnloadHook

if LocalPlayer.Character then
    xDTaraZ.Player:Bind(LocalPlayer.Character)
end

pcall(xDTaraZ.Banner.Step, "Character bound")
BuildInterface()