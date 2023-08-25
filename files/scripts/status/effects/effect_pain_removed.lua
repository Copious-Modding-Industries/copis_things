local effect_id = GetUpdatedEntityID()
local victim_id = EntityGetRootEntity(effect_id)
if victim_id == effect_id then EntityKill(effect_id) return end
local animalaicomp = EntityGetFirstComponent(victim_id, "AnimalAIComponent")
if animalaicomp then
    local x, y = EntityGetTransform(victim_id)
    local detect_x = ComponentGetValue2(animalaicomp, "creature_detection_range_x")
    local detect_y = ComponentGetValue2(animalaicomp, "creature_detection_range_y")
    ComponentSetValue2(animalaicomp, "creature_detection_range_x", detect_x*50)
    ComponentSetValue2(animalaicomp, "creature_detection_range_y", detect_y*50)
    ComponentSetValue2(animalaicomp, "sense_creatures", true)
    EntityLoad("mods/copis_things/files/entities/particles/pain_burst_expire.xml", x, y)
end