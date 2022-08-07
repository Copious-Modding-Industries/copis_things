dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()

if self.ProjectileComponent then
    self.ProjectileComponent.lifetime = -1
end
if self.LifetimeComponent then
    self.LifetimeComponent:remove()
end
