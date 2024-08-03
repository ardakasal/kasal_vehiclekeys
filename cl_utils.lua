local npcModel = GetHashKey(Config.KeyPersonal.model)
local npcCoords = vector3(Config.KeyPersonal.x, Config.KeyPersonal.y, Config.KeyPersonal.z)

local markerCoords = vector3(Config.IllegalKeyZone.x, Config.IllegalKeyZone.y, Config.IllegalKeyZone.z)
local markerRadius = Config.IllegalKeyZone.radius

local npc = nil


Citizen.CreateThread(function()
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(1)
    end

    npc = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z, Config.KeyPersonal.h, false, true)
    SetEntityAsMissionEntity(npc, true, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    TaskStartScenarioInPlace(npc, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if npc then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local dist = #(playerCoords - npcCoords)

            if dist < 3.0 then
                DrawText3D(npcCoords.x, npcCoords.y, npcCoords.z + 1.0, "[E] Anahtarcı")

                if IsControlJustReleased(0, 38) then 
                    TriggerServerEvent('kasal_vehiclekeys:getVeh')
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local dist = #(playerCoords - markerCoords)

        if dist < 15 then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            DrawMarker(25, markerCoords.x, markerCoords.y, markerCoords.z - 0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, markerRadius, markerRadius, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
            
            if vehicle and vehicle ~= 0 then
                DrawText3D(markerCoords.x, markerCoords.y, markerCoords.z + 1.0, "[E] Anahtar Çıkart")
            if IsControlJustReleased(0, 38) then  -- 'E' tuşu
                local plate = GetVehicleNumberPlateText(vehicle)
                FreezeEntityPosition(vehicle, true)
                if lib.progressCircle({
                    duration = 6000,
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        move = true,
                        mouse = false,
                    },
                }) then 
                    TriggerServerEvent('kasal_vehiclekeys:getNoVeh', plate)
                    FreezeEntityPosition(vehicle, false)
                end
                print(plate)
            end
            end
        end
    end
end)


function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(pX, pY, pZ) - vector3(x, y, z))

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.35 * scale, 0.35 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


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