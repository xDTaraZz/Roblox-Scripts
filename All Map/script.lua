local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Insert = game:GetService("InsertService")

local function purgeMacUi()
    local tag = getgenv()._eliteMacGui
    if tag and tag.Parent then
        pcall(tag.Destroy, tag)
    end
    getgenv()._eliteMacGui = nil
    local roots = { CoreGui }
    if gethui then table.insert(roots, 1, gethui()) end
    local plr0 = Players.LocalPlayer
    if plr0 then
        local pg = plr0:FindFirstChild("PlayerGui")
        if pg then table.insert(roots, pg) end
    end
    for _, root in ipairs(roots) do
        for _, g in ipairs(root:GetDescendants()) do
            if g:IsA("ScreenGui") and g:FindFirstChild("Base", true) then
                pcall(g.Destroy, g)
            end
        end
    end
end

if getgenv()._eliteShutdown then
    pcall(getgenv()._eliteShutdown)
    task.wait(0.2)
end
purgeMacUi()

local function bypassskibidieieiei()
    local mt = getrawmetatable(game)
    local oldNc, oldIx, oldNi = mt.__namecall, mt.__index, mt.__newindex
    setreadonly(mt, false)
    local block = { Kick = true, Destroy = true }
    local remoteBlock = { Check = true, Validate = true, Verify = true, Ping = true, Report = true }
    mt.__namecall = newcclosure(function(self, ...)
        local m = getnamecallmethod()
        local s = tostring(self):lower()
        if m == "Kick" or m == "Destroy" then return end
        if m == "FireServer" or m == "InvokeServer" then
            for _, w in ipairs({ "anti", "cheat", "kick", "ban", "report", "log", "telemetry", "analytics", "ping", "heartbeat", "ac", "detection" }) do
                if s:find(w) then return end
            end
            local a = ({ ... })[1]
            if remoteBlock[a] then return end
        end
        return oldNc(self, ...)
    end)
    mt.__index = newcclosure(function(self, key)
        if block[key] then return function() end end
        return oldIx(self, key)
    end)
    mt.__newindex = newcclosure(function(self, key, val)
        if key == "Parent" and tostring(self):lower():find("ban") then return end
        return oldNi(self, key, val)
    end)
    setreadonly(mt, true)
    getgenv()._eliteBypassNamecall, getgenv()._eliteBypassIndex, getgenv()._eliteBypassNewIndex = oldNc, oldIx, oldNi
end

local function removeacsixseven()
    for _, v in pairs(game:GetDescendants()) do
        local n = v.Name:lower()
        if v:IsA("LocalScript") or v:IsA("ModuleScript") then
            if n:find("anticheat") or n:find("antihack") or n:find("cheat") or n:find("security") or n:find("detection") or n:find("admin") then
                pcall(v.Destroy, v)
            end
        elseif v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            if n:find("anti") or n:find("cheat") or n:find("kick") or n:find("ban") or n:find("report") then
                pcall(v.Destroy, v)
            end
        end
    end
end

pcall(bypassskibidieieiei)
pcall(removeacsixseven)

local MacLib = loadstring(game:HttpGet("https://pastebin.com/raw/bWtBwBR9"))()

local UI = { win = nil, gui = nil }

local function notify(title, desc, life)
    if UI.win then
        UI.win:Notify({ Title = title, Description = desc, Lifetime = life or 4 })
    end
end

local S = {
    Players = game:GetService("Players"),
    Run = game:GetService("RunService"),
    Input = game:GetService("UserInputService"),
    Light = game:GetService("Lighting"),
    Prompt = game:GetService("ProximityPromptService"),
    Teleport = game:GetService("TeleportService"),
    Http = game:GetService("HttpService"),
    Virtual = game:GetService("VirtualUser"),
    CAS = game:GetService("ContextActionService"),
    Starter = game:GetService("StarterPlayer"),
}

local plr = S.Players.LocalPlayer
local cam = workspace.CurrentCamera
local mouse = plr:GetMouse()

local function findMacGui()
    local roots = { plr:FindFirstChild("PlayerGui") }
    if gethui then table.insert(roots, 1, gethui()) end
    for _, root in ipairs(roots) do
        if root then
            for _, g in ipairs(root:GetChildren()) do
                if g:IsA("ScreenGui") and g:FindFirstChild("Base", true) then return g end
            end
        end
    end
end

local function throttle(last, gap)
    local t = tick()
    if t - last < gap then return last, false end
    return t, true
end

local Conn = { live = true, list = {}, keyed = {} }
function Conn.track(c)
    if c then table.insert(Conn.list, c) end
    return c
end
function Conn.bind(key, c)
    Conn.off(key)
    Conn.keyed[key] = c
end
function Conn.off(key)
    local c = Conn.keyed[key]
    if c then c:Disconnect() Conn.keyed[key] = nil end
end
function Conn.clear()
    for key in pairs(Conn.keyed) do Conn.off(key) end
end

local Loop = { beat = {}, draw = {} }
function Loop.reg(kind, fn)
    table.insert(kind == "draw" and Loop.draw or Loop.beat, fn)
end
function Loop.start()
    Conn.track(S.Run.Heartbeat:Connect(function()
        if not Conn.live then return end
        for _, fn in ipairs(Loop.beat) do fn() end
    end))
    Conn.track(S.Run.RenderStepped:Connect(function(dt)
        if not Conn.live then return end
        mouse = plr:GetMouse()
        cam = workspace.CurrentCamera
        for _, fn in ipairs(Loop.draw) do fn(dt) end
    end))
end

local Plr = {}
function Plr.sameTeam(who)
    return plr.Team and who.Team and plr.Team == who.Team
end
function Plr.alive(who)
    if who == plr then return end
    local char
    if typeof(who) == "Instance" and who:IsA("Player") then
        char = who.Character
    elseif typeof(who) == "Instance" and who:IsA("Model") then
        char = who
    else
        return
    end
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    return char, hum
end

local Sys = {
    antiAfk = false,
    autoRespawn = false,
    panicKey = Enum.KeyCode.End,
}

function Sys.panic()
    Move.reset()
    Move.setFly(false)
    Move.setNoclip(false)
    Aimbot.bot = false
    Aimbot.silent = false
    Gun.reset()
    Pull.all = false
    Pull.one = false
    Hitbox.setOn(false)
    Cam.setFree(false)
    World.setBright(false)
    World.setClear(false)
    World.setInstant(false)
    Zoom.setOn(false)
    Radar.on = false
    Aimbot.lockMark = false
    ESP.skeleton = false
    Npc.esp = false
    Npc.aim = false
    Aimbot.npc = false
    ESP.npc = false
    pcall(Radar.kill)
    Npc.cleanEsp()
    TP.click = false
    TP.spectatePlayer(false)
    if Avatar.korbloxOn or Avatar.headlessOn then
        Avatar.setKorbloxHeadless(false)
    end
    notify("Panic", "ปิดทุกฟีเจอร์แล้ว", 4)
end

local Avatar = {
    headlessOn = false,
    korbloxOn = false,
    korbloxId = 139607718,
    pendingName = "", pendingJob = "",
    pendingRig = nil,
    copiedUid = nil, respawning = false,
}

local TP = {
    click = false,
    spectate = false,
    pickPlayer = nil,
    pickPoint = nil,
    wp = {},
    wpId = 0,
    clickMod = Enum.KeyCode.LeftAlt,
}

local Char = { saved = nil }

