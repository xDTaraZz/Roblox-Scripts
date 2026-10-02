if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765012427 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Build the Pyramid only")
    return
end

if not LPH_OBFUSCATED then
    local function Passthrough(fn) return fn end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local osClock = os.clock
local vector3New = Vector3.new

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    SaveFolder = "Build the Pyramid",
    TickDelay = 0.1,
    LoadTimeout = 10,
    SettleDelay = 0.15,
    StreamWait = 2,
    PickupRetries = 3,
    PlaceTimeout = 3,
    PlaceRetries = 3,
    PlaceReach = 28,
    SlotSpacing = 4,
    HoverHeight = 6,
    SlotSearchCells = 200,
    QuarrySpot = vector3New(-234, -16, 38),
    BenchRange = 12,
    BenchRetry = 2,
    StandRadius = 4,
    UpgradeInterval = 2,
    CodeGap = 1.1,
    ActivityInterval = 60,
    RateWindow = 60,
    RejoinDelay = 5,
    SlowRequests = { UpgradeNow = true, CodesNow = true },
    ExtraCodes = { "SUNGOD", "SORRYFORUPDATEBUG", "FREECODE", "WELCOME", "DEADBYMELOL", "UPDATE15", "PYRAMID1500" },
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    MoveConns = {},
    Requests = {},
    Running = {},
    Messages = {},
    Last = {},
    Stats = {},
    CoinLog = {},
    Status = "Idle",
    Task = "None",
    Placed = 0,
    Opt = {
        AutoFarm = false,
        ReturnOnStop = false,
        AutoUpgrade = false,
        Upgrades = {},
        UpgradeOrder = "Cheapest First",
        KeepCoins = 0,
        AutoStrength = false,
        AutoSpeed = false,
        Priority = "Farm",
        AlternateMinutes = 5,
        AutoPool = false,
        SpeedOn = false,
        WalkSpeed = 50,
        Fly = false,
        FlySpeed = 60,
        Noclip = false,
        InfJump = false,
        AntiAfk = false,
        AutoRejoin = false,
        NoRender = false,
    },
}

local Config, State = xDTaraZ.Config, xDTaraZ.State
local Shared = ReplicatedStorage:WaitForChild("Shared")
local SharedConfig = Shared:WaitForChild("Config")
local KnitServices = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services")

---@return Instance?  RF/RE under a Knit service, nil if the game renamed it
local function Remote(service, kind, name)
    local svc = KnitServices:WaitForChild(service, Config.LoadTimeout)
    local folder = svc and svc:WaitForChild(kind, Config.LoadTimeout)
    return folder and folder:WaitForChild(name, Config.LoadTimeout)
end

xDTaraZ.GameLib = {
    Pyramid = require(SharedConfig.PyramidConfig),
    Carry = require(SharedConfig.CarryConfig),
    Upgrades = require(SharedConfig.UpgradeCatalog),
    Gym = require(SharedConfig.GymConfig),
    Codes = require(SharedConfig.CodesConfig),
    Completion = require(SharedConfig.PyramidCompletionConfig),
    GymAccess = require(Shared:WaitForChild("Gym"):WaitForChild("GymAccess")),
    Runtime = require(Shared:WaitForChild("Placement"):WaitForChild("PyramidRuntime")),
    CarryState = require(Shared:WaitForChild("Books"):WaitForChild("CarryState")),
    Regions = require(Shared:WaitForChild("RegionRegistry")),
    Knit = require(ReplicatedStorage.Packages:WaitForChild("Knit")),
    Pickup = Remote("BookService", "RF", "Pickup"),
    Place = Remote("PyramidService", "RF", "Place"),
    Purchase = Remote("DataService", "RF", "PurchaseUpgrade"),
    StartBench = Remote("GymService", "RF", "StartBench"),
    StopBench = Remote("GymService", "RF", "StopBench"),
    Redeem = Remote("CodesService", "RF", "Redeem"),
    Activity = Remote("AFKService", "RE", "Activity"),
}

local GameLib = xDTaraZ.GameLib

xDTaraZ.UpgradeByName = {}
xDTaraZ.UpgradeNames = {}
do
    for _, upgrade in ipairs(GameLib.Upgrades.Upgrades) do
        xDTaraZ.UpgradeByName[upgrade.DisplayName] = upgrade
        table.insert(xDTaraZ.UpgradeNames, upgrade.DisplayName)
    end
end

xDTaraZ.CodeList = {}
do
    local seen = {}
    local function Add(code)
        if seen[code] then return end
        seen[code] = true
        xDTaraZ.CodeList[#xDTaraZ.CodeList + 1] = code
    end
    for code in pairs(GameLib.Codes.Codes) do Add(code) end
    for _, code in ipairs(Config.ExtraCodes) do Add(code) end
end

xDTaraZ.Util = {}

---@return string?  body, nil when no http function works
function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then return body end
    local requester = request or http_request or (syn and syn.request) or (http and http.request)
    if not requester then return nil end
    local sent, reply = pcall(requester, { Url = url, Method = "GET" })
    return sent and type(reply) == "table" and reply.Body or nil
end

function xDTaraZ.Util.Copy(text)
    local copy = setclipboard or toclipboard
    if not copy then return false end
    copy(text)
    return true
end

function xDTaraZ.Format(n)
    n = tonumber(n) or 0
    local units = { "", "K", "M", "B", "T", "Qa", "Qi" }
    local i = 1
    while math.abs(n) >= 1000 and i < #units do
        n /= 1000
        i += 1
    end
    return (i == 1 and "%d%s" or "%.2f%s"):format(n, units[i])
end

function xDTaraZ:Notify(msg)
    table.insert(self.State.Messages, msg)
end

function xDTaraZ:Character()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp and hum.Health > 0) then return nil end
    return char, hum, hrp
