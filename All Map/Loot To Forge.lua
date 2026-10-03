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
    LoaderUrl = "",
    TickDelay = 0.25,
    StatusInterval = 2,
    ForgePerTick = 10,
    RefillAmount = 100000,
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
    IndexForgeRecipes = {
        { forgeType = "Weapon", ores = 4 },
        { forgeType = "Weapon", ores = 13 },
        { forgeType = "Armor", ores = 4 },
        { forgeType = "Armor", ores = 11 },
        { forgeType = "Armor", ores = 13 },
    },
    IndexLevelClaims = 50,
    ClaimIdScan = 20,
    ClaimInterval = 30,
    UpgradeInterval = 5,
    TrainRejoinDelay = 0.3,
    TrainAcceptWait = 1.5,
    KillAuraInterval = 0.25,
    KillDamage = 1e30,
    RaceRollDelay = 1.2,
    RejoinDelay = 5,
    Codes = { "30000CCU", "20000CCU" },
    EquipInterval = 3,
    KaitunToggles = { "MaxGear", "AutoEquip", "AutoForge", "AutoSell", "AutoTrain", "AutoRebirth", "AutoUpgrade", "AutoClaim", "KillAura", "SuperLootAura" },
}

local Config = xDTaraZ.Config

xDTaraZ.State = {
    Alive = true,
    Busy = false,
    GearBusy = false,
    InTower = false,
    Entering = false,
    GearForged = false,
    TrainArea = nil,
    LastClaim = 0,
    LastUpgrade = 0,
    LastEquip = 0,
    Profile = nil,
    GearNote = nil,
    TowerLoot = 0,
    OreLabels = {},
    OreStage = {},
    Conns = {},
    Opt = {
        MaxGear = false,
        AutoEquip = false,
        EnhanceTarget = 10,
        CollectOre = false,
        Stage = nil,
        CollectRarities = {},
        KillAura = false,
        SuperLootAura = false,
        AutoForge = false,
        ForgeTarget = "Great Weapon",
        ForgeRarities = {},
        KeepPerOre = 0,
        BestOreFirst = false,
        InfiniteOre = false,
        AutoSell = false,
        SellTypes = { Weapon = true, Armor = true, Hat = true },
        SellRarities = {},
        KeepPerItem = 1,
        AutoTrain = false,
        AutoClick = false,
        AutoRebirth = false,
        AutoUpgrade = false,
        Upgrades = {},
        AutoClaim = false,
        AutoTower = false,
        AutoRace = false,
        TargetRace = nil,
        SpawnOre = nil,
        SpawnAmount = 100000,
        SpeedOn = false,
        WalkSpeed = 60,
        InfJump = false,
        AutoRejoin = false,
        LowGraphics = false,
    },
}

local State = xDTaraZ.State

for _, name in ipairs({ "Util", "Data", "Stage", "Ore", "Forge", "Sell", "Gear", "Level", "Upgrade", "Tower", "Index", "Claim", "SuperLoot", "Combat", "Race", "Movement", "Session", "Scheduler" }) do
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
        if not name then
            break
        end
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
    table.sort(ores, function(a, b)
        return a.tier > b.tier
    end)
    return ores
end

function xDTaraZ.Ore.Choices()
    local oreShow = require(GameConfig.Ore.Show)
    local ids = {}
    for oreId in pairs(require(GameConfig.Ore.Config)) do
        table.insert(ids, oreId)
    end
    table.sort(ids, function(a, b)
        return xDTaraZ.Util.Tier(a) > xDTaraZ.Util.Tier(b)
    end)

    local labels, idByLabel = {}, {}
    for _, oreId in ipairs(ids) do
        local label = oreShow[oreId] and oreShow[oreId].DisplayName or oreId
        if idByLabel[label] then
            label = ("%s (%d)"):format(label, xDTaraZ.Util.Tier(oreId))
        end
        idByLabel[label] = oreId
        table.insert(labels, label)
    end
    State.OreLabels = idByLabel
    return labels
end

function xDTaraZ.Ore.Add(uuid, amount)
    xDTaraZ.Util.Remote("Backpack", "TrySellItemRE"):FireServer(uuid, -math.abs(amount))
end

function xDTaraZ.Ore.Spawn(oreId, amount)
    local uuid = xDTaraZ.Data.Uuid(xDTaraZ.Data.Get(), oreId)
    if not uuid and xDTaraZ.Stage.AcquireOre(oreId) then
        task.wait(0.5)
        uuid = xDTaraZ.Data.Uuid(xDTaraZ.Data.Get(), oreId)
    end
    if not uuid then
        return false
    end
    xDTaraZ.Ore.Add(uuid, amount)
    return true
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

