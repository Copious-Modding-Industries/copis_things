local mod_button_reservation = tonumber( GlobalsGetValue( "config_lib_mod_button_reservation", "0" ) );
local current_button_reservation = tonumber( GlobalsGetValue( "mod_button_tr_current", "0" ) );
if current_button_reservation > mod_button_reservation then
    current_button_reservation = mod_button_reservation;
elseif current_button_reservation < mod_button_reservation then
    current_button_reservation = math.max( 0, mod_button_reservation + (current_button_reservation - mod_button_reservation ) );
else
    current_button_reservation = mod_button_reservation;
end
GlobalsSetValue( "mod_button_tr_current", tostring( current_button_reservation + 15 ) );
return current_button_reservation