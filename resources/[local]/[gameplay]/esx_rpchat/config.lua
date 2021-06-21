Config        = {}
Config.Locale = 'en'

Config.EnableESXIdentity = false -- only turn this on if you are using esx_identity and want to use RP names
Config.OnlyFirstname     = false
Config.Job = {
    police = {
        label = "^5Cảnh Sát | ^2",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 255, 255, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
    ambulance = {
        label = "^6Bác sĩ | ^2",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 255, 255, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
    mechanic = {
        label = "^3Cứu Hộ | ^2",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 255, 255, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
    army = {
        label = "^2Quân Đội | ^2",
        template = '<div style="padding: 0.3vw; display: inline-block;  background-color: rgba(255, 255, 255, 0.4); border-radius: 1vw;"><i class="icon"></i> {0} : {1}</div>'
    },
}