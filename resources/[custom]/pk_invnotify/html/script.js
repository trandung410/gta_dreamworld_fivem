var toastrs= {};

$(function(){
	window.onload = (e) => { 
		window.addEventListener('message', (event) => {	            
			if(event.data.options && event.data.type == 'notify'){
				var inventor_url = 'nui://' + event.data.options.inventory;
				var options = event.data.options;

				options.name = event.data.item.label;
				options.image = inventor_url + event.data.item.name + '.png';
				imageExists(options.image, function(exists) {
					if(exists == false){
						options.image = 'no-image.png'
					}
					
					sendNotify(options);
				});

				
			} else if (event.data.type == 'clear'){
				toastr.clear(toastrs[event.data.number], { force: true });
			}
		});
	};
});

function imageExists(url, callback) {
	var img = new Image();
	img.onload = function() { callback(true); };
	img.onerror = function() { callback(false); };
	img.src = url;
}

function sendNotify(options){
	var toastr_options = {
		timeOut: options.timeout, 
		action: options.action
	};
	
	if (options.type=='add') {
		var $toast = toastr.success(options.name, options.image, toastr_options); 
	} else if (options.type=='remove') {
		var $toast = toastr.error(options.name, options.image, toastr_options); 
	} else if (options.type == 'use') {
		var $toast = toastr.warning(options.name, options.image, toastr_options); 
	}
}