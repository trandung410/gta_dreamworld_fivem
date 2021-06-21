--========================================================================================================================================================================-
--========================================================================================================================================================================-
--=========================================                                                                                      =========================================-                         
--=========================================                                                                                      =========================================-
--=========================================                                                                                      =========================================-
--========================================================================================================================================================================-
--========================================================================================================================================================================-



globalConfig = {

  language = 'en', --change with 'en' for english, 'fr' for french, 'cz' for czech, 'de' for german




      --Set up new line to add a table, xyz are the coordinate, model is the props used as table. The 3 tables for armwrestling are 

                                                    -- 'prop_arm_wrestle_01' --
                                              -- 'bkr_prop_clubhouse_arm_wrestle_01a' --
                                              -- 'bkr_prop_clubhouse_arm_wrestle_02a' --

  props = { 
    


    -- {x = 0, y = 0, z = 0, model = 'prop_arm_wrestle_01'},
    -- {x = 0, y =0, z = 0, model = 'bkr_prop_clubhouse_arm_wrestle_01a'},
    {x = 237.9201965332, y = -875.87493896484, z =30.49210357666, model = 'bkr_prop_clubhouse_arm_wrestle_02a'},
    {x = 232.80654907227, y = -873.86041259766, z =30.49210357666, model = 'bkr_prop_clubhouse_arm_wrestle_02a'},
    {x = 227.59930419922, y = -871.97259521484, z =30.49210357666, model = 'bkr_prop_clubhouse_arm_wrestle_02a'},


  },

  showBlipOnMap = false, -- Set to true to show blip for each table

  blip = { --Blip info

    title="<FONT FACE='Montserrat'>Vật tay",  
    colour=0, -- 
    id=1 

  }

}

text = { 
  ['en'] = {
    ['win'] = "Bạn thắng !",
    ['lose'] = "Bạn thua",
    ['full'] = "A wrestling match is already in progress",
    ['tuto'] = "Để thắng, nhấn ",
    ['wait'] = "Đang chờ đối thủ",
  },
  ['fr'] = {
    ['win'] = "Vous avez gagné !",
    ['lose'] = "Vous avez perdu",
    ['full'] = "Un bras de fer est déjà en cours",
    ['tuto'] = "Pour gagner, appuyez rapidement sur ",
    ['wait'] = "En attente d'un adversaire",
  },
  ['cz'] = {
    ['win'] = "Vyhrál jsi !",
    ['lose'] = "Prohrál jsi",
    ['full'] = "Zápasový zápas již probíhá",
    ['tuto'] = "Chcete-li vyhrát, rychle stiskněte ",
    ['wait'] = "Čekání na protivníka",
  },
  ['de'] = {
    ['win'] = "Du hast gewinnen !",
    ['lose'] = "Du hast verloren",
    ['full'] = "Ein Wrestling Match ist bereits im Gange",
    ['tuto'] = "Um zu gewinnen, drücken Sie schnell ",
    ['wait'] = "Warten auf einen Gegner",
  },

}