QBCore = exports['qb-core']:GetCoreObject()

exports('vehiclekey', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
        local plate = itemSlot.metadata.plate
        print(plate)
        TriggerClientEvent('lock:toggleClient', -1, plate)  
    end
end)
    

RegisterNetEvent('kasal_vehiclekeys:getVeh') 
AddEventHandler('kasal_vehiclekeys:getVeh', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid

    exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE citizenid = ?', {citizenid}, function(vehicles)
        TriggerClientEvent('kasal_vehiclekeys:getVehMenu', src, vehicles)
    end)
end)

RegisterNetEvent('kasal_vehiclekeys:getNoVeh')
AddEventHandler('kasal_vehiclekeys:getNoVeh', function(plate)
    print("(debug) kod bana geldi")
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE plate = ?', {plate}, function(result)
        if #result == 0 then
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
            TriggerClientEvent('lib.notify', src, {type = 'error', description = 'Bu araç zaten kayıtlı.'})
        end
    end)
end)