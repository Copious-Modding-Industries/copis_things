function add_projectile_repeating_trigger_timer( entity_filename, delay_frames, times, action_draw_count )
	if reflecting then
		Reflection_RegisterProjectile( entity_filename )
		return
	end

	local n = times
	local firerate = delay_frames

	GamePrint("Deck: " .. tostring(n))
	GamePrint("CD: " .. tostring(firerate))

	BeginProjectile( entity_filename )
		if (n > 0) then
			for i=1,n,1 do
				BeginTriggerTimer( firerate*i )
					c.speed_multiplier = math.max(c.speed_multiplier, 10)
					draw_shot( create_shot( 1 ), true )
				EndTrigger()
			end
		end
	EndProjectile()
	c.lifetime_add = c.lifetime_add + (n * firerate)
end

--[[
function draw_shot( shot, instant_reload_if_empty )
	local c_old = c

	c = shot.state

	shot_structure = {}
	draw_actions( shot.num_of_cards_to_draw, instant_reload_if_empty )
	register_action( shot.state )
	SetProjectileConfigs()

	c = c_old
end

function create_shot( num_of_cards_to_draw )
	local shot = { }
	shot.state = { }
	reset_modifiers( shot.state )
	shot.num_of_cards_to_draw = num_of_cards_to_draw
	return shot
end

function reset_modifiers( state )
	ConfigGunActionInfo_Init( state )
end

function draw_actions( how_many, instant_reload_if_empty )
	if ( dont_draw_actions == false ) then
		c.action_draw_many_count = how_many
		if playing_permanent_card and (how_many == 1) then
			return -- SPECIAL RULE: modifiers that use draw_actions(1) to draw one more action don't result in two actions being drawn after them if the modifier is permanently attached and wand 'casts 1'
		end

		for i = 1, how_many do
			local ok = draw_action( instant_reload_if_empty )
			if ok == false then
				-- attempt to draw other actions
				while #deck > 0 do
					if draw_action( instant_reload_if_empty ) then
						break
					end
				end
			end

			if reloading then
				return
			end
		end
	end
end

function draw_action( instant_reload_if_empty )
	local action = nil

	state_cards_drawn = state_cards_drawn + 1

	if reflecting then  return  end


	if ( #deck <= 0 ) then
		if instant_reload_if_empty and ( force_stop_draws == false ) then
			move_discarded_to_deck()
			order_deck()
			start_reload = true
		else
			reloading = true
			return true -- <------------------------------------------ RETURNS
		end
	end

	if #deck > 0 then
		-- draw from the start of the deck
		action = deck[ 1 ]

		table.remove( deck, 1 )
		
		-- update mana
		local action_mana_required = action.mana
		if action.mana == nil then
			action_mana_required = ACTION_MANA_DRAIN_DEFAULT
		end

		if action_mana_required > mana then
			OnNotEnoughManaForAction()
			table.insert( discarded, action )
			return false -- <------------------------------------------ RETURNS
		end

		if action.uses_remaining == 0 then
			table.insert( discarded, action )
			return false -- <------------------------------------------ RETURNS
		end

		mana = mana - action_mana_required
	end

	--- add the action to hand and execute it ---
	if action ~= nil then
		play_action( action )
	end

	return true
end

function play_action( action )
	OnActionPlayed( action.id )

	table.insert( hand, action )

	set_current_action( action )
	action.action()

	local is_projectile = false

	if action.type == ACTION_TYPE_PROJECTILE then
		is_projectile = true
		got_projectiles = true
	end

	if  action.type == ACTION_TYPE_STATIC_PROJECTILE then
		is_projectile = true
		got_projectiles = true
	end

	if action.type == ACTION_TYPE_MATERIAL then
		is_projectile = true
		got_projectiles = true
	end

	if is_projectile then
		for i,modifier in ipairs(active_extra_modifiers) do
			extra_modifiers[modifier]()
		end
	end

	current_reload_time = current_reload_time + ACTION_DRAW_RELOAD_TIME_INCREASE
end

function set_current_action( action )
	c.action_id                	 = action.id
	c.action_name              	 = action.name
	c.action_description       	 = action.description
	c.action_sprite_filename   	 = action.sprite
	c.action_type              	 = action.type
	c.action_recursive           = action.recursive
	c.action_spawn_level       	 = action.spawn_level
	c.action_spawn_probability 	 = action.spawn_probability
	c.action_spawn_requires_flag = action.spawn_requires_flag
	c.action_spawn_manual_unlock = action.spawn_manual_unlock or false
	c.action_max_uses          	 = action.max_uses
	c.custom_xml_file          	 = action.custom_xml_file
	c.action_ai_never_uses		 = action.ai_never_uses or false
	c.action_never_unlimited	 = action.never_unlimited or false

	c.action_is_dangerous_blast  = action.is_dangerous_blast

	c.sound_loop_tag = action.sound_loop_tag

	c.action_mana_drain = action.mana
	if action.mana == nil then
		c.action_mana_drain = ACTION_MANA_DRAIN_DEFAULT
	end

	c.action_unidentified_sprite_filename = action.sprite_unidentified
	if action.sprite_unidentified == nil then
		c.action_unidentified_sprite_filename = ACTION_UNIDENTIFIED_SPRITE_DEFAULT
	end

	current_action = action
end
]]--
















































--[[


function draw_shot( shot, instant_reload_if_empty )
	local c_old = c

	c = shot.state

	shot_structure = {}

	if ( dont_draw_actions == false ) then
		c.action_draw_many_count = how_many
		if playing_permanent_card and (how_many == 1) then
			return -- SPECIAL RULE: modifiers that use draw_actions(1) to draw one more action don't result in two actions being drawn after them if the modifier is permanently attached and wand 'casts 1'
		end

		for i = 1, shot.num_of_cards_to_draw do
			local ok = draw_action( instant_reload_if_empty )
			if ok == false then
				-- attempt to draw other actions
				while #deck > 0 do
					if draw_action( instant_reload_if_empty ) then
						break
					end
				end
			end

			if reloading then
				return
			end
		end
	end


	register_action( shot.state )
	SetProjectileConfigs()

	c = c_old
end
















]]