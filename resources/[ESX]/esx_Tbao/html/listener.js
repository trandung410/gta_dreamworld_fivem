var audio = new Audio('audio.mp3');
audio.volume = 0.2;
function sleep(ms) {
	return new Promise(resolve => setTimeout(resolve, ms));
}
window.addEventListener('message', (event) => {
	var item = event.data;
	var elem = document.getElementById("container");
	if (item !== undefined && item.type === "ui") {
		if (item.display === true) {
            document.getElementById('smaller').innerHTML = '<marquee><p>'+event.data.msg+'</p></marquee>';
			$("#container").show();
			audio.play();
		} else{	
			$("#container").hide();
			audio.pause();
			audio.currentTime = 0;	
		}
	}
});