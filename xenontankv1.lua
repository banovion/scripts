--[[
XENON TANK V1.2

Universal tank script created by banov#0 made to be extremely hard to detect in order to improve my demongod antiexploit. | 12/11/24

Only use if u know the anti ur in only detects cantouch tank

A short explanation for why this script works is because the three ways you can get hit by a sword is your client, the server and the .touched firer's script
which causes you to be able to get damaged up to 3 times in 1 hit. This script changes your client so you do not take damage from sword hits on your screen
effectively giving you a large advantage.

--]]


getgenv().config = {
    ["Tank type"] = "touch_deletion", -- the tank types are "grippos", "destroy", "handle", "touch_deletion" "joint_deletion", ranked from least to most likely to bypass an anti
    ["Enabled"] = true, -- alternatively you can press [ to disable the tank
    ["BlatantMode"] = true,
    ["Universal/Watchdog Bypass Mode"] = false, -- doesn't work if you don't have wave or codex, makes the tank really buggy in exchange for bypassing strong antis
    ["Safe mode"] = false -- encases the entire script in a pcall and removes every print to prevent desperate antis detecting this script via LogService, turn this off for manual debugging.
}


getgenv().whitelist = {
    game.Players.LocalPlayer.Name
}

-- // Keybinds \\ --

getgenv().keybinds = {
		["Enabled"] = "[",
        ["Change tank type"] = "]" -- i wouldn't use this but you can
    --[[["Kill Script"] = ""
        ["Invisible Check"] = ,
        ["Team Check"] = , --]]
}


-- // Variables \\ --

local players: Players = cloneref(game:GetService("Players"))
local client = players.LocalPlayer
local uis: UserInputService = cloneref(game:GetService("UserInputService"))
local runservice: RunService = cloneref(game:GetService("RunService"))


-- // Pre-Core \\ --

local function processtool(tool, action)
    if tool and tool:FindFirstChild("Handle") then
    local handle = tool.Handle
    if action and type(action) == "function" then
        action(handle)
        end
    end
end
-- ignore most of this shit that doesnt work im too lazy to delete it, its from v1
local function safemodeprint(message)
    if not config["Safe mode"] then
        print(message)
    end
end

local function whitelisted(model)
    for uwu, owo in pairs(getgenv().whitelist) do
        if owo == model then
            return true
        end
    end
    return false
end

local function workspacetools()
    for ifurstillreading, justknowimgay in pairs(workspace:GetDescendants()) do
        if justknowimgay:IsA("Model") and justknowimgay.Name ~= client.Name then
            continue
        end
        if justknowimgay:IsA("Tool") then
            processtool(justknowimgay, function(handle)
                safemodeprint("handle found (workspace) [debug]")
            end)
        end
    end
end


workspacetools()


-- // Keybind functionality \\ --
uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then if input.KeyCode == Enum.KeyCode.LeftBracket then
            keybinds["Enabled"] = not keybinds["Enabled"]
            if keybinds["Enabled"] then
            safemodeprint("Disabled [debug]")
        else
                safemodeprint("Enabled [debug]")
            end
        end
    end
end)
-----------------------------------------------------
local t = {
    "grippos",
    "handle",
    "destroy",
    "joint_deletion"
}

local i = 1

uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightBracket then
            i = i % #t + 1
            config["Tank type"] = t[i]
            safemodeprint("Tank type changed to: " .. config["Tank type"] .. " [debug]")
            end
        end
    end)
		

-- // Core \\ --

local name = (identifyexecutor or getexecutorname)()
if not config["Safe mode"] then print(name)
    if name ~= "Wave" and name ~= "Codex" then
    config["Universal/Watchdog Bypass Mode"] = false
    safemodeprint("unsupported executor, disabling universal/watchdog bypass [debug]")
    end
end

runservice.RenderStepped:Connect(function()
    if not config["Enabled"] then return end
    pcall(function()
        for e,sex in pairs(players:GetChildren()) do
            if sex ~= client then
                local char = sex.Character
                local wmyex = char:FindFirstChildOfClass("Tool")
                local SUCKS = wmyex:FindFirstChild("Handle")
                        if config["Universal/Watchdog Bypass Mode"] then
                            setsecureinstance(handle)
                        end
                        if SUCKS then
                        if config["Tank type"]:lower() == "grippos" then
                            SUCKS.Position = Vector3.new(9999, 9999, 9999)
                    elseif config["Tank type"]:lower() == "handle" then
                    SUCKS.Size = Vector3.new(0, 0, 0)
                    elseif config["Tank type"]:lower() == "destroy" then
                    SUCKS:Destroy()
                    elseif config["Tank type"]:lower() == "joint_deletion" then
                    char:FindFirstChild("Right Arm"):FindFirstChild("RightGrip"):Destroy()
                    elseif config["Tank type"]:lower() == "touch_deletion" then
                    char:FindFirstChildOfClass("Tool"):FindFirstChild("Handle"):FindFirstChildOfClass("TouchTransmitter"):Destroy()
                    end
                end
            end
        end
    end)
end)
