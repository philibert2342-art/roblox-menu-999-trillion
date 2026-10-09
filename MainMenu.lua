-- ========================================
-- ROBLOX MOD MENU + ADMIN PANEL
-- ========================================
-- Appuyez sur M pour ouvrir/fermer le menu
-- ========================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local menuOpen = false
local adminOpen = false
local invisibleMode = false
local botEnabled = false

-- ========================================
-- CRÉATION DE L'INTERFACE
-- ========================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobloxModMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local darkBackground = Instance.new("Frame")
darkBackground.Name = "DarkBackground"
darkBackground.Size = UDim2.new(1, 0, 1, 0)
darkBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
darkBackground.BackgroundTransparency = 0.45
darkBackground.Visible = false
darkBackground.Parent = screenGui

local mainMenu = Instance.new("Frame")
mainMenu.Name = "MainMenu"
mainMenu.Size = UDim2.new(0, 620, 0, 720)
mainMenu.Position = UDim2.new(0.5, -310, 0.5, -360)
mainMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainMenu.BorderSizePixel = 0
mainMenu.Visible = false
mainMenu.Parent = screenGui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 22)
menuCorner.Parent = mainMenu

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(150, 90, 255)
menuStroke.Thickness = 2
menuStroke.Parent = mainMenu

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 90)
titleBar.BackgroundColor3 = Color3.fromRGB(27, 15, 52)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainMenu

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 22)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "ROBLOX MOD MENU"
titleLabel.TextColor3 = Color3.fromRGB(255, 130, 220)
titleLabel.TextSize = 32
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.Parent = titleBar

local moneyFrame = Instance.new("Frame")
moneyFrame.Name = "MoneyFrame"
moneyFrame.Size = UDim2.new(0, 560, 0, 110)
moneyFrame.Position = UDim2.new(0.5, -280, 0, 110)
moneyFrame.BackgroundColor3 = Color3.fromRGB(32, 26, 60)
moneyFrame.BorderSizePixel = 0
moneyFrame.Parent = mainMenu

local moneyCorner = Instance.new("UICorner")
moneyCorner.CornerRadius = UDim.new(0, 16)
moneyCorner.Parent = moneyFrame

local moneyLabel = Instance.new("TextLabel")
moneyLabel.Size = UDim2.new(1, 0, 0, 35)
moneyLabel.BackgroundTransparency = 1
moneyLabel.Position = UDim2.new(0, 0, 0, 12)
moneyLabel.Text = "💰 ROBUX 💰"
moneyLabel.TextColor3 = Color3.fromRGB(255, 210, 90)
moneyLabel.TextSize = 18
moneyLabel.Font = Enum.Font.GothamBold
moneyLabel.Parent = moneyFrame

local moneyValue = Instance.new("TextLabel")
moneyValue.Size = UDim2.new(1, 0, 0, 45)
moneyValue.BackgroundTransparency = 1
moneyValue.Position = UDim2.new(0, 0, 0, 45)
moneyValue.Text = "999 TRILLION"
moneyValue.TextColor3 = Color3.fromRGB(110, 255, 110)
moneyValue.TextSize = 28
moneyValue.Font = Enum.Font.GothamBold
moneyValue.Parent = moneyFrame

-- boutons du menu
local actionButtons = {
	{Text = "ADMIN PANEL", Color = Color3.fromRGB(220, 60, 60), Action = "admin"},
	{Text = "MODE INVISIBLE", Color = Color3.fromRGB(150, 110, 255), Action = "invisible"},
	{Text = "BOT ACTIVÉ", Color = Color3.fromRGB(60, 180, 110), Action = "bot"},
	{Text = "TELEPORT", Color = Color3.fromRGB(80, 150, 255), Action = "teleport"},
	{Text = "PARAMÈTRES", Color = Color3.fromRGB(255, 160, 70), Action = "settings"},
	{Text = "FERMER", Color = Color3.fromRGB(110, 110, 110), Action = "close"},
}

local buttonsFrame = Instance.new("Frame")
buttonsFrame.Size = UDim2.new(0, 560, 0, 380)
buttonsFrame.Position = UDim2.new(0.5, -280, 0, 240)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = mainMenu

