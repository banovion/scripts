--[[
Vesteria GUI created by banovion|@banov on discord
Required functions: hookfunction,hookmetamethod,restorefunction,debug.getinfo
Made on 3/16/2025
]]

local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local MarketplaceService = cloneref(game:GetService("MarketplaceService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Mouse = Players.LocalPlayer:GetMouse()

local Luxtl = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Luxware-UI-Library/main/Source.lua"))()
local Luxt = Luxtl.CreateWindow("Vesteria GUI", 6105620301)

local combatTab = Luxt:Tab("Combat", 6087485864)
local mainTab = Luxt:Tab("Farming")
local teleportsTab = Luxt:Tab("Teleports")
local characterTab = Luxt:Tab("Character")
local creditsTab = Luxt:Tab("Credits")
local cf = creditsTab:Section("Script creator")
cf:Credit("banovion")

staminaval = Players.LocalPlayer.Character.hitbox.stamina

local ntab = combatTab:Section("Combat")
ntab:Toggle("Godmode", function(toggled)
    local callback = debug.getinfo(ReplicatedStorage.network.RemoteEvent.playerRequest_damageEntity.FireServer)
    if toggled then
        local old;old = hookfunction(callback.func, function(...)
            local caller = getcallingscript()
            if caller.Name == "entityRenderer" then
                return nil
            end
            return old(...)
        end)
    else
        restorefunction(callback.func)
    end
end)

ntab:Toggle("Anti Knockback", function(toggled)
    local knock = debug.getinfo(ReplicatedStorage.network.BindableEvent_Client.applyKnockbackVelocityToCharacter.fire)
    if toggled then
        local v;v = hookfunction(knock.func, function(...)
        local cs = getcallingscript()
        if not checkcaller() and cs.Name == "entityRenderer" then
            return nil
            end
            return v(...)
        end)
    elseif not toggled then
        restorefunction(knock.func)
    end
end)

ntab:Toggle("Inf stamina", function(toggled)
    if toggled then
        local stamina;stamina = hookmetamethod(game, "__index", function(...)
        local self,arg = ...
        if not checkcaller() and typeof(self) == "Instance" and compareinstances(self, staminaval) and typeof(arg) == "string" then
            return math.huge
        end
        return stamina(...)
        end)
    end
end)

local cour
local xtab = mainTab:Section("Farming")
xtab:Toggle("Auto collect (silently collects items around the map\nwithout tping) some items i.e potions arent grabbed", function(toggled)
    if toggled then
        local cour = task.spawn(function()
            while task.wait(1/2) do
                for i,v in pairs(workspace.placeFolders.items:GetChildren()) do
                    if v then
                        ReplicatedStorage.network.RemoteFunction.pickUpItemRequest:InvokeServer(v)
                    end
                end
            end
        end)
    elseif not toggled then
        if cour then
            task.cancel(cour)
            cour = nil
        end
    end
end)

xtab:Toggle("Nearby collect (basically the above but for\nmanual farming)", function(toggled)
    if toggled then
        task.spawn(function()
            while toggled do
                for i, v in pairs(workspace.placeFolders.items:GetChildren()) do
                    if (v.Position - Players.LocalPlayer.Character.hitbox.Position).Magnitude <= 15 then
                        ReplicatedStorage.network.RemoteFunction.pickUpItemRequest:InvokeServer(v)
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

xtab:Button("Collect all chests (doesnt get special chests)\t\t\t\t\t\t", function()
    for i,v in pairs(workspace.Chests:GetChildren()) do
        local rootchest = v.RootPart
        Players.LocalPlayer.Character.hitbox.Position = rootchest.Position
        ReplicatedStorage.network.BindableFunction_Client.openTreasureChest_client:Invoke(v)
        task.wait(0.5)
    end
end)

local destinations = {}
local destinationnames = {}
local absdestinations = {}

for i, v in pairs(getinstances()) do
    if v.Name == "TeleportBrick" or v.Name == "teleportPart" then
        local absdestination = v:FindFirstChild("teleportDestination")
        local destination = v:FindFirstChild("teleportDestination").Value
        table.insert(destinations, destination)
        table.insert(absdestinations, absdestination)
    end
end

for i,v in pairs(destinations) do
    local destinationname = MarketplaceService:GetProductInfo(v).Name
    table.insert(destinationnames,destinationname)
end

local ttab = teleportsTab:Section("Teleports")
ttab:DropDown("Destination", destinationnames, function(name)
    for i,v in pairs(destinationnames) do
        if v == name then
            local absdestination = absdestinations[i]
            Players.LocalPlayer.Character.hitbox.Position = absdestination.Parent.Position
            break
        end
    end
end)

local chartab = characterTab:Section("Character")
chartab:Toggle("Click teleport (Y key to teleport)", function(toggled)
    if toggled then
        clicktp = game:GetService("UserInputService").InputBegan:Connect(function(key,gpe)
            if not gpe and key.KeyCode == Enum.KeyCode.Y then
                Players.LocalPlayer.Character.hitbox.Position = Mouse.Hit.Position
            end
        end)
    elseif not toggled then
        clicktp:Disconnect()
        clicktp = nil
    end
end)

-- experimental walkspeed not finished
--[[
print(string.rep(' ',50))
local inst = game:GetService("Players").LocalPlayer.PlayerScripts.repo.controlScript
local walkspeed = 70
for i, v in pairs(getgc()) do
    if typeof(v) == "function" and islclosure(v) and rawget(getfenv(v), "script") == inst then
        for index, value in ipairs(getupvalues(v)) do
            if index == 2 and value == 18 then
                print("got")
                local stack = debug.getstack(1)
                if stack[12] then
                    print("stack value:", stack[12])
                    debug.setstack(1, 12, walkspeed)
                    local newstack = debug.getstack(1)
                    print("changed walkspeed to", newstack[12])
                end
            end
        end
    end
end
]]
