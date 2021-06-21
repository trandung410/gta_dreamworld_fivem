-- Created By.xZero



ESX = nil

Citizen.CreateThread(function() 
    Citizen.Wait(1000)
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    ESX.RegisterServerCallback('xscoreboard:server:getdata', function(source, cb)
        local iden = GetPlayerIdentifiers(source)[1]
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @iden LIMIT 0,1', {
            ['@iden'] = iden
        }, function(result)
            if not (result[1] == nil) then
                local data = {}
                local grade_job = GetGradeJob(result[1].job, result[1].job_grade)
                local job_label = GetJobLabel(result[1].job)
                local xPlayers = ESX.GetPlayers()
                local players = 0
                local police = 0
                local ems = 0
                local mc = 0
                for i=1, #xPlayers, 1 do
                    players = (players + 1)
                    local xP = ESX.GetPlayerFromId(xPlayers[i])
                    local xP_Job = xP.getJob()
                    if xP_Job.name == "police" then
                        police = (police + 1)
                    elseif xP_Job.name == "ambulance" then
                        ems = (ems + 1)
                    elseif xP_Job.name == "mechanic" then
                        mc = (mc + 1)
                    end
                end
                
                table.insert(data, {
                    my_phonenmumber = result[1].phone_number,
                    my_fullname = result[1].name,
                    my_job = job_label..' - '..grade_job,
                    my_ping = GetPlayerPing(source),
					players = players,
                    police = police,
                    ems = ems,
                    mc = mc
                })

                cb(data)
            else
                cb(nil)
            end
        end)
    end)

end)

function GetGradeJob(job_name, job_grade)
    local result = MySQL.Sync.fetchAll('SELECT label FROM job_grades WHERE job_name = @job_name AND grade = @job_grade', {
        ['@job_name'] = job_name,
        ['@job_grade'] = job_grade
    })
    if not (result[1] == nil) then
        return result[1].label
    end
    return nil
end
function GetJobLabel(job_name)
    local result = MySQL.Sync.fetchAll('SELECT label FROM jobs WHERE name = @job_name', {
        ['@job_name'] = job_name
    })
    if not (result[1] == nil) then
        return result[1].label
    end
    return nil
end
