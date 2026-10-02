if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765298801 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Stone Skipping only")
    return
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local osClock, osTime = os.clock, os.time
local vector3New = Vector3.new

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    SaveFolder = "Stone Skipping",
    TickDelay = 0.2,
    GcRescan = 5,
    WalkTimeout = 15,
    ArriveRadius = 4,
    StandLane = 10,
    ThrowTimeout = 30,
    ThrowStart = 3,
    HatchTimeout = 15,
    HatchCooldown = 0.8,
    HatchBurst = 25,
    RevealClickGap = 0.35,
    ClaimInterval = 20,
    BuyInterval = 3,
    PotionInterval = 10,
    RebirthInterval = 15,
    RateWindow = 120,
    RejoinDelay = 5,
    Codes = { "10KCCU", "SECRET", "WORLD4", "WELCOME", "THANKYOU", "5KCCU" },
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Requests = {},
    Messages = {},
    Status = "Idle",
    Throws = 0,
    WinsEarned = 0,
    SkillEarned = 0,
    EarnLog = {},
    Last = {},
    OwnedPasses = {},
    Opt = {
        AutoFarm = false,
        FarmMode = "Smart",
        TrainZone = "Best",
        AutoBuyStone = false,
        StoneReserve = 0,
        AutoRebirth = false,
        AutoHatch = false,
        HatchEgg = "Best",
        HatchReserve = 0,
        AutoInventoryHatch = false,
        AutoPotions = false,
        Potions = { Skill = true, Win = true, Luck = true },
        AutoClaim = false,
        AutoTravel = false,
        SpeedOn = false,
        WalkSpeed = 32,
        InfJump = false,
        AntiAfk = false,
        AutoRejoin = false,
    },
}

local Config, State = xDTaraZ.Config, xDTaraZ.State
local Network = ReplicatedStorage:WaitForChild("SkippingNetwork")
local SharedConfig = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Config")

xDTaraZ.GameLib = {
    Balance = require(SharedConfig.GameBalance),
    Worlds = require(SharedConfig.Worlds),
    Request = Network:WaitForChild("Request"),
    Event = Network:WaitForChild("Event"),
}

local GameLib = xDTaraZ.GameLib

xDTaraZ.Caps = {
    Gc = type(getgc) == "function" and type(debug.getupvalue) == "function",
    Connections = type(getconnections) == "function",
    Prompt = type(fireproximityprompt) == "function",
}

xDTaraZ.StoneById = {}
do
    for _, stone in ipairs(GameLib.Balance.Stones) do
        xDTaraZ.StoneById[stone.Id] = stone
    end
end

xDTaraZ.WorldById = {}
do
    for _, world in ipairs(GameLib.Worlds.Definitions or {}) do
        xDTaraZ.WorldById[world.Id] = world
    end
end

xDTaraZ.TrainZones = {}
do
    local practice = GameLib.Balance.Practice
    for name, bonus in pairs(practice.ZoneBonuses) do
        table.insert(xDTaraZ.TrainZones, {
            Name = name,
            Bonus = bonus,
            Rebirths = practice.ZoneRequiredRebirths[name] or 0,
            Pass = GameLib.Balance.TrainingPasses[name],
        })
    end
    table.sort(xDTaraZ.TrainZones, function(a, b) return a.Bonus > b.Bonus end)
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

function xDTaraZ:Send(action, ...)
    GameLib.Request:FireServer(action, ...)
end

xDTaraZ.Game = {}

function xDTaraZ.Game.Controller()
    local cached = xDTaraZ.Game.Cached
    if cached and type(rawget(cached, "BeginThrow")) == "function" then return cached end
    if not xDTaraZ.Caps.Gc or osClock() - (State.Last.GcScan or -math.huge) < Config.GcRescan then return nil end
    State.Last.GcScan = osClock()
    for _, t in ipairs(getgc(true)) do
        if type(t) == "table" and type(rawget(t, "RedeemCode")) == "function" and type(rawget(t, "BeginThrow")) == "function" then
            local canThrow = debug.getupvalue(t.BeginThrow, 1)
            if type(canThrow) ~= "function" then return nil end
            xDTaraZ.Game.Cached = t
            xDTaraZ.Game.CanThrow = canThrow
            return t
        end
    end
    return nil
end

---@return table?  live player profile kept by the game client
function xDTaraZ.Game.Profile()
    if not xDTaraZ.Game.Controller() then return nil end
    local profile = debug.getupvalue(xDTaraZ.Game.CanThrow, 3)
    return type(profile) == "table" and profile or nil
end

function xDTaraZ.Game.World()
    local world = Workspace:FindFirstChild("SkippingWorlds")
    local id = LocalPlayer:GetAttribute("SkippingWorld") or "World1"
    return world and world:FindFirstChild(id), id
end

function xDTaraZ.Game.Activity()
    return LocalPlayer:GetAttribute("SkippingActivity") or "Idle"
end

function xDTaraZ.Game.Wins()
    local data = xDTaraZ.Game.Profile()
    return data and tonumber(data.Wins) or 0
end

