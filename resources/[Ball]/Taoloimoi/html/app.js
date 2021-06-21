setTimeout(function(){ $("#box").fadeOut(); }, 500);
$.post("http://fd_frakmenu/fd_frakmenu:fade");


window.onload = function(e) {
  window.addEventListener('message', function(event) {
    let data = event.data
    $("#box").fadeIn();
        document.getElementById("title").textContent = data.title;
        document.getElementById("description").textContent = data.message;
  })
}

$("#okbtn").click(function () {
  $("#box").fadeOut();
  $.post("http://fd_frakmenu/fd_frakmenu:ja");
});

$("#nebtn").click(function () {
  $("#box").fadeOut();
  $.post("http://fd_frakmenu/fd_frakmenu:ciao");
});