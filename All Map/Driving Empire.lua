if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 1202096104 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub : this script is for Driving Empire only")
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
        "   DRIVING EMPIRE  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})
local Modules = ReplicatedStorage.Modules
local RemoteFolder = ReplicatedStorage.Remotes
local Remotes = require(Modules.Shared.Remotes)
local Data = require(Modules.Shared.Data)
local JobsController = require(Modules.Client.Jobs.JobsController)
local VehicleController = require(Modules.Client.Vehicles.VehicleController)
local TeleportGuard = require(Modules.Client.Exploit.VehicleTeleportDetectionController)
local PlayRewardUtil = require(Modules.Shared.PlayRewards.PlayRewardUtil)

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui_v2.lua",
    SaveFolder = "Driving Empire",
    SpawnerCacheFile = "Driving Empire/atm_spawners.json",
    TickDelay = 0.5,
    BustWait = 2.6,
    DebounceTimeout = 6,
    StreamWait = 0.5,
    SweepStep = 800,
    SweepHeight = 400,
    SweepDelay = 0.35,
    SweepMin = Vector3.new(-3500, 0, -6500),
    SweepMax = Vector3.new(7500, 0, 5000),
    CashOutCrimes = 5,
    CashOutWait = 12,
    DropOffApproach = 80,
    WantedSafety = 25,
    CopAvoidRadius = 45,
    RewardInterval = 60,
    EspInterval = 1,
    HopDelay = 4,
    DriveCenter = Vector3.new(-2053, 22, 235),
    DriveRadius = 150,
    DriveSpeed = 150,
    DropOffSeeds = {
        Vector3.new(-2543.3, 11.9, 4030.3),
        Vector3.new(7322.1, 197.8, -2811.6),
    },
    PlaceSeeds = {
        ["Job: Outlaw"] = Vector3.new(135.2, 21.5, -1852.0),
        ["Job: Police"] = Vector3.new(148.2, 21.5, -1991.5),
        ["Job: Delivery"] = Vector3.new(122.5, 21.8, -1922.7),
        ["Job: Security HQ"] = Vector3.new(-109.8, 25.1, -956.8),
        ["Spawn Dealership"] = Vector3.new(-482, 14, -1767),
    },
    Codes = {
        "UWU", "RECORD", "USA250", "10KITS", "MARCH2026", "HAPPY2026", "CALL911", "GOBBLEGOBBLE",
        "SPOOKY", "VEGAS2025", "WHOOPS", "RDCNASCAR25", "2MLIKES", "NASCAR100M", "CUSTOMIZATION2025",
        "200KMEMBERS", "NEWYEAR2025", "ZOOM", "HAPPYXMAS",
    },
    CodeDelay = 1.5,
}

local Config = xDTaraZ.Config

xDTaraZ.State = {
    Alive = true,
    Messages = {},
    Busy = false,
    Stats = nil,
    Spawners = {},
    LastReward = 0,
    LastEsp = 0,
    AtmSession = { Busted = 0, Earned = 0, CashedOut = 0, StartCash = 0 },
    DriveConn = nil,
    Conns = {},
    EspObjects = {},
    LightingBackup = nil,
    Opt = {
        AtmFarm = false,
        HopWhenEmpty = false,
        AvoidCops = false,
        CashOutCrimes = 10,
        DriveFarm = false,
        DriveCar = nil,
        AutoPlaytime = false,
        AutoClaimMisc = false,
        Code = "",
        WalkSpeed = 16,
        JumpPower = 50,
        SpeedEnabled = false,
        Noclip = false,
        InfiniteJump = false,
        Fullbright = false,
        AntiAfk = false,
        AutoRejoin = false,
        EspAtm = false,
        EspCops = false,
        EspDropOff = false,
        CarSpeed = 0,
    },
}

local State = xDTaraZ.State

for _, name in ipairs({ "Util", "Player", "Vehicle", "Jobs", "Atm", "Drive", "Rewards", "Teleport", "Esp", "Movement", "Session", "Scheduler" }) do
    xDTaraZ[name] = {}
end

