dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
local wand = self:parent()
local shooter = self:root()

if GameGetFrameNum() >= self.var_int.cooldown_frame then     -- run if cooldown is over

    local kicked = false
    local shooter_controls = shooter.ControlsComponent
    if shooter_controls ~= nil and shooter_controls.mButtonFrameKick == GameGetFrameNum() then      -- run if kicked this frame
        kicked = true
        self.var_int.cooldown_frame = GameGetFrameNum() + 5       -- add cooldown
    end

    local x, y = self:transform()
    local projectile_ids = EntityGetInRadiusWithTag(x, y, 32, "projectile" )
    for _,projectile_id in ipairs(projectile_ids) do
        GameCreateSpriteForXFrames( "data/particles/radar_wand_strong.png", EntityGetTransform(projectile_id) )     -- mark hittables
        if kicked then
            local projectile = Entity.Wrap(projectile_id)   -- set up
            if wand ~= nil then

                local ability_component = wand.AbilityComponent
                local mana = ability_component.mana

                if mana >= 5 then
                    ability_component.mana = mana - 5

                    local velocity = projectile.VelocityComponent.mVelocity
                    if velocity then    -- move projectile

                        local aim_vec = shooter.ControlsComponent.mAimingVectorNormalized
                        local angle = math.atan2( aim_vec.y, aim_vec.x );

                        local magnitude = math.max( math.sqrt( velocity.x * velocity.x + velocity.y * velocity.y ) * 1.5, 150 );
                        velocity.x = math.cos( angle ) * magnitude
                        velocity.y = math.sin( angle ) * magnitude

                        projectile.VelocityComponent.mVelocity = velocity
                        projectile.ProjectileComponent.friendly_fire = true
                        projectile.ProjectileComponent.mWhoShot = shooter:id()
                    end
                else
                    break
                end
            end
        end
    end
end
