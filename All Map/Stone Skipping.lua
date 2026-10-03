if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765298801 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Stone Skipping only")
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
        "   STONE SKIPPING  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

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
    LoadTimeout = 30,
    RequireTimeout = 3,
    MaxFailures = 5,
    FailWindow = 10,
    AlertTries = 20,
    AlertDelay = 0.5,
    TickDelay = 0.2,
    GcRescan = 5,
    WalkTimeout = 15,
    ArriveRadius = 4,
    StallTime = 1.5,
    StallDistance = 1,
    HopStep = 6,
    HopDelay = 0.1,
    HopRange = 24,
    StandHeight = 3,
    PracticeStart = 4,
    ZoneBench = 120,
    CapNames = { Gc = "getgc", Upvalues = "getupvalue" },
    GatedFeatures = { "AutoFarm", "AutoBuyStone", "AutoRebirth", "AutoTravel", "AutoHatch", "AutoInventoryHatch", "AutoPotions", "AutoClaim" },
    StandLane = 10,
    ThrowTimeout = 30,
    ThrowStart = 3,
    PageTimeout = 10,
    OfflinePage = "OfflineEarningsOverlay",
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
    Codes = { "10KCCU", "SECRET", "WORLD4", "WORLD3", "5KCCU", "WELCOME" },
    PotionKinds = { "Skill", "Win", "Luck" },
    Needs = {
        AutoFarm = { "Worlds.Definitions", "Balance.TrainingPasses" },
        AutoBuyStone = { "Balance.Stones", "Worlds.Definitions" },
        AutoTravel = { "Worlds.Definitions" },
        AutoClaim = { "Balance.GiftRewards", "Balance.DailyRewards.Rewards" },
    },
}

