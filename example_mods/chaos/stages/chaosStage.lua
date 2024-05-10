local angleshit = 1;
local anglevar = 1;
function onCreate()
    makeLuaSprite('ChaosBG', 'ChaosBG', -2000, -1500);
    setLuaSpriteScrollFactor('ChaosBG', 1, 1);

    makeLuaSprite('ChaosBGFRONT', 'ChaosBGFRONT', 60, 500);
    setLuaSpriteScrollFactor('ChaosBGFRONT', 1, 1);

    makeAnimatedLuaSprite('Emeralds', 'Emeralds', 670, -700);
    luaSpriteAddAnimationByPrefix('Emeralds', 'TheEmeralds instance 1', 'TheEmeralds instance 1');
	setLuaSpriteScrollFactor('Emeralds', 0.9, 0.9);

    if not lowQuality then
	    makeAnimatedLuaSprite('Emerald Beam Charged', 'Emerald Beam Charged', 60, -2000);
        luaSpriteAddAnimationByPrefix('Emerald Beam Charged', 'Emerald Beam Charged instance 1', 'Emerald Beam Charged instance 1');
	    setLuaSpriteScrollFactor('Emerald Beam Charged', 1, 1);

	    makeAnimatedLuaSprite('Porker Lewis', 'Porker Lewis', 2300, -960);
        luaSpriteAddAnimationByPrefix('Porker Lewis', 'Porker FG', 'Porker FG');
	    setLuaSpriteScrollFactor('Porker Lewis', 0.9, 0.9);

      setProperty('gf.visible',false)
	end

	addLuaSprite('ChaosBG', false);
	addLuaSprite('ChaosBGFRONT', true);
	addLuaSprite('Emerald Beam Charged', false);
	addLuaSprite('Emeralds', false);
	addLuaSprite('Porker Lewis', true);

end

function onUpdate()
	setProperty('gf.visible',false)
end
