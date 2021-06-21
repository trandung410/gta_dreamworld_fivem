QB = {}
QB.Phone = {}
QB.Screen = {}
QB.Phone.Functions = {}
QB.Phone.Animations = {}
QB.Phone.Notifications = {}

let currentjob = 'null'
let businessicon = true
let servicesloaded = false
let backgroundurl = null
let darkbackgroundurl = null
let lastservicenumber = null
let darkmode = false;

$(function() {
    var documentWidth = document.documentElement.clientWidth;
    var documentHeight = document.documentElement.clientHeight;
    var container = $(".container");

    window.addEventListener("message", function(event) {
        var item = event.data;

        if (item.showPhone) {
            QB.Phone.Animations.BottomSlideUp('.container', 300, 0);
            ChangeWallpaper(item.data.wallpaper);
            if (item.data.darkmode == 1) {
                Darkmode();
                darkmode = true
                document.getElementById("darkmodetoggle").checked = true;
            } else {
                Whitemode();
            }
            $(".phone-message").hide();

            if (item.unemployed) {
                if (businessicon == true) {
                    $("#businessicon").remove();
                }
                businessicon = false
            }

            if (lastwindow == "privatmessage") {
                sendData("loadmessage", {
                    number: privatmessage
                });
            }
        } else if (item.hidePhone) {
            QB.Phone.Animations.BottomSlideDown('.container', 300, -70);
        } else if (item.loadBusiness) {
            loadBusiness(item.business)
        } else if (item.showContacts) {
            loadcontacts(item.html);
        } else if (item.showNotification) {
            ShowNotif(item);
        } else if (item.showMessages) {
            loadmessages(item.html)
        } else if (item.showRecentMessages) {
            loadrecentmessages(item.html)
        } else if (item.changeWallpaper) {
            ChangeWallpaper(item.url)
        } else if (item.acceptCall) {
            AcceptCall(item.number, item.contact)
        } else if (item.incomingCall) {
            IncomingCall(item.number, item.contact)
        } else if (item.endcall) {
            EndCall()
        } else if (item.declinecall) {
            DeclineCall()
        } else if (item.stopcall) {
            StopCall(item)
        } else if (item.loadrecentcalls) {
            loadrecentcalls(item.recentcalls)
        } else if (item.showBusiness) {
            showBusiness(item.member, item.onlinemember, item.motd)
        } else if (item.showRecentBusinessMessages) {
            loadrecentbusinessmessages(item.html)
        } else if (item.showBusinessMessages) {
            loadbusinessmessages(item.html)
        } else if (item.loadservices) {
            LoadServices(item.html)
        } else if (item.playmessagesound) {
            PlayMessageSound()
        } else if (item.playbusinessmessagesound) {
            PlayBMessageSound()
        } else if (item.updatetime) {
            UpdateTime(item)
        } else if (item.setvalues) {
            backgroundurl = item.backgroundurl;
            darkbackgroundurl = item.darkbackgroundurl;
        } else if (item.syncbpbabutton) {
            syncbpbabutton(item.number)
        } else if (item.syncclosebmessage) {
            syncclosebmessage(item.number)
        } else if (item.updatenumber) {
            $("#phonesettingsnumber").html(item.number);
        }
    });

    $(document).keyup(function(data) {
        if (data.which == 27) {
            sendData("close");
        }
    });
});

function sendData(name, data) {
    $.post("http://d-phone/" + name, JSON.stringify(data), function(datab) {
        console.log(datab);
    });
}

function playSound(sound) {
    sendData("playsound", { name: sound });
}

function hide() {
    $("#menuoption1").hide();
}


QB.Phone.Animations.BottomSlideUp = function(Object, Timeout, Percentage) {
    $(Object).css({ 'display': 'block' }).animate({
        bottom: Percentage + "%",
    }, Timeout);
}

QB.Phone.Animations.BottomSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({ 'display': 'block' }).animate({
        bottom: Percentage + "%",
    }, Timeout, function() {
        $(Object).css({ 'display': 'none' });
    });
}

QB.Phone.Animations.TopSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({ 'display': 'block' }).animate({
        top: Percentage + "%",
    }, Timeout);
}

QB.Phone.Animations.TopSlideUp = function(Object, Timeout, Percentage, cb) {
    $(Object).css({ 'display': 'block' }).animate({
        top: Percentage + "%",
    }, Timeout, function() {
        $(Object).css({ 'display': 'none' });
    });
}

