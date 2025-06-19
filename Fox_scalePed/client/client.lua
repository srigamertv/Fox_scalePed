local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPscale = {}
Tunnel.bindInterface("Fox_scalePed", vRPscale)

local isScaling = false
local currentScale = 1.0
local DEFAULT_PED_HEIGHT = 1.0
local lastAdjustedZ = nil

function norm(vec)
    local mag = math.sqrt(vec.x ^ 2 + vec.y ^ 2 + vec.z ^ 2)
    if mag > 0 then
        return vec / mag
    end
    return vec
end

function vRPscale.applyScaleToEntity(ped, scale)
    local forward, right, upVector, position = GetEntityMatrix(ped)

    local forwardNorm = norm(forward) * scale
    local rightNorm = norm(right) * scale
    local upNorm = norm(upVector) * scale

    local zOffset = (1.0 - scale) * DEFAULT_PED_HEIGHT * 0.5
    local speed = GetEntitySpeed(ped)
    local adjustedZ

    if speed > 0.1 then
        adjustedZ = position.z - zOffset * 2
        lastAdjustedZ = adjustedZ
    else
        if lastAdjustedZ then
            adjustedZ = lastAdjustedZ
        else
            adjustedZ = position.z - zOffset * 2
            lastAdjustedZ = adjustedZ
        end
    end

    SetEntityMatrix(ped,
        forwardNorm.x, forwardNorm.y, forwardNorm.z,
        rightNorm.x, rightNorm.y, rightNorm.z,
        upNorm.x, upNorm.y, upNorm.z,
        position.x, position.y, adjustedZ
    )
end

function vRPscale.startScale(targetScale)
    isScaling = true
    lastAdjustedZ = nil

    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then return end

    local initialScale = currentScale
    local duration = 1000
    local startTime = GetGameTimer()

    CreateThread(function()
        while isScaling and GetGameTimer() - startTime < duration do
            local now = GetGameTimer()
            local progress = (now - startTime) / duration
            local scale = initialScale + (targetScale - initialScale) * progress

            currentScale = scale

            if DoesEntityExist(ped) then
                vRPscale.applyScaleToEntity(ped, scale)
            end

            Wait(0)
        end

        currentScale = targetScale
        if DoesEntityExist(ped) then
            vRPscale.applyScaleToEntity(ped, targetScale)
        end

        while isScaling do
            if DoesEntityExist(ped) then
                vRPscale.applyScaleToEntity(ped, targetScale)
            end
            Wait(0)
        end
    end)
end

function vRPscale.stopScale()
    isScaling = false
    currentScale = 1.0
    lastAdjustedZ = nil
end

-- COMANDOS
RegisterCommand("gigante", function()
    vRPscale.stopScale()
    Wait(2000)
    vRPscale.startScale(Config.scaleGigante)
    print("Modo gigante ativado.")
end)

RegisterCommand("pequeno", function()
    vRPscale.stopScale()
    Wait(2000)
    vRPscale.startScale(Config.scalePequeno)
    print("Modo pequeno ativado.")
end)

RegisterCommand("normal", function()
    vRPscale.stopScale()
    print("Você voltou ao tamanho padrão.")
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    vRPscale.stopScale()
end)

RegisterNetEvent("um-ped-scale:applyScale")
AddEventHandler("um-ped-scale:applyScale", function(scale)
    vRPscale.stopScale()
    Wait(2000)  
    vRPscale.startScale(scale)
end)

RegisterNetEvent("um-ped-scale:stopScale")
AddEventHandler("um-ped-scale:stopScale", function()
    vRPscale.stopScale()
end)