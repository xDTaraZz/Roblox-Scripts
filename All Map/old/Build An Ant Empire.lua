if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10436530264 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Build An Ant Empire only")
    return
end

do
    local ok, env = pcall(getgenv)
    if ok and type(env) == "table" and type(env.AntEmpireUnload) == "function" then
        pcall(env.AntEmpireUnload)
    end
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
    if ok and type(renv) == "table" and type(renv.print) == "function" then MarioBanner.Print = renv.print end
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
        "   BUILD AN ANT EMPIRE  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
        "   executor: " .. executor .. "   //   player: " .. game:GetService("Players").LocalPlayer.Name,
        rule,
    }, "\n"))
end

---@param label string
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
    local function Passthrough(fn)
        return fn
    end
    LPH_JIT, LPH_JIT_MAX, LPH_NO_VIRTUALIZE = Passthrough, Passthrough, Passthrough
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    SaveFolder = "Build An Ant Empire",
    Discord = "https://discord.gg/FHVfmeSceA",
    GameId = 10436530264,
    PlaceId = 78490532994307,
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    UpdateLog = {
        { "2026-10-15", "Added Build An Ant Empire support\nKaitun, food farming and auto sell\nAuto roll, rarity filters and best ants\nPool and stat upgrades with a cash reserve\nMarioBanner and reliable Stop All" },
    },
    LoadTimeout = 10,
    RemoteTimeout = 8,
    RequireTimeout = 3,
    AlertTries = 12,
    AlertDelay = 0.5,
    TickDelay = 0.08,
    StatusInterval = 1.2,
    PumpInterval = 0.2,
    ReplyTimeout = 4,
    RollSlack = 0.08,
    MaxJobTime = 10,
    CodeGap = 10.2,
    Codes = { "10000members", "cyberants", "wnixh2", "9hcb2s" },
    Needs = {
        AutoSell = { "Packages.EventBus.RemoteEvent" },
        AutoPool = { "Packages.EventBus.RemoteEvent", "_genConfigs.battle_tbpoollevelupgrade" },
        AutoAttr = { "Packages.EventBus.RemoteEvent", "_genConfigs.battle_tbattribute" },
        AutoRoll = { "Packages.EventBus.RemoteEvent", "_genConfigs.battle_tbraritypool" },
        AutoEquipBest = { "UI.Backpack.Model.BackpackModel" },
        AutoOnlineAward = { "UI.OnlineReward.Model.OnlineState" },
        AutoActivity = { "Packages.EventBus.RemoteEvent", "_genConfigs.battle_tbactivityshop" },
        CodeRedeem = { "Packages.CodeService" },
    },
}

local Config = xDTaraZ.Config

xDTaraZ.State = {
    Alive = true,
    StopGen = 0,
    ThreadGenerations = setmetatable({}, { __mode = "k" }),
    Conns = {},
    Replies = {},
    InFlight = {},
    PendingRolls = {},
    Collision = {},
    Actions = {},
    UiQueue = {},
    Buttons = {},
    Metrics = { Rolls = 0, Claims = 0, Sales = 0, Gold = 0 },
    ChildThreads = {},
    Failures = {},
    Halted = {},
    StatusLines = {},
    FoodPrice = 0,
    PriceTime = 0,
    GearShop = nil,
    BossActive = false,
    SeenCodes = {},
    CodeResults = {},
    Opt = {
        KeepGold = 1000,
        SellMinPrice = 0,
        Kaitun = false,
        AutoSell = false,
        SellDelay = 1.5,
        AutoCollectFood = false,
        AutoWorkerFood = false,
        AutoAntRewards = false,
        UpgradePriority = "Pool first",
        ClaimRarities = {},
        AutoPool = false,
        PoolBurst = 5,
        AutoAttr = false,
        AttrTarget = "Ant Attack Power",
        UpgradeAllAttr = false,
        AutoRoll = false,
        AutoClaimRolled = false,
        RollDelay = 3.1,
        AutoEquipBest = false,
        AutoPlaceAnts = false,
        AutoCompostPull = false,
        AutoCompostUpgrade = false,
        AutoOnlineAward = false,
        AutoActivity = false,
        AutoLootBossCoins = false,
        SpeedOn = false,
        WalkSpeed = 200,
        FlyOn = false,
        FlySpeed = 120,
        NoclipOn = false,
        InfJump = false,
        AntiAfk = false,
        Fullbright = false,
        EspPlayers = false,
        EspBoss = false,
        EspDungeon = false,
        EspDist = 800,
    },
}

local State = xDTaraZ.State
local Library
local GuiService = game:GetService("GuiService")
xDTaraZ.Platform = {
    Touch = UserInputService.TouchEnabled,
    Mobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled,
    Console = GuiService:IsTenFootInterface(),
    Viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720),
}

xDTaraZ.GameLib = { Loaded = {}, Failed = {}, Apis = {}, Deferred = {} }

---@param module Instance
---@return boolean, any
function xDTaraZ.GameLib.RequireAsGame(module)
    local done, ok, loaded = false, false, nil
    local thread = xDTaraZ.Util.Child(function()
        pcall(setthreadidentity, 2)
        local read, identity = pcall(getthreadidentity)
        if read and identity == 2 then
            ok, loaded = pcall(require, module)
        end
        done = true
    end)
    local deadline = os.clock() + Config.RequireTimeout
    while not done and os.clock() < deadline do
        task.wait()
    end
    if not done then
        pcall(task.cancel, thread)
        return false, "module require timed out"
    end
    return ok, loaded
end

---@param module Instance
---@return table?
function xDTaraZ.GameLib.Require(module)
    if not module or not module:IsA("ModuleScript") then return nil end
    local cached = xDTaraZ.GameLib.Loaded[module]
    if cached ~= nil or xDTaraZ.GameLib.Failed[module] then
        return cached
    end

    local result
    local thread = xDTaraZ.Util.Child(function()
        result = table.pack(pcall(require, module))
    end)
    local deadline = os.clock() + Config.RequireTimeout
    while not result and os.clock() < deadline do
        task.wait()
    end
    if not result then
        pcall(task.cancel, thread)
        result = { false, "module require timed out" }
    end
    local ok, loaded = result[1], result[2]
    if not ok then
        local firstErr = loaded
        ok, loaded = xDTaraZ.GameLib.RequireAsGame(module)
        if not ok then
            xDTaraZ.GameLib.Failed[module] = tostring(firstErr)
            warn("[AntEmpire] require", module:GetFullName(), firstErr)
            return nil
        end
    end
    xDTaraZ.GameLib.Loaded[module] = loaded
    return loaded
end

---@param fn function
---@return boolean, any ...
function xDTaraZ.GameLib.CallAsGame(fn, ...)
    local args = table.pack(...)
    local box
    local thread = xDTaraZ.Util.Child(function()
        pcall(setthreadidentity, 2)
        box = table.pack(pcall(fn, table.unpack(args, 1, args.n)))
    end)
    local deadline = os.clock() + Config.RequireTimeout
    while not box and os.clock() < deadline do
        task.wait()
    end
    if not box then
        pcall(task.cancel, thread)
        return false, "game call timed out"
    end
    return table.unpack(box, 1, box.n)
end

---@param fn function
---@return any ...
function xDTaraZ.GameLib.Call(fn, ...)
    if not xDTaraZ.GameLib.Deferred[fn] then
        local result = table.pack(pcall(fn, ...))
        if result[1] or not tostring(result[2]):find("non-RobloxScript", 1, true) then
            if not result[1] then
                error(result[2], 0)
            end
            return table.unpack(result, 2, result.n)
        end
        xDTaraZ.GameLib.Deferred[fn] = true
    end
    local result = table.pack(xDTaraZ.GameLib.CallAsGame(fn, ...))
    if not result[1] then
        error(result[2], 0)
    end
    return table.unpack(result, 2, result.n)
end

---@param module Instance
---@return table
function xDTaraZ.GameLib.Need(module)
    local loaded = xDTaraZ.GameLib.Require(module)
    if loaded == nil then
        error(("game data %s.%s can't be read on this executor"):format(module.Parent.Name, module.Name), 0)
    end
    return loaded
end

---@param path string
---@return Instance?
function xDTaraZ.GameLib.Find(path)
    local node = ReplicatedStorage
    for part in path:gmatch("[^%.]+") do
        node = node and node:FindFirstChild(part)
    end
    if node then
        return node
    end
    return nil
end

---@return table
function xDTaraZ.GameLib.Missing()
    local missing = {}
    for idx, paths in pairs(Config.Needs) do
        for _, path in ipairs(paths) do
            if not xDTaraZ.GameLib.Find(path) then
                missing[idx] = missing[idx] or {}
                table.insert(missing[idx], path)
            end
        end
    end
    return missing
end

for _, name in ipairs({ "Util", "Data", "Player", "Colony", "Farm", "Economy", "Progression", "Shop", "Boss", "Rewards", "Movement", "Esp", "Scheduler", "Collect", "Teleport" }) do
    xDTaraZ[name] = {}
end

---@param fn function
---@return thread
function xDTaraZ.Util.Child(fn)
    for thread in pairs(State.ChildThreads) do
        if coroutine.status(thread) == "dead" then State.ChildThreads[thread] = nil end
    end
    local generation = State.StopGen
    local thread = task.defer(function()
        State.ThreadGenerations[coroutine.running()] = generation
        fn()
    end)
    State.ChildThreads[thread] = true
    return thread
end