$(document).on('click', '.phone-application', function(e) {
    e.preventDefault();
    var PressedApplication = $(this).data('app');
    var AppObject = $("." + PressedApplication + "-app");
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

    if (PressedApplication == "settings") {
        $(".phone-applications").hide();
        $(".phone-settings").fadeIn(250);

    } else if (PressedApplication == "contacts") {
        $(".phone-applications").hide();
        $(".phone-app").fadeIn(250);
        $(".phone-contacts").show();
    } else if (PressedApplication == "call") {
        $(".phone-applications").hide();
        $(".phone-all-call-sector").hide();
        $(".phone-call").fadeIn(250);
        $(".phone-call-sector").fadeIn(250);
    } else if (PressedApplication == "messages") {
        sendData("loadrecentmessage", {})
    } else if (PressedApplication == "services") {
        if (servicesloaded == true) {
            $(".phone-applications").hide();
            $(".phone-services").fadeIn(250);
        } else {
            sendData("LoadServices")
        }
    } else if (PressedApplication == "business") {
        let job = $(this).data('job');
        sendData("showBusiness", { job: job })
        $(".phone-settings").hide();
        currentjob = job
    } else if (PressedApplication == "radio") {
        $(".phone-applications").hide();
        $(".phone-radio").fadeIn(250);
    } else if (PressedApplication == "camera") {
        sendData("openCamera");
        $(".phone-applications").show();
    } else if (PressedApplication == "twitter") {
        $(".phone-applications").hide();
        sendData("twitter:open");

        // $(".phone-twitter").fadeIn(500);
        // $(".phone-tweets").fadeIn(500);
    }

});

$(document).on('click', '#changewallpaper', function() {
    $(".phone-settings-wallpaper ").fadeIn(250);
});

$(document).on('click', '#backwallaper', function() {
    $(".phone-settings-wallpaper ").fadeOut(250);
});

$(document).on('click', '#pswsubmitbutton', function() {
    var avatar = $('#psw').val();

    if (avatar.includes("png") == true || avatar.includes("jpeg") == true || avatar.includes("jpg") == true) {
        sendData("changewallpaper", {
            url: avatar
        });

        $(".phone-settings-wallpaper ").fadeOut(250);
    } else {
        sendData("notification", { text: locale.avatarerror, length: 5000 })
    }

});

function ChangeWallpaper(url) {
    if (url == '') {
        $('.phone-background').css('background-image', 'url(' + backgroundurl + ')');
    } else {
        $('.phone-background').css('background-image', 'url("' + url + '")');
        $('.phone-background').css('background-size', 'cover');
    }
}

function flightmode() {
    if (document.getElementById('flightmode').checked) {
        sendData("flightmode", { state: 1 });
    } else {
        sendData("flightmode", { state: 0 });
    };
};

function mute() {
    if (document.getElementById('mute').checked) {
        mutes = true
    } else {
        mutes = false
    };
};

function darkmodetoggle() {
    if (document.getElementById('darkmodetoggle').checked) {
        Darkmode();
        darkmode = true
        sendData("changedarkmode", { state: 1 });
    } else {
        darkmode = false
        Whitemode();
        sendData("changedarkmode", { state: 0 });
    };
};


/*  Notification  */
function CreateNotification(data) {
    let $notification = $(document.createElement('div'));
    $notification.addClass('notify');
    $notification.html(data.text);
    $notification.css({ "border-left": "1vh solid " + data.color });
    $notification.fadeIn();

    return $notification;
}


function ShowNotif(data) {
    let $notification = CreateNotification(data);
    $('.notification').append($notification);
    setTimeout(function() {
        $.when($notification.fadeOut()).done(function() {
            $notification.remove()
        });
    }, data.length != null ? data.length : 2500);
}

let selectedservice = 'null'
let serviceopen = 'null'

$(document).on('click', '#phone-service-return', function() {
    if (serviceopen == 'null') {
        $(".phone-services").hide();
        $(".phone-applications").fadeIn(250);
    } else if (serviceopen == 'sendmessage') {
        $(".phone-services-message").hide();
        $(".phone-services-sector").fadeIn(250);

        serviceopen = 'null'
    }
});

$(document).on('click', '.phone-service', function() {
    $(".phone-services-sector").hide();
    $(".phone-services-message").fadeIn(250);

    serviceopen = 'sendmessage'
    selectedservice = $(this).data('service');
});

