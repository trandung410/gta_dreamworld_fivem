Config = {}
Config.BlipName = {
    ['job-apply'] = "Nơi xin việc",
    ['cloak-room'] = "Phòng thay đồ",
    ['dealer'] = "Thương nhân",
}
Config.Jobs = {
    ['miner'] = {
        ['job-label'] = "Thợ Mỏ",
        ['main-pos'] = {
            ['job-apply'] = {x = 2627.1906738281, y = 2937.587890625, z = 40.422878265381},
            ['cloak-room'] = {x = 2631.9416503906, y = 2935.3500976562, z = 40.421634674072},
            ['dealer'] = {x = 193.9952545166, y = -899.58813476563, z = 31.116765975952, h = 249.34176635742},
        },
        ['items'] = {
            ['copper'] = 350,
            ['gold'] = 5000,
            ['iron'] = 450,
            ['diamond'] = 50000
        },
        ['level'] = {
            [1] = 0,
            [2] = 1500,
            [3] = 3000,
            [4] = 4000,
            [5] = 5000
        },
        ['uniform'] = {
            ['male'] = {
                tshirt_2 = 1,
                ears_1 = 8,
                glasses_1 = 15,
                torso_2 = 0,
                ears_2 = 2,
                glasses_2 = 3,
                shoes_2 = 1,
                pants_1 = 75,
                shoes_1 = 51,
                bags_1 = 0,
                helmet_2 = 0,
                pants_2 = 7,
                torso_1 = 71,
                tshirt_1 = 59,
                arms = 2,
                bags_2 = 0,
                helmet_1 = 0
            },
            ['female'] = {
                tshirt_2 = 3,
                decals_2 = 0,
                glasses = 0,
                hair_1 = 2,
                torso_1 = 73,
                shoes = 1,
                hair_color_2 = 0,
                glasses_1 = 19,
                skin = 13,
                face = 6,
                pants_2 = 5,
                tshirt_1 = 75,
                pants_1 = 37,
                helmet_1 = 57,
                torso_2 = 0,
                arms = 14,
                sex = 1,
                glasses_2 = 0,
                decals_1 = 0,
                hair_2 = 0,
                helmet_2 = 0,
                hair_color_1 = 0
            }
        },
        ['blip'] = {sprite = 318, color = 5},
        ['step'] = {
            [1] = {
                coords = {x = 2944.9641113281, y = 2794.4562988281, z = 40.584594726562},
                blip = {sprite = 121, color = 1, label = "Đào Đá"},
                helpMessage = "Nhấn [E] để đào hoạch đá",
                progressBar = {
                    label = "Đang đào đá",
                    duration = 5000
                },
                work = {
                    type = "gather",
                    radius = 30.0,
                    obj = {
                        "prop_rock_4_a", "prop_rock_4_cl_1", "rock_4_cl_2_2", "prop_rock_4_c_2", "prop_rock_5_smash3", "prop_rock_5_smash2", "rock_4_cl_2_1", "prop_rock_5_e", "prop_rock_5_d", "prop_rock_4_big"
                    },
                    ["max-spawn"] = 50,
                    scenario = "WORLD_HUMAN_CONST_DRILL",
                    require = nil,
                    reward = {
                        {name = "stone", count = 1, probability = 100}
                    },
                    levelBonus = {
                        [1] = {
                            {name = "stone", count = 1, probability = 30}
                        },
                        [2] = {
                            {name = "stone", count = 1, probability = 40},
                            {name = "stone", count = 1, probability = 30},
                            {name = "stone", count = 1, probability = 10},
                        },
                        [3] = {
                            {name = "stone", count = 1, probability = 100},
                            {name = "stone", count = 1, probability = 30},
                            {name = "stone", count = 1, probability = 10},
                        },
                        [4] = {
                            {name = "stone", count = 1, probability = 100},
                            {name = "stone", count = 1, probability = 30},
                            {name = "stone", count = 1, probability = 20},
                            {name = "stone", count = 1, probability = 10},
                        },
                        [5] = {
                            {name = "stone", count = 1, probability = 100},
                            {name = "stone", count = 1, probability = 100},
                            {name = "stone", count = 1, probability = 30},
                            {name = "stone", count = 1, probability = 10},
                        }
                    }
                }
            },
            [2] = {
                coords = {x = 1903.1311035156, y = 261.8581237793, z = 161.85749816895},
                blip = {sprite = 121, color = 1, label = "Rửa Đá"},
                helpMessage = "Nhấn [E] để rửa đá",
                progressBar = {
                    label = "Đang rửa đá",
                    duration = 5000
                },
                work = {
                    type = "freeze",
                    scenario = "PROP_HUMAN_BUM_BIN",
                    require = {
                        {name = "stone", count = 1}
                    },
                    reward = {
                        {name = "washed_stone", count = 1, probability = 100}
                    }
                }
            },
            [3] = {
                coords = {x = 1109.2874755859, y = -2007.7858886719, z = 31.035409927368},
                blip = {sprite = 121, color = 1, label = "Luyện Đá"},
                helpMessage = "Nhấn [E] để luyện đá",
                progressBar = {
                    label = "Đang luyện đá",
                    duration = 10000
                },
                work = {
                    type = "freeze",
                    scenario = "PROP_HUMAN_BUM_BIN",
                    require = {
                        {name = "washed_stone", count = 3}
                    },
                    reward = {
                        {name = "copper", count = 1, probability = 90},
                        {name = "gold", count = 1, probability = 30},
                        {name = "iron", count = 1, probability = 70},
                        -- {name = "coat", count = 1, probability = 20},
                        {name = "diamond", count = 1, probability = 5}
                    }
                }
            }
        }
    },
    ['fueler'] = {
        ['job-label'] = "Dầu",
        ['main-pos'] = {
            ['job-apply'] = {x = -266.37225341797, y = -955.62091064453, z = 31.223134994507},
            ['cloak-room'] = {x = 557.83349609375, y = -2327.7778320312, z = 5.8283071517944},
            ['dealer'] = {x = 202.59948730469, y = -900.89324951172, z = 31.116868972778, h = 27.765245437622},
        },
        ['items'] = {
            ['essence'] = 1000
        },
        ['level'] = {
            [1] = 0,
            [2] = 1500,
            [3] = 3000,
            [4] = 4000,
            [5] = 5000
        },
        ['uniform'] = {
            ['male'] = {
                tshirt_2 = 1,
                ears_1 = 8,
                glasses_1 = 15,
                torso_2 = 0,
                ears_2 = 2,
                glasses_2 = 3,
                shoes_2 = 1,
                pants_1 = 75,
                shoes_1 = 51,
                bags_1 = 0,
                helmet_2 = 0,
                pants_2 = 7,
                torso_1 = 71,
                tshirt_1 = 59,
                arms = 2,
                bags_2 = 0,
                helmet_1 = 0
            },
            ['female'] = {
                tshirt_2 = 3,
                decals_2 = 0,
                glasses = 0,
                hair_1 = 2,
                torso_1 = 73,
                shoes = 1,
                hair_color_2 = 0,
                glasses_1 = 19,
                skin = 13,
                face = 6,
                pants_2 = 5,
                tshirt_1 = 75,
                pants_1 = 37,
                helmet_1 = 57,
                torso_2 = 0,
                arms = 14,
                sex = 1,
                glasses_2 = 0,
                decals_1 = 0,
                hair_2 = 0,
                helmet_2 = 0,
                hair_color_1 = 0
            }
        },
        ['blip'] = {sprite = 436, color = 5},
        ['step'] = {
            [1] = {
                coords = {x = 603.57556152344, y = 2858.4392089844, z = 39.989868164062},
                blip = {sprite = 121, color = 1, label = "Thu hoạch Dầu"},
                helpMessage = "Nhấn [E] để thu hoạch dầu",
                progressBar = {
                    label = "Đang thu hoạch Dầu",
                    duration = 4000
                },
                work = {
                    type = "freeze",
                    radius = 5.0,
                    ["max-spawn"] = 500,
                    scenario = "WORLD_HUMAN_CONST_DRILL",
                    require = nil,
                    reward = {
                        {name = "petrol", count = 1, probability = 100}
                    }
                }
            },
            [2] = {
                coords = {x = 2736.4826660156, y = 1416.8919677734, z = 24.4700050354},
                blip = {sprite = 121, color = 1, label = "Lọc Dầu"},
                helpMessage = "Nhấn [E] để lọc Dầu",
                progressBar = {
                    label = "Đang lọc dầu",
                    duration = 4000
                },
                work = {
                    type = "freeze",
                    radius = 5.0,
                    require = {
                        {name = "petrol", count = 2}
                    },
                    reward = {
                        {name = "petrol_raffin", count = 1, probability = 100}
                    }
                }
            },
            [3] = {
                coords = {x = 265.58297729492, y = -3013.3444824219, z = 5.7331867218018},
                blip = {sprite = 121, color = 1, label = "Trộn Dầu"},
                helpMessage = "Nhấn [E] để trộn dầu",
                progressBar = {
                    label = "Đang trộn dầu",
                    duration = 4000
                },
                work = {
                    type = "freeze",
                    radius = 5.0,
                    require = {
                        {name = "petrol_raffin", count = 1}
                    },
                    reward = {
                        {name = "essence", count = 2, probability = 90}
                    }
                }
            }
        }
    },
    ['lumberjack'] = {
        ['job-label'] = "Gỗ",
        ['main-pos'] = {
            ['job-apply'] = {x = 1952.8640136719, y = 3842.2248535156, z = 32.179344177246},
            ['cloak-room'] = {x = 1950.76, y = 3846.42, z = 32.18},
            ['dealer'] = {x = 202.59948730469, y = -900.89324951172, z = 31.116868972778, h = 27.765245437622},
        },
        ['items'] = {
            ['packaged_plank'] = 2100
        },
        ['level'] = {
            [1] = 0,
            [2] = 1500,
            [3] = 3000,
            [4] = 4000,
            [5] = 5000
        },
        ['uniform'] = {
            ['male'] = {
                tshirt_2 = 1,
                ears_1 = 8,
                glasses_1 = 15,
                torso_2 = 0,
                ears_2 = 2,
                glasses_2 = 3,
                shoes_2 = 1,
                pants_1 = 75,
                shoes_1 = 51,
                bags_1 = 0,
                helmet_2 = 0,
                pants_2 = 7,
                torso_1 = 71,
                tshirt_1 = 59,
                arms = 2,
                bags_2 = 0,
                helmet_1 = 0
            },
            ['female'] = {
                tshirt_2 = 3,
                decals_2 = 0,
                glasses = 0,
                hair_1 = 2,
                torso_1 = 73,
                shoes = 1,
                hair_color_2 = 0,
                glasses_1 = 19,
                skin = 13,
                face = 6,
                pants_2 = 5,
                tshirt_1 = 75,
                pants_1 = 37,
                helmet_1 = 57,
                torso_2 = 0,
                arms = 14,
                sex = 1,
                glasses_2 = 0,
                decals_1 = 0,
                hair_2 = 0,
                helmet_2 = 0,
                hair_color_1 = 0
            }
        },
        ['blip'] = {sprite = 237, color = 4},
        ['step'] = {
            [1] = {
                coords = {x = -534.32012939453, y = 5373.7900390625, z = 70.500450134277},
                blip = {sprite = 121, color = 1, label = "Thu hoạch Gỗ"},
                helpMessage = "Nhấn [E] để thu hoạch gỗ",
                progressBar = {
                    label = "Đang thu hoạch Gỗ",
                    duration = 4000
                },
                work = {
                    type = "freeze",
                    radius = 5.0,
                    ["max-spawn"] = 500,
                    scenario = "WORLD_HUMAN_CONST_DRILL",
                    require = nil,
                    reward = {
                        {name = "wood", count = 2, probability = 100}
                    }
                }
            },
            [2] = {
                coords = {x = -552.21002197266, y = 5326.8999023438, z = 73.591812133789},
                blip = {sprite = 121, color = 1, label = "Xẻ Gỗ"},
                helpMessage = "Nhấn [E] để xẻ gỗ",
                progressBar = {
                    label = "Đang xẻ gỗ",
                    duration = 4000
                },
                work = {
                    type = "freeze",
                    radius = 5.0,
                    require = {
                        {name = "wood", count = 1}
                    },
                    reward = {
                        {name = "pro_wood", count = 1, probability = 100}
                    }
                }
            },
            [3] = {
                coords = {x = 1191.9599609375, y = -1261.7700195312, z = 35.171432495117},
                blip = {sprite = 121, color = 1, label = "Đóng Gói Gỗ"},
                helpMessage = "Nhấn [E] để đóng gói Gỗ",
                progressBar = {
                    label = "Đang đóng gói Gỗ",
                    duration = 4000
                },
                work = {
                    type = "freeze",
                    radius = 5.0,
                    require = {
                        {name = "pro_wood", count = 1}
                    },
                    reward = {
                        {name = "packaged_plank", count = 1, probability = 100}
                    }
                }
            }
        }
    },
    ['slaughter'] = {
        ['job-label'] = "Giết Mổ",
        ['main-pos'] = {
            ['job-apply'] = {x = -68.452209472656, y = 6255.3618164062, z = 31.090166091919},
            ['cloak-room'] = {x = 1200.8056640625, y = -1276.1540527344, z = 35.224983215332},
            ['dealer'] = {x = -76.099822998047, y = 6255.84375, z = 31.090009689331, h = 312.98025512695},
        },
        ['items'] = {
            ['packaged_bird'] = 800,
            ['feathers'] = 1
        },
        ['level'] = {
            [1] = 0,
            [2] = 1500,
            [3] = 3000,
            [4] = 4000,
            [5] = 5000
        },
        ['uniform'] = {
            ['male'] = {
                tshirt_2 = 1,
                ears_1 = 8,
                glasses_1 = 15,
                torso_2 = 0,
                ears_2 = 2,
                glasses_2 = 3,
                shoes_2 = 1,
                pants_1 = 75,
                shoes_1 = 51,
                bags_1 = 0,
                helmet_2 = 0,
                pants_2 = 7,
                torso_1 = 71,
                tshirt_1 = 59,
                arms = 2,
                bags_2 = 0,
                helmet_1 = 0
            },
            ['female'] = {
                tshirt_2 = 3,
                decals_2 = 0,
                glasses = 0,
                hair_1 = 2,
                torso_1 = 73,
                shoes = 1,
                hair_color_2 = 0,
                glasses_1 = 19,
                skin = 13,
                face = 6,
                pants_2 = 5,
                tshirt_1 = 75,
                pants_1 = 37,
                helmet_1 = 57,
                torso_2 = 0,
                arms = 14,
                sex = 1,
                glasses_2 = 0,
                decals_1 = 0,
                hair_2 = 0,
                helmet_2 = 0,
                hair_color_1 = 0
            }
        },
        ['blip'] = {sprite = 268, color = 5},
        ['step'] = {
            [1] = {
                coords = {x = 2308.1862792969, y = 4933.8969726562, z = 41.414943695068},
                blip = {sprite = 121, color = 1, label = "Bắt Chim"},
                helpMessage = "Nhấn [E] để bắt chim",
                progressBar = {
                    label = "Đang bắt chim",
                    duration = 5000
                },
                work = {
                    type = "gather",
                    radius = 30.0,
                    objType = "ped",
                    obj = {
                        "a_c_chickenhawk"
                    },
                    ["max-spawn"] = 15,
                    scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD",
                    require = nil,
                    reward = {
                        {name = "alive_bird", count = 1, probability = 100}
                    },
                    levelBonus = {
                        [1] = {
                            {name = "alive_bird", count = 1, probability = 30}
                        },
                        [2] = {
                            {name = "alive_bird", count = 1, probability = 40},
                            {name = "alive_bird", count = 1, probability = 30},
                            {name = "alive_bird", count = 1, probability = 10},
                        },
                        [3] = {
                            {name = "alive_bird", count = 1, probability = 100},
                            {name = "alive_bird", count = 1, probability = 30},
                            {name = "alive_bird", count = 1, probability = 10},
                        },
                        [4] = {
                            {name = "alive_bird", count = 1, probability = 100},
                            {name = "alive_bird", count = 1, probability = 30},
                            {name = "alive_bird", count = 1, probability = 20},
                            {name = "alive_bird", count = 1, probability = 10},
                        },
                        [5] = {
                            {name = "alive_bird", count = 1, probability = 100},
                            {name = "alive_bird", count = 1, probability = 100},
                            {name = "alive_bird", count = 1, probability = 30},
                            {name = "alive_bird", count = 1, probability = 10},
                        }
                    }
                }
            },
            [2] = {
                coords = {x = -78.088806152344, y = 6229.37890625, z = 31.091815948486},
                blip = {sprite = 121, color = 1, label = "Chặt Chim"},
                helpMessage = "Nhấn [E] để chặt chim",
                progressBar = {
                    label = "Đang chặt",
                    duration = 5000
                },
                work = {
                    type = "freeze",
                    scenario = "PROP_HUMAN_BUM_BIN",
                    require = {
                        {name = "alive_bird", count = 1}
                    },
                    reward = {
                        {name = "slaughtered_bird", count = 1, probability = 100},
                        {name = "feathers", count = 100, probability = 100}
                    }
                }
            },
            [3] = {
                coords = {x = -103.8553237915, y = 6206.263671875, z = 31.025020599365},
                blip = {sprite = 121, color = 1, label = "Đóng Gói KFC"},
                helpMessage = "Nhấn [E] để đóng gói",
                progressBar = {
                    label = "Đang đóng gói",
                    duration = 10000
                },
                work = {
                    type = "freeze",
                    scenario = "PROP_HUMAN_BBQ",
                    require = {
                        {name = "slaughtered_bird", count = 3}
                    },
                    reward = {
                        {name = "packaged_bird", count = 1, probability = 100}
                    }
                }
            }
        }
    },
}