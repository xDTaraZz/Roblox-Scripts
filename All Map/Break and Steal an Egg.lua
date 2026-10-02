if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765288803 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Break and Steal an Egg only")
    return
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local osClock = os.clock
local vector3New, cframeNew = Vector3.new, CFrame.new

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    SaveFolder = "Break and Steal an Egg",
    TickDelay = 0.05,
    TpSettle = 0.12,
    GrabTimeout = 1,
    SkipFor = 4,
    BankTimeout = 2.5,
    HitSlice = 1.2,
    TripCost = 1,
    EggOffset = vector3New(0, 3, 3.5),
    PromptMatch = 30,
    BreakPickupRadius = 40,
    EquipInterval = 2,
    BuyInterval = 1.5,
    ClaimInterval = 31,
    EggInterval = 5,
    EggSpacing = 8,
    SellInterval = 4,
    EspInterval = 0.4,
    BatRange = 15,
    BatGap = 0.72,
    RejoinDelay = 5,
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Requests = {},
    Messages = {},
    Last = {},
    Status = "Idle",
    Steals = 0,
    Broken = 0,
    Banked = 0,
    StartCash = nil,
    StartAt = osClock(),
    HitTokens = 3,
    HitStamp = osClock(),
    BreakSpot = nil,
    Opt = {
        AutoSteal = false,
        Take = "Upgrades Only",
        StealRarities = {},
        StealMinValue = 0,
        AutoBreak = false,
        BreakZone = "Best",
        MaxHits = 40,
        RobCarriers = false,
        AutoPlace = false,
        AutoSell = false,
        KeepRarities = {},
        AutoBuyPickaxe = false,
        AutoUpgradePlot = false,
        AutoTrail = false,
        AutoTreadmill = false,
        CashReserve = 0,
        AutoClaim = false,
        AutoHatch = false,
        BatTarget = nil,
        BatLoop = false,
        BatAura = false,
        EspPickups = false,
        EspEggs = false,
        EspPlayers = false,
        EspMinRarity = "Common",
        SpeedOn = false,
        WalkSpeed = 80,
        InfJump = false,
        Noclip = false,
        AntiAfk = false,
        AutoRejoin = false,
    },
}

local Config, State = xDTaraZ.Config, xDTaraZ.State
local Shared = ReplicatedStorage:WaitForChild("Shared")

xDTaraZ.GameLib = {
    Eggs = require(Shared.EggConfig),
    Rewards = require(Shared.EggRewards),
    Rarity = require(Shared.EggRarity),
    Pickaxe = require(Shared.PickaxeConfig),
    Zones = require(Shared.ZonesConfig),
    Plot = require(Shared.PlotUpgradeConfig),
    Treadmill = require(Shared.TreadmillUpgradeConfig),
    Trails = require(Shared.TrailsConfig),
    Bat = require(Shared.BatConfig),
    Speed = require(Shared.SpeedConfig),
    Remote = setmetatable({}, {
        __index = function(self, name)
            local remote = ReplicatedStorage:FindFirstChild(name)
            if remote then rawset(self, name, remote) end
            return remote
        end,
    }),
}

local GameLib = xDTaraZ.GameLib

xDTaraZ.Caps = {
    Prompt = type(fireproximityprompt) == "function",
}

xDTaraZ.RarityLadder = GameLib.Rarity.Ladder()
xDTaraZ.RarityRank = {}
do
    for i, name in ipairs(xDTaraZ.RarityLadder) do
        xDTaraZ.RarityRank[name] = i
    end
end

xDTaraZ.ZoneList = {}
do
    for index, zone in pairs(GameLib.Zones.Zones) do
        table.insert(xDTaraZ.ZoneList, { Index = index, Name = zone.Name or ("Zone" .. index), Rarity = zone.Rarity, Power = zone.RequiredPower or 0 })
    end
    table.sort(xDTaraZ.ZoneList, function(a, b) return a.Index < b.Index end)
end

xDTaraZ.ZonePool = {}
do
    for _, entry in ipairs(GameLib.Rewards.Pool) do
        local zone = entry.Zone
        if not zone then continue end
        xDTaraZ.ZonePool[zone] = xDTaraZ.ZonePool[zone] or {}
        table.insert(xDTaraZ.ZonePool[zone], { Name = entry.Name, Chance = entry.Chance or 1 })
    end
end

function xDTaraZ.Format(n)
    n = tonumber(n) or 0
    local units = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }
    local i = 1
    while math.abs(n) >= 1000 and i < #units do
        n /= 1000
        i += 1
    end
    return (i == 1 and "%d%s" or "%.2f%s"):format(n, units[i])
end

function xDTaraZ:Notify(msg)
    table.insert(State.Messages, msg)
end

function xDTaraZ:Character()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp and hum.Health > 0) then return nil end
    return char, hum, hrp
end

function xDTaraZ:Connect(signal, handler)
    local conn = signal:Connect(handler)
    table.insert(State.Connections, conn)
    return conn
end

function xDTaraZ:Fire(name, ...)
    local remote = GameLib.Remote[name]
    if remote then remote:FireServer(...) end
end

function xDTaraZ.Attr(name, fallback)
    local value = LocalPlayer:GetAttribute(name)
    if value == nil then return fallback end
    return value
end

function xDTaraZ.Spendable()
    return xDTaraZ.Attr("Cash", 0) - (State.Opt.CashReserve or 0)
end

xDTaraZ.Move = {}

function xDTaraZ.Move.To(cf)
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return false end
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.CFrame = cf
    return true
end

function xDTaraZ.Move.ApplySpeed()
    local _, hum = xDTaraZ:Character()
    if not hum then return end
    if State.Opt.SpeedOn then
        hum.WalkSpeed = State.Opt.WalkSpeed
    elseif State.SpeedTouched then
        hum.WalkSpeed = GameLib.Speed.SpeedPowerToWalkSpeed(xDTaraZ.Attr("SpeedPower", 0))
        State.SpeedTouched = false
    end
end

function xDTaraZ.Move.HoldSpeed(hum)
    if State.SpeedConn then State.SpeedConn:Disconnect() end
    State.SpeedConn = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if State.Opt.SpeedOn and hum.WalkSpeed ~= State.Opt.WalkSpeed then hum.WalkSpeed = State.Opt.WalkSpeed end
    end)
end

function xDTaraZ.Move.SetNoclip(on)
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            if on then
                if part.CanCollide then
                    State.NoclipParts = State.NoclipParts or {}
                    State.NoclipParts[part] = true
                    part.CanCollide = false
                end
            elseif State.NoclipParts and State.NoclipParts[part] then
                part.CanCollide = true
            end
        end
    end
    if not on then State.NoclipParts = nil end
end

xDTaraZ.Base = {}

function xDTaraZ.Base.Own()
    local cached = State.Plot
    if cached and cached.Parent and cached:GetAttribute("OwnerUserId") == LocalPlayer.UserId then return cached end
    for _, plot in ipairs(Workspace.Plots:GetChildren()) do
        if plot:GetAttribute("OwnerUserId") == LocalPlayer.UserId then
            State.Plot = plot
            return plot
        end
    end
    return nil
end

function xDTaraZ.Base.Hitbox()
    local plot = xDTaraZ.Base.Own()
    return plot and plot:FindFirstChild("Hitbox", true)
end

