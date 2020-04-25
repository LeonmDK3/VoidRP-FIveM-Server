local PlayerInjuries = {}

function GetCharsInjuries(source)
    return PlayerInjuries[source]
end

RegisterServerEvent('ND_hospital:server:SyncInjuries')
AddEventHandler('ND_hospital:server:SyncInjuries', function(data)
    PlayerInjuries[source] = data
end)
