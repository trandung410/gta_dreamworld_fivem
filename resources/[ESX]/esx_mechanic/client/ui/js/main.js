let isOpenByAdmin = false;

let currentJobName = null;
let currentCash = null;

let canDetailCardToggle = true;
let userDetailCardToggle = true;

let menuLastPos = [];
let menuLastPosIndex = '';

let cardFadeOutTimeOut = null;

let menuLoading = false;

let currentVehicleCard = {
    vehicleName: '',
    power: 0.0,
    acceleration: 0.0,
    maxSpeed: 0.0,
    breaks: 0.0
};

let grid = null;
let isCustom = null;
let colorIndex = 0;
let colorPriceMult = null;

let colorData = [
    [[13, 17, 22], [28, 29, 33], [50, 56, 61], [69, 75, 79], [153, 157, 160], [194, 196, 198], [151, 154, 151], [99, 115, 128], [99, 98, 92], [60, 63, 71], [68, 78, 84], [29, 33, 41], [19, 24, 31], [38, 40, 42], [81, 85, 84], [21, 25, 33]],
    [[30, 36, 41], [51, 58, 60], [140, 144, 149], [57, 67, 77], [80, 98, 114], [30, 35, 47], [54, 58, 63], [160, 161, 153], [211, 211, 211], [183, 191, 202], [119, 135, 148], [192, 14, 26], [218, 25, 24], [182, 17, 27], [165, 30, 35], [123, 26, 34]],
    [[142, 27, 31], [111, 24, 24], [73, 17, 29], [182, 15, 37], [212, 74, 23], [194, 148, 79], [247, 134, 22], [207, 31, 33], [115, 32, 33], [242, 125, 32], [255, 201, 31], [156, 16, 22], [222, 15, 24], [143, 30, 23], [169, 71, 68], [177, 108, 81]],
    [[55, 28, 37], [19, 36, 40], [18, 46, 43], [18, 56, 60], [49, 66, 63], [21, 92, 45], [27, 103, 112], [102, 184, 31], [34, 56, 62], [29, 90, 63], [45, 66, 63], [69, 89, 75], [101, 134, 127], [34, 46, 70], [35, 49, 85], [48, 76, 126]],
    [[71, 87, 143], [99, 123, 167], [57, 71, 98], [214, 231, 241], [118, 175, 190], [52, 94, 114], [11, 156, 241], [47, 45, 82], [40, 44, 77], [35, 84, 161], [110, 163, 198], [17, 37, 82], [27, 32, 62], [39, 81, 144], [96, 133, 146], [36, 70, 168]],
    [[66, 113, 225], [59, 57, 224], [31, 40, 82], [37, 58, 167], [28, 53, 81], [76, 95, 129], [88, 104, 142], [116, 181, 216], [255, 207, 32], [251, 226, 18], [145, 101, 50], [224, 225, 61], [152, 210, 35], [155, 140, 120], [80, 50, 24], [71, 63, 43]],
    [[34, 27, 25], [101, 63, 35], [119, 92, 62], [172, 153, 117], [108, 107, 75], [64, 46, 43], [164, 150, 95], [70, 35, 26], [117, 43, 25], [191, 174, 123], [223, 213, 178], [247, 237, 213], [58, 42, 27], [120, 95, 51], [181, 160, 121], [255, 255, 246]],
    [[234, 234, 234], [176, 171, 148], [69, 56, 49], [42, 40, 43], [114, 108, 87], [106, 116, 124], [53, 65, 88], [155, 160, 168], [88, 112, 161], [234, 230, 222], [223, 221, 208], [242, 173, 46], [249, 164, 88], [131, 197, 102], [241, 204, 64], [76, 195, 218]],
    [[78, 100, 67], [188, 172, 143], [248, 182, 88], [252, 249, 241], [255, 255, 251], [129, 132, 76], [255, 255, 255], [242, 31, 153], [253, 214, 205], [223, 88, 145], [246, 174, 32], [176, 238, 110], [8, 233, 250], [10, 12, 23], [12, 13, 24], [14, 13, 20]],
    [[159, 158, 138], [98, 18, 118], [11, 20, 33], [17, 20, 26], [107, 31, 123], [30, 29, 34], [188, 25, 23], [45, 54, 42], [105, 103, 72], [122, 108, 85], [195, 180, 146], [90, 99, 82], [129, 130, 127], [175, 214, 228], [122, 100, 64], [127, 106, 72]]
];

