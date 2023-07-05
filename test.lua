
---@diagnostic disable shuts up diagnostics here




EffectIDs = EffectIDs or (function()
    local effect_ids = {}
    dofile("data/scripts/status_effects/status_list.lua")
    for sindex = 1, #status_effects do
        effect_ids[status_effects[sindex].id] = sindex
    end
    return effect_ids
end)()

local player = EntityGetWithTag("player_unit")[1]
local sedc = EntityGetFirstComponent(player, "StatusEffectDataComponent") --[[@cast sedc number]]
local ingestion = ComponentGetValue2(sedc, "ingestion_effects")