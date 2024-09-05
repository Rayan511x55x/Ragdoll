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
            if not isWhitelisted(speaker) then
                chat("You do not have permission to execute this command.")
                return
            end
            
            local targetPlayer = game.Players:FindFirstChild(args[2])
            if targetPlayer then
                targetPlayer:Kick("You have been kicked by " .. speaker)
                chat(targetPlayer.DisplayName .. " has been kicked.")
            else
                chat("Player not found.")
            end
        end,
    },
    follow = {
        Name = "follow",
        Use = "Makes the bot follow a specified player.",
        CommandFunction = function(args, speaker)
            if not isWhitelisted(speaker) then
                chat("You do not have permission to execute this command.")
                return
            end
            
            local playerToFollow = args[2] and game.Players:FindFirstChild(args[2]) or nil
            if playerToFollow then
                follow(playerToFollow)
                chat("Now following " .. playerToFollow.DisplayName .. ".")
                followplr = playerToFollow
            else
                chat("Player not found.")
            end
        end,
    },
    freeze = {
        Name = "freeze",
        Use = "Freezes a specified player in place.",
        CommandFunction = function(args, speaker)
            if not isWhitelisted(speaker) then
                chat("You do not have permission to execute this command.")
                return
            end
            
            local targetPlayer = game.Players:FindFirstChild(args[2])
            if targetPlayer then
                -- Implementing freeze logic such as preventing the player from moving
                targetPlayer.Character.HumanoidRootPart.Anchored = true
                chat(targetPlayer.DisplayName .. " has been frozen.")
            else
                chat("Player not found.")
            end
        end,
    },
    say = {
        Name = "say",
        Use = "Sends a message in chat.",
        CommandFunction = function(args, speaker)
            if not isWhitelisted(speaker) then
                chat("You do not have permission to execute this command.")
                return
            end

            local message = table.concat(args, " ", 2) -- Join arguments as message
            chat(message)
        end,
    },
}

-- Command execution function
local function onCommandReceived(data)
    local message = data.Text
    local speakerPlayer = game.Players:GetPlayerByUserId(data.TextSource.UserId)
    local speaker = speakerPlayer.Name

    if not speakerPlayer then return end

    if string.sub(message, 1, 1) == prefix then
        local args = string.split(string.sub(message, 2), " ") -- Remove prefix
        local cmdName = args[1]
        local command = commands[cmdName]

        if command and command.CommandFunction then
            command.CommandFunction(args, speaker)
        else
            chat("Command not found.")
        end
    end
end

game.TextChatService.TextChannels.RBXGeneral.MessageReceived:Connect(onCommandReceived)

-- Optional: Status update for loading
chat("LunarBot is loaded! Use " .. prefix .. "say <message>, " .. prefix .. "kick <player>, " .. prefix .. "follow <player>, " .. prefix .. "freeze <player>.")