$(window).ready(function() {
    resetUI();
    listener();

    $.post('http://esx_mechanic/uiReady', {});
});

function listener() {
    window.addEventListener('message', (event) => {
        let tempData = event.data;

        if (tempData.type === 'open') {
            isOpenByAdmin = tempData.isOpenByAdmin

            $('html').show();
            $('#buttonHelpers').show(500);
            
            fadeInDetailCard();
            userDetailCardToggle = false;
            cardFadeOutTimeOut = setTimeout(function() {
                fadeOutDetailCard();
            }, 5000);

            if (tempData.what === 'menu') {
                createMenu(tempData.menuId, tempData.options, tempData.menuTitle, tempData.defaultOption, tempData.whitelistJobName);
            } else if (tempData.what === 'colorPicker') {
                isCustom = tempData.isCustom;
                colorPriceMult = tempData.priceMult;
                fadeInColorPicker(tempData.title, isOpenByAdmin ? 0 : tempData.price, tempData.defaultValue, tempData.whitelistJobName);
            }
        } else if (tempData.type === 'close') {
            resetUI();
        } else if (tempData.type === 'update') {
            if (tempData.what === 'card') {
                updateDetailCardData(tempData);
            } else if (tempData.what === 'cash') {
                if (currentCash != tempData.cash) {
                    currentCash = tempData.cash;
                    $('#cash').html('$' + GetNumberWithCommas(currentCash));

                    $('.options_container_option_price').each(function(index) {
                        let tempPrice = parseInt($(this).html().replace(/[^0-9]/g, ''));
                        if (tempPrice) {
                            let oldPrice = tempPrice;
                            tempPrice = tempPrice * 2;
                            if (tempData.whitelistJobName && currentJobName == tempData.whitelistJobName) {
                                tempPrice = oldPrice;
                            }

                            if (tempPrice > currentCash) {
                                $(this).addClass('cash_not');
                            } else {
                                $(this).removeClass('cash_not');
                            }
                        }
                    });

                    if ($('#colorPicker-holder').css("opacity") >= 0.1) {
                        let tempPrice = parseInt($('#colorPicker-price').html().replace(/[^0-9]/g, ''));
                        tempPrice = tempPrice * 2;
                        if (tempPrice > currentCash) {
                            $('#colorPicker-price').addClass('cash_not');
                        } else {
                            $('#colorPicker-price').removeClass('cash_not');
                        }
                    }
                }
            } else if (tempData.what === 'job') {
                currentJobName = tempData.jobName;
            } else if (tempData.what === 'menu') {
                createMenu(tempData.menuId, tempData.options, tempData.menuTitle, tempData.defaultOption, tempData.whitelistJobName);
            } else if (tempData.what === 'colorPicker') {
                fadeOutColorPicker();
            }
        } else if (tempData.type === 'playSound') {
            playSound(tempData.soundName, tempData.volume);
        }
    });
}

