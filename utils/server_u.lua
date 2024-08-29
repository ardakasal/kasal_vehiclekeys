RegisterNetEvent('kasal_vehiclekeys:nearbyPlateServ')
AddEventHandler('kasal_vehiclekeys:nearbyPlateServ', function(keyPlate)
    local source = source
    if keyPlate then
        local metadata = { 
            description = Config.Locales.plate_text ..' : ' .. keyPlate,
            plate = keyPlate 
        }
    if Config.Inventory == 'ox' then 
        exports.ox_inventory:AddItem(source, 'vehiclekey', 1, metadata, nil, function(success)
            if success then      
                TriggerClientEvent('kasal:notify', source, Config.Locales.givekey_success, Config.Locales.plate_text .. ': ' .. keyPlate, 'success')
            end
        end)
    elseif Config.Inventory == 'qb' then
        QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(source)
        local success = Player.Functions.AddItem("vehiclekey", 1, false, metadata)
        if success then
            TriggerClientEvent('kasal:notify', source, Config.Locales.givekey_success, Config.Locales.plate_text .. ': ' .. keyPlate, 'success')
        end
    end
end
end)



RegisterNetEvent('kasal_vehiclekeys:getVeh') 
AddEventHandler('kasal_vehiclekeys:getVeh', function()
    if Config.Framework == 'qb' or Config.Framework == 'qbox' then 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid

    exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE citizenid = ?', {citizenid}, function(vehicles)
        TriggerClientEvent('kasal_vehiclekeys:getVehMenu', src, vehicles)
    end)
elseif Config.Framework == 'esx' then 
    local ESX = exports['es_extended']:getSharedObject()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local citizenid = xPlayer.getIdentifier() 

exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE owner = ?', {citizenid}, function(vehicles)
    TriggerClientEvent('kasal_vehiclekeys:getVehMenu', src, vehicles)
end)

end
end)

RegisterNetEvent('kasal_vehiclekeys:buyKeys')
AddEventHandler('kasal_vehiclekeys:buyKeys', function(keyPlate)
    if Config.Framework == 'qbox' or Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
    local Player = QBCore.Functions.GetPlayer(source)
    local money = Player.Functions.GetMoney('cash')

    if money < Config.KeyPrice then
        TriggerClientEvent('kasal:notify', source, Config.Locales.no_money_title, Config.Locales.no_money_desc .. ': $' .. Config.KeyPrice, 'error')
        return
    end

    local metadata = { 
        description = Config.Locales.plate_text ..' : ' .. keyPlate,
        plate = keyPlate 
    }

    if Config.Inventory == 'ox' then 
    exports.ox_inventory:AddItem(source, 'vehiclekey', 1, metadata, nil, function(success)
        if success then
            Player.Functions.RemoveMoney('cash', Config.KeyPrice)
            TriggerClientEvent('kasal:notify', source, Config.Locales.givekey_success, keyPlate .. ' ' .. Config.Locales.givekey_desc, 'success')
        end
    end)
elseif Config.Inventory== 'qb' then 
        local success = Player.Functions.AddItem("vehiclekey", 1, false, metadata)
        if success then
            TriggerClientEvent('kasal:notify', source, Config.Locales.givekey_success, Config.Locales.plate_text .. ': ' .. keyPlate, 'success')
        end
end

elseif Config.Framework == 'esx' then
    local ESX = exports['es_extended']:getSharedObject()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney('money')

    if money < Config.KeyPrice then
        TriggerClientEvent('kasal:notify', source, Config.Locales.no_money_title, Config.Locales.no_money_desc .. ': $' .. Config.KeyPrice, 'error')
        return
    end

    local metadata = { 
        description = Config.Locales.plate_text ..' : ' .. keyPlate,
        plate = keyPlate 
    }

    if Config.Inventory == 'ox' then 
        exports.ox_inventory:AddItem(source, 'vehiclekey', 1, metadata, nil, function(success)
            if success then
                xPlayer.removeAccountMoney('money', Config.KeyPrice)
                TriggerClientEvent('kasal:notify', source, Config.Locales.givekey_success, keyPlate .. ' ' .. Config.Locales.givekey_desc, 'success')
            end
        end)
    end


end
end)



RegisterNetEvent('kasal_vehiclekeys:GiveVehicleKey', function(keyPlate)
    local source = source

    if not keyPlate then
        return
    end

    local metadata = { 
        description = Config.Locales.plate_text .. ' : ' .. keyPlate,
        plate = keyPlate 
    }

    if Config.Inventory == 'ox' then 
        exports.ox_inventory:AddItem(source, 'vehiclekey', 1, metadata, nil, function(success)
            if success then      
                TriggerClientEvent('kasal:notify', source, Config.Locales.givekey_success, Config.Locales.plate_text .. ': ' .. keyPlate, 'success')
            end
        end)
        
    elseif Config.Inventory == 'qb' then 
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(source)
        local success = Player.Functions.AddItem("vehiclekey", 1, false, metadata)
        
        if success then
            TriggerClientEvent('kasal:notify', source, Config.Locales.givekey_success, Config.Locales.plate_text .. ': ' .. keyPlate, 'success')
        end
    end
end)



