if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId ~= 66654135 then
    game:GetService("Players").LocalPlayer:Kick("Mario Hub: this script is for Murder Mystery 2 only")
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
        "   MURDER MYSTERY 2  //  by xDTaraZ  //  discord.gg/FHVfmeSceA",
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
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

local xDTaraZ = setmetatable({}, {
    __newindex = function(self, key, value)
        rawset(self, key, type(value) == "function" and LPH_JIT(value) or value)
    end,
})

xDTaraZ.Config = {
    Discord = "https://discord.gg/FHVfmeSceA",
    UiSource = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/ui.lua",
    SaveFolder = "Murder Mystery 2",
    LoadTimeout = 10,
    AlertTries = 20,
    AlertRetry = 0.5,
    JobFailLimit = 5,
    JobFailWindow = 10,
    StatusRefresh = 1,
    TickDelay = 0.5,
    RoleRefresh = 1,
    ShootStands = { Vector3.new(0, 0, 6), Vector3.new(0, 0, -6), Vector3.new(6, 0, 0), Vector3.new(-6, 0, 0), Vector3.new(0, 6, 3) },
    ShootAttempts = 3,
    ShootConfirm = 0.8,
    ShootSettle = 0.25,
    ShootReturn = 0.3,
    ShootCooldown = 1.2,
    StabCooldown = 0.9,
    BusyTimeout = 6,
    StabOffset = 2,
    KillAuraRange = 18,
    GunGrabHold = 0.35,
    FarmSpeed = 25,
    FarmSpeedMax = 28,
    FarmMurdererRadius = 30,
    FarmArrive = 1.5,
    FarmBrake = 20,
    FarmGroundLift = 4,
    FarmGroundReach = 400,
    FarmIdleWait = 0.3,
    FarmSettle = 0.15,
    FarmSkipTime = 4,
    FlingVelocityCap = 120,
    XRayTransparency = 0.6,
    DodgeRange = 22,
    DodgeCooldown = 2.5,
    VictimPriority = { Sheriff = 1, Hero = 1, Innocent = 2 },
    FlingForce = 9e4,
    FlingTime = 2.5,
    FlySpeed = 70,
    SpeedDefault = 16,
    JumpDefault = 50,
    LobbyName = "RegularLobby",
    Colors = {
        Murderer = Color3.fromHSV(0, 0.75, 1),
        Sheriff = Color3.fromHSV(0.6, 0.7, 1),
        Hero = Color3.fromHSV(0.14, 0.8, 1),
        Innocent = Color3.fromHSV(0.33, 0.6, 0.95),
        Gun = Color3.fromHSV(0.12, 0.9, 1),
        Coin = Color3.fromHSV(0.15, 0.6, 1),
    },
}

local Config = xDTaraZ.Config

xDTaraZ.State = {
    Alive = true,
    Conns = {},
    Roles = {},
    LastRoleFetch = 0,
    LastShoot = 0,
    LastStab = 0,
    ActionBusy = false,
    BusySince = 0,
    ShootBusy = false,
    LastDodge = 0,
    FarmBusy = false,
    FarmHome = nil,
    FarmMover = nil,
    Bag = { Current = 0, Max = 0 },
    SkippedCoins = {},
    XRayMap = nil,
    XRayParts = {},
    Skins = {},
    KillBusy = false,
    NoclipConn = nil,
    NoclipSaved = {},
    FlyConn = nil,
    FlyVelocity = nil,
    StickTarget = nil,
    Hook = nil,
    Esp = { Players = {}, Gun = nil },
    LightingDefaults = nil,
    Halted = {},
    Opt = {
        AutoGrabGun = false,
        AutoShoot = false,
        SilentAim = false,
        AutoKillAll = false,
        KillAura = false,
        KnifeAim = false,
        AutoDodge = false,
        Kaitun = false,
        AutoFarm = false,
        FarmSpeed = 25,
        ResetWhenFull = false,
        AntiFling = false,
        XRay = false,
        Aimbot = false,
        AimSmooth = 70,
        SkinSource = nil,
        EspPlayers = false,
        EspGun = false,
        RoleNotify = false,
        SpeedOn = false,
        WalkSpeed = 24,
        JumpOn = false,
        JumpPower = 70,
        InfJump = false,
        Noclip = false,
        Fly = false,
        Fullbright = false,
        AntiAfk = false,
        TrollTarget = nil,
        TeleportTarget = nil,
    },
}

local State = xDTaraZ.State

for _, name in ipairs({ "Util", "Round", "Sheriff", "Murderer", "Troll", "Survive", "Kaitun", "Farm", "Aim", "Skin", "Teleport", "Movement", "Esp", "Visual", "Session", "Scheduler" }) do
    xDTaraZ[name] = {}
end

