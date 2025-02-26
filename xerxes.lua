--[[

        Shock X Banov

]]

getgenv().config = {
    ["Enabled"] = true,
    ["Magnitude Before TP"] = 7,
    ["Lunge Only"] = true,
    ["Sword Direction"] = "Left",
    ["Autoclicker"] = false,
    ["Disable Connections"] = true;
}

local runService = game.GetService(game, "RunService")
local players = game.GetService(game, "Players")
local localPlayer = players.LocalPlayer
local originalStates = {
    ["Lunging"] = Vector3.new(-0, -0, 1),
    ["Idle"] = Vector3.new(-1, -0, -0)
}

local function IsLunging()
    if localPlayer.Character:FindFirstChildOfClass("Tool").GripUp.Z == 0 then
        return true
    end
    return false
end

local hook; hook = hookmetamethod(game, "__index", function(self, key)
    if not checkcaller() and tostring(key):find("GripForward") then
        if IsLunging() == true then
            return originalStates["Lunging"]
        elseif IsLunging() == false then
            return originalStates["Idle"]
        end
    end
    return hook(self, key)
end)

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local X = Material.Load({
    Title = "Xerxes Gui",
    Style = 3,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark",
    ColorOverrides = {
        MainFrame = Color3.fromRGB(30,30,30)
    }
})

local Y = X.New({
    Title = "balboa = gud"
})

local B = Y.Toggle({
    Text = "Toggle On",
    Callback = function(Value)
        getgenv().config["Enabled"] = Value
    end,
    Enabled = true
})

local C = Y.Slider({
    Text = "Magnitude Before TP",
    Callback = function(Value)
        getgenv().config["Magnitude Before TP"] = Value
    end,
    Min = 0,
    Max = 25,
    Def = 10
})

local D = Y.Toggle({
    Text = "Only On Lunge",
    Callback = function(Value)
        getgenv().config["Lunge Only"] = Value
    end,
    Enabled = true
})

local E = Y.Dropdown({
    Text = "Sword Direction",
    Callback = function(Value)
        getgenv().config["Sword Direction"] = Value
    end,
    Options = {
        "Right",
        "Left",
        "HRP",
    },
    Menu = {
        Information = function(self)
            X.Banner({
                Text = "balboa?"
            })
        end
    }
})

local F = Y.Toggle({
    Text = "Autoclicker",
    Callback = function(Value)
        getgenv().config["Autoclicker"] = Value
    end,
    Enabled = false
})

local G = Y.Toggle({
    Text = "Disable Connections",
    Callback = function(Value)
        getgenv().config["Disable Connections"] = Value
    end,
    Enabled = true
})

game:GetService("UserInputService").InputBegan:connect(function(inp, gpe)
	if gpe then return end
	if inp.KeyCode == Enum.KeyCode.X then
		game:GetService("CoreGui")["Xerxes Gui"].Enabled = not game:GetService("CoreGui")["Xerxes Gui"].Enabled
	end
end)

runService.RenderStepped:Connect(function()
    pcall(function()
        if config["Enabled"] then
            for i, v in pairs(players:GetPlayers()) do 
                if v.UserId ~= localPlayer.UserId and (v.Character.HumanoidRootPart.Position - localPlayer.Character:FindFirstChildOfClass("Tool").Handle.Position).Magnitude <= getgenv().config["Magnitude Before TP"] then
                    if getgenv().config["Disable Connections"] then
                        for _,x in pairs(getconnections(localPlayer.Character:FindFirstChildOfClass("Tool"):GetPropertyChangedSignal("GripRight"))) do v:Disable() end
                        for _,x in pairs(getconnections(localPlayer.Character:FindFirstChildOfClass("Tool"):GetPropertyChangedSignal("Grip"))) do v:Disable() end
                    end
                    if getgenv().config["Lunge Only"] then
                        if localPlayer.Character:FindFirstChildOfClass("Tool").GripUp.Z == 0 then
                            if getgenv().config["Sword Direction"] == "Right" then
                                localPlayer.Character:FindFirstChildOfClass("Tool").GripRight = Vector3.new(0, 0, 1)
                            elseif getgenv().config["Sword Direction"] == "Left" then
                                localPlayer.Character:FindFirstChildOfClass("Tool").GripRight = Vector3.new(0, 0, -1)
                            elseif getgenv().config["Sword Direction"] == "HRP" then
                                localPlayer.Character:FindFirstChildOfClass("Tool").GripRight = v.Character.HumanoidRootPart.Position
                            end
                        end
                    else
                        if getgenv().config["Sword Direction"] == "Right" then
                            localPlayer.Character:FindFirstChildOfClass("Tool").GripRight = Vector3.new(0, 0, 1)
                        elseif getgenv().config["Sword Direction"] == "Left" then
                            localPlayer.Character:FindFirstChildOfClass("Tool").GripRight = Vector3.new(0, 0, -1)
                        elseif getgenv().config["Sword Direction"] == "HRP" then
                            localPlayer.Character:FindFirstChildOfClass("Tool").GripRight = v.Character.HumanoidRootPart.Position
                        end
                    end
                end
            end
        end
        if getgenv().config["Autoclicker"] then
            localPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
        end
    end)
end)