function xDTaraZ:Connect(signal, fn)
    for index = #State.Conns, 1, -1 do
        if not State.Conns[index].Connected then table.remove(State.Conns, index) end
    end
    local conn = signal:Connect(fn)
    State.Conns[#State.Conns + 1] = conn
    return conn
end

function xDTaraZ.Util.Later(fn)
    State.UiQueue[#State.UiQueue + 1] = fn
end

function xDTaraZ.Util.Pump()
    local queued = State.UiQueue
    State.UiQueue = {}
    for _, fn in ipairs(queued) do xDTaraZ.Util.Try(fn) end
    if State.ActivityDropdown then xDTaraZ.Util.ActivityIcons() end
end

function xDTaraZ.Util.ActivityIcons()
    local dropdown = State.ActivityDropdown
    local sprites = xDTaraZ.Data.ActivitySprites
    if not dropdown or not sprites then return end
    local sprite = sprites[dropdown.Value]
    if dropdown.Thumb and sprite then
        dropdown.Thumb.ImageRectOffset = sprite.ImageRectOffset or Vector2.zero
        dropdown.Thumb.ImageRectSize = sprite.ImageRectSize or Vector2.zero
    end
    if dropdown.List == State.ActivityPopup then return end
    State.ActivityPopup = dropdown.List
    if not dropdown.List or not Library.Window or not Library.Window.Root.Parent then return end
    for _, image in ipairs(Library.Window.Root.Parent:QueryDescendants("ImageLabel")) do
        if image.Name == "Thumb" and image.Parent:IsA("TextButton") then
            local label = image.Parent:FindFirstChildWhichIsA("TextLabel")
            local entry = label and sprites[label.Text]
            if entry then
                image.ImageRectOffset = entry.ImageRectOffset or Vector2.zero
                image.ImageRectSize = entry.ImageRectSize or Vector2.zero
            end
        end
    end
end

function xDTaraZ.Util.Await(check, timeout)
    local deadline = os.clock() + (timeout or Config.ReplyTimeout)
    repeat
        if not State.Alive or not xDTaraZ.Util.Current() then return false end
        local value = check()
        if value then return value end
        task.wait(0.04)
    until os.clock() >= deadline
    return false
end

function xDTaraZ.Util.Current()
    local generation = State.ThreadGenerations[coroutine.running()]
    return generation == nil or generation == State.StopGen
end

function xDTaraZ.Util.Action(key, fn)
    if not State.Alive or not xDTaraZ.Util.Current() then return false end
    local owner = State.Actions[key]
    if owner and coroutine.status(owner) ~= "dead" then return false end
    State.Actions[key] = coroutine.running()
    local result = table.pack(pcall(fn))
    State.Actions[key] = nil
    if not result[1] then error(result[2], 0) end
    return table.unpack(result, 2, result.n)
end

function xDTaraZ.Util.Bounded(fn, timeout, ...)
    local args = table.pack(...)
    local result
    local thread = xDTaraZ.Util.Child(function()
        result = table.pack(pcall(fn, table.unpack(args, 1, args.n)))
    end)
    if not xDTaraZ.Util.Await(function() return result ~= nil end, timeout) then
        pcall(task.cancel, thread)
        return false, "Timed out"
    end
    return table.unpack(result, 1, result.n)
end

function xDTaraZ.Util.Button(group, info)
    local callback = info.Func
    local busy = false
    info.Func = function()
        if busy or not State.Alive then return end
        busy = true
        xDTaraZ.Util.Child(function()
            local ok, result = xDTaraZ.Util.Bounded(callback, Config.MaxJobTime)
            busy = false
            if not ok then
                xDTaraZ.Util.PushStatus("Action", tostring(result))
                xDTaraZ.Util.Later(function() Library:Notify("Mario Hub", tostring(result), 4, "Error") end)
            end
        end)
    end
    local button = group:AddButton(info)
    State.Buttons[#State.Buttons + 1] = button
    return button
end

---@param url string
---@return string?, string?
function xDTaraZ.Util.HttpGet(url)
    local ok, body = xDTaraZ.Util.Bounded(function()
        return game:HttpGet(url)
    end, Config.RemoteTimeout)
    if ok and type(body) == "string" and #body > 100 then
        return body, nil
    end

    local send = request or http_request or (syn and syn.request) or (http and http.request)
    if not send then
        return nil, tostring(body)
    end
    local sent, response = xDTaraZ.Util.Bounded(send, Config.RemoteTimeout, { Url = url, Method = "GET" })
    if not sent then
        return nil, tostring(response)
    end
    if type(response) ~= "table" or response.StatusCode ~= 200 or type(response.Body) ~= "string" then
        return nil, "HTTP " .. tostring(type(response) == "table" and response.StatusCode)
    end
    return response.Body, nil
end

---@param text string
---@param detail string?
function xDTaraZ.Util.Alert(text, detail)
    warn("[AntEmpire] menu:", text, detail or "")
    task.spawn(function()
        for _ = 1, Config.AlertTries do
            local shown = pcall(StarterGui.SetCore, StarterGui, "SendNotification", {
                Title = "Mario Hub",
                Text = text,
                Duration = 8,
            })
            if shown then return end
            task.wait(Config.AlertDelay)
        end
    end)
end

---@return table?
function xDTaraZ.Util.LoadLibrary()
    local body, err = xDTaraZ.Util.HttpGet(Config.UiSource)
    if not body or not body:sub(-64):find("return Library%s*$") then
        xDTaraZ.Util.Alert("Could not download menu. Check network connection.", err or "truncated body")
        return nil
    end
    local chunk, compileErr = loadstring(body)
    if not chunk then
        xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(compileErr))
        return nil
    end
    local ok, library = pcall(chunk)
    if not ok or type(library) ~= "table" then
        xDTaraZ.Util.Alert("The menu failed to initialize: " .. tostring(library))
        return nil
    end
    return library
end

---@param key string
---@param err any
function xDTaraZ.Util.WarnJob(key, err)
    State.Failures[key] = (State.Failures[key] or 0) + 1
    if State.Failures[key] >= 5 and not State.Halted[key] then
        State.Halted[key] = true
        local option = key == "Kaitun" and "KaitunMaster" or key
        State.Opt[key] = false
        if key == "AutoCompost" then State.Opt.AutoCompostPull, State.Opt.AutoCompostUpgrade = false, false end
        warn(string.format("[AntEmpire] %s stopped: %s", key, tostring(err)))
        xDTaraZ.Util.Later(function()
            if Library and Library.Options[option] then Library.Options[option]:SetValue(false) end
            if Library then Library:Notify("Mario Hub", key .. " stopped: " .. tostring(err), 5, "Error") end
        end)
    end
end

---@param fn function
---@return boolean, any
function xDTaraZ.Util.Try(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then
        warn("[AntEmpire]", err)
    end
    return ok, err
end

---@param key string
---@param text string?
function xDTaraZ.Util.PushStatus(key, text)
    State.StatusLines[key] = (text and text ~= "") and text or nil
end

---@return string
function xDTaraZ.Util.StatusText()
    local parts = {}
    for _, v in pairs(State.StatusLines) do
        parts[#parts + 1] = v
    end
    table.sort(parts)
    return #parts > 0 and table.concat(parts, "  |  ") or "Colony Active"
end

---@param text string
function xDTaraZ.Util.Clipboard(text)
    pcall(function()
        if setclipboard then
            setclipboard(text)
        elseif toclipboard then
            toclipboard(text)
        end
    end)
end

---@return Model?
function xDTaraZ.Util.GetChar()
    return LocalPlayer.Character
end

---@return BasePart?
function xDTaraZ.Util.GetHRP()
    if State.Root and State.Root.Parent then return State.Root end
    return nil
end

---@return Humanoid?
function xDTaraZ.Util.GetHum()
    if State.Humanoid and State.Humanoid.Parent then return State.Humanoid end
    return nil
end

local EventRE = xDTaraZ.GameLib.Find("Packages.EventBus.RemoteEvent")
if not EventRE then
    xDTaraZ.Util.Alert("Game connection is unavailable. Rejoin and try again.")
    return
end

xDTaraZ.GameLib.Apis.Context = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("UI._global.Ecs"))
xDTaraZ.GameLib.Apis.Context = xDTaraZ.GameLib.Apis.Context and xDTaraZ.GameLib.Apis.Context.Context
xDTaraZ.GameLib.Apis.PlayerData = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("UI._global.PlayerData"))
xDTaraZ.GameLib.Apis.Backpack = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("UI.Backpack.Model.BackpackModel"))
xDTaraZ.GameLib.Apis.Carry = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("Battle.Game.Helper.RoomHelper.FoodSellCarryState"))
xDTaraZ.GameLib.Apis.WuKong = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("WuKong"))
xDTaraZ.GameLib.Apis.Compost = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("UI.Compost.Model.CompostModel"))
xDTaraZ.GameLib.Apis.Activity = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("UI.ActivityEvent.Model.State"))
xDTaraZ.GameLib.Apis.Online = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("UI.OnlineReward.Model.OnlineState"))
xDTaraZ.GameLib.Apis.SevenDay = xDTaraZ.GameLib.Require(xDTaraZ.GameLib.Find("UI.7DAY.Model.SevenDayState"))

function xDTaraZ.Data.Snapshot()
    local playerData = xDTaraZ.GameLib.Apis.PlayerData
    return {
        Gold = playerData and tonumber(playerData.Gold) or 0,
        Food = playerData and tonumber(playerData.Food) or 0,
        PoolLevel = playerData and tonumber(playerData.PoolLevel) or 1,
        RollCount = playerData and tonumber(playerData.RollCount) or 0,
    }
end

function xDTaraZ.Colony.Room()
    local ctx = xDTaraZ.GameLib.Apis.Context
    return ctx and xDTaraZ.GameLib.Call(ctx.Helper.RoomHelper.GetLocalClientRoomObject)
end

function xDTaraZ.Util.Command(action, params, resultEvent)
    return xDTaraZ.Util.Action(action, function()
        local previous = State.Replies[resultEvent]
        xDTaraZ.Util.FireEcs(action, params)
        local reply = xDTaraZ.Util.Await(function()
            local current = State.Replies[resultEvent]
            return current ~= previous and current
        end)
        if not reply then
            xDTaraZ.Util.PushStatus(action, action .. ": no reply")
            return false, "No server reply"
        end
        local payload = reply.Payload
        local success = type(payload) == "table" and payload.Success == true
        local reason = type(payload) == "table" and (payload.Reason or (type(payload.Result) == "table" and payload.Result.Reason))
        if success then
            xDTaraZ.Util.PushStatus(action, nil)
        else
            xDTaraZ.Util.PushStatus(action, action .. ": " .. tostring(reason or "Rejected"))
        end
        return success, payload
    end)
end

do
    xDTaraZ.Data.Attributes = {}
    xDTaraZ.Data.AttributeNames = {}
    xDTaraZ.Data.AttributeMap = {}
    xDTaraZ.Data.PoolLevels = {}
    xDTaraZ.Data.PoolMaxLevel = 0
    xDTaraZ.Data.OnlineAwardCount = 0
    xDTaraZ.Data.GearShopRequestEvent = "GearShopRequest"
    xDTaraZ.Data.GearShopResultEvent = "GearShopResult"
    xDTaraZ.Data.GearShopSnapshotEvent = "GearShopSnapshot"

    local gen = ReplicatedStorage:FindFirstChild("_genConfigs")

    local attrMod = gen and gen:FindFirstChild("battle_tbattribute")
    if attrMod then
        local rawAttrs = xDTaraZ.GameLib.Require(attrMod)
        if type(rawAttrs) == "table" then
            local friendlyNames = {
                ["巢穴层数"] = "Nest Layers",
                ["单抽数量"] = "Roll Amount",
                ["蚂蚁攻击力"] = "Ant Attack Power",
                ["蚁后等级"] = "Ant Queen Level",
                ["蚂蚁移速"] = "Ant Move Speed",
                ["幸运值"] = "Lucky Value",
            }
            for key, attrDef in pairs(rawAttrs) do
                if type(attrDef) == "table" and attrDef.AttributeName then
                    local attrKey = attrDef.AttributeName
                    local friendly = friendlyNames[attrKey] or tostring(attrKey)
                    local maxLvl = type(attrDef.Info) == "table" and #attrDef.Info or 1
                    table.insert(xDTaraZ.Data.Attributes, {
                        Key = attrKey,
                        Name = friendly,
                        MaxLevel = maxLvl,
                    })
                    table.insert(xDTaraZ.Data.AttributeNames, friendly)
                    xDTaraZ.Data.AttributeMap[friendly] = attrKey
                end
            end
        end
    end
    local poolUpgradeMod = gen and gen:FindFirstChild("battle_tbpoollevelupgrade")
    if poolUpgradeMod then
        local rawLevels = xDTaraZ.GameLib.Require(poolUpgradeMod)
        if type(rawLevels) == "table" then
            local maxLvl = 1
            for _, v in pairs(rawLevels) do
                if type(v) == "table" and v.Level then
                    maxLvl = math.max(maxLvl, v.Level)
                end
            end
            xDTaraZ.Data.PoolMaxLevel = maxLvl
            xDTaraZ.Data.PoolLevels = rawLevels
        end
    end

    local awardMod = gen and gen:FindFirstChild("battle_tbonlineaward")
    if awardMod then
        local rawAwards = xDTaraZ.GameLib.Require(awardMod)
        if type(rawAwards) == "table" then
            local count = 0
            for _ in pairs(rawAwards) do
                count = count + 1
            end
            xDTaraZ.Data.OnlineAwardCount = count
        end
    end

    local gearShopCfg = ReplicatedStorage:FindFirstChild("Configs") and ReplicatedStorage.Configs:FindFirstChild("GearShopConfig")
    if gearShopCfg then
        local rawCfg = xDTaraZ.GameLib.Require(gearShopCfg)
        if type(rawCfg) == "table" then
            xDTaraZ.Data.GearShopRequestEvent = rawCfg.RequestEvent or "GearShopRequest"
            xDTaraZ.Data.GearShopResultEvent = rawCfg.ResultEvent or "GearShopResult"
            xDTaraZ.Data.GearShopSnapshotEvent = rawCfg.SnapshotEvent or "GearShopSnapshot"
        end
    end