$(document).on('click', '#phone-service-button', function() {
    $(".phone-services-sector").show();
    $(".phone-services-message").hide();
    $(".phone-services").hide();
    $(".phone-applications").fadeIn(250);
    serviceopen = 'null'

    let sendnumber = 0
    let sendgps = 0
    selectednumber = selectedservice
    let message = $(".phone-service-message-input").val()
    if (document.getElementById('sendnumber').checked) {
        sendnumber = 1
    }
    if (document.getElementById('sendgps').checked) {
        sendgps = 1
    }

    sendData("sendservice", { service: selectedservice, message: message, sendnumber: sendnumber, job: currentjob, sendgps: sendgps })
});

let businessapp = null

function loadBusiness(item) {
    businessapp = item
    if (businessicon == true) {
        document.getElementById("businessicon").remove();
    }

    $('.phone-home-applications').append(item);
    businessicon = true
    document.getElementById("businessicon").style.backgroundColor = " #8c47fc";
}

function showBusiness(member, onlinemember, motd) {
    $(".phone-ba-member-list").children().detach();
    $(".phone-ba-member-list").append(member);

    document.getElementById('phone-ba-member').innerHTML = locale.memberonline + ' : ' + onlinemember;
    document.getElementById('phone-ba-motd-inhalt').innerHTML = motd;

    $(".phone-recent-businessapp-sector").hide();
    $(".phone-businessapp-message").hide();
    $(".phone-applications").hide();
    $(".phone-businessapp-settings").hide();
    CloseAll();
    $(".phone-businessapp-sector").show();
    $(".phone-businessapp").fadeIn(250);

}

$(document).on('click', '#phone-businessapp-return', function() {
    $(".phone-applications").hide();
    $(".phone-businessapp").fadeIn(250);
});

$(document).on('click', '#phone-ba-member-call', function() {
    let name = $(this).data('name');
    let number = $(this).data('number');

    var element = document.getElementById("phone-call-outgoing-caller");
    element.innerHTML = name
    $(".phone-call").hide();
    $(".phone-businessapp").hide();
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
        outgoingsound.loop = true;
        outgoingsound.currentTime = 0;
        outgoingsound.play();
    }


    sendData("startcall", { number: number, contact: name });

    lastcontact = 'null'
});

$(document).on('click', '#phone-ba-member-message', function() {
    let number = $('#phone-ba-member-call').data('number');
    let name = $('#phone-ba-member-call').data('name');
    $(".phone-businessapp").hide();

    selectednumber = number

    sendData("loadmessage", {
        number: number
    });
});

$(document).on('click', '#pbf-member', function() {
    $(".phone-businessapp-settings").hide();
    sendData("showBusiness", { job: currentjob })
});

$(document).on('click', '#pbf-messages', function() {
    $(".phone-businessapp-settings").hide();
    sendData("showBusinessMessages", { job: currentjob })
});

$(document).on('click', '#pbf-settings', function() {
    $(".phone-recent-businessapp-sector").hide();
    $(".phone-businessapp-message").hide();
    $(".phone-businessapp-sector").hide();
    $(".phone-businessapp-settings").fadeIn(250);
});

function loadrecentbusinessmessages(html) {
    $(".phone-recent-businessapp-sector").children().detach();
    $(".phone-recent-businessapp-sector").append(html);
    if (darkmode == true) {
        Darkmode();
    }

    $(".phone-businessapp-sector").hide();
    $(".phone-recent-businessapp-sector").fadeIn(250);
}

$(document).on('click', '.phone-recent-businessapp-selection', function() {
    let number = $(this).data('number');
    selectednumber = $(this).data('number');
    lastservicenumber = selectednumber
    sendData("loadbusinessmessage", {
        number: number,
        job: currentjob
    });


});

function loadbusinessmessages(html) {
    $(".phone-businessapp-chat").children().detach();
    $(".phone-businessapp-chat").append(html);
    if (darkmode == true) {
        Darkmode();
    }
    $(".phone-recent-businessapp-sector").hide();
    $(".phone-businessapp-message").fadeIn(250);
    $(".phone-businessapp-chat").scrollTop($(".phone-businessapp-chat")[0].scrollHeight);
}

$(document).on('click', '#phone-businessapp-send', function() {
    var message = $('#phone-business-input-message').val();

    sendData("sendbusinessmessage", {
        message: message,
        number: selectednumber,
        job: currentjob
    });

    document.getElementById('phone-business-input-message').value = "";
});

$(document).on('click', '#phone-businessapp-placeicon', function() {
    sendData("sendbusinessgps", {
        number: selectednumber,
        job: currentjob
    });
});

