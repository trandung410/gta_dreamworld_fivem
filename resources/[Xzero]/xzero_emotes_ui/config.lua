--[[
    Script for FiveM (GTAV)
    Created By.xZero
]]
Config = {}

Config.keyPress           = 170     -- ปุ่มที่ใช้ในการเปิดเมนู Emotes
-- https://docs.fivem.net/docs/game-references/controls/
-- TriggerEvent("xzero_emotes_ui:CL:UI_SET_isShow", true)

Config.textTitleHeader = "Emotes"
Config.textTitleHistory = "Lasted History"

Config.audioEmoClicked    = true    -- true = เปิดใช้งานเสียงตอนกดใช้ Emo
Config.audioEmoClickedVol = 0.35    -- ระดับความดัง

Config.emoTypes = {
    {
        name = "Expressions",
        etype = "expression",
        label = "Moods",
        reset = true
    },
    {
        name = "Walks",
        index_name = 1,
        label = "Walks",
        reset = true
    },
    {
        name = "Dances",
        etype = "dances",
        label = "Dances",
        index_label = 3
    },
    {
        name = "Emotes",
        etype = "emotes",
        label = "Emotes",
        index_label = 3
    },
    {
        name = "PropEmotes",
        etype = "props",
        label = "Prop",
        index_label = 3
    },
    {
        name = "Shared",
        label = "Shared",
        index_label = 3
    }
}

Config.emoItemList = {
    ["Expressions"] = {
        {
            name = "reset",
            label = "Reset"
        }
    },
    ["Walks"] = {
        {
            name = "reset",
            label = "Reset"
        },
        {
            name = "move_m@injured",
            label = "Injured"
        }
    }
}