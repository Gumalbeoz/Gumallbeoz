-- NEXT HUB (UI ONLY - CLIENT)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.3, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main)

local stroke = Instance.new("UIStroke", Main)
stroke.Thickness = 3

task.spawn(function()
	while true do
		for i = 0,1,0.01 do
			stroke.Color = Color3.fromHSV(i,1,1)
			task.wait(0.02)
		end
	end
end)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "Next Hub"
Title.BackgroundColor3 = Color3.fromRGB(30,30,30)
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local dragging, dragStart, startPos
Title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0,0,0,40)
TabBar.Size = UDim2.new(1,0,0,40)
TabBar.BackgroundColor3 = Color3.fromRGB(25,25,25)

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0,0,0,80)
Content.Size = UDim2.new(1,0,1,-80)
Content.BackgroundTransparency = 1

local tabs = {}
local buttons = {}

local function createTab(name, pos)
	local btn = Instance.new("TextButton", TabBar)
	btn.Size = UDim2.new(0,120,1,0)
	btn.Position = UDim2.new(0,pos,0,0)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	btn.TextColor3 = Color3.new(1,1,1)

	local page = Instance.new("Frame", Content)
	page.Size = UDim2.new(1,0,1,0)
	page.BackgroundColor3 = Color3.fromRGB(25,25,25)
	page.Visible = false

	tabs[name] = page
	buttons[name] = btn
end

createTab("Main",0)
createTab("Farm",120)
createTab("Teleport",240)
createTab("Misc",360)

local currentTab
local function switchTab(name)
	local newTab = tabs[name]
	if not newTab then return end

	if currentTab then
		currentTab.Visible = false
	end

	newTab.Visible = true
	currentTab = newTab
end

for name,btn in pairs(buttons) do
	btn.MouseButton1Click:Connect(function()
		switchTab(name)
	end)
end

switchTab("Main")

print("Next Hub UI Loaded")
