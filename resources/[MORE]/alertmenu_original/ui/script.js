$(document).ready(function () {
	// Retrieval form vars

	window.addEventListener('message', function (event) {
		var data = event.data;
		if (data.action === "open") {
			if (data.enermy == 1) {
				$('#retrieve-form').css('display', 'block');
				SetupDataTable(data);
			} else {
				$('#main-form').css('display', 'block');
			}
		} else if (data.action === "refresh") {
			SetupDataTable(data);
		}

		if (data.action == "close") {
			$('#main-form2').css('display', 'none');

			$('#retrieve-form').css('display', 'none');
			$('#main-form').css('display', 'none');

		}
	});

	// On 'Esc' call close method
	document.onkeyup = function (data) {
		if (data.which == 27 ) {
			$.post('http://alertmenu_original/escape', JSON.stringify({}));
		}
	};

	$('#ping-police, #ping-ambulance, #ping-mechanic, #ping-taxi').click(function () {
		var tab = $(this).val()
		$.post('http://alertmenu_original/PingAlert', JSON.stringify(tab));

	});

	$('#ping-tasklist').click(function () {
		$.post('http://alertmenu_original/OpenMenu', JSON.stringify());
	});
	function SetupDataTable(data) {
		var vehicleHtml = "";
		for(var i = 0; i < data.alert.length; i++) {
			var type = ""
			var officer = "";
			

	
			if (data.alert[i].type == 'police') {
				type = 'Cảnh Sát';
			} else if (data.alert[i].type == 'ambulance'){
				type = 'Bác Sĩ';

			} else if (data.alert[i].type == 'mechanic'){
				type = 'Sửa xe';

			} else if (data.alert[i].type == 'taxi'){
				type = 'Taxi';

			} 
			var row = `<tr>
				<td id="type">${type}</td>
				<td id="sender">${data.alert[i].name}</td>
				<td id="price">${data.alert[i].sdt}</td>
				<td id="distance">${data.alert[i].distance}m</td>`

			var tb = JSON.stringify({
				steamid : data.alert[i].sender,
				type : data.alert[i].type,
				coords : data.alert[i].coords 
			})

			if(data.alert[i].accept == 0) {

				button = `<td>
					<button class="btn accept" id="accept" value=${tb}>Nhận</button>
				</td></tr>`

			} else {
				if (data.alert[i].mytask == 1) {
					button = `<td>
						<button class="btn ping" id="ping" value=${data.alert[i].coords}>Ping vị trí</button>
						<button class="btn success" id="success" value=${tb}>Hoàn thành</button>
						<button class="btn cancel" id="cancel" value=${tb}>Hủy</button>
					</td></tr>`
				} else {
					button = `<td>
						<a>${data.alert[i].recived} đã nhận</a>
					</td></tr>`
				}
			}
			row = row + button;
			vehicleHtml = vehicleHtml + row;
		}
		if (vehicleHtml == "") {
			vehicleHtml = `<br><a style="color: rgb(255, 255, 255); text-align: center;">Không có yêu cầu dịch vụ</a>`
		}
		$('#impounded-vehicles').html(vehicleHtml);
	}
	
	$('table').on('click', '.accept', function () {
		var tab = $(this).val()
		$.post('http://alertmenu_original/accept', JSON.stringify(tab));
	});

	$('table').on('click', '.success', function () {
		var tab = $(this).val()
		$.post('http://alertmenu_original/success', JSON.stringify(tab));
	});

	$('table').on('click', '.cancel', function () {
		var tab = $(this).val()
		$.post('http://alertmenu_original/cancel', JSON.stringify(tab));
	});


	$('table').on('click', '.ping', function () {
		$.post('http://alertmenu_original/ping', JSON.stringify($(this).val()));
	});

	$('table').on('click', '.unlock', function () {
		var plate = $(this).parent().parent().find('#plate').text();
		$.post('http://alertmenu_original/unlock', JSON.stringify(plate));
	});



	$('#cancel, #exit').click(function (event) {
		$.post('http://alertmenu_original/escape', null);
	});
	
});
