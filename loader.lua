--
--
--
--
--

local httpService = game:GetService("HttpService")
local nebulaSource = httpService:GetAsync("https://raw.githubusercontent.com/Basscans/Nebula/infinity/Script.lua", true)
local f, e = loadstring(nebulaSource)
if e then
	Instance.new("Hint",Workspace).Text="Nebula has encountered an error!"
	Instance.new("Message",Workspace).Text=tostring(e)
	print('Error',tostring(e))
else
	getfenv(f).nebulaSource=nebulaSource
	f()
end
