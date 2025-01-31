local function diveDumpster(player)
    -- Randomize loot
    for _, loot in ipairs(Config.lootTable) do
        if math.random(1, 100) <= loot.chance then
            local amount = math.random(loot.amount[1], loot.amount[2])
            exports.ox_inventory:AddItem(player, loot.item, amount)
            return
        end
    end

    TriggerClientEvent('ox_lib:notify', player, { type = 'inform', description = 'You found nothing.', position = 'center-right'  })
end

RegisterNetEvent('dumpster_diving:dive', function()
    local player = source
    diveDumpster(player)
end)
