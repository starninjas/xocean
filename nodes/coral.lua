local S = xocean.S

local function register_coral(block_name, block_def, skeleton_name, skeleton_def, rooted_name, rooted_def, rooted_skeleton_name, rooted_skeleton_def)
	block_def.tiles, block_def.tile = {block_def.tile}, nil
	block_def.groups = { cracky = 3, coral = 1 }
	block_def.sounds = default.node_sound_stone_defaults()
	block_def.drop = skeleton_name

	skeleton_def.tiles, skeleton_def.tile = {skeleton_def.tile}, nil
	skeleton_def.groups = { cracky = 3, coral = 1 }
	skeleton_def.sounds = default.node_sound_stone_defaults()

	rooted_def.tiles, rooted_def.tile = {rooted_def.tile}, nil
	rooted_def.special_tiles, rooted_def.special_tile = { { name = rooted_def.special_tile, tileable_vertical = true } }, nil
	rooted_def.drawtype = "plantlike_rooted"
	rooted_def.waving = 1
	rooted_def.paramtype = "light"
	rooted_def.groups = { snappy = 3, coral = 1 }
	rooted_def.selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
			{ -4 / 16, 0.5, -4 / 16, 4 / 16, 1.5, 4 / 16 },
		},
	}
	rooted_def.node_dig_prediction = block_name
	rooted_def.node_placement_prediction = ""
	rooted_def.sounds = default.node_sound_stone_defaults({
		dig = { name = "default_dig_snappy", gain = 0.2 },
		dug = { name = "default_grass_footstep", gain = 0.25 },
	})
	rooted_def.drop = rooted_skeleton_name
	rooted_def.on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = vector.new(pos_under.x, pos_under.y + 1, pos_under.z)

		if minetest.is_protected(pos_under, player_name) or minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, S("Node is protected"))
			return
		end

		local node_under = minetest.get_node(pos_under)
		local node_above = minetest.get_node(pos_above)

		if node_under.name ~= block_name or node_above.name ~= "default:water_source" then
			return
		end

		minetest.set_node(pos_under, { name = rooted_name })

		if not minetest.is_creative_enabled(player_name) then
			itemstack:take_item()
			return itemstack
		end
	end
	rooted_def.after_destruct = function(pos, oldnode)
		minetest.set_node(pos, { name = block_name })
	end

	rooted_skeleton_def.tiles, rooted_skeleton_def.tile = {rooted_skeleton_def.tile}, nil
	rooted_skeleton_def.special_tiles, rooted_skeleton_def.special_tile = { { name = rooted_skeleton_def.special_tile, tileable_vertical = true } }, nil
	rooted_skeleton_def.drawtype = "plantlike_rooted"
	rooted_skeleton_def.waving = 1
	rooted_skeleton_def.paramtype = "light"
	rooted_skeleton_def.groups = { snappy = 3, coral = 1 }
	rooted_skeleton_def.selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
			{ -4 / 16, 0.5, -4 / 16, 4 / 16, 1.5, 4 / 16 },
		},
	}
	rooted_skeleton_def.node_dig_prediction = skeleton_name
	rooted_skeleton_def.node_placement_prediction = ""
	rooted_skeleton_def.sounds = default.node_sound_stone_defaults({
		dig = { name = "default_dig_snappy", gain = 0.2 },
		dug = { name = "default_grass_footstep", gain = 0.25 },
	})
	rooted_skeleton_def.on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = vector.new(pos_under.x, pos_under.y + 1, pos_under.z)

		if minetest.is_protected(pos_under, player_name) or minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, S("Node is protected"))
			return
		end

		local node_under = minetest.get_node(pos_under)
		local node_above = minetest.get_node(pos_above)

		if node_under.name ~= skeleton_name or node_above.name ~= "default:water_source" then
			return
		end

		minetest.set_node(pos_under, { name = rooted_skeleton_name })

		if not minetest.is_creative_enabled(player_name) then
			itemstack:take_item()
			return itemstack
		end
	end
	rooted_skeleton_def.after_destruct = function(pos, oldnode)
		minetest.set_node(pos, { name = skeleton_name })
	end

	for _, things in ipairs({{block_name, block_def}, {skeleton_name, skeleton_def}, {rooted_name, rooted_def}, {rooted_skeleton_name, rooted_skeleton_def}}) do
		local name, def = unpack(things)
		if minetest.registered_nodes[name] then
			minetest.override_item(name, def)

		else
			minetest.register_node(name, def)
		end
	end
