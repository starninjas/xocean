local S = xocean.S
local l_water_level = (tonumber(minetest.settings:get("water_level")) or 1) - 2

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
