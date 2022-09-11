dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
local shooter = self.var_int.copis_things_shooter
local x, y, a, sx, sy = self:transform()
local entities = EntityGetInRadiusWithTag(x, y, 52, "hittable")
for _, entity in ipairs(entities) do
    local damage_models = EntityGetComponent( entity, "DamageModelComponent" );
    local max_hp = 0
    if damage_models ~= nil then
        for index,damage_model in pairs( damage_models ) do
            local current_hp = ComponentGetValue2( damage_model, "hp" );
            max_hp = ComponentGetValue2( damage_model, "max_hp" );
            ComponentSetValue2( damage_model, "max_hp", math.max(max_hp - max_hp / 20, 0.04));
        end
    end
    EntityAddRandomStains(entity, CellFactory_GetType("poison"), 100)
    EntityInflictDamage(entity, math.max(max_hp/20, 5), "DAMAGE_MATERIAL", "terror", "BLOOD_EXPLOSION", 0, 0, shooter)
end