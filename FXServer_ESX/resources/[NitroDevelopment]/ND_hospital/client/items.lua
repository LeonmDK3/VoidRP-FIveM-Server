RegisterNetEvent("ND_hospital:items:gauze")
AddEventHandler("ND_hospital:items:gauze", function(item)
    exports['ND_progbar']:Progress({
        name = "firstaid_action",
        duration = 1500,
        label = "Packing Wounds",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            TriggerEvent('ND_hospital:client:FieldTreatBleed')
        end
    end)
end)

RegisterNetEvent("ND_hospital:items:bandage")
AddEventHandler("ND_hospital:items:bandage", function(item)
    exports['ND_progbar']:Progress({
        name = "firstaid_action",
        duration = 5000,
        label = "Using Bandage",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(status)
        if not status then
            local maxHealth = GetEntityMaxHealth(PlayerPedId())
            local health = GetEntityHealth(PlayerPedId())
            local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
            SetEntityHealth(PlayerPedId(), newHealth)
        end
    end)
end)

RegisterNetEvent("ND_hospital:items:firstaid")
AddEventHandler("ND_hospital:items:firstaid", function(item)
    exports['ND_progbar']:Progress({
        name = "firstaid_action",
        duration = 10000,
        label = "Using First Aid",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_stat_pack_01"
        },
    }, function(status)
        if not status then
            local maxHealth = GetEntityMaxHealth(PlayerPedId())
            local health = GetEntityHealth(PlayerPedId())
            local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
            SetEntityHealth(PlayerPedId(), newHealth)
        end
    end)
end)

RegisterNetEvent("ND_hospital:items:medkit")
AddEventHandler("ND_hospital:items:medkit", function(item)
    exports['ND_progbar']:Progress({
        name = "firstaid_action",
        duration = 20000,
        label = "Using Medkit",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_ld_health_pack"
        },
    }, function(status)
        if not status then
            SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
            TriggerEvent('ND_hospital:client:FieldTreatLimbs')
        end
    end)
end)

RegisterNetEvent("ND_hospital:items:vicodin")
AddEventHandler("ND_hospital:items:vicodin", function(item)
    exports['ND_progbar']:Progress({
        name = "firstaid_action",
        duration = 1000,
        label = "Taking " .. item.label,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('ND_hospital:client:UsePainKiller', 1)
        end
    end)
end)

RegisterNetEvent("ND_hospital:items:hydrocodone")
AddEventHandler("ND_hospital:items:hydrocodone", function(item)
    exports['ND_progbar']:Progress({
        name = "firstaid_action",
        duration = 1000,
        label = "Taking " .. item.label,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('ND_hospital:client:UsePainKiller', 2)
        end
    end)
end)

RegisterNetEvent("ND_hospital:items:morphine")
AddEventHandler("ND_hospital:items:morphine", function(item)
    exports['ND_progbar']:Progress({
        name = "firstaid_action",
        duration = 2000,
        label = "Taking " .. item.label,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        },
    }, function(status)
        if not status then
            TriggerEvent('ND_hospital:client:UsePainKiller', 6)
        end
    end)
end)