function xDTaraZ.Util.Try(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then
        warn("[MM2]", err)
    end
    return ok, err
end

---@param text string  shown as a Roblox notification, works before the menu exists
function xDTaraZ.Util.Alert(text)
    warn("[MM2] " .. text)
    task.spawn(function()
        local starterGui = game:GetService("StarterGui")
        for _ = 1, Config.AlertTries do
            if pcall(starterGui.SetCore, starterGui, "SendNotification", { Title = "Mario Hub", Text = text, Duration = 10 }) then
                return
            end
            task.wait(Config.AlertRetry)
        end
    end)
end

---@return string?  body, nil when every way to fetch failed
function xDTaraZ.Util.HttpGet(url)
    local ok, body = pcall(game.HttpGet, game, url)
    if ok and type(body) == "string" then
        return body
    end
    local send = (type(request) == "function" and request) or (type(http_request) == "function" and http_request)
        or (type(syn) == "table" and syn.request) or (type(http) == "table" and http.request)
    if type(send) ~= "function" then
        return nil
    end
    local sent, response = pcall(send, { Url = url, Method = "GET" })
    if sent and type(response) == "table" and tonumber(response.StatusCode) == 200 and type(response.Body) == "string" then
        return response.Body
    end
    return nil
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
    if type(library.Compat) ~= "table" then
        xDTaraZ.Util.Alert("The menu is out of date. Wait a few minutes and run the script again.")
        return nil
    end
    return library
end

---@param instance Instance  parented to gethui, then CoreGui, then PlayerGui
function xDTaraZ.Util.Mount(instance)
    local ok, hui = pcall(gethui)
    if ok and typeof(hui) == "Instance" and pcall(function() instance.Parent = hui end) then
        return
    end
    if pcall(function() instance.Parent = game:GetService("CoreGui") end) then
        return
    end
    instance.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", Config.LoadTimeout)
end

local Remotes = ReplicatedStorage:WaitForChild("Remotes", Config.LoadTimeout)
local GameplayRemotes = Remotes and Remotes:WaitForChild("Gameplay", Config.LoadTimeout)
if not GameplayRemotes then
    xDTaraZ.Util.Alert("Murder Mystery 2 has not finished loading. Rejoin and run the script again.")
    return
end

function xDTaraZ.Util.Connect(signal, fn)
    local conn = signal:Connect(fn)
    table.insert(State.Conns, conn)
    return conn
end

function xDTaraZ.Util.Root(player)
    local character = (player or LocalPlayer).Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

function xDTaraZ.Util.Humanoid(player)
    local character = (player or LocalPlayer).Character
    return character and character:FindFirstChildOfClass("Humanoid")
end

function xDTaraZ.Util.Tool(player, name)
    local character = player.Character
    local backpack = player:FindFirstChild("Backpack")
    return (character and character:FindFirstChild(name)) or (backpack and backpack:FindFirstChild(name))
end

function xDTaraZ.Round.RefreshRoles()
    if os.clock() - State.LastRoleFetch < Config.RoleRefresh then
        return
    end
    State.LastRoleFetch = os.clock()
    local ok, roster = pcall(GameplayRemotes.GetCurrentPlayerData.InvokeServer, GameplayRemotes.GetCurrentPlayerData)
    if ok and type(roster) == "table" then
        State.Roles = roster
    end
end

---@return string?  role, falls back to the tools in their backpack
function xDTaraZ.Round.RoleOf(player)
    local entry = State.Roles[player.Name]
    if entry and not entry.Dead and entry.Role then
        return entry.Role
    end
    if xDTaraZ.Util.Tool(player, "Knife") then
        return "Murderer"
    end
    if xDTaraZ.Util.Tool(player, "Gun") then
        return "Sheriff"
    end
    return entry and entry.Dead and "Dead" or "Innocent"
end

function xDTaraZ.Round.FindByRole(role)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and xDTaraZ.Round.RoleOf(player) == role and xDTaraZ.Util.Root(player) then
            return player
        end
    end
    return nil
end

function xDTaraZ.Round.Map()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name ~= Config.LobbyName and child:IsA("Model") and child:FindFirstChild("CoinContainer") then
            return child
        end
    end
    return nil
end

function xDTaraZ.Round.IAmPlaying()
    local entry = State.Roles[LocalPlayer.Name]
    local humanoid = xDTaraZ.Util.Humanoid()
    return xDTaraZ.Round.Map() ~= nil and humanoid ~= nil and humanoid.Health > 0 and entry ~= nil and not entry.Dead
end

function xDTaraZ.Round.GunDrop()
    local map = xDTaraZ.Round.Map()
    local drop = (map and map:FindFirstChild("GunDrop", true)) or workspace:FindFirstChild("GunDrop")
    return drop
end

function xDTaraZ.Movement.SetNoclip(enabled)
    if State.NoclipConn then
        State.NoclipConn:Disconnect()
        State.NoclipConn = nil
    end
    if not enabled then
        xDTaraZ.Movement.RestoreCollision()
        return
    end
    local saved = State.NoclipSaved
    State.NoclipConn = xDTaraZ.Util.Connect(RunService.Stepped, function()
        local character = LocalPlayer.Character
        if not character then return end
        for _, part in ipairs(character:GetChildren()) do
            if not part:IsA("BasePart") then continue end
            if saved[part] == nil then
                saved[part] = part.CanCollide
            end
            part.CanCollide = false
        end
    end)
end

function xDTaraZ.Movement.RestoreCollision()
    for part, canCollide in pairs(State.NoclipSaved) do
        if part.Parent then part.CanCollide = canCollide end
    end
    table.clear(State.NoclipSaved)
end

function xDTaraZ.Movement.RefreshNoclip()
    xDTaraZ.Movement.SetNoclip(State.Opt.Noclip or State.FarmBusy)
end

function xDTaraZ.Movement.Apply()
    local humanoid = xDTaraZ.Util.Humanoid()
    if not humanoid then
        return
    end
    local opt = State.Opt
    if opt.SpeedOn then
        humanoid.WalkSpeed = opt.WalkSpeed
    end
    if opt.JumpOn then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = opt.JumpPower
    end
end

function xDTaraZ.Movement.RestoreSpeed()
    local humanoid = xDTaraZ.Util.Humanoid()
    if humanoid then
        humanoid.WalkSpeed = Config.SpeedDefault
    end
end

function xDTaraZ.Movement.RestoreJump()
    local humanoid = xDTaraZ.Util.Humanoid()
    if humanoid then
        humanoid.JumpPower = Config.JumpDefault
    end
end

function xDTaraZ.Movement.InitInfJump()
    xDTaraZ.Util.Connect(UserInputService.JumpRequest, function()
        local humanoid = xDTaraZ.Util.Humanoid()
        if State.Opt.InfJump and humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

function xDTaraZ.Movement.SetFly(enabled)
    if State.FlyConn then
        State.FlyConn:Disconnect()
        State.FlyConn = nil
    end
    if State.FlyVelocity then
        State.FlyVelocity:Destroy()
        State.FlyVelocity = nil
    end
    local humanoid = xDTaraZ.Util.Humanoid()
    if humanoid then
        humanoid.PlatformStand = false
    end
    if not enabled then
        return
    end
    local mover = Instance.new("BodyVelocity")
    mover.MaxForce = Vector3.one * 1e9
    mover.Velocity = Vector3.zero
    State.FlyVelocity = mover
    State.FlyConn = xDTaraZ.Util.Connect(RunService.RenderStepped, function()
        local root, hum = xDTaraZ.Util.Root(), xDTaraZ.Util.Humanoid()
        if not root or not hum then
            return
        end
        mover.Parent = root
        hum.PlatformStand = true
        local vertical = (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0)
        mover.Velocity = (hum.MoveDirection + Vector3.yAxis * vertical) * Config.FlySpeed
    end)
end

function xDTaraZ.Util.Busy()
    return State.ActionBusy and os.clock() - State.BusySince < Config.BusyTimeout
end

function xDTaraZ.Util.SetBusy(busy)
    State.ActionBusy = busy
    State.BusySince = os.clock()
end

---@return any  result of action, character moved back after
function xDTaraZ.Util.WarpAndReturn(targetCFrame, action)
    local root = xDTaraZ.Util.Root()
    if not root or not targetCFrame or xDTaraZ.Util.Busy() then
        return false
    end
    xDTaraZ.Util.SetBusy(true)
    local home = root.CFrame
    local ok = xDTaraZ.Util.Try(function()
        root.CFrame = targetCFrame
        root.AssemblyLinearVelocity = Vector3.zero
        action()
    end)
    local current = xDTaraZ.Util.Root()
    if current then
        current.CFrame = home
    end
    xDTaraZ.Util.SetBusy(false)
    return ok
end

function xDTaraZ.Sheriff.Gun()
    return xDTaraZ.Util.Tool(LocalPlayer, "Gun")
end

function xDTaraZ.Sheriff.Equip(tool)
    local humanoid = xDTaraZ.Util.Humanoid()
    if humanoid and tool.Parent ~= LocalPlayer.Character then
        humanoid:EquipTool(tool)
    end
end

function xDTaraZ.Sheriff.ClearStand(target, targetRoot)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LocalPlayer.Character, target.Character }
    for _, offset in ipairs(Config.ShootStands) do
        local position = (targetRoot.CFrame * CFrame.new(offset)).Position
        if not workspace:Raycast(position, targetRoot.Position - position, params) then
            return CFrame.lookAt(position, targetRoot.Position)
        end
    end
    return CFrame.lookAt((targetRoot.CFrame * CFrame.new(Config.ShootStands[1])).Position, targetRoot.Position)
end

function xDTaraZ.Sheriff.ShootTarget(target)
    local gun, targetRoot = xDTaraZ.Sheriff.Gun(), xDTaraZ.Util.Root(target)
    if not gun or not targetRoot or os.clock() - State.LastShoot < Config.ShootCooldown then
        return false
    end
    State.LastShoot = os.clock()
    xDTaraZ.Sheriff.Equip(gun)
    return xDTaraZ.Util.WarpAndReturn(xDTaraZ.Sheriff.ClearStand(target, targetRoot), function()
        task.wait(Config.ShootSettle)
        local root = xDTaraZ.Util.Root()
        local attachment = root and root:FindFirstChild("GunRaycastAttachment")
        local aimRoot = xDTaraZ.Util.Root(target) or targetRoot
        gun.Shoot:FireServer(attachment and attachment.WorldCFrame or root.CFrame, aimRoot.CFrame)
        task.wait(Config.ShootReturn)
    end)
end

function xDTaraZ.Util.IsDead(player)
    local humanoid = xDTaraZ.Util.Humanoid(player)
    return not humanoid or humanoid.Health <= 0
end

function xDTaraZ.Sheriff.ShootMurderer()
    xDTaraZ.Round.RefreshRoles()
    local murderer = xDTaraZ.Round.FindByRole("Murderer")
    if not murderer then
        return false, "No murderer found"
    end
    for _ = 1, Config.ShootAttempts do
        if not xDTaraZ.Sheriff.Gun() then
            break
        end
        xDTaraZ.Sheriff.ShootTarget(murderer)
        task.wait(Config.ShootConfirm)
        if xDTaraZ.Util.IsDead(murderer) then
            return true, murderer.Name
        end
        task.wait(math.max(0, Config.ShootCooldown - Config.ShootConfirm))
    end
    return false, murderer.Name .. " survived"
end

function xDTaraZ.Sheriff.AutoShootStep()
    if not State.Opt.AutoShoot or State.ShootBusy or not xDTaraZ.Sheriff.Gun() or not xDTaraZ.Round.IAmPlaying() then
        return
    end
    State.ShootBusy = true
    task.spawn(function()
        xDTaraZ.Util.Try(xDTaraZ.Sheriff.ShootMurderer)
        State.ShootBusy = false
    end)
end

function xDTaraZ.Sheriff.GrabGun()
    local drop = xDTaraZ.Round.GunDrop()
    if not drop or xDTaraZ.Sheriff.Gun() or not xDTaraZ.Round.IAmPlaying() then
        return false
    end
    local part = drop:IsA("BasePart") and drop or drop:FindFirstChildWhichIsA("BasePart", true)
    if not part then
        return false
    end
    return xDTaraZ.Util.WarpAndReturn(part.CFrame, function()
        local root = xDTaraZ.Util.Root()
        if root and xDTaraZ.Library.Compat.Caps.Touch then
            firetouchinterest(root, part, 0)
            firetouchinterest(root, part, 1)
        end
        task.wait(Config.GunGrabHold)
    end)
end

function xDTaraZ.Sheriff.AutoGrabStep()
    if State.Opt.AutoGrabGun and xDTaraZ.Round.RoleOf(LocalPlayer) ~= "Murderer" and xDTaraZ.Round.GunDrop() then
        task.spawn(xDTaraZ.Sheriff.GrabGun)
    end
end

function xDTaraZ.Murderer.Knife()
    return xDTaraZ.Util.Tool(LocalPlayer, "Knife")
end

function xDTaraZ.Murderer.Stab(target)
    local knife, targetRoot = xDTaraZ.Murderer.Knife(), xDTaraZ.Util.Root(target)
    if not knife or not targetRoot then
        return false
    end
    xDTaraZ.Sheriff.Equip(knife)
    local events = knife:FindFirstChild("Events")
    if not events then
        return false
    end
    local stand = targetRoot.CFrame * CFrame.new(0, 0, Config.StabOffset)
    return xDTaraZ.Util.WarpAndReturn(stand, function()
        events.KnifeStabbed:FireServer()
        task.wait()
        local aimRoot = xDTaraZ.Util.Root(target) or targetRoot
        events.HandleTouched:FireServer(aimRoot)
        task.wait(Config.StabCooldown)
    end)
end

function xDTaraZ.Murderer.Victims()
    local victims = {}
    for _, player in ipairs(Players:GetPlayers()) do
        local humanoid = xDTaraZ.Util.Humanoid(player)
        local entry = State.Roles[player.Name]
        local inRound = entry == nil or not entry.Dead
        if player ~= LocalPlayer and humanoid and humanoid.Health > 0 and inRound and xDTaraZ.Util.Root(player) then
            table.insert(victims, player)
        end
    end
    table.sort(victims, function(a, b)
        return (Config.VictimPriority[xDTaraZ.Round.RoleOf(a)] or 3) < (Config.VictimPriority[xDTaraZ.Round.RoleOf(b)] or 3)
    end)
    return victims
end

function xDTaraZ.Murderer.KillAll()
    if not xDTaraZ.Murderer.Knife() then
        return 0
    end
    local kills = 0
    for _, victim in ipairs(xDTaraZ.Murderer.Victims()) do
        if not State.Alive or not xDTaraZ.Murderer.Knife() then
            break
        end
        if xDTaraZ.Murderer.Stab(victim) then
            kills = kills + 1
        end
    end
    return kills
end

function xDTaraZ.Murderer.AutoKillStep()
    if not State.Opt.AutoKillAll or State.KillBusy or not xDTaraZ.Murderer.Knife() or not xDTaraZ.Round.IAmPlaying() then
        return
    end
    State.KillBusy = true
    task.spawn(function()
        xDTaraZ.Util.Try(xDTaraZ.Murderer.KillAll)
        State.KillBusy = false
    end)
end

function xDTaraZ.Murderer.KillAuraStep()
    local knife, root = xDTaraZ.Murderer.Knife(), xDTaraZ.Util.Root()
    if not State.Opt.KillAura or not knife or not root or os.clock() - State.LastStab < Config.StabCooldown then
        return
    end
    local events = knife:FindFirstChild("Events")
    for _, victim in ipairs(xDTaraZ.Murderer.Victims()) do
        local victimRoot = xDTaraZ.Util.Root(victim)
        if events and victimRoot and (victimRoot.Position - root.Position).Magnitude <= Config.KillAuraRange then
            State.LastStab = os.clock()
            xDTaraZ.Sheriff.Equip(knife)
            events.KnifeStabbed:FireServer()
            events.HandleTouched:FireServer(victimRoot)
            return
        end
    end
end

function xDTaraZ.Murderer.NearestVictimRoot(origin)
    local best, bestDistance
    for _, victim in ipairs(xDTaraZ.Murderer.Victims()) do
        local victimRoot = xDTaraZ.Util.Root(victim)
        local distance = victimRoot and (victimRoot.Position - origin).Magnitude
        if distance and (not bestDistance or distance < bestDistance) then
            best, bestDistance = victimRoot, distance
        end
    end
    return best
end

---Hooked only while Silent Aim or Knife Throw Aim is on, the original goes back when both are off.
function xDTaraZ.Sheriff.SyncAimHook()
    local wanted = State.Alive and (State.Opt.SilentAim or State.Opt.KnifeAim)
    if wanted and not State.Hook then
        xDTaraZ.Util.Try(xDTaraZ.Sheriff.InstallAimHook)
    elseif not wanted and State.Hook then
        local restore = State.Hook
        State.Hook = nil
        xDTaraZ.Util.Try(restore)
    end
end

function xDTaraZ.Sheriff.InstallAimHook()
    if not xDTaraZ.Library.Compat.Has({ "Namecall", "CheckCaller" }) then return end
    local original, restore
    original, restore = xDTaraZ.Library.Compat.HookMeta(game, "__namecall", function(self, ...)
        if not State.Alive or getnamecallmethod() ~= "FireServer" or checkcaller() then
            return original(self, ...)
        end
        local parent = self.Parent
        local opt = State.Opt
        if opt.SilentAim and self.Name == "Shoot" and parent and parent.Name == "Gun" then
            local murderer = xDTaraZ.Round.FindByRole("Murderer")
            local murdererRoot = murderer and xDTaraZ.Util.Root(murderer)
            if murdererRoot then
                local origin = ...
                return original(self, origin, murdererRoot.CFrame)
            end
        elseif opt.KnifeAim and self.Name == "KnifeThrown" and parent and parent.Name == "Events" then
            local origin = ...
            local victimRoot = xDTaraZ.Murderer.NearestVictimRoot(origin.Position)
            if victimRoot then
                return original(self, origin, victimRoot.Position)
            end
        end
        return original(self, ...)
    end)
    State.Hook = restore
end

function xDTaraZ.Survive.SafestSpot(threatPosition)
    local map = xDTaraZ.Round.Map()
    local best, bestDistance
    for _, coin in ipairs(map and map.CoinContainer:GetChildren() or {}) do
        if coin:IsA("BasePart") then
            local distance = (coin.Position - threatPosition).Magnitude
            if not bestDistance or distance > bestDistance then
                best, bestDistance = coin, distance
            end
        end
    end
    return best and CFrame.new(best.Position + Vector3.new(0, 3, 0))
end

function xDTaraZ.Survive.DodgeStep()
    local root = xDTaraZ.Util.Root()
    local murderer = xDTaraZ.Round.FindByRole("Murderer")
    local threat = murderer and xDTaraZ.Util.Root(murderer)
    if not State.Opt.AutoDodge or not root or not threat or xDTaraZ.Murderer.Knife() or xDTaraZ.Util.Busy() then
        return
    end
    if os.clock() - State.LastDodge < Config.DodgeCooldown or (threat.Position - root.Position).Magnitude > Config.DodgeRange then
        return
    end
    local spot = xDTaraZ.Survive.SafestSpot(threat.Position)
    if spot then
        State.LastDodge = os.clock()
        root.CFrame = spot
        root.AssemblyLinearVelocity = Vector3.zero
    end
end

function xDTaraZ.Kaitun.Step()
    if not State.Opt.Kaitun or not xDTaraZ.Round.IAmPlaying() then
        return
    end
    local opt = State.Opt
    opt.AutoKillAll = xDTaraZ.Murderer.Knife() ~= nil
    opt.AutoShoot = xDTaraZ.Sheriff.Gun() ~= nil
    opt.AutoGrabGun = true
    opt.AutoDodge = true
    opt.AutoFarm = true
end

function xDTaraZ.Farm.NearestCoin(map, origin)
    local murderer = not xDTaraZ.Murderer.Knife() and xDTaraZ.Round.FindByRole("Murderer")
    local threat = murderer and xDTaraZ.Util.Root(murderer)
    local best, bestDistance
    for _, coin in ipairs(map.CoinContainer:GetChildren()) do
        local visual = coin:FindFirstChild("CoinVisual")
        local skippedAt = State.SkippedCoins[coin]
        local skipped = skippedAt and os.clock() - skippedAt < Config.FarmSkipTime
        local dangerous = threat and (coin.Position - threat.Position).Magnitude < Config.FarmMurdererRadius
        if coin:IsA("BasePart") and visual and not visual:GetAttribute("Collected") and not skipped and not dangerous then
            local distance = (coin.Position - origin).Magnitude
            if not bestDistance or distance < bestDistance then
                best, bestDistance = coin, distance
            end
        end
    end
    return best
end

function xDTaraZ.Farm.BagFull()
    return State.Bag.Max > 0 and State.Bag.Current >= State.Bag.Max
end

function xDTaraZ.Farm.CanRun()
    return State.Alive and State.Opt.AutoFarm and xDTaraZ.Round.IAmPlaying() and not xDTaraZ.Farm.BagFull()
end

function xDTaraZ.Farm.AttachMover(root)
    local attachment = Instance.new("Attachment")
    attachment.Parent = root
    local mover = Instance.new("LinearVelocity")
    mover.Attachment0 = attachment
    mover.MaxForce = math.huge
    mover.RelativeTo = Enum.ActuatorRelativeTo.World
    mover.VectorVelocity = Vector3.zero
    mover.Parent = root
    State.FarmMover = { Attachment = attachment, Velocity = mover }
    return mover
end

function xDTaraZ.Farm.DetachMover()
    local mover = State.FarmMover
    if mover then
        mover.Velocity:Destroy()
        mover.Attachment:Destroy()
        State.FarmMover = nil
    end
end

function xDTaraZ.Farm.GlideTo(position)
    local root = xDTaraZ.Util.Root()
    local mover = State.FarmMover
    if not root or not mover or mover.Velocity.Parent ~= root then
        xDTaraZ.Farm.DetachMover()
        mover = root and { Velocity = xDTaraZ.Farm.AttachMover(root) }
    end
    while mover and xDTaraZ.Farm.CanRun() and root.Parent do
        local delta = position - root.Position
        if delta.Magnitude <= Config.FarmArrive then
            break
        end
        mover.Velocity.VectorVelocity = delta.Unit * math.min(State.Opt.FarmSpeed, delta.Magnitude * Config.FarmBrake)
        RunService.Heartbeat:Wait()
    end
    if mover then
        mover.Velocity.VectorVelocity = Vector3.zero
    end
end

function xDTaraZ.Farm.Run()
    local root = xDTaraZ.Util.Root()
    if root then
        xDTaraZ.Farm.AttachMover(root)
    end
    xDTaraZ.Movement.RefreshNoclip()
    State.FarmHome = root and root.CFrame
    while xDTaraZ.Farm.CanRun() do
        local map, hrp = xDTaraZ.Round.Map(), xDTaraZ.Util.Root()
        local coin = map and hrp and xDTaraZ.Farm.NearestCoin(map, hrp.Position)
        if coin and not xDTaraZ.Util.Busy() then
            xDTaraZ.Farm.GlideTo(coin.Position)
            task.wait(Config.FarmSettle)
            State.SkippedCoins[coin] = os.clock()
        else
            local mover = State.FarmMover
            if mover then
                mover.Velocity.VectorVelocity = Vector3.zero
            end
            task.wait(Config.FarmIdleWait)
        end
    end
end

---Leaves the character standing on something: back to where the farm started when there is no ground below.
function xDTaraZ.Farm.Settle()
    local root, home = xDTaraZ.Util.Root(), State.FarmHome
    State.FarmHome = nil
    if not root then return end
    root.AssemblyLinearVelocity = Vector3.zero
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LocalPlayer.Character }
    local ground = workspace:Raycast(root.Position + Vector3.new(0, Config.FarmGroundLift, 0), Vector3.new(0, -Config.FarmGroundReach, 0), params)
    if ground or not home then return end
    root.CFrame = home
