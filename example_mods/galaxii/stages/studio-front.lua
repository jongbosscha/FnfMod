function onCreate()
	-- background shit
	makeLuaSprite('sky', 'frontstudios/sky', -330, -300);
	setScrollFactor('sky', 1.0, 1.0);
	scaleObject('sky', 0.91, 0.91);

	makeLuaSprite('fence', 'frontstudios/fences', -320, -227);
	setScrollFactor('fence', 1.0, 1.0);
	scaleObject('fence', 0.9, 0.9);

	makeLuaSprite('building', 'frontstudios/studios_building', -320, -260);
	setScrollFactor('building', 1.0, 1.0);
	scaleObject('building', 0.9, 0.9);

	makeLuaSprite('side', 'frontstudios/sidewalk', -330, -270);
	setScrollFactor('side', 1.0, 1.0);
	scaleObject('side', 0.91, 0.91);

	addLuaSprite('sky', false);
	addLuaSprite('fence', false);
	addLuaSprite('building', false);
	addLuaSprite('side', false);
end