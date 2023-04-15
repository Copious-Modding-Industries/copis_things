dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
local wand = self:parent()
local shooter = self:root()

if GameGetFrameNum() >= self.var_int.cooldown_frame then     -- run if cooldown is over
    local shooter_controls = shooter.ControlsComponent
    if shooter_controls ~= nil and shooter_controls.mButtonDownRightClick == GameGetFrameNum() then

        if wand ~= nil then

            local ability_component = wand.AbilityComponent
            local mana = ability_component.mana
            if mana >= 5 then
                ability_component.mana = mana - 5

                local velocity = shooter.CharacterDataComponent.mVelocity
                if velocity then
                    local aim_vec = shooter.ControlsComponent.mAimingVectorNormalized
                    aim_vec.x = aim_vec.x * 32
                    aim_vec.y = aim_vec.y * 32

                    local force = {
                        x = 325,
                        y = 500,
                    }

                    local len = math.sqrt((aim_vec.x ^ 2) + (aim_vec.y ^ 2))
                    velocity.x = velocity.x + (aim_vec.x / len * force.x)
                    velocity.y = velocity.y + (aim_vec.y / len * force.y)

                    shooter.CharacterDataComponent.mVelocity = velocity
                end
            end
        end

        self.var_int.cooldown_frame = GameGetFrameNum() + 12
    end

end