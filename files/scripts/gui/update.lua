
if initialized == nil then initialized = false; end
if initialized == false then
    initialized = true;
    __loaded = {};
    print("[copi's things] setting up GUI");
    dofile_once( "mods/copis_things/files/scripts/lib/flags.lua");
    dofile_once( "mods/copis_things/files/scripts/lib/config.lua");
    dofile_once( "mods/copis_things/files/scripts/lib/helper.lua");
    local MISC = dofile_once( "mods/copis_things/files/scripts/lib/options.lua" );
    dofile_once( "mods/copis_things/files/scripts/lib/inventories.lua");
    dofile_once( "mods/copis_things/files/scripts/lib/mod_settings.lua");
    dofile_once( "data/scripts/lib/coroutines.lua" );
    dofile_once( "data/scripts/lib/utilities.lua" );

    local gui = gui or GuiCreate();
    local full_screen_width, full_screen_height = GuiGetScreenDimensions( gui );
    GuiStartFrame( gui );
    local screen_width, screen_height = GuiGetScreenDimensions( gui );

    local CONTENT = {};
    COPI_CONFIG.parse_content( false, true, CONTENT );
    local SETTINGS                      = COPI_CONFIG.SETTINGS;
    local OPTIONS                       = COPI_CONFIG.OPTIONS;
    local CONTENT_ACTIVATION_TYPE       = COPI_CONFIG.CONTENT_ACTIVATION_TYPE;
    local SCREEN = {
        Closed = 0,
        Info = 1,
        Options = 2,
        ContentSelection = 3,
        ContentTypeSelection = 4,
    }


    local z_index = -9000;
    local mod_settings_id = "copis_things";
    local gokiui = dofile_once( "mods/copis_things/files/scripts/lib/gokiui.lua" )( gui, 0, mod_settings_id, z_index );
    local next_id = gokiui.next_id;
    local reset_id = gokiui.reset_id;
    local iterate_settings = gokiui.iterate_settings;
    local refresh_settings = gokiui.refresh_settings;
    local do_custom_tooltip = gokiui.do_custom_tooltip;


    if setting_get( "version" ) == nil then
        local iterate_options = {};
        for k,v in pairs( OPTIONS ) do
            table.insert( iterate_options, v );
        end
        local i = 1;
        while i < #iterate_options do
            local v = iterate_options[i];
            if v.settings ~= nil then
                for _,vv in pairs( v.settings ) do table.insert( iterate_options, vv ); end
            else
                if v.key then
                    if HasFlagPersistent( v.key ) then
                        setting_set( v.key, true );
                    else
                        setting_set( v.key, false );
                    end
                    RemoveFlagPersistent( v.key )
                end
            end
            i = i + 1;
        end
        local enabled_by_default = { 
            perk = true, 
            action = true, 
            champion_type = true, 
            legendary_wand = true, 
            loadout = true, 
            pack = true
        };
        for k,v in pairs( CONTENT ) do
            if v.settings_key then
                if HasFlagPersistent( "gkbrkn_"..v.settings_key ) then
                    if v.enabled_by_default and enabled_by_default[v.type] == true then
                        setting_set( v.settings_key, false );
                    else
                        setting_set( v.settings_key, true );
                    end
                else
                    if v.enabled_by_default and enabled_by_default[v.type] == true then
                        setting_set( v.settings_key, true );
                    else
                        setting_set( v.settings_key, false );
                    end
                end
            end
        end
        refresh_settings();
        setting_set( "version", SETTINGS.Version );
    end

    local hidden = false;
    local hide_menu_frame = GameGetFrameNum() + 300;

    function do_gui()
        local can_show = false;
        if setting_get( FLAGS.ShowWhileInInventory ) == true or not GameIsInventoryOpen() then
            can_show = true;
        end
        reset_id();
        GuiStartFrame( gui );
        GuiIdPushString( gui, "gkbrkn_noita" );

        if setting_get( MISC.AutoHide.EnabledFlag ) == false or hidden == false then
            GuiZSet( gui, z_index );
            GuiOptionsAdd( gui, GUI_OPTION.NoPositionTween );
            screen_width, screen_height = GuiGetScreenDimensions( gui );
            gokiui.parse_mod_settings( OPTIONS, setting_get( FLAGS.DisableNewContent ) );
            if can_show then
                GuiLayoutBeginVertical( gui, 5, 16 );
                if is_panel_open then
                    gokiui.do_gui();
                    hide_menu_frame = GameGetFrameNum() + 300;
                    hidden = false;
                else
                    if hide_menu_frame - GameGetFrameNum() < 0 then
                        hidden = true;
                    end
                end
                GuiLayoutEnd( gui );
            end

            GuiLayoutBeginVertical( gui, 0, 0 );
                local mod_button_reservation = tonumber( GlobalsGetValue( "copi_mod_button_reservation", "0" ) );
                local current_button_reservation = tonumber( GlobalsGetValue( "mod_button_tr_current", "0" ) );
                if current_button_reservation > mod_button_reservation then
                    current_button_reservation = mod_button_reservation;
                elseif current_button_reservation < mod_button_reservation then
                    current_button_reservation = math.max( 0, mod_button_reservation + (current_button_reservation - mod_button_reservation ) );
                else
                    current_button_reservation = mod_button_reservation;
                end
                GlobalsSetValue( "mod_button_tr_current", tostring( current_button_reservation + 15 ) );

                local player = EntityGetWithTag( "player_unit" )[1];
                if player then
                    local platform_shooter_player = EntityGetFirstComponent( player, "PlatformShooterPlayerComponent" );
                    if platform_shooter_player then
                        local is_gamepad = ComponentGetValue2( platform_shooter_player, "mHasGamepadControlsPrev" );
                        if is_gamepad == true then
                            GuiOptionsAddForNextWidget( gui, GUI_OPTION.NonInteractive );
                            GuiOptionsAddForNextWidget( gui, GUI_OPTION.AlwaysClickable );
                        end
                    end
                end

                GuiOptionsAddForNextWidget( gui, GUI_OPTION.HandleDoubleClickAsClick );
                if GuiImageButton( gui, next_id(), screen_width - 14 - current_button_reservation, 2, "", "mods/copis_things/files/ui_gfx/gui/icon.png" ) then
                    GamePlaySound( "data/audio/Desktop/ui.bank", "ui/button_click", GameGetCameraPos() );
                    is_panel_open = not is_panel_open;
                end
                local width = GuiGetTextDimensions( gui, "Configure Copi's Things" );
                do_custom_tooltip( function()
                    GuiText( gui, 0, 0, "Configure Copi's Things" );
                    GuiColorSetForNextWidget( gui, 0.5, 0.5, 0.5, 1.0 );
                    GuiText( gui, 0, 0, SETTINGS.Version );
                end, -100, -width - 24, 10 );
            GuiLayoutEnd( gui );
            GuiOptionsRemove( gui, GUI_OPTION.NoPositionTween );

            if is_panel_open then
                if not GameHasFlagRun( FLAGS.ConfigMenuOpen ) then
                    GameAddFlagRun( FLAGS.ConfigMenuOpen );
                end
            else
                if GameHasFlagRun( FLAGS.ConfigMenuOpen ) then
                    GameRemoveFlagRun( FLAGS.ConfigMenuOpen );
                end
            end
        end

        GuiIdPop( gui );
    end
    print("[copi's things] done setting up GUI");

else
    do_gui();
end
