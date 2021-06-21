(() => {

	ESX = {};
	ESX.HUDElements = [];

	ESX.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	ESX.insertHUDElement = function (name, index, priority, html, data) {
		ESX.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		ESX.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	ESX.updateHUDElement = function (name, data) {

		for (let i = 0; i < ESX.HUDElements.length; i++) {
			if (ESX.HUDElements[i].name == name) {
				ESX.HUDElements[i].data = data;
			}
		}

		ESX.refreshHUD();
	};

	ESX.deleteHUDElement = function (name) {
		for (let i = 0; i < ESX.HUDElements.length; i++) {
			if (ESX.HUDElements[i].name == name) {
				ESX.HUDElements.splice(i, 1);
			}
		}

		ESX.refreshHUD();
	};

	ESX.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < ESX.HUDElements.length; i++) {
			let html = Mustache.render(ESX.HUDElements[i].html, ESX.HUDElements[i].data);
			$('#hud').append(html);
		}
	};
    /*
	ESX.inventoryNotification = function (add, item, count) {
		let notif = '';

		if (add) {
			notif += '+';
		} else {
			notif += '-';
		}

		notif += count + ' ' + item.label;

		let elem = $('<div>' + notif + '</div>');

		$('#inventory_notifications').append(elem);

		$(elem).delay(3000).fadeOut(1000, function () {
			elem.remove();
		});
	};
    */
	window.onData = (data) => {
		switch (data.action) {
			case 'setHUDDisplay': {
				ESX.setHUDDisplay(data.opacity);
				break;
			}

			case 'insertHUDElement': {
				ESX.insertHUDElement(data.name, data.index, data.priority, data.html, data.data);
				break;
			}

			case 'updateHUDElement': {
				ESX.updateHUDElement(data.name, data.data);
				break;
			}

			case 'deleteHUDElement': {
				ESX.deleteHUDElement(data.name);
				break;
			}

			case 'inventoryNotification': {
				ESX.inventoryNotification(data.add, data.item, data.count);
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();
$(document).ready(function() {
	var currentAppend = 0;
	$('#heal0').hide();
/*    $('#heal1').hide();
   $('#heal2').hide();
   $('#heal3').hide(); 
   $('#heal4').hide(); */ 
   window.addEventListener('message', function(event) {
	   var data = event.data;
	   $(".lorraxs").css("display", data.show? "block":"none");
	   /* if(currentAppend > 0){
			for (i = 0; i < currentAppend; i++){
				var id = "heal" + (i + 1);
				$('.container').remove('#'+id);
			}
	   }; */
	   $('.appendClass').remove();
	   if(data.show == true){
			$('#heal0').show();
			$("#boxHeal0").css("width", data.nuiData.ownerHealth + "%");
			$("#boxHeal0").text(data.nuiData.ownerName);
		   if (data.nuiData.player.length > 0 ){
			   currentAppend = data.nuiData.player.length;
			   for (i = 0; i < currentAppend; i++){
					var id = "heal" + (i + 1);
					$('.lorraxs').append(
							`<div id = ${id} class='heal appendClass'>
								<div id = ${"boxHeal" + (i + 1)} class="text boxHeal";"></div>
							</div>`
					);
					$("#boxHeal" + (i + 1)).css("width", data.nuiData.player[i].health + "%");
					$("#boxHeal" + (i + 1)).text(data.nuiData.player[i].name); 
			   }
		   }
	   }
	   
   })
})