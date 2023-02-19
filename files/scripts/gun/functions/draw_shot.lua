NewCast = nil
local function draw_shot( shot, instant_reload_if_empty )
    -- ??? wtf it works I guess
    local call_end_cast = false
    if NewCast == nil then
        call_end_cast = true
        NewCast = false
        local state = tonumber(GlobalsGetValue("GLOBAL_CAST_STATE", "0"))
        GlobalsSetValue("GLOBAL_CAST_STATE", tostring( state + 1))
    end

    if call_end_cast then
        NewCast = nil
    end

    copi_state.old._draw_shot( shot, instant_reload_if_empty )
end
return {draw_shot}