end

function xDTaraZ:Invoke(remote, ...)
    if not remote then return false, "missing remote" end
    local packed = table.pack(pcall(remote.InvokeServer, remote, ...))
    if not packed[1] then
        warn("[BuildThePyramid]", remote.Name, packed[2])
        return false, packed[2]
    end
    return table.unpack(packed, 2, packed.n)
end

xDTaraZ.Game = {}

function xDTaraZ.Game.Attr(name)
    return LocalPlayer:GetAttribute(name)
end

function xDTaraZ.Game.UpgradeLevel(upgrade)
    return tonumber(LocalPlayer:GetAttribute(GameLib.Upgrades.AttributePrefix .. upgrade.Attribute)) or 0
end

function xDTaraZ.Game.Capacity()
    return GameLib.Carry.Capacity + (tonumber(xDTaraZ.Game.Attr("StrengthLevel")) or 0)
end

function xDTaraZ.Game.Carried()
    if State.Carry then return State.Carry end
    local ok, state = pcall(GameLib.CarryState.read, LocalPlayer)
    return ok and type(state) == "table" and tonumber(state.count) or 0
end

function xDTaraZ.Game.Coins()
    return tonumber(State.Stats.Coins) or 0
end

function xDTaraZ.Game.Benching()
    local station = xDTaraZ.Game.Attr(GameLib.Gym.BenchStationAttribute)
    return type(station) == "string" and station ~= "" and station or nil
end

function xDTaraZ.Game.Model()
    return Workspace:FindFirstChild(GameLib.Pyramid.ModelName)
end

---@return boolean  completion window running (pool is open)
function xDTaraZ.Game.Completed()
    local model = xDTaraZ.Game.Model()
    if not model then return false end
    if model:GetAttribute(GameLib.Pyramid.CompleteAttribute) == true then return true end
    local endsAt = tonumber(model:GetAttribute(GameLib.Completion.CompletionEndsAtAttribute)) or 0
    return endsAt > Workspace:GetServerTimeNow()
end

---@param carryState any  "revision:count:..." string from a Pickup/Place reply
---@return number?         blocks held, nil when the reply carries no state
function xDTaraZ.Game.ReadCarry(carryState)
    if type(carryState) ~= "string" then return nil end
    local ok, decoded = pcall(GameLib.CarryState.decode, carryState)
    return ok and type(decoded) == "table" and tonumber(decoded.count) or nil
end

function xDTaraZ.Game.WatchStats()
    local ok, err = pcall(function()
        GameLib.Knit.OnStart():await()
        local prop = GameLib.Knit.GetService("DataService").StatValues
        local conn = prop:Observe(function(values)
            if type(values) ~= "table" then return end
            local before = tonumber(State.Stats.Coins)
            local now = tonumber(values.Coins)
            if before and now and now > before then table.insert(State.CoinLog, { osClock(), now - before }) end
            State.Stats = values
        end)
        table.insert(State.Connections, conn)
    end)
    if not ok then warn("[BuildThePyramid] stats:", err) end
end

xDTaraZ.Move = {}

---@param pos Vector3  streams the area in the background, gives up after Config.StreamWait
function xDTaraZ.Move.Stream(pos)
    local finished = false
    task.spawn(function()
        pcall(LocalPlayer.RequestStreamAroundAsync, LocalPlayer, pos, Config.StreamWait)
        finished = true
    end)
    local deadline = osClock() + Config.StreamWait
    while not finished and osClock() < deadline do task.wait() end
end

---@param stream boolean?  ask the engine to load the destination first (far targets only)
function xDTaraZ.Move.To(pos, stream)
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return false end
    if stream and (hrp.Position - pos).Magnitude > 200 then xDTaraZ.Move.Stream(pos) end
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.CFrame = CFrame.new(pos) * hrp.CFrame.Rotation
    return true
end

function xDTaraZ.Move.Near(pos, radius)
    local _, _, hrp = xDTaraZ:Character()
    return hrp ~= nil and (hrp.Position - pos).Magnitude <= (radius or Config.StandRadius)
end

function xDTaraZ.Move.QuarrySpot()
    local region = GameLib.Regions.getPart("Quarry")
    if not (region and region:IsA("BasePart")) then return Config.QuarrySpot end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LocalPlayer.Character, region, Workspace:FindFirstChild(GameLib.Pyramid.QuarryFolderName) }
    local top = region.Position + vector3New(0, region.Size.Y / 2, 0)
    local hit = Workspace:Raycast(top, vector3New(0, -region.Size.Y - 50, 0), params)
    local spot = hit and hit.Position + vector3New(0, 3, 0)
    if spot and GameLib.Regions.isWithin("Quarry", spot) then return spot end
    return Config.QuarrySpot
end

function xDTaraZ.Move.GymPart(folder, model, part)
    local gym = Workspace:FindFirstChild(GameLib.Gym.GymFolderName)
    local station = gym and gym:FindFirstChild(folder)
    local machine = station and station:FindFirstChild(model)
    local found = machine and machine:FindFirstChild(part)
    return found and found:IsA("BasePart") and found or nil
