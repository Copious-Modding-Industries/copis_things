dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()
local projectile = EntityGetFirstComponentIncludingDisabled( GetUpdatedEntityID(), "ProjectileComponent" );
if projectile ~= nil then
    local shooter = ComponentGetValue2( projectile, "mWhoShot" ) or 0;
    self.var_int.copis_things_shooter = shooter
end