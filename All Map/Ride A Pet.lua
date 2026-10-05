if not game:IsLoaded() then game.Loaded:Wait() end
if game.GameId ~= 10035204815 then game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Ride A Pet only") return end

do
    local ok, env = pcall(getgenv)
    if ok and type(env) == "table" and type(env.RideAPetUnload) == "function" then
        pcall(env.RideAPetUnload)
    end
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Library

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    GameId = 10035204815, PlaceId = 124216119978534,
    Tag = "[RideAPet]",

    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    LoadTimeout = 10, GameLibDeadline = 8,
    AlertTries = 8, AlertGap = 1.5, WarnGap = 5,

    PickupReach = 84,
    PickupLimit = 90,
    PickupRetryStep = 0.04,
    PickupReplyTimeout = 0.6,
    PickupTotalTimeout = 1.5,
    TpSettle = 0.1, VolcanoSettle = 0.3, DismountTimeout = 10, DismountToolWindow = 2,
    DropOutside = 4,
    DropSettle = 0.2,
    DropSettleMax = 0.35,
    DropEndsSlack = 0.03,
    DropAppearTimeout = 1.0,
    StaleDropDistance = 20,
    DepositTimeout = 1.5,
    RunBudget = 4.0,
    DirectFactor = 2.5,
    DirectFactorAfterFail = 2.0,
    ReturnBackoff = { 2.0, 1.5 }, ReturnStopCount = 3, ReturnWindow = 300, ReturnDedupe = 3,
    UnmountedDirect = 90, WeightPenalty = 0.01, CherubWeightPenalty = 0.0125, WeightPenaltyMax = 0.8,
    ContainsSlack = 2, EdgeInset = 1, StandLift = 3,
    TripCost = { Plot = 0.35, Direct = 0.62, Drop = 1.25 },
    ContestWeight = 1.5, ContestWeightMax = 3, ContestHorizon = 6, UnmountedPlayerSpeed = 36,
    CycleLength = 420, CycleOffset = 418.5, WaveSurge = 12, WaveWakeEarly = 2,
    GoneBlacklistSec = 2,
    MountTimeout = 1.5, MountTries = 3, MountGap = 0.35,
    CarryDeferCap = 3,
    EggTick = 0.05, SlowTick = 1, EspTick = 0.25, EspTickMobile = 0.5,
    EspRange = 4000, EspRangeMobile = 1500,
    FailLimit = 5, FailWindow = 10,
    PlantSpacing = 6, PlantCapDefault = 10, HatchGap = 0.3,
    CollectMinPending = 60, SellRange = 9, SellBatch = 50, ConfirmWindow = 2,
    ShopBuyGap = 0.15, AfkRejoinSec = 1100,
    HunterHopsPerCycle = 5, HunterMinLeft = 90,
    VolcanoCenter = Vector3.new(-5103, 41406, -3489), VolcanoResultTimeout = 20, VolcanoMinBreakLeft = 3,
    PumpTick = 0.5, PlotRetry = 1, MobileViewport = 900,
    UnloadCarryTimeout = 2,
    JobTick = {
        Volcano = 0.25, Junk = 0.25, Hatch = 1, Plant = 2, Pets = 2,
        Feed = 1, Sell = 10, Fusion = 2, Economy = 3, Shop = 5, Rewards = 30, Boosts = 5, Server = 5,
        Webhook = 1, Settle = 1, Kaitun = 2,
    },
    JobBackoff = 40,

    VolcanoStreamTimeout = 5,
    VolcanoTouchEvery = 0.25,
    VolcanoStepWait = 5,
    VolcanoStandLift = 3,
    VolcanoRetry = 30,
    VolcanoDipSettle = 0.7,
    VolcanoRefire = 0.3,
    VolcanoTailEggs = 1,
    VolcanoClaimSec = 2,

    PlantReplyTimeout = 1.5,
    PlantTries = 3,
    EquipSettle = 0.1,
    HatchPending = 5,
    PlotEggsRefresh = 60, PlotFullRecheck = 10,
    PlantStandLift = 3,
    PlantLongGrow = 3600,
    PlantLongShare = 0.5,

    JunkEquipSettle = 0.1,
    JunkSpacing = 0.2,
    JunkSpacingMin = 0.1,
    JunkSpacingMax = 1,
    JunkSpacingUp = 0.05,
    JunkSpacingDown = 0.02,
    JunkSpacingEase = 20,
    JunkPlantTimeout = 0.9,
    JunkPlantFails = 8,
    JunkHatchRetry = 0.8,
    JunkHatchSlack = 0.02,
    JunkHatchSlackMax = 0.3,
    JunkHatchGapMax = 0.3,
    JunkHatchGapStep = 0.02,
    JunkSellEvery = 60,
    JunkQueueTtl = 30,
    JunkIdleCheck = 5,
    JunkResyncIdle = 8,
    JunkFullPause = 0.6,
    JunkAutoShare = 0.2,
    JunkShareSample = 200,
    JunkSessionMax = 45,
    JunkYieldGap = 3,
    JunkBackoff = 10,
    JunkRateWindow = 60,
    JunkReportGap = 0.5,
    JunkAnchorNear = 4,
    JunkPlotShare = 0.5,
    JunkYieldTo = {
        "AutoEquipBest", "AutoCollectCash", "AutoFeed", "AutoFusion", "AutoPlaceEggs",
    },

    PetReplyTimeout = 1.5,
    PetSwapGain = 1.01,
    PetSpread = 0.35,
    PetStandLift = 3,
    PetBaseKg = 10,
    PetMaxAge = 100,
    CollectGap = 0.15,
    FeedGap = 0.36, FeedBurst = 8, FeedMissLimit = 3, FeedReplyTimeout = 1,
    TopCacheSec = 1,
    AutoCollectPass = { "AutoCollect", "1940707069" },
    PetAgeRefresh = 30,
    PetWatchedAttrs = {
        PetKey = true, PetName = true, Weight = true, BaseWeight = true, Mutation = true,
        SpawnMutation = true, Age = true, BirthTime = true, Favorited = true,
    },

    SellReplyTimeout = 8,
    SellRetry = 0.45,
    SellTries = 5,
    SellNear = 3,
    SellPriceMult = 600,
    SellStand = 5,
    IncomeSettle = 1.5,
    SellSettle = 0.6,
    FuseSlots = 4,
    FuseStand = 3,
    FuseLift = 3,
    FuseSettle = 0.15,
    FuseReplyTimeout = 2,
    FuseGap = 0.3,
    FusePlaceSettle = 1,
    FuseResultTimeout = 5,
    WeekSec = 604800,
    SellKeepTopRarities = 3,

    UpgradePayback = 300,
    UpgradeBatch = 25,
    UpgradeGap = 0.1,
    UpgradeVerify = 1.5,
    UpgradeBackoff = 30,
    UpgradeMaxBuy = 1000,
    RebirthSaveWindow = 1800,
    RebirthVerify = 3,
    RebirthBackoff = 60,
    ShopReplyTimeout = 3,
    ShopRecheck = 300,
    ClaimVerify = 2,
    PromptRetry = 3600,
    GroupRewardCooldown = 86400,
    BoostAttributes = {
        "HatchLuckEventMultiplier", "HatchLuckEventUntil", "HatchMutationEventMultiplier",
        "HatchMutationEventUntil", "HatchSpeedBoostAmount", "HatchSpeedBoostUntil", "GlobalCashBoostUntil",
    },

    KaitunToggles = {
        "AutoEggs", "EggHunter", "AutoPlaceEggs", "AutoHatch", "AutoEquipBest",
        "AutoCollectCash", "AutoUpgrade", "AutoClaim", "SmartSpend",
    },
    KaitunHuntRarity = "Mythic",
    KaitunSteerEvery = 60,

    UpdateLog = {
        { "2026-10-05", "Auto Feed is about 5x faster\nFixed Auto Place Eggs saying the plot is full when it is not\nFixed Volcano Dip and Auto Volcano Egg doing nothing unless Auto Eggs was on\nA returned egg no longer stops the whole farm, it slows delivery and keeps going\nAuto Reconnect after a disconnect\nWeather alerts now name the storm type\nScript rebuilt from scratch for the new game update\nEggs reach your base every time, no more returned eggs\nMuch less lag while farming with a big inventory\nClear Junk Eggs: hatch cheap eggs and sell the pets\nMinimum Egg Rarity to farm rare eggs only\nFixed Auto Place Best Pets swapping out good pets\nPerformance: Boost FPS, hide other pets and eggs, FPS cap, disable 3D\nFixed the inventory bar not coming back after farming\nRemoved the Stop All button" },
        { "2026-10-04", "Rebuilt egg collecting: faster trips and no more returned eggs\nRide pet picker, rare egg hunter and plant order\nPet protect list, safer selling and smarter spending\nClear Junk Eggs now sells what it hatches, and Minimum Egg Rarity skips cheap eggs" },
    },
}

xDTaraZ.State = {
    Alive = true, Connections = {}, Halted = {}, Errors = {},
    Tune = { DropSettle = 0.2, ContestWeight = 1.5, DirectFactor = 2.5 },
    Status = {},
    PendingSet = {},
    PendingToggleOff = {},
    PendingNotify = {},
    LastFail = nil,
    Stats = { delivered = 0, lost = 0, returned = 0, plot = 0, direct = 0, drop = 0, staleDrops = 0, window = {} },
    PlotEggs = {}, PlantCap = 10, Weather = {},
    WarnedAt = {},
}

xDTaraZ.Options = {}

local Config, State = xDTaraZ.Config, xDTaraZ.State

Config.JobTick.Eggs, Config.JobTick.Hunter = Config.EggTick, Config.EggTick

State.Tune.DropSettle = Config.DropSettle
State.Tune.ContestWeight = Config.ContestWeight
State.Tune.DirectFactor = Config.DirectFactor
State.PlantCap = Config.PlantCapDefault

xDTaraZ.Util = {}

---@return boolean, any  ok, fn result or the error
function xDTaraZ.Util.Try(label, fn, ...)
    local ok, err = pcall(fn, ...)
    if ok then return true, err end

    local now = os.clock()
    if now - (State.WarnedAt[label] or -math.huge) >= Config.WarnGap then
        State.WarnedAt[label] = now
        warn(Config.Tag .. " " .. label .. ":", err)
    end
    return false, err
end

---@return string|nil, string|nil  body, or nil and why every transport failed
function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then return body end

    local requester = (syn and syn.request) or (http and http.request) or http_request or request
    if not requester then return nil, "no http function" end

    local sent, response = pcall(requester, { Url = url, Method = "GET" })
    if not sent or type(response) ~= "table" then return nil, tostring(response) end
    if response.StatusCode ~= 200 or type(response.Body) ~= "string" then
        return nil, "HTTP " .. tostring(response.StatusCode)
    end
    return response.Body
end

---@param detail any  console only
function xDTaraZ.Util.Alert(text, detail)
    warn(Config.Tag, text, detail or "")
    task.spawn(function()
        for _ = 1, Config.AlertTries do
            local shown = pcall(StarterGui.SetCore, StarterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 })
            if shown then return end
            task.wait(Config.AlertGap)
        end
    end)
end

---@return table|nil  UI library, nil after an on-screen alert
function xDTaraZ.Util.LoadLibrary(url)
    local source, why = xDTaraZ.Util.HttpGet(url)
    if not source or not source:sub(-64):find("return%s+Library%s*$") then
        xDTaraZ.Util.Alert("Could not download the menu. Check your connection and run it again.", why or "truncated download")
        return nil
    end

    local chunk, compileErr = loadstring(source)
    if type(chunk) ~= "function" then
        xDTaraZ.Util.Alert("The menu failed to load on this executor.", compileErr)
        return nil
    end

    local ok, lib = pcall(chunk)
    if not ok or type(lib) ~= "table" then
        xDTaraZ.Util.Alert("The menu failed to load on this executor.", lib)
        return nil
    end
    return lib
end

function xDTaraZ.Util.Copy(text)
    local copier = setclipboard or toclipboard
    if not copier then return false end
    return (pcall(copier, text))
end

---@return boolean  queued for the next server
function xDTaraZ.Util.Queue(src)
    if not (Library and Library.Compat and Library.Compat.Caps.Queue) then return false end
    local queue = queue_on_teleport or queueonteleport
    if not queue then return false end
    return (pcall(queue, src))
end

function xDTaraZ.Util.ServerNow()
    return Workspace:GetServerTimeNow()
end

---@return number  XZ distance
function xDTaraZ.Util.Flat(a, b)
    local dx, dz = a.X - b.X, a.Z - b.Z
    return math.sqrt(dx * dx + dz * dz)
end

function xDTaraZ.Util.Format(n)
    n = tonumber(n) or 0
    if n ~= n or n == math.huge then return "-" end

    local suffixes = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx" }
    local step = 1
    repeat
        if math.abs(n) < 1000 then break end
        n /= 1000
        step += 1
    until step == #suffixes
    if step == 1 then return tostring(math.floor(n)) end
    return string.format("%.2f%s", n, suffixes[step])
end

---@return any  option value; the UI mirror first, then the live option
function xDTaraZ.Util.Opt(idx)
    local mirrored = xDTaraZ.Options[idx]
    if mirrored ~= nil then return mirrored end
    local option = Library and Library.Options and Library.Options[idx]
    return option and option.Value
end

---@param seconds number|nil
function xDTaraZ.Util.Notify(title, text, seconds)
    table.insert(State.PendingNotify, { title, text, seconds or 5 })
end

do
    local camera = Workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
    local touch = UserInputService.TouchEnabled
    local noKeys = not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

    xDTaraZ.Platform = {
        Touch = touch,
        Mobile = touch and (noKeys or viewport.X < Config.MobileViewport),
        Console = GuiService:IsTenFootInterface(),
        Viewport = viewport,
    }
end

---@return boolean  false when the executor has no working fps cap
function xDTaraZ.Util.SetFpsCap(fps)
    local ok = pcall(function() setfpscap(fps) end)
    return ok
end

function xDTaraZ:Connect(signal, handler)
    local conn = signal:Connect(handler)
    table.insert(self.State.Connections, conn)
    return conn
end

xDTaraZ.StopOrder = {
    "Kaitun", "Guard", "Eggs", "Hunter", "Volcano", "Junk", "Hatch", "Pets", "Sell", "Fusion",
    "Economy", "Shop", "Rewards", "Boosts", "Troll", "Server", "Webhook", "Visual",
}

function xDTaraZ:Unload()
    if not State.Alive or State.Unloading then return end
    State.Unloading = true
    local try = xDTaraZ.Util.Try

    try("unload carry", function() xDTaraZ.Eggs.FinishCarry(Config.UnloadCarryTimeout) end)
    State.Alive = false
    try("unload tasks", function() xDTaraZ.Tasks.ReleaseAll("unload") end)
    for _, name in ipairs(xDTaraZ.StopOrder) do
        local module = rawget(xDTaraZ, name)
        if module and module.Stop then try("unload " .. name, module.Stop) end
    end
    try("unload character", function() xDTaraZ.Player:Release() end)
    try("unload inventory", function() xDTaraZ.Eggs.QuietInventory(false, true) end)
    State.TeardownPending = true
    if not State.TeardownConn then xDTaraZ.Teardown() end
end

function xDTaraZ.Teardown()
    State.TeardownPending = false
    if State.TeardownConn then
        State.TeardownConn:Disconnect()
        State.TeardownConn = nil
    end
    local try = xDTaraZ.Util.Try

    try("unload move", function() xDTaraZ.Move.Restore() end)
    try("unload esp", function() xDTaraZ.Esp.Clear() end)
    try("unload hooks", function() Library.Compat.RestoreAll() end)

    try("unload player", function() xDTaraZ.Player:Unbind() end)
    for _, conn in ipairs(State.Connections) do
        if type(conn) == "function" then conn() else conn:Disconnect() end
    end
    table.clear(State.Connections)

    try("unload ui", function() Library:Unload() end)
end

---@param signal RBXScriptSignal  fired on a thread that never calls game code
function xDTaraZ.BindTeardown(signal)
    State.TeardownConn = signal:Connect(function()
        if State.TeardownPending then xDTaraZ.Teardown() end
    end)
end

do
    local ok, env = pcall(getgenv)
    if ok and type(env) == "table" then
        env.RideAPetUnload = function() xDTaraZ:Unload() end
    end
end

xDTaraZ.GameLib = {
    Data = {}, Svc = {}, Missing = {},
    Cache = {}, NetSearched = false,
    EggInfo = {}, PetInfo = {}, RarityOrder = {}, RarityRank = {},
    Foods = {}, FoodOrder = {}, ShopItems = {}, Rebirths = { Cap = 0, Costs = {} }, RebirthReq = {},
    IndexStages = {}, Mutations = {},
}

local GameLib = xDTaraZ.GameLib

GameLib.DataModules = {
    "Pets", "Eggs", "Spawns", "General", "Rebirths", "HatchLuck", "Mutations", "Weather",
    "Foods", "Shop", "IndexRewards", "Volcano", "Fusion", "EggBaskets",
}
GameLib.ServiceModules = { "General", "EggCycle", "DayNight", "EggDeliveryRules", "SellValue", "PetAging" }

GameLib.Denied = {
    Restock = true, SetOpenShop = true, RegisterSkipTarget = true, RegisterSkipAllTarget = true,
    UpdatePlayerToGift = true, CanGiftGamepass = true, CmdrFunction = true, PetMove = true,
    EggTimerPause = true, EggArrivalClaim = true,
    ["Reusable.Ban"] = true, ["Reusable.GetPlayerData"] = true, ["Reusable.InitiatePlot"] = true,
    ["Reusable.ClaimGroupReward"] = true, ["Reusable.ClaimEventReward"] = true, ["Reusable.Teleporting"] = true,
}
GameLib.DeniedPrefix = { "SkipGrowth" }
GameLib.ListenOnly = { Restock = true }

GameLib.Needs = {
    AutoEggs = { "EggPickup", "BasketDrop", "Mounting", "GameMessage", "ActiveEggs" },
    EggHunter = { "EggPickup", "BasketDrop", "ActiveEggs" },
    VolcanoDip = { "EggPickup", "BasketDrop", "VolcanoDip", "VolcanoDipResult" },
    VolcanoObby = { "EggPickup", "BasketDrop", "ActiveEggs" },
    AutoPlaceEggs = { "EggPlaced" },
    AutoHatch = { "Hatch" },
    ClearJunk = { "EggPlaced", "Hatch", "SellItems", "ConfirmRequest" },
    AutoEquipBest = { "PlacePet", "PickupPet" },
    AutoCollectCash = { "PetCollect" },
    AutoFeed = { "FeedPet" },
    AutoSell = { "SellItems", "ConfirmRequest" },
    AutoFusion = { "FusionPetPlace", "FusionAction" },
    AutoUpgrade = { "Plot.Upgrades" },
    AutoRebirth = { "Rebirth" },
    AutoShop = { "ShopStock", "BuyWithCash" },
    AutoClaim = { "ClaimIndexReward", "OfflineEarnings" },
    Kaitun = { "EggPickup", "BasketDrop", "ActiveEggs" },
}

---@return boolean, any  ok, module or error; retried from an identity-2 thread
function GameLib.RequireAsGame(module)
    local done, ok, loaded = false, false, nil
    task.spawn(function()
        local switched = pcall(setthreadidentity, 2)
        if switched then ok, loaded = pcall(require, module) end
        done = true
    end)

    local deadline = os.clock() + xDTaraZ.Config.LoadTimeout
    repeat
        if done then break end
        task.wait()
    until os.clock() > deadline
    return ok, loaded
end

---@return table|nil
function GameLib.Require(module)
    if typeof(module) ~= "Instance" or not module:IsA("ModuleScript") then return nil end

    local ok, loaded
    if Library and Library.Compat then
        ok, loaded = Library.Compat.Require(module)
    else
        ok, loaded = pcall(require, module)
        if not ok and tostring(loaded):find("non-RobloxScript", 1, true) then
            ok, loaded = GameLib.RequireAsGame(module)
        end
    end

    if ok and type(loaded) == "table" then return loaded end
    warn(xDTaraZ.Config.Tag, "require " .. module.Name .. ":", loaded)
    return nil
end

---@return boolean, ...  ok, then the game function's results or the error
function GameLib.Call(fn, ...)
    if type(fn) ~= "function" then return false, "not a function" end
    if Library and Library.Compat then
        return pcall(Library.Compat.Call, fn, ...)
    end
    return pcall(fn, ...)
end

---@return boolean
function GameLib.IsDenied(name)
    if GameLib.Denied[name] then return true end
    for _, prefix in ipairs(GameLib.DeniedPrefix) do
        if name:sub(1, #prefix) == prefix then return true end
    end
    return false
end

---@return Instance|nil  the packages Net folder, found once whatever the _Index version
function GameLib.NetFolder()
    if GameLib.NetSearched then return GameLib.NetFolderRef end
    GameLib.NetSearched = true

    local packages = ReplicatedStorage:FindFirstChild("packages")
    if not packages then return nil end
    local direct = packages:FindFirstChild("Net")
    if direct then
        GameLib.NetFolderRef = direct
        return direct
    end

    for _, node in ipairs(packages:GetDescendants()) do
        if node.Name ~= "Net" then continue end
        for _, child in ipairs(node:GetChildren()) do
            if child.Name:sub(1, 3) == "RE/" then
                GameLib.NetFolderRef = node
                return node
            end
        end
    end
    return nil
end

---@param name string  "EggPickup", "Plot.Upgrades" or a packages Net name without "RE/"
---@return Instance|nil
function GameLib.Remote(name)
    if GameLib.IsDenied(name) then return nil end
    local cached = GameLib.Cache[name]
    if cached and cached.Parent then return cached end

    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local gameFolder = remotes and remotes:FindFirstChild("Game")
    local reusable = remotes and remotes:FindFirstChild("Reusable")
    local found

    local folder, leaf = name:match("^(%w+)%.(.+)$")
    if folder then
        local parent = gameFolder and gameFolder:FindFirstChild(folder)
        found = parent and parent:FindFirstChild(leaf)
    else
        found = gameFolder and gameFolder:FindFirstChild(name)
        if not found and reusable and not GameLib.IsDenied("Reusable." .. name) then
            found = reusable:FindFirstChild(name)
        end
        if not found then
            local net = GameLib.NetFolder()
            found = net and net:FindFirstChild("RE/" .. name)
        end
    end

    GameLib.Cache[name] = found
    return found
end

---@return Instance|nil  a denied remote that is only ever listened to, never fired
function GameLib.Listen(name)
    if not GameLib.ListenOnly[name] then return GameLib.Remote(name) end
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    local gameFolder = remotes and remotes:FindFirstChild("Game")
    return gameFolder and gameFolder:FindFirstChild(name)
end

xDTaraZ.Net = setmetatable({}, {
    __index = function(self, name)
        local remote = GameLib.Remote(name)
        if remote then rawset(self, name, remote) end
        return remote
    end,
})

---@return Instance|nil
function GameLib.ActiveEggs()
    local serverData = ReplicatedStorage:FindFirstChild("ServerData")
    return serverData and serverData:FindFirstChild("ActiveEggs")
end

---@return Model|nil
function GameLib.Plot()
    local general = GameLib.Svc.General
    if general and general.GetPlot then
        local ok, plot = GameLib.Call(general.GetPlot, general, LocalPlayer)
        if ok and typeof(plot) == "Instance" then return plot end
    end

    local plots = Workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in ipairs(plots:GetChildren()) do
        local data = plot:FindFirstChild("Data")
        local owner = data and data:FindFirstChild("Owner")
        if owner and owner.Value == LocalPlayer then return plot end
    end
    return nil
end

---@return boolean  same rule as the game's delivery check, Y ignored
function GameLib.Contains(bp, pos)
    local rel = bp.CFrame:PointToObjectSpace(pos)
    local slack = xDTaraZ.Config.ContainsSlack
    return math.abs(rel.X) <= bp.Size.X / 2 + slack and math.abs(rel.Z) <= bp.Size.Z / 2 + slack
end

function GameLib.CycleIndex()
    local cycle = GameLib.Svc.EggCycle
    if cycle then
        local ok, index = GameLib.Call(cycle.Index)
        if ok and type(index) == "number" then return index end
    end
    return math.floor((xDTaraZ.Util.ServerNow() - xDTaraZ.Config.CycleOffset) / xDTaraZ.Config.CycleLength)
end

---@return number  seconds until the next egg wave
function GameLib.CycleLeft()
    local cycle = GameLib.Svc.EggCycle
    if cycle then
        local ok, left = GameLib.Call(cycle.SecondsRemaining)
        if ok and type(left) == "number" then return left end
    end
    local length = xDTaraZ.Config.CycleLength
    return length - (xDTaraZ.Util.ServerNow() - xDTaraZ.Config.CycleOffset) % length
end

---@param mult number  hatch luck multiplier, event included
---@return table|nil   { {pet, chance} }
function GameLib.Odds(egg, mult)
    local hatchLuck, eggs = GameLib.Data.HatchLuck, GameLib.Data.Eggs
    local info = GameLib.EggInfo[egg]
    if not (hatchLuck and hatchLuck.GetOdds and eggs and eggs[egg] and info) then return nil end

    local ok, odds = GameLib.Call(hatchLuck.GetOdds, info.luck * (mult or 1), eggs[egg])
    if not ok or type(odds) ~= "table" then return nil end

    local out = {}
    for _, row in ipairs(odds) do
        if type(row) == "table" and row.PetName then
            out[#out + 1] = { row.PetName, tonumber(row.Chance) or 0 }
        end
    end
    return out
end

---@return number|nil  growth seconds an egg of this weight needs, nil when the game module is missing
function GameLib.GrowthSeconds(base, weight)
    local general = GameLib.Data.General
    if not (general and general.GrowthTimeFor) then return nil end

    local ok, total = GameLib.Call(general.GrowthTimeFor, base, weight)
    return ok and tonumber(total) or nil
end

---@return number|nil  growth seconds still needed, nil when the game modules are missing
function GameLib.GrowthLeft(placeTime, base, weight)
    local dayNight = GameLib.Svc.DayNight
    local total = GameLib.GrowthSeconds(base, weight)
    if not (total and dayNight and dayNight.GrowthElapsed) then return nil end

    local ok, elapsed = GameLib.Call(dayNight.GrowthElapsed, placeTime)
    if not ok then return nil end
    return total - (tonumber(elapsed) or 0)
end

---@return number|nil  real seconds until a placed egg is grown, night counts faster; nil when unknown
function GameLib.GrowthRealLeft(placeTime, base, weight)
    local dayNight = GameLib.Svc.DayNight
    local total = GameLib.GrowthSeconds(base, weight)
    if not (total and dayNight and dayNight.GrowthRealRemaining) then return nil end

    local ok, left = GameLib.Call(dayNight.GrowthRealRemaining, placeTime, total)
    return ok and tonumber(left) or nil
end

---@param into   table   GameLib.Data or GameLib.Svc
---@param stopAt number  shared deadline for every require
function GameLib.LoadFolder(folder, names, into, label, stopAt)
    for _, name in ipairs(names) do
        local module = folder and folder:FindFirstChild(name)
        if module and os.clock() < stopAt then into[name] = GameLib.Require(module) end
        if not into[name] then GameLib.Missing[label .. "." .. name] = module and "load timeout" or "module not found" end
    end
end

function GameLib.LoadModules()
    local deadline = xDTaraZ.Config.GameLibDeadline
    local dataFolder = ReplicatedStorage:WaitForChild("GameData", deadline)
    local svcFolder = ReplicatedStorage:FindFirstChild("GameServices") or ReplicatedStorage:WaitForChild("GameServices", 1)
    local stopAt = os.clock() + deadline

    GameLib.LoadFolder(dataFolder, GameLib.DataModules, GameLib.Data, "GameData", stopAt)
    GameLib.LoadFolder(svcFolder, GameLib.ServiceModules, GameLib.Svc, "GameServices", stopAt)
end

local function BuildRarities()
    local order, rank = GameLib.RarityOrder, GameLib.RarityRank
    table.clear(order)
    table.clear(rank)

    local general = GameLib.Data.General or {}
    local levels = general.RarityLevelRequirementMultiplier or {}
    local weight = {}
    for rarity, level in pairs(levels) do
        weight[rarity] = tonumber(level) or 0
    end

    local floor = {}
    for _, pet in pairs(GameLib.PetInfo) do
        floor[pet.rarity] = math.min(floor[pet.rarity] or math.huge, pet.income)
    end
    for _, egg in pairs(GameLib.EggInfo) do
        floor[egg.rarity] = floor[egg.rarity] or math.huge
    end
    for rarity, income in pairs(floor) do
        if not weight[rarity] then weight[rarity] = 1e9 + math.min(income, 1e12) end
    end

    for rarity in pairs(weight) do
        order[#order + 1] = rarity
    end
    table.sort(order, function(a, b) return weight[a] < weight[b] end)
    for index, rarity in ipairs(order) do
        rank[rarity] = index
    end
end

local function BuildEggsAndPets()
    table.clear(GameLib.EggInfo)
    table.clear(GameLib.PetInfo)
    local breakTimer = (GameLib.Data.General or {}).EggBreakTimer or {}

    for name, egg in pairs(GameLib.Data.Eggs or {}) do
        if type(egg) ~= "table" then continue end
        local rarity = egg.Rarity or "Common"
        GameLib.EggInfo[name] = {
            rarity = rarity,
            luck = tonumber(egg.Luck) or 0,
            growth = tonumber(egg.GrowthTime) or 0,
            breakSec = tonumber(breakTimer[rarity]) or 0,
            ethereal = rarity == "Ethereal",
            volcanic = egg.RequiresVolcano == true,
        }
    end

    for name, pet in pairs(GameLib.Data.Pets or {}) do
        if type(pet) ~= "table" or not pet.Rarity then continue end
        GameLib.PetInfo[name] = {
            rarity = pet.Rarity,
            speed = tonumber(pet.Speed) or 0,
            income = tonumber(pet.Income) or 0,
            fusionOnly = pet.FusionOnly == true,
            moveSpeed = tonumber(pet.MovementSpeed) or 0,
        }
    end
end

local function BuildEconomy()
    local data = GameLib.Data

    table.clear(GameLib.Foods)
    table.clear(GameLib.FoodOrder)
    for name, food in pairs(data.Foods or {}) do
        if type(food) ~= "table" then continue end
        GameLib.Foods[name] = { cost = tonumber(food.Cost) or 0, xp = tonumber(food.XP) or 0, rarity = food.Rarity, noFeedAll = food.NoFeedAll == true }
        table.insert(GameLib.FoodOrder, name)
    end
    table.sort(GameLib.FoodOrder, function(a, b) return GameLib.Foods[a].cost < GameLib.Foods[b].cost end)

    table.clear(GameLib.ShopItems)
    local categories = data.Shop and data.Shop.Categories or {}
    for category, items in pairs(categories) do
        for item, entry in pairs(items) do
            if type(entry) ~= "table" or entry.Source == "Lanterns" then continue end
            local price = tonumber(entry.Price) or (GameLib.Foods[item] and GameLib.Foods[item].cost) or 0
            GameLib.ShopItems[#GameLib.ShopItems + 1] = { cat = category, item = item, price = price, rarity = entry.Rarity }
        end
    end
    table.sort(GameLib.ShopItems, function(a, b) return a.price < b.price end)

    local rebirths = data.Rebirths
    GameLib.Rebirths.Cap = rebirths and tonumber(rebirths.Cap) or 0
    table.clear(GameLib.Rebirths.Costs)
    for n = 1, GameLib.Rebirths.Cap do
        local ok, cost = GameLib.Call(rebirths.GetCost, n - 1)
        GameLib.Rebirths.Costs[n] = ok and tonumber(cost) or math.huge
    end

    table.clear(GameLib.RebirthReq)
    for index, pet in ipairs((data.General or {}).RebirthRequirements or {}) do
        GameLib.RebirthReq[index] = pet
    end

    table.clear(GameLib.IndexStages)
    for _, stage in ipairs(data.IndexRewards and data.IndexRewards.Stages or {}) do
        table.insert(GameLib.IndexStages, { goal = tonumber(stage.Goal) or 0, reward = tonumber(stage.Reward) or 0 })
    end

    table.clear(GameLib.Mutations)
    for name, mutation in pairs(data.Mutations or {}) do
        if type(mutation) == "table" and mutation.StatMultiplier then
            GameLib.Mutations[name] = 1 + (tonumber(mutation.StatMultiplier) or 0) / 100
        end
    end
end

function GameLib.Build()
    BuildEggsAndPets()
    BuildRarities()
    BuildEconomy()
end

---@return string|nil  why the option cannot run
function GameLib.Blocked(idx)
    for _, name in ipairs(GameLib.Needs[idx] or {}) do
        local reason = GameLib.Missing[name]
        if reason then return reason end
    end
    return nil
end

function GameLib.Check()
    local started = os.clock()
    local deadline = xDTaraZ.Config.GameLibDeadline
    local seen = {}

    for _, names in pairs(GameLib.Needs) do
        for _, name in ipairs(names) do
            if seen[name] then continue end
            seen[name] = true
            if os.clock() - started > deadline then
                GameLib.Missing[name] = "check timed out"
                continue
            end

            local found
            if name == "ActiveEggs" then
                found = GameLib.ActiveEggs()
            else
                found = GameLib.Remote(name)
            end
            if not found then GameLib.Missing[name] = "not found after a game update" end
        end
    end

    if not GameLib.Data.Eggs or not GameLib.Data.Pets then
        GameLib.Missing.ActiveEggs = GameLib.Missing.ActiveEggs or "egg data not readable"
    end
end

xDTaraZ.Player = {
    Client = LocalPlayer,
    Char = nil, Humanoid = nil, Root = nil,
    Epoch = 0,
    CharConns = {},
    PlotModel = nil, Baseplate = nil, PlotConn = nil, PlotRetryAt = 0,
}

function xDTaraZ.Player:Lose(char)
    if self.LostChar == char then return end
    self.LostChar = char
    self.Epoch += 1
    xDTaraZ.Util.Try("abort on death", function() xDTaraZ.Tasks.Abort("death") end)
    xDTaraZ.Util.Try("forget mount", function() xDTaraZ.Mount.Forget() end)
end

function xDTaraZ.Player:Unbind()
    for _, conn in ipairs(self.CharConns) do
        conn:Disconnect()
    end
    table.clear(self.CharConns)
    if self.PlotConn then
        self.PlotConn:Disconnect()
        self.PlotConn = nil
    end
end

function xDTaraZ.Player:Bind(char)
    for _, conn in ipairs(self.CharConns) do
        conn:Disconnect()
    end
    table.clear(self.CharConns)
    self.Char, self.Humanoid, self.Root = char, nil, nil

    task.spawn(function()
        local hum = char:WaitForChild("Humanoid", Config.LoadTimeout)
        local hrp = char:WaitForChild("HumanoidRootPart", Config.LoadTimeout)
        if self.Char ~= char then return end
        if not hum or not hrp then
            warn(Config.Tag, "character parts missing after", Config.LoadTimeout, "s")
            return
        end

        self.Humanoid, self.Root = hum, hrp
        table.insert(self.CharConns, hum.Died:Connect(function() self:Lose(char) end))
    end)
end

function xDTaraZ.Player:IsAlive()
    local hum, hrp = self.Humanoid, self.Root
    return hum ~= nil and hum.Health > 0 and hrp ~= nil and hrp.Parent ~= nil
end

---@return Model|nil, BasePart|nil  plot and its baseplate
function xDTaraZ.Player:Plot()
    local plot, bp = self.PlotModel, self.Baseplate
    if plot and bp and plot.Parent and bp.Parent then return plot, bp end

    local now = os.clock()
    if now < self.PlotRetryAt then return nil, nil end
    self.PlotRetryAt = now + Config.PlotRetry

    plot = xDTaraZ.GameLib.Plot()
    bp = plot and plot:FindFirstChild("Baseplate")
    if not bp then return nil, nil end
    self.PlotModel, self.Baseplate = plot, bp

    if self.PlotConn then self.PlotConn:Disconnect() end
    local owner = plot:FindFirstChild("Data") and plot.Data:FindFirstChild("Owner")
    if owner then
        self.PlotConn = owner.Changed:Connect(function()
            self.PlotModel, self.Baseplate, self.PlotRetryAt = nil, nil, 0
        end)
    end
    return plot, bp
end

---@return Instance[]
function xDTaraZ.Player:BasketItems()
    local basket = LocalPlayer:FindFirstChild("Basket")
    return basket and basket:GetChildren() or {}
end

function xDTaraZ.Player:BasketCount()
    local basket = LocalPlayer:FindFirstChild("Basket")
    return basket and #basket:GetChildren() or 0
end

function xDTaraZ.Player:Riding()
    return LocalPlayer:GetAttribute("IsRiding") == true
end

---@async
---@return boolean  off the mount with empty hands, yields until the landing tool is put away
function xDTaraZ.Player:Release()
    local hum = self.Humanoid
    local remote = self:Riding() and xDTaraZ.GameLib.Remote("PetDismount")
    if remote and hum and hum.Parent then
        local landed = false
        local conn = hum.Parent.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then landed = true end
        end)
        remote:FireServer()

        local deadline = os.clock() + Config.DismountTimeout
        while self:Riding() and os.clock() < deadline do task.wait() end
        local toolBy = os.clock() + Config.DismountToolWindow
        while not landed and os.clock() < toolBy and hum.Parent do task.wait() end
        conn:Disconnect()
    end

    if self:BasketCount() > 0 or not hum then return not self:Riding() end
    hum:UnequipTools()
    return not self:Riding()
end

---@return number  server delivery-failure counter
function xDTaraZ.Player:Flags()
    return tonumber(LocalPlayer:GetAttribute("TeleportFlags")) or 0
end

xDTaraZ.Geo = {}

---@return Vector3  nearest point inside the baseplate edge, standing height
function xDTaraZ.Geo.EdgeInside(bp, target)
    local rel = bp.CFrame:PointToObjectSpace(target)
    local hx, hz = bp.Size.X / 2 - Config.EdgeInset, bp.Size.Z / 2 - Config.EdgeInset
    local clamped = Vector3.new(math.clamp(rel.X, -hx, hx), bp.Size.Y / 2 + Config.StandLift, math.clamp(rel.Z, -hz, hz))
    return bp.CFrame:PointToWorldSpace(clamped)
end

---@param dist number  studs past the edge
---@return Vector3     point outside the baseplate on the side facing target
function xDTaraZ.Geo.Outside(bp, target, dist)
    local rel = bp.CFrame:PointToObjectSpace(target)
    local hx, hz = bp.Size.X / 2, bp.Size.Z / 2
    local cx, cz = math.clamp(rel.X, -hx, hx), math.clamp(rel.Z, -hz, hz)
    local dx, dz = rel.X - cx, rel.Z - cz
    local len = math.sqrt(dx * dx + dz * dz)
    if len < 1e-3 then dx, dz, len = 1, 0, 1 end

    return bp.CFrame:PointToWorldSpace(Vector3.new(cx + dx / len * dist, bp.Size.Y / 2 + Config.StandLift, cz + dz / len * dist))
end

---@return Vector3  pickup spot on the egg-to-plot line, within reach of the egg
function xDTaraZ.Geo.StandPoint(bp, eggPos)
    local edge = xDTaraZ.Geo.EdgeInside(bp, eggPos)
    local dir = (edge - eggPos) * Vector3.new(1, 0, 1)
    local span = dir.Magnitude
    if span < 1e-3 then return Vector3.new(eggPos.X, eggPos.Y + Config.StandLift, eggPos.Z) end

    local spot = eggPos + dir.Unit * math.min(Config.PickupReach, span)
    return Vector3.new(spot.X, eggPos.Y + Config.StandLift, spot.Z)
end

---@return number  flat studs from a point to the plot edge
function xDTaraZ.Geo.Trip(bp, from)
    return xDTaraZ.Util.Flat(from, xDTaraZ.Geo.EdgeInside(bp, from))
end

function xDTaraZ.Geo.InPlot(pos)
    local _, bp = xDTaraZ.Player:Plot()
    return bp ~= nil and xDTaraZ.GameLib.Contains(bp, pos)
end

if LocalPlayer.Character then xDTaraZ.Player:Bind(LocalPlayer.Character) end
xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(char) xDTaraZ.Player:Bind(char) end)
xDTaraZ:Connect(LocalPlayer.CharacterRemoving, function(char) xDTaraZ.Player:Lose(char) end)

xDTaraZ.Tasks = { Current = nil, Prio = { Recover = 100, Volcano = 80, Hunter = 70, Mount = 65, Eggs = 60, Plot = 40, Travel = 30, Manual = 20 } }

function xDTaraZ.Tasks.Carrying()
    return xDTaraZ.Player:BasketCount() > 0
end

function xDTaraZ.Tasks.EggsBusy()
    local eggs = xDTaraZ.Eggs
    if not eggs or not eggs.Waiting then return false end
    return not eggs.Waiting()
end

---@return table|nil  token { owner, prio, epoch, dead, preempt }
function xDTaraZ.Tasks.Request(owner, prio)
    if not xDTaraZ.State.Alive then return nil end

    if prio <= xDTaraZ.Tasks.Prio.Manual and xDTaraZ.Tasks.Carrying() then
        table.insert(xDTaraZ.State.PendingNotify, { "Mario Hub", "Finish the egg delivery first" })
        return nil
    end
    if prio <= xDTaraZ.Tasks.Prio.Plot and prio > xDTaraZ.Tasks.Prio.Manual and xDTaraZ.Tasks.EggsBusy() then return nil end

    local cur = xDTaraZ.Tasks.Current
    if cur and (cur.dead or cur.epoch ~= xDTaraZ.Player.Epoch) then
        cur.dead = true
        cur = nil
        xDTaraZ.Tasks.Current = nil
    end

    if cur then
        if prio > cur.prio then cur.preempt = true end
        return nil
    end

    local token = { owner = owner, prio = prio, epoch = xDTaraZ.Player.Epoch, dead = false, preempt = false }
    local hrp = xDTaraZ.Player.Root
    if prio <= xDTaraZ.Tasks.Prio.Plot and hrp then token.home = hrp.CFrame end
    xDTaraZ.Tasks.Current = token
    return token
end

function xDTaraZ.Tasks.Release(token)
    if not token or token.dead then return end
    token.dead = true
    if xDTaraZ.Tasks.Current == token then xDTaraZ.Tasks.Current = nil end

    local opts = xDTaraZ.Options
    local back = opts and opts.ReturnAfter
    if not token.home or not back or xDTaraZ.Tasks.Carrying() then return end
    local hrp = xDTaraZ.Player.Root
    if hrp and xDTaraZ.Player:IsAlive() and token.epoch == xDTaraZ.Player.Epoch then
        hrp.CFrame = token.home
        hrp.AssemblyLinearVelocity = Vector3.zero
    end
end

---@return boolean  false after preempt, death or unload
function xDTaraZ.Tasks.Holds(token)
    if not token or token.dead or not xDTaraZ.State.Alive then return false end
    if xDTaraZ.Tasks.Current ~= token or token.epoch ~= xDTaraZ.Player.Epoch then return false end
    if not token.preempt or token.critical then return true end
    local delivering = token.owner == "Eggs" or token.owner == "Hunter" or token.owner == "Recover" or token.owner == "Volcano"
    if delivering and ((xDTaraZ.Eggs and xDTaraZ.Eggs.CarryCritical) or xDTaraZ.Tasks.Carrying()) then return true end

    xDTaraZ.Tasks.Release(token)
    return false
end

---@param cond     function|nil  nil waits the full timeout
---@return boolean, string        "ok"|"timeout"|"preempted"|"death"|"unload"
function xDTaraZ.Tasks.Await(token, cond, timeout)
    local deadline = os.clock() + timeout
    repeat
        if not xDTaraZ.State.Alive then return false, "unload" end
        if not token or token.epoch ~= xDTaraZ.Player.Epoch then return false, "death" end
        if not xDTaraZ.Tasks.Holds(token) then return false, "preempted" end
        if cond and cond() then return true, "ok" end
        task.wait()
    until os.clock() >= deadline
    return false, "timeout"
end

---@return boolean  refuses dead tokens
function xDTaraZ.Tasks.Teleport(token, cf)
    if not token or token.dead or xDTaraZ.Tasks.Current ~= token then return false end
    if token.epoch ~= xDTaraZ.Player.Epoch or not xDTaraZ.Player:IsAlive() then return false end
    local hrp = xDTaraZ.Player.Root
    if not hrp then return false end

    hrp.CFrame = cf
    hrp.AssemblyLinearVelocity = Vector3.zero
    return true
end

function xDTaraZ.Tasks.Abort(why)
    local cur = xDTaraZ.Tasks.Current
    if not cur then return end
    cur.dead, cur.why = true, why
    xDTaraZ.Tasks.Current = nil
end

function xDTaraZ.Tasks.ReleaseAll(why)
    xDTaraZ.Tasks.Abort(why or "release")
end

function xDTaraZ.Tasks.Owner()
    local cur = xDTaraZ.Tasks.Current
    return cur and not cur.dead and cur.owner or nil
end

xDTaraZ.Scheduler = { Jobs = {}, Order = {}, Booted = false }

xDTaraZ.Scheduler.Defaults = {
    { "Eggs", "Eggs", "Step", { "AutoEggs" } },
    { "Hunter", "Hunter", "Step", { "EggHunter" } },
    { "Volcano", "Volcano", "Step", { "VolcanoDip", "VolcanoObby" } },
    { "Junk", "Junk", "Step", { "ClearJunk" } },
    { "Hatch", "Hatch", "Step", { "AutoHatch" } },
    { "Plant", "Hatch", "PlantStep", { "AutoPlaceEggs" } },
    { "Pets", "Pets", "Step", { "AutoEquipBest", "AutoCollectCash" } },
    { "Feed", "Pets", "FeedStep", { "AutoFeed" } },
    { "Sell", "Sell", "Step", { "AutoSell" } },
    { "Fusion", "Fusion", "Step", { "AutoFusion" } },
    { "Economy", "Economy", "Step", { "AutoUpgrade", "AutoRebirth", "SmartSpend" } },
    { "Shop", "Shop", "Step", { "AutoShop" } },
    { "Rewards", "Rewards", "Step", { "AutoClaim" } },
    { "Boosts", "Boosts", "Step", nil },
    { "Server", "Server", "Step", nil },
    { "Esp", "Esp", "Step", { "EggEsp" } },
    { "Webhook", "Webhook", "Step", nil },
    { "Settle", "Eggs", "SettleStep", nil },
    { "Kaitun", "Kaitun", "Step", { "Kaitun" } },
}

---@param enabledFn function|nil  nil = any of toggles is on, or always when toggles is nil too
---@param toggles string[]|nil    switched off when the job halts
function xDTaraZ.Scheduler.Add(name, interval, fn, enabledFn, toggles)
    local job = xDTaraZ.Scheduler.Jobs[name]
    if not job then
        job = { name = name, due = 0, busy = false }
        job.runner = function()
            local ok, err = pcall(job.fn)
            job.busy = false
            if ok then return end
            xDTaraZ.Scheduler.Fail(job, err)
        end
        xDTaraZ.Scheduler.Jobs[name] = job
        table.insert(xDTaraZ.Scheduler.Order, job)
    end
    job.interval, job.fn, job.enabledFn, job.toggles = interval, fn, enabledFn, toggles or {}
    return job
end

---@return boolean
function xDTaraZ.Scheduler.Enabled(job)
    if State.Halted[job.name] then return false end
    if job.enabledFn then return job.enabledFn() == true end
    if #job.toggles == 0 then return true end

    for _, idx in ipairs(job.toggles) do
        if xDTaraZ.Util.Opt(idx) == true then return true end
    end
    return false
end

function xDTaraZ.Scheduler.Fail(job, err)
    local now = os.clock()
    local log = State.Errors[job.name] or {}
    State.Errors[job.name] = log

    local kept = {}
    for _, at in ipairs(log) do
        if now - at <= Config.FailWindow then kept[#kept + 1] = at end
    end
    kept[#kept + 1] = now
    State.Errors[job.name] = kept

    if #kept == 1 then warn(Config.Tag, job.name .. " failing:", err) end
    if #kept < Config.FailLimit then return end

    if #job.toggles == 0 then
        State.Errors[job.name] = nil
        job.due = now + Config.JobBackoff
        warn(Config.Tag, job.name .. " backing off:", err)
        return
    end

    State.Halted[job.name] = true
    for _, idx in ipairs(job.toggles) do
        table.insert(State.PendingToggleOff, idx)
    end
    local line = tostring(err):match("^[^\n]*") or "unknown error"
    xDTaraZ.Util.Notify("Mario Hub", job.name .. " stopped: " .. line, 8)
end

function xDTaraZ.Scheduler.Run(job)
    job.busy = true
    task.spawn(job.runner)
end

function xDTaraZ.Scheduler.Tick()
    if not State.Alive then return end
    local now = os.clock()
    for _, job in ipairs(xDTaraZ.Scheduler.Order) do
        if job.busy or now < job.due then continue end
        job.due = now + job.interval
        if not xDTaraZ.Scheduler.Enabled(job) then continue end
        xDTaraZ.Scheduler.Run(job)
    end
end

---@param key string  job name or toggle idx
function xDTaraZ.Scheduler.Resume(key)
    for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
        if name == key or table.find(job.toggles, key) then
            State.Halted[name] = nil
            State.Errors[name] = nil
            job.due = 0
        end
    end
end

function xDTaraZ.Scheduler.Pump()
    if not Library then return end
    if #State.PendingToggleOff == 0 and #State.PendingNotify == 0 then return end

    local offList = State.PendingToggleOff
    State.PendingToggleOff = {}
    for _, idx in ipairs(offList) do
        local option = Library.Options and Library.Options[idx]
        if option and option.Value then option:SetValue(false) end
        xDTaraZ.Options[idx] = false
    end

    local notes = State.PendingNotify
    State.PendingNotify = {}
    for _, note in ipairs(notes) do
        Library:Notify(note[1], note[2], note[3] or 5)
    end
end

function xDTaraZ.Scheduler.AddDefaults()
    local espTick = xDTaraZ.Platform.Mobile and Config.EspTickMobile or Config.EspTick
    for _, row in ipairs(xDTaraZ.Scheduler.Defaults) do
        local name, owner, method, toggles = row[1], row[2], row[3], row[4]
        local interval = Config.JobTick[name] or espTick
        if xDTaraZ.Scheduler.Jobs[name] then continue end

        local module = rawget(xDTaraZ, owner)
        local fn = module and module[method]
        if type(fn) ~= "function" then
            warn(Config.Tag, "no job function " .. owner .. "." .. method)
            continue
        end
        xDTaraZ.Scheduler.Add(name, interval, fn, nil, toggles)
    end
end

function xDTaraZ.Scheduler.Boot()
    if xDTaraZ.Scheduler.Booted then return end
    xDTaraZ.Scheduler.Booted = true

    xDTaraZ.Scheduler.AddDefaults()
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Scheduler.Tick)
end

xDTaraZ.Signal = {}
xDTaraZ.Signal.__index = xDTaraZ.Signal

function xDTaraZ.Signal.new()
    return setmetatable({ handlers = {} }, xDTaraZ.Signal)
end

---@return function  call to disconnect
function xDTaraZ.Signal:Connect(fn)
    local handlers = self.handlers
    handlers[#handlers + 1] = fn
    return function()
        local at = table.find(handlers, fn)
        if at then table.remove(handlers, at) end
    end
end

function xDTaraZ.Signal:Fire(...)
    for _, fn in ipairs(table.clone(self.handlers)) do
        xDTaraZ.Util.Try("signal", fn, ...)
    end
end

xDTaraZ.EggIndex = {
    Entries = {}, Conns = {}, Waiters = {},
    Claimed = {}, LocalClaims = {}, Blacklist = {}, Failed = {}, FailCap = 2,
    Memo = {}, Mult = nil, Median = nil, ValueEpoch = 0,
    Cycle = nil, RolledAt = 0, Started = false,
    OnAdded = xDTaraZ.Signal.new(),
    OnRemoved = xDTaraZ.Signal.new(),
    OnReply = xDTaraZ.Signal.new(),
    OnRoll = xDTaraZ.Signal.new(),
}

---@return number  hatch luck multiplier: upgrades x live event
function xDTaraZ.EggIndex.LuckMult()
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local upgrades = saved and saved:FindFirstChild("HatchUpgrades")
    local n = upgrades and tonumber(upgrades.Value) or 0
    local event = tonumber(ReplicatedStorage:GetAttribute("HatchLuckEventMultiplier")) or 1
    return (1 + n + 4 * math.floor(n / 5)) * event
end

---@return number  expected income of one hatch, luck-based fallback when odds are unreadable
function xDTaraZ.EggIndex.Expected(egg, mult)
    local key = egg .. "|" .. mult
    local memo = xDTaraZ.EggIndex.Memo
    if memo[key] then return memo[key] end

    local total = 0
    for _, pair in ipairs(GameLib.Odds(egg, mult) or {}) do
        local pet = GameLib.PetInfo[pair[1]]
        total += (tonumber(pair[2]) or 0) * (pet and pet.income or 0)
    end
    if total <= 0 then
        local info = GameLib.EggInfo[egg]
        total = (info and info.luck or 0) * mult
    end

    memo[key] = total
    return total
end

function xDTaraZ.EggIndex.Value(entry)
    if not entry.egg then return 0 end
    local index = xDTaraZ.EggIndex
    index.Mult = index.Mult or index.LuckMult()
    local factor = entry.mutation and GameLib.Mutations[entry.mutation] or 1
    return index.Expected(entry.egg, index.Mult) * (entry.weight or 1) * factor
end

function xDTaraZ.EggIndex.Revalue()
    local index = xDTaraZ.EggIndex
    table.clear(index.Memo)
    index.Mult = nil
    for _, entry in pairs(index.Entries) do
        entry.value = index.Value(entry)
    end
    index.Median = nil
    index.ValueEpoch += 1
end

---@param entry table?  refreshed in place when given
function xDTaraZ.EggIndex.Read(inst, entry)
    entry = entry or { guid = inst.Name, inst = inst }
    entry.egg = inst:GetAttribute("Egg")
    entry.pos = inst:GetAttribute("Position")
    entry.weight = tonumber(inst:GetAttribute("Weight")) or 1
    entry.mutation = inst:GetAttribute("Mutation")
    entry.cycle = tonumber(inst:GetAttribute("Cycle"))
    entry.privateTo = inst:GetAttribute("PrivateTo")
    entry.area = inst:GetAttribute("Area") == true
    entry.dropEndsAt = tonumber(inst:GetAttribute("DropEndsAt"))
    entry.origin = inst:GetAttribute("OriginPosition")
    entry.value = xDTaraZ.EggIndex.Value(entry)
    return entry
end

function xDTaraZ.EggIndex.Add(inst)
    local index = xDTaraZ.EggIndex
    if index.Entries[inst.Name] then return end
    local entry = index.Read(inst)
    index.Entries[inst.Name] = entry
    index.Median = nil

    index.Conns[inst.Name] = inst.AttributeChanged:Connect(function(attr)
        if attr ~= "Position" and attr ~= "DropEndsAt" and attr ~= "PrivateTo" then return end
        local wasDropped = entry.dropEndsAt ~= nil
        index.Read(inst, entry)
        if attr == "DropEndsAt" and not wasDropped and entry.dropEndsAt then index.OnAdded:Fire(entry) end
    end)

    index.OnAdded:Fire(entry)
end

function xDTaraZ.EggIndex.Remove(inst)
    local index = xDTaraZ.EggIndex
    local entry = index.Entries[inst.Name]
    if not entry then return end
    index.Entries[inst.Name] = nil
    entry.removed = true

    local conn = index.Conns[inst.Name]
    if conn then conn:Disconnect() end
    index.Conns[inst.Name] = nil
    index.Median = nil
    index.OnRemoved:Fire(entry)
end

---@param key string  egg guid, or "*carry" for Deposited/BasketFull
function xDTaraZ.EggIndex.Expect(key)
    local waiter = {}
    xDTaraZ.EggIndex.Waiters[key] = waiter
    return waiter
end

function xDTaraZ.EggIndex.Deliver(key, kind, text)
    local waiter = key and xDTaraZ.EggIndex.Waiters[key]
    if not waiter or waiter.kind then return end
    waiter.kind, waiter.text = kind, text
end

---@return string, string?  PickedUp|Refused|Gone|BasketFull|Deposited|Timeout, server text
function xDTaraZ.EggIndex.WaitReply(key, timeout)
    local index = xDTaraZ.EggIndex
    local waiter = index.Waiters[key] or index.Expect(key)
    local deadline = os.clock() + timeout
    while not waiter.kind and os.clock() < deadline and State.Alive do
        task.wait()
    end
    if index.Waiters[key] == waiter then index.Waiters[key] = nil end
    if not waiter.kind then return "Timeout" end
    return waiter.kind, waiter.text
end

function xDTaraZ.EggIndex.Route(kind, first, second)
    local index = xDTaraZ.EggIndex
    if kind == "PickedUp" then
        index.Deliver(second, "PickedUp", first)
        index.OnReply:Fire("PickedUp", second, first)
    elseif kind == "Refused" then
        local text = tostring(first)
        local verdict = text:find("already gone", 1, true) and "Gone" or "Refused"
        if verdict == "Gone" and second then index.Blacklist[second] = os.clock() + Config.GoneBlacklistSec end
        index.Deliver(second, verdict, text)
        index.OnReply:Fire(verdict, second, text)
    elseif kind == "Deposited" then
        index.Deliver("*carry", "Deposited", tostring(first))
        index.OnReply:Fire("Deposited", nil, first)
    elseif kind == "BasketFull" then
        for key in pairs(index.Waiters) do index.Deliver(key, "BasketFull") end
        index.OnReply:Fire("BasketFull")
    end
end

function xDTaraZ.EggIndex.OnMessage(text)
    if type(text) ~= "string" then return end
    if text:find("Egg Delivery Failed", 1, true) or text:find("Was Returned", 1, true) then
        xDTaraZ.Guard.Trip("message")
    end
end

function xDTaraZ.EggIndex.ReadClaims()
    local index = xDTaraZ.EggIndex
    local raw = LocalPlayer:GetAttribute("CollectedEggCycles")
    if type(raw) ~= "string" or raw == "" then return end

    local http = game:GetService("HttpService")
    local ok, decoded = pcall(http.JSONDecode, http, raw)
    if not ok or type(decoded) ~= "table" then
        index.ClaimsBroken = true
        return
    end

    table.clear(index.Claimed)
    for egg, cycle in pairs(decoded) do
        index.Claimed[egg] = tonumber(cycle)
    end
    index.ClaimsBroken = false
end

---@return number  last cycle this egg was claimed in, -1 if never
function xDTaraZ.EggIndex.ClaimedCycle(egg)
    local index = xDTaraZ.EggIndex
    return math.max(index.Claimed[egg] or -1, index.LocalClaims[egg] or -1)
end

function xDTaraZ.EggIndex.MarkClaimed(egg, cycle)
    if not egg or not cycle then return end
    local claims = xDTaraZ.EggIndex.LocalClaims
    claims[egg] = math.max(claims[egg] or -1, cycle)
end

function xDTaraZ.EggIndex.MarkGone(guid)
    if guid then xDTaraZ.EggIndex.Blacklist[guid] = os.clock() + Config.GoneBlacklistSec end
end

function xDTaraZ.EggIndex.Fail(guid)
    local failed = xDTaraZ.EggIndex.Failed
    failed[guid] = (failed[guid] or 0) + 1
end

---@return boolean  true on the tick the egg cycle rolled over
function xDTaraZ.EggIndex.CheckRoll()
    local index = xDTaraZ.EggIndex
    local cycle = GameLib.CycleIndex()
    if cycle == index.Cycle then return false end

    local rolled = index.Cycle ~= nil
    index.Cycle = cycle
    if not rolled then return false end

    table.clear(index.Blacklist)
    table.clear(index.Failed)
    index.RolledAt = os.clock()
    index.OnRoll:Fire(cycle)
    return true
end

---@return number  median value of the eggs on the map now
function xDTaraZ.EggIndex.MedianValue()
    local index = xDTaraZ.EggIndex
    if index.Median then return index.Median end

    local values = {}
    for _, entry in pairs(index.Entries) do
        local info = entry.egg and GameLib.EggInfo[entry.egg]
        if info and not info.volcanic then values[#values + 1] = entry.value or 0 end
    end
    table.sort(values)

    index.Median = values[math.max(1, math.ceil(#values / 2))] or 0
    return index.Median
end

---@return string?  reason the egg cannot be taken right now
function xDTaraZ.EggIndex.Blocked(entry, info)
    local index = xDTaraZ.EggIndex
    if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then return "private" end
    if info.volcanic then return "volcanic" end
    if entry.dropEndsAt and xDTaraZ.Util.ServerNow() < entry.dropEndsAt then return "falling" end
    if info.ethereal and entry.cycle and entry.cycle <= index.ClaimedCycle(entry.egg) then return "claimed" end
    if (index.Blacklist[entry.guid] or 0) > os.clock() then return "taken" end
    if (index.Failed[entry.guid] or 0) >= index.FailCap then return "failed" end
    return nil
end

---@return boolean  passes the user's egg filters
function xDTaraZ.EggIndex.Allowed(entry, info)
    local opts = xDTaraZ.Options
    local rarities, names = opts.EggRarities, opts.EggNames
    local floor = GameLib.RarityRank[opts.MinEggRarity or ""]
    if floor and (GameLib.RarityRank[info.rarity] or 0) < floor then return false end
    if type(rarities) == "table" and next(rarities) and not rarities[info.rarity] then return false end
    if type(names) == "table" and next(names) and not names[entry.egg] then return false end
    if (info.luck or 0) < (tonumber(opts.MinLuck) or 0) then return false end
    return entry.weight >= (tonumber(opts.MinWeight) or 0)
end

---@param ignoreFilters boolean?  hunter-only mode skips the user filters
---@return boolean, string?       wanted, reason when not
function xDTaraZ.EggIndex.Wanted(entry, ignoreFilters)
    if entry.removed or not entry.pos or not entry.egg then return false, "gone" end
    local info = GameLib.EggInfo[entry.egg]
    if not info then return false, "unknown" end

    local reason = xDTaraZ.EggIndex.Blocked(entry, info)
    if reason then return false, reason end
    if ignoreFilters then return true end

    if not xDTaraZ.EggIndex.Allowed(entry, info) then return false, "filtered" end
    if xDTaraZ.Options.SmartEggs and (entry.value or 0) < xDTaraZ.EggIndex.MedianValue() then return false, "low value" end
    return true
end

function xDTaraZ.EggIndex.WatchValues()
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local upgrades = saved and saved:FindFirstChild("HatchUpgrades")
    if upgrades then xDTaraZ:Connect(upgrades.Changed, xDTaraZ.EggIndex.Revalue) end
    xDTaraZ:Connect(ReplicatedStorage:GetAttributeChangedSignal("HatchLuckEventMultiplier"), xDTaraZ.EggIndex.Revalue)
    xDTaraZ:Connect(LocalPlayer:GetAttributeChangedSignal("CollectedEggCycles"), xDTaraZ.EggIndex.ReadClaims)
end

---@return boolean  index is live
function xDTaraZ.EggIndex.Start()
    local index = xDTaraZ.EggIndex
    if index.Started then return true end
    local serverData = ReplicatedStorage:FindFirstChild("ServerData")
    local folder = serverData and serverData:FindFirstChild("ActiveEggs")
    if not folder then return false end
    index.Started = true

    xDTaraZ:Connect(folder.ChildAdded, xDTaraZ.EggIndex.Add)
    xDTaraZ:Connect(folder.ChildRemoved, xDTaraZ.EggIndex.Remove)
    for _, inst in ipairs(folder:GetChildren()) do
        index.Add(inst)
    end

    local pickup = GameLib.Remote("EggPickup")
    if pickup then xDTaraZ:Connect(pickup.OnClientEvent, xDTaraZ.EggIndex.Route) end
    local message = GameLib.Remote("GameMessage")
    if message then xDTaraZ:Connect(message.OnClientEvent, xDTaraZ.EggIndex.OnMessage) end

    index.WatchValues()
    index.ReadClaims()
    index.Cycle = GameLib.CycleIndex()
    return true
end

function xDTaraZ.EggIndex.Stop()
    local index = xDTaraZ.EggIndex
    for guid, conn in pairs(index.Conns) do
        conn:Disconnect()
        index.Conns[guid] = nil
    end
    table.clear(index.Waiters)
end

xDTaraZ.Delivery = {}

---@return "Plot"|"Direct"|"Drop", number  mode, trip studs
function xDTaraZ.Delivery.Mode(entry)
    local _, bp = xDTaraZ.Player:Plot()
    if not bp or not entry or not entry.pos then return "Drop", math.huge end

    local inside = xDTaraZ.Geo.EdgeInside(bp, entry.pos)
    if xDTaraZ.Util.Flat(inside, entry.pos) <= xDTaraZ.Config.PickupReach then return "Plot", 0 end

    local trip = xDTaraZ.Geo.Trip(bp, xDTaraZ.Geo.StandPoint(bp, entry.pos))
    local opts = xDTaraZ.Options
    if opts and opts.DeliveryMode == "Safe" then return "Drop", trip end

    if xDTaraZ.Delivery.Fits(trip, entry.weight, entry.egg) then return "Direct", trip end
    return "Drop", trip
end

---@return number  carry speed left after the egg weight slowdown
function xDTaraZ.Delivery.WeightFactor(weight, eggName)
    local cfg = xDTaraZ.Config
    local over = math.max(0, (tonumber(weight) or 1) - 1)
    local per = eggName == "Cherub" and cfg.CherubWeightPenalty or cfg.WeightPenalty
    return 1 - math.min(cfg.WeightPenaltyMax, over * 10 * per)
end

---@param weight number|nil  carried egg weight, nil = light
---@return boolean           straight trip home passes with the pet ridden right now
function xDTaraZ.Delivery.Fits(trip, weight, eggName)
    local factor = xDTaraZ.Delivery.WeightFactor(weight, eggName)
    local speed = xDTaraZ.Mount.Speed()
    if speed > 0 then return trip <= xDTaraZ.State.Tune.DirectFactor * speed * factor end
    return trip <= xDTaraZ.Config.UnmountedDirect * factor
end

---@return boolean  true when the full time passed
function xDTaraZ.Delivery.Sleep(token, sec)
    if sec <= 0 then return true end
    local _, why = xDTaraZ.Tasks.Await(token, nil, sec)
    return why == "timeout"
end

---@return boolean, string
function xDTaraZ.Delivery.Pickup(token, guid, standPos)
    local cfg = xDTaraZ.Config
    local remote = xDTaraZ.GameLib.Remote("EggPickup")
    local hrp = xDTaraZ.Player.Root
    if not remote or not hrp then return false, "missing" end

    if (hrp.Position - standPos).Magnitude > 1 then
        if not xDTaraZ.Tasks.Teleport(token, CFrame.new(standPos)) then return false, "aborted" end
        if not xDTaraZ.Delivery.Sleep(token, cfg.TpSettle) then return false, "aborted" end
    end

    local deadline = os.clock() + cfg.PickupTotalTimeout
    repeat
        if token.dead or token.epoch ~= xDTaraZ.Player.Epoch then return false, "aborted" end
        remote:FireServer(guid)
        local kind, text = xDTaraZ.EggIndex.WaitReply(guid, cfg.PickupReplyTimeout)

        if kind == "PickedUp" then return true, "ok" end
        if xDTaraZ.Player:BasketCount() > 0 then return true, "ok" end
        if kind == "BasketFull" then return false, "full" end
        if kind == "Gone" then
            xDTaraZ.EggIndex.MarkGone(guid)
            return false, "gone"
        end
        if kind == "Refused" and not tostring(text or ""):find("studs") then return false, "refused" end
        if kind == "Refused" then task.wait(cfg.PickupRetryStep) end
    until os.clock() >= deadline
    return false, "timeout"
end

---@return boolean  only true on the server's Deposited reply
function xDTaraZ.Delivery.AwaitDeposit(token, timeout)
    local kind = xDTaraZ.EggIndex.WaitReply("*carry", timeout)
    return kind == "Deposited" and not xDTaraZ.Guard.Tripped
end

function xDTaraZ.Delivery.StepHome(token, bp)
    local hrp = xDTaraZ.Player.Root
    if not hrp then return false end
    return xDTaraZ.Tasks.Teleport(token, CFrame.new(xDTaraZ.Geo.EdgeInside(bp, hrp.Position)))
end

---@return table|nil  newest dropped entry for the carried egg
---@param before table  guids that existed before our drop
function xDTaraZ.Delivery.FindDrop(eggName, origin, since, before)
    local hrp = xDTaraZ.Player.Root
    local here = hrp and hrp.Position
    local byOrigin, nearest, nearestDist = nil, nil, math.huge

    for _, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if not entry.dropEndsAt or entry.dropEndsAt < since then continue end
        if before[entry.guid or ""] then continue end
        if origin and entry.origin and xDTaraZ.Util.Flat(entry.origin, origin) < 1 then
            byOrigin = entry
            break
        end
        if entry.egg == eggName and here then
            local dist = xDTaraZ.Util.Flat(entry.pos, here)
            if dist < nearestDist then nearest, nearestDist = entry, dist end
        end
    end
    return byOrigin or nearest
end

---@return table|nil
function xDTaraZ.Delivery.Drop(token, eggName, origin)
    local cfg = xDTaraZ.Config
    local remote = xDTaraZ.GameLib.Remote("BasketDrop")
    if not remote then return nil end

    local before = {}
    for _, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if entry.guid then before[entry.guid] = true end
    end
    local since = xDTaraZ.Util.ServerNow() - 0.5
    remote:FireServer()

    local drop
    xDTaraZ.Tasks.Await(token, function()
        drop = xDTaraZ.Delivery.FindDrop(eggName, origin, since, before)
        return drop ~= nil
    end, cfg.DropAppearTimeout)
    return drop
end

function xDTaraZ.Delivery.WaitLanded(token, drop)
    local landAt = drop.dropEndsAt + xDTaraZ.Config.DropEndsSlack
    local ok = xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Util.ServerNow() >= landAt end, xDTaraZ.Config.DropAppearTimeout)
    return ok
end

function xDTaraZ.Delivery.RaiseSettle()
    local tune = xDTaraZ.State.Tune
    tune.DropSettle = math.min(tune.DropSettle + 0.05, xDTaraZ.Config.DropSettleMax)
    xDTaraZ.State.Stats.staleDrops += 1
end

function xDTaraZ.Delivery.LowerSettle()
    local tune = xDTaraZ.State.Tune
    local floor = math.max(xDTaraZ.Config.DropSettle, tonumber(xDTaraZ.Util.Opt("DropSettle")) or 0)
    tune.DropSettle = math.max(floor, tune.DropSettle - 0.01)
end

---@return "Deposited"|"Gone"|"Refused"|"Aborted"
function xDTaraZ.Delivery.DropCycle(token, bp, eggName, origin)
    local cfg = xDTaraZ.Config

    for _ = 0, 2 do
        local hrp = xDTaraZ.Player.Root
        if not hrp or os.clock() > token.budget then return "Aborted" end

        local out = xDTaraZ.Geo.Outside(bp, hrp.Position, cfg.DropOutside)
        if not xDTaraZ.Tasks.Teleport(token, CFrame.new(out)) then return "Aborted" end
        if not xDTaraZ.Delivery.Sleep(token, xDTaraZ.State.Tune.DropSettle) then return "Aborted" end

        local drop = xDTaraZ.Delivery.Drop(token, eggName, origin)
        if not drop then return xDTaraZ.Player:BasketCount() == 0 and "Gone" or "Aborted" end
        origin = drop.origin or origin

        local fresh = xDTaraZ.Util.Flat(drop.pos, out) <= cfg.StaleDropDistance
        local stand = fresh and out or drop.pos + Vector3.new(0, 3, 0)
        if fresh then xDTaraZ.Delivery.LowerSettle() end
        if not fresh then
            xDTaraZ.Delivery.RaiseSettle()
            if not xDTaraZ.Tasks.Teleport(token, CFrame.new(stand)) then return "Aborted" end
        end
        if not xDTaraZ.Delivery.WaitLanded(token, drop) then return "Aborted" end

        local got, why = xDTaraZ.Delivery.Pickup(token, drop.guid, stand)
        if not got then return why == "gone" and "Gone" or "Aborted" end

        if fresh or xDTaraZ.Delivery.Fits(xDTaraZ.Geo.Trip(bp, stand), drop.weight, eggName) then
            if not xDTaraZ.Delivery.StepHome(token, bp) then return "Aborted" end
            return xDTaraZ.Delivery.AwaitDeposit(token, cfg.DepositTimeout) and "Deposited" or "Aborted"
        end
    end
    return "Aborted"
end

---@return "Deposited"|"Aborted"
function xDTaraZ.Delivery.DirectHome(token, bp)
    local cfg = xDTaraZ.Config
    if not xDTaraZ.Delivery.StepHome(token, bp) then return "Aborted" end
    if xDTaraZ.Delivery.AwaitDeposit(token, cfg.DepositTimeout) then return "Deposited" end
    if xDTaraZ.Player:BasketCount() > 0 and xDTaraZ.Player:Flags() <= token.flags0 then
        if xDTaraZ.Delivery.AwaitDeposit(token, cfg.DepositTimeout) then return "Deposited" end
    end
    return "Aborted"
end

---@return "Deposited"|"Gone"|"Refused"|"Aborted", number  outcome, seconds
function xDTaraZ.Delivery.Run(token, entry)
    local _, bp = xDTaraZ.Player:Plot()
    if not bp or not entry then return "Aborted", 0 end

    local t0 = os.clock()
    token.flags0 = xDTaraZ.Player:Flags()
    token.budget = t0 + xDTaraZ.Config.RunBudget

    local mode, trip = xDTaraZ.Delivery.Mode(entry)
    xDTaraZ.Delivery.LastPlan = { mode = mode, trip = math.floor(trip), speed = xDTaraZ.Mount.Speed(), settle = xDTaraZ.State.Tune.DirectFactor }
    local stand = mode == "Plot" and xDTaraZ.Geo.EdgeInside(bp, entry.pos) or xDTaraZ.Geo.StandPoint(bp, entry.pos)

    local got, why = xDTaraZ.Delivery.Pickup(token, entry.guid, stand)
    if not got then
        if why == "full" then xDTaraZ.Delivery.Recover(token) end
        return why == "gone" and "Gone" or (why == "refused" and "Refused" or "Aborted"), os.clock() - t0
    end

    xDTaraZ.Eggs.CarryCritical = true
    local outcome
    if mode == "Plot" then
        outcome = xDTaraZ.Delivery.AwaitDeposit(token, xDTaraZ.Config.DepositTimeout) and "Deposited" or "Aborted"
    elseif mode == "Direct" then
        outcome = xDTaraZ.Delivery.DirectHome(token, bp)
    else
        outcome = xDTaraZ.Delivery.DropCycle(token, bp, entry.egg, entry.origin or entry.pos)
    end

    if outcome ~= "Deposited" and xDTaraZ.Player:BasketCount() > 0 then xDTaraZ.Delivery.Recover(token) end
    xDTaraZ.Eggs.CarryCritical = false
    xDTaraZ.Guard.Check(token.flags0)

    local seconds = os.clock() - t0
    local stats = xDTaraZ.State.Stats
    if outcome == "Deposited" then
        local key = string.lower(mode)
        stats[key] = (stats[key] or 0) + 1
    end
    stats.lastRun, stats.lastMode = seconds, mode
    return outcome, seconds
end

---@return string|nil, string|nil  egg name, "Delivering"|"Carry"|"Unknown"
function xDTaraZ.Delivery.Carried()
    local items = xDTaraZ.Player:BasketItems()
    local first = items[1]
    if not first then return nil, nil end
    if first:GetAttribute("Delivering") == true then return first:GetAttribute("Egg"), "Delivering" end
    if first:GetAttribute("BreakAt") then return first:GetAttribute("Egg"), "Carry" end
    return first:GetAttribute("Egg"), "Unknown"
end

---@return boolean  deposited after stepping out of the plot and back in
function xDTaraZ.Delivery.Reenter(token, bp, hrp)
    local cfg = xDTaraZ.Config
    local out = xDTaraZ.Geo.Outside(bp, hrp.Position, cfg.DropOutside)
    if not xDTaraZ.Tasks.Teleport(token, CFrame.new(out)) then return false end
    if not xDTaraZ.Delivery.Sleep(token, cfg.TpSettle) then return false end
    if not xDTaraZ.Delivery.StepHome(token, bp) then return false end
    return xDTaraZ.Delivery.AwaitDeposit(token, cfg.DepositTimeout)
end

---@return boolean  basket empty afterwards
function xDTaraZ.Delivery.Recover(token)
    local eggName, phase = xDTaraZ.Delivery.Carried()
    if not phase then return true end

    local cfg = xDTaraZ.Config
    token.flags0 = token.flags0 or xDTaraZ.Player:Flags()
    token.budget = math.max(token.budget or 0, os.clock() + cfg.RunBudget)

    if phase ~= "Carry" then
        xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Player:BasketCount() == 0 end, cfg.DepositTimeout)
        return xDTaraZ.Player:BasketCount() == 0
    end

    local _, bp = xDTaraZ.Player:Plot()
    local hrp = xDTaraZ.Player.Root
    if not bp or not hrp then return false end

    local wasCritical = xDTaraZ.Eggs.CarryCritical
    xDTaraZ.Eggs.CarryCritical = true
    if not (xDTaraZ.Geo.InPlot(hrp.Position) and xDTaraZ.Delivery.Reenter(token, bp, hrp)) then
        xDTaraZ.Delivery.DropCycle(token, bp, eggName, nil)
    end
    xDTaraZ.Eggs.CarryCritical = wasCritical
    return xDTaraZ.Player:BasketCount() == 0
end

xDTaraZ.Mount = { Name = nil, Dirty = true, AutoLabel = "Auto (fastest)" }

function xDTaraZ.Mount.PetName(inst)
    local name = inst:GetAttribute("PetName") or inst.Name
    if xDTaraZ.GameLib.PetInfo[name] then return name end
    return nil
end

function xDTaraZ.Mount.Moving(name)
    local pets = xDTaraZ.GameLib.Data and xDTaraZ.GameLib.Data.Pets
    local row = pets and pets[name]
    return type(row) == "table" and tonumber(row.MovementSpeed) or 0
end

---@return table  pet name -> Tool, Backpack and hand
function xDTaraZ.Mount.Tools()
    return xDTaraZ.Pets.ToolsByName()
end

---@return string|nil  ridden pet name from the mount joint
function xDTaraZ.Mount.Detect()
    local hrp = xDTaraZ.Player.Root
    local joint = hrp and hrp:FindFirstChild("PetMountJoint")
    local part = joint and joint.Part1
    local model = part and part:FindFirstAncestorOfClass("Model")
    if not model then return nil end
    return xDTaraZ.Mount.PetName(model)
end

function xDTaraZ.Mount.Choice()
    local opts = xDTaraZ.Options
    local pick = opts and opts.RidePet
    if type(pick) ~= "string" or pick == "" or pick == xDTaraZ.Mount.AutoLabel then return nil end
    return pick
end

---@return string|nil, number  name, ride speed
function xDTaraZ.Mount.Best()
    local info = xDTaraZ.GameLib.PetInfo
    local forced = xDTaraZ.Mount.Choice()
    if forced then return forced, info[forced] and info[forced].speed or 0 end

    local names = {}
    for name in pairs(xDTaraZ.Mount.Tools()) do names[#names + 1] = name end
    if xDTaraZ.Player:Riding() and xDTaraZ.Mount.Name then table.insert(names, xDTaraZ.Mount.Name) end

    local best, bestSpeed, bestMove = nil, 0, 0
    for _, name in ipairs(names) do
        local speed = info[name] and info[name].speed or 0
        local move = xDTaraZ.Mount.Moving(name)
        if speed > bestSpeed or (speed == bestSpeed and speed > 0 and move > bestMove) then
            best, bestSpeed, bestMove = name, speed, move
        end
    end
    return best, bestSpeed
end

function xDTaraZ.Mount.Speed()
    if not xDTaraZ.Player:Riding() then return 0 end
    local name = xDTaraZ.Mount.Name or xDTaraZ.Mount.Detect()
    if not name then return 0 end
    xDTaraZ.Mount.Name = name
    local info = xDTaraZ.GameLib.PetInfo[name]
    return info and info.speed or 0
end

function xDTaraZ.Mount.Forget()
    xDTaraZ.Mount.Name = nil
    xDTaraZ.Mount.Dirty = true
end

---@return Tool|nil  tool of a pet placed on the plot, only when the user named it
function xDTaraZ.Mount.Unplace(token, name)
    local remote = xDTaraZ.GameLib.Remote("PickupPet")
    if not remote then return nil end
    for _, pet in ipairs(xDTaraZ.Pets.Owned()) do
        if pet.name == name and pet.placed then
            remote:FireServer(pet.key)
            break
        end
    end

    local tool
    xDTaraZ.Tasks.Await(token, function()
        tool = xDTaraZ.Pets.ToolNamed(name)
        return tool ~= nil
    end, xDTaraZ.Config.MountTimeout)
    return tool
end

function xDTaraZ.Mount.Dismount(token)
    local remote = xDTaraZ.GameLib.Remote("PetDismount")
    if not remote then return false end
    remote:FireServer()
    xDTaraZ.Mount.Name = nil
    return (xDTaraZ.Tasks.Await(token, function() return not xDTaraZ.Player:Riding() end, xDTaraZ.Config.MountTimeout))
end

---@return boolean  riding the chosen pet
function xDTaraZ.Mount.Ensure(token)
    local cfg = xDTaraZ.Config
    if xDTaraZ.Player:BasketCount() > 0 or not xDTaraZ.Player:IsAlive() then return false end

    local name = xDTaraZ.Mount.Best()
    if not name then return false end
    if xDTaraZ.Player:Riding() then
        if (xDTaraZ.Mount.Name or xDTaraZ.Mount.Detect()) == name then
            xDTaraZ.Mount.Name, xDTaraZ.Mount.Dirty = name, false
            return true
        end
        if not xDTaraZ.Mount.Dismount(token) then return false end
    end

    local tool = xDTaraZ.Pets.ToolNamed(name)
    if not tool and xDTaraZ.Mount.Choice() == name then tool = xDTaraZ.Mount.Unplace(token, name) end
    local remote = xDTaraZ.GameLib.Remote("Mounting")
    local hum = xDTaraZ.Player.Humanoid
    if not tool or not remote or not hum then return false end

    hum:EquipTool(tool)
    for _ = 1, cfg.MountTries do
        remote:FireServer()
        local ok, why = xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Player:Riding() end, cfg.MountGap)
        if ok then break end
        if why ~= "timeout" then return false end
    end
    xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Player:Riding() end, cfg.MountTimeout)

    if not xDTaraZ.Player:Riding() then return false end
    xDTaraZ.Mount.Name, xDTaraZ.Mount.Dirty = name, false
    return true
end

function xDTaraZ.Mount.Watch(backpack)
    if not backpack then return end
    xDTaraZ:Connect(backpack.ChildAdded, function(child)
        if child:IsA("Tool") and xDTaraZ.Mount.PetName(child) then xDTaraZ.Mount.Dirty = true end
    end)
end

task.spawn(function()
    xDTaraZ.Mount.Watch(LocalPlayer:WaitForChild("Backpack", xDTaraZ.Config.LoadTimeout))
end)
xDTaraZ:Connect(LocalPlayer.CharacterAdded, function()
    task.defer(function()
        xDTaraZ.Mount.Watch(LocalPlayer:WaitForChild("Backpack", xDTaraZ.Config.LoadTimeout))
    end)
end)

xDTaraZ.Planner = {
    Ranked = {}, Contested = {},
    Dirty = true, BuiltAt = 0, Epoch = -1, MountName = nil,
    RebuildGap = 0.5, MaxAge = 2, ContestStep = 0.25,
    Started = false,
}

---@return number  studs per second this player can close on an egg
function xDTaraZ.Planner.PlayerSpeed(player, char)
    if player:GetAttribute("IsRiding") ~= true then return Config.UnmountedPlayerSpeed end
    for _, child in ipairs(char:GetChildren()) do
        local pet = GameLib.PetInfo[child.Name]
        if pet and pet.speed then return pet.speed end
    end
    return Config.UnmountedPlayerSpeed
end

---@return table  { {pos, speed} } of every other player with a body
function xDTaraZ.Planner.Riders()
    local riders = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        riders[#riders + 1] = { hrp.Position, xDTaraZ.Planner.PlayerSpeed(player, char) }
    end
    return riders
end

---@param riders table?  from Planner.Riders, built when nil
---@return number        0..1, 1 = someone is on it now
function xDTaraZ.Planner.Contest(entry, riders)
    if not entry.pos then return 0 end
    local best = 0
    for _, rider in ipairs(riders or xDTaraZ.Planner.Riders()) do
        local eta = xDTaraZ.Util.Flat(rider[1], entry.pos) / math.max(rider[2], 1)
        best = math.max(best, math.clamp(1 - eta / Config.ContestHorizon, 0, 1))
    end
    return best
end

---@return number, string, number  score, delivery mode, contest
function xDTaraZ.Planner.Score(entry, riders)
    local mode = xDTaraZ.Delivery.Mode(entry)
    local contest = xDTaraZ.Planner.Contest(entry, riders)
    local cost = Config.TripCost[mode] or Config.TripCost.Drop
    local score = (entry.value or 0) * (1 + contest * State.Tune.ContestWeight) / cost
    return score, mode, contest
end

function xDTaraZ.Planner.Rebuild()
    local planner = xDTaraZ.Planner
    local riders = planner.Riders()
    local ranked = planner.Ranked
    table.clear(ranked)

    for _, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if not entry.pos or not entry.egg then continue end
        if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then continue end
        local score, mode, contest = planner.Score(entry, riders)
        table.insert(ranked, { entry, mode, contest, score })
    end
    table.sort(ranked, function(a, b) return a[4] > b[4] end)

    planner.Dirty, planner.BuiltAt = false, os.clock()
    planner.Epoch = xDTaraZ.EggIndex.ValueEpoch
    planner.MountName = xDTaraZ.Mount.Name
end

---@return boolean  ranking is stale
function xDTaraZ.Planner.Stale()
    local planner = xDTaraZ.Planner
    local age = os.clock() - planner.BuiltAt
    if planner.Epoch ~= xDTaraZ.EggIndex.ValueEpoch or planner.MountName ~= xDTaraZ.Mount.Name then return true end
    if age > planner.MaxAge then return true end
    if not planner.Dirty then return false end

    local surging = os.clock() - xDTaraZ.EggIndex.RolledAt <= Config.WaveSurge
    return surging or age >= planner.RebuildGap
end

---@param minRank number?  hunter-only: rarity rank floor, user filters skipped
---@return table?, string?  entry, planned mode
function xDTaraZ.Planner.Next(minRank)
    local planner = xDTaraZ.Planner
    if planner.Stale() then planner.Rebuild() end

    for _, pick in ipairs(planner.Ranked) do
        local entry = pick[1]
        if minRank then
            local info = GameLib.EggInfo[entry.egg]
            if not info or (GameLib.RarityRank[info.rarity] or 0) < minRank then continue end
        end
        if xDTaraZ.EggIndex.Wanted(entry, minRank ~= nil) then
            planner.Contested[entry.guid] = pick[3]
            return entry, pick[2]
        end
    end
    return nil
end

function xDTaraZ.Planner.OnReply(kind, guid)
    local planner = xDTaraZ.Planner
    if kind ~= "Gone" or not guid then return end
    local contest = planner.Contested[guid]
    planner.Contested[guid] = nil
    if not contest or contest <= 0 then return end

    local tune = State.Tune
    local before = tune.ContestWeight
    tune.ContestWeight = math.min(Config.ContestWeightMax, before + planner.ContestStep)
    if tune.ContestWeight == before then return end

    State.TuneLog = State.TuneLog or {}
    table.insert(State.TuneLog, { "ContestWeight", before, tune.ContestWeight, os.time() })
end

function xDTaraZ.Planner.MarkDirty()
    xDTaraZ.Planner.Dirty = true
end

function xDTaraZ.Planner.Start()
    local planner = xDTaraZ.Planner
    if planner.Started then return end
    planner.Started = true

    local index = xDTaraZ.EggIndex
    index.OnAdded:Connect(xDTaraZ.Planner.MarkDirty)
    index.OnRemoved:Connect(xDTaraZ.Planner.MarkDirty)
    index.OnRoll:Connect(function()
        table.clear(planner.Contested)
        planner.Dirty = true
    end)
    index.OnReply:Connect(xDTaraZ.Planner.OnReply)
end

xDTaraZ.Eggs = {
    Enabled = false, Manual = false, Phase = "Idle", Note = nil,
    Token = nil, CarryCritical = false,
    MountRetryAt = 0, RecoverAt = 0,
    Prio = { Eggs = 60, Hunter = 70, Recover = 100 },
    RateWindow = 60,
}

xDTaraZ.Hunter = { Enabled = false, Hops = 0, HopCycle = nil, HopAt = 0, Seen = {}, Started = false }

xDTaraZ.Guard = {
    Baseline = nil, Tripped = false, Watching = false,
    Toggles = { "AutoEggs", "EggHunter", "VolcanoDip", "VolcanoObby" },
}

---@return number  eggs delivered in the last minute
function xDTaraZ.Eggs.PerMinute()
    local window = State.Stats.window
    local cutoff = os.clock() - xDTaraZ.Eggs.RateWindow
    while window[1] and window[1] < cutoff do
        table.remove(window, 1)
    end
    return #window
end

function xDTaraZ.Eggs.Status()
    local eggs = xDTaraZ.Eggs
    if not eggs.Enabled and not eggs.Manual and not xDTaraZ.Hunter.Enabled then return "Egg farm is off" end
    return eggs.Note or eggs.Phase or "Idle"
end

---@return boolean  always false, so callers can return it
function xDTaraZ.Eggs.SetPhase(phase, note)
    local eggs = xDTaraZ.Eggs
    eggs.Phase, eggs.Note = phase, note
    State.Status.Eggs = eggs.Status()
    if not eggs.Enabled and not eggs.Manual and not xDTaraZ.Hunter.Enabled then
        State.Status.EggRate, State.Status.WaveAt = nil, nil
        return false
    end
    State.Status.EggRate = eggs.PerMinute() .. "/min"
    State.Status.WaveAt = os.clock() + GameLib.CycleLeft()
    return false
end

---@return boolean  Plot and Travel tasks may use the character now
function xDTaraZ.Eggs.Waiting()
    local eggs = xDTaraZ.Eggs
    local active = eggs.Enabled or eggs.Manual or xDTaraZ.Hunter.Enabled
    return not active or eggs.Phase == "WaveWait"
end

function xDTaraZ.Eggs.ReleaseToken()
    local eggs = xDTaraZ.Eggs
    if not eggs.Token then return end
    xDTaraZ.Tasks.Release(eggs.Token)
    eggs.Token = nil
end

---@return boolean  we hold a token at this priority
function xDTaraZ.Eggs.Claim(prio)
    local eggs = xDTaraZ.Eggs
    local token = eggs.Token
    if token and token.prio == prio and xDTaraZ.Tasks.Holds(token) then return true end

    eggs.ReleaseToken()
    local owner = prio >= eggs.Prio.Hunter and "Hunter" or "Eggs"
    eggs.Token = xDTaraZ.Tasks.Request(owner, prio)
    return eggs.Token ~= nil
end

function xDTaraZ.Eggs.EnsureMount()
    local eggs, mount = xDTaraZ.Eggs, xDTaraZ.Mount
    if os.clock() < eggs.MountRetryAt then return end
    if xDTaraZ.Player:Riding() and not mount.Dirty and mount.Best() == mount.Name then return end

    eggs.SetPhase("Mount", "Mounting")
    local ok, mounted = xDTaraZ.Util.Try("Mount.Ensure", mount.Ensure, eggs.Token)
    if ok and mounted then
        mount.Dirty = false
        return
    end
    eggs.MountRetryAt = os.clock() + Config.FailWindow
end

---@return boolean  basket is empty afterwards
function xDTaraZ.Eggs.Recover()
    local eggs = xDTaraZ.Eggs
    if eggs.CarryCritical or os.clock() < eggs.RecoverAt then return false end
    eggs.RecoverAt = os.clock() + Config.SlowTick
    eggs.ReleaseToken()

    local token = xDTaraZ.Tasks.Request("Recover", eggs.Prio.Recover)
    if not token then return eggs.SetPhase("Recover", "Waiting to finish the egg") end

    eggs.SetPhase("Recover", "Finishing the egg")
    xDTaraZ.Util.Try("Delivery.Recover", xDTaraZ.Delivery.Recover, token)
    xDTaraZ.Tasks.Release(token)
    return xDTaraZ.Player:BasketCount() == 0
end

function xDTaraZ.Eggs.Park()
    if not xDTaraZ.Options.ReturnAfter then return end
    local _, bp = xDTaraZ.Player:Plot()
    local hrp = xDTaraZ.Player.Root
    if not bp or not hrp or xDTaraZ.Geo.InPlot(hrp.Position) then return end

    local token = xDTaraZ.Tasks.Request("Eggs", xDTaraZ.Eggs.Prio.Eggs)
    if not token then return end
    xDTaraZ.Tasks.Teleport(token, CFrame.new(xDTaraZ.Geo.EdgeInside(bp, hrp.Position)))
    xDTaraZ.Tasks.Release(token)
end

function xDTaraZ.Eggs.WaveWait()
    local eggs = xDTaraZ.Eggs
    if eggs.Phase ~= "WaveWait" then
        eggs.ReleaseToken()
        eggs.Park()
    end
    local left = GameLib.CycleLeft()
    return eggs.SetPhase("WaveWait", left <= Config.WaveWakeEarly and "New wave" or nil)
end

function xDTaraZ.Eggs.Record(entry, outcome)
    local stats = State.Stats
    if outcome == "Gone" then
        stats.lost += 1
        return
    end
    if outcome == "Refused" then
        xDTaraZ.EggIndex.Fail(entry.guid)
        return
    end
    if outcome ~= "Deposited" then return end

    stats.delivered += 1
    table.insert(stats.window, os.clock())

    local info = GameLib.EggInfo[entry.egg]
    if info and info.ethereal then xDTaraZ.EggIndex.MarkClaimed(entry.egg, entry.cycle) end
end

---@return boolean  the egg reached the plot
function xDTaraZ.Eggs.Trip(entry)
    local eggs = xDTaraZ.Eggs
    eggs.SetPhase("Run", entry.egg)
    local ok, outcome = xDTaraZ.Util.Try("Delivery.Run", xDTaraZ.Delivery.Run, eggs.Token, entry)
    eggs.CarryCritical = false
    if not ok then outcome = "Aborted" end

    eggs.Record(entry, outcome)
    xDTaraZ.Planner.Dirty = true
    eggs.SetPhase("Settle")
    task.wait(Config.EggTick)
    return outcome == "Deposited"
end

---@param minRank number?  hunter-only: rarity floor, user filters skipped
---@return boolean          an egg was delivered
function xDTaraZ.Eggs.Tick(minRank)
    local eggs = xDTaraZ.Eggs
    if eggs.Ticking then return end
    eggs.Ticking = true
    local ok, err = pcall(eggs.TickOnce, minRank)
    eggs.Ticking = false
    if not ok then error(err, 0) end
end

function xDTaraZ.Eggs.TickOnce(minRank)
    local eggs = xDTaraZ.Eggs
    xDTaraZ.EggIndex.CheckRoll()

    local _, bp = xDTaraZ.Player:Plot()
    if not bp then return eggs.SetPhase("Idle", "Waiting for plot") end
    if not xDTaraZ.Player:IsAlive() then return eggs.SetPhase("Idle", "Waiting for respawn") end
    if xDTaraZ.Player:BasketCount() > 0 then return eggs.Recover() end
    if eggs.Token and not xDTaraZ.Tasks.Holds(eggs.Token) then eggs.ReleaseToken() end
    if xDTaraZ.Volcano.Pending() then
        eggs.ReleaseToken()
        return eggs.SetPhase("Pick", "Volcano dip")
    end

    local entry = xDTaraZ.Planner.Next(minRank)
    if not entry then return eggs.WaveWait() end
    if not eggs.Claim(xDTaraZ.Hunter.Priority(entry)) then return eggs.SetPhase("Pick", "Waiting for a turn") end

    eggs.EnsureMount()
    return eggs.Trip(entry)
end

function xDTaraZ.Eggs.Step()
    if not xDTaraZ.Eggs.Enabled or xDTaraZ.Guard.Tripped then return end
    xDTaraZ.Eggs.Tick(nil)
end

---@return boolean  index is live
function xDTaraZ.Eggs.Prepare()
    xDTaraZ.Guard.Arm()
    xDTaraZ.Planner.Start()
    return xDTaraZ.EggIndex.Start()
end

---@param quiet boolean  pause the game's inventory bar while farming; the game rebuilds it once when it comes back
---@param force boolean? restore even while a farming toggle is on
function xDTaraZ.Eggs.QuietInventory(quiet, force)
    local eggs = xDTaraZ.Eggs
    if quiet then
        if eggs.InventoryPaused then return end
        eggs.InventoryPaused = true
        eggs.InventoryWas = LocalPlayer:GetAttribute("SatchelEnabled")
        LocalPlayer:SetAttribute("SatchelEnabled", false)
        return
    end
    if not eggs.InventoryPaused then return end
    if not force and (eggs.Enabled or xDTaraZ.Hunter.Enabled or xDTaraZ.Util.Opt("ClearJunk")) then return end
    eggs.InventoryPaused = false
    LocalPlayer:SetAttribute("SatchelEnabled", eggs.InventoryWas)
end

function xDTaraZ.Eggs.Start()
    local eggs = xDTaraZ.Eggs
    eggs.QuietInventory(true)
    if State.LastFail then State.Tune.DirectFactor = math.min(State.Tune.DirectFactor, Config.DirectFactorAfterFail) end
    eggs.Prepare()
    eggs.Enabled, eggs.MountRetryAt = true, 0
    eggs.SetPhase("Idle")
end

function xDTaraZ.Eggs.Stop()
    local eggs = xDTaraZ.Eggs
    eggs.Enabled = false
    if xDTaraZ.Hunter.Enabled then return end
    if eggs.InFlight() then
        task.spawn(xDTaraZ.Eggs.FinishCarry, Config.RunBudget * 2)
        return
    end
    eggs.ReleaseToken()
    eggs.SetPhase("Idle")
    task.spawn(xDTaraZ.Eggs.Settle)
end

---@async
---@return boolean  dismounted and the inventory bar is back
function xDTaraZ.Eggs.Settle()
    local eggs = xDTaraZ.Eggs
    eggs.SettlePending = true
    if not eggs.LetGo() then return false end
    eggs.SettlePending = false
    eggs.QuietInventory(false)
    return true
end

function xDTaraZ.Eggs.SettleStep()
    local eggs = xDTaraZ.Eggs
    if not eggs.SettlePending then return end
    if eggs.Enabled or eggs.Manual or xDTaraZ.Hunter.Enabled or xDTaraZ.Util.Opt("ClearJunk") then
        eggs.SettlePending = false
        return
    end
    eggs.Settle()
end

---@return boolean  a trip is running or an egg is carried
function xDTaraZ.Eggs.InFlight()
    local eggs = xDTaraZ.Eggs
    return eggs.Phase == "Run" or eggs.CarryCritical or xDTaraZ.Player:BasketCount() > 0
end

---@param timeout number  seconds to wait for a running delivery
---@return boolean        basket is empty
function xDTaraZ.Eggs.FinishCarry(timeout)
    local eggs = xDTaraZ.Eggs
    local deadline = os.clock() + (timeout or Config.RunBudget)
    while (eggs.CarryCritical or eggs.Phase == "Run") and os.clock() < deadline do
        task.wait(Config.EggTick)
    end

    if xDTaraZ.Player:BasketCount() > 0 then
        eggs.RecoverAt = 0
        eggs.Recover()
    end
    eggs.ReleaseToken()
    if not eggs.Enabled and not xDTaraZ.Hunter.Enabled then eggs.Settle() end
    return xDTaraZ.Player:BasketCount() == 0
end

---@async
---@return boolean  off the mount with empty hands; false while a task or a carried egg still needs the mount
function xDTaraZ.Eggs.LetGo()
    if xDTaraZ.Tasks.Owner() or xDTaraZ.Player:BasketCount() > 0 then return false end
    return xDTaraZ.Player:Release()
end

function xDTaraZ.Eggs.ExitNow()
    local eggs = xDTaraZ.Eggs
    eggs.Enabled = false
    table.insert(State.PendingToggleOff, "AutoEggs")
    eggs.FinishCarry(Config.RunBudget)
    eggs.SetPhase("Idle", "Stopped")
end

---@async
---@return integer  eggs delivered in this pass, yields until the pass ends
function xDTaraZ.Eggs.CollectNow()
    local eggs = xDTaraZ.Eggs
    if eggs.Enabled or eggs.Manual or xDTaraZ.Hunter.Enabled then return 0 end
    if not eggs.Prepare() then return 0 end

    eggs.Manual = true
    local before = State.Stats.delivered
    local limit = 0
    for _ in pairs(xDTaraZ.EggIndex.Entries) do limit += 1 end

    for _ = 1, limit do
        if xDTaraZ.Guard.Tripped or not State.Alive then break end
        eggs.Tick(nil)
        if eggs.Phase == "WaveWait" or eggs.Phase == "Idle" or eggs.Phase == "Pick" then break end
    end

    eggs.ReleaseToken()
    eggs.Manual = false
    eggs.Settle()
    local got = State.Stats.delivered - before
    table.insert(State.PendingNotify, { "Collect Eggs", "Delivered " .. got .. " eggs" })
    return got
end

---@return number  rarity rank the hunter cares about, huge when unset
function xDTaraZ.Hunter.MinRank()
    return GameLib.RarityRank[xDTaraZ.Options.HuntMinRarity] or math.huge
end

---@return number  task priority for this egg
function xDTaraZ.Hunter.Priority(entry)
    local prio = xDTaraZ.Eggs.Prio
    if not xDTaraZ.Hunter.Enabled then return prio.Eggs end
    local info = GameLib.EggInfo[entry.egg]
    local rank = info and GameLib.RarityRank[info.rarity] or 0
    return rank >= xDTaraZ.Hunter.MinRank() and prio.Hunter or prio.Eggs
end

function xDTaraZ.Hunter.Spotted(entry)
    local hunter = xDTaraZ.Hunter
    if not hunter.Enabled or not entry.egg or hunter.Seen[entry.guid] then return end
    if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then return end
    local info = GameLib.EggInfo[entry.egg]
    if not info or info.volcanic then return end
    if (GameLib.RarityRank[info.rarity] or 0) < hunter.MinRank() then return end

    hunter.Seen[entry.guid] = true
    table.insert(State.PendingNotify, { "Rare Egg", entry.egg .. " (" .. tostring(info.rarity) .. ") spawned" })
    local webhook = xDTaraZ.Webhook
    if webhook and webhook.EggSpawned and entry.inst then task.defer(webhook.EggSpawned, entry.inst) end
end

function xDTaraZ.Hunter.TryHop()
    local hunter = xDTaraZ.Hunter
    if not xDTaraZ.Options.HunterHop or os.clock() < hunter.HopAt then return end
    if GameLib.CycleLeft() <= Config.HunterMinLeft or xDTaraZ.Player:BasketCount() > 0 then return end

    local cycle = GameLib.CycleIndex()
    if hunter.HopCycle ~= cycle then hunter.HopCycle, hunter.Hops = cycle, 0 end
    if hunter.Hops >= Config.HunterHopsPerCycle then return end
    if xDTaraZ.Planner.Next(hunter.MinRank()) then return end

    hunter.Hops += 1
    hunter.HopAt = os.clock() + Config.LoadTimeout
    xDTaraZ.Util.Try("Server.Hop", xDTaraZ.Server.Hop)
end

function xDTaraZ.Hunter.Step()
    local hunter, eggs = xDTaraZ.Hunter, xDTaraZ.Eggs
    if not hunter.Enabled or eggs.Manual or xDTaraZ.Guard.Tripped then return end
    if not eggs.Enabled then eggs.Tick(hunter.MinRank()) end
    if eggs.Phase == "WaveWait" then hunter.TryHop() end
end

function xDTaraZ.Hunter.Start()
    local hunter = xDTaraZ.Hunter
    if State.LastFail then State.Tune.DirectFactor = math.min(State.Tune.DirectFactor, Config.DirectFactorAfterFail) end
    xDTaraZ.Eggs.Prepare()
    xDTaraZ.Eggs.QuietInventory(true)
    hunter.Enabled = true
    if hunter.Started then return end

    hunter.Started = true
    xDTaraZ.EggIndex.OnAdded:Connect(xDTaraZ.Hunter.Spotted)
    xDTaraZ.EggIndex.OnRoll:Connect(function() table.clear(hunter.Seen) end)
end

function xDTaraZ.Hunter.Stop()
    xDTaraZ.Hunter.Enabled = false
    if xDTaraZ.Eggs.Enabled then return end
    if xDTaraZ.Eggs.InFlight() then
        task.spawn(xDTaraZ.Eggs.FinishCarry, Config.RunBudget * 2)
        return
    end
    xDTaraZ.Eggs.ReleaseToken()
    xDTaraZ.Eggs.SetPhase("Idle")
    task.spawn(xDTaraZ.Eggs.Settle)
end

function xDTaraZ.Guard.Arm()
    local guard = xDTaraZ.Guard
    guard.Tripped = false
    guard.Baseline = xDTaraZ.Player:Flags()
    if guard.Watching then return end
    guard.Watching = true
    xDTaraZ:Connect(LocalPlayer:GetAttributeChangedSignal("TeleportFlags"), xDTaraZ.Guard.OnFlags)
end

function xDTaraZ.Guard.OnFlags()
    local guard = xDTaraZ.Guard
    local flags = xDTaraZ.Player:Flags()
    if guard.Baseline and flags > guard.Baseline then guard.Trip("flags") end
    guard.Baseline = flags
end

function xDTaraZ.Guard.Check(flags0)
    if xDTaraZ.Player:Flags() > (flags0 or 0) then xDTaraZ.Guard.Trip("flags") end
end

---@return table  State.LastFail
function xDTaraZ.Guard.Snapshot(why)
    local plan = type(xDTaraZ.Delivery.LastPlan) == "table" and xDTaraZ.Delivery.LastPlan or {}
    return {
        why = why, at = os.time(),
        mode = plan.mode, trip = plan.trip, speed = plan.speed, settle = plan.settle, timings = plan.timings,
        flagsBefore = xDTaraZ.Guard.Baseline, flagsAfter = xDTaraZ.Player:Flags(),
    }
end

---@return boolean  true when the farm keeps going on a slower delivery pace
function xDTaraZ.Guard.Soften()
    local guard = xDTaraZ.Guard
    local now = os.clock()
    guard.Recent = guard.Recent or {}
    while guard.Recent[1] and now - guard.Recent[1] > Config.ReturnWindow do
        table.remove(guard.Recent, 1)
    end
    guard.Recent[#guard.Recent + 1] = now
    if #guard.Recent >= Config.ReturnStopCount then return false end

    local pace = Config.ReturnBackoff[#guard.Recent] or Config.ReturnBackoff[#Config.ReturnBackoff]
    State.Tune.DirectFactor = math.min(State.Tune.DirectFactor, pace)
    table.insert(State.PendingNotify, { "Egg Farm", "An egg was returned. Delivering slower and carrying on." })
    return true
end

function xDTaraZ.Guard.Trip(why)
    local guard = xDTaraZ.Guard
    if guard.Tripped or os.clock() - (guard.LastTrip or -math.huge) < Config.ReturnDedupe then return end
    guard.LastTrip = os.clock()
    State.Stats.returned += 1

    State.LastFail = guard.Snapshot(why)
    local webhook = xDTaraZ.Webhook
    if webhook and webhook.DeliveryFailed then task.defer(webhook.DeliveryFailed, State.LastFail) end
    if guard.Soften() then return end

    guard.Tripped = true
    xDTaraZ.Eggs.Enabled = false
    xDTaraZ.Hunter.Enabled = false
    local volcano = xDTaraZ.Volcano
    if volcano and volcano.Stop then xDTaraZ.Util.Try("Volcano.Stop", volcano.Stop) end
    for _, idx in ipairs(guard.Toggles) do
        table.insert(State.PendingToggleOff, idx)
    end
    table.insert(State.PendingNotify, { "Egg Farm", "Eggs keep getting returned. Egg farming stopped, switch Delivery to Safe and turn it back on." })
end

xDTaraZ.Volcano = {
    Token = nil,
    Reply = nil,
    Bound = false,
    Skip = {},
    ObbyAfter = 0,
    Dipped = 0,
    Magma = 0,
}

local function Never() return false end

function xDTaraZ.Volcano.Options()
    return xDTaraZ.Options or {}
end

function xDTaraZ.Volcano.SetStatus(text)
    xDTaraZ.State.Status.Volcano = text
end

---@return boolean  false when the token died while waiting
function xDTaraZ.Volcano.Sleep(token, sec)
    local _, why = xDTaraZ.Tasks.Await(token, Never, sec)
    return why == "timeout"
end

local function IsOurs(owner)
    return owner == LocalPlayer or owner == LocalPlayer.UserId
end

function xDTaraZ.Volcano.Bind()
    if xDTaraZ.Volcano.Bound then return end
    xDTaraZ.Volcano.Bound = true

    local result = xDTaraZ.GameLib.Remote("VolcanoDipResult")
    if result then
        xDTaraZ:Connect(result.OnClientEvent, function(reply)
            if type(reply) ~= "table" or not IsOurs(reply.Owner) then return end
            xDTaraZ.Volcano.Reply = reply
        end)
    end

    local cancelled = xDTaraZ.GameLib.Remote("VolcanoDipCancelled")
    if cancelled then
        xDTaraZ:Connect(cancelled.OnClientEvent, function(reply)
            if type(reply) == "table" and not IsOurs(reply.Owner) then return end
            xDTaraZ.Volcano.Reply = { Cancelled = true }
        end)
    end
end

---@return boolean  VolcanoTop is streamed in, not just the empty Volcano shell
function xDTaraZ.Volcano.Stream(token)
    if xDTaraZ.Volcano.Part("VolcanoTop") then return true end
    local ok, err = pcall(LocalPlayer.RequestStreamAroundAsync, LocalPlayer, xDTaraZ.Config.VolcanoCenter, xDTaraZ.Config.VolcanoStreamTimeout)
    if not ok then warn("[RideAPet] volcano stream:", err) end
    return xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Volcano.Part("VolcanoTop") ~= nil end, xDTaraZ.Config.VolcanoStreamTimeout) == true
end

---@return BasePart?
function xDTaraZ.Volcano.Part(name)
    local volcano = workspace:FindFirstChild("Volcano")
    local part = volcano and volcano:FindFirstChild(name, true)
    if part and part:IsA("BasePart") then return part end

    for _, tagged in ipairs(game:GetService("CollectionService"):GetTagged(name)) do
        if tagged:IsA("BasePart") then return tagged end
    end
    return nil
end

---@return boolean  same footprint rule the game uses before it lets a dip fire
function xDTaraZ.Volcano.IsOver(top)
    local hrp = xDTaraZ.Player.Root
    local info = xDTaraZ.GameLib.Data.Volcano
    if not hrp or not top or not info then return false end

    local slack = tonumber(info.ServerRangeSlack) or 0
    local localPos = top.CFrame:PointToObjectSpace(hrp.Position)
    if localPos.Y < 0 then return false end
    return math.abs(localPos.X) <= top.Size.X / 2 + slack and math.abs(localPos.Z) <= top.Size.Z / 2 + slack
end

---@return boolean  ethereal, volcanic or already magma/eternal
local function SkipsDip(entry, info)
    if not info or info.ethereal or info.volcanic then return true end
    return entry.mutation == "Magma" or entry.mutation == "Eternal"
end

---@return boolean  egg run is idle or waiting, or the wave is down to its last free eggs
function xDTaraZ.Volcano.WaveTail()
    if xDTaraZ.Eggs.Waiting() then return true end
    local free = 0
    for _, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if xDTaraZ.EggIndex.Wanted(entry) and xDTaraZ.Planner.Contest(entry) == 0 then free += 1 end
        if free > xDTaraZ.Config.VolcanoTailEggs then return false end
    end
    return true
end

---@return table?  index entry worth a dip, best score first
function xDTaraZ.Volcano.PickDip()
    local rarities = xDTaraZ.Volcano.Options().DipRarities or {}
    local info = xDTaraZ.GameLib.Data.Volcano
    local minBreak = (info and tonumber(info.BonusSeconds) or math.huge) + xDTaraZ.Config.VolcanoMinBreakLeft
    local best, bestScore = nil, -math.huge

    for guid, entry in pairs(xDTaraZ.EggIndex.Entries) do
        local egg = xDTaraZ.GameLib.EggInfo[entry.egg]
        if SkipsDip(entry, egg) or (xDTaraZ.Volcano.Skip[guid] or 0) > os.clock() then continue end
        if next(rarities) and not rarities[egg.rarity] then continue end
        if (egg.breakSec or 0) <= minBreak or not xDTaraZ.EggIndex.Wanted(entry) then continue end
        if xDTaraZ.Delivery.Mode(entry) == "Plot" then continue end

        local score = xDTaraZ.Planner.Score(entry)
        if score > bestScore then best, bestScore = entry, score end
    end
    return best
end

---@return Instance?  carried egg that can still be dipped
function xDTaraZ.Volcano.Carried()
    local now = xDTaraZ.Util.ServerNow()
    local minBreak = (tonumber(xDTaraZ.GameLib.Data.Volcano.BonusSeconds) or math.huge) + xDTaraZ.Config.VolcanoMinBreakLeft
    for _, egg in ipairs(xDTaraZ.Player:BasketItems()) do
        if egg:GetAttribute("VolcanoDipped") or egg:GetAttribute("Delivering") then continue end
        if (tonumber(egg:GetAttribute("VolcanoUntil")) or 0) > now then continue end
        local breakAt = tonumber(egg:GetAttribute("BreakAt"))
        if breakAt and breakAt - now > minBreak then return egg end
    end
    return nil
end

---@return table?  dip reply, re-fired while the server position still lags the teleport
function xDTaraZ.Volcano.FireUntilReply(token, remote)
    xDTaraZ.Volcano.Reply = nil
    local deadline = os.clock() + xDTaraZ.Config.VolcanoResultTimeout
    repeat
        remote:FireServer()
        if xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Volcano.Reply ~= nil end, xDTaraZ.Config.VolcanoRefire) then
            return xDTaraZ.Volcano.Reply
        end
        if not xDTaraZ.Tasks.Holds(token) then return nil end
    until os.clock() >= deadline
    return nil
end

---@return boolean  the dip reply came back and the egg is home in the basket again
function xDTaraZ.Volcano.Dip(token)
    local remote = xDTaraZ.GameLib.Remote("VolcanoDip")
    local info = xDTaraZ.GameLib.Data.Volcano
    if not remote or not info or not xDTaraZ.Volcano.Carried() then return false end
    if not xDTaraZ.Volcano.Stream(token) then return false end

    local top = xDTaraZ.Volcano.Part("VolcanoTop")
    if not top then return false end
    xDTaraZ.Tasks.Teleport(token, CFrame.new(top.Position + Vector3.yAxis * (tonumber(info.HoverHeight) or 0)))
    if not xDTaraZ.Volcano.Sleep(token, xDTaraZ.Config.VolcanoDipSettle) then return false end
    if not xDTaraZ.Volcano.IsOver(top) then return false end

    xDTaraZ.Volcano.SetStatus("Dipping egg")
    local reply = xDTaraZ.Volcano.FireUntilReply(token, remote)
    if not reply or reply.Cancelled then return false end

    local landAt = tonumber(reply.ArriveAt) or 0
    xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Util.ServerNow() >= landAt end, xDTaraZ.Config.VolcanoResultTimeout)
    xDTaraZ.Volcano.Dipped += 1
    if reply.Success then xDTaraZ.Volcano.Magma += 1 end
    return true
end

---@return string  short outcome for the status line
function xDTaraZ.Volcano.DipRun(token, entry)
    local _, bp = xDTaraZ.Player:Plot()
    if not bp then return "no plot" end

    local ok, why = xDTaraZ.Delivery.Pickup(token, entry.guid, xDTaraZ.Geo.StandPoint(bp, entry.pos))
    if not ok then
        xDTaraZ.Volcano.Skip[entry.guid] = os.clock() + xDTaraZ.Config.GoneBlacklistSec
        return "pickup " .. tostring(why)
    end

    xDTaraZ.Eggs.CarryCritical = true
    local dipped = xDTaraZ.Volcano.Dip(token)
    xDTaraZ.Delivery.Recover(token)
    xDTaraZ.Eggs.CarryCritical = false
    return dipped and "dipped" or "dip skipped"
end

---@param canTouch boolean  executor touch works
function xDTaraZ.Volcano.Hold(token, part, canTouch)
    local hrp = xDTaraZ.Player.Root
    if not hrp or not part.Parent then return end
    hrp.AssemblyLinearVelocity = Vector3.zero
    if (hrp.Position - part.Position).Magnitude > part.Size.Magnitude / 2 then xDTaraZ.Tasks.Teleport(token, part.CFrame) end
    if not canTouch or os.clock() < (xDTaraZ.Volcano.TouchAt or 0) then return end
    xDTaraZ.Volcano.TouchAt = os.clock() + xDTaraZ.Config.VolcanoTouchEvery
    firetouchinterest(hrp, part, 0)
    task.defer(firetouchinterest, hrp, part, 1)
end

function xDTaraZ.Volcano.Climb(token)
    if xDTaraZ.Volcano.Done() then return true end
    if not xDTaraZ.Volcano.Stream(token) then return false end
    local canTouch = Library and Library.Compat and Library.Compat.Caps.Touch == true

    for _, step in ipairs({ { "VolcanoEntrance" }, { "VolcanoValidate", "InVolcano" }, { "VolcanoTop", "VolcanoValidated" } }) do
        local part = xDTaraZ.Volcano.Part(step[1])
        if not part or not xDTaraZ.Tasks.Teleport(token, part.CFrame) then return false end
        if not xDTaraZ.Volcano.Sleep(token, xDTaraZ.Config.VolcanoSettle) then return false end

        xDTaraZ.Volcano.Hold(token, part, canTouch)
        local attr = step[2]
        if attr and not xDTaraZ.Tasks.Await(token, function()
            if LocalPlayer:GetAttribute(attr) == true then return true end
            xDTaraZ.Volcano.Hold(token, part, canTouch)
            return false
        end, xDTaraZ.Config.VolcanoStepWait) then
            return false
        end
    end
    return xDTaraZ.Volcano.Done()
end

function xDTaraZ.Volcano.Done()
    return LocalPlayer:GetAttribute("VolcanoValidated") == true
end

---@return table?  Volcanic egg in the index we may pick up
function xDTaraZ.Volcano.VolcanicEgg()
    for guid, entry in pairs(xDTaraZ.EggIndex.Entries) do
        local info = xDTaraZ.GameLib.EggInfo[entry.egg]
        if not info or not info.volcanic then continue end
        if entry.privateTo and not IsOurs(entry.privateTo) then continue end
        if (xDTaraZ.Volcano.Skip[guid] or 0) > os.clock() then continue end
        return entry
    end
    return nil
end

---@return string
function xDTaraZ.Volcano.ObbyRun(token, entry)
    if not xDTaraZ.Volcano.Climb(token) then
        xDTaraZ.Volcano.ObbyAfter = os.clock() + xDTaraZ.Config.VolcanoRetry
        return "climb failed"
    end

    local stand = entry.pos + Vector3.yAxis * xDTaraZ.Config.VolcanoStandLift
    local ok, why = xDTaraZ.Delivery.Pickup(token, entry.guid, stand)
    if not ok then
        xDTaraZ.Volcano.Skip[entry.guid] = os.clock() + xDTaraZ.Config.GoneBlacklistSec
        return "pickup " .. tostring(why)
    end

    xDTaraZ.Eggs.CarryCritical = true
    xDTaraZ.Delivery.Recover(token)
    xDTaraZ.Eggs.CarryCritical = false
    return "volcanic egg run done"
end

---@return table?, function?  target and runner for this tick
function xDTaraZ.Volcano.Plan()
    local opts = xDTaraZ.Volcano.Options()
    if opts.VolcanoObby and os.clock() >= xDTaraZ.Volcano.ObbyAfter then
        local egg = xDTaraZ.Volcano.VolcanicEgg()
        if egg then return egg, xDTaraZ.Volcano.ObbyRun end
    end
    if opts.VolcanoDip and xDTaraZ.GameLib.Data.Volcano and xDTaraZ.Volcano.WaveTail() then
        local egg = xDTaraZ.Volcano.PickDip()
        if egg then return egg, xDTaraZ.Volcano.DipRun end
    end
    return nil
end

---@return boolean  the egg run must leave the character to the volcano for now
function xDTaraZ.Volcano.Pending()
    local hold = xDTaraZ.Volcano.Claimed
    if not hold then return false end
    if os.clock() < hold[2] and xDTaraZ.EggIndex.Entries[hold[1]] then return true end
    xDTaraZ.Volcano.Claimed = nil
    return false
end

---@return boolean  an egg nobody delivers is still in the basket
local function Orphaned()
    local eggs = xDTaraZ.Eggs
    if xDTaraZ.Player:BasketCount() == 0 or eggs.CarryCritical then return false end
    return not (eggs.Enabled or eggs.Manual or xDTaraZ.Hunter.Enabled)
end

function xDTaraZ.Volcano.Step()
    if not xDTaraZ.State.Alive or not xDTaraZ.Player:IsAlive() or xDTaraZ.Guard.Tripped then return end
    if Orphaned() then
        xDTaraZ.Volcano.SetStatus("Finishing the egg")
        xDTaraZ.Eggs.Recover()
        return
    end
    xDTaraZ.Volcano.Bind()

    local entry, runner = xDTaraZ.Volcano.Plan()
    if not entry then
        xDTaraZ.Volcano.Claimed = nil
        xDTaraZ.Volcano.SetStatus("Waiting")
        return
    end

    xDTaraZ.Volcano.Claimed = { entry.guid, os.clock() + xDTaraZ.Config.VolcanoClaimSec }
    if xDTaraZ.Player:BasketCount() > 0 then return end
    local token = xDTaraZ.Tasks.Request("Volcano", xDTaraZ.Tasks.Prio.Volcano)
    if not token then return end
    xDTaraZ.Volcano.Claimed = nil
    xDTaraZ.Volcano.Token = token

    local flags0 = xDTaraZ.Player:Flags()
    local ok, outcome = xDTaraZ.Util.Try("volcano", runner, token, entry)
    xDTaraZ.Guard.Check(flags0)

    xDTaraZ.Volcano.Token = nil
    xDTaraZ.Tasks.Release(token)
    xDTaraZ.Volcano.SetStatus(ok and outcome or "error")
end

function xDTaraZ.Volcano.Start()
    xDTaraZ.Eggs.Prepare()
    xDTaraZ.Volcano.Bind()
    xDTaraZ.Volcano.ObbyAfter = 0
end

function xDTaraZ.Volcano.Stop()
    xDTaraZ.Volcano.Claimed = nil
    local token = xDTaraZ.Volcano.Token
    if token and xDTaraZ.Player:BasketCount() == 0 then
        xDTaraZ.Volcano.Token = nil
        xDTaraZ.Tasks.Release(token)
    end
end

function xDTaraZ.Volcano.Status()
    return xDTaraZ.State.Status.Volcano or "Off"
end

xDTaraZ.Hatch = {
    Bound = false,
    Pending = {},
    LastPlaced = 0,
    LastRequest = 0,
    CapHit = false,
    Hatched = 0,
    Planted = 0,
    GrowCache = {},
    Signal = xDTaraZ.Signal.new(),
}

local function IsOurs(owner)
    return owner == nil or owner == LocalPlayer or owner == LocalPlayer.UserId
end

function xDTaraZ.Hatch.Options()
    return xDTaraZ.Options or {}
end

function xDTaraZ.Hatch.SetStatus(text)
    xDTaraZ.State.Status.Hatch = text
end

function xDTaraZ.Hatch.Store(placement)
    if type(placement) ~= "table" or type(placement.EggKey) ~= "string" then return end
    xDTaraZ.State.PlotEggs[placement.EggKey] = {
        key = placement.EggKey,
        egg = placement.EggName,
        placeTime = tonumber(placement.PlaceTime),
        weight = tonumber(placement.Weight) or 1,
        pos = typeof(placement.UpCFrame) == "CFrame" and placement.UpCFrame.Position or placement.Coordinate,
    }
    xDTaraZ.Hatch.LastPlaced = os.clock()
end

---@param msg table  EggPlaced reply, snapshot or one placement
function xDTaraZ.Hatch.OnPlaced(msg)
    if type(msg) ~= "table" or not IsOurs(msg.Owner) then return end
    if not msg.Snapshot then
        xDTaraZ.Hatch.Store(msg)
        return
    end

    table.clear(xDTaraZ.State.PlotEggs)
    for _, placement in pairs(type(msg.Placements) == "table" and msg.Placements or {}) do
        xDTaraZ.Hatch.Store(placement)
    end
end

function xDTaraZ.Hatch.OnHatched(msg)
    if type(msg) ~= "table" or not IsOurs(msg.Owner) or not msg.EggKey then return end
    xDTaraZ.State.PlotEggs[msg.EggKey] = nil
    xDTaraZ.Hatch.Pending[msg.EggKey] = nil
    xDTaraZ.Hatch.Hatched += 1
    xDTaraZ.Hatch.Signal:Fire(msg)
end

function xDTaraZ.Hatch.OnMessage(text)
    if type(text) ~= "string" then return end
    local used, cap = text:match("Max (%d+)/(%d+)")
    if not cap then return end
    xDTaraZ.State.PlantCap = math.max(tonumber(used), tonumber(cap))
    xDTaraZ.Hatch.CapHit = true
    xDTaraZ.Hatch.RequestSnapshot()
end

function xDTaraZ.Hatch.Bind()
    if xDTaraZ.Hatch.Bound then return end
    xDTaraZ.Hatch.Bound = true

    local placed = xDTaraZ.GameLib.Remote("EggPlaced")
    if placed then xDTaraZ:Connect(placed.OnClientEvent, xDTaraZ.Hatch.OnPlaced) end

    local hatch = xDTaraZ.GameLib.Remote("Hatch")
    if hatch then xDTaraZ:Connect(hatch.OnClientEvent, xDTaraZ.Hatch.OnHatched) end

    local message = xDTaraZ.GameLib.Remote("GameMessage")
    if message then xDTaraZ:Connect(message.OnClientEvent, xDTaraZ.Hatch.OnMessage) end

    xDTaraZ.Hatch.RequestSnapshot()
end

function xDTaraZ.Hatch.RequestSnapshot()
    local remote = xDTaraZ.GameLib.Remote("RequestPlotEggs")
    if not remote then return end
    xDTaraZ.Hatch.LastRequest = os.clock()
    remote:FireServer(true)
end

---@return boolean  a hatch luck event is running
function xDTaraZ.Hatch.BoostActive()
    local rs = game:GetService("ReplicatedStorage")
    local mult = tonumber(rs:GetAttribute("HatchLuckEventMultiplier")) or 1
    local untilAt = tonumber(rs:GetAttribute("HatchLuckEventUntil"))
    if untilAt and untilAt <= xDTaraZ.Util.ServerNow() then return false end
    return mult > 1
end

---@return number?  seconds of growth left, nil when unknown
function xDTaraZ.Hatch.Left(plotEgg)
    local info = xDTaraZ.GameLib.EggInfo[plotEgg.egg or ""]
    if not info or not plotEgg.placeTime then return nil end
    return xDTaraZ.GameLib.GrowthLeft(plotEgg.placeTime, info.growth, plotEgg.weight)
end

---@return number|nil  os.clock() moment the egg is grown, night growth included; nil when unknown
function xDTaraZ.Hatch.ReadyAt(plotEgg)
    if plotEgg.readyAt then return plotEgg.readyAt end
    local info = xDTaraZ.GameLib.EggInfo[plotEgg.egg or ""]
    if not info or not plotEgg.placeTime then return nil end

    local left = xDTaraZ.GameLib.GrowthRealLeft(plotEgg.placeTime, info.growth, plotEgg.weight)
    if not left then return nil end
    plotEgg.readyAt = os.clock() + left
    return plotEgg.readyAt
end

---@return integer  hatch fires sent this pass
function xDTaraZ.Hatch.HatchNow()
    local remote = xDTaraZ.GameLib.Remote("Hatch")
    if not remote then return 0 end
    xDTaraZ.Hatch.Bind()

    local fired, now = 0, os.clock()
    for key, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        if (xDTaraZ.Hatch.Pending[key] or 0) > now then continue end
        local left = xDTaraZ.Hatch.Left(plotEgg)
        if not left or left > 0 then continue end

        if fired > 0 then task.wait(xDTaraZ.Config.HatchGap) end
        xDTaraZ.Hatch.Pending[key] = os.clock() + xDTaraZ.Config.HatchPending
        remote:FireServer({ EggKey = key })
        fired += 1
    end
    return fired
end

function xDTaraZ.Hatch.Step()
    local opts = xDTaraZ.Hatch.Options()
    if not opts.AutoHatch then return end
    xDTaraZ.Hatch.Bind()

    if os.clock() - xDTaraZ.Hatch.LastRequest > xDTaraZ.Config.PlotEggsRefresh then
        xDTaraZ.Hatch.RequestSnapshot()
    end
    if opts.HoldHatchBoost and not xDTaraZ.Hatch.BoostActive() then
        xDTaraZ.Hatch.SetStatus("Holding for luck boost")
        return
    end

    local fired = xDTaraZ.Hatch.HatchNow()
    if fired > 0 then xDTaraZ.Hatch.SetStatus("Hatching " .. fired) end
end

---@return string?  egg name the tool plants
function xDTaraZ.Hatch.ToolEgg(tool)
    local name = tool:GetAttribute("Egg") or tool.Name:match("^(.-Egg)")
    return xDTaraZ.GameLib.EggInfo[name or ""] and name or nil
end

---@return { {Tool, string, number, string?} }  egg tools with name, weight and mutation
function xDTaraZ.Hatch.EggTools()
    local tools = {}
    for _, holder in ipairs({ LocalPlayer:FindFirstChild("Backpack"), xDTaraZ.Player.Char }) do
        if not holder then continue end
        for _, tool in ipairs(holder:GetChildren()) do
            if not tool:IsA("Tool") or not tool:GetAttribute("EggInventoryId") then continue end
            local name = xDTaraZ.Hatch.ToolEgg(tool)
            if not name then continue end
            table.insert(tools, { tool, name, tonumber(tool:GetAttribute("Weight")) or 1, tool:GetAttribute("Mutation") })
        end
    end
    return tools
end

---@return number  higher plants first
function xDTaraZ.Hatch.Rank(name, weight, order, mutation)
    local info = xDTaraZ.GameLib.EggInfo[name]
    local growth = math.max(info.growth or 1, 1)
    if order == "Fastest growth" then return -growth end
    local value = xDTaraZ.EggIndex.Value({ egg = name, weight = weight, mutation = mutation })
    if order == "Value per hour" then return value / growth end
    return value
end

---@return { {Tool, string, number} }  tools to plant in order, PlantKeep per egg name held back
function xDTaraZ.Hatch.Queue()
    local opts = xDTaraZ.Hatch.Options()
    local order = opts.PlantOrder or "Best value"
    local tools = xDTaraZ.Hatch.EggTools()
    for _, entry in ipairs(tools) do
        entry[5] = xDTaraZ.Hatch.Rank(entry[2], entry[3], order, entry[4])
    end
    local function Better(a, b) return a[5] > b[5] end
    table.sort(tools, Better)

    local keep = tonumber(opts.PlantKeep) or 0
    if keep <= 0 then return tools end
    local seen, queue = {}, {}
    for i = #tools, 1, -1 do
        local name = tools[i][2]
        seen[name] = (seen[name] or 0) + 1
        if seen[name] > keep then queue[#queue + 1] = tools[i] end
    end
    table.sort(queue, Better)
    return queue
end

function xDTaraZ.Hatch.Count()
    local count = 0
    for _ in pairs(xDTaraZ.State.PlotEggs) do count += 1 end
    return count
end

function xDTaraZ.Hatch.Room()
    return math.max(0, (xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault) - xDTaraZ.Hatch.Count())
end

---@return integer  plot slots Auto Place Eggs owns while Clear Junk shares the plot
function xDTaraZ.Hatch.ValueCap()
    local cap = xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault
    return math.floor(cap * (1 - xDTaraZ.Config.JunkPlotShare))
end

---@return integer  slots the value planter may fill, Clear Junk keeps its share free
function xDTaraZ.Hatch.ValueRoom()
    local room = xDTaraZ.Hatch.Room()
    if not xDTaraZ.Util.Opt("ClearJunk") then return room end
    local held = xDTaraZ.Hatch.Count() - xDTaraZ.Junk.PlotJunk()
    return math.max(0, math.min(room, xDTaraZ.Hatch.ValueCap() - held))
end

---@return integer  slots Clear Junk may fill, the value share stays free while Auto Place Eggs runs
function xDTaraZ.Hatch.JunkRoom()
    local room = xDTaraZ.Hatch.Room()
    if not xDTaraZ.Util.Opt("AutoPlaceEggs") then return room end
    local held = xDTaraZ.Hatch.Count() - xDTaraZ.Junk.PlotJunk()
    return math.max(0, room - math.max(0, xDTaraZ.Hatch.ValueCap() - held))
end

---@return Vector3[]  free grid points on the baseplate top, PlantSpacing apart from planted eggs
function xDTaraZ.Hatch.Spots(bp, count)
    local spacing = xDTaraZ.Config.PlantSpacing
    local taken = {}
    for _, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        if typeof(plotEgg.pos) == "Vector3" then taken[#taken + 1] = plotEgg.pos end
    end

    local top = bp.Size.Y / 2
    local halfX = bp.Size.X / 2 - xDTaraZ.Config.EdgeInset - spacing / 2
    local halfZ = bp.Size.Z / 2 - xDTaraZ.Config.EdgeInset - spacing / 2
    local spots = {}
    for x = -halfX, halfX, spacing do
        for z = -halfZ, halfZ, spacing do
            local pos = (bp.CFrame * CFrame.new(x, top, z)).Position
            local clear = true
            for _, other in ipairs(taken) do
                if xDTaraZ.Util.Flat(other, pos) < spacing then
                    clear = false
                    break
                end
            end
            if not clear then continue end
            spots[#spots + 1] = pos
            taken[#taken + 1] = pos
            if #spots >= count then return spots end
        end
    end
    return spots
end

---@return { string }  nest ids that are unlocked and empty
function xDTaraZ.Hatch.FreeNests(plot)
    local nests = plot:FindFirstChild("Nests")
    local free = {}
    for _, nest in ipairs(nests and nests:GetChildren() or {}) do
        if nest:GetAttribute("Unlocked") and not nest:GetAttribute("Occupied") then table.insert(free, nest.Name) end
    end
    return free
end

---@return boolean  the server answered with a new placement
function xDTaraZ.Hatch.PlantOne(token, tool, args)
    local hum = xDTaraZ.Player.Humanoid
    if not hum or tool.Parent == nil then return false end
    hum:EquipTool(tool)
    local _, why = xDTaraZ.Tasks.Await(token, function() return false end, xDTaraZ.Config.EquipSettle)
    if why ~= "timeout" then return false end

    local before = xDTaraZ.Hatch.LastPlaced
    xDTaraZ.Hatch.CapHit = false
    local replied = function() return xDTaraZ.Hatch.LastPlaced ~= before or xDTaraZ.Hatch.CapHit end
    for _ = 1, xDTaraZ.Config.PlantTries do
        if tool.Parent ~= hum.Parent then hum:EquipTool(tool) end
        xDTaraZ.GameLib.Remote("EggPlaced"):FireServer(args)
        local ok, why = xDTaraZ.Tasks.Await(token, replied, xDTaraZ.Config.PlantReplyTimeout)
        if ok then return not xDTaraZ.Hatch.CapHit end
        if why ~= "timeout" or tool.Parent == nil then return false end
    end
    return false
end

---@return boolean  takes longer than PlantLongGrow seconds to grow
function xDTaraZ.Hatch.IsLong(name, weight)
    local cache = xDTaraZ.Hatch.GrowCache
    local key = name .. "|" .. weight
    if cache[key] == nil then
        local info = xDTaraZ.GameLib.EggInfo[name]
        local total = info and (xDTaraZ.GameLib.GrowthSeconds(info.growth, weight) or info.growth) or 0
        cache[key] = total > xDTaraZ.Config.PlantLongGrow
    end
    return cache[key]
end

---@return integer  slow growers we may still plant so the rest of the plot keeps hatching
function xDTaraZ.Hatch.LongRoom()
    local cap = xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault
    local held = 0
    for _, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        local left = xDTaraZ.Hatch.Left(plotEgg)
        if left and left > xDTaraZ.Config.PlantLongGrow then held += 1 end
    end
    return math.max(0, math.floor(cap * xDTaraZ.Config.PlantLongShare) - held)
end

---@return { {Tool, string, number} }  Queue trimmed to room, slow growers capped by LongRoom
function xDTaraZ.Hatch.Pick(room)
    local longRoom = xDTaraZ.Hatch.LongRoom()
    local picked, spare = {}, {}
    for _, entry in ipairs(xDTaraZ.Hatch.Queue()) do
        if #picked >= room then break end
        if xDTaraZ.Hatch.IsLong(entry[2], entry[3]) then
            if longRoom <= 0 then
                spare[#spare + 1] = entry
                continue
            end
            longRoom -= 1
        end
        picked[#picked + 1] = entry
    end
    for _, entry in ipairs(spare) do
        if #picked >= room then break end
        picked[#picked + 1] = entry
    end
    return picked
end

---@return integer  eggs planted
function xDTaraZ.Hatch.Plant(token, plot, bp)
    local noNest = LocalPlayer:GetAttribute("NoNest") == true
    local room = xDTaraZ.Hatch.ValueRoom()
    local queue = xDTaraZ.Hatch.Pick(room)
    local slots = noNest and xDTaraZ.Hatch.Spots(bp, math.min(room, #queue)) or xDTaraZ.Hatch.FreeNests(plot)
    if #slots == 0 or #queue == 0 or room == 0 then return 0 end

    xDTaraZ.Tasks.Teleport(token, CFrame.new(bp.Position + Vector3.yAxis * (bp.Size.Y / 2 + xDTaraZ.Config.PlantStandLift)))
    local planted = 0
    for i, slot in ipairs(slots) do
        local entry = queue[i]
        if i > room or not entry or not xDTaraZ.Tasks.Holds(token) then break end
        xDTaraZ.Hatch.SetStatus("Placing " .. entry[2])
        local args = noNest and { PlantPosition = slot } or { NestId = slot }
        if not xDTaraZ.Hatch.PlantOne(token, entry[1], args) then break end
        planted += 1
    end

    return planted
end

---@return boolean  planting may take the character now
function xDTaraZ.Hatch.CanPlant()
    if xDTaraZ.Player:BasketCount() > 0 or not xDTaraZ.Player:IsAlive() then return false end
    if not xDTaraZ.GameLib.Remote("EggPlaced") or xDTaraZ.Junk.Running then return false end
    return not xDTaraZ.Hatch.Options().AutoEggs or xDTaraZ.Eggs.Phase == "WaveWait"
end

---@return integer  eggs planted
function xDTaraZ.Hatch.PlaceNow()
    xDTaraZ.Hatch.Bind()
    if not xDTaraZ.Hatch.CanPlant() then return 0 end
    local plot, bp = xDTaraZ.Player:Plot()
    if not plot or not bp then return 0 end
    if xDTaraZ.Hatch.ValueRoom() == 0 then
        if os.clock() - xDTaraZ.Hatch.LastRequest > xDTaraZ.Config.PlotFullRecheck then xDTaraZ.Hatch.RequestSnapshot() end
        xDTaraZ.Hatch.SetStatus(string.format("Plot full (%d/%d)", xDTaraZ.Hatch.Count(), xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault))
        return 0
    end

    local token = xDTaraZ.Tasks.Request("Plant", 40)
    if not token then return 0 end
    local ok, planted = xDTaraZ.Util.Try("plant", xDTaraZ.Hatch.Plant, token, plot, bp)
    local hum = xDTaraZ.Player.Humanoid
    if hum and xDTaraZ.Player:BasketCount() == 0 then hum:UnequipTools() end
    xDTaraZ.Tasks.Release(token)

    planted = ok and planted or 0
    xDTaraZ.Hatch.Planted += planted
    xDTaraZ.Hatch.SetStatus(planted > 0 and ("Placed " .. planted .. " eggs") or (#xDTaraZ.Hatch.EggTools() == 0 and "No eggs to place" or string.format("Plot %d/%d", xDTaraZ.Hatch.Count(), xDTaraZ.State.PlantCap or xDTaraZ.Config.PlantCapDefault)))
    return planted
end

function xDTaraZ.Hatch.PlantStep()
    local opts = xDTaraZ.Hatch.Options()
    if not opts.AutoPlaceEggs then return end
    xDTaraZ.Hatch.PlaceNow()
end

function xDTaraZ.Hatch.Start()
    xDTaraZ.Hatch.Bind()
end

function xDTaraZ.Hatch.Stop()
    table.clear(xDTaraZ.Hatch.Pending)
end

function xDTaraZ.Hatch.Status()
    return xDTaraZ.State.Status.Hatch or "Idle"
end

xDTaraZ.Junk = {
    Bound = false,
    Running = false,
    Queue = {},
    Cursor = 1,
    BuiltAt = -math.huge,
    EmptyUntil = 0,
    Growth = {},
    Share = {},
    Held = nil,
    EquippedAt = 0,
    Spacing = xDTaraZ.Config.JunkSpacing,
    LastFire = -math.huge,
    Calm = 0,
    Slack = xDTaraZ.Config.JunkHatchSlack,
    HatchGap = 0,
    Retries = 0,
    Anchor = "seller",
    PlantFails = 0,
    FullUntil = 0,
    BackoffUntil = 0,
    YieldUntil = 0,
    ActiveAt = 0,
    ReportAt = 0,
    Fresh = 0,
    Selling = false,
    Planted = 0,
    Hatched = 0,
    Sold = 0,
    Window = {},
}

function xDTaraZ.Junk.SetStatus(text)
    xDTaraZ.State.Status.Junk = text
end

---@return integer  hatches in the last JunkRateWindow seconds
function xDTaraZ.Junk.PerMinute()
    local window = xDTaraZ.Junk.Window
    local cutoff = os.clock() - xDTaraZ.Config.JunkRateWindow
    while window[1] and window[1] < cutoff do
        table.remove(window, 1)
    end
    return #window
end

function xDTaraZ.Junk.Report(note)
    local junk = xDTaraZ.Junk
    junk.ReportAt = os.clock()
    local line = string.format("Hatched %d | Sold %d | %d/min", junk.Hatched, junk.Sold, junk.PerMinute())
    junk.SetStatus(note and (line .. " | " .. note) or line)
end

---@return table  { [rarity] = true } egg rarities to clear, Common and Rare when none are picked
function xDTaraZ.Junk.Set()
    local picked = xDTaraZ.Util.Opt("JunkRarities")
    if type(picked) == "table" and next(picked) then return picked end
    return { Common = true, Rare = true }
end

---@return number  seconds this egg takes to grow, huge when the game does not say
function xDTaraZ.Junk.GrowthOf(name, weight)
    local cache = xDTaraZ.Junk.Growth
    local key = name .. "|" .. string.format("%.2f", weight)
    local known = cache[key]
    if known then return known end

    local info = xDTaraZ.GameLib.EggInfo[name]
    known = info and xDTaraZ.GameLib.GrowthSeconds(info.growth, weight) or math.huge
    cache[key] = known
    return known
end

---@return integer  eggs queued, fastest growing first
function xDTaraZ.Junk.Build()
    local junk = xDTaraZ.Junk
    local set, queue = junk.Set(), {}
    for _, entry in ipairs(xDTaraZ.Hatch.EggTools()) do
        local info = xDTaraZ.GameLib.EggInfo[entry[2]]
        if info and set[info.rarity] then
            queue[#queue + 1] = { entry[1], entry[2], entry[3], junk.GrowthOf(entry[2], entry[3]), info.luck }
        end
    end
    table.sort(queue, function(a, b)
        if a[4] ~= b[4] then return a[4] < b[4] end
        return a[5] < b[5]
    end)

    junk.Queue, junk.Cursor, junk.BuiltAt = queue, 1, os.clock()
    junk.EmptyUntil = #queue == 0 and os.clock() + xDTaraZ.Config.JunkIdleCheck or 0
    if #queue > 0 then junk.Share = junk.Measure(queue) end
    return #queue
end

---@return Tool|nil  next egg tool still in the bag
function xDTaraZ.Junk.NextTool()
    local junk = xDTaraZ.Junk
    local stale = os.clock() - junk.BuiltAt > xDTaraZ.Config.JunkQueueTtl
    if junk.Cursor > #junk.Queue or stale then
        if os.clock() < junk.EmptyUntil then return nil end
        junk.Build()
    end

    while junk.Cursor <= #junk.Queue do
        local tool = junk.Queue[junk.Cursor][1]
        junk.Cursor += 1
        if tool.Parent ~= nil and tool ~= junk.Held then return tool end
    end
    return nil
end

---@return table<string, number>  share of hatches per pet rarity from the eggs at the head of the queue
function xDTaraZ.Junk.Measure(queue)
    local counts, total = {}, math.min(#queue, xDTaraZ.Config.JunkShareSample)
    for index = 1, total do
        local name = queue[index][2]
        counts[name] = (counts[name] or 0) + 1
    end

    local mult, share = xDTaraZ.EggIndex.LuckMult(), {}
    for name, count in pairs(counts) do
        for _, pair in ipairs(xDTaraZ.GameLib.Odds(name, mult) or {}) do
            local pet = xDTaraZ.GameLib.PetInfo[pair[1]]
            if pet then share[pet.rarity] = (share[pet.rarity] or 0) + pair[2] * count / total end
        end
    end
    return share
end

---@return table<string, number>  last measured share per pet rarity, built on first use
function xDTaraZ.Junk.Distribution()
    local junk = xDTaraZ.Junk
    if junk.BuiltAt == -math.huge then junk.Build() end
    return junk.Share
end

---@return table  { [rarity] = true } pet rarities Clear Junk Eggs sells
function xDTaraZ.Junk.SellSet()
    local picked = xDTaraZ.Util.Opt("JunkSellPets")
    if type(picked) == "table" and next(picked) then return picked end

    local rank, ceiling = xDTaraZ.GameLib.RarityRank, 0
    for rarity, share in pairs(xDTaraZ.Junk.Distribution()) do
        if share >= xDTaraZ.Config.JunkAutoShare then ceiling = math.max(ceiling, rank[rarity] or 0) end
    end
    if ceiling == 0 then return xDTaraZ.Junk.Set() end

    local set = {}
    for _, rarity in ipairs(xDTaraZ.GameLib.RarityOrder) do
        if (rank[rarity] or math.huge) <= ceiling then set[rarity] = true end
    end
    return set
end

function xDTaraZ.Junk.WarnMismatch()
    local picked = xDTaraZ.Util.Opt("JunkSellPets")
    if type(picked) ~= "table" or not next(picked) then return end

    local share = xDTaraZ.Junk.Distribution()
    if not next(share) then return end
    for rarity, chance in pairs(share) do
        if picked[rarity] and chance >= 0.01 then return end
    end
    xDTaraZ.Util.Notify("Clear Junk Eggs", "Your junk eggs do not give the pet rarities you picked to sell", 8)
end

---@return integer  junk eggs growing on the plot
function xDTaraZ.Junk.PlotJunk()
    local set, count = xDTaraZ.Junk.Set(), 0
    for _, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        local info = xDTaraZ.GameLib.EggInfo[plotEgg.egg or ""]
        if info and set[info.rarity] then count += 1 end
    end
    return count
end

---@return boolean  a junk hatch was sent and its answer has not come back
function xDTaraZ.Junk.HatchInFlight()
    local now = os.clock()
    for key in pairs(xDTaraZ.State.PlotEggs) do
        if (xDTaraZ.Hatch.Pending[key] or 0) > now then return true end
    end
    return false
end

---@return boolean  there is something to plant, hatch or sell
function xDTaraZ.Junk.HasWork()
    local junk = xDTaraZ.Junk
    if junk.PlotJunk() > 0 or junk.Fresh >= xDTaraZ.Config.JunkSellEvery then return true end
    if xDTaraZ.Hatch.JunkRoom() == 0 then return false end
    if junk.Cursor <= #junk.Queue then return true end
    if os.clock() < junk.EmptyUntil then return false end
    return junk.Build() > 0
end

---@return boolean  value eggs may hatch now, unless the player holds them for a luck boost
local function ValueHatchOpen()
    if not xDTaraZ.Util.Opt("HoldHatchBoost") then return true end
    return xDTaraZ.Hatch.BoostActive()
end

---@return boolean  growth has finished on a junk egg, or on any egg while value hatching is open
function xDTaraZ.Junk.Due(key, plotEgg, set, now)
    local junk = xDTaraZ.Junk
    local info = xDTaraZ.GameLib.EggInfo[plotEgg.egg or ""]
    if not info then return false end
    if not set[info.rarity] and not ValueHatchOpen() then return false end
    if (xDTaraZ.Hatch.Pending[key] or 0) > now then return false end

    local readyAt = xDTaraZ.Hatch.ReadyAt(plotEgg)
    return readyAt ~= nil and now >= readyAt + junk.Slack
end

function xDTaraZ.Junk.Fire(remote, key, now)
    local junk, plotEgg = xDTaraZ.Junk, xDTaraZ.State.PlotEggs[key]
    if not plotEgg then return end

    if plotEgg.fired then
        junk.Retries += 1
        junk.Slack = math.min(junk.Slack + 0.01, xDTaraZ.Config.JunkHatchSlackMax)
        junk.HatchGap = math.min(junk.HatchGap * 2 + xDTaraZ.Config.JunkHatchGapStep, xDTaraZ.Config.JunkHatchGapMax)
    end
    plotEgg.fired = true
    xDTaraZ.Hatch.Pending[key] = now + xDTaraZ.Config.JunkHatchRetry
    remote:FireServer({ EggKey = key })
end

---@return integer  hatch fires sent
function xDTaraZ.Junk.HatchReady()
    local junk, remote = xDTaraZ.Junk, xDTaraZ.GameLib.Remote("Hatch")
    if not remote then return 0 end

    local set, now, keys = junk.Set(), os.clock(), {}
    for key, plotEgg in pairs(xDTaraZ.State.PlotEggs) do
        if junk.Due(key, plotEgg, set, now) then keys[#keys + 1] = key end
    end
    for index, key in ipairs(keys) do
        if index > 1 and junk.HatchGap > 0 then task.wait(junk.HatchGap) end
        junk.Fire(remote, key, os.clock())
    end
    return #keys
end

function xDTaraZ.Junk.OnHatched()
    local junk = xDTaraZ.Junk
    junk.Hatched += 1
    junk.Fresh += 1
    table.insert(junk.Window, os.clock())
end

---@return Tool|nil  egg tool now in hand
function xDTaraZ.Junk.Prime()
    local junk, hum = xDTaraZ.Junk, xDTaraZ.Player.Humanoid
    local tool = junk.NextTool()
    if not tool or not hum then return nil end

    hum:EquipTool(tool)
    junk.Held, junk.EquippedAt = tool, os.clock()
    return tool
end

---@return boolean  the egg is the only tool in hand
function xDTaraZ.Junk.HandHolds(tool)
    local char = xDTaraZ.Player.Char
    if not char or tool.Parent ~= char then return false end
    for _, child in ipairs(char:GetChildren()) do
        if child ~= tool and child:IsA("Tool") then return false end
    end
    return true
end

---@return Tool|nil  egg tool in hand and settled; a pet that landed in the hand is swapped back out
function xDTaraZ.Junk.Ready(token)
    local junk, hum = xDTaraZ.Junk, xDTaraZ.Player.Humanoid
    local held = junk.Held
    if held and held.Parent == nil then
        held = nil
        junk.Held = nil
    end
    if held and hum and not junk.HandHolds(held) then
        hum:UnequipTools()
        hum:EquipTool(held)
        junk.EquippedAt = os.clock()
    end
    held = held or junk.Prime()
    if not held then return nil end

    local fireAt = math.max(junk.EquippedAt + xDTaraZ.Config.JunkEquipSettle, junk.LastFire + junk.Spacing)
    return junk.Pause(token, fireAt, held) and held or nil
end

---@return boolean  reached the moment with a clean hand, the token, and no hatch sent
function xDTaraZ.Junk.Pause(token, untilAt, held)
    local junk = xDTaraZ.Junk
    while os.clock() < untilAt do
        if junk.HatchReady() > 0 or not junk.HandHolds(held) then return false end
        if not junk.Frame(token) then return false end
    end
    return junk.HandHolds(held)
end

function xDTaraZ.Junk.Ease()
    local junk, cfg = xDTaraZ.Junk, xDTaraZ.Config
    junk.Calm += 1
    if junk.Calm < cfg.JunkSpacingEase then return end
    junk.Calm = 0
    junk.Spacing = math.max(cfg.JunkSpacingMin, junk.Spacing - cfg.JunkSpacingDown)
end

function xDTaraZ.Junk.Harden()
    local junk, cfg = xDTaraZ.Junk, xDTaraZ.Config
    junk.Calm = 0
    junk.PlantFails += 1
    junk.Spacing = math.min(cfg.JunkSpacingMax, junk.Spacing + cfg.JunkSpacingUp)
end

function xDTaraZ.Junk.OnFull()
    local junk, hatch = xDTaraZ.Junk, xDTaraZ.Hatch
    junk.FullUntil = os.clock() + xDTaraZ.Config.JunkFullPause
    hatch.RequestSnapshot()
end

---@return boolean  the server placed the egg
function xDTaraZ.Junk.Settled(replied, before, tool)
    local junk, hatch = xDTaraZ.Junk, xDTaraZ.Hatch
    if replied and hatch.LastPlaced ~= before then
        junk.PlantFails = 0
        junk.Planted += 1
        junk.ActiveAt = os.clock()
        junk.Ease()
        junk.Held = nil
        junk.Prime()
        return true
    end
    if replied then
        junk.OnFull()
        return false
    end
    if tool.Parent == nil then
        hatch.RequestSnapshot()
    elseif not junk.HandHolds(tool) then
        junk.Held = tool
    else
        junk.Harden()
    end
    return false
end

---@return boolean  the server placed an egg
function xDTaraZ.Junk.PlantOne(token, bp)
    local junk, hatch = xDTaraZ.Junk, xDTaraZ.Hatch
    local tool, remote = junk.Ready(token), xDTaraZ.GameLib.Remote("EggPlaced")
    local spot = hatch.Spots(bp, 1)[1]
    if not tool or not remote or not spot then return false end
    if not junk.HandHolds(tool) then return false end

    local before = hatch.LastPlaced
    hatch.CapHit = false
    junk.LastFire = os.clock()
    remote:FireServer({ PlantPosition = spot })
    local replied = function() return hatch.LastPlaced ~= before or hatch.CapHit end
    local ok = xDTaraZ.Tasks.Await(token, replied, xDTaraZ.Config.JunkPlantTimeout)
    return junk.Settled(ok, before, tool)
end

---@return boolean  token still held after one frame
function xDTaraZ.Junk.Frame(token)
    local _, why = xDTaraZ.Tasks.Await(token, nil, 0)
    return why == "timeout"
end

---@return boolean  the run may go on
function xDTaraZ.Junk.Alive(token)
    if not xDTaraZ.Util.Opt("ClearJunk") then return false end
    if xDTaraZ.Tasks.Carrying() or not xDTaraZ.Player:IsAlive() then return false end
    return xDTaraZ.Tasks.Holds(token)
end

---@return integer  eggs planted this pass
function xDTaraZ.Junk.PlantFree(token, bp)
    local junk, planted = xDTaraZ.Junk, 0
    while xDTaraZ.Hatch.JunkRoom() > 0 and os.clock() >= junk.FullUntil and not junk.HatchInFlight() and junk.Alive(token) do
        if not junk.PlantOne(token, bp) then break end
        planted += 1
    end
    return planted
end

---@return boolean  standing at the anchor
function xDTaraZ.Junk.Goto(token, where)
    local junk, hrp = xDTaraZ.Junk, xDTaraZ.Player.Root
    local stand
    if where == "seller" then
        stand = xDTaraZ.Sell.Stand()
    else
        stand = xDTaraZ.Pets.PlotStand()
    end
    if not stand or not hrp then return false end
    if (hrp.Position - stand.Position).Magnitude <= xDTaraZ.Config.JunkAnchorNear then return true end
    if not xDTaraZ.Tasks.Teleport(token, stand) then return false end

    local _, why = xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.SellSettle)
    return why == "timeout"
end

---@return boolean  ready to plant
function xDTaraZ.Junk.Enter(token)
    local junk = xDTaraZ.Junk
    junk.Spacing = xDTaraZ.Config.JunkSpacing
    xDTaraZ.Eggs.QuietInventory(true)
    if xDTaraZ.Player:Riding() then
        xDTaraZ.Player:Release()
        xDTaraZ.Tasks.Await(token, function() return not xDTaraZ.Player:Riding() end, xDTaraZ.Config.MountTimeout)
    end
    if junk.Anchor == "seller" and not xDTaraZ.Sell.Stand() then junk.Anchor = "plot" end

    if not junk.Goto(token, junk.Anchor) then return false end
    junk.ActiveAt = os.clock()
    junk.WarnMismatch()
    return true
end

---@return integer  pets sold
function xDTaraZ.Junk.Sell(token)
    local junk = xDTaraZ.Junk
    junk.Selling, junk.Fresh = true, 0
    local ok, sold = pcall(xDTaraZ.Sell.Run, token, true)
    junk.Selling = false
    if not ok then error(sold, 0) end

    junk.Sold += sold
    return sold
end

function xDTaraZ.Junk.Dispatch(token)
    local junk = xDTaraZ.Junk
    if junk.Anchor == "seller" then
        task.spawn(xDTaraZ.Util.Try, "junk sell", junk.Sell, token)
        return
    end
    xDTaraZ.Util.Try("junk sell", junk.Sell, token)
    junk.Goto(token, "plot")
end

function xDTaraZ.Junk.Resync()
    local junk = xDTaraZ.Junk
    if os.clock() - junk.ActiveAt < xDTaraZ.Config.JunkResyncIdle then return end
    junk.ActiveAt = os.clock()
    xDTaraZ.Hatch.RequestSnapshot()
end

function xDTaraZ.Junk.Progress(token)
    local junk = xDTaraZ.Junk
    if not junk.Selling and junk.Fresh >= xDTaraZ.Config.JunkSellEvery then junk.Dispatch(token) end
    junk.Resync()
    if os.clock() - junk.ReportAt >= xDTaraZ.Config.JunkReportGap then junk.Report() end
end

---@return boolean  planting keeps failing and the run should end
function xDTaraZ.Junk.Stuck(token)
    local junk = xDTaraZ.Junk
    if junk.PlantFails < xDTaraZ.Config.JunkPlantFails then return false end
    junk.PlantFails = 0
    if junk.Anchor == "seller" then
        junk.Anchor = "plot"
        return not junk.Goto(token, "plot")
    end
    junk.BackoffUntil = os.clock() + xDTaraZ.Config.JunkBackoff
    junk.Report("Server is not taking eggs, retrying soon")
    return true
end

---@return boolean  other jobs are waiting for the character
function xDTaraZ.Junk.Yielding()
    for _, idx in ipairs(xDTaraZ.Config.JunkYieldTo) do
        if xDTaraZ.Util.Opt(idx) == true then return true end
    end
    return false
end

---@return boolean  the run should end
function xDTaraZ.Junk.Finished(token, started)
    local junk, now = xDTaraZ.Junk, os.clock()
    if junk.Stuck(token) then return true end
    if now - started > xDTaraZ.Config.JunkSessionMax and junk.Yielding() then
        junk.YieldUntil = now + xDTaraZ.Config.JunkYieldGap
        return true
    end
    return not junk.HasWork()
end

---@return boolean  something was hatched or planted
function xDTaraZ.Junk.Pulse(token, bp)
    local junk = xDTaraZ.Junk
    local hatched = junk.HatchReady()
    local planted = junk.PlantFree(token, bp)
    if hatched + planted > 0 then junk.ActiveAt = os.clock() end
    junk.Progress(token)
    return hatched + planted > 0
end

function xDTaraZ.Junk.Leave(token)
    local junk, hum = xDTaraZ.Junk, xDTaraZ.Player.Humanoid
    xDTaraZ.Tasks.Await(token, function() return not junk.Selling end, xDTaraZ.Config.SellReplyTimeout)
    if junk.Alive(token) and junk.Fresh > 0 and not junk.HasWork() then
        xDTaraZ.Util.Try("junk sell", junk.Sell, token)
    end

    junk.Held = nil
    if hum and hum.Parent and xDTaraZ.Player:BasketCount() == 0 then hum:UnequipTools() end
    xDTaraZ.Mount.Dirty = true
    junk.Report()
end

function xDTaraZ.Junk.Run(token)
    local junk = xDTaraZ.Junk
    local _, bp = xDTaraZ.Player:Plot()
    if not bp or not junk.Enter(token) then return end

    local started = os.clock()
    while junk.Alive(token) do
        junk.Pulse(token, bp)
        if junk.Finished(token, started) or not junk.Frame(token) then break end
    end
    junk.Leave(token)
end

function xDTaraZ.Junk.Bind()
    local junk = xDTaraZ.Junk
    if junk.Bound then return end
    junk.Bound = true
    xDTaraZ.Hatch.Bind()
    xDTaraZ.Sell.Bind()
    xDTaraZ.Hatch.Signal:Connect(junk.OnHatched)
end

---@return boolean  a run may start now
function xDTaraZ.Junk.CanRun()
    local junk, now = xDTaraZ.Junk, os.clock()
    if now < junk.BackoffUntil or now < junk.YieldUntil then return false end
    if xDTaraZ.Tasks.Carrying() or not xDTaraZ.Player:IsAlive() then return false end
    return junk.HasWork()
end

function xDTaraZ.Junk.Step()
    if not xDTaraZ.Util.Opt("ClearJunk") then return end
    local junk = xDTaraZ.Junk
    junk.Bind()
    junk.HatchReady()
    if not junk.CanRun() then
        if junk.PlotJunk() > 0 then return end
        junk.Report(xDTaraZ.Hatch.Room() == 0 and "Plot is full" or "Nothing to clear right now")
        return
    end

    local token = xDTaraZ.Tasks.Request("Junk", xDTaraZ.Tasks.Prio.Plot)
    if not token then
        junk.Report("Waiting for the egg run")
        return
    end

    junk.Running = true
    local ok, err = pcall(junk.Run, token)
    junk.Running = false
    xDTaraZ.Tasks.Release(token)
    if not ok then error(err, 0) end
end

function xDTaraZ.Junk.SellNow()
    xDTaraZ.Junk.Bind()
    local sold = xDTaraZ.Pets.WithToken("Sell", xDTaraZ.Tasks.Prio.Travel, function(token)
        return xDTaraZ.Sell.Run(token, true)
    end) or 0
    xDTaraZ.Util.Notify("Clear Junk Eggs", sold > 0 and ("Sold " .. sold .. " pets") or "No junk pets to sell", 4)
    return sold
end

function xDTaraZ.Junk.Start()
    xDTaraZ.Junk.Bind()
end

function xDTaraZ.Junk.Stop()
    local junk = xDTaraZ.Junk
    junk.Report("Off")
end

function xDTaraZ.Junk.Status()
    return xDTaraZ.State.Status.Junk or "Off"
end

xDTaraZ.Pets = {
    Bound = false,
    Index = {},
    Holders = {},
    Placed = {},
    Top = {},
    TopAt = 0,
    Collected = 0,
    Swaps = 0,
    Fed = 0,
    Kept = {},
}

function xDTaraZ.Pets.IsOurs(owner)
    return owner == nil or owner == LocalPlayer or owner == LocalPlayer.UserId or owner == LocalPlayer.Name
end

function xDTaraZ.Pets.SetStatus(text)
    xDTaraZ.State.Status.Pets = text
end

---@return any  SavedData value, nil when missing
function xDTaraZ.Pets.Saved(name)
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local value = saved and saved:FindFirstChild(name)
    return value and value.Value
end

---@return number  leaderstats Income/s
function xDTaraZ.Pets.IncomeRate()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    local value = stats and stats:FindFirstChild("Income/s")
    return value and tonumber(value.Value) or 0
end

function xDTaraZ.Pets.MaxSlots()
    local fromAttr = tonumber(LocalPlayer:GetAttribute("MaxPets"))
    return fromAttr or tonumber(xDTaraZ.Pets.Saved("MaxPets")) or 5
end

---@return number  weight after the game's age bonus
function xDTaraZ.Pets.AgedWeight(kg, age)
    local aging = xDTaraZ.GameLib.Svc.PetAging
    if not age or type(aging) ~= "table" then return kg end
    local ok, aged = xDTaraZ.GameLib.Call(aging.WeightFor, kg, age)
    return ok and tonumber(aged) or kg
end

---@param row table  PetName, BaseWeight, Weight, BirthTime
---@return number|nil  age the game shows for this BirthTime
function xDTaraZ.Pets.AgeFrom(row)
    local aging = xDTaraZ.GameLib.Svc.PetAging
    if not tonumber(row.BirthTime) or type(aging) ~= "table" then return nil end
    local ok, age = xDTaraZ.GameLib.Call(aging.StateFrom, row.BirthTime, xDTaraZ.Util.ServerNow(), row)
    return ok and tonumber(age) or nil
end

---@return number  display income per second, before rebirth and friend bonus
function xDTaraZ.Pets.Income(pet)
    local info = xDTaraZ.GameLib.PetInfo[pet.name or ""]
    if not info then return 0 end

    local mutations = xDTaraZ.GameLib.Mutations
    local factor = (mutations[pet.mutation or ""] or 1) * (mutations[pet.spawnMutation or ""] or 1)
    local kg = pet.baseWeight and pet.age and xDTaraZ.Pets.AgedWeight(pet.baseWeight, pet.age)
        or xDTaraZ.Pets.AgedWeight(pet.weight or xDTaraZ.Config.PetBaseKg, pet.age)
    return math.floor(math.floor((info.income or 0) * kg / 10) * factor)
end

---@param src  Instance|table  pet Tool or a PlacePet reply
---@return table  pet record
function xDTaraZ.Pets.Record(src, placed)
    local isTool = typeof(src) == "Instance"
    local attrs = isTool and src:GetAttributes() or src

    local name = attrs.PetName or (isTool and src.Name) or nil
    local pet = {
        key = attrs.PetKey,
        name = name,
        weight = tonumber(attrs.Weight) or tonumber(attrs.BaseWeight),
        mutation = attrs.Mutation,
        spawnMutation = attrs.SpawnMutation,
        baseWeight = tonumber(attrs.BaseWeight),
        birthTime = tonumber(attrs.BirthTime),
        age = tonumber(attrs.Age),
        favorite = attrs.Favorited == true,
        placed = placed,
        tool = isTool and src or nil,
        pos = placed and attrs.Position or nil,
        collectTime = tonumber(attrs.CollectTime),
        at = os.clock(),
    }
    if not pet.age and pet.birthTime then
        pet.age = xDTaraZ.Pets.AgeFrom({ PetName = name, BaseWeight = pet.baseWeight, Weight = pet.weight, BirthTime = pet.birthTime })
    end
    pet.ageKnown = pet.age ~= nil
    pet.mutated = (pet.mutation ~= nil and pet.mutation ~= "") or (pet.spawnMutation ~= nil and pet.spawnMutation ~= "")
    pet.income = xDTaraZ.Pets.Income(pet)
    local info = xDTaraZ.GameLib.PetInfo[name or ""]
    pet.speed = info and info.speed or 0
    pet.rarity = info and info.rarity
    return pet
end

---@param reply table  PlacePet.OnClientEvent payload
function xDTaraZ.Pets.OnPlace(reply)
    if type(reply) ~= "table" or not xDTaraZ.Pets.IsOurs(reply.Owner) then return end
    if reply.Action == "Remove" then
        if type(reply.PetKey) == "string" then
            xDTaraZ.Pets.Placed[reply.PetKey] = nil
        else
            table.clear(xDTaraZ.Pets.Placed)
        end
    elseif reply.Action == "Place" and reply.PetKey then
        xDTaraZ.Pets.Placed[reply.PetKey] = xDTaraZ.Pets.Record(reply, true)
    end
    xDTaraZ.Pets.TopAt = 0
end

function xDTaraZ.Pets.OnCollect(reply)
    if type(reply) ~= "table" or not xDTaraZ.Pets.IsOurs(reply.Owner) then return end
    local keys = type(reply.PetKeys) == "table" and reply.PetKeys or { reply.PetKey }
    for _, key in pairs(keys) do
        local pet = xDTaraZ.Pets.Placed[key]
        if pet then pet.collectTime = tonumber(reply.CollectTime) or xDTaraZ.Util.ServerNow() end
    end
end

function xDTaraZ.Pets.OnFed(reply)
    if type(reply) ~= "table" or not xDTaraZ.Pets.IsOurs(reply.Owner) then return end
    xDTaraZ.Pets.FedAt = os.clock()
    local pet = xDTaraZ.Pets.Placed[reply.PetKey or ""]
    if not pet then return end
    pet.weight = tonumber(reply.Weight) or pet.weight
    if tonumber(reply.BirthTime) then
        pet.birthTime = tonumber(reply.BirthTime)
        pet.age = xDTaraZ.Pets.AgeFrom({ PetName = pet.name, BaseWeight = pet.baseWeight, Weight = pet.weight, BirthTime = pet.birthTime }) or pet.age
    end
    pet.income = xDTaraZ.Pets.Income(pet)
end

function xDTaraZ.Pets.SeedFromRenderer()
    local scripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local module = scripts and scripts:FindFirstChild("PetRenderer", true)
    local renderer = module and xDTaraZ.GameLib.Require(module)
    if type(renderer) ~= "table" or type(renderer.GetAll) ~= "function" then return end

    local ok, all = xDTaraZ.GameLib.Call(renderer.GetAll)
    if not ok or type(all) ~= "table" then return end
    for _, entry in pairs(all) do
        if type(entry) ~= "table" or not entry.PetKey then continue end
        if entry.OwnerUserId ~= LocalPlayer.UserId then continue end

        local model = typeof(entry.Model) == "Instance" and entry.Model or nil
        local pos = entry.Position
        if typeof(pos) ~= "Vector3" and model and model:IsA("Model") then pos = model:GetPivot().Position end
        local row = setmetatable({ PetName = entry.PetName or (model and model.Name), Position = pos }, {
            __index = function(_, key)
                local value = entry[key]
                if value == nil and model then value = model:GetAttribute(key) end
                return value
            end,
        })
        xDTaraZ.Pets.Placed[entry.PetKey] = xDTaraZ.Pets.Record(row, true)
    end
end

function xDTaraZ.Pets.Bind()
    if xDTaraZ.Pets.Bound then return end
    xDTaraZ.Pets.Bound = true

    local place = xDTaraZ.GameLib.Remote("PlacePet")
    if place then xDTaraZ:Connect(place.OnClientEvent, xDTaraZ.Pets.OnPlace) end
    local collect = xDTaraZ.GameLib.Remote("PetCollect")
    if collect then xDTaraZ:Connect(collect.OnClientEvent, xDTaraZ.Pets.OnCollect) end
    local fed = xDTaraZ.GameLib.Remote("PetFed")
    if fed then xDTaraZ:Connect(fed.OnClientEvent, xDTaraZ.Pets.OnFed) end

    xDTaraZ.Util.Try("pets seed", xDTaraZ.Pets.SeedFromRenderer)
    table.insert(xDTaraZ.State.Connections, xDTaraZ.Pets.Unbind)
    xDTaraZ.Pets.WatchHolders(LocalPlayer.Character)
    xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(char)
        task.defer(xDTaraZ.Util.Try, "pets rebind", xDTaraZ.Pets.WatchHolders, char)
    end)
end

function xDTaraZ.Pets.Unbind()
    for _, entry in pairs(xDTaraZ.Pets.Index) do entry.conn:Disconnect() end
    table.clear(xDTaraZ.Pets.Index)
    table.clear(xDTaraZ.Pets.Holders)
end

function xDTaraZ.Pets.Held(inst)
    local parent = inst.Parent
    return parent ~= nil and xDTaraZ.Pets.Holders[parent] ~= nil
end

function xDTaraZ.Pets.Track(tool)
    local index = xDTaraZ.Pets.Index
    if index[tool] or not tool:IsA("Tool") or not tool:GetAttribute("PetKey") then return end

    local entry = { name = tool:GetAttribute("PetName") or tool.Name }
    entry.conn = tool.AttributeChanged:Connect(function(attr)
        if xDTaraZ.Config.PetWatchedAttrs[attr] then entry.rec = nil end
    end)
    index[tool] = entry
end

function xDTaraZ.Pets.Untrack(tool)
    local entry = xDTaraZ.Pets.Index[tool]
    if not entry or xDTaraZ.Pets.Held(tool) then return end
    entry.conn:Disconnect()
    xDTaraZ.Pets.Index[tool] = nil
end

function xDTaraZ.Pets.Watch(holder)
    if not holder or xDTaraZ.Pets.Holders[holder] then return end
    xDTaraZ.Pets.Holders[holder] = {
        xDTaraZ:Connect(holder.ChildAdded, xDTaraZ.Pets.Track),
        xDTaraZ:Connect(holder.ChildRemoved, function(child) task.defer(xDTaraZ.Pets.Untrack, child) end),
    }
    for _, child in ipairs(holder:GetChildren()) do xDTaraZ.Pets.Track(child) end
end

---@param char Model|nil  current character; the old character and Backpack stop being watched
function xDTaraZ.Pets.WatchHolders(char)
    local bag = LocalPlayer:FindFirstChildOfClass("Backpack") or LocalPlayer:WaitForChild("Backpack", xDTaraZ.Config.LoadTimeout)
    for holder, conns in pairs(xDTaraZ.Pets.Holders) do
        if holder == bag or holder == char then continue end
        for _, conn in ipairs(conns) do conn:Disconnect() end
        xDTaraZ.Pets.Holders[holder] = nil
    end

    xDTaraZ.Pets.Watch(bag)
    xDTaraZ.Pets.Watch(char)
    for tool in pairs(xDTaraZ.Pets.Index) do xDTaraZ.Pets.Untrack(tool) end
end

---@return table  cached record, rebuilt after a watched attribute changed or the age went stale
function xDTaraZ.Pets.ToolRecord(tool, entry)
    local rec = entry.rec
    if rec and not (rec.birthTime and os.clock() - rec.at > xDTaraZ.Config.PetAgeRefresh) then return rec end
    rec = xDTaraZ.Pets.Record(tool, false)
    entry.rec = rec
    return rec
end

---@return table<string, Tool>  pet name -> one held tool of that pet
function xDTaraZ.Pets.ToolsByName()
    xDTaraZ.Pets.Bind()
    local found = {}
    for tool, entry in pairs(xDTaraZ.Pets.Index) do
        local name = entry.name
        if name and not found[name] and xDTaraZ.GameLib.PetInfo[name] then found[name] = tool end
    end
    return found
end

---@return Tool|nil  one held tool of that pet
function xDTaraZ.Pets.ToolNamed(name)
    xDTaraZ.Pets.Bind()
    for tool, entry in pairs(xDTaraZ.Pets.Index) do
        if entry.name == name then return tool end
    end
    return nil
end

---@return table[]  fresh list, safe to sort; records are shared, do not edit them
function xDTaraZ.Pets.Owned()
    xDTaraZ.Pets.Bind()
    local list = {}
    for tool, entry in pairs(xDTaraZ.Pets.Index) do
        list[#list + 1] = xDTaraZ.Pets.ToolRecord(tool, entry)
    end
    for _, pet in pairs(xDTaraZ.Pets.Placed) do
        table.insert(list, pet)
    end
    return list
end

---@return string|nil  key of the pet we ride right now
function xDTaraZ.Pets.RideKey()
    if not xDTaraZ.Player:Riding() then return nil end
    local char = xDTaraZ.Player.Char
    local tool = char and char:FindFirstChildOfClass("Tool")
    return tool and tool:GetAttribute("PetKey") or nil
end

function xDTaraZ.Pets.IsRide(pet)
    if pet.tool and pet.tool.Parent == xDTaraZ.Player.Char and xDTaraZ.Player:Riding() then return true end
    local rideKey = xDTaraZ.Pets.RideKey()
    return rideKey ~= nil and rideKey == pet.key
end

---@return table<string, true>  pet names some unfinished rebirth still needs
function xDTaraZ.Pets.RebirthNeeds()
    local done = tonumber(xDTaraZ.Pets.Saved("Rebirths")) or 0
    local needs = {}
    for step, req in pairs(xDTaraZ.GameLib.RebirthReq or {}) do
        local index = tonumber(step)
        if type(step) == "string" and not index then
            if (tonumber(req) or math.huge) > done then needs[step] = true end
            continue
        end
        if not index or index <= done then continue end
        if type(req) == "string" then needs[req] = true end
        if type(req) == "table" then
            for _, name in pairs(req) do
                if type(name) == "string" then needs[name] = true end
            end
        end
    end
    return needs
end

---@return table<string, true>  keys of the placed pets that earn the most
function xDTaraZ.Pets.TopPlaced()
    local now = os.clock()
    if now - xDTaraZ.Pets.TopAt < xDTaraZ.Config.TopCacheSec then return xDTaraZ.Pets.Top end

    local placed = {}
    for _, pet in pairs(xDTaraZ.Pets.Placed) do placed[#placed + 1] = pet end
    table.sort(placed, function(a, b) return a.income > b.income end)

    local top = {}
    for i = 1, math.min(#placed, xDTaraZ.Pets.MaxSlots()) do top[placed[i].key] = true end
    xDTaraZ.Pets.Top, xDTaraZ.Pets.TopAt = top, now
    return top
end

---@return boolean, string|nil  protected, why
function xDTaraZ.Pets.Protected(pet, needs)
    if pet.favorite then return true, "favorite" end

    local list = xDTaraZ.Util.Opt("ProtectList")
    if type(list) == "table" and (list[pet.name or ""] or list[pet.key or ""]) then return true, "protect list" end

    needs = needs or xDTaraZ.Pets.RebirthNeeds()
    if needs[pet.name or ""] then return true, "rebirth" end
    if xDTaraZ.Pets.IsRide(pet) then return true, "ride pet" end
    if pet.name and (xDTaraZ.Mount.Choice() == pet.name or xDTaraZ.Mount.Name == pet.name) then return true, "ride pet" end

    local fusion = xDTaraZ.Fusion
    if fusion and fusion.Inputs and fusion.Inputs[pet.key or ""] then return true, "fusion" end
    if pet.placed and xDTaraZ.Pets.TopPlaced()[pet.key or ""] then return true, "placed" end
    return false
end

---@return CFrame|nil, BasePart|nil  a point on our baseplate, the baseplate
function xDTaraZ.Pets.PlotStand()
    local _, bp = xDTaraZ.Player:Plot()
    if not bp then return nil end
    return CFrame.new(bp.Position + Vector3.new(0, bp.Size.Y / 2 + xDTaraZ.Config.PetStandLift, 0)), bp
end

---@return Vector3  random spot on the baseplate surface
function xDTaraZ.Pets.Spot(bp)
    local spread = xDTaraZ.Config.PetSpread
    local offset = Vector3.new((math.random() * 2 - 1) * bp.Size.X * spread, bp.Size.Y / 2 + 1, (math.random() * 2 - 1) * bp.Size.Z * spread)
    return (bp.CFrame * CFrame.new(offset)).Position
end

---@param fn fun(token: table): any
---@return any  fn result, nil when no token was granted
function xDTaraZ.Pets.WithToken(owner, prio, fn)
    local token = xDTaraZ.Tasks.Request(owner, prio)
    if not token then return nil end
    local ok, out = pcall(fn, token)
    xDTaraZ.Tasks.Release(token)
    if not ok then error(out, 0) end
    return out
end

---@return table[], table[]  unplaced candidates best first, placed pets worst first
function xDTaraZ.Pets.SwapPlan()
    local unplaced, placed = {}, {}
    local mount = xDTaraZ.Mount.Best()
    local rideKept = false
    for _, pet in ipairs(xDTaraZ.Pets.Owned()) do
        if pet.placed then
            if pet.ageKnown then placed[#placed + 1] = pet end
        elseif xDTaraZ.Pets.IsRide(pet) then
            rideKept = true
        elseif pet.key and pet.income > 0 then
            table.insert(unplaced, pet)
        elseif pet.name == mount then
            rideKept = true
        end
    end
    table.sort(unplaced, function(a, b) return a.income > b.income end)
    table.sort(placed, function(a, b) return a.income < b.income end)

    if mount and not rideKept then
        for i = #unplaced, 1, -1 do
            if unplaced[i].name == mount then
                table.remove(unplaced, i)
                break
            end
        end
    end
    return unplaced, placed
end

---@return boolean  the server confirmed the change
function xDTaraZ.Pets.AwaitPlaced(token, key, present)
    return (xDTaraZ.Tasks.Await(token, function()
        return (xDTaraZ.Pets.Placed[key] ~= nil) == present
    end, xDTaraZ.Config.PetReplyTimeout))
end

---@param worst table|nil  placed pet to pick up first
---@return boolean  pet is placed; a failed place puts worst back
function xDTaraZ.Pets.Swap(token, pet, worst, bp)
    local placeRemote, pickRemote = xDTaraZ.GameLib.Remote("PlacePet"), xDTaraZ.GameLib.Remote("PickupPet")
    token.critical = true

    if worst then
        pickRemote:FireServer(worst.key)
        if not xDTaraZ.Pets.AwaitPlaced(token, worst.key, false) then
            token.critical = false
            return false
        end
    end

    placeRemote:FireServer(pet.key, xDTaraZ.Pets.Spot(bp))
    local ok = xDTaraZ.Pets.AwaitPlaced(token, pet.key, true)
    if not ok and worst then
        placeRemote:FireServer(worst.key, worst.pos or xDTaraZ.Pets.Spot(bp))
        xDTaraZ.Pets.AwaitPlaced(token, worst.key, true)
    end
    token.critical = false
    return ok
end

---@return integer  pets placed or swapped
function xDTaraZ.Pets.PlaceBest(token)
    local placeRemote, pickRemote = xDTaraZ.GameLib.Remote("PlacePet"), xDTaraZ.GameLib.Remote("PickupPet")
    local stand, bp = xDTaraZ.Pets.PlotStand()
    if not placeRemote or not pickRemote or not stand then return 0 end

    local unplaced, placed = xDTaraZ.Pets.SwapPlan()
    local free = xDTaraZ.Pets.MaxSlots() - #placed
    for i = #placed, 1, -1 do
        if xDTaraZ.Pets.Kept[placed[i].key or ""] then table.remove(placed, i) end
    end
    if not unplaced[1] then return 0 end
    if free <= 0 and (not placed[1] or unplaced[1].income <= placed[1].income * xDTaraZ.Config.PetSwapGain) then return 0 end
    if not xDTaraZ.Tasks.Teleport(token, stand) then return 0 end

    local changed, swapped = 0, {}
    local before = xDTaraZ.Pets.IncomeRate()
    for _, pet in ipairs(unplaced) do
        if not xDTaraZ.Tasks.Holds(token) then break end
        local worst
        if free <= 0 then
            worst = placed[1]
            if not worst or pet.income <= worst.income * xDTaraZ.Config.PetSwapGain then break end
        end
        local ok = xDTaraZ.Pets.Swap(token, pet, worst, bp)
        if not ok then break end
        if worst then
            table.remove(placed, 1)
            table.insert(swapped, { pet, worst })
        else
            free -= 1
        end
        changed += 1
    end
    if #swapped > 0 then changed -= xDTaraZ.Pets.GuardIncome(token, before, swapped, bp) end

    xDTaraZ.Pets.Swaps += changed
    if changed > 0 then xDTaraZ.Mount.Dirty = true end
    return changed
end

---@param swapped table[]  { placed, pickedUp } pairs, undone newest first
---@return integer           swaps undone because Income/s went down
function xDTaraZ.Pets.GuardIncome(token, before, swapped, bp)
    xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.IncomeSettle)
    local after = xDTaraZ.Pets.IncomeRate()
    if after >= before then return 0 end

    local undone = 0
    for i = #swapped, 1, -1 do
        local pair = swapped[i]
        xDTaraZ.Pets.Kept[pair[2].key] = true
        if not xDTaraZ.Tasks.Holds(token) then break end
        if xDTaraZ.Pets.Swap(token, pair[2], xDTaraZ.Pets.Placed[pair[1].key] or pair[1], bp) then undone += 1 end
    end
    warn(xDTaraZ.Config.Tag, "place best: income " .. before .. " -> " .. after .. ", undid " .. undone)
    return undone
end

---@return boolean  the game collects on its own (pass owned)
function xDTaraZ.Pets.GameCollects()
    if LocalPlayer:GetAttribute("AutoCollectCash") == true then return true end
    local passes = tostring(xDTaraZ.Pets.Saved("OwnedPasses") or "")
    for _, mark in ipairs(xDTaraZ.Config.AutoCollectPass) do
        if passes:find(mark, 1, true) then return true end
    end
    return false
end

---@return number  seconds of income waiting on this pet
function xDTaraZ.Pets.PendingSec(pet)
    if not pet.collectTime then return math.huge end
    return xDTaraZ.Util.ServerNow() - pet.collectTime
end

---@param force boolean  ignore the pending threshold
---@return integer  collect fires sent
function xDTaraZ.Pets.Collect(token, force)
    local remote = xDTaraZ.GameLib.Remote("PetCollect")
    if not remote then return 0 end

    local fired = 0
    for key, pet in pairs(xDTaraZ.Pets.Placed) do
        if not xDTaraZ.Tasks.Holds(token) then break end
        if not force and xDTaraZ.Pets.PendingSec(pet) < xDTaraZ.Config.CollectMinPending then continue end
        if typeof(pet.pos) ~= "Vector3" then continue end
        if not xDTaraZ.Tasks.Teleport(token, CFrame.new(pet.pos + Vector3.new(0, xDTaraZ.Config.PetStandLift, 0))) then break end

        local ok, why = xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.CollectGap)
        if not ok and why ~= "timeout" then break end
        remote:FireServer(key)
        fired += 1
    end

    xDTaraZ.Pets.Collected += fired
    if fired > 0 then
        local stand = xDTaraZ.Pets.PlotStand()
        if stand then xDTaraZ.Tasks.Teleport(token, stand) end
    end
    return fired
end

---@return Tool[]  food tools the user allows, cheapest first
function xDTaraZ.Pets.FoodTools()
    local allowed = xDTaraZ.Util.Opt("FoodTypes")
    local foods = xDTaraZ.GameLib.Foods or {}
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    local tools = {}
    for _, tool in ipairs(backpack and backpack:GetChildren() or {}) do
        local row = tool:IsA("Tool") and foods[tool.Name]
        if not row then continue end
        if type(allowed) == "table" and next(allowed) and not allowed[tool.Name] then continue end
        tools[#tools + 1] = { tool, type(row) == "table" and tonumber(row.Price or row.Cost) or 0 }
    end
    table.sort(tools, function(a, b) return a[2] < b[2] end)
    for i, pair in ipairs(tools) do tools[i] = pair[1] end
    return tools
end

---@return table[]  { key, ridden } pets to feed for the current FeedTarget
function xDTaraZ.Pets.FeedTargets()
    local mode = xDTaraZ.Util.Opt("FeedTarget") or "Placed"
    local targets = {}
    if mode ~= "Ride pet" then
        for key, pet in pairs(xDTaraZ.Pets.Placed) do
            if (pet.age or 0) < xDTaraZ.Config.PetMaxAge then targets[#targets + 1] = { key, false } end
        end
    end

    local rideKey = mode ~= "Placed" and xDTaraZ.Pets.RideKey()
    if rideKey then
        local tool = xDTaraZ.Player.Char and xDTaraZ.Player.Char:FindFirstChildOfClass("Tool")
        local age = tool and tonumber(tool:GetAttribute("Age")) or 0
        if age < xDTaraZ.Config.PetMaxAge then table.insert(targets, { rideKey, true }) end
    end
    return targets
end

---@return boolean  standing on our plot
function xDTaraZ.Pets.GoHome(token)
    local hrp = xDTaraZ.Player.Root
    if hrp and xDTaraZ.Geo.InPlot(hrp.Position) then return true end
    local stand = xDTaraZ.Pets.PlotStand()
    return stand ~= nil and xDTaraZ.Tasks.Teleport(token, stand)
end

---@return integer  foods used
function xDTaraZ.Pets.Feed()
    local remote = xDTaraZ.GameLib.Remote("FeedPet")
    if not remote then return 0 end
    xDTaraZ.Pets.Bind()
    if not xDTaraZ.Pets.FoodTools()[1] or not xDTaraZ.Pets.FeedTargets()[1] then
        xDTaraZ.State.Status.Feed = "No food or nothing to feed"
        return 0
    end
    return xDTaraZ.Pets.WithToken("Feed", xDTaraZ.Tasks.Prio.Plot, function(token)
        if not xDTaraZ.Pets.GoHome(token) then
            xDTaraZ.State.Status.Feed = "Could not reach the ranch"
            return 0
        end
        return xDTaraZ.Pets.FeedAll(remote, token)
    end) or 0
end

---@return integer  food left in a stacked food tool
local function FoodLeft(tool)
    local data = tool and tool.Parent and tool:FindFirstChild("Data")
    local amount = data and data:FindFirstChild("Amount")
    return amount and tonumber(amount.Value) or 1
end

---@return integer  feeds the server took, one at a time at its own pace, until food, pets or the burst run out
function xDTaraZ.Pets.FeedAll(remote, token)
    local cfg = xDTaraZ.Config
    local used, misses, turn = 0, 0, 0
    local deadline = os.clock() + cfg.FeedBurst
    while os.clock() < deadline and misses < cfg.FeedMissLimit and xDTaraZ.Tasks.Holds(token) do
        local targets = xDTaraZ.Pets.FeedTargets()
        local food
        for _, tool in ipairs(xDTaraZ.Pets.FoodTools()) do
            if FoodLeft(tool) > 0 then
                food = tool
                break
            end
        end
        if not food or #targets == 0 then break end

        turn = turn % #targets + 1
        local target = targets[turn]
        local before, firedAt = xDTaraZ.Pets.FedAt, os.clock()
        remote:FireServer(target[1], food.Name, target[2] or nil)
        local ok = xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Pets.FedAt ~= before end, cfg.FeedReplyTimeout)
        if ok then
            used += 1
            misses = 0
        else
            misses += 1
        end
        local wait = firedAt + cfg.FeedGap - os.clock()
        if wait > 0 then xDTaraZ.Tasks.Await(token, function() return false end, wait) end
    end

    xDTaraZ.Pets.Fed += used
    xDTaraZ.State.Status.Feed = used > 0 and ("Fed " .. xDTaraZ.Pets.Fed .. " times") or "No food or nothing to feed"
    return used
end

function xDTaraZ.Pets.PlaceNow()
    return xDTaraZ.Pets.WithToken("Pets", xDTaraZ.Tasks.Prio.Plot, function(token)
        xDTaraZ.Pets.Bind()
        local changed = xDTaraZ.Pets.PlaceBest(token)
        xDTaraZ.Pets.SetStatus(changed > 0 and ("Placed " .. changed .. " pets") or "Best pets placed")
        return changed
    end) or 0
end

function xDTaraZ.Pets.CollectNow()
    return xDTaraZ.Pets.WithToken("Pets", xDTaraZ.Tasks.Prio.Plot, function(token)
        xDTaraZ.Pets.Bind()
        return xDTaraZ.Pets.Collect(token, true)
    end) or 0
end

function xDTaraZ.Pets.Step()
    local equip, collect = xDTaraZ.Util.Opt("AutoEquipBest"), xDTaraZ.Util.Opt("AutoCollectCash")
    if not equip and not collect then return end
    xDTaraZ.Pets.Bind()

    local gameCollects = collect and xDTaraZ.Pets.GameCollects()
    xDTaraZ.Pets.WithToken("Pets", xDTaraZ.Tasks.Prio.Plot, function(token)
        if equip then xDTaraZ.Pets.PlaceBest(token) end
        if collect and not gameCollects then xDTaraZ.Pets.Collect(token, false) end
    end)
    xDTaraZ.Pets.SetStatus(xDTaraZ.Pets.Status())
end

function xDTaraZ.Pets.FeedStep()
    if not xDTaraZ.Util.Opt("AutoFeed") then return end
    xDTaraZ.Pets.Feed()
end

function xDTaraZ.Pets.Status()
    return string.format("Placed %d/%d | Swaps %d | Collects %d", #xDTaraZ.Pets.PlacedList(), xDTaraZ.Pets.MaxSlots(), xDTaraZ.Pets.Swaps, xDTaraZ.Pets.Collected)
end

function xDTaraZ.Pets.PlacedList()
    local list = {}
    for _, pet in pairs(xDTaraZ.Pets.Placed) do list[#list + 1] = pet end
    return list
end

function xDTaraZ.Pets.Start()
    xDTaraZ.Pets.Bind()
end

function xDTaraZ.Pets.Stop()
    local hum = xDTaraZ.Player.Humanoid
    if hum and not xDTaraZ.Player:Riding() then hum:UnequipTools() end
end

xDTaraZ.Sell = {
    Bound = false,
    ConfirmUntil = 0,
    Reply = nil,
    Sold = 0,
    Earned = 0,
}

function xDTaraZ.Sell.SetStatus(text)
    xDTaraZ.State.Status.Sell = text
end

function xDTaraZ.Sell.OnConfirm(id, question)
    if os.clock() > xDTaraZ.Sell.ConfirmUntil then return end
    if not tostring(question or ""):lower():find("sell", 1, true) then return end
    xDTaraZ.Sell.ConfirmUntil = 0
    local remote = xDTaraZ.GameLib.Remote("ConfirmRequest")
    if remote then remote:FireServer(id, true) end
end

function xDTaraZ.Sell.Bind()
    if xDTaraZ.Sell.Bound then return end
    xDTaraZ.Sell.Bound = true

    local sell = xDTaraZ.GameLib.Remote("SellItems")
    if sell then
        xDTaraZ:Connect(sell.OnClientEvent, function(reply) xDTaraZ.Sell.Reply = reply end)
    end
    local confirm = xDTaraZ.GameLib.Remote("ConfirmRequest")
    if confirm then xDTaraZ:Connect(confirm.OnClientEvent, xDTaraZ.Sell.OnConfirm) end
end

---@return boolean  this pet passes the sell filters
function xDTaraZ.Sell.Allowed(pet, keep, under)
    if pet.placed or not pet.key or not pet.rarity then return false end
    if keep[pet.rarity] then return false end
    if pet.mutated and xDTaraZ.Util.Opt("SellKeepMutated") then return false end
    if under > 0 and pet.income >= under then return false end
    return true
end

---@return table  { [rarity] = true } for the top rarities when the player picked none
function xDTaraZ.Sell.DefaultKeep()
    local order = xDTaraZ.GameLib.RarityOrder
    local keep = {}
    for i = math.max(1, #order - xDTaraZ.Config.SellKeepTopRarities + 1), #order do
        keep[order[i]] = true
    end
    return keep
end

---@return table  { [rarity] = true } every rarity except the junk pets Clear Junk Eggs sells
function xDTaraZ.Sell.JunkKeep()
    local sell = xDTaraZ.Junk.SellSet()
    local keep = {}
    for _, rarity in ipairs(xDTaraZ.GameLib.RarityOrder) do
        if not sell[rarity] then keep[rarity] = true end
    end
    return keep
end

---@param junkOnly boolean?  sell only the Clear Junk Eggs pet rarities, never the best pets that fill the plot
---@return table[], number    pets to sell, cash expected
function xDTaraZ.Sell.Plan(junkOnly)
    local keep = xDTaraZ.Util.Opt("SellRarities")
    if type(keep) ~= "table" or next(keep) == nil then keep = xDTaraZ.Sell.DefaultKeep() end
    if junkOnly then keep = xDTaraZ.Sell.JunkKeep() end

    local under = not junkOnly and tonumber(xDTaraZ.Util.Opt("SellUnderIncome")) or 0
    local keepBest = junkOnly and xDTaraZ.Pets.MaxSlots() or tonumber(xDTaraZ.Util.Opt("SellKeepBest")) or 0
    local owned = xDTaraZ.Pets.Owned()
    table.sort(owned, function(a, b) return a.income > b.income end)

    local needs = xDTaraZ.Pets.RebirthNeeds()
    local plan, cash = {}, 0
    for rank, pet in ipairs(owned) do
        if rank <= keepBest then continue end
        if not xDTaraZ.Sell.Allowed(pet, keep, under) then continue end
        if xDTaraZ.Pets.Protected(pet, needs) then continue end
        plan[#plan + 1] = pet
        cash += pet.income * xDTaraZ.Config.SellPriceMult
    end
    return plan, cash
end

function xDTaraZ.Sell.Preview()
    local plan, cash = xDTaraZ.Sell.Plan()
    local text = "Will sell " .. #plan .. " for $" .. xDTaraZ.Util.Format(cash)
    xDTaraZ.State.Status.SellPreview = text
    return text
end

---@return CFrame|nil  a spot next to the seller
function xDTaraZ.Sell.Stand()
    local stalls = Workspace:FindFirstChild("Stalls")
    local stall = stalls and stalls:FindFirstChild("Sell")
    local richie = stall and stall:FindFirstChild("Richie")
    if not richie then return nil end

    local pivot = richie:IsA("Model") and richie:GetPivot() or (richie:IsA("BasePart") and richie.CFrame)
    if not pivot then return nil end
    return CFrame.new(pivot.Position + pivot.LookVector * xDTaraZ.Config.SellStand)
end

---@return number|nil  pets sold in this batch, nil when the seller refused
---@return string|nil  refusal reason
function xDTaraZ.Sell.Batch(token, remote, keys)
    xDTaraZ.Sell.Reply = nil
    xDTaraZ.Sell.ConfirmUntil = os.clock() + xDTaraZ.Config.ConfirmWindow
    remote:FireServer({ Pets = keys, Eggs = {} })

    xDTaraZ.Tasks.Await(token, function() return xDTaraZ.Sell.Reply ~= nil end, xDTaraZ.Config.SellReplyTimeout)
    local reply = xDTaraZ.Sell.Reply
    if type(reply) ~= "table" then return nil end
    if reply.Reason and reply.Reason ~= "Sold" then return nil, reply.Reason end
    return tonumber(reply.Sold) or 0
end

---@return number|nil  pets sold, nil when the seller refused for good
function xDTaraZ.Sell.Send(token, remote, keys)
    local cfg = xDTaraZ.Config
    for _ = 1, cfg.SellTries do
        local got, why = xDTaraZ.Sell.Batch(token, remote, keys)
        if got then return got end
        if why ~= "TooFar" and why ~= "Busy" then
            xDTaraZ.Sell.SetStatus("Seller says: " .. tostring(why or "no answer"))
            return nil
        end

        local _, waited = xDTaraZ.Tasks.Await(token, nil, why == "Busy" and cfg.SellRetry or cfg.SellSettle)
        if waited ~= "timeout" then return nil end
    end
    xDTaraZ.Sell.SetStatus("Seller is busy")
    return nil
end

---@param toggle string  switched off when income drops after the sale
function xDTaraZ.Sell.GuardIncome(before, toggle)
    task.wait(xDTaraZ.Config.IncomeSettle)
    local after = xDTaraZ.Pets.IncomeRate()
    if after >= before then return end

    table.insert(xDTaraZ.State.PendingToggleOff, toggle)
    xDTaraZ.Util.Notify("Mario Hub", "Income went down after selling, the sale option was stopped", 8)
    warn(xDTaraZ.Config.Tag .. " sell: income " .. before .. " -> " .. after)
end

---@return boolean  next to the seller and settled
function xDTaraZ.Sell.Arrive(token, stand)
    local hrp = xDTaraZ.Player.Root
    if hrp and (hrp.Position - stand.Position).Magnitude <= xDTaraZ.Config.SellNear then return true end
    if not xDTaraZ.Tasks.Teleport(token, stand) then return false end

    local _, settled = xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.SellSettle)
    return settled == "timeout"
end

---@param junkOnly boolean?  sell only the Clear Junk Eggs pet rarities
---@return integer            pets sold
function xDTaraZ.Sell.Run(token, junkOnly)
    local remote = xDTaraZ.GameLib.Remote("SellItems")
    local stand = xDTaraZ.Sell.Stand()
    if not remote or not xDTaraZ.GameLib.Remote("ConfirmRequest") or not stand then
        xDTaraZ.Sell.SetStatus("Seller not found")
        return 0
    end

    local plan, cash = xDTaraZ.Sell.Plan(junkOnly)
    if #plan == 0 then
        xDTaraZ.Sell.SetStatus("Nothing to sell")
        return 0
    end
    if not xDTaraZ.Sell.Arrive(token, stand) then return 0 end

    local before, sold = xDTaraZ.Pets.IncomeRate(), 0
    for first = 1, #plan, xDTaraZ.Config.SellBatch do
        local keys = {}
        for i = first, math.min(first + xDTaraZ.Config.SellBatch - 1, #plan) do
            table.insert(keys, plan[i].key)
        end
        local got = xDTaraZ.Sell.Send(token, remote, keys)
        if not got then break end
        sold += got
    end

    xDTaraZ.Sell.Sold += sold
    if sold > 0 then xDTaraZ.Sell.Earned += cash * sold / #plan end
    xDTaraZ.Sell.SetStatus("Sold " .. sold .. " pets")
    xDTaraZ.Sell.GuardIncome(before, junkOnly and "ClearJunk" or "AutoSell")
    return sold
end

function xDTaraZ.Sell.Now()
    xDTaraZ.Sell.Bind()
    return xDTaraZ.Pets.WithToken("Sell", xDTaraZ.Tasks.Prio.Travel, xDTaraZ.Sell.Run) or 0
end

function xDTaraZ.Sell.Step()
    xDTaraZ.Sell.Preview()
    if xDTaraZ.Util.Opt("AutoSell") then xDTaraZ.Sell.Now() end
end

function xDTaraZ.Sell.Status()
    return xDTaraZ.State.Status.Sell or ""
end

function xDTaraZ.Sell.Start()
    xDTaraZ.Sell.Bind()
end

function xDTaraZ.Sell.Stop()
    xDTaraZ.Sell.ConfirmUntil = 0
end

xDTaraZ.Fusion = {
    Inputs = {},
    Fused = 0,
    FiredAt = 0,
}

---@return string[]  rarities the machine takes, lowest first
function xDTaraZ.Fusion.Rarities()
    local cfg = xDTaraZ.GameLib.Data.Fusion
    local rank = xDTaraZ.GameLib.RarityRank
    local floor = type(cfg) == "table" and rank[cfg.MinimumInputRarity] or 0
    local list = {}
    for _, rarity in ipairs(xDTaraZ.GameLib.RarityOrder) do
        if (rank[rarity] or 0) >= floor then list[#list + 1] = rarity end
    end
    return list
end

---@return boolean  waited out the server request cooldown
function xDTaraZ.Fusion.Pace(token)
    local cfg = xDTaraZ.GameLib.Data.Fusion
    local gap = type(cfg) == "table" and tonumber(cfg.RequestCooldown) or xDTaraZ.Config.FuseGap
    local readyAt = xDTaraZ.Fusion.FiredAt + gap
    if os.clock() >= readyAt then return true end
    return (xDTaraZ.Tasks.Await(token, function() return os.clock() >= readyAt end, gap))
end

function xDTaraZ.Fusion.SetStatus(text)
    xDTaraZ.State.Status.Fusion = text
end

---@return boolean  the fusion event is running now
function xDTaraZ.Fusion.Active()
    local cfg = xDTaraZ.GameLib.Data and xDTaraZ.GameLib.Data.Fusion
    if type(cfg) ~= "table" then return false end

    local start = tonumber(cfg.StartTime)
    local on, off = tonumber(cfg.ActiveWeeks), tonumber(cfg.InactiveWeeks)
    if not (start and on and off) then return xDTaraZ.Fusion.Machine() ~= nil end

    local now = xDTaraZ.Util.ServerNow()
    if now < start then return false end
    local period = (on + off) * xDTaraZ.Config.WeekSec
    return (now - start) % period < on * xDTaraZ.Config.WeekSec
end

---@return Vector3|nil, table<number, Attachment>  console stand point, slot attachments
function xDTaraZ.Fusion.Machine()
    local functionals = Workspace:FindFirstChild("Functionals")
    local machine = functionals and functionals:FindFirstChild("Fusion")
    if not machine then return nil, {} end

    local slots, console = {}, nil
    for _, node in ipairs(machine:GetDescendants()) do
        local slot = node:IsA("Attachment") and tonumber(node:GetAttribute("FusionSlot"))
        if slot then slots[slot] = node end
        if node:IsA("ProximityPrompt") and node.Name == "OpenConsole" and node.Parent:IsA("Attachment") then
            console = node.Parent.WorldPosition
        end
    end
    return console, slots
end

---@return CFrame  stand point next to a world position
function xDTaraZ.Fusion.Near(pos)
    return CFrame.new(pos + Vector3.new(0, xDTaraZ.Config.FuseLift, xDTaraZ.Config.FuseStand))
end

---@return table[]  lowest income eligible backpack pets, up to count
function xDTaraZ.Fusion.Candidates(count)
    local allowed = xDTaraZ.Util.Opt("FuseRarities")
    if type(allowed) ~= "table" or not next(allowed) then return {} end

    local floor = xDTaraZ.GameLib.RarityRank[(xDTaraZ.Fusion.Rarities())[1] or ""] or 0
    local owned = xDTaraZ.Pets.Owned()
    table.sort(owned, function(a, b) return a.income > b.income end)
    local keepBest = tonumber(xDTaraZ.Util.Opt("FuseKeepBest")) or 0
    local needs = xDTaraZ.Pets.RebirthNeeds()

    local picked = {}
    for rank = #owned, keepBest + 1, -1 do
        if #picked >= count then break end
        local pet = owned[rank]
        if pet.placed or not pet.tool or not allowed[pet.rarity or ""] then continue end
        if (xDTaraZ.GameLib.RarityRank[pet.rarity] or 0) < floor then continue end
        if pet.mutated and xDTaraZ.Util.Opt("FuseKeepMutated") then continue end
        if xDTaraZ.Pets.Protected(pet, needs) then continue end
        picked[#picked + 1] = pet
    end
    return picked
end

---@return number|nil  cash the next fuse costs, nil when the preview does not say
function xDTaraZ.Fusion.Cost(state)
    local raw = state:GetAttribute("FusionPreviewJSON")
    if type(raw) ~= "string" or raw == "" then return nil end
    local ok, preview = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok or type(preview) ~= "table" then return nil end
    return tonumber(preview.Cost or preview.Price)
end

---@return boolean  fired and the slot filled
function xDTaraZ.Fusion.PlaceOne(token, state, slot, attach, pet)
    local remote = xDTaraZ.GameLib.Remote("FusionPetPlace")
    local hum = xDTaraZ.Player.Humanoid
    if not remote or not hum or not pet.tool.Parent then return false end
    if not xDTaraZ.Tasks.Teleport(token, xDTaraZ.Fusion.Near(attach.WorldPosition)) then return false end

    hum:EquipTool(pet.tool)
    xDTaraZ.Mount.Dirty = true
    local equipped = xDTaraZ.Tasks.Await(token, function() return pet.tool.Parent == xDTaraZ.Player.Char end, xDTaraZ.Config.FuseSettle * 4)
    if not equipped then return false end
    xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.FusePlaceSettle)
    if not xDTaraZ.Tasks.Holds(token) or not xDTaraZ.Fusion.Pace(token) then return false end
    xDTaraZ.Fusion.Inputs[pet.key] = true
    xDTaraZ.Fusion.FiredAt = os.clock()
    remote:FireServer(slot)

    local filled = xDTaraZ.Tasks.Await(token, function()
        return state:FindFirstChild(tostring(slot)) ~= nil
    end, xDTaraZ.Config.FuseReplyTimeout)
    if not filled then xDTaraZ.Fusion.Inputs[pet.key] = nil end
    return filled
end

---@return boolean  all slots filled
function xDTaraZ.Fusion.Fill(token, state, slots)
    local missing = {}
    for index = 1, xDTaraZ.Config.FuseSlots do
        if slots[index] and not state:FindFirstChild(tostring(index)) then missing[#missing + 1] = index end
    end
    if #missing == 0 then return true end

    local allowed = xDTaraZ.Util.Opt("FuseRarities")
    if type(allowed) ~= "table" or not next(allowed) then
        xDTaraZ.Fusion.SetStatus("Pick which rarities to fuse")
        return false
    end
    local pets = xDTaraZ.Fusion.Candidates(#missing)
    if #pets < #missing then
        xDTaraZ.Fusion.SetStatus("Need " .. (#missing - #pets) .. " more pets to fuse")
        return false
    end

    local done = true
    for i, slot in ipairs(missing) do
        xDTaraZ.Fusion.SetStatus("Filling slot " .. slot .. " of " .. xDTaraZ.Config.FuseSlots)
        if not xDTaraZ.Fusion.PlaceOne(token, state, slot, slots[slot], pets[i]) then
            done = false
            break
        end
    end
    local hum = xDTaraZ.Player.Humanoid
    if hum then hum:UnequipTools() end
    return done
end

function xDTaraZ.Fusion.AtConsole(token, console, ...)
    local remote = xDTaraZ.GameLib.Remote("FusionAction")
    if not remote or select(1, ...) == "SkipPurchase" then return false end
    if not xDTaraZ.Tasks.Teleport(token, xDTaraZ.Fusion.Near(console)) then return false end
    xDTaraZ.Tasks.Await(token, nil, xDTaraZ.Config.FuseSettle)
    if not xDTaraZ.Fusion.Pace(token) then return false end
    xDTaraZ.Fusion.FiredAt = os.clock()
    remote:FireServer(...)
    return true
end

---@return string|nil  key the Claim call wants
function xDTaraZ.Fusion.ResultKey(state)
    if state:GetAttribute("FusionFailed") == true then return state:GetAttribute("FusionResultKey") end
    local result = LocalPlayer:FindFirstChild("FusionResult")
    local pet = result and result:FindFirstChild("Pet")
    return pet and pet:GetAttribute("PetKey") or state:GetAttribute("FusionResultKey")
end

function xDTaraZ.Fusion.Waiting(token, state, console)
    local left = (tonumber(state:GetAttribute("EndsAt")) or math.huge) - xDTaraZ.Util.ServerNow()
    if left > 0 then
        xDTaraZ.Fusion.SetStatus("Fusing, " .. math.ceil(left) .. "s left")
        return
    end
    if xDTaraZ.Fusion.AtConsole(token, console, "Fuse") then xDTaraZ.Fusion.SetStatus("Fusion finished, claiming next") end
end

function xDTaraZ.Fusion.Claim(token, state, console)
    local fusion = xDTaraZ.Fusion
    local key = fusion.ResultKey(state)
    if not key or key == fusion.ClaimedKey then return end
    if not fusion.AtConsole(token, console, "Claim", key) then return end

    fusion.ClaimedKey = key
    fusion.Fused += 1
    table.clear(fusion.Inputs)
    fusion.SetStatus("Claimed fusion result")
    xDTaraZ.Tasks.Await(token, function() return state:GetAttribute("FusionStatus") ~= "Result" end, xDTaraZ.Config.FuseResultTimeout)
    fusion.PutAway(token)
end

---@return boolean  the result pet that lands in hand after a claim is back in the bag
function xDTaraZ.Fusion.PutAway(token)
    local hum, char = xDTaraZ.Player.Humanoid, xDTaraZ.Player.Char
    if not hum or not char or xDTaraZ.Player:Riding() then return false end
    xDTaraZ.Tasks.Await(token, function() return char:FindFirstChildOfClass("Tool") ~= nil end, xDTaraZ.Config.DismountToolWindow)
    hum:UnequipTools()
    return char:FindFirstChildOfClass("Tool") == nil
end

function xDTaraZ.Fusion.StartFuse(token, state, console)
    local cost = xDTaraZ.Fusion.Cost(state)
    local economy = xDTaraZ.Economy
    if cost and economy and economy.Reserve then
        economy.Reserve("Fusion", cost)
        if economy.Budget("Fusion") < cost then
            xDTaraZ.Fusion.SetStatus("Saving $" .. xDTaraZ.Util.Format(cost) .. " to fuse")
            return
        end
    end
    local started = xDTaraZ.Fusion.AtConsole(token, console, "Start")
    if economy and economy.Reserve then economy.Reserve("Fusion", nil) end
    if started then xDTaraZ.Fusion.SetStatus("Fusion started") end
end

function xDTaraZ.Fusion.Run(token)
    local state = LocalPlayer:FindFirstChild("FusionSlots")
    local console, slots = xDTaraZ.Fusion.Machine()
    if not state or not console then
        xDTaraZ.Fusion.SetStatus("Fusion machine not found")
        return
    end

    local status = state:GetAttribute("FusionStatus")
    if status == "Waiting" then
        xDTaraZ.Fusion.Waiting(token, state, console)
        return
    end
    if status == "Result" then
        xDTaraZ.Fusion.Claim(token, state, console)
        return
    end

    if not xDTaraZ.Fusion.Fill(token, state, slots) then return end
    if state:GetAttribute("Ready") == false then return xDTaraZ.Fusion.SetStatus("Machine is not ready yet") end
    xDTaraZ.Fusion.StartFuse(token, state, console)
end

---@return boolean, string|nil  allowed, why not
function xDTaraZ.Fusion.Ready()
    if (tonumber(xDTaraZ.Pets.Saved("Rebirths")) or 0) < 1 then return false, "Needs one rebirth" end
    if not xDTaraZ.Fusion.Active() then return false, "Fusion event is closed" end
    return true
end

function xDTaraZ.Fusion.Now()
    local ok, why = xDTaraZ.Fusion.Ready()
    if not ok then
        xDTaraZ.Fusion.SetStatus(why)
        return
    end
    xDTaraZ.Fusion.SetStatus("")
    local ran = xDTaraZ.Pets.WithToken("Fusion", xDTaraZ.Tasks.Prio.Plot, function(token)
        xDTaraZ.Fusion.Run(token)
        if xDTaraZ.Tasks.Holds(token) then xDTaraZ.Pets.GoHome(token) end
        return true
    end)
    if not ran then
        xDTaraZ.Fusion.SetStatus("Waiting for a turn")
    elseif xDTaraZ.State.Status.Fusion == "" then
        xDTaraZ.Fusion.SetStatus("Nothing to fuse")
    end
end

function xDTaraZ.Fusion.Step()
    if not xDTaraZ.Util.Opt("AutoFusion") then return end
    xDTaraZ.Fusion.Now()
end

function xDTaraZ.Fusion.Status()
    return xDTaraZ.State.Status.Fusion or ""
end

function xDTaraZ.Fusion.Start() end

function xDTaraZ.Fusion.Stop()
    local hum = xDTaraZ.Player.Humanoid
    if hum and not xDTaraZ.Player:Riding() then hum:UnequipTools() end
end

xDTaraZ.Economy = {
    Reserves = {},
    Plan = "",
    PendingUpgrade = nil,
    PendingRebirth = nil,
    UpgradeBlockedUntil = 0,
    RebirthBlockedUntil = 0,
}

---@return any  SavedData value, nil when not replicated yet
function xDTaraZ.Economy.Saved(name)
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local node = saved and saved:FindFirstChild(name)
    return node and node.Value
end

function xDTaraZ.Economy.Cash()
    return tonumber(xDTaraZ.Economy.Saved("Cash")) or 0
end

---@return number  cash per second, as the leaderboard shows it
function xDTaraZ.Economy.Income()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    local node = stats and stats:FindFirstChild("Income/s")
    return node and tonumber(node.Value) or 0
end

function xDTaraZ.Economy.Rebirths()
    return tonumber(xDTaraZ.Economy.Saved("Rebirths")) or 0
end

function xDTaraZ.Economy.HatchUpgrades()
    return tonumber(xDTaraZ.Economy.Saved("HatchUpgrades")) or 0
end

---@return integer  free luck packs not spent yet
function xDTaraZ.Economy.FreePacks()
    local free = tonumber(xDTaraZ.Economy.Saved("FreeHatchUpgrades")) or 0
    local used = tonumber(xDTaraZ.Economy.Saved("UsedFreeHatchUpgrades")) or 0
    return math.max(free - used, 0)
end

---@param n integer  upgrades already owned
---@return number    price of the next one
function xDTaraZ.Economy.UpgradePrice(n)
    local tier = math.floor(n / 5)
    return 5 + 10 * n + 50 * (5 * tier * (tier - 1) / 2 + tier * (n - 5 * tier + 1))
end

---@return number  hatch luck multiplier with the live event bonus
function xDTaraZ.Economy.LuckMult()
    local n = xDTaraZ.Economy.HatchUpgrades()
    local event = tonumber(ReplicatedStorage:GetAttribute("HatchLuckEventMultiplier")) or 1
    return (1 + n + 4 * math.floor(n / 5)) * event
end

---@param amount number|nil  nil or 0 clears the hold
function xDTaraZ.Economy.Reserve(owner, amount)
    if not amount or amount <= 0 then
        xDTaraZ.Economy.Reserves[owner] = nil
        return
    end
    xDTaraZ.Economy.Reserves[owner] = amount
end

---@return number  cash this owner may spend: keep floor and the other owners' holds removed
function xDTaraZ.Economy.Budget(owner)
    local budget = xDTaraZ.Economy.Cash() - (tonumber(xDTaraZ.Util.Opt("ShopKeepCash")) or 0)
    if not xDTaraZ.Util.Opt("SmartSpend") then return budget end

    for holder, amount in pairs(xDTaraZ.Economy.Reserves) do
        if holder ~= owner then budget -= amount end
    end
    return budget
end

---@return string|nil  name of the pet the next rebirth asks for, nil when every rebirth is done
function xDTaraZ.Economy.NextRequirement()
    local done = xDTaraZ.Economy.Rebirths()
    if done >= (xDTaraZ.GameLib.Rebirths.Cap or 0) then return nil end
    return xDTaraZ.GameLib.RebirthReq[done + 1]
end

---@return table|nil  first owned pet entry with that name
function xDTaraZ.Economy.OwnedPet(name)
    if not name then return nil end
    for _, pet in ipairs(xDTaraZ.Pets.Owned()) do
        if pet.name == name then return pet end
    end
    return nil
end

---@return table  { cost, pet, owned, ready, payback, reason }
function xDTaraZ.Economy.RebirthPlan()
    local done = xDTaraZ.Economy.Rebirths()
    local target = tonumber(xDTaraZ.Util.Opt("RebirthTarget")) or xDTaraZ.GameLib.Rebirths.Cap or 0
    local plan = { cost = math.huge, payback = math.huge }

    if done >= math.min(target, xDTaraZ.GameLib.Rebirths.Cap or 0) then
        plan.reason = "target reached"
        return plan
    end

    plan.cost = xDTaraZ.GameLib.Rebirths.Costs[done + 1] or math.huge
    plan.pet = xDTaraZ.Economy.NextRequirement()
    local owned = xDTaraZ.Economy.OwnedPet(plan.pet)
    plan.owned = owned ~= nil and xDTaraZ.Pets.Protected(owned) == true

    local gain = xDTaraZ.Economy.Income() / (1 + done)
    if gain > 0 then plan.payback = plan.cost / gain end

    if not plan.owned then
        plan.reason = "need " .. tostring(plan.pet)
    elseif xDTaraZ.Economy.Cash() < plan.cost then
        plan.reason = "saving"
    else
        plan.ready = true
    end
    return plan
end

---@return integer  levels to buy now, 0 when the next one is not worth it
function xDTaraZ.Economy.UpgradeCount(budget, income)
    local n = xDTaraZ.Economy.HatchUpgrades()
    local cap = income * xDTaraZ.Config.UpgradePayback
    local count, spent = 0, 0

    repeat
        local price = xDTaraZ.Economy.UpgradePrice(n + count)
        if price >= cap or spent + price > budget then break end
        spent += price
        count += 1
    until count >= xDTaraZ.Config.UpgradeMaxBuy
    return count
end

---@return boolean  true when every level cash could buy also passes the payback rule
function xDTaraZ.Economy.MaxIsSafe(count)
    if xDTaraZ.Util.Opt("SmartSpend") and next(xDTaraZ.Economy.Reserves) then return false end
    if (tonumber(xDTaraZ.Util.Opt("ShopKeepCash")) or 0) > 0 then return false end
    local n = xDTaraZ.Economy.HatchUpgrades() + count
    return xDTaraZ.Economy.UpgradePrice(n) > xDTaraZ.Economy.Cash()
end

---@return integer  levels asked for
function xDTaraZ.Economy.Upgrade()
    local remote = xDTaraZ.Net["Plot.Upgrades"]
    if not remote then return 0 end
    if LocalPlayer:GetAttribute("Setting_LuckMultiplier") == false then
        xDTaraZ.State.Status.Upgrade = "Luck upgrades are turned off in game settings"
        return 0
    end

    local before = xDTaraZ.Economy.HatchUpgrades()
    if xDTaraZ.Economy.FreePacks() > 0 then remote:FireServer("MaxFree") end

    local count = xDTaraZ.Economy.UpgradeCount(xDTaraZ.Economy.Budget("Upgrade"), xDTaraZ.Economy.Income())
    if count == 0 then return 0 end

    if xDTaraZ.Economy.MaxIsSafe(count) then
        remote:FireServer("Max")
    else
        for i = 1, math.min(count, xDTaraZ.Config.UpgradeBatch) do
            remote:FireServer()
            if i < count then task.wait(xDTaraZ.Config.UpgradeGap) end
        end
    end
    xDTaraZ.Economy.PendingUpgrade = { before, os.clock() + xDTaraZ.Config.UpgradeVerify }
    return count
end

---@return boolean  false while a check is still waiting or the last buy was refused
function xDTaraZ.Economy.VerifyUpgrade()
    local pending = xDTaraZ.Economy.PendingUpgrade
    if not pending then return true end
    if os.clock() < pending[2] then return false end

    xDTaraZ.Economy.PendingUpgrade = nil
    if xDTaraZ.Economy.HatchUpgrades() > pending[1] then return true end
    xDTaraZ.Economy.UpgradeBlockedUntil = os.clock() + xDTaraZ.Config.UpgradeBackoff
    return false
end

function xDTaraZ.Economy.UpgradeNow()
    local count = xDTaraZ.Economy.Upgrade()
    xDTaraZ.Util.Notify("Upgrades", count > 0 and ("Buying " .. count .. " luck levels") or "Nothing worth buying now")
end

---@return boolean  fired
function xDTaraZ.Economy.Rebirth(plan)
    local remote = xDTaraZ.Net.Rebirth
    if not (remote and plan.ready) then return false end
    if os.clock() < xDTaraZ.Economy.RebirthBlockedUntil or xDTaraZ.Economy.PendingRebirth then return false end
    if xDTaraZ.Eggs and xDTaraZ.Eggs.CarryCritical then return false end

    xDTaraZ.Economy.PendingRebirth = { xDTaraZ.Economy.Rebirths(), os.clock() + xDTaraZ.Config.RebirthVerify }
    remote:FireServer()
    return true
end

function xDTaraZ.Economy.VerifyRebirth()
    local pending = xDTaraZ.Economy.PendingRebirth
    if not pending or os.clock() < pending[2] then return end
    xDTaraZ.Economy.PendingRebirth = nil

    if xDTaraZ.Economy.Rebirths() > pending[1] then
        xDTaraZ.Economy.Reserve("Rebirth", nil)
        xDTaraZ.Util.Notify("Rebirth", "Rebirth " .. xDTaraZ.Economy.Rebirths() .. " done")
        return
    end
    xDTaraZ.Economy.RebirthBlockedUntil = os.clock() + xDTaraZ.Config.RebirthBackoff
    xDTaraZ.State.Status.Economy = "Rebirth refused, retry in 1 min"
end

function xDTaraZ.Economy.RebirthNow()
    local plan = xDTaraZ.Economy.RebirthPlan()
    if not xDTaraZ.Economy.Rebirth(plan) then
        xDTaraZ.Util.Notify("Rebirth", "Not ready: " .. tostring(plan.reason or "busy"))
    end
end

---@return boolean  true while cash is being saved for a rebirth that resets luck upgrades
function xDTaraZ.Economy.SaveForRebirth(plan)
    if not (xDTaraZ.Util.Opt("AutoRebirth") and xDTaraZ.Util.Opt("SmartSpend")) then
        xDTaraZ.Economy.Reserve("Rebirth", nil)
        return false
    end
    if not plan.owned or plan.cost == math.huge then
        xDTaraZ.Economy.Reserve("Rebirth", nil)
        return false
    end

    local income = math.max(xDTaraZ.Economy.Income(), 1)
    local wait = (plan.cost - xDTaraZ.Economy.Cash()) / income
    if wait > xDTaraZ.Config.RebirthSaveWindow then
        xDTaraZ.Economy.Reserve("Rebirth", nil)
        return false
    end
    xDTaraZ.Economy.Reserve("Rebirth", plan.cost)
    return true
end

function xDTaraZ.Economy.Step()
    xDTaraZ.Economy.VerifyRebirth()
    local plan = xDTaraZ.Economy.RebirthPlan()
    local saving = xDTaraZ.Economy.SaveForRebirth(plan)

    if xDTaraZ.Util.Opt("AutoRebirth") and plan.ready then
        xDTaraZ.Economy.Rebirth(plan)
        xDTaraZ.Economy.Plan = "Rebirthing"
    elseif saving then
        xDTaraZ.Economy.Plan = "Saving for rebirth (" .. xDTaraZ.Util.Format(plan.cost) .. ")"
    else
        xDTaraZ.Economy.Plan = plan.reason and ("Rebirth: " .. plan.reason) or ""
    end

    local upgradeOk = xDTaraZ.Economy.VerifyUpgrade() and os.clock() >= xDTaraZ.Economy.UpgradeBlockedUntil
    if xDTaraZ.Util.Opt("AutoUpgrade") and upgradeOk and not saving and not xDTaraZ.Economy.PendingRebirth then
        xDTaraZ.Economy.Upgrade()
    end
    xDTaraZ.State.Status.Economy = xDTaraZ.Economy.Status()
end

function xDTaraZ.Economy.Status()
    local luck = "Luck x" .. xDTaraZ.Util.Format(xDTaraZ.Economy.LuckMult())
    if xDTaraZ.Economy.Plan == "" then return luck end
    return luck .. " | " .. xDTaraZ.Economy.Plan
end

function xDTaraZ.Economy.Stop()
    table.clear(xDTaraZ.Economy.Reserves)
    xDTaraZ.Economy.PendingUpgrade = nil
    xDTaraZ.Economy.PendingRebirth = nil
end

xDTaraZ.Shop = {
    Stock = nil,
    StockAt = 0,
    Signature = nil,
    LastCheck = 0,
    Conn = nil,
    Bought = 0,
}

---@return string[]  "Category/Item" labels for the picker, cheapest first
function xDTaraZ.Shop.Labels()
    local labels = {}
    for _, entry in ipairs(xDTaraZ.GameLib.ShopItems) do
        labels[#labels + 1] = entry.cat .. "/" .. entry.item
    end
    return labels
end

---@return number  price from game data, math.huge when unknown
function xDTaraZ.Shop.Price(category, item)
    for _, entry in ipairs(xDTaraZ.GameLib.ShopItems) do
        if entry.cat == category and entry.item == item then return entry.price end
    end
    return math.huge
end

function xDTaraZ.Shop.Bind()
    if xDTaraZ.Shop.Conn then return end
    local restock = xDTaraZ.GameLib.Listen("Restock")
    if not restock then return end
    xDTaraZ.Shop.Conn = xDTaraZ:Connect(restock.OnClientEvent, function(stock)
        if type(stock) ~= "table" then return end
        xDTaraZ.Shop.Stock = stock
        xDTaraZ.Shop.StockAt = os.clock()
    end)
end

---@return string  restock timestamps joined; changes when the shop restocks
function xDTaraZ.Shop.RestockSignature()
    local serverData = ReplicatedStorage:FindFirstChild("ServerData")
    if not serverData then return "" end

    local parts = {}
    for name, value in pairs(serverData:GetAttributes()) do
        if name:find("LastRestockTime", 1, true) then table.insert(parts, name .. "=" .. tostring(value)) end
    end
    for _, child in ipairs(serverData:GetChildren()) do
        if child.Name:find("LastRestockTime", 1, true) and child:IsA("ValueBase") then
            table.insert(parts, child.Name .. "=" .. tostring(child.Value))
        end
    end
    table.sort(parts)
    return table.concat(parts, ";")
end

---@return table|nil  stock[cat][item] = { Amount }, nil when the server did not answer
function xDTaraZ.Shop.ReadStock()
    local request = xDTaraZ.Net.ShopStock
    if not request then return nil end
    xDTaraZ.Shop.Bind()

    local asked = os.clock()
    request:FireServer()
    local deadline = asked + xDTaraZ.Config.ShopReplyTimeout
    repeat
        if xDTaraZ.Shop.StockAt >= asked then return xDTaraZ.Shop.Stock end
        task.wait(0.05)
    until os.clock() > deadline
    return nil
end

---@return integer  units fired
function xDTaraZ.Shop.Buy()
    local wanted = xDTaraZ.Util.Opt("ShopItems")
    local buy = xDTaraZ.Net.BuyWithCash
    if type(wanted) ~= "table" or not next(wanted) or not buy then return 0 end

    local stock = xDTaraZ.Shop.ReadStock()
    if not stock then return 0 end

    local budget, fired = xDTaraZ.Economy.Budget("Shop"), 0
    for label, on in pairs(wanted) do
        if not on then continue end
        local category, item = label:match("^(.-)/(.+)$")
        local slot = category and type(stock[category]) == "table" and stock[category][item]
        local amount = type(slot) == "table" and tonumber(slot.Amount) or 0
        local price = xDTaraZ.Shop.Price(category, item)

        for _ = 1, amount do
            if budget < price then break end
            buy:FireServer(category, item)
            budget -= price
            fired += 1
            task.wait(xDTaraZ.Config.ShopBuyGap)
        end
    end
    xDTaraZ.Shop.Bought += fired
    return fired
end

function xDTaraZ.Shop.BuyNow()
    local fired = xDTaraZ.Shop.Buy()
    xDTaraZ.Util.Notify("Shop", fired > 0 and ("Bought " .. fired .. " items") or "Nothing to buy in stock")
end

function xDTaraZ.Shop.Step()
    if not xDTaraZ.Util.Opt("AutoShop") then return end
    local signature = xDTaraZ.Shop.RestockSignature()
    local stale = os.clock() - xDTaraZ.Shop.LastCheck >= xDTaraZ.Config.ShopRecheck
    if signature == xDTaraZ.Shop.Signature and not stale then return end

    xDTaraZ.Shop.Signature = signature
    xDTaraZ.Shop.LastCheck = os.clock()
    xDTaraZ.Shop.Buy()
    xDTaraZ.State.Status.Shop = "Bought " .. xDTaraZ.Shop.Bought .. " this session"
end

function xDTaraZ.Shop.Stop()
    xDTaraZ.Shop.Signature = nil
    xDTaraZ.Shop.LastCheck = 0
end

xDTaraZ.Rewards = {
    OfflineDone = false,
    PromptAt = {},
    PendingIndex = nil,
    IndexBlockedUntil = 0,
}

---@return integer  game pets found in OwnedPets, counted the way the index does
function xDTaraZ.Rewards.IndexCount()
    local owned = tostring(xDTaraZ.Economy.Saved("OwnedPets") or "")
    if owned == "" then return 0 end

    local count = 0
    for name in pairs(xDTaraZ.GameLib.PetInfo) do
        if owned:find(name .. ",", 1, true) then count += 1 end
    end
    return count
end

---@return table|nil  next unclaimed stage { goal, reward } when its goal is met
function xDTaraZ.Rewards.IndexReady()
    local stage = tonumber(xDTaraZ.Economy.Saved("IndexRewardStage")) or 0
    local nextStage = xDTaraZ.GameLib.IndexStages[stage + 1]
    if not nextStage then return nil end
    if xDTaraZ.Rewards.IndexCount() < nextStage.goal then return nil end
    return nextStage
end

---@return boolean  fired
function xDTaraZ.Rewards.ClaimIndex()
    local remote = xDTaraZ.Net.ClaimIndexReward
    if not remote or os.clock() < xDTaraZ.Rewards.IndexBlockedUntil then return false end
    if not xDTaraZ.Rewards.IndexReady() then return false end

    local stage = tonumber(xDTaraZ.Economy.Saved("IndexRewardStage")) or 0
    remote:FireServer()
    task.delay(xDTaraZ.Config.ClaimVerify, function()
        local now = tonumber(xDTaraZ.Economy.Saved("IndexRewardStage")) or 0
        if now <= stage then xDTaraZ.Rewards.IndexBlockedUntil = os.clock() + xDTaraZ.Config.PromptRetry end
    end)
    return true
end

---@return boolean  fired
function xDTaraZ.Rewards.ClaimOffline()
    local remote = xDTaraZ.Net.OfflineEarnings
    if not remote or xDTaraZ.Rewards.OfflineDone then return false end
    if (tonumber(LocalPlayer:GetAttribute("OfflineSeconds")) or 0) <= 0 then return false end

    xDTaraZ.Rewards.OfflineDone = true
    remote:FireServer()
    return true
end

---@return ProximityPrompt|nil
function xDTaraZ.Rewards.FindPrompt(holder)
    local functionals = Workspace:FindFirstChild("Functionals")
    local model = functionals and functionals:FindFirstChild(holder)
    local handle = model and model:FindFirstChild("Handle")
    local prompt = handle and handle:FindFirstChild("Claim")
    if prompt and prompt:IsA("ProximityPrompt") and prompt.Enabled then return prompt end
    return nil
end

---@return boolean  triggered, through the executor or a hold while in range
function xDTaraZ.Rewards.TriggerPrompt(prompt)
    if Library and Library.Compat and Library.Compat.Caps.Prompt then
        return (pcall(fireproximityprompt, prompt))
    end

    local root = xDTaraZ.Player.Root
    local part = prompt.Parent
    if not (root and part and part:IsA("BasePart")) then return false end
    if (root.Position - part.Position).Magnitude > prompt.MaxActivationDistance then return false end

    prompt:InputHoldBegin()
    task.wait(prompt.HoldDuration + 0.05)
    prompt:InputHoldEnd()
    return true
end

---@return boolean  group reward cooldown is over (or never claimed)
function xDTaraZ.Rewards.GroupReady()
    local last = tonumber(LocalPlayer:GetAttribute("GroupRewardClaimTime"))
    if not last then return true end
    return os.time() - last >= xDTaraZ.Config.GroupRewardCooldown
end

---@return integer  prompts triggered
function xDTaraZ.Rewards.ClaimPrompts(force)
    local fired = 0
    local list = {
        { "EventBoost", true },
        { "Meat", xDTaraZ.Rewards.GroupReady() },
    }

    for _, pair in ipairs(list) do
        local holder, ready = pair[1], pair[2]
        local due = force or os.clock() - (xDTaraZ.Rewards.PromptAt[holder] or -math.huge) >= xDTaraZ.Config.PromptRetry
        if not (ready and due) then continue end

        local prompt = xDTaraZ.Rewards.FindPrompt(holder)
        if not prompt then continue end
        xDTaraZ.Rewards.PromptAt[holder] = os.clock()
        if xDTaraZ.Rewards.TriggerPrompt(prompt) then fired += 1 end
    end
    return fired
end

---@return integer  claims fired
function xDTaraZ.Rewards.Claim(force)
    local fired = 0
    if xDTaraZ.Rewards.ClaimIndex() then fired += 1 end
    if xDTaraZ.Rewards.ClaimOffline() then fired += 1 end
    fired += xDTaraZ.Rewards.ClaimPrompts(force)
    return fired
end

function xDTaraZ.Rewards.ClaimNow()
    local fired = xDTaraZ.Rewards.Claim(true)
    xDTaraZ.Util.Notify("Rewards", fired > 0 and ("Claimed " .. fired .. " rewards") or "Nothing to claim right now")
end

function xDTaraZ.Rewards.Step()
    if not xDTaraZ.Util.Opt("AutoClaim") then return end
    xDTaraZ.Rewards.Claim(false)

    local nextStage = xDTaraZ.GameLib.IndexStages[(tonumber(xDTaraZ.Economy.Saved("IndexRewardStage")) or 0) + 1]
    if nextStage then
        xDTaraZ.State.Status.Rewards = "Index " .. xDTaraZ.Rewards.IndexCount() .. "/" .. nextStage.goal
    else
        xDTaraZ.State.Status.Rewards = "Index complete"
    end
end

function xDTaraZ.Rewards.Stop()
    table.clear(xDTaraZ.Rewards.PromptAt)
end

xDTaraZ.Boosts = {
    Last = {},
    Lines = {},
    Primed = false,
}

---@return string|nil  readable line, nil when the boost is not running
function xDTaraZ.Boosts.Describe(name, value)
    if value == nil then return nil end
    local now = xDTaraZ.Util.ServerNow()

    if name:sub(-5) == "Until" then
        local left = (tonumber(value) or 0) - now
        if left <= 0 then return nil end
        return name:gsub("Until$", "") .. ": " .. math.floor(left / 60) .. "m left"
    end

    local amount = tonumber(value)
    if not amount or amount <= 1 then return nil end
    return name .. ": x" .. amount
end

---@return table  { name = line } of running boosts
function xDTaraZ.Boosts.Read()
    local running = {}
    for _, name in ipairs(xDTaraZ.Config.BoostAttributes) do
        running[name] = xDTaraZ.Boosts.Describe(name, ReplicatedStorage:GetAttribute(name))
    end
    running.EventBoostUntil = xDTaraZ.Boosts.Describe("EventBoostUntil", LocalPlayer:GetAttribute("EventBoostUntil"))

    local serverData = ReplicatedStorage:FindFirstChild("ServerData")
    local weather = serverData and serverData:GetAttribute("ActiveWeathers")
    local names = xDTaraZ.Boosts.WeatherNames(weather)
    if names then running.Weather = "Weather: " .. names end
    return running
end

---@param raw any     ServerData ActiveWeathers JSON
---@return string|nil  "Storm, Rain", nil when clear or unreadable
function xDTaraZ.Boosts.WeatherNames(raw)
    if type(raw) ~= "string" or raw == "" then return nil end
    local ok, list = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok then
        warn(xDTaraZ.Config.Tag, "weather decode:", list)
        return nil
    end
    if type(list) ~= "table" then return nil end

    local names = {}
    for _, entry in pairs(list) do
        local kind = type(entry) == "table" and entry.Type or entry
        local variant = type(entry) == "table" and entry.Variant
        if type(variant) == "string" and variant ~= "" then kind = tostring(kind) .. " (" .. variant .. ")" end
        if type(kind) == "string" and not table.find(names, kind) then names[#names + 1] = kind end
    end
    return #names > 0 and table.concat(names, ", ") or nil
end

function xDTaraZ.Boosts.Announce(name, line)
    xDTaraZ.Util.Notify("Boost", line, 8)
    local webhook = rawget(xDTaraZ, "Webhook")
    if not (webhook and webhook.Push) then return end
    xDTaraZ.Util.Try("boost webhook", webhook.Push, { Kind = "Boost", Title = name, Lines = { line } })
end

function xDTaraZ.Boosts.Step()
    local running = xDTaraZ.Boosts.Read()
    local lines = {}

    for name, line in pairs(running) do
        table.insert(lines, line)
        if xDTaraZ.Boosts.Primed and not xDTaraZ.Boosts.Last[name] then xDTaraZ.Boosts.Announce(name, line) end
    end
    table.sort(lines)

    xDTaraZ.Boosts.Last = running
    xDTaraZ.Boosts.Primed = true
    xDTaraZ.Boosts.Lines = lines
    xDTaraZ.State.Weather = running.Weather and { running.Weather } or {}
    xDTaraZ.State.Status.Boosts = #lines > 0 and table.concat(lines, "\n") or "No boosts running"
end

function xDTaraZ.Boosts.Stop()
    table.clear(xDTaraZ.Boosts.Last)
    xDTaraZ.Boosts.Primed = false
end

do
    local defaults = {
        WalkSpeed = 60, JumpPower = 80, FlySpeed = 120,
        FlingSpin = 2000, FlingForce = 9e4, StickOffset = 2,
        StandLift = 3, StreamTimeout = 5,
        EspLift = 4, EspPool = 48,
        FloatSize = 52, FloatGap = 8,
        ReconnectDelay = 5, ReconnectRetry = 10, ReconnectTries = 6, ReconnectMax = 3, ReconnectWindow = 600,
        ReconnectFile = "MarioHub_RideAPet_reconnect.txt",
        HopPick = 15, ServerListUrl = "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
        ReloadSource = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/loader.lua"))()',
        RarityColors = {
            Common = Color3.fromRGB(200, 200, 200), Rare = Color3.fromRGB(90, 170, 255), Epic = Color3.fromRGB(190, 110, 255),
            Legendary = Color3.fromRGB(255, 200, 60), Mythic = Color3.fromRGB(255, 90, 90), Divine = Color3.fromRGB(120, 255, 220),
            Ethereal = Color3.fromRGB(255, 130, 230),
        },
    }
    for key, value in pairs(defaults) do
        if Config[key] == nil then Config[key] = value end
    end
end

xDTaraZ.World = { Conn = nil, Gui = nil }

---@return Instance  hidden gui root, CoreGui or PlayerGui when gethui is missing
function xDTaraZ.World.GuiRoot()
    local caps = Library and Library.Compat and Library.Compat.Caps
    if caps and caps.Hui then
        local ok, hui = pcall(gethui)
        if ok and typeof(hui) == "Instance" then return hui end
    end
    local ok, core = pcall(function() return game:GetService("CoreGui") end)
    if ok and core and pcall(function() return core.Name end) then return core end
    return LocalPlayer:WaitForChild("PlayerGui", Config.LoadTimeout)
end

function xDTaraZ.World.Screen()
    local gui = xDTaraZ.World.Gui
    if gui and gui.Parent then return gui end

    gui = Instance.new("ScreenGui")
    gui.Name = "MarioWorld"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local ok = pcall(function() gui.Parent = xDTaraZ.World.GuiRoot() end)
    if not ok then gui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") end
    xDTaraZ.World.Gui = gui
    return gui
end

---@return boolean  any per-frame movement or troll option is on
function xDTaraZ.World.NeedsFrame()
    local opt = xDTaraZ.Util.Opt
    return opt("SpeedOn") or opt("JumpOn") or opt("Fly") or opt("NoClip") or opt("Fling") or opt("Stick") or false
end

function xDTaraZ.World.Sync()
    local world = xDTaraZ.World
    if world.NeedsFrame() then
        if world.Conn then return end
        world.Conn = xDTaraZ:Connect(RunService.Heartbeat, function(dt)
            xDTaraZ.Util.Try("Move.Frame", xDTaraZ.Move.Frame, dt)
            xDTaraZ.Util.Try("Troll.Frame", xDTaraZ.Troll.Frame)
        end)
        return
    end
    if world.Conn then
        world.Conn:Disconnect()
        world.Conn = nil
    end
end

function xDTaraZ.World.Carrying()
    return xDTaraZ.Player:BasketCount() > 0
end

xDTaraZ.Teleport = {}

---@return CFrame  a standing spot on top of a part
local function Above(part)
    return CFrame.new(part.Position + Vector3.new(0, part.Size.Y / 2 + Config.StandLift, 0))
end

---@return table<string, function>  label -> CFrame getter
function xDTaraZ.Teleport.Places()
    local places = {}
    places["My Plot"] = function()
        local _, bp = xDTaraZ.Player:Plot()
        return bp and Above(bp)
    end

    local spawns = Workspace:FindFirstChild("EggSpawns")
    local seen = {}
    for _, pad in ipairs(spawns and spawns:GetChildren() or {}) do
        if not pad:IsA("BasePart") then continue end
        local rarity = pad.Name:gsub("%-+$", "")
        seen[rarity] = (seen[rarity] or 0) + 1
        places["Eggs: " .. rarity .. " #" .. seen[rarity]] = function() return Above(pad) end
    end

    for _, folderName in ipairs({ "Stalls", "Functionals" }) do
        local folder = Workspace:FindFirstChild(folderName)
        for _, spot in ipairs(folder and folder:GetChildren() or {}) do
            if not (spot:IsA("Model") or spot:IsA("BasePart")) then continue end
            if spot.Name:find("^AlwaysStream") then continue end
            places[folderName .. ": " .. spot.Name] = function()
                return spot:GetPivot() + Vector3.new(0, Config.StandLift, 0)
            end
        end
    end

    local plots = Workspace:FindFirstChild("Plots")
    for _, plot in ipairs(plots and plots:GetChildren() or {}) do
        local owner = plot:FindFirstChild("Data") and plot.Data:FindFirstChild("Owner")
        local player = owner and owner.Value
        local bp = plot:FindFirstChild("Baseplate")
        if not bp or not player or player == LocalPlayer then continue end
        places["Plot: " .. player.Name] = function() return Above(bp) end
    end

    places["Volcano"] = xDTaraZ.Teleport.VolcanoSpot
    return places
end

---@return CFrame|nil  top of the volcano once it streams in, else its centre
function xDTaraZ.Teleport.VolcanoSpot()
    local center = Config.VolcanoCenter
    pcall(LocalPlayer.RequestStreamAroundAsync, LocalPlayer, center, Config.StreamTimeout)

    local tagged = game:GetService("CollectionService"):GetTagged("VolcanoTop")
    for _, part in ipairs(tagged) do
        if part:IsA("BasePart") then return Above(part) end
    end
    return CFrame.new(center)
end

---@return string[]  sorted; egg pads by rarity order
function xDTaraZ.Teleport.PlaceNames()
    local rank = GameLib.RarityRank
    local names = {}
    for name in pairs(xDTaraZ.Teleport.Places()) do
        names[#names + 1] = name
    end

    table.sort(names, function(a, b)
        local ra = rank[a:match("^Eggs: (.-) #") or ""] or 0
        local rb = rank[b:match("^Eggs: (.-) #") or ""] or 0
        if ra ~= rb then return ra < rb end
        return a < b
    end)
    return names
end

---@return boolean  moved; refused while an egg is carried or another task drives
function xDTaraZ.Teleport.Go(cf)
    if not cf then return false end
    if xDTaraZ.World.Carrying() then
        xDTaraZ.Util.Notify("Teleport", "Finish the egg delivery first")
        return false
    end

    local token = xDTaraZ.Tasks.Request("Manual", xDTaraZ.Tasks.Prio.Manual)
    if not token then
        xDTaraZ.Util.Notify("Teleport", "Busy with farming, try again in a moment")
        return false
    end
    token.home = nil
    local moved = xDTaraZ.Tasks.Teleport(token, cf)
    xDTaraZ.Tasks.Release(token)
    return moved
end

function xDTaraZ.Teleport.To(name)
    local getter = xDTaraZ.Teleport.Places()[name or ""]
    if not getter then return false end
    return xDTaraZ.Teleport.Go(getter())
end

function xDTaraZ.Teleport.ToPlayer(name)
    local target = Players:FindFirstChild(name or "")
    if not target or target == LocalPlayer then return false end
    local hrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        xDTaraZ.Util.Notify("Teleport", target.Name .. " is too far to see right now")
        return false
    end
    return xDTaraZ.Teleport.Go(hrp.CFrame + Vector3.new(0, Config.StandLift, 0))
end

function xDTaraZ.Teleport.Home()
    return xDTaraZ.Teleport.To("My Plot")
end

xDTaraZ.Move = { Saved = {}, Patched = {}, Parts = {}, PartsOf = nil, Conns = {}, Floats = {}, FlyWarned = false }

---@param idx string   option id
---@param on  boolean
function xDTaraZ.Move.Set(idx, on)
    xDTaraZ.Options[idx] = on
    local move = xDTaraZ.Move
    local hum = xDTaraZ.Player.Humanoid

    if on and hum then
        if idx == "SpeedOn" and move.Saved.WalkSpeed == nil then move.Saved.WalkSpeed = hum.WalkSpeed end
        if idx == "JumpOn" and move.Saved.JumpPower == nil then
            move.Saved.JumpPower, move.Saved.UseJumpPower = hum.JumpPower, hum.UseJumpPower
        end
    end
    if idx == "InfJump" then move.BindJump(on) end
    if idx == "AntiAfk" then move.BindIdle(on) end
    if not on then move.Restore(idx) end
    xDTaraZ.World.Sync()
end

function xDTaraZ.Move.BindJump(on)
    local move = xDTaraZ.Move
    if move.Conns.Jump then
        move.Conns.Jump:Disconnect()
        move.Conns.Jump = nil
    end
    if not on then return end

    move.Conns.Jump = xDTaraZ:Connect(UserInputService.JumpRequest, function()
        local hum = xDTaraZ.Player.Humanoid
        if hum and hum.Health > 0 then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
end

function xDTaraZ.Move.BindIdle(on)
    local move = xDTaraZ.Move
    if move.Conns.Idle then
        move.Conns.Idle:Disconnect()
        move.Conns.Idle = nil
    end
    if not on then return end

    move.Conns.Idle = xDTaraZ:Connect(LocalPlayer.Idled, function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end)
end

---@return BasePart[]  character parts, rebuilt only when the character changes
function xDTaraZ.Move.CharParts()
    local move, char = xDTaraZ.Move, xDTaraZ.Player.Char
    if move.PartsOf == char then return move.Parts end

    table.clear(move.Parts)
    move.PartsOf = char
    for _, part in ipairs(char and char:GetDescendants() or {}) do
        if part:IsA("BasePart") then move.Parts[#move.Parts + 1] = part end
    end
    return move.Parts
end

function xDTaraZ.Move.NoClip(on)
    local patched = xDTaraZ.Move.Patched
    if not on then
        for part in pairs(patched) do
            if part.Parent then part.CanCollide = true end
        end
        table.clear(patched)
        return
    end

    for _, part in ipairs(xDTaraZ.Move.CharParts()) do
        if part.Parent and part.CanCollide then
            patched[part] = true
            part.CanCollide = false
        end
    end
end

---@return Vector3  wanted direction from keys or the touch stick
function xDTaraZ.Move.FlyDirection(hum, cam)
    local look = cam.CFrame.LookVector
    local dir = hum.MoveDirection
    if dir.Magnitude > 0 then
        local flat = Vector3.new(look.X, 0, look.Z)
        local forward = flat.Magnitude > 0 and dir:Dot(flat.Unit) or 0
        dir += Vector3.new(0, look.Y * forward, 0)
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.yAxis end
    return dir
end

function xDTaraZ.Move.FlyStep(dt)
    local hrp, hum = xDTaraZ.Player.Root, xDTaraZ.Player.Humanoid
    local cam = Workspace.CurrentCamera
    if not hrp or not hum or not cam then return end

    if xDTaraZ.World.Carrying() or xDTaraZ.Tasks.Owner() then
        if not xDTaraZ.Move.FlyWarned and xDTaraZ.World.Carrying() then
            xDTaraZ.Move.FlyWarned = true
            xDTaraZ.Util.Notify("Fly", "Fly pauses while you carry an egg")
        end
        return
    end
    xDTaraZ.Move.FlyWarned = false

    hrp.AssemblyLinearVelocity = Vector3.zero
    local dir = xDTaraZ.Move.FlyDirection(hum, cam)
    if dir.Magnitude == 0 then return end
    hrp.CFrame += dir.Unit * (tonumber(xDTaraZ.Util.Opt("FlySpeed")) or Config.FlySpeed) * dt
end

function xDTaraZ.Move.Frame(dt)
    local opt = xDTaraZ.Util.Opt
    local hum = xDTaraZ.Player.Humanoid

    if opt("NoClip") or opt("Fly") or opt("Fling") then xDTaraZ.Move.NoClip(true) end
    if opt("Fly") then xDTaraZ.Move.FlyStep(dt) end
    if not hum then return end

    if opt("SpeedOn") then hum.WalkSpeed = tonumber(opt("WalkSpeed")) or Config.WalkSpeed end
    if opt("JumpOn") then
        hum.UseJumpPower = true
        hum.JumpPower = tonumber(opt("JumpPower")) or Config.JumpPower
    end
end

---@param idx string|nil  option that turned off; nil restores everything
function xDTaraZ.Move.Restore(idx)
    local move, opt = xDTaraZ.Move, xDTaraZ.Util.Opt
    local hum, hrp = xDTaraZ.Player.Humanoid, xDTaraZ.Player.Root

    if hum and (idx == nil or idx == "SpeedOn") and move.Saved.WalkSpeed then
        hum.WalkSpeed = move.Saved.WalkSpeed
        move.Saved.WalkSpeed = nil
    end
    if hum and (idx == nil or idx == "JumpOn") and move.Saved.JumpPower then
        hum.JumpPower = move.Saved.JumpPower
        hum.UseJumpPower = move.Saved.UseJumpPower
        move.Saved.JumpPower, move.Saved.UseJumpPower = nil, nil
    end

    if idx == nil or not (opt("NoClip") or opt("Fly") or opt("Fling")) then move.NoClip(false) end
    if (idx == nil or idx == "Fly") and hrp then hrp.AssemblyLinearVelocity = Vector3.zero end

    if idx == nil then
        move.BindJump(false)
        move.BindIdle(false)
        move.ClearFloats()
        xDTaraZ.Esp.Clear()
        if xDTaraZ.World.Gui then
            xDTaraZ.World.Gui:Destroy()
            xDTaraZ.World.Gui = nil
        end
        if xDTaraZ.World.Conn then
            xDTaraZ.World.Conn:Disconnect()
            xDTaraZ.World.Conn = nil
        end
    end
end

---@param list table  { {idx, text}, ... } toggles that get a draggable touch button
function xDTaraZ.Move.BuildFloats(list)
    if not xDTaraZ.Platform.Touch then return end
    local move = xDTaraZ.Move
    move.ClearFloats()

    local screen = xDTaraZ.World.Screen()
    local size, gap = Config.FloatSize, Config.FloatGap
    for i, row in ipairs(list) do
        local button = move.FloatButton(screen, row[1], row[2])
        button.Position = UDim2.new(1, -(size + gap) * 2, 0.3, (i - 1) * (size + gap))
        table.insert(move.Floats, button)
    end
end

---@return TextButton
function xDTaraZ.Move.FloatButton(screen, idx, text)
    local button = Instance.new("TextButton")
    button.Name = "Float_" .. idx
    button.Size = UDim2.fromOffset(Config.FloatSize, Config.FloatSize)
    button.BackgroundColor3 = Color3.fromRGB(27, 21, 18)
    button.BackgroundTransparency = 0.25
    button.TextColor3 = Color3.fromRGB(232, 160, 76)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.Text = text
    button.Active = true
    button.Draggable = true
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)
    button.Parent = screen

    local pressedAt
    button.MouseButton1Down:Connect(function() pressedAt = button.AbsolutePosition end)
    button.MouseButton1Up:Connect(function()
        if pressedAt and (button.AbsolutePosition - pressedAt).Magnitude > 6 then return end
        local option = Library and Library.Options and Library.Options[idx]
        if option then option:SetValue(not option.Value) end
    end)
    return button
end

function xDTaraZ.Move.ClearFloats()
    for _, button in ipairs(xDTaraZ.Move.Floats) do
        button:Destroy()
    end
    table.clear(xDTaraZ.Move.Floats)
end

xDTaraZ.Troll = { Token = nil, Home = nil }

function xDTaraZ.Troll.TargetRoot()
    local target = Players:FindFirstChild(xDTaraZ.Util.Opt("TrollTarget") or "")
    if not target or target == LocalPlayer then return nil end
    return target.Character and target.Character:FindFirstChild("HumanoidRootPart")
end

---@param idx string  "Fling" | "Stick"
function xDTaraZ.Troll.Set(idx, on)
    xDTaraZ.Options[idx] = on
    if on and xDTaraZ.World.Carrying() then
        xDTaraZ.Util.Notify("Troll", "Finish the egg delivery first")
        table.insert(State.PendingToggleOff, idx)
        xDTaraZ.Options[idx] = false
        return
    end
    if not on then xDTaraZ.Troll.Stop(idx) end
    xDTaraZ.World.Sync()
end

---@return table|nil  manual task token, nil while farming drives the character
function xDTaraZ.Troll.Hold()
    local troll = xDTaraZ.Troll
    if troll.Token and xDTaraZ.Tasks.Holds(troll.Token) then return troll.Token end
    troll.Token = nil
    if xDTaraZ.World.Carrying() then return nil end

    local token = xDTaraZ.Tasks.Request("Troll", xDTaraZ.Tasks.Prio.Manual)
    if not token then return nil end
    token.home = nil
    troll.Token = token
    return token
end

function xDTaraZ.Troll.Frame()
    local opt = xDTaraZ.Util.Opt
    if not opt("Fling") and not opt("Stick") then return end
    local target, hrp = xDTaraZ.Troll.TargetRoot(), xDTaraZ.Player.Root
    if not target or not hrp then return end
    if not xDTaraZ.Troll.Hold() then return end

    xDTaraZ.Troll.Home = xDTaraZ.Troll.Home or hrp.CFrame
    if opt("Fling") then
        local spin = math.rad(os.clock() * Config.FlingSpin % 360)
        hrp.CFrame = target.CFrame * CFrame.Angles(0, spin, 0)
        hrp.AssemblyLinearVelocity = Vector3.new(0, Config.FlingForce, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, Config.FlingForce, 0)
        return
    end
    hrp.CFrame = target.CFrame * CFrame.new(0, 0, Config.StickOffset)
end

---@param idx string|nil  toggle that turned off; nil on unload
function xDTaraZ.Troll.Stop(idx)
    local troll, hrp = xDTaraZ.Troll, xDTaraZ.Player.Root
    if hrp then
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end
    if idx then xDTaraZ.Move.Restore(idx) end
    local opt = xDTaraZ.Util.Opt
    if idx and (opt("Fling") or opt("Stick")) then return end

    local token = troll.Token
    troll.Token = nil
    if token and xDTaraZ.Tasks.Holds(token) then
        if troll.Home then xDTaraZ.Tasks.Teleport(token, troll.Home) end
        xDTaraZ.Tasks.Release(token)
    end
    troll.Home = nil
    if idx == nil then xDTaraZ.Troll.Spectate(nil) end
end

---@param name string|nil  nil returns the camera to us
function xDTaraZ.Troll.Spectate(name)
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local target = name and Players:FindFirstChild(name)
    local hum = target and target.Character and target.Character:FindFirstChildOfClass("Humanoid")
    cam.CameraSubject = hum or xDTaraZ.Player.Humanoid

    local troll = xDTaraZ.Troll
    if troll.LeaveConn then
        troll.LeaveConn:Disconnect()
        troll.LeaveConn = nil
    end
    if not hum then return end
    troll.LeaveConn = xDTaraZ:Connect(Players.PlayerRemoving, function(player)
        if player == target then xDTaraZ.Troll.Spectate(nil) end
    end)
end

xDTaraZ.Server = { Hopping = false }

function xDTaraZ.Server.QueueReload()
    return xDTaraZ.Util.Queue(Config.ReloadSource)
end

---@return boolean  teleport started
function xDTaraZ.Server.Rejoin()
    if xDTaraZ.World.Carrying() then
        xDTaraZ.Util.Notify("Server", "Finish the egg delivery first")
        return false
    end
    xDTaraZ.Server.QueueReload()
    local ok, err = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, game.JobId, LocalPlayer)
    if not ok then warn(Config.Tag, "rejoin:", err) end
    return ok
end

---@return string[]  open public server ids other than ours
function xDTaraZ.Server.OpenServers()
    local body = xDTaraZ.Util.HttpGet(Config.ServerListUrl:format(game.PlaceId))
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, body or "")
    local open = {}
    if not ok or type(decoded) ~= "table" then return open end

    for _, server in ipairs(decoded.data or {}) do
        local playing, cap = tonumber(server.playing) or 0, tonumber(server.maxPlayers) or 0
        if server.id ~= game.JobId and playing < cap then table.insert(open, server.id) end
    end
    return open
end

---@return boolean  teleport started
function xDTaraZ.Server.Hop()
    local server = xDTaraZ.Server
    if server.Hopping then return false end
    if xDTaraZ.World.Carrying() then
        xDTaraZ.Util.Notify("Server", "Finish the egg delivery first")
        return false
    end

    server.Hopping = true
    task.delay(Config.LoadTimeout, function() server.Hopping = false end)
    server.QueueReload()

    local open = server.OpenServers()
    local ok, err
    if #open > 0 then
        local pick = open[math.random(1, math.min(#open, Config.HopPick))]
        ok, err = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, pick, LocalPlayer)
    else
        ok, err = pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
    end
    if not ok then warn(Config.Tag, "hop:", err) end
    return ok
end

xDTaraZ.Server.IdleKeepers = { "AntiAfk", "AutoEggs", "EggHunter", "Kaitun" }

---@return boolean  under the cap, so a kick loop cannot rejoin forever
function xDTaraZ.Server.ReconnectBudget()
    if not (Library and Library.Compat and Library.Compat.Caps.FileSystem) then return true end
    local now, recent = os.time(), {}
    local ok, raw = pcall(readfile, Config.ReconnectFile)
    for stamp in (ok and tostring(raw) or ""):gmatch("%d+") do
        if now - tonumber(stamp) < Config.ReconnectWindow then recent[#recent + 1] = stamp end
    end
    if #recent >= Config.ReconnectMax then return false end
    recent[#recent + 1] = tostring(now)
    local wrote, err = pcall(writefile, Config.ReconnectFile, table.concat(recent, ","))
    if not wrote then warn(Config.Tag, "reconnect log:", err) end
    return true
end

function xDTaraZ.Server.OnError()
    local server = xDTaraZ.Server
    local message = GuiService:GetErrorMessage()
    if server.Reconnecting or message == "" or not xDTaraZ.Util.Opt("AutoReconnect") then return end
    if message:lower():find("ban") then return end
    server.Reconnecting = true

    task.delay(Config.ReconnectDelay, function()
        if not server.ReconnectBudget() then
            warn(Config.Tag, "reconnect: too many disconnects, staying out")
            return
        end
        server.QueueReload()
        for _ = 1, Config.ReconnectTries do
            local ok, err = pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
            if not ok then warn(Config.Tag, "reconnect:", err) end
            task.wait(Config.ReconnectRetry)
        end
    end)
end

function xDTaraZ.Server.Step()
    local server = xDTaraZ.Server
    if not server.ErrorConn and xDTaraZ.Util.Opt("AutoReconnect") then
        server.ErrorConn = xDTaraZ:Connect(GuiService.ErrorMessageChanged, server.OnError)
    end

    local want = false
    for _, idx in ipairs(xDTaraZ.Server.IdleKeepers) do
        if xDTaraZ.Util.Opt(idx) then want = true break end
    end
    if want ~= (xDTaraZ.Move.Conns.Idle ~= nil) then xDTaraZ.Move.BindIdle(want) end
end

function xDTaraZ.Server.Stop()
    xDTaraZ.Server.Hopping = false
end

xDTaraZ.Esp = { Boards = {}, Pool = {}, Anchors = {}, Made = {} }

---@return Color3  preset, or a hue by rank for rarities the game adds later
function xDTaraZ.Esp.Color(rarity)
    local preset = Config.RarityColors[rarity]
    if preset then return preset end
    local rank = GameLib.RarityRank[rarity]
    if not rank then return Color3.new(1, 1, 1) end
    return Color3.fromHSV(rank / math.max(#GameLib.RarityOrder, 1) * 0.85, 0.55, 1)
end

---@return table  { board, label, anchor } from the pool
function xDTaraZ.Esp.Take()
    local spare = table.remove(xDTaraZ.Esp.Pool)
    if spare then return spare end

    local anchor = Instance.new("Attachment")
    anchor.Name = "MarioEspAnchor"
    anchor.Parent = Workspace.Terrain

    local board = Instance.new("BillboardGui")
    board.Name = "MarioEsp"
    board.AlwaysOnTop = true
    board.Size = UDim2.fromOffset(xDTaraZ.Platform.Mobile and 150 or 200, xDTaraZ.Platform.Mobile and 30 or 40)
    board.StudsOffset = Vector3.new(0, Config.EspLift, 0)
    board.Adornee = anchor

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.TextStrokeTransparency = 0.3
    label.Parent = board
    board.Parent = xDTaraZ.World.Screen()
    local slot = { board = board, label = label, anchor = anchor }
    xDTaraZ.Esp.Made[slot] = true
    return slot
end

function xDTaraZ.Esp.Give(guid)
    local esp = xDTaraZ.Esp
    local slot = esp.Boards[guid]
    if not slot then return end
    esp.Boards[guid] = nil

    if #esp.Pool >= Config.EspPool then
        esp.Drop(slot)
        return
    end
    slot.board.Enabled = false
    table.insert(esp.Pool, slot)
end

---@return boolean  entry passes the rarity floor and is visible to us
function xDTaraZ.Esp.Shows(entry, minRank)
    if entry.removed or not entry.egg or typeof(entry.pos) ~= "Vector3" then return false end
    if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then return false end
    local info = GameLib.EggInfo[entry.egg]
    return info ~= nil and (GameLib.RarityRank[info.rarity] or 1) >= minRank
end

function xDTaraZ.Esp.Drop(slot)
    xDTaraZ.Esp.Made[slot] = nil
    slot.board:Destroy()
    slot.anchor:Destroy()
end

function xDTaraZ.Esp.Step()
    if not xDTaraZ.State.Alive or not xDTaraZ.Util.Opt("EggEsp") then return end
    if not xDTaraZ.EggIndex.Start() then return end
    local esp = xDTaraZ.Esp
    local hrp = xDTaraZ.Player.Root
    local range = xDTaraZ.Platform.Mobile and Config.EspRangeMobile or Config.EspRange
    local minRank = GameLib.RarityRank[xDTaraZ.Util.Opt("EspMinRarity") or ""] or 1
    local seen = {}

    for guid, entry in pairs(xDTaraZ.EggIndex.Entries) do
        if not esp.Shows(entry, minRank) then continue end
        local dist = hrp and (entry.pos - hrp.Position).Magnitude or 0
        if dist > range then continue end

        seen[guid] = true
        local slot = esp.Boards[guid]
        if not slot then
            slot = esp.Take()
            esp.Boards[guid] = slot
        end
        local info = GameLib.EggInfo[entry.egg]
        local mutation = entry.mutation and entry.mutation ~= "" and (" " .. entry.mutation) or ""
        slot.anchor.WorldPosition = entry.pos
        slot.board.MaxDistance = range
        slot.board.Enabled = true
        slot.label.TextColor3 = esp.Color(info.rarity)
        slot.label.Text = string.format("%s [%s]%s\n%.2fkg | %dm", entry.egg, info.rarity, mutation, entry.weight or 1, math.floor(dist))
    end

    for guid in pairs(esp.Boards) do
        if not seen[guid] then esp.Give(guid) end
    end
end

function xDTaraZ.Esp.Clear()
    local esp = xDTaraZ.Esp
    for slot in pairs(esp.Made) do
        esp.Drop(slot)
    end
    table.clear(esp.Boards)
    table.clear(esp.Pool)
end

function xDTaraZ.Esp.Stop()
    xDTaraZ.Esp.Clear()
end

do
    local defaults = {
        OwnPetReach = 25, BoostBatch = 400, FpsCapDefault = 240, FpsCapRestore = 60,
        BoostClasses = { ParticleEmitter = true, Trail = true, Beam = true, Smoke = true, Fire = true, Sparkles = true },
    }
    for key, value in pairs(defaults) do
        if Config[key] == nil then Config[key] = value end
    end
end

xDTaraZ.Visual = {
    Holder = Instance.new("Folder"),
    Conns = { Pets = {}, Eggs = {}, Boost = {} },
    Hidden = { Pets = {}, Eggs = {} },
    Disabled = {}, Props = {},
    BoostToken = 0,
    PetSetting = nil,
    CapOn = false,
}

function xDTaraZ.Visual.Drop(kind)
    local list = xDTaraZ.Visual.Conns[kind]
    for _, conn in ipairs(list) do conn:Disconnect() end
    table.clear(list)
end

function xDTaraZ.Visual.Watch(kind, signal, handler)
    table.insert(xDTaraZ.Visual.Conns[kind], xDTaraZ:Connect(signal, handler))
end

---@param kind string  "Pets" or "Eggs"
function xDTaraZ.Visual.Hide(kind, model)
    local hidden = xDTaraZ.Visual.Hidden[kind]
    if hidden[model] or not model.Parent then return end
    hidden[model] = model.Parent
    model.Parent = xDTaraZ.Visual.Holder
end

function xDTaraZ.Visual.Show(kind, model)
    local hidden = xDTaraZ.Visual.Hidden[kind]
    local home = hidden[model]
    if not home then return end
    hidden[model] = nil
    if model.Parent ~= xDTaraZ.Visual.Holder or not home.Parent then return end
    pcall(function() model.Parent = home end)
end

function xDTaraZ.Visual.ShowAll(kind)
    local models = {}
    for model in pairs(xDTaraZ.Visual.Hidden[kind]) do models[#models + 1] = model end
    for _, model in ipairs(models) do xDTaraZ.Visual.Show(kind, model) end
end

---@return boolean  true when the ridden pet belongs to someone else
function xDTaraZ.Visual.ForeignPet(model)
    if not model:IsA("Model") or model:GetAttribute("Ridden") ~= true then return false end
    local ownerId = model:GetAttribute("OwnerUserId")
    if ownerId ~= nil then return ownerId ~= LocalPlayer.UserId end
    local owner = model:GetAttribute("Owner")
    if owner ~= nil then return owner ~= LocalPlayer.UserId and owner ~= LocalPlayer.Name end

    local char = LocalPlayer.Character
    if char and model:IsDescendantOf(char) then return false end
    if LocalPlayer:GetAttribute("IsRiding") ~= true then return true end
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return (model:GetPivot().Position - hrp.Position).Magnitude > Config.OwnPetReach
end

function xDTaraZ.Visual.TrackPet(model)
    if not model:IsA("Model") then return end
    xDTaraZ.Visual.Watch("Pets", model:GetAttributeChangedSignal("Ridden"), function()
        if model:GetAttribute("Ridden") == true then
            if xDTaraZ.Visual.ForeignPet(model) then xDTaraZ.Visual.Hide("Pets", model) end
        else
            xDTaraZ.Visual.Show("Pets", model)
        end
    end)
    if xDTaraZ.Visual.ForeignPet(model) then xDTaraZ.Visual.Hide("Pets", model) end
end

function xDTaraZ.Visual.HidePets(on)
    xDTaraZ.Visual.Drop("Pets")
    local remote = xDTaraZ.GameLib.Remote("UpdateSetting")

    if not on then
        xDTaraZ.Visual.ShowAll("Pets")
        if remote and xDTaraZ.Visual.PetSetting ~= nil then remote:FireServer("ViewOtherPets", xDTaraZ.Visual.PetSetting) end
        xDTaraZ.Visual.PetSetting = nil
        return
    end

    if remote and xDTaraZ.Visual.PetSetting == nil then
        xDTaraZ.Visual.PetSetting = LocalPlayer:GetAttribute("Setting_ViewOtherPets") ~= false
        remote:FireServer("ViewOtherPets", false)
    end

    local objects = Workspace:FindFirstChild("GameObjects")
    if not objects then return end
    for _, model in ipairs(objects:GetChildren()) do xDTaraZ.Visual.TrackPet(model) end
    xDTaraZ.Visual.Watch("Pets", objects.ChildAdded, xDTaraZ.Visual.TrackPet)
end

function xDTaraZ.Visual.HideEggs(on)
    xDTaraZ.Visual.Drop("Eggs")
    if not on then return xDTaraZ.Visual.ShowAll("Eggs") end

    local plots = Workspace:FindFirstChild("Plots")
    if not plots then return end
    for _, plot in ipairs(plots:GetChildren()) do
        local owner = plot:FindFirstChild("Data") and plot.Data:FindFirstChild("Owner")
        local eggs = plot:FindFirstChild("Eggs")
        if not owner or not eggs or owner.Value == LocalPlayer then continue end

        for _, egg in ipairs(eggs:GetChildren()) do
            if egg:IsA("Model") then xDTaraZ.Visual.Hide("Eggs", egg) end
        end
        xDTaraZ.Visual.Watch("Eggs", eggs.ChildAdded, function(egg)
            if egg:IsA("Model") and owner.Value ~= LocalPlayer then xDTaraZ.Visual.Hide("Eggs", egg) end
        end)
    end
end

---@param target Instance  property owner, original value saved once
function xDTaraZ.Visual.SetProp(target, prop, value)
    local key = target:GetFullName() .. "." .. prop
    local props = xDTaraZ.Visual.Props
    local ok, old = pcall(function() return target[prop] end)
    if not ok then return end
    if not props[key] then props[key] = { target, prop, old } end
    pcall(function() target[prop] = value end)
end

function xDTaraZ.Visual.Mute(inst)
    if not Config.BoostClasses[inst.ClassName] or xDTaraZ.Visual.Disabled[inst] ~= nil then return end
    local char = LocalPlayer.Character
    if char and inst:IsDescendantOf(char) then return end
    if not inst.Enabled then return end
    xDTaraZ.Visual.Disabled[inst] = true
    inst.Enabled = false
end

function xDTaraZ.Visual.Sweep(token)
    local list = Workspace:GetDescendants()
    for i, inst in ipairs(list) do
        if xDTaraZ.Visual.BoostToken ~= token then return end
        xDTaraZ.Visual.Mute(inst)
        if i % Config.BoostBatch == 0 then task.wait() end
    end
end

function xDTaraZ.Visual.Boost(on)
    xDTaraZ.Visual.Drop("Boost")
    xDTaraZ.Visual.BoostToken += 1

    if not on then
        for inst in pairs(xDTaraZ.Visual.Disabled) do
            if inst.Parent then pcall(function() inst.Enabled = true end) end
        end
        table.clear(xDTaraZ.Visual.Disabled)
        for _, row in pairs(xDTaraZ.Visual.Props) do
            pcall(function() row[1][row[2]] = row[3] end)
        end
        table.clear(xDTaraZ.Visual.Props)
        return
    end

    local lighting = game:GetService("Lighting")
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    xDTaraZ.Visual.SetProp(lighting, "GlobalShadows", false)
    for _, holder in ipairs({ lighting, Workspace.CurrentCamera }) do
        for _, effect in ipairs(holder and holder:GetChildren() or {}) do
            if effect:IsA("PostEffect") then xDTaraZ.Visual.SetProp(effect, "Enabled", false) end
        end
    end
    if terrain then
        xDTaraZ.Visual.SetProp(terrain, "Decoration", false)
        xDTaraZ.Visual.SetProp(terrain, "WaterWaveSize", 0)
        xDTaraZ.Visual.SetProp(terrain, "WaterReflectance", 0)
    end
    pcall(function() xDTaraZ.Visual.SetProp(settings().Rendering, "QualityLevel", Enum.QualityLevel.Level01) end)

    xDTaraZ.Visual.Watch("Boost", Workspace.DescendantAdded, xDTaraZ.Visual.Mute)
    task.spawn(xDTaraZ.Visual.Sweep, xDTaraZ.Visual.BoostToken)
end

---@return boolean  false when the executor cannot cap fps
---@return boolean  the cap was applied; turning it off puts back the cap the player had before
function xDTaraZ.Visual.Cap(on)
    local visual = xDTaraZ.Visual
    if on and not visual.CapOn then
        local ok, before = pcall(function() return getfpscap() end)
        visual.CapBefore = ok and tonumber(before) or nil
    end
    visual.CapOn = on
    local fps = on and (tonumber(xDTaraZ.Options.FpsCap) or Config.FpsCapDefault) or (visual.CapBefore or Config.FpsCapRestore)
    return xDTaraZ.Util.SetFpsCap(fps)
end

function xDTaraZ.Visual.Render(on)
    RunService:Set3dRenderingEnabled(not on)
end

function xDTaraZ.Visual.Stop()
    local try = xDTaraZ.Util.Try
    try("visual pets", xDTaraZ.Visual.HidePets, false)
    try("visual eggs", xDTaraZ.Visual.HideEggs, false)
    try("visual boost", xDTaraZ.Visual.Boost, false)
    if xDTaraZ.Visual.CapOn then try("visual cap", xDTaraZ.Visual.Cap, false) end
    try("visual render", xDTaraZ.Visual.Render, false)
end

do
    local defaults = {
        WebhookPattern = "^https://[%w%.]*discord[app]*%.com/api/webhooks/%d+/[%w_%-]+$",
        WebhookGap = 1.2, WebhookQueueMax = 20,
        WebhookLogo = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/main/logo.png",
        WebhookAvatarApi = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=%d&size=150x150&format=Png",
        WebhookIcons = { Egg = "🥚", Server = "📡", Magma = "🌋", Pet = "🐾", Rebirth = "♻️", Kick = "⚠️", Report = "📊", Test = "✅", Fail = "🛑" },
        WebhookColors = { Egg = 0xE8A04C, Pet = 0x7DD87D, Magma = 0xFF5A2A, Server = 0xFF82E6, Rebirth = 0x5AB4FF, Kick = 0xE04848, Report = 0x9AA4B0, Test = 0xE8A04C, Fail = 0xE04848 },
    }
    for key, value in pairs(defaults) do
        if Config[key] == nil then Config[key] = value end
    end
end

xDTaraZ.Webhook = {
    Events = { "Rare Egg Picked", "Rare Egg In Server", "Magma Dip", "Pet Hatched", "Rebirth", "Egg Returned", "Kicked", "Status Report" },
    Queue = {}, Sending = false, Booted = false,
    SeenPets = {}, SeenEggs = {},
    LastReport = os.clock(), StartedAt = os.clock(),
    Avatar = nil, Baseline = nil, Conns = {},
    Counts = { Eggs = 0, Rare = 0, Dips = 0, Magma = 0, Pets = 0 },
}

---@return boolean  looks like a Discord webhook url
function xDTaraZ.Webhook.Valid(url)
    return type(url) == "string" and url:match(Config.WebhookPattern) ~= nil
end

function xDTaraZ.Webhook.Wants(event)
    local opt = xDTaraZ.Util.Opt
    if opt("Webhook") == false then return false end
    if not xDTaraZ.Webhook.Valid(opt("WebhookUrl")) then return false end
    local events = opt("WebhookEvents")
    return type(events) == "table" and events[event] == true
end

---@return number  embed colour, the event colour when the rarity has no preset
function xDTaraZ.Webhook.Color(rarity, kind)
    local color = rarity and Config.RarityColors and Config.RarityColors[rarity]
    if not color then return Config.WebhookColors[kind] or Config.WebhookColors.Report end
    return math.floor(color.R * 255) * 65536 + math.floor(color.G * 255) * 256 + math.floor(color.B * 255)
end

function xDTaraZ.Webhook.Duration(seconds)
    seconds = math.max(0, math.floor(seconds))
    local hours, minutes = math.floor(seconds / 3600), math.floor(seconds % 3600 / 60)
    if hours > 0 then return string.format("%dh %02dm", hours, minutes) end
    return string.format("%dm %02ds", minutes, seconds % 60)
end

---@return string|nil  headshot url, fetched once
function xDTaraZ.Webhook.AvatarUrl()
    local hook = xDTaraZ.Webhook
    if hook.Avatar ~= nil then return hook.Avatar or nil end
    hook.Avatar = false

    local body = xDTaraZ.Util.HttpGet(Config.WebhookAvatarApi:format(LocalPlayer.UserId))
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, body or "")
    local row = ok and type(decoded) == "table" and type(decoded.data) == "table" and decoded.data[1]
    if row and type(row.imageUrl) == "string" then hook.Avatar = row.imageUrl end
    return hook.Avatar or nil
end

---@return number
local function SavedNumber(name)
    local saved = LocalPlayer:FindFirstChild("SavedData")
    local value = saved and saved:FindFirstChild(name)
    return value and tonumber(value.Value) or 0
end

function xDTaraZ.Webhook.Income()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    local income = stats and stats:FindFirstChild("Income/s")
    return income and tonumber(income.Value) or 0
end

---@return table  account and session lines shared by every alert
function xDTaraZ.Webhook.AccountFields()
    local hook = xDTaraZ.Webhook
    local counts, stats = hook.Counts, State.Stats
    local format = xDTaraZ.Util.Format
    return {
        { "💵 Cash", format(SavedNumber("Cash")) },
        { "📈 Income", format(hook.Income()) .. "/s" },
        { "♻️ Rebirths", SavedNumber("Rebirths") },
        { "🥚 Eggs (session)", stats.delivered .. " delivered, " .. counts.Rare .. " rare" },
        { "🌋 Magma (session)", counts.Magma .. " / " .. counts.Dips .. " dips" },
        { "⏱️ Session", hook.Duration(os.clock() - hook.StartedAt) .. " | " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers .. " players" },
    }
end

---@param event table  { Kind, Title, Lines?, Fields?, Rarity?, Ping?, Account?, Thumbnail? }
---@return string      json body
function xDTaraZ.Webhook.Build(event)
    local fields = {}
    for _, field in ipairs(event.Fields or {}) do
        fields[#fields + 1] = { name = field[1], value = tostring(field[2]), inline = field[3] ~= false }
    end
    if event.Account ~= false then
        table.insert(fields, { name = "\u{200B}", value = "**Account**", inline = false })
        for _, field in ipairs(xDTaraZ.Webhook.AccountFields()) do
            fields[#fields + 1] = { name = field[1], value = tostring(field[2]), inline = true }
        end
    end

    return HttpService:JSONEncode({
        username = "Mario Hub",
        avatar_url = Config.WebhookLogo,
        content = event.Ping and xDTaraZ.Util.Opt("WebhookPing") and "@everyone" or nil,
        embeds = { {
            author = { name = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")", icon_url = xDTaraZ.Webhook.AvatarUrl() },
            title = (Config.WebhookIcons[event.Kind] or "") .. " " .. event.Title,
            description = event.Lines and table.concat(event.Lines, "\n") or nil,
            color = xDTaraZ.Webhook.Color(event.Rarity, event.Kind),
            fields = fields,
            thumbnail = event.Thumbnail and { url = event.Thumbnail } or nil,
            footer = { text = "Mario Hub • Ride A Pet", icon_url = Config.WebhookLogo },
            timestamp = DateTime.now():ToIsoDate(),
        } },
    })
end

---@return boolean, string|nil  sent, or false and why
function xDTaraZ.Webhook.Post(url, json)
    local requester = (syn and syn.request) or (http and http.request) or http_request or request
    if not requester then return false, "no http function" end

    local ok, response = pcall(requester, { Url = url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = json })
    if not ok or type(response) ~= "table" then return false, tostring(response) end
    local code = tonumber(response.StatusCode) or 0
    if code < 200 or code >= 300 then return false, "HTTP " .. code .. " " .. tostring(response.Body):sub(1, 120) end
    return true
end

function xDTaraZ.Webhook.Push(event)
    local queue = xDTaraZ.Webhook.Queue
    if #queue >= Config.WebhookQueueMax then table.remove(queue, 1) end
    queue[#queue + 1] = event
    xDTaraZ.Webhook.Flush()
end

function xDTaraZ.Webhook.Flush()
    local hook = xDTaraZ.Webhook
    if hook.Sending then return end
    hook.Sending = true

    task.spawn(function()
        local queue = hook.Queue
        for _ = 1, Config.WebhookQueueMax do
            if #queue == 0 or not State.Alive then break end
            local url = xDTaraZ.Util.Opt("WebhookUrl")
            if not hook.Valid(url) then
                table.clear(queue)
                break
            end

            local built, json = pcall(hook.Build, table.remove(queue, 1))
            local sent, why = false, json
            if built then sent, why = hook.Post(url, json) end
            if not sent then warn(Config.Tag, "webhook:", why) end
            task.wait(Config.WebhookGap)
        end
        hook.Sending = false
        if #queue > 0 and State.Alive then hook.Flush() end
    end)
end

---@return table|nil  GameLib.EggInfo row when it reaches the rarity floor picked in the menu
function xDTaraZ.Webhook.RareEgg(eggName)
    local info = GameLib.EggInfo[eggName or ""]
    if not info then return nil end
    local floor = GameLib.RarityRank[xDTaraZ.Util.Opt("WebhookEggRarity") or ""] or 1
    if (GameLib.RarityRank[info.rarity] or 0) < floor then return nil end
    return info
end

---@param entry table|nil  EggIndex entry
---@return table           fields for an egg embed
function xDTaraZ.Webhook.EggFields(eggName, entry)
    local info = GameLib.EggInfo[eggName] or {}
    local fields = {
        { "✨ Rarity", tostring(info.rarity or "?") },
        { "🍀 Luck", "1 in " .. xDTaraZ.Util.Format(info.luck or 0) },
    }
    if entry and entry.weight then fields[#fields + 1] = { "⚖️ Weight", string.format("%.2f", entry.weight) } end
    if entry and entry.mutation and entry.mutation ~= "" then fields[#fields + 1] = { "🧬 Mutation", entry.mutation } end
    if (info.growth or 0) > 0 then fields[#fields + 1] = { "⏳ Grow time", xDTaraZ.Webhook.Duration(info.growth) } end
    if info.volcanic then fields[#fields + 1] = { "🌋 Spawn", "Inside the volcano" } end
    return fields
end

---@param guid string|nil
---@param text any         server reply text, used when the guid is not indexed
function xDTaraZ.Webhook.EggPicked(guid, text)
    local hook = xDTaraZ.Webhook
    local entry = guid and xDTaraZ.EggIndex.Entries[guid]
    local eggName = entry and entry.egg or (type(text) == "string" and text) or nil
    hook.Counts.Eggs += 1

    local info = hook.RareEgg(eggName)
    if not info then return end
    hook.Counts.Rare += 1
    if not hook.Wants("Rare Egg Picked") then return end

    hook.Push({
        Kind = "Egg",
        Title = "Picked up " .. eggName,
        Lines = { "On the way home." },
        Fields = hook.EggFields(eggName, entry),
        Rarity = info.rarity,
        Ping = GameLib.RarityRank[info.rarity] == #GameLib.RarityOrder,
    })
end

---@param egg Instance|table  ActiveEggs child or EggIndex entry
function xDTaraZ.Webhook.EggSpawned(egg)
    local hook = xDTaraZ.Webhook
    local entry = type(egg) == "table" and egg or (typeof(egg) == "Instance" and xDTaraZ.EggIndex.Entries[egg.Name])
    if not entry or not entry.guid or hook.SeenEggs[entry.guid] then return end
    if entry.dropEndsAt then return end
    if entry.privateTo and entry.privateTo ~= LocalPlayer.UserId then return end
    if not hook.Wants("Rare Egg In Server") then return end

    local info = hook.RareEgg(entry.egg)
    if not info then return end
    hook.SeenEggs[entry.guid] = true

    local fields = hook.EggFields(entry.egg, entry)
    fields[#fields + 1] = { "🆔 Server", "`" .. game.JobId .. "`", false }
    hook.Push({
        Kind = "Server",
        Title = entry.egg .. " spawned",
        Lines = { "A " .. info.rarity .. " egg is on the map in your server." },
        Fields = fields,
        Rarity = info.rarity,
        Ping = true,
    })
end

---@param reply table  VolcanoDipResult payload, already ours
function xDTaraZ.Webhook.Dipped(reply)
    local hook = xDTaraZ.Webhook
    local counts = hook.Counts
    counts.Dips += 1
    if reply.Success then counts.Magma += 1 end
    if not reply.Success or not hook.Wants("Magma Dip") then return end

    local eggName = tostring(reply.Egg)
    local info = GameLib.EggInfo[eggName] or {}
    hook.Push({
        Kind = "Magma",
        Title = eggName .. " became " .. tostring(reply.Mutation),
        Lines = { "The volcano dip worked." },
        Fields = {
            { "✨ Rarity", tostring(info.rarity or "?") },
            { "⚖️ Weight", string.format("%.2f", tonumber(reply.Weight) or 0) },
            { "🎲 Hit rate", string.format("%d / %d (%.0f%%)", counts.Magma, counts.Dips, counts.Magma / counts.Dips * 100) },
        },
        Rarity = info.rarity,
    })
end

function xDTaraZ.Webhook.PetAdded(tool)
    local hook = xDTaraZ.Webhook
    if not tool:IsA("Tool") then return end
    local key = tool:GetAttribute("PetKey")
    if not key or hook.SeenPets[key] then return end
    hook.SeenPets[key] = true
    hook.Counts.Pets += 1
    if not hook.Wants("Pet Hatched") then return end

    local petName = tool:GetAttribute("PetName") or tool.Name
    local info = GameLib.PetInfo[petName]
    local rarity = info and info.rarity or "?"
    local floor = GameLib.RarityRank[xDTaraZ.Util.Opt("WebhookPetRarity") or ""] or 1
    if (GameLib.RarityRank[rarity] or 0) < floor then return end

    local fields = {
        { "✨ Rarity", rarity },
        { "💰 Income", xDTaraZ.Util.Format(info and info.income or 0) .. "/s" },
    }
    local weight = tonumber(tool:GetAttribute("Weight") or tool:GetAttribute("BaseWeight"))
    if weight then table.insert(fields, { "⚖️ Weight", string.format("%.2f", weight) }) end
    for _, attr in ipairs({ "Mutation", "SpawnMutation" }) do
        local mutation = tool:GetAttribute(attr)
        if mutation and mutation ~= "" then fields[#fields + 1] = { "🧬 " .. (attr == "Mutation" and "Mutation" or "Spawn Mutation"), mutation } end
    end
    fields[#fields + 1] = { "🐾 New pets (session)", hook.Counts.Pets }

    hook.Push({
        Kind = "Pet",
        Title = "New pet: " .. petName,
        Fields = fields,
        Rarity = rarity,
        Ping = GameLib.RarityRank[rarity] == #GameLib.RarityOrder,
    })
end

---@param _plan table|nil  State.LastFail from Guard; mechanics stay out of Discord
function xDTaraZ.Webhook.DeliveryFailed(_plan)
    if not xDTaraZ.Webhook.Wants("Egg Returned") then return end
    xDTaraZ.Webhook.Push({
        Kind = "Fail",
        Title = "Egg farming stopped",
        Lines = { "An egg was returned, so egg farming switched itself off. Turn it back on in the menu to continue." },
        Fields = {
            { "📦 Delivered", State.Stats.delivered },
            { "❌ Lost", State.Stats.lost },
        },
        Ping = true,
    })
end

function xDTaraZ.Webhook.Snapshot()
    local counts = xDTaraZ.Webhook.Counts
    return { Cash = SavedNumber("Cash"), Eggs = State.Stats.delivered, Magma = counts.Magma, Pets = counts.Pets, At = os.clock() }
end

function xDTaraZ.Webhook.Report()
    local hook = xDTaraZ.Webhook
    local minutes = tonumber(xDTaraZ.Util.Opt("WebhookReportMins")) or 0
    if minutes <= 0 or os.clock() - hook.LastReport < minutes * 60 then return end
    if not hook.Wants("Status Report") then return end
    hook.LastReport = os.clock()

    local now = hook.Snapshot()
    local before = hook.Baseline or now
    hook.Baseline = now
    local span = math.max(now.At - before.At, 1)
    local gained = now.Cash - before.Cash
    local format = xDTaraZ.Util.Format

    hook.Push({
        Kind = "Report",
        Title = "Status report",
        Lines = { "**Doing:** " .. tostring(State.Status.Eggs or "Idle") },
        Fields = {
            { "💵 Cash gained", (gained >= 0 and "+" or "") .. format(gained) },
            { "⚡ Cash / hour", format(gained / span * 3600) },
            { "🥚 Eggs", "+" .. (now.Eggs - before.Eggs) },
            { "🌋 Magma", "+" .. (now.Magma - before.Magma) },
            { "🐾 New pets", "+" .. (now.Pets - before.Pets) },
            { "🕒 Window", hook.Duration(span) },
        },
    })
end

---@param message string  disconnect text; posted at once, the queue dies with the session
function xDTaraZ.Webhook.Kicked(message)
    if not xDTaraZ.Webhook.Wants("Kicked") then return end
    local built, json = pcall(xDTaraZ.Webhook.Build, {
        Kind = "Kick",
        Title = "Disconnected",
        Lines = { "```" .. tostring(message):sub(1, 500) .. "```" },
        Ping = true,
    })
    if built then xDTaraZ.Webhook.Post(xDTaraZ.Util.Opt("WebhookUrl"), json) end
end

---@return boolean  false when the url is not a Discord webhook
---@return boolean, string|nil  Discord accepted it, or false and why
function xDTaraZ.Webhook.Test()
    local url = xDTaraZ.Util.Opt("WebhookUrl")
    if not xDTaraZ.Webhook.Valid(url) then return false, "Paste a Discord webhook URL first" end

    local built, json = pcall(xDTaraZ.Webhook.Build, { Kind = "Test", Title = "Webhook connected", Lines = { "Alerts from Mario Hub will show up here." } })
    if not built then return false, tostring(json) end
    local sent, why = xDTaraZ.Webhook.Post(url, json)
    if sent then return true end
    if tostring(why):find("HTTP 404", 1, true) then return false, "Discord says this webhook does not exist" end
    return false, why
end

---@param signal RBXScriptSignal|table  Roblox signal or an xDTaraZ.Signal
function xDTaraZ.Webhook.Listen(signal, fn)
    if getmetatable(signal) == xDTaraZ.Signal then
        local off = signal:Connect(fn)
        table.insert(xDTaraZ.Webhook.Conns, { Disconnect = off })
        return
    end
    local conn = xDTaraZ:Connect(signal, fn)
    table.insert(xDTaraZ.Webhook.Conns, conn)
end

function xDTaraZ.Webhook.MarkPets(container)
    for _, tool in ipairs(container and container:GetChildren() or {}) do
        local key = tool:GetAttribute("PetKey")
        if key then xDTaraZ.Webhook.SeenPets[key] = true end
    end
end

function xDTaraZ.Webhook.WatchBackpack(backpack)
    xDTaraZ.Webhook.MarkPets(backpack)
    xDTaraZ.Webhook.Listen(backpack.ChildAdded, xDTaraZ.Webhook.PetAdded)
end

function xDTaraZ.Webhook.WatchGame()
    local hook, index = xDTaraZ.Webhook, xDTaraZ.EggIndex
    hook.Listen(index.OnReply, function(kind, guid, text)
        if kind == "PickedUp" then hook.EggPicked(guid, text) end
    end)
    hook.Listen(index.OnAdded, function(entry) task.defer(hook.EggSpawned, entry) end)

    local dip = GameLib.Remote("VolcanoDipResult")
    if dip then
        hook.Listen(dip.OnClientEvent, function(reply)
            if type(reply) ~= "table" then return end
            if reply.Owner ~= LocalPlayer.UserId and reply.Owner ~= LocalPlayer then return end
            hook.Dipped(reply)
        end)
    end

    local saved = LocalPlayer:FindFirstChild("SavedData")
    local rebirths = saved and saved:FindFirstChild("Rebirths")
    if rebirths then
        hook.Listen(rebirths.Changed, function(value)
            if not hook.Wants("Rebirth") then return end
            hook.Push({ Kind = "Rebirth", Title = "Rebirth " .. tostring(value) .. " done", Lines = { "Cash and luck reset, +1 pet slot." } })
        end)
    end

    hook.Listen(GuiService.ErrorMessageChanged, function()
        local message = GuiService:GetErrorMessage()
        if message ~= "" then task.spawn(hook.Kicked, message) end
    end)
end

function xDTaraZ.Webhook.Boot()
    local hook = xDTaraZ.Webhook
    if hook.Booted then return end
    hook.Booted = true

    hook.MarkPets(xDTaraZ.Player.Char)
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if backpack then hook.WatchBackpack(backpack) end
    hook.Listen(LocalPlayer.ChildAdded, function(child)
        if child:IsA("Backpack") then hook.WatchBackpack(child) end
    end)

    hook.WatchGame()
    hook.Baseline = hook.Snapshot()
    task.spawn(hook.AvatarUrl)
end

function xDTaraZ.Webhook.Step()
    local hook = xDTaraZ.Webhook
    if not hook.Booted then hook.Boot() end
    hook.Report()
end

function xDTaraZ.Webhook.Stop()
    local hook = xDTaraZ.Webhook
    for _, conn in ipairs(hook.Conns) do
        conn:Disconnect()
    end
    table.clear(hook.Conns)
    table.clear(hook.Queue)
    hook.Booted = false
end

xDTaraZ.Kaitun = {
    Running = false,
    Saved = {},
    Steered = nil,
    SteerKey = nil,
    SteerAt = 0,
}

---@param value any
function xDTaraZ.Kaitun.Set(idx, value)
    xDTaraZ.Options[idx] = value
    table.insert(xDTaraZ.State.PendingSet, { idx, value })
end

---@return any  a copy safe to store, tables shallow copied
function xDTaraZ.Kaitun.Snapshot(value)
    if type(value) ~= "table" then return value end
    local copy = {}
    for key, entry in pairs(value) do
        copy[key] = entry
    end
    return copy
end

function xDTaraZ.Kaitun.Start()
    if xDTaraZ.Kaitun.Running then return end
    xDTaraZ.Kaitun.Running = true
    table.clear(xDTaraZ.Kaitun.Saved)

    local remember = { "HuntMinRarity", "EggRarities", "MinEggRarity" }
    for _, idx in ipairs(xDTaraZ.Config.KaitunToggles) do
        table.insert(remember, idx)
    end
    for _, idx in ipairs(remember) do
        xDTaraZ.Kaitun.Saved[idx] = { xDTaraZ.Kaitun.Snapshot(xDTaraZ.Util.Opt(idx)) }
    end

    xDTaraZ.Kaitun.Set("HuntMinRarity", xDTaraZ.Config.KaitunHuntRarity)
    xDTaraZ.Kaitun.Set("MinEggRarity", xDTaraZ.GameLib.RarityOrder[1])
    for _, idx in ipairs(xDTaraZ.Config.KaitunToggles) do
        if not xDTaraZ.GameLib.Blocked(idx) then xDTaraZ.Kaitun.Set(idx, true) end
    end
    xDTaraZ.Kaitun.SteerAt = 0
end

function xDTaraZ.Kaitun.Stop()
    if not xDTaraZ.Kaitun.Running then return end
    xDTaraZ.Kaitun.Running = false

    for idx, boxed in pairs(xDTaraZ.Kaitun.Saved) do
        xDTaraZ.Kaitun.Set(idx, boxed[1] == nil and false or boxed[1])
    end
    table.clear(xDTaraZ.Kaitun.Saved)
    xDTaraZ.Kaitun.Steered = nil
    xDTaraZ.Kaitun.SteerKey = nil
    xDTaraZ.State.Status.Kaitun = "Off"
end

---@return table|nil  { [rarity] = true } of eggs that can hatch this pet, nil when none can
function xDTaraZ.Kaitun.RaritiesFor(pet)
    local mult = xDTaraZ.Economy.LuckMult()
    local wanted, any = {}, false

    for egg, info in pairs(xDTaraZ.GameLib.EggInfo) do
        if info.volcanic then continue end
        local odds = xDTaraZ.GameLib.Odds(egg, mult)
        for _, row in ipairs(odds or {}) do
            if row[1] == pet and row[2] > 0 then
                wanted[info.rarity] = true
                any = true
                break
            end
        end
    end
    return any and wanted or nil
end

---@return string  what the steer is chasing, for the status line
function xDTaraZ.Kaitun.Steer()
    local pet = xDTaraZ.Economy.NextRequirement()
    local missing = pet and not xDTaraZ.Economy.OwnedPet(pet)
    local key = missing and (pet .. "@" .. math.floor(xDTaraZ.Economy.LuckMult())) or "none"

    local due = os.clock() - xDTaraZ.Kaitun.SteerAt >= xDTaraZ.Config.KaitunSteerEvery
    if key == xDTaraZ.Kaitun.SteerKey and not due then
        return missing and ("Hunting " .. pet) or "Farming"
    end
    xDTaraZ.Kaitun.SteerKey = key
    xDTaraZ.Kaitun.SteerAt = os.clock()

    local rarities = missing and xDTaraZ.Kaitun.RaritiesFor(pet)
    if rarities then
        xDTaraZ.Kaitun.Steered = rarities
        xDTaraZ.Kaitun.Set("EggRarities", rarities)
        return "Hunting " .. pet
    end

    if xDTaraZ.Kaitun.Steered then
        local saved = xDTaraZ.Kaitun.Saved.EggRarities
        xDTaraZ.Kaitun.Set("EggRarities", saved and xDTaraZ.Kaitun.Snapshot(saved[1]) or {})
        xDTaraZ.Kaitun.Steered = nil
    end
    return "Farming"
end

function xDTaraZ.Kaitun.Step()
    if not xDTaraZ.Kaitun.Running then return end
    local doing = xDTaraZ.Kaitun.Steer()

    local plan = xDTaraZ.Economy.Plan
    local rebirths = xDTaraZ.Economy.Rebirths() .. "/" .. (xDTaraZ.GameLib.Rebirths.Cap or 0)
    xDTaraZ.State.Status.Kaitun = doing .. " | Rebirth " .. rebirths .. (plan ~= "" and (" | " .. plan) or "")
end

function xDTaraZ.Kaitun.Status()
    return xDTaraZ.State.Status.Kaitun or "Off"
end

local function T(en, th)
    return Library:T(en, th)
end

xDTaraZ.UI = { Labels = {}, Shown = {} }

xDTaraZ.UI.WebhookEvents = {
    "Rare Egg Picked", "Rare Egg In Server", "Egg Returned", "Magma Dip", "Pet Hatched",
    "Rebirth", "Boost Started", "Kicked", "Status Report",
}

xDTaraZ.UI.Floats = { { "Fly", "Fly" }, { "NoClip", "Clip" }, { "SpeedOn", "Run" }, { "EggEsp", "ESP" } }

---@param module string    root module name
---@param group  string[]  toggles sharing that module; Stop runs when all are off
---@return function
function xDTaraZ.UI.Shared(module, group)
    return function(on)
        local mod = rawget(xDTaraZ, module)
        if not mod then return end
        if on then
            if mod.Start then mod.Start() end
            return
        end
        for _, idx in ipairs(group) do
            if xDTaraZ.Options[idx] then return end
        end
        if mod.Stop then mod.Stop() end
    end
end

---@return function
function xDTaraZ.UI.Switch(module)
    return function(on)
        local mod = xDTaraZ[module]
        if on then mod.Start() else mod.Stop() end
    end
end

---@return function
function xDTaraZ.UI.MoveHook(idx)
    return function(on) xDTaraZ.Move.Set(idx, on) end
end

---@return function
function xDTaraZ.UI.TrollHook(idx)
    return function(on) xDTaraZ.Troll.Set(idx, on) end
end

do
    local ui, shared = xDTaraZ.UI, xDTaraZ.UI.Shared
    local volcano = { "VolcanoDip", "VolcanoObby" }
    local hatch = { "AutoPlaceEggs", "AutoHatch" }
    local pets = { "AutoEquipBest", "AutoCollectCash", "AutoFeed" }
    local economy = { "AutoUpgrade", "AutoRebirth", "SmartSpend" }

    ui.Hooks = {
        AutoEggs = ui.Switch("Eggs"),
        EggHunter = ui.Switch("Hunter"),
        VolcanoDip = shared("Volcano", volcano),
        VolcanoObby = shared("Volcano", volcano),
        AutoPlaceEggs = shared("Hatch", hatch),
        AutoHatch = shared("Hatch", hatch),
        ClearJunk = function(on)
            if on then
                xDTaraZ.Eggs.QuietInventory(true)
                xDTaraZ.Junk.Start()
                return
            end
            xDTaraZ.Junk.Stop()
            task.spawn(xDTaraZ.Eggs.Settle)
        end,
        AutoEquipBest = shared("Pets", pets),
        AutoCollectCash = shared("Pets", pets),
        AutoFeed = shared("Pets", pets),
        AutoSell = ui.Switch("Sell"),
        AutoFusion = ui.Switch("Fusion"),
        AutoShop = shared("Shop", { "AutoShop" }),
        AutoUpgrade = shared("Economy", economy),
        AutoRebirth = shared("Economy", economy),
        SmartSpend = shared("Economy", economy),
        AutoClaim = shared("Rewards", { "AutoClaim" }),
        Kaitun = ui.Switch("Kaitun"),
        EggEsp = function(on) if not on then xDTaraZ.Esp.Clear() end end,
        Fling = ui.TrollHook("Fling"),
        Stick = ui.TrollHook("Stick"),
        HideOtherPets = xDTaraZ.Visual.HidePets,
        HideOtherEggs = xDTaraZ.Visual.HideEggs,
        BoostFps = xDTaraZ.Visual.Boost,
        Render3D = xDTaraZ.Visual.Render,
        UnlockFps = function(on)
            if xDTaraZ.Visual.Cap(on) or not on then return end
            Library.Compat.Block("UnlockFps", T("Not supported on this executor", "executor นี้ไม่รองรับ"))
        end,
        FpsCap = function()
            if xDTaraZ.Options.UnlockFps then xDTaraZ.Visual.Cap(true) end
        end,
    }
    for _, idx in ipairs({ "SpeedOn", "JumpOn", "Fly", "NoClip", "InfJump", "AntiAfk" }) do
        ui.Hooks[idx] = ui.MoveHook(idx)
    end
end

---@return function  runs fn on its own thread so game calls never taint the UI thread
function xDTaraZ.UI.Detach(label, fn)
    return function(...)
        local args = table.pack(...)
        task.spawn(function()
            xDTaraZ.Util.Try("ui " .. label, fn, table.unpack(args, 1, args.n))
        end)
    end
end

---@return table  the option, mirrored into xDTaraZ.Options
function xDTaraZ.UI.Bind(idx, option)
    xDTaraZ.Options[idx] = option.Value
    option:OnChanged(function(value)
        xDTaraZ.Options[idx] = value
        if value == true then xDTaraZ.Scheduler.Resume(idx) end

        local hook = xDTaraZ.UI.Hooks[idx]
        if hook then task.spawn(xDTaraZ.Util.Try, "toggle " .. idx, hook, value == true) end
    end)
    return option
end

function xDTaraZ.UI.Toggle(group, idx, info)
    info.Default = false
    return xDTaraZ.UI.Bind(idx, group:AddToggle(idx, info))
end

---@return table  toggle; the key picker is saved as "<idx>Key"
function xDTaraZ.UI.KeyToggle(group, idx, info)
    local toggle = xDTaraZ.UI.Toggle(group, idx, info)
    toggle:AddKeyPicker(idx .. "Key", { Default = "None", Mode = "Toggle" })
    return toggle
end

function xDTaraZ.UI.CarryGuard(option)
    if type(option.AddGuard) ~= "function" then return end
    option:AddGuard(function(value)
        if value ~= true or xDTaraZ.Player:BasketCount() == 0 then return true end
        Library:Notify("Mario Hub", T("Finish the egg delivery first", "ส่งไข่ให้เสร็จก่อน"), 4, "Warning")
        task.defer(option.SetValue, option, false)
        return false
    end)
end

function xDTaraZ.UI.Status(group, key, fallback)
    local label = group:AddLabel(fallback)
    table.insert(xDTaraZ.UI.Labels, { label, key, fallback })
    return label
end

---@return table  list from a builder, empty when it errors
function xDTaraZ.UI.Values(source)
    local ok, list = pcall(source)
    return ok and type(list) == "table" and list or {}
end

---@return string[]
function xDTaraZ.UI.Rarities()
    return table.clone(xDTaraZ.GameLib.RarityOrder)
end

---@return string  "Mythic" when the game has it, else the rarest one
function xDTaraZ.UI.HuntDefault()
    local order = xDTaraZ.GameLib.RarityOrder
    if xDTaraZ.GameLib.RarityRank.Mythic then return "Mythic" end
    return order[#order]
end

---@return string[]  sorted keys of a GameLib table
function xDTaraZ.UI.Names(source)
    local names = {}
    for name in pairs(source) do
        names[#names + 1] = name
    end
    table.sort(names)
    return names
end

---@return string[]  "Auto (fastest)" then every ridable pet tool we hold
function xDTaraZ.UI.RideNames()
    local names = xDTaraZ.UI.Names(xDTaraZ.Mount.Tools())
    table.insert(names, 1, xDTaraZ.Mount.AutoLabel)
    return names
end

function xDTaraZ.UI.Pump()
    local sets = State.PendingSet
    if sets and #sets > 0 then
        State.PendingSet = {}
        for _, row in ipairs(sets) do
            local option = Library.Options[row[1]]
            if option then option:SetValue(row[2]) end
        end
    end
    xDTaraZ.Scheduler.Pump()

    local shown = xDTaraZ.UI.Shown
    for _, row in ipairs(xDTaraZ.UI.Labels) do
        local text = State.Status[row[2]] or row[3]
        if shown[row[1]] == text then continue end
        shown[row[1]] = text
        row[1]:SetText(text)
    end

    local stats = State.Stats
    local line = string.format("Delivered %d | Lost %d", stats.delivered, stats.lost)
    if State.Status.WaveAt then
        local left = math.max(0, math.floor(State.Status.WaveAt - os.clock()))
        line ..= string.format(" | Wave in %d:%02d | %s", math.floor(left / 60), left % 60, State.Status.EggRate or "0/min")
    end
    if shown.Rate ~= line and xDTaraZ.UI.RateLabel then
        shown.Rate = line
        xDTaraZ.UI.RateLabel:SetText(line)
    end
end

function xDTaraZ.UI.Gate()
    local blocked = 0
    for idx in pairs(xDTaraZ.GameLib.Needs) do
        local reason = xDTaraZ.GameLib.Blocked(idx)
        if not reason or not Library.Options[idx] then continue end
        blocked += 1
        warn(Config.Tag, idx .. " blocked:", reason)
        Library.Compat.Block(idx, T("The game changed, waiting for a script update", "เกมอัปเดต รอสคริปต์อัปเดต"))
    end
    if blocked == 0 then return end
    Library:Notify("Mario Hub", T(blocked .. " features are off until the next update", "ปิดไว้ " .. blocked .. " ฟีเจอร์ จนกว่าจะอัปเดต"), 8, "Warning")
end

function xDTaraZ.UI.Home(window)
    local tab = window:AddTab(T("Home", "หน้าแรก"), "mushroom", T("Status and full auto", "สถานะและโหมดอัตโนมัติ"))

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "info")
    xDTaraZ.UI.Status(status, "Eggs", "Egg farm is off")
    xDTaraZ.UI.RateLabel = status:AddLabel("Delivered 0 | Lost 0 | Wave in 0:00 | 0/min")
    xDTaraZ.UI.Status(status, "Economy", "Cash: waiting")

    local quick = tab:AddLeftGroupbox(T("Quick", "ด่วน"), "bomb")
    quick:AddButton({ Text = T("Collect Eggs Now", "เก็บไข่เดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach("collect now", xDTaraZ.Eggs.CollectNow) })
    quick:AddButton({ Text = T("Return Home", "กลับบ้าน"), Func = xDTaraZ.UI.Detach("return home", xDTaraZ.Teleport.Home) })

    local kaitun = tab:AddLeftGroupbox(T("Kaitun", "ไก่ตัน"), "star")
    xDTaraZ.UI.Toggle(kaitun, "Kaitun", {
        Text = T("Kaitun", "ไก่ตัน"),
        Description = T("Plays the account for you, from eggs to rebirth", "เล่นแทนทั้งบัญชี ตั้งแต่ไข่จนถึงรีเบิร์ธ"),
    })
    xDTaraZ.UI.Status(kaitun, "Kaitun", "Off")

    xDTaraZ.UI.Webhook(tab:AddLeftGroupbox(T("Discord Webhook", "แจ้งเตือนดิสคอร์ด"), "bell"))

    local discord = tab:AddRightGroupbox(T("Discord", "ดิสคอร์ด"), "link")
    discord:AddLabel(Config.Discord)
    discord:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ดิสคอร์ด"), Func = function()
        if xDTaraZ.Util.Copy(Config.Discord) then
            Library:Notify("Discord", T("Link copied", "คัดลอกลิงก์แล้ว"), 3, "Success")
        else
            Library:Notify("Discord", Config.Discord, 6, "Info")
        end
    end })

    local updates = tab:AddRightGroupbox(T("Update Log", "อัปเดตล่าสุด"), "bell")
    for i = 1, math.min(2, #Config.UpdateLog) do
        local entry = Config.UpdateLog[i]
        updates:AddParagraph({ Title = entry[1], Content = entry[2] })
    end

end

function xDTaraZ.UI.Webhook(hook)
    local rarities = xDTaraZ.UI.Rarities()
    xDTaraZ.UI.Toggle(hook, "Webhook", { Text = T("Webhook Alerts", "แจ้งเตือนผ่าน Webhook"), Description = T("Sends what you got to your Discord channel", "ส่งของที่ได้เข้าห้องดิสคอร์ดของคุณ") })
    xDTaraZ.UI.Bind("WebhookUrl", hook:AddInput("WebhookUrl", { Text = T("Webhook URL", "ลิงก์ Webhook"), Default = "", Placeholder = T("Paste your webhook link", "วางลิงก์ webhook"), Finished = true }))
    xDTaraZ.UI.Bind("WebhookEvents", hook:AddDropdown("WebhookEvents", { Text = T("Alerts", "แจ้งเตือนเรื่อง"), Values = xDTaraZ.UI.WebhookEvents, Multi = true, Default = {} }))
    xDTaraZ.UI.Bind("WebhookEggRarity", hook:AddDropdown("WebhookEggRarity", { Text = T("Egg Rarity At Least", "ไข่ความหายากตั้งแต่"), Values = rarities, Default = xDTaraZ.UI.HuntDefault() }))
    xDTaraZ.UI.Bind("WebhookPetRarity", hook:AddDropdown("WebhookPetRarity", { Text = T("Pet Rarity At Least", "สัตว์ความหายากตั้งแต่"), Values = rarities, Default = xDTaraZ.UI.HuntDefault() }))
    xDTaraZ.UI.Bind("WebhookReportMins", hook:AddSlider("WebhookReportMins", { Text = T("Status Report Every", "รายงานสถานะทุก"), Min = 5, Max = 120, Default = 30, Rounding = 0, Suffix = " min" }))
    xDTaraZ.UI.Bind("WebhookPing", hook:AddCheckbox("WebhookPing", { Text = T("Ping @everyone On Top Finds", "แท็ก @everyone เมื่อได้ของสุดยอด"), Default = false }))
    hook:AddButton({ Text = T("Send Test", "ส่งทดสอบ"), Func = xDTaraZ.UI.Detach("webhook test", function()
        local sent, why = xDTaraZ.Webhook.Test()
        xDTaraZ.Util.Notify("Webhook", sent and "Test delivered" or ("Test failed: " .. tostring(why)), 6)
    end) })
end

function xDTaraZ.UI.EggFarm(window)
    local tab = window:AddTab(T("Egg Farm", "ฟาร์มไข่"), "coin", T("Wild egg collecting", "เก็บไข่ป่า"))
    local rarities = xDTaraZ.UI.Rarities()

    local farm = tab:AddLeftGroupbox(T("Collect Eggs", "เก็บไข่"), "zap")
    xDTaraZ.UI.Toggle(farm, "AutoEggs", { Text = T("Auto Collect Eggs", "เก็บไข่อัตโนมัติ"), Description = T("Brings every wanted egg on the map home", "เก็บไข่ที่เลือกทั่วแมพแล้วพากลับบ้าน") })
    farm:AddButton({ Text = T("Collect Now", "เก็บเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach("collect now", xDTaraZ.Eggs.CollectNow) })
        :AddButton({ Text = T("Exit Now", "ออกทันที"), Style = "Warning", Func = xDTaraZ.UI.Detach("exit now", xDTaraZ.Eggs.ExitNow) })
    xDTaraZ.UI.Toggle(farm, "ReturnAfter", { Text = T("Wait At Home", "รอที่บ้าน"), Description = T("Waits at your plot between waves", "รอที่พล็อตระหว่างรอบไข่") })
    xDTaraZ.UI.Bind("DeliveryMode", farm:AddDropdown("DeliveryMode", { Text = T("Delivery", "การส่งไข่"), Values = { "Auto", "Safe" }, Default = "Auto" }))

    local ride = xDTaraZ.UI.Bind("RidePet", farm:AddDropdown("RidePet", { Text = T("Ride Pet", "สัตว์ที่ขี่"), Values = xDTaraZ.UI.RideNames(), Default = xDTaraZ.Mount.AutoLabel, Searchable = true }))
    farm:AddButton({ Text = T("Refresh Ride Pets", "รีเฟรชสัตว์ที่ขี่"), Func = function()
        ride:SetValues(xDTaraZ.UI.RideNames())
        xDTaraZ.Mount.Dirty = true
    end })

    local settle = xDTaraZ.UI.Bind("DropSettle", farm:AddSlider("DropSettle", { Text = T("Delivery Safety", "ความปลอดภัยการส่ง"), Min = 0.2, Max = 0.45, Default = 0.2, Rounding = 2, Suffix = "s" }))
    settle:OnChanged(function(value)
        State.Tune.DropSettle = math.clamp(tonumber(value) or Config.DropSettle, Config.DropSettle, 0.45)
    end)
    local contest = xDTaraZ.UI.Bind("ContestWeight", farm:AddSlider("ContestWeight", { Text = T("Beat Other Players", "แย่งไข่ก่อนคนอื่น"), Min = 0, Max = Config.ContestWeightMax, Default = Config.ContestWeight, Rounding = 1 }))
    contest:OnChanged(function(value)
        State.Tune.ContestWeight = math.clamp(tonumber(value) or Config.ContestWeight, 0, Config.ContestWeightMax)
    end)

    local volcano = tab:AddLeftGroupbox(T("Volcano (beta)", "ภูเขาไฟ (ทดลอง)"), "flower")
    xDTaraZ.UI.Toggle(volcano, "VolcanoDip", { Text = T("Volcano Dip", "จุ่มไข่ในภูเขาไฟ"), Description = T("Dips eggs in the volcano for a chance at Magma", "จุ่มไข่ในภูเขาไฟ ลุ้นได้ Magma"), Risky = true })
    xDTaraZ.UI.Bind("DipRarities", volcano:AddDropdown("DipRarities", { Text = T("Dip Rarities (empty = all)", "ความหายากที่จะจุ่ม (ว่าง = ทั้งหมด)"), Values = rarities, Multi = true, Default = {} }))
    xDTaraZ.UI.Toggle(volcano, "VolcanoObby", { Text = T("Auto Volcano Egg", "เก็บไข่ภูเขาไฟอัตโนมัติ"), Description = T("Clears the climb and brings the Volcanic Egg home", "ผ่านด่านแล้วพาไข่ Volcanic กลับบ้าน"), Risky = true })
    xDTaraZ.UI.Status(volcano, "Volcano", "Off")

    local filters = tab:AddRightGroupbox(T("Egg Filters", "ตัวกรองไข่"), "target")
    local minDrop = xDTaraZ.UI.Bind("MinEggRarity", filters:AddDropdown("MinEggRarity", { Text = T("Minimum Egg Rarity", "ความหายากไข่ขั้นต่ำ"), Values = rarities, Default = rarities[1], Description = T("Skips eggs below this rarity", "ข้ามไข่ที่หายากต่ำกว่านี้") }))
    local rarityDrop = xDTaraZ.UI.Bind("EggRarities", filters:AddDropdown("EggRarities", { Text = T("Rarities (empty = all)", "ความหายาก (ว่าง = ทั้งหมด)"), Values = rarities, Multi = true, Default = {} }))
    local nameDrop = xDTaraZ.UI.Bind("EggNames", filters:AddDropdown("EggNames", { Text = T("Eggs (empty = all)", "ไข่ (ว่าง = ทั้งหมด)"), Values = xDTaraZ.UI.Names(xDTaraZ.GameLib.EggInfo), Multi = true, Searchable = true, Default = {} }))
    xDTaraZ.UI.Bind("MinLuck", filters:AddSlider("MinLuck", { Text = T("Minimum Luck (1 in X)", "โชคขั้นต่ำ (1 ใน X)"), Min = 0, Max = 1000000, Default = 0, Rounding = 0 }))
    xDTaraZ.UI.Bind("MinWeight", filters:AddSlider("MinWeight", { Text = T("Minimum Weight", "น้ำหนักขั้นต่ำ"), Min = 1, Max = 3, Default = 1, Rounding = 1, Suffix = "x" }))
    xDTaraZ.UI.Toggle(filters, "SmartEggs", { Text = T("Top Eggs Of The Wave", "เฉพาะไข่ดีของรอบ"), Description = T("Skips eggs worth less than the wave average", "ข้ามไข่ที่ค่าน้อยกว่าค่ากลางของรอบ") })
    filters:AddButton({ Text = T("Refresh Egg List", "รีเฟรชรายการไข่"), Func = function()
        xDTaraZ.GameLib.Build()
        minDrop:SetValues(xDTaraZ.UI.Rarities())
        rarityDrop:SetValues(xDTaraZ.UI.Rarities())
        nameDrop:SetValues(xDTaraZ.UI.Names(xDTaraZ.GameLib.EggInfo))
    end })

    local hunter = tab:AddRightGroupbox(T("Rare Egg Hunter", "ล่าไข่หายาก"), "star")
    xDTaraZ.UI.Toggle(hunter, "EggHunter", { Text = T("Rare Egg Hunter", "ล่าไข่หายาก"), Description = T("Goes for rare eggs first and alerts you when one spawns", "รีบไปเก็บไข่หายากก่อน และแจ้งเตือนเมื่อเกิด") })
    xDTaraZ.UI.Bind("HuntMinRarity", hunter:AddDropdown("HuntMinRarity", { Text = T("Minimum Rarity", "ความหายากขั้นต่ำ"), Values = rarities, Default = xDTaraZ.UI.HuntDefault() }))
    local hop = xDTaraZ.UI.Toggle(hunter, "HunterHop", { Text = T("Hop Servers (beta)", "ย้ายเซิร์ฟหา (ทดลอง)"), Description = T("Moves to another server when none are around", "ย้ายเซิร์ฟเมื่อไม่มีไข่หายาก"), Risky = true })
    Library.Compat.NeedCap(hop, "Queue")
end

function xDTaraZ.UI.Hatching(window)
    local tab = window:AddTab(T("Hatch", "ฟักไข่"), "flower", T("Placing and hatching", "วางและฟักไข่"))

    local place = tab:AddLeftGroupbox(T("Place Eggs", "วางไข่"), "flower")
    xDTaraZ.UI.Toggle(place, "AutoPlaceEggs", { Text = T("Auto Place Eggs", "วางไข่อัตโนมัติ"), Description = T("Fills your plot up to the limit", "วางไข่ลงพล็อตจนเต็มลิมิต") })
    place:AddButton({ Text = T("Place Now", "วางเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach("place now", xDTaraZ.Hatch.PlaceNow) })
    xDTaraZ.UI.Bind("PlantOrder", place:AddDropdown("PlantOrder", { Text = T("Place First", "วางก่อน"), Values = { "Best value", "Fastest growth", "Value per hour" }, Default = "Best value" }))
    xDTaraZ.UI.Bind("PlantKeep", place:AddSlider("PlantKeep", { Text = T("Keep Per Egg", "เก็บไว้ต่อชนิด"), Min = 0, Max = 20, Default = 0, Rounding = 0 }))
    xDTaraZ.UI.Status(place, "Hatch", "Idle")

    local hatch = tab:AddLeftGroupbox(T("Hatching", "ฟักไข่"), "star")
    xDTaraZ.UI.Toggle(hatch, "AutoHatch", { Text = T("Auto Hatch", "ฟักอัตโนมัติ"), Description = T("Hatches eggs from anywhere once they are grown", "ฟักไข่จากที่ไหนก็ได้เมื่อโตเต็มที่") })
    hatch:AddButton({ Text = T("Hatch Now", "ฟักเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach("hatch now", xDTaraZ.Hatch.HatchNow) })
    xDTaraZ.UI.Toggle(hatch, "HoldHatchBoost", { Text = T("Wait For Luck Boost", "รอบูสต์โชค"), Description = T("Holds grown eggs until a luck boost is running", "เก็บไข่ที่โตแล้วไว้ฟักตอนมีบูสต์โชค") })

    local junk = tab:AddRightGroupbox(T("Clear Junk Eggs", "ล้างไข่ขยะ"), "bomb")
    local rarities = xDTaraZ.UI.Rarities()
    xDTaraZ.UI.Toggle(junk, "ClearJunk", { Text = T("Clear Junk Eggs", "ล้างไข่ขยะ"), Description = T("Hatches your cheap eggs and sells the pets that come out", "ฟักไข่ถูกๆ แล้วขายสัตว์ที่ได้") })
    junk:AddButton({ Text = T("Sell Junk Pets Now", "ขายสัตว์ขยะเดี๋ยวนี้"), Style = "Warning", Func = xDTaraZ.UI.Detach("sell junk now", xDTaraZ.Junk.SellNow) })
    xDTaraZ.UI.Bind("JunkRarities", junk:AddDropdown("JunkRarities", { Text = T("Eggs To Clear", "ไข่ที่จะล้าง"), Values = rarities, Multi = true, Default = { "Common", "Rare" } }))
    xDTaraZ.UI.Bind("JunkSellPets", junk:AddDropdown("JunkSellPets", { Text = T("Pets To Sell (empty = auto)", "สัตว์ที่จะขาย (ว่าง = อัตโนมัติ)"), Values = rarities, Multi = true, Default = {}, Description = T("Auto sells what your junk eggs usually give", "อัตโนมัติ = ขายระดับที่ไข่ขยะมักให้") }))
    xDTaraZ.UI.Status(junk, "Junk", "Off")
end

function xDTaraZ.UI.Ranch(tab)
    local ranch = tab:AddLeftGroupbox(T("Ranch", "ฟาร์ม"), "house")
    xDTaraZ.UI.Toggle(ranch, "AutoEquipBest", { Text = T("Auto Place Best Pets", "วางสัตว์ตัวดีสุดอัตโนมัติ"), Description = T("Keeps the highest income pets on your plot", "ใส่สัตว์ที่ทำเงินได้มากสุดลงพล็อตเสมอ") })
    xDTaraZ.UI.Toggle(ranch, "AutoCollectCash", { Text = T("Auto Collect Cash", "เก็บเงินอัตโนมัติ") })
    ranch:AddButton({ Text = T("Place Best Now", "วางตัวดีสุดเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach("place pets", xDTaraZ.Pets.PlaceNow) })
        :AddButton({ Text = T("Collect Now", "เก็บเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach("collect cash", xDTaraZ.Pets.CollectNow) })
    xDTaraZ.UI.Status(ranch, "Pets", "Idle")

    local sell = tab:AddLeftGroupbox(T("Sell Pets", "ขายสัตว์เลี้ยง"), "coin")
    local rarities = xDTaraZ.UI.Rarities()
    xDTaraZ.UI.Toggle(sell, "AutoSell", { Text = T("Auto Sell Pets", "ขายสัตว์อัตโนมัติ"), Description = T("Sells bag pets outside the rarities you keep", "ขายสัตว์ในกระเป๋าที่ไม่อยู่ในความหายากที่เก็บไว้"), Risky = true })
    sell:AddButton({ Text = T("Sell Now", "ขายเดี๋ยวนี้"), Style = "Warning", DoubleClick = true, Func = xDTaraZ.UI.Detach("sell now", function()
        local sold = xDTaraZ.Sell.Now()
        xDTaraZ.Util.Notify("Sell", (sold or 0) > 0 and ("Sold " .. sold .. " pets") or "Nothing to sell with these options", 4)
    end) })
    xDTaraZ.UI.Bind("SellRarities", sell:AddDropdown("SellRarities", { Text = T("Rarities To Keep", "ความหายากที่เก็บไว้"), Values = rarities, Multi = true, Default = {} }))
    xDTaraZ.UI.Bind("SellKeepBest", sell:AddSlider("SellKeepBest", { Text = T("Keep Best Pets", "เก็บตัวดีสุดไว้"), Min = 0, Max = 100, Default = 10, Rounding = 0 }))
    xDTaraZ.UI.Bind("SellUnderIncome", sell:AddInput("SellUnderIncome", { Text = T("Only Below Income /s", "ขายเฉพาะรายได้ต่ำกว่า /วิ"), Default = "0", Numeric = true, Finished = true }))
    xDTaraZ.UI.Bind("SellKeepMutated", sell:AddCheckbox("SellKeepMutated", { Text = T("Keep Mutated Pets", "ไม่ขายตัวมิวเทชัน"), Default = true }))
    xDTaraZ.UI.Status(sell, "SellPreview", "Will sell 0")
end

function xDTaraZ.UI.Care(tab)
    local feed = tab:AddRightGroupbox(T("Feeding", "ให้อาหาร"), "heart")
    xDTaraZ.UI.Toggle(feed, "AutoFeed", { Text = T("Auto Feed", "ให้อาหารอัตโนมัติ") })
    feed:AddButton({ Text = T("Feed Now", "ให้อาหารเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach("feed now", xDTaraZ.Pets.Feed) })
    xDTaraZ.UI.Bind("FoodTypes", feed:AddDropdown("FoodTypes", { Text = T("Foods (empty = all)", "อาหาร (ว่าง = ทั้งหมด)"), Values = table.clone(xDTaraZ.GameLib.FoodOrder), Multi = true, Default = {} }))
    xDTaraZ.UI.Bind("FeedTarget", feed:AddDropdown("FeedTarget", { Text = T("Feed", "ให้อาหาร"), Values = { "Placed", "Ride pet", "All" }, Default = "Placed" }))
    xDTaraZ.UI.Status(feed, "Feed", "Idle")

    local protect = tab:AddRightGroupbox(T("Protect", "ป้องกัน"), "shield")
    local list = xDTaraZ.UI.Bind("ProtectList", protect:AddDropdown("ProtectList", { Text = T("Never Sell Or Fuse", "ห้ามขายหรือหลอม"), Values = xDTaraZ.UI.Names(xDTaraZ.GameLib.PetInfo), Multi = true, Searchable = true, Default = {} }))
    protect:AddButton({ Text = T("Refresh Pets", "รีเฟรชสัตว์"), Func = function()
        list:SetValues(xDTaraZ.UI.Names(xDTaraZ.GameLib.PetInfo))
    end })

    local fuse = tab:AddRightGroupbox(T("Fusion", "หลอมสัตว์"), "bomb")
    local rarities = xDTaraZ.Fusion.Rarities()
    xDTaraZ.UI.Toggle(fuse, "AutoFusion", { Text = T("Auto Fusion", "หลอมสัตว์อัตโนมัติ"), Description = T("Fuses four matching pets and claims the result", "หลอมสัตว์ 4 ตัวที่ตรงเงื่อนไขแล้วรับผล"), Risky = true })
    fuse:AddButton({ Text = T("Fuse Now", "หลอมเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach("fuse now", xDTaraZ.Fusion.Now) })
    xDTaraZ.UI.Bind("FuseRarities", fuse:AddDropdown("FuseRarities", { Text = T("Rarities To Fuse", "ความหายากที่จะหลอม"), Values = rarities, Multi = true, Default = {} }))
    xDTaraZ.UI.Bind("FuseKeepBest", fuse:AddSlider("FuseKeepBest", { Text = T("Keep Best Pets", "เก็บตัวดีสุดไว้"), Min = 0, Max = 100, Default = 10, Rounding = 0 }))
    xDTaraZ.UI.Bind("FuseKeepMutated", fuse:AddCheckbox("FuseKeepMutated", { Text = T("Keep Mutated Pets", "ไม่ใช้ตัวมิวเทชัน"), Default = true }))
    xDTaraZ.UI.Status(fuse, "Fusion", "Idle")
end

function xDTaraZ.UI.PetsTab(window)
    local tab = window:AddTab(T("Pets", "สัตว์เลี้ยง"), "shell", T("Ranch, selling and fusion", "ฟาร์ม ขาย และหลอม"))
    xDTaraZ.UI.Ranch(tab)
    xDTaraZ.UI.Care(tab)
end

function xDTaraZ.UI.Upgrades(window)
    local tab = window:AddTab(T("Upgrades", "อัปเกรด"), "oneup", T("Luck, rebirth, shop, rewards", "โชค รีเบิร์ธ ร้าน รางวัล"))
    local cap = math.max(1, xDTaraZ.GameLib.Rebirths.Cap or 1)

    local up = tab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "oneup")
    xDTaraZ.UI.Toggle(up, "AutoUpgrade", { Text = T("Auto Upgrade Hatch Luck", "อัปโชคฟักอัตโนมัติ"), Description = T("Buys luck upgrades that pay back fast", "ซื้ออัปโชคที่คืนทุนเร็ว") })
    up:AddButton({ Text = T("Upgrade Now", "อัปเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach("upgrade now", xDTaraZ.Economy.UpgradeNow) })
    xDTaraZ.UI.Toggle(up, "SmartSpend", { Text = T("Spend By Payback", "ใช้เงินตามความคุ้ม"), Description = T("Spends on what pays back first and saves for rebirth", "ใช้เงินกับสิ่งที่คืนทุนก่อน และเก็บไว้รีเบิร์ธ") })
    xDTaraZ.UI.Toggle(up, "AutoRebirth", { Text = T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"), Description = T("Rebirths when cash and the needed pet are ready", "รีเบิร์ธเมื่อเงินและสัตว์ที่ต้องใช้พร้อม"), Risky = true })
    up:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Style = "Warning", DoubleClick = true, Func = xDTaraZ.UI.Detach("rebirth now", xDTaraZ.Economy.RebirthNow) })
    xDTaraZ.UI.Bind("RebirthTarget", up:AddSlider("RebirthTarget", { Text = T("Stop At Rebirth", "หยุดที่รีเบิร์ธ"), Min = 1, Max = cap, Default = cap, Rounding = 0 }))
    xDTaraZ.UI.Status(up, "Upgrade", "Idle")

    local shop = tab:AddRightGroupbox(T("Stock Shop", "ร้านสต็อก"), "shop")
    xDTaraZ.UI.Toggle(shop, "AutoShop", { Text = T("Auto Buy Stock", "ซื้อของในร้านอัตโนมัติ"), Description = T("Buys the picked items when they restock", "ซื้อของที่เลือกเมื่อร้านเติมของ") })
    shop:AddButton({ Text = T("Buy Now", "ซื้อเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach("buy now", xDTaraZ.Shop.BuyNow) })
    xDTaraZ.UI.Bind("ShopItems", shop:AddDropdown("ShopItems", { Text = T("Items To Buy", "ของที่จะซื้อ"), Values = xDTaraZ.UI.Values(xDTaraZ.Shop.Labels), Multi = true, Searchable = true, Default = {} }))
    xDTaraZ.UI.Bind("ShopKeepCash", shop:AddInput("ShopKeepCash", { Text = T("Keep Cash", "กันเงินไว้"), Default = "0", Numeric = true, Finished = true }))
    xDTaraZ.UI.Status(shop, "Shop", "Idle")

    local rewards = tab:AddRightGroupbox(T("Rewards", "รางวัล"), "key")
    xDTaraZ.UI.Toggle(rewards, "AutoClaim", { Text = T("Auto Claim Rewards", "รับรางวัลอัตโนมัติ"), Description = T("Index, offline and event rewards", "รางวัลสมุดสะสม ออฟไลน์ และอีเวนต์") })
    rewards:AddButton({ Text = T("Claim All Now", "รับทั้งหมดเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach("claim now", xDTaraZ.Rewards.ClaimNow) })
    xDTaraZ.UI.Status(rewards, "Rewards", "Idle")

    local boosts = tab:AddRightGroupbox(T("Boosts", "บูสต์"), "zap")
    xDTaraZ.UI.Status(boosts, "Boosts", "No boosts running")
end

function xDTaraZ.UI.TeleportTab(window)
    local tab = window:AddTab(T("Teleport", "วาร์ป"), "pipe", T("Places and players", "สถานที่และผู้เล่น"))

    local places = tab:AddLeftGroupbox(T("Places", "สถานที่"), "map")
    local placeDrop = xDTaraZ.UI.Bind("TeleportPlace", places:AddDropdown("TeleportPlace", { Text = T("Place", "สถานที่"), Values = xDTaraZ.UI.Values(xDTaraZ.Teleport.PlaceNames), Searchable = true }))
    places:AddButton({ Text = T("Teleport", "วาร์ป"), Style = "Primary", Func = xDTaraZ.UI.Detach("teleport", function() xDTaraZ.Teleport.To(placeDrop.Value) end) })
        :AddButton({ Text = T("Refresh", "รีเฟรช"), Func = function() placeDrop:SetValues(xDTaraZ.UI.Values(xDTaraZ.Teleport.PlaceNames)) end })

    local players = tab:AddRightGroupbox(T("Players", "ผู้เล่น"), "user")
    local playerDrop = xDTaraZ.UI.Bind("TeleportPlayer", players:AddDropdown("TeleportPlayer", { Text = T("Player", "ผู้เล่น"), SpecialType = "Player", Searchable = true }))
    players:AddButton({ Text = T("Teleport To Player", "วาร์ปไปหาผู้เล่น"), Func = xDTaraZ.UI.Detach("teleport player", function() xDTaraZ.Teleport.ToPlayer(playerDrop.Value) end) })
end

function xDTaraZ.UI.PlayerTab(window)
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and utility", "การเคลื่อนที่และอรรถประโยชน์"))

    local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "zap")
    xDTaraZ.UI.KeyToggle(move, "SpeedOn", { Text = T("Speed", "วิ่งเร็ว") })
    xDTaraZ.UI.Bind("WalkSpeed", move:AddSlider("WalkSpeed", { Text = T("Walk Speed", "ความเร็ว"), Min = 16, Max = 300, Default = Config.WalkSpeed, Rounding = 0 }))
    xDTaraZ.UI.KeyToggle(move, "JumpOn", { Text = T("Jump Power", "กระโดดสูง") })
    xDTaraZ.UI.Bind("JumpPower", move:AddSlider("JumpPower", { Text = T("Jump Power", "แรงกระโดด"), Min = 50, Max = 300, Default = Config.JumpPower, Rounding = 0 }))
    xDTaraZ.UI.KeyToggle(move, "InfJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด") })

    local troll = tab:AddLeftGroupbox(T("Troll", "ป่วน"), "troll")
    xDTaraZ.UI.Bind("TrollTarget", troll:AddDropdown("TrollTarget", { Text = T("Target", "เป้าหมาย"), SpecialType = "Player", Searchable = true }))
    xDTaraZ.UI.Toggle(troll, "Fling", { Text = T("Fling", "เหวี่ยงกระเด็น"), Description = T("Pauses egg farming while on", "หยุดฟาร์มไข่ชั่วคราวระหว่างเปิด"), Risky = true })
    xDTaraZ.UI.Toggle(troll, "Stick", { Text = T("Stick To Player", "เกาะติดผู้เล่น"), Description = T("Pauses egg farming while on", "หยุดฟาร์มไข่ชั่วคราวระหว่างเปิด"), Risky = true })
    troll:AddButton({ Text = T("Spectate", "ส่องดู"), Func = function() xDTaraZ.Troll.Spectate(xDTaraZ.Options.TrollTarget) end })
        :AddButton({ Text = T("Stop", "เลิกส่อง"), Func = function() xDTaraZ.Troll.Spectate(nil) end })

    local fly = tab:AddRightGroupbox(T("Fly and Noclip", "บินและเดินทะลุ"), "pipe")
    local flyToggle = xDTaraZ.UI.KeyToggle(fly, "Fly", { Text = T("Fly", "บิน") })
    xDTaraZ.UI.Bind("FlySpeed", fly:AddSlider("FlySpeed", { Text = T("Fly Speed", "ความเร็วบิน"), Min = 20, Max = 500, Default = Config.FlySpeed, Rounding = 0 }))
    xDTaraZ.UI.KeyToggle(fly, "NoClip", { Text = T("Noclip", "เดินทะลุ") })
    xDTaraZ.UI.CarryGuard(flyToggle)

    local misc = tab:AddRightGroupbox(T("Utility", "อรรถประโยชน์"), "gear")
    xDTaraZ.UI.Toggle(misc, "AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK") })
    xDTaraZ.UI.Toggle(misc, "AutoReconnect", { Text = T("Auto Reconnect", "เข้าเกมใหม่อัตโนมัติ"), Description = T("Joins back and reloads the hub after a disconnect", "หลุดแล้วเข้าเกมใหม่และโหลดสคริปต์ให้เอง") })
    misc:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟใหม่"), Func = xDTaraZ.UI.Detach("rejoin", xDTaraZ.Server.Rejoin) })
        :AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Func = xDTaraZ.UI.Detach("hop", xDTaraZ.Server.Hop) })

    local esp = tab:AddRightGroupbox(T("Egg ESP", "มองเห็นไข่"), "eye")
    xDTaraZ.UI.KeyToggle(esp, "EggEsp", { Text = T("Egg ESP", "มองเห็นไข่"), Description = T("Shows eggs through walls with rarity and distance", "แสดงไข่ทะลุกำแพง พร้อมความหายากและระยะ") })
    xDTaraZ.UI.Bind("EspMinRarity", esp:AddDropdown("EspMinRarity", { Text = T("Minimum Rarity", "ความหายากขั้นต่ำ"), Values = xDTaraZ.UI.Rarities(), Default = xDTaraZ.GameLib.RarityOrder[1] }))

    local perf = tab:AddRightGroupbox(T("Performance", "ประสิทธิภาพ"), "zap")
    xDTaraZ.UI.Toggle(perf, "HideOtherPets", { Text = T("Hide Other Pets", "ซ่อนสัตว์คนอื่น"), Description = T("Only your own pets stay visible", "เห็นแค่สัตว์ของเรา") })
    xDTaraZ.UI.Toggle(perf, "HideOtherEggs", { Text = T("Hide Other Eggs", "ซ่อนไข่คนอื่น"), Description = T("Hides eggs on other players' bases", "ซ่อนไข่ในฐานคนอื่น") })
    xDTaraZ.UI.Toggle(perf, "BoostFps", { Text = T("Boost FPS", "เพิ่ม FPS"), Description = T("Lower graphics for smoother play", "ลดกราฟิกให้ลื่นขึ้น") })
    xDTaraZ.UI.Toggle(perf, "UnlockFps", { Text = T("FPS Cap", "จำกัด FPS") })
    xDTaraZ.UI.Bind("FpsCap", perf:AddSlider("FpsCap", { Text = T("Max FPS", "FPS สูงสุด"), Min = 30, Max = 240, Default = Config.FpsCapDefault, Rounding = 0 }))
    xDTaraZ.UI.Toggle(perf, "Render3D", { Text = T("Disable 3D Rendering", "ปิดการเรนเดอร์ 3D"), Description = T("Black screen to save power while farming AFK", "จอดำ ประหยัดเครื่องตอนฟาร์ม AFK") })
end

local function BuildTabs()
    local window = Library.Window
    local try = xDTaraZ.Util.Try

    window:AddTabSection(T("Main", "หลัก"))
    try("ui home", xDTaraZ.UI.Home, window)

    window:AddTabSection(T("Farming", "ฟาร์ม"))
    try("ui eggs", xDTaraZ.UI.EggFarm, window)
    try("ui hatch", xDTaraZ.UI.Hatching, window)

    window:AddTabSection(T("Progression", "พัฒนา"))
    try("ui pets", xDTaraZ.UI.PetsTab, window)
    try("ui upgrades", xDTaraZ.UI.Upgrades, window)

    window:AddTabSection(T("Misc", "อื่นๆ"))
    try("ui teleport", xDTaraZ.UI.TeleportTab, window)
    try("ui player", xDTaraZ.UI.PlayerTab, window)
    try("ui settings", window.AddSettingsTab, window)

    try("ui floats", xDTaraZ.Move.BuildFloats, xDTaraZ.UI.Floats)
    Library:Every(Config.PumpTick, function() try("ui pump", xDTaraZ.UI.Pump) end)
end

---@return boolean  menu is up
function xDTaraZ.Boot()
    Library = xDTaraZ.Util.LoadLibrary(Config.UiSource)
    if not Library then return false end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Ride A Pet by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = "Ride A Pet",
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            xDTaraZ.Util.Try("gamelib load", xDTaraZ.GameLib.LoadModules)
            xDTaraZ.Util.Try("gamelib build", xDTaraZ.GameLib.Build)
            xDTaraZ.Util.Try("ui build", BuildTabs)
            xDTaraZ.Util.Try("scheduler", xDTaraZ.Scheduler.Boot)
            xDTaraZ.Util.Try("autoload config", Library.LoadAutoloadConfig, Library)
            task.spawn(function()
                xDTaraZ.Util.Try("gamelib check", xDTaraZ.GameLib.Check)
                xDTaraZ.Util.Try("ui gate", xDTaraZ.UI.Gate)
            end)
        end,
    })
    xDTaraZ.BindTeardown(RunService.Heartbeat)
    Library:OnUnload(function() xDTaraZ:Unload() end)
    return true
end

xDTaraZ.Util.Try("boot", xDTaraZ.Boot)