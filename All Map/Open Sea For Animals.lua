if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765091041 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub : this script is for Open Sea For Animals only")
    return
end

local MarioBanner = {
    Print = print,
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
        "   OPEN SEA FOR ANIMALS  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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

do
    local ok, renv = pcall(getrenv)
    if ok and type(renv) == "table" and type(renv.print) == "function" then
        MarioBanner.Print = renv.print
    end
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
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    SaveFolder = "Open Sea For Animals",
    LoadTimeout = 10,
    AlertTries = 20,
    AlertRetry = 0.5,
    JobFailLimit = 5,
    JobFailWindow = 10,
    TickDelay = 0.25,
    LootWorkers = 3,
    WaveExtension = 5,
    LootIdle = 1,
    ResumeInterval = 0.5,
    ResumeBackoff = 30,
    InventoryLimit = 200,
    PlotRecheck = 30,
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
    Halted = {},
    Summary = "Loading...",
    StartCash = nil,
    Looted = 0,
    LootFull = nil,
    LootReserved = 0,
    Resume = { last = 0, fails = 0, retryAt = 0 },
    SpeedBase = nil,
    PlotFull = nil,
    Trained = false,
    SpeedPinned = false,
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

xDTaraZ.GameLib = {}
local GameLib = xDTaraZ.GameLib

---Plain require first; identity-3 executors get "Cannot require a non-RobloxScript module", so retry once from a fresh identity-2 thread.
---@return table?  module, nil when this executor cannot load it
function GameLib.Require(module)
    if not module or not module:IsA("ModuleScript") then return nil end
    local ok, loaded = pcall(require, module)
    if ok then return loaded end
    local setIdentity = setthreadidentity or setidentity
    local getIdentity = getthreadidentity or getidentity
    if type(setIdentity) ~= "function" or type(getIdentity) ~= "function" then
        warn("[OpenSea] require " .. module.Name .. ":", loaded)
        return nil
    end
    local done, retried = false, nil
    task.spawn(function()
        pcall(setIdentity, 2)
        local again, value = false, nil
        if select(2, pcall(getIdentity)) == 2 then again, value = pcall(require, module) end
        done, retried = true, again and value or nil
    end)
    local deadline = os.clock() + Config.LoadTimeout
    repeat
        if not done then task.wait() end
    until done or os.clock() > deadline
    if not retried then warn("[OpenSea] require " .. module.Name .. ":", loaded) end
    return retried
end

do
    local packages = ReplicatedStorage:WaitForChild("Packages", Config.LoadTimeout)
    local configs = ReplicatedStorage:WaitForChild("Configs", Config.LoadTimeout)
    local function Load(name)
        return GameLib.Require(configs and configs:FindFirstChild(name))
    end

    GameLib.Knit = GameLib.Require(packages and packages:WaitForChild("Knit", Config.LoadTimeout))
    GameLib.Eggs = Load("EggsConfig")
    GameLib.Brainrots = Load("BrainrotsConfig")
    GameLib.Rarities = Load("RaritiesConfig")
    GameLib.Mutations = Load("MutationConfig")
    GameLib.Sizes = Load("SizeConfig")
    GameLib.Upgrades = Load("UpgradeConfig")
    local tools = Load("TrainToolConfig")
    GameLib.TrainTools = tools and tools.TRAIN_TOOLS
    GameLib.PlayerStates = Load("PlayerStateConfig")
    GameLib.Modifiers = GameLib.Require(ReplicatedStorage:FindFirstChild("Modifiers"))
end

do
    local describe = { "Knit", "Eggs", "Brainrots", "Mutations", "Sizes" }
    local score = { "Knit", "Eggs", "Brainrots", "Mutations", "Sizes", "Rarities" }
    GameLib.Needs = {
        Kaitun = { "Knit" },
        AutoLoot = score,
        AutoHatch = score,
        AutoEquipBest = { "Knit" },
        AutoSellEggs = describe,
        AutoSellBrainrots = { "Knit" },
        AutoUpgrade = { "Knit", "Upgrades" },
        AutoTrain = { "Knit" },
        AutoBuyTool = { "Knit", "TrainTools" },
        AutoRebirth = { "Knit" },
        AutoClaim = { "Knit" },
    }
end

---@return string?  first game module the feature needs that did not load
function GameLib.Missing(idx)
    for _, name in ipairs(GameLib.Needs[idx] or {}) do
        if not GameLib[name] then return name end
    end
    return nil
end

for _, name in ipairs({ "Util", "Data", "Loot", "Sell", "Progress", "Claim", "Hatch", "Movement", "Scheduler" }) do
    xDTaraZ[name] = {}
end

local services = {}
local SUFFIXES = { "", "K", "M", "B", "T", "Qa", "Qi" }

function xDTaraZ.Util.Try(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[OpenSea]", err) end
    return ok, err
end

function xDTaraZ.Util.Service(name)
    if not GameLib.Knit then error("game services did not load on this executor", 2) end
    services[name] = services[name] or GameLib.Knit.GetService(name)
    return services[name]
end

---@return string?  body, nil when every way to fetch failed
function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then return body end
    local send = (type(request) == "function" and request) or (type(http_request) == "function" and http_request)
        or (type(syn) == "table" and syn.request)
    if type(send) ~= "function" then return nil end
    local sent, response = pcall(send, { Url = url, Method = "GET" })
    if sent and type(response) == "table" and tonumber(response.StatusCode) == 200 and type(response.Body) == "string" then
        return response.Body
    end
    return nil
end

---@param text string  shown as a Roblox notification, works before the menu exists
function xDTaraZ.Util.Alert(text)
    warn("[OpenSea] " .. text)
    task.spawn(function()
        local starterGui = game:GetService("StarterGui")
        for _ = 1, Config.AlertTries do
            if pcall(starterGui.SetCore, starterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 }) then return end
            task.wait(Config.AlertRetry)
        end
    end)
end

---@return table?  UI library, nil after telling the player why
function xDTaraZ.Util.LoadLibrary()
    local source = xDTaraZ.Util.HttpGet(Config.UiSource)
    if not source or not source:sub(-64):find("return Library%s*$") then
        xDTaraZ.Util.Alert("Could not download the menu. Check your connection and run it again.")
        return nil
    end
    local chunk, err = loadstring(source)
    if not chunk then
        xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(err))
        return nil
    end
    local ok, library = pcall(chunk)
    if not ok or type(library) ~= "table" then
        xDTaraZ.Util.Alert("The menu failed to load on this executor: " .. tostring(library))
        return nil
    end
    return library
