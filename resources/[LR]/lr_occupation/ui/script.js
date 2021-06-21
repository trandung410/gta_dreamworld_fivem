$(document).ready(function() {

    window.addEventListener("message", function(event) {
        if (event.data.update == true) {		
			setImageIcon(event.data.url)
			
        };
		if (event.data.display == true){
			
			
			
			
			$(".hud1").fadeIn();
			
			$("#thongBao").append(`
				<marquee id="reason" style="margin: 10px 0px 0px 0px; color: #310E02"></marquee>
			`)


			document.getElementById('reason').innerHTML = 'Thông Báo : ' +event.data.playerName+ ' đang chiếm đóng khu vực ' +event.data.vitri+ ' !'
			
			
			
			
			
		}else if (event.data.display == false){
			$(".hud1").fadeOut();
			$('marquee').remove('#reason');
		};
		
		
    });
	
   
    

});