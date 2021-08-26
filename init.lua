minetest.register_node("xocean:ocean_cobble", {
	description = "Ocean Cobblestone",
	tiles = {"xocean_cobble.png"},
	groups = {cracky=3},
})

minetest.register_node("xocean:ocean_stone", {
	description = "Ocean Stone",
	tiles = {"xocean_stone.png"},
	groups = {cracky=3},
	drop= "xocean:ocean_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "xocean:ocean_stone",
	recipe = "xocean:ocean_cobble",
})
---Spawn the stone
minetest.register_ore({
		ore_type        = "blob",
		ore             = "xocean:ocean_stone",
		wherein         = {"default:sand"},
		clust_scarcity  = 32 * 32 * 32,
		clust_size      = 8,
		y_min           = -15,
		y_max           = 0,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 8, y = 5, z = 8},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

minetest.register_node("xocean:ocean_carved", {
	description = "Carved Ocean Stone",
	tiles = {"xocean_carved.png"},
	groups = {cracky=2},
})

minetest.register_craft({
	output = '"xocean:ocean_carved" 4',
	recipe = {
		{'xocean:ocean_stone', 'xocean:ocean_stone',},
		{'xocean:ocean_stone', 'xocean:ocean_stone',},
		},
})

minetest.register_node("xocean:ocean_circular", {
	description = "Circular Ocean Stone",
	tiles = {"xocean_circular.png"},
	groups = {cracky=2},
})

minetest.register_craft({
	output = '"xocean:ocean_circular" 4',
	recipe = {
		{'xocean:ocean_carved', 'xocean:ocean_carved',},
		{'xocean:ocean_carved', 'xocean:ocean_carved',},
		},
})

minetest.register_node("xocean:ocean_pillar", {
	description = "Ocean Pillar",
	tiles = {"xocean_pillar.png"},
	groups = {cracky=2},
})

minetest.register_craft({
	output = '"xocean:ocean_pillar" 4',
	recipe = {
		{'xocean:ocean_brick', 'xocean:ocean_brick',},
		{'xocean:ocean_brick', 'xocean:ocean_brick',},
		},
})

minetest.register_node("xocean:ocean_brick", {
	description = "Ocean Brick",
	tiles = {"xocean_brick.png"},
	groups = {cracky=2},
})

minetest.register_craft({
	output = '"xocean:ocean_brick" 4',
	recipe = {
		{'xocean:ocean_cobble', 'xocean:ocean_cobble',},
		{'xocean:ocean_cobble', 'xocean:ocean_cobble',},
		},
})

minetest.register_node("xocean:sea_lantern", {
    description = "Sea Lantern",
    drawtype = "glasslike",
	light_source = 14,
    tiles = {"xocean_lantern.png"},
    paramtype = "light",
    is_ground_content = true,
    sunlight_propagates = true,
    sounds = default.node_sound_glass_defaults(),
    groups = {cracky=3,oddly_breakable_by_hand=3},
})

minetest.register_craft({
	output = '"xocean:sea_lantern" 4',
	recipe = {
		{'default:torch', 'default:glass', 'default:torch', },
		{'default:glass', 'bucket:bucket_water', 'default:glass', },
		{'default:torch', 'default:glass', 'default:torch', },
		},
		replacements = {{ "bucket:bucket_water", "bucket:bucket_empty"}}
})
---Sea stuff
minetest.register_node("xocean:kelp_block", {
	description = "Dried Kelp Block",
	tiles = {"xocean_kelp_block.png"},
	groups = {snappy=3},
	drop= "xocean:kelp 9",
})
minetest.register_craft({
	output = '"xocean:kelp_block" 1',
	recipe = {
		{'xocean:kelp', 'xocean:kelp', 'xocean:kelp', },
		{'xocean:kelp', 'xocean:kelp', 'xocean:kelp', },
		{'xocean:kelp', 'xocean:kelp', 'xocean:kelp', },
		},
})
minetest.override_item("default:sand_with_kelp", {
	description = "Kelp",
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_sand.png"},
	special_tiles = {{name = "default_kelp.png", tileable_vertical = true}},
	inventory_image = "xocean_kelp.png",
	wield_image = "xocean_kelp.png",
	paramtype = "light",
	paramtype2 = "leveled",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	sounds = default.node_sound_sand_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
			local node_ptu = minetest.get_node(pointed_thing.under)
			local def_ptu = minetest.registered_nodes[node_ptu.name]
			if def_ptu and def_ptu.on_rightclick then
				return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
					itemstack, pointed_thing)
			end
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end

		local height = math.random(4, 6)
		local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
		local node_top = minetest.get_node(pos_top)
		local def_top = minetest.registered_nodes[node_top.name]
		local player_name = placer:get_player_name()

		if def_top and def_top.liquidtype == "source" and
				minetest.get_item_group(node_top.name, "water") > 0 then
			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pos_top, player_name) then
				minetest.set_node(pos, {name = "default:sand_with_kelp",
					param2 = height * 16})
				if not (creative and creative.is_enabled_for
						and creative.is_enabled_for(player_name)) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})
