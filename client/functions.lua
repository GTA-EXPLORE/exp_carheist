---@param str string
---@return string
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

---@param model number Model Hash
function _RequestModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(50) end
end

function DoesPedHaveAnyBag(ped)
    return GetPedDrawableVariation(ped, 5) > 0
end

---@param data table
function AddEntityMenuItem(data)
    if GetResourceState("exp_target_menu") == "started" then
        exports.exp_target_menu:AddEntityMenuItem({
            entity = data.entity,
            event = data.event,
            name = data.name,
            desc = data.desc
        })
    end

    if GetResourceState("ox_target") == "started" then
        exports.ox_target:addLocalEntity(data.entity, {
            label = data.desc,
            event = data.event,
            distance = 1.5
          })
    end

    if GetResourceState("qb-target") == "started" then
        exports["qb-target"]:AddTargetEntity(data.entity, {
            options = {
                {
                    label = data.desc,
                    event = data.event,
                }
            },
            distance = 1.5
        })
    end
end

---@param center vector3
---@param radius number
---@return vector3
function GetRandomPositionInCircle(center, radius)
    local angle = math.rad(math.random(0, 360))
    local offsetX = (math.max(0.5, math.random()) * radius) * math.cos(angle)
    local offsetY = (math.max(0.5, math.random()) * radius) * math.sin(angle)

    local randomPosition = vector3(center.x + offsetX, center.y + offsetY, center.z)
    return randomPosition
end