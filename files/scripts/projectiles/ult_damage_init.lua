dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", "holy"}
if ( comp ~= nil ) then

    local damage = ComponentGetValue2( comp, "damage" )
    ComponentSetValue2( comp, "damage", damage * 5 )

    for _, type in ipairs(damage_types) do
        local type_damage = ComponentObjectGetValue2(comp, "damage_by_type", type)
        ComponentObjectSetValue2(comp, "damage_by_type", type, type_damage * 5)
    end
end