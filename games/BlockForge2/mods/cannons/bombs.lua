
bombs={}

-- Explosive Bomb
bombs.explosive={}
bombs.explosive.name=modname..':explosivebomb'
bombs.explosive.item=modname..':explosiveammo'
bombs.explosive.gravity=9
bombs.explosive.velocity=40

local explosivebomb={
	physical = false,
	textures = {"gunmod_bullet1_back.png"},
	visual = "mesh",
	mesh = "bomb1.x",
	textures={"explosiveBomb.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
    on_step = function(self, dtime)
	    local pos = self.object:getpos()
	    local node = minetest.env:get_node(pos)
	    local exs=true
        if node.name == "default:water_source" or node.name == "default:water_flowing" then 
            exs=false
            self.object:remove() 
        end
	    if self.lastpos.x~=nil then
	    	if node.name ~= "air" and exs then
	    	    self.object:remove()
	    		explode(pos)
	    	end
	    end
	    self.lastpos={x=pos.x, y=pos.y, z=pos.z}
    end
}
minetest.register_entity(bombs.explosive.name, explosivebomb)


-- Timer Bomb
bombs.timer={}
bombs.timer.name=modname..':timerbomb'
bombs.timer.item=modname..':timerammo'
bombs.timer.gravity=9
bombs.timer.velocity=20

local timerbomb={
	physical = true,
	textures = {"gunmod_bullet1_back.png"},
	visual = "mesh",
	mesh = "bomb1.x",
	textures={"timerBomb.png"},
	lastpos={},
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    c=false,
    on_step = function(self, dtime)
	    local pos = self.object:getpos()
	    local node = minetest.env:get_node(pos)

        if self.c==false then
            args={}
	        args.self=self
	        args.pos=pos
            self.c=true
	        minetest.after(6, function(args)
	            if self.object~=nil and self.object:getpos()~=nil then
	                self.object:remove()
	                explode(self.object:getpos())
	            end   
	        end,self)
        end
	    self.lastpos={x=pos.x, y=pos.y, z=pos.z}
    end
}
minetest.register_entity(bombs.timer.name, timerbomb)


-- Funct

function explode(pos) -- Based on https://github.com/PilzAdam/TNT
        minetest.sound_play("DeathFlash", {pos=pos, gain=1.5, max_hear_distance=2*64})
		local objects = minetest.env:get_objects_inside_radius(pos, 7)
		for _,obj in ipairs(objects) do
			if obj:is_player() or (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item") then
				local obj_p = obj:getpos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
				local damage = (80*0.5^dist)*2
				obj:punch(obj, 1.0, {
					full_punch_interval=1.0,
					groupcaps={
						fleshy={times={[1]=1/damage, [2]=1/damage, [3]=1/damage}},
						snappy={times={[1]=1/damage, [2]=1/damage, [3]=1/damage}},
					}
				}, nil)
			end
		end	
		for dx=-2,2 do
			for dz=-2,2 do
				for dy=2,-2,-1 do
					pos.x = pos.x+dx
					pos.y = pos.y+dy
					pos.z = pos.z+dz
					local node =  minetest.env:get_node(pos)   
						if math.abs(dx)<2 and math.abs(dy)<2 and math.abs(dz)<2 then
							destroy(pos)
						else
							if math.random(1,5) <= 4 then
								destroy(pos)
							end
						end			
					pos.x = pos.x-dx
					pos.y = pos.y-dy
					pos.z = pos.z-dz
				end
			end
		end
end

function destroy(pos) -- Based on https://github.com/PilzAdam/TNT
	if math.random(1,5) <= 4 then
		minetest.env:add_entity({x=pos.x+math.random(0,10)/10-0.5, y=pos.y, z=pos.z+math.random(0,10)/10-0.5}, "tnt:smoke")
	end
	local nodename = minetest.env:get_node(pos).name
	if nodename ~= "air" and nodename ~= "default:water_source" and nodename ~= "default:water_flowing"  then
		minetest.env:remove_node(pos)
		nodeupdate(pos)
	end
end