end

function xDTaraZ.Farm.Step()
    if State.FarmBusy or not xDTaraZ.Farm.CanRun() then return end
    State.FarmBusy = true
    task.spawn(function()
        local ok = xDTaraZ.Util.Try(xDTaraZ.Farm.Run)
        xDTaraZ.Farm.DetachMover()
        xDTaraZ.Farm.Settle()
        State.FarmBusy = false
        xDTaraZ.Movement.RefreshNoclip()

        local humanoid = xDTaraZ.Util.Humanoid()
        if ok and humanoid and State.Opt.ResetWhenFull and xDTaraZ.Farm.BagFull() then
            humanoid.Health = 0
        end
    end)
end

function xDTaraZ.Farm.InitBagTracking()
    xDTaraZ.Util.Connect(GameplayRemotes.CoinCollected.OnClientEvent, function(_, current, maximum)
        State.Bag.Current = tonumber(current) or 0
        State.Bag.Max = tonumber(maximum) or 0
    end)
    xDTaraZ.Util.Connect(GameplayRemotes.CoinsStarted.OnClientEvent, function()
        State.Bag.Current, State.Bag.Max = 0, 0
        table.clear(State.SkippedCoins)
    end)
    xDTaraZ.Util.Connect(GameplayRemotes.RoundStart.OnClientEvent, function()
        State.Bag.Current, State.Bag.Max = 0, 0
        table.clear(State.Roles)
    end)
