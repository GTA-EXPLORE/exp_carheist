ESX = exports["es_extended"]:getSharedObject()
-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetPoliceCount()
    local players = ESX.GetPlayers()
    local count = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player.job.name == 'lspd' then
            count = count + 1
        end
    end

    return count
end

function DiscordLog(player_src, event)
    -- Setup our discord log here.
end

function GivePlayerRewards(player_src, earnings)
    local xPlayer = ESX.GetPlayerFromId(player_src)
    xPlayer.addAccountMoney('black_money', earnings)
end

function DoesPlayerHaveItem(player_src, item)
    return ESX.GetPlayerFromId(player_src).getInventoryItem(item).count > 0
end