end

function xDTaraZ.Move.PoolSpot()
    local display = Workspace:FindFirstChild(GameLib.Completion.CompletedDisplayName)
    local hitbox = display and display:FindFirstChild(GameLib.Completion.PoolHitboxName)
    return hitbox and hitbox:IsA("BasePart") and hitbox.Position or nil
end

function xDTaraZ.Move.Frame()
    local char, hum, hrp = xDTaraZ:Character()
    if not char then return end
    if State.Opt.SpeedOn and not State.Opt.Fly and hum.MoveDirection.Magnitude > 0 then
        local velocity = hrp.AssemblyLinearVelocity
        hrp.AssemblyLinearVelocity = vector3New(hum.MoveDirection.X * State.Opt.WalkSpeed, velocity.Y, hum.MoveDirection.Z * State.Opt.WalkSpeed)
    end
    if State.Opt.Noclip then
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide then
                State.Collided[part] = true
                part.CanCollide = false
            end
        end
    end
    if not State.Opt.Fly then return end
    local cam = Workspace.CurrentCamera
    local dir = hum.MoveDirection
    local lift = cam and dir.Magnitude > 0 and cam.CFrame.LookVector.Y * dir.Magnitude or 0
    hum.PlatformStand = true
    hrp.AssemblyLinearVelocity = (dir + vector3New(0, lift, 0)) * State.Opt.FlySpeed
end

function xDTaraZ.Move.Refresh()
    local opt = State.Opt
    local want = opt.Fly or opt.Noclip or opt.SpeedOn
    if want and #State.MoveConns == 0 then
        State.Collided = State.Collided or {}
        table.insert(State.MoveConns, RunService.Stepped:Connect(xDTaraZ.Move.Frame))
    elseif not want then
        for _, conn in ipairs(State.MoveConns) do conn:Disconnect() end
        table.clear(State.MoveConns)
    end
    if not opt.Noclip and State.Collided then
        for part in pairs(State.Collided) do
            if part.Parent then part.CanCollide = true end
        end
        table.clear(State.Collided)
    end
    local _, hum = xDTaraZ:Character()
    if hum and not opt.Fly and hum.PlatformStand then hum.PlatformStand = false end
end

xDTaraZ.Farm = {}

---@return boolean  holding at least one block
function xDTaraZ.Farm.Gather()
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    local cap = xDTaraZ.Game.Capacity()
    if xDTaraZ.Game.Carried() >= cap then return true end

    State.Status = "Picking up blocks"
    if not xDTaraZ.Move.To(xDTaraZ.Move.QuarrySpot()) then return false end
    task.wait(Config.SettleDelay)

    local region = GameLib.Regions.getPart("Quarry")
    local grant = 1 + xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPickup)
    local carried, misses = xDTaraZ.Game.Carried(), 0
    local calls = math.ceil(cap / grant) + Config.PickupRetries
    for _ = 1, calls do
        if carried >= cap or not State.Opt.AutoFarm then break end
        local ok, carryState = xDTaraZ:Invoke(GameLib.Pickup, region)
        if ok == true then
            carried = xDTaraZ.Game.ReadCarry(carryState) or carried
            State.Carry = carried
            misses = 0
        else
            misses += 1
            if carried > 0 or misses >= Config.PickupRetries then break end
            task.wait(Config.SettleDelay)
        end
    end
    if carried > 0 then return true end
    State.Carry = cap
    return true
end

---@param origin Vector3  where the character stands
---@param count number     slots wanted
---@return table[]         free slots in reach, far enough apart that bulk fills do not overlap
function xDTaraZ.Farm.Slots(origin, count, radius)
    local picked, cells, rejected = {}, {}, {}
    local geometry = GameLib.Runtime.getGeometry(Workspace, 2)
    local function Skip(layer, index)
        if rejected[layer .. ":" .. index] then return true end
        local col, row = geometry.fromSlotIndex(layer, index)
        for _, cell in ipairs(cells) do
            if cell.layer == layer and math.max(math.abs(cell.col - col), math.abs(cell.row - row)) < Config.SlotSpacing then
                return true
            end
        end
        return false
    end
    for _ = 1, count * 3 do
        if #picked >= count then break end
        local slot = GameLib.Runtime.resolveNearestSlot(origin, Workspace, Skip, radius)
        if not slot then break end
        local flat = vector3New(slot.position.X - origin.X, 0, slot.position.Z - origin.Z)
        if flat.Magnitude <= Config.PlaceReach then
            local col, row = geometry.fromSlotIndex(slot.layer, slot.slotIndex)
            table.insert(cells, { layer = slot.layer, col = col, row = row })
            table.insert(picked, slot)
        else
            rejected[slot.layer .. ":" .. slot.slotIndex] = true
        end
    end
    return picked
end

---@return number  blocks still carried
function xDTaraZ.Farm.PlaceBatch(slots)
    local pending, left = #slots, xDTaraZ.Game.Carried()
    for _, slot in ipairs(slots) do
        task.spawn(function()
            local ok, carryState = xDTaraZ:Invoke(GameLib.Place, slot.layer, slot.slotIndex, slot.generation)
            if ok == true then State.Placed += 1 end
            left = math.min(left, xDTaraZ.Game.ReadCarry(carryState) or left)
            pending -= 1
        end)
    end
    local deadline = osClock() + Config.PlaceTimeout
    while pending > 0 and osClock() < deadline do task.wait() end
    State.Carry = left
    return left