$(document).on('click', '#phone-businessapp-return', function() {
    $(".phone-recent-businessapp-sector").hide();
    $(".phone-businessapp-message").hide();
    $(".phone-businessapp-settings").hide();
    $(".phone-businessapp-sector").show();
    $(".phone-businessapp").hide();

    $(".phone-applications").fadeIn(250);
});

$(document).on('click', '#changemotd', function() {
    $(".phone-businessapp-motd").fadeIn(250);
});

$(document).on('click', '#backmotd', function() {
    $(".phone-businessapp-motd").fadeOut(250);
});

$(document).on('click', '#motdsubmit', function() {
    $(".phone-businessapp-motd").fadeOut(250);
    var message = $('#motd').val();
    sendData("changemotd", { job: currentjob, message: message })
});

function bpbaccept() {
    var acceptbutton = "#bpb-accept-" + selectednumber
    var declinebutton = "#bpb-decline-" + selectednumber

    $(acceptbutton).css({ 'display': 'none', "tranistion": ".5" });
    $(declinebutton).css({ 'width': '100%', "tranistion": ".5" });


    sendData("serviceaccept", {
        number: selectednumber,
        job: currentjob
    })
}

function bpbdecline() {
    var acceptbutton = "#bpb-accept-" + selectednumber
    var declinebutton = "#bpb-decline-" + selectednumber


    sendData("serviceclose", {
        number: selectednumber,
        job: currentjob
    })

    $(acceptbutton).css({ 'width': '50%', 'display': 'block', "tranistion": ".5" });
    $(declinebutton).css({ 'width': '50%', "tranistion": ".5" });

    syncclosebmessage(selectednumber)
}

function syncclosebmessage(number) {
    if (lastservicenumber == number) {
        $(".phone-businessapp-message").hide();
        sendData("showBusinessMessages", { job: currentjob })

        lastservicenumber = null
    }
}

function syncbpbabutton(selectednumber) {
    var acceptbutton = "#bpb-accept-" + selectednumber
    var declinebutton = "#bpb-decline-" + selectednumber

    $(acceptbutton).css({ 'display': 'none', "tranistion": ".5" });
    $(declinebutton).css({ 'width': '100%', "tranistion": ".5" });

}


function LoadServices(services) {
    $(".phone-services-list").children().detach();
    $(".phone-services-list").append(services);
    if (darkmode == true) {
        Darkmode();
    }
    CloseAll()
    $(".phone-services").fadeIn(250);

    servicesloaded = true
}


/* Sound */
function PlayMessageSound() {
    if (mutes == false) {
        if (messagesound != null) {
            messagesound.pause();
        }

        messagesound = new Audio("./sound/Google_Event.ogg");
        messagesound.volume = 0.2;
        messagesound.currentTime = 0;
        messagesound.play();

        setTimeout(function() {;
            messagesound.pause();
            messagesound.currentTime = 0;
            messagesound.volume = 0.2;
        }, 1300);
    }
}

function PlayBMessageSound() {
    if (mutes == false) {
        if (bmessagesound != null) {
            bmessagesound.pause();
        }

        bmessagesound = new Audio("./sound/message_tone.ogg");
        bmessagesound.volume = 0.2;

        bmessagesound.currentTime = 0;
        bmessagesound.play();

        setTimeout(function() {;
            bmessagesound.pause();
            bmessagesound.currentTime = 0;
            bmessagesound.volume = 0.2;
        }, 1300);
    }
}

/* Radio */
$(document).on('click', '#phone-radio-return', function() {
    $(".phone-radio").hide();
    $(".phone-applications").fadeIn(250);
});

$(document).on('click', '#phone-frequenz-join-button', function() {
    var freq = $('#phone-radio-frequenz-input').val();
    sendData("setRadio", { freq: freq })
});

$(document).on('click', '#phone-frequenz-leave-button', function() {
    var freq = $('#phone-radio-frequenz-input').val();
    sendData("leaveRadio", { freq: freq })
});


/* Update Time */
function UpdateTime(data) {
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    if (NewHour < 10) {
        Hourssssss = "0" + Hourssssss;
    }
    if (NewMinute < 10) {
        Minutessss = "0" + NewMinute;
    }
    var MessageTime = Hourssssss + ":" + Minutessss

    $("#phone-time").html(MessageTime);
}

