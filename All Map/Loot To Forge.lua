if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10684750879 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub : this script is for Loot To Forge only")
    return
end

local MarioBanner = {
    Print = type(getrenv) == "function" and getrenv().print or print,
    Started = os.clock(),
    Last = os.clock(),
    Done = 0,
    Total = 4,
}

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
        "   LOOT TO FORGE  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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

MarioBanner.Show()
MarioBanner.Step("Core")

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

local LocalPlayer = Players.LocalPlayer

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})
local Remote = ReplicatedStorage:WaitForChild("Remote")
local GameConfig = ReplicatedStorage:WaitForChild("Config")

xDTaraZ.Config = {
    SaveFolder = "Loot To Forge",
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui_v2.lua",
    LoaderUrl = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/loader.lua",
    TickDelay = 0.2,
    StatusInterval = 2,
    RefillAmount = 100000,
    OwnedOresLabel = "Owned ores",
    AcquireRounds = 300,
    StoneWorkers = 8,
    StoneCallsPerWorker = 15,
    TowerWorkers = 8,
    TowerCallsPerWorker = 25,
    GearForgeTries = 15,
    GearEnhanceTries = 20,
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
    EnchantRefill = 50,
    ForgeCountMax = 30,
    HuntBatch = 40,
    HuntWorkers = 4,
    HuntMaxForges = 4000,
    HuntTargetHits = 3,
    IndexInterval = 60,
    IndexLevelClaims = 50,
    ClaimIdScan = 20,
    ClaimInterval = 30,
    SeasonInterval = 60,
    BossCards = 8,
    BossSkill = "G_Skill_7",
    BossHitsPerTick = 20,
    UpgradeInterval = 5,
    EquipInterval = 3,
    SellInterval = 1,
    RebirthInterval = 2,
    BossInterval = 1,
    TrainRejoinDelay = 0.3,
    TrainAcceptWait = 1.5,
    KillAuraInterval = 0.25,
    KillDamage = 1e30,
    RaceRollDelay = 0.45,
    RejoinDelay = 5,
    Codes = { "30000CCU", "20000CCU" },
    KaitunToggles = { "MaxGear", "AutoEquip", "AutoForge", "AutoSell", "AutoTrain", "AutoRebirth", "AutoUpgrade", "AutoClaim", "AutoSeason", "KillAura", "SuperLootAura", "AutoWorldBoss", "AutoTower", "GodMode", "AutoBestRace" },
}

local Config = xDTaraZ.Config

xDTaraZ.State = {
    Alive = true,
    Busy = false,
    Lock = nil,
    InTower = false,
    Entering = false,
    GearForged = false,
    TrainArea = nil,
    LastRun = {},
    Profile = nil,
    GearNote = nil,
    IndexNote = nil,
    TowerLoot = 0,
    OreLabels = {},
    SpawnLabels = {},
    MissingLabels = {},
    OreStage = {},
    Plans = {},
    Conns = {},
    Opt = {
        MaxGear = false,
        AutoEquip = false,
        EnhanceTarget = 10,
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
        AutoTower = false,
        AutoRace = false,
        TargetRace = nil,
        SpawnItem = nil,
        SpawnAmount = 100000,
        SpeedOn = false,
        WalkSpeed = 60,
        InfJump = false,
        AutoRejoin = false,
        LowGraphics = false,
    },
}

local State = xDTaraZ.State

for _, name in ipairs({ "Util", "Data", "Stage", "Ore", "Spawn", "Forge", "Sell", "Gear", "Index", "Level", "Upgrade", "Tower", "Boss", "Season", "Claim", "SuperLoot", "Combat", "Guard", "Race", "Movement", "Session", "Scheduler" }) do
    xDTaraZ[name] = {}
end

function xDTaraZ.Util.Remote(folder, name)
    return Remote:WaitForChild(folder):WaitForChild(name)
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
    while pending > 0 do
        task.wait(0.1)
    end
end

function xDTaraZ.Util.RarityNames()
    local helper = require(GameConfig.Rarity.Helper)
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
    local oreConfig = require(GameConfig.Ore.Config)[oreId]
    return oreConfig and require(GameConfig.Rarity.Helper).GetRarityByLevel(oreConfig.Rarity)
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
    for oreId in pairs(require(GameConfig.Ore.Config)) do
        table.insert(ids, oreId)
    end
    table.sort(ids, function(a, b) return xDTaraZ.Util.Tier(a) > xDTaraZ.Util.Tier(b) end)
    return ids
end

function xDTaraZ.Ore.Choices()
    local oreShow = require(GameConfig.Ore.Show)
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
    local stoneShow = require(GameConfig.EnchStone.Show)
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

function xDTaraZ.Stage.List()
    local stages = {}
    for stageId in pairs(require(GameConfig.Stage.Helper).GetStageEnemyConfig()) do
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
    local target = xDTaraZ.Util.Tier(oreId) * #stages / xDTaraZ.Util.Tier(xDTaraZ.Util.HighestKey(require(GameConfig.Ore.Config)))
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
    require(LocalPlayer.PlayerScripts.Manager.StageManager.StageUtils).ExitFight(true)
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
        if not wornEntry or xDTaraZ.Gear.Score(entry) > xDTaraZ.Gear.Score(wornEntry) then
            keep[uuid] = true
        end
    end
    xDTaraZ.Sell.Fresh(fresh, keep)
end

function xDTaraZ.Sell.Rarity(entry)
    local folder = entry.Type == "Weapon" and "Weapon" or "Armor"
    local itemConfig = require(GameConfig[folder].Config)[entry.ID]
    return itemConfig and itemConfig.Rarity
end

function xDTaraZ.Sell.Run(profile)
    local opt = State.Opt
    local equipped = {}
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
    local equipped = {}
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

