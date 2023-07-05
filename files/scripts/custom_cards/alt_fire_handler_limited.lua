---Handles simple alt fire projectile firing
---@param card number the card ID
---@param projectile string the projectile to fire
---@param cooldown_frames integer the number of frames to wait
---@param vel_min number the minimum velocity
---@param vel_max number the maximum velocity
---@param mana_cost number the mana cost
function AltFireHandler(card, projectile, cooldown_frames, vel_min, vel_max, mana_cost)
    local wand = EntityGetParent(card)
    local shooter = EntityGetRootEntity(card)
    local vscs = EntityGetComponent(card, "VariableStorageComponent") or {}
    local cooldown = nil
    local vsc = nil
    for i = 1, #vscs do
        if ComponentGetValue2(vscs[i], "name") == "cooldown_frame" then
            cooldown = ComponentGetValue2(vscs[i], "value_int")
            vsc = vscs[i]
            break
        end
    end

    if not cooldown then return end
    local now = GameGetFrameNum()
    local abilitycomp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent") --[[@cast abilitycomp number]]
    local itemcomp = EntityGetFirstComponentIncludingDisabled(card, "ItemComponent") --[[@cast itemcomp number]]
    local controlscomp = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent") --[[@cast controlscomp number]]
    local x, y = EntityGetTransform(card)
    if now >= cooldown then
        if ComponentGetValue2(controlscomp, "mButtonFrameRightClick") == now then
            local mana = ComponentGetValue2(abilitycomp, "mana")
            local charges = ComponentGetValue2(itemcomp, "uses_remaining")
            if (mana >= mana_cost) then
                if charges > 0 then
                    -- Handle shoot dist
                    local dist_x, dist_y = 12, 0
                    local HotspotComponent = EntityGetFirstComponentIncludingDisabled(wand, "HotspotComponent", "shoot_pos")
                    if HotspotComponent then
                        local wand_x, wand_y, wand_r = EntityGetTransform(wand)
                        local ox, oy = ComponentGetValue2(HotspotComponent, "offset")
                        local tx = math.cos(wand_r) * ox - math.sin(wand_r) * oy
                        local ty = math.sin(wand_r) * ox + math.cos(wand_r) * oy
                        dist_x, dist_y = tx, ty
                    end

                    -- Handle Shooting
                    local aim_x, aim_y = ComponentGetValue2(controlscomp, "mAimingVectorNormalized")
                    local shoot_x, shoot_y = x + dist_x, y + dist_y
                    local projectile_id = EntityLoad(projectile, shoot_x, shoot_y)
                    local projcomp = EntityGetFirstComponent(projectile_id, "ProjectileComponent") --[[@cast projcomp number]]
                    local velcomp = EntityGetFirstComponent(projectile_id, "VelocityComponent") --[[@cast velcomp number]]
                    local genome = EntityGetFirstComponent(shooter, "GenomeDataComponent")
                    local herd_id = genome and ComponentGetValue2(genome, "herd_id") or -1
                    local velocity = math.random(vel_min, vel_max)
                    local vel_x, vel_y = aim_x * velocity, aim_y * velocity
                    GameShootProjectile(shooter, shoot_x, shoot_y, x + vel_x, y + vel_y, projectile_id, true)
                    ComponentSetValue2(projcomp, "mWhoShot", shooter)
                    ComponentSetValue2(projcomp, "mShooterHerdId", herd_id)
                    ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)

                    -- Handle Mana
                    ComponentSetValue2(abilitycomp, "mana", mana - mana_cost)
                    ComponentSetValue2(vsc, "value_int", now + cooldown_frames)
                    -- Handle Charges
                    local chance = 1
                    local shoteffectcomps = EntityGetComponent(shooter, "ShotEffectComponent", "perk_component") or {}
                    for i=1, #shoteffectcomps do
                        if ComponentGetValue2(shoteffectcomps[i], "extra_modifier") == "copis_things_spell_efficiency" then
                            chance = chance / 1.5
                        end
                    end
                    if math.random() < chance then
                        ComponentSetValue2(itemcomp, "uses_remaining", charges - 1)
                        --[[ Todo: summon a temp invis wand to deplete 1 charge of a real spell to simulate the effect
                        if charges == 1 then
                            -- This func is only available in the gun system, fucking hell. 
                            --ActionUsesRemainingChanged( ComponentGetValue2(itemcomp, "mItemUid"), 0 )
                        end]]
                    end
                end

            else
                --[[ weird jank, cant figure this out
                local invguicomp = EntityGetFirstComponentIncludingDisabled(shooter, "InventoryGuiComponent")
                if invguicomp then ComponentSetValue2(invguicomp, "mFrameShake_ManaBar", now) end
                ]]
                GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", x, y)
            end
        end
    end
end
return AltFireHandler