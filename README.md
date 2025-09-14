# TPZ-CORE Water Actions

## Requirements

1. TPZ-Core: https://github.com/TPZ-CORE/tpz_core
2. TPZ-Characters: https://github.com/TPZ-CORE/tpz_characters

# Installation

1. When opening the zip file, open `tpz_water_actions-main` directory folder and inside there will be another directory folder which is called as `tpz_water_actions`, this directory folder is the one that should be exported to your resources (The folder which contains `fxmanifest.lua`).

2. Add `ensure tpz_water_actions` after the **REQUIREMENTS** in the resources.cfg or server.cfg, depends where your scripts are located.

## Development

- You can use and trigger the following event (Client Sided) in order to disable water action prompts when player is fishing.

```
-- @param state : Requires a boolean value (true / false). 
TriggerEvent("tpz_water_actions:setFishingState", state)
```
