local effect_id = GetUpdatedEntityID()
local victim_id = EntityGetRootEntity(effect_id)
if victim_id == effect_id then EntityKill(effect_id) return end
if not EntityGetFirstComponent(victim_id, "ControlsComponent") then EntityKill(effect_id) return end
local genomecomp = EntityGetFirstComponent(victim_id, "GenomeDataComponent")
if genomecomp then
    local animalaicomp = EntityGetFirstComponent(victim_id, "AnimalAIComponent")
    if animalaicomp then
        local x, y = EntityGetTransform(victim_id)
        local detect_x = ComponentGetValue2(animalaicomp, "creature_detection_range_x")
        local detect_y = ComponentGetValue2(animalaicomp, "creature_detection_range_y")
        ComponentSetValue2(animalaicomp, "mGreatestThreat", 0)
        ComponentSetValue2(animalaicomp, "mGreatestPrey", 0)
        ComponentSetValue2(animalaicomp, "mHasBeenAttackedByPlayer", false)
        ComponentSetValue2(animalaicomp, "mHasNoticedPlayer", false)
        ComponentSetValue2(animalaicomp, "sense_creatures", false)
        ComponentSetValue2(animalaicomp, "mLastFrameJumped", 0)
        ComponentSetValue2(animalaicomp, "ai_state", 12)
        ComponentSetValue2(animalaicomp, "creature_detection_range_x", detect_x/50)
        ComponentSetValue2(animalaicomp, "creature_detection_range_y", detect_y/50)
        EntityLoad("mods/copis_things/files/entities/particles/pain_burst.xml", x, y)
        EntitySetComponentsWithTagEnabled(effect_id, "disabled_at_start", true)
    end
end