function xDTaraZ.Base.Home()
    local hitbox = xDTaraZ.Base.Hitbox()
    if hitbox then xDTaraZ.Move.To(hitbox.CFrame + vector3New(0, 2, 0)) end
end

---@return number  cash/s an animal must beat to be worth taking
function xDTaraZ.Base.Floor()
    if State.Opt.Take == "Everything" then return -1 end
    return xDTaraZ.Base.Weakest()
end

---@return number  weakest placed cash/s, 0 while slots are free
function xDTaraZ.Base.Weakest()
    local cached = State.FloorCache
    if cached and osClock() - cached[1] < 1 then return cached[2] end
    local plot = xDTaraZ.Base.Own()
    local placed = plot and plot:FindFirstChild("PlacedAnimals")
    local floor = 0
    if placed and #placed:GetChildren() >= (plot:GetAttribute("MaxAnimals") or math.huge) then
        floor = math.huge
        for _, animal in ipairs(placed:GetChildren()) do
            floor = math.min(floor, animal:GetAttribute("CashPerSecond") or 0)
        end
    end
    State.FloorCache = { osClock(), floor }
    return floor
end

function xDTaraZ.Base.Carry()
    return xDTaraZ.Attr("CarryCount", 0), xDTaraZ.Attr("SatchelCapacity", 1)
end

---@return boolean  true once everything carried is banked
function xDTaraZ.Base.Bank()
    local hitbox = xDTaraZ.Base.Hitbox()
    if not hitbox then return false end
    State.Status = "Banking"
    local before = xDTaraZ.Base.Carry()
    local deadline = osClock() + Config.BankTimeout
    repeat
        xDTaraZ.Move.To(hitbox.CFrame + vector3New(0, 2, 0))
        task.wait()
    until xDTaraZ.Base.Carry() == 0 or osClock() > deadline
    local done = xDTaraZ.Base.Carry() == 0
    if done then
        State.Banked += before
        State.BreakSpot = nil
        State.Last.Banked = osClock()
        State.Requests.Place = State.Opt.AutoPlace or nil
    end
    return done
end

xDTaraZ.Pickup = {}

---@return number  cash per second once placed
function xDTaraZ.Pickup.Value(model)
    local name = model:GetAttribute("AnimalName")
    if type(name) ~= "string" then return 0 end
    local ok, value = pcall(GameLib.Rewards.PlacedCashPerSecond, name, model:GetAttribute("SizeMult") or 1, model:GetAttribute("Mutation"), model:GetAttribute("WeightKg"), model:GetAttribute("Variant"))
    return ok and value or 0
end

function xDTaraZ.Pickup.PromptFor(model)
    local pos = model:GetPivot().Position
    local best, bestDist = nil, Config.PromptMatch
    for _, prompt in ipairs(CollectionService:GetTagged("SmartPrompt")) do
        local anchor = prompt.Name == "StealPrompt" and prompt.Parent
        if anchor and anchor:IsA("BasePart") then
            local dist = (anchor.Position - pos).Magnitude
            if dist < bestDist then best, bestDist = prompt, dist end
        end
    end
    return best
end

function xDTaraZ.Pickup.Allowed(model, value)
    local opt = State.Opt
    if next(opt.StealRarities) and not opt.StealRarities[model:GetAttribute("Rarity") or ""] then return false end
    return value >= (opt.StealMinValue or 0)
end

---@return Model?  best pickup to take next
function xDTaraZ.Pickup.Next()
    local opt = State.Opt
    local folder = Workspace:FindFirstChild("AnimalPickups")
    if not folder then return nil end
    local floor = xDTaraZ.Base.Floor()
    local best, bestValue = nil, floor
    for _, model in ipairs(folder:GetChildren()) do
        local value = xDTaraZ.Pickup.Value(model)
        if value <= bestValue or osClock() < (State.Skip and State.Skip[model] or 0) then continue end
        local fromBreak = State.BreakSpot and (model:GetPivot().Position - State.BreakSpot).Magnitude < Config.BreakPickupRadius
        if (opt.AutoSteal and xDTaraZ.Pickup.Allowed(model, value)) or (opt.AutoBreak and fromBreak) then
            best, bestValue = model, value
        end
    end
    return best
end

function xDTaraZ.Pickup.Trigger(prompt)
    if xDTaraZ.Caps.Prompt then
        fireproximityprompt(prompt)
        return
    end
    prompt:InputHoldBegin()
    task.wait(prompt.HoldDuration)
    prompt:InputHoldEnd()
end

---@return boolean  true if it ended up in the satchel
function xDTaraZ.Pickup.Grab(model)
    local prompt = xDTaraZ.Pickup.PromptFor(model)
    State.Skip = State.Skip or setmetatable({}, { __mode = "k" })
    if not prompt then
        State.Skip[model] = osClock() + Config.SkipFor
        return false
    end
    State.Status = "Stealing " .. tostring(model:GetAttribute("AnimalName"))
    local before = xDTaraZ.Base.Carry()
    xDTaraZ.Move.To(cframeNew(prompt.Parent.Position + vector3New(0, 2, 0)))
    task.wait(Config.TpSettle)
    xDTaraZ.Pickup.Trigger(prompt)
    local deadline = osClock() + Config.GrabTimeout
    repeat task.wait() until xDTaraZ.Base.Carry() > before or not model.Parent or osClock() > deadline
    local got = xDTaraZ.Base.Carry() > before
    if got then State.Steals += 1 else State.Skip[model] = osClock() + Config.SkipFor end
    return got
end

xDTaraZ.Break = {}

function xDTaraZ.Break.Damage()
    return GameLib.Pickaxe.GetDamage(xDTaraZ.Attr("PickaxeTier", 1))
end

function xDTaraZ.Break.Alive(egg)
    return egg.Parent ~= nil and not egg:GetAttribute("Broken") and (egg:GetAttribute("Health") or 0) > 0
end

---@return number  average cash/s of what hatches from it
function xDTaraZ.Break.Expected(egg)
    State.EggWorth = State.EggWorth or setmetatable({}, { __mode = "k" })
    local cached = State.EggWorth[egg]
    if cached then return cached end
    local zone, weight = egg:GetAttribute("ZoneIndex"), egg:GetAttribute("WeightKg")
    local total, chances = 0, 0
    for _, entry in ipairs(xDTaraZ.ZonePool[zone] or {}) do
        local ok, value = pcall(GameLib.Rewards.PlacedCashPerSecond, entry.Name, nil, nil, weight)
        if ok then
            total += entry.Chance * value
            chances += entry.Chance
        end
    end
    local worth = chances > 0 and total / chances or 0
    State.EggWorth[egg] = worth
    return worth
end

---@return BasePart?  egg with the most cash per second spent that beats the base
function xDTaraZ.Break.Pick()
    local opt = State.Opt
    local damage = xDTaraZ.Break.Damage()
    local floor = xDTaraZ.Base.Floor()
    local burst, cooldown = GameLib.Eggs.HitBurst, GameLib.Eggs.HitCooldown
    local wantZone = opt.BreakZone ~= "Best" and tonumber(tostring(opt.BreakZone):match("%d+")) or nil
    local best, bestScore
    for _, egg in ipairs(CollectionService:GetTagged("BreakableEgg")) do
        if not xDTaraZ.Break.Alive(egg) then continue end
        if wantZone and egg:GetAttribute("ZoneIndex") ~= wantZone then continue end
        local hits = math.ceil(egg:GetAttribute("Health") / damage)
        if hits > opt.MaxHits then continue end
        local worth = xDTaraZ.Break.Expected(egg)
        if worth <= floor then continue end
        local score = worth / (math.max(hits - burst, 0) * cooldown + Config.TripCost)
        if not best or score > bestScore then best, bestScore = egg, score end
    end
    return best
