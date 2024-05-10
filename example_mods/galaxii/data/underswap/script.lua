function onCreate()
	makeAnimatedLuaSprite('Fuck', 'characters/Nathan_Be_Shootin_Assets', 1500, -130);
	setScrollFactor('Fuck', 1.0, 1.0);
	addAnimationByPrefix('Fuck','bop','Nathan Idle',24,false)
	addAnimationByPrefix('Fuck','gun','Nathan Shoot',24,false)
	scaleObject('Fuck', 1.0, 1.0);

	addLuaSprite('Fuck', false);
end

function onBeatHit()
	objectPlayAnimation('Fuck','bop',false)
end

function goodNoteHit(d, noteData, noteType, isSustainNote)
	if noteType == 'Warning Note' then
		objectPlayAnimation('Fuck','gun',true)
	end
end

function onUpdate(elapsed)
	if not mustHitSection then
		doTweenZoom('seven','camGame',1.02,0.3,'linear')
	end
end