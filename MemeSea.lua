for i,v in pairs (game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "pa1nhub" then
        v:Destroy()
    end
end

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xpa1n/library/main/CustomVepLibrary.lua"))()

local s = VLib:Window("Best Skrwdipt ", "MEME SEA", "")

local ss = s:Tab("YES")
local s2 = s:Tab("Teleport")
local sx = s:Tab("Credits")



ss:Label("---AUTO FARM---")
ss:Button("OP EXP FARM (REJOIN TO STOP)",function()
spawn(function()
while wait() do
if not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Combat) end
for i = 1,5 do
for I,v in pairs(game:GetService("Workspace").Monster:GetChildren()) do
if v:FindFirstChild("Head") then
local args = {
   [1] = i,
   [2] = v.Head.Position
}
game:GetService("Players").LocalPlayer.Character.Combat.Sword_Client.RemoteEvent:FireServer(unpack(args))
end
end
end
end
end)
end)

ss:Button("BLUE GUI (CLICK ONCE)",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SHAREHACK/allscript/main/memesea"))()
end)
ss:Label("")
ss:Label("---RACE CHOOSER---")

ss:Button("HUMAN RACE",function()
game:GetService("ReplicatedStorage").RaceSelector.RaceEvents.Human:FireServer()
end)

ss:Button("MINK/RABBIT RACE",function()
game:GetService("ReplicatedStorage").RaceSelector.RaceEvents.Mink:FireServer()
end)

ss:Button("SKYPEAN RACE",function()
game:GetService("ReplicatedStorage").RaceSelector.RaceEvents.Skypian:FireServer()
end)

ss:Button("FISHMAN RACE",function()
game:GetService("ReplicatedStorage").RaceSelector.RaceEvents.Fishman:FireServer()
end)



s2:Label("---Worlds---")

s2:Button("First Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(188.147446, -36.9041977, -653.436401, -0.987197876, 3.1233288e-08, -0.159500211, 2.34810269e-08, 1, 5.04881328e-08, 0.159500211, 4.60965488e-08, -0.987197876)
end)

s2:Button("Testing Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4157.88721, -100.83831, -1039.00708, 0.994251966, -9.68335456e-08, 0.107065402, 9.41340161e-08, 1, 3.02676249e-08, -0.107065402, -2.00151504e-08, 0.994251966)
end)

s2:Button("Zombie Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1200.16748, -92.5983429, 1456.82581, 0.192773715, -3.75307003e-08, -0.981243253, -1.19067414e-08, 1, -4.05872917e-08, 0.981243253, 1.95075724e-08, 0.192773715)
end)

s2:Button("Desert Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-379.423553, -77.1598053, -2882.97998, 0.753265917, 5.91404756e-08, 0.657716095, -1.01931885e-09, 1, -8.87505394e-08, -0.657716095, 6.61823307e-08, 0.753265917)
end)

s2:Button("Pink Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3247.50635, -91.6156235, 495.873016, 0.00524493959, 7.49089324e-08, -0.999986231, 1.20370283e-08, 1, 7.49730944e-08, 0.999986231, -1.24300925e-08, 0.00524493959)
end)

s2:Button("Snow Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2173.50366, -68.4425201, -1328.46924, -0.890697598, -4.99506889e-08, 0.454596251, -5.08489393e-08, 1, 1.02501101e-08, -0.454596251, -1.39859884e-08, -0.890697598)
end)

s2:Button("Black Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2915.0708, -80.7271729, 3085.01343, 0.0242958385, 4.21406874e-08, -0.999704838, 8.86365115e-08, 1, 4.43072636e-08, 0.999704838, -8.96868357e-08, 0.0242958385)
end)

s2:Button("Something Island",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(917.003174, 122.026558, 2159.2644, -0.979881108, -4.25366374e-11, 0.19958207, -4.8196714e-11, 1, -2.35011732e-11, -0.19958207, -3.26475548e-11, -0.979881108)
end)


ss:Slider("WalkSpeed",0,200,70,function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t;
end)



sx:Label("Credits to")
sx:Label("mjtbincourse(RACE CHOOSER), wincoh#5722 EXP FARM, pa1n")
sx:Label("For the Skripts")
sx:Label("")
sx:Button("Join Discord For More Skripts!",function()
setclipboard("https://pa1n.xyz/discord")
end)
sx:Label("(Click to Copy!)")
