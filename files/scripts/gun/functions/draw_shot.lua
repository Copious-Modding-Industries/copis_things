local function draw_shot( shot, instant_reload_if_empty )
    -- ??? wtf it works I guess
    local call_end_cast = false
    if copi_state.new_cast == nil then

		if not reflecting then
			local inv2c = EntityGetFirstComponent(GetUpdatedEntityID(), "Inventory2Component") --[[@cast inv2c number]]
			local buffs = EntityGetAllChildren(GetUpdatedEntityID()) or {}
			for i=1, #buffs do
				if EntityGetName(buffs[i]) == "arcanum_axiom" then
					if EntityHasTag(GetUpdatedEntityID(), "player_unit") then AddFlagPersistent("action_copith_arcanum_axiom") end
					local vsc = EntityGetFirstComponent(buffs[i], "VariableStorageComponent") --[[@cast vsc number]]
					if not (EntityGetParent(ComponentGetValue2(vsc, "value_int")) == ComponentGetValue2(inv2c, "mActiveItem")) then
						_play_permanent_card(ComponentGetValue2(vsc, "value_string"))
					end
				end
			end
		end

        call_end_cast = true
        copi_state.new_cast = false
        local state = tonumber(GlobalsGetValue("GLOBAL_CAST_STATE", "0"))
        GlobalsSetValue("GLOBAL_CAST_STATE", tostring( state + 1))
    end

    if call_end_cast then
        copi_state.new_cast = nil
    end

    if copi_state.skip_config then
        local c_old = c
        c = shot.state
        shot_structure = {}
        draw_actions( shot.num_of_cards_to_draw, instant_reload_if_empty )
        register_action( shot.state )
        c = c_old
    else
        copi_state.old._draw_shot( shot, instant_reload_if_empty )
    end
end
return {draw_shot=draw_shot}