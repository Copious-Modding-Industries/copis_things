local projectile = nil
for extra_entity in string.gmatch(c.extra_entities, '([^,]+)') do
    local new_entity = EntityLoad(extra_entity)
    EntityAddChild(projectile, new_entity)
end