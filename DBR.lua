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
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1777.05969, 473.427765, -1298.41687, 0.714867771, 1.12815597e-08, 0.699259639, -4.25165467e-08, 1, 2.73319767e-08, -0.699259639, -4.92688557e-08, 0.714867771)
end)

sx:Button("IceIsland",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5326.43506, 515.802002, -1814.30664, -0.0832328424, -3.54851579e-08, 0.996530116, -1.29052165e-08, 1, 3.45308386e-08, -0.996530116, -9.98633709e-09, -0.0832328424)
end)

sx:Button("DesertWoods",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1757.50122, 483.524414, -2056.17627, -0.282744437, -6.5758563e-08, -0.959195256, 1.03300994e-08, 1, -7.16010007e-08, 0.959195256, -3.0153366e-08, -0.282744437)
end)

sx:Button("Tournament",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.821167, 476.926483, -3383.6543, 0.993600667, 2.88275164e-08, 0.112949818, -1.89126173e-08, 1, -8.88529641e-08, -0.112949818, 8.61481908e-08, 0.993600667)
end)

sx:Button("Volcano",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(835.50177, 1028.01685, -5090.11768, 0.289804488, -8.13992762e-10, -0.957085848, -3.88843313e-09, 1, -2.02790407e-09, 0.957085848, 4.30926006e-09, 0.289804488)
end)

sx:Button("TropicalIsland",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1598.57642, 497.986115, -5985.85498, 0.881060839, 1.200572e-08, 0.473003, -1.5312688e-08, 1, 3.1409737e-09, -0.473003, -1.00103366e-08, 0.881060839)
end)

sx:Button("LargeIsland",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2189.00146, 477.380432, 1601.32153, 0.917621791, -4.86310121e-08, 0.397454739, 6.46895444e-08, 1, -2.6995588e-08, -0.397454739, 5.04829067e-08, 0.917621791)
end)

sx:Button("Winter",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3489.85767, 519.313599, -2450.98047, -0.987529278, 1.85139495e-08, -0.157435551, 5.10982145e-09, 1, 8.55451674e-08, 0.157435551, 8.36738892e-08, -0.987529278)
end)

sx:Button("Plains",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-237.824005, 567.189575, 883.082153, 0.658311129, -1.79035814e-10, -0.752745926, -4.09201117e-10, 1, -5.95708927e-10, 0.752745926, 7.00186298e-10, 0.658311129)
end)

sx:Button("Forest",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3535.28784, 527.217773, -4655.09229, 0.223640189, -3.84026784e-08, 0.974671781, 2.41689317e-08, 1, 3.38550201e-08, -0.974671781, 1.59854334e-08, 0.223640189)
end)

sx:Button("Desert",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3399.25708, 644.655884, -233.228531, -0.576870382, 4.96522894e-08, -0.816835701, -1.66418115e-08, 1, 7.25390166e-08, 0.816835701, 5.54392336e-08, -0.576870382)
end)

local sy = s:Tab("Mob Farm")

sy:Label("-- Farm Mobs --")

sy:Toggle("Farm Dummy",function(t)
getgenv().farmd = t;

while wait() and getgenv().farmd do
pcall(function()
for i,v in pairs(game:GetService("Workspace").Map.NPCs:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == 'Dummy' then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
        end
end
end)
end
    
end)

sy:Toggle("Farm Saibamen",function(t)
getgenv().farms = t;

while wait() and getgenv().farms do
pcall(function()
for i,v in pairs(game:GetService("Workspace").Map.NPCs:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == 'Saibamen' then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
        end
end
end)
end
    
end)

sy:Toggle("Farm Goku",function(t)
getgenv().farmg = t;

while wait() and getgenv().farmg do
pcall(function()
for i,v in pairs(game:GetService("Workspace").Map.NPCs:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == 'Goku' then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
        end
end
end)
end
    
end)
local sqwe = s:Tab("Player")
sqwe:Slider("WalkSpeed",16,300,16,function(t)
    _G.ws = t; 
    local plr = game:service'Players'.LocalPlayer;
    plr.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
    plr.Character.Humanoid.WalkSpeed = _G.ws;
    end)
    plr.Character.Humanoid.WalkSpeed = _G.ws; 
end)
sqwe:Slider("JumpPower",60,300,16,function(t)
    _G.jp = t; 
    local plr = game:service'Players'.LocalPlayer;
    plr.Character.Humanoid:GetPropertyChangedSignal'JumpPower':Connect(function()
    plr.Character.Humanoid.JumpPower = _G.jp;
    end)
    plr.Character.Humanoid.JumpPower = _G.jp;
end)



local sc = s:Tab("Credits!")

sc:Label("")
sc:Label("")
sc:Label("Script made by pa1n#8015")
sc:Label("")
sc:Button("Join Discord (Click to Copy)",function()
setclipboard("https://pa1n.xyz/discord")
end)
sc:Label("If you need help or the script is not working let me know in ")
sc:Label("discord")
sc:Label("")
sc:Label("[Press K to Hide/Show This GUI]")
