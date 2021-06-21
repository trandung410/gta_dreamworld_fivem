$(document).ready(function(){

    function Error(element, msg, time = 1000){
        $(element).addClass("error")
        $(element).addClass("animate__animated")
        $(element).addClass("animate__headShake")
        $(".noti").append(`
            <p class="notification">${msg}</p>
        `)
        setTimeout(function(){
            $(element).removeClass("error")
            $(element).removeClass("animate__animated")
            $(element).removeClass("animate__headShake")
        }, time)
        setTimeout(function(){
            $(".noti").empty()
        }, 5000)
    }


    window.addEventListener("message", function(e){
        var event = e.data.event;
        var data = e.data.data;
        switch(event){
            case "toggle":
                if (data == true){
                    $("#app").fadeIn()
                }else{
                    $("#app").fadeOut()
                }
                break;
            case "init":
                for(var i in data){
                    if(i == "color"){
                        $(`#${i}`).css("color", `rgb(${data[i][0]}, ${data[i][1]}, ${data[i][2]})`)
                    }else{
                        $(`#${i}`).text(data[i])
                    }
                }
                break;
            default:
        }
    })
    $(document).on("click", "#accept", function(){
        var plate = $("#plate").text();
        var reason = $("#reason").val();
        var fine = parseInt($("#fine").val());
        console.log(plate, reason, fine)
        if (fine <= 0 || fine >= 1000000){
            Error("#fine", "tiền phạt phải lớn hơn 0 và nhỏ hơn 1.000.000")
            return
        }
        if(reason.length < 10){
            Error("#reason", "lý do phải lớn hơn 10 ký tự")
            return
        }
        $.post("https://lr_impound/Impound", JSON.stringify({
            plate: plate,
            reason: reason,
            fine: fine
        }))
    })
    $(document).on("click", "#cancel", function(){
        $.post("https://lr_impound/Close")
    })
    $(document).on("keyup", function(e){
        if (e.key == "Escape"){
            $.post("https://lr_impound/Close")
        }
    })
})