document.onkeydown = function(event) {
    if (event.which == 9) {
        return false;
    } else if (event.which == 39 || event.which == 68) { // left (prev)
        event.preventDefault();

        if (!menuLoading) {
            if ($('#colorPicker-holder').css("opacity") < 0.5) {
                menuGoto(1);
            } else {
                menuColorPickerGoto(1, 0)
            }
        }
    } else if (event.which == 37 || event.which == 65) { // right (next)
        event.preventDefault();

        if (!menuLoading) {
            if ($('#colorPicker-holder').css("opacity") < 0.5) {
                menuGoto(-1);
            } else {
                menuColorPickerGoto(-1, 0)
            }
        }
    } else if (event.which == 71) { // g
        event.preventDefault();

        userDetailCardToggle = !userDetailCardToggle;
        fadeInDetailCard();
        fadeOutDetailCard();
    } else if (event.which == 38 || event.which == 87) { // up (next)
        event.preventDefault();

        if ($('#colorPicker-holder').css("opacity") >= 0.5) {
            menuColorPickerGoto(0, -1)
        }
    } else if (event.which == 40 || event.which == 83) { // down (next)
        event.preventDefault();

        if ($('#colorPicker-holder').css("opacity") >= 0.5) {
            menuColorPickerGoto(0, 1)
        }
    } else if (event.which == 8) { // backspace
        event.preventDefault();

        $.post('http://esx_mechanic/handle', JSON.stringify({
            type: 'update',
            what: 'menu',
            user: 'backspace',
            menuId: menuLastPosIndex,
            menuIndex: menuLastPos[menuLastPosIndex]
        }));

        menuLastPos[menuLastPosIndex] = null;

        if ($('#colorPicker-holder').css("opacity") > 0.05) {
            fadeOutColorPicker();
        }
    } else if (event.which == 13) { // enter
        event.preventDefault();

        let tempColor = null;
        if ($('#colorPicker-holder').css("opacity") >= 0.5) {
            tempColor = colorIndex;
            if (isCustom) {
                let temp = getRGBFromString($('.colorPicker-columnSelected').css( "background-color" ));
                tempColor = [temp.red, temp.green, temp.blue];
            }
        }

        $.post('http://esx_mechanic/handle', JSON.stringify({
            type: 'update',
            what: 'menu',
            user: 'enter',
            menuId: menuLastPosIndex,
            menuIndex: menuLastPos[menuLastPosIndex],
            color: tempColor,
            isCustom: isCustom,
            priceMult: colorPriceMult,
        }));
    } else if (event.which == 27) { // esc
        event.preventDefault();
        
        $('#options_container').stop(true, true).animate({height: '0px'}, 300);

        $('#detailCard').stop(true, true).animate({
            opacity: 0,
            right: '-140px'
        }, 500, function() {
            resetUI();
    
            $.post('http://esx_mechanic/handle', JSON.stringify({
                type: "close"
            }));
        });
    }
}

function resetUI() {
    $('html').hide();
    $('#buttonHelpers').hide();

    canDetailCardToggle = true;
    userDetailCardToggle = true;

    menuLastPos = [];
    menuLastPosIndex = '';

    cardFadeOutTimeOut = null;
    clearTimeout(cardFadeOutTimeOut);
    
    menuLoading = false;

    currentCash = null;
    $('#cash').html('');

    $('#options_title').html('');
    $('#options_container').html('');
    $('#options_subTitle').html('');

    $('#detailCard').hide();
    $('#detailCard').css({opacity: 0, right: '-140px'})

    $('#detailCard_name').html('');

    isCustom = null;
    grid = null;
    colorIndex = 0;
    $('#colorPicker-title').html('');
    $('#colorPicker-price').html('');
    $('#colorPicker-holder').css({opacity: "0", left: '-140px'});

    $('#card_power_percent').css({width: "0%"});
    $('#card_power_number').html('0.0');
    
    $('#card_acceleration_percent').css({width: "0%"});
    $('#card_acceleration_number').html('0.0');
    
    $('#card_maxspeed_percent').css({width: "0%"});
    $('#card_maxspeed_number').html('0.0');
    
    $('#card_breaks_percent').css({width: "0%"});
    $('#card_breaks_number').html('0.0');
}

function createMenu(menuId, data, title, defaultOption, whitelistJobName) {
    menuLastPosIndex = menuId;

    menuLoading = true;
    
    $('#options_container').stop(true, true).animate({height: '0px'}, 300, function() {
        $('#options_container').html('');
    
        for (let i = 0; i < data.length; i++) {
            let price = '';

            if (data[i].price >= 0) {
                let tempClass = '';
                if ((!isOpenByAdmin) && data[i].price > currentCash) tempClass = 'cash_not';

                let tempPrice = data[i].price * 2;
                if (whitelistJobName && currentJobName == whitelistJobName) {
                    tempPrice = data[i].price;
                }

                price = `<div class="options_container_option_price ${tempClass}">$${isOpenByAdmin ? 0 : GetNumberWithCommas(tempPrice)}</div>`;
            } else if (data[i].price == -1) {
                price = '<div class="options_container_option_price"><img src="img/check.png" style="width:20px;height:20px;"></div>';
            }
            
            $('#options_container').append(`
                <div class="options_option">
                    ${price}
                    <div class="options_option_img"><img src="${data[i].img}" onerror="this.style.display='none'"></div>
                    <div class="options_option_text">${data[i].label ? data[i].label : ''}</div>
                </div>
            `);
        }
    
        $('#options_title').html(title);
        
        defaultOption = defaultOption ? defaultOption : 0;
        menuLastPos[menuLastPosIndex] = menuLastPos[menuLastPosIndex] != null ? menuLastPos[menuLastPosIndex] : defaultOption;
        
        menuGoto(0);
        
        $('#options_container').stop(true, true).animate({height: '170px'}, 300, function() {
            menuLoading = false;
        });
    });
}

