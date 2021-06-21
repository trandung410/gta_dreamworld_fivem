Config = {}
Config.BlipName = {
    ['job-apply'] = "Nơi xin việc",
    -- ['cloak-room'] = "Phòng thay đồ",
    ['dealer'] = "Thương nhân",
}
Config.Jobs = {
    ['miner'] = {
        ['job-label'] = "Thợ Mỏ",
        ['main-pos'] = {
            ['job-apply'] = {x = 2627.1906738281, y = 2937.587890625, z = 40.422878265381},
            -- ['cloak-room'] = {x = 2631.9416503906, y = 2935.3500976562, z = 40.421634674072},
            ['dealer'] = {x = -621.99884033203, y = -230.7614440918, z =38.057052612305, h = 120.34},
        },
        ['items'] = {
            ['copper'] = 400,
            ['gold'] = 1000,
            ['iron'] = 800,
            ['diamond'] = 5000
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
                    duration = 10000
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
                        {name = "stone", count = 1, probability = 100},
                        {name = "chi", count = 1, probability = 5},
                    },
                    levelBonus = {
                        [1] = {
                            -- {name = "stone", count = 1, probability = 30}
                        },
                        [2] = {
                            -- {name = "stone", count = 1, probability = 10},
                        },
                        [3] = {
                            -- {name = "stone", count = 1, probability = 10},
                        },
                        [4] = {
                            -- {name = "stone", count = 1, probability = 10},
                        },
                        [5] = {
                            -- {name = "stone", count = 1, probability = 10},
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
                    duration = 10000
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
                        {name = "copper", count = 10, probability = 90},
                        {name = "gold", count = 3, probability = 20},
                        {name = "iron", count = 5, probability = 50},
                        {name = "diamond", count = 1, probability = 5}
                    }
                }
            }
        }
    },
    ['fueler'] = {
        ['job-label'] = "Dầu",
        ['main-pos'] = {
            ['job-apply'] = {x = 562.58135986328, y = 2740.7543945312, z =42.752998352051},
            -- ['cloak-room'] = {x = 557.83349609375, y = -2327.7778320312, z = 5.8283071517944},
            ['dealer'] = {x = -2221.1264648438, y = 3483.4604492188, z =30.163167953491, h = 174.58},
        },
        ['items'] = {
            ['xang'] = 400
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
                blip = {sprite = 121, color = 1, label = "Thu hoạch Xăng"},
                helpMessage = "Nhấn [E] để thu hoạch Xăng",
                progressBar = {
                    label = "Đang thu hoạch Xăng",
                    duration = 10000
                },
                work = {
                    type = "freeze",
                    radius = 5.0,
                    ["max-spawn"] = 500,
                    scenario = "WORLD_HUMAN_CONST_DRILL",
                    require = nil,
                    reward = {
                        {name = "xang", count = 1, probability = 100},
                        {name = "carbon", count = 1, probability = 1}
                    }
                }
            },
            -- [2] = {
            --     coords = {x = 2736.4826660156, y = 1416.8919677734, z = 24.4700050354},
            --     blip = {sprite = 121, color = 1, label = "Lọc Dầu"},
            --     helpMessage = "Nhấn [E] để lọc Dầu",
            --     progressBar = {
            --         label = "Đang lọc dầu",
            --         duration = 4000
            --     },
            --     work = {
            --         type = "freeze",
            --         radius = 5.0,
            --         require = {
            --             {name = "oil_raw", count = 2}
            --         },
            --         reward = {
            --             {name = "oil", count = 1, probability = 100}
            --         }
            --     }
            -- }
        }
    },
    ['lumberjack'] = {
        ['job-label'] = "Gỗ",
        ['main-pos'] = {
            ['job-apply'] = {x = -568.55169677734, y = 5253.2939453125, z =70.487480163574},
            -- ['cloak-room'] = {x = 1950.76, y = 3846.42, z = 32.18},
            ['dealer'] = {x = 1194.2604980469, y = -1319.5111083984, z =35.126525878906, h = 174.89},
        },
        ['items'] = {
            ['cratedwood'] = 500
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
                        {name = "wood", count = 1, probability = 100},
                        {name = "wood_pro", count = 1, probability = 5}
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
                        {name = "cutedwood", count = 1, probability = 100}
                    }
                }
            },
            [3] = {
                coords = {x = -508.71166992188, y = 5264.3159179688, z =80.610153198242},
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
                        {name = "cutedwood", count = 1}
                    },
                    reward = {
                        {name = "cratedwood", count = 2, probability = 100}
                    }
                }
            }
        }
    },
    -- ['slaughter'] = {
    --     ['job-label'] = "Giết Mổ",
    --     ['main-pos'] = {
    --         ['job-apply'] = {x = -68.452209472656, y = 6255.3618164062, z = 31.090166091919},
    --         ['dealer'] = {x = -76.099822998047, y = 6255.84375, z = 31.090009689331, h = 312.98025512695},
    --     },
    --     ['items'] = {
    --         ['meat'] = 800,
    --     },
    --     ['level'] = {
    --         [1] = 0,
    --         [2] = 1500,
    --         [3] = 3000,
    --         [4] = 4000,
    --         [5] = 5000
    --     },
    --     ['uniform'] = {
    --         ['male'] = {
    --             tshirt_2 = 1,
    --             ears_1 = 8,
    --             glasses_1 = 15,
    --             torso_2 = 0,
    --             ears_2 = 2,
    --             glasses_2 = 3,
    --             shoes_2 = 1,
    --             pants_1 = 75,
    --             shoes_1 = 51,
    --             bags_1 = 0,
    --             helmet_2 = 0,
    --             pants_2 = 7,
    --             torso_1 = 71,
    --             tshirt_1 = 59,
    --             arms = 2,
    --             bags_2 = 0,
    --             helmet_1 = 0
    --         },
    --         ['female'] = {
    --             tshirt_2 = 3,
    --             decals_2 = 0,
    --             glasses = 0,
    --             hair_1 = 2,
    --             torso_1 = 73,
    --             shoes = 1,
    --             hair_color_2 = 0,
    --             glasses_1 = 19,
    --             skin = 13,
    --             face = 6,
    --             pants_2 = 5,
    --             tshirt_1 = 75,
    --             pants_1 = 37,
    --             helmet_1 = 57,
    --             torso_2 = 0,
    --             arms = 14,
    --             sex = 1,
    --             glasses_2 = 0,
    --             decals_1 = 0,
    --             hair_2 = 0,
    --             helmet_2 = 0,
    --             hair_color_1 = 0
    --         }
    --     },
    --     ['blip'] = {sprite = 268, color = 5},
    --     ['step'] = {
    --         [1] = {
    --             coords = {x = 2308.1862792969, y = 4933.8969726562, z = 41.414943695068},
    --             blip = {sprite = 121, color = 1, label = "Bắt Chim"},
    --             helpMessage = "Nhấn [E] để bắt chim",
    --             progressBar = {
    --                 label = "Đang bắt chim",
    --                 duration = 5000
    --             },
    --             work = {
    --                 type = "gather",
    --                 radius = 30.0,
    --                 objType = "ped",
    --                 obj = {
    --                     "a_c_chickenhawk"
    --                 },
    --                 ["max-spawn"] = 15,
    --                 scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD",
    --                 require = nil,
    --                 reward = {
    --                     {name = "chic", count = 1, probability = 100}
    --                 },
    --                 levelBonus = {
    --                     -- [1] = {
    --                     --     {name = "chic", count = 1, probability = 30}
    --                     -- },
    --                     -- [2] = {
    --                     --     {name = "chic", count = 1, probability = 40},
    --                     --     {name = "chic", count = 1, probability = 30},
    --                     --     {name = "chic", count = 1, probability = 10},
    --                     -- },
    --                     -- [3] = {
    --                     --     {name = "chic", count = 1, probability = 100},
    --                     --     {name = "chic", count = 1, probability = 30},
    --                     --     {name = "chic", count = 1, probability = 10},
    --                     -- },
    --                     -- [4] = {
    --                     --     {name = "chic", count = 1, probability = 100},
    --                     --     {name = "chic", count = 1, probability = 30},
    --                     --     {name = "chic", count = 1, probability = 20},
    --                     --     {name = "chic", count = 1, probability = 10},
    --                     -- },
    --                     -- [5] = {
    --                     --     {name = "chic", count = 1, probability = 100},
    --                     --     {name = "chic", count = 1, probability = 100},
    --                     --     {name = "chic", count = 1, probability = 30},
    --                     --     {name = "chic", count = 1, probability = 10},
    --                     -- }
    --                 }
    --             }
    --         },
    --         [2] = {
    --             coords = {x = -78.088806152344, y = 6229.37890625, z = 31.091815948486},
    --             blip = {sprite = 121, color = 1, label = "Chặt Chim"},
    --             helpMessage = "Nhấn [E] để chặt chim",
    --             progressBar = {
    --                 label = "Đang chặt",
    --                 duration = 5000
    --             },
    --             work = {
    --                 type = "freeze",
    --                 scenario = "PROP_HUMAN_BUM_BIN",
    --                 require = {
    --                     {name = "chic", count = 1}
    --                 },
    --                 reward = {
    --                     {name = "chic_s", count = 1, probability = 100},
    --                 }
    --             }
    --         },
    --         [3] = {
    --             coords = {x = -103.8553237915, y = 6206.263671875, z = 31.025020599365},
    --             blip = {sprite = 121, color = 1, label = "Đóng Gói KFC"},
    --             helpMessage = "Nhấn [E] để đóng gói",
    --             progressBar = {
    --                 label = "Đang đóng gói",
    --                 duration = 10000
    --             },
    --             work = {
    --                 type = "freeze",
    --                 scenario = "PROP_HUMAN_BBQ",
    --                 require = {
    --                     {name = "chic_s", count = 3}
    --                 },
    --                 reward = {
    --                     {name = "chic_p", count = 1, probability = 100}
    --                 }
    --             }
    --         }
    --     }
    -- },
}