function CloseAll() {
    $(".phone-call").hide();
    $(".phone-call-app").hide();
    $(".phone-call-ongoing").hide();
    $(".phone-call-incoming").hide();
    $(".phone-call-outgoing").hide();
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
    $(".phone-twitter").hide();
    $(".phone-applications").hide();
}

function Home() {
    CloseAll();
    $(".phone-applications").fadeIn(250);
}


function Darkmode() {


    $(".phone-footer-applications").addClass('darkphone-footer-applications');

    /* Phone App */
    document.getElementById("phone-call").classList.add("darkmode");
    document.getElementById("phone-call-header").classList.add("darkmodeheader");
    $(".phone-enter").each(function() {
        $(this).addClass('darkphone-enter');
    });
    $(".phone-enterinvisibleicon").addClass('darkphone-enterinvisibleicon');
    $(".phone-call-footer-item").addClass('darkphone-call-footer-item');
    $(".phone-returnicon").each(function() {
        $(this).addClass('darkphone-returnicon')
    });

    /* Call App */
    $(".phone-call-app").addClass('darkmode');

    /* Contacts App */
    $(".phone-app").addClass('darkmode');
    $(".phone-app-header").each(function() {
        $(this).addClass('darkmodeheader')
    });
    $(".phone-contact").addClass('darkphone-contact');
    $("#pcinumber").addClass('darkpcinumber');
    $(".pciinput").addClass('darkpciinput');

    /* Radio App */
    $(".phone-radio").addClass('darkmode');
    $(".phone-radio-frequenz-input").addClass('darkpciinput');

    /* Settings App */
    $(".phone-settings").addClass('darkmode');
    $(".phone-settings-header").addClass('darkmodeheader')
    $(".phone-settings-selection").addClass('darkphone-settings-selection');

    /* Recent Messages App */
    $(".phone-recent-message").addClass('darkmode');
    $(".phone-message-header").addClass('darkmodeheader');

    $(".phone-recent-messages-selection").each(function() {
        $(this).addClass('darkmode-prms')
    });

    /*  Messages App */
    $(".phone-message").addClass('darkmode');
    $(".phone-message-header").addClass('darkmodeheader');

    $(".phone-chat-message").each(function() {
        $(this).addClass('darkphone-chat-message')
    });

    $(".phone-chat-message-header").each(function() {
        $(this).addClass('darkphone-chat-message-header')
    });

    $(".sendservicenumber").each(function() {
        $(this).addClass('darksendservicenumber')
    });

    $("#phone-chat-input-message").addClass('darkpciinput');
    $("#phone-chat-placeicon").addClass('darkphone-chat-placeicon');

    /*  Service App */
    $(".phone-services").addClass('darkmode');
    $(".phone-app-header").addClass('darkmodeheader');

    $(".phone-service-selection").each(function() {
        $(this).addClass('darkphone-service-selection')
    });

    $(".phone-service").each(function() {
        $(this).addClass('darkphone-service-selection')
    });
    $(".phone-service-message-input ").addClass('darkpciinput');

    /*  Business App */
    $(".phone-businessapp").addClass('darkmode');
    $(".phone-app-header").each(function() {
        $(this).addClass('darkmodeheader')
    });

    $(".phone-recent-businessapp-selection").each(function() {
        $(this).addClass('darkmode-prms')
    });

    $(".phone-businessapp-inputt").addClass('darkpciinput');
    $("#phone-businessapp-placeicon").addClass('darkphone-chat-placeicon');

    $(".phone-businessapp-settings-menu").each(function() {
        $(this).addClass('darkphone-businessapp-settings-menu')
    });
    $(".phone-businessapp-footer-item").each(function() {
        $(this).addClass('darkphone-businessapp-footer-item')
    });

    $(".phone-businessapp-motd").addClass('darkminiinput');
    $(".phone-settings-wallpaper").addClass('darkminiinput');

    /*  Twitter App */
    $(".phone-twitter").addClass('darkmode');
    $(".phone-twitter-header").addClass('darkheader');
    $(".phone-tweet ").each(function() {
        $(this).addClass('darkphone-tweet')
    });
    $(".phone-tweet-header").each(function() {
        $(this).addClass('darkphone-tweet-header')
    });
    $(".phone-tweet-name").each(function() {
        $(this).addClass('darkphone-tweet-name')
    });
    $(".phone-tweet-footer").each(function() {
        $(this).addClass('darkphone-tweet-footer')
    });
    $(".phone-tweet-input").each(function() {
        $(this).addClass('darkphone-tweet-input')
    });
    $(".ptw-submitzone").each(function() {
        $(this).addClass('darkptw-submitzone')
    });
}

