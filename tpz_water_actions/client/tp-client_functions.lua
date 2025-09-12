
local Prompts = GetRandomIntInRange(0, 0xffffff)
local PromptsList = {}

-----------------------------------------------------------
--[[ Prompts ]]--
-----------------------------------------------------------

function RegisterRiverPrompts()

    for index, tprompt in pairs (Config.PromptKeys) do

        local str      = tprompt.Label
        local keyPress = tprompt.Key
    
        local dPrompt = PromptRegisterBegin()
        PromptSetControlAction(dPrompt, keyPress)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(dPrompt, str)
        PromptSetEnabled(dPrompt, 1)
        PromptSetVisible(dPrompt, 1)
        PromptSetStandardMode(dPrompt, 1)
        PromptSetHoldMode(dPrompt, 1000)
        PromptSetGroup(dPrompt, Prompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C, dPrompt, true)
        PromptRegisterEnd(dPrompt)
    
        table.insert(PromptsList, {prompt = dPrompt, type = tprompt.Type})
    end

end

GetPromptData = function ()
    return Prompts, PromptsList
end
