dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()
SetRandomSeed(GetUpdatedComponentID(), GameGetFrameNum())
self.var_int.copis_things_spawn_frame = GameGetFrameNum()
if self.VelocityComponent ~= nil then
    self.VelocityComponent.mVelocity.air_friction = math.random() * -2 - 1.5
    self.VelocityComponent.mVelocity.terminal_velocity = 500
    self.VelocityComponent.mVelocity.apply_terminal_velocity = true
end
