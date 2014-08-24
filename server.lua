-- Server Framework --
local nebServ={}
nebServ.re = Instance.new("RemoteEvent",game:GetService("ReplicatedStorage"))
nebServ.re.Name="NServer"

nebServ.idleList = {}


function nebServ.OnServerEvent(client,...)
	local args = {...}
	if args[1]=='idle' then
		print(args[2].Name .. ' is idle!')
		if nebServ.idleList[args[2].Name]~=true then
			if type(args[2])=='table' then
				nilCmds(args[2],'afk;') -- Todo
			else
				cmds(args[2],'afk;')
			end
			nebServ.idleList[args[2].Name]=true
		else
			print(args[2].Name .. ' is idling for ' .. args[3])
		end
	elseif args[1]=='chat' then
		print(args[2].Name .. ' has chatted!')
		if type(args[2])=='table' then
			nilChat(args[2],args[3])
		end
	elseif args[1]=='getRank' then
		nebServ.re:FireClient(client,'setRank',getNilRank(args[2].Name))
	end
end

nebServ.re.OnServerEvent:connect(nebServ.OnServerEvent)