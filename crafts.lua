minetest.register_craft({
	type = "cooking",
	output = "xocean:ocean_stone",
	recipe = "xocean:ocean_cobble",
})

minetest.register_craft({
	output = "xocean:ocean_carved 4",
	recipe = {
		{ "xocean:ocean_stone", "xocean:ocean_stone" },
		{ "xocean:ocean_stone", "xocean:ocean_stone" },
	},
})

minetest.register_craft({
	output = "xocean:ocean_circular 4",
	recipe = {
		{ "xocean:ocean_carved", "xocean:ocean_carved" },
		{ "xocean:ocean_carved", "xocean:ocean_carved" },
	},
})

minetest.register_craft({
	output = "xocean:ocean_pillar 4",
	recipe = {
		{ "xocean:ocean_brick", "xocean:ocean_brick" },
		{ "xocean:ocean_brick", "xocean:ocean_brick" },
	},
})

minetest.register_craft({
	output = "xocean:ocean_brick 4",
	recipe = {
		{ "xocean:ocean_cobble", "xocean:ocean_cobble" },
		{ "xocean:ocean_cobble", "xocean:ocean_cobble" },
	},
})

minetest.register_craft({
	output = "xocean:sea_lantern 4",
	recipe = {
		{ "default:torch", "default:glass", "default:torch" },
		{ "default:glass", "bucket:bucket_water", "default:glass" },
		{ "default:torch", "default:glass", "default:torch" },
	},
	replacements = { { "bucket:bucket_water", "bucket:bucket_empty" } },
})

minetest.register_craft({
	output = "xocean:kelp_block 1",
	recipe = {
		{ "xocean:kelp", "xocean:kelp", "xocean:kelp" },
		{ "xocean:kelp", "xocean:kelp", "xocean:kelp" },
		{ "xocean:kelp", "xocean:kelp", "xocean:kelp" },
	},
})

minetest.register_craft({
	type = "cooking",
	output = "xocean:kelp",
	recipe = "default:sand_with_kelp",
})

minetest.register_craft({
	output = "xocean:sushi 1",
	recipe = {
		{ "xocean:fish_edible" },
		{ "xocean:kelp" },
	},
})
