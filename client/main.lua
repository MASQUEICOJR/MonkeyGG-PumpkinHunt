-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------

Monkey = {}
Tunnel.bindInterface("pumpkin", Monkey)
vSERVER = Tunnel.getInterface("pumpkin")

local PumpkinSpawned = {}
local PumpkinTargeted = {}

local animDict = "anim@scripted@player@freemode@tun_prep_ig1_grab_low@heeled@"
RequestAnimDict(animDict)
while not HasAnimDictLoaded(animDict) do
    RequestAnimDict(animDict)
    Wait(50)
end

CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)

        for i, pumpkinCoords in ipairs(Pumpkin["Coords"]) do
            local Distance = #(Coords - vec3(pumpkinCoords.x, pumpkinCoords.y, pumpkinCoords.z))

            if Distance <= 50.0 then
                if not PumpkinSpawned[i] then
                    local PumpkinModelIndex = (i - 1) % #Pumpkin["Pumpkins"] + 1
                    local PumpkinModel = Pumpkin["Pumpkins"][PumpkinModelIndex]
                    local hash = GetHashKey(PumpkinModel)

                    RequestModel(hash)
                    while not HasModelLoaded(hash) do
                        Wait(10)
                    end

                    local x, y, z, heading = pumpkinCoords.x, pumpkinCoords.y, pumpkinCoords.z, pumpkinCoords.w
                    PumpkinSpawned[i] = CreateObject(hash, x, y, z - 1, true, true, false)
                    SetEntityHeading(PumpkinSpawned[i], heading)
                    FreezeEntityPosition(PumpkinSpawned[i], true)
                    SetModelAsNoLongerNeeded(hash)
                end
            else
                if PumpkinSpawned[i] then
                    if DoesEntityExist(PumpkinSpawned[i]) then
                        DeleteEntity(PumpkinSpawned[i])
                    end
                    PumpkinSpawned[i] = nil
                end
            end
        end

        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        local PlayerCoords = GetEntityCoords(Ped)

        for i, Coords in ipairs(Pumpkin["Coords"]) do
            local Distance = #(PlayerCoords - vec3(Coords.x, Coords.y, Coords.z))

            if Distance <= 50.0 then
                if not PumpkinTargeted[i] then
                    local x, y, z, heading = Coords.x, Coords.y, Coords.z, Coords.w
                    
                    exports["target"]:AddCircleZone("Pumpkin:Collect" .. i, vec3(x, y, z - 0.9), 0.5, {
                        name = "PumpkinNPC" .. i,
                        heading = heading
                    }, {
                        Distance = 1.75,
                        options = {
                            {
                                event = "Pumpkin:Collect",
                                label = "Coletar Travessuras",
                                tunnel = "proserver"
                            }
                        }
                    })

                    PumpkinTargeted[i] = true
                end
            else
                if PumpkinTargeted[i] then
                    exports["target"]:RemCircleZone("Pumpkin:Collect" .. i)
                    PumpkinTargeted[i] = false
                end
            end
        end

        Wait(1000)
    end
end)
