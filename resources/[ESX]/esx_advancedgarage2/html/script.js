
$(function() {
		window.addEventListener('message', function(event) {
			if (event.data.type == 'shop') {
				$('#wrapper').show("fast");


			var i1;
			var id = 750;

			if (event.data.result.length > 10) {
				for (i1 = 0; i1 < (event.data.result.length -10) / 5; i1++) { 
					
					/* $('#wrapper').append(
						`<div class="line" style = "top: ${id}px; position: relative;"></div>`
					); */

					id = id + 375
				}
			}

			var i;
			for (i = 0; i < event.data.result.length; i++) {
				/* var dongco = Math.floor(event.data.result[i].engineHealth / 1000 * 100) 
				var thanxe = Math.floor(event.data.result[i].bodyHealth / 1000 * 100)  */
				var dongco = 100;
				var thanxe = 100;
				var src = "https://i.imgur.com/XPsSqqr.png";
				/* if (dongco > 70 & dongco < 90){
					var src = "https://i.imgur.com/dHInKTW.png";
				}else if(dongco <= 70 & dongco > 50){
					var src = "https://i.imgur.com/TDU01SL.png";
				}else if(dongco <= 50 & dongco > 25){
					var src = "https://i.imgur.com/g8R5arC.png";
				}else if(dongco <= 25){
					var src = "https://i.imgur.com/3jeH6Wb.png";
				} */
				var src2 = "https://i.imgur.com/V4EPFoP.png";
				/* if (dongco > 70 & dongco < 90){
					var src2 = "https://i.imgur.com/WtZnWld.png";
				}else if(dongco <= 70 & dongco > 50){
					var src2 = "https://i.imgur.com/3jVUWNf.png";
				}else if(dongco <= 50 & dongco > 25){
					var src2 = "https://i.imgur.com/Lz4OrfS.png";
				}else if(dongco <= 25){
					var src2 = "https://i.imgur.com/NC34aPT.png";
				} */
				if (event.data.result[i].stored == '1'){		
					if(event.data.result[i].vehicleType == '8'){
						$('#wrapper').append(					
							`<div class = "image" id = ${i} >
								<img src= "https://i.imgur.com/V4EPFoP.png" style='height: 80%; width: 80%; object-fit: contain'/> 
								<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
								<h4 class = "h4" style = "color : #42f54b;">🚧 Trong Garage</h4>
								<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
								<h5 class = "h4">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
								<div style = " margin-top: 3.704vh">
								<button class = "button" id = "buybutton" number = ${i} style = "style= width: 70px">⭐ Lấy xe</button>
								</div>
							</div>`
						);
					}else{
						$('#wrapper').append(					
							`<div class = "image" id = ${i} >
								<img src="https://i.imgur.com/XPsSqqr.png" style='height: 80%; width: 80%; object-fit: contain'/> 
								<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
								<h4 class = "h4" style = "color : #42f54b;">🚧 Trong Garage</h4>
								<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
								<h5 class = "h4">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
								<div style = " margin-top: 3.704vh">
								<button class = "button" id = "buybutton" number = ${i} style = "style= width: 70px">⭐ Lấy xe</button>
								</div>
							</div>`
						);
					}
				}else{
					if(event.data.result[i].vehicleType == '8'){
						$('#wrapper').append(					
							`<div class = "image" id = ${i} >
								<img src="https://i.imgur.com/NC34aPT.png" style='height: 80%; width: 80%; object-fit: contain'/> 
								<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
								<h4 class = "h4" style = "color : #ed1325;">🚧 Ngoài Garage</h4>
								<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
								<h5 class = "h4">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
								<div style = " margin-top: 3.704vh">
								<button class = "button" id = "buybutton" number = ${i} style = "style= width: 70px">⭐ Lấy xe</button>
								</div>
							</div>`
						);
					}else{
						$('#wrapper').append(					
							`<div class = "image" id = ${i} >
								<img src="https://i.imgur.com/3jeH6Wb.png" style='height: 80%; width: 80%; object-fit: contain'/> 
								<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
								<h4 class = "h4" style = "color : #ed1325;">🚧 Ngoài Garage</h4>
								<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
								<h5 class = "h4">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
								<div style = " margin-top: 3.704vh">
								<button class = "button" id = "buybutton" number = ${i} style = "style= width: 70px">⭐ Lấy xe</button>
								</div>
							</div>`
						);
					}
				}
			}

			$('#wrapper').append(
				` <h6 class = "h4" style = "right: 47.125%; position: absolute;" bottom = ${id - 5}>Dream World</h6>`
			)

			if (event.data.owner == true) {

				$('#wrapper').append(
					`
					<button class = "button" id = "bossactions" style = "position: absolute; right: 15px; top: 5px;">Boss actions</button>
					`
				);
			}

			var CartCount;

			/* $('.image').on('click', function () {
				//$("#cart").load(location.href + " #cart");

				//$('.carticon').show("fast");

				CartCount = CartCount + 1;
				var item = $(this).attr('id');
				var label = $(this).attr('label');
				var count = $(this).attr('count');
				var price = $(this).attr('price');

				$("#" + item).hide();
				

				$.post('http://esx_advancedgarage/putcart', JSON.stringify({item: item, price : price, label : label, count : count, id : id}), function( cb ) {

					$('#cart').html('');

				var i;
					for (i = 0; i < cb.length; i++) { 

						$('#cart').append(
							`<div class = "cartitem" label = ${cb[i].label} count = ${cb[i].count} price = ${cb[i].price}>
							<h6>${cb[i].label}</h4>
							<h6>$${cb[i].price} per item</h4>
							<h6>In stock: ${cb[i].count}</h4>
							<input type="text" id = ${cb[i].item} count = ${cb[i].count} class = "textareas" placeholder = "How many?"></textarea>
							</div>`
								);
							};

							$('#cart').append(
							`
							<button class = "button" id = "buybutton" style = "position: absolute; right: 15px; top: 5px;">Purchase</button>
							<button class = "button" id = "back" style = "position: absolute; left: 15px; top: 5px;">Back</button>
							`
						);
					});
			});
			
			$('.carticon').on('click', function () {
				$('#cart').show("fast");
				$('#wrapper').hide("fast");
				$('.carticon').hide("fast");
			});

			$("body").on("click", "#refreshcart", function() {
				$.post('http://esx_advancedgarage/escape', JSON.stringify({}));
				location.reload(true);
				$('#wrapper').hide("fast");
				$('#payment').hide("fast");
				$('#cart').hide("fast");
				$.post('http://esx_advancedgarage/refresh', JSON.stringify({}));
			});

			$("body").on("click", "#back", function() {
				$('#cart').hide("fast");
				$('#wrapper').show("fast");
				$('.carticon').show("fast");
			}); */
			$("body").on("click", "#changename", function() {
				var number = $(this).attr('number');
				var plate = event.data.result[number].plate;
				$.post('http://esx_advancedgarage/changeName', JSON.stringify({plate : plate}));
				location.reload(true);
				$('#wrapper').hide("fast");
			}
			)
			$("body").on("click", "#buybutton", function() {
				var number = $(this).attr('number');
				var vehicle = event.data.result[number].value.vehicle;
				var plate = event.data.result[number].plate;
				var stored = event.data.result[number].stored;
				if(stored == '1'){
					$.post('http://esx_advancedgarage/spawnVehicle', JSON.stringify({vehicle : vehicle, plate : plate}));
					$.post('http://esx_advancedgarage/escape', JSON.stringify({}));
					location.reload(true);
					$('#wrapper').hide("fast");
				}else if(event.data.pos == 'returnVehicle'){
					$.post('http://esx_advancedgarage/spawnVehicle1', JSON.stringify({vehicle : event.data.result[number].value, plate : plate}));
					$.post('http://esx_advancedgarage/escape', JSON.stringify({}));
					location.reload(true);
					$('#wrapper').hide("fast");
				}else{
					$.post('http://esx_advancedgarage/notify', JSON.stringify({msg : 'Xe của bạn đã mất'}));
				}
				/* for (i = 0; i < value.length; i++) {

					var isNumber = isNaN(value[i].value) === false;

					var count = $('#' + value[i].id).attr('count');

					if (parseInt(count) >= parseInt(value[i].value) && parseInt(value[i].value) != 0 && isNumber) {

						$.post('http://esx_advancedgarage/escape', JSON.stringify({}));
					
						location.reload(true);

						$('#wrapper').hide("fast");
						$('#payment').hide("fast");
						$('#cart').hide("fast");
						$.post('http://esx_advancedgarage/buy', JSON.stringify({Count : value[i].value, Item : value[i].id}));
					} 
					else {
						$.post('http://esx_advancedgarage/notify', JSON.stringify({msg : "~r~One of the item does not have enough stock or the amount is invalid."}));
					}`
				} */
			});

			
			$("body").on("click", "#bossactions", function() {
				$.post('http://esx_advancedgarage/bossactions', JSON.stringify({}));
				$.post('http://esx_advancedgarage/escape', JSON.stringify({}));
				location.reload(true);
				$.post('http://esx_advancedgarage/emptycart', JSON.stringify({}));
				$('#wrapper').hide("fast");
				$('#payment').hide("fast");
				$('#cart').hide("fast");
			});
		}
	});

	


	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://esx_advancedgarage/escape', JSON.stringify({}));
			location.reload(true);
			$.post('http://esx_advancedgarage/emptycart', JSON.stringify({}));
			$('#wrapper').hide("fast");
			$('#payment').hide("fast");
			$('#cart').hide("fast");
		}
	}
});