end

function xDTaraZ.Util.Abbreviate(number)
    local tier = 1
    while math.abs(number) >= 1000 and tier < #SUFFIXES do
        number, tier = number / 1000, tier + 1
    end
    return tier == 1 and ("%d"):format(number) or ("%.2f%s"):format(number, SUFFIXES[tier])
end

function xDTaraZ.Util.Count(tbl)
    local n = 0
    for _ in pairs(tbl) do n += 1 end
    return n
end

---@param kind string?  Info (default), Success, Warning or Error
function xDTaraZ.Util.Notify(text, kind)
    State.Messages[#State.Messages + 1] = { Text = text, Kind = kind }
end

---@return string[]  lowest rarity first
function xDTaraZ.Util.RarityNames()
    local names = {}
    if not GameLib.Rarities then return names end
    for name in pairs(GameLib.Rarities) do names[#names + 1] = name end
    table.sort(names, function(a, b) return GameLib.Rarities[a] < GameLib.Rarities[b] end)
    return names
end

function xDTaraZ.Util.MutationNames()
    local names = {}
    for id, info in pairs(GameLib.Mutations or {}) do
        if type(info) == "table" then names[#names + 1] = info.name or id end
    end
    table.sort(names)
    return names
end

function xDTaraZ.Data.Get()
    if not GameLib.Knit then error("game data did not load on this executor", 2) end
    return GameLib.Knit.GetController("ReplicaController"):GetPlayerData()
end

function xDTaraZ.Data.Cash()
    return xDTaraZ.Data.Get().Currencies.Cash
end

function xDTaraZ.Data.InventoryLimit()
    local modifiers = GameLib.Modifiers
    return modifiers and modifiers.Get(LocalPlayer, "InventoryLimit") or Config.InventoryLimit
end

function xDTaraZ.Data.MaxPickup()
    return math.max(1, xDTaraZ.Data.Get().Upgrades.Carry or 1)
end

---@return string, string, table?, table?  rarity, mutation, size, config
function xDTaraZ.Data.Describe(entity)
    local info = entity.eggType and GameLib.Eggs.EGGS[entity.eggType]
        or entity.brainrotType and GameLib.Brainrots.CONFIG[entity.brainrotType]
    local mutation = entity.mutation and GameLib.Mutations[entity.mutation]
    local size = GameLib.Sizes.SIZES[entity.size or "baby"]
    return info and info.rarity or "Common", mutation and mutation.name or "Normal", size, info
end

function xDTaraZ.Data.Score(entity)
    local rarity, _, size, info = xDTaraZ.Data.Describe(entity)
    local mutation = entity.mutation and GameLib.Mutations[entity.mutation]
    local rank = GameLib.Rarities[rarity] or 1
    local mutationMulti = mutation and mutation.cashMulti or 1
    local sizeMulti = size and size.cashMulti or 1
    local bossBonus = entity.isBossItem and 2 or 1
    return rank * 1000 * mutationMulti * sizeMulti * bossBonus + (info and info.tier or 1)
end

function xDTaraZ.Loot.Wanted(entity)
    local keep = State.Opt.LootKeep
    if next(keep) == nil then return true end
    local rarity, mutation = xDTaraZ.Data.Describe(entity)
    return keep[rarity] or keep[mutation] or false
end

---@return string[]  item ids, best first
function xDTaraZ.Loot.PickBest(spawns, limit)
    local ranked = {}
    for id, spawn in pairs(spawns) do
        local entity = spawn.entity
        entity.isBossItem = spawn.isBossItem
        if xDTaraZ.Loot.Wanted(entity) then ranked[#ranked + 1] = { id, xDTaraZ.Data.Score(entity) } end
    end
    table.sort(ranked, function(a, b) return a[2] > b[2] end)

    local picked = {}
    for i = 1, math.min(limit, #ranked) do picked[i] = ranked[i][1] end
    return picked
end

---@return number  slots no other worker holds; 0 when full (the first full reading per pause tells the player once)
function xDTaraZ.Loot.FreeSlots()
    local count, limit = xDTaraZ.Util.Count(xDTaraZ.Data.Get().Inventory), xDTaraZ.Data.InventoryLimit()
    if count < limit then
        State.LootFull = nil
        return limit - count - State.LootReserved
    end
    local full = State.LootFull or { notified = false }
    State.LootFull = full
    full.count, full.limit = count, limit
    if full.notified or not State.Opt.AutoLoot then return 0 end

    full.notified = true
    local selling = State.Opt.AutoSellEggs or State.Opt.AutoSellBrainrots
    xDTaraZ.Util.Notify(("Inventory is full (%d/%d), Auto Loot %s"):format(count, limit,
        selling and "resumes after Auto Sell frees space" or "waits for free space"), "Warning")
    return 0
end

function xDTaraZ.Loot.MayBeTraining()
    if State.Trained or State.Opt.AutoTrain then return true end
    if not GameLib.Knit then return false end
    local ok, training = pcall(function()
        return GameLib.Knit.GetController("TrainingController"):IsTraining()
    end)
    return ok and training == true
end

---@return table?  picked ids, nil when the server refused the wave
function xDTaraZ.Loot.RunWave(take)
    local waves = xDTaraZ.Util.Service("WaveService")
    local wave = waves:Start(Config.WaveExtension)
    if type(wave) ~= "table" or not wave.spawns then return nil end

    local picked = xDTaraZ.Loot.PickBest(wave.spawns, take)
    waves:Finished(picked)
    return picked
end

---@return number?, string?  items taken this wave; nil and "full", "busy" or "refused" when no wave ran
function xDTaraZ.Loot.RunOnce()
    local free = xDTaraZ.Loot.FreeSlots()
    if State.LootFull then return nil, "full" end
    if free <= 0 then return nil, "busy" end

    local take = math.min(xDTaraZ.Data.MaxPickup(), free)
    State.LootReserved += take
    local ok, picked = pcall(xDTaraZ.Loot.RunWave, take)
    State.LootReserved -= take
    if not ok then error(picked, 0) end
    if not picked then return nil, "refused" end

    State.Looted += #picked
    if xDTaraZ.Loot.MayBeTraining() then State.Requests.ResumeTraining = true end
    return #picked
end

function xDTaraZ.Loot.RestartTraining()
    if State.Trained or xDTaraZ.Progress.ServerTraining() then
        xDTaraZ.Util.Service("TrainingService"):StartTraining()
    end
end

---@return boolean  false when throttled or backing off; never fails the farm
function xDTaraZ.Loot.ResumeTraining()
    local resume, now = State.Resume, os.clock()
    if now < resume.retryAt then return false end
    if now - resume.last < Config.ResumeInterval then
        State.Requests.ResumeTraining = true
        return false
    end
    resume.last = now

    local ok, err = pcall(xDTaraZ.Loot.RestartTraining)
    if ok then
        resume.fails = 0
        return true
    end
    resume.fails += 1
    if resume.fails < Config.JobFailLimit then return false end

    resume.fails, resume.retryAt = 0, now + Config.ResumeBackoff
    warn("[OpenSea] resume training:", err)
    return false
end

function xDTaraZ.Loot.Worker()
    local fails, firstFail = 0, 0
    while State.Alive and State.Opt.AutoLoot do
        local ok, took = pcall(xDTaraZ.Loot.RunOnce)
        fails = ok and 0 or fails + 1
        if fails == 1 then firstFail = os.clock() end
        if fails >= Config.JobFailLimit and os.clock() - firstFail >= Config.JobFailWindow then
            xDTaraZ.Scheduler.Halt("Auto Loot", "AutoLoot", took)
            break
        end
        if not ok then
            task.wait(1)
        elseif not took then
            task.wait(Config.LootIdle)
        end
        task.wait()
    end
end

function xDTaraZ.Loot.SetEnabled(enabled)
    State.Opt.AutoLoot = enabled
    if not enabled then return end
    if State.LootFull then State.LootFull.notified = false end
    for _ = 1, Config.LootWorkers do task.spawn(xDTaraZ.Loot.Worker) end
end

function xDTaraZ.Hatch.MyPlot()
    local plotId = tostring(xDTaraZ.Util.Service("PlotService"):GetPlayerPlot())
    local plots = Workspace:FindFirstChild("Plots")
    local holder = plots and plots:FindFirstChild(plotId)
    return holder and holder:FindFirstChild(plotId)
end

---@return number  eggs hatched
function xDTaraZ.Hatch.HatchReady()
    local eggs = xDTaraZ.Util.Service("EggService")
    local now, hatched = Workspace:GetServerTimeNow(), 0
    for key, egg in pairs(xDTaraZ.Data.Get().PlacedEggs) do
        if egg.startTime and egg.startTime + (egg.duration or 0) <= now and eggs:HatchEgg(key) then
            hatched += 1
        end
    end
    return hatched
end

---@return table[]  inventory eggs, most valuable first
function xDTaraZ.Hatch.RankedEggs()
    local ranked = {}
    for id, entry in pairs(xDTaraZ.Data.Get().Inventory) do
        local inner = entry.innerEntity
        if entry.itemType == "Egg" and inner and inner.eggType then
            ranked[#ranked + 1] = { id = id, score = GameLib.Eggs.GetSellPrice(inner.eggType) * xDTaraZ.Data.Score(inner) }
        end
    end
    table.sort(ranked, function(a, b) return a.score > b.score end)
    return ranked
end

---@return boolean  true while the plot still holds as many eggs as when the last place was rejected
function xDTaraZ.Hatch.PlotFull(profile)
    local full = State.PlotFull
    if not full then return false end

    local stale = xDTaraZ.Util.Count(profile.PlacedEggs) < full.placed
        or profile.Upgrades.PlotUpgrade ~= full.level
        or os.clock() - full.at >= Config.PlotRecheck
    if stale then State.PlotFull = nil end
    return not stale
end

---@return number  eggs placed
function xDTaraZ.Hatch.PlaceBest()
    if xDTaraZ.Hatch.PlotFull(xDTaraZ.Data.Get()) then return 0 end
    local plot = xDTaraZ.Hatch.MyPlot()
    local surface = plot and plot:FindFirstChild("PlotSurface")
    local part = surface and (surface:IsA("BasePart") and surface or surface:FindFirstChildWhichIsA("BasePart", true))
    if not part then return 0 end

    local eggs, placed = xDTaraZ.Util.Service("EggService"), 0
    for i, egg in ipairs(xDTaraZ.Hatch.RankedEggs()) do
        if i > Config.PlaceEggTries then break end
        local offset = Vector3.new((math.random() - 0.5) * part.Size.X * 0.8, part.Size.Y / 2 + 1, (math.random() - 0.5) * part.Size.Z * 0.8)
        if not eggs:PlaceEgg(egg.id, CFrame.new(part.Position + offset)) then
            local profile = xDTaraZ.Data.Get()
            State.PlotFull = { placed = xDTaraZ.Util.Count(profile.PlacedEggs), level = profile.Upgrades.PlotUpgrade, at = os.clock() }
            break
        end
        placed += 1
    end
    return placed
end

function xDTaraZ.Hatch.Step()
    xDTaraZ.Hatch.HatchReady()
    xDTaraZ.Hatch.PlaceBest()
    xDTaraZ.Progress.EquipBest()
end

---@return number  eggs sold
function xDTaraZ.Sell.EggsNow()
    local inventory, keep, sold = xDTaraZ.Util.Service("InventoryService"), State.Opt.SellKeep, 0
    for id, entry in pairs(xDTaraZ.Data.Get().Inventory) do
        if entry.itemType == "Egg" then
            local rarity, mutation = xDTaraZ.Data.Describe(entry.innerEntity or {})
            if not keep[rarity] and not keep[mutation] then
                inventory:SellEgg(id)
                sold += 1
            end
        end
    end
    return sold
end

function xDTaraZ.Sell.BrainrotsNow()
    xDTaraZ.Util.Service("InventoryService"):SellAllBrainrots()
end

---@return number  upgrades bought
function xDTaraZ.Progress.UpgradeNow()
    local upgrades, bought = xDTaraZ.Util.Service("UpgradesService"), 0
    for _, name in ipairs(Config.UpgradeNames) do
        if State.Opt.UpgradePick[name] then
            local ok, price = pcall(GameLib.Upgrades.GetPrice, name, xDTaraZ.Data.Get().Upgrades[name])
            if ok and price and xDTaraZ.Data.Cash() - price >= State.Opt.CashReserve then
                upgrades:Upgrade(name, 1)
                bought += 1
            end
        end
    end
    return bought
end

function xDTaraZ.Progress.StartTraining()
    xDTaraZ.Util.Service("TrainingService"):StartTraining()
    State.Trained = true
end

function xDTaraZ.Progress.StopTraining()
    xDTaraZ.Util.Service("TrainingService"):StopTraining()
    State.Trained = false
end

---@return boolean  true while the server counts the player as training
function xDTaraZ.Progress.ServerTraining()
    local states = GameLib.PlayerStates
    if not states then return false end
    return xDTaraZ.Util.Service("PlayerStateService"):GetState() == states.STATES.TRAINING
end

---@return boolean  true if a treadmill session was ended
function xDTaraZ.Progress.ReleaseTreadmill()
    if not GameLib.Knit then return false end
    local controller = GameLib.Knit.GetController("TrainingController")
    if not controller:IsTraining() then return false end

    controller:StopTraining(true)
    if not State.Opt.AutoTrain then State.Trained = false end
    return true
end

---@return string?  strongest dumbbell within budget
function xDTaraZ.Progress.BestAffordableTool()
    local profile = xDTaraZ.Data.Get()
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
function xDTaraZ.Progress.BuyBestTool()
    local name = xDTaraZ.Progress.BestAffordableTool()
    if not name then return nil end

    local training = xDTaraZ.Util.Service("TrainingService")
    training:BuyTrainTool(name)
    training:EquipTrainTool(name)
    if State.Opt.AutoTrain then xDTaraZ.Progress.StartTraining() end
    return name
end

function xDTaraZ.Progress.RebirthNow()
    return xDTaraZ.Util.Service("RebirthService"):Rebirth()
end

function xDTaraZ.Progress.EquipBest()
    xDTaraZ.Util.Service("AnimalService"):EquipBest()
end

function xDTaraZ.Claim.Daily()
    local daily = xDTaraZ.Data.Get().DailyReward
    xDTaraZ.Util.Service("DailyRewardService"):ClaimReward((daily.LastClaimedDay or 0) + 1)
end

function xDTaraZ.Claim.Playtime()
    local playtime = xDTaraZ.Util.Service("PlaytimeRewardService")
    for slot = 1, Config.PlaytimeSlots do playtime:ClaimGift(slot) end
end

function xDTaraZ.Claim.All()
    xDTaraZ.Util.Try(xDTaraZ.Claim.Daily)
    xDTaraZ.Util.Try(xDTaraZ.Claim.Playtime)
    xDTaraZ.Util.Try(function() xDTaraZ.Util.Service("SpinWheelService"):SpinAll() end)
    xDTaraZ.Util.Try(function() xDTaraZ.Util.Service("FreeShopService"):Claim() end)
    xDTaraZ.Util.Try(function() xDTaraZ.Util.Service("ForeverPackService"):ClaimForeverPack() end)
    xDTaraZ.Util.Try(function() xDTaraZ.Util.Service("RewardService"):GroupReward() end)
    xDTaraZ.Util.Try(function() xDTaraZ.Util.Service("DiscService"):GetReward() end)
    xDTaraZ.Util.Try(function() xDTaraZ.Util.Service("AnimalService"):CollectOfflineCash() end)
end

---@return number  codes redeemed
function xDTaraZ.Claim.RedeemCodes(codes)
    local svc, redeemed = xDTaraZ.Util.Service("CodesService"), 0
    for _, code in ipairs(codes) do
        local ok, reply = pcall(svc.RedeemCode, svc, code)
        if ok and reply then redeemed += 1 end
    end
    return redeemed
end

function xDTaraZ.Movement.Humanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

function xDTaraZ.Movement.OnPinned()
    if State.SpeedPinned then return end
    State.SpeedPinned = true
    State.Requests.ReleaseTreadmill = true
end

function xDTaraZ.Movement.Step()
    local hum = xDTaraZ.Movement.Humanoid()
    if not hum then return end
    if State.Opt.Speed then
        if State.SpeedBase == nil then State.SpeedBase = hum.WalkSpeed > 0 and hum.WalkSpeed or false end
        if hum.WalkSpeed == 0 then
            xDTaraZ.Movement.OnPinned()
        else
            State.SpeedPinned = false
        end
        hum.WalkSpeed = State.Opt.SpeedValue
    end
    if not State.Opt.Noclip then return end

    for _, part in ipairs(LocalPlayer.Character:GetChildren()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
end

function xDTaraZ.Movement.RestoreCollision()
    local char = LocalPlayer.Character
    if not char then return end
    for _, name in ipairs(Config.NoclipParts) do
        local part = char:FindFirstChild(name)
        if part and part:IsA("BasePart") then part.CanCollide = true end
    end
end

function xDTaraZ.Movement.Bind()
    table.insert(State.Conns, RunService.Stepped:Connect(xDTaraZ.Movement.Step))
    table.insert(State.Conns, UserInputService.JumpRequest:Connect(function()
        local hum = xDTaraZ.Movement.Humanoid()
        if State.Opt.InfJump and hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end))
    table.insert(State.Conns, LocalPlayer.Idled:Connect(function()
        if not State.Opt.AntiAfk then return end
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.zero)
    end))
end

function xDTaraZ.Movement.ResetSpeed()
    local hum = xDTaraZ.Movement.Humanoid()
    local base = State.SpeedBase
    State.SpeedBase = nil
    if not hum then return end
    hum.WalkSpeed = base or xDTaraZ.Data.Get().Upgrades.MovementSpeed or 16
end

xDTaraZ.Scheduler.Requests = {
    LootOnce = function()
        local ok, count, reason = xDTaraZ.Util.Try(xDTaraZ.Loot.RunOnce)
        if ok and count then
            xDTaraZ.Util.Notify(("Collected %d item(s)"):format(count))
        elseif ok and reason == "full" then
            xDTaraZ.Util.Notify(("Inventory is full (%d/%d)"):format(State.LootFull.count, State.LootFull.limit), "Warning")
        else
            xDTaraZ.Util.Notify("Wave not ready")
        end
    end,
    SellEggs = function()
        local ok, sold = xDTaraZ.Util.Try(xDTaraZ.Sell.EggsNow)
        xDTaraZ.Util.Notify(ok and ("Sold %d egg(s)"):format(sold) or "Sell failed")
    end,
    SellBrainrots = function()
        xDTaraZ.Util.Try(xDTaraZ.Sell.BrainrotsNow)
        xDTaraZ.Util.Notify("Brainrots sold")
    end,
    HatchNow = function()
        local ok, hatched = xDTaraZ.Util.Try(xDTaraZ.Hatch.HatchReady)
        local _, placed = xDTaraZ.Util.Try(xDTaraZ.Hatch.PlaceBest)
        xDTaraZ.Util.Notify(("Hatched %d, placed %d egg(s)"):format(ok and hatched or 0, tonumber(placed) or 0))
    end,
    UpgradeNow = function()
        local ok, bought = xDTaraZ.Util.Try(xDTaraZ.Progress.UpgradeNow)
        xDTaraZ.Util.Notify(ok and ("Bought %d upgrade(s)"):format(bought) or "Upgrade failed")
    end,
    ToolNow = function()
        local ok, name = xDTaraZ.Util.Try(xDTaraZ.Progress.BuyBestTool)
        xDTaraZ.Util.Notify(ok and name and ("Equipped " .. name) or "Nothing better to buy")
    end,
    RebirthNow = function()
        local ok, reply = xDTaraZ.Util.Try(xDTaraZ.Progress.RebirthNow)
        xDTaraZ.Util.Notify(ok and reply and "Rebirthed" or "Requirement not met")
    end,
    ClaimNow = function()
        xDTaraZ.Claim.All()
        xDTaraZ.Util.Notify("Rewards claimed")
    end,
    RedeemAll = function()
        xDTaraZ.Util.Notify(("Redeemed %d/%d code(s)"):format(xDTaraZ.Claim.RedeemCodes(Config.Codes), #Config.Codes))
    end,
    RedeemInput = function()
        local codes = {}
        for code in State.Opt.CodeInput:gmatch("[^,%s]+") do codes[#codes + 1] = code end
        xDTaraZ.Util.Notify(("Redeemed %d/%d code(s)"):format(xDTaraZ.Claim.RedeemCodes(codes), #codes))
    end,
    ResetSpeed = function() xDTaraZ.Util.Try(xDTaraZ.Movement.ResetSpeed) end,
    StopTrain = function() xDTaraZ.Util.Try(xDTaraZ.Progress.StopTraining) end,
    ReleaseTreadmill = function()
        local ok, released = xDTaraZ.Util.Try(xDTaraZ.Progress.ReleaseTreadmill)
        if not (ok and released) then
            State.SpeedPinned = false
            return
        end
        xDTaraZ.Util.Notify("Left the treadmill so Speed works")
    end,
    ResumeTraining = function() xDTaraZ.Loot.ResumeTraining() end,
}

function xDTaraZ.Scheduler.Summarize()
    local profile = xDTaraZ.Data.Get()
    local cash = profile.Currencies.Cash
    State.StartCash = State.StartCash or cash
    State.Summary = ("Cash %s (+%s)\nItems looted %d · Carry %d · Rebirth %d\nInventory %d/%d"):format(
        xDTaraZ.Util.Abbreviate(cash), xDTaraZ.Util.Abbreviate(cash - State.StartCash),
        State.Looted, profile.Upgrades.Carry or 1, profile.Rebirth or 0,
        xDTaraZ.Util.Count(profile.Inventory), xDTaraZ.Data.InventoryLimit())
    if State.Opt.AutoLoot and State.LootFull then
        State.Summary ..= "\nWARNING: inventory full, Auto Loot paused"
    end
end

xDTaraZ.Scheduler.Jobs = {
    { "Status", nil, xDTaraZ.Scheduler.Summarize, 0 },
    { "Auto Hatch", "AutoHatch", xDTaraZ.Hatch.Step, Config.SellInterval },
    { "Auto Sell Eggs", "AutoSellEggs", xDTaraZ.Sell.EggsNow, Config.SellInterval },
    { "Auto Sell Brainrots", "AutoSellBrainrots", xDTaraZ.Sell.BrainrotsNow, Config.SellInterval },
    { "Auto Place Best", "AutoEquipBest", xDTaraZ.Progress.EquipBest, Config.SellInterval },
    { "Auto Upgrade", "AutoUpgrade", xDTaraZ.Progress.UpgradeNow, Config.UpgradeInterval },
    { "Auto Rebirth", "AutoRebirth", xDTaraZ.Progress.RebirthNow, Config.UpgradeInterval },
    { "Auto Buy Dumbbell", "AutoBuyTool", xDTaraZ.Progress.BuyBestTool, Config.UpgradeInterval },
    { "Auto Train", "AutoTrain", xDTaraZ.Progress.StartTraining, Config.UpgradeInterval },
    { "Auto Claim", "AutoClaim", xDTaraZ.Claim.All, Config.ClaimInterval },
}

---Switches a failing feature off from the scheduler thread; the UI pump flips the toggle (this thread has touched game modules).
function xDTaraZ.Scheduler.Halt(label, idx, err)
    if idx and not State.Opt[idx] then return end
    local reason = tostring(err):match("^[^\n]*")
    if idx then
        State.Opt[idx] = false
        State.Halted[#State.Halted + 1] = idx
    end
    warn("[OpenSea] " .. label .. " stopped:", reason)
    xDTaraZ.Util.Notify(label .. " stopped: " .. reason)
end

---@param job table  { label, toggle idx, step, interval }; a feature halts after Config.JobFailLimit errors spanning Config.JobFailWindow seconds, the status job only goes quiet
function xDTaraZ.Scheduler.Run(job, now)
    if job[2] and not State.Opt[job[2]] then
        job.Streak = nil
        return
    end
    if now - (job.Last or 0) < job[4] then return end
    job.Last = now

    local ok, err = pcall(job[3])
    if ok then
        job.Streak = nil
        return
    end
    local streak = job.Streak
    if not streak then
        streak = { count = 0, since = now }
        job.Streak = streak
        warn("[OpenSea] " .. job[1] .. ":", err)
    end
    streak.count += 1
    if not job[2] or streak.count < Config.JobFailLimit or now - streak.since < Config.JobFailWindow then return end
    job.Streak = nil
    xDTaraZ.Scheduler.Halt(job[1], job[2], err)
end

function xDTaraZ.Scheduler.Step()
    for name, handler in pairs(xDTaraZ.Scheduler.Requests) do
        if State.Requests[name] then
            State.Requests[name] = nil
            xDTaraZ.Util.Try(handler)
        end
    end

    local now = os.clock()
    for _, job in ipairs(xDTaraZ.Scheduler.Jobs) do
        xDTaraZ.Scheduler.Run(job, now)
    end
end

function xDTaraZ.Scheduler.Boot()
    xDTaraZ.Movement.Bind()
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
    getgenv().OpenSeaUnload = nil
    State.Opt.AutoLoot = false
    for _, conn in ipairs(State.Conns) do conn:Disconnect() end
    table.clear(State.Conns)
    if State.Opt.Noclip then xDTaraZ.Movement.RestoreCollision() end
    if State.Opt.Speed then xDTaraZ.Util.Try(xDTaraZ.Movement.ResetSpeed) end
    if State.Trained then task.spawn(xDTaraZ.Util.Try, xDTaraZ.Progress.StopTraining) end
end

---@return boolean  false when the menu could not load
local function BuildInterface()
    local Library = xDTaraZ.Util.LoadLibrary()
    if not Library then return false end
    pcall(MarioBanner.Step, "UI library")
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt

    local keepValues = {}
    xDTaraZ.Util.Try(function()
        for _, name in ipairs(xDTaraZ.Util.RarityNames()) do keepValues[#keepValues + 1] = name end
        for _, name in ipairs(xDTaraZ.Util.MutationNames()) do keepValues[#keepValues + 1] = name end
    end)

    local function Notify(text, kind)
        Library:Notify("Open Sea For Animals", text, 4, kind or "Info")
    end

    ---@param idx string?  feature whose game modules the request needs
    local function Request(name, idx)
        return function()
            if idx and GameLib.Missing(idx) then
                Notify("Not available on this executor", "Warning")
                return
            end
            State.Requests[name] = true
        end
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

    local function Feature(group, key, text, description, onChange)
        return Toggle(group, key, text, description, onChange):AddKeyPicker(key .. "Key", { Default = "None", Mode = "Toggle" })
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

    local function BuildMain(window)
        window:AddTabSection(T("Farm", "ฟาร์ม"))
        local mainTab = window:AddTab(T("Main", "หลัก"), "house", T("Loot farm and status", "ฟาร์มของและสถานะ"))

        local statusBox = mainTab:AddLeftGroupbox(T("Status", "สถานะ"))
        local statusLabel = statusBox:AddLabel("Loading...")

        local lootBox = mainTab:AddLeftGroupbox(T("Sea Loot", "เก็บของในทะเล"))
        Feature(lootBox, "AutoLoot", T("Auto Loot", "เก็บของอัตโนมัติ"),
            T("Collects the best eggs and brainrots from every wave without leaving your base", "เก็บไข่และ brainrot ที่ดีที่สุดทุกคลื่น โดยไม่ต้องออกจากฐาน"),
            xDTaraZ.Loot.SetEnabled)
        lootBox:AddButton({ Text = T("Loot Once", "เก็บหนึ่งรอบ"), Style = "Primary", Func = Request("LootOnce", "AutoLoot") })
        MultiSelect(lootBox, "LootKeep", T("Only Collect", "เก็บเฉพาะ"),
            T("Empty takes the best item, otherwise only these rarities or mutations", "เว้นว่าง = เอาชิ้นดีสุดเสมอ ถ้าเลือกไว้จะเก็บเฉพาะ rarity หรือ mutation ที่เลือก"),
            keepValues)

        local kaitunBox = mainTab:AddRightGroupbox("Kaitun")
        kaitunBox:AddToggle("Kaitun", {
            Text = T("Kaitun (All-in-one)", "ไก่ตัน (ทำทุกอย่าง)"),
            Description = T("Loot, sell, upgrades, rebirth and rewards together", "เก็บของ ขาย อัปเกรด รีเบิร์ธ และรับรางวัลพร้อมกัน"),
            NoSave = true,
            Callback = function(value)
                for _, key in ipairs({ "AutoLoot", "AutoSellEggs", "AutoTrain", "AutoHatch", "AutoBuyTool", "AutoUpgrade", "AutoRebirth", "AutoClaim", "AutoEquipBest" }) do
                    local toggle = Options[key]
                    if toggle then toggle:SetValue(value) end
                end
            end,
        }):AddKeyPicker("KaitunKey", { Default = "None", Mode = "Toggle" })

        local discordBox = mainTab:AddRightGroupbox("Discord", "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            local copy = setclipboard or toclipboard
            if copy then copy(Config.Discord) end
            Notify(copy and "Discord link copied" or Config.Discord)
        end })

        return statusLabel
    end

    local function BuildSell(window)
        local sellTab = window:AddTab(T("Sell", "ขาย"), "upload", T("Sell eggs and brainrots", "ขายไข่และ brainrot"))

        local sellBox = sellTab:AddLeftGroupbox(T("Eggs", "ไข่"))
        Feature(sellBox, "AutoSellEggs", T("Auto Sell Eggs", "ขายไข่อัตโนมัติ"), T("Sells eggs as they come in, except the ones you keep", "ขายไข่ที่ได้มาทันที ยกเว้นที่เลือกเก็บไว้"))
        sellBox:AddButton({ Text = T("Sell Eggs Now", "ขายไข่เดี๋ยวนี้"), Style = "Primary", Func = Request("SellEggs", "AutoSellEggs") })
        MultiSelect(sellBox, "SellKeep", T("Keep", "เก็บไว้"), T("Rarities and mutations that are never sold", "rarity และ mutation ที่จะไม่ขาย"), keepValues)

        local brainrotBox = sellTab:AddRightGroupbox(T("Brainrots", "Brainrots"))
        brainrotBox:AddToggle("AutoSellBrainrots", {
            Text = T("Auto Sell Brainrots", "ขาย brainrot อัตโนมัติ"),
            Description = T("Sells all brainrots in your inventory", "ขาย brainrot ทั้งหมดในกระเป๋า"),
            Risky = true,
            Default = opt.AutoSellBrainrots,
            Callback = function(value) opt.AutoSellBrainrots = value end,
        }):AddKeyPicker("AutoSellBrainrotsKey", { Default = "None", Mode = "Toggle" })
        brainrotBox:AddButton({ Text = T("Sell Brainrots Now", "ขาย brainrot เดี๋ยวนี้"), Func = Request("SellBrainrots", "AutoSellBrainrots") })
        Feature(brainrotBox, "AutoHatch", T("Auto Hatch", "ฟักไข่อัตโนมัติ"), T("Hatches your most valuable eggs on your plot and places the best animals", "ฟักไข่ที่มีค่าที่สุดบนพื้นที่ แล้ววางสัตว์ตัวที่ดีที่สุด"))
        brainrotBox:AddButton({ Text = T("Hatch Now", "ฟักเดี๋ยวนี้"), Func = Request("HatchNow", "AutoHatch") })
        Feature(brainrotBox, "AutoEquipBest", T("Auto Place Best", "วางตัวดีสุดอัตโนมัติ"), T("Keeps your best animals placed on your plot", "วางสัตว์ตัวที่ดีที่สุดบนพื้นที่เสมอ"))
    end

    local function BuildProgress(window)
        window:AddTabSection(T("Progress", "ความคืบหน้า"))
        local progressTab = window:AddTab(T("Upgrade", "อัปเกรด"), "sliders-horizontal", T("Upgrades, rebirth and rewards", "อัปเกรด รีเบิร์ธ และรางวัล"))

        local upgradeBox = progressTab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"))
        Feature(upgradeBox, "AutoUpgrade", T("Auto Upgrade", "อัปเกรดอัตโนมัติ"), T("Buys the selected upgrades whenever you can afford them", "ซื้ออัปเกรดที่เลือกทุกครั้งที่เงินพอ"))
        upgradeBox:AddButton({ Text = T("Upgrade Now", "อัปเกรดเดี๋ยวนี้"), Style = "Primary", Func = Request("UpgradeNow", "AutoUpgrade") })
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
        Feature(trainBox, "AutoTrain", T("Auto Train", "ฝึกอัตโนมัติ"), T("Gains power anywhere. More power reaches rarer eggs further out at sea", "เพิ่มพลังได้ทุกที่ พลังยิ่งเยอะยิ่งเอื้อมถึงไข่หายากที่อยู่ไกล"), function(value)
            if not value and State.Trained then State.Requests.StopTrain = true end
        end)
        Feature(trainBox, "AutoBuyTool", T("Auto Buy Best Dumbbell", "ซื้อดัมเบลล์ดีสุดอัตโนมัติ"), T("Buys and equips the strongest dumbbell you can afford", "ซื้อและใส่ดัมเบลล์ที่แรงที่สุดที่ซื้อไหว"))
        trainBox:AddButton({ Text = T("Buy Best Dumbbell Now", "ซื้อดัมเบลล์ดีสุดเดี๋ยวนี้"), Func = Request("ToolNow", "AutoBuyTool") })

        local rebirthBox = progressTab:AddRightGroupbox(T("Rebirth", "รีเบิร์ธ"))
        Feature(rebirthBox, "AutoRebirth", T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"), T("Rebirths as soon as you meet the requirement", "รีเบิร์ธทันทีเมื่อครบเงื่อนไข"))
        rebirthBox:AddButton({ Text = T("Rebirth Now", "รีเบิร์ธเดี๋ยวนี้"), Func = Request("RebirthNow", "AutoRebirth") })

        local claimBox = progressTab:AddRightGroupbox(T("Rewards", "รางวัล"))
        Feature(claimBox, "AutoClaim", T("Auto Claim", "รับรางวัลอัตโนมัติ"), T("Daily, playtime, spins, free shop, packs and offline cash", "รายวัน เวลาเล่น วงล้อ ร้านฟรี แพ็ก และเงินตอนออฟไลน์"))
        claimBox:AddButton({ Text = T("Claim All Now", "รับทั้งหมดเดี๋ยวนี้"), Func = Request("ClaimNow", "AutoClaim") })
        claimBox:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Func = Request("RedeemAll", "AutoClaim") })
        claimBox:AddInput("CodeBox", {
            Text = T("Redeem Codes", "ใส่โค้ด"),
            Description = T("Separate codes with commas", "คั่นโค้ดด้วยจุลภาค"),
            Default = "",
            Placeholder = T("CODE1, CODE2", "โค้ด1, โค้ด2"),
            Finished = true,
            Callback = function(value)
                opt.CodeInput = value
                State.Requests.RedeemInput = true
            end,
        })
    end

    local function BuildPlayer(window)
        window:AddTabSection(T("Other", "อื่นๆ"))
        local playerTab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement", "การเคลื่อนที่"))

        local moveBox = playerTab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"))
        Feature(moveBox, "Speed", T("Speed", "ความเร็ว"), nil, function(value)
            State.SpeedPinned = false
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
        Feature(moveBox, "InfJump", T("Infinite Jump", "กระโดดไม่จำกัด"))
        Feature(moveBox, "Noclip", T("Noclip", "ทะลุวัตถุ"), nil, function(value)
            if not value then xDTaraZ.Movement.RestoreCollision() end
        end)
    end

    local function BuildSettings(window)
        local settingsTab = window:AddSettingsTab()
        local sessionBox = settingsTab:AddLeftGroupbox(T("Session", "เซสชัน"))
        Toggle(sessionBox, "AntiAfk", T("Anti AFK", "กันหลุด AFK"), T("Stay in the server while idle", "อยู่ในเซิร์ฟต่อได้แม้ไม่ได้ขยับ"))
        sessionBox:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟเดิมใหม่"), Func = function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end })
    end

    ---Features whose game module did not load refuse to turn on instead of erroring every tick.
    local function GateModules()
        for idx in pairs(GameLib.Needs) do
            local missing = GameLib.Missing(idx)
            if missing and Options[idx] then
                warn("[OpenSea] " .. idx .. " disabled, module missing: " .. missing)
                Library.Compat.Block(idx, T("Not available on this executor", "ใช้กับ executor นี้ไม่ได้"))
            end
        end
        if not GameLib.Knit then State.Summary = "Game data is not available on this executor" end
    end

    local function Pump(statusLabel)
        while #State.Messages > 0 do
            local message = table.remove(State.Messages, 1)
            Notify(message.Text, message.Kind)
        end

        while #State.Halted > 0 do
            local toggle = Library.Toggles[table.remove(State.Halted, 1)]
            if toggle and toggle.Value then toggle:SetValue(false) end
        end

        if statusLabel then statusLabel:SetText(State.Summary) end
    end

    local function BuildTabs()
        local window = Library.Window
        local try = xDTaraZ.Util.Try
        local _, statusLabel = try(BuildMain, window)
        try(BuildSell, window)
        try(BuildProgress, window)
        try(BuildPlayer, window)
        try(BuildSettings, window)
        try(GateModules)

        Library:Every(1, function() Pump(statusLabel) end)
    end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
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
            xDTaraZ.Util.Try(xDTaraZ.Scheduler.Boot)
            Notify("Loaded")
            xDTaraZ.Util.Try(Library.LoadAutoloadConfig, Library)
        end,
    })
    return true
end

if getgenv().OpenSeaUnload then
    pcall(getgenv().OpenSeaUnload)
end

pcall(MarioBanner.Step, "Systems")
if BuildInterface() then
    pcall(MarioBanner.Step, "Interface")
    pcall(MarioBanner.Ready)
end