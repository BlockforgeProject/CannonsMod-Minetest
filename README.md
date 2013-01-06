 	 .oooooo.                                                                    
	 d8P'  `Y8b                                                                   
	888           .oooo.   ooo. .oo.   ooo. .oo.    .ooooo.  ooo. .oo.    .oooo.o 
	888          `P  )88b  `888P"Y88b  `888P"Y88b  d88' `88b `888P"Y88b  d88(  "8 
	888           .oP"888   888   888   888   888  888   888  888   888  `"Y88b.  
	`88b    ooo  d8(  888   888   888   888   888  888   888  888   888  o.  )88b 
 	`Y8bood8P'  `Y888""8o o888o o888o o888o o888o `Y8bod8P' o888o o888o 8""888P' 
                                                                              
        
Author: Riccardo B. <riccardo@cryptolab.net>

License: Gnu GPL

Homepage: http://forkforge.net/proj.13




Thanks to LorenzoVulcan (https://github.com/BlockforgeProject/) for Crafting Recipes
	

License
====================

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.



Recipes
====================

### Cobble Wheel (cannons:cobble_wheel)

![ recipe](https://raw.github.com/RickyFF/CannonsMod-Minetest/master/craft/cobble_wheel.png)
```
recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', '', 'default:cobble'},
		{'', 'default:cobble', ''},
	}
```
	


### Obsidian Rod (cannons:obsidian_rod)

![ recipe](https://raw.github.com/RickyFF/CannonsMod-Minetest/master/craft/obsidian_rod.png)
```
recipe = {
		{'lulzpack:obsidian_plate', '', 'lulzpack:obsidian_plate'},
		{'lulzpack:obsidian_plate', '', 'lulzpack:obsidian_plate'},
	}
```
		


### Explosive Ammunition (cannons:explosiveammo)

![ recipe](https://raw.github.com/RickyFF/CannonsMod-Minetest/master/craft/explosiveammo.png)
```
recipe = {
		{'', 'lulzpack:hotstone', ''},
		{'lulzpack:hotstone', 'lulzpack:dintled_celisblock', 'lulzpack:hotstone'},
		{'', 'lulzpack:hotstone', ''},
	}
```
			


### Explosive Ammunition with Timer (cannons:timerammo)

![ recipe](https://raw.github.com/RickyFF/CannonsMod-Minetest/master/craft/timerammo.png)
```
recipe = {
		{'', 'lulzpack:obsidian_bucket_meltediron', ''},
		{'lulzpack:redyz_ingot', 'lulzpack:dintled_celisblock', 'lulzpack:redyz_ingot'},
		{'', 'lulzpack:obsidian_bucket_meltediron', ''},
	}
```
				


### Simple Cannon (cannons:uno)

![ recipe](https://raw.github.com/RickyFF/CannonsMod-Minetest/master/craft/cannonuno.png)
```
recipe = {
		{'', modname..':obsidian_rod', modname..':obsidian_rod'},
		{'lulzpack:dintled_steelblock', 'lulzpack:dintled_steelblock','lulzpack:dintled_steelblock'},
		{modname..':cobble_wheel', '',modname..':cobble_wheel'},
	}
```

---------------------------------

Lulzpack Recipes: https://github.com/BlockforgeProject/BlockForge-2-/wiki/_pages
