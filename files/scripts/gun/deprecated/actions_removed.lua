---@diagnostic disable: param-type-mismatch
local to_insert = {

    {
        id                  = "INFINITE_LIFETIME",
        name                = "Infinite Lifetime",
        description         = "Causes your projectile to last forever, but drain your wand's mana. Projectile expires when you run out of mana.",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/lifetime_infinite.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "1,2,4,5,10",
        spawn_probability   = "0.1,0.2,0.1,0.1,0.2",
        price               = 280,
        mana                = 60,
        action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 64
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/lifetime_infinite.xml,"
            draw_actions(1, true)
        end,
    },
	{
		id					= "BUBBLEBOMB",
		name				= "Bubblebomb",
		description			= "Testing",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/bubblebomb.png",
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 9,
		mana				= 0,
		action				= function()
		add_projectile("mods/copis_things/files/entities/projectiles/bubblebomb.xml")
		end,
	},
	{
		id					= "BUBBLEBOMB_DEATH_TRIGGER",
		name				= "Bubblebomb with death trigger",
		description			= "Testing",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/bubblebomb_death_trigger.png",
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 9,
		mana				= 0,
		action				= function()
		add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/bubblebomb.xml", 1)
		end,
	},
    {
        id                = "PLANK_HORIZONTAL",
        name              = "Build Wooden Platform",
        description       = "Construct a horizontal wooden platform",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/plank_horizontal.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,4,5,6", -- WALL_SQUARE
        spawn_probability = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
        price             = 100,
        mana              = 40,
        max_uses          = 3,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/plank_horizontal.xml",
        action            = function()
            local entity_id = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,
                    "ControlsComponent"), "mMousePosition")
                EntityLoad("mods/copis_things/files/entities/buildings/plank_horizontal_building.xml", mouse_x, mouse_y)
                c.fire_rate_wait = c.fire_rate_wait + 5
                current_reload_time = current_reload_time + 15
            end

        end,
    },

    {
        id                = "PLANK_CUBE",
        name              = "Build Wooden Cube",
        description       = "Construct a wooden cube",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/plank_cube.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,4,5,6", -- WALL_SQUARE
        spawn_probability = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
        price             = 100,
        mana              = 40,
        max_uses          = 12,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/plank_cube.xml",
        action            = function()
            local entity_id = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,
                    "ControlsComponent"), "mMousePosition")
                function round(n, to)
                    return math.floor(n / to + 0.5) * to
                end

                EntityLoad("mods/copis_things/files/entities/buildings/plank_cube_building.xml", round(mouse_x, 16),
                    round(mouse_y, 16))
                c.fire_rate_wait = c.fire_rate_wait + 5
                current_reload_time = current_reload_time + 15
            end

        end,
    },

    {
        id                = "PLANK_VERTICAL",
        name              = "Build Wooden Wall",
        description       = "Construct a vertical wooden wall",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/plank_vertical.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,1,2,4,5,6", -- WALL_SQUARE
        spawn_probability = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
        price             = 100,
        mana              = 40,
        max_uses          = 3,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/plank_vertical.xml",
        action            = function()
            local entity_id = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,
                    "ControlsComponent"), "mMousePosition")
                EntityLoad("mods/copis_things/files/entities/buildings/plank_vertical_building.xml", mouse_x, mouse_y)
                c.fire_rate_wait = c.fire_rate_wait + 5
                current_reload_time = current_reload_time + 15
            end

        end,
    },

	{
		id          = "DAMAGE_EXPLOSION",
		name 		= "Explosive damage plus",
		description = "Increases the explosion damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_explosion.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_explosion_add = c.damage_explosion_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},

	{
		id					= "PASSIVE_RECHARGE",
		name				= "Passive Recharge",
		description			= "Your wand recharges faster!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/passive_recharge.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
		price				= 200,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/passive_recharge.xml",
		action = function()
			draw_actions( 1, true )
		end
	},
	{
		id					= "SPELL_REFRESH",
		name				= "Spell refresh",
		description			= "Refreshes the spells within your wands and inventory",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/spell_refresh.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
		spawn_probability	= "0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005,	0.005",
		price				= 600,
		mana				= 240,
        ai_never_uses       = true,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
            if reflecting then return; end
			local entity_id = GetUpdatedEntityID()


            local valid1 = false
            local valid2 = false
            local spell_comp
            local uses_left
            local stomach
			local player = EntityGetWithTag( "player_unit" )[1]
			if entity_id ~= nil and entity_id == player then
                IngestionComps = EntityGetComponent(player, "IngestionComponent")

                for _, value in pairs(IngestionComps)do
                    stomach = value
                    local fullness = ComponentGetValue2(value, "ingestion_size")
                    if fullness >= 500 then
                        valid1 = true
                    else
                        valid1 = false
                        GamePrint("Not enough satiety!")
                        return
                    end

                    local inventory_2_comp = EntityGetFirstComponentIncludingDisabled( player, "Inventory2Component")
                    if inventory_2_comp == nil then return end
                    local wand_id = ComponentGetValue2( inventory_2_comp, "mActiveItem" )
                    for i, spell in ipairs(EntityGetAllChildren( wand_id )) do
                        spell_comp = EntityGetFirstComponentIncludingDisabled( spell, "ItemComponent" )
                        if spell_comp ~= nil then
                            ComponentSetValue2( spell_comp, "uses_remaining", uses_left - 1 )
                        end
                    end

                    if valid1 == true and valid2 == true then
                        ComponentSetValue2(stomach, "ingestion_size", fullness - 500) ---@diagnostic disable-next-line: param-type-mismatch
                        ComponentSetValue2( spell_comp, "uses_remaining", uses_left - 1 )
                        add_projectile( "mods/copis_things/files/entities/projectiles/vomere.xml" );
                        c.fire_rate_wait = c.fire_rate_wait + 15;
                        current_reload_time = current_reload_time + 33;
                    end

                end

            end

        end
	},

    {
        id					= "SILVER_BULLET_RECURSIVE_TRIGGER",
        name				= "Silver bullet with Recursive Trigger",
        description			= "A small bullet created from arcane silver which fires a copy which fires a spell upon collision",
        sprite				= "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_recursive_trigger.png",
        related_projectiles	= {"mods/copis_things/files/entities/projectiles/silver_bullet.xml"},
        type				= ACTION_TYPE_PROJECTILE,
        spawn_level			= "2,3,4",
        spawn_probability	= "0.2,0.2,0.1",
        price				= 420,
        mana				= 50,
        action				= function()
            c.fire_rate_wait = c.fire_rate_wait - 24;

            if reflecting then
                Reflection_RegisterProjectile( "mods/copis_things/files/entities/projectiles/silver_bullet.xml" )
                return
            end

            BeginProjectile( "mods/copis_things/files/entities/projectiles/silver_bullet.xml" )
                BeginTriggerHitWorld()
                    BeginProjectile( "mods/copis_things/files/entities/projectiles/silver_bullet.xml" )
                        BeginTriggerHitWorld()
                            draw_shot( create_shot( 1 ), true )
                        EndTrigger()
                    EndProjectile()
                EndTrigger()
            EndProjectile()
        end,
    },

    {
		id          		= "CHARGE_BULLET",
		name 				= "Loaded Shot",
		description 		= "Loads a bullet every time the spell is cast, all fired when you stop shooting.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/charge_bullet.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/silver_bullet.xml"},
		type 				= ACTION_TYPE_MODIFIER,
		spawn_level			= "2,3,4",
		spawn_probability	= "0.5,0.6,0.4",
		price 				= 220,
		mana 				= 20,
        ai_never_uses       = true,
		action 		= function()
			local entity_id = GetUpdatedEntityID()
			local player = EntityGetWithTag( "player_unit" )[1]
			if entity_id ~= nil and entity_id ~= 0 then
				if (entity_id == player) then
					local controls_component = EntityGetFirstComponent( player, "ControlsComponent" );
					if controls_component ~= nil then
						if ( GameGetFrameNum() == ComponentGetValue2( controls_component, "mButtonFrameFire" ) ) then
							GlobalsSetValue("Charge_bullet_revs", "0")
						else
							GlobalsSetValue("Charge_bullet_revs", tostring(GlobalsGetValue("Charge_bullet_revs")+1))
						end
						--if ComponentGetValue2( controls_component, "mButtonDownFire") ~= true then
						if tonumber(GlobalsGetValue("Charge_bullet_revs")) == 10 then
							local i = tonumber(GlobalsGetValue("Charge_bullet_revs"))
							while i >= 0 do
								add_projectile("mods/copis_things/files/entities/projectiles/silver_bullet.xml")
								i = i - 1
							end
							GlobalsSetValue("Charge_bullet_revs", "0")
						end
					end
				end
			end
		end
	},

    {
        id                = "SPELLS_TO_HEART_EXTRAHP",
        name              = "Spells to Vitality",
        description       = "Turn all nearby spells on the ground into hearts",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/spells_to_heart_extrahp.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,4",
        spawn_probability = "0.6,0.6",
        price             = 100,
        mana              = 5,
        max_uses          = 3,
        never_unlimited   = true,
        action            = function()
            local entity_id = GetUpdatedEntityID()
            local player = EntityGetWithTag("player_unit")[1]
            if (entity_id == player) then
                local pos_x, pos_y = EntityGetTransform(player) ---@diagnostic disable-next-line: param-type-mismatch
                local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")
                if (mouse_x == nil or mouse_y == nil) then return end
                local aim_x = mouse_x - pos_x
                local aim_y = mouse_y - pos_y
                local len = math.sqrt((aim_x ^ 2) + (aim_y ^ 2))
                local force_x = 1000
                local force_y = 1000
                ---@diagnostic disable-next-line: param-type-mismatch
                ComponentSetValue2(EntityGetFirstComponent(player, "CharacterDataComponent"), "mVelocity",
                    (aim_x / len * force_x), (aim_y / len * force_y))
            end
        end,
    },

    {
        id                  = "TELEPORT_CAST_BETTER",
        name                = "Conveying cast",
        description         = "Casts a spell at the nearest enemy in a large area",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/teleport_cast_better.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/teleport_projectile_unidentified.png",
        related_projectiles = { "data/entities/projectiles/deck/teleport_cast.xml" },
        type                = ACTION_TYPE_UTILITY,
        spawn_level         = "0,1,2,4,5,6", -- TELEPORT_CAST
        spawn_probability   = "0.1,0.2,0.4,0.7,0.6,0.2", -- TELEPORT_CAST
        price               = 190,
        mana                = 100,
        max_uses            = 100,
        custom_uses_logic   = true,
        ai_never_uses       = true,
        action              = function()

            if reflecting then return; end
            local valid2 = false
            local spell_comp
            local uses_left
            local entity_id = GetUpdatedEntityID()
            local player = EntityGetWithTag("player_unit")[1]
            if entity_id ~= nil and entity_id == player then

                local inventory_2_comp = EntityGetFirstComponentIncludingDisabled(player, "Inventory2Component")
                if inventory_2_comp == nil then return end
                local wand_id = ComponentGetValue2(inventory_2_comp, "mActiveItem")
                for i, spell in ipairs(EntityGetAllChildren(wand_id)) do
                    spell_comp = EntityGetFirstComponentIncludingDisabled(spell, "ItemComponent")
                    if spell_comp ~= nil and
                        ComponentGetValue2(spell_comp, "mItemUid") == current_action.inventoryitem_id then
                        uses_left = ComponentGetValue2(spell_comp, "uses_remaining")
                        if uses_left ~= 0 then
                            ComponentSetValue2(spell_comp, "uses_remaining", uses_left - 1)
                            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/teleport_cast_better.xml");
                            c.fire_rate_wait = c.fire_rate_wait + 30;
                            current_reload_time = current_reload_time + 66;
                        else
                            GamePrint("Not enough charges!")
                            return
                        end
                        break
                    end
                end
            end
        end,
    },

	{
		id          = "SUNSABER_DARK",
		name 		= "Dark Sunsaber",
		description = "A blade forged from the dark sun",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/sunsaber_dark.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/sunsaber_dark.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			               = "0,0",
		spawn_probability	               = "0,0",
		price = 150,
		mana = 0,
		sound_loop_tag = "sound_digger",
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/sunsaber_dark.xml")
			c.fire_rate_wait = c.fire_rate_wait - 35
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
		end,
	},

	{
		id					= "SWORD_BLADE",
		name				= "Sword Blade",
		description			= "Your sword's sharp edge deals damage as it hits foes!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/sword_blade.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level       = "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/projectiles/sword_blade.xml",
		action = function()
		end
	},

	{
		id					= "SPECIAL_DATARANDAL",
		name				= "Datarandal",
		description			= "The personal weapon of choice of the great warrior mage Copisinpäällikkö.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/datarandal.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 0,
		custom_xml_file 	= "mods/copis_things/files/entities/misc/custom_cards/datarandal.xml",
		action 				= function()
		end
	},

	{
		id					= "JSR_BLAST",
		name				= "JSR Blast",
		description			= "Fire a pulse of energy",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/jsr_blast.png",
		related_projectiles	= {"data/entities/projectiles/laser_bouncy.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price				= 0,
		mana				= 0,
		action				= function()
				add_projectile("data/entities/projectiles/laser_bouncy.xml")
				c.spread_degrees = c.spread_degrees - 2.0
				c.damage_projectile_add = c.damage_projectile_add - 0.25
		end,
	},

	{
		id					= "TWISTED_SWORD_THROW",
		name				= "Sword throw",
		description			= "Throw a rapidly spinning sword clone",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/twisted_throw.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/twisted_throw.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price				= 0,
		mana				= 0,
	action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/twisted_throw.xml")
			c.screenshake = c.screenshake + 0.7
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_critical_chance = c.damage_critical_chance + 15
			c.fire_rate_wait = c.fire_rate_wait + 40
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
			c.damage_projectile_add = c.damage_projectile_add + 0.2
		end,
	},


	{
		id          = "SHADOWTENTACLE",
		name 		= "Shadow Apparition",
		description = "Release a lash of pure darkness which spreads from it's victims",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/shadowtentacle.png",
		related_projectiles	= {"mods/copis_things/files/projectiles/shadowtentacle.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price = 170,
		mana = 30,
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/shadow_lash.xml")
			c.fire_rate_wait = c.fire_rate_wait - 5
		end
	},

    {
        id                  = "DAMAGE_MINUS",
        name                = "Damage Minus",
        description         = "Decreases the damage done by a projectile",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/damage_minus.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "2,3,4,5", -- DAMAGE
        spawn_probability   = "0.3,0.3,0.3,0.3", -- DAMAGE
        price               = 50,
        mana                = -20,
        --max_uses = 50,
        action              = function()
            c.damage_projectile_add       = c.damage_projectile_add - 0.2
            c.gore_particles              = c.gore_particles - 5
            c.fire_rate_wait              = c.fire_rate_wait - 2.5
            shot_effects.recoil_knockback = shot_effects.recoil_knockback - 10.0
            draw_actions(1, true)
        end,
    },

	{
		id					= "SUMMON_POUCH",
		name				= "Summon pouch",
		description			= "Summons an empty pouch",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_flask.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 90,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/goldnugget_200.xml")
		end,
	},

	{
		id					= "SUMMON_POUCH_FULL",
		name				= "Summon filled pouch",
		description			= "Summons a pouch filled with a random material",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_flask_full.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.125,	0.17,	0.25,	0.17,	0.125",
		price				= 300,
		mana				= 120,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/goldnugget_200.xml")
		end,
	},

	{
		id          = "SHUFFLE_DECK",
		name 		= "Shuffle",
		description = "Imbues a wand with unpredictable energy",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/shuffle_deck.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,3,4,5", -- FREEZE
		spawn_probability	               = "1,1,1,1", -- FREEZE
		price = 100,
		mana = -20,
		action				= function()
		end,
	},

    {
        id                = "BOUNCE_100",
        name              = "Hundredfold Bounce",
        description       = "Causes a projectile to bounce many times",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/bounce_100.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "2,3,4,5,6", -- BOUNCE
        spawn_probability = "1,1,0.4,0.2,0.2", -- BOUNCE
        price             = 100,
        mana              = 10,
        action            = function()
            c.bounces = c.bounces + 100
            c.speed_multiplier = c.speed_multiplier * 1.2
            c.spread_degrees = c.spread_degrees - 10
            draw_actions(1, true)
        end,
    },

    {
        id                  = "HOMING_ANGLE",
        name                = "Cubic Homing",
        description         = "Projectiles rotate towards enemies to their sides",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/homing_angle.png",
        type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4,5,6",
		spawn_probability   = "0.7,0.7,0.4,0.4,1.0",
        price               = 190,
        mana                = 25,
        action              = function()
            c.extra_entities    = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_angle.xml,data/entities/particles/tinyspark_white_small.xml,"
			c.fire_rate_wait    = c.fire_rate_wait + 8
			c.spread_degrees    = c.spread_degrees - 12
            c.speed_multiplier  = c.speed_multiplier * 0.75;
            draw_actions( 1, true );
        end,
    },

    {
        id                  = "SUMMON_TABLET",
        name                = "Summon Emerald Tablet",
        description         = "Summon an emerald tablet",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/summon_tablet.png",
        related_projectiles = { "mods/copis_things/files/entities/projectiles/tablet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3,4,5,6", -- SUMMON_ROCK
        spawn_probability   = "0.8,0.8,0.8,0.8,0.8,0.8,0.8", -- SUMMON_ROCK
        price               = 160,
        mana                = 100,
        max_uses            = 3,
        --custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/summon_rock.xml",
        action              = function()
            add_projectile("mods/copis_things/files/entities/projectiles/tablet.xml")
        end,
    },

    {
        id                     = "HOMING_LIGHT",
        name                   = "Soft Homing",
        description            = "Guides a projectile weakly towards your foes",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/homing_light.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/homing_light.xml,data/entities/particles/tinyspark_white_weak.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5,6", -- HOMING
        spawn_probability      = "0.4,0.8,1,0.4,0.1,0.1", -- HOMING
        price                  = 100,
        mana                   = 25,
        action                 = function()
            c.extra_entities = c.extra_entities ..
                "mods/copis_things/files/entities/misc/homing_light.xml,data/entities/particles/tinyspark_white_weak.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_MELEE",
        name                   = "Melee damage plus",
        description            = "Increases melee the damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_melee.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_melee_add            = c.damage_melee_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_DRILL",
        name                   = "Drill damage plus",
        description            = "Increases the drill damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_drill.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_drill_add            = c.damage_drill_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,

    },

    {
        id                     = "DAMAGE_SLICE",
        name                   = "Slice damage plus",
        description            = "Increases the slice damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_slice.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_slice_add            = c.damage_slice_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_ELECTRICITY",
        name                   = "Electric damage plus",
        description            = "Increases the electric damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_electricity.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_electricity_add      = c.damage_electricity_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_FREEZE",
        name                   = "Freeze damage plus",
        description            = "Increases the freeze damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_freeze.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_ice_add              = c.damage_ice_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_CURSE",
        name                   = "Curse damage plus",
        description            = "Increases the curse damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_curse.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5", -- DAMAGE
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_curse_add            = c.damage_curse_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                     = "DAMAGE_FIRE",
        name                   = "Fire damage plus",
        description            = "Increases the fire damage done by a projectile",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/damage_fire.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/damage_unidentified.png",
        related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "1,2,3,4,5",
        spawn_probability      = "0.6,0.6,0.6,0.6,0.6",
        price                  = 140,
        mana                   = 5,
        --max_uses = 50,
        custom_xml_file        = "data/entities/misc/custom_cards/damage.xml",
        action                 = function()
            c.damage_fire_add             = c.damage_fire_add + 0.4
            c.gore_particles              = c.gore_particles + 5
            c.fire_rate_wait              = c.fire_rate_wait + 5
            c.extra_entities              = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
            shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
            draw_actions(1, true)
        end,
    },

    {
        id                  = "DAMAGE_TO_CURSE",
        name                = "Damage to Curse",
        description         = "Converts 80% of projectile damage to curse damage",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/damage_to_curse.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "1,2,4,5,10",
        spawn_probability   = "0.1,1,0.1,0.1,0.2",
        price               = 280,
        mana                = 30,
        action              = function()
			c.fire_rate_wait = c.fire_rate_wait + 14
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_to_curse.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "OSCILLATING_SPEED",
        name              = "Oscillating Speed",
        description       = "Causes a projectile's speed to fluctuate",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/oscillating_speed.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3", -- SPEED
        spawn_probability = "1,0.5,0.5", -- SPEED
        price             = 80,
        mana              = 2,
        --max_uses = 100,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/oscillating_speed.xml,"
            c.spread_degrees = c.spread_degrees - 8
            draw_actions(1, true)
        end,
    },

    {
        id                = "HITFX_CRITICAL_DRUNK",
        name              = "Critical on drunk enemies",
        description       = "Makes a projectile always do a critical hit on drunk enemies",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_alcoholic.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price             = 70,
        mana              = 10,
        --max_uses = 50,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_alcoholic.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "HITFX_CRITICAL_CONFUSION",
        name              = "Critical on confused enemies",
        description       = "Makes a projectile always do a critical hit on confused enemies",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_confusion.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,3,4,5", -- HITFX_CRITICAL_WATER
        spawn_probability = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
        price             = 70,
        mana              = 10,
        --max_uses = 50,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_confusion.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "RECHARGE_2",
        name              = "Reduce recharge time II",
        description       = "Reduces the time between spellcasts heavily",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_2.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
        price             = 400,
        mana              = 24,
        --max_uses = 75,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait - 20
            current_reload_time = current_reload_time - 40
            draw_actions(1, true)
        end,
    },

    {
        id                = "RECHARGE_3",
        name              = "Reduce recharge time III",
        description       = "Reduces the time between spellcasts immensely",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_3.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.33,0.33,0.33,0.33,0.33,0.33", -- RECHARGE
        price             = 600,
        mana              = 48,
        --max_uses = 50,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait - 30
            current_reload_time = current_reload_time - 60
            draw_actions(1, true)
        end,
    },

    {
        id                = "RECHARGE_DELAY_UP",
        name              = "Delayed recharge",
        description       = "Sharply reduces wand recharge speed at the cost of cast delay",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_delay_up.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
        price             = 400,
        mana              = 24,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 60
            current_reload_time = current_reload_time - 80
            draw_actions(1, true)
        end,
    },

    {
        id                = "RECHARGE_DELAY_DOWN",
        name              = "Rushing recharge",
        description       = "Sharply reduces cast delay between spells at the cost of wand recharge speed",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_delay_down.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
        price             = 400,
        mana              = 24,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait - 80
            current_reload_time = current_reload_time + 60
            draw_actions(1, true)
        end,
    },

    {
        id                = "ARCANE_RECHARGE",
        name              = "Arcane Recharge",
        description       = "Slightly reduce the time between spellcasts, but gain mana when casting",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/arcane_recharge.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
        price             = 400,
        mana              = -12,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait - 5
            current_reload_time = current_reload_time - 10
            draw_actions(1, true)
        end,
    },

    {
        id                = "MANA_REDUCE_2",
        name              = "Add mana II",
        description       = "Adds 60 mana to the wand",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/mana_2.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "3,4,5,6", -- MANA_REDUCE
        spawn_probability = "0.5,0.5,0.5,0.5", -- MANA_REDUCE
        price             = 500,
        mana              = -60,
        --max_uses = 75,
        custom_xml_file   = "data/entities/misc/custom_cards/mana_reduce.xml",
        action            = function()
            c.fire_rate_wait = c.fire_rate_wait + 20
            draw_actions(1, true)
        end,
    },

    {
        id                = "MANA_REDUCE_3",
        name              = "Add mana III",
        description       = "Adds 90 mana to the wand",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/mana_3.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "5,6", -- MANA_REDUCE
        spawn_probability = "0.33,0.33", -- MANA_REDUCE
        price             = 750,
        mana              = -90,
        --max_uses = 50,
        custom_xml_file   = "data/entities/misc/custom_cards/mana_reduce.xml",
        action            = function()
            c.fire_rate_wait = c.fire_rate_wait + 30
            draw_actions(1, true)
        end,
    },

    {
        id                = "SUMMON_BOSS_CENTIPEDE",
        name              = "Summon Kolmisilmä",
        description       = "Summons Kolmisilmä.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_centipede.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_centipede/boss_centipede.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_WIZARD",
        name              = "Summon Mestarien mestari",
        description       = "Summons Mestarien mestari.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_wizard.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_wizard/boss_wizard.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_ALCHEMIST",
        name              = "Summon Ylialkemisti",
        description       = "Summons Ylialkemisti.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_alchemist.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_alchemist/boss_alchemist.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_DRAGON",
        name              = "Summon Suomuhauki",
        description       = "Summons Suomuhauki.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_dragon.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_dragon.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_GHOST",
        name              = "Summon Unohdettu",
        description       = "Summons Unohdettu.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_ghost.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_ghost/boss_ghost.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_PIT",
        name              = "Summon Sauvojen Tuntija",
        description       = "Summons Sauvojen Tuntija.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_pit.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_pit/boss_pit.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_LIMBS",
        name              = "Summon Kolmisilmän Koipi",
        description       = "Summons Kolmisilmän Koipi.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_limbs.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_limbs/boss_limbs.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_BOSS_ROBOT",
        name              = "Summon Kolmisilmän silmä",
        description       = "Summons Kolmisilmän Koipi.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_robot.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/boss_robot/boss_robot.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_MAGGOT_TINY",
        name              = "Summon Limatoukka",
        description       = "Summons Limatoukka.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_maggot_tiny.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 1500,
        max_uses          = 1,
        action            = function()
            add_projectile("data/entities/animals/maggot_tiny/maggot_tiny.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_FLASK",
        name              = "Summon flask",
        description       = "Summons an empty flask",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_flask.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 90,
        max_uses          = 1,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            add_projectile("data/entities/items/pickup/potion_empty.xml")
        end,
    },

    {
        id                = "SUMMON_FLASK_FULL",
        name              = "Summon filled flask",
        description       = "Summons a flask filled with a random material",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_flask_full.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.17,	0.125",
        price             = 300,
        mana              = 120,
        max_uses          = 1,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            add_projectile("data/entities/items/pickup/potion_random_material.xml")
        end,
    },

    {
        id                = "SUMMON_JAR",
        name              = "Summon jar",
        description       = "Summons an empty jar",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_jar.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.050,	0.067,	0.100,	0.067,	0.050",
        price             = 200,
        mana              = 90,
        max_uses          = 1,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            add_projectile("data/entities/items/pickup/jar.xml")
        end,
    },

    {
        id                = "SUMMON_SUN",
        name              = "Summon Sun",
        description       = "Summons the sun.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_sun.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 3000,
        action            = function()
            add_projectile("data/entities/items/pickup/sun/newsun.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "SUMMON_DARK_SUN",
        name              = "Summon Dark Sun",
        description       = "Summons the dark sun.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_dark_sun.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 3000,
        action            = function()
            add_projectile("data/entities/items/pickup/sun/newsun_dark.xml")
            c.fire_rate_wait = c.fire_rate_wait + 150
            current_reload_time = current_reload_time + 40
        end,
    },

    {
        id                = "BUFF_BERSERK",
        name              = "Status: Berserk",
        description       = "Applies the berserk status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_berserk.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_berserk.xml", px
                    , py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_BOUNCE",
        name              = "Status: Bouncing Shots",
        description       = "Applies the bouncing shots status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_bounce.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_bounce.xml", px
                    , py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_DAMAGE_PLUS",
        name              = "Status: Damage plus",
        description       = "Applies the damage plus status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_damage_plus.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_damage_plus.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_EDIT_WANDS_EVERYWHERE",
        name              = "Status: Tinker with wands",
        description       = "Applies the tinker with wands status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_edit_wands_everywhere.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.083,	0.125",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_edit_wands_everywhere.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_FASTER_LEVITATION",
        name              = "Status: Faster levitiation",
        description       = "Applies the faster levitation status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_faster_levitation.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_faster_levitation.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_HOMING",
        name              = "Status: Homing shots",
        description       = "Applies the homing shots status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_homing.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_homing.xml", px
                    , py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_HP_REGENERATION",
        name              = "Status: Health regeneration",
        description       = "Applies the health regeneration status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_hp_regeneration.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.17,	0.125",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_hp_regeneration.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_INVISIBILITY",
        name              = "Status: Invisibility",
        description       = "Applies the invisibility status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_invisibility.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_invisibility.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_MANA_REGENERATION",
        name              = "Status: Mana regeneration",
        description       = "Applies the mana regeneration status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_mana_regeneration.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_mana_regeneration.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_MOVEMENT_FASTER",
        name              = "Status: Greased lightning",
        description       = "Applies the greased lightning status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_movement_faster.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_movement_faster.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_NIGHTVISION",
        name              = "Status: Wormy vision",
        description       = "Applies the wormy vision status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_nightvision.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.17,	0.125",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_nightvision.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_PROTECTION_ALL",
        name              = "Status: Immunity",
        description       = "Applies the immunity status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_protection_all.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.125,	0.17,	0.25,	0.17,	0.125",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_protection_all.xml"
                    , px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_RECHARGE",
        name              = "Status: Reduced recharge",
        description       = "Applies the reduced recharge status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_recharge.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_recharge.xml",
                    px, py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "BUFF_SHIELD",
        name              = "Status: Shielded",
        description       = "Applies the shielded status to you for a short time",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/buff_shield.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,		3,		4,		5,		6",
        spawn_probability = "0.25,	0.33,	0.50,	0.33,	0.25",
        price             = 200,
        mana              = 120,
        max_uses          = 10,
        never_unlimited   = true,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 40
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()

            if entity_id ~= nil and entity_id ~= 0 then
                local px, py = EntityGetTransform(entity_id)
                local effect_id = EntityLoad("mods/copis_things/files/entities/misc/status_entities/buff_shield.xml", px
                    , py)
                EntityAddChild(entity_id, effect_id)
            end
        end,
    },

    {
        id                = "LIGHT_REMOVER",
        name              = "Light Remover",
        description       = "Removes the light from a projectile",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/light_remover.png",
        type              = ACTION_TYPE_MODIFIER,
        spawn_level       = "2,3", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2", -- FIREBALL_RAY
        price             = 50,
        mana              = 0,
        action            = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/light_remover.xml,";
            draw_actions(1, true);
        end,
    },

    {
        id                = "RANDOM_CAST",
        name              = "Random cast",
        description       = "Casts a spell from a random position",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/random_cast.png",
        type              = ACTION_TYPE_UTILITY,
        spawn_level       = "2,3,4,5", -- FIREBALL_RAY
        spawn_probability = "0.2,0.2,0.2,0.2", -- FIREBALL_RAY
        price             = 90,
        mana              = 0,
        action            = function()
            c.fire_rate_wait = c.fire_rate_wait - 10
            if reflecting then return; end
            add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/random_cast.xml", 1)
        end,
    },

    {
        id                = "PROTECTION_FIRE",
        name              = "Fire immunity",
        description       = "Your wand grants you a magical aura of fire immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_fire.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_fire.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_EXPLOSION",
        name              = "Explosion immunity",
        description       = "Your wand grants you a magical aura of explosion immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_explosion.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_explosion.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_ELECTRICITY",
        name              = "Electricity immunity",
        description       = "Your wand grants you a magical aura of electricity immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_electricity.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_electricity.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_ICE",
        name              = "Freeze immunity",
        description       = "Your wand grants you a magical aura of freeze immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_ice.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_ice.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_RADIOACTIVITY",
        name              = "Toxic immunity",
        description       = "Your wand grants you a magical aura of toxic immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_radioactivity.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_radioactivity.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_MELEE",
        name              = "Melee immunity",
        description       = "Your wand grants you a magical aura of melee immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_melee.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_melee.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "PROTECTION_POLYMORPH",
        name              = "Polymorph immunity",
        description       = "Your wand grants you a magical aura of polymorph immunity!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/protection_polymorph.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6,10", -- RECHARGE
        spawn_probability = "0.05,0.05,0.05,0.05,0.05,0.05,0.1", -- RECHARGE
        price             = 1200,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/protection_polymorph.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "INVISIBILITY",
        name              = "Invisibility",
        description       = "Your wand grants you a magical aura of invisibility!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/invisibility.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
        price             = 800,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/invisibility.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "BREATH_UNDERWATER",
        name              = "Breath Underwater",
        description       = "Your wand grants you a magical aura of respiration!",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/breath_underwater.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5,6", -- RECHARGE
        spawn_probability = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
        price             = 800,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/breath_underwater.xml",
        action            = function()
            draw_actions(1, true)
        end
    },

    {
        id                = "KICK_EXPLOSION",
        name              = "Explosive Kick",
        description       = "Create a devastating explosion when you kick. Use wisely! Consumes 60 mana when you kick.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/kick_explosion.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price             = 280,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/kick_explosion.xml",
        action            = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end,
    },

    {
        id                  = "SHUFFLE_DECK",
        name                = "Shuffle Deck",
        description         = "Randomize the order of all spells in the cast",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/shuffle_deck.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "0,		1,		2,		3,		4,		5,		6",
        spawn_probability   = "0.4,	0.4,	0.4,	0.4,	0.4,	0.4,	0.4",
        price               = 100,
        mana                = -20,
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait - 32
            SetRandomSeed(GameGetFrameNum(), 1284);
            local shuffle_deck = {};
            for i = 1, #deck do
                local index = Random(1, #deck);
                local action = deck[index];
                table.remove(deck, index);
                table.insert(shuffle_deck, action);
            end
            for index, action in pairs(shuffle_deck) do
                table.insert(deck, action);
            end
            draw_actions(1, true);
        end,
    },

    {
        id                     = "EXPIRE_NEARBY_ENEMIES",
        name                   = "Projectile Area Expiration",
        description            = "Projectiles will expire when enemies are nearby",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/expire_nearby_enemies.png",
        sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/expire_nearby_enemies.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,		4,		5,		6",
        spawn_probability      = "0.2,	0.2,	0.5,	0.1",
        price                  = 50,
        mana                   = 5,
        action                 = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/expire_nearby_enemies.xml,"
            draw_actions(1, true);
        end,
    },

    {
        id                  = "LIGHT_BULLET_INHERIT_TRIGGER",
        name                = "Spark bolt with inheritance trigger",
        description         = "A spark bolt that casts another spell upon expiring, which inherits modifiers",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/light_bullet_inherit_trigger.png",
        related_projectiles = { "data/entities/projectiles/deck/light_bullet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "2,3,4", -- LIGHT_BULLET_TRIGGER
        spawn_probability   = "0.2,0.2,0.2", -- LIGHT_BULLET_TRIGGER
        price               = 280,
        mana                = 60,
        --max_uses = 100,
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait + 3
            c.screenshake = c.screenshake + 0.5
            c.damage_critical_chance = c.damage_critical_chance + 5

            if reflecting then
                Reflection_RegisterProjectile("data/entities/projectiles/deck/light_bullet.xml")
                return
            end

            local c_old = c
            BeginProjectile("data/entities/projectiles/deck/light_bullet.xml");
            BeginTriggerDeath();
            draw_actions(1, true);
            register_action(c);
            SetProjectileConfigs();
            EndTrigger();
            EndProjectile();
            c = c_old
        end,
    },

    {
        id                  = "LIGHT_BULLET_RECURSIVE_TRIGGER",
        name                = "Spark bolt with Recursive Trigger",
        description         = "A spark bolt which fires a copy which fires a spell upon collision",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/light_bullet_recursive_trigger.png",
        related_projectiles = { "data/entities/projectiles/deck/light_bullet.xml" },
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3", -- LIGHT_BULLET_TRIGGER
        spawn_probability   = "1,0.5,0.5,0.5", -- LIGHT_BULLET_TRIGGER
        price               = 160,
        mana                = 20,
        --max_uses = 100,
        action              = function()
            c.fire_rate_wait = c.fire_rate_wait + 6
            c.screenshake = c.screenshake + 1
            c.damage_critical_chance = c.damage_critical_chance + 10

            if reflecting then
                Reflection_RegisterProjectile("data/entities/projectiles/deck/light_bullet.xml");
                return;
            end

            BeginProjectile("data/entities/projectiles/deck/light_bullet.xml");
                BeginTriggerHitWorld();
                    BeginProjectile("data/entities/projectiles/deck/light_bullet.xml");
                        BeginTriggerHitWorld()
                            draw_shot(create_shot(1), true)
                        EndTrigger()
                    EndProjectile();
                    register_action( c );
                    SetProjectileConfigs();
                EndTrigger();
            EndProjectile()
        end,
    },

    {
        id                = "WAND_SET",
        name              = "Ascension (One-Off)",
        description       = "Cast inside a wand to store it in the heavens.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/wand_set.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
        spawn_probability = "0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05",
        price             = 2000,
        mana              = 0,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 500
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local x, y = EntityGetTransform(entity_id)
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                if not ModSettingGet("copis_things.wand0") then
                    local wand = EZWand.GetHeldWand()
                    wand:RemoveSpells("COPIS_THINGS_WAND_SET")
                    ModSettingSet("copis_things.wand0", wand:Serialize())
                    GameScreenshake(50, x, y)
                    EntityLoad("mods/copis_things/files/entities/particles/blast.xml", x, y)
                    GamePrintImportant("Your wand disintegrates into divine light!", "Wand stored!")
                    EntityKill(wand.entity_id)
                else
                    GameScreenshake(10, x, y)
                    GamePrintImportant("You feel the heavens are full", "Wand already stored!")
                    GamePrint("Retrieve your stored wand before inserting a new one")
                end
            end
        end
    },

    {
        id                = "WAND_GET",
        name              = "Deliverance (One-Off)",
        description       = "Cast inside a wand to retrieve what was once yours.",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/wand_get.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
        spawn_probability = "0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05,	0.05",
        price             = 2000,
        mana              = 0,
        action            = function()
            c.fire_rate_wait    = c.fire_rate_wait + 20
            current_reload_time = current_reload_time + 500
            if reflecting then return; end
            local entity_id     = GetUpdatedEntityID()
            if entity_id ~= nil and entity_id ~= 0 then
                dofile("data/scripts/lib/utilities.lua")
                local x, y = EntityGetTransform(entity_id)
                local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
                if not ModSettingGet("copis_things.wand0") then
                    GamePrintImportant("You feel an emptiness in the heavens", "No wand stored!")
                    GamePrint("Store a wand to retrieve")
                else
                    local wand = EZWand(ModSettingGet("copis_things.wand0"), x, y)
                    GamePrintImportant("The heavens deliver a gift!", "Wand retrieved!")
                    GameScreenshake(10, x, y)
                    EntityLoad("mods/copis_things/files/entities/particles/blast.xml", x, y)
                    ModSettingRemove("copis_things.wand0")
                    local wand2 = EZWand.GetHeldWand()
                    wand2:RemoveSpells("COPIS_THINGS_WAND_GET")
                end
            end
        end
    },

    {
        id                = "AUTO_ALT_FIRE",
        name              = "Automation - Alt fire",
        description       = "Your held wand fires when you hold alt fire",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/passive_auto_alt_fire.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "3,4,5,6", -- TINY_GHOST
        spawn_probability = "0.1,0.1,0.1,0.1", -- TINY_GHOST
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/auto_alt_fire.xml",
        action            = function()
            draw_actions(1, true)
        end,
    },

	{
		id          = "CHAOS_BLADE",
		name 		= "Chaos Blade",
		description = "A slash of destructive energy, struck enemies will be left vulnerable",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/chaos_blade.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/chaos_blade.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "3,4,6",
		spawn_probability                 = "0.1,0.4,0.5",
		price = 150,
		mana = 40,
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 10
            if reflecting then return; end
			add_projectile("mods/copis_things/files/entities/projectiles/chaos_blade.xml")
		end,
	},

    {
        id                  = "MULTICAST_SPREAD",
        name                = "Full Hand",
        description         = "Fire all remaining spells with spread proportional to spells drawn",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/draw_many_spread.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/slow_bullet_timer_unidentified.png",
        type                = ACTION_TYPE_DRAW_MANY,
        spawn_level         = "4,5,6",
        spawn_probability   = "0.1,0.2,0.3",
        price               = 250,
        mana                = 20,
        action              = function()

            local n = 1
            while (#deck > 0) do
                n = n + 1
                draw_actions( 1, true )
            end

            c.pattern_degrees = c.pattern_degrees + (n * 0.5)
        end,
    },

    {
        id                     = "GUNNER_SHOT_CURSOR",
        name                   = "Controlled Gunner Shot",
        description            = "Makes a projectile rapidly fire weak shots at the cursor while holding RMB",
        sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot_cursor.png",
        related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot_cursor.xml" },
        type                   = ACTION_TYPE_MODIFIER,
        spawn_level            = "2,3,4,5,10", -- FIREBALL_RAY
        spawn_probability      = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
        price                  = 260,
        mana                   = 100,
        --max_uses = 20,
        action                 = function()
            c.fire_rate_wait = c.fire_rate_wait + 15
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot_cursor.xml,"
            draw_actions(1, true)
        end,
    },

    {
        id                = "ATTACK_LEG",
        name              = "Lukki Limb",
        description       = "Control a Lukki leg to kick nearby enemies automatically",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/attack_leg.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.1,0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/attack_leg.xml",
        action            = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end,
    },

    {
        id                = "BAYONET",
        name              = "Bayonet",
        description       = "Attach a small knife to the tip of your wand --INDEV WRONG AREA DAMAGE--",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/bayonet.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
        spawn_probability = "0.1,0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
        price             = 160,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/bayonet.xml",
        action            = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end,
    },

    {
        id                = "ALT_FIRE_LUNGE",
        name              = "Sidearm Lunge",
        description       = "Launch yourself forwards with a burst of speed when you press alt fire. Consumes 5 mana when lunging",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_lunge.png",
        type              = ACTION_TYPE_PASSIVE,
        spawn_level       = "1,2,4",
        spawn_probability = "0.4,0.4,0.4",
        price             = 100,
        mana              = 0,
        custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_lunge.xml",
        action            = function()
            -- does nothing to the projectiles
            draw_actions(1, true)
        end,
    },

	{
		id          = "ENERGY_SHIELD_SPIN",
		name 		= "Orbiting Energy Shields",
		description = "4 small energy shields which orbit you!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/energy_shield_spin.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/energy_shield_sector_unidentified.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level                       = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
		spawn_probability                 = "0.05,0.6,0.6,0.6,0.6,0.6", -- ENERGY_SHIELD_SECTOR
		price = 160,
        mana = 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/energy_shield_spin.xml",
		action 		= function()
			-- does nothing to the projectiles
			draw_actions( 1, true )
		end,
	},
    -- PSYCHIC GRIP
    {
        id = "COPIS_THINGS_PSYCHIC_GRIP",
        author = "Copi",
        name = "Psychic Grip",
        description = "Locks a projectile in front of your wand",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/psychic_grip.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_grip.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_CORPSE_BOMB",
        author = "Copi",
        name = "Detonecromation",
        description = "Causes the corpses of killed enemies to violently explode into noxious gasses",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/corpse_bomb.png",
        type = ACTION_TYPE_MODIFIER,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            if not c.extra_entities:find("mods/copis_things/files/entities/misc/default_ragdoll.xml,") then
                c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/default_ragdoll.xml,"
            end
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/corpse_bomb.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_TELEPORT_CORPSE",
        author = "Copi",
        name = "Deathbound teleport bolt",
        description = "A magical bolt that curses a body to carry you postmortem",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/teleport_corpse.png",
        type = ACTION_TYPE_PROJECTILE,
        spawn_level = "2,3,4,5,6",
        spawn_probability = "0.3,0.4,0.5,0.6,0.6",
        price = 150,
        mana = 15,
        action = function()
            if not c.extra_entities:find("mods/copis_things/files/entities/misc/default_ragdoll.xml,") then
                c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/default_ragdoll.xml,"
            end
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/corpse_teleport.xml,"
            draw_actions(1, true)
        end
    },
    {
        id = "COPIS_THINGS_LIGHT_BULLET_DECK_RAY_ENEMY",
        author = "Copi",
        name = "Enemy Trigger",
        description = "The next casting block is fired as the enemy",
        sprite = "mods/copis_things/files/ui_gfx/gun_actions/barrier_arc.png",
        type = ACTION_TYPE_MODIFIER,
		spawn_level = "2,3,4,5,6", -- ARC_ELECTRIC
		spawn_probability = "0.4,0.4,0.4,0.4,0.8", -- ARC_ELECTRIC
        price = 10,
        mana = 0,
        action = function()

            GamePrint("THIS CONTENT IS WIP.")
            draw_actions(1, true)
        end
    },

}

for _, value in ipairs(to_insert) do
    if (value.author == nil) then
        value.author = "Copi"
    end
    value.id = "COPIS_THINGS_" .. value.id
    table.insert(actions, value)
end
