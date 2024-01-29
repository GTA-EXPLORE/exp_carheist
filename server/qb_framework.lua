if GetResourceState("qb-core") == "started" then
    print("^5Starting with QB-Core^0")
    QBCore = exports['qb-core']:GetCoreObject()

    function GetPoliceCount()
        local count = 0
        for ServerId, Player in ipairs(QBCore.Functions.GetQBPlayers()) do
            if Player.PlayerData.job.name == "police" then
                count = count + 1
            end
        end
        return count
    end
    
    function DiscordLog(player_src, event)
        -- Setup your logs
    end
    
    function GivePlayerRewards(player_src, earnings)
        QBCore.Functions.GetPlayer(player_src).Functions.AddMoney("cash", earnings)
    end
    
    function DoesPlayerHaveItem(source, item)
        local player_item = QBCore.Functions.GetPlayer(source).Functions.GetItemByName(item)
        return not item or (player_item and player_item.amount >= 0 or false)
    end
end