function xDTaraZ.Stage.List()
    local stages = {}
    for stageId in pairs(require(GameConfig.Stage.Helper).GetStageEnemyConfig()) do
        table.insert(stages, stageId)
    end
    table.sort(stages, function(a, b)
        return xDTaraZ.Util.Tier(a) > xDTaraZ.Util.Tier(b)
    end)
    return stages
end

function xDTaraZ.Stage.Best()
    return xDTaraZ.Stage.List()[1]
end

function xDTaraZ.Stage.Collect(stageId, rarities)
    local drops = xDTaraZ.Util.Remote("Stage", "StageFinishedRF"):InvokeServer(stageId)
    if type(drops) ~= "table" then
        return
    end
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
        if a == known or b == known then
            return a == known
        end
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
    local stageUtils = require(LocalPlayer.PlayerScripts.Manager.StageManager.StageUtils)
    stageUtils.ExitFight(true)
end

function xDTaraZ.Forge.Target()
    for _, target in ipairs(Config.ForgeTargets) do
        if target.name == State.Opt.ForgeTarget then
            return target
        end
    end
    return Config.ForgeTargets[1]
end

function xDTaraZ.Forge.PickOres(profile, count)
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
        table.sort(candidates, function(a, b)
            return a.tier < b.tier
        end)
    end
    if opt.InfiniteOre and candidates[1] and candidates[1].spare < count then
        xDTaraZ.Ore.Add(candidates[1].uuid, Config.RefillAmount)
        candidates[1].spare += Config.RefillAmount
    end

    local pick, need = {}, count
    for _, ore in ipairs(candidates) do
        if need <= 0 then
            break
        end
        local take = math.min(need, ore.spare)
        pick[ore.uuid] = take
        need -= take
    end
    return need <= 0 and pick or nil
end

function xDTaraZ.Forge.Run(forgeType, oreList)
    return xDTaraZ.Util.Remote("Forge", "ForgeRF"):InvokeServer({ ConfigType = forgeType, UUIDList = oreList })
end

function xDTaraZ.Forge.Once()
    local target = xDTaraZ.Forge.Target()
    local pick = xDTaraZ.Forge.PickOres(xDTaraZ.Data.Get(), target.ores)
    return pick ~= nil and xDTaraZ.Forge.Run(target.forgeType, pick) ~= nil
end

function xDTaraZ.Forge.Step()
    for _ = 1, Config.ForgePerTick do
        if not xDTaraZ.Forge.Once() then
            break
        end
    end
end

function xDTaraZ.Sell.Rarity(entry)
    local folder = entry.Type == "Weapon" and "Weapon" or "Armor"
    local itemConfig = require(GameConfig[folder].Config)[entry.ID]
    return itemConfig and itemConfig.Rarity
end

function xDTaraZ.Sell.Run(profile, onlyUuids)
    local opt = State.Opt
    local equipped = {}
    for _, uuid in pairs(profile.Backpack.equiped) do
        equipped[uuid] = true
    end

    local byId = {}
    for uuid, entry in pairs(profile.Backpack.have) do
        if opt.SellTypes[entry.Type] and not equipped[uuid] and (not onlyUuids or onlyUuids[uuid]) then
            byId[entry.ID] = byId[entry.ID] or {}
            table.insert(byId[entry.ID], { uuid = uuid, entry = entry })
        end
    end

    local sell = xDTaraZ.Util.Remote("Backpack", "TrySellItemRE")
    for _, items in pairs(byId) do
        table.sort(items, function(a, b)
            return (a.entry.Level or 0) > (b.entry.Level or 0)
        end)
        local keep = onlyUuids and 0 or opt.KeepPerItem
        for index, item in ipairs(items) do
            if index > keep and opt.SellRarities[xDTaraZ.Sell.Rarity(item.entry)] then
                sell:FireServer(item.uuid, 1)
            end
        end
    end
end

---@return number  gear power, enchants only break ties
function xDTaraZ.Gear.Score(entry)
    local helper = require(entry.Type == "Weapon" and GameConfig.Weapon.Helper or GameConfig.Armor.Helper)
    local ok, base = pcall(helper.GetMainAffix, entry.ID)
    if not ok or type(base) ~= "number" then
        return 0
    end
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
    State.GearBusy = true
    local before = {}
    for uuid in pairs(xDTaraZ.Data.Get().Backpack.have) do
        before[uuid] = true
    end

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
    local profile = xDTaraZ.Data.Get()
    local created = {}
    for uuid in pairs(profile.Backpack.have) do
        if not before[uuid] then
            created[uuid] = true
        end
    end
    local savedTypes, savedRarities = State.Opt.SellTypes, State.Opt.SellRarities
    State.Opt.SellTypes = xDTaraZ.Util.AllSet(Config.GearTypes)
    State.Opt.SellRarities = xDTaraZ.Util.AllSet(xDTaraZ.Util.RarityNames())
    xDTaraZ.Sell.Run(profile, created)
    State.Opt.SellTypes, State.Opt.SellRarities = savedTypes, savedRarities
    State.GearBusy = false