function xDTaraZ.Util.Try(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then
        warn("[Driving Empire]", err)
    end
    return ok, err
end

function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then
        return body
    end
    local requestFn = request or http_request or (syn and syn.request)
    if not requestFn then
        error("No HTTP function available")
    end
    local response = requestFn({ Url = url, Method = "GET" })
    if type(response) ~= "table" or type(response.Body) ~= "string" then
        error("HTTP request failed: " .. url)
    end
    return response.Body
end

function xDTaraZ.Util.GuiRoot()
    if gethui then
        return gethui()
    end
    return game:GetService("CoreGui")
end

function xDTaraZ.Util.Stats()
    if State.Stats and State.Stats.Parent then return State.Stats end
    local folder = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild(LocalPlayer.Name .. "'s Stats")
    State.Stats = folder or Data.GetLoadedStatsFolder(LocalPlayer)
    return State.Stats
end

function xDTaraZ.Util.Cash()
    local stats = xDTaraZ.Util.Stats()
    return stats and stats.Cash.Value or 0
end

function xDTaraZ.Util.Commas(number)
    local text = tostring(math.floor(number))
    repeat
        local count
        text, count = text:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
    until count == 0
    return text
end

function xDTaraZ.Player.Character()
    local character = LocalPlayer.Character
    if character and character.Parent and character:FindFirstChild("HumanoidRootPart") then
        return character
    end
end

function xDTaraZ.Player.Humanoid()
    local character = xDTaraZ.Player.Character()
    return character and character:FindFirstChildOfClass("Humanoid")
end

function xDTaraZ.Player.Root()
    local character = xDTaraZ.Player.Character()
    return character and character.HumanoidRootPart
end

function xDTaraZ.Player.TeleportTo(cframe)
    local root = xDTaraZ.Player.Root()
    if not root then
        return false
    end
    if xDTaraZ.Vehicle.IsSeated() then
        xDTaraZ.Vehicle.Despawn()
        task.wait(1)
    end
    root.CFrame = cframe
    root.AssemblyLinearVelocity = Vector3.zero
    return true
end

function xDTaraZ.Vehicle.Current()
    local vehicle = VehicleController.getVehicle()
    return vehicle and vehicle.Object
end

function xDTaraZ.Vehicle.IsSeated()
    local humanoid = xDTaraZ.Player.Humanoid()
    return humanoid ~= nil and humanoid.SeatPart ~= nil
end

function xDTaraZ.Vehicle.Owned()
    local owned = {}
    local stats = xDTaraZ.Util.Stats()
    if not stats then
        return owned
    end
    for _, entry in ipairs(stats.Vehicles:GetChildren()) do
        if entry.Value == true then
            table.insert(owned, entry.Name)
        end
    end
    table.sort(owned)
    return owned
end

function xDTaraZ.Vehicle.Spawn(vehicleId)
    if not vehicleId then
        return nil
    end
    RemoteFolder.VehicleEvent:FireServer("Spawn", vehicleId)
    local deadline = os.clock() + 8
    repeat
        task.wait(0.25)
    until xDTaraZ.Vehicle.Current() or os.clock() > deadline
    return xDTaraZ.Vehicle.Current()
end

function xDTaraZ.Vehicle.Despawn()
    RemoteFolder.VehicleEvent:FireServer("Despawn")
end

---@return boolean  moved the car, or the character when on foot
function xDTaraZ.Vehicle.TeleportTo(cframe)
    local car = xDTaraZ.Vehicle.Current()
    if not car or not xDTaraZ.Vehicle.IsSeated() then
        local root = xDTaraZ.Player.Root()
        if root then
            root.CFrame = cframe
        end
        return root ~= nil
    end
    TeleportGuard.AuthorizeNextTeleport()
    car:PivotTo(cframe)
    if car.PrimaryPart then
        car.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
    end
    return true
end

function xDTaraZ.Vehicle.ApplySpeed()
    local car = xDTaraZ.Vehicle.Current()
    local boost = State.Opt.CarSpeed
    if not car or not car.PrimaryPart or boost <= 0 or not xDTaraZ.Vehicle.IsSeated() then
        return
    end
    if not UserInputService:IsKeyDown(Enum.KeyCode.W) then
        return
    end
    local root = car.PrimaryPart
    local flat = root.CFrame.LookVector * Vector3.new(1, 0, 1)
    if flat.Magnitude < 0.1 then
        return
    end
    local velocity = root.AssemblyLinearVelocity
    local forward = velocity:Dot(flat.Unit)
    local target = math.max(forward, boost)
    root.AssemblyLinearVelocity = flat.Unit * target + Vector3.new(0, velocity.Y, 0)
end

function xDTaraZ.Jobs.Current()
    return LocalPlayer:GetAttribute("JobId")
end

function xDTaraZ.Jobs.Start(jobId)
    if xDTaraZ.Jobs.Current() == jobId then
        return true
    end
    JobsController.RequestStartJobSession(jobId, "jobPad")
    local deadline = os.clock() + 4
    repeat
        task.wait(0.2)
    until xDTaraZ.Jobs.Current() == jobId or os.clock() > deadline
    return xDTaraZ.Jobs.Current() == jobId
end

function xDTaraZ.Jobs.Leave()
    if xDTaraZ.Jobs.Current() then
        JobsController.RequestEndJobSession("jobPad")
    end
end

function xDTaraZ.Atm.LoadCache()
    if not (isfile and readfile) or not isfile(Config.SpawnerCacheFile) then
        return
    end
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(Config.SpawnerCacheFile))
    if not ok or type(decoded) ~= "table" then
        return
    end
    for id, coords in pairs(decoded) do
        State.Spawners[id] = Vector3.new(coords[1], coords[2], coords[3])
    end
end

function xDTaraZ.Atm.SaveCache()
    local encoded = {}
    for id, position in pairs(State.Spawners) do
        encoded[id] = { position.X, position.Y, position.Z }
    end
    if not (writefile and makefolder and isfolder) then
        return
    end
    if not isfolder("Driving Empire") then
        makefolder("Driving Empire")
    end
    writefile(Config.SpawnerCacheFile, HttpService:JSONEncode(encoded))
end

function xDTaraZ.Atm.SpawnerCount()
    local count = 0
    for _ in pairs(State.Spawners) do
        count += 1
    end
    return count
end

local function RecordStreamedSpawners()
    for _, spawner in ipairs(workspace.Game.Jobs.CriminalATMSpawners:GetChildren()) do
        local id = spawner:GetAttribute("ComponentServerId")
        if id then
            State.Spawners[id] = spawner.Position
        end
    end
end

function xDTaraZ.Atm.Sweep()
    local root = xDTaraZ.Player.Root()
    if not root then
        return 0
    end
    if xDTaraZ.Vehicle.IsSeated() then
        xDTaraZ.Vehicle.Despawn()
        task.wait(1)
    end
    for x = Config.SweepMin.X, Config.SweepMax.X, Config.SweepStep do
        for z = Config.SweepMin.Z, Config.SweepMax.Z, Config.SweepStep do
            if not State.Alive then
                return xDTaraZ.Atm.SpawnerCount()
            end
            root.CFrame = CFrame.new(x, Config.SweepHeight, z)
            root.AssemblyLinearVelocity = Vector3.zero
            task.wait(Config.SweepDelay)
            RecordStreamedSpawners()
        end
    end
    xDTaraZ.Atm.SaveCache()
    return xDTaraZ.Atm.SpawnerCount()
end

local function FindAtm(spawnerId)
    for _, spawner in ipairs(workspace.Game.Jobs.CriminalATMSpawners:GetChildren()) do
        if spawner:GetAttribute("ComponentServerId") == spawnerId then
            return spawner:FindFirstChild("CriminalATM")
        end
    end
end

function xDTaraZ.Atm.IsAvailable(atm)
    if not atm or atm:GetAttribute("State") ~= "Normal" then
        return false
    end
    local engaging = atm:GetAttribute("EngagingPlayerId")
    return engaging == nil or engaging == LocalPlayer.UserId
end

function xDTaraZ.Atm.CopNearby(position)
    for _, other in ipairs(Players:GetPlayers()) do
        local character = other ~= LocalPlayer and other.Character
        if character and other:GetAttribute("JobId") == "Security" then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root and (root.Position - position).Magnitude < Config.CopAvoidRadius then
                return true
            end
        end
    end
    return false
end

local function WaitForDebounce(character)
    local deadline = os.clock() + Config.DebounceTimeout
    while character:GetAttribute("ATMBustDebounce") and os.clock() < deadline do
        task.wait(0.1)
    end
end

