if Config.Framework == 'qb' or Config.Framework == 'qbox' then 
    QBCore = exports['qb-core']:GetCoreObject()

    if Config.Inventory == 'ox' then 
        lib.addCommand(Config.AdminCommands, {
            help = Config.AdminCommandsDesc,
            restricted = 'group.admin'
        }, function(source, args, raw)
            TriggerClientEvent('kasal_vehiclekeys:nearbyPlate', source)
        end) 

        exports('vehiclekey', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
                local itemPlate = itemSlot.metadata.plate
                TriggerClientEvent('kasal_vehiclekeys:ToggleLock', -1, itemPlate)
            end
        end)

    elseif Config.Inventory == 'qb' then 
        QBCore.Commands.Add(Config.AdminCommands, Config.AdminCommandsDesc, {}, false, function(source, args)
            TriggerClientEvent('kasal_vehiclekeys:nearbyPlate', source)
        end, 'admin')

        QBCore.Functions.CreateUseableItem("vehiclekey", function(source, item)
            local src = source
            TriggerClientEvent('kasal_vehiclekeys:ToggleLock', -1, item.info.plate)
        end)
    end 
elseif Config.Framework == 'esx' then 
    if Config.Inventory == 'ox' then 
        lib.addCommand(Config.AdminCommands, {
            help = Config.AdminCommandsDesc,
            restricted = 'group.admin'
        }, function(source, args, raw)
            TriggerClientEvent('kasal_vehiclekeys:nearbyPlate', source)
        end) 

        exports('vehiclekey', function(event, item, inventory, slot, data)
            if event == 'usingItem' then
                local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
                local itemPlate = itemSlot.metadata.plate
                TriggerClientEvent('kasal_vehiclekeys:ToggleLock', -1, itemPlate)
            end
        end)
    end
end