function xDTaraZ.Game.RebirthLevel(data)
    local listed = tonumber(data.NextRebirthLevel)
    if listed then return listed end
    local rebirths = tonumber(data.Rebirths) or 0
    local hud = LocalPlayer.PlayerGui:FindFirstChild("SkippingHUD")
    local overlay = hud and hud:FindFirstChild("RebirthOverlay", true)
    local label = overlay and overlay:FindFirstChild("Requirement", true)
    local shown = label and label:IsA("TextLabel") and tonumber((label.Text:gsub(",", "")):match("/%s*Level%s*(%d+)"))
    if shown then return shown end
    local reb = GameLib.Balance.Rebirth
    local need = reb.RequiredLevels[rebirths + 1]
    if need then return need end
    local count = #reb.RequiredLevels
    return math.min(reb.RequiredLevels[count] + (rebirths + 1 - count) * 20, reb.MaxRequiredLevel)
end

function xDTaraZ.Game.HatchActive()
    local hud = LocalPlayer.PlayerGui:FindFirstChild("SkippingHUD")
    return hud ~= nil and hud:GetAttribute("HatchActive") == true
end

function xDTaraZ.Game.ClosePages()
    local hud = LocalPlayer.PlayerGui:FindFirstChild("SkippingHUD")
    local frames = hud and hud:FindFirstChild("Frames")
    if not (frames and xDTaraZ.Caps.Connections) then return end
    for _, overlay in ipairs(frames:GetChildren()) do
        if not (overlay:IsA("GuiObject") and overlay.Visible) then continue end
        local close = overlay:FindFirstChild("Close", true)
        if close and close:IsA("GuiButton") then
            for _, conn in ipairs(getconnections(close.Activated)) do conn:Fire() end
        end
    end
end

function xDTaraZ.Game.SkipReveal()
    local deadline = osClock() + Config.HatchTimeout
    while xDTaraZ.Game.HatchActive() and osClock() < deadline and State.Alive do
        local cam = Workspace.CurrentCamera
        local size = cam and cam.ViewportSize or Vector2.new(800, 600)
        VirtualInputManager:SendMouseButtonEvent(size.X / 2, size.Y / 2, 0, true, game, 0)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(size.X / 2, size.Y / 2, 0, false, game, 0)
        task.wait(Config.RevealClickGap)
    end
end

xDTaraZ.Move = {}

function xDTaraZ.Move.WalkTo(pos)
    local _, hum, hrp = xDTaraZ:Character()
    if not hum then return false end
    local deadline = osClock() + Config.WalkTimeout
    repeat
        hum:MoveTo(pos)
        task.wait(0.25)
        local flat = vector3New(pos.X, hrp.Position.Y, pos.Z)
        if (hrp.Position - flat).Magnitude <= Config.ArriveRadius then return true end
    until osClock() > deadline or not State.Alive or hum.Health <= 0
    return false
end

---@return number?  x of the open lane in front of the training stands
function xDTaraZ.Move.LaneX()
    local spot = xDTaraZ.Move.ZoneSpot("TrainingZone")
    return spot and spot.X + Config.StandLane
end

function xDTaraZ.Move.Travel(pos)
    if xDTaraZ.Game.Activity() == "Practice" then
        xDTaraZ:Send("StopPractice")
        task.wait(0.3)
    end
    local _, _, hrp = xDTaraZ:Character()
    local laneX = xDTaraZ.Move.LaneX()
    if hrp and laneX and math.abs(hrp.Position.Z - pos.Z) > Config.ArriveRadius then
        xDTaraZ.Move.WalkTo(vector3New(laneX, pos.Y, hrp.Position.Z))
        xDTaraZ.Move.WalkTo(vector3New(laneX, pos.Y, pos.Z))
    end
    return xDTaraZ.Move.WalkTo(pos)
end

function xDTaraZ.Move.LaunchSpot()
    local world = xDTaraZ.Game.World()
    local zone = world and world:FindFirstChild("LaunchZone")
    if not zone then return nil end
    return zone.Position + vector3New(0, 2, 0)
end

function xDTaraZ.Move.ZoneSpot(name)
    local world = xDTaraZ.Game.World()
    local folder = world and world:FindFirstChild("TrainingZones")
    local zone = folder and folder:FindFirstChild(name)
    local stand = zone and zone:FindFirstChild("TrainingStand")
    if not stand then return nil end
    return stand.Position + vector3New(0, 2, 0)
end

function xDTaraZ.Move.EggSpot(eggId)
    local world = xDTaraZ.Game.World()
    local displays = world and world:FindFirstChild("EggShop") and world.EggShop:FindFirstChild("Displays")
    local egg = displays and displays:FindFirstChild(eggId)
    local anchor = egg and egg:FindFirstChild("PromptAnchor", true)
    if not anchor then return nil end
    return anchor.WorldPosition, egg
end

function xDTaraZ.Move.ApplySpeed()
    local _, hum = xDTaraZ:Character()
    if not hum then return end
    if State.Opt.SpeedOn then
        State.BaseSpeed = State.BaseSpeed or hum.WalkSpeed
        hum.WalkSpeed = State.Opt.WalkSpeed
    elseif State.BaseSpeed then
        hum.WalkSpeed = State.BaseSpeed
        State.BaseSpeed = nil
    end
