local Library = loadstring(game:HttpGet("https://pastebin.com/raw/vdc16Dh7"))()

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("ImageLabel")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

Frame.Name = "Frame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.Position = UDim2.new(0, 0, 0.65, -100)
Frame.Size = UDim2.new(0, 100, 0, 50)
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(96, 100, 199)
Frame.ImageTransparency = 0.200
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.120
Frame.Active = true
Frame.ZIndex = 10

TextButton.Parent = Frame
TextButton.AnchorPoint = Vector2.new(0, 0.5)
TextButton.BackgroundColor3 = Color3.fromRGB(96, 100, 199)
TextButton.BackgroundTransparency = 1.000
TextButton.Position = UDim2.new(0.022162716, 0, 0.85, -20)
TextButton.Size = UDim2.new(1, -10, 1, 0) 
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "made by bxris"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 20.000
TextButton.TextWrapped = true
TextButton.ZIndex = 11 
TextButton.MouseButton1Down:Connect(function()
    Library:ToggleUI()
end)


local draggingEnabled = false
local dragStartPos = nil
local frameStartPos = nil

local function updatePosition(input)
    local delta = input.Position - dragStartPos
    Frame.Position = UDim2.new(
        frameStartPos.X.Scale,
        frameStartPos.X.Offset + delta.X,
        frameStartPos.Y.Scale,
        frameStartPos.Y.Offset + delta.Y
    )
end

TextButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingEnabled = true
        dragStartPos = input.Position
        frameStartPos = Frame.Position
    end
end)

TextButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingEnabled = false
    end
end)

TextButton.InputChanged:Connect(function(input)
    if draggingEnabled and
        (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updatePosition(input)
    end
end)

Frame.InputChanged:Connect(function(input)
    if draggingEnabled and
        (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updatePosition(input)
    end
end) 

local Window = Library.CreateLib("Luminex FE", "Ocean")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Main")

Section:NewSlider("Speed", "Change your character's speed.", 500, 0, function(L)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = L
end)
Section:NewButton("Hitbox Expander", "Increases your hitbox to make killing easier.", function()
    G.HeadSize = 40
_G.Disabled = true
 
game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.6
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Cyan")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)
Section:NewButton("ESP", "See other hidden players, Only shows the name and distance.", function()
    MobEsp = false
MobLocations = {game:GetService("Workspace")}
MobNames = {""}

PlayerESP = true

plr = game.Players.LocalPlayer
_G.on = true

names = {}
function isin(obj,tbl)
	for a = 1,#tbl do
		if obj == tbl[a] then
			return true
		end
	end
	return false
end
function test1(D)
	local d = tonumber(string.sub(D,1,string.find(D,".",1,true) + 1))
	return d
end
function Label(Part,Distance)
	local MainName = Part.Parent.Name
	local check = Part:FindFirstChild(MainName .. " Tracker")
	if check then
		destroyed = false
		while not destroyed do
			for i = 1,#names do
				if names[i] == MainName then
					table.remove(names,i)
					destroyed = true
					break
				end
			end
			destroyed = true
		end
		check:Destroy()
	end
	local Gui = Instance.new("BillboardGui")
	local Text = Instance.new("TextLabel")
	if Distance ~= nil then
		local assa,D = pcall(test1,Distance)
		if D ~= nil and D then
			D = tonumber(D)
			table.insert(names,MainName)
			Gui.Name = MainName.." Tracker"
			Gui.Parent = Part
			Gui.Adornee = Part
			Gui.ExtentsOffsetWorldSpace = Vector3.new(0,3,0)
			Gui.MaxDistance = 2500
			Gui.Size = UDim2.new(0,200,0,50)
			Gui.AlwaysOnTop = true
			Text.Parent = Gui
			Text.TextWrapped = true
			Text.BackgroundTransparency = 1
			Text.TextSize = 8
			Text.Size = UDim2.new(0, 200, 0, 50)
			Text.Font = Enum.Font.Legacy
			if D ~= nil and D < 30 then
				Text.TextColor3 = Color3.fromRGB(33, 231, 40)
				Text.Text = Part.Parent.Name .. "\n Dist: " .. D
			elseif D ~= nil and D < 100 then
				Text.TextColor3 = Color3.fromRGB(228, 231, 34)
				Text.Text = Part.Parent.Name .. "\n Dist: " .. D
			elseif D ~= nil and D < 500 then
				Text.TextColor3 = Color3.fromRGB(255, 140, 46)
				Text.Text = Part.Parent.Name .. "\n Dist: " .. D
			elseif D ~= nil and D < 2500 then
				Text.TextColor3 = Color3.fromRGB(255, 0, 0)
				Text.Text = Part.Parent.Name .. "\n Dist: " .. D
			end
		end
	end
end

function Root()
	plr = game.Players:FindFirstChild(game.Players.LocalPlayer.Name)
	if plr then
		local root = plr.Character:FindFirstChild("HumanoidRootPart")
		if root then
			return root
		else
			for i = 1,#names do
				local check = game.Workspace:FindFirstChild(names[i] .. " Tracker",true)
				if check then
					table.remove(names,i)
					check:Destroy()
					break
				end
			end
			game:GetService('RunService').Stepped:wait()
			Root()
		end
	end
end

while _G.on do
	game:GetService('RunService').Stepped:wait()
	plr = game.Players.LocalPlayer
	if MobEsp then
		for iter = 1,#MobLocations do
			local check = MobLocations[iter]:FindFirstChildOfClass("Model")
			local check2 = MobLocations[iter]:FindFirstChildOfClass("Part")
			if check or check2 then
				for i,v in pairs(MobLocations[iter]:GetChildren()) do
					if v.ClassName == "Model" or v.ClassName == "Part" and isin(v.Name,MobNames) == true then
						local placed = false
						for a,b in pairs(v:GetChildren()) do
							if b.Name == "Head" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
								placed = true
								Label(b,(Root().Position - b.Position).Magnitude)
							elseif b.Name == "UpperTorso" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
								placed = true
								Label(b,(Root().Position - b.Position).Magnitude)
							elseif b.Name == "Torso" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
								placed = true
								Label(b,(Root().Position - b.Position).Magnitude)
							elseif b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
								placed = true
								repeat wait() until game.Players.LocalPlayer.Character ~= nil
								Label(b,(Root().Position - b.Position).Magnitude)
							end
						end
					end
				end
			end
		end
	end
	if PlayerESP then
		for z,d in pairs(game.Players:GetChildren()) do
			if d.Character ~= nil and d ~= plr then
				local prt = d.Character:FindFirstChildOfClass("Part")
				if prt then
					local placed = false
					for j,g in pairs(d.Character:GetChildren()) do
						if g.Name == "Head" and not placed then
							placed = true
							Label(g,(Root().Position - g.Position).Magnitude)
						elseif g.Name == "UpperTorso" and not placed then
							placed = true
							Label(g,(Root().Position - g.Position).Magnitude)
						elseif g.Name == "Torso" and not placed then
							placed = true
							Label(g,(Root().Position - g.Position).Magnitude)
						end
					end
				end
			end
		end
	end
end
while #names > 0 do
	game:GetService('RunService').Stepped:wait()
	for i = 1,#names do
		local check = game.Workspace:FindFirstChild(names[i] .. " Tracker",true)
		if check then
			table.remove(names,i)
			check:Destroy()
		end
	end
end
end)
local Tab = Window:NewTab("Project XL")
local Section = Tab:NewSection("Project XL")
Section:NewButton("Tora Script", "An Project XL Script.", function()
 loadstring(game:HttpGet('https://raw.githubusercontent.com/ToraScript/Script/main/ProjectXL'))()
