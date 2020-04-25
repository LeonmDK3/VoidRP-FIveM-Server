RegisterNetEvent('ND_hospital:client:RPCheckPos')
AddEventHandler('ND_hospital:client:RPCheckPos', function()
    TriggerServerEvent('ND_hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('ND_hospital:client:RPSendToBed')
AddEventHandler('ND_hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetBedCam()

    Citizen.CreateThread(function()
        local scaleform = InBedTooltip('instructional_buttons', false)
        while bedOccupyingData ~= nil do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            if IsControlJustReleased(0, Config.Keys.GetUp) then
                LeaveBed()
            end
            Citizen.Wait(1)
        end
    end)
end)

RegisterNetEvent('ND_hospital:client:SendToBed')
AddEventHandler('ND_hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetBedCam()

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local player = PlayerPedId()

        exports['ND_notify']:SendAlert('inform', Config.Strings.BeingTreated)
        Citizen.Wait(Config.AIHealTimer * 1000)
        TriggerServerEvent('ND_hospital:server:EnteredBed')
    end)
end)

RegisterNetEvent('ND_hospital:client:ForceLeaveBed')
AddEventHandler('ND_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)
