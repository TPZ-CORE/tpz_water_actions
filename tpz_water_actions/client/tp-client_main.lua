
local TPZ = exports.tpz_core:getCoreAPI()

local IS_PLAYER_FISHING = false
local HAS_TOGGLE_ACTIVE = true
local IS_PLAYER_BUSY    = false

--[[-------------------------------------------------------
 Events
]]---------------------------------------------------------

RegisterNetEvent("tpz_water_actions:setFishingState")
AddEventHandler("tpz_water_actions:setFishingState", function(cb)
    IS_PLAYER_FISHING = cb
end)

--[[-------------------------------------------------------
 Local Functions
]]---------------------------------------------------------

local StartWash = function(dict, anim, waterType)
    
    local playerPed = PlayerPedId()

    IS_PLAYER_BUSY = true

    TPZ.PlayAnimation(playerPed, { 
        dict = dict, 
        name = anim,
        blendInSpeed = 1.0,
        blendOutSpeed = 8.0,
        duration = 7000,
        flag = 0,
        playbackRate = 0.0
    })

    Citizen.Wait(7000)
    ClearPedTasks(playerPed)

    ClearPedEnvDirt(playerPed)
    ClearPedBloodDamage(playerPed)
    N_0xe3144b932dfdff65(playerPed, 0.0, -1, 1, 1)
    ClearPedDamageDecalByZone(playerPed, 10, "ALL")
    Citizen.InvokeNative(0x7F5D88333EE8A86F, playerPed, 1)

    ClearPedWetness(playerPed)

    if waterType == 'river' or waterType == 'lake' then
        
        -- todo (action when washing on a river or a lake)

        if Config.tp_dirtsystem.Enabled then 
            exports.tp_dirtsystem:AddPlayerDirtLevel(Config.tp_dirtsystem.WaterTypes[waterType])
        end

    elseif waterType == 'swamp' then

        -- todo (action when washing on a swamp (dirty water) )

        if Config.tp_dirtsystem.Enabled then 
            local current = exports.tp_dirtsystem:GetDirtLevel()
            exports.tp_dirtsystem:SetPlayerDirtLevel(Config.tp_dirtsystem.WaterTypes['swamp'])
        end

    end

    IS_PLAYER_BUSY = false
end


--[[-------------------------------------------------------
 Threads
]]---------------------------------------------------------

Citizen.CreateThread(function()
    RegisterRiverPrompts()

    while true do

        local playerPed = PlayerPedId()
        local isDead    = IsEntityDead(playerPed)
        local coords    = GetEntityCoords(playerPed)
        local Water     = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)

        local sleep     = 1000

        if IS_PLAYER_FISHING or not HAS_TOGGLE_ACTIVE or isDead or not IsPedOnFoot(playerPed) or not IsEntityInWater(playerPed) or IsPedSwimming(playerPed) or IsPedSwimmingUnderWater(playerPed) then
            goto END
        end

        if Config.WaterTypes[Water] then
            sleep = 0

            local promptGroup, promptList = GetPromptData()

            local label = CreateVarString(10, 'LITERAL_STRING', '')
            PromptSetActiveGroupThisFrame(promptGroup, label)

            for i, prompt in pairs (promptList) do

                if PromptHasHoldModeCompleted(prompt.prompt) then
                    
                    ClearPedTasksImmediately(playerPed)
                    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true, 0, false, false)
      
                    if prompt.type == 'WASH' then

                        local dict, anim = "amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d", "idle_l"

                        if IsPedMale(playerPed) == 0 then
                            dict, anim = "amb_misc@world_human_wash_face_bucket@ground@female_a@idle_d", "idle_l"
                        end

                        StartWash(dict, anim, Config.WaterTypes[Water])

                    elseif prompt.type == 'DRINK' then

                        IS_PLAYER_BUSY = true

                        local dict = "amb_rest_drunk@world_human_bucket_drink@ground@male_a@idle_a"
                        local anim = "idle_a"

                        if IsPedMale(playerPed) == 0 then
                            dict, anim = "amb_rest_drunk@world_human_bucket_drink_ladle@ground@female_b@idle_a", "idle_c"
                        end

                        TaskStandStill(playerPed, -1)
      
                        TPZ.PlayAnimation(PlayerPedId(), { 
                            dict = dict, 
                            name = anim,
                            blendInSpeed = 1.0,
                            blendOutSpeed = 8.0,
                            duration = -1,
                            flag = 1,
                            playbackRate = 0.0
                        })
                            
                        Wait(10000)
                        StopAnimTask(playerPed, dict, anim, 1.0)

                        TaskStandStill(playerPed, 1)
                        PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)

                        TriggerEvent("tpz_metabolism:setMetabolismValue", 'THIRST', 'add', Config.AddDrinkThirstValue)

                        local random = math.random(1, 99)

                        if random <= Config.ChanceToBeDamaged.Chance then

                            PlayPain(playerPed, 9, 1, true, true)

                            local health  = GetEntityHealth(playerPed)
                            local removedHealthValue = health - Config.ChanceToBeDamaged.HealthDamage

                            SetEntityHealth(playerPed, removedHealthValue)

                        end

                    end

                    Wait(2000)

                end

            end

        end

        ::END::
        Wait(sleep)
    end
end)

--[[-------------------------------------------------------
 Commands
]]---------------------------------------------------------

RegisterCommand(Config.ToggleRiverActions.Command, function(source, args, rawCommand)
    HAS_TOGGLE_ACTIVE = not HAS_TOGGLE_ACTIVE

    if not HAS_TOGGLE_ACTIVE then

        TriggerEvent('tpz_core:sendBottomTipNotification', Config.ToggleRiverActions.DisabledText, 3000)
    else
        TriggerEvent('tpz_core:sendBottomTipNotification', Config.ToggleRiverActions.EnabledText, 3000)
    end

end, false)