---@return boolean, string?  robbed, else the server's reason
function xDTaraZ.Atm.Bust(atm)
    local character = xDTaraZ.Player.Character()
    if not character or not xDTaraZ.Atm.IsAvailable(atm) then
        return false, "Unavailable"
    end
    local attachment = atm:FindFirstChild("PromptAttachment")
    local target = attachment and attachment.WorldPosition or atm:GetPivot().Position
    if State.Opt.AvoidCops and xDTaraZ.Atm.CopNearby(target) then
        return false, "CopNearby"
    end
    WaitForDebounce(character)
    character.HumanoidRootPart.CFrame = CFrame.lookAt(target + atm:GetPivot().LookVector * 3, target)
    task.wait(0.25)
    local started, reason = Remotes.invokeServer("AttemptATMBustStart", atm)
    if not started then
        return false, reason
    end
    task.wait(Config.BustWait)
    local earnedBefore = character:GetAttribute("CurrencyEarned") or 0
    local done, failReason = Remotes.invokeServer("AttemptATMBustComplete", atm)
    if not done then
        return false, failReason
    end
    State.AtmSession.Busted += 1
    task.defer(function()
        task.wait(0.5)
        State.AtmSession.Earned += math.max(0, (character:GetAttribute("CurrencyEarned") or 0) - earnedBefore)
    end)
    return true
end

function xDTaraZ.Atm.DropOffPositions()
    local positions = {}
    for _, point in ipairs(CollectionService:GetTagged("CriminalDropOffPoint")) do
        table.insert(positions, point:GetPivot().Position)
    end
    if #positions == 0 then
        return Config.DropOffSeeds
    end
    return positions
end

function xDTaraZ.Atm.NearestDropOff()
    local root = xDTaraZ.Player.Root()
    local best, bestDistance = nil, math.huge
    for _, position in ipairs(xDTaraZ.Atm.DropOffPositions()) do
        local distance = root and (position - root.Position).Magnitude or 0
        if distance < bestDistance then
            best, bestDistance = position, distance
        end
    end
    return best
end

function xDTaraZ.Atm.Crimes()
    local character = xDTaraZ.Player.Character()
    return character and character:GetAttribute("CrimesCommitted") or 0
end

function xDTaraZ.Atm.CashOut()
    if xDTaraZ.Atm.Crimes() < Config.CashOutCrimes then
        return false
    end
    local target = xDTaraZ.Atm.NearestDropOff()
    if not target then
        return false
    end
    local cashBefore = xDTaraZ.Util.Cash()
    xDTaraZ.Player.TeleportTo(CFrame.new(target + Vector3.new(0, 4, Config.DropOffApproach)))
    task.wait(1)
    target = xDTaraZ.Atm.NearestDropOff()
    xDTaraZ.Player.TeleportTo(CFrame.new(target + Vector3.new(0, 3, 0)))
    local deadline = os.clock() + Config.CashOutWait
    repeat
        task.wait(0.25)
    until xDTaraZ.Util.Cash() > cashBefore or os.clock() > deadline
    local gained = xDTaraZ.Util.Cash() - cashBefore
    State.AtmSession.CashedOut += math.max(0, gained)
    return gained > 0, gained
end

function xDTaraZ.Atm.RunPass()
    if not xDTaraZ.Jobs.Start("Criminal") then
        return 0
    end
    if xDTaraZ.Atm.SpawnerCount() == 0 then
        xDTaraZ.Atm.Sweep()
    end
    local busted = 0
    for id, position in pairs(State.Spawners) do
        if not State.Opt.AtmFarm or not State.Alive then
            break
        end
        xDTaraZ.Player.TeleportTo(CFrame.new(position + Vector3.new(0, 6, 0)))
        local atm
        local deadline = os.clock() + Config.StreamWait
        repeat
            task.wait(0.1)
            atm = FindAtm(id)
        until atm or os.clock() > deadline
        RecordStreamedSpawners()
        if xDTaraZ.Atm.IsAvailable(atm) and xDTaraZ.Atm.Bust(atm) then
            busted += 1
        end
        local crimes = xDTaraZ.Atm.Crimes()
        if crimes >= State.Opt.CashOutCrimes or (crimes >= Config.CashOutCrimes and xDTaraZ.Atm.WantedLeft() < Config.WantedSafety) then
            xDTaraZ.Atm.CashOut()
        end
    end
    return busted
end

function xDTaraZ.Atm.WantedLeft()
    local character = xDTaraZ.Player.Character()
    local expire = character and character:GetAttribute("CriminalExpireEpoch")
    return expire and expire - workspace:GetServerTimeNow() or math.huge
end

function xDTaraZ.Atm.FarmStep()
    local busted = xDTaraZ.Atm.RunPass()
    if not State.Opt.AtmFarm then
        return
    end
    if xDTaraZ.Atm.Crimes() >= State.Opt.CashOutCrimes then
        xDTaraZ.Atm.CashOut()
    end
    if busted == 0 and State.Opt.HopWhenEmpty and xDTaraZ.Atm.Crimes() == 0 then
        xDTaraZ.Session.Hop()
    end
end

function xDTaraZ.Atm.NearestAvailable()
    local root = xDTaraZ.Player.Root()
    local best, bestDistance
    for _, spawner in ipairs(workspace.Game.Jobs.CriminalATMSpawners:GetChildren()) do
        local atm = spawner:FindFirstChild("CriminalATM")
        if xDTaraZ.Atm.IsAvailable(atm) then
            local distance = (spawner.Position - root.Position).Magnitude
            if not bestDistance or distance < bestDistance then
                best, bestDistance = atm, distance
            end
        end
    end
    return best
end

function xDTaraZ.Drive.Start()
    if State.DriveConn then
        return
    end
    xDTaraZ.Jobs.Leave()
    local car = xDTaraZ.Vehicle.Current()
    if not car or not xDTaraZ.Vehicle.IsSeated() then
        car = xDTaraZ.Vehicle.Spawn(State.Opt.DriveCar or xDTaraZ.Vehicle.Owned()[1])
    end
    if not car then
        return false
    end
    task.wait(1)
    xDTaraZ.Vehicle.TeleportTo(CFrame.new(Config.DriveCenter + Vector3.new(Config.DriveRadius, 4, 0)))
    task.wait(1)
    State.DriveConn = RunService.Heartbeat:Connect(function()
        local current = xDTaraZ.Vehicle.Current()
        local root = current and current.PrimaryPart
        if not root then
            return
        end
        local offset = (root.Position - Config.DriveCenter) * Vector3.new(1, 0, 1)
        if offset.Magnitude < 1 then
            return
        end
        local tangent = Vector3.new(-offset.Z, 0, offset.X).Unit
        local pull = offset.Unit * (Config.DriveRadius - offset.Magnitude) * 1.5
        local fall = math.min(root.AssemblyLinearVelocity.Y, 0)
        root.AssemblyLinearVelocity = tangent * Config.DriveSpeed + pull + Vector3.new(0, fall, 0)
        root.AssemblyAngularVelocity = Vector3.new(0, -Config.DriveSpeed / Config.DriveRadius, 0)
    end)
    return true