end

function xDTaraZ.Break.EquipPickaxe()
    local char, hum = xDTaraZ:Character()
    if not char then return false end
    if char:FindFirstChild(GameLib.Pickaxe.ToolName) then return true end
    local tool = LocalPlayer.Backpack:FindFirstChild(GameLib.Pickaxe.ToolName)
    if not tool then return false end
    hum:EquipTool(tool)
    return true
end

function xDTaraZ.Break.TakeToken()
    local now = osClock()
    local cooldown = GameLib.Eggs.HitCooldown
    State.HitTokens = math.min(GameLib.Eggs.HitBurst, State.HitTokens + (now - State.HitStamp) / cooldown)
    State.HitStamp = now
    if State.HitTokens >= 1 then
        State.HitTokens -= 1
        return 0
    end
    return (1 - State.HitTokens) * cooldown
end

function xDTaraZ.Break.Hit(egg)
    if not xDTaraZ.Break.EquipPickaxe() then
        State.Status = "No pickaxe"
        return
    end
    State.Status = ("Breaking %s (Zone %s)"):format(tostring(egg:GetAttribute("EggType")), tostring(egg:GetAttribute("ZoneIndex")))
    State.BreakSpot = egg.Position
    local remote = GameLib.Remote.EggHitRequest
    local stop = osClock() + Config.HitSlice
    while xDTaraZ.Break.Alive(egg) and State.Opt.AutoBreak and osClock() < stop do
        xDTaraZ.Move.To(cframeNew(egg.Position + Config.EggOffset, egg.Position))
        local waitFor
        repeat
            waitFor = xDTaraZ.Break.TakeToken()
            if waitFor > 0 then task.wait(waitFor) end
        until waitFor == 0
        remote:FireServer(egg)
    end
    if not xDTaraZ.Break.Alive(egg) then State.Broken += 1 end
end

xDTaraZ.Bat = {}

function xDTaraZ.Bat.Equip()
    local char, hum = xDTaraZ:Character()
    if not char then return false end
    if char:FindFirstChild(GameLib.Bat.ToolName) then return true end
    local tool = LocalPlayer.Backpack:FindFirstChild(GameLib.Bat.ToolName)
    if not tool then return false end
    hum:EquipTool(tool)
    return true
end

function xDTaraZ.Bat.RootOf(player)
    local char = player and player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp and hum.Health > 0) then return nil end
    return hrp
end

---@return boolean  true if a swing went out
function xDTaraZ.Bat.Swing(player, approach)
    local target = xDTaraZ.Bat.RootOf(player)
    if not target then return false end
    if osClock() - (State.Last.Bat or 0) < Config.BatGap then return false end
    if not xDTaraZ.Bat.Equip() then return false end
    if approach then
        xDTaraZ.Move.To(target.CFrame * cframeNew(0, 0, 3))
        task.wait(Config.TpSettle)
    end
    State.Last.Bat = osClock()
    xDTaraZ:Fire("BatHitRequest", player)
    return true
end

function xDTaraZ.Bat.Carrier()
    local best, bestCount = nil, 0
    for _, player in ipairs(Players:GetPlayers()) do
        local count = player ~= LocalPlayer and (player:GetAttribute("CarryCount") or 0) or 0
        if count > bestCount and xDTaraZ.Bat.RootOf(player) then best, bestCount = player, count end
    end
    return best
end

function xDTaraZ.Bat.Aura()
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return end
    local range = Config.BatRange * (xDTaraZ.Attr("BatHitboxMultiplier", 1)) + GameLib.Bat.Targeting.HitTolerance
    for _, player in ipairs(Players:GetPlayers()) do
        local root = player ~= LocalPlayer and xDTaraZ.Bat.RootOf(player)
        if root and (root.Position - hrp.Position).Magnitude <= range then
            if xDTaraZ.Bat.Swing(player, false) then return end
        end
    end
end

xDTaraZ.Farm = {}

function xDTaraZ.Farm.Step()
    local opt = State.Opt
    if not (opt.AutoSteal or opt.AutoBreak or opt.RobCarriers) then return end
    if not xDTaraZ:Character() then
        State.Status = "Waiting for respawn"
        return
    end

    local carry, cap = xDTaraZ.Base.Carry()
    local nextPickup = (carry < cap) and xDTaraZ.Pickup.Next() or nil
    if carry >= cap or (carry > 0 and not nextPickup) or xDTaraZ.Attr("BeingChased", false) and carry > 0 then
        xDTaraZ.Base.Bank()
        return
    end
    if nextPickup then
        xDTaraZ.Pickup.Grab(nextPickup)
        return
    end
    if opt.RobCarriers then
        local victim = xDTaraZ.Bat.Carrier()
        if victim then
            State.Status = "Robbing " .. victim.Name
            local root = xDTaraZ.Bat.RootOf(victim)
            if root then State.BreakSpot = root.Position end
            xDTaraZ.Bat.Swing(victim, true)
            return
        end
    end
    if opt.AutoBreak then
        local egg = xDTaraZ.Break.Pick()
        if egg then
            xDTaraZ.Break.Hit(egg)
            return
        end
        State.Status = "No egg beats your base yet"
        return
    end
    State.Status = "Waiting for animals better than your base"
end

xDTaraZ.Shop = {}

function xDTaraZ.Shop.Pickaxe()
    local tier = xDTaraZ.Attr("PickaxeTier", 1)
    local cash = xDTaraZ.Spendable()
    local best
    for nextTier = tier + 1, #GameLib.Pickaxe.Tiers do
        if GameLib.Pickaxe.GetPrice(nextTier) > cash then break end
        best = nextTier
    end
    if not best then return false end
    xDTaraZ:Fire("PickaxeShopRequest", "Buy", best)
    return true
end

function xDTaraZ.Shop.Plot()
    local plot = xDTaraZ.Base.Own()
    if not plot then return false end
    local cost = GameLib.Plot.UpgradeCost(plot:GetAttribute("PlotLevel") or 1)
    if not cost or cost > xDTaraZ.Spendable() then return false end
    xDTaraZ:Fire("UpgradePlotRequest")
    return true
end

function xDTaraZ.Shop.Trail()
    local owned = {}
    for id in tostring(xDTaraZ.Attr("OwnedTrails", "")):gmatch("%d+") do owned[tonumber(id)] = true end
    local pick
    for _, trail in ipairs(GameLib.Trails.Trails) do
        if not owned[trail.Id] and trail.Price <= xDTaraZ.Spendable() and (not pick or trail.Multiplier > pick.Multiplier) then pick = trail end
    end
    local equipped = xDTaraZ.Attr("EquippedTrail", 1)
    local bestOwned
    for _, trail in ipairs(GameLib.Trails.Trails) do
        if owned[trail.Id] and (not bestOwned or trail.Multiplier > bestOwned.Multiplier) then bestOwned = trail end
    end
    if pick then
        xDTaraZ:Fire("TrailShopRequest", "Buy", pick.Id)
        task.wait(0.3)
        xDTaraZ:Fire("TrailShopRequest", "Equip", pick.Id)
        return true
    end
    if bestOwned and bestOwned.Id ~= equipped then xDTaraZ:Fire("TrailShopRequest", "Equip", bestOwned.Id) end
    return false
