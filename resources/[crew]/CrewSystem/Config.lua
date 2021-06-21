show_your_name = true
enable_blips = true
enable_names = true
color_blip = 3 -- blue
sprite_blip = 270

-- name head
scaleY = 0.55
distance_from_head = 1.0
text_font = 0

enable_rank = true
-- Change letters according to your preference
-- d = days
-- m = month
-- y = year
date_format = "%d/%m/%y"

use_script_in_coordinates = false
range_use = 50.0
coordinates = {
    vector3(0.0,0.0,0.0)
}

commands = {
    crewmenu = "crew",
    joincrew = "joincrew",
    createcrew = 'createcrew',
    invitecrew = 'invitecrew',
    leftcrew = 'leftcrew',
    prove = 'provecrew',
    demote = 'demotecrew',
    list = 'listcrew',
    kick = 'kickcrew',
    deletecrew = 'deletecrew',
    ranking = 'rank'
}

translate = {
    TR_CREATE_CREW = "You created the crew",
    TR_CANOT_NAME = "There is already a Crew with that name",
    TR_CANOT_CREATE = "You are already part of a Crew",
    TR_CANOT_CREATE2 = "Use the /exitcrew command to leave your current Crew, or /deletecrew to delete your Crew.",
    TR_NOT_PERMISSION = "You dont have permission or are not part of a crew",
    TR_NOT_FOUND = "Player not found",
    TR_HAS_CREW = "This player already has a Crew",
    TR_RECEIVE_INVITE = "You received an invitation to Crew",
    TR_RECEIVE_INVITE2 = "Use the /joincrew command to join the Crew",
    TR_SEND_INVITE = "Invitation sent",
    TR_HAS_CREW2 = "You already have a Crew",
    TR_NOT_HAS = "You are not in any Crew",
    TR_EXIT = 'You left your Crew',
    TR_DONT_EXIT = "You cannot leave a Crew in which you are the leader.",
    TR_DONT_EXIT2 = "Use the /deletecrew command if you want to delete the crew",
    TR_NOTIFY_DELETE = "The Crew you were a member has been deleted.",
    TR_NOT_PART = "The player is not part of your Crew", 
    TR_RECEIVE_PROVE = "The player was promoted",
    TR_RECEIVE_PROVE2 = "You received a promotion",
    TR_RECEIVE_DEMOTE = "The player was demoted",
    TR_RECEIVE_DEMOTE2 = "You received a demotion",
    TR_KICK = "Player kicked out of the Crew.",
    TR_KICK2 = "You have been kicked out of your Crew",

    TR_CREWNAME = "Crew Name",
    TR_KILLS = "Kills",
    TR_CREATEDAT = "Created At",
    TR_RANKMEMBERS = "Num Members",

    TR_NOT_COORDINATE = "You are not in the right place to use this.",

    TR_CREATE = "Create",
    TR_CREATE2 = "Create a new crew",
    TR_JOIN = "Join",
    TR_JOIN2 = "Join crew",
    TR_INVITE = "Invite",
    TR_INVITE2 = "Invite a member to your crew",
    TR_LEAVE = "Leave",
    TR_LEAVE2 = "Leave your crew",
    TR_PROMOTE = "Promote",
    TR_PROMOTE2 = "Promote a member",
    TR_DEMOTE = "Demote",
    TR_DEMOTE2 = "Demote a member",
    TR_LIST = "List",
    TR_LIST2 = "List of members crew",
    TR_KICK_MENU = "Kick",
    TR_KICK_MENU2 = "Kick a member",
    TR_RANK = "Rank",
    TR_RANK2 = "Crews Classification"
}