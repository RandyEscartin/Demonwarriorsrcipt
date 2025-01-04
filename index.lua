-- Settings
local auraRange = 10
local farmRange = 20
local hatchMultiplier = 3
local expMultiplier = 10

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Player
local player = Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")

-- Kill Aura
local function aura()
    for _, enemy in pairs(Workspace:GetDescendants()) do
        if enemy:IsA("Humanoid") and enemy ~= humanoid then
            local distance = (enemy.HumanoidRootPart.Position - humanoid.HumanoidRootPart.Position).Magnitude
            if distance <= auraRange then
                enemy:TakeDamage(100)
            end
        end
    end
end

-- Auto-Farm
local function farm()
    for _, enemy in pairs(Workspace:GetDescendants()) do
        if enemy:IsA("Humanoid") and enemy ~= humanoid then
            local distance = (enemy.HumanoidRootPart.Position - humanoid.HumanoidRootPart.Position).Magnitude
            if distance <= farmRange then
                humanoid:MoveTo(enemy.HumanoidRootPart.Position)
                aura()
            end
        end
    end
end

-- Fast Hatch
local function hatch()
    local args = {
        ["hatchEgg"] = true,
        ["eggId"] = 1, -- Replace with desired egg ID
        ["hatchCount"] = hatchMultiplier
    }
    game:GetService("ReplicatedStorage").EggHatcher.HatchEgg:FireServer(args)
end

-- Exp Multiplier
local function expBoost()
    local args = {
        ["expMultiplier"] = expMultiplier
    }
    game:GetService("ReplicatedStorage").ExperienceBooster.BoostExperience:FireServer(args)
end

-- Loops
while true do
    aura()
    farm()
    wait(0.1)
end

-- Hatch and Exp Boost
while true do
    hatch()
    expBoost()
    wait(300) -- Adjust hatch interval
end
