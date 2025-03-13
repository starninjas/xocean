local f = string.format

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

xocean = {
	version = os.time({year = 2022, month = 11, day = 14}),
	author = "starninjas",
	license = "MIT",

	custom_spawn = false,

	modname = modname,
	modpath = modpath,

	S = S,

	has = {
		mobs = minetest.get_modpath("mobs") and mobs.mod == "redo",
	},

	log = function(level, message, ...)
		message = message:format(...)
		minetest.log(level, f("[%s] %s", modname, message))
	end,

	dofile = function(...)
		dofile(table.concat({modpath, ...}, DIR_DELIM) .. ".lua")
	end,
}

local input = io.open(modpath .. "/spawn.lua", "r")

if input then
	xocean.custom_spawn = true
	input:close()
	input = nil
end

xocean.dofile("craftitems")
xocean.dofile("nodes", "init")
xocean.dofile("mobs", "init")
xocean.dofile("crafts")
xocean.dofile("mapgen")

if xocean.custom_spawn then
	dofile(modpath .. "/spawn.lua")
end