for i, btnInfo in ipairs(actionButtons) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 53)
	button.Position = UDim2.new(0, 0, 0, (i - 1) * 60)
	button.BackgroundColor3 = btnInfo.Color
	button.Text = btnInfo.Text
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 18
	button.Font = Enum.Font.GothamBold
	button.BorderSizePixel = 0
	button.Parent = buttonsFrame

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 12)
	buttonCorner.Parent = button

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(
			math.clamp(btnInfo.Color.R + 0.08, 0, 1),
			math.clamp(btnInfo.Color.G + 0.08, 0, 1),
			math.clamp(btnInfo.Color.B + 0.08, 0, 1)
		)
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = btnInfo.Color
	end)

	button.MouseButton1Click:Connect(function()
		if btnInfo.Action == "admin" then
			toggleAdminPanel()
		elseif btnInfo.Action == "invisible" then
			toggleInvisible()
		elseif btnInfo.Action == "bot" then
			toggleBot()
		elseif btnInfo.Action == "teleport" then
			teleportToRandomPlayer()
		elseif btnInfo.Action == "settings" then
			print("Paramètres ouverts")
		elseif btnInfo.Action == "close" then
			closeMenu()
		end
	end)
end

local bottomStatus = Instance.new("Frame")
bottomStatus.Name = "BottomStatus"
bottomStatus.Size = UDim2.new(1, 0, 0, 42)
bottomStatus.Position = UDim2.new(0, 0, 1, -42)
bottomStatus.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
bottomStatus.BorderSizePixel = 0
bottomStatus.Parent = mainMenu

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 18)
statusCorner.Parent = bottomStatus

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "Status: Invisible OFF | Bot OFF"
statusText.TextColor3 = Color3.fromRGB(110, 255, 110)
statusText.TextSize = 14
statusText.Font = Enum.Font.Gotham
statusText.Parent = bottomStatus

-- ========================================
-- ADMIN PANEL
-- ========================================

local adminPanel = Instance.new("Frame")
adminPanel.Name = "AdminPanel"
adminPanel.Size = UDim2.new(0, 680, 0, 520)
adminPanel.Position = UDim2.new(0.5, -340, 0.5, -260)
adminPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
adminPanel.BorderSizePixel = 0
adminPanel.Visible = false
adminPanel.Parent = screenGui

local adminCorner = Instance.new("UICorner")
adminCorner.CornerRadius = UDim.new(0, 18)
adminCorner.Parent = adminPanel

local adminTitle = Instance.new("TextLabel")
adminTitle.Size = UDim2.new(1, 0, 0, 60)
adminTitle.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
adminTitle.Text = "ADMIN PANEL"
adminTitle.TextColor3 = Color3.fromRGB(255, 100, 150)
adminTitle.TextSize = 28
adminTitle.Font = Enum.Font.GothamBlack
adminTitle.Parent = adminPanel

local adminClose = Instance.new("TextButton")
adminClose.Size = UDim2.new(0, 110, 0, 38)
adminClose.Position = UDim2.new(1, -120, 0, 12)
adminClose.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
adminClose.Text = "FERMER"
adminClose.TextColor3 = Color3.fromRGB(255, 255, 255)
adminClose.TextSize = 16
adminClose.Font = Enum.Font.GothamBold
adminClose.BorderSizePixel = 0
adminClose.Parent = adminTitle

local adminCloseCorner = Instance.new("UICorner")
adminCloseCorner.CornerRadius = UDim.new(0, 10)
adminCloseCorner.Parent = adminClose

adminClose.MouseButton1Click:Connect(function()
	toggleAdminPanel(false)
end)

local listFrame = Instance.new("ScrollingFrame")
listFrame.Size = UDim2.new(0, 270, 0, 360)
listFrame.Position = UDim2.new(0, 20, 0, 90)
listFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
listFrame.BorderSizePixel = 0
listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
listFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
listFrame.ScrollBarThickness = 6
listFrame.Parent = adminPanel

local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 14)
listCorner.Parent = listFrame

local actionFrame = Instance.new("Frame")
actionFrame.Size = UDim2.new(0, 330, 0, 360)
actionFrame.Position = UDim2.new(0, 320, 0, 90)
actionFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
actionFrame.BorderSizePixel = 0
actionFrame.Parent = adminPanel

local actionCorner = Instance.new("UICorner")
actionCorner.CornerRadius = UDim.new(0, 14)
actionCorner.Parent = actionFrame

local buttonsAdmin = {
	{Text = "KICK", Color = Color3.fromRGB(220, 40, 40), Action = "kick"},
	{Text = "BAN", Color = Color3.fromRGB(255, 120, 20), Action = "ban"},
	{Text = "TP", Color = Color3.fromRGB(100, 150, 255), Action = "tp"},
	{Text = "GIVE 999T", Color = Color3.fromRGB(55, 200, 110), Action = "money"},
	{Text = "INVISIBLE", Color = Color3.fromRGB(180, 100, 255), Action = "invisible"},
}

