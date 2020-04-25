RegisterCommand('ping', function(source, args, rawCommand)
	if args[1] ~= nil then
        if args[1]:lower() == 'accept' then
            TriggerClientEvent('ND_ping:client:AcceptPing', source)
        elseif args[1]:lower() == 'reject' then
            TriggerClientEvent('ND_ping:client:RejectPing', source)
        else
            local tSrc = tonumber(args[1])
            if source ~= tSrc then
                TriggerClientEvent('ND_ping:client:SendPing', tSrc, GetPlayerName(source), source)
            else
                TriggerClientEvent('ND_notify:client:SendAlert', source, { type = 'inform', text = 'Can\'t Ping Yourself' })
            end
        end
    end
end, false)

RegisterServerEvent('ND_ping:server:SendPingResult')
AddEventHandler('ND_ping:server:SendPingResult', function(id, result)
	if result == 'accept' then
		TriggerClientEvent('ND_notify:client:SendAlert', id, { type = 'inform', text = GetPlayerName(source) .. ' Accepted Your Ping' })
	elseif result == 'reject' then
		TriggerClientEvent('ND_notify:client:SendAlert', id, { type = 'inform', text = GetPlayerName(source) .. ' Rejected Your Ping' })
	elseif result == 'timeout' then
		TriggerClientEvent('ND_notify:client:SendAlert', id, { type = 'inform', text = GetPlayerName(source) .. ' Did Not Accept Your Ping' })
	elseif result == 'unable' then
		TriggerClientEvent('ND_notify:client:SendAlert', id, { type = 'inform', text = GetPlayerName(source) .. ' Was Unable To Receive Your Ping' })
	elseif result == 'received' then
		TriggerClientEvent('ND_notify:client:SendAlert', id, { type = 'inform', text = 'You Sent A Ping To ' .. GetPlayerName(source) })
	end
end)
