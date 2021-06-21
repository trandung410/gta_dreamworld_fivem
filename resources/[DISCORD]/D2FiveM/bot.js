const Discordie = require("discordie");
const Events = Discordie.Events;
const Client = new Discordie();
const Config = require("./config.json");
const Lang = require("./language.json");
const Chans = require("./channels.json");
var Reason = "";
var Message;

Client.connect({ token: Config.token });
Client.Dispatcher.on(Events.GATEWAY_READY, e => {
	console.log(`Bot has started as ${Client.User.username}.`); 
	Client.User.setGame({type: 0, name: "Dream World RP"});
	// Client.User.setGame('Galaxy RP')
});

Client.Dispatcher.on(Events.MESSAGE_CREATE, async e => {
	var message = e.message
	if(message.author.bot) return;
	if(message.content.indexOf(Config.prefix) !== 0) return;

	const args = message.content.slice(Config.prefix.length).trim().split(/ +/g);
	const command = args.shift().toLowerCase();
	const ChannelCheck = IsChannelAllowed(message.channel.id, command);

	if (ChannelCheck === true) {
		Message = message
		
		if (command === "cmdlist") {
			ReturnMessageToDiscord(command, "");
			//return message.delete().catch(O_o=>{}); 
		};
		if (command === "help") {
			ReturnMessageToDiscord(command, "");
			//return message.delete().catch(O_o=>{}); 
		};
		
		switch(command) {
			case "ip":
				message.reply("```IP Server: cfx.re/join/gged7m\nHướng dẫn kết nối server\n-C1: Vào bằng list fiveM\n-C2: F8 -> Nhập connect cfx.re/join/gged7m -> Enter ```");
				break;
			// case "players":
			// 	if (args.length === 0) {
			// 		emit("D2FiveM:Request", command);
			// 	} else {
			// 		message.reply(Lang.commandNoArgs);
			// 	};
			// 	break;
			case "getclients":
				if (args.length === 0) {
					emit("D2FiveM:Request", command);
				} else {
					message.reply(Lang.commandNoArgs);
				};
				break;
			case "send":
				var TheActualMessage = args.join(" ");
				if (TheActualMessage.length > 0 && TheActualMessage !== "<MESSAGE>") {
					emit("D2FiveM:Request", command, "^3[ADMIN] ^2" + Message.author.username , TheActualMessage);
				} else {
					message.reply(Lang.sendNoMessage);
				};
				break;
			case "uptime":
				emit("D2FiveM:Request", command);
				break;
			case "kick":
				var ServerID = parseInt(args[0], 10);

				if (ServerID) {
					args.splice(0, 1);
					var TheActualReason = args.join(" ");
					
					if (ServerID < 10) {
						ServerID = "0" + ServerID;
					};
					
					if (TheActualReason.length > 0 && TheActualReason !== "<REASON>") {
						Reason = TheActualReason;
						emit("D2FiveM:Request", command, ServerID, TheActualReason);
					} else {
						message.reply(Lang.kickbanNoReason);
					};
				} else {
					message.reply(Lang.kickbanNoServerID);
				};
				break;
			case "ban":
				var ServerID = parseInt(args[0], 10);

				if (ServerID) {
					args.splice(0, 1);
					var TheActualReason = args.join(" ");

					if (ServerID < 10) {
						ServerID = "0" + ServerID;
					};
					
					if (TheActualReason.length > 0 && TheActualReason !== "<REASON>") {
						Reason = TheActualReason;
						emit("D2FiveM:Request", command, ServerID, TheActualReason);
					} else {
						message.reply(Lang.kickbanNoReason);
					};
				} else {
					message.reply(Lang.kickbanNoServerID);
				};
				break;
			case "reviveall":
				if (args.length === 0) {
					emit("D2FiveM:Request", command);
				} else {
					message.reply(Lang.commandNoArgs);
				};
				break;
			case "revive":
				var ServerID = parseInt(args[0], 10);

				if (ServerID) {
					args.splice(0, 1);
					if (ServerID < 10) {
						ServerID = "0" + ServerID;
					};
					emit("D2FiveM:Request", command, ServerID);
				} else {
					message.reply(Lang.kickbanNoServerID);
				};
				break;
			case "news":
				var dem = 0;
				for (const property in args) {
					dem = dem + 1 ;
				}
				var TheActualMessage = args.join(" ");
				if (TheActualMessage.length > 0 && TheActualMessage !== "<MESSAGE>" && dem > 0 ) {
					emit("D2FiveM:Request", command, Message.author.username , TheActualMessage,dem);
				} else {
					message.reply(Lang.sendNoMessage);
				};
				break;
			case "tp":
				var ServerID = parseInt(args[0], 10);
				if (ServerID) {
					args.splice(0, 1);
					if (ServerID < 10) {
						ServerID = "0" + ServerID;
					};
					emit("D2FiveM:Request", command, ServerID);
				} else {
					message.reply(Lang.kickbanNoServerID);
				};
				break;
			case "resourcestop":
				if (args.length === 1 || args[0] !== "<RESOURCE_NAME>") {
					emit("D2FiveM:Request", command, args[0]);
				} else {
					message.reply(Lang.resourceNoSpace);
				};
				break;
			case "resourcestart":
				if (args.length === 1 || args[0] !== "<RESOURCE_NAME>") {
					emit("D2FiveM:Request", command, args[0]);
				} else {
					message.reply(Lang.resourceNoSpace);
				};
				break;
			case "resourcerestart":
				if (args.length === 1 || args[0] !== "<RESOURCE_NAME>") {
					emit("D2FiveM:Request", command, args[0]);
				} else {
					message.reply(Lang.resourceNoSpace);
				};
				break;
			case "resourcerefresh":
				if (args.length === 0) {
					emit("D2FiveM:Request", command);
				} else {
					message.reply(Lang.commandNoArgs);
				};
				break;
			case "resourcelist":
				if (args.length === 0) {
					emit("D2FiveM:Request", command);
				} else {
					message.reply(Lang.commandNoArgs);
				};
				break;
			default:
		};
	};
	//message.delete().catch(O_o=>{}); 
});

