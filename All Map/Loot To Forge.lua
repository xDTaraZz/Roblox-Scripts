if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10684750879 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Loot To Forge only")
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
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    SaveFolder = "Loot To Forge",
    Discord = "https://discord.gg/FHVfmeSceA",
    UpdateLog = {
        { "2026-10-10", "Find Old Server: join a server still on the old version, where Spawn Rolls works. Remembers old servers it found\nSpawn Best Set: strongest weapon, armor and hat, equipped\nAuto Roll Race: pick target stars\nSpawn Race Rolls, Season Tickets and Tokens (OP)\nAuto Token Shop: every pass and pack for free\nHop to emptiest server, save and return position" },
        { "2026-10-06", "Updated for the new game version\nSpawn Items now lists only items that still work (ores and runes)\nDupe Whole Inventory skips items the game no longer allows" },
    },
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    ReloadSource = [[
if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(2)
local url = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/loader.lua"
local ok, body = pcall(game.HttpGet, game, url)
if not (ok and type(body) == "string") then
    local requester = request or http_request or (syn and syn.request) or (http and http.request)
    local sent, reply = pcall(requester, { Url = url, Method = "GET" })
    body = sent and type(reply) == "table" and reply.Body
end
if type(body) == "string" then loadstring(body)() end]],
    LoadTimeout = 30,
    RemoteTimeout = 10,
    RequireTimeout = 3,
    MaxFailures = 5,
    FailWindow = 10,
    AlertTries = 20,
    AlertDelay = 0.5,
    TickDelay = 0.2,
    StatusInterval = 2,
    PumpInterval = 0.25,
    RefillAmount = 100000,
    OwnedOresLabel = "Owned ores",
    AcquireRounds = 300,
    StoneWorkers = 8,
    StoneCallsPerWorker = 15,
    TowerWorkers = 128,
    CoinFarmTimeout = 600,
    PotionStack = 100000,
    TowerCallsPerWorker = 25,
    GearForgeTries = 15,
    GearEnhanceTries = 2,
    GearEnhanceWorkers = 8,
    SlotEnhanceRounds = 200,
    ClickInterval = 0.16,
    ForgeTargets = {
        { name = "Great Weapon", forgeType = "Weapon", ores = 13 },
        { name = "Katana", forgeType = "Weapon", ores = 4 },
        { name = "Armor", forgeType = "Armor", ores = 11 },
        { name = "Hat", forgeType = "Armor", ores = 4 },
    },
    GearSlots = {
        { slot = "Weapon", forgeType = "Weapon", ores = 13 },
        { slot = "Armor", forgeType = "Armor", ores = 11 },
        { slot = "Hat", forgeType = "Armor", ores = 4 },
    },
    GearTypes = { "Weapon", "Armor", "Hat" },
    EnchantPriority = { "Poison_3", "Thunder_3", "Ice_3", "Fire_3", "Poison_2", "Thunder_2", "Ice_2", "Fire_2" },
    RuneMinTier = 2,
    EnchantRefill = 50,
    ForgeCountMax = 30,
    PlanSlice = 0.004,
    HuntBatch = 40,
    HuntWorkers = 4,
    HuntMaxForges = 4000,
    HuntTargetHits = 3,
    IndexInterval = 60,
    IndexLevelClaims = 50,
    ClaimIdScan = 20,
    BonusRewards = { Race = { id = "4", per = 2 }, Season = { id = "5", per = 2 }, Token = { id = "6", per = 20 } },
    BonusBatch = 300,
    BonusMaxClaims = 1000,
    LookKinds = { "Ore", "EnchStone", "Weapon", "Armor", "Material", "Class" },
    BonusKeyLength = 16,
    RaceRefill = 40,
    TokenShopInterval = 60,
    ClaimInterval = 30,
    SeasonInterval = 60,
    BossCards = 8,
    BossAttackIds = { Katana = "K_ATK_1", Great = "G_ATK_1" },
    BossHitsPerTick = 30,
    BossHitGap = 0.02,
    BossJoinSettle = 1,
    BossClaimDelay = 3.5,
    BossStandHeight = 3,
    BossStandBack = 8,
    BossReach = 25,
    UpgradeInterval = 5,
    EquipInterval = 3,
    SellInterval = 1,
    RebirthInterval = 2,
    BossInterval = 1,
    BossHopInterval = 5,
    BossHopAfter = 8,
    BossLootTimeout = 30,
    BossHopFlag = "bosshop.txt",
    BossHopResume = 180,
    BossHopServers = "bossservers.json",
    HopListTtl = 120,
    HopBackoffStart = 5,
    HopBackoffMax = 60,
    HopGiveUp = 8,
    HopStall = 30,
    HopGap = 15,
    OldServerFlag = "oldserver.json",
    OldServerKnown = "oldservers.json",
    OldServerKeep = 20,
    OldServerVersion = 36046,
    OldServerTries = 40,
    OldServerGap = 4,
    TrainRejoinDelay = 0.3,
    TrainWatchdog = 3,
    TrainAcceptWait = 1.5,
    TrainExitTries = 3,
    TrainSettle = 0.5,
    WarnCooldown = 30,
    WarnMemory = 64,
    KillAuraInterval = 0.25,
    KillDamage = 1e30,
    RaceRollDelay = 0.15,
    RaceResultWait = 2,
    RaceProtectRarity = "Mythic",
    RaceSlots = { "Equipped", "Slot 1", "Slot 2", "Slot 3" },
    RejoinDelay = 5,
    CodeReplyWait = 1.5,
    Codes = { "100000CCU", "50000CCU", "30000CCU", "20000CCU" },
    Needs = {
        CollectOre = { "Remote.Stage.StageFinishedRF", "Remote.Stage.GetOreRF", "Remote.Stage.ClaimedAllOreRE", "Config.Stage.Helper", "Config.Ore.Config" },
        SuperLootAura = { "Remote.SuperLoot.KillSuperLootRE", "Remote.SuperLoot.RefreshSuperLootRE", "Remote.Stage.GetOreRF" },
        AutoWorldBoss = { "Remote.WorldBoss.IntoWorldBossFight", "Remote.WorldBoss.ExitWorldBossFight", "Remote.WorldBoss.BossDeadRE", "Remote.Attack.UseAnyATKRE", "Remote.Attack.AttackEnemyServiceRE" },
        AutoIndex = { "Remote.Forge.ForgeRF", "Remote.Index.TryClaimIndexExpRF", "Utils.ForgeUtils", "Config.Weapon.Config", "Config.Armor.Config" },
        MaxGear = { "Utils.BalanceUtils", "Remote.Forge.ForgeRF", "Remote.Backpack.EnhantEquipmentRF", "Remote.Backpack.EnchantRE", "Config.Enhant.Config", "Config.EnchStone.Show" },
        AutoEquip = { "Utils.BalanceUtils", "Remote.Backpack.TryEquipItemRE", "Config.Weapon.Helper", "Config.Armor.Helper" },
        AutoForge = { "Remote.Forge.ForgeRF", "Remote.Backpack.TrySellItemRE", "Config.Ore.Config" },
        AutoSell = { "Remote.Backpack.TrySellItemRE", "Config.Weapon.Config", "Config.Armor.Config" },
        AutoTrain = { "Remote.Train.IntoAutoTrainRE", "Remote.Train.ExitAutoTrainRE", "Config.TrainArea.Config" },
        AutoRebirth = { "Remote.Rebirth.TryRebirthRE", "Config.Rebirth.Helper" },
        AutoUpgrade = { "Remote.Upgrade.UpgradeOnceRE", "Config.Upgrade.Config" },
        AutoTower = { "Remote.Dungeon.TryIntoDungeonRF", "Remote.Dungeon.StartRoundRE", "Remote.Dungeon.CompleteRoundRF", "Config.Dungeon.Config.LootTab" },
        AutoSeason = { "Remote.Season.TryClaimDailyTicRE", "Remote.Season.ExchangeGoodsRE", "Remote.Season.LuckRE", "Config.Season.GoodsConfig" },
        AutoClaim = { "Remote.Offline.TryClaimOfflineRewardRE", "Remote.Online.TryClaimRE" },
        AutoRace = { "Remote.Class.LuckOnceRE", "Config.Class.Config" },
        AutoBestRace = { "Remote.Class.ChangeEquipedIndexRE", "Config.Class.Config" },
        KeepOre = { "Remote.Stage.LostAllOreRF" },
    },
    KaitunToggles = { "MaxGear", "AutoEquip", "AutoForge", "AutoSell", "AutoTrain", "AutoRebirth", "AutoUpgrade", "AutoClaim", "AutoSeason", "KillAura", "SuperLootAura", "AutoWorldBoss", "AutoTower", "GodMode", "AutoBestRace" },
}

local Config = xDTaraZ.Config
local Remote = ReplicatedStorage:WaitForChild("Remote", Config.LoadTimeout)
local GameConfig = ReplicatedStorage:WaitForChild("Config", Config.LoadTimeout)

xDTaraZ.State = {
    Alive = true,
    Busy = false,
    Rolling = false,
    SavedSpot = nil,
    Rejoining = false,
    Lock = nil,
    Failures = {},
    Halted = {},
    InTower = false,
    Entering = false,
    GearForged = false,
    TrainArea = nil,
    TrainPending = nil,
    TrainEntering = false,
    TrainGen = 0,
    TrainFiredAt = 0,
    TrainRebirth = nil,
    BossReturn = nil,
    TrainLevel = nil,
    TrainNilSince = nil,
    Warned = {},
    WarnedCount = 0,
    LastRun = {},
    Profile = nil,
    GearNote = nil,
    IndexNote = nil,
    TowerLoot = 0,
    OreLabels = {},
    SpawnLabels = {},
    GearLabels = {},
    BossHopping = false,
    HopFails = 0,
    HopBackoff = nil,
    HopBlockedUntil = 0,
    HopQueued = false,
    BossDone = nil,
    MissingLabels = {},
    OreStage = {},
    Plans = {},
    Runes = nil,
    Conns = {},
    Opt = {
        MaxGear = false,
        AutoEquip = false,
        EnhanceTarget = 20,
        GearForge = true,
        GearEnchant = true,
        GearEnhance = true,
        EnchantPriority = {},
        EnhanceSlot = "Weapon",
        ForgeSellJunk = false,
        ForgePerTick = 10,
        BossCards = true,
        SeasonSpin = true,
        SeasonGoods = { ["4"] = true, ["7"] = true },
        AutoBestRace = false,
        GodMode = false,
        KeepOre = false,
        CollectOre = false,
        Stage = nil,
        CollectRarities = {},
        KillAura = false,
        SuperLootAura = false,
        AutoWorldBoss = false,
        BossHop = false,
        BossWaitMinutes = 2.5,
        AutoForge = false,
        ForgeTarget = "Great Weapon",
        ForgeOre = nil,
        ForgeRarities = {},
        KeepPerOre = 0,
        BestOreFirst = false,
        AutoSell = false,
        SellTypes = { Weapon = true, Armor = true, Hat = true },
        SellRarities = {},
        KeepPerItem = 1,
        AutoIndex = false,
        IndexTypes = { Weapon = true, Armor = true, Hat = true },
        MissingItem = nil,
        AutoTrain = false,
        AutoClick = false,
        AutoRebirth = false,
        AutoUpgrade = false,
        Upgrades = {},
        AutoClaim = false,
        AutoSeason = false,
        AutoTokenShop = false,
        BonusKind = "Race",
        BonusAmount = 1000,
        AutoTower = false,
        AutoRace = false,
        RaceTargets = {},
        RaceMinLevel = nil,
        RaceStar = 0,
        RaceSlot = "Equipped",
        RaceRefill = false,
        RaceLock = false,
        RaceProtect = false,
        RaceAnim = false,
        SpawnItem = nil,
        SpawnAmount = 100000,
        CoinTarget = 1000000,
        OldVersion = 36046,
        SpawnGear = nil,
        GearCopies = 1,
        SpeedOn = false,
        WalkSpeed = 60,
        InfJump = false,
        AutoRejoin = false,
        LowGraphics = false,
    },
}

local State = xDTaraZ.State

xDTaraZ.GameLib = { Loaded = {}, Failed = {}, Apis = {}, Deferred = {} }

---@return boolean, any  ok + module, retried from an identity-2 thread when the executor can really switch
function xDTaraZ.GameLib.RequireAsGame(module)
    local done, ok, loaded = false, false, nil
    task.spawn(function()
        pcall(setthreadidentity, 2)
        local read, identity = pcall(getthreadidentity)
        if read and identity == 2 then
            ok, loaded = pcall(require, module)
        end
        done = true
    end)
    local deadline = os.clock() + Config.RequireTimeout
    while not done and os.clock() < deadline do
        task.wait()
    end
    return ok, loaded
end

---@return table?  nil when this executor can't require it; the failure is warned once
function xDTaraZ.GameLib.Require(module)
    local cached = xDTaraZ.GameLib.Loaded[module]
    if cached ~= nil or xDTaraZ.GameLib.Failed[module] then return cached end

    local ok, loaded = pcall(require, module)
    if not ok then
        local firstErr = loaded
        ok, loaded = xDTaraZ.GameLib.RequireAsGame(module)
        if not ok then
            xDTaraZ.GameLib.Failed[module] = tostring(firstErr)
            warn("[LootToForge] require", module:GetFullName(), firstErr)
            return nil
        end
    end
    xDTaraZ.GameLib.Loaded[module] = loaded
    return loaded
end

---@return boolean, any ...  pcall-style results
function xDTaraZ.GameLib.CallAsGame(fn, ...)
    local args = table.pack(...)
    local box
    task.defer(function()
        pcall(setthreadidentity, 2)
        box = table.pack(pcall(fn, table.unpack(args, 1, args.n)))
    end)
    local deadline = os.clock() + Config.RequireTimeout
    while not box and os.clock() < deadline do
        task.wait()
    end
    if not box then return false, "game call timed out" end
    return table.unpack(box, 1, box.n)
end

function xDTaraZ.GameLib.Call(fn, ...)
    if not xDTaraZ.GameLib.Deferred[fn] then
        local result = table.pack(pcall(fn, ...))
        if result[1] or not tostring(result[2]):find("non-RobloxScript", 1, true) then
            if not result[1] then error(result[2], 0) end
            return table.unpack(result, 2, result.n)
        end
        xDTaraZ.GameLib.Deferred[fn] = true
    end
    local result = table.pack(xDTaraZ.GameLib.CallAsGame(fn, ...))
    if not result[1] then error(result[2], 0) end
    return table.unpack(result, 2, result.n)
end

---@return table  function fields go through GameLib.Call; for helper/controller modules, not config tables
function xDTaraZ.GameLib.Api(module)
    local api = xDTaraZ.GameLib.Apis[module]
    if api then return api end
    local loaded = xDTaraZ.GameLib.Need(module)
    api = setmetatable({}, {
        __index = function(self, key)
            local value = loaded[key]
            if type(value) ~= "function" then return value end
            local wrapped = function(...)
                return xDTaraZ.GameLib.Call(value, ...)
            end
            rawset(self, key, wrapped)
            return wrapped
        end,
    })
    xDTaraZ.GameLib.Apis[module] = api
    return api
end

---@return table  errors with a readable reason instead of returning nil
function xDTaraZ.GameLib.Need(module)
    local loaded = xDTaraZ.GameLib.Require(module)
    if loaded == nil then
        error(("game data %s.%s can't be read on this executor"):format(module.Parent.Name, module.Name), 0)
    end
    return loaded
end

---@param path string  dotted path under ReplicatedStorage, e.g. "Config.Ore.Config"
---@return Instance?
function xDTaraZ.GameLib.Find(path)
    local node = ReplicatedStorage
    for part in path:gmatch("[^%.]+") do
        node = node and node:FindFirstChild(part)
    end
    if node then return node end
    local folder, name = path:match("^Remote%.([^%.]+)%.([^%.]+)$")
    return folder and xDTaraZ.Util.FindRemote(folder, name)
end

---@return table  option idx -> missing paths
function xDTaraZ.GameLib.Missing()
    local missing = {}
    for idx, paths in pairs(Config.Needs) do
        for _, path in ipairs(paths) do
            if not xDTaraZ.GameLib.Find(path) then
                missing[idx] = missing[idx] or {}
                table.insert(missing[idx], path)
            end
        end
    end
    return missing
end

for _, name in ipairs({ "Util", "Data", "Stage", "Ore", "Spawn", "Potion", "Forge", "Sell", "Gear", "Index", "Level", "Upgrade", "Tower", "Boss", "Season", "Claim", "Bonus", "TokenShop", "Look", "SuperLoot", "Combat", "Guard", "Race", "Movement", "Session", "Scheduler" }) do
    xDTaraZ[name] = {}
end

---@return Instance?  nil when missing; a renamed folder is searched by remote name
function xDTaraZ.Util.FindRemote(folder, name)
    if not Remote then return nil end
    for _, holderName in ipairs({ folder .. "_Server", folder }) do
        local holder = Remote:FindFirstChild(holderName)
        local remote = holder and holder:FindFirstChild(name)
        if remote then return remote end
    end
    return Remote:FindFirstChild(name, true)
end

function xDTaraZ.Util.Remote(folder, name)
    local remote = xDTaraZ.Util.FindRemote(folder, name)
    if remote then return remote end

    local holder = Remote and (Remote:FindFirstChild(folder .. "_Server") or Remote:WaitForChild(folder, Config.RemoteTimeout))
    remote = holder and holder:WaitForChild(name, Config.RemoteTimeout) or xDTaraZ.Util.FindRemote(folder, name)
    if not remote then error(("remote %s.%s not found"):format(folder, name), 0) end
    return remote
end

---@return string?, string?  body, or nil + why every transport failed
function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if ok and type(body) == "string" then return body end

    local send = request or http_request or (syn and syn.request) or (http and http.request)
    if not send then return nil, tostring(body) end
    local sent, response = pcall(send, { Url = url, Method = "GET" })
    if not sent then return nil, tostring(response) end
    if type(response) ~= "table" or response.StatusCode ~= 200 or type(response.Body) ~= "string" then
        return nil, "HTTP " .. tostring(type(response) == "table" and response.StatusCode)
    end
    return response.Body
end

function xDTaraZ.Util.Alert(text, detail)
    warn("[LootToForge] menu:", text, detail or "")
    task.spawn(function()
        for _ = 1, Config.AlertTries do
            local shown = pcall(StarterGui.SetCore, StarterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 })
            if shown then return end
            task.wait(Config.AlertDelay)
        end
    end)
end

---@return table?  the UI library, nil after telling the player why
function xDTaraZ.Util.LoadLibrary()
    local body, err = xDTaraZ.Util.HttpGet(Config.UiSource)
    if not body or not body:sub(-64):find("return Library%s*$") then
        xDTaraZ.Util.Alert("Could not download the menu. Check your connection and run it again.", err or "truncated body")
        return nil
    end
    local chunk, compileErr = loadstring(body)
    if not chunk then
        xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(compileErr))
        return nil
    end
    local ok, library = pcall(chunk)
    if not ok or type(library) ~= "table" then
        xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(library))
        return nil
    end
    return library
end

