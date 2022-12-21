local f = string.format

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

xoceans = {
    version = os.time({year = 2022, month = 11, day = 14}),
    author = "starninjas",
    license = "MIT",

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

xoceans.dofile("craftitems")
xoceans.dofile("nodes", "init")
xoceans.dofile("mobs", "init")
xoceans.dofile("crafts")
xoceans.dofile("mapgen")
