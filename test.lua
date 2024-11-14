----@diagnostic disable shuts up diagnostics here
local this_luacomp = GetUpdatedComponentID()
EntityTable			= EntityTable or {}
States              = States or {

    -- Execute On Added
    [1] = function (entity_id)
        _G['EntityTable'][entity_id] = true
    end,

    -- Execute Each Frame
    [0] = function (entity_id)
        local x, y = EntityGetTransform(entity_id)
        for entity, alive in pairs(_G['EntityTable']) do
            if not alive then goto continue end
            local tx, ty = EntityGetTransform(entity)
            local ray_x, ray_y = tx-x, ty-y
            local dist = ((ray_x*ray_x)+(ray_y*ray_y))^0.5
            local run, rise = ray_x/dist, ray_y/dist
            for i=0, dist do
                ---@diagnostic disable-next-line: undefined-global
                GameCreateCosmeticParticle("spark_purple", x+run*i, y+rise*i, 1, 0, 0, 0, 0.05, 0.05, true, true, false, false, 0, 0)
            end
            ::continue::
        end
    end,

    -- Execute On Removed
    [-1] = function (entity_id)
        _G['EntityTable'][entity_id] = false
    end,

}

-- Handle appropriate code
States[ComponentGetValue2(this_luacomp, "execute_times")](GetUpdatedEntityID())
















local effect_id = GetUpdatedEntityID()
local victim_id = EntityGetParent(effect_id)
local dmc = EntityGetFirstComponent(victim_id, "DamageModelComponent")
if dmc then
    -- Prevent stainless, Set hp to 1, Deal 1000*maxhp damage
    EntityAddRandomStains(victim_id, CellFactory_GetType("poison"), 100)
    ComponentSetValue2(dmc, "hp", 0.04)
    local hp = ComponentGetValue2(dmc, "max_hp")
    EntityInflictDamage(victim_id, hp * 1000, "DAMAGE_CURSE", "translation_string_here", "DISINTEGRATED", 0, 0)
    -- Extra measures :)
    EntityKill(victim_id)
else
    -- Clean up effect
    EntityKill(effect_id)
end



local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local liquiform = RaytraceSurfacesAndLiquiform(x, y, x, y+1)
local platform = RaytracePlatforms(x, y, x, y+1)
if liquiform and not platform then
    local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
    ComponentSetValue2(velcomp, vel_x, vel_y+1)
end

ModTextFileSetContent("data/virtual/tremble.lua", [[
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
EntitySetTransform(entity_id, x+math.random()-0.5, y+math.random()-0.5)]])
EntityAddComponent2(entity_id, "LuaComponent", {
    script_source_file = "data/virtual/tremble.lua"
})