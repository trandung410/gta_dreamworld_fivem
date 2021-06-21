
$(function () {
	window.addEventListener('message', function (event) {

		switch (event.data.action) {
			case 'open':					
				$('#wrap').fadeIn();
				break;

			case 'close':
				$('#wrap').fadeOut();
				break;

			

			case 'updatePlayerJobs':
				var jobs = event.data.jobs;

				$('#player_count').html(jobs.player_count);

				$('#ems').html(jobs.ems);
				$('#police').html(jobs.police);
				$('#taxi').html(jobs.taxi);
				$('#mechanic').html(jobs.mechanic);
				$('#mafia').html(jobs.mafia);
				$('#biker').html(jobs.biker);
				$('#cartel').html(jobs.cartel);
				$('#gang').html(jobs.gang);
				break;

			case 'updatePlayerList':
				$('#playerlist tr:gt(0)').remove();
				$('#playerlist').append(event.data.players);
				sortPlayerList();
				break;

		
			case 'updateServerInfo':
				
				if (event.data.maxPlayers) {
					$('#max_players').html(event.data.maxPlayers);
				}

				if (event.data.uptime) {
					$('#server_uptime').html(event.data.uptime);
				}

				if (event.data.playTime) {
					$('#play_time').html(event.data.playTime);
				}

				break;

		
		}
	}, false);
});
 var Config = new Object();
Config.closeKeys = [231, 27, 90, 65, 83, 68];
// Todo: not the best code
$(document).ready(function () {
	$(document).on("keyup", function (key) {
		//console.log(key.key)
       // if (Config.closeKeys.includes(key.which)) {
			$.post("http://esx_scoreboard/NUIFocusOff", JSON.stringify({}));
        //}
    });
});
 
function sortPlayerList() {
	var table = $('#playerlist'),
		rows = $('tr:not(.heading)', table);

	rows.sort(function(a, b) {
		var keyA = $('td', a).eq(1).html();
		var keyB = $('td', b).eq(1).html();

		return (keyA - keyB);
	});

	rows.each(function(index, row) {
		table.append(row);
	});
}
