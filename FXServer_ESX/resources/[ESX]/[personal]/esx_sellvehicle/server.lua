ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('px:sprzedaj')
AddEventHandler('px:sprzedaj', function(target, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _target = target
	local tPlayer = ESX.GetPlayerFromId(_target)
	if xPlayer.job.name ~= nil and tPlayer.job.name ~= nil then
	if xPlayer.job.name == 'cardealer' or tPlayer.job.name == 'cardealer' then
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
			['@identifier'] = xPlayer.identifier,
			['@plate'] = plate
		})
	if result[1] ~= nil then
		MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@target'] = tPlayer.identifier
		}, function (rowsChanged)
			if rowsChanged ~= 0 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Sprzedano Auto: ~b~'..plate)
				TriggerClientEvent('esx:showNotification', _target, '~g~Zakupiono Auto: ~b~'..plate)
			end
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, '~r~To nie twój samochód!')
	end 
	else
	TriggerClientEvent('esx:showNotification', _source, '~r~Przynajmniej jedna osoba z tranzakcji musi być ~b~CarDealerem')
	TriggerClientEvent('esx:showNotification', _target, '~r~Przynajmniej jedna osoba z tranzakcji musi być ~b~CarDealerem')
	end
	end
end)

TriggerEvent('es:addCommand', 'sellauto', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('px:pojazd', _source)
end)


