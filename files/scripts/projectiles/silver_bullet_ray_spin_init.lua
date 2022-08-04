dofile_once("data/scripts/lib/utilities.lua")
local entity = GetUpdatedEntityID();
local comp = EntityGetFirstComponent( entity, "VariableStorageComponent", "init_angle" );

SetRandomSeed(GameGetFrameNum(), entity)
local angle = Random() * math.pi * 2;

if comp ~= nil then
    ComponentSetValue2( comp, "value_int", angle);
end