repeat task.wait() until game:IsLoaded()

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("pa1n Scripts")

local serv = win:Server("x", "")

local main = serv:Channel("Main")

function autoattack()
    local button = game:service'VirtualInputManager'
    local X, Y = 0, 0
    
    button:SendMouseButtonEvent(X, Y, 0, true, game, 1)
    button:SendMouseButtonEvent(X, Y, 0, false, game, 1)
    wait(0.3)
    button:SendKeyEvent(true, "Q", false, game)
    button:SendKeyEvent(true, "E", false, game)
    button:SendKeyEvent(true, "R", false, game)
    button:SendKeyEvent(true, "T", false, game)
    button:SendKeyEvent(true, "One", false, game)
    button:SendKeyEvent(true, "Two", false, game)
    button:SendKeyEvent(true, "Three", false, game)
    button:SendKeyEvent(true, "Four", false, game)
end

function autocollectcoins()
    local coins = game:GetService("Workspace"):GetDescendants()
    for i,v in pairs(coins) do 
    if v.Name == 'CoinDrop' then
        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
         wait(0.6)
    end
    end
end

function egg1()
    local args = {[1] = "World1"} 
    game:GetService("ReplicatedStorage")._remotes.CharacterHatchFunctionTriple:InvokeServer(unpack(args))
    wait(1)
end

function egg2()
    local args = {[1] = "World2"}
    game:GetService("ReplicatedStorage")._remotes.CharacterHatchFunctionTriple:InvokeServer(unpack(args))
    wait(1)
end

main:Toggle("Auto Attack/Skill/Support",false, function(t)
    getgenv().attacking = t;
    while task.wait() and getgenv().attacking do
        autoattack()
    end
end)

main:Toggle("Auto Collect Coins",false, function(t)
    getgenv().collectcoins = t;
    while task.wait() and getgenv().collectcoins do
        autocollectcoins()
    end
end)

main:Toggle("Auto Open Egg (World 1)",false, function(t)
    getgenv().eggf1 = t;

    while getgenv().eggf1 and task.wait() do
        task.spawn(function()
            egg1()
        end)
    end
end)

main:Toggle("Auto Open Egg (World 2)",false, function(t)
    getgenv().eggf2 = t;

    while getgenv().eggf2 and task.wait() do
        task.spawn(function()
            egg2()
        end)
    end
end)


main:Button("Auto Redeem Codes", function()
    
    local args = {[1] = "1klikesnice"}
    game:GetService("ReplicatedStorage")._remotes.CodeFunction:InvokeServer(unpack(args))
    
    local args = {[1] = "Release"}
    game:GetService("ReplicatedStorage")._remotes.CodeFunction:InvokeServer(unpack(args))
    
    local args = {[1] = "500likescool"}
    game:GetService("ReplicatedStorage")._remotes.CodeFunction:InvokeServer(unpack(args))
    
    local args = {[1] = "sorryforshutdown"}
    game:GetService("ReplicatedStorage")._remotes.CodeFunction:InvokeServer(unpack(args))
    
    local args = {[1] = "sorryforshutdownagain"}
    game:GetService("ReplicatedStorage")._remotes.CodeFunction:InvokeServer(unpack(args))
    
    local args = {[1] = "world2"}
    game:GetService("ReplicatedStorage")._remotes.CodeFunction:InvokeServer(unpack(args))
            
    local args = {[1] = "update2"}
    game:GetService("ReplicatedStorage")._remotes.CodeFunction:InvokeServer(unpack(args))
            
    local args = {[1] = "7klikeswoo"}
    game:GetService("ReplicatedStorage")._remotes.CodeFunction:InvokeServer(unpack(args))
end)

local mobfarm = serv:Channel("Mob Farm")

mobfarm:Label("(You need to be in the zone to farm)")
mobfarm:Label("-- East Town --")

mobfarm:Button("Quest NPC",function(t)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(522.232178, 52.1414223, 510.11676, -0.611822248, 3.98394313e-08, -0.7909953, 6.82093031e-08, 1, -2.39260611e-09, 0.7909953, -5.54170896e-08, -0.611822248)
end)

mobfarm:Dropdown("Select NPC",{"Marine1", "Marine2", "MarineX"}, function(t)
    getgenv().etmname = t;
end)

mobfarm:Toggle("Toggle Farm",false, function(t)
    getgenv().togglefarm1 = t;
    while task.wait() and getgenv().togglefarm1 do
        for i,v in pairs(game:GetService("Workspace").Enemies.World1Zone1:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == getgenv().etmname then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
            end
        end
    end
end)

mobfarm:Label("-- Buggy's Town --")

mobfarm:Button("Quest NPC",function(t)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3577.60645, 49.063652, 477.101227, 0.494200438, 1.43748409e-08, -0.86934799, -5.45416441e-08, 1, -1.44702286e-08, 0.86934799, 5.45668613e-08, 0.494200438)
end)

