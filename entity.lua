
local S = core.get_translator(cmer_skeleton.modname)

local bones_sound, death_sound
if core.global_exists("sounds") then
	if sounds.skeleton then
		bones_sound = sounds.skeleton:get(1)
	end
	if sounds.zombie_death then
		death_sound = sounds.zombie_death:get(1)
	end
end


local mob_name = "creatures:skeleton"

local base_def = {
	name = mob_name,
	nametag = S("Skeleton"),
	hp_min = 55,
	hp_max = 55,
	hostile = true,
	knockback = true,
	sneaky = false,
	floats = true,
	stepheight = 1,
	collisionbox = {-0.25, -0.01, -0.25, 0.25, 1.65, 0.25},
	rotation = -90.0,
	mesh = "creatures_zombie.b3d",
	textures = {"cmer_skeleton_mesh.png"},
	drops = {
		{name="creatures:bone", min=1, max=1, chance=1},
	},
	spawn = {
		interval = cmer_skeleton.spawn_interval,
		chance = cmer_skeleton.spawn_chance,
		nodes = {
			"group:sand",
			"group:stone",
			"nether:rack",
			"nether:rack_deep",
		},
		light_range = {min=0, max=8},
		height_range = {min=-31000, max=31000},
		count = {min=1, max=2},
	},
	combat = {
		radius = 2.0,
		damage = 13,
		chance = 100,
	},
	speed = {
		walk = 1,
		run = 3,
	},
	search = {
		radius = 20,
		target = "player",
	},
	mode_chance = {
		idle = 0.3,
		walk = 0.7,
	},
	sounds = {
		random = bones_sound,
		death = death_sound,
		war_cry = nil,
		attack = nil,
		damage = nil,
	},
	animation = {
		idle = {start=0, stop=80, speed=15},
		walk = {start=102, stop=122, speed=15.5},
		run = {},
		attack = {start=102, stop=122, speed=25},
		death = {start=81, stop=101, speed=28, loop=false, rotate=false, duration=2.12},
	},
}

dofile(cmer_skeleton.modpath .. "/register/" .. cmer_skeleton.lib .. ".lua")(base_def)


if core.global_exists("asm") then
	asm.addEgg({
		name = "skeleton",
		title = S("Skeleton"),
		inventory_image = "cmer_skeleton_inv.png",
		spawn = mob_name,
		ingredients = "creatures:bone",
	})
end
if not core.registered_items["creatures:skeleton"] then
	core.register_alias("creatures:skeleton", "spawneggs:skeleton")
end


core.register_craftitem(":creatures:bone", {
	description = S("Bone"),
	inventory_image = "cmer_skeleton_bone.png",
	stack_max = 99,
})
if not core.registered_items["cmer:bone"] then
	core.register_alias("cmer:bone", "creatures:bone")
end
