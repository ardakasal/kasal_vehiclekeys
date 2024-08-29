function GetNearbyVehicles(radius)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local nearbyVehicles = {}
    
    for veh in EnumerateVehicles() do
        local vehPos = GetEntityCoords(veh)
        if Vdist2(playerPos, vehPos) <= (radius * radius) then
            table.insert(nearbyVehicles, veh)
        end
    end
    
    return nearbyVehicles
end

function EnumerateVehicles()
    return coroutine.wrap(function()
        local handle, vehicle = FindFirstVehicle()
        local success
        
        repeat
            success, vehicle = FindNextVehicle(handle)
            if success then
                coroutine.yield(vehicle)
            end
        until not success
        
        EndFindVehicle(handle)
    end)
end


RegisterNetEvent('kasal_vehiclekeys:nearbyPlate')
AddEventHandler('kasal_vehiclekeys:nearbyPlate', function()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)

    local vehicle = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 2.0, 0, 71)
    
    if vehicle ~= 0 then
        local keyPlate = GetVehicleNumberPlateText(vehicle)
        TriggerServerEvent('kasal_vehiclekeys:nearbyPlateServ', keyPlate)
    end
end)

RegisterNetEvent('kasal:notify')
AddEventHandler('kasal:notify', function(title, desc, type)
    Notify(title, desc, type)
end)




local npcModel = GetHashKey(Config.KeyPersonal.model)
local npcCoords = vector3(Config.KeyPersonal.x, Config.KeyPersonal.y, Config.KeyPersonal.z)


local npc = nil


Citizen.CreateThread(function()
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(1)
    end

    npc = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z, Config.KeyPersonal.h, false, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetPedDiesWhenInjured(npc, false)
    SetPedCanPlayAmbientAnims(npc, true)
    SetPedCanRagdollFromPlayerImpact(npc, false)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)

    if Config.Target == 'ox' then
    local targetOptions = {
        {
            name = 'npc_interact',
            label = Config.Locales.npc_title,
            icon = 'fas fa-handshake',
            onSelect = function ()
                TriggerServerEvent('kasal_vehiclekeys:getVeh')
            end
        }
    }
    
    exports['ox_target']:addLocalEntity(npc, targetOptions)
elseif Config.Target == 'qb' then 
    
    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                type = 'server',
                event = 'kasal_vehiclekeys:getVeh',
                icon = 'fas fa-handshake',
                label = Config.Locales.npc_title
            }
        },
        distance = 2.5
    })
end
end)


exports('GiveVehicleKey', function(keyPlate)
    TriggerServerEvent('kasal_vehiclekeys:GiveVehicleKey', keyPlate)
end)