if not game:IsLoaded() then
    game.Loaded:Wait()
end

local BASE = "https://raw.githubusercontent.com/xDTaraZz/Roblox-Scripts/refs/heads/main/All%20Map/"

local GAMES = {
    [10418224975] = "TNT Mining",
    [10684750879] = "Loot To Forge",
    [10765091041] = "Open Sea For Animals",
    [66654135] = "Murder Mystery 2",
    [1202096104] = "Driving Empire",
    [9534705677] = "Sniper Arena",
    [6739698191] = "Violence District",
    [10708913337] = "Anime Dice",
    [10035204815] = "Ride A Pet",
    [10031505426] = "AirDrop Arena",
    [7633926880] = "BloxStrike",
}

local function notify(text)
    pcall(game:GetService("StarterGui").SetCore, game:GetService("StarterGui"), "SendNotification", {
        Title = "Mario Hub",
        Text = text,
        Duration = 8,
    })
end

local name = GAMES[game.GameId]
if not name then
    return notify("This game is not supported yet. Join discord.gg/FHVfmeSceA for the list.")
end

local ok, source = pcall(game.HttpGet, game, BASE .. name:gsub(" ", "%%20") .. ".lua")
if not ok or type(source) ~= "string" then
    return notify("Could not download the " .. name .. " script. Try again.")
end

local fn, err = loadstring(source)
if not fn then
    return notify("The " .. name .. " script failed to load: " .. tostring(err))
end
fn()