local to_insert = {
    {
        id                = "DEV",
        name              = "Dev",
        description       = "cast state data",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 0,
        ai_never_uses     = true,
        action            = function(recursion_level, iteration)
            if not reflecting then
                print("[COPI'S THINGS CAST STATE PRINT START]")
                for k,v in pairs(c) do
                    print(k.." = "..tostring(v));
                end
                print("[COPI'S THINGS CAST STATE PRINT END]")
            end
        end,
    },

    {
        id                = "SWORD_MAGIC",
        name              = "Mage's Razor of Cunning",
        description       = "A series of techniques developed around magical adaptation",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 0,
        ai_never_uses     = true,
        action            = function(recursion_level, iteration)
            if not reflecting then
                local entity_id = GetUpdatedEntityID()
                local controls_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
                if controls_comp ~= nil then
                    local keys = {
                        left   = ComponentGetValue2(controls_comp, "mButtonDownLeft"),
                        right  = ComponentGetValue2(controls_comp, "mButtonDownRight"),
                        up     = ComponentGetValue2(controls_comp, "mButtonDownUp"),
                        down   = ComponentGetValue2(controls_comp, "mButtonDownDown"),
                        kick   = ComponentGetValue2(controls_comp, "mButtonDownKick"),
                        rmb    = ComponentGetValue2(controls_comp, "mButtonDownRightClick"),
                    }

                    local attack = nil

                    if keys.up then
                        attack = "upstab"
                        if keys.left then
                            attack = "upleftslash"
                        elseif keys.right then
                            attack = "uprightslash"
                        end
                    end
                    if keys.down then attack = "downstab" end

                end
            end
        end,
    },
}

for _, value in ipairs(to_insert) do
    if (value.author == nil) then
        value.author = "Copi"
    end
    value.id = "COPIS_THINGS_" .. value.id
    table.insert(actions, value)
end