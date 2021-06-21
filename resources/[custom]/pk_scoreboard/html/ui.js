// Created By.xZero
$(function() {
  window.addEventListener("message", function(event) {
    var item = event.data;

    if (item !== undefined) {
      if (item.type == "ui") {
        if (item.display == true) {
          $("body").fadeIn();
        } else {
          $("#body").fadeOut();
        }
      } else if (item.type == "update") {
        $("#my_id").html(item.my_id);
        $("#my_phonenumber").html(item.my_phonenmumber);
        $("#my_fullname").html(item.my_fullname);
        $("#my_job").html(item.my_job);
        $("#my_ping").html(item.my_ping + "ms");
        // document.getElementById("img").src = item.img;

        $("#players").html(item.players);
        $("#police").html(item.police);
        $("#ems").html(item.ems);
        $("#mc").html(item.mc);
      }
    }
  });
});