end

function xDTaraZ.Drive.Stop()
    if State.DriveConn then
        State.DriveConn:Disconnect()
        State.DriveConn = nil
    end
    local car = xDTaraZ.Vehicle.Current()
    if car and car.PrimaryPart then
        car.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
    end
end

function xDTaraZ.Rewards.ClaimPlaytime()
    local ok, unclaimed = pcall(function()
        local pending = PlayRewardUtil.getUnclaimedRewards(LocalPlayer)
        if type(pending) == "table" and pending.expect then
            pending = pending:expect()
        end
        return pending
    end)
    if not ok or type(unclaimed) ~= "table" then
        return 0
    end
    local count = 0
    for index in pairs(unclaimed) do
        Remotes.fireServer("PlayRewards", tonumber(index) or index, false)
        count += 1
        task.wait(0.5)
    end
    return count
end

function xDTaraZ.Rewards.ClaimMisc()
    Remotes.fireServer("ClaimRewards")
    Remotes.fireServer("RaceLeaderboardClaimRewards")
end

function xDTaraZ.Rewards.Redeemed()
    local stats = xDTaraZ.Util.Stats()
    local ok, decoded = pcall(HttpService.JSONDecode, HttpService, stats and stats.Codes.Value or "")
    return ok and type(decoded) == "table" and decoded or {}
end

---@return number, number  new codes redeemed, cash gained
function xDTaraZ.Rewards.RedeemCodes(codes)
    local redeemedBefore = xDTaraZ.Rewards.Redeemed()
    local cashBefore = xDTaraZ.Util.Cash()
    local success = 0
    for _, code in ipairs(codes) do
        if not redeemedBefore[code] then
            RemoteFolder.Code:FireServer(code)
            task.wait(Config.CodeDelay)
            if xDTaraZ.Rewards.Redeemed()[code] then
                success += 1
            end
        end
    end
    return success, xDTaraZ.Util.Cash() - cashBefore
end

function xDTaraZ.Teleport.Destinations()
    local destinations = {}
    local names = {}
    local function Add(name, position)
        if position and not destinations[name] then
            destinations[name] = position
            table.insert(names, name)
        end
    end
    for name, position in pairs(Config.PlaceSeeds) do
        Add(name, position)
    end
    for index, position in ipairs(xDTaraZ.Atm.DropOffPositions()) do
        Add(("Criminal Drop-off %d"):format(index), position)
    end
    local heist = workspace.Game.Heists:FindFirstChild("BankHeist")
    local heistStart = heist and heist:FindFirstChild("HeistStartTeleport", true)
    if heistStart then
        Add("Bank Heist", heistStart.Position)
    end
    local dealerships = workspace.Game:FindFirstChild("Dealerships")
    dealerships = dealerships and dealerships:FindFirstChild("Dealerships")
    if dealerships then
        for _, dealership in ipairs(dealerships:GetChildren()) do
            local part = dealership:FindFirstChildWhichIsA("BasePart", true)
            if part then
                Add("Dealership: " .. dealership.Name, part.Position)
            end
        end
    end
    table.sort(names)
    return names, destinations
end

function xDTaraZ.Teleport.Go(position)
    if not position then
        return
    end
    LocalPlayer:RequestStreamAroundAsync(position, 5)
    xDTaraZ.Vehicle.TeleportTo(CFrame.new(position + Vector3.new(0, 5, 0)))
end

function xDTaraZ.Teleport.ToPlayer(name)
    local target = Players:FindFirstChild(name)
    local root = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if root then
        xDTaraZ.Teleport.Go(root.Position + Vector3.new(0, 0, 4))
    end
end

function xDTaraZ.Movement.Step()
    local opt = State.Opt
    local character = xDTaraZ.Player.Character()
    local humanoid = xDTaraZ.Player.Humanoid()
    if not character or not humanoid then
        return
    end
    if opt.SpeedEnabled and not xDTaraZ.Vehicle.IsSeated() then
        humanoid.WalkSpeed = opt.WalkSpeed
        humanoid.UseJumpPower = true
        humanoid.JumpPower = opt.JumpPower
    end
    if opt.Noclip then
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    xDTaraZ.Vehicle.ApplySpeed()
end

function xDTaraZ.Movement.ResetSpeed()
    local humanoid = xDTaraZ.Player.Humanoid()
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end

function xDTaraZ.Movement.SetFullbright(enabled)
    if enabled then
        State.LightingBackup = State.LightingBackup or {
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            GlobalShadows = Lighting.GlobalShadows,
            Ambient = Lighting.Ambient,
        }
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(180, 180, 180)
        return
    end
    if State.LightingBackup then
        for property, value in pairs(State.LightingBackup) do
            Lighting[property] = value
        end
        State.LightingBackup = nil
    end
end

function xDTaraZ.Movement.Bind()
    table.insert(State.Conns, RunService.Stepped:Connect(function()
        xDTaraZ.Util.Try(xDTaraZ.Movement.Step)
    end))
    table.insert(State.Conns, UserInputService.JumpRequest:Connect(function()
        local humanoid = xDTaraZ.Player.Humanoid()
        if State.Opt.InfiniteJump and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end))
end

