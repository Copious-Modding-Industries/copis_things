dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
local final_damage = 0
local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice"}
if ( comp ~= nil ) then

    local damage = ComponentGetValue2( comp, "damage" )
    final_damage = final_damage + damage * 0.5
    ComponentSetValue2( comp, "damage", 0.0 )

    for _, type in ipairs(damage_types) do
        local type_damage = ComponentObjectGetValue2(comp, "damage_by_type", type)
        final_damage = final_damage + type_damage * 0.5
        ComponentObjectSetValue2(comp, "damage_by_type", type, 0.0)
    end

    ComponentObjectSetValue2(comp, "damage_by_type", "healing", final_damage * -1)
end