end

---@return boolean  false when the pyramid has no free slot
function xDTaraZ.Farm.Deliver()
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then return false end
    local perPlace = 1 + xDTaraZ.Game.UpgradeLevel(GameLib.Upgrades.ById.bulkPlace)

    for _ = 1, Config.PlaceRetries do
        local carried = xDTaraZ.Game.Carried()
        if carried <= 0 or not State.Opt.AutoFarm then return true end
        local first = GameLib.Runtime.resolveNearestSlot(hrp.Position, Workspace, nil, Config.SlotSearchCells)
        if not first then return false end

        State.Status = ("Placing on layer %d"):format(first.layer)
        xDTaraZ.Move.To(first.position + vector3New(0, Config.HoverHeight, 0))
        task.wait(Config.SettleDelay)

        local reach = math.ceil(Config.PlaceReach / GameLib.Pyramid.BlockSize)
        local slots = xDTaraZ.Farm.Slots(hrp.Position, math.ceil(carried / perPlace), reach)
        if #slots == 0 then return false end
        if xDTaraZ.Farm.PlaceBatch(slots) <= 0 then return true end
    end
    return true
end

---@return boolean  did work this tick
function xDTaraZ.Farm.Step()
    if not GameLib.Runtime.getCurrentLayer(Workspace) then return false end
    if not State.FarmOrigin then
        local _, _, hrp = xDTaraZ:Character()
        State.FarmOrigin = hrp and hrp.CFrame
    end
    if not xDTaraZ.Farm.Gather() then
        task.wait(Config.SettleDelay)
        return true
    end
    xDTaraZ.Farm.Deliver()
    return true
end

function xDTaraZ.Farm.Stop()
    local origin = State.FarmOrigin
    State.FarmOrigin = nil
    if not (origin and State.Opt.ReturnOnStop) then return end
    local _, _, hrp = xDTaraZ:Character()
    if hrp then hrp.CFrame = origin end
end

xDTaraZ.Train = {}

function xDTaraZ.Train.HasAccess(folder)
    local access = GameLib.Gym.Access[folder]
    if not access then return false end
    local owned = GameLib.GymAccess.purchasedFromAttribute(xDTaraZ.Game.Attr(GameLib.Gym.GymUnlocksAttribute), folder)
        or GameLib.GymAccess.ownsGamePass(LocalPlayer, access.ProductKey)
    local done = tonumber(xDTaraZ.Game.Attr("Pyramids")) or 0
    return GameLib.GymAccess.hasAccess(access, done, owned)
end

---@param stations table  GymConfig station list
---@return string?        gym folder with the highest multiplier you can use
function xDTaraZ.Train.Best(stations, key)
    local best, bestMult
    for _, station in ipairs(stations) do
        if xDTaraZ.Train.HasAccess(station.GymFolder) and (not bestMult or station[key] > bestMult) then
            best, bestMult = station.GymFolder, station[key]
        end
    end
    return best, bestMult
end

function xDTaraZ.Train.Strength()
    local folder, mult = xDTaraZ.Train.Best(GameLib.Gym.BenchpressStations, "StrengthMultiplier")
    if not folder then return false end
    State.Status = ("Bench press x%d"):format(mult)
    local current = xDTaraZ.Game.Benching()
    if current == folder then return true end
    if current then xDTaraZ:Invoke(GameLib.StopBench) end

    if osClock() - (State.Last.BenchTry or 0) < Config.BenchRetry then return true end
    State.Last.BenchTry = osClock()

    local seat = xDTaraZ.Move.GymPart(folder, GameLib.Gym.BenchpressModelName, GameLib.Gym.AlignPartName)
    if not seat then return false end
    if not xDTaraZ.Move.Near(seat.Position, Config.BenchRange) then
        xDTaraZ.Move.To(seat.Position + vector3New(0, 3, 0))
        task.wait(Config.SettleDelay)
    end
    local ok = xDTaraZ:Invoke(GameLib.StartBench, folder)
    if not ok then State.Status = "Bench refused, retrying" end
    return true
end

function xDTaraZ.Train.Speed()
    local folder, mult = xDTaraZ.Train.Best(GameLib.Gym.TreadmillStations, "SpeedMultiplier")
    local hitbox = folder and xDTaraZ.Move.GymPart(folder, GameLib.Gym.TreadmillModelName, GameLib.Gym.HitboxName)
    if not hitbox then return false end
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    State.Status = ("Treadmill x%d"):format(mult)
    if not xDTaraZ.Move.Near(hitbox.Position) then xDTaraZ.Move.To(hitbox.Position) end
    return true
end

function xDTaraZ.Train.Step()
    local opt = State.Opt
    if opt.AutoStrength and opt.AutoSpeed then
        local str = tonumber(xDTaraZ.Game.Attr("StrengthLevel")) or 0
        local spd = tonumber(xDTaraZ.Game.Attr("SpeedLevel")) or 0
        if spd < str then return xDTaraZ.Train.Speed() end
        return xDTaraZ.Train.Strength()
    end
    if opt.AutoStrength then return xDTaraZ.Train.Strength() end
    if opt.AutoSpeed then return xDTaraZ.Train.Speed() end
    return false
