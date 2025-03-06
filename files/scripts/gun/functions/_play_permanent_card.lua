local function _play_permanent_card(...)
	copi_state.old.__play_permanent_card(...)
end
return {_play_permanent_card=_play_permanent_card}