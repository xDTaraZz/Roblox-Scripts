if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765012427 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Build the Pyramid only")
    return
end

local MarioBanner = {
    Print = print,
    Started = os.clock(),
    Last = os.clock(),
    Done = 0,
    Total = 4,
}

do
    local ok, renv = pcall(getrenv)
    if ok and type(renv) == "table" and type(renv.print) == "function" then MarioBanner.Print = renv.print end
end

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
        "   BUILD THE PYRAMID  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local osClock = os.clock
local vector3New = Vector3.new

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UpdateLog = {
        { "2026-10-10", "Updated for the new game version\nFaster farm loop\nAuto Free Gift and Train While Waiting\nStop targets for farm and training\nFixed unloading, Balanced training and upgrade checks" },
        { "2026-10-04", "Auto Farm twice as fast\nPlace Distance option\nBalanced mode trains Strength only when it pays back\nAuto Upgrade buys the best upgrade first\nPick your Bench and Treadmill gym\nSpend Banked Blocks & Claim Free Gift\nRemoved keybinds from auto features" },
    },
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    ReloadSource = [[
local url = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/loader.lua"
local ok, body = pcall(game.HttpGet, game, url)
if not (ok and type(body) == "string") then
    local requester = request or http_request or (syn and syn.request) or (http and http.request)
    local sent, reply = pcall(requester, { Url = url, Method = "GET" })
    body = sent and type(reply) == "table" and reply.Body
end
if type(body) == "string" then loadstring(body)() end]],
    SaveFolder = "Build the Pyramid",
    TickDelay = 0.1,
    LoadTimeout = 10,
    AlertTries = 20,
    AlertGap = 0.5,
    FailLimit = 5,
    FailWindow = 10,
    SettleDelay = 0.15,
    StreamWait = 2,
    StreamDistance = 200,
    CameraShieldJump = 100,
    PickupRetries = 3,
    PickupTimeout = 2,
    BenchBase = 3.75,
    LevelProbe = 1000,
    SmartRefresh = 2,
    RateSample = 15,
    SaveSeconds = 600,
    UnmeasuredGain = 1e9,
    ConfirmTimeout = 3,
    QuarryJitter = 0.35,
    RetryDelay = 1,
    RetryMax = 8,
    StallLimit = 120,
    PlaceTimeout = 3,
    PlaceRetries = 3,
    SlotSpacing = 2,
    SlotSearchCells = 150,
    EngineRadiusLimit = 15000,
    HoverHeight = 6,
    StandHeight = 3,
    QuarrySpot = vector3New(-234, -16, 38),
    BenchRange = 12,
    BenchRetry = 2,
    StandRadius = 4,
    UpgradeInterval = 2,
    UpgradeGap = 0.3,
    UpgradeBurst = 36,
    CodeGap = 1.1,
    ActivityInterval = 60,
    RateWindow = 60,
    RejoinDelay = 5,
    BankInterval = 10,
    BankSettle = 1,
    GiftInterval = 30,
    BoostInterval = 30,
    FlyKeys = { Up = Enum.KeyCode.Space, Down = Enum.KeyCode.Q },
    AutoOptions = { "AutoFarm", "AutoStrength", "AutoSpeed", "AutoPool", "AutoUpgrade", "AutoGift", "TrainWhileWaiting" },
    CodeFinal = { Redeemed = true, AlreadyRedeemed = true, Expired = true, FullyClaimed = true },
    CodeLabels = { Redeemed = "redeemed", AlreadyRedeemed = "already used", Expired = "expired", FullyClaimed = "fully claimed", InvalidCode = "invalid", NoReply = "no reply" },
    SlowRequests = { UpgradeNow = true, CodesNow = true, GiftNow = true, Hop = true },
    ExtraCodes = { "SUNGOD", "SORRYFORUPDATEBUG", "FREECODE", "WELCOME", "DEADBYMELOL", "UPDATE15", "PYRAMID1500" },
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    MoveConns = {},
    Requests = {},
    Running = {},
    Messages = {},
    Last = {},
    Stats = {},
    CoinLog = {},
    CycleLog = {},
    CodeDone = {},
    UpgradeGain = {},
    BankRefused = {},
    Fails = {},
    FailSince = {},
    Halted = {},
    HaltQueue = {},
    Status = "Idle",
    Task = "None",
    Placed = 0,
    FarmWait = 0,
    Opt = {
        AutoFarm = false,
        ReturnOnStop = false,
        StopCoins = 0,
        StopPyramids = 0,
        TrainWhileWaiting = false,
        TargetStrength = 0,
        TargetSpeed = 0,
        AutoGift = false,
        UpgradeMax = {},
        PlaceReach = 30,
        BenchStation = "Best Unlocked",
        TreadmillStation = "Best Unlocked",
        AutoUpgrade = false,
        Upgrades = {},
        UpgradeOrder = "Best Value",
        KeepCoins = 0,
        AutoStrength = false,
        AutoSpeed = false,
        Priority = "Balanced",
        SmartMinutes = 30,
        AlternateMinutes = 5,
        AutoPool = false,
        SpeedOn = false,
        WalkSpeed = 100,
        Fly = false,
        FlySpeed = 60,
        Noclip = false,
        InfJump = false,
        AntiAfk = false,
        AutoRejoin = false,
        NoRender = false,
    },
}

local Config, State = xDTaraZ.Config, xDTaraZ.State

xDTaraZ.Util = {}

---@return string?, string?  body, or nil and why every transport failed
function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then return body end
    local requester = request or http_request or (syn and syn.request) or (http and http.request)
    if not requester then return nil, "no http function" end

    local sent, reply = pcall(requester, { Url = url, Method = "GET" })
    if not sent or type(reply) ~= "table" then return nil, tostring(reply) end
    if reply.StatusCode ~= 200 or type(reply.Body) ~= "string" then return nil, "HTTP " .. tostring(reply.StatusCode) end
    return reply.Body
end

---@param detail any?  extra context for the console only
function xDTaraZ.Util.Alert(text, detail)
    warn("[BuildThePyramid]", text, detail or "")
    task.spawn(function()
        local starterGui = game:GetService("StarterGui")
        for _ = 1, Config.AlertTries do
            local shown = pcall(starterGui.SetCore, starterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 })
            if shown then return end
            task.wait(Config.AlertGap)
        end
    end)
end

---@return boolean  fn finished without error
function xDTaraZ.Util.Try(label, fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[BuildThePyramid] " .. label .. ":", err) end
    return ok
end

---@return table?, string?  UI library, or nil and a message for the player
function xDTaraZ.Util.LoadLibrary(url)
    local source, why = xDTaraZ.Util.HttpGet(url)
    if not source or not source:sub(-64):find("return%s+Library%s*$") then
        warn("[BuildThePyramid] ui download:", why or "truncated or not the library")
        return nil, "Could not download the menu. Check your connection and run it again."
    end
    local chunk, compileErr = loadstring(source)
    if not chunk then return nil, "The menu failed to load on this executor: " .. tostring(compileErr) end
    local ok, lib = pcall(chunk)
    if not ok or type(lib) ~= "table" then return nil, "The menu failed to load on this executor: " .. tostring(lib) end
    return lib
end

---@return boolean  the hub is queued to load again after the next teleport
function xDTaraZ.Util.QueueReload()
    local queue = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport)
    if not queue then return false end
    return (pcall(queue, Config.ReloadSource))
end

function xDTaraZ.Util.Copy(text)
    local copy = setclipboard or toclipboard
    if not copy then return false end
    return (pcall(copy, text))
end

local bootMissed = false

---@return Instance?  child, nil once Config.LoadTimeout runs out; no waiting after the first miss
local function Wait(parent, name)
    if not parent then return nil end
    if bootMissed then return parent:FindFirstChild(name) end
    local child = parent:WaitForChild(name, Config.LoadTimeout)
    if not child then bootMissed = true end
    return child
end

---@return Instance?  Services folder of whichever knit version the game ships
local function FindKnitServices()
    local index = Wait(Wait(ReplicatedStorage, "Packages"), "_Index")
    if not index then return nil end
    local fallback
    for _, package in ipairs(index:GetChildren()) do
        if not package.Name:find("^sleitnick_knit") then continue end
        local knit = package:FindFirstChild("knit")
        local services = knit and knit:FindFirstChild("Services")
        if services then return services end
        fallback = fallback or knit
    end
    return Wait(fallback, "Services")
end

local Shared = Wait(ReplicatedStorage, "Shared")
local SharedConfig = Wait(Shared, "Config")
local KnitServices = FindKnitServices()

if not (SharedConfig and KnitServices) then
    xDTaraZ.Util.Alert("Build the Pyramid was updated and this script needs an update too. Join discord.gg/FHVfmeSceA",
        SharedConfig and "knit Services folder not found" or "Shared.Config not found")
    return
end

---@return Instance?  RF/RE under a Knit service, found by name when the service moved; nil if renamed
local function Remote(service, kind, name)
    local remote = Wait(Wait(Wait(KnitServices, service), kind), name)
    if remote then return remote end
    for _, node in ipairs(KnitServices:GetDescendants()) do
        if node.Name == name and node.Parent and node.Parent.Name == kind then return node end
    end
    return nil
end

xDTaraZ.GameLib = {}
local GameLib = xDTaraZ.GameLib

---@return boolean, any  ok and module, required from a fresh identity-2 thread
function GameLib.RequireAsGame(module)
    if GameLib.CanSwitch == false then return false, nil end

    local done, ok, loaded = false, false, nil
    task.spawn(function()
        local switched = pcall(setthreadidentity, 2)
        local read, identity = pcall(getthreadidentity)
        if switched and read and identity == 2 then
            ok, loaded = pcall(require, module)
        else
            GameLib.CanSwitch = false
        end
        done = true
    end)
    local deadline = osClock() + Config.LoadTimeout
    while not done and osClock() < deadline do task.wait() end
    return ok, loaded
end

---@return any?  module, nil when it is missing or no identity can require it
function GameLib.Require(module)
    if not (module and module:IsA("ModuleScript")) then return nil end
    local ok, loaded = pcall(require, module)
    if ok then return loaded end
    local retried, again = GameLib.RequireAsGame(module)
    if retried then return again end
    warn("[BuildThePyramid] require " .. module.Name .. ":", loaded)
    return nil
end

do
    local modules = {
        Pyramid = Wait(SharedConfig, "PyramidConfig"),
        Carry = Wait(SharedConfig, "CarryConfig"),
        Upgrades = Wait(SharedConfig, "UpgradeCatalog"),
        Gym = Wait(SharedConfig, "GymConfig"),
        Codes = Wait(SharedConfig, "CodesConfig"),
        Completion = Wait(SharedConfig, "PyramidCompletionConfig"),
        GymAccess = Wait(Wait(Shared, "Gym"), "GymAccess"),
        Runtime = Wait(Wait(Shared, "Placement"), "PyramidRuntime"),
        CarryState = Wait(Wait(Shared, "Books"), "CarryState"),
        Regions = Wait(Shared, "RegionRegistry"),
        Knit = Wait(Wait(ReplicatedStorage, "Packages"), "Knit"),
        Progression = Wait(Wait(Shared, "Stats"), "StatProgression"),
    }
    for key, module in pairs(modules) do
        GameLib[key] = GameLib.Require(module)
    end
