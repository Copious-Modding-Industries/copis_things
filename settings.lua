dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.
local defaults = {
  -- these need to be set dynamically on first run based on resolution
  pos_x = 0.77224264144897, -- starts out as percentage of screen_width and height
  pos_y = 0.10784312354194,
  size_x = 11,
  size_y = 11,
  zoom = 1.5
}

local mod_id = "Copis_Things"
mod_settings_version = 1

-- This file can't access other files from this or other mods in all circumstances.
-- Settings will be automatically saved.
-- Settings don't have access unsafe lua APIs.

-- Use ModSettingGet() in the game to query settings.
-- For some settings (for example those that affect world generation) you might want to retain the current value until a certain point, even
-- if the player has changed the setting while playing.
-- To make it easy to define settings like that, each setting has a "scope" (e.g. MOD_SETTING_SCOPE_NEW_GAME) that will define when the changes
-- will actually become visible via ModSettingGet(). In the case of MOD_SETTING_SCOPE_NEW_GAME the value at the start of the run will be visible
-- until the player starts a new game.
-- ModSettingSetNextValue() will set the buffered value, that will later become visible via ModSettingGet(), unless the setting scope is MOD_SETTING_SCOPE_RUNTIME.

function mod_setting_slider_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local old_value = value
	--GuiSlider( gui:obj, id:int, x:number, y:number, text:string, value:number, value_min:number, value_max:number, value_default:number, value_display_multiplier:number, value_formatting:string, width:number ) -> new_value:number [This is not intended to be outside mod settings menu, and might bug elsewhere.]
	value = GuiSlider(gui, im_id, 0, 0, setting.ui_name, value, setting.value_min, setting.value_max, setting.value_default, setting.value_display_multiplier, math.floor(value * math.pow(10, setting.decimal_places)) / math.pow(10, setting.decimal_places), 200)
	mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
	if value ~= old_value then
		ModSettingSetNextValue(mod_setting_get_id(mod_id, setting), value, false)
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, old_value, value )
	end
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	ModSettingSet(mod_id .. ".ui_needs_update", true)
end

mod_settings =
{

	{
		category_id = "perks",
		ui_name = "Perks",
		settings =
		{
		},
	},
}







function adjust_setting_values(screen_width, screen_height)
	if not screen_width then
		local gui = GuiCreate()
		GuiStartFrame(gui)
		screen_width, screen_height = GuiGetScreenDimensions(gui)
	end
	for i, setting in ipairs(mod_settings) do
		if setting.id == "pos_x" then
			setting.value_max = screen_width
			setting.value_default = screen_width * defaults.pos_x
		elseif setting.id == "pos_y" then
			setting.value_max = screen_height
			setting.value_default = screen_height * defaults.pos_y
		end
	end
end

-- This function is called to ensure the correct setting values are visible to the game via ModSettingGet(). your mod's settings don't work if you don't have a function like this defined in settings.lua.
-- This function is called:
--		- when entering the mod settings menu (init_scope will be MOD_SETTINGS_SCOPE_ONLY_SET_DEFAULT)
-- 		- before mod initialization when starting a new game (init_scope will be MOD_SETTING_SCOPE_NEW_GAME)
--		- when entering the game after a restart (init_scope will be MOD_SETTING_SCOPE_RESTART)
--		- at the end of an update when mod settings have been changed via ModSettingsSetNextValue() and the game is unpaused (init_scope will be MOD_SETTINGS_SCOPE_RUNTIME)
function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
	adjust_setting_values()
	mod_settings_update( mod_id, mod_settings, init_scope )
end

-- This function should return the number of visible setting UI elements.
-- Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
-- If your mod changes the displayed settings dynamically, you might need to implement custom logic.
-- The value will be used to determine whether or not to display various UI elements that link to mod settings.
-- At the moment it is fine to simply return 0 or 1 in a custom implementation, but we don't guarantee that will be the case in the future.
-- This function is called every frame when in the settings menu.
function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui( gui, in_main_menu )
	new_screen_width, new_screen_height = GuiGetScreenDimensions(gui)
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end
