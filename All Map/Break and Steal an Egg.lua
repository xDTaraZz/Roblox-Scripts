if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765288803 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Break and Steal an Egg only")
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
    if ok and type(renv) == "table" and type(renv.print) == "function" then
        MarioBanner.Print = renv.print
    end
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
        "   BREAK AND STEAL AN EGG  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

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
    LoadTimeout = 30,
    RequireTimeout = 3,
    MaxFailures = 5,
    FailWindow = 10,
    AlertTries = 20,
    AlertDelay = 0.5,
    TickDelay = 0.05,
    TpSettle = 0.2,
    GrabTimeout = 2,
    CarryGrace = 2.5,
    StandRadius = 6,
    SpeedFallback = 120,
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
    Failures = {},
    Halted = {},
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
        AutoUpgrade = false,
        UpgradeTargets = { Pickaxe = true, Base = true, Trail = true, Treadmill = true },
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
        WalkSpeed = xDTaraZ.Config.SpeedFallback,
        InfJump = false,
        Noclip = false,
        AntiAfk = false,
        AutoRejoin = false,
    },
}

local Config, State = xDTaraZ.Config, xDTaraZ.State
local Shared = ReplicatedStorage:WaitForChild("Shared", Config.LoadTimeout)

xDTaraZ.GameLib = {
    Remote = setmetatable({}, {
        __index = function(self, name)
            local remote = ReplicatedStorage:FindFirstChild(name)
            if not remote then
                local nested = ReplicatedStorage:FindFirstChild(name, true)
                remote = nested and (nested:IsA("BaseRemoteEvent") or nested:IsA("RemoteFunction")) and nested or nil
            end
            if remote then rawset(self, name, remote) end
            return remote
        end,
    }),
}

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
    local deadline = osClock() + Config.RequireTimeout
    while not done and osClock() < deadline do
        task.wait()
    end
    return ok, loaded
end

---@param name string  module under ReplicatedStorage.Shared
---@return table?      nil when it is missing or this executor can't require it
function xDTaraZ.GameLib.Require(name)
    local module = Shared and Shared:FindFirstChild(name)
    if not module then
        local nested = Shared and Shared:FindFirstChild(name, true)
        module = nested and nested:IsA("ModuleScript") and nested or nil
    end
    if not module then
        warn("[BreakStealEgg] missing game module", name)
        return nil
    end
    local ok, loaded = pcall(require, module)
    if ok then return loaded end
    local okAgain, again = xDTaraZ.GameLib.RequireAsGame(module)
    if okAgain then return again end
    warn("[BreakStealEgg] require", name, loaded)
    return nil
end

local GameLib = xDTaraZ.GameLib

do
    local modules = {
        Eggs = "EggConfig", Rewards = "EggRewards", Rarity = "EggRarity", Pickaxe = "PickaxeConfig", Zones = "ZonesConfig",
        Plot = "PlotUpgradeConfig", Treadmill = "TreadmillUpgradeConfig", Trails = "TrailsConfig", Bat = "BatConfig", Speed = "SpeedConfig",
    }
    for key, name in pairs(modules) do
        GameLib[key] = GameLib.Require(name)
    end
    State.Opt.WalkSpeed = GameLib.Speed and GameLib.Speed.MaxWalkSpeed or Config.SpeedFallback
end

GameLib.Needs = {
    AutoSteal = { "Rewards" },
    AutoBreak = { "Pickaxe", "Eggs", "Rewards", "Remote.EggHitRequest" },
    RobCarriers = { "Bat", "Remote.BatHitRequest" },
    AutoPlace = { "Remote.PetsInventoryRemote" },
    AutoSell = { "Rewards", "Remote.BackpackSellRemote" },
    AutoClaim = { "Remote.IndexRemote", "Remote.OfflineRewardRemote" },
    AutoHatch = { "Remote.MergeMachineRemote" },
    AutoBuyPickaxe = { "Pickaxe" },
    AutoUpgradePlot = { "Plot" },
    AutoTrail = { "Trails" },
    AutoTreadmill = { "Treadmill" },
    SpeedOn = { "Speed" },
    EspEggs = { "Pickaxe" },
    BatLoop = { "Bat", "Remote.BatHitRequest" },
    BatAura = { "Bat", "Remote.BatHitRequest" },
}

---@return string?  first module ("Rewards") or remote ("Remote.EggHitRequest") the feature needs that is gone
function GameLib.Missing(idx)
    for _, key in ipairs(GameLib.Needs[idx] or {}) do
        local node = GameLib
        for part in key:gmatch("[^.]+") do
            node = type(node) == "table" and node[part] or nil
        end
        if node == nil then return key end
    end
    return nil
