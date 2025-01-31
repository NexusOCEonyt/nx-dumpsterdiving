local dumpsterCooldowns = {}

local dumpsterSearchStatus = {}

CreateThread(function()
    for _, dumpster in ipairs(Config.dumpsters) do
        exports.ox_target:addModel(dumpster, {
            name = 'dumpster_dive',
            label = 'Search Dumpster',
            icon = 'fa-solid fa-dumpster',
            onSelect = function(data)
                local entity = data.entity
                local entityCoords = GetEntityCoords(entity)
                local entityId = tostring(entityCoords) -- Unique identifier for the dumpster based on its position

                -- Check if the dumpster has been searched
                if dumpsterSearchStatus[entityId] then
                    TriggerEvent('ox_lib:notify', { type = 'error', description = 'This dumpster has already been searched. Try another one.', position = 'center-right'  })
                    return
                end

                -- Start the cooldown for the dumpster
                if dumpsterCooldowns[entityId] and (GetGameTimer() - dumpsterCooldowns[entityId] < Config.cooldown * 1000) then
                    TriggerEvent('ox_lib:notify', { 
                        type = 'error', 
                        description = 'This dumpster is on cooldown. Try again later.', 
                        position = 'center-right' 
                    })
                    return
                end

                -- Mark the dumpster as searched
                dumpsterSearchStatus[entityId] = true

                -- Start the cooldown for the dumpster
                dumpsterCooldowns[entityId] = GetGameTimer()

                -- Show progress bar for 5 seconds
                if lib.progressCircle({
                    duration = 3500,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        move = true,
                    },
                    label = "Searching dumpster...",  -- Adding the text here
                    anim = {
                        dict = 'amb@prop_human_bum_bin@enter',
                        clip = 'enter'
                    },
                }) then
                    TriggerServerEvent('dumpster_diving:dive')
                end
            end
        })
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, dumpster in ipairs(Config.dumpsters) do
            exports.ox_target:removeModel(dumpster, 'dumpster_dive')
        end
    end
end)

