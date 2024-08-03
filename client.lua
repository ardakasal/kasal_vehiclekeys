RegisterNetEvent('kasal_vehiclekeys:toggleLock')
AddEventHandler('kasal_vehiclekeys:toggleLock', function(plate)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local isInsideVehicle = (vehicle and vehicle ~= 0)

    
    if not isInsideVehicle then
        local nearbyVehicles = GetNearbyVehicles(Config.CheckDistance)
        for _, veh in ipairs(nearbyVehicles) do
            local vehPlate = GetVehicleNumberPlateText(veh)
            
            if vehPlate == plate then
                vehicle = veh
                isInsideVehicle = true
                break
            end
        end
    end

    if isInsideVehicle then
        local vehPlate = GetVehicleNumberPlateText(vehicle)
        if vehPlate == plate then
            local isLocked = GetVehicleDoorLockStatus(vehicle)
            if isLocked == 1 then
                if Config.UseHeadlight then
                    SetVehicleLights(vehicle, 2)
                    Wait(250)
                    SetVehicleLights(vehicle, 1)
                    Wait(200)
                    SetVehicleLights(vehicle, 0)
                    Wait(300)
                end
                ClearPedTasks(ped)
                SetVehicleDoorsLocked(vehicle, 2)
                lib.notify({
                    title = "Araç Kilidi",
                    description = "Araç kilitlendi.",
                    type = "error"
                })
            else
                if Config.UseHeadlight then
                    SetVehicleLights(vehicle, 2)
                    Wait(250)
                    SetVehicleLights(vehicle, 1)
                    Wait(200)
                    SetVehicleLights(vehicle, 0)
                    Wait(300)
                end
                ClearPedTasks(ped)
                SetVehicleDoorsLocked(vehicle, 1)
                lib.notify({
                    title = "Araç Kilidi",
                    description = "Araç kilidi açıldı.",
                    type = "success"
                })
            end
        else
            lib.notify({
                title = "Araç Kilidi",
                description = "Bu anahtar bu araç için uyumlu değil.",
                type = "error"
            })
        end
    else
        lib.notify({
            title = "Araç Kilidi",
            description = "Sinyal hiç bir araç ile eşleşmedi.",
            type = "error"
        })
    end
end)

--

RegisterNetEvent('kasal_vehiclekeys:getVehMenu')
AddEventHandler('kasal_vehiclekeys:getVehMenu', function(vehicles)
    local options = {}

    for _, vehicle in pairs(vehicles) do
        table.insert(options, {
            title = vehicle.vehicle ..' - ' .. vehicle.plate .. ' - ' .. Config.KeyPrice ..'$',
            event = 'kasal_vehiclekeys:selectVeh',
            args = vehicle.plate
        })
    end

    lib.registerContext({
        id = 'keymenu',
        title = 'Araç Listesi',
        options = options
    })

    lib.showContext('keymenu')
end)

RegisterNetEvent('kasal_vehiclekeys:selectVeh')
AddEventHandler('kasal_vehiclekeys:selectVeh', function(plate)
    TriggerServerEvent('kasal_vehiclekeys:giveKeys', plate)
end)