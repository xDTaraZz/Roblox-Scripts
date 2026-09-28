if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765091041 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub : this script is for Open Sea For Animals only")
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
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"))
local Configs = ReplicatedStorage:WaitForChild("Configs")

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    SaveFolder = "Open Sea For Animals",
    TickDelay = 0.25,
    LootWorkers = 3,
    WaveExtension = 5,
    ClaimInterval = 30,
    UpgradeInterval = 3,
    SellInterval = 2,
    Codes = { "Release" },
    PlaytimeSlots = 12,
    PlaceEggTries = 3,
    UpgradeNames = { "Carry", "MovementSpeed", "PlotUpgrade" },
    NoclipParts = { "Head", "Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart" },
}

xDTaraZ.State = {
    Alive = true,
    Busy = false,
    Conns = {},
    Requests = {},
    Messages = {},
    Summary = "Loading...",
    StartCash = nil,
    Looted = 0,
    LastClaim = 0,
    LastUpgrade = 0,
    LastSell = 0,
    Opt = {
        AutoLoot = false,
        LootKeep = {},
        AutoSellEggs = false,
        SellKeep = {},
        AutoSellBrainrots = false,
        AutoEquipBest = false,
        AutoUpgrade = false,
        UpgradePick = {},
        CashReserve = 0,
        AutoRebirth = false,
        AutoTrain = false,
        AutoHatch = false,
        AutoBuyTool = false,
        AutoClaim = false,
        Speed = false,
        SpeedValue = 60,
        InfJump = false,
        Noclip = false,
        AntiAfk = false,
        CodeInput = "",
    },
}

local Config, State = xDTaraZ.Config, xDTaraZ.State

xDTaraZ.GameLib = {
    Eggs = require(Configs.EggsConfig),
    Brainrots = require(Configs.BrainrotsConfig),
    Rarities = require(Configs.RaritiesConfig),
    Mutations = require(Configs.MutationConfig),
    Sizes = require(Configs.SizeConfig),
    Upgrades = require(Configs.UpgradeConfig),
    TrainTools = require(Configs.TrainToolConfig).TRAIN_TOOLS,
}
local GameLib = xDTaraZ.GameLib

for _, name in ipairs({ "Util", "Data", "Loot", "Sell", "Progress", "Claim", "Hatch", "Movement", "Scheduler" }) do
    xDTaraZ[name] = {}
end
local Util, Data, Loot, Sell = xDTaraZ.Util, xDTaraZ.Data, xDTaraZ.Loot, xDTaraZ.Sell
local Progress, Claim, Hatch = xDTaraZ.Progress, xDTaraZ.Claim, xDTaraZ.Hatch
local Movement, Scheduler = xDTaraZ.Movement, xDTaraZ.Scheduler

local services = {}
local SUFFIXES = { "", "K", "M", "B", "T", "Qa", "Qi" }

