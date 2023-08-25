local Compatibility = {}

Compatibility.compatibleMods = {
    anvil_of_destiny = "mods/copis_things/files/compatibility/anvil_of_destiny.lua"
}

function Compatibility.setupModCompat()
    for key, value in pairs(Compatibility.compatibleMods) do
        if ModIsEnabled(key) then
            dofile_once(value)
        end
    end
end

return Compatibility