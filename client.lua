-- Client --
wait()
script.Parent=nil
for i,v in pairs(script:GetChildren()) do v:Destroy() end

local server
local player = game:GetService("Players").LocalPlayer
local camera = Workspace.CurrentCamera

function getRecrusiveChildren(model)
  local result = {}
  for i,v in pairs(model:GetChildren()) do
    table.insert(result,v)
    if #v:GetChildren()>0 then
      for a, b in pairs(getRecrusiveChildren(v)) do
        table.insert(result,b)
      end
    end
  end
  return result
end

local cache = {
  Player={
    Name=player.Name;
  };
  Rank=nil;
}

local idleEvent
local chatEvent

local pseudoCharacterModel

cache.Character={}
cache.Motor6d={}
cache.Weld={}

for i,v in pairs(player.Character:GetChildren()) do
  table.insert(cache.Character,v:Clone())
end
for i,v in pairs(getRecrusiveChildren(player.Character)) do
  if v:IsA("Motor6D") then
    cache.Motor6d[v.Name]={Part0=v.Part0.Name,Part1=v.Part1.Name,C0=v.C0,C1=v.C1}
  elseif v:IsA("Weld") then
    cache.Motor6d[v.Name]={Part0=v.Part0.Name,Part1=v.Part1.Name,C0=v.C0,C1=v.C1}
  end
end

function pseudoCharacter()
  if pseudoCharacterModel and pseudoCharacterModel.Parent==Workspace then return pseudoCharacterModel
  else
    pseudoCharacterModel=Instance.new("Model")
    pseudoCharacterModel.Name=cache.Player.Name
    for i,v in pairs(cache.Character) do
      local obj = v:Clone()
      obj.Parent=pseudoCharacterModel
    end
    for i,v in pairs(getRecrusiveChildren(pseudoCharacterModel)) do
      if v:IsA("Motor6D") then
        v.Part0=pseudoCharacterModel[cache.Motor6d[v.Name].Part0]
        v.Part1=pseudoCharacterModel[cache.Motor6d[v.Name].Part1]
        v.C0=cache.Motor6d[v.Name].C0
        v.C1=cache.Motor6d[v.Name].C1
      end
    end
    for i,v in pairs(cache.Weld) do
      local w = Instance.new('Weld',pseudoCharacterModel.Head)
      w.Part0=pseudoCharacterModel[v.Part0]
      w.Part1=pseudoCharacterModel[v.Part1]
      w.C0=v.C0
      w.C1=v.C1
    end
    pseudoCharacterModel.Parent=Workspace

    camera.CameraType='Track'
    camera.CameraSubject=pseudoCharacterModel
  end
end

print('Getting server.')
while not server do wait()
  if game:GetService("ReplicatedStorage"):findFirstChild("NServer") then
    server= game:GetService("ReplicatedStorage"):findFirstChild("NServer")
  end
end
print('Got server.')

function pseudoPlayer()
  local pseudo = {}
  pseudo.Name = cache.Player.Name
  pseudo.Character=pseudoCharacter()
  return pseudo
end

function getPlayer()
  if not player.Parent then
    return pseudoPlayer()
  else
    return player
  end
end

function onIdle(time)
  print('Firing server to do idle function!')
  server:FireServer("idle",getPlayer(),time)
end

function onChatted(chat)
  print('Firing server to do chat function!')
  server:FireServer("chat",getPlayer(),chat)
end

print('Checking context')
if cache.Rank<3 then
  pcall(function()
    if PluginManager() then
      repeat until false
    end
  end)
  print('Correct action completed')
else
  print('Player is allowed to have context changer')
end

coroutine.wrap(function()
  while wait() do
    if pseudoCharacterModel and pseudoCharacterModel.Parent~=Workspace then pseudoCharacterModel=nil end

    player=game:GetService("Players").LocalPlayer
    camera=Workspace.CurrentCamera
    pcall(function() idleEvent:disconnect() end)
    idleEvent = player.Idled:connect(onIdle)
    pcall(function() chatEvent:disconnect() end)
    chatEvent = player.Chatted:connect(onChatted)
  end
end)()