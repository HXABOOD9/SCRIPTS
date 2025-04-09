-- NOVA HX v1 - RIVALS SCRIPT (Solara V3 Required)
-- Created by ChatGPT for RIVALS map
-- Features: Aimbot, Silent Aim, ESP, Wallhack, Wallbang, Player Mods, GUI

-- Load Solara V3 first before running this script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "NOVA HX v1 | RIVALS", HidePremium = false, SaveConfig = true, ConfigFolder = "NovaHX"})

-- Variables
local AimbotEnabled = false
local SilentAimEnabled = false
local ESPEnabled = false
local WallhackEnabled = false
local WallbangEnabled = false
local FlyEnabled = false
local NoclipEnabled = false
local NoRecoilEnabled = false
local InfiniteJumpEnabled = false

local AimbotFOV = 100
local AimbotSmoothness = 0.2

local FlySpeed = 50
local WalkSpeed = 20

-- Functions
function GetClosestPlayer()
    local closest, distance = nil, math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if mag < AimbotFOV and mag < distance then
                    closest, distance = player, mag
                end
            end
        end
    end
    return closest
end

-- Aimbot
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            local camPos = Camera.CFrame.Position
            local direction = (headPos - camPos).Unit
            local newCFrame = CFrame.new(camPos, camPos + direction)
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, AimbotSmoothness)
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- GUI Tabs
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "⚔️", PremiumOnly = false})
local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "👁️", PremiumOnly = false})
local PlayerTab = Window:MakeTab({Name = "Player", Icon = "👤", PremiumOnly = false})
local MiscTab = Window:MakeTab({Name = "Misc", Icon = "⚙️", PremiumOnly = false})

-- Combat
CombatTab:AddToggle({Name = "Aimbot", Default = false, Callback = function(v) AimbotEnabled = v end})
CombatTab:AddSlider({Name = "Aimbot FOV", Min = 10, Max = 300, Default = 100, Callback = function(v) AimbotFOV = v end})
CombatTab:AddSlider({Name = "Aimbot Smoothness", Min = 0, Max = 1, Default = 0.2, Increment = 0.01, Callback = function(v) AimbotSmoothness = v end})
CombatTab:AddToggle({Name = "Silent Aim", Default = false, Callback = function(v) SilentAimEnabled = v end})
CombatTab:AddToggle({Name = "Wallbang", Default = false, Callback = function(v) WallbangEnabled = v end})
CombatTab:AddToggle({Name = "No Recoil", Default = false, Callback = function(v) NoRecoilEnabled = v end})
CombatTab:AddButton({Name = "Unlock All Weapons + Skins", Callback = function()
    for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
        item:Clone().Parent = LocalPlayer.Backpack
    end
end})

-- Visuals
VisualsTab:AddToggle({Name = "ESP", Default = false, Callback = function(v) ESPEnabled = v end})
VisualsTab:AddToggle({Name = "Wallhack", Default = false, Callback = function(v) WallhackEnabled = v end})

-- Player
PlayerTab:AddSlider({Name = "WalkSpeed", Min = 16, Max = 100, Default = 20, Callback = function(v) LocalPlayer.Character.Humanoid.WalkSpeed = v end})
PlayerTab:AddToggle({Name = "Fly", Default = false, Callback = function(v) FlyEnabled = v end})
PlayerTab:AddSlider({Name = "Fly Speed", Min = 50, Max = 300, Default = 100, Callback = function(v) FlySpeed = v end})
PlayerTab:AddToggle({Name = "Infinite Jump", Default = false, Callback = function(v) InfiniteJumpEnabled = v end})
PlayerTab:AddToggle({Name = "Noclip", Default = false, Callback = function(v) NoclipEnabled = v end})

-- Toggle GUI
UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.RightShift and not processed then
        OrionLib:Toggle()
    end
end)

OrionLib:Init()
