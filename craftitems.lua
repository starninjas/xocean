local S = xocean.S

minetest.register_craftitem("xocean:kelp", {
	description = S("Dried Kelp"),
	on_use = minetest.item_eat(1),
	inventory_image = "xocean_dried_kelp.png",
})

minetest.register_craftitem("xocean:sushi", {
	description = S("Sushi"),
	on_use = minetest.item_eat(6),
	inventory_image = "xocean_sushi.png",
})

minetest.register_craftitem("xocean:fish_edible", {
	description = S("Tropical Fish"),
	on_use = minetest.item_eat(3),
	inventory_image = "xocean_fish_edible.png",
})
