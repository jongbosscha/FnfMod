local x = -150
local y = -200
--I'm extremely lazy

function onCreate()
	-- background shit
	makeLuaSprite('sky', 'halloween/Halloween_Sky', 0, y);
	setScrollFactor('sky', 1.0, 1.0);
	scaleObject('sky', 1.2, 1.2);

	makeLuaSprite('bgh', 'halloween/Halloween_BG', 0, y);
	setScrollFactor('bgh', 1.0, 1.0);
	scaleObject('bgh', 1.2, 1.2);

	makeLuaSprite('light', 'halloween/Halloween_Light', x, y);
	setScrollFactor('light', 1.0, 1.0);
	scaleObject('light', 1.2, 1.2);
	
	makeLuaSprite('fg', 'halloween/Halloween_Foreground', x, -376);
	setScrollFactor('fg', 1.0, 1.0);
	scaleObject('fg', 1.4, 1.4);

	addLuaSprite('sky', false);
	addLuaSprite('bgh', false);
	addLuaSprite('light', true);
	addLuaSprite('fg', true);
end