end

xDTaraZ.Train = {}

function xDTaraZ.Train.OwnsPass(passId)
    if not passId then return true end
    local known = State.OwnedPasses[passId]
    if known ~= nil then return known end
    local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, LocalPlayer.UserId, passId)
    State.OwnedPasses[passId] = ok and owns or false
    return State.OwnedPasses[passId]
end

function xDTaraZ.Train.BestZone()
    local choice = State.Opt.TrainZone
    if choice ~= "Best" then return choice end
    local data = xDTaraZ.Game.Profile()
    local rebirths = data and tonumber(data.Rebirths) or 0
    for _, zone in ipairs(xDTaraZ.TrainZones) do
        if rebirths >= zone.Rebirths and xDTaraZ.Train.OwnsPass(zone.Pass) then return zone.Name end
    end
    return "TrainingZone"
end

function xDTaraZ.Train.Step()
    local name = xDTaraZ.Train.BestZone()
    local spot = xDTaraZ.Move.ZoneSpot(name)
    if not spot then return end
    State.Status = "Training at " .. name:gsub("TrainingZone_?", ""):gsub("^$", "Basic")
    if xDTaraZ.Game.Activity() == "Practice" then return end
    xDTaraZ.Move.Travel(spot)
end

xDTaraZ.Throw = {}

function xDTaraZ.Throw.Once()
    local ctrl = xDTaraZ.Game.Controller()
    local spot = xDTaraZ.Move.LaunchSpot()
    if not (ctrl and spot) then return false end

    State.Status = "Walking to throw zone"
    if not xDTaraZ.Move.Travel(spot) then return false end

    local deadline = osClock() + Config.ThrowTimeout
    while not xDTaraZ.Game.CanThrow() do
        if osClock() > deadline or not State.Alive then return false end
        task.wait(0.2)
    end

    xDTaraZ.Shop.IdleTasks()
    local before = xDTaraZ.Game.Wins()
    State.Status = "Throwing"
    xDTaraZ.Game.ClosePages()
    task.spawn(ctrl.BeginThrow)
    local started = osClock() + Config.ThrowStart
    while xDTaraZ.Game.Activity() ~= "Throw" do
        if osClock() > started or not State.Alive then return false end
        task.wait(0.1)
    end

    while xDTaraZ.Game.Activity() == "Throw" and osClock() < deadline and State.Alive do
        task.wait(0.25)
    end

    local got = xDTaraZ.Game.Wins() - before
    State.Throws += 1
    if got > 0 then
        State.WinsEarned += got
        table.insert(State.EarnLog, { osClock(), got })
    end
    return true
end

