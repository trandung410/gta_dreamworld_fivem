$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var data = event.data;
		// $(".container").css("display",data.show? "none":"block");
		

        var food = event.data.food;
        $("#boxHunger").css("width", food + "%");
        var water = event.data.water;
		$("#boxThirst").css("width", water + "%");
		
		$("#playerid").html(data.id + "  <i class='fas fa-hashtag'></i>");
		
		if (data.health >= 100){
			$('#box').css("background", "linear-gradient(130deg, rgba(183,52,219,1) 0%, rgba(18, 158, 228, 0.7) 100%)")
		}else if(data.health <= 30){
			$('#box').css("background", "rgba(212,30,24,0.5)")
		}

		if (data.stamina >= 51){
			$('#boxStamina').css("background", "linear-gradient(130deg, rgba(183,52,219,1) 0%, rgba(18, 158, 228, 0.7) 100%)")
		}else if(data.stamina <= 50){
			$('#boxStamina').css("background", "rgba(212,30,24,0.5)")
		}

		if (data.dive >= 51){
			$('#boxDive').css("background", "linear-gradient(130deg, rgba(183,52,219,1) 0%, rgba(18, 158, 228, 0.7) 100%)")
		}else if(data.dive <= 50){
			$('#boxDive').css("background", "rgba(212,30,24,0.5)")
		}

		if (data.food >= 50){
			$('#boxHunger').css("background", "linear-gradient(130deg, rgba(183,52,219,1) 0%, rgba(18, 158, 228, 0.7) 100%)")
		}else if(data.food <= 50){
			$('#boxHunger').css("background", "rgba(212,30,24,0.5)")
		}

		if (data.water >= 51){
			$('#boxThirst').css("background", "linear-gradient(130deg, rgba(183,52,219,1) 0%, rgba(18, 158, 228, 0.7) 100%)")
		}else if(data.water <= 50){
			$('#boxThirst').css("background", "rgba(212,30,24,0.5)")
		}


        if (data.armor == 0) {
            $("#armor").hide();
		} else if (data.armor > 10) {
            $("#armor").show();
			$("#boxArmor").css("width", data.armor + "%");
		} else if (data.armor <= 10) {
			$("#armor").show();
			$("#boxArmor").css("width", data.armor + "%");
		}

        if (data.stamina >= 100) {
            $("#stamina").hide();
		} else if (data.stamina > 10) {
			$("#stamina").show();
			$("#boxStamina").css("width", data.stamina + "%");
		} else if (data.stamina <= 10) {
			$("#stamina").show();
			$("#boxStamina").css("width", data.stamina + "%");
        }
        
        if (data.dive >= 100) {
			$("#dive").hide();
		} else if (data.dive > 32) {
			$("#dive").show();
			$("#boxDive").css("width", data.dive + "%");
		} else if (data.dive <= 32) {
			$("#dive").show();
			$("#boxDive").css("width", data.dive + "%");
		}

		if (data.health != -100){
			$('#healtlevel').html(Math.round(data.health))
		}else if(data.health == 0){
			$('#healtlevel').html("0")
		}

		if (data.stamina != 100){
			$('#staminalevel').html(Math.round(data.stamina))
		}else if(data.stamina == 0){
			$('#staminalevel').html("0")
		}

		if (data.armor != 100){
			$('#armorlevel').html(Math.round(data.armor))
		}else if(data.armor == 0){
			$('#armorlevel').html("0")
		}

		if (data.dive != 100){
			$('#divelevel').html(Math.round(data.dive))
		}else if(data.dive == 0){
			$('#divelevel').html("0")
		}

		if (data.food != 100){
			$('#hungerlevel').html(Math.round(data.food))
		}else if(data.food == 0){
			$('#hungerlevel').html("0")
		}

		if (data.water != 100){
			$('#waterlevel').html(Math.round(data.water))
		}else if(data.water == 0){
			$('#waterlevel').html("0")
		}

    })
})


