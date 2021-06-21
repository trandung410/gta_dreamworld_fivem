# ALLHOUSING
ESX breaking backward compatibility (and people ignoring the kashacters requirement on the site) have caused playerhousing to malfunction in many circumstances.
Allhousing aims be the solution for both native housing and playerhousing going forward.
It will support all of K4MB1s shells sold on modit.store, and allow developers easier access to the functions and offsets used to spawn them.

# DEPENDENCIES
meta_libs [https://github.com/meta-hub/meta_libs/releases]
mythic_interiors [https://github.com/meta-hub/mythic_interiors]
input [included in mod pack folder]

optional: vSync [https://github.com/meta-hub/mythic_interiors]

# AUTHORIZATION
Please refer to credentials.lua for instructions on authorising this product. (The mod will not work correctly/at all while it hasn't been authorized.)
Please allow up to 24 hours for the webhook to authorize you for usage before attempting to report that the mod isn't working.
Each set of credentials can be run on a maximum of two servers at a time. Any more and the mod will stop working, and the credentials will be irreversibly blacklisted if suspicious behaviour continues.
  NOTE:
    Your credentials are your only claim to this mod in the future.
    Do not share these.
    If you leave them on a server where multiple people have access, we will not issue you a new set of credentials every time one of your dev makes off with your mods.
    Take responsibility for who you're letting access valuable credentials that you've payed for. Do not become a victim.

# SUPPORT
https://discord.gg/4S7FcFs
Head to the discord link provided for bug reports and support requests. Generally the community will be able to answer your questions, so posting minor questions in the public channels is usually fine.
For anything more serious, use the #contact-us channel, where the bot will automatically open a ticket with us.
There will be no support given for any mod that is purchased anywhere besides https://modit.store.
You must be able to prove your ownership of the mod before continueing with any support request (NOTE: This does not mean post your credentials in the public channels).
If you purchased the mod elsewhere, you should refund your purchase, re-purchase the product from modit.store, and update to the latest version provided through the download link.

# CONFIGURATION
Make sure you check the config.lua file before attempting to run this mod.
If you opt out of using ESX, you have much work to do (see # CUSTOM FRAMEWORK USERS below).
Probably don't use Crazy Colors option (unless you're listening to "Eminem - Without Me").
If you're using Kashacters, the mod cannot be restarted without relogging.

# ADDING HOUSES
Players with the correct job (set in the config.lua, CreationJobs) can use the /createhouse command to follow the prompts.
You can alternatively add directly to the Houses table found at src/houses.lua.

# ESX_INVENTORYHUD INFO
If you're using esx_inventoryhud (the only inventory supported...), make sure you drag and drop the property.lua provided into your esx_inventoryhud/client folder.
Back your previous file up before overwriting, just incase.

# ESX_USERS
Make sure you set "Using V1.2.0" to true in config if you're using V1.2+, accounting for weight and account/bank changes.
Make sure you have the bank and cash account set correctly.

# CUSTOM FRAMEWORK USERS
Find and edit the following files:
  src/client/framework/framework_functions.lua
  src/client/commands.lua
  src/server/framework/framework_functions.lua
  src/server/main.lua