---@return boolean  next world still locked and a throw can now reach its portal
function xDTaraZ.Throw.PortalReachable()
    local data = xDTaraZ.Game.Profile()
    local _, worldId = xDTaraZ.Game.World()
    local world = xDTaraZ.WorldById[worldId]
    if not (data and world and world.NextWorldId) or data[world.NextWorldId .. "Unlocked"] then return false end
    local milestones = world.Throw and world.Throw.DistanceMilestones or GameLib.Balance.Throw.DistanceMilestones
    local last = milestones[#milestones]
    return last ~= nil and (tonumber(data.Level) or 0) >= last.Level
end

---@return boolean  true if a throw is worth more than training right now
function xDTaraZ.Throw.NeedWins()
    local opt = State.Opt
    if opt.AutoTravel and xDTaraZ.Throw.PortalReachable() then return true end
    if opt.AutoBuyStone and xDTaraZ.Shop.NextStone() and not xDTaraZ.Shop.Affordable() then return true end
    if opt.AutoHatch then return true end
    return false
end

xDTaraZ.Farm = {}

function xDTaraZ.Farm.Step()
    local mode = State.Opt.FarmMode
    if mode ~= "Throw" and xDTaraZ.Shop.Pending() then
        local spot = xDTaraZ.Move.LaunchSpot()
        State.Status = "Rebirth / buying stones"
        if spot and xDTaraZ.Move.Travel(spot) then
            task.wait(0.5)
            xDTaraZ.Shop.IdleTasks()
        end
        return
    end
    if mode == "Train" then return xDTaraZ.Train.Step() end
    if mode == "Throw" or xDTaraZ.Throw.NeedWins() then
        if not xDTaraZ.Throw.Once() then task.wait(0.5) end
        return
    end
    xDTaraZ.Train.Step()
end

xDTaraZ.Shop = {}

---@return table?  cheapest unowned stone of this world
function xDTaraZ.Shop.NextStone()
    local data = xDTaraZ.Game.Profile()
    local _, worldId = xDTaraZ.Game.World()
    local world = xDTaraZ.WorldById[worldId]
    if not (data and world) then return nil end
    local owned = data.OwnedStones or {}
    for _, id in ipairs(world.StoneIds) do
        local stone = xDTaraZ.StoneById[id]
        if stone and not owned[id] then return stone end
    end
    return nil
end

function xDTaraZ.Shop.BestOwned()
    local data = xDTaraZ.Game.Profile()
    if not data then return nil end
    local best
    for id in pairs(data.OwnedStones or {}) do
        local stone = xDTaraZ.StoneById[id]
        if stone and (not best or stone.Multiplier > best.Multiplier) then best = stone end
    end
    return best
end

function xDTaraZ.Shop.BuyStones()
    local data = xDTaraZ.Game.Profile()
    if not data then return end
    if xDTaraZ.Game.Activity() ~= "Idle" then return end
    local pick = xDTaraZ.Shop.Affordable()
    if pick then
        xDTaraZ:Send("Buy", pick.Id)
        xDTaraZ:Notify("Bought " .. pick.Name)
        task.wait(0.5)
    end

    local best = xDTaraZ.Shop.BestOwned()
    if best and data.EquippedStone ~= best.Id then xDTaraZ:Send("Equip", best.Id) end
end

function xDTaraZ.Shop.Affordable()
    local data = xDTaraZ.Game.Profile()
    local _, worldId = xDTaraZ.Game.World()
    local world = xDTaraZ.WorldById[worldId]
    if not (data and world) then return nil end
    local budget = xDTaraZ.Game.Wins() - State.Opt.StoneReserve
    local owned = data.OwnedStones or {}
    local pick
    for _, id in ipairs(world.StoneIds) do
        local stone = xDTaraZ.StoneById[id]
        if stone and not owned[id] and stone.Price <= budget and (not pick or stone.Multiplier > pick.Multiplier) then
            pick = stone
        end
    end
    return pick
end

function xDTaraZ.Shop.CanRebirth()
    local data = xDTaraZ.Game.Profile()
    if not data then return false end
    if osClock() - (State.Last.RebirthSent or 0) < Config.RebirthInterval then return false end
    return (tonumber(data.Level) or 0) >= xDTaraZ.Game.RebirthLevel(data)
end

---@return boolean  something needs the player idle outside training
function xDTaraZ.Shop.Pending()
    local opt = State.Opt
    if opt.AutoBuyStone and xDTaraZ.Shop.Affordable() then return true end
    return opt.AutoRebirth and xDTaraZ.Shop.CanRebirth()
end

function xDTaraZ.Shop.IdleTasks()
    if State.Opt.AutoRebirth then xDTaraZ.Shop.Rebirth() end
    if State.Opt.AutoBuyStone then xDTaraZ.Shop.BuyStones() end
end

function xDTaraZ.Shop.Rebirth()
    local data = xDTaraZ.Game.Profile()
    if not data then return end
    if xDTaraZ.Game.Activity() ~= "Idle" or not xDTaraZ.Shop.CanRebirth() then return end
    local rebirths = tonumber(data.Rebirths) or 0
    State.Last.RebirthSent = osClock()
    xDTaraZ:Send("Rebirth", rebirths)
    xDTaraZ:Notify("Rebirth " .. (rebirths + 1))
end

function xDTaraZ.Shop.Travel()
    local data = xDTaraZ.Game.Profile()
    local _, worldId = xDTaraZ.Game.World()
    local world = xDTaraZ.WorldById[worldId]
    local nextId = world and world.NextWorldId
    if not (data and nextId and data[nextId .. "Unlocked"]) then return end
    if xDTaraZ.Shop.NextStone() then return end
    local current = xDTaraZ.Game.World()
    local prompt = current and current:FindFirstChild("WorldPortal") and current.WorldPortal:FindFirstChild("WorldTravelPrompt", true)
    if not prompt then return end
    State.Status = "Traveling to " .. nextId
    if not xDTaraZ.Move.Travel(prompt.Parent.WorldPosition) then return end
    fireproximityprompt(prompt)
    xDTaraZ:Notify("Traveling to " .. nextId)
end

xDTaraZ.Pets = {}

function xDTaraZ.Pets.EggList()
    local list = {}
    local world = xDTaraZ.Game.World()
    local displays = world and world:FindFirstChild("EggShop") and world.EggShop:FindFirstChild("Displays")
    if not displays then return list end
    for _, egg in ipairs(displays:GetChildren()) do
        if egg:GetAttribute("Wins") then table.insert(list, { egg.Name, egg:GetAttribute("Wins") }) end
    end
    table.sort(list, function(a, b) return a[2] < b[2] end)
    return list
end

---@return string?  chosen egg id, "Best" = priciest one you can afford
function xDTaraZ.Pets.PickEgg()
    local choice = State.Opt.HatchEgg
    if choice ~= "Best" then return choice end
    local spendable = xDTaraZ.Game.Wins() - State.Opt.HatchReserve
    local pick
    for _, egg in ipairs(xDTaraZ.Pets.EggList()) do
        if egg[2] <= spendable then pick = egg[1] end
    end
    return pick
end

function xDTaraZ.Pets.HatchShop()
    local data = xDTaraZ.Game.Profile()
    local eggId = xDTaraZ.Pets.PickEgg()
    local pos, egg = xDTaraZ.Move.EggSpot(eggId or "")
    if not (data and pos) then return end
    local price = egg:GetAttribute("Wins") or math.huge
    local function Batch()
        local spendable = xDTaraZ.Game.Wins() - State.Opt.HatchReserve
        return math.min(math.max(1, tonumber(data.MultiHatchCount) or 1), math.floor(spendable / price))
    end
    if Batch() < 1 then return end

    State.Status = "Hatching " .. eggId
    if not xDTaraZ.Move.Travel(pos) then return end
    for _ = 1, Config.HatchBurst do
        local count = Batch()
        if count < 1 or not State.Alive then break end
        State.HatchId = (State.HatchId or 0) + 1
        xDTaraZ:Send("HatchEgg", { EggId = eggId, Count = count, RequestId = State.HatchId })
        task.wait(Config.HatchCooldown)
        xDTaraZ.Game.SkipReveal()
        data = xDTaraZ.Game.Profile() or data
    end
end

function xDTaraZ.Pets.HatchInventory()
    local data = xDTaraZ.Game.Profile()
    if not data then return end
    for eggId, amount in pairs(data.Eggs or {}) do
        if (tonumber(amount) or 0) > 0 then
            xDTaraZ:Send("HatchInventoryEgg", eggId)
            task.wait(1)
            xDTaraZ.Game.SkipReveal()
            return
        end
    end
end

xDTaraZ.Rewards = {}

function xDTaraZ.Rewards.Claim()
    local data = xDTaraZ.Game.Profile()
    if not data then return end
    local now = osTime()

    local gifts = GameLib.Balance.GiftRewards
    local claimed = data.GiftClaimed or {}
    local started = tonumber(data.GiftStartedAt) or now
    if now >= (tonumber(data.GiftCooldownUntil) or 0) then
        for i, unlock in ipairs(gifts.UnlockSeconds) do
            if not (claimed[i] or claimed[tostring(i)]) and now - started >= unlock then
                xDTaraZ:Send("ClaimGift", i)
                task.wait(0.3)
            end
        end
    end

    if now >= (tonumber(data.DailyNextClaimAt) or math.huge) then
        local day = (tonumber(data.DailyClaimed) or 0) % #GameLib.Balance.DailyRewards.Rewards + 1
        xDTaraZ:Send("ClaimDaily", { Day = day, Cycle = data.DailyCycle or 0 })
    end

    if (tonumber(data.OfflineSkill) or 0) > 0 then xDTaraZ:Send("ClaimOffline") end

    if not data.FreeRewardClaimed and not State.Last.FreeTried then
        State.Last.FreeTried = true
        xDTaraZ:Send("ClaimFreeReward")
    end
end

function xDTaraZ.Rewards.UsePotions()
    local data = xDTaraZ.Game.Profile()
    if not data then return end
    local active = data.BoostExpiresAt or {}
    local now = osTime()
    for kind, count in pairs(data.Potions or {}) do
        if State.Opt.Potions[kind] and (tonumber(count) or 0) > 0 and (tonumber(active[kind]) or 0) <= now then
            xDTaraZ:Send("UsePotion", kind)
            task.wait(0.5)
        end
    end
end

function xDTaraZ.Rewards.RedeemAll()
    for _, code in ipairs(Config.Codes) do
        xDTaraZ:Send("RedeemCode", code)
        task.wait(1)
    end
end

xDTaraZ.Client = {}

function xDTaraZ.Client.Bind()
    table.insert(State.Connections, GameLib.Event.OnClientEvent:Connect(function(action, info)
        if type(info) ~= "table" then return end
        if action == "CodeResult" or action == "GiftRewardResult" then
            table.insert(State.Messages, tostring(info.Message))
        elseif action == "Bounce" or action == "PracticeGain" then
            State.SkillEarned += tonumber(info.Skill) or 0
        end
    end))

    table.insert(State.Connections, LocalPlayer.Idled:Connect(function()
        if not State.Opt.AntiAfk then return end
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.zero)
    end))

    table.insert(State.Connections, UserInputService.JumpRequest:Connect(function()
        if not State.Opt.InfJump then return end
        local _, hum = xDTaraZ:Character()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end))

    table.insert(State.Connections, LocalPlayer.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid", 10)
        State.BaseSpeed = nil
        xDTaraZ.Move.ApplySpeed()
    end))

    table.insert(State.Connections, GuiService.ErrorMessageChanged:Connect(function()
        if not State.Opt.AutoRejoin or State.Rejoining or GuiService:GetErrorMessage() == "" then return end
        State.Rejoining = true
        task.wait(Config.RejoinDelay)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end))
