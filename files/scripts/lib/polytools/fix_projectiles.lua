dofile_once("[POLYTOOLS_PATH]disco_util/disco_util.lua")

local self = Entity.Current()
if self.ProjectileComponent then self.ProjectileComponent.on_death_explode = true end
