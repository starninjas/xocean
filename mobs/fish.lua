local S = xocean.S
local l_water_level = (tonumber(minetest.settings:get("water_level")) or 1) - 2

-- Can the mob swim in this node? (same rule as Mobs Redo for fly_in: a name, or a list of names
-- and "group:" entries)
local function swimmable(self, name)
	local fly_in = self.fly_in
	if type(fly_in) ~= "table" then
		return name == fly_in
	end
	for _, entry in ipairs(fly_in) do
		if entry == name or (entry:sub(1, 6) == "group:"
				and minetest.get_item_group(name, entry:sub(7)) > 0) then
			return true
		end
	end
	return false
end

local function swimmable_at(self, pos)
	return swimmable(self, minetest.get_node(vector.round(pos)).name)
end

-- Mobs Redo never stops a swimming mob at the edge of its water: it keeps its speed (vertical
-- speed included) and only steers it back once per second, while air damage is also applied once
-- per second. Fish (5 hp, air_damage 8) therefore die as soon as they swim through the surface
-- or onto a beach. Every step, stop the rise before the surface and turn back before the shore.
local function keep_in_water(self)
	if self.health <= 0 then
		return
	end
	local pos = self.object:get_pos()
	local vel = self.object:get_velocity()
	if not pos or not vel or not swimmable_at(self, pos) then
		return -- already out of the water: Mobs Redo handles it (flop, air damage)
	end

	local changed = false
	-- vertical: half a node of margin, enough to keep the whole body under the surface
	if vel.y ~= 0 and not swimmable_at(self, vector.offset(pos, 0, vel.y > 0 and 0.5 or -0.5, 0)) then
		vel.y = 0
		changed = true
	end

	-- horizontal: look 0.75 node ahead in the direction of travel
	local speed = math.sqrt(vel.x * vel.x + vel.z * vel.z)
	if speed > 0.05 and not swimmable_at(self,
			vector.offset(pos, vel.x / speed * 0.75, 0, vel.z / speed * 0.75)) then
		-- turn back (set_velocity moves along yaw + rotate), cancelling any smooth rotation
		self.delay = 0
		self:set_yaw(math.atan2(vel.x, -vel.z) - (self.rotate or 0) + math.random() - 0.5, 0)
		self.object:set_velocity(vel) -- keep the vertical fix before set_velocity reads it
		self:set_velocity(speed)
		return
	end

	if changed then
		self.object:set_velocity(vel)
	end
end

local function register_fish(name, def)
	def.type = "animal"
	def.hp_min = 5
	def.hp_max = 5
	def.armor = 100
	def.visual_size = {x = 2, y = 2, z = 2}
	def.collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25}
	def.visual = "mesh"
	def.mesh = "fishy.b3d"
	def.stay_near = {nodes = "group:coral", chance = 5}
	def.makes_footstep_sound = false
	def.walk_velocity = 2
	def.run_velocity = 3
	def.fly = true
	def.fly_in = "default:water_source"
	def.jump = false
	def.stepheight = 0 -- Mobs Redo defaults to 1.1: fish would climb up beaches, step by step
	def.do_custom = keep_in_water
	def.fall_speed = 0
	def.view_range = 30
	def.water_damage = 0
	def.lava_damage = 10
	def.air_damage = 8
	def.light_damage = 0
	def.animation = {
		speed_normal = 15,
		speed_run = 25,
		stand_start = 40,
		stand_end = 100,
		walk_start = 40,
		walk_end = 100,
		run_start = 40,
		run_end = 100,
	}

	mobs:register_mob(name, def)

	if not xocean.custom_spawn then
		mobs:spawn_specific(
			name,
			{"default:water_source"},
			{"default:water_flowing", "default:water_source"},
			2,
			20,
			30,
			10000,
			5,
			-31000,
			l_water_level
		)
	end
end

register_fish("xocean:fish", {
	textures = {
		{"mobs_fishy.png"},
		{"mobs_fishy1.png"},
		{"mobs_fishy2.png"},
		{"mobs_fishy3.png"},
	},
	drops = {
		{name = "xocean:fish_edible", chance = 1, min = 1, max = 1},
	},
})
mobs:register_egg("xocean:fish", S("Tropical Fish (Kob)"), "xocean_fish.png", 0)

register_fish("xocean:fish2", {
	textures = {
		{"mobs_fishy4.png"},
		{"mobs_fishy5.png"},
		{"mobs_fishy6.png"},
	},
	drops = {
		{name = "xocean:fish_edible", chance = 2, min = 1, max = 2},
	},
})
mobs:register_egg("xocean:fish2", S("Tropical Fish (SunStreak)"), "xocean_fish2.png", 0)

register_fish("xocean:fish3", {
	textures = {
		{"mobs_fishy7.png"},
		{"mobs_fishy8.png"},
		{"mobs_fishy9.png"},
	},
	drops = {
		{name = "xocean:fish_edible", chance = 2, min = 1, max = 2},
	},
})
mobs:register_egg("xocean:fish3", S("Tropical Fish (Dasher)"), "xocean_fish3.png", 0)

register_fish("xocean:fish4", {
	textures = {
		{"mobs_fishy10.png"},
		{"mobs_fishy11.png"},
		{"mobs_fishy12.png"},
	},
	drops = {
		{name = "xocean:fish_edible", chance = 2, min = 1, max = 2},
	},
})
mobs:register_egg("xocean:fish4", S("Tropical Fish (Snapper)"), "xocean_fish4.png", 0)
