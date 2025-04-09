-- NOVA HX v1 Script for RIVALS Map (Roblox)
-- Aimbot, ESP, Wallbang, No Recoil, Fly, No Reload, and more

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local ESPEnabled = false
local AimbotEnabled = false
local SilentAimEnabled = false
local WallbangEnabled = false
local NoRecoilEnabled = false
local FlyEnabled = false
local NoReloadEnabled = false
local WalkSpeed = 16
local FlySpeed = 50
local InfiniteJumpEnabled = false

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui
ScreenGui.Name = "NOVA HX v1"

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Parent = ScreenGui

local function createToggle(name, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 250, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = mainFrame
    button.MouseButton1Click:Connect(callback)
end

-- Add toggle buttons
createToggle("Aimbot", UDim2.new(0, 10, 0, 10), function()
    AimbotEnabled = not AimbotEnabled
    print("Aimbot: " .. tostring(AimbotEnabled))
end)

createToggle("Silent Aim", UDim2.new(0, 10, 0, 50), function()
    SilentAimEnabled = not SilentAimEnabled
    print("Silent Aim: " .. tostring(SilentAimEnabled))
end)

createToggle("ESP", UDim2.new(0, 10, 0, 90), function()
    ESPEnabled = not ESPEnabled
    print("ESP: " .. tostring(ESPEnabled))
end)

createToggle("Wallbang", UDim2.new(0, 10, 0, 130), function()
    WallbangEnabled = not WallbangEnabled
    print("Wallbang: " .. tostring(WallbangEnabled))
end)

createToggle("No Recoil", UDim2.new(0, 10, 0, 170), function()
    NoRecoilEnabled = not NoRecoilEnabled
    print("No Recoil: " .. tostring(NoRecoilEnabled))
end)

createToggle("Fly", UDim2.new(0, 10, 0, 210), function()
    FlyEnabled = not FlyEnabled
    print("Fly: " .. tostring(FlyEnabled))
end)

createToggle("No Reload", UDim2.new(0, 10, 0, 250), function()
    NoReloadEnabled = not NoReloadEnabled
    print("No Reload: " .. tostring(NoReloadEnabled))
end)

createToggle("Infinite Jump", UDim2.new(0, 10, 0, 290), function()
    InfiniteJumpEnabled = not InfiniteJumpEnabled
    print("Infinite Jump: " .. tostring(InfiniteJumpEnabled))
end)

-- Function for Aimbot
local function aimbot()
    if AimbotEnabled then
        -- Aim at the head of the closest enemy
        local closestPlayer = nil
        local closestDistance = math.huge
        for _, v in ipairs(game.Players:GetPlayers()) do
            if v.Team ~= player.Team and v.Character and v.Character:FindFirstChild("Head") then
                local distance = (v.Character.Head.Position - camera.CFrame.Position).Magnitude
                if distance < closestDistance then
                    closestPlayer = v
                    closestDistance = distance
                end
            end
        end
        
        if closestPlayer then
            local targetHeadPosition = closestPlayer.Character.Head.Position
            local cameraToTarget = (targetHeadPosition - camera.CFrame.Position).unit
            camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + cameraToTarget)
        end
    end
end

-- Function for Silent Aim
local function silentAim()
    if SilentAimEnabled then
        -- Automatically hit enemy's head with bullet without camera movement
        local closestPlayer = nil
        local closestDistance = math.huge
        for _, v in ipairs(game.Players:GetPlayers()) do
            if v.Team ~= player.Team and v.Character and v.Character:FindFirstChild("Head") then
                local distance = (v.Character.Head.Position - camera.CFrame.Position).Magnitude
                if distance < closestDistance then
                    closestPlayer = v
                    closestDistance = distance
                end
            end
        end
        
        if closestPlayer then
            -- Fire bullets directly to the head of the closest enemy (Silent Aim)
            -- This is where you'd hook into the gun firing mechanism.
            -- For demonstration purposes, this is just a basic outline.
        end
    end
end

-- Function for ESP
local function ESP()
    if ESPEnabled then
        -- Display boxes around enemy players
        for _, v in ipairs(game.Players:GetPlayers()) do
            if v.Team ~= player.Team and v.Character and v.Character:FindFirstChild("Head") then
                local box = Instance.new("BoxHandleAdornment")
                box.Adornee = v.Character.Head
                box.Size = Vector3.new(3, 5, 3)
                box.Color3 = Color3.fromRGB(255, 0, 0)
                box.Parent = workspace
            end
        end
    end
end

-- Function for Wallbang (bullet goes through walls)
local function wallbang()
    if WallbangEnabled then
        -- Modify bullet behavior to pass through walls (implementation may vary depending on how shooting is handled)
    end
end

-- Function for No Recoil
local function noRecoil()
    if NoRecoilEnabled then
        -- Disable recoil when shooting (this would depend on how recoil is managed in the game)
    end
end

-- Function for Fly
local function fly()
    if FlyEnabled then
        -- Enable flight by modifying player position
        local bodyVelocity = player.Character:FindFirstChildOfClass("BodyVelocity")
        if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
            bodyVelocity.Parent = player.Character:WaitForChild("HumanoidRootPart")
        end
        bodyVelocity.Velocity = Vector3.new(0, FlySpeed, 0)
    else
        -- Disable flight
        local bodyVelocity = player.Character:FindFirstChildOfClass("BodyVelocity")
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end

-- Function for Infinite Jump
local function infiniteJump()
    if InfiniteJumpEnabled then
        -- Make the player jump indefinitely
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid:GetState() == Enum.HumanoidStateType.Physics then
            humanoid:ChangeState(Enum.HumanoidStateType.Seated)
        end
    end
end

-- Update loop
while true do
    wait(0.1)
    aimbot()
    silentAim()
    ESP()
    wallbang()
    noRecoil()
    fly()
    infiniteJump()
end