end


do
    xDTaraZ.Data.ClaimRarities = {}
    local ctx = xDTaraZ.GameLib.Apis.Context
    local seen = {}
    for _, entry in pairs(ctx and ctx.Config.UnitConfig or {}) do
        if type(entry) == "table" and type(entry.Rarity) == "string" and not seen[entry.Rarity] then
            seen[entry.Rarity] = true
            xDTaraZ.Data.ClaimRarities[#xDTaraZ.Data.ClaimRarities + 1] = entry.Rarity
        end
    end
    table.sort(xDTaraZ.Data.ClaimRarities)
end

do
    local activity = xDTaraZ.GameLib.Apis.Activity
    xDTaraZ.Data.ActivityLabels, xDTaraZ.Data.ActivityIds = {}, {}
    xDTaraZ.Data.ActivityImages, xDTaraZ.Data.ActivityColors, xDTaraZ.Data.ActivitySprites = {}, {}, {}
    local spriteGroups = {}
    local assets = ReplicatedStorage:FindFirstChild("Assets")
    local sprites = assets and assets:FindFirstChild("sprites")
    if activity and sprites then
        for _, module in ipairs(sprites:GetChildren()) do
            if module:IsA("ModuleScript") then
                for group, entries in pairs(xDTaraZ.GameLib.Require(module) or {}) do
                    if type(entries) == "table" then
                        spriteGroups[group] = spriteGroups[group] or {}
                        for name, sprite in pairs(entries) do spriteGroups[group][name] = sprite end
                    end
                end
            end
        end
    end
    if activity then
        xDTaraZ.GameLib.Call(activity.Init, activity)
        for _, entry in ipairs(xDTaraZ.GameLib.Call(activity.GetShopCatalog, activity)) do
            local label = tostring(entry.DisplayName) .. " (" .. tostring(entry.Price) .. ")"
            xDTaraZ.Data.ActivityLabels[#xDTaraZ.Data.ActivityLabels + 1] = label
            xDTaraZ.Data.ActivityIds[label] = entry.ProductId
            local sprite = spriteGroups[entry.IconSpriteGroup] and spriteGroups[entry.IconSpriteGroup][entry.IconSpriteId]
            if type(sprite) == "table" and type(sprite.Image) == "string" then
                xDTaraZ.Data.ActivityImages[label] = sprite.Image
                xDTaraZ.Data.ActivitySprites[label] = sprite
            end
            local ui = assets and assets:FindFirstChild("UI")
            local gradient = ui and ui:FindFirstChild(tostring(entry.Rarity) .. "Gradient")
            if gradient and gradient:IsA("UIGradient") then xDTaraZ.Data.ActivityColors[label] = gradient.Color.Keypoints[1].Value end
        end
    end
end

---@param char Model
function xDTaraZ.Player.Bind(char)
    if State.CharacterConn then State.CharacterConn:Disconnect() end
    State.Character = char
    State.CharacterParts = {}
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then State.CharacterParts[part] = true end
    end
    State.CharacterConn = xDTaraZ:Connect(char.DescendantAdded, function(part)
        if part:IsA("BasePart") then State.CharacterParts[part] = true end
    end)
    State.Humanoid = char:WaitForChild("Humanoid", Config.LoadTimeout)
    State.Root = char:WaitForChild("HumanoidRootPart", Config.LoadTimeout)
    State.SpeedApplied, State.FlyApplied = false, false
    if State.Character ~= char then return end
    table.clear(State.Collision)
    if State.Humanoid then
        State.WalkSpeed = State.Humanoid.WalkSpeed
        State.PlatformStand = State.Humanoid.PlatformStand
        if State.Opt.SpeedOn then xDTaraZ.Movement.ApplySpeed() end
        if State.Opt.FlyOn then xDTaraZ.Movement.ApplyFly() end
    end
end

xDTaraZ:Connect(LocalPlayer.CharacterAdded, function(char)
    xDTaraZ.Util.Child(function() xDTaraZ.Player.Bind(char) end)
end)
if LocalPlayer.Character then xDTaraZ.Player.Bind(LocalPlayer.Character) end

---@param action string
---@param params table?
function xDTaraZ.Util.FireEcs(action, params)
    if not State.Alive or not xDTaraZ.Util.Current() or not EventRE or not EventRE.Parent then return false end
    local payload = table.clone(params or {})
    payload.UserId = payload.UserId or LocalPlayer.UserId
    EventRE:FireServer("ECS_COMMAND", action, payload)
    return true
end

---@return number
function xDTaraZ.Colony.GetRoomIndex()
    return LocalPlayer:GetAttribute("RoomIndex") or 1
end

function xDTaraZ.Colony.RollAnt()
    local ctx = xDTaraZ.GameLib.Apis.Context
    if not ctx then return false end
    local interval = xDTaraZ.GameLib.Call(ctx.Helper.PlayerDataHelper.GetPlayerRollInterval, ctx, LocalPlayer.UserId)
    local now = os.clock()
    if now < (State.NextRoll or 0) then return false end
    if next(State.PendingRolls) and (State.Opt.AutoClaimRolled or State.Opt.Kaitun) then
        xDTaraZ.Colony.ClaimPending()
    end
    if xDTaraZ.Colony.ClaimsInFlight() then return false end
    State.NextRoll = now + math.max(tonumber(interval) or 3, Config.RollSlack) + Config.RollSlack
    return xDTaraZ.Util.FireEcs("RollAnt", { Source = "RollModel" })
end

function xDTaraZ.Colony.ClaimsInFlight()
    for claimId, started in pairs(State.InFlight) do
        if os.clock() - started > Config.ReplyTimeout then State.InFlight[claimId] = nil end
    end
    return next(State.InFlight) ~= nil
end

function xDTaraZ.Colony.ClaimRolled(claimId)
    if not claimId or xDTaraZ.Colony.ClaimsInFlight() then return false end
    local spending = State.Actions.Spend
    if spending and coroutine.status(spending) ~= "dead" then return false end
    local offer = State.PendingRolls[claimId]
    if not offer then return false end
    if next(State.Opt.ClaimRarities) and not State.Opt.ClaimRarities[offer.Rarity] then return false end
    local gold = xDTaraZ.Data.Snapshot().Gold
    local cost = tonumber(offer.Cost)
    if not cost or cost ~= cost or cost < 0 or cost == math.huge then return false end
    if offer.Currency and offer.Currency ~= "金币" then return false end
    if cost > math.max(0, gold - State.Opt.KeepGold) then return false end
    State.InFlight[claimId] = os.clock()
    return xDTaraZ.Util.FireEcs("ClaimRolledAnt", { ClaimId = claimId })
end

function xDTaraZ.Colony.ClaimPending()
    if xDTaraZ.Colony.ClaimsInFlight() or not next(State.PendingRolls) then return end
    local offers = {}
    for claimId, offer in pairs(State.PendingRolls) do
        local backpack = xDTaraZ.GameLib.Apis.Backpack
        local entry = backpack and xDTaraZ.GameLib.Call(backpack.BuildEntry, backpack, {
            Ecs = { Context = xDTaraZ.GameLib.Apis.Context },
        }, "Backpack", offer.V, 1, 0)
        offers[#offers + 1] = { Id = claimId, Offer = offer, Attack = entry and entry.Attack or 0 }
    end
    table.sort(offers, function(a, b)
        if a.Attack ~= b.Attack then return a.Attack > b.Attack end
        return (a.Offer.Cost or 0) < (b.Offer.Cost or 0)
    end)
    for _, entry in ipairs(offers) do
        if xDTaraZ.Colony.ClaimRolled(entry.Id) then break end
    end
end

function xDTaraZ.Colony.QueueClaims()
    if not State.Alive or not (State.Opt.AutoClaimRolled or State.Opt.Kaitun) then return end
    local queued = State.ClaimThread
    if queued and coroutine.status(queued) ~= "dead" then return end
    State.ClaimThread = xDTaraZ.Util.Child(function()
        if not State.Alive or not xDTaraZ.Util.Current() then return end
        if State.Opt.AutoClaimRolled or State.Opt.Kaitun then
            xDTaraZ.Util.Try(xDTaraZ.Colony.ClaimPending)
        end
    end)
end

function xDTaraZ.Colony.EquipBest()
    return xDTaraZ.Util.Action("EquipBest", function()
        local backpack = xDTaraZ.GameLib.Apis.Backpack
        if not backpack then return false end
        return xDTaraZ.GameLib.Call(backpack.EquipBest, backpack)
    end)
end

function xDTaraZ.Colony.PlaceAnts()
    return xDTaraZ.Colony.EquipBest()
end

function xDTaraZ.Colony.CompostState()
    local model = xDTaraZ.GameLib.Apis.Compost
    if not model then return nil end
    return xDTaraZ.GameLib.Call(model.GetState, model, {
        PlayerData = xDTaraZ.GameLib.Apis.PlayerData,
        Ecs = { Context = xDTaraZ.GameLib.Apis.Context },
    })
end

function xDTaraZ.Colony.CompostPull()
    local info = xDTaraZ.Colony.CompostState()
    if not info or not info.CanPull then return false end
    return xDTaraZ.Util.Action("Compost", function()
        return xDTaraZ.Util.Command("CompostPullLever", {}, "CompostMachineResult")
    end)
end

function xDTaraZ.Colony.CompostUpgrade()
    local info = xDTaraZ.Colony.CompostState()
    if not info or not info.CanUpgrade or info.UpgradePrice > xDTaraZ.Data.Snapshot().Gold - State.Opt.KeepGold then return false end
    return xDTaraZ.Util.Action("Compost", function()
        return xDTaraZ.Util.Command("CompostUpgrade", {}, "CompostMachineResult")
    end)
end

function xDTaraZ.Farm.SellFood()
    return xDTaraZ.Util.Action("Sell", function()
        local carry = xDTaraZ.GameLib.Apis.Carry
        if not carry or (tonumber(carry.GetSnapshot().FoodAmount) or 0) <= 0 then return false end
        if State.Opt.SellMinPrice > 0 and (State.FoodPrice <= 0 or State.FoodPrice < State.Opt.SellMinPrice) then return false end
        local amount = carry.GetSnapshot().FoodAmount
        return xDTaraZ.Util.Command("SellPlayerFood", { FoodAmount = amount, Source = "PlayerFoodPrompt" }, "SellResuit")
    end)
end

function xDTaraZ.Farm.CollectFood()
    local carry = xDTaraZ.GameLib.Apis.Carry
    local food = xDTaraZ.Data.Snapshot().Food
    if not carry or food <= (tonumber(carry.GetSnapshot().FoodAmount) or 0) then return false end
    local room = xDTaraZ.Colony.Room()
    if not room then return false end
    return xDTaraZ.GameLib.Call(carry.SetSnapshot, {
        Source = "PlayerFoodPrompt", FoodAmount = food, RoomIndex = room.RoomIndex,
    })
end

function xDTaraZ.Farm.RequestPrice()
    return xDTaraZ.Util.FireEcs("RequestSellFoodPrice", { Source = "SellShopModel" })
end

function xDTaraZ.Progression.PoolCost()
    local current = xDTaraZ.Data.Snapshot().PoolLevel
    local info = xDTaraZ.Data.PoolLevels[current] or xDTaraZ.Data.PoolLevels[tostring(current)]
    if not info or not info.NextLevel then return nil end
    return tonumber(info.CostFood or info.Cost or info.FoodCost)
end

function xDTaraZ.Progression.UpgradePool()
    if xDTaraZ.Colony.ClaimsInFlight() then return false end
    local cost = xDTaraZ.Progression.PoolCost()
    if not cost or cost > xDTaraZ.Data.Snapshot().Gold - State.Opt.KeepGold then return false end
    return xDTaraZ.Util.Action("Spend", function()
        return xDTaraZ.Util.Command("PoolLevelUpgrade", {}, "PoolLevelUpgradeResult")
    end)
end

function xDTaraZ.Progression.AttributeInfo(attrName)
    local ctx = xDTaraZ.GameLib.Apis.Context
    if not ctx then return nil end
    local key = xDTaraZ.Data.AttributeMap[attrName] or attrName
    return xDTaraZ.GameLib.Call(ctx.Helper.PlayerDataHelper.GetPlayerUpgradeAttributeInfo, ctx, LocalPlayer.UserId, key)
end

function xDTaraZ.Progression.UpgradeAttribute(attrName)
    if xDTaraZ.Colony.ClaimsInFlight() then return false end
    return xDTaraZ.Util.Action("Spend", function()
        local info = xDTaraZ.Progression.AttributeInfo(attrName)
        if not info or info.IsMax or info.Price > xDTaraZ.Data.Snapshot().Gold - State.Opt.KeepGold then return false end
        return xDTaraZ.Util.Command("UpgradePlayerAttribute", { AttributeName = info.AttributeName }, "UpgradePlayerAttributeResult")
    end)
end

function xDTaraZ.Progression.UpgradeAll()
    local best, score
    for _, attr in ipairs(xDTaraZ.Data.Attributes) do
        local info = xDTaraZ.Progression.AttributeInfo(attr.Key)
        if info and not info.IsMax and info.Price <= xDTaraZ.Data.Snapshot().Gold - State.Opt.KeepGold then
            local gain = math.max(0, (tonumber(info.NextValue) or 0) - (tonumber(info.Value) or 0))
            local value = gain / math.max(1, math.abs(tonumber(info.Value) or 0)) / math.max(1, info.Price)
            if not score or value > score then best, score = attr.Key, value end
        end
    end
    if best then return xDTaraZ.Progression.UpgradeAttribute(best) end
    return false
end

function xDTaraZ.Rewards.ClaimOnline()
    return xDTaraZ.Util.Action("Online", function()
        local model = xDTaraZ.GameLib.Apis.Online
        if not model then return false end
        local index = xDTaraZ.GameLib.Call(model.GetFirstClaimableRewardIndex, model)
        if not index then return false end
        local before = LocalPlayer:GetAttribute("onlineaward")
        xDTaraZ.GameLib.Call(model.GetReward, model, index)
        return xDTaraZ.Util.Await(function() return LocalPlayer:GetAttribute("onlineaward") ~= before end)
    end)
end

function xDTaraZ.Shop.PurchaseActivity(id)
    return xDTaraZ.Util.Action("Activity", function()
        local model = xDTaraZ.GameLib.Apis.Activity
        if not model then return false end
        xDTaraZ.GameLib.Call(model.Init, model)
        local selected = id or State.Opt.ActivityItem
        if not selected then return false end
        local entry = xDTaraZ.GameLib.Call(model.GetShopEntry, model, selected)
        if not entry or entry.Price > (tonumber(model.WishCurrencyBalance) or 0) then return false end
        local previous = State.Replies.ActivityShopResult
        local sent = xDTaraZ.GameLib.Call(model.PurchaseShopItem, model, entry.ProductId)
        if not sent then return false end
        local reply = xDTaraZ.Util.Await(function()
            local current = State.Replies.ActivityShopResult
            return current ~= previous and current
        end)
        return reply and reply.Payload.Success == true or false
    end)
end

function xDTaraZ.Shop.RefreshGearSnapshot()
    EventRE:FireServer(xDTaraZ.Data.GearShopRequestEvent, { Action = "Snapshot" })
end

function xDTaraZ.Boss.LootCoins()
    local count = 0
    for prompt in pairs(State.CoinPrompts or {}) do
        if not prompt.Parent then
            State.CoinPrompts[prompt] = nil
        elseif Library and Library.Compat and Library.Compat.Has("Prompt") then
            fireproximityprompt(prompt)
            count += 1
        end
    end
    return count
end

---@param codeStr string
---@return boolean, string
function xDTaraZ.Rewards.RedeemCode(codeStr)
    local clean = string.lower(codeStr):gsub("^%s*(.-)%s*$", "%1")
    if clean == "" or State.SeenCodes[clean] then return false, "Already attempted" end
    local module = xDTaraZ.GameLib.Find("Packages.CodeService")
    local remote = module and module:FindFirstChild("RemoteFunction")
    if not remote then return false, "Code service unavailable" end
    local ok, success, message = xDTaraZ.Util.Bounded(function()
        return remote:InvokeServer("Redeem", clean)
    end, Config.RemoteTimeout)
    if not ok then return false, tostring(success) end
    if message == nil and type(success) == "string" then message, success = success, false end
    message = tostring(message or (success == true and "Redeemed" or "Rejected"))
    local retry = message:lower():match("try again in (%d+)")
    if not retry then State.SeenCodes[clean] = true end
    State.CodeResults[clean] = { Success = success == true, Message = message }
    return success == true, message, tonumber(retry)
end

function xDTaraZ.Rewards.RedeemAll()
    if State.Redeeming then return false end
    State.Redeeming = true
    State.CodeThread = xDTaraZ.Util.Child(function()
        for _, code in ipairs(Config.Codes) do
            if not State.Alive or not xDTaraZ.Util.Current() then break end
            local ok, message, retry = xDTaraZ.Rewards.RedeemCode(code)
            if retry then
                task.wait(retry + 0.2)
                if State.Alive and xDTaraZ.Util.Current() then ok, message = xDTaraZ.Rewards.RedeemCode(code) end
            end
            xDTaraZ.Util.PushStatus("Codes", code .. ": " .. tostring(message))
            if ok then State.Metrics.Codes = (State.Metrics.Codes or 0) + 1 end
            task.wait(Config.CodeGap)
        end
        State.Redeeming = false
    end)
    return true
end

function xDTaraZ.Movement.ApplySpeed()
    local hum = xDTaraZ.Util.GetHum()
    if hum then
        if State.Opt.SpeedOn then
            if not State.SpeedApplied then State.WalkSpeed = hum.WalkSpeed end
            hum.WalkSpeed = State.Opt.WalkSpeed
        elseif State.SpeedApplied then
            hum.WalkSpeed = State.WalkSpeed
        end
        State.SpeedApplied = State.Opt.SpeedOn
    end
end

local flyBodyVel, flyBodyGyro

function xDTaraZ.Movement.ApplyFly()
    local hrp = xDTaraZ.Util.GetHRP()
    local hum = xDTaraZ.Util.GetHum()
    if not hrp or not hum then return end

    if State.Opt.FlyOn then
        if not flyBodyVel or flyBodyVel.Parent ~= hrp then
            flyBodyVel = Instance.new("BodyVelocity")
            flyBodyVel.Velocity = Vector3.zero
            flyBodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            flyBodyVel.Parent = hrp
        end
        if not flyBodyGyro or flyBodyGyro.Parent ~= hrp then
            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            flyBodyGyro.CFrame = hrp.CFrame
            flyBodyGyro.Parent = hrp
        end
        if not State.FlyApplied then State.PlatformStand = hum.PlatformStand end
        State.FlyApplied = true
        hum.PlatformStand = true
    else
        if flyBodyVel then
            flyBodyVel:Destroy()
            flyBodyVel = nil
        end
        if flyBodyGyro then
            flyBodyGyro:Destroy()
            flyBodyGyro = nil
        end
        if State.FlyApplied then hum.PlatformStand = State.PlatformStand == true end
        State.FlyApplied = false
    end
end

xDTaraZ:Connect(RunService.RenderStepped, function()
    if not State.Alive then return end
    if State.Opt.FlyOn and flyBodyVel and flyBodyGyro then
        local hrp = xDTaraZ.Util.GetHRP()
        local cam = workspace.CurrentCamera
        if hrp and cam then
            local hum = xDTaraZ.Util.GetHum()
            local move = xDTaraZ.Platform.Touch and hum and hum.MoveDirection or Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end

            flyBodyVel.Velocity = move.Magnitude > 0 and (move.Unit * State.Opt.FlySpeed) or Vector3.zero
            flyBodyGyro.CFrame = cam.CFrame
        end
    end
end)

xDTaraZ:Connect(RunService.Stepped, function()
    if not State.Alive then return end
    if State.Opt.NoclipOn then
        local char = xDTaraZ.Util.GetChar()
        if char then
            for part in pairs(State.CharacterParts or {}) do
                if part.Parent and part.CanCollide then
                    if State.Collision[part] == nil then State.Collision[part] = part.CanCollide end
                    part.CanCollide = false
                end
            end
        end
    end
end)

xDTaraZ:Connect(UserInputService.JumpRequest, function()
    if State.Opt.InfJump then
        local hum = xDTaraZ.Util.GetHum()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local originalBrightness = Lighting.Brightness
local originalClockTime = Lighting.ClockTime
local originalFogEnd = Lighting.FogEnd
local originalShadows = Lighting.GlobalShadows

function xDTaraZ.Movement.ApplyFullbright()
    if State.Opt.Fullbright then
        if not State.LightApplied then
            originalBrightness, originalClockTime = Lighting.Brightness, Lighting.ClockTime
            originalFogEnd, originalShadows = Lighting.FogEnd, Lighting.GlobalShadows
        end
        State.LightApplied = true
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 1e6
        Lighting.GlobalShadows = false
    elseif State.LightApplied then
        State.LightApplied = false
        Lighting.Brightness = originalBrightness
        Lighting.ClockTime = originalClockTime
        Lighting.GlobalShadows = originalShadows
        Lighting.FogEnd = originalFogEnd
    end
end

State.CoinPrompts = {}
function xDTaraZ.Boss.TrackPrompt(instance)
    if instance:IsA("ProximityPrompt") and instance.Name == "ActivityCoinPrompt" then
        State.CoinPrompts[instance] = true
    end
end
for _, prompt in ipairs(workspace:QueryDescendants("ProximityPrompt")) do xDTaraZ.Boss.TrackPrompt(prompt) end
xDTaraZ:Connect(workspace.DescendantAdded, xDTaraZ.Boss.TrackPrompt)
xDTaraZ:Connect(workspace.DescendantRemoving, function(instance) State.CoinPrompts[instance] = nil end)
xDTaraZ:Connect(LocalPlayer.Idled, function()
    if not State.Alive or not State.Opt.AntiAfk then return end
    local virtualUser = game:GetService("VirtualUser")
    local ok, err = pcall(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.zero)
    end)
    if not ok then xDTaraZ.Util.WarnJob("AntiAfk", err) end
end)

function xDTaraZ.Teleport.Refresh()
    local points = {}
    local room = xDTaraZ.Colony.Room()
    if room and room.BaseGround then points["My Nest"] = room.BaseGround end
    for _, object in ipairs(workspace:GetChildren()) do
        if object.Name == "GearShop" or object.Name == "PetShop" or object.Name == "StrawberryKingPart" then
            points[object.Name] = object
        end
    end
    local entrances = workspace:FindFirstChild("DungeonEntrances")
    if entrances then
        for _, entry in ipairs(entrances:GetChildren()) do
            local target = entry:IsA("BasePart") and entry or entry:FindFirstChildWhichIsA("BasePart", true)
            if target then points["Dungeon " .. entry.Name] = target end
        end
    end
    State.TravelPoints = points
    local names = {}
    for name in pairs(points) do names[#names + 1] = name end
    table.sort(names)
    return names
end

function xDTaraZ.Teleport.Travel(name)
    return xDTaraZ.Util.Action("Travel", function()
        local hrp = xDTaraZ.Util.GetHRP()
        local target = State.TravelPoints and State.TravelPoints[name]
        if not hrp or not target or not target.Parent then return false end
        local pos = target:GetPivot().Position
        if workspace.StreamingEnabled then
            xDTaraZ.Util.Bounded(function() LocalPlayer:RequestStreamAroundAsync(pos) end, Config.RequireTimeout)
        end
        if not State.Alive or hrp ~= xDTaraZ.Util.GetHRP() then return false end
        State.ReturnCFrame = hrp.CFrame
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
        return true
    end)
end

function xDTaraZ.Teleport.Return()
    local hrp = xDTaraZ.Util.GetHRP()
    if not hrp or not State.ReturnCFrame then return false end
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.CFrame = State.ReturnCFrame
    State.ReturnCFrame = nil
    return true
end

function xDTaraZ.Esp.CreateHighlight(inst, color, fill)
    local highlight = Instance.new("Highlight")
    highlight.Name = "MarioEsp"
    highlight.Adornee = inst
    highlight.OutlineColor = color
    highlight.FillColor = fill
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = inst
    return highlight
end

function xDTaraZ.Esp.Clear()
    for target, highlight in pairs(State.EspObjects or {}) do
        highlight:Destroy()
        State.EspObjects[target] = nil
    end
end

function xDTaraZ.Esp.Update()
    local wanted = {}
    State.EspObjects = State.EspObjects or {}
    local myHrp = xDTaraZ.Util.GetHRP()
    local myPos = myHrp and myHrp.Position or Vector3.zero

    if State.Opt.EspBoss then
        local boss = workspace:FindFirstChild("StrawberryKing") or workspace:FindFirstChild("StrawberryKingPart")
        if boss then
            wanted[boss] = Color3.fromRGB(255, 60, 60)
        end
    end

    if State.Opt.EspDungeon then
        local entrances = workspace:FindFirstChild("DungeonEntrances")
        if entrances then
            for _, ent in ipairs(entrances:GetChildren()) do
                wanted[ent] = Color3.fromRGB(80, 200, 255)
            end
        end
    end

    if State.Opt.EspPlayers then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local pHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if pHrp and (pHrp.Position - myPos).Magnitude <= State.Opt.EspDist then
                    wanted[plr.Character] = Color3.fromRGB(100, 255, 100)
                end
            end
        end
    end
    for target, highlight in pairs(State.EspObjects) do
        if not target.Parent or not wanted[target] then
            highlight:Destroy()
            State.EspObjects[target] = nil
        end
    end
    for target, color in pairs(wanted) do
        if not State.EspObjects[target] then
            State.EspObjects[target] = xDTaraZ.Esp.CreateHighlight(target, color, color)
        end
    end
end

function xDTaraZ.Collect.ClaimDailyEvents()
    local model = xDTaraZ.GameLib.Apis.SevenDay
    if not model or not xDTaraZ.GameLib.Call(model.IsAward, model) then return false end
    return xDTaraZ.GameLib.Call(model.GetReward, model) == true
end

function xDTaraZ.Collect.ClaimAllOnlineAwards()
    local claimed = 0
    for _ = 1, xDTaraZ.Data.OnlineAwardCount do
        if not State.Alive or not xDTaraZ.Rewards.ClaimOnline() then break end
        claimed += 1
    end
    return claimed
end

function xDTaraZ.Collect.ClaimAllAntRewards()
    local room = xDTaraZ.Colony.Room()
    if not room then return false end
    local indices = {}
    for slot, ant in pairs(room.AntObjects or {}) do
        if ant.HasCarriedRewards and xDTaraZ.GameLib.Call(ant.HasCarriedRewards, ant) then
            indices[#indices + 1] = slot
        end
    end
    if #indices == 0 then return false end
    return xDTaraZ.Util.FireEcs("ClaimAntReward", { AntIndices = indices })
end

function xDTaraZ.Collect.ClaimAllWorkerFood()
    local room = xDTaraZ.Colony.Room()
    if not room then return false end
    local claims = {}
    for slot, ant in pairs(room.AntObjects or {}) do
        local amount = ant.info and tonumber(ant.info.Food) or 0
        if amount > 0 then claims[#claims + 1] = { SlotIndex = slot, Amount = math.floor(amount) } end
    end
    if #claims == 0 then return false end
    return xDTaraZ.Util.FireEcs("ClaimWorkerAntFood", { SubmissionId = HttpService:GenerateGUID(false), Claims = claims })
end

function xDTaraZ.Collect.UpgradeAllEquippedAnts()
    local room = xDTaraZ.Colony.Room()
    if not room then return 0 end
    local count = 0
    for slot in pairs(room.AntObjects or {}) do
        if not State.Alive then break end
        xDTaraZ.Util.FireEcs("UpgradeEquippedAnt", { AntIndex = slot })
        count += 1
    end
    return count
end

function xDTaraZ.Economy.Step()
    if State.Actions.Economy then return false end
    local auto = State.Opt.Kaitun
    return xDTaraZ.Util.Action("Economy", function()
        xDTaraZ.Collect.ClaimAllWorkerFood()
        xDTaraZ.Farm.CollectFood()
        if not State.Alive then return false end
        xDTaraZ.Farm.SellFood()
        if not State.Alive then return false end
        local poolCost = xDTaraZ.Progression.PoolCost()
        local balance = xDTaraZ.Data.Snapshot().Gold - State.Opt.KeepGold
        if auto and not State.Opt.Kaitun then return false end
        if State.Opt.UpgradePriority == "Stats first" and xDTaraZ.Progression.UpgradeAll() then
            xDTaraZ.Util.PushStatus("Progression", "Upgraded an affordable stat")
        elseif poolCost and balance >= poolCost then
            xDTaraZ.Progression.UpgradePool()
        elseif State.Opt.UpgradeAllAttr then
            xDTaraZ.Progression.UpgradeAll()
        else
            xDTaraZ.Progression.UpgradeAttribute(State.Opt.AttrTarget)
        end
        if not State.Alive or (auto and not State.Opt.Kaitun) then return false end
        xDTaraZ.Colony.ClaimPending()
        xDTaraZ.Colony.RollAnt()
        xDTaraZ.Colony.EquipBest()
        xDTaraZ.Rewards.ClaimOnline()
        return true
    end)
end

xDTaraZ:Connect(EventRE.OnClientEvent, function(event, data)
    if not State.Alive then return end
    State.Replies[event] = { At = os.clock(), Payload = data }
    if event == "RollAntResult" and type(data) == "table" and type(data.Results) == "table" then
        State.PendingRolls = {}
        State.Metrics.Rolls += 1
        for _, offer in ipairs(data.Results or {}) do
            if type(offer) == "table" and type(offer.ClaimId) == "string" then State.PendingRolls[offer.ClaimId] = offer end
        end
        xDTaraZ.Colony.QueueClaims()
    elseif event == "ClaimRolledAntResult" and type(data) == "table" and type(data.ClaimId) == "string" then
        local requested = State.InFlight[data.ClaimId] ~= nil
        State.InFlight[data.ClaimId] = nil
        if data.Success then
            State.PendingRolls[data.ClaimId] = nil
            if requested then State.Metrics.Claims += 1 end
            xDTaraZ.Colony.QueueClaims()
        elseif data.Reason == "Expired" or data.Reason == "Replaced" then
            State.PendingRolls[data.ClaimId] = nil
        elseif requested then
            State.InFlight[data.ClaimId] = os.clock()
        end
    elseif event == "SellResuit" and type(data) == "table" and data.Success then
        State.Metrics.Sales += 1
        State.Metrics.Gold += type(data.Result) == "table" and tonumber(data.Result.GoldAmount) or 0
    elseif event == "SellFoodPriceUpdate" and type(data) == "table" then
        if data.GoldPerFood then
            State.FoodPrice = data.GoldPerFood
            State.PriceTime = os.clock()
        end
    elseif event == "StrawberryKingState" and type(data) == "table" then
        State.BossActive = data.Active == true
    end
end)

local jobs = {
    { name = "AutoWorkerFood", interval = 0.5, last = 0, run = xDTaraZ.Collect.ClaimAllWorkerFood },
    { name = "AutoAntRewards", interval = 1, last = 0, run = xDTaraZ.Collect.ClaimAllAntRewards },
    {
        name = "Kaitun",
        interval = 1.0,
        last = 0,
        run = function()
            if not State.Opt.Kaitun then return end
            xDTaraZ.Economy.Step()
        end,
    },
    {
        name = "AutoSell",
        interval = 1.5,
        last = 0,
        run = function()
            if State.Opt.AutoSell and not State.Opt.Kaitun then
                xDTaraZ.Farm.SellFood()
            end
        end,
    },
    {
        name = "AutoCollectFood",
        interval = 2.0,
        last = 0,
        run = function()
            if State.Opt.AutoCollectFood and not State.Opt.Kaitun then
                xDTaraZ.Farm.CollectFood()
            end
        end,
    },
    {
        name = "AutoPool",
        interval = 4.0,
        last = 0,
        run = function()
            if State.Opt.AutoPool and not State.Opt.Kaitun then
                for _ = 1, State.Opt.PoolBurst do
                    if not State.Opt.AutoPool or not State.Alive then break end
                    if not xDTaraZ.Progression.UpgradePool() then break end
                end
            end
        end,
    },
    {
        name = "AutoAttr",
        interval = 2.0,
        last = 0,
        run = function()
            if State.Opt.AutoAttr and not State.Opt.Kaitun then
                if State.Opt.UpgradeAllAttr then
                    xDTaraZ.Progression.UpgradeAll()
                else
                    xDTaraZ.Progression.UpgradeAttribute(State.Opt.AttrTarget)
                end
            end
        end,
    },
    {
        name = "AutoRoll",
        interval = 0.15,
        last = 0,
        run = function()
            if State.Opt.AutoRoll and not State.Opt.Kaitun then
                xDTaraZ.Colony.RollAnt(nil)
            end
        end,
    },
    {
        name = "AutoEquipBest",
        interval = 5.0,
        last = 0,
        run = function()
            if State.Opt.AutoEquipBest and not State.Opt.Kaitun then
                xDTaraZ.Colony.EquipBest()
            end
        end,
    },
    {
        name = "AutoPlaceAnts",
        interval = 8.0,
        last = 0,
        run = function()
            if State.Opt.AutoPlaceAnts and not State.Opt.Kaitun then
                xDTaraZ.Colony.PlaceAnts()
            end
        end,
    },
    {
        name = "AutoCompost",
        interval = 5.0,
        last = 0,
        run = function()
            if State.Opt.AutoCompostPull then
                xDTaraZ.Colony.CompostPull()
            end
            if State.Opt.AutoCompostUpgrade then
                xDTaraZ.Colony.CompostUpgrade()
            end
        end,
    },
    {
        name = "AutoOnlineAward",
        interval = 30.0,
        last = 0,
        run = function()
            if State.Opt.AutoOnlineAward and not State.Opt.Kaitun then
                xDTaraZ.Collect.ClaimAllOnlineAwards()
            end
        end,
    },
    {
        name = "AutoActivity",
        interval = 60.0,
        last = 0,
        run = function()
            if State.Opt.AutoActivity and not State.Opt.Kaitun then
                xDTaraZ.Shop.PurchaseActivity(State.Opt.ActivityItem)
            end
        end,
    },
    {
        name = "AutoLootBossCoins",
        interval = 1.0,
        last = 0,
        run = function()
            if State.Opt.AutoLootBossCoins then
                xDTaraZ.Boss.LootCoins()
            end
        end,
    },
    {
        name = "EspUpdate",
        interval = 2.0,
        last = 0,
        run = function()
            if State.Opt.EspBoss or State.Opt.EspDungeon or State.Opt.EspPlayers then
                xDTaraZ.Esp.Update()
            end
        end,
    },
    {
        name = "PriceMonitor",
        interval = 10.0,
        last = 0,
        run = function()
            xDTaraZ.Farm.RequestPrice()
        end,
    },
    {
        name = "ClaimPending", interval = 0.15, last = 0,
        run = xDTaraZ.Colony.ClaimPending,
    },
}

local JobIndex = {}
for i, job in ipairs(jobs) do
    JobIndex[job.name] = job
end

function xDTaraZ.Scheduler.Enabled(name)
    if name == "Kaitun" then return State.Opt.Kaitun end
    if name == "ClaimPending" then return State.Opt.AutoClaimRolled or State.Opt.Kaitun end
    if name == "AutoCompost" then return State.Opt.AutoCompostPull or State.Opt.AutoCompostUpgrade end
    if name == "EspUpdate" then return State.Opt.EspBoss or State.Opt.EspDungeon or State.Opt.EspPlayers end
    if name == "PriceMonitor" then return State.Opt.AutoSell or State.Opt.Kaitun end
    return State.Opt[name] == true
end

function xDTaraZ.Scheduler.Boot()
    if State.SchedulerStarted then return end
    State.SchedulerStarted = true
    local acc = 0
    xDTaraZ:Connect(RunService.Heartbeat, function(dt)
        if not State.Alive then return end
        acc += dt
        if acc < Config.TickDelay then return end
        acc = 0
        local now = os.clock()
        for _, job in ipairs(jobs) do
            if job.busy and now - job.started > Config.MaxJobTime then
                if job.thread then pcall(task.cancel, job.thread) end
                job.busy = false
                xDTaraZ.Util.WarnJob(job.name, "deadline exceeded")
            end
            if xDTaraZ.Scheduler.Enabled(job.name) and not job.busy and not State.Halted[job.name] and now - job.last >= job.interval then
                job.last, job.started, job.busy = now, now, true
                job.thread = xDTaraZ.Util.Child(function()
                    local ok, err = pcall(job.run)
                    job.busy = false
                    if ok then
                        State.Failures[job.name] = 0
                    else
                        xDTaraZ.Util.WarnJob(job.name, err)
                    end
                end)
            end
        end
    end)
end

function xDTaraZ.Scheduler.Stop()
    State.StopGen += 1
    if State.ClaimThread and coroutine.status(State.ClaimThread) ~= "dead" then pcall(task.cancel, State.ClaimThread) end
    State.ClaimThread = nil
    if State.CodeThread and coroutine.status(State.CodeThread) ~= "dead" then pcall(task.cancel, State.CodeThread) end
    State.CodeThread, State.Redeeming = nil, false
    for key, value in pairs(State.Opt) do
        if type(value) == "boolean" then State.Opt[key] = false end
    end
    local current = coroutine.running()
    for _, job in ipairs(jobs) do
        if job.thread and job.thread ~= current and coroutine.status(job.thread) ~= "dead" then pcall(task.cancel, job.thread) end
        job.busy = false
    end
    xDTaraZ.Movement.ApplySpeed()
    xDTaraZ.Movement.ApplyFly()
    xDTaraZ.Movement.ApplyFullbright()
    for part, collide in pairs(State.Collision) do
        if part.Parent then part.CanCollide = collide end
    end
    table.clear(State.Collision)
    xDTaraZ.Esp.Clear()
    xDTaraZ.Util.Later(function()
        for index, option in pairs(Library.Options) do
            if (type(State.Opt[index]) == "boolean" or index == "KaitunMaster") and option.Value == true then option:SetValue(false) end
        end
    end)
end

local function BuildInterface()
    Library = xDTaraZ.Util.LoadLibrary()
    State.Library = Library
    if not Library then return end
    pcall(MarioBanner.Step, "UI library")

    local T = function(en, th)
        return Library:T(en, th)
    end

    Library:OnUnload(xDTaraZ.Unload)
    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Build An Ant Empire by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            local win = Library.Window
            win.Root:SetAttribute("MarioGameId", Config.GameId)
            win.Root:SetAttribute("MarioBuild", "2026-10-15.2")

            win:AddTabSection(T("Main", "หน้าหลัก"))
            local mainTab = win:AddTab(T("Main", "หน้าหลัก"), "home", T("Colony overview & Kaitun", "ภาพรวมอาณาจักรและไก่ตัน"))

            local statusGroup = mainTab:AddLeftGroupbox(T("Colony Status", "สถานะอาณาจักร"), "activity")
            local statusPara = statusGroup:AddLabel(T("Connecting to colony systems...", "กำลังเชื่อมต่อระบบ..."))

            local kaitunGroup = mainTab:AddLeftGroupbox(T("Kaitun Automation", "บอตไก่ตันอัตโนมัติ"), "bot", "OP")
            kaitunGroup:AddToggle("KaitunMaster", {
                Text = T("Autonomous Kaitun", "เปิดบอตไก่ตันครบวงจร"),
                Default = false,
                Description = T("Orchestrates food, summons, upgrades, and claims", "คุมการขายอาหาร สุ่มมด อัปเกรด และรับรางวัลอัตโนมัติ"),
                Callback = function(v) State.Opt.Kaitun = v end,
            })
            xDTaraZ.Util.Button(kaitunGroup, {
                Text = T("Run Kaitun Cycle Now", "รันไก่ตัน 1 รอบทันที"),
                Func = function()
                    xDTaraZ.Util.Child(xDTaraZ.Economy.Step)
                end,
            })

            xDTaraZ.Util.Button(kaitunGroup, { Text = T("Stop All", "หยุดทั้งหมด"), Func = xDTaraZ.Scheduler.Stop })

            local discordGroup = mainTab:AddRightGroupbox("Discord", "link")
            discordGroup:AddLabel(Config.Discord)
            xDTaraZ.Util.Button(discordGroup, {
                Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"),
                Func = function()
                    xDTaraZ.Util.Clipboard(Config.Discord)
                    xDTaraZ.Util.Later(function() Library:Notify("Mario Hub", "Discord link copied to clipboard", 5) end)
                end,
            })

            local updateGroup = mainTab:AddRightGroupbox(T("Update Log", "บันทึกอัปเดต"), "bell")
            for i = 1, math.min(2, #Config.UpdateLog) do
                updateGroup:AddParagraph({
                    Title = Config.UpdateLog[i][1],
                    Content = Config.UpdateLog[i][2],
                })
            end

            local actions = mainTab:AddRightGroupbox(T("Colony Actions", "จัดการรังมด"), "star")
            xDTaraZ.Util.Button(actions, { Text = T("Claim Ready Rewards Now", "รับรางวัลที่พร้อมทันที"), Func = function()
                xDTaraZ.Util.Child(function()
                    xDTaraZ.Collect.ClaimDailyEvents()
                    xDTaraZ.Collect.ClaimAllOnlineAwards()
                end)
            end })
            xDTaraZ.Util.Button(actions, { Text = T("Collect Ant Food Now", "เก็บอาหารจากมดทันที"), Func = function()
                xDTaraZ.Util.Child(xDTaraZ.Collect.ClaimAllWorkerFood)
            end })
            actions:AddToggle("AutoAntRewards", {
                Text = T("Auto Collect Ant Rewards", "เก็บรางวัลจากมดอัตโนมัติ"), Default = false,
                Callback = function(value) State.Opt.AutoAntRewards = value end,
            })
            xDTaraZ.Util.Button(actions, { Text = T("Collect Ant Rewards Now", "เก็บรางวัลจากมดทันที"), Func = function()
                xDTaraZ.Util.Child(xDTaraZ.Collect.ClaimAllAntRewards)
            end })
            kaitunGroup:AddDropdown("UpgradePriority", {
                Text = T("Upgrade Priority", "ลำดับการอัปเกรด"), Values = { "Pool first", "Stats first" }, Default = "Pool first",
                Callback = function(value) State.Opt.UpgradePriority = value end,
            })
            kaitunGroup:AddInput("KeepGold", {
                Text = T("Keep Cash", "เก็บเงินสำรอง"), Default = "1000", Numeric = true, Finished = true,
                Callback = function(value)
                    local amount = tonumber(value)
                    if amount and amount == amount and amount >= 0 and amount < math.huge then State.Opt.KeepGold = math.floor(amount) end
                end,
            })

            win:AddTabSection(T("Farming", "ฟาร์ม"))
            local farmTab = win:AddTab(T("Farm & Colony", "ฟาร์มและรังมด"), "leaf", T("Food production and ant recruitment", "การผลิตอาหารและการสุ่มมด"))

            local foodGroup = farmTab:AddLeftGroupbox(T("Food Economy", "เศรษฐกิจอาหาร"), "coins", "OP")
            foodGroup:AddToggle("AutoWorkerFood", {
                Text = T("Auto Collect Ant Food", "เก็บอาหารจากมดอัตโนมัติ"), Default = false,
                Callback = function(value) State.Opt.AutoWorkerFood = value end,
            })
            xDTaraZ.Util.Button(foodGroup, { Text = T("Collect Ant Food Now", "เก็บอาหารจากมดทันที"),
                Func = xDTaraZ.Collect.ClaimAllWorkerFood,
            })
            foodGroup:AddToggle("AutoSell", {
                Text = T("Auto Sell Food", "ขายอาหารอัตโนมัติ"),
                Default = false,
                Description = T("Exchanges carried food for gold automatically", "ขายอาหารที่ถือเป็นเงินอัตโนมัติ"),
                Callback = function(v) State.Opt.AutoSell = v end,
            })
            foodGroup:AddSlider("SellDelay", {
                Text = T("Sell Interval", "ระยะห่างการขาย"),
                Min = 0.5,
                Max = 10,
                Default = 1.5,
                Rounding = 1,
                Suffix = "s",
                Callback = function(v)
                    State.Opt.SellDelay = v
                    local sellJob = JobIndex["AutoSell"]
                    if sellJob then sellJob.interval = v end
                end,
            })
            foodGroup:AddSlider("SellMinPrice", {
                Text = T("Minimum Sell Price", "ราคาขายขั้นต่ำ"), Min = 0, Max = 2, Default = 0, Rounding = 2,
                Callback = function(value) State.Opt.SellMinPrice = value end,
            })
            xDTaraZ.Util.Button(foodGroup, {
                Text = T("Sell Food Now", "ขายอาหารทันที"),
                Func = function()
                    xDTaraZ.Farm.SellFood()

                end,
            })
            foodGroup:AddToggle("AutoCollectFood", {
                Text = T("Auto Collect Nest Food", "เก็บอาหารจากรังอัตโนมัติ"),
                Default = false,
                Description = T("Collects accumulated food from room storage", "เก็บอาหารสะสมจากจุดเก็บอาหารในห้อง"),
                Callback = function(v) State.Opt.AutoCollectFood = v end,
            })
            xDTaraZ.Util.Button(foodGroup, {
                Text = T("Collect Nest Food Now", "เก็บอาหารทันที"),
                Func = function()
                    xDTaraZ.Farm.CollectFood()

                end,
            })

            local compostGroup = farmTab:AddLeftGroupbox(T("Compost Machine", "เครื่องหมักปุ๋ย"), "recycle")
            compostGroup:AddToggle("AutoCompostPull", {
                Text = T("Auto Pull Compost Lever", "โยกคันโยกหมักปุ๋ยอัตโนมัติ"),
                Default = false,
                Description = T("Pulls compost lever to convert and claim rewards", "ดึงคันโยกเพื่อหมักปุ๋ยและรับเหรียญ"),
                Callback = function(v) State.Opt.AutoCompostPull = v end,
            })
            xDTaraZ.Util.Button(compostGroup, {
                Text = T("Pull Compost Lever Now", "โยกคันโยกทันที"),
                Func = function()
                    xDTaraZ.Colony.CompostPull()

                end,
            })
            compostGroup:AddToggle("AutoCompostUpgrade", {
                Text = T("Auto Upgrade Compost", "อัปเกรดเครื่องหมักปุ๋ยอัตโนมัติ"),
                Default = false,
                Description = T("Upgrades compost when eligible", "อัปเกรดขั้นเครื่องหมักปุ๋ยเมื่อเหรียญพอ"),
                Callback = function(v) State.Opt.AutoCompostUpgrade = v end,
            })
            xDTaraZ.Util.Button(compostGroup, {
                Text = T("Upgrade Compost Now", "อัปเกรดเครื่องหมักปุ๋ยทันที"),
                Func = function()
                    xDTaraZ.Colony.CompostUpgrade()
                    xDTaraZ.Util.Later(function() Library:Notify("Mario Hub", "Compost upgrade requested", 3) end)
                end,
            })

            local rollGroup = farmTab:AddRightGroupbox(T("Ant Summoning", "อัญเชิญมด"), "sparkles", "OP")
            rollGroup:AddToggle("AutoRoll", {
                Text = T("Auto Roll Ants", "สุ่มมดอัตโนมัติ"),
                Default = false,
                Description = T("Rolls when the next summon is ready", "สุ่มมดเมื่อพร้อมสุ่มครั้งต่อไป"),
                Callback = function(v) State.Opt.AutoRoll = v end,
            })
            rollGroup:AddDropdown("ClaimRarities", {
                Text = T("Claim Rarities (Empty = All)", "ระดับที่รับ (ว่าง = ทั้งหมด)"), Values = xDTaraZ.Data.ClaimRarities or {}, Multi = true, Default = {},
                Callback = function(value) State.Opt.ClaimRarities = value end,
            })
            rollGroup:AddToggle("AutoClaimRolled", {
                Text = T("Auto Claim Rolled Ants", "รับมดที่สุ่มได้ทันที"),
                Default = false,
                Description = T("Instantly claims ant without walking to pedestal", "รับมดเข้ากระเป๋าโดยไม่ต้องเดินไปกดที่แท่น"),
                Callback = function(v) State.Opt.AutoClaimRolled = v end,
            })
            xDTaraZ.Util.Button(rollGroup, { Text = T("Claim Rolled Ants Now", "รับมดที่สุ่มได้ทันที"),
                Func = function() xDTaraZ.Util.Child(xDTaraZ.Colony.ClaimPending) end,
            })
            rollGroup:AddSlider("RollDelay", {
                Text = T("Roll Delay", "คูลดาวน์การสุ่ม"),
                Min = 0.5,
                Max = 10,
                Default = 3.1,
                Rounding = 1,
                Suffix = "s",
                Callback = function(v)
                    State.Opt.RollDelay = v
                    local rollJob = JobIndex["AutoRoll"]
                    if rollJob then rollJob.interval = math.max(0.15, v) end
                end,
            })
            xDTaraZ.Util.Button(rollGroup, {
                Text = T("Roll Ant Now", "สุ่มมดทันที"),
                Func = function()
                    xDTaraZ.Colony.RollAnt(nil)

                end,
            })

            local colonyGroup = farmTab:AddRightGroupbox(T("Colony Management", "จัดการรังมด"), "users")
            colonyGroup:AddToggle("AutoEquipBest", {
                Text = T("Auto Equip Best Ants", "ใส่มดที่ดีที่สุดอัตโนมัติ"),
                Default = false,
                Description = T("Continuously optimizes equipped ants via game evaluator", "คัดเลือกและใส่มดพลังสูงสุดอัตโนมัติ"),
                Callback = function(v) State.Opt.AutoEquipBest = v end,
            })
            xDTaraZ.Util.Button(colonyGroup, {
                Text = T("Equip Best Ants Now", "ใส่มดที่ดีที่สุดทันที"),
                Func = function()
                    xDTaraZ.Colony.EquipBest()

                end,
            })
            colonyGroup:AddToggle("AutoPlaceAnts", {
                Text = T("Auto Place Ants into Nest", "วางมดลงรังอัตโนมัติ"),
                Default = false,
                Description = T("Fills empty nest slots with owned ants", "บรรจุมดลงในช่องรังที่ยังว่าง"),
                Callback = function(v) State.Opt.AutoPlaceAnts = v end,
            })
            xDTaraZ.Util.Button(colonyGroup, {
                Text = T("Place Ants into Nest Now", "วางมดลงรังทันที"),
                Func = function()
                    xDTaraZ.Colony.PlaceAnts()

                end,
            })

            win:AddTabSection(T("Progression", "พัฒนา"))
            local progTab = win:AddTab(T("Progression & Shop", "อัปเกรดและร้านค้า"), "trending-up", T("Stat upgrades, shops, and rewards", "อัปสเตตัส ร้านค้า และรางวัล"))

            local poolGroup = progTab:AddLeftGroupbox(T("Ant Pool Upgrade", "อัปเกรดตู้สุ่มมด"), "arrow-up-circle", "OP")
            poolGroup:AddToggle("AutoPool", {
                Text = T("Auto Upgrade Pool", "อัปเกรดตู้สุ่มอัตโนมัติ"),
                Default = false,
                Description = T("Upgrades the pool when cash allows", "เพิ่มระดับตู้สุ่มอัตโนมัติเมื่ออาหารพอ"),
                Callback = function(v) State.Opt.AutoPool = v end,
            })
            poolGroup:AddSlider("PoolBurst", {
                Text = T("Upgrade Burst", "จำนวนครั้งต่อรอบ"),
                Min = 1,
                Max = 10,
                Default = 5,
                Rounding = 0,
                Callback = function(v) State.Opt.PoolBurst = v end,
            })
            xDTaraZ.Util.Button(poolGroup, {
                Text = T("Upgrade Pool Now", "อัปเกรดตู้สุ่มทันที"),
                Func = function()
                    for _ = 1, State.Opt.PoolBurst do
                        xDTaraZ.Progression.UpgradePool()
                    end

                end,
            })

            local attrGroup = progTab:AddLeftGroupbox(T("Player Attributes", "อัปเกรดสเตตัสตัวละคร"), "shield")
            attrGroup:AddToggle("AutoAttr", {
                Text = T("Auto Upgrade Attributes", "อัปเกรดสเตตัสอัตโนมัติ"),
                Default = false,
                Description = T("Automatically buys stat upgrades using gold", "ใช้เงินอัปเกรดค่าพลังอัตโนมัติ"),
                Callback = function(v) State.Opt.AutoAttr = v end,
            })
            attrGroup:AddDropdown("AttrTarget", {
                Text = T("Target Stat", "สเตตัสเป้าหมาย"),
                Values = xDTaraZ.Data.AttributeNames,
                Default = xDTaraZ.Data.AttributeNames[1] or "Ant Attack Power",
                Callback = function(v) State.Opt.AttrTarget = v end,
            })
            attrGroup:AddToggle("UpgradeAllAttr", {
                Text = T("Auto Select Stat", "อัปเกรดทุกสเตตัสพร้อมกัน"),
                Default = false,
                Description = T("Selects the next affordable stat", "อัปเกรดสเตตัสครบทุกสาย"),
                Callback = function(v) State.Opt.UpgradeAllAttr = v end,
            })
            xDTaraZ.Util.Button(attrGroup, {
                Text = T("Upgrade Stat Now", "อัปเกรดสเตตัสทันที"),
                Func = function()
                    if State.Opt.UpgradeAllAttr then
                        xDTaraZ.Progression.UpgradeAll()
                    else
                        xDTaraZ.Progression.UpgradeAttribute(State.Opt.AttrTarget)
                    end

                end,
            })

            local shopGroup = progTab:AddRightGroupbox(T("Shops & Vendors", "ร้านค้าและกิจกรรม"), "shopping-bag")
            local activityDropdown = shopGroup:AddDropdown("ActivityItem", {
                Text = T("Activity Item", "สินค้ากิจกรรม"), Values = xDTaraZ.Data.ActivityLabels, Searchable = true,
                Callback = function(value) State.Opt.ActivityItem = xDTaraZ.Data.ActivityIds[value] end,
            })
            if activityDropdown.SetImages then
                activityDropdown:SetImages(xDTaraZ.Data.ActivityImages, xDTaraZ.Data.ActivityColors)
                State.ActivityDropdown = activityDropdown
            end
            shopGroup:AddToggle("AutoActivity", {
                Text = T("Auto Buy Activity Shop", "ซื้อร้านกิจกรรมอัตโนมัติ"),
                Default = false,
                Description = T("Purchases available stock from activity shop", "ซื้อไอเทมร้านกิจกรรมอัตโนมัติ"),
                Callback = function(v) State.Opt.AutoActivity = v end,
            })
            xDTaraZ.Util.Button(shopGroup, {
                Text = T("Buy Activity Items Now", "ซื้อไอเทมกิจกรรมทันที"),
                Func = function()
                    xDTaraZ.Shop.PurchaseActivity(State.Opt.ActivityItem)

                end,
            })
            xDTaraZ.Util.Button(shopGroup, {
                Text = T("Refresh Gear Shop Stock", "รีเฟรชสต็อกร้านอุปกรณ์"),
                Func = function()
                    xDTaraZ.Shop.RefreshGearSnapshot()

                end,
            })

            local rewardsGroup = progTab:AddRightGroupbox(T("Rewards & Codes", "รางวัลและโค้ด"), "gift")
            rewardsGroup:AddToggle("AutoOnlineAward", {
                Text = T("Auto Claim Online Awards", "รับรางวัลออนไลน์อัตโนมัติ"),
                Default = false,
                Description = T("Claims all eligible timed online reward slots", "กดรับของรางวัลตามเวลาออนไลน์อัตโนมัติ"),
                Callback = function(v) State.Opt.AutoOnlineAward = v end,
            })
            xDTaraZ.Util.Button(rewardsGroup, {
                Text = T("Claim Online Awards Now", "รับรางวัลออนไลน์ทันที"),
                Func = function()
                    xDTaraZ.Collect.ClaimAllOnlineAwards()

                end,
            })
            xDTaraZ.Util.Button(rewardsGroup, {
                Text = T("Redeem All Codes", "แลกโค้ดทั้งหมดทันที"),
                Func = function()
                    xDTaraZ.Rewards.RedeemAll()
                    xDTaraZ.Util.Later(function() Library:Notify("Mario Hub", "Checking code responses...", 5) end)
                end,
            })


            win:AddTabSection(T("Misc", "อื่นๆ"))
            local worldTab = win:AddTab(T("World & Visuals", "โลกและสายตา"), "swords", T("Bosses, teleports, and visual ESP", "บอส วาร์ป และระบบมองทะลุ"))

            local bossGroup = worldTab:AddLeftGroupbox(T("World Boss", "บอสโลก"), "flame", "OP")
            bossGroup:AddToggle("AutoLootBossCoins", {
                Text = T("Auto Loot Strawberry Coins", "เก็บเหรียญสตรอว์เบอร์รี่อัตโนมัติ"),
                Default = false,
                Description = T("Collects available strawberry coins", "เก็บเหรียญที่ดรอปจากบอสอัตโนมัติ"),
                Callback = function(v) State.Opt.AutoLootBossCoins = v end,
            })
            xDTaraZ.Util.Button(bossGroup, {
                Text = T("Loot Boss Coins Now", "เก็บเหรียญบอสทันที"),
                Func = function()
                    xDTaraZ.Boss.LootCoins()

                end,
            })
            local tpGroup = worldTab:AddLeftGroupbox(T("Teleports", "จุดวาร์ป"), "map-pin")
            local destination = tpGroup:AddDropdown("Destination", {
                Text = T("Destination", "จุดหมาย"), Values = {}, Searchable = true,
                Callback = function(value) State.Opt.Destination = value end,
            })
            xDTaraZ.Util.Button(tpGroup, { Text = T("Refresh Destinations", "รีเฟรชจุดวาร์ป"), Func = function()
                local names = xDTaraZ.Teleport.Refresh()
                xDTaraZ.Util.Later(function() destination:SetValues(names) end)
            end })
            xDTaraZ.Util.Button(tpGroup, { Text = T("Teleport Now", "วาร์ปทันที"), Func = function()
                return xDTaraZ.Teleport.Travel(State.Opt.Destination)
            end })
            xDTaraZ.Util.Button(tpGroup, { Text = T("Return Now", "กลับจุดเดิมทันที"), Func = xDTaraZ.Teleport.Return })
            xDTaraZ.Util.Child(function()
                local names = xDTaraZ.Teleport.Refresh()
                xDTaraZ.Util.Later(function() destination:SetValues(names) end)
            end)

            local espGroup = worldTab:AddRightGroupbox(T("Visuals & ESP", "สายตาและอีเอสพี"), "eye")
            espGroup:AddToggle("EspBoss", {
                Text = T("Boss ESP", "มองทะลุบอส"),
                Default = false,
                Description = T("Highlights Strawberry King boss and indicators", "แสดงกรอบเรืองแสงบอส Strawberry King"),
                Callback = function(v)
                    State.Opt.EspBoss = v
                    if not v then xDTaraZ.Esp.Clear() end
                end,
            })
            espGroup:AddToggle("EspDungeon", {
                Text = T("Dungeon ESP", "มองทะลุดันเจียน"),
                Default = false,
                Description = T("Highlights dungeon portal entrances", "แสดงประตูดันเจียน"),
                Callback = function(v)
                    State.Opt.EspDungeon = v
                    if not v then xDTaraZ.Esp.Clear() end
                end,
            })
            espGroup:AddToggle("EspPlayers", {
                Text = T("Player ESP", "มองทะลุผู้เล่น"),
                Default = false,
                Description = T("Highlights other players in range", "แสดงกรอบผู้เล่นคนอื่นในแมพ"),
                Callback = function(v)
                    State.Opt.EspPlayers = v
                    if not v then xDTaraZ.Esp.Clear() end
                end,
            })
            espGroup:AddSlider("EspDist", {
                Text = T("ESP Max Distance", "ระยะสูงสุด ESP"),
                Min = 100,
                Max = 2000,
                Default = 800,
                Rounding = 0,
                Suffix = " studs",
                Callback = function(v) State.Opt.EspDist = v end,
            })

            local perfGroup = worldTab:AddRightGroupbox(T("Utilities", "เครื่องมือช่วยเหลือ"), "sliders")
            perfGroup:AddToggle("Fullbright", {
                Text = T("Fullbright", "แสงสว่างเต็มที่"),
                Default = false,
                Description = T("Eliminates darkness and fog globally", "ปรับแสงให้สว่างทั่วแมพไม่มีหมอก"),
                Callback = function(v)
                    State.Opt.Fullbright = v
                    xDTaraZ.Movement.ApplyFullbright()
                end,
            })
            perfGroup:AddToggle("AntiAfk", {
                Text = T("Anti-AFK", "ป้องกันการหลุด AFK"),
                Default = false,
                Description = T("Prevents client disconnection from 20-minute idle", "ป้องกัน Roblox เตะเมื่อเปิดทิ้งไว้"),
                Callback = function(v) State.Opt.AntiAfk = v end,
            })
            xDTaraZ.Util.Button(perfGroup, {
                Text = T("Rejoin Server", "เข้าเซิร์ฟเดิมใหม่"),
                Func = function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
                end,
            })


            local playerTab = win:AddTab(T("Movement & Physics", "การเคลื่อนที่"), "user", T("Walkspeed, flying, and collision", "ความเร็วเดิน บิน และทะลุกำแพง"))

            local speedGroup = playerTab:AddLeftGroupbox(T("Walk & Sprint", "ความเร็วเดิน"), "zap")
            local speedToggle = speedGroup:AddToggle("SpeedOn", {
                Text = T("Walk Speed", "เพิ่มความเร็วการเดิน"),
                Default = false,
                Description = T("Modifies humanoid walk speed", "เพิ่มความเร็วเดินของตัวละคร"),
                Callback = function(v)
                    State.Opt.SpeedOn = v
                    xDTaraZ.Movement.ApplySpeed()
                end,
            })
            speedToggle:AddKeyPicker("SpeedKey", {
                Default = "None",
                SyncToggleState = true,
                Mode = "Toggle",
                Text = T("Speed Keybind", "ปุ่มความเร็ว"),
            })
            speedGroup:AddSlider("WalkSpeed", {
                Text = T("Speed Value", "ค่าความเร็ว"),
                Min = 16,
                Max = 350,
                Default = 200,
                Rounding = 0,
                Suffix = " ws",
                Callback = function(v)
                    State.Opt.WalkSpeed = v
                    xDTaraZ.Movement.ApplySpeed()
                end,
            })

            local flyGroup = playerTab:AddRightGroupbox(T("Flight", "การบิน"), "wind")
            local flyToggle = flyGroup:AddToggle("FlyOn", {
                Text = T("Fly Mode", "โหมดบิน"),
                Default = false,
                Description = T("Fly freely in all directions", "บินได้อย่างอิสระทุกทิศทาง"),
                Callback = function(v)
                    State.Opt.FlyOn = v
                    xDTaraZ.Movement.ApplyFly()
                end,
            })
            flyToggle:AddKeyPicker("FlyKey", {
                Default = "None",
                SyncToggleState = true,
                Mode = "Toggle",
                Text = T("Fly Keybind", "ปุ่มบิน"),
            })
            flyGroup:AddSlider("FlySpeed", {
                Text = T("Fly Speed", "ความเร็วบิน"),
                Min = 20,
                Max = 300,
                Default = 120,
                Rounding = 0,
                Suffix = " studs/s",
                Callback = function(v) State.Opt.FlySpeed = v end,
            })

            local physicsGroup = playerTab:AddLeftGroupbox(T("Physics & Collision", "ฟิสิกส์และการชน"), "shield")
            local noclipToggle = physicsGroup:AddToggle("NoclipOn", {
                Text = T("Noclip", "เดินทะลุกำแพง"),
                Default = false,
                Description = T("Pass through obstacles and walls", "เดินทะลุสิ่งกีดขวางและกำแพง"),
                Callback = function(v)
                    State.Opt.NoclipOn = v
                    if not v then
                        for part, collide in pairs(State.Collision) do
                            if part.Parent then part.CanCollide = collide end
                        end
                        table.clear(State.Collision)
                    end
                end,
            })
            noclipToggle:AddKeyPicker("NoclipKey", {
                Default = "None",
                SyncToggleState = true,
                Mode = "Toggle",
                Text = T("Noclip Keybind", "ปุ่มทะลุ"),
            })

            local infJumpToggle = physicsGroup:AddToggle("InfJump", {
                Text = T("Infinite Jump", "กระโดดไม่จำกัด"),
                Default = false,
                Description = T("Jump indefinitely in mid-air", "กระโดดกลางอากาศได้ตลอดเวลา"),
                Callback = function(v) State.Opt.InfJump = v end,
            })
            infJumpToggle:AddKeyPicker("InfJumpKey", {
                Default = "None",
                SyncToggleState = true,
                Mode = "Toggle",
                Text = T("Jump Keybind", "ปุ่มกระโดด"),
            })

            local charGroup = playerTab:AddRightGroupbox(T("Character Actions", "การจัดการตัวละคร"), "rotate-ccw")
            xDTaraZ.Util.Button(charGroup, {
                Text = T("Respawn Character", "เกิดใหม่ทันที"),
                Func = function()
                    local hum = xDTaraZ.Util.GetHum()
                    if hum then
                        hum.Health = 0
                    end
                end,
            })

            if Library.Compat then
                for index, paths in pairs(xDTaraZ.GameLib.Missing()) do
                    local option = Library.Options[index]
                    if option then Library.Compat.Block(option, "Missing game dependency: " .. table.concat(paths, ", ")) end
                end
                Library.Compat.NeedCap(Library.Options.AutoLootBossCoins, "Prompt")
                local dependencies = {
                    KaitunMaster = "Context", AutoRoll = "Context", AutoClaimRolled = "Context", AutoCollectFood = "Carry", AutoWorkerFood = "Context", AutoAntRewards = "Context",
                    AutoSell = "Carry", AutoEquipBest = "Backpack", AutoPlaceAnts = "Backpack",
                    AutoPool = "PlayerData", AutoAttr = "Context", AutoActivity = "Activity",
                    AutoOnlineAward = "Online", AutoCompostPull = "Compost", AutoCompostUpgrade = "Compost",
                }
                for index, api in pairs(dependencies) do
                    if not xDTaraZ.GameLib.Apis[api] then Library.Compat.Block(Library.Options[index], "Game data unavailable on this executor") end
                end
            end

            win:AddSettingsTab()

            xDTaraZ.Util.Try(xDTaraZ.Scheduler.Boot)
            pcall(MarioBanner.Step, "Interface")
            pcall(MarioBanner.Ready)
            Library:Every(Config.PumpInterval, xDTaraZ.Util.Pump)
            pcall(function() Library:LoadAutoloadConfig() end)

            xDTaraZ.Util.Child(function()
                while State.Alive and Library and Library.Window do
                    pcall(function()
                        local carriedFood = LocalPlayer:GetAttribute("CarriedSellFoodAmount") or 0
                        local maxSlots = LocalPlayer:GetAttribute("MaxAntSlots") or 1
                        local roomIdx = LocalPlayer:GetAttribute("RoomIndex") or 1
                        local nestLayer = LocalPlayer:GetAttribute("NestLayer") or 1
                        local txt = string.format("Room: %s  |  Nest Layer: %s  |  Ant Slots: %s  |  Carried Food: %s  |  Price: %s Gold",
                            tostring(roomIdx), tostring(nestLayer), tostring(maxSlots), tostring(carriedFood), tostring(State.FoodPrice))
                        local snapshot = xDTaraZ.Data.Snapshot()
                        txt = txt .. string.format("\nCash: %.0f | Food: %.0f | Earned: %.0f | Sales: %d | Claims: %d\n%s", snapshot.Gold, snapshot.Food, State.Metrics.Gold, State.Metrics.Sales, State.Metrics.Claims, xDTaraZ.Util.StatusText())
                        xDTaraZ.Util.Later(function() statusPara:SetText(txt) end)
                    end)
                    task.wait(Config.StatusInterval)
                end
            end)
        end,
    })

end

function xDTaraZ.Unload()
    if not State.Alive then return end
    State.Alive = false
    for _, conn in ipairs(State.Conns) do conn:Disconnect() end
    table.clear(State.Conns)
    local current = coroutine.running()
    for thread in pairs(State.ChildThreads) do
        if thread ~= current and coroutine.status(thread) ~= "dead" then pcall(task.cancel, thread) end
    end
    table.clear(State.ChildThreads)
    State.Opt.SpeedOn, State.Opt.FlyOn, State.Opt.NoclipOn, State.Opt.Fullbright = false, false, false, false
    xDTaraZ.Movement.ApplySpeed()
    xDTaraZ.Movement.ApplyFly()
    xDTaraZ.Movement.ApplyFullbright()
    for part, collide in pairs(State.Collision) do
        if part.Parent then part.CanCollide = collide end
    end
    xDTaraZ.Esp.Clear()
    if Library then pcall(Library.Unload, Library) end
    local ok, env = pcall(getgenv)
    if ok and env.AntEmpireUnload == xDTaraZ.Unload then env.AntEmpireUnload = nil end
end

do
    local ok, env = pcall(getgenv)
    if ok and type(env) == "table" then env.AntEmpireUnload = xDTaraZ.Unload end
end

pcall(MarioBanner.Step, "Systems")
BuildInterface()