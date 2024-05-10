function onCreate()
    setProperty('dad.x',0)
	setProperty('dad.y',-550)
    
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
end

function onStepHit()
    if curStep == 608 then
        doTweenAlpha('bottombordervisible', 'blackBorderTop', 1, 0.3,'linear')
        doTweenAlpha('topbordervisible', 'blackBorderBottom', 1, 0.3,'linear')
    end
    if curStep == 736 then
        doTweenAlpha('bottomborderinvis2', 'blackBorderTop', 0, 0.3,'linear')
        doTweenAlpha('topborderinvis2', 'blackBorderBottom', 0, 0.3,'linear')
    end
end