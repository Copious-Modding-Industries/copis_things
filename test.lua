do
    local projectile = nil
    for extra_entity in string.gmatch(c.extra_entities, '([^,]+)') do
        local new_entity = EntityLoad(extra_entity)
        EntityAddChild(projectile, new_entity)
    end
end


do
    local action = function()
        local projectile = "mods/copis_things/files/entities/projectiles/dart.xml"
        if not reflecting then
            local caster = GetUpdatedEntityID()
            local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent")
            if controls_component ~= nil then
                -- Check if  began shooting THIS FRAME
                local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire")
                if GameGetFrameNum() == shooting_start then
                    -- Add the projectile
                    add_projectile(projectile)
                end
            end
        else
            -- Reflection data
            Reflection_RegisterProjectile(projectile)
        end
    end
    action()
end
