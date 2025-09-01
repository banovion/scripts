-- blue heater script made by banov
local mt = getrawmetatable(game)
setreadonly(mt,false)
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local getreg = getreg or getregistry or debug.getregistry

getgenv().config = {
    ["infstamina"] = true,
    ["antifalldamage"] = true,
    ["killaura"] = true,
    ["collectdrops"] = false
}

function Run(x: boolean, func: () -> any): any?
    if config[x] then
        return func()
    end
end

-- inf stamina
local function InfStamina(): nil
    local mainscript, stamina = Players.LocalPlayer.Character:WaitForChild("Animate",1/2), Players.LocalPlayer.Character.Values:WaitForChild("Stamina",1/2)
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
end

-- anti falldamage
local function AntiFallDamage(): nil
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
end

-- kill aura
local function KillAura(): nil
    task.spawn(function(...)
        while config["killaura"] do
        	for _,x in pairs(workspace.SpawnedEntities:GetChildren()) do -- i couldve just did remotes but im lazy as fuck so i just did hbe
	        	if x:FindFirstChild("HumanoidRootPart") then
		        	local hrp = x:FindFirstChild("HumanoidRootPart")
			        hrp.Size = Vector3.new(40,40,40) -- add hooksignal
        			hrp.CanCollide = false -- add hooksignal
	        	end
	        end
        task.wait(1)
        end
    end)
    task.spawn(function(...)
        repeat
            ReplicatedStorage.PlayerEvents.MobileEvents.Attack:Fire(true)
            task.wait(1/20)
        until acyisntaskid or horizonisagoodanti
    end)
end

-- collect drops
local function CollectDrops(): nil -- this might lag u if ur on a shit pc
    task.spawn(function(...)
        while config["collectdrops"] do
            for i,v in workspace:GetDescendants() do
                if v:IsA("ProximityPrompt") and v.ActionText == "Pick up" and v.Enabled and v.Parent and v.Parent.Position then
                    -- workspace.StreamingEnabled = false
                    Players.LocalPlayer.Character.HumanoidRootPart.Position = v.Parent.Position
                    fireproximityprompt(v)
                end
            end
            task.wait(3/4)
        end
    end)
end

-- change mobileevent to normal sword swings
-- switch killaura to remote based if its not laggy
-- autofarm
-- auto chest
-- auto quest
-- switch pairs to in {}

Run("infstamina", InfStamina)
Run("antifalldamage", AntiFallDamage)
Run("killaura", KillAura)
Run("collectdrops", CollectDrops)
