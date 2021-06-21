-- ระบบ Discord Log
Config.DC = {
    -- อุ้ม
    ['carry1'] = {
        Enabled = false, -- true = เปิดใช้งาน
        URL_Webhook = '',
        Action = true, -- true = ส่งข้อมูลตอนอุ้ม
        -- รูปแบบการแสดงข้อมูลในดิสคอส
        Template = {
            color = 0x08F896,
            description = 'Source: **%s** | **%s** \n' .. 'Target: **%s** | **%s**'
        }
    },
    -- ขี่หลัง
    ['carry2'] = {
        Enabled = false, -- true = เปิดใช้งาน
        URL_Webhook = '',
        Action = true, -- true = ส่งข้อมูลตอนอุ้ม
        -- รูปแบบการแสดงข้อมูลในดิสคอส
        Template = {
            color = 0x08F896,
            description = 'Source: **%s** | **%s** \n' .. 'Target: **%s** | **%s**'
        }
    },
    -- แบก
    ['carry3'] = {
        Enabled = false, -- true = เปิดใช้งาน
        URL_Webhook = '',
        Action = true, -- true = ส่งข้อมูลตอนอุ้ม
        -- รูปแบบการแสดงข้อมูลในดิสคอส
        Template = {
            color = 0x08F896,
            description = 'Source: **%s** | **%s** \n' .. 'Target: **%s** | **%s**'
        }
    },
    -- จับเป็นตัวประกัน
    ['hostage'] = {
        Enabled = false, -- true = เปิดใช้งาน
        URL_Webhook = '',
        Action = true, -- true = ส่งข้อมูลตอนที่จับเป็นตัวประกัน
        Kill = true, -- true = ส่งข้อมูลตอนที่ฆ่าตัวประกัน
        -- รูปแบบการแสดงข้อมูลในดิสคอส
        Template = {
            color = 0xF88308,
            color_kill = 0xFF0000,
            description = 'Source: **%s** | **%s** \n' .. 'Target: **%s** | **%s** \n' .. 'Weapon: **%s**'
        }
    }
}