function Whitemode() {
    $(".phone-footer-applications").removeClass('darkphone-footer-applications');

    /* Phone App */
    $("#phone-call").removeClass('darkmode');
    $("#phone-call-header").removeClass('darkmodeheader');
    $(".phone-enter").each(function() {
        $(this).removeClass('darkphone-enter');
    });
    $(".phone-enterinvisibleicon").removeClass('darkphone-enterinvisibleicon');
    $(".phone-call-footer-item").removeClass('darkphone-call-footer-item');
    $(".phone-returnicon").each(function() {
        $(this).removeClass('darkphone-returnicon')
    });

    /* Call App */
    $(".phone-call-app").removeClass('darkmode');

    /* Contacts App */
    $(".phone-app").removeClass('darkmode');
    $(".phone-app-header").each(function() {
        $(this).removeClass('darkmodeheader')
    });
    $("#pcinumber").removeClass('darkpcinumber');
    $(".pciinput").removeClass('darkpciinput');
    $(".phone-contact").each(function() {
        $(this).removeClass('darkphone-contact')
    });

    /* Radio App */
    $(".phone-radio").removeClass('darkmode');
    $(".phone-radio-frequenz-input").removeClass('darkpciinput');

    /* Settings App */
    $(".phone-settings").removeClass('darkmode');
    $(".phone-settings-header").removeClass('darkmodeheader')
    $(".phone-settings-selection").removeClass('darkphone-settings-selection');

    /* Recent Messages App */
    $(".phone-recent-message").removeClass('darkmode');
    $(".phone-message-header").removeClass('darkmodeheader');

    $(".phone-recent-messages-selection").each(function() {
        $(this).removeClass('darkmode-prms')
    });

    /*  Messages App */
    $(".phone-message").removeClass('darkmode');
    $(".phone-message-header").removeClass('darkmodeheader');

    $(".phone-chat-message").each(function() {
        $(this).removeClass('darkphone-chat-message')
    });

    $(".phone-chat-message-header").each(function() {
        $(this).removeClass('darkphone-chat-message-header')
    });

    $(".sendservicenumber").each(function() {
        $(this).removeClass('darksendservicenumber')
    });

    $("#phone-chat-input-message").removeClass('darkpciinput');
    $("#phone-chat-placeicon").removeClass('darkphone-chat-placeicon');

    /*  Service App */
    $(".phone-services").removeClass('darkmode');
    $(".phone-app-header").removeClass('darkmodeheader');

    $(".phone-service-selection").each(function() {
        $(this).removeClass('darkphone-service-selection')
    });

    $(".phone-service").each(function() {
        $(this).removeClass('darkphone-service-selection')
    });
    $(".phone-service-message-input ").removeClass('darkpciinput');

    /*  Business App */
    $(".phone-businessapp").removeClass('darkmode');
    $(".phone-app-header").each(function() {
        $(this).removeClass('darkmodeheader')
    });

    $(".phone-recent-businessapp-selection").each(function() {
        $(this).removeClass('darkmode-prms')
    });

    $(".phone-businessapp-inputt").removeClass('darkpciinput');
    $("#phone-businessapp-placeicon").removeClass('darkphone-chat-placeicon');

    $(".phone-businessapp-settings-menu").each(function() {
        $(this).removeClass('darkphone-businessapp-settings-menu')
    });
    $(".phone-businessapp-footer-item").each(function() {
        $(this).removeClass('darkphone-businessapp-footer-item')
    });

    $(".phone-businessapp-motd").removeClass('darkminiinput');
    $(".phone-settings-wallpaper").removeClass('darkminiinput');
    /*  Twitter App */
    $(".phone-twitter").removeClass('darkmode');
    $(".phone-twitter-header").removeClass('darkheader');
    $(".phone-tweet ").each(function() {
        $(this).removeClass('darkphone-tweet')
    });
    $(".phone-tweet-header").each(function() {
        $(this).removeClass('darkphone-tweet-header')
    });
    $(".phone-tweet-name").each(function() {
        $(this).removeClass('darkphone-tweet-name')
    });
    $(".phone-tweet-footer").each(function() {
        $(this).removeClass('darkphone-tweet-footer')
    });
    $(".phone-tweet-input").each(function() {
        $(this).removeClass('darkphone-tweet-input')
    });
    $(".ptw-submitzone").each(function() {
        $(this).removeClass('darkptw-submitzone')
    });
}