dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()
SetRandomSeed(GetUpdatedComponentID(), GameGetFrameNum())
if self.ProjectileComponent then
    self.ProjectileComponent.lifetime = self.ProjectileComponent.lifetime * (Random(2, 40)/10)
end