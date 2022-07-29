dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once("[POLYTOOLS_PATH]disco_util/disco_util.lua")

local wand = Entity.Current()

local wandac = wand.AbilityComponent
wandac.ui_name = "Natural Attacks"
wandac.mana_max = 0
wandac.mana = 0
wandac.mana_charge_speed = 0

wandac.gun_config.deck_capacity = 1
wandac.gun_config.actions_per_round = 1
wandac.gun_config.shuffle_deck_when_empty = false
wandac.gun_config.reload_time = 0

wandac.gunaction_config.fire_rate_wait = 0
wandac.gunaction_config.spread_degrees = 0
wandac.gunaction_config.speed_multiplier = 1

function GetProjectileSprite(path, sprite)
    local proj = Entity(EntityLoad(path, 0, 0))
    local proj_sprite = proj.SpriteComponent
    if proj_sprite then
        sprite.alpha = proj_sprite.alpha
        sprite.image_file = proj_sprite.image_file
        sprite.next_rect_animation = proj_sprite.next_rect_animation
        sprite.rect_animation = proj_sprite.rect_animation
        sprite.additive = proj_sprite.additive
    end
    proj.ProjectileComponent.on_death_explode = false
    proj:kill()
end

local owner = wand:root()
if not owner then
    print_error("no owner -- can't add natural attacks")
    return
end
local attacks = {}
if owner.AIAttackComponent then
    for k, v in owner.AIAttackComponent:ipairs() do
        local action = Entity(CreateItemActionEntity("AZOTH_WRITABLE"))
        if action then
            action:setParent(wand)
            action:setEnabledWithTag("enabled_in_world", false)

            action.var_str.projectile = v.attack_ranged_entity_file
            action.var_int.fire_rate_wait = v.frames_between
            action.var_int.multishot_min = v.attack_ranged_entity_count_min
            action.var_int.multishot_max = v.attack_ranged_entity_count_max

            local mysprite = action:componentsWithTag("SpriteComponent", "item_identified")
            GetProjectileSprite(v.attack_ranged_entity_file, mysprite)
            action.ItemComponent.ui_sprite = mysprite.image_file

            action.ItemComponent.always_use_item_name_in_ui = true
            action.ItemComponent.item_name = "Natural Attack"
            action.ItemComponent.is_frozen = true
            table.insert(attacks, action)
        end
    end
elseif owner.AnimalAIComponent then
    for k, v in owner.AnimalAIComponent:ipairs() do
        if v.attack_ranged_enabled and v.attack_ranged_entity_file ~= "" then
            local action = Entity(CreateItemActionEntity("AZOTH_WRITABLE"))
            if action then
                action:setParent(wand)
                action:setEnabledWithTag("enabled_in_world", false)

                action.var_str.projectile = v.attack_ranged_entity_file
                action.var_int.fire_rate_wait = v.attack_ranged_frames_between
                action.var_int.multishot_min = v.attack_ranged_entity_count_min
                action.var_int.multishot_max = v.attack_ranged_entity_count_max

                local mysprite = action:componentsWithTag("SpriteComponent", "item_identified")
                GetProjectileSprite(v.attack_ranged_entity_file, mysprite)
                action.ItemComponent.ui_sprite = mysprite.image_file

                action.ItemComponent.always_use_item_name_in_ui = true
                action.ItemComponent.item_name = "Natural Attack"
                action.ItemComponent.is_frozen = true
                table.insert(attacks, action)
            end
        end
    end
end

if #attacks == 0 then
    wand:kill()
else
    wand.ItemComponent.item_name = "Natural Attacks"
    wand.ItemComponent.always_use_item_name_in_ui = true
    wandac.gun_config.deck_capacity = #attacks
    wandac.sprite_file = attacks[1].ItemComponent.ui_sprite
    owner.Inventory2Component.mActualActiveItem = 0
end
