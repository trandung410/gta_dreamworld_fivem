var lastcontact = 'null'
var lastmassage = 'null'
let selectedname
let selectednumber
let selectedfavourite
let contacts

function loadcontacts(html) {
    $(".phone-contact-list").children().detach();
    $(".phone-contact-list").append(html);
    contacts = html

    if (darkmode == true) {
        Darkmode();
    }
    lastcontact = 'null'
}

$(document).on('click', '#phone-return', function() {
    $(".phone-contacts-add").hide();
    $("#phone-edit").hide();
    $(".phone-call").hide();
    $(".phone-settings-wallpaper").hide();
    $(".phone-contacts-information").hide();
    $(".phone-contacts-edit").hide();
    $(".phone-message").hide();

    if (lastcontact == 'null') {
        $(".phone-app").hide();
        $(".phone-applications").fadeIn(250);
        lastwindow = null
    } else if (lastcontact == 'addcontact') {
        $(".phone-contacts").fadeIn(250);
        lastcontact = 'null'
    } else if (lastcontact == 'contactinfo') {
        $(".phone-contacts").fadeIn(250);
        lastcontact = 'null'
    } else if (lastcontact == 'editcontact') {
        $(".phone-contacts-information").fadeIn(250);

        document.getElementById("pcinamee").innerHTML = selectedname;
        document.getElementById("pcinumberr").innerHTML = selectednumber;

        lastcontact = 'contactinfo'
        $("#phone-edit").show();
    } else if (lastcontact == 'message') {
        $(".phone-app").show();
        $(".phone-contacts").fadeIn(250);

        lastcontact = 'null'
    } else if (lastcontact == 'recentmessage') {
        $(".phone-recent-message").hide();
        $(".phone-app").hide();
        $(".phone-applications").fadeIn(250);


        lastcontact = 'null'
    } else if (lastcontact == 'recentmessagemessage') {
        $(".phone-message").hide();
        sendData("loadrecentmessage", {})
        privatmessage = null
        lastwindow = null
        lastcontact = 'recentmessage'
    }
});

$(document).on('click', '.phone-contact-add', function() {
    $(".phone-contacts").hide();
    $(".phone-contacts-add").fadeIn(250);

    lastcontact = 'addcontact'
});

$(document).on('click', '#phone-edit', function() {
    $(".phone-contacts-information").hide();
    $(".phone-contacts-edit").fadeIn(250);

    $("#pciinputname2").val(selectedname);
    $("#pciinputnumber2").val(selectednumber);

    lastcontact = 'editcontact'
    $("#phone-edit").hide();
});


$(document).on('click', '.phone-contact', function() {
    $(".phone-contacts").hide();
    $(".phone-contacts-information").fadeIn(250);

    selectedname = $(this).data('name');
    selectednumber = $(this).data('number');
    selectedfavourite = $(this).data('favourite');
    document.getElementById("pcinamee").innerHTML = selectedname;
    document.getElementById("pcinumberr").innerHTML = selectednumber;

    if (selectedfavourite == 1) {
        $("#pcifavourit").addClass("pcifavouriteicon")
    } else {
        $("#pcifavourit").removeClass("pcifavouriteicon")
    }
    $("#phone-edit").show();
    lastcontact = 'contactinfo'
});


$(document).on('click', '#pciinputsubmit', function() {
    var name = $('#pciinputname').val();
    var number = $('#pciinputnumber').val();

    $(".phone-contacts-add").hide();
    $(".phone-contacts").fadeIn(250);
    lastcontact = 'null'

    sendData("addcontact", {
        name: name,
        number: number
    });

    document.getElementById('pciinputname').value = "";
    document.getElementById('pciinputnumber').value = "";
});

$(document).on('click', '#pcieditsubmit', function() {
    var name = $('#pciinputname2').val();
    var number = $('#pciinputnumber2').val();

    lastcontact = 'null'

    sendData("editcontact", {
        name: name,
        number: number,
        name2: selectedname,
        number2: selectednumber
    });

    document.getElementById('pciinputname2').value = "";
    document.getElementById('pciinputnumber2').value = "";
    $(".phone-contacts-edit").fadeOut(500);
    $(".phone-contacts").fadeIn(0);
});

$(document).on('click', '#pcidelete', function() {
    $(".phone-contacts-information").hide();
    $(".phone-contacts").fadeIn(250);
    lastcontact = 'null'

    if (selectedname != null) {
        sendData("deletecontact", {
            name: selectedname,
            number: selectednumber
        });

        selectedname = null
        selectednumber = null
    }
});

$(document).on('click', '#pcishare', function() {
    $(".phone-contacts-information").hide();
    $(".phone-contacts").fadeIn(250);
    lastcontact = 'null'

    if (selectedname != null) {
        sendData("sharecontact", {
            name: selectedname,
            number: selectednumber
        });

        selectedname = null
        selectednumber = null
    }
});

$(document).on('click', '#pcigps', function() {
    sendData("sendgps", {
        number: selectednumber
    });
});

var outgoingsound = document.getElementById("outgoing-sound");

$(document).on('click', '#pcicall', function() {
    var element = document.getElementById("phone-call-outgoing-caller");
    element.innerHTML = selectedname
    $(".phone-call").hide();
    $(".phone-app").hide();
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


    sendData("startcall", { number: selectednumber, contact: selectedname });

    lastcontact = 'null'
});

$(document).on('click', '#pcicall2', function() {
    var element = document.getElementById("phone-call-outgoing-caller");
    element.innerHTML = selectedname
    $(".phone-call").hide();
    $(".phone-app").hide();
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


    sendData("startcall", { number: selectednumber, contact: selectedname });

    lastcontact = 'null'
});

// Favourite
$(document).on('click', '#pcifavourit', function() {
    sendData("addcontactfavourit", {
        name: selectedname,
        number: selectednumber
    });

    if (selectedfavourite == 1) {
        $(this).removeClass("pcifavouriteicon")
        selectedfavourite = 0
    } else {
        selectedfavourite = 1
        $(this).addClass("pcifavouriteicon")
    }
});

$(document).on('click', '#pcifavourit2', function() {
    sendData("addcontactfavourit", {
        name: selectedname,
        number: selectednumber
    });

    if (selectedfavourite == 1) {
        $('#pcifavourit').removeClass("pcifavouriteicon")
        selectedfavourite = 0
    } else {
        selectedfavourite = 1
        $('#pcifavourit').addClass("pcifavouriteicon")
    }
});