local function EspMark(key, adornee, text, color)
    local entry = State.EspObjects[key]
    if entry and entry.Highlight.Parent and entry.Highlight.Adornee == adornee then
        entry.Label.Text = text
        return
    end
    if entry then
        entry.Highlight:Destroy()
        entry.Billboard:Destroy()
    end
    local highlight = Instance.new("Highlight")
    highlight.FillColor = color
    highlight.FillTransparency = 0.6
    highlight.OutlineColor = color
    highlight.Adornee = adornee
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = xDTaraZ.Util.GuiRoot()
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.fromOffset(160, 28)
    billboard.StudsOffset = Vector3.new(0, 5, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = adornee
    billboard.Parent = xDTaraZ.Util.GuiRoot()
    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = color
    label.TextStrokeTransparency = 0.3
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Text = text
    label.Parent = billboard
    State.EspObjects[key] = { Highlight = highlight, Billboard = billboard, Label = label }
end

function xDTaraZ.Esp.Refresh()
    local opt = State.Opt
    local root = xDTaraZ.Player.Root()
    local alive = {}
    local function Distance(position)
        return root and math.floor((position - root.Position).Magnitude) or 0
    end
    if opt.EspAtm then
        for _, spawner in ipairs(workspace.Game.Jobs.CriminalATMSpawners:GetChildren()) do
            local atm = spawner:FindFirstChild("CriminalATM")
            if xDTaraZ.Atm.IsAvailable(atm) then
                local key = "atm" .. tostring(spawner:GetAttribute("ComponentServerId"))
                alive[key] = true
                EspMark(key, atm, ("ATM %s · %dm"):format(tostring(atm:GetAttribute("Rarity")), Distance(spawner.Position)), Color3.fromRGB(90, 220, 120))
            end
        end
    end
    if opt.EspCops then
        for _, other in ipairs(Players:GetPlayers()) do
            local character = other.Character
            local job = other:GetAttribute("JobId")
            if other ~= LocalPlayer and character and character:FindFirstChild("HumanoidRootPart") and job then
                local key = "plr" .. other.UserId
                alive[key] = true
                local color = job == "Security" and Color3.fromRGB(80, 140, 255) or job == "Criminal" and Color3.fromRGB(255, 90, 90) or Color3.fromRGB(232, 160, 76)
                EspMark(key, character, ("%s [%s] · %dm"):format(other.DisplayName, job, Distance(character.HumanoidRootPart.Position)), color)
            end
        end
    end
    if opt.EspDropOff then
        for index, point in ipairs(CollectionService:GetTagged("CriminalDropOffPoint")) do
            local key = "drop" .. index
            alive[key] = true
            EspMark(key, point, ("Drop-off · %dm"):format(Distance(point:GetPivot().Position)), Color3.fromRGB(255, 210, 80))
        end
    end
    for key, entry in pairs(State.EspObjects) do
        if not alive[key] then
            entry.Highlight:Destroy()
            entry.Billboard:Destroy()
            State.EspObjects[key] = nil
        end
    end
end

function xDTaraZ.Session.Bind()
    table.insert(State.Conns, LocalPlayer.Idled:Connect(function()
        if State.Opt.AntiAfk then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.zero)
        end
    end))
    table.insert(State.Conns, GuiService.ErrorMessageChanged:Connect(function()
        if not State.Opt.AutoRejoin then
            return
        end
        task.wait(Config.HopDelay)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end))
end

