function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function loadPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Citizen.Wait(50)
	end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

DrawScreenText = function(text, scale, posX, posY, color)
	SetTextFont(0)
	SetTextScale(scale, scale)
    SetTextDropShadow(0, 0, 0, 0, 0)
	SetTextColour(color[1], color[2], color[3], 255)
	BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(posX, posY)
end

SecondsToClock = function(seconds)
	seconds = tonumber(seconds)
	if seconds <= 0 then
		return "00:00"
	else
		local mins = string.format("%02.f", math.floor(seconds / 60))
		local secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end


function _TaskVehicleDriveToCoord(ped, vehicle, x, y, z, speed, p6, vehicleModel, drivingMode, stopRange, p10)
    TaskVehicleDriveToCoord(ped, vehicle, x, y, z, speed, p6, vehicleModel, drivingMode, stopRange, p10)

    while GetScriptTaskStatus(ped, 0x93A5526E) ~= 7 do
        Wait(0)
    end

    return true
end

function DoesPedHaveAnyBag(ped)
    return GetPedDrawableVariation(ped, 5) > 0
end