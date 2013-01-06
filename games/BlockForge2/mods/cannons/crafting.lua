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