end

xDTaraZ.RarityLadder = GameLib.Rarity and GameLib.Rarity.Ladder() or {}
xDTaraZ.RarityRank = {}
do
    for i, name in ipairs(xDTaraZ.RarityLadder) do
        xDTaraZ.RarityRank[name] = i
    end
end

xDTaraZ.ZoneList = {}
do
    for index, zone in pairs(GameLib.Zones and GameLib.Zones.Zones or {}) do
        table.insert(xDTaraZ.ZoneList, { Index = index, Name = zone.Name or ("Zone" .. index), Rarity = zone.Rarity, Power = zone.RequiredPower or 0 })
    end
    table.sort(xDTaraZ.ZoneList, function(a, b) return a.Index < b.Index end)
end

xDTaraZ.ZonePool = {}
do
    for _, entry in ipairs(GameLib.Rewards and GameLib.Rewards.Pool or {}) do
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

xDTaraZ.Util = {}

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

---Shows a Roblox notification even when the menu never loaded; SetCore fails for a while after joining.
function xDTaraZ.Util.Alert(text, detail)
    warn("[BreakStealEgg] menu:", text, detail or "")
    task.spawn(function()
        for _ = 1, Config.AlertTries do
            if pcall(StarterGui.SetCore, StarterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 }) then return end
            task.wait(Config.AlertDelay)
        end
    end)
end

---@return boolean, any  pcall result, warns with the label when it fails
function xDTaraZ.Util.Try(label, fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[BreakStealEgg] " .. label .. ":", err) end
    return ok, err
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
    if ok and type(library) == "table" then return library end
    xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(library))
    return nil
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

---@return number  speed the game itself gives the player now, never lower than what SpeedPower earns
function xDTaraZ.Move.NaturalSpeed()
    local earned = GameLib.Speed and GameLib.Speed.SpeedPowerToWalkSpeed(xDTaraZ.Attr("SpeedPower", 0)) or 0
    return math.max(State.NaturalSpeed or 0, earned)
end

function xDTaraZ.Move.ApplySpeed()
    local _, hum = xDTaraZ:Character()
    if not hum then return end
    if State.Opt.SpeedOn then
        if not State.SpeedWritten then State.NaturalSpeed = hum.WalkSpeed end
        State.SpeedWritten = math.max(State.Opt.WalkSpeed, xDTaraZ.Move.NaturalSpeed())
        hum.WalkSpeed = State.SpeedWritten
    elseif State.SpeedWritten then
        State.SpeedWritten = nil
        hum.WalkSpeed = xDTaraZ.Move.NaturalSpeed()
    end
end

function xDTaraZ.Move.HoldSpeed(hum)
    if State.SpeedConn then State.SpeedConn:Disconnect() end
    State.SpeedWritten = nil
    State.SpeedConn = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if hum.WalkSpeed == State.SpeedWritten then return end
        State.NaturalSpeed = hum.WalkSpeed
        if State.Opt.SpeedOn then xDTaraZ.Move.ApplySpeed() end
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
    if not plot then return nil end
    local cached = State.Hitbox
    if cached and cached[1] == plot and cached[2]:IsDescendantOf(plot) then return cached[2] end

    local hitbox = plot:FindFirstChild("Hitbox", true)
    State.Hitbox = hitbox and { plot, hitbox } or nil
    return hitbox
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
    if xDTaraZ.Compat and xDTaraZ.Compat.Caps.Prompt then
        fireproximityprompt(prompt)
        return
    end
    prompt:InputHoldBegin()
    task.wait(prompt.HoldDuration)
    prompt:InputHoldEnd()
end

---@return number  animals the other players carry right now
function xDTaraZ.Pickup.OthersCarrying()
    local total = 0
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then total += player:GetAttribute("CarryCount") or 0 end
    end
    return total
end

---@param before number  CarryCount read before the prompt fired
---@param others number  OthersCarrying read before the prompt fired
---@return boolean       true once the satchel shows the animal; a pickup that vanished without it keeps waiting for the count unless another player picked it up
function xDTaraZ.Pickup.AwaitCarry(model, before, others)
    local fired = osClock()
    local goneAt
    repeat
        task.wait()
        if xDTaraZ.Base.Carry() > before then return true end
        if not model.Parent then
            goneAt = goneAt or osClock()
            if xDTaraZ.Pickup.OthersCarrying() > others then return false end
        end
    until osClock() > (goneAt and goneAt + Config.CarryGrace or fired + Config.GrabTimeout)
    return false
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
    local others = xDTaraZ.Pickup.OthersCarrying()
    xDTaraZ.Pickup.Trigger(prompt)
    local got = xDTaraZ.Pickup.AwaitCarry(model, before, others)
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