function Util.Try(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[OpenSea]", err) end
    return ok, err
end

function Util.Service(name)
    services[name] = services[name] or Knit.GetService(name)
    return services[name]
end

function Util.Abbreviate(number)
    local tier = 1
    while math.abs(number) >= 1000 and tier < #SUFFIXES do
        number, tier = number / 1000, tier + 1
    end
    return tier == 1 and ("%d"):format(number) or ("%.2f%s"):format(number, SUFFIXES[tier])
end

function Util.Count(tbl)
    local n = 0
    for _ in pairs(tbl) do n += 1 end
    return n
end

function Util.Notify(text)
    State.Messages[#State.Messages + 1] = text
end

---@return string[]  lowest rarity first
function Util.RarityNames()
    local names = {}
    for name in pairs(GameLib.Rarities) do names[#names + 1] = name end
    table.sort(names, function(a, b) return GameLib.Rarities[a] < GameLib.Rarities[b] end)
    return names
end

function Util.MutationNames()
    local names = {}
    for id, info in pairs(GameLib.Mutations) do
        if type(info) == "table" then names[#names + 1] = info.name or id end
    end
    table.sort(names)
    return names
end

function Data.Get()
    return Knit.GetController("ReplicaController"):GetPlayerData()
end

function Data.Cash()
    return Data.Get().Currencies.Cash
end

function Data.MaxPickup()
    return math.max(1, Data.Get().Upgrades.Carry or 1)
end

---@return string, string, table?, table?  rarity, mutation, size, config
function Data.Describe(entity)
    local info = entity.eggType and GameLib.Eggs.EGGS[entity.eggType]
        or entity.brainrotType and GameLib.Brainrots.CONFIG[entity.brainrotType]
    local mutation = entity.mutation and GameLib.Mutations[entity.mutation]
    local size = GameLib.Sizes.SIZES[entity.size or "baby"]
    return info and info.rarity or "Common", mutation and mutation.name or "Normal", size, info
end

function Data.Score(entity)
    local rarity, _, size, info = Data.Describe(entity)
    local mutation = entity.mutation and GameLib.Mutations[entity.mutation]
    local rank = GameLib.Rarities[rarity] or 1
    local mutationMulti = mutation and mutation.cashMulti or 1
    local sizeMulti = size and size.cashMulti or 1
    local bossBonus = entity.isBossItem and 2 or 1
    return rank * 1000 * mutationMulti * sizeMulti * bossBonus + (info and info.tier or 1)
end

function Loot.Wanted(entity)
    local keep = State.Opt.LootKeep
    if next(keep) == nil then return true end
    local rarity, mutation = Data.Describe(entity)
    return keep[rarity] or keep[mutation] or false
end

---@return string[]  item ids, best first
function Loot.PickBest(spawns, limit)
    local ranked = {}
    for id, spawn in pairs(spawns) do
        local entity = spawn.entity
        entity.isBossItem = spawn.isBossItem
        if Loot.Wanted(entity) then ranked[#ranked + 1] = { id, Data.Score(entity) } end
    end
    table.sort(ranked, function(a, b) return a[2] > b[2] end)

    local picked = {}
    for i = 1, math.min(limit, #ranked) do picked[i] = ranked[i][1] end
    return picked
end

---@return number  items taken this wave
function Loot.RunOnce()
    local waves = Util.Service("WaveService")
    local wave = waves:Start(Config.WaveExtension)
    if type(wave) ~= "table" or not wave.spawns then return 0 end

    local picked = Loot.PickBest(wave.spawns, Data.MaxPickup())
    if #picked == 0 then picked = Loot.PickBest(wave.spawns, 0) end

    waves:Finished(picked)
    State.Looted += #picked
    return #picked
end

function Loot.Worker()
    while State.Alive and State.Opt.AutoLoot do
        if not Util.Try(Loot.RunOnce) then task.wait(1) end
        task.wait()
    end
end

function Loot.SetEnabled(enabled)
    State.Opt.AutoLoot = enabled
    if not enabled then return end
    for _ = 1, Config.LootWorkers do task.spawn(Loot.Worker) end
end

function Hatch.MyPlot()
    local plotId = tostring(Util.Service("PlotService"):GetPlayerPlot())
    local plots = Workspace:FindFirstChild("Plots")
    local holder = plots and plots:FindFirstChild(plotId)
    return holder and holder:FindFirstChild(plotId)
end

---@return number  eggs hatched
function Hatch.HatchReady()
    local eggs = Util.Service("EggService")
    local now, hatched = Workspace:GetServerTimeNow(), 0
    for key, egg in pairs(Data.Get().PlacedEggs) do
        if egg.startTime and egg.startTime + (egg.duration or 0) <= now and eggs:HatchEgg(key) then
            hatched += 1
        end
    end
    return hatched
end

---@return table[]  inventory eggs, most valuable first
function Hatch.RankedEggs()
    local ranked = {}
    for id, entry in pairs(Data.Get().Inventory) do
        local inner = entry.innerEntity
        if entry.itemType == "Egg" and inner and inner.eggType then
            ranked[#ranked + 1] = { id = id, score = GameLib.Eggs.GetSellPrice(inner.eggType) * Data.Score(inner) }
        end
    end
    table.sort(ranked, function(a, b) return a.score > b.score end)
    return ranked
end

---@return number  eggs placed
function Hatch.PlaceBest()
    local plot = Hatch.MyPlot()
    local surface = plot and plot:FindFirstChild("PlotSurface")
    local part = surface and (surface:IsA("BasePart") and surface or surface:FindFirstChildWhichIsA("BasePart", true))
    if not part then return 0 end

    local eggs, placed = Util.Service("EggService"), 0
    for i, egg in ipairs(Hatch.RankedEggs()) do
        if i > Config.PlaceEggTries then break end
        local offset = Vector3.new((math.random() - 0.5) * part.Size.X * 0.8, part.Size.Y / 2 + 1, (math.random() - 0.5) * part.Size.Z * 0.8)
        if not eggs:PlaceEgg(egg.id, CFrame.new(part.Position + offset)) then break end
        placed += 1
    end
    return placed
end

function Hatch.Step()
    Hatch.HatchReady()
    Hatch.PlaceBest()
    Progress.EquipBest()
end

---@return number  eggs sold
function Sell.EggsNow()
    local inventory, keep, sold = Util.Service("InventoryService"), State.Opt.SellKeep, 0
    for id, entry in pairs(Data.Get().Inventory) do
        if entry.itemType == "Egg" then
            local rarity, mutation = Data.Describe(entry.innerEntity or {})
            if not keep[rarity] and not keep[mutation] then
                inventory:SellEgg(id)
                sold += 1
            end
        end
    end
    return sold
end

function Sell.BrainrotsNow()
    Util.Service("InventoryService"):SellAllBrainrots()
end

---@return number  upgrades bought
function Progress.UpgradeNow()
    local upgrades, bought = Util.Service("UpgradesService"), 0
    for _, name in ipairs(Config.UpgradeNames) do
        if State.Opt.UpgradePick[name] then
            local ok, price = pcall(GameLib.Upgrades.GetPrice, name, Data.Get().Upgrades[name])
            if ok and price and Data.Cash() - price >= State.Opt.CashReserve then
                upgrades:Upgrade(name, 1)
                bought += 1
            end
        end
    end
    return bought
end

function Progress.StartTraining()
    Util.Service("TrainingService"):StartTraining()
end

---@return string?  strongest dumbbell within budget
function Progress.BestAffordableTool()
    local profile = Data.Get()
    local budget = profile.Currencies.Cash - State.Opt.CashReserve
    local current = GameLib.TrainTools[profile.EquippedTrainTool]
    local bestName, bestGain = nil, current and current.gainPerTrain or 0
    for name, tool in pairs(GameLib.TrainTools) do
        if tool.cost and tool.cost <= budget and (tool.gainPerTrain or 0) > bestGain then
            bestName, bestGain = name, tool.gainPerTrain
        end
    end
    return bestName
end

---@return string?  dumbbell bought
function Progress.BuyBestTool()
    local name = Progress.BestAffordableTool()
    if not name then return nil end

    local training = Util.Service("TrainingService")
    training:BuyTrainTool(name)
    training:EquipTrainTool(name)
    Progress.StartTraining()
    return name
end

function Progress.RebirthNow()
    return Util.Service("RebirthService"):Rebirth()
end

function Progress.EquipBest()
    Util.Service("AnimalService"):EquipBest()
end

function Claim.Daily()
    local daily = Data.Get().DailyReward
    Util.Service("DailyRewardService"):ClaimReward((daily.LastClaimedDay or 0) + 1)
end

function Claim.Playtime()
    local playtime = Util.Service("PlaytimeRewardService")
    for slot = 1, Config.PlaytimeSlots do playtime:ClaimGift(slot) end
end

function Claim.All()
    Util.Try(Claim.Daily)
    Util.Try(Claim.Playtime)
    Util.Try(function() Util.Service("SpinWheelService"):SpinAll() end)
    Util.Try(function() Util.Service("FreeShopService"):Claim() end)
    Util.Try(function() Util.Service("ForeverPackService"):ClaimForeverPack() end)
    Util.Try(function() Util.Service("RewardService"):GroupReward() end)
    Util.Try(function() Util.Service("DiscService"):GetReward() end)
    Util.Try(function() Util.Service("AnimalService"):CollectOfflineCash() end)
end

---@return number  codes redeemed
function Claim.RedeemCodes(codes)
    local svc, redeemed = Util.Service("CodesService"), 0
    for _, code in ipairs(codes) do
        local ok, reply = pcall(svc.RedeemCode, svc, code)
        if ok and reply then redeemed += 1 end
    end
    return redeemed
end

function Movement.Humanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

function Movement.Step()
    local hum = Movement.Humanoid()
    if not hum then return end
    if State.Opt.Speed then hum.WalkSpeed = State.Opt.SpeedValue end
    if not State.Opt.Noclip then return end

    for _, part in ipairs(LocalPlayer.Character:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
end

function Movement.RestoreCollision()
    local char = LocalPlayer.Character
    if not char then return end
    for _, name in ipairs(Config.NoclipParts) do
        local part = char:FindFirstChild(name)
        if part and part:IsA("BasePart") then part.CanCollide = true end
    end
end

function Movement.Bind()
    table.insert(State.Conns, RunService.Stepped:Connect(Movement.Step))
    table.insert(State.Conns, UserInputService.JumpRequest:Connect(function()
        local hum = Movement.Humanoid()
        if State.Opt.InfJump and hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end))
    table.insert(State.Conns, LocalPlayer.Idled:Connect(function()
        if not State.Opt.AntiAfk then return end
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.zero)
    end))
end

function Movement.ResetSpeed()
    local hum = Movement.Humanoid()
    if hum then hum.WalkSpeed = Data.Get().Upgrades.MovementSpeed or 16 end
end

Scheduler.Requests = {
    LootOnce = function()
        local ok, count = Util.Try(Loot.RunOnce)
        Util.Notify(ok and ("Collected %d item(s)"):format(count) or "Wave not ready")
    end,
    SellEggs = function()
        local ok, sold = Util.Try(Sell.EggsNow)
        Util.Notify(ok and ("Sold %d egg(s)"):format(sold) or "Sell failed")
    end,
    SellBrainrots = function()
        Util.Try(Sell.BrainrotsNow)
        Util.Notify("Brainrots sold")
    end,
    HatchNow = function()
        local ok, hatched = Util.Try(Hatch.HatchReady)
        local _, placed = Util.Try(Hatch.PlaceBest)
        Util.Notify(("Hatched %d, placed %d egg(s)"):format(ok and hatched or 0, tonumber(placed) or 0))
    end,
    UpgradeNow = function()
        local ok, bought = Util.Try(Progress.UpgradeNow)
        Util.Notify(ok and ("Bought %d upgrade(s)"):format(bought) or "Upgrade failed")
    end,
    ToolNow = function()
        local ok, name = Util.Try(Progress.BuyBestTool)
        Util.Notify(ok and name and ("Equipped " .. name) or "Nothing better to buy")
    end,
    RebirthNow = function()
        local ok, reply = Util.Try(Progress.RebirthNow)
        Util.Notify(ok and reply and "Rebirthed" or "Requirement not met")
    end,
    ClaimNow = function()
        Claim.All()
        Util.Notify("Rewards claimed")
    end,
    RedeemAll = function()
        Util.Notify(("Redeemed %d/%d code(s)"):format(Claim.RedeemCodes(Config.Codes), #Config.Codes))
    end,
    RedeemInput = function()
        local codes = {}
        for code in State.Opt.CodeInput:gmatch("[^,%s]+") do codes[#codes + 1] = code end
        Util.Notify(("Redeemed %d/%d code(s)"):format(Claim.RedeemCodes(codes), #codes))
    end,
    ResetSpeed = function() Util.Try(Movement.ResetSpeed) end,
}

function Scheduler.Summarize()
    local profile = Data.Get()
    local cash = profile.Currencies.Cash
    State.StartCash = State.StartCash or cash
    State.Summary = ("Cash %s (+%s)\nItems looted %d · Carry %d · Rebirth %d\nInventory %d"):format(
        Util.Abbreviate(cash), Util.Abbreviate(cash - State.StartCash),
        State.Looted, profile.Upgrades.Carry or 1, profile.Rebirth or 0,
        Util.Count(profile.Inventory))
end

function Scheduler.Step()
    local opt, now = State.Opt, os.clock()
    Util.Try(Scheduler.Summarize)

    for name, handler in pairs(Scheduler.Requests) do
        if State.Requests[name] then
            State.Requests[name] = nil
            Util.Try(handler)
        end
    end

    if now - State.LastSell >= Config.SellInterval then
        State.LastSell = now
        if opt.AutoHatch then Util.Try(Hatch.Step) end
        if opt.AutoSellEggs then Sell.EggsNow() end
        if opt.AutoSellBrainrots then Sell.BrainrotsNow() end
        if opt.AutoEquipBest then Progress.EquipBest() end
    end

    if now - State.LastUpgrade >= Config.UpgradeInterval then
        State.LastUpgrade = now
        if opt.AutoUpgrade then Progress.UpgradeNow() end
        if opt.AutoRebirth then Progress.RebirthNow() end
        if opt.AutoBuyTool then Progress.BuyBestTool() end
        if opt.AutoTrain then Progress.StartTraining() end
    end

    if opt.AutoClaim and now - State.LastClaim >= Config.ClaimInterval then
        State.LastClaim = now
        Claim.All()
    end
end

function Scheduler.Boot()
    Movement.Bind()
    task.spawn(function()
        while State.Alive do
            if not State.Busy then
                State.Busy = true
                Util.Try(Scheduler.Step)
                State.Busy = false
            end
            task.wait(Config.TickDelay)
        end
    end)
end

function Scheduler.Stop()
    State.Alive = false
    State.Opt.AutoLoot = false
    for _, conn in ipairs(State.Conns) do conn:Disconnect() end
    table.clear(State.Conns)
    if State.Opt.Noclip then Movement.RestoreCollision() end
    if State.Opt.Speed then Util.Try(Movement.ResetSpeed) end
end

local function BuildInterface()
    local Library = loadstring(game:HttpGet(Config.UiSource))()
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt

    local rarityNames = Util.RarityNames()
    local keepValues = table.clone(rarityNames)
    for _, name in ipairs(Util.MutationNames()) do keepValues[#keepValues + 1] = name end

    local function Notify(text)
        Library:Notify("Open Sea For Animals", text, 4)
    end

    local function Request(name)
        return function() State.Requests[name] = true end
    end

    local function Toggle(group, key, text, description, onChange)
        return group:AddToggle(key, {
            Text = text,
            Description = description,
            Default = opt[key],
            Callback = function(value)
                opt[key] = value
                if onChange then onChange(value) end
            end,
        })
    end

    local function MultiSelect(group, key, text, description, values, default)
        return group:AddDropdown(key, {
            Text = text,
            Description = description,
            Values = values,
            Multi = true,
            Default = default or {},
            Searchable = #values > 8,
            Callback = function(selected) opt[key] = selected end,
        })
    end

    local function BuildTabs()
        local window = Library.Window
        window:AddTabSection(T("Farm", "ฟาร์ม"))
        local mainTab = window:AddTab(T("Main", "หลัก"), "house", T("Loot farm and status", "ฟาร์มของและสถานะ"))
        local sellTab = window:AddTab(T("Sell", "ขาย"), "upload", T("Sell eggs and brainrots", "ขายไข่และ brainrot"))
        window:AddTabSection(T("Progress", "ความคืบหน้า"))
        local progressTab = window:AddTab(T("Upgrade", "อัปเกรด"), "sliders-horizontal", T("Upgrades, rebirth and rewards", "อัปเกรด รีเบิร์ธ และรางวัล"))
        window:AddTabSection(T("Other", "อื่นๆ"))
        local playerTab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement", "การเคลื่อนที่"))

        local statusBox = mainTab:AddLeftGroupbox(T("Status", "สถานะ"))
        local statusLabel = statusBox:AddLabel("Loading...")

        local lootBox = mainTab:AddLeftGroupbox(T("Sea Loot", "เก็บของในทะเล"))
        Toggle(lootBox, "AutoLoot", T("Auto Loot", "เก็บของอัตโนมัติ"),
            T("Collects the best eggs and brainrots from every wave without leaving your base", "เก็บไข่และ brainrot ที่ดีที่สุดทุกคลื่น โดยไม่ต้องออกจากฐาน"),
            Loot.SetEnabled)
        lootBox:AddButton({ Text = T("Loot Once", "เก็บหนึ่งรอบ"), Style = "Primary", Func = Request("LootOnce") })
        MultiSelect(lootBox, "LootKeep", T("Only Collect", "เก็บเฉพาะ"),
            T("Leave empty to always take the best item. Otherwise only these rarities or mutations are collected", "เว้นว่าง = เอาชิ้นดีสุดเสมอ ถ้าเลือกไว้จะเก็บเฉพาะ rarity หรือ mutation ที่เลือก"),
            keepValues)

        local kaitunBox = mainTab:AddRightGroupbox("Kaitun")
        kaitunBox:AddToggle("Kaitun", {
            Text = T("Kaitun (All-in-one)", "ไก่ตัน (ทำทุกอย่าง)"),
            Description = T("Loot, sell, upgrades, rebirth and rewards together", "เก็บของ ขาย อัปเกรด รีเบิร์ธ และรับรางวัลพร้อมกัน"),
            NoSave = true,
            Callback = function(value)
                for _, key in ipairs({ "AutoLoot", "AutoSellEggs", "AutoTrain", "AutoHatch", "AutoBuyTool", "AutoUpgrade", "AutoRebirth", "AutoClaim", "AutoEquipBest" }) do
                    Options[key]:SetValue(value)
                end
            end,
        })

        local discordBox = mainTab:AddRightGroupbox("Discord", "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            local copy = setclipboard or toclipboard
            if copy then copy(Config.Discord) end
            Notify(copy and "Discord link copied" or Config.Discord)
        end })

        local sellBox = sellTab:AddLeftGroupbox(T("Eggs", "ไข่"))
        Toggle(sellBox, "AutoSellEggs", T("Auto Sell Eggs", "ขายไข่อัตโนมัติ"), T("Sells eggs as they come in, except the ones you keep", "ขายไข่ที่ได้มาทันที ยกเว้นที่เลือกเก็บไว้"))
        sellBox:AddButton({ Text = T("Sell Eggs Now", "ขายไข่เดี๋ยวนี้"), Style = "Primary", Func = Request("SellEggs") })
        MultiSelect(sellBox, "SellKeep", T("Keep", "เก็บไว้"), T("Rarities and mutations that are never sold", "rarity และ mutation ที่จะไม่ขาย"), keepValues)

        local brainrotBox = sellTab:AddRightGroupbox("Brainrots")
        Toggle(brainrotBox, "AutoSellBrainrots", T("Auto Sell Brainrots", "ขาย brainrot อัตโนมัติ"), T("Sells all brainrots in your inventory", "ขาย brainrot ทั้งหมดในกระเป๋า"))
        brainrotBox:AddButton({ Text = T("Sell Brainrots Now", "ขาย brainrot เดี๋ยวนี้"), Func = Request("SellBrainrots") })
        Toggle(brainrotBox, "AutoHatch", T("Auto Hatch", "ฟักไข่อัตโนมัติ"), T("Hatches your most valuable eggs on your plot and places the best animals", "ฟักไข่ที่มีค่าที่สุดบนพื้นที่ แล้ววางสัตว์ตัวที่ดีที่สุด"))
        brainrotBox:AddButton({ Text = T("Hatch Now", "ฟักเดี๋ยวนี้"), Func = Request("HatchNow") })
        Toggle(brainrotBox, "AutoEquipBest", T("Auto Place Best", "วางตัวดีสุดอัตโนมัติ"), T("Keeps your best animals placed on your plot", "วางสัตว์ตัวที่ดีที่สุดบนพื้นที่เสมอ"))

        local upgradeBox = progressTab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"))
        Toggle(upgradeBox, "AutoUpgrade", T("Auto Upgrade", "อัปเกรดอัตโนมัติ"), T("Buys the selected upgrades whenever you can afford them", "ซื้ออัปเกรดที่เลือกทุกครั้งที่เงินพอ"))
        upgradeBox:AddButton({ Text = T("Upgrade Now", "อัปเกรดเดี๋ยวนี้"), Style = "Primary", Func = Request("UpgradeNow") })
        MultiSelect(upgradeBox, "UpgradePick", T("Upgrades", "อัปเกรด"), T("Carry lets you bring back more items per wave", "Carry ทำให้ขนของกลับได้มากขึ้นต่อคลื่น"), Config.UpgradeNames, Config.UpgradeNames)
        opt.UpgradePick = { Carry = true, MovementSpeed = true, PlotUpgrade = true }
        upgradeBox:AddInput("CashReserve", {
            Text = T("Keep Cash", "กันเงินไว้"),
            Description = T("Never spend below this amount", "ไม่ใช้เงินจนต่ำกว่าจำนวนนี้"),
            Default = "0",
            Numeric = true,
            Finished = true,
            Callback = function(value) opt.CashReserve = math.max(0, tonumber(value) or 0) end,
        })

        local trainBox = progressTab:AddLeftGroupbox(T("Power", "พลัง"))
        Toggle(trainBox, "AutoTrain", T("Auto Train", "ฝึกอัตโนมัติ"), T("Gains power anywhere. More power reaches rarer eggs further out at sea", "เพิ่มพลังได้ทุกที่ พลังยิ่งเยอะยิ่งเอื้อมถึงไข่หายากที่อยู่ไกล"))
        Toggle(trainBox, "AutoBuyTool", T("Auto Buy Best Dumbbell", "ซื้อดัมเบลล์ดีสุดอัตโนมัติ"), T("Buys and equips the strongest dumbbell you can afford", "ซื้อและใส่ดัมเบลล์ที่แรงที่สุดที่ซื้อไหว"))
        trainBox:AddButton({ Text = T("Buy Best Dumbbell Now", "ซื้อดัมเบลล์ดีสุดเดี๋ยวนี้"), Func = Request("ToolNow") })

        local rebirthBox = progressTab:AddRightGroupbox(T("Rebirth", "รีเบิร์ธ"))
        Toggle(rebirthBox, "AutoRebirth", T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"), T("Rebirths as soon as you meet the requirement", "รีเบิร์ธทันทีเมื่อครบเงื่อนไข"))
        rebirthBox:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Func = Request("RebirthNow") })

        local claimBox = progressTab:AddRightGroupbox(T("Rewards", "รางวัล"))
        Toggle(claimBox, "AutoClaim", T("Auto Claim", "รับรางวัลอัตโนมัติ"), T("Daily, playtime, spins, free shop, packs and offline cash", "รายวัน เวลาเล่น วงล้อ ร้านฟรี แพ็ก และเงินตอนออฟไลน์"))
        claimBox:AddButton({ Text = T("Claim All Now", "รับทั้งหมดเดี๋ยวนี้"), Func = Request("ClaimNow") })
        claimBox:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Func = Request("RedeemAll") })
        claimBox:AddInput("CodeBox", {
            Text = T("Redeem Codes", "ใส่โค้ด"),
            Description = T("Separate codes with commas", "คั่นโค้ดด้วยจุลภาค"),
            Default = "",
            Finished = true,
            Callback = function(value)
                opt.CodeInput = value
                State.Requests.RedeemInput = true
            end,
        })

        local moveBox = playerTab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"))
        Toggle(moveBox, "Speed", T("Speed", "ความเร็ว"), nil, function(value)
            if not value then State.Requests.ResetSpeed = true end
        end)
        moveBox:AddSlider("SpeedValue", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Default = opt.SpeedValue,
            Min = 16,
            Max = 300,
            Rounding = 0,
            Callback = function(value) opt.SpeedValue = tonumber(value) or opt.SpeedValue end,
        })
        Toggle(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))
        Toggle(moveBox, "Noclip", T("Noclip", "ทะลุวัตถุ"), nil, function(value)
            if not value then Movement.RestoreCollision() end
        end)

        local settingsTab = window:AddSettingsTab()
        local sessionBox = settingsTab:AddLeftGroupbox(T("Session", "เซสชัน"))
        Toggle(sessionBox, "AntiAfk", T("Anti AFK", "กันหลุด AFK"), T("Stay in the server while idle", "อยู่ในเซิร์ฟต่อได้แม้ไม่ได้ขยับ"))
        sessionBox:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟเดิมใหม่"), Func = function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end })

        Library:Every(1, function()
            while #State.Messages > 0 do Notify(table.remove(State.Messages, 1)) end
            statusLabel:SetText(State.Summary)
        end)
    end

    Library:OnUnload(Scheduler.Stop)
    getgenv().OpenSeaUnload = function()
        Library:Unload()
    end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Open Sea For Animals by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            BuildTabs()
            Scheduler.Boot()
            Notify("Loaded")
            Library:LoadAutoloadConfig()
        end,
    })
end

if getgenv().OpenSeaUnload then
    pcall(getgenv().OpenSeaUnload)
end

BuildInterface()