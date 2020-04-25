
ESX = nil
local TutkaEnabled = false
local blipsCops = {}
local wasOn = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('tutka:ShowRadarBlip')
AddEventHandler('tutka:ShowRadarBlip', function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		TutkaEnabled = true
		exports['ND_notify']:DoHudText('inform', 'Radar Detector Turned On!')
	elseif wasOn then
		TutkaEnabled = false
		wasOn = false
		exports['ND_notify']:DoHudText('inform', 'Radar Detector Will No Longer Turn On Automatically!')
	else
		exports['ND_notify']:DoHudText('inform', 'You Are Not In A Vehicle!')
	end
end)

RegisterNetEvent('tutka:RemoveRadarBlip')
AddEventHandler('tutka:RemoveRadarBlip', function()
	exports['ND_notify']:DoHudText('inform', 'Radar Detector Turned Off!')
	TutkaEnabled = false
	Citizen.Wait(1000)
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
end)

RegisterNetEvent('tutka:FRemoveRadarBlip')
AddEventHandler('tutka:FRemoveRadarBlip', function()
	TutkaEnabled = false
	wasOn = false
	Citizen.Wait(1000)
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
end)

function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then
		exports['ND_notify']:DoHudText('inform', 'Radar Detected Nearby!')
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 60)
		ShowHeadingIndicatorOnBlip(blip, true)
		SetBlipScale(blip, 1.45)
		SetBlipAsShortRange(blip, true)
		SetBlipFlashTimer(blip, 20000)

		table.insert(blipsCops, blip)
	end
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if IsPedInAnyVehicle(PlayerPedId(), false) and wasOn and not TutkaEnabled then
			TutkaEnabled = true
		end
		if TutkaEnabled then
			local playerPed = PlayerPedId()
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				wasOn = false
				ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
					for i=1, #players, 1 do
						Citizen.Wait(10)
						if players[i].job.name == 'police' then
							local id = GetPlayerFromServerId(players[i].source)
							local ped = GetPlayerPed(id)
							if NetworkIsPlayerActive(id) and ped ~= PlayerPedId() then
								local coords    = GetEntityCoords(playerPed)
								local coords2 	= GetEntityCoords(GetPlayerPed(id))
								if GetDistanceBetweenCoords(coords, coords2,  true) < 400 then
									local pveh = GetVehiclePedIsUsing(ped)
									if GetVehicleClass(pveh) == 18 then
										createBlip(id)
									else
										local blip = GetBlipFromEntity(ped)
										if DoesBlipExist(blip) then
											RemoveBlip(blip)
											exports['ND_notify']:DoHudText('inform', 'Radar Close To You Has Disappeared!')
										end
									end
								else
									local blip = GetBlipFromEntity(ped)
									if DoesBlipExist(blip) then
										RemoveBlip(blip)
										exports['ND_notify']:DoHudText('inform', 'Radar Close To YOu Has Disappeared!')
									end
								end
							end
						end
					end
				end)
			else
				wasOn = true
				TriggerEvent("tutka:RemoveRadarBlip")
			end
		else
			Citizen.Wait(5000)
		end
		if IsPedInAnyVehicle(PlayerPedId(), false) and wasOn and not TutkaEnabled then
			TriggerEvent("tutka:ShowRadarBlip")
		end
	end
end)
