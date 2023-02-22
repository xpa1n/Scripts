--- Ignore
if _G.AutoRaid and game.PlaceId == 11582083063 then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(397.592651, 60.478054, -4316.15527, 0.999958456, -8.54472688e-08, -0.0091136517, 8.53811812e-08, 1, -7.64078756e-09, 0.0091136517, 6.86233603e-09, 0.999958456)
    wait(3)
end

task.spawn(function()
    while _G.AutoRaid do
        if game:GetService("Workspace").Worlds.World1.Lobby.Raid.RaidGUI.SurfaceGui.Timer.Text:match("Raid In Progress") then
            if _G.BoogieRaid then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.9574928, -1.14258242, -7559.74561, -0.362684637, -3.93572428e-08, -0.931911945, 2.63739999e-08, 1, -5.24971142e-08, 0.931911945, -4.36181402e-08, -0.362684637)
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                repeat task.wait() until game:GetService("Workspace").Worlds.World1.Lobby.RaidLobby.Map.BuggyRaid:FindFirstChild("Teleport")
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            elseif _G.SawfishRaid then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-161.397675, 8.90677643, -7556.2876, -0.51346308, 2.92121527e-08, 0.85811168, 1.05759639e-07, 1, 2.92403861e-08, -0.85811168, 1.05767441e-07, -0.51346308)
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                repeat task.wait() until game:GetService("Workspace").Worlds.World1.Lobby.RaidLobby.Map.BuggyRaid:FindFirstChild("Teleport")
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
        end
        task.wait()
    end
end)
task.spawn(function()
            if game.PlaceId ~= 11582083063 then
                while task.wait() and _G.AutoRaid do
                for i,v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "RaidBoss" and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0  then
                    v.HumanoidRootPart.Size = Vector3.new(999,999,999)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Head.CFrame * CFrame.new(0,40,40)
                end
            end
        end
    end
end)

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

task.spawn(function()
    while task.wait() and _G.AutoRaid and game.PlaceId ~= 11582083063 do
        autoattack()
    end
end)

---- KILL NOTIFICATIONS
game:GetService("Players").pa1nx9.PlayerGui.MainGui.MainFrame.NotificationFrame.Visible = false;

---- ANTI AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)
