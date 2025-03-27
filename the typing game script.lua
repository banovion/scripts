-- banov the typing game script
-- if u type over 300WPM u get kicked i tried to make it slower than that but u still may get kicked sometimes
local vim = cloneref(game:GetService("VirtualInputManager"))
local container = workspace.Board.Gameplay.Container

local function sendkey(key)
	pcall(function()
		if key == " " then
			vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
		else
			vim:SendKeyEvent(true, Enum.KeyCode[key], false, game)
		end
	end)
end

local numbers = {}
local numbers2 = {}
local keys = {}

for i,v in ipairs(workspace.Board.Gameplay.Container["1"]["1"]:GetChildren()) do
    if v:IsA("TextLabel") then
        table.insert(numbers, v)
    end
end
for i,v in ipairs(workspace.Board.Gameplay.Container["1"]["2"]:GetChildren()) do
    if v:IsA("TextLabel") then
        table.insert(numbers2, v)
    end
end
table.sort(numbers2, function(a, b)
    return tonumber(a.Name) < tonumber(b.Name)
end)
for i,v in ipairs(numbers) do
    local key = v.Text
    table.insert(keys,key)
end
for i,v in ipairs(numbers2) do
    local key = v.Text
    table.insert(keys,key)
end
while task.wait(1/10) do
    for i,v in ipairs(keys) do
        sendkey(v:upper())
    end
end
