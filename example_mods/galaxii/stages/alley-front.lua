function onCreate()
	-- background shit
	makeLuaSprite('alley', 'frontalleyway/alleyway', -300, 400);
	setScrollFactor('alley', 1.0, 1.0);
	scaleObject('alley', 1.0, 1.0);

	makeLuaSprite('pov', 'frontalleyway/wall_perspective', 138, 337);
	setScrollFactor('pov', 1.0, 1.0);
	scaleObject('pov', 0.9, 0.9);

	makeLuaSprite('fence', 'alley/Fence', -600, 195);
	setScrollFactor('fence', 1.0, 1.0);
	scaleObject('fence', 1.1, 1.1);

	makeLuaSprite('wall', 'frontalleyway/awakened_walls', -720, 330);
	setScrollFactor('wall', 1.0, 1.0);
	scaleObject('wall', 0.9, 0.9);

	makeLuaSprite('road', 'frontalleyway/road', -800, 1100);
	setScrollFactor('road', 1.0, 1.0);
	scaleObject('road', 1.0, 1.0);

	addLuaSprite('alley', false);
	addLuaSprite('pov', false);
	addLuaSprite('fence', false);
	addLuaSprite('wall', false);
	addLuaSprite('road', false);
end