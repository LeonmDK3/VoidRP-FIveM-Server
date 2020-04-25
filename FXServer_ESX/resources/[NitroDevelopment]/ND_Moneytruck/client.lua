
ESX =  nil

local pos = GetEntityCoords(GetPlayerPed(-1),  true)
local s1, s2 = GetStreetNameAtCoord( pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
local street1 = GetStreetNameFromHashKey(s1)
local street2 = GetStreetNameFromHashKey(s2)
local isRobbing = false
local hasRobbed = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:notification')
AddEventHandler('esx:notification', function(msg, color)
    ESX.ShowNotification(msg, false, false, color)
end)

function removeblip(Blip)
  if DoesBlipExist(Blip) then
    RemoveBlip(Blip)
  end
end

RegisterNetEvent('ND:Blip')
AddEventHandler('ND:Blip', function(x,y,z)
  Blip = AddBlipForCoord(x,y,z)
    SetBlipSprite(Blip,  477)
    SetBlipColour(Blip,  1)
    SetBlipAlpha(Blip,  250)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 1.2)
    SetBlipFlashes(Blip, true)
    SetBlipAsShortRange(Blip,  true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Robbery In Progress | Money Truck')
    EndTextCommandSetBlipName(Blip)
end)

function DrawText3Ds(x,y,z,text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('animation:rob')
AddEventHandler('animation:rob', function()
    local Ped = GetPlayerPed(-1)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    while isRobbing == true do
        if not IsEntityPlayingAnim(Ped, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end)

RegisterNetEvent('animation:hack')
AddEventHandler('animation:hack', function()
    local Ped = GetPlayerPed(-1)
    RequestAnimDict("anim@heists@humane_labs@emp@hack_door")
    while not HasAnimDictLoaded("anim@heists@humane_labs@emp@hack_door") do
        Citizen.Wait(0)
    end

    while Hacking == true do
        if not IsEntityPlayingAnim(Ped, "anim@heists@humane_labs@emp@hack_door", "hack_loop", 3) then
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "anim@heists@humane_labs@emp@hack_door", "hack_loop", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end)

RegisterNetEvent('ND:getReward')
AddEventHandler('ND:getReward', function()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)

    if vehicle == GetHashKey('stockade') or GetEntityModel(vehicle) then
      createped()
      pedSpawned = true
      TriggerServerEvent('ND:NotifyPolice', street1, street2, pos)
    end
    Citizen.Wait(0)
end)

function Timeout(hasRobbed)

    if hasRobbed == true then
        exports['ND_notify']:DoHudText('error', 'You have grabbed the loot and the truck appears to be empty go lay low for a while' )
        --TriggerEvent('esx:notification','~g~You have grabbed the loot and the truck appears to be empty go lay low for a while~w~', g)
        Citizen.Wait(Config.Timeout * 1000)
        hasRobbed = false
    else
        hasRobbed = false
    end
end


Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    local pos = GetEntityCoords(GetPlayerPed(-1))
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)
    local text = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -4.25, 0.0)
    local dstCheck = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(vehicle), true)
    local engine = GetVehicleEngineHealth(vehicle)

    if DoesEntityExist(vehicle) then
        if GetEntityModel(vehicle) == GetHashKey('stockade') and not isRobbing and not hasRobbed then
            if dstCheck < 5.0 then
                if IsControlJustReleased(0, 38) then
                    if engine ~= 0 then
                        TriggerServerEvent('ND:Itemcheck', 1)
                    else
                        exports['ND_notify']:DoHudText('error', 'Vehicle is disabled or already been hit')
                        --TriggerEvent('esx:notification','~r~Vehicle is disabled or already been hit~w~', r)
                    end
                end
            end
        end
        if not IsEntityDead(GetPlayerPed(-1)) then

            if pedSpawned == true then

                DrawMarker(27, text.x, text.y, text.z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255, 0, 0, 100, 0, 0, 0, 0)
                DrawText3Ds(text.x, text.y, text.z, "~r~[E]~w~ To Rob")

                if IsControlJustReleased(0,38) then
                    TriggerEvent('animation:rob')
                    exports['progressBars']:startUI(Config.Timer * 1000, "Grabbing Cash/Items")
                    TriggerServerEvent('ND:Payout')
                    Wait(Config.Timer * 1000)
                    finished = true
                end

                if finished == true then
                    SetPedAsNoLongerNeeded(gaurd)
                    SetPedAsNoLongerNeeded(guard2)
                    SetPedAsNoLongerNeeded(guard3)
                    pedSpawned = false
                    isRobbing = false
                    Timeout(true)
                    RemoveBlip(Blip)
                    SetVehicleEngineHealth(vehicle, 0)
                end
            end
        else
            Citizen.Wait(Config.Timeout * 1000)
            RemoveBlip(Blip)
            finished = false
            isRobbing = false
            pedSpawned = false
        end
    else
        Citizen.Wait(500)
    end
  end