end

GameLib.Pickup = Remote("BlockService", "RF", "Pickup")
GameLib.Place = Remote("PyramidService", "RF", "Place")
GameLib.Purchase = Remote("DataService", "RF", "PurchaseUpgrade")
GameLib.StartBench = Remote("GymService", "RF", "StartBench")
GameLib.StopBench = Remote("GymService", "RF", "StopBench")
GameLib.Redeem = Remote("CodesService", "RF", "Redeem")
GameLib.Activity = Remote("AFKService", "RE", "Activity")
GameLib.SpendBlocks = Remote("PyramidService", "RF", "SpendBankedBlocks")
GameLib.SpendSeconds = Remote("PyramidService", "RF", "SpendBankedSeconds")
GameLib.GiftClaim = Remote("FreeGiftService", "RF", "Claim")
GameLib.GiftStep = Remote("FreeGiftService", "RF", "MarkStep")
GameLib.GiftState = Remote("FreeGiftService", "RF", "GetState")
GameLib.GiftChanged = Remote("FreeGiftService", "RE", "StateChanged")
GameLib.BoostState = Remote("ServerBoostService", "RF", "GetState")

xDTaraZ.UpgradeByName = {}
xDTaraZ.UpgradeNames = {}
do
    for _, upgrade in ipairs(GameLib.Upgrades and GameLib.Upgrades.Upgrades or {}) do
        xDTaraZ.UpgradeByName[upgrade.DisplayName] = upgrade
        table.insert(xDTaraZ.UpgradeNames, upgrade.DisplayName)
    end
end

xDTaraZ.CodeList = {}
do
    local seen = {}
    local function Add(code)
        if seen[code] then return end
        seen[code] = true
        xDTaraZ.CodeList[#xDTaraZ.CodeList + 1] = code
    end
    for code in pairs(GameLib.Codes and GameLib.Codes.Codes or {}) do Add(code) end
    for _, code in ipairs(Config.ExtraCodes) do Add(code) end
end

xDTaraZ.Gate = {
    Needs = {
        AutoFarm = { "Pyramid", "Carry", "CarryState", "Runtime", "Regions", "Upgrades", "Pickup", "Place" },
        AutoStrength = { "Gym", "GymAccess", "StartBench", "StopBench" },
        AutoSpeed = { "Gym", "GymAccess" },
        AutoPool = { "Pyramid", "Completion" },
        AutoUpgrade = { "Upgrades", "Purchase", "Knit" },
        AutoGift = { "GiftState", "GiftStep", "GiftClaim" },
        TrainWhileWaiting = { "Gym", "GymAccess", "StartBench", "StopBench" },
    },
}

---@return string?  first game module or remote the option needs that was not found
function xDTaraZ.Gate.Missing(idx)
    for _, key in ipairs(xDTaraZ.Gate.Needs[idx] or {}) do
        if GameLib[key] == nil then return key end
    end
    return nil
end

function xDTaraZ.Gate.Ready(idx)
    return xDTaraZ.Gate.Missing(idx) == nil
end

function xDTaraZ.Format(n)
    n = tonumber(n) or 0
    local units = { "", "K", "M", "B", "T", "Qa", "Qi" }
    local i = 1
    while math.abs(n) >= 1000 and i < #units do
        n /= 1000
        i += 1
    end
    return (i == 1 and "%d%s" or "%.2f%s"):format(n, units[i])
end

function xDTaraZ:Notify(msg)
    table.insert(self.State.Messages, msg)
end

function xDTaraZ:Character()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp and hum.Health > 0) then return nil end
    return char, hum, hrp
end

function xDTaraZ:Invoke(remote, ...)
    if not remote then return false, "missing remote" end
    local packed = table.pack(pcall(remote.InvokeServer, remote, ...))
    if not packed[1] then
        warn("[BuildThePyramid]", remote.Name, packed[2])
        return false, packed[2]
    end
    return table.unpack(packed, 2, packed.n)
end

xDTaraZ.Game = {}

function xDTaraZ.Game.Attr(name)
    return LocalPlayer:GetAttribute(name)
end

function xDTaraZ.Game.UpgradeLevel(upgrade)
    return tonumber(LocalPlayer:GetAttribute(GameLib.Upgrades.AttributePrefix .. upgrade.Attribute)) or 0
end

function xDTaraZ.Game.Capacity()
    local base = GameLib.Carry and tonumber(GameLib.Carry.Capacity) or 0
    return base + (tonumber(xDTaraZ.Game.Attr("StrengthLevel")) or 0)
end

function xDTaraZ.Game.Carried()
    if State.Carry then return State.Carry end
    if GameLib.CarryState then
        local ok, state = pcall(GameLib.CarryState.read, LocalPlayer)
        local count = ok and type(state) == "table" and tonumber(state.count)
        if count then return count end
    end
    return tonumber(xDTaraZ.Game.Attr("CarriedCount")) or 0
end

function xDTaraZ.Game.Coins()
    return tonumber(State.Stats.Coins) or 0
end

function xDTaraZ.Game.Benching()
    if not GameLib.Gym then return nil end
    local station = xDTaraZ.Game.Attr(GameLib.Gym.BenchStationAttribute)
    return type(station) == "string" and station ~= "" and station or nil
end

function xDTaraZ.Game.Model()
    return Workspace:FindFirstChild(GameLib.Pyramid.ModelName)
end

---@return boolean  completion window running (pool is open)
function xDTaraZ.Game.Completed()
    local model = xDTaraZ.Game.Model()
    if not model then return false end
    if model:GetAttribute(GameLib.Pyramid.CompleteAttribute) == true then return true end
    local endsAt = tonumber(model:GetAttribute(GameLib.Completion.CompletionEndsAtAttribute)) or 0
    return endsAt > Workspace:GetServerTimeNow()
end

---@param carryState any  "revision:count:..." string from a Pickup/Place reply
---@return number?         blocks held, nil when the reply carries no state
function xDTaraZ.Game.ReadCarry(carryState)
    if type(carryState) ~= "string" then return nil end
    local ok, decoded = pcall(GameLib.CarryState.decode, carryState)
    return ok and type(decoded) == "table" and tonumber(decoded.count) or nil
end

function xDTaraZ.Game.WatchStats()
    local ok, err = pcall(function()
        GameLib.Knit.OnStart():await()
        local prop = GameLib.Knit.GetService("DataService").StatValues
        local conn = prop:Observe(function(values)
            if type(values) ~= "table" then return end
            local before = tonumber(State.Stats.Coins)
            local now = tonumber(values.Coins)
            if before and now and now > before then table.insert(State.CoinLog, { osClock(), now - before }) end
            State.Stats = values
        end)
        table.insert(State.Connections, conn)
    end)
    if not ok then warn("[BuildThePyramid] stats:", err) end
end

xDTaraZ.Move = {}

---@param pos Vector3  streams the area in the background, gives up after Config.StreamWait
function xDTaraZ.Move.Stream(pos)
    local finished = false
    task.spawn(function()
        pcall(LocalPlayer.RequestStreamAroundAsync, LocalPlayer, pos, Config.StreamWait)
        finished = true
    end)
    local deadline = osClock() + Config.StreamWait
    while not finished and osClock() < deadline do task.wait() end
end

---Holds the camera script off for two frames so a long jump does not make the game's held-item shield query an out-of-range radius.
function xDTaraZ.Move.FreezeCamera()
    local camera = Workspace.CurrentCamera
    if not camera or camera.CameraType ~= Enum.CameraType.Custom then return end
    camera.CameraType = Enum.CameraType.Scriptable
    task.spawn(function()
        RunService.RenderStepped:Wait()
        RunService.RenderStepped:Wait()
        if camera.CameraType == Enum.CameraType.Scriptable then camera.CameraType = Enum.CameraType.Custom end
    end)
end

---@param stream boolean?  ask the engine to load the destination first (far targets only)
function xDTaraZ.Move.To(pos, stream)
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return false end
    if stream and (hrp.Position - pos).Magnitude > Config.StreamDistance then xDTaraZ.Move.Stream(pos) end
    hrp.AssemblyLinearVelocity = Vector3.zero
    local freezeCamera = (hrp.Position - pos).Magnitude > Config.CameraShieldJump
    if freezeCamera then xDTaraZ.Move.FreezeCamera() end
    hrp.CFrame = CFrame.new(pos) * hrp.CFrame.Rotation
    return true
end

function xDTaraZ.Move.Near(pos, radius)
    local _, _, hrp = xDTaraZ:Character()
    return hrp ~= nil and (hrp.Position - pos).Magnitude <= (radius or Config.StandRadius)
end

---@param jitter boolean?  pick a random spot inside the region instead of its centre
function xDTaraZ.Move.QuarrySpot(jitter)
    local region = GameLib.Regions.getPart("Quarry")
    if not (region and region:IsA("BasePart")) then return Config.QuarrySpot end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LocalPlayer.Character, region, Workspace:FindFirstChild(GameLib.Pyramid.QuarryFolderName) }

    local top = region.Position + vector3New(0, region.Size.Y / 2, 0)
    if jitter then
        local spread = Config.QuarryJitter
        top += region.CFrame:VectorToWorldSpace(vector3New(
            (math.random() * 2 - 1) * region.Size.X * spread, 0, (math.random() * 2 - 1) * region.Size.Z * spread))
    end
    local hit = Workspace:Raycast(top, vector3New(0, -region.Size.Y - 50, 0), params)
    local spot = hit and hit.Position + vector3New(0, Config.StandHeight, 0)
    if spot and GameLib.Regions.isWithin("Quarry", spot) then return spot end
    return Config.QuarrySpot
end

function xDTaraZ.Move.GymPart(folder, model, part)
    local gym = Workspace:FindFirstChild(GameLib.Gym.GymFolderName)
    local station = gym and gym:FindFirstChild(folder)
    local machine = station and station:FindFirstChild(model)
    local found = machine and machine:FindFirstChild(part)
    return found and found:IsA("BasePart") and found or nil
end

function xDTaraZ.Move.PoolSpot()
    local display = Workspace:FindFirstChild(GameLib.Completion.CompletedDisplayName)
    local hitbox = display and display:FindFirstChild(GameLib.Completion.PoolHitboxName)
    return hitbox and hitbox:IsA("BasePart") and hitbox.Position or nil
end

