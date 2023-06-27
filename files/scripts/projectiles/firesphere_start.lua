local entity_id = GetUpdatedEntityID()
EntityAddComponent2(entity_id, "VariableStorageComponent", {name="starting_frame", value_int=GameGetFrameNum()})
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local fire = ComponentObjectGetValue2(projcomp, "damage_by_type", "fire")
local dmg = ComponentGetValue2(projcomp, "damage")
ComponentObjectSetValue2(projcomp, "damage_by_type", "ice", 0)  -- fuk off ice damage
ComponentObjectSetValue2(projcomp, "damage_by_type", "fire", fire+dmg/2)
ComponentSetValue2(projcomp, "damage", dmg/2)