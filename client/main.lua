local plane

Citizen.CreateThread(function()
    if START_SCENE.enable then
        local ped = SpawnNPC(START_SCENE.ped.model, START_SCENE.ped.coords, START_SCENE.ped.heading)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
        
        AddEntityMenuItem({
            entity = ped,
            event = "exp_carheist:StartHeist",
            desc = _("start_npc_desc"),
            name = _("start_npc_name")
        })
    end
end)

function StartCarHeist()
    TriggerServerCallback('exp_carheist:checkPoliceCount', function(enough_police)
        if not enough_police then
            ShowNotification({
                message = _("not_enough_police"),
                type = "error"
            })
            return
        end

        TriggerServerCallback('exp_carheist:checkTime', function(already_robbed)
            if already_robbed then
                ShowNotification({
                    message = _("already_robbed"),
                    type = "error"
                })
                return
            end

            ShowNotification({
                message = _("start_heist"),
                type = "default"
            })
            
            local blip = SetBlip(_('airport_blip'), "airport_blip", PLANE.coords, 90, 1, 0.8)
            SetBlipAsShortRange(blip, false)
            SetupCarHeist()
        end)
    end)
end

RegisterNetEvent("exp_carheist:StartHeist")
AddEventHandler("exp_carheist:StartHeist", StartCarHeist)

local guardPeds = {}
function SetupCarHeist()
    TriggerServerEvent("exp_carheist:SpawnPlane")
end

RegisterNetEvent("exp_carheist:EnterThread")
AddEventHandler("exp_carheist:EnterThread", function(net_plane)
    local ped = PlayerPedId()
    plane = nil
    while true do
        if #(GetEntityCoords(ped) - PLANE.coords) < 300.0 then
            plane = NetworkGetEntityFromNetworkId(net_plane)
            if DoesEntityExist(plane) then
                SetEntityInvincible(plane, true)
                SetEntityAsMissionEntity(plane)
                SetVehicleDoorOpen(plane, 2, false, true)
                SetupScene()
                break
            end
        end
        Wait(500)
    end
end)

function SetupScene()
    TriggerServerCallback("exp_carheist:HaveVehiclesSpawn", function(has_spawned)
        if not has_spawned then
            SpawnGuards({ center = PLANE.coords})
            for i, v in ipairs(CARS) do
                local x,y,z = table.unpack(PLANE.coords)
                RequestModel(v.model)
                while not HasModelLoaded(v.model) do Wait(50) end
                local car = CreateVehicle(v.model, vector3(x,y,z+10), 0.0, 1, 1)
                FreezeEntityPosition(car, true)
                SetVehicleDoorsLocked(car, 2)
                AttachEntityToEntity(car, plane, 0, v.offset, 0.0, 0.0, GetEntityHeading(plane)-240, false, false, true, false, 1, true)

                AddEntityMenuItem({
                    entity = car,
                    event = "exp_carheist:HackVehicle",
                    desc = _("hack"),
                    name = _("vehicle_name", firstToUpper(GetDisplayNameFromVehicleModel(v.model):lower()))
                })
            end

        else

            local vehicles = GetVehiclesInArea(PLANE.coords, 50.0)
            while #vehicles == 0 do Wait(5000)
                GetVehiclesInArea(PLANE.coords, 50.0)
            end
            for i, v in ipairs(vehicles) do
                if GetEntityAttachedTo(v) == plane then
                    
                    AddEntityMenuItem({
                        entity = v,
                        event = "exp_carheist:HackVehicle",
                        desc = _("hack"),
                        name = _("vehicle_name", firstToUpper(GetDisplayNameFromVehicleModel(v.model):lower()))
                    })
                end
            end

        end
    end)

end

AddEventHandler("exp_carheist:HackVehicle", function(entity)
    entity = type(entity) == "number" and entity or entity.entity
    HackVehicle(entity)
end)

