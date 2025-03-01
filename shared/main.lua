-- Configurações do Pumpkin Hunt
Pumpkin = {}

-- Configuração do sistema de sazonal / Halloween / Vallantines / Pascoa / Natal 
Pumpkin["Sazonal"] = "Halloween"

-- Habilita ou desabilita o modo de debug
Pumpkin["Debug"] = true

-- Número máximo de abóboras normais que podem ser spawnadas
Pumpkin["MaxPumpkins"] = 10

-- Número máximo de abóboras raras que podem ser spawnadas durante eventos especiais
Pumpkin["MaxRarePumpkins"] = 3

-- Lista de modelos de abóboras e espantalhos
Pumpkin["Pumpkins"] = {
    "ayc_hpumpkin", "ayc_hscarecrow", "reh_Prop_REH_Lantern_PK_01a", "reh_Prop_REH_Lantern_PK_01b", "reh_Prop_REH_Lantern_PK_01c"
}

-- Lista de locais de spawn das abóboras
Pumpkin["SpawnLocations"] = {
    { x = 926.17, y = -856.77, z = 43.54, w = 306.15 },
    { x = 896.55, y = -827.76, z = 43.44, w = 147.41 },
    { x = 201.3, y = -985.51, z = 29.28, w = 294.81 },
    { x = 51.87, y = -1043.73, z = 29.59, w = 187.09 },
    { x = 73.52, y = -960.51, z = 29.81, w = 113.39 },
    { x = 57.57, y = -877.08, z = 30.4, w = 255.12 },
    { x = 102.69, y = -1074.21, z = 29.18, w = 257.96 },
    { x = 231.64, y = -1103.52, z = 29.28, w = 141.74 },
    { x = 75.61, y = -195.32, z = 54.49, w = 257.96 },
    { x = -1687.35, y = 26.67, z = 64.45, w = 331.66 },
    { x = -618.01, y = -1208.82, z = 14.07, w = 331.66 },
    { x = 963.35, y = -1033.91, z = 40.83, w = 269.3 },
    { x = 458.18, y = -1911.49, z = 25.12, w = 187.09 },
    { x = 83.16, y = -1401.16, z = 29.42, w = 294.81 },
    { x = 410.27, y = -1621.26, z = 29.28, w = 226.78 },
    { x = 470.87, y = -1278.42, z = 29.54, w = 272.13 },
    { x = 341.21, y = -1297.09, z = 32.5, w = 158.75 },
    { x = 246.24, y = -824.43, z = 29.91, w = 161.58 },
    { x = 75.64, y = -1020.69, z = 29.47, w = 246.62 }
}

-- Lista de prêmios com suas raridades
Pumpkin["Prizes"] = {
    { name = "donut", rarity = "common" },
    { name = "marshmallow", rarity = "common" },
    { name = "cookies", rarity = "common" },
    { name = "strawberry", rarity = "common" },
    { name = "energetic", rarity = "common" },
    { name = "pumpkin_pie", rarity = "uncommon" },
    { name = "candy_corn", rarity = "uncommon" },
    { name = "chocolate_bar", rarity = "uncommon" },
    { name = "halloween_mask", rarity = "rare" },
    { name = "golden_pumpkin", rarity = "legendary" }
}