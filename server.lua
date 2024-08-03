exports('vehiclekey', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
        local plate = itemSlot.metadata.plate
        print(plate)
        TriggerClientEvent('kasal_vehiclekeys:toggleLock', -1, plate)  
    end
end)
    
lib.addCommand(Config.AdminCommands, {
    restricted = 'group.admin'
}, function(source, args, raw)
    local playerPed = GetPlayerPed(source)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle and vehicle ~= 0 then
        local keyPlate = GetVehicleNumberPlateText(vehicle)
        local item = 'vehiclekey'
        local quantity = 1
        local metadata = { 
            description = Config.Locales.plate_text .. ': ' .. keyPlate,
            plate = keyPlate 
        }

        exports.ox_inventory:AddItem(source, item, quantity, metadata, nil, function(success)
            if success then      
                --print(Config.Locales.adminkey_success, keyPlate)
            else
                --print(Config.Locales.adminkey_fail)
            end
        end)
    else
        --print(Config.Locales.vehicle_not_found)
    end
end)


RegisterNetEvent('kasal_vehiclekeys:giveKeys')
AddEventHandler('kasal_vehiclekeys:giveKeys', function(plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local money = Player.Functions.GetMoney('cash')

    if money >= Config.KeyPrice then
        local item = 'vehiclekey'
        local quantity = 1
        local metadata = { 
            description = Config.Locales.plate_text .. ': ' .. keyPlate,
            plate = plate 
        }

        exports.ox_inventory:AddItem(src, item, quantity, metadata, nil, function(success)
            if success then
                Player.Functions.RemoveMoney('cash', Config.KeyPrice)
                TriggerClientEvent('lib.notify', src, {type = 'success', description = 'Anahtar başarıyla verildi: ' .. plate})
            else
                TriggerClientEvent('lib.notify', src, {type = 'error', description = 'Anahtar verilemedi.'})
            end
        end)
    else
        TriggerClientEvent('lib.notify', src, {type = 'error', description = 'Yeterli paranız yok.'})
    end
end)