end

function xDTaraZ.Shop.Treadmill()
    local plot = xDTaraZ.Base.Own()
    if not plot then return false end
    if not plot:GetAttribute("TreadmillUnlocked") then
        xDTaraZ:Fire("UnlockTreadmillRequest")
        return true
    end
    local level = plot:GetAttribute("TreadmillLevel") or 1
    if level >= GameLib.Treadmill.MaxLevel then return false end
    if GameLib.Treadmill.UpgradeCost(level) > xDTaraZ.Spendable() then return false end
    xDTaraZ:Fire("UpgradeTreadmillRequest")
    return true
end

function xDTaraZ.Shop.Step()
    local opt = State.Opt
    local plot = xDTaraZ.Base.Own()
    local plotCost = plot and GameLib.Plot.UpgradeCost(plot:GetAttribute("PlotLevel") or 1) or math.huge
    local pickTier = xDTaraZ.Attr("PickaxeTier", 1)
    local pickCost = pickTier < #GameLib.Pickaxe.Tiers and GameLib.Pickaxe.GetPrice(pickTier + 1) or math.huge
    if opt.AutoUpgradePlot and plotCost <= pickCost and xDTaraZ.Shop.Plot() then return end
    if opt.AutoBuyPickaxe and xDTaraZ.Shop.Pickaxe() then return end
    if opt.AutoUpgradePlot and xDTaraZ.Shop.Plot() then return end
    if opt.AutoTrail and xDTaraZ.Shop.Trail() then return end
    if opt.AutoTreadmill then xDTaraZ.Shop.Treadmill() end
end

xDTaraZ.Pets = {}

