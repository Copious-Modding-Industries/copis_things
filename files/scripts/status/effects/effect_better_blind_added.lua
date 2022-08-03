dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
local target = self:root()
if target:id() == self:id() then return end

local ai = target.AnimalAIComponent
if ai then
    ai.creature_detection_range_x = ai.creature_detection_range_x / 20
    ai.creature_detection_range_y = ai.creature_detection_range_y / 20
    ai.mGreatestThreat = 0
    ai.mGreatestPrey = 0
end
