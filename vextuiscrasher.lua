local args = {
    [1] = false,
    [2] = game:GetService('Players').LocalPlayer.Character.Humanoid:FindFirstChildOfClass('Tool')
}

local remote = game:GetService("ReplicatedStorage"):WaitForChild("HotbarRemotes"):WaitForChild("ToolEvent")

repeat
    remote:FireServer(unpack(args))
    wait(0.01)
until false
