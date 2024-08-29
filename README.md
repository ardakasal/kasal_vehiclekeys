# 🚗🔑 kasal_vehiclekeys - FiveM Key System 

### Compatible Frameworks: QB-Core(qb or ox inventory) / QBOX (ox inventory) / ESX (ox_inventory)

## 📋 Features

- **🗝️ Metadata-Based Vehicle Key (Item)**
- **🔒 Vehicle Locking and Unlocking Functions**

### 🚗 Extracting Vehicle Key

1. **Legal**
   - If the vehicle is listed in your `player_vehicles` or `owned_vehicles` table, you can extract a key for that specific vehicle.
   - 📝 **Note:** Keys can only be extracted for vehicles that you own.

2. **Admin**
   - Administrators can extract a key for any vehicle they are currently inside, using the vehicle's license plate.

## 🔧 Setup

1.1. Add the following entry to your `ox_inventory > items.lua`:

    ```lua
    ["vehiclekey"] = {
        label = 'Vehicle Key',
        weight = 10,
        stack = false,
        close = true,
        consume = 0,
        client = {
            image = "vehiclekey.png",
        },
        server = {
            export = 'kasal_vehiclekeys.vehiclekey'
        },
    }
    ```

1.2. Add the following entry to your `qb_core > shared > items.lua`:

    ```lua
    vehiclekey                       = { name = 'vehiclekey', label = 'Vehicle Key', weight = 10, type = 'item', image = 'vehiclekey.png', unique = true, useable = true, shouldClose = true, description = '' },
    ```

2. Add the kasal_vehiclekeys script to the resources section of your server.

3. Configure your settings, such as Framework, Inventory, Target, and Locales, through the Config file.

4. Start the script and enjoy using it!

## Example vehicleshop
export (client side):

    ```lua
    exports['kasal_vehiclekeys']:GiveVehicleKey(plate)
    ```