---Once every farm toggle is off: banks what is carried or walks back to where the farm picked the character up, then shows Idle.
function xDTaraZ.Farm.Stand()
    local origin = State.FarmOrigin
    if not origin then return end
    State.FarmOrigin = nil
    State.BreakSpot = nil
    local _, _, hrp = xDTaraZ:Character()
    if hrp and not (xDTaraZ.Base.Carry() > 0 and xDTaraZ.Base.Bank()) and (hrp.Position - origin.Position).Magnitude > Config.StandRadius then
        xDTaraZ.Move.To(origin)
    end
    State.Status = "Idle"
end

function xDTaraZ.Farm.Rest()
    local opt = State.Opt
    if not (opt.AutoSteal or opt.AutoBreak or opt.RobCarriers) then State.Status = "Idle" end
end

function xDTaraZ.Farm.Step()
    local opt = State.Opt
    if not (opt.AutoSteal or opt.AutoBreak or opt.RobCarriers) then
        xDTaraZ.Farm.Stand()
        return
    end
    local _, _, hrp = xDTaraZ:Character()
    if not hrp then
        State.Status = "Waiting for respawn"
        return
    end
    State.FarmOrigin = State.FarmOrigin or hrp.CFrame

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

---Dropdown entry -> the flag Shop.Step reads; order = menu order.
xDTaraZ.Shop.Targets = {
    { Key = "Pickaxe", Flag = "AutoBuyPickaxe" },
    { Key = "Base", Flag = "AutoUpgradePlot" },
    { Key = "Trail", Flag = "AutoTrail" },
    { Key = "Treadmill", Flag = "AutoTreadmill" },
}

---Turns the Auto Upgrade toggle + target dropdown into the per-shop flags; targets whose game module is missing stay off.
function xDTaraZ.Shop.Sync()
    local opt = State.Opt
    for _, target in ipairs(xDTaraZ.Shop.Targets) do
        opt[target.Flag] = opt.AutoUpgrade and opt.UpgradeTargets[target.Key] == true and not GameLib.Missing(target.Flag)
    end
end

---One pass over the picked targets, cheapest win first like Shop.Step; nil when nothing was affordable.
function xDTaraZ.Shop.Now()
    local picked = State.Opt.UpgradeTargets
    local bought = false
    if picked.Base and not GameLib.Missing("AutoUpgradePlot") and xDTaraZ.Shop.Plot() then bought = true end
    if picked.Pickaxe and not GameLib.Missing("AutoBuyPickaxe") and xDTaraZ.Shop.Pickaxe() then bought = true end
    if picked.Trail and not GameLib.Missing("AutoTrail") and xDTaraZ.Shop.Trail() then bought = true end
    if picked.Treadmill and not GameLib.Missing("AutoTreadmill") and xDTaraZ.Shop.Treadmill() then bought = true end
    if not bought then xDTaraZ:Notify("Nothing to upgrade yet: not enough cash or already maxed") end
end

function xDTaraZ.Shop.Step()
    local opt = State.Opt
    local plot = xDTaraZ.Base.Own()
    local plotCost = plot and GameLib.Plot and GameLib.Plot.UpgradeCost(plot:GetAttribute("PlotLevel") or 1) or math.huge
    local pickTier = xDTaraZ.Attr("PickaxeTier", 1)
    local pickaxes = GameLib.Pickaxe
    local pickCost = pickaxes and pickTier < #pickaxes.Tiers and pickaxes.GetPrice(pickTier + 1) or math.huge
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
    if name == "My Base" then
        xDTaraZ.Base.Home()
        return
    end
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
    if not ok then folder.Parent = LocalPlayer:WaitForChild("PlayerGui", Config.LoadTimeout) end
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
    Speed = xDTaraZ.Move.ApplySpeed,
    Place = xDTaraZ.Pets.Place,
    SellNow = function() xDTaraZ:Notify(("Sold %d animals"):format(xDTaraZ.Pets.Sell())) end,
    UpgradeNow = xDTaraZ.Shop.Now,
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
        xDTaraZ.Farm.Rest()
    end,
    BankNow = function()
        xDTaraZ.Base.Bank()
        xDTaraZ.Farm.Rest()
    end,
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
            xDTaraZ.Scheduler.Run(name, handler)
        end
    end
end