end)

function createped()

  local pos = GetEntityCoords(GetPlayerPed(-1))
  local hashKey = GetHashKey("ig_casey")
  local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)
  local pedSpawned = false
  local pedType = 5

  RequestModel(hashKey)
  while not HasModelLoaded(hashKey) do
      RequestModel(hashKey)
      Citizen.Wait(500)
  end

  print('Spawning Peds?')

  guard = CreatePedInsideVehicle(vehicle, pedType, hashKey, 0, 1, 1)
  guard2 = CreatePedInsideVehicle(vehicle, pedType, hashKey, 1, 1, 1)
  guard3 =  CreatePedInsideVehicle(vehicle, pedType, hashKey, 2, 1, 1)

--////////////
--  Guard 1
--///////////

  SetPedShootRate(guard,  750)
  SetPedCombatAttributes(guard, 46, true)
  SetPedFleeAttributes(guard, 0, 0)
  SetPedAsEnemy(guard,true)
  SetPedMaxHealth(guard, 900)
  SetPedAlertness(guard, 3)
  SetPedCombatRange(guard, 0)
  SetPedCombatMovement(guard, 3)
  TaskCombatPed(guard, GetPlayerPed(-1), 0,16)
  GiveWeaponToPed(guard, GetHashKey("WEAPON_SMG"), 5000, true, true)
  SetPedRelationshipGroupHash( guard, GetHashKey("HATES_PLAYER"))

  --////////////
  --  Guard 2
  --///////////
  SetPedShootRate(guard2,  750)
  SetPedCombatAttributes(guard2, 46, true)
  SetPedFleeAttributes(guard2, 0, 0)
  SetPedAsEnemy(guard2,true)
  SetPedMaxHealth(guard2, 900)
  SetPedAlertness(guard2, 3)
  SetPedCombatRange(guard2, 0)
  SetPedCombatMovement(guard2, 3)
  TaskCombatPed(guard2, GetPlayerPed(-1), 0,16)
  GiveWeaponToPed(guard2, GetHashKey("WEAPON_SMG"), 5000, true, true)
  SetPedRelationshipGroupHash( guard2, GetHashKey("HATES_PLAYER"))

  --////////////
  --  Guard3
  --///////////
  SetPedShootRate(guard3,  750)
  SetPedCombatAttributes(guard3, 46, true)
  SetPedFleeAttributes(guard3, 0, 0)
  SetPedAsEnemy(guard3,true)
  SetPedMaxHealth(guard3, 900)
  SetPedAlertness(guard3, 3)
  SetPedCombatRange(guard3, 0)
  SetPedCombatMovement(guard3, 3)
  TaskCombatPed(guard3, GetPlayerPed(-1), 0,16)
  GiveWeaponToPed(guard3, GetHashKey("WEAPON_SMG"), 5000, true, true)
  SetPedRelationshipGroupHash( guard3, GetHashKey("HATES_PLAYER"))
end

RegisterNetEvent('ND:startHacking')
AddEventHandler('ND:startHacking', function(cb)
  cb = true
  isRobbing = true
  Hacking = true
    if isRobbing == true then
      print('started')
      TriggerEvent('mhacking:seqstart', 6, Config.Hackingtime, cb1)
    end
end)

RegisterNetEvent('ND:NotifyPolice')
AddEventHandler('ND:NotifyPolice', function(msg)
    --TriggerEvent('esx:notification', msg, r)
    exports['ND_notify']:DoHudText('success', msg)
end)

function cb1(success, timeremaining)
  if success then
    TriggerEvent('ND:getReward')
    Hacking = false
  else
    exports['ND_notify']:DoHudText('error', 'You failed to hack you need to wait 30 seconds')
    --TriggerEvent('esx:notification', '~r~You failed to hack you need to wait 30 seconds~w~', r)
    TriggerEvent('mhacking:hide')
    TriggerServerEvent('ND:NotifyPolice', street1, street2, pos)
    Hacking = false
    Wait(30 * 1000) -- add a time penalty if failed, so it gives police more time to arrive // feel free to remove
    isRobbing = false
    exports['ND_notify']:DoHudText('success', 'you can now hit the truck again')
    --TriggerEvent('esx:notification', '~g~You can now hit the truck again~w~', g)
  end
end
