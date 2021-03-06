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

    title="<FONT FACE='Montserrat'>V???t tay",  
    colour=0, -- 
    id=1 

  }

}

text = { 
  ['en'] = {
    ['win'] = "B???n th???ng !",
    ['lose'] = "B???n thua",
    ['full'] = "A wrestling match is already in progress",
    ['tuto'] = "????? th???ng, nh???n ",
    ['wait'] = "??ang ch??? ?????i th???",
  },
  ['fr'] = {
    ['win'] = "Vous avez gagn?? !",
    ['lose'] = "Vous avez perdu",
    ['full'] = "Un bras de fer est d??j?? en cours",
    ['tuto'] = "Pour gagner, appuyez rapidement sur ",
    ['wait'] = "En attente d'un adversaire",
  },
  ['cz'] = {
    ['win'] = "Vyhr??l jsi !",
    ['lose'] = "Prohr??l jsi",
    ['full'] = "Z??pasov?? z??pas ji?? prob??h??",
    ['tuto'] = "Chcete-li vyhr??t, rychle stiskn??te ",
    ['wait'] = "??ek??n?? na protivn??ka",
  },
  ['de'] = {
    ['win'] = "Du hast gewinnen !",
    ['lose'] = "Du hast verloren",
    ['full'] = "Ein Wrestling Match ist bereits im Gange",
    ['tuto'] = "Um zu gewinnen, dr??cken Sie schnell ",
    ['wait'] = "Warten auf einen Gegner",
  },

}