end

function xDTaraZ.Movement.AntiFlingStep()
    if not State.Opt.AntiFling then
        return
    end
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player ~= LocalPlayer and player.Character
        if character then
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
    local root = xDTaraZ.Util.Root()
    if root and not xDTaraZ.Util.Busy() and not State.Opt.Fly and root.AssemblyLinearVelocity.Magnitude > Config.FlingVelocityCap then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
end

---@return Player?  next victim with the knife, otherwise the murderer
function xDTaraZ.Aim.Target()
    if xDTaraZ.Murderer.Knife() then
        return xDTaraZ.Murderer.Victims()[1]
    end
    return xDTaraZ.Round.FindByRole("Murderer")
end

function xDTaraZ.Aim.Step(dt)
    if not State.Opt.Aimbot then
        return
    end
    local target = xDTaraZ.Aim.Target()
    local head = target and target.Character and target.Character:FindFirstChild("Head")
    if not head then
        return
    end
    local camera = workspace.CurrentCamera
    local goal = CFrame.lookAt(camera.CFrame.Position, head.Position)
    local alpha = 1 - (State.Opt.AimSmooth / 100) ^ (dt * 60)
    camera.CFrame = camera.CFrame:Lerp(goal, math.clamp(alpha, 0, 1))
end

function xDTaraZ.Visual.ClearXRay()
    for part, original in pairs(State.XRayParts) do
        if part.Parent then
            part.Transparency = original
        end
    end
    table.clear(State.XRayParts)
    State.XRayMap = nil
end

function xDTaraZ.Visual.XRayStep()
    if not State.Opt.XRay then
        if State.XRayMap then
            xDTaraZ.Visual.ClearXRay()
        end
        return
    end
    local map = xDTaraZ.Round.Map() or workspace:FindFirstChild(Config.LobbyName)
    if not map or State.XRayMap == map then
        return
    end
    xDTaraZ.Visual.ClearXRay()
    State.XRayMap = map
    local coins = map:FindFirstChild("CoinContainer")
    for _, part in ipairs(map:GetDescendants()) do
        if part:IsA("BasePart") and not (coins and part:IsDescendantOf(coins)) then
            State.XRayParts[part] = part.Transparency
            part.Transparency = math.max(part.Transparency, Config.XRayTransparency)
        end
    end
end

function xDTaraZ.Skin.MeshOf(tool)
    local handle = tool and tool:FindFirstChild("Handle")
    return handle and handle:FindFirstChildWhichIsA("SpecialMesh")
end

function xDTaraZ.Skin.Copy(sourceName, weaponName)
    local source = sourceName and Players:FindFirstChild(sourceName)
    local mesh = source and xDTaraZ.Skin.MeshOf(xDTaraZ.Util.Tool(source, weaponName))
    if not mesh then
        return false
    end
    State.Skins[weaponName] = { MeshId = mesh.MeshId, TextureId = mesh.TextureId, Scale = mesh.Scale }
    return true
end

function xDTaraZ.Skin.ApplyStep()
    for weaponName, look in pairs(State.Skins) do
        local mesh = xDTaraZ.Skin.MeshOf(xDTaraZ.Util.Tool(LocalPlayer, weaponName))
        if mesh and mesh.MeshId ~= look.MeshId then
            mesh.MeshId, mesh.TextureId, mesh.Scale = look.MeshId, look.TextureId, look.Scale
        end
    end
end

function xDTaraZ.Troll.Target()
    return State.Opt.TrollTarget and Players:FindFirstChild(State.Opt.TrollTarget)
end

function xDTaraZ.Troll.Fling(target)
    local root, targetRoot = xDTaraZ.Util.Root(), xDTaraZ.Util.Root(target)
    if not root or not targetRoot or xDTaraZ.Util.Busy() then
        return false
    end
    xDTaraZ.Util.SetBusy(true)
    local home = root.CFrame
    local spin = Instance.new("BodyAngularVelocity")
    spin.MaxTorque = Vector3.one * math.huge
    spin.AngularVelocity = Vector3.new(0, Config.FlingForce, 0)
    spin.Parent = root
    xDTaraZ.Movement.SetNoclip(true)
    local started = os.clock()
    while os.clock() - started < Config.FlingTime do
        local currentTarget = xDTaraZ.Util.Root(target)
        if not currentTarget or not root.Parent then
            break
        end
        root.CFrame = currentTarget.CFrame
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        RunService.Heartbeat:Wait()
    end
    spin:Destroy()
    if root.Parent then
        root.AssemblyAngularVelocity = Vector3.zero
        root.AssemblyLinearVelocity = Vector3.zero
        root.CFrame = home
    end
    xDTaraZ.Util.SetBusy(false)
    xDTaraZ.Movement.RefreshNoclip()
    return true
end

function xDTaraZ.Troll.Spectate(target)
    local humanoid = target and xDTaraZ.Util.Humanoid(target) or xDTaraZ.Util.Humanoid()
    if humanoid then
        workspace.CurrentCamera.CameraSubject = humanoid
    end
end

function xDTaraZ.Troll.StickStep()
    local target = State.StickTarget and Players:FindFirstChild(State.StickTarget)
    local root, targetRoot = xDTaraZ.Util.Root(), target and xDTaraZ.Util.Root(target)
    if root and targetRoot and not xDTaraZ.Util.Busy() then
        root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 2)
    end
end

function xDTaraZ.Teleport.To(cframe)
    local root = xDTaraZ.Util.Root()
    if root and cframe then
        root.CFrame = cframe + Vector3.new(0, 3, 0)
        return true
    end
    return false
end

function xDTaraZ.Teleport.ToPlayer(name)
    local player = name and Players:FindFirstChild(name)
    local root = player and xDTaraZ.Util.Root(player)
    return xDTaraZ.Teleport.To(root and root.CFrame)
end

function xDTaraZ.Teleport.ToLobby()
    local lobby = workspace:FindFirstChild(Config.LobbyName)
    local spawnPart = lobby and (lobby:FindFirstChild("Spawns", true) or lobby:FindFirstChildWhichIsA("SpawnLocation", true))
    local part = spawnPart and (spawnPart:IsA("BasePart") and spawnPart or spawnPart:FindFirstChildWhichIsA("BasePart"))
    if not part and lobby then
        part = lobby:FindFirstChildWhichIsA("BasePart", true)
    end
    return xDTaraZ.Teleport.To(part and part.CFrame)
