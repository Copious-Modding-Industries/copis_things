dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice", "holy"}
if ( comp ~= nil ) then
    ComponentSetValue2( comp, "damage", 0.0 )
    for _, type in ipairs(damage_types) do
        ComponentObjectSetValue2(comp, "damage_by_type", type, 0.0)
    end
end