RegisterNetEvent('ND_hospital:client:SyncLimbs')
AddEventHandler('ND_hospital:client:SyncLimbs', function(limbs)
    BodyParts = limbs

	injured = {}
    for k, v in pairs(BodyParts) do
        if v.isDamaged then
            table.insert(injured, {
                part = k,
                label = v.label,
                severity = v.severity
            })
        end
    end

    DoLimbAlert()
end)

RegisterNetEvent('ND_hospital:client:SyncBleed')
AddEventHandler('ND_hospital:client:SyncBleed', function(bleedStatus)
    isBleeding = tonumber(bleedStatus)
    DoBleedAlert()
end)

RegisterNetEvent('ND_hospital:client:FieldTreatLimbs')
AddEventHandler('ND_hospital:client:FieldTreatLimbs', function()
    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 1
    end

    for k, v in pairs(injured) do
        if v.part == Config.Bones[bone] then
            v.severity = BodyParts[Config.Bones[bone]].severity
        end
    end

    TriggerServerEvent('ND_hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
end)
RegisterNetEvent('ND_hospital:client:FieldTreatBleed')
AddEventHandler('ND_hospital:client:FieldTreatBleed', function()
    if isBleeding > 1 then
        isBleeding = tonumber(isBleeding) - 1

        TriggerServerEvent('ND_hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(PlayerPedId())
        DoBleedAlert()
    end
end)

RegisterNetEvent('ND_hospital:client:ReduceBleed')
AddEventHandler('ND_hospital:client:ReduceBleed', function()
    if isBleeding > 0 then
        isBleeding = tonumber(isBleeding) - 1

        TriggerServerEvent('ND_hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(PlayerPedId())
        DoBleedAlert()
    end
end)


RegisterNetEvent('ND_hospital:client:ResetLimbs')
AddEventHandler('ND_hospital:client:ResetLimbs', function()
    injured = {}

    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 0
    end
    TriggerServerEvent('ND_hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
end)

RegisterNetEvent('ND_hospital:client:RemoveBleed')
AddEventHandler('ND_hospital:client:RemoveBleed', function()
    isBleeding = 0

    TriggerServerEvent('ND_hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    DoBleedAlert()
end)

RegisterNetEvent('ND_hospital:client:UsePainKiller')
AddEventHandler('ND_hospital:client:UsePainKiller', function(tier)
    if tier < 10 then
        onPainKiller = 90 * tier
    end

    exports['ND_notify']:SendAlert('inform', Config.Strings.UsePainKillers, 5000)
    ProcessRunStuff(PlayerPedId())
end)

RegisterNetEvent('ND_hospital:client:UseAdrenaline')
AddEventHandler('ND_hospital:client:UseAdrenaline', function(tier)
    if tier < 10 then
        onDrugs = 180 * tier
    end

    exports['ND_notify']:SendAlert('inform', Config.Strings.UseAdrenaline, 5000)
    ProcessRunStuff(PlayerPedId())
end)

--[[ Player Died Events ]]--
--[[RegisterNetEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
    ResetAll()
end)

RegisterNetEvent('baseevents:onPlayerDied')
AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
    ResetAll()
end)]]
