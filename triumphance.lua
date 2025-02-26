-- aka modified hitware

local on = true
local distance = 5

local starterGui = game:GetService("StarterGui")
local plr = game:GetService('Players').LocalPlayer
local cooldown = false
game:GetService('RunService').Heartbeat:connect(function()
    if on then
    local hum = plr.Character.Humanoid
        for _,v in ipairs(game.Players:GetPlayers()) do
            if v.Name ~= plr.Name then
                local s,e = pcall(function()
                    local root = v.Character.HumanoidRootPart
                    local torso = v.Character.Torso
                    local head = v.Character.Head
                    local leftarm = v.Character["Left Arm"]
                    local rightarm = v.Character["Right Arm"]
                    local leftleg = v.Character["Left Leg"]
                    local rightleg = v.Character["Right Leg"]

                    local sword = hum.Parent:FindFirstChildOfClass('Tool')
                    if sword and (root.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= distance then 
                         if cooldown == false then
                        cooldown = true
                        firetouchinterest(sword.Handle, root, 1)
                        firetouchinterest(sword.Handle, root, 0)
                        wait(0.05)
                        cooldown = false
                        end
                    end
                end) if e then print(e) end
            end
        end
    end
end)
local is_on = function()
    return on and 'on' or 'off'
end

local mouse = plr:GetMouse()
mouse.KeyDown:connect(function(key)
    if key == 'r' then
        on = not on
    elseif key == 'u' then
        local status = is_on()
        starterGui:SetCore('SendNotification', {Title = "TRIUMPHANCE", Text = 'Hitware is '..status..'. Current: '.. distance..' studs'})
    elseif key == "q" then
        distance = distance + 1
        starterGui:SetCore("SendNotification", {Title = "TRIUMPHANCE", Text = "Hitware has increased by 1. Current: " .. distance..' studs'})
    elseif key == "e" then
        if distance > 1 then
            distance = distance - 1
            starterGui:SetCore("SendNotification", {Title = "TRIUMPHANCE", Text = "Hitware has decreased by 1. Current: " .. distance..' studs'})
        else
            starterGui:SetCore("SendNotification", {Title = "TRIUMPHANCE", Text = "Cannot decrease any further!"})
        end
    end
end)

local AC = false
local Key = Enum.KeyCode.G

game:GetService("UserInputService").InputBegan:Connect(function(k,g)
  if not g and k.KeyCode == Key then
    AC = not AC
  end
end)

while wait() do
  if AC then
     pcall(function()
       local Sword = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass'Tool'
Sword:Activate()
 Sword:Activate()
            end)
  end
end
