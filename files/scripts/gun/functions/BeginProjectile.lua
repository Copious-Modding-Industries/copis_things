---@diagnostic disable: lowercase-global, undefined-global

local function BeginProjectile( action )
	c.action_type = copi_state.bit
    copi_state.old._BeginProjectile( action )
end

return {BeginProjectile = BeginProjectile}