for i,v in pairs (game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "pa1nhub" then
        v:Destroy()
    end
end

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xpa1n/library/main/CustomVepLibrary.lua"))()

local s = VLib:Window("pa1n Scripts", "Dragon Ball Rage", "")

local ss = s:Tab("Auto Farm")
ss:Label("Auto Train")

ss:Toggle("Auto Train Attack",function(t)
getgenv().ta = t;

while wait() and getgenv().ta == true do
    local button = game:service'VirtualInputManager'
    
    button:SendKeyEvent(true, "E", false, game)
    wait()
end
end)
    

ss:Toggle("Auto Train Defense",function(t)
getgenv().td = t;

while wait() and getgenv().td == true do
    local button = game:service'VirtualInputManager'
    
    button:SendKeyEvent(true, "R", false, game)
    wait()
end
    
end)

ss:Toggle("Auto Train Ki",function(t)
getgenv().tk = t;

while wait() and getgenv().tk == true do
    local button = game:service'VirtualInputManager'
    
    button:SendKeyEvent(true, "Q", false, game)
    wait()
end
    
end)

ss:Label("Infinite Energy")

ss:Textbox("Reset Timer (press enter)", true,function(t)
getgenv().timer = t;
end)

ss:Toggle("Auto Reset / Infinite Energy",function(t)
getgenv().ie = t;

while wait() and getgenv().ie == true do
    game:GetService("Players").LocalPlayer.Character.Humanoid.Health=0
    wait(getgenv().timer)
end
    
end)

ss:Label("Farm With Tool")

ss:Toggle("Auto Equip Tool",function(t)
getgenv().eqtool = t;

while getgenv().eqtool and wait() do
local backpack = game:GetService("Players").LocalPlayer.Backpack
for i, a in pairs(backpack:GetChildren()) do 
if a:IsA("Tool") then
    getgenv().tool = a.Name
  end
end
local Plr = game:GetService("Players").LocalPlayer
pcall(function()
if Plr.Backpack:FindFirstChild(getgenv().tool) and Plr.Character:FindFirstChild(getgenv().tool) == nil then
local tol = Plr.Backpack:FindFirstChild(getgenv().tool)
Plr.Character.Humanoid:EquipTool(tol)
end
end)
end 
end)

ss:Toggle("Auto M1",function(t)
getgenv().m1 = t;

while wait() and getgenv().m1 == true do
local user = game:GetService("VirtualUser")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
user:CaptureController()
user:ClickButton1(Vector2.new(mouse.x,mouse.y))
end
    
end)

ss:Label("Transform")

ss:Button("Quick Transform",function()
local button = game:service'VirtualInputManager'
button:SendKeyEvent(true, "V", false, game)
end)

ss:Button("Long Transform",function()
local button = game:service'VirtualInputManager'
button:SendKeyEvent(true, "B", false, game)
end)

local sx = s:Tab("Teleport")

sx:Label("NPC Teleport")

sx:Button("Dracius",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Quests.iDracius.Head.CFrame
end)

sx:Button("Krillin",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Quests.Krillin.Head.CFrame
end)

sx:Button("Goku",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.bossSpawns.Goku.CFrame
end)

sx:Button("SaibaMan",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.bossSpawns.Saibamen.Part.CFrame
end)

sx:Label("-- Island Teleport --")

sx:Button("Mountains",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.Mountains.Grass.Grass.CFrame
end)

sx:Button("IceIsland",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.IceIsland.Part.CFrame
end)

sx:Button("DesertWoods",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.DesertWoods.Desert.BaseSand.Union.CFrame
end)

sx:Button("Tournament",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.Tournament.GrassBase.CFrame
end)

sx:Button("Volcano",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.Volcano.Volcano.Union.CFrame
end)

sx:Button("TropicalIsland",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.TropicalIsland.Pebble.CFrame
end)

sx:Button("LargeIsland",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.LargeIsland.Parts.Forest.Ground.Grass.CFrame
end)

sx:Button("Winter",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.Winter.Part.CFrame
end)

sx:Button("Plains",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.Plains.Base.CFrame
end)

sx:Button("Forest",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.Forest.Base.Grass.CFrame
end)

sx:Button("Desert",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Islands.Desert.Base.CFrame
end)

local sy = s:Tab("Mob Farm")

sy:Toggle("Auto Train Ki",function(t)
getgenv().tk = t;

while wait() and getgenv().tk == true do
    local button = game:service'VirtualInputManager'
    
    button:SendKeyEvent(true, "Q", false, game)
    wait()
end
    
end)
