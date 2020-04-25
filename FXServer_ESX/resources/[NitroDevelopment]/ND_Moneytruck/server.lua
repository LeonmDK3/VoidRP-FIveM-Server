ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

    for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            CopsConnected = CopsConnected + 1
        end
    end
    SetTimeout(120 * 1000 , CountCops)
end

CountCops()

RegisterNetEvent('ND:Itemcheck')
AddEventHandler('ND:Itemcheck', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local isRobbing = true

    local item = xPlayer.getInventoryItem(Config.Item)

    if isRobbing and item.count > 0 and amount > 0 then
        CountCops()
        if CopsConnected >= Config.Copsneeded then
            --xPlayer.removeInventoryItem("Config.Item", 1)  // uncomment if you want to remove the item on start //
            TriggerClientEvent('ND:startHacking',source,true)
            TriggerClientEvent('animation:hack', source)
        else
            isRobbing = false
            TriggerClientEvent('ND_notify:client:SendAlert', source, { type = 'error', text = ("Not Enough Police") })
            --TriggerClientEvent('esx:notification','~r~Not Enough Police', source, r)
        end
    else
        isRobbing = false
        TriggerClientEvent('ND_notify:client:SendAlert', source, { type = 'error', text = ("You dont have the right tools for this") })
        --TriggerClientEvent('esx:notification','~r~You dont have the right tools for this', source, r)
    end
end)

RegisterNetEvent('ND:NotifyPolice')
AddEventHandler('ND:NotifyPolice', function(street1, street2, pos)
    local xPlayers = ESX.GetPlayers()
    local isRobbing = true

    if isRobbing == true then
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                TriggerClientEvent('ND:Blip', xPlayers[i], pos.x, pos.y, pos.z)
                TriggerClientEvent('ND:NotifyPolice', xPlayers[i], '~r~Robbery In Progress : Security Truck | ' .. street1 .. " | " .. street2 .. '~w~ ')
			end
		end
	end
end)

function RandomItem()
	return Config.Items[math.random(#Config.Items)]
end

function RandomNumber()
	return math.random(1,10)
end

RegisterNetEvent('ND:Payout')
AddEventHandler('ND:Payout', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local Robbing = false
    local timer = 0

    Robbing = true

    while Robbing == true do
        timer = timer + 5
        Citizen.Wait(3500)  --// Delay between receiving Items/Cash might need to play around with this if you decide to change the default timer (Config.Timer)
        if math.random(1,100) <= 50 then
            xPlayer.addMoney(math.random(300,2500))
        else
            xPlayer.addInventoryItem(RandomItem(), RandomNumber())
        end
        if timer == Config.Timer then
            Robbing = false
            break
        end
    end
end)
