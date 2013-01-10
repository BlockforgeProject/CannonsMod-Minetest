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

bombs={}

-- Explosive Bomb
bombs.explosive={}
bombs.explosive.name=modname..':explosivebomb'
bombs.explosive.item=modname..':explosiveammo'
bombs.explosive.gravity=9
bombs.explosive.velocity=40

local explosivebomb={
	physical = false,
	visual = "mesh",
	mesh = "bomb1.x",
	textures={"explosiveBomb.png"},
	lastpos={},
	plastpos={},
	collisionbox = {0,0,0,0,0,0},
    on_step = function(self, dtime)
	    local pos = self.object:getpos()
	    local node = minetest.env:get_node(pos)
	    local exs=true
        if minetest.get_node_group(node.name, "puts_out_fire")~=0 then 
            exs=false
            self.object:remove() 
        end
	    if self.lastpos.x~=nil then
	    	if node.name ~= "air" and exs then
	    	    self.object:remove()
	    		explode(pos,2,destroy)
	    	end
	    end
	    checkState(self)
	    self.plastpos=self.lastpos
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
	                explode(self.object:getpos(),2,destroy)
	            end   
	        end,self)
        end
	    self.lastpos={x=pos.x, y=pos.y, z=pos.z}
    end
}
minetest.register_entity(bombs.timer.name, timerbomb)

-- Flame Bomb
bombs.flame={}
bombs.flame.name=modname..':flamebomb'
bombs.flame.item=modname..':flameammo'
bombs.flame.gravity=9
bombs.flame.velocity=20

local flamebomb={
	physical = false,
	visual = "mesh",
	mesh = "bomb1.x",
	textures={"flameBomb.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
    c=false,
   on_step = function(self, dtime)
	    local pos = self.object:getpos()
	    local node = minetest.env:get_node(pos)
	    local exs=true
        if minetest.get_node_group(node.name, "puts_out_fire")~=0 then 
            exs=false
            self.object:remove() 
        end
	    if self.lastpos.x~=nil then
	    	if node.name ~= "air" and exs then
	    	    self.object:remove()
	    		explode(pos,1,ignite)
	    	end
	    end
	    checkState(self)
	    self.plastpos=self.lastpos
	    self.lastpos={x=pos.x, y=pos.y, z=pos.z}
    end
}
minetest.register_entity(bombs.flame.name, flamebomb)


-- Funct

function explode(pos,dmwc1,func) -- Based on https://github.com/PilzAdam/TNT
        if checkProtection(pos) then return end
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
		local destroyed=0
		local stop=false
		for dx=-2,2 do
			for dz=-2,2 do
				for dy=2,-2,-1 do
					pos.x = pos.x+dx
					pos.y = pos.y+dy
					pos.z = pos.z+dz
					local node =  minetest.env:get_node(pos)   
						if math.abs(dx)<2 and math.abs(dy)<2 and math.abs(dz)<2 then
					        func(pos)
							if minetest.get_node_group(node.name, "cracky")==1 or minetest.get_node_group(node.name, "obs")==1 then	destroyed=destroyed+1 end
						else
							if math.random(1,5) <= 4 then
                                func(pos)
							end
						end			
				    if destroyed>dmwc1 then 
				        stop=true
				        break
				    end 
					pos.x = pos.x-dx
					pos.y = pos.y-dy
					pos.z = pos.z-dz
				end
				if stop then break end
			end
			if stop then break end
		end
end


function destroy(pos) -- Based on https://github.com/PilzAdam/TNT
	if math.random(1,5) <= 4 then
		minetest.env:add_entity({x=pos.x+math.random(0,10)/10-0.5, y=pos.y, z=pos.z+math.random(0,10)/10-0.5}, modname..":smoke")
	end
	local nodename = minetest.env:get_node(pos).name
	if minetest.get_node_group(nodename, "puts_out_fire")==0 then
		minetest.env:remove_node(pos)
		nodeupdate(pos)
	end
end

function ignite(pos) -- Based on https://github.com/PilzAdam/TNT
	if math.random(1,5) <= 4 then
		minetest.env:add_entity({x=pos.x+math.random(0,10)/10-0.5, y=pos.y, z=pos.z+math.random(0,10)/10-0.5}, modname..":smoke")
	end
	local nodename = minetest.env:get_node(pos).name
	if minetest.get_node_group(nodename, "puts_out_fire")==0 then
	    local nodepos = {x=pos.x,y=pos.y+1,z=pos.z}
        if minetest.env:get_node(nodepos).name == 'air' then 
		    minetest.env:add_node(nodepos, {name="fire:basic_flame"})
		    nodeupdate(pos)
		end
	end
end



minetest.register_entity(modname..":smoke", { -- Based on https://github.com/PilzAdam/TNT
	physical = true,
	visual = "sprite",
	textures = {"tnt_smoke.png"},
	collisionbox = {0,0,0,0,0,0},
	
	timer = 0,
	time = 5,
	
	on_activate = function(self, staticdata)
		self.object:setacceleration({x=math.random(0,10)/10-0.5, y=5, z=math.random(0,10)/10-0.5})
		self.time = math.random(1, 10)/10
	end,
	
	on_step = function(self, dtime)
		self.timer = self.timer+dtime
		if self.timer > self.time then
			self.object:remove()
		end
	end,
})

function checkState(ss)
    minetest.after(2, function(s)
	    if s~=nil and s.plastpos==s.object:getpos() then
	        s.object:remove()
	        explode(s.object:getpos(),2)
	    end   
    end,ss)
end

function checkProtection(pos)

end
