if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10418224975 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub : this script is for +1 TNT Mining only")
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
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local vector3New, cframeNew = Vector3.new, CFrame.new
local mathMin, mathMax, mathCeil = math.min, math.max, math.ceil

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui_v2.lua",
    SaveFolder = "TNT Mining",
    TickDelay = 0.1,
    ClicksPerBatch = 25,
    ClickInterval = 1,
    ExplodeTimeout = 3,
    DropSettle = 0.35,
    IdConfirmTimeout = 3,
    SolverYieldEvery = 1500,
    HotbarSlots = 4,
    PurchaseInterval = 3,
    ClaimInterval = 60,
    HatchInterval = 1,
    MineStandOffset = 3,
    RejoinDelay = 5,
    RateWindow = 60,
}

xDTaraZ.State = {
    Alive = true,
    Busy = false,
    NeedRefill = true,
    Connections = {},
    Requests = {},
    Messages = {},
    Status = "Idle",
    Summary = "Loading...",
    Bombs = 0,
    Earned = 0,
    LastPurchase = 0,
    LastClaim = 0,
    LastHatch = 0,
    EarnLog = {},
    SecretSeen = {},
    Opt = {
        AutoMine = false,
        MineArea = "Best",
        TargetShards = false,
        AutoSell = false,
        AutoCollect = false,
        AutoClick = false,
        AutoRebirth = false,
        AutoBomb = false,
        AutoUpgrade = false,
        Upgrades = {},
        AutoArea = false,
        AutoLuck = false,
        AutoHatch = false,
        AutoEquipPets = false,
        AutoSellPets = false,
        KeepPets = 10,
        KeepPetRarities = {},
        SecretAlert = false,
        AutoRejoin = false,
        LowGraphics = false,
        AutoClaim = false,
        SpeedOn = false,
        WalkSpeed = 60,
        InfJump = false,
    },
}

local Logic = ReplicatedStorage:WaitForChild("Logic")
local Configs = Logic:WaitForChild("Configs")

xDTaraZ.GameLib = {
    Session = require(Logic.Classes.PlayerSession),
    Network = require(Logic.Network),
    MineState = require(ReplicatedStorage.ClientLogic.Services.MineStateService),
    AreaRenderer = require(Logic.Services.AreaRenderer),
    Blocks = require(Configs.BlocksConfig),
    Bombs = require(Configs.BombsConfig),
    Areas = require(Configs.AreasConfig),
    Upgrades = require(Configs.UpgradesConfig),
    Mine = require(Configs.MineConfig),
    Rebirth = require(Configs.RebirthConfig),
    Pets = require(Configs.PetsConfig),
}

local GameLib = xDTaraZ.GameLib
local Config, State = xDTaraZ.Config, xDTaraZ.State

xDTaraZ.AreaOrder = GameLib.Areas.GetOrderedNames()

xDTaraZ.BombOrder = {}
do
    for name, bomb in pairs(GameLib.Bombs) do
        if type(bomb) == "table" and not bomb.IsPremium and bomb.Price then
            table.insert(xDTaraZ.BombOrder, name)
        end
    end
    table.sort(xDTaraZ.BombOrder, function(a, b) return GameLib.Bombs[a].Price < GameLib.Bombs[b].Price end)
end

xDTaraZ.UpgradeNames = {}
do
    for name, upgrade in pairs(GameLib.Upgrades) do
        if type(upgrade) == "table" and not upgrade.AreaSpecific then
            table.insert(xDTaraZ.UpgradeNames, name)
        end
    end
    table.sort(xDTaraZ.UpgradeNames, function(a, b)
        return (GameLib.Upgrades[a].LayoutOrder or 0) < (GameLib.Upgrades[b].LayoutOrder or 0)
    end)
end

xDTaraZ.BlockSize = ReplicatedStorage.Assets.Models.BlockTemplate.Root.Size.X

local SUFFIXES = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }

function xDTaraZ:Session()
    return GameLib.Session.GetClient()
end

function xDTaraZ:Invoke(action, args)
    return GameLib.Network.ClientAction.Invoke({ action, args })
end

function xDTaraZ.Format(number)
    number = tonumber(number) or 0
    local tier = 1
    while number >= 1000 and tier < #SUFFIXES do
        number, tier = number / 1000, tier + 1
    end
    return tier == 1 and ("%d"):format(number) or ("%.2f%s"):format(number, SUFFIXES[tier])
end

