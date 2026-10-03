if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local environment = getgenv and getgenv() or _G
if type(environment.AnimeDiceUnload) == "function" then
    pcall(environment.AnimeDiceUnload)
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local osClock = os.clock

if game.GameId ~= 10708913337 then
    LocalPlayer:Kick("Mario Hub: this script is for Anime Dice only")
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
        "   ANIME DICE  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    Discord = "https://discord.gg/FHVfmeSceA",
    ReloadSource = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/loader.lua"))()',
    RejoinDelay = 5,
    RejoinRetry = 30,
    WebhookColor = 0xE8A04C,
    SaveFolder = "Anime Dice",
    LoadTimeout = 10,
    AlertTries = 20,
    AlertGap = 0.5,
    JobFailLimit = 5,
    JobFailWindow = 10,
    StatusInterval = 1,
    RollInterval = 0.05,
    GradeDelay = 0.3,
    TraitDelay = 0.3,
    FuseDelay = 0.55,
    BuyDelay = 0.3,
    LevelDelay = 0.2,
    RedeemDelay = 0.6,
    ClaimDelay = 0.25,
    TowerTick = 0.25,
    TowerRetry = 0.5,
    TowerStartCooldown = 3.2,
    ItemDelay = 0.6,
    RewardsInterval = 5,
    SnapshotTtl = 0.4,
    StorageHeadroom = 6,
    StorageRefill = 0.7,
    TowerDemoteFloor = 5,
    RollStats = { Luck = true, ["Roll Duration"] = true, Rolls = true },
    UtilitySeconds = { Default = 120, Walkspeed = 10, ["Sell Multiplier"] = 60, ["Unit Storage"] = 180, Luck = 600, ["Roll Duration"] = 600 },
    UtilityFallbackShare = 0.05,
    SwapMargin = 1.15,
    FuseGain = 1.25,
    FuseMoneyShare = 0.05,
    SwapsPerPass = 4,
    PlaceDelay = 0.55,
    TowerActionTime = {
        floorStarted = 0.76,
        damageEnemy = 0.62,
        damagePlayer = 0.62,
        memberDefeated = 0.32,
        floorCompleted = 0.24,
    },
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Halted = {},
    Notices = {},
}

xDTaraZ.Options = {
    AntiAfk = false,
    DisableCutscene = false,

    WalkSpeed = false,
    WalkSpeedValue = 32,
    InfiniteJump = false,
    NoClip = false,
    Fly = false,
    FlySpeed = 60,

    AutoRoll = false,

    AutoCollect = false,
    CollectInterval = 1,
    EquipBestUnitsAuto = false,
    EquipInterval = 5,
    PlacementMode = "Potential",
    AutoLevelUp = false,
    LevelMinRarity = "Common",
    LevelTarget = 10,

    AutoBuyDice = false,
    AutoEquipBestDice = false,
    AutoBuyUpgrades = false,
    UpgradeFilter = {},

    AutoSell = false,
    SellRarities = {},
    SellKeepMutations = {},
    KeepPerRarity = 0,
    SellInterval = 2,
    AutoClearStorage = false,
    ClearKeepRarity = "Mythical",
    LevelPayback = 180,
    UpgradePayback = 1800,

    AutoRebirth = false,

    AutoGrade = false,
    GradeTarget = "S",
    GradeOverwrite = false,
    AutoTrait = false,
    TraitTarget = "Samurai",
    TraitOverwrite = false,
    AutoFuse = false,
    FuseRarities = {},

    AutoTower = false,
    TowerName = "Dragon Tower",
    TowerStopFloor = 100,
    TowerReequip = false,
    TowerSmart = false,

    AutoGear = false,
    AutoPotion = false,
    PotionFilter = {},
    AutoSpin = false,
    AutoTicketShop = false,
    TicketShopItems = {},

    AutoDaily = false,
    AutoGroup = false,
    AutoOffline = false,
    AutoQuest = false,

    RareNotify = false,
    NotifyRarities = {},
    NotifyMutations = {},
    WebhookUrl = "",
    AutoLock = false,
    LockRarity = "Secret I",
    LockMutations = {},
    AutoRejoin = false,

    Kaitun = false,
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

---@return string?, string?  body, or nil and why every transport failed
function Util.HttpGet(url)
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if ok and type(body) == "string" then
        return body
    end
    if not Util.Request then return nil, "no http function" end

    local sent, response = pcall(Util.Request, { Url = url, Method = "GET" })
    if not sent or type(response) ~= "table" then return nil, tostring(response) end
    if response.StatusCode ~= 200 or type(response.Body) ~= "string" then
        return nil, "HTTP " .. tostring(response.StatusCode)
    end
    return response.Body
end

---@param detail any?  extra context for the console only
function Util.Alert(text, detail)
    warn("[AnimeDice] " .. text, detail or "")
    task.spawn(function()
        local starterGui = game:GetService("StarterGui")
        for _ = 1, xDTaraZ.Config.AlertTries do
            if pcall(starterGui.SetCore, starterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 }) then return end
            task.wait(xDTaraZ.Config.AlertGap)
        end
    end)
end

function Util.Copy(text)
    if not Util.SetClipboard then return false end
    return (pcall(Util.SetClipboard, text))
end

