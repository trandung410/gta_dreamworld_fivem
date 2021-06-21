let callnumber
var outgoingsound = null;
var messagesound = null;
var bmessagesound = null;
var incomingsound = null;
var mutes = false;

$(document).on('click', '.phone-enter', function() {
    let number = $(this).data('id');

    var element = document.getElementById("phone-number-enter");
    element.innerHTML = element.innerHTML + number;

    $("#phone-enter-deletelast").fadeIn(250);
});


$(document).on('click', '#phone-enter-deletelast', function() {
    let number = $(this).data('id');

    $("#phone-number-enter").html($("#phone-number-enter").text().replace(/.$/g, ''));

    if ($('#phone-number-enter').text().trim() === "") {
        $("#phone-enter-deletelast").fadeOut(250);
    }
});


$(document).on('click', '.phone-enter-call', function() {
    callnumber = $('#phone-number-enter').val()
    var number = document.getElementById("phone-number-enter");
    var element = document.getElementById("phone-call-outgoing-caller");
    element.innerHTML = number.innerHTML;
    $(".phone-call").hide();
    $(".phone-call-app").show();
    $(".phone-call-outgoing").fadeIn(250);

    if (mutes == true) {
        sendData("notification", { text: locale.yourecallingsb, length: 5000 })
    } else {
        if (outgoingsound != null) {
            outgoingsound.pause();
        }

        outgoingsound = new Audio("./sound/Phonecall.ogg");
        outgoingsound.volume = 0.2;
        outgoingsound.currentTime = 0;
        outgoingsound.loop = true;
        outgoingsound.play();
    }
    sendData("startcall", { number: callnumber });
});


$(document).on('click', '#outgoing-cancel', function() {
    $(".phone-call").fadeIn(250);
    $(".phone-call-app").hide();
    $(".phone-call-outgoing").hide();
    sendData("stopcall")
    outgoingsound.pause();
});

function IncomingCall(number, contact) {
    CloseAll();
    $(".phone-call-app").show();
    $(".phone-call-incoming").fadeIn();

    var element = document.getElementById("phone-call-incoming-caller");
    element.innerHTML = contact;

    if (mutes == true) {
        sendData("notification", { text: locale.somebodyiscallingyou, length: 5000 })
    } else {

        incomingsound = null

        if (incomingsound != null) {
            incomingsound.pause();
        }

        incomingsound = new Audio("./sound/ring.ogg");
        incomingsound.volume = 0.2;
        incomingsound.currentTime = 0;
        incomingsound.loop = true;
        incomingsound.play();
    }
}

$(document).on('click', '#incoming-answer', function() {
    sendData("acceptcall")

});

$(document).on('click', '#incoming-deny', function() {
    $(".phone-applications").fadeIn(250);
    $(".phone-call-app").hide();
    $(".phone-call-incoming").hide();

    sendData("declinecall")
    incomingsound.pause();
});


let incall = false
let Timer

function AcceptCall(number, contact) {
    $(".phone-call-outgoing").hide();
    $(".phone-call-incoming").hide();
    $(".phone-call-app").show();
    $(".phone-call-ongoing").fadeIn(250);
    if (outgoingsound != null) {
        outgoingsound.pause();
    };
    if (incomingsound != null) {
        incomingsound.pause()
    };
    incall = true

    var element = document.getElementById("phone-call-ongoing-caller");
    element.innerHTML = contact;

    let seconds = 0
    let minutes = 0

    Timer = setInterval(() => {
        if (seconds == 60) {
            minutes = minutes + 1
            seconds = 0
        } else {
            seconds = seconds + 1
        }

        var element = document.getElementById("phone-call-ongoing-time");
        if (seconds < 10) {
            if (minutes < 10) {
                element.innerHTML = '0' + minutes + ':0' + seconds;
            } else {
                element.innerHTML = minutes + ':0' + seconds;
            }
        } else {
            if (minutes < 10) {
                element.innerHTML = '0' + minutes + ':' + seconds;
            } else {
                element.innerHTML = minutes + ':' + seconds;
            }
        }
    }, 1000);
}

$(document).on('click', '#ongoing-cancel', function() {
    clearInterval(Timer);
    sendData("endcall")
});


function EndCall() {
    CloseAll();
    $(".phone-applications").fadeIn(250);

    incall = false
}

function DeclineCall() {
    CloseAll();
    $(".phone-applications").fadeIn(250);
    sendData("stopcall")

    if (outgoingsound != null) {
        outgoingsound.pause();
    };
    if (incomingsound != null) {
        incomingsound.pause()
    };
}

function StopCall() {
    CloseAll();
    $(".phone-applications").fadeIn(250);

    if (outgoingsound != null) {
        outgoingsound.pause();
    };
    if (incomingsound != null) {
        incomingsound.pause()
    };
}

$(document).on('click', '#pcb-numpad', function() {
    $(".phone-all-call-sector").hide();
    $(".phone-call-sector").fadeIn(250);
});

$(document).on('click', '#pcb-calls', function() {
    sendData("loadrecentcalls")
});

$(document).on('click', '#pacs-call', function() {
    var number = $('#pacs-call').data('number');;
    var element = document.getElementById("phone-call-outgoing-caller");
    element.innerHTML = number;
    CloseAll();
    $(".phone-call-app").show();
    $(".phone-call-outgoing").fadeIn(250);

    if (mutes == true) {
        sendData("notification", { text: locale.yourecallingsb, length: 5000 })
    } else {
        if (outgoingsound != null) {
            outgoingsound.pause();
        }

        outgoingsound = new Audio("./sound/Phonecall.ogg");
        outgoingsound.volume = 0.2;
        outgoingsound.currentTime = 0;
        outgoingsound.loop = true;
        outgoingsound.play();
    }
    sendData("startcall", { number: number });
});

$(document).on('click', '#pacs-message', function() {
    var number = $('#pacs-call').data('number');;

    sendData("loadmessage", {
        number: number
    });
    selectednumber = number;
    lastcontact = 'message'
});

function loadrecentcalls(html) {
    $(".phone-all-call-sector").children().detach();
    $(".phone-all-call-sector").append(html);

    $(".phone-call-sector").hide();
    $(".phone-all-call-sector").fadeIn(250);
}