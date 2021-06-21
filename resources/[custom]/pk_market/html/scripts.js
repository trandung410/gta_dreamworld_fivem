var prices = {}
var page = "menu";
var maxes = {}
var zone = null
var Config = new Object();
Config.closeKeys = [113, 27, 90];


// Partial Functions
function closeMain() {
	$("shop-container").css("left", "-300px")
	$("body").css("display", "none");

}
function openMain() {
	$("body").css("display", "block");

}
function closeAll() {
	$(".body").css("display", "none");
}
$(".close").click(function(){
	$.post('http://pk_market/quit', JSON.stringify({}));
	
});


$("body").on("keyup", function (key) {
	if (Config.closeKeys.includes(key.which)) {
		setTimeout(3000)
		$.post('http://pk_market/quit', JSON.stringify({}));
		
	}
});
// Listen for NUI Events
window.addEventListener('message', function (event) {

	var item = event.data;

	// Open & Close main window
	if (item.message == "show") {
		if (item.clear == true){
			$( ".home" ).empty();
			prices = {}
			maxes = {}
			zone = null
		}
		openMain();
	}

	if (item.message == "hide") {
		closeMain();
	}
	
	if (item.message == "add"){
		$( ".home" ).append('<div class="card">' +
					'<div class="price">' + item.price + '$' + '</div>' +
					'<div class="ham"><img src="nui://esx_inventoryhud/html/img/items/' + item.item + '.png" alt="' +  '" style="width:100%;margin:auto;"></div>' + 
		
					'<div class="buy" name="' + item.item + '">Mua</div>' + 
						
					
			
				'</div>');
				$('menu').hide();	
		prices[item.item] = item.price;
		maxes[item.item] = item.max;
		zone = item.loc;
	}
});



$(".home").on("click", ".buy", function() {
	var $button = $(this);
	var $name = $button.attr('name')
	var $input = parseInt($("#count").val())
            swal({
               title: "Xác nhận mua hàng",
               text: "Bạn có đồng ý mua mặt hàng này?",
			   icon: "warning",
			   buttons: true,
               dangerMode: true,
			   className: 'swt',
			 
			   
            })
            .then((willDelete) => {
                if (willDelete) {
                    $.post('http://pk_market/purchase', JSON.stringify({
				    item: $name,
				    count: $input,
				    loc: zone
				}));
                }
                
            });
	// $.post('http://readyplus-market/purchase', JSON.stringify({
	// 	item: $name,
	// 	count: $count,
	// 	loc: zone
	// }));
});

