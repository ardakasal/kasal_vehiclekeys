# 🚗🔑 kasal_vehiclekeys - FiveM Key System 

ox_inventory -> items.lua 

`
["vehiclekey"] = {
		label = 'Araba Anahtarı',
		weight = 10,
		stack = false,
		close = true,
		consume = 0,
		client = {image = "cuffkeys.png",},
		server = {
			export = 'kasal_vehiclekeys.vehiclekey'
		},
	}	`

# [EN]

## 📋 Features

- **🗝️ Metadata Vehicle Key (Item)**
- **🔒 Vehicle Locking and Unlocking Functions**

### 🚗 Extracting Vehicle Key

1. **Legal**
   - If the vehicle is in your `player_vehicles` table, you can extract the key for that vehicle.
   - 📝 **Note:** This allows you to extract keys only for your own vehicles.
   
2. **Illegal**
   - If the vehicle is not in the `player_vehicles` table, you can extract the key for that vehicle.
   - 📝 **Note:** This allows you to extract keys only for NPC vehicles.
   
3. **Admin**
   - Can extract the key for the vehicle they are currently inside, based on its license plate.


# [TR]

## 📋 Özellikler

- **🗝️ Metadata Araç Anahtarı (Eşya)**
- **🔒 Araç Kilitleme ve Kilit Açma Fonksiyonları**

### 🚗 Araç Anahtar Çıkartma

1. **Legal**
   - Eğer araç sizin `player_vehicles` tablonuzda ise o aracın anahtarını çıkartabilirsiniz.
   - 📝 **Not:** Bu sayede sadece kendi araçlarınızın anahtarlarını çıkartabilirsiniz.
   
2. **İllegal**
   - Eğer araç `player_vehicles` tablosunda yoksa o aracın anahtarını çıkartabilirsiniz.
   - 📝 **Not:** Bu sayede sadece NPC araçlarının anahtarlarını çıkartabilirsiniz.
   
3. **Yetkili**
   - İçerisinde bulunduğu aracın plakasının anahtarını çıkartabilir.
