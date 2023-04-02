-- Disable unwanted actions
for i = 1, #actions do
    local action = actions[i]
    if not ModSettingGet("CopisThings.spelltoggle" .. action.id) then

        local replacement =  {
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
                
            end
        }

		action.spawn_level = "0"
		action.spawn_probability = "0"
        action.action = function ()
            -- Kill action
            if not reflecting then
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                local shooter = GetUpdatedEntityID()
                local inventory2comp = EntityGetFirstComponent(shooter, "Inventory2Component")
                if inventory2comp then
                    local active_wand = ComponentGetValue2(inventory2comp, "mActiveItem")
                    local wand = EZWand(active_wand)
                    if wand ~= nil then
                        wand:RemoveSpells(action.id)
                        if not HasFlagPersistent("copis_things_sus_secret") then
                            RemoveFlagPersistent("action_copis_things_sus_trail")
                        end
                    end
                end
            end
        end

    end
end