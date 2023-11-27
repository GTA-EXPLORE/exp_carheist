local ServerCallbacks, CurrentRequestId = {}, 0

function TriggerServerCallback(name, cb, ...)
	ServerCallbacks[CurrentRequestId] = cb

	TriggerServerEvent('exp_carheist:triggerServerCallback', name, CurrentRequestId, ...)

	if CurrentRequestId < 65535 then
		CurrentRequestId = CurrentRequestId + 1
	else
		CurrentRequestId = 0
	end
end

RegisterNetEvent('exp_carheist:serverCallback')
AddEventHandler('exp_carheist:serverCallback', function(requestId, ...)
	ServerCallbacks[requestId](...)
	ServerCallbacks[requestId] = nil
end)

function GetVehiclesInArea(coords, maxDistance)
	return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end

	return nearbyEntities
end

function GetVehicles()
	return GetGamePool('CVehicle')
end

local Blips = {}
function SetBlip(pName, pId, pCoords, pSprite, pColor, pScale)
	if Blips[pId] then
		RemoveBlip(Blips[pId])
	end
	Blips[pId] = AddBlipForCoord(pCoords.x, pCoords.y, pCoords.z)

	SetBlipSprite (Blips[pId], pSprite)
	SetBlipDisplay(Blips[pId], 4)
	SetBlipColour(Blips[pId], pColor)
	SetBlipScale  (Blips[pId], pScale or 1.0)
	SetBlipAsShortRange(Blips[pId], true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(pName)
	EndTextCommandSetBlipName(Blips[pId])
    return Blips[pId]
end

function SetPedAnim(ped, dict, anim, time, flag)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Wait(10)
        end
        TaskPlayAnim(ped, dict, anim, 8.0, -8.0, time, flag or 49, 1, false, false, false)
    end
end

function DeleteBlip(blip_id)
	RemoveBlip(Blips[blip_id])
end

function SpawnNPC(model, position, heading)
	model = GetHashKey(model)
	RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
	local npc = CreatePed(4, model, position, heading, false, true)
	-- SetEntityHeading(npc, heading)
	return npc
end

function IsSpawnPointClear(coords)
	return #EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, 1.0) == 0
end