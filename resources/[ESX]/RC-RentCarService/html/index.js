


function sportsSelected() {
    var sport = document.getElementById("supercars");
    var classic = document.getElementById("classiccars");
    var motorcycle = document.getElementById("motorcyclecars");
    
    sport.style.display = "block";
    classic.style.display = "none";
    motorcycle.style.display = "none";
      //x.style.display = "block";
    
}

function classicSelected() {
    var sport = document.getElementById("supercars");
    var classic = document.getElementById("classiccars");
    var motorcycle = document.getElementById("motorcyclecars");

    classic.style.display = "block";
    sport.style.display = "none";
    motorcycle.style.display = "none";
      //x.style.display = "block";
    
}

function motorcycleSelected() {
    var sport = document.getElementById("supercars");
    var classic = document.getElementById("classiccars");
    var motorcycle = document.getElementById("motorcyclecars");
    
    motorcycle.style.display = "block";
    sport.style.display = "none";
    classic.style.display = "none";
      //x.style.display = "block";
    
}







function askPlayerBGTrigger() {
    var carRentalBG = document.getElementById("windowBG");
    var askPlayerBG = document.getElementById("windowBG2");

    carRentalBG.style.display = "none";
    askPlayerBG.style.display = "block";
}


function closeAsk() {
    var carRentalBG = document.getElementById("windowBG");
    var askPlayerBG = document.getElementById("windowBG2");

    carRentalBG.style.display = "block";
    askPlayerBG.style.display = "none";
}









$(function () {
    var playerAskModelName = document.getElementById("modelName");

    function display(bool) {
        if (bool) {
            $("#shopMenu").show();
        } else {
            $("#shopMenu").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://RC-RentCarService/exit', JSON.stringify({}));
            return
        }
    };
    //when the user clicks on the submit button, it will run
    $("#closeBtn").click(function () {
        $.post('http://RC-RentCarService/exit', JSON.stringify({}));
        return
    })


    $("#acceptAsk").click(function () {

        closeAsk()
        $.post('http://RC-RentCarService/askAccept', JSON.stringify({}));
        return
    })


    $("#slot1Supercar").click(function () {
        //askPlayerBG.style.display = "none";
        playerAskModelName.innerHTML = "T20";
        askPlayerBGTrigger()

        $.post('http://RC-RentCarService/slot1SportSelected', JSON.stringify({}));
        return
    })

    $("#slot2Supercar").click(function () {
        //askPlayerBG.style.display = "none";
        playerAskModelName.innerHTML = "ADDER";
        askPlayerBGTrigger()

        $.post('http://RC-RentCarService/slot2SportSelected', JSON.stringify({}));
        return
    })




    $("#slot1Classic").click(function () {
        //askPlayerBG.style.display = "none";
        playerAskModelName.innerHTML = "ASEA";
        askPlayerBGTrigger()

        $.post('http://RC-RentCarService/slot1ClassicSelected', JSON.stringify({}));
        return
    })

    $("#slot2Classic").click(function () {
        //askPlayerBG.style.display = "none";
        playerAskModelName.innerHTML = "PANTO";
        askPlayerBGTrigger()

        $.post('http://RC-RentCarService/slot2ClassicSelected', JSON.stringify({}));
        return
    })





    $("#slot1Motorcycle").click(function () {
        //askPlayerBG.style.display = "none";
        playerAskModelName.innerHTML = "BATI";
        askPlayerBGTrigger()

        $.post('http://RC-RentCarService/slot1MotorcycleSelected', JSON.stringify({}));
        return
    })

    $("#slot2Motorcycle").click(function () {
        //askPlayerBG.style.display = "none";
        playerAskModelName.innerHTML = "AKUMA";
        askPlayerBGTrigger()

        $.post('http://RC-RentCarService/slot2MotorcycleSelected', JSON.stringify({}));
        return
    })

    
})