end

register_coral("xocean:brain_block", {
	description = S("Brain Coral Block"),
	tile = "xocean_coral_brain.png",
}, "xocean:brain_skeleton", {
	description = S("Brain Coral Skeleton Block"),
	tile = "xocean_coral_brain_skeleton.png",
}, "default:coral_pink", {
	description = S("Brain Coral"),
	tile = "xocean_coral_brain.png",
	special_tile = "xocean_brain.png",
	inventory_image = "xocean_brain.png",
}, "xocean:skeleton_brain", {
	description = S("Brain Coral Skeleton"),
	tile = "xocean_coral_brain_skeleton.png",
	special_tile = "xocean_brain_skeleton.png",
	inventory_image = "xocean_brain_skeleton.png",
})

register_coral("xocean:tube_block", {
	description = S("Tube Coral Block"),
	tile = "xocean_coral_tube.png",
}, "xocean:tube_skeleton", {
	description = S("Tube Coral Skeleton Block"),
	tile = "xocean_coral_tube_skeleton.png",
}, "default:coral_cyan", {
	description = S("Tube Coral"),
	tile = "xocean_coral_tube.png",
	special_tile = "xocean_tube.png",
	inventory_image = "xocean_tube.png",
}, "xocean:skeleton_tube", {
	description = S("Tube Coral Skeleton"),
	tile = "xocean_coral_tube_skeleton.png",
	special_tile = "xocean_tube_skeleton.png",
	inventory_image = "xocean_tube_skeleton.png",
})

register_coral("xocean:bubble_block", {
	description = S("Bubble Coral Block"),
	tile = "xocean_coral_bubble.png",
}, "xocean:bubble_skeleton", {
	description = S("Bubble Coral Skeleton Block"),
	tile = "xocean_coral_bubble_skeleton.png",
}, "xocean:bubble", {
	description = S("Bubble Coral"),
	tile = "xocean_coral_bubble.png",
	special_tile = "xocean_bubble.png",
	inventory_image = "xocean_bubble.png",
}, "xocean:skeleton_bubble", {
	description = S("Bubble Coral Skeleton"),
	tile = "xocean_coral_bubble_skeleton.png",
	special_tile = "xocean_bubble_skeleton.png",
	inventory_image = "xocean_bubble_skeleton.png",
})

register_coral("default:coral_brown", {
	description = S("Horn Coral Block"),
	tile = "xocean_coral_horn.png",
}, "xocean:horn_skeleton", {
	description = S("Horn Coral Skeleton Block"),
	tile = "xocean_coral_horn_skeleton.png",
}, "xocean:horn", {
	description = S("Horn Coral"),
	tile = "xocean_coral_horn.png",
	special_tile = "xocean_horn.png",
	inventory_image = "xocean_horn.png",
}, "xocean:skeleton_horn", {
	description = S("Horn Coral Skeleton"),
	tile = "xocean_coral_horn_skeleton.png",
	special_tile = "xocean_horn_skeleton.png",
	inventory_image = "xocean_horn_skeleton.png",
})

register_coral("default:coral_orange", {
	description = S("Fire Coral Block"),
	tile = "xocean_coral_fire.png",
}, "xocean:fire_skeleton", {
	description = S("Fire Coral Skeleton Block"),
	tile = "xocean_coral_fire_skeleton.png",
}, "xocean:fire", {
	description = S("Fire Coral"),
	tile = "xocean_coral_fire.png",
	special_tile = "xocean_fire.png",
	inventory_image = "xocean_fire.png",
}, "xocean:skeleton_fire", {
	description = S("Fire Coral Skeleton"),
	tile = "xocean_coral_fire_skeleton.png",
	special_tile = "xocean_fire_skeleton.png",
	inventory_image = "xocean_fire_skeleton.png",
})
