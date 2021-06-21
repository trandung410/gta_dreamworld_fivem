
/* 
	██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
	██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
	██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
	██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
	███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
	╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
	 */
$(function() {
	
		window.addEventListener('message', function(event) {
			if (event.data.type == 'shop') {
				$('#nav').fadeIn("fast");
				$('#donate-container').fadeIn("fast");
				document.getElementById("coin").innerHTML = event.data.cash+' 💎 ';
			var cash = event.data.cash

			var i1;
			var id = 750;

			/* if (event.data.result.length > 10) {
				for (i1 = 0; i1 < (event.data.result.length -10) / 5; i1++) { 
					
					$('#wrapper').append(
						`<div class="line" style = "top: ${id}px; position: relative;"></div>`
					);

					id = id + 375
				}
			} */

			var i;
			
			for (i = 0; i < event.data.result.length; i++) {
				if(event.data.result[i].type == 'vehicle'){
					$('#phuongtien').append(
						`<div class = "image" id = ${event.data.result[i].name} label = ${event.data.result[i].label} price = ${event.data.result[i].price} type = ${event.data.result[i].type}>
							<img src="${event.data.result[i].src}" style='height: 80%; width: 80%; object-fit: contain'/>
							 <h4 class = "h4">${event.data.result[i].label}</h4>
							 <h4 class = "h4">Giá: ${event.data.result[i].price}</h4>
							<div style = " margin-top: 3.704vh">
							<button class = "button" id = "buybutton" type = "vehicle" number = ${i} style = "style= width: 70px">⭐ Mua</button>
							</div>
						</div>`
					)
				}else if(event.data.result[i].type == 'item'){
					$('#vatpham').append(
						`<div class = "image" id = ${event.data.result[i].name} label = ${event.data.result[i].label} price = ${event.data.result[i].price} type = ${event.data.result[i].type}>
							<img src="${event.data.result[i].src}" style='height: 80%; width: 80%; object-fit: contain'/>
							 <h4 class = "h4">${event.data.result[i].label}</h4>
							 <h4 class = "h4">Giá: ${event.data.result[i].price}</h4>
							<div style = " margin-top: 3.704vh">
							<button class = "button" id = "buybutton" type = "item" number = ${i} style = "style= width: 70px">⭐ Mua</button>
							</div>
						</div>`
					)
				}else if(event.data.result[i].type == 'skin'){
					$('#quanao').append(
						`<div class = "image" id = ${event.data.result[i].name} label = ${event.data.result[i].label} price = ${event.data.result[i].price} type = ${event.data.result[i].type}>
							<img src="${event.data.result[i].src}" style='height: 80%; width: 80%; object-fit: contain'/>
							 <h4 class = "h4">${event.data.result[i].label}</h4>
							 <h4 class = "h4">Giá: ${event.data.result[i].price}</h4>
							<div style = " margin-top: 3.704vh">
							<button class = "button" id = "buybutton" type = "skin" number = ${i} style = "style= width: 70px">⭐ Mua</button>
							</div>
						</div>`
					)
				}else if(event.data.result[i].type == 'weapon'){
					$('#khac').append(
						`<div class = "image" id = ${event.data.result[i].name} label = ${event.data.result[i].label} price = ${event.data.result[i].price} type = ${event.data.result[i].type}>
							<img src="nui://esx_inventoryhud/html/img/items/${event.data.result[i].name.toUpperCase()}.png" style='height: 80%; width: 80%; object-fit: contain'/>
							 <h4 class = "h4">${event.data.result[i].label}</h4>
							 <h4 class = "h4">Giá: ${event.data.result[i].price}</h4>
							<div style = " margin-top: 3.704vh">
							<button class = "button" id = "buybutton" type = "general" number = ${i} style = "style= width: 70px">⭐ Mua</button>
							</div>
						</div>`
					)
				}
			}

			$('#wrapper').append(
				` <h6 class = "h4" style = "right: 47.125%; position: absolute;" bottom = ${id - 5}>Made by LORRAXS</h6>`
			)

			if (event.data.owner == true) {

				$('#wrapper').append(
					`
					<button class = "button" id = "bossactions" style = "position: absolute; right: 15px; top: 5px;">Boss actions</button>
					`
				);
			}

			var CartCount;

			$("body").on("click", "#donate", function(){
				$('#phuongtien').fadeOut("fast");
				$('#quanao').fadeOut("fast");
				$('#vatpham').fadeOut("fast");
				$('#khac').fadeOut("fast");
				$('#donate-container').fadeIn("fast");
			})


			$("body").on("click", "#item", function() {
				$('#phuongtien').fadeOut("fast");
				$('#quanao').fadeOut("fast");
				$('#vatpham').fadeIn("fast");
				$('#khac').fadeOut("fast");
				$('#donate-container').fadeOut("fast");
			});

			$("body").on("click", "#skin", function() {
				$('#phuongtien').fadeOut("fast");
				$('#quanao').fadeIn("fast");
				$('#vatpham').fadeOut("fast");
				$('#khac').fadeOut("fast");
				$('#donate-container').fadeOut("fast");
			});

			$("body").on("click", "#vehicle", function() {
				$('#phuongtien').fadeIn("fast");
				$('#quanao').fadeOut("fast");
				$('#vatpham').fadeOut("fast");
				$('#khac').fadeOut("fast");
				$('#donate-container').fadeOut("fast");
			});

			$("body").on("click", "#general", function() {
				$('#phuongtien').fadeOut("fast");
				$('#quanao').fadeOut("fast");
				$('#vatpham').fadeOut("fast");
				$('#khac').fadeIn("fast");
				$('#donate-container').fadeOut("fast");
			});

			$("body").on("click", "#buybutton", function() {
				var number = $(this).attr('number');
				var label = event.data.result[number].label;
				var price = event.data.result[number].price;
				var item = event.data.result[number].name;
				var type = event.data.result[number].type;
				var src = event.data.result[number].src;
				$('#wrapper').fadeOut("fast");
				$('#nav').fadeOut("fast");
				$('#cart').fadeOut("fast");
				$('#phuongtien').fadeOut("fast");
				$('#quanao').fadeOut("fast");
				$('#vatpham').fadeOut("fast");
				$('#khac').fadeOut("fast");
				if (type == 'item'){
					$('#xacnhan').append(
						`
						<div class = "image2" label = ${label} price = ${price}>
						<img src="nui://esx_inventoryhud/html/img/items/${item}.png" style='height: 60%; width: 60%; object-fit: contain'/>
						<h3>${label}</h3>
						<h5>$${price} per item</h5>
						<div style = " margin-top: 3.704vh">
						<input type="number" id = 'text' class = "textareas" placeholder = "Bao nhiêu?"></textarea>
						<button class = "button" id = "buybutton2" item = ${item} price = ${price} type = ${type} style = "style= width: 70px">Mua</button>
						<button class = "button" id = "back" style = "style= width: 70px">Trở về</button>
						</div>
						</div>`
					);
					$('#xacnhan').fadeIn("fast");
				}else{
					if (type == "weapon"){
						src = `nui://esx_inventoryhud/html/img/items/${item}.png`
					}
					$('#xacnhan').append(
						`
						<div class = "image2" label = ${label} price = ${price}>
						<img src="${src}" style='height: 60%; width: 60%; object-fit: contain'/>
						<h3>${label}</h3>
						<h5>$${price} per item</h5>
						<div style = " margin-top: 3.704vh">
						<button class = "button" id = "buybutton2" item = ${item} price = ${price} type = ${type} style = "style= width: 70px">Mua</button>
						<button class = "button" id = "back" style = "style= width: 70px">Trở về</button>
						</div>
						</div>`
					);
					$('#xacnhan').fadeIn("fast");
				}
			});
			$("body").on("click", "#buybutton2", function() {
				var item = $(this).attr('item');
				var price = $(this).attr('price');
				var type = $(this).attr('type');
				if (type == 'item'){
					var value = document.getElementById("text").value;
				}else{
					var value = 1;
				}
				console.log(value);
				var isNumber = isNaN(value) === false;
				if ((parseInt(price) * parseInt(value)) <= parseInt(event.data.cash) && parseInt(value) != 0 && isNumber) {

					$.post('http://lorraxs_cashshop/escape', JSON.stringify({}));
				
					location.reload(true);

					$('#wrapper').fadeOut("fast");
					$('#payment').fadeOut("fast");
					$('#cart').fadeOut("fast");
					$('#phuongtien').fadeOut("fast");
					$('#quanao').fadeOut("fast");
					$('#vatpham').fadeOut("fast");
					$('#khac').fadeOut("fast");
					$('#xacnhan').fadeOut("fast");
					$.post('http://lorraxs_cashshop/buy', JSON.stringify({type : type, name : item, price : price, amount : value}));
				} 
				else {
					$.post('http://lorraxs_cashshop/notify', JSON.stringify({msg : "~r~Bạn không đủ khả năng để mua vật phẩm hoặc phương tiện này!"}));
				}
			});
			$("body").on("click", "#back", function() {
				$.post('http://lorraxs_cashshop/escape', JSON.stringify({}));
				location.reload(true);
				$('#wrapper').fadeOut("fast");
				$('#payment').fadeOut("fast");
				$('#cart').fadeOut("fast");
				$('#phuongtien').fadeOut("fast");
				$('#quanao').fadeOut("fast");
				$('#vatpham').fadeOut("fast");
				$('#khac').fadeOut("fast");
				$('#xacnhan').fadeOut("fast");
				$.post('http://lorraxs_cashshop/refresh', JSON.stringify({}));
			});
		}
	});

	


	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://lorraxs_cashshop/escape', JSON.stringify({}));
			location.reload(true);
			$.post('http://lorraxs_cashshop/emptycart', JSON.stringify({}));
			$('#wrapper').fadeOut("fast");
						$('#payment').fadeOut("fast");
						$('#cart').fadeOut("fast");
						$('#phuongtien').fadeOut("fast");
						$('#quanao').fadeOut("fast");
						$('#vatpham').fadeOut("fast");
						$('#khac').fadeOut("fast");
						$('#xacnhan').fadeOut("fast");
		}
	}
});
