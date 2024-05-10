function onCreate()
	setProperty('dad.x',80)
	setProperty('dad.y',180)
	addCharacterToList('gf-and-her-gfs-awake', 'gf')
end

function onUpdate(elapsed)
	if curStep == 368 then
		doTweenAlpha('1','camHUD',0,0.5,'linear')
	end

	if curStep == 384 then
		doTweenZoom('2','camGame',1.3,1.7,'linear')
	end

	if curStep == 396 then
		characterPlayAnim('gf', 'scared', false)
	end

	if curStep == 400 then
		doTweenAlpha('1','camHUD',1,0.5,'linear')
		triggerEvent('Change Character', 'gf', 'gf-and-her-gfs-awake');
	end
end