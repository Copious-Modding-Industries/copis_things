
dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

function shot( shot_entity )
    local self = Entity.Current()
    local shot = shot_entity.wrap()
    local force_shooter = nil
    if self ~= nil then
        force_shooter = self.var_int.copis_things_shooter
    end
    if shot.ProjectileComponent then

        shot.ProjectileComponent.explosion_dont_damage_shooter = true
        shot.ProjectileComponent.friendly_fire = false
        shot.ProjectileComponent.config_explosion.dont_damage_this = force_shooter
        for _, component in shot:allComponents():ipairs() do
            if component:type() == "AreaDamageComponent" then
                if EntityHasTag( force_shooter, "player_unit" ) then
                    component.entities_with_tag = "enemy"
                else
                    component.entities_with_tag = "player_unit"
                end
            end
        end
        if shot.LightningComponent then
            shot.LightningComponent.config_explosion.dont_damage_this = force_shooter
        end

        shot:addComponent("LuaComponent", {
            execute_on_added=true,
            script_shot = "mods/copis_things/files/scripts/projectiles/ult_protection_init.lua",
        })
    end
end
