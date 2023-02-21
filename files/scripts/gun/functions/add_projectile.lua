local function add_projectile( filepath )
    copi_state.add_projectile_depth = copi_state.add_projectile_depth + 1

    copi_state.old._add_projectile( filepath )

    copi_state.add_projectile_depth = copi_state.add_projectile_depth - 1
end
return {add_projectile = add_projectile}