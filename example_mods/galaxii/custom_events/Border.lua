-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Border' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end
		makeLuaSprite('blackBorderBottom', 'black border', 0, 0);
		scaleObject('blackBorderBottom', 5, 0.9);
		setObjectCamera('blackBorderBottom', 'other')
		addLuaSprite('blackBorderBottom')
		--lol
		makeLuaSprite('blackBorderTop', 'black border', 0, 550);
		scaleObject('blackBorderTop', 5, 0.9);
		setObjectCamera('blackBorderTop', 'other')
		addLuaSprite('blackBorderTop')
		doTweenAlpha('bottomborderinvis', 'blackBorderTop', 0, 0.1,'linear')
		doTweenAlpha('topborderinvis', 'blackBorderBottom', 0, 0.1,'linear')

		targetAlpha = tonumber(value2);
        doTweenAlpha('bottombordervisible', 'blackBorderTop', 1, 0.2,'linear')
        doTweenAlpha('topbordervisible', 'blackBorderBottom', 1, 0.2,'linear')
	end
end
