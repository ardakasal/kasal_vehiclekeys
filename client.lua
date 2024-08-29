RegisterNetEvent('kasal_vehiclekeys:ToggleLock')
AddEventHandler('kasal_vehiclekeys:ToggleLock', function(plate)
    local isInsideVehicle = (vehicle and vehicle ~= 0)

    
    if not isInsideVehicle then
        local nearbyVehicles = GetNearbyVehicles(Config.VehCheckDist)
        
        for _, veh in ipairs(nearbyVehicles) do
            local vehPlate = GetVehicleNumberPlateText(veh)
                        
            if trim(vehPlate) == plate then
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
                Anim()
                Horn()
                Notify(Config.Locales.notify_title, Config.Locales.lock_locked, "error")
                Wait(200)
                Headlight()
                Horn()
                SetVehicleDoorsLocked(vehicle, 2)

            else
                Anim()
                Horn()
                Notify(Config.Locales.notify_title, Config.Locales.lock_unlocked, "success") 
                Wait(200)
                Headlight()
                SetVehicleDoorsLocked(vehicle, 1)
            end
        else
            Notify(Config.Locales.notify_title, Config.Locales.lock_wrong_veh, "error")
        end
    else
        Notify(Config.Locales.notify_title, Config.Locales.lock_no_match, "error")
    end
end)


function Anim()
    if Config.UseAnim then
        local ped = PlayerPedId()
        loadAnimDict("anim@mp_player_intmenu@key_fob@")
        TaskPlayAnim(ped, "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, -8.0, -1, 52, 0, false, false, false)
        StopAnimTask(ped, "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0)
    end
end




function Headlight()
    if Config.UseHeadlight then
        SetVehicleLights(vehicle, 2)
        Wait(250)
        SetVehicleLights(vehicle, 1)
        Wait(200)
        SetVehicleLights(vehicle, 0)
        Wait(300)
    end
end


function Horn()
    if Config.UseHorn then 
        StartVehicleHorn(vehicle, 10, "HELDDOWN")
    end
end 

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Citizen.Wait(5)
    end
  end


  RegisterNetEvent('kasal_vehiclekeys:getVehMenu')
  AddEventHandler('kasal_vehiclekeys:getVehMenu', function(vehicles)
      local options = {}

      if Config.Inventory == 'ox' then
  
      for _, vehicle in pairs(vehicles) do
          table.insert(options, {
              title = '[' .. vehicle.plate .. '] ' .. Config.KeyPrice ..'$',
              event = 'kasal_vehiclekeys:selectVeh',
              args = vehicle.plate
          })
      end
  
      lib.registerContext({
          id = 'keymenu',
          title = Config.Locales.buy_menu_title,
          options = options
      })
  
      lib.showContext('keymenu')

    elseif Config.Inventory == 'qb' then 
        
        for _, vehicle in pairs(vehicles) do
            table.insert(options, {
                header = '[' .. vehicle.plate .. '] ' .. Config.KeyPrice .. '$',
                txt = "Araç anahtarını satın al",
                params = {
                    event = 'kasal_vehiclekeys:selectVeh',
                    args = vehicle.plate
                }
            })
        end

        exports['qb-menu']:openMenu({
            {
                header = Config.Locales.buy_menu_title,
                isMenuHeader = true
            },
            table.unpack(options)
        })

    end
  end)
  
  RegisterNetEvent('kasal_vehiclekeys:selectVeh')
  AddEventHandler('kasal_vehiclekeys:selectVeh', function(plate)
      TriggerServerEvent('kasal_vehiclekeys:buyKeys', plate)
  end)  

  
  function trim(s)
    return s:match("^%s*(.-)%s*$")
end
