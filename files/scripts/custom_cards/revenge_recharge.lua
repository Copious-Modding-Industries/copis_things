-- oh my fucking fuck fucking bloody hell I cant deal with this
-- in nolla's esoteric infinite wisdom they made the most incomprehensible parent child relationships ever
-- adopted son twice removed would be less confusing than whatever the hell nolla has made
-- I swear wtf if you have a gameffect crap like on brimstone and its not directly a child of the entity then half the fucking time (BUT NOT ALWAYS! CONSISTENCY IS A SIN.)
--- the game shits itself and hjust
-- fuickging dies auuuuuuuuugggggggghhhhhhhhhhhhhhhhh
-- why doesnt this shit run aaaaaaaaaaaaaaaaaaa
-- abandon all hope ye who enter here, I have given up (for now)
-- Why the hell does damage received script not run if it's parent > inv > wand > spell (here)
-- shouldnt it just care if root or someone higher on the heiarchy gets hurt or something
-- how tf am I supposed to detect >0 damage :(((((((((
    -- fuck this im going to bed

        -- (ps nolla if you read this I love your game and stuff I'm not mad just dissapointed (not really I just shouldn't be coding when I'm this tired))

---@diagnostic disable-next-line: lowercase-global
function damage_received( damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible )
    if damage > 0 then
        -- test print
        print("THIS IS TRULY MY METAL GEAR RISING REVENGEANCE")
        local card = GetUpdatedEntityID()
        local wand = EntityGetParent(card)
        local abilitycomp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent") --[[@cast abilitycomp number]]
        local vscs = EntityGetComponentIncludingDisabled(card, "VariableStorageComponent") or {}
        for i=1, #vscs do
            local vsc = vscs[i]
            if ComponentGetValue2(vsc, "name") == "cooldown_frame" then
                local now = GameGetFrameNum()
                if ComponentGetValue2(vsc, "value_int") <= now then
                    ComponentSetValue2(abilitycomp, "mReloadNextFrameUsable", now)
                    ComponentSetValue2(abilitycomp, "mReloadFramesLeft", 0)
                    ComponentSetValue2(abilitycomp, "mNextFrameUsable", now)
                    ComponentSetValue2(vsc, "value_int", now + 30)
                end
                break
            end
        end
    end
end