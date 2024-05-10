local pain = -470

function onCreate()
	setProperty('dad.x',1230)
	setProperty('dad.y',1400)
	makeLuaSprite('goo', 'goo', -90, -810);
	setScrollFactor('goo', 0.0, 0.0);
	scaleObject('goo', 1.13, 1.13);
	addLuaSprite('goo', true);
end

function onUpdate(elapsed)
	if curStep == 160 then
		doTweenY('gooMove','goo',-50,18,'linear')
	end

	if curStep == 240 then
		cancelTween('gooMove')
	end

	if curStep == 301 then
		doTweenY('gooMove','goo',-150,18,'linear')
	end
end