for i, info in ipairs(buttonsAdmin) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 55)
	btn.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 65)
	btn.BackgroundColor3 = info.Color
	btn.Text = info.Text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 18
	btn.Font = Enum.Font.GothamBold
	btn.BorderSizePixel = 0
	btn.Parent = actionFrame

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 12)
	btnCorner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		local selectedPlayer = getSelectedPlayer()
		if not selectedPlayer then
			print("Aucun joueur sélectionné")
			return
		end

		if info.Action == "kick" then
			print("KICK : " .. selectedPlayer.Name)
		elseif info.Action == "ban" then
			print("BAN : " .. selectedPlayer.Name)
		elseif info.Action == "tp" then
			teleportToPlayer(selectedPlayer)
		elseif info.Action == "money" then
			print("GIVE 999T à : " .. selectedPlayer.Name)
		elseif info.Action == "invisible" then
			toggleInvisible()
		end
	end)
end

local selectedLabel = Instance.new("TextLabel")
selectedLabel.Size = UDim2.new(1, -20, 0, 30)
selectedLabel.Position = UDim2.new(0, 10, 1, -40)
selectedLabel.BackgroundTransparency = 1
selectedLabel.Text = "Joueur sélectionné: Aucun"
selectedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
selectedLabel.TextSize = 15
selectedLabel.Font = Enum.Font.Gotham
selectedLabel.Parent = actionFrame

-- ========================================
-- FONCTIONS
-- ========================================

local selectedPlayerName = nil

local function refreshPlayerList()
	for _, child in ipairs(listFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local allPlayers = Players:GetPlayers()
	for i, p in ipairs(allPlayers) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -10, 0, 40)
		btn.Position = UDim2.new(0, 5, 0, (i - 1) * 45)
		btn.BackgroundColor3 = (p == player) and Color3.fromRGB(50, 100, 180) or Color3.fromRGB(60, 60, 70)
		btn.Text = p.Name
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 16
		btn.Font = Enum.Font.GothamBold
		btn.BorderSizePixel = 0
		btn.Parent = listFrame

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 10)
		btnCorner.Parent = btn

		btn.MouseButton1Click:Connect(function()
			selectedPlayerName = p.Name
			selectedLabel.Text = "Joueur sélectionné: " .. p.Name
		end)
	end
end

function getSelectedPlayer()
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name == selectedPlayerName then
			return p
		end
	end
	return nil
end

function toggleAdminPanel(forceState)
	if forceState ~= nil then
		adminOpen = forceState
	else
		adminOpen = not adminOpen
	end
	adminPanel.Visible = adminOpen
	refreshPlayerList()
end

function toggleInvisible()
	invisibleMode = not invisibleMode
	local char = player.Character or player.CharacterAdded:Wait()

	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = invisibleMode and 1 or 0
		end
	end

	statusText.Text = "Status: Invisible " .. (invisibleMode and "ON" or "OFF") .. " | Bot " .. (botEnabled and "ON" or "OFF")
end

function toggleBot()
	botEnabled = not botEnabled
	statusText.Text = "Status: Invisible " .. (invisibleMode and "ON" or "OFF") .. " | Bot " .. (botEnabled and "ON" or "OFF")
	print(botEnabled and "🤖 Bot activé" or "🤖 Bot désactivé")
end

function teleportToRandomPlayer()
	local players = Players:GetPlayers()
	if #players <= 1 then
		print("Pas assez de joueurs")
		return
	end

	local target = players[math.random(1, #players)]
	if target ~= player then
		local root = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
		if root then
			player.Character:PivotTo(root.CFrame + Vector3.new(0, 3, 0))
			print("Téléporté vers " .. target.Name)
		end
	end
end

function teleportToPlayer(targetPlayer)
	if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local root = targetPlayer.Character.HumanoidRootPart
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = root.CFrame + Vector3.new(0, 3, 0)
			print("Téléporté jusqu'à " .. targetPlayer.Name)
		end
	end
end

function closeMenu()
	menuOpen = false
	mainMenu.Visible = false
darkBackground.Visible = false
end

-- ========================================
-- OUVERTURE AVEC M
-- ========================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.M then
		menuOpen = not menuOpen
		mainMenu.Visible = menuOpen
		darkBackground.Visible = menuOpen
	end
end)

-- refresh au démarrage
refreshPlayerList()
print("✅ Menu Roblox + Admin Panel chargé. Appuie sur M pour ouvrir.")
