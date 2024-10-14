-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Monkey = {}
Tunnel.bindInterface("pumpkin", Monkey)
vCLIENT = Tunnel.getInterface("pumpkin")

local pumpkinCooldowns = {}

local selectedFunctions = Functions["Functions"][Functions["Framework"]]

RegisterNetEvent("Pumpkin:Collect")
AddEventHandler("Pumpkin:Collect", function()
    local source = source
    local Passport = selectedFunctions[1](source)

    local cooldownTime = 100 
    local currentTime = os.time()
    local playerCoords = GetEntityCoords(GetPlayerPed(source))

    for _, Coords in ipairs(Pumpkin["Coords"]) do
        local pumpkinId = string.format("%.2f,%.2f,%.2f,%s", Coords.x, Coords.y, Coords.z, tostring(Passport))
        local distance = #(playerCoords - vec3(Coords.x, Coords.y, Coords.z))

        if distance <= 2.0 then
            for _, cooldown in ipairs(pumpkinCooldowns) do
                if cooldown.playerSource == source and cooldown.pumpkinId == pumpkinId then
                    local timePassed = currentTime - cooldown.timeCollected
                    if timePassed < cooldownTime then
                        local remainingTime = cooldownTime - timePassed
                        TriggerClientEvent("Notify", source, "vermelho", "Você já coletou essa abóbora, volte em " .. remainingTime .. " segundos.", "Pumpkin Hunt", 5000)
                        return
                    end
                end
            end

            if Passport then
                local totalItemsToCollect = math.random(1, 3)
                local collectedItems = {}

                for i = 1, totalItemsToCollect do
                    local randomIndex = math.random(1, #Pumpkin["Prizes"])
                    local prize = Pumpkin["Prizes"][randomIndex]
                    local Valuation = math.random(1, 3)

                    if (selectedFunctions[2](Passport) + ItemWeight(prize) * Valuation) <= selectedFunctions[3](Passport) then
                        selectedFunctions[4](Passport, prize, Valuation, true)
                        table.insert(collectedItems, prize)
                    else
                        TriggerClientEvent("Notify", source, "amarelo", "Sua recompensa caiu no chão.", "Mochila Sobrecarregada", 5000)
                        exports["inventory"]:Drops(Passport, source, prize, Valuation)
                    end
                end

                table.insert(pumpkinCooldowns, { playerSource = source, pumpkinId = pumpkinId, timeCollected = currentTime })

                if #collectedItems > 0 then
                    TriggerClientEvent("Notify", source, "azul", "Você coletou: " .. table.concat(collectedItems, ", ") .. " na Pumpkin Hunt.", "Pumpkin Hunt", 5000)
                end

                return
            end
        end
    end

    TriggerClientEvent("Notify", source, "vermelho", "Você precisa estar mais perto de uma abóbora.", "Pumpkin Hunt", 5000)
end)