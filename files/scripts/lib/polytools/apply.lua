dofile_once("[POLYTOOLS_PATH]disco_util/disco_util.lua")
local self = Entity.Current()

local x, y = self:transform()
local parent = self:parent()
if not parent then return end

local is_player = false

-- Destroy all components from the polymorph sheep to make room for the new creature
local keep_comps = {ControlsComponent = true, FogOfWarRadiusComponent = true}
local comps = parent:allComponents()
if comps then
    for k, v in comps:ipairs() do
        local name = v:type()
        if name == "GameStatsComponent" then
            is_player = v.is_player
            v.extra_death_msg = ", while polymorphed"
        elseif not keep_comps[name] then
            v:remove()
        end
    end
end

-- Load in the new creature over the sheep
local polytarget = self.GameEffectComponent.polymorph_target

parent:loadComponents(polytarget, true, true, true)
local add_components = self.var_str.add_components
if add_components and add_components ~= "" then
    -- Scripts applying this effect can point to an xml with extra components to add (eg new attacks)
    parent:loadComponents(add_components, true)
end

-- All parts below are for player controls, so don't do them for enemies
if not is_player then return end

-- Turn off all AI components to prevent interference with the player controls
local animal_ai = parent.AnimalAIComponent
if animal_ai then for k, v in animal_ai:ipairs() do v:setEnabled(false) end end

local dragon = parent.BossDragonComponent
if dragon then
    -- Special handling for the dragon
    parent:addComponent("WormAIComponent", {})
    parent:addComponent("WormComponent",
                        {speed = dragon.speed, acceleration = dragon.acceleration,
                         gravity = dragon.gravity, tail_gravity = dragon.tail_gravity,
                         part_distance = dragon.part_distance,
                         ground_check_offset = dragon.ground_check_offset,
                         hitbox_radius = dragon.hitbox_radius, bite_damage = dragon.bite_damage,
                         target_kill_radius = dragon.target_kill_radius,
                         target_kill_ragdoll_force = dragon.target_kill_ragdoll_force,
                         jump_cam_shake = dragon.jump_cam_shake,
                         jump_cam_shake_distance = dragon.jump_cam_shake_distance,
                         eat_anim_wait_mult = dragon.eat_anim_wait_mult,
                         ragdoll_filename = dragon.ragdoll_filename})
    -- Add some dummy attack components for the wand to scrape
    parent:addComponent("AIAttackComponent",
                        {attack_ranged_entity_file = "data/entities/projectiles/bossdragon.xml",
                         frames_between = 1})
    parent:addComponent("AIAttackComponent",
                        {attack_ranged_entity_file = "data/entities/projectiles/bossdragon_ray.xml",
                         frames_between = 0})
    dragon:setEnabled(false)
end

local keep_ui = self.var_bool.keep_ui
local worm_ai = parent.WormAIComponent
if worm_ai then
    -- Turn off the worm AI and add a worm player controller
    for k, v in worm_ai:ipairs() do v:setEnabled(false) end
    parent:addComponent("WormPlayerComponent", {_enabled = true})

    if keep_ui then
        -- Kill components so the game doesn't crash when they player components are added
        parent:removeComponents({"CameraBoundComponent", "CharacterCollisionComponent",
                                 "ControlsComponent", "ItemPickUpperComponent", "ItemChestComponent"})

        -- Parts to enable the health bar and inventory
        parent:loadComponents("[POLYTOOLS_PATH]ui/player_base_worm.xml", true)
    end
    local wormvision = parent:addGameEffect("data/entities/misc/effect_nightvision.xml")
    wormvision.GameEffectComponent.frames = -1
else
    if keep_ui then
        -- Kill components so the game doesn't crash when they player components are added
        parent:removeComponents({"CameraBoundComponent", "CharacterDataComponent",
                                 "CharacterPlatformingComponent", "CharacterCollisionComponent",
                                 "ControlsComponent", "ItemPickUpperComponent",
                                 "ItemChestComponent", "PlayerCollisionComponent"})
        -- Add components to make controls more player-like
        parent:loadComponents("[POLYTOOLS_PATH]ui/player_base.xml", true)

    end
end

-- Make sure the camera can follow the player
if not parent.PlatformShooterPlayerComponent then
    parent:loadComponents("[POLYTOOLS_PATH]ui/player_base_hide.xml", true)
end

for k, v in parent.ControlsComponent:ipairs() do v.polymorph_hax = false end

if parent.DamageModelComponent then
    -- Add script to pass health/gold pickups to the player
    self.var_float.maxhp_start = parent.DamageModelComponent.max_hp
    self:addComponent("LuaComponent",
                      {script_source_file = "[POLYTOOLS_PATH]ui/on_remove.lua",
                       execute_on_removed = true, execute_every_n_frame = -1})
end
if self.var_bool.end_on_death then
    print("adding death script")
    parent:addComponent("LuaComponent", {execute_every_n_frame = -1,
                                         script_damage_received = "[POLYTOOLS_PATH]depoly_death.lua"})
end