function Char.restorePhys()
    if not Char.obj or not Char.obj.Parent then return end
    if Char.hum and Char.hum.Parent then
        local s = Char.saved
        Char.hum.WalkSpeed = (s and s.walk) or 16
        Char.hum.JumpPower = (s and s.jump) or 50
        if s and s.hip then
            Char.hum.HipHeight = s.hip
        else
            Char.hum.HipHeight = Char.hum.RigType == Enum.HumanoidRigType.R15 and 2 or 0
        end
        Char.hum.UseJumpPower = true
        Char.hum.PlatformStand = false
        Char.hum.AutoRotate = true
        if not TP.spectate then cam.CameraSubject = Char.hum end
    end
    for _, p in ipairs(Char.obj:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = p.Name ~= "HumanoidRootPart"
        end
    end
end

local function bindChar(c)
    Char.obj = c
    Char.root = c:WaitForChild("HumanoidRootPart")
    Char.hum = c:WaitForChild("Humanoid")
    Char.saved = {
        walk = Char.hum.WalkSpeed,
        jump = Char.hum.JumpPower,
        hip = Char.hum.HipHeight,
    }
    if not TP.spectate then cam.CameraSubject = Char.hum end
    Conn.off("respawn")
    Conn.bind("respawn", Char.hum.Died:Connect(function()
        task.spawn(function()
            local t = 1
            pcall(function() t = S.Players.RespawnTime end)
            task.wait(t)
            if Avatar.copiedUid then
                Avatar.respawnCopy()
            elseif Sys.autoRespawn then
                pcall(function() plr:LoadCharacter() end)
            end
        end)
    end))
    if Avatar.korbloxOn then task.defer(function() Avatar.setKorbloxHeadless(true) end)
    elseif Avatar.headlessOn then task.defer(Avatar.applyHeadless) end
end
bindChar(plr.Character or plr.CharacterAdded:Wait())
Conn.track(plr.CharacterAdded:Connect(bindChar))
Conn.track(plr.CharacterRemoving:Connect(function()
    if not Avatar.copiedUid or Avatar.respawning then return end
    task.spawn(function()
        local t = 1
        pcall(function() t = S.Players.RespawnTime end)
        task.wait(t + 0.3)
        if Avatar.respawning or not Avatar.copiedUid then return end
        if not plr.Character or not plr.Character.Parent then
            Avatar.respawnCopy()
        end
    end)
end))

local ESP
local Npc = { esp = false, aim = false, live = {}, last = 0 }

function Npc.tick()
    if not Npc.esp and not Npc.aim then return end
    local t, ok = throttle(Npc.last, 0.85)
    if not ok then return end
    Npc.last = t
    table.clear(Npc.live)
    local keep = {}
    local owned = {}
    for _, p in ipairs(S.Players:GetPlayers()) do
        if p.Character then owned[p.Character] = true end
    end
    local mine = Char.obj or plr.Character
    for _, inst in ipairs(workspace:GetDescendants()) do
        if inst:IsA("Model") and inst ~= mine and not owned[inst] then
            local hum = inst:FindFirstChildOfClass("Humanoid")
            local hrp = inst:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                keep[inst] = true
                Npc.live[#Npc.live + 1] = inst
            end
        end
    end
    if Npc.esp then
        for m in pairs(keep) do
            if not ESP.cache[m] then ESP.track(m) end
        end
        for key in pairs(ESP.cache) do
            if typeof(key) == "Instance" and key:IsA("Model") and not keep[key] then
                ESP.drop(key)
            end
        end
    end
end

function Npc.cleanEsp()
    for key in pairs(ESP.cache) do
        if typeof(key) == "Instance" and key:IsA("Model") then
            ESP.drop(key)
        end
    end
end

local Move = {
    fly = false, flySpeed = 50, flyLift = 30,
    walk = false, walkSpd = 16,
    jump = false, jumpPow = 50, infJump = false,
    bhop = false, bhopLast = 0,
    noclip = false,
    gravity = false, gravPull = 0,
    noFall = false,
    hipOn = false, hip = 0,
    flyBv = nil, flyBg = nil,
}

function Move.clearFly()
    if Move.flyBv then Move.flyBv:Destroy() Move.flyBv = nil end
    if Move.flyBg then Move.flyBg:Destroy() Move.flyBg = nil end
end

function Move.setFly(on)
    Move.fly = on
    Move.clearFly()
    if not on or not Char.root then return end
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.zero
    bv.Parent = Char.root
    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.CFrame = Char.root.CFrame
    bg.Parent = Char.root
    Move.flyBv = bv
    Move.flyBg = bg
end

function Move.setNoclip(on)
    Move.noclip = on
    Conn.off("noclip")
    if not on then return end
    Conn.bind("noclip", S.Run.Stepped:Connect(function()
        if not Move.noclip or not Char.obj then return end
        for _, p in ipairs(Char.obj:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end))
end

function Move.tick()
    if not Char.hum then return end
    if Move.walk then Char.hum.WalkSpeed = Move.walkSpd end
    if Move.jump then Char.hum.UseJumpPower = true Char.hum.JumpPower = Move.jumpPow end
    if Move.hipOn then Char.hum.HipHeight = Move.hip end
    if Move.noFall and Char.root and Char.hum:GetState() == Enum.HumanoidStateType.Freefall then
        local v = Char.root.AssemblyLinearVelocity
        if v.Y < -20 then Char.root.AssemblyLinearVelocity = Vector3.new(v.X, -20, v.Z) end
    end
    if Move.gravity and Char.root then
        workspace.Gravity = Char.root.AssemblyLinearVelocity.Y < -0.1
            and math.clamp(196.2 - Move.gravPull, 0, 196.2) or 196.2
    end
    if Move.bhop and not Move.fly and Char.root and S.Input:IsKeyDown(Enum.KeyCode.Space) then
        local state = Char.hum:GetState()
        if state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.Running then
            local t, ok = throttle(Move.bhopLast, 0.1)
            if ok then
                Move.bhopLast = t
                Char.hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end

function Move.draw()
    if not Move.fly or not Char.root or not Char.hum then return end
    local bv, bg = Move.flyBv, Move.flyBg
    if not bv or not bg then Move.setFly(false) return end
    local vel = Vector3.zero
    local look, right = cam.CFrame.LookVector, cam.CFrame.RightVector
    local dir = Char.hum.MoveDirection
    if dir.Magnitude > 0 then
        local flat = (look * dir:Dot(look) + right * dir:Dot(right)).Unit
        vel = flat * Move.flySpeed
        bg.CFrame = CFrame.new(Char.root.Position, Char.root.Position + flat)
    else
        bg.CFrame = cam.CFrame
    end
    if S.Input:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0, Move.flyLift, 0)
    elseif S.Input:IsKeyDown(Enum.KeyCode.LeftControl) then vel += Vector3.new(0, -Move.flyLift, 0) end
    bv.Velocity = vel
end

function Move.reset()
    Move.setFly(false)
    Move.setNoclip(false)
    Move.walk = false Move.jump = false Move.hipOn = false
    Move.gravity = false Move.noFall = false Move.infJump = false Move.bhop = false
    workspace.Gravity = 196.2
    Char.restorePhys()
end

local Hitbox = { on = false, size = 5, showBox = true, orig = {} }

function Hitbox.restoreAll()
    for part, o in pairs(Hitbox.orig) do
        pcall(function()
            if part.Parent then
                part.Size = o.size
                part.Transparency = o.trans
                part.CanCollide = o.collide
                part.BrickColor = o.color
                part.Material = o.mat
            end
        end)
    end
    table.clear(Hitbox.orig)
end

function Hitbox.setOn(on)
    Hitbox.on = on
    if not on then 
        Hitbox.restoreAll() 
    end
end

function Hitbox.draw()
    if not Hitbox.on then return end
    local sz = Vector3.new(Hitbox.size, Hitbox.size, Hitbox.size)
    for _, who in ipairs(S.Players:GetPlayers()) do
        if who ~= plr and not Plr.sameTeam(who) then
            pcall(function()
                local hrp = who.Character and who.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                if not Hitbox.orig[hrp] then
                    Hitbox.orig[hrp] = {
                        size = hrp.Size,
                        trans = hrp.Transparency,
                        collide = hrp.CanCollide,
                        color = hrp.BrickColor,
                        mat = hrp.Material,
                    }
                end
                hrp.Size = sz
                hrp.CanCollide = false
                local o = Hitbox.orig[hrp]
                if Hitbox.showBox then
                    hrp.Transparency = 0.7
                    hrp.BrickColor = BrickColor.new("Really blue")
                    hrp.Material = Enum.Material.Neon
                else
                    hrp.Transparency = o.trans
                    hrp.BrickColor = o.color
                    hrp.Material = o.mat
                end
            end)
        end
    end
end

local Aimbot
local Hook

local Gun = {
    norecoil = false, rapid = false, spin = false,
    fireGap = 0.05, spinSpd = 25,
    aimRot = nil, savedCam = nil,
    lastFire = 0,
}

local function gunTool()
    local char = plr.Character or Char.obj
    if not char then return end
    local t = char:FindFirstChildWhichIsA("Tool", true)
    if t then return t end
    for _, d in ipairs(char:GetChildren()) do
        if d:IsA("Model") and (d:FindFirstChild("Handle") or d:FindFirstChild("Blade")) then
            return d
        end
    end
end

function Gun.tick()
    if Gun.rapid and S.Input:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local tool = gunTool()
        local t = tick()
        if tool and t - Gun.lastFire >= Gun.fireGap then
            Gun.lastFire = t
            tool:Activate()
        end
    end
end

function Gun.draw(dt)
    dt = dt or 0.016
    if Gun.norecoil then
        local c = workspace.CurrentCamera
        if c then
            if c.CameraType ~= Enum.CameraType.Scriptable then
                Gun.savedCam = Gun.savedCam or c.CameraType
                c.CameraType = Enum.CameraType.Scriptable
            end
            if S.Input:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                if not Gun.aimRot then Gun.aimRot = c.CFrame - c.CFrame.Position end
                pcall(function() c.CFrame = CFrame.new(c.CFrame.Position) * Gun.aimRot end)
            else
                Gun.aimRot = nil
            end
        end
    elseif Gun.savedCam then
        pcall(function()
            local c = workspace.CurrentCamera
            if c then c.CameraType = Gun.savedCam end
        end)
        Gun.savedCam = nil
    end
    if Gun.spin and Char.root then
        local yaw = math.rad(Gun.spinSpd * 6) * dt
        if Move.fly and Move.flyBg then
            Move.flyBg.CFrame = Move.flyBg.CFrame * CFrame.Angles(0, yaw, 0)
        end
        Char.root.CFrame = Char.root.CFrame * CFrame.Angles(0, yaw, 0)
    end
end

function Gun.reset()
    Gun.norecoil = false Gun.rapid = false Gun.spin = false
    Gun.aimRot = nil
end

Aimbot = {
    bot = false, silent = false, sticky = false, skipTeam = false, wall = false, npc = false,
    fov = 120, smooth = 5, boneMode = "Head", priority = "screen", lockMark = false,
    lockBind = Enum.UserInputType.MouseButton2,
    locked = nil, grace = 0, hooks = false,
    point = nil, part = nil, cf = nil, ready = false,
}

do
local lockHi = Instance.new("Highlight")
lockHi.Enabled = false
lockHi.FillTransparency = 0.6
lockHi.OutlineColor = Color3.fromRGB(255, 70, 70)
local wallRay = RaycastParams.new()
wallRay.FilterType = Enum.RaycastFilterType.Exclude
local fovRing = Drawing.new("Circle")
fovRing.Visible = false
fovRing.Thickness = 1
fovRing.Filled = false
fovRing.ZIndex = 2

local function keyHeld()
    local b = Aimbot.lockBind
    if not b or typeof(b) ~= "EnumItem" then return false end
    if b.EnumType == Enum.KeyCode then return S.Input:IsKeyDown(b) end
    return S.Input:IsMouseButtonPressed(b)
end

local function bonePart(char)
    if Aimbot.boneMode == "Random" then
        local pool = { "Head", "UpperTorso", "Torso", "HumanoidRootPart" }
        return char:FindFirstChild(pool[math.random(1, #pool)]) or char:FindFirstChild("Head")
    end
    if Aimbot.boneMode == "Torso" then
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function targetChar(target)
    if typeof(target) == "Instance" and target:IsA("Player") then
        if target == plr or (Aimbot.skipTeam and Plr.sameTeam(target)) then return end
        return Plr.alive(target)
    end
    if typeof(target) == "Instance" and target:IsA("Model") then
        return Plr.alive(target)
    end
end

local function leadPos(target, part)
    if typeof(target) == "Instance" and target:IsA("Player") then
        local t = 0.05
        pcall(function() t = math.clamp(target:GetNetworkPing(), 0.02, 0.25) end)
        return part.Position + part.AssemblyLinearVelocity * t
    end
    return part.Position + part.AssemblyLinearVelocity * 0.05
end

local function canSee(char, part)
    if not Aimbot.wall then return true end
    wallRay.FilterDescendantsInstances = { Char.obj }
    local from = cam.CFrame.Position
    local hit = workspace:Raycast(from, part.Position - from, wallRay)
    return not hit or hit.Instance:IsDescendantOf(char)
end

local function targetScore(target, mid)
    local char, hum = targetChar(target)
    if not char or not Char.root then return end
    local part = bonePart(char)
    if not part or not canSee(char, part) then return end
    local s, ok = cam:WorldToViewportPoint(part.Position)
    if not ok or s.Z <= 0 then return end
    local screenD = (Vector2.new(s.X, s.Y) - mid).Magnitude
    if screenD > Aimbot.fov then return end
    if Aimbot.priority == "hp" then return hum and hum.Health or math.huge, screenD end
    if Aimbot.priority == "dist" then return (Char.root.Position - part.Position).Magnitude, screenD end
    return screenD, screenD
end

local function pickTarget(mid)
    if Aimbot.sticky and Aimbot.locked then
        local pri, scr = targetScore(Aimbot.locked, mid)
        if pri and scr <= Aimbot.fov * 1.3 then Aimbot.grace = 12 return Aimbot.locked end
        if Aimbot.grace > 0 then Aimbot.grace -= 1 return Aimbot.locked end
    end
    local best, bestPri, bestScreen = nil, math.huge, math.huge
    local function try(target)
        local pri, scr = targetScore(target, mid)
        if not pri then return end
        if pri < bestPri or (pri == bestPri and scr < bestScreen) then
            bestPri, bestScreen, best = pri, scr, target
        end
    end
    for _, target in ipairs(S.Players:GetPlayers()) do try(target) end
    if Aimbot.npc then for _, target in ipairs(Npc.live) do try(target) end end
    if best then Aimbot.grace = 12 end
    return best
end

local function sync(mid)
    Aimbot.ready = false
    Aimbot.point, Aimbot.part, Aimbot.cf = nil, nil, nil
    local want = Aimbot.silent or (Aimbot.bot and keyHeld())
    if not want then Aimbot.locked = nil Aimbot.grace = 0 return end
    local tgt = pickTarget(mid)
    Aimbot.locked = tgt
    if not tgt then return end
    local char
    if typeof(tgt) == "Instance" and tgt:IsA("Player") then char = tgt.Character
    elseif typeof(tgt) == "Instance" and tgt:IsA("Model") then char = tgt end
    if not char then return end
    local part = bonePart(char)
    local pos = part and leadPos(tgt, part)
    if not pos then return end
    Aimbot.point, Aimbot.part, Aimbot.cf = pos, part, CFrame.new(pos)
    Aimbot.ready = true
end

function Aimbot.live() return Aimbot.silent and Aimbot.ready end

function Aimbot.rayDir(origin, maxLen)
    if not Aimbot.point then return end
    local delta = Aimbot.point - origin
    if delta.Magnitude < 0.01 then return end
    return delta.Unit * (maxLen or delta.Magnitude)
end

function Aimbot.patchArgs(args, mode)
    if not Aimbot.point then return false end
    if mode == "raycast" then
        for i = 1, #args - 1 do
            local from, dir = args[i], args[i + 1]
            if typeof(from) == "Vector3" and typeof(dir) == "Vector3" then
                local dist = dir.Magnitude < 0.01 and 1000 or dir.Magnitude
                local delta = Aimbot.point - from
                if delta.Magnitude > 0.01 then args[i + 1] = delta.Unit * dist return true end
            end
        end
    else
        for i = 1, #args do
            local ray = args[i]
            if typeof(ray) == "Ray" then
                local delta = Aimbot.point - ray.Origin
                local dist = ray.Direction.Magnitude < 0.01 and 1000 or ray.Direction.Magnitude
                if delta.Magnitude > 0.01 then args[i] = Ray.new(ray.Origin, delta.Unit * dist) return true end
            end
        end
    end
    return false
end

Hook = { done = false, Old = {} }

function Hook.seal(fn)
    return newcclosure and newcclosure(fn) or fn
end

function Hook.silentMouse(self, key, Old)
    if checkcaller() or not Aimbot.live() then return Old(self, key) end
    if typeof(self) ~= "Instance" or not self:IsA("Mouse") then return Old(self, key) end
    local k = string.lower(tostring(key))
    if k == "target" and Aimbot.part then return Aimbot.part end
    if k == "hit" and Aimbot.cf then return Aimbot.cf end
    if k == "unitray" and Aimbot.point then
        local origin = cam.CFrame.Position
        local delta = Aimbot.point - origin
        if delta.Magnitude > 0.01 then return Ray.new(origin, delta.Unit) end
    end
    return Old(self, key)
end

function Hook.install()
    if Hook.done then return true end
    if not hookmetamethod or not checkcaller then return false end
    local seal = Hook.seal
    Hook.Old.Index = hookmetamethod(game, "__index", seal(function(self, key)
        return Hook.silentMouse(self, key, Hook.Old.Index)
    end))
    Hook.Old.Call = hookmetamethod(game, "__namecall", seal(function(self, ...)
        local args = { ... }
        if checkcaller() or not Aimbot.live() then return Hook.Old.Call(self, ...) end
        local m = string.lower(getnamecallmethod())
        if m == "raycast" and Aimbot.patchArgs(args, "raycast") then
            return Hook.Old.Call(self, table.unpack(args))
        end
        if (m == "findpartonray" or m == "findpartonraywithignorelist" or m == "findpartonraywithwhitelist" or m == "blockcast")
            and Aimbot.patchArgs(args, "ray") then
            return Hook.Old.Call(self, table.unpack(args))
        end
        if (m == "viewportpointtoray" or m == "screenpointtoray") and Aimbot.point and self == cam then
            local origin = cam.CFrame.Position
            local delta = Aimbot.point - origin
            if delta.Magnitude > 0.01 then return Ray.new(origin, delta.Unit) end
        end
        return Hook.Old.Call(self, ...)
    end))
    if hookfunction then
        pcall(function()
            Hook.Old.Raycast = hookfunction(workspace.Raycast, seal(function(origin, direction, ...)
                if Aimbot.live() and typeof(origin) == "Vector3" and typeof(direction) == "Vector3" then
                    local dist = direction.Magnitude < 0.01 and 1000 or direction.Magnitude
                    local patched = Aimbot.rayDir(origin, dist)
                    if patched then direction = patched end
                end
                return Hook.Old.Raycast(origin, direction, ...)
            end))
        end)
    end
    Hook.done = true
    Aimbot.hooks = true
    return true
end

function Aimbot.tick()
    if not Aimbot.silent then return end
    cam = workspace.CurrentCamera
    if cam then sync(cam.ViewportSize * 0.5) end
end

function Aimbot.draw()
    cam = workspace.CurrentCamera
    if not cam then return end
    local mid = cam.ViewportSize * 0.5
    if Aimbot.bot or Aimbot.silent then
        fovRing.Position = mid
        fovRing.Radius = Aimbot.fov
        fovRing.Color = Color3.fromRGB(255, 255, 255)
        fovRing.Visible = true
    else
        fovRing.Visible = false
    end
    sync(mid)
    if Aimbot.lockMark then
        local char
        local tgt = Aimbot.locked
        if typeof(tgt) == "Instance" and tgt:IsA("Player") then char = tgt.Character
        elseif typeof(tgt) == "Instance" and tgt:IsA("Model") then char = tgt end
        if char and char.Parent then
            lockHi.Parent = char
            lockHi.Enabled = true
        else
            lockHi.Enabled = false
        end
    else
        lockHi.Enabled = false
    end
    if Aimbot.bot and keyHeld() and Aimbot.ready and not Aimbot.silent and Aimbot.point then
        local lv = math.clamp(Aimbot.smooth or 5, 1, 10)
        local alpha = math.clamp(1 - ((lv - 1) / 9) * 0.97, 0.03, 1)
        cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, Aimbot.point), alpha)
    end
end

function Aimbot.reset()
    Aimbot.bot = false Aimbot.silent = false
    Aimbot.locked = nil Aimbot.ready = false
    lockHi.Enabled = false
    fovRing.Visible = false
end
end

ESP = {
    boxes = false,
    names = false,
    dist = false,
    health = false,
    tracers = false,
    chams = false,
    flags = false,
    teamFlag = false,
    weapon = false,
    teamColor = false,
    hideTeam = false,
    npc = false,
    skeleton = false,
    color = Color3.fromRGB(0, 255, 128),
    teamTint = Color3.fromRGB(80, 160, 255),
    enemyTint = Color3.fromRGB(255, 70, 70),
    cache = {},
    preview = nil,
}

function ESP.refreshPreview()
    if ESP.preview then ESP.preview:Update(ESP) end
end

function ESP.tint(target)
    if typeof(target) == "Instance" and target:IsA("Model") then
        return ESP.color
    end
    if ESP.teamColor and plr.Team and target.Team then
        return plr.Team == target.Team and ESP.teamTint or ESP.enemyTint
    end
    return ESP.color
end

function ESP.displayName(target)
    return target.Name
end

function ESP.weaponName(char)
    local tool = char:FindFirstChildOfClass("Tool")
    return tool and tool.Name or "None"
end

function ESP.flagText(target, hum)
    if hum:GetState() == Enum.HumanoidStateType.Freefall then return "AIR" end
    if hum:GetState() == Enum.HumanoidStateType.Running then return "RUN" end
    return "IDLE"
end

function ESP.teamText(target)
    if typeof(target) == "Instance" and target:IsA("Model") then return "NPC" end
    if target.Team then return string.upper(target.Team.Name) end
    return "NO TEAM"
end

function ESP.track(target)
    if ESP.cache[target] then return end
    local function txt()
        local t = Drawing.new("Text")
        t.Visible = false
        t.Size = 13
        t.Center = false
        t.Outline = true
        t.Color = Color3.fromRGB(255, 255, 255)
        return t
    end
    local skel = {}
    for i = 1, 14 do
        local ln = Drawing.new("Line")
        ln.Visible = false
        ln.Thickness = 1.2
        skel[i] = ln
    end
    ESP.cache[target] = {
        box = Drawing.new("Square"),
        line = Drawing.new("Line"),
        name = txt(),
        dist = txt(),
        weapon = txt(),
        flags = txt(),
        team = txt(),
        hpNum = txt(),
        barBg = Drawing.new("Line"),
        barFill = Drawing.new("Line"),
        glow = Instance.new("Highlight"),
        skel = skel,
    }
    local d = ESP.cache[target]
    d.box.Visible = false d.box.Thickness = 1.5 d.box.Filled = false
    d.line.Visible = false d.line.Thickness = 1.5
    d.name.Center = true
    d.dist.Center = true
    d.weapon.Center = true
    d.barBg.Visible = false d.barBg.Thickness = 3
    d.barFill.Visible = false d.barFill.Thickness = 3
    d.glow.Enabled = false d.glow.FillTransparency = 0.5 d.glow.OutlineTransparency = 0
    d.glow.OutlineColor = Color3.fromRGB(255, 255, 255)
end

function ESP.drop(target)
    local d = ESP.cache[target]
    if not d then return end
    d.box:Remove() d.line:Remove()
    d.name:Remove() d.dist:Remove() d.weapon:Remove()
    d.flags:Remove() d.team:Remove() d.hpNum:Remove()
    d.barBg:Remove() d.barFill:Remove()
    if d.skel then for _, ln in ipairs(d.skel) do ln:Remove() end end
    if d.glow then d.glow:Destroy() end
    ESP.cache[target] = nil
end

function ESP.hide(d)
    d.box.Visible = false d.line.Visible = false
    d.name.Visible = false d.dist.Visible = false d.weapon.Visible = false
    d.flags.Visible = false d.team.Visible = false d.hpNum.Visible = false
    d.barBg.Visible = false d.barFill.Visible = false d.glow.Enabled = false
    if d.skel then for _, ln in ipairs(d.skel) do ln.Visible = false end end
end

local skelLinks = {
    { { "Head" }, { "UpperTorso", "Torso" } },
    { { "UpperTorso", "Torso" }, { "LowerTorso", "Torso" } },
    { { "UpperTorso", "Torso" }, { "LeftUpperArm", "Left Arm" } },
    { { "LeftUpperArm", "Left Arm" }, { "LeftLowerArm", "Left Arm" } },
    { { "LeftLowerArm", "Left Arm" }, { "LeftHand" } },
    { { "UpperTorso", "Torso" }, { "RightUpperArm", "Right Arm" } },
    { { "RightUpperArm", "Right Arm" }, { "RightLowerArm", "Right Arm" } },
    { { "RightLowerArm", "Right Arm" }, { "RightHand" } },
    { { "LowerTorso", "Torso" }, { "LeftUpperLeg", "Left Leg" } },
    { { "LeftUpperLeg", "Left Leg" }, { "LeftLowerLeg", "Left Leg" } },
    { { "LeftLowerLeg", "Left Leg" }, { "LeftFoot" } },
    { { "LowerTorso", "Torso" }, { "RightUpperLeg", "Right Leg" } },
    { { "RightUpperLeg", "Right Leg" }, { "RightLowerLeg", "Right Leg" } },
    { { "RightLowerLeg", "Right Leg" }, { "RightFoot" } },
}

local function skelPart(char, names)
    for _, n in ipairs(names) do
        local p = char:FindFirstChild(n)
        if p and p:IsA("BasePart") then return p end
    end
end

function ESP.drawSkel(d, char, tint)
    local n = 1
    for _, link in ipairs(skelLinks) do
        local a = skelPart(char, link[1])
        local b = skelPart(char, link[2])
        local ln = d.skel[n]
        if a and b and ln then
            local sa, oa = cam:WorldToViewportPoint(a.Position)
            local sb, ob = cam:WorldToViewportPoint(b.Position)
            if oa and ob and sa.Z > 0 and sb.Z > 0 then
                ln.From = Vector2.new(sa.X, sa.Y)
                ln.To = Vector2.new(sb.X, sb.Y)
                ln.Color = tint
                ln.Visible = true
                n += 1
            end
        end
    end
    for i = n, #d.skel do d.skel[i].Visible = false end
end

function ESP.drawText(draw, key, text, pos, on, tint)
    local t = draw[key]
    if on and text ~= "" then
        t.Text = text
        t.Position = pos
        t.Color = tint
        t.Visible = true
    else
        t.Visible = false
    end
end

function ESP.draw()
    local vp = cam.ViewportSize
    local foot = Vector2.new(vp.X * 0.5, vp.Y)
    for target, d in pairs(ESP.cache) do
        if ESP.hideTeam and typeof(target) == "Instance" and target:IsA("Player") and Plr.sameTeam(target) then
            ESP.hide(d)
        else
        local char, hum = Plr.alive(target)
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if char and hrp then
            local scr, vis = cam:WorldToViewportPoint(hrp.Position)
            if vis then
                local scale = 1000 / (scr.Z * 0.5)
                local w, h = 3 * scale, 4 * scale
                local x, y = scr.X - w * 0.5, scr.Y - h * 0.5
                local tint = ESP.tint(target)
                d.box.Color = tint d.line.Color = tint
                if ESP.boxes then
                    d.box.Size = Vector2.new(w, h)
                    d.box.Position = Vector2.new(x, y)
                    d.box.Visible = true
                else d.box.Visible = false end
                if ESP.health and hum then
                    local pct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
                    local bx, by, bh = x - 6, y, h
                    d.barBg.From = Vector2.new(bx, by)
                    d.barBg.To = Vector2.new(bx, by + bh)
                    d.barBg.Color = Color3.fromRGB(25, 25, 25)
                    d.barBg.Visible = true
                    d.barFill.From = Vector2.new(bx, by + bh * (1 - pct))
                    d.barFill.To = Vector2.new(bx, by + bh)
                    d.barFill.Color = Color3.fromRGB(255 - pct * 200, 60 + pct * 195, 60)
                    d.barFill.Visible = true
                    ESP.drawText(d, "hpNum", tostring(math.floor(hum.Health)), Vector2.new(bx - 4, by + bh * 0.5), true, tint)
                else
                    d.barBg.Visible = false d.barFill.Visible = false d.hpNum.Visible = false
                end
                ESP.drawText(d, "name", ESP.displayName(target), Vector2.new(scr.X, y - 16), ESP.names, tint)
                ESP.drawText(d, "flags", ESP.flagText(target, hum), Vector2.new(x + w + 4, y), ESP.flags, tint)
                ESP.drawText(d, "team", ESP.teamText(target), Vector2.new(x + w + 4, y + 14), ESP.teamFlag, tint)
                local showDist = ESP.dist and Char.root
                local distStr = showDist and (math.round((Char.root.Position - hrp.Position).Magnitude) .. "m") or ""
                ESP.drawText(d, "dist", distStr, Vector2.new(scr.X, y + h + 4), showDist, tint)
                ESP.drawText(d, "weapon", ESP.weaponName(char), Vector2.new(scr.X, y + h + 18), ESP.weapon, tint)
                if ESP.tracers then
                    d.line.From = foot
                    d.line.To = Vector2.new(scr.X, y + h * 0.5)
                    d.line.Visible = true
                else d.line.Visible = false end
                if ESP.chams then
                    if d.glow.Parent ~= char then d.glow.Parent = char end
                    d.glow.FillColor = tint d.glow.Enabled = true
                else d.glow.Enabled = false end
                if ESP.skeleton then ESP.drawSkel(d, char, tint)
                elseif d.skel then for _, ln in ipairs(d.skel) do ln.Visible = false end end
            else
                ESP.hide(d)
            end
        else
            ESP.hide(d)
        end
        end
    end
end

local World = {
    bright = false, instant = false, noClear = false,
    amb = S.Light.Ambient, out = S.Light.OutdoorAmbient,
    fogEnd = S.Light.FogEnd, fogStart = S.Light.FogStart,
}

function World.tick()
    if World.bright then
        local white = Color3.fromRGB(255, 255, 255)
        S.Light.Ambient = white
        S.Light.OutdoorAmbient = white
    end
    if World.noClear then
        S.Light.FogEnd = 100000
        S.Light.FogStart = 0
        for _, v in ipairs(S.Light:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false
            end
        end
    end
end

function World.setClear(on)
    World.noClear = on
    if on then return end
    S.Light.FogEnd = World.fogEnd
    S.Light.FogStart = World.fogStart
end

function World.setBright(on)
    World.bright = on
    if not on then S.Light.Ambient = World.amb S.Light.OutdoorAmbient = World.out end
end

function World.zeroPrompt(obj)
    if obj:IsA("ProximityPrompt") then obj.HoldDuration = 0 end
end

function World.setInstant(on)
    World.instant = on
    if on then for _, v in ipairs(workspace:GetDescendants()) do World.zeroPrompt(v) end end
end

function TP.playerList()
    local names = {}
    for _, p in ipairs(S.Players:GetPlayers()) do
        if p ~= plr then table.insert(names, p.Name) end
    end
    table.sort(names)
    return names
end

function TP.pointList()
    local names = {}
    for name in pairs(TP.wp) do table.insert(names, name) end
    table.sort(names)
    return names
end

function TP.toPlayer(name)
    local target = S.Players:FindFirstChild(name)
    local hrp = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if hrp and Char.root then Char.root.CFrame = hrp.CFrame end
end

function TP.spectatePlayer(on)
    TP.spectate = on
    if on and TP.pickPlayer then
        local target = S.Players:FindFirstChild(TP.pickPlayer)
        local hum = target and target.Character and target.Character:FindFirstChildOfClass("Humanoid")
        if hum then cam.CameraSubject = hum end
    elseif Char.hum then cam.CameraSubject = Char.hum end
end

function TP.saveHere()
    if not Char.root then return end
    TP.wpId += 1
    local name = "Point " .. TP.wpId
    TP.wp[name] = Char.root.CFrame
    return name
end

function TP.toPoint(name)
    if Char.root and TP.wp[name] then Char.root.CFrame = TP.wp[name] end
end

local Pull = { all = false, one = false, pick = nil, dist = 5 }

function Pull.isTeam(who)
    if Plr.sameTeam(who) then return true end
    local char = who.Character
    if Char.obj and char then
        local mine = Char.obj:GetAttribute("Team")
        if mine ~= nil and mine ~= -1 and char:GetAttribute("Team") == mine then
            return true
        end
    end
    return false
end

function Pull.draw()
    if not Pull.all and not Pull.one then return end
    local lp = Char.root
    if not lp then
        local char = plr.Character
        lp = char and char:FindFirstChild("HumanoidRootPart")
    end
    if not lp then return end
    local spot = lp.CFrame * CFrame.new(0, 0, -Pull.dist)
    local function grab(who)
        if who == plr or Pull.isTeam(who) then return end
        local hrp = who.Character and who.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        pcall(function()
            hrp.CFrame = spot
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end)
    end
    if Pull.one then
        local who = Pull.pick and S.Players:FindFirstChild(Pull.pick)
        if who then grab(who) end
        return
    end
    for _, who in ipairs(S.Players:GetPlayers()) do grab(who) end
end

local Radar = { on = false, range = 200, rad = 52 }
local rBg, rMid
local rDots = {}

local function radarDot(i)
    if not rDots[i] then
        rDots[i] = Drawing.new("Circle")
        rDots[i].Filled = true
        rDots[i].Radius = 3
        rDots[i].NumSides = 10
        rDots[i].Visible = false
    end
    return rDots[i]
end

function Radar.draw()
    if not Radar.on or not Char.root then
        if rBg then rBg.Visible = false end
        if rMid then rMid.Visible = false end
        for _, d in ipairs(rDots) do d.Visible = false end
        return
    end
    if not rBg then
        rBg = Drawing.new("Circle")
        rBg.Filled = true
        rBg.Color = Color3.fromRGB(12, 12, 12)
        rBg.Transparency = 0.35
        rBg.Radius = Radar.rad
        rBg.NumSides = 48
        rMid = Drawing.new("Triangle")
        rMid.Filled = true
        rMid.Color = Color3.fromRGB(0, 255, 140)
    end
    local vp = cam.ViewportSize
    local hub = Vector2.new(vp.X - Radar.rad - 16, vp.Y - Radar.rad - 16)
    rBg.Position = hub
    rBg.Visible = true
    rMid.PointA = hub + Vector2.new(0, -5)
    rMid.PointB = hub + Vector2.new(-4, 4)
    rMid.PointC = hub + Vector2.new(4, 4)
    rMid.Visible = true
    local yaw = math.atan2(cam.CFrame.LookVector.X, cam.CFrame.LookVector.Z)
    local n = 0
    for _, who in ipairs(S.Players:GetPlayers()) do
        if who ~= plr and not Plr.sameTeam(who) then
            local hrp = who.Character and who.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local flat = hrp.Position - Char.root.Position
                flat = Vector3.new(flat.X, 0, flat.Z)
                local dist = flat.Magnitude
                if dist > 2 and dist <= Radar.range then
                    n += 1
                    local ang = math.atan2(flat.X, flat.Z) - yaw
                    local ring = (dist / Radar.range) * (Radar.rad - 8)
                    local dot = radarDot(n)
                    dot.Position = hub + Vector2.new(math.sin(ang) * ring, -math.cos(ang) * ring)
                    dot.Color = Color3.fromRGB(255, 80, 80)
                    dot.Visible = true
                end
            end
        end
    end
    for i = n + 1, #rDots do rDots[i].Visible = false end
end

function Radar.kill()
    Radar.on = false
    pcall(function() if rBg then rBg:Remove() end if rMid then rMid:Remove() end end)
    rBg, rMid = nil, nil
    for _, d in ipairs(rDots) do pcall(function() d:Remove() end) end
    table.clear(rDots)
end

local Cam = {
    fov = cam and cam.FieldOfView or 70,
    defFov = cam and cam.FieldOfView or 70,
    free = false, freeSpd = 50, sens = 0.35, savedType = nil,
}

function Cam.tick()
    local c = workspace.CurrentCamera
    if c then c.FieldOfView = Cam.fov end
end

function Cam.draw(dt)
    if not Cam.free then return end
    local cc = workspace.CurrentCamera
    if not cc then return end
    local delta = S.Input:GetMouseDelta()
    local cf = cc.CFrame
    cf = cf * CFrame.Angles(0, math.rad(-delta.X * Cam.sens), 0)
    cf = cf * CFrame.Angles(math.rad(-delta.Y * Cam.sens), 0, 0)
    local look, right = cf.LookVector, cf.RightVector
    local move = Vector3.zero
    if S.Input:IsKeyDown(Enum.KeyCode.W) then move += look end
    if S.Input:IsKeyDown(Enum.KeyCode.S) then move -= look end
    if S.Input:IsKeyDown(Enum.KeyCode.A) then move -= right end
    if S.Input:IsKeyDown(Enum.KeyCode.D) then move += right end
    if S.Input:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
    if S.Input:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end
    if move.Magnitude > 0 then cf += move.Unit * Cam.freeSpd * dt end
    cc.CFrame = cf
end

function Cam.setFree(on)
    Cam.free = on
    if not on then
        local c = workspace.CurrentCamera
        if c then
            if Cam.savedType then c.CameraType = Cam.savedType end
            if Char.hum then c.CameraSubject = Char.hum end
        end
        Cam.savedType = nil
        return
    end
    local c = workspace.CurrentCamera
    if c then
        Cam.savedType = c.CameraType
        c.CameraType = Enum.CameraType.Scriptable
        c.CameraSubject = nil
    end
end

function Cam.reset()
    Cam.setFree(false)
    local c = workspace.CurrentCamera
    if c then c.FieldOfView = Cam.defFov end
end

local Zoom = { on = false, maxDist = 999999, minDist = 0.5, defMax = 128, defMin = 0.5 }

function Zoom.setOn(on)
    Zoom.on = on
    if on then
        plr.CameraMaxZoomDistance = Zoom.maxDist
        plr.CameraMinZoomDistance = Zoom.minDist
    else
        plr.CameraMaxZoomDistance = Zoom.defMax
        plr.CameraMinZoomDistance = Zoom.defMin
    end
end

function Zoom.tick()
    if not Zoom.on then return end
    plr.CameraMaxZoomDistance = Zoom.maxDist
    plr.CameraMinZoomDistance = Zoom.minDist
end

local Net = {}

function Net.http()
    return syn and syn.request or http and http.request or http_request or request
end

function Net.get(url)
    local req = Net.http()
    if not req then return end
    local ok, res = pcall(function()
        return req({ Url = url, Method = "GET" })
    end)
    if not ok or not res or not res.Body then return end
    local okJson, body = pcall(S.Http.JSONDecode, S.Http, res.Body)
    if okJson then return body end
end

function Net.serverHop()
    local req = Net.http()
    if not req then return false end
    local ok, res = pcall(function()
        return req({ Url = ("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId) })
    end)
    if not ok or not res or not res.Body then return false end
    local okJson, body = pcall(S.Http.JSONDecode, S.Http, res.Body)
    if not okJson or not body or not body.data then return false end
    local ids = {}
    for _, row in ipairs(body.data) do
        if row.id and row.maxPlayers and row.playing and row.maxPlayers > row.playing and row.id ~= game.JobId then
            table.insert(ids, row.id)
        end
    end
    if #ids == 0 then return false end
    S.Teleport:TeleportToPlaceInstance(game.PlaceId, ids[math.random(#ids)], plr)
    return true
end

function Net.rejoin()
    S.Teleport:TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
end

function Net.joinJob(jobId)
    jobId = jobId and jobId:gsub("%s+", "") or ""
    if jobId == "" then
        notify("Join Failed", "ใส่ JobId ก่อน", 4)
        return false
    end
    notify("Joining", jobId, 3)
    local ok, err = pcall(S.Teleport.TeleportToPlaceInstance, S.Teleport, game.PlaceId, jobId, plr)
    if not ok then
        notify("Join Failed", tostring(err), 5)
        return false
    end
    return true
end

function Net.lowGraphics()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    S.Light.GlobalShadows = false
    S.Light.FogEnd = 9e9
    local killFx = { Decal = true, Texture = true, Clothing = true, ShirtGraphic = true, ParticleEmitter = true, Trail = true, Smoke = true, Sparkles = true, Fire = true }
    local killPost = { PostEffect = true, BloomEffect = true, BlurEffect = true, ColorCorrectionEffect = true, SunRaysEffect = true }
    task.spawn(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0 obj.CastShadow = false
                if obj:IsA("MeshPart") then obj.TextureID = "" end
            elseif obj:IsA("SpecialMesh") then obj.TextureId = ""
            elseif killFx[obj.ClassName] then obj:Destroy()
            elseif killPost[obj.ClassName] then obj.Enabled = false end
        end
        for _, obj in ipairs(S.Light:GetChildren()) do
            if killPost[obj.ClassName] then obj.Enabled = false end
        end
    end)
end

function Avatar.trimName(name)
    return name and name:gsub("^%s+", ""):gsub("%s+$", "") or ""
end

function Avatar.userId(name)
    name = Avatar.trimName(name)
    if name == "" then return end
    local ok, id = pcall(S.Players.GetUserIdFromNameAsync, S.Players, name)
    if ok and typeof(id) == "number" and id > 0 then return id end
    ok, id = pcall(S.Players.GetUserIdFromName, S.Players, name)
    if ok and typeof(id) == "number" and id > 0 then return id end
end

function Avatar.stripAnims(desc)
    if not desc then return end
    local keys = {
        "ClimbAnimation", "FallAnimation", "IdleAnimation", "JumpAnimation",
        "RunAnimation", "SwimAnimation", "WalkAnimation", "MoodAnimation",
        "SwimIdleAnimation", "LandingAnimation", "SitAnimation", "StaticFacialAnimation",
    }
    for _, k in ipairs(keys) do
        pcall(function() desc[k] = 0 end)
    end
end

function Avatar.fetchFullDesc(uid)
    local best
    Avatar.pendingRig = nil
    local ok2, model = pcall(S.Players.CreateHumanoidModelFromUserId, S.Players, uid)
    if ok2 and model then
        local srcHum = model:WaitForChild("Humanoid", 8)
        if srcHum then
            model:WaitForChild("HumanoidRootPart", 8)
            task.wait(0.5)
            local ok3, d2 = pcall(srcHum.GetAppliedDescription, srcHum)
            if ok3 and d2 then
                best = Avatar.cloneDesc(d2)
                Avatar.pendingRig = srcHum.RigType
            end
        end
        model:Destroy()
    end
    if not best then
        local ok, d1 = pcall(S.Players.GetHumanoidDescriptionFromUserId, S.Players, uid)
        if ok and d1 then best = Avatar.cloneDesc(d1) end
    end
    if best then Avatar.stripAnims(best) end
    return best
end

function Avatar.cloneDesc(src)
    local d = Instance.new("HumanoidDescription")
    local nums = {
        "Shirt", "Pants", "GraphicTShirt", "Face",
        "Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg",
        "WalkAnimation", "RunAnimation", "IdleAnimation", "JumpAnimation",
        "FallAnimation", "ClimbAnimation", "SwimAnimation",
    }
    local strs = {
        "HatAccessory", "HairAccessory", "FaceAccessory", "NeckAccessory",
        "ShoulderAccessory", "FrontAccessory", "BackAccessory", "WaistAccessory",
    }
    local colors = {
        "HeadColor", "TorsoColor", "LeftArmColor", "RightArmColor", "LeftLegColor", "RightLegColor",
    }
    local scales = {
        "BodyTypeScale", "DepthScale", "HeadScale", "HeightScale", "ProportionScale", "WidthScale",
    }
    for _, p in ipairs(nums) do pcall(function() d[p] = src[p] end) end
    for _, p in ipairs(strs) do pcall(function() d[p] = src[p] end) end
    for _, p in ipairs(colors) do pcall(function() d[p] = src[p] end) end
    for _, p in ipairs(scales) do pcall(function() d[p] = src[p] end) end
    pcall(function()
        if src.GetAccessories and d.SetAccessories then
            local acc = src:GetAccessories(true)
            if acc then d:SetAccessories(acc) end
        end
    end)
    return d
end

function Avatar.ensureAnimate(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and not hum:FindFirstChildOfClass("Animator") then
        pcall(function() Instance.new("Animator").Parent = hum end)
    end
    local cur = char:FindFirstChild("Animate")
    if cur and cur:IsA("LocalScript") then return cur end
    if cur then pcall(function() cur:Destroy() end) end
    local sc = S.Starter:FindFirstChild("StarterCharacterScripts")
    local tpl = sc and sc:FindFirstChild("Animate")
    if not tpl then return end
    local a = tpl:Clone()
    a.Parent = char
    return a
end

function Avatar.waitJob(job)
    if not job then return false end
    if job.await then
        local ok = pcall(function() job:await() end)
        return ok
    end
    if job.Wait then
        local ok = pcall(function() job:Wait() end)
        return ok
    end
    task.wait(0.6)
    return true
end

function Avatar.applyDesc(desc, rig, asOther)
    if not desc then return false end
    if asOther then Avatar.stripAnims(desc) end
    pcall(function() desc.UseAvatarSettings = false end)
    if plr.LoadCharacterWithHumanoidDescription and asOther then
        local ok = pcall(function() plr:LoadCharacterWithHumanoidDescription(desc) end)
        if ok then
            local char = plr.Character or plr.CharacterAdded:Wait()
            if char then
                Char.obj = char
                Char.root = char:WaitForChild("HumanoidRootPart", 10)
                Char.hum = char:WaitForChild("Humanoid", 10)
                if rig and Char.hum then pcall(function() Char.hum.RigType = rig end) end
            end
            return true
        end
    end
    if not Char.hum then return false end
    if rig then pcall(function() Char.hum.RigType = rig end) end
    if Char.hum.ApplyDescriptionAsync then
        local ok, job = pcall(function() return Char.hum:ApplyDescriptionAsync(desc) end)
        if ok and Avatar.waitJob(job) then return true end
    end
    if pcall(function() Char.hum:ApplyDescription(desc) end) then
        task.wait(0.35)
        return true
    end
    if Char.hum.ApplyDescriptionReset then
        if pcall(function() Char.hum:ApplyDescriptionReset(desc) end) then
            task.wait(0.35)
            return true
        end
    end
    if not asOther and plr.LoadCharacterWithHumanoidDescription then
        local ok = pcall(function() plr:LoadCharacterWithHumanoidDescription(desc) end)
        if ok then
            local char = plr.Character or plr.CharacterAdded:Wait()
            if char then
                Char.obj = char
                Char.root = char:WaitForChild("HumanoidRootPart", 10)
                Char.hum = char:WaitForChild("Humanoid", 10)
            end
            return true
        end
    end
    return false
end

function Avatar.respawnCopy()
    local uid = Avatar.copiedUid
    if not uid or Avatar.respawning then return end
    Avatar.respawning = true
    local desc = Avatar.fetchFullDesc(uid)
    if desc then pcall(function() desc.UseAvatarSettings = false end) end
    local ok = false
    if desc then
        ok = Avatar.applyDesc(desc, Avatar.pendingRig, true)
    end
    if not ok then ok = Avatar.replaceChar(uid) end
    if ok then
        if Avatar.korbloxOn then task.defer(function() Avatar.setKorbloxHeadless(true) end)
    elseif Avatar.headlessOn then task.defer(Avatar.applyHeadless) end
    else
        pcall(function() plr:LoadCharacter() end)
    end
    Avatar.respawning = false
end

function Avatar.replaceChar(uid)
    local old = plr.Character
    local cf
    if old and old:FindFirstChild("HumanoidRootPart") then
        cf = old.HumanoidRootPart.CFrame
    end
    local ok, model = pcall(S.Players.CreateHumanoidModelFromUserId, S.Players, uid)
    if not ok or not model then return false end
    local hum = model:FindFirstChildOfClass("Humanoid") or model:WaitForChild("Humanoid", 12)
    if not hum then
        model:Destroy()
        return false
    end
    if not model:FindFirstChild("HumanoidRootPart") then
        model:WaitForChild("HumanoidRootPart", 12)
    end
    task.wait(0.4)
    model.Name = plr.Name
    for _, p in ipairs(model:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Anchored = false
        end
    end
    model.Parent = workspace
    if cf then
        pcall(function() model:PivotTo(cf) end)
    end
    local swapped = false
    pcall(function()
        plr.Character = model
        swapped = plr.Character == model
    end)
    if not swapped then
        model:Destroy()
        return false
    end
    if old and old.Parent and old ~= model then
        pcall(function() old:Destroy() end)
    end
    Avatar.copiedUid = uid
    bindChar(model)
    Avatar.ensureAnimate(model)
    return true
end

function Avatar.applyOutfit(uid, desc)
    local rig = Avatar.pendingRig
    Avatar.pendingRig = nil
    pcall(function() desc.UseAvatarSettings = false end)
    local ok = false
    if Avatar.applyDesc(desc, rig, true) then
        ok = true
    elseif Avatar.replaceChar(uid) then
        ok = true
    elseif Avatar.applyClone(uid) then
        ok = true
    end
    if ok then Avatar.copiedUid = uid end
    return ok
end

function Avatar.applyClone(uid)
    if Avatar.replaceChar(uid) then return true end
    local ok, model = pcall(S.Players.CreateHumanoidModelFromUserId, S.Players, uid)
    if not ok or not model then return false end
    local srcHum = model:FindFirstChildOfClass("Humanoid")
    if not srcHum or not Char.obj or not Char.hum then
        model:Destroy()
        return false
    end
    local okDesc, cloneDesc = pcall(srcHum.GetAppliedDescription, srcHum)
    if okDesc and cloneDesc then
        local d = Avatar.cloneDesc(cloneDesc)
        pcall(function() d.UseAvatarSettings = false end)
        if Avatar.applyDesc(d, srcHum.RigType, true) then
            model:Destroy()
            return true
        end
    end
    for _, item in ipairs(model:GetChildren()) do
        if item:IsA("Accessory") then
            pcall(function() Char.hum:AddAccessory(item:Clone()) end)
        elseif item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
            pcall(function()
                local old = Char.obj:FindFirstChildOfClass(item.ClassName)
                if old then old:Destroy() end
                item:Clone().Parent = Char.obj
            end)
        elseif item:IsA("BodyColors") then
            pcall(function()
                local bc = Char.obj:FindFirstChildOfClass("BodyColors")
                if bc then
                    bc.HeadColor3 = item.HeadColor3
                    bc.TorsoColor3 = item.TorsoColor3
                    bc.LeftArmColor3 = item.LeftArmColor3
                    bc.RightArmColor3 = item.RightArmColor3
                    bc.LeftLegColor3 = item.LeftLegColor3
                    bc.RightLegColor3 = item.RightLegColor3
                end
            end)
        end
    end
    model:Destroy()
    return true
end

function Avatar.applyHeadless()
    if not Char.obj then return end
    local head = Char.obj:FindFirstChild("Head")
    if not head then return end
    if Avatar.headlessOn then
        head.Transparency = 1
        head.CanCollide = false
        for _, v in ipairs(head:GetChildren()) do
            if v:IsA("Decal") or v:IsA("SurfaceAppearance") then
                v.Transparency = 1
            elseif v:IsA("SpecialMesh") then
                v.Transparency = 1
            end
        end
    else
        head.Transparency = 0
        head.CanCollide = true
        for _, v in ipairs(head:GetChildren()) do
            if v:IsA("Decal") or v:IsA("SurfaceAppearance") then
                v.Transparency = 0
            elseif v:IsA("SpecialMesh") then
                v.Transparency = 0
            end
        end
    end
end

function Avatar.korbloxMeshIds(pak, id)
    local meshId = "rbxassetid://" .. id
    local texId = meshId
    if not pak then return meshId, texId end
    if pak:IsA("MeshPart") and pak.MeshId ~= "" then
        return pak.MeshId, pak.TextureID ~= "" and pak.TextureID or pak.MeshId
    end
    local sm = pak:FindFirstChildWhichIsA("SpecialMesh", true)
    if sm and sm.MeshId ~= "" then
        return sm.MeshId, (sm.TextureId ~= "" and sm.TextureId) or sm.MeshId
    end
    return meshId, texId
end

function Avatar.weldKorbloxHip(char, pak)
    local slot = "Right Leg"
    local upper = char:FindFirstChild("RightUpperLeg")
    local foot = char:FindFirstChild("RightFoot")
    if not upper or not foot then return false end
    local torso = char:FindFirstChild("LowerTorso")
    local hipJoint = torso and torso:FindFirstChild("RightHip")
    local hipWeld = CFrame.new(0, upper.Size.Y * 0.5, 0)
    if hipJoint and hipJoint:IsA("Motor6D") then
        hipWeld = hipJoint.C1
    end
    local toe = foot.CFrame * CFrame.new(0, -foot.Size.Y * 0.5, 0)
    local hipWorld = upper.CFrame * hipWeld
    local legVec = toe.Position - hipWorld.Position
    local span = legVec.Magnitude
    if span < 0.35 then
        local chain = { "RightUpperLeg", "RightLowerLeg", "RightFoot" }
        span = Avatar.limbSpan(char, chain)
        legVec = toe.Position - hipWorld.Position
    end
    if legVec.Magnitude < 0.02 then
        legVec = toe.Position - upper.Position
    end
    if span < 0.3 then span = math.max(legVec.Magnitude, 2.1) end
    local weldC1 = CFrame.new(upper.CFrame:VectorToObjectSpace(legVec) * 0.5)
    local meshId, texId = Avatar.korbloxMeshIds(pak, Avatar.korbloxId)
    local src = pak and (pak:IsA("MeshPart") and pak or pak:FindFirstChildWhichIsA("MeshPart", true))
    if src and src:IsA("MeshPart") and src.MeshId ~= "" then
        local leg = src:Clone()
        leg.Name = "eliteLimb_korblox"
        leg:SetAttribute("eliteLimb", slot)
        leg.Anchored = false
        leg.CanCollide = false
        leg.Massless = true
        local sy = span / math.max(src.Size.Y, 0.08)
        leg.Size = src.Size * Vector3.new(1.05, sy, 1.05)
        leg.Parent = char
        local weld = Instance.new("Weld")
        weld.Part0 = upper
        weld.Part1 = leg
        weld.C0 = hipWeld
        weld.C1 = weldC1
        weld.Parent = leg
        return true
    end
    local hull = Instance.new("Part")
    hull.Name = "eliteLimb_korblox"
    hull:SetAttribute("eliteLimb", slot)
    hull.Size = Vector3.new(0.12, 0.12, 0.12)
    hull.Transparency = 1
    hull.CanCollide = false
    hull.Massless = true
    hull.Anchored = false
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = meshId
    mesh.TextureId = texId
    mesh.Scale = Vector3.new(1.08, span, 1.08)
    mesh.Parent = hull
    hull.Parent = char
    local weld = Instance.new("Weld")
    weld.Part0 = upper
    weld.Part1 = hull
    weld.C0 = hipWeld
    weld.C1 = weldC1
    weld.Parent = hull
    return true
end

function Avatar.loadAsset(id)
    local ok, pak = pcall(Insert.LoadAsset, Insert, id)
    if ok and pak then return pak end
    ok, pak = pcall(function()
        local list = game:GetObjects("rbxassetid://" .. id)
        return list and list[1]
    end)
    return ok and pak or nil
end

function Avatar.unwrapPak(pak)
    if pak:IsA("Accessory") then return pak:FindFirstChild("Handle") or pak end
    local acc = pak:FindFirstChildWhichIsA("Accessory", true)
    if acc then return acc:FindFirstChild("Handle") or acc end
    return pak
end

function Avatar.applyKorblox()
    local char, hum = Char.obj, Char.hum
    if not char or not hum then return false end
    local slot = "Right Leg"
    local chain = { "RightUpperLeg", "RightLowerLeg", "RightFoot" }
    Avatar.clearLimbTag(char, slot)
    local pak = Avatar.loadAsset(Avatar.korbloxId)
    if not pak then return false end
    pak = Avatar.unwrapPak(pak)
    local upper = char:FindFirstChild("RightUpperLeg")
    local span = Avatar.limbSpan(char, chain)
    local src = pak:IsA("MeshPart") and pak or pak:FindFirstChildWhichIsA("MeshPart", true)
        or pak:FindFirstChildWhichIsA("BasePart", true)
    if upper and src then
        Avatar.hideParts(char, slot, { "RightLowerLeg", "RightFoot" })
        if Avatar.applyMeshToLimb(src, upper, span) then
            local dm = upper:FindFirstChildOfClass("SpecialMesh")
            if dm then
                local sy = span / math.max(upper.Size.Y, 0.05) * 1.12
                dm.Scale = Vector3.new(1.1, sy, 1.1)
            end
            upper.Transparency = 0
            pcall(function() pak:Destroy() end)
            return true
        end
    end
    Avatar.hideParts(char, slot, chain)
    local worked = Avatar.weldKorbloxHip(char, pak)
    pcall(function() pak:Destroy() end)
    return worked
end

function Avatar.setKorbloxHeadless(on)
    Avatar.korbloxOn = on
    Avatar.headlessOn = on
    if not Char.hum then
        notify("Korblox", "ไม่มีตัวละคร", 4)
        return
    end
    if on and Char.hum.RigType ~= Enum.HumanoidRigType.R15 then
        notify("Korblox", "ใช้ได้แค่ R15", 4)
        Avatar.korbloxOn = false
        Avatar.headlessOn = false
        return
    end
    Avatar.applyHeadless()
    if not on then
        if Char.obj then Avatar.clearLimbTag(Char.obj, "Right Leg") end
        return
    end
    task.spawn(function()
        notify("Korblox", "กำลังใส่ขา...", 3)
        if Avatar.applyKorblox() then
            Avatar.applyHeadless()
            notify("Korblox", "Headless + ขา Korblox แล้ว", 4)
        else
            notify("Korblox", "ใส่ขาไม่ได้", 5)
            Avatar.korbloxOn = false
            Avatar.headlessOn = false
            Avatar.applyHeadless()
        end
    end)
end

function Avatar.currentDesc()
    if not Char.hum then return end
    local ok, desc = pcall(Char.hum.GetAppliedDescription, Char.hum)
    if ok and desc then return Avatar.cloneDesc(desc) end
    ok, desc = pcall(S.Players.GetHumanoidDescriptionFromUserId, S.Players, plr.UserId)
    if ok and desc then return Avatar.cloneDesc(desc) end
    return Instance.new("HumanoidDescription")
end

function Avatar.copyOutfit(name)
    name = Avatar.trimName(name)
    if name == "" then
        notify("Outfit", "ใส่ชื่อผู้เล่นก่อน", 4)
        return
    end
    task.spawn(function()
        notify("Outfit", "กำลัง copy ตัว " .. name .. "...", 4)
        local uid = Avatar.userId(name)
        if not uid then
            notify("Outfit Failed", "หา user ไม่เจอ", 5)
            return
        end
        local desc = Avatar.fetchFullDesc(uid)
        if not desc then
            notify("Outfit Failed", "ดึง avatar ไม่ได้", 5)
            return
        end
        pcall(function() desc.UseAvatarSettings = false end)
        if not Avatar.applyOutfit(uid, desc) then
            notify("Outfit Failed", "apply ไม่ผ่าน", 5)
            return
        end
        task.wait(0.4)
        if Avatar.headlessOn then Avatar.applyHeadless() end
        notify("Outfit", "copy ตัว " .. name .. " แล้ว", 5)
    end)
end

Avatar.limbSave = {}

function Avatar.limbSpan(char, chain)
    local upper = char:FindFirstChild(chain[1])
    local foot = char:FindFirstChild(chain[#chain])
    if upper and foot then
        return (foot.Position - upper.Position).Magnitude
    end
    local lower = char:FindFirstChild(chain[2])
    if lower then return lower.Size.Y * 2.5 end
    return 2
end

function Avatar.hideParts(char, slot, names)
    if not names then return end
    Avatar.limbSave[slot] = Avatar.limbSave[slot] or {}
    for _, n in ipairs(names) do
        local part = char:FindFirstChild(n)
        if part and part:IsA("BasePart") then
            local o = { trans = part.Transparency, kids = {} }
            for _, c in ipairs(part:GetDescendants()) do
                if c:IsA("Decal") or c:IsA("Texture") then
                    o.kids[c] = { kind = "num", val = c.Transparency }
                    c.Transparency = 1
                elseif c:IsA("SurfaceAppearance") then
                    o.kids[c] = { kind = "tex", val = c.Transparency }
                    c.Transparency = 1
                elseif c:IsA("SpecialMesh") then
                    o.kids[c] = { kind = "num", val = c.Transparency }
                    c.Transparency = 1
                end
            end
            part.Transparency = 1
            Avatar.limbSave[slot][part] = o
        end
    end
end

function Avatar.clearLimbTag(char, slot)
    for _, p in ipairs(char:GetChildren()) do
        if p:GetAttribute("eliteLimb") == slot then p:Destroy() end
    end
    local saved = Avatar.limbSave[slot]
    if saved then
        for part, o in pairs(saved) do
            if part.Parent then
                part.Transparency = o.trans
                for kid, kt in pairs(o.kids) do
                    if kid.Parent then
                        if kt.kind == "num" then kid.Transparency = kt.val
                        elseif kt.kind == "tex" then kid.Transparency = kt.val end
                    end
                end
            end
        end
        Avatar.limbSave[slot] = nil
    end
end

function Avatar.applyMeshToLimb(src, limb, span)
    if not src or not limb then return false end
    if limb:IsA("MeshPart") and src:IsA("MeshPart") then
        limb.MeshId = src.MeshId
        limb.TextureID = src.TextureID
        limb.Transparency = 0
        return true
    end
    local smSrc = src:FindFirstChildOfClass("SpecialMesh")
    if not smSrc and src:IsA("UnionOperation") then
        smSrc = src:FindFirstChildOfClass("SpecialMesh")
    end
    local dm = limb:FindFirstChildOfClass("SpecialMesh")
    if not dm then
        dm = Instance.new("SpecialMesh")
        dm.Parent = limb
    end
    if smSrc then
        dm.MeshId = smSrc.MeshId
        dm.TextureId = smSrc.TextureId
        dm.MeshType = smSrc.MeshType
        local sy = span / math.max(limb.Size.Y, 0.05) * 0.9
        dm.Scale = Vector3.new(1.05, sy, 1.05)
        limb.Transparency = 0
        return true
    end
    if src:IsA("MeshPart") then
        dm.MeshId = src.MeshId
        dm.TextureId = src.TextureID
        dm.MeshType = Enum.MeshType.FileMesh
        local sy = span / math.max(limb.Size.Y, 0.05) * 0.9
        dm.Scale = Vector3.new(1.05, sy, 1.05)
        limb.Transparency = 0
        return true
    end
    return false
end

local Cross = {
    on = false,
    h = Drawing.new("Line"),
    v = Drawing.new("Line"),
}
Cross.h.Thickness = 1
Cross.h.Visible = false
Cross.v.Thickness = 1
Cross.v.Visible = false

function Cross.draw()
    if not Cross.on then
        Cross.h.Visible = false
        Cross.v.Visible = false
        return
    end
    local mid = cam.ViewportSize * 0.5
    local s = 6
    Cross.h.From = Vector2.new(mid.X - s, mid.Y)
    Cross.h.To = Vector2.new(mid.X + s, mid.Y)
    Cross.h.Color = Color3.fromRGB(255, 255, 255)
    Cross.h.Visible = true
    Cross.v.From = Vector2.new(mid.X, mid.Y - s)
    Cross.v.To = Vector2.new(mid.X, mid.Y + s)
    Cross.v.Color = Color3.fromRGB(255, 255, 255)
    Cross.v.Visible = true
end

function Cross.kill()
    Cross.on = false
    pcall(function() Cross.h:Remove() Cross.v:Remove() end)
end

local function hookPlayer(who)
    Conn.track(who.CharacterAdded:Connect(function(char)
        if Hitbox.on then task.defer(Hitbox.draw) end
    end))
end

Loop.reg("beat", Move.tick)
Loop.reg("beat", Gun.tick)
Loop.reg("beat", World.tick)
Loop.reg("beat", Cam.tick)
Loop.reg("beat", Zoom.tick)
Loop.reg("beat", Npc.tick)
Loop.reg("beat", Aimbot.tick)
Loop.reg("draw", Pull.draw)
Loop.reg("draw", Hitbox.draw)
Loop.reg("draw", Move.draw)
Loop.reg("draw", Gun.draw)
Loop.reg("draw", Aimbot.draw)
Loop.reg("draw", ESP.draw)
Loop.reg("draw", Radar.draw)
Loop.reg("draw", Cam.draw)
Loop.reg("draw", Cross.draw)
Loop.start()

Conn.track(S.Input.JumpRequest:Connect(function()
    if Move.infJump and Char.hum then Char.hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end))

Conn.track(S.Prompt.PromptShown:Connect(function(prompt)
    if World.instant then prompt.HoldDuration = 0 end
end))

Conn.track(S.Input.InputBegan:Connect(function(input, processed)
    if processed then return end
    if TP.click and input.UserInputType == Enum.UserInputType.MouseButton1 and S.Input:IsKeyDown(TP.clickMod) then
        if mouse.Target and Char.root then
            Char.root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end
    if input.KeyCode == Sys.panicKey then Sys.panic() end
end))

if not getgenv()._eliteIdle then
    getgenv()._eliteIdle = Conn.track(plr.Idled:Connect(function()
        if not Sys.antiAfk then return end
        S.Virtual:Button2Down(Vector2.zero, cam.CFrame)
        task.wait(1)
        S.Virtual:Button2Up(Vector2.zero, cam.CFrame)
    end))
end

Conn.track(workspace.DescendantAdded:Connect(function(obj)
    if World.instant then World.zeroPrompt(obj) end
end))

local UI_KEY = Enum.KeyCode.LeftControl
local UI_MUTE_KEY = Enum.KeyCode.World2
local uiKeyDown = false

local function toggleUi()
    if not UI.win then return end
    UI.win:SetState(not UI.win:GetState())
end

local Window = MacLib:Window({
    Title = "xDTaraZ", -- so skibidi dobdob yesyes
    Subtitle = "Sixseven",
    Size = UDim2.fromOffset(820, 580),
    Keybind = UI_KEY,
    AcrylicBlur = true,
})
UI.win = Window
UI.gui = findMacGui()
getgenv()._eliteMacGui = UI.gui
task.defer(function()
    if not UI.win then return end
    UI.gui = findMacGui() or UI.gui
    getgenv()._eliteMacGui = UI.gui
end)
Window:SetKeybind(UI_MUTE_KEY)

Conn.track(S.Input.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if input.KeyCode == UI_KEY then uiKeyDown = true end
end))

Conn.track(S.Input.InputEnded:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if input.KeyCode == UI_KEY and uiKeyDown then
        uiKeyDown = false
        toggleUi()
    end
end))

local Group = Window:TabGroup()
local TabCombat = Group:Tab({ Name = "Combat" })
local TabVisual = Group:Tab({ Name = "Visuals" })
local TabMove = Group:Tab({ Name = "Movement" })
local TabTP = Group:Tab({ Name = "Teleport" })
local TabAvatar = Group:Tab({ Name = "Avatar" })
local TabSys = Group:Tab({ Name = "System" })

local MoveL = TabMove:Section({ Side = "Left" })
local MoveR = TabMove:Section({ Side = "Right" })

MoveL:Header({ Name = "Flight" })
MoveL:Toggle({ Name = "Fly", Default = false, Callback = function(v) Move.setFly(v) end })
MoveL:Slider({ Name = "Fly Speed", Default = 50, Minimum = 10, Maximum = 1000, Precision = 0, Callback = function(v) Move.flySpeed = v end })
MoveL:Slider({ Name = "Fly Lift", Default = 30, Minimum = 10, Maximum = 200, Precision = 0, Callback = function(v) Move.flyLift = v end })

MoveR:Header({ Name = "Character" })
MoveR:Toggle({ Name = "Walk Speed", Default = false, Callback = function(v) Move.walk = v if not v and Char.hum then Char.hum.WalkSpeed = 16 end end })
MoveR:Slider({ Name = "Speed", Default = 16, Minimum = 16, Maximum = 1000, Precision = 0, Callback = function(v) Move.walkSpd = v end })
MoveR:Toggle({ Name = "Jump Power", Default = false, Callback = function(v) Move.jump = v if not v and Char.hum then Char.hum.JumpPower = 50 end end })
MoveR:Slider({ Name = "Power", Default = 50, Minimum = 50, Maximum = 500, Precision = 0, Callback = function(v) Move.jumpPow = v end })
MoveR:Toggle({ Name = "Infinite Jump", Default = false, Callback = function(v) Move.infJump = v end })
MoveR:Toggle({ Name = "Bunny Hop", Default = false, Callback = function(v) Move.bhop = v end })
MoveR:Toggle({ Name = "Noclip", Default = false, Callback = function(v) Move.setNoclip(v) end })
MoveR:Toggle({ Name = "Spinbot", Default = false, Callback = function(v) Gun.spin = v end })
MoveR:Slider({ Name = "Spin Speed", Default = 25, Minimum = 5, Maximum = 100, Precision = 0, Callback = function(v) Gun.spinSpd = v end })
MoveR:Toggle({ Name = "No Fall Damage", Default = false, Callback = function(v) Move.noFall = v end })
MoveR:Toggle({ Name = "Hip Height", Default = false, Callback = function(v)
    Move.hipOn = v
    if not v and Char.hum then
        local s = Char.saved
        Char.hum.HipHeight = (s and s.hip) or (Char.hum.RigType == Enum.HumanoidRigType.R15 and 2 or 0)
    end
end })
MoveR:Slider({ Name = "Hip", Default = 0, Minimum = 0, Maximum = 50, Precision = 0, Callback = function(v) Move.hip = v end })
MoveR:Toggle({ Name = "Low Gravity", Default = false, Callback = function(v) Move.gravity = v if not v then workspace.Gravity = 196.2 end end })
MoveR:Slider({ Name = "Gravity Pull", Default = 0, Minimum = 0, Maximum = 196, Precision = 0, Callback = function(v) Move.gravPull = v end })
MoveR:Header({ Name = "World" })
MoveR:Toggle({ Name = "Instant Interact", Default = false, Callback = function(v) World.setInstant(v) end })

local CombatL = TabCombat:Section({ Side = "Left" })
local CombatR = TabCombat:Section({ Side = "Right" })

CombatL:Header({ Name = "Combat" })
CombatL:Toggle({ Name = "Aimbot", Default = false, Callback = function(v) Aimbot.bot = v end })
CombatL:Toggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(v)
        Aimbot.silent = v
        if v and not Hook.install() then notify("Silent Aim", "Executor notsupport", 6) end
    end,
})
CombatL:Keybind({
    Name = "Lock Key",
    Default = Enum.UserInputType.MouseButton2,
    onBinded = function(key)
        Aimbot.lockBind = key
        notify("Lock Key", key.Name, 3)
    end,
})
CombatL:Toggle({ Name = "Sticky Target", Default = false, Callback = function(v) Aimbot.sticky = v end })
CombatL:Toggle({ Name = "Skip Team", Default = false, Callback = function(v) Aimbot.skipTeam = v end })
CombatL:Toggle({ Name = "NPC Aim", Default = false, Callback = function(v) Aimbot.npc = v Npc.aim = v end })
CombatL:Toggle({ Name = "Wall Check", Default = false, Callback = function(v) Aimbot.wall = v end })
CombatL:Slider({ Name = "FOV", Default = 120, Minimum = 40, Maximum = 400, Precision = 0, Callback = function(v) Aimbot.fov = v end })
CombatL:Slider({ Name = "Smooth", Default = 5, Minimum = 1, Maximum = 10, Precision = 0, Callback = function(v) Aimbot.smooth = v end })
CombatL:Dropdown({
    Name = "Aim Part",
    Options = { "Head", "Torso", "Random" },
    Default = 1,
    Callback = function(v) Aimbot.boneMode = v end,
})
CombatL:Dropdown({
    Name = "Priority",
    Options = { "Crosshair", "Distance", "Low HP" },
    Default = 1,
    Callback = function(v)
        if v == "Distance" then Aimbot.priority = "dist"
        elseif v == "Low HP" then Aimbot.priority = "hp"
        else Aimbot.priority = "screen" end
    end,
})
CombatL:Toggle({ Name = "Lock Highlight", Default = false, Callback = function(v) Aimbot.lockMark = v end })

CombatR:Header({ Name = "Weapon" })
CombatR:Toggle({ Name = "No Recoil", Default = false, Callback = function(v) Gun.norecoil = v end })
CombatR:Toggle({ Name = "Rapid Fire", Default = false, Callback = function(v) Gun.rapid = v end })
CombatR:Header({ Name = "Pull" })
CombatR:Toggle({ Name = "Bring All", Default = false, Callback = function(v) Pull.all = v if v then Pull.one = false end end })
CombatR:Toggle({ Name = "Bring One", Default = false, Callback = function(v) Pull.one = v if v then Pull.all = false end end })
local dropPull
local function refreshPull()
    if not dropPull then return end
    local list = TP.playerList()
    if #list == 0 then list = { "-" } end
    dropPull:ClearOptions()
    dropPull:InsertOptions(list)
end
dropPull = CombatR:Dropdown({
    Name = "Pull Target",
    Options = #TP.playerList() > 0 and TP.playerList() or { "-" },
    Required = false,
    Callback = function(v) if v ~= "-" then Pull.pick = v end end,
})
CombatR:Slider({ Name = "Distance", Default = 5, Minimum = 1, Maximum = 30, Precision = 0, Callback = function(v) Pull.dist = v end })
CombatR:Header({ Name = "Hitbox" })
CombatR:Toggle({ Name = "Expand Hitbox", Default = false, Callback = function(v) Hitbox.setOn(v) end })
CombatR:Toggle({ Name = "Show Box", Default = true, Callback = function(v) Hitbox.showBox = v end })
CombatR:Slider({ Name = "Hitbox Size", Default = 5, Minimum = 1, Maximum = 50, Precision = 0, Callback = function(v) Hitbox.size = v end })

local VisualL = TabVisual:Section({ Side = "Left" })
local VisualR = TabVisual:Section({ Side = "Right" })

local function espToggle(name, key, def)
    VisualL:Toggle({
        Name = name,
        Default = def,
        Callback = function(v)
            ESP[key] = v
            ESP.refreshPreview()
        end,
    })
end

VisualL:Header({ Name = "ESP" })
espToggle("Boxes", "boxes", false)
espToggle("Names", "names", false)
espToggle("Distance", "dist", false)
espToggle("Health", "health", false)
espToggle("Weapon", "weapon", false)
espToggle("Flags", "flags", false)
espToggle("Team Flag", "teamFlag", false)
espToggle("Tracers", "tracers", false)
espToggle("Highlight", "chams", false)
espToggle("Skeleton", "skeleton", false)
espToggle("Team Color", "teamColor", false)
VisualL:Toggle({ Name = "Hide Team", Default = false, Callback = function(v) ESP.hideTeam = v end })
VisualL:Toggle({
    Name = "NPC ESP",
    Default = false,
    Callback = function(v)
        ESP.npc = v
        Npc.esp = v
        if v then
            Npc.last = 0
            Npc.tick()
        else
            Npc.cleanEsp()
        end
    end,
})

VisualL:Colorpicker({
    Name = "Color",
    Default = Color3.fromRGB(0, 255, 128),
    Callback = function(v) ESP.color = v ESP.refreshPreview() end,
})
VisualL:Colorpicker({
    Name = "Team",
    Default = Color3.fromRGB(80, 160, 255),
    Callback = function(v) ESP.teamTint = v ESP.refreshPreview() end,
})
VisualL:Colorpicker({
    Name = "Enemy",
    Default = Color3.fromRGB(255, 70, 70),
    Callback = function(v) ESP.enemyTint = v ESP.refreshPreview() end,
})

VisualL:Header({ Name = "Camera" })
VisualL:Slider({ Name = "FOV", Default = Cam.defFov, Minimum = 40, Maximum = 120, Precision = 0, Callback = function(v) Cam.fov = v end })
VisualL:Toggle({ Name = "Infinity Zoom", Default = false, Callback = function(v) Zoom.setOn(v) end })
VisualL:Toggle({ Name = "Crosshair", Default = false, Callback = function(v) Cross.on = v end })
VisualL:Toggle({ Name = "Freecam", Default = false, Callback = function(v) Cam.setFree(v) end })
VisualL:Slider({ Name = "Freecam Speed", Default = 50, Minimum = 10, Maximum = 300, Precision = 0, Callback = function(v) Cam.freeSpd = v end })
VisualL:Header({ Name = "World" })
VisualL:Toggle({ Name = "Fullbright", Default = false, Callback = function(v) World.setBright(v) end })
VisualL:Toggle({ Name = "No Fog + Blur", Default = false, Callback = function(v) World.setClear(v) end })
VisualR:Toggle({ Name = "Radar", Default = false, Callback = function(v) Radar.on = v end })

VisualR:Header({ Name = "Preview" })
local okPrev, prev = pcall(function()
    return VisualR:ESPPreview({ Name = "ESP Preview" })
end)
if okPrev then
    ESP.preview = prev
    ESP.refreshPreview()
else
    notify("ESP Preview", "วาง maclib.txt ใน workspace executor", 5)
end

local TpL = TabTP:Section({ Side = "Left" })
local TpR = TabTP:Section({ Side = "Right" })

TpL:Header({ Name = "Quick" })
TpL:Toggle({ Name = "Alt + Click TP", Default = false, Callback = function(v) TP.click = v end })

TpL:Header({ Name = "Players" })
local dropPlayer
local function refreshPlayers()
    if not dropPlayer then return end
    local list = TP.playerList()
    if #list == 0 then list = { "-" } end
    dropPlayer:ClearOptions()
    dropPlayer:InsertOptions(list)
    refreshPull()
end
dropPlayer = TpL:Dropdown({
    Name = "Player",
    Options = #TP.playerList() > 0 and TP.playerList() or { "-" },
    Required = false,
    Callback = function(v) if v ~= "-" then TP.pickPlayer = v end end,
})
TpL:Button({ Name = "Teleport", Callback = function() if TP.pickPlayer then TP.toPlayer(TP.pickPlayer) end end })
TpL:Toggle({ Name = "Spectate", Default = false, Callback = function(v) TP.spectatePlayer(v) end })

TpR:Header({ Name = "Waypoints" })
local dropPoint
local function refreshPoints()
    if not dropPoint then return end
    local list = TP.pointList()
    if #list == 0 then list = { "-" } end
    dropPoint:ClearOptions()
    dropPoint:InsertOptions(list)
end
TpR:Button({ Name = "Save Position", Callback = function() local name = TP.saveHere() if name then refreshPoints() end end })
dropPoint = TpR:Dropdown({
    Name = "Waypoint",
    Options = #TP.pointList() > 0 and TP.pointList() or { "-" },
    Required = false,
    Callback = function(v) if v ~= "-" then TP.pickPoint = v end end,
})
TpR:Button({ Name = "Go", Callback = function() if TP.pickPoint then TP.toPoint(TP.pickPoint) end end })
TpR:Button({
    Name = "Delete",
    Callback = function()
        if TP.pickPoint then
            TP.wp[TP.pickPoint] = nil
            TP.pickPoint = nil
            refreshPoints()
        end
    end,
})

local AvL = TabAvatar:Section({ Side = "Left" })
local AvR = TabAvatar:Section({ Side = "Right" })

local outfitField
AvL:Header({ Name = "Copy Avatar" })
outfitField = AvL:Input({
    Name = "Username",
    Placeholder = "ชื่อ Roblox",
    AcceptedCharacters = "All",
    onChanged = function(t) Avatar.pendingName = t end,
})
AvL:Button({
    Name = "Copy Avatar",
    Callback = function()
        local name = Avatar.pendingName
        if outfitField and outfitField.GetInput then
            local t = outfitField:GetInput()
            if t and t ~= "" then name = t end
        end
        Avatar.copyOutfit(name)
    end,
})

AvR:Toggle({
    Name = "Headless + Korblox Leg",
    Default = false,
    Callback = function(v) Avatar.setKorbloxHeadless(v) end,
})
local SysL = TabSys:Section({ Side = "Left" })
local SysR = TabSys:Section({ Side = "Right" })

SysL:Header({ Name = "Menu" })
SysL:Keybind({
    Name = "Menu Key",
    Default = Enum.KeyCode.LeftControl,
    onBinded = function(key)
        UI_KEY = key
        Window:SetKeybind(UI_MUTE_KEY)
        notify("Menu Key", key.Name, 3)
    end,
})
SysL:Button({ Name = "Hide UI", Callback = toggleUi })

SysL:Header({ Name = "Safety" })
SysL:Toggle({ Name = "Anti AFK", Default = false, Callback = function(v) Sys.antiAfk = v end })
SysL:Toggle({ Name = "Auto Respawn", Default = false, Callback = function(v) Sys.autoRespawn = v end })
SysL:Button({ Name = "Panic", Callback = Sys.panic })
SysL:Keybind({
    Name = "Panic Key",
    Default = Enum.KeyCode.End,
    onBinded = function(key) Sys.panicKey = key end,
})

SysL:Header({ Name = "Performance" })
SysL:Button({ Name = "Unlock FPS", Callback = function() if setfpscap then setfpscap(999) end end })
SysL:Button({ Name = "Low Graphics", Callback = Net.lowGraphics })

SysR:Header({ Name = "Server" })
SysR:Button({
    Name = "Copy JobId",
    Callback = function()
        if setclipboard then
            setclipboard(game.JobId)
            notify("Copied", game.JobId, 4)
        else
            notify("Copy Failed", "Executor ไม่รองรับ clipboard", 4)
        end
    end,
})

local jobField
jobField = SysR:Input({
    Name = "JobId",
    Placeholder = "วาง JobId...",
    AcceptedCharacters = "All",
    onChanged = function(t) Avatar.pendingJob = t end,
})
SysR:Button({
    Name = "Join JobId",
    Callback = function()
        local id = Avatar.pendingJob
        if jobField and jobField.GetInput then
            local t = jobField:GetInput()
            if t and t ~= "" then id = t end
        end
        Net.joinJob(id)
    end,
})

SysR:Button({
    Name = "Reset Character",
    Callback = function()
        if Char.hum then Char.hum.Health = 0 end
    end,
})
SysR:Button({
    Name = "Server Hop",
    Callback = function()
        if not Net.serverHop() then notify("Hop Failed", "No server or HTTP blocked.", 4) end
    end,
})
SysR:Button({ Name = "Rejoin", Callback = Net.rejoin })

for _, p in ipairs(S.Players:GetPlayers()) do
    ESP.track(p)
    hookPlayer(p)
end
Conn.track(S.Players.PlayerAdded:Connect(function(p)
    ESP.track(p)
    hookPlayer(p)
    refreshPlayers()
    if Hitbox.on and p.Character then Hitbox.draw() end
end))
Conn.track(S.Players.PlayerRemoving:Connect(function(p)
    ESP.drop(p)
    refreshPlayers()
end))

refreshPlayers()
refreshPoints()
if not Hook.install() then
    task.defer(function() notify("Hooks", "hookmetamethod notsupport", 5) end)
end

function Conn.destroyGui()
    UI.win, UI.gui = nil, nil
    purgeMacUi()
end

function Conn.shutdown()
    if not Conn.live then return end
    Conn.live = false
    Conn.clear()
    for _, conn in ipairs(Conn.list) do pcall(function() conn:Disconnect() end) end
    table.clear(Conn.list)
    Avatar.copiedUid = nil
    Avatar.respawning = false
    TP.spectatePlayer(false)
    Hitbox.setOn(false)
    Gun.reset()
    Move.reset()
    Cam.reset()
    Zoom.setOn(false)
    World.setBright(false)
    World.setClear(false)
    World.instant = false
    Aimbot.reset()
    Pull.all = false
    Pull.one = false
    Npc.esp = false
    Npc.aim = false
    Aimbot.npc = false
    ESP.npc = false
    pcall(Npc.cleanEsp)
    pcall(function()
        ESP.preview = nil
        for target in pairs(ESP.cache) do ESP.drop(target) end
    end)
    pcall(Cross.kill)
    pcall(Radar.kill)
    if getgenv()._eliteIdle then
        pcall(function() getgenv()._eliteIdle:Disconnect() end)
        getgenv()._eliteIdle = nil
    end
    if Avatar.korbloxOn or Avatar.headlessOn then
        Avatar.setKorbloxHeadless(false)
    end
end

function Conn.kill(fromUi)
    if Conn._busy then return end
    Conn._busy = true
    Conn.shutdown()
    pcall(Char.restorePhys)
    local win = UI.win
    UI.win, UI.gui = nil, nil
    if win and not fromUi then pcall(function() win:Unload() end) end
    purgeMacUi()
    Conn._busy = false
end

getgenv()._eliteShutdown = function() Conn.kill(true) end