function xDTaraZ.Pets.Tools()
    local list = {}
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and CollectionService:HasTag(tool, "AnimalTool") then list[#list + 1] = tool end
    end
    return list
end

function xDTaraZ.Pets.Place()
    if #xDTaraZ.Pets.Tools() == 0 then return end
    xDTaraZ:Fire("PetsInventoryRemote", "EquipBest", nil)
end

---@return number  tools sent to sell
function xDTaraZ.Pets.Sell()
    local keep = State.Opt.KeepRarities
    if State.Opt.AutoPlace and osClock() - (State.Last.Banked or 0) < Config.EquipInterval * 2 then return 0 end
    local floor = State.Opt.AutoPlace and xDTaraZ.Base.Weakest() or math.huge
    local batch = {}
    for _, tool in ipairs(xDTaraZ.Pets.Tools()) do
        if keep[tool:GetAttribute("Rarity") or ""] or xDTaraZ.Pickup.Value(tool) > floor then continue end
        batch[#batch + 1] = tool
    end
    if #batch == 0 then return 0 end
    local remote = GameLib.Remote.BackpackSellRemote
    if not remote then return 0 end
    local ok, err = pcall(remote.InvokeServer, remote, batch)
    if not ok then warn("[BreakStealEgg] sell:", err) end
    return ok and #batch or 0
end

xDTaraZ.Rewards = {}

function xDTaraZ.Rewards.Claim()
    xDTaraZ:Fire("IndexRemote", "ClaimAll", nil)
    xDTaraZ:Fire("OfflineRewardRemote", "Claim")
    if not State.GroupClaimed then
        xDTaraZ:Fire("GroupRewardRemote", "Joined")
        xDTaraZ:Fire("GroupRewardRemote", "Claim")
    end
    if not State.DiscordClaimed then xDTaraZ:Fire("DiscordRewardRemote", "Verify", LocalPlayer.Name) end
end

function xDTaraZ.Rewards.Watch()
    local function Track(remote, key)
        if not remote then return end
        xDTaraZ:Connect(remote.OnClientEvent, function(kind, info)
            if kind == "State" and type(info) == "table" and info.Claimed then State[key] = true end
        end)
        remote:FireServer("Get")
    end
    Track(GameLib.Remote.GroupRewardRemote, "GroupClaimed")
    Track(GameLib.Remote.DiscordRewardRemote, "DiscordClaimed")
end

xDTaraZ.Eggs = {}

function xDTaraZ.Eggs.Tools()
    local list = {}
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and CollectionService:HasTag(tool, "MergeEggTool") then list[#list + 1] = tool end
    end
    return list
end

---@return number  eggs that got placed or hatched
function xDTaraZ.Eggs.Step()
    local done = 0
    local now = Workspace:GetServerTimeNow()
    for _, egg in ipairs(CollectionService:GetTagged("MergeEggPlaced")) do
        if egg:GetAttribute("OwnerUserId") == LocalPlayer.UserId and (egg:GetAttribute("ReadyAtServerTime") or math.huge) <= now then
            xDTaraZ:Fire("MergeMachineRemote", "HatchEgg", egg:GetAttribute("EggId"))
            done += 1
        end
    end
    local tools = xDTaraZ.Eggs.Tools()
    local hitbox = #tools > 0 and xDTaraZ.Base.Hitbox()
    if not hitbox then return done end
    local _, hum = xDTaraZ:Character()
    for i, tool in ipairs(tools) do
        if hum then hum:EquipTool(tool) end
        local offset = vector3New((i % 3 - 1) * Config.EggSpacing, -hitbox.Size.Y / 2 + 0.5, math.floor(i / 3) * Config.EggSpacing)
        xDTaraZ:Fire("MergeMachineRemote", "PlaceEgg", tool, hitbox.Position + offset)
        done += 1
        task.wait(0.2)
    end
    return done
end

xDTaraZ.Teleport = {}

function xDTaraZ.Teleport.Zones()
    local names = {}
    for _, zone in ipairs(xDTaraZ.ZoneList) do names[#names + 1] = zone.Name end
    return names
end

function xDTaraZ.Teleport.Zone(name)
    local builds = Workspace:FindFirstChild("Build") and Workspace.Build:FindFirstChild("ZoneBuilds")
    local zone = builds and builds:FindFirstChild(name)
    if not zone then return end
    local eggs = zone:FindFirstChild("Eggs")
    local spot = eggs and eggs:FindFirstChildWhichIsA("BasePart", true)
    local pos = spot and spot.Position or zone:GetPivot().Position
    xDTaraZ.Move.To(cframeNew(pos + vector3New(0, 6, 0)))
end

function xDTaraZ.Teleport.Places()
    local list = { "My Base" }
    local booths = Workspace:FindFirstChild("Booths")
    if booths then
        for _, booth in ipairs(booths:GetChildren()) do list[#list + 1] = booth.Name end
    end
    if Workspace:FindFirstChild("EggMachine") then list[#list + 1] = "Egg Machine" end
    return list
end

function xDTaraZ.Teleport.Place(name)
    if name == "My Base" then return xDTaraZ.Base.Home() end
    local target = name == "Egg Machine" and Workspace:FindFirstChild("EggMachine") or (Workspace:FindFirstChild("Booths") and Workspace.Booths:FindFirstChild(name))
    if target then xDTaraZ.Move.To(cframeNew(target:GetPivot().Position + vector3New(0, 4, 6))) end
end

function xDTaraZ.Teleport.Player(name)
    local player = Players:FindFirstChild(name or "")
    local root = xDTaraZ.Bat.RootOf(player)
    if root then xDTaraZ.Move.To(root.CFrame * cframeNew(0, 0, 3)) end
end

xDTaraZ.Esp = { Tags = {} }

function xDTaraZ.Esp.Folder()
    local folder = State.EspFolder
    if folder and folder.Parent then return folder end
    folder = Instance.new("Folder")
    folder.Name = "MarioEsp"
    local ok = pcall(function() folder.Parent = (gethui and gethui()) or CoreGui end)
    if not ok then folder.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    State.EspFolder = folder
    return folder
end

function xDTaraZ.Esp.Tag(adornee, text, color)
    local tag = xDTaraZ.Esp.Tags[adornee]
    if not tag then
        tag = Instance.new("BillboardGui")
        tag.AlwaysOnTop = true
        tag.Size = UDim2.fromOffset(200, 34)
        tag.StudsOffset = vector3New(0, 3, 0)
        tag.MaxDistance = 5000
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Size = UDim2.fromScale(1, 1)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 13
        label.TextStrokeTransparency = 0.3
        label.Parent = tag
        tag.Parent = xDTaraZ.Esp.Folder()
        xDTaraZ.Esp.Tags[adornee] = tag
    end
    tag.Adornee = adornee
    tag.TextLabel.Text = text
    tag.TextLabel.TextColor3 = color
    return tag
end

xDTaraZ.Esp.RarityColors = {
    Common = Color3.fromRGB(200, 200, 200), Uncommon = Color3.fromRGB(110, 230, 110), Rare = Color3.fromRGB(80, 170, 255),
    Epic = Color3.fromRGB(190, 110, 255), Legendary = Color3.fromRGB(255, 190, 60), Mythic = Color3.fromRGB(255, 80, 120),
}

function xDTaraZ.Esp.Step()
    local opt = State.Opt
    local _, _, hrp = xDTaraZ:Character()
    local origin = hrp and hrp.Position or Vector3.zero
    local seen = {}
    local minRank = xDTaraZ.RarityRank[opt.EspMinRarity] or 1

    if opt.EspPickups and Workspace:FindFirstChild("AnimalPickups") then
        for _, model in ipairs(Workspace.AnimalPickups:GetChildren()) do
            local rarity = model:GetAttribute("Rarity") or "Common"
            local part = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
            if part and (xDTaraZ.RarityRank[rarity] or 1) >= minRank then
                seen[part] = true
                xDTaraZ.Esp.Tag(part, ("%s [%s] %.0fkg\n$%s/s · %dm"):format(tostring(model:GetAttribute("AnimalName")), rarity, model:GetAttribute("WeightKg") or 0, xDTaraZ.Format(xDTaraZ.Pickup.Value(model)), (part.Position - origin).Magnitude), xDTaraZ.Esp.RarityColors[rarity] or Color3.fromRGB(255, 120, 255))
            end
        end
    end

    if opt.EspEggs then
        local damage = xDTaraZ.Break.Damage()
        for _, egg in ipairs(CollectionService:GetTagged("BreakableEgg")) do
            if xDTaraZ.Break.Alive(egg) then
                seen[egg] = true
                local hits = math.ceil(egg:GetAttribute("Health") / damage)
                xDTaraZ.Esp.Tag(egg, ("%s · Z%s\n%s HP · %d hits"):format(tostring(egg:GetAttribute("EggType")), tostring(egg:GetAttribute("ZoneIndex")), xDTaraZ.Format(egg:GetAttribute("Health")), hits), hits <= opt.MaxHits and Color3.fromRGB(120, 255, 140) or Color3.fromRGB(255, 120, 100))
            end
        end
    end

    if opt.EspPlayers then
        for _, player in ipairs(Players:GetPlayers()) do
            local root = player ~= LocalPlayer and xDTaraZ.Bat.RootOf(player)
            if root then
                seen[root] = true
                local carry = player:GetAttribute("CarryCount") or 0
                xDTaraZ.Esp.Tag(root, ("%s · %dm%s"):format(player.DisplayName, (root.Position - origin).Magnitude, carry > 0 and ("\nCarrying " .. tostring(player:GetAttribute("Carrying"))) or ""), carry > 0 and Color3.fromRGB(255, 200, 60) or Color3.fromRGB(255, 255, 255))
            end
        end
    end

    for adornee, tag in pairs(xDTaraZ.Esp.Tags) do
        if not seen[adornee] or not adornee.Parent then
            tag:Destroy()
            xDTaraZ.Esp.Tags[adornee] = nil
        end
    end
end

function xDTaraZ.Esp.Clear()
    for adornee, tag in pairs(xDTaraZ.Esp.Tags) do
        tag:Destroy()
        xDTaraZ.Esp.Tags[adornee] = nil
    end
end

xDTaraZ.Session = {}

function xDTaraZ.Session.Rejoin()
    if #Players:GetPlayers() <= 1 then
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end

function xDTaraZ.Session.Bind()
    xDTaraZ:Connect(LocalPlayer.Idled, function()
        if not State.Opt.AntiAfk then return end
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    xDTaraZ:Connect(UserInputService.JumpRequest, function()
        if not State.Opt.InfJump then return end
        local _, hum = xDTaraZ:Character()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
    xDTaraZ:Connect(RunService.Stepped, function()
        if State.Opt.Noclip then xDTaraZ.Move.SetNoclip(true) end
    end)
    xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(char)
        State.NoclipParts = nil
        local hum = char:WaitForChild("Humanoid", 10)
        if not hum then return end
        xDTaraZ.Move.HoldSpeed(hum)
        if State.Opt.SpeedOn then State.Requests.Speed = true end
    end)
    local _, hum = xDTaraZ:Character()
    if hum then xDTaraZ.Move.HoldSpeed(hum) end
    local overlay = CoreGui:FindFirstChild("RobloxPromptGui")
    overlay = overlay and overlay:FindFirstChild("promptOverlay")
    if overlay then
        xDTaraZ:Connect(overlay.ChildAdded, function(child)
            if child.Name ~= "ErrorPrompt" or not State.Opt.AutoRejoin or State.Rejoining then return end
            State.Rejoining = true
            task.delay(Config.RejoinDelay, xDTaraZ.Session.Rejoin)
        end)
    end
end

xDTaraZ.Scheduler = {}

xDTaraZ.Scheduler.RequestHandlers = {
    Speed = function()
        State.SpeedTouched = true
        xDTaraZ.Move.ApplySpeed()
    end,
    Place = xDTaraZ.Pets.Place,
    SellNow = function() xDTaraZ:Notify(("Sold %d animals"):format(xDTaraZ.Pets.Sell())) end,
    PickaxeNow = function() if not xDTaraZ.Shop.Pickaxe() then xDTaraZ:Notify("Not enough cash for the next pickaxe") end end,
    PlotNow = function() if not xDTaraZ.Shop.Plot() then xDTaraZ:Notify("Not enough cash for a plot upgrade") end end,
    TrailNow = xDTaraZ.Shop.Trail,
    TreadmillNow = xDTaraZ.Shop.Treadmill,
    ClaimNow = xDTaraZ.Rewards.Claim,
}

xDTaraZ.Scheduler.MoveHandlers = {
    StealNow = function()
        local folder = Workspace:FindFirstChild("AnimalPickups")
        local best, bestValue = nil, -1
        for _, model in ipairs(folder and folder:GetChildren() or {}) do
            local value = xDTaraZ.Pickup.Value(model)
            if value > bestValue then best, bestValue = model, value end
        end
        if best and xDTaraZ.Pickup.Grab(best) then xDTaraZ.Base.Bank() end
    end,
    BankNow = xDTaraZ.Base.Bank,
    HatchNow = function() xDTaraZ:Notify(("Eggs handled: %d"):format(xDTaraZ.Eggs.Step())) end,
    BatNow = function() xDTaraZ.Bat.Swing(Players:FindFirstChild(State.Opt.BatTarget or ""), true) end,
    Goto = function()
        local job = State.Goto
        State.Goto = nil
        if job then job() end
    end,
}

function xDTaraZ.Scheduler.Drain(handlers)
    for name, handler in pairs(handlers) do
        if State.Requests[name] then
            State.Requests[name] = nil
            xDTaraZ.Scheduler.Run(handler)
        end
    end
end

function xDTaraZ.Scheduler.Run(fn)
    local ok, err = pcall(fn)
    if not ok then warn("[BreakStealEgg]", err) end
end

function xDTaraZ.Scheduler.Every(key, interval, fn)
    if osClock() - (State.Last[key] or 0) < interval then return end
    State.Last[key] = osClock()
    xDTaraZ.Scheduler.Run(fn)
end

function xDTaraZ.Scheduler.Summarize()
    local cash = xDTaraZ.Attr("Cash", 0)
    State.StartCash = State.StartCash or cash
    local plot = xDTaraZ.Base.Own()
    local minutes = math.max((osClock() - State.StartAt) / 60, 1 / 60)
    local carry, cap = xDTaraZ.Base.Carry()
    local tier = xDTaraZ.Attr("PickaxeTier", 1)
    local pickaxe = GameLib.Pickaxe.Tiers[tier]
    State.Summary = ("Cash %s · %s/s\n%s (%s dmg) · Carry %d/%d\nBase %s/%s animals · Level %s"):format(
        xDTaraZ.Format(cash), xDTaraZ.Format(xDTaraZ.Attr("CashPerSecond", 0)),
        pickaxe and pickaxe.Name or "-", xDTaraZ.Format(xDTaraZ.Break.Damage()), carry, cap,
        tostring(plot and plot:GetAttribute("AnimalsPlaced") or "-"), tostring(plot and plot:GetAttribute("MaxAnimals") or "-"),
        tostring(plot and plot:GetAttribute("PlotLevel") or "-"))
    State.RunText = ("%s\nSteals %d · Eggs %d · Banked %d · +%s/min"):format(
        State.Status, State.Steals, State.Broken, State.Banked, xDTaraZ.Format((cash - State.StartCash) / minutes))
end

function xDTaraZ.Scheduler.Side()
    local opt = State.Opt
    xDTaraZ.Scheduler.Every("Summary", 0.5, xDTaraZ.Scheduler.Summarize)
    xDTaraZ.Scheduler.Drain(xDTaraZ.Scheduler.RequestHandlers)
    if opt.AutoPlace then xDTaraZ.Scheduler.Every("Place", Config.EquipInterval, xDTaraZ.Pets.Place) end
    if opt.AutoSell then xDTaraZ.Scheduler.Every("Sell", Config.SellInterval, xDTaraZ.Pets.Sell) end
    if opt.AutoBuyPickaxe or opt.AutoUpgradePlot or opt.AutoTrail or opt.AutoTreadmill then xDTaraZ.Scheduler.Every("Shop", Config.BuyInterval, xDTaraZ.Shop.Step) end
    if opt.AutoClaim then xDTaraZ.Scheduler.Every("Claim", Config.ClaimInterval, xDTaraZ.Rewards.Claim) end
    if opt.EspPickups or opt.EspEggs or opt.EspPlayers then
        xDTaraZ.Scheduler.Every("Esp", Config.EspInterval, xDTaraZ.Esp.Step)
    elseif next(xDTaraZ.Esp.Tags) then
        xDTaraZ.Esp.Clear()
    end
end

function xDTaraZ.Scheduler.Control()
    local opt = State.Opt
    xDTaraZ.Scheduler.Drain(xDTaraZ.Scheduler.MoveHandlers)
    if opt.BatLoop and opt.BatTarget then
        xDTaraZ.Scheduler.Run(function() xDTaraZ.Bat.Swing(Players:FindFirstChild(opt.BatTarget), true) end)
        return
    end
    if opt.BatAura then xDTaraZ.Scheduler.Run(xDTaraZ.Bat.Aura) end
    if opt.AutoHatch then xDTaraZ.Scheduler.Every("Eggs", Config.EggInterval, xDTaraZ.Eggs.Step) end
    xDTaraZ.Scheduler.Run(xDTaraZ.Farm.Step)
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Session.Bind()
    xDTaraZ.Scheduler.Run(xDTaraZ.Rewards.Watch)
    task.spawn(function()
        while State.Alive do
            xDTaraZ.Scheduler.Side()
            task.wait(0.1)
        end
    end)
    task.spawn(function()
        while State.Alive do
            xDTaraZ.Scheduler.Control()
            task.wait(Config.TickDelay)
        end
    end)
end

function xDTaraZ.Scheduler.Stop()
    State.Alive = false
    for _, conn in ipairs(State.Connections) do conn:Disconnect() end
    if State.SpeedConn then State.SpeedConn:Disconnect() end
    table.clear(State.Connections)
    State.Opt.SpeedOn = false
    xDTaraZ.Move.ApplySpeed()
    xDTaraZ.Move.SetNoclip(false)
    xDTaraZ.Esp.Clear()
    if State.EspFolder then State.EspFolder:Destroy() end
end

local function BuildInterface()
    local Library = loadstring(game:HttpGet(Config.UiSource))()
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt

    local function Notify(text)
        Library:Notify("Break and Steal an Egg", text, 4)
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
                opt[key] = value
                if onChange then onChange(value) end
            end,
        })
    end

    local function ToSet(selected)
        local set = {}
        if type(selected) ~= "table" then return set end
        for k, v in pairs(selected) do
            if v == true then set[k] = true elseif type(v) == "string" then set[v] = true end
        end
        return set
    end

    local function Goto(fn, arg)
        State.Goto = function() fn(arg) end
        State.Requests.Goto = true
    end

    local function PlayerNames()
        local names = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then names[#names + 1] = player.Name end
        end
        table.sort(names)
        return names
    end

    local function BuildTabs()
        local Window = Library.Window
        Window:AddTabSection(T("Main", "หลัก"))
        local MainTab = Window:AddTab(T("Main", "หลัก"), "house", T("Status and all-in-one mode", "สถานะและโหมดทำทุกอย่าง"))
        Window:AddTabSection(T("Farming", "ฟาร์ม"))
        local FarmTab = Window:AddTab(T("Steal & Break", "ขโมยและทุบไข่"), "star", T("Steal animals and break eggs", "ขโมยสัตว์และทุบไข่"))
        Window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local BaseTab = Window:AddTab(T("Base & Shop", "ฐานและร้านค้า"), "shop", T("Placing, selling, upgrades and rewards", "วางสัตว์ ขาย อัปเกรด และรางวัล"))
        Window:AddTabSection(T("Misc", "อื่นๆ"))
        local PlayerTab = Window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and teleports", "การเคลื่อนที่และวาร์ป"))
        local VisualTab = Window:AddTab(T("Visuals", "มองเห็น"), "eye", T("See animals, eggs and players", "มองเห็นสัตว์ ไข่ และผู้เล่น"))
        local TrollTab = Window:AddTab(T("Troll", "ป่วน"), "troll", T("Bat other players", "ตีผู้เล่นอื่น"))

        local statusBox = MainTab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
        local statusLabel = statusBox:AddLabel(T("Loading...", "กำลังโหลด..."))
        local runLabel = statusBox:AddLabel("-")

        local kaitunBox = MainTab:AddRightGroupbox(T("Kaitun", "ไก่ตัน"), "oneup")
        kaitunBox:AddToggle("Kaitun", {
            Text = T("Kaitun (All-in-one)", "ไก่ตัน (ทำทุกอย่าง)"),
            Description = T("Steals, breaks eggs, places, sells, upgrades and claims rewards by itself", "ขโมย ทุบไข่ วางสัตว์ ขาย อัปเกรด และรับรางวัลให้เองทั้งหมด"),
            NoSave = true,
            Callback = function(value)
                State.KaitunSet = State.KaitunSet or {}
                for _, key in ipairs({ "AutoSteal", "AutoBreak", "AutoPlace", "AutoSell", "AutoBuyPickaxe", "AutoUpgradePlot", "AutoClaim", "AutoHatch", "AntiAfk" }) do
                    if value and not opt[key] then
                        State.KaitunSet[key] = true
                        Options[key]:SetValue(true)
                    elseif not value and State.KaitunSet[key] then
                        State.KaitunSet[key] = nil
                        Options[key]:SetValue(false)
                    end
                end
            end,
        })

        local discordBox = MainTab:AddRightGroupbox(T("Discord", "Discord"), "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            local copy = setclipboard or toclipboard
            if copy then copy(Config.Discord) end
            Notify(copy and "Discord link copied" or Config.Discord)
        end })

        local stealBox = FarmTab:AddLeftGroupbox(T("Auto Steal", "ขโมยอัตโนมัติ"), "star")
        Toggle(stealBox, "AutoSteal", T("Auto Steal", "ขโมยอัตโนมัติ"), T("Grabs the most valuable animals on the map and brings them home instantly", "คว้าสัตว์ที่มีค่าที่สุดบนแมพแล้วพากลับฐานทันที"))
        stealBox:AddDropdown("Take", {
            Text = T("Take", "เก็บ"),
            Description = T("Upgrades Only = only animals that earn more than your weakest one", "Upgrades Only = เฉพาะตัวที่ทำเงินมากกว่าตัวที่อ่อนสุดบนฐาน"),
            Values = { "Upgrades Only", "Everything" },
            Default = 1,
            Callback = function(value) opt.Take = value or "Upgrades Only" end,
        })
        stealBox:AddDropdown("StealRarities", {
            Text = T("Only Rarities", "เฉพาะ rarity"),
            Description = T("Empty = take everything", "ไม่เลือก = เอาทุกตัว"),
            Values = xDTaraZ.RarityLadder,
            Multi = true,
            Default = {},
            Callback = function(selected) opt.StealRarities = ToSet(selected) end,
        })
        stealBox:AddInput("StealMinValue", {
            Text = T("Min Cash/s", "เงินต่อวิขั้นต่ำ"),
            Placeholder = "0",
            Numeric = true,
            Callback = function(value) opt.StealMinValue = tonumber(value) or 0 end,
        })
        Toggle(stealBox, "RobCarriers", T("Rob Carriers", "ปล้นคนที่แบกสัตว์"), T("Bats players carrying animals and takes what they drop", "ตีผู้เล่นที่แบกสัตว์แล้วเก็บของที่หล่น"))
        stealBox:AddButton({ Text = T("Steal Best Now", "ขโมยตัวดีสุดเดี๋ยวนี้"), Style = "Primary", Func = Request("StealNow") })
        stealBox:AddButton({ Text = T("Bank Now", "เก็บเข้าฐานเดี๋ยวนี้"), Func = Request("BankNow") })

        local breakBox = FarmTab:AddRightGroupbox(T("Auto Break", "ทุบไข่อัตโนมัติ"), "qblock")
        Toggle(breakBox, "AutoBreak", T("Auto Break Eggs", "ทุบไข่อัตโนมัติ"), T("Breaks eggs in any zone at max speed and takes the animal home", "ทุบไข่ได้ทุกโซนด้วยความเร็วสูงสุดแล้วพาสัตว์กลับฐาน"))
        local zoneChoices = { "Best" }
        for _, name in ipairs(xDTaraZ.Teleport.Zones()) do zoneChoices[#zoneChoices + 1] = name end
        breakBox:AddDropdown("BreakZone", {
            Text = T("Zone", "โซน"),
            Description = T("Best = most worth for the time spent", "Best = คุ้มที่สุดต่อเวลาที่ใช้"),
            Values = zoneChoices,
            Default = 1,
            Callback = function(value) opt.BreakZone = value or "Best" end,
        })
        breakBox:AddSlider("MaxHits", {
            Text = T("Max Hits Per Egg", "จำนวนตีสูงสุดต่อไข่"),
            Description = T("Skips eggs that take longer than this", "ข้ามไข่ที่ใช้นานกว่านี้"),
            Min = 1, Max = 200, Default = opt.MaxHits, Rounding = 0,
            Callback = function(value) opt.MaxHits = tonumber(value) or opt.MaxHits end,
        })

        local placeBox = BaseTab:AddLeftGroupbox(T("Animals", "สัตว์"), "mushroom")
        Toggle(placeBox, "AutoPlace", T("Auto Place Best", "วางตัวดีสุดอัตโนมัติ"), T("Keeps the best earners standing on your base", "วางตัวที่ทำเงินดีสุดไว้บนฐานตลอด"))
        placeBox:AddButton({ Text = T("Place Best Now", "วางตัวดีสุดเดี๋ยวนี้"), Func = Request("Place") })
        Toggle(placeBox, "AutoSell", T("Auto Sell Leftovers", "ขายตัวที่เหลืออัตโนมัติ"), T("Sells animals in your backpack that did not fit on the base", "ขายสัตว์ในกระเป๋าที่ไม่ได้วางบนฐาน"))
        placeBox:AddDropdown("KeepRarities", {
            Text = T("Never Sell", "ไม่ขาย"),
            Values = xDTaraZ.RarityLadder,
            Multi = true,
            Default = {},
            Callback = function(selected) opt.KeepRarities = ToSet(selected) end,
        })
        placeBox:AddButton({ Text = T("Sell All Now", "ขายทั้งหมดเดี๋ยวนี้"), Func = Request("SellNow") })

        local shopBox = BaseTab:AddRightGroupbox(T("Upgrades", "อัปเกรด"), "coin")
        Toggle(shopBox, "AutoBuyPickaxe", T("Auto Buy Pickaxe", "ซื้อ Pickaxe อัตโนมัติ"), T("Jumps straight to the best pickaxe you can afford", "ข้ามไปซื้อ Pickaxe ที่ดีที่สุดที่ซื้อไหวทันที"))
        shopBox:AddButton({ Text = T("Buy Pickaxe Now", "ซื้อ Pickaxe เดี๋ยวนี้"), Func = Request("PickaxeNow") })
        Toggle(shopBox, "AutoUpgradePlot", T("Auto Upgrade Base", "อัปเกรดฐานอัตโนมัติ"), T("More animal slots as soon as you can pay", "เพิ่มช่องวางสัตว์ทันทีที่เงินพอ"))
        shopBox:AddButton({ Text = T("Upgrade Base Now", "อัปเกรดฐานเดี๋ยวนี้"), Func = Request("PlotNow") })
        Toggle(shopBox, "AutoTrail", T("Auto Buy Trail", "ซื้อ Trail อัตโนมัติ"), T("Buys and wears the strongest trail", "ซื้อและใส่ Trail ที่แรงที่สุด"))
        shopBox:AddButton({ Text = T("Buy Trail Now", "ซื้อ Trail เดี๋ยวนี้"), Func = Request("TrailNow") })
        Toggle(shopBox, "AutoTreadmill", T("Auto Upgrade Treadmill", "อัปเกรดลู่วิ่งอัตโนมัติ"))
        shopBox:AddButton({ Text = T("Upgrade Treadmill Now", "อัปเกรดลู่วิ่งเดี๋ยวนี้"), Func = Request("TreadmillNow") })
        shopBox:AddInput("CashReserve", {
            Text = T("Keep Cash", "กันเงินไว้"),
            Placeholder = "0",
            Numeric = true,
            Callback = function(value) opt.CashReserve = tonumber(value) or 0 end,
        })

        local rewardBox = BaseTab:AddLeftGroupbox(T("Rewards", "รางวัล"), "star")
        Toggle(rewardBox, "AutoClaim", T("Auto Claim", "รับรางวัลอัตโนมัติ"), T("Claims index, offline, group and community rewards, no joining needed", "รับรางวัล Index ออฟไลน์ กลุ่ม และคอมมูนิตี้ ไม่ต้องเข้ากลุ่ม"))
        rewardBox:AddButton({ Text = T("Claim Now", "รับเดี๋ยวนี้"), Func = Request("ClaimNow") })
        Toggle(rewardBox, "AutoHatch", T("Auto Hatch Eggs", "ฟักไข่อัตโนมัติ"), T("Places eggs from your backpack on your base and hatches them when ready", "วางไข่ในกระเป๋าบนฐานแล้วฟักเมื่อพร้อม"))
        rewardBox:AddButton({ Text = T("Hatch Eggs Now", "ฟักไข่เดี๋ยวนี้"), Func = Request("HatchNow") })

        local moveBox = PlayerTab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "star")
        Toggle(moveBox, "SpeedOn", T("Speed", "ความเร็ว"), nil, Request("Speed"))
        moveBox:AddSlider("WalkSpeed", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Min = 16, Max = 300, Default = opt.WalkSpeed, Rounding = 0,
            Callback = function(value)
                opt.WalkSpeed = tonumber(value) or opt.WalkSpeed
                if opt.SpeedOn then State.Requests.Speed = true end
            end,
        })
        Toggle(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))
        Toggle(moveBox, "Noclip", T("Noclip", "ทะลุกำแพง"), nil, function(on) if not on then xDTaraZ.Move.SetNoclip(false) end end)

        local tpBox = PlayerTab:AddRightGroupbox(T("Teleport", "วาร์ป"), "teleport")
        tpBox:AddDropdown("TpZone", {
            AllowNull = true,
            Text = T("Zone", "โซน"),
            Values = xDTaraZ.Teleport.Zones(),
            Searchable = true,
            NoSave = true,
            Callback = function(value) if value then Goto(xDTaraZ.Teleport.Zone, value) end end,
        })
        tpBox:AddDropdown("TpPlace", {
            AllowNull = true,
            Text = T("Place", "สถานที่"),
            Values = xDTaraZ.Teleport.Places(),
            NoSave = true,
            Callback = function(value) if value then Goto(xDTaraZ.Teleport.Place, value) end end,
        })
        local tpPlayer = tpBox:AddDropdown("TpPlayer", {
            AllowNull = true,
            Text = T("Player", "ผู้เล่น"),
            Values = PlayerNames(),
            Searchable = true,
            NoSave = true,
            Callback = function(value) if value then Goto(xDTaraZ.Teleport.Player, value) end end,
        })
        tpBox:AddButton({ Text = T("Refresh Players", "รีเฟรชผู้เล่น"), Func = function() tpPlayer:SetValues(PlayerNames()) end })

        local espBox = VisualTab:AddLeftGroupbox(T("ESP", "ESP"), "eye")
        Toggle(espBox, "EspPickups", T("Animals", "สัตว์"), T("Name, rarity, weight and cash per second", "ชื่อ rarity น้ำหนัก และเงินต่อวิ"))
        espBox:AddDropdown("EspMinRarity", {
            Text = T("Min Rarity", "rarity ขั้นต่ำ"),
            Values = xDTaraZ.RarityLadder,
            Default = 1,
            Callback = function(value) opt.EspMinRarity = value or "Common" end,
        })
        Toggle(espBox, "EspEggs", T("Eggs", "ไข่"), T("HP and how many hits it takes", "HP และจำนวนครั้งที่ต้องตี"))
        Toggle(espBox, "EspPlayers", T("Players", "ผู้เล่น"), T("Distance and what they carry", "ระยะและสิ่งที่แบกอยู่"))

        local batBox = TrollTab:AddLeftGroupbox(T("Bat", "ไม้ตี"), "swords")
        local batTarget = batBox:AddDropdown("BatTarget", {
            AllowNull = true,
            Text = T("Target", "เป้าหมาย"),
            Values = PlayerNames(),
            Searchable = true,
            NoSave = true,
            Callback = function(value) opt.BatTarget = value end,
        })
        batBox:AddButton({ Text = T("Refresh Players", "รีเฟรชผู้เล่น"), Func = function() batTarget:SetValues(PlayerNames()) end })
        Toggle(batBox, "BatLoop", T("Loop Bat Target", "ตีเป้าหมายวนไป"), T("Follows the target and keeps knocking them over", "ตามเป้าหมายแล้วตีล้มไม่หยุด"))
        batBox:AddButton({ Text = T("Bat Target Now", "ตีเป้าหมายเดี๋ยวนี้"), Func = Request("BatNow") })
        Toggle(batBox, "BatAura", T("Bat Aura", "ออร่าไม้ตี"), T("Knocks over anyone who gets close", "ตีล้มทุกคนที่เข้าใกล้"))

        local settingsTab = Window:AddSettingsTab()
        local sessionBox = settingsTab:AddLeftGroupbox(T("Session", "เซสชัน"), "gear")
        Toggle(sessionBox, "AntiAfk", T("Anti AFK", "กันหลุด AFK"), T("Stops the idle kick", "กันโดนเตะเพราะไม่ขยับ"))
        Toggle(sessionBox, "AutoRejoin", T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"))
        sessionBox:AddButton({ Text = T("Rejoin Now", "เข้าเกมใหม่เดี๋ยวนี้"), Func = xDTaraZ.Session.Rejoin })

        Library:Every(0.5, function()
            while #State.Messages > 0 do
                Notify(table.remove(State.Messages, 1))
            end
            statusLabel:SetText(State.Summary or "-")
            runLabel:SetText(State.RunText or State.Status)
        end)
    end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    getgenv().BreakStealEggUnload = function()
        Library:Unload()
    end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Break and Steal an Egg by xDTaraZ",
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

if getgenv().BreakStealEggUnload then
    pcall(getgenv().BreakStealEggUnload)
end

BuildInterface()