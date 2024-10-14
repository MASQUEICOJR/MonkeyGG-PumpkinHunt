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

Functions = {}

Functions["Framework"] = "Rework" -- vRPex, Network, Rework

Functions["Functions"] = {
    ["Rework"] = {
        function(source)
            return vRP.Passport(source)
        end,
        function(Passport)
            return vRP.InventoryWeight(Passport)          
        end,
        function(Passport)
            return vRP.GetWeight(Passport)
        end,
        function(Passport, prize, Valuation, bol)
            return vRP.GenerateItem(Passport, prize, Valuation, bol)
        end,
    },
    ["Network"] = {
        function(source)
            return vRP.passport(source)
        end,
        function(Passport)
            return vRP.inventoryWeight(Passport)          
        end,
        function(Passport)
            return vRP.getWeight(Passport)
        end,
        function(Passport, prize, Valuation, bol)
            return vRP.generateItem(Passport, prize, Valuation, bol)
        end,
    },
    ["vRPex"] = {
        function(source)
            return vRP.getUserId(source)
        end,
        function(Passport)
            return vRP.getInventoryItemWeight(Passport)  
        end,
        function(Passport)
            return vRP.getWeight(Passport)
        end,
        function(Passport, prize, Valuation, bol)
            return vRP.giveInventoryItem(Passport, prize, Valuation, bol)
        end,
    }
}
