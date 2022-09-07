dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
local wand = self:parent()
local shooter = self:root()

if GameGetFrameNum() >= self.var_int.cooldown_frame then     -- run if cooldown is over

    local kicked = false
    local shooter_controls = shooter.ControlsComponent
    if shooter_controls ~= nil and shooter_controls.mButtonFrameKick == GameGetFrameNum() then      -- run if kicked this frame
        kicked = true
        self.var_int.cooldown_frame = GameGetFrameNum() + 12       -- add cooldown
    end

    local entity_id = GetUpdatedEntityID()
    local controls_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
    if controls_comp ~= nil then

        local velocity = shooter.CharacterDataComponent.mVelocity
        if velocity then
            local aim_vec = shooter.ControlsComponent.mAimingVectorNormalized
            aim_vec.x = aim_vec.x * 32
            aim_vec.y = aim_vec.y * 32

            local force = {
                x = 650,
                y = 1000,
            }

            local len = math.sqrt((aim_vec.x ^ 2) + (aim_vec.y ^ 2))
            velocity.x = velocity.x + (aim_vec.x / len * force.x)
            velocity.y = velocity.y + (aim_vec.y / len * force.y)

            shooter.CharacterDataComponent.mVelocity = velocity
        end
    end
end
