
-- Cannon 1
local cannon1 = {
	physical = true,
	collisionbox = {-1.5,.5,-1.5, 1.5,4,1.5},
	visual = "mesh",
	mesh = "cannon1.x",
	textures={"cannon1.png"},

	on_rightclick = function(self, clicker) 
	    for k,v in pairs(bombs) do
		    if clicker:get_wielded_item():get_name()==v.item then
                clicker:get_inventory():remove_item("main", v.item)
                local pos=self.object:getpos()
                minetest.sound_play("biggun1", {pos=pos, gain=1.5, max_hear_distance=2*64})
                local dir=clicker:get_look_dir()
                self.object:setyaw(clicker:get_look_yaw()+30-0.09)
	            shot(dir,pos,v.name,v.gravity,v.velocity)
	            break
	        end
	    end
	end,
	
	on_punch = function(self,puncher, time_from_last_punch, tool_capabilities, direction) 
	    self.object:remove()
	    if puncher and puncher:is_player() then
		    puncher:get_inventory():add_item("main", modname..":uno")
	    end
	end,
}
minetest.register_entity(modname..":uno", cannon1)


function shot(dir,pos,entity,gravity,velocity)
    local obj=minetest.env:add_entity({x=pos.x,y=pos.y+1.5,z=pos.z}, entity)
    obj:setvelocity({x=dir.x*velocity, y=dir.y*velocity, z=dir.z*velocity})
    obj:setacceleration({x=dir.x*-3, y=-gravity, z=dir.z*-3})
end
