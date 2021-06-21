--[[
    Script for FiveM (GTAV)
    Created: xZero
]]
Config = {}

Config.isStartGameDelay = 1500                  -- ดีเลย์ก่อนจะเริ่ม (1000 = 1วินาที)
Config.keyPress         = 69                    -- ปุ่มในการกด
Config.textHelp         = "" -- แสดงข้อความบอก (ถ้าไม่อยากให้แสดง ปิดใช้งานได้)
-- หาข้อมูลปุ่มกดได้จาก http://gcctech.org/csc/javascript/javascript_keycodes.htm
-- ให้ดูจาก KeyCode ที่เป็นตัวเลขมาใส่

RegisterCommand('testskill',function(source,args)
    local Result = exports['xzero_skillcheck']:startGameSync({
        textTitle               ="Skill",
        speedMin                = 10,
        speedMax                = 10,
        speedMax                = 10,
        countSuccessMax         = 5,
        countFailedMax          = 3,
        layout                  = 'bottom',
        freezePos               = 'true',
        playScenario            ='',
        playAnim                = {
            Dict = "",
            Name = ""
        }
    })
    if Result.status then
        --
    else
        --
    end
end, false)