---@return boolean  fn finished without error
function Util.Try(label, fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[AnimeDice] " .. label .. ":", err) end
    return ok
end

---@return table?, string?  UI library, or nil and a message for the player
function Util.LoadLibrary(url)
    local source, why = Util.HttpGet(url)
    if not source or not source:sub(-64):find("return%s+Library%s*$") then
        warn("[AnimeDice] ui download:", why or "truncated or not the library")
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

function Util.FormatNumber(value)
    value = tonumber(value) or 0
    if value >= 1e6 then
        local suffixes = { "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }
        local tier = math.clamp(math.floor(math.log(value, 1000)) - 1, 1, #suffixes)
        return string.format("%.2f%s", value / (1000 ^ (tier + 1)), suffixes[tier])
    end
    local text = tostring(math.floor(value))
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

xDTaraZ.GameLib = {}
local GameLib = xDTaraZ.GameLib

---@return Instance?  descendant at a dotted path, nil when any part is missing
function GameLib.Find(root, path)
    local node = root
    for part in path:gmatch("[^.]+") do
        if not node then return nil end
        node = node:FindFirstChild(part)
    end
    return node
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
    local deadline = osClock() + xDTaraZ.Config.LoadTimeout
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
    warn("[AnimeDice] require " .. module:GetFullName() .. ":", loaded)
    return nil
end

do
    local framework = ReplicatedStorage:WaitForChild("Framework", xDTaraZ.Config.LoadTimeout)
    local features = framework and framework:WaitForChild("Features", xDTaraZ.Config.LoadTimeout)
    local function Load(path) return GameLib.Require(GameLib.Find(features, path)) end

    GameLib.Dice = Load("Rolling.Dice")
    GameLib.Rebirths = Load("Rebirth.Rebirths")
    GameLib.Upgrades = Load("Upgrades.Upgrades")
    GameLib.Tree = Load("Upgrades.TreeStructure")
    GameLib.Grades = Load("Grades.Grades")
    GameLib.Traits = Load("Traits.Traits")
    GameLib.Towers = Load("Towers.Towers")
    GameLib.Rarities = GameLib.Require(GameLib.Find(framework, "Other.Rarities"))
    GameLib.Entry = Load("Inventory.EntryRegistry")
    GameLib.Mutations = Load("Inventory.Kinds.Unit.Mutations")
    GameLib.UnitUtil = Load("Inventory.Kinds.Unit.UnitUtil")
    GameLib.Codes = Load("Codes.CodesConfig")
    GameLib.Quests = Load("Quests.QuestConfig")
    GameLib.RollController = Load("Rolling.RollController")
    GameLib.Buffs = Load("Buffs.BuffController")
    GameLib.BuffsConfig = Load("Buffs.BuffsConfig")
    GameLib.FusingConfig = Load("Fusing.FusingConfig")

    local rewards = GameLib.Find(features, "Rewards")
    GameLib.Daily = GameLib.Require(rewards and rewards:FindFirstChild("DailyRewardConfig", true))
    GameLib.DataClient = GameLib.Require(GameLib.Find(ReplicatedStorage, "Packages.Data.Client"))
end

GameLib.EntryCache = {}

function GameLib.EntryOf(name)
    local registry = GameLib.Entry
    if not registry or not name then return nil end
    local cached = GameLib.EntryCache[name]
    if cached ~= nil then return cached or nil end
    local ok, config = pcall(registry.getEntryConfig, name)
    GameLib.EntryCache[name] = ok and config or false
    return ok and config or nil
end

function GameLib.GradeOrder(gradeName)
    local grade = gradeName and GameLib.Grades and GameLib.Grades[gradeName]
    return type(grade) == "table" and tonumber(grade.order) or 0
end

---@return number  strongest multiplier, order breaks ties
function GameLib.TraitPower(traitName)
    local trait = traitName and GameLib.Traits and GameLib.Traits[traitName]
    if type(trait) ~= "table" then return 0 end
    local best = math.max(tonumber(trait.incomeMultiplier) or 0, tonumber(trait.damageMultiplier) or 0,
        tonumber(trait.healthMultiplier) or 0)
    return best + (tonumber(trait.order) or 0) / 1000
end

function GameLib.RarityOrder(rarityName)
    local rarities = GameLib.Rarities
    if not rarities or not rarityName then return 0 end
    local ok, entry = pcall(rarities.Get, rarityName)
    return ok and type(entry) == "table" and tonumber(entry.sortOrder) or 0
end

---@return string[]  names of every entry of a kind, sorted
function GameLib.NamesOfKind(kind)
    local registry = GameLib.Entry
    local names = {}
    if not registry then return names end
    local ok, entries = pcall(registry.entriesOfKind, kind)
    if ok and type(entries) == "table" then
        for name in pairs(entries) do names[#names + 1] = tostring(name) end
    end
    table.sort(names)
    return names
end

function GameLib.GradeNames()
    local names = Util.SortedKeys(GameLib.Grades or {})
    table.sort(names, function(a, b) return GameLib.GradeOrder(a) < GameLib.GradeOrder(b) end)
    return names
end

function GameLib.TraitNames()
    local names = {}
    for name, trait in pairs(GameLib.Traits or {}) do
        if type(trait) == "table" and GameLib.TraitPower(name) > 0 then names[#names + 1] = name end
    end
    table.sort(names, function(a, b) return GameLib.TraitPower(a) < GameLib.TraitPower(b) end)
    return names
end

function GameLib.MutationNames()
    local names = {}
    for name, mutation in pairs(GameLib.Mutations or {}) do
        if type(mutation) == "table" then names[#names + 1] = name end
    end
    table.sort(names, function(a, b)
        return (tonumber(GameLib.Mutations[a].chance) or 0) < (tonumber(GameLib.Mutations[b].chance) or 0)
    end)
    return names
end

---@return string[]  unit rarities present in the registry, worst first
function GameLib.UnitRarities()
    local seen = {}
    local registry = GameLib.Entry
    if registry then
        local ok, units = pcall(registry.entriesOfKind, "Unit")
        if ok and type(units) == "table" then
            for _, config in pairs(units) do
                if type(config) == "table" and config.rarity then seen[config.rarity] = true end
            end
        end
    end
    local list = {}
    for rarity in pairs(seen) do list[#list + 1] = rarity end
    table.sort(list, function(a, b) return GameLib.RarityOrder(a) < GameLib.RarityOrder(b) end)
    return list
end

function GameLib.ShopNames()
    local names = {}
    local shop = GameLib.Quests and GameLib.Quests.Shop
    for _, item in ipairs(type(shop) == "table" and shop or {}) do
        if type(item) == "table" and item.name and not item.gamepass then names[#names + 1] = item.name end
    end
    return names
end

xDTaraZ.Net = {}
local Network = ReplicatedStorage:WaitForChild("Network", xDTaraZ.Config.LoadTimeout)

---@return Instance?  remote at a dotted path under Network
function xDTaraZ.Net.Get(path)
    return GameLib.Find(Network, path)
end

function xDTaraZ.Net.Fire(path, ...)
    local remote = xDTaraZ.Net.Get(path)
    if remote then remote:FireServer(...) end
end

---@return boolean, any  invoke success, server reply
function xDTaraZ.Net.Invoke(path, ...)
    local remote = xDTaraZ.Net.Get(path)
    if not remote then return false, "no remote" end
    return pcall(remote.InvokeServer, remote, ...)
end

xDTaraZ.Data = {}

---@return any  raw replicated value of a top-level profile field
function xDTaraZ.Data.Read(field)
    local client = GameLib.DataClient
    if not client then return nil end
    local ok, proxy = pcall(function() return client:get({ field }) end)
    if not ok then return nil end
    if type(proxy) == "table" then
        local okCall, value = pcall(proxy)
        if okCall then return value end
    end
    return proxy
end

function xDTaraZ.Data.Table(field)
    local value = xDTaraZ.Data.Read(field)
    return type(value) == "table" and value or {}
end

function xDTaraZ.Data.Money()
    return tonumber(xDTaraZ.Data.Read("Money")) or 0
end

function xDTaraZ.Data.Rebirth()
    return tonumber(xDTaraZ.Data.Read("Rebirth")) or 0
end

function xDTaraZ.Data.Rolls()
    return tonumber(xDTaraZ.Data.Read("Rolls")) or 0
end

function xDTaraZ.Data.Token(name)
    local total = 0
    for _, entry in pairs(xDTaraZ.Data.Table("Inventory")) do
        if type(entry) == "table" and entry.name == name then
            total += tonumber(entry.amount) or 0
        end
    end
    return total
end

---@return table<string, boolean>  unit keys placed on the plot or in the tower team
function xDTaraZ.Data.BusyKeys()
    local busy = {}
    for _, slot in pairs(xDTaraZ.Data.Table("Slots")) do
        if type(slot) == "table" and slot.unitId then busy[tostring(slot.unitId)] = true end
    end
    for _, key in pairs(xDTaraZ.Data.Table("TowerTeam")) do
        if type(key) == "string" then busy[key] = true end
    end
    return busy
end

---@return table[]  items of one kind {Key, Name, Amount}
function xDTaraZ.Data.ItemsOfKind(kind)
    local items = {}
    for key, entry in pairs(xDTaraZ.Data.Table("Inventory")) do
        if type(entry) == "table" and entry.name then
            local config = GameLib.EntryOf(entry.name)
            if config and config.kind == kind then
                items[#items + 1] = { Key = tostring(key), Name = entry.name, Amount = tonumber(entry.amount) or 1 }
            end
        end
    end
    return items
end

---@return number  unit entries the server counts against Unit Storage, trade reservations included
function xDTaraZ.Data.UnitCount()
    local count = 0
    for _, entry in pairs(xDTaraZ.Data.Table("Inventory")) do
        local config = type(entry) == "table" and entry.name and GameLib.EntryOf(entry.name)
        if config and config.kind == "Unit" then count += 1 end
    end
    local trade = xDTaraZ.Data.Read("PendingTrade")
    if type(trade) == "table" and not trade.applied then count += tonumber(trade.reservedUnits) or 0 end
    return count
end

xDTaraZ.Data.UnitCache = { At = -1, List = {} }

---@return table[]  owned units, plotted first then by income; shared snapshot
function xDTaraZ.Data.Units()
    local cache = xDTaraZ.Data.UnitCache
    local now = osClock()
    if now - cache.At < xDTaraZ.Config.SnapshotTtl then return cache.List end
    cache.List = xDTaraZ.Data.ScanUnits()
    cache.At = now
    return cache.List
end

function xDTaraZ.Data.Invalidate()
    xDTaraZ.Data.UnitCache.At = -1
end

function xDTaraZ.Data.IncomeAt(config, attrs, level)
    local probe = table.clone(attrs)
    probe.level = level
    local ok, value = pcall(config.income, probe)
    return ok and tonumber(value) or 0
end

function xDTaraZ.Data.LevelPrice(unit, level)
    local probe = table.clone(unit.Attr)
    probe.level = level
    local ok, price = pcall(GameLib.UnitUtil.GetLevelPrice, unit.Name, probe)
    return ok and tonumber(price) or math.huge
end

function xDTaraZ.Data.ScanUnits()
    local busy = xDTaraZ.Data.BusyKeys()
    local units = {}
    for key, entry in pairs(xDTaraZ.Data.Table("Inventory")) do
        if type(entry) == "table" and entry.name then
            local config = GameLib.EntryOf(entry.name)
            if config and config.kind == "Unit" then
                local attrs = type(entry.attributes) == "table" and entry.attributes or {}
                local rarity = config.rarity
                if type(config.getRarity) == "function" then
                    local ok, dynamic = pcall(config.getRarity, attrs)
                    if ok and dynamic then rarity = dynamic end
                end
                local income, potential = 0, 0
                if type(config.income) == "function" then
                    local ok, value = pcall(config.income, attrs)
                    if ok then income = tonumber(value) or 0 end
                    potential = xDTaraZ.Data.IncomeAt(config, attrs, 1)
                end
                local chance
                if type(config.chance) == "function" and not config.limited and (tonumber(entry.amount) or 1) == 1 then
                    local ok, value = pcall(config.chance, attrs)
                    chance = ok and tonumber(value) or nil
                end
                key = tostring(key)
                units[#units + 1] = {
                    Key = key,
                    Name = entry.name,
                    Attr = attrs,
                    Rarity = rarity,
                    Grade = attrs.grade,
                    Trait = attrs.trait,
                    Mutation = attrs.mutation,
                    Level = tonumber(attrs.level) or 1,
                    Locked = attrs.locked == true,
                    Busy = busy[key] == true,
                    Value = income,
                    Potential = potential,
                    Chance = chance,
                }
            end
        end
    end
    table.sort(units, function(a, b)
        if a.Busy ~= b.Busy then return a.Busy end
        return a.Value > b.Value
    end)
    return units
end

xDTaraZ.Player = { Client = LocalPlayer }

function xDTaraZ.Player:Bind(character)
    self.Character = character
    self.Humanoid = character:WaitForChild("Humanoid", xDTaraZ.Config.LoadTimeout)
    self.Root = character:WaitForChild("HumanoidRootPart", xDTaraZ.Config.LoadTimeout)
end

xDTaraZ.Scheduler = { Jobs = {}, Booted = false }

---@param interval number|function  seconds, or a getter read every tick
---@param toggles string[]?          options switched off when the job keeps failing
function xDTaraZ.Scheduler.Every(name, interval, fn, toggles)
    xDTaraZ.Scheduler.Jobs[name] = { Interval = interval, Fn = fn, Last = 0, Running = false, Fails = 0, Toggles = toggles or {} }
end

---@return boolean  one of the job's toggles is on
function xDTaraZ.Scheduler.Wanted(job)
    for _, idx in ipairs(job.Toggles) do
        if xDTaraZ.Options[idx] == true then return true end
    end
    return false
end

function xDTaraZ.Scheduler.Run(name, job)
    local ok, err = pcall(job.Fn)
    job.Running = false
    if ok then
        job.Fails, job.FailSince = 0, nil
        return
    end

    job.Fails += 1
    job.FailSince = job.FailSince or osClock()
    if job.Fails == 1 then warn("[AnimeDice] job " .. name .. " failing:", err) end

    local config = xDTaraZ.Config
    if job.Fails < config.JobFailLimit or osClock() - job.FailSince < config.JobFailWindow then return end
    if not xDTaraZ.Scheduler.Wanted(job) then return end
    job.Halted = true
    table.insert(xDTaraZ.State.Halted, { name, job.Toggles, tostring(err):match("^[^\n]*") })
end

function xDTaraZ.Scheduler.Step()
    local now = osClock()
    for name, job in pairs(xDTaraZ.Scheduler.Jobs) do
        local interval = type(job.Interval) == "function" and job.Interval() or job.Interval
        if not job.Running and not job.Halted and now - job.Last >= interval then
            job.Last = now
            job.Running = true
            task.spawn(xDTaraZ.Scheduler.Run, name, job)
        end
    end
end

function xDTaraZ.Scheduler.Resume(idx)
    for _, job in pairs(xDTaraZ.Scheduler.Jobs) do
        if table.find(job.Toggles, idx) then
            job.Halted, job.Fails, job.FailSince = false, 0, nil
        end
    end
end

function xDTaraZ.Scheduler.Boot()
    if xDTaraZ.Scheduler.Booted then return end
    xDTaraZ.Scheduler.Booted = true
    xDTaraZ:Connect(RunService.Heartbeat, xDTaraZ.Scheduler.Step)
end

xDTaraZ.AntiAfk = { Connection = nil }

function xDTaraZ.AntiAfk.OnIdled()
    if not xDTaraZ.Options.AntiAfk then return end
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.zero)
end

function xDTaraZ.AntiAfk.Start()
    xDTaraZ.Options.AntiAfk = true
    if not xDTaraZ.AntiAfk.Connection then
        xDTaraZ.AntiAfk.Connection = xDTaraZ:Connect(LocalPlayer.Idled, xDTaraZ.AntiAfk.OnIdled)
    end
end

function xDTaraZ.AntiAfk.Stop()
    xDTaraZ.Options.AntiAfk = false
end

xDTaraZ.Cutscene = { Saved = nil }

function xDTaraZ.Cutscene.Skip() end

function xDTaraZ.Cutscene.Apply()
    local controller = GameLib.RollController
    if type(controller) ~= "table" or table.isfrozen(controller) or xDTaraZ.Cutscene.Saved then return end
    local original = rawget(controller, "PlayCutscene")
    if type(original) ~= "function" then return end
    xDTaraZ.Cutscene.Saved = original
    rawset(controller, "PlayCutscene", xDTaraZ.Cutscene.Skip)
end

function xDTaraZ.Cutscene.Restore()
    local controller = GameLib.RollController
    local original = xDTaraZ.Cutscene.Saved
    if not original then return end
    if rawget(controller, "PlayCutscene") == xDTaraZ.Cutscene.Skip then rawset(controller, "PlayCutscene", original) end
    xDTaraZ.Cutscene.Saved = nil
end

function xDTaraZ.Cutscene.Step()
    if xDTaraZ.Options.DisableCutscene then xDTaraZ.Cutscene.Apply() else xDTaraZ.Cutscene.Restore() end
end

xDTaraZ.Move = { NoClipConnection = nil, FlyConnection = nil, FlyForce = nil, JumpConnection = nil }

function xDTaraZ.Move.ApplyWalkSpeed()
    local hum = xDTaraZ.Player.Humanoid
    if hum and xDTaraZ.Options.WalkSpeed then hum.WalkSpeed = xDTaraZ.Options.WalkSpeedValue end
end

function xDTaraZ.Move.SpeedStart()
    xDTaraZ.Options.WalkSpeed = true
    xDTaraZ.Move.ApplyWalkSpeed()
end

function xDTaraZ.Move.SpeedStop()
    xDTaraZ.Options.WalkSpeed = false
    local hum = xDTaraZ.Player.Humanoid
    if hum then hum.WalkSpeed = 16 end
end

function xDTaraZ.Move.JumpStart()
    xDTaraZ.Options.InfiniteJump = true
    if xDTaraZ.Move.JumpConnection then return end
    xDTaraZ.Move.JumpConnection = xDTaraZ:Connect(UserInputService.JumpRequest, function()
        local hum = xDTaraZ.Player.Humanoid
        if xDTaraZ.Options.InfiniteJump and hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
end

function xDTaraZ.Move.JumpStop()
    xDTaraZ.Options.InfiniteJump = false
end

function xDTaraZ.Move.NoClipStart()
    xDTaraZ.Options.NoClip = true
    if xDTaraZ.Move.NoClipConnection then return end
    xDTaraZ.Move.NoClipConnection = xDTaraZ:Connect(RunService.Stepped, function()
        local char = xDTaraZ.Player.Character
        if not (xDTaraZ.Options.NoClip and char) then return end
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
        end
    end)
end

function xDTaraZ.Move.NoClipStop()
    xDTaraZ.Options.NoClip = false
    local char = xDTaraZ.Player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CanCollide = true end
end

function xDTaraZ.Move.FlyStart()
    if xDTaraZ.Move.FlyForce then return end
    local hrp = xDTaraZ.Player.Root
    if not hrp then return end
    xDTaraZ.Options.Fly = true

    local force = Instance.new("BodyVelocity")
    force.MaxForce = Vector3.one * 9e9
    force.Velocity = Vector3.zero
    force.Parent = hrp
    xDTaraZ.Move.FlyForce = force

    if xDTaraZ.Move.FlyConnection then return end
    xDTaraZ.Move.FlyConnection = xDTaraZ:Connect(RunService.RenderStepped, function()
        local bv = xDTaraZ.Move.FlyForce
        if not (xDTaraZ.Options.Fly and bv) then return end
        local look = Workspace.CurrentCamera.CFrame
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += look.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= look.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= look.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += look.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.yAxis end
        bv.Velocity = dir.Magnitude > 0 and dir.Unit * xDTaraZ.Options.FlySpeed or Vector3.zero
    end)
end

function xDTaraZ.Move.FlyStop()
    xDTaraZ.Options.Fly = false
    if xDTaraZ.Move.FlyForce then
        xDTaraZ.Move.FlyForce:Destroy()
        xDTaraZ.Move.FlyForce = nil
    end
end

function xDTaraZ.Move.Rebind()
    xDTaraZ.Move.ApplyWalkSpeed()
    if xDTaraZ.Options.Fly then
        xDTaraZ.Move.FlyForce = nil
        xDTaraZ.Move.FlyStart()
    end
end

xDTaraZ.Roll = { Status = "Off", Session = 0, LastRolls = nil, StorageFull = false }

---@return boolean, number, number  room left for a roll, units held, units the server allows
function xDTaraZ.Roll.Room()
    local buffs = GameLib.Buffs
    if not buffs then return true, 0, 0 end
    local okStorage, storage = pcall(buffs.GetBuff, "Unit Storage")
    local okRolls, rolls = pcall(buffs.GetBuff, "Rolls")
    storage, rolls = tonumber(okStorage and storage), tonumber(okRolls and rolls)
    if not storage or not rolls then return true, 0, 0 end
    local limit = storage + rolls - 1
    local held = xDTaraZ.Data.UnitCount()
    return held < limit, held, limit
end

function xDTaraZ.Roll.SetStorageFull(full, held, limit)
    if full == xDTaraZ.Roll.StorageFull then return end
    xDTaraZ.Roll.StorageFull = full
    if not full then return end
    table.insert(xDTaraZ.State.Notices, {
        "Unit storage full",
        string.format("%d/%d units. Rolling paused until you sell or clear some.", held, limit),
    })
end

function xDTaraZ.Roll.Once()
    return xDTaraZ.Net.Invoke("RollService.RF.RollDice")
end

function xDTaraZ.Roll.ResetCounter()
    xDTaraZ.Roll.Session = 0
    xDTaraZ.Roll.LastRolls = xDTaraZ.Data.Rolls()
end

function xDTaraZ.Roll.Track()
    local rolls = xDTaraZ.Data.Rolls()
    if xDTaraZ.Roll.LastRolls and rolls > xDTaraZ.Roll.LastRolls then
        xDTaraZ.Roll.Session += rolls - xDTaraZ.Roll.LastRolls
    end
    xDTaraZ.Roll.LastRolls = rolls
end

function xDTaraZ.Roll.Step()
    xDTaraZ.Roll.Track()
    if not xDTaraZ.Options.AutoRoll then
        xDTaraZ.Roll.Status = "Off"
        xDTaraZ.Roll.StorageFull = false
        return
    end
    local hasRoom, held, limit = xDTaraZ.Roll.Room()
    xDTaraZ.Roll.SetStorageFull(not hasRoom, held, limit)
    if not hasRoom then
        xDTaraZ.Roll.Status = string.format("Storage full %d/%d, paused", held, limit)
        return
    end
    xDTaraZ.Roll.Status = "Rolling"
    xDTaraZ.Roll.Once()
end

function xDTaraZ.Roll.GetStatus()
    return string.format("%s · session %s · total %s", xDTaraZ.Roll.Status,
        Util.FormatNumber(xDTaraZ.Roll.Session), Util.FormatNumber(xDTaraZ.Data.Rolls()))
end

xDTaraZ.Plot = { Status = "Off" }

function xDTaraZ.Plot.CollectNow()
    for index, slot in pairs(xDTaraZ.Data.Table("Slots")) do
        local balance = type(slot) == "table" and tonumber(slot.balance) or 0
        if balance > 0 then
            xDTaraZ.Net.Fire("PlotService.RE.CollectBalance", tonumber(index))
            xDTaraZ.Economy.Collected += balance
        end
    end
end

---@return number  highest level whose price still pays back within the payback limit
function xDTaraZ.Plot.WorthLevel(unit, mult)
    local config = GameLib.EntryOf(unit.Name)
    if not config then return unit.Level end
    local gain = (xDTaraZ.Data.IncomeAt(config, unit.Attr, 2) - unit.Potential) * mult
    if gain <= 0 then return unit.Level end
    local cap = math.min(xDTaraZ.Options.LevelTarget, 500)
    local level = 1
    while level < cap and xDTaraZ.Data.LevelPrice(unit, level) / gain <= xDTaraZ.Options.LevelPayback do
        level += 1
    end
    return level
end

---@return number  income this unit reaches on the plot once cheap levels are bought
function xDTaraZ.Plot.Score(unit, mult)
    local config = GameLib.EntryOf(unit.Name)
    if not config then return unit.Value end
    local level = math.max(unit.Level, xDTaraZ.Plot.WorthLevel(unit, mult))
    return level == unit.Level and unit.Value or xDTaraZ.Data.IncomeAt(config, unit.Attr, level)
end

---@return table[]  { slot, placeKey } swaps that raise plot income, weakest slot first
function xDTaraZ.Plot.PlanSwaps()
    local slots = xDTaraZ.Data.Table("Slots")
    local byKey = {}
    for _, unit in ipairs(xDTaraZ.Data.Units()) do byKey[unit.Key] = unit end

    local mult = xDTaraZ.Economy.Multiplier()
    local current, placed = {}, {}
    for index, slot in pairs(slots) do
        if type(slot) ~= "table" then continue end
        local unit = slot.unitId and byKey[tostring(slot.unitId)]
        current[#current + 1] = { tonumber(index), unit and xDTaraZ.Plot.Score(unit, mult) or 0 }
        if unit then placed[unit.Key] = true end
    end
    table.sort(current, function(a, b) return a[2] < b[2] end)

    local bench = {}
    for _, unit in ipairs(xDTaraZ.Data.Units()) do
        if not placed[unit.Key] then bench[#bench + 1] = unit end
    end
    table.sort(bench, function(a, b) return a.Potential > b.Potential end)
    for index = #bench, #current * 2 + 1, -1 do bench[index] = nil end
    for _, unit in ipairs(bench) do unit.Score = xDTaraZ.Plot.Score(unit, mult) end
    table.sort(bench, function(a, b) return a.Score > b.Score end)

    local swaps = {}
    for index, slot in ipairs(current) do
        local candidate = bench[index]
        if not candidate or candidate.Score < slot[2] * xDTaraZ.Config.SwapMargin then break end
        swaps[#swaps + 1] = { slot[1], candidate.Key }
    end
    return swaps
end

---@return number  units moved onto the plot
function xDTaraZ.Plot.EquipBest()
    if xDTaraZ.Options.PlacementMode ~= "Potential" then
        xDTaraZ.Net.Fire("PlotService.RE.EquipBest")
        return 0
    end
    local moved = 0
    for _, swap in ipairs(xDTaraZ.Plot.PlanSwaps()) do
        if moved >= xDTaraZ.Config.SwapsPerPass then break end
        xDTaraZ.Net.Fire("PlotService.RE.CollectBalance", swap[1])
        local ok, held = xDTaraZ.Net.Invoke("UnitService.RF.Equip", swap[2])
        if not (ok and held) then break end
        task.wait(xDTaraZ.Config.PlaceDelay)
        xDTaraZ.Net.Fire("PlotService.RE.InteractSlot", swap[1])
        moved += 1
        task.wait(xDTaraZ.Config.PlaceDelay)
    end
    if moved > 0 then xDTaraZ.Data.Invalidate() end
    xDTaraZ.Plot.Status = moved > 0 and (moved .. " better units placed") or "Best units placed"
    return moved
end

function xDTaraZ.Plot.CollectStep()
    if xDTaraZ.Options.AutoCollect then xDTaraZ.Plot.CollectNow() end
end

function xDTaraZ.Plot.EquipStep()
    if xDTaraZ.Options.EquipBestUnitsAuto then xDTaraZ.Plot.EquipBest() end
end

---@return table[]  { slot, price, payback } for plotted units, fastest payback first
function xDTaraZ.Plot.LevelCandidates()
    local byKey = {}
    for _, unit in ipairs(xDTaraZ.Data.Units()) do byKey[unit.Key] = unit end
    local minRarity = GameLib.RarityOrder(xDTaraZ.Options.LevelMinRarity)
    local mult = xDTaraZ.Economy.Multiplier()
    local list = {}

    for index, slot in pairs(xDTaraZ.Data.Table("Slots")) do
        local unit = type(slot) == "table" and slot.unitId and byKey[tostring(slot.unitId)]
        if not unit or unit.Level >= xDTaraZ.Options.LevelTarget or GameLib.RarityOrder(unit.Rarity) < minRarity then continue end
        local config = GameLib.EntryOf(unit.Name)
        local okPrice, price = pcall(GameLib.UnitUtil.GetLevelPrice, unit.Name, unit.Attr)
        local nextAttrs = table.clone(unit.Attr)
        nextAttrs.level = unit.Level + 1
        local okGain, nextIncome = pcall(config.income, nextAttrs)
        local gain = okGain and ((tonumber(nextIncome) or 0) - unit.Value) * mult or 0
        if okPrice and tonumber(price) and gain > 0 then
            list[#list + 1] = { tonumber(index), price, price / gain }
        end
    end
    table.sort(list, function(a, b) return a[3] < b[3] end)
    return list
end

---@param ignoreGoal boolean?  manual pass: skip saving for dice/rebirth
---@return number  levels bought
function xDTaraZ.Plot.LevelPass(ignoreGoal)
    local money = xDTaraZ.Data.Money()
    local goal = not ignoreGoal and xDTaraZ.Economy.Goal()
    local levelled = 0

    for _, pick in ipairs(xDTaraZ.Plot.LevelCandidates()) do
        local slot, price, payback = pick[1], pick[2], pick[3]
        if payback > xDTaraZ.Options.LevelPayback then break end
        if price > money then continue end
        if goal and money - price < goal.Cost and payback >= xDTaraZ.Economy.Eta(goal.Cost, money - price) then continue end
        xDTaraZ.Net.Fire("PlotService.RE.LevelUpSlot", slot)
        money -= price
        levelled += 1
        task.wait(xDTaraZ.Config.LevelDelay)
    end
    xDTaraZ.Plot.Status = levelled > 0 and (levelled .. " levelled") or (goal and ("Saving for " .. goal.Name) or "No level worth it")
    return levelled
end

xDTaraZ.Economy = { Rate = 0, Collected = 0, LastTotal = nil, LastAt = 0, Earned = 0 }

function xDTaraZ.Economy.Sample()
    local total = 0
    for _, slot in pairs(xDTaraZ.Data.Table("Slots")) do
        if type(slot) == "table" then total += tonumber(slot.balance) or 0 end
    end
    local economy, now = xDTaraZ.Economy, osClock()
    if economy.LastTotal and now > economy.LastAt then
        local earned = total + economy.Collected - economy.LastTotal
        local sample = earned / (now - economy.LastAt)
        if sample >= 0 then
            economy.Rate = economy.Rate == 0 and sample or economy.Rate * 0.8 + sample * 0.2
            economy.Earned += earned
        end
    end
    economy.LastTotal, economy.LastAt, economy.Collected = total, now, 0
end

---@return number  real money per second divided by the plotted units' raw income
function xDTaraZ.Economy.Multiplier()
    local plotted = {}
    for _, slot in pairs(xDTaraZ.Data.Table("Slots")) do
        if type(slot) == "table" and slot.unitId then plotted[tostring(slot.unitId)] = true end
    end
    local raw = 0
    for _, unit in ipairs(xDTaraZ.Data.Units()) do
        if plotted[unit.Key] then raw += unit.Value end
    end
    return (raw > 0 and xDTaraZ.Economy.Rate > 0) and xDTaraZ.Economy.Rate / raw or 1
end

---@return table?  cheapest enabled goal {Name, Cost} still out of reach
function xDTaraZ.Economy.Goal()
    local goals = {}
    if xDTaraZ.Options.AutoRebirth then
        local rebirth = xDTaraZ.Rebirth.Next()
        if rebirth then goals[#goals + 1] = { Name = "rebirth", Cost = tonumber(rebirth.cost) or math.huge } end
    end
    if xDTaraZ.Options.AutoBuyDice then
        local name, price = xDTaraZ.Dice.NextTarget()
        if name then goals[#goals + 1] = { Name = name .. " dice", Cost = price } end
    end
    table.sort(goals, function(a, b) return a.Cost < b.Cost end)
    return goals[1]
end

function xDTaraZ.Economy.Eta(cost, money)
    local rate = xDTaraZ.Economy.Rate
    if cost <= money then return 0 end
    return rate > 0 and (cost - money) / rate or math.huge
end

function xDTaraZ.Economy.Step()
    xDTaraZ.Economy.Sample()
    local options = xDTaraZ.Options
    if options.AutoBuyDice or options.AutoEquipBestDice then xDTaraZ.Dice.Step() end
    if options.AutoRebirth then xDTaraZ.Rebirth.RebirthNow() end
    if options.AutoBuyUpgrades then xDTaraZ.Upgrade.BuyAll() end
    if options.AutoLevelUp then xDTaraZ.Plot.LevelPass() end
end

function xDTaraZ.Economy.GetStatus()
    local goal = xDTaraZ.Economy.Goal()
    local text = "Income " .. Util.FormatNumber(xDTaraZ.Economy.Rate) .. "/s"
    if not goal then return text end
    local eta = xDTaraZ.Economy.Eta(goal.Cost, xDTaraZ.Data.Money())
    local etaText = eta == math.huge and "?" or (eta < 60 and string.format("%ds", eta) or string.format("%dm", math.floor(eta / 60)))
    return string.format("%s · %s in %s", text, goal.Name, etaText)
end

xDTaraZ.Dice = { Status = "Off" }

function xDTaraZ.Dice.OwnedSet()
    local owned = { Basic = true }
    for key, value in pairs(xDTaraZ.Data.Table("OwnedDice")) do
        if type(key) == "number" then owned[value] = true elseif value then owned[key] = true end
    end
    return owned
end

---@return string, number  best owned dice and its luck
function xDTaraZ.Dice.BestOwned()
    local owned = xDTaraZ.Dice.OwnedSet()
    local bestName, bestLuck = "Basic", 1
    for name, info in pairs(GameLib.Dice and GameLib.Dice.GetAll() or {}) do
        local luck = tonumber(info.luck) or 0
        if owned[name] and luck > bestLuck then bestName, bestLuck = name, luck end
    end
    return bestName, bestLuck
end

---@return string?  highest-luck dice affordable now that beats the best owned
function xDTaraZ.Dice.NextBuy()
    local owned = xDTaraZ.Dice.OwnedSet()
    local money = xDTaraZ.Data.Money()
    local _, pickLuck = xDTaraZ.Dice.BestOwned()
    local pick
    for name, info in pairs(GameLib.Dice and GameLib.Dice.GetAll() or {}) do
        local luck = tonumber(info.luck) or 0
        if not owned[name] and (tonumber(info.price) or math.huge) <= money and luck > pickLuck then
            pick, pickLuck = name, luck
        end
    end
    return pick
end

---@return string?, number  cheapest unowned dice luckier than the best owned
function xDTaraZ.Dice.NextTarget()
    local owned = xDTaraZ.Dice.OwnedSet()
    local _, bestLuck = xDTaraZ.Dice.BestOwned()
    local pick, pickPrice = nil, math.huge
    for name, info in pairs(GameLib.Dice and GameLib.Dice.GetAll() or {}) do
        local price = tonumber(info.price) or math.huge
        if not owned[name] and (tonumber(info.luck) or 0) > bestLuck and price < pickPrice then pick, pickPrice = name, price end
    end
    return pick, pickPrice
end

function xDTaraZ.Dice.EquipBest()
    local best = xDTaraZ.Dice.BestOwned()
    if best ~= xDTaraZ.Data.Read("Dice") then xDTaraZ.Net.Fire("DiceShopService.RE.EquipDice", best) end
end

function xDTaraZ.Dice.Step()
    if xDTaraZ.Options.AutoBuyDice then
        local buy = xDTaraZ.Dice.NextBuy()
        if buy then
            xDTaraZ.Net.Fire("DiceShopService.RE.BuyDice", buy)
            xDTaraZ.Dice.Status = "Bought " .. buy
            task.wait(xDTaraZ.Config.BuyDelay)
        end
    end
    if xDTaraZ.Options.AutoEquipBestDice or xDTaraZ.Options.AutoBuyDice then xDTaraZ.Dice.EquipBest() end
end

xDTaraZ.Upgrade = { Status = "Off" }

function xDTaraZ.Upgrade.Branch(name)
    return (name:gsub("%s+[IVXLC]+$", ""))
end

function xDTaraZ.Upgrade.Branches()
    local seen = {}
    for name in pairs(GameLib.Upgrades or {}) do
        if type(name) == "string" and name ~= "Start" then seen[xDTaraZ.Upgrade.Branch(name)] = true end
    end
    return Util.SortedKeys(seen)
end

---@return table  stat -> { base, percentage } summed over owned upgrades
function xDTaraZ.Upgrade.OwnedBuffs(owned)
    local sums = {}
    for name in pairs(owned) do
        local info = GameLib.Upgrades and GameLib.Upgrades[name]
        for stat, buff in pairs(type(info) == "table" and info.buffs or {}) do
            sums[stat] = sums[stat] or { base = 0, percentage = 0 }
            if sums[stat][buff.bucket] then sums[stat][buff.bucket] += tonumber(buff.amount) or 0 end
        end
    end
    return sums
end

---@return number  relative boost this buff adds to its stat (0.1 = +10%)
function xDTaraZ.Upgrade.Gain(stat, buff, sums)
    local amount = tonumber(buff.amount) or 0
    local sum = sums[stat] or { base = 0, percentage = 0 }
    if stat == "Roll Duration" then
        local ok, duration = pcall(GameLib.Buffs.GetBuff, stat)
        duration = ok and tonumber(duration) or 0
        return duration + amount > 0 and duration / (duration + amount) - 1 or 0
    end
    if buff.bucket == "percentage" then return amount / (1 + sum.percentage) end
    if buff.bucket == "multiplier" then return amount - 1 end
    local ok, config = pcall(GameLib.BuffsConfig.GetBuff, stat)
    local default = ok and type(config) == "table" and tonumber(config.default) or 1
    return amount / math.max(default + sum.base, 1e-3)
end

---@return number?  money spent per +1% luck on the next dice, nil when dice are maxed
function xDTaraZ.Upgrade.DiceDeal()
    local name, price = xDTaraZ.Dice.NextTarget()
    if not name then return nil end
    local _, bestLuck = xDTaraZ.Dice.BestOwned()
    local luck = tonumber(GameLib.Dice.GetAll()[name].luck) or bestLuck
    return price / math.max(luck / bestLuck - 1, 1e-3)
end

---@return boolean  price is a small slice of what the player earns
function xDTaraZ.Upgrade.Cheap(stat, price, money, rate)
    local seconds = xDTaraZ.Config.UtilitySeconds
    if rate > 0 then return price <= rate * (seconds[stat] or seconds.Default) end
    return price <= money * xDTaraZ.Config.UtilityFallbackShare
end

---@return table[]  { name, price, rank } upgrades worth buying now, best first
function xDTaraZ.Upgrade.Worth()
    local owned = xDTaraZ.Data.Table("Upgrades")
    local sums = xDTaraZ.Upgrade.OwnedBuffs(owned)
    local money, rate = xDTaraZ.Data.Money(), xDTaraZ.Economy.Rate
    local goal = xDTaraZ.Economy.Goal()
    local diceDeal = xDTaraZ.Upgrade.DiceDeal()
    local filter = Util.SetFromList(xDTaraZ.Options.UpgradeFilter)
    local anyBranch = next(filter) == nil
    local tree = GameLib.Tree
    local picks = {}

    for name, info in pairs(GameLib.Upgrades or {}) do
        if type(info) ~= "table" or name == "Start" or owned[name] then continue end
        local price = tonumber(info.price) or math.huge
        if price > money or not (anyBranch or filter[xDTaraZ.Upgrade.Branch(name)]) then continue end
        local parent = tree.GetParent(name)
        if parent and parent ~= "Start" and not owned[parent] then continue end

        local rank
        for stat, buff in pairs(info.buffs or {}) do
            local gain = xDTaraZ.Upgrade.Gain(stat, buff, sums)
            if gain <= 0 then continue end
            if stat == "Money Multiplier" and rate > 0 then
                local payback = price / (rate * gain)
                local etaAfter = goal and xDTaraZ.Economy.Eta(goal.Cost, money - price) or math.huge
                if payback <= xDTaraZ.Options.UpgradePayback or payback < etaAfter then rank = payback end
            elseif xDTaraZ.Config.RollStats[stat] and diceDeal then
                if price / (gain * 100) <= diceDeal / 100 then rank = 1e6 + price / money end
            elseif xDTaraZ.Upgrade.Cheap(stat, price, money, rate) then
                rank = 2e6 + price / money
            end
        end
        if rank then picks[#picks + 1] = { name, price, rank } end
    end
    table.sort(picks, function(a, b) return a[3] < b[3] end)
    return picks
end

---@return string  cheapest upgrade still locked behind money
function xDTaraZ.Upgrade.NextHint()
    local owned = xDTaraZ.Data.Table("Upgrades")
    local pick, price = nil, math.huge
    for name, info in pairs(GameLib.Upgrades or {}) do
        if type(info) ~= "table" or name == "Start" or owned[name] then continue end
        local parent = GameLib.Tree.GetParent(name)
        if parent and parent ~= "Start" and not owned[parent] then continue end
        if (tonumber(info.price) or math.huge) < price then pick, price = name, tonumber(info.price) end
    end
    return pick and string.format("Next: %s at %s", pick, Util.FormatNumber(price)) or "All upgrades owned"
end

---@return number  upgrades bought
function xDTaraZ.Upgrade.BuyAll()
    local bought, spent = 0, 0
    for _, pick in ipairs(xDTaraZ.Upgrade.Worth()) do
        if pick[2] + spent > xDTaraZ.Data.Money() then continue end
        xDTaraZ.Net.Fire("RE.BuyUpgrade", pick[1])
        spent += pick[2]
        bought += 1
        task.wait(xDTaraZ.Config.BuyDelay)
    end
    xDTaraZ.Upgrade.Status = bought > 0 and (bought .. " bought") or xDTaraZ.Upgrade.NextHint()
    return bought
end

xDTaraZ.Sell = { Status = "Off" }

---@return string[]  unit keys to sell under the current filters
function xDTaraZ.Sell.Pick()
    local wanted = Util.SetFromList(xDTaraZ.Options.SellRarities)
    if next(wanted) == nil then return {} end
    local keepMutation = Util.SetFromList(xDTaraZ.Options.SellKeepMutations)
    local keep = math.max(xDTaraZ.Options.KeepPerRarity, 0)

    local byRarity = {}
    for _, unit in ipairs(xDTaraZ.Data.Units()) do
        if unit.Busy or unit.Locked or not wanted[unit.Rarity] then continue end
        if unit.Mutation and keepMutation[unit.Mutation] then continue end
        byRarity[unit.Rarity] = byRarity[unit.Rarity] or {}
        table.insert(byRarity[unit.Rarity], unit)
    end

    local keys = {}
    for _, list in pairs(byRarity) do
        for index = keep + 1, #list do keys[#keys + 1] = list[index].Key end
    end
    return keys
end

function xDTaraZ.Sell.SellNow()
    local keys = xDTaraZ.Sell.Pick()
    if #keys == 0 then xDTaraZ.Sell.Status = "Nothing to sell" return xDTaraZ.Sell.Status end
    local before = xDTaraZ.Data.Money()
    xDTaraZ.Net.Invoke("SellService.RF.SellInventory", keys)
    xDTaraZ.Data.Invalidate()
    xDTaraZ.Sell.Status = string.format("%d sold (+%s)", #keys, Util.FormatNumber(xDTaraZ.Data.Money() - before))
    return xDTaraZ.Sell.Status
end

function xDTaraZ.Sell.Step()
    if xDTaraZ.Options.AutoSell then xDTaraZ.Sell.SellNow() end
end

xDTaraZ.Storage = { Status = "-" }

function xDTaraZ.Storage.Cap()
    local buffs = GameLib.Buffs
    local ok, cap = pcall(function() return buffs.GetBuff("Unit Storage") end)
    return ok and tonumber(cap) or math.huge
end

---@return number  units sold to make room for rolling
function xDTaraZ.Storage.Clear()
    local units = xDTaraZ.Data.Units()
    local cap = xDTaraZ.Storage.Cap()
    xDTaraZ.Storage.Status = string.format("%d/%s", #units, cap == math.huge and "?" or tostring(cap))
    if #units < cap - xDTaraZ.Config.StorageHeadroom then return 0 end

    local keepRank = GameLib.RarityOrder(xDTaraZ.Options.ClearKeepRarity)
    local keepMutation = Util.SetFromList(xDTaraZ.Options.SellKeepMutations)
    local spare = {}
    for _, unit in ipairs(units) do
        if unit.Busy or unit.Locked or (unit.Mutation and keepMutation[unit.Mutation]) then continue end
        if keepRank > 0 and GameLib.RarityOrder(unit.Rarity) >= keepRank then continue end
        spare[#spare + 1] = unit
    end
    table.sort(spare, function(a, b) return a.Potential < b.Potential end)

    local excess = #units - math.floor(cap * xDTaraZ.Config.StorageRefill)
    local keys = {}
    for index = 1, math.min(excess, #spare) do keys[index] = spare[index].Key end
    if #keys == 0 then xDTaraZ.Storage.Status ..= " · full, nothing sellable" return 0 end

    xDTaraZ.Net.Invoke("SellService.RF.SellInventory", keys)
    xDTaraZ.Data.Invalidate()
    return #keys
end

function xDTaraZ.Storage.Step()
    if xDTaraZ.Options.AutoClearStorage then xDTaraZ.Storage.Clear() end
end

xDTaraZ.Rebirth = { Status = "Off" }

---@return table?  next tier {cost, moneyMultiplier}, nil at max
function xDTaraZ.Rebirth.Next()
    local rebirths = GameLib.Rebirths
    if not rebirths then return nil end
    local ok, info = pcall(rebirths.GetNext, xDTaraZ.Data.Rebirth())
    return ok and type(info) == "table" and info or nil
end

function xDTaraZ.Rebirth.RebirthNow()
    local info = xDTaraZ.Rebirth.Next()
    if not info then xDTaraZ.Rebirth.Status = "Max rebirth" return false end
    if xDTaraZ.Data.Money() < (tonumber(info.cost) or math.huge) then
        xDTaraZ.Rebirth.Status = "Need " .. Util.FormatNumber(info.cost)
        return false
    end
    xDTaraZ.Net.Fire("RebirthService.RE.Rebirth")
    xDTaraZ.Rebirth.Status = "Rebirthed"
    return true
end

xDTaraZ.Grade = { Status = "Off" }

---@return table?  next unit that should be rerolled toward the target
function xDTaraZ.Grade.Pick()
    local target = GameLib.GradeOrder(xDTaraZ.Options.GradeTarget)
    local protected = xDTaraZ.Data.Table("ProtectedGrades")
    for _, unit in ipairs(xDTaraZ.Data.Units()) do
        if not unit.Busy or unit.Locked or GameLib.GradeOrder(unit.Grade) >= target then continue end
        if unit.Grade and protected[unit.Grade] and not xDTaraZ.Options.GradeOverwrite then continue end
        return unit
    end
    return nil
end

function xDTaraZ.Grade.RollOne()
    if xDTaraZ.Data.Token("Gems") < 1 then xDTaraZ.Grade.Status = "No Gems" return false end
    local unit = xDTaraZ.Grade.Pick()
    if not unit then xDTaraZ.Grade.Status = "All at target" return false end
    xDTaraZ.Net.Fire("GradeService.RE.Roll", unit.Key)
    xDTaraZ.Grade.Status = string.format("%s [%s]", unit.Name, unit.Grade or "-")
    return true
end

function xDTaraZ.Grade.Step()
    if xDTaraZ.Options.AutoGrade then xDTaraZ.Grade.RollOne() end
end

xDTaraZ.Trait = { Status = "Off" }

function xDTaraZ.Trait.Pick()
    local target = GameLib.TraitPower(xDTaraZ.Options.TraitTarget)
    local protected = xDTaraZ.Data.Table("ProtectedTraits")
    for _, unit in ipairs(xDTaraZ.Data.Units()) do
        if not unit.Busy or unit.Locked or GameLib.TraitPower(unit.Trait) >= target then continue end
        if unit.Trait and protected[unit.Trait] and not xDTaraZ.Options.TraitOverwrite then continue end
        return unit
    end
    return nil
end

function xDTaraZ.Trait.RollOne()
    if xDTaraZ.Data.Token("Trait Reroll") < 1 then xDTaraZ.Trait.Status = "No Trait Reroll" return false end
    local unit = xDTaraZ.Trait.Pick()
    if not unit then xDTaraZ.Trait.Status = "All at target" return false end
    xDTaraZ.Net.Fire("TraitService.RE.Roll", unit.Key)
    xDTaraZ.Trait.Status = string.format("%s [%s]", unit.Name, unit.Trait or "-")
    return true
end

function xDTaraZ.Trait.Step()
    if xDTaraZ.Options.AutoTrait then xDTaraZ.Trait.RollOne() end
end

xDTaraZ.Fuse = { Status = "Off" }

---@return table[]  spare units the game allows to fuse, rarest first
function xDTaraZ.Fuse.Pool()
    local wanted = Util.SetFromList(xDTaraZ.Options.FuseRarities)
    local anyRarity = next(wanted) == nil
    local keepRank = GameLib.RarityOrder(xDTaraZ.Options.ClearKeepRarity)
    local keepMutation = Util.SetFromList(xDTaraZ.Options.SellKeepMutations)
    local pool = {}
    for _, unit in ipairs(xDTaraZ.Data.Units()) do
        if unit.Busy or unit.Locked or not unit.Chance then continue end
        if unit.Mutation and keepMutation[unit.Mutation] then continue end
        if anyRarity and keepRank > 0 and GameLib.RarityOrder(unit.Rarity) >= keepRank then continue end
        if anyRarity or wanted[unit.Rarity] then pool[#pool + 1] = unit end
    end
    table.sort(pool, function(a, b) return a.Chance > b.Chance end)
    return pool
end

---@return table?  three keys whose expected result is clearly rarer than the best input and cheap to fuse
function xDTaraZ.Fuse.PickTrio()
    local pool = xDTaraZ.Fuse.Pool()
    local config = GameLib.FusingConfig
    local average = tonumber(config.AverageMultiplier) or 0.667
    local budget = xDTaraZ.Data.Money() * xDTaraZ.Config.FuseMoneyShare
    for index = 1, #pool - 2 do
        local a, b, c = pool[index], pool[index + 1], pool[index + 2]
        local sum = a.Chance + b.Chance + c.Chance
        local ok, cost = pcall(config.GetCost, sum)
        if sum * average >= a.Chance * xDTaraZ.Config.FuseGain and ok and cost <= budget then
            return { a.Key, b.Key, c.Key, a.Name }
        end
    end
    return nil
end

function xDTaraZ.Fuse.FuseNow()
    local trio = xDTaraZ.Fuse.PickTrio()
    if not trio then xDTaraZ.Fuse.Status = "No worthwhile trio" return false end
    xDTaraZ.Net.Fire("FusingService.RE.Fuse", trio[1], trio[2], trio[3])
    xDTaraZ.Data.Invalidate()
    xDTaraZ.Fuse.Status = "Fused " .. trio[4] .. " +2"
    return true
end

function xDTaraZ.Fuse.Step()
    if xDTaraZ.Options.AutoFuse then xDTaraZ.Fuse.FuseNow() end
end

xDTaraZ.Tower = { Status = "Off", State = "Idle", NextAt = 0, Floor = 0, Best = 0, Runs = 0, Misses = 0, Ending = false }

---@return string[]  "Tower (Difficulty)" labels, easiest first
function xDTaraZ.Tower.Labels()
    local towers = GameLib.Towers and GameLib.Towers.GetAll() or {}
    local names = {}
    for name in pairs(towers) do names[#names + 1] = name end
    table.sort(names, function(a, b) return (tonumber(towers[a].order) or 0) < (tonumber(towers[b].order) or 0) end)
    local labels = {}
    for _, name in ipairs(names) do
        local difficulty = type(towers[name].difficulty) == "table" and towers[name].difficulty.name or "?"
        labels[#labels + 1] = string.format("%s (%s)", name, difficulty)
    end
    return labels
end

function xDTaraZ.Tower.NameFromLabel(label)
    return (tostring(label):gsub("%s*%b()$", ""))
end

function xDTaraZ.Tower.EquipTeam()
    xDTaraZ.Net.Fire("Towers.RE.EquipBestTowerTeam")
end

---@return number  seconds the server needs to play the returned actions
function xDTaraZ.Tower.Duration(actions)
    local total = 0
    for _, action in ipairs(actions) do
        total += xDTaraZ.Config.TowerActionTime[action.action] or 0.3
    end
    return total
end

---@return string[]  tower names, easiest first
function xDTaraZ.Tower.Order()
    local towers = GameLib.Towers and GameLib.Towers.GetAll() or {}
    local names = {}
    for name in pairs(towers) do names[#names + 1] = name end
    table.sort(names, function(a, b) return (tonumber(towers[a].order) or 0) < (tonumber(towers[b].order) or 0) end)
    return names
end

---@param floor number?  floor the last run reached, nil when the tower could not be entered
function xDTaraZ.Tower.Adapt(floor)
    if not xDTaraZ.Options.TowerSmart then return end
    local order = xDTaraZ.Tower.Order()
    local index = table.find(order, xDTaraZ.Options.TowerName) or 1
    local info = GameLib.Towers.Get(xDTaraZ.Options.TowerName)
    local top = math.min(tonumber(info and info.maxFloors) or math.huge, xDTaraZ.Options.TowerStopFloor)
    if floor and floor >= top and order[index + 1] then
        index += 1
    elseif (not floor or floor < xDTaraZ.Config.TowerDemoteFloor) and index > 1 then
        index -= 1
    end
    xDTaraZ.Options.TowerName = order[index]
end

function xDTaraZ.Tower.Leave()
    if xDTaraZ.Tower.Ending then return end
    xDTaraZ.Tower.Ending = true
    xDTaraZ.Net.Invoke("Towers.RF.CancelTower")
end

function xDTaraZ.Tower.Start()
    local now = osClock()
    if xDTaraZ.Options.TowerReequip or xDTaraZ.Tower.Runs == 0 then
        xDTaraZ.Tower.EquipTeam()
        task.wait(0.4)
    end
    local _, started = xDTaraZ.Net.Invoke("Towers.RF.PlayTower", xDTaraZ.Options.TowerName)
    xDTaraZ.Tower.State = "Climbing"
    xDTaraZ.Tower.Floor = 0
    xDTaraZ.Tower.Ending = not started
    xDTaraZ.Tower.NextAt = now
    xDTaraZ.Tower.Status = started and ("Entered " .. xDTaraZ.Options.TowerName) or "Finishing previous run"
end

function xDTaraZ.Tower.Climb()
    local ok, actions = xDTaraZ.Net.Invoke("Towers.RF.CompleteTowerFloor")
    local now = osClock()
    if not ok or type(actions) ~= "table" or #actions == 0 then
        xDTaraZ.Tower.Misses += 1
        xDTaraZ.Tower.NextAt = now + xDTaraZ.Config.TowerRetry
        if xDTaraZ.Tower.Misses >= 20 then
            xDTaraZ.Tower.Misses = 0
            xDTaraZ.Tower.Adapt(nil)
            xDTaraZ.Tower.State = "Idle"
            xDTaraZ.Tower.NextAt = now + xDTaraZ.Config.TowerStartCooldown
        end
        return
    end
    xDTaraZ.Tower.Misses = 0

    for _, action in ipairs(actions) do
        if tonumber(action.floor) then xDTaraZ.Tower.Floor = math.max(xDTaraZ.Tower.Floor, action.floor) end
    end
    xDTaraZ.Tower.Best = math.max(xDTaraZ.Tower.Best, xDTaraZ.Tower.Floor)
    xDTaraZ.Tower.NextAt = now + xDTaraZ.Tower.Duration(actions)

    if actions[#actions].action == "ended" then
        xDTaraZ.Tower.Runs += 1
        xDTaraZ.Tower.State = "Idle"
        xDTaraZ.Tower.Ending = false
        xDTaraZ.Tower.NextAt += xDTaraZ.Config.TowerStartCooldown
        xDTaraZ.Tower.Status = string.format("Run %d ended at floor %d", xDTaraZ.Tower.Runs, xDTaraZ.Tower.Floor)
        xDTaraZ.Tower.Adapt(xDTaraZ.Tower.Floor)
        return
    end
    if xDTaraZ.Tower.Floor >= xDTaraZ.Options.TowerStopFloor then xDTaraZ.Tower.Leave() end
    xDTaraZ.Tower.Status = string.format("%s · floor %d", xDTaraZ.Options.TowerName, xDTaraZ.Tower.Floor)
end

function xDTaraZ.Tower.Step()
    local tower = xDTaraZ.Tower
    if osClock() < tower.NextAt then return end
    if not xDTaraZ.Options.AutoTower then
        if tower.State == "Idle" then tower.Status = "Off" return end
        tower.Leave()
        tower.Climb()
        return
    end
    if tower.State == "Idle" then tower.Start() else tower.Climb() end
end

function xDTaraZ.Tower.GetStatus()
    if not xDTaraZ.Options.AutoTower then return "Off" end
    return string.format("%s · best %d · runs %d", xDTaraZ.Tower.Status, xDTaraZ.Tower.Best, xDTaraZ.Tower.Runs)
end

xDTaraZ.Gear = { Status = "Off" }

---@return number  slots changed
function xDTaraZ.Gear.EquipBest()
    local best = {}
    for _, item in ipairs(xDTaraZ.Data.ItemsOfKind("Gear")) do
        local config = GameLib.EntryOf(item.Name)
        local slot = config and config.slot
        if not slot then continue end
        local rank = GameLib.RarityOrder(config.rarity)
        if not best[slot] or rank > best[slot][2] then best[slot] = { item.Name, rank } end
    end

    local equipped = xDTaraZ.Data.Table("EquippedGear")
    local changed = 0
    for slot, pick in pairs(best) do
        if equipped[slot] ~= pick[1] then
            xDTaraZ.Net.Fire("GearService.RE.Equip", slot, pick[1])
            changed += 1
            task.wait(xDTaraZ.Config.GradeDelay)
        end
    end
    xDTaraZ.Gear.Status = changed > 0 and (changed .. " slots upgraded") or "Best gear on"
    return changed
end

function xDTaraZ.Gear.Step()
    if xDTaraZ.Options.AutoGear then xDTaraZ.Gear.EquipBest() end
end

xDTaraZ.Items = { Status = "Off" }

---@return boolean  true while the potion's effect is actually being used
function xDTaraZ.Items.PotionUseful(name)
    local towerWord = name:match("^(%a+)%s+%a+%s+[IVX]+$")
    if towerWord then
        return xDTaraZ.Options.AutoTower and xDTaraZ.Tower.State == "Climbing" and xDTaraZ.Options.TowerName:find(towerWord) ~= nil
    end
    if name:find("Luck") then return xDTaraZ.Options.AutoRoll end
    if name:find("Damage") then return xDTaraZ.Options.AutoTower end
    if name:find("Income") then return xDTaraZ.Economy.Rate > 0 end
    return true
end

---@param force boolean?  manual use: ignore timing
function xDTaraZ.Items.UsePotions(force)
    local filter = Util.SetFromList(xDTaraZ.Options.PotionFilter)
    local anyPotion = next(filter) == nil
    local active = xDTaraZ.Data.Table("ActiveEntries")
    local used = 0
    for _, item in ipairs(xDTaraZ.Data.ItemsOfKind("Boost")) do
        if not (force or xDTaraZ.Items.PotionUseful(item.Name)) then continue end
        if (anyPotion or filter[item.Name]) and not active[item.Name] then
            xDTaraZ.Net.Fire("BoostService.RE.Use", item.Key)
            used += 1
            task.wait(xDTaraZ.Config.ItemDelay)
        end
    end
    return used
end

function xDTaraZ.Items.UseSpins()
    local used = 0
    for _, item in ipairs(xDTaraZ.Data.ItemsOfKind("Spin")) do
        for _ = 1, math.min(item.Amount, 10) do
            xDTaraZ.Net.Fire("SpinService.RE.Use", item.Key)
            used += 1
            task.wait(xDTaraZ.Config.ItemDelay)
        end
    end
    return used
end

---@return number  ticket shop purchases made
function xDTaraZ.Items.BuyTicketShop()
    local wanted = Util.SetFromList(xDTaraZ.Options.TicketShopItems)
    if next(wanted) == nil then return 0 end
    local shop = GameLib.Quests and GameLib.Quests.Shop or {}
    local bought = 0
    for _, item in ipairs(shop) do
        if type(item) ~= "table" or not wanted[item.name] then continue end
        local cost = tonumber(item.tickets) or math.huge
        while xDTaraZ.Data.Token("Tickets") >= cost and bought < 50 do
            local before = xDTaraZ.Data.Token("Tickets")
            xDTaraZ.Net.Fire("QuestService.RE.Buy", item.name)
            bought += 1
            task.wait(xDTaraZ.Config.ItemDelay)
            if xDTaraZ.Data.Token("Tickets") >= before then break end
        end
    end
    return bought
end

function xDTaraZ.Items.Step()
    if xDTaraZ.Options.AutoPotion then xDTaraZ.Items.UsePotions() end
    if xDTaraZ.Options.AutoSpin then xDTaraZ.Items.UseSpins() end
    if xDTaraZ.Options.AutoTicketShop then xDTaraZ.Items.BuyTicketShop() end
end

xDTaraZ.Watch = { Seen = nil, Best = nil, Pulls = 0, StartAt = osClock(), StartGems = nil }

function xDTaraZ.Watch.Describe(unit)
    return string.format("%s [%s]%s", unit.Name, unit.Rarity or "?", unit.Mutation and (" · " .. unit.Mutation) or "")
end

function xDTaraZ.Watch.Alert(unit)
    local text = xDTaraZ.Watch.Describe(unit)
    pcall(function() xDTaraZ.Library:Notify("Rare pull", text, 8, "Success") end)
    local url = xDTaraZ.Options.WebhookUrl
    if type(url) ~= "string" or not url:find("^https://") or not Util.Request then return end
    local body = HttpService:JSONEncode({
        username = "Mario Hub",
        embeds = { { title = "Anime Dice · rare pull", description = text, color = xDTaraZ.Config.WebhookColor } },
    })
    local ok, err = pcall(Util.Request, { Url = url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = body })
    if not ok then warn("[AnimeDice] webhook:", err) end
end

function xDTaraZ.Watch.OnNew(unit)
    local watch = xDTaraZ.Watch
    watch.Pulls += 1
    if not watch.Best or unit.Potential > watch.Best.Potential then watch.Best = unit end
    if not xDTaraZ.Options.RareNotify then return end
    local rarities = Util.SetFromList(xDTaraZ.Options.NotifyRarities)
    local mutations = Util.SetFromList(xDTaraZ.Options.NotifyMutations)
    if rarities[unit.Rarity] or (unit.Mutation and mutations[unit.Mutation]) then watch.Alert(unit) end
end

function xDTaraZ.Watch.Step()
    local watch = xDTaraZ.Watch
    local units = xDTaraZ.Data.Units()
    if not watch.Seen then
        watch.Seen, watch.StartGems = {}, xDTaraZ.Data.Token("Gems")
        for _, unit in ipairs(units) do watch.Seen[unit.Key] = true end
        return
    end
    for _, unit in ipairs(units) do
        if not watch.Seen[unit.Key] then
            watch.Seen[unit.Key] = true
            watch.OnNew(unit)
        end
    end
end

---@return string[]  lines for the stats panel
function xDTaraZ.Watch.Stats()
    local watch = xDTaraZ.Watch
    local hours = math.max(osClock() - watch.StartAt, 1) / 3600
    return {
        string.format("Money %s/h · Rolls %s/h", Util.FormatNumber(xDTaraZ.Economy.Earned / hours), Util.FormatNumber(xDTaraZ.Roll.Session / hours)),
        string.format("Pulls %d · Gems %+d · Tower runs %d", watch.Pulls, xDTaraZ.Data.Token("Gems") - (watch.StartGems or 0), xDTaraZ.Tower.Runs),
        "Best pull: " .. (watch.Best and xDTaraZ.Watch.Describe(watch.Best) or "-"),
    }
end

xDTaraZ.Lock = { Status = "Off" }

---@return number  units locked this pass
function xDTaraZ.Lock.Step()
    if not xDTaraZ.Options.AutoLock then return 0 end
    local rank = GameLib.RarityOrder(xDTaraZ.Options.LockRarity)
    local mutations = Util.SetFromList(xDTaraZ.Options.LockMutations)
    local keys, count = {}, 0
    for _, unit in ipairs(xDTaraZ.Data.Units()) do
        if unit.Locked then continue end
        if (rank > 0 and GameLib.RarityOrder(unit.Rarity) >= rank) or (unit.Mutation and mutations[unit.Mutation]) then
            keys[unit.Key] = true
            count += 1
        end
    end
    if count > 0 then
        xDTaraZ.Net.Fire("UnitService.RE.SetLocked", keys)
        xDTaraZ.Data.Invalidate()
    end
    xDTaraZ.Lock.Status = count > 0 and (count .. " locked") or "Nothing new to lock"
    return count
end

xDTaraZ.Rejoin = { Hooked = false, Busy = false }

function xDTaraZ.Rejoin.Now()
    if xDTaraZ.Rejoin.Busy then return end
    xDTaraZ.Rejoin.Busy = true
    if Util.QueueTeleport then
        local resume = xDTaraZ.Options.Kaitun and "getgenv().AnimeDiceResume = true " or ""
        pcall(Util.QueueTeleport, resume .. xDTaraZ.Config.ReloadSource)
    end
    local ok, err = pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
    if not ok then warn("[AnimeDice] rejoin:", err) end
    task.delay(xDTaraZ.Config.RejoinRetry, function() xDTaraZ.Rejoin.Busy = false end)
end

function xDTaraZ.Rejoin.Start()
    xDTaraZ.Options.AutoRejoin = true
    if xDTaraZ.Rejoin.Hooked then return end
    xDTaraZ.Rejoin.Hooked = true
    xDTaraZ:Connect(GuiService.ErrorMessageChanged, function(message)
        if xDTaraZ.Options.AutoRejoin and message ~= "" then task.delay(xDTaraZ.Config.RejoinDelay, xDTaraZ.Rejoin.Now) end
    end)
end

function xDTaraZ.Rejoin.Stop()
    xDTaraZ.Options.AutoRejoin = false
end

xDTaraZ.Rewards = { Status = "Off", DailyRetryAt = 0, Member = nil }

function xDTaraZ.Rewards.RedeemAll()
    local redeemed = xDTaraZ.Data.Table("RedeemedCodes")
    local sent = 0
    for code in pairs(GameLib.Codes or {}) do
        if type(code) == "string" and not redeemed[code] then
            xDTaraZ.Net.Fire("CodesService.RE.RedeemCode", code)
            sent += 1
            task.wait(xDTaraZ.Config.RedeemDelay)
        end
    end
    return sent > 0 and (sent .. " codes redeemed") or "All codes already redeemed"
end

---@return number  quests claimed
function xDTaraZ.Rewards.ClaimQuests()
    local periods = GameLib.Quests and GameLib.Quests.Periods
    local records = xDTaraZ.Data.Table("Quests")
    if type(periods) ~= "table" then return 0 end
    local claimedCount = 0
    for period, def in pairs(periods) do
        local record = records[period]
        if type(record) ~= "table" or type(def) ~= "table" then continue end
        local progress = type(record.progress) == "table" and record.progress or {}
        local claimed = type(record.claimed) == "table" and record.claimed or {}
        for _, quest in ipairs(def.quests or {}) do
            if not claimed[quest.id] and (tonumber(progress[quest.id]) or 0) >= (tonumber(quest.target) or math.huge) then
                xDTaraZ.Net.Fire("QuestService.RE.Claim", period, quest.id, record.expiresAt)
                claimedCount += 1
                task.wait(xDTaraZ.Config.ClaimDelay)
            end
        end
    end
    return claimedCount
end

function xDTaraZ.Rewards.ClaimOffline()
    if (tonumber(xDTaraZ.Data.Read("PendingOfflineEarnings")) or 0) > 0 then
        xDTaraZ.Net.Fire("OfflineEarningsService.RE.Claim")
    end
end

function xDTaraZ.Rewards.DailyReady()
    local cooldown = GameLib.Daily and tonumber(GameLib.Daily.Cooldown) or 82800
    local last = tonumber(xDTaraZ.Data.Read("LastDailyRewardClaim")) or 0
    return os.time() - last >= cooldown and osClock() >= xDTaraZ.Rewards.DailyRetryAt
end

function xDTaraZ.Rewards.InGroup()
    if xDTaraZ.Rewards.Member == nil then
        local ok, member = pcall(LocalPlayer.IsInGroup, LocalPlayer, xDTaraZ.Config.GroupId)
        xDTaraZ.Rewards.Member = ok and member == true
    end
    return xDTaraZ.Rewards.Member
end

function xDTaraZ.Rewards.Step()
    if xDTaraZ.Options.AutoDaily and xDTaraZ.Rewards.DailyReady() then
        xDTaraZ.Rewards.DailyRetryAt = osClock() + 60
        xDTaraZ.Net.Fire("DailyRewardService.RE.Claim")
    end
    if xDTaraZ.Options.AutoGroup and not xDTaraZ.Data.Read("ClaimedGroupReward") and xDTaraZ.Rewards.InGroup() then
        xDTaraZ.Net.Fire("GroupRewardService.RE.Claim")
    end
    if xDTaraZ.Options.AutoOffline then xDTaraZ.Rewards.ClaimOffline() end
    if xDTaraZ.Options.AutoQuest then xDTaraZ.Rewards.ClaimQuests() end
end

xDTaraZ.Kaitun = { Status = "Off", Members = {
    "AntiAfk", "AutoRejoin", "RareNotify", "AutoLock", "TowerSmart", "AutoFuse", "DisableCutscene", "AutoRoll", "AutoCollect", "EquipBestUnitsAuto", "AutoLevelUp",
    "AutoBuyDice", "AutoEquipBestDice", "AutoBuyUpgrades", "AutoSell", "AutoRebirth", "AutoGrade",
    "AutoTrait", "AutoTower", "AutoPotion", "AutoSpin", "AutoTicketShop", "AutoDaily", "AutoGroup",
    "AutoOffline", "AutoQuest", "AutoGear", "AutoClearStorage",
}, SellDefault = { "Common", "Uncommon" } }

function xDTaraZ.Kaitun.SetMembers(on)
    local toggles = xDTaraZ.Library and xDTaraZ.Library.Toggles or {}
    for _, idx in ipairs(xDTaraZ.Kaitun.Members) do
        if toggles[idx] then toggles[idx]:SetValue(on) else xDTaraZ.Options[idx] = on end
    end
end

function xDTaraZ.Kaitun.Start()
    xDTaraZ.Options.Kaitun = true
    local options = xDTaraZ.Library and xDTaraZ.Library.Options or {}
    local function Default(idx, value)
        if next(Util.SetFromList(xDTaraZ.Options[idx])) ~= nil then return end
        if options[idx] then options[idx]:SetValue(Util.SetFromList(value)) end
        xDTaraZ.Options[idx] = value
    end
    Default("TicketShopItems", { "Gems" })
    Default("SellRarities", xDTaraZ.Kaitun.SellDefault)
    Default("LockMutations", { "Diamond", "Ruby", "Rainbow" })
    Default("NotifyRarities", { "Secret I", "Secret II", "Heavenly", "Exclusive" })
    Default("NotifyMutations", { "Ruby", "Rainbow" })
    if options.LevelTarget then options.LevelTarget:SetValue(200) end
    xDTaraZ.Options.LevelTarget = 200
    xDTaraZ.Kaitun.SetMembers(true)
    task.defer(function() xDTaraZ.Rewards.RedeemAll() end)
end

function xDTaraZ.Kaitun.Stop()
    xDTaraZ.Options.Kaitun = false
    xDTaraZ.Kaitun.SetMembers(false)
end

function xDTaraZ.Kaitun.GetStatus()
    return string.format("R%d · %s", xDTaraZ.Data.Rebirth(), xDTaraZ.Economy.GetStatus())
end

xDTaraZ.UI = { Labels = {} }
local Library, T

function xDTaraZ.UI.Detach(fn)
    return function(...)
        local packed = table.pack(...)
        task.defer(function()
            local ok, err = pcall(fn, table.unpack(packed, 1, packed.n))
            if not ok then warn("[AnimeDice] ui: " .. tostring(err)) end
        end)
    end
end

---@param module table  feature with Start/Stop
function xDTaraZ.UI.StartStop(module)
    return xDTaraZ.UI.Detach(function(on)
        if on then module.Start() else module.Stop() end
    end)
end

function xDTaraZ.UI.Notify(title, text, kind)
    Library:Notify(title, tostring(text), 4, kind or "Info")
end

---@return table  list from a game-data source, empty when it errors
function xDTaraZ.UI.Values(source, ...)
    local ok, list = pcall(source, ...)
    return ok and type(list) == "table" and list or {}
end

function xDTaraZ.UI.MultiDropdown(group, idx, text, desc, values)
    return group:AddDropdown(idx, {
        Text = text,
        Description = desc,
        Values = values,
        Multi = true,
        Default = {},
        AllowNull = true,
        Searchable = true,
    })
end

xDTaraZ.UI.Needs = {
    Kaitun = { "DataClient", "Entry" },
    AutoCollect = { "DataClient" },
    EquipBestUnitsAuto = { "DataClient", "Entry" },
    AutoLevelUp = { "DataClient", "Entry", "UnitUtil" },
    AutoTower = { "Towers" },
    AutoSell = { "DataClient", "Entry" },
    AutoClearStorage = { "DataClient", "Entry", "Buffs" },
    AutoBuyDice = { "DataClient", "Dice" },
    AutoEquipBestDice = { "DataClient", "Dice" },
    AutoBuyUpgrades = { "DataClient", "Upgrades", "Tree", "Buffs", "BuffsConfig" },
    AutoRebirth = { "DataClient", "Rebirths" },
    AutoGrade = { "DataClient", "Entry", "Grades" },
    AutoTrait = { "DataClient", "Entry", "Traits" },
    AutoFuse = { "DataClient", "Entry", "FusingConfig" },
    AutoGear = { "DataClient", "Entry" },
    AutoLock = { "DataClient", "Entry" },
    AutoPotion = { "DataClient", "Entry" },
    AutoSpin = { "DataClient", "Entry" },
    AutoTicketShop = { "DataClient", "Quests" },
    AutoQuest = { "DataClient", "Quests" },
    AutoDaily = { "DataClient" },
    AutoGroup = { "DataClient" },
    AutoOffline = { "DataClient" },
    RareNotify = { "DataClient", "Entry" },
}

---@return string?  first game module the option needs that could not be loaded
function xDTaraZ.UI.MissingFor(idx)
    for _, key in ipairs(xDTaraZ.UI.Needs[idx] or {}) do
        if GameLib[key] == nil then return key end
    end
    return nil
end

function xDTaraZ.UI.Gate()
    local blocked = 0
    for idx in pairs(xDTaraZ.UI.Needs) do
        if not Library.Options[idx] or not xDTaraZ.UI.MissingFor(idx) then continue end
        blocked += 1
        Library.Compat.Block(idx, T("Not available on this executor", "ใช้กับ executor นี้ไม่ได้"))
    end
    if blocked == 0 then return end
    Library:Notify("Mario Hub", T(blocked .. " features are not available on this executor", blocked .. " ฟีเจอร์ใช้กับ executor นี้ไม่ได้"), 8, "Warning")
end

function xDTaraZ.UI.DrainHalted()
    local halted = xDTaraZ.State.Halted
    while #halted > 0 do
        local entry = table.remove(halted, 1)
        local stopKaitun = false
        for _, idx in ipairs(entry[2]) do
            local toggle = Library.Toggles[idx]
            if toggle and toggle.Value == true then toggle:SetValue(false) end
            stopKaitun = stopKaitun or table.find(xDTaraZ.Kaitun.Members, idx) ~= nil
        end

        local kaitun = Library.Toggles.Kaitun
        if stopKaitun and kaitun and kaitun.Value == true then kaitun:SetValue(false) end
        Library:Notify("Mario Hub", entry[1] .. " stopped: " .. tostring(entry[3]), 8, "Error")
    end
end

function xDTaraZ.UI.DrainNotices()
    local notices = xDTaraZ.State.Notices
    while #notices > 0 do
        local notice = table.remove(notices, 1)
        Library:Notify(notice[1], notice[2], 8, "Warning")
    end
end

function xDTaraZ.UI.Panic()
    for _, toggle in pairs(Library.Toggles) do
        if toggle.Value == true then toggle:SetValue(false) end
    end
end

function xDTaraZ.UI.BuildMain(window)
    local tab = window:AddTab(T("Home", "หน้าแรก"), "mushroom", T("Status and full auto", "สถานะและโหมดอัตโนมัติ"))

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
    xDTaraZ.UI.Labels.Economy = status:AddParagraph({ Title = T("Economy", "เศรษฐกิจ"), Content = "-" })
    xDTaraZ.UI.Labels.Roll = status:AddParagraph({ Title = T("Rolling", "การทอย"), Content = "-" })
    xDTaraZ.UI.Labels.Units = status:AddParagraph({ Title = T("Units", "ตัวละคร"), Content = "-" })
    xDTaraZ.UI.Labels.Tower = status:AddParagraph({ Title = T("Tower", "หอคอย"), Content = "-" })

    local stats = tab:AddLeftGroupbox(T("Session Stats", "สถิติรอบนี้"), "flag")
    xDTaraZ.UI.Labels.Stats = stats:AddParagraph({ Title = T("This session", "รอบนี้"), Content = "-" })

    local master = tab:AddRightGroupbox(T("Kaitun", "ไคตุน"), "qblock")
    master:AddToggle("Kaitun", {
        Text = T("Kaitun (full auto)", "ไคตุน (อัตโนมัติทั้งหมด)"),
        Description = T("Rolls, levels, upgrades, grades, climbs towers and rebirths on its own", "ทอย อัปเลเวล อัปเกรด รีเกรด ไต่หอคอย และรีเบิร์ธเองทั้งหมด"),
        Callback = xDTaraZ.UI.StartStop(xDTaraZ.Kaitun),
    }):AddKeyPicker("KaitunKey", { Default = "None", Mode = "Toggle" })
    xDTaraZ.UI.Labels.Kaitun = master:AddParagraph({ Title = T("Progress", "ความคืบหน้า"), Content = "-" })
    master:AddButton({ Text = T("Panic - all off", "ฉุกเฉิน ปิดทั้งหมด"), Style = "Danger", Func = xDTaraZ.UI.Detach(xDTaraZ.UI.Panic) })

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

function xDTaraZ.UI.BuildFarm(window)
    local tab = window:AddTab(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "coin", T("Rolling, plot and levels", "ทอย ฐาน และเลเวล"))
    local rarities = xDTaraZ.UI.Values(GameLib.UnitRarities)

    local roll = tab:AddLeftGroupbox(T("Rolling", "การทอย"), "star")
    roll:AddToggle("AutoRoll", { Text = T("Fast roll", "ทอยเร็ว"), Description = T("Rolls non-stop with no roll animation", "ทอยต่อเนื่องไม่มีแอนิเมชัน") })
        :AddKeyPicker("AutoRollKey", { Default = "None", Mode = "Toggle" })
    roll:AddButton({ Text = T("Roll Once", "ทอย 1 ครั้ง"), Func = xDTaraZ.UI.Detach(function() xDTaraZ.Roll.Once() end) })
    roll:AddButton({ Text = T("Reset roll counter", "รีเซ็ตตัวนับการทอย"), Func = xDTaraZ.UI.Detach(xDTaraZ.Roll.ResetCounter) })

    local plot = tab:AddRightGroupbox(T("Plot", "ฐาน"), "castle")
    plot:AddToggle("AutoCollect", { Text = T("Auto collect", "เก็บเงินอัตโนมัติ") })
    plot:AddSlider("CollectInterval", { Text = T("Collect interval", "ความถี่เก็บเงิน"), Min = 0.5, Max = 60, Default = 1, Rounding = 1, Suffix = "s" })
    plot:AddToggle("EquipBestUnitsAuto", { Text = T("Auto equip best", "วางตัวดีสุดอัตโนมัติ") })
    plot:AddDropdown("PlacementMode", {
        Text = T("Pick units by", "เลือกตัวตาม"),
        Description = T("Potential places your strongest units even at level 1", "ศักยภาพ = วางตัวที่เก่งจริงแม้ยังเลเวล 1"),
        Values = { "Potential", "Current income" },
        Default = "Potential",
    })
    plot:AddSlider("EquipInterval", { Text = T("Equip interval", "ความถี่วางตัว"), Min = 1, Max = 120, Default = 5, Rounding = 0, Suffix = "s" })
    plot:AddButton({ Text = T("Collect Now", "เก็บเงินตอนนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Plot.CollectNow) })
    plot:AddButton({ Text = T("Equip Best Now", "วางตัวดีสุดตอนนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Plot.EquipBest) })

    local level = tab:AddLeftGroupbox(T("Level Up", "อัปเลเวล"), "oneup")
    level:AddToggle("AutoLevelUp", { Text = T("Auto level up", "อัปเลเวลอัตโนมัติ"), Description = T("Levels plotted units when you can afford it", "อัปเลเวลตัวบนฐานเมื่อเงินพอ") })
    level:AddDropdown("LevelMinRarity", { Text = T("Minimum rarity (plotted units)", "rarity ขั้นต่ำ (ตัวบนฐาน)"), Values = rarities, Default = "Common", Searchable = true })
    level:AddSlider("LevelTarget", { Text = T("Target level", "เลเวลเป้าหมาย"), Min = 2, Max = 200, Default = 10, Rounding = 0 })
    level:AddSlider("LevelPayback", { Text = T("Max payback time", "คืนทุนไม่เกิน"), Description = T("Buys levels that pay back fast without delaying dice or rebirth", "อัปเฉพาะเลเวลที่คืนทุนเร็ว ไม่ทำให้เต๋า/รีเบิร์ธช้าลง"), Min = 10, Max = 3600, Default = 180, Rounding = 0, Suffix = "s" })
    level:AddButton({ Text = T("Run a pass", "อัปเลเวล 1 รอบ"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Level Up", "อัปเลเวล"), xDTaraZ.Plot.LevelPass(true) .. " levelled", "Success")
    end) })
end

function xDTaraZ.UI.BuildEconomy(window)
    local tab = window:AddTab(T("Economy", "เศรษฐกิจ"), "shop", T("Dice, upgrades, selling, rebirth", "เต๋า อัปเกรด ขาย รีเบิร์ธ"))
    local rarities = xDTaraZ.UI.Values(GameLib.UnitRarities)

    local dice = tab:AddLeftGroupbox(T("Dice", "เต๋า"), "qblock")
    dice:AddToggle("AutoBuyDice", { Text = T("Auto buy dice", "ซื้อเต๋าอัตโนมัติ"), Description = T("Buys the luckiest dice you can afford", "ซื้อเต๋าที่ดวงดีสุดเท่าที่เงินถึง") })
    dice:AddToggle("AutoEquipBestDice", { Text = T("Equip best owned dice", "ใส่เต๋าดีสุดที่มี") })
    dice:AddButton({ Text = T("Equip Best Now", "ใส่เต๋าดีสุดตอนนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Dice.EquipBest) })

    local upgrade = tab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "star")
    upgrade:AddToggle("AutoBuyUpgrades", { Text = T("Auto upgrades", "อัปเกรดอัตโนมัติ") })
    xDTaraZ.UI.MultiDropdown(upgrade, "UpgradeFilter", T("Branches to upgrade", "สายที่จะอัปเกรด"),
        T("Empty buys every branch", "ไม่เลือก = ซื้อทุกสาย"), xDTaraZ.UI.Values(xDTaraZ.Upgrade.Branches))
    upgrade:AddSlider("UpgradePayback", { Text = T("Max income payback", "คืนทุนรายได้ไม่เกิน"), Description = T("Buys money and luck upgrades only when they are worth it", "ซื้ออัปเกรดเงินและดวงเฉพาะตอนคุ้ม"), Min = 30, Max = 7200, Default = 1800, Rounding = 0, Suffix = "s" })
    upgrade:AddButton({ Text = T("Buy available upgrades", "ซื้ออัปเกรดที่ซื้อได้"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Upgrades", "อัปเกรด"), xDTaraZ.Upgrade.BuyAll() .. " bought", "Success")
    end) })

    local sell = tab:AddRightGroupbox(T("Sell", "ขาย"), "coin")
    sell:AddToggle("AutoSell", { Text = T("Auto sell", "ขายอัตโนมัติ"), Description = T("Never sells units on your plot or tower team", "ไม่ขายตัวที่อยู่บนฐานหรือในทีมหอคอย") })
    xDTaraZ.UI.MultiDropdown(sell, "SellRarities", T("Rarities to sell", "rarity ที่จะขาย"), nil, rarities)
    xDTaraZ.UI.MultiDropdown(sell, "SellKeepMutations", T("Mutations to keep", "mutation ที่เก็บไว้"), nil, xDTaraZ.UI.Values(GameLib.MutationNames))
    sell:AddSlider("KeepPerRarity", { Text = T("Keep best per rarity", "เก็บตัวดีสุดต่อ rarity"), Min = 0, Max = 20, Default = 0, Rounding = 0 })
    sell:AddSlider("SellInterval", { Text = T("Interval", "ความถี่"), Min = 0.5, Max = 60, Default = 2, Rounding = 1, Suffix = "s" })
    sell:AddToggle("AutoClearStorage", { Text = T("Auto clear full storage", "เคลียร์กระเป๋าเมื่อเต็ม"), Description = T("Sells your weakest spare units so rolling never stops", "ขายตัวสำรองที่อ่อนสุดเพื่อให้ทอยได้ไม่หยุด") })
    sell:AddDropdown("ClearKeepRarity", { Text = T("Never clear rarity and above", "ไม่เคลียร์ rarity นี้ขึ้นไป"), Values = rarities, Default = "Mythical", Searchable = true })
    sell:AddButton({ Text = T("Sell Now", "ขายตอนนี้"), Style = "Warning", Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Sell", "ขาย"), xDTaraZ.Sell.SellNow(), "Coin")
    end) })

    local rebirth = tab:AddRightGroupbox(T("Rebirth", "รีเบิร์ธ"), "flag")
    rebirth:AddToggle("AutoRebirth", { Text = T("Auto rebirth", "รีเบิร์ธอัตโนมัติ"), Description = T("Rebirths the moment you can afford it", "รีเบิร์ธทันทีที่เงินถึง") })
    rebirth:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธตอนนี้"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.Rebirth.RebirthNow()
        xDTaraZ.UI.Notify(T("Rebirth", "รีเบิร์ธ"), xDTaraZ.Rebirth.Status)
    end) })
end

function xDTaraZ.UI.BuildUnits(window)
    local tab = window:AddTab(T("Units", "ตัวละคร"), "heart", T("Grades, traits, fusing", "เกรด trait หลอมรวม"))
    local rarities = xDTaraZ.UI.Values(GameLib.UnitRarities)
    local mutations = xDTaraZ.UI.Values(GameLib.MutationNames)

    local grade = tab:AddLeftGroupbox(T("Grades", "เกรด"), "star")
    grade:AddToggle("AutoGrade", { Text = T("Auto grade", "รีเกรดอัตโนมัติ"), Description = T("Rerolls units on your plot and tower team up to the minimum", "รีเกรดตัวบนฐานและในทีมหอคอยจนถึงขั้นต่ำ") })
    grade:AddDropdown("GradeTarget", { Text = T("Minimum grade", "เกรดขั้นต่ำ"), Values = xDTaraZ.UI.Values(GameLib.GradeNames), Default = "S" })
    grade:AddToggle("GradeOverwrite", { Text = T("Overwrite protected tiers (S+)", "ยอมทับเกรดที่ป้องกันไว้ (S+)"), Risky = true })
    grade:AddButton({ Text = T("Grade Once", "รีเกรด 1 ครั้ง"), Func = xDTaraZ.UI.Detach(xDTaraZ.Grade.RollOne) })

    local trait = tab:AddLeftGroupbox(T("Traits", "trait"), "shell")
    trait:AddToggle("AutoTrait", { Text = T("Auto trait", "รี trait อัตโนมัติ"), Description = T("Rerolls units on your plot and tower team up to the minimum", "รี trait ตัวบนฐานและในทีมหอคอยจนถึงขั้นต่ำ") })
    trait:AddDropdown("TraitTarget", { Text = T("Minimum trait", "trait ขั้นต่ำ"), Values = xDTaraZ.UI.Values(GameLib.TraitNames), Default = "Samurai", Searchable = true })
    trait:AddToggle("TraitOverwrite", { Text = T("Overwrite protected tiers (Samurai/Shogun)", "ยอมทับ trait ที่ป้องกันไว้ (Samurai/Shogun)"), Risky = true })
    trait:AddButton({ Text = T("Trait Once", "รี trait 1 ครั้ง"), Func = xDTaraZ.UI.Detach(xDTaraZ.Trait.RollOne) })

    local lock = tab:AddRightGroupbox(T("Auto Lock", "ล็อกอัตโนมัติ"), "key")
    lock:AddToggle("AutoLock", { Text = T("Auto lock rare units", "ล็อกตัวหายากอัตโนมัติ"), Description = T("Locked units are never sold or fused", "ตัวที่ล็อกจะไม่ถูกขายหรือหลอม") })
    lock:AddDropdown("LockRarity", { Text = T("Lock rarity and above", "ล็อก rarity นี้ขึ้นไป"), Values = rarities, Default = "Secret I", Searchable = true })
    xDTaraZ.UI.MultiDropdown(lock, "LockMutations", T("Lock mutations", "ล็อก mutation"), nil, mutations)

    local gear = tab:AddRightGroupbox(T("Gear", "อุปกรณ์"), "shield")
    gear:AddToggle("AutoGear", { Text = T("Auto equip best gear", "ใส่อุปกรณ์ดีสุดอัตโนมัติ"), Description = T("Wears your rarest gear in every slot", "ใส่ชิ้นที่หายากสุดทุกช่อง") })
    gear:AddButton({ Text = T("Equip Best Now", "ใส่ดีสุดตอนนี้"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Gear", "อุปกรณ์"), xDTaraZ.Gear.EquipBest() .. " slots upgraded", "Success")
    end) })

    local fuse = tab:AddRightGroupbox(T("Fusing", "หลอมรวม"), "bomb")
    fuse:AddToggle("AutoFuse", { Text = T("Auto Fuse", "หลอมอัตโนมัติ"), Description = T("Fuses spare trios only when the result is expected to be rarer and the cost is small", "หลอมตัวสำรองเฉพาะเมื่อผลที่คาดไว้หายากกว่าเดิมและค่าหลอมถูก"), Risky = true })
    xDTaraZ.UI.MultiDropdown(fuse, "FuseRarities", T("Rarities to fuse", "rarity ที่จะหลอม"), T("Empty uses any spare below the never-clear rarity", "ไม่เลือก = ใช้ตัวสำรองที่ต่ำกว่า rarity ที่ไม่เคลียร์"), rarities)
    fuse:AddButton({ Text = T("Fuse Now", "หลอมตอนนี้"), Func = xDTaraZ.UI.Detach(xDTaraZ.Fuse.FuseNow) })
end

function xDTaraZ.UI.BuildTower(window)
    local tab = window:AddTab(T("Tower", "หอคอย"), "castle", T("Tower climbing for Gems", "ไต่หอคอยเก็บ Gems"))

    local group = tab:AddLeftGroupbox(T("Auto Tower", "ไต่หอคอยอัตโนมัติ"), "castle")
    group:AddToggle("AutoTower", { Text = T("Auto tower", "ไต่หอคอยอัตโนมัติ"), Description = T("Climbs, restarts after each run and keeps going", "ไต่ จบรอบแล้วเริ่มใหม่ต่อเนื่อง") })
        :AddKeyPicker("AutoTowerKey", { Default = "None", Mode = "Toggle" })
    local labels = xDTaraZ.UI.Values(xDTaraZ.Tower.Labels)
    group:AddDropdown("TowerDifficulty", {
        Text = T("Difficulty", "ความยาก"),
        Values = labels,
        Default = labels[1],
        Callback = function(label) xDTaraZ.Options.TowerName = xDTaraZ.Tower.NameFromLabel(label) end,
    })
    group:AddSlider("TowerStopFloor", { Text = T("Stop at floor", "หยุดที่ชั้น"), Min = 1, Max = 500, Default = 100, Rounding = 0 })
    group:AddToggle("TowerReequip", { Text = T("Re-equip before each run", "จัดทีมใหม่ก่อนทุกรอบ") })
    group:AddToggle("TowerSmart", { Text = T("Auto Difficulty", "ปรับความยากอัตโนมัติ"), Description = T("Moves up after a full clear and down when the team falls early", "ขึ้นหอยากขึ้นเมื่อผ่านหมด ลดลงเมื่อแพ้เร็ว") })
    group:AddButton({ Text = T("Equip best team", "จัดทีมดีสุด"), Func = xDTaraZ.UI.Detach(xDTaraZ.Tower.EquipTeam) })
end

function xDTaraZ.UI.BuildItems(window)
    local tab = window:AddTab(T("Items", "ไอเทม"), "flower", T("Potions, spins, ticket shop", "ยา สปิน ร้านตั๋ว"))

    local potion = tab:AddLeftGroupbox(T("Potions", "ยาบัฟ"), "flower")
    potion:AddToggle("AutoPotion", { Text = T("Auto potion", "ใช้ยาอัตโนมัติ"), Description = T("Uses each boost only when it helps", "ใช้บัฟแต่ละตัวเฉพาะตอนมีประโยชน์") })
    xDTaraZ.UI.MultiDropdown(potion, "PotionFilter", T("Potions to use", "ยาที่จะใช้"), T("Empty uses every potion", "ไม่เลือก = ใช้ทุกชนิด"), xDTaraZ.UI.Values(GameLib.NamesOfKind, "Boost"))
    potion:AddButton({ Text = T("Use Now", "ใช้ตอนนี้"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Potions", "ยาบัฟ"), xDTaraZ.Items.UsePotions(true) .. " used", "Power")
    end) })

    local spin = tab:AddRightGroupbox(T("Spins", "สปิน"), "star")
    spin:AddToggle("AutoSpin", { Text = T("Auto use spins", "ใช้สปินอัตโนมัติ"), Description = T("Uses Lucky and Jackpot spins", "ใช้ Lucky และ Jackpot spin") })
    spin:AddButton({ Text = T("Use Spins Now", "ใช้สปินตอนนี้"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Spins", "สปิน"), xDTaraZ.Items.UseSpins() .. " used")
    end) })

    local shop = tab:AddRightGroupbox(T("Ticket Shop", "ร้านตั๋ว"), "shop")
    shop:AddToggle("AutoTicketShop", { Text = T("Auto buy with tickets", "ซื้อด้วยตั๋วอัตโนมัติ"), Description = T("Spends quest tickets on what you pick", "ใช้ตั๋วเควสต์ซื้อของที่เลือก") })
    xDTaraZ.UI.MultiDropdown(shop, "TicketShopItems", T("Items to buy", "ของที่จะซื้อ"), nil, xDTaraZ.UI.Values(GameLib.ShopNames))
    shop:AddButton({ Text = T("Buy Now", "ซื้อตอนนี้"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Ticket Shop", "ร้านตั๋ว"), xDTaraZ.Items.BuyTicketShop() .. " bought", "Coin")
    end) })
end

function xDTaraZ.UI.BuildRewards(window)
    local tab = window:AddTab(T("Rewards", "รางวัล"), "key", T("Codes, daily, quests", "โค้ด รายวัน เควสต์"))

    local codes = tab:AddLeftGroupbox(T("Codes", "โค้ด"), "qblock")
    codes:AddButton({ Text = T("Redeem All Codes", "แลกโค้ดทั้งหมด"), Style = "Primary", Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Codes", "โค้ด"), xDTaraZ.Rewards.RedeemAll(), "Success")
    end) })

    local quest = tab:AddLeftGroupbox(T("Quests", "เควสต์"), "flag")
    quest:AddToggle("AutoQuest", { Text = T("Auto claim quests", "รับรางวัลเควสต์อัตโนมัติ") })
    quest:AddButton({ Text = T("Claim now", "รับตอนนี้"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.UI.Notify(T("Quests", "เควสต์"), xDTaraZ.Rewards.ClaimQuests() .. " claimed", "Success")
    end) })

    local claims = tab:AddRightGroupbox(T("Claims", "รับรางวัล"), "coin")
    claims:AddToggle("AutoDaily", { Text = T("Auto daily reward", "รับรางวัลรายวันอัตโนมัติ") })
    claims:AddToggle("AutoGroup", { Text = T("Auto group reward", "รับรางวัลกลุ่มอัตโนมัติ") })
    claims:AddToggle("AutoOffline", { Text = T("Auto offline earnings", "รับรายได้ออฟไลน์อัตโนมัติ") })
end

function xDTaraZ.UI.BuildPlayer(window)
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "oneup", T("Movement and utility", "การเคลื่อนที่และอรรถประโยชน์"))

    local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "gear")
    move:AddToggle("WalkSpeed", { Text = T("Walk speed", "ความเร็วเดิน"), Callback = xDTaraZ.UI.Detach(function(on)
        if on then xDTaraZ.Move.SpeedStart() else xDTaraZ.Move.SpeedStop() end
    end) })
    move:AddSlider("WalkSpeedValue", { Text = T("Speed", "ความเร็ว"), Min = 16, Max = 200, Default = 32, Rounding = 0 })
    move:AddToggle("InfiniteJump", { Text = T("Infinite jump", "กระโดดไม่จำกัด"), Callback = xDTaraZ.UI.Detach(function(on)
        if on then xDTaraZ.Move.JumpStart() else xDTaraZ.Move.JumpStop() end
    end) })
    move:AddToggle("NoClip", { Text = T("No clip", "ทะลุกำแพง"), Callback = xDTaraZ.UI.Detach(function(on)
        if on then xDTaraZ.Move.NoClipStart() else xDTaraZ.Move.NoClipStop() end
    end) }):AddKeyPicker("NoClipKey", { Default = "None", Mode = "Toggle" })
    move:AddToggle("Fly", { Text = T("Fly", "บิน"), Callback = xDTaraZ.UI.Detach(function(on)
        if on then xDTaraZ.Move.FlyStart() else xDTaraZ.Move.FlyStop() end
    end) }):AddKeyPicker("FlyKey", { Default = "None", Mode = "Toggle" })
    move:AddSlider("FlySpeed", { Text = T("Fly speed", "ความเร็วบิน"), Min = 20, Max = 300, Default = 60, Rounding = 0 })

    local util = tab:AddRightGroupbox(T("Utility", "อรรถประโยชน์"), "star")
    util:AddToggle("AntiAfk", { Text = T("Anti-AFK", "กันหลุด AFK"), Callback = xDTaraZ.UI.StartStop(xDTaraZ.AntiAfk) })
    util:AddToggle("AutoRejoin", { Text = T("Auto rejoin", "รีจอยน์อัตโนมัติ"), Description = T("Rejoins after a disconnect and resumes Kaitun", "เข้าเกมใหม่เมื่อหลุดและทำไคตุนต่อ"), Callback = xDTaraZ.UI.StartStop(xDTaraZ.Rejoin) })
    util:AddToggle("DisableCutscene", { Text = T("Disable cutscenes", "ปิดคัตซีน"), Description = T("Skips roll and fuse reveal cutscenes", "ข้ามคัตซีนตอนทอยและหลอม"), Callback = function(on)
        if not on then xDTaraZ.Cutscene.Restore() end
    end })

    local alerts = tab:AddRightGroupbox(T("Rare Alerts", "แจ้งเตือนของหายาก"), "bell")
    alerts:AddToggle("RareNotify", { Text = T("Alert on rare pulls", "แจ้งเตือนเมื่อได้ของหายาก") })
    xDTaraZ.UI.MultiDropdown(alerts, "NotifyRarities", T("Rarities", "rarity"), nil, xDTaraZ.UI.Values(GameLib.UnitRarities))
    xDTaraZ.UI.MultiDropdown(alerts, "NotifyMutations", T("Mutations", "mutation"), nil, xDTaraZ.UI.Values(GameLib.MutationNames))
    alerts:AddInput("WebhookUrl", { Text = T("Discord webhook", "Discord webhook"), Default = "", Placeholder = T("Optional webhook URL", "ลิงก์ webhook (ไม่ใส่ก็ได้)"), Finished = true })
    alerts:AddButton({ Text = T("Send test alert", "ทดสอบแจ้งเตือน"), Func = xDTaraZ.UI.Detach(function()
        xDTaraZ.Watch.Alert({ Name = "Test", Rarity = "Heavenly", Mutation = "Rainbow" })
    end) })
end

function xDTaraZ.UI.RefreshStatus()
    local labels = xDTaraZ.UI.Labels
    if not labels.Kaitun then return end

    labels.Economy:SetContent(string.format("$%s · R%d · Gems %s · Tickets %s",
        Util.FormatNumber(xDTaraZ.Data.Money()), xDTaraZ.Data.Rebirth(),
        Util.FormatNumber(xDTaraZ.Data.Token("Gems")), Util.FormatNumber(xDTaraZ.Data.Token("Tickets"))))
    labels.Roll:SetContent(xDTaraZ.Roll.GetStatus())
    labels.Units:SetContent(string.format("Storage %s · Grade: %s · Trait: %s", xDTaraZ.Storage.Status, xDTaraZ.Grade.Status, xDTaraZ.Trait.Status))
    labels.Tower:SetContent(xDTaraZ.Tower.GetStatus())
    labels.Kaitun:SetContent(xDTaraZ.Kaitun.GetStatus() .. "\nUpgrades: " .. xDTaraZ.Upgrade.Status .. "\nLevels: " .. xDTaraZ.Plot.Status)
    labels.Stats:SetContent(table.concat(xDTaraZ.Watch.Stats(), "\n"))
end

function xDTaraZ.UI.BindOptions()
    for key in pairs(xDTaraZ.Options) do
        local widget = Library.Options[key]
        if widget and widget.OnChanged then
            xDTaraZ.Options[key] = widget.Value
            widget:OnChanged(function(value)
                xDTaraZ.Options[key] = value
                if value == true then xDTaraZ.Scheduler.Resume(key) end
            end)
        end
    end
end

function xDTaraZ.UI.Build()
    local window = Library.Window
    local layout = {
        { T("Main", "หลัก"), "Main", xDTaraZ.UI.BuildMain },
        { T("Farming", "ฟาร์ม"), "Farm", xDTaraZ.UI.BuildFarm },
        { nil, "Tower", xDTaraZ.UI.BuildTower },
        { T("Progression", "พัฒนา"), "Units", xDTaraZ.UI.BuildUnits },
        { nil, "Economy", xDTaraZ.UI.BuildEconomy },
        { nil, "Items", xDTaraZ.UI.BuildItems },
        { nil, "Rewards", xDTaraZ.UI.BuildRewards },
        { T("Misc", "อื่นๆ"), "Player", xDTaraZ.UI.BuildPlayer },
    }
    for _, section in ipairs(layout) do
        if section[1] then window:AddTabSection(section[1]) end
        Util.Try("ui " .. section[2], section[3], window)
    end
    Util.Try("ui settings", window.AddSettingsTab, window)

    Util.Try("ui bind", xDTaraZ.UI.BindOptions)
    Util.Try("ui gate", xDTaraZ.UI.Gate)
    Library:Every(xDTaraZ.Config.StatusInterval, xDTaraZ.UI.RefreshStatus)
    Library:Every(xDTaraZ.Config.StatusInterval, xDTaraZ.UI.DrainHalted)
    Library:Every(xDTaraZ.Config.StatusInterval, xDTaraZ.UI.DrainNotices)
end

local function BuildInterface()
    local lib, problem = Util.LoadLibrary(xDTaraZ.Config.UiSource)
    if not lib then
        Util.Alert(problem)
        return
    end
    Library = lib
    pcall(MarioBanner.Step, "UI library")
    xDTaraZ.Library = Library
    T = function(en, th) return Library:T(en, th) end
    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Anime Dice by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = xDTaraZ.Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        Intro = true,
        OnUnlocked = function()
            xDTaraZ.UI.Build()
            task.defer(Util.Try, "boot", xDTaraZ.Boot)
            task.defer(function()
                Util.Try("autoload config", Library.LoadAutoloadConfig, Library)
                if environment.AnimeDiceResume then
                    environment.AnimeDiceResume = nil
                    if Library.Toggles.Kaitun then Library.Toggles.Kaitun:SetValue(true) end
                end
            end)
        end,
    })
    Library:OnUnload(function()
        xDTaraZ:Unload()
    end)
    return true
end

function xDTaraZ.Boot()
    xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(character)
        xDTaraZ.Player:Bind(character)
        task.defer(xDTaraZ.Move.Rebind)
    end)
    xDTaraZ.Roll.ResetCounter()

    local options, config = xDTaraZ.Options, xDTaraZ.Config
    local every = xDTaraZ.Scheduler.Every
    every("Roll", config.RollInterval, xDTaraZ.Roll.Step, { "AutoRoll" })
    every("Collect", function() return options.CollectInterval end, xDTaraZ.Plot.CollectStep, { "AutoCollect" })
    every("Equip", function() return options.EquipInterval end, xDTaraZ.Plot.EquipStep, { "EquipBestUnitsAuto" })
    every("Economy", 1, xDTaraZ.Economy.Step, { "AutoBuyDice", "AutoEquipBestDice", "AutoRebirth", "AutoBuyUpgrades", "AutoLevelUp" })
    every("Sell", function() return options.SellInterval end, xDTaraZ.Sell.Step, { "AutoSell" })
    every("Storage", 1, xDTaraZ.Storage.Step, { "AutoClearStorage" })
    every("Grade", config.GradeDelay, xDTaraZ.Grade.Step, { "AutoGrade" })
    every("Trait", config.TraitDelay, xDTaraZ.Trait.Step, { "AutoTrait" })
    every("Fuse", config.FuseDelay, xDTaraZ.Fuse.Step, { "AutoFuse" })
    every("Tower", config.TowerTick, xDTaraZ.Tower.Step, { "AutoTower" })
    every("Items", config.RewardsInterval, xDTaraZ.Items.Step, { "AutoPotion", "AutoSpin", "AutoTicketShop" })
    every("Gear", config.RewardsInterval, xDTaraZ.Gear.Step, { "AutoGear" })
    every("Watch", 1, xDTaraZ.Watch.Step, { "RareNotify" })
    every("Lock", config.RewardsInterval, xDTaraZ.Lock.Step, { "AutoLock" })
    every("Rewards", config.RewardsInterval, xDTaraZ.Rewards.Step, { "AutoDaily", "AutoGroup", "AutoOffline", "AutoQuest" })
    every("Speed", 1, xDTaraZ.Move.ApplyWalkSpeed, { "WalkSpeed" })
    every("Cutscene", 1, xDTaraZ.Cutscene.Step, { "DisableCutscene" })
    xDTaraZ.Scheduler.Boot()
end

function xDTaraZ:Unload()
    self.State.Alive = false
    if environment.AnimeDiceUnload == self.State.UnloadEntry then environment.AnimeDiceUnload = nil end
    self.Options.AutoTower = false
    if xDTaraZ.Tower.State ~= "Idle" then xDTaraZ.Tower.Leave() end
    xDTaraZ.Move.SpeedStop()
    xDTaraZ.Move.NoClipStop()
    xDTaraZ.Move.FlyStop()
    xDTaraZ.Cutscene.Restore()
    for _, connection in ipairs(self.State.Connections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(self.State.Connections)
end

xDTaraZ.State.UnloadEntry = function()
    if xDTaraZ.Library and not xDTaraZ.Library.Unloaded then
        xDTaraZ.Library:Unload()
    else
        xDTaraZ:Unload()
    end
end
environment.AnimeDiceUnload = xDTaraZ.State.UnloadEntry

if LocalPlayer.Character then
    xDTaraZ.Player:Bind(LocalPlayer.Character)
end

pcall(MarioBanner.Step, "Systems")
if BuildInterface() then
    pcall(MarioBanner.Step, "Interface")
    pcall(MarioBanner.Ready)
end