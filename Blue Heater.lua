-- by banov
local mt = getrawmetatable(game)
setreadonly(mt,false)
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))

-- inf stamina
local mainscript = Players.LocalPlayer.Character:WaitForChild("Animate",1/2)
local stamina = Players.LocalPlayer.Character.Values:WaitForChild("Stamina",1/2)
for i, v in pairs(getreg()) do
    if rawequal(typeof(v), "function") and rawget(getfenv(v), "script") == mainscript then

        local callback = debug.getinfo(v)
        if callback.name == "ActionHandler" then
            debug.setconstant(callback.func, 33, "GetStamina")
            local stam;stam = hookmetamethod(game, "__newindex", newcclosure(function(...)
                local args = {...}
                local self = rawget(args, 1)
                local key = rawget(args, 2)

                if not checkcaller() and rawequal(typeof(self), "Instance") and rawequal(key, "Value") then
                    rawset(args,3,self:GetAttribute("Max"))
                return stam(table.unpack(args))
                    
                end
            return stam(...)
            end))
		break
        end

    end
end

-- anti falldamage
local replicate = ReplicatedStorage:WaitForChild("PlayerEvents",1/2).Replicate
local hook;hook = hookfunction(mt.__namecall, newcclosure(function(...)
    local args = {...}
    local self = rawget(args, 1)
    local remargs = {select(2, ...)}

    if not checkcaller() and getnamecallmethod() == "FireServer" and compareinstances(self,replicate) and rawget(remargs, 1) == "Fall Damage" then
        rawset(remargs,2,{Difference = 0})
        return hook(self, table.unpack(remargs))
    end

    return hook(table.unpack(args))
end))

-- kill aura
while task.wait(1) do
	for _,x in pairs(workspace.SpawnedEntities:GetChildren()) do -- i couldve just did remotes but im lazy as fuck so i just did hbe
		if x:FindFirstChild("HumanoidRootPart") then
			local hrp = x:FindFirstChild("HumanoidRootPart")
			hrp.Size = Vector3.new(40,40,40)
			hrp.CanCollide = false
		end
	end
end

repeat
game:GetService("ReplicatedStorage").PlayerEvents.MobileEvents.Attack:Fire(true)
task.wait(1/20)
until acyisntaskid

while task.wait(1) do
	killaura()
end


--for i,v in getinstances() do if v:IsA("ProximityPrompt") and v.ActionText == "Pick Up" then fireproximityprompt(v)


-- change mobileevent to normal sword swings
-- switch killaura to remote based if its not laggy
-- autofarm
-- drop collector
-- auto quest
