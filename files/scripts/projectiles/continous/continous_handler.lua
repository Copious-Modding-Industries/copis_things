--[[
CONTINOUS ATTACKS
- Handler projectile (this is what triggers the beam)
- KILLED on:
	- Swapping wand
	- Creation of a new one

- While holding fire:
	- Hit internal hitbox every n frames, based on:
		- config:fire_rate_wait
		- config:reload_time
	- This creates a beam projectile (invisible)
	- Display visual beam
	- Create hit sparks

	- config:spread_degrees		-> NOISE based warbling (should waver, not snap about)
	- config:pattern_degrees	-> FIXED OFFSET based on beam count and stat


]]