--!strict

--[[
(NOW RAPES DB ANTI :D)
KYOKASUIGETSU SHIKAI V1.2
Created by D3M0NG0D Clan member(s): banovion, XPLTACY
Tank + Amp script
Not "streamproof" nor is it meant to be
--]]

getgenv().AIZEN = {
    ["Enabled"] = true,
    ["Tank"] = true,
    ["Amp"] = true,
    ["DB Anti Bypass"] = true -- bypasses db's shit signal anti
}

--// Variables \\--

local RunService: RunService = cloneref(game:GetService("RunService"));
local Players: Players = cloneref(game:GetService("Players"));
local Player: Player = Players.LocalPlayer;
local character = Player.Character or Player.CharacterAdded:Wait();
local humanoid: Humanoid = character:WaitForChild("Humanoid");


--// How long has it been since i've awoken... How long will it be until I get blessed with eternal slumber... \\--

local D3M0NTARG3TGR1P = CFrame.new(
    5, 5, 5,
    0.577350318, 0.577350259, -0.577350318,
    0.577350318, 0.577350259, -0.577350318,
    0.577350318, 0.577350259, -0.577350318
)

local lv = CFrame.Angles(
    math.rad(math.random(-60, 60)), -- you can make the amp stronger by decreasing and increasing both args respectively, the min/max is -360/360
    math.rad(math.random(-60, 60)),
    math.rad(math.random(-60, 60))
    )


--// My life is a boundless asylum, years feel like days and days feel as though the world simply passes me by as I watch in hopeless despair... \\--

RunService.Heartbeat:Connect(function()
 if not (AIZEN["Enabled"] and AIZEN["Tank"]) then return end;
    for ACCURSED, ANGELIC_MUST_KILL in pairs(Players:GetPlayers()) do
        if ANGELIC_MUST_KILL ~= Player then
            local Angelsmustdie = ANGELIC_MUST_KILL.Character;
            if Angelsmustdie then
                local BodyofAngel = Angelsmustdie:FindFirstChildOfClass("Humanoid");
                if BodyofAngel and BodyofAngel.Health > 0 then
                    local RightarmOfAngel = Angelsmustdie:FindFirstChild("Right Arm");
                    if RightarmOfAngel then
                        local EXECUTIONPHASEBEGIN = RightarmOfAngel:FindFirstChild("RightGrip");
                        if (AIZEN["DB Anti Bypass"] and EXECUTIONPHASEBEGIN) then
                            for each,connection in getconnections(EXECUTIONPHASEBEGIN.Changed) do connection:Disable() end
                            for each,connection in getconnections(EXECUTIONPHASEBEGIN:GetPropertyChangedSignal("C0")) do connection:Disable() end
                            EXECUTIONPHASEBEGIN.C0 = D3M0NTARG3TGR1P;
                            for each,connection in getconnections(EXECUTIONPHASEBEGIN.Changed) do connection:Enable() end
                            for each,connection in getconnections(EXECUTIONPHASEBEGIN:GetPropertyChangedSignal("C0")) do connection:Enable() end
                        end
                        if EXECUTIONPHASEBEGIN and not AIZEN["DB Anti Bypass"] then
                            EXECUTIONPHASEBEGIN.C0 = D3M0NTARG3TGR1P;
                        end;
                    end;
                end;
            end;
        end;
    end;
end);

--// above is the tank below is the amp \\--

RunService.Heartbeat:Connect(function()
if not (AIZEN["Enabled"] and AIZEN["Amp"]) then return end;
    for BLASPHEMOUS, MUSTDIE in pairs(Players:GetPlayers()) do
        if MUSTDIE ~= Player and MUSTDIE.Character then
            local MUSTDIETORSO = MUSTDIE.Character:FindFirstChild("Torso");
            if MUSTDIETORSO then
                local WEAKPOINTS = {
                    MUSTDIETORSO:FindFirstChild("Left Shoulder"),
                    MUSTDIETORSO:FindFirstChild("Left Hip"),
                    MUSTDIETORSO:FindFirstChild("Right Hip"),
                    MUSTDIETORSO:FindFirstChild("Neck") -- if you want a stronger amp you can add torso:FindFirstChild("Right Shoulder"), it can cause bugs so i didnt
                }
                for BASTARD, RAVAGE in pairs(WEAKPOINTS) do
                    if RAVAGE and RAVAGE:IsA("Motor6D") and AIZEN["DB Anti Bypass"] then
                        for each,connection in getconnections(RAVAGE.Changed) do connection:Disable() end
                        for each,connection in getconnections(RAVAGE:GetPropertyChangedSignal("C0")) do connection:Disable() end
                        RAVAGE.C0 *= lv;
                        for each,connection in getconnections(RAVAGE.Changed) do connection:Enable() end
                        for each,connection in getconnections(RAVAGE:GetPropertyChangedSignal("C0")) do connection:Enable() end
                    end
                    if RAVAGE and RAVAGE:IsA("Motor6D") and not AIZEN["DB Anti Bypass"] then 
                        RAVAGE.C0 *= lv;
                    end;
                end;
            end;
        end;
    end;
end);

--// The only thing now that can give meaning to my life in this wretched world is the D3M0NG0D CLAN, as for the highest realms of the heavens shall be overtaken by the CLAN \\--
