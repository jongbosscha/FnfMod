local birdX = math.random(600, 950);
local birdY = math.random(-100, -250);

function onCreate()
	-- background shit
	if songName == 'J' or songName == 'UNDERSWAP' then
		makeLuaSprite('Skyg', 'alley/Sky_galaxy', -600, -3750);
		setScrollFactor('Skyg', 1.0, 1.0);
		scaleObject('Skyg', 1.0, 1.0);
	end

	if songName == 'J' or songName == 'UNDERSWAP' then
		makeLuaSprite('Skyr', 'alley/Sky_reaching_galaxy', -600, -2670);
		setScrollFactor('Skyr', 1.0, 1.0);
		scaleObject('Skyr', 1.0, 1.0);
	end

	makeLuaSprite('Skym', 'alley/Sky_middle', -520, -205);
	setScrollFactor('Skym', 0, 0);
	scaleObject('Skym', 1.0, 1.0);

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

	if songName == 'Angelic' or songName == 'Angelic The Second' then
		makeAnimatedLuaSprite('queer', 'alley/bgQueers', 420, -400);
		setScrollFactor('queer', 1.0, 1.0);
		addAnimationByPrefix('queer','bop','Dance',24,false)
		scaleObject('quuer', 0.7, 0.7);
	end

	makeLuaSprite('Walls', 'alley/Walls', -585, -740);
	setScrollFactor('Walls', 1.0, 1.0);
	scaleObject('Walls', 1.01, 1.0);

	makeLuaSprite('Ground', 'alley/Ground', -500, -470);
	setScrollFactor('Ground', 1.0, 1.0);
	scaleObject('Ground', 0.98, 0.98);

	makeLuaSprite('Blood', 'alley/bloodsplatter', 400, 540);
	setScrollFactor('Blood', 1.0, 1.0);
	scaleObject('Blood', 0.9, 0.9);

	addLuaSprite('Skym', false);
	addLuaSprite('Skyr', false);
	addLuaSprite('Skyg', false);
	addLuaSprite('Sky', false);
	addLuaSprite('clouds', false);
	addLuaSprite('L', false);
	addLuaSprite('queer', false);
	addLuaSprite('Walls', false);
	addLuaSprite('Ground', false);
	addLuaSprite('Blood', false);
end

function onUpdate(elapsed)
	if curStep == 1168 then
		addLuaSprite('Skyr', false);
	end

	if curStep == 1200 then
		addLuaSprite('Skyg', false);
	end
end

function onBeatHit()
	objectPlayAnimation('clouds','bop',false)
	objectPlayAnimation('queer','bop',false)
end