end

xDTaraZ.Scheduler = {}

xDTaraZ.Scheduler.RequestHandlers = {
    Speed = xDTaraZ.Move.ApplySpeed,
    ThrowNow = xDTaraZ.Throw.Once,
    TrainNow = xDTaraZ.Train.Step,
    StoneNow = xDTaraZ.Shop.BuyStones,
    RebirthNow = function()
        local data = xDTaraZ.Game.Profile()
        if data then xDTaraZ:Send("Rebirth", tonumber(data.Rebirths) or 0) end
    end,
    TravelNow = xDTaraZ.Shop.Travel,
    HatchNow = xDTaraZ.Pets.HatchShop,
    InventoryNow = xDTaraZ.Pets.HatchInventory,
    PotionNow = xDTaraZ.Rewards.UsePotions,
    ClaimNow = xDTaraZ.Rewards.Claim,
    CodesNow = xDTaraZ.Rewards.RedeemAll,
    LaunchTp = function() local p = xDTaraZ.Move.LaunchSpot() if p then xDTaraZ.Move.Travel(p) end end,
    EggTp = function() local p = xDTaraZ.Move.EggSpot(xDTaraZ.Pets.PickEgg() or "Common") if p then xDTaraZ.Move.Travel(p) end end,
}

function xDTaraZ.Scheduler.Run(fn)
    local ok, err = pcall(fn)
    if not ok then warn("[StoneSkipping]", err) end