function xDTaraZ.Move.Frame()
    local char, hum, hrp = xDTaraZ:Character()
    if not char then return end
    if State.Opt.SpeedOn and not State.Opt.Fly and hum.MoveDirection.Magnitude > 0 then
        local velocity = hrp.AssemblyLinearVelocity
        local speed = math.max(State.Opt.WalkSpeed, hum.WalkSpeed)
        hrp.AssemblyLinearVelocity = vector3New(hum.MoveDirection.X * speed, velocity.Y, hum.MoveDirection.Z * speed)
    end
    if State.Opt.Noclip then
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide then
                State.Collided[part] = true
                part.CanCollide = false
            end
        end
    end
    if not State.Opt.Fly then return end
    local cam = Workspace.CurrentCamera
    local dir = hum.MoveDirection
    local lift = cam and dir.Magnitude > 0 and cam.CFrame.LookVector.Y * dir.Magnitude or 0
    local typing = UserInputService:GetFocusedTextBox() ~= nil
    if not typing and (UserInputService:IsKeyDown(Config.FlyKeys.Up) or hum.Jump) then lift += 1 end
    if not typing and UserInputService:IsKeyDown(Config.FlyKeys.Down) then lift -= 1 end

    hum.PlatformStand = true
    hrp.AssemblyLinearVelocity = (dir + vector3New(0, lift, 0)) * State.Opt.FlySpeed
end

function xDTaraZ.Move.Refresh()
    local opt = State.Opt
    local want = opt.Fly or opt.Noclip or opt.SpeedOn
    if want and #State.MoveConns == 0 then
        State.Collided = State.Collided or {}
        table.insert(State.MoveConns, RunService.Stepped:Connect(xDTaraZ.Move.Frame))
    elseif not want then
        for _, conn in ipairs(State.MoveConns) do conn:Disconnect() end
        table.clear(State.MoveConns)
    end
    if not opt.Noclip and State.Collided then
        for part in pairs(State.Collided) do
            if part.Parent then part.CanCollide = true end
        end
        table.clear(State.Collided)
    end
    local _, hum = xDTaraZ:Character()
    if hum and not opt.Fly and hum.PlatformStand then hum.PlatformStand = false end
end

xDTaraZ.Farm = {}

function xDTaraZ.Farm.Progress()
    State.StallSince, State.Backoff = nil, nil
end

---@param reason string  shown while the farm waits; raised once the stall passes Config.StallLimit
---@return boolean       always false, so lower jobs get the character meanwhile
function xDTaraZ.Farm.Hold(reason)
    local now = osClock()
    State.StallSince = State.StallSince or now
    if now - State.StallSince > Config.StallLimit then
        State.Waiting = nil
        error(reason:lower() .. " for " .. Config.StallLimit .. "s", 0)
    end
    State.Backoff = State.Backoff and math.min(State.Backoff * 2, Config.RetryMax) or Config.RetryDelay
    State.FarmWait = now + State.Backoff
    State.Waiting = reason .. ", retrying"
    return false
end

---@return boolean  the server had you flagged AFK and was told you are back
function xDTaraZ.Farm.Wake()
    if xDTaraZ.Game.Attr("IsAFK") ~= true or not GameLib.Activity then return false end
    GameLib.Activity:FireServer()
    return true
end

function xDTaraZ.Farm.Park()
    if State.Parked then return end
    State.Parked = true
    xDTaraZ.Move.To(xDTaraZ.Move.QuarrySpot())
end

---@param calls number  pickups fired at once; the server stops granting at capacity
---@return number, number  blocks carried after the batch, calls that were refused or never answered
function xDTaraZ.Farm.GrabBatch(region, calls, carried)
    local token = {}
    State.GrabToken = token
    local pending, failed = calls, 0
    for _ = 1, calls do
        task.spawn(function()
            local ok, carryState = xDTaraZ:Invoke(GameLib.Pickup, region)
            if State.GrabToken ~= token then return end
            if ok == true then
                carried = math.max(carried, xDTaraZ.Game.ReadCarry(carryState) or carried)
            else
                failed += 1
            end
            pending -= 1
        end)
    end

    local deadline = osClock() + Config.PickupTimeout
    while pending > 0 and osClock() < deadline do task.wait() end
    State.GrabToken = nil
    return carried, failed + pending
end

---@param calls number  pickups needed to fill up; only the refused ones are fired again
---@return number       blocks carried after every round
function xDTaraZ.Farm.GrabAll(region, calls)
    local start = xDTaraZ.Game.Carried()
    local carried, cap = start, xDTaraZ.Game.Capacity()
    for _ = 0, Config.PickupRetries do
        if calls <= 0 or carried >= cap or not State.Alive then break end
        carried, calls = xDTaraZ.Farm.GrabBatch(region, calls, carried)
        if calls > 0 then task.wait() end
    end

    if carried > start then
        State.Carry = carried
        xDTaraZ.Farm.Progress()
    end
    return carried
end

---@return boolean, string?  holding at least one block, else why not
function xDTaraZ.Farm.Gather()
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    local cap = xDTaraZ.Game.Capacity()
    if xDTaraZ.Game.Carried() >= cap then return true end

    State.Status = "Picking up blocks"
    if not xDTaraZ.Move.To(xDTaraZ.Move.QuarrySpot(State.Backoff ~= nil)) then return false, "Character not ready" end

    local region = GameLib.Regions.getPart("Quarry")
    local grant = 1 + xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPickup)
    local carried = xDTaraZ.Farm.GrabAll(region, math.ceil((cap - xDTaraZ.Game.Carried()) / grant))
    if carried > 0 then return true end

    State.Carry = nil
    if xDTaraZ.Game.Carried() > 0 then return true end
    if xDTaraZ.Farm.Wake() then return false, "Marked AFK, waking up" end
    return false, "Quarry refused blocks"
end

---@return table?  geometry of the tier being built, same one the slot resolver uses
function xDTaraZ.Farm.Geometry()
    local context = GameLib.Runtime.getContext(Workspace)
    return context and context.geometry
end

---@param cells number  ring count wanted
---@return number       ring count whose stud radius stays inside the engine's spatial query limit
function xDTaraZ.Farm.ClampCells(cells)
    return math.min(cells, math.floor(Config.EngineRadiusLimit / GameLib.Pyramid.BlockSize))
end

---@return number  rings that reach every cell of the current layer
function xDTaraZ.Farm.SearchCells()
    local geometry = xDTaraZ.Farm.Geometry()
    local layer = GameLib.Runtime.getCurrentLayer(Workspace)
    local side = geometry and layer and geometry.getLayerSide(layer) or Config.SlotSearchCells
    return xDTaraZ.Farm.ClampCells(math.min(side, Config.SlotSearchCells))
end

---@param from Vector3  used until the first block lands
---@return table?        free slot on the current layer, searched from the last placed block
function xDTaraZ.Farm.FirstSlot(from)
    return GameLib.Runtime.resolveNearestSlot(State.LastSlot or from, Workspace, nil, xDTaraZ.Farm.SearchCells())
end

---@param origin Vector3  where the character stands
---@param count number     slots wanted
---@return table[]         free slots in reach, far enough apart that bulk fills do not overlap
function xDTaraZ.Farm.Slots(origin, count, radius)
    local picked, cells, rejected = {}, {}, {}
    local geometry = xDTaraZ.Farm.Geometry()
    if not geometry then return picked end
    local function Skip(layer, index)
        if rejected[layer .. ":" .. index] then return true end
        local col, row = geometry.fromSlotIndex(layer, index)
        if not (col and row) then return false end
        for _, cell in ipairs(cells) do
            if cell.layer == layer and math.max(math.abs(cell.col - col), math.abs(cell.row - row)) < Config.SlotSpacing then
                return true
            end
        end
        return false
    end
    for _ = 1, count * 3 do
        if #picked >= count then break end
        local slot = GameLib.Runtime.resolveNearestSlot(origin, Workspace, Skip, xDTaraZ.Farm.ClampCells(radius))
        if not slot then break end
        local flat = vector3New(slot.position.X - origin.X, 0, slot.position.Z - origin.Z)
        local col, row = geometry.fromSlotIndex(slot.layer, slot.slotIndex)
        if col and row and flat.Magnitude <= State.Opt.PlaceReach then
            table.insert(cells, { layer = slot.layer, col = col, row = row })
            table.insert(picked, slot)
        else
            rejected[slot.layer .. ":" .. slot.slotIndex] = true
        end
    end
    return picked
end

---@return number  blocks still carried
function xDTaraZ.Farm.PlaceBatch(slots)
    local pending, left, known = #slots, xDTaraZ.Game.Carried(), false
    local token = {}
    State.PlaceToken = token
    for _, slot in ipairs(slots) do
        task.spawn(function()
            local ok, carryState = xDTaraZ:Invoke(GameLib.Place, slot.layer, slot.slotIndex, slot.generation)
            if ok == true then
                State.Placed += 1
                State.LastSlot = slot.position
            end
            if State.PlaceToken ~= token then return end
            local count = xDTaraZ.Game.ReadCarry(carryState)
            if count then left, known = math.min(left, count), true end
            pending -= 1
        end)
    end

    local deadline = osClock() + Config.PlaceTimeout
    while pending > 0 and osClock() < deadline do task.wait() end
    State.PlaceToken = nil
    State.Carry = known and left or nil
    return xDTaraZ.Game.Carried()
end

---@return boolean, string?  placed at least one block (or nothing left to place), else why not
function xDTaraZ.Farm.Deliver()
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return false, "Character not ready" end
    local perPlace = 1 + xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPlace)
    local before, why = State.Placed, "Pyramid refused blocks"

    for _ = 1, Config.PlaceRetries do
        local carried = xDTaraZ.Game.Carried()
        if carried <= 0 or not (State.Alive and State.Opt.AutoFarm) then return true end
        local first = xDTaraZ.Farm.FirstSlot(hrp.Position)
        if not first then
            why = "No free slot on the pyramid"
            break
        end

        State.Status = ("Placing on layer %d"):format(first.layer)
        local stand = first.position + vector3New(0, Config.HoverHeight, 0)
        xDTaraZ.Move.To(stand)
        local arrived = osClock()

        local reach = math.ceil(State.Opt.PlaceReach / GameLib.Pyramid.BlockSize)
        local slots = xDTaraZ.Farm.Slots(stand, math.ceil(carried / perPlace), reach)
        local remaining = Config.SettleDelay - (osClock() - arrived)
        if remaining > 0 then task.wait(remaining) end
        if #slots == 0 then
            why = "No free slot on the pyramid"
            break
        end
        if xDTaraZ.Farm.PlaceBatch(slots) <= 0 then break end
    end

    if State.Placed == before then return false, why end
    xDTaraZ.Farm.Progress()
    return true
end

---@return string?  why the farm should stop, nil while no stop target is reached
function xDTaraZ.Farm.TargetReached()
    local opt = State.Opt
    if opt.StopCoins > 0 and xDTaraZ.Game.Coins() >= opt.StopCoins then
        return "reached " .. xDTaraZ.Format(opt.StopCoins) .. " coins"
    end
    local done = tonumber(xDTaraZ.Game.Attr("Pyramids")) or 0
    if opt.StopPyramids > 0 and done >= opt.StopPyramids then return ("reached %d pyramids"):format(done) end
    return nil