end

function xDTaraZ.Gear.MissingForEnhance(profile, level)
    local cost = require(GameConfig.Enhant.Config)[level + 1]
    if not cost then
        return nil
    end
    if xDTaraZ.Data.Count(profile, "EnhantStone_2") < (cost.EnhantStone_2 or 0) then
        return "EnhantStone_2"
    end
    if xDTaraZ.Data.Count(profile, "EnhantStone_1") < (cost.EnhantStone_1 or 0) then
        return "EnhantStone_1"
    end
    if profile.Eco.coin < (cost.NeedCoin or 0) then
        return "Coin"
    end
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

function xDTaraZ.Gear.Enchant(profile, uuid)
    local entry = profile.Backpack.have[uuid]
    local used = {}
    for slot = 1, entry.EnchanceNum or 0 do
        local current = entry.EnchanceList and entry.EnchanceList[slot]
        local currentId = current and current.ID
        local wanted
        for _, stoneId in ipairs(Config.EnchantPriority) do
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
            for _ = 1, Config.GearEnhanceTries do
                if not enhance:InvokeServer(uuid, { UseProtect = false }) then
                    break
                end
                local current = xDTaraZ.Data.Get().Backpack.have[uuid]
                if not current or (current.Level or 0) >= target then
                    break
                end
            end
            return false
        end
    end
    return true
end

function xDTaraZ.Gear.HasEnchantStone(profile)
    for _, stoneId in ipairs(Config.EnchantPriority) do
        if xDTaraZ.Data.Count(profile, stoneId) > 0 then
            return true
        end
    end
    return false
end

function xDTaraZ.Gear.MaxStep()
    if not State.GearForged then
        xDTaraZ.Gear.ForgeBest()
        State.GearForged = true
    end
    local profile = xDTaraZ.Data.Get()
    if not xDTaraZ.Gear.HasEnchantStone(profile) then
        xDTaraZ.Gear.Gather("EnchStone")
        profile = xDTaraZ.Data.Get()
    end
    for _, spec in ipairs(Config.GearSlots) do
        local uuid = profile.Backpack.equiped[spec.slot]
        if uuid then
            xDTaraZ.Gear.Enchant(profile, uuid)
        end
    end
    if xDTaraZ.Gear.Enhance(xDTaraZ.Data.Get()) then
        State.GearNote = "Done"
    end
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

function xDTaraZ.Level.FindBestArea()
    local areas = require(GameConfig.TrainArea.Config)
    local ids = {}
    for areaId in pairs(areas) do
        table.insert(ids, tonumber(areaId))
    end
    table.sort(ids, function(a, b)
        return areas[a].Basic > areas[b].Basic
    end)

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
        if not State.Opt.AutoTrain or LocalPlayer:GetAttribute("AutoTrainAreaID") then
            return
        end
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
        if selected then
            buy:FireServer(name)
        end
    end
end

function xDTaraZ.Tower.LastRound()
    return xDTaraZ.Util.Tier(xDTaraZ.Util.HighestKey(require(GameConfig.Dungeon.Config)))
end

function xDTaraZ.Tower.Enter()
    while State.Entering do
        task.wait(0.1)
    end
    if State.InTower then
        return true
    end
    State.Entering = true
    local ok, entered = pcall(function()
        return xDTaraZ.Util.Remote("Dungeon", "TryIntoDungeonRF"):InvokeServer(1)
    end)
    State.Entering = false
    State.InTower = ok and entered and true or false
    return State.InTower
end

function xDTaraZ.Tower.Exit()
    if not State.InTower then
        return
    end
    State.InTower = false
    xDTaraZ.Util.Remote("Dungeon", "ExitDungeonRE"):FireServer()
end

function xDTaraZ.Tower.FarmStep()
    if not xDTaraZ.Tower.Enter() then
        return false
    end
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
        if not claimLevel:InvokeServer() then
            break
        end
    end
end

function xDTaraZ.Index.Unlocked()
    local index = xDTaraZ.Data.Get().Index
    local unlocked = 0
    for _ in pairs(index.unlocked) do
        unlocked += 1
    end
    return unlocked, index.level
