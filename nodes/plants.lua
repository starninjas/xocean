local S = xocean.S

local function register_plant(name, def)
	def.drawtype = "plantlike_rooted"
	def.waving = 1
	def.tiles = { "default_sand.png" }
	def.paramtype = "light"
	def.groups = { snappy = 3 }
	def.node_dig_prediction = "default:sand"
	def.node_placement_prediction = ""
	def.sounds = default.node_sound_sand_defaults({
		dig = { name = "default_dig_snappy", gain = 0.2 },
		dug = { name = "default_grass_footstep", gain = 0.25 },
	})
	def.after_destruct = function(pos, oldnode)
		minetest.set_node(pos, { name = "default:sand" })
	end
	def.on_place = def.on_place or function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above
		local node_under = minetest.get_node(pos_under)
		local node_above = minetest.get_node(pos_above)

		if minetest.is_player(placer) and not placer:get_player_control().sneak then
			local def_under = minetest.registered_nodes[node_under.name]
			if def_under and def_under.on_rightclick then
				return def_under.on_rightclick(pointed_thing.under, node_under, placer, itemstack, pointed_thing)
			end
		end

		local player_name = placer:get_player_name()

		if node_under.name ~= "default:sand" or node_above.name ~= "default:water_source" then
			return
		end

		if minetest.is_protected(pos_under, player_name) or minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, S("Node is protected"))
			return
		end

		minetest.set_node(pos_under, { name = itemstack:get_name() })

		if not minetest.is_creative_enabled(player_name) then
			itemstack:take_item()
		end

		return itemstack
	end
	minetest.register_node(name, def)
end

minetest.override_item("default:sand_with_kelp", {
	description = S("Kelp"),
	special_tiles = { { name = "default_kelp.png", tileable_vertical = true } },
	inventory_image = "xocean_kelp.png",
	wield_image = "xocean_kelp.png",
	paramtype2 = "leveled",
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
			{ -2 / 16, 0.5, -2 / 16, 2 / 16, 3.5, 2 / 16 },
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

		local pos_under = pointed_thing.under
		local node_under = minetest.get_node(pos_under)

		if minetest.is_player(placer) and not placer:get_player_control().sneak then
			local def_under = minetest.registered_nodes[node_under.name]
			if def_under and def_under.on_rightclick then
				return def_under.on_rightclick(pointed_thing.under, node_under, placer, itemstack, pointed_thing)
			end
		end

		local player_name = placer:get_player_name()

		if node_under.name ~= "default:sand" then
			return
		end

		if minetest.is_protected(pos_under, player_name) then
			minetest.chat_send_player(player_name, S("Node is protected"))
			return
		end

		local height = math.random(4, 6)
		local can_place = true

		for i = 1, height do
			local pos_above = vector.new(pos_under.x, pos_under.y + i, pos_under.z)
			local name_above = minetest.get_node(pos_above).name
			local def_above = minetest.registered_nodes[name_above] or {}
			if (
				def_above.liquidtype ~= "source" or
				minetest.get_item_group(name_above, "water") == 0 or
				minetest.is_protected(pos_above, player_name)
			) then
				can_place = false
				break
			end
		end

		if can_place then
			minetest.set_node(pos_under, {name = "default:sand_with_kelp", param2 = height * 16 })

			if not minetest.is_creative_enabled(player_name) then
				itemstack:take_item()
				return itemstack
			end
		else
			minetest.chat_send_player(player_name, S("Node is protected"))
		end
	end
})

register_plant("xocean:seagrass", {
	description = S("Seagrass"),
	special_tiles = { { name = "xocean_grass.png", tileable_vertical = true } },
	inventory_image = "xocean_grass.png",
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
			{ -4 / 16, 0.5, -4 / 16, 4 / 16, 1.5, 4 / 16 },
		},
	},
})

register_plant("xocean:pickle", {
	description = S("Sea Pickle"),
	special_tiles = { { name = "xocean_pickle.png", tileable_vertical = true } },
	inventory_image = "xocean_pickle.png",
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
			{ -4 / 16, 0.5, -4 / 16, 4 / 16, 1.5, 4 / 16 },
		},
	},
	light_source = 3,
})
