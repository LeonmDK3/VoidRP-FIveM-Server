ESX                           = nil
displ = true  
polialerta = false 
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
if Config.TestMSG == true then
	RegisterCommand("env", function(source, args, rawCommand)
		TriggerEvent("hb_notifications:display", "top-middle", "Prueba de texto", "white", 4000, true)
	end)
end
local TeleportFromTo = {
  ["zonabandas"] = {
    positionFrom = { ['x'] = -437.64, ['y'] = -979.46, ['z'] = 30.69, nom = "NonUsed"},
    positionFrom = { ['x'] = -81.9, ['y'] = -806.71, ['z'] = 243.39, nom = "Salir"},
  },  
}
Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing
function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function Drawing.draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
function Drawing.drawMissionText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end

RegisterNetEvent("hb_notifications:display")
AddEventHandler("hb_notifications:display", function(pos, msg, hue, time, sound)	
	ShowNotify(pos, msg, hue, time, sound)
end)
function ShowNotify(pos, msg, hue, time, sound)
	if msg ~= nil and msg ~= "" then
		if time == nil then
			time = Config.DefaultFadeOut
		end		
		TriggerEvent('message:show', pos, msg, hue)
		if sound == true then
			SendNUIMessage({message = 'play', sound = 'notification.ogg', volume = 0.3})
		end
		Wait(time)
		TriggerEvent('message:hide')
	else
		print("ERROR: A code of the server owner tried to draw a text with unknown values")
	end
end	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if IsControlPressed(0, 177) then 
			TriggerEvent('message:hide')
		end
	end
end)
RegisterNetEvent('message:show')
AddEventHandler('message:show', function(pos, msg, hue)
	SendNUIMessage({
      type = "message",
	  position = pos,
      display = true,
	  message = msg,
	  color = hue
    })
end)
RegisterNetEvent('message:hide')
AddEventHandler('message:hide', function()
	SendNUIMessage({
      type = "message",
	  position = nil,
      display = false,
	  message = nil,
	  color = nil
    })
 end)
AddEventHandler("onResourceStart", function(resource) 
	if resource == GetCurrentResourceName() then
		TriggerEvent("message:hide", true)
	end
end)
AddEventHandler("onClientResourceStart", function(resource) 
	if (resource == GetCurrentResourceName()) then
		TriggerEvent("message:hide", true)
	else
		return
	end
end)
function prueba()
  end