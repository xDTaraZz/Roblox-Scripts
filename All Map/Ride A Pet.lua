if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10035204815 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Ride A Pet only")
    return
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
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

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
        "   RIDE A PET  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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
if type(environment.RideAPetUnload) == "function" then
    pcall(environment.RideAPetUnload)
end

local vector3New, cframeNew = Vector3.new, CFrame.new
local osClock = os.clock

local Library, T

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    ReloadSource = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/loader.lua"))()',
    Discord = "https://discord.gg/FHVfmeSceA",
    UpdateLog = {
        { "2026-10-04", "Updated for the new game version\nAuto Sell Pets with rarity filter\nFaster egg collecting\nRemoved keybind from Auto Collect Eggs\nFixed Auto Place Best Pets swapping pets\nAuto Feed goes to your base first\nVolcano Dip & Auto Volcano Obby\nAuto Place Eggs fills your plot up to its limit\nFixed eggs breaking before reaching base\nVolcano climb runs by itself for Volcanic Eggs\nRemoved Auto Buy Nests" },
        { "2026-10-03", "Classic Mario Hub UI is back\nBetter executor support\nBug fixes & better UI" },
    },
    SaveFolder = "Ride A Pet",
    Tag = "[RideAPet]",
    LoadTimeout = 30,
    AlertTries = 20,
    AlertGap = 0.5,
    FailLimit = 5,
    FailWindow = 10,
    DataModules = { "Eggs", "Pets", "Rebirths", "Mutations", "Foods", "EggBaskets", "Shop" },

    EggHover = 4,
    HomeHover = 3,
    NestHover = 5,
    TeleportSettle = 0.25,
    EquipSettle = 0.15,
    PickupWait = 0.9,
    RetryGap = 0.07,
    SellEvery = 45,
    SellStand = 6,
    SellWait = 6,
    FuseSlots = 4,
    FuseLift = 3,
    FuseStand = 5,
    FuseSettle = 0.5,
    FuseReplyWait = 1.2,
    FuseEvery = 5,
    ShopEvery = 20,
    ShopWait = 3,
    ShopGap = 0.15,
    DeliverWait = 0.6,
    ClaimBatch = 64,
    DeliverMargin = 5,
    EggSkipFor = 30,
    EggStock = 40,
    DeliverBackoff = 3,
    VolcanoSpot = Vector3.new(-5103, 41406, -3489),
    VolcanoStream = 5,
    VolcanoWait = 3,
    VolcanoSettle = 0.3,
    TouchGap = 0.05,
    VolcanoStep = 0.4,
    DeliverTries = 3,
    DipWait = 15,
    DipMinLeft = 12,
    ObbyRetry = 30,
    SnapshotTtl = 0.2,
    LockWait = 6,

    EggTick = 0.1,
    StepTick = 0.5,
    HatchGap = 1.5,
    HatchRetry = 30,
    PlaceGap = 0.4,
    NestSkipFor = 30,
    PlantGap = 9,
    PlantSpread = 0.42,
    PlantWait = 1.5,
    PlotCapGuess = 40,
    PlotCapRecheck = 60,
    PetSpread = 0.35,
    PetLift = 0.5,
    PetFailBackoff = 20,
    SwapMargin = 1.1,
    FeedGap = 1,
    FeedEvery = 5,
    ClaimGap = 30,
    UpgradeGap = 2,
    RebirthGap = 5,
    RebirthBackoff = 60,
    RebirthReserve = 2,

    HuntHopAfter = 45,
    HuntMaxHops = 15,
    HopPick = 15,
    HopReset = 15,

    FlySpeed = 120,
    WalkSpeed = 60,
    JumpPower = 80,
    FlingSpin = 2000,
    FlingForce = 9e4,
    StickOffset = 2,

    EspRange = 8000,
    EspRefresh = 0.5,
    EspLift = 4,
    RarityColors = {
        Common = Color3.fromRGB(200, 200, 200), Rare = Color3.fromRGB(90, 170, 255), Epic = Color3.fromRGB(190, 110, 255),
        Legendary = Color3.fromRGB(255, 200, 60), Mythic = Color3.fromRGB(255, 90, 90), Divine = Color3.fromRGB(120, 255, 220),
        Ethereal = Color3.fromRGB(255, 130, 230),
    },
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Status = "Idle",
    Lock = nil,
    EggsCollected = 0,
    DipReply = nil,
    MagmaEggs = 0,
    ObbyRetryAt = 0,
    EggSkip = {},
    NestSkip = {},
    PlotCap = nil,
    PlotCapAt = 0,
    Snapshot = nil,
    StockFloor = 0,
    SnapshotAt = 0,
    DeliverFailUntil = 0,
    PetFailUntil = 0,
    PetScores = {},
    LastHatch = 0,
    LastHatchAll = 0,
    LastClaim = 0,
    LastUpgrade = 0,
    LastRebirth = 0,
    RebirthBlockedUntil = 0,
    LastFeed = 0,
    LastSell = 0,
    LastFusion = 0,
    LastShop = 0,
    SellPending = false,
    NextRebirthCost = math.huge,
    EmptySince = nil,
    Hopping = false,
    EspBoards = {},
    CollidePatch = {},
    TrollHome = nil,
    Missing = {},
    Fails = {},
    FailSince = {},
    Halted = {},
    HaltQueue = {},
}

xDTaraZ.Options = {}

local Config, State = xDTaraZ.Config, xDTaraZ.State

xDTaraZ.Util = {}

---@return string?, string?  body, or nil and why every transport failed
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

---@param detail any?  extra context for the console only
function xDTaraZ.Util.Alert(text, detail)
    warn(Config.Tag, text, detail or "")
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
    if not ok then warn(Config.Tag, label .. ":", err) end
    return ok
end

---@return table?, string?  UI library, or nil and a message for the player
function xDTaraZ.Util.LoadLibrary(url)
    local source, why = xDTaraZ.Util.HttpGet(url)
    if not source or not source:sub(-64):find("return%s+Library%s*$") then
        warn(Config.Tag, "ui download:", why or "truncated or not the library")
        return nil, "Could not download the menu. Check your connection and run it again."
    end
    local chunk, compileErr = loadstring(source)
    if not chunk then
        return nil, "The menu failed to load on this executor: " .. tostring(compileErr)
    end
    local ok, lib = pcall(chunk)
    if not ok or type(lib) ~= "table" then
        return nil, "The menu failed to load on this executor: " .. tostring(lib)
    end
    return lib
end

function xDTaraZ.Util.ParentGui(gui)
    local ok, hidden = pcall(gethui)
    if ok and hidden and pcall(function() gui.Parent = hidden end) then return end
    if pcall(function() gui.Parent = CoreGui end) then return end
    gui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
end

function xDTaraZ.Util.Copy(text)
    local copier = setclipboard or toclipboard
    if not copier then return false end
    copier(text)
    return true
end

function xDTaraZ.Util.FormatNumber(n)
    if n == math.huge then return "-" end
    local suffixes = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx" }
    local i = 1
    while math.abs(n) >= 1000 and i < #suffixes do
        n /= 1000
        i += 1
    end
    return i == 1 and tostring(math.floor(n)) or string.format("%.2f%s", n, suffixes[i])
end

xDTaraZ.GameLib = { Missing = {} }
local GameLib = xDTaraZ.GameLib

---@return Instance?  child, nil and noted in State.Missing when it never shows up
local function Need(parent, name)
    if not parent then
        table.insert(State.Missing, name)
        return nil
    end
    local child
    if #State.Missing > 0 then
        child = parent:FindFirstChild(name)
    else
        child = parent:WaitForChild(name, Config.LoadTimeout)
    end
    if not child then table.insert(State.Missing, name) end
    return child
end

---@return Instance?  remote with this name anywhere under ReplicatedStorage.Remotes
local function SearchRemote(name)
    local root = ReplicatedStorage:FindFirstChild("Remotes")
    for _, node in ipairs(root and root:GetDescendants() or {}) do
        if node.Name == name and (node:IsA("RemoteEvent") or node:IsA("RemoteFunction")) then return node end
    end
    return nil
end

---@return Instance?  remote, nil and gated as "Net.<name>" when it is gone
local function NeedRemote(folder, name)
    local remote = Need(folder, name)
    if remote then return remote end

    remote = SearchRemote(name)
    if remote then
        table.remove(State.Missing, table.find(State.Missing, name))
        return remote
    end
    GameLib.Missing["Net." .. name] = true
    return nil
end

local GameRemotes = Need(Need(ReplicatedStorage, "Remotes"), "Game")
if not GameRemotes then
    xDTaraZ.Util.Alert("Ride A Pet was updated and this script needs an update too. Join discord.gg/FHVfmeSceA", "missing " .. table.concat(State.Missing, ", "))
    return
end
local PlotRemotes = Need(GameRemotes, "Plot")

xDTaraZ.Net = {
    EggPickup = NeedRemote(GameRemotes, "EggPickup"),
    EggArrivalClaim = NeedRemote(GameRemotes, "EggArrivalClaim"),
    EggPlaced = NeedRemote(GameRemotes, "EggPlaced"),
    Hatch = NeedRemote(GameRemotes, "Hatch"),
    PlacePet = NeedRemote(GameRemotes, "PlacePet"),
    PickupPet = NeedRemote(GameRemotes, "PickupPet"),
    PetCollect = NeedRemote(GameRemotes, "PetCollect"),
    FeedPet = NeedRemote(GameRemotes, "FeedPet"),
    Rebirth = NeedRemote(GameRemotes, "Rebirth"),
    Upgrades = NeedRemote(PlotRemotes, "Upgrades"),
    ClaimIndexReward = NeedRemote(GameRemotes, "ClaimIndexReward"),
    OfflineEarnings = NeedRemote(GameRemotes, "OfflineEarnings"),
    BuyWithCash = NeedRemote(GameRemotes, "BuyWithCash"),
    SetOpenShop = NeedRemote(GameRemotes, "SetOpenShop"),
    ShopStock = NeedRemote(GameRemotes, "ShopStock"),
    Restock = NeedRemote(GameRemotes, "Restock"),
    ClaimGroupReward = NeedRemote(Need(ReplicatedStorage:FindFirstChild("Remotes"), "Reusable"), "ClaimGroupReward"),
    FusionAction = NeedRemote(GameRemotes, "FusionAction"),
    FusionPetPlace = NeedRemote(GameRemotes, "FusionPetPlace"),
    SellItems = NeedRemote(GameRemotes, "SellItems"),
    ConfirmRequest = NeedRemote(GameRemotes, "ConfirmRequest"),
}

do
    local packages = ReplicatedStorage:FindFirstChild("packages")
    local netPackage = packages and packages:FindFirstChild("Net")
    xDTaraZ.Net.VolcanoDip = NeedRemote(netPackage, "RE/VolcanoDip")
    xDTaraZ.Net.VolcanoDipResult = NeedRemote(netPackage, "RE/VolcanoDipResult")
    xDTaraZ.Net.VolcanoDipCancelled = NeedRemote(netPackage, "RE/VolcanoDipCancelled")
end

local GameData = Need(ReplicatedStorage, "GameData")
local dataModules = {}
for _, name in ipairs(Config.DataModules) do
    dataModules[name] = Need(GameData, name) or false
end

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

---@return any?  module, nil when no identity can require it
function GameLib.Require(module)
    local ok, loaded = pcall(require, module)
    if ok then return loaded end
    local retried, again = GameLib.RequireAsGame(module)
    if retried then return again end
    warn(Config.Tag, "require " .. module.Name .. ":", loaded)
    return nil
end

for name, module in pairs(dataModules) do
    local loaded = module and GameLib.Require(module)
    if type(loaded) ~= "table" then GameLib.Missing[name] = true end
    GameLib[name] = type(loaded) == "table" and loaded or {}
end

if #State.Missing > 0 then
    warn(Config.Tag, "missing after a game update, related features are off:", table.concat(State.Missing, ", "))
end

xDTaraZ.EggInfo = {}
xDTaraZ.EggNames = {}
xDTaraZ.Rarities = {}
xDTaraZ.RarityRank = {}
xDTaraZ.PetRarities = {}
xDTaraZ.FoodNames = {}

