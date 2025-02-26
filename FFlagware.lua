--[[
FFLAGWARE V1
Created by banovion the bladelord
Recommended values for closetting is 8-10, 1-4 is blatant (you will float), 11-13 is a small difference. 15 is the default value with no fflags on, 0 or negative integers freezes your character.
Created on 1/1/2025 if ur reading this happy new years
]]

if fflagware_LOADED then
    print("fagware is alredy running", 0)
    return
end

pcall(function() getgenv().fflagware_LOADED = true end)

if not setfflag then
print("ur executor doesnt support this script lil nigga, try getting awp or wave or sum");
return;
end;

--// Variables \\--
getgenv().Enabled = {
    ["Enabled"] = true
}
local RunService: RunService = game:GetService("RunService");
local starterGui: starterGui = game:GetService("StarterGui");
local basefflag: number = 15;
--local Safemode: Boolean = false; -- encases the entire script in a pcall to prevent desperate antis detecting this script via LogService, turn this off for manual debugging.

--// Keybinds --\\

getgenv().keybinds = {
		["Enabled"] = "[",
        ["Increase"] = "q",
        ["Decrease"] = "e"
}

--// Keybind functionality \\--

local mouse = game.Players.LocalPlayer:GetMouse();
mouse.KeyDown:Connect(function(key)
    if key == keybinds["Enabled"] then Enabled["Enabled"] = not Enabled["Enabled"];
    elseif key == keybinds["Increase"] then
        basefflag += 1
        starterGui:SetCore("SendNotification", {Title = "Banovions FFlagware", Text = "curent valuae incesed by 0ne. Current flag Valaeu: " .. basefflag})
    elseif key == keybinds["Decrease"] then
        basefflag -= 1
        starterGui:SetCore("SendNotification", {Title = "Banovions FFlagware", Text = "curent valuae incesed by 0ne. Current flag Valaeu: " .. basefflag})
        end
end)

--// Scipt --\\

while task.wait(1) do -- not using renderstepped for optimization
setfflag("DFIntS2PhysicsSenderRate", tostring(basefflag));
end