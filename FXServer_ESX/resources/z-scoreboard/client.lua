--[[ Need Help? Join my discord @ discord.gg/yWddFpQ ]]

local nui = false
players = {}
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100) -- Wait 2 seconds
		local num = 1;
		players = {};
		ptable = GetPlayers()
		for _, i in ipairs(ptable) do
			r, g, b = GetPlayerRgbColour(i)
			if num == 1 then
				table.insert(players,
				'<tr style=\"color: #fff"><td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td>'
				)
				num = 2
			elseif num == 2 then
				table.insert(players, '<td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td>')
				num = 3
			elseif num == 3 then
				table.insert(players, '<td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td>')
				num = 4
			elseif num == 4 then
				table.insert(players, '<td>' .. GetPlayerServerId(i) .. '</td><td>' .. GetPlayerName(i) .. '</td></tr>')
				num = 1
			end
		end
	end
end)
]]--
Citizen.CreateThread(function()
    --[[ If you want to change the key, go to https://docs.fivem.net/game-references/controls/ and change the '20' value below]]
    local key = 20 -- Change this to your key value
    nui = false
    while true do
        Citizen.Wait(1)
        if IsControlPressed(0, key) then
            if not nui then
				local num = 1;
				players = {};
				ptable = GetPlayers()
				for _, i in ipairs(ptable) do
					r, g, b = GetPlayerRgbColour(i)
					if num == 1 then
						table.insert(players,
						'<tr style=\"color: #fff"><td>' .. GetPlayerServerId(i) .. ' →</td><td>' .. GetPlayerName(i) .. '</td>'
						)
						num = 2
					elseif num == 2 then
						table.insert(players, '<td class="spaceme">' .. GetPlayerServerId(i) .. ' →</td><td>' .. GetPlayerName(i) .. '</td>')
						num = 3
					elseif num == 3 then
						table.insert(players, '<td class="spaceme">' .. GetPlayerServerId(i) .. ' →</td><td>' .. GetPlayerName(i) .. '</td>')
						num = 4
					elseif num == 4 then
						table.insert(players, '<td class="spaceme">' .. GetPlayerServerId(i) .. ' →</td><td>' .. GetPlayerName(i) .. '</td></tr>')
						num = 1
					end
				end
                SendNUIMessage({ text = table.concat(players) })

                nui = true
                while nui do
                    Wait(0)
                    if(IsControlPressed(0, key) == false) then
                        nui = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)

function GetPlayers()
    local players = {}

    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
