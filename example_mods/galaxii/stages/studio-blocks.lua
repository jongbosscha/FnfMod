function onCreate()
	-- background shit
	makeLuaSprite('Fjc_you', 'studio/Fjc_you', -600, -530);
	setScrollFactor('Fjc_you', 1.0, 1.0);
	scaleObject('Fjc_you', 1.1, 1.1);

	makeLuaSprite('galaxiibgbackblocks', 'studio/galaxiibgbackblocks', -510, -470);
	setScrollFactor('galaxiibgbackblocks', 1.1, 1.02);
	scaleObject('galaxiibgbackblocks', 1.0, 1.0);

	makeAnimatedLuaSprite('BGBoppers', 'studio/BGBoppers', 355, 180);
	addAnimationByPrefix('BGBoppers','bop','bganim',24,false)
	setScrollFactor('BGBoppers', 1.05, 1.01);
	scaleObject('BGBoppers', 1.0, 1.0);
	
	makeLuaSprite('galaxiibgfrontblocks', 'studio/galaxiibgfrontblocks', -650, -500);
	setScrollFactor('galaxiibgfrontblocks', 1.0, 1.0);
	scaleObject('galaxiibgfrontblocks', 1.05, 1.05);

	makeAnimatedLuaSprite('MGBoppers', 'studio/MGBoppers', 10, 260);
	addAnimationByPrefix('MGBoppers','bop','mganim',24,false)
	setScrollFactor('MGBoppers', 1.0, 1.0);
	scaleObject('MGBoppers', 1.1, 1.1);
	
	makeAnimatedLuaSprite('AaronDead', 'studio/AaronDead', 200, 530);
	addAnimationByPrefix('AaronDead','bop','AaronBop',24,false)
	setScrollFactor('AaronDead', 1.0, 1.0);
	scaleObject('AaronDead', 0.95, 0.95);

	makeAnimatedLuaSprite('FGBoppers', 'studio/FGBoppers', -700, 354);
	addAnimationByPrefix('FGBoppers','bop','fganim',24,false)
	setScrollFactor('FGBoppers', 2.8, 0.6);
	scaleObject('FGBoppers', 1.55, 1.55);
	
	addLuaSprite('Fjc_you', true);
	addLuaSprite('galaxiibgbackblocks', false);
	addLuaSprite('BGBoppers', false);
	addLuaSprite('galaxiibgfrontblocks', false);
	addLuaSprite('MGBoppers', false);
	addLuaSprite('AaronDead', true);
	addLuaSprite('FGBoppers', true);

	setObjectOrder('AaronDead',5)
end

function onBeatHit()
	objectPlayAnimation('BGBoppers','bop',false)
	objectPlayAnimation('MGBoppers','bop',false)
	objectPlayAnimation('FGBoppers','bop',false)
	objectPlayAnimation('AaronDead','bop',false)
end