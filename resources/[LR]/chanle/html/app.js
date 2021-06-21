document.addEventListener('DOMContentLoaded', function () {

var d1 = document.getElementById("dice1");
var d2 = document.getElementById("dice2");
var d3 = document.getElementById("dice3");
var d4 = document.getElementById("dice4");
var idGame = document.getElementById("id");
var soNguoiChonChan = document.getElementById("userchan");
var soNguoiChonLe = document.getElementById("userle");
var soNguoiChonBonden = document.getElementById("userbonden");
var soNguoiChonBontrang = document.getElementById("userbontrang");
var soNguoiChonBaden = document.getElementById("userbaden");
var soNguoiChonBatrang = document.getElementById("userbatrang");
var tongTienDatChan = document.getElementById("sumchan");
var tongTienDatLe = document.getElementById("sumle");
var tongTienDatBonden = document.getElementById("sumbonden");
var tongTienDatBontrang = document.getElementById("sumbontrang");
var tongTienDatBaden = document.getElementById("sumbaden");
var tongTienDatBatrang = document.getElementById("sumbatrang");
var time = document.getElementById("time");
var gameStart = function(){
    time.style.opacity = 1;
    d1.style.opacity = 0;
    d2.style.opacity = 0;
    d3.style.opacity = 0;
	d4.style.opacity = 0;
    document.getElementById('dragon').style.webkitAnimationPlayState = 'running'; 
    document.getElementById("chantxt").style.webkitAnimationPlayState = 'paused';
	document.getElementById("letxt").style.webkitAnimationPlayState = 'paused';
	document.getElementById("bondentxt").style.webkitAnimationPlayState = 'paused';
	document.getElementById("bontrangtxt").style.webkitAnimationPlayState = 'paused';
	document.getElementById("badentxt").style.webkitAnimationPlayState = 'paused';
    document.getElementById("batrangtxt").style.webkitAnimationPlayState = 'paused'; 
};
var el = document.getElementById('pullchan');
if(el){
el.addEventListener('keyup', function(event) {
	if (event.key === "Enter") {
        $.post("http://chanle/datchan",JSON.stringify({
            dice: 'chan',
            money: Number(document.getElementById('pullchan').value)
        }));
        document.getElementById('pullchan').value = '';
    }
});}

var el = document.getElementById('pullle');
if(el){
el.addEventListener('keyup', function(event) {
	if (event.key === "Enter") {
        $.post("http://chanle/datle",JSON.stringify({
            dice: 'le',
            money: Number(document.getElementById('pullle').value)
        }));
        document.getElementById('pullle').value = '';
    }
});}

var el = document.getElementById('pullbonden');
if(el){
el.addEventListener('keyup', function(event) {
	if (event.key === "Enter") {
        $.post("http://chanle/datbonden",JSON.stringify({
            dice: 'bonden',
            money: Number(document.getElementById('pullbonden').value)
        }));
        document.getElementById('pullbonden').value = '';
    }
});}

var el = document.getElementById('pullbontrang');
if(el){
el.addEventListener('keyup', function(event) {
	if (event.key === "Enter") {
        $.post("http://chanle/datbontrang",JSON.stringify({
            dice: 'bontrang',
            money: Number(document.getElementById('pullbontrang').value)
        }));
        document.getElementById('pullbontrang').value = '';
    }
});}

var el = document.getElementById('pullbaden');
if(el){
el.addEventListener('keyup', function(event) {
	if (event.key === "Enter") {
        $.post("http://chanle/datbaden",JSON.stringify({
            dice: 'baden',
            money: Number(document.getElementById('pullbaden').value)
        }));
        document.getElementById('pullbaden').value = '';
    }
});}

var ek = document.getElementById('pullbatrang');
if(ek){
ek.addEventListener('keyup', function(event) {
    if (event.key === "Enter") {
        $.post("http://chanle/datbatrang",JSON.stringify({
            dice: 'batrang',
            money: Number(document.getElementById('pullbatrang').value)
        }));
        document.getElementById('pullbatrang').value = '';
    }
});}

window.addEventListener('message', function(e) {
	$("#container").stop(false, true);
    if (e.data.displayWindow == 'true') {
        $("#container").css('display', 'flex');
  		
        $("#container").animate({
        	bottom: "16%",
        	opacity: "1.0"
            
        	},
        	700, function() {
        	console.log('[Animate Start]');
        });

    }else if (e.data.displayWindow == 'false') {
    	$("#container").animate({
        	bottom: "-50%",
        	opacity: "0.0"
        	},
        	700, function() {
        		console.log('[Animate End]');
        		$("#container").css('display', 'none');
	         	
        });
    }

});




var gameOver = function(dice){
    time.style.opacity = 0;
    var roll = document.getElementById("roll");
    document.getElementById('dragon').style.webkitAnimationPlayState = 'paused'; 
    roll.src = "";
    roll.src = 'imgs/roll1.gif';
    roll.style.opacity = 1;
	var xucxac = {
        0: "trang",
        1: "den",
    };
    setTimeout(()=>{
        roll.style.opacity = 0;
        showDice(dice.dice1,dice.dice2,dice.dice3,dice.dice4);
		if(dice.result == 'nhacaian'){
			showStt('Nhà cái ăn');
		}else{
        /* document.getElementById(xucxac[dice.dice1]+"txt").style.webkitAnimationPlayState = 'running'; 
		document.getElementById(xucxac[dice.dice2]+"txt").style.webkitAnimationPlayState = 'running'; 
		document.getElementById(xucxac[dice.dice3]+"txt").style.webkitAnimationPlayState = 'running';  */
		}
    },2000);
};

var showDice = function(dice1,dice2,dice3,dice4){
    var dice = {
        0: 'trang',
        1: 'den',
    };
    d1.style.background = "url('imgs/"+dice[dice1]+".png') no-repeat ";
    d2.style.background = "url('imgs/"+dice[dice2]+".png') no-repeat ";
    d3.style.background = "url('imgs/"+dice[dice3]+".png') no-repeat ";
	d4.style.background = "url('imgs/"+dice[dice4]+".png') no-repeat ";
	d1.style.backgroundSize = "cover";
    d2.style.backgroundSize = "cover";
    d3.style.backgroundSize = "cover";
	d4.style.backgroundSize = "cover";
    d1.style.opacity = 1;
    d2.style.opacity = 1;
    d3.style.opacity = 1;
	d4.style.opacity = 1;

};

var showStt = function(msg,timeout = 3000){
    var statustxt = document.getElementById('statustxt');
    statustxt.innerHTML = msg;
    statustxt.style.opacity = 1;
    setTimeout(()=>{
        statustxt.style.opacity = 0;
    },timeout);
};

gameStart();

window.addEventListener('message', function(e) {
	
		
	if (e.data.type == 'gameData') {
		idGame.innerHTML         = '#' + e.data.id;
		soNguoiChonChan.innerHTML = e.data.chonchan;
		soNguoiChonLe.innerHTML = e.data.chonle;
		soNguoiChonBonden.innerHTML = e.data.chonbonden;
		soNguoiChonBontrang.innerHTML = e.data.chonbontrang;
		soNguoiChonBaden.innerHTML = e.data.chonbaden;
		soNguoiChonBatrang.innerHTML = e.data.chonbatrang;
		tongTienDatChan.innerHTML = e.data.tienchan;
		tongTienDatLe.innerHTML = e.data.tienle;
		tongTienDatBonden.innerHTML = e.data.tienbonden;
		tongTienDatBontrang.innerHTML = e.data.tienbontrang;
		tongTienDatBaden.innerHTML = e.data.tienbaden;
		tongTienDatBatrang.innerHTML = e.data.tienbatrang;
		if(e.data.t < 10){
			time.innerHTML  = e.data.t == 0 ? '' : '0' + e.data.t;
		}else{
			time.innerHTML  = e.data.t;
		}
	}
}
);
window.addEventListener('message', function(e) {
	if (e.data.type == 'gameOver') {
		var dice1 = e.data.dice1;
		var dice2 = e.data.dice3;
		var dice3 = e.data.dice3;
		var dice4 = e.data.dice4;
		var ketqua = {
			dice1 : e.data.dice1,
			dice2 : e.data.dice2,
			dice3 : e.data.dice3,
			dice4 : e.data.dice4,
			result : dice1 + dice2+ dice3 <= 9 ? 'xiu' : 'tai'
		};
		gameOver(e.data);
	}
}
);
window.addEventListener('message', function(e) {
	if (e.data.type == 'gameStart') {
		gameStart();
		showStt('Game bắt đầu');
	}
}
);
window.addEventListener('message', function(e) {
	if (e.data.type == 'nhankeo') {
		gameStart();
		showStt('Game bắt đầu');
	}
}
);
window.addEventListener('message', function(e) {
	if (e.data.type == 'pull') {
		if(e.data.tinnhan == 'success'){
			showStt('Đặt cược thành công');
		}else if(e.data.tinnhan == 'error'){
			showStt('Không thể đặt, vui lòng chờ giây lát');
		}
	}
}
);

	

/* socket.on('gameOver', function (data) {
    gameOver(data);
}); */

/* socket.on('gameStart', function (data) {
    gameStart();
    showStt('Game bắt đầu');
}); */

/* socket.on('pull', function (data) {
    if(data.status == 'success'){
        showStt('Đặt cược thành công');
    }else if(data.status == 'error'){
        showStt(data.error);
    }
    
}); */
/* socket.on('winGame', function (data) {
    showStt(data.msg,10000);
}); */




$(document).ready(function () {	
	$("body").on("keyup", function (key) {
		if (event.which == 27 || event.keyCode == 27) {
			closeInventory();
			return false;
		}
		return true;
});
});

function closeInventory() {
    $.post("http://chanle/NUIFocusOff", JSON.stringify({}));
}
	});	