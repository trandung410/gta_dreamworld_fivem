-- ระบบ Discord Log
Config = {}
Config.DC = {
    Enabled = true, -- true = เปิดใช้งาน
    URL_Webhook = '',
    -- รูปแบบการแสดงข้อมูลในดิสคอส
    Template = {
        color_money = 0x08F896,
        color_black_money = 0xFF0000,
        description = 'Identifier: **%s** | **%s** \n Item: **%s** | **%s** \n Count: **%s** \n Price: **%s** | **%s**'
    }
}