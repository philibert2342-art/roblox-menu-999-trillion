-- ========================================
-- Menu Principal Roblox - 999 Trillion Robux
-- ========================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables
local menuOpen = false
local isInvisible = false
local botActive = false
local playerMoney = 999000000000000 -- 999 Trillion

-- ========================================
-- CRÉATION DE L'INTERFACE PRINCIPALE
-- ========================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainMenuGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Fond principal (noir semi-transparent)
local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.5
background.Parent = screenGui

-- Panel principal du menu
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 600, 0, 700)
mainPanel.Position = UDim2.new(0.5, -300, 0.5, -350)
mainPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = screenGui

-- Coin arrondi (effet)
local cornerRadius = Instance.new("UICorner")
cornerRadius.CornerRadius = UDim.new(0, 20)
cornerRadius.Parent = mainPanel

-- Ombre du panneau
local shadow = Instance.new("UIStroke")
shadow.Color = Color3.fromRGB(100, 50, 200)
shadow.Thickness = 2
shadow.Parent = mainPanel

-- ========================================
-- TITRE DU MENU
-- ========================================

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 80)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 15, 50)
titleLabel.BorderSizePixel = 0
titleLabel.Text = "🎮 ROBLOX MOD MENU 🎮"
titleLabel.TextColor3 = Color3.fromRGB(255, 100, 200)
titleLabel.TextSize = 35
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainPanel

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = titleLabel

-- ========================================
-- AFFICHAGE DE L'ARGENT
-- ========================================

local moneyPanel = Instance.new("Frame")
moneyPanel.Name = "MoneyPanel"
moneyPanel.Size = UDim2.new(0, 560, 0, 100)
moneyPanel.Position = UDim2.new(0.5, -280, 0, 100)
moneyPanel.BackgroundColor3 = Color3.fromRGB(50, 25, 80)
moneyPanel.BorderSizePixel = 0
moneyPanel.Parent = mainPanel

local moneyCorner = Instance.new("UICorner")
moneyCorner.CornerRadius = UDim.new(0, 15)
moneyCorner.Parent = moneyPanel

local moneyStroke = Instance.new("UIStroke")
moneyStroke.Color = Color3.fromRGB(200, 100, 255)
moneyStroke.Thickness = 2
moneyStroke.Parent = moneyPanel

local moneyLabel = Instance.new("TextLabel")
moneyLabel.Name = "MoneyLabel"
moneyLabel.Size = UDim2.new(1, 0, 0, 35)
moneyLabel.Position = UDim2.new(0, 0, 0, 10)
moneyLabel.BackgroundTransparency = 1
moneyLabel.Text = "💰 ROBUX 💰"
moneyLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
moneyLabel.TextSize = 20
moneyLabel.Font = Enum.Font.GothamBold
moneyLabel.Parent = moneyPanel

local moneyAmount = Instance.new("TextLabel")
moneyAmount.Name = "MoneyAmount"
moneyAmount.Size = UDim2.new(1, 0, 0, 50)
moneyAmount.Position = UDim2.new(0, 0, 0, 40)
moneyAmount.BackgroundTransparency = 1
moneyAmount.Text = "999 TRILLION ROBUX"
moneyAmount.TextColor3 = Color3.fromRGB(100, 255, 100)
moneyAmount.TextSize = 30
moneyAmount.Font = Enum.Font.GothamBold
moneyAmount.Parent = moneyPanel

-- ========================================
-- CONTENEUR DES BOUTONS
-- ========================================

local buttonsContainer = Instance.new("Frame")
buttonsContainer.Name = "ButtonsContainer"
buttonsContainer.Size = UDim2.new(0, 560, 0, 400)
buttonsContainer.Position = UDim2.new(0.5, -280, 0, 220)
buttonsContainer.BackgroundTransparency = 1
buttonsContainer.Parent = mainPanel

-- Liste des boutons
local buttons = {
	{name = "👤 ADMIN PANEL", color = Color3.fromRGB(200, 50, 50), callback = function() print("Admin Panel ouvert") end},
	{name = "👻 MODE INVISIBLE", color = Color3.fromRGB(150, 100, 255), callback = function() toggleInvisible() end},
	{name = "🤖 ACTIVER BOT", color = Color3.fromRGB(50, 200, 100), callback = function() toggleBot() end},
	{name = "📍 TELEPORTER", color = Color3.fromRGB(100, 150, 255), callback = function() print("Teleport actif") end},
	{name = "⚙️ PARAMÈTRES", color = Color3.fromRGB(255, 150, 50), callback = function() print("Paramètres ouverts") end},
	{name = "❌ FERMER MENU", color = Color3.fromRGB(100, 100, 100), callback = function() closeMenu() end},
}

-- Création des boutons
for i, buttonData in ipairs(buttons) do
	local button = Instance.new("TextButton")
	button.Name = "Button_" .. i
	button.Size = UDim2.new(1, 0, 0, 55)
	button.Position = UDim2.new(0, 0, 0, (i - 1) * 65)
	button.BackgroundColor3 = buttonData.color
	button.BorderSizePixel = 0
	button.Text = buttonData.name
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 18
	button.Font = Enum.Font.GothamBold
	button.Parent = buttonsContainer

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 10)
	buttonCorner.Parent = button

	-- Effet au survol
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(
			math.min(buttonData.color.R * 255 + 50, 255) / 255,
			math.min(buttonData.color.G * 255 + 50, 255) / 255,
			math.min(buttonData.color.B * 255 + 50, 255) / 255
		)
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = buttonData.color
	end)

	-- Clique sur le bouton
	button.MouseButton1Click:Connect(function()
		buttonData.callback()
	end)
end

-- ========================================
-- BARRE DE STATUT EN BAS
-- ========================================

local statusBar = Instance.new("Frame")
statusBar.Name = "StatusBar"
statusBar.Size = UDim2.new(1, 0, 0, 40)
statusBar.Position = UDim2.new(0, 0, 1, -40)
statusBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
statusBar.BorderSizePixel = 0
statusBar.Parent = mainPanel

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 20)
statusCorner.Parent = statusBar

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, 0, 1, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Invisible: OFF | Bot: OFF"
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = statusBar

-- ========================================
-- FONCTIONS DU MENU
-- ========================================

function toggleInvisible()
	isInvisible = not isInvisible
	local character = player.Character
	
	if character then
		if isInvisible then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Transparency = 1
				end
			end
			statusLabel.Text = "Status: Invisible: ON | Bot: " .. (botActive and "ON" or "OFF")
		else
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Transparency = 0
				end
			end
			statusLabel.Text = "Status: Invisible: OFF | Bot: " .. (botActive and "ON" or "OFF")
		end
	end
end

function toggleBot()
	botActive = not botActive
	statusLabel.Text = "Status: Invisible: " .. (isInvisible and "ON" or "OFF") .. " | Bot: " .. (botActive and "ON" or "OFF")
	
	if botActive then
		print("🤖 Bot activé!")
		-- Ici tu peux ajouter la logique du bot
	else
		print("🤖 Bot désactivé!")
	end
end

function closeMenu()
	screenGui:Destroy()
	menuOpen = false
end

-- ========================================
-- OUVRIR/FERMER LE MENU AVEC M
-- ========================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.M then
		menuOpen = not menuOpen
		mainPanel.Visible = menuOpen
		background.Visible = menuOpen
	end
end)

print("✅ Menu Roblox chargé! Appuyez sur M pour ouvrir/fermer")
