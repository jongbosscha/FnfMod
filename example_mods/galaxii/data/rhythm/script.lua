function onCreate()
	makeAnimatedLuaSprite('Fuck', 'characters/Nathan_Be_Shootin_Assets', 1500, -130);
	setScrollFactor('Fuck', 1.0, 1.0);
	addAnimationByPrefix('Fuck','bop','Nathan Idle',24,false)
	addAnimationByPrefix('Fuck','gun','Nathan Shoot',24,false)
	scaleObject('Fuck', 1.0, 1.0);

	addLuaSprite('Fuck', false);
	setProperty('dad.x',60)
	setProperty('dad.y',-120)
end

function goodNoteHit(d, noteData, noteType, isSustainNote)
	if noteType == 'Warning Note' then
		objectPlayAnimation('Fuck','gun',true)
	end
end

function onBeatHit(elapsed)
	objectPlayAnimation('Fuck','bop',false)
	if curStep < 56 and difficulty == 0 then
		setProperty('health',getProperty('health') + 0.1)
	end
end