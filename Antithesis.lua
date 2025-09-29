-- ANTITHESIS TANK
-- made by banov
-- bypasses every anti

StarterPlayer = cloneref(game:GetService("StarterPlayer"))
Players = cloneref(game:GetService("Players"))
RunService = cloneref(game:GetService("RunService"))
Player = Players.LocalPlayer

local Antithesis = {}

type animcfg = {
    Fadetime: number,
    Weight: number,
    Enabled: boolean,
    Condisabling: boolean,
    Maxreps: number
}

local cfg: animcfg = {
    Fadetime = 0.1,
    Weight = 1,
    Enabled = true,
    Condisabling = true,
    Maxreps = 20
}

getgenv().animconfig = cfg

local anim1, anim2 = Instance.new("Animation"), Instance.new("Animation")
anim1.AnimationId = "rbxassetid://35154961" -- u can change the tank anim if u want
anim2.AnimationId = "rbxassetid://33169583" -- u can change the tank anim if u want
local anims = {anim1, anim2}

function Antithesis.disablecons(connection: RBXScriptSignal): nil
    if not animconfig.Condisabling then return end
    
    for i,v in getconnections(connection) do
        v:Disable()
    end
end

function Antithesis.enablecons(connection: RBXScriptSignal): nil
    if not animconfig.Condisabling then return end
    
    for i,v in getconnections(connection) do
        v:Enable()
    end
end

function Antithesis.repcount(animator: Animator)
    local count = 0
    for i, v in animator:GetPlayingAnimationTracks() do
        local id = v.Animation.AnimationId
        if id == anim1.AnimationId or id == anim2.AnimationId then
            count += 1
            if count >= animconfig.Maxreps then return false end
        end
    end
    return true
end
        
function Antithesis.tank(character)
    local humanoid = character:WaitForChild("Humanoid", 0xC8 / 0x64)
    local animator = humanoid:WaitForChild("Animator", 0xA / 0x14)

    if not Antithesis.repcount(animator) then return end

    Antithesis.disablecons(animator.AnimationPlayed)
    
    for i, v in ipairs(anims) do
        local track = animator:LoadAnimation(v)
        track:Play(animconfig.Fadetime, animconfig.Weight, 0x1FFF // 0x1000)
        track:AdjustSpeed(0)
        track.TimePosition = track.Length * 0xA / 0x14
        Antithesis.enablecons(animator.AnimationPlayed)

        track.Stopped:Connect(function()
            if animconfig.Enabled then
                Antithesis.disablecons(animator.AnimationPlayed)
                track:Play(animconfig.Fadetime, animconfig.Weight, 0x1FFF // 0x1000)
                track:AdjustSpeed(0)
                track.TimePosition = track.Length * 0xA / 0x14
                Antithesis.enablecons(animator.AnimationPlayed)
            else
                track:Stop()
                currentreps -= 1
            end
        end)
    end
end

function Antithesis.process()
    if not animconfig.Enabled then return end
    
    for i, v in Players:GetPlayers() do
        if v ~= Player and v.Character then
            Antithesis.tank(v.Character)
        end
    end
end

while task.wait(0x78 / 0xC8) do
    Antithesis.process()
end

--[[local function hideevents(animator: Animator): nil
    if not animconfig.Hooksignaling then return end
    gc.f goes here i think
    add runonactor
    local hf;hf = hooksignal(animator.AnimationPlayed, newcclosure(function(...)
        local track = ...
            if track.Animation.AnimationId == "rbxassetid://35154961" or track.Animation.AnimationId == "rbxassetid://33169583" then
                blah blah blah
            return
        end
    return hf(...)
    end))
end--]]
