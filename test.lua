----@diagnostic disable shuts up diagnostics here
local this_luacomp = GetUpdatedComponentID()
_G['EntityTable']   = _G['EntityTable'] or {}
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