--
--
--
--
--

local httpService = game:GetService("HttpService")
local nebulaSource = httpService:GetAsync("https://raw.githubusercontent.com/Basscans/Nebula/master/Script.lua", true)
loadstring(nebulaSource)()