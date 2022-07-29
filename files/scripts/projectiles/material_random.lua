dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/copis_things/files/scripts/projectiles/material_random_materials.lua")
local entity = GetUpdatedEntityID();

local rnd = random_create(9123,58925+GameGetFrameNum() )
local mat = tostring(pick_random_from_table_weighted( rnd, options )[1])
local children = EntityGetAllChildren( entity ) or {};

for _,particle_emitter in pairs( EntityGetComponent( entity, "ParticleEmitterComponent" ) or {} ) do
    ComponentSetValue2(particle_emitter, "emitted_material_name", mat)
end
for _,material_spawner in pairs( EntityGetComponent( entity, "MaterialSeaSpawnerComponent" ) or {} ) do
    ComponentSetValue2(material_spawner, "material", CellFactory_GetType(mat))
end
for _,projectile in pairs( EntityGetComponent( entity, "ProjectileComponent" ) or {} ) do
    ComponentSetValue2(projectile, "on_death_emit_particle_type", mat)
    ComponentObjectSetValue2(projectile, "config_explosion", "create_cell_material", mat)
end
for _,magic_convert_material in pairs( EntityGetComponent( entity, "MagicConvertMaterialComponent" ) or {} ) do
    ComponentSetValue2(magic_convert_material, "to_material", CellFactory_GetType(mat))
end

for _,child in pairs(children) do
    for _,particle_emitter in pairs( EntityGetComponent( child, "ParticleEmitterComponent" ) or {} ) do
        ComponentSetValue2(particle_emitter, "emitted_material_name", mat)
    end
end