end

function xDTaraZ.Scheduler.Every(key, interval, fn)
    if osClock() - (State.Last[key] or 0) < interval then return end
    State.Last[key] = osClock()
    xDTaraZ.Scheduler.Run(fn)
end

function xDTaraZ.Scheduler.Summarize()
    local data = xDTaraZ.Game.Profile()
    if not data then
        State.Summary = xDTaraZ.Caps.Gc and "Waiting for game data..." or "Executor missing getgc"
        return
    end
    local cutoff = osClock() - Config.RateWindow
    local recent = 0
    for i = #State.EarnLog, 1, -1 do
        local entry = State.EarnLog[i]
        if entry[1] < cutoff then table.remove(State.EarnLog, i) else recent += entry[2] end
    end
    local stone = xDTaraZ.StoneById[data.EquippedStone]
    State.Summary = ("Level %s · Rebirth %s · Wins %s\nStone %s (x%s) · %s wins/min"):format(
        tostring(data.Level), tostring(data.Rebirths), xDTaraZ.Format(data.Wins),
        stone and stone.Name or "-", stone and xDTaraZ.Format(stone.Multiplier) or "-",
        xDTaraZ.Format(recent * 60 / Config.RateWindow))
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

    local _, hum = xDTaraZ:Character()
    if not hum then return end
    if opt.SpeedOn and hum.WalkSpeed ~= opt.WalkSpeed then xDTaraZ.Move.ApplySpeed() end
    if xDTaraZ.Game.Activity() == "Throw" then return end
    if xDTaraZ.Game.HatchActive() then return xDTaraZ.Scheduler.Run(xDTaraZ.Game.SkipReveal) end

    if opt.AutoClaim then xDTaraZ.Scheduler.Every("Claim", Config.ClaimInterval, xDTaraZ.Rewards.Claim) end
    if opt.AutoPotions then xDTaraZ.Scheduler.Every("Potion", Config.PotionInterval, xDTaraZ.Rewards.UsePotions) end
    if xDTaraZ.Game.Activity() == "Idle" then xDTaraZ.Scheduler.Every("Idle", Config.BuyInterval, xDTaraZ.Shop.IdleTasks) end
    if opt.AutoTravel then xDTaraZ.Scheduler.Every("Travel", Config.BuyInterval, xDTaraZ.Shop.Travel) end
    if opt.AutoInventoryHatch then xDTaraZ.Scheduler.Every("Inventory", Config.BuyInterval, xDTaraZ.Pets.HatchInventory) end
    if opt.AutoHatch then xDTaraZ.Scheduler.Every("Hatch", Config.BuyInterval, xDTaraZ.Pets.HatchShop) end
    if opt.AutoFarm then xDTaraZ.Scheduler.Run(xDTaraZ.Farm.Step) end
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Client.Bind()
    task.spawn(function()
        while State.Alive do
            xDTaraZ.Scheduler.Step()
            task.wait(Config.TickDelay)
        end
    end)
end

function xDTaraZ.Scheduler.Stop()
    State.Alive = false
    for _, conn in ipairs(State.Connections) do conn:Disconnect() end
    table.clear(State.Connections)
    State.Opt.SpeedOn = false
    xDTaraZ.Move.ApplySpeed()
end