end

function xDTaraZ.Teleport.ToMap()
    local map = xDTaraZ.Round.Map()
    local spawns = map and map:FindFirstChild("Spawns")
    local part = spawns and spawns:FindFirstChildWhichIsA("BasePart") or (map and map.CoinContainer:FindFirstChildWhichIsA("BasePart"))
    return xDTaraZ.Teleport.To(part and part.CFrame)
end

function xDTaraZ.Esp.Init()
    xDTaraZ.Esp.Folder = Instance.new("Folder")
    xDTaraZ.Esp.Folder.Name = HttpService:GenerateGUID(false)
    xDTaraZ.Util.Mount(xDTaraZ.Esp.Folder)
end

function xDTaraZ.Esp.MakeHighlight(adornee, color)
    local highlight = Instance.new("Highlight")
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.65
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = adornee
    highlight.Parent = xDTaraZ.Esp.Folder
    return highlight
end

function xDTaraZ.Esp.MakeLabel(adornee, color)
    local gui = Instance.new("BillboardGui")
    gui.Size = UDim2.fromOffset(180, 36)
    gui.StudsOffset = Vector3.new(0, 3.5, 0)
    gui.AlwaysOnTop = true
    gui.Adornee = adornee
    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = color
    label.TextStrokeTransparency = 0.4
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = gui
    gui.Parent = xDTaraZ.Esp.Folder
    return gui, label
end

function xDTaraZ.Esp.DropEntry(entry)
    if entry then
        entry.Highlight:Destroy()
        entry.Gui:Destroy()
    end
end

function xDTaraZ.Esp.RefreshPlayers()
    local entries = State.Esp.Players
    local myRoot = xDTaraZ.Util.Root()
    for _, player in ipairs(Players:GetPlayers()) do
        local character, root = player.Character, xDTaraZ.Util.Root(player)
        local entry = entries[player]
        local role = xDTaraZ.Round.RoleOf(player)
        local visible = State.Opt.EspPlayers and player ~= LocalPlayer and character and root and role ~= "Dead"
        if not visible then
            xDTaraZ.Esp.DropEntry(entry)
            entries[player] = nil
        else
            if not entry or entry.Character ~= character then
                xDTaraZ.Esp.DropEntry(entry)
                local gui, label = xDTaraZ.Esp.MakeLabel(root, Color3.new(1, 1, 1))
                entry = { Character = character, Highlight = xDTaraZ.Esp.MakeHighlight(character, Color3.new(1, 1, 1)), Gui = gui, Label = label }
                entries[player] = entry
            end
            local color = Config.Colors[role] or Config.Colors.Innocent
            local distance = myRoot and math.floor((root.Position - myRoot.Position).Magnitude) or 0
            entry.Highlight.FillColor, entry.Highlight.OutlineColor, entry.Label.TextColor3 = color, color, color
            entry.Label.Text = string.format("%s [%s] %dm", player.DisplayName, role, distance)
        end
    end
    for player, entry in pairs(entries) do
        if not player.Parent then
            xDTaraZ.Esp.DropEntry(entry)
            entries[player] = nil
        end
    end
end

function xDTaraZ.Esp.RefreshGun()
    local drop = State.Opt.EspGun and xDTaraZ.Round.GunDrop()
    local entry = State.Esp.Gun
    if entry and entry.Adornee == drop then
        return
    end
    xDTaraZ.Esp.DropEntry(entry)
    State.Esp.Gun = nil
    if drop then
        local gui, label = xDTaraZ.Esp.MakeLabel(drop, Config.Colors.Gun)
        label.Text = "GUN DROP"
        State.Esp.Gun = { Adornee = drop, Highlight = xDTaraZ.Esp.MakeHighlight(drop, Config.Colors.Gun), Gui = gui }
    end
end

function xDTaraZ.Esp.Destroy()
    if xDTaraZ.Esp.Folder then
        xDTaraZ.Esp.Folder:Destroy()
    end
    table.clear(State.Esp.Players)
    State.Esp.Gun = nil
end

function xDTaraZ.Visual.SetFullbright(enabled)
    if enabled and not State.LightingDefaults then
        State.LightingDefaults = { Ambient = Lighting.Ambient, Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime, FogEnd = Lighting.FogEnd, GlobalShadows = Lighting.GlobalShadows }
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 1e9
        Lighting.GlobalShadows = false
    elseif not enabled and State.LightingDefaults then
        for property, value in pairs(State.LightingDefaults) do
            Lighting[property] = value
        end
        State.LightingDefaults = nil
    end
end

function xDTaraZ.Session.RedeemCode(code)
    local ok, message = pcall(Remotes.Extras.RedeemCode.InvokeServer, Remotes.Extras.RedeemCode, code)
    return ok and tostring(message) or "Request failed"
end

function xDTaraZ.Session.Rejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end

function xDTaraZ.Session.Hop()
    local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", game.PlaceId)
    local body = xDTaraZ.Util.HttpGet(url)
    local ok, servers = pcall(HttpService.JSONDecode, HttpService, body or "")
    if not ok or type(servers) ~= "table" then
        return
    end
    for _, server in ipairs(servers.data or {}) do
        if server.id ~= game.JobId and server.playing < server.maxPlayers then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
            return
        end
    end
end

