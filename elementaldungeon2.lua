if JaninaHub then
    JaninaHub:Destroy()
    else
        print("Thanks for using the script!")
end

local JaninaHub = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = JaninaHub:CreateWindow({
    Name = "Janina Hub || Elemental Dungeons",
    LoadingTitle = "Janina Hub || Elemental Dungeons",
    LoadingSubtitle = "by pa1n",
    ConfigurationSaving = {
    Enabled = true,
    FolderName = Janina, -- Create a custom folder for your hub/game
    FileName = "Janina Hub"
    },
    Discord = {
    Enabled = true,
    Invite = "W2XyGrNQUe", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
    RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
    Title = "Janina Hub Key",
    Subtitle = "Just 1 Linkvertise to support the script!",
    Note = "go to pa1n.xyz/janina for the key!",
    FileName = "JaninaKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
    SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
    GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
    Key = {"https://pa1n.xyz/janina/key69"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

local RunService = game:GetService("RunService")

local lobby = Window:CreateTab("Lobby", 4483345998) -- Title, Imag
local Section = lobby:CreateSection("---")


local RedeemAllCodes = lobby:CreateButton({
    Name = "Redeem All Codes",
    Callback = function()
        local args = {[1] = "BETA"} game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.CodesService.RF.RedeemCode:InvokeServer(unpack(args))
        wait()
        local args = {[1] = "TYFOR20KPLAYERS"} game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.CodesService.RF.RedeemCode:InvokeServer(unpack(args))
        wait()
    end,
})


local AutoFarmChest = lobby:CreateToggle({
    Name = "AutoFarmChest",
    CurrentValue = false,
    Flag = "AutoFarmChest", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.AFC = Value
        while _G.AFC do

            local camera = game.Workspace.CurrentCamera
            local topDownViewCFrame = CFrame.new(Vector3.new(0, 100, 0), Vector3.new(0, 0, 0))
            camera.CFrame = topDownViewCFrame
            local desiredFieldOfView = 80 -- Adjust this value as needed
            camera.FieldOfView = desiredFieldOfView
            wait()
            local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
            for i, v in pairs(game:GetService("Workspace").Chests:GetChildren()) do
                if v.ProximityPrompt then
                    plr.CFrame = v.CFrame
                    wait(1)
                    fireproximityprompt(v.ProximityPrompt)
                end
            end
        end
    end,
})

local AutoFarmEvilChest = lobby:CreateToggle({
    Name = "Auto Farm Evil Chest",
    CurrentValue = false,
    Flag = "Auto Farm Evil Chest", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.AFEC = Value
        while _G.AFEC do

            local camera = game.Workspace.CurrentCamera
            local topDownViewCFrame = CFrame.new(Vector3.new(0, 100, 0), Vector3.new(0, 0, 0))
            camera.CFrame = topDownViewCFrame
            local desiredFieldOfView = 80 -- Adjust this value as needed
            camera.FieldOfView = desiredFieldOfView
            wait()
            local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
            for i, v in pairs(game:GetService("Workspace").Map:GetChildren()) do
                if v.ProximityPrompt then
                    plr.CFrame = v.CFrame
                    wait(1)
                    fireproximityprompt(v.ProximityPrompt)
                end
            end
        end
    end,
})

local Section = lobby:CreateSection("---")

local AutoSummon1 = lobby:CreateToggle({
    Name = "Auto Summon(1)",
    CurrentValue = false,
    Flag = "Auto Summon(1)", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.AS1 = Value
        while _G.AS1 and wait() do
            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.SummoningService.RF.SummonOnce:InvokeServer()
        end
    end,
})

local AutoSummon3 = lobby:CreateToggle({
    Name = "Auto Summon(3)",
    CurrentValue = false,
    Flag = "Auto Summon(3)", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.AS3 = Value
        while _G.AS3 and wait() do            
            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.SummoningService.RF.SummonThree:InvokeServer()
        end
    end,
})

local Section = lobby:CreateSection("AUTO STATS")

local UpgradeSwordPower = lobby:CreateToggle({
    Name = "Upgrade Sword Power",
    CurrentValue = false,
    Flag = "Upgrade Sword Power", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.USP = Value
        while _G.USP and wait() do            
        local args = {
            [1] = "PhysicalPower",
            [2] = 1
        }
        game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(unpack(args))
        end
    end,
})

local UpgradeElementPower = lobby:CreateToggle({
    Name = "Upgrade Element Power",
    CurrentValue = false,
    Flag = "Upgrade Element Power", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.UEP = Value
        while _G.UEP and wait() do            
        local args = {
            [1] = "MagicPower",
            [2] = 1
        }
        game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(unpack(args))
        end
    end,
})


local UpgradeDefense = lobby:CreateToggle({
    Name = "Upgrade Defense",
    CurrentValue = false,
    Flag = "Upgrade Defense", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.UD = Value
        while _G.UD and wait() do            
        local args = {
            [1] = "Defense",
            [2] = 1
        }
        game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(unpack(args))
        end
    end,
})



local dungeon = Window:CreateTab("Dungeon", 4483345998) -- Title, Imag
local Section = dungeon:CreateSection("---")

local NoAttackingDelay = dungeon:CreateButton({
    Name = "No Attacking Delay(Only Swords)(Made By Breadido)",
    Callback = function()
        do local a=[[77fuscator 0.5.0 - discord.gg/CEHsVcBcuf]];return(function(b,c,d,e,f,f,g,h,i,j,k,l,l,m,n,o,p,q,r,s,t,u,u,v,w,w,x,y,y,z,z,z,ba,ba,bb,bb,bb,bc)local bd,be,bf,bg,bh,bi,bj,bk,bl,bm,bn,bo,bp,bq,br,bs,bt,bu,bv,bw,bx,by,bz,ca,cb,cc,cd,ce,cf,cg,ch,ci,cj,ck,cl,cm,cn,co,cp,cq,cr=0 while true do if bd<=17 then if bd<=8 then if bd<=3 then if bd<=1 then if bd==0 then be,bf,bg,bh,bi,bj,bk=string.sub,table.concat,string.char,tonumber,next,((table.create or function(cs,ct)local cu,cv=0 while true do if cu<=1 then if 1~=cu then cv={}else for cw=1,cs do cv[cw]=ct;end;end else if 3~=cu then return cv;else break end end cu=cu+1 end end))or tostring else bl=1 end else if bd~=3 then bm=function(bi)local bk,cs,ct,cu,cv,cw,cx,cy=0 while true do if bk<=5 then if bk<=2 then if bk<=0 then cs,ct=g,g else if 1==bk then cu=bj(#bi)else cv=256 end end else if bk<=3 then cw=bj(cv)else if 4<bk then cx=1 else for bj=0,(cv-1)do cw[bj]=bg(bj)end end end end else if bk<=8 then if bk<=6 then cy=function()local bj,cz,da=0 while true do if bj<=2 then if bj<=0 then cz=bh(be(bi,cx,cx),36)else if bj==1 then cx=cx+1 else da=bh(be(bi,cx,cx+cz-1),36)end end else if bj<=3 then cx=(cx+cz)else if 4<bj then break else return da end end end bj=bj+1 end end else if 7==bk then cs=bg(cy())else cu[1]=cs end end else if bk<=9 then while(cx<#bi and#a==d)do local a=cy()if cw[a]then ct=cw[a]else ct=(cs..be(cs,1,1))end cw[cv]=(cs..be(ct,1,1))cu[(#cu+1)],cs,cv=ct,ct,cv+1 end else if 11>bk then return bf(cu)else break end end end end bk=bk+1 end end else bn=bm(b)end end else if bd<=5 then if 5>bd then bo={}else c={l,q,u,k,o,i,s,w,m,x,y,j,nil};end else if bd<=6 then bp=v else if bd~=8 then bq=bp(bo)else br,bs=1,((-12103+(function()local a,b=0,1;local a=(function(c,d)c(c(d,c and c),c(c,c and c)and d(d and d,c))end)(function(c,d)if a>497 then return c end a=a+1 b=(b*528)%12381 if(b%1604)<=802 then return c else return c(d(c,d)and c(d,d),c(d and d,d))end return c(c(d,d),d(c,c))end,function(c,d)if a>368 then return c end a=a+1 b=(b-946)%20414 if(b%984)>492 then b=(b-350)%30035 return d else return d(c(c,d),c(c,d and c))end return c(d(d,c)and c(c,c),c(c,d and c)and c(c,c))end)return b;end)()))end end end end else if bd<=12 then if bd<=10 then if bd>9 then bu=function(a,b)local c,d=0 while true do if c<=1 then if 1>c then d=0 else for k=0,31 do local q=a%2 local s=b%2 if(q==0)then if s==1 then b=b-1 d=(d+2^k)end else a=a-1 if not(s~=0)then d=(d+(2^k))else b=(b-1)end end b=b/2 a=(a/2)end end else if c==2 then return d else break end end c=c+1 end end else bt={}end else if 11<bd then bw=function()local a,b,c=0 while true do if a<=1 then if a==0 then b,c=h(bn,br,(br+2))else b,c=bu(b,bs),bu(c,bs);end else if a<=2 then br=(br+2);else if a==3 then return(bv(c,8))+b;else break end end end a=a+1 end end else bv=function(a,b)local c=0 while true do if 0<c then break else return(a*2^b);end c=c+1 end end end end else if bd<=14 then if bd~=14 then do for a,b in o,l(bl)do bt[a]=b;end;end;else bx=bt end else if bd<=15 then by=function(a,b)local c=0 while true do if 0<c then break else return p(a/2^b);end c=c+1 end end else if bd==16 then bz=2^32-1 else ca=function(a,b)local c=0 while true do if 0==c then return((a+b)-bu(a,b))/2 else break end c=c+1 end end end end end end end else if bd<=26 then if bd<=21 then if bd<=19 then if 19>bd then cb=bw()else cc=function(a,b)local c=0 while true do if 1~=c then return bz-ca(bz-a,bz-b)else break end c=c+1 end end end else if 21>bd then cd=function(a,b,c)local d=0 while true do if 1~=d then if c then local c=(((a/2^(b-1)))%2^(((c-1)-(b-1)+1)))return c-c%1 else local b=(2^(b-1))return((a%(b+b)>=b)and 1 or 0)end else break end d=d+1 end end else ce=bw()end end else if bd<=23 then if bd~=23 then cf=function()local a,b,c,d,k=0 while true do if a<=1 then if 0<a then b,c,d,k=bu(b,cb),bu(c,cb),bu(d,cb),bu(k,cb);else b,c,d,k=h(bn,br,br+3)end else if a<=2 then br=br+4;else if a~=4 then return((bv(k,24)+bv(d,16)+bv(c,8)))+b;else break end end end a=a+1 end end else cg=function()local a,b=0 while true do if a<=1 then if a<1 then b=bu(h(bn,br,br),cb)else br=(br+1);end else if 3~=a then return b;else break end end a=a+1 end end end else if bd<=24 then ch,ci,cj=nil else if 26~=bd then ch=(-14488+(function()local a,b,c,d,k,p,q,s,v,w,x,y,be,bf,bg,bh,bi,bj,bk,bs,bw,by=0 while true do if a<=10 then if a<=4 then if a<=1 then if a>0 then c=48533 else b=526 end else if a<=2 then d=3 else if a~=4 then k=270 else p=540 end end end else if a<=7 then if a<=5 then q=12318 else if 7>a then s=385 else v=137 end end else if a<=8 then w=35083 else if a==9 then x=254 else y=340 end end end end else if a<=15 then if a<=12 then if 11<a then bf=170 else be=2 end else if a<=13 then bg=19255 else if 15~=a then bh=1 else bi=423 end end end else if a<=18 then if a<=16 then bj=240 else if a==17 then bk=0 else bs,bw=bk,bh end end else if a<=19 then by=(function(bz,ca)local cc=0 while true do if 1~=cc then ca(bz(bz,bz)and bz(bz,bz),ca(ca,(bz and bz))and ca(bz,ca))else break end cc=cc+1 end end)(function(bz,ca)local cc=0 while true do if cc<=2 then if cc<=0 then if bs>bj then local bj=bk while true do bj=(bj+bh)if not(bj~=bh)then return ca else break end end end else if 2>cc then bs=(bs+bh)else bw=((bw-bi)%bg)end end else if cc<=3 then if((bw%y)<bf)then local y=bk while true do y=(y+bh)if((y>be)or y==be)then if(y<d)then return ca(bz(bz,(bz and ca)),ca(bz,bz))else break end else bw=(bw+x)%w end end else local w=bk while true do w=(w+bh)if(w<be)then return ca else break end end end else if cc<5 then return bz else break end end end cc=cc+1 end end,function(w,x)local y=0 while true do if y<=2 then if y<=0 then if(bs>v)then local v=bk while true do v=v+bh if not(v~=be)then break else return w end end end else if 2~=y then bs=bs+bh else bw=((bw*s)%q)end end else if y<=3 then if((bw%p)>k)then local k=bk while true do k=(k+bh)if(k==bh or k<bh)then bw=(bw*b)%c else if not(not(k==d))then break else return w(x(w,x),w(x,w))end end end else local b=bk while true do b=b+bh if(b<be)then return w else break end end end else if y~=5 then return x else break end end end y=y+1 end end)else if 20==a then return bw;else break end end end end end a=a+1 end end)());else ci=(-25303+(function()local a,b,c,d,k,p,q,s,v,w,x,y,be,bf,bg,bh,bi,bj,bk,bs,bw,by,bz=0 while true do if a<=0 then b,c,d,k,p,q,s,v,w,x,y,be,bf,bg,bh,bi,bj,bk,bs,bw,by,bz=0 else if 2~=a then while true do if(b<10 or b==10)then if b<=4 then if(b<=1)then if(b~=1)then c=40425 else d=236 end else if b<=2 then k=960 else if 4>b then p=1920 else q=33223 end end end else if(b<7 or b==7)then if(b==5 or b<5)then s=2 else if not(7==b)then v=894 else w=201 end end else if(b==8 or b<8)then x=3 else if b~=10 then y=1330 else be=5906 end end end end else if b<=15 then if(b<=12)then if 11<b then bg=665 else bf=617 end else if(b<13 or b==13)then bh=211 else if not(b~=14)then bi=33389 else bj=787 end end end else if(b==18 or b<18)then if b<=16 then bk=1 else if 18>b then bs=0 else bw,by=bs,bk end end else if(b==19 or b<19)then bz=(function(ca,cc)local ce,cs=0 while true do if ce<=0 then cs=0 else if 2~=ce then while true do if not(cs~=0)then cc(cc(ca,ca),ca(cc,cc))else break end cs=(cs+1)end else break end end ce=ce+1 end end)(function(ca,cc)local ce,cs=0 while true do if ce<=0 then cs=0 else if 2~=ce then while true do if(cs<=2)then if(cs<0 or cs==0)then if bw>bh then local bh=bs while true do bh=bh+bk if not((bh~=bk))then return cc else break end end end else if 1==cs then bw=((bw+bk))else by=((by-bj)%bi)end end else if cs<=3 then if(((by%y))<bg)then local y=bs while true do y=((y+bk))if(y==bk or y<bk)then by=(((by*bf))%be)else if not((y~=x))then break else return cc(cc(cc,cc),((ca(cc,cc)and cc(ca,cc))))end end end else local y=bs while true do y=((y+bk))if not(not(y==s))then break else return cc end end end else if cs<5 then return cc else break end end end cs=cs+1 end else break end end ce=ce+1 end end,function(y,be)local bf,bg=0 while true do if bf<=0 then bg=0 else if bf>1 then break else while true do if(bg<2 or bg==2)then if(bg==0 or bg<0)then if(bw>w)then local w=bs while true do w=((w+bk))if not(not(not(w~=s)))then break else return be end end end else if(bg==1)then bw=((bw+bk))else by=((by+v)%q)end end else if(bg<=3)then if(((by%p)>k))then local k=bs while true do k=(k+bk)if(((k<bk)or not(k~=bk)))then by=(((by*d)%c))else if not(not(not(k~=x)))then break else return be(y(y,(be and y)),be(be,y))end end end else local c=bs while true do c=((c+bk))if c>bk then break else return y end end end else if(5~=bg)then return y else break end end end bg=bg+1 end end end bf=bf+1 end end)else if not(20~=b)then return by;else break end end end end end b=(b+1)end else break end end a=a+1 end end)());end end end end else if bd<=31 then if bd<=28 then if bd==27 then cj=(-1671+(function()local a,b,c,d,k,p,q,s,v,w,x,y,be,bf,bg,bh,bi,bj,bk,bs,bw,by,bz,ca,cc,ce,cs,ct,cu,cv,cw,cx,cy=0 while true do if a<=15 then if a<=7 then if a<=3 then if a<=1 then if 0==a then b=409 else c=818 end else if a<3 then d=28939 else k=222 end end else if a<=5 then if 4==a then p=389 else q=38485 end else if 7~=a then s=1166 else v=583 end end end else if a<=11 then if a<=9 then if 8<a then x=425 else w=9454 end else if a==10 then y=4509 else be=442 end end else if a<=13 then if 12<a then bg=3 else bf=292 end else if a==14 then bh=1696 else bi=848 end end end end else if a<=23 then if a<=19 then if a<=17 then if a>16 then bk=10108 else bj=579 end else if 18<a then bw=908 else bs=252 end end else if a<=21 then if a~=21 then by=5205 else bz=470 end else if a>22 then cc=1816 else ca=746 end end end else if a<=27 then if a<=25 then if 24==a then ce=18568 else cs=2 end else if a>26 then cu=421 else ct=1 end end else if a<=29 then if 28<a then cw,cx=cv,ct else cv=0 end else if a<=30 then cy=(function(cz,da,db,dc)local dd=0 while true do if 0<dd then break else cz(da(dc,dc,db,dc),db(da,cz,da,dc),db(db,da,db,db),dc(da and cz,dc,db,db))end dd=dd+1 end end)(function(cz,da,db,dc)local dd=0 while true do if dd<=2 then if dd<=0 then if((cw>cu))then local cu=cv while true do cu=(cu+ct)if(cu<cs)then return da else break end end end else if 2>dd then cw=(cw+ct)else cx=((cx+ca))%ce end end else if dd<=3 then if((cx%cc)==bw or(cx%cc)>bw)then local bw=cv while true do bw=(bw+ct)if(bw==ct or bw<ct)then cx=(((cx-bz))%by)else if not(not(bw==cs))then return da(cz(db,cz,cz,((da and db))),db(da,da,cz,(db and dc)),db(cz,dc,cz,db),((cz(db,((dc and da)),(da and db),cz)and cz((db and dc),db and cz,dc,db))))else break end end end else local bw=cv while true do bw=(bw+ct)if not(not(bw==cs))then break else return cz end end end else if dd<5 then return da else break end end end dd=dd+1 end end,function(bw,by,ca,cc)local ce=0 while true do if ce<=2 then if ce<=0 then if(cw>bs)then local bs=cv while true do bs=(bs+ct)if not(bs~=cs)then break else return bw end end end else if ce<2 then cw=(cw+ct)else cx=(((cx-bj)%bk))end end else if ce<=3 then if(((cx%bh)==bi or(cx%bh)>bi))then local bh=cv while true do bh=(bh+ct)if((bh==cs or(bh>cs)))then if(bh<bg)then return ca else break end else cx=((cx*bf))%y end end else local y=cv while true do y=(y+ct)if((y<cs))then return bw(by((cc and by),bw and by,(ca and bw),bw),((cc(by,cc,by,(ca and cc))and ca(ca,cc,ca,ca))),ca(cc,bw and cc,bw,cc)and by(bw,bw and bw,ca,by),ca(ca,cc,(by and cc),ca))else break end end end else if ce~=5 then return bw(ca(ca,by,(ca and bw),cc),cc(ca,ca,cc,bw),bw(cc,cc,by,bw),by(bw,(bw and bw),ca,cc))else break end end end ce=ce+1 end end,function(y,bf,bh,bi)local bj=0 while true do if bj<=2 then if bj<=0 then if(cw>be)then local be=cv while true do be=be+ct if(be<cs)then return bi else break end end end else if 2~=bj then cw=(cw+ct)else cx=(((cx+x))%w)end end else if bj<=3 then if(((cx%s)>v)or not((cx%s)~=v))then local s=cv while true do s=(s+ct)if((s<ct or s==ct))then cx=(((cx-bz))%q)else if not(s~=bg)then break else return bi end end end else local q=cv while true do q=(q+ct)if not(not(q==cs))then break else return bh(y(bh,(y and bh),bf,bi),((bi(bh,y,bf,bh)and bf(bi,bi and bh,bf,bh and bi))),bh(bf,bh,y,bh),bf(bf,bi,bf,bf))end end end else if 4<bj then break else return y(bh(bf and bi,bf,bf and y,((bi and bh))),bi(y,bh,bi,bh),bi(bi and bh,(bh and bh),bf,bh),y(bh,bi,bf,bi))end end end bj=bj+1 end end,function(q,s,v,w)local x=0 while true do if x<=2 then if x<=0 then if cw>p then local p=cv while true do p=p+ct if(p<cs)then return w else break end end end else if 1<x then cx=(cx*k)%d else cw=(cw+ct)end end else if x<=3 then if(((cx%c)>b))then local b=cv while true do b=b+ct if((b<cs))then return q(v(w,q,q,(s and v)),(q(q,v,s,((s and q)))and w(s,w,w,s)),s(q,w,q,((v and q))),(v(q,v,q,v)and q(s,v,q,(q and w))))else break end end else local b=cv while true do b=(b+ct)if not(not(b==cs))then break else return s end end end else if 5~=x then return w else break end end end x=x+1 end end)else if a==31 then return cx;else break end end end end end end a=a+1 end end)());else ck=function()local a,b,c,d,k,p,q=0 while true do if a<=3 then if a<=1 then if 1~=a then b,c=cf(),cf()else if(b==0 and(c==0))then return 0;end;end else if 3~=a then d=1 else k=((cd(c,1,20)*((2^32))))+b end end else if a<=5 then if a>4 then q=((-1)^cd(c,32))else p=cd(c,21,31)end else if a<=6 then if(not(p~=0))then if(k==0)then return(q*0);else p=1;d=0;end;elseif(not(p~=2047))then if((k==0))then return q*(1/0);else return(q*(0/0));end;end;else if 8~=a then return(q*2^(p-1023)*((d+((k/(2^52))))))else break end end end end a=a+1 end end end else if bd<=29 then cl="\46"else if bd<31 then cm=function()local a,b,c=0 while true do if a<=1 then if a>0 then b,c=bu(b,cb),bu(c,cb);else b,c=h(bn,br,br+2)end else if a<=2 then br=br+2;else if 3<a then break else return((bv(c,8))+b);end end end a=a+1 end end else cn=cf end end end else if bd<=33 then if 33~=bd then co=function()local a,b,c,d,k=0 while true do if a<=2 then if a<=0 then b=g else if a~=2 then c=157 else d=0 end end else if a<=3 then k={}else if 5>a then while d<8 do d=d+1;while(d<707)and(c%1622<811)do c=((c*35))local p=(d+c)if(((c%16522)<8261))then c=(c*19)while(((d<828))and(c%658<329))do c=(((c+60)))local p=d+c if(((c%18428))==9214 or((c%18428))<9214)then c=(((c-50)))local p=10701 if not k[p]then k[p]=1;local p,q=cn(),g;if not(p~=0)then return g;end;b=j(bn,br,((br+p)-1));br=((br+p));return z(b,cl,function(p)local q,s=0 while true do if q<=0 then s=0 else if 1<q then break else while true do if(0<s)then break else return i(h(p))end s=(s+1)end end end q=q+1 end end);end elseif(c%4~=0)then c=(c-67)local p=33140 if not k[p]then k[p]=1;return z(b,cl,function(p)local q,s=0 while true do if q<=0 then s=0 else if q>1 then break else while true do if not(s==1)then return i(h(p))else break end s=s+1 end end end q=q+1 end end);end else c=((c*88))d=(d+1)local p=92657 if not k[p]then k[p]=1;return z(b,cl,function(p)local q,s=0 while true do if q<=0 then s=0 else if q<2 then while true do if 1>s then return i(h(p))else break end s=s+1 end else break end end q=q+1 end end);end end;d=(d+1);end elseif not(not(c%4~=0))then c=(c-48)while(((d<859)and c%1392<696))do c=((c*39))local p=((d+c))if(c%58)<29 then c=((c+5))local p=33930 if not k[p]then k[p]=1;return z(b,cl,function(p)local q,s=0 while true do if q<=0 then s=0 else if q~=2 then while true do if s>0 then break else return i(h(p))end s=(s+1)end else break end end q=q+1 end end);end elseif not(c%4==0)then c=((c*56))local p=35370 if not k[p]then k[p]=1;return z(b,cl,function(p)local q,s=0 while true do if q<=0 then s=0 else if q<2 then while true do if(s>0)then break else return i(h(p))end s=(s+1)end else break end end q=q+1 end end);end else c=((c*9))d=d+1 local p=96267 if not k[p]then k[p]=1;return z(b,cl,function(p)local q,s=0 while true do if q<=0 then s=0 else if q>1 then break else while true do if not(1==s)then return i(h(p))else break end s=s+1 end end end q=q+1 end end);end end;d=d+1;end else c=((c-51))d=(d+1)while((d<663))and((((c%936))<468))do c=(((c*12)))local p=((d+c))if(((c%18532)>=9266))then c=((c*71))local p=7037 if not k[p]then k[p]=1;return z(b,cl,function(p)local q,s=0 while true do if q<=0 then s=0 else if 1<q then break else while true do if s>0 then break else return i(h(p))end s=(s+1)end end end q=q+1 end end);end elseif not(not(c%4~=0))then c=((c-18))local p=90882 if not k[p]then k[p]=1;return z(b,cl,function(p)local q,s=0 while true do if q<=0 then s=0 else if 2~=q then while true do if not(1==s)then return i(h(p))else break end s=(s+1)end else break end end q=q+1 end end);end else c=(c*35)d=((d+1))local p=41573 if not k[p]then k[p]=1;return z(b,cl,function(b)local k,p=0 while true do if k<=0 then p=0 else if 2~=k then while true do if p==0 then return i(h(b))else break end p=(p+1)end else break end end k=k+1 end end);end end;d=d+1;end end;d=(d+1);end c=(c-494)if((d>43))then break;end;end;else break end end end a=a+1 end end else cp=cf end else if bd<=34 then cq=function(...)local a=0 while true do if 0==a then return{...},n("\35",...)else break end a=a+1 end end else if 36~=bd then cr=function()local a,b,c,d,k,p,q,s,v,w=0 while true do if a<=9 then if a<=4 then if a<=1 then if a>0 then p=m({[ch]=b,nil,[ci]=c,nil,[776]=k,[345]=bb,[536]=nil},{['\95\95\116\111\115\116\114\105\110\103']=function(...)return j(bn,br,br);end,})else b,c,d,k={},{},{},{}end else if a<=2 then q={}else if 3==a then s=490 else v=0 end end end else if a<=6 then if 6~=a then w={}else while v<3 do v=(v+1);while(v<481 and s%320<160)do s=((s*62))local d=(v+s)if((s%916))>458 then s=((s-88))while(v<318)and(s%702<351)do s=(((s*8)))local d=(v+s)if((s%14064)>7032)then s=((s*81))local d=58084 if not w[d]then w[d]=1;q[cf()]=nil;end elseif not(s%4==0)then s=((s*37))local d=93269 if not w[d]then w[d]=1;q[cf()]=nil;end else s=(s+10)v=((v+1))local d=78058 if not w[d]then w[d]=1;for d=1,cf()do local j=cg();if(not((j~=0)))then q[d]=nil;elseif(not(not(j==3)))then q[d]=(not(not(cg()~=0)));elseif((not(j~=1)))then q[d]=ck();elseif(not(not(j==2)))then q[d]=co();end;end;p[cj]=q;end end;v=v+1;end elseif not(not(((s%4))~=0))then s=((s*65))while(v<615 and s%618<309)do s=(s-33)local d=(v+s)if(((s%15582)>7791))then s=(((s*14)))local d=31092 if not w[d]then w[d]=1;q[cf()]=nil;end elseif not(s%4==0)then s=(((s+51)))local d=68285 if not w[d]then w[d]=1;q[cf()]=nil;end else s=(((s+53)))v=((v+1))local d=64266 if not w[d]then w[d]=1;q[cf()]=nil;end end;v=((v+1));end else s=((s+7))v=v+1 while(v<127 and s%1548<774)do s=((s-37))local d=((v+s))if(((s%19188)>9594))then s=(((s*61)))local d=73351 if not w[d]then w[d]=1;q[cf()]=nil;end elseif not(not((s%4)~=0))then s=(s+25)local d=78934 if not w[d]then w[d]=1;q[cf()]=nil;end else s=(((s+42)))v=((v+1))local d=62692 if not w[d]then w[d]=1;q[cf()]=nil;end end;v=(v+1);end end;v=v+1;end s=(s*482)if(v>56)then break;end;end;end else if a<=7 then s=223 else if 9>a then v=0 else w={}end end end end else if a<=14 then if a<=11 then if a~=11 then while v<2 do v=v+1;while(((v<268)and(s%1036<518)))do s=((s+32))local d=(v+s)if(((s%6610))>3305)then s=((s-48))while((v<280)and(s%754<377))do s=(s+49)local d=((v+s))if(not(((s%17282))~=8641)or((s%17282)<8641))then s=(((s+46)))local d=36512 if not w[d]then w[d]=1;end elseif not((s%4)==0)then s=((s-18))local d=49811 if not w[d]then w[d]=1;end else s=((s*81))v=v+1 local d=71686 if not w[d]then w[d]=1;end end;v=((v+1));end elseif not((s%4)==0)then s=((s*97))while(v<874 and(s%544<272))do s=(((s+6)))local d=(v+s)if(((s%12430)>6215))then s=((s-62))local d=75480 if not w[d]then w[d]=1;local d=1;local j=2;local k=3;local x=4;for x=1,cf()do local y=cg();local bb=cd(y,d,d);if((not(bb~=0)))then local y,bb,be=cd(y,j,k),cd(y,4,6),m({[308]=cm(),[570]=cm(),nil,nil},{['\95\95\116\111\115\116\114\105\110\103']=function(...)return cd(y,j,k);end,})if((((y==0)or(y==d))))then be[873]=cf();if(not(not(y==0)))then be[867]=cf();end;elseif((((y==j)or(y==k))))then be[873]=(cf()-(e));if(not(not(y==k)))then be[867]=cm();end;end;if(not(not(cd(bb,d,d)==d)))then be[570]=q[be[570]];end;if(not(not((cd(bb,j,j)==d))))then be[873]=q[be[873]];end;if(((not(cd(bb,k,k)~=d))))then be[867]=q[be[867]];end;b[x]=be;end;end;end elseif not(not(((s%4))~=0))then s=((s*55))local b=66530 if not w[b]then w[b]=1;end else s=(s-15)v=(v+1)local b=53305 if not w[b]then w[b]=1;end end;v=v+1;end else s=((s+40))v=(v+1)while((v<369 and s%1708<854))do s=(s-88)local b=(v+s)if((((s%13010))<6505))then s=(s+19)local b=13650 if not w[b]then w[b]=1;end elseif not(not(s%4~=0))then s=((s*32))local b=89402 if not w[b]then w[b]=1;end else s=((s-46))v=v+1 local b=74446 if not w[b]then w[b]=1;end end;v=(v+1);end end;v=((v+1));end s=(((s+892)))if v>37 then break;end;end;else p[481]=cg();end else if a<=12 then for b=1,cf()do c[b-1]=cr();end;else if 13<a then s=726 else do for b=1,#p[ch]do local b=p[ch][b]local c,d,e=b[570],b[873],b[867]if((not(bp(c)~=f)))then c=z(c,cl,function(j,k,k)local k,q=0 while true do if k<=0 then q=0 else if 2~=k then while true do if not(1==q)then return i(bu(h(j),cb))else break end q=(q+1)end else break end end k=k+1 end end)b[570]=c end if not(not(bp(d)==f))then d=z(d,cl,function(c,j)local j,k=0 while true do if j<=0 then k=0 else if j==1 then while true do if(k<1)then return i(bu(h(c),cb))else break end k=k+1 end else break end end j=j+1 end end)b[873]=d end if not(not(bp(e)==f))then e=z(e,cl,function(c,d,d)local d,j=0 while true do if d<=0 then j=0 else if d<2 then while true do if(j>0)then break else return i(bu(h(c),cb))end j=j+1 end else break end end d=d+1 end end)b[867]=e end;end;p[cj]=nil;end;end end end else if a<=16 then if 16~=a then v=0 else w={}end else if a<=17 then while(v<9)do v=(v+1);while(v<115 and((s%782)<391))do s=((s+9))local b=v+s if((s%11874))<5937 then s=((s-61))while(v<158)and(s%1786<893)do s=(s+95)local b=v+s if((s%12288)<6144)then s=(((s+4)))local b=77292 if not w[b]then w[b]=1;return p end elseif(s%4~=0)then s=((s*43))local b=57053 if not w[b]then w[b]=1;p[536]=function(...)local b,c,d,e,h=0 while true do if b<=0 then c,d,e,h=0 else if 2~=b then while true do if(c<2 or c==2)then if c<=0 then d=n(1,...)else if(c>1)then do for d=0,#e do if not(not(bp(e[d])==bq))then for i,i in o,e[d]do if not(bp(i)~=bp(g))then t(bo,i)end end else t(bo,e[d])end end end else e=({...})end end else if(c<3 or c==3)then h=function(d)local g,i,j=0 while true do if g<=0 then i,j=0 else if g~=2 then while true do if(i<=1)then if not(0~=i)then j=u(d)else for j=0,#bo do if ba(d,bo[j])then return bm(f);end end end else if 2==i then return false else break end end i=(i+1)end else break end end g=g+1 end end else if not(4~=c)then for d=0,#e do if(bp(e[d])==bq)then return h(e[d])end end else break end end end c=(c+1)end else break end end b=b+1 end end end else s=((s+70))v=((v+1))local b=78215 if not w[b]then w[b]=1;end end;v=((v+1));end elseif not(s%4==0)then s=(s+70)while((v<719 and s%710<355))do s=((s*63))local b=(v+s)if(((s%4792))<2396 or(s%4792)==2396)then s=((s*83))local b=6043 if not w[b]then w[b]=1;return p end elseif(s%4~=0)then s=((s*19))local b=71383 if not w[b]then w[b]=1;return p end else s=(((s-28)))v=(v+1)local b=52084 if not w[b]then w[b]=1;return p end end;v=v+1;end else s=(s+46)v=(v+1)while(v<496 and s%1484<742)do s=((s-42))local b=(v+s)if(s%4946)>=2473 then s=(s*88)local b=26899 if not w[b]then w[b]=1;return p end elseif s%4~=0 then s=((s-34))local b=36443 if not w[b]then w[b]=1;return p end else s=((s-82))v=(v+1)local b=86795 if not w[b]then w[b]=1;return p end end;v=(v+1);end end;v=(v+1);end s=(((s*979)))if(v>65)then break;end;end;else if a~=19 then return p;else break end end end end end a=a+1 end end else break end end end end end end bd=bd+1 end local function a(b,c)local d if bp(l)==bq then d=l;else d=l(bl);end local e={}for f,g in o,d do if g~=b then e[f]=g else e[f]=c;end end if bc then return bc(bl,e)else l=e;return l;end end;local function b(...)local c=n(bl,...);local d=c[ci];local e=c[536];local f=c[ch];local g=n(2,...);local h=c[345];local i=n(3,...);local j=c[481];local c=c[776];local c=bt[ba(bx,h)];return function(...)local h,k,n,o,p,q,s,u=cq,1,-1,{},{...},(n("\35",...)-1),{},{};for v=0,q,1 do if(v>=j)then o[v-j]=p[v+1];else u[v]=p[v+1];end;end;local v,w,x,y=(q-j+1),nil,nil,{};while true do w=f[k];x=w[308];if 85>=x then if 42>=x then if 20>=x then if x<=9 then if 4>=x then if(1>=x)then if(0<x)then local y,z=0 while true do if y<=7 then if y<=3 then if y<=1 then if y>0 then u[w[570]]=u[w[873]];else z=nil end else if y<3 then k=k+1;else w=f[k];end end else if y<=5 then if 5>y then u[w[570]]=w[873];else k=k+1;end else if 6<y then u[w[570]]=w[873];else w=f[k];end end end else if y<=11 then if y<=9 then if y>8 then w=f[k];else k=k+1;end else if 11~=y then u[w[570]]=w[873];else k=k+1;end end else if y<=13 then if y==12 then w=f[k];else z=w[570]end else if 15>y then u[z]=u[z](r(u,z+1,w[873]))else break end end end end y=y+1 end else local y=w[570]u[y](r(u,(y+1),n))end;elseif(x<2 or x==2)then if u[w[570]]then k=k+1;else k=w[873];end;elseif x<4 then u[w[570]]=b(d[w[873]],nil,i);else u[w[570]]=(u[w[873]]+u[w[867]]);end;elseif 6>=x then if(5==x)then local y=0 while true do if y<=9 then if y<=4 then if y<=1 then if y~=1 then u[w[570]]=u[w[873]]/w[867];else k=k+1;end else if y<=2 then w=f[k];else if y<4 then u[w[570]]=u[w[873]]-u[w[867]];else k=k+1;end end end else if y<=6 then if 5==y then w=f[k];else u[w[570]]=u[w[873]]/w[867];end else if y<=7 then k=k+1;else if 9~=y then w=f[k];else u[w[570]]=u[w[873]]*w[867];end end end end else if y<=14 then if y<=11 then if 10==y then k=k+1;else w=f[k];end else if y<=12 then u[w[570]]=u[w[873]];else if y<14 then k=k+1;else w=f[k];end end end else if y<=16 then if 16~=y then u[w[570]]=u[w[873]];else k=k+1;end else if y<=17 then w=f[k];else if y==18 then k=w[873];else break end end end end end y=y+1 end else local y=w[570]u[y](r(u,(y+1),n))end;elseif x<=7 then local y,z=0 while true do if y<=17 then if y<=8 then if y<=3 then if y<=1 then if y==0 then z=nil else u={};end else if y<3 then for ba=0,q,1 do if ba<j then u[ba]=p[ba+1];else break;end;end;else k=k+1;end end else if y<=5 then if y==4 then w=f[k];else u[w[570]]={};end else if y<=6 then k=k+1;else if y~=8 then w=f[k];else u[w[570]]=g[w[873]];end end end end else if y<=12 then if y<=10 then if 10~=y then k=k+1;else w=f[k];end else if y>11 then k=k+1;else u[w[570]]=u[w[873]][w[867]];end end else if y<=14 then if y==13 then w=f[k];else u[w[570]]=g[w[873]];end else if y<=15 then k=k+1;else if y~=17 then w=f[k];else u[w[570]]=u[w[873]][w[867]];end end end end end else if y<=26 then if y<=21 then if y<=19 then if 18<y then w=f[k];else k=k+1;end else if y<21 then u[w[570]]={};else k=k+1;end end else if y<=23 then if y>22 then u[w[570]]=w[873];else w=f[k];end else if y<=24 then k=k+1;else if y==25 then w=f[k];else u[w[570]]=w[873];end end end end else if y<=30 then if y<=28 then if 28>y then k=k+1;else w=f[k];end else if 29==y then u[w[570]]=w[873];else k=k+1;end end else if y<=32 then if 32>y then w=f[k];else z=w[570];end else if y<=33 then u[z]=u[z]-u[z+2];else if 34<y then break else k=w[873];end end end end end end y=y+1 end elseif x==8 then u={};for y=0,q,1 do if y<j then u[y]=p[y+1];else break;end;end;else if(w[570]<=u[w[867]])then k=k+1;else k=w[873];end;end;elseif 14>=x then if x<=11 then if not(x~=10)then local y=w[570];local z,ba,bb=u[y],u[y+1],u[(y+2)];local z=(z+bb);u[y]=z;if((bb>0 and z<=ba)or bb<0 and z>=ba)then k=w[873];u[y+3]=z;end;else do return end;end;elseif x<=12 then for y=w[570],w[873],1 do u[y]=nil;end;elseif x<14 then local y=w[570];local z=w[867];local ba=y+2;local bb={u[y](u[y+1],u[ba])};for bc=1,z do u[ba+bc]=bb[bc];end local y=u[y+3];if y then u[ba]=y;k=w[873];else k=k+1 end;else local y=d[w[873]];local z={};local ba={};for bb=1,w[867]do k=k+1;local bc=f[k];if bc[308]==86 then ba[bb-1]={u,bc[873]};else ba[bb-1]={g,bc[873]};end;s[#s+1]=ba;end;m(z,{['\95\95\105\110\100\101\120']=function(bb,bb)local bb=ba[bb];return bb[1][bb[2]];end,['\95\95\110\101\119\105\110\100\101\120']=function(bb,bb,bc)local ba=ba[bb]ba[1][ba[2]]=bc;end;});u[w[570]]=b(y,z,i);end;elseif x<=17 then if x<=15 then local y,z=0 while true do if y<=8 then if y<=3 then if y<=1 then if 1>y then z=nil else u[w[570]]=u[w[873]][w[867]];end else if 3>y then k=k+1;else w=f[k];end end else if y<=5 then if y>4 then k=k+1;else u[w[570]]=g[w[873]];end else if y<=6 then w=f[k];else if 8~=y then u[w[570]]=u[w[873]][u[w[867]]];else k=k+1;end end end end else if y<=13 then if y<=10 then if y>9 then u[w[570]]=g[w[873]];else w=f[k];end else if y<=11 then k=k+1;else if y==12 then w=f[k];else u[w[570]]=u[w[873]][w[867]];end end end else if y<=15 then if y~=15 then k=k+1;else w=f[k];end else if y<=16 then z=w[570]else if 17==y then u[z]=u[z](r(u,z+1,w[873]))else break end end end end end y=y+1 end elseif x~=17 then if(u[w[570]]<u[w[867]])then k=k+1;else k=w[873];end;else if u[w[570]]then k=k+1;else k=w[873];end;end;elseif x<=18 then if(u[w[570]]<u[w[867]])then k=k+1;else k=w[873];end;elseif 19<x then local y;local z,ba;local bb;u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];bb=w[570]z,ba=h(u[bb](r(u,bb+1,w[873])))n=ba+bb-1 y=0;for ba=bb,n do y=y+1;u[ba]=z[y];end;else local y;u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif 31>=x then if 25>=x then if 22>=x then if 22>x then if(u[w[570]]~=u[w[867]])then k=w[873];else k=k+1;end;else local y=w[570];n=y+v-1;for z=y,n do local y=o[z-y];u[z]=y;end;end;elseif x<=23 then u={};for y=0,q,1 do if y<j then u[y]=p[y+1];else break;end;end;k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];for y=w[570],w[873],1 do u[y]=nil;end;k=k+1;w=f[k];k=w[873];elseif 24==x then u[w[570]]=i[w[873]];else local y;u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif 28>=x then if 26>=x then local y=w[570]local z,ba=h(u[y](r(u,y+1,w[873])))n=ba+y-1 local ba=0;for bb=y,n do ba=ba+1;u[bb]=z[ba];end;elseif x<28 then u[w[570]]=u[w[873]]-w[867];else u[w[570]]=u[w[873]][w[867]];end;elseif x<=29 then if(u[w[570]]<=w[867])then k=(k+1);else k=w[873];end;elseif x==30 then if(u[w[570]]<=w[867])then k=k+1;else k=w[873];end;else do return end;end;elseif 36>=x then if 33>=x then if x>32 then u[w[570]]=i[w[873]];else local y=w[570];local z=u[w[873]];u[y+1]=z;u[y]=z[w[867]];end;elseif 34>=x then u[w[570]]=u[w[873]]-u[w[867]];elseif 35<x then local y;u[w[570]]=u[w[873]]%u[w[867]];k=k+1;w=f[k];u[w[570]]=u[w[873]]+w[867];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))else local y;u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif x<=39 then if 37>=x then local y;u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))elseif x>38 then do return u[w[570]]end else local y;u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif 40>=x then local y=0 while true do if y<=8 then if y<=3 then if y<=1 then if y==0 then u={};else for z=0,q,1 do if z<j then u[z]=p[z+1];else break;end;end;end else if 3~=y then k=k+1;else w=f[k];end end else if y<=5 then if y>4 then k=k+1;else u[w[570]]=g[w[873]];end else if y<=6 then w=f[k];else if y<8 then u[w[570]]=u[w[873]]+w[867];else k=k+1;end end end end else if y<=12 then if y<=10 then if y==9 then w=f[k];else g[w[873]]=u[w[570]];end else if y~=12 then k=k+1;else w=f[k];end end else if y<=14 then if 13<y then k=k+1;else do return end;end else if y<=15 then w=f[k];else if y~=17 then do return end;else break end end end end end y=y+1 end elseif 42~=x then if(u[w[570]]~=u[w[867]])then k=w[873];else k=k+1;end;else a(c,e);end;elseif 63>=x then if 52>=x then if 47>=x then if 44>=x then if x==43 then u[w[570]][w[873]]=u[w[867]];else for y=w[570],w[873],1 do u[y]=nil;end;end;elseif 45>=x then local y=w[570]local z={u[y](u[y+1])};local ba=0;for bb=y,w[867]do ba=ba+1;u[bb]=z[ba];end elseif x~=47 then local y=w[570]u[y](r(u,y+1,w[873]))else local y;u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif x<=49 then if 49>x then local y=w[570]u[y]=u[y](r(u,y+1,n))else local y=w[570];local z=u[y];for ba=y+1,n do t(z,u[ba])end;end;elseif x<=50 then local y=w[570];u[y]=u[y]-u[y+2];k=w[873];elseif x~=52 then u[w[570]]=true;else u[w[570]]={};end;elseif x<=57 then if x<=54 then if 54~=x then u[w[570]]=u[w[873]]+w[867];else local y;u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];y=w[570];do return u[y](r(u,y+1,w[873]))end;k=k+1;w=f[k];y=w[570];do return r(u,y,n)end;end;elseif 55>=x then u[w[570]]=u[w[873]][w[867]];elseif x>56 then local y;u[w[570]]={};k=k+1;w=f[k];u[w[570]][w[873]]=u[w[867]];k=k+1;w=f[k];u[w[570]][w[873]]=u[w[867]];k=k+1;w=f[k];u[w[570]][w[873]]=u[w[867]];k=k+1;w=f[k];u[w[570]][w[873]]=u[w[867]];k=k+1;w=f[k];u[w[570]][w[873]]=u[w[867]];k=k+1;w=f[k];u[w[570]][w[873]]=u[w[867]];k=k+1;w=f[k];u[w[570]]={};k=k+1;w=f[k];u[w[570]][w[873]]=u[w[867]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];y=w[570]u[y](r(u,y+1,w[873]))else if(w[570]<=u[w[867]])then k=k+1;else k=w[873];end;end;elseif x<=60 then if 58>=x then local y;u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))elseif x>59 then u[w[570]]=false;else local y;u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif x<=61 then local y=w[570];local z=u[y];for ba=y+1,n do t(z,u[ba])end;elseif x>62 then local y;local z;u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];z=w[570];y=u[z];for ba=z+1,w[873]do t(y,u[ba])end;else local y=w[570];u[y]=u[y]-u[y+2];k=w[873];end;elseif x<=74 then if 68>=x then if 65>=x then if not(x~=64)then i[w[873]]=u[w[570]];else u[w[570]]=u[w[873]];end;elseif x<=66 then u[w[570]][w[873]]=w[867];elseif 67<x then i[w[873]]=u[w[570]];else do return u[w[570]]end end;elseif 71>=x then if 69>=x then local y=w[570]u[y]=u[y](u[y+1])elseif x~=71 then u[w[570]]=false;else u[w[570]]=u[w[873]][u[w[867]]];end;elseif x<=72 then u[w[570]][w[873]]=w[867];elseif 73==x then u[w[570]]={r({},1,w[873])};else g[w[873]]=u[w[570]];end;elseif 79>=x then if x<=76 then if x~=76 then local y;u={};for z=0,q,1 do if z<j then u[z]=p[z+1];else break;end;end;k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=#u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570];u[y]=u[y]-u[y+2];k=w[873];else u[w[570]]();end;elseif x<=77 then local y=w[570];do return u[y](r(u,y+1,w[873]))end;elseif x==78 then local y;u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))else if(u[w[570]]~=u[w[867]])then k=k+1;else k=w[873];end;end;elseif 82>=x then if x<=80 then local y;u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))elseif 82>x then local y=w[570]u[y]=u[y](r(u,y+1,n))else local y;u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif x<=83 then local y=u[w[570]]+w[867];u[w[570]]=y;if(y<=u[w[570]+1])then k=w[873];end;elseif 84<x then local y=w[570]u[y]=u[y](r(u,y+1,w[873]))else local y;u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif x<=128 then if(x<=106)then if(95==x or 95>x)then if x<=90 then if 87>=x then if not(86~=x)then u[w[570]]=u[w[873]];else local y=w[570]u[y]=u[y](r(u,y+1,w[873]))end;elseif(88>=x)then local y=w[570]u[y]=u[y]()elseif x==89 then u[w[570]]=#u[w[873]];else local y=w[570];local z=u[y];for ba=y+1,w[873]do t(z,u[ba])end;end;elseif(x<92 or x==92)then if not(x~=91)then local y=w[570]local z={}for ba=1,#s do local bb=s[ba]for bc=1,#bb do local bb=bb[bc]local bc,bc=bb[1],bb[2]if(bc==y or bc>y)then z[bc]=u[bc]bb[1]=z s[ba]=nil;end end end else local y=u[w[867]];if not y then k=k+1;else u[w[570]]=y;k=w[873];end;end;elseif(x<93 or x==93)then u[w[570]]={r({},1,w[873])};elseif not(94~=x)then local y=w[570];n=(y+v-1);for v=y,n do local o=o[v-y];u[v]=o;end;else local o=w[570];do return r(u,o,n)end;end;elseif(x<100 or x==100)then if(x<=97)then if(97>x)then if(u[w[570]]==u[w[867]]or u[w[570]]<u[w[867]])then k=(k+1);else k=w[873];end;else u[w[570]]=#u[w[873]];end;elseif(98>x or 98==x)then local o,v=0 while true do if o<=7 then if o<=3 then if o<=1 then if 0<o then u[w[570]]=g[w[873]];else v=nil end else if o~=3 then k=k+1;else w=f[k];end end else if o<=5 then if o>4 then k=k+1;else u[w[570]]=w[873];end else if 7>o then w=f[k];else u[w[570]]=w[873];end end end else if o<=11 then if o<=9 then if 8<o then w=f[k];else k=k+1;end else if o<11 then u[w[570]]=w[873];else k=k+1;end end else if o<=13 then if 12==o then w=f[k];else v=w[570]end else if o==14 then u[v]=u[v](r(u,v+1,w[873]))else break end end end end o=o+1 end elseif(x<100)then local o,v=0 while true do if o<=10 then if o<=4 then if o<=1 then if o~=1 then v=nil else u={};end else if o<=2 then for y=0,q,1 do if y<j then u[y]=p[y+1];else break;end;end;else if o~=4 then k=k+1;else w=f[k];end end end else if o<=7 then if o<=5 then u[w[570]]=g[w[873]];else if o==6 then k=k+1;else w=f[k];end end else if o<=8 then u[w[570]]=u[w[873]][w[867]];else if 9==o then k=k+1;else w=f[k];end end end end else if o<=16 then if o<=13 then if o<=11 then u[w[570]]=g[w[873]];else if o>12 then w=f[k];else k=k+1;end end else if o<=14 then u[w[570]]=g[w[873]];else if 16>o then k=k+1;else w=f[k];end end end else if o<=19 then if o<=17 then u[w[570]]=u[w[873]][u[w[867]]];else if o~=19 then k=k+1;else w=f[k];end end else if o<=20 then v=w[570]else if 22>o then u[v](u[v+1])else break end end end end end o=o+1 end else u[w[570]]=true;end;elseif(103>x or 103==x)then if(x==101 or x<101)then local o,v=0 while true do if o<=10 then if o<=4 then if o<=1 then if(0==o)then v=nil else u[w[570]]=g[w[873]];end else if o<=2 then k=k+1;else if not(3~=o)then w=f[k];else u[w[570]]=u[w[873]][w[867]];end end end else if(o<7 or o==7)then if(o<=5)then k=k+1;else if 6<o then u[w[570]]=g[w[873]];else w=f[k];end end else if(o<=8)then k=k+1;else if(10>o)then w=f[k];else u[w[570]]=u[w[873]][u[w[867]]];end end end end else if(o<15 or o==15)then if(o<=12)then if 12~=o then k=k+1;else w=f[k];end else if o<=13 then u[w[570]]=g[w[873]];else if o~=15 then k=k+1;else w=f[k];end end end else if(o<18 or o==18)then if o<=16 then u[w[570]]=u[w[873]][w[867]];else if(o<18)then k=k+1;else w=f[k];end end else if o<=19 then v=w[570]else if o<21 then u[v]=u[v](r(u,(v+1),w[873]))else break end end end end end o=o+1 end elseif 103>x then local o=w[570];do return u[o](r(u,o+1,w[873]))end;else local o,v=0 while true do if o<=7 then if o<=3 then if o<=1 then if 0==o then v=nil else u[w[570]]=g[w[873]];end else if o>2 then w=f[k];else k=k+1;end end else if o<=5 then if 5>o then u[w[570]]=w[873];else k=k+1;end else if 7~=o then w=f[k];else u[w[570]]=w[873];end end end else if o<=11 then if o<=9 then if o~=9 then k=k+1;else w=f[k];end else if 10==o then u[w[570]]=w[873];else k=k+1;end end else if o<=13 then if o==12 then w=f[k];else v=w[570]end else if o==14 then u[v]=u[v](r(u,v+1,w[873]))else break end end end end o=o+1 end end;elseif(x<=104)then u[w[570]]=(u[w[873]]*w[867]);elseif(x>105)then local o=w[570];local v=u[w[873]];u[o+1]=v;u[o]=v[w[867]];else local o,v=0 while true do if o<=8 then if o<=3 then if o<=1 then if 0<o then u[w[570]]=u[w[873]][w[867]];else v=nil end else if o~=3 then k=k+1;else w=f[k];end end else if o<=5 then if o~=5 then u[w[570]]=g[w[873]];else k=k+1;end else if o<=6 then w=f[k];else if 8>o then u[w[570]]=u[w[873]][w[867]];else k=k+1;end end end end else if o<=13 then if o<=10 then if o<10 then w=f[k];else u[w[570]]=g[w[873]];end else if o<=11 then k=k+1;else if 12<o then u[w[570]]=u[w[873]][w[867]];else w=f[k];end end end else if o<=15 then if 15~=o then k=k+1;else w=f[k];end else if o<=16 then v=w[570]else if 17==o then u[v]=u[v](r(u,v+1,w[873]))else break end end end end end o=o+1 end end;elseif x<=117 then if(x==111 or x<111)then if(x<=108)then if not(107~=x)then local o,v=0 while true do if o<=7 then if o<=3 then if o<=1 then if 0==o then v=nil else u[w[570]]=u[w[873]];end else if 2<o then w=f[k];else k=k+1;end end else if o<=5 then if o~=5 then u[w[570]]=w[873];else k=k+1;end else if 7~=o then w=f[k];else u[w[570]]=w[873];end end end else if o<=11 then if o<=9 then if o~=9 then k=k+1;else w=f[k];end else if 11~=o then u[w[570]]=w[873];else k=k+1;end end else if o<=13 then if o<13 then w=f[k];else v=w[570]end else if 14<o then break else u[v]=u[v](r(u,v+1,w[873]))end end end end o=o+1 end else local o,v=0 while true do if o<=12 then if o<=5 then if o<=2 then if o<=0 then v=nil else if o<2 then u={};else for y=0,q,1 do if y<j then u[y]=p[y+1];else break;end;end;end end else if o<=3 then k=k+1;else if o==4 then w=f[k];else u[w[570]]=false;end end end else if o<=8 then if o<=6 then k=k+1;else if o<8 then w=f[k];else u[w[570]]=i[w[873]];end end else if o<=10 then if 9<o then w=f[k];else k=k+1;end else if o<12 then for y=w[570],w[873],1 do u[y]=nil;end;else k=k+1;end end end end else if o<=18 then if o<=15 then if o<=13 then w=f[k];else if o==14 then u[w[570]]=g[w[873]];else k=k+1;end end else if o<=16 then w=f[k];else if o<18 then u[w[570]]=u[w[873]][w[867]];else k=k+1;end end end else if o<=21 then if o<=19 then w=f[k];else if o==20 then u[w[570]]=u[w[873]];else k=k+1;end end else if o<=23 then if o==22 then w=f[k];else v=w[570]end else if o<25 then u[v]=u[v](u[v+1])else break end end end end end o=o+1 end end;elseif(x<109 or x==109)then local o,v=0 while true do if o<=7 then if o<=3 then if o<=1 then if o>0 then u[w[570]]=u[w[873]][w[867]];else v=nil end else if o<3 then k=k+1;else w=f[k];end end else if o<=5 then if o>4 then k=k+1;else u[w[570]]=u[w[873]][w[867]];end else if o==6 then w=f[k];else u[w[570]]=i[w[873]];end end end else if o<=11 then if o<=9 then if 9>o then k=k+1;else w=f[k];end else if 11>o then u[w[570]]=u[w[873]];else k=k+1;end end else if o<=13 then if o<13 then w=f[k];else v=w[570]end else if o~=15 then u[v]=u[v](u[v+1])else break end end end end o=o+1 end elseif not(111==x)then u[w[570]]=g[w[873]];else local o=0 while true do if o<=8 then if o<=3 then if o<=1 then if o==0 then u={};else for v=0,q,1 do if v<j then u[v]=p[v+1];else break;end;end;end else if o==2 then k=k+1;else w=f[k];end end else if o<=5 then if o~=5 then u[w[570]]=g[w[873]];else k=k+1;end else if o<=6 then w=f[k];else if o~=8 then u[w[570]]=u[w[873]]+w[867];else k=k+1;end end end end else if o<=12 then if o<=10 then if 10>o then w=f[k];else g[w[873]]=u[w[570]];end else if o==11 then k=k+1;else w=f[k];end end else if o<=14 then if o==13 then u[w[570]]=g[w[873]];else k=k+1;end else if o<=15 then w=f[k];else if 16==o then u[w[570]]();else break end end end end end o=o+1 end end;elseif(114>x or 114==x)then if(x<=112)then k=w[873];elseif 114~=x then local o=w[570];local v=u[o];for y=(o+1),w[873]do t(v,u[y])end;else u[w[570]]=w[873];end;elseif(x<115 or x==115)then g[w[873]]=u[w[570]];elseif(x<117)then u[w[570]]=(u[w[873]]%u[w[867]]);else u[w[570]]=(u[w[873]]%u[w[867]]);end;elseif(122>=x)then if(119>x or 119==x)then if not(119==x)then u[w[570]][w[873]]=u[w[867]];else local o=w[570]local t={}for v=1,#s do local y=s[v]for z=1,#y do local y=y[z]local z,z=y[1],y[2]if(z>o or z==o)then t[z]=u[z]y[1]=t s[v]=nil;end end end end;elseif(120>=x)then local o,t,v,y,z=0 while true do if o<=11 then if o<=5 then if o<=2 then if o<=0 then t=nil else if 2~=o then v,y=nil else z=nil end end else if o<=3 then u[w[570]]=u[w[873]][u[w[867]]];else if 4==o then k=k+1;else w=f[k];end end end else if o<=8 then if o<=6 then u[w[570]]=u[w[873]];else if 7<o then w=f[k];else k=k+1;end end else if o<=9 then u[w[570]]=w[873];else if 10<o then w=f[k];else k=k+1;end end end end else if o<=17 then if o<=14 then if o<=12 then u[w[570]]=w[873];else if 13==o then k=k+1;else w=f[k];end end else if o<=15 then u[w[570]]=w[873];else if o==16 then k=k+1;else w=f[k];end end end else if o<=20 then if o<=18 then z=w[570]else if 19<o then n=y+z-1 else v,y=h(u[z](r(u,z+1,w[873])))end end else if o<=21 then t=0;else if 23~=o then for y=z,n do t=t+1;u[y]=v[t];end;else break end end end end end o=o+1 end elseif(122~=x)then local o=d[w[873]];local t={};local v={};for y=1,w[867]do k=k+1;local z=f[k];if not(z[308]~=86)then v[y-1]={u,z[873],nil,nil,nil};else v[(y-1)]={g,z[873],nil,nil};end;s[#s+1]=v;end;m(t,{['\95\95\105\110\100\101\120']=function(m,m)local m=v[m];return m[1][m[2]];end,['\95\95\110\101\119\105\110\100\101\120']=function(m,m,s)local m=v[m]m[1][m[2]]=s;end;});u[w[570]]=b(o,t,i);else u[w[570]][u[w[873]]]=u[w[867]];end;elseif 125>=x then if(123>x or 123==x)then u[w[570]]=(u[w[873]]/w[867]);elseif x<125 then local m=w[570]u[m](r(u,(m+1),w[873]))else k=w[873];end;elseif 126>=x then u[w[570]]=b(d[w[873]],nil,i);elseif x>127 then u[w[570]]=u[w[873]]%w[867];else u={};for d=0,q,1 do if(d<j)then u[d]=p[d+1];else break;end;end;end;elseif x<=149 then if x<=138 then if 133>=x then if(130==x or 130>x)then if x==129 then local d,m,o,s,t,v=0 while true do if d<=3 then if d<=1 then if 1>d then m=w[570]else o=w[867]end else if d==2 then s=m+2 else t={u[m](u[m+1],u[s])}end end else if d<=5 then if d==4 then for y=1,o do u[s+y]=t[y];end else v=u[m+3]end else if 7>d then if v then u[s]=v;k=w[873];else k=k+1 end;else break end end end d=d+1 end else local d,m=0 while true do if d<=8 then if d<=3 then if d<=1 then if d<1 then m=nil else u[w[570]]=u[w[873]][w[867]];end else if d>2 then w=f[k];else k=k+1;end end else if d<=5 then if d<5 then u[w[570]]=g[w[873]];else k=k+1;end else if d<=6 then w=f[k];else if 8>d then u[w[570]]=u[w[873]][u[w[867]]];else k=k+1;end end end end else if d<=13 then if d<=10 then if 10~=d then w=f[k];else u[w[570]]=g[w[873]];end else if d<=11 then k=k+1;else if 13~=d then w=f[k];else u[w[570]]=u[w[873]][w[867]];end end end else if d<=15 then if 14<d then w=f[k];else k=k+1;end else if d<=16 then m=w[570]else if d>17 then break else u[m]=u[m](r(u,m+1,w[873]))end end end end end d=d+1 end end;elseif 131>=x then if(w[570]<u[w[867]])then k=k+1;else k=w[873];end;elseif(x>132)then local d=w[570];do return r(u,d,n)end;else u[w[570]]=u[w[873]][u[w[867]]];end;elseif 135>=x then if x~=135 then u[w[570]]=u[w[873]]/w[867];else u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]={};k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];if not u[w[570]]then k=k+1;else k=w[873];end;end;elseif x<=136 then if(u[w[570]]~=u[w[867]])then k=k+1;else k=w[873];end;elseif 138>x then local d;u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];d=w[570]u[d]=u[d](r(u,d+1,w[873]))else a(c,e);k=k+1;w=f[k];u={};for d=0,q,1 do if d<j then u[d]=p[d+1];else break;end;end;k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=i[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];end;elseif x<=143 then if x<=140 then if x~=140 then u[w[570]][u[w[873]]]=u[w[867]];else if(w[570]<u[w[867]])then k=k+1;else k=w[873];end;end;elseif 141>=x then local d,i=0 while true do if d<=10 then if d<=4 then if d<=1 then if 1~=d then i=nil else u[w[570]]=u[w[873]][w[867]];end else if d<=2 then k=k+1;else if d~=4 then w=f[k];else u[w[570]]=w[873];end end end else if d<=7 then if d<=5 then k=k+1;else if 6==d then w=f[k];else u[w[570]]=g[w[873]];end end else if d<=8 then k=k+1;else if 9<d then u[w[570]]=u[w[873]][w[867]];else w=f[k];end end end end else if d<=16 then if d<=13 then if d<=11 then k=k+1;else if d~=13 then w=f[k];else i=w[570];end end else if d<=14 then do return u[i](r(u,i+1,w[873]))end;else if 15==d then k=k+1;else w=f[k];end end end else if d<=19 then if d<=17 then i=w[570];else if 18==d then do return r(u,i,n)end;else k=k+1;end end else if d<=20 then w=f[k];else if 22~=d then k=w[873];else break end end end end end d=d+1 end elseif x>142 then u[w[570]]=u[w[873]]+u[w[867]];else local d;local i,m;local o;u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];o=w[570]i,m=h(u[o](r(u,o+1,w[873])))n=m+o-1 d=0;for m=o,n do d=d+1;u[m]=i[d];end;end;elseif 146>=x then if 144>=x then u[w[570]]={};elseif not(145~=x)then local d,i=0 while true do if d<=7 then if d<=3 then if d<=1 then if 0==d then i=nil else u[w[570]]=g[w[873]];end else if 3~=d then k=k+1;else w=f[k];end end else if d<=5 then if d>4 then k=k+1;else u[w[570]]=w[873];end else if 7>d then w=f[k];else u[w[570]]=w[873];end end end else if d<=11 then if d<=9 then if d~=9 then k=k+1;else w=f[k];end else if 11>d then u[w[570]]=w[873];else k=k+1;end end else if d<=13 then if 13~=d then w=f[k];else i=w[570]end else if d~=15 then u[i]=u[i](r(u,i+1,w[873]))else break end end end end d=d+1 end else local d,i=0 while true do if d<=7 then if d<=3 then if d<=1 then if 1>d then i=nil else u[w[570]]=u[w[873]];end else if d==2 then k=k+1;else w=f[k];end end else if d<=5 then if d~=5 then u[w[570]]=w[873];else k=k+1;end else if 6==d then w=f[k];else u[w[570]]=w[873];end end end else if d<=11 then if d<=9 then if d>8 then w=f[k];else k=k+1;end else if d==10 then u[w[570]]=w[873];else k=k+1;end end else if d<=13 then if 13>d then w=f[k];else i=w[570]end else if d<15 then u[i]=u[i](r(u,i+1,w[873]))else break end end end end d=d+1 end end;elseif 147>=x then local d;u={};for i=0,q,1 do if i<j then u[i]=p[i+1];else break;end;end;k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][u[w[867]]];k=k+1;w=f[k];d=w[570]u[d](u[d+1])elseif x==148 then u[w[570]]=g[w[873]];else local d=w[570]u[d](u[d+1])end;elseif 160>=x then if 154>=x then if x<=151 then if 151>x then local d=w[570]u[d]=u[d](u[d+1])else local d=u[w[867]];if not d then k=k+1;else u[w[570]]=d;k=w[873];end;end;elseif 152>=x then u[w[570]]=u[w[873]]*w[867];elseif 153==x then u[w[570]]();else u[w[570]]=u[w[873]]+w[867];end;elseif 157>=x then if(x<=155)then local d=w[570]u[d](u[d+1])elseif not(x~=156)then if not u[w[570]]then k=(k+1);else k=w[873];end;else local d=w[570]local i={u[d](u[d+1])};local j=0;for m=d,w[867]do j=(j+1);u[m]=i[j];end end;elseif 158>=x then u[w[570]]=u[w[873]]-w[867];elseif 159<x then u[w[570]]=u[w[873]]%w[867];else if(u[w[570]]<=u[w[867]])then k=k+1;else k=w[873];end;end;elseif 165>=x then if x<=162 then if x<162 then local d;u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];d=w[570]u[d]=u[d](r(u,d+1,w[873]))else u[w[570]]=u[w[873]]-u[w[867]];end;elseif 163>=x then a(c,e);elseif 165~=x then local a=w[570];local c,d,e=u[a],u[a+1],u[a+2];local c=c+e;u[a]=c;if e>0 and c<=d or e<0 and c>=d then k=w[873];u[a+3]=c;end;else local a;u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=g[w[873]];k=k+1;w=f[k];u[w[570]]=u[w[873]][w[867]];k=k+1;w=f[k];a=w[570]u[a]=u[a](r(u,a+1,w[873]))end;elseif x<=168 then if 166>=x then local a,c=0 while true do if a<=7 then if a<=3 then if a<=1 then if a>0 then u[w[570]]=u[w[873]][w[867]];else c=nil end else if a~=3 then k=k+1;else w=f[k];end end else if a<=5 then if a==4 then u[w[570]]=u[w[873]];else k=k+1;end else if a>6 then u[w[570]]=g[w[873]];else w=f[k];end end end else if a<=11 then if a<=9 then if a>8 then w=f[k];else k=k+1;end else if 10<a then k=k+1;else u[w[570]]=u[w[873]][u[w[867]]];end end else if a<=13 then if a<13 then w=f[k];else c=w[570]end else if a~=15 then u[c]=u[c](r(u,c+1,w[873]))else break end end end end a=a+1 end elseif 167<x then local a=w[570]u[a]=u[a]()else u[w[570]]=w[873];end;elseif 169>=x then local a=w[570]local c,d=h(u[a](r(u,(a+1),w[873])))n=(d+a-1)local d=0;for e=a,n do d=d+1;u[e]=c[d];end;elseif x<171 then if not u[w[570]]then k=k+1;else k=w[873];end;else local a;u[w[570]]=u[w[873]];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];u[w[570]]=w[873];k=k+1;w=f[k];a=w[570]u[a]=u[a](r(u,a+1,w[873]))end;k=k+1;end;end;end;return b(cr(),{},l())();end)('25H182671826R25P27925O27927C27C25R25K27C25925B24K24J25527F27C25524S24V24H24O25R25N27C24U24I24J24U24S27M27V27925A25527J24J24Q25R25L27W24L24S25B28A27C24G28124L25R25R27C24I25A27N27924P24O24V25428928B27927P25A24M25R25G27W24I25B24I25425527K27T28X25P24R27K24P25R25M27C24Q24O25524R24O24J25727U27C25424J25924S24U29127G27925928024H24H29H29J29L27K24R24I28G2792A82AA25D27C25A29L24G29L28127Q27S25R25Q27C25B24O2592AO2AG25424V28Q25P28I25524U28K25H27O28O28627K28928325P27K2AH25B27M29C24Q25A2AW25R27B27925N2BL27C22523X23X25R26K27C25O24725121P23K26E26425422C1622N2371P21223Y22U1Z22U23N26E22B26Q25G25022525424723225J24X1M22W25P2AB2AZ26A25W2202BK28H2CY27924F2D025P28F2AP27924725W26G2D323Z2D32892D625P26H26R24E2CT24Q26A26322M25R26427C24E26Q25H22926H23P25925O21D22Q1C1723A22C26N1121Y25R2B427924224B23S24F24E23O23M23N2AY24H24I25624O28F29C24223S23N24B2BO22522M1H1923W2BO27C21P26Q2CT25628D2BF27C24P25424G2AT29I2EB24229F24O25125R25J27C24224224J24O2562FH2FJ2FE25P2FN29V24K25B28P2EA2FV2FG2FX2FZ29R2FF24K2552EO2FK2FM2422552B628724Q2F127926O2BS2BG24S2AJ2GB27923U29L24E2EO25724K24U24O2GI25P26R2BS2DQ2D12AS24H2GW28124O24P24E2GE25B24S29K25R25C2DR28D2AR24P23K24I2FA27S28P2FL27924A24O24S25927Y23T2AL2A52792AR2582542FY27T25F27C2HT2HV27Y23Y24I24I24H24P2EM24J2GZ2441D25R21X27C23W24H24S25A26926L2G826L2HV2592HU2FZ26L2552F72J124L24O2J429624O25A26L24I24R2IW24Q27Y25026L28D2572J624V24O24R24S2A329O26L2AJ2IT24S24J24P2J42J62AH24J25A28124K27Y2JA27X2542FZ2B82J729724Q24L2JS2JH2JM2KA28E2J62FH25A24U27J24V2AM2JH2FI2KN25424U24K2K328826B25R24927C26N23O2552IU2JA24J24I2L52J52J82JA2J22812JS24S24M2J624L24K2852952502IT28U2LA2LL2HC2JH2LE2L528I2LI2JA2LB24I2J926B26N26L26826L23R28O2AS2KE2HB2JP27K21K2BO21Z27D2MI2MJ2MK27926727D2BO2MN25P27B28M2MM27928M2DF26L2MV2CS27C29C2AU2DF2MM22225P28B29Z25P2MY2N72NC2BM27C2MQ27G2FU2MQ27V2G12MQ29I2N92MQ2B42932MU25P2932DF2MQ2FL2HR25P2MQ25I25P2O12NS2AF2MT27D2HH2ML2NB2I72NR25P2AF2NE25P2I72622MR2OJ25L25927C2OI2MS2AP2I72BO26526E2NT2OD27C2I72BM2I72I728M27B2BL24B2ML27E2AP25E25P2DF25N2I72652NC27B2D62P52792FU2MI2PI25P2P92MK2PM2O62MI24025P2DQ2OY2MI2672BU2MN2O825P25N2292NZ25P26M2OJ27B2OL27C2Q727B26L25T2Q52OC29C2PY25P2662OG27C2Q32QK25P26I2Q82N72OM2792QR2QD2QF2QL2OC2PW2QE25P2612OV2792QI2BU2602PN27C2R226325P2FU2BA2R22OI2G12PE2BM2Q42OI26B2QS2QA2792RO2QX25P2RI27C2H32NZ2BU25X2Q527926L26Q25P25W2RE27C2QL2S227925Z2S72792R42SA25P25Y2SD25P2R92SG2QF2FU2SL2S125S25P2RD2SG25V2R52RU2RB27925U2SJ2S02MI2DQ2T027A27D2PT2MN2OI2MK22U2QP2RK2PX2SE2S52NF2792R92SC2NS2RD2SI2MI2QL2ST2N02IO2R325P2TE27D26725B2SK25P2QF2MM2TZ2RD2TL2NZ2TZ2OI2TO2792482TU2TA2TS27923W2U02TW2NF2U425P2SR2U32SX2U62TY25P2S02UA25P2UC2R92T22UF25P2UH2RD2UJ2UO2OI2UN2U72US25P2UQ2TZ2S62UU2UC2RD2S62MZ2TT2OI2V32V72S02SV2UO2S62VA2V92SH27D2UC2OI2U62PR2UH2S02VK2UR2S62VG2V72SC2VQ2SI2VD2V82UA2VX2TH2W02TZ2SC2V62UR2SI2VQ2QF2W82S62U22UZ2UH2SC2WD2VS2W32UR2QF2VQ2SR2W82WF27E27D2UH2SI2WR2QF2T52V72SR2VQ2SV2W82SI2VN2WO2U12TV2MK2UR2SR2NB2V72SV2VQ2T02W82X52X02TT2SR2WR2SV2X62UR2T02VQ2MY2W82XJ2XR2UG25P2SV2WR2T02XK2UR2MY2VQ2BU2W82SV2BU2VH2Y42T02WR2MY2WT2TZ2BU2VQ26N2VS27C2UC2T02YQ2YH2V02NA2XG2MJ2UR2BU2YG2V72YQ2VQ2Q72W82MY2Q72YW2UH2BU2WR2YQ2Z32UR2Q72VQ26H2YR2UB25P2BU2ZK2ZB25P2YQ2WR2Q72YM2DG2VR2UO26G2ZL2UV2ZR25P2ZZ2ZQ2Q72WR2ZK2ZV2ZZ2VQ26J31002UC2Q7310C2ZQ2ZK2WR2ZZ2WG2TZ310C2VQ2QR2W82ZK2QR2ZQ2ZZ2WR310C2ZV2QR2VQ26D310D310325P31102ZQ310C2WR2QR2YV2V731102VQ26C3111310C311D2ZQ2QR2WR31102ZA2V7311D2VQ26F31112QR311P2ZQ31102WR311D311L2UR311P2VQ2OU2W831102OU2ZQ311D2WR311P2ZV2OU2VQ2693111311D312C2ZQ311P2WR2OU31192UR312C2VQ2683111311P312O2ZQ2OU2WR312C2ZP2V7312O2VQ2RO2W82OU2RO2ZQ312C2WR312O311X2TZ2RO2VQ26A3111312C313C2ZQ312O2WR2RO313825P313C2VQ2713111312O313O2ZQ2RO2WR313C2ZV313O2VQ27031112RO313Z2ZQ313C2WR313O2ZV313Z2VQ2733111313C314A2ZQ313O2WR313Z31042V7314A2VQ272310022S25P313O314M2MK26O2S12BV27D23V2QP2ML2QJ2R4310G2NA2QF2R92FU310S2Y42RD2SF2MJ23S2U02O62WB2V22XH2U82XF2UO2S02VQ2VC2VT2SS2TH2YH25N311D2R91H2OJ2RD2RQ25P315V2BL24P2QP2GZ2RY2U02Q12QO2R921B2RP2QU25P316A27B2QJ2R931142Q22DQ2R92102OJ2R6316C316M27B2PC2U027G27B29Z2PM2OE2MJ2PM2VK25P2PM2OC2PL27C2Q131752NS2PX23X315D2RB315425P2RJ2QN2Q42R91Y316B27C317K2RT2R92G12RX25N316K25P22N25O2BO315Y317V316R2DQ2QL23P317W2N1316C3183317O317F2RW2NF2R42RD2PR2792VJ2XH2792S02XW2792VP2TI2VR2UU318F2ZX2MJ24C2U027D315F2YZ2PX315I2Y92TZ315L2UK2TH2W82VF2Y3315S2U025E3184315X316C319A316F2R82UF317S2U025F3184316O2OX3184316G2UZ2TC315G2Z0318Q2WT318I318R2MQ315N2MI31962YH26L24N315P2TR2S92VL25P311G279314O2RD2UY2MI27V2SP2T6319M2BV2Q9316C319K316F2TZ2R9311S27924S315P2RX2TX315I31AR25L2782R923V31842R22S6317Q27D2512VR2RX31AE2792X3318H2XF318K2UM319X2792XA2MJ2XC2ML318T2W32ZQ2WQ315H2VS31902XF2WW31112WZ315R311D2S627031842SC315Y31C22RT31B5318A2MV2AP2SC2BA25P21V2VS2W02792XQ2NS2X8318N31BK2MI31BM2MK31BO2MI2WB31BR2Z02TZ2SI31BU2WV31932WX315O31BY319H31C025P31B227B31C4316C31D731652S62O6319I2S626Q319L2QT27C31DH319F2TH2PR2TC31CU2TF2WS318N31CZ31CK31002SB31BH31A231A42W52S831932QF31AA25P314O2SC2WN31AF315Q314V31AJ25P31C631DJ27931DL31EG31D6318425L2UH27921E21E28M2QO27923Y25O2AP31EP31EM27C31EP31ER2Q427923S31EV25P31EP25N22I2S8318431EX2FL2R926631EL316C317Z2V731AQ27D31AT2RD31AV31932OI31AY31B025P22K31B32QF31C82792TE2QJ2SC2PR315C31DD2Y331B431EB312427931DP318X2TX31BC2ZN31DT31BI31BH318P2VR2V631DE31D524R31C331EJ31GN31DM31G42BM2DQ2S62GY317X316C31GW31DC319Q2VR31CH31DS2NS31DU2SQ31DW31GJ31G531E0318R31A72WU31A927D31E7315J2MJ27V31BP316N31EJ24A31FG27C31GZ31G6317G27C23U31B927C31AE31G32UF2O631G62W331G825P31GA31H32SI2ZG31CI31GG31D12MI31D331GL2TH24X31GO315Y31IH31C7318931FY2P72VR2PK31HZ315E317D2TH31I327D31I631BE31I831GF2UQ27931IC27D31IE2QN31D531FU31D831EJ31J831H031DE31GU25P21Z31DI315Y31JG31GR31H131DQ31GC31H42S131H62MQ31J327C31J52S231HB2U631HD2TZ31E431HG2VR31E927D31HK2MI31GX27C31IK31EJ31JJ31JA31EL31EN31F631EQ2Q231F231CE31F531EX31KE31F031KH27C22L31KK21E31F827C23L31FB21E25L31FD25P31KV31882FU312F316J2U022Q31JH316C31L731AO2U031AR25P31FM2PU31BS31FQ2N131FS22R319O2BU2S62PO2Q22I72SC2B42PG2792PM2PK27D2PM31FO27C2PM31BB27C312O31GS318R31DF25P22O31L827C31MA31DM2SI31DO2XF31H32SR319V2Y531GG2XO2MJ31CJ2UF31A32XF2WN31JY31ML31E5314O2QF2XD31EA318P31K727923031HP27922P319L2462V82ML31KY2U022C319O2TZ2QL2BO316S2R42932MS31LV31E22PP27C315A31K42I72R92FL2P331NN31792MI22L315P2P631O02UE2MK31O031M331IO2S62O327926S318R2OF2YZ2SC312R31EB2RK2SC313331OI31DX313F31OM2VR313R31OP2SC314231OS25P314D31EB27C31N127C2RK2SI31OX31MK2QF2MQ27D2SR2TR2MK31CN2ML31MY31EC316531P62X131BH31O431PI31PC2MI2RO31PE31AI31PG314U2YX2SR31O72YX31PM27D31PO31ML31PQ316S2QF2AF27B2NR31LW2ML2PM31P7317831IM316Z31C931QD27931PA31LY31JT31Q82QN31QK2792PW31QB31NR31PI2SR31K327C22C31BH2BO2F131N931A72MJ26J2XD211318431AL27C31R431DM2QL31JD2QP21631MB27931RD31R931MQ2QF2R431P7314R2NA31A42R4315A31MU2RD31MW2TU31QH31QL31R031HM315Y1G31N525P31RG2NZ317B31NM2MM2BU2QL26X2RB31A42QL31A726W31IT2R931P726Z315O2QL2SP31I12QY314Y25P26Y2RB24G2QP31A726T2SY31SU27C31OC2NS2R426V2MJ31FE2P62TU31IS27927123P2TU26U27C26P27D31OA316425P2Q12BO2AY28S28U28927D24Y31T627931TH31TS31I029C2FP25127M315723L2HU2LI2JX23Z29527Y24K28S26L25727126B26Y26L25A29725B2GX26V26L2EL24S24P2852GG317731PK319T2N02GZ2N431NB2ND2MI29C3189316R311D2NK317L27931LT31ET25P27G318E2BM2242N0316U2N0315Y31VG25P312C28M31VC31V931VM2ML31TU2MJ2PR2O62GZ2F331TM28T28V31CD316I31TV2P62XK31K631W22ML31TI2MO31TV29C31VV31DH31W72MK2GL27C24V2502G9312W25P31TR31T62UR2P231932AP2O625F2262N02R431N22TU27B31WU31WW31V631WZ2NA23131UZ2792MX31X631VJ2PA2QN2IN28B31Q431VA31EJ31XG2NC2AP2DF2PR2332Q231V02RB27G27V2BA31UX2S72BO2N92NB29I2FU2MX2MZ2O631XV27B31LX2MK31CD2N127D2AP316R31P72OO2OK316C31YF2YX31PQ27D31X128M2YQ31WY31YO31X531X731XC31QN31WV28M2SR2Q931EJ31YX2R631XC31XM27D31XO2N931Z12S222331XH2N92MX22D2N031Y431PI27931Z631852ON316N23Y31XC31VN2O231PF318V31K431IO2842BJ29C2B228E31TI2GI21924I23X31WC25R31192492LK2LZ2IR26L2L826L2IY25B2A925B28I27Z2KK2FC29W2L52EL24H31OO2SJ31TS31XV2MJ31V12MI2NB28B31WB2MJ31ZI27D2NB27G2N931VC31Y931JN29I2NV31V731UZ2MQ2932N928X29I2PE2BL2UH2O132112Y42AF2NY2MI315C2O131T827921Y31XP2NY31OA25P321V27V31OA2NY31NC29I2O1321J2S731VN2UR2B431Z631AT3174318Y25P2FL321F2782B4311D2QD2SI2AF31OA31Z62ZK2AF316Y2BO2NB322S27C32112HH31W82QM320V2MI31LP2P62PE321Y2MJ2DQ32372MI2I72RX2PR31HV2I72BA31QO2Q72P9323227D2PE31Y727D2DQ316Y318H323R2MJ2P931P7323E2RA2BA32342UC2HH31LP323X2HH2BA3177321V2AP31OA2Q131NC2B42RD2BL24J318931ZO2UH2NU2ML24R3189322E27C22031QC2MK31VR2MI2N42NY31ZZ2MJ31VW29C2552502IY2AY25426U25Z22926D2GI2BQ2BS2Z32BW2BY2C02C22C42C62C82CA2CC2CE2CG2CI2CK2CM2CO2CQ2CS31TX2FI2822AQ26B25J22C26M23L2G62BB2K12EO2F827931WI2G924431TQ31TV324G3230318D31T627V2GI2F131O0326G2UZ2MJ314T326K319331WQ27C31AT31YC31BS28B2O631AZ2N0313O31DM27V2N431HV29I31XX27D315C27V321T25P324G327731BS2B42QI2TZ321E31932FL31CD2UC29I2NY31IF27V2OU31Y631EJ327T316527V2PK327631HM31Z6312C2B42G127D315Y311031DM2O12N42UH321O2ML321R31I027D324G31XJ322F2HH2NL2TZ2I72NO2TZ2P9327N2OW324331J631ZP32882OW3287316N324G321S2MK2R22O131OA3174328I31YT2MJ2UH2HH321P31PY31ZP31TK2QN31VE31K531NM315Y2S631R631T9329031XP31VN2R231XT27C32972S7320T25P31HV31V831ZH329E31V531PQ31NC28M322631LQ2UF31LU25P22H31YA2MK32AC2YW27D32AF31HM31NS31XC31NW2MT32AI323L32AB31ZQ319328B2F131AT31XB31AW329Q31LJ2NC24A2OJ2QJ2B432752OV2BO31IQ324H2Y3327D32B631BS2FL327I31ZP328P2OW328S293316Y31IF2B423R2OJ293315Y32BO32272B431ZO31HV31NL27C2PK22E32B932A4316C32B131DM32B427D32BW31HM32B832BU32BA324G32BX31CV322G31QC2UR321L31932AF32BJ2OW31BZ318932C42OV315Y32CQ2YX32C62MK32C832B727D32C032CB32A432BE25P31TF2BL324T31CS27C32BL2G12GE31UQ2B8324X2MI324Z27C29E2JW2AY27I27K27M2X625427325S22626D25I25925M21D2122181S23821V24U1F2251L26A23S21I25U24N2631Z25N26B1F24P25H22T325A2BR2BT2BV2BX2BZ2C12C32C52C72C92CB2CD2CF2CH2CJ2CL2CN2CP2CR2AU2I12AS2EV2EX2EZ2D325N25R31U131U32H926L31U629624J31U92J631UC31UE31UG31UI31UK31UM24I31UO32DD28831ZM27C31WN2P62QJ31NW2TT31ZO31F32OJ321T31WP2UZ324G329X31AS31Z2326X3299327028M2S4324F31XP316426L22Z31XP2BA3232323O2MI32852ML3284322X31HJ31QC31RB27V32GI31ZJ31EH32B22BU27V31Z62S629I3229321B2BA321D2SJ2NW324R2PJ32CG31DZ2S72FU2OC2UR293321P314O29I324O2NE31Y92MP32H531XH27C32H8326O2NS2B431OA32HD2NI2792FL32GT2S7327Q31SB32HK329U319332HO31K132HR2ML329T31W931ED2DQ327332HX31L527V27831WY32IR327X32IO2TH32H931BE2B432HC27929332I532CG32I8327P31HA32IC32J132IE32HI31AB2S732HS32GO31W531S731XP32H7322832IY31ZP2NS32J2318N32I72MJ32J632HJ31Y032ID2UO32IF27C32HQ2SW31EA32HU32H225P310C32D632AR2R62FL28M32CE314X32G425P31ZM31VP324S32K732AJ322T31WE32DG2F43250325227T2BA25B325Z326131KV2MI325B32EN27A32EP325G32ES325J32EV325M32EY325P32F1325S32F42N932DM27L25R32DP32DR32DT32DV32DX32DZ32E132E332E532E732E932EB32ED32EF32EH32EJ32F52D432F72BP32F923W32FB32052I82J32FI320M24H2JH2KJ26L2502972J125B2502KA2GE31UG24O24O315C27C23Q31TS2MQ32G231ZR31TS32KG31DR31WS32AD27B31ZM31DM27G2N4324G321732C732JF31Z732G531VB32CC32GK31BS29I32BF322B32JA328S27V2OC31IF27G32MY31XP315Y32NL32BB321M31HU31ZA32AD2Q231AA32NL27G32NN32H431XH2PK2S6326J31BE29I2NL321B2NO32J9321732NH32J732IJ2SW322A32JB31E631XP32I82NE31ZI32HV32O027D32O232AJ318N3225318N32NE32JN31XP31EA32NI32IB32OD32HM2TZ2B432HP32OI32II32IV31RY316C2R932MZ2SJ319I27G23Z32P827C32PF32PB32O132NA31UU32O532OT32IO32HD32OA2SW31I131A432P0319332P331K132A332GX32OL2NF2BU2NH32OO32PL31DR32OS32I132PP32O932GX32OY31JV32N532OE32P232OG314O32PZ31EA32Q131ED311P32K631YK2N131NV32PL32D731ZQ31TL2L12792L32L52LL320B2L92JI2EO2M12LD2J32LX2LJ2LS2LN2LP2982JI32RB32ME2J42LF32R92LZ32R52M22M42M62M82AH2592MB27P2H624J2PR32FZ2P632QU2MK31TL31O02UB2BD32MD24K32FG32MH2FA2FC26L26Y26Y24R2542KM28129526925C25J23Z32RE24O2JK32RH2992JT2IU2L527I24I2JK2JX24Q2AR2H832KS32SL32072J627X31UA2AR28I29A2JX24I24V2KM2K82J62JV2JX2GE28V24L32SK25J23T2JN32MF2882IW2A32IW2552G92FC2552IS32RI2L5256320A29O2KC24L2KZ326D31TS32S031VS27E29C32SA2AT2XD23S25124U32SG2J62AJ31UG2FY2IT2J232R12LL24J26I2L524D24E24826B328522M31W631T631W432IK31W9323032MT32S131HM31ZO31VU31TG32KI32D832QQ25P31VW2N931TN28V2PK24I32V331W332KL32VP32VF32V62F132UB2MI321532LB28725532042DF2AR2DY32LY2EY32M02FU2AH2J22ID24M31QO32RY2XH2BU32MQ319I27B328J315Y31XG32G132AJ324G32G42R232MT32PT31ZE27C2NV2TZ320Y31K128M32AP32O332V6315Y31NW32WM316N32VW32V632M22HS32M425132M632M82AR32MA32MC28632TR24Q2J124I32MI24O31V132WF2MK324E31T6324Q323032X927C31L42E92FM2ED2EF2EH2EJ2N92EL2EN25B31642BS2FU29K29924J2A92CT2AD320431OA32UK25B2AR27L32RV2GY2MJ2612BS31OA32YQ28S32DJ2H931TI25R316Y32WA2AJ27P27P27R27T32VZ32DN2GZ25X2BS32W332LX2792EW32W72CT2FI2G82GZ25T32032MJ26L32ZO2MI26N32ZR27D26H32ZU27C26J32ZX27926D330025P26F31WG2792F62812GZ269330326B3303271330625P32UF32DL2A224H2GZ270330327333032722BS2OC28629W28T29W29Y28H2812B22GZ26X330326W330326Z330326Y330326T330326S330326V330326U330326P2BS2W323V29T24J2LU2J324K32XP32XI25432R42AR2252BO24H32VS31BE32MQ2X032KD32GB2NB31XL32BA31Z1323032MV2YW324G32AT32932QF32WZ31X8328V2AP322Z2NC315Y332L330H32KI316S2DF32AA2PM2P632AI31ZO32AI31TI332D32I03153332M32NT2QO28B329M31YG32HY329P326Y332F333332A131GT2NC1M32PG279333H316R31KI31HV32X6316C333N2V728B31CD324G32N02ML32AV32P72UO32OD327028B315C32BT32992MI24531V231G52QF32GV32HH31HQ2OV329R32J92QH2MJ2FL32GB32CG2NY31Y732A732ZP31TT32JM32HG2OV31OA31SN32CG2OC2R031SW2FL334332CG315Y335125N22A32CG3351327H316C33512QJ3295328H328Y2ML324G2HH32NQ2RO2O1329G32JH2O1323R329832GL31Q332CN31TJ32IB322W31QN31932I73234314O2AF31QO31ZS323731WY314M32GJ2O132N33294334R2TW31QV334O333I25P31TD329N25P335131EY31EO31KG31ES25P32PF31EW31KX31KM336O31KI23T31XC31F731F92SA27B31FC2NC2MY336J2OM318027H336G3377333R32OW279333U334531FL32NS32CF334027828B32VO3344329X334732A032G9334E32932272OV2OC3211334J31T62NX32BY2MJ336F3212334Q31OA31M0293334U31PI2FL32HS25F334Z25P337N3352316C338H335532CG338H335928N32NZ335D27C329832AP335H333Y2RR329F31PF335C335T32BB328J3212335S316Y31P731MR335W2QM2UO335Z31K1336232P6336532K324T333827924L339J338G2OK336U31F127C331Z336S336M31KF339Q337E336Y31KS337025P23N2OJ337328B33A2337827922T336G33A931LB333S335E333V2MK333X321M2UR337K2NC32GN32GJ32D1320W337V334B333Y324K2P62932OC31Y732QS334P334L31NO27D32PX332C32BC32ZP2QF33AV31NQ328V2B421T32BP31EJ33BC33AN33312R233AR32152AP32CE339X33AY320W2QF33812TJ315O33B3337S33BM3394337W27C2TR31982B433AM32CR316C33C332B3334R32BB32BQ335G32CG335J3189324W32Q23189316Y319I2B4335631WY33CL339X32CV2MJ31AT33AR31K42IN29I33CN338O27933CN33C7335P33B533BP33BY318Q32QE33B8335X2UO2O13360334T32P632GT31WY326M31EJ33CN315Y33C3339U31KN336P232339Y33DL336V27C2CR336S31KT330733A331KX32D3256339M333K337C333T31XH329X33AH31BS33AK28B1N329P33AO33BX33AR31V132CD337G32NR33D7320R315C33AO334V33AR31AE33EH335R33D431EB33C125P1D33BD315Y33EX33BG329R334A31QC2N233BL2UZ33EM328G2S233F32G133EQ33D233BX33EK2U633EV33EB31Q531EJ33FJ316532I2335E33CA2MK324G322H2ML2RO33BU32OM2B433CI2DQ2B41U336G33G233BG33E6318932OJ25N33CU25P33G43189315Y33GC33D033FP32OQ33FA33ET2UA31MR33EK2PW32CI2RA32JY33DC31Y832HG31WY19339M33GC315Y33FM33DQ339W25P1Q33DP339P31KO2791K339Y33DV31M933DX31NC28B22O333A31W3332G31UZ2WN319I28B21I336G33HO33AC337D32NP33EI32GC321433E8337D334125P21J32NZ2B42V6316S324K32AA32AI332V32WW31QM320R27D312O33AO2OC33CJ25P21G336G33IJ31DM2FL321Y329131YS338S2OW33CD2FL32KK32JH33IU335E338431IT338R31Q031RN31ZP31OA33GO2TZ324231K1335L32P6329D31WY21P339M21H316N31N932GR2N732D321533HH33F2333D32IO33HM2UM31RE33JS322728B337P2PF32N932N832ZP31T333HW333E2S132OD338232GL32HH2FU2X632GW2FU2PR32N233IC31QU32Q631NI31XE33JU31XH315Y25S31LM31XP33IO2S7338U318933CD32PZ2F133KF32OJ25P31QV32X3336G26433KP27V33FZ31XP33KO31WY33L932IU33D1327F33B632J82YY32QE32JU33D82V729333DB32IH33GT32K231ED267319L333033JO332H31GE333F28B24Y33JT33M033A725P24D33JT33M532GJ32AP2NA2L133LW311932GW334F337I333Y327B329332HT27C2Z333K733MJ33LG311L33KC32BA334731XB33KE32Q633BX32OD31WL2UC33AD33B433K033D333K333LX27933MT32VB335E327Y2ML33L131HM33KX33HS320W31TD32OD33MD32HH32NQ321B33K833G727C314I31QL2G131DE33KK33M232NM316C33NW2QJ3221335E32NC33CB32OU2MJ2RO33KW33NA334S27933ND31QX32K331EU32IN33L727V33NW31ED33NZ32HW33LD33GI333233LJ32K432IB33OQ33J62OV33LN32K031ZS33LQ31EJ23T31S133OJ33LU329324K33JP323233N3338533MG33MM2NE33NO32OD315731YA2BA33MV32AW31IT33N531W131HV33LW31Z63347332E33N233HI33MG33MD2UH32742ML334733L2334V32OD2PK327E33OO2R233OQ31E52UC32Q433B433NB2MK33OC31ZQ33KF2O933NI337D33NK33KS31T6337R33PA33AR31LD2NE33NT31XD31XP33NW32NX33NY33L533C833Q533KT33O531PN32P531YK33KY33NC33KI32K325A33QZ33OH31WM33M133RC33O233Q62SN2SJ31G831MR33OT32JA33OW32JE33K6336G32W132QP33OO31UZ33PI29C32YJ31WF2GZ25H32YC2A632YF2A92GZ2652BS2532L2320732R12KN2HU25532TG32FP24R2G92FP2JX24G2JH2J528E2L52JC31UG2GE2FP26B26L24E2J526L24P32S72JX32TI26L2FR2J2331V33T033T22KF31UM2IR32U228E24G26L29N24O32RV2BH33TH2952JI2FB2JV2G82502M32S32M72M932RS33SX32RU27K31NR32XS2MJ324G326I2RX32WL316C31XJ33U433Q621S32VA2NS31S631ZR33MF32MT329X32KD31T631V131NH339X32VH2NA31SJ320U318N33UF332333MO32MT32NQ33UK31T632XY31PQ2CT31ZX28F32U933V032VT31PF33V32HJ32RX31TV33V131TW2F92FB2AT2BA2512A12JP24H32V1332033AZ2MJ2GZ332232UC32KD32MQ32VC31ZQ33VE',{},40,2^16,{},"\115\116\114\105\110\103",'',string.byte,string.char,string.sub,table.concat,(math.ldexp or(function(a,b)return a*(2^b);end)),(getfenv or function()_ENV['\95\69\78\86']=_ENV;return _ENV end),setmetatable,select,next,math.floor,string.format,(unpack or table.unpack),tonumber,table.insert,string.gmatch,tostring,type,_VERSION,pcall,string.match,string.find,(debug.getinfo or debug.info),string.len,rawset,string.gsub,math.random,(table.find or function(a,b)for c,d in next,a do if d==b then return c;end;end return nil;end),rawget,_G,print,setfenv);end;
    end,
})

local AutoAttack = dungeon:CreateToggle({
    Name = "Auto Attack(M1)",
    CurrentValue = false,
    Flag = "Auto Attack(M1)", 
    Callback = function(Value)
        _G.AutoAttack = Value
        while _G.AutoAttack and task.wait() do
                local user = game:GetService("VirtualUser")
                local player = game.Players.LocalPlayer
                local mouse = player:GetMouse()
                user:CaptureController()
                user:ClickButton1(Vector2.new(mouse.x,mouse.y))
        end
    end,
})

local KillAura = dungeon:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "Kill Aura", 
    Callback = function(Value)
        _G.KillAura = Value
        local player = game:GetService("Players").LocalPlayer
        pcall(function()
            while _G.KillAura and task.wait() do
                for i,v in pairs(workspace.Mobs:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                    and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 15 then

                        local args = {
                            [1] = {
                                ["Direction"] = Vector3.new(0.19999732077121735, -0.13707752525806427, -0.970160186290741),
                                ["Position"] = v.HumanoidRootPart.Position, -- Use the mob's position
                                ["Origin"] = Vector3.new(-501.6357116699219, 65.80438232421875, -1992.13623046875)
                            }
                        }

                        game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.WeaponService.RF.UseSword:InvokeServer(unpack(args))
                    end
                end
            end
        end)
    end,
})


local AutoFarmMobNearest = dungeon:CreateToggle({
    Name = "Auto Farm Mob (Nearest)",
    CurrentValue = false,
    Flag = "Auto Farm Mob (Nearest)",
    Callback = function(Value)
        _G.Nearest = Value
        pcall(function()
            while _G.Nearest do
                RunService.RenderStepped:wait()

                pcall(function()
                    local plr = game.Players.LocalPlayer
                    local character = plr.Character
            
                    if character and character:FindFirstChild("HumanoidRootPart") and _G.AutoPickUp then
                        local humanoidRootPart = character.HumanoidRootPart
            
                        for i, v in pairs(game:GetService("Workspace").Camera.Drops:GetChildren()) do
                            if v.Center.ProximityPrompt and v:IsA("Model") and v.Name == "Drop" then
                                humanoidRootPart.CFrame = v.Center.CFrame
                                repeat wait() until fireproximityprompt(v.Center.ProximityPrompt)
                            end
                        end
                    end
                end)

                -- Check the number of mobs left in the dungeon
                local MobAmount = game:GetService("Players").LocalPlayer.PlayerGui.Main.BossHealthBars.DungeonTimer.MobsLeft.Amount
                if MobAmount == 0 then
                    repeat
                        RunService.RenderStepped:wait()
                    until MobAmount ~= 0
                else
                    local function findNearestNPC()
                        local character = game.Players.LocalPlayer.Character
                        if not character then
                            return nil
                        end
                    
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                        if not humanoidRootPart then
                            return nil
                        end
                    
                        local mobsFolder = game:GetService("Workspace").Mobs
                        local nearestNPC = nil
                        local shortestDistance = math.huge
                    
                        -- Find the nearest NPC
                        for _, npc in pairs(mobsFolder:GetChildren()) do
                            if npc:IsA("Model") and npc:FindFirstChild('HumanoidRootPart') and npc.Humanoid.Health > 0 then
                                local npcPosition = npc.HumanoidRootPart.Position
                                local playerPosition = humanoidRootPart.Position
                                local verticalDistance = npcPosition.Y - playerPosition.Y
                                
                                -- Check if the NPC is at least 30 units below the player
                                if verticalDistance >= -30 then
                                    local distance = (npcPosition - playerPosition).Magnitude

                                    if distance < shortestDistance then
                                        nearestNPC = npc
                                        shortestDistance = distance
                                    end

                                end
                            end
                        end
                    
                        return nearestNPC
                    end
                    
                    local nearestNPC = findNearestNPC()
                    if nearestNPC then
                        local player = game.Players.LocalPlayer
                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                        
                        if humanoidRootPart then
                            local npcCFrame = nearestNPC.HumanoidRootPart.CFrame
                            humanoidRootPart.CFrame = npcCFrame * CFrame.new(0, 0, 6) -- Teleport with an offset of 7 units above the NPC
                        end
                    else
                        print("No NPCs found.")
                    end
                end
            end
        end)
    end
})

local Toggle = dungeon:CreateToggle({
    Name = "Auto Pick Up Loot",
    CurrentValue = false,
    Flag = "Auto Pick Up Loot",
    Callback = function(Value)
         _G.AutoPickUp = Value
        while _G.AutoPickUp and not _G.Nearest do
            RunService.RenderStepped:wait()
            pcall(function()
                local plr = game.Players.LocalPlayer
                local character = plr.Character
        
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local humanoidRootPart = character.HumanoidRootPart
        
                    for i, v in pairs(game:GetService("Workspace").Camera.Drops:GetChildren()) do
                        if v.Center.ProximityPrompt and v:IsA("Model") and v.Name == "Drop" then
                            humanoidRootPart.CFrame = v.Center.CFrame
                            fireproximityprompt(v.Center.ProximityPrompt)
                        end
                    end
                end
            end)
        end
    end,
 })


local Toggle = dungeon:CreateToggle({
    Name = "Increase Mob Hitbox",
    CurrentValue = false,
    Flag = "Increase Mob Hitbox",
    Callback = function(Value)
        _G.HeadSize = 20
        _G.Disabled = Value

        while _G.Disabled and wait(1) do
            for _, x in ipairs(game:GetService("Workspace").Mobs:GetChildren()) do
                if x:IsA("Model") and x:FindFirstChild("HumanoidRootPart") and x.Humanoid.Health > 0 then
                    pcall(function()
                        -- Set the color to a light blue and increase transparency
                        x.HumanoidRootPart.BrickColor = BrickColor.new("Bright blue")
                        x.HumanoidRootPart.Transparency = 0.9
                        x.HumanoidRootPart.Material = "Neon"
                        x.HumanoidRootPart.CanCollide = false
                        x.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)

                        -- Update the HitPart with the same color and transparency
                        if x.HitPart then
                            x.HitPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                            x.HitPart.Transparency = 1
                            x.HitPart.BrickColor = BrickColor.new("White")
                            x.HitPart.Material = "Neon"
                            x.HitPart.CanCollide = false
                        end
                    end)
                end
            end
        end
    end,
})

local AutoHeal = dungeon:CreateToggle({
    Name = "Auto Heal",
    CurrentValue = false,
    Flag = "Auto Heal", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.AutoHeal = Value
        while _G.AutoHeal do
            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.HealingService.RF.UseHeal:InvokeServer()
            RunService.RenderStepped:wait(3)
        end
    end,
 })

 local Misc = Window:CreateTab("Misc", 4483345998) -- Title, Image
 local Section = Misc:CreateSection("---")

 local WalkSpeed = Misc:CreateSlider({
    Name = "Walk Speed",
    Range = {0, 200},
    Increment = 1,
    Suffix = "",
    CurrentValue = 16,
    Flag = "Walk Speed", 
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
 })

 local InfiniteJump = Misc:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "Infinite Jump", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.infinjump = Value

        if _G.infinJumpStarted == nil then
            --Ensures this only runs once to save resources
            _G.infinJumpStarted = true

            --The actual infinite jump
            local plr = game:GetService('Players').LocalPlayer
            local m = plr:GetMouse()
            m.KeyDown:connect(function(k)
                if _G.infinjump then
                    if k:byte() == 32 then
                    humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
                    humanoid:ChangeState('Jumping')
                    wait()
                    humanoid:ChangeState('Seated')
                    end
                end
            end)
        end
    end,
 })

 local ESPPlayers = Misc:CreateToggle({
    Name = "ESP Players",
    CurrentValue = false,
    Flag = "ESP Players", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        _G.plrESP = Value -- Set this to true to enable player ESP

        local function createPlayerESP(player)
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local BillboardGui = Instance.new('BillboardGui')
                    local TextLabel = Instance.new('TextLabel')
        
                    BillboardGui.Parent = humanoidRootPart
                    BillboardGui.AlwaysOnTop = true
                    BillboardGui.Size = UDim2.new(0, 50, 0, 50)
                    BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
        
                    TextLabel.Parent = BillboardGui
                    TextLabel.BackgroundColor3 = Color3.new(1, 0, 0)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.Size = UDim2.new(1, 0, 1, 0)
                    TextLabel.Text = player.Name -- Display the player's name
                    TextLabel.TextColor3 = Color3.new(2, 2, 2)
                    TextLabel.TextScaled = true
                end
            end
        end
        
        local function removePlayerESP(player)
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local BillboardGui = humanoidRootPart:FindFirstChildOfClass("BillboardGui")
                    if BillboardGui then
                        BillboardGui:Destroy()
                    end
                end
            end
        end
        
        for _, player in ipairs(game.Players:GetPlayers()) do
            if _G.plrESP then
                createPlayerESP(player)
            else
                removePlayerESP(player)
            end
        end
        
    end,
 })

 local ServerHop = Misc:CreateButton({
    Name = "Server Hop",
    Interact = 'Click',
    Callback = function()
        repeat  task.wait() until game:IsLoaded()
        warn("Rejoinning....") 
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
 })

 local AntiAFK = Misc:CreateButton({
    Name = "Anti AFK (Already Turned On)",
    Interact = 'Click',
    Callback = function()
        print("9")
    end,
 })

 local Credits = Window:CreateTab("Credits", 4483345998) -- Title, Image
 local Creditx = Credits:CreateSection("Credits")

 local JoinDiscord = Credits:CreateButton({
    Name = "Join Discord",
    Interact = 'Click',
    Callback = function()
        setclipboard("https://discord.com/invite/W2XyGrNQUe")

        JaninaHub:Notify({
            Title = "Copied Discord Invite!",
            Content = "huheuheuhh",
            Duration = 6.5,
            Image = 4483362458,
            Actions = { -- Notification Buttons
               Ignore = {
                  Name = "Okay!",
                  Callback = function()
                  print("The user tapped Okay!")
               end
            },
         },
         }) 
    end,
 })

 local Input = Credits:CreateInput({
    Name = "or copy from here",
    PlaceholderText = "https://discord.com/invite/W2XyGrNQUe",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        print(Text)
    end,
 })
 
 ------ ANTI AFK
 local vu = game:GetService("VirtualUser")
 game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
 end)