xDTaraZ.State = {
    Alive = true,
    Connections = {},
    Requests = {},
    Messages = {},
    Failures = {},
    Halted = {},
    Status = "Idle",
    Throws = 0,
    WinsEarned = 0,
    SkillEarned = 0,
    EarnLog = {},
    Last = {},
    Benched = {},
    ZonesByWorld = {},
    LastHatch = 0,
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
        Potions = {},
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

xDTaraZ.GameLib = {}

---@return Instance?  the network folder; a renamed one is found by its Request + Event remotes
function xDTaraZ.GameLib.FindNetwork()
    local named = ReplicatedStorage:FindFirstChild("SkippingNetwork")
    if named then return named end
    for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
        if remote.Name == "Request" and remote:IsA("RemoteEvent") and remote.Parent:FindFirstChild("Event") then return remote.Parent end
    end
    return ReplicatedStorage:WaitForChild("SkippingNetwork", Config.LoadTimeout)
end

local Network = xDTaraZ.GameLib.FindNetwork()
local Shared = ReplicatedStorage:WaitForChild("Shared", Config.LoadTimeout)
local SharedConfig = Shared and Shared:WaitForChild("Config", Config.LoadTimeout)

xDTaraZ.GameLib.Request = Network and Network:WaitForChild("Request", Config.LoadTimeout)
xDTaraZ.GameLib.Event = Network and Network:WaitForChild("Event", Config.LoadTimeout)

---@return ModuleScript?  Shared.Config.<name>, or the first module with that name anywhere under Shared
function xDTaraZ.GameLib.Module(name)
    local direct = SharedConfig and SharedConfig:FindFirstChild(name)
    if direct then return direct end
    local found = Shared and Shared:FindFirstChild(name, true)
    return found and found:IsA("ModuleScript") and found or nil
end

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

---@return table?  nil when it is missing or this executor can't require it
function xDTaraZ.GameLib.Require(module)
    if not module then return nil end
    local ok, loaded = pcall(require, module)
    if ok then return loaded end
    local okAgain, again = xDTaraZ.GameLib.RequireAsGame(module)
    if okAgain then return again end
    warn("[StoneSkipping] require", module:GetFullName(), loaded)
    return nil
end

local GameLib = xDTaraZ.GameLib
GameLib.Balance = GameLib.Require(GameLib.Module("GameBalance"))
GameLib.Worlds = GameLib.Require(GameLib.Module("Worlds"))
GameLib.Ready = GameLib.Balance ~= nil and GameLib.Worlds ~= nil and GameLib.Request ~= nil

---@return table  option idx -> GameLib paths that are gone
function xDTaraZ.GameLib.Missing()
    local missing = {}
    for idx, paths in pairs(Config.Needs) do
        for _, path in ipairs(paths) do
            local node = GameLib
            for part in path:gmatch("[^.]+") do
                node = type(node) == "table" and node[part] or nil
            end
            if node == nil then
                missing[idx] = missing[idx] or {}
                table.insert(missing[idx], path)
            end
        end
    end
    return missing
end

xDTaraZ.StoneById = {}
do
    for _, stone in ipairs(GameLib.Balance and GameLib.Balance.Stones or {}) do
        xDTaraZ.StoneById[stone.Id] = stone
    end
end

xDTaraZ.WorldById = {}
do
    for _, world in ipairs(GameLib.Worlds and GameLib.Worlds.Definitions or {}) do
        xDTaraZ.WorldById[world.Id] = world
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

function xDTaraZ.Try(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[StoneSkipping]", err) end
    return ok, err
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
    warn("[StoneSkipping] menu:", text, detail or "")
    task.spawn(function()
        for _ = 1, Config.AlertTries do
            if pcall(StarterGui.SetCore, StarterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 }) then return end
            task.wait(Config.AlertDelay)
        end
    end)
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

---@param caps string|string[]  Library.Compat cap names
---@return boolean              false until the menu library is loaded
function xDTaraZ:Can(caps)
    return self.Compat ~= nil and self.Compat.Has(caps) == true
end

---@return string?  the game piece that failed to load, nil when all of them did
function xDTaraZ.GameLib.MissingPart()
    if not GameLib.Request then return "the game's request remote" end
    if not GameLib.Balance then return "the GameBalance module" end
    if not GameLib.Worlds then return "the Worlds module" end
    return nil
end

---@return string?, string?  English and Thai reason the farm features can't run here; nil when they can
function xDTaraZ:Unsupported()
    local part = GameLib.MissingPart()
    if part then
        return ("Can't load %s on this executor"):format(part), ("โหลด %s บน executor นี้ไม่ได้"):format(part)
    end
    if not self.Compat then return nil end
    local supported, cap = self.Compat.Has({ "Gc", "Upvalues" })
    if supported then return nil end
    local name = Config.CapNames[cap] or cap
    return ("Needs %s"):format(name), ("ต้องใช้ %s"):format(name)
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

xDTaraZ.Game.GetUpvalue = getupvalue or debug.getupvalue

function xDTaraZ.Game.Controller()
    local cached = xDTaraZ.Game.Cached
    if cached and type(rawget(cached, "BeginThrow")) == "function" then return cached end
    if not xDTaraZ:Can({ "Gc", "Upvalues" }) or osClock() - (State.Last.GcScan or -math.huge) < Config.GcRescan then return nil end
    State.Last.GcScan = osClock()
    for _, t in ipairs(getgc(true)) do
        if type(t) == "table" and type(rawget(t, "RedeemCode")) == "function" and type(rawget(t, "BeginThrow")) == "function" then
            local canThrow = xDTaraZ.Game.GetUpvalue(t.BeginThrow, 1)
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
    local profile = xDTaraZ.Game.GetUpvalue(xDTaraZ.Game.CanThrow, 3)
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

---@return boolean  false while the offline earnings page still blocks a throw
function xDTaraZ.Game.ClosePages()
    local hud = LocalPlayer.PlayerGui:FindFirstChild("SkippingHUD")
    if not hud then return true end
    local frames = hud:FindFirstChild("Frames")
    if frames and xDTaraZ:Can("Connections") then
        for _, overlay in ipairs(frames:GetChildren()) do
            if not (overlay:IsA("GuiObject") and overlay.Visible) then continue end
            local close = overlay:FindFirstChild("Close", true)
            if close and close:IsA("GuiButton") then
                for _, conn in ipairs(xDTaraZ.Compat.Api.GetConnections(close.Activated)) do conn:Fire() end
            end
        end
    end
    return xDTaraZ.Game.ClearOffline(hud:FindFirstChild(Config.OfflinePage, true))
end

---The offline page has no close button, only the free claim and a paid x10, so the free claim is what hides it.
function xDTaraZ.Game.ClearOffline(page)
    if not (page and page:IsA("GuiObject") and page.Visible) then return true end
    State.Status = "Claiming offline earnings"
    xDTaraZ:Send("ClaimOffline")

    local deadline = osClock() + Config.PageTimeout
    while page.Visible and osClock() < deadline do
        if not xDTaraZ.Scheduler.Live() then return false end
        task.wait(0.25)
    end
    if page.Visible then State.Status = "Offline earnings page is stuck open" end
    return not page.Visible
end

---@return boolean  false once this client refuses virtual clicks; it is not tried again
function xDTaraZ.Game.ClickReveal()
    if State.RevealBroken then return false end
    local cam = Workspace.CurrentCamera
    local size = cam and cam.ViewportSize or Vector2.new(800, 600)
    local ok, err = pcall(function()
        VirtualInputManager:SendMouseButtonEvent(size.X / 2, size.Y / 2, 0, true, game, 0)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(size.X / 2, size.Y / 2, 0, false, game, 0)
    end)
    if ok then return true end
    State.RevealBroken = true
    warn("[StoneSkipping] reveal click:", err)
    return false
end

---Clicks through the hatch reveal, or just waits it out when clicks don't work here.
function xDTaraZ.Game.SkipReveal()
    local deadline = osClock() + Config.HatchTimeout
    while xDTaraZ.Game.HatchActive() and osClock() < deadline and xDTaraZ.Scheduler.Live() do
        xDTaraZ.Game.ClickReveal()
        task.wait(Config.RevealClickGap)
    end
end

xDTaraZ.Move = {}

function xDTaraZ.Move.FlatGap(from, pos)
    return (from - vector3New(pos.X, from.Y, pos.Z)).Magnitude
end

---@return boolean  false on timeout or as soon as the character stops making progress
function xDTaraZ.Move.WalkTo(pos)
    local _, hum, hrp = xDTaraZ:Character()
    if not hum then return false end
    local deadline = osClock() + Config.WalkTimeout
    local mark, markedAt = hrp.Position, osClock()
    repeat
        hum:MoveTo(pos)
        task.wait(0.25)
        if xDTaraZ.Move.FlatGap(hrp.Position, pos) <= Config.ArriveRadius then return true end
        if (hrp.Position - mark).Magnitude > Config.StallDistance then
            mark, markedAt = hrp.Position, osClock()
        elseif osClock() - markedAt > Config.StallTime then
            return false
        end
    until osClock() > deadline or not xDTaraZ.Scheduler.Live() or hum.Health <= 0
    return false
end

---Covers the last few studs a walk can't (raised stands, fences) in short CFrame steps.
function xDTaraZ.Move.HopTo(pos)
    local _, _, hrp = xDTaraZ:Character()
    if not hrp or (hrp.Position - pos).Magnitude > Config.HopRange then return false end
    for _ = 1, math.ceil(Config.HopRange / Config.HopStep) + 1 do
        local offset = pos - hrp.Position
        if offset.Magnitude <= Config.ArriveRadius or not xDTaraZ.Scheduler.Live() then break end
        hrp.CFrame += offset.Magnitude > Config.HopStep and offset.Unit * Config.HopStep or offset
        hrp.AssemblyLinearVelocity = Vector3.zero
        task.wait(Config.HopDelay)
    end
    return xDTaraZ.Move.FlatGap(hrp.Position, pos) <= Config.ArriveRadius
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
    if xDTaraZ.Move.WalkTo(pos) then return true end
    return xDTaraZ.Move.HopTo(pos)
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
    return stand.Position + vector3New(0, stand.Size.Y / 2 + Config.StandHeight, 0)
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

function xDTaraZ.Train.CheckPasses()
    local passes = GameLib.Balance and GameLib.Balance.TrainingPasses
    for _, passId in pairs(passes or {}) do
        xDTaraZ.Train.OwnsPass(passId)
    end
end

---Each world carries its own bonuses and rebirth gates (World2 needs 30 rebirths for the zone World1 opens at 6).
---@return table[]  zones of the current world, best bonus first; empty until the world data is readable
function xDTaraZ.Train.Zones()
    local _, worldId = xDTaraZ.Game.World()
    local cached = State.ZonesByWorld[worldId]
    if cached then return cached end
    local world = xDTaraZ.WorldById[worldId]
    local practice = world and world.Practice
    local zones = {}
    if not practice then return zones end
    for name, bonus in pairs(practice.ZoneBonuses) do
        table.insert(zones, {
            Name = name,
            Bonus = bonus,
            Rebirths = practice.ZoneRequiredRebirths[name] or 0,
            Pass = GameLib.Balance.TrainingPasses[name],
        })
    end
    table.sort(zones, function(a, b) return a.Bonus > b.Bonus end)
    State.ZonesByWorld[worldId] = zones
    return zones
end

---@return string  the picked zone, or the best one this world has that needs no pass you lack, no more rebirths and did not just refuse training
function xDTaraZ.Train.BestZone()
    local data = xDTaraZ.Game.Profile()
    local rebirths = data and tonumber(data.Rebirths) or 0
    local best
    for _, zone in ipairs(xDTaraZ.Train.Zones()) do
        if rebirths < zone.Rebirths or not xDTaraZ.Move.ZoneSpot(zone.Name) then continue end
        if (State.Benched[zone.Name] or 0) > osClock() or not xDTaraZ.Train.OwnsPass(zone.Pass) then continue end
        if zone.Name == State.Opt.TrainZone then return zone.Name end
        best = best or zone.Name
    end
    return best or "TrainingZone"
end

---Waits for the game to start practice after reaching a stand; a stand that never starts it is benched and the character steps off so the next visit touches it fresh.
---@return boolean  true once the activity is Practice
function xDTaraZ.Train.AwaitPractice(name, spot)
    local deadline = osClock() + Config.PracticeStart
    while xDTaraZ.Game.Activity() ~= "Practice" do
        if not xDTaraZ.Scheduler.Live() then return false end
        if osClock() > deadline then
            State.Benched[name] = osClock() + Config.ZoneBench
            State.Status = "Stand did not start training, resetting"
            local laneX = xDTaraZ.Move.LaneX()
            local lane = laneX and vector3New(laneX, spot.Y, spot.Z)
            if lane and not xDTaraZ.Move.WalkTo(lane) then xDTaraZ.Move.HopTo(lane) end
            return false
        end
        task.wait(0.2)
    end
    return true
end

function xDTaraZ.Train.Step()
    local name = xDTaraZ.Train.BestZone()
    local spot = xDTaraZ.Move.ZoneSpot(name)
    if not spot then return end
    State.Status = "Training at " .. name:gsub("TrainingZone_?", ""):gsub("^$", "Basic")
    if xDTaraZ.Game.Activity() == "Practice" then return end
    if not xDTaraZ.Move.Travel(spot) then return end
    xDTaraZ.Train.AwaitPractice(name, spot)
end

xDTaraZ.Throw = {}

---@return boolean  true once the player stands idle on the launch zone with no game page in the way
function xDTaraZ.Throw.Ready()
    local spot = xDTaraZ.Move.LaunchSpot()
    if not spot then return false end
    State.Status = "Walking to throw zone"
    if not xDTaraZ.Move.Travel(spot) then return false end

    local deadline = osClock() + Config.ThrowTimeout
    while not xDTaraZ.Game.CanThrow() do
        if osClock() > deadline or not xDTaraZ.Scheduler.Live() then return false end
        task.wait(0.2)
    end
    xDTaraZ.Shop.IdleTasks()
    return xDTaraZ.Game.ClosePages()
end

function xDTaraZ.Throw.Once()
    local ctrl = xDTaraZ.Game.Controller()
    if not (ctrl and xDTaraZ.Throw.Ready()) then return false end

    local before = xDTaraZ.Game.Wins()
    State.Status = "Throwing"
    task.spawn(ctrl.BeginThrow)
    local started = osClock() + Config.ThrowStart
    while xDTaraZ.Game.Activity() ~= "Throw" do
        if osClock() > started or not xDTaraZ.Scheduler.Live() then return false end
        task.wait(0.1)
    end

    local deadline = osClock() + Config.ThrowTimeout
    while xDTaraZ.Game.Activity() == "Throw" and osClock() < deadline do
        if not xDTaraZ.Scheduler.Live() then return false end
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
    if mode == "Train" then
        xDTaraZ.Train.Step()
        return
    end
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
    if xDTaraZ:Can("Prompt") then
        fireproximityprompt(prompt)
    else
        prompt:InputHoldBegin()
        task.wait(prompt.HoldDuration)
        prompt:InputHoldEnd()
    end
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
        if count < 1 or not xDTaraZ.Scheduler.Live() then break end
        State.HatchId = (State.HatchId or 0) + 1
        xDTaraZ:Send("HatchEgg", { EggId = eggId, Count = count, RequestId = State.HatchId })
        State.LastHatch = osClock()
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
            State.LastHatch = osClock()
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

---@return string[]  known potion kinds plus any new kind found in your saved data
function xDTaraZ.Rewards.PotionKinds()
    local kinds = table.clone(Config.PotionKinds)
    local known = {}
    for _, kind in ipairs(kinds) do known[kind] = true end

    local data = xDTaraZ.Game.Profile()
    for kind in pairs(data and data.Potions or {}) do
        if not known[kind] then table.insert(kinds, kind) end
    end
    return kinds
end

function xDTaraZ.Rewards.RedeemAll()
    for _, code in ipairs(Config.Codes) do
        xDTaraZ:Send("RedeemCode", code)
        task.wait(1)
    end
    xDTaraZ:Notify(("Tried %d codes"):format(#Config.Codes))
end

xDTaraZ.Client = {}

function xDTaraZ.Client.Bind()
    if GameLib.Event then
        table.insert(State.Connections, GameLib.Event.OnClientEvent:Connect(function(action, info)
            if action == "CodeResult" or action == "GiftRewardResult" then
                local msg = type(info) == "table" and info.Message or info
                if msg ~= nil then table.insert(State.Messages, tostring(msg)) end
            elseif type(info) == "table" and (action == "Bounce" or action == "PracticeGain") then
                State.SkillEarned += tonumber(info.Skill) or 0
            end
        end))
    end

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
        State.BaseSpeed = nil
        xDTaraZ.Move.ApplySpeed()
    end))

    table.insert(State.Connections, GuiService.ErrorMessageChanged:Connect(function()
        if not State.Opt.AutoRejoin or State.Rejoining or GuiService:GetErrorMessage() == "" then return end
        State.Rejoining = true
        task.wait(Config.RejoinDelay)
        local ok, err = pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
        if ok then return end
        warn("[StoneSkipping] rejoin:", err)
        State.Rejoining = false
    end))

    table.insert(State.Connections, TeleportService.TeleportInitFailed:Connect(function(player, _, msg)
        if player ~= LocalPlayer or not State.Rejoining then return end
        warn("[StoneSkipping] rejoin failed:", msg)
        State.Rejoining = false
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
    LaunchTp = function()
        local pos = xDTaraZ.Move.LaunchSpot()
        if pos then xDTaraZ.Move.Travel(pos) end
    end,
    EggTp = function()
        local cheapest = xDTaraZ.Pets.EggList()[1]
        local eggId = xDTaraZ.Pets.PickEgg() or (cheapest and cheapest[1])
        local pos = eggId and xDTaraZ.Move.EggSpot(eggId)
        if pos then xDTaraZ.Move.Travel(pos) end
    end,
}

---Runs one round of a job; a toggle that keeps failing for Config.FailWindow seconds is switched off and queued for the UI to report.
---@param key string  State.Opt flag of the feature, or a plain label for jobs without one
function xDTaraZ.Scheduler.Run(key, fn)
    State.Running = key
    local ok, err = pcall(fn)
    State.Running = nil
    local failures = State.Failures
    if ok then
        failures[key] = nil
        return
    end

    local streak = failures[key]
    if not streak then
        streak = { count = 0, since = osClock() }
        failures[key] = streak
        warn("[StoneSkipping]", key, err)
    end
    streak.count += 1
    if streak.count < Config.MaxFailures or osClock() - streak.since < Config.FailWindow then return end
    if State.Opt[key] ~= true then return end

    failures[key] = nil
    State.Opt[key] = false
    local reason = tostring(err):match("[^\n]*")
    warn("[StoneSkipping]", key, "stopped:", reason)
    table.insert(State.Halted, { key, reason })
end

---@return boolean  false once the hub unloads or the running job's toggle is switched off
function xDTaraZ.Scheduler.Live()
    return State.Alive and State.Opt[State.Running or ""] ~= false
end

---@param stamp string  State.Last field holding the last run time
---@param key string    passed on to Run
function xDTaraZ.Scheduler.Every(stamp, key, interval, fn)
    if osClock() - (State.Last[stamp] or 0) < interval then return end
    State.Last[stamp] = osClock()
    xDTaraZ.Scheduler.Run(key, fn)
end

function xDTaraZ.Scheduler.Summarize()
    local data = xDTaraZ.Game.Profile()
    if not data then
        State.Summary = xDTaraZ:Unsupported() or "Waiting for game data..."
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
    xDTaraZ.Scheduler.Run("Summary", xDTaraZ.Scheduler.Summarize)
    if State.FarmRan and not opt.AutoFarm then
        State.FarmRan = false
        State.Status = "Idle"
    end

    for name, handler in pairs(xDTaraZ.Scheduler.RequestHandlers) do
        if State.Requests[name] then
            State.Requests[name] = nil
            xDTaraZ.Scheduler.Run(name, handler)
        end
    end

    local _, hum = xDTaraZ:Character()
    if not hum then return end
    if opt.SpeedOn and hum.WalkSpeed ~= opt.WalkSpeed then xDTaraZ.Move.ApplySpeed() end
    if xDTaraZ.Game.Activity() == "Throw" then return end
    if xDTaraZ.Game.HatchActive() then
        local asked = osClock() - State.LastHatch < Config.HatchTimeout
        if asked or opt.AutoHatch or opt.AutoInventoryHatch then xDTaraZ.Scheduler.Run("Reveal", xDTaraZ.Game.SkipReveal) end
        return
    end

    if opt.AutoClaim then xDTaraZ.Scheduler.Every("Claim", "AutoClaim", Config.ClaimInterval, xDTaraZ.Rewards.Claim) end
    if opt.AutoPotions then xDTaraZ.Scheduler.Every("Potion", "AutoPotions", Config.PotionInterval, xDTaraZ.Rewards.UsePotions) end
    if xDTaraZ.Game.Activity() == "Idle" then xDTaraZ.Scheduler.Every("Idle", "IdleTasks", Config.BuyInterval, xDTaraZ.Shop.IdleTasks) end
    if opt.AutoTravel then xDTaraZ.Scheduler.Every("Travel", "AutoTravel", Config.BuyInterval, xDTaraZ.Shop.Travel) end
    if opt.AutoInventoryHatch then xDTaraZ.Scheduler.Every("Inventory", "AutoInventoryHatch", Config.BuyInterval, xDTaraZ.Pets.HatchInventory) end
    if opt.AutoHatch then xDTaraZ.Scheduler.Every("Hatch", "AutoHatch", Config.BuyInterval, xDTaraZ.Pets.HatchShop) end
    if opt.AutoFarm then
        State.FarmRan = true
        xDTaraZ.Scheduler.Run("AutoFarm", xDTaraZ.Farm.Step)
    end
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
    local Library = xDTaraZ.Util.LoadLibrary()
    if not Library then return end
    xDTaraZ.Compat = Library.Compat
    pcall(MarioBanner.Step, "UI library")
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt
    local statusLabel, runLabel
    local gated = {}
    for _, key in ipairs(Config.GatedFeatures) do gated[key] = true end

    local function Notify(text, kind)
        Library:Notify("Stone Skipping", text, 4, kind or "Info")
    end

    local function Request(name)
        return function() State.Requests[name] = true end
    end

    local function Toggle(group, key, text, description, onChange)
        local toggle = group:AddToggle(key, {
            Text = text,
            Description = description,
            Default = opt[key],
            Callback = function(value)
                opt[key] = value
                if onChange then onChange(value) end
            end,
        })
        toggle.Info = toggle.Info or { Text = text }
        return toggle
    end

    local function Feature(group, key, text, description)
        return Toggle(group, key, text, description):AddKeyPicker(key .. "Key", { Default = "None", Mode = "Toggle" })
    end

    local function TitleOf(toggle, idx)
        local title = toggle and toggle.Row and toggle.Row.Title
        return title and title.Text or idx
    end

    local function ReportHalts()
        for _, halt in ipairs(State.Halted) do
            local toggle = Options[halt[1]]
            if toggle and toggle.Value then toggle:SetValue(false) end
            Notify(("%s stopped: %s"):format(TitleOf(toggle, halt[1]), halt[2]), "Warning")
        end
        table.clear(State.Halted)
    end

    local function BuildMain(window)
        window:AddTabSection(T("Main", "หลัก"))
        local MainTab = window:AddTab(T("Main", "หลัก"), "house", T("Status and all-in-one mode", "สถานะและโหมดทำทุกอย่าง"))

        local statusBox = MainTab:AddLeftGroupbox(T("Status", "สถานะ"), "star")
        statusLabel = statusBox:AddLabel(T("Loading...", "กำลังโหลด..."))
        runLabel = statusBox:AddLabel("-")

        local kaitunBox = MainTab:AddRightGroupbox(T("Kaitun", "ไก่ตัน"), "oneup")
        kaitunBox:AddToggle("Kaitun", {
            Text = T("Kaitun (All-in-one)", "ไก่ตัน (ทำทุกอย่าง)"),
            Description = T("Trains, throws, upgrades, rebirths and claims rewards by itself", "ฝึก ปาหิน อัปเกรด รีเบิร์ธ และรับรางวัลให้เอง"),
            NoSave = true,
            Callback = function(value)
                State.KaitunSet = State.KaitunSet or {}
                for _, key in ipairs({ "AutoFarm", "AutoBuyStone", "AutoRebirth", "AutoTravel", "AutoInventoryHatch", "AutoPotions", "AutoClaim", "AntiAfk" }) do
                    local toggle = Options[key]
                    if not toggle or toggle.Blocked or (gated[key] and xDTaraZ:Unsupported()) then continue end
                    if value and not opt[key] then
                        toggle:SetValue(true)
                        State.KaitunSet[key] = toggle.Value == true or nil
                    elseif not value and State.KaitunSet[key] then
                        State.KaitunSet[key] = nil
                        toggle:SetValue(false)
                    end
                end
            end,
        })
        kaitunBox:AddButton({ Text = T("Panic - All Off", "ฉุกเฉิน ปิดทั้งหมด"), Style = "Danger", Func = function()
            for idx, toggle in pairs(Library.Toggles) do
                if toggle.Value == true and not tostring(idx):find("^Mario") then toggle:SetValue(false) end
            end
        end })

        local discordBox = MainTab:AddLeftGroupbox(T("Discord", "Discord"), "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            local copy = setclipboard or toclipboard
            if copy then copy(Config.Discord) end
            Notify(copy and "Discord link copied" or Config.Discord)
        end })
    end

    local function BuildFarm(window)
        window:AddTabSection(T("Farming", "ฟาร์ม"))
        local FarmTab = window:AddTab(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "star", T("Throwing and training", "ปาหินและฝึก"))

        local farmBox = FarmTab:AddLeftGroupbox(T("Auto Farm", "ฟาร์มอัตโนมัติ"), "star")
        Feature(farmBox, "AutoFarm", T("Auto Farm", "ฟาร์มอัตโนมัติ"), T("Earns skill and wins without stopping", "ฟาร์ม Skill และ Wins ไม่หยุด"))
        farmBox:AddDropdown("FarmMode", {
            Text = T("Farm Mode", "โหมดฟาร์ม"),
            Description = T("Smart: throws for wins when needed, trains otherwise", "Smart: ปาหินเมื่อต้องใช้ Wins นอกนั้นฝึก Skill"),
            Values = { "Smart", "Train", "Throw" },
            Default = 1,
            Callback = function(value) opt.FarmMode = value or "Smart" end,
        })
        farmBox:AddButton({ Text = T("Throw Now", "ปาหินเดี๋ยวนี้"), Style = "Primary", Func = Request("ThrowNow") })

        local function ZoneNames()
            local names = { "Best" }
            for _, zone in ipairs(xDTaraZ.Train.Zones()) do
                if not zone.Pass or State.OwnedPasses[zone.Pass] == true then names[#names + 1] = zone.Name end
            end
            return names
        end

        local trainBox = FarmTab:AddRightGroupbox(T("Training", "ฝึก"), "target")
        local zoneDropdown = trainBox:AddDropdown("TrainZone", {
            Text = T("Training Zone", "โซนฝึก"),
            Description = T("Best = strongest zone you have unlocked", "Best = โซนที่ดีที่สุดที่ปลดล็อกแล้ว"),
            Values = ZoneNames(),
            Default = 1,
            Callback = function(value) opt.TrainZone = value or "Best" end,
        })
        trainBox:AddButton({ Text = T("Refresh Zones", "รีเฟรชรายการโซน"), Func = function()
            table.clear(State.OwnedPasses)
            xDTaraZ.Train.CheckPasses()
            zoneDropdown:SetValues(ZoneNames())
        end })
        task.spawn(function()
            xDTaraZ.Train.CheckPasses()
            zoneDropdown:SetValues(ZoneNames())
        end)
        trainBox:AddButton({ Text = T("Go Train Now", "ไปฝึกเดี๋ยวนี้"), Func = Request("TrainNow") })
    end

    local function BuildStones(window)
        window:AddTabSection(T("Progression", "ความคืบหน้า"))
        local ShopTab = window:AddTab(T("Stones & Rebirth", "หินและรีเบิร์ธ"), "shop", T("Stones, rebirth and worlds", "หิน รีเบิร์ธ และโลก"))

        local stoneBox = ShopTab:AddLeftGroupbox(T("Stones", "หิน"), "coin")
        Feature(stoneBox, "AutoBuyStone", T("Auto Buy Best Stone", "ซื้อหินดีสุดอัตโนมัติ"), T("Buys and equips the strongest stone you can afford", "ซื้อและใส่หินที่แรงที่สุดที่ซื้อไหว"))
        stoneBox:AddSlider("StoneReserve", {
            Text = T("Keep Wins", "กัน Wins ไว้"),
            Min = 0, Max = 100000, Default = 0, Rounding = 0,
            Callback = function(value) opt.StoneReserve = tonumber(value) or 0 end,
        })
        stoneBox:AddButton({ Text = T("Buy Best Stone Now", "ซื้อหินดีสุดเดี๋ยวนี้"), Func = Request("StoneNow") })

        local rebirthBox = ShopTab:AddRightGroupbox(T("Rebirth & Worlds", "รีเบิร์ธและโลก"), "flag")
        Feature(rebirthBox, "AutoRebirth", T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"), T("Rebirths as soon as your level is high enough", "รีเบิร์ธทันทีเมื่อเลเวลถึง"))
        rebirthBox:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Func = Request("RebirthNow") })
        Feature(rebirthBox, "AutoTravel", T("Auto Next World", "ไปโลกถัดไปอัตโนมัติ"), T("Moves to the next world once it is unlocked and this world's stones are done", "ย้ายไปโลกถัดไปเมื่อปลดล็อกและซื้อหินโลกนี้ครบแล้ว"))
        rebirthBox:AddButton({ Text = T("Next World Now", "ไปโลกถัดไปเดี๋ยวนี้"), Func = Request("TravelNow") })
    end

    local function EggNames()
        local names = { "Best" }
        for _, egg in ipairs(xDTaraZ.Pets.EggList()) do table.insert(names, egg[1]) end
        return names
    end

    local function BuildPets(window)
        local PetTab = window:AddTab(T("Pets & Rewards", "สัตว์เลี้ยงและรางวัล"), "mushroom", T("Eggs, potions, rewards and codes", "ไข่ ยา รางวัล และโค้ด"))

        local eggBox = PetTab:AddLeftGroupbox(T("Eggs", "ไข่"), "mushroom")
        Feature(eggBox, "AutoHatch", T("Auto Hatch", "ฟักไข่อัตโนมัติ"), T("Buys and hatches the selected egg with wins", "ซื้อและฟักไข่ที่เลือกด้วย Wins"))
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
        Feature(eggBox, "AutoInventoryHatch", T("Auto Open Inventory Eggs", "เปิดไข่ในกระเป๋าอัตโนมัติ"), T("Opens eggs from codes, gifts and daily rewards", "เปิดไข่ที่ได้จากโค้ด ของขวัญ และรางวัลรายวัน"))
        eggBox:AddButton({ Text = T("Open Inventory Egg Now", "เปิดไข่ในกระเป๋าเดี๋ยวนี้"), Func = Request("InventoryNow") })

        local rewardBox = PetTab:AddRightGroupbox(T("Rewards", "รางวัล"), "coin")
        Feature(rewardBox, "AutoClaim", T("Auto Claim", "รับรางวัลอัตโนมัติ"), T("Claims playtime gifts, daily, offline and group rewards", "รับของขวัญเวลาเล่น รางวัลรายวัน ออฟไลน์ และกลุ่ม"))
        rewardBox:AddButton({ Text = T("Claim Now", "รับเดี๋ยวนี้"), Func = Request("ClaimNow") })
        Feature(rewardBox, "AutoPotions", T("Auto Use Potions", "ใช้ยาอัตโนมัติ"), T("Keeps the selected boosts running", "เปิดบูสต์ที่เลือกไว้ตลอด"))
        local potionKinds = xDTaraZ.Rewards.PotionKinds()
        for _, kind in ipairs(potionKinds) do opt.Potions[kind] = true end
        rewardBox:AddDropdown("Potions", {
            Text = T("Potions", "ยา"),
            Values = potionKinds,
            Multi = true,
            Default = potionKinds,
            Callback = function(selected) opt.Potions = selected end,
        })
        rewardBox:AddButton({ Text = T("Use Potions Now", "ใช้ยาเดี๋ยวนี้"), Func = Request("PotionNow") })
        rewardBox:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Style = "Primary", Func = Request("CodesNow") })
    end

    local function BuildPlayer(window)
        window:AddTabSection(T("Misc", "อื่นๆ"))
        local PlayerTab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement and teleports", "การเคลื่อนที่และวาร์ป"))

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
    end

    local function BuildSettings(window)
        local settingsTab = window:AddSettingsTab()
        local sessionBox = settingsTab:AddRightGroupbox(T("Session", "เซสชัน"), "gear")
        Toggle(sessionBox, "AntiAfk", T("Anti AFK", "กันหลุด AFK"), T("Stops the idle kick", "กันโดนเตะเพราะไม่ขยับ"))
        Toggle(sessionBox, "AutoRejoin", T("Auto Rejoin", "เข้าเกมใหม่อัตโนมัติ"), T("Rejoins by itself after a disconnect", "หลุดแล้วเข้าเกมใหม่เอง"))
    end

    local function GateFeatures()
        for _, idx in ipairs(Config.GatedFeatures) do
            local toggle = Options[idx]
            if not toggle then continue end
            toggle:AddGuard(function(value)
                if value ~= true then return true end
                local en, th = xDTaraZ:Unsupported()
                if not en then return true end
                local title = TitleOf(toggle, idx)
                Library:Notify("Mario Hub", T(("%s: %s"):format(title, en), ("%s: %s"):format(title, th)), 4, "Warn")
                task.defer(toggle.SetValue, toggle, false)
                return false
            end)
        end
        for idx, paths in pairs(GameLib.Ready and GameLib.Missing() or {}) do
            warn("[StoneSkipping]", idx, "blocked, missing:", table.concat(paths, ", "))
            Library.Compat.Block(idx, T("Not available after a game update", "ใช้ไม่ได้หลังเกมอัปเดต"))
        end
        local en, th = xDTaraZ:Unsupported()
        if not en then return end
        Library:Notify("Stone Skipping", T(("Farming is off: %s. Movement still works."):format(en), ("ฟาร์มใช้ไม่ได้: %s ส่วนการเคลื่อนที่ยังใช้ได้"):format(th)), 10, "Error")
    end

    local function Live()
        Library:Every(1, function()
            ReportHalts()
            while #State.Messages > 0 do
                Notify(table.remove(State.Messages, 1))
            end
            if statusLabel then statusLabel:SetText(State.Summary or "-") end
            if runLabel then
                runLabel:SetText(("%s\nThrows %d · Wins +%s · Skill +%s"):format(State.Status, State.Throws, xDTaraZ.Format(State.WinsEarned), xDTaraZ.Format(State.SkillEarned)))
            end
        end)
    end

    local function BuildTabs()
        local window = Library.Window
        for _, build in ipairs({ BuildMain, BuildFarm, BuildStones, BuildPets, BuildPlayer, BuildSettings }) do
            xDTaraZ.Try(build, window)
        end
        xDTaraZ.Try(GateFeatures)
        xDTaraZ.Try(Live)
    end

    local function UnloadSelf()
        Library:Unload()
    end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    Library:OnUnload(function()
        if getgenv().StoneSkippingUnload == UnloadSelf then getgenv().StoneSkippingUnload = nil end
    end)
    getgenv().StoneSkippingUnload = UnloadSelf

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Stone Skipping by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            BuildTabs()
            xDTaraZ.Try(xDTaraZ.Scheduler.Boot)
            Notify("Loaded", "Success")
            xDTaraZ.Try(Library.LoadAutoloadConfig, Library)
        end,
    })
end

if getgenv().StoneSkippingUnload then
    pcall(getgenv().StoneSkippingUnload)
end

pcall(MarioBanner.Step, "Systems")
task.spawn(xDTaraZ.Train.CheckPasses)
BuildInterface()
pcall(MarioBanner.Step, "Interface")
pcall(MarioBanner.Ready)