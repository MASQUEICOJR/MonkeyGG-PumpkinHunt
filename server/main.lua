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

local prizeRarities = {
    common = 70,
    uncommon = 20,
    rare = 8,
    legendary = 2
}

local function getRandomPrize()
    local totalWeight = 0
    for _, prize in ipairs(Pumpkin["Prizes"]) do
        totalWeight = totalWeight + prizeRarities[prize.rarity]
    end

    local randomNumber = math.random(1, totalWeight)
    local currentWeight = 0

    for _, prize in ipairs(Pumpkin["Prizes"]) do
        currentWeight = currentWeight + prizeRarities[prize.rarity]
        if randomNumber <= currentWeight then
            return prize.name
        end
    end
end

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
                    local prize = getRandomPrize()
                    local Valuation = math.random(1, 3)
                    local 

                    if (selectedFunctions[2](Passport) + ItemWeight(prize) * Valuation) <= selectedFunctions[3](Passport) then

                        local animDict = "anim@scripted@player@freemode@tun_prep_ig1_grab_low@heeled@"
                        local animName = "grab_low"

                        TaskPlayAnim(source, animDict, animName, 8.0, -8.0, -1, 49, 0, false, false, false)

                        Wait(500)

                        ClearPedTasks(source)

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