local function BuildInterface()
    local Library = loadstring(game:HttpGet(Config.UiSource))()
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt

    local function Notify(text)
        Library:Notify("Stone Skipping", text, 4)
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

    local function NeedCap(idx, cap)
        if xDTaraZ.Caps[cap] then return end
        local option = Options[idx]
        if not option then return end
        option:OnChanged(function(on)
            if not on then return end
            local title = option.Row and option.Row.Title
            Notify((title and title.Text or idx) .. " is not supported on this executor")
            task.defer(function() option:SetValue(false) end)
        end)
    end

    local function BuildTabs()
        local Window = Library.Window
        Window:AddTabSection(T("Main", "หลัก"))
        local MainTab = Window:AddTab(T("Main", "หลัก"), "house", T("Status and all-in-one mode", "สถานะและโหมดทำทุกอย่าง"))
        Window:AddTabSection(T("Farming", "ฟาร์ม"))
        local FarmTab = Window:AddTab(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "star", T("Throwing and training", "ปาหินและฝึก"))
        Window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local ShopTab = Window:AddTab(T("Stones & Rebirth", "หินและรีเบิร์ธ"), "shop", T("Stones, rebirth and worlds", "หิน รีเบิร์ธ และโลก"))
        local PetTab = Window:AddTab(T("Pets & Rewards", "สัตว์เลี้ยงและรางวัล"), "mushroom", T("Eggs, potions, rewards and codes", "ไข่ ยา รางวัล และโค้ด"))
        Window:AddTabSection(T("Misc", "อื่นๆ"))
        local PlayerTab = Window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and teleports", "การเคลื่อนที่และวาร์ป"))

        local statusBox = MainTab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
        local statusLabel = statusBox:AddLabel(T("Loading...", "กำลังโหลด..."))
        local runLabel = statusBox:AddLabel("-")

        local kaitunBox = MainTab:AddRightGroupbox(T("Kaitun", "ไก่ตัน"), "oneup")
        kaitunBox:AddToggle("Kaitun", {
            Text = T("Kaitun (All-in-one)", "ไก่ตัน (ทำทุกอย่าง)"),
            Description = T("Trains, throws, upgrades, rebirths and claims rewards by itself", "ฝึก ปาหิน อัปเกรด รีเบิร์ธ และรับรางวัลให้เอง"),
            NoSave = true,
            Callback = function(value)
                State.KaitunSet = State.KaitunSet or {}
                for _, key in ipairs({ "AutoFarm", "AutoBuyStone", "AutoRebirth", "AutoTravel", "AutoInventoryHatch", "AutoPotions", "AutoClaim", "AntiAfk" }) do
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

        local farmBox = FarmTab:AddLeftGroupbox(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "star")
        Toggle(farmBox, "AutoFarm", T("Auto Farm", "ฟาร์มอัตโนมัติ"), T("Earns skill and wins without stopping", "ฟาร์ม Skill และ Wins ไม่หยุด"))
        farmBox:AddDropdown("FarmMode", {
            Text = T("Farm Mode", "โหมดฟาร์ม"),
            Description = T("Smart: throws for wins when needed, trains otherwise", "Smart: ปาหินเมื่อต้องใช้ Wins นอกนั้นฝึก Skill"),
            Values = { "Smart", "Train", "Throw" },
            Default = 1,
            Callback = function(value) opt.FarmMode = value or "Smart" end,
        })
        local zoneChoices = { "Best" }
        for _, zone in ipairs(xDTaraZ.TrainZones) do table.insert(zoneChoices, zone.Name) end
        farmBox:AddDropdown("TrainZone", {
            Text = T("Training Zone", "โซนฝึก"),
            Description = T("Best = strongest zone you have unlocked", "Best = โซนที่ดีที่สุดที่ปลดล็อกแล้ว"),
            Values = zoneChoices,
            Default = 1,
            Callback = function(value) opt.TrainZone = value or "Best" end,
        })

        local nowBox = FarmTab:AddRightGroupbox(T("Manual", "สั่งเอง"), "target")
        nowBox:AddButton({ Text = T("Throw Now", "ปาหินเดี๋ยวนี้"), Style = "Primary", Func = Request("ThrowNow") })
        nowBox:AddButton({ Text = T("Go Train Now", "ไปฝึกเดี๋ยวนี้"), Func = Request("TrainNow") })

        local stoneBox = ShopTab:AddLeftGroupbox(T("Stones", "หิน"), "coin")
        Toggle(stoneBox, "AutoBuyStone", T("Auto Buy Best Stone", "ซื้อหินดีสุดอัตโนมัติ"), T("Buys and equips the strongest stone you can afford", "ซื้อและใส่หินที่แรงที่สุดที่ซื้อไหว"))
        stoneBox:AddSlider("StoneReserve", {
            Text = T("Keep Wins", "กัน Wins ไว้"),
            Min = 0, Max = 100000, Default = 0, Rounding = 0,
            Callback = function(value) opt.StoneReserve = tonumber(value) or 0 end,
        })
        stoneBox:AddButton({ Text = T("Buy Best Stone Now", "ซื้อหินดีสุดเดี๋ยวนี้"), Func = Request("StoneNow") })

        local rebirthBox = ShopTab:AddRightGroupbox(T("Rebirth & Worlds", "รีเบิร์ธและโลก"), "flag")
        Toggle(rebirthBox, "AutoRebirth", T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"), T("Rebirths as soon as your level is high enough", "รีเบิร์ธทันทีเมื่อเลเวลถึง"))
        rebirthBox:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Func = Request("RebirthNow") })
        Toggle(rebirthBox, "AutoTravel", T("Auto Next World", "ไปโลกถัดไปอัตโนมัติ"), T("Moves to the next world once it is unlocked and this world's stones are done", "ย้ายไปโลกถัดไปเมื่อปลดล็อกและซื้อหินโลกนี้ครบแล้ว"))
        rebirthBox:AddButton({ Text = T("Next World Now", "ไปโลกถัดไปเดี๋ยวนี้"), Func = Request("TravelNow") })

        local eggBox = PetTab:AddLeftGroupbox(T("Eggs", "ไข่"), "mushroom")
        Toggle(eggBox, "AutoHatch", T("Auto Hatch", "ฟักไข่อัตโนมัติ"), T("Buys and hatches the selected egg with wins", "ซื้อและฟักไข่ที่เลือกด้วย Wins"))
        local function EggNames()
            local names = { "Best" }
            for _, egg in ipairs(xDTaraZ.Pets.EggList()) do table.insert(names, egg[1]) end
            return names
        end
        local eggDropdown = eggBox:AddDropdown("HatchEgg", {
            Text = T("Egg", "ไข่"),
            Values = EggNames(),
            Default = 1,
            Callback = function(value) opt.HatchEgg = value or "Best" end,
        })
        eggBox:AddButton({ Text = T("Refresh Eggs", "รีเฟรชรายการไข่"), Func = function() eggDropdown:SetValues(EggNames()) end })
        eggBox:AddSlider("HatchReserve", {
            Text = T("Keep Wins", "กัน Wins ไว้"),
            Min = 0, Max = 100000, Default = 0, Rounding = 0,
            Callback = function(value) opt.HatchReserve = tonumber(value) or 0 end,
        })
        eggBox:AddButton({ Text = T("Hatch Now", "ฟักเดี๋ยวนี้"), Func = Request("HatchNow") })
        Toggle(eggBox, "AutoInventoryHatch", T("Auto Open Inventory Eggs", "เปิดไข่ในกระเป๋าอัตโนมัติ"), T("Opens eggs from codes, gifts and daily rewards", "เปิดไข่ที่ได้จากโค้ด ของขวัญ และรางวัลรายวัน"))
        eggBox:AddButton({ Text = T("Open Inventory Egg Now", "เปิดไข่ในกระเป๋าเดี๋ยวนี้"), Func = Request("InventoryNow") })

        local rewardBox = PetTab:AddRightGroupbox(T("Rewards", "รางวัล"), "coin")
        Toggle(rewardBox, "AutoClaim", T("Auto Claim", "รับรางวัลอัตโนมัติ"), T("Claims playtime gifts, daily, offline and group rewards", "รับของขวัญเวลาเล่น รางวัลรายวัน ออฟไลน์ และกลุ่ม"))
        rewardBox:AddButton({ Text = T("Claim Now", "รับเดี๋ยวนี้"), Func = Request("ClaimNow") })
        Toggle(rewardBox, "AutoPotions", T("Auto Use Potions", "ใช้ยาอัตโนมัติ"), T("Keeps the selected boosts running", "เปิดบูสต์ที่เลือกไว้ตลอด"))
        rewardBox:AddDropdown("Potions", {
            Text = T("Potions", "ยา"),
            Values = { "Skill", "Win", "Luck" },
            Multi = true,
            Default = { "Skill", "Win", "Luck" },
            Callback = function(selected) opt.Potions = selected end,
        })
        rewardBox:AddButton({ Text = T("Use Potions Now", "ใช้ยาเดี๋ยวนี้"), Func = Request("PotionNow") })
        rewardBox:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Style = "Primary", Func = Request("CodesNow") })

        local moveBox = PlayerTab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "star")
        Toggle(moveBox, "SpeedOn", T("Speed", "ความเร็ว"), nil, Request("Speed"))
        moveBox:AddSlider("WalkSpeed", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Min = 16, Max = 150, Default = opt.WalkSpeed, Rounding = 0,
            Callback = function(value)
                opt.WalkSpeed = tonumber(value) or opt.WalkSpeed
                State.Requests.Speed = true
            end,
        })
        Toggle(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))

        local tpBox = PlayerTab:AddRightGroupbox(T("Teleport", "วาร์ป"), "teleport")
        tpBox:AddButton({ Text = T("Throw Zone", "โซนปาหิน"), Func = Request("LaunchTp") })
        tpBox:AddButton({ Text = T("Best Training Zone", "โซนฝึกที่ดีที่สุด"), Func = Request("TrainNow") })
        tpBox:AddButton({ Text = T("Selected Egg", "ไข่ที่เลือก"), Func = Request("EggTp") })

        local settingsTab = Window:AddSettingsTab()
        local sessionBox = settingsTab:AddLeftGroupbox(T("Session", "เซสชัน"), "gear")
        Toggle(sessionBox, "AntiAfk", T("Anti AFK", "กันหลุด AFK"), T("Stops the idle kick", "กันโดนเตะเพราะไม่ขยับ"))
        Toggle(sessionBox, "AutoRejoin", T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"))

        for _, idx in ipairs({ "AutoFarm", "AutoBuyStone", "AutoRebirth", "AutoTravel", "AutoHatch", "AutoInventoryHatch", "AutoPotions", "AutoClaim" }) do
            NeedCap(idx, "Gc")
        end
        NeedCap("AutoTravel", "Prompt")

        Library:Every(1, function()
            while #State.Messages > 0 do
                Notify(table.remove(State.Messages, 1))
            end
            statusLabel:SetText(State.Summary or "-")
            runLabel:SetText(("%s\nThrows %d · Wins +%s · Skill +%s"):format(State.Status, State.Throws, xDTaraZ.Format(State.WinsEarned), xDTaraZ.Format(State.SkillEarned)))
        end)
    end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    getgenv().StoneSkippingUnload = function()
        Library:Unload()
    end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Stone Skipping by xDTaraZ",
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

if getgenv().StoneSkippingUnload then
    pcall(getgenv().StoneSkippingUnload)
end

BuildInterface()