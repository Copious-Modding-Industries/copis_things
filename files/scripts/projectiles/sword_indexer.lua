local separator = GetUpdatedEntityID()
local caststate = nil
local shooter = nil
do  -- Get cast state
    local projcomp = EntityGetFirstComponentIncludingDisabled(separator, "ProjectileComponent")
    local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
    shooter = ComponentGetValue2( projcomp, "mWhoShot" );
    local i, j = string.find(desc, "\nCASTSTATE|([a-zA-Z0-9]*)")
    caststate = (string.sub(desc, i, j))
end

-- Get player projectiles
local player_projectiles = EntityGetWithTag("projectile_player") or {}
local sword_projectiles = {}

-- Add sword projectiles to list
for index = 1, #player_projectiles do
    local target = player_projectiles[index]
    if EntityHasTag(target, "SWORD_FORMATION") then
        local projcomp = EntityGetFirstComponentIncludingDisabled(target, "ProjectileComponent")
        local desc = ComponentObjectGetValue2(projcomp, "config", "action_description")
        local i, j = string.find(desc, "\nCASTSTATE|([a-zA-Z0-9]*)")
        local target_caststate = (string.sub(desc, i, j))
        if target_caststate == caststate then
            sword_projectiles[#sword_projectiles+1] = target
        end
    end
end

-- Sort by order fired
table.sort( player_projectiles, function( a, b ) return a < b; end )

-- Add comps
for index = 1, #sword_projectiles do
    local target = sword_projectiles[index]
    EntityAddComponent(target, "VariableStorageComponent", {
        _tags = "SWORD_DATA",
        value_float = index,  -- "Position"
        value_int = shooter  -- "Leader"
    })
    EntityAddComponent(target, "LuaComponent", {
        script_source_file="mods/copis_things/files/scripts/projectiles/sword_transformer.lua",
        execute_every_n_frame=1
    })
end

EntityKill(separator)