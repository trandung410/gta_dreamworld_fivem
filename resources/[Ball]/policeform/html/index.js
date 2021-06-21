$(function () {
    function display(bool) {
        if (bool) {
            $("#container").slideDown(400);
            $("#startscreen ").slideDown(400);
            $("#info").hide()
            $("#done").hide()



            

            
        } else {
            $("#container").hide();
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
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post(`http://${GetParentResourceName()}/exit`, JSON.stringify({}));
            return
        }
    };
    $("#start").click(function () {
        
       $("#startscreen").fadeOut(400)
       $("#info").fadeIn(500)
       $("#warn").hide()

       document.getElementById('firstname').value = ''
       document.getElementById('lastname').value = ''
       document.getElementById('age').value = ''
       document.getElementById('why').value = ''
       document.getElementById('gender').value = ''







    })


    var first = document.getElementById('firstname')
    var last = document.getElementById('lastname')
    var age = document.getElementById('age')
    var why = document.getElementById('why')
    var gender = document.getElementById('gender')


        $(".sumbit").click(function() {
                if($(first , last , age , why , gender).val() === '') {
                    $("#warn").fadeIn(400)
                    return
                    
                } else{
       
          
              
            
                $("#warn").fadeOut(400)
                $("#info").fadeOut(400)
                $("#done").fadeIn(400)
                $.post(
                    `http://${GetParentResourceName()}/name`,
                  JSON.stringify({
                    plate: $("#firstname").val(),     
                    lastname: $("#lastname").val(),
                    age: $("#age").val(),
                    why: $("#why").val(),
                    gender: $("#gender").val(),
                  })
                );
            }
        
    })

    $(".exit").click(function() {

        $("#container").slideUp();
        setTimeout(function(){
            $.post(`http://${GetParentResourceName()}/exit`, JSON.stringify({}));

        },400);


        return
    })
    




        
    

        
    

})
