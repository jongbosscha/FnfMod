function onCreate()
	-- background shit
	makeLuaSprite('galaxiibgbackblocks', 'studio/galaxiibgbackblocks', -510, -470);
	setScrollFactor('galaxiibgbackblocks', 1.1, 1.02);
	scaleObject('galaxiibgbackblocks', 1.0, 1.0);
	
	makeLuaSprite('galaxiibgfrontblocks', 'studio/galaxiibgfrontblocks', -650, -500);
	setScrollFactor('galaxiibgfrontblocks', 1.0, 1.0);
	scaleObject('galaxiibgfrontblocks', 1.05, 1.05);

	makeAnimatedLuaSprite('AaronDead', 'studio/AaronDead', 200, 530);
	addAnimationByPrefix('AaronDead','bop','AaronBop',24,false)
	setScrollFactor('AaronDead', 1.0, 1.0);
	scaleObject('AaronDead', 0.95, 0.95);
		
	addLuaSprite('galaxiibgbackblocks', false);
	addLuaSprite('galaxiibgfrontblocks', false);
	addLuaSprite('AaronDead', true);

	setObjectOrder('AaronDead',3)
end
	
function onBeatHit()
	objectPlayAnimation('AaronDead','bop',false)
end