function xDTaraZ:Notify(text)
    State.Messages[#State.Messages + 1] = text
end

function xDTaraZ:Connect(signal, handler)
    local conn = signal:Connect(handler)
    table.insert(State.Connections, conn)
    return conn
end

function xDTaraZ:Root()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

function xDTaraZ:Humanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

function xDTaraZ:AreaModel(areaName)
    for _, area in ipairs(Workspace.Map.Areas:GetChildren()) do
        if area:GetAttribute("AreaName") == areaName then return area end
    end
end

xDTaraZ.Mine = {}

---@return string  best owned area for current damage
function xDTaraZ.Mine.PickArea(session)
    local picked = State.Opt.MineArea
    if picked ~= "Best" and session.OwnedAreas[picked] then return picked end

    local best = xDTaraZ.AreaOrder[1]
    for _, name in ipairs(xDTaraZ.AreaOrder) do
        if session.OwnedAreas[name] and session.Damage >= GameLib.Areas[name].ExplosionDamage.Start then
            best = name
        end
    end
    return best
end

---@return boolean  mine loaded
function xDTaraZ.Mine.Enter(areaName)
    local area = xDTaraZ:AreaModel(areaName)
    if not area then
        GameLib.AreaRenderer.RenderArea(areaName)
        area = xDTaraZ:AreaModel(areaName)
    end

    local mineArea = area and area:FindFirstChild("MineArea", true)
    local hrp = xDTaraZ:Root()
    if not (mineArea and hrp) then return false end

    hrp.CFrame = cframeNew(mineArea.Position + vector3New(0, mineArea.Size.Y / 2 + Config.MineStandOffset, 0))
    hrp.AssemblyLinearVelocity = Vector3.zero

    local mineState = GameLib.MineState
    local giveUp = os.clock() + 8
    repeat
        if mineState.IsLoaded() and mineState.GetAreaName() == areaName then return true end
        task.wait(0.2)
    until os.clock() > giveUp
    return false
end

function xDTaraZ.Mine.BlockValue(block, shardValue)
    if block.BlockType == "EggShard" then return shardValue end
    local info = GameLib.Blocks[block.BlockType]
    return info and info.SellValue or 0
end

---@param count number  max spots
---@return Vector3[]    best first, no overlap
function xDTaraZ.Mine.FindBatch(session, count)
    local mineState = GameLib.MineState
    local damage = session.Damage
    local radius = session:GetBombExplosionRadius(session.EquippedBomb, session.EnchantedBombs > 0)
    local reach, radiusSq = mathCeil(radius), radius * radius

    local shardValue = 0
    if State.Opt.TargetShards then
        for _, info in pairs(GameLib.Blocks) do
            shardValue = mathMax(shardValue, info.SellValue or 0)
        end
    end

    local offsets = {}
    for dx = -reach, reach do
        for dy = -reach, reach do
            for dz = -reach, reach do
                if dx * dx + dy * dy + dz * dz <= radiusSq then
                    offsets[#offsets + 1] = { dx, dy, dz }
                end
            end
        end
    end

    local scores, seen = {}, 0
    for _, block in pairs(mineState.GetBlocks()) do
        if not block.Alive then continue end

        local worth = xDTaraZ.Mine.BlockValue(block, shardValue) * mathMin(1, damage / mathMax(block.Health, 1))
        if worth > 0 then
            local gx, gy, gz = block.GridX, block.GridY, block.GridZ
            for i = 1, #offsets do
                local o = offsets[i]
                local center = mineState.GetBlockAt(gx + o[1], gy + o[2], gz + o[3])
                if center then scores[center] = (scores[center] or 0) + worth end
            end
        end

        seen += 1
        if seen % Config.SolverYieldEvery == 0 then task.wait() end
    end

    local ranked = {}
    for block, score in pairs(scores) do
        ranked[#ranked + 1] = { block, score }
    end
    table.sort(ranked, function(a, b) return a[2] > b[2] end)

    local spots, spacingSq = {}, (2 * radius) ^ 2
    for _, entry in ipairs(ranked) do
        if #spots >= count then break end

        local block, tooClose = entry[1], false
        for _, other in ipairs(spots) do
            local dx, dy, dz = block.GridX - other.GridX, block.GridY - other.GridY, block.GridZ - other.GridZ
            if dx * dx + dy * dy + dz * dz < spacingSq then
                tooClose = true
                break
            end
        end
        if not tooClose then spots[#spots + 1] = block end
    end

    for i, block in ipairs(spots) do
        spots[i] = block.Position
    end
    return spots
end

---@return string?  nil if rejected
function xDTaraZ.Mine.WaitServerId(bomb)
    local giveUp = os.clock() + Config.IdConfirmTimeout
    while os.clock() < giveUp and not bomb.IsDestroyed do
        if not tostring(bomb.Id):match("^P") then return bomb.Id end
        task.wait()
    end
end

---@return number  drops collected
function xDTaraZ.Mine.Collect(session)
    local folder = Workspace:FindFirstChild("ClientCollectibleBlocks")
    if not folder then return 0 end

    local ids = {}
    for _, drop in ipairs(folder:GetChildren()) do
        ids[#ids + 1] = drop.Name
    end

    local batchSize = GameLib.Mine.Collectible.PickupBatchSize or 20
    local got = 0
    for first = 1, #ids, batchSize do
        local reply = session:CollectBlocks(table.move(ids, first, mathMin(first + batchSize - 1, #ids), 1, {}), false, Config.HotbarSlots)
        got += reply and reply.Collected or 0
    end
    return got
end

function xDTaraZ.Mine.Sell(session)
    local before = session.Money
    session:SellBlocks(nil)

    local gained = mathMax(session.Money - before, 0)
    State.Earned += gained
    State.EarnLog[#State.EarnLog + 1] = { os.clock(), gained }
end

---@return number  money per minute
function xDTaraZ.Mine.EarnRate()
    local log, cutoff = State.EarnLog, os.clock() - Config.RateWindow
    while log[1] and log[1][1] < cutoff do
        table.remove(log, 1)
    end

    local total = 0
    for _, entry in ipairs(log) do total += entry[2] end
    return total * 60 / Config.RateWindow
end

function xDTaraZ.Mine.ScanSecrets()
    for _, block in pairs(GameLib.MineState.GetBlocks()) do
        local info = GameLib.Blocks[block.BlockType]
        local id = block.CollectibleId
        if block.Alive and info and info.Rarity == "Secret" and not State.SecretSeen[id] then
            State.SecretSeen[id] = true
            xDTaraZ:Notify(("Secret block spawned: %s (%s)"):format(block.BlockType, xDTaraZ.Format(info.SellValue)))
        end
    end
end

function xDTaraZ.Mine.Cycle()
    local session = xDTaraZ:Session()
    local areaName = xDTaraZ.Mine.PickArea(session)

    if session:GetMineAreaName() ~= areaName or GameLib.MineState.GetAreaName() ~= areaName then
        State.Status = "Entering " .. areaName
        if not xDTaraZ.Mine.Enter(areaName) then
            State.Status = "Could not enter " .. areaName
            return
        end
    end

    if State.NeedRefill or session.HeldBombs < session.MaxActiveBombs then
        State.NeedRefill = false
        xDTaraZ.Mine.Collect(session)
        session:LeaveMine()
    end

    for id, bomb in pairs(session.ActiveBombs) do
        if not bomb.IsFused and not tostring(id):match("^P") then session:IgniteBomb(id) end
    end

    State.Status = "Bombing " .. areaName
    local placed = xDTaraZ.Mine.PlaceBatch(session)
    if #placed == 0 then
        State.Status = "Resetting mine run"
        session:LeaveMine()
        task.wait(1)
        return
    end

    for _, bomb in ipairs(placed) do
        local serverId = xDTaraZ.Mine.WaitServerId(bomb)
        if serverId then
            session:IgniteBomb(serverId)
            State.Bombs += 1
        else
            State.NeedRefill = true
        end
    end

    xDTaraZ.Mine.WaitExploded(placed)
    xDTaraZ.Mine.Collect(session)
    if State.Opt.AutoSell then xDTaraZ.Mine.Sell(session) end
end

---@return table[]  placed bombs
function xDTaraZ.Mine.PlaceBatch(session)
    local placed = {}
    for _, pos in ipairs(xDTaraZ.Mine.FindBatch(session, mathMin(session.HeldBombs, session.MaxActiveBombs))) do
        local reply = session:PlaceBomb(cframeNew(pos))
        local bomb = reply and reply.Success and session.ActiveBombs[reply.Id]
        if not bomb then break end
        placed[#placed + 1] = bomb
    end
    return placed
end

function xDTaraZ.Mine.WaitExploded(bombs)
    local giveUp = os.clock() + Config.ExplodeTimeout
    local function anyLeft()
        for _, bomb in ipairs(bombs) do
            if not bomb.IsDestroyed then return true end
        end
        return false
    end

    while anyLeft() and os.clock() < giveUp do
        task.wait()
    end
    task.wait(Config.DropSettle)
end

xDTaraZ.Progress = {}

function xDTaraZ.Progress.Click()
    local reply = xDTaraZ:Invoke("ApplyClicks", { Config.ClicksPerBatch })
    if not (reply and reply.Success) then return end
    xDTaraZ:Session():ApplyDataUpdate({ Damage = reply.Damage, Level = reply.Level })
end

function xDTaraZ.Progress.StartClicking()
    task.spawn(function()
        while State.Alive and State.Opt.AutoClick do
            local ok, err = pcall(xDTaraZ.Progress.Click)
            if not ok then warn("[TNTMining] click:", err) end
            task.wait(Config.ClickInterval)
        end
    end)
end

---@return boolean  rebirth sent
function xDTaraZ.Progress.Rebirth()
    local session = xDTaraZ:Session()
    if session.Level < GameLib.Rebirth.GetRebirthLevelRequirement(session.Rebirths) then return false end
    session:PerformRebirth()
    return true
end

function xDTaraZ.Progress.BuyBestBomb()
    local session = xDTaraZ:Session()
    local target
    for _, name in ipairs(xDTaraZ.BombOrder) do
        if session:OwnsBomb(name) or session.Money >= GameLib.Bombs[name].Price then
            target = name
        end
    end
    if not target then return end

    if not session:OwnsBomb(target) then
        session:BuyBomb(target)
    elseif session.EquippedBomb ~= target and not session:IsPremiumBombEquipped() then
        session:EquipBomb(target)
    end
end

function xDTaraZ.Progress.BuyUpgrades()
    local session = xDTaraZ:Session()
    for _, name in ipairs(xDTaraZ.UpgradeNames) do
        if State.Opt.Upgrades[name] then session:BuyUpgrade(name) end
    end
end

function xDTaraZ.Progress.BuyLuck()
    local session = xDTaraZ:Session()
    session:BuyUpgrade("MineLuck", xDTaraZ.Mine.PickArea(session))
end

function xDTaraZ.Progress.BuyNextArea()
    local session = xDTaraZ:Session()
    for _, name in ipairs(xDTaraZ.AreaOrder) do
        if not session.OwnedAreas[name] then
            if session.Money >= GameLib.Areas[name].Price then session:PurchaseArea(name) end
            return
        end
    end
end

xDTaraZ.Pets = {}

function xDTaraZ.Pets.Hatch()
    local session = xDTaraZ:Session()
    local egg
    for _, name in ipairs(xDTaraZ.AreaOrder) do
        local price = GameLib.Areas[name].PetEggPrice
        if price and session.OwnedAreas[name] and session.EggShards >= price then egg = name end
    end
    if egg then session:HatchPetEgg(egg) end
end

---@return number  pets sold
function xDTaraZ.Pets.SellExtras()
    local session = xDTaraZ:Session()
    local keepRarity = State.Opt.KeepPetRarities

    local equipped = {}
    for _, id in ipairs(session.EquippedPets or {}) do equipped[id] = true end

    local pool = {}
    for id, petName in pairs(session.OwnedPets) do
        local info = GameLib.Pets[petName]
        if not equipped[id] and not (info and keepRarity[info.Rarity]) then
            pool[#pool + 1] = { id, session:GetPetDamagePerClickMultiplier(id) }
        end
    end
    table.sort(pool, function(a, b) return a[2] > b[2] end)

    local sell = {}
    for i = State.Opt.KeepPets + 1, #pool do
        sell[#sell + 1] = pool[i][1]
    end
    if #sell > 0 then session:SellPets(sell) end
    return #sell
end

xDTaraZ.Claim = {}

function xDTaraZ.Claim.All()
    local session = xDTaraZ:Session()
    pcall(session.ClaimDailyReward, session)
    pcall(session.ClaimGroupReward, session)

    for _, name in ipairs(xDTaraZ.AreaOrder) do
        if not session.ClaimedIndexRewards[name] and session:IsAreaIndexComplete(name) then
            session:ClaimIndexReward(name)
        end
    end
end

xDTaraZ.Client = {}

function xDTaraZ.Client.SetLowGraphics(enabled)
    RunService:Set3dRenderingEnabled(not enabled)
end

function xDTaraZ.Client.Bind()
    xDTaraZ:Connect(GuiService.ErrorMessageChanged, function(msg)
        if not State.Opt.AutoRejoin or msg == "" then return end
        task.delay(Config.RejoinDelay, TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
    end)
end

xDTaraZ.Movement = {}

function xDTaraZ.Movement.Apply()
    local hum = xDTaraZ:Humanoid()
    if not hum then return end
    hum.WalkSpeed = State.Opt.SpeedOn and State.Opt.WalkSpeed or xDTaraZ:Session():GetUpgradeValue("WalkSpeed")
end

function xDTaraZ.Movement.Bind()
    xDTaraZ:Connect(UserInputService.JumpRequest, function()
        local hum = xDTaraZ:Humanoid()
        if State.Opt.InfJump and hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)

    xDTaraZ:Connect(LocalPlayer.CharacterAdded, function()
        task.wait(1)
        if State.Opt.SpeedOn then State.Requests.Speed = true end
    end)

    xDTaraZ:Connect(LocalPlayer.Idled, function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.zero)
    end)
end

xDTaraZ.Scheduler = {}

xDTaraZ.Scheduler.RequestHandlers = {
    Speed = xDTaraZ.Movement.Apply,
    BombNow = xDTaraZ.Progress.BuyBestBomb,
    UpgradeNow = xDTaraZ.Progress.BuyUpgrades,
    AreaNow = xDTaraZ.Progress.BuyNextArea,
    LuckNow = xDTaraZ.Progress.BuyLuck,
    HatchNow = xDTaraZ.Pets.Hatch,
    ClaimNow = xDTaraZ.Claim.All,

    SellNow = function()
        local session = xDTaraZ:Session()
        xDTaraZ.Mine.Collect(session)
        xDTaraZ.Mine.Sell(session)
        xDTaraZ:Notify("Sold all blocks")
    end,
    RebirthNow = function()
        xDTaraZ:Notify(xDTaraZ.Progress.Rebirth() and "Rebirthed" or "Level too low to rebirth")
    end,
    EquipPetsNow = function()
        xDTaraZ:Session():EquipBestPets()
    end,
    SellPetsNow = function()
        xDTaraZ:Notify(("Sold %d pets"):format(xDTaraZ.Pets.SellExtras()))
    end,
    CollectNow = function()
        xDTaraZ:Notify(("Collected %d drops"):format(xDTaraZ.Mine.Collect(xDTaraZ:Session())))
    end,
}

function xDTaraZ.Scheduler.Run(fn)
    local ok, err = pcall(fn)
    if not ok then warn("[TNTMining]", err) end
end

---@param key string  State field holding last run time
function xDTaraZ.Scheduler.Every(key, interval, fn)
    local now = os.clock()
    if now - State[key] < interval then return end
    State[key] = now
    xDTaraZ.Scheduler.Run(fn)
end

function xDTaraZ.Scheduler.Summarize()
    local session = xDTaraZ:Session()
    local fmt = xDTaraZ.Format
    State.Summary = ("Level %d · Rebirth %d · Damage %s\nMoney %s · Shards %d\nMoney/min %s"):format(
        session.Level, session.Rebirths, fmt(session.Damage),
        fmt(session.Money), session.EggShards,
        fmt(xDTaraZ.Mine.EarnRate()))
end

function xDTaraZ.Scheduler.Purchases()
    local opt = State.Opt
    if opt.AutoBomb then xDTaraZ.Progress.BuyBestBomb() end
    if opt.AutoUpgrade then xDTaraZ.Progress.BuyUpgrades() end
    if opt.AutoArea then xDTaraZ.Progress.BuyNextArea() end
    if opt.AutoLuck then xDTaraZ.Progress.BuyLuck() end
    if opt.AutoEquipPets then xDTaraZ:Session():EquipBestPets() end
    if opt.AutoSellPets then xDTaraZ.Pets.SellExtras() end
    if opt.SecretAlert and GameLib.MineState.IsLoaded() then xDTaraZ.Mine.ScanSecrets() end
end

function xDTaraZ.Scheduler.Step()
    local opt = State.Opt
    xDTaraZ.Scheduler.Run(xDTaraZ.Scheduler.Summarize)

    for name, handler in pairs(xDTaraZ.Scheduler.RequestHandlers) do
        if State.Requests[name] then
            State.Requests[name] = nil
            xDTaraZ.Scheduler.Run(handler)
        end
    end

    if opt.AutoRebirth then xDTaraZ.Scheduler.Run(xDTaraZ.Progress.Rebirth) end
    xDTaraZ.Scheduler.Every("LastPurchase", Config.PurchaseInterval, xDTaraZ.Scheduler.Purchases)
    if opt.AutoHatch then xDTaraZ.Scheduler.Every("LastHatch", Config.HatchInterval, xDTaraZ.Pets.Hatch) end
    if opt.AutoClaim then xDTaraZ.Scheduler.Every("LastClaim", Config.ClaimInterval, xDTaraZ.Claim.All) end

    if opt.AutoMine then
        xDTaraZ.Scheduler.Run(xDTaraZ.Mine.Cycle)
        return
    end

    State.Status = "Idle"
    if opt.AutoCollect then
        xDTaraZ.Scheduler.Run(function() xDTaraZ.Mine.Collect(xDTaraZ:Session()) end)
    end
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Movement.Bind()
    xDTaraZ.Client.Bind()

    task.spawn(function()
        while State.Alive do
            if not State.Busy then
                State.Busy = true
                xDTaraZ.Scheduler.Step()
                State.Busy = false
            end
            task.wait(Config.TickDelay)
        end
    end)
end

function xDTaraZ.Scheduler.Stop()
    State.Alive = false
    State.Opt.AutoClick = false

    for _, conn in ipairs(State.Connections) do conn:Disconnect() end
    table.clear(State.Connections)

    if State.Opt.LowGraphics then xDTaraZ.Client.SetLowGraphics(false) end

    local hum = xDTaraZ:Humanoid()
    if hum and State.Opt.SpeedOn then hum.WalkSpeed = GameLib.Upgrades.WalkSpeed.BaseValue end
end

local function BuildInterface()
    local Library = loadstring(game:HttpGet(Config.UiSource))()
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt

    local kaitunKeys = { "AutoMine", "AutoSell", "AutoClick", "AutoRebirth", "AutoBomb", "AutoUpgrade", "AutoArea", "AutoLuck", "AutoClaim", "AutoHatch", "AutoEquipPets", "AutoSellPets" }

    local function Notify(text, kind)
        Library:Notify("TNT Mining", text, 4, kind or "Info")
    end

    local function Request(name)
        return function()
            State.Requests[name] = true
        end
    end

    local function Store(key, onChange)
        return function(value)
            opt[key] = value
            if onChange then onChange(value) end
        end
    end

    ---@param info table  Text, Description, Icon, Now = { text, request }, Risky, Options
    local function Feature(group, key, info)
        local now = info.Now and { Text = info.Now[1], Callback = Request(info.Now[2]) }
        return group:AddFeature(key, {
            Text = info.Text,
            Description = info.Description,
            Icon = info.Icon,
            Risky = info.Risky,
            Badge = info.Risky and T("Risky", "เสี่ยง") or nil,
            Keybind = { Default = "None", Mode = "Toggle" },
            Now = now,
            Options = info.Options,
            Default = false,
            Callback = Store(key, info.OnChange),
        })
    end

    local function BuildMain(window)
        window:AddTabSection(T("Main", "หลัก"))
        local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and all-in-one mode", "สถานะและโหมดทำทุกอย่าง"))

        local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "stats")
        status:AddStatus("StatusRun", { Text = T("Farm", "ฟาร์ม"), Icon = "auto-mine", Default = { "Idle", "Idle" } })
        local summary = status:AddLabel("Loading...", true)

        local live = tab:AddLeftGroupbox(T("Live", "ตัวเลขสด"), "chart")
        live:AddStat("StatEarned", { Text = T("Earned", "รายได้"), Icon = "coin", Format = "%s", Token = "Coin" })
        live:AddStat("StatBombs", { Text = T("Bombs used", "ระเบิดที่ใช้"), Icon = "bomb", Format = "%s" })

        local kaitun = tab:AddRightGroupbox("Kaitun", "kaitun")
        kaitun:AddToggle("Kaitun", {
            Text = T("Kaitun", "ไก่ตัน"),
            Description = T("Mines, sells, trains, buys and rebirths by itself", "ขุด ขาย ฝึก ซื้อของ และรีเบิร์ธให้เองทั้งหมด"),
            Icon = "kaitun",
            Default = false,
            NoSave = true,
            Callback = function(value)
                for _, key in ipairs(kaitunKeys) do
                    Options[key]:SetValue(value)
                end
            end,
        })

        Library.Kit.Discord.Build(tab, Config.Discord)
        return summary
    end

    local function BuildMining(window)
        local tab = window:AddTab(T("Mining", "ขุด"), "bomb", T("Auto mining and selling", "ขุดและขายอัตโนมัติ"))

        local areaChoices = { "Best" }
        for _, areaName in ipairs(xDTaraZ.AreaOrder) do table.insert(areaChoices, areaName) end

        local mine = tab:AddLeftGroupbox(T("Auto Mine", "ขุดอัตโนมัติ"), "auto-mine")
        Feature(mine, "AutoMine", {
            Text = T("Auto Mine", "ขุดอัตโนมัติ"),
            Description = T("Blasts the most valuable spots and picks up every drop", "ระเบิดจุดที่มีค่าที่สุดแล้วเก็บของดรอปทั้งหมด"),
            Icon = "tnt",
            Options = function(options)
                options:AddDropdown("MineArea", {
                    Text = T("Mine Area", "พื้นที่ขุด"),
                    Description = T("Best = strongest area you can break", "Best = พื้นที่ดีสุดที่ขุดไหว"),
                    Icon = "area",
                    Values = areaChoices,
                    Default = "Best",
                    Searchable = true,
                    Callback = function(value) opt.MineArea = value or "Best" end,
                })
                options:AddToggle("TargetShards", { Text = T("Egg Shards First", "เน้นเศษไข่ก่อน"), Icon = "crystal", Default = false, Callback = Store("TargetShards") })
            end,
        })
        mine:AddToggle("SecretAlert", {
            Text = T("Secret Block Alert", "แจ้งเตือนบล็อก Secret"),
            Icon = "notification",
            Default = false,
            Callback = Store("SecretAlert"),
        })

        Feature(mine, "AutoCollect", {
            Text = T("Auto Collect", "เก็บของอัตโนมัติ"),
            Description = T("Picks up every drop in your mine from anywhere", "เก็บของดรอปทั้งเหมืองจากทุกที่"),
            Icon = "auto-collect",
            Risky = true,
            Now = { T("Collect Now", "เก็บเดี๋ยวนี้"), "CollectNow" },
        })

        local sell = tab:AddRightGroupbox(T("Sell", "ขาย"), "sell")
        Feature(sell, "AutoSell", {
            Text = T("Auto Sell", "ขายอัตโนมัติ"),
            Description = T("Sells blocks after every blast, favorites are kept", "ขายบล็อกหลังระเบิดทุกครั้ง เก็บบล็อกที่กดชอบไว้"),
            Icon = "auto-sell",
            Now = { T("Sell All Now", "ขายทั้งหมดเดี๋ยวนี้"), "SellNow" },
        })
    end

    local function BuildUpgrades(window)
        window:AddTabSection(T("Progress", "ความคืบหน้า"))
        local tab = window:AddTab(T("Upgrades", "อัปเกรด"), "upgrades", T("Damage, bombs, areas and rebirth", "ดาเมจ ระเบิด พื้นที่ และรีเบิร์ธ"))

        local train = tab:AddLeftGroupbox(T("Damage & Rebirth", "ดาเมจและรีเบิร์ธ"), "rebirths")
        Feature(train, "AutoClick", {
            Text = T("Auto Click", "คลิกอัตโนมัติ"),
            Description = T("Trains damage as fast as the game allows", "เพิ่มดาเมจเร็วสุดเท่าที่เกมยอม"),
            Icon = "auto-clicker",
            OnChange = function(value)
                if value then xDTaraZ.Progress.StartClicking() end
            end,
        })
        Feature(train, "AutoRebirth", {
            Text = T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"),
            Description = T("Rebirths as soon as your level is high enough", "รีเบิร์ธทันทีเมื่อเลเวลถึง"),
            Icon = "rebirths",
            Now = { T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), "RebirthNow" },
        })

        opt.Upgrades = { MaxHeldBombs = true, MaxActiveBombs = true }
        local upgrades = tab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "upgrades")
        Feature(upgrades, "AutoUpgrade", {
            Text = T("Auto Buy Upgrades", "ซื้ออัปเกรดอัตโนมัติ"),
            Icon = "auto-buy",
            Now = { T("Buy Now", "ซื้อเดี๋ยวนี้"), "UpgradeNow" },
            Options = function(options)
                options:AddDropdown("Upgrades", {
                    Text = T("Upgrades To Buy", "อัปเกรดที่จะซื้อ"),
                    Icon = "list-menu",
                    Values = xDTaraZ.UpgradeNames,
                    Multi = true,
                    Default = { "MaxHeldBombs", "MaxActiveBombs" },
                    Callback = function(selected) opt.Upgrades = selected end,
                })
            end,
        })

        local shop = tab:AddRightGroupbox(T("Shop", "ร้านค้า"), "shop")
        Feature(shop, "AutoBomb", {
            Text = T("Auto Buy Best Bomb", "ซื้อระเบิดดีสุดอัตโนมัติ"),
            Description = T("Buys and equips the strongest bomb you can afford", "ซื้อและใส่ระเบิดที่แรงที่สุดที่ซื้อไหว"),
            Icon = "bombs",
            Now = { T("Buy Bomb Now", "ซื้อระเบิดเดี๋ยวนี้"), "BombNow" },
        })
        Feature(shop, "AutoArea", {
            Text = T("Auto Buy Next Area", "ซื้อพื้นที่ถัดไปอัตโนมัติ"),
            Icon = "areas",
            Now = { T("Buy Area Now", "ซื้อพื้นที่เดี๋ยวนี้"), "AreaNow" },
        })
        Feature(shop, "AutoLuck", {
            Text = T("Auto Buy Mine Luck", "ซื้อโชคเหมืองอัตโนมัติ"),
            Description = T("Upgrades luck for the area you mine", "อัปโชคของพื้นที่ที่กำลังขุด"),
            Icon = "luck",
            Now = { T("Buy Luck Now", "ซื้อโชคเดี๋ยวนี้"), "LuckNow" },
        })
    end

    local function BuildPets(window)
        local tab = window:AddTab(T("Pets & Rewards", "สัตว์เลี้ยงและรางวัล"), "pets", T("Eggs, pets and free rewards", "ไข่ สัตว์เลี้ยง และรางวัลฟรี"))

        local pets = tab:AddLeftGroupbox(T("Pets", "สัตว์เลี้ยง"), "pets")
        Feature(pets, "AutoHatch", {
            Text = T("Auto Hatch", "ฟักไข่อัตโนมัติ"),
            Description = T("Hatches the best egg your shards can pay for", "ฟักไข่ที่ดีที่สุดที่เศษไข่พอ"),
            Icon = "auto-hatch",
            Now = { T("Hatch Now", "ฟักเดี๋ยวนี้"), "HatchNow" },
        })
        Feature(pets, "AutoEquipPets", {
            Text = T("Auto Equip Best", "ใส่ตัวดีสุดอัตโนมัติ"),
            Icon = "best",
            Now = { T("Equip Now", "ใส่เดี๋ยวนี้"), "EquipPetsNow" },
        })

        local petRarities = {}
        for rarity in pairs(GameLib.Pets.Rarities) do petRarities[#petRarities + 1] = rarity end
        table.sort(petRarities, function(a, b) return GameLib.Pets.Rarities[a].Weight > GameLib.Pets.Rarities[b].Weight end)

        local petSell = tab:AddLeftGroupbox(T("Sell Pets", "ขายสัตว์เลี้ยง"), "sell")
        Feature(petSell, "AutoSellPets", {
            Text = T("Auto Sell Pets", "ขายสัตว์เลี้ยงอัตโนมัติ"),
            Description = T("Keeps your strongest pets and sells the rest", "เก็บตัวที่แรงที่สุดไว้ ขายที่เหลือ"),
            Icon = "auto-sell",
            Now = { T("Sell Extras Now", "ขายส่วนเกินเดี๋ยวนี้"), "SellPetsNow" },
            Options = function(options)
                options:AddStepper("KeepPets", {
                    Text = T("Keep Best", "เก็บตัวดีสุด"),
                    Icon = "keep",
                    Min = 0, Max = 50, Step = 1, Default = opt.KeepPets,
                    Callback = function(value) opt.KeepPets = tonumber(value) or opt.KeepPets end,
                })
                options:AddMultiChips("KeepPetRarities", {
                    Text = T("Never Sell", "ห้ามขาย"),
                    Icon = "rarity",
                    Values = petRarities,
                    Default = {},
                    Callback = function(selected) opt.KeepPetRarities = selected end,
                })
            end,
        })

        local rewards = tab:AddRightGroupbox(T("Rewards", "รางวัล"), "rewards")
        Feature(rewards, "AutoClaim", {
            Text = T("Auto Claim", "รับรางวัลอัตโนมัติ"),
            Description = T("Claims daily, group and index rewards", "รับรางวัลรายวัน กลุ่ม และสมุดสะสม"),
            Icon = "auto-claim",
            Now = { T("Claim Now", "รับเดี๋ยวนี้"), "ClaimNow" },
        })
    end

    local function BuildPlayer(window)
        window:AddTabSection(T("Other", "อื่นๆ"))
        local tab = window:AddTab(T("Player", "ผู้เล่น"), "player", T("Movement", "การเคลื่อนที่"))

        local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "movement")
        Feature(move, "SpeedOn", {
            Text = T("Speed", "ความเร็ว"),
            Icon = "walkspeed",
            OnChange = Request("Speed"),
            Options = function(options)
                options:AddSlider("WalkSpeed", {
                    Text = T("Walk Speed", "ความเร็วเดิน"),
                    Icon = "speed",
                    Min = 16, Max = 200, Default = opt.WalkSpeed, Rounding = 0,
                    Callback = function(value)
                        opt.WalkSpeed = tonumber(value) or opt.WalkSpeed
                        State.Requests.Speed = true
                    end,
                })
            end,
        })
        Feature(move, "InfJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด"), Icon = "inf-jump" })
    end

    local function BuildSettings(window)
        local tab = window:AddSettingsTab()
        local session = tab:AddLeftGroupbox(T("Session", "เซสชัน"), "session")
        session:AddToggle("AutoRejoin", {
            Text = T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"),
            Description = T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"),
            Icon = "auto-rejoin",
            Default = false,
            Callback = Store("AutoRejoin"),
        })
        session:AddToggle("LowGraphics", {
            Text = T("FPS Boost", "เพิ่ม FPS"),
            Description = T("Turns off 3D rendering to save CPU and GPU", "ปิดการแสดงผล 3D ประหยัด CPU/GPU"),
            Icon = "fps-boost",
            Default = false,
            Callback = Store("LowGraphics", xDTaraZ.Client.SetLowGraphics),
        })
    end

    local function BuildTabs()
        local window = Library.Window
        local summary = BuildMain(window)
        BuildMining(window)
        BuildUpgrades(window)
        BuildPets(window)
        BuildPlayer(window)
        BuildSettings(window)

        Library:Every(1, function()
            while #State.Messages > 0 do
                Notify(table.remove(State.Messages, 1))
            end
            local kind = State.Status == "Idle" and "Idle" or "Running"
            Options.StatusRun:SetValue(State.Status, kind)
            Options.StatEarned:SetValue(State.Earned)
            Options.StatBombs:SetValue(State.Bombs)
            summary:SetText(State.Summary)
        end)
    end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    getgenv().TNTMiningUnload = function()
        Library:Unload()
    end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "TNT Mining by xDTaraZ",
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

if getgenv().TNTMiningUnload then
    pcall(getgenv().TNTMiningUnload)
end

BuildInterface()