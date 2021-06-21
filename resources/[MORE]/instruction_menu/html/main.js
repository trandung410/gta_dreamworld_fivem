$(function()
{
	window.addEventListener('message', function (event) {
		var item = event.data;
		if (item.action = "update") {
			if (item.show) {
				$(".playerStats").show();
			} else {
				$(".playerStats").hide();
			}
		} 
		if (item.mgs = "toggleT" ){
			if (item.toggle) {
				$(".playerStats").show();
			} else {
				$(".playerStats").hide();
			}
		}
	});

});
