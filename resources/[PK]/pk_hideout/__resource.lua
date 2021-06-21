resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	'code/main.lua'
}

client_scripts {
	'code/main.lua'
}

exports {
  'getLocation'
}

server_exports {
  'setOwner',
  'getOwner',
  'getOwnership'
}
