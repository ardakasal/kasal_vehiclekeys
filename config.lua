Config = {}

-- Framework & Inventory & Target
Config.Framework = 'qbox' -- qbox, qb, esx (only ox_inventory) # ESX, QBOX = use ox_lib for menu, target. QB = use qb-menu, qb-target
Config.Inventory = 'ox' -- ox, qb
Config.Target = 'ox' -- ox, qb

Config.UseAnim = true
Config.UseHeadlight = true
Config.UseHorn = true

Config.VehCheckDist = 3.5

Config.AdminCommands = 'adminanahtar'
Config.AdminCommandsDesc = 'Yakındaki aracın anahtarını oluşturur.'

Config.KeyPrice = 500
Config.KeyPersonal = {
    model = 'a_m_m_farmer_01',
    x = 30.37,
    y = -899.91,
    z = 28.98,
    h = 343.83
}

Config.Locales = {
    notify_title = "Kilit Sistemi",
    plate_text = "Plaka",
    givekey_success = "Anahtar verildi.",
    givekey_desc = "plakalı aracın anahtarını çıkarttınız.", 
    no_money_title = "Yeterli paran yok.", 
    no_money_desc = "Gereken", 
    buy_menu_title = "Araç Listesi",
    npc_title = "NPC ile Etkileşim", 
    key_grant_failure = "Anahtar verme işlemi başarısız oldu.",
    lock_unlocked = "Araç kilidi açıldı.",
    lock_locked = "Araç kilidi kilitlendi.",
    lock_wrong_veh = "Bu anahtar bu araç için uyumlu değil.",
    lock_no_match = "Sinyal hiçbir araç ile eşleşmedi."
}



function Notify(title, desc, type) -- Default : ox_lib
    lib.notify({
        title = title,
        description = desc,
        type = type
   })

   --QBCore.Functions.Notify(desc, type, 2000) // for QB
end
