function onCreate()
	-- background shit
	makeLuaSprite('Sky', 'alley/Sky', -520, -700);
	setScrollFactor('Sky', 0.9, 0.96);
	scaleObject('Sky', 1.0, 1.0);

	if not lowQuality then
		makeAnimatedLuaSprite('clouds', 'alley/clouds', -2050, -550);
		setScrollFactor('clouds', 1.0, 1.0);
		addAnimationByPrefix('clouds','bop','CloudsIdle',24,false)
		scaleObject('clouds', 1.0, 1.0);
	end

	makeLuaSprite('L', 'alley/Road_and_Buildings', -585, -740);
	setScrollFactor('L', 1.0, 1.0);
	scaleObject('L', 1.01, 1.0);

	makeLuaSprite('Walls', 'alley/Walls', -585, -740);
	setScrollFactor('Walls', 1.0, 1.0);
	scaleObject('Walls', 1.01, 1.0);

	makeLuaSprite('Ground', 'alley/Ground', -500, -470);
	setScrollFactor('Ground', 1.0, 1.0);
	scaleObject('Ground', 0.98, 0.98);

	addLuaSprite('Sky', false);
	addLuaSprite('clouds', false);
	addLuaSprite('L', false);
	addLuaSprite('Walls', false);
	addLuaSprite('Ground', false);
	addLuaSprite('Blood', false);
end

function onBeatHit()
	objectPlayAnimation('clouds','bop',false)
end