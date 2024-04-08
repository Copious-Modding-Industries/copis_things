--- ### Adds a component to an entity file.
--- ***
--- @param file_path string The path to the file you wish to add a component to.
--- @param comp string The component you wish to add.
function ModEntityFileAddComponent(file_path, comp)
    local file_contents = ModTextFileGetContent(file_path)
    local contents = file_contents:gsub("</Entity>$", function() return comp .. "</Entity>" end)
    ModTextFileSetContent(file_path, contents)
end

--[=[ Charges don't work
-- Black Hole
ModEntityFileAddComponent("data/entities/misc/custom_cards/black_hole.xml", [[
	<SpriteComponent
		_tags="enabled_in_hand,not_enabled_in_wand"
		_enabled="0"
		offset_x="3.5"
		offset_y="6"
		image_file="mods/copis_things/files/items_gfx/in_hand/black_hole.xml"
		next_rect_animation="default"
		rect_animation="default"
	/>
	<AbilityComponent
		_tags="enabled_in_hand"
		ui_name="$action_black_hole"
		entity_file="data/entities/projectiles/deck/black_hole.xml"
		rotate_hand_amount="0.75"
		throw_as_item="1"
		simulate_throw_as_item="1"
		use_entity_file_as_projectile_info_proxy="1"
		>
			<gun_config
				deck_capacity="0"
			/>
	</AbilityComponent>
]])
]=]

--[=[ Charges don't work
-- Dark Flame
ModEntityFileAddComponent("data/entities/misc/custom_cards/darkflame.xml", [[
	<SpriteComponent
		_tags="enabled_in_hand,not_enabled_in_wand"
		_enabled="0"
		offset_x="6" 
		offset_y="6" 
		rect_animation="spawn" 
		image_file="data/projectiles_gfx/darkflame.xml"
	/>
	<AbilityComponent
		_tags="enabled_in_hand"
		entity_file="data/entities/projectiles/darkflame.xml"
		rotate_hand_amount="0.75"
		throw_as_item="1"
		ui_name="$action_dark_flame"
		simulate_throw_as_item="1"
		use_entity_file_as_projectile_info_proxy="1"
		>
			<gun_config
				deck_capacity="0"
			/>
	</AbilityComponent>
]])
]=]

-- Conc Light
ModEntityFileAddComponent("data/entities/misc/custom_cards/laser.xml", [[
	<ParticleEmitterComponent 
		_tags="enabled_in_hand"
		emitted_material_name="plasma_fading_green"
		offset.x="0"
		offset.y="0"
		gravity.y="0.0"
		x_vel_min="0"
		x_vel_max="0"
		y_vel_min="-2"
		y_vel_max="2"
		count_min="1"
		count_max="2"
		trail_gap="0.5"
		fade_based_on_lifetime="1"
		attractor_force="1"
		lifetime_min="0.05"
		lifetime_max="0.4"
		emit_real_particles="0"
		render_on_grid="1"
		emit_cosmetic_particles="1"
		emission_interval_min_frames="1"
		emission_interval_max_frames="2"
		is_emitting="1"
	/>
	<AbilityComponent
		_tags="enabled_in_hand"
		entity_file="data/entities/projectiles/deck/laser.xml"
		rotate_hand_amount="0.75"
		ui_name="$action_laser"
		throw_as_item="1"
		simulate_throw_as_item="1"
		use_entity_file_as_projectile_info_proxy="1"
		>
			<gun_config
				deck_capacity="0"
			/>
	</AbilityComponent>
]])