---Runs one round of a job, warning once per failure streak; toggles that keep failing for Config.FailWindow seconds are switched off and queued for the UI to report.
---@param key string|string[]  State.Opt flag(s) of the feature, or a plain label for jobs without one
function xDTaraZ.Scheduler.Run(key, fn)
    local ok, err = pcall(fn)
    local label = type(key) == "table" and key[1] or key
    local failures = State.Failures
    if ok then
        failures[label] = nil
        return
    end

    local streak = failures[label]
    if not streak then
        streak = { count = 0, since = osClock() }
        failures[label] = streak
        warn("[BreakStealEgg]", label, err)
    end
    streak.count += 1
    if streak.count < Config.MaxFailures or osClock() - streak.since < Config.FailWindow then return end

    local reason = tostring(err):match("[^\n]*")
    for _, flag in ipairs(type(key) == "table" and key or { key }) do
        if State.Opt[flag] ~= true then continue end
        failures[label] = nil
        State.Opt[flag] = false
        warn("[BreakStealEgg]", flag, "stopped:", reason)
        table.insert(State.Halted, { flag, reason })
    end
end

---@param stamp string  State.Last field holding the last run time
---@param key string|string[]  passed on to Run
function xDTaraZ.Scheduler.Every(stamp, key, interval, fn)
    if osClock() - (State.Last[stamp] or 0) < interval then return end
    State.Last[stamp] = osClock()
    xDTaraZ.Scheduler.Run(key, fn)
end

xDTaraZ.Scheduler.ShopFlags = { "AutoUpgrade" }
xDTaraZ.Scheduler.EspFlags = { "EspPickups", "EspEggs", "EspPlayers" }
xDTaraZ.Scheduler.FarmFlags = { "AutoSteal", "AutoBreak", "RobCarriers" }

function xDTaraZ.Scheduler.Summarize()
    local cash = xDTaraZ.Attr("Cash", 0)
    State.StartCash = State.StartCash or cash
    local plot = xDTaraZ.Base.Own()
    local minutes = math.max((osClock() - State.StartAt) / 60, 1 / 60)
    local carry, cap = xDTaraZ.Base.Carry()
    local tier = xDTaraZ.Attr("PickaxeTier", 1)
    local pickaxe = GameLib.Pickaxe and GameLib.Pickaxe.Tiers[tier]
    State.Summary = ("Cash %s · %s/s\n%s (%s dmg) · Carry %d/%d\nBase %s/%s animals · Level %s"):format(
        xDTaraZ.Format(cash), xDTaraZ.Format(xDTaraZ.Attr("CashPerSecond", 0)),
        pickaxe and pickaxe.Name or "-", pickaxe and xDTaraZ.Format(xDTaraZ.Break.Damage()) or "-", carry, cap,
        tostring(plot and plot:GetAttribute("AnimalsPlaced") or "-"), tostring(plot and plot:GetAttribute("MaxAnimals") or "-"),
        tostring(plot and plot:GetAttribute("PlotLevel") or "-"))
    State.RunText = ("%s\nSteals %d · Eggs %d · Banked %d · +%s/min"):format(
        State.Status, State.Steals, State.Broken, State.Banked, xDTaraZ.Format((cash - State.StartCash) / minutes))
end

function xDTaraZ.Scheduler.Side()
    local opt = State.Opt
    xDTaraZ.Scheduler.Every("Summary", "Summary", 0.5, xDTaraZ.Scheduler.Summarize)
    xDTaraZ.Scheduler.Drain(xDTaraZ.Scheduler.RequestHandlers)
    if opt.AutoPlace then xDTaraZ.Scheduler.Every("Place", "AutoPlace", Config.EquipInterval, xDTaraZ.Pets.Place) end
    if opt.AutoSell then xDTaraZ.Scheduler.Every("Sell", "AutoSell", Config.SellInterval, xDTaraZ.Pets.Sell) end
    if opt.AutoBuyPickaxe or opt.AutoUpgradePlot or opt.AutoTrail or opt.AutoTreadmill then xDTaraZ.Scheduler.Every("Shop", xDTaraZ.Scheduler.ShopFlags, Config.BuyInterval, xDTaraZ.Shop.Step) end
    if opt.AutoClaim then xDTaraZ.Scheduler.Every("Claim", "AutoClaim", Config.ClaimInterval, xDTaraZ.Rewards.Claim) end
    if opt.EspPickups or opt.EspEggs or opt.EspPlayers then
        xDTaraZ.Scheduler.Every("Esp", xDTaraZ.Scheduler.EspFlags, Config.EspInterval, xDTaraZ.Esp.Step)
    elseif next(xDTaraZ.Esp.Tags) then
        xDTaraZ.Esp.Clear()
    end
