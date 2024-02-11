local already_robbed = false

RegisterServerCallback('exp_carheist:checkPoliceCount', function(source, cb)
    cb(GetPoliceCount() >= POLICE_REQUIRED)
end)

RegisterServerCallback('exp_carheist:checkTime', function(source, callback)
    callback(already_robbed)
    if not already_robbed then
        DiscordLog(source, {
            name = "start"
        })
    end
end)

local vehicles_spawned = false
RegisterServerEvent("exp_carheist:SpawnPlane")
AddEventHandler("exp_carheist:SpawnPlane", function()
    local plane = CreateVehicle(GetHashKey(PLANE.model), PLANE.coords, PLANE.heading, 1, 0)
    -- FreezeEntityPosition(plane, true)
    vehicles_spawned = false
    while not DoesEntityExist(plane) do Wait(1) end
    TriggerClientEvent("exp_carheist:EnterThread", -1, NetworkGetNetworkIdFromEntity(plane))
    already_robbed = true
    Wait(INTERVAL)
    already_robbed = false
    vehicles_spawned = false
    if DoesEntityExist(plane) then
        DeleteEntity(plane)
    end
    DiscordLog(_source, {
        name = "reset"
    })
end)

local heist_owner = nil
RegisterServerCallback("exp_carheist:HaveVehiclesSpawn", function(source, callback)
    callback(vehicles_spawned)
    if not vehicles_spawned then
        heist_owner = source
    end
    vehicles_spawned = true
end)

RegisterServerEvent("exp_carheist:SoldVehicle")
AddEventHandler("exp_carheist:SoldVehicle", function(vehicle_health)
    local _source = source
    
    local ped = GetPlayerPed(_source)
    if #(GetEntityCoords(ped) - SELLER_SCENE.finish) > 50.0 then
        DiscordLog(_source, {
            name = "cheater"
        })
        return
    end

    local earnings = math.ceil(VEHICLE_EARNINGS - ((1-vehicle_health/1000) * MAX_DAMAGE_LOSS))
    GivePlayerRewards(_source, earnings)
    
    TriggerClientEvent("exp_carheist:ShowNotification", _source, _("earned", earnings), "default")
    DiscordLog(_source, {
        name = "vehicle-sold",
        earnings = earnings
    })
end)

RegisterServerEvent("exp_carheist:FreeVehicle")
AddEventHandler("exp_carheist:FreeVehicle", function(net_vehicle)
    TriggerClientEvent("exp_carheist:FreeVehicle", heist_owner, net_vehicle)
end)

RegisterServerCallback("exp_carheist:HasItem", function(source, callback, item)
    callback(DoesPlayerHaveItem(source, item))
end)