print("executed")

local cfg = {
    ["entitiesesp"] = true,
    ["distancecheck"] = true,
    ["tasksesp"] = true
}

local distancecheck = 60.0 -- change for lower distance check

local check = setmetatable({}, {__call = function(x, p, ...) if not p then return end
    for i,v in ipairs({...}) do p = p:FindFirstChild(v) 
    if not p then return end end return p end
})

local function DetectEntities()
    local ef = check(game.Workspace, "Entities") if not ef then return {} end
    
    local models = {}
    for i, model in pairs(ef:GetChildren()) do
        if model:IsA("Model") then
            local root = model.RootPart or model.HumanoidRootPart or model.PrimaryPart
            if root then
                table.insert(models, {model = model, root = root})
            end
        end
    end
    return models
end

local function EntitiesESP()
    local color = Color3.fromRGB(255, 215, 0)
    for i, ent in pairs(DetectEntities()) do
        local sx, sy, visible = utility.world_to_screen(ent.root.Position)
        if visible then
            draw.text_outlined(ent.model.Name, sx-40, sy-25, color, "ConsolasBold", 255)
        end
    end
end

local function DistanceCheck()
    local hrp = entity.GetLocalPlayer():GetBoneInstance("HumanoidRootPart")
    
    for i, ent in pairs(DetectEntities()) do
        local distance = (ent.root.Position - hrp.Position).Magnitude
        if distance <= distancecheck then
            local sx, sy, visible = utility.world_to_screen(entity.GetLocalPlayer():GetBoneInstance("HumanoidRootPart").Position)
            if visible then
                local text = string.format("%s NEARBY", ent.model.Name)
                draw.text_outlined(text, sx-50, sy-150, Color3.fromRGB(255, 0, 0), "ConsolasBold", 255)
                draw.text_outlined(text, sx, sy-50, Color3.fromRGB(255, 0, 0), "ConsolasBold", 255) -- change to also overlay on closest task
                draw.text_outlined(text, sx+80, sy-200, Color3.fromRGB(255, 0, 0), "ConsolasBold", 255)
            end
        end
    end
end

local function TasksESP()
    local ef = check(game.Workspace, "CurrentMap", "CurrentTasks")
    if not ef then return end

    local green = Color3.fromRGB(0, 255, 0)   -- not completed
    local red = Color3.fromRGB(255, 10, 10) -- completed
    
    for i, model in pairs(ef:GetChildren()) do
        if model:IsA("Model") then
            local root = model.Base or model.Main or model.PrimaryPart or model.MainBase or model.Knob or model.Grid or model:FindFirstChildOfClass("MeshPart")
            if root then
                local completed = model:FindFirstChild("Completed")
                
                local color = red
                if completed and completed:IsA("BoolValue") then
                    if completed.Value ~= 1 then
                        color = green
                    end
                end
                
                local sx, sy, visible = utility.world_to_screen(root.Position)
                if visible then
                    draw.text_outlined(model.Name, sx-40, sy-25, color, "ConsolasBold", 255)
                end
            end
        end
    end
end

local code = {{EntitiesESP, cfg["entitiesesp"]},{TasksESP, cfg["tasksesp"]},{DistanceCheck, cfg["distancecheck"]}}
setmetatable(code, {__call = function(t)
    for i, v in ipairs(t) do
        if v[2] then v[1]() end
    end
end})

cheat.register("onPaint", function()
    code()
end)