function xDTaraZ.Session.Hop()
    local ok, body = pcall(xDTaraZ.Util.HttpGet, ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100"):format(game.PlaceId))
    if not ok then
        return false
    end
    local decoded = HttpService:JSONDecode(body)
    local candidates = {}
    for _, server in ipairs(decoded.data or {}) do
        if server.id ~= game.JobId and server.playing < server.maxPlayers - 1 then
            table.insert(candidates, server.id)
        end
    end
    if #candidates == 0 then
        return false
    end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, candidates[math.random(#candidates)], LocalPlayer)
    return true
end

function xDTaraZ.Scheduler.Step()
    local opt = State.Opt
    local now = os.clock()
    if opt.AtmFarm then
        xDTaraZ.Atm.FarmStep()
    end
    if (opt.AutoPlaytime or opt.AutoClaimMisc) and now - State.LastReward > Config.RewardInterval then
        State.LastReward = now
        if opt.AutoPlaytime then
            xDTaraZ.Rewards.ClaimPlaytime()
        end
        if opt.AutoClaimMisc then
            xDTaraZ.Rewards.ClaimMisc()
        end
    end
    if now - State.LastEsp > Config.EspInterval then
        State.LastEsp = now
        xDTaraZ.Esp.Refresh()
    end
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Atm.LoadCache()
    xDTaraZ.Movement.Bind()
    xDTaraZ.Session.Bind()
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

function xDTaraZ.Scheduler.Stop()
    State.Alive = false
    for key in pairs(State.Opt) do
        if type(State.Opt[key]) == "boolean" and key ~= "AntiAfk" then
            State.Opt[key] = false
        end
    end
    xDTaraZ.Drive.Stop()
    xDTaraZ.Movement.ResetSpeed()
    xDTaraZ.Movement.SetFullbright(false)
    for _, conn in ipairs(State.Conns) do
        conn:Disconnect()
    end
    table.clear(State.Conns)
    xDTaraZ.Esp.Refresh()
end

xDTaraZ.UI = {}
local Library, T

function xDTaraZ.UI.Notify(text)
    State.Messages[#State.Messages + 1] = text
end

function xDTaraZ.UI.Spawn(action)
    return function()
        task.spawn(xDTaraZ.Util.Try, action)
    end
end

---@param onChange function?  runs after State.Opt is updated
function xDTaraZ.UI.Write(key, onChange)
    return function(value)
        State.Opt[key] = value
        if onChange then xDTaraZ.Util.Try(onChange, value) end
    end
end

function xDTaraZ.UI.RegisterIcons()
    if Library:HasIcon("car") then return end
    Library:AddIcon("car", {
        ".........",
        ".........",
        "..RRRR...",
        ".RWWRWR..",
        "RRRRRRRRR",
        "RRRRRRRRY",
        "RKKRRRKKR",
        ".KK...KK.",
        ".........",
    }, {
        R = Color3.fromRGB(226, 60, 52),
        W = Color3.fromRGB(170, 220, 255),
        Y = Color3.fromRGB(255, 220, 90),
        K = Color3.fromRGB(40, 40, 48),
    })
end

---@return string, string  status text, status kind
function xDTaraZ.UI.AtmStatus()
    if not State.Opt.AtmFarm then return "Off", "Idle" end
    local crimes = xDTaraZ.Atm.Crimes()
    if crimes >= State.Opt.CashOutCrimes then return "Cashing out", "Busy" end
    return ("Robbing · %d stars"):format(crimes), "Running"
end

function xDTaraZ.UI.BuildMain(window)
    window:AddTabSection(T("Main", "หลัก"))
    local tab = window:AddTab(T("Main", "หลัก"), "mushroom", T("Status and links", "สถานะและลิงก์"))

    local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "stats")
    status:AddStatus("StatusAtm", { Text = T("ATM Farm", "ฟาร์ม ATM"), Icon = "money" })
    status:AddStatus("StatusDrive", { Text = T("Auto Drive", "ขับรถอัตโนมัติ"), Icon = "car" })
    status:AddStatus("StatusJob", { Text = T("Job", "อาชีพ"), Icon = "quest" })

    local live = tab:AddLeftGroupbox(T("Live", "ตัวเลขสด"), "chart")
    live:AddStat("StatCash", { Text = T("Cash", "เงิน"), Icon = "money", Format = "$%s", Token = "Coin" })
    live:AddStat("StatRobbed", { Text = T("ATMs robbed", "ATM ที่ปล้น"), Icon = "loot", Format = "%s" })
    live:AddStat("StatWanted", { Text = T("Cash on you", "เงินที่ถืออยู่"), Icon = "warn", Format = "$%s" })
    live:AddStat("StatCashedOut", { Text = T("Cashed out", "ส่งเงินแล้ว"), Icon = "success", Format = "$%s", Token = "Good" })
    live:AddStat("StatSpots", { Text = T("ATM spots known", "จุด ATM ที่รู้"), Icon = "map", Format = "%s" })

    local quick = tab:AddRightGroupbox(T("Quick", "ด่วน"), "lightning")
    quick:AddButton({ Text = T("Panic - All Off", "ฉุกเฉิน ปิดทั้งหมด"), Icon = "stop", Style = "Danger", Callback = function()
        for _, toggle in pairs(Library.Toggles) do
            if toggle.Value == true then toggle:SetValue(false) end
        end
    end })

    Library.Kit.Discord.Build(tab, Config.Discord)
end

function xDTaraZ.UI.BuildAtm(tab)
    local opt = State.Opt
    local atm = tab:AddLeftGroupbox(T("ATM Farm", "ฟาร์ม ATM"), "money")
    atm:AddFeature("AtmFarm", {
        Text = T("Auto ATM Farm", "ฟาร์ม ATM อัตโนมัติ"),
        Description = T("Robs every ATM on the map, then cashes out", "ปล้น ATM ทุกตู้ในแมพ แล้วส่งเงิน"),
        Icon = "money",
        Risky = true,
        Badge = T("Risky", "เสี่ยง"),
        Keybind = { Default = "None", Mode = "Toggle" },
        Callback = xDTaraZ.UI.Write("AtmFarm"),
        Now = { Text = T("Rob Nearest", "ปล้นตู้ใกล้สุด"), Icon = "loot", Callback = xDTaraZ.UI.Spawn(function()
            xDTaraZ.Jobs.Start("Criminal")
            local target = xDTaraZ.Atm.NearestAvailable()
            if not target then
                xDTaraZ.UI.Notify("No ATM nearby")
                return
            end
            local ok, reason = xDTaraZ.Atm.Bust(target)
            xDTaraZ.UI.Notify(ok and "ATM robbed" or ("Failed: " .. tostring(reason)))
        end) },
        Options = function(options)
            options:AddToggle("HopWhenEmpty", { Text = T("Hop when empty", "ย้ายเซิร์ฟเมื่อ ATM หมด"), Icon = "hop", Callback = xDTaraZ.UI.Write("HopWhenEmpty") })
            options:AddToggle("AvoidCops", { Text = T("Avoid police", "หลบตำรวจ"), Icon = "shield", Callback = xDTaraZ.UI.Write("AvoidCops") })
        end,
    })
    atm:AddStepper("CashOutCrimes", {
        Text = T("Cash out at robberies", "ส่งเงินเมื่อปล้นครบ"),
        Description = T("Higher = more cash per trip, more risk", "ยิ่งมากยิ่งได้ต่อรอบ แต่เสี่ยงขึ้น"),
        Icon = "trophy",
        Min = 5, Max = 30, Step = 1, Default = opt.CashOutCrimes,
        Callback = function(value) opt.CashOutCrimes = tonumber(value) or opt.CashOutCrimes end,
    })
    atm:AddButton({ Text = T("Cash Out Now", "ส่งเงินเดี๋ยวนี้"), Icon = "money", Style = "Success", Callback = xDTaraZ.UI.Spawn(function()
        local ok, gained = xDTaraZ.Atm.CashOut()
        xDTaraZ.UI.Notify(ok and ("Cashed out $" .. xDTaraZ.Util.Commas(gained)) or "Need 5 stars first")
    end) }):AddButton({ Text = T("Scan Map", "สแกนแมพ"), Icon = "radar", Style = "Ghost", Callback = xDTaraZ.UI.Spawn(function()
        xDTaraZ.UI.Notify(("Found %d ATM spots"):format(xDTaraZ.Atm.Sweep()))
    end) })
end

function xDTaraZ.UI.BuildFarm(window)
    window:AddTabSection(T("Farming", "ฟาร์ม"))
    local tab = window:AddTab(T("Farm", "ฟาร์ม"), "autofarm", T("ATMs, jobs and driving", "ATM อาชีพ และขับรถ"))
    xDTaraZ.UI.BuildAtm(tab)

    local drive = tab:AddRightGroupbox(T("Drive Farm", "ฟาร์มขับรถ"), "car")
    drive:AddFeature("DriveFarm", {
        Text = T("Auto Drive", "ขับรถอัตโนมัติ"),
        Description = T("Drives laps on its own for cash", "ขับวนเองเพื่อรับเงิน"),
        Icon = "car",
        Keybind = { Default = "None", Mode = "Toggle" },
        Callback = xDTaraZ.UI.Write("DriveFarm", function(on)
            if not on then return xDTaraZ.Drive.Stop() end
            if not xDTaraZ.Drive.Start() then xDTaraZ.UI.Notify("No car to drive") end
        end),
    })

    local jobs = tab:AddRightGroupbox(T("Jobs", "อาชีพ"), "quest")
    jobs:AddSegmented("JobPick", {
        Text = T("Job", "อาชีพ"),
        Icon = "players",
        Values = { "Criminal", "Security", "Delivery" },
        Default = "Criminal",
        Callback = xDTaraZ.UI.Write("JobPick"),
    })
    jobs:AddButton({ Text = T("Start Job", "เริ่มงาน"), Icon = "play", Style = "Primary", Callback = xDTaraZ.UI.Spawn(function()
        xDTaraZ.UI.Notify(xDTaraZ.Jobs.Start(State.Opt.JobPick or "Criminal") and "Job started" or "Could not start job")
    end) }):AddButton({ Text = T("Quit Job", "ออกจากงาน"), Icon = "close", Callback = xDTaraZ.UI.Spawn(xDTaraZ.Jobs.Leave) })
end

function xDTaraZ.UI.BuildRewards(window)
    local tab = window:AddTab(T("Rewards", "รางวัล"), "loot", T("Codes and claims", "โค้ดและรับรางวัล"))

    local claims = tab:AddLeftGroupbox(T("Claims", "รับรางวัล"), "loot")
    claims:AddFeature("AutoPlaytime", {
        Text = T("Auto Playtime Rewards", "รับรางวัลเวลาเล่นอัตโนมัติ"),
        Description = T("Cash, cars and packs as soon as they unlock", "เงิน รถ และแพ็กทันทีที่ปลดล็อก"),
        Icon = "clock",
        Callback = xDTaraZ.UI.Write("AutoPlaytime"),
        Now = { Text = T("Claim All Now", "รับทั้งหมดเดี๋ยวนี้"), Icon = "loot", Callback = xDTaraZ.UI.Spawn(function()
            local count = xDTaraZ.Rewards.ClaimPlaytime()
            xDTaraZ.Rewards.ClaimMisc()
            xDTaraZ.UI.Notify(("Claimed %d playtime rewards"):format(count))
        end) },
    })
    claims:AddToggle("AutoClaimMisc", {
        Text = T("Auto Claim Pending", "รับรางวัลค้างอัตโนมัติ"),
        Description = T("Race and event rewards", "รางวัลแข่งและอีเวนต์"),
        Icon = "trophy",
        Callback = xDTaraZ.UI.Write("AutoClaimMisc"),
    })

    local codes = tab:AddRightGroupbox(T("Codes", "โค้ด"), "code")
    codes:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Icon = "code", Style = "Primary", Callback = xDTaraZ.UI.Spawn(function()
        local count, cash = xDTaraZ.Rewards.RedeemCodes(Config.Codes)
        xDTaraZ.UI.Notify(("Redeemed %d new codes (+$%s)"):format(count, xDTaraZ.Util.Commas(cash)))
    end) })
    codes:AddInput("Code", {
        Text = T("Custom code", "ใส่โค้ดเอง"),
        Icon = "edit",
        Default = "",
        Finished = true,
        Save = false,
        Callback = xDTaraZ.UI.Write("Code"),
    })
    codes:AddButton({ Text = T("Redeem", "ใช้โค้ด"), Icon = "check", Callback = xDTaraZ.UI.Spawn(function()
        local count = xDTaraZ.Rewards.RedeemCodes({ State.Opt.Code })
        xDTaraZ.UI.Notify(count > 0 and "Code redeemed" or "Code invalid or already used")
    end) })
end

function xDTaraZ.UI.BuildVehicle(window)
    local tab = window:AddTab(T("Vehicle", "รถ"), "car", T("Garage and speed", "โรงรถและความเร็ว"))
    local owned = xDTaraZ.Vehicle.Owned()
    State.Opt.DriveCar = owned[1]

    local garage = tab:AddLeftGroupbox(T("Garage", "โรงรถ"), "car")
    local picker = garage:AddDropdown("DriveCar", {
        Text = T("Car", "รถ"),
        Icon = "car",
        Values = owned,
        Default = owned[1],
        Searchable = true,
        Callback = xDTaraZ.UI.Write("DriveCar"),
    })
    garage:AddButton({ Text = T("Spawn", "เรียกรถ"), Icon = "play", Style = "Primary", Callback = xDTaraZ.UI.Spawn(function()
        xDTaraZ.UI.Notify(xDTaraZ.Vehicle.Spawn(State.Opt.DriveCar) and "Car spawned" or "Spawn failed")
    end) }):AddButton({ Text = T("Despawn", "เก็บรถ"), Icon = "trash", Callback = xDTaraZ.UI.Spawn(xDTaraZ.Vehicle.Despawn) })
    garage:AddButton({ Text = T("Refresh Garage", "รีเฟรชโรงรถ"), Icon = "refresh", Style = "Ghost", Callback = function()
        picker:SetValues(xDTaraZ.Vehicle.Owned())
    end })

    local tune = tab:AddRightGroupbox(T("Performance", "สมรรถนะ"), "speed")
    tune:AddSlider("CarSpeed", {
        Text = T("Car speed boost", "เร่งความเร็วรถ"),
        Description = T("Holds this speed while pressing W (0 = off)", "คงความเร็วนี้ขณะกด W (0 = ปิด)"),
        Icon = "speed",
        Min = 0, Max = 600, Default = State.Opt.CarSpeed, Rounding = 0,
        Callback = function(value) State.Opt.CarSpeed = tonumber(value) or 0 end,
    })
end

local function PlayerNames()
    local names = {}
    for _, other in ipairs(Players:GetPlayers()) do
        if other ~= LocalPlayer then table.insert(names, other.Name) end
    end
    return names
end

function xDTaraZ.UI.BuildTeleport(window)
    local tab = window:AddTab(T("Teleport", "วาร์ป"), "teleport", T("Go anywhere", "ไปได้ทุกที่"))
    local destNames, destinations = xDTaraZ.Teleport.Destinations()

    local places = tab:AddLeftGroupbox(T("Places", "สถานที่"), "waypoint")
    local placePicker = places:AddDropdown("Place", {
        Text = T("Destination", "จุดหมาย"),
        Icon = "map",
        Values = destNames,
        Default = destNames[1],
        Searchable = true,
        Callback = xDTaraZ.UI.Write("Place"),
    })
    places:AddButton({ Text = T("Teleport", "วาร์ป"), Icon = "teleport", Style = "Primary", Callback = xDTaraZ.UI.Spawn(function()
        xDTaraZ.Teleport.Go(destinations[State.Opt.Place or destNames[1]])
    end) }):AddButton({ Text = T("Refresh", "รีเฟรช"), Icon = "refresh", Style = "Ghost", Callback = function()
        destNames, destinations = xDTaraZ.Teleport.Destinations()
        placePicker:SetValues(destNames)
    end })

    local people = tab:AddRightGroupbox(T("Players", "ผู้เล่น"), "players")
    local playerPicker = people:AddDropdown("TargetPlayer", {
        Text = T("Player", "ผู้เล่น"),
        Icon = "player",
        Values = PlayerNames(),
        Searchable = true,
        AllowNull = true,
        Save = false,
        Callback = xDTaraZ.UI.Write("TargetPlayer"),
    })
    people:AddButton({ Text = T("Teleport To Player", "วาร์ปไปหาผู้เล่น"), Icon = "follow", Style = "Primary", Callback = xDTaraZ.UI.Spawn(function()
        xDTaraZ.Teleport.ToPlayer(State.Opt.TargetPlayer)
    end) }):AddButton({ Text = T("Refresh", "รีเฟรช"), Icon = "refresh", Style = "Ghost", Callback = function()
        playerPicker:SetValues(PlayerNames())
    end })
end

function xDTaraZ.UI.BuildPlayer(window)
    local opt = State.Opt
    local tab = window:AddTab(T("Player", "ผู้เล่น"), "player", T("Movement, world and server", "การเคลื่อนที่ โลก และเซิร์ฟ"))

    local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "speed")
    move:AddFeature("SpeedEnabled", {
        Text = T("Custom Speed", "ปรับความเร็วเอง"),
        Description = T("Walk speed and jump while on foot", "ความเร็วเดินและแรงกระโดดตอนเดิน"),
        Icon = "speed",
        Keybind = { Default = "None", Mode = "Toggle" },
        Callback = xDTaraZ.UI.Write("SpeedEnabled", function(on)
            if not on then xDTaraZ.Movement.ResetSpeed() end
        end),
        Options = function(options)
            options:AddSlider("WalkSpeed", { Text = T("Walk speed", "ความเร็วเดิน"), Icon = "speed", Min = 16, Max = 200, Default = opt.WalkSpeed, Rounding = 0, Callback = function(value) opt.WalkSpeed = tonumber(value) or opt.WalkSpeed end })
            options:AddSlider("JumpPower", { Text = T("Jump power", "แรงกระโดด"), Icon = "jump", Min = 50, Max = 300, Default = opt.JumpPower, Rounding = 0, Callback = function(value) opt.JumpPower = tonumber(value) or opt.JumpPower end })
        end,
    })
    move:AddToggle("Noclip", { Text = T("Noclip", "ทะลุวัตถุ"), Icon = "noclip", Callback = xDTaraZ.UI.Write("Noclip") })
    move:AddToggle("InfiniteJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด"), Icon = "infjump", Callback = xDTaraZ.UI.Write("InfiniteJump") })

    local world = tab:AddRightGroupbox(T("World", "โลก"), "sun")
    world:AddToggle("Fullbright", { Text = T("Fullbright", "สว่างเต็มจอ"), Icon = "fullbright", Callback = xDTaraZ.UI.Write("Fullbright", xDTaraZ.Movement.SetFullbright) })

    local server = tab:AddRightGroupbox(T("Server", "เซิร์ฟเวอร์"), "server")
    server:AddToggle("AntiAfk", { Text = T("Anti AFK", "กันหลุด AFK"), Icon = "antiafk", Callback = xDTaraZ.UI.Write("AntiAfk") })
    server:AddToggle("AutoRejoin", { Text = T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), Icon = "rejoin", Callback = xDTaraZ.UI.Write("AutoRejoin") })
    server:AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), Icon = "hop", Callback = xDTaraZ.UI.Spawn(xDTaraZ.Session.Hop) })