async function ReturnMessageToDiscord(Command, Value1, Value2, Value3) {	
	var ReturnChannels = GetReturnChannels(Message, Command);
	
	ReturnChannels.forEach(function(channel) {
		switch(Command) {
			case "cmdlist":
				Message.channel.sendMessage("", false, {
														"color": 4768928,
														"title": Lang.CommandList + ":",
														"fields": [
																   {
																	"name": Config.prefix + "cmdlist",
																	"value": Lang.cmdlistDesc
																   },
																   {
																	"name": Config.prefix + "getclients",
																	"value": Lang.getclientsDesc
																   },
																   {
																	"name": Config.prefix + "send <MESSAGE>",
																	"value": Lang.sendDesc
																   },
																   {
																	"name": Config.prefix + "revive <SERVER_ID>",
																	"value": "Hồi sinh 1 người chơi"
																   },
																   {
																	"name": Config.prefix + "reviveall",
																	"value": "Hồi sinh tất cả người chơi"
																   },
																   {
																	"name": Config.prefix + "news <MESSAGE>",
																	"value": "Thông báo server"
																   },
																   {
																	"name": Config.prefix + "tp <SERVER_ID>",
																	"value": "Teleport người chơi ra GARA Trung Tâm"
																   },
																   {
																	"name": Config.prefix + "kick <SERVER_ID> <REASON>",
																	"value": Lang.kickDesc
																   },
																   {
																	"name": Config.prefix + "ban <SERVER_ID> <REASON>",
																	"value": Lang.banDesc
																//    },
																//    {
																// 	"name": Config.prefix + "resourcestop <RESOURCE_NAME>",
																// 	"value": Lang.resourcestopDesc
																//    },
																//    {
																// 	"name": Config.prefix + "resourcestart <RESOURCE_NAME>",
																// 	"value": Lang.resourcestartDesc
																//    },
																//    {
																// 	"name": Config.prefix + "resourcerestart <RESOURCE_NAME>",
																// 	"value": Lang.resourcerestartDesc
																//    },
																//    {
																// 	"name": Config.prefix + "resourcerefresh",
																// 	"value": Lang.resourcerefreshDesc
																//    },
																//    {
																// 	"name": Config.prefix + "resourcelist",
																// 	"value": Lang.resourcelistDesc
																   }
																  ],
														"footer": {
																   "text": "Requested by " + Message.author.username + "#" + Message.author.discriminator,
																   "icon_url": "https://i.imgur.com/9NRAzos.png"
																  }
														}
														   
										   );
				break;
				case "help":
				//message.reply("```IP Server: c103.205.107.119\nHướng dẫn kết nối server\n-C1: Vào bằng list fiveM\n-C2: F8 -> Nhập connect 103.205.107.119 -> Enter ```");

				Message.channel.sendMessage("", false, {
														"color": 41372,
														"title": Lang.CommandList + ":",
														"fields": [
																//    {
																// 	"name": Config.prefix + "help",
																// 	"value": "```"+Lang.helpDesc+"```"
																//    },
																//    {
																// 	"name": Config.prefix + "players",
																// 	"value": "```"+Lang.getclientsDesc+"```"
																//    },
																   {
																	"name": Config.prefix + "ip",
																	"value": "```Hiển thị ip của server```"
																   },
																   {
																	"name": Config.prefix + "uptime",
																	"value": "```Hiển thị uptime của server```"
																   },
																  ],
														"footer": {
																   "text": "Requested by " + Message.author.username + "#" + Message.author.discriminator,
																   "icon_url": "https://i.imgur.com/9NRAzos.png"
																  }
														}
														   
										   );
				break;
			// case "players":
			// 	if (Value1 !== undefined && Value1.length > 0 && Value1 !== "```lua\nCó vẻ như không có người chơi nào online ... ¯\\_(ツ)_/¯```") {
			// 		Message.channel.sendMessage("**" + Lang.getclientsConnectedClients + ":**\n" + Value1);
			// 	} else {
			// 		Message.channel.sendMessage("**" + Lang.getclientsConnectedClients + ":**\n" + Value1);
		
			// 	};
			// 	break;
			case "getclients":
				if (Value1 !== undefined && Value1.length > 0 && Value1 !== "```lua\nCó vẻ như không có người chơi nào online ... ¯\\_(ツ)_/¯```") {
					Message.channel.sendMessage("**" + Lang.getclientsConnectedClients + ":**\n" + Value1);
		
				} else {
					Message.channel.sendMessage("**" + Lang.getclientsConnectedClients + ":**\n" + Value1);
		
				};
				break;
			case "uptime":
				Message.reply("\n Dream World RP \n" + Value1);

					   
				break;
			case "send":
				if (Value1 === "Sent") {
					Message.reply("\n" + Lang.sendMessageSent);
				} else {
					Message.reply("\n" + Lang.sendError);
				};
				break;
			case "kick":
				if (Value1 === 'Kicked') {
					if (Config.kickbanLogChannel !== undefined && Config.kickbanLogChannel !== "") {
						Client.channels.get(Config.kickbanLogChannel).send(Message.author + " " + Lang.kickLogKicked + " " + Value2 + "\n" + Lang.kickbanLogReason + ": " + Reason);
					};
					Message.reply("\n" + Lang.kickKicked);
				} else {
					Message.reply("\n" + Lang.kickbanElse);
				};
				break;
			case "ban":
				if (Value1 === 'Banned') {
					if (Config.kickbanLogChannel !== undefined && Config.kickbanLogChannel !== "") {
						var dur = ""
						if (Value3 === "0") {
							dur = Lang.banLogBannedForever
						} else {
							dur = Value3 + " " + Lang.banLogBannedHours
						};
						Client.channels.get(Config.kickbanLogChannel).send(Message.author + " " + Lang.banLogBanned + " " + Value2 + "\n" + Lang.kickbanLogReason + ": " + Reason + "\n" + Lang.banLogBannedDuration + ": " + dur);
					};
					Message.reply("\n" + Lang.banBanned);
				} else {
					Message.reply("\n" + Lang.kickbanElse);
				};
				break;
			case "reviveall":
				if (Value1 === "revivedall") {
					Message.reply("Đã hồi sinh tất cả mọi người");
				} else {
					Message.reply("Chưa hồi sinh tất cả mọi người");
				};
				break;
			case "revive":
				if (Value1 === "revived") {
					Message.reply("Đã hồi sinh người này");
				} else {
					Message.reply("Lỗi hồi sinh người này");
				};
				break;
				case "freeze":
				if (Value1 === "freezed") {
					Message.reply("Đã đóng băng người này");
				} else {
					Message.reply("Lỗi đóng băng người này");
				};
				break;
				case "unfreeze":
				if (Value1 === "unfreezed") {
					Message.reply("Đã hủy đóng băng người này");
				} else {
					Message.reply("Lỗi hủy đóng băng người này");
				};
				break;
			case "tp":
				if (Value1 === "tp_ed") {
					Message.reply("Đã Teleport người này");
				} else {
					Message.reply("Lỗi Teleport người này");
				};
				break;
			case "news":
				if (Value1 === "newsed") {
					Message.reply("Đã thông báo Server!");
				} else {
					Message.reply("Lỗi thông báo Server!");
				};
				break;
			case "cleareverything":
				if (Value1 === "clear") {
						Message.reply("Bắt đầu cleareverything!");
				} else {
						Message.reply("Lỗi cleareverything!");
				};
				break;
			case "resourcestop":
				if (Value1 === "Stopped") {
					Message.reply("\n" + Lang.resourcestopStopped);
				} else {
					Message.reply("\n" + Lang.resourceError);
				};
				break;
			case "resourcestart":
				if (Value1 === "Started") {
					Message.reply("\n" + Lang.resourcestartStarted);
				} else {
					Message.reply("\n" + Lang.resourceError);
				};
				break;
			case "resourcerestart":
				if (Value1 === "Restarted") {
					Message.reply("\n" + Lang.resourcerestartRestarted);
				} else {
					Message.reply("\n" + Lang.resourceError);
				};
				break;
			case "resourcerefresh":
				if (Value1 === "Refreshed") {
					Message.reply("\n" + Lang.resourcerefreshRefreshed);
				} else {
					Message.reply("\n" + Lang.resourceError);
				};
				break;
			case "resourcelist":
				Message.reply("\n```\n" + Value1 + "\n```");
				break;
			default:
		};
	});
	Reason = "";
	Message = null;
}

