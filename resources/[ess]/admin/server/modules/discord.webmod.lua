local WEBHOOK = Config.DiscordWebhook
if Config.EnableDiscordLogging then
    assert(WEBHOOK ~= "", 'Setup your Discord Webhook at "@admin/server/config.web.lua" for logs!')
end

local function SecureContent(content)
    content = content:trim()
    
    if string.len(content) > 1999 then
        print('Webhook sending more than 2000 characters')
        return (string.sub(content, 0, 1999-string.len(content))):trim()
    end
    return content
end

local function EmbedObject(parameters)
    return {
        title = parameters.title,
        type = parameters.type or "rich",
        description = parameters.description,
        url = parameters.url,
        timestamp = parameters.timestamp or os.date("!%Y-%m-%dT%H:%M:%SZ"),
        color = parameters.color or 0,
        footer = parameters.footer,
        image = parameters.image,
        thumbnail = parameters.thumbnail,
        video = parameters.video,
        provider = parameters.provider,
        author = parameters.author,
        fields = parameters.fields
    }
end

local function EmbedAuthorObject(parameters)
    return {
        name = parameters.name,
        url = parameters.url,
        icon_url = parameters.icon_url,
        proxy_icon_url = parameters.proxy_icon_url,
    }
end

local function EmbedColorValue(color)
    local colors = {
        ['DEFAULT']             = 0,
        ['AQUA']                = 1752220,
        ['DARK_AQUA']           = 1146986,
        ['GREEN']               = 3066993,
        ['DARK_GREEN']          = 2067276,
        ['BLUE']                = 3447003,
        ['DARK_BLUE']           = 2123412,
        ['PURPLE']              = 10181046,
        ['DARK_PURPLE']         = 7419530,
        ['LUMINOUS_VIVID_PINK'] = 15277667,
        ['DARK_VIVID_PINK']     = 11342935,
        ['GOLD']                = 15844367,
        ['DARK_GOLD']           = 12745742,
        ['ORANGE']              = 15105570,
        ['DARK_ORANGE']         = 11027200,
        ['RED']                 = 15158332,
        ['DARK_RED']            = 10038562,
        ['GREY']                = 9807270,
        ['DARK_GREY']           = 9936031,
        ['DARKER_GREY']         = 8359053,
        ['LIGHT_GREY']          = 12370112,
        ['NAVY']                = 3426654,
        ['DARK_NAVY']           = 2899536,
        ['YELLOW']              = 16776960,
        ['WHITE']               = 16777215,
        ['BLURPLE']             = 7506394,
        ['GREYPLE']             = 10070709,
        ['DARK_BUT_NOT_BLACK']  = 2895667,
        ['NOT_QUITE_BLACK']     = 2303786,
    }
    return colors[color:upper()] or colors['DEFAULT']
end

function SendWebhook(title, message, author)
    if not Config.EnableDiscordLogging then return true end
    local status, response, headers = request.post(WEBHOOK, {
        username = "ESX Manager",
        embeds = {
            EmbedObject{
                title = title,
                description = SecureContent(message),
                author = EmbedAuthorObject{name = "Executor: " .. author},
                color = EmbedColorValue "red",
            },
        }
    })
    if status ~= 204 then
        print("Sending webhook", status, response, json.encode(headers))
    end
    return status == 204
end
