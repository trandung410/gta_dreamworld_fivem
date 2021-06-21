--[[
	code generated using luamin.js, Herrtt#3868
--]]


Config.Hold_Action = {
	["carry1"] = {
		["source"] = {
			TaskAnim = {
				animDictionary = "anim@heists@box_carry@",
				animationName = "idle",
				blendInSpeed = 8.0,
				blendOutSpeed = 8.0,
				duration = -1,
				flag = 50,
				playbackRate = 0,
				lockX = false,
				lockY = false,
				lockZ = false
			}
		},
		["target"] = {
			TaskAnim = {
				animDictionary = "amb@code_human_in_car_idles@generic@ps@base",
				animationName = "base",
				blendInSpeed = 8.0,
				blendOutSpeed = -8,
				duration = -1,
				flag = 33,
				playbackRate = 0,
				lockX = 0,
				lockY = 40,
				lockZ = 0
			},
			AttachEntity = {
				boneIndex = 9816,
				xPos = 0.015,
				yPos = 0.38,
				zPos = 0.11,
				xRot = 0.9,
				yRot = 0.30,
				zRot = 90.0,
				p9 = false,
				useSoftPinning = false,
				collision = false,
				isPed = false,
				vertexIndex = 2,
				fixedRot = false
			}
		}
	},
	['carry2'] = {
		["source"] = {
			TaskAnim = {
				animDictionary = "anim@arena@celeb@flat@paired@no_props@",
				animationName = "piggyback_c_player_a",
				blendInSpeed = 8.0,
				blendOutSpeed = -8.0,
				duration = -1,
				flag = 49,
				playbackRate = 0,
				lockX = false,
				lockY = false,
				lockZ = false
			}
		},
		["target"] = {
			TaskAnim = {
				animDictionary = "anim@arena@celeb@flat@paired@no_props@",
				animationName = "piggyback_c_player_b",
				blendInSpeed = 8.0,
				blendOutSpeed = -8.0,
				duration = -1,
				flag = 33,
				playbackRate = 0,
				lockX = false,
				lockY = false,
				lockZ = false
			},
			AttachEntity = {
				boneIndex = 0,
				xPos = 0.0,
				yPos = -0.07,
				zPos = 0.45,
				xRot = 0.9,
				yRot = 0.5,
				zRot = 0.5,
				p9 = false,
				useSoftPinning = false,
				collision = false,
				isPed = false,
				vertexIndex = 2,
				fixedRot = false
			}
		}
	},
	['carry3'] = {
		["source"] = {},
		["target"] = {
			TaskAnim = {
				animDictionary = "nm",
				animationName = "firemans_carry",
				blendInSpeed = 8.0,
				blendOutSpeed = -8.0,
				duration = -1,
				flag = 33,
				playbackRate = 0,
				lockX = false,
				lockY = false,
				lockZ = false
			},
			AttachEntity = {
				boneIndex = 0,
				xPos = 0.27,
				yPos = 0.15,
				zPos = 0.63,
				xRot = 0.5,
				yRot = 0.5,
				zRot = 0.0,
				p9 = false,
				useSoftPinning = false,
				collision = false,
				isPed = false,
				vertexIndex = 2,
				fixedRot = false
			}
		}
	},
	['hostage'] = {
		['source'] = {
			TaskAnim = {
				animDictionary = "anim@gangops@hostage@",
				animationName = "perp_idle",
				blendInSpeed = 8.0,
				blendOutSpeed = -8.0,
				duration = -1,
				flag = 49,
				playbackRate = 0,
				lockX = false,
				lockY = false,
				lockZ = false
			},
			Cancel_TaskAnim = {
				animDictionary = "reaction@shove",
				animationName = "shove_var_a",
				blendInSpeed = 8.0,
				blendOutSpeed = -8.0,
				duration = -1,
				flag = 120,
				playbackRate = 0,
				lockX = false,
				lockY = false,
				lockZ = false
			}
		},
		['target'] = {
			TaskAnim = {
				animDictionary = "anim@gangops@hostage@",
				animationName = "victim_idle",
				blendInSpeed = 8.0,
				blendOutSpeed = -8.0,
				duration = -1,
				flag = 49,
				playbackRate = 0,
				lockX = false,
				lockY = false,
				lockZ = false
			},
			AttachEntity = {
				boneIndex = 0,
				xPos = -0.24,
				yPos = 0.11,
				zPos = 0,
				xRot = 0.5,
				yRot = 0.5,
				zRot = 0.0,
				p9 = false,
				useSoftPinning = false,
				collision = false,
				isPed = false,
				vertexIndex = 2,
				fixedRot = false
			},
			Cancel_TaskAnim = {
				animDictionary = "reaction@shove",
				animationName = "shoved_back",
				blendInSpeed = 8.0,
				blendOutSpeed = -8.0,
				duration = -1,
				flag = 0,
				playbackRate = 0,
				lockX = false,
				lockY = false,
				lockZ = false
			}
		}
	}
}