--[[
    Script: hit_sound.lua

    * This will play a sound if you hit a enemy.
		Note: I would use U.I built into this cheat if it had a better API.
]]

--> User Configuration (If you do not configure this the script will not work as intended)

local sound = '' --> Steam\steamapps\common\Counter-Strike Global Offensive\csgo\sound\hitsounds
local volume = '' --> 0.1 to 1.0

--[		Do not touch anything below here unless you know what you are doing.		]--

--> API Reference(s)
local menu = fatality.menu
local input = fatality.input
local config = fatality.config
local render = fatality.render
local callbacks = fatality.callbacks

local engine_client = csgo.interface_handler:get_engine_client()
local entity_list = csgo.interface_handler:get_entity_list()
local debug_overlay = csgo.interface_handler:get_debug_overlay()

local global_vars = csgo.interface_handler:get_global_vars()

local game_events = csgo.interface_handler:get_events()
local events = csgo.interface_handler:get_events()

local cvar = csgo.interface_handler:get_cvar()

--> Main function(s)
local on_player_hurt = function(ent)
	local local_player = entity_list:get_localplayer()

	local victim_id = ent:get_int('user_id')
    local attacker_id = ent:get_int('attacker')

    local victim_ent = entity_list:get_player_from_id(victim_id)
    local attacker_ent = entity_list:get_player_from_id(attacker_id)

	if local_player == nil or victim_ent == nil or attacker_ent == nil or sound == nil or volume == nil then return end

	engine_client:client_cmd_unrestricted(string.format('playvol /hitsounds/%s %s', sound, volume))
end

local on_event = function(event)
	local event_name = event:get_name()

	if event_name == 'player_hurt' then
		on_player_hurt(event)
	end
end

--> Callback(s)
events:add_event('player_hurt')
callbacks:add('events', on_event)
