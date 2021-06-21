
$(function () {
	window.addEventListener('message', function (event) {
		if (event.data.type == 'shop') {
			$('#wrapper').show("fast");


			var i1;
			var id = 750;

			if (event.data.result.length > 10) {
				for (i1 = 0; i1 < (event.data.result.length - 10) / 5; i1++) {
					id = id + 375
				}
			}

			var i;
			for (i = 0; i < event.data.result.length; i++) {
				if (event.data.pos == 'getVehicle') {
					var dongco = event.data.result[i].value.vehicle.engineHealth / 10;
					if (event.data.result[i].stored == '1') {
						if (event.data.result[i].value.vehicle.vehicleType == '8') {
							$('#wrapper').append(
								`<div class = "image" id = ${i} >
									<img src= "https://i.imgur.com/V4EPFoP.png" style='height: 80%; width: 80%; object-fit: contain'/> 
									<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
									<h4 class = "h4" style = "color : #42f54b;">🚧 Trong Garage</h4>
									<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
									<h5 class = "h4">Độ bền: ${dongco}%</h5>
									<div style = " margin-top: 3.704vh">
									<button class = "button" id = "buybutton" number = ${i} style = "style= width: 70px">⭐ Lấy xe</button>
									<button class = "button" id = "changename" number = ${i} style = "style= width: 70px">💳 Đổi tên</button>
									</div>
								</div>`
							);
						} else {
							$('#wrapper').append(
								`<div class = "image" id = ${i} >
									<img src="https://i.imgur.com/XPsSqqr.png" style='height: 80%; width: 80%; object-fit: contain'/> 
									<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
									<h4 class = "h4" style = "color : #42f54b;">🚧 Trong Garage</h4>
									<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
									<h5 class = "h4">Độ bền: ${dongco}%</h5>
									<div style = " margin-top: 3.704vh">
									<button class = "button" id = "buybutton" number = ${i} style = "style= width: 70px">⭐ Lấy xe</button>
									<button class = "button" id = "changename" number = ${i} style = "style= width: 70px">💳 Đổi tên</button>
									</div>
								</div>`
							);
						}
					} else if (event.data.result[i].stored == '5') {
						if (event.data.result[i].value.vehicle.vehicleType == '8') {
							$('#wrapper').append(
								`<div class = "image" id = ${i} >
									<img src= "https://i.imgur.com/V4EPFoP.png" style='height: 80%; width: 80%; object-fit: contain'/> 
									<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
									<h4 class = "h4" style = "color : #42f54b;">🚧 Trong Garage Ở nhà</h4>
									<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
									<h5 class = "h4">Độ bền: ${dongco}%</h5>
									<div style = " margin-top: 3.704vh">
									<button class = "button" id = "changename" number = ${i} style = "style= width: 70px">💳 Đổi tên</button>
									</div>
								</div>`
							);
						} else {
							$('#wrapper').append(
								`<div class = "image" id = ${i} >
									<img src="https://i.imgur.com/XPsSqqr.png" style='height: 80%; width: 80%; object-fit: contain'/> 
									<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
									<h4 class = "h4" style = "color : #42f54b;">🚧 Trong Garage Ở nhà</h4>
									<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
									<h5 class = "h4">Độ bền: ${dongco}%</h5>
									<div style = " margin-top: 3.704vh">
									<button class = "button" id = "changename" number = ${i} style = "style= width: 70px">💳 Đổi tên</button>
									</div>
								</div>`
							);
						}
					} else {
						if (event.data.result[i].value.vehicle.vehicleType == '8') {
							$('#wrapper').append(
								`<div class = "image" id = ${i} >
									<img src="https://i.imgur.com/NC34aPT.png" style='height: 80%; width: 80%; object-fit: contain'/> 
									<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
									<h4 class = "h4" style = "color : #ed1325;">🚧 Ngoài Garage</h4>
									<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
									<h5 class = "h4">Độ bền: ${dongco}%</h5>
									<div style = " margin-top: 3.704vh">
									</div>
								</div>`
							);
						} else {
							$('#wrapper').append(
								`<div class = "image" id = ${i} >
									<img src="https://i.imgur.com/3jeH6Wb.png" style='height: 80%; width: 80%; object-fit: contain'/> 
									<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
									<h4 class = "h4" style = "color : #ed1325;">🚧 Ngoài Garage</h4>
									<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
									<h5 class = "h4">Độ bền: ${dongco}%</h5>
									<div style = " margin-top: 3.704vh">
									</div>
								</div>`
							);
						}
					}
				} else {
					var dongco = event.data.result[i].value.vehicle.engineHealth / 10;
					if (event.data.result[i].value.vehicle.vehicleType == '8') {
						$('#wrapper').append(
							`<div class = "image" id = ${i} >
								<img src="https://i.imgur.com/NC34aPT.png" style='height: 80%; width: 80%; object-fit: contain'/> 
								<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
								<h4 class = "h4" style = "color : #ed1325;">🚧 Ngoài Garage</h4>
								<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
								<h5 class = "h4">Độ bền: ${dongco}%</h5>
								<div style = " margin-top: 3.704vh">
								<button class = "button" id = "buybutton" number = ${i} style = "style= width: 70px">⭐ Lấy xe</button>
								</div>
							</div>`
						);
					} else {
						$('#wrapper').append(
							`<div class = "image" id = ${i} >
								<img src="https://i.imgur.com/3jeH6Wb.png" style='height: 80%; width: 80%; object-fit: contain'/> 
								<h3 class = "h4">🚘 ${event.data.result[i].name}</h3>
								<h4 class = "h4" style = "color : #ed1325;">🚧 Ngoài Garage</h4>
								<h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
								<h5 class = "h4">Độ bền: ${dongco}%</h5>
								<div style = " margin-top: 3.704vh">
								<button class = "button" id = "buybutton" number = ${i} style = "style= width: 70px">⭐ Lấy xe</button>
								</div>
							</div>`
						);
					}
				}

			}

			$('#wrapper').append(`<h6 class = "h4" style = "right: 47.125%; position: absolute;" bottom = ${id - 5}>Remaker by: Duy</h6>`)

			if (event.data.owner == true) {
				$('#wrapper').append(
					`
					<button class = "button" id = "bossactions" style = "position: absolute; right: 15px; top: 5px;">Boss actions</button>
					`
				);
			}

			$("body").on("click", "#changename", function () {
				var number = $(this).attr('number');
				var plate = event.data.result[number].plate;
				$.post('http://esx_advancedgarage/changeName', JSON.stringify({ plate: plate }));
				location.reload(true);
				$('#wrapper').hide("fast");
			})

			$("body").on("click", "#buybutton", function () {
				var number = $(this).attr('number');
				var vehicle = event.data.result[number].value.vehicle;
				var plate = event.data.result[number].plate;
				var stored = event.data.result[number].stored;
				if (stored == '1') {
					$.post('http://esx_advancedgarage/spawnVehicle', JSON.stringify({ vehicle: vehicle, plate: plate }));
					$.post('http://esx_advancedgarage/escape', JSON.stringify({}));
					location.reload(true);
					$('#wrapper').hide("fast");
				} else if (event.data.pos == 'returnVehicle') {
					$.post('http://esx_advancedgarage/returnVehiclePound', JSON.stringify({ vehicle: vehicle, plate: plate }));
					$.post('http://esx_advancedgarage/escape', JSON.stringify({}));
					location.reload(true);
					$('#wrapper').hide("fast");
				} else {
					$.post('http://esx_advancedgarage/notify', JSON.stringify({ msg: 'Xe của bạn đã mất' }));
				}

			});


			$("body").on("click", "#bossactions", function () {
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