end

function xDTaraZ.Train.Leave()
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
end

function xDTaraZ.Train.Pool()
    if not xDTaraZ.Game.Completed() then return false end
    local spot = xDTaraZ.Move.PoolSpot()
    if not spot then return false end
    if xDTaraZ.Game.Benching() then xDTaraZ:Invoke(GameLib.StopBench) end
    State.Status = "Training in the pool"
    if not xDTaraZ.Move.Near(spot) then xDTaraZ.Move.To(spot) end
    return true
end

xDTaraZ.Tasks = {}

function xDTaraZ.Tasks.Order()
    local opt = State.Opt
    local order = {}
    if opt.AutoPool then table.insert(order, "Pool") end
    local trainFirst = opt.Priority == "Train"
    if opt.Priority == "Alternate" then
        local slice = math.floor(osClock() / (opt.AlternateMinutes * 60))
        trainFirst = slice % 2 == 1
    end
    if trainFirst then
        order[#order + 1] = "Train"
        order[#order + 1] = "Farm"
    else
        order[#order + 1] = "Farm"
        order[#order + 1] = "Train"
    end
    return order
end

xDTaraZ.Tasks.Jobs = {
    Pool = { On = function() return State.Opt.AutoPool end, Step = xDTaraZ.Train.Pool },
    Farm = { On = function() return State.Opt.AutoFarm end, Step = xDTaraZ.Farm.Step },
    Train = { On = function() return State.Opt.AutoStrength or State.Opt.AutoSpeed end, Step = xDTaraZ.Train.Step },
}

function xDTaraZ.Tasks.Step()
    for _, name in ipairs(xDTaraZ.Tasks.Order()) do
        local job = xDTaraZ.Tasks.Jobs[name]
        if not job.On() then continue end
        if job.Step() then
            State.Task = name
            return
        end
    end
    State.Task = "None"
    State.Status = "Idle"
end

xDTaraZ.Upgrade = {}

---@return table?, number?  cheapest wanted upgrade you can afford above the floor, and its cost
function xDTaraZ.Upgrade.Pick()
    local budget = xDTaraZ.Game.Coins() - State.Opt.KeepCoins
    local pick, pickCost
    for _, name in ipairs(xDTaraZ.UpgradeNames) do
        local upgrade = xDTaraZ.UpgradeByName[name]
        if not State.Opt.Upgrades[name] then continue end
        local cost = upgrade.Costs[xDTaraZ.Game.UpgradeLevel(upgrade) + 1]
        if not cost or cost > budget then continue end
        if State.Opt.UpgradeOrder == "In Order" then return upgrade, cost end
        if not pickCost or cost < pickCost then pick, pickCost = upgrade, cost end
    end
    return pick, pickCost
end

function xDTaraZ.Upgrade.Buy(upgrade, cost)
    local level = xDTaraZ.Game.UpgradeLevel(upgrade) + 1
    local reply = xDTaraZ:Invoke(GameLib.Purchase, upgrade.Id)
    if not (type(reply) == "table" and reply.ok == true) then return false end
    xDTaraZ:Notify(("Bought %s %d"):format(upgrade.DisplayName, level))
    local coins = tonumber(State.Stats.Coins)
    if coins then State.Stats.Coins = tostring(coins - cost) end
    return true
end

function xDTaraZ.Upgrade.Step()
    local upgrade, cost = xDTaraZ.Upgrade.Pick()
    if upgrade then xDTaraZ.Upgrade.Buy(upgrade, cost) end
end

function xDTaraZ.Upgrade.Now()
    local bought = 0
    repeat
        local upgrade, cost = xDTaraZ.Upgrade.Pick()
        if not (upgrade and xDTaraZ.Upgrade.Buy(upgrade, cost)) then break end
        bought += 1
        task.wait(0.3)
    until bought >= 36
    if bought == 0 then xDTaraZ:Notify("Nothing to buy") end
end

xDTaraZ.Codes = {}

function xDTaraZ.Codes.RedeemAll()
    local got = 0
    for _, code in ipairs(xDTaraZ.CodeList) do
        local reply = xDTaraZ:Invoke(GameLib.Redeem, code)
        if type(reply) == "table" and reply.ok then
            got += 1
            xDTaraZ:Notify(code .. ": redeemed")
        else
            xDTaraZ:Notify(("%s: %s"):format(code, type(reply) == "table" and tostring(reply.reason) or "no reply"))
        end
        task.wait(Config.CodeGap)
    end
    xDTaraZ:Notify(("Codes done, %d new"):format(got))
end

xDTaraZ.Teleport = {}

function xDTaraZ.Teleport.Quarry()
    xDTaraZ.Move.To(xDTaraZ.Move.QuarrySpot())
end

function xDTaraZ.Teleport.Pyramid()
    local _, _, hrp = xDTaraZ:Character()
    local from = hrp and hrp.Position or Config.QuarrySpot
    local slot = GameLib.Runtime.resolveNearestSlot(from, Workspace, nil, Config.SlotSearchCells)
    if slot then return xDTaraZ.Move.To(slot.position + vector3New(0, Config.HoverHeight, 0)) end
    local model = xDTaraZ.Game.Model()
    if model then xDTaraZ.Move.To(model:GetPivot().Position + vector3New(0, Config.HoverHeight, 0)) end
end

function xDTaraZ.Teleport.Pool()
    local spot = xDTaraZ.Move.PoolSpot()
    if spot then return xDTaraZ.Move.To(spot, true) end
    xDTaraZ:Notify("Pool is closed right now")
end

function xDTaraZ.Teleport.Gym()
    local folder = State.GymTarget
    local seat = folder and xDTaraZ.Move.GymPart(folder, GameLib.Gym.BenchpressModelName, GameLib.Gym.AlignPartName)
    local belt = folder and xDTaraZ.Move.GymPart(folder, GameLib.Gym.TreadmillModelName, GameLib.Gym.HitboxName)
    local target = seat or belt
    if target then xDTaraZ.Move.To(target.Position + vector3New(0, 3, 0)) end
end

function xDTaraZ.Teleport.Player()
    local target = State.PlayerTarget and Players:FindFirstChild(State.PlayerTarget)
    local root = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if root then return xDTaraZ.Move.To(root.Position + vector3New(0, 3, 0), true) end
    xDTaraZ:Notify("Player not found")
end

xDTaraZ.Server = {}

function xDTaraZ.Server.Rejoin()
    if #Players:GetPlayers() <= 1 then return TeleportService:Teleport(game.PlaceId, LocalPlayer) end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end

function xDTaraZ.Server.Hop()
    local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100"):format(game.PlaceId)
    local body = xDTaraZ.Util.HttpGet(url)
    local ok, page = pcall(HttpService.JSONDecode, HttpService, body or "")
    if not (ok and type(page) == "table" and page.data) then
        xDTaraZ:Notify("Server list unavailable")
        return
    end
    local options = {}
    for _, server in ipairs(page.data) do
        if server.id ~= game.JobId and (server.playing or 0) < (server.maxPlayers or 0) then
            table.insert(options, server.id)
        end
    end
    if #options == 0 then return xDTaraZ:Notify("No other server found") end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, options[math.random(#options)], LocalPlayer)
end

function xDTaraZ.Server.Boost()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e6
    for _, inst in ipairs(Workspace:GetDescendants()) do
        if inst:IsA("ParticleEmitter") or inst:IsA("Trail") or inst:IsA("Smoke") or inst:IsA("Fire") then
            inst.Enabled = false
        elseif inst:IsA("BasePart") and inst.Material ~= Enum.Material.Plastic then
            inst.Material = Enum.Material.SmoothPlastic
        end
    end
    xDTaraZ:Notify("FPS boost applied")
end

xDTaraZ.Client = {}

function xDTaraZ.Client.Bind()
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
        char:WaitForChild("Humanoid", Config.LoadTimeout)
        if State.Collided then table.clear(State.Collided) end
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
    Movement = xDTaraZ.Move.Refresh,
    FarmStop = xDTaraZ.Farm.Stop,
    TrainStop = xDTaraZ.Train.Leave,
    UpgradeNow = xDTaraZ.Upgrade.Now,
    CodesNow = xDTaraZ.Codes.RedeemAll,
    TpQuarry = xDTaraZ.Teleport.Quarry,
    TpPyramid = xDTaraZ.Teleport.Pyramid,
    TpPool = xDTaraZ.Teleport.Pool,
    TpGym = xDTaraZ.Teleport.Gym,
    TpPlayer = xDTaraZ.Teleport.Player,
    Rejoin = xDTaraZ.Server.Rejoin,
    Hop = xDTaraZ.Server.Hop,
    Boost = xDTaraZ.Server.Boost,
}

function xDTaraZ.Scheduler.Run(fn)
    local ok, err = pcall(fn)
    if not ok then warn("[BuildThePyramid]", err) end
end

function xDTaraZ.Scheduler.RunOnce(name, fn)
    if State.Running[name] then return end
    State.Running[name] = true
    task.spawn(function()
        xDTaraZ.Scheduler.Run(fn)
        State.Running[name] = nil
    end)
end

function xDTaraZ.Scheduler.Every(key, interval, fn)
    if osClock() - (State.Last[key] or 0) < interval then return end
    State.Last[key] = osClock()
    xDTaraZ.Scheduler.Run(fn)
end

function xDTaraZ.Scheduler.Summarize()
    local cutoff = osClock() - Config.RateWindow
    local recent = 0
    for i = #State.CoinLog, 1, -1 do
        local entry = State.CoinLog[i]
        if entry[1] < cutoff then table.remove(State.CoinLog, i) else recent += entry[2] end
    end
    local carried, cap = xDTaraZ.Game.Carried(), xDTaraZ.Game.Capacity()
    State.Summary = ("Coins %s · %s/min\nStrength Lv %s · Speed Lv %s · Carry %d/%d\nPyramids %s · Placed %d"):format(
        xDTaraZ.Format(State.Stats.Coins), xDTaraZ.Format(recent * 60 / Config.RateWindow),
        tostring(xDTaraZ.Game.Attr("StrengthLevel") or 0), tostring(xDTaraZ.Game.Attr("SpeedLevel") or 0),
        carried, cap, tostring(xDTaraZ.Game.Attr("Pyramids") or 0), State.Placed)
end

function xDTaraZ.Scheduler.Step()
    local opt = State.Opt
    xDTaraZ.Scheduler.Run(xDTaraZ.Scheduler.Summarize)

    for name, handler in pairs(xDTaraZ.Scheduler.RequestHandlers) do
        if State.Requests[name] then
            State.Requests[name] = nil
            if Config.SlowRequests[name] then
                xDTaraZ.Scheduler.RunOnce(name, handler)
            else
                xDTaraZ.Scheduler.Run(handler)
            end
        end
    end

    if opt.AntiAfk and GameLib.Activity then
        xDTaraZ.Scheduler.Every("Activity", Config.ActivityInterval, function() GameLib.Activity:FireServer() end)
    end
    if opt.AutoUpgrade then xDTaraZ.Scheduler.Every("Upgrade", Config.UpgradeInterval, xDTaraZ.Upgrade.Step) end

    local _, hum = xDTaraZ:Character()
    if not hum then return end
    xDTaraZ.Scheduler.Run(xDTaraZ.Tasks.Step)
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Client.Bind()
    task.defer(function()
        xDTaraZ.Game.WatchStats()
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
    local opt = State.Opt
    opt.SpeedOn, opt.Fly, opt.Noclip = false, false, false
    xDTaraZ.Move.Refresh()
    RunService:Set3dRenderingEnabled(true)
end

local function BuildInterface()
    local Library = loadstring(xDTaraZ.Util.HttpGet(Config.UiSource))()
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt

    local function Notify(text)
        Library:Notify("Build the Pyramid", text, 4)
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

    local function PlayerNames()
        local names = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then names[#names + 1] = plr.Name end
        end
        table.sort(names)
        return names
    end

    local function GymNames()
        local names = {}
        for _, station in ipairs(GameLib.Gym.BenchpressStations) do
            table.insert(names, ("Gym %s (x%d)"):format(station.GymFolder, station.StrengthMultiplier))
        end
        return names
    end

    local function BuildTabs()
        local Window = Library.Window
        Window:AddTabSection(T("Main", "หลัก"))
        local MainTab = Window:AddTab(T("Main", "หลัก"), "house", T("Status and Discord", "สถานะและ Discord"))
        Window:AddTabSection(T("Farming", "ฟาร์ม"))
        local FarmTab = Window:AddTab(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "brick", T("Blocks and coins", "บล็อกและเหรียญ"))
        local GymTab = Window:AddTab(T("Training", "ฝึก"), "heart", T("Strength, speed and the pool", "พลัง ความเร็ว และสระ"))
        Window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local ShopTab = Window:AddTab(T("Upgrades & Codes", "อัปเกรดและโค้ด"), "shop", T("Spend coins and redeem codes", "ใช้เหรียญและใส่โค้ด"))
        Window:AddTabSection(T("Misc", "อื่นๆ"))
        local PlayerTab = Window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and teleports", "การเคลื่อนที่และวาร์ป"))

        local statusBox = MainTab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
        local statusLabel = statusBox:AddLabel(T("Loading...", "กำลังโหลด..."))
        local runLabel = statusBox:AddLabel("-")

        local discordBox = MainTab:AddRightGroupbox(T("Discord", "Discord"), "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            Notify(xDTaraZ.Util.Copy(Config.Discord) and "Discord link copied" or Config.Discord)
        end })

        local farmBox = FarmTab:AddLeftGroupbox(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "brick")
        Toggle(farmBox, "AutoFarm", T("Auto Farm", "ฟาร์มอัตโนมัติ"), T("Grabs blocks and builds the pyramid for coins", "หยิบบล็อกแล้วสร้างพีระมิดเพื่อเหรียญ"), function(on)
            if not on then State.Requests.FarmStop = true end
        end)
        Toggle(farmBox, "ReturnOnStop", T("Return On Stop", "กลับที่เดิมเมื่อหยุด"), T("Goes back to where you started", "กลับไปจุดที่เริ่มฟาร์ม"))

        local orderBox = FarmTab:AddRightGroupbox(T("Farm vs Training", "ฟาร์มกับฝึก"), "sliders-horizontal")
        orderBox:AddDropdown("Priority", {
            Text = T("When Both Are On", "เมื่อเปิดทั้งคู่"),
            Values = { "Farm", "Train", "Alternate" },
            Default = 1,
            Callback = function(value) opt.Priority = value or "Farm" end,
        })
        orderBox:AddSlider("AlternateMinutes", {
            Text = T("Alternate Every (min)", "สลับทุก (นาที)"),
            Min = 1, Max = 30, Default = opt.AlternateMinutes, Rounding = 0,
            Callback = function(value) opt.AlternateMinutes = tonumber(value) or 5 end,
        })

        local gymBox = GymTab:AddLeftGroupbox(T("Gym", "ยิม"), "heart")
        Toggle(gymBox, "AutoStrength", T("Auto Train Strength", "ฝึกพลังอัตโนมัติ"), T("Bench press at your strongest gym", "ยกน้ำหนักที่ยิมแรงสุดที่ใช้ได้"), function(on)
            if not on then State.Requests.TrainStop = true end
        end)
        Toggle(gymBox, "AutoSpeed", T("Auto Train Speed", "ฝึกความเร็วอัตโนมัติ"), T("Runs on your strongest treadmill", "วิ่งบนลู่ที่แรงสุดที่ใช้ได้"))

        local poolBox = GymTab:AddRightGroupbox(T("Waters of Nu", "สระ Waters of Nu"), "pipe")
        Toggle(poolBox, "AutoPool", T("Auto Join Pool", "ลงสระอัตโนมัติ"), T("Trains in the pool when a pyramid is finished", "ฝึกในสระเมื่อพีระมิดสร้างเสร็จ"))

        local upgradeBox = ShopTab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "coin")
        Toggle(upgradeBox, "AutoUpgrade", T("Auto Upgrade", "อัปเกรดอัตโนมัติ"), T("Buys the selected upgrades with coins", "ซื้ออัปเกรดที่เลือกด้วยเหรียญ"))
        upgradeBox:AddDropdown("Upgrades", {
            Text = T("Upgrades", "อัปเกรด"),
            Values = xDTaraZ.UpgradeNames,
            Multi = true,
            Default = {},
            Callback = function(selected) opt.Upgrades = selected or {} end,
        })
        upgradeBox:AddDropdown("UpgradeOrder", {
            Text = T("Order", "ลำดับ"),
            Values = { "Cheapest First", "In Order" },
            Default = 1,
            Callback = function(value) opt.UpgradeOrder = value or "Cheapest First" end,
        })
        upgradeBox:AddSlider("KeepCoins", {
            Text = T("Keep Coins", "กันเหรียญไว้"),
            Min = 0, Max = 1000000, Default = 0, Rounding = 0,
            Callback = function(value) opt.KeepCoins = tonumber(value) or 0 end,
        })
        upgradeBox:AddButton({ Text = T("Buy Now", "ซื้อเดี๋ยวนี้"), Func = Request("UpgradeNow") })

        local codeBox = ShopTab:AddRightGroupbox(T("Codes", "โค้ด"), "code")
        codeBox:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Style = "Primary", Func = Request("CodesNow") })

        local moveBox = PlayerTab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "star")
        Toggle(moveBox, "SpeedOn", T("Speed", "ความเร็ว"), nil, Request("Movement"))
        moveBox:AddSlider("WalkSpeed", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Min = 16, Max = 200, Default = opt.WalkSpeed, Rounding = 0,
            Callback = function(value) opt.WalkSpeed = tonumber(value) or opt.WalkSpeed end,
        })
        Toggle(moveBox, "Fly", T("Fly", "บิน"), nil, Request("Movement"))
        moveBox:AddSlider("FlySpeed", {
            Text = T("Fly Speed", "ความเร็วบิน"),
            Min = 10, Max = 200, Default = opt.FlySpeed, Rounding = 0,
            Callback = function(value) opt.FlySpeed = tonumber(value) or opt.FlySpeed end,
        })
        Toggle(moveBox, "Noclip", T("Noclip", "ทะลุกำแพง"), nil, Request("Movement"))
        Toggle(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))

        local tpBox = PlayerTab:AddRightGroupbox(T("Teleport", "วาร์ป"), "teleport")
        tpBox:AddButton({ Text = T("Quarry", "เหมืองหิน"), Func = Request("TpQuarry") })
        tpBox:AddButton({ Text = T("Pyramid", "พีระมิด"), Func = Request("TpPyramid") })
        tpBox:AddButton({ Text = T("Pool", "สระ"), Func = Request("TpPool") })
        tpBox:AddDropdown("GymTarget", {
            Text = T("Gym", "ยิม"),
            Values = GymNames(),
            Default = 1,
            Callback = function(value) State.GymTarget = value and value:match("^Gym (%S+)") end,
        })
        tpBox:AddButton({ Text = T("Go To Gym", "ไปยิม"), Func = Request("TpGym") })
        local playerDropdown = tpBox:AddDropdown("PlayerTarget", {
            Text = T("Player", "ผู้เล่น"),
            Values = PlayerNames(),
            Searchable = true,
            Callback = function(value) State.PlayerTarget = value end,
        })
        tpBox:AddButton({ Text = T("Refresh Players", "รีเฟรชผู้เล่น"), Func = function() playerDropdown:SetValues(PlayerNames()) end })
        tpBox:AddButton({ Text = T("Go To Player", "ไปหาผู้เล่น"), Func = Request("TpPlayer") })

        local settingsTab = Window:AddSettingsTab()
        local sessionBox = settingsTab:AddLeftGroupbox(T("Session", "เซสชัน"), "gear")
        Toggle(sessionBox, "AntiAfk", T("Anti AFK", "กันหลุด AFK"), T("Stops the idle kick", "กันโดนเตะเพราะไม่ขยับ"))
        Toggle(sessionBox, "AutoRejoin", T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"))
        Toggle(sessionBox, "NoRender", T("Disable 3D Rendering", "ปิดการเรนเดอร์ 3D"), T("Saves battery and CPU while farming", "ประหยัดแบตและ CPU ตอนฟาร์ม"), function(on)
            RunService:Set3dRenderingEnabled(not on)
        end)
        sessionBox:AddButton({ Text = T("FPS Boost", "เพิ่ม FPS"), Func = Request("Boost") })
        sessionBox:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟเดิมใหม่"), Func = Request("Rejoin") })
        sessionBox:AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Func = Request("Hop") })

        Library:Every(1, function()
            while #State.Messages > 0 do
                Notify(table.remove(State.Messages, 1))
            end
            statusLabel:SetText(State.Summary or "-")
            runLabel:SetText(("%s: %s"):format(State.Task, State.Status))
        end)
    end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    getgenv().BuildThePyramidUnload = function()
        Library:Unload()
    end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Build the Pyramid by xDTaraZ",
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

if getgenv().BuildThePyramidUnload then
    pcall(getgenv().BuildThePyramidUnload)
end

BuildInterface()