<IMPORTANT>
Join my Discord and open a Ticket.
Post in this Ticket that you need the Phone role. To proof that you really bought the phone, send a screenshot from the Mail, which you received from Tebex.
Discord Link  > https://discord.gg/tngc5yN6mf

<INSTALLATION>
1. Drag it in your resource folder 
2. add this in your server.cfg
 start d-phone
3. insert the sql in your database
4. Replace this to <esx_ambulancejob> > <main.lua>

Search for SendDistressSignal() and replace it with this

```lua
function SendDistressSignal()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local position = {x = coords.x, y = coords.y, z = coords.z}

	TriggerServerEvent("d-phone:server:sendservicemessage", GetPlayerServerId(PlayerId()), "Unconscious person", "yourambulancejoblabel", 0, 1, position, "5")
	TriggerEvent("d-notification", "Service Message sended", 5000,  "rgba(255, 0, 0, 0.8)")
end
```

Pay attention that you really replace "yourambulancejoblabel" in the function

5. GO in your Database and set the jobs which you want to have an businessapp

if hasapp = 1 then the job will have the app.
If onlyboss = 1 and hasapp = 1 then only the boss will have the app
if handyservice = 1 then it will be shown in the service app


If you want to replace a locale you need to change it in the config but also in the html > js > locales.js
There are some locales in the js > locales folder

<Support>
If there are any bugs then report these on my Discord > https://discord.gg/tngc5yN6mf

 <RIGHTS>
 You are not allowed to sell this script. 
 CREATOR: d-development.xyz
