function onCreate()
	makeAnimatedLuaSprite('nathan','characters/Angelic_Nathan',0,-550);
	addAnimationByPrefix('nathan','Idle','NathanIdle',24,false);
	setScrollFactor('nathan', 1.0, 1.0);
	scaleObject('nathan', 1.0, 1.0);

	addCharacterToList('nard', 'dad');
end

function onBeatHit()
	objectPlayAnimation('nathan','Idle')
end

function onUpdate(elapsed)
	if curStep == 799 then
		addLuaSprite('nathan',true);
		setProperty('dad.x',1490);
		setProperty('dad.y',-180);
		triggerEvent('Change Character', 1, 'nard');
	end

	if curStep == 879 then
		removeLuaSprite('nathan',true);
		addLuaSprite('nard',true);
		setProperty('dad.x',0);
		setProperty('dad.y',-550);
		triggerEvent('Change Character', 1, 'angelic-nathan');
	end
end