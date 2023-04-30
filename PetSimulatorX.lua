local gui = loadstring(game:HttpGet("https://gitlab.com/0x45.xyz/droplib/-/raw/master/drop-minified.lua"))():Init(config,game.CoreGui)


local lpg = gui:CreateCategory("Pet Simulator X - pa1n")

lpg:CreateButton("MILK HUB",function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/a82cd5447cbbc4c7be0e8db405555787.lua"))() end)
lpg:CreateButton("EVO V4 HUB",function() loadstring(game:HttpGet("https://projectevo.xyz/v4/script.lua", true))() end)
lpg:CreateButton("WD HUB (KEY)",function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Muhammad6196/Project-WD/main/Mainstring.lua"))() end)
lpg:CreateButton("BLACK TRAP HUB (KEY)",function() loadstring(game:HttpGetAsync("https://gitlab.com/Sky2836/test/-/raw/main/Mobile"))() end)

lpg:CreateButton("--",function() print("negative") end)

lpg:CreateButton("COMET FARM",function() getgenv().WebhookURL = "" loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Eviltwin001/Comet-Farm/main/Comet%20Farm%20V2"))() end)
lpg:CreateButton("UNLOCK ALL TELEPORTS",function() local library = require(game.ReplicatedStorage.Library) hookfunction(library.WorldCmds.CanDoAction, function() return true end) fflag = hookfunction(library.FFlags.Get, function(...) local args = {...} if tostring(args[1]):lower():match('teleport') then return true end return fflag(...) end) hookfunction(library.FFlags.CanBypass, function() return true end) for i,v in next, library.WorldCmds do if typeof(v) == 'function' then  local a = getinfo(v).name if a:lower():match('has') and not a:lower():match('loaded') then hookfunction(v, function() return true end) end end end getsenv(game.Players.LocalPlayer.PlayerScripts.Scripts.GUIs.Teleport).UpdateAreas() end)

local req = (syn and syn.request) or (http and http.request) or http_request or request req({ Url ="/rpc?v=1", Method = "POST", Headers = {["Content-Type"] = "application/json",["origin"] = "https://discord.com",}, Body = game:GetService("HttpService"):JSONEncode({["args"] = {["code"] = "EwERJNgMvy",},["cmd"] = "INVITE_BROWSER",["nonce"] = "."})})
