for i,v in pairs (game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "pa1nhub" then
        v:Destroy()
    end
end

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xpa1n/library/main/CustomVepLibrary.lua"))()

local s = VLib:Window("Best Skript ", "Anime Artifacts S2", "")

local ss = s:Tab("Sex")
local s2 = s:Tab("Teleport")
local sx = s:Tab("Credits")


ss:Button("Inf Money",function()
local args = {
   [1] = "Sell",
   [2] = {
       [1] = {
           ["onlyId"] = "15823026.4166416",
           ["Level"] = math.huge,
           ["ItemId"] = "weapon003"
           }                    
          }                      
         }
          
game:GetService("ReplicatedStorage").Events.WeaponSell:InvokeServer(unpack(args))
end)


ss:Toggle("Kill Aura (Mobs)",function(t)

getgenv().killAura = t

local player = game:GetService("Players").LocalPlayer

while killAura and task.wait() do
   for i,v in pairs(game:GetService("Workspace").Monsters[player.Stage.Value]:GetChildren()) do      
       game:GetService("ReplicatedStorage").Events.DmgEvent:FireServer(v)
   end    
end

end)

ss:Toggle("Kill Aura (Bosses)",function(t)

getgenv().bossAura = t

local player = game:GetService("Players").LocalPlayer
local arena = "FightArea_" .. tostring(player.UserId)

while bossAura and task.wait() do
   local status = game:GetService("Workspace"):FindFirstChild(arena)
   if status then
       for i,v in pairs(status:GetChildren()) do
           if string.match(v.Name, "monster") then
               game:GetService("ReplicatedStorage").Events.DmgEvent:FireServer(v)
           end
       end
   end
end

end)

ss:Toggle("Kill Aura (Norm Dungeons)",function(t)

getgenv().dungeonAura = t

local player = game:GetService("Players").LocalPlayer

while dungeonAura and task.wait() do
   for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
       if string.match(v.Name, "monster") then
           game:GetService("ReplicatedStorage").Events.DmgEvent:FireServer(v)
       end
   end
end

end)

ss:Toggle("Kill Aura (Event Dungeons)",function(t)

getgenv().eventAura = t

local player = game:GetService("Players").LocalPlayer

while eventAura and task.wait() do
   local event = game:GetService("Workspace"):WaitForChild("CopybookFolder")
   for i,v in pairs(event:GetChildren()) do
       if string.match(v.Name, "monster") then
           game:GetService("ReplicatedStorage").Events.DmgEvent:FireServer(v)
       end
   end
   for i,v in pairs(game:GetService("Workspace").Monsters:GetChildren()) do
       if string.match(v.Name, "monster") then
           game:GetService("ReplicatedStorage").Events.DmgEvent:FireServer(v)
       end
   end
end

end)


ss:Dropdown("Get Free Crates!",{"draw001", "draw002", "draw003", "draw004", "draw005", "draw006", "draw007", "draw008", "draw009", "draw010", "draw011", "draw012"},function(t)

for i = 1,100 do
local args = {
   [1] = t ,
   [2] = "E",
}

game:GetService("ReplicatedStorage").Events.UIEvents.DrawWeapon:FireServer(unpack(args))
end

end)

s2:Label("---Worlds---")

s2:Button("Stage 1",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage001.CFrame
end)
s2:Button("Stage 2",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage002.CFrame
end)
s2:Button("Stage 3",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage003.CFrame
end)
s2:Button("Stage 4",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage004.CFrame
end)
s2:Button("Stage 5",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage005.CFrame
end)
s2:Button("Stage 6",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage006.CFrame
end)
s2:Button("Stage 7",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage007.CFrame
end)
s2:Button("Stage 8",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage008.CFrame
end)
s2:Button("Stage 9",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage009.CFrame
end)
s2:Button("Stage 10",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage010.CFrame
end)
s2:Button("Stage 11",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage011.CFrame
end)
s2:Button("Stage 12",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds.stage012.CFrame
end)


ss:Slider("WalkSpeed",0,200,70,function(t)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t;
end)



sx:Label("Credits to")
sx:Label("tr#5030, Eucalyptus, PpRoStOo")
sx:Label("For the Skripts")
sx:Label("")
sx:Button("Join Discord For More Skripts!",function()
setclipboard("https://pa1n.xyz/discord")
end)
sx:Label("(Click to Copy!)")
