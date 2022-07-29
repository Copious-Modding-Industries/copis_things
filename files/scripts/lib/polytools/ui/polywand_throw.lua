function throw_item(from_x, from_y, to_x, to_y)
    -- Kill the wand to make sure it's never possible for the player to get it
    EntityKill(GetUpdatedEntityID())
end
