function onCreate()
	-- background shit
	makeLuaSprite('chug', 'chugBG', -600, -550);
	setScrollFactor('chug', 1.0, 1.0);
	scaleObject('chug', 1.0, 1.0);

	addLuaSprite('chug', false);
end