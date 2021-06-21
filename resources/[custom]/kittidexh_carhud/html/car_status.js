var prices = {}
var page = "menu";
var maxes = {}
var zone = null
var Config = new Object();
Config.closeKeys = [113, 27, 90];


// Partial Functions
function closeMain() {
	$("body").css("display", "none");

}
function openMain() {
	$("body").css("display", "block");
	
}

$(".close").click(function(){
	$.post('http://readyplus-market/quit', JSON.stringify({}));
	
});

// Listen for NUI Events
window.addEventListener('message', function (event) {

	var item = event.data;

	var streetName = event.data.streetName,
	hasBelt = event.data.hasBelt,
	beltOn = event.data.beltOn,
	gear = event.data.gear,
	engineStatus = event.data.engineStatus,
    maxGear = event.data.maxGear;

	this.document.querySelector('.placeName').innerHTML = streetName;
	this.document.getElementById('gearNum').innerHTML = gear;
	

	if(hasBelt) {
		this.document.getElementById('belt').style.display = ""
	} else {
		this.document.getElementById('belt').style.display = "none"
	}

	if(beltOn && hasBelt) {
		document.getElementById('belt').classList.add('active');
	} else if(!beltOn && hasBelt) {
		document.getElementById('belt').classList.remove('active');
	}

	if(engineStatus) {
		document.getElementById('engine').classList.add('active');
		document.getElementById('engine').getElementsByTagName('p')[0].innerHTML = "ON";
		document.getElementById('engine').getElementsByTagName('p')[0].style.paddingLeft = "3px";
	} else {
		document.getElementById('engine').classList.remove('active');
		document.getElementById('engine').getElementsByTagName('p')[0].innerHTML = "OFF";
		document.getElementById('engine').getElementsByTagName('p')[0].style.paddingLeft = "";
	}

	// Open & Close main window
	if (item.message == "show") {
		openMain();
		document.querySelector('.header h5').innerHTML = item.speed + "<span style='font-size:10px;opacity:50%;font-weight:400;'>";
		document.querySelector('.fuel span').innerHTML = item.fuel + "/100";
	}

	if (item.message == "hide") {
		closeMain();
	}

});

async function insertGear(amount) {
    gearReady = false;
    elmGear.innerHTML = "";
    elmGear.style.width = (amount * 13) + 'px';
    elmGear.style.marginLeft = ((6 - amount) * 14) + 'px';
    for(var i = 0; i <= (amount - 1); i++) {
        await sleep(100);
        var spanG = document.createElement('span');
        spanG.innerHTML = (i + 1);
        elmGear.appendChild(spanG);
    }
    gearReady = true;
}