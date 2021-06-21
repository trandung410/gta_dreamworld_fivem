/*  MESSAGE  */
let lastwindow = null
let privatmessage = null

$(document).on('click', '#pcimessage', function() {
    sendData("loadmessage", {
        number: selectednumber
    });
    lastcontact = 'message'
});

$(document).on('click', '#pcimessage2', function() {
    sendData("loadmessage", {
        number: selectednumber
    });
    lastcontact = 'message'
});

$(document).on('click', '#phone-chat-send', function() {
    var message = $('#phone-chat-input-message').val();

    sendData("sendmessage", {
        message: message,
        number: selectednumber
    });

    document.getElementById('phone-chat-input-message').value = "";
});


$(document).on('click', '#phone-chat-placeicon', function() {
    sendData("sendgps", {
        number: selectednumber
    });
});

$(document).on('click', '#phone-chat-message-message-gps', function() {

    let x = $(this).data('x');
    let y = $(this).data('y');
    let z = $(this).data('z');


    sendData("setgps", {
        x: x,
        y: y,
        z: z
    });

});

function loadmessages(html) {
    $(".phone-chat").children().detach();
    $(".phone-chat").append(html);
    CloseAll();
    $(".phone-message").fadeIn(250);
    $(".phone-chat").scrollTop($(".phone-chat")[0].scrollHeight);
    privatmessage = selectednumber
    lastwindow = "privatmessage"
    lastcontact = "recentmessagemessage"
    if (darkmode == true) {
        Darkmode();
    }
}

function loadrecentmessages(html) {
    $(".phone-recent-messages-sector").children().detach();
    $(".phone-recent-messages-sector").append(html);
    if (darkmode == true) {
        Darkmode();
    }
    $(".phone-applications").hide();
    $(".phone-call").hide();
    $(".phone-call-app").hide();
    $(".phone-call-ongoing").hide();
    $(".phone-applications").hide();
    $(".phone-app").hide();
    $(".phone-contacts").hide();
    $(".phone-contacts-information").hide();
    $(".phone-contacts-add").hide();
    $(".phone-contacts-edit").hide();
    $(".phone-recent-message").hide();
    $(".phone-message").hide();
    $(".phone-settings").hide();
    $(".phone-services").hide();
    $(".phone-businessapp").hide();
    $(".phone-radio").hide();
    $(".phone-recent-message").fadeIn(250);
    lastcontact = 'recentmessage'
}

$(document).on('click', '.phone-recent-messages-selection', function() {
    let number = $(this).data('number');
    selectednumber = $(this).data('number');
    sendData("loadmessage", {
        number: number
    });
    lastcontact = 'recentmessagemessage'
});