end

---@return boolean  did work this tick
function xDTaraZ.Farm.Step()
    local target = xDTaraZ.Farm.TargetReached()
    if target then
        xDTaraZ.Scheduler.Finish({ "AutoFarm" }, "Auto Farm", target)
        return false
    end
    if osClock() < State.FarmWait then return false end
    if not GameLib.Runtime.getCurrentLayer(Workspace) then
        xDTaraZ.Farm.Progress()
        State.Waiting = "Waiting for the next pyramid"
        xDTaraZ.Farm.Park()
        return false
    end

    State.Waiting, State.Parked = nil, false
    if not State.FarmOrigin then
        local _, _, hrp = xDTaraZ:Character()
        State.FarmOrigin = hrp and hrp.CFrame
    end
    local holding, why = xDTaraZ.Farm.Gather()
    if not holding then return xDTaraZ.Farm.Hold(why) end
    if not (State.Alive and State.Opt.AutoFarm) then return false end

    local placed, reason = xDTaraZ.Farm.Deliver()
    if not placed then return xDTaraZ.Farm.Hold(reason) end
    table.insert(State.CycleLog, osClock())
    return true
end

function xDTaraZ.Farm.Stop()
    local origin = State.FarmOrigin
    State.FarmOrigin, State.Waiting, State.Parked, State.FarmWait = nil, nil, false, 0
    xDTaraZ.Farm.Progress()
    if not (origin and State.Opt.ReturnOnStop) then return end
    local _, _, hrp = xDTaraZ:Character()
    if hrp then hrp.CFrame = origin end
end

xDTaraZ.Train = {}

function xDTaraZ.Train.HasAccess(folder)
    local access = GameLib.Gym.Access[folder]
    if not access then return false end
    local owned = GameLib.GymAccess.purchasedFromAttribute(xDTaraZ.Game.Attr(GameLib.Gym.GymUnlocksAttribute), folder)
        or GameLib.GymAccess.ownsGamePass(LocalPlayer, access.ProductKey)
    local done = tonumber(xDTaraZ.Game.Attr("Pyramids")) or 0
    return GameLib.GymAccess.hasAccess(access, done, owned)
end

---@param stations table  GymConfig station list
---@return string?        gym folder with the highest multiplier you can use
function xDTaraZ.Train.Best(stations, key)
    local best, bestMult
    for _, station in ipairs(stations) do
        if xDTaraZ.Train.HasAccess(station.GymFolder) and (not bestMult or station[key] > bestMult) then
            best, bestMult = station.GymFolder, station[key]
        end
    end
    return best, bestMult
end

---@param chosen string  dropdown value, "Best Unlocked" or a gym folder
---@return string?       the chosen gym when you can use it, else the best one you can
function xDTaraZ.Train.Pick(stations, key, chosen)
    for _, station in ipairs(stations) do
        if station.GymFolder == chosen and xDTaraZ.Train.HasAccess(station.GymFolder) then
            return station.GymFolder, station[key]
        end
    end
    return xDTaraZ.Train.Best(stations, key)
end

---@param value number  current Strength value
---@return number       value that reaches the next Strength level
function xDTaraZ.Train.NextLevelValue(value)
    local progression = GameLib.Progression
    local base = progression.levelForValue(value)
    local low, high = value, math.max(value * 2, value + Config.LevelProbe)
    while high - low > 1 do
        local mid = math.floor((low + high) / 2)
        if progression.levelForValue(mid) > base then high = mid else low = mid end
    end
    return high
end

---@return number?  Strength per second gained on the bench so far, nil until it has run long enough
function xDTaraZ.Train.MeasuredRate(value, now)
    if not xDTaraZ.Game.Benching() then
        State.BenchRef = nil
        return State.BenchRate
    end
    local ref = State.BenchRef
    if not ref then
        State.BenchRef = { at = now, value = value }
        return State.BenchRate
    end
    if now - ref.at >= Config.RateSample and value > ref.value then
        State.BenchRate = (value - ref.value) / (now - ref.at)
        State.BenchRef = { at = now, value = value }
    end
    return State.BenchRate
end

---Coins lost while benching for the next Strength level vs the extra coin per farm cycle it earns inside the payback time.
---@return boolean  the next Strength level pays for itself
function xDTaraZ.Train.Worth()
    local now = osClock()
    local cached = State.SmartCache
    if cached and now - cached.at < Config.SmartRefresh then return cached.worth end

    local worth = false
    local value = tonumber(State.Stats.Strength)
    local coinRate, cycleRate = State.CoinRate or 0, State.CycleRate or 0
    local _, mult = xDTaraZ.Train.Pick(GameLib.Gym.BenchpressStations, "StrengthMultiplier", State.Opt.BenchStation)
    if GameLib.Progression and value and mult and coinRate > 0 and cycleRate > 0 then
        local rate = xDTaraZ.Train.MeasuredRate(value, now) or Config.BenchBase * mult
        local seconds = (xDTaraZ.Train.NextLevelValue(value) - value) / rate
        local cost = seconds * coinRate
        local gain = cycleRate * State.Opt.SmartMinutes * 60
        worth = gain > cost
    end
    State.SmartCache = { at = now, worth = worth }
    return worth
end

function xDTaraZ.Train.Strength()
    local folder, mult = xDTaraZ.Train.Pick(GameLib.Gym.BenchpressStations, "StrengthMultiplier", State.Opt.BenchStation)
    if not folder then return false end
    State.Status = ("Bench press x%d"):format(mult)
    local current = xDTaraZ.Game.Benching()
    if current == folder then return true end
    if current then xDTaraZ:Invoke(GameLib.StopBench) end

    if osClock() - (State.Last.BenchTry or 0) < Config.BenchRetry then return true end
    State.Last.BenchTry = osClock()

    local seat = xDTaraZ.Move.GymPart(folder, GameLib.Gym.BenchpressModelName, GameLib.Gym.AlignPartName)
    if not seat then return false end
    if not xDTaraZ.Move.Near(seat.Position, Config.BenchRange) then
        xDTaraZ.Move.To(seat.Position + vector3New(0, Config.StandHeight, 0))
        task.wait(Config.SettleDelay)
    end
    if not State.Alive then return false end
    local ok = xDTaraZ:Invoke(GameLib.StartBench, folder)
    if ok == true then return true end
    State.Status = "Bench refused, retrying"
    return false
end

function xDTaraZ.Train.Speed()
    local folder, mult = xDTaraZ.Train.Pick(GameLib.Gym.TreadmillStations, "SpeedMultiplier", State.Opt.TreadmillStation)
    local hitbox = folder and xDTaraZ.Move.GymPart(folder, GameLib.Gym.TreadmillModelName, GameLib.Gym.HitboxName)
    if not hitbox then return false end
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    State.Status = ("Treadmill x%d"):format(mult)
    if not xDTaraZ.Move.Near(hitbox.Position) then xDTaraZ.Move.To(hitbox.Position) end
    return true
end

function xDTaraZ.Train.CheckTargets()
    local opt = State.Opt
    local str = tonumber(xDTaraZ.Game.Attr("StrengthLevel")) or 0
    local spd = tonumber(xDTaraZ.Game.Attr("SpeedLevel")) or 0
    if opt.AutoStrength and opt.TargetStrength > 0 and str >= opt.TargetStrength then
        xDTaraZ.Scheduler.Finish({ "AutoStrength" }, "Auto Train Strength", ("reached level %d"):format(str))
    end
    if opt.AutoSpeed and opt.TargetSpeed > 0 and spd >= opt.TargetSpeed then
        xDTaraZ.Scheduler.Finish({ "AutoSpeed" }, "Auto Train Speed", ("reached level %d"):format(spd))
    end
end

---@return boolean  benching or in the pool while the farm waits
function xDTaraZ.Train.WhileWaiting()
    if not (State.Opt.AutoFarm and State.Waiting) then return false end
    return xDTaraZ.Train.Pool() or xDTaraZ.Train.Strength()
end

function xDTaraZ.Train.Step()
    local opt = State.Opt
    xDTaraZ.Train.CheckTargets()
    if not (opt.AutoStrength or opt.AutoSpeed) then
        return opt.TrainWhileWaiting and xDTaraZ.Train.WhileWaiting()
    end
    if opt.Priority == "Balanced" and opt.AutoStrength and not opt.AutoSpeed then return xDTaraZ.Train.Strength() end
    if opt.AutoStrength and opt.AutoSpeed then
        local str = tonumber(xDTaraZ.Game.Attr("StrengthLevel")) or 0
        local spd = tonumber(xDTaraZ.Game.Attr("SpeedLevel")) or 0
        if spd < str then return xDTaraZ.Train.Speed() end
        return xDTaraZ.Train.Strength()
    end
    if opt.AutoStrength then return xDTaraZ.Train.Strength() end
    if opt.AutoSpeed then return xDTaraZ.Train.Speed() end
    return false
end

function xDTaraZ.Train.Leave()
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
end

function xDTaraZ.Train.Pool()
    if not xDTaraZ.Game.Completed() then return false end
    local spot = xDTaraZ.Move.PoolSpot()
    if not spot then return false end
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    State.Status = "Training in the pool"
    if not xDTaraZ.Move.Near(spot) then xDTaraZ.Move.To(spot) end
    return true
end

xDTaraZ.Tasks = {}

