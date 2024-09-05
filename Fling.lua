local bot = game.Players.LocalPlayer
local whitelistedUsers = { bot.Name, "im8hr" } -- Whitelist includes local player's name and 'im8hr'
local prefix = "!" -- Set command prefix
local followplr = nil -- Variable to store the player to follow

-- Function to check if a player is whitelisted
local function isWhitelisted(playerName)
    return table.find(whitelistedUsers, playerName) ~= nil
end

-- Function to send messages in chat
local function chat(msg)
    game.TextChatService.TextChannels.RBXGeneral:SendAsync("[LunarBot]: " .. msg)
end

-- Function to follow a player
local function follow(player)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        bot.Character:MoveTo(player.Character.HumanoidRootPart.Position)
    end
end

-- Define commands
local commands = {
    kick = {
        Name = "kick",
        Use = "Kicks a specified player from the game.",
        CommandFunction = function(args, speaker)
            local targetPlayer = game.Players:FindFirstChild(args[2])
            if targetPlayer then
                targetPlayer:Kick("You have been kicked by " .. speaker)
            end
        end,
    },
    follow = {
        Name = "follow",
        Use = "Makes the bot follow a specified player.",
        CommandFunction = function(args, speaker)
            local playerToFollow = args[2] and game.Players:FindFirstChild(args[2]) or nil
            if playerToFollow then
                follow(playerToFollow)
                followplr = playerToFollow
            end
        end,
    },
    freeze = {
        Name = "freeze",
        Use = "Freezes a specified player in place.",
        CommandFunction = function(args, speaker)
            local targetPlayer = game.Players:FindFirstChild(args[2])
            if targetPlayer then
                targetPlayer.Character.HumanoidRootPart.Anchored = true
            end
        end,
    },
    say = {
        Name = "say",
        Use = "Sends a message in chat.",
        CommandFunction = function(args, speaker)
            local message = table.concat(args, " ", 2) -- Join arguments as message
            chat(message)
        end,
    },
    bring = {
        Name = "bring",
        Use = "Brings a specified player to the speaker or all local players if `.` is used.",
        CommandFunction = function(args, speaker)
            local query = args[2]
            if query == "." then
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= bot then -- Optionally exclude the bot itself
                        follow(player)
                    end
                end
            elseif query and string.len(query) >= 3 then
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.Name:lower():sub(1, 3) == query:lower() or player.DisplayName:lower():sub(1, 3) == query:lower() then
                        follow(player)
                    end
                end
            end
        end,
    },
}

-- Command execution function
local function onCommandReceived(data)
    local message = data.Text
    local speakerPlayer = game.Players:GetPlayerByUserId(data.TextSource.UserId)

    if not speakerPlayer then return end

    if string.sub(message, 1, 1) == prefix then
        local args = string.split(string.sub(message, 2), " ") -- Remove prefix
        local cmdName = args[1]
        local command = commands[cmdName]

        if command and command.CommandFunction then
            if isWhitelisted(speakerPlayer.Name) then -- Check whitelist
                command.CommandFunction(args, speakerPlayer.Name)
            end
        end
    end
end

game.TextChatService.TextChannels.RBXGeneral.MessageReceived:Connect(onCommandReceived)