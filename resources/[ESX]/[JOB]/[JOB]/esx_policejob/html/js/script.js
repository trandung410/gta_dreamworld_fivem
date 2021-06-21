window.addEventListener('message', function (event) {
    var data = event.data;
	
	if (data.clear == true) {
        $(".weapon").empty();
	}
		
	
	if (data !== undefined && data.display == true) {
		
		var str1 = '';
		var str2 = '';
		var str3 = '';		
		
		str1 = `<input id="weapon_buy_btn_img"  src="img/button/buy.png" type="image" onclick="get_car('`+event.data.name+`','`+event.data.model+`','`+event.data.price+`')" onmouseover="this.src='img/button/buy_hover.png'" onmouseout="this.src='img/button/buy.png'"/>`
				
		$(".weapon").append(`
			<div class="weapon_item">
				<center>
				<img src="img/`+event.data.model+`.png" style="margin-top: 3px;"></img>
				<div class="label">
					<span id="weapon_name">`+event.data.name+`</span>
					Giá: <span id="weapon_price">`+event.data.price+`$</span>
				</div>				
				`+str1+`
				
				</center>
			</div>
		`);
		$(".container").show();
		
		$(".container").mousedown(function (e) {
        if (e.which == 3) {
				$(".weapon").empty();
				$(".popup").fadeOut(100);
				$(".container").fadeOut(100);
				$.post('http://esx_policejob/NUIFocusOff');
			}
		});
	}
	
	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$(".weapon").empty();
			$(".popup").fadeOut(100);
			$(".container").fadeOut(100);
			$.post('http://esx_policejob/NUIFocusOff');
		}	
	}
	
	if (data.display == false) {
		$(".container").fadeOut(100);
    }
});



function get_car(name, model, price) {
		
	$(".weapon").empty();
	$(".container").fadeOut(200);
	$('.popup').fadeIn(200);

	$('#popupYes').on('click', function (e){
		$.post('http://esx_policejob/get_car', JSON.stringify({name: name, model: model, price: price}));
		$(".weapon").empty();
		$(".popup").fadeOut(100);
		$(".container").fadeOut(200);
		name  = '';
		model  = '';
		price = 0;
		return;
	});
	
	
	$('#popupNo').on('click', function (e) {
		CarModel = '';
		price = 0;
		$('.popup').fadeOut(200);
		$.post('http://esx_policejob/NUIFocusOff');
	});
}

document.addEventListener('DOMContentLoaded', function () {
    $(".container").hide();
});
