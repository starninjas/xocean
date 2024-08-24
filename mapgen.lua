minetest.register_ore({
	ore_type = "blob",
	ore = "xocean:ocean_stone",
	wherein = { "default:sand" },
	clust_scarcity = 32 * 32 * 32,
	clust_size = 8,
	y_min = -15,
	y_max = 0,
	noise_threshold = 0.0,
	noise_params = {
		offset = 0.5,
		scale = 0.2,
		spread = { x = 8, y = 5, z = 8 },
		seed = -316,
		octaves = 1,
		persist = 0.0,
	},
})

local function register_decoration(def)
	def.place_offset_y = -1
	def.biomes = {
		"taiga_ocean",
		"snowy_grassland_ocean",
		"grassland_ocean",
		"coniferous_forest_ocean",
		"deciduous_forest_ocean",
		"sandstone_desert_ocean",
		"cold_desert_ocean",
	}
	def.flags = "force_placement"
	def.param2 = 48
	def.param2_max = 96
	
	minetest.register_decoration(def)
end

local function register_schematic_decoration(def) 
	def.deco_type = "schematic"
	def.place_on = { "default:sand" }
	def.y_max = -6
	def.y_min = -16
	
	register_decoration(def)
end

local function register_simple_decoration(def) 
	def.deco_type = "simple"
	def.sidelen = 16
	def.y_max = -5
	def.y_min = -50
	
	register_decoration(def)
end

local function register_coral_plant(def)
	def.place_on = {
		"xocean:brain_block",
		"xocean:tube_block",
		"default:coral_orange",
		"default:coral_brown",
		"xocean:bubble_block",
	}
	def.noise_params = {
		offset = -0.04,
		scale = 1.0,
		spread = { x = 20, y = 20, z = 20 },
		seed = 87112,
		octaves = 3,
		persist = 0.7,
	}

	register_simple_decoration(def)
end

register_schematic_decoration({
	name = "xocean:brain",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.0001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 20,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/brain.mts",
})

register_schematic_decoration({
	name = "xocean:horn",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.0001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 20,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/horn.mts",
})

register_schematic_decoration({
	name = "xocean:bubble",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.0001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 20,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/bubble.mts",
})

register_schematic_decoration({
	name = "xocean:tube",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.0001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 20,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/tube.mts",
})

register_schematic_decoration({
	name = "xocean:fire",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.0001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 20,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/fire.mts",
})

register_schematic_decoration({
	name = "xocean:brain2",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 28,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/brain2.mts",
})

register_schematic_decoration({
	name = "xocean:horn2",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 28,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/horn2.mts",
})

register_schematic_decoration({
	name = "xocean:bubble2",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 28,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/bubble2.mts",
})

register_schematic_decoration({
	name = "xocean:tube2",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 28,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/tube2.mts",
})

register_schematic_decoration({
	name = "xocean:fire2",
	sidelen = 2,
	noise_params = {
		offset = 0.0001,
		scale = 0.001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 12,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/fire2.mts",
})

register_schematic_decoration({
	name = "xocean:tube3",
	sidelen = 1,
	noise_params = {
		offset = 0.0001,
		scale = 0.000001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 20,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/tube3.mts",
})

register_schematic_decoration({
	name = "xocean:brain3",
	sidelen = 1,
	noise_params = {
		offset = 0.0001,
		scale = 0.000001,
		spread = { x = 100000, y = 100000, z = 100000 },
		seed = 87112,
		octaves = 25,
		persist = 0.7,
	},
	schematic = minetest.get_modpath("xocean") .. "/schems/brain3.mts",
})

---------------------

register_coral_plant({
	name = "xocean:fire_plant_dead",
	decoration = "xocean:skeleton_fire",
})

register_coral_plant({
	name = "xocean:horn_plant_dead",
	decoration = "xocean:skeleton_horn",
})

register_coral_plant({
	name = "xocean:bubble_plant_skeleton",
	decoration = "xocean:skeleton_bubble",
})

register_coral_plant({
	name = "xocean:brain_plant_skeleton",
	decoration = "xocean:skeleton_brain",
})

register_coral_plant({
	name = "xocean:tube_plant",
	decoration = "xocean:skeleton_tube",
})

register_coral_plant({
	name = "xocean:fire_plant",
	decoration = "xocean:fire",
})

register_coral_plant({
	name = "xocean:horn_plant",
	decoration = "xocean:horn",
})

register_coral_plant({
	name = "xocean:bubble_plant",
	decoration = "xocean:bubble",
})

register_coral_plant({
	name = "xocean:brain_plant",
	decoration = "default:coral_pink",
})

register_coral_plant({
	name = "xocean:tube_plant",
	decoration = "default:coral_cyan",
})

register_simple_decoration({
	name = "xocean:pickle",
	place_on = { "default:sand" },
	noise_params = {
		offset = -0.04,
		scale = 0.04,
		spread = { x = 200, y = 200, z = 200 },
		seed = 87112,
		octaves = 3,
		persist = 0.7,
	},
	decoration = "xocean:pickle",
})

register_simple_decoration({
	name = "xocean:seagrass",
	place_on = { "default:sand" },
	noise_params = {
		offset = -0.04,
		scale = 0.4,
		spread = { x = 200, y = 200, z = 200 },
		seed = 87112,
		octaves = 3,
		persist = 0.7,
	},
	decoration = "xocean:seagrass",
})
