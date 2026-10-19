if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765012427 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Build the Pyramid only")
    return
end

if getgenv().BuildThePyramidUnload then
    pcall(getgenv().BuildThePyramidUnload)
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
local ProximityPromptService = game:GetService("ProximityPromptService")

local LocalPlayer = Players.LocalPlayer
local osClock = os.clock
local vector3New = Vector3.new

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Platform = {
    Touch = UserInputService.TouchEnabled,
    Mobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled,
    Console = GuiService:IsTenFootInterface(),
    Viewport = Workspace.CurrentCamera and Workspace.CurrentCamera.ViewportSize or Vector2.zero,
}

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UpdateLog = {
        { "2026-10-19", "Halloween, Pipelined Farm Engine & Multi-Tier Pool\n• Auto Farm: Low-overhead pipelined batch pickup & multi-slot placement\n• Network Acceleration [OP]: RakNet Insane Instant Farm, Remote Quarry Refill & Wire-Speed Packet Burst\n• Halloween & Economy: Dual-currency upgrades (Candy Corn & Coins) with icons, Secret Codes\n• Waters of Nu: Multi-tier detection (Basic, Silver, Gold, Void, Haunted, Cursed)\n• Pet Suite: Native Equip Best, Exclusive-safe Auto-Delete & Auto-Lock Rares\n• World Travel & POIs: Halloween Portal, Sun Shrine, Event Sign, Jack NPC\n• OP Exploits: Zero-lag PromptShown Instant Prompts, Anti-Hazard & Fast Hold" },
        { "2026-10-13", "Smart Progression and faster Auto Farm\nPets, hatching limits and full ESP\nAuto Skip Cutscene and Spectate\nFixed pool training, respawn and camera recovery\nImproved upgrade guards, rejoin and cleanup" },
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
    LocalReloadFile = "mariohub/runtime/build_the_pyramid.lua",
    TickDelay = 0.1,
    LoadTimeout = 10,
    RemoteTimeout = 5,
    MaxInflight = 128,
    MaxBatch = 64,
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
    QuarrySpot = vector3New(-234.75, -6.5, 38.25),
    BenchRange = 12,
    BenchRetry = 2,
    StandRadius = 4,
    UpgradeInterval = 2,
    UpgradeGap = 0.3,
    UpgradeBurst = 36,
    CodeGap = 1.1,
    ActivityInterval = 5,
    RateWindow = 60,
    RejoinDelay = 5,
    BankInterval = 10,
    BankSettle = 1,
    GiftInterval = 30,
    BoostInterval = 30,
    FlyKeys = { Up = Enum.KeyCode.Space, Down = Enum.KeyCode.Q },
    AutoOptions = { "AutoFarm", "InsaneInstant", "AutoPickup", "AutoPlace", "AutoStrength", "AutoSpeed", "AutoPool", "AutoUpgrade", "AutoGift", "TrainWhileWaiting", "AutoProgression" },
    CodeFinal = { Redeemed = true, AlreadyRedeemed = true, Expired = true, FullyClaimed = true },
    CodeLabels = { Redeemed = "redeemed", AlreadyRedeemed = "already used", Expired = "expired", FullyClaimed = "fully claimed", InvalidCode = "invalid", NoReply = "no reply" },
    SlowRequests = { UpgradeNow = true, CodesNow = true, GiftNow = true, Hop = true, PetsBestNow = true, PetsRefresh = true, PetEquipNow = true, PetUnequipNow = true, PetLockNow = true, PetUnlockNow = true, PetUnequipAllNow = true, PetDeleteUnlockedNow = true, BlocksNow = true, SecondsNow = true, TpSunGod = true, TpEventSign = true, SignUpEventNow = true, RaknetCycleNow = true },
    ExtraCodes = { "HALLOWEEN", "PETS", "SORRYFORDELAY", "SUNGOD", "SORRYFORUPDATEBUG", "FREECODE", "WELCOME", "DEADBYMELOL", "UPDATE15", "PYRAMID1500" },
}

xDTaraZ.State = {
    Alive = true,
    Inflight = {},
    InflightCount = 0,
    WorkEpoch = 0,
    Connections = {},
    MoveConns = {},
    Requests = {},
    Running = {},
    Messages = {},
    Last = {},
    Stats = {},
    CoinLog = {},
    CycleLog = {},
    BlockLog = {},
    FarmSamples = {},
    Placed = 0,
    BlocksPlaced = 0,
    FarmWait = 0,
    CodeDone = {},
    UpgradeGain = {},
    BankRefused = {},
    Fails = {},
    FailSince = {},
    Halted = {},
    HaltQueue = {},
    Status = "Idle",
    Task = "None",
    CandyCornLog = {},
    CandyCornGained = 0,
    Opt = {
        AutoFarm = false,
        RemoteQuarry = false,
        PacketBurst = false,
        InsaneInstant = false,
        InstantPrompts = false,
        AntiHazard = false,
        FastInteract = false,
        AutoPickup = false,
        AutoPlace = false,
        AutoHatch = false,
        AutoEquipPets = false,
        AutoLockRares = false,
        AutoDeletePets = false,
        AutoDeleteFilter = "Common & Uncommon",
        PetEgg = "Basic",
        PetHatchAmount = "Best Owned",
        PetKeepCoins = 0,
        PetKeepCandyCorn = 0,
        PetHatchBudget = 0,
        PetSessionMax = 0,
        PetStopRarity = "None",
        PetStopId = "None",
        PetReturnOnStop = false,
        ReturnOnStop = false,
        StopCoins = 0,
        StopPyramids = 0,
        TrainWhileWaiting = false,
        TargetStrength = 0,
        TargetSpeed = 0,
        AutoGift = false,
        AutoBuyJack = false,
        UpgradeMax = {},
        PlaceReach = 30,
        FarmBatchCap = 64,
        FarmSettle = 0.15,
        FarmPlacement = "Native Bulk",
        BenchStation = "Best Unlocked",
        TreadmillStation = "Best Unlocked",
        AutoUpgrade = false,
        Upgrades = {},
        UpgradeOrder = "Best Value",
        UpgradeCurrency = "Auto",
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
        AutoSkipCutscene = false,
        AntiAfk = false,
        AutoRejoin = false,
        NoRender = false,
        SpendBlocks = false,
        SpendSeconds = false,
        KeepBlocks = 0,
        KeepSeconds = 0,
        ReturnTraining = false,
        FlyVertical = "Camera",
    },
}

local Config, State = xDTaraZ.Config, xDTaraZ.State

xDTaraZ.Util = {}

---@return boolean, ...  result before the deadline; timed-out workers remain counted until they return
function xDTaraZ.Util.Deadline(key, seconds, fn, allowStopped)
    if not State.Alive and not allowStopped then return false, "cancelled" end
    if State.Inflight[key] or State.InflightCount >= Config.MaxInflight then return false, "request still pending" end
    local token = {}
    State.Inflight[key] = token
    State.InflightCount += 1
    local done, packed = false, nil
    task.spawn(function()
        packed = table.pack(pcall(fn))
        done = true
        if State.Inflight[key] == token then State.Inflight[key] = nil end
        State.InflightCount -= 1
    end)
    local deadline = osClock() + seconds
    while not done and osClock() < deadline and (State.Alive or allowStopped) do task.wait() end
    if not done then return false, State.Alive and "request timed out" or "cancelled" end
    if not State.Alive and not allowStopped then return false, "cancelled" end
    return table.unpack(packed, 1, packed.n)
end

---@return string?, string?  body, or nil and why every transport failed
function xDTaraZ.Util.HttpGet(url)
    local ok, body = xDTaraZ.Util.Deadline("http:" .. url, Config.LoadTimeout, function() return game:HttpGet(url) end)
    if ok and type(body) == "string" then return body end
    local requester = request or http_request or (syn and syn.request) or (http and http.request)
    if not requester then return nil, "no http function" end

    local sent, reply = xDTaraZ.Util.Deadline("request:" .. url, Config.LoadTimeout, function() return requester({ Url = url, Method = "GET" }) end)
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
    local source = Config.ReloadSource
    local readable, body = pcall(function() return readfile(Config.LocalReloadFile) end)
    if readable and type(body) == "string" and loadstring(body) then
        source = "local ok,body=pcall(readfile," .. string.format("%q", Config.LocalReloadFile)
            .. "); if ok and type(body)=='string' then loadstring(body)() else " .. Config.ReloadSource .. " end"
    end
    source = "repeat task.wait(0.25) until game:IsLoaded()\n" .. source
    return (pcall(queue, source))
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
    return xDTaraZ.Util.Deadline(module, Config.LoadTimeout, function()
        local switched = pcall(setthreadidentity, 2)
        local read, identity = pcall(getthreadidentity)
        if switched and read and identity == 2 then
            return require(module)
        end
        GameLib.CanSwitch = false
        error("identity switching unavailable", 0)
    end)
end

---@return any?  module, nil when it is missing or no identity can require it
function GameLib.Require(module)
    if not (module and module:IsA("ModuleScript")) then return nil end
    local ok, loaded = xDTaraZ.Util.Deadline(module, Config.LoadTimeout, function() return require(module) end)
    if ok then return loaded end
    if loaded == "request timed out" or loaded == "request still pending" then return nil end
    local retried, again = GameLib.RequireAsGame(module)
    if retried then return again end
    warn("[BuildThePyramid] require " .. module.Name .. ":", loaded)
    return nil
end

do
    local carryFolder = Shared and (Shared:FindFirstChild("Blocks") or Shared:FindFirstChild("Books"))
    if not carryFolder and Shared then
        carryFolder = Shared:WaitForChild("Blocks", 2) or Shared:WaitForChild("Books", 2)
    end
    local modules = {
        Pyramid = Wait(SharedConfig, "PyramidConfig"),
        EggConfig = SharedConfig:FindFirstChild("EggConfig"),
        PetConfig = SharedConfig:FindFirstChild("PetConfig"),
        PetPresentation = SharedConfig:FindFirstChild("PetPresentationConfig"),
        PlaceConfig = SharedConfig:FindFirstChild("PlaceConfig"),
        PortalConfig = SharedConfig:FindFirstChild("PortalConfig"),
        JackConfig = SharedConfig:FindFirstChild("JackConfig"),
        Carry = Wait(SharedConfig, "CarryConfig"),
        Upgrades = Wait(SharedConfig, "UpgradeCatalog"),
        UpgradeLevels = Shared:FindFirstChild("Upgrades") and Shared.Upgrades:FindFirstChild("UpgradeLevels"),
        Gym = Wait(SharedConfig, "GymConfig"),
        Codes = Wait(SharedConfig, "CodesConfig"),
        Completion = Wait(SharedConfig, "PyramidCompletionConfig"),
        GymAccess = Wait(Wait(Shared, "Gym"), "GymAccess"),
        Runtime = Wait(Wait(Shared, "Placement"), "PyramidRuntime"),
        CarryState = carryFolder and (carryFolder:FindFirstChild("CarryState") or Wait(carryFolder, "CarryState")),
        Regions = Wait(Shared, "RegionRegistry"),
        Knit = Wait(Wait(ReplicatedStorage, "Packages"), "Knit"),
        Progression = Wait(Wait(Shared, "Stats"), "StatProgression"),
        PlacementRange = Shared:FindFirstChild("Placement") and Shared.Placement:FindFirstChild("PlacementRange"),
        CharacterAccess = Shared:FindFirstChild("CharacterAccess"),
        PyramidFallPhysics = Shared:FindFirstChild("Movement") and Shared.Movement:FindFirstChild("PyramidFallPhysics"),
    }
    for key, module in pairs(modules) do
        GameLib[key] = GameLib.Require(module)
    end
    if GameLib.Knit then
        local ok, controller = pcall(GameLib.Knit.GetController, "CompletionCinematicController")
        if ok and controller then GameLib.Cinematic = controller end
    end
end

if GameLib.EggConfig and GameLib.EggConfig.Order then State.Opt.PetEgg = GameLib.EggConfig.Order[1] end

GameLib.PetHatch = Remote("PetService", "RF", "Hatch")
GameLib.PetEquipBest = Remote("PetService", "RF", "EquipBest")
GameLib.PetEquip = Remote("PetService", "RF", "Equip")
GameLib.PetUnequip = Remote("PetService", "RF", "Unequip")
GameLib.PetSetLocked = Remote("PetService", "RF", "SetLocked")
GameLib.PetDelete = Remote("PetService", "RF", "DeletePets")
GameLib.PetUnequipAll = Remote("PetService", "RF", "UnequipAll")

GameLib.Pickup = Remote("BlockService", "RF", "Pickup")
GameLib.CarryChanged = Remote("BlockService", "RE", "CarryStateChanged")
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
GameLib.ShopPurchase = Remote("ShopService", "RF", "RequestPassPurchase")
GameLib.EquipCharacter = Remote("ShopService", "RF", "EquipCharacter")
GameLib.TutorialComplete = Remote("TutorialService", "RF", "Complete")
GameLib.TutorialSkip = Remote("TutorialService", "RF", "Skip")
GameLib.SettingsSet = Remote("SettingsService", "RF", "Set")
GameLib.PyramidState = Remote("PyramidService", "RF", "GetState")

xDTaraZ.UpgradeByName = {}
xDTaraZ.UpgradeNames = {}
xDTaraZ.UpgradeImages = {}
do
    for _, upgrade in ipairs(GameLib.Upgrades and GameLib.Upgrades.Upgrades or {}) do
        xDTaraZ.UpgradeByName[upgrade.DisplayName] = upgrade
        xDTaraZ.UpgradeImages[upgrade.DisplayName] = upgrade.Icon
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
        AutoSkipCutscene = { "Cinematic" },
        AutoFarm = { "Pyramid", "Carry", "CarryState", "Runtime", "Regions", "Upgrades", "Pickup", "Place" },
        AutoStrength = { "Gym", "GymAccess", "StartBench", "StopBench" },
        AutoSpeed = { "Gym", "GymAccess", "StopBench" },
        AutoPool = { "Pyramid", "Completion", "Gym", "StopBench" },
        AutoUpgrade = { "Upgrades", "Purchase", "Knit" },
        AutoGift = { "GiftState", "GiftStep", "GiftClaim" },
        SpendBlocks = { "SpendBlocks", "Runtime" },
        SpendSeconds = { "SpendSeconds", "Pyramid", "Completion" },
        TrainWhileWaiting = { "Gym", "GymAccess", "StartBench", "StopBench" },
    },
}

xDTaraZ.Gate.Needs.AutoProgression = { "Pyramid", "Carry", "CarryState", "Runtime", "Regions", "Upgrades", "Pickup", "Place", "Gym", "GymAccess", "StartBench", "StopBench" }
xDTaraZ.Gate.Needs.AutoHatch = { "EggConfig", "PetConfig", "PetHatch", "Knit" }
xDTaraZ.Gate.Needs.AutoEquipPets = { "PetConfig", "PetEquipBest", "Knit" }
xDTaraZ.Gate.Needs.AutoPickup = xDTaraZ.Gate.Needs.AutoFarm
xDTaraZ.Gate.Needs.AutoPlace = xDTaraZ.Gate.Needs.AutoFarm
xDTaraZ.Gate.Needs.AutoBuyJack = { "ShopPurchase", "EquipCharacter" }

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
    if not State.Alive then return end
    table.insert(self.State.Messages, msg)
end

function xDTaraZ:Character()
    local char = LocalPlayer.Character
    if not char then return nil end
    if State.Character ~= char or not (State.Humanoid and State.Root and State.Root.Parent) then
        State.Character = char
        State.Humanoid = char:FindFirstChildOfClass("Humanoid")
        State.Root = char:FindFirstChild("HumanoidRootPart")
    end
    local hum, hrp = State.Humanoid, State.Root
    if not (hum and hrp and hum.Health > 0) then return nil end
    return char, hum, hrp
end

function xDTaraZ:Invoke(remote, ...)
    if not remote then return false, "missing remote" end
    local args = table.pack(...)
    local packed = table.pack(xDTaraZ.Util.Deadline({}, Config.RemoteTimeout, function()
        return remote:InvokeServer(table.unpack(args, 1, args.n))
    end))
    if not packed[1] then
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
    local cap = xDTaraZ.Game.Capacity()
    if State.CarrySnapshot then
        if cap > 0 and State.CarrySnapshot.count > cap then
            State.CarrySnapshot = nil
        else
            return State.CarrySnapshot.count
        end
    end
    if GameLib.CarryState then
        local ok, native = pcall(GameLib.CarryState.read, LocalPlayer)
        if ok and type(native) == "table" and tonumber(native.count) then
            local count = tonumber(native.count) or 0
            if cap <= 0 or count <= cap then
                return count
            end
        end
    end
    return tonumber(xDTaraZ.Game.Attr("CarriedCount")) or 0
end

function xDTaraZ.Game.Coins()
    return tonumber(State.Stats.Coins) or 0
end

function xDTaraZ.Game.CandyCorn()
    return tonumber(State.Stats.CandyCorn) or 0
end

function xDTaraZ.Game.World()
    if GameLib.PlaceConfig and type(GameLib.PlaceConfig.World) == "string" then
        return GameLib.PlaceConfig.World
    end
    if Workspace:FindFirstChild("MainPlacePortalArea") then
        return "Halloween"
    end
    return "Main"
end

function xDTaraZ.Game.Benching()
    if not GameLib.Gym then return nil end
    local station = xDTaraZ.Game.Attr(GameLib.Gym.BenchStationAttribute)
    return type(station) == "string" and station ~= "" and station or nil
end

function xDTaraZ.Game.Model()
    if not GameLib.Pyramid then return nil end
    return Workspace:FindFirstChild(GameLib.Pyramid.ModelName)
end

---@return boolean  completion window running (pool is open)
function xDTaraZ.Game.Completed()
    local model = xDTaraZ.Game.Model()
    if not model then return false end
    if model:GetAttribute(GameLib.Pyramid.CompleteAttribute) == true then return true end
    local endsAt = GameLib.Completion and tonumber(model:GetAttribute(GameLib.Completion.CompletionEndsAtAttribute)) or 0
    return endsAt > Workspace:GetServerTimeNow()
end

---@return number?, string?  seconds remaining until next pyramid reset and active tierId
function xDTaraZ.Game.ResetCountdown()
    local model = xDTaraZ.Game.Model()
    local tierId = model and (model:GetAttribute("PyramidTierId") or model:GetAttribute("TierId"))
    if model and GameLib.Completion then
        local endsAt = tonumber(model:GetAttribute(GameLib.Completion.CompletionEndsAtAttribute))
        if endsAt and endsAt > Workspace:GetServerTimeNow() then
            return math.max(math.ceil(endsAt - Workspace:GetServerTimeNow()), 0), tierId
        end
    end
    local now = osClock()
    if State.PyramidStateCache and now < State.PyramidStateNext then
        return State.PyramidStateCache, State.PyramidTierCache or tierId
    end
    State.PyramidStateNext = now + 2
    if not GameLib.PyramidState then return nil, tierId end
    local ok, res = pcall(GameLib.PyramidState.InvokeServer, GameLib.PyramidState)
    local secs = ok and type(res) == "table" and tonumber(res.resetInSeconds) or nil
    State.PyramidStateCache = secs and math.max(math.ceil(secs), 0) or nil
    State.PyramidTierCache = ok and type(res) == "table" and res.tierId or tierId
    return State.PyramidStateCache, State.PyramidTierCache
end

---@param carryState any  "revision:count:..." string from a Pickup/Place reply
---@return number?         blocks held, nil when the reply carries no state
function xDTaraZ.Game.ReadCarry(carryState)
    if not State.Alive or type(carryState) ~= "string" then return nil end
    local ok, decoded = pcall(GameLib.CarryState.decode, carryState)
    if not ok or type(decoded) ~= "table" then return nil end
    local count, revision = tonumber(decoded.count), tonumber(decoded.revision)
    if not count or count < 0 or not revision then return nil end
    local cap = xDTaraZ.Game.Capacity()
    if cap > 0 and count > cap then return nil end
    if not State.CarrySnapshot or revision >= State.CarrySnapshot.revision or (count == 0 and revision ~= State.CarrySnapshot.revision) then
        State.CarrySnapshot = { revision = revision, count = count }
        State.CarryConfirmed = true
        if GameLib.CarryState.observe then
            pcall(GameLib.CarryState.observe, LocalPlayer, carryState)
        end
    end
    return count
end

function xDTaraZ.Game.WatchStats()
    local ok, err = pcall(function()
        local ready, why = xDTaraZ.Util.Deadline("StatsStart", Config.LoadTimeout, function()
            GameLib.Knit.OnStart():await()
            return true
        end)
        if not ready then error(tostring(why), 0) end
        if not State.Alive then return end
        local prop = GameLib.Knit.GetService("DataService").StatValues
        if not State.Alive then return end
        local conn = prop:Observe(function(values)
            if not State.Alive then return end
            if type(values) ~= "table" then return end
            local before = tonumber(State.Stats.Coins)
            local now = tonumber(values.Coins)
            if before and now and now > before then table.insert(State.CoinLog, { osClock(), now - before }) end
            local beforeCandy = tonumber(State.Stats.CandyCorn)
            local nowCandy = tonumber(values.CandyCorn)
            if beforeCandy and nowCandy and nowCandy > beforeCandy then
                table.insert(State.CandyCornLog, { osClock(), nowCandy - beforeCandy })
                State.CandyCornGained = (State.CandyCornGained or 0) + (nowCandy - beforeCandy)
            end
            State.Stats = values
        end)
        table.insert(State.Connections, conn)
    end)
    if not ok then warn("[BuildThePyramid] stats:", err) end
end

xDTaraZ.Exploits = {
    OriginalPromptDurations = {},
    PromptConn = nil,
    HazardConn = nil,
    OriginalFastHooks = nil,
    OriginalHazardStart = nil,
}

local FAST_INTERACT_LOOK = {
    instafillRepeatInterval = 0,
    instafillRepeatDelay = 0,
    instafillActionsPerFrame = 60,
    placeDistanceMultiplier = 8,
    completionMultiplier = 4,
}