on('D2FiveM:Response', (Command, ResponseValue1, ResponseValue2, ResponseValue3) => {
	ReturnMessageToDiscord(Command, ResponseValue1, ResponseValue2, ResponseValue3);
});

on('D2FiveM:Reset', () => {
	console.log("Reset Discord Bot");
	Client.connect({ token: Config.token });
});


function IsChannelAllowed(Channel, Command) {	
	const PathChannels = eval("Chans." + Command + "Channel");
	
	for (CurrentChannel in PathChannels) {
		if (eval("Chans." + Command + "Channel." + CurrentChannel) === Channel) {
			return true;
		};
	};
			
	return false;
}

function GetReturnChannels(message, Command) {	
	const PathReturnChannels = eval("Chans." + Command + "ReturnChannel");
	var AvailableChannels = [];

	for (CurrentChannel in PathReturnChannels) {
		if (eval("Chans." + Command + "ReturnChannel." + CurrentChannel) !== undefined && eval("Chans." + Command + "ReturnChannel." + CurrentChannel) !== "" && AvailableChannels.includes(eval("Chans." + Command + "ReturnChannel." + CurrentChannel)) === false) {
			AvailableChannels.splice(0, 0, eval("Chans." + Command + "ReturnChannel." + CurrentChannel));
		};
	};
			
	if (AvailableChannels.length === 0) {
		AvailableChannels.splice(0, 0, message.channel.id);
	};
	return AvailableChannels;
}

