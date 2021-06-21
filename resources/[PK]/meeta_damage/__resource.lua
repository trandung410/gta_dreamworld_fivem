--client_script 'client.lua'

client_scripts {
	"config.lua",
   --"client.lua"
}

 
files {
   'weapons.meta'
}
 
data_file 'WEAPONINFO_FILE_PATCH' 'weapons.meta'
client_script '12698.lua'