---Warns a job failure once per Config.WarnCooldown so a feature that flips between failing and succeeding can't flood the console.
function xDTaraZ.Util.WarnJob(key, err)
    local stamp = key .. tostring(err):match("[^\n]*")
    local now = os.clock()
    if now - (State.Warned[stamp] or -Config.WarnCooldown) < Config.WarnCooldown then return end

    if not State.Warned[stamp] then
        State.WarnedCount += 1
        if State.WarnedCount > Config.WarnMemory then
            table.clear(State.Warned)
            State.WarnedCount = 1
        end
    end
    State.Warned[stamp] = now
    warn("[LootToForge]", key, err)
end

function xDTaraZ.Util.Try(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then
        warn("[LootToForge]", err)
    end
    return ok, err
end

function xDTaraZ.Util.Tier(id)
    return tonumber(tostring(id):match("%d+")) or 0
end

function xDTaraZ.Util.Abbreviate(number)
    local units = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp" }
    local index = 1
    while number >= 1000 and index < #units do
        number /= 1000
        index += 1
    end
    return (index == 1 and "%d%s" or "%.2f%s"):format(number, units[index])
end

function xDTaraZ.Util.HighestKey(configTable)
    local bestKey, bestTier = nil, -1
    for key in pairs(configTable) do
        local tier = xDTaraZ.Util.Tier(key)
        if tier > bestTier then
            bestKey, bestTier = key, tier
        end
    end
    return bestKey
end

function xDTaraZ.Util.WaitAll(workers, job)
    local pending = workers
    for _ = 1, workers do
        task.spawn(function()
            xDTaraZ.Util.Try(job)
            pending -= 1
        end)
    end
    local deadline = os.clock() + Config.RemoteTimeout * 3
    while pending > 0 and os.clock() < deadline do
        task.wait(0.1)
    end
end

function xDTaraZ.Util.RarityNames()
    local helper = xDTaraZ.GameLib.Api(GameConfig.Rarity.Helper)
    local names = {}
    for level = 1, 20 do
        local name = helper.GetRarityByLevel(level)
        if not name then break end
        table.insert(names, name)
    end
    return names
end

function xDTaraZ.Util.AllSet(list)
    local set = {}
    for _, name in ipairs(list) do
        set[name] = true
    end
    return set
end

---@param name string  shown in status while it runs
---@return boolean     false if another long job holds the character
function xDTaraZ.Util.Exclusive(name, fn, ...)
    if State.Lock then return false end
    State.Lock = name
    local ok = xDTaraZ.Util.Try(fn, ...)
    State.Lock = nil
    return ok
end

function xDTaraZ.Data.Get()
    State.Profile = xDTaraZ.Util.Remote("Profile", "GetTotalDataRF"):InvokeServer()
    return State.Profile
end

function xDTaraZ.Data.Count(profile, itemId)
    local total = 0
    for _, entry in pairs(profile.Backpack.have) do
        if entry.ID == itemId then
            total += entry.Number or 1
        end
    end
    return total
end

function xDTaraZ.Data.Uuid(profile, itemId)
    for uuid, entry in pairs(profile.Backpack.have) do
        if entry.ID == itemId and (entry.Number or 0) >= 1 then
            return uuid
        end
    end
    return nil
end

function xDTaraZ.Data.Snapshot()
    local seen = {}
    for uuid in pairs(xDTaraZ.Data.Get().Backpack.have) do
        seen[uuid] = true
    end
    return seen
end

---@return table  { [uuid] = entry } gear that appeared after the snapshot
function xDTaraZ.Data.NewGear(before)
    local fresh = {}
    for uuid, entry in pairs(xDTaraZ.Data.Get().Backpack.have) do
        if not before[uuid] and entry.Type ~= "Ore" and entry.Type ~= "Material" and entry.Type ~= "EnchStone" then
            fresh[uuid] = entry
        end
    end
    return fresh
end

function xDTaraZ.Ore.Rarity(oreId)
    local oreConfig = xDTaraZ.GameLib.Need(GameConfig.Ore.Config)[oreId]
    return oreConfig and xDTaraZ.GameLib.Api(GameConfig.Rarity.Helper).GetRarityByLevel(oreConfig.Rarity)
end

function xDTaraZ.Ore.Owned(profile)
    local ores = {}
    for uuid, entry in pairs(profile.Backpack.have) do
        if entry.Type == "Ore" and (entry.Number or 0) >= 1 then
            table.insert(ores, {
                uuid = uuid,
                id = entry.ID,
                tier = xDTaraZ.Util.Tier(entry.ID),
                number = math.floor(entry.Number),
                rarity = xDTaraZ.Ore.Rarity(entry.ID),
            })
        end
    end
    table.sort(ores, function(a, b) return a.tier > b.tier end)
    return ores
end

function xDTaraZ.Ore.Ids()
    local ids = {}
    for oreId in pairs(xDTaraZ.GameLib.Need(GameConfig.Ore.Config)) do
        table.insert(ids, oreId)
    end
    table.sort(ids, function(a, b) return xDTaraZ.Util.Tier(a) > xDTaraZ.Util.Tier(b) end)
    return ids
end

---@return string?, string?  image asset and rarity name from the game's own item tables
function xDTaraZ.Look.Item(itemId)
    for _, kind in ipairs(Config.LookKinds) do
        local folder = GameConfig:FindFirstChild(kind)
        local show = folder and folder:FindFirstChild("Show") and xDTaraZ.GameLib.Require(folder.Show)
        local entry = show and show[itemId]
        if not entry then continue end
        local config = folder:FindFirstChild("Config") and xDTaraZ.GameLib.Require(folder.Config)
        local info = config and config[itemId]
        return entry.Image, info and info.Rarity
    end
    return nil, nil
end

---@return Color3?  the colour the game paints this rarity with
function xDTaraZ.Look.Color(rarity)
    if rarity == nil then return nil end
    State.RarityColors = State.RarityColors or {}
    local cached = State.RarityColors[rarity]
    if cached ~= nil then return cached or nil end

    local helper = xDTaraZ.GameLib.Api(GameConfig.Rarity.Helper)
    local name = rarity
    if type(rarity) == "number" then
        local ok, byLevel = pcall(helper.GetRarityByLevel, rarity)
        name = ok and byLevel or rarity
    end
    local probe = Instance.new("TextLabel")
    pcall(helper.SetUIQiu, probe, name)
    local gradient = probe:FindFirstChildWhichIsA("UIGradient")
    local color = gradient and gradient.Color.Keypoints[1].Value
    probe:Destroy()
    State.RarityColors[rarity] = color or false
    return color
end

---@param idOf fun(label: string): string?  item id behind a dropdown label
---@return table, table  label -> image, label -> Color3
function xDTaraZ.Look.Maps(labels, idOf)
    local images, colors = {}, {}
    for _, label in ipairs(labels) do
        local itemId = idOf(label)
        if not itemId then continue end
        local image, rarity = xDTaraZ.Look.Item(itemId)
        images[label] = image
        colors[label] = xDTaraZ.Look.Color(rarity)
    end
    return images, colors
end

function xDTaraZ.Ore.Choices()
    local oreShow = xDTaraZ.GameLib.Need(GameConfig.Ore.Show)
    local labels, idByLabel = {}, {}
    for _, oreId in ipairs(xDTaraZ.Ore.Ids()) do
        local label = ("%s (%s)"):format(oreShow[oreId] and oreShow[oreId].DisplayName or oreId, xDTaraZ.Ore.Rarity(oreId) or "?")
        if idByLabel[label] then
            label = ("%s #%d"):format(label, xDTaraZ.Util.Tier(oreId))
        end
        idByLabel[label] = oreId
        table.insert(labels, label)
    end
    State.OreLabels = idByLabel
    return labels
end

function xDTaraZ.Ore.ForgeChoices()
    local labels = xDTaraZ.Ore.Choices()
    table.insert(labels, 1, Config.OwnedOresLabel)
    return labels
end

function xDTaraZ.Ore.Add(uuid, amount)
    xDTaraZ.Util.Remote("Backpack", "TrySellItemRE"):FireServer(uuid, -math.abs(amount))
end

---@param need number  how many must be in the stack afterwards
---@return string?     stack uuid, nil if the ore never dropped
function xDTaraZ.Ore.Ensure(oreId, need)
    local profile = xDTaraZ.Data.Get()
    local uuid = xDTaraZ.Data.Uuid(profile, oreId)
    if not uuid then
        if not xDTaraZ.Stage.AcquireOre(oreId) then return nil end
        task.wait(0.4)
        profile = xDTaraZ.Data.Get()
        uuid = xDTaraZ.Data.Uuid(profile, oreId)
    end
    if uuid and xDTaraZ.Data.Count(profile, oreId) < need then
        xDTaraZ.Ore.Add(uuid, math.max(Config.RefillAmount, need))
        task.wait(0.4)
    end
    return uuid
end

function xDTaraZ.Ore.Top(minimum)
    local top = xDTaraZ.Ore.Owned(xDTaraZ.Data.Get())[1]
    if not top then
        xDTaraZ.Stage.Collect(xDTaraZ.Stage.Best(), nil)
        top = xDTaraZ.Ore.Owned(xDTaraZ.Data.Get())[1]
    end
    if top and top.number < minimum then
        xDTaraZ.Ore.Add(top.uuid, Config.RefillAmount)
        task.wait(0.4)
    end
    return top
end

function xDTaraZ.Spawn.Choices()
    local labels, byLabel = xDTaraZ.Ore.Choices(), {}
    for label, oreId in pairs(State.OreLabels) do
        byLabel[label] = { id = oreId, kind = "Ore" }
    end
    local stoneShow = xDTaraZ.GameLib.Need(GameConfig.EnchStone.Show)
    local stones = {}
    for stoneId in pairs(stoneShow) do
        table.insert(stones, stoneId)
    end
    table.sort(stones, function(a, b)
        local ta, tb = xDTaraZ.Util.Tier(a), xDTaraZ.Util.Tier(b)
        if ta ~= tb then return ta > tb end
        return a < b
    end)
    for _, stoneId in ipairs(stones) do
        local label = stoneShow[stoneId].DisplayName or stoneId
        byLabel[label] = { id = stoneId, kind = "EnchStone" }
        table.insert(labels, label)
    end
    State.SpawnLabels = byLabel
    return labels
end

---@return boolean  false if the item was never owned and can't be found
function xDTaraZ.Spawn.Give(itemId, kind, amount)
    if kind == "Ore" then
        local uuid = xDTaraZ.Ore.Ensure(itemId, 0)
        if not uuid then return false end
        xDTaraZ.Ore.Add(uuid, amount)
        return true
    end
    local uuid = xDTaraZ.Data.Uuid(xDTaraZ.Data.Get(), itemId)
    if not uuid then return false end
    xDTaraZ.Ore.Add(uuid, amount)
    return true
end

---@return string[]  potion ids you own at least once (the rest can't be added)
function xDTaraZ.Potion.Owned()
    local owned = {}
    local stock = xDTaraZ.Data.Get().Potion or {}
    for potionId in pairs(xDTaraZ.GameLib.Need(GameConfig.Potion.Config)) do
        if stock[potionId] ~= nil then table.insert(owned, potionId) end
    end
    table.sort(owned)
    return owned
end

function xDTaraZ.Potion.Add(potionId, amount)
    xDTaraZ.Util.Remote("Potion", "TryUsePotionRE"):FireServer(potionId, -math.abs(amount))
end

---@return number  potions boosted for about a year each
function xDTaraZ.Potion.MaxBuffs()
    local use = xDTaraZ.Util.Remote("Potion", "TryUsePotionRE")
    local owned = xDTaraZ.Potion.Owned()
    for _, potionId in ipairs(owned) do
        xDTaraZ.Potion.Add(potionId, Config.PotionStack)
        use:FireServer(potionId, Config.PotionStack)
    end
    return #owned
end

---@return string  a reward key the server hasn't seen yet
function xDTaraZ.Bonus.Key(rewardId)
    local pad = table.create(Config.BonusKeyLength)
    for i = 1, Config.BonusKeyLength do
        pad[i] = math.random(2) == 1 and " " or "	"
    end
    return table.concat(pad) .. rewardId
end

---@return boolean  false once the server stops paying repeat claims
function xDTaraZ.Bonus.Works()
    if State.BonusWorks ~= nil then return State.BonusWorks end
    local classStore = xDTaraZ.GameLib.Need(ReplicatedStorage.LocalData.ClassData)
    local before = classStore.GetLuckTimes()
    xDTaraZ.Util.Remote("UpdateLog", "TryClaimUPDRewardRE"):FireServer(xDTaraZ.Bonus.Key(Config.BonusRewards.Race.id))
    local deadline = os.clock() + Config.RaceResultWait * 2
    repeat task.wait(0.1) until classStore.GetLuckTimes() > before or os.clock() > deadline
    State.BonusWorks = classStore.GetLuckTimes() > before
    return State.BonusWorks
end

---@param kind   string  Race, Season or Token
---@param amount number  rolls, tickets or tokens wanted
---@return number        claims sent, 0 when the game no longer pays them
function xDTaraZ.Bonus.Spawn(kind, amount)
    if not xDTaraZ.Bonus.Works() then return 0 end
    local reward = Config.BonusRewards[kind]
    local claim = xDTaraZ.Util.Remote("UpdateLog", "TryClaimUPDRewardRE")
    local times = math.clamp(math.ceil(amount / reward.per), 1, Config.BonusMaxClaims)
    for i = 1, times do
        claim:FireServer(xDTaraZ.Bonus.Key(reward.id))
        if i % Config.BonusBatch == 0 then task.wait() end
    end
    return times
end

---@return number  goods bought this call
function xDTaraZ.TokenShop.BuyAll()
    local goodsConfig = xDTaraZ.GameLib.Need(GameConfig.TokenShop.Config)
    local exchange = xDTaraZ.Util.Remote("TokenShop", "ExchangeGoodsRF")
    local profile = xDTaraZ.Data.Get()
    local bought = 0
    for slot, good in pairs(profile.TokenShop and profile.TokenShop.Goods or {}) do
        local entry = goodsConfig[tonumber(slot)] or goodsConfig[tostring(slot)]
        if good.Exchanged or not entry then continue end

        local short = (entry.Token or 0) - (profile.Token and profile.Token.value or 0)
        if short > 0 then
            xDTaraZ.Bonus.Spawn("Token", short + Config.BonusRewards.Token.per)
            task.wait(1)
        end
        exchange:InvokeServer(tostring(slot))
        bought += 1
        profile = xDTaraZ.Data.Get()
    end
    return bought
end

---@return number  stacks touched
function xDTaraZ.Spawn.DupeAll(amount)
    local touched = 0
    for uuid, entry in pairs(xDTaraZ.Data.Get().Backpack.have) do
        if type(entry) ~= "table" or not entry.Number or entry.Type == "Material" then continue end
        touched += 1
        xDTaraZ.Ore.Add(uuid, amount)
    end
    return touched
end

function xDTaraZ.Stage.List()
    local stages = {}
    for stageId in pairs(xDTaraZ.GameLib.Api(GameConfig.Stage.Helper).GetStageEnemyConfig()) do
        table.insert(stages, stageId)
    end
    table.sort(stages, function(a, b) return xDTaraZ.Util.Tier(a) > xDTaraZ.Util.Tier(b) end)
    return stages
end

function xDTaraZ.Stage.Best()
    return xDTaraZ.Stage.List()[1]
end

function xDTaraZ.Stage.Collect(stageId, rarities)
    local drops = xDTaraZ.Util.Remote("Stage", "StageFinishedRF"):InvokeServer(stageId)
    if type(drops) ~= "table" then return end
    for uuid, drop in pairs(drops) do
        if type(drop) == "table" then
            xDTaraZ.Util.Remote("Stage", "GetEnhantStoneRE"):FireServer(uuid)
        elseif not rarities or rarities[xDTaraZ.Ore.Rarity(drop)] then
            xDTaraZ.Util.Remote("Stage", "GetOreRF"):InvokeServer(uuid)
        end
    end
    xDTaraZ.Util.Remote("Stage", "ClaimedAllOreRE"):FireServer()
end

function xDTaraZ.Stage.FarmStones(stageId)
    local finished = xDTaraZ.Util.Remote("Stage", "StageFinishedRF")
    local pickStone = xDTaraZ.Util.Remote("Stage", "GetEnhantStoneRE")
    xDTaraZ.Util.WaitAll(Config.StoneWorkers, function()
        for _ = 1, Config.StoneCallsPerWorker do
            local drops = finished:InvokeServer(stageId)
            for uuid, drop in pairs(type(drops) == "table" and drops or {}) do
                if type(drop) == "table" then
                    pickStone:FireServer(uuid)
                end
            end
        end
    end)
end

function xDTaraZ.Stage.AcquireOre(oreId)
    local stages = xDTaraZ.Stage.List()
    local known = State.OreStage[oreId]
    local target = xDTaraZ.Util.Tier(oreId) * #stages / xDTaraZ.Util.Tier(xDTaraZ.Util.HighestKey(xDTaraZ.GameLib.Need(GameConfig.Ore.Config)))
    table.sort(stages, function(a, b)
        if a == known or b == known then return a == known end
        return math.abs(xDTaraZ.Util.Tier(a) - target) < math.abs(xDTaraZ.Util.Tier(b) - target)
    end)

    local finished = xDTaraZ.Util.Remote("Stage", "StageFinishedRF")
    local pickOre = xDTaraZ.Util.Remote("Stage", "GetOreRF")
    for round = 1, Config.AcquireRounds do
        local stageId = stages[(round - 1) % math.min(#stages, 4) + 1]
        local drops = finished:InvokeServer(stageId)
        for uuid, drop in pairs(type(drops) == "table" and drops or {}) do
            if drop == oreId and pickOre:InvokeServer(uuid) then
                xDTaraZ.Util.Remote("Stage", "ClaimedAllOreRE"):FireServer()
                State.OreStage[oreId] = stageId
                return true
            end
        end
    end
    return false
end

function xDTaraZ.Stage.ExitFight()
    xDTaraZ.GameLib.Api(LocalPlayer.PlayerScripts.Manager.StageManager.StageUtils).ExitFight(true)
end

function xDTaraZ.Forge.Target()
    for _, target in ipairs(Config.ForgeTargets) do
        if target.name == State.Opt.ForgeTarget then
            return target
        end
    end
    return Config.ForgeTargets[1]
end

function xDTaraZ.Forge.Run(forgeType, oreList)
    return xDTaraZ.Util.Remote("Forge", "ForgeRF"):InvokeServer({ ConfigType = forgeType, UUIDList = oreList })
end

function xDTaraZ.Forge.PickOwned(profile, count)
    local opt = State.Opt
    local candidates = {}
    for _, ore in ipairs(xDTaraZ.Ore.Owned(profile)) do
        local spare = ore.number - opt.KeepPerOre
        if opt.ForgeRarities[ore.rarity] and spare > 0 then
            ore.spare = spare
            table.insert(candidates, ore)
        end
    end
    if not opt.BestOreFirst then
        table.sort(candidates, function(a, b) return a.tier < b.tier end)
    end

    local pick, need = {}, count
    for _, ore in ipairs(candidates) do
        if need <= 0 then break end
        local take = math.min(need, ore.spare)
        pick[ore.uuid] = take
        need -= take
    end
    return need <= 0 and pick or nil
end

---@return table?  { [uuid] = count }, nil when no ore fits
function xDTaraZ.Forge.Pick(count)
    local oreId = State.OreLabels[State.Opt.ForgeOre]
    if not oreId then
        return xDTaraZ.Forge.PickOwned(xDTaraZ.Data.Get(), count)
    end
    local uuid = xDTaraZ.Ore.Ensure(oreId, count * State.Opt.ForgePerTick)
    return uuid and { [uuid] = count }
end

function xDTaraZ.Forge.Once()
    local target = xDTaraZ.Forge.Target()
    local pick = xDTaraZ.Forge.Pick(target.ores)
    return pick ~= nil and xDTaraZ.Forge.Run(target.forgeType, pick) ~= nil
end

function xDTaraZ.Forge.Burst()
    local target = xDTaraZ.Forge.Target()
    local perTick = State.Opt.ForgePerTick
    local pick = xDTaraZ.Forge.Pick(target.ores * perTick)
    if not pick then return end
    local uuid = next(pick)
    if next(pick, uuid) == nil then
        for _ = 1, perTick do
            xDTaraZ.Forge.Run(target.forgeType, { [uuid] = target.ores })
        end
        return
    end
    for _ = 1, perTick do
        if not xDTaraZ.Forge.Once() then break end
    end
end

function xDTaraZ.Forge.Step()
    if not State.Opt.ForgeSellJunk then return xDTaraZ.Forge.Burst() end
    local before = xDTaraZ.Data.Snapshot()
    xDTaraZ.Forge.Burst()
    local fresh = xDTaraZ.Data.NewGear(before)
    local profile = State.Profile
    local keep = {}
    for uuid, entry in pairs(fresh) do
        local worn = profile.Backpack.equiped[entry.Type]
        local wornEntry = worn and profile.Backpack.have[worn]
        if not wornEntry or xDTaraZ.Gear.Score(entry, true) > xDTaraZ.Gear.Score(wornEntry, true) then
            keep[uuid] = true
        end
    end
    xDTaraZ.Sell.Fresh(fresh, keep)
end

function xDTaraZ.Sell.Rarity(entry)
    local folder = entry.Type == "Weapon" and "Weapon" or "Armor"
    local itemConfig = xDTaraZ.GameLib.Need(GameConfig[folder].Config)[entry.ID]
    return itemConfig and itemConfig.Rarity
end

---@return table<string, boolean>  uuids of the strongest normal piece per slot, which exclusive gear takes its power from
function xDTaraZ.Sell.Anchors(profile)
    local anchors, bestPower = {}, {}
    for uuid, entry in pairs(profile.Backpack.have) do
        if not (entry.Type == "Weapon" or entry.Type == "Armor" or entry.Type == "Hat") then continue end
        local helper = xDTaraZ.GameLib.Api(entry.Type == "Weapon" and GameConfig.Weapon.Helper or GameConfig.Armor.Helper)
        local ok, percent = pcall(helper.CheckIsBestPercent, entry.ID)
        if not ok or percent then continue end
        local powerOk, power = pcall(helper.GetMainAffix, entry.ID)
        if powerOk and type(power) == "number" and power > (bestPower[entry.Type] or 0) then
            bestPower[entry.Type] = power
            anchors[entry.Type] = uuid
        end
    end
    local keep = {}
    for _, uuid in pairs(anchors) do
        keep[uuid] = true
    end
    local backpack = xDTaraZ.GameLib.Require(ReplicatedStorage.LocalData.BackpackData)
    if type(backpack) == "table" and type(backpack.IsLocked) == "function" then
        for uuid in pairs(profile.Backpack.have) do
            local ok, locked = pcall(backpack.IsLocked, uuid)
            if ok and locked then keep[uuid] = true end
        end
    end
    return keep
end

function xDTaraZ.Sell.Run(profile)
    local opt = State.Opt
    local equipped = xDTaraZ.Sell.Anchors(profile)
    for _, uuid in pairs(profile.Backpack.equiped) do
        equipped[uuid] = true
    end

    local byId = {}
    for uuid, entry in pairs(profile.Backpack.have) do
        if opt.SellTypes[entry.Type] and not equipped[uuid] then
            byId[entry.ID] = byId[entry.ID] or {}
            table.insert(byId[entry.ID], { uuid = uuid, entry = entry })
        end
    end

    local sell = xDTaraZ.Util.Remote("Backpack", "TrySellItemRE")
    for _, items in pairs(byId) do
        table.sort(items, function(a, b) return (a.entry.Level or 0) > (b.entry.Level or 0) end)
        for index, gear in ipairs(items) do
            if index > opt.KeepPerItem and opt.SellRarities[xDTaraZ.Sell.Rarity(gear.entry)] then
                sell:FireServer(gear.uuid, 1)
            end
        end
    end
end

---@param keep table?  { [uuid] = true } never sold
function xDTaraZ.Sell.Fresh(fresh, keep)
    local equipped = xDTaraZ.Sell.Anchors(State.Profile)
    for _, uuid in pairs(State.Profile.Backpack.equiped) do
        equipped[uuid] = true
    end
    local sell = xDTaraZ.Util.Remote("Backpack", "TrySellItemRE")
    for uuid in pairs(fresh) do
        if not equipped[uuid] and not (keep and keep[uuid]) then
            sell:FireServer(uuid, 1)
        end
    end
end

---@param atTarget boolean?  score as if enhanced to the target, so exclusive gear isn't skipped for a higher-level common piece
---@return number           power from the game's own formula
function xDTaraZ.Gear.Score(entry, atTarget)
    local balance = xDTaraZ.GameLib.Api(ReplicatedStorage.Utils.BalanceUtils)
    local backpack = (State.Profile or xDTaraZ.Data.Get()).Backpack
    local potential = table.clone(entry)
    if atTarget then potential.Level = math.max(entry.Level or 0, State.Opt.EnhanceTarget) end
    local value = entry.Type == "Weapon" and balance.GetWeaponTrainValue or balance.GetArmorValue
    local ok, power = pcall(value, LocalPlayer, potential, backpack)
    if not ok or type(power) ~= "number" then return 0 end
    return power * (1 + (entry.Level or 0) * 1e-6 + #(entry.EnchanceList or {}) * 1e-9)
end

function xDTaraZ.Gear.BestOwned(profile, slot, atTarget)
    local bestUuid, bestScore = nil, -1
    for uuid, entry in pairs(profile.Backpack.have) do
        if entry.Type == slot then
            local score = xDTaraZ.Gear.Score(entry, atTarget)
            if score > bestScore then
                bestUuid, bestScore = uuid, score
            end
        end
    end
    return bestUuid, bestScore
end

---@return number  slots changed
function xDTaraZ.Gear.EquipBest()
    local profile = xDTaraZ.Data.Get()
    local equip = xDTaraZ.Util.Remote("Backpack", "TryEquipItemRE")
    local changed = 0
    local atTarget = State.Opt.MaxGear and State.Opt.GearEnhance
    for _, slot in ipairs(Config.GearTypes) do
        local best, bestScore = xDTaraZ.Gear.BestOwned(profile, slot, atTarget)
        local current = profile.Backpack.equiped[slot]
        local currentEntry = current and profile.Backpack.have[current]
        if best and best ~= current and bestScore > (currentEntry and xDTaraZ.Gear.Score(currentEntry, atTarget) or -1) then
            equip:FireServer(best, slot)
            changed += 1
        end
    end
    return changed
end

function xDTaraZ.Gear.ForgeBest()
    local before = xDTaraZ.Data.Snapshot()
    for _, spec in ipairs(Config.GearSlots) do
        local top = xDTaraZ.Ore.Top(spec.ores * Config.GearForgeTries)
        if top then
            for _ = 1, Config.GearForgeTries do
                xDTaraZ.Forge.Run(spec.forgeType, { [top.uuid] = spec.ores })
            end
        end
        local best = xDTaraZ.Gear.BestOwned(xDTaraZ.Data.Get(), spec.slot, true)
        if best then
            xDTaraZ.Util.Remote("Backpack", "TryEquipItemRE"):FireServer(best, spec.slot)
        end
    end
    task.wait(1)
    xDTaraZ.Sell.Fresh(xDTaraZ.Data.NewGear(before))
end

function xDTaraZ.Gear.MissingForEnhance(profile, level)
    local cost = xDTaraZ.GameLib.Need(GameConfig.Enhant.Config)[level + 1]
    if not cost then return nil end
    if xDTaraZ.Data.Count(profile, "EnhantStone_2") < (cost.EnhantStone_2 or 0) then return "EnhantStone_2" end
    if xDTaraZ.Data.Count(profile, "EnhantStone_1") < (cost.EnhantStone_1 or 0) then return "EnhantStone_1" end
    if profile.Eco.coin < (cost.NeedCoin or 0) then return "Coin" end
    return nil
end

function xDTaraZ.Gear.Gather(missing)
    State.GearNote = missing
    if missing == "Coin" then
        xDTaraZ.Forge.Step()
        xDTaraZ.Sell.Run(xDTaraZ.Data.Get())
    elseif missing == "EnhantStone_1" then
        xDTaraZ.Stage.FarmStones(xDTaraZ.Stage.Best())
    elseif not xDTaraZ.Tower.FarmStep() then
        State.GearNote = "NoTicket"
    end
end

---@return string[]  every rune the game has from RuneMinTier up, strongest tier first
function xDTaraZ.Gear.RuneOrder()
    if State.Runes then return State.Runes end
    local show = xDTaraZ.GameLib.Find("Config.EnchStone.Show")
    local stones = show and xDTaraZ.GameLib.Require(show)
    if not stones then return Config.EnchantPriority end

    local known = {}
    for index, stoneId in ipairs(Config.EnchantPriority) do
        known[stoneId] = index
    end
    local runes = {}
    for stoneId in pairs(stones) do
        if xDTaraZ.Util.Tier(stoneId) >= Config.RuneMinTier then runes[#runes + 1] = stoneId end
    end
    table.sort(runes, function(a, b)
        local ta, tb = xDTaraZ.Util.Tier(a), xDTaraZ.Util.Tier(b)
        if ta ~= tb then return ta > tb end
        local ka, kb = known[a] or math.huge, known[b] or math.huge
        if ka ~= kb then return ka < kb end
        return a < b
    end)
    State.Runes = runes
    return runes
end

function xDTaraZ.Gear.Priority()
    return #State.Opt.EnchantPriority > 0 and State.Opt.EnchantPriority or xDTaraZ.Gear.RuneOrder()
end

function xDTaraZ.Gear.StockEnchants(profile)
    for _, stoneId in ipairs(xDTaraZ.Gear.Priority()) do
        local uuid = xDTaraZ.Data.Uuid(profile, stoneId)
        if uuid and xDTaraZ.Data.Count(profile, stoneId) < Config.EnchantRefill then
            xDTaraZ.Ore.Add(uuid, Config.EnchantRefill)
        end
    end
end

function xDTaraZ.Gear.Enchant(profile, uuid)
    local entry = profile.Backpack.have[uuid]
    local used = {}
    for slot = 1, entry.EnchanceNum or 0 do
        local current = entry.EnchanceList and entry.EnchanceList[slot]
        local currentId = current and current.ID
        local wanted
        for _, stoneId in ipairs(xDTaraZ.Gear.Priority()) do
            if not used[stoneId] and (stoneId == currentId or xDTaraZ.Data.Count(profile, stoneId) > 0) then
                wanted = stoneId
                break
            end
        end
        if wanted then
            used[wanted] = true
            if wanted ~= currentId then
                if currentId then
                    xDTaraZ.Util.Remote("Backpack", "UnEnchantRE"):FireServer(uuid, slot)
                    task.wait(0.3)
                end
                xDTaraZ.Util.Remote("Backpack", "EnchantRE"):FireServer(uuid, xDTaraZ.Data.Uuid(profile, wanted), slot)
                task.wait(0.3)
            end
        end
    end
end

function xDTaraZ.Gear.Enhance(profile)
    local target = math.min(State.Opt.EnhanceTarget, xDTaraZ.Util.Tier(xDTaraZ.Util.HighestKey(xDTaraZ.GameLib.Need(GameConfig.Enhant.Config))))
    local enhance = xDTaraZ.Util.Remote("Backpack", "EnhantEquipmentRF")
    for _, spec in ipairs(Config.GearSlots) do
        local uuid = profile.Backpack.equiped[spec.slot]
        local entry = uuid and profile.Backpack.have[uuid]
        if entry and (entry.Level or 0) < target then
            local missing = xDTaraZ.Gear.MissingForEnhance(profile, entry.Level or 0)
            if missing then
                xDTaraZ.Gear.Gather(missing)
                return false
            end
            State.GearNote = "Enhancing"
            local useProtect = xDTaraZ.Data.Count(profile, "EnhantProtect") > 0 and (entry.Level or 0) >= xDTaraZ.GameLib.Api(GameConfig.Enhant.Helper).GetFailLevel()
            xDTaraZ.Util.WaitAll(Config.GearEnhanceWorkers, function()
                for _ = 1, Config.GearEnhanceTries do
                    if not enhance:InvokeServer(uuid, { UseProtect = useProtect }) then return end
                end
            end)
            return false
        end
    end
    return true
end

function xDTaraZ.Gear.MaxStep()
    local opt = State.Opt
    if opt.GearForge and not State.GearForged then
        xDTaraZ.Gear.ForgeBest()
        State.GearForged = true
    end
    if opt.GearEnchant then
        local profile = xDTaraZ.Data.Get()
        xDTaraZ.Gear.StockEnchants(profile)
        profile = xDTaraZ.Data.Get()
        for _, spec in ipairs(Config.GearSlots) do
            local uuid = profile.Backpack.equiped[spec.slot]
            if uuid then xDTaraZ.Gear.Enchant(profile, uuid) end
        end
    end
    if not opt.GearEnhance or xDTaraZ.Gear.Enhance(xDTaraZ.Data.Get()) then
        State.GearNote = "Done"
    end
end

---@return number?  level reached, nil if nothing equipped there
function xDTaraZ.Gear.EnhanceSlot(slot, target)
    local enhance = xDTaraZ.Util.Remote("Backpack", "EnhantEquipmentRF")
    local failLevel = xDTaraZ.GameLib.Api(GameConfig.Enhant.Helper).GetFailLevel()
    local level = 0
    for _ = 1, Config.SlotEnhanceRounds do
        local profile = xDTaraZ.Data.Get()
        local uuid = profile.Backpack.equiped[slot]
        local entry = uuid and profile.Backpack.have[uuid]
        if not entry then return nil end
        level = entry.Level or 0
        if level >= target then return level end
        local missing = xDTaraZ.Gear.MissingForEnhance(profile, level)
        if missing == "EnhantStone_1" then
            xDTaraZ.Stage.FarmStones(xDTaraZ.Stage.Best())
        elseif missing then
            return level
        else
            enhance:InvokeServer(uuid, { UseProtect = level >= failLevel and xDTaraZ.Data.Count(profile, "EnhantProtect") > 0 })
        end
    end
    return level
end

function xDTaraZ.Gear.EquippedNames(profile)
    local names = {}
    for _, spec in ipairs(Config.GearSlots) do
        local uuid = profile.Backpack.equiped[spec.slot]
        local entry = uuid and profile.Backpack.have[uuid]
        if entry then
            local shows = xDTaraZ.GameLib.Require(GameConfig[entry.Type == "Weapon" and "Weapon" or "Armor"].Show)
            local show = shows and shows[entry.ID]
            table.insert(names, ("%s +%d"):format(show and show.DisplayName or entry.ID, entry.Level or 0))
        end
    end
    return table.concat(names, " · ")
end

function xDTaraZ.Index.GearCatalog()
    local gear = {}
    local armorHelper = xDTaraZ.GameLib.Api(GameConfig.Armor.Helper)
    for weaponId, weapon in pairs(xDTaraZ.GameLib.Need(GameConfig.Weapon.Config)) do
        table.insert(gear, { id = weaponId, slot = "Weapon", forgeType = "Weapon", forgeable = weapon.TLevel ~= nil })
    end
    for armorId, armor in pairs(xDTaraZ.GameLib.Need(GameConfig.Armor.Config)) do
        table.insert(gear, { id = armorId, slot = armorHelper.GetBigType(armorId) or "Armor", forgeType = "Armor", forgeable = armor.TLevel ~= nil })
    end
    return gear
end

---@return table[]  gear the index still lacks, filtered by IndexTypes
function xDTaraZ.Index.Missing()
    local unlocked = xDTaraZ.Data.Get().Index.unlocked
    local missing = {}
    for _, gear in ipairs(xDTaraZ.Index.GearCatalog()) do
        if State.Opt.IndexTypes[gear.slot] and not unlocked[gear.slot .. "-" .. gear.id] then
            table.insert(missing, gear)
        end
    end
    table.sort(missing, function(a, b)
        if a.forgeable ~= b.forgeable then return a.forgeable end
        return a.id < b.id
    end)
    return missing
end

---@return number, string?, number?  chance per forge, ore id, ore count
function xDTaraZ.Index.Plan(gear)
    local cached = State.Plans[gear.id]
    if cached then return cached[1], cached[2], cached[3] end

    local forgeUtils = xDTaraZ.GameLib.Api(ReplicatedStorage.Utils.ForgeUtils)
    local helper = xDTaraZ.GameLib.Api(gear.forgeType == "Weapon" and GameConfig.Weapon.Helper or GameConfig.Armor.Helper)
    local bestChance, bestOre, bestCount = 0, nil, nil
    local sliceStart = os.clock()
    for count = 1, Config.ForgeCountMax do
        local split = helper.GetForgePercentByNumber(count)
        if not split then continue end
        for _, oreId in ipairs(xDTaraZ.Ore.Ids()) do
            if os.clock() - sliceStart > Config.PlanSlice then
                task.wait()
                sliceStart = os.clock()
            end
            local list = { [oreId] = count }
            local ok, chance = pcall(function()
                local low, high = forgeUtils.GetForgeOreResult(list)
                local power = forgeUtils.GetOreAvgPower(list)
                local total = 0
                for subType, share in pairs(split) do
                    if share > 0 then
                        total += share * (forgeUtils.GetEquPercent(gear.forgeType, count, low, high, power, subType)[gear.id] or 0)
                    end
                end
                return total
            end)
            if ok and chance > bestChance then
                bestChance, bestOre, bestCount = chance, oreId, count
            end
        end
    end
    State.Plans[gear.id] = { bestChance, bestOre, bestCount }
    return bestChance, bestOre, bestCount
end

function xDTaraZ.Index.Label(gear)
    local show = xDTaraZ.GameLib.Need(GameConfig[gear.forgeType].Show)[gear.id]
    local name = ("%s [%s]"):format(show and show.DisplayName or gear.id, gear.slot)
    if not gear.forgeable then return name .. " - event" end
    local chance = xDTaraZ.Index.Plan(gear)
    return chance > 0 and ("%s - %.2f%%"):format(name, chance * 100) or name .. " - no recipe"
end

function xDTaraZ.Index.Choices()
    local labels, byLabel = {}, {}
    for _, gear in ipairs(xDTaraZ.Index.Missing()) do
        local label = xDTaraZ.Index.Label(gear)
        byLabel[label] = gear
        table.insert(labels, label)
    end
    State.MissingLabels = byLabel
    return labels
end

---@param copies number?  keep forging until this many new copies, ignoring the index
---@return boolean        true once the index has it, or all copies were made
function xDTaraZ.Index.Hunt(gear, copies)
    local chance, oreId, count = xDTaraZ.Index.Plan(gear)
    if chance <= 0 then return false end
    local budget = math.min(Config.HuntMaxForges * (copies or 1), math.ceil(Config.HuntTargetHits * (copies or 1) / chance))
    local key = gear.slot .. "-" .. gear.id
    local forged, got = 0, 0
    while forged < budget and State.Alive do
        local uuid = xDTaraZ.Ore.Ensure(oreId, count * Config.HuntBatch)
        if not uuid then return false end
        local before = xDTaraZ.Data.Snapshot()
        local perWorker = math.ceil(Config.HuntBatch / Config.HuntWorkers)
        xDTaraZ.Util.WaitAll(Config.HuntWorkers, function()
            for _ = 1, perWorker do
                xDTaraZ.Forge.Run(gear.forgeType, { [uuid] = count })
            end
        end)
        forged += perWorker * Config.HuntWorkers
        State.IndexNote = ("%s %d/%d"):format(gear.id, forged, budget)
        local fresh = xDTaraZ.Data.NewGear(before)
        local keep = {}
        for freshUuid, entry in pairs(fresh) do
            if entry.ID == gear.id and (not copies or got < copies) then
                keep[freshUuid] = true
                got += 1
            end
        end
        xDTaraZ.Sell.Fresh(fresh, keep)
        if copies then
            State.IndexNote = ("%s %d/%d"):format(gear.id, got, copies)
            if got >= copies then return true end
        elseif State.Profile.Index.unlocked[key] or next(keep) then
            return true
        end
    end
    return false
end

---@param slot string  "Weapon", "Armor" or "Hat"
---@return string[]    every forgeable piece of that slot, strongest first
function xDTaraZ.Spawn.GearChoices(slot)
    local labels, byLabel, list = {}, {}, {}
    for _, gear in ipairs(xDTaraZ.Index.GearCatalog()) do
        if not gear.forgeable or gear.slot ~= slot then continue end
        local helper = xDTaraZ.GameLib.Api(gear.forgeType == "Weapon" and GameConfig.Weapon.Helper or GameConfig.Armor.Helper)
        local ok, power = pcall(helper.GetMainAffix, gear.id)
        table.insert(list, { gear, ok and tonumber(power) or 0 })
    end
    table.sort(list, function(a, b) return a[2] > b[2] end)
    for _, pair in ipairs(list) do
        local label = xDTaraZ.Index.Label(pair[1])
        byLabel[label] = pair[1]
        table.insert(labels, label)
    end
    State.GearLabels = byLabel
    return labels
end

---@return number, number  found, tried
---@return number  pieces spawned, one per slot at most
function xDTaraZ.Spawn.BestSet()
    local made = 0
    for _, slot in ipairs(Config.GearTypes) do
        local best, bestPower = nil, -1
        for _, gear in ipairs(xDTaraZ.Index.GearCatalog()) do
            if not gear.forgeable or gear.slot ~= slot then continue end
            local helper = xDTaraZ.GameLib.Api(gear.forgeType == "Weapon" and GameConfig.Weapon.Helper or GameConfig.Armor.Helper)
            local ok, power = pcall(helper.GetMainAffix, gear.id)
            power = ok and tonumber(power) or 0
            if power > bestPower then best, bestPower = gear, power end
        end
        if best and xDTaraZ.Index.Hunt(best, 1) then made += 1 end
    end
    task.wait(0.5)
    xDTaraZ.Gear.EquipBest()
    return made
end

function xDTaraZ.Index.HuntAll()
    local found, tried = 0, 0
    for _, gear in ipairs(xDTaraZ.Index.Missing()) do
        if not State.Opt.AutoIndex and State.Lock ~= "Index" then break end
        if gear.forgeable and xDTaraZ.Index.Plan(gear) > 0 then
            tried += 1
            if xDTaraZ.Index.Hunt(gear) then found += 1 end
        end
    end
    xDTaraZ.Index.ClaimAll()
    if tried > 0 then State.IndexNote = ("Found %d/%d"):format(found, tried) end
    return found, tried
end

function xDTaraZ.Index.CollectOres()
    for _, stageId in ipairs(xDTaraZ.Stage.List()) do
        xDTaraZ.Stage.Collect(stageId, nil)
    end
    xDTaraZ.Index.ClaimAll()
end

function xDTaraZ.Index.ClaimAll()
    local index = xDTaraZ.Data.Get().Index
    local claimExp = xDTaraZ.Util.Remote("Index", "TryClaimIndexExpRF")
    for key in pairs(index.unlocked) do
        local itemType, itemId = key:match("^(.-)%-(.+)$")
        if itemType and not index.claimed[key] then
            claimExp:InvokeServer(itemType, itemId)
        end
    end
    local claimLevel = xDTaraZ.Util.Remote("Index", "TryClaimLevelRewardRF")
    for _ = 1, Config.IndexLevelClaims do
        if not claimLevel:InvokeServer() then break end
    end
end

function xDTaraZ.Index.Progress()
    local index = xDTaraZ.Data.Get().Index
    local unlocked = 0
    for _ in pairs(index.unlocked) do
        unlocked += 1
    end
    return unlocked, index.level
end

---@param gen number  State.TrainGen at the start; a newer one aborts the search
---@return number?    area entered, nil when none accepted or AutoTrain was toggled meanwhile
function xDTaraZ.Level.FindBestArea(gen)
    local areas = xDTaraZ.GameLib.Need(GameConfig.TrainArea.Config)
    local ids = {}
    for areaId in pairs(areas) do
        table.insert(ids, tonumber(areaId))
    end
    table.sort(ids, function(a, b) return areas[a].Basic > areas[b].Basic end)

    local function Live()
        return State.Opt.AutoTrain and State.TrainGen == gen
    end

    local into = xDTaraZ.Util.Remote("Train", "IntoAutoTrainRE")
    for _, areaId in ipairs(ids) do
        if not Live() then return nil end
        State.TrainPending = areaId
        into:FireServer(areaId)
        local deadline = os.clock() + Config.TrainAcceptWait
        while Live() and os.clock() < deadline and LocalPlayer:GetAttribute("AutoTrainAreaID") ~= areaId do
            task.wait(0.1)
        end
        if LocalPlayer:GetAttribute("AutoTrainAreaID") == areaId then
            State.TrainPending = nil
            return areaId
        end
    end
    State.TrainPending = nil
    return nil
end

function xDTaraZ.Level.Enter()
    if not State.Opt.AutoTrain or State.TrainEntering then return end
    if State.TrainArea then
        if os.clock() - State.TrainFiredAt < Config.TrainAcceptWait then return end
        State.TrainFiredAt = os.clock()
        xDTaraZ.Util.Remote("Train", "IntoAutoTrainRE"):FireServer(State.TrainArea)
        return
    end

    local gen = State.TrainGen
    State.TrainEntering = true
    local ok, areaId = pcall(xDTaraZ.Level.FindBestArea, gen)
    State.TrainEntering = false
    if not ok then error(areaId, 0) end
    if State.TrainGen == gen and areaId then
        State.TrainArea = areaId
        State.TrainFiredAt = os.clock()
    end
end

---Exits the training area and keeps resending until the server drops it; stops if AutoTrain is turned back on or the hub unloaded.
function xDTaraZ.Level.Leave()
    local exit = xDTaraZ.Util.Remote("Train", "ExitAutoTrainRE")
    for _ = 1, Config.TrainExitTries do
        local areaId = LocalPlayer:GetAttribute("AutoTrainAreaID") or State.TrainPending or State.TrainArea
        if not areaId then return end
        exit:FireServer(areaId)
        if not State.Alive then
            State.TrainPending = nil
            return
        end

        task.wait(Config.TrainSettle)
        if State.Opt.AutoTrain then return end
        if not LocalPlayer:GetAttribute("AutoTrainAreaID") then
            State.TrainPending = nil
            return
        end
    end
    warn("[LootToForge] training area still set after", Config.TrainExitTries, "exits")
end

function xDTaraZ.Level.SetTraining(enabled)
    State.TrainGen += 1
    if enabled then
        xDTaraZ.Level.Enter()
    else
        xDTaraZ.Level.Leave()
    end
end

function xDTaraZ.Level.Bind()
    table.insert(State.Conns, LocalPlayer:GetAttributeChangedSignal("AutoTrainAreaID"):Connect(function()
        if not State.Opt.AutoTrain or LocalPlayer:GetAttribute("AutoTrainAreaID") then return end
        task.delay(Config.TrainRejoinDelay, function()
            if State.Opt.AutoTrain and not LocalPlayer:GetAttribute("AutoTrainAreaID") then
                xDTaraZ.Util.Try(xDTaraZ.Level.Enter)
            end
        end)
    end))
end

function xDTaraZ.Level.UsePotions(profile)
    local potionConfig = xDTaraZ.GameLib.Need(GameConfig.Potion.Config)
    local now = workspace:GetAttribute("ServerTime") or os.time()
    local buffs = profile.Buff or {}
    for potionName, count in pairs(profile.Potion or {}) do
        local buffId = potionConfig[potionName] and potionConfig[potionName].BuffID
        local active = buffId and type(buffs[buffId]) == "number" and buffs[buffId] > now
        if type(count) == "number" and count > 0 and not active then
            xDTaraZ.Util.Remote("Potion", "TryUsePotionRE"):FireServer(potionName, 1)
        end
    end
end

function xDTaraZ.Level.TrainStep()
    local profile = xDTaraZ.Data.Get()
    xDTaraZ.Level.UsePotions(profile)
    if profile.Eco.rebirth ~= State.TrainRebirth or profile.Eco.level ~= State.TrainLevel then
        State.TrainRebirth = profile.Eco.rebirth
        State.TrainLevel = profile.Eco.level
        State.TrainArea = nil
    end

    if LocalPlayer:GetAttribute("AutoTrainAreaID") then
        State.TrainNilSince = nil
        return
    end
    State.TrainNilSince = State.TrainNilSince or os.clock()
    if os.clock() - State.TrainNilSince < Config.TrainWatchdog then return end
    xDTaraZ.Level.Enter()
end

function xDTaraZ.Level.Rebirth()
    xDTaraZ.Util.Remote("Rebirth", "TryRebirthRE"):FireServer()
end

function xDTaraZ.Level.RebirthStep()
    local profile = xDTaraZ.Data.Get()
    local ok, needLevel = pcall(xDTaraZ.GameLib.Api(GameConfig.Rebirth.Helper).GetNeedLevel, profile.Eco.rebirth + 1)
    if ok and needLevel and profile.Eco.level >= needLevel then
        xDTaraZ.Level.Rebirth()
    end
end

function xDTaraZ.Level.ClickOnce()
    xDTaraZ.GameLib.Api(ReplicatedStorage.CTRL.TrainCTRL).TrainOnce()
end

function xDTaraZ.Level.StartClicking()
    if State.ClickLoop then return end
    State.ClickLoop = task.defer(function()
        while State.Alive and State.Opt.AutoClick do
            xDTaraZ.Scheduler.Run("AutoClick", xDTaraZ.Level.ClickOnce)
            task.wait(Config.ClickInterval)
        end
        State.ClickLoop = nil
    end)
end

function xDTaraZ.Upgrade.Names()
    local names = {}
    for name in pairs(xDTaraZ.GameLib.Need(GameConfig.Upgrade.Config)) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

function xDTaraZ.Upgrade.BuySelected()
    local buy = xDTaraZ.Util.Remote("Upgrade", "UpgradeOnceRE")
    for name, selected in pairs(State.Opt.Upgrades) do
        if selected then buy:FireServer(name) end
    end
end

---@return number  highest floor that still has a loot table
function xDTaraZ.Tower.LastRound()
    return #xDTaraZ.GameLib.Need(GameConfig.Dungeon.Config.LootTab)
end

function xDTaraZ.Tower.Enter()
    local deadline = os.clock() + 10
    while State.Entering and os.clock() < deadline do
        task.wait(0.1)
    end
    if State.InTower then return true end
    State.Entering = true
    local ok, entered = pcall(function()
        return xDTaraZ.Util.Remote("Dungeon", "TryIntoDungeonRF"):InvokeServer(1)
    end)
    State.Entering = false
    State.InTower = ok and entered and true or false
    return State.InTower
end

function xDTaraZ.Tower.Exit()
    if not State.InTower then return end
    State.InTower = false
    xDTaraZ.Util.Remote("Dungeon", "ExitDungeonRE"):FireServer()
end

function xDTaraZ.Tower.FarmStep()
    if not xDTaraZ.Tower.Enter() then return false end
    local round = xDTaraZ.Tower.LastRound()
    local start = xDTaraZ.Util.Remote("Dungeon", "StartRoundRE")
    local complete = xDTaraZ.Util.Remote("Dungeon", "CompleteRoundRF")
    start:FireServer(round)
    xDTaraZ.Util.WaitAll(Config.TowerWorkers, function()
        for _ = 1, Config.TowerCallsPerWorker do
            if complete:InvokeServer(round) then
                State.TowerLoot += 1
            end
        end
    end)
    return true
end

---@return number  season coins gained
function xDTaraZ.Tower.FarmCoins(target)
    local start = (xDTaraZ.Season.Current() or {}).SeasonCoin or 0
    local deadline = os.clock() + Config.CoinFarmTimeout
    local gained = 0
    while gained < target and os.clock() < deadline do
        if not State.InTower and xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "Dungeon_Ticket") < 1 then break end
        if not xDTaraZ.Tower.FarmStep() then break end
        gained = ((xDTaraZ.Season.Current() or {}).SeasonCoin or 0) - start
    end
    xDTaraZ.Tower.Exit()
    return gained
end

---@return string?  basic attack id of the equipped weapon, nil for an unknown weapon type
function xDTaraZ.Boss.AttackId()
    local weapon = LocalPlayer:GetAttribute("WeaponType")
    return Config.BossAttackIds[weapon]
end

function xDTaraZ.Boss.Join()
    xDTaraZ.Util.Remote("WorldBoss", "IntoWorldBossFight"):FireServer()
    local char = LocalPlayer.Character
    if char and not State.BossReturn then State.BossReturn = char:GetPivot() end
end

---@param boss Model
function xDTaraZ.Boss.StandNear(boss)
    local char = LocalPlayer.Character
    if not char then return end
    local pos = boss:GetPivot().Position
    if (char:GetPivot().Position - pos).Magnitude > Config.BossReach then
        char:PivotTo(CFrame.new(pos + Vector3.new(0, Config.BossStandHeight, Config.BossStandBack), pos))
    end
end

function xDTaraZ.Boss.Step()
    local bossName = workspace:GetAttribute("CurrentWorldBoss")
    if not bossName then return end
    local attackId = xDTaraZ.Boss.AttackId()
    if not attackId then return end
    if LocalPlayer:GetAttribute("IntoFight") ~= "WorldBoss" then
        xDTaraZ.Boss.Join()
        task.wait(Config.BossJoinSettle)
    end

    local boss = workspace.EnemyFolder_Server:FindFirstChild(bossName)
    if not boss or boss:GetAttribute("Dead") then return end
    xDTaraZ.Boss.StandNear(boss)
    local announce = xDTaraZ.Util.Remote("Attack", "UseAnyATKRE")
    local attack = xDTaraZ.Util.Remote("Attack", "AttackEnemyServiceRE")
    for _ = 1, Config.BossHitsPerTick do
        if not (State.Opt.AutoWorldBoss and boss.Parent) then return end
        announce:FireServer(attackId, workspace:GetServerTimeNow())
        attack:FireServer({ bossName }, { Phase = 1, SkillID = attackId, Attacker = LocalPlayer }, workspace:GetServerTimeNow())
        task.wait(Config.BossHitGap)
    end
end

function xDTaraZ.Boss.ClaimCards()
    local claim = xDTaraZ.Util.Remote("WorldBoss", "TryClaimBossRewardRE")
    for card = 1, Config.BossCards do
        task.spawn(claim.FireServer, claim, tostring(card))
    end
end

function xDTaraZ.Boss.Leave()
    xDTaraZ.Util.Remote("WorldBoss", "ExitWorldBossFight"):FireServer()
    LocalPlayer:SetAttribute("IntoFight", nil)
    local char = LocalPlayer.Character
    if State.BossReturn and char then char:PivotTo(State.BossReturn) end
    State.BossReturn = nil
end

function xDTaraZ.Boss.Bind()
    table.insert(State.Conns, xDTaraZ.Util.Remote("WorldBoss", "BossDeadRE").OnClientEvent:Connect(function()
        if not State.Opt.AutoWorldBoss then return end
        State.BossLooting = os.clock()
        task.delay(Config.BossClaimDelay, function()
            if State.Opt.BossCards then xDTaraZ.Util.Try(xDTaraZ.Boss.ClaimCards) end
            task.wait(Config.BossHopAfter)
            xDTaraZ.Util.Try(xDTaraZ.Boss.Leave)
            State.BossDone = os.clock()
            State.BossLooting = nil
        end)
    end))
    table.insert(State.Conns, xDTaraZ.Util.Remote("WorldBoss", "BossEscapeRE").OnClientEvent:Connect(function()
        if State.Opt.AutoWorldBoss then xDTaraZ.Util.Try(xDTaraZ.Boss.Leave) end
    end))
end

function xDTaraZ.Season.Current()
    local seasons = xDTaraZ.Data.Get().Season or {}
    local bestKey = xDTaraZ.Util.HighestKey(seasons)
    return bestKey and seasons[bestKey]
end

function xDTaraZ.Season.Goods()
    local goods = xDTaraZ.GameLib.Need(GameConfig.Season.GoodsConfig)
    local ids = {}
    for goodId in pairs(goods) do
        table.insert(ids, goodId)
    end
    table.sort(ids, function(a, b) return tonumber(a) < tonumber(b) end)
    local labels, byLabel = {}, {}
    for _, goodId in ipairs(ids) do
        local good = goods[goodId]
        local label = ("%s x%d (%d coin)"):format(good.ID, good.Number, good.NeedSeasonCoin)
        byLabel[label] = goodId
        table.insert(labels, label)
    end
    return labels, byLabel
end

---@return number  exclusive gear bought, farming the coins first when short
function xDTaraZ.Season.BuyExclusive()
    local goods = xDTaraZ.GameLib.Need(GameConfig.Season.GoodsConfig)
    local exchange = xDTaraZ.Util.Remote("Season", "ExchangeGoodsRE")
    local bought = 0
    for goodId, good in pairs(goods) do
        if good.Type ~= "Weapon" and good.Type ~= "Armor" and good.Type ~= "Hat" then continue end
        local season = xDTaraZ.Season.Current()
        if not season or ((season.Goods or {})[goodId] or 0) >= (good.Store or 1) then continue end
        local short = good.NeedSeasonCoin - (season.SeasonCoin or 0)
        if short > 0 then xDTaraZ.Tower.FarmCoins(short) end
        exchange:FireServer(goodId)
        bought += 1
        task.wait(0.5)
    end
    return bought
end

function xDTaraZ.Season.BuyGoods()
    local goods = xDTaraZ.GameLib.Need(GameConfig.Season.GoodsConfig)
    local exchange = xDTaraZ.Util.Remote("Season", "ExchangeGoodsRE")
    for goodId, wanted in pairs(State.Opt.SeasonGoods) do
        local good = goods[goodId]
        if not (wanted and good) then continue end
        for _ = 1, good.Store or 1 do
            local season = xDTaraZ.Season.Current()
            if not season or (season.SeasonCoin or 0) < good.NeedSeasonCoin then break end
            exchange:FireServer(goodId)
            task.wait(0.3)
        end
    end
end

function xDTaraZ.Season.Step()
    xDTaraZ.Util.Remote("Season", "TryClaimDailyTicRE"):FireServer()
    xDTaraZ.Util.Remote("Season", "TryClaimAllRewardRE"):FireServer()
    task.wait(0.5)
    xDTaraZ.Season.BuyGoods()
    local season = xDTaraZ.Season.Current()
    if not (season and State.Opt.SeasonSpin) then return end
    local luck = xDTaraZ.Util.Remote("Season", "LuckRE")
    for _ = 1, season.SeasonTicket or 0 do
        luck:FireServer(1)
        task.wait(0.5)
    end
end

function xDTaraZ.Claim.All()
    xDTaraZ.Util.Remote("Offline", "TryClaimOfflineRewardRE"):FireServer()
    xDTaraZ.Util.Remote("Dungeon", "TryClaimDailyDunTicRE"):FireServer()
    xDTaraZ.Util.Try(xDTaraZ.Index.ClaimAll)

    local claimQuest = xDTaraZ.Util.Remote("EnhantEvent", "TryClaimQuestRE")
    local claimUpdate = xDTaraZ.Util.Remote("UpdateLog", "TryClaimUPDRewardRE")
    for id = 1, Config.ClaimIdScan do
        claimQuest:FireServer(id)
        claimUpdate:FireServer(id)
    end

    local ok, rewards = pcall(xDTaraZ.GameLib.Api(GameConfig.Online.Helper).GetOnlineRewardConfig)
    for rewardName in pairs(ok and type(rewards) == "table" and rewards or {}) do
        xDTaraZ.Util.Remote("Online", "TryClaimRE"):FireServer(rewardName)
    end
end

---@return string  the server's message for this code ("no reply" when it stayed silent)
function xDTaraZ.Claim.Code(code)
    local message
    local hasListener, messageEvent = pcall(xDTaraZ.Util.Remote, "Message", "MessageRE")
    local conn = hasListener and messageEvent.OnClientEvent:Connect(function(text)
        message = message or tostring(text)
    end)
    local ok, err = pcall(function()
        return xDTaraZ.Util.Remote("Code", "TryUseCodeRF"):InvokeServer(code)
    end)
    local deadline = os.clock() + Config.CodeReplyWait
    while conn and not message and os.clock() < deadline do task.wait(0.05) end
    if conn then conn:Disconnect() end
    if not ok then return "failed: " .. tostring(err) end
    return message or "no reply"
end

function xDTaraZ.Claim.AllCodes()
    local results = {}
    for _, code in ipairs(Config.Codes) do
        table.insert(results, ("%s: %s"):format(code, xDTaraZ.Claim.Code(code)))
    end
    return table.concat(results, "\n")
end

function xDTaraZ.SuperLoot.Kill(uuid)
    xDTaraZ.Util.Remote("SuperLoot", "KillSuperLootRE"):FireServer(uuid)
    task.wait(0.2)
    xDTaraZ.Util.Remote("Stage", "GetOreRF"):InvokeServer(uuid)
    xDTaraZ.Util.Remote("Stage", "ClaimedAllOreRE"):FireServer()
end

function xDTaraZ.SuperLoot.KillExisting()
    for _, enemy in ipairs(workspace.EnemyFolder:GetChildren()) do
        local enemyId = enemy:GetAttribute("EnemyID")
        if enemyId and enemyId:find("^Super") then
            task.spawn(xDTaraZ.Util.Try, xDTaraZ.SuperLoot.Kill, enemy.Name)
        end
    end
end

function xDTaraZ.SuperLoot.Bind()
    table.insert(State.Conns, xDTaraZ.Util.Remote("SuperLoot", "RefreshSuperLootRE").OnClientEvent:Connect(function(_, uuid)
        if State.Opt.SuperLootAura then
            task.spawn(xDTaraZ.Util.Try, xDTaraZ.SuperLoot.Kill, uuid)
        end
    end))
end

function xDTaraZ.Combat.KillAll()
    local hit = xDTaraZ.GameLib.Api(ReplicatedStorage.Utils.CommunicationUtils).TryGetBindableEvent("Attack", "EnemyHitBE")
    local hitInfo = { SkillID = "K_ATK_1", IsCrit = true, Damage = Config.KillDamage }
    for _, enemy in ipairs(workspace.EnemyFolder:GetChildren()) do
        local enemyId = enemy:GetAttribute("EnemyID")
        if enemyId and not enemyId:find("^Super") then
            hit:Fire(enemy.Name, Config.KillDamage, hitInfo)
        end
    end
end

function xDTaraZ.Combat.Start()
    if State.AuraLoop then return end
    State.AuraLoop = task.defer(function()
        while State.Alive and State.Opt.KillAura do
            xDTaraZ.Scheduler.Run("KillAura", xDTaraZ.Combat.KillAll)
            task.wait(Config.KillAuraInterval)
        end
        State.AuraLoop = nil
    end)
end

---@return boolean  false when the game's damage function can't be reached
function xDTaraZ.Guard.HookDamage()
    if State.RestoreDamage then return true end
    local hpCtrl = xDTaraZ.GameLib.Require(ReplicatedStorage.CTRL.HPCTRL)
    local damageOnce = hpCtrl and hpCtrl.DamageOnce
    if type(damageOnce) ~= "function" then return false end

    hpCtrl.DamageOnce = function(target, damage)
        if target == LocalPlayer and State.Opt.GodMode then return false end
        return damageOnce(target, damage)
    end
    State.RestoreDamage = function()
        hpCtrl.DamageOnce = damageOnce
        State.RestoreDamage = nil
    end
    return true
end

---@return boolean  false when the executor can't hook namecall or the remote is missing
function xDTaraZ.Guard.HookOreLoss()
    if State.RestoreNamecall then return true end
    local compat = xDTaraZ.Compat
    if not (compat and compat.Caps.Namecall) then return false end
    local found, lostOre = pcall(xDTaraZ.Util.Remote, "Stage", "LostAllOreRF")
    if not found then
        warn("[LootToForge] keep ore:", lostOre)
        return false
    end

    local original, restore
    original, restore = compat.HookMeta(game, "__namecall", function(self, ...)
        if self == lostOre and State.Opt.KeepOre and getnamecallmethod() == "InvokeServer" then
            return {}
        end
        return original(self, ...)
    end)
    if not original then return false end

    State.RestoreNamecall = function()
        State.RestoreNamecall = nil
        restore()
    end
    return true
end

function xDTaraZ.Guard.UnhookOreLoss()
    if State.RestoreNamecall then State.RestoreNamecall() end
end

function xDTaraZ.Guard.Stop()
    if State.RestoreDamage then State.RestoreDamage() end
    xDTaraZ.Guard.UnhookOreLoss()
end

function xDTaraZ.Race.Choices()
    local classConfig = xDTaraZ.GameLib.Need(GameConfig.Class.Config)
    local show = xDTaraZ.GameLib.Need(GameConfig.Class.Show)
    local ids = {}
    for classId in pairs(classConfig) do
        table.insert(ids, classId)
    end
    table.sort(ids, function(a, b) return classConfig[a].Weight < classConfig[b].Weight end)

    local labels, idByLabel = {}, {}
    for _, classId in ipairs(ids) do
        local label = ("%s (%s)"):format(show[classId] and show[classId].DisplayName or classId, classConfig[classId].Rarity)
        idByLabel[label] = classId
        table.insert(labels, label)
    end
    return labels, idByLabel
end

function xDTaraZ.Race.EquipBest()
    local classData = xDTaraZ.Data.Get().Class
    local classConfig = xDTaraZ.GameLib.Need(GameConfig.Class.Config)
    local bestSlot, bestWeight = nil, math.huge
    for slot, classId in pairs(classData.have) do
        local weight = classConfig[classId] and classConfig[classId].Weight or math.huge
        if weight < bestWeight then bestSlot, bestWeight = slot, weight end
    end
    if not bestSlot or tostring(bestSlot) == tostring(classData.equiped) then return false end
    xDTaraZ.Util.Remote("Class", "ChangeEquipedIndexRE"):FireServer(tostring(bestSlot))
    return true
end

---@return number  rarity level, 0 when unknown
function xDTaraZ.Race.RarityLevel(rarity)
    local ok, level = pcall(xDTaraZ.GameLib.Api(GameConfig.Rarity.Helper).GetRarityLevel, rarity)
    return ok and tonumber(level) or 0
end

function xDTaraZ.Race.Level(classId)
    local info = classId and xDTaraZ.GameLib.Need(GameConfig.Class.Config)[classId]
    return info and xDTaraZ.Race.RarityLevel(info.Rarity) or 0
end

---@return string[], table  "Mythic+" style labels, label -> level
function xDTaraZ.Race.RarityChoices()
    local seen, levels = {}, {}
    for _, info in pairs(xDTaraZ.GameLib.Need(GameConfig.Class.Config)) do
        if seen[info.Rarity] then continue end
        seen[info.Rarity] = true
        table.insert(levels, { info.Rarity, xDTaraZ.Race.RarityLevel(info.Rarity) })
    end
    table.sort(levels, function(a, b) return a[2] < b[2] end)
    local labels, byLabel = { "Off" }, {}
    for _, pair in ipairs(levels) do
        local label = pair[1] .. "+"
        table.insert(labels, label)
        byLabel[label] = pair[2]
    end
    return labels, byLabel
end

---@return number  star level the account has on this race, 0 if never rolled
function xDTaraZ.Race.Stars(classId)
    local record = xDTaraZ.GameLib.Need(ReplicatedStorage.LocalData.ClassData).GetData().recored
    local entry = record and record[classId]
    return entry and tonumber(entry.Level) or 0
end

function xDTaraZ.Race.IsGoal(classId)
    if not classId then return false end
    local wanted = State.Opt.RaceTargets[classId]
        or (State.Opt.RaceMinLevel ~= nil and xDTaraZ.Race.Level(classId) >= State.Opt.RaceMinLevel)
    return wanted and xDTaraZ.Race.Stars(classId) >= (State.Opt.RaceStar or 0)
end

---@return string?, string?  slot to roll, or nil + why not
function xDTaraZ.Race.PickSlot(classData)
    local slot = State.Opt.RaceSlot == "Equipped" and tostring(classData.equiped) or State.Opt.RaceSlot:match("%d+")
    if not (slot and classData.have[slot]) then return nil, "that slot is not unlocked" end
    if classData.lock and classData.lock[slot] then return nil, "that slot is locked" end
    return slot
end

---Mutes the game's roll cutscene so rolls run in the background.
function xDTaraZ.Race.MuteAnim(muted)
    if not xDTaraZ.Compat.Caps.Connections then return end
    local event = xDTaraZ.Util.Remote("Class", "ShowLuckResultRE").OnClientEvent
    for _, conn in ipairs(getconnections(event)) do
        if muted then conn:Disable() else conn:Enable() end
    end
end

---@return boolean  true when rolls are available
function xDTaraZ.Race.EnsureRolls(classStore)
    if (classStore.GetData().luckTimes or 0) > 0 then return true end
    if not State.Opt.RaceRefill then return false end
    xDTaraZ.Bonus.Spawn("Race", Config.RaceRefill)
    local deadline = os.clock() + Config.RaceResultWait * 2
    repeat task.wait(0.1) until (classStore.GetData().luckTimes or 0) > 0 or os.clock() > deadline
    return (classStore.GetData().luckTimes or 0) > 0
end

---@return string, string?  got / empty / blocked / stopped, plus detail
function xDTaraZ.Race.RollUntil()
    local classStore = xDTaraZ.GameLib.Need(ReplicatedStorage.LocalData.ClassData)
    local roll = xDTaraZ.Util.Remote("Class", "LuckOnceRE")
    local protectLevel = xDTaraZ.Race.RarityLevel(Config.RaceProtectRarity)
    State.RaceRolls = 0
    while State.Alive and State.Opt.AutoRace do
        local classData = classStore.GetData()
        local slot, why = xDTaraZ.Race.PickSlot(classData)
        if not slot then return "blocked", why end

        local current = classData.have[slot]
        if xDTaraZ.Race.IsGoal(current) then
            if State.Opt.RaceLock then xDTaraZ.Util.Remote("Class", "SetIndexLockRE"):FireServer(slot) end
            return "got", current
        end
        if State.Opt.RaceProtect and xDTaraZ.Race.Level(current) >= protectLevel then
            return "blocked", "this slot holds a Mythic+ race"
        end
        if not xDTaraZ.Race.EnsureRolls(classStore) then return "empty" end

        roll:FireServer(slot)
        State.RaceRolls += 1
        local deadline = os.clock() + Config.RaceResultWait
        repeat task.wait() until classStore.GetData().have[slot] ~= current or os.clock() > deadline
        task.wait(Config.RaceRollDelay)
    end
    return "stopped"
end

function xDTaraZ.Movement.Humanoid()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end

function xDTaraZ.Movement.Apply()
    local hum = xDTaraZ.Movement.Humanoid()
    if not hum then return end
    hum.WalkSpeed = State.Opt.SpeedOn and State.Opt.WalkSpeed or (LocalPlayer:GetAttribute("OriWalkSpeed") or 22)
end

function xDTaraZ.Movement.Bind()
    table.insert(State.Conns, UserInputService.JumpRequest:Connect(function()
        local hum = xDTaraZ.Movement.Humanoid()
        if State.Opt.InfJump and hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end))
    table.insert(State.Conns, LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        xDTaraZ.Movement.Apply()
    end))
end

function xDTaraZ.Session.SetLowGraphics(enabled)
    RunService:Set3dRenderingEnabled(not enabled)
end

function xDTaraZ.Session.Rejoin()
    local queue = queue_on_teleport or queueonteleport
    if queue then queue(Config.ReloadSource) end
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

---@return boolean  false when the server list was refused
function xDTaraZ.Session.HopSmallest()
    local body = xDTaraZ.Util.HttpGet(("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId))
    local ok, list = pcall(HttpService.JSONDecode, HttpService, body or "")
    local best
    for _, server in ipairs(ok and type(list) == "table" and type(list.data) == "table" and list.data or {}) do
        if server.id == game.JobId or server.playing >= server.maxPlayers then continue end
        if not best or server.playing < best.playing then best = server end
    end
    if not best then return false end
    local queue = queue_on_teleport or queueonteleport
    if queue then queue(Config.ReloadSource) end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, best.id, LocalPlayer)
    return true
end

function xDTaraZ.Session.SavePosition()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    State.SavedSpot = root and root.CFrame
    return State.SavedSpot ~= nil
end

function xDTaraZ.Session.ReturnPosition()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not (root and State.SavedSpot) then return false end
    root.CFrame = State.SavedSpot
    return true
end

function xDTaraZ.Boss.HopFlag(enabled)
    local flag = Config.SaveFolder .. "/" .. Config.BossHopFlag
    pcall(function()
        if enabled then
            if not isfolder(Config.SaveFolder) then makefolder(Config.SaveFolder) end
            writefile(flag, tostring(os.time()))
        elseif isfile(flag) then
            delfile(flag)
        end
    end)
end

---@return number?  seconds since the last hop, nil when no hop is pending
function xDTaraZ.Boss.SinceLastHop()
    local ok, stamp = pcall(readfile, Config.SaveFolder .. "/" .. Config.BossHopFlag)
    if not ok or not tonumber(stamp) then return nil end
    return os.time() - tonumber(stamp)
end

---@return boolean  true only right after a hop, so a fresh launch never starts hopping by itself
function xDTaraZ.Boss.HopWanted()
    local since = xDTaraZ.Boss.SinceLastHop()
    return since ~= nil and since < Config.BossHopResume
end

---@return string[], number  unvisited servers from the saved list, and when it was fetched
function xDTaraZ.Boss.LoadServers()
    local ok, text = pcall(readfile, Config.SaveFolder .. "/" .. Config.BossHopServers)
    if not ok then return {}, 0 end
    local decoded
    ok, decoded = pcall(HttpService.JSONDecode, HttpService, text)
    if not ok or type(decoded) ~= "table" or type(decoded.ids) ~= "table" then return {}, 0 end
    local fetchedAt = tonumber(decoded.at) or 0
    if os.time() - fetchedAt > Config.HopListTtl then return {}, 0 end
    return decoded.ids, fetchedAt
end

---@param ids string[]    servers still unvisited
---@param fetchedAt number  when the list came from the API
function xDTaraZ.Boss.SaveServers(ids, fetchedAt)
    pcall(function()
        if not isfolder(Config.SaveFolder) then makefolder(Config.SaveFolder) end
        writefile(Config.SaveFolder .. "/" .. Config.BossHopServers, HttpService:JSONEncode({ at = fetchedAt, ids = ids }))
    end)
end

---@return string[]  public servers with room; empty while the API refuses (waits 2x longer after each refusal)
function xDTaraZ.Boss.FetchServers()
    if os.clock() < State.HopBlockedUntil then return {} end
    local body = xDTaraZ.Util.HttpGet(("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId))
    local ok, list = pcall(HttpService.JSONDecode, HttpService, body or "")
    local ids = {}
    for _, server in ipairs(ok and type(list) == "table" and type(list.data) == "table" and list.data or {}) do
        if server.id ~= game.JobId and server.playing < server.maxPlayers then table.insert(ids, server.id) end
    end
    if #ids > 0 then
        State.HopFails, State.HopBackoff = 0, nil
        return ids
    end
    State.HopFails += 1
    State.HopBackoff = math.min((State.HopBackoff or Config.HopBackoffStart / 2) * 2, Config.HopBackoffMax)
    State.HopBlockedUntil = os.clock() + State.HopBackoff
    warn("[LootToForge] server list refused, retry in", State.HopBackoff, "s, fail", State.HopFails)
    return {}
end

---@return string?  a public server with room, not this one
function xDTaraZ.Boss.PickServer()
    local ids, fetchedAt = xDTaraZ.Boss.LoadServers()
    if #ids == 0 then
        ids, fetchedAt = xDTaraZ.Boss.FetchServers(), os.time()
    end
    while #ids > 0 do
        local serverId = table.remove(ids, math.random(#ids))
        if serverId ~= game.JobId then
            xDTaraZ.Boss.SaveServers(ids, fetchedAt)
            return serverId
        end
    end
    xDTaraZ.Boss.SaveServers(ids, fetchedAt)
    return nil
end

function xDTaraZ.Boss.Hop()
    local serverId = xDTaraZ.Boss.PickServer()
    if not serverId then return end
    State.BossHopping = os.clock()
    xDTaraZ.Boss.HopFlag(true)
    local queue = queue_on_teleport or queueonteleport
    if queue and not State.HopQueued then
        queue(Config.ReloadSource)
        State.HopQueued = true
    end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, LocalPlayer)
end

---@return boolean  true when this server is worth staying in: boss up, boss about to spawn, or still collecting
function xDTaraZ.Boss.WorthStaying()
    if State.BossLooting and os.clock() - State.BossLooting < Config.BossLootTimeout then return true end
    local boss = workspace:GetAttribute("CurrentWorldBoss")
    if boss and not State.BossDone then return true end
    if State.BossDone then return os.clock() - State.BossDone < Config.BossHopAfter end
    local nextTick, serverTime = workspace:GetAttribute("NextWorldBossTick"), workspace:GetAttribute("ServerTime")
    if not nextTick or not serverTime then return true end
    return nextTick - serverTime <= State.Opt.BossWaitMinutes * 60
end

function xDTaraZ.Boss.HopGiveUp()
    State.Opt.BossHop = false
    xDTaraZ.Boss.HopFlag(false)
    table.insert(State.Halted, { "BossHop", "no server list from Roblox, try again later" })
end

function xDTaraZ.Boss.HopStep()
    if State.BossHopping then
        if os.clock() - State.BossHopping < Config.HopStall then return end
        State.BossHopping = false
    end
    if xDTaraZ.Boss.WorthStaying() then return end
    if (xDTaraZ.Boss.SinceLastHop() or Config.HopGap) < Config.HopGap then return end
    if State.HopFails >= Config.HopGiveUp then
        xDTaraZ.Boss.HopGiveUp()
        return
    end
    xDTaraZ.Boss.Hop()
end

---@return table?  { target, tries } while a search is running
function xDTaraZ.Session.OldSearch()
    local ok, text = pcall(readfile, Config.SaveFolder .. "/" .. Config.OldServerFlag)
    if not ok then return nil end
    local decoded
    ok, decoded = pcall(HttpService.JSONDecode, HttpService, text)
    return ok and type(decoded) == "table" and tonumber(decoded.target) and decoded or nil
end

function xDTaraZ.Session.SaveOldSearch(search)
    local path = Config.SaveFolder .. "/" .. Config.OldServerFlag
    pcall(function()
        if not search then
            if isfile(path) then delfile(path) end
            return
        end
        if not isfolder(Config.SaveFolder) then makefolder(Config.SaveFolder) end
        writefile(path, HttpService:JSONEncode(search))
    end)
end

---@param target number?  place version to look for, nil to continue a saved search
---@return string         found / searching / gaveup / nolist
function xDTaraZ.Session.FindOldServer(target)
    local search = target and { target = target, tries = 0, known = xDTaraZ.Session.KnownOld() } or xDTaraZ.Session.OldSearch()
    if not search then return "gaveup" end
    if game.PlaceVersion <= search.target then
        xDTaraZ.Session.SaveOldSearch(nil)
        xDTaraZ.Session.RememberOld(game.JobId)
        return "found"
    end
    if search.tries >= Config.OldServerTries then
        xDTaraZ.Session.SaveOldSearch(nil)
        return "gaveup"
    end
    local serverId
    search.known = type(search.known) == "table" and search.known or {}
    repeat serverId = table.remove(search.known, 1) until serverId ~= game.JobId
    serverId = serverId or xDTaraZ.Boss.PickServer()
    if not serverId then return "nolist" end
    search.tries += 1
    xDTaraZ.Session.SaveOldSearch(search)
    local queue = queue_on_teleport or queueonteleport
    if queue and not State.HopQueued then
        queue(Config.ReloadSource)
        State.HopQueued = true
    end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, LocalPlayer)
    return "searching"
end

---@return string[]  old-version servers found before, newest first
function xDTaraZ.Session.KnownOld()
    local ok, text = pcall(readfile, Config.SaveFolder .. "/" .. Config.OldServerKnown)
    if not ok then return {} end
    local decoded
    ok, decoded = pcall(HttpService.JSONDecode, HttpService, text)
    return ok and type(decoded) == "table" and decoded or {}
end

function xDTaraZ.Session.RememberOld(jobId)
    local known = { jobId }
    for _, id in ipairs(xDTaraZ.Session.KnownOld()) do
        if id ~= jobId and #known < Config.OldServerKeep then table.insert(known, id) end
    end
    pcall(function()
        if not isfolder(Config.SaveFolder) then makefolder(Config.SaveFolder) end
        writefile(Config.SaveFolder .. "/" .. Config.OldServerKnown, HttpService:JSONEncode(known))
    end)
end

function xDTaraZ.Session.Bind()
    table.insert(State.Conns, TeleportService.TeleportInitFailed:Connect(function()
        if xDTaraZ.Session.OldSearch() then
            task.delay(1, xDTaraZ.Util.Try, xDTaraZ.Session.FindOldServer)
            return
        end
        if not State.BossHopping then return end
        State.BossHopping = false
        task.delay(1, xDTaraZ.Util.Try, xDTaraZ.Boss.HopStep)
    end))
    table.insert(State.Conns, LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end))
    table.insert(State.Conns, GuiService.ErrorMessageChanged:Connect(function(msg)
        if State.Opt.AutoRejoin and msg ~= "" and not State.Rejoining then
            State.Rejoining = true
            task.delay(Config.RejoinDelay, xDTaraZ.Session.Rejoin)
        end
    end))
end

xDTaraZ.Scheduler.Jobs = {
    { key = "MaxGear", every = 0, run = function() xDTaraZ.Gear.MaxStep() end },
    { key = "CollectOre", every = 0, run = function() xDTaraZ.Stage.Collect(State.Opt.Stage or xDTaraZ.Stage.Best(), State.Opt.CollectRarities) end },
    { key = "AutoForge", every = 0, run = function() xDTaraZ.Forge.Step() end },
    { key = "AutoEquip", every = Config.EquipInterval, run = function() xDTaraZ.Gear.EquipBest() end },
    { key = "AutoSell", every = Config.SellInterval, run = function() xDTaraZ.Sell.Run(xDTaraZ.Data.Get()) end },
    { key = "AutoTrain", every = 1, run = function() xDTaraZ.Level.TrainStep() end },
    { key = "AutoRebirth", every = Config.RebirthInterval, run = function() xDTaraZ.Level.RebirthStep() end },
    { key = "AutoUpgrade", every = Config.UpgradeInterval, run = function() xDTaraZ.Upgrade.BuySelected() end },
    { key = "AutoTower", every = 0, run = function() xDTaraZ.Tower.FarmStep() end },
    { key = "AutoWorldBoss", every = Config.BossInterval, run = function() xDTaraZ.Boss.Step() end },
    { key = "BossHop", every = Config.BossHopInterval, run = function() xDTaraZ.Boss.HopStep() end },
    { key = "AutoClaim", every = Config.ClaimInterval, run = function() xDTaraZ.Claim.All() end },
    { key = "AutoSeason", every = Config.SeasonInterval, run = function() xDTaraZ.Season.Step() end },
    { key = "AutoTokenShop", every = Config.TokenShopInterval, run = function() xDTaraZ.TokenShop.BuyAll() end },
    { key = "AutoBestRace", every = 10, run = function() xDTaraZ.Race.EquipBest() end },
    { key = "AutoIndex", every = Config.IndexInterval, run = function() xDTaraZ.Util.Exclusive("Index", xDTaraZ.Index.HuntAll) end },
}

---Runs one round of a feature; one that keeps failing for Config.FailWindow seconds is switched off and queued for the UI to report.
---@param key string  State.Opt flag of the feature
function xDTaraZ.Scheduler.Run(key, fn)
    local ok, err = pcall(fn)
    local failures = State.Failures
    if ok then
        failures[key] = nil
        return
    end

    local streak = failures[key]
    if not streak then
        streak = { count = 0, since = os.clock() }
        failures[key] = streak
        xDTaraZ.Util.WarnJob(key, err)
    end
    streak.count += 1
    if streak.count < Config.MaxFailures or os.clock() - streak.since < Config.FailWindow then return end

    failures[key] = nil
    State.Opt[key] = false
    local reason = tostring(err):match("[^\n]*")
    warn("[LootToForge]", key, "stopped:", reason)
    table.insert(State.Halted, { key, reason })
end

function xDTaraZ.Scheduler.Step()
    if State.Lock then return end
    local now = os.clock()
    for _, job in ipairs(xDTaraZ.Scheduler.Jobs) do
        if not State.Opt[job.key] or State.Lock then continue end
        if now - (State.LastRun[job.key] or 0) < job.every then continue end
        State.LastRun[job.key] = now
        xDTaraZ.Scheduler.Run(job.key, job.run)
    end
end

function xDTaraZ.Scheduler.Start()
    task.spawn(function()
        while State.Alive do
            if not State.Busy then
                State.Busy = true
                xDTaraZ.Util.Try(xDTaraZ.Scheduler.Step)
                State.Busy = false
            end
            task.wait(Config.TickDelay)
        end
    end)
end

function xDTaraZ.Scheduler.Boot()
    for _, bind in ipairs({ xDTaraZ.Movement.Bind, xDTaraZ.Level.Bind, xDTaraZ.SuperLoot.Bind, xDTaraZ.Boss.Bind, xDTaraZ.Session.Bind }) do
        xDTaraZ.Util.Try(bind)
    end
    xDTaraZ.Scheduler.Start()
end

function xDTaraZ.Scheduler.Stop()
    State.Alive = false
    for _, conn in ipairs(State.Conns) do
        conn:Disconnect()
    end
    table.clear(State.Conns)
    if State.Opt.AutoTrain then
        State.Opt.AutoTrain = false
        task.spawn(xDTaraZ.Util.Try, xDTaraZ.Level.SetTraining, false)
    end
    if State.Opt.SpeedOn then
        State.Opt.SpeedOn = false
        xDTaraZ.Movement.Apply()
    end
    if State.Opt.LowGraphics then
        xDTaraZ.Session.SetLowGraphics(false)
    end
    xDTaraZ.Util.Try(xDTaraZ.Tower.Exit)
    if LocalPlayer:GetAttribute("IntoFight") == "WorldBoss" then xDTaraZ.Util.Try(xDTaraZ.Boss.Leave) end
    xDTaraZ.Guard.Stop()
end

local function BuildInterface()
    local Library = xDTaraZ.Util.LoadLibrary()
    if not Library then return end
    xDTaraZ.Compat = Library.Compat or { Caps = {}, Block = function() end, NeedCap = function() end }
    local Options = Library.Options
    pcall(MarioBanner.Step, "UI library")
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt
    local featureNames = {}
    local uiQueue = {}
    local statusLabel, gearLabel, taskLabel

    ---@return table, table  empty tables when the game data can't be read
    local function Source(fn)
        local ok, first, second = pcall(fn)
        if not ok then
            warn("[LootToForge] menu data:", first)
            return {}, {}
        end
        return first or {}, second or {}
    end

    local rarityNames = Source(xDTaraZ.Util.RarityNames)

    local function Later(fn, ...)
        local args = table.pack(...)
        table.insert(uiQueue, function()
            fn(table.unpack(args, 1, args.n))
        end)
    end

    local function Notify(text, kind, seconds)
        Later(Library.Notify, Library, "Loot To Forge", text, seconds or 4, kind or "Info")
    end

    local function TurnOff(key)
        local toggle = Options[key]
        if toggle and toggle.Value then toggle:SetValue(false) end
    end

    ---@param pickFirst boolean?  also select the first entry
    local function SetList(idx, values, pickFirst)
        local dropdown = Options[idx]
        if not dropdown then return end
        dropdown:SetValues(values)
        if pickFirst and values[1] then
            dropdown:SetValue(values[1])
        elseif dropdown.Value ~= opt[idx] then
            dropdown:SetValue(dropdown.Value)
        end
    end

    ---@param module Instance  game module the feature can't run without
    local function NeedModule(option, module)
        if xDTaraZ.GameLib.Require(module) then return end
        xDTaraZ.Compat.Block(option, T("Not available on this executor", "ใช้กับ executor นี้ไม่ได้"))
    end

    local function BlockMissing()
        for idx, paths in pairs(xDTaraZ.GameLib.Missing()) do
            warn("[LootToForge]", idx, "blocked, missing:", table.concat(paths, ", "))
            if Options[idx] then xDTaraZ.Compat.Block(Options[idx], T("Not available after a game update", "ใช้ไม่ได้หลังเกมอัปเดต")) end
        end
    end

    local function Pump()
        for _, halt in ipairs(State.Halted) do
            TurnOff(halt[1])
            Notify(("%s stopped: %s"):format(featureNames[halt[1]] or halt[1], halt[2]), "Warning")
        end
        table.clear(State.Halted)

        local jobs = uiQueue
        uiQueue = {}
        for _, job in ipairs(jobs) do
            xDTaraZ.Util.Try(job)
        end
    end

    local function Action(action)
        return function()
            task.defer(xDTaraZ.Util.Try, action)
        end
    end

    ---@param name string  lock name, also the busy message
    local function LongAction(name, action, done)
        return function()
            task.defer(function()
                if State.Lock then return Notify("Busy: " .. State.Lock, "Warning") end
                Notify(name .. "...")
                local outcome
                xDTaraZ.Util.Exclusive(name, function() outcome = action() end)
                if done then Notify(done(outcome), "Success") end
            end)
        end
    end

    local function Toggle(group, key, text, description, onChange)
        featureNames[key] = text.EN
        return group:AddToggle(key, {
            Text = text,
            Description = description,
            Default = opt[key],
            Callback = function(value)
                opt[key] = value
                if onChange then
                    onChange(value)
                end
            end,
        })
    end

    local Feature = Toggle

    local function HotkeyFeature(group, key, text, description, onChange)
        return Toggle(group, key, text, description, onChange):AddKeyPicker(key .. "Key", { Default = "None", Mode = "Toggle" })
    end

    local function Check(group, key, text)
        return group:AddCheckbox(key, {
            Text = text,
            Default = opt[key],
            Callback = function(value)
                opt[key] = value
            end,
        })
    end

    local function MultiSelect(group, key, text, description, values)
        opt[key] = xDTaraZ.Util.AllSet(values)
        return group:AddDropdown(key, {
            Text = text,
            Description = description,
            Values = values,
            Multi = true,
            Default = values,
            Searchable = #values > 8,
            Callback = function(selected)
                opt[key] = selected
            end,
        })
    end

    ---@param source function  returns the dropdown values, read safely
    local function Pick(group, key, text, description, source, noSave)
        local values = Source(source)
        opt[key] = values[1]
        return group:AddDropdown(key, {
            Text = text,
            Description = description,
            Values = values,
            Default = 1,
            Searchable = #values > 8,
            NoSave = noSave,
            Callback = function(value)
                opt[key] = value
            end,
        })
    end

    local function NumberInput(group, key, text, description, minimum)
        return group:AddInput(key, {
            Text = text,
            Description = description,
            Default = tostring(opt[key]),
            Numeric = true,
            Finished = true,
            Callback = function(value)
                opt[key] = math.max(minimum or 0, math.floor(tonumber(value) or opt[key]))
            end,
        })
    end

    ---@param idOf function  dropdown label -> game item id
    local function Decorate(idx, idOf)
        task.defer(function()
            local dropdown = Options[idx]
            if not (dropdown and dropdown.SetImages) then return end
            local ok, images, colors = pcall(xDTaraZ.Look.Maps, dropdown.Values, idOf)
            if not ok then return warn("[LootToForge] item images:", images) end
            Later(function()
                if Options[idx] then Options[idx]:SetImages(images, colors) end
            end)
        end)
    end

    local function OreId(label)
        return State.OreLabels and State.OreLabels[label]
    end

    local function RefreshButton(idx, list)
        return { Text = T("Refresh", "รีเฟรช"), Func = function()
            task.defer(function()
                Later(SetList, idx, (Source(list)))
                if State.Decorators and State.Decorators[idx] then Later(Decorate, idx, State.Decorators[idx]) end
            end)
        end }
    end

    local function BuildMain(tab)
        local statusBox = tab:AddLeftGroupbox(T("Status", "สถานะ"))
        statusLabel = statusBox:AddLabel("Loading...")
        gearLabel = statusBox:AddLabel("Equipped: -")
        taskLabel = statusBox:AddLabel("Working on: Idle")

        local kaitunBox = tab:AddLeftGroupbox(T("Kaitun", "ไก่ตัน"))
        kaitunBox:AddToggle("Kaitun", {
            Text = T("Kaitun (All-in-one)", "ไก่ตัน (ทำทุกอย่าง)"),
            Description = T("Best gear, money, level, rewards and bosses all at once", "ของดีสุด เงิน เลเวล รางวัล และบอส ทำพร้อมกันทั้งหมด"),
            NoSave = true,
            Callback = function(value)
                for _, key in ipairs(Config.KaitunToggles) do
                    if Options[key] then Options[key]:SetValue(value) end
                end
            end,
        })

        local discordBox = tab:AddRightGroupbox("Discord", "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            local copy = setclipboard or toclipboard
            if copy then copy(Config.Discord) end
            Notify(copy and "Discord link copied" or Config.Discord)
        end })

        local logBox = tab:AddRightGroupbox(T("Update Log", "อัปเดตล่าสุด"), "bell")
        for i = 1, math.min(2, #Config.UpdateLog) do
            local entry = Config.UpdateLog[i]
            logBox:AddParagraph({ Title = entry[1], Content = entry[2] })
        end

        local rewardBox = tab:AddLeftGroupbox(T("Rewards", "รางวัล"))
        Feature(rewardBox, "AutoClaim", T("Auto Claim", "รับรางวัลอัตโนมัติ"), T("Claims every free reward, including index", "รับรางวัลฟรีทุกอย่าง รวมสมุดสะสม"))
        rewardBox:AddButton({ Text = T("Claim Now", "รับเดี๋ยวนี้"), Style = "Success", Func = Action(xDTaraZ.Claim.All) })
        rewardBox:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Style = "Primary", Func = Action(function()
            Notify(xDTaraZ.Claim.AllCodes(), "Success", 6)
        end) })
    end

    local function BuildGear(tab)
        local gearBox = tab:AddLeftGroupbox(T("Max Gear", "อุปกรณ์สูงสุด"))
        Feature(gearBox, "MaxGear", T("Max Gear", "อุปกรณ์สูงสุด"),
            T("Best gear and runes, enhanced to your target. Finds anything missing by itself", "ของดีสุด รูนดีสุด ตีบวกถึงเป้า ขาดอะไรหาเองหมด"),
            function()
                State.GearForged = false
            end)
        Check(gearBox, "GearForge", T("Forge best gear", "หลอมของดีสุด"))
        Check(gearBox, "GearEnchant", T("Best runes", "ใส่รูนดีสุด"))
        Check(gearBox, "GearEnhance", T("Enhance", "ตีบวก"))
        gearBox:AddSlider("EnhanceTarget", {
            Text = T("Enhance Target", "ตีบวกถึง"),
            Description = T("Above +10 the success rate gets very low and can take a long time", "เกิน +10 โอกาสสำเร็จต่ำมาก อาจใช้เวลานาน"),
            Min = 5, Max = 20, Default = opt.EnhanceTarget, Rounding = 0, Prefix = "+",
            Callback = function(value)
                opt.EnhanceTarget = value
            end,
        })
        local runes = xDTaraZ.Gear.RuneOrder()
        opt.EnchantPriority = table.clone(runes)
        gearBox:AddDropdown("EnchantPriority", {
            Text = T("Runes To Use", "รูนที่ใช้"),
            Description = T("Stronger runes go in first", "รูนที่แรงกว่าใส่ก่อน"),
            Values = runes,
            Multi = true,
            Default = runes,
            Searchable = #runes > 8,
            Callback = function(selected)
                local order = {}
                for _, stoneId in ipairs(runes) do
                    if selected[stoneId] then order[#order + 1] = stoneId end
                end
                if #order == 0 then Notify("No rune selected, using all runes", "Warning") end
                opt.EnchantPriority = order
            end,
        })

        local equipBox = tab:AddRightGroupbox(T("Equip", "ใส่ของ"))
        Feature(equipBox, "AutoEquip", T("Auto Equip Best", "ใส่ของดีสุดอัตโนมัติ"), T("Always wears your strongest weapon, armor and hat, counting enhance level", "ใส่อาวุธ เกราะ และหมวกที่แรงที่สุดเสมอ นับระดับตีบวกด้วย"))
        equipBox:AddButton({ Text = T("Equip Best Now", "ใส่ของดีสุดเดี๋ยวนี้"), Func = function()
            task.defer(function()
                local changed = xDTaraZ.Gear.EquipBest()
                Notify(changed > 0 and ("Equipped %d better item(s)"):format(changed) or "Already wearing your best gear")
            end)
        end })

        equipBox:AddDivider()
        equipBox:AddDropdown("EnhanceSlot", {
            Text = T("Enhance Slot", "ช่องที่ตีบวก"),
            Values = Config.GearTypes,
            Default = opt.EnhanceSlot,
            Callback = function(value)
                opt.EnhanceSlot = value or opt.EnhanceSlot
            end,
        })
        equipBox:AddButton({ Text = T("Enhance To Target", "ตีบวกถึงเป้า"), Style = "Primary", Func = LongAction("Enhance", function()
            return xDTaraZ.Gear.EnhanceSlot(opt.EnhanceSlot, opt.EnhanceTarget)
        end, function(level) return level and ("%s is +%d"):format(opt.EnhanceSlot, level) or "Nothing equipped there" end) })
    end

    local function BuildFarm(tab)
        local stageBox = tab:AddLeftGroupbox(T("Stage", "ด่าน"))
        Pick(stageBox, "Stage", T("Stage", "ด่าน"), T("Any stage, no unlock needed", "เลือกด่านไหนก็ได้ ไม่ต้องปลดล็อก"), xDTaraZ.Stage.List)
        Feature(stageBox, "CollectOre", T("Auto Collect Ore", "เก็บแร่อัตโนมัติ"), T("Clears the stage and collects its ores nonstop", "เคลียร์ด่านแล้วเก็บแร่ไม่หยุด"))
        MultiSelect(stageBox, "CollectRarities", T("Ore Rarity Filter", "กรอง rarity แร่"), T("Only collect these rarities", "เก็บเฉพาะ rarity ที่เลือก"), rarityNames)

        local combatBox = tab:AddLeftGroupbox(T("Combat", "ต่อสู้"))
        local killAura = Feature(combatBox, "KillAura", T("Kill Aura", "ฆ่ารอบตัว"), T("Every monster in your fight dies instantly", "มอนสเตอร์ทุกตัวในการต่อสู้ตายทันที"), function(value)
            if value then xDTaraZ.Combat.Start() end
        end)
        NeedModule(killAura, ReplicatedStorage.Utils.CommunicationUtils)
        Feature(combatBox, "SuperLootAura", T("Kill Ore Boss", "ฆ่าบอสแร่"), T("Kills rare ore bosses the moment they spawn", "ฆ่าบอสแร่หายากทันทีที่เกิด"), function(value)
            if value then xDTaraZ.SuperLoot.KillExisting() end
        end)
        combatBox:AddButton({ Text = T("Exit Fight Now", "ออกจากการต่อสู้เดี๋ยวนี้"), Style = "Warning", Func = Action(xDTaraZ.Stage.ExitFight) })

        local bossBox = tab:AddRightGroupbox(T("World Boss", "บอสโลก"))
        Feature(bossBox, "AutoWorldBoss", T("Auto World Boss", "บอสโลกอัตโนมัติ"), T("Joins every world boss and kills it", "เข้าบอสโลกทุกรอบแล้วฆ่า"), function(value)
            if not value and LocalPlayer:GetAttribute("IntoFight") == "WorldBoss" then task.spawn(xDTaraZ.Util.Try, xDTaraZ.Boss.Leave) end
        end)
        Check(bossBox, "BossCards", T("Auto Take Reward Card", "เปิดการ์ดรางวัลอัตโนมัติ"))
        Feature(bossBox, "BossHop", T("Boss Server Hop", "ย้ายเซิร์ฟหาบอส"), T("Hops to servers where the boss is up or about to spawn, kills it, then moves on", "ย้ายไปเซิร์ฟที่บอสเกิดอยู่หรือใกล้เกิด ฆ่าแล้วย้ายต่อ"), function(value)
            xDTaraZ.Boss.HopFlag(value)
            if value and Options.AutoWorldBoss and not Options.AutoWorldBoss.Value then Options.AutoWorldBoss:SetValue(true) end
        end)
        bossBox:AddSlider("BossWaitMinutes", {
            Text = T("Wait If Boss Within", "รอถ้าบอสจะเกิดภายใน"),
            Description = T("Stays on a server when the boss spawns this soon", "อยู่เซิร์ฟเดิมถ้าบอสจะเกิดภายในเวลานี้"),
            Min = 0.5, Max = 10, Default = opt.BossWaitMinutes, Rounding = 1, Suffix = " min",
            Callback = function(value)
                opt.BossWaitMinutes = tonumber(value) or opt.BossWaitMinutes
            end,
        })

        local indexBox = tab:AddRightGroupbox(T("Index", "สมุดสะสม"))
        MultiSelect(indexBox, "IndexTypes", T("Index Types", "ประเภทที่จะเก็บ"), nil, Config.GearTypes)
        Pick(indexBox, "MissingItem", T("Missing Item", "ของที่ยังไม่มี"), T("Chance shown is per forge with the best ore", "เปอร์เซ็นต์ = โอกาสต่อการหลอมหนึ่งครั้งด้วยแร่ที่ดีที่สุด"), function()
            return { "..." }
        end, true)
        task.defer(function()
            local ok, labels = pcall(xDTaraZ.Index.Choices)
            if ok then
                Later(SetList, "MissingItem", labels, true)
            else
                warn("[LootToForge] index list:", labels)
            end
        end)
        indexBox:AddButton({ Text = T("Get Selected", "หาชิ้นนี้"), Style = "Primary", Func = LongAction("Index", function()
            local gear = State.MissingLabels[opt.MissingItem]
            return gear and xDTaraZ.Index.Hunt(gear)
        end, function(got)
            Later(SetList, "MissingItem", (Source(xDTaraZ.Index.Choices)))
            return got and "Got it!" or "Not found this time, press again"
        end) }):AddButton(RefreshButton("MissingItem", xDTaraZ.Index.Choices))
        Feature(indexBox, "AutoIndex", T("Auto Complete Index", "เก็บสมุดสะสมอัตโนมัติ"), T("Forges every missing weapon, armor and hat, then claims rewards", "หลอมอาวุธ เกราะ หมวกที่ยังไม่มีทุกชิ้น แล้วรับรางวัล"), nil, true)
        indexBox:AddButton({ Text = T("Collect All Ores", "เก็บแร่ทุกชนิด"), Func = LongAction("Ores", xDTaraZ.Index.CollectOres, function()
            local count, level = xDTaraZ.Index.Progress()
            return ("Index %d, level %d"):format(count, level)
        end) }):AddButton({ Text = T("Claim Rewards", "รับรางวัล"), Style = "Success", Func = Action(xDTaraZ.Index.ClaimAll) })
    end

    local function BuildForge(tab)
        local forgeBox = tab:AddLeftGroupbox(T("Forge", "หลอม"))
        local targetNames = {}
        for _, target in ipairs(Config.ForgeTargets) do
            targetNames[#targetNames + 1] = target.name
        end
        forgeBox:AddDropdown("ForgeTarget", {
            Text = T("Target Gear", "อุปกรณ์ที่จะหลอม"),
            Values = targetNames,
            Default = 1,
            Callback = function(value)
                opt.ForgeTarget = value or opt.ForgeTarget
            end,
        })
        Pick(forgeBox, "ForgeOre", T("Ore To Use", "แร่ที่ใช้หลอม"), T("Pick an ore and it never runs out", "เลือกแร่แล้วไม่มีวันหมด"), xDTaraZ.Ore.ForgeChoices, nil)
        Decorate("ForgeOre", OreId)
        Feature(forgeBox, "AutoForge", T("Auto Forge", "หลอมอัตโนมัติ"), T("Forges the target gear nonstop", "หลอมอุปกรณ์ที่เลือกไม่หยุด"))
        forgeBox:AddButton({ Text = T("Forge Now", "หลอมเดี๋ยวนี้"), Style = "Primary", Func = Action(xDTaraZ.Forge.Step) })
        forgeBox:AddSlider("ForgePerTick", {
            Text = T("Forges Per Round", "หลอมต่อรอบ"),
            Min = 1, Max = 50, Default = opt.ForgePerTick, Rounding = 0,
            Callback = function(value)
                opt.ForgePerTick = value
            end,
        })
        Check(forgeBox, "ForgeSellJunk", T("Sell worse gear right away", "ขายของที่แย่กว่าที่ใส่ทันที"))

        local oreUseBox = tab:AddRightGroupbox(T("Ore Usage", "การใช้แร่"))
        oreUseBox:AddLabel(T("Used when Ore To Use is Owned ores", "ใช้ตอนแร่ที่ใช้หลอม = Owned ores"))
        Toggle(oreUseBox, "BestOreFirst", T("Spend Best Ore First", "ใช้แร่ดีสุดก่อน"), T("Off = spend the weakest ore first", "ปิด = ใช้แร่ที่อ่อนที่สุดก่อน"))
        MultiSelect(oreUseBox, "ForgeRarities", T("Forge Ore Rarity", "rarity แร่ที่ใช้หลอม"), T("Only these ore rarities are used for forging", "ใช้แร่เฉพาะ rarity ที่เลือกในการหลอม"), rarityNames)
        NumberInput(oreUseBox, "KeepPerOre", T("Keep Per Ore", "เก็บแร่ไว้ชนิดละ"), T("Never forge below this amount of each ore", "ไม่หลอมจนแร่แต่ละชนิดต่ำกว่าจำนวนนี้"))
    end

    local function BuildSell(tab)
        local sellBox = tab:AddLeftGroupbox(T("Auto Sell", "ขายอัตโนมัติ"))
        Feature(sellBox, "AutoSell", T("Auto Sell", "ขายอัตโนมัติ"), T("Sells gear that matches your filters. Equipped gear is never sold", "ขายอุปกรณ์ที่ตรงตัวกรอง ของที่ใส่อยู่จะไม่ขาย"))
        sellBox:AddButton({ Text = T("Sell All Now", "ขายทั้งหมดเดี๋ยวนี้"), Style = "Primary", Func = Action(function()
            xDTaraZ.Sell.Run(xDTaraZ.Data.Get())
            Notify("Sold", "Coin")
        end) })

        local filterBox = tab:AddRightGroupbox(T("Filters", "ตัวกรอง"))
        MultiSelect(filterBox, "SellTypes", T("Sell Item Types", "ประเภทที่จะขาย"), nil, Config.GearTypes)
        MultiSelect(filterBox, "SellRarities", T("Sell Rarity Filter", "กรอง rarity ที่จะขาย"), T("Only sell these rarities", "ขายเฉพาะ rarity ที่เลือก"), rarityNames)
        NumberInput(filterBox, "KeepPerItem", T("Keep Per Item", "เก็บไว้ชิ้นละ"), T("Keeps this many of each item, highest enhance first", "เก็บแต่ละไอเทมไว้ตามจำนวนนี้ เลือกตัวตีบวกสูงสุดก่อน"))
    end

    local function BuildProgress(tab)
        local trainBox = tab:AddLeftGroupbox(T("Training", "ฝึก"))
        Feature(trainBox, "AutoTrain", T("Auto Train", "ฝึกอัตโนมัติ"), T("Trains at the best area nonstop and drinks your potions", "ฝึกโซนดีสุดไม่หยุด ใช้ยาให้เอง"), function(value)
            task.spawn(xDTaraZ.Util.Try, xDTaraZ.Level.SetTraining, value)
        end)
        local autoClick = Feature(trainBox, "AutoClick", T("Auto Click", "คลิกอัตโนมัติ"), T("Clicks to train as fast as the game allows", "คลิกฝึกเร็วสุดเท่าที่เกมยอม"), function(value)
            if value then xDTaraZ.Level.StartClicking() end
        end)
        NeedModule(autoClick, ReplicatedStorage.CTRL.TrainCTRL)
        Feature(trainBox, "AutoRebirth", T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"), T("Rebirths as soon as your level is high enough", "รีเบิร์ธทันทีเมื่อเลเวลถึง"))
        trainBox:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Func = Action(xDTaraZ.Level.Rebirth) })

        local upgradeBox = tab:AddRightGroupbox(T("Upgrades", "อัปเกรด"))
        MultiSelect(upgradeBox, "Upgrades", T("Upgrades To Buy", "อัปเกรดที่จะซื้อ"), nil, (Source(xDTaraZ.Upgrade.Names)))
        Feature(upgradeBox, "AutoUpgrade", T("Auto Buy Upgrades", "ซื้ออัปเกรดอัตโนมัติ"), T("Buys the selected upgrades whenever possible", "ซื้ออัปเกรดที่เลือกทุกครั้งที่ซื้อได้"))
        upgradeBox:AddButton({ Text = T("Buy Upgrade Now", "ซื้ออัปเกรดเดี๋ยวนี้"), Func = Action(xDTaraZ.Upgrade.BuySelected) })
    end

    local function BuildTower(tab)
        local towerBox = tab:AddLeftGroupbox(T("Tower", "หอคอย"))
        Feature(towerBox, "AutoTower", T("Auto Farm Tower", "ฟาร์มหอคอยอัตโนมัติ"), T("Top floor loot nonstop on one ticket: rare stones and season coins", "ของชั้นบนสุดไม่หยุดด้วยตั๋วใบเดียว ได้หินหายากและเหรียญซีซั่น"), function(value)
            task.defer(function()
                if not value then return xDTaraZ.Util.Try(xDTaraZ.Tower.Exit) end
                if not xDTaraZ.Tower.Enter() then Notify("No tower ticket", "Warning") end
            end)
        end)
        towerBox:AddButton({ Text = T("Exit Tower Now", "ออกจากหอคอยเดี๋ยวนี้"), Style = "Warning", Func = function()
            Options.AutoTower:SetValue(false)
            task.spawn(xDTaraZ.Util.Try, xDTaraZ.Tower.Exit)
        end })

        local seasonBox = tab:AddRightGroupbox(T("Season", "ซีซั่น"))
        local goodLabels, goodIds = Source(xDTaraZ.Season.Goods)
        local goodDefault = {}
        for label, goodId in pairs(goodIds) do
            if opt.SeasonGoods[goodId] then table.insert(goodDefault, label) end
        end
        Feature(seasonBox, "AutoSeason", T("Auto Season", "ซีซั่นอัตโนมัติ"), T("Daily ticket, pass rewards, spins and shop", "ตั๋วรายวัน รางวัลพาส สุ่ม และร้าน"))
        seasonBox:AddButton({ Text = T("Season Now", "ซีซั่นเดี๋ยวนี้"), Func = Action(xDTaraZ.Season.Step) })
        Check(seasonBox, "SeasonSpin", T("Spin every ticket", "สุ่มตั๋วทุกใบ"))
        seasonBox:AddDropdown("SeasonGoods", {
            Text = T("Shop Items To Buy", "ของในร้านที่จะซื้อ"),
            Values = goodLabels,
            Multi = true,
            Default = goodDefault,
            Searchable = #goodLabels > 8,
            Callback = function(selected)
                local wanted = {}
                for label, on in pairs(selected) do
                    if on and goodIds[label] then wanted[goodIds[label]] = true end
                end
                opt.SeasonGoods = wanted
            end,
        })
    end

    local function BuildSpawn(tab)
        local spawnBox = tab:AddLeftGroupbox(T("Spawn Items", "เสกของ"), nil, "OP")
        Pick(spawnBox, "SpawnItem", T("Item", "ของ"), T("Ores and runes. Runes need at least one owned", "แร่และรูน รูนต้องมีอย่างน้อย 1 ชิ้น"), xDTaraZ.Spawn.Choices, true)
        State.Decorators = { SpawnItem = function(label)
            local picked = State.SpawnLabels and State.SpawnLabels[label]
            return picked and picked.id
        end }
        Decorate("SpawnItem", State.Decorators.SpawnItem)
        NumberInput(spawnBox, "SpawnAmount", T("Amount", "จำนวน"), nil, 1)
        spawnBox:AddButton({ Text = T("Spawn", "เสก"), Style = "Primary", Func = function()
            local picked = State.SpawnLabels[opt.SpawnItem]
            if not picked then return Notify("Pick an item first", "Warning") end
            local label, amount = opt.SpawnItem, opt.SpawnAmount
            task.defer(function()
                local ok = xDTaraZ.Spawn.Give(picked.id, picked.kind, amount)
                Notify(ok and ("Added %s %s"):format(xDTaraZ.Util.Abbreviate(amount), label) or "You need at least one of this item first", ok and "Success" or "Warning")
            end)
        end }):AddButton(RefreshButton("SpawnItem", xDTaraZ.Spawn.Choices))
        spawnBox:AddButton({ Text = T("Dupe Whole Inventory", "ปั๊มของทั้งกระเป๋า"), Func = function()
            local amount = opt.SpawnAmount
            task.defer(function()
                local touched = xDTaraZ.Spawn.DupeAll(amount)
                Notify(("Added %s to %d stacks"):format(xDTaraZ.Util.Abbreviate(amount), touched), touched > 0 and "Success" or "Warning")
            end)
        end })

        local gearBox = tab:AddLeftGroupbox(T("Spawn Gear", "เสกอาวุธและชุด"), nil, "OP")
        local function LoadGearList(slot)
            task.defer(function()
                local ok, labels = pcall(xDTaraZ.Spawn.GearChoices, slot)
                if ok then
                    Later(SetList, "SpawnGear", labels, true)
                    Later(Decorate, "SpawnGear", function(label)
                        local gear = State.GearLabels and State.GearLabels[label]
                        return gear and gear.id
                    end)
                else
                    warn("[LootToForge] gear list:", labels)
                end
            end)
        end
        opt.GearSlot = Config.GearTypes[1]
        gearBox:AddDropdown("GearSlot", {
            Text = T("Type", "ประเภท"),
            Values = Config.GearTypes,
            Default = 1,
            NoSave = true,
            Callback = function(value)
                opt.GearSlot = value
                LoadGearList(value)
            end,
        })
        opt.SpawnGear = nil
        gearBox:AddDropdown("SpawnGear", {
            Text = T("Gear", "อุปกรณ์"),
            Description = T("Strongest first. Exclusive gear is shop only", "แรงสุดอยู่บน ของ Exclusive มีแค่ในร้าน"),
            Values = { "..." },
            Default = 1,
            Searchable = true,
            NoSave = true,
            Callback = function(value)
                opt.SpawnGear = value
            end,
        })
        LoadGearList(opt.GearSlot)
        NumberInput(gearBox, "GearCopies", T("Copies", "จำนวนชิ้น"), nil, 1)
        gearBox:AddButton({ Text = T("Spawn Gear", "เสกอุปกรณ์"), Style = "Primary", Func = LongAction("Index", function()
            local gear = State.GearLabels[opt.SpawnGear]
            return gear and xDTaraZ.Index.Hunt(gear, math.max(1, math.floor(opt.GearCopies)))
        end, function(got)
            return got and "Spawned!" or "Not all copies this time, press again"
        end) })
        gearBox:AddButton({ Text = T("Spawn Best Set", "เสกเซ็ตที่แรงสุด"), Func = LongAction("Index", xDTaraZ.Spawn.BestSet, function(made)
            return ("Spawned and equipped %d/3 pieces"):format(made or 0)
        end) })
        gearBox:AddButton({ Text = T("Buy Exclusive Gear", "ซื้อของ Exclusive"), Func = LongAction("Tower", xDTaraZ.Season.BuyExclusive, function(bought)
            return (bought or 0) > 0 and ("Bought %d exclusive pieces"):format(bought) or "Already bought this refresh"
        end) })

        local bonusBox = tab:AddRightGroupbox(T("Rolls, Tickets & Tokens", "เผ่า ตั๋ว และ Token"), nil, "OP")
        local bonusByLabel = { ["Race Rolls"] = "Race", ["Season Tickets + Coins"] = "Season", ["Tokens"] = "Token" }
        bonusBox:AddDropdown("BonusKind", {
            Text = T("Item", "ของ"),
            Values = { "Race Rolls", "Season Tickets + Coins", "Tokens" },
            Default = 1,
            NoSave = true,
            Callback = function(value)
                opt.BonusKind = bonusByLabel[value] or "Race"
            end,
        })
        NumberInput(bonusBox, "BonusAmount", T("Amount", "จำนวน"), T("Up to 2K rolls/tickets or 20K tokens per press. Every press grows your save, keep it small", "ต่อครั้งสูงสุด 2K roll/ตั๋ว หรือ 20K Token ทุกครั้งที่กดทำให้เซฟใหญ่ขึ้น ใช้เท่าที่จำเป็น"), 1)
        bonusBox:AddButton({ Text = T("Spawn", "เสก"), Style = "Primary", Func = LongAction("Spawn", function()
            return xDTaraZ.Bonus.Spawn(opt.BonusKind, opt.BonusAmount) * Config.BonusRewards[opt.BonusKind].per
        end, function(added)
            if (added or 0) <= 0 then return "Patched by the latest game update" end
            return ("+%s %s (stay 1 min so it saves)"):format(xDTaraZ.Util.Abbreviate(added), opt.BonusKind)
        end) })

        local tokenBox = tab:AddRightGroupbox(T("Token Shop", "ร้าน Token"), nil, "OP")
        Feature(tokenBox, "AutoTokenShop", T("Auto Token Shop", "ซื้อร้าน Token อัตโนมัติ"), T("Buys every pass and pack in the shop for free", "ซื้อพาสและแพ็คทุกชิ้นในร้าน Token ให้ฟรี"))
        tokenBox:AddButton({ Text = T("Buy All Now", "ซื้อทั้งหมดเดี๋ยวนี้"), Func = LongAction("Token Shop", xDTaraZ.TokenShop.BuyAll, function(bought)
            return (bought or 0) > 0 and ("Bought %d items"):format(bought) or "Everything here is already yours"
        end) })

        local potionBox = tab:AddRightGroupbox(T("Potions", "ยา"), nil, "OP")
        potionBox:AddButton({ Text = T("Max Potion Buffs", "บัฟยาเต็มทั้งปี"), Style = "Primary", Func = LongAction("Potion", xDTaraZ.Potion.MaxBuffs, function(count)
            return (count or 0) > 0 and ("%d potion buffs active for about a year"):format(count) or "Own at least one potion first"
        end) })
        potionBox:AddButton({ Text = T("Add 100K Potions", "เพิ่มยา 100K ขวด"), Func = Action(function()
            for _, potionId in ipairs(xDTaraZ.Potion.Owned()) do
                xDTaraZ.Potion.Add(potionId, Config.PotionStack)
            end
        end) })

        local coinBox = tab:AddRightGroupbox(T("Season Coins", "เหรียญซีซั่น"), nil, "OP")
        NumberInput(coinBox, "CoinTarget", T("Amount", "จำนวน"), nil, 1)
        coinBox:AddButton({ Text = T("Add Season Coins", "เพิ่มเหรียญซีซั่น"), Style = "Primary", Func = LongAction("Tower", function()
            return xDTaraZ.Tower.FarmCoins(opt.CoinTarget)
        end, function(gained) return ("+%s season coins"):format(xDTaraZ.Util.Abbreviate(gained or 0)) end) })

        local stoneBox = tab:AddRightGroupbox(T("Enhance Stones", "หินตีบวก"))
        stoneBox:AddButton({ Text = T("Farm Enhance Stones", "ฟาร์มหินตีบวก"), Style = "Primary", Func = LongAction("Stones", function()
            local before = xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "EnhantStone_1")
            xDTaraZ.Stage.FarmStones(xDTaraZ.Stage.Best())
            task.wait(0.5)
            return xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "EnhantStone_1") - before
        end, function(gained) return ("+%d enhance stones"):format(gained or 0) end) })
        stoneBox:AddButton({ Text = T("Farm Rare Stones", "ฟาร์มหินตีบวกหายาก"), Func = LongAction("Tower", function()
            local before = xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "EnhantStone_2")
            xDTaraZ.Tower.FarmStep()
            task.wait(0.5)
            return xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "EnhantStone_2") - before
        end, function(gained) return ("+%d rare stones"):format(gained or 0) end) })
    end

    local function BuildPlayer(tab)
        local raceBox = tab:AddLeftGroupbox(T("Race", "เผ่า"))
        local raceLabels, raceIds = Source(xDTaraZ.Race.Choices)
        raceBox:AddDropdown("RaceTargets", {
            Text = T("Target Races", "เผ่าที่ต้องการ"),
            Values = raceLabels,
            Multi = true,
            Default = {},
            Searchable = #raceLabels > 8,
            Callback = function(selected)
                local ids = {}
                for label, on in pairs(selected) do
                    if on and raceIds[label] then ids[raceIds[label]] = true end
                end
                opt.RaceTargets = ids
            end,
        })
        Decorate("RaceTargets", function(label) return raceIds[label] end)
        local rarityLabels, rarityLevels = Source(xDTaraZ.Race.RarityChoices)
        raceBox:AddDropdown("RaceMinRarity", {
            Text = T("Or Any Race Of", "หรือเผ่าระดับ"),
            Values = rarityLabels,
            Default = 1,
            Callback = function(value)
                opt.RaceMinLevel = rarityLevels[value]
            end,
        })
        local starByLabel = { ["Any"] = 0, ["2 Stars+"] = 2, ["3 Stars"] = 3 }
        raceBox:AddDropdown("RaceStar", {
            Text = T("Target Stars", "ดาวที่ต้องการ"),
            Values = { "Any", "2 Stars+", "3 Stars" },
            Default = 1,
            Callback = function(value)
                opt.RaceStar = starByLabel[value] or 0
            end,
        })
        raceBox:AddDropdown("RaceSlot", {
            Text = T("Roll Slot", "ช่องที่สุ่ม"),
            Values = Config.RaceSlots,
            Default = 1,
            Callback = function(value)
                opt.RaceSlot = value
            end,
        })
        Feature(raceBox, "AutoRace", T("Auto Roll Race", "สุ่มเผ่าอัตโนมัติ"), T("Rolls in the background until a chosen race shows up", "สุ่มเบื้องหลังจนกว่าจะได้เผ่าที่เลือก"), function(value)
            if not value or State.Rolling then return end
            if not next(opt.RaceTargets) and not opt.RaceMinLevel then
                Notify("Pick a target race first", "Warning")
                return Later(TurnOff, "AutoRace")
            end
            State.Rolling = true
            task.defer(function()
                if not opt.RaceAnim then xDTaraZ.Util.Try(xDTaraZ.Race.MuteAnim, true) end
                local ok, outcome, detail = pcall(xDTaraZ.Race.RollUntil)
                xDTaraZ.Util.Try(xDTaraZ.Race.MuteAnim, false)
                State.Rolling = false
                local used = State.RaceRolls or 0
                if not ok then
                    warn("[LootToForge] race roll:", outcome)
                elseif outcome == "got" then
                    Notify(("Got %s after %d rolls!"):format(tostring(detail), used), "Success", 8)
                elseif outcome == "empty" then
                    Notify("Out of race rolls. Turn on Spawn Rolls When Out", "Warning")
                elseif outcome == "blocked" then
                    Notify("Can't roll: " .. tostring(detail), "Warning")
                end
                Later(TurnOff, "AutoRace")
            end)
        end)
        Check(raceBox, "RaceRefill", T("Spawn Rolls When Out", "หมดแล้วเสก roll เพิ่ม"))
        Check(raceBox, "RaceLock", T("Lock Slot When Found", "ได้แล้วล็อกช่อง"))
        Check(raceBox, "RaceProtect", T("Never Replace Mythic+", "ไม่สุ่มทับเผ่า Mythic ขึ้นไป"))
        Check(raceBox, "RaceAnim", T("Show Roll Animation", "แสดงฉากสุ่ม"))
        Feature(raceBox, "AutoBestRace", T("Use Best Race Slot", "ใช้ช่องเผ่าที่ดีสุด"), T("Switches to your rarest race", "สลับไปใช้เผ่าที่หายากที่สุด"))
        raceBox:AddButton({ Text = T("Switch Now", "สลับเดี๋ยวนี้"), Func = Action(function()
            Notify(xDTaraZ.Race.EquipBest() and "Switched race slot" or "Already on your best race")
        end) })

        local moveBox = tab:AddRightGroupbox(T("Movement", "การเคลื่อนที่"))
        HotkeyFeature(moveBox, "SpeedOn", T("Speed", "ความเร็ว"), nil, xDTaraZ.Movement.Apply)
        moveBox:AddSlider("WalkSpeed", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Min = 16, Max = 200, Default = opt.WalkSpeed, Rounding = 0,
            Callback = function(value)
                opt.WalkSpeed = value
                xDTaraZ.Movement.Apply()
            end,
        })
        HotkeyFeature(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))

        local guardBox = tab:AddRightGroupbox(T("Survival", "เอาตัวรอด"))
        local godMode = Feature(guardBox, "GodMode", T("Invincible", "อมตะ"), T("Monsters and bosses can't kill you", "มอนสเตอร์และบอสฆ่าไม่ตาย"), function(value)
            if not value then
                if State.RestoreDamage then State.RestoreDamage() end
            elseif not xDTaraZ.Guard.HookDamage() then
                Notify("Invincible is not available on this executor", "Warning")
                task.defer(TurnOff, "GodMode")
            end
        end)
        NeedModule(godMode, ReplicatedStorage.CTRL.HPCTRL)
        local keepOre = Feature(guardBox, "KeepOre", T("Keep Ore On Death", "ตายแล้วแร่ไม่หาย"), nil, function(value)
            if not value then
                xDTaraZ.Guard.UnhookOreLoss()
            elseif not xDTaraZ.Guard.HookOreLoss() then
                Notify("Keep Ore On Death is not supported on this executor", "Warning")
                task.defer(TurnOff, "KeepOre")
            end
        end)
        xDTaraZ.Compat.NeedCap(keepOre, "Namecall")
    end

    local function BuildSettings(window)
        local settingsTab = window:AddSettingsTab()
        local sessionBox = settingsTab:AddRightGroupbox(T("Session", "เซสชัน"))
        Toggle(sessionBox, "AutoRejoin", T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), T("Rejoins the game by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"))
        Toggle(sessionBox, "LowGraphics", T("FPS Boost", "เพิ่ม FPS"), T("Turns off 3D rendering to save CPU and GPU", "ปิดการแสดงผล 3D ประหยัด CPU/GPU"), xDTaraZ.Session.SetLowGraphics)
        sessionBox:AddButton({ Text = T("Rejoin Now", "เข้าเกมใหม่เดี๋ยวนี้"), Func = Action(xDTaraZ.Session.Rejoin) })
        NumberInput(sessionBox, "OldVersion", T("Old Server Version", "เวอร์ชันเซิร์ฟเก่า"), T("Hops until it lands in a server still on this version", "ย้ายเซิร์ฟไปเรื่อยๆ จนเจอเซิร์ฟที่ยังเป็นเวอร์ชันนี้"), 1)
        sessionBox:AddButton({ Text = T("Find Old Server", "หาเซิร์ฟเวอร์ชันเก่า"), Func = Action(function()
            local target = math.floor(tonumber(opt.OldVersion) or Config.OldServerVersion)
            if game.PlaceVersion <= target then return Notify(("Already on version %d"):format(game.PlaceVersion), "Success") end
            local outcome = xDTaraZ.Session.FindOldServer(target)
            Notify(outcome == "searching" and ("Looking for version %d (now %d)"):format(target, game.PlaceVersion) or "Server list unavailable, try again", outcome == "searching" and "Info" or "Warning")
        end) }):AddButton({ Text = T("Stop", "หยุด"), Func = Action(function()
            xDTaraZ.Session.SaveOldSearch(nil)
            Notify("Old server search stopped", "Info")
        end) })
        sessionBox:AddButton({ Text = T("Hop To Emptiest Server", "ย้ายไปเซิร์ฟคนน้อยสุด"), Func = Action(function()
            if not xDTaraZ.Session.HopSmallest() then Notify("Server list unavailable, try again", "Warning") end
        end) })

        local spotBox = settingsTab:AddRightGroupbox(T("Position", "ตำแหน่ง"))
        spotBox:AddButton({ Text = T("Save Position", "บันทึกตำแหน่ง"), Func = Action(function()
            Notify(xDTaraZ.Session.SavePosition() and "Position saved" or "No character", "Info")
        end) }):AddButton({ Text = T("Go Back", "กลับไปจุดที่บันทึก"), Func = Action(function()
            if not xDTaraZ.Session.ReturnPosition() then Notify("Save a position first", "Warning") end
        end) })
    end

    local noteText = {
        EnhantStone_1 = "farming enhance stones",
        EnhantStone_2 = "farming rare enhance stones",
        Coin = "farming coins",
        Enhancing = "enhancing",
        NoTicket = "need a tower ticket",
        Done = "all at target",
    }

    local function TaskText()
        if State.Lock == "Index" then return "Index " .. (State.IndexNote or "planning") end
        if State.Lock then return State.Lock end
        if opt.MaxGear then return "Max Gear, " .. (noteText[State.GearNote] or "starting") end
        return "Idle"
    end

    local function UpdateStatus()
        local ok, profile = pcall(xDTaraZ.Data.Get)
        if not (ok and profile and statusLabel) then return end
        local eco = profile.Eco
        local line = ("Level %d · Rebirth %d · Coins %s"):format(eco.level, eco.rebirth, xDTaraZ.Util.Abbreviate(eco.coin))
        if State.TowerLoot > 0 then
            line ..= ("\nTower loot x%d"):format(State.TowerLoot)
        end
        Later(statusLabel.SetText, statusLabel, line)
        Later(gearLabel.SetText, gearLabel, "Equipped: " .. xDTaraZ.Gear.EquippedNames(profile))
        Later(taskLabel.SetText, taskLabel, "Working on: " .. TaskText())
    end

    local function BuildTabs()
        local Window = Library.Window
        Window:AddTabSection(T("Farm", "ฟาร์ม"))
        local MainTab = Window:AddTab(T("Main", "หลัก"), "house", T("Status, all-in-one mode and rewards", "สถานะ โหมดทำทุกอย่าง และรางวัล"))
        local GearTab = Window:AddTab(T("Gear", "อุปกรณ์"), "sword", T("Best gear, equip and enhance", "อุปกรณ์ที่ดีสุด ใส่ของ และตีบวก"))
        local FarmTab = Window:AddTab(T("Combat & Farm", "ต่อสู้และฟาร์ม"), "swords", T("Stages, monsters, bosses and index", "ด่าน มอนสเตอร์ บอส และสมุดสะสม"))
        local ForgeTab = Window:AddTab(T("Forge", "หลอม"), "zap", T("Forge gear from any ore", "หลอมอุปกรณ์จากแร่ไหนก็ได้"))
        local SellTab = Window:AddTab(T("Sell", "ขาย"), "upload", T("Sell gear by type and rarity", "ขายอุปกรณ์ตามประเภทและ rarity"))
        Window:AddTabSection(T("Progress", "ความคืบหน้า"))
        local ProgressTab = Window:AddTab(T("Upgrade & Rebirth", "อัปเกรดและรีเบิร์ธ"), "sliders-horizontal", T("Training, rebirth and upgrades", "ฝึก รีเบิร์ธ และอัปเกรด"))
        local TowerTab = Window:AddTab(T("Tower", "หอคอย"), "shield", T("Tower loot and season pass", "ของจากหอคอย และซีซั่นพาส"))
        local SpawnTab = Window:AddTab(T("Spawn Items", "เสกของ"), "target", T("Ores, runes and enhance stones", "แร่ รูน และหินตีบวก"))
        Window:AddTabSection(T("Other", "อื่นๆ"))
        local PlayerTab = Window:AddTab(T("Player", "ผู้เล่น"), "user", T("Race, movement and survival", "เผ่า การเคลื่อนที่ และเอาตัวรอด"))

        local sections = {
            { BuildMain, MainTab },
            { BuildGear, GearTab },
            { BuildFarm, FarmTab },
            { BuildForge, ForgeTab },
            { BuildSell, SellTab },
            { BuildProgress, ProgressTab },
            { BuildTower, TowerTab },
            { BuildSpawn, SpawnTab },
            { BuildPlayer, PlayerTab },
            { BuildSettings, Window },
        }
        for _, section in ipairs(sections) do
            xDTaraZ.Util.Try(section[1], section[2])
        end
        xDTaraZ.Util.Try(BlockMissing)

        Library:Every(Config.PumpInterval, Pump)
        task.spawn(function()
            while State.Alive do
                UpdateStatus()
                task.wait(Config.StatusInterval)
            end
        end)
    end

    local function Unload()
        Library:Unload()
    end
    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    Library:OnUnload(function()
        if getgenv().LootToForgeUnload == Unload then getgenv().LootToForgeUnload = nil end
    end)
    getgenv().LootToForgeUnload = Unload

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Loot To Forge by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Halloween",
        OnUnlocked = function()
            BuildTabs()
            xDTaraZ.Util.Try(xDTaraZ.Scheduler.Boot)
            Notify("Loaded", "Success")
            xDTaraZ.Util.Try(Library.LoadAutoloadConfig, Library)
            if xDTaraZ.Boss.HopWanted() and Options.BossHop then Options.BossHop:SetValue(true) end
            local search = xDTaraZ.Session.OldSearch()
            if search then
                task.delay(Config.OldServerGap, function()
                    local outcome = xDTaraZ.Session.FindOldServer()
                    if outcome == "found" then
                        Notify(("Found a version %d server!"):format(game.PlaceVersion), "Success", 10)
                    elseif outcome == "gaveup" then
                        Notify(("No version %d server after %d hops"):format(search.target, Config.OldServerTries), "Warning", 10)
                    elseif outcome == "nolist" then
                        Notify("Server list unavailable, press Find Old Server again", "Warning")
                    else
                        Notify(("Version %d, hop %d/%d"):format(game.PlaceVersion, search.tries + 1, Config.OldServerTries), "Info")
                    end
                end)
            end
        end,
    })
end

if getgenv().LootToForgeUnload then
    pcall(getgenv().LootToForgeUnload)
end

pcall(MarioBanner.Step, "Systems")
BuildInterface()
pcall(MarioBanner.Step, "Interface")
pcall(MarioBanner.Ready)