minetest.register_craft({
	type = "cooking",
	output = "xocean:kelp",
	recipe = "default:sand_with_kelp",
})
minetest.register_craftitem("xocean:kelp", {
	description = "Dried Kelp",
	on_use = minetest.item_eat(1),
	inventory_image = "xocean_dried_kelp.png",
})
minetest.register_craftitem("xocean:sushi", {
	description = "Sushi",
	on_use = minetest.item_eat(6),
	inventory_image = "xocean_sushi.png",
})
minetest.register_craft({
	output = '"xocean:sushi" 1',
	recipe = {
		{'xocean:fish_edible'},
		{'xocean:kelp' },
		},
})
minetest.register_node("xocean:seagrass", {
	description = "Seagrass",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "xocean_grass.png", tileable_vertical = true}},
	inventory_image = "xocean_grass.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "default:sand" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:seagrass"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end,
})
minetest.register_craftitem("xocean:fish_edible", {
	description = "Tropical Fish",
	on_use = minetest.item_eat(3),
	inventory_image = "xocean_fish_edible.png",
})
minetest.register_node("xocean:pickle", {
	description = "Sea Pickle",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "xocean_pickle.png", tileable_vertical = true}},
	inventory_image = "xocean_pickle.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	light_source = 3,
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "default:sand" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:pickle"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end,
})
---Corals
minetest.register_node("xocean:brain_block", {
	description = "Brain Coral Block",
	tiles = {"xocean_coral_brain.png"},
	groups = {cracky = 3},
	drop = "xocean:brain_skeleton",
	sounds = default.node_sound_stone_defaults(),
})
minetest.override_item("default:coral_pink", {
	description = "Brain Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_brain.png"},
	special_tiles = {{name = "xocean_brain.png", tileable_vertical = true}},
	inventory_image = "xocean_brain.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "xocean:brain_block",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "xocean:brain_block" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "default:coral_pink"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:brain_block"})
	end,
})
minetest.register_node("xocean:brain_skeleton", {
	description = "Brain Coral Skeleton Block",
	tiles = {"xocean_coral_brain_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("xocean:skeleton_brain", {
	description = "Brain Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_brain_skeleton.png"},
	special_tiles = {{name = "xocean_brain_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_brain_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "xocean:brain_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "xocean:brain_skeleton" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:skeleton_brain"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:brain_skeleton"})
	end,
})
minetest.register_node("xocean:tube_block", {
	description = "Tube Coral Block",
	tiles = {"xocean_coral_tube.png"},
	groups = {cracky = 3},
	drop = "xocean:tube_skeleton",
	sounds = default.node_sound_stone_defaults(),
})
minetest.override_item("default:coral_cyan", {
	description = "Tube Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_tube.png"},
	special_tiles = {{name = "xocean_tube.png", tileable_vertical = true}},
	inventory_image = "xocean_tube.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "xocean:skeleton_tube",
	node_dig_prediction = "xocean:tube_block",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "xocean:tube_block" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "default:coral_cyan"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:tube_block"})
	end,
})
minetest.register_node("xocean:tube_skeleton", {
	description = "Tube Coral Skeleton Block",
	tiles = {"xocean_coral_tube_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("xocean:skeleton_tube", {
	description = "Tube Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_tube_skeleton.png"},
	special_tiles = {{name = "xocean_tube_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_tube_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "xocean:tube_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "xocean:tube_skeleton" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:skeleton_tube"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:tube_skeleton"})
	end,
})
minetest.register_node("xocean:bubble_block", {
	description = "Bubble Coral Block",
	tiles = {"xocean_coral_bubble.png"},
	groups = {cracky = 3},
	drop = "xocean:bubble_skeleton",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("xocean:bubble", {
	description = "Bubble Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	drop = "xocean:skeleton_bubble",
	paramtype = "light",
	tiles = {"xocean_coral_bubble.png"},
	special_tiles = {{name = "xocean_bubble.png", tileable_vertical = true}},
	inventory_image = "xocean_bubble.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "xocean:bubble_block",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "xocean:bubble_block" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:bubble"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:bubble_block"})
	end,
})
minetest.register_node("xocean:bubble_skeleton", {
	description = "Bubble Coral Skeleton Block",
	tiles = {"xocean_coral_bubble_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("xocean:skeleton_bubble", {
	description = "Bubble Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_bubble_skeleton.png"},
	special_tiles = {{name = "xocean_bubble_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_bubble_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "xocean:skeleton_bubble",
	node_dig_prediction = "xocean:bubble_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "xocean:bubble_skeleton" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:skeleton_bubble"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:bubble_skeleton"})
	end,
})
minetest.override_item("default:coral_brown", {
 	description = "Horn Coral Block",
	tiles = {"xocean_coral_horn.png"},
	groups = {cracky = 3},
	drop = "default:coral_skeleton",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("xocean:horn", {
	description = "Horn Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_horn.png"},
	special_tiles = {{name = "xocean_horn.png", tileable_vertical = true}},
	inventory_image = "xocean_horn.png",
	groups = {snappy = 3},
	drop = "xocean:skeleton_horn",
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "default:coral_brown",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "default:coral_brown" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:horn"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:horn_block"})
	end,
})
minetest.override_item("default:coral_skeleton", {
 	description = "Horn Coral Skeleton Block",
	tiles = {"xocean_coral_horn_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("xocean:skeleton_horn", {
	description = "Horn Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_horn_skeleton.png"},
	special_tiles = {{name = "xocean_horn_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_horn_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "xocean:skeleton_horn",
	node_dig_prediction = "xocean:horn_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		-- if minetest.get_node(pos_under).name ~= "xocean:horn_skeleton" or
		if minetest.get_node(pos_under).name ~= "default:coral_skeleton" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:skeleton_horn"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:horn_skeleton"})
	end,
})
minetest.override_item("default:coral_orange", {
 	description = "Fire Coral Block",
	tiles = {"xocean_coral_fire.png"},
	groups = {cracky = 3},
	drop = "xocean:fire_skeleton",
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("xocean:fire", {
	description = "Fire Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_fire.png"},
	special_tiles = {{name = "xocean_fire.png", tileable_vertical = true}},
	inventory_image = "xocean_fire.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "xocean:skeleton_fire",
	node_dig_prediction = "xocean:default:coral_orange",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "default:coral_orange" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:fire"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:coral_orange"})
	end,
})
minetest.register_node("xocean:fire_skeleton", {
 	description = "Fire Coral Skeleton Block",
	tiles = {"xocean_coral_fire_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("xocean:skeleton_fire", {
	description = "Fire Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_fire_skeleton.png"},
	special_tiles = {{name = "xocean_fire_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_fire_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "xocean:fire_skeleton",
	node_placement_prediction = "",
	sounds = default.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "xocean:fire_skeleton" or
				minetest.get_node(pos_above).name ~= "default:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "xocean:skeleton_fire"})
		if not (creative and creative.is_enabled_for(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "xocean:fire_skeleton"})
	end,
})
---Mapgen
minetest.register_decoration({
		name = "xocean:brain",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/brain.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:horn",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/horn.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:bubble",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/bubble.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:tube",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/tube.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:fire",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/fire.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:brain2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/brain2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:horn2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/horn2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:bubble2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/bubble2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:tube2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/tube2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:fire2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 12,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/fire2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:tube3",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 1  ,
		noise_params = {
			offset = 0.0001,
			scale = 0.000001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/tube3.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "xocean:brain3",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 1,
		noise_params = {
			offset = 0.0001,
			scale = 0.000001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 25,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/brain3.mts",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:seagrass",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.4,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:seagrass",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:fire_plant_dead",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:skeleton_fire",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:horn_plant_dead",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:skeleton_horn",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:bubble_plant_skeleton",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:skeleton_bubble",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:brain_plant_skeleton",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:skeleton_brain",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:tube_plant",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:skeleton_tube",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:fire_plant",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:fire",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:horn_plant",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:horn",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:bubble_plant",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:bubble",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:brain_plant",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "default:coral_pink",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:tube_plant",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "default:coral_cyan",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "xocean:pickle",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.04,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -8,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:pickle",
		param2 = 48,
		param2_max = 96,
	})
---Mobs
if minetest.get_modpath("mobs") then
local l_water_level		= minetest.setting_get("water_level") - 2
	mobs:register_mob("xocean:dolphin", {
		type = "animal",
		attack_type = "dogfight",
		damage = 1,
		visual_size = {x = 15, y = 15, z= 15},
		reach = 3,
		hp_min = 20,
		hp_max = 20,
		armor = 100,
		collisionbox = {-0.75, -0.5, -0.75, 0.75, 0.5, 0.75},
		visual = "mesh",
		mesh = "dolphin.b3d",
		textures = {
			{"mobs_dolphin.png"}
		},
		drops = {
        {name = "mobs:meat_raw", chance = 1, min = 2, max = 4},
    },
		makes_footstep_sound = false,
		walk_velocity = 4,
		run_velocity = 6,
		fly = true,
		fly_in = "default:water_source",
		jump = false,
		stepheight = 0.1,
		fall_speed = 0,
		rotate = 90,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		jump = false,
		stepheight = 0.1,
		light_damage = 0,
		animation = {
		speed_normal = 15,
	    speed_run = 25,
		stand_start = 40,
		stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
	})
	mobs:spawn_specific("xocean:dolphin",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	5, 20, 30, 10000, 2, -31000, l_water_level)
	mobs:register_egg("xocean:dolphin", "Dolphin", "xocean_stone.png", 1)
	
mobs:register_mob("xocean:fish", {
		type = "animal",
		hp_min = 5,
		hp_max = 5,
		armor = 100,
		visual_size = {x = 2, y = 2, z= 2},
		collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25},
		visual = "mesh",
		mesh = "fishy.b3d",
		textures = {
			{"mobs_fishy.png"},
			{"mobs_fishy1.png"},
			{"mobs_fishy2.png"},
			{"mobs_fishy3.png"}
		},
		drops = {
        {name = "xocean:fish_edible", chance = 1, min = 1, max = 1},
    },
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 3,
		fly = true,
		fly_in = "default:water_source",
		jump = false,
		stepheight = 0.1,
		fall_speed = 0,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
		speed_normal = 15,
	    speed_run = 25,
		stand_start = 40,
		stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
	})
	mobs:spawn_specific("xocean:fish",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	2, 20, 30, 10000, 5, -31000, l_water_level)
	mobs:register_egg("xocean:fish", "Tropical Fish (Kob)", "xocean_fish.png", 0)
mobs:register_mob("xocean:fish2", {
		type = "animal",
		hp_min = 5,
		hp_max = 5,
		armor = 100,
		visual_size = {x = 2, y = 2, z= 2},
		collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25},
		visual = "mesh",
		mesh = "fishy.b3d",
		textures = {
			{"mobs_fishy4.png"},
			{"mobs_fishy5.png"},
			{"mobs_fishy6.png"}
		},
		drops = {
        {name = "xocean:fish_edible", chance = 2, min = 1, max = 2},
    },
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 3,
		fly = true,
		fly_in = "default:water_source",
		jump = false,
		stepheight = 0.1,
		fall_speed = 0,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
		speed_normal = 15,
	    speed_run = 25,
		stand_start = 40,
		stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
	})
	mobs:spawn_specific("xocean:fish2",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	2, 20, 30, 10000, 5, -31000, l_water_level)
	mobs:register_egg("xocean:fish2", "Tropical Fish (SunStreak)", "xocean_fish2.png", 0)
	
mobs:register_mob("xocean:fish3", {
		type = "animal",
		hp_min = 5,
		hp_max = 5,
		armor = 100,
		visual_size = {x = 2, y = 2, z= 2},
		collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25},
		visual = "mesh",
		mesh = "fishy.b3d",
		textures = {
			{"mobs_fishy7.png"},
			{"mobs_fishy8.png"},
			{"mobs_fishy9.png"}
		},
		drops = {
        {name = "xocean:fish_edible", chance = 2, min = 1, max = 2},
    },
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 3,
		fly = true,
		fly_in = "default:water_source",
		jump = false,
		stepheight = 0.1,
		fall_speed = 0,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
		speed_normal = 15,
	    speed_run = 25,
		stand_start = 40,
		stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
	})
	mobs:spawn_specific("xocean:fish3",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	2, 20, 30, 10000, 5, -31000, l_water_level)
	mobs:register_egg("xocean:fish3", "Tropical Fish (Dasher)", "xocean_fish3.png", 0)
	
mobs:register_mob("xocean:fish4", {
		type = "animal",
		hp_min = 5,
		hp_max = 5,
		armor = 100,
		visual_size = {x = 2, y = 2, z= 2},
		collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25},
		visual = "mesh",
		mesh = "fishy.b3d",
		textures = {
			{"mobs_fishy10.png"},
			{"mobs_fishy11.png"},
			{"mobs_fishy12.png"}
		},
		drops = {
        {name = "xocean:fish_edible", chance = 2, min = 1, max = 2},
    },
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 3,
		fly = true,
		fly_in = "default:water_source",
		jump = false,
		stepheight = 0.1,
		fall_speed = 0,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
		speed_normal = 15,
	    speed_run = 25,
		stand_start = 40,
		stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
	})
	mobs:spawn_specific("xocean:fish4",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	2, 20, 30, 10000, 5, -31000, l_water_level)
	mobs:register_egg("xocean:fish4", "Tropical Fish (Snapper)", "xocean_fish4.png", 0)
end