function HackVehicle(vehicle)
    TriggerServerCallback('exp_carheist:HasItem', function(has_item)
        if not has_item then
            ShowNotification({
                message = _("need_laptop"),
                type = "error"
            })
            return
        end

        local ped = PlayerPedId()
        local tablet_model = GetHashKey("prop_cs_tablet_hack")
        RequestModel(tablet_model)
        while not HasModelLoaded(tablet_model) do Wait(50) end

        local tablet = CreateObject(tablet_model, GetEntityCoords(ped), true, true, false)
        AttachEntityToEntity(tablet, ped, GetPedBoneIndex(ped, 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 1, true)
        SetPedAnim(ped, "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", -1)

        SetFollowPedCamViewMode(4)

        Wait(2000)

        StartHack(function()
            TriggerServerEvent("exp_carheist:FreeVehicle", NetworkGetNetworkIdFromEntity(vehicle))
            FreezeEntityPosition(ped, false)
            TaskWarpPedIntoVehicle(ped, vehicle, -1)
            Deliver(vehicle)

            ClearPedTasks(ped)
            DeleteObject(tablet)
            FreezeEntityPosition(ped, false)
        end, function()
            ClearPedTasks(ped)
            DeleteObject(tablet)
            FreezeEntityPosition(ped, false)
        end)
    end, HACK_ITEM)
end

function Deliver(vehicle, no_info)
    Citizen.CreateThread(function()
        local ped = PlayerPedId()

        if not no_info then
            ShowNotification({
                message = _("deliver"),
                type = "default"
            })
            DeleteBlip("airport_blip")
            local blip = SetBlip(_('buyer_blip'), "buyer_blip", SELLER_SCENE.finish, 500, 1, 0.8)
            SetBlipAsShortRange(blip, false)
        end
        
        local _wait = 2000
        while true do Wait(_wait)
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                _wait = 500
                if #(GetEntityCoords(ped) - SELLER_SCENE.start.coords) < 2.0 then
                    break
                end
            else
                _wait = 2000
            end
        end
        
        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        local camCoords = SELLER_SCENE.cam.coords
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 1000, true, false)
        SetCamCoord(cam, camCoords)
        SetCamRot(cam, SELLER_SCENE.cam.rotation)
    
        while true do Wait(1)
            local dist = #(GetEntityCoords(vehicle) - SELLER_SCENE.finish)
            if dist < 2.0 then
                TriggerServerEvent("exp_carheist:SoldVehicle", GetEntityHealth(vehicle))
                DeleteEntity(vehicle)
                DeleteBlip("buyer_blip")
                break
            elseif dist > 15.0 then
                Deliver(vehicle, true)
                break
            end
        end

        RenderScriptCams(false, true, 1000, 1, 0)
        DestroyCam(cam, false)
    end)
end


RegisterNetEvent("exp_carheist:FreeVehicle")
AddEventHandler("exp_carheist:FreeVehicle", function(net_vehicle)
    local vehicle = NetworkGetEntityFromNetworkId(net_vehicle)
    DetachEntity(vehicle, false, false)
    FreezeEntityPosition(vehicle, false)
    SetVehicleDoorsLocked(vehicle, 1)

end)

RegisterNetEvent("exp_carheist:ShowNotification")
AddEventHandler("exp_carheist:ShowNotification", function(message, type)
    ShowNotification({
        message = message,
        type = type
    })
end)

function SpawnGuards(data)

    for index, value in ipairs(GUARDS.models) do
        _RequestModel(GetHashKey(value))
    end

    local ped = PlayerPedId()

    AddRelationshipGroup('GUARDS')
    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
    SetRelationshipBetweenGroups(0, GetHashKey("GUARDS"), GetHashKey("GUARDS"))
	SetRelationshipBetweenGroups(5, GetHashKey("GUARDS"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GUARDS"))

    for i = 1, GUARDS.amount do
        local position = GetRandomPositionInCircle(data.center, GUARDS.spawn_range)
        while not IsSpawnPointClear(position) do
            position = GetRandomPositionInCircle(data.center, GUARDS.spawn_range)
        end

        local guard = CreatePed(0, GetHashKey(GUARDS.models[math.random(#GUARDS.models)]), position, 0.0, true, true)
        SetEntityAsMissionEntity(guard)
        SetPedRelationshipGroupHash(guard, GetHashKey("GUARDS"))
        SetPedAccuracy(guard, GUARDS.accuracy)
        SetPedArmour(guard, GUARDS.armour)
        SetPedDropsWeaponsWhenDead(guard, false)
        SetPedFleeAttributes(guard, 0, false)
        GiveWeaponToPed(guard, GetHashKey(GUARDS.weapons[math.random(#GUARDS.weapons)]), 255, false, true)
        TaskGuardCurrentPosition(guard, 10.0, 10.0, true)
    end
end