end

function xDTaraZ.Index.UnlockAll()
    State.GearBusy = true
    local before = {}
    for uuid in pairs(xDTaraZ.Data.Get().Backpack.have) do
        before[uuid] = true
    end
    for _, stageId in ipairs(xDTaraZ.Stage.List()) do
        xDTaraZ.Stage.Collect(stageId, nil)
    end
    for _, ore in ipairs(xDTaraZ.Ore.Owned(xDTaraZ.Data.Get())) do
        xDTaraZ.Ore.Add(ore.uuid, 100)
        task.wait(0.2)
        for _, recipe in ipairs(Config.IndexForgeRecipes) do
            xDTaraZ.Forge.Run(recipe.forgeType, { [ore.uuid] = recipe.ores })
        end
    end
    task.wait(1)

    local profile = xDTaraZ.Data.Get()
    local created = {}
    for uuid, entry in pairs(profile.Backpack.have) do
        if not before[uuid] and entry.Type ~= "Ore" then
            created[uuid] = true
        end
    end
    local savedTypes, savedRarities = State.Opt.SellTypes, State.Opt.SellRarities
    State.Opt.SellTypes = xDTaraZ.Util.AllSet(Config.GearTypes)
    State.Opt.SellRarities = xDTaraZ.Util.AllSet(xDTaraZ.Util.RarityNames())
    xDTaraZ.Sell.Run(profile, created)
    State.Opt.SellTypes, State.Opt.SellRarities = savedTypes, savedRarities
    State.GearBusy = false
    xDTaraZ.Index.ClaimAll()
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

function xDTaraZ.Race.Choices()
    local classConfig = require(GameConfig.Class.Config)
    local show = require(GameConfig.Class.Show)
    local ids = {}
    for classId in pairs(classConfig) do
        table.insert(ids, classId)
    end
    table.sort(ids, function(a, b)
        return classConfig[a].Weight < classConfig[b].Weight
    end)

    local labels, idByLabel = {}, {}
    for _, classId in ipairs(ids) do
        local label = ("%s (%s)"):format(show[classId] and show[classId].DisplayName or classId, classConfig[classId].Rarity)
        idByLabel[label] = classId
        table.insert(labels, label)
    end
    return labels, idByLabel
end

function xDTaraZ.Race.RollUntil(targetId)
    local roll = xDTaraZ.Util.Remote("Class", "LuckOnceRE")
    while State.Opt.AutoRace do
        local classData = xDTaraZ.Data.Get().Class
        if classData.have[classData.equiped] == targetId then
            return "got"
        end
        if (classData.luckTimes or 0) <= 0 then
            return "empty"
        end
        roll:FireServer(tostring(classData.equiped))
        task.wait(Config.RaceRollDelay)
    end
    return "stopped"
end

function xDTaraZ.Movement.Humanoid()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end

function xDTaraZ.Movement.Apply()
    local humanoid = xDTaraZ.Movement.Humanoid()
    if humanoid then
        humanoid.WalkSpeed = State.Opt.SpeedOn and State.Opt.WalkSpeed or (LocalPlayer:GetAttribute("OriWalkSpeed") or 22)
    end
end

