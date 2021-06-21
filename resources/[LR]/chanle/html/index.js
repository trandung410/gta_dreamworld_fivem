


var chanle = function(){

    // cài đặt
    this.idPhien             = 0;  // id phiên đặt
    this.timeDatCuoc         = 60; // thời gian đặt cược = 60s;
    this.timechophienmoi     = 10; // thời gian chờ phiên mới = 10s;
    this.soNguoiChonChan      = 0;  // Số người đặt tài
	this.soNguoiChonLe      = 0;  // Số người đặt tài
	this.soNguoiChonBonden      = 0;  // Số người đặt tài
	this.soNguoiChonBontrang      = 0;  // Số người đặt tài
	this.soNguoiChonBaden      = 0;  // Số người đặt tài
    this.soNguoiChonBatrang      = 0;  // Số người đặt xỉu
    this.tongTienDatChan      = 0;  // tổng tiền đặt tài
	this.tongTienDatLe      = 0;
	this.tongTienDatBonden      = 0;
	this.tongTienDatBontrang      = 0;
	this.tongTienDatBaden      = 0;
	this.tongTienDatBatrang      = 0;
    this.time                = this.timeDatCuoc;  // thời gian
    this.coTheDatCuoc        = true; // có thể đặt hay không
    this.idChonBaden           = []; // array id chọn tài
	this.idChonChan           = [];
	this.idChonLe           = [];
	this.idChonBonden           = [];
	this.idChonBontrang          = [];
    this.idChonBatrang           = []; // array id chọn xỉu
    this.ketQua              = ''; // kết quá


    // game bắt đầu
    this.gameStart = function(){
        // code
        seft = this;
        seft.idPhien ++;
        seft.coTheDatCuoc        = true // có thể đặt
        seft.soNguoiChonChan      = 0;  // Số người đặt tài
		seft.soNguoiChonLe      = 0;  // Số người đặt tài
		seft.soNguoiChonBonden      = 0;  // Số người đặt tài
		seft.soNguoiChonBontrang      = 0;  // Số người đặt tài
		seft.soNguoiChonBaden      = 0;  // Số người đặt tài
		seft.soNguoiChonBatrang      = 0;  // Số người đặt xỉu
        seft.tongTienDatChan      = 0;  // tổng tiền đặt tài
		seft.tongTienDatLe      = 0;
		seft.tongTienDatBonden      = 0;
		seft.tongTienDatBontrang      = 0;
		seft.tongTienDatBaden      = 0;
		seft.tongTienDatBatrang      = 0;
        seft.idChonBaden           = []; // array id chọn tài
		seft.idChonChan           = [];
		seft.idChonLe           = [];
		seft.idChonBonden           = [];
		seft.idChonBontrang          = [];
		seft.idChonBatrang           = []; // array id chọn xỉu
        seft.time = seft.timeDatCuoc;
        /* console.log('newgame');
		console.log( 'idGame:' + seft.idPhien); */
		emitNet('chanle:gameStart', -1, this.ketQua);
        loopAGame = setInterval(function() {              
            seft.time--;
			emitNet('chanle:gameData', -1, { 
                idGame        : seft.idPhien,
                soNguoiChonChan: seft.soNguoiChonChan, 
				soNguoiChonLe: seft.soNguoiChonLe, 
				soNguoiChonBonden: seft.soNguoiChonBonden, 
				soNguoiChonBontrang: seft.soNguoiChonBontrang, 
				soNguoiChonBaden: seft.soNguoiChonBaden, 
                soNguoiChonBatrang: seft.soNguoiChonBatrang, 
                tongTienDatChan: seft.tongTienDatChan,	
				tongTienDatLe: seft.tongTienDatLe,
				tongTienDatBonden: seft.tongTienDatBonden,
				tongTienDatBontrang: seft.tongTienDatBontrang,
				tongTienDatBaden: seft.tongTienDatBaden,
                tongTienDatBatrang: seft.tongTienDatBatrang, 
                 
                time          : seft.time, 
            });
            ketqua = seft.gameRandomResult();
            
            /* console.log( 'soNguoiChonTai:' + seft.soNguoiChonTai);
            console.log( 'soNguoiChonXiu:' + seft.soNguoiChonXiu);
            console.log( 'tongTienDatTai:' + seft.tongTienDatTai);
            console.log( 'tongTienDatXiu:' + seft.tongTienDatXiu);
            console.log( 'time:' + seft.time); */
            if (seft.time == 0){
                clearInterval(loopAGame);
                seft.gameOver();
            }
        }, 1000);
        // console.log( 'tongTienDatXiu:' + JSON.stringify(ketqua));

        // console.log();
    };
    // game kết thúc
    this.gameOver = function(){
        seft = this;
        seft.coTheDatCuoc  = false // không thể đặt
        seft.time = seft.timechophienmoi;
        this.ketQua =  seft.gameRandomResult();
		emitNet('chanle:gameOver', -1, this.ketQua);
        /* console.log(JSON.stringify(this.ketQua)); */
		
		var dice = {
			0: seft.idChonChan,
			1: seft.idChonLe,
			2: seft.idChonChan,
			3: seft.idChonLe,
			4: seft.idChonChan,
		};
		var lorraxs = {
			0: seft.idChonBontrang,
			1: seft.idChonBatrang,
			3: seft.idChonBaden,
			4: seft.idChonBonden,
		};
			
			
			
		idWin1 = dice[this.ketQua.result];
		idWin1.forEach((data)=>{
				emitNet('chanle:winGame1', data.id, data.tien);
			});
		if(this.ketQua.result != '2'){
			/* emitNet('mythic_notify:client:SendAlert', -1, { type : 'error', text : this.ketQua.result}) */
			if ((this.ketQua.result == '0') || (this.ketQua.result == '4')){
				/* emitNet('mythic_notify:client:SendAlert', -1, { type : 'error', text : ("Chưa đến phiên tiếp theo, vui lòng chờ giây lát!")}) */
				idWin2 = lorraxs[this.ketQua.result];
				idWin2.forEach((data)=>{
						emitNet('chanle:winGame2', data.id, data.tien);
					})
			}else if ((this.ketQua.result == '1') || (this.ketQua.result == '3')){
				idWin3 = lorraxs[this.ketQua.result];
				idWin3.forEach((data)=>{
						emitNet('chanle:winGame3', data.id, data.tien);
					})
			}
		};
        loopAGame = setInterval(function() {   
            seft.time --;   
            /* console.log(seft.time); */
			emitNet('chanle:gameData', -1, { 
                idGame        : seft.idPhien,
                soNguoiChonChan: seft.soNguoiChonChan, 
				soNguoiChonLe: seft.soNguoiChonLe, 
				soNguoiChonBonden: seft.soNguoiChonBonden, 
				soNguoiChonBontrang: seft.soNguoiChonBontrang, 
				soNguoiChonBaden: seft.soNguoiChonBaden, 
                soNguoiChonBatrang: seft.soNguoiChonBatrang, 
                tongTienDatChan: seft.tongTienDatChan,	
				tongTienDatLe: seft.tongTienDatLe,
				tongTienDatBonden: seft.tongTienDatBonden,
				tongTienDatBontrang: seft.tongTienDatBontrang,
				tongTienDatBaden: seft.tongTienDatBaden,
                tongTienDatBatrang: seft.tongTienDatBatrang, 
                 
                time          : seft.time, 
            });
            if (seft.time == 0){
                clearInterval(loopAGame);
                seft.gameStart();
            }
        }, 1000);
    };
    // đặt cược
    this.putMoney = function(id,cau,tien){
        // nếu đang trong thời gian chờ (coTheDatCuoc == false)
        if (this.coTheDatCuoc == false){
            return {
                status  : 'error',
                error   : 'Không thể đặt, vui lòng chờ giây lát'
            };
        }
        if(cau == 'chan'){
            // thêm tiền vào tổng số tiền đặt tài
            this.tongTienDatChan += tien;
            // thêm id vào list id array nếu chưa có
            if(!this.idChonChan.find(x => x.id === id)){ 
                this.idChonChan.push({
                    id   : id,
                    cau  : 'chan',
                    tien : tien
                });
                this.soNguoiChonChan ++;
            }else{
                // nếu tìm thấy thì cộng thêm tiền vô
                this.idChonChan.find(x => x.id === id).tien += tien;
            }
		}else if(cau == 'le'){
            // thêm tiền vào tổng số tiền đặt tài
            this.tongTienDatLe += tien;
            // thêm id vào list id array nếu chưa có
            if(!this.idChonLe.find(x => x.id === id)){ 
                this.idChonLe.push({
                    id   : id,
                    cau  : 'le',
                    tien : tien
                });
                this.soNguoiChonLe ++;
            }else{
                // nếu tìm thấy thì cộng thêm tiền vô
                this.idChonLe.find(x => x.id === id).tien += tien;
            }
		}else if(cau == 'bonden'){
            // thêm tiền vào tổng số tiền đặt tài
            this.tongTienDatBonden += tien;
            // thêm id vào list id array nếu chưa có
            if(!this.idChonBonden.find(x => x.id === id)){ 
                this.idChonBonden.push({
                    id   : id,
                    cau  : 'bonden',
                    tien : tien
                });
                this.soNguoiChonBonden ++;
            }else{
                // nếu tìm thấy thì cộng thêm tiền vô
                this.idChonBonden.find(x => x.id === id).tien += tien;
            }
		}else if(cau == 'bontrang'){
            // thêm tiền vào tổng số tiền đặt tài
            this.tongTienDatBontrang += tien;
            // thêm id vào list id array nếu chưa có
            if(!this.idChonBontrang.find(x => x.id === id)){ 
                this.idChonBontrang.push({
                    id   : id,
                    cau  : 'bontrang',
                    tien : tien
                });
                this.soNguoiChonBontrang ++;
            }else{
                // nếu tìm thấy thì cộng thêm tiền vô
                this.idChonBontrang.find(x => x.id === id).tien += tien;
            }
		}else if(cau == 'baden'){
            // thêm tiền vào tổng số tiền đặt tài
            this.tongTienDatBaden += tien;
            // thêm id vào list id array nếu chưa có
            if(!this.idChonBaden.find(x => x.id === id)){ 
                this.idChonBaden.push({
                    id   : id,
                    cau  : 'baden',
                    tien : tien
                });
                this.soNguoiChonBaden ++;
            }else{
                // nếu tìm thấy thì cộng thêm tiền vô
                this.idChonBaden.find(x => x.id === id).tien += tien;
            }
            
        }else if(cau == 'batrang'){
            // thêm tiền vào tổng số tiền đặt tài
            this.tongTienDatBatrang += tien;
            // thêm id vào list id array nếu chưa có
            if(!this.idChonBatrang.find(x => x.id === id)){ 
                this.idChonBatrang.push({
                    id   : id,
                    cau  : 'batrang',
                    tien : tien
                });
                this.soNguoiChonBatrang ++;
            }else{
                // nếu tìm thấy thì cộng thêm tiền vô
                this.idChonBatrang.find(x => x.id === id).tien += tien;
            }
        }
        return {
            status : 'success',
			player : id,
			tiendat : tien,
			caudat : cau,
        }
    }
    // random kết quả
    this.gameRandomResult = function(){
        dice1 =  Math.round( Math.random() );
        dice2 =  Math.round( Math.random() );
        dice3 =  Math.round( Math.random() );
		dice4 =  Math.round( Math.random() );
		
			return {
				dice1    : dice1,
				dice2    : dice2,
				dice3    : dice3,
				dice4	: dice4,
				result  : dice1 + dice2 + dice3 + dice4
			};
		
    }
    
}

tx = new chanle();

onNet('chanle:pull', function (id, dice, money) {
        msg = tx.putMoney(id, dice, money);
        emitNet('chanle:pull', id, msg);
		
});

tx.gameStart();