function xDTaraZ.Exploits.SetInstantPrompts(enabled)
    local fn = setproximitypromptduration
    local function Apply(prompt)
        if not (prompt and prompt:IsA("ProximityPrompt")) then return end
        if xDTaraZ.Exploits.OriginalPromptDurations[prompt] == nil then
            xDTaraZ.Exploits.OriginalPromptDurations[prompt] = prompt.HoldDuration
        end
        if fn then
            pcall(fn, prompt, 0)
        else
            pcall(function() prompt.HoldDuration = 0 end)
        end
    end
    if enabled then
        for _, folderName in ipairs({ "HalloweenPortalArea", "MainPlacePortalArea", "SunGod", "EventSign", "JackArea", "Quarry" }) do
            local folder = Workspace:FindFirstChild(folderName)
            if folder then
                for _, desc in ipairs(folder:GetDescendants()) do Apply(desc) end
            end
        end
        if not xDTaraZ.Exploits.PromptConn then
            xDTaraZ.Exploits.PromptConn = ProximityPromptService.PromptShown:Connect(function(prompt)
                if State.Alive and State.Opt.InstantPrompts then Apply(prompt) end
            end)
            table.insert(State.Connections, xDTaraZ.Exploits.PromptConn)
        end
        return
    end
    if xDTaraZ.Exploits.PromptConn then
        xDTaraZ.Exploits.PromptConn:Disconnect()
        xDTaraZ.Exploits.PromptConn = nil
    end
    for prompt, orig in pairs(xDTaraZ.Exploits.OriginalPromptDurations) do
        if prompt and prompt.Parent then
            if fn then pcall(fn, prompt, orig) else pcall(function() prompt.HoldDuration = orig end) end
        end
    end
    table.clear(xDTaraZ.Exploits.OriginalPromptDurations)
end

function xDTaraZ.Exploits.SetAntiHazard(enabled)
    local fallPhysics = GameLib.PyramidFallPhysics
    if not enabled then
        if xDTaraZ.Exploits.HazardConn then
            xDTaraZ.Exploits.HazardConn:Disconnect()
            xDTaraZ.Exploits.HazardConn = nil
        end
        if fallPhysics and xDTaraZ.Exploits.OriginalHazardStart then
            pcall(function()
                if setreadonly then setreadonly(fallPhysics, false) end
                fallPhysics.start = xDTaraZ.Exploits.OriginalHazardStart
            end)
            xDTaraZ.Exploits.OriginalHazardStart = nil
        end
        return
    end
    if fallPhysics and type(fallPhysics.start) == "function" and not xDTaraZ.Exploits.OriginalHazardStart then
        xDTaraZ.Exploits.OriginalHazardStart = fallPhysics.start
        pcall(function()
            if setreadonly then setreadonly(fallPhysics, false) end
            fallPhysics.start = function(char, hum, hrp, janitor)
                if State.Alive and State.Opt.AntiHazard and char == LocalPlayer.Character then return nil end
                return xDTaraZ.Exploits.OriginalHazardStart and xDTaraZ.Exploits.OriginalHazardStart(char, hum, hrp, janitor)
            end
        end)
    end
    if xDTaraZ.Exploits.HazardConn then return end
    xDTaraZ.Exploits.HazardConn = RunService.Heartbeat:Connect(function()
        if not (State.Alive and State.Opt.AntiHazard) then return end
        local char, hum, hrp = xDTaraZ:Character()
        if not (char and hrp) then return end
        if char:GetAttribute("PyramidFallId") then pcall(char.SetAttribute, char, "PyramidFallId", nil) end
        if hrp.Position.Y >= -50 then return end
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        local safeSpot = (xDTaraZ.Move and xDTaraZ.Move.QuarrySpot and xDTaraZ.Move.QuarrySpot()) or Config.QuarrySpot
        char:PivotTo(CFrame.new(safeSpot + vector3New(0, 3, 0)))
        if hum then
            hum.PlatformStand = false
            hum.Sit = false
        end
    end)
    table.insert(State.Connections, xDTaraZ.Exploits.HazardConn)
end

function xDTaraZ.Exploits.SetFastInteract(enabled)
    local charAccess = GameLib.CharacterAccess
    if not (charAccess and type(charAccess) == "table") then return end
    pcall(function()
        if setreadonly then setreadonly(charAccess, false) end
        if not enabled then
            for name, orig in pairs(xDTaraZ.Exploits.OriginalFastHooks or {}) do
                charAccess[name] = orig
            end
            xDTaraZ.Exploits.OriginalFastHooks = nil
            return
        end
        if xDTaraZ.Exploits.OriginalFastHooks then return end
        local origBurst = charAccess.holdRepeatBurst
        local origInterval = charAccess.holdRepeatInterval
        local origDelay = charAccess.holdRepeatDelay
        local origLook = charAccess.look
        local saved = {
            holdRepeatBurst = origBurst,
            holdRepeatInterval = origInterval,
            holdRepeatDelay = origDelay,
            look = origLook,
        }
        local overrides = {
            holdRepeatBurst = function(player)
                return (State.Alive and State.Opt.FastInteract) and 60 or (origBurst and origBurst(player))
            end,
            holdRepeatInterval = function(player, interval)
                return (State.Alive and State.Opt.FastInteract) and 0 or (origInterval and origInterval(player, interval))
            end,
            holdRepeatDelay = function(player, delay)
                return (State.Alive and State.Opt.FastInteract) and 0 or (origDelay and origDelay(player, delay))
            end,
            look = function(player)
                return (State.Alive and State.Opt.FastInteract) and FAST_INTERACT_LOOK or (origLook and origLook(player))
            end,
        }
        for name, fn in pairs(overrides) do
            if type(saved[name]) == "function" then
                charAccess[name] = fn
            end
        end
        xDTaraZ.Exploits.OriginalFastHooks = saved
    end)
end

function xDTaraZ.Exploits.CompleteTutorial()
    if GameLib.TutorialComplete then
        local ok, res = xDTaraZ:Invoke(GameLib.TutorialComplete)
        if ok and type(res) == "table" and res.ok then
            xDTaraZ:Notify("Tutorial completed!")
            return true
        end
    end
    if GameLib.TutorialSkip then
        local ok, res = xDTaraZ:Invoke(GameLib.TutorialSkip)
        if ok and type(res) == "table" and res.ok then
            xDTaraZ:Notify("Tutorial skipped!")
            return true
        end
    end
    xDTaraZ:Notify("Tutorial already completed or unavailable")
    return false
end

xDTaraZ.Raknet = {}

function xDTaraZ.Raknet.Available()
    return type(raknet) == "table"
        and type(raknet.add_send_hook) == "function"
        and type(raknet.remove_send_hook) == "function"
        and type(raknet.add_receive_hook) == "function"
        and type(raknet.remove_receive_hook) == "function"
        and type(raknet.send) == "function"
end

function xDTaraZ.Raknet.RemoveSendHook()
    if xDTaraZ.Raknet.SendHook and xDTaraZ.Raknet.Available() then
        pcall(raknet.remove_send_hook, xDTaraZ.Raknet.SendHook)
    end
    xDTaraZ.Raknet.SendHook = nil
end

function xDTaraZ.Raknet.RemoveRecvHook()
    if xDTaraZ.Raknet.RecvHook and xDTaraZ.Raknet.Available() then
        pcall(raknet.remove_receive_hook, xDTaraZ.Raknet.RecvHook)
    end
    xDTaraZ.Raknet.RecvHook = nil
end

function xDTaraZ.Raknet.Stop()
    xDTaraZ.Raknet.RemoveSendHook()
    xDTaraZ.Raknet.RemoveRecvHook()
end

function xDTaraZ.Raknet.EnsureQuarryPhysics()
    if not xDTaraZ.Raknet.Available() then return false end
    local char, _, hrp = xDTaraZ:Character()
    if not (char and hrp) then return false end
    if State.QuarryPhysBuf and State.QuarryPhysChar == char then return true end
    State.QuarryPhysBuf = nil
    if not xDTaraZ.Move.To(xDTaraZ.Move.QuarrySpot()) then return false end
    local function CaptureHook(pkt)
        if pkt.PacketId ~= 161 or State.QuarryPhysBuf then return end
        State.QuarryPhysBuf = pkt.AsBuffer
        State.QuarryPriority = pkt.Priority
        State.QuarryReliability = pkt.Reliability
        State.QuarryChannel = pkt.OrderingChannel
        State.QuarryPhysChar = char
    end
    xDTaraZ.Raknet.RemoveSendHook()
    xDTaraZ.Raknet.SendHook = CaptureHook
    pcall(raknet.add_send_hook, CaptureHook)
    hrp.AssemblyLinearVelocity = vector3New(0, 0.05, 0)
    local deadline = osClock() + 0.35
    while not State.QuarryPhysBuf and osClock() < deadline and State.Alive do
        task.wait()
    end
    xDTaraZ.Raknet.RemoveSendHook()
    hrp.AssemblyLinearVelocity = Vector3.zero
    return State.QuarryPhysBuf ~= nil
end

function xDTaraZ.Raknet.BeginQuarrySpoof()
    if not (xDTaraZ.Raknet.Available() and State.QuarryPhysBuf) then return false end
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return false end
    local function SpoofHook(pkt)
        if pkt.PacketId ~= 161 or not State.QuarryPhysBuf then return end
        local cur = pkt.AsBuffer
        local qBuf = State.QuarryPhysBuf
        local len = buffer.len(qBuf)
        local out = buffer.create(len)
        buffer.copy(out, 0, qBuf, 0, len)
        if buffer.len(cur) >= 4 and len >= 4 then
            buffer.writeu8(out, 1, buffer.readu8(cur, 1))
            buffer.writeu8(out, 2, buffer.readu8(cur, 2))
            buffer.writeu8(out, 3, buffer.readu8(cur, 3))
        end
        pkt:SetData(out)
    end
    xDTaraZ.Raknet.RemoveSendHook()
    xDTaraZ.Raknet.SendHook = SpoofHook
    if not pcall(raknet.add_send_hook, SpoofHook) then
        xDTaraZ.Raknet.SendHook = nil
        return false
    end
    pcall(raknet.send, State.QuarryPhysBuf, State.QuarryPriority or 1, State.QuarryReliability or 0, State.QuarryChannel or 0)
    return true
end

function xDTaraZ.Raknet.EndQuarrySpoof(standFrame)
    xDTaraZ.Raknet.RemoveSendHook()
    local _, _, hrp = xDTaraZ:Character()
    if not (hrp and standFrame) then return end
    hrp.CFrame = standFrame
    hrp.AssemblyLinearVelocity = Vector3.zero
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
    local token = { Object = camera, Type = camera.CameraType }
    State.CameraFreeze = token
    camera.CameraType = Enum.CameraType.Scriptable
    task.spawn(function()
        RunService.RenderStepped:Wait()
        RunService.RenderStepped:Wait()
        if State.CameraFreeze ~= token then return end
        local cinematic = GameLib.Cinematic
        if cinematic and cinematic._playing then
            if Workspace.CurrentCamera == camera and cinematic._savedCameraType == Enum.CameraType.Scriptable then cinematic._savedCameraType = token.Type end
        elseif camera.CameraType == Enum.CameraType.Scriptable then camera.CameraType = token.Type end
        State.CameraFreeze = nil
    end)
end

---@param stream boolean?  ask the engine to load the destination first (far targets only)
function xDTaraZ.Move.To(pos, stream)
    local manual = State.ManualMove or State.FarmManual
    if not State.Alive or (not manual and State.ActiveEpoch ~= nil and State.ActiveEpoch ~= State.WorkEpoch) then return false end
    local char, _, hrp = xDTaraZ:Character()
    if not hrp or not char then return false end
    if stream and (hrp.Position - pos).Magnitude > Config.StreamDistance then xDTaraZ.Move.Stream(pos) end
    if not State.Alive or (not manual and State.ActiveEpoch ~= nil and State.ActiveEpoch ~= State.WorkEpoch) then return false end
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
    local freezeCamera = (hrp.Position - pos).Magnitude > Config.CameraShieldJump
    if freezeCamera then xDTaraZ.Move.FreezeCamera() end
    char:PivotTo(CFrame.new(pos) * hrp.CFrame.Rotation)
    return true
end

function xDTaraZ.Move.Pivot(pos)
    local char, _, hrp = xDTaraZ:Character()
    if not (char and hrp) then return false end
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
    char:PivotTo(CFrame.new(pos) * hrp.CFrame.Rotation)
    return true
end

function xDTaraZ.Move.Near(pos, radius)
    local _, _, hrp = xDTaraZ:Character()
    return hrp ~= nil and (hrp.Position - pos).Magnitude <= (radius or Config.StandRadius)
end

---@param frame CFrame  local restoration also works while unloading
function xDTaraZ.Move.Restore(frame)
    local char, _, root = xDTaraZ:Character()
    if not root or not char then return false end
    if (root.Position - frame.Position).Magnitude > Config.CameraShieldJump then xDTaraZ.Move.FreezeCamera() end
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    char:PivotTo(frame)
    return true
end

---@param jitter boolean?  pick a random spot inside the region instead of its centre
function xDTaraZ.Move.QuarrySpot(jitter)
    local region = GameLib.Regions and GameLib.Regions.getPart("Quarry")
    local fallback = xDTaraZ.Game.World() == "Halloween" and vector3New(601.96, 340, 156.27) or Config.QuarrySpot
    if not (region and region:IsA("BasePart")) then return fallback end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LocalPlayer.Character, region }

    local top = region.Position + vector3New(0, region.Size.Y / 2, 0)
    if jitter then
        local spread = Config.QuarryJitter
        top += region.CFrame:VectorToWorldSpace(vector3New(
            (math.random() * 2 - 1) * region.Size.X * spread, 0, (math.random() * 2 - 1) * region.Size.Z * spread))
    end
    local hit = Workspace:Raycast(top, vector3New(0, -region.Size.Y - 50, 0), params)
    local spot = hit and hit.Position + vector3New(0, Config.StandHeight, 0)
    if spot and GameLib.Regions.isWithin("Quarry", spot) then return spot end
    return region.Position + vector3New(0, Config.StandHeight, 0)
end

function xDTaraZ.Move.GymPart(folder, model, part)
    if not GameLib.Gym or not folder then return nil end
    local gym = Workspace:FindFirstChild(GameLib.Gym.GymFolderName)
    local station = gym and gym:FindFirstChild(folder)
    local machine = station and station:FindFirstChild(model)
    local found = machine and machine:FindFirstChild(part)
    return found and found:IsA("BasePart") and found or nil
end

function xDTaraZ.Move.PoolSpot()
    if not GameLib.Completion then return nil end
    local display = Workspace:FindFirstChild(GameLib.Completion.CompletedDisplayName)
    if not display then
        for _, child in ipairs(Workspace:GetChildren()) do
            if child.Name:find("^Completed.*Pyramid$") then
                display = child
                break
            end
        end
    end
    local hitbox = display and display:FindFirstChild(GameLib.Completion.PoolHitboxName)
    if not hitbox or not hitbox:IsA("BasePart") then return nil end
    if State.PoolPart == hitbox and State.PoolSpot and osClock() < (State.PoolRayNext or 0) then return State.PoolSpot end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LocalPlayer.Character, hitbox }
    params.RespectCanCollide = true
    local up = hitbox.CFrame.UpVector
    local _, hum, root = xDTaraZ:Character()
    local height = hum and root and hum.HipHeight + root.Size.Y / 2 or Config.StandHeight
    local floor = Workspace:Raycast(hitbox.Position, -up * hitbox.Size.Y, params)
    local spot = floor and floor.Position + up * height
        or hitbox.CFrame:PointToWorldSpace(vector3New(0, -hitbox.Size.Y / 2 + height, 0))
    State.PoolPart, State.PoolSpot, State.PoolRayNext = hitbox, spot, osClock() + 1
    return spot
end

function xDTaraZ.Move.JackSpot()
    local jackArea = Workspace:FindFirstChild("JackArea")
    local jackModel = jackArea and jackArea:FindFirstChild("Jack")
    local torso = jackModel and (jackModel:FindFirstChild("Torso") or jackModel:FindFirstChild("HumanoidRootPart") or jackModel:FindFirstChildWhichIsA("BasePart"))
    return torso and torso.Position + vector3New(0, Config.StandHeight, 0)
end

function xDTaraZ.Move.EggsSpot()
    local folder = Workspace:FindFirstChild(GameLib.EggConfig and GameLib.EggConfig.WorldFolderName or "EggsArea")
    local part = folder and (folder:FindFirstChildWhichIsA("BasePart", true))
    return part and part.Position + vector3New(0, Config.StandHeight, 0)
end

function xDTaraZ.Move.SunGodSpot()
    local sg = Workspace:FindFirstChild("SunGod")
    local prompt = sg and sg:FindFirstChildWhichIsA("ProximityPrompt", true)
    local part = prompt and prompt.Parent or (sg and sg:FindFirstChildWhichIsA("BasePart", true))
    return part and part.Position + vector3New(0, Config.StandHeight, 0)
end

function xDTaraZ.Move.EventSignSpot()
    local es = Workspace:FindFirstChild("EventSign")
    local part = es and (es:FindFirstChild("PromptPart") or es:FindFirstChildWhichIsA("BasePart", true))
    return part and part.Position + vector3New(0, Config.StandHeight, 0)
end

function xDTaraZ.Move.TravelWorld(targetWorld)
    local portalCfg = GameLib.PortalConfig
    local placeCfg = GameLib.PlaceConfig
    local isHalloween = targetWorld == "Halloween"
    local areaName = isHalloween and (portalCfg and portalCfg.HalloweenAreaName or "HalloweenPortalArea")
        or (portalCfg and portalCfg.MainPlaceAreaName or "MainPlacePortalArea")
    local modelName = isHalloween and (portalCfg and portalCfg.HalloweenModelName or "HalloweenPortal")
        or (portalCfg and portalCfg.MainPlaceModelName or "MainPlacePortal")
    local placeId = isHalloween and (placeCfg and placeCfg.HalloweenPlaceId or 95412364107708)
        or (placeCfg and placeCfg.MainPlaceId or 123720558354386)
    if xDTaraZ.Game.World() == targetWorld then
        xDTaraZ:Notify("Already in " .. targetWorld .. " World!")
        return true
    end
    xDTaraZ.Util.QueueReload()
    local area = Workspace:FindFirstChild(areaName)
    local portal = area and area:FindFirstChild(modelName)
    local promptPart = portal and portal:FindFirstChild(portalCfg and portalCfg.PromptPartName or "ProximityPromptPart")
    local prompt = promptPart and promptPart:FindFirstChild(portalCfg and portalCfg.PromptName or "PortalPrompt")
    if promptPart and prompt then
        xDTaraZ.Move.To(promptPart.Position + vector3New(0, Config.StandHeight, 0), true)
        task.wait(0.2)
        if typeof(fireproximityprompt) == "function" then
            fireproximityprompt(prompt)
            return true
        end
    end
    TeleportService:Teleport(placeId, LocalPlayer)
    return true
end

function xDTaraZ.Move.HalloweenPortal()
    return xDTaraZ.Move.TravelWorld("Halloween")
end

function xDTaraZ.Move.MainPortal()
    return xDTaraZ.Move.TravelWorld("Main")
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
    if not State.FlyHumanoid then
        State.FlyHumanoid, State.FlyStand = hum, hum.PlatformStand
    elseif State.FlyHumanoid ~= hum then
        if State.FlyHumanoid.Parent then State.FlyHumanoid.PlatformStand = State.FlyStand end
        State.FlyHumanoid, State.FlyStand = hum, hum.PlatformStand
    end
    local cam = Workspace.CurrentCamera
    local dir = hum.MoveDirection
    local lift = cam and dir.Magnitude > 0 and cam.CFrame.LookVector.Y * dir.Magnitude or 0
    local typing = UserInputService:GetFocusedTextBox() ~= nil
    if not typing and (UserInputService:IsKeyDown(Config.FlyKeys.Up) or hum.Jump) then lift += 1 end
    if not typing and UserInputService:IsKeyDown(Config.FlyKeys.Down) then lift -= 1 end
    if State.Opt.FlyVertical == "Up" then
        lift = 1
    elseif State.Opt.FlyVertical == "Down" then
        lift = -1
    end

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
    if not opt.Fly and State.FlyHumanoid then
        local root = State.FlyHumanoid.Parent and State.FlyHumanoid.Parent:FindFirstChild("HumanoidRootPart")
        if root then root.AssemblyLinearVelocity = Vector3.zero end
        if State.FlyHumanoid.Parent then State.FlyHumanoid.PlatformStand = State.FlyStand end
        State.FlyHumanoid, State.FlyStand = nil, nil
    end
end

xDTaraZ.Farm = {}

function xDTaraZ.Farm.Enabled()
    local opt = State.Opt
    return opt.AutoFarm or opt.InsaneInstant or opt.AutoPickup or opt.AutoPlace or State.FarmManual or State.ProgressionFarm
end

function xDTaraZ.Farm.Cancelled()
    return not State.Alive or not xDTaraZ.Farm.Enabled() or State.ActiveEpoch ~= State.WorkEpoch
end

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

---@return number  blocks carried after the sweep
function xDTaraZ.Farm.Grab(region)
    if xDTaraZ.Farm.Cancelled() or not GameLib.Pickup then return xDTaraZ.Game.Carried() end
    local start = xDTaraZ.Game.Carried()
    local carried, cap = start, xDTaraZ.Game.Capacity()
    local isInsane = State.Opt.InsaneInstant or State.Opt.PacketBurst
    local batchLimit = isInsane and 128 or Config.MaxBatch
    local maxCalls = math.min(State.Opt.FarmBatchCap or batchLimit, batchLimit)
    local grant = 1 + xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPickup)

    for _ = 0, (isInsane and 1 or Config.PickupRetries) do
        if carried >= cap or xDTaraZ.Farm.Cancelled() then break end
        local needed = math.clamp(math.ceil((cap - carried) / grant), 1, maxCalls)
        local token = {}
        State.GrabToken = token
        local pending = needed
        for _ = 1, needed do
            task.spawn(function()
                if xDTaraZ.Farm.Cancelled() then
                    pending -= 1
                    return
                end
                local callOk, ok, carryState = pcall(GameLib.Pickup.InvokeServer, GameLib.Pickup, region)
                if not State.Alive or State.GrabToken ~= token or xDTaraZ.Farm.Cancelled() then return end
                if callOk and ok == true then
                    carried = math.max(carried, xDTaraZ.Game.ReadCarry(carryState) or carried)
                end
                pending -= 1
            end)
        end
        local deadline = osClock() + Config.PickupTimeout
        while pending > 0 and osClock() < deadline and carried < cap and not xDTaraZ.Farm.Cancelled() do
            task.wait()
        end
        if State.Alive then State.GrabToken = nil end
        if carried >= cap then break end
    end

    if carried > start and not xDTaraZ.Farm.Cancelled() then
        State.Carry = carried
        xDTaraZ.Farm.Progress()
    end
    return carried
end

function xDTaraZ.Farm.GrabAll(region)
    return xDTaraZ.Farm.Grab(region)
end

function xDTaraZ.Farm.GrabBatch(region)
    return xDTaraZ.Farm.Grab(region)
end

