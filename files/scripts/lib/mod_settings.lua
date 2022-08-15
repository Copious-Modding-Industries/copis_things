function setting_get( key ) return ModSettingGet( "copis_things."..key ); end
function setting_set( key, value ) if value ~= nil then return ModSettingSet( "copis_things."..key, value ); end end
function setting_clear( key ) return ModSettingRemove( "copis_things."..key ); end