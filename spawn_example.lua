
--[[ Spawn Template, defaults to values shown if line not provided

mobs:spawn({

	name = "",

		- Name of mob, must be provided e.g. "mymod:my_mob"

	nodes = {"group:soil, "group:stone"},

		- Nodes to spawn on top of.

	neighbors = {"air"},

		- Nodes to spawn beside.

	min_light = 0,

		- Minimum light level.

	max_light = 15,

		- Maximum light level, 15 is sunlight only.

	interval = 30,

		- Spawn interval in seconds.

	chance = 5000,

		- Spawn chance, 1 in every 5000 nodes.

	active_object_count = 1,

		- Active mobs of this type in area.

	min_height = -31000,

		- Minimum height level.

	max_height = 31000,

		- Maximum height level.

	day_toggle = nil,

		- Daytime toggle, true to spawn during day, false for night, nil for both

	on_spawn = nil,

		- On spawn function to run when mob spawns in world

	on_map_load = nil,

		- On map load, when true mob only spawns in newly generated map areas
})
]]--

mobs:spawn({
	name = "xocean:dolphin",
	nodes = {"default:water_source"},
	neighbors = {"default:water_flowing", "default:water_source"},
	interval = 30,
	chance = 1000,
	active_object_count = 5,
	min_height = -20,
	max_height = 0,
})

mobs:spawn({
	name = "xocean:fish",
	nodes = {"default:water_source"},
	neighbors = {"default:water_flowing", "default:water_source"},
	interval = 30,
	chance = 1000,
	active_object_count = 5,
	min_height = -20,
	max_height = 0,
})

mobs:spawn({
	name = "xocean:fish2",
	nodes = {"default:water_source"},
	neighbors = {"default:water_flowing", "default:water_source"},
	interval = 30,
	chance = 1000,
	active_object_count = 5,
	min_height = -20,
	max_height = 0,
})

mobs:spawn({
	name = "xocean:fish3",
	nodes = {"default:water_source"},
	neighbors = {"default:water_flowing", "default:water_source"},
	interval = 30,
	chance = 1000,
	active_object_count = 5,
	min_height = -20,
	max_height = 0,
})

mobs:spawn({
	name = "xocean:fish4",
	nodes = {"default:water_source"},
	neighbors = {"default:water_flowing", "default:water_source"},
	interval = 30,
	chance = 1000,
	active_object_count = 5,
	min_height = -20,
	max_height = 0,
})
