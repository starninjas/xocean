local S = xocean.S

minetest.register_node("xocean:sea_lantern", {
	description = S("Sea Lantern"),
	drawtype = "glasslike",
	light_source = 14,
	tiles = { "xocean_lantern.png" },
	paramtype = "light",
	is_ground_content = true,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = { cracky = 3, oddly_breakable_by_hand = 3 },
})

minetest.register_node("xocean:kelp_block", {
	description = S("Dried Kelp Block"),
	tiles = { "xocean_kelp_block.png" },
	groups = { snappy = 3 },
	drop = "xocean:kelp 9",
})