---@return boolean, string?  holding at least one block, else why not
function xDTaraZ.Farm.Gather()
    xDTaraZ.Farm.Wake()
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    local cap = xDTaraZ.Game.Capacity()
    if xDTaraZ.Game.Carried() >= cap then return true end

    State.Status = "Picking up blocks"
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return false, "Character not ready" end
    local region = GameLib.Regions.getPart("Quarry")

    if State.Opt.RemoteQuarry and xDTaraZ.Raknet.Available() and State.Backoff == nil then
        local standFrame = hrp.CFrame
        if xDTaraZ.Raknet.EnsureQuarryPhysics() then
            if (hrp.Position - standFrame.Position).Magnitude > 2 then
                hrp.CFrame = standFrame
                task.wait(0.05)
            end
            if xDTaraZ.Raknet.BeginQuarrySpoof() then
                local remoteCarried = xDTaraZ.Farm.Grab(region)
                xDTaraZ.Raknet.EndQuarrySpoof(standFrame)
                if remoteCarried > 0 then return true end
                State.QuarryPhysBuf = nil
            end
        end
    end

    local wasInQuarry = GameLib.Regions and GameLib.Regions.isWithin("Quarry", hrp.Position)
    if not xDTaraZ.Move.To(xDTaraZ.Move.QuarrySpot(State.Backoff ~= nil)) then return false, "Character not ready" end
    if not wasInQuarry and not State.Opt.InsaneInstant and (State.Opt.FarmSettle or 0) > 0 then
        task.wait(math.min(State.Opt.FarmSettle, Config.SettleDelay))
    end
    if xDTaraZ.Farm.Cancelled() then return false, "Stopped" end

    local carried = xDTaraZ.Farm.Grab(region)
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
    local picked, cells, rejected, reserved = {}, {}, {}, {}
    local geometry = xDTaraZ.Farm.Geometry()
    if not geometry then return picked end
    local context = GameLib.Runtime.getContext(Workspace)
    local budget = xDTaraZ.Game.Carried()
    local units = 1 + xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPlace)
    local nativeRange = GameLib.PlacementRange and GameLib.PlacementRange.forPlayer(LocalPlayer, GameLib.Pyramid.PlaceDistance) or State.Opt.PlaceReach
    local maxReach = math.max(State.Opt.PlaceReach, nativeRange - 4)
    local occupancy = {}
    local function Skip(layer, index)
        if rejected[layer .. ":" .. index] or reserved[layer .. ":" .. index] then return true end
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
        if #picked >= count or budget <= 0 then break end
        local slot = GameLib.Runtime.resolveNearestSlot(origin, Workspace, Skip, xDTaraZ.Farm.ClampCells(radius))
        if not slot then break end
        local flat = vector3New(slot.position.X - origin.X, 0, slot.position.Z - origin.Z)
        local col, row = geometry.fromSlotIndex(slot.layer, slot.slotIndex)
        if col and row and flat.Magnitude <= maxReach then
            reserved[slot.layer .. ":" .. slot.slotIndex] = true
            local layer = context and context.model:FindFirstChild(GameLib.Pyramid.LayerPrefix .. slot.layer)
            local extras = {}
            local nativeBulk = State.Opt.FarmPlacement ~= "Server Fill" and layer and type(geometry.findBulkSlots) == "function" and type(GameLib.Runtime.isSlotFreeInReplica) == "function"
            if nativeBulk and units > 1 then
                extras = geometry.findBulkSlots(slot.layer, slot.slotIndex, math.min(units - 1, budget - 1), function(index)
                    return not reserved[slot.layer .. ":" .. index] and GameLib.Runtime.isSlotFreeInReplica(layer, slot.layer, index, occupancy, geometry)
                end, function(index)
                    local cf = geometry.getSlotCFrame(slot.layer, index)
                    return cf ~= nil and (origin - cf.Position).Magnitude <= nativeRange
                end)
            end
            for _, index in ipairs(extras) do reserved[slot.layer .. ":" .. index] = true end
            slot.extraSlots = extras
            budget -= nativeBulk and (1 + #extras) or units
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
    if not GameLib.Place then return xDTaraZ.Game.Carried() end
    local pending, left, known, batchPlaced = #slots, xDTaraZ.Game.Carried(), false, 0
    local before, confirmed = left, State.CarryConfirmed
    local token = {}
    State.PlaceToken = token
    for _, slot in ipairs(slots) do
        task.spawn(function()
            if xDTaraZ.Farm.Cancelled() then
                pending -= 1
                return
            end
            local callOk, ok, carryState, placedUnits = pcall(GameLib.Place.InvokeServer, GameLib.Place, slot.layer, slot.slotIndex, slot.generation, slot.extraSlots or {})
            if not State.Alive then return end
            if callOk and ok == true then
                State.Placed = (State.Placed or 0) + 1
                State.LastSlot = slot.position
                batchPlaced += (tonumber(placedUnits) or 1)
            end
            if State.PlaceToken ~= token then return end
            local count = xDTaraZ.Game.ReadCarry(carryState)
            if count then left, known = math.min(left, count), true end
            pending -= 1
        end)
    end

    local deadline = osClock() + Config.PlaceTimeout
    while pending > 0 and osClock() < deadline and not (known and left <= 0) and not (batchPlaced >= before) and not xDTaraZ.Farm.Cancelled() do
        task.wait()
    end
    if State.Alive then State.PlaceToken = nil end
    if State.Alive then State.Carry = known and left or nil end
    if State.Alive and not xDTaraZ.Farm.Cancelled() then
        local blocks = (confirmed and known) and math.max(before - left, 0) or math.min(batchPlaced, before)
        if blocks > 0 then
            State.BlocksPlaced += blocks
            table.insert(State.BlockLog, { osClock(), blocks })
        end
    end
    return xDTaraZ.Game.Carried()
end

---@return boolean, string?  placed at least one block (or nothing left to place), else why not
function xDTaraZ.Farm.Deliver()
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return false, "Character not ready" end
    local before, why = State.Placed or 0, "Pyramid refused blocks"
    local passes = 0
    local maxPasses = State.Opt.InsaneInstant and 64 or Config.PlaceRetries

    while passes < maxPasses do
        passes += 1
        local carried = xDTaraZ.Game.Carried()
        if carried <= 0 or not (State.Alive and xDTaraZ.Farm.Enabled()) then return true end
        local first = xDTaraZ.Farm.FirstSlot(hrp.Position)
        if not first then
            why = "No free slot on the pyramid"
            break
        end

        State.Status = ("Placing on layer %d"):format(first.layer)
        local stand = first.position + vector3New(0, Config.HoverHeight, 0)
        if (hrp.Position - stand).Magnitude <= 80 then
            xDTaraZ.Move.Pivot(stand)
        else
            xDTaraZ.Move.To(stand)
        end
        local arrived = osClock()

        local nativeRange = GameLib.PlacementRange and GameLib.PlacementRange.forPlayer(LocalPlayer, GameLib.Pyramid.PlaceDistance) or State.Opt.PlaceReach
        local maxReach = math.max(State.Opt.PlaceReach, nativeRange - 4)
        local reach = math.ceil(maxReach / GameLib.Pyramid.BlockSize)
        local batchLimit = State.Opt.InsaneInstant and 128 or Config.MaxBatch
        local maxBatch = math.min(carried, State.Opt.InsaneInstant and 128 or (State.Opt.FarmBatchCap or batchLimit), batchLimit)
        local slots = xDTaraZ.Farm.Slots(stand, maxBatch, reach)
        local settle = State.Opt.InsaneInstant and 0 or (State.Opt.FarmSettle or 0)
        local remaining = settle - (osClock() - arrived)
        if remaining > 0 then task.wait(remaining) end
        if xDTaraZ.Farm.Cancelled() then return false, "Stopped" end
        local context = GameLib.Runtime and GameLib.Runtime.getContext(Workspace)
        if context and context.model then
            local liveGen = context.model:GetAttribute(GameLib.Pyramid.PlacementGenerationAttribute)
            if liveGen then
                for _, s in ipairs(slots) do
                    s.generation = liveGen
                end
            end
        end
        local lastPlaced = State.Placed
        if xDTaraZ.Farm.PlaceBatch(slots) <= 0 or State.Placed == lastPlaced then break end
    end

    if (State.Placed or 0) == before then return false, why end
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
    local target = not State.ProgressionFarm and xDTaraZ.Farm.TargetReached()
    if target then
        xDTaraZ.Scheduler.Finish({ "AutoFarm", "InsaneInstant", "AutoPickup", "AutoPlace" }, "Farm", target)
        return false
    end
    if State.Opt.InsaneInstant and xDTaraZ.Raknet.Available() then
        State.Opt.RemoteQuarry = true
        State.Opt.PacketBurst = true
    end
    if not (State.Opt.AutoFarm or State.Opt.InsaneInstant or State.ProgressionFarm) then
        if State.Opt.AutoPlace and xDTaraZ.Game.Carried() > 0 then return xDTaraZ.Farm.Deliver() end
        if State.Opt.AutoPickup then return xDTaraZ.Farm.Gather() end
        return false
    end
    if not State.Opt.InsaneInstant and osClock() < State.FarmWait then return false end
    local currentLayer = GameLib.Runtime.getCurrentLayer(Workspace)
    if not currentLayer then
        xDTaraZ.Farm.Progress()
        State.CurrentLayer = nil
        State.LastSlot = nil
        local resetSeconds, tierId = xDTaraZ.Game.ResetCountdown()
        if resetSeconds then
            State.Waiting = ("Resetting in %ds (%s)"):format(resetSeconds, tierId or "Pyramid")
        else
            State.Waiting = "Waiting for the next pyramid"
        end
        if not State.Opt.TrainWhileWaiting then
            xDTaraZ.Farm.Park()
        end
        return false
    end

    if State.CurrentLayer ~= currentLayer then
        State.CurrentLayer = currentLayer
        State.LastSlot = nil
        xDTaraZ.Farm.Progress()
    end

    if State.Waiting then
        if xDTaraZ.Game.Benching() and xDTaraZ.Train and xDTaraZ.Train.Leave then
            xDTaraZ.Train.Leave()
        end
        State.Waiting, State.Parked = nil, false
    end
    if not State.FarmOrigin then
        local _, _, hrp = xDTaraZ:Character()
        State.FarmOrigin = hrp and hrp.CFrame
    end
    local started, beforeBlocks = osClock(), State.BlocksPlaced
    local holding, why = xDTaraZ.Farm.Gather()
    local gathered = osClock()
    if xDTaraZ.Farm.Cancelled() then return false end
    if not holding then return xDTaraZ.Farm.Hold(why) end
    if not (State.Alive and xDTaraZ.Farm.Enabled()) then return false end

    local placed, reason = xDTaraZ.Farm.Deliver()
    if xDTaraZ.Farm.Cancelled() then return false end
    if not placed then return xDTaraZ.Farm.Hold(reason) end
    local finished = osClock()
    table.insert(State.CycleLog, finished)
    local blocks = State.BlocksPlaced - beforeBlocks
    if blocks > 0 then
        local sample = { gather = gathered - started, place = finished - gathered,
            seconds = finished - started, blocks = blocks, cap = xDTaraZ.Game.Capacity(),
            pickup = 1 + xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPickup),
            placement = 1 + xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPlace) }
        State.FarmSamples[#State.FarmSamples + 1] = sample
        if #State.FarmSamples > 16 then table.remove(State.FarmSamples, 1) end
        State.LastFarmSample = sample
    end
    return true
end

function xDTaraZ.Farm.Stop()
    xDTaraZ.Raknet.Stop()
    State.GrabToken, State.PlaceToken, State.Carry = nil, nil, nil
    local origin = State.FarmOrigin
    State.FarmOrigin, State.Waiting, State.Parked, State.FarmWait = nil, nil, false, 0
    xDTaraZ.Farm.Progress()
    if not (origin and State.Opt.ReturnOnStop) then return end
    local _, _, hrp = xDTaraZ:Character()
    if hrp then xDTaraZ.Move.Restore(origin) end
end

function xDTaraZ.Farm.Now(place)
    State.FarmManual = true
    local ok, result = pcall(place and xDTaraZ.Farm.Deliver or xDTaraZ.Farm.Gather)
    State.FarmManual = nil
    xDTaraZ.Raknet.Stop()
    if not ok then error(result, 0) end
    return result
end

function xDTaraZ.Farm.CycleNow()
    State.FarmManual = true
    local okGather, held = pcall(xDTaraZ.Farm.Gather)
    local okDeliver, placed = false, false
    if okGather and held then
        okDeliver, placed = pcall(xDTaraZ.Farm.Deliver)
    end
    State.FarmManual = nil
    xDTaraZ.Raknet.Stop()
    if not okGather then error(held, 0) end
    if not okDeliver and held then error(placed, 0) end
    return placed
end

xDTaraZ.Train = {}

function xDTaraZ.Train.HasAccess(folder)
    local access = GameLib.Gym and GameLib.Gym.Access[folder]
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
    for _, station in ipairs(stations or {}) do
        if xDTaraZ.Train.HasAccess(station.GymFolder) and (not bestMult or station[key] > bestMult) then
            best, bestMult = station.GymFolder, station[key]
        end
    end
    return best, bestMult
end

---@param chosen string  dropdown value, "Best Unlocked" or a gym folder
---@return string?       the chosen gym when you can use it, else the best one you can
function xDTaraZ.Train.Pick(stations, key, chosen)
    for _, station in ipairs(stations or {}) do
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
    local level = tonumber(xDTaraZ.Game.Attr("StrengthLevel")) or 0
    if State.Opt.TargetStrength > 0 and level >= State.Opt.TargetStrength then return false end
    local cached = State.SmartCache
    if cached and now - cached.at < Config.SmartRefresh then return cached.worth end

    local worth = false
    local value = tonumber(State.Stats.Strength)
    local coinRate, blockRate = State.CoinRate or 0, State.BlockRate or 0
    local sample = State.LastFarmSample
    local _, mult = xDTaraZ.Train.Pick((GameLib.Gym and GameLib.Gym.BenchpressStations or {}), "StrengthMultiplier", State.Opt.BenchStation)
    if GameLib.Progression and value and mult and sample and sample.blocks >= sample.cap and sample.seconds > 0 and coinRate > 0 and blockRate > 0 then
        local rate = xDTaraZ.Train.MeasuredRate(value, now) or Config.BenchBase * mult
        local seconds = (xDTaraZ.Train.NextLevelValue(value) - value) / rate
        local coinPerBlock = coinRate / blockRate
        local pickupCalls = math.max(math.ceil(sample.cap / sample.pickup), 1)
        local placeCalls = math.max(math.ceil(sample.cap / sample.placement), 1)
        local extraTime = (math.ceil((sample.cap + 1) / sample.pickup) - pickupCalls) * sample.gather / pickupCalls
            + (math.ceil((sample.cap + 1) / sample.placement) - placeCalls) * sample.place / placeCalls
        local nextBlockRate = (sample.blocks + 1) / (sample.seconds + extraTime)
        local marginal = math.max(nextBlockRate - sample.blocks / sample.seconds, 0) * coinPerBlock
        worth = marginal * State.Opt.SmartMinutes * 60 > seconds * coinRate
    end
    State.SmartCache = { at = now, worth = worth }
    return worth
end

function xDTaraZ.Train.Strength(chosen)
    if not State.Alive then return false end
    local _, _, origin = xDTaraZ:Character()
    if not State.TrainingOrigin and origin then State.TrainingOrigin = origin.CFrame end
    local folder, mult = xDTaraZ.Train.Pick((GameLib.Gym and GameLib.Gym.BenchpressStations or {}), "StrengthMultiplier", chosen or State.Opt.BenchStation)
    State.TrainingPool = nil
    if not folder then return false end
    State.Status = ("Bench press x%d"):format(mult)
    local current = xDTaraZ.Game.Benching()
    if current == folder then return true end
    if current then xDTaraZ:Invoke(GameLib.StopBench) end

    if osClock() - (State.Last.BenchTry or 0) < Config.BenchRetry then return true end
    State.Last.BenchTry = osClock()

    local seat = xDTaraZ.Move.GymPart(folder, GameLib.Gym.BenchpressModelName, GameLib.Gym.AlignPartName)
    if not seat then return false end
    State.TrainingPosition = seat.Position
    if not xDTaraZ.Move.Near(seat.Position, Config.BenchRange) then
        xDTaraZ.Move.To(seat.Position + vector3New(0, Config.StandHeight, 0))
        task.wait(Config.SettleDelay)
    end
    if not State.Alive or State.ActiveEpoch ~= State.WorkEpoch then return false end
    local ok = xDTaraZ:Invoke(GameLib.StartBench, folder)
    if ok == true then return true end
    State.Status = "Bench refused, retrying"
    return false
end

function xDTaraZ.Train.Speed(chosen)
    local _, hum, origin = xDTaraZ:Character()
    if not State.TrainingOrigin and origin then State.TrainingOrigin = origin.CFrame end
    local folder, mult = xDTaraZ.Train.Pick((GameLib.Gym and GameLib.Gym.TreadmillStations or {}), "SpeedMultiplier", chosen or State.Opt.TreadmillStation)
    State.TrainingPool = nil
    local hitbox = folder and xDTaraZ.Move.GymPart(folder, GameLib.Gym.TreadmillModelName, GameLib.Gym.HitboxName)
    if not hitbox then return false end
    State.TrainingPosition = hitbox.Position
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    State.Status = ("Treadmill x%d"):format(mult)
    if not xDTaraZ.Move.Near(hitbox.Position) then xDTaraZ.Move.To(hitbox.Position) end
    if hum then hum:Move(hitbox.CFrame.LookVector, false) end
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
    local str = tonumber(xDTaraZ.Game.Attr("StrengthLevel")) or 0
    if State.Opt.TargetStrength > 0 and str >= State.Opt.TargetStrength then return false end
    return (State.Opt.AutoPool and xDTaraZ.Train.Pool()) or xDTaraZ.Train.Strength()
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
    local origin = State.TrainingOrigin
    State.TrainingOrigin = nil
    if origin and State.Opt.ReturnTraining then
        local _, _, hrp = xDTaraZ:Character()
        if hrp then xDTaraZ.Move.Restore(origin) end
    elseif State.TrainingPool then
        xDTaraZ.Move.Restore(CFrame.new(xDTaraZ.Move.QuarrySpot()))
    elseif State.TrainingPosition then
        local _, _, hrp = xDTaraZ:Character()
        if hrp and (hrp.Position - State.TrainingPosition).Magnitude <= Config.BenchRange then
            hrp.CFrame += vector3New(Config.BenchRange * 2, 0, 0)
        end
    end
    State.TrainingPosition = nil
    State.TrainingPool = nil
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
end

function xDTaraZ.Train.Exit()
    xDTaraZ.Scheduler.Finish({ "AutoStrength", "AutoSpeed", "AutoPool", "TrainWhileWaiting" }, "Training", "stopped")
    xDTaraZ.Train.Leave()
end

function xDTaraZ.Train.Pool()
    if not xDTaraZ.Game.Completed() then return false end
    local spot = xDTaraZ.Move.PoolSpot()
    if not spot then return false end
    local _, _, origin = xDTaraZ:Character()
    if not State.TrainingOrigin and origin then State.TrainingOrigin = origin.CFrame end
    State.TrainingPosition = spot
    State.TrainingPool = true
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    State.Status = "Training in the pool"
    if not xDTaraZ.Move.Near(spot) then xDTaraZ.Move.To(spot) end
    return true
end

xDTaraZ.Pets = { Revision = 0, SessionCount = 0, SessionSpent = 0, NextHatch = 0 }

function xDTaraZ.Pets.Ready()
    return GameLib.EggConfig and GameLib.PetConfig and GameLib.Knit and GameLib.PetHatch
end

function xDTaraZ.Pets.Accept(inventory)
    if not State.Alive or type(inventory) ~= "table" or type(inventory.Owned) ~= "table" then return end
    xDTaraZ.Pets.Inventory = inventory
    xDTaraZ.Pets.Revision += 1
end

function xDTaraZ.Pets.Init()
    if xDTaraZ.Pets.Property then return true end
    if not xDTaraZ.Pets.Ready() then return false, "Pet modules unavailable" end
    if xDTaraZ.Pets.InitFailed then return false, xDTaraZ.Pets.InitFailed end
    local ok, result = xDTaraZ.Util.Deadline("PetInventoryInit", Config.LoadTimeout, function()
        GameLib.Knit.OnStart():await()
        if not State.Alive then return false end
        local prop = GameLib.Knit.GetService("PetService").Inventory
        local conn = prop:Observe(xDTaraZ.Pets.Accept)
        if not State.Alive then
            conn:Disconnect()
            return false
        end
        table.insert(State.Connections, conn)
        xDTaraZ.Pets.Property = prop
        xDTaraZ.Pets.Accept(prop:Get())
        return true
    end)
    if not ok or result ~= true then
        xDTaraZ.Pets.InitFailed = tostring(result or "Inventory unavailable")
        return false, xDTaraZ.Pets.InitFailed
    end
    return true
end

function xDTaraZ.Pets.Begin()
    xDTaraZ.Pets.SessionCount, xDTaraZ.Pets.SessionSpent = 0, 0
    xDTaraZ.Pets.StopReason, xDTaraZ.Pets.LastReply, xDTaraZ.Pets.HatchFailures = nil, nil, 0
    xDTaraZ.Pets.Seen = xDTaraZ.Pets.Inventory and {} or nil
    if xDTaraZ.Pets.Seen then
        for uid in pairs(xDTaraZ.Pets.Inventory.Owned) do xDTaraZ.Pets.Seen[uid] = true end
    end
end

function xDTaraZ.Pets.Stop(reason)
    State.Opt.AutoHatch = false
    xDTaraZ.Pets.StopReason = reason or "Stopped"
    xDTaraZ.Pets.ReturnPending = xDTaraZ.Pets.Origin ~= nil
    xDTaraZ.Pets.SyncToggle = true
end

function xDTaraZ.Pets.Return()
    if not xDTaraZ.Pets.ReturnPending then return false end
    local origin = xDTaraZ.Pets.Origin
    xDTaraZ.Pets.Origin, xDTaraZ.Pets.ReturnPending = nil, false
    if State.Opt.PetReturnOnStop and origin and xDTaraZ:Character() then
        xDTaraZ.Move.To(origin, true)
        return true
    end
    return false
end

function xDTaraZ.Pets.TargetReached()
    local opt = State.Opt
    local cfg = GameLib.PetConfig
    if not cfg then return false end
    local rank = opt.PetStopRarity ~= "None" and cfg.RarityRank[opt.PetStopRarity]
    for uid, owned in pairs(xDTaraZ.Pets.Inventory and xDTaraZ.Pets.Inventory.Owned or {}) do
        if xDTaraZ.Pets.Seen and not xDTaraZ.Pets.Seen[uid] then
            xDTaraZ.Pets.Seen[uid] = true
            local def = cfg.ById[owned.PetId]
            if (opt.PetStopId ~= "None" and owned.PetId == opt.PetStopId)
                or (rank and def and (cfg.RarityRank[def.Rarity] or 0) >= rank) then
                xDTaraZ.Pets.Stop("Pet target reached")
                return true
            end
        end
    end
    return false
end

function xDTaraZ.Pets.Egg()
    local cfg = GameLib.EggConfig
    if not cfg then return nil end
    local curWorld = xDTaraZ.Game.World()
    local egg = cfg.ById[State.Opt.PetEgg]
    if egg and (not egg.World or egg.World == curWorld) then
        return egg
    end
    for _, id in ipairs(cfg.AllOrder or cfg.Order or {}) do
        local candidate = cfg.ById[id]
        if candidate and (candidate.World == curWorld or not candidate.World) then
            State.Opt.PetEgg = id
            return candidate
        end
    end
    return egg
end

function xDTaraZ.Pets.Amount()
    local access = xDTaraZ.Pets.Inventory and xDTaraZ.Pets.Inventory.Access or {}
    if State.Opt.PetHatchAmount == "3" then
        if access.Triple ~= true then return nil, "Triple hatching is not owned" end
        return 3
    end
    return State.Opt.PetHatchAmount == "Best Owned" and access.Triple == true and 3 or 1
end

function xDTaraZ.Pets.Call(key, remote, ...)
    if not remote then return false, "Pet action unavailable" end
    local args = table.pack(...)
    local ok, result, reason = xDTaraZ.Util.Deadline(key, Config.RemoteTimeout, function()
        return remote:InvokeServer(table.unpack(args, 1, args.n))
    end)
    if not ok then return false, result end
    if type(result) == "table" then return result.ok == true, result.reason, result end
    return result == true, reason or result
end

function xDTaraZ.Pets.CanHatch()
    local opt = State.Opt
    local egg, amount = xDTaraZ.Pets.Egg(), xDTaraZ.Pets.Amount()
    if not egg then return nil, nil, nil, "Choose an available egg" end
    if not amount then return nil, nil, nil, "Triple hatching is not owned" end
    local cost = egg.Price * amount
    local count = tonumber(xDTaraZ.Pets.Inventory.OwnedCount) or 0
    if count + amount > GameLib.PetConfig.MaxOwned then return nil, nil, nil, "Pet inventory full" end
    if opt.PetSessionMax > 0 and xDTaraZ.Pets.SessionCount + amount > opt.PetSessionMax then return nil, nil, nil, "Hatch limit reached" end
    if opt.PetHatchBudget > 0 and xDTaraZ.Pets.SessionSpent + cost > opt.PetHatchBudget then return nil, nil, nil, "Hatch budget reached" end
    if egg.Currency == "CandyCorn" then
        if xDTaraZ.Game.CandyCorn() - (opt.PetKeepCandyCorn or 0) < cost then return nil, nil, nil, "Candy Corn reserve reached" end
    else
        if xDTaraZ.Game.Coins() - math.max(opt.KeepCoins or 0, opt.PetKeepCoins or 0) < cost then return nil, nil, nil, "Coin reserve reached" end
    end
    local curWorld = xDTaraZ.Game.World()
    if egg.World and egg.World ~= curWorld then
        return nil, nil, nil, egg.World == "Halloween" and "Requires Halloween World" or "Requires Main World"
    end
    return egg, amount, cost
end

function xDTaraZ.Pets.BuyPart(egg)
    local folder = Workspace:FindFirstChild(GameLib.EggConfig.WorldFolderName)
    local display = folder and folder:FindFirstChild(egg.DisplayModel)
    local buy = display and (display:FindFirstChild("BuyPart", true) or display:FindFirstChildWhichIsA("BasePart", true))
    return buy and buy:IsA("BasePart") and buy or nil
end

function xDTaraZ.Pets.Step(manual)
    local opt = State.Opt
    if xDTaraZ.Pets.ReturnPending then return xDTaraZ.Pets.Return() end
    if not manual and not opt.AutoHatch then return false end
    local ready, reason = xDTaraZ.Pets.Init()
    if not ready then
        xDTaraZ.Pets.Stop(reason)
        return false
    end
    if not xDTaraZ.Pets.Inventory or LocalPlayer:GetAttribute("DataReady") ~= true then return not manual end
    if not xDTaraZ.Pets.Seen then
        xDTaraZ.Pets.Seen = {}
        for uid in pairs(xDTaraZ.Pets.Inventory.Owned) do xDTaraZ.Pets.Seen[uid] = true end
    end
    if xDTaraZ.Pets.TargetReached() then return false end
    if osClock() < xDTaraZ.Pets.NextHatch or State.Inflight.PetHatch then return not manual end

    local egg, amount, cost, err = xDTaraZ.Pets.CanHatch()
    if not egg then
        xDTaraZ.Pets.Stop(err)
        return false
    end
    local buy = xDTaraZ.Pets.BuyPart(egg)
    if not buy then
        xDTaraZ.Pets.Stop("Egg area unavailable")
        return false
    end
    local _, _, root = xDTaraZ:Character()
    if not root then return false end
    if not xDTaraZ.Pets.Origin then xDTaraZ.Pets.Origin = root.Position end
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    if not xDTaraZ.Move.Near(buy.Position, GameLib.EggConfig.MaxHatchDistance) then
        if not xDTaraZ.Move.To(buy.Position + Vector3.new(0, Config.StandHeight, 0), true) then return false end
        task.wait(Config.SettleDelay)
    end
    if not State.Alive or (not manual and not opt.AutoHatch) then return false end
    State.Status = "Hatching " .. egg.DisplayName
    if State.EconomyBusy then return not manual end
    State.EconomyBusy = true
    local ok, reply = xDTaraZ.Pets.Call("PetHatch", GameLib.PetHatch, opt.PetEgg, amount)
    State.EconomyBusy = nil
    if not State.Alive then return false end
    xDTaraZ.Pets.NextHatch = osClock() + math.max(GameLib.EggConfig.HatchCooldownSeconds, 0.5)
    xDTaraZ.Pets.LastReply = tostring(reply or (ok and "Hatched" or "No reply"))
    if ok then
        xDTaraZ.Pets.HatchFailures = 0
        xDTaraZ.Pets.SessionCount += amount
        xDTaraZ.Pets.SessionSpent += cost
        xDTaraZ.Pets.AutoLockCheck()
        xDTaraZ.Pets.AutoDeleteCheck()
        if State.Opt.AutoEquipPets then xDTaraZ.Pets.EquipBestStep(false) end
        if manual then xDTaraZ.Pets.Stop("Hatch completed") end
    elseif reply == "RateLimited" or reply == "TooFar" then
        xDTaraZ.Pets.HatchFailures = (xDTaraZ.Pets.HatchFailures or 0) + 1
        if xDTaraZ.Pets.HatchFailures >= 3 then xDTaraZ.Pets.Stop(xDTaraZ.Pets.LastReply) end
    else
        xDTaraZ.Pets.Stop(xDTaraZ.Pets.LastReply)
    end
    return true
end

function xDTaraZ.Pets.SelectedAction(action)
    if not xDTaraZ.Pets.Init() then return end
    local uid = xDTaraZ.Pets.SelectedUid
    local owned = uid and xDTaraZ.Pets.Inventory and xDTaraZ.Pets.Inventory.Owned[uid]
    if not owned then
        xDTaraZ.Pets.LastReply = "Choose an owned pet"
        return
    end
    local remote = GameLib["Pet" .. action]
    local ok, reason
    if action == "Lock" or action == "Unlock" then
        ok, reason = xDTaraZ.Pets.Call("PetAction", GameLib.PetSetLocked, uid, action == "Lock")
    else
        ok, reason = xDTaraZ.Pets.Call("PetAction", remote, uid)
    end
    xDTaraZ.Pets.LastReply = tostring(reason or (ok and "Pet updated" or "Pet action failed"))
    if ok then xDTaraZ.Pets.EquippedSignature = nil end
end

function xDTaraZ.Pets.UnequipAll()
    if not xDTaraZ.Pets.Init() then return end
    local ok, reason = xDTaraZ.Pets.Call("PetUnequipAll", GameLib.PetUnequipAll)
    xDTaraZ.Pets.LastReply = tostring(reason or (ok and "All pets unequipped" or "Unequip failed"))
    if ok then
        xDTaraZ.Pets.EquippedSignature = nil
        xDTaraZ:Notify("All pets unequipped")
    end
end

function xDTaraZ.Pets.DeletableUids()
    local inv = xDTaraZ.Pets.Inventory
    local cfg = GameLib.PetConfig
    if not (inv and cfg and cfg.ById and cfg.RarityRank) then return {} end
    local filter = State.Opt.AutoDeleteFilter or "Common & Uncommon"
    if filter == "None" then return {} end
    local minRank = cfg.RarityRank.Common or 2
    local maxRank = cfg.RarityRank.Uncommon or 3
    if filter == "Up to Rare" then maxRank = cfg.RarityRank.Rare or 4
    elseif filter == "Up to Epic" then maxRank = cfg.RarityRank.Epic or 5 end

    local equipped = {}
    for _, uid in ipairs(inv.Equipped or {}) do equipped[uid] = true end
    local toDelete = {}
    for uid, pet in pairs(inv.Owned or {}) do
        if equipped[uid] or pet.Locked == true then continue end
        local def = cfg.ById[pet.PetId]
        if not def or def.Rarity == "Exclusive" then continue end
        local rank = cfg.RarityRank[def.Rarity]
        if rank and rank >= minRank and rank <= maxRank then
            table.insert(toDelete, uid)
        end
    end
    return toDelete
end

function xDTaraZ.Pets.DeleteUnlocked()
    if not xDTaraZ.Pets.Init() or not xDTaraZ.Pets.Inventory then return end
    local toDelete = xDTaraZ.Pets.DeletableUids()
    if #toDelete == 0 then
        xDTaraZ:Notify("No unlocked pets matching delete filter")
        return
    end
    local ok, reason = xDTaraZ.Pets.Call("PetDelete", GameLib.PetDelete, toDelete)
    xDTaraZ.Pets.LastReply = tostring(reason or (ok and ("Deleted %d pets"):format(#toDelete) or "Delete failed"))
    if ok then
        xDTaraZ:Notify(("Deleted %d unlocked pets"):format(#toDelete))
        xDTaraZ.Pets.Refresh()
    end
end

function xDTaraZ.Pets.AutoLockCheck()
    if not (State.Opt.AutoLockRares and xDTaraZ.Pets.Inventory) then return end
    local cfg = GameLib.PetConfig
    if not (cfg and cfg.ById and cfg.RarityRank) then return end
    local minRareRank = cfg.RarityRank.Legendary or 6
    local lockedCount = 0
    for uid, pet in pairs(xDTaraZ.Pets.Inventory.Owned or {}) do
        if pet.Locked == true then continue end
        local def = cfg.ById[pet.PetId]
        local rank = def and cfg.RarityRank[def.Rarity] or 0
        if not (def and (def.Rarity == "Exclusive" or rank >= minRareRank)) then continue end
        local ok = xDTaraZ.Pets.Call("PetLockRare", GameLib.PetSetLocked, uid, true)
        if ok then
            pet.Locked = true
            lockedCount += 1
        end
    end
    if lockedCount > 0 then
        xDTaraZ.Pets.Revision += 1
        xDTaraZ:Notify(("Auto-locked %d rare pet(s)!"):format(lockedCount))
    end
end

function xDTaraZ.Pets.AutoDeleteCheck()
    if not State.Opt.AutoDeletePets or not xDTaraZ.Pets.Inventory then return end
    local toDelete = xDTaraZ.Pets.DeletableUids()
    if #toDelete > 0 then
        xDTaraZ.Pets.Call("PetDelete", GameLib.PetDelete, toDelete)
    end
end

function xDTaraZ.Pets.HatchNow()
    if xDTaraZ.Pets.ReturnPending then xDTaraZ.Pets.Return() end
    xDTaraZ.Pets.Begin()
    for _ = 1, 3 do
        if not State.Alive or State.ActiveEpoch ~= State.WorkEpoch then break end
        local left = xDTaraZ.Pets.NextHatch - osClock()
        if left > 0 then task.wait(math.min(left, 1)) end
        xDTaraZ.Pets.Step(true)
        if xDTaraZ.Pets.SessionCount > 0 then return true end
        if xDTaraZ.Pets.LastReply ~= "TooFar" and xDTaraZ.Pets.LastReply ~= "RateLimited" then break end
    end
    xDTaraZ.Pets.Stop(xDTaraZ.Pets.StopReason or xDTaraZ.Pets.LastReply or "Hatch cancelled")
    return false
end

function xDTaraZ.Pets.EquipBestStep(manual)
    if not manual and not State.Opt.AutoEquipPets then return end
    if not xDTaraZ.Pets.Init() or not xDTaraZ.Pets.Inventory then return end
    if State.Inflight.PetEquipBest then return end
    local ok, reason = xDTaraZ.Pets.Call("PetEquipBest", GameLib.PetEquipBest)
    if ok then
        xDTaraZ.Pets.EquippedSignature = nil
        if manual then xDTaraZ:Notify("Best pets equipped!") end
    else
        if manual then xDTaraZ:Notify("Equip failed: " .. tostring(reason)) end
    end
    xDTaraZ.Pets.LastReply = tostring(reason or (ok and "Best pets equipped" or "Equip failed"))
end

function xDTaraZ.Pets.Status()
    local inv = xDTaraZ.Pets.Inventory
    if not inv then return xDTaraZ.Pets.StopReason or "Inventory not loaded" end
    return string.format("Pets %d/%d | Equipped %d/%d | Coins x%.2f\nSession %d eggs | %d spent\n%s",
        tonumber(inv.OwnedCount) or 0, GameLib.PetConfig.MaxOwned, #(inv.Equipped or {}),
        tonumber(inv.Access and inv.Access.Slots) or 0, tonumber(inv.Boosts and inv.Boosts.Coins) or 1,
        xDTaraZ.Pets.SessionCount, xDTaraZ.Pets.SessionSpent, xDTaraZ.Pets.StopReason or xDTaraZ.Pets.LastReply or "Ready")
end

local function BuildHatchSettings(tab, T, opt, Queue, Library)
    local hatch = tab:AddLeftGroupbox(T("Hatching", "เปิดไข่"), "star")
    local rules = tab:AddRightGroupbox(T("Hatch Limits", "เงื่อนไขเปิดไข่"), "coin")
    local function Number(key, text)
        rules:AddInput(key, { Text = text, Default = tostring(opt[key] or 0), Numeric = true, Finished = true,
            Callback = function(value)
                local n = tonumber(value)
                opt[key] = n and n == n and n < math.huge and math.max(0, math.floor(n)) or 0
            end,
        })
    end
    local cfg, presentation = GameLib.EggConfig, GameLib.PetPresentation or {}
    local eggValues, eggIds, eggImages, eggColors = {}, {}, {}, {}
    for _, id in ipairs(cfg and (cfg.AllOrder or cfg.Order) or {}) do
        local egg = cfg.ById[id]
        if egg then
            local currency = egg.Currency or "coins"
            local label = egg.DisplayName .. " | " .. tostring(egg.Price) .. " " .. currency:lower()
            eggValues[#eggValues + 1], eggIds[label] = label, id
            eggImages[label] = presentation.EggIcons and presentation.EggIcons[id]
            local highest = 0
            for _, loot in ipairs(egg.Loot or {}) do
                local def = GameLib.PetConfig and GameLib.PetConfig.ById[loot.PetId]
                local rank = def and GameLib.PetConfig.RarityRank[def.Rarity] or 0
                if rank > highest then
                    highest = rank
                    eggColors[label] = presentation.RarityColors and presentation.RarityColors[def.Rarity]
                end
            end
        end
    end
    hatch:AddDropdown("PetEgg", { Text = T("Egg", "ไข่"), Values = eggValues, Default = 1,
        Images = eggImages, Colors = eggColors, Callback = function(value) opt.PetEgg = eggIds[value] end,
    })
    hatch:AddDropdown("PetHatchAmount", { Text = T("Eggs Per Hatch", "จำนวนไข่ต่อครั้ง"),
        Values = { "Best Owned", "1", "3" }, Default = 1, Callback = function(value) opt.PetHatchAmount = value or "Best Owned" end,
    })
    hatch:AddToggle("AutoHatch", { Text = T("Auto Hatch", "เปิดไข่อัตโนมัติ"), Default = false,
        Description = T("Uses coins/candy corn. Pauses farming while hatching.", "ใช้เหรียญ/แคนดี้คอร์น หยุดฟาร์มชั่วคราวระหว่างเปิดไข่"),
        Callback = function(value)
            if value and not xDTaraZ.Pets.Ready() then
                xDTaraZ:Notify(T("Pet modules unavailable", "ระบบสัตว์เลี้ยงยังไม่พร้อม"))
                task.defer(function() Library.Toggles.AutoHatch:SetValue(false) end)
                return
            end
            opt.AutoHatch = value == true
            if value then
                xDTaraZ.Pets.Begin()
                xDTaraZ.Scheduler.Resume("AutoHatch")
            else
                xDTaraZ.Pets.Stop(xDTaraZ.Pets.StopReason or "Stopped")
                State.WorkEpoch += 1
            end
        end,
    })
    hatch:AddButton({ Text = T("Hatch Now", "เปิดไข่เดี๋ยวนี้"), Func = Queue("PetsNow") })
    hatch:AddButton({ Text = T("Stop Hatching", "หยุดเปิดไข่"), Func = Queue("PetsStop") })
    Number("PetKeepCoins", T("Keep Coins", "สำรองเหรียญ"))
    Number("PetKeepCandyCorn", T("Keep Candy Corn", "สำรองแคนดี้คอร์น"))
    Number("PetHatchBudget", T("Session Currency Budget (0 = unlimited)", "งบต่อรอบ (0 = ไม่จำกัด)"))
    Number("PetSessionMax", T("Session Egg Limit (0 = unlimited)", "จำนวนไข่สูงสุดต่อรอบ (0 = ไม่จำกัด)"))
    local rarities = { "None" }
    for _, rarity in ipairs(GameLib.PetConfig and GameLib.PetConfig.RarityOrder or {}) do rarities[#rarities + 1] = rarity end
    rules:AddDropdown("PetStopRarity", { Text = T("Stop At Rarity Or Better", "หยุดเมื่อได้ระดับนี้ขึ้นไป"),
        Values = rarities, Default = 1, Colors = presentation.RarityColors,
        Callback = function(value) opt.PetStopRarity = value or "None" end,
    })
    local petValues, petIds, petImages, petColors = { "None" }, { None = "None" }, {}, {}
    local petOrder = {}
    if GameLib.PetConfig then
        if GameLib.PetConfig.Order then for _, id in ipairs(GameLib.PetConfig.Order) do table.insert(petOrder, id) end end
        for id in pairs(GameLib.PetConfig.ById or {}) do
            if not table.find(petOrder, id) then table.insert(petOrder, id) end
        end
    end
    for _, id in ipairs(petOrder) do
        local def = GameLib.PetConfig.ById[id]
        if def then
            local label = def.DisplayName .. " | " .. tostring(def.Rarity)
            petValues[#petValues + 1], petIds[label] = label, id
            petImages[label] = presentation.Icons and presentation.Icons[id]
            petColors[label] = presentation.RarityColors and presentation.RarityColors[def.Rarity]
        end
    end
    rules:AddDropdown("PetStopId", { Text = T("Stop At Pet", "หยุดเมื่อได้ตัวนี้"), Values = petValues,
        Default = 1, Images = petImages, Colors = petColors,
        Callback = function(value) opt.PetStopId = petIds[value] or "None" end,
    })
    rules:AddToggle("PetReturnOnStop", { Text = T("Return When Finished", "กลับจุดเดิมเมื่อเสร็จ"), Default = false,
        Callback = function(value) opt.PetReturnOnStop = value == true end,
    })
end

local function BuildTeamSettings(tab, T, opt, Queue)
    local team = tab:AddLeftGroupbox(T("Pet Team", "ทีมสัตว์เลี้ยง"), "mushroom")
    local ownedBox = tab:AddRightGroupbox(T("Owned Pets", "สัตว์เลี้ยงในกระเป๋า"), "star")
    local info = tab:AddLeftGroupbox(T("Pet Status", "สถานะสัตว์เลี้ยง"), "info")
    team:AddToggle("AutoEquipPets", { Text = T("Auto Equip Best", "ใส่ตัวที่ดีที่สุดอัตโนมัติ"), Default = false,
        Callback = function(value) opt.AutoEquipPets = value == true end,
    })
    team:AddToggle("AutoLockRares", { Text = T("Auto Lock Rares", "ล็อกสัตว์หายากอัตโนมัติ"), Default = false,
        Description = T("Automatically locks Legendary, Mythic, Secret and Exclusive pets", "ล็อกสัตว์ระดับ Legendary, Mythic, Secret และ Exclusive อัตโนมัติ"),
        Callback = function(value) opt.AutoLockRares = value == true end,
    })
    team:AddToggle("AutoDeletePets", { Text = T("Auto Delete Pets", "ลบสัตว์เลี้ยงอัตโนมัติ"), Default = false,
        Description = T("Deletes unlocked junk pets based on filter", "ลบสัตว์เลี้ยงที่ไม่ล็อกตามเงื่อนไขที่เลือก"),
        Callback = function(value) opt.AutoDeletePets = value == true end,
    })
    team:AddDropdown("AutoDeleteFilter", { Text = T("Delete Filter", "ระดับที่ลบ"),
        Values = { "Common & Uncommon", "Up to Rare", "Up to Epic", "None" }, Default = 1,
        Callback = function(value) opt.AutoDeleteFilter = value or "Common & Uncommon" end,
    })
    team:AddButton({ Text = T("Equip Best Now", "ใส่ตัวดีที่สุดเดี๋ยวนี้"), Func = Queue("PetsBestNow") })
    team:AddButton({ Text = T("Unequip All Pets", "ถอดสัตว์เลี้ยงทั้งหมด"), Func = Queue("PetUnequipAllNow") })
    team:AddButton({ Text = T("Delete Filtered Pets", "ลบสัตว์ตามตัวกรองทันที"), Func = Queue("PetDeleteUnlockedNow") })
    team:AddButton({ Text = T("Refresh Inventory", "รีเฟรชกระเป๋า"), Func = Queue("PetsRefresh") })
    xDTaraZ.Pets.StatusLabel = info:AddLabel(xDTaraZ.Pets.Status())
    xDTaraZ.Pets.OwnedDropdown = ownedBox:AddDropdown("PetOwned", { Text = T("Owned Pet", "สัตว์เลี้ยงในกระเป๋า"),
        Values = {}, Callback = function(value) xDTaraZ.Pets.SelectedUid = xDTaraZ.Pets.OwnedIds and xDTaraZ.Pets.OwnedIds[value] end,
    })
    ownedBox:AddButton({ Text = T("Equip Selected", "ใส่ตัวที่เลือก"), Func = Queue("PetEquipNow") })
    ownedBox:AddButton({ Text = T("Unequip Selected", "ถอดตัวที่เลือก"), Func = Queue("PetUnequipNow") })
    ownedBox:AddButton({ Text = T("Lock Selected", "ล็อกตัวที่เลือก"), Func = Queue("PetLockNow") })
    ownedBox:AddButton({ Text = T("Unlock Selected", "ปลดล็อกตัวที่เลือก"), Func = Queue("PetUnlockNow") })
end

function xDTaraZ.Pets.Build(window, T, Library)
    local opt = State.Opt
    local tab = window:AddTab(T("Pets & Eggs", "สัตว์เลี้ยงและไข่"), "star", T("Hatch eggs and manage your pet team", "เปิดไข่และจัดทีมสัตว์เลี้ยง"))
    local Queue = xDTaraZ.Scheduler.Action
    BuildHatchSettings(tab, T, opt, Queue, Library)
    BuildTeamSettings(tab, T, opt, Queue)
    xDTaraZ.Pets.UIRevision = -1
end

function xDTaraZ.Pets.Refresh()
    if not xDTaraZ.Pets.Init() then return end
    local ok, result = xDTaraZ.Util.Deadline("PetInventoryRead", Config.RemoteTimeout, function() return xDTaraZ.Pets.Property:Get() end)
    if ok then xDTaraZ.Pets.Accept(result) end
end

function xDTaraZ.Pets.Pump(Library)
    if xDTaraZ.Pets.SyncToggle then
        xDTaraZ.Pets.SyncToggle = false
        if Library.Toggles.AutoHatch and Library.Toggles.AutoHatch.Value then Library.Toggles.AutoHatch:SetValue(false) end
    end
    if xDTaraZ.Pets.StatusLabel then xDTaraZ.Pets.StatusLabel:SetText(xDTaraZ.Pets.Status()) end
    if not xDTaraZ.Pets.OwnedDropdown or xDTaraZ.Pets.UIRevision == xDTaraZ.Pets.Revision then return end
    xDTaraZ.Pets.UIRevision = xDTaraZ.Pets.Revision
    local values, ids, images, colors = {}, {}, {}, {}
    local cfg, presentation = GameLib.PetConfig, GameLib.PetPresentation or {}
    for uid, owned in pairs(xDTaraZ.Pets.Inventory and xDTaraZ.Pets.Inventory.Owned or {}) do
        local def = cfg and cfg.ById[owned.PetId]
        if def then
            local label = def.DisplayName .. " | " .. def.Rarity .. " | " .. tostring(uid)
            values[#values + 1], ids[label] = label, uid
            images[label] = presentation.Icons and presentation.Icons[owned.PetId]
            colors[label] = presentation.RarityColors and presentation.RarityColors[def.Rarity]
        end
    end
    table.sort(values)
    xDTaraZ.Pets.OwnedIds = ids
    xDTaraZ.Pets.OwnedDropdown:SetValues(values)
    if xDTaraZ.Pets.OwnedDropdown.SetImages then xDTaraZ.Pets.OwnedDropdown:SetImages(images, colors) end
end

xDTaraZ.Tasks = {}

function xDTaraZ.Tasks.Order()
    local opt = State.Opt
    local order = { "Pets" }
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
    Pets = { On = function() return State.Opt.AutoHatch or xDTaraZ.Pets.ReturnPending end, Step = function() return xDTaraZ.Pets.Step(false) end },
    Pool = { On = function() return State.Opt.AutoPool end, Step = xDTaraZ.Train.Pool },
    Farm = { On = xDTaraZ.Farm.Enabled, Step = xDTaraZ.Farm.Step },
    Train = {
        On = function()
            local opt = State.Opt
            return opt.AutoStrength or opt.AutoSpeed or (opt.TrainWhileWaiting and opt.AutoFarm)
        end,
        Step = xDTaraZ.Train.Step,
    },
}

function xDTaraZ.Tasks.Step()
    if State.Opt.AutoProgression or State.ProgressionCleanup then
        local ok, result = pcall(xDTaraZ.Progression.Step)
        if not ok then
            xDTaraZ.Progression.Stop("Controller error")
            xDTaraZ.Scheduler.Fail("Progression", result)
        else
            State.Fails.Progression, State.FailSince.Progression = nil, nil
        end
        State.Task = "Progression"
        return
    end
    for _, name in ipairs(xDTaraZ.Tasks.Order()) do
        if not State.Alive then return end
        local job = xDTaraZ.Tasks.Jobs[name]
        if not job.On() or State.Halted[name] then continue end
        local ok, worked = pcall(job.Step)
        if not State.Alive then return end
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

function xDTaraZ.Upgrade.CostFor(upgrade, currency)
    if not State.Opt.Upgrades[upgrade.DisplayName] then return nil end
    local level = xDTaraZ.Game.UpgradeLevel(upgrade)
    local cap = State.Opt.UpgradeMax[upgrade.DisplayName] or 0
    if cap > 0 and level >= cap then return nil end
    if GameLib.UpgradeLevels and type(GameLib.UpgradeLevels.costToNext) == "function" then
        return GameLib.UpgradeLevels.costToNext(upgrade.Id, level, currency)
    end
    local base = upgrade.Costs[level + 1]
    if not base then return nil end
    if currency == "CandyCorn" then
        local ratio = GameLib.Upgrades and GameLib.Upgrades.CandyCornRatio or 2
        return math.max(1, math.floor(base * ratio + 0.5))
    end
    return base
end

function xDTaraZ.Upgrade.ResolveCurrency()
    local isHalloween = xDTaraZ.Game.World() == "Halloween"
    local pref = State.Opt.UpgradeCurrency or "Auto"
    if pref == "Candy Corn" and isHalloween then return "CandyCorn" end
    if pref == "Coins" or not isHalloween then return "Coins" end
    local candyBudget = xDTaraZ.Game.CandyCorn() - (State.Opt.PetKeepCandyCorn or 0)
    if candyBudget > 0 then return "CandyCorn" end
    return "Coins"
end

function xDTaraZ.Upgrade.BudgetFor(currency, extraReserve)
    if currency == "CandyCorn" then
        return xDTaraZ.Game.CandyCorn() - (State.Opt.PetKeepCandyCorn or 0)
    end
    return xDTaraZ.Game.Coins() - math.max(State.Opt.KeepCoins or 0, extraReserve or 0)
end

---@return number?  cost of the next level, nil when it is not selected, maxed or capped by its Max Level
function xDTaraZ.Upgrade.NextCost(upgrade, currency)
    return xDTaraZ.Upgrade.CostFor(upgrade, currency or "Coins")
end

---@return number  measured coins/s gained per coin spent; untried upgrades rank first, cheapest first
function xDTaraZ.Upgrade.Score(upgrade, cost)
    if upgrade.Id == "placementRange" and GameLib.PlacementRange then
        local reach = GameLib.PlacementRange.forPlayer(LocalPlayer, GameLib.Pyramid.PlaceDistance)
        if State.Opt.PlaceReach + Config.HoverHeight <= reach then return 0 end
    end
    local gain = State.UpgradeGain[upgrade.Id]
    if gain then return math.max(gain, 0) / cost end
    local sample = State.LastFarmSample
    if sample and sample.seconds > 0 and (upgrade.Id == "bulkPickup" or upgrade.Id == "bulkPlace") then
        local grant = upgrade.Id == "bulkPickup" and sample.pickup or sample.placement
        local elapsed = upgrade.Id == "bulkPickup" and sample.gather or sample.place
        local calls = math.max(math.ceil(sample.cap / grant), 1)
        local reduced = calls - math.ceil(sample.cap / (grant + 1))
        if reduced <= 0 then return 0 end
        local saved = elapsed * reduced / calls
        local seconds = math.max(sample.seconds - saved, Config.TickDelay)
        return math.max((State.CoinRate or 0) * saved / seconds, 0) / cost
    end
    return Config.UnmeasuredGain / cost
end

function xDTaraZ.Upgrade.Probe(upgrade)
    if State.ManualUpgrades or State.UpgradeProbe then return end
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

---@param budget number  currency free to spend
---@param currency string  "Coins" or "CandyCorn"
---@param order string?  "Best Value", "In Order", or "Cheapest"
---@return table?, number?, string?  evaluated upgrade, cost, and currency
function xDTaraZ.Upgrade.Evaluate(budget, currency, order)
    local best, bestCost, bestScore
    local afford, affordCost, affordScore
    local cheap, cheapCost

    for _, name in ipairs(xDTaraZ.UpgradeNames) do
        local upgrade = xDTaraZ.UpgradeByName[name]
        local cost = xDTaraZ.Upgrade.NextCost(upgrade, currency)
        if not cost then continue end
        if order == "In Order" and cost <= budget then
            return upgrade, cost, currency
        end
        if cost <= budget and (not cheapCost or cost < cheapCost) then
            cheap, cheapCost = upgrade, cost
        end
        if order == "Best Value" then
            local baseCost = xDTaraZ.Upgrade.NextCost(upgrade, "Coins") or cost
            local score = xDTaraZ.Upgrade.Score(upgrade, baseCost)
            if score > 0 then
                if not bestScore or score > bestScore then best, bestCost, bestScore = upgrade, cost, score end
                if cost <= budget and (not affordScore or score > affordScore) then
                    afford, affordCost, affordScore = upgrade, cost, score
                end
            end
        end
    end

    if order ~= "Best Value" then return cheap, cheapCost, currency end
    if not best then return nil end
    if bestCost <= budget then return best, bestCost, currency end
    if currency ~= "CandyCorn" then
        local income = State.CoinRate or 0
        if income > 0 and (bestCost - budget) / income <= Config.SaveSeconds then return nil end
    end
    if afford then return afford, affordCost, currency end
    return nil
end

function xDTaraZ.Upgrade.PickByValue(budget, currency)
    return xDTaraZ.Upgrade.Evaluate(budget, currency, "Best Value")
end

---@return table?, number?, string?  wanted upgrade to buy next by the chosen order, its cost, and currency
function xDTaraZ.Upgrade.Pick()
    local primary = xDTaraZ.Upgrade.ResolveCurrency()
    local currencies = { primary }
    if (State.Opt.UpgradeCurrency or "Auto") == "Auto" and primary == "CandyCorn" then
        currencies[2] = "Coins"
    end
    local order = State.Opt.UpgradeOrder or "Best Value"
    for _, currency in ipairs(currencies) do
        local budget = xDTaraZ.Upgrade.BudgetFor(currency)
        if budget > 0 then
            local up, cost = xDTaraZ.Upgrade.Evaluate(budget, currency, order)
            if up then return up, cost, currency end
        end
    end
    return nil
end

---@param loud boolean?  tell the player why the server refused
---@return boolean       the level went up or currency was taken
function xDTaraZ.Upgrade.Buy(upgrade, loud, chosenCurrency)
    local level, coins, candy = xDTaraZ.Game.UpgradeLevel(upgrade), xDTaraZ.Game.Coins(), xDTaraZ.Game.CandyCorn()
    local currency = chosenCurrency or xDTaraZ.Upgrade.ResolveCurrency()
    local reply = xDTaraZ:Invoke(GameLib.Purchase, upgrade.Id, currency)
    if not State.Alive then return false end
    if not (type(reply) == "table" and reply.ok == true) then
        if loud then
            xDTaraZ:Notify(("%s: %s"):format(upgrade.DisplayName, type(reply) == "table" and tostring(reply.reason) or "no reply"))
        end
        return false
    end

    local function Confirmed()
        return xDTaraZ.Game.UpgradeLevel(upgrade) > level or xDTaraZ.Game.Coins() < coins or xDTaraZ.Game.CandyCorn() < candy
    end
    local deadline = osClock() + Config.ConfirmTimeout
    repeat task.wait() until not State.Alive or Confirmed() or osClock() > deadline
    if not State.Alive then return false end
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
    if State.EconomyBusy or State.Inflight.PetHatch then return end
    State.EconomyBusy = true
    local ok, err = pcall(buy)
    State.EconomyBusy = nil
    if not ok then error(err, 0) end
end

function xDTaraZ.Upgrade.Step()
    if State.UpgradeProbe then
        xDTaraZ.Upgrade.Measure()
        if State.UpgradeProbe then return end
    end
    xDTaraZ.Upgrade.Exclusive(function()
        local upgrade, _, currency = xDTaraZ.Upgrade.Pick()
        if upgrade then xDTaraZ.Upgrade.Buy(upgrade, false, currency) end
    end)
end

function xDTaraZ.Upgrade.Now()
    State.UpgradeProbe = nil
    State.ManualUpgrades = true
    xDTaraZ.Upgrade.Exclusive(function()
        local bought = 0
        repeat
            local upgrade, _, currency = xDTaraZ.Upgrade.Pick()
            if not (upgrade and State.Alive and xDTaraZ.Upgrade.Buy(upgrade, true, currency)) then break end
            bought += 1
            task.wait(Config.UpgradeGap)
        until bought >= Config.UpgradeBurst
        if bought == 0 then xDTaraZ:Notify("Nothing to buy") end
    end)
    State.ManualUpgrades = nil
end

xDTaraZ.Codes = {}

function xDTaraZ.Codes.RedeemAll()
    local tally, order = {}, {}
    for _, code in ipairs(xDTaraZ.CodeList) do
        if not State.Alive then break end
        if State.CodeDone[code] then continue end

        local reply = xDTaraZ:Invoke(GameLib.Redeem, code)
        if not State.Alive then return end
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
function xDTaraZ.Bank.Spend(remote, attr, label, reserve)
    local before = tonumber(xDTaraZ.Game.Attr(attr)) or 0
    local refused = State.BankRefused[attr]
    if before <= 0 or before <= (reserve or 0) then return false end
    if type(refused) == "table" and refused.balance == before and osClock() < refused.retryAt then return false end

    local ok, reason = xDTaraZ:Invoke(remote)
    if not State.Alive then return false end
    if ok ~= true then
        State.BankRefused[attr] = { balance = before, retryAt = osClock() + Config.BankInterval }
        xDTaraZ:Notify(("Could not spend %s: %s"):format(label, tostring(reason or "no reply")))
        return false
    end

    State.BankRefused[attr] = nil
    task.wait(Config.BankSettle)
    if not State.Alive then return false end
    local left = tonumber(xDTaraZ.Game.Attr(attr)) or 0
    xDTaraZ:Notify(("Spent %s %s"):format(xDTaraZ.Format(before - left), label))
    return true
end

function xDTaraZ.Bank.Auto()
    if State.Opt.SpendBlocks and GameLib.Runtime and GameLib.Runtime.getCurrentLayer(Workspace) then
        xDTaraZ.Bank.Spend(GameLib.SpendBlocks, "BankedBlocks", "banked blocks", State.Opt.KeepBlocks)
    end
    if State.Alive and State.Opt.SpendSeconds and xDTaraZ.Game.Completed() then
        xDTaraZ.Bank.Spend(GameLib.SpendSeconds, "BankedSeconds", "banked pool seconds", State.Opt.KeepSeconds)
    end
end

function xDTaraZ.Bank.BlocksNow()
    State.BankRefused.BankedBlocks = nil
    xDTaraZ.Bank.Spend(GameLib.SpendBlocks, "BankedBlocks", "banked blocks", State.Opt.KeepBlocks)
end

function xDTaraZ.Bank.SecondsNow()
    State.BankRefused.BankedSeconds = nil
    xDTaraZ.Bank.Spend(GameLib.SpendSeconds, "BankedSeconds", "banked pool seconds", State.Opt.KeepSeconds)
end

xDTaraZ.Gift = {}

---@param manual boolean?  pressed by the player; reports every outcome
function xDTaraZ.Gift.Claim(manual)
    local state = xDTaraZ:Invoke(GameLib.GiftState)
    if not State.Alive then return end
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
        if not State.Alive then return end
        if not state[step] then xDTaraZ:Invoke(GameLib.GiftStep, step) end
    end
    local reply, reason = xDTaraZ:Invoke(GameLib.GiftClaim)
    if not State.Alive then return end
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

function xDTaraZ.Tasks.BuyJack()
    local jackCfg = GameLib.JackConfig
    local charId = jackCfg and (jackCfg.ProductKey or jackCfg.CharacterId) or "jack"
    local passAttr = jackCfg and jackCfg.OwnsPassAttribute or ("OwnsPass_" .. charId)
    local price = jackCfg and jackCfg.Price or 50000000
    local owns = LocalPlayer:GetAttribute(passAttr) == true
    if owns then
        local equipped = LocalPlayer:GetAttribute("EquippedCharacter")
        if equipped ~= charId and GameLib.EquipCharacter then
            local ok = xDTaraZ:Invoke(GameLib.EquipCharacter, charId)
            if ok then
                xDTaraZ:Notify("Jack equipped!")
                return true
            end
        else
            xDTaraZ:Notify("Jack is already owned and equipped!")
            return true
        end
    end
    local candy = xDTaraZ.Game.CandyCorn()
    if candy < price then
        xDTaraZ:Notify(("Need %s Candy Corn for Jack (have %s)"):format(xDTaraZ.Format(price), xDTaraZ.Format(candy)))
        return false
    end
    if GameLib.ShopPurchase then
        local ok, reply = xDTaraZ:Invoke(GameLib.ShopPurchase, charId)
        if ok == true or (type(reply) == "table" and reply.ok) then
            xDTaraZ:Notify("Jack purchased!")
            if GameLib.EquipCharacter then
                task.wait(0.5)
                xDTaraZ:Invoke(GameLib.EquipCharacter, charId)
            end
            return true
        end
    end
    local jackArea = Workspace:FindFirstChild("JackArea")
    local prompt = jackArea and jackArea:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt and typeof(fireproximityprompt) == "function" then
        fireproximityprompt(prompt)
        xDTaraZ:Notify("Interacted with Jack NPC!")
        return true
    end
    xDTaraZ:Notify("Purchase failed: could not buy Jack")
    return false
end

function xDTaraZ.Tasks.AutoJack()
    if not State.Opt.AutoBuyJack then return end
    local jackCfg = GameLib.JackConfig
    local charId = jackCfg and (jackCfg.ProductKey or jackCfg.CharacterId) or "jack"
    local passAttr = jackCfg and jackCfg.OwnsPassAttribute or ("OwnsPass_" .. charId)
    local price = jackCfg and jackCfg.Price or 50000000
    local owns = LocalPlayer:GetAttribute(passAttr) == true
    if not owns then
        if xDTaraZ.Game.CandyCorn() >= price then
            xDTaraZ.Tasks.BuyJack()
        end
    elseif LocalPlayer:GetAttribute("EquippedCharacter") ~= charId and GameLib.EquipCharacter then
        xDTaraZ:Invoke(GameLib.EquipCharacter, charId)
    end
end

function xDTaraZ.Tasks.SignUpEvent()
    local es = Workspace:FindFirstChild("EventSign")
    local prompt = es and es:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt and typeof(fireproximityprompt) == "function" then
        fireproximityprompt(prompt)
        xDTaraZ:Notify("Signed up for event!")
        return true
    end
    local service = GameLib.Knit and GameLib.Knit.GetService and GameLib.Knit.GetService("EventSignupService")
    local rf = service and service.ReservePrompt
    if rf then
        local ok = pcall(function() return rf:InvokeServer() end)
        if ok then
            xDTaraZ:Notify("Signed up for event!")
            return true
        end
    end
    xDTaraZ:Notify("Event sign prompt not found")
    return false
end

xDTaraZ.Boost = {}

function xDTaraZ.Boost.Read()
    local state = xDTaraZ:Invoke(GameLib.BoostState)
    if not State.Alive then return end
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

xDTaraZ.Cutscene = {}

---@return boolean  uses the native cleanup to release camera, HUD and movement locks
function xDTaraZ.Cutscene.Skip(manual)
    local controller = GameLib.Cinematic
    if not controller or type(controller.Stop) ~= "function" then
        if manual then xDTaraZ:Notify("Cutscene controller unavailable") end
        return false
    end
    if controller._playing ~= true then
        if manual then xDTaraZ:Notify("No active completion cutscene") end
        return false
    end
    local freeze = State.CameraFreeze
    if freeze and freeze.Object == Workspace.CurrentCamera and controller._savedCameraType == Enum.CameraType.Scriptable then
        controller._savedCameraType = freeze.Type
    end
    controller:Stop()
    local stopped = controller._playing ~= true
    if stopped then State.CutscenesSkipped = (State.CutscenesSkipped or 0) + 1 end
    if manual then xDTaraZ:Notify(stopped and "Cutscene skipped" or "Cutscene is still active") end
    return stopped
end

function xDTaraZ.Cutscene.SetAutoSkip(enabled)
    State.Opt.AutoSkipCutscene = enabled == true
    if enabled then xDTaraZ.Cutscene.Skip(false) end
    if GameLib.SettingsSet then
        task.spawn(function()
            pcall(GameLib.SettingsSet.InvokeServer, GameLib.SettingsSet, "skipPyramidCutscene", enabled == true)
        end)
    end
end

function xDTaraZ.Cutscene.Now()
    return xDTaraZ.Cutscene.Skip(true)
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

function xDTaraZ.Teleport.SunGod()
    local spot = xDTaraZ.Move.SunGodSpot()
    if not spot then
        xDTaraZ:Notify("Sun God shrine not found")
        return
    end
    xDTaraZ.Move.To(spot, true)
end

function xDTaraZ.Teleport.EventSign()
    local spot = xDTaraZ.Move.EventSignSpot()
    if not spot then
        xDTaraZ:Notify("Event sign not found")
        return
    end
    xDTaraZ.Move.To(spot, true)
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
    if not State.Alive then return end
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

xDTaraZ.Progression = { Stage = "Idle", Failures = 0 }

for key, value in pairs({ AutoProgression = false, ProgressionUpgrades = false, ProgressionWaitTrain = false,
    ProgressionCoins = 0, ProgressionPyramids = 0, ProgressionStrength = 0, ProgressionSpeed = 0,
    ProgressionReserve = 0, ProgressionMinutes = 0 }) do
    if State.Opt[key] == nil then State.Opt[key] = value end
end

function xDTaraZ.Progression.Ready()
    return xDTaraZ.Gate.Ready("AutoFarm") and xDTaraZ.Gate.Ready("AutoStrength")
        and xDTaraZ.Gate.Ready("AutoSpeed") and GameLib.Gym ~= nil
end

function xDTaraZ.Progression.Start()
    local self = xDTaraZ.Progression
    if not self.Ready() then
        self.Stage = "Game modules unavailable"
        return false
    end
    self.Started, self.Failures, self.LastUpgrade = osClock(), 0, 0
    self.SyncToggle = false
    self.Stage, self.WaitingLevel, self.ProbeEnd = "Starting", nil, nil
    State.ProgressionCleanup = false
    return true
end

function xDTaraZ.Progression.Stop(reason)
    local self = xDTaraZ.Progression
    State.Opt.AutoProgression = false
    State.ProgressionFarm = false
    State.ProgressionCleanup = State.ProgressionTraining == true
    self.Started, self.WaitingLevel = nil, nil
    self.Stage, self.SyncToggle = reason or "Stopped", true
end

function xDTaraZ.Progression.Cleanup()
    State.ProgressionFarm = false
    if State.ProgressionTraining then xDTaraZ.Train.Leave() end
    State.ProgressionTraining, State.ProgressionCleanup = false, false
end

function xDTaraZ.Progression.Goals()
    local opt = State.Opt
    local strength = tonumber(xDTaraZ.Game.Attr("StrengthLevel")) or 0
    local speed = tonumber(xDTaraZ.Game.Attr("SpeedLevel")) or 0
    local pyramids = tonumber(xDTaraZ.Game.Attr("Pyramids")) or 0
    local hasGoal = opt.ProgressionCoins > 0 or opt.ProgressionPyramids > 0
        or opt.ProgressionStrength > 0 or opt.ProgressionSpeed > 0
    local needStrength = opt.ProgressionStrength > 0 and strength < opt.ProgressionStrength
    local needSpeed = opt.ProgressionSpeed > 0 and speed < opt.ProgressionSpeed
    local done = hasGoal and not needStrength and not needSpeed
        and (opt.ProgressionCoins <= 0 or xDTaraZ.Game.Coins() >= opt.ProgressionCoins)
        and (opt.ProgressionPyramids <= 0 or pyramids >= opt.ProgressionPyramids)
    return done, needStrength, needSpeed
end

function xDTaraZ.Progression.Select()
    local self, opt = xDTaraZ.Progression, State.Opt
    local done, needStrength, needSpeed = self.Goals()
    if done then return "Targets reached" end
    if self.Started and opt.ProgressionMinutes > 0 and osClock() - self.Started >= opt.ProgressionMinutes * 60 then
        return "Session limit reached"
    end
    if needStrength then return "Strength" end
    if needSpeed then return "Speed" end
    local waiting = not GameLib.Runtime.getCurrentLayer(Workspace)
    if waiting then
        if not opt.ProgressionWaitTrain then return "Waiting" end
        return "Wait Strength"
    end
    self.WaitingLevel = nil
    if opt.ProgressionStrength == 0 and State.LastFarmSample and not State.BenchRate
        and (not self.ProbeEnd or osClock() < self.ProbeEnd) then return "Measure Strength" end
    if opt.ProgressionStrength == 0 and State.BenchRate and State.LastFarmSample and xDTaraZ.Train.Worth() then
        return "Smart Strength"
    end
    return "Farm"
end

function xDTaraZ.Progression.Upgrade()
    local self, opt = xDTaraZ.Progression, State.Opt
    if not opt.ProgressionUpgrades or not xDTaraZ.Gate.Ready("AutoUpgrade")
        or osClock() - self.LastUpgrade < Config.UpgradeInterval or State.UpgradeProbe then return end
    self.LastUpgrade = osClock()
    local currency = xDTaraZ.Upgrade.ResolveCurrency()
    local budget = xDTaraZ.Upgrade.BudgetFor(currency, opt.ProgressionReserve)
    if budget <= 0 then return end
    local upgrade, cost = xDTaraZ.Upgrade.PickByValue(budget, currency)
    if not upgrade or not cost or cost > budget then return end
    xDTaraZ.Upgrade.Exclusive(function()
        local current = xDTaraZ.Upgrade.NextCost(upgrade, currency)
        local available = xDTaraZ.Upgrade.BudgetFor(currency, opt.ProgressionReserve)
        if current and current <= available and State.Opt.AutoProgression then
            xDTaraZ.Upgrade.Buy(upgrade, false, currency)
        end
    end)
end

function xDTaraZ.Progression.TrainStage(stage, once)
    local self = xDTaraZ.Progression
    State.ProgressionTraining = true
    local ok = stage == "Speed" and xDTaraZ.Train.Speed("Best Unlocked")
        or (stage ~= "Speed" and xDTaraZ.Train.Strength("Best Unlocked"))
    self.Failures = ok and 0 or (self.Failures + 1)
    if ok and stage ~= "Speed" then
        if stage == "Measure Strength" and not self.ProbeEnd then self.ProbeEnd = osClock() + Config.RateSample + 2 end
        local value = tonumber(State.Stats.Strength)
        if value then xDTaraZ.Train.MeasuredRate(value, osClock()) end
    end
    if once and ok then
        local deadline = osClock() + 3
        repeat task.wait(Config.TickDelay)
        until not State.Alive or State.ActiveEpoch ~= State.WorkEpoch or osClock() >= deadline
    end
end

function xDTaraZ.Progression.FarmStage(once)
    local self = xDTaraZ.Progression
    if not once then self.Upgrade() end
    if not State.Alive or State.ActiveEpoch ~= State.WorkEpoch then return end
    State.ProgressionFarm = true
    local ok, result = pcall(xDTaraZ.Farm.Step)
    State.ProgressionFarm = false
    if not ok then
        self.Stop("Farm error")
        error(result, 0)
    end
    self.Failures = (result or State.Waiting) and 0 or (self.Failures + 1)
end

function xDTaraZ.Progression.Step(once)
    local self = xDTaraZ.Progression
    if State.ProgressionCleanup then self.Cleanup() end
    if not State.Opt.AutoProgression and not once then return false end
    if not self.Started and not self.Start() then return false end
    if not self.Ready() then
        self.Stop("Game modules unavailable")
        self.Cleanup()
        return false
    end
    local _, humanoid = xDTaraZ:Character()
    if not humanoid then
        self.Stage = "Waiting for character"
        return true
    end
    local stage = self.Select()
    self.Stage = stage
    if stage == "Targets reached" or stage == "Session limit reached" then
        self.Stop(stage)
        self.Cleanup()
        return true
    end
    if (stage == "Farm" or stage == "Waiting") and State.ProgressionTraining then
        self.Cleanup()
    end
    if stage == "Waiting" then
        local secs = xDTaraZ.Game.ResetCountdown()
        State.Status = (secs and secs > 0) and ("Smart: waiting for next pyramid (%ds)"):format(secs) or "Smart: waiting for next pyramid"
        return true
    end
    if stage ~= "Farm" then
        self.TrainStage(stage, once)
    else
        self.FarmStage(once)
    end
    if self.Failures >= 12 then
        self.Stop("No progress: check game access")
        self.Cleanup()
    end
    if once then
        self.Cleanup()
        self.Started = nil
        self.Stage = "Decision completed"
    end
    return true
end

function xDTaraZ.Progression.Now()
    if State.Opt.AutoProgression then
        xDTaraZ:Notify("Smart Progression is already running")
        return
    end
    xDTaraZ.Progression.Step(true)
end

function xDTaraZ.Progression.Build(window, T, Library)
    local self, opt = xDTaraZ.Progression, State.Opt
    local tab = window:AddTab(T("Progression", "สมาร์ทพัฒนา"), "star", T("Farm and train toward your targets", "ฟาร์มและฝึกตามเป้าหมาย"))
    local run = tab:AddLeftGroupbox(T("Progression Controller", "ตัวควบคุมสมาร์ท"), "star")
    local goals = tab:AddRightGroupbox(T("Targets", "เป้าหมาย"), "flag")
    local economy = tab:AddLeftGroupbox(T("Economy", "การใช้เหรียญ"), "coin")
    run:AddToggle("AutoProgression", { Text = T("Auto Progression", "พัฒนาแบบสมาร์ทอัตโนมัติ"), Default = false,
        Description = T("Owns farm and training while enabled; existing options stay saved", "ควบคุมฟาร์มและฝึกเมื่อเปิด โดยเก็บค่าตัวเลือกเดิม"),
        Callback = function(on)
            State.WorkEpoch += 1
            if on and not self.Start() then
                opt.AutoProgression = false
                task.defer(function() Library.Toggles.AutoProgression:SetValue(false) end)
                return
            end
            local previous = opt.AutoProgression
            opt.AutoProgression = on
            if on then
                xDTaraZ.Scheduler.Resume("AutoProgression")
            elseif previous then
                self.Stop("Stopped")
            end
        end,
    })
    run:AddButton({ Text = T("Run One Decision Now", "ทำหนึ่งขั้นตอนตอนนี้"), Func = xDTaraZ.Scheduler.Action("ProgressionNow") })
    run:AddButton({ Text = T("Stop Progression", "หยุดสมาร์ทพัฒนา"), Func = function()
        State.WorkEpoch += 1
        self.Stop("Stopped")
    end })
    run:AddToggle("ProgressionWaitTrain", { Text = T("Train One Level Between Pyramids", "ฝึกหนึ่งเลเวลระหว่างรอพีระมิด"), Default = false,
        Callback = function(on) opt.ProgressionWaitTrain = on end })
    economy:AddToggle("ProgressionUpgrades", { Text = T("Buy Selected Coin Upgrades", "ซื้ออัปเกรดเหรียญที่เลือก"), Default = false,
        Description = T("Uses your upgrade selection and level caps", "ใช้รายการอัปเกรดและเพดานเลเวลที่คุณเลือก"),
        Callback = function(on) opt.ProgressionUpgrades = on end })
    local function Number(box, key, en, th)
        box:AddInput(key, { Text = T(en, th), Default = "0", Numeric = true, Finished = true,
            Callback = function(value)
                local n = tonumber(value)
                opt[key] = n and n == n and n < math.huge and math.max(0, math.floor(n)) or 0
            end })
    end
    Number(goals, "ProgressionCoins", "Target Coins (0 = none)", "เป้าหมายเหรียญ (0 = ไม่กำหนด)")
    Number(goals, "ProgressionPyramids", "Target Total Pyramids (0 = none)", "เป้าหมายพีระมิดรวม (0 = ไม่กำหนด)")
    Number(goals, "ProgressionStrength", "Target Strength Level (0 = smart)", "เป้าหมายเลเวลแรง (0 = สมาร์ท)")
    Number(goals, "ProgressionSpeed", "Target Speed Level (0 = none)", "เป้าหมายเลเวลความเร็ว (0 = ไม่กำหนด)")
    Number(goals, "ProgressionMinutes", "Session Minutes (0 = until stopped)", "เวลาทำงานเป็นนาที (0 = จนกว่าจะหยุด)")
    Number(economy, "ProgressionReserve", "Keep Coins", "เก็บเหรียญไว้")
    goals:AddLabel(T("Stops when all specified targets are reached", "หยุดเมื่อถึงทุกเป้าหมายที่กำหนด"))
    self.Label = run:AddLabel(T("Status: Idle", "สถานะ: พร้อม"))
end

function xDTaraZ.Progression.Pump(Library, T)
    local self = xDTaraZ.Progression
    if self.SyncToggle then
        self.SyncToggle = false
        local toggle = Library.Toggles.AutoProgression
        if toggle and toggle.Value then toggle:SetValue(false) end
    end
    local stages = {
        Idle = "พร้อม", Starting = "เริ่มทำงาน", Farm = "ฟาร์ม", Strength = "ฝึกแรง", Speed = "ฝึกความเร็ว",
        Waiting = "รอพีระมิด", ["Wait Strength"] = "ฝึกแรงระหว่างรอ", ["Smart Strength"] = "ฝึกแรงตามผลวัด",
        ["Measure Strength"] = "วัดอัตราฝึกแรง", ["Targets reached"] = "ถึงเป้าหมายแล้ว",
        ["Session limit reached"] = "ครบเวลาทำงาน", Stopped = "หยุดแล้ว", ["Decision completed"] = "จบหนึ่งขั้นตอน",
        ["Game modules unavailable"] = "ไม่พบระบบเกม", ["Waiting for character"] = "รอตัวละคร",
        ["No progress: check game access"] = "ไม่คืบหน้า ตรวจสิทธิ์เข้าพื้นที่", ["Farm error"] = "ฟาร์มผิดพลาด",
    }
    if self.Label then self.Label:SetText(T("Status: " .. self.Stage, "สถานะ: " .. (stages[self.Stage] or self.Stage))) end
end

xDTaraZ.Visual = { Entries = {}, NextRefresh = 0, NextUpdate = 0, MaxEntries = 96 }
State.Opt.ESP = false
State.Opt.ESPCategories = { Players = true, Quarry = true, Pyramid = true, Pool = true, Gyms = true, Eggs = true, POI = true }
State.Opt.ESPDistance = 1500
State.Opt.ESPNames, State.Opt.ESPDistances, State.Opt.ESPStatus = true, true, true
State.Opt.ESPThroughWalls = true
State.Opt.Spectate = false

function xDTaraZ.Visual.Clear()
    for _, entry in pairs(xDTaraZ.Visual.Entries) do
        if entry.Highlight then entry.Highlight:Destroy() end
        if entry.Label then entry.Label:Destroy() end
    end
    table.clear(xDTaraZ.Visual.Entries)
    if xDTaraZ.Visual.Folder then
        xDTaraZ.Visual.Folder:Destroy()
        xDTaraZ.Visual.Folder = nil
    end
end

function xDTaraZ.Visual.RestoreCamera()
    local saved = xDTaraZ.Visual.Camera
    if saved then
        local camera = saved.Object
        if camera and camera == Workspace.CurrentCamera and camera.CameraSubject == saved.Subject and camera.CameraType ~= Enum.CameraType.Scriptable then
            local original = saved.OriginalSubject
            if not original or not original.Parent then
                local character = LocalPlayer.Character
                original = character and character:FindFirstChildOfClass("Humanoid")
            end
            if original then camera.CameraSubject = original end
            camera.CameraType = saved.Type
        end
        xDTaraZ.Visual.Camera = nil
    end
end

function xDTaraZ.Visual.CameraStep()
    local visual, opt = xDTaraZ.Visual, State.Opt
    if not opt.Spectate then
        visual.RestoreCamera()
        return
    end
    local target = opt.SpectateTarget and Players:FindFirstChild(opt.SpectateTarget)
    if not target or target == LocalPlayer then
        opt.Spectate = false
        visual.RestoreCamera()
        return
    end
    local camera = Workspace.CurrentCamera
    if not camera then return end
    if visual.Camera and visual.Camera.Object ~= camera then visual.RestoreCamera() end
    if camera.CameraType == Enum.CameraType.Scriptable then return end
    local character = target.Character
    local hum = character and character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then
        visual.RestoreCamera()
        return
    end
    if not visual.Camera then
        visual.Camera = { Object = camera, OriginalSubject = camera.CameraSubject, Type = camera.CameraType }
    end
    visual.Camera.Subject = hum
    camera.CameraSubject = hum
end

function xDTaraZ.Visual.Collect(categories)
    local candidates = {}
    local function Add(object, anchor, category, name, player)
        if #candidates >= 256 or not categories[category] or not object or not anchor or not anchor:IsA("BasePart") then return end
        candidates[#candidates + 1] = { Object = object, Anchor = anchor, Category = category, Name = name, Player = player }
    end
    if categories.Players then
        for _, player in ipairs(Players:GetPlayers()) do
            local character = player.Character
            if player ~= LocalPlayer and character then
                Add(character, character:FindFirstChild("HumanoidRootPart"), "Players", player.DisplayName .. " (@" .. player.Name .. ")", player)
            end
        end
    end
    if categories.Quarry and GameLib.Regions then
        local part = GameLib.Regions.getPart("Quarry")
        Add(part, part, "Quarry", "Quarry")
    end
    if categories.Pyramid and GameLib.Pyramid then
        local model = Workspace:FindFirstChild(GameLib.Pyramid.ModelName)
        local part = model and (model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart"))
        if not part and model and GameLib.Regions then part = GameLib.Regions.getPart("Pyramid") end
        Add(model, part, "Pyramid", "Pyramid")
    end
    if categories.Pool and GameLib.Completion then
        xDTaraZ.Move.PoolSpot()
        local part = State.PoolPart
        if part then Add(part, part, "Pool", "Waters of Nu") end
    end
    if categories.Gyms and GameLib.Gym then
        local seen = {}
        for _, stations in ipairs({ GameLib.Gym.BenchpressStations or {}, GameLib.Gym.TreadmillStations or {} }) do
            for _, station in ipairs(stations) do
                local folder = station.GymFolder
                if not seen[folder] then
                    seen[folder] = true
                    local part = xDTaraZ.Move.GymPart(folder, GameLib.Gym.BenchpressModelName, GameLib.Gym.AlignPartName)
                        or xDTaraZ.Move.GymPart(folder, GameLib.Gym.TreadmillModelName, GameLib.Gym.HitboxName)
                    Add(part, part, "Gyms", "Gym " .. tostring(folder))
                end
            end
        end
    end
    if categories.Eggs and GameLib.EggConfig then
        local folder = Workspace:FindFirstChild(GameLib.EggConfig.WorldFolderName)
        local order = GameLib.EggConfig.AllOrder or GameLib.EggConfig.Order or {}
        for _, id in ipairs(order) do
            local egg = GameLib.EggConfig.ById[id]
            local display = egg and folder and folder:FindFirstChild(egg.DisplayModel)
            local part = display and (display:FindFirstChild("BuyPart", true) or display:FindFirstChildWhichIsA("BasePart", true))
            if display and part then
                local cur = egg.Currency or "coins"
                Add(display, part, "Eggs", egg.DisplayName .. " | " .. tostring(egg.Price) .. " " .. cur:lower())
            end
        end
    end
    if categories.POI then
        local portalArea = Workspace:FindFirstChild("HalloweenPortalArea") or Workspace:FindFirstChild("MainPlacePortalArea")
        local portal = portalArea and (portalArea:FindFirstChild("HalloweenPortal") or portalArea:FindFirstChild("MainPlacePortal"))
        local pPart = portal and (portal:FindFirstChild("ProximityPromptPart") or portal:FindFirstChildWhichIsA("BasePart", true))
        if pPart then Add(portal, pPart, "POI", "World Portal") end

        local sg = Workspace:FindFirstChild("SunGod")
        local sgPart = sg and sg:FindFirstChildWhichIsA("BasePart", true)
        if sgPart then Add(sg, sgPart, "POI", "Sun Shrine") end

        local jackArea = Workspace:FindFirstChild("JackArea")
        local jack = jackArea and jackArea:FindFirstChild("Jack")
        local jPart = jack and (jack:FindFirstChild("Torso") or jack:FindFirstChildWhichIsA("BasePart", true))
        if jPart then Add(jack, jPart, "POI", "Jack NPC") end

        local es = Workspace:FindFirstChild("EventSign")
        local esPart = es and (es:FindFirstChild("PromptPart") or es:FindFirstChildWhichIsA("BasePart", true))
        if esPart then Add(es, esPart, "POI", "Event Sign") end
    end
    return candidates
end

function xDTaraZ.Visual.Mount(candidate)
    local visual = xDTaraZ.Visual
    if not visual.Folder then
        local folder = Instance.new("Folder")
        folder.Name = "MarioPyramidVisuals"
        folder.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        visual.Folder = folder
    end
    local entry = candidate
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "Marker"
    billboard.ResetOnSpawn = false
    billboard.Adornee = entry.Anchor
    billboard.Size = UDim2.fromOffset(250, 58)
    billboard.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
    billboard.Parent = visual.Folder
    entry.Label = billboard
    local text = Instance.new("TextLabel")
    text.Size = UDim2.fromScale(1, 1)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255, 230, 120)
    text.TextStrokeTransparency = 0.35
    text.TextSize = 14
    text.Font = Enum.Font.GothamBold
    text.Parent = billboard
    entry.Text = text
    local ok, highlight = pcall(function()
        local item = Instance.new("Highlight")
        item.Adornee = entry.Object
        item.FillTransparency = 0.8
        item.OutlineColor = Color3.fromRGB(255, 220, 100)
        item.Parent = visual.Folder
        return item
    end)
    if ok then entry.Highlight = highlight end
    visual.Entries[candidate.Object] = entry
end

function xDTaraZ.Visual.Refresh()
    local visual, opt = xDTaraZ.Visual, State.Opt
    local candidates = visual.Collect(opt.ESPCategories or {})
    local _, _, root = xDTaraZ:Character()
    table.sort(candidates, function(a, b)
        if (a.Category == "Players") ~= (b.Category == "Players") then return a.Category ~= "Players" end
        if root then return (a.Anchor.Position - root.Position).Magnitude < (b.Anchor.Position - root.Position).Magnitude end
        return a.Name < b.Name
    end)
    local present = {}
    for i, candidate in ipairs(candidates) do
        if i > visual.MaxEntries then break end
        present[candidate.Object] = true
        local entry = visual.Entries[candidate.Object]
        if entry and (entry.Anchor ~= candidate.Anchor or not entry.Label.Parent) then
            if entry.Highlight then entry.Highlight:Destroy() end
            entry.Label:Destroy()
            visual.Entries[candidate.Object] = nil
            entry = nil
        end
        if not entry then visual.Mount(candidate) end
    end
    for object, entry in pairs(visual.Entries) do
        if not present[object] then
            if entry.Highlight then entry.Highlight:Destroy() end
            entry.Label:Destroy()
            visual.Entries[object] = nil
        end
    end
end

function xDTaraZ.Visual.Step()
    local visual, opt = xDTaraZ.Visual, State.Opt
    if visual.Folder and not visual.Folder.Parent then
        visual.Clear()
        visual.NextRefresh = 0
    end
    visual.CameraStep()
    if not opt.ESP then
        if next(visual.Entries) then visual.Clear() end
        return
    end
    local now = osClock()
    if now >= visual.NextRefresh then
        visual.NextRefresh = now + 1
        visual.Refresh()
    end
    if now < visual.NextUpdate then return end
    visual.NextUpdate = now + 0.25
    local _, _, root = xDTaraZ:Character()
    for object, entry in pairs(visual.Entries) do
        local distance = root and entry.Anchor.Parent and (root.Position - entry.Anchor.Position).Magnitude
        local enabled = object.Parent ~= nil and distance ~= nil and distance <= opt.ESPDistance
        entry.Label.Enabled = enabled
        entry.Label.AlwaysOnTop = opt.ESPThroughWalls
        entry.Label.MaxDistance = opt.ESPDistance
        if entry.Highlight then
            entry.Highlight.Enabled = enabled
            entry.Highlight.DepthMode = opt.ESPThroughWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        end
        if enabled then
            local lines = {}
            if opt.ESPNames then lines[#lines + 1] = entry.Name end
            if opt.ESPDistances then lines[#lines + 1] = tostring(math.floor(distance + 0.5)) .. " studs" end
            if opt.ESPStatus then
                if entry.Player then
                    local hum = object:FindFirstChildOfClass("Humanoid")
                    lines[#lines + 1] = hum and ("HP " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)) or "Respawning"
                elseif entry.Category == "Pyramid" then
                    lines[#lines + 1] = xDTaraZ.Game.Completed() and "Completed" or "Building"
                end
            end
            entry.Text.Text = table.concat(lines, "\n")
        end
    end
end

function xDTaraZ.Visual.Stop()
    State.Opt.ESP, State.Opt.Spectate = false, false
    xDTaraZ.Visual.RestoreCamera()
    xDTaraZ.Visual.Clear()
end

local function BuildEspSection(tab, T, opt, visual)
    local markers = tab:AddLeftGroupbox(T("Map ESP", "มองจุดสำคัญ"), "eye")
    local detail = tab:AddRightGroupbox(T("Marker Options", "ตัวเลือกป้าย"), "gear")
    local function Toggle(group, key, text, callback)
        group:AddToggle(key, { Text = text, Default = opt[key] == true,
            Callback = function(value)
                opt[key] = value == true
                if callback then callback(value) end
            end })
    end
    Toggle(markers, "ESP", T("Enable ESP", "เปิดป้ายและเส้นขอบ"), function(value)
        if value then
            visual.NextRefresh = 0
        else
            visual.Clear()
        end
    end)
    markers:AddDropdown("ESPCategories", { Text = T("Categories", "หมวดหมู่"),
        Values = { "Players", "Quarry", "Pyramid", "Pool", "Gyms", "Eggs", "POI" }, Multi = true,
        Default = { "Players", "Quarry", "Pyramid", "Pool", "Gyms", "Eggs", "POI" },
        Callback = function(value)
            opt.ESPCategories = value or {}
            visual.NextRefresh = 0
        end })
    markers:AddSlider("ESPDistance", { Text = T("Maximum Distance", "ระยะสูงสุด"), Min = 50, Max = 5000,
        Default = opt.ESPDistance, Rounding = 0, Callback = function(value) opt.ESPDistance = value end })
    markers:AddButton({ Text = T("Refresh Markers Now", "รีเฟรชป้ายตอนนี้"), Func = function()
        visual.NextRefresh = 0
        if opt.ESP then visual.Step() end
    end })
    Toggle(detail, "ESPNames", T("Names", "ชื่อ"))
    Toggle(detail, "ESPDistances", T("Distances", "ระยะทาง"))
    Toggle(detail, "ESPStatus", T("Health / Pyramid Status", "พลังชีวิต / สถานะพีระมิด"))
    Toggle(detail, "ESPThroughWalls", T("Show Through Walls", "แสดงผ่านกำแพง"))
end

local function BuildSpectateSection(tab, T, opt, visual, Library)
    local camera = tab:AddLeftGroupbox(T("Spectate", "ติดตามกล้องผู้เล่น"), "user")
    local function Names()
        local result = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then result[#result + 1] = player.Name end
        end
        table.sort(result)
        return result
    end
    local targets = camera:AddDropdown("SpectateTarget", { Text = T("Player", "ผู้เล่น"),
        Values = Names(), Searchable = true, AllowNull = true,
        Callback = function(value)
            visual.RestoreCamera()
            opt.SpectateTarget = value
        end })
    camera:AddToggle("Spectate", { Text = T("Auto Follow Selected Player", "ติดตามผู้เล่นที่เลือก"), Default = false,
        Callback = function(value)
            opt.Spectate = value == true
            visual.CameraStep()
        end })
    camera:AddButton({ Text = T("Spectate Now", "ดูผู้เล่นตอนนี้"), Func = function()
        opt.Spectate = true
        visual.CameraStep()
        if Library.Toggles.Spectate then Library.Toggles.Spectate:SetValue(opt.Spectate) end
    end })
    camera:AddButton({ Text = T("Return To My Camera", "กลับกล้องตัวเอง"), Func = function()
        opt.Spectate = false
        visual.RestoreCamera()
        if Library.Toggles.Spectate then Library.Toggles.Spectate:SetValue(false) end
    end })
    camera:AddButton({ Text = T("Refresh Players", "รีเฟรชผู้เล่น"), Func = function() targets:SetValues(Names()) end })
end

function xDTaraZ.Visual.Build(window, T, Library)
    local visual, opt = xDTaraZ.Visual, State.Opt
    local tab = window:AddTab(T("Visuals", "การมองเห็น"), "eye", T("Map markers and player camera", "จุดสำคัญในแมพและกล้องผู้เล่น"))
    BuildEspSection(tab, T, opt, visual)
    BuildSpectateSection(tab, T, opt, visual, Library)
end

function xDTaraZ.Visual.Pump(Library)
    local toggle = Library.Toggles.Spectate
    if toggle and toggle.Value and not State.Opt.Spectate then toggle:SetValue(false) end
end

xDTaraZ.Client = {}

function xDTaraZ.Client.ResetCharacter()
    State.WorkEpoch += 1
    xDTaraZ.Raknet.Stop()
    if xDTaraZ.Visual then
        xDTaraZ.Visual.Clear()
        xDTaraZ.Visual.NextRefresh = 0
    end
    State.TrainingOrigin, State.TrainingPosition, State.FarmOrigin, State.LastSlot = nil, nil, nil, nil
    State.TrainingPool, State.PoolPart, State.PoolSpot, State.PoolRayNext = nil, nil, nil, nil
    State.CarrySnapshot, State.Carry, State.CarryConfirmed = nil, nil, false
    State.QuarryPhysBuf, State.QuarryPhysChar = nil, nil
    State.FarmWait, State.Parked = 0, false
    xDTaraZ.Pets.Origin, xDTaraZ.Pets.ReturnPending = nil, false
    State.Character, State.Humanoid, State.Root = nil, nil, nil
end

function xDTaraZ.Client.IsAutomating()
    local opt = State.Opt
    return opt.AutoProgression or opt.AutoFarm or opt.AutoPickup or opt.AutoPlace or opt.AutoStrength
        or opt.AutoSpeed or opt.AutoPool or opt.AutoHatch or State.ManualMove == true
end

function xDTaraZ.Client.DispatchRejoin()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

function xDTaraZ.Client.Jump()
    if not State.Opt.InfJump then return false end
    local _, hum = xDTaraZ:Character()
    if not hum then return false end
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    return true
end

function xDTaraZ.Client.Recover()
    if not State.Alive or not State.Opt.AutoRejoin or State.Rejoining then return false end
    if osClock() < (State.RejoinNext or 0) then return false end
    State.Rejoining = true
    xDTaraZ.Util.QueueReload()
    task.wait(Config.RejoinDelay)
    if not State.Alive or not State.Opt.AutoRejoin then
        State.Rejoining = false
        return false
    end
    local ok, err = pcall(xDTaraZ.Client.DispatchRejoin)
    if not ok then
        State.Rejoining, State.RejoinNext = false, osClock() + Config.RejoinDelay
        xDTaraZ:Notify("Reconnect failed: " .. tostring(err))
    end
    return ok
end

function xDTaraZ.Client.Bind()
    table.insert(State.Connections, LocalPlayer.Idled:Connect(function()
        if not State.Opt.AntiAfk and not xDTaraZ.Client.IsAutomating() then return end
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.zero)
        end)
    end))

    table.insert(State.Connections, UserInputService.JumpRequest:Connect(xDTaraZ.Client.Jump))

    table.insert(State.Connections, LocalPlayer.CharacterAdded:Connect(function(char)
        xDTaraZ.Client.ResetCharacter()
        local hum = char:WaitForChild("Humanoid", Config.LoadTimeout)
        local root = char:WaitForChild("HumanoidRootPart", Config.LoadTimeout)
        if not State.Alive or LocalPlayer.Character ~= char then return end
        State.Character, State.Humanoid, State.Root = char, hum, root
        if State.Collided then table.clear(State.Collided) end
    end))

    table.insert(State.Connections, GuiService.ErrorMessageChanged:Connect(function(message)
        if type(message) ~= "string" then
            local ok, value = pcall(GuiService.GetErrorMessage, GuiService)
            message = ok and value or "Disconnected"
        end
        State.DisconnectMessage = message
        if message ~= "" then task.spawn(xDTaraZ.Client.Recover) end
    end))
    table.insert(State.Connections, TeleportService.TeleportInitFailed:Connect(function(player)
        if player ~= LocalPlayer then return end
        State.Rejoining, State.RejoinNext = false, osClock() + Config.RejoinDelay
    end))
end

xDTaraZ.Scheduler = {}

xDTaraZ.Scheduler.RequestHandlers = {
    ProgressionNow = xDTaraZ.Progression.Now,
    PickupNow = function() xDTaraZ.Farm.Now(false) end,
    PlaceNow = function() xDTaraZ.Farm.Now(true) end,
    TrainStrengthNow = xDTaraZ.Train.Strength,
    TrainSpeedNow = xDTaraZ.Train.Speed,
    Unboost = xDTaraZ.Server.Unboost,
    PetsNow = xDTaraZ.Pets.HatchNow,
    PetsStop = function()
        xDTaraZ.Pets.Stop()
        xDTaraZ.Pets.Return()
    end,
    PetsBestNow = function() xDTaraZ.Pets.EquipBestStep(true) end,
    PetsRefresh = xDTaraZ.Pets.Refresh,
    PetEquipNow = function() xDTaraZ.Pets.SelectedAction("Equip") end,
    PetUnequipNow = function() xDTaraZ.Pets.SelectedAction("Unequip") end,
    PetLockNow = function() xDTaraZ.Pets.SelectedAction("Lock") end,
    PetUnlockNow = function() xDTaraZ.Pets.SelectedAction("Unlock") end,
    PetUnequipAllNow = xDTaraZ.Pets.UnequipAll,
    PetDeleteUnlockedNow = xDTaraZ.Pets.DeleteUnlocked,
    Movement = xDTaraZ.Move.Refresh,
    FarmStop = xDTaraZ.Farm.Stop,
    TrainStop = xDTaraZ.Train.Leave,
    TrainingExit = xDTaraZ.Train.Exit,
    BlocksNow = xDTaraZ.Bank.BlocksNow,
    SecondsNow = xDTaraZ.Bank.SecondsNow,
    UpgradeNow = xDTaraZ.Upgrade.Now,
    CodesNow = xDTaraZ.Codes.RedeemAll,
    SkipCutsceneNow = xDTaraZ.Cutscene.Now,
    GiftNow = xDTaraZ.Gift.Now,
    TpQuarry = xDTaraZ.Teleport.Quarry,
    TpPyramid = xDTaraZ.Teleport.Pyramid,
    TpPool = xDTaraZ.Teleport.Pool,
    TpGym = xDTaraZ.Teleport.Gym,
    TpPlayer = xDTaraZ.Teleport.Player,
    TpEggs = function()
        local spot = xDTaraZ.Move.EggsSpot()
        if spot then xDTaraZ.Move.To(spot, true) end
    end,
    TpJack = function()
        local spot = xDTaraZ.Move.JackSpot()
        if spot then xDTaraZ.Move.To(spot, true) end
    end,
    TpHalloween = xDTaraZ.Move.HalloweenPortal,
    TpMain = xDTaraZ.Move.MainPortal,
    TpSunGod = xDTaraZ.Teleport.SunGod,
    TpEventSign = xDTaraZ.Teleport.EventSign,
    SignUpEventNow = xDTaraZ.Tasks.SignUpEvent,
    BuyJackNow = xDTaraZ.Tasks.BuyJack,
    Rejoin = xDTaraZ.Server.Rejoin,
    Hop = xDTaraZ.Server.Hop,
    Boost = xDTaraZ.Server.Boost,
    CompleteTutorialNow = xDTaraZ.Exploits.CompleteTutorial,
    RaknetCycleNow = xDTaraZ.Farm.CycleNow,
}

xDTaraZ.Scheduler.Toggles = {
    Progression = { "AutoProgression" },
    Pets = { "AutoHatch" },
    PetsBest = { "AutoEquipPets" },
    PetsLock = { "AutoLockRares" },
    PetsDelete = { "AutoDeletePets" },
    Farm = { "AutoFarm", "InsaneInstant", "AutoPickup", "AutoPlace" },
    Train = { "AutoStrength", "AutoSpeed", "TrainWhileWaiting" },
    Pool = { "AutoPool" },
    Upgrade = { "AutoUpgrade" },
    Gift = { "AutoGift" },
    Cutscene = { "AutoSkipCutscene" },
    Activity = { "AntiAfk" },
    Bank = { "SpendBlocks", "SpendSeconds" },
    Jack = { "AutoBuyJack" },
    Summary = {},
}

xDTaraZ.Tasks.Commands = {
    ProgressionNow = true, PickupNow = true, PlaceNow = true, RaknetCycleNow = true, TrainStrengthNow = true, TrainSpeedNow = true,
    PetsNow = true, PetsStop = true, FarmStop = true, TrainStop = true, TrainingExit = true,
    TpQuarry = true, TpPyramid = true, TpPool = true, TpGym = true, TpPlayer = true, TpEggs = true, TpJack = true,
    TpHalloween = true, TpMain = true, TpSunGod = true, TpEventSign = true, SignUpEventNow = true, BuyJackNow = true,
    PetUnequipAllNow = true, PetDeleteUnlockedNow = true,
}

---@param name string
function xDTaraZ.Scheduler.Enqueue(name)
    if not State.Alive then return end
    if xDTaraZ.Tasks.Commands[name] then State.WorkEpoch += 1 end
    State.Requests[name] = true
end

---@param name string
---@return function
function xDTaraZ.Scheduler.Action(name)
    return function() xDTaraZ.Scheduler.Enqueue(name) end
end

---@param key string?  job name; repeated failures stop it and switch its toggles off
function xDTaraZ.Scheduler.Run(fn, key)
    if key and State.Halted[key] then return end
    local ok, err = pcall(fn)
    if not State.Alive then return end
    if ok then
        if key then State.Fails[key], State.FailSince[key] = nil, nil end
        return
    end
    if not State.Alive then return end
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
        if State.Alive then State.Running[name] = nil end
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

local function PruneLog(log, cutoff)
    local sum = 0
    for i = #log, 1, -1 do
        local entry = log[i]
        if entry[1] < cutoff then
            table.remove(log, i)
        else
            sum += entry[2]
        end
    end
    return sum
end

function xDTaraZ.Scheduler.Summarize()
    local cutoff = osClock() - Config.RateWindow
    local recent = PruneLog(State.CoinLog, cutoff)
    while State.CycleLog[1] and State.CycleLog[1] < cutoff do table.remove(State.CycleLog, 1) end
    local blocks = PruneLog(State.BlockLog, cutoff)
    State.BlockRate = blocks / Config.RateWindow

    local petCoins = xDTaraZ.Pets.Inventory and xDTaraZ.Pets.Inventory.Boosts and xDTaraZ.Pets.Inventory.Boosts.Coins or 1
    local economy = tostring(xDTaraZ.Game.Attr("StrengthLevel")) .. ":" .. tostring(petCoins)
    if State.EconomySignature ~= economy then
        State.EconomySignature, State.UpgradeProbe = economy, nil
        table.clear(State.UpgradeGain)
        table.clear(State.CoinLog)
        table.clear(State.BlockLog)
        recent, blocks, State.BlockRate = 0, 0, 0
    end

    local signature = table.concat({ tostring(xDTaraZ.Game.Attr("StrengthLevel")), tostring(petCoins),
        tostring(State.Opt.PlaceReach), tostring(State.Opt.FarmBatchCap), tostring(State.Opt.FarmSettle),
        tostring(xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPickup)),
        tostring(xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPlace)),
        tostring(xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.placementRange)) }, ":")
    if State.SmartSignature ~= signature then
        State.SmartSignature, State.SmartCache, State.LastFarmSample = signature, nil, nil
        table.clear(State.FarmSamples)
    end
    State.CoinRate = recent / Config.RateWindow
    State.CycleRate = #State.CycleLog / Config.RateWindow
    xDTaraZ.Upgrade.Measure()

    local carried, cap = xDTaraZ.Game.Carried(), xDTaraZ.Game.Capacity()
    local candy = xDTaraZ.Game.CandyCorn()
    local candyText = candy > 0 and (" · Candy " .. xDTaraZ.Format(candy)) or ""
    local world = xDTaraZ.Game.World()
    State.Summary = ("Coins %s · %s/min%s · %s\nStrength Lv %s · Speed Lv %s · Carry %d/%d\nPyramids %s · Blocks %d\n%s"):format(
        xDTaraZ.Format(State.Stats.Coins), xDTaraZ.Format(recent * 60 / Config.RateWindow),
        candyText, world,
        tostring(xDTaraZ.Game.Attr("StrengthLevel") or 0), tostring(xDTaraZ.Game.Attr("SpeedLevel") or 0),
        carried, cap, tostring(xDTaraZ.Game.Attr("Pyramids") or 0), State.BlocksPlaced, xDTaraZ.Boost.Text())
end

function xDTaraZ.Scheduler.Light()
    local opt = State.Opt
    xDTaraZ.Scheduler.Run(xDTaraZ.Visual.Step, "Visual")
    if opt.AutoSkipCutscene then xDTaraZ.Scheduler.Every("Cutscene", 0.1, xDTaraZ.Cutscene.Skip) end
    if opt.AutoEquipPets then xDTaraZ.Scheduler.Every("PetsBest", Config.UpgradeInterval, function() xDTaraZ.Pets.EquipBestStep(false) end, true) end
    xDTaraZ.Scheduler.Run(xDTaraZ.Scheduler.Summarize, "Summary")

    for name, handler in pairs(xDTaraZ.Scheduler.RequestHandlers) do
        if xDTaraZ.Tasks.Commands[name] then continue end
        if not State.Requests[name] then continue end
        State.Requests[name] = nil
        if Config.SlowRequests[name] then
            xDTaraZ.Scheduler.RunOnce(name, handler)
        else
            xDTaraZ.Scheduler.Run(handler)
        end
    end

    if opt.AutoRejoin and (State.DisconnectMessage or "") ~= "" then xDTaraZ.Scheduler.Every("Reconnect", math.max(Config.RejoinDelay, 1), xDTaraZ.Client.Recover, true) end
    if (opt.AntiAfk or xDTaraZ.Client.IsAutomating()) and GameLib.Activity then
        xDTaraZ.Scheduler.Every("Activity", Config.ActivityInterval, function() GameLib.Activity:FireServer() end)
    end
    if GameLib.BoostState then xDTaraZ.Scheduler.Every("Boost", Config.BoostInterval, xDTaraZ.Boost.Read, true) end
    if opt.AutoUpgrade and not opt.AutoProgression then xDTaraZ.Scheduler.Every("Upgrade", Config.UpgradeInterval, xDTaraZ.Upgrade.Step, true) end
    if opt.SpendBlocks or opt.SpendSeconds then xDTaraZ.Scheduler.Every("Bank", Config.BankInterval, xDTaraZ.Bank.Auto, true) end
    if opt.AutoBuyJack then xDTaraZ.Scheduler.Every("Jack", 5, xDTaraZ.Tasks.AutoJack, true) end

    if opt.AutoGift and not State.GiftDone then
        if State.GiftDirty then
            State.GiftDirty = false
            State.Last.Gift = nil
        end
        xDTaraZ.Scheduler.Every("Gift", Config.GiftInterval, xDTaraZ.Gift.Claim, true)
    end
end

function xDTaraZ.Scheduler.Work()
    State.ActiveEpoch = State.WorkEpoch
    for name in pairs(xDTaraZ.Tasks.Commands) do
        if not State.Requests[name] then continue end
        State.Requests[name] = nil
        State.ManualMove = true
        xDTaraZ.Scheduler.Run(xDTaraZ.Scheduler.RequestHandlers[name])
        if not State.Alive then return end
        State.ManualMove = false
        State.ActiveEpoch = State.WorkEpoch
        return
    end
    local _, hum = xDTaraZ:Character()
    if not hum then return end
    xDTaraZ.Scheduler.Run(xDTaraZ.Tasks.Step)
end

---@param step function  one pass of a loop that ends with the hub
function xDTaraZ.Scheduler.Loop(step, label)
    task.defer(function()
        local fails = 0
        while State.Alive do
            local ok, result = pcall(step)
            if ok and result == false then return end
            if ok then
                fails = 0
            else
                fails += 1
                if fails == 1 then warn("[BuildThePyramid] " .. (label or "Worker") .. ":", result) end
                if fails == Config.FailLimit then xDTaraZ:Notify((label or "Worker") .. " is retrying after an error") end
            end
            local delay = ok and ((label == "Character" and State.Opt.InsaneInstant) and 0 or Config.TickDelay)
                or math.min(Config.RetryMax, Config.TickDelay * 2 ^ math.min(fails, 7))
            task.wait(delay)
        end
    end)
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Client.Bind()
    if GameLib.CarryChanged then
        table.insert(State.Connections, GameLib.CarryChanged.OnClientEvent:Connect(function(blob) xDTaraZ.Game.ReadCarry(blob) end))
    end
    if GameLib.GiftChanged then
        table.insert(State.Connections, GameLib.GiftChanged.OnClientEvent:Connect(function()
            State.GiftDirty = true
            State.GiftDone = false
        end))
    end
    task.spawn(xDTaraZ.Game.WatchStats)
    xDTaraZ.Scheduler.Loop(xDTaraZ.Scheduler.Light, "Background")
    xDTaraZ.Scheduler.Loop(xDTaraZ.Scheduler.Work, "Character")
end

function xDTaraZ.Scheduler.Stop()
    if not State.Alive then return end
    local opt = State.Opt
    xDTaraZ.Visual.Stop()
    xDTaraZ.Progression.Stop("Unloaded")
    State.Alive = false
    opt.AutoHatch, opt.AutoEquipPets = false, false
    State.WorkEpoch += 1
    State.GrabToken, State.PlaceToken = nil, nil
    for _, idx in ipairs(Config.AutoOptions) do opt[idx] = false end
    opt.SpendBlocks, opt.SpendSeconds = false, false
    local benching = xDTaraZ.Game.Benching()
    if benching and GameLib.StopBench then
        task.spawn(function()
            xDTaraZ.Util.Deadline("stopbench", Config.RemoteTimeout, function() return GameLib.StopBench:InvokeServer() end, true)
        end)
    end
    xDTaraZ.Util.Try("leave gym", xDTaraZ.Train.Leave)
    xDTaraZ.Util.Try("farm stop", xDTaraZ.Farm.Stop)

    if xDTaraZ.Exploits then
        pcall(xDTaraZ.Exploits.SetInstantPrompts, false)
        pcall(xDTaraZ.Exploits.SetAntiHazard, false)
        pcall(xDTaraZ.Exploits.SetFastInteract, false)
    end
    xDTaraZ.Raknet.Stop()
    opt.RemoteQuarry, opt.PacketBurst, opt.InsaneInstant = false, false, false
    opt.InstantPrompts = false
    opt.AntiHazard = false
    opt.FastInteract = false

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
    local Compat = Library.Compat
    local opt = State.Opt
    local statusLabel, runLabel

    local function Notify(text, kind)
        Library:Notify("Build the Pyramid", text, 4, kind or "Info")
    end

    local Request = xDTaraZ.Scheduler.Action

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
            Callback = function(value)
                local n = tonumber(value)
                onValue(n and n == n and n < math.huge and math.max(math.floor(n), 0) or 0)
            end,
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
        for _, station in ipairs((GameLib.Gym and GameLib.Gym.BenchpressStations or {})) do
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
            local item = table.remove(State.HaltQueue, 1)
            if not item then break end
            local toggles, label, reason = item[1], item[2], item[3]
            for _, idx in ipairs(toggles or {}) do
                local toggle = Library.Toggles[idx]
                if toggle and toggle.Value == true then toggle:SetValue(false) end
            end
            Notify(tostring(label) .. " stopped: " .. tostring(reason), "Error")
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

    local function BuildFarmCore(FarmTab, T, opt, Toggle, NumberInput)
        local farmBox = FarmTab:AddLeftGroupbox(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "brick")
        farmBox:AddToggle("AutoFarm", {
            Text = T("Auto Farm", "ฟาร์มอัตโนมัติ"),
            Description = T("Grabs blocks and builds the pyramid for coins", "หยิบบล็อกแล้วสร้างพีระมิดเพื่อเหรียญ"),
            Default = false,
            Callback = function(value)
                opt.AutoFarm = value
                if value then
                    xDTaraZ.Scheduler.Resume("AutoFarm")
                else
                    State.WorkEpoch += 1
                    State.Requests.FarmStop = true
                end
            end,
        })
        Toggle(farmBox, "ReturnOnStop", T("Return On Stop", "กลับที่เดิมเมื่อหยุด"), T("Goes back to where you started", "กลับไปจุดที่เริ่มฟาร์ม"))
        farmBox:AddSlider("PlaceReach", {
            Text = T("Place Distance", "ระยะวางบล็อก"),
            Description = T("Lower it if blocks get refused, raise it for fewer repositions", "ลดถ้าวางไม่ติด เพิ่มเพื่อขยับน้อยลง"),
            Min = 16, Max = 36, Default = opt.PlaceReach, Rounding = 0, Suffix = " studs",
            Callback = function(value) opt.PlaceReach = tonumber(value) or opt.PlaceReach end,
        })
        farmBox:AddDropdown("FarmPlacement", {
            Text = T("Placement Strategy", "วิธีวางบล็อก"), Values = { "Native Bulk", "Server Fill" }, Default = opt.FarmPlacement,
            Description = T("Native Bulk reserves distinct slots; Server Fill lets the server choose extras.", "Native Bulk จองช่องไม่ซ้ำ ส่วน Server Fill ให้เซิร์ฟเวอร์เลือกช่องเพิ่มเติม"),
            Callback = function(value) opt.FarmPlacement = value end,
        })
        farmBox:AddSlider("FarmBatchCap", {
            Text = T("Calls Per Batch", "จำนวนคำสั่งต่อชุด"), Min = 16, Max = Config.MaxBatch,
            Default = opt.FarmBatchCap, Rounding = 0,
            Callback = function(value) opt.FarmBatchCap = math.clamp(math.floor(tonumber(value) or Config.MaxBatch), 16, Config.MaxBatch) end,
        })
        farmBox:AddSlider("FarmSettle", {
            Text = T("Placement Pacing", "จังหวะวางบล็อก"),
            Description = T("Default 0.15 seconds; lower values need testing on your connection.", "ค่าเริ่มต้น 0.15 วินาที ค่าที่ต่ำกว่าต้องลองกับการเชื่อมต่อของคุณ"),
            Min = 0.05, Max = 0.5, Default = opt.FarmSettle, Rounding = 2, Suffix = " s",
            Callback = function(value) opt.FarmSettle = math.clamp(tonumber(value) or Config.SettleDelay, 0.05, 0.5) end,
        })
        NumberInput(farmBox, "StopCoins", T("Stop At Coins (0 = never)", "หยุดเมื่อเหรียญถึง (0 = ไม่หยุด)"), function(value) opt.StopCoins = value end)
        NumberInput(farmBox, "StopPyramids", T("Stop At Pyramids (0 = never)", "หยุดเมื่อพีระมิดถึง (0 = ไม่หยุด)"), function(value) opt.StopPyramids = value end)

        local blockBox = FarmTab:AddLeftGroupbox(T("Block Actions", "คำสั่งบล็อก"), "brick")
        Toggle(blockBox, "AutoPickup", T("Auto Pickup", "หยิบบล็อกอัตโนมัติ"), nil, function(on) if not on then State.WorkEpoch += 1 end end)
        Toggle(blockBox, "AutoPlace", T("Auto Place", "วางบล็อกอัตโนมัติ"), nil, function(on) if not on then State.WorkEpoch += 1 end end)
        blockBox:AddButton({ Text = T("Pickup Now", "หยิบบล็อกเดี๋ยวนี้"), Func = Request("PickupNow") })
        blockBox:AddButton({ Text = T("Place Now", "วางบล็อกเดี๋ยวนี้"), Func = Request("PlaceNow") })
    end

    local function BuildFarmCoordination(FarmTab, T, opt, Toggle, Compat, Library)
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

        local accelBox = FarmTab:AddRightGroupbox(T("Network Acceleration", "เร่งความเร็วขั้นสูง"), "zap", "OP")
        local function HandleRaknetToggle(toggle, key, on)
            opt[key] = on
            if not on then
                xDTaraZ.Raknet.Stop()
                return
            end
            task.spawn(function()
                if not Compat.RaknetLive(1.5) and State.Alive and opt[key] then
                    Library:Notify("Mario Hub", T("Turn on RakNet in Potassium settings", "กรุณาเปิด RakNet ในตั้งค่า Potassium ก่อน"), 4, "Warn")
                    toggle:SetValue(false)
                end
            end)
        end
        local remoteQuarryToggle
        remoteQuarryToggle = accelBox:AddToggle("RemoteQuarry", {
            Text = T("Remote Quarry Refill", "เติมบล็อกจากเหมืองระยะไกล"),
            Description = T("Refills blocks without leaving the pyramid", "เติมบล็อกเต็มความจุโดยไม่ต้องเดินกลับไปที่เหมือง"),
            Default = false,
            Callback = function(on) HandleRaknetToggle(remoteQuarryToggle, "RemoteQuarry", on) end,
        })
        Compat.NeedCap(remoteQuarryToggle, "Raknet")
        local packetBurstToggle
        packetBurstToggle = accelBox:AddToggle("PacketBurst", {
            Text = T("Instant Pickup Burst", "ดึงบล็อกแบบรวดเดียว"),
            Description = T("Fills your carry capacity in a single burst", "ดึงบล็อกเข้าตัวพร้อมกันรวดเดียวจนเต็มความจุ"),
            Default = false,
            Callback = function(on) HandleRaknetToggle(packetBurstToggle, "PacketBurst", on) end,
        })
        Compat.NeedCap(packetBurstToggle, "Raknet")
        local insaneInstantToggle
        insaneInstantToggle = accelBox:AddToggle("InsaneInstant", {
            Text = T("Zero-Delay Instant Farm", "ฟาร์มทันทีไร้ดีเลย์"),
            Description = T("Continuous high-speed block refill and instant pyramid building", "เติมบล็อกความเร็วสูงต่อเนื่องและสร้างพีระมิดทันที"),
            Default = false,
            Callback = function(on)
                HandleRaknetToggle(insaneInstantToggle, "InsaneInstant", on)
                if on then
                    if remoteQuarryToggle then remoteQuarryToggle:SetValue(true) end
                    if packetBurstToggle then packetBurstToggle:SetValue(true) end
                end
            end,
        })
        Compat.NeedCap(insaneInstantToggle, "Raknet")
        accelBox:AddButton({ Text = T("Refill & Place Now", "เติมและวางบล็อกเดี๋ยวนี้"), Func = Request("RaknetCycleNow") })
    end

    local function BuildFarm(window)
        window:AddTabSection(T("Farming", "ฟาร์ม"))
        local FarmTab = window:AddTab(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "brick", T("Blocks and coins", "บล็อกและเหรียญ"))
        BuildFarmCore(FarmTab, T, opt, Toggle, NumberInput)
        BuildFarmCoordination(FarmTab, T, opt, Toggle, Compat, Library)
    end

    local function BuildGymSection(GymTab, T, opt, Toggle, NumberInput)
        local gymBox = GymTab:AddLeftGroupbox(T("Gym", "ยิม"), "heart")
        Toggle(gymBox, "AutoStrength", T("Auto Train Strength", "ฝึกพลังอัตโนมัติ"), T("Bench press at your strongest gym", "ยกน้ำหนักที่ยิมแรงสุดที่ใช้ได้"), function(on)
            if not on then
                State.WorkEpoch += 1
                State.Requests.TrainStop = true
            end
        end)
        Toggle(gymBox, "AutoSpeed", T("Auto Train Speed", "ฝึกความเร็วอัตโนมัติ"), T("Runs on your strongest treadmill", "วิ่งบนลู่ที่แรงสุดที่ใช้ได้"), function(on)
            if not on then
                State.WorkEpoch += 1
                State.Requests.TrainStop = true
            end
        end)

        gymBox:AddButton({ Text = T("Train Strength Now", "ฝึกพลังเดี๋ยวนี้"), Func = Request("TrainStrengthNow") })
        gymBox:AddButton({ Text = T("Train Speed Now", "ฝึกความเร็วเดี๋ยวนี้"), Func = Request("TrainSpeedNow") })

        local function StationLabels(stations, key)
            local labels = { "Best Unlocked" }
            for _, station in ipairs(stations or {}) do
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
            Values = StationLabels((GameLib.Gym and GameLib.Gym.BenchpressStations or {}), "StrengthMultiplier"),
            Default = 1,
            Callback = StationPick("BenchStation"),
        })
        gymBox:AddDropdown("TreadmillStationPick", {
            Text = T("Treadmill Gym", "ยิมลู่วิ่ง"),
            Values = StationLabels((GameLib.Gym and GameLib.Gym.TreadmillStations or {}), "SpeedMultiplier"),
            Default = 1,
            Callback = StationPick("TreadmillStation"),
        })
        NumberInput(gymBox, "TargetStrength", T("Target Strength Level (0 = never)", "เลเวลพลังเป้าหมาย (0 = ไม่หยุด)"), function(value) opt.TargetStrength = value end)
        NumberInput(gymBox, "TargetSpeed", T("Target Speed Level (0 = never)", "เลเวลความเร็วเป้าหมาย (0 = ไม่หยุด)"), function(value) opt.TargetSpeed = value end)
        Toggle(gymBox, "ReturnTraining", T("Return On Training Stop", "กลับที่เดิมเมื่อหยุดฝึก"))
        gymBox:AddButton({ Text = T("Exit Training Now", "ออกจากการฝึกทันที"), Func = Request("TrainingExit") })
    end

    local function BuildPoolSection(GymTab, T, opt, Toggle, NumberInput)
        local poolBox = GymTab:AddRightGroupbox(T("Waters of Nu", "สระ Waters of Nu"), "pipe")
        Toggle(poolBox, "AutoPool", T("Auto Join Pool", "ลงสระอัตโนมัติ"), T("Trains in the pool when a pyramid is finished", "ฝึกในสระเมื่อพีระมิดสร้างเสร็จ"), function(on)
            if not on then
                State.WorkEpoch += 1
                State.Requests.TrainStop = true
            end
        end)
        poolBox:AddButton({ Text = T("Go To Pool", "ไปสระ"), Func = Request("TpPool") })
        local bankBox = GymTab:AddRightGroupbox(T("Banked Resources", "ทรัพยากรที่ซื้อเก็บไว้"), "coin")
        bankBox:AddLabel(T("Spending uses the whole balance. Any reserve above 0 blocks spending.", "ใช้ครั้งเดียวหมดทั้งยอด ตั้งสำรองมากกว่า 0 เพื่อไม่ให้ใช้"))
        Toggle(bankBox, "SpendBlocks", T("Auto Spend Banked Blocks", "ใช้บล็อกที่ซื้อไว้อัตโนมัติ"))
        NumberInput(bankBox, "KeepBlocks", T("Keep Banked Blocks", "สำรองบล็อกที่ซื้อไว้"), function(value) opt.KeepBlocks = value end)
        bankBox:AddButton({ Text = T("Spend Blocks Now", "ใช้บล็อกเดี๋ยวนี้"), Func = Request("BlocksNow") })
        Toggle(bankBox, "SpendSeconds", T("Auto Spend Pool Time", "ใช้เวลาสระที่ซื้อไว้อัตโนมัติ"))
        NumberInput(bankBox, "KeepSeconds", T("Keep Pool Seconds", "สำรองเวลาสระ (วินาที)"), function(value) opt.KeepSeconds = value end)
        bankBox:AddButton({ Text = T("Spend Pool Time Now", "ใช้เวลาสระเดี๋ยวนี้"), Func = Request("SecondsNow") })
    end

    local function BuildTraining(window)
        local GymTab = window:AddTab(T("Training", "ฝึก"), "heart", T("Strength, speed and the pool", "พลัง ความเร็ว และสระ"))
        BuildGymSection(GymTab, T, opt, Toggle, NumberInput)
        BuildPoolSection(GymTab, T, opt, Toggle, NumberInput)
    end

    local function BuildShop(window)
        window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local ShopTab = window:AddTab(T("Upgrades & Codes", "อัปเกรดและโค้ด"), "shop", T("Spend coins and redeem codes", "ใช้เหรียญและใส่โค้ด"))

        local upgradeBox = ShopTab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "coin")
        Toggle(upgradeBox, "AutoUpgrade", T("Auto Upgrade", "อัปเกรดอัตโนมัติ"), T("Buys the selected upgrades with Coins or Candy Corn", "ซื้ออัปเกรดที่เลือกด้วยเหรียญหรือแคนดี้คอร์น"))
        opt.Upgrades = {}
        for _, name in ipairs(xDTaraZ.UpgradeNames) do opt.Upgrades[name] = true end
        upgradeBox:AddDropdown("Upgrades", {
            Text = T("Upgrades", "อัปเกรด"),
            Values = xDTaraZ.UpgradeNames,
            Images = xDTaraZ.UpgradeImages,
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
        rulesBox:AddDropdown("UpgradeCurrency", {
            Text = T("Currency", "สกุลเงินที่ใช้"),
            Values = { "Auto", "Coins", "Candy Corn" },
            Default = 1,
            Callback = function(value) opt.UpgradeCurrency = value or "Auto" end,
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

        local halloweenShopBox = ShopTab:AddRightGroupbox(T("Halloween Event", "กิจกรรมฮาโลวีน"), "star")
        Toggle(halloweenShopBox, "AutoBuyJack", T("Auto Buy & Equip Jack", "ซื้อและสวมใส่ Jack อัตโนมัติ"),
            T("Costs 50M Candy Corn. Grants +0.5 Hatch Luck, Quick Grab & Place.", "ราคา 50M แคนดี้คอร์น ได้รับ +0.5 โชคเปิดไข่, หยิบและวางไวพิเศษ"))
        halloweenShopBox:AddButton({ Text = T("Buy Jack Now", "ซื้อ Jack ทันที"), Func = Request("BuyJackNow") })
    end

    local function BuildMoveSection(PlayerTab, T, opt, Toggle)
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
        moveBox:AddDropdown("FlyVertical", {
            Text = T("Fly Vertical Direction", "ทิศทางบินแนวตั้ง"),
            Values = { "Camera", "Up", "Down" }, Default = 1,
            Callback = function(value) opt.FlyVertical = value or "Camera" end,
        })
        Toggle(moveBox, "Noclip", T("Noclip", "ทะลุกำแพง"), nil, Request("Movement"))
            :AddKeyPicker("NoclipKey", { Default = "None", Mode = "Toggle" })
        Toggle(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))

        local exploitBox = PlayerTab:AddLeftGroupbox(T("OP Exploits", "เอ็กซ์พลอยต์ OP"), "zap", "OP")
        Toggle(exploitBox, "InstantPrompts", T("Instant Prompts", "กดโต้ตอบทันที"),
            T("Removes hold delay for all proximity prompts", "กดใช้ Proximity Prompt ทุกจุดได้ทันทีไม่ต้องกดค้าง"),
            function(on) xDTaraZ.Exploits.SetInstantPrompts(on) end)
        Toggle(exploitBox, "AntiHazard", T("Anti-Hazard / Godmode", "กันตก / อมตะจากหลุม"),
            T("Prevents void death, fall damage and ragdoll locks", "ป้องกันการตกหลุมตายและอาการล็อกขยับไม่ได้"),
            function(on) xDTaraZ.Exploits.SetAntiHazard(on) end)
        Toggle(exploitBox, "FastInteract", T("Fast Hold Interaction (60/s)", "กดค้างความเร็วสูง (60/วิ)"),
            T("Accelerates manual holding actions to 60/sec", "เร่งความเร็วการกดค้างเองเป็น 60 ครั้งต่อวินาที"),
            function(on) xDTaraZ.Exploits.SetFastInteract(on) end)
        exploitBox:AddButton({ Text = T("Complete Tutorial Now", "ผ่านติวเตอร์ทันที"), Func = Request("CompleteTutorialNow") })
    end

    local function BuildTeleportSection(PlayerTab, T)
        local tpBox = PlayerTab:AddRightGroupbox(T("Teleport", "วาร์ป"), "teleport")
        tpBox:AddButton({ Text = T("Halloween World (Portal)", "โลกฮาโลวีน (วาร์ป)"), Func = Request("TpHalloween") })
        tpBox:AddButton({ Text = T("Main World (Portal)", "โลกหลัก (วาร์ป)"), Func = Request("TpMain") })
        tpBox:AddButton({ Text = T("Quarry", "เหมืองหิน"), Func = Request("TpQuarry") })
        tpBox:AddButton({ Text = T("Pyramid", "พีระมิด"), Func = Request("TpPyramid") })
        tpBox:AddButton({ Text = T("Waters of Nu (Pool)", "สระวารีศักดิ์สิทธิ์"), Func = Request("TpPool") })
        tpBox:AddButton({ Text = T("Eggs Area", "พื้นที่ไข่"), Func = Request("TpEggs") })
        tpBox:AddButton({ Text = T("Jack NPC", "จุดรับแจ็ค"), Func = Request("TpJack") })
        tpBox:AddButton({ Text = T("Sun Shrine", "ศาลสุริยัน"), Func = Request("TpSunGod") })
        tpBox:AddButton({ Text = T("Event Sign", "ป้ายกิจกรรม"), Func = Request("TpEventSign") })
        tpBox:AddButton({ Text = T("Sign Up Event Now", "ลงทะเบียนกิจกรรมทันที"), Func = Request("SignUpEventNow") })
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

    local function BuildPlayer(window)
        window:AddTabSection(T("Misc", "อื่นๆ"))
        local PlayerTab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and teleports", "การเคลื่อนที่และวาร์ป"))
        BuildMoveSection(PlayerTab, T, opt, Toggle)
        BuildTeleportSection(PlayerTab, T)
    end

    local function BuildSettings(window)
        local settingsTab = window:AddSettingsTab()
        local sessionBox = settingsTab:AddRightGroupbox(T("Session", "เซสชัน"), "gear")
        Toggle(sessionBox, "AutoSkipCutscene", T("Auto Skip Cutscene", "ข้ามคัตซีนอัตโนมัติ"),
            T("Restores camera, HUD and controls after completion", "คืนกล้อง หน้าจอ และการควบคุมหลังสร้างเสร็จ"),
            function(on) xDTaraZ.Cutscene.SetAutoSkip(on) end)
        sessionBox:AddButton({ Text = T("Skip Cutscene Now", "ข้ามคัตซีนตอนนี้"), Func = Request("SkipCutsceneNow") })
        Toggle(sessionBox, "AntiAfk", T("Anti AFK", "กันหลุด AFK"), T("Keeps the session active even when automation is off", "คงสถานะแอ็กทีฟแม้ไม่ได้เปิดระบบอัตโนมัติ"))
        Toggle(sessionBox, "AutoRejoin", T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"))
        if Library.Compat and Library.Compat.NeedCap then Library.Compat.NeedCap(Library.Toggles.AutoRejoin, "Queue") end
        Toggle(sessionBox, "NoRender", T("Disable 3D Rendering", "ปิดการเรนเดอร์ 3D"), T("Saves battery and CPU while farming", "ประหยัดแบตและ CPU ตอนฟาร์ม"), function(on)
            RunService:Set3dRenderingEnabled(not on)
        end)
        sessionBox:AddButton({ Text = T("Restore Graphics", "คืนค่ากราฟิก"), Func = Request("Unboost") })
        sessionBox:AddButton({ Text = T("FPS Boost", "เพิ่ม FPS"), Func = Request("Boost") })
        sessionBox:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟเดิมใหม่"), Func = Request("Rejoin") })
        sessionBox:AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Func = Request("Hop") })
    end

    local function Live()
        Library:Every(1, function()
            xDTaraZ.Pets.Pump(Library)
            xDTaraZ.Progression.Pump(Library, T)
            xDTaraZ.Visual.Pump(Library)
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
        xDTaraZ.Util.Try("ui progression", xDTaraZ.Progression.Build, window, T, Library)
        xDTaraZ.Util.Try("ui farm", BuildFarm, window)
        xDTaraZ.Util.Try("ui training", BuildTraining, window)
        xDTaraZ.Util.Try("ui shop", BuildShop, window)
        xDTaraZ.Util.Try("ui pets", xDTaraZ.Pets.Build, window, T, Library)
        xDTaraZ.Util.Try("ui player", BuildPlayer, window)
        xDTaraZ.Util.Try("ui visual", xDTaraZ.Visual.Build, window, T, Library)
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

pcall(MarioBanner.Step, "Systems")
if BuildInterface() then
    pcall(MarioBanner.Step, "Interface")
    pcall(MarioBanner.Ready)
end