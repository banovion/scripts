--[[
Universal tank script created by banov#0 made to be extremely hard to detect in order to improve my demongod antiexploit. | 12/11/24

If you were sent this script I ask you to not leak it because this script is made to bypass every current anti and therefore is not meant for exploiters to use.

A short explanation for why this script works is because the three ways you can get hit by a sword is your client, the server and the .touched firer's script
which causes you to be able to get damaged up to 3 times in 1 hit. This script changes your client so you do not take damage from sword hits on your screen
effectively giving you a large advantage.

--]]


getgenv().config = {
    ["Tank type"] = "handle", -- other tank types are "handle" and "destroy", handle is the most likely to get detected by a good anti 
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

local players = game:GetService("Players")
local client = players.LocalPlayer
local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")


-- // Pre-Core \\ --

local function processtool(tool, action)
    if tool and tool:FindFirstChild("Handle") then
    local handle = tool.Handle
    if action and type(action) == "function" then
        action(handle)
        end
    end
end

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
    "destroy"
}

local i = 1

uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightBracket then
            i = i % #t + 1 -- chatgpt'd this part cuz fuck math LUL
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
        for each, fatass in pairs(workspace:GetDescendants()) do
            if fatass:IsA("Model") and fatass.Name == client.Name then
                continue
            end
                    if fatass:IsA("Tool") then
                        processtool(fatass, function(handle)
                        if config["Universal/Watchdog Bypass Mode"] then
                            setsecureinstance(handle)
                        end
                        if handle then
                    if config["Tank type"]:lower() == "grippos" then
                        handle.Position = Vector3.new(9999, 9999, 9999)
                    elseif config["Tank type"]:lower() == "handle" then
                        handle.Size = Vector3.new(0, 0, 0)
                    elseif config["Tank type"]:lower() == "destroy" then
                        handle:Destroy()
                    end
                end
            end)
        end
    end
end)
end)
