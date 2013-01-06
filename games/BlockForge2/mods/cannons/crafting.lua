--  _______  _______  _        _        _______  _        _______ 
-- (  ____ \(  ___  )( (    /|( (    /|(  ___  )( (    /|(  ____ \
-- | (    \/| (   ) ||  \  ( ||  \  ( || (   ) ||  \  ( || (    \/
-- | |      | (___) ||   \ | ||   \ | || |   | ||   \ | || (_____ 
-- | |      |  ___  || (\ \) || (\ \) || |   | || (\ \) |(_____  )
-- | |      | (   ) || | \   || | \   || |   | || | \   |      ) |
-- | (____/\| )   ( || )  \  || )  \  || (___) || )  \  |/\____) |
-- (_______/|/     \||/    )_)|/    )_)(_______)|/    )_)\_______)
--                                                                                    
-- Author: Riccardo B. <riccardo@cryptolab.net>
-- License: Gnu GPL v3
-- Description: Small mod for adding cannons to minetest.
-- Homepage: http://forkforge.net/proj.13
-- Requirements: https://github.com/BlockforgeProject/BlockForge-2-/
--
--
-- Thanks to LorenzoVulcan (https://github.com/BlockforgeProject/) for Crafting Recipes

minetest.register_craftitem(modname..":uno", {
	description = "Simple Cannon",
	inventory_image = "cannon1inv.png",
	wield_image = "cannon1inv.png",
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		minetest.env:add_entity(pointed_thing.above, modname..":uno")
		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_craftitem(bombs.explosive.item, {
	description = "Explosive Ammunition",
	inventory_image = "explosiveammo.png",
	wield_image = "explosiveammo.png",	
})

minetest.register_craftitem(bombs.timer.item, {
	description = "Explosive Ammunition with Timer",
	inventory_image = "timerammo.png",
	wield_image = "timerammo.png",	
})


------------------------------------------------------------------------
minetest.register_craftitem(modname..":obsidian_rod", {
	description = "Obsidian Rod",
	inventory_image = "obsidian_rod.png",
})
------------------------------------------------------------------------
minetest.register_craftitem(modname..":cobble_wheel", {
	description = "Cobble Wheel",
	inventory_image = "cobble_wheel.png",
})

minetest.register_craft({
	output = modname..':cobble_wheel 3',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', '', 'default:cobble'},
		{'', 'default:cobble', ''},
	}
})
minetest.register_craft({
	output = modname..':obsidian_rod',
	recipe = {
		{'lulzpack:obsidian_plate', '', 'lulzpack:obsidian_plate'},
		{'lulzpack:obsidian_plate', '', 'lulzpack:obsidian_plate'},
	}
})

minetest.register_craft({
	output = modname..':explosiveammo 6',
	recipe = {
		{'', 'lulzpack:hotstone', ''},
		{'lulzpack:hotstone', 'lulzpack:dintled_celisblock', 'lulzpack:hotstone'},
		{'', 'lulzpack:hotstone', ''},
	}
})

minetest.register_craft({
	output = modname..':timerammo 3',
	recipe = {
		{'', 'lulzpack:obsidian_bucket_meltediron', ''},
		{'lulzpack:redyz_ingot', 'lulzpack:dintled_celisblock', 'lulzpack:redyz_ingot'},
		{'', 'lulzpack:obsidian_bucket_meltediron', ''},
	}
})


minetest.register_craft({
	output = modname..':uno',
	recipe = {
		{'', modname..':obsidian_rod', modname..':obsidian_rod'},
		{'lulzpack:dintled_steelblock', 'lulzpack:dintled_steelblock','lulzpack:dintled_steelblock'},
		{modname..':cobble_wheel', '',modname..':cobble_wheel'},
	}
})
