ESX                           = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent("test:find")
AddEventHandler("test:find", function(Fromcl)
value = Fromcl
TriggerClientEvent("hb_notifications:display", -1, "top-middle", value, "#000000", 20000, true)	
MySQL.Async.fetchAll("UPDATE alertas SET nivel = @nivel WHERE identificador = @identificador",
    {
     ['@identificador'] = 1,
	 ['@nivel'] = 4
    }
   )
end)
RegisterServerEvent("anun:Defa")
AddEventHandler("anun:Defa", function(Fromclf)
value = Fromclf
TriggerClientEvent("hb_notifications:display", -1, "top-middle", value, "#000000", 20000, true)
end)
RegisterServerEvent("RD:JmColor1")
AddEventHandler("RD:JmColor1", function(Fromcs)
value = Fromcs
TriggerClientEvent("hb_notifications:display", -1, "top-middle", value, "#000000", 20000, true)
MySQL.Async.fetchAll("UPDATE alertas SET nivel = @nivel WHERE identificador = @identificador",
    {
     ['@identificador'] = 1,
	 ['@nivel'] = 5
    }
   )
end)
RegisterServerEvent("RD:JmColor2")
AddEventHandler("RD:JmColor2", function(Fromcc)
value = Fromcc
TriggerClientEvent("hb_notifications:display", -1, "top-middle", value, "#000000", 20000, true)
MySQL.Async.fetchAll("UPDATE alertas SET nivel = @nivel WHERE identificador = @identificador",
    {
     ['@identificador'] = 1,
     ['@nivel'] = 3
    }
   )
end)
RegisterServerEvent("DS:desac")
AddEventHandler("DS:desac", function()
MySQL.Async.fetchAll("UPDATE alertas SET nivel = @nivel WHERE identificador = @identificador",
    {
     ['@identificador'] = 1,
	 ['@nivel'] = 0
    }
   )
end)
RegisterServerEvent("RD:JmColor3")
AddEventHandler("RD:JmColor3", function(Fromcc)
value = Fromcc
TriggerClientEvent("hb_notifications:display", -1, "top-middle", value, "#000000", 20000, true)
MySQL.Async.fetchAll("UPDATE alertas SET nivel = @nivel WHERE identificador = @identificador",
    {
     ['@identificador'] = 1,
	 ['@nivel'] = 1
    }
   )
end)
RegisterServerEvent("RD:JmColor4")
AddEventHandler("RD:JmColor4", function(Fromcc)
value = Fromcc
TriggerClientEvent("hb_notifications:display", -1, "top-middle", value, "#000000", 20000, true)
MySQL.Async.fetchAll("UPDATE alertas SET nivel = @nivel WHERE identificador = @identificador",
    {
     ['@identificador'] = 1,
	 ['@nivel'] = 2
    }
   )
end)
AddEventHandler("onResourceStart", function(resource)
	if resource == GetCurrentResourceName() then
		if resource ~= 'hb_notifications' then	
			print("^8------------------------------------------------------------------------------------")
			print("^8------------------------------------------------------------------------------------")
			print("^8ERROR: Please rename "..GetCurrentResourceName().." to hb_notifications, otherwise it might not work properly...")
			print("^8------------------------------------------------------------------------------------")
			print("^8------------------------------------------------------------------------------------^0")
		end
	end
end)