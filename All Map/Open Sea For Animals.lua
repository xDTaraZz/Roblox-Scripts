if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 10765091041 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub : this script is for Open Sea For Animals only")
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

MarioBanner.Show()
MarioBanner.Step("Core")

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
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui_v2.lua",
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
    Cash = nil,
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

local services = {}
local SUFFIXES = { "", "K", "M", "B", "T", "Qa", "Qi" }

function xDTaraZ.Util.Try(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("[OpenSea]", err) end
    return ok, err
end

function xDTaraZ.Util.Service(name)
    services[name] = services[name] or Knit.GetService(name)
    return services[name]
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

function xDTaraZ.Util.Notify(text)
    State.Messages[#State.Messages + 1] = text
end

---@return string[]  lowest rarity first
function xDTaraZ.Util.RarityNames()
    local names = {}
    for name in pairs(GameLib.Rarities) do names[#names + 1] = name end
    table.sort(names, function(a, b) return GameLib.Rarities[a] < GameLib.Rarities[b] end)
    return names
end

function xDTaraZ.Util.MutationNames()
    local names = {}
    for id, info in pairs(GameLib.Mutations) do
        if type(info) == "table" then names[#names + 1] = info.name or id end
    end
    table.sort(names)
    return names
end

function xDTaraZ.Data.Get()
    return Knit.GetController("ReplicaController"):GetPlayerData()
end

function xDTaraZ.Data.Cash()
    return xDTaraZ.Data.Get().Currencies.Cash
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

---@return number  items taken this wave
function xDTaraZ.Loot.RunOnce()
    local waves = xDTaraZ.Util.Service("WaveService")
    local wave = waves:Start(Config.WaveExtension)
    if type(wave) ~= "table" or not wave.spawns then return 0 end

    local picked = xDTaraZ.Loot.PickBest(wave.spawns, xDTaraZ.Data.MaxPickup())
    if #picked == 0 then picked = xDTaraZ.Loot.PickBest(wave.spawns, 0) end

    waves:Finished(picked)
    State.Looted += #picked
    return #picked
end

function xDTaraZ.Loot.Worker()
    while State.Alive and State.Opt.AutoLoot do
        if not xDTaraZ.Util.Try(xDTaraZ.Loot.RunOnce) then task.wait(1) end
        task.wait()
    end
end

function xDTaraZ.Loot.SetEnabled(enabled)
    State.Opt.AutoLoot = enabled
    if not enabled then return end
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

---@return number  eggs placed
function xDTaraZ.Hatch.PlaceBest()
    local plot = xDTaraZ.Hatch.MyPlot()
    local surface = plot and plot:FindFirstChild("PlotSurface")
    local part = surface and (surface:IsA("BasePart") and surface or surface:FindFirstChildWhichIsA("BasePart", true))
    if not part then return 0 end

    local eggs, placed = xDTaraZ.Util.Service("EggService"), 0
    for i, egg in ipairs(xDTaraZ.Hatch.RankedEggs()) do
        if i > Config.PlaceEggTries then break end
        local offset = Vector3.new((math.random() - 0.5) * part.Size.X * 0.8, part.Size.Y / 2 + 1, (math.random() - 0.5) * part.Size.Z * 0.8)
        if not eggs:PlaceEgg(egg.id, CFrame.new(part.Position + offset)) then break end
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
    xDTaraZ.Progress.StartTraining()
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

function xDTaraZ.Movement.Step()
    local hum = xDTaraZ.Movement.Humanoid()
    if not hum then return end
    if State.Opt.Speed then hum.WalkSpeed = State.Opt.SpeedValue end
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
    if hum then hum.WalkSpeed = xDTaraZ.Data.Get().Upgrades.MovementSpeed or 16 end
end

xDTaraZ.Scheduler.Requests = {
    LootOnce = function()
        local ok, count = xDTaraZ.Util.Try(xDTaraZ.Loot.RunOnce)
        xDTaraZ.Util.Notify(ok and ("Collected %d item(s)"):format(count) or "Wave not ready")
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
}

function xDTaraZ.Scheduler.Summarize()
    local profile = xDTaraZ.Data.Get()
    local cash = profile.Currencies.Cash
    State.StartCash = State.StartCash or cash
    State.Cash = cash
    State.Summary = ("Cash %s (+%s)\nItems looted %d · Carry %d · Rebirth %d\nInventory %d"):format(
        xDTaraZ.Util.Abbreviate(cash), xDTaraZ.Util.Abbreviate(cash - State.StartCash),
        State.Looted, profile.Upgrades.Carry or 1, profile.Rebirth or 0,
        xDTaraZ.Util.Count(profile.Inventory))
end

function xDTaraZ.Scheduler.Step()
    local opt, now = State.Opt, os.clock()
    xDTaraZ.Util.Try(xDTaraZ.Scheduler.Summarize)

    for name, handler in pairs(xDTaraZ.Scheduler.Requests) do
        if State.Requests[name] then
            State.Requests[name] = nil
            xDTaraZ.Util.Try(handler)
        end
    end

    if now - State.LastSell >= Config.SellInterval then
        State.LastSell = now
        if opt.AutoHatch then xDTaraZ.Util.Try(xDTaraZ.Hatch.Step) end
        if opt.AutoSellEggs then xDTaraZ.Sell.EggsNow() end
        if opt.AutoSellBrainrots then xDTaraZ.Sell.BrainrotsNow() end
        if opt.AutoEquipBest then xDTaraZ.Progress.EquipBest() end
    end

    if now - State.LastUpgrade >= Config.UpgradeInterval then
        State.LastUpgrade = now
        if opt.AutoUpgrade then xDTaraZ.Progress.UpgradeNow() end
        if opt.AutoRebirth then xDTaraZ.Progress.RebirthNow() end
        if opt.AutoBuyTool then xDTaraZ.Progress.BuyBestTool() end
        if opt.AutoTrain then xDTaraZ.Progress.StartTraining() end
    end

    if opt.AutoClaim and now - State.LastClaim >= Config.ClaimInterval then
        State.LastClaim = now
        xDTaraZ.Claim.All()
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
    State.Opt.AutoLoot = false
    for _, conn in ipairs(State.Conns) do conn:Disconnect() end
    table.clear(State.Conns)
    if State.Opt.Noclip then xDTaraZ.Movement.RestoreCollision() end
    if State.Opt.Speed then xDTaraZ.Util.Try(xDTaraZ.Movement.ResetSpeed) end
end

local function BuildInterface()
    local Library = loadstring(game:HttpGet(Config.UiSource))()
    MarioBanner.Step("UI library")
    local Options = Library.Options
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt

    local rarityNames = xDTaraZ.Util.RarityNames()
    local keepValues = table.clone(rarityNames)
    for _, name in ipairs(xDTaraZ.Util.MutationNames()) do keepValues[#keepValues + 1] = name end

    local function Notify(text, kind)
        Library:Notify("Open Sea For Animals", text, 4, kind or "Info")
    end

    local function Request(name)
        return function() State.Requests[name] = true end
    end

    local function Store(key, onChange)
        return function(value)
            opt[key] = value
            if onChange then onChange(value) end
        end
    end

    ---@param info table  Now = { en, th, request name }
    local function Feature(group, key, info)
        local spec = {
            Text = info.Text,
            Description = info.Description,
            Icon = info.Icon,
            Risky = info.Risky,
            Keybind = { Default = "None", Mode = "Toggle" },
            Callback = Store(key, info.OnChange),
            Options = info.Options,
        }
        if info.Now then
            spec.Now = { Text = T(info.Now[1], info.Now[2]), Icon = info.Icon, Callback = Request(info.Now[3]) }
        end
        return group:AddFeature(key, spec)
    end

    local function Chips(group, key, info)
        return group:AddMultiChips(key, {
            Text = info.Text,
            Description = info.Description,
            Icon = info.Icon,
            Values = info.Values,
            Default = info.Default or {},
            Callback = function(selected) opt[key] = selected end,
        })
    end

    local function BuildMain(window)
        window:AddTabSection(T("Main", "หลัก"))
        local tab = window:AddTab(T("Main", "หลัก"), "house", T("Status, Kaitun and links", "สถานะ ไก่ตัน และลิงก์"))

        local status = tab:AddLeftGroupbox(T("Status", "สถานะ"), "status")
        status:AddStat("StatCash", { Text = T("Cash earned", "เงินที่ได้"), Icon = "cash", Format = "%s", Token = "Coin" })
        status:AddStat("StatLooted", { Text = T("Items looted", "ของที่เก็บได้"), Icon = "treasure", Format = "%s", Token = "Good" })
        local summary = status:AddLabel("Loading...", true)

        local kaitun = tab:AddRightGroupbox("Kaitun", "kaitun")
        kaitun:AddFeature("Kaitun", {
            Text = T("Kaitun", "ไก่ตัน"),
            Description = T("Loot, sell, upgrades, rebirth and rewards together", "เก็บของ ขาย อัปเกรด รีเบิร์ธ และรับรางวัลพร้อมกัน"),
            Icon = "kaitun",
            NoSave = true,
            Keybind = { Default = "None", Mode = "Toggle" },
            Callback = function(value)
                for _, key in ipairs({ "AutoLoot", "AutoSellEggs", "AutoTrain", "AutoHatch", "AutoBuyTool", "AutoUpgrade", "AutoRebirth", "AutoClaim", "AutoEquipBest" }) do
                    Options[key]:SetValue(value)
                end
            end,
        })

        Library.Kit.Discord.Build(tab, Config.Discord)
        return summary
    end

    local function BuildFarm(window)
        window:AddTabSection(T("Farm", "ฟาร์ม"))
        local tab = window:AddTab(T("Loot", "เก็บของ"), "treasure", T("Sea loot and hatching", "เก็บของในทะเลและฟักไข่"))

        local loot = tab:AddLeftGroupbox(T("Sea Loot", "เก็บของในทะเล"), "waves")
        Feature(loot, "AutoLoot", {
            Text = T("Auto Loot", "เก็บของอัตโนมัติ"),
            Description = T("Best eggs and brainrots from every wave, without leaving base", "เก็บไข่และ brainrot ดีสุดทุกคลื่น ไม่ต้องออกจากฐาน"),
            Icon = "autocollect",
            OnChange = xDTaraZ.Loot.SetEnabled,
            Now = { "Loot Once", "เก็บหนึ่งรอบ", "LootOnce" },
            Options = function(options)
                Chips(options, "LootKeep", {
                    Text = T("Only Collect", "เก็บเฉพาะ"),
                    Description = T("None selected takes the best item", "ไม่เลือก = เอาชิ้นดีสุด"),
                    Icon = "filters",
                    Values = keepValues,
                })
            end,
        })

        local hatch = tab:AddRightGroupbox(T("Plot", "พื้นที่"), "plot")
        Feature(hatch, "AutoHatch", {
            Text = T("Auto Hatch", "ฟักไข่อัตโนมัติ"),
            Description = T("Hatches your most valuable eggs and places the best animals", "ฟักไข่ที่มีค่าที่สุด แล้ววางสัตว์ตัวดีสุด"),
            Icon = "hatch",
            Now = { "Hatch Now", "ฟักเดี๋ยวนี้", "HatchNow" },
        })
        Feature(hatch, "AutoEquipBest", {
            Text = T("Auto Place Best", "วางตัวดีสุดอัตโนมัติ"),
            Description = T("Keeps your best animals on your plot", "วางสัตว์ตัวดีสุดบนพื้นที่เสมอ"),
            Icon = "best",
        })

        local sell = window:AddTab(T("Sell", "ขาย"), "sell-all", T("Eggs and brainrots", "ไข่และ brainrot"))
        local eggs = sell:AddLeftGroupbox(T("Eggs", "ไข่"), "eggs")
        Feature(eggs, "AutoSellEggs", {
            Text = T("Auto Sell Eggs", "ขายไข่อัตโนมัติ"),
            Description = T("Sells new eggs except the ones you keep", "ขายไข่ที่ได้มา ยกเว้นที่เลือกเก็บ"),
            Icon = "autosell",
            Now = { "Sell Eggs Now", "ขายไข่เดี๋ยวนี้", "SellEggs" },
            Options = function(options)
                Chips(options, "SellKeep", {
                    Text = T("Keep", "เก็บไว้"),
                    Description = T("Never sold", "จะไม่ขาย"),
                    Icon = "keep",
                    Values = keepValues,
                })
            end,
        })

        local brainrots = sell:AddRightGroupbox(T("Brainrots", "Brainrots"), "paw")
        Feature(brainrots, "AutoSellBrainrots", {
            Text = T("Auto Sell Brainrots", "ขาย brainrot อัตโนมัติ"),
            Description = T("Sells every brainrot in your inventory", "ขาย brainrot ทั้งหมดในกระเป๋า"),
            Icon = "sell-all",
            Risky = true,
            Now = { "Sell Brainrots Now", "ขาย brainrot เดี๋ยวนี้", "SellBrainrots" },
        })
    end

    local function BuildProgress(window)
        window:AddTabSection(T("Progress", "ความคืบหน้า"))
        local tab = window:AddTab(T("Upgrade", "อัปเกรด"), "upgrades", T("Upgrades, power and rebirth", "อัปเกรด พลัง และรีเบิร์ธ"))

        local upgrades = tab:AddLeftGroupbox(T("Upgrades", "อัปเกรด"), "upgrades")
        Feature(upgrades, "AutoUpgrade", {
            Text = T("Auto Upgrade", "อัปเกรดอัตโนมัติ"),
            Description = T("Buys the selected upgrades when you can afford them", "ซื้ออัปเกรดที่เลือกเมื่อเงินพอ"),
            Icon = "level-up",
            Now = { "Upgrade Now", "อัปเกรดเดี๋ยวนี้", "UpgradeNow" },
            Options = function(options)
                Chips(options, "UpgradePick", {
                    Text = T("Upgrades", "อัปเกรด"),
                    Description = T("Carry brings back more items per wave", "Carry ขนของกลับได้มากขึ้นต่อคลื่น"),
                    Icon = "list-ordered",
                    Values = Config.UpgradeNames,
                    Default = Config.UpgradeNames,
                })
                options:AddInput("CashReserve", {
                    Text = T("Keep Cash", "กันเงินไว้"),
                    Description = T("Never spend below this amount", "ไม่ใช้เงินจนต่ำกว่าจำนวนนี้"),
                    Icon = "wallet",
                    Default = "0",
                    Numeric = true,
                    Finished = true,
                    Callback = function(value) opt.CashReserve = math.max(0, tonumber(value) or 0) end,
                })
            end,
        })

        local power = tab:AddLeftGroupbox(T("Power", "พลัง"), "weight")
        Feature(power, "AutoTrain", {
            Text = T("Auto Train", "ฝึกอัตโนมัติ"),
            Description = T("More power reaches rarer eggs further out", "พลังยิ่งเยอะยิ่งเอื้อมถึงไข่หายากที่ไกลขึ้น"),
            Icon = "train",
        })
        Feature(power, "AutoBuyTool", {
            Text = T("Auto Buy Best Dumbbell", "ซื้อดัมเบลล์ดีสุดอัตโนมัติ"),
            Description = T("Buys and equips the strongest one you can afford", "ซื้อและใส่อันที่แรงสุดที่ซื้อไหว"),
            Icon = "autobuy",
            Now = { "Buy Now", "ซื้อเดี๋ยวนี้", "ToolNow" },
        })

        local rebirth = tab:AddRightGroupbox(T("Rebirth", "รีเบิร์ธ"), "rebirths")
        Feature(rebirth, "AutoRebirth", {
            Text = T("Auto Rebirth", "รีเบิร์ธอัตโนมัติ"),
            Description = T("Rebirths as soon as you qualify", "รีเบิร์ธทันทีเมื่อครบเงื่อนไข"),
            Icon = "rebirths",
            Now = { "Rebirth Now", "รีเบิร์ธเดี๋ยวนี้", "RebirthNow" },
        })

        local rewards = window:AddTab(T("Rewards", "รางวัล"), "rewards", T("Daily, playtime and codes", "รายวัน เวลาเล่น และโค้ด"))
        local claim = rewards:AddLeftGroupbox(T("Rewards", "รางวัล"), "gift")
        Feature(claim, "AutoClaim", {
            Text = T("Auto Claim", "รับรางวัลอัตโนมัติ"),
            Description = T("Daily, playtime, spins, free shop, packs and offline cash", "รายวัน เวลาเล่น วงล้อ ร้านฟรี แพ็ก และเงินตอนออฟไลน์"),
            Icon = "autoclaim",
            Now = { "Claim All Now", "รับทั้งหมดเดี๋ยวนี้", "ClaimNow" },
        })

        local codes = rewards:AddRightGroupbox(T("Codes", "โค้ด"), "codes")
        codes:AddButton({ Text = T("Redeem All Codes", "ใช้โค้ดทั้งหมด"), Icon = "redeem-codes", Style = "Primary", Callback = Request("RedeemAll") })
        codes:AddInput("CodeBox", {
            Text = T("Redeem Codes", "ใส่โค้ด"),
            Description = T("Separate codes with commas", "คั่นโค้ดด้วยจุลภาค"),
            Icon = "code",
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
        window:AddTabSection(T("Misc", "อื่นๆ"))
        local tab = window:AddTab(T("Player", "ผู้เล่น"), "player", T("Movement and session", "การเคลื่อนที่และเซสชัน"))

        local move = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"), "movement")
        Feature(move, "Speed", {
            Text = T("Speed", "ความเร็ว"),
            Icon = "walkspeed",
            OnChange = function(value)
                if not value then State.Requests.ResetSpeed = true end
            end,
            Options = function(options)
                options:AddSlider("SpeedValue", {
                    Text = T("Walk Speed", "ความเร็วเดิน"),
                    Icon = "sprint",
                    Default = opt.SpeedValue,
                    Min = 16,
                    Max = 300,
                    Rounding = 0,
                    Callback = function(value) opt.SpeedValue = tonumber(value) or opt.SpeedValue end,
                })
            end,
        })
        Feature(move, "InfJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด"), Icon = "infinite-jump" })
        Feature(move, "Noclip", {
            Text = T("Noclip", "ทะลุวัตถุ"),
            Icon = "no-clip",
            OnChange = function(value)
                if not value then xDTaraZ.Movement.RestoreCollision() end
            end,
        })

        local session = tab:AddRightGroupbox(T("Session", "เซสชัน"), "session")
        session:AddToggle("AntiAfk", {
            Text = T("Anti AFK", "กันหลุด AFK"),
            Description = T("Stay in the server while idle", "อยู่ในเซิร์ฟต่อได้แม้ไม่ได้ขยับ"),
            Icon = "anti-afk",
            Callback = Store("AntiAfk"),
        })
        session:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟเดิมใหม่"), Icon = "re-join", Style = "Ghost", Callback = function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end })
    end

    local function BuildTabs()
        local window = Library.Window
        local summary = BuildMain(window)
        BuildFarm(window)
        BuildProgress(window)
        BuildPlayer(window)
        window:AddSettingsTab()

        Library:Every(1, function()
            while #State.Messages > 0 do Notify(table.remove(State.Messages, 1)) end
            summary:SetText(State.Summary)
            if State.StartCash and State.Cash then Options.StatCash:SetValue(State.Cash - State.StartCash) end
            Options.StatLooted:SetValue(State.Looted)
        end)
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
            xDTaraZ.Scheduler.Boot()
            Notify("Loaded")
            Library:LoadAutoloadConfig()
        end,
    })
end

if getgenv().OpenSeaUnload then
    pcall(getgenv().OpenSeaUnload)
end

MarioBanner.Step("Systems")
BuildInterface()
MarioBanner.Step("Interface")
MarioBanner.Ready()