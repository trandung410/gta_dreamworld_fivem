Config = {}

Config.ElectronicRecieve = { 1, 2 } -- สุ่มอัตราการเก็บได้ 1-6
Config.Random = 29  ------------ ปรับอัตราการสุ่มได้ไม่ได้ ในที่นี้ ถ้าสุ่มได้ น้อยกว่าหรือเท่า 29 เท่ากับล้มเหลว
Config.Itemname = "cement"  ----------- ชื่อ item
Config.CallCopsPercent = 1
Config.PedRejectPercent = 30  --ถ้าสุ่มได้มากหรือเท่ากับ 30 คือ การขโมยล้มเหลว
Config.Colourblip = 2  --แจ้งเตือนตอนขโมยไม่สำเร็จ -1 = สีแดง 2 = สีเขียว 3 = สีฟ้า 4 = สีขาว 7 = สีม่วง 8 = สีชมพู
Config.showcopsmisbehave = true   ------------ เปิดปิดการแจ้งเตือนเมื่อ Reject   เปลี่ยนเป็น false หาไม่ต้องการให้แจ้งเตือน
Config.Needcop = 0    ----- ต้องการตำรวจกี่คน
Config.FarfromCity = 1200 --ระยะห่างจากเมือง

Config.ElectronicAvailable = {
    
    "prop_cons_cements01",
}