end

function xDTaraZ.UI.BuildVisuals(window)
    local tab = window:AddTab(T("Visuals", "การมองเห็น"), "esp", T("ATMs, players and drop-offs", "ATM ผู้เล่น และจุดส่งเงิน"))
    local esp = tab:AddLeftGroupbox(T("ESP", "ESP"), "esp")
    esp:AddToggle("EspAtm", { Text = T("ATMs", "ATM"), Description = T("Every ATM you can rob with its rarity", "ATM ที่ปล้นได้ทุกตู้พร้อมระดับ"), Icon = "money", Callback = xDTaraZ.UI.Write("EspAtm") })
    esp:AddToggle("EspCops", { Text = T("Players By Job", "ผู้เล่นตามอาชีพ"), Description = T("Blue = police, red = outlaw, orange = delivery", "น้ำเงิน = ตำรวจ, แดง = โจร, ส้ม = ส่งของ"), Icon = "players", Callback = xDTaraZ.UI.Write("EspCops") })
    esp:AddToggle("EspDropOff", { Text = T("Drop-off Points", "จุดส่งเงิน"), Description = T("Where outlaws cash out", "จุดที่โจรไปส่งเงิน"), Icon = "waypoint", Callback = xDTaraZ.UI.Write("EspDropOff") })
