for i,v in pairs (game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "pa1nhub" then
        v:Destroy()
    end
end

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xpa1n/library/main/CustomVepLibrary.lua"))()

local s = VLib:Window("pa1n Scripts", "Dragon Ball Rage", "")

local ss = s:Tab("Key")

ss:Label("")
ss:Label("")
ss:Label("-- Thank you so much for using our script --")
ss:Label("")
ss:Label("You need a key to unlock the GUI")
ss:Textbox("                           Put Key (Hit Enter)", true,function(key)
if key == "sex" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xpa1n/Scripts/main/DBR.lua"))()
end
end)

ss:Button("Join Discord (For key) -- Click to Copy",function()
setclipboard("https://pa1n.xyz/discord")
end)
ss:Label("(No Linkvertise/Workink)")


