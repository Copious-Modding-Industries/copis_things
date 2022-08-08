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
		id          = "SORT_DECK",
		name 		= "Unshuffle",
		description = "Stablizes shuffled wands",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/sort_deck.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,3,4,5", -- FREEZE
		spawn_probability	               = "1,1,1,1", -- FREEZE
		price = 100,
		mana = 5,
		action				= function()
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

}

for _, value in ipairs(to_insert) do
    if (value.author == nil) then
        value.author = "Copi"
    end
    value.id = "COPIS_THINGS_" .. value.id
    table.insert(actions, value)
end