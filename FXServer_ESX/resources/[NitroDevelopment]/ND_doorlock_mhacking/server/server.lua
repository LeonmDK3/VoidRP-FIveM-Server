ESX				= nil
local DoorInfo	= {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ND_doorlock:updateState')
AddEventHandler('ND_doorlock:updateState', function(doorID, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		print(('ND_doorlock: %s didn\'t send a number!'):format(xPlayer.identifier))
		return
	end

	if not IsAuthorized(xPlayer.job.name, Config.DoorList[doorID]) then
		print(('ND_doorlock: %s attempted to open a locked door!'):format(xPlayer.identifier))
		return
	end

	-- make each door a table, and clean it when toggled
	DoorInfo[doorID] = {}

	-- assign information
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('ND_doorlock:setState', -1, doorID, state)
end)

ESX.RegisterServerCallback('ND_doorlock:getDoorInfo', function(source, cb)
	cb(DoorInfo, #DoorInfo)
end)

function IsAuthorized(jobName, doorID)
	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == jobName then
			return true
		end
	end

	return true
end



RegisterServerEvent('ND_doorlock:hack')
AddEventHandler('ND_doorlock:hack', function(mycb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	local cops = 0
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end

		if xPlayer.getInventoryItem('keycard').count >= 1 and cops >= Config.PoliceNumberRequired then
			xPlayer.removeInventoryItem('keycard', 1)

			TriggerClientEvent('ND_doorlock:currentlyhacking', source)
		else

			TriggerClientEvent('esx:showNotification', _source, _U('min_police', Config.PoliceNumberRequired))
		end
end)