function xDTaraZ.Session.InitAntiAfk()
    xDTaraZ.Util.Connect(LocalPlayer.Idled, function()
        if State.Opt.AntiAfk then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

function xDTaraZ.Session.InitRoleNotify(notify)
    xDTaraZ.Util.Connect(Remotes.Gameplay.RoundStart.OnClientEvent, function()
        task.wait(2)
        State.LastRoleFetch = 0
        xDTaraZ.Round.RefreshRoles()
        if not State.Opt.RoleNotify then
            return
        end
        local murderer, sheriff = xDTaraZ.Round.FindByRole("Murderer"), xDTaraZ.Round.FindByRole("Sheriff")
        notify(string.format("Murderer: %s | Sheriff: %s | You: %s", murderer and murderer.Name or "?", sheriff and sheriff.Name or "?", xDTaraZ.Round.RoleOf(LocalPlayer)))
    end)
end

xDTaraZ.Scheduler.Jobs = {
    Tick = {
        { "Roles", xDTaraZ.Round.RefreshRoles },
        { "Auto Win", xDTaraZ.Kaitun.Step, "Kaitun" },
        { "Auto Farm", xDTaraZ.Farm.Step, "AutoFarm" },
        { "X-Ray", xDTaraZ.Visual.XRayStep, "XRay" },
        { "Skins", xDTaraZ.Skin.ApplyStep },
        { "Movement", xDTaraZ.Movement.Apply, { "SpeedOn", "JumpOn" } },
        { "Auto Grab Gun", xDTaraZ.Sheriff.AutoGrabStep, "AutoGrabGun" },
        { "Auto Shoot", xDTaraZ.Sheriff.AutoShootStep, "AutoShoot" },
        { "Auto Kill All", xDTaraZ.Murderer.AutoKillStep, "AutoKillAll" },
        { "Role ESP", xDTaraZ.Esp.RefreshPlayers, "EspPlayers" },
        { "Gun ESP", xDTaraZ.Esp.RefreshGun, "EspGun" },
    },
    Stepped = { { "Anti Fling", xDTaraZ.Movement.AntiFlingStep, "AntiFling" } },
    Render = { { "Aimbot", xDTaraZ.Aim.Step, "Aimbot" } },
    Heartbeat = {
        { "Kill Aura", xDTaraZ.Murderer.KillAuraStep, "KillAura" },
        { "Auto Dodge", xDTaraZ.Survive.DodgeStep, "AutoDodge" },
        { "Stick To Player", xDTaraZ.Troll.StickStep, "StickTo" },
    },
}

---@param job table  { label, step, toggle idx or list }
---@return table     toggles of the job that are on
function xDTaraZ.Scheduler.OnToggles(job)
    local on = {}
    if not xDTaraZ.Library or job[3] == nil then return on end
    for _, idx in ipairs(type(job[3]) == "table" and job[3] or { job[3] }) do
        local toggle = xDTaraZ.Library.Toggles[idx]
        if toggle and toggle.Value then
            on[#on + 1] = toggle
        end
    end
    return on
end

---Queues the job's toggles to be switched off by the UI pump (their callbacks restore the game state); a job with none on rests until one turns on.
function xDTaraZ.Scheduler.Halt(job, err)
    local reason = tostring(err):match("^[^\n]*")
    job.Streak = nil
    if #xDTaraZ.Scheduler.OnToggles(job) == 0 then
        job.Stopped = true
        warn("[MM2] " .. job[1] .. " paused until turned on:", reason)
        return
    end

    job.Halting = true
    warn("[MM2] " .. job[1] .. " stopped:", reason)
    table.insert(State.Halted, { job, reason })
end

---@param job table  { label, step, toggle idx or list }; toggle jobs halt after Config.JobFailLimit errors spanning Config.JobFailWindow seconds
function xDTaraZ.Scheduler.Run(job, ...)
    if job.Halting then return end
    if job.Stopped then
        if #xDTaraZ.Scheduler.OnToggles(job) == 0 then return end
        job.Stopped = nil
    end

    local ok, err = pcall(job[2], ...)
    if ok then
        job.Streak = nil
        return
    end

    local streak = job.Streak
    if not streak then
        streak = { count = 0, since = os.clock() }
        job.Streak = streak
        warn("[MM2] " .. job[1] .. ":", err)
    end
    streak.count += 1
    if job[3] == nil or streak.count < Config.JobFailLimit or os.clock() - streak.since < Config.JobFailWindow then return end
    xDTaraZ.Scheduler.Halt(job, err)
end

function xDTaraZ.Scheduler.RunLane(lane, ...)
    for _, job in ipairs(xDTaraZ.Scheduler.Jobs[lane]) do
        xDTaraZ.Scheduler.Run(job, ...)
    end
end

function xDTaraZ.Scheduler.Boot(notify)
    xDTaraZ.Esp.Init()
    xDTaraZ.Farm.InitBagTracking()
    xDTaraZ.Util.Connect(RunService.Stepped, function()
        xDTaraZ.Scheduler.RunLane("Stepped")
    end)
    xDTaraZ.Movement.InitInfJump()
    xDTaraZ.Session.InitAntiAfk()
    xDTaraZ.Session.InitRoleNotify(notify)
    xDTaraZ.Util.Connect(RunService.RenderStepped, function(dt)
        xDTaraZ.Scheduler.RunLane("Render", dt)
    end)
    xDTaraZ.Util.Connect(RunService.Heartbeat, function()
        xDTaraZ.Scheduler.RunLane("Heartbeat")
    end)
    task.spawn(function()
        while State.Alive do
            xDTaraZ.Scheduler.RunLane("Tick")
            task.wait(Config.TickDelay)
        end
    end)
end

function xDTaraZ.Scheduler.Stop()
    State.Alive = false
    getgenv().MurderMystery2Unload = nil
    xDTaraZ.Sheriff.SyncAimHook()
    State.StickTarget = nil
    xDTaraZ.Movement.SetFly(false)
    xDTaraZ.Movement.SetNoclip(false)
    for _, conn in ipairs(State.Conns) do
        conn:Disconnect()
    end
    table.clear(State.Conns)
    if State.Opt.SpeedOn then
        xDTaraZ.Movement.RestoreSpeed()
    end
    if State.Opt.JumpOn then
        xDTaraZ.Movement.RestoreJump()
    end
    xDTaraZ.Troll.Spectate(nil)
    xDTaraZ.Visual.SetFullbright(false)
    xDTaraZ.Visual.ClearXRay()
    xDTaraZ.Farm.DetachMover()
    xDTaraZ.Esp.Destroy()
end

local function BuildInterface()
    local Library = xDTaraZ.Util.LoadLibrary()
    if not Library then return false end
    xDTaraZ.Library = Library
    pcall(MarioBanner.Step, "UI library")
    local T = function(en, th) return Library:T(en, th) end
    local opt = State.Opt
    local live = {}

    local function Notify(text, kind)
        Library:Notify("Murder Mystery 2", text, 5, kind or "Info")
    end

    local function Bind(idx)
        return function(value)
            opt[idx] = value
        end
    end

    local function AimHookBind(idx)
        return function(value)
            opt[idx] = value
            xDTaraZ.Sheriff.SyncAimHook()
        end
    end

    ---@return string?  live dropdown value, the list can change without a callback
    local function Picked(idx)
        local option = Library.Options[idx]
        opt[idx] = option and option.Value or nil
        return opt[idx]
    end

    local function FlingAsync(target)
        if target then task.spawn(xDTaraZ.Troll.Fling, target) end
    end

    local function BuildCombatTab(window)
        local tab = window:AddTab(T("Combat", "ต่อสู้"), "crosshair", T("Sheriff and murderer tools", "เครื่องมือนายอำเภอและฆาตกร"))

        local gunBox = tab:AddLeftGroupbox(T("Sheriff / Hero", "นายอำเภอ / ฮีโร่"))
        gunBox:AddToggle("SilentAim", {
            Text = T("Silent Aim", "ยิงล็อกเป้า"),
            Description = T("Every shot you fire goes to the murderer", "ทุกนัดที่ยิงไปโดนฆาตกร"),
            Default = false,
            Callback = AimHookBind("SilentAim"),
        }):AddKeyPicker("SilentAimKey", { Default = "None", Mode = "Toggle" })
        Library.Compat.NeedCap("SilentAim", { "Namecall", "CheckCaller" })
        gunBox:AddToggle("AutoShoot", {
            Text = T("Auto Shoot Murderer", "ยิงฆาตกรอัตโนมัติ"),
            Description = T("Kills the murderer as soon as you hold the gun", "ยิงฆาตกรทันทีที่ได้ถือปืน"),
            Default = false,
            Risky = true,
            Callback = Bind("AutoShoot"),
        }):AddKeyPicker("AutoShootKey", { Default = "None", Mode = "Toggle" })
        gunBox:AddButton({ Text = T("Shoot Murderer Now", "ยิงฆาตกรเดี๋ยวนี้"), Style = "Primary", Func = function()
            local ok, detail = xDTaraZ.Sheriff.ShootMurderer()
            Notify(ok and ("Shot " .. tostring(detail)) or tostring(detail or "You need the gun"), ok and "Success" or "Warning")
        end })
        gunBox:AddToggle("AutoGrabGun", {
            Text = T("Auto Grab Gun", "เก็บปืนอัตโนมัติ"),
            Description = T("Picks up the dropped gun the moment the sheriff dies", "เก็บปืนที่ตกทันทีที่นายอำเภอตาย"),
            Default = false,
            Callback = Bind("AutoGrabGun"),
        }):AddKeyPicker("AutoGrabGunKey", { Default = "None", Mode = "Toggle" })
        gunBox:AddButton({ Text = T("Grab Gun Now", "เก็บปืนเดี๋ยวนี้"), Func = function()
            local got = xDTaraZ.Sheriff.GrabGun()
            Notify(got and "Gun grabbed" or "No gun on the ground", got and "Success" or "Warning")
        end })

        local knifeBox = tab:AddRightGroupbox(T("Murderer", "ฆาตกร"))
        knifeBox:AddToggle("AutoKillAll", {
            Text = T("Auto Kill All", "ฆ่าทุกคนอัตโนมัติ"),
            Description = T("Ends the round by killing everyone when you are the murderer", "จบรอบด้วยการฆ่าทุกคนเมื่อเราเป็นฆาตกร"),
            Default = false,
            Risky = true,
            Callback = Bind("AutoKillAll"),
        }):AddKeyPicker("AutoKillAllKey", { Default = "None", Mode = "Toggle" })
        knifeBox:AddButton({ Text = T("Kill All Now", "ฆ่าทุกคนเดี๋ยวนี้"), Style = "Primary", Func = function()
            task.spawn(function()
                Notify(string.format("Killed %d players", xDTaraZ.Murderer.KillAll()))
            end)
        end })
        knifeBox:AddToggle("KillAura", {
            Text = T("Kill Aura", "ออร่าฆ่า"),
            Description = T("Kills anyone who gets close while you hold the knife", "ฆ่าใครก็ตามที่เข้าใกล้ตอนถือมีด"),
            Default = false,
            Risky = true,
            Callback = Bind("KillAura"),
        }):AddKeyPicker("KillAuraKey", { Default = "None", Mode = "Toggle" })
        knifeBox:AddToggle("KnifeAim", {
            Text = T("Knife Throw Aim", "ปามีดล็อกเป้า"),
            Description = T("Thrown knives fly to the nearest player", "มีดที่ปาพุ่งไปหาคนที่ใกล้ที่สุด"),
            Default = false,
            Callback = AimHookBind("KnifeAim"),
        })
        Library.Compat.NeedCap("KnifeAim", { "Namecall", "CheckCaller" })

        local aimBox = tab:AddRightGroupbox(T("Aimbot", "ล็อกกล้อง"))
        aimBox:AddToggle("Aimbot", {
            Text = T("Aimbot", "ล็อกกล้อง"),
            Description = T("Locks your camera on the murderer, or on the next victim when you hold the knife", "ล็อกกล้องไปที่ฆาตกร หรือเหยื่อคนถัดไปตอนถือมีด"),
            Default = false,
            Callback = Bind("Aimbot"),
        }):AddKeyPicker("AimbotKey", { Default = "Q", Mode = "Hold" })
        aimBox:AddSlider("AimSmooth", {
            Text = T("Smoothness", "ความนุ่ม"),
            Min = 0, Max = 95, Default = opt.AimSmooth, Rounding = 0, Suffix = "%",
            Callback = function(value)
                opt.AimSmooth = tonumber(value) or 0
            end,
        })

        local smartBox = tab:AddLeftGroupbox(T("Auto Play", "เล่นอัตโนมัติ"))
        smartBox:AddToggle("Kaitun", {
            Text = T("Auto Win", "ชนะอัตโนมัติ"),
            Description = T("Plays every round for you in any role", "เล่นทุกรอบให้เองทุกบทบาท"),
            Default = false,
            Risky = true,
            Callback = function(value)
                opt.Kaitun = value
                if value then
                    return
                end
                for _, idx in ipairs({ "AutoKillAll", "AutoShoot", "AutoGrabGun", "AutoDodge", "AutoFarm" }) do
                    opt[idx] = Library.Options[idx].Value
                end
            end,
        }):AddKeyPicker("KaitunKey", { Default = "None", Mode = "Toggle" })
        smartBox:AddToggle("AutoDodge", {
            Text = T("Auto Dodge Murderer", "หลบฆาตกรอัตโนมัติ"),
            Description = T("Escapes to the far side of the map when the murderer gets close", "หนีไปอีกฝั่งของแมพเมื่อฆาตกรเข้าใกล้"),
            Default = false,
            Callback = Bind("AutoDodge"),
        }):AddKeyPicker("AutoDodgeKey", { Default = "None", Mode = "Toggle" })
    end

    local function BuildTeleportTab(window)
        local tab = window:AddTab(T("Teleport", "วาร์ป"), "globe", T("Map, lobby and players", "แมพ ล็อบบี้ และผู้เล่น"))

        local placeBox = tab:AddLeftGroupbox(T("Places", "สถานที่"))
        placeBox:AddButton({ Text = T("Lobby", "ล็อบบี้"), Func = xDTaraZ.Teleport.ToLobby }):AddButton({ Text = T("Map", "แมพ"), Func = xDTaraZ.Teleport.ToMap })
        placeBox:AddButton({ Text = T("To Murderer", "ไปหาฆาตกร"), Func = function()
            local target = xDTaraZ.Round.FindByRole("Murderer")
            xDTaraZ.Teleport.ToPlayer(target and target.Name)
        end }):AddButton({ Text = T("To Sheriff", "ไปหานายอำเภอ"), Func = function()
            local target = xDTaraZ.Round.FindByRole("Sheriff")
            xDTaraZ.Teleport.ToPlayer(target and target.Name)
        end })

        local playerBox = tab:AddRightGroupbox(T("Players", "ผู้เล่น"))
        playerBox:AddDropdown("TeleportTarget", {
            Text = T("Player", "ผู้เล่น"),
            SpecialType = "Player",
            Searchable = true,
            Callback = Bind("TeleportTarget"),
        })
        playerBox:AddButton({ Text = T("Teleport", "วาร์ป"), Style = "Primary", Func = function()
            xDTaraZ.Teleport.ToPlayer(Picked("TeleportTarget"))
        end })
    end

    local function BuildTrollTab(window)
        local tab = window:AddTab(T("Troll", "ป่วน"), "zap", T("Fling, stick and spectate", "ดีด เกาะติด และส่อง"))

        local box = tab:AddLeftGroupbox(T("Target", "เป้าหมาย"))
        box:AddDropdown("TrollTarget", {
            Text = T("Player", "ผู้เล่น"),
            SpecialType = "Player",
            Searchable = true,
            Callback = function(value)
                opt.TrollTarget = value
                local stick, spectate = Library.Options.StickTo, Library.Options.Spectate
                if stick and stick.Value then State.StickTarget = value end
                if spectate and spectate.Value then xDTaraZ.Troll.Spectate(xDTaraZ.Troll.Target()) end
            end,
        })
        box:AddButton({ Text = T("Fling", "ดีดกระเด็น"), Style = "Primary", Func = function()
            Picked("TrollTarget")
            FlingAsync(xDTaraZ.Troll.Target())
        end }):AddButton({ Text = T("Fling Murderer", "ดีดฆาตกร"), Func = function()
            FlingAsync(xDTaraZ.Round.FindByRole("Murderer"))
        end })
        box:AddButton({ Text = T("Fling Everyone", "ดีดทุกคน"), Style = "Warning", DoubleClick = true, Func = function()
            task.spawn(function()
                for _, player in ipairs(Players:GetPlayers()) do
                    if player == LocalPlayer or not xDTaraZ.Util.Root(player) then continue end
                    xDTaraZ.Troll.Fling(player)
                end
            end)
        end })

        local followBox = tab:AddRightGroupbox(T("Follow", "ติดตาม"))
        followBox:AddToggle("StickTo", {
            Text = T("Stick To Player", "เกาะติดผู้เล่น"),
            Description = T("Stays glued right behind the selected player", "เกาะอยู่ข้างหลังผู้เล่นที่เลือกตลอด"),
            Default = false,
            Callback = function(value)
                State.StickTarget = value and Picked("TrollTarget") or nil
            end,
        })
        followBox:AddToggle("Spectate", {
            Text = T("Spectate", "ส่องผู้เล่น"),
            Default = false,
            Callback = function(value)
                Picked("TrollTarget")
                xDTaraZ.Troll.Spectate(value and xDTaraZ.Troll.Target() or nil)
            end,
        })
    end

    local function BuildPlayerTab(window)
        local tab = window:AddTab(T("Player", "ผู้เล่น"), "user", T("Movement", "การเคลื่อนที่"))

        local moveBox = tab:AddLeftGroupbox(T("Movement", "การเคลื่อนที่"))
        moveBox:AddToggle("SpeedOn", {
            Text = T("Walk Speed", "ความเร็วเดิน"),
            Default = false,
            Callback = function(value)
                opt.SpeedOn = value
                if not value then
                    xDTaraZ.Movement.RestoreSpeed()
                end
            end,
        })
        moveBox:AddSlider("WalkSpeed", {
            Text = T("Speed", "ความเร็ว"), Min = 16, Max = 120, Default = opt.WalkSpeed, Rounding = 0,
            Callback = function(value)
                opt.WalkSpeed = tonumber(value) or Config.SpeedDefault
            end,
        })
        moveBox:AddToggle("JumpOn", {
            Text = T("Jump Power", "แรงกระโดด"),
            Default = false,
            Callback = function(value)
                opt.JumpOn = value
                if not value then
                    xDTaraZ.Movement.RestoreJump()
                end
            end,
        })
        moveBox:AddSlider("JumpPower", {
            Text = T("Power", "แรง"), Min = 50, Max = 200, Default = opt.JumpPower, Rounding = 0,
            Callback = function(value)
                opt.JumpPower = tonumber(value) or Config.JumpDefault
            end,
        })

        local extraBox = tab:AddRightGroupbox(T("Extra", "เพิ่มเติม"))
        extraBox:AddToggle("AntiFling", {
            Text = T("Anti Fling", "กันโดนดีด"),
            Description = T("Other players cannot push or launch you", "ผู้เล่นอื่นดันหรือดีดเราไม่ได้"),
            Default = false,
            Callback = Bind("AntiFling"),
        })
        extraBox:AddToggle("InfJump", { Text = T("Infinite Jump", "กระโดดไม่จำกัด"), Default = false, Callback = Bind("InfJump") })
        extraBox:AddToggle("Noclip", {
            Text = T("Noclip", "ทะลุวัตถุ"),
            Default = false,
            Callback = function(value)
                opt.Noclip = value
                xDTaraZ.Movement.RefreshNoclip()
            end,
        }):AddKeyPicker("NoclipKey", { Default = "None", Mode = "Toggle" })
        extraBox:AddToggle("Fly", {
            Text = T("Fly", "บิน"),
            Description = T("Space to go up, Left Ctrl to go down", "Space ขึ้น, Left Ctrl ลง"),
            Default = false,
            Callback = function(value)
                opt.Fly = value
                xDTaraZ.Movement.SetFly(value)
            end,
        }):AddKeyPicker("FlyKey", { Default = "None", Mode = "Toggle" })
    end

    local function BuildVisualTab(window)
        local tab = window:AddTab(T("Visuals", "ภาพ"), "eye", T("Roles and gun", "บทบาทและปืน"))

        local espBox = tab:AddLeftGroupbox(T("ESP", "ESP"))
        espBox:AddToggle("EspPlayers", {
            Text = T("Role ESP", "มองเห็นบทบาท"),
            Description = T("Murderer red, sheriff blue, hero yellow, innocents green", "ฆาตกรแดง นายอำเภอน้ำเงิน ฮีโร่เหลือง คนธรรมดาเขียว"),
            Default = false,
            Callback = Bind("EspPlayers"),
        })
        espBox:AddToggle("EspGun", {
            Text = T("Gun Drop ESP", "มองเห็นปืนที่ตก"),
            Default = false,
            Callback = Bind("EspGun"),
        })
        espBox:AddToggle("RoleNotify", {
            Text = T("Role Notify", "แจ้งบทบาท"),
            Description = T("Tells you who the murderer and sheriff are at round start", "บอกว่าใครเป็นฆาตกรและนายอำเภอตอนเริ่มรอบ"),
            Default = false,
            Callback = Bind("RoleNotify"),
        })

        local worldBox = tab:AddRightGroupbox(T("World", "โลก"))
        worldBox:AddToggle("XRay", {
            Text = T("X-Ray", "มองทะลุ"),
            Description = T("See through walls on every map", "มองทะลุกำแพงได้ทุกแมพ"),
            Default = false,
            Callback = Bind("XRay"),
        })
        worldBox:AddToggle("Fullbright", {
            Text = T("Fullbright", "สว่างเต็มจอ"),
            Default = false,
            Callback = function(value)
                opt.Fullbright = value
                xDTaraZ.Visual.SetFullbright(value)
            end,
        })

        local skinBox = tab:AddRightGroupbox(T("Skins", "สกิน"))
        skinBox:AddDropdown("SkinSource", {
            Text = T("Copy From", "ก๊อปจาก"),
            SpecialType = "Player",
            Searchable = true,
            Callback = Bind("SkinSource"),
        })
        skinBox:AddButton({ Text = T("Copy Knife", "ก๊อปมีด"), Style = "Primary", Func = function()
            local ok = xDTaraZ.Skin.Copy(Picked("SkinSource"), "Knife")
            Notify(ok and "Knife skin applied" or "That player has no knife loaded", ok and "Success" or "Warning")
        end }):AddButton({ Text = T("Copy Gun", "ก๊อปปืน"), Func = function()
            local ok = xDTaraZ.Skin.Copy(Picked("SkinSource"), "Gun")
            Notify(ok and "Gun skin applied" or "That player has no gun loaded", ok and "Success" or "Warning")
        end })
        skinBox:AddButton({ Text = T("Reset Skins", "รีเซ็ตสกิน"), Func = function()
            table.clear(State.Skins)
        end })
    end

    local function BuildFarmTab(window)
        local tab = window:AddTab(T("Farm", "ฟาร์ม"), "cookie", T("Coins every round", "เหรียญทุกรอบ"))

        local coinBox = tab:AddLeftGroupbox(T("Coin Farm", "ฟาร์มเหรียญ"))
        coinBox:AddToggle("AutoFarm", {
            Text = T("Auto Farm Coins", "ฟาร์มเหรียญอัตโนมัติ"),
            Description = T("Glides smoothly to every coin until your bag is full and stays away from the murderer", "ไหลไปเก็บเหรียญทุกเหรียญจนเต็มถุง และอยู่ห่างจากฆาตกร"),
            Default = false,
            Callback = Bind("AutoFarm"),
        }):AddKeyPicker("AutoFarmKey", { Default = "None", Mode = "Toggle" })
        coinBox:AddSlider("FarmSpeed", {
            Text = T("Farm Speed", "ความเร็วฟาร์ม"),
            Min = 16, Max = Config.FarmSpeedMax, Default = Config.FarmSpeed, Rounding = 0,
            Callback = function(value)
                opt.FarmSpeed = tonumber(value) or Config.FarmSpeed
            end,
        })
        coinBox:AddToggle("ResetWhenFull", {
            Text = T("Reset When Bag Full", "รีเซ็ตตัวเมื่อถุงเต็ม"),
            Description = T("Respawns after the bag fills so the murderer cannot catch you", "เกิดใหม่หลังถุงเต็ม ฆาตกรจะได้ตามไม่ทัน"),
            Default = false,
            Callback = Bind("ResetWhenFull"),
        })
        live.Bag = coinBox:AddProgressBar("StatusBag", { Text = T("Coin Bag", "ถุงเหรียญ"), Max = 1, Default = 0 })

        local roundBox = tab:AddRightGroupbox(T("Round", "รอบนี้"))
        live.Role = roundBox:AddLabel("You: -")
        live.Murderer = roundBox:AddLabel("Murderer: ?")
        live.Sheriff = roundBox:AddLabel("Sheriff: ?")
        live.BagCount = roundBox:AddLabel("Bag: 0 / 0")

        local discordBox = tab:AddRightGroupbox("Discord", "link")
        discordBox:AddLabel(Config.Discord)
        discordBox:AddButton({ Text = T("Copy Discord Link", "คัดลอกลิงก์ Discord"), Style = "Primary", Func = function()
            local copy = setclipboard or toclipboard
            if copy then copy(Config.Discord) end
            Notify(copy and "Discord link copied" or Config.Discord)
        end })
    end

    local function BuildMiscTab(window)
        local tab = window:AddTab(T("Misc", "อื่นๆ"), "sliders-horizontal", T("Session tools", "เครื่องมือเซสชัน"))

        local box = tab:AddLeftGroupbox(T("Session", "เซสชัน"))
        box:AddToggle("AntiAfk", {
            Text = T("Anti AFK", "กันหลุด AFK"),
            Default = false,
            Callback = Bind("AntiAfk"),
        })
        box:AddButton({ Text = T("Rejoin", "เข้าเซิร์ฟเดิมใหม่"), DoubleClick = true, Func = xDTaraZ.Session.Rejoin })
            :AddButton({ Text = T("Server Hop", "ย้ายเซิร์ฟ"), DoubleClick = true, Func = xDTaraZ.Session.Hop })
        box:AddButton({ Text = T("Panic - All Off", "ฉุกเฉิน ปิดทั้งหมด"), Style = "Danger", Func = function()
            for _, toggle in pairs(Library.Toggles) do
                if toggle.Value == true then toggle:SetValue(false) end
            end
        end })

        local codeBox = tab:AddRightGroupbox(T("Codes", "โค้ด"))
        local codeText = ""
        codeBox:AddInput("RedeemCodeInput", {
            Text = T("Code", "โค้ด"),
            Default = "",
            Placeholder = T("Enter code", "ใส่โค้ด"),
            NoSave = true,
            Callback = function(value)
                codeText = value
            end,
        })
        codeBox:AddButton({ Text = T("Redeem", "ใช้โค้ด"), Style = "Primary", Func = function()
            if codeText == "" then return end
            Notify(xDTaraZ.Session.RedeemCode(codeText))
        end })
    end

    local function ReportHalts()
        while #State.Halted > 0 do
            local halt = table.remove(State.Halted, 1)
            local job = halt[1]
            for _, toggle in ipairs(xDTaraZ.Scheduler.OnToggles(job)) do
                toggle:SetValue(false)
            end
            job.Halting = nil
            Notify(job[1] .. " stopped: " .. halt[2], "Warning")
        end
    end

    local shown = {}
    local function Show(key, text)
        if shown[key] == text or not live[key] then return end
        shown[key] = text
        live[key]:SetText(text)
    end

    local function RefreshRound()
        local running = xDTaraZ.Round.Map() ~= nil
        local murderer = running and xDTaraZ.Round.FindByRole("Murderer")
        local sheriff = running and (xDTaraZ.Round.FindByRole("Sheriff") or xDTaraZ.Round.FindByRole("Hero"))
        local role = xDTaraZ.Round.IAmPlaying() and tostring(xDTaraZ.Round.RoleOf(LocalPlayer)) or "Lobby"
        local current, capacity = running and State.Bag.Current or 0, running and State.Bag.Max or 0
        Show("Role", "You: " .. role)
        Show("Murderer", "Murderer: " .. (murderer and murderer.Name or "?"))
        Show("Sheriff", "Sheriff: " .. (sheriff and sheriff.Name or "?"))
        Show("BagCount", string.format("Bag: %d / %d", current, capacity))

        local fill = capacity > 0 and math.min(current / capacity, 1) or 0
        if live.Bag and live.Bag.Value ~= fill then
            live.Bag:SetValue(fill)
        end
    end

    local function StartLive()
        Library:Every(Config.StatusRefresh, function()
            ReportHalts()
            if live.Role then RefreshRound() end
        end)
    end

    local function BuildTabs()
        local window = Library.Window
        window:AddTabSection(T("Game", "เกม"))
        xDTaraZ.Util.Try(BuildFarmTab, window)
        xDTaraZ.Util.Try(BuildCombatTab, window)
        xDTaraZ.Util.Try(BuildTeleportTab, window)
        xDTaraZ.Util.Try(BuildTrollTab, window)
        window:AddTabSection(T("Other", "อื่นๆ"))
        xDTaraZ.Util.Try(BuildPlayerTab, window)
        xDTaraZ.Util.Try(BuildVisualTab, window)
        xDTaraZ.Util.Try(BuildMiscTab, window)
        xDTaraZ.Util.Try(window.AddSettingsTab, window)
        xDTaraZ.Util.Try(StartLive)
    end

    Library:OnUnload(xDTaraZ.Scheduler.Stop)
    getgenv().MurderMystery2Unload = function()
        Library:Unload()
    end

    Library:CreateWindow({
        Title = "Mario Hub",
        SubTitle = "Murder Mystery 2 by xDTaraZ",
        MenuKey = Enum.KeyCode.LeftControl,
        ConfigFolder = Config.SaveFolder,
        Language = "Auto",
        Theme = "Overworld",
        OnUnlocked = function()
            BuildTabs()
            xDTaraZ.Util.Try(xDTaraZ.Scheduler.Boot, Notify)
            Notify("Loaded")
            xDTaraZ.Util.Try(Library.LoadAutoloadConfig, Library)
        end,
    })
    return true
end

if getgenv().MurderMystery2Unload then
    pcall(getgenv().MurderMystery2Unload)
end

pcall(MarioBanner.Step, "Systems")
if BuildInterface() then
    pcall(MarioBanner.Step, "Interface")
    pcall(MarioBanner.Ready)
end