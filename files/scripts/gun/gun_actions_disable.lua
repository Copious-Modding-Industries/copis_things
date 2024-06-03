-- Disable unwanted actions
for i = 1, #actions do
    local action = actions[i]
    if not ModSettingGet("CopisThings.spelltoggle" .. action.id) then
        actions[i] = {
            disabled = true,
            id = action.id,
            name = action.name,
            description = "This content is disabled via Copi's Things.",
            sprite = action.sprite,
            type = action.type,
            spawn_level = "0",
            spawn_probability = "0",
            spawn_requires_flag = "this_should_never_spawn",
            price = 0,
            mana = 0,
            action = function()
                ---@diagnostic disable-next-line: undefined-global
                if reflecting then return end
				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				EntityKill(this_card)
				print(table.concat { "[COPIS THINGS]: ACTION ", action.id, " WHICH IS DISABLED HAS BEEN CASTED!" })
            end
        }
    end
end