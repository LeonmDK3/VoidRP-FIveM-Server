ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('px:pojazd')
AddEventHandler('px:pojazd', function()
	local PedGracza = PlayerPedId()
	local lokalizacjagracza = GetEntityCoords(PedGracza)
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local pojazd = ESX.Game.GetClosestVehicle(lokalizacjagracza)
		local lokalizacjapojazdu = GetEntityCoords(pojazd)
		local DystansPojazd = GetDistanceBetweenCoords(lokalizacjagracza, lokalizacjapojazdu, true)
		if DoesEntityExist(pojazd) and (DystansPojazd <= 3) then
			local ModelPojazdu = ESX.Game.GetVehicleProperties(pojazd)
			TriggerServerEvent('px:sprzedaj', GetPlayerServerId(closestPlayer), ModelPojazdu.plate)
		else
			ESX.ShowNotification('Nie ma auta w pobliżu')
		end
	else
		ESX.ShowNotification('Nie ma gracza w pobliżu')
	end
	
end)
