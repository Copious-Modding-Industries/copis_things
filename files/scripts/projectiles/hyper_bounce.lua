dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()
if self.ProjectileComponent ~= nil then
    self.ProjectileComponent.bounce_energy = math.max( 1.10, self.ProjectileComponent.bounce_energy + 0.10 )
    self.ProjectileComponent.bounce_at_any_angle = true
end
