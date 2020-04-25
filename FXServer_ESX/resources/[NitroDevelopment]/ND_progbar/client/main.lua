ND_action = {
    name = "",
    duration = 0,
    label = "",
    useWhileDead = false,
    canCancel = true,
    controlDisables = {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },
    animation = {
        animDict = nil,
        anim = nil,
        flags = 0,
        task = nil,
    },
    prop = {
        model = nil,
    },
}

local ESX = nil

local isDoingAction = false
local disableMouse = false
local wasCancelled = false
local isAnim = false
local isProp = false
local prop_net = nil
local notified = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("ND_progbar:client:progress")
AddEventHandler("ND_progbar:client:progress", function(action, cb)
    ND_action = action

    if not IsEntityDead(GetPlayerPed(-1)) or ND_action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            wasCancelled = false
            isAnim = false
            isProp = false
            notified = false

            SendNUIMessage({
                action = "ND_progress",
                duration = ND_action.duration,
                label = ND_action.label
            })

            Citizen.CreateThread(function ()
                while isDoingAction do
                    Citizen.Wait(0)
                    if ND_action.canCancel then
                        if not notified then
                            to = ND_action.duration / 2
                            exports.pNotify:SendNotification({
                                text = "Press <b style='color:red'>DEL</b> to cancel",
                                type = "info",
                                timeout = to,
                                layout = "Bottomright",
                                queue = "left"
                            })
                            notified = true
                        end


                        if IsControlJustPressed(0, 178) and ND_action.canCancel then
                            TriggerEvent("ND_progbar:client:cancel")
                        end
                    end
                end
                if cb ~= nil then
                    cb(wasCancelled)
                end
            end)
        else
            print('Action Already Performing') -- Replace with alert call if you want the player to see this warning on-screen
        end
    else
        print('Cannot do action while dead') -- Replace with alert call if you want the player to see this warning on-screen
    end
end)

RegisterNetEvent("ND_progbar:client:cancel")
AddEventHandler("ND_progbar:client:cancel", function()
    isDoingAction = false
    wasCancelled = true
    notified = true
    TriggerEvent("ND_progbar:client:actionCleanup")

    SendNUIMessage({
        action = "ND_progress_cancel"
    })
end)

RegisterNetEvent("ND_progbar:client:actionCleanup")
AddEventHandler("ND_progbar:client:actionCleanup", function()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    StopAnimTask(ped, ND_action.animDict, ND_action.anim, 1.0)
    DetachEntity(NetToObj(prop_net), 1, 1)
    DeleteEntity(NetToObj(prop_net))
    prop_net = nil
end)

-- Disable controls while GUI open
Citizen.CreateThread(function()
    while true do
        if isDoingAction then
            if not isAnim then
                if ND_action.animation ~= nil then
                    if ND_action.animation.task ~= nil then
                        TaskStartScenarioInPlace(PlayerPedId(), ND_action.animation.task, 0, true)
                    elseif ND_action.animation.animDict ~= nil and ND_action.animation.anim ~= nil then
                        if ND_action.animation.flags == nil then
                            ND_action.animation.flags = 1
                        end

                        local player = PlayerPedId()
                        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
                            loadAnimDict( ND_action.animation.animDict )
                            TaskPlayAnim( player, ND_action.animation.animDict, ND_action.animation.anim, 3.0, 1.0, -1, ND_action.animation.flags, 0, 0, 0, 0 )
                        end
                    else
                        TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                    end
                end

                isAnim = true
            end
            if not isProp and ND_action.prop ~= nil and ND_action.prop.model ~= nil then
                RequestModel(ND_action.prop.model)

                while not HasModelLoaded(GetHashKey(ND_action.prop.model)) do
                    Citizen.Wait(0)
                end

                local pCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, 0.0)
                local modelSpawn = CreateObject(GetHashKey(ND_action.prop.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)

                local netid = ObjToNet(modelSpawn)
                SetNetworkIdExistsOnAllMachines(netid, true)
                NetworkSetNetworkIdDynamic(netid, true)
                SetNetworkIdCanMigrate(netid, false)
                AttachEntityToEntity(modelSpawn, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
                prop_net = netid

                isProp = true
            end

            DisableActions(GetPlayerPed(-1))
        end
        Citizen.Wait(0)
    end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DisableActions(ped)
    if ND_action.controlDisables.disableMouse then
        DisableControlAction(0, 1, true) -- LookLeftRight
        DisableControlAction(0, 2, true) -- LookUpDown
        DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
    end

    if ND_action.controlDisables.disableMovement then
        DisableControlAction(0, 30, true) -- disable left/right
        DisableControlAction(0, 31, true) -- disable forward/back
        DisableControlAction(0, 36, true) -- INPUT_DUCK
        DisableControlAction(0, 21, true) -- disable sprint
    end

    if ND_action.controlDisables.disableCarMovement then
        DisableControlAction(0, 63, true) -- veh turn left
        DisableControlAction(0, 64, true) -- veh turn right
        DisableControlAction(0, 71, true) -- veh forward
        DisableControlAction(0, 72, true) -- veh backwards
        DisableControlAction(0, 75, true) -- disable exit vehicle
    end

    if ND_action.controlDisables.disableCombat then
        DisablePlayerFiring(ped, true) -- Disable weapon firing
        DisableControlAction(0, 24, true) -- disable attack
        DisableControlAction(0, 25, true) -- disable aim
        DisableControlAction(1, 37, true) -- disable weapon select
        DisableControlAction(0, 47, true) -- disable weapon
        DisableControlAction(0, 58, true) -- disable weapon
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
    end
end

RegisterNUICallback('actionFinish', function(data, cb)
    -- Do something here
    isDoingAction = false
    TriggerEvent("ND_progbar:client:actionCleanup")
    cb('ok')
end)

RegisterNUICallback('actionCancel', function(data, cb)
    -- Do something here
    cb('ok')
end)