function xDTaraZ.Movement.Bind()
    table.insert(State.Conns, UserInputService.JumpRequest:Connect(function()
        local humanoid = xDTaraZ.Movement.Humanoid()
        if State.Opt.InfJump and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
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
    if Config.LoaderUrl ~= "" and queue_on_teleport then
        queue_on_teleport(("loadstring(game:HttpGet(%q))()"):format(Config.LoaderUrl))
    end
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

function xDTaraZ.Session.Bind()
    table.insert(State.Conns, LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end))
    table.insert(State.Conns, GuiService.ErrorMessageChanged:Connect(function(message)
        if State.Opt.AutoRejoin and message ~= "" then
            task.delay(Config.RejoinDelay, xDTaraZ.Session.Rejoin)
        end
    end))
end

function xDTaraZ.Scheduler.Step()
    local opt = State.Opt
    if State.GearBusy then
        return
    end
    if opt.MaxGear then
        xDTaraZ.Gear.MaxStep()
    end
    if opt.CollectOre then
        xDTaraZ.Stage.Collect(opt.Stage or xDTaraZ.Stage.Best(), opt.CollectRarities)
    end
    if opt.AutoForge then
        xDTaraZ.Forge.Step()
    end
    if opt.AutoEquip and os.clock() - State.LastEquip > Config.EquipInterval then
        State.LastEquip = os.clock()
        xDTaraZ.Gear.EquipBest()
    end
    if opt.AutoSell then
        xDTaraZ.Sell.Run(xDTaraZ.Data.Get())
    end
    if opt.AutoTrain then
        xDTaraZ.Level.TrainStep()
    end
    if opt.AutoRebirth then
        xDTaraZ.Level.RebirthStep()
    end
    if opt.AutoUpgrade and os.clock() - State.LastUpgrade > Config.UpgradeInterval then
        State.LastUpgrade = os.clock()
        xDTaraZ.Upgrade.BuySelected()
    end
    if opt.AutoTower then
        xDTaraZ.Tower.FarmStep()
    elseif State.InTower and not opt.MaxGear then
        xDTaraZ.Tower.Exit()
    end
    if opt.AutoClaim and os.clock() - State.LastClaim > Config.ClaimInterval then
        State.LastClaim = os.clock()
        xDTaraZ.Claim.All()
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
            xDTaraZ.Util.Try(action)
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
        local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status, Kaitun and rewards", "สถานะ ไก่ตัน และรางวัล"))

        local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "stats")
        status:AddStatus("StatusGear", { Text = T("Gear", "อุปกรณ์"), Icon = "sword" })
        status:AddStatus("StatusTask", { Text = T("Max Gear", "อุปกรณ์สูงสุด"), Icon = "upgrade" })

        local live = tab:AddLeftGroupbox(T("Live", "ตัวเลขสด"), "chart")
        live:AddStat("StatLevel", { Text = T("Level", "เลเวล"), Icon = "up", Format = "%s" })
        live:AddStat("StatRebirth", { Text = T("Rebirth", "รีเบิร์ธ"), Icon = "rebirth", Format = "%s" })
        live:AddStat("StatCoins", { Text = T("Coins", "เหรียญ"), Icon = "coin", Format = function(coins) return xDTaraZ.Util.Abbreviate(math.floor(coins)) end, Token = "Coin" })
        live:AddStat("StatTowerLoot", { Text = T("Tower loot", "ของจากหอคอย"), Icon = "loot", Format = "%s", Token = "Good" })

        local kaitun = tab:AddLeftGroupbox(T("Kaitun", "ไก่ตัน"), "crown")
        kaitun:AddFeature("Kaitun", {
            Text = T("Kaitun", "ไก่ตัน"),
            Description = T("Best gear, money, level, upgrades, rewards and ore bosses at once", "ของดีสุด เงิน เลเวล อัปเกรด รางวัล และบอสแร่ พร้อมกันทั้งหมด"),
            Icon = "crown",
            NoSave = true,
            Keybind = { Default = "None", Mode = "Toggle" },
            Callback = function(value)
                for _, key in ipairs(Config.KaitunToggles) do
                    Options[key]:SetValue(value)
                end
            end,
        })

        Library.Kit.Discord.Build(tab, Config.Discord)

        local quick = tab:AddRightGroupbox(T("Quick", "ด่วน"), "lightning")
        quick:AddButton({ Text = T("Panic - All Off", "ฉุกเฉิน ปิดทั้งหมด"), Icon = "stop", Style = "Danger", Callback = function()
            for _, toggle in pairs(Library.Toggles) do
                if toggle.Value == true then toggle:SetValue(false) end
            end
        end })

        local rewards = tab:AddRightGroupbox(T("Rewards", "รางวัล"), "trophy")
        Feature(rewards, "AutoClaim", {
            Text = T("Auto Claim", "รับรางวัลอัตโนมัติ"),
            Description = T("Every free reward, index included", "รางวัลฟรีทุกอย่าง รวมสมุดสะสม"),
            Icon = "collect",
            Now = { Text = T("Claim Now", "รับเดี๋ยวนี้"), Icon = "trophy", Style = "Success", Callback = Action(xDTaraZ.Claim.All) },
        })
        rewards:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Icon = "code", Style = "Primary", Callback = function()
            Library:Notify("Codes", xDTaraZ.Claim.AllCodes(), 6, "Success")
        end })
        rewards:AddInput("Code", {
            Text = T("Redeem Code", "ใส่โค้ด"),
            Icon = "edit",
            Placeholder = T("Code", "โค้ด"),
            Finished = true,
            NoSave = true,
            Callback = function(value)
                if value ~= "" then
                    Library:Notify("Code", tostring(xDTaraZ.Claim.Code(value)), 4)
                end
            end,
        })
    end

    local function BuildFarm(window)
        window:AddTabSection(T("Farming", "ฟาร์ม"))
        local tab = window:AddTab(T("Farm", "ฟาร์ม"), "autofarm", T("Stages, ore, monsters and tower", "ด่าน แร่ มอนสเตอร์ และหอคอย"))

        local stage = tab:AddLeftGroupbox(T("Stage", "ด่าน"), "map")
        local stageList = xDTaraZ.Stage.List()
        opt.Stage = stageList[1]
        stage:AddDropdown("Stage", {
            Text = T("Stage", "ด่าน"),
            Description = T("Any stage, no unlock needed", "ด่านไหนก็ได้ ไม่ต้องปลดล็อก"),
            Icon = "map",
            Values = stageList,
            Default = stageList[1],
            Searchable = true,
            Callback = Store("Stage"),
        })
        Refresh(stage, "Stage", xDTaraZ.Stage.List)
        Feature(stage, "CollectOre", {
            Text = T("Auto Collect Ore", "เก็บแร่อัตโนมัติ"),
            Description = T("Clears the stage and collects its ores nonstop", "เคลียร์ด่านแล้วเก็บแร่ไม่หยุด"),
            Icon = "pickaxe",
            Options = function(sub)
                Chips(sub, "CollectRarities", { Text = T("Collect rarities", "rarity ที่เก็บ"), Icon = "filter", Values = rarityNames })
            end,
        })

        local index = tab:AddLeftGroupbox(T("Index", "สมุดสะสม"), "list")
        index:AddButton({
            Text = T("Complete Index", "เก็บสมุดสะสมให้ครบ"),
            Description = T("Every ore and gear type, then all index rewards", "แร่และอุปกรณ์ทุกชนิด แล้วรับรางวัลสมุดสะสมทั้งหมด"),
            Icon = "check",
            Style = "Primary",
            Callback = function()
                if State.GearBusy then return end
                Notify("Completing index...")
                local before = xDTaraZ.Index.Unlocked()
                xDTaraZ.Util.Try(xDTaraZ.Index.UnlockAll)
                State.GearBusy = false
                local after, level = xDTaraZ.Index.Unlocked()
                Notify(("Index +%d (total %d, level %d)"):format(after - before, after, level), "Success")
            end,
        })

        local combat = tab:AddRightGroupbox(T("Combat", "ต่อสู้"), "sword")
        Feature(combat, "KillAura", {
            Text = T("Instant Kill", "ฆ่าทันที"),
            Description = T("Every monster in your stage dies instantly", "มอนสเตอร์ทุกตัวในด่านตายทันที"),
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

        local tower = tab:AddRightGroupbox(T("Tower", "หอคอย"), "shield")
        Feature(tower, "AutoTower", {
            Text = T("Auto Farm Tower", "ฟาร์มหอคอยอัตโนมัติ"),
            Description = T("Tower loot nonstop on a single ticket", "ฟาร์มของหอคอยไม่หยุดด้วยตั๋วใบเดียว"),
            Icon = "loot",
            Callback = function(value)
                local ok, entered = pcall(function()
                    return not value or xDTaraZ.Tower.Enter()
                end)
                if not (ok and entered) then Notify("No tower ticket", "Warn") end
            end,
        })
        tower:AddButton({ Text = T("Exit Tower Now", "ออกจากหอคอยเดี๋ยวนี้"), Icon = "close", Style = "Warning", Callback = function()
            Options.AutoTower:SetValue(false)
            xDTaraZ.Util.Try(xDTaraZ.Tower.Exit)
        end })
    end

    local function BuildForge(tab)
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
        Feature(forge, "AutoForge", {
            Text = T("Auto Forge", "หลอมอัตโนมัติ"),
            Description = T("Forges the target gear nonstop", "หลอมอุปกรณ์ที่เลือกไม่หยุด"),
            Icon = "anvil",
            Now = { Text = T("Forge Now", "หลอมเดี๋ยวนี้"), Icon = "fire", Callback = function()
                Notify(xDTaraZ.Forge.Once() and "Forged" or "Not enough ore")
            end },
        })

        local ore = tab:AddLeftGroupbox(T("Ore Usage", "การใช้แร่"), "gem")
        Toggle(ore, "InfiniteOre", {
            Text = T("Infinite Ore", "แร่ไม่จำกัด"),
            Description = T("Your best ore refills itself while forging", "แร่ที่ดีที่สุดเติมเองระหว่างหลอม"),
            Icon = "gem",
            Risky = true,
            Badge = T("Risky", "เสี่ยง"),
        })
        Toggle(ore, "BestOreFirst", {
            Text = T("Spend Best Ore First", "ใช้แร่ดีสุดก่อน"),
            Description = T("Off = weakest ore first", "ปิด = ใช้แร่อ่อนสุดก่อน"),
            Icon = "sort",
        })
        Chips(ore, "ForgeRarities", { Text = T("Forge rarities", "rarity แร่ที่ใช้หลอม"), Icon = "filter", Values = rarityNames })
        Count(ore, "KeepPerOre", { Text = T("Keep per ore", "เก็บแร่ไว้ชนิดละ"), Icon = "box", Min = 0, Max = 100000, Step = 10 })
    end

    local function BuildGear(window)
        local tab = window:AddTab(T("Gear", "อุปกรณ์"), "anvil", T("Max gear, forging and selling", "อุปกรณ์สูงสุด หลอม และขาย"))
        BuildForge(tab)

        local gear = tab:AddRightGroupbox(T("Max Gear", "อุปกรณ์สูงสุด"), "upgrade")
        Feature(gear, "MaxGear", {
            Text = T("Max Gear", "อุปกรณ์สูงสุด"),
            Description = T("Best weapon, armor and hat with top enchants, enhanced to your target", "อาวุธ เกราะ หมวกดีสุด enchant ดีสุด ตีบวกถึงเป้า"),
            Icon = "upgrade",
            Callback = function()
                State.GearForged = false
            end,
            Options = function(sub)
                sub:AddSlider("EnhanceTarget", {
                    Text = T("Enhance target", "ตีบวกถึง"),
                    Description = T("Above +10 it can take a long time", "เกิน +10 อาจใช้เวลานาน"),
                    Icon = "plus",
                    Min = 5, Max = 20, Default = opt.EnhanceTarget, Rounding = 0, Prefix = "+",
                    Callback = Store("EnhanceTarget"),
                })
            end,
        })
        Feature(gear, "AutoEquip", {
            Text = T("Auto Equip Best", "ใส่ของดีสุดอัตโนมัติ"),
            Description = T("Always wears your strongest gear, enhance counted", "ใส่ของที่แรงสุดเสมอ นับระดับตีบวกด้วย"),
            Icon = "shield",
            Now = { Text = T("Equip Best Now", "ใส่ของดีสุดเดี๋ยวนี้"), Icon = "check", Callback = function()
                local changed = xDTaraZ.Gear.EquipBest()
                Notify(changed > 0 and ("Equipped %d better item(s)"):format(changed) or "Already wearing your best gear")
            end },
        })

        local sell = tab:AddRightGroupbox(T("Sell", "ขาย"), "sell")
        Feature(sell, "AutoSell", {
            Text = T("Auto Sell", "ขายอัตโนมัติ"),
            Description = T("Equipped gear is never sold", "ของที่ใส่อยู่จะไม่ถูกขาย"),
            Icon = "sell",
            Now = { Text = T("Sell Now", "ขายเดี๋ยวนี้"), Icon = "money", Style = "Warning", Callback = function()
                xDTaraZ.Sell.Run(xDTaraZ.Data.Get())
                Notify("Sold", "Coin")
            end },
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

    local function BuildProgress(window)
        window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local tab = window:AddTab(T("Progress", "ความคืบหน้า"), "up", T("Training, rebirth, upgrades and ore", "ฝึก รีเบิร์ธ อัปเกรด และแร่"))

        local train = tab:AddLeftGroupbox(T("Training", "ฝึก"), "power")
        Feature(train, "AutoTrain", {
            Text = T("Auto Train", "ฝึกอัตโนมัติ"),
            Description = T("Trains at the x100 area nonstop", "ฝึกที่โซน x100 ไม่หยุด"),
            Icon = "power",
            Callback = function(value)
                task.spawn(xDTaraZ.Util.Try, xDTaraZ.Level.SetTraining, value)
            end,
        })
        Feature(train, "AutoClick", {
            Text = T("Auto Click", "คลิกอัตโนมัติ"),
            Description = T("As fast as the game allows", "เร็วสุดเท่าที่เกมยอม"),
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
        Feature(upgrade, "AutoUpgrade", {
            Text = T("Auto Buy Upgrades", "ซื้ออัปเกรดอัตโนมัติ"),
            Icon = "buy",
            Now = { Text = T("Buy Now", "ซื้อเดี๋ยวนี้"), Icon = "money", Callback = Action(xDTaraZ.Upgrade.BuySelected) },
        })
        local upgradeNames = xDTaraZ.Upgrade.Names()
        opt.Upgrades = xDTaraZ.Util.AllSet(upgradeNames)
        upgrade:AddDropdown("Upgrades", {
            Text = T("Upgrades to buy", "อัปเกรดที่จะซื้อ"),
            Icon = "list",
            Values = upgradeNames,
            Multi = true,
            Default = upgradeNames,
            Searchable = #upgradeNames > 8,
            Callback = Store("Upgrades"),
        })
        Refresh(upgrade, "Upgrades", xDTaraZ.Upgrade.Names)

        local spawn = tab:AddRightGroupbox(T("Spawn Ore", "เสกแร่"), "gem")
        local oreLabels = xDTaraZ.Ore.Choices()
        opt.SpawnOre = oreLabels[1]
        spawn:AddDropdown("SpawnOre", {
            Text = T("Ore", "แร่"),
            Description = T("Any ore, even ones you never had", "แร่ทุกชนิด แม้ยังไม่เคยได้"),
            Icon = "gem",
            Values = oreLabels,
            Default = oreLabels[1],
            Searchable = true,
            NoSave = true,
            Callback = Store("SpawnOre"),
        })
        Refresh(spawn, "SpawnOre", xDTaraZ.Ore.Choices)
        spawn:AddInput("SpawnAmount", {
            Text = T("Amount", "จำนวน"),
            Icon = "plus",
            Default = tostring(opt.SpawnAmount),
            Numeric = true,
            Finished = true,
            Callback = function(value)
                opt.SpawnAmount = math.max(0, tonumber(value) or opt.SpawnAmount)
            end,
        })
        spawn:AddButton({ Text = T("Spawn", "เสก"), Icon = "gem", Style = "Primary", Risky = true, Callback = function()
            local oreId = State.OreLabels[opt.SpawnOre]
            if not oreId then return Notify("Pick an ore first", "Warn") end
            local label, amount = opt.SpawnOre, opt.SpawnAmount
            Notify(xDTaraZ.Ore.Spawn(oreId, amount) and ("Added %s %s"):format(xDTaraZ.Util.Abbreviate(amount), label) or "Could not find this ore, try again")
        end })
    end

    local function BuildPlayer(window)
        window:AddTabSection(T("Misc", "อื่นๆ"))
        local tab = window:AddTab(T("Player", "ผู้เล่น"), "player", T("Race, movement and session", "เผ่า การเคลื่อนที่ และเซสชัน"))

        local race = tab:AddLeftGroupbox(T("Race", "เผ่า"), "egg")
        local raceLabels, raceIds = xDTaraZ.Race.Choices()
        opt.TargetRace = raceIds[raceLabels[1]]
        race:AddDropdown("TargetRace", {
            Text = T("Target race", "เผ่าที่ต้องการ"),
            Icon = "favorite",
            Values = raceLabels,
            Default = raceLabels[1],
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

        local move = tab:AddRightGroupbox(T("Movement", "การเคลื่อนที่"), "speed")
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

        local session = tab:AddRightGroupbox(T("Session", "เซสชัน"), "server")
        Toggle(session, "AutoRejoin", { Text = T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), Description = T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"), Icon = "rejoin" })
        Toggle(session, "LowGraphics", { Text = T("FPS Boost", "เพิ่ม FPS"), Description = T("Turns off 3D rendering to save CPU and GPU", "ปิดการแสดงผล 3D ประหยัด CPU/GPU"), Icon = "fpsboost", Callback = xDTaraZ.Session.SetLowGraphics })
    end

    local noteText = {
        EnhantStone_1 = "Farming enhance stones",
        EnhantStone_2 = "Farming rare enhance stones",
        EnchStone = "Farming enchant stones",
        Coin = "Farming coins",
        Enhancing = "Enhancing",
        NoTicket = "Need a tower ticket",
        Done = "All at target",
    }

    local function UpdateLive()
        local ok, profile = pcall(xDTaraZ.Data.Get)
        if not (ok and profile) then return end

        local eco = profile.Eco
        Options.StatLevel:SetValue(eco.level)
        Options.StatRebirth:SetValue(eco.rebirth)
        Options.StatCoins:SetValue(eco.coin)
        Options.StatTowerLoot:SetValue(State.TowerLoot)
        Options.StatusGear:SetValue(xDTaraZ.Gear.EquippedNames(profile), "Idle")

        local note = opt.MaxGear and noteText[State.GearNote]
        if not opt.MaxGear then
            Options.StatusTask:SetValue("Off", "Idle")
        else
            Options.StatusTask:SetValue(note or "Working", State.GearNote == "NoTicket" and "Warn" or "Running")
        end
    end

    local function BuildTabs()
        local window = Library.Window
        RegisterIcons()
        BuildMain(window)
        BuildFarm(window)
        BuildGear(window)
        BuildProgress(window)
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