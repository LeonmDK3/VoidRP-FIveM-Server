local ESX = nil
local time_out = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("ND__police-tracker")
AddEventHandler("ND__police-tracker", function(plate)

    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])


        if xPlayer.getJob().name == 'police' then
            TriggerClientEvent("ND__police-tracker:plate", xPlayers[i], plate)

        end

    end
end)

RegisterServerEvent("ND__police-tracker:setActivePlates")
AddEventHandler("ND__police-tracker:setActivePlates", function(plate)
    time_out[plate] = false
end)

RegisterServerEvent("ND__police-tracker:removeActivePlate")
AddEventHandler("ND__police-tracker:removeActivePlate", function(plate)
    time_out[plate] = time_out[nil]
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])


        if xPlayer.getJob().name == 'police' then
            TriggerClientEvent("ND__police-tracker:updateActivePlate", xPlayers[i], plate)
        end

    end

end)

RegisterServerEvent("ND__police-tracker:getActivePlates")
AddEventHandler("ND__police-tracker:getActivePlates", function()
    TriggerClientEvent("ND__police-tracker:getActivePlates", source, time_out)
end)


RegisterServerEvent("ND__police-tracker:triggerTimer")
AddEventHandler("ND__police-tracker:triggerTimer", function(plate)
    local xPlayers = ESX.GetPlayers()
    local startTimer = os.time() + Config.removeTimer
    Citizen.CreateThread(function()
        while os.time() < startTimer and time_out[plate] ~= nil do
            Citizen.Wait(5)
        end

        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])


            if xPlayer.getJob().name == 'police' then
                TriggerClientEvent("ND__police-tracker:updateTimer", xPlayers[i], plate)
            end

        end

    end)
end)
