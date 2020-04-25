RegisterServerEvent('ND_hospital:server:AttemptHiddenRevive')
AddEventHandler('ND_hospital:server:AttemptHiddenRevive', function()
    local src = source
    math.randomseed(os.time())
    local luck = math.random(100) < Config.HiddenRevChance

    local totalBill = CalculateBill(GetCharsInjuries(src), Config.HiddenInjuryBase)

    if BillPlayer(src, totalBill) then
        if luck then
            TriggerClientEvent('ND_notify:client:SendAlert', src, { text = 'You\'ve Been Treated & Billed', type = 'inform', style = { ['background-color'] = '#760036' }})
        else
            TriggerClientEvent('ND_notify:client:SendAlert', src, { text = 'You were revived, but there were some complications', type = 'inform', length = 10000, style = { ['background-color'] = '#760036' }})
        end
    else
        luck = false
        TriggerClientEvent('ND_notify:client:SendAlert', src, { text = 'You were revived, but did not have the funds to cover further medical services', type = 'inform', style = { ['background-color'] = '#760036' }})
    end

    RecentlyUsedHidden[source] = os.time() + 180000
    TriggerClientEvent('ND_hospital:client:FinishServices', src, true, luck)
end)