function menuGoto(valueHor) {
    let total = $('#options_container > div').length;
    if (total < 1) {
        $('#options_subTitle').html('');
        return;
    }

    $('#options_container > div').eq(menuLastPos[menuLastPosIndex]).removeClass('options_container_optionSelected');
    
    menuLastPos[menuLastPosIndex] = menuLastPos[menuLastPosIndex] + valueHor;
    if (menuLastPos[menuLastPosIndex] > (total - 1)) {
        menuLastPos[menuLastPosIndex] = 0
    }
    if (menuLastPos[menuLastPosIndex] < 0) {
        menuLastPos[menuLastPosIndex] = total - 1
    }
    
    $('#options_container > div').eq(menuLastPos[menuLastPosIndex]).addClass('options_container_optionSelected');
    $('#options_subTitle').html((menuLastPos[menuLastPosIndex] + 1) + '/' + total);

    let tempOffset = $('#options_container > div').eq(menuLastPos[menuLastPosIndex]).offset();
    if (tempOffset) {
        $('#options_container').stop(true, true).animate({
            scrollLeft: tempOffset.left - $('#options_container > div').eq(0).offset().left - 10
        }, 200);
    }

    $.post('http://esx_mechanic/handle', JSON.stringify({
        type: 'update',
        what: 'menu',
        user: 'hover',
        menuId: menuLastPosIndex,
        menuIndex: menuLastPos[menuLastPosIndex]
    }));
}

function menuColorPickerGoto(hor, vert) {
    $('.colorPicker-column').eq(colorIndex).removeClass('colorPicker-columnSelected');

    if (hor != 0) {
        colorIndex += hor;

        if (hor > 0 && colorIndex % grid.x == 0) {
            colorIndex -= grid.x;
        }
        if (hor < 0 && (colorIndex % grid.x == (grid.x - 1) || colorIndex % grid.x < 0)) {
            colorIndex += grid.x;
        }
    }
    if (vert != 0) {
        colorIndex += (vert * grid.x);
        
        if (colorIndex == -grid.x) {
            colorIndex = $('.colorPicker-column').length - grid.x;
        }
        if (colorIndex < 0) {
            colorIndex = $('.colorPicker-column').length + (colorIndex % grid.x);
        }
        if (colorIndex >= $('.colorPicker-column').length) {
            colorIndex = colorIndex % grid.x;
        }
    }

    $('.colorPicker-column').eq(colorIndex).addClass('colorPicker-columnSelected');

    let tempColor = null;
    if ($('#colorPicker-holder').css("opacity") >= 0.5) {
        tempColor = colorIndex;
        if (isCustom) {
            let temp = getRGBFromString($('.colorPicker-columnSelected').css( "background-color" ));
            tempColor = [temp.red, temp.green, temp.blue];
        }
    }

    $.post('http://esx_mechanic/handle', JSON.stringify({
        type: 'update',
        what: 'menu',
        user: 'hover',
        menuId: menuLastPosIndex,
        menuIndex: menuLastPos[menuLastPosIndex],
        color: tempColor,
        isCustom: isCustom
    }));
}

