minetest.register_node("xocean:ocean_stone", {
	description = "Ocean Stone",
	tiles = { "xocean_stone.png" },
	groups = { cracky = 3 },
	drop = "xocean:ocean_cobble",
})

minetest.register_node("xocean:ocean_cobble", {
	description = "Ocean Cobblestone",
	tiles = { "xocean_cobble.png" },
	groups = { cracky = 3 },
})

minetest.register_node("xocean:ocean_carved", {
	description = "Carved Ocean Stone",
	tiles = { "xocean_carved.png" },
	groups = { cracky = 2 },
})

minetest.register_node("xocean:ocean_circular", {
	description = "Circular Ocean Stone",
	tiles = { "xocean_circular.png" },
	groups = { cracky = 2 },
})

minetest.register_node("xocean:ocean_pillar", {
	description = "Ocean Pillar",
	tiles = { "xocean_pillar.png" },
	groups = { cracky = 2 },
})

minetest.register_node("xocean:ocean_brick", {
	description = "Ocean Brick",
	tiles = { "xocean_brick.png" },
	groups = { cracky = 2 },
})
