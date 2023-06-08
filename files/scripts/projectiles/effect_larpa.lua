-- Get entity IDs
local entity_id = GetUpdatedEntityID()
local victim = EntityGetRootEntity(entity_id)

-- Prevent cloning of bosses and wandghosts; debating wether leggy should be allowed; is this any easier than other kinds of perk farming? I doubt it
local valid = true
local disallowed = {
    "boss", "miniboss", "necrobot_NOT", "wand_ghost"
}
for i = 1, #disallowed do
    if EntityHasTag(victim, disallowed[i]) then
        valid = false
        EntityKill(entity_id)
        break
    end
end

-- Clone logic
if valid then
    local x, y = EntityGetTransform(victim)

    -- Create the clone itself
    if EntityHasTag(victim, "player_unit") then
        -- Todo: make "distorted" player, loses hp over time and runs around kicking stuff before dying
        -- Hey spoop, conga, whichever of you ends up reading this, I really can't make enemies, but if you want to help out,
        -- I've been thinking about making it summon a 'distorted' player clone who's like a mere imitation of the real player,
        -- Acting as a mindless follower or something: I can't animate at all and enemy making still eludes me, so some help would be appreciated
        -- https://imgur.com/a/YzMTrrd
    else
        local path = EntityGetFilename(victim)
        if path:match("data/") or path:match("mods/") then
            local clone = EntityLoad(path, x + math.random(15, -15), y + math.random(5, 10))
            EntityAddTag(clone, "necrobot_NOT") -- anti clonedupe, find better approach
            EntityAddComponent2(clone, "VariableStorageComponent", {
                _tags = "no_gold_drop",
                name = "is_cloned_entity"
            })
        end
    end

    -- Cosmetic particle spray: todo, actual PEC entity for better gfx
    ---@diagnostic disable-next-line: undefined-global
    GameCreateCosmeticParticle("spark_purple", x, y, 64, 100, 100, 0, 1, 1, true, true, true, true)

    -- Damage to deter infinite cloning, and maybe make it a part of some niche funny damage wand idk it makes more enemies at full HP might make it clone effects and HP too
    local dmcs = EntityGetComponentIncludingDisabled(victim, "DamageModelComponent") or {}
    EntityInflictDamage(
        victim,
        (function(comps) local sum = 0 local num = #comps for i = 1, num do sum = sum + ComponentGetValue2(comps[i], "max_hp") end return sum / num end)(dmcs) / 10,
        "DAMAGE_CURSE",
        "Cloning Trauma",
        "BLOOD_EXPLOSION",
        0, 0,
        victim
    )
end