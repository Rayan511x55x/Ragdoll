local Players = game.Players
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Define the list of admin user IDs
local Admins = {
    3861815968, -- iiTheCaliXx
    3743834922, -- LaBeastHk
    2549855342, -- svoirr
}

-- Create or get the RemoteEvent
local CommandEvent = ReplicatedStorage:FindFirstChild('CommandEvent')
if not CommandEvent then
    CommandEvent = Instance.new('RemoteEvent')
    CommandEvent.Name = 'CommandEvent'
    CommandEvent.Parent = ReplicatedStorage
end

local function executeCommand(command)
    local player = Players.LocalPlayer

    if command == 'm!freeze' then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Anchored = true
        end
    elseif command == 'm!unfreeze' or command == 'm!nofreeze' then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Anchored = false
        end
    elseif command == 'm!fling' then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Velocity = Vector3.new(500000, 500000, 500000)
        end
    elseif command == 'm!kill' then
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:Destroy()
        end
    elseif command == 'm!sit' then
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Sit = true
        end
    elseif command == 'm!bug' then
        if player.Character then
            player.Character:Destroy()
        end
    end
end

-- Function to handle incoming chat commands
local function onPlayerChatted(message)
    local player = Players.LocalPlayer

    -- Ensure the command is for this local player
    if not table.find(Admins, player.UserId) then
        return
    end

    -- Split and identify the command
    local SplitCMD = string.split(string.lower(message), ' ')
    local command = SplitCMD[1]

    -- Execute the command locally
    executeCommand(command)

    -- Optionally send command to server for logging or additional handling
    CommandEvent:FireServer(command)
end

-- Connect the chat function
Players.LocalPlayer.Chatted:Connect(onPlayerChatted)
