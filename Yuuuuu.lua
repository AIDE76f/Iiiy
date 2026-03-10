-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- STATES
local AutoCollect=false
local WoodMode="Upgrade" -- Upgrade / Storage / Balanced

-- GUI
local gui=Instance.new("ScreenGui",game.CoreGui)

local main=Instance.new("Frame",gui)
main.Size=UDim2.new(0,260,0,230)
main.Position=UDim2.new(0,20,0,20)
main.BackgroundColor3=Color3.fromRGB(25,25,25)
main.Active=true
main.Draggable=true
Instance.new("UICorner",main)

local title=Instance.new("TextLabel",main)
title.Size=UDim2.new(1,0,0,30)
title.Text="Raft Survival Hub"
title.BackgroundTransparency=1
title.TextColor3=Color3.new(1,1,1)
title.Font=Enum.Font.GothamBold

-- OPEN BUTTON
local open=Instance.new("TextButton",gui)
open.Size=UDim2.new(0,70,0,35)
open.Position=UDim2.new(0,20,0,20)
open.Text="OPEN"
open.Visible=false

local hide=Instance.new("TextButton",main)
hide.Size=UDim2.new(0,40,0,25)
hide.Position=UDim2.new(1,-50,0,3)
hide.Text="-"

hide.MouseButton1Click:Connect(function()
main.Visible=false
open.Visible=true
end)

open.MouseButton1Click:Connect(function()
main.Visible=true
open.Visible=false
end)

-- TOGGLE
local function Toggle(text,y,callback)

local btn=Instance.new("TextButton",main)
btn.Size=UDim2.new(0,200,0,35)
btn.Position=UDim2.new(0,20,0,y)
btn.Text=text
btn.BackgroundColor3=Color3.fromRGB(40,40,40)

local state=false

local indicator=Instance.new("Frame",btn)
indicator.Size=UDim2.new(0,15,0,15)
indicator.Position=UDim2.new(1,-20,0.5,-7)
indicator.BackgroundColor3=Color3.fromRGB(200,0,0)
Instance.new("UICorner",indicator)

btn.MouseButton1Click:Connect(function()

state=not state

indicator.BackgroundColor3=
state and Color3.fromRGB(0,200,0)
or Color3.fromRGB(200,0,0)

callback(state)

end)

end

-- WOOD MODE BUTTON
local modeBtn=Instance.new("TextButton",main)
modeBtn.Size=UDim2.new(0,200,0,35)
modeBtn.Position=UDim2.new(0,20,0,120)
modeBtn.Text="Wood Mode: Upgrade"

modeBtn.MouseButton1Click:Connect(function()

if WoodMode=="Upgrade" then
WoodMode="Storage"

elseif WoodMode=="Storage" then
WoodMode="Balanced"

else
WoodMode="Upgrade"
end

modeBtn.Text="Wood Mode: "..WoodMode

end)

-- AUTO COLLECT
Toggle("Auto Collect",60,function(v)
AutoCollect=v
end)

-- COLLECT SYSTEM
task.spawn(function()

while true do
task.wait(0.15)

if AutoCollect then

for _,v in pairs(workspace:GetDescendants()) do

if v:IsA("Part") then

local n=v.Name:lower()

if string.find(n,"wood")
or string.find(n,"plank")
or string.find(n,"scrap")
or string.find(n,"leaf") then

v.CFrame=root.CFrame

-- wood logic
if string.find(n,"wood") then

if WoodMode=="Upgrade" then
print("Send wood to boat upgrade")

elseif WoodMode=="Storage" then
print("Send wood to crafting storage")

elseif WoodMode=="Balanced" then
print("Split between upgrade and storage")

end

end

end

end

end

end

end

end)