mobfarm:Dropdown("Select NPC",{"Minion1", "Minion2", "Tamer", "Cyclist"}, function(t)
    getgenv().btname = t;
end)

mobfarm:Toggle("Toggle Farm",false, function(t)
    getgenv().togglefarm1 = t;
    while task.wait() and getgenv().togglefarm1 do
        for i,v in pairs(game:GetService("Workspace").Enemies.World1Zone2:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == getgenv().btname then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
            end
        end
    end
end)

mobfarm:Label("-- Maple Village --")

mobfarm:Button("Quest NPC",function(t)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6294.69531, 89.0400772, 499.592285, 0.817001045, -1.6721069e-10, 0.576636195, -1.66070233e-08, 1, 2.38194655e-08, -0.576636195, -2.90367392e-08, 0.817001045)
end)

mobfarm:Dropdown("Select NPC",{"SlasherCrew1", "SlasherCrew2", "CatBro1", "CatBro2", "Hypno"}, function(t)
    getgenv().mpname = t;
end)

mobfarm:Toggle("Toggle Farm",false, function(t)
    getgenv().togglefarm1 = t;
    while task.wait() and getgenv().togglefarm1 do
        for i,v in pairs(game:GetService("Workspace").Enemies.World1Zone3:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == getgenv().mpname then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
            end
        end
    end
end)

mobfarm:Label("-- Baratia --")

mobfarm:Button("Quest NPC",function(t)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(9065.0791, 15.3150225, 442.642609, 0.265996993, 8.12083627e-08, -0.96397388, -1.57275526e-08, 1, 7.99034936e-08, 0.96397388, -6.09313933e-09, 0.265996993)
end)

mobfarm:Dropdown("Select NPC",{"GoldCrew1", "GoldCrew2", "Jin", "Marble"}, function(t)
    getgenv().baraname = t;
end)

mobfarm:Toggle("Toggle Farm",false, function(t)
    getgenv().togglefarm1 = t;
    while task.wait() and getgenv().togglefarm1 do
        for i,v in pairs(game:GetService("Workspace").Enemies.World1Zone4:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == getgenv().baraname then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
            end
        end
    end
end)

mobfarm:Label("-- Sawfish Park --")

mobfarm:Button("Quest NPC",function(t)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(12003.0703, 15.9947357, 254.662277, -0.922755599, -8.81142626e-08, -0.385385633, -7.21572562e-08, 1, -5.58680746e-08, 0.385385633, -2.37442084e-08, -0.922755599)
end)

mobfarm:Dropdown("Select NPC",{"Fish1", "Fish2", "Chomp", "Karate", "Squid"}, function(t)
    getgenv().sawname = t;
end)

mobfarm:Toggle("Toggle Farm",false, function(t)
    getgenv().togglefarm1 = t;
    while task.wait() and getgenv().togglefarm1 do
        for i,v in pairs(game:GetService("Workspace").Enemies.World1Zone5:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == getgenv().sawname then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
            end
        end
    end
end)

local mobfarm2 = serv:Channel("Mob Farm (World 2)")

mobfarm2:Label("(You need to be in the zone to farm)")
mobfarm2:Label("-- Snowy Hills --")

mobfarm2:Button("Quest NPC",function(t)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(829.34552, -94.79599, 3515.06445, -0.878049016, -8.0525723e-08, 0.478570729, -7.44066568e-08, 1, 3.174668e-08, -0.478570729, -7.73370878e-09, -0.878049016)
end)

mobfarm2:Dropdown("Select NPC",{"LittleBunny", "MidBunny", "BigBunny", "Afro", "Jester"}, function(t)
    getgenv().snowyn1 = t;
end)

mobfarm2:Toggle("Toggle Farm",false, function(t)
    getgenv().togglefarm1 = t;
    while task.wait() and getgenv().togglefarm1 do
        for i,v in pairs(game:GetService("Workspace").Enemies.World2Zone1:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == getgenv().snowyn1 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
            end
        end
    end
end)

mobfarm2:Label("-- Desert Kingdom --")

mobfarm2:Button("Quest NPC",function(t)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3349.8064, -133.750641, 3687.88721, 0.421696275, -7.50829656e-08, -0.906737149, -2.37965967e-08, 1, -9.38727425e-08, 0.906737149, 6.11630426e-08, 0.421696275)
end)

mobfarm2:Dropdown("Select NPC",{"BombMan", "Kilo", "Batter", "Mole", "Spikes", "Steel"}, function(t)
    getgenv().desert = t;
end)

mobfarm2:Toggle("Toggle Farm",false, function(t)
    getgenv().togglefarm1 = t;
    while task.wait() and getgenv().togglefarm1 do
        for i,v in pairs(game:GetService("Workspace").Enemies.World2Zone2:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v.Name == getgenv().desert then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,5)
            end
        end
    end
end)

local bossfarm = serv:Channel("Boss Farm")
mobfarm2:Label("-- Boss Farm --")
plr = game.Players.LocalPlayer

function farmboss(boss)
    if getgenv().bossname ~= nil then
        for i,v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Folder") and v.Name:match(plr.UserId.."BossBattleFolder") then
                if v:FindFirstChild(boss) then
                    if v[boss]:FindFirstChild("Humanoid").Health > 0 then
                        plr.Character:FindFirstChild("HumanoidRootPart").CFrame = v[boss]:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,0,5)
                    end
                end    
            end 
        end 
    end
end

function startbossfarm(boss)
    
if plr.Character:FindFirstChild("HumanoidRootPart") then
        if boss == "Cap Freeman" and not game.Workspace:FindFirstChild(plr.UserId .. "BossBattleFolder") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(977.35614, 52.2258492, 739.708618, -0.999380112, 3.05162366e-08, 0.0352046527, 3.03523748e-08, 1, -5.18903764e-09, -0.0352046527, -4.11727585e-09, -0.999380112)
            plr.Character.HumanoidRootPart.Anchored = true
            task.wait(2)
            plr.Character.HumanoidRootPart.Anchored = false
            fireproximityprompt(game:GetService("Workspace").Bosses[boss].HumanoidRootPart.ProximityPrompt)
            button = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.MainFrame.BossFight.ContinueFrame.Continue
            task.wait(2)
            for i,v in pairs(getconnections(button.Activated)) do
                v:Fire()
            end
            task.wait(2)
            farmboss(boss)
        elseif boss == "Boogie" and not game.Workspace:FindFirstChild(plr.UserId .. "BossBattleFolder") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(4049.39258, 100.916237, 487.413666, -0.00746295368, -4.52747706e-08, -0.999972165, -1.74710664e-08, 1, -4.51456437e-08, 0.999972165, 1.71336598e-08, -0.00746295368)
            plr.Character.HumanoidRootPart.Anchored = true
            task.wait(2)
            plr.Character.HumanoidRootPart.Anchored = false
            fireproximityprompt(game:GetService("Workspace").Bosses[boss].HumanoidRootPart.ProximityPrompt)
            button = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.MainFrame.BossFight.ContinueFrame.Continue
            task.wait(2)
            for i,v in pairs(getconnections(button.Activated)) do
                v:Fire()
            end
            task.wait(2)
            farmboss(boss)
        elseif boss == "Slasher" and not game.Workspace:FindFirstChild(plr.UserId .. "BossBattleFolder") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(6969.67871, 23.0138168, 483.006012, 0.255250245, 1.12091385e-07, -0.966875017, -2.18212755e-08, 1, 1.10170902e-07, 0.966875017, -7.02270464e-09, 0.255250245)
            plr.Character.HumanoidRootPart.Anchored = true
            task.wait(2)
            plr.Character.HumanoidRootPart.Anchored = false
            fireproximityprompt(game:GetService("Workspace").Bosses[boss].HumanoidRootPart.ProximityPrompt)
            button = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.MainFrame.BossFight.ContinueFrame.Continue
            task.wait(2)
            for i,v in pairs(getconnections(button.Activated)) do
                v:Fire()
            end
            task.wait(2)
            farmboss(boss)
        elseif boss == "Don Craig" and not game.Workspace:FindFirstChild(plr.UserId .. "BossBattleFolder") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(9572.91016, 15.1261148, 452.330963, -0.0230331887, 4.58216505e-08, -0.9997347, -6.02195138e-09, 1, 4.5972552e-08, 0.9997347, 7.0792483e-09, -0.0230331887)
            plr.Character.HumanoidRootPart.Anchored = true
            task.wait(2)
            plr.Character.HumanoidRootPart.Anchored = false
            fireproximityprompt(game:GetService("Workspace").Bosses[boss].HumanoidRootPart.ProximityPrompt)
            button = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.MainFrame.BossFight.ContinueFrame.Continue
            task.wait(2)
            for i,v in pairs(getconnections(button.Activated)) do
                v:Fire()
            end
            task.wait(2)
            farmboss(boss)
        elseif boss == "Sawfish" and not game.Workspace:FindFirstChild(plr.UserId .. "BossBattleFolder") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(12393.585, 15.9946442, 550.497437, -0.985396147, -2.37007214e-08, -0.170277596, -4.12453254e-08, 1, 9.94978961e-08, 0.170277596, 1.05067997e-07, -0.985396147)
            plr.Character.HumanoidRootPart.Anchored = true
            task.wait(2)
            plr.Character.HumanoidRootPart.Anchored = false
            fireproximityprompt(game:GetService("Workspace").Bosses[boss].HumanoidRootPart.ProximityPrompt)
            button = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.MainFrame.BossFight.ContinueFrame.Continue
            task.wait(2)
            for i,v in pairs(getconnections(button.Activated)) do
                v:Fire()
            end
            task.wait(2)
            farmboss(boss)
        elseif boss == "Muncher" and not game.Workspace:FindFirstChild(plr.UserId .. "BossBattleFolder") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(678.908386, -73.6656799, 4207.79785, -0.663332283, 1.04694912e-07, 0.74832499, 6.49905516e-08, 1, -8.22965731e-08, -0.74832499, -5.95591754e-09, -0.663332283)
            plr.Character.HumanoidRootPart.Anchored = true
            task.wait(2)
            plr.Character.HumanoidRootPart.Anchored = false
            fireproximityprompt(game:GetService("Workspace").Bosses[boss].HumanoidRootPart.ProximityPrompt)
            button = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.MainFrame.BossFight.ContinueFrame.Continue
            task.wait(2)
            for i,v in pairs(getconnections(button.Activated)) do
                v:Fire()
            end
            task.wait(2)
            farmboss(boss)
        elseif boss == "Croc" and not game.Workspace:FindFirstChild(plr.UserId .. "BossBattleFolder") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(4247.96973, -112.418404, 3557.95923, -0.17554608, -8.63102656e-09, -0.984471202, 4.39167351e-08, 1, -1.65981877e-08, 0.984471202, -4.61485108e-08, -0.17554608)
            plr.Character.HumanoidRootPart.Anchored = true
            task.wait(2)
            plr.Character.HumanoidRootPart.Anchored = false
            fireproximityprompt(game:GetService("Workspace").Bosses[boss].HumanoidRootPart.ProximityPrompt)
            button = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.MainFrame.BossFight.ContinueFrame.Continue
            task.wait(2)
            for i,v in pairs(getconnections(button.Activated)) do
                v:Fire()
            end
            task.wait(2)
            farmboss(boss)
        else
        farmboss(boss)
        end
end
end



bossfarm:Dropdown("Select NPC",{"Cap Freeman", "Boogie", "Slasher", "Don Craig", "Sawfish", "Muncher", "Croc"}, function(t)
    getgenv().bossname = t;
end)

bossfarm:Toggle("Toggle Farm",false, function(t)
    getgenv().bossfarm = t;
end)

local plrtab = serv:Channel("Player")

plrtab:Slider("WalkSpeed",16,300,16,function(t)
    _G.ws = t; 
    local plr = game:service'Players'.LocalPlayer;
    plr.Character.Humanoid:GetPropertyChangedSignal'WalkSpeed':Connect(function()
    plr.Character.Humanoid.WalkSpeed = _G.ws;
    end)
    plr.Character.Humanoid.WalkSpeed = _G.ws; 
end)

plrtab:Slider("JumpPower",60,300,16,function(t)
    _G.jp = t; 
    local plr = game:service'Players'.LocalPlayer;
    plr.Character.Humanoid:GetPropertyChangedSignal'JumpPower':Connect(function()
    plr.Character.Humanoid.JumpPower = _G.jp;
    end)
    plr.Character.Humanoid.JumpPower = _G.jp;
end)

plrtab:Toggle("Infinite Jump",false, function(t)
    local Player = game:GetService'Players'.LocalPlayer;
    local UIS = game:GetService'UserInputService';
     
    _G.JumpHeight = 50;
     
    function Action(Object, Function) if Object ~= nil then Function(Object); end end
     
    UIS.InputBegan:connect(function(UserInput)
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
            Action(Player.Character.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(self)
                        self.Velocity = Vector3.new(0, _G.JumpHeight, 0);
                    end)
                end
            end)
        end
    end)
end)

plrtab:Label("Built in Anti-AFK :)")

local credit = serv:Channel("Credits!")

credit:Label("")
credit:Label("")
credit:Label("Script made by pa1n#8015 & Arpon AG#6612")
credit:Label("")
credit:Button("Join Discord (Click to Copy)",function()
setclipboard("https://pa1n.xyz/discord")
end)
credit:Label("If you need help or the script is not working let me know in ")
credit:Label("discord")
credit:Label("")
credit:Label("[Press K to Hide/Show This GUI]")

---- ANTI AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)
