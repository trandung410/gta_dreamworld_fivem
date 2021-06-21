local MySQL = assert(MySQL, 'no MySQL running')

MySQL.ready(function()

local affectedRows = MySQL.Sync.execute(
[[CREATE TABLE IF NOT EXISTS `esx_manager_warns` (
    `id` INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `warned` text NOT NULL,
    `reason` text NOT NULL,
    `date` text
);
CREATE TABLE IF NOT EXISTS `esx_manager_bans` (
    `identifier` VARCHAR(60) PRIMARY KEY NOT NULL,
    `name` TEXT NOT NULL,
    `reason` LONGTEXT NOT NULL
)]])

print('Database ready', affectedRows)
end)