---@return number  gear power, enchants only break ties
function xDTaraZ.Gear.Score(entry)
    local helper = require(entry.Type == "Weapon" and GameConfig.Weapon.Helper or GameConfig.Armor.Helper)
    local ok, base = pcall(helper.GetMainAffix, entry.ID)
    if not ok or type(base) ~= "number" then return 0 end
    local boostOk, boost = pcall(require(GameConfig.Enhant.Helper).GetBoost, entry.Level or 0)
    return base * (1 + (boostOk and tonumber(boost) or 0)) * (1 + #(entry.EnchanceList or {}) * 1e-9)
end

function xDTaraZ.Gear.BestOwned(profile, slot)
    local bestUuid, bestScore = nil, -1
    for uuid, entry in pairs(profile.Backpack.have) do
        if entry.Type == slot then
            local score = xDTaraZ.Gear.Score(entry)
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
    for _, slot in ipairs(Config.GearTypes) do
        local best, bestScore = xDTaraZ.Gear.BestOwned(profile, slot)
        local current = profile.Backpack.equiped[slot]
        local currentEntry = current and profile.Backpack.have[current]
        if best and best ~= current and bestScore > (currentEntry and xDTaraZ.Gear.Score(currentEntry) or -1) then
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
        local best = xDTaraZ.Gear.BestOwned(xDTaraZ.Data.Get(), spec.slot)
        if best then
            xDTaraZ.Util.Remote("Backpack", "TryEquipItemRE"):FireServer(best, spec.slot)
        end
    end
    task.wait(1)
    xDTaraZ.Sell.Fresh(xDTaraZ.Data.NewGear(before))
end

function xDTaraZ.Gear.MissingForEnhance(profile, level)
    local cost = require(GameConfig.Enhant.Config)[level + 1]
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

function xDTaraZ.Gear.Priority()
    return #State.Opt.EnchantPriority > 0 and State.Opt.EnchantPriority or Config.EnchantPriority
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
    local target = math.min(State.Opt.EnhanceTarget, xDTaraZ.Util.Tier(xDTaraZ.Util.HighestKey(require(GameConfig.Enhant.Config))))
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
            local useProtect = xDTaraZ.Data.Count(profile, "EnhantProtect") > 0 and (entry.Level or 0) >= require(GameConfig.Enhant.Helper).GetFailLevel()
            for _ = 1, Config.GearEnhanceTries do
                if not enhance:InvokeServer(uuid, { UseProtect = useProtect }) then break end
                local current = xDTaraZ.Data.Get().Backpack.have[uuid]
                if not current or (current.Level or 0) >= target then break end
            end
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
    local failLevel = require(GameConfig.Enhant.Helper).GetFailLevel()
    local level = 0
    for _ = 1, Config.GearEnhanceTries * 10 do
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
            local show = require(GameConfig[entry.Type == "Weapon" and "Weapon" or "Armor"].Show)[entry.ID]
            table.insert(names, ("%s +%d"):format(show and show.DisplayName or entry.ID, entry.Level or 0))
        end
    end
    return table.concat(names, " · ")
end

function xDTaraZ.Index.GearCatalog()
    local gear = {}
    local armorHelper = require(GameConfig.Armor.Helper)
    for weaponId, weapon in pairs(require(GameConfig.Weapon.Config)) do
        table.insert(gear, { id = weaponId, slot = "Weapon", forgeType = "Weapon", forgeable = weapon.TLevel ~= nil })
    end
    for armorId, armor in pairs(require(GameConfig.Armor.Config)) do
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

    local forgeUtils = require(ReplicatedStorage.Utils.ForgeUtils)
    local helper = require(gear.forgeType == "Weapon" and GameConfig.Weapon.Helper or GameConfig.Armor.Helper)
    local bestChance, bestOre, bestCount = 0, nil, nil
    for count = 1, Config.ForgeCountMax do
        local split = helper.GetForgePercentByNumber(count)
        if not split then continue end
        for _, oreId in ipairs(xDTaraZ.Ore.Ids()) do
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
    local show = require(GameConfig[gear.forgeType].Show)[gear.id]
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

---@return boolean  true once the index has it
function xDTaraZ.Index.Hunt(gear)
    local chance, oreId, count = xDTaraZ.Index.Plan(gear)
    if chance <= 0 then return false end
    local budget = math.min(Config.HuntMaxForges, math.ceil(Config.HuntTargetHits / chance))
    local key = gear.slot .. "-" .. gear.id
    local forged = 0
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
            if entry.ID == gear.id then keep[freshUuid] = true end
        end
        xDTaraZ.Sell.Fresh(fresh, keep)
        if State.Profile.Index.unlocked[key] or next(keep) then return true end
    end
    return false
end

---@return number, number  found, tried
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

function xDTaraZ.Level.FindBestArea()
    local areas = require(GameConfig.TrainArea.Config)
    local ids = {}
    for areaId in pairs(areas) do
        table.insert(ids, tonumber(areaId))
    end
    table.sort(ids, function(a, b) return areas[a].Basic > areas[b].Basic end)

    local into = xDTaraZ.Util.Remote("Train", "IntoAutoTrainRE")
    for _, areaId in ipairs(ids) do
        into:FireServer(areaId)
        local deadline = os.clock() + Config.TrainAcceptWait
        while os.clock() < deadline and LocalPlayer:GetAttribute("AutoTrainAreaID") ~= areaId do
            task.wait(0.1)
        end
        if LocalPlayer:GetAttribute("AutoTrainAreaID") == areaId then
            return areaId
        end
    end
    return nil
end

function xDTaraZ.Level.Enter()
    if not State.TrainArea then
        State.TrainArea = xDTaraZ.Level.FindBestArea()
        return
    end
    xDTaraZ.Util.Remote("Train", "IntoAutoTrainRE"):FireServer(State.TrainArea)
end

function xDTaraZ.Level.SetTraining(enabled)
    if enabled then
        xDTaraZ.Level.Enter()
    elseif State.TrainArea then
        xDTaraZ.Util.Remote("Train", "ExitAutoTrainRE"):FireServer(State.TrainArea)
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
    local potionConfig = require(GameConfig.Potion.Config)
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
    xDTaraZ.Level.UsePotions(xDTaraZ.Data.Get())
    if not LocalPlayer:GetAttribute("AutoTrainAreaID") then
        xDTaraZ.Level.Enter()
    end
end

function xDTaraZ.Level.Rebirth()
    xDTaraZ.Util.Remote("Rebirth", "TryRebirthRE"):FireServer()
end

function xDTaraZ.Level.RebirthStep()
    local profile = xDTaraZ.Data.Get()
    local ok, needLevel = pcall(require(GameConfig.Rebirth.Helper).GetNeedLevel, profile.Eco.rebirth + 1)
    if ok and needLevel and profile.Eco.level >= needLevel then
        xDTaraZ.Level.Rebirth()
    end
end

function xDTaraZ.Level.StartClicking()
    task.spawn(function()
        local trainCtrl = require(ReplicatedStorage.CTRL.TrainCTRL)
        while State.Alive and State.Opt.AutoClick do
            xDTaraZ.Util.Try(trainCtrl.TrainOnce)
            task.wait(Config.ClickInterval)
        end
    end)
end

function xDTaraZ.Upgrade.Names()
    local names = {}
    for name in pairs(require(GameConfig.Upgrade.Config)) do
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
    return #require(GameConfig.Dungeon.Config.LootTab)
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
    xDTaraZ.Util.WaitAll(Config.TowerWorkers, function()
        for _ = 1, Config.TowerCallsPerWorker do
            start:FireServer(round)
            if complete:InvokeServer(round) then
                State.TowerLoot += 1
            end
        end
    end)
    return true
end

function xDTaraZ.Boss.Alive()
    return workspace:GetAttribute("CurrentWorldBoss") ~= nil
end

function xDTaraZ.Boss.Step()
    if not xDTaraZ.Boss.Alive() then return end
    if LocalPlayer:GetAttribute("IntoFight") ~= "WorldBoss" then
        xDTaraZ.Util.Remote("WorldBoss", "IntoWorldBossFight"):FireServer()
        LocalPlayer:SetAttribute("IntoFight", "WorldBoss")
    end
    xDTaraZ.Combat.KillAll()
    local targets = {}
    for _, enemy in ipairs(workspace.EnemyFolder_Server:GetChildren()) do
        table.insert(targets, enemy.Name)
    end
    if #targets == 0 then return end
    local attack = xDTaraZ.Util.Remote("Attack", "AttackEnemyServiceRE")
    for _ = 1, Config.BossHitsPerTick do
        attack:FireServer(targets, { Phase = 1, SkillID = Config.BossSkill, Attacker = LocalPlayer }, workspace:GetServerTimeNow())
    end
end

function xDTaraZ.Boss.ClaimCards()
    local claim = xDTaraZ.Util.Remote("WorldBoss", "TryClaimBossRewardRE")
    for card = 1, Config.BossCards do
        claim:FireServer(tostring(card))
    end
end

function xDTaraZ.Boss.Bind()
    table.insert(State.Conns, xDTaraZ.Util.Remote("WorldBoss", "BossDeadRE").OnClientEvent:Connect(function()
        if not State.Opt.AutoWorldBoss then return end
        task.delay(1, function()
            if State.Opt.BossCards then xDTaraZ.Util.Try(xDTaraZ.Boss.ClaimCards) end
            xDTaraZ.Util.Remote("WorldBoss", "ExitWorldBossFight"):FireServer()
            LocalPlayer:SetAttribute("IntoFight", nil)
        end)
    end))
end

function xDTaraZ.Season.Current()
    local seasons = xDTaraZ.Data.Get().Season or {}
    local bestKey = xDTaraZ.Util.HighestKey(seasons)
    return bestKey and seasons[bestKey]
end

function xDTaraZ.Season.Goods()
    local goods = require(GameConfig.Season.GoodsConfig)
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

function xDTaraZ.Season.BuyGoods()
    local goods = require(GameConfig.Season.GoodsConfig)
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

    local ok, rewards = pcall(require(GameConfig.Online.Helper).GetOnlineRewardConfig)
    for rewardName in pairs(ok and type(rewards) == "table" and rewards or {}) do
        xDTaraZ.Util.Remote("Online", "TryClaimRE"):FireServer(rewardName)
    end
end

function xDTaraZ.Claim.Code(code)
    local ok, reply = pcall(function()
        return xDTaraZ.Util.Remote("Code", "TryUseCodeRF"):InvokeServer(code)
    end)
    return ok and reply
end

function xDTaraZ.Claim.AllCodes()
    local results = {}
    for _, code in ipairs(Config.Codes) do
        table.insert(results, ("%s: %s"):format(code, tostring(xDTaraZ.Claim.Code(code))))
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
    local hit = require(ReplicatedStorage.Utils.CommunicationUtils).TryGetBindableEvent("Attack", "EnemyHitBE")
    local hitInfo = { SkillID = "K_ATK_1", IsCrit = true, Damage = Config.KillDamage }
    for _, enemy in ipairs(workspace.EnemyFolder:GetChildren()) do
        local enemyId = enemy:GetAttribute("EnemyID")
        if enemyId and not enemyId:find("^Super") then
            hit:Fire(enemy.Name, Config.KillDamage, hitInfo)
        end
    end
end

function xDTaraZ.Combat.Start()
    task.spawn(function()
        while State.Alive and State.Opt.KillAura do
            xDTaraZ.Util.Try(xDTaraZ.Combat.KillAll)
            task.wait(Config.KillAuraInterval)
        end
    end)
end

function xDTaraZ.Guard.Boot()
    local hpCtrl = require(ReplicatedStorage.CTRL.HPCTRL)
    local damageOnce = hpCtrl.DamageOnce
    State.RestoreDamage = function() hpCtrl.DamageOnce = damageOnce end
    hpCtrl.DamageOnce = function(target, damage)
        if target == LocalPlayer and State.Opt.GodMode then return false end
        return damageOnce(target, damage)
    end
end

---@return boolean  false when the executor can't hook namecall
function xDTaraZ.Guard.HookOreLoss()
    if State.NamecallHooked then return true end
    if not (hookmetamethod and getnamecallmethod) then return false end
    local lostOre = xDTaraZ.Util.Remote("Stage", "LostAllOreRF")
    local original
    original = hookmetamethod(game, "__namecall", function(self, ...)
        if self == lostOre and State.Opt.KeepOre and getnamecallmethod() == "InvokeServer" then
            return {}
        end
        return original(self, ...)
    end)
    State.NamecallHooked = true
    State.RestoreNamecall = function() hookmetamethod(game, "__namecall", original) end
    return true
end

function xDTaraZ.Guard.Stop()
    if State.RestoreDamage then State.RestoreDamage() end
    if State.RestoreNamecall then pcall(State.RestoreNamecall) end
end

function xDTaraZ.Race.Choices()
    local classConfig = require(GameConfig.Class.Config)
    local show = require(GameConfig.Class.Show)
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
    local classConfig = require(GameConfig.Class.Config)
    local bestSlot, bestWeight = nil, math.huge
    for slot, classId in pairs(classData.have) do
        local weight = classConfig[classId] and classConfig[classId].Weight or math.huge
        if weight < bestWeight then bestSlot, bestWeight = slot, weight end
    end
    if not bestSlot or tostring(bestSlot) == tostring(classData.equiped) then return false end
    xDTaraZ.Util.Remote("Class", "ChangeEquipedIndexRE"):FireServer(tostring(bestSlot))
    return true
end

function xDTaraZ.Race.RollUntil(targetId)
    local roll = xDTaraZ.Util.Remote("Class", "LuckOnceRE")
    while State.Opt.AutoRace do
        local classData = xDTaraZ.Data.Get().Class
        if classData.have[classData.equiped] == targetId then return "got" end
        if (classData.luckTimes or 0) <= 0 then return "empty" end
        roll:FireServer(tostring(classData.equiped))
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
    if queue then
        queue(("loadstring(game:HttpGet(%q))()"):format(Config.LoaderUrl))
    end
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

function xDTaraZ.Session.Bind()
    table.insert(State.Conns, LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end))
    table.insert(State.Conns, GuiService.ErrorMessageChanged:Connect(function(msg)
        if State.Opt.AutoRejoin and msg ~= "" then
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
    { key = "AutoClaim", every = Config.ClaimInterval, run = function() xDTaraZ.Claim.All() end },
    { key = "AutoSeason", every = Config.SeasonInterval, run = function() xDTaraZ.Season.Step() end },
    { key = "AutoBestRace", every = 10, run = function() xDTaraZ.Race.EquipBest() end },
    { key = "AutoIndex", every = Config.IndexInterval, run = function() xDTaraZ.Util.Exclusive("Index", xDTaraZ.Index.HuntAll) end },
}

function xDTaraZ.Scheduler.Step()
    if State.Lock then return end
    local now = os.clock()
    for _, job in ipairs(xDTaraZ.Scheduler.Jobs) do
        if not State.Opt[job.key] or State.Lock then continue end
        if now - (State.LastRun[job.key] or 0) < job.every then continue end
        State.LastRun[job.key] = now
        xDTaraZ.Util.Try(job.run)
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
    xDTaraZ.Movement.Bind()
    xDTaraZ.Level.Bind()
    xDTaraZ.SuperLoot.Bind()
    xDTaraZ.Boss.Bind()
    xDTaraZ.Util.Try(xDTaraZ.Guard.Boot)
    xDTaraZ.Session.Bind()
    xDTaraZ.Scheduler.Start()
end

function xDTaraZ.Scheduler.Stop()
    State.Alive = false
    for _, conn in ipairs(State.Conns) do
        conn:Disconnect()
    end
    table.clear(State.Conns)
    if State.Opt.AutoTrain then
        xDTaraZ.Util.Try(xDTaraZ.Level.SetTraining, false)
    end
    if State.Opt.LowGraphics then
        xDTaraZ.Session.SetLowGraphics(false)
    end
    xDTaraZ.Util.Try(xDTaraZ.Tower.Exit)
    xDTaraZ.Guard.Stop()
end

local function BuildInterface()
    local Library = loadstring(game:HttpGet(Config.UiSource))()
    MarioBanner.Step("UI library")
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt
    local rarityNames = xDTaraZ.Util.RarityNames()

    local function Notify(text, kind)
        Library:Notify("Loot To Forge", text, 4, kind or "Info")
    end

    local function Action(action)
        return function()
            task.spawn(xDTaraZ.Util.Try, action)
        end
    end

    ---@param name string  lock name, also the busy message
    local function LongAction(name, action, done)
        return function()
            task.spawn(function()
                if State.Lock then return Notify("Busy: " .. State.Lock, "Warn") end
                Notify(name .. "...")
                local outcome
                xDTaraZ.Util.Exclusive(name, function() outcome = action() end)
                if done then Notify(done(outcome), "Success") end
            end)
        end
    end

    local function Store(key, onChange)
        return function(value)
            opt[key] = value
            if onChange then onChange(value) end
        end
    end

    ---@param info table  AddFeature info; Callback is wrapped to mirror opt[key]
    local function Feature(group, key, info)
        info.Default = opt[key]
        info.Keybind = info.Keybind or { Default = "None", Mode = "Toggle" }
        info.Callback = Store(key, info.Callback)
        return group:AddFeature(key, info)
    end

    local function Toggle(group, key, info)
        info.Default = opt[key]
        info.Callback = Store(key, info.Callback)
        return group:AddToggle(key, info)
    end

    local function Chips(group, key, info)
        opt[key] = xDTaraZ.Util.AllSet(info.Values)
        info.Default = info.Values
        info.Callback = Store(key)
        return group:AddMultiChips(key, info)
    end

    local function Count(group, key, info)
        info.Default = opt[key]
        info.Callback = Store(key)
        return group:AddStepper(key, info)
    end

    local function Pick(group, key, info)
        local values = info.Source()
        info.Source = nil
        opt[key] = values[1]
        info.Values = values
        info.Default = values[1]
        info.Searchable = #values > 8
        info.Callback = Store(key)
        return group:AddDropdown(key, info)
    end

    local function Refresh(group, idx, list)
        group:AddButton({ Text = T("Refresh", "รีเฟรช"), Icon = "refresh", Style = "Ghost", Callback = function()
            Options[idx]:SetValues(list())
        end })
    end

    local function RegisterIcons()
        if Library:HasIcon("anvil") then return end
        Library:AddIcon("anvil", {
            "............",
            "..kkkkkkkkk.",
            "kkeeeeeeeenk",
            "keeeeeeeeNk.",
            ".kkNNNNNNk..",
            "...kNNNNk...",
            "...knnnNk...",
            "..kkNNNNkk..",
            ".kNNNNNNNNk.",
            ".kkkkkkkkkk.",
            "....oooo....",
            "............",
        }, {
            k = Color3.fromRGB(28, 24, 30),
            e = Color3.fromRGB(214, 220, 230),
            n = Color3.fromRGB(150, 158, 172),
            N = Color3.fromRGB(96, 104, 120),
            o = Color3.fromRGB(255, 140, 40),
        })
    end

    local function BuildMain(window)
        window:AddTabSection(T("Main", "หลัก"))
        local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and Kaitun", "สถานะ และไก่ตัน"))

        local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "stats")
        status:AddStatus("StatusGear", { Text = T("Gear", "อุปกรณ์"), Icon = "sword" })
        status:AddStatus("StatusTask", { Text = T("Working on", "กำลังทำ"), Icon = "upgrade" })
        status:AddStat("StatLevel", { Text = T("Level", "เลเวล"), Icon = "up", Format = "%s" })
        status:AddStat("StatRebirth", { Text = T("Rebirth", "รีเบิร์ธ"), Icon = "rebirth", Format = "%s" })
        status:AddStat("StatCoins", { Text = T("Coins", "เหรียญ"), Icon = "coin", Format = function(coins) return xDTaraZ.Util.Abbreviate(math.floor(coins)) end, Token = "Coin" })
        status:AddStat("StatTowerLoot", { Text = T("Tower loot", "ของจากหอคอย"), Icon = "loot", Format = "%s", Token = "Good" })

        local kaitun = tab:AddRightGroupbox(T("Kaitun", "ไก่ตัน"), "crown")
        kaitun:AddFeature("Kaitun", {
            Text = T("Kaitun", "ไก่ตัน"),
            Description = T("Best gear, money, level, rewards and bosses all at once", "ของดีสุด เงิน เลเวล รางวัล และบอส พร้อมกันทั้งหมด"),
            Icon = "crown",
            NoSave = true,
            Keybind = { Default = "None", Mode = "Toggle" },
            Callback = function(value)
                for _, key in ipairs(Config.KaitunToggles) do
                    Options[key]:SetValue(value)
                end
            end,
        })
        kaitun:AddButton({ Text = T("Panic - All Off", "ฉุกเฉิน ปิดทั้งหมด"), Icon = "stop", Style = "Danger", Callback = function()
            for _, toggle in pairs(Library.Toggles) do
                if toggle.Value == true then toggle:SetValue(false) end
            end
        end })

        Library.Kit.Discord.Build(tab, Config.Discord)
    end

    local function BuildFarm(window)
        window:AddTabSection(T("Farming", "ฟาร์ม"))
        local tab = window:AddTab(T("Farm", "ฟาร์ม"), "autofarm", T("Stages and monsters", "ด่าน และมอนสเตอร์"))

        local stage = tab:AddLeftGroupbox(T("Stage", "ด่าน"), "map")
        Pick(stage, "Stage", {
            Text = T("Stage", "ด่าน"),
            Description = T("Any stage, no unlock needed", "ด่านไหนก็ได้ ไม่ต้องปลดล็อก"),
            Icon = "map",
            Source = xDTaraZ.Stage.List,
        })
        Feature(stage, "CollectOre", {
            Text = T("Auto Collect Ore", "เก็บแร่อัตโนมัติ"),
            Description = T("Clears the stage and grabs its ores nonstop", "เคลียร์ด่านแล้วเก็บแร่ไม่หยุด"),
            Icon = "pickaxe",
            Options = function(sub)
                Chips(sub, "CollectRarities", { Text = T("Collect rarities", "rarity ที่เก็บ"), Icon = "filter", Values = rarityNames })
            end,
        })

        local combat = tab:AddRightGroupbox(T("Combat", "ต่อสู้"), "sword")
        Feature(combat, "KillAura", {
            Text = T("Kill Aura", "ฆ่ารอบตัว"),
            Description = T("Every monster in your fight dies instantly", "มอนสเตอร์ทุกตัวในการต่อสู้ตายทันที"),
            Icon = "killaura",
            Callback = function(value)
                if value then xDTaraZ.Combat.Start() end
            end,
        })
        Feature(combat, "SuperLootAura", {
            Text = T("Kill Ore Boss", "ฆ่าบอสแร่"),
            Description = T("Rare ore bosses die the moment they spawn", "บอสแร่หายากตายทันทีที่เกิด"),
            Icon = "boss",
            Callback = function(value)
                if value then xDTaraZ.SuperLoot.KillExisting() end
            end,
        })
        combat:AddButton({ Text = T("Exit Fight Now", "ออกจากการต่อสู้เดี๋ยวนี้"), Icon = "close", Style = "Warning", Callback = Action(xDTaraZ.Stage.ExitFight) })
    end

    local function BuildBosses(window)
        local tab = window:AddTab(T("Bosses", "บอส"), "boss", T("World boss and tower", "บอสโลก และหอคอย"))

        local boss = tab:AddLeftGroupbox(T("World Boss", "บอสโลก"), "boss")
        Feature(boss, "AutoWorldBoss", {
            Text = T("Auto World Boss", "บอสโลกอัตโนมัติ"),
            Description = T("Joins every world boss and kills it", "เข้าบอสโลกทุกรอบแล้วฆ่า"),
            Icon = "boss",
            Badge = T("Beta", "เบต้า"),
            Options = function(sub)
                Toggle(sub, "BossCards", { Text = T("Take every reward card", "เปิดการ์ดรางวัลทุกใบ"), Icon = "trophy" })
            end,
        })

        local tower = tab:AddRightGroupbox(T("Tower", "หอคอย"), "shield")
        Feature(tower, "AutoTower", {
            Text = T("Auto Farm Tower", "ฟาร์มหอคอยอัตโนมัติ"),
            Description = T("Top floor loot nonstop on one ticket: rare stones and season coins", "ของชั้นบนสุดไม่หยุดด้วยตั๋วใบเดียว ได้หินหายากและเหรียญซีซั่น"),
            Icon = "loot",
            Callback = function(value)
                task.spawn(function()
                    if not value then return xDTaraZ.Util.Try(xDTaraZ.Tower.Exit) end
                    if not xDTaraZ.Tower.Enter() then Notify("No tower ticket", "Warn") end
                end)
            end,
        })
        tower:AddButton({ Text = T("Exit Tower Now", "ออกจากหอคอยเดี๋ยวนี้"), Icon = "close", Style = "Warning", Callback = function()
            Options.AutoTower:SetValue(false)
            task.spawn(xDTaraZ.Util.Try, xDTaraZ.Tower.Exit)
        end })
    end

    local function BuildForge(window)
        window:AddTabSection(T("Forging", "หลอม"))
        local tab = window:AddTab(T("Forge", "หลอม"), "anvil", T("Forge gear from any ore", "หลอมอุปกรณ์จากแร่ไหนก็ได้"))

        local forge = tab:AddLeftGroupbox(T("Forge", "หลอม"), "anvil")
        local targetNames = {}
        for _, target in ipairs(Config.ForgeTargets) do
            targetNames[#targetNames + 1] = target.name
        end
        forge:AddSegmented("ForgeTarget", {
            Text = T("Target gear", "อุปกรณ์ที่จะหลอม"),
            Icon = "craft",
            Values = targetNames,
            Default = opt.ForgeTarget,
            Callback = function(value)
                opt.ForgeTarget = value or opt.ForgeTarget
            end,
        })
        Pick(forge, "ForgeOre", {
            Text = T("Ore to use", "แร่ที่ใช้หลอม"),
            Description = T("Pick an ore and it never runs out", "เลือกแร่แล้วไม่มีวันหมด"),
            Icon = "gem",
            Source = xDTaraZ.Ore.ForgeChoices,
            Risky = true,
        })
        Feature(forge, "AutoForge", {
            Text = T("Auto Forge", "หลอมอัตโนมัติ"),
            Description = T("Forges the target gear nonstop", "หลอมอุปกรณ์ที่เลือกไม่หยุด"),
            Icon = "anvil",
            Now = { Text = T("Forge Now", "หลอมเดี๋ยวนี้"), Icon = "fire", Callback = Action(xDTaraZ.Forge.Step) },
            Options = function(sub)
                Count(sub, "ForgePerTick", { Text = T("Forges per round", "หลอมต่อรอบ"), Icon = "plus", Min = 1, Max = 50, Step = 1 })
                Toggle(sub, "ForgeSellJunk", { Text = T("Sell worse gear right away", "ขายของที่แย่กว่าที่ใส่ทันที"), Icon = "sell" })
            end,
        })

        local owned = tab:AddRightGroupbox(T("Owned Ores", "แร่ที่มี"), "box")
        owned:AddLabel({ Text = T("Used when Ore to use is Owned ores", "ใช้ตอนเลือกแร่ที่ใช้หลอม = แร่ที่มี") })
        Toggle(owned, "BestOreFirst", {
            Text = T("Spend Best Ore First", "ใช้แร่ดีสุดก่อน"),
            Description = T("Off = weakest ore first", "ปิด = ใช้แร่อ่อนสุดก่อน"),
            Icon = "sort",
        })
        Chips(owned, "ForgeRarities", { Text = T("Forge rarities", "rarity แร่ที่ใช้หลอม"), Icon = "filter", Values = rarityNames })
        Count(owned, "KeepPerOre", { Text = T("Keep per ore", "เก็บแร่ไว้ชนิดละ"), Icon = "box", Min = 0, Max = 100000, Step = 10 })
    end

    local function BuildGear(window)
        local tab = window:AddTab(T("Gear", "อุปกรณ์"), "shield", T("Max gear, enhance, equip and sell", "อุปกรณ์สูงสุด ตีบวก ใส่ของ และขาย"))

        local gear = tab:AddLeftGroupbox(T("Max Gear", "อุปกรณ์สูงสุด"), "upgrade")
        Feature(gear, "MaxGear", {
            Text = T("Max Gear", "อุปกรณ์สูงสุด"),
            Description = T("Best gear, best runes, enhanced to your target", "ของดีสุด รูนดีสุด ตีบวกถึงเป้า"),
            Icon = "upgrade",
            Callback = function()
                State.GearForged = false
            end,
            Options = function(sub)
                Toggle(sub, "GearForge", { Text = T("Forge best gear", "หลอมของดีสุด"), Icon = "anvil" })
                Toggle(sub, "GearEnchant", { Text = T("Best runes", "ใส่รูนดีสุด"), Icon = "gem" })
                Toggle(sub, "GearEnhance", { Text = T("Enhance", "ตีบวก"), Icon = "plus" })
                sub:AddSlider("EnhanceTarget", {
                    Text = T("Enhance target", "ตีบวกถึง"),
                    Icon = "plus",
                    Min = 5, Max = 20, Default = opt.EnhanceTarget, Rounding = 0, Prefix = "+",
                    Callback = Store("EnhanceTarget"),
                })
            end,
        })
        opt.EnchantPriority = table.clone(Config.EnchantPriority)
        gear:AddPriorityList("EnchantPriority", {
            Text = T("Rune order", "ลำดับรูน"),
            Icon = "sort",
            Values = Config.EnchantPriority,
            Default = Config.EnchantPriority,
            Callback = Store("EnchantPriority"),
        })

        local enhance = tab:AddLeftGroupbox(T("Enhance", "ตีบวก"), "plus")
        enhance:AddSegmented("EnhanceSlot", {
            Text = T("Slot", "ช่อง"),
            Icon = "shield",
            Values = Config.GearTypes,
            Default = opt.EnhanceSlot,
            Callback = function(value)
                opt.EnhanceSlot = value or opt.EnhanceSlot
            end,
        })
        enhance:AddButton({ Text = T("Enhance To Target", "ตีบวกถึงเป้า"), Icon = "plus", Style = "Primary", Callback = LongAction("Enhance", function()
            return xDTaraZ.Gear.EnhanceSlot(opt.EnhanceSlot, opt.EnhanceTarget)
        end, function(level) return level and ("%s is +%d"):format(opt.EnhanceSlot, level) or "Nothing equipped there" end) })

        local equip = tab:AddRightGroupbox(T("Equip", "ใส่ของ"), "shield")
        Feature(equip, "AutoEquip", {
            Text = T("Auto Equip Best", "ใส่ของดีสุดอัตโนมัติ"),
            Description = T("Always wears your strongest gear", "ใส่ของที่แรงสุดเสมอ"),
            Icon = "shield",
            Now = { Text = T("Equip Best Now", "ใส่ของดีสุดเดี๋ยวนี้"), Icon = "check", Callback = function()
                task.spawn(function()
                    local changed = xDTaraZ.Gear.EquipBest()
                    Notify(changed > 0 and ("Equipped %d better item(s)"):format(changed) or "Already wearing your best gear")
                end)
            end },
        })

        local sell = tab:AddRightGroupbox(T("Sell", "ขาย"), "sell")
        Feature(sell, "AutoSell", {
            Text = T("Auto Sell", "ขายอัตโนมัติ"),
            Description = T("Equipped gear is never sold", "ของที่ใส่อยู่จะไม่ถูกขาย"),
            Icon = "sell",
            Now = { Text = T("Sell Now", "ขายเดี๋ยวนี้"), Icon = "money", Style = "Warning", Callback = Action(function()
                xDTaraZ.Sell.Run(xDTaraZ.Data.Get())
                Notify("Sold", "Coin")
            end) },
        })
        Chips(sell, "SellTypes", { Text = T("Sell types", "ประเภทที่ขาย"), Icon = "sword", Values = Config.GearTypes })
        Chips(sell, "SellRarities", { Text = T("Sell rarities", "rarity ที่ขาย"), Icon = "filter", Values = rarityNames })
        Count(sell, "KeepPerItem", {
            Text = T("Keep per item", "เก็บไว้ชิ้นละ"),
            Description = T("Highest enhance kept first", "เก็บตัวตีบวกสูงสุดก่อน"),
            Icon = "favorite",
            Min = 0, Max = 50, Step = 1,
        })
    end

    local function BuildIndex(window)
        local tab = window:AddTab(T("Index", "สมุดสะสม"), "list", T("Find every missing item", "หาของที่ยังไม่มีให้ครบ"))

        local hunt = tab:AddLeftGroupbox(T("Missing Gear", "อุปกรณ์ที่ยังไม่มี"), "search")
        Chips(hunt, "IndexTypes", { Text = T("Types", "ประเภท"), Icon = "filter", Values = Config.GearTypes })
        Pick(hunt, "MissingItem", {
            Text = T("Missing item", "ของที่ยังไม่มี"),
            Description = T("Chance shown is per forge with the best ore", "เปอร์เซ็นต์ = โอกาสต่อการหลอมหนึ่งครั้งด้วยแร่ที่ดีที่สุด"),
            Icon = "search",
            Source = function() return { "..." } end,
            NoSave = true,
        })
        task.spawn(function()
            local ok, labels = pcall(xDTaraZ.Index.Choices)
            if ok then Options.MissingItem:SetValues(labels) Options.MissingItem:SetValue(labels[1]) end
        end)
        hunt:AddButton({ Text = T("Get Selected", "หาชิ้นนี้"), Icon = "anvil", Style = "Primary", Callback = LongAction("Index", function()
            local gear = State.MissingLabels[opt.MissingItem]
            return gear and xDTaraZ.Index.Hunt(gear)
        end, function(got)
            task.spawn(function() Options.MissingItem:SetValues(xDTaraZ.Index.Choices()) end)
            return got and "Got it!" or "Not found this time, press again"
        end) })
        Refresh(hunt, "MissingItem", xDTaraZ.Index.Choices)

        local auto = tab:AddRightGroupbox(T("Complete Index", "เก็บสมุดสะสมให้ครบ"), "check")
        Feature(auto, "AutoIndex", {
            Text = T("Auto Complete Index", "เก็บสมุดสะสมอัตโนมัติ"),
            Description = T("Forges every missing weapon, armor and hat, then claims rewards", "หลอมอาวุธ เกราะ หมวกที่ยังไม่มีทุกชิ้น แล้วรับรางวัล"),
            Icon = "check",
            Risky = true,
        })
        auto:AddButton({ Text = T("Collect All Ores", "เก็บแร่ทุกชนิด"), Icon = "pickaxe", Callback = LongAction("Ores", xDTaraZ.Index.CollectOres, function()
            local count, level = xDTaraZ.Index.Progress()
            return ("Index %d, level %d"):format(count, level)
        end) })
        auto:AddButton({ Text = T("Claim Index Rewards", "รับรางวัลสมุดสะสม"), Icon = "trophy", Style = "Success", Callback = Action(xDTaraZ.Index.ClaimAll) })
    end

    local function BuildItems(window)
        local tab = window:AddTab(T("Items", "ไอเทม"), "gem", T("Spawn ore, runes and stones", "เสกแร่ รูน และหิน"))

        local spawn = tab:AddLeftGroupbox(T("Spawn Items", "เสกของ"), "gem")
        Pick(spawn, "SpawnItem", {
            Text = T("Item", "ของ"),
            Description = T("Any ore or enchant rune", "แร่หรือรูน enchant ชนิดไหนก็ได้"),
            Icon = "gem",
            Source = xDTaraZ.Spawn.Choices,
            NoSave = true,
        })
        spawn:AddInput("SpawnAmount", {
            Text = T("Amount", "จำนวน"),
            Icon = "plus",
            Default = tostring(opt.SpawnAmount),
            Numeric = true,
            Finished = true,
            Callback = function(value)
                opt.SpawnAmount = math.max(1, math.floor(tonumber(value) or opt.SpawnAmount))
            end,
        })
        spawn:AddButton({ Text = T("Spawn", "เสก"), Icon = "gem", Style = "Primary", Risky = true, Callback = function()
            local picked = State.SpawnLabels[opt.SpawnItem]
            if not picked then return Notify("Pick an item first", "Warn") end
            local label, amount = opt.SpawnItem, opt.SpawnAmount
            task.spawn(function()
                local ok = xDTaraZ.Spawn.Give(picked.id, picked.kind, amount)
                Notify(ok and ("Added %s %s"):format(xDTaraZ.Util.Abbreviate(amount), label) or "You need at least one of this rune first", ok and "Success" or "Warn")
            end)
        end })
        Refresh(spawn, "SpawnItem", xDTaraZ.Spawn.Choices)

        local stones = tab:AddRightGroupbox(T("Enhance Stones", "หินตีบวก"), "gem")
        stones:AddButton({ Text = T("Farm Enhance Stones", "ฟาร์มหินตีบวก"), Icon = "gem", Style = "Primary", Callback = LongAction("Stones", function()
            local before = xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "EnhantStone_1")
            xDTaraZ.Stage.FarmStones(xDTaraZ.Stage.Best())
            task.wait(0.5)
            return xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "EnhantStone_1") - before
        end, function(gained) return ("+%d enhance stones"):format(gained or 0) end) })
        stones:AddButton({ Text = T("Farm Rare Stones", "ฟาร์มหินตีบวกหายาก"), Icon = "loot", Callback = LongAction("Tower", function()
            local before = xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "EnhantStone_2")
            xDTaraZ.Tower.FarmStep()
            task.wait(0.5)
            return xDTaraZ.Data.Count(xDTaraZ.Data.Get(), "EnhantStone_2") - before
        end, function(gained) return ("+%d rare stones"):format(gained or 0) end) })
    end

    local function BuildLevel(window)
        window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local tab = window:AddTab(T("Level", "เลเวล"), "up", T("Training, rebirth, upgrades and race", "ฝึก รีเบิร์ธ อัปเกรด และเผ่า"))

        local train = tab:AddLeftGroupbox(T("Training", "ฝึก"), "power")
        Feature(train, "AutoTrain", {
            Text = T("Auto Train", "ฝึกอัตโนมัติ"),
            Description = T("Best training area nonstop, potions used", "ฝึกโซนดีสุดไม่หยุด ใช้ยาให้เอง"),
            Icon = "power",
            Callback = function(value)
                task.spawn(xDTaraZ.Util.Try, xDTaraZ.Level.SetTraining, value)
            end,
        })
        Feature(train, "AutoClick", {
            Text = T("Auto Click", "คลิกอัตโนมัติ"),
            Icon = "mouse",
            Callback = function(value)
                if value then xDTaraZ.Level.StartClicking() end
            end,
        })
        Feature(train, "AutoRebirth", {
            Text = T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"),
            Description = T("Rebirths as soon as your level allows", "รีเบิร์ธทันทีเมื่อเลเวลถึง"),
            Icon = "rebirth",
            Now = { Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Icon = "rebirth", Callback = Action(xDTaraZ.Level.Rebirth) },
        })

        local upgrade = tab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "upgrade")
        local upgradeNames = xDTaraZ.Upgrade.Names()
        opt.Upgrades = xDTaraZ.Util.AllSet(upgradeNames)
        Feature(upgrade, "AutoUpgrade", {
            Text = T("Auto Buy Upgrades", "ซื้ออัปเกรดอัตโนมัติ"),
            Icon = "buy",
            Now = { Text = T("Buy Now", "ซื้อเดี๋ยวนี้"), Icon = "money", Callback = Action(xDTaraZ.Upgrade.BuySelected) },
            Options = function(sub)
                sub:AddDropdown("Upgrades", {
                    Text = T("Upgrades to buy", "อัปเกรดที่จะซื้อ"),
                    Icon = "list",
                    Values = upgradeNames,
                    Multi = true,
                    Default = upgradeNames,
                    Searchable = #upgradeNames > 8,
                    Callback = Store("Upgrades"),
                })
            end,
        })

        local race = tab:AddRightGroupbox(T("Race", "เผ่า"), "egg")
        local raceLabels, raceIds = xDTaraZ.Race.Choices()
        opt.TargetRace = raceIds[raceLabels[1]]
        race:AddDropdown("TargetRace", {
            Text = T("Target race", "เผ่าที่ต้องการ"),
            Icon = "favorite",
            Values = raceLabels,
            Default = raceLabels[1],
            Searchable = #raceLabels > 8,
            Callback = function(value)
                opt.TargetRace = raceIds[value]
            end,
        })
        Feature(race, "AutoRace", {
            Text = T("Auto Roll Race", "สุ่มเผ่าอัตโนมัติ"),
            Description = T("Rolls until you get the chosen race", "สุ่มจนได้เผ่าที่เลือก"),
            Icon = "refresh",
            Callback = function(value)
                if not value then return end
                task.spawn(function()
                    local ok, outcome = pcall(xDTaraZ.Race.RollUntil, opt.TargetRace)
                    if ok and outcome == "got" then
                        Notify("Got the race!", "Success")
                    elseif ok and outcome == "empty" then
                        Notify("No race rolls left", "Warn")
                    end
                    Options.AutoRace:SetValue(false)
                end)
            end,
        })
        Feature(race, "AutoBestRace", {
            Text = T("Use Best Race Slot", "ใช้ช่องเผ่าที่ดีสุด"),
            Description = T("Switches to your rarest race", "สลับไปใช้เผ่าที่หายากที่สุด"),
            Icon = "crown",
            Now = { Text = T("Switch Now", "สลับเดี๋ยวนี้"), Icon = "check", Callback = Action(function()
                Notify(xDTaraZ.Race.EquipBest() and "Switched race slot" or "Already on your best race")
            end) },
        })
    end

    local function BuildRewards(window)
        local tab = window:AddTab(T("Rewards", "รางวัล"), "trophy", T("Free rewards, season and codes", "รางวัลฟรี ซีซั่น และโค้ด"))

        local rewards = tab:AddLeftGroupbox(T("Rewards", "รางวัล"), "trophy")
        Feature(rewards, "AutoClaim", {
            Text = T("Auto Claim", "รับรางวัลอัตโนมัติ"),
            Description = T("Offline, online, daily ticket, events, updates and index", "ออฟไลน์ ออนไลน์ ตั๋วรายวัน อีเวนต์ อัปเดต และสมุดสะสม"),
            Icon = "collect",
            Now = { Text = T("Claim Now", "รับเดี๋ยวนี้"), Icon = "trophy", Style = "Success", Callback = Action(xDTaraZ.Claim.All) },
        })

        local codes = tab:AddLeftGroupbox(T("Codes", "โค้ด"), "code")
        codes:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Icon = "code", Style = "Primary", Callback = Action(function()
            Library:Notify("Codes", xDTaraZ.Claim.AllCodes(), 6, "Success")
        end) })
        codes:AddInput("Code", {
            Text = T("Redeem Code", "ใส่โค้ด"),
            Icon = "code",
            Placeholder = T("Code", "โค้ด"),
            Finished = true,
            NoSave = true,
            Callback = function(value)
                if value == "" then return end
                task.spawn(function()
                    Library:Notify("Code", tostring(xDTaraZ.Claim.Code(value)), 4)
                end)
            end,
        })

        local season = tab:AddRightGroupbox(T("Season", "ซีซั่น"), "ticket")
        local goodLabels, goodIds = xDTaraZ.Season.Goods()
        local goodDefault = {}
        for label, goodId in pairs(goodIds) do
            if opt.SeasonGoods[goodId] then table.insert(goodDefault, label) end
        end
        Feature(season, "AutoSeason", {
            Text = T("Auto Season", "ซีซั่นอัตโนมัติ"),
            Description = T("Daily ticket, pass rewards, spins and shop", "ตั๋วรายวัน รางวัลพาส สุ่ม และร้าน"),
            Icon = "ticket",
            Now = { Text = T("Season Now", "ซีซั่นเดี๋ยวนี้"), Icon = "ticket", Callback = Action(xDTaraZ.Season.Step) },
            Options = function(sub)
                Toggle(sub, "SeasonSpin", { Text = T("Spin every ticket", "สุ่มตั๋วทุกใบ"), Icon = "refresh" })
                sub:AddDropdown("SeasonGoods", {
                    Text = T("Shop items to buy", "ของในร้านที่จะซื้อ"),
                    Icon = "buy",
                    Values = goodLabels,
                    Multi = true,
                    Default = goodDefault,
                    Searchable = #goodLabels > 8,
                    Callback = function(value)
                        local wanted = {}
                        for label, on in pairs(value) do
                            if on and goodIds[label] then wanted[goodIds[label]] = true end
                        end
                        opt.SeasonGoods = wanted
                    end,
                })
            end,
        })
    end

    local function BuildPlayer(window)
        window:AddTabSection(T("Misc", "อื่นๆ"))
        local tab = window:AddTab(T("Player", "ผู้เล่น"), "player", T("Movement and session", "การเคลื่อนที่ และเซสชัน"))

        local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "speed")
        Feature(move, "SpeedOn", {
            Text = T("Speed", "ความเร็ว"),
            Icon = "speed",
            Callback = xDTaraZ.Movement.Apply,
            Options = function(sub)
                sub:AddSlider("WalkSpeed", {
                    Text = T("Walk speed", "ความเร็วเดิน"),
                    Icon = "speed",
                    Min = 16, Max = 200, Default = opt.WalkSpeed, Rounding = 0,
                    Callback = Store("WalkSpeed", xDTaraZ.Movement.Apply),
                })
            end,
        })
        Feature(move, "InfJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด"), Icon = "infjump" })

        local guard = tab:AddLeftGroupbox(T("Survival", "เอาตัวรอด"), "shield")
        Feature(guard, "GodMode", {
            Text = T("Invincible", "อมตะ"),
            Description = T("Monsters and bosses can't kill you", "มอนสเตอร์และบอสฆ่าไม่ตาย"),
            Icon = "shield",
        })
        local keepOre = Feature(guard, "KeepOre", {
            Text = T("Keep Ore On Death", "ตายแล้วแร่ไม่หาย"),
            Icon = "gem",
            Callback = function(value)
                if value then xDTaraZ.Guard.HookOreLoss() end
            end,
        })
        Library.Kit.Caps.NeedCap(keepOre, "Hook")

        local session = tab:AddRightGroupbox(T("Session", "เซสชัน"), "server")
        Toggle(session, "AutoRejoin", { Text = T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), Description = T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"), Icon = "rejoin" })
        Toggle(session, "LowGraphics", { Text = T("FPS Boost", "เพิ่ม FPS"), Description = T("Turns off 3D rendering", "ปิดการแสดงผล 3D"), Icon = "fpsboost", Callback = xDTaraZ.Session.SetLowGraphics })
        session:AddButton({ Text = T("Rejoin Now", "เข้าเกมใหม่เดี๋ยวนี้"), Icon = "rejoin", Callback = Action(xDTaraZ.Session.Rejoin) })
    end

    local noteText = {
        EnhantStone_1 = "Farming enhance stones",
        EnhantStone_2 = "Farming rare enhance stones",
        Coin = "Farming coins",
        Enhancing = "Enhancing",
        NoTicket = "Need a tower ticket",
        Done = "Gear at target",
    }

    local function TaskText()
        if State.Lock == "Index" then return "Index: " .. (State.IndexNote or "planning"), "Running" end
        if State.Lock then return State.Lock, "Running" end
        if opt.MaxGear then return noteText[State.GearNote] or "Max Gear", State.GearNote == "NoTicket" and "Warn" or "Running" end
        return "Idle", "Idle"
    end

    local function UpdateLive()
        local ok, profile = pcall(xDTaraZ.Data.Get)
        if not (ok and profile) then return end
        local eco = profile.Eco
        Options.StatLevel:SetValue(eco.level)
        Options.StatRebirth:SetValue(eco.rebirth)
        Options.StatCoins:SetValue(eco.coin)
        Options.StatTowerLoot:SetValue(State.TowerLoot)
        Options.StatusGear:SetValue(xDTaraZ.Gear.EquippedNames(profile), "Idle")
        Options.StatusTask:SetValue(TaskText())
    end

    local function BuildTabs()
        local window = Library.Window
        RegisterIcons()
        BuildMain(window)
        BuildFarm(window)
        BuildBosses(window)
        BuildForge(window)
        BuildGear(window)
        BuildIndex(window)
        BuildItems(window)
        BuildLevel(window)
        BuildRewards(window)
        BuildPlayer(window)
        window:AddSettingsTab()

        task.spawn(function()
            while State.Alive do
                UpdateLive()
                task.wait(Config.StatusInterval)
            end
        end)
    end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    getgenv().LootToForgeUnload = function()
        Library:Unload()
    end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Loot To Forge by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            BuildTabs()
            xDTaraZ.Scheduler.Boot()
            Notify("Loaded", "Success")
            Library:LoadAutoloadConfig()
        end,
    })
end

if getgenv().LootToForgeUnload then
    pcall(getgenv().LootToForgeUnload)
end

MarioBanner.Step("Systems")
BuildInterface()
MarioBanner.Step("Interface")
MarioBanner.Ready()