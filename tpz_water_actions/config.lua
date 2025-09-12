Config = {}

--[[-------------------------------------------------------
 Prompts
]]---------------------------------------------------------

Config.PromptKeys = {
  
  [1] = {
    Type  = "WASH",
    Label = 'Wash',
    Key   = 0x760A9C6F,
  },

  [2] = {

    Type  = "DRINK",
    Label = 'Drink',
    Key   = 0xC7B5340A,
  },

}

--[[-------------------------------------------------------
 General Settings
]]---------------------------------------------------------

-- tpz_metabolism
-- How much thirst should be added on the player when drinking from water?
Config.AddDrinkThirstValue = 10

-- When drinking from a water source.
Config.ChanceToBeDamaged = { Chance = 70, HealthDamage = 100}

-- The specified command can be used to hide or show the water prompts.
Config.ToggleRiverActions = {
  Command      = 'toggleriver',
  DisabledText = "~e~River actions have been disabled.",
  EnabledText  = "~t6~River actions have been enabled.",
}

-- TP Dirt System (PAID Script support).
Config.tp_dirtsystem = {
  Enabled = true,

  WaterTypes = {

    ['river'] = 2500, -- <- DECREASING DIRT LEVEL (CLEANING).
    ['lake']  = 2500, -- <- DECREASING DIRT LEVEL (CLEANING).
    ['swamp'] = 2500, -- <- INCREASING DIRT LEVEL (BECOMING DIRTIER).
  },

}

--[[-------------------------------------------------------
  Water Types
]]---------------------------------------------------------

Config.WaterTypes = {
    [-247856387]  = "lake",
    [-1504425495] = "river",
    [-1369817450] = "lake",
    [-1356490953] = "lake",
    [-1781130443] = "river",
    [-1300497193] = "river",
    [-1276586360] = "river",
    [-1410384421] = "river",
    [370072007]   = "river",
    [650214731]   = "river",
    [592454541]   = "lake",
    [-804804953]  = "lake",
    [1245451421]  = "river",
    [-218679770]  = "river",
    [-1817904483] = "lake",
    [-811730579]  = "lake",
    [-1229593481] = "river",
    [-105598602]  = "lake",
    [1755369577]  = "swamp",
    [-557290573]  = "swamp",
    [-2040708515] = "river",
    [231313522]   = "river",
    [2005774838]  = "river",
    [-1287619521] = "river",
    [-1308233316] = "river",
    [-196675805]  = "river",
}
