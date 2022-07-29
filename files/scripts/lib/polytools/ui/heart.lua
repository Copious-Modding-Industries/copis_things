dofile_once("[POLYTOOLS_PATH]disco_util/disco_util.lua")
dofile("data/scripts/game_helpers.lua")

function item_pickup(entity_item, entity_who_picked, name)
    local heart = Entity(entity_item)
    local picker = Entity(entity_who_picked)

    local max_hp_old = 0
    local max_hp = 0

    local x, y = EntityGetTransform(entity_item)

    local damagemodel = picker.DamageModelComponent
    if damagemodel then
        for i, damagemodel in damagemodel:ipairs() do
            max_hp_old = damagemodel.max_hp
            max_hp = max_hp_old + heart.var_float.health_value

            local max_hp_cap = damagemodel.max_hp_cap
            if max_hp_cap > 0 then max_hp = math.min(max_hp, max_hp_cap) end

            -- if( hp > max_hp ) then hp = max_hp end
            damagemodel.max_hp_old = max_hp_old
            damagemodel.max_hp = max_hp
            damagemodel.mLastMaxHpChangeFrame = GameGetFrameNum()
        end
    end

    EntityLoad("data/entities/particles/image_emitters/heart_effect.xml", x, y - 12)
    EntityLoad("data/entities/particles/heart_out.xml", x, y - 8)
    local description = GameTextGet("$logdesc_heart", tostring(math.floor(max_hp * 25)))
    if max_hp == max_hp_old then
        description = GameTextGet("$logdesc_heart_blocked", tostring(math.floor(max_hp * 25)))
    end

    GamePrintImportant("$log_heart", description)
    GameTriggerMusicCue("item")

    -- remove the item from the game
    EntityKill(entity_item)
end