end

function xDTaraZ.Scheduler.Control()
    local opt = State.Opt
    xDTaraZ.Scheduler.Drain(xDTaraZ.Scheduler.MoveHandlers)
    if opt.BatLoop and opt.BatTarget then
        xDTaraZ.Scheduler.Run("BatLoop", function() xDTaraZ.Bat.Swing(Players:FindFirstChild(opt.BatTarget), true) end)
        return
    end
    if opt.BatAura then xDTaraZ.Scheduler.Run("BatAura", xDTaraZ.Bat.Aura) end
    if opt.AutoHatch then xDTaraZ.Scheduler.Every("Eggs", "AutoHatch", Config.EggInterval, xDTaraZ.Eggs.Step) end
    xDTaraZ.Scheduler.Run(xDTaraZ.Scheduler.FarmFlags, xDTaraZ.Farm.Step)
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Session.Bind()
    xDTaraZ.Scheduler.Run("Watch", xDTaraZ.Rewards.Watch)
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
    local Library = xDTaraZ.Util.LoadLibrary()
    if not Library then return end
    xDTaraZ.Compat = Library.Compat
    pcall(MarioBanner.Step, "UI library")
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt
    local names = {}

    local function Notify(text, kind)
        Library:Notify("Break and Steal an Egg", text, 4, kind or "Info")
    end

    local function Request(name)
        return function() State.Requests[name] = true end
    end

    local function Toggle(group, key, info, onChange)
        names[key] = info.Text
        info.Default = false
        info.Callback = function(value)
            opt[key] = value
            if onChange then onChange(value) end
        end
        return group:AddToggle(key, info)
    end

    ---@return table  toggle with an unbound key saved as <key>Key
    local function Feature(group, key, info, onChange)
        return Toggle(group, key, info, onChange):AddKeyPicker(key .. "Key", { Default = "None", Mode = "Toggle" })
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
        local list = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then list[#list + 1] = player.Name end
        end
        table.sort(list)
        return list
    end

    ---@return table  { Summary, Run } labels the pump refreshes
    local function BuildMain(window)
        window:AddTabSection(T("Main", "หลัก"))
        local tab = window:AddTab(T("Main", "หลัก"), "house", T("Status and all-in-one mode", "สถานะและโหมดทำทุกอย่าง"))

        local statusBox = tab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
        local labels = {
            Summary = statusBox:AddLabel(T("Loading...", "กำลังโหลด...")),
            Run = statusBox:AddLabel("-"),
        }

        local kaitunBox = tab:AddRightGroupbox(T("Kaitun", "ไก่ตัน"), "oneup")
        kaitunBox:AddToggle("Kaitun", {
            Text = T("Kaitun (All-in-one)", "ไก่ตัน (ทำทุกอย่าง)"),
            Description = T("Steals, breaks eggs, places, sells, upgrades and claims rewards by itself", "ขโมย ทุบไข่ วางสัตว์ ขาย อัปเกรด และรับรางวัลให้เองทั้งหมด"),
            NoSave = true,
            Callback = function(value)
                State.KaitunSet = State.KaitunSet or {}
                for _, key in ipairs({ "AutoSteal", "AutoBreak", "AutoPlace", "AutoSell", "AutoUpgrade", "AutoClaim", "AutoHatch", "AntiAfk" }) do
                    if value and not opt[key] then
                        State.KaitunSet[key] = true
                        Options[key]:SetValue(true)
                    elseif not value and State.KaitunSet[key] then
                        State.KaitunSet[key] = nil
                        Options[key]:SetValue(false)
                    end
                end
            end,
        }):AddKeyPicker("KaitunKey", { Default = "None", Mode = "Toggle" })

        local discordBox = tab:AddRightGroupbox(T("Discord", "Discord"), "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            local copy = setclipboard or toclipboard
            if copy then copy(Config.Discord) end
            Notify(copy and "Discord link copied" or Config.Discord)
        end })

        return labels
    end

    local function BuildFarm(window)
        window:AddTabSection(T("Farming", "ฟาร์ม"))
        local tab = window:AddTab(T("Steal & Break", "ขโมยและทุบไข่"), "star", T("Steal animals and break eggs", "ขโมยสัตว์และทุบไข่"))

        local stealBox = tab:AddLeftGroupbox(T("Auto Steal", "ขโมยอัตโนมัติ"), "star")
        Feature(stealBox, "AutoSteal", { Text = T("Auto Steal", "ขโมยอัตโนมัติ"), Description = T("Grabs the most valuable animals on the map and brings them home instantly", "คว้าสัตว์ที่มีค่าที่สุดบนแมพแล้วพากลับฐานทันที") })
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
        stealBox:AddButton({ Text = T("Steal Best Now", "ขโมยตัวดีสุดเดี๋ยวนี้"), Style = "Primary", Func = Request("StealNow") })
        stealBox:AddButton({ Text = T("Bank Now", "เก็บเข้าฐานเดี๋ยวนี้"), Func = Request("BankNow") })

        local breakBox = tab:AddRightGroupbox(T("Auto Break", "ทุบไข่อัตโนมัติ"), "qblock")
        Feature(breakBox, "AutoBreak", { Text = T("Auto Break Eggs", "ทุบไข่อัตโนมัติ"), Description = T("Breaks eggs in any zone at max speed and takes the animal home", "ทุบไข่ได้ทุกโซนด้วยความเร็วสูงสุดแล้วพาสัตว์กลับฐาน") })
        local zoneChoices = { "Best" }
        for _, name in ipairs(xDTaraZ.Teleport.Zones()) do table.insert(zoneChoices, name) end
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

        local robBox = tab:AddRightGroupbox(T("Rob Players", "ปล้นผู้เล่น"), "swords")
        Toggle(robBox, "RobCarriers", { Text = T("Rob Carriers", "ปล้นคนที่แบกสัตว์"), Description = T("Bats players carrying animals and takes what they drop", "ตีผู้เล่นที่แบกสัตว์แล้วเก็บของที่หล่น"), Risky = true })
    end

    local function BuildBase(window)
        window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local tab = window:AddTab(T("Base & Shop", "ฐานและร้านค้า"), "shop", T("Placing, selling, upgrades and rewards", "วางสัตว์ ขาย อัปเกรด และรางวัล"))

        local placeBox = tab:AddLeftGroupbox(T("Animals", "สัตว์"), "mushroom")
        Feature(placeBox, "AutoPlace", { Text = T("Auto Place Best", "วางตัวดีสุดอัตโนมัติ"), Description = T("Keeps the best earners standing on your base", "วางตัวที่ทำเงินดีสุดไว้บนฐานตลอด") })
        placeBox:AddButton({ Text = T("Place Best Now", "วางตัวดีสุดเดี๋ยวนี้"), Func = Request("Place") })

        local sellBox = tab:AddLeftGroupbox(T("Sell", "ขาย"), "coin")
        Feature(sellBox, "AutoSell", { Text = T("Auto Sell Leftovers", "ขายตัวที่เหลืออัตโนมัติ"), Description = T("Sells animals in your backpack that did not fit on the base", "ขายสัตว์ในกระเป๋าที่ไม่ได้วางบนฐาน") })
        sellBox:AddDropdown("KeepRarities", {
            Text = T("Never Sell", "ไม่ขาย"),
            Values = xDTaraZ.RarityLadder,
            Multi = true,
            Default = {},
            Callback = function(selected) opt.KeepRarities = ToSet(selected) end,
        })
        sellBox:AddButton({ Text = T("Sell All Now", "ขายทั้งหมดเดี๋ยวนี้"), Func = Request("SellNow") })

        local shopBox = tab:AddRightGroupbox(T("Upgrades", "อัปเกรด"), "coin")
        Feature(shopBox, "AutoUpgrade", { Text = T("Auto Upgrade", "อัปเกรดอัตโนมัติ"), Description = T("Buys the picked upgrades as soon as you can pay", "ซื้ออัปเกรดที่เลือกทันทีที่เงินพอ") }, xDTaraZ.Shop.Sync)
        shopBox:AddDropdown("UpgradeTargets", {
            Text = T("Upgrade", "อัปเกรด"),
            Description = T("Pickaxe jumps to the best you can afford, Trail buys and wears the strongest", "Pickaxe ข้ามไปตัวดีสุดที่ซื้อไหว Trail ซื้อและใส่ตัวแรงสุด"),
            Values = { "Pickaxe", "Base", "Trail", "Treadmill" },
            Multi = true,
            Default = { "Pickaxe", "Base", "Trail", "Treadmill" },
            Callback = function(selected)
                opt.UpgradeTargets = ToSet(selected)
                xDTaraZ.Shop.Sync()
            end,
        })
        shopBox:AddButton({ Text = T("Upgrade Now", "อัปเกรดเดี๋ยวนี้"), Func = Request("UpgradeNow") })
        shopBox:AddInput("CashReserve", {
            Text = T("Keep Cash", "กันเงินไว้"),
            Description = T("Upgrades never spend below this", "อัปเกรดจะไม่ใช้เงินต่ำกว่านี้"),
            Placeholder = "0",
            Numeric = true,
            Callback = function(value) opt.CashReserve = tonumber(value) or 0 end,
        })

        local hatchBox = tab:AddLeftGroupbox(T("Eggs", "ไข่"), "mushroom")
        Feature(hatchBox, "AutoHatch", { Text = T("Auto Hatch Eggs", "ฟักไข่อัตโนมัติ"), Description = T("Places eggs from your backpack on your base and hatches them when ready", "วางไข่ในกระเป๋าบนฐานแล้วฟักเมื่อพร้อม") })
        hatchBox:AddButton({ Text = T("Hatch Eggs Now", "ฟักไข่เดี๋ยวนี้"), Func = Request("HatchNow") })

        local rewardBox = tab:AddRightGroupbox(T("Rewards", "รางวัล"), "star")
        Feature(rewardBox, "AutoClaim", { Text = T("Auto Claim", "รับรางวัลอัตโนมัติ"), Description = T("Claims index, offline, group and community rewards, no joining needed", "รับรางวัล Index ออฟไลน์ กลุ่ม และคอมมูนิตี้ ไม่ต้องเข้ากลุ่ม") })
        rewardBox:AddButton({ Text = T("Claim Now", "รับเดี๋ยวนี้"), Func = Request("ClaimNow") })
    end

    local function BuildPlayer(window)
        local tab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and teleports", "การเคลื่อนที่และวาร์ป"))

        local moveBox = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "star")
        Feature(moveBox, "SpeedOn", { Text = T("Speed", "ความเร็ว") }, Request("Speed"))
        moveBox:AddSlider("WalkSpeed", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Min = 16, Max = 300, Default = opt.WalkSpeed, Rounding = 0,
            Callback = function(value)
                opt.WalkSpeed = tonumber(value) or opt.WalkSpeed
                if opt.SpeedOn then State.Requests.Speed = true end
            end,
        })
        Feature(moveBox, "InfJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด") })
        Feature(moveBox, "Noclip", { Text = T("Noclip", "ทะลุกำแพง") }, function(on) if not on then xDTaraZ.Move.SetNoclip(false) end end)

        local tpBox = tab:AddRightGroupbox(T("Teleport", "วาร์ป"), "teleport")
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
    end

    local function BuildVisuals(window)
        local tab = window:AddTab(T("Visuals", "มองเห็น"), "eye", T("See animals, eggs and players", "มองเห็นสัตว์ ไข่ และผู้เล่น"))
        local espBox = tab:AddLeftGroupbox(T("ESP", "ESP"), "eye")
        Toggle(espBox, "EspPickups", { Text = T("Animals", "สัตว์"), Description = T("Name, rarity, weight and cash per second", "ชื่อ rarity น้ำหนัก และเงินต่อวิ") })
        espBox:AddDropdown("EspMinRarity", {
            Text = T("Min Rarity", "rarity ขั้นต่ำ"),
            Values = xDTaraZ.RarityLadder,
            Default = 1,
            Callback = function(value) opt.EspMinRarity = value or "Common" end,
        })

        local worldEspBox = tab:AddRightGroupbox(T("Eggs & Players", "ไข่และผู้เล่น"), "eye")
        Toggle(worldEspBox, "EspEggs", { Text = T("Eggs", "ไข่"), Description = T("HP and how many hits it takes", "HP และจำนวนครั้งที่ต้องตี") })
        Toggle(worldEspBox, "EspPlayers", { Text = T("Players", "ผู้เล่น"), Description = T("Distance and what they carry", "ระยะและสิ่งที่แบกอยู่") })
    end

    local function BuildTroll(window)
        local tab = window:AddTab(T("Troll", "ป่วน"), "troll", T("Bat other players", "ตีผู้เล่นอื่น"))
        local batBox = tab:AddLeftGroupbox(T("Bat", "ไม้ตี"), "swords")
        local batTarget = batBox:AddDropdown("BatTarget", {
            AllowNull = true,
            Text = T("Target", "เป้าหมาย"),
            Values = PlayerNames(),
            Searchable = true,
            NoSave = true,
            Callback = function(value) opt.BatTarget = value end,
        })
        batBox:AddButton({ Text = T("Refresh Players", "รีเฟรชผู้เล่น"), Func = function() batTarget:SetValues(PlayerNames()) end })
        Feature(batBox, "BatLoop", { Text = T("Loop Bat Target", "ตีเป้าหมายวนไป"), Description = T("Follows the target and keeps knocking them over", "ตามเป้าหมายแล้วตีล้มไม่หยุด"), Risky = true })
        batBox:AddButton({ Text = T("Bat Target Now", "ตีเป้าหมายเดี๋ยวนี้"), Func = Request("BatNow") })

        local auraBox = tab:AddRightGroupbox(T("Bat Aura", "ออร่าไม้ตี"), "swords")
        Feature(auraBox, "BatAura", { Text = T("Bat Aura", "ออร่าไม้ตี"), Description = T("Knocks over anyone who gets close", "ตีล้มทุกคนที่เข้าใกล้"), Risky = true })
    end

    local function BuildSettings(window)
        local tab = window:AddSettingsTab()
        local sessionBox = tab:AddRightGroupbox(T("Session", "เซสชัน"), "gear")
        Toggle(sessionBox, "AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK"), Description = T("Stops the idle kick", "กันโดนเตะเพราะไม่ขยับ") })
        Toggle(sessionBox, "AutoRejoin", { Text = T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), Description = T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง") })
        sessionBox:AddButton({ Text = T("Rejoin Now", "เข้าเกมใหม่เดี๋ยวนี้"), Func = xDTaraZ.Session.Rejoin })
    end

    local function ReportHalts()
        for _, halt in ipairs(State.Halted) do
            local flag, reason = halt[1], halt[2]
            local toggle = Options[flag]
            if toggle and toggle.Value then toggle:SetValue(false) end
            Notify(("%s stopped: %s"):format(names[flag] and names[flag].EN or flag, reason), "Warning")
        end
        table.clear(State.Halted)
    end

    ---@return number  features blocked because a game module did not load
    local function GateModules()
        local gated = 0
        for idx in pairs(GameLib.Needs) do
            local missing = GameLib.Missing(idx)
            if not (missing and Options[idx]) then continue end
            warn("[BreakStealEgg] " .. idx .. " disabled, missing: " .. missing)
            local reason = missing:find("^Remote%.") and T("Not available after a game update", "ใช้ไม่ได้หลังเกมอัปเดต")
                or T("Not available on this executor", "ใช้กับ executor นี้ไม่ได้")
            if Library.Compat then
                Library.Compat.Block(idx, reason)
            else
                local toggle = Options[idx]
                toggle:OnChanged(function(on)
                    if not on then return end
                    toggle:SetValue(false)
                    Notify(reason.EN or "Not available on this executor", "Warning")
                end)
            end
            gated += 1
        end
        return gated
    end

    local function BuildTabs()
        local window = Library.Window
        local try = xDTaraZ.Util.Try
        local _, labels = try("ui main", BuildMain, window)
        try("ui farm", BuildFarm, window)
        try("ui base", BuildBase, window)

        window:AddTabSection(T("Misc", "อื่นๆ"))
        for _, build in ipairs({ BuildPlayer, BuildVisuals, BuildTroll, BuildSettings }) do
            try("ui misc", build, window)
        end

        local _, gated = try("ui gate", GateModules)
        if type(gated) == "number" and gated > 0 then
            Library:Notify("Break and Steal an Egg", "Some features can't find the game parts they need and are turned off.", 8, "Warning")
        end

        Library:Every(0.5, function()
            ReportHalts()
            while #State.Messages > 0 do
                Notify(table.remove(State.Messages, 1))
            end
            if type(labels) ~= "table" then return end
            labels.Summary:SetText(State.Summary or "-")
            labels.Run:SetText(State.RunText or State.Status)
        end)
    end

    local function Unload()
        Library:Unload()
    end
    Library:OnUnload(function()
        xDTaraZ.Scheduler.Stop()
        if getgenv().BreakStealEggUnload == Unload then getgenv().BreakStealEggUnload = nil end
    end)
    getgenv().BreakStealEggUnload = Unload

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Break and Steal an Egg by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            xDTaraZ.Util.Try("build", BuildTabs)
            if xDTaraZ.Util.Try("boot", xDTaraZ.Scheduler.Boot) then Notify("Loaded", "Success") end
            xDTaraZ.Util.Try("autoload", Library.LoadAutoloadConfig, Library)
        end,
    })
end

if getgenv().BreakStealEggUnload then
    pcall(getgenv().BreakStealEggUnload)
end

pcall(MarioBanner.Step, "Systems")
BuildInterface()
pcall(MarioBanner.Step, "Interface")
pcall(MarioBanner.Ready)