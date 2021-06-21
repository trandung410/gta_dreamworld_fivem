var Discordie = require("discordie");
var fs = require("fs");
var client = new Discordie();

on("LRPT:webhook:sendImg", function(id, token, path, msg, filename){

    client.Webhooks.execute(id, token, {
        content: msg,
        username: "LRPT ScreenShot",
        file: fs.readFileSync(path),
        filename: filename+".jpg",
    })
})