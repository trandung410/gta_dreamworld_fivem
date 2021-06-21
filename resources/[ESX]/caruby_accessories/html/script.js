(() => {

	TEZ = {};
	TEZ.HUDElements = [];

	TEZ.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	TEZ.insertHUDElement = function (name, index, priority, html, data) {
		TEZ.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		TEZ.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	TEZ.updateHUDElement = function (name, data) {

		for (let i = 0; i < TEZ.HUDElements.length; i++) {
			if (TEZ.HUDElements[i].name == name) {
				TEZ.HUDElements[i].data = data;
			}
		}

		TEZ.refreshHUD();
	};

	TEZ.deleteHUDElement = function (name) {
		for (let i = 0; i < TEZ.HUDElements.length; i++) {
			if (TEZ.HUDElements[i].name == name) {
				TEZ.HUDElements.splice(i, 1);
			}
		}

		TEZ.refreshHUD();
	};

	TEZ.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < TEZ.HUDElements.length; i++) {
			let html = Mustache.render(TEZ.HUDElements[i].html, TEZ.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

	TEZ.inventoryNotification = function (add, item, count) {
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

	window.onData = (data) => {
		switch (data.action) {
			case 'setHUDDisplay': {
				TEZ.setHUDDisplay(data.opacity);
				break;
			}

			case 'insertHUDElement': {
				TEZ.insertHUDElement(data.name, data.index, data.priority, data.html, data.data);
				break;
			}

			case 'updateHUDElement': {
				TEZ.updateHUDElement(data.name, data.data);
				break;
			}

			case 'deleteHUDElement': {
				TEZ.deleteHUDElement(data.name);
				break;
			}

			case 'inventoryNotification': {
				TEZ.inventoryNotification(data.add, data.item, data.count);
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();