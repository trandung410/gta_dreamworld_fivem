if connectedPlayerss[serverId] ~= nil and  connectedPlayerss[serverId].job2 == 'biker' then
                                
                                
    DrawMarker(9, x2, y2, z2 + displayIDHeight + 0.2, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 255,false, true, 2, false, "h2r", "ghl", false)
                                
    red = 0
    green = 0
    blue = 255
    DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), GetPlayerName(id))
-----------------------------
DrawMarker(9, x2, y2, z2 + displayIDHeight + 0.2, 0.0, 0.0, 0.0, 90.0, 90.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 255,false, true, 2, false, "h2r", "ghl", false)
-----------------------------
*1 : 'h2r' là tên của dict 
*2 : 'ghl' là tên của file trong dict 

cách add custom img vào dict 

1 : sử dụng openiv để mở một file ytd bất kì ( ở trong source thì sử dụng file ytd của xe h2r )
    tên của file ytd chính là *1 
2 : add file png 512 x 512 của bạn vào file ytd đã mở ở bước 1 ( nhớ bật edit mode trong openIV mới thêm được)
    tên của file png chính là *2
3 : restart source chứa file ytd bạn vừa chỉnh ( ở đây là source xe h2r )
    ** không nên restart khi server đang chạy, sẽ dẫn đến những người chơi trong game bị crash vì chưa tải thư viện bạn vừa chỉnh
4 : tùy chỉnh những dòng DrawMarker trong client.lua
5 : stop playernames và start source này