function updateDetailCardData(data) {
    currentVehicleCard.vehicleName = data.vehicleName ? data.vehicleName : currentVehicleCard.vehicleName
    currentVehicleCard.power = data.power ? data.power : currentVehicleCard.power;
    currentVehicleCard.acceleration = data.acceleration ? data.acceleration : currentVehicleCard.acceleration;
    currentVehicleCard.maxSpeed = data.maxSpeed ? data.maxSpeed : currentVehicleCard.maxSpeed;
    currentVehicleCard.breaks = data.breaks ? data.breaks : currentVehicleCard.breaks;

    $('#detailCard_name').html(currentVehicleCard.vehicleName);
}

function fadeInDetailCard() {
    if (!userDetailCardToggle || !canDetailCardToggle || !$('#detailCard').is(':hidden')) {
        return;
    }
    
    canDetailCardToggle = false;

    $('#card_power_percent').stop(true, true).animate({width: (currentVehicleCard.power * 10) + '%'}, 3000);
    $('#card_power_number').html(currentVehicleCard.power.toFixed(1));

    $('#card_acceleration_percent').stop(true, true).animate({width: (currentVehicleCard.acceleration * 10) + '%'}, 3000);
    $('#card_acceleration_number').html(currentVehicleCard.acceleration.toFixed(1));

    $('#card_maxspeed_percent').stop(true, true).animate({width: (currentVehicleCard.maxSpeed * 10) + '%'}, 3000);
    $('#card_maxspeed_number').html(currentVehicleCard.maxSpeed.toFixed(1));

    $('#card_breaks_percent').stop(true, true).animate({width: (currentVehicleCard.breaks * 10) + '%'}, 3000, function(){
        canDetailCardToggle = true;
    });
    $('#card_breaks_number').html(currentVehicleCard.breaks.toFixed(1));

    $('#detailCard').stop(true, true).animate({
        opacity: 1,
        right: '40px'
    }, 1000)

    $('#detailCard').show();
}

function fadeOutDetailCard() {
    if (userDetailCardToggle || !canDetailCardToggle || !$('#detailCard').is(':visible')) {
        return;
    }

    canDetailCardToggle = false;

    $('#detailCard').stop(true, true).animate({
        opacity: 0,
        right: '-140px'
    }, 1000, function() {
        $('#detailCard').hide();

        $('#card_power_percent').css({width: "0%"});
        $('#card_power_number').html('0.0');
        
        $('#card_acceleration_percent').css({width: "0%"});
        $('#card_acceleration_number').html('0.0');
        
        $('#card_maxspeed_percent').css({width: "0%"});
        $('#card_maxspeed_number').html('0.0');
        
        $('#card_breaks_percent').css({width: "0%"});
        $('#card_breaks_number').html('0.0');

        setTimeout(function(){
            canDetailCardToggle = true;
        }, 1000);
    })
}

function fadeInColorPicker(title, price, defaultValue, whitelistJobName) {
    initColorPicker(title, isOpenByAdmin ? 0 : price, defaultValue, whitelistJobName);
    $('#colorPicker-holder').stop(true, true).animate({
        opacity: 1,
        left: '40px'
    }, 1000)
}

function fadeOutColorPicker() {
    $('#colorPicker-holder').stop(true, true).animate({
        opacity: 0,
        left: '-140px'
    }, 1000)
}

function GetNumberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function initColorPicker(title, price, defaultValue, whitelistJobName) {
    let srting = '';
    let scale = 18

    let tempPrice = price * 2;
    if (whitelistJobName && currentJobName == whitelistJobName) {
        tempPrice = price;
    }

    if (isOpenByAdmin)
        tempPrice = 0

    $('#colorPicker-title').html(title);
    $('#colorPicker-price').html('$' + GetNumberWithCommas(tempPrice));
    if (tempPrice > currentCash) {
        $('#colorPicker-price').addClass('cash_not');
    }else{
        $('#colorPicker-price').removeClass('cash_not');
    }

    $('#colorPicker-container').html('');
    
    if (isCustom != null && !isCustom) {
        grid = {x: colorData[0].length, y: colorData.length};

        let tempCount = 0;
        for (let y = 0; y < colorData.length; y++) {
            srting += `<div class='colorPicker-row'>`;
            for (let x = 0; x < colorData[y].length; x++) {
                let tempClass = '';
                if (tempCount == defaultValue) {
                    tempClass = 'colorPicker-columnDefault colorPicker-columnSelected';
                    colorIndex = tempCount;
                }

                srting += `<div class='colorPicker-column ${tempClass}' style='background-color:rgb(${colorData[y][x][0]},${colorData[y][x][1]},${colorData[y][x][2]});'></div>`;
                tempCount += 1;
            }
            srting += `</div>`;
        }
    } else {
        grid = {x: 16, y: 16}

        let hslOfDefault = rgbToHsl(defaultValue[0], defaultValue[1], defaultValue[2]);
        
        let tempCount = 0;
        srting += `<div class='colorPicker-row'>`;
        for (let x = 0; x < grid.x; x++) {
            let h = 0;
            let s = 0;
            let l = 100 - (x * 100 / (grid.x - 1));

            let tempClass = '';
            if (Math.abs(hslOfDefault[0] - h.toFixed(2)) <= 0.01 && Math.abs(hslOfDefault[1] - s.toFixed(2)) <= 0.01 && Math.abs(hslOfDefault[2] - l.toFixed(2)) <= 0.01) {
                tempClass = 'colorPicker-columnDefault colorPicker-columnSelected';
                colorIndex = tempCount;
            }
            
            srting += `<div class='colorPicker-column ${tempClass}' style='background-color:hsl(${h}deg,${s}%,${l}%);'></div>`;
            tempCount += 1;
        }
        srting += `</div>`;

        for (let y = 3; y < grid.y; y++) {
            srting += `<div class='colorPicker-row'>`;
            for (let x = 0; x < grid.x; x++) {
                let h = 360 / grid.x * x;
                let s = 200 / grid.y * y;
                let l = 100 - (100 / grid.y * y);

                let tempClass = '';
                // if (Math.abs(hslOfDefault[0] - h.toFixed(2)) <= 10.0 && Math.abs(hslOfDefault[1] - s.toFixed(2)) <= 10.0 && Math.abs(hslOfDefault[2] - l.toFixed(2)) <= 10.0) {
                //     tempClass = 'colorPicker-columnDefault colorPicker-columnSelected';
                //     colorIndex = tempCount;
                // }
                
                srting += `<div class='colorPicker-column ${tempClass}' style='background-color:hsl(${h}deg,${s}%,${l}%);'></div>`;
                tempCount += 1;
            }
            srting += `</div>`;
        }
    }

    $('#colorPicker-container').html(srting);
    
    $('#colorPicker-holder').width((grid.x * scale) + (grid.x * 6) - 2);
    $('.colorPicker-column').height(scale - 2);

    if ($('.colorPicker-columnSelected').length < 1) {
        $('.colorPicker-column').eq(0).addClass('colorPicker-columnDefault');
        $('.colorPicker-column').eq(0).addClass('colorPicker-columnSelected');
        colorIndex = 0;
    }
}

function rgbToHsl(r, g, b) {
    r /= 255, g /= 255, b /= 255;
    let max = Math.max(r, g, b), min = Math.min(r, g, b);
    let h, s, l = (max + min) / 2;

    if(max == min){
        h = s = 0; // achromatic
    }else{
        let d = max - min;
        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
        switch(max){
            case r: h = (g - b) / d + (g < b ? 6 : 0); break;
            case g: h = (b - r) / d + 2; break;
            case b: h = (r - g) / d + 4; break;
        }
        h /= 6;
    }
    s *= 100;
    l *= 100;
    return [h.toFixed(2),s.toFixed(2), l.toFixed(2)];
}

function getRGBFromString(str){
    let match = str.match(/rgba?\((\d{1,3}), ?(\d{1,3}), ?(\d{1,3})\)?(?:, ?(\d(?:\.\d?))\))?/);
    return match ? {
        red: match[1],
        green: match[2],
        blue: match[3]
    } : {};
}

function playSound(soundName, volume) {
    let audioElement = document.createElement('audio');
    audioElement.setAttribute('src', 'sounds/' + soundName + '.ogg');
    audioElement.volume = volume;

    audioElement.addEventListener('ended', function() {
        this.remove();
    }, false);

    audioElement.play();
}