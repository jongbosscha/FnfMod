function onCreate()
	-- background shit
	makeLuaSprite('jailcell', 'jailcell',-200, -350);
	setScrollFactor('jailcell', 1.0, 1.0);
	scaleObject('jailcell', 1.3, 1.3);

	addLuaSprite('jailcell', false);
end