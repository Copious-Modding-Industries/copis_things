dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()

if self.ProjectileComponent then
    local shooter = self.ProjectileComponent.mWhoShot
    self.var_int.copis_things_shooter = shooter

    self.ProjectileComponent.explosion_dont_damage_shooter = true
    self.ProjectileComponent.friendly_fire = false
    self.ProjectileComponent.config_explosion.dont_damage_this = shooter
    for _, component in self:allComponents():ipairs() do
        if component:type() == "AreaDamageComponent" then
            if EntityHasTag( shooter, "player_unit" ) then
                component.entities_with_tag = "enemy"
            else
                component.entities_with_tag = "player_unit"
            end
        end
    end
    if self.LightningComponent then
        self.LightningComponent.config_explosion.dont_damage_this = shooter
    end

    self:addComponent("LuaComponent", {
        script_shot = "mods/copis_things/files/scripts/projectiles/ult_protection_init.lua",
    })
end