end

function xDTaraZ.UI.Live()
    local status = Library.Lib.Status
    local session = State.AtmSession
    status("StatusAtm", xDTaraZ.UI.AtmStatus, 1)
    status("StatusDrive", function()
        if not State.Opt.DriveFarm then return "Off", "Idle" end
        return "Driving", "Running"
    end, 1)
    status("StatusJob", function() return tostring(xDTaraZ.Jobs.Current() or "Citizen"), "Idle" end, 1)

    status("StatCash", xDTaraZ.Util.Cash, 1)
    status("StatRobbed", function() return session.Busted end, 1)
    status("StatWanted", function()
        local char = xDTaraZ.Player.Character()
        return char and char:GetAttribute("CurrencyEarned") or 0
    end, 1)
    status("StatCashedOut", function() return session.CashedOut end, 1)
    status("StatSpots", xDTaraZ.Atm.SpawnerCount, 5)

    Library:Every(1, function()
        while #State.Messages > 0 do
            Library:Notify("Driving Empire", table.remove(State.Messages, 1), 5)
        end
    end)
end

function xDTaraZ.UI.Build()
    local window = Library.Window
    xDTaraZ.UI.RegisterIcons()
    xDTaraZ.UI.BuildMain(window)
    xDTaraZ.UI.BuildFarm(window)
    xDTaraZ.UI.BuildRewards(window)

    window:AddTabSection(T("Misc", "อื่นๆ"))
    xDTaraZ.UI.BuildVehicle(window)
    xDTaraZ.UI.BuildTeleport(window)
    xDTaraZ.UI.BuildPlayer(window)
    xDTaraZ.UI.BuildVisuals(window)
    window:AddSettingsTab()
    xDTaraZ.UI.Live()
end

local function BuildInterface()
    Library = loadstring(xDTaraZ.Util.HttpGet(Config.UiSource))()
    MarioBanner.Step("UI library")
    T = function(en, th) return Library:T(en, th) end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    getgenv().DrivingEmpireUnload = function()
        Library:Unload()
    end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Driving Empire by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        Intro = true,
        OnUnlocked = function()
            xDTaraZ.UI.Build()
            xDTaraZ.Scheduler.Boot()
            xDTaraZ.UI.Notify("Loaded")
            Library:LoadAutoloadConfig()
        end,
    })
end

if getgenv().DrivingEmpireUnload then
    pcall(getgenv().DrivingEmpireUnload)
end

MarioBanner.Step("Systems")
BuildInterface()
MarioBanner.Step("Interface")
MarioBanner.Ready()