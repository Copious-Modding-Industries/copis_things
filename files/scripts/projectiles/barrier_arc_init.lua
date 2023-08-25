local entity_id = GetUpdatedEntityID()
if not EntityHasTag(entity_id, "CASTSTATE_SHARED") then EntityAddTag(entity_id, "CASTSTATE_SHARED") end