function xDTaraZ.Tasks.Order()
    local opt = State.Opt
    local order = {}
    if opt.AutoPool then table.insert(order, "Pool") end
    local trainFirst = opt.Priority == "Train"
    if opt.Priority == "Balanced" then trainFirst = opt.AutoStrength and xDTaraZ.Train.Worth() end
    if opt.Priority == "Alternate" then
        local slice = math.floor(osClock() / (opt.AlternateMinutes * 60))
        trainFirst = slice % 2 == 1
    end
    if not (opt.AutoStrength or opt.AutoSpeed) then trainFirst = false end
    if trainFirst then
        order[#order + 1] = "Train"
        order[#order + 1] = "Farm"
    else
        order[#order + 1] = "Farm"
        order[#order + 1] = "Train"
    end
    return order
end

xDTaraZ.Tasks.Jobs = {
    Pool = { On = function() return State.Opt.AutoPool end, Step = xDTaraZ.Train.Pool },
    Farm = { On = function() return State.Opt.AutoFarm end, Step = xDTaraZ.Farm.Step },
    Train = {
        On = function()
            local opt = State.Opt
            return opt.AutoStrength or opt.AutoSpeed or (opt.TrainWhileWaiting and opt.AutoFarm)
        end,
        Step = xDTaraZ.Train.Step,
    },
}

function xDTaraZ.Tasks.Step()
    for _, name in ipairs(xDTaraZ.Tasks.Order()) do
        if not State.Alive then return end
        local job = xDTaraZ.Tasks.Jobs[name]
        if not job.On() or State.Halted[name] then continue end
        local ok, worked = pcall(job.Step)
        if not ok then
            xDTaraZ.Scheduler.Fail(name, worked)
            return
        end
        State.Fails[name], State.FailSince[name] = nil, nil
        if worked then
            State.Task = name
            return
        end
    end
    State.Task = "None"
    State.Status = State.Opt.AutoFarm and State.Waiting or "Idle"
end

xDTaraZ.Upgrade = {}

---@return number?  cost of the next level, nil when it is not selected, maxed or capped by its Max Level
function xDTaraZ.Upgrade.NextCost(upgrade)
    if not State.Opt.Upgrades[upgrade.DisplayName] then return nil end
    local level = xDTaraZ.Game.UpgradeLevel(upgrade)
    local cap = State.Opt.UpgradeMax[upgrade.DisplayName] or 0
    if cap > 0 and level >= cap then return nil end
    return upgrade.Costs[level + 1]
end

---@return number  measured coins/s gained per coin spent; untried upgrades rank first, cheapest first
function xDTaraZ.Upgrade.Score(upgrade, cost)
    local gain = State.UpgradeGain[upgrade.Id]
    if not gain then return Config.UnmeasuredGain / cost end
    return math.max(gain, 0) / cost
end

function xDTaraZ.Upgrade.Probe(upgrade)
    local rate = State.CoinRate or 0
    State.UpgradeProbe = rate > 0 and State.Opt.AutoFarm and { id = upgrade.Id, rate = rate, at = osClock() } or nil
end

function xDTaraZ.Upgrade.Measure()
    local probe = State.UpgradeProbe
    if not probe or osClock() - probe.at < Config.RateWindow then return end
    State.UpgradeProbe = nil
    if not State.Opt.AutoFarm then return end
    local gain = (State.CoinRate or 0) - probe.rate
    local old = State.UpgradeGain[probe.id]
    State.UpgradeGain[probe.id] = old and (old + gain) / 2 or gain
end

---@param budget number  coins free to spend
---@return table?, number?  best scored upgrade you can afford, nil while saving up for a better one
function xDTaraZ.Upgrade.PickByValue(budget)
    local best, bestCost, bestScore
    local afford, affordCost, affordScore
    for _, name in ipairs(xDTaraZ.UpgradeNames) do
        local upgrade = xDTaraZ.UpgradeByName[name]
        local cost = xDTaraZ.Upgrade.NextCost(upgrade)
        if not cost then continue end
        local score = xDTaraZ.Upgrade.Score(upgrade, cost)
        if not bestScore or score > bestScore then best, bestCost, bestScore = upgrade, cost, score end
        if cost <= budget and (not affordScore or score > affordScore) then
            afford, affordCost, affordScore = upgrade, cost, score
        end
    end

    if not best then return nil end
    if bestCost <= budget then return best, bestCost end
    local income = State.CoinRate or 0
    if income > 0 and (bestCost - budget) / income <= Config.SaveSeconds then return nil end
    return afford, affordCost
end

---@return table?, number?  wanted upgrade to buy next by the chosen order, and its cost
function xDTaraZ.Upgrade.Pick()
    local budget = xDTaraZ.Game.Coins() - State.Opt.KeepCoins
    if State.Opt.UpgradeOrder == "Best Value" then return xDTaraZ.Upgrade.PickByValue(budget) end

    local pick, pickCost
    for _, name in ipairs(xDTaraZ.UpgradeNames) do
        local upgrade = xDTaraZ.UpgradeByName[name]
        local cost = xDTaraZ.Upgrade.NextCost(upgrade)
        if not cost or cost > budget then continue end
        if State.Opt.UpgradeOrder == "In Order" then return upgrade, cost end
        if not pickCost or cost < pickCost then pick, pickCost = upgrade, cost end
    end
    return pick, pickCost
end

---@param loud boolean?  tell the player why the server refused
---@return boolean       the level went up or coins were taken
function xDTaraZ.Upgrade.Buy(upgrade, loud)
    local level, coins = xDTaraZ.Game.UpgradeLevel(upgrade), xDTaraZ.Game.Coins()
    local reply = xDTaraZ:Invoke(GameLib.Purchase, upgrade.Id)
    if not (type(reply) == "table" and reply.ok == true) then
        if loud then
            xDTaraZ:Notify(("%s: %s"):format(upgrade.DisplayName, type(reply) == "table" and tostring(reply.reason) or "no reply"))
        end
        return false
    end

    local function Confirmed()
        return xDTaraZ.Game.UpgradeLevel(upgrade) > level or xDTaraZ.Game.Coins() < coins
    end
    local deadline = osClock() + Config.ConfirmTimeout
    repeat task.wait() until Confirmed() or osClock() > deadline
    if not Confirmed() then
        xDTaraZ:Notify(("%s %d was not confirmed"):format(upgrade.DisplayName, level + 1))
        return false
    end

    xDTaraZ:Notify(("Bought %s %d"):format(upgrade.DisplayName, level + 1))
    xDTaraZ.Upgrade.Probe(upgrade)
    return true
end

---@param buy function  runs alone; a second caller returns at once
function xDTaraZ.Upgrade.Exclusive(buy)
    if State.Buying then return end
    State.Buying = true
    local ok, err = pcall(buy)
    State.Buying = false
    if not ok then error(err, 0) end
end

function xDTaraZ.Upgrade.Step()
    xDTaraZ.Upgrade.Exclusive(function()
        local upgrade = xDTaraZ.Upgrade.Pick()
        if upgrade then xDTaraZ.Upgrade.Buy(upgrade) end
    end)
end

function xDTaraZ.Upgrade.Now()
    xDTaraZ.Upgrade.Exclusive(function()
        local bought = 0
        repeat
            local upgrade = xDTaraZ.Upgrade.Pick()
            if not (upgrade and State.Alive and xDTaraZ.Upgrade.Buy(upgrade, true)) then break end
            bought += 1
            task.wait(Config.UpgradeGap)
        until bought >= Config.UpgradeBurst
        if bought == 0 then xDTaraZ:Notify("Nothing to buy") end
    end)
end

xDTaraZ.Codes = {}

function xDTaraZ.Codes.RedeemAll()
    local tally, order = {}, {}
    for _, code in ipairs(xDTaraZ.CodeList) do
        if not State.Alive then break end
        if State.CodeDone[code] then continue end

        local reply = xDTaraZ:Invoke(GameLib.Redeem, code)
        local reason = "NoReply"
        if type(reply) == "table" then reason = reply.ok and "Redeemed" or tostring(reply.reason) end
        if Config.CodeFinal[reason] then State.CodeDone[code] = reason end
        if reason == "Redeemed" then xDTaraZ:Notify(code .. ": redeemed") end

        if not tally[reason] then
            tally[reason] = 0
            order[#order + 1] = reason
        end
        tally[reason] += 1
        task.wait(Config.CodeGap)
    end

    if #order == 0 then
        xDTaraZ:Notify("Every code was already checked this session")
        return
    end
    local parts = {}
    for _, reason in ipairs(order) do
        table.insert(parts, ("%d %s"):format(tally[reason], Config.CodeLabels[reason] or reason))
    end
    xDTaraZ:Notify("Codes: " .. table.concat(parts, ", "))
end

xDTaraZ.Bank = {}

---@param attr string  player attribute holding what was bought with Robux
---@return boolean     the server took it
function xDTaraZ.Bank.Spend(remote, attr, label)
    local before = tonumber(xDTaraZ.Game.Attr(attr)) or 0
    if before <= 0 or State.BankRefused[attr] == before then return false end

    local ok, reason = xDTaraZ:Invoke(remote)
    if ok ~= true then
        State.BankRefused[attr] = before
        xDTaraZ:Notify(("Could not spend %s: %s"):format(label, tostring(reason or "no reply")))
        return false
    end

    State.BankRefused[attr] = nil
    task.wait(Config.BankSettle)
    local left = tonumber(xDTaraZ.Game.Attr(attr)) or 0
    xDTaraZ:Notify(("Spent %s %s"):format(xDTaraZ.Format(before - left), label))
    return true
end

function xDTaraZ.Bank.Auto()
    if GameLib.Runtime.getCurrentLayer(Workspace) then
        xDTaraZ.Bank.Spend(GameLib.SpendBlocks, "BankedBlocks", "banked blocks")
    end
    if xDTaraZ.Game.Completed() then
        xDTaraZ.Bank.Spend(GameLib.SpendSeconds, "BankedSeconds", "banked pool seconds")
    end
end

xDTaraZ.Gift = {}

---@param manual boolean?  pressed by the player; reports every outcome
function xDTaraZ.Gift.Claim(manual)
    local state = xDTaraZ:Invoke(GameLib.GiftState)
    if type(state) ~= "table" then
        if manual then xDTaraZ:Notify("Free gift is not available right now") end
        return
    end
    if state.claimed then
        State.GiftDone = true
        if manual then xDTaraZ:Notify("Free gift already claimed") end
        return
    end
    if not state.inGroup then
        if manual or not State.GiftNagged then xDTaraZ:Notify("Join the game group to claim the free gift") end
        State.GiftNagged = true
        return
    end

    for _, step in ipairs({ "liked", "favorited" }) do
        if not state[step] then xDTaraZ:Invoke(GameLib.GiftStep, step) end
    end
    local reply, reason = xDTaraZ:Invoke(GameLib.GiftClaim)
    if reply == true or (type(reply) == "table" and reply.ok) then
        State.GiftDone = true
        xDTaraZ:Notify(("Free gift claimed: +%s Speed, +%s Strength"):format(
            xDTaraZ.Format(state.speedReward), xDTaraZ.Format(state.strengthReward)))
        return
    end
    xDTaraZ:Notify("Free gift: " .. (type(reply) == "table" and tostring(reply.reason) or tostring(reason)))
end

function xDTaraZ.Gift.Now()
    xDTaraZ.Gift.Claim(true)
end

xDTaraZ.Boost = {}

function xDTaraZ.Boost.Read()
    local state = xDTaraZ:Invoke(GameLib.BoostState)
    if type(state) ~= "table" then return end
    State.Boost = { tier = tonumber(state.tier) or 0, expiresAt = tonumber(state.expiresAt) or 0 }
end

---@return string  "Server Boost T2 · 14m 05s left", or none when no boost runs
function xDTaraZ.Boost.Text()
    local boost = State.Boost
    if not boost then return "Server Boost -" end
    local left = math.floor(boost.expiresAt - Workspace:GetServerTimeNow())
    if boost.tier <= 0 or left <= 0 then return "Server Boost none" end
    return ("Server Boost T%d · %dm %02ds left"):format(boost.tier, math.floor(left / 60), left % 60)
end

xDTaraZ.Teleport = {}

function xDTaraZ.Teleport.Quarry()
    xDTaraZ.Move.To(xDTaraZ.Move.QuarrySpot())
end

function xDTaraZ.Teleport.Pyramid()
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return end
    local slot = xDTaraZ.Farm.FirstSlot(hrp.Position)
    if slot then
        xDTaraZ.Move.To(slot.position + vector3New(0, Config.HoverHeight, 0))
        return
    end
    local model = xDTaraZ.Game.Model()
    if model then xDTaraZ.Move.To(model:GetPivot().Position + vector3New(0, Config.HoverHeight, 0)) end
end

function xDTaraZ.Teleport.Pool()
    local spot = xDTaraZ.Move.PoolSpot()
    if not spot then
        xDTaraZ:Notify(xDTaraZ.Game.Completed() and "Pool is not loaded yet, try again in a moment" or "Pool opens when a pyramid is completed")
        return
    end
    xDTaraZ.Move.To(spot, true)
end

function xDTaraZ.Teleport.Gym()
    local folder = State.GymTarget
    local seat = folder and xDTaraZ.Move.GymPart(folder, GameLib.Gym.BenchpressModelName, GameLib.Gym.AlignPartName)
    local belt = folder and xDTaraZ.Move.GymPart(folder, GameLib.Gym.TreadmillModelName, GameLib.Gym.HitboxName)
    local target = seat or belt
    if target then xDTaraZ.Move.To(target.Position + vector3New(0, Config.StandHeight, 0)) end
end

function xDTaraZ.Teleport.Player()
    local target = State.PlayerTarget and Players:FindFirstChild(State.PlayerTarget)
    local root = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not root then
        xDTaraZ:Notify("Player not found")
        return
    end
    xDTaraZ.Move.To(root.Position + vector3New(0, Config.StandHeight, 0), true)
end

xDTaraZ.Server = {}

function xDTaraZ.Server.Rejoin()
    if #Players:GetPlayers() > 1 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    else
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
end

function xDTaraZ.Server.Hop()
    local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100"):format(game.PlaceId)
    local body = xDTaraZ.Util.HttpGet(url)
    local ok, page = pcall(HttpService.JSONDecode, HttpService, body or "")
    if not (ok and type(page) == "table" and page.data) then
        xDTaraZ:Notify("Server list unavailable")
        return
    end
    local options = {}
    for _, server in ipairs(page.data) do
        if server.id ~= game.JobId and (server.playing or 0) < (server.maxPlayers or 0) then
            table.insert(options, server.id)
        end
    end
    if #options == 0 then
        xDTaraZ:Notify("No other server found")
        return
    end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, options[math.random(#options)], LocalPlayer)
end

function xDTaraZ.Server.Boost()
    local saved = State.Boosted
    if not saved then
        saved = { Shadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd, Effects = {}, Materials = {} }
        State.Boosted = saved
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e6

    local plastic, smooth = Enum.Material.Plastic, Enum.Material.SmoothPlastic
    for _, inst in ipairs(Workspace:GetDescendants()) do
        if inst:IsA("ParticleEmitter") or inst:IsA("Trail") or inst:IsA("Smoke") or inst:IsA("Fire") then
            if not inst.Enabled then continue end
            saved.Effects[inst] = true
            inst.Enabled = false
        elseif inst:IsA("BasePart") and inst.Material ~= plastic and inst.Material ~= smooth then
            saved.Materials[inst] = inst.Material
            inst.Material = smooth
        end
    end
    xDTaraZ:Notify("FPS boost applied")
end

function xDTaraZ.Server.Unboost()
    local saved = State.Boosted
    if not saved then return end
    State.Boosted = nil
    Lighting.GlobalShadows, Lighting.FogEnd = saved.Shadows, saved.FogEnd
    for inst in pairs(saved.Effects) do
        if inst.Parent then inst.Enabled = true end
    end
    for part, material in pairs(saved.Materials) do
        if part.Parent then part.Material = material end
    end
end

xDTaraZ.Client = {}

function xDTaraZ.Client.Bind()
    table.insert(State.Connections, LocalPlayer.Idled:Connect(function()
        if not State.Opt.AntiAfk then return end
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.zero)
    end))

    table.insert(State.Connections, UserInputService.JumpRequest:Connect(function()
        if not State.Opt.InfJump then return end
        local _, hum = xDTaraZ:Character()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end))

    table.insert(State.Connections, LocalPlayer.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid", Config.LoadTimeout)
        if State.Collided then table.clear(State.Collided) end
    end))

    table.insert(State.Connections, GuiService.ErrorMessageChanged:Connect(function()
        if not State.Opt.AutoRejoin or State.Rejoining or GuiService:GetErrorMessage() == "" then return end
        State.Rejoining = true
        if not xDTaraZ.Util.QueueReload() then warn("[BuildThePyramid] auto rejoin: this executor cannot reload the hub after teleport") end
        task.wait(Config.RejoinDelay)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end))
end

xDTaraZ.Scheduler = {}

xDTaraZ.Scheduler.RequestHandlers = {
    Movement = xDTaraZ.Move.Refresh,
    FarmStop = xDTaraZ.Farm.Stop,
    TrainStop = xDTaraZ.Train.Leave,
    UpgradeNow = xDTaraZ.Upgrade.Now,
    CodesNow = xDTaraZ.Codes.RedeemAll,
    GiftNow = xDTaraZ.Gift.Now,
    TpQuarry = xDTaraZ.Teleport.Quarry,
    TpPyramid = xDTaraZ.Teleport.Pyramid,
    TpPool = xDTaraZ.Teleport.Pool,
    TpGym = xDTaraZ.Teleport.Gym,
    TpPlayer = xDTaraZ.Teleport.Player,
    Rejoin = xDTaraZ.Server.Rejoin,
    Hop = xDTaraZ.Server.Hop,
    Boost = xDTaraZ.Server.Boost,
}

xDTaraZ.Scheduler.Toggles = {
    Farm = { "AutoFarm" },
    Train = { "AutoStrength", "AutoSpeed", "TrainWhileWaiting" },
    Pool = { "AutoPool" },
    Upgrade = { "AutoUpgrade" },
    Gift = { "AutoGift" },
    Activity = { "AntiAfk" },
    Summary = {},
}

---@param key string?  job name; repeated failures stop it and switch its toggles off
function xDTaraZ.Scheduler.Run(fn, key)
    if key and State.Halted[key] then return end
    local ok, err = pcall(fn)
    if ok then
        if key then State.Fails[key], State.FailSince[key] = nil, nil end
        return
    end
    if key then
        xDTaraZ.Scheduler.Fail(key, err)
    else
        warn("[BuildThePyramid]", err)
    end
end

---@return boolean  one of the job's toggles is on; core jobs have none
function xDTaraZ.Scheduler.Wanted(key)
    for _, idx in ipairs(xDTaraZ.Scheduler.Toggles[key] or {}) do
        if State.Opt[idx] == true then return true end
    end
    return false
end

---@param toggles string[]  options to switch off; the UI pump flips the matching toggles and tells the player
function xDTaraZ.Scheduler.Finish(toggles, label, reason)
    for _, idx in ipairs(toggles) do State.Opt[idx] = false end
    table.insert(State.HaltQueue, { toggles, label, reason })
end

function xDTaraZ.Scheduler.Fail(key, err)
    local fails = (State.Fails[key] or 0) + 1
    State.Fails[key] = fails
    State.FailSince[key] = State.FailSince[key] or osClock()
    if fails == 1 then warn("[BuildThePyramid] " .. key .. " failing:", err) end

    if fails < Config.FailLimit or osClock() - State.FailSince[key] < Config.FailWindow then return end
    if not xDTaraZ.Scheduler.Wanted(key) then return end
    State.Halted[key] = true
    xDTaraZ.Scheduler.Finish(xDTaraZ.Scheduler.Toggles[key] or {}, key, tostring(err):match("^[^\n]*"))
end

function xDTaraZ.Scheduler.Resume(idx)
    for key, toggles in pairs(xDTaraZ.Scheduler.Toggles) do
        if table.find(toggles, idx) then
            State.Halted[key], State.Fails[key], State.FailSince[key] = nil, nil, nil
        end
    end
end

function xDTaraZ.Scheduler.RunOnce(name, fn, key)
    if State.Running[name] then return end
    State.Running[name] = true
    task.spawn(function()
        xDTaraZ.Scheduler.Run(fn, key)
        State.Running[name] = nil
    end)
end

---@param async boolean?  run off the light loop so a slow remote does not hold the other jobs
function xDTaraZ.Scheduler.Every(key, interval, fn, async)
    if osClock() - (State.Last[key] or 0) < interval then return end
    State.Last[key] = osClock()
    if async then
        xDTaraZ.Scheduler.RunOnce(key, fn, key)
    else
        xDTaraZ.Scheduler.Run(fn, key)
    end
end

function xDTaraZ.Scheduler.Summarize()
    local now = osClock()
    local cutoff = now - Config.RateWindow
    local recent = 0
    for i = #State.CoinLog, 1, -1 do
        local entry = State.CoinLog[i]
        if entry[1] < cutoff then table.remove(State.CoinLog, i) else recent += entry[2] end
    end
    while State.CycleLog[1] and State.CycleLog[1] < cutoff do table.remove(State.CycleLog, 1) end

    State.CoinRate = recent / Config.RateWindow
    State.CycleRate = #State.CycleLog / Config.RateWindow
    xDTaraZ.Upgrade.Measure()

    local carried, cap = xDTaraZ.Game.Carried(), xDTaraZ.Game.Capacity()
    State.Summary = ("Coins %s · %s/min\nStrength Lv %s · Speed Lv %s · Carry %d/%d\nPyramids %s · Placed %d\n%s"):format(
        xDTaraZ.Format(State.Stats.Coins), xDTaraZ.Format(recent * 60 / Config.RateWindow),
        tostring(xDTaraZ.Game.Attr("StrengthLevel") or 0), tostring(xDTaraZ.Game.Attr("SpeedLevel") or 0),
        carried, cap, tostring(xDTaraZ.Game.Attr("Pyramids") or 0), State.Placed, xDTaraZ.Boost.Text())
end

function xDTaraZ.Scheduler.Light()
    local opt = State.Opt
    xDTaraZ.Scheduler.Run(xDTaraZ.Scheduler.Summarize, "Summary")

    for name, handler in pairs(xDTaraZ.Scheduler.RequestHandlers) do
        if not State.Requests[name] then continue end
        State.Requests[name] = nil
        if Config.SlowRequests[name] then
            xDTaraZ.Scheduler.RunOnce(name, handler)
        else
            xDTaraZ.Scheduler.Run(handler)
        end
    end

    if opt.AntiAfk and GameLib.Activity then
        xDTaraZ.Scheduler.Every("Activity", Config.ActivityInterval, function() GameLib.Activity:FireServer() end)
    end
    if GameLib.BoostState then xDTaraZ.Scheduler.Every("Boost", Config.BoostInterval, xDTaraZ.Boost.Read, true) end
    if opt.AutoUpgrade then xDTaraZ.Scheduler.Every("Upgrade", Config.UpgradeInterval, xDTaraZ.Upgrade.Step, true) end
    if opt.AutoFarm then xDTaraZ.Scheduler.Every("Bank", Config.BankInterval, xDTaraZ.Bank.Auto, true) end

    if opt.AutoGift and not State.GiftDone then
        if State.GiftDirty then
            State.GiftDirty = false
            State.Last.Gift = nil
        end
        xDTaraZ.Scheduler.Every("Gift", Config.GiftInterval, xDTaraZ.Gift.Claim, true)
    end
end

function xDTaraZ.Scheduler.Work()
    local _, hum = xDTaraZ:Character()
    if not hum then return end
    xDTaraZ.Scheduler.Run(xDTaraZ.Tasks.Step)
end

---@param step function  one pass of a loop that ends with the hub
function xDTaraZ.Scheduler.Loop(step)
    task.defer(function()
        while State.Alive do
            step()
            task.wait(Config.TickDelay)
        end
    end)
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Client.Bind()
    if GameLib.GiftChanged then
        table.insert(State.Connections, GameLib.GiftChanged.OnClientEvent:Connect(function()
            State.GiftDirty = true
            State.GiftDone = false
        end))
    end
    task.spawn(xDTaraZ.Game.WatchStats)
    xDTaraZ.Scheduler.Loop(xDTaraZ.Scheduler.Light)
    xDTaraZ.Scheduler.Loop(xDTaraZ.Scheduler.Work)
end

function xDTaraZ.Scheduler.Stop()
    local opt = State.Opt
    for _, idx in ipairs(Config.AutoOptions) do opt[idx] = false end
    xDTaraZ.Util.Try("leave gym", xDTaraZ.Train.Leave)
    xDTaraZ.Util.Try("farm stop", xDTaraZ.Farm.Stop)
    State.Alive = false

    for _, conn in ipairs(State.Connections) do conn:Disconnect() end
    table.clear(State.Connections)
    opt.SpeedOn, opt.Fly, opt.Noclip, opt.NoRender = false, false, false, false
    xDTaraZ.Move.Refresh()
    RunService:Set3dRenderingEnabled(true)
    xDTaraZ.Util.Try("fps boost restore", xDTaraZ.Server.Unboost)
end

local function BuildInterface()
    local Library, problem = xDTaraZ.Util.LoadLibrary(Config.UiSource)
    if not Library then
        xDTaraZ.Util.Alert(problem)
        return
    end
    pcall(MarioBanner.Step, "UI library")
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt
    local statusLabel, runLabel

    local function Notify(text, kind)
        Library:Notify("Build the Pyramid", text, 4, kind or "Info")
    end

    local function Request(name)
        return function() State.Requests[name] = true end
    end

    local function Toggle(group, key, text, description, onChange)
        return group:AddToggle(key, {
            Text = text,
            Description = description,
            Default = false,
            Callback = function(value)
                if value == true and not xDTaraZ.Gate.Ready(key) then
                    Notify(T("Needs a script update (game changed)", "ต้องอัปเดตสคริปต์ (เกมเปลี่ยน)"), "Warning")
                    task.defer(function() Library.Toggles[key]:SetValue(false) end)
                    return
                end
                opt[key] = value
                if value == true then xDTaraZ.Scheduler.Resume(key) end
                if onChange then onChange(value) end
            end,
        })
    end

    local function NumberInput(group, idx, text, onValue)
        return group:AddInput(idx, {
            Text = text,
            Default = "0",
            Placeholder = "0",
            Numeric = true,
            Finished = true,
            Callback = function(value) onValue(math.max(math.floor(tonumber(value) or 0), 0)) end,
        })
    end

    local function PlayerNames()
        local names = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then names[#names + 1] = plr.Name end
        end
        table.sort(names)
        return names
    end

    local function GymNames()
        local names = {}
        for _, station in ipairs(GameLib.Gym.BenchpressStations) do
            table.insert(names, ("Gym %s (x%d)"):format(station.GymFolder, station.StrengthMultiplier))
        end
        return names
    end

    ---@return table  list from a game-data source, empty when it errors
    local function Values(source)
        local ok, list = pcall(source)
        return ok and type(list) == "table" and list or {}
    end

    local function Gate()
        local blocked = 0
        for idx in pairs(xDTaraZ.Gate.Needs) do
            local missing = xDTaraZ.Gate.Missing(idx)
            if not Library.Options[idx] or not missing then continue end
            blocked += 1
            warn("[BuildThePyramid] " .. idx .. " blocked, missing " .. missing)
            if Library.Compat then Library.Compat.Block(Library.Options[idx], T("Needs a script update (game changed)", "ต้องอัปเดตสคริปต์ (เกมเปลี่ยน)")) end
        end
        if blocked == 0 then return end
        Library:Notify("Mario Hub", blocked .. " features need a script update (game changed)", 8, "Warning")
    end

    local function DrainHalted()
        while #State.HaltQueue > 0 do
            local toggles, label, reason = table.unpack(table.remove(State.HaltQueue, 1))
            for _, idx in ipairs(toggles) do
                local toggle = Library.Toggles[idx]
                if toggle and toggle.Value == true then toggle:SetValue(false) end
            end
            Notify(label .. " stopped: " .. reason, "Error")
        end
    end

    local function BuildMain(window)
        window:AddTabSection(T("Main", "หลัก"))
        local MainTab = window:AddTab(T("Main", "หลัก"), "house", T("Status and Discord", "สถานะและ Discord"))

        local statusBox = MainTab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
        statusLabel = statusBox:AddLabel(T("Loading...", "กำลังโหลด..."))
        runLabel = statusBox:AddLabel("-")

        local discordBox = MainTab:AddRightGroupbox(T("Discord", "Discord"), "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            Notify(xDTaraZ.Util.Copy(Config.Discord) and "Discord link copied" or Config.Discord)
        end })

        local logBox = MainTab:AddRightGroupbox(T("Update Log", "อัปเดตล่าสุด"), "bell")
        for i = 1, math.min(2, #Config.UpdateLog) do
            local entry = Config.UpdateLog[i]
            logBox:AddParagraph({ Title = entry[1], Content = entry[2] })
        end
    end

    local function BuildFarm(window)
        window:AddTabSection(T("Farming", "ฟาร์ม"))
        local FarmTab = window:AddTab(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "brick", T("Blocks and coins", "บล็อกและเหรียญ"))

        local farmBox = FarmTab:AddLeftGroupbox(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "brick")
        farmBox:AddToggle("AutoFarm", {
            Text = T("Auto Farm", "ฟาร์มอัตโนมัติ"),
            Description = T("Grabs blocks and builds the pyramid for coins", "หยิบบล็อกแล้วสร้างพีระมิดเพื่อเหรียญ"),
            Default = false,
            Callback = function(value)
                opt.AutoFarm = value
                if value then xDTaraZ.Scheduler.Resume("AutoFarm") else State.Requests.FarmStop = true end
            end,
        })
        Toggle(farmBox, "ReturnOnStop", T("Return On Stop", "กลับที่เดิมเมื่อหยุด"), T("Goes back to where you started", "กลับไปจุดที่เริ่มฟาร์ม"))
        farmBox:AddSlider("PlaceReach", {
            Text = T("Place Distance", "ระยะวางบล็อก"),
            Description = T("Lower it if blocks get refused, raise it for fewer repositions", "ลดถ้าวางไม่ติด เพิ่มเพื่อขยับน้อยลง"),
            Min = 16, Max = 36, Default = opt.PlaceReach, Rounding = 0, Suffix = " studs",
            Callback = function(value) opt.PlaceReach = tonumber(value) or opt.PlaceReach end,
        })
        NumberInput(farmBox, "StopCoins", T("Stop At Coins (0 = never)", "หยุดเมื่อเหรียญถึง (0 = ไม่หยุด)"), function(value) opt.StopCoins = value end)
        NumberInput(farmBox, "StopPyramids", T("Stop At Pyramids (0 = never)", "หยุดเมื่อพีระมิดถึง (0 = ไม่หยุด)"), function(value) opt.StopPyramids = value end)

        local orderBox = FarmTab:AddRightGroupbox(T("Farm vs Training", "ฟาร์มกับฝึก"), "sliders-horizontal")
        Toggle(orderBox, "TrainWhileWaiting", T("Train While Waiting", "ฝึกระหว่างรอ"),
            T("Trains Strength or joins the pool while the pyramid resets", "ฝึกพลังหรือลงสระระหว่างรอพีระมิดใหม่"))
        local altSlider, smartSlider
        orderBox:AddDropdown("Priority", {
            Text = T("When Both Are On", "เมื่อเปิดทั้งคู่"),
            Description = T("Balanced trains Strength only while the extra blocks pay it back", "Balanced ฝึกพลังเฉพาะตอนที่คุ้มกับบล็อกที่ได้เพิ่ม"),
            Values = { "Balanced", "Farm", "Train", "Alternate" },
            Default = 1,
            Callback = function(value)
                opt.Priority = value or "Balanced"
                if altSlider then altSlider:SetVisible(opt.Priority == "Alternate") end
                if smartSlider then smartSlider:SetVisible(opt.Priority == "Balanced") end
            end,
        })
        smartSlider = orderBox:AddSlider("SmartMinutes", {
            Text = T("Payback Time (min)", "คืนทุนภายใน (นาที)"),
            Description = T("Train while one more Strength level repays itself within this time", "ฝึกเมื่อเลเวลพลังที่เพิ่มคืนทุนภายในเวลานี้"),
            Min = 5, Max = 240, Default = opt.SmartMinutes, Rounding = 0,
            Callback = function(value) opt.SmartMinutes = tonumber(value) or 30 end,
        })
        altSlider = orderBox:AddSlider("AlternateMinutes", {
            Text = T("Alternate Every (min)", "สลับทุก (นาที)"),
            Min = 1, Max = 30, Default = opt.AlternateMinutes, Rounding = 0,
            Callback = function(value) opt.AlternateMinutes = tonumber(value) or 5 end,
        })
        altSlider:SetVisible(opt.Priority == "Alternate")
    end

    local function BuildTraining(window)
        local GymTab = window:AddTab(T("Training", "ฝึก"), "heart", T("Strength, speed and the pool", "พลัง ความเร็ว และสระ"))

        local gymBox = GymTab:AddLeftGroupbox(T("Gym", "ยิม"), "heart")
        Toggle(gymBox, "AutoStrength", T("Auto Train Strength", "ฝึกพลังอัตโนมัติ"), T("Bench press at your strongest gym", "ยกน้ำหนักที่ยิมแรงสุดที่ใช้ได้"), function(on)
            if not on then State.Requests.TrainStop = true end
        end)
        Toggle(gymBox, "AutoSpeed", T("Auto Train Speed", "ฝึกความเร็วอัตโนมัติ"), T("Runs on your strongest treadmill", "วิ่งบนลู่ที่แรงสุดที่ใช้ได้"))

        local function StationLabels(stations, key)
            local labels = { "Best Unlocked" }
            for _, station in ipairs(stations) do
                table.insert(labels, ("Gym %s (x%d)"):format(station.GymFolder, station[key]))
            end
            return labels
        end
        local function StationPick(optionKey)
            return function(value)
                opt[optionKey] = value and value:match("^Gym (%S+)") or "Best Unlocked"
            end
        end
        gymBox:AddDropdown("BenchStationPick", {
            Text = T("Bench Gym", "ยิมยกน้ำหนัก"),
            Values = StationLabels(GameLib.Gym.BenchpressStations, "StrengthMultiplier"),
            Default = 1,
            Callback = StationPick("BenchStation"),
        })
        gymBox:AddDropdown("TreadmillStationPick", {
            Text = T("Treadmill Gym", "ยิมลู่วิ่ง"),
            Values = StationLabels(GameLib.Gym.TreadmillStations, "SpeedMultiplier"),
            Default = 1,
            Callback = StationPick("TreadmillStation"),
        })
        NumberInput(gymBox, "TargetStrength", T("Target Strength Level (0 = never)", "เลเวลพลังเป้าหมาย (0 = ไม่หยุด)"), function(value) opt.TargetStrength = value end)
        NumberInput(gymBox, "TargetSpeed", T("Target Speed Level (0 = never)", "เลเวลความเร็วเป้าหมาย (0 = ไม่หยุด)"), function(value) opt.TargetSpeed = value end)

        local poolBox = GymTab:AddRightGroupbox(T("Waters of Nu", "สระ Waters of Nu"), "pipe")
        Toggle(poolBox, "AutoPool", T("Auto Join Pool", "ลงสระอัตโนมัติ"), T("Trains in the pool when a pyramid is finished", "ฝึกในสระเมื่อพีระมิดสร้างเสร็จ"))
        poolBox:AddButton({ Text = T("Go To Pool", "ไปสระ"), Func = Request("TpPool") })
    end

    local function BuildShop(window)
        window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local ShopTab = window:AddTab(T("Upgrades & Codes", "อัปเกรดและโค้ด"), "shop", T("Spend coins and redeem codes", "ใช้เหรียญและใส่โค้ด"))

        local upgradeBox = ShopTab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "coin")
        Toggle(upgradeBox, "AutoUpgrade", T("Auto Upgrade", "อัปเกรดอัตโนมัติ"), T("Buys the selected upgrades with coins", "ซื้ออัปเกรดที่เลือกด้วยเหรียญ"))
        opt.Upgrades = {}
        for _, name in ipairs(xDTaraZ.UpgradeNames) do opt.Upgrades[name] = true end
        upgradeBox:AddDropdown("Upgrades", {
            Text = T("Upgrades", "อัปเกรด"),
            Values = xDTaraZ.UpgradeNames,
            Multi = true,
            Default = xDTaraZ.UpgradeNames,
            Callback = function(selected) opt.Upgrades = selected or {} end,
        })
        upgradeBox:AddButton({ Text = T("Buy Now", "ซื้อเดี๋ยวนี้"), Func = Request("UpgradeNow") })

        local rulesBox = ShopTab:AddRightGroupbox(T("Spending", "การใช้เหรียญ"), "coin")
        rulesBox:AddDropdown("UpgradeOrder", {
            Text = T("Order", "ลำดับ"),
            Description = T("Best Value buys what speeds up farming most and saves up when it is close", "Best Value ซื้อตัวที่ช่วยฟาร์มเร็วสุด และเก็บเงินรอถ้าใกล้พอซื้อ"),
            Values = { "Best Value", "Cheapest First", "In Order" },
            Default = 1,
            Callback = function(value) opt.UpgradeOrder = value or "Best Value" end,
        })
        NumberInput(rulesBox, "KeepCoins", T("Keep Coins", "กันเหรียญไว้"), function(value) opt.KeepCoins = value end)
        for _, name in ipairs(xDTaraZ.UpgradeNames) do
            NumberInput(upgradeBox, "UpgradeMax_" .. name, T("Max " .. name .. " Level (0 = max)", "เลเวลสูงสุด " .. name .. " (0 = สุด)"), function(value)
                opt.UpgradeMax[name] = value
            end)
        end

        local codeBox = ShopTab:AddRightGroupbox(T("Codes & Gifts", "โค้ดและของขวัญ"), "code")
        codeBox:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Style = "Primary", Func = Request("CodesNow") })
        Toggle(codeBox, "AutoGift", T("Auto Free Gift", "รับของขวัญฟรีอัตโนมัติ"), T("Claims the free gift once you join the game group", "รับของขวัญฟรีเมื่อเข้ากลุ่มเกมแล้ว"))
        codeBox:AddButton({ Text = T("Claim Now", "รับเดี๋ยวนี้"), Func = Request("GiftNow") })
    end

    local function BuildPlayer(window)
        window:AddTabSection(T("Misc", "อื่นๆ"))
        local PlayerTab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and teleports", "การเคลื่อนที่และวาร์ป"))

        local moveBox = PlayerTab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "star")
        Toggle(moveBox, "SpeedOn", T("Speed", "ความเร็ว"), nil, Request("Movement"))
            :AddKeyPicker("SpeedOnKey", { Default = "None", Mode = "Toggle" })
        moveBox:AddSlider("WalkSpeed", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Min = 16, Max = 200, Default = opt.WalkSpeed, Rounding = 0,
            Callback = function(value) opt.WalkSpeed = tonumber(value) or opt.WalkSpeed end,
        })
        Toggle(moveBox, "Fly", T("Fly", "บิน"), nil, Request("Movement"))
            :AddKeyPicker("FlyKey", { Default = "None", Mode = "Toggle" })
        moveBox:AddSlider("FlySpeed", {
            Text = T("Fly Speed", "ความเร็วบิน"),
            Min = 10, Max = 200, Default = opt.FlySpeed, Rounding = 0,
            Callback = function(value) opt.FlySpeed = tonumber(value) or opt.FlySpeed end,
        })
        Toggle(moveBox, "Noclip", T("Noclip", "ทะลุกำแพง"), nil, Request("Movement"))
            :AddKeyPicker("NoclipKey", { Default = "None", Mode = "Toggle" })
        Toggle(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))

        local tpBox = PlayerTab:AddRightGroupbox(T("Teleport", "วาร์ป"), "teleport")
        tpBox:AddButton({ Text = T("Quarry", "เหมืองหิน"), Func = Request("TpQuarry") })
        tpBox:AddButton({ Text = T("Pyramid", "พีระมิด"), Func = Request("TpPyramid") })
        tpBox:AddButton({ Text = T("Pool", "สระ"), Func = Request("TpPool") })
        local gymDropdown = tpBox:AddDropdown("GymTarget", {
            Text = T("Gym", "ยิม"),
            Values = Values(GymNames),
            Default = 1,
            Callback = function(value) State.GymTarget = value and value:match("^Gym (%S+)") end,
        })
        State.GymTarget = gymDropdown.Value and gymDropdown.Value:match("^Gym (%S+)")
        tpBox:AddButton({ Text = T("Go To Gym", "ไปยิม"), Func = Request("TpGym") })

        local playerDropdown = tpBox:AddDropdown("PlayerTarget", {
            Text = T("Player", "ผู้เล่น"),
            Values = PlayerNames(),
            Searchable = true,
            AllowNull = true,
            Callback = function(value) State.PlayerTarget = value end,
        })
        tpBox:AddButton({ Text = T("Refresh Players", "รีเฟรชผู้เล่น"), Func = function() playerDropdown:SetValues(PlayerNames()) end })
        tpBox:AddButton({ Text = T("Go To Player", "ไปหาผู้เล่น"), Func = Request("TpPlayer") })
    end

    local function BuildSettings(window)
        local settingsTab = window:AddSettingsTab()
        local sessionBox = settingsTab:AddRightGroupbox(T("Session", "เซสชัน"), "gear")
        Toggle(sessionBox, "AntiAfk", T("Anti AFK", "กันหลุด AFK"), T("Stops the idle kick", "กันโดนเตะเพราะไม่ขยับ"))
        Toggle(sessionBox, "AutoRejoin", T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"))
        Toggle(sessionBox, "NoRender", T("Disable 3D Rendering", "ปิดการเรนเดอร์ 3D"), T("Saves battery and CPU while farming", "ประหยัดแบตและ CPU ตอนฟาร์ม"), function(on)
            RunService:Set3dRenderingEnabled(not on)
        end)
        sessionBox:AddButton({ Text = T("FPS Boost", "เพิ่ม FPS"), Func = Request("Boost") })
        sessionBox:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟเดิมใหม่"), Func = Request("Rejoin") })
        sessionBox:AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Func = Request("Hop") })
    end

    local function Live()
        Library:Every(1, function()
            while #State.Messages > 0 do
                Notify(table.remove(State.Messages, 1))
            end
            DrainHalted()
            if statusLabel then statusLabel:SetText(State.Summary or "-") end
            if not runLabel then return end
            runLabel:SetText(State.Task == "None" and State.Status or ("%s: %s"):format(State.Task, State.Status))
        end)
    end

    local function BuildTabs()
        local window = Library.Window
        xDTaraZ.Util.Try("ui main", BuildMain, window)
        xDTaraZ.Util.Try("ui farm", BuildFarm, window)
        xDTaraZ.Util.Try("ui training", BuildTraining, window)
        xDTaraZ.Util.Try("ui shop", BuildShop, window)
        xDTaraZ.Util.Try("ui player", BuildPlayer, window)
        xDTaraZ.Util.Try("ui settings", BuildSettings, window)
        xDTaraZ.Util.Try("ui gate", Gate)
        xDTaraZ.Util.Try("ui live", Live)
    end

    local function UnloadHub()
        Library:Unload()
    end
    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    Library:OnUnload(function()
        if getgenv().BuildThePyramidUnload == UnloadHub then getgenv().BuildThePyramidUnload = nil end
    end)
    getgenv().BuildThePyramidUnload = UnloadHub

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Build the Pyramid by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            BuildTabs()
            xDTaraZ.Util.Try("boot", xDTaraZ.Scheduler.Boot)
            Notify("Loaded", "Success")
            xDTaraZ.Util.Try("autoload config", Library.LoadAutoloadConfig, Library)
        end,
    })
    return true
end

if getgenv().BuildThePyramidUnload then
    pcall(getgenv().BuildThePyramidUnload)
end

pcall(MarioBanner.Step, "Systems")
if BuildInterface() then
    pcall(MarioBanner.Step, "Interface")
    pcall(MarioBanner.Ready)
end