if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10684750879 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub : this script is for Loot To Forge only")
    return
end

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
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
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
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt
    local rarityNames = xDTaraZ.Util.RarityNames()

    local function Notify(text)
        Library:Notify("Loot To Forge", text, 4)
    end

    local function Toggle(group, key, text, description, onChange)
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

    local function Action(action)
        return function()
            xDTaraZ.Util.Try(action)
        end
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

    local function NumberInput(group, key, text, description)
        return group:AddInput(key, {
            Text = text,
            Description = description,
            Default = tostring(opt[key]),
            Numeric = true,
            Finished = true,
            Callback = function(value)
                opt[key] = math.max(0, tonumber(value) or opt[key])
            end,
        })
    end

    local function BuildTabs()
        local Window = Library.Window
        Window:AddTabSection(T("Farm", "ฟาร์ม"))
        local MainTab = Window:AddTab(T("Main", "หลัก"), "house", T("Status, all-in-one mode and rewards", "สถานะ โหมดทำทุกอย่าง และรางวัล"))
        local FarmTab = Window:AddTab(T("Combat & Farm", "ต่อสู้และฟาร์ม"), "swords", T("Stages, ore collection and monsters", "ด่าน เก็บแร่ และมอนสเตอร์"))
        local ForgeTab = Window:AddTab(T("Forge", "หลอม"), "zap", T("Forge gear from your ores", "หลอมอุปกรณ์จากแร่ที่มี"))
        local SellTab = Window:AddTab(T("Sell", "ขาย"), "upload", T("Sell gear by type and rarity", "ขายอุปกรณ์ตามประเภทและ rarity"))
        Window:AddTabSection(T("Progress", "ความคืบหน้า"))
        local ProgressTab = Window:AddTab(T("Upgrade & Rebirth", "อัปเกรดและรีเบิร์ธ"), "sliders-horizontal", T("Training, rebirth and upgrades", "ฝึก รีเบิร์ธ และอัปเกรด"))
        local TowerTab = Window:AddTab(T("Tower", "หอคอย"), "shield", T("Tower loot farming", "ฟาร์มของจากหอคอย"))
        local OreTab = Window:AddTab(T("Spawn Ore", "เสกแร่"), "target", T("Add any ore to your storage", "เพิ่มแร่ชนิดไหนก็ได้เข้าคลัง"))
        Window:AddTabSection(T("Other", "อื่นๆ"))
        local PlayerTab = Window:AddTab(T("Player", "ผู้เล่น"), "user", T("Race and movement", "เผ่าและการเคลื่อนที่"))

        local statusBox = MainTab:AddLeftGroupbox(T("Status", "สถานะ"))
        local statusLabel = statusBox:AddLabel("Loading...")
        local gearLabel = statusBox:AddLabel("Equipped: -")

        local kaitunBox = MainTab:AddLeftGroupbox(T("Kaitun", "ไก่ตัน"))
        kaitunBox:AddToggle("Kaitun", {
            Text = T("Kaitun (All-in-one)", "ไก่ตัน (ทำทุกอย่าง)"),
            Description = T("Best gear, money, level, upgrades, rewards and ore bosses all at once", "ของดีสุด เงิน เลเวล อัปเกรด รางวัล และบอสแร่ ทำพร้อมกันทั้งหมด"),
            NoSave = true,
            Callback = function(value)
                for _, key in ipairs(Config.KaitunToggles) do
                    Options[key]:SetValue(value)
                end
            end,
        })

        local discordBox = MainTab:AddRightGroupbox("Discord", "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            local copy = setclipboard or toclipboard
            if copy then copy(Config.Discord) end
            Notify(copy and "Discord link copied" or Config.Discord)
        end })

        local gearBox = MainTab:AddRightGroupbox(T("Max Gear", "อุปกรณ์สูงสุด"))
        Toggle(gearBox, "MaxGear", T("Max Gear", "อุปกรณ์สูงสุด"),
            T("Best weapon, armor and hat, enhanced to your target with the best enchants. Finds anything missing by itself", "อาวุธ เกราะ หมวกที่ดีที่สุด ตีบวกถึงเป้า พร้อม enchant ดีสุด ขาดอะไรหาเองหมด"),
            function()
                State.GearForged = false
            end)
        Toggle(gearBox, "AutoEquip", T("Auto Equip Best", "ใส่ของดีสุดอัตโนมัติ"), T("Always wears your strongest weapon, armor and hat, counting enhance level", "ใส่อาวุธ เกราะ และหมวกที่แรงที่สุดเสมอ นับระดับตีบวกด้วย"))
        gearBox:AddButton({ Text = T("Equip Best Now", "ใส่ของดีสุดเดี๋ยวนี้"), Func = function()
            local changed = xDTaraZ.Gear.EquipBest()
            Notify(changed > 0 and ("Equipped %d better item(s)"):format(changed) or "Already wearing your best gear")
        end })
        gearBox:AddSlider("EnhanceTarget", {
            Text = T("Enhance Target", "ตีบวกถึง"),
            Description = T("Above +10 the success rate gets very low and can take a long time", "เกิน +10 โอกาสสำเร็จต่ำมาก อาจใช้เวลานาน"),
            Min = 5, Max = 20, Default = opt.EnhanceTarget, Rounding = 0, Suffix = "",
            Callback = function(value)
                opt.EnhanceTarget = value
            end,
        })

        local rewardBox = MainTab:AddRightGroupbox(T("Rewards", "รางวัล"))
        Toggle(rewardBox, "AutoClaim", T("Auto Claim", "รับรางวัลอัตโนมัติ"), T("Claims every free reward, including index", "รับรางวัลฟรีทุกอย่าง รวมสมุดสะสม"))
        rewardBox:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Style = "Primary", Func = function()
            Library:Notify("Codes", xDTaraZ.Claim.AllCodes(), 6)
        end })
        rewardBox:AddInput("Code", {
            Text = T("Redeem Code", "ใส่โค้ด"),
            Placeholder = T("Code", "โค้ด"),
            Finished = true,
            NoSave = true,
            Callback = function(value)
                if value ~= "" then
                    Library:Notify("Code", tostring(xDTaraZ.Claim.Code(value)), 4)
                end
            end,
        })

        local stageBox = FarmTab:AddLeftGroupbox(T("Stage", "ด่าน"))
        local stageList = xDTaraZ.Stage.List()
        opt.Stage = stageList[1]
        stageBox:AddDropdown("Stage", {
            Text = T("Stage", "ด่าน"),
            Description = T("Any stage, no unlock needed", "เลือกด่านไหนก็ได้ ไม่ต้องปลดล็อก"),
            Values = stageList,
            Default = 1,
            Searchable = true,
            Callback = function(value)
                opt.Stage = value
            end,
        })
        Toggle(stageBox, "CollectOre", T("Auto Collect Ore", "เก็บแร่อัตโนมัติ"), T("Clears the stage and collects its ores nonstop", "เคลียร์ด่านแล้วเก็บแร่ไม่หยุด"))
        MultiSelect(stageBox, "CollectRarities", T("Ore Rarity Filter", "กรอง rarity แร่"), T("Only collect these rarities", "เก็บเฉพาะ rarity ที่เลือก"), rarityNames)

        local combatBox = FarmTab:AddRightGroupbox(T("Combat", "ต่อสู้"))
        Toggle(combatBox, "KillAura", T("Instant Kill", "ฆ่าทันที"), T("Every monster in your stage dies instantly", "มอนสเตอร์ทุกตัวในด่านตายทันที"), function(value)
            if value then
                xDTaraZ.Combat.Start()
            end
        end)
        Toggle(combatBox, "SuperLootAura", T("Kill Ore Boss", "ฆ่าบอสแร่"), T("Kills rare ore bosses the moment they spawn", "ฆ่าบอสแร่หายากทันทีที่เกิด"), function(value)
            if value then
                xDTaraZ.SuperLoot.KillExisting()
            end
        end)
        combatBox:AddButton({ Text = T("Exit Fight Now", "ออกจากการต่อสู้เดี๋ยวนี้"), Func = Action(xDTaraZ.Stage.ExitFight) })

        local indexBox = FarmTab:AddRightGroupbox(T("Index", "สมุดสะสม"))
        indexBox:AddButton({
            Text = T("Complete Index", "เก็บสมุดสะสมให้ครบ"),
            Description = T("Collects every ore and gear type, then claims all index rewards", "เก็บแร่และอุปกรณ์ทุกชนิด แล้วรับรางวัลสมุดสะสมทั้งหมด"),
            Style = "Primary",
            Func = function()
                if State.GearBusy then
                    return
                end
                Notify("Completing index...")
                local before = xDTaraZ.Index.Unlocked()
                xDTaraZ.Util.Try(xDTaraZ.Index.UnlockAll)
                State.GearBusy = false
                local after, level = xDTaraZ.Index.Unlocked()
                Notify(("Index +%d (total %d, level %d)"):format(after - before, after, level))
            end,
        })

        local forgeBox = ForgeTab:AddLeftGroupbox(T("Forge", "หลอม"))
        local targetNames = {}
        for _, target in ipairs(Config.ForgeTargets) do
            table.insert(targetNames, target.name)
        end
        forgeBox:AddDropdown("ForgeTarget", {
            Text = T("Target Gear", "อุปกรณ์ที่จะหลอม"),
            Values = targetNames,
            Default = 1,
            Callback = function(value)
                opt.ForgeTarget = value or opt.ForgeTarget
            end,
        })
        Toggle(forgeBox, "AutoForge", T("Auto Forge", "หลอมอัตโนมัติ"), T("Forges the target gear nonstop", "หลอมอุปกรณ์ที่เลือกไม่หยุด"))
        forgeBox:AddButton({ Text = T("Forge Now", "หลอมเดี๋ยวนี้"), Style = "Primary", Func = function()
            Notify(xDTaraZ.Forge.Once() and "Forged" or "Not enough ore")
        end })

        local oreUseBox = ForgeTab:AddRightGroupbox(T("Ore Usage", "การใช้แร่"))
        Toggle(oreUseBox, "InfiniteOre", T("Infinite Ore", "แร่ไม่จำกัด"), T("Your best ore refills itself while forging", "แร่ที่ดีที่สุดเติมเองระหว่างหลอม"))
        Toggle(oreUseBox, "BestOreFirst", T("Spend Best Ore First", "ใช้แร่ดีสุดก่อน"), T("Off = spend the weakest ore first", "ปิด = ใช้แร่ที่อ่อนที่สุดก่อน"))
        MultiSelect(oreUseBox, "ForgeRarities", T("Forge Ore Rarity", "rarity แร่ที่ใช้หลอม"), T("Only these ore rarities are used for forging", "ใช้แร่เฉพาะ rarity ที่เลือกในการหลอม"), rarityNames)
        NumberInput(oreUseBox, "KeepPerOre", T("Keep Per Ore", "เก็บแร่ไว้ชนิดละ"), T("Never forge below this amount of each ore", "ไม่หลอมจนแร่แต่ละชนิดต่ำกว่าจำนวนนี้"))

        local sellBox = SellTab:AddLeftGroupbox(T("Auto Sell", "ขายอัตโนมัติ"))
        Toggle(sellBox, "AutoSell", T("Auto Sell", "ขายอัตโนมัติ"), T("Sells gear that matches your filters. Equipped gear is never sold", "ขายอุปกรณ์ที่ตรงตัวกรอง ของที่ใส่อยู่จะไม่ขาย"))
        sellBox:AddButton({ Text = T("Sell All Now", "ขายทั้งหมดเดี๋ยวนี้"), Style = "Primary", Func = function()
            xDTaraZ.Sell.Run(xDTaraZ.Data.Get())
            Notify("Sold")
        end })

        local sellFilterBox = SellTab:AddRightGroupbox(T("Filters", "ตัวกรอง"))
        MultiSelect(sellFilterBox, "SellTypes", T("Sell Item Types", "ประเภทที่จะขาย"), nil, Config.GearTypes)
        MultiSelect(sellFilterBox, "SellRarities", T("Sell Rarity Filter", "กรอง rarity ที่จะขาย"), T("Only sell these rarities", "ขายเฉพาะ rarity ที่เลือก"), rarityNames)
        NumberInput(sellFilterBox, "KeepPerItem", T("Keep Per Item", "เก็บไว้ชิ้นละ"), T("Keeps this many of each item, highest enhance first", "เก็บแต่ละไอเทมไว้ตามจำนวนนี้ เลือกตัวตีบวกสูงสุดก่อน"))

        local trainBox = ProgressTab:AddLeftGroupbox(T("Training", "ฝึก"))
        Toggle(trainBox, "AutoTrain", T("Auto Train", "ฝึกอัตโนมัติ"), T("Trains at the x100 area nonstop", "ฝึกที่โซน x100 ไม่หยุด"), function(value)
            task.spawn(xDTaraZ.Util.Try, xDTaraZ.Level.SetTraining, value)
        end)
        Toggle(trainBox, "AutoClick", T("Auto Click", "คลิกอัตโนมัติ"), T("Clicks to train as fast as the game allows", "คลิกฝึกเร็วสุดเท่าที่เกมยอม"), function(value)
            if value then
                xDTaraZ.Level.StartClicking()
            end
        end)
        Toggle(trainBox, "AutoRebirth", T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"), T("Rebirths as soon as your level is high enough", "รีเบิร์ธทันทีเมื่อเลเวลถึง"))
        trainBox:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Func = Action(xDTaraZ.Level.Rebirth) })

        local upgradeBox = ProgressTab:AddRightGroupbox(T("Upgrades", "อัปเกรด"))
        MultiSelect(upgradeBox, "Upgrades", T("Upgrades To Buy", "อัปเกรดที่จะซื้อ"), nil, xDTaraZ.Upgrade.Names())
        Toggle(upgradeBox, "AutoUpgrade", T("Auto Buy Upgrades", "ซื้ออัปเกรดอัตโนมัติ"), T("Buys the selected upgrades whenever possible", "ซื้ออัปเกรดที่เลือกทุกครั้งที่ซื้อได้"))
        upgradeBox:AddButton({ Text = T("Buy Upgrade Now", "ซื้ออัปเกรดเดี๋ยวนี้"), Func = Action(xDTaraZ.Upgrade.BuySelected) })

        local towerBox = TowerTab:AddLeftGroupbox(T("Tower", "หอคอย"))
        Toggle(towerBox, "AutoTower", T("Auto Farm Tower", "ฟาร์มหอคอยอัตโนมัติ"), T("Farms tower loot nonstop with a single ticket", "ฟาร์มของหอคอยไม่หยุดด้วยตั๋วใบเดียว"), function(value)
            local ok, entered = pcall(function()
                return not value or xDTaraZ.Tower.Enter()
            end)
            if not (ok and entered) then
                Notify("No tower ticket")
            end
        end)
        towerBox:AddButton({ Text = T("Exit Tower Now", "ออกจากหอคอยเดี๋ยวนี้"), Func = function()
            Options.AutoTower:SetValue(false)
            xDTaraZ.Util.Try(xDTaraZ.Tower.Exit)
        end })

        local spawnBox = OreTab:AddLeftGroupbox(T("Spawn Ore", "เสกแร่"))
        local oreLabels = xDTaraZ.Ore.Choices()
        opt.SpawnOre = oreLabels[1]
        spawnBox:AddDropdown("SpawnOre", {
            Text = T("Ore", "แร่"),
            Description = T("Any ore in the game, even ones you don't have yet", "แร่ทุกชนิดในเกม แม้ยังไม่เคยได้"),
            Values = oreLabels,
            Default = 1,
            Searchable = true,
            NoSave = true,
            Callback = function(value)
                opt.SpawnOre = value
            end,
        })
        NumberInput(spawnBox, "SpawnAmount", T("Amount", "จำนวน"))
        spawnBox:AddButton({ Text = T("Spawn", "เสก"), Style = "Primary", Func = function()
            local oreId = State.OreLabels[opt.SpawnOre]
            if not oreId then
                return Notify("Pick an ore first")
            end
            local label, amount = opt.SpawnOre, opt.SpawnAmount
            Notify(xDTaraZ.Ore.Spawn(oreId, amount) and ("Added %s %s"):format(xDTaraZ.Util.Abbreviate(amount), label) or "Could not find this ore, try again")
        end })

        local raceBox = PlayerTab:AddLeftGroupbox(T("Race", "เผ่า"))
        local raceLabels, raceIds = xDTaraZ.Race.Choices()
        opt.TargetRace = raceIds[raceLabels[1]]
        raceBox:AddDropdown("TargetRace", {
            Text = T("Target Race", "เผ่าที่ต้องการ"),
            Values = raceLabels,
            Default = 1,
            Callback = function(value)
                opt.TargetRace = raceIds[value]
            end,
        })
        Toggle(raceBox, "AutoRace", T("Auto Roll Race", "สุ่มเผ่าอัตโนมัติ"), T("Uses your race rolls until you get the chosen race", "สุ่มเผ่าจนกว่าจะได้เผ่าที่เลือก"), function(value)
            if not value then
                return
            end
            task.spawn(function()
                local ok, outcome = pcall(xDTaraZ.Race.RollUntil, opt.TargetRace)
                if ok and outcome == "got" then
                    Notify("Got the race!")
                elseif ok and outcome == "empty" then
                    Notify("No race rolls left")
                end
                Options.AutoRace:SetValue(false)
            end)
        end)

        local moveBox = PlayerTab:AddRightGroupbox(T("Movement", "การเคลื่อนที่"))
        Toggle(moveBox, "SpeedOn", T("Speed", "ความเร็ว"), nil, xDTaraZ.Movement.Apply)
        moveBox:AddSlider("WalkSpeed", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Min = 16, Max = 200, Default = opt.WalkSpeed, Rounding = 0,
            Callback = function(value)
                opt.WalkSpeed = value
                xDTaraZ.Movement.Apply()
            end,
        })
        Toggle(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))

        local settingsTab = Window:AddSettingsTab()
        local sessionBox = settingsTab:AddLeftGroupbox(T("Session", "เซสชัน"))
        Toggle(sessionBox, "AutoRejoin", T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), T("Rejoins the game by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"))
        Toggle(sessionBox, "LowGraphics", T("FPS Boost", "เพิ่ม FPS"), T("Turns off 3D rendering to save CPU and GPU", "ปิดการแสดงผล 3D ประหยัด CPU/GPU"), xDTaraZ.Session.SetLowGraphics)

        local noteText = {
            EnhantStone_1 = "farming enhance stones",
            EnhantStone_2 = "farming rare enhance stones",
            EnchStone = "farming enchant stones",
            Coin = "farming coins",
            Enhancing = "enhancing",
            NoTicket = "need a tower ticket",
            Done = "all at target",
        }

        task.spawn(function()
            while State.Alive do
                local ok, profile = pcall(xDTaraZ.Data.Get)
                if ok and profile then
                    local eco = profile.Eco
                    local line = ("Level %d · Rebirth %d · Coins %s"):format(eco.level, eco.rebirth, xDTaraZ.Util.Abbreviate(eco.coin))
                    if State.TowerLoot > 0 then
                        line ..= ("\nTower loot x%d"):format(State.TowerLoot)
                    end
                    statusLabel:SetText(line)

                    local gearLine = "Equipped: " .. xDTaraZ.Gear.EquippedNames(profile)
                    local note = opt.MaxGear and noteText[State.GearNote]
                    if note then
                        gearLine ..= "\n" .. note
                    end
                    gearLabel:SetText(gearLine)
                end
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
            Notify("Loaded")
            Library:LoadAutoloadConfig()
        end,
    })
end

if getgenv().LootToForgeUnload then
    pcall(getgenv().LootToForgeUnload)
end

BuildInterface()