function xDTaraZ.BuildLists()
    table.clear(xDTaraZ.EggInfo)
    table.clear(xDTaraZ.EggNames)
    table.clear(xDTaraZ.Rarities)
    table.clear(xDTaraZ.RarityRank)
    table.clear(xDTaraZ.FoodNames)

    local rarityFloor = {}
    for name, info in pairs(GameLib.Eggs) do
        local rarity = info.Rarity or "Common"
        local luck = tonumber(info.Luck) or math.huge
        xDTaraZ.EggInfo[name] = { Rarity = rarity, Luck = luck, Growth = tonumber(info.GrowthTime) or 0 }
        xDTaraZ.EggNames[#xDTaraZ.EggNames + 1] = name
        rarityFloor[rarity] = math.min(rarityFloor[rarity] or math.huge, luck)
    end
    table.sort(xDTaraZ.EggNames, function(a, b) return xDTaraZ.EggInfo[a].Luck > xDTaraZ.EggInfo[b].Luck end)

    for rarity in pairs(rarityFloor) do
        xDTaraZ.Rarities[#xDTaraZ.Rarities + 1] = rarity
    end
    table.sort(xDTaraZ.Rarities, function(a, b) return rarityFloor[a] < rarityFloor[b] end)
    for index, rarity in ipairs(xDTaraZ.Rarities) do
        xDTaraZ.RarityRank[rarity] = index
    end
    xDTaraZ.HuntDefault = table.find(xDTaraZ.Rarities, "Mythic") and "Mythic" or xDTaraZ.Rarities[math.max(#xDTaraZ.Rarities - 1, 1)]

    local petFloor = {}
    for _, info in pairs(GameLib.Pets) do
        if type(info) ~= "table" or not info.Rarity then continue end
        petFloor[info.Rarity] = math.min(petFloor[info.Rarity] or math.huge, tonumber(info.Income) or 0)
    end
    table.clear(xDTaraZ.PetRarities)
    for rarity in pairs(petFloor) do
        xDTaraZ.PetRarities[#xDTaraZ.PetRarities + 1] = rarity
    end
    table.sort(xDTaraZ.PetRarities, function(a, b) return petFloor[a] < petFloor[b] end)

    for name in pairs(GameLib.Foods) do
        xDTaraZ.FoodNames[#xDTaraZ.FoodNames + 1] = name
    end
    table.sort(xDTaraZ.FoodNames, function(a, b) return (GameLib.Foods[a].XP or 0) > (GameLib.Foods[b].XP or 0) end)
end
xDTaraZ.BuildLists()

xDTaraZ.Player = { Client = LocalPlayer, Parts = {} }

function xDTaraZ.Player:Bind(character)
    self.Character = character
    self.Humanoid = character:WaitForChild("Humanoid", Config.LoadTimeout)
    self.Root = character:WaitForChild("HumanoidRootPart", Config.LoadTimeout)
    table.clear(self.Parts)
    table.clear(State.CollidePatch)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then self.Parts[#self.Parts + 1] = part end
    end
    if self.CharConn then self.CharConn:Disconnect() end
    self.CharConn = character.DescendantAdded:Connect(function(part)
        if part:IsA("BasePart") then self.Parts[#self.Parts + 1] = part end
    end)
    if self.Humanoid then
        xDTaraZ.Move.Saved.WalkSpeed = xDTaraZ.Move.Saved.WalkSpeed or self.Humanoid.WalkSpeed
        xDTaraZ.Move.Saved.JumpPower = xDTaraZ.Move.Saved.JumpPower or self.Humanoid.JumpPower
    end
end

function xDTaraZ.Player:IsAlive()
    return self.Humanoid ~= nil and self.Humanoid.Health > 0 and self.Root ~= nil and self.Root.Parent ~= nil
end

function xDTaraZ:Connect(signal, handler)
    local conn = signal:Connect(handler)
    table.insert(self.State.Connections, conn)
    return conn
end

function xDTaraZ:SetStatus(text)
    State.Status = text
end

---@return boolean  got the character lock
function xDTaraZ:Acquire(owner, patience)
    local deadline = osClock() + (patience or 0)
    while State.Lock and State.Lock ~= owner do
        if osClock() > deadline or not State.Alive then return false end
        task.wait(0.05)
    end
    State.Lock = owner
    return true
end

function xDTaraZ:Release(owner)
    if State.Lock == owner then State.Lock = nil end
end

---@return boolean ok, any err
function xDTaraZ:WithLock(owner, patience, fn, ...)
    if not self:Acquire(owner, patience) then return false, "busy" end
    local ok, err = pcall(fn, ...)
    self:Release(owner)
    if not ok then warn(Config.Tag, owner .. ":", err) end
    return ok, err
end

function xDTaraZ:TrollActive()
    return self.Options.Fling or self.Options.Stick
end

function xDTaraZ:Saved()
    return LocalPlayer:FindFirstChild("SavedData")
end

function xDTaraZ:Cash()
    local saved = self:Saved()
    return saved and saved.Cash.Value or 0
end

function xDTaraZ:Rebirths()
    local saved = self:Saved()
    return saved and saved.Rebirths.Value or 0
end

function xDTaraZ:GetPlot()
    if State.Plot and State.Plot.Parent then return State.Plot end
    local plots = Workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in ipairs(plots:GetChildren()) do
        local data = plot:FindFirstChild("Data")
        local owner = data and data:FindFirstChild("Owner")
        if owner and owner.Value == LocalPlayer then
            State.Plot = plot
            return plot
        end
    end
end

---@return CFrame?  standing spot on own plot
function xDTaraZ:HomeCFrame()
    local plot = self:GetPlot()
    local base = plot and plot:FindFirstChild("Baseplate")
    if not base then return nil end
    return base.CFrame + vector3New(0, base.Size.Y / 2 + Config.HomeHover, 0)
end

function xDTaraZ:MoveTo(cf)
    local player = self.Player
    if not cf or not player:IsAlive() then return false end
    player.Root.AssemblyLinearVelocity = Vector3.zero
    player.Root.CFrame = cf
    return true
end

function xDTaraZ:BasketCount()
    local basket = LocalPlayer:FindFirstChild("Basket")
    return basket and #basket:GetChildren() or 0
end

function xDTaraZ:BasketCapacity()
    local saved = self:Saved()
    local info = GameLib.EggBaskets[saved and saved.EquippedEggBasket.Value or "Wooden"]
    local capacity = type(info) == "table" and tonumber(info.Capacity) or 1
    return math.min(capacity, Config.ClaimBatch)
end

xDTaraZ.Eggs = {}

---@return boolean  passes hunter/rarity/name/luck filters
function xDTaraZ.Eggs.Wanted(eggName)
    local info = xDTaraZ.EggInfo[eggName]
    if not info then return false end
    local opts = xDTaraZ.Options
    if opts.EggHunter then
        local floor = xDTaraZ.RarityRank[opts.HuntMinRarity or xDTaraZ.HuntDefault] or 1
        if (xDTaraZ.RarityRank[info.Rarity] or 1) < floor then return false end
    end
    local rarities = opts.EggRarities
    if rarities and next(rarities) and not rarities[info.Rarity] then return false end
    local names = opts.EggNames
    if names and next(names) and not names[eggName] then return false end
    if opts.SmartEggs and info.Luck <= State.StockFloor then return false end
    return info.Luck >= (opts.MinLuck or 0)
end

---@return number  luck an egg must beat once the bag holds EggStock eggs
function xDTaraZ.Eggs.StockFloor()
    local tools = xDTaraZ.Hatch.EggTools()
    if #tools < Config.EggStock then return 0 end
    local lucks = table.create(#tools)
    for i, tool in ipairs(tools) do
        local info = xDTaraZ.Hatch.ToolEgg(tool)
        lucks[i] = info and info.Luck or 0
    end
    table.sort(lucks, function(a, b) return a > b end)
    return lucks[Config.EggStock]
end

---@return Instance[]  pickable wanted eggs, best first (cached briefly)
function xDTaraZ.Eggs.Available()
    local now = osClock()
    if State.Snapshot and now - State.SnapshotAt < Config.SnapshotTtl then return State.Snapshot end

    State.StockFloor = xDTaraZ.Options.SmartEggs and xDTaraZ.Eggs.StockFloor() or 0
    local folder = ReplicatedStorage:FindFirstChild("ServerData")
    folder = folder and folder:FindFirstChild("ActiveEggs")
    local list = {}
    if folder then
        local serverNow = Workspace:GetServerTimeNow()
        for _, egg in ipairs(folder:GetChildren()) do
            local name = egg:GetAttribute("Egg")
            local private = egg:GetAttribute("PrivateTo")
            if not name or not egg:GetAttribute("Position") then continue end
            if private and private ~= LocalPlayer.UserId then continue end
            if (tonumber(egg:GetAttribute("DropEndsAt")) or 0) > serverNow then continue end
            if (State.EggSkip[egg.Name] or 0) > now then continue end
            if not xDTaraZ.Eggs.Wanted(name) then continue end
            list[#list + 1] = { egg, xDTaraZ.EggInfo[name].Luck * (egg:GetAttribute("Weight") or 1) }
        end
        table.sort(list, function(a, b) return a[2] > b[2] end)
        for i, pair in ipairs(list) do list[i] = pair[1] end
    end

    State.Snapshot, State.SnapshotAt = list, now
    return list
end

---@param kind string  server reply to wait for ("PickedUp" or "Deposited")
---@return boolean     the server answered with that reply since State.PickReply was cleared
function xDTaraZ.Eggs.Answered(kind)
    local reply = State.PickReply
    return reply ~= nil and reply.kind == kind
end

---@return boolean  another player took the egg first
function xDTaraZ.Eggs.Gone()
    local reply = State.PickReply
    return reply ~= nil and reply.kind == "Refused" and tostring(reply.detail):find("already gone", 1, true) ~= nil
end

---@return boolean  picked up
function xDTaraZ.Eggs.Pickup(egg)
    local before = xDTaraZ:BasketCount()
    State.PickReply = nil
    xDTaraZ:MoveTo(cframeNew(egg:GetAttribute("Position") + vector3New(0, Config.EggHover, 0)))

    local deadline = osClock() + Config.PickupWait
    local got = false
    repeat
        xDTaraZ.Net.EggPickup:FireServer(egg.Name)
        task.wait(Config.RetryGap)
        got = xDTaraZ.Eggs.Answered("PickedUp") or xDTaraZ:BasketCount() > before
    until got or xDTaraZ.Eggs.Answered("BasketFull") or xDTaraZ.Eggs.Gone() or osClock() > deadline
    if not got then State.EggSkip[egg.Name] = osClock() + Config.EggSkipFor end
    return got
end

---@return boolean  basket emptied
function xDTaraZ.Eggs.Deliver()
    if xDTaraZ:BasketCount() == 0 then return true end
    if not xDTaraZ:MoveTo(xDTaraZ:HomeCFrame()) then return false end
    State.PickReply = nil

    local deadline = osClock() + Config.DeliverWait
    repeat
        local names = {}
        for _, egg in ipairs(LocalPlayer.Basket:GetChildren()) do
            names[#names + 1] = egg.Name
            if #names >= Config.ClaimBatch then break end
        end
        if #names == 0 then return true end
        xDTaraZ.Net.EggArrivalClaim:FireServer(Workspace:GetServerTimeNow(), xDTaraZ.Player.Root.Position, names)
        task.wait(Config.RetryGap)
    until xDTaraZ.Eggs.Answered("Deposited") or xDTaraZ:BasketCount() == 0 or osClock() > deadline
    return xDTaraZ.Eggs.Answered("Deposited") or xDTaraZ:BasketCount() == 0
end

xDTaraZ.Volcano = {}

---@return BasePart?  volcano part, streamed in first when it is far away
function xDTaraZ.Volcano.Part(name)
    local volcano = Workspace:FindFirstChild("Volcano")
    local part = volcano and volcano:FindFirstChild(name)
    if part then return part end
    pcall(LocalPlayer.RequestStreamAroundAsync, LocalPlayer, Config.VolcanoSpot, Config.VolcanoStream)
    volcano = Workspace:FindFirstChild("Volcano")
    return volcano and volcano:FindFirstChild(name)
end

function xDTaraZ.Volcano.Done()
    return LocalPlayer:GetAttribute("VolcanoValidated") == true
end

---@return boolean  the volcano climb counts as finished
function xDTaraZ.Volcano.Validate()
    if xDTaraZ.Volcano.Done() then return true end
    for _, step in ipairs({ { "VolcanoEntrance" }, { "VolcanoValidate", "InVolcano" }, { "VolcanoTop", "VolcanoValidated" } }) do
        local part = xDTaraZ.Volcano.Part(step[1])
        if not part or not xDTaraZ:MoveTo(part.CFrame) then return false end
        task.wait(Config.VolcanoSettle)
        firetouchinterest(xDTaraZ.Player.Root, part, 0)
        task.wait(Config.TouchGap)
        firetouchinterest(xDTaraZ.Player.Root, part, 1)
        if not step[2] then
            task.wait(Config.VolcanoStep)
            continue
        end
        local deadline = osClock() + Config.VolcanoWait
        repeat task.wait() until LocalPlayer:GetAttribute(step[2]) or osClock() > deadline
        if not LocalPlayer:GetAttribute(step[2]) then return false end
    end
    return xDTaraZ.Volcano.Done()
end

function xDTaraZ.Volcano.ValidateNow()
    local origin = xDTaraZ.Player.Root and xDTaraZ.Player.Root.CFrame
    xDTaraZ:WithLock("eggs", Config.LockWait, function()
        local done = xDTaraZ.Volcano.Validate()
        xDTaraZ:SetStatus(done and "Volcano climb done" or "Volcano climb failed")
    end)
    if origin then xDTaraZ:MoveTo(origin) end
end

---@return Instance?  basket egg that can still be dipped in time
function xDTaraZ.Volcano.NextDip()
    local basket = LocalPlayer:FindFirstChild("Basket")
    local rarities = xDTaraZ.Options.DipRarities
    local now = Workspace:GetServerTimeNow()
    for _, egg in ipairs(basket and basket:GetChildren() or {}) do
        if egg:GetAttribute("VolcanoDipped") then continue end
        local info = xDTaraZ.EggInfo[egg:GetAttribute("Egg") or ""]
        if rarities and next(rarities) and not (info and rarities[info.Rarity]) then continue end
        if (tonumber(egg:GetAttribute("BreakAt")) or math.huge) - now < Config.DipMinLeft then continue end
        return egg
    end
    return nil
end

---@return number  eggs dipped
function xDTaraZ.Volcano.DipBasket()
    if not (xDTaraZ.Net.VolcanoDip and xDTaraZ.Volcano.NextDip()) then return 0 end
    if not xDTaraZ.Volcano.Validate() then return 0 end
    local top = xDTaraZ.Volcano.Part("VolcanoTop")
    if not top then return 0 end

    local dips = 0
    for _ = 1, xDTaraZ:BasketCount() do
        if not xDTaraZ.Volcano.NextDip() or not xDTaraZ.Player:IsAlive() then break end
        xDTaraZ:MoveTo(top.CFrame + vector3New(0, Config.HomeHover, 0))
        task.wait(Config.TeleportSettle)
        xDTaraZ:SetStatus("Dipping egg in the volcano")
        State.DipReply = nil
        xDTaraZ.Net.VolcanoDip:FireServer()
        local deadline = osClock() + Config.DipWait
        repeat task.wait(0.2) until State.DipReply or osClock() > deadline
        local reply = State.DipReply
        if type(reply) ~= "table" or reply.Cancelled then break end
        local back = (tonumber(reply.ArriveAt) or 0) - Workspace:GetServerTimeNow()
        if back > 0 then task.wait(math.min(back + Config.TeleportSettle, Config.DipWait)) end
        dips += 1
        if reply.Success then State.MagmaEggs += 1 end
    end
    return dips
end

---@return boolean  basket emptied at home, eggs dipped first when Volcano Dip is on
function xDTaraZ.Eggs.Bank()
    if xDTaraZ.Options.VolcanoDip then xDTaraZ.Volcano.DipBasket() end
    for _ = 1, Config.DeliverTries do
        if xDTaraZ.Eggs.Deliver() then return true end
    end
    return false
end

---@return boolean  an egg in the basket breaks soon unless it goes home now
function xDTaraZ.Eggs.Urgent()
    local basket = LocalPlayer:FindFirstChild("Basket")
    local now = Workspace:GetServerTimeNow()
    for _, egg in ipairs(basket and basket:GetChildren() or {}) do
        if (tonumber(egg:GetAttribute("BreakAt")) or math.huge) - now < Config.DeliverMargin then return true end
    end
    return false
end

---@return boolean  the volcano climb is done, finishing it first when a Volcanic Egg needs it
function xDTaraZ.Volcano.Ready()
    if xDTaraZ.Volcano.Done() then return true end
    if not (Library and Library.Compat and Library.Compat.Caps.Touch) then return false end
    xDTaraZ:SetStatus("Finishing volcano climb")
    return xDTaraZ.Volcano.Validate()
end

---@param manual boolean  Collect Now press, ignores the farm toggles
---@return number         eggs picked up this run
function xDTaraZ.Eggs.Run(manual)
    local opts = xDTaraZ.Options
    local origin = xDTaraZ.Player.Root.CFrame
    local capacity = xDTaraZ:BasketCapacity()
    local got = 0

    for _, egg in ipairs(xDTaraZ.Eggs.Available()) do
        if not State.Alive or not xDTaraZ.Player:IsAlive() or xDTaraZ:TrollActive() then break end
        if not manual and not (opts.AutoEggs or opts.EggHunter) then break end
        if not egg.Parent then continue end
        local info = xDTaraZ.EggInfo[egg:GetAttribute("Egg")]
        if info and info.RequiresVolcano and not xDTaraZ.Volcano.Ready() then continue end
        xDTaraZ:SetStatus("Grabbing " .. egg:GetAttribute("Egg"))
        if xDTaraZ.Eggs.Pickup(egg) then got += 1 end
        local goHome = xDTaraZ:BasketCount() >= capacity or (xDTaraZ:BasketCount() > 0 and xDTaraZ.Eggs.Urgent())
        if goHome and not xDTaraZ.Eggs.Bank() then
            State.DeliverFailUntil = osClock() + Config.DeliverBackoff
            xDTaraZ:SetStatus("Delivery refused, retrying soon")
            break
        end
    end
    if xDTaraZ:BasketCount() > 0 and not xDTaraZ.Eggs.Bank() then
        State.DeliverFailUntil = osClock() + Config.DeliverBackoff
    end

    State.Snapshot = nil
    State.EggsCollected += got
    if opts.ReturnAfter and got > 0 then xDTaraZ:MoveTo(origin) end
    if osClock() > State.DeliverFailUntil then
        xDTaraZ:SetStatus(got > 0 and ("Collected " .. got .. " eggs") or "Waiting for eggs")
    end
    return got
end

---@return number  eggs picked up
function xDTaraZ.Eggs.CollectNow()
    if not xDTaraZ.Player:IsAlive() then return 0 end
    local got = 0
    xDTaraZ:WithLock("eggs", Config.LockWait, function() got = xDTaraZ.Eggs.Run(true) end)
    return got
end

function xDTaraZ.Eggs.Step()
    local opts = xDTaraZ.Options
    if opts.VolcanoObby and not xDTaraZ.Volcano.Done() and osClock() > State.ObbyRetryAt and not xDTaraZ:TrollActive() then
        State.ObbyRetryAt = osClock() + Config.ObbyRetry
        xDTaraZ.Volcano.ValidateNow()
    end
    if not opts.AutoEggs and not opts.EggHunter then return end
    if xDTaraZ:TrollActive() or osClock() < State.DeliverFailUntil then return end

    if #xDTaraZ.Eggs.Available() > 0 then
        State.EmptySince = nil
        if opts.EggHunter then State.HuntHops = 0 end
        xDTaraZ:WithLock("eggs", 0, xDTaraZ.Eggs.Run)
        return
    end

    State.EmptySince = State.EmptySince or osClock()
    if not opts.EggHunter then
        xDTaraZ:SetStatus("Waiting for eggs")
        return
    end
    local left = Config.HuntHopAfter - (osClock() - State.EmptySince)
    xDTaraZ:SetStatus(string.format("No rare eggs here, hopping in %ds", math.max(0, math.ceil(left))))
    if left <= 0 and not State.Hopping then xDTaraZ.Server.HuntHop() end
end

xDTaraZ.Hatch = {}

function xDTaraZ.Hatch.EggTools()
    local tools = {}
    for _, holder in ipairs({ LocalPlayer:FindFirstChild("Backpack"), xDTaraZ.Player.Character }) do
        if not holder then continue end
        for _, tool in ipairs(holder:GetChildren()) do
            if tool:IsA("Tool") and tool:GetAttribute("EggInventoryId") then tools[#tools + 1] = tool end
        end
    end
    return tools
end

function xDTaraZ.Hatch.ToolEgg(tool)
    return xDTaraZ.EggInfo[tool.Name:match("^(.-Egg)") or ""]
end

function xDTaraZ.Hatch.MyEggs()
    local plot = xDTaraZ:GetPlot()
    local folder = plot and plot:FindFirstChild("Eggs")
    local eggs = {}
    if not folder then return eggs end
    for _, egg in ipairs(folder:GetChildren()) do
        if egg:GetAttribute("EggKey") and egg:GetAttribute("OwnerUserId") == LocalPlayer.UserId then eggs[#eggs + 1] = egg end
    end
    return eggs
end

---@return boolean  timer shows finished; eggs without a loaded timer wait for the periodic sweep
function xDTaraZ.Hatch.IsReady(egg)
    for _, label in ipairs(egg:GetDescendants()) do
        if label.Name == "Timer" and label:IsA("TextLabel") then
            local text = label.Text
            return not text:find("[1-9]")
        end
    end
    return false
end

function xDTaraZ.Hatch.FreeNests()
    local plot = xDTaraZ:GetPlot()
    local nests = plot and plot:FindFirstChild("Nests")
    local free = {}
    if not nests then return free end
    for _, nest in ipairs(nests:GetChildren()) do
        if nest:GetAttribute("Unlocked") and not nest:GetAttribute("Occupied") and (State.NestSkip[nest] or 0) < osClock() then
            free[#free + 1] = nest
        end
    end
    return free
end

---@return boolean  the game lets you plant eggs anywhere on your plot instead of nests
function xDTaraZ.Hatch.NoNest()
    return LocalPlayer:GetAttribute("NoNest") == true
end

---@return number  eggs that still fit; in plant mode the cap is learned from the server and rechecked every minute
function xDTaraZ.Hatch.Room()
    if not xDTaraZ.Hatch.NoNest() then return #xDTaraZ.Hatch.FreeNests() end
    local cap = State.PlotCap
    if not cap or osClock() - State.PlotCapAt > Config.PlotCapRecheck then cap = Config.PlotCapGuess end
    return math.max(0, cap - #xDTaraZ.Hatch.MyEggs())
end

---@return Vector3[]  free planting spots on your plot, kept apart from eggs already there
function xDTaraZ.Hatch.PlantSpots(count)
    local plot = xDTaraZ:GetPlot()
    local base = plot and plot:FindFirstChild("Baseplate")
    if not base or count < 1 then return {} end
    local top = base.Position.Y + base.Size.Y / 2
    local taken = {}
    for _, egg in ipairs(xDTaraZ.Hatch.MyEggs()) do
        local pos = egg:GetPivot().Position
        taken[#taken + 1] = vector3New(pos.X, top, pos.Z)
    end

    local spots = {}
    local half = base.Size * Config.PlantSpread
    for x = -half.X, half.X, Config.PlantGap do
        for z = -half.Z, half.Z, Config.PlantGap do
            local flat = (base.CFrame * cframeNew(x, 0, z)).Position
            local pos = vector3New(flat.X, top, flat.Z)
            local clear = true
            for _, other in ipairs(taken) do
                if (other - pos).Magnitude < Config.PlantGap then
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

---@return number  eggs planted; stops and remembers the cap when the server refuses one
function xDTaraZ.Hatch.Plant(tools)
    local spots = xDTaraZ.Hatch.PlantSpots(math.min(xDTaraZ.Hatch.Room(), #tools))
    if #spots == 0 then return 0 end
    xDTaraZ:MoveTo(xDTaraZ:HomeCFrame())
    task.wait(Config.TeleportSettle)

    local placed = 0
    for _, pos in ipairs(spots) do
        local tool = table.remove(tools, 1)
        if not tool or not xDTaraZ.Player:IsAlive() then break end
        local before = #xDTaraZ.Hatch.MyEggs()
        xDTaraZ:SetStatus("Placing " .. tool.Name)
        xDTaraZ.Player.Humanoid:EquipTool(tool)
        task.wait(Config.EquipSettle)
        xDTaraZ.Net.EggPlaced:FireServer({ PlantPosition = pos })
        local deadline = osClock() + Config.PlantWait
        repeat task.wait(0.05) until #xDTaraZ.Hatch.MyEggs() > before or osClock() > deadline
        if #xDTaraZ.Hatch.MyEggs() == before then
            State.PlotCap, State.PlotCapAt = before, osClock()
            break
        end
        placed += 1
    end
    return placed
end

function xDTaraZ.Hatch.Place()
    local tools = xDTaraZ.Hatch.EggTools()
    if #tools == 0 or xDTaraZ.Hatch.Room() == 0 then return end

    local fastest = xDTaraZ.Options.FastestFirst
    local function Rank(tool)
        local info = xDTaraZ.Hatch.ToolEgg(tool)
        if not info then return -math.huge end
        return fastest and -info.Growth or info.Luck
    end
    table.sort(tools, function(a, b) return Rank(a) > Rank(b) end)

    local origin = xDTaraZ.Player.Root.CFrame
    local placed = 0
    local nests = xDTaraZ.Hatch.NoNest() and {} or xDTaraZ.Hatch.FreeNests()
    if xDTaraZ.Hatch.NoNest() then placed = xDTaraZ.Hatch.Plant(tools) end
    for _, nest in ipairs(nests) do
        local tool = table.remove(tools, 1)
        if not tool or not xDTaraZ.Player:IsAlive() then break end
        xDTaraZ:SetStatus("Placing " .. tool.Name)
        xDTaraZ:MoveTo(nest:GetPivot() + vector3New(0, Config.NestHover, 0))
        task.wait(Config.TeleportSettle)
        xDTaraZ.Player.Humanoid:EquipTool(tool)
        task.wait(Config.EquipSettle)
        xDTaraZ.Net.EggPlaced:FireServer({ NestId = nest.Name })
        task.wait(Config.PlaceGap)
        if nest:GetAttribute("Occupied") then
            placed += 1
        else
            State.NestSkip[nest] = osClock() + Config.NestSkipFor
        end
    end
    xDTaraZ.Player.Humanoid:UnequipTools()
    xDTaraZ:MoveTo(origin)
    xDTaraZ:SetStatus(placed > 0 and ("Placed " .. placed .. " eggs") or "Idle")
end

function xDTaraZ.Hatch.PlaceNow()
    xDTaraZ:WithLock("place", Config.LockWait, xDTaraZ.Hatch.Place)
end

---@param force boolean?  ignore the timer check
---@return number ready, number total  eggs past their timer, eggs on the nests
function xDTaraZ.Hatch.HatchNow(force)
    local eggs = xDTaraZ.Hatch.MyEggs()
    local ready = 0
    for _, egg in ipairs(eggs) do
        local isReady = xDTaraZ.Hatch.IsReady(egg)
        if isReady then ready += 1 end
        if force or isReady then
            xDTaraZ.Net.Hatch:FireServer({ EggKey = egg:GetAttribute("EggKey") })
        end
    end
    return ready, #eggs
end

function xDTaraZ.Hatch.ReportHatch(ready, total)
    if ready > 0 then
        xDTaraZ:SetStatus("Hatching " .. ready .. " eggs")
        return
    end
    local status = State.Status
    if not (status:find("^Plac") or status:find("^Hatching")) then return end
    xDTaraZ:SetStatus(total > 0 and "Nothing ready" or "Idle")
end

function xDTaraZ.Hatch.Step()
    local opts, now = xDTaraZ.Options, osClock()
    if opts.AutoPlaceEggs and not xDTaraZ:TrollActive() and xDTaraZ.Hatch.Room() > 0 and #xDTaraZ.Hatch.EggTools() > 0 then
        xDTaraZ:WithLock("place", 0, xDTaraZ.Hatch.Place)
    end
    if opts.AutoHatch and now - State.LastHatch > Config.HatchGap then
        State.LastHatch = now
        local sweep = now - State.LastHatchAll > Config.HatchRetry
        if sweep then State.LastHatchAll = now end
        xDTaraZ.Hatch.ReportHatch(xDTaraZ.Hatch.HatchNow(sweep))
    end
end

xDTaraZ.Pets = {}

---@return number  income per second estimate (weight and mutations included); one value per pet whether it is held or placed
function xDTaraZ.Pets.Score(inst)
    local key = inst:GetAttribute("PetKey")
    local known = key and State.PetScores[key]
    if known then return known end
    local info = GameLib.Pets[inst:GetAttribute("PetName") or ""]
    local income = type(info) == "table" and tonumber(info.Income) or 0
    local factor = 1
    for _, attr in ipairs({ "Mutation", "SpawnMutation" }) do
        local mutation = GameLib.Mutations[inst:GetAttribute(attr) or ""]
        if type(mutation) == "table" then factor *= 1 + (tonumber(mutation.StatMultiplier) or 0) / 100 end
    end
    local score = income * (inst:GetAttribute("Weight") or 1) * factor
    if key and typeof(inst) == "Instance" then State.PetScores[key] = score end
    return score
end

---@return table[]  { inst, score } sorted
function xDTaraZ.Pets.Ranked(list, ascending)
    local ranked = table.create(#list)
    for i, inst in ipairs(list) do ranked[i] = { inst, xDTaraZ.Pets.Score(inst) } end
    table.sort(ranked, function(a, b)
        if ascending then return a[2] < b[2] end
        return a[2] > b[2]
    end)
    return ranked
end

---@return table?  the game's pet renderer, which holds every pet standing on a ranch
function xDTaraZ.Pets.Renderer()
    if GameLib.PetRenderer ~= nil then return GameLib.PetRenderer or nil end
    local scripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local module = scripts and scripts:FindFirstChild("PetRenderer", true)
    GameLib.PetRenderer = module and GameLib.Require(module) or false
    return GameLib.PetRenderer or nil
end

---@return table[]  placed pets as objects with GetAttribute, read from the renderer (newer game) or the plot folder (older game)
function xDTaraZ.Pets.Placed()
    local list = {}
    local renderer = xDTaraZ.Pets.Renderer()
    local ok, all = pcall(function() return renderer and renderer.GetAll() end)
    if ok and type(all) == "table" then
        for _, entry in pairs(all) do
            if entry.OwnerUserId == LocalPlayer.UserId and entry.PetKey then
                list[#list + 1] = {
                    GetAttribute = function(_, name)
                        if name == "PetName" then return entry.Model and entry.Model.Name end
                        if name == "Weight" then return entry.BaseWeight or entry.Weight end
                        return entry[name]
                    end,
                }
            end
        end
        if #list > 0 then return list end
    end

    local plot = xDTaraZ:GetPlot()
    local folder = plot and plot:FindFirstChild("Pets")
    if not folder then return list end
    for _, pet in ipairs(folder:GetChildren()) do
        if pet:GetAttribute("OwnerUserId") == LocalPlayer.UserId and pet:GetAttribute("PetKey") then list[#list + 1] = pet end
    end
    return list
end

function xDTaraZ.Pets.Owned()
    local list = {}
    for _, holder in ipairs({ LocalPlayer:FindFirstChild("Backpack"), xDTaraZ.Player.Character }) do
        if not holder then continue end
        for _, tool in ipairs(holder:GetChildren()) do
            if tool:IsA("Tool") and tool:GetAttribute("PetKey") then list[#list + 1] = tool end
        end
    end
    return list
end

function xDTaraZ.Pets.MaxSlots()
    local saved = xDTaraZ:Saved()
    return tonumber(saved and saved.MaxPets.Value) or GameLib.Rebirths.BasePetCapacity or 5
end

function xDTaraZ.Pets.RandomSpot()
    local plot = xDTaraZ:GetPlot()
    local base = plot and plot:FindFirstChild("Baseplate")
    if not base then return nil end
    local half = base.Size * Config.PetSpread
    local offset = vector3New((math.random() * 2 - 1) * half.X, base.Size.Y / 2 + Config.PetLift, (math.random() * 2 - 1) * half.Z)
    return (base.CFrame * cframeNew(offset)).Position
end

---@return boolean  changed something
function xDTaraZ.Pets.EquipBest()
    if osClock() < State.PetFailUntil then return false end
    local placed = xDTaraZ.Pets.Ranked(xDTaraZ.Pets.Placed(), true)
    local owned = xDTaraZ.Pets.Ranked(xDTaraZ.Pets.Owned(), false)
    local free = xDTaraZ.Pets.MaxSlots() - #placed
    local before = #placed
    local acted = false

    for _, pair in ipairs(owned) do
        local tool, score = pair[1], pair[2]
        local spot = xDTaraZ.Pets.RandomSpot()
        if not spot then return false end
        if free > 0 then
            xDTaraZ.Net.PlacePet:FireServer(tool:GetAttribute("PetKey"), spot)
            free -= 1
            acted = true
            task.wait(Config.PlaceGap)
            continue
        end
        local worst = placed[1]
        if not worst or score <= worst[2] * Config.SwapMargin then break end
        table.remove(placed, 1)
        xDTaraZ.Net.PickupPet:FireServer(worst[1]:GetAttribute("PetKey"))
        task.wait(Config.PlaceGap)
        xDTaraZ.Net.PlacePet:FireServer(tool:GetAttribute("PetKey"), spot)
        acted = true
        task.wait(Config.PlaceGap)
    end

    if acted and #xDTaraZ.Pets.Placed() < math.min(before + 1, xDTaraZ.Pets.MaxSlots()) and before < xDTaraZ.Pets.MaxSlots() then
        State.PetFailUntil = osClock() + Config.PetFailBackoff
    end
    return acted
end

function xDTaraZ.Pets.EquipBestNow()
    xDTaraZ:WithLock("pets", Config.LockWait, xDTaraZ.Pets.EquipBest)
end

function xDTaraZ.Pets.CollectNow()
    for _, pet in ipairs(xDTaraZ.Pets.Placed()) do
        xDTaraZ.Net.PetCollect:FireServer(pet:GetAttribute("PetKey"))
    end
end

function xDTaraZ.Pets.FoodTool()
    local allowed = xDTaraZ.Options.FoodTypes
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    for _, name in ipairs(xDTaraZ.FoodNames) do
        if allowed and next(allowed) and not allowed[name] then continue end
        local tool = (backpack and backpack:FindFirstChild(name)) or (xDTaraZ.Player.Character and xDTaraZ.Player.Character:FindFirstChild(name))
        if tool then return tool end
    end
end

function xDTaraZ.Pets.Feed()
    if not xDTaraZ.Pets.FoodTool() or not xDTaraZ.Player:IsAlive() then return end
    local origin = xDTaraZ.Player.Root.CFrame
    local home = xDTaraZ:HomeCFrame()
    if home then
        xDTaraZ:MoveTo(home)
        task.wait(Config.TeleportSettle)
    end
    for _, pair in ipairs(xDTaraZ.Pets.Ranked(xDTaraZ.Pets.Placed(), false)) do
        local food = xDTaraZ.Pets.FoodTool()
        if not food or not xDTaraZ.Player:IsAlive() then break end
        xDTaraZ.Player.Humanoid:EquipTool(food)
        task.wait(Config.EquipSettle)
        xDTaraZ.Net.FeedPet:FireServer(pair[1]:GetAttribute("PetKey"), food.Name, true)
        task.wait(Config.FeedGap)
    end
    if xDTaraZ.Player.Humanoid then xDTaraZ.Player.Humanoid:UnequipTools() end
    if home and xDTaraZ.Player:IsAlive() then xDTaraZ:MoveTo(origin) end
end

function xDTaraZ.Pets.FeedNow()
    xDTaraZ:WithLock("feed", Config.LockWait, xDTaraZ.Pets.Feed)
end

---@return Instance[]  pet tools matching the sell options, never favorites or the strongest SellKeepBest
function xDTaraZ.Pets.SellList()
    local opts = xDTaraZ.Options
    local rarities = opts.SellRarities
    local list = {}
    if not (rarities and next(rarities)) then return list end
    for rank, pair in ipairs(xDTaraZ.Pets.Ranked(xDTaraZ.Pets.Owned(), false)) do
        local tool = pair[1]
        local info = GameLib.Pets[tool:GetAttribute("PetName") or ""]
        if rank <= (opts.SellKeepBest or 0) then continue end
        if tool:GetAttribute("Favorited") == true then continue end
        if opts.SellKeepMutated and (tool:GetAttribute("Mutation") or tool:GetAttribute("SpawnMutation")) then continue end
        if type(info) == "table" and rarities[info.Rarity] then list[#list + 1] = tool end
    end
    return list
end

---@return Vector3?  where the seller stands
function xDTaraZ.Pets.SellerSpot()
    local stalls = Workspace:FindFirstChild("Stalls")
    local seller = stalls and stalls:FindFirstChild("Sell")
    local root = seller and seller:FindFirstChild("HumanoidRootPart", true)
    return root and (root.CFrame * cframeNew(0, 0, Config.SellStand)).Position
end

---@return number  pets sold, 0 when the seller refuses
function xDTaraZ.Pets.Sell()
    local list = xDTaraZ.Pets.SellList()
    local spot = xDTaraZ.Pets.SellerSpot()
    if #list == 0 or not spot or not xDTaraZ.Net.SellItems then return 0 end

    local keys = table.create(#list)
    for i, tool in ipairs(list) do keys[i] = tool:GetAttribute("PetKey") end
    local origin = xDTaraZ.Player.Root.CFrame
    xDTaraZ:SetStatus("Selling " .. #keys .. " pets")
    xDTaraZ:MoveTo(cframeNew(spot))
    task.wait(Config.TeleportSettle)

    State.SellReply, State.SellPending = nil, true
    xDTaraZ.Net.SellItems:FireServer({ Pets = keys, Eggs = {} })
    local deadline = osClock() + Config.SellWait
    repeat task.wait() until State.SellReply or osClock() > deadline
    State.SellPending = false
    xDTaraZ:MoveTo(origin)

    local reply = State.SellReply
    return type(reply) == "table" and tonumber(reply.Sold) or 0
end

function xDTaraZ.Pets.SellNow()
    local sold = 0
    xDTaraZ:WithLock("sell", Config.LockWait, function() sold = xDTaraZ.Pets.Sell() end)
    return sold
end

function xDTaraZ.Pets.Step()
    local opts, now = xDTaraZ.Options, osClock()
    if opts.AutoSell and now - State.LastSell > Config.SellEvery then
        State.LastSell = now
        xDTaraZ:WithLock("sell", 0, xDTaraZ.Pets.Sell)
    end
    if opts.AutoEquipBest then xDTaraZ:WithLock("pets", 0, xDTaraZ.Pets.EquipBest) end
    if opts.AutoCollectCash then xDTaraZ.Pets.CollectNow() end
    if opts.AutoFeed and now - State.LastFeed > Config.FeedGap * Config.FeedEvery then
        State.LastFeed = now
        xDTaraZ:WithLock("feed", 0, xDTaraZ.Pets.Feed)
    end
end

xDTaraZ.Fusion = {}

---@return Vector3?, table<number, Attachment>  where to stand at the console, and the four slot attachments
function xDTaraZ.Fusion.Machine()
    local functionals = Workspace:FindFirstChild("Functionals")
    local machine = functionals and functionals:FindFirstChild("Fusion")
    local slots, console = {}, nil
    for _, node in ipairs(machine and machine:GetDescendants() or {}) do
        local slot = node:IsA("Attachment") and node:GetAttribute("FusionSlot")
        if slot then slots[slot] = node end
        if node:IsA("ProximityPrompt") and node.Name == "OpenConsole" and node.Parent:IsA("Attachment") then console = node.Parent.WorldPosition end
    end
    return console, slots
end

---@param count number  pets needed
---@return Instance[]   cheapest matching pets, never favorites, never the strongest FuseKeepBest
function xDTaraZ.Fusion.Candidates(count)
    local opts = xDTaraZ.Options
    local rarities = opts.FuseRarities
    local picked = {}
    if not (rarities and next(rarities)) then return picked end
    local ranked = xDTaraZ.Pets.Ranked(xDTaraZ.Pets.Owned(), false)
    for rank = #ranked, 1, -1 do
        local tool = ranked[rank][1]
        local info = GameLib.Pets[tool:GetAttribute("PetName") or ""]
        if rank <= (opts.FuseKeepBest or 0) or #picked >= count then continue end
        if tool:GetAttribute("Favorited") == true then continue end
        if opts.FuseKeepMutated and (tool:GetAttribute("Mutation") or tool:GetAttribute("SpawnMutation")) then continue end
        if type(info) == "table" and rarities[info.Rarity] then picked[#picked + 1] = tool end
    end
    return picked
end

---@param fn function  runs once you are next to the console
function xDTaraZ.Fusion.AtConsole(spot, fn)
    local origin = xDTaraZ.Player.Root.CFrame
    xDTaraZ:MoveTo(cframeNew(spot + vector3New(0, Config.FuseLift, Config.FuseStand)))
    task.wait(Config.FuseSettle)
    fn()
    task.wait(Config.FuseReplyWait)
    xDTaraZ:MoveTo(origin)
end

---@return boolean  placed the missing pets, false when there are not enough matching pets
function xDTaraZ.Fusion.Fill(state, slots)
    local missing = {}
    for index = 1, Config.FuseSlots do
        if not state:FindFirstChild(tostring(index)) and slots[index] then missing[#missing + 1] = index end
    end
    local pets = xDTaraZ.Fusion.Candidates(#missing)
    if #pets < #missing then
        xDTaraZ:SetStatus(("Fusion needs %d more matching pets"):format(#missing - #pets))
        return false
    end
    local origin = xDTaraZ.Player.Root.CFrame
    for i, index in ipairs(missing) do
        xDTaraZ:MoveTo(cframeNew(slots[index].WorldPosition + vector3New(0, Config.FuseLift, Config.FuseStand)))
        task.wait(Config.FuseSettle)
        xDTaraZ.Player.Humanoid:EquipTool(pets[i])
        task.wait(Config.EquipSettle)
        xDTaraZ.Net.FusionPetPlace:FireServer(index)
        task.wait(Config.FuseReplyWait)
    end
    xDTaraZ.Player.Humanoid:UnequipTools()
    xDTaraZ:MoveTo(origin)
    return true
end

function xDTaraZ.Fusion.Run()
    local state = LocalPlayer:FindFirstChild("FusionSlots")
    local console, slots = xDTaraZ.Fusion.Machine()
    if not (state and console and xDTaraZ.Net.FusionAction and xDTaraZ.Net.FusionPetPlace) then return end

    local status = state:GetAttribute("FusionStatus")
    if status == "Waiting" then
        if Workspace:GetServerTimeNow() < (state:GetAttribute("EndsAt") or math.huge) then
            xDTaraZ:SetStatus(("Fusing, %ds left"):format((state:GetAttribute("EndsAt") or 0) - Workspace:GetServerTimeNow()))
            return
        end
        xDTaraZ.Fusion.AtConsole(console, function() xDTaraZ.Net.FusionAction:FireServer("Fuse") end)
    elseif status == "Result" then
        local result = LocalPlayer:FindFirstChild("FusionResult")
        local pet = result and result:FindFirstChild("Pet")
        local key = state:GetAttribute("FusionFailed") == true and state:GetAttribute("FusionResultKey") or (pet and pet:GetAttribute("PetKey"))
        if key then xDTaraZ.Fusion.AtConsole(console, function() xDTaraZ.Net.FusionAction:FireServer("Claim", key) end) end
    elseif (state:GetAttribute("Count") or 0) < Config.FuseSlots then
        xDTaraZ.Fusion.Fill(state, slots)
    elseif state:GetAttribute("Ready") == true then
        xDTaraZ.Fusion.AtConsole(console, function() xDTaraZ.Net.FusionAction:FireServer("Start") end)
    end
end

function xDTaraZ.Fusion.RunNow()
    xDTaraZ:WithLock("fusion", Config.LockWait, xDTaraZ.Fusion.Run)
end

function xDTaraZ.Fusion.Step()
    if not xDTaraZ.Options.AutoFusion then return end
    if osClock() - State.LastFusion < Config.FuseEvery then return end
    State.LastFusion = osClock()
    xDTaraZ:WithLock("fusion", 0, xDTaraZ.Fusion.Run)
end

xDTaraZ.Shop = {}

---@return string[]  "Category/Item" for every cash item in the stock shop, cheapest first
function xDTaraZ.Shop.Labels()
    local list = {}
    for category, items in pairs(GameLib.Shop.Categories or {}) do
        for name, config in pairs(type(items) == "table" and items or {}) do
            local price = type(config) == "table" and tonumber(config.Price) or 0
            if price > 0 and not (config.Source == "MiscGears") then list[#list + 1] = { category .. "/" .. name, price } end
        end
    end
    table.sort(list, function(a, b) return a[2] < b[2] end)
    for i, pair in ipairs(list) do list[i] = pair[1] end
    return list
end

---@return table?  stock table { [category] = { [item] = { InStock, Amount } } } as the server sees it now
function xDTaraZ.Shop.ReadStock()
    State.Stock = nil
    xDTaraZ.Net.ShopStock:FireServer()
    local deadline = osClock() + Config.ShopWait
    repeat task.wait(0.05) until State.Stock or osClock() > deadline
    return State.Stock
end

---@return number  items bought
function xDTaraZ.Shop.Buy()
    local wanted = xDTaraZ.Options.ShopItems
    local stock = xDTaraZ.Shop.ReadStock()
    if not (wanted and next(wanted) and stock) then return 0 end

    local bought, cash = 0, xDTaraZ:Cash() - (xDTaraZ.Options.ShopKeepCash or 0)
    for label in pairs(wanted) do
        local category, name = label:match("^(.-)/(.+)$")
        local entry = category and stock[category] and stock[category][name]
        local price = tonumber(GameLib.Shop.Categories[category] and GameLib.Shop.Categories[category][name] and GameLib.Shop.Categories[category][name].Price) or math.huge
        if not (entry and entry.InStock) then continue end
        xDTaraZ.Net.SetOpenShop:FireServer(category)
        for _ = 1, entry.Amount or 0 do
            if cash < price then break end
            xDTaraZ.Net.BuyWithCash:FireServer(category, name)
            cash -= price
            bought += 1
            task.wait(Config.ShopGap)
        end
    end
    return bought
end

function xDTaraZ.Shop.BuyNow()
    local bought = 0
    xDTaraZ:WithLock("shop", Config.LockWait, function() bought = xDTaraZ.Shop.Buy() end)
    return bought
end

function xDTaraZ.Shop.Step()
    if not xDTaraZ.Options.AutoShop or osClock() - State.LastShop < Config.ShopEvery then return end
    State.LastShop = osClock()
    xDTaraZ:WithLock("shop", 0, xDTaraZ.Shop.Buy)
end

xDTaraZ.Progress = {}

function xDTaraZ.Progress.RebirthCost()
    local lib = GameLib.Rebirths
    local nextRebirth = xDTaraZ:Rebirths() + 1
    if nextRebirth > (lib.Cap or math.huge) then return math.huge end
    if lib.RiggedCost and lib.RiggedCost[nextRebirth] then return lib.RiggedCost[nextRebirth] end
    local ok, cost = pcall(lib.GetCost, xDTaraZ:Rebirths())
    return ok and tonumber(cost) or math.huge
end

function xDTaraZ.Progress.CanRebirthSoon()
    return xDTaraZ.Options.AutoRebirth and State.NextRebirthCost < math.huge and osClock() > State.RebirthBlockedUntil
end

function xDTaraZ.Progress.RebirthNow()
    if xDTaraZ:Rebirths() >= (GameLib.Rebirths.Cap or math.huge) then return end
    local before = xDTaraZ:Rebirths()
    xDTaraZ.Net.Rebirth:FireServer()
    task.delay(3, function()
        if xDTaraZ:Rebirths() == before then
            State.RebirthBlockedUntil = osClock() + Config.RebirthBackoff
            xDTaraZ:SetStatus("Rebirth refused (missing required pet?)")
        end
    end)
end

function xDTaraZ.Progress.UpgradeNow()
    xDTaraZ.Net.Upgrades:FireServer("Max")
end

function xDTaraZ.Progress.ClaimNow()
    xDTaraZ.Net.ClaimIndexReward:FireServer()
    xDTaraZ.Net.OfflineEarnings:FireServer()
    local saved = xDTaraZ:Saved()
    local claimed = saved and saved:FindFirstChild("ClaimedGroupReward")
    if xDTaraZ.Net.ClaimGroupReward and not (claimed and claimed.Value ~= "" and claimed.Value ~= false) then
        xDTaraZ.Net.ClaimGroupReward:FireServer()
    end
end

---@return boolean  luck upgrades should wait for rebirth cash
function xDTaraZ.Progress.SavingForRebirth()
    if not xDTaraZ.Options.SmartSpend or not xDTaraZ.Progress.CanRebirthSoon() then return false end
    return xDTaraZ:Cash() < State.NextRebirthCost * Config.RebirthReserve
end

function xDTaraZ.Progress.Step()
    local opts, now = xDTaraZ.Options, osClock()
    State.NextRebirthCost = xDTaraZ.Progress.RebirthCost()

    if opts.AutoRebirth and now - State.LastRebirth > Config.RebirthGap and now > State.RebirthBlockedUntil and xDTaraZ:Cash() >= State.NextRebirthCost then
        State.LastRebirth = now
        xDTaraZ.Progress.RebirthNow()
    end
    if opts.AutoUpgrade and now - State.LastUpgrade > Config.UpgradeGap and not xDTaraZ.Progress.SavingForRebirth() then
        State.LastUpgrade = now
        xDTaraZ.Progress.UpgradeNow()
    end
    if opts.AutoClaim and now - State.LastClaim > Config.ClaimGap then
        State.LastClaim = now
        xDTaraZ.Progress.ClaimNow()
    end
end

xDTaraZ.Move = { Saved = {} }

function xDTaraZ.Move.SetNoClip(on)
    if on then
        for _, part in ipairs(xDTaraZ.Player.Parts) do
            if part.Parent and part.CanCollide then
                State.CollidePatch[part] = true
                part.CanCollide = false
            end
        end
        return
    end
    for part in pairs(State.CollidePatch) do
        if part.Parent then part.CanCollide = true end
    end
    table.clear(State.CollidePatch)
end

function xDTaraZ.Move.FlyStep(dt)
    local root = xDTaraZ.Player.Root
    if not root then return end
    local cam = Workspace.CurrentCamera
    local dir = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.yAxis end
    root.AssemblyLinearVelocity = Vector3.zero
    if dir.Magnitude > 0 then root.CFrame += dir.Unit * (xDTaraZ.Options.FlySpeed or Config.FlySpeed) * dt end
end

function xDTaraZ.Move.Frame(dt)
    local opts = xDTaraZ.Options
    local hum = xDTaraZ.Player.Humanoid
    if opts.NoClip or opts.Fly or opts.Fling then xDTaraZ.Move.SetNoClip(true) end
    if opts.Fly then xDTaraZ.Move.FlyStep(dt) end
    if hum and opts.SpeedOn then hum.WalkSpeed = opts.WalkSpeed or Config.WalkSpeed end
    if hum and opts.JumpOn then hum.JumpPower = opts.JumpPower or Config.JumpPower end
end

---@param idx string  option that just turned off
function xDTaraZ.Move.Restore(idx)
    local opts, hum = xDTaraZ.Options, xDTaraZ.Player.Humanoid
    if hum and (idx == "SpeedOn" or idx == nil) then hum.WalkSpeed = xDTaraZ.Move.Saved.WalkSpeed or 16 end
    if hum and (idx == "JumpOn" or idx == nil) then hum.JumpPower = xDTaraZ.Move.Saved.JumpPower or 50 end
    if idx == nil or not (opts.NoClip or opts.Fly or opts.Fling) then xDTaraZ.Move.SetNoClip(false) end
    if idx == "Fly" and xDTaraZ.Player.Root then xDTaraZ.Player.Root.AssemblyLinearVelocity = Vector3.zero end
end

xDTaraZ.Esp = {}

---@return Color3  preset colour, or a hue by rank for rarities added later
function xDTaraZ.Esp.Color(rarity)
    local preset = Config.RarityColors[rarity]
    if preset then return preset end
    local rank = xDTaraZ.RarityRank[rarity]
    if not rank then return Color3.new(1, 1, 1) end
    return Color3.fromHSV((rank / math.max(#xDTaraZ.Rarities, 1)) * 0.85, 0.55, 1)
end

function xDTaraZ.Esp.Clear()
    for key, entry in pairs(State.EspBoards) do
        entry.Board:Destroy()
        State.EspBoards[key] = nil
    end
end

function xDTaraZ.Esp.Entry(model, info)
    local entry = State.EspBoards[model]
    if entry and entry.Board.Parent then return entry end
    local part = model:IsA("BasePart") and model or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
    if not part then return nil end

    local board = Instance.new("BillboardGui")
    board.Name = "MarioEsp"
    board.AlwaysOnTop = true
    board.Size = UDim2.fromOffset(200, 40)
    board.StudsOffset = vector3New(0, Config.EspLift, 0)
    board.MaxDistance = Config.EspRange
    board.Adornee = part
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextStrokeTransparency = 0.3
    label.TextColor3 = xDTaraZ.Esp.Color(info.Rarity)
    label.Parent = board
    xDTaraZ.Util.ParentGui(board)

    entry = { Board = board, Label = label, Part = part }
    State.EspBoards[model] = entry
    return entry
end

function xDTaraZ.Esp.Refresh()
    if not xDTaraZ.Options.EggEsp then
        if next(State.EspBoards) then xDTaraZ.Esp.Clear() end
        return
    end
    local rendered = Workspace:FindFirstChild("RenderedEggs")
    if not rendered then return end

    local root = xDTaraZ.Player.Root
    local minRank = xDTaraZ.RarityRank[xDTaraZ.Options.EspMinRarity or ""] or 1
    local seen = {}
    for _, model in ipairs(rendered:GetChildren()) do
        local info = xDTaraZ.EggInfo[model.Name]
        if not info or (xDTaraZ.RarityRank[info.Rarity] or 1) < minRank then continue end
        local entry = xDTaraZ.Esp.Entry(model, info)
        if not entry then continue end
        seen[model] = true
        local dist = root and math.floor((entry.Part.Position - root.Position).Magnitude) or 0
        entry.Label.Text = string.format("%s [%s]\n1 in %s | %dm", model.Name, info.Rarity, xDTaraZ.Util.FormatNumber(info.Luck), dist)
    end
    for key, entry in pairs(State.EspBoards) do
        if not seen[key] then
            entry.Board:Destroy()
            State.EspBoards[key] = nil
        end
    end
end

xDTaraZ.Teleport = {}

function xDTaraZ.Teleport.Places()
    local places = { ["My Plot"] = function() return xDTaraZ:HomeCFrame() end }
    local stalls = Workspace:FindFirstChild("Stalls")
    for _, stall in ipairs(stalls and stalls:GetChildren() or {}) do
        places["Shop: " .. stall.Name] = function() return stall:GetPivot() + vector3New(0, Config.HomeHover, 0) end
    end
    local volcano = Workspace:FindFirstChild("Volcano")
    for _, spot in ipairs({ "VolcanoEntrance", "VolcanoTop" }) do
        local part = volcano and volcano:FindFirstChild(spot)
        if part then
            places["Volcano: " .. spot:sub(8)] = function() return part.CFrame + vector3New(0, Config.NestHover, 0) end
        end
    end
    return places
end

function xDTaraZ.Teleport.PlaceNames()
    local names = {}
    for name in pairs(xDTaraZ.Teleport.Places()) do names[#names + 1] = name end
    table.sort(names)
    return names
end

function xDTaraZ.Teleport.To(name)
    local getter = xDTaraZ.Teleport.Places()[name or ""]
    if getter then xDTaraZ:MoveTo(getter()) end
end

function xDTaraZ.Teleport.ToPlayer(name)
    local target = Players:FindFirstChild(name or "")
    local root = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if root then xDTaraZ:MoveTo(root.CFrame + vector3New(0, Config.HomeHover, 0)) end
end

function xDTaraZ.Teleport.BestEgg()
    local egg = xDTaraZ.Eggs.Available()[1]
    if egg then xDTaraZ:MoveTo(cframeNew(egg:GetAttribute("Position") + vector3New(0, Config.EggHover, 0))) end
end

xDTaraZ.Troll = {}

---@return string?  name shown in the Target dropdown
function xDTaraZ.Troll.TargetName()
    local option = Library and Library.Options.TrollTarget
    return option and option.Value
end

function xDTaraZ.Troll.TargetRoot()
    local target = Players:FindFirstChild(xDTaraZ.Troll.TargetName() or "")
    return target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
end

function xDTaraZ.Troll.Spectate(name)
    local target = Players:FindFirstChild(name or "")
    local hum = target and target.Character and target.Character:FindFirstChildOfClass("Humanoid")
    Workspace.CurrentCamera.CameraSubject = hum or xDTaraZ.Player.Humanoid
end

function xDTaraZ.Troll.Frame()
    local opts = xDTaraZ.Options
    if not opts.Fling and not opts.Stick then return end
    local troot, root = xDTaraZ.Troll.TargetRoot(), xDTaraZ.Player.Root
    if not troot or not root then return end

    State.TrollHome = State.TrollHome or root.CFrame
    if opts.Fling then
        root.CFrame = troot.CFrame * CFrame.Angles(0, math.rad(osClock() * Config.FlingSpin % 360), 0)
        root.AssemblyLinearVelocity = vector3New(0, Config.FlingForce, 0)
        root.AssemblyAngularVelocity = vector3New(0, Config.FlingForce, 0)
        return
    end
    root.CFrame = troot.CFrame * cframeNew(0, 0, Config.StickOffset)
end

---@param idx string?  troll toggle that just turned off, nil on unload
function xDTaraZ.Troll.Stop(idx)
    local root = xDTaraZ.Player.Root
    if root then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
    if idx then xDTaraZ.Move.Restore(idx) end
    if idx and xDTaraZ:TrollActive() then return end

    if root and State.TrollHome then root.CFrame = State.TrollHome end
    State.TrollHome = nil
end

xDTaraZ.Server = {}

function xDTaraZ.Server.Rejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end

function xDTaraZ.Server.Hop()
    local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId)
    local ok, decoded = pcall(function() return HttpService:JSONDecode(xDTaraZ.Util.HttpGet(url)) end)
    local open = {}
    for _, server in ipairs(ok and decoded and decoded.data or {}) do
        if server.id ~= game.JobId and server.playing < server.maxPlayers then open[#open + 1] = server.id end
    end
    if #open > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, open[math.random(1, math.min(#open, Config.HopPick))], LocalPlayer)
        return
    end
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

function xDTaraZ.Server.HuntHop()
    State.Hopping = true
    local hops = (State.HuntHops or 0) + 1
    if hops > Config.HuntMaxHops then
        State.HuntHops, State.Hopping, State.EmptySince = 0, false, osClock()
        table.insert(State.HaltQueue, { "Rare Egg Hunter", "no rare eggs after " .. Config.HuntMaxHops .. " servers", { "EggHunter" } })
        return
    end
    local queue = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport)
    if queue and xDTaraZ.Options.EggHunter then
        queue(string.format("getgenv().RideAPetHunt = { Hops = %d, Rarity = %q } ", hops, xDTaraZ.Options.HuntMinRarity or xDTaraZ.HuntDefault) .. Config.ReloadSource)
    end
    task.delay(Config.HopReset, function()
        State.Hopping = false
        State.EmptySince = osClock()
    end)
    local ok, err = pcall(xDTaraZ.Server.Hop)
    if not ok then warn(Config.Tag, "hop:", err) end
end

xDTaraZ.Scheduler = {}

xDTaraZ.Scheduler.Toggles = {
    Eggs = { "AutoEggs", "EggHunter" },
    Hatch = { "AutoPlaceEggs", "AutoHatch" },
    Pets = { "AutoEquipBest", "AutoCollectCash", "AutoFeed", "AutoSell" },
    Fusion = { "AutoFusion" },
    Shop = { "AutoShop" },
    Progress = { "AutoUpgrade", "AutoRebirth", "AutoClaim" },
}

---@return boolean  one of the job's toggles is on
function xDTaraZ.Scheduler.Wanted(name)
    for _, idx in ipairs(xDTaraZ.Scheduler.Toggles[name] or {}) do
        if xDTaraZ.Options[idx] == true then return true end
    end
    return false
end

function xDTaraZ.Scheduler.Fail(name, err)
    local fails = (State.Fails[name] or 0) + 1
    State.Fails[name] = fails
    State.FailSince[name] = State.FailSince[name] or osClock()
    if fails == 1 then warn(Config.Tag, name .. " failing:", err) end

    if fails < Config.FailLimit or osClock() - State.FailSince[name] < Config.FailWindow then return end
    if not xDTaraZ.Scheduler.Wanted(name) then return end
    State.Halted[name] = true
    table.insert(State.HaltQueue, { name, tostring(err):match("^[^\n]*") })
end

function xDTaraZ.Scheduler.Resume(idx)
    for name, toggles in pairs(xDTaraZ.Scheduler.Toggles) do
        if table.find(toggles, idx) then
            State.Halted[name], State.Fails[name], State.FailSince[name] = nil, nil, nil
        end
    end
end

---@param names string[]  modules whose Step runs every tick
function xDTaraZ.Scheduler.Loop(tick, names)
    task.spawn(function()
        while State.Alive do
            for _, name in ipairs(names) do
                if State.Halted[name] then continue end
                local ok, err = pcall(xDTaraZ[name].Step)
                if ok then
                    State.Fails[name], State.FailSince[name] = nil, nil
                else
                    xDTaraZ.Scheduler.Fail(name, err)
                end
            end
            task.wait(tick)
        end
    end)
end

function xDTaraZ.Scheduler.Boot()
    if xDTaraZ.Net.EggPickup then
        xDTaraZ:Connect(xDTaraZ.Net.EggPickup.OnClientEvent, function(kind, detail)
            State.PickReply = { kind = kind, detail = detail, at = osClock() }
        end)
    end
    if xDTaraZ.Net.VolcanoDipResult then
        xDTaraZ:Connect(xDTaraZ.Net.VolcanoDipResult.OnClientEvent, function(reply)
            if type(reply) == "table" and reply.Owner == LocalPlayer.UserId then State.DipReply = reply end
        end)
    end
    if xDTaraZ.Net.VolcanoDipCancelled then
        xDTaraZ:Connect(xDTaraZ.Net.VolcanoDipCancelled.OnClientEvent, function() State.DipReply = { Cancelled = true } end)
    end
    if xDTaraZ.Net.SellItems then
        xDTaraZ:Connect(xDTaraZ.Net.SellItems.OnClientEvent, function(reply) State.SellReply = reply end)
    end
    if xDTaraZ.Net.Restock then
        xDTaraZ:Connect(xDTaraZ.Net.Restock.OnClientEvent, function(stock)
            if type(stock) == "table" then State.Stock = stock end
        end)
    end
    if xDTaraZ.Net.ConfirmRequest then
        xDTaraZ:Connect(xDTaraZ.Net.ConfirmRequest.OnClientEvent, function(id, question)
            if State.SellPending and type(id) == "string" and type(question) == "string" then
                xDTaraZ.Net.ConfirmRequest:FireServer(id, true)
            end
        end)
    end
    xDTaraZ.Scheduler.Loop(Config.EggTick, { "Eggs" })
    xDTaraZ.Scheduler.Loop(Config.StepTick, { "Hatch", "Pets", "Progress", "Fusion", "Shop" })
    xDTaraZ:Connect(RunService.Heartbeat, function(dt)
        xDTaraZ.Move.Frame(dt)
        xDTaraZ.Troll.Frame()
    end)
    xDTaraZ:Connect(LocalPlayer.Idled, function()
        if not xDTaraZ.Options.AntiAfk then return end
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    xDTaraZ:Connect(UserInputService.JumpRequest, function()
        if xDTaraZ.Options.InfJump and xDTaraZ.Player.Humanoid then
            xDTaraZ.Player.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    xDTaraZ:Connect(Players.PlayerRemoving, function(player)
        local subject = Workspace.CurrentCamera.CameraSubject
        if subject and subject:IsDescendantOf(player.Character or game) and player ~= LocalPlayer then xDTaraZ.Troll.Spectate(nil) end
    end)
end

xDTaraZ.UI = {}

xDTaraZ.UI.OffHooks = {
    SpeedOn = function() xDTaraZ.Move.Restore("SpeedOn") end,
    JumpOn = function() xDTaraZ.Move.Restore("JumpOn") end,
    NoClip = function() xDTaraZ.Move.Restore("NoClip") end,
    Fly = function() xDTaraZ.Move.Restore("Fly") end,
    Fling = function() xDTaraZ.Troll.Stop("Fling") end,
    Stick = function() xDTaraZ.Troll.Stop("Stick") end,
}

xDTaraZ.UI.KaitunSet = { "AutoEggs", "SmartEggs", "AutoPlaceEggs", "AutoHatch", "AutoEquipBest", "AutoCollectCash", "AutoFeed", "AutoUpgrade", "SmartSpend", "AutoRebirth", "AutoClaim", "AntiAfk" }

xDTaraZ.UI.Needs = {
    AutoEggs = { "Eggs", "EggBaskets", "Net.EggPickup", "Net.EggArrivalClaim" },
    EggHunter = { "Eggs", "EggBaskets", "Net.EggPickup", "Net.EggArrivalClaim" },
    VolcanoDip = { "Eggs", "Net.VolcanoDip", "Net.VolcanoDipResult" },
    AutoPlaceEggs = { "Eggs", "Net.EggPlaced" },
    AutoHatch = { "Net.Hatch" },
    AutoEquipBest = { "Pets", "Mutations", "Net.PlacePet", "Net.PickupPet" },
    AutoCollectCash = { "Net.PetCollect" },
    AutoFeed = { "Foods", "Net.FeedPet" },
    AutoUpgrade = { "Net.Upgrades" },
    AutoRebirth = { "Rebirths", "Net.Rebirth" },
    AutoClaim = { "Net.ClaimIndexReward", "Net.OfflineEarnings" },
    AutoSell = { "Net.SellItems", "Net.ConfirmRequest" },
    AutoFusion = { "Net.FusionAction", "Net.FusionPetPlace" },
    AutoShop = { "Shop", "Net.BuyWithCash", "Net.SetOpenShop", "Net.ShopStock", "Net.Restock" },
    EggEsp = { "Eggs" },
}

function xDTaraZ.UI.Bind(idx, option)
    xDTaraZ.Options[idx] = option.Value
    option:OnChanged(function(value)
        xDTaraZ.Options[idx] = value
        if value == true then xDTaraZ.Scheduler.Resume(idx) end
        local hook = xDTaraZ.UI.OffHooks[idx]
        if hook and not value then hook() end
    end)
    return option
end

function xDTaraZ.UI.Toggle(group, idx, en, th, desc, risky)
    return xDTaraZ.UI.Bind(idx, group:AddToggle(idx, { Text = T(en, th), Description = desc, Default = false, Risky = risky }))
end

---@return table  toggle, with a key picker saved as "<idx>Key"
function xDTaraZ.UI.KeyToggle(group, idx, en, th, desc, risky)
    return xDTaraZ.UI.Toggle(group, idx, en, th, desc, risky):AddKeyPicker(idx .. "Key", { Default = "None", Mode = "Toggle" })
end

---@return function  runs fn off the UI thread, warns on error
function xDTaraZ.UI.Detach(fn)
    return function(...)
        local args = table.pack(...)
        task.spawn(function()
            local ok, err = pcall(fn, table.unpack(args, 1, args.n))
            if not ok then warn(Config.Tag, "ui:", err) end
        end)
    end
end

---@return table  list from a game-data source, empty when it errors
function xDTaraZ.UI.Values(source)
    local ok, list = pcall(source)
    return ok and type(list) == "table" and list or {}
end

---@return string?  first module or remote the option needs that is missing
function xDTaraZ.UI.MissingFor(idx)
    for _, name in ipairs(xDTaraZ.UI.Needs[idx] or {}) do
        if GameLib.Missing[name] then return name end
    end
    return nil
end

function xDTaraZ.UI.Gate()
    local blocked = 0
    for idx in pairs(xDTaraZ.UI.Needs) do
        local missing = xDTaraZ.UI.MissingFor(idx)
        if not Library.Options[idx] or not missing then continue end
        blocked += 1
        local bare = missing:gsub("^Net%.", "")
        local gone = missing ~= bare or table.find(State.Missing, bare) ~= nil
        warn(Config.Tag, idx .. " blocked, missing " .. missing)
        Library.Compat.Block(idx, gone and T("The game changed, waiting for a script update", "เกมอัปเดต รอสคริปต์อัปเดต")
            or T("Not available on this executor", "ใช้กับ executor นี้ไม่ได้"))
    end
    if blocked > 0 then
        Library:Notify("Mario Hub", T(blocked .. " features are turned off for now", "ปิดไว้ก่อน " .. blocked .. " ฟีเจอร์"), 8, "Warning")
    end
end

function xDTaraZ.UI.DrainHalted()
    while #State.HaltQueue > 0 do
        local name, reason, only = table.unpack(table.remove(State.HaltQueue, 1))
        local inKaitun = false
        for _, idx in ipairs(only or xDTaraZ.Scheduler.Toggles[name] or {}) do
            local option = Library.Options[idx]
            if option and option.Value == true then option:SetValue(false) end
            inKaitun = inKaitun or table.find(xDTaraZ.UI.KaitunSet, idx) ~= nil
        end

        local kaitun = Library.Options.Kaitun
        if inKaitun and kaitun and kaitun.Value == true then
            kaitun:SetValue(false)
            xDTaraZ:SetStatus("Idle")
        end
        Library:Notify("Mario Hub", name .. " stopped: " .. reason, 8, "Error")
    end
end

function xDTaraZ.UI.Home(window)
    local tab = window:AddTab(T("Home", "หน้าแรก"), "mushroom", T("Status and full auto", "สถานะและโหมดอัตโนมัติ"))
    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "info")
    xDTaraZ.UI.StatusLabel = status:AddLabel("...")
    xDTaraZ.UI.CashLabel = status:AddLabel("...")
    xDTaraZ.UI.EggLabel = status:AddLabel("...")

    local quick = tab:AddLeftGroupbox(T("Quick", "ด่วน"), "bomb")
    quick:AddButton({ Text = T("Panic - All Off", "ฉุกเฉิน ปิดทั้งหมด"), Style = "Danger", Func = function()
        for idx, toggle in pairs(Library.Toggles) do
            if toggle.Value == true and not tostring(idx):find("^Mario") then toggle:SetValue(false) end
        end
    end })

    local discord = tab:AddRightGroupbox(T("Discord", "ดิสคอร์ด"), "link")
    discord:AddLabel(Config.Discord)
    discord:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ดิสคอร์ด"), Func = function()
        if xDTaraZ.Util.Copy(Config.Discord) then
            Library:Notify("Discord", "Link copied", 3, "Success")
        else
            Library:Notify("Discord", Config.Discord, 6, "Info")
        end
    end })

    local logBox = tab:AddRightGroupbox(T("Update Log", "อัปเดตล่าสุด"), "bell")
    for i = 1, math.min(2, #Config.UpdateLog) do
        local entry = Config.UpdateLog[i]
        logBox:AddParagraph({ Title = entry[1], Content = entry[2] })
    end

    local kaitun = tab:AddRightGroupbox(T("Kaitun", "ไก่ตัน"), "star")
    kaitun:AddToggle("Kaitun", {
        Text = T("Kaitun", "ไก่ตัน"),
        Description = T("Plays the whole account for you, from eggs to rebirth", "เล่นแทนทั้งบัญชี ตั้งแต่ไข่จนถึงรีเบิร์ธ"),
        Default = false,
        Callback = function(on)
            for _, idx in ipairs(xDTaraZ.UI.KaitunSet) do
                local option = Library.Options[idx]
                if option then option:SetValue(on) end
            end
        end,
    })
    xDTaraZ.UI.Toggle(kaitun, "SmartSpend", "Save For Rebirth", "เก็บเงินไว้รีเบิร์ธ", T("Holds luck upgrades until rebirth is paid for", "รอซื้ออัปโชคจนกว่าจะรีเบิร์ธได้"))
end

function xDTaraZ.UI.EggFarm(window)
    local tab = window:AddTab(T("Egg Farm", "ฟาร์มไข่"), "coin", T("Wild egg collecting", "เก็บไข่ป่า"))
    local farm = tab:AddLeftGroupbox(T("Collect Eggs", "เก็บไข่"), "zap")
    xDTaraZ.UI.Toggle(farm, "AutoEggs", "Auto Collect Eggs", "เก็บไข่อัตโนมัติ", T("Grabs every wanted egg on the map and brings it home", "เก็บไข่ที่เลือกทั่วแมพแล้วพากลับบ้าน"), true)
    xDTaraZ.UI.Toggle(farm, "SmartEggs", "Better Eggs Only", "เก็บเฉพาะไข่ที่ดีกว่า", T("Once your bag is stocked, only grabs eggs better than what you hold", "พอไข่ในกระเป๋าเยอะแล้ว เก็บเฉพาะไข่ที่ดีกว่าที่มี"))
    xDTaraZ.UI.Toggle(farm, "ReturnAfter", "Return To Spot", "กลับจุดเดิม", T("Go back where you stood after each run", "กลับไปจุดเดิมหลังเก็บเสร็จ"))
    farm:AddButton({ Text = T("Collect Eggs Now", "เก็บไข่เดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        Library:Notify("Eggs", "Collected " .. xDTaraZ.Eggs.CollectNow(), 3, "Success")
    end) })
    farm:AddButton({ Text = T("Teleport To Best Egg", "วาร์ปไปไข่ที่ดีที่สุด"), Func = xDTaraZ.Teleport.BestEgg })

    local volcano = tab:AddLeftGroupbox(T("Volcano", "ภูเขาไฟ"), "flower")
    local dip = xDTaraZ.UI.Toggle(volcano, "VolcanoDip", "Volcano Dip", "จุ่มไข่ในภูเขาไฟ", T("Dips collected eggs in the volcano for a chance at Magma", "จุ่มไข่ที่เก็บมาในภูเขาไฟ ลุ้นได้ Magma"))
    xDTaraZ.UI.Bind("DipRarities", volcano:AddDropdown("DipRarities", { Text = T("Dip Rarities (empty = all)", "ความหายากที่จะจุ่ม (ว่าง = ทั้งหมด)"), Values = xDTaraZ.Rarities, Multi = true, Default = {} }))
    local obby = xDTaraZ.UI.Toggle(volcano, "VolcanoObby", "Auto Volcano Obby", "ผ่านด่านภูเขาไฟอัตโนมัติ", T("Finishes the volcano climb so Volcanic Eggs can be collected", "ผ่านด่านปีนภูเขาไฟ เพื่อเก็บไข่ Volcanic ได้"))
    volcano:AddButton({ Text = T("Finish Volcano Obby Now", "ผ่านด่านภูเขาไฟเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.Volcano.ValidateNow()
        Library:Notify("Volcano", xDTaraZ.Volcano.Done() and "Volcano climb done" or "Volcano climb failed", 4, xDTaraZ.Volcano.Done() and "Success" or "Warning")
    end) })
    Library.Compat.NeedCap(dip, "Touch")
    Library.Compat.NeedCap(obby, "Touch")

    local filters = tab:AddRightGroupbox(T("Egg Filters", "ตัวกรองไข่"), "target")
    local rarities = xDTaraZ.UI.Bind("EggRarities", filters:AddDropdown("EggRarities", { Text = T("Rarities (empty = all)", "ความหายาก (ว่าง = ทั้งหมด)"), Values = xDTaraZ.Rarities, Multi = true, Default = {} }))
    local eggNames = xDTaraZ.UI.Bind("EggNames", filters:AddDropdown("EggNames", { Text = T("Eggs (empty = all)", "ไข่ (ว่าง = ทั้งหมด)"), Values = xDTaraZ.EggNames, Multi = true, Searchable = true, Default = {} }))
    xDTaraZ.UI.Bind("MinLuck", filters:AddSlider("MinLuck", { Text = T("Minimum Luck (1 in X)", "โชคขั้นต่ำ (1 ใน X)"), Min = 0, Max = 1000000, Default = 0, Rounding = 0 }))
    filters:AddButton({ Text = T("Refresh Egg List", "รีเฟรชรายการไข่"), Func = function()
        xDTaraZ.BuildLists()
        eggNames:SetValues(xDTaraZ.EggNames)
        rarities:SetValues(xDTaraZ.Rarities)
    end })

    local hunter = tab:AddRightGroupbox(T("Rare Egg Hunter", "ล่าไข่หายาก"), "star")
    xDTaraZ.UI.Toggle(hunter, "EggHunter", "Rare Egg Hunter", "ล่าไข่หายาก", T("Grabs only top rarity eggs and hops servers until it finds them", "เก็บเฉพาะไข่ระดับสูง ไม่มีก็ย้ายเซิร์ฟหาเอง"), true)
    xDTaraZ.UI.Bind("HuntMinRarity", hunter:AddDropdown("HuntMinRarity", { Text = T("Minimum Rarity", "ความหายากขั้นต่ำ"), Values = xDTaraZ.Rarities, Default = xDTaraZ.HuntDefault }))
    hunter:AddButton({ Text = T("Hop Server Now", "ย้ายเซิร์ฟเดี๋ยวนี้"), Style = "Warning", Func = xDTaraZ.UI.Detach(xDTaraZ.Server.Hop) })
end

function xDTaraZ.UI.Hatching(window)
    local tab = window:AddTab(T("Hatch", "ฟักไข่"), "flower", T("Placing and hatching", "วางและฟักไข่"))
    local place = tab:AddLeftGroupbox(T("Place Eggs", "วางไข่"), "flower")
    xDTaraZ.UI.Toggle(place, "AutoPlaceEggs", "Auto Place Eggs", "วางไข่อัตโนมัติ", T("Fills your plot with your best eggs up to the limit", "วางไข่ที่ดีที่สุดลงพล็อตจนเต็มลิมิต"))
    xDTaraZ.UI.Toggle(place, "FastestFirst", "Fastest Eggs First", "ไข่ที่ฟักเร็วก่อน", T("Off = best luck first", "ปิด = ไข่โชคดีสุดก่อน"))
    place:AddButton({ Text = T("Place Eggs Now", "วางไข่เดี๋ยวนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Hatch.PlaceNow) })

    local hatch = tab:AddRightGroupbox(T("Hatching", "ฟักไข่"), "star")
    xDTaraZ.UI.Toggle(hatch, "AutoHatch", "Auto Hatch", "ฟักอัตโนมัติ", T("Hatches eggs from anywhere as soon as they are ready", "ฟักไข่จากที่ไหนก็ได้ทันทีที่พร้อม"))
    hatch:AddButton({ Text = T("Hatch Now", "ฟักเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function() xDTaraZ.Hatch.HatchNow(true) end) })
end

function xDTaraZ.UI.PetsTab(window)
    local tab = window:AddTab(T("Pets", "สัตว์เลี้ยง"), "shell", T("Ranch, feeding and cash", "ฟาร์ม ให้อาหาร และเงิน"))
    local ranch = tab:AddLeftGroupbox(T("Ranch", "ฟาร์ม"), "house")
    xDTaraZ.UI.Toggle(ranch, "AutoEquipBest", "Auto Place Best Pets", "วางสัตว์ตัวดีสุดอัตโนมัติ", T("Keeps your ranch filled with the highest income pets", "ใส่สัตว์ที่ทำเงินได้มากสุดลงฟาร์มเสมอ"))
    xDTaraZ.UI.Toggle(ranch, "AutoCollectCash", "Auto Collect Cash", "เก็บเงินอัตโนมัติ", T("Collects pet cash from anywhere", "เก็บเงินจากสัตว์จากที่ไหนก็ได้"))
    ranch:AddButton({ Text = T("Place Best Now", "วางตัวดีสุดเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(xDTaraZ.Pets.EquipBestNow) })
    ranch:AddButton({ Text = T("Collect Cash Now", "เก็บเงินเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Pets.CollectNow) })

    local feed = tab:AddRightGroupbox(T("Feeding", "ให้อาหาร"), "heart")
    xDTaraZ.UI.Toggle(feed, "AutoFeed", "Auto Feed", "ให้อาหารอัตโนมัติ", T("Feeds your best pets with the food you own", "ให้อาหารสัตว์ตัวดีสุดด้วยอาหารที่มี"))
    xDTaraZ.UI.Bind("FoodTypes", feed:AddDropdown("FoodTypes", { Text = T("Foods to use (empty = all)", "อาหารที่ใช้ (ว่าง = ทั้งหมด)"), Values = xDTaraZ.FoodNames, Multi = true, Default = {} }))
    feed:AddButton({ Text = T("Feed Now", "ให้อาหารเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Pets.FeedNow) })

    local sell = tab:AddLeftGroupbox(T("Sell Pets", "ขายสัตว์เลี้ยง"), "coin")
    xDTaraZ.UI.Toggle(sell, "AutoSell", "Auto Sell Pets", "ขายสัตว์อัตโนมัติ", T("Sells the pets in your bag that match the rarities below", "ขายสัตว์ในกระเป๋าที่ตรงกับความหายากด้านล่าง"), true)
    xDTaraZ.UI.Bind("SellRarities", sell:AddDropdown("SellRarities", { Text = T("Rarities To Sell", "ความหายากที่จะขาย"), Values = xDTaraZ.PetRarities, Multi = true, Default = {} }))
    xDTaraZ.UI.Bind("SellKeepBest", sell:AddSlider("SellKeepBest", { Text = T("Keep Best Pets", "เก็บตัวดีสุดไว้"), Min = 0, Max = 100, Default = 10, Rounding = 0 }))
    xDTaraZ.UI.Bind("SellKeepMutated", sell:AddCheckbox("SellKeepMutated", { Text = T("Keep Mutated Pets", "ไม่ขายตัวมิวเทชัน"), Default = true }))
    sell:AddButton({ Text = T("Sell Now", "ขายเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        local sold = xDTaraZ.Pets.SellNow()
        Library:Notify("Sell", sold > 0 and ("Sold " .. sold .. " pets") or "Nothing to sell with these options", 3, sold > 0 and "Success" or "Warning")
    end) })

    local shop = tab:AddLeftGroupbox(T("Stock Shop", "ร้านสต็อก"), "shop")
    xDTaraZ.UI.Toggle(shop, "AutoShop", "Auto Buy Stock", "ซื้อของในร้านอัตโนมัติ", T("Buys the items below the moment they are in stock", "ซื้อของที่เลือกทันทีที่มีของในร้าน"))
    local shopLabels = xDTaraZ.UI.Values(xDTaraZ.Shop.Labels)
    xDTaraZ.UI.Bind("ShopItems", shop:AddDropdown("ShopItems", { Text = T("Items To Buy", "ของที่จะซื้อ"), Values = shopLabels, Multi = true, Searchable = true, Default = {} }))
    xDTaraZ.UI.Bind("ShopKeepCash", shop:AddSlider("ShopKeepCash", { Text = T("Keep Cash", "กันเงินไว้"), Min = 0, Max = 1000000000, Default = 0, Rounding = 0 }))
    shop:AddButton({ Text = T("Buy Now", "ซื้อเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach(function()
        local bought = xDTaraZ.Shop.BuyNow()
        Library:Notify("Shop", bought > 0 and ("Bought " .. bought .. " items") or "Nothing in stock for these items", 3, bought > 0 and "Success" or "Warning")
    end) })

    local fuse = tab:AddRightGroupbox(T("Fusion", "หลอมสัตว์"), "bomb")
    xDTaraZ.UI.Toggle(fuse, "AutoFusion", "Auto Fusion", "หลอมสัตว์อัตโนมัติ", T("Puts four matching pets in the machine, fuses and claims the result", "ใส่สัตว์ 4 ตัวที่ตรงเงื่อนไขลงเครื่อง หลอม แล้วรับผลลัพธ์"), true)
    xDTaraZ.UI.Bind("FuseRarities", fuse:AddDropdown("FuseRarities", { Text = T("Rarities To Fuse", "ความหายากที่จะหลอม"), Values = xDTaraZ.PetRarities, Multi = true, Default = {} }))
    xDTaraZ.UI.Bind("FuseKeepBest", fuse:AddSlider("FuseKeepBest", { Text = T("Keep Best Pets", "เก็บตัวดีสุดไว้"), Min = 0, Max = 100, Default = 10, Rounding = 0 }))
    xDTaraZ.UI.Bind("FuseKeepMutated", fuse:AddCheckbox("FuseKeepMutated", { Text = T("Keep Mutated Pets", "ไม่ใช้ตัวมิวเทชัน"), Default = true }))
    fuse:AddButton({ Text = T("Fuse Now", "หลอมเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Fusion.RunNow) })
end

function xDTaraZ.UI.Upgrades(window)
    local tab = window:AddTab(T("Upgrades", "อัปเกรด"), "oneup", T("Luck, rebirth, rewards", "โชค รีเบิร์ธ รางวัล"))
    local up = tab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "oneup")
    xDTaraZ.UI.Toggle(up, "AutoUpgrade", "Auto Upgrade Hatch Luck", "อัปโชคฟักอัตโนมัติ", T("Buys as many luck upgrades as you can afford", "ซื้ออัปเกรดโชคเท่าที่เงินพอ"))
    up:AddButton({ Text = T("Upgrade Max Now", "อัปสุดเดี๋ยวนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(xDTaraZ.Progress.UpgradeNow) })
    xDTaraZ.UI.Toggle(up, "AutoRebirth", "Auto Rebirth", "รีเบิร์ธอัตโนมัติ", T("Rebirths when you have the cash (needs the required pet)", "รีเบิร์ธเมื่อเงินพอ (ต้องมีสัตว์ที่กำหนด)"), true)
    up:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Style = "Warning", DoubleClick = true, Func = xDTaraZ.UI.Detach(xDTaraZ.Progress.RebirthNow) })

    local rewards = tab:AddRightGroupbox(T("Rewards", "รางวัล"), "key")
    xDTaraZ.UI.Toggle(rewards, "AutoClaim", "Auto Claim Rewards", "รับรางวัลอัตโนมัติ", T("Index and offline rewards", "รางวัลสมุดสะสมและออฟไลน์"))
    rewards:AddButton({ Text = T("Claim Now", "รับเดี๋ยวนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Progress.ClaimNow) })
end

function xDTaraZ.UI.TeleportTab(window)
    local tab = window:AddTab(T("Teleport", "วาร์ป"), "pipe", T("Places and players", "สถานที่และผู้เล่น"))
    local places = tab:AddLeftGroupbox(T("Places", "สถานที่"), "map")
    local placeDrop = places:AddDropdown("TeleportPlace", { Text = T("Place", "สถานที่"), Values = xDTaraZ.UI.Values(xDTaraZ.Teleport.PlaceNames), Searchable = true })
    places:AddButton({ Text = T("Teleport", "วาร์ป"), Style = "Primary", Func = function() xDTaraZ.Teleport.To(placeDrop.Value) end })
    places:AddButton({ Text = T("Refresh", "รีเฟรช"), Func = function() placeDrop:SetValues(xDTaraZ.UI.Values(xDTaraZ.Teleport.PlaceNames)) end })

    local players = tab:AddRightGroupbox(T("Players", "ผู้เล่น"), "user")
    local playerDrop = players:AddDropdown("TeleportPlayer", { Text = T("Player", "ผู้เล่น"), SpecialType = "Player", Searchable = true })
    players:AddButton({ Text = T("Teleport To Player", "วาร์ปไปหาผู้เล่น"), Func = function() xDTaraZ.Teleport.ToPlayer(playerDrop.Value) end })
end

function xDTaraZ.UI.PlayerTab(window)
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and utility", "การเคลื่อนที่และอรรถประโยชน์"))
    local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "zap")
    xDTaraZ.UI.KeyToggle(move, "SpeedOn", "Speed", "วิ่งเร็ว")
    xDTaraZ.UI.Bind("WalkSpeed", move:AddSlider("WalkSpeed", { Text = T("Walk Speed", "ความเร็ว"), Min = 16, Max = 300, Default = Config.WalkSpeed, Rounding = 0 }))
    xDTaraZ.UI.KeyToggle(move, "JumpOn", "Jump Power", "กระโดดสูง")
    xDTaraZ.UI.Bind("JumpPower", move:AddSlider("JumpPower", { Text = T("Jump Power", "แรงกระโดด"), Min = 50, Max = 300, Default = Config.JumpPower, Rounding = 0 }))
    xDTaraZ.UI.Toggle(move, "InfJump", "Infinite Jump", "กระโดดไม่จำกัด")

    local troll = tab:AddLeftGroupbox(T("Troll", "ป่วน"), "troll")
    troll:AddDropdown("TrollTarget", { Text = T("Target", "เป้าหมาย"), SpecialType = "Player", Searchable = true })
    xDTaraZ.UI.KeyToggle(troll, "Fling", "Fling", "เหวี่ยงกระเด็น", T("Pauses egg farming while on", "หยุดฟาร์มไข่ชั่วคราวระหว่างเปิด"), true)
    xDTaraZ.UI.KeyToggle(troll, "Stick", "Stick To Player", "เกาะติดผู้เล่น", T("Pauses egg farming while on", "หยุดฟาร์มไข่ชั่วคราวระหว่างเปิด"))
    troll:AddButton({ Text = T("Spectate", "ส่องดู"), Func = function() xDTaraZ.Troll.Spectate(xDTaraZ.Troll.TargetName()) end })
    troll:AddButton({ Text = T("Stop Spectate", "เลิกส่อง"), Func = function() xDTaraZ.Troll.Spectate(nil) end })

    local fly = tab:AddRightGroupbox(T("Fly and Noclip", "บินและเดินทะลุ"), "pipe")
    xDTaraZ.UI.KeyToggle(fly, "NoClip", "Noclip", "เดินทะลุ")
    xDTaraZ.UI.KeyToggle(fly, "Fly", "Fly", "บิน")
    xDTaraZ.UI.Bind("FlySpeed", fly:AddSlider("FlySpeed", { Text = T("Fly Speed", "ความเร็วบิน"), Min = 20, Max = 500, Default = Config.FlySpeed, Rounding = 0 }))

    local misc = tab:AddRightGroupbox(T("Utility", "อรรถประโยชน์"), "gear")
    xDTaraZ.UI.Toggle(misc, "AntiAfk", "Anti AFK", "กันหลุด AFK")
    misc:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟใหม่"), Func = xDTaraZ.UI.Detach(xDTaraZ.Server.Rejoin) })
    misc:AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Func = xDTaraZ.UI.Detach(xDTaraZ.Server.Hop) })

    local esp = tab:AddRightGroupbox(T("Egg ESP", "มองเห็นไข่"), "eye")
    xDTaraZ.UI.KeyToggle(esp, "EggEsp", "Egg ESP", "มองเห็นไข่", T("Shows eggs through walls with rarity and distance", "แสดงไข่ทะลุกำแพง พร้อมความหายากและระยะ"))
    xDTaraZ.UI.Bind("EspMinRarity", esp:AddDropdown("EspMinRarity", { Text = T("Minimum Rarity", "ความหายากขั้นต่ำ"), Values = xDTaraZ.Rarities, Default = xDTaraZ.Rarities[1] }))
end

function xDTaraZ.UI.Build()
    local window = Library.Window
    window:AddTabSection(T("Main", "หลัก"))
    xDTaraZ.Util.Try("ui home", xDTaraZ.UI.Home, window)

    window:AddTabSection(T("Farming", "ฟาร์ม"))
    xDTaraZ.Util.Try("ui eggs", xDTaraZ.UI.EggFarm, window)
    xDTaraZ.Util.Try("ui hatch", xDTaraZ.UI.Hatching, window)

    window:AddTabSection(T("Progression", "พัฒนา"))
    xDTaraZ.Util.Try("ui pets", xDTaraZ.UI.PetsTab, window)
    xDTaraZ.Util.Try("ui upgrades", xDTaraZ.UI.Upgrades, window)

    window:AddTabSection(T("Misc", "อื่นๆ"))
    xDTaraZ.Util.Try("ui teleport", xDTaraZ.UI.TeleportTab, window)
    xDTaraZ.Util.Try("ui player", xDTaraZ.UI.PlayerTab, window)
    xDTaraZ.Util.Try("ui settings", window.AddSettingsTab, window)

    xDTaraZ.Util.Try("ui gate", xDTaraZ.UI.Gate)
end

function xDTaraZ.UI.Refresh()
    if not xDTaraZ.UI.StatusLabel then return end
    local saving = xDTaraZ.Progress.SavingForRebirth() and " (saving for rebirth)" or ""
    local flag = State.Status:find("refused", 1, true) and "[!] " or ""
    local nextCost = State.NextRebirthCost == math.huge and "Max" or xDTaraZ.Util.FormatNumber(State.NextRebirthCost)
    xDTaraZ.UI.StatusLabel:SetText("Status: " .. flag .. State.Status .. saving)
    xDTaraZ.UI.CashLabel:SetText(string.format("Cash: %s | Rebirths: %d | Next: %s", xDTaraZ.Util.FormatNumber(xDTaraZ:Cash()), xDTaraZ:Rebirths(), nextCost))
    xDTaraZ.UI.EggLabel:SetText(string.format("Eggs collected: %d | Wanted on map: %d", State.EggsCollected, #xDTaraZ.Eggs.Available()))
end

function xDTaraZ.UI.ResumeHunt()
    local hunt = environment.RideAPetHunt
    environment.RideAPetHunt = nil
    if type(hunt) ~= "table" then return end

    State.HuntHops = tonumber(hunt.Hops) or 0
    Library.Options.HuntMinRarity:SetValue(hunt.Rarity)
    for _, idx in ipairs({ "EggHunter", "AutoPlaceEggs", "AutoHatch", "AntiAfk" }) do
        Library.Options[idx]:SetValue(true)
    end
    Library:Notify("Rare Egg Hunter", string.format("Hunting %s+ (server %d/%d). Turn it off to stop.", tostring(hunt.Rarity), State.HuntHops, Config.HuntMaxHops), 8, "Info")
end

function xDTaraZ:Unload()
    self.State.Alive = false
    xDTaraZ.Esp.Clear()
    if xDTaraZ:TrollActive() then xDTaraZ.Troll.Stop(nil) end
    xDTaraZ.Move.Restore(nil)
    xDTaraZ.Troll.Spectate(nil)
    for _, conn in ipairs(self.State.Connections) do
        conn:Disconnect()
    end
    table.clear(self.State.Connections)
    if xDTaraZ.Player.CharConn then xDTaraZ.Player.CharConn:Disconnect() end
    if environment.RideAPetUnload == xDTaraZ.UnloadEntry then environment.RideAPetUnload = nil end
end

local function BuildInterface()
    local lib, problem = xDTaraZ.Util.LoadLibrary(Config.UiSource)
    if not lib then
        xDTaraZ.Util.Alert(problem)
        return
    end
    Library = lib
    pcall(MarioBanner.Step, "UI library")
    xDTaraZ.Library = Library
    T = function(en, th) return Library:T(en, th) end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Ride A Pet by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            xDTaraZ.UI.Build()
            Library:Every(Config.EspRefresh, xDTaraZ.Esp.Refresh)
            Library:Every(Config.EspRefresh, xDTaraZ.UI.Refresh)
            Library:Every(Config.EspRefresh, xDTaraZ.UI.DrainHalted)
            xDTaraZ.Util.Try("boot", xDTaraZ.Scheduler.Boot)
            xDTaraZ.Util.Try("autoload config", Library.LoadAutoloadConfig, Library)
            xDTaraZ.Util.Try("hunt resume", xDTaraZ.UI.ResumeHunt)
        end,
    })
    Library:OnUnload(function() xDTaraZ:Unload() end)
    return true
end

function xDTaraZ.UnloadEntry()
    if xDTaraZ.Library and not xDTaraZ.Library.Unloaded then
        xDTaraZ.Library:Unload()
    else
        xDTaraZ:Unload()
    end
end
environment.RideAPetUnload = xDTaraZ.UnloadEntry

if LocalPlayer.Character then xDTaraZ.Player:Bind(LocalPlayer.Character) end
xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(character)
    xDTaraZ.Player:Bind(character)
end)

pcall(MarioBanner.Step, "Systems")
if BuildInterface() then
    pcall(MarioBanner.Step, "Interface")
    pcall(MarioBanner.Ready)
end