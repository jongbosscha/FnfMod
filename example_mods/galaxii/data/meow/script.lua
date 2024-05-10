local guitarSolo = false

function onCreate()
    makeLuaSprite('black', 'black', -250, -200);
    setScrollFactor('black', 0.0, 0.0);
    scaleObject('black', 3.0, 3.0);
    addCharacterToList('mouse', 'dad')

    makeAnimatedLuaSprite('Fuck', 'characters/Max_Assets', -360, 575);
	setScrollFactor('Fuck', 1.0, 1.0);
	addAnimationByPrefix('Fuck','bop','MaximusIdle',24,false)
	scaleObject('Fuck', 1.0, 1.0);

    makeAnimatedLuaSprite('Fuck2', 'characters/Bagheera_Assets', -640, 780);
	setScrollFactor('Fuck2', 1.0, 1.0);
	addAnimationByPrefix('Fuck2','bop','BagheeraIdle',24,false)
	addAnimationByPrefix('Fuck2','guitar','BagheeraGuitar',24,false)
	scaleObject('Fuck2', 1.0, 1.0);
end

function onBeatHit()
    objectPlayAnimation('Fuck','bop',false)
    if guitarSolo == false then
        objectPlayAnimation('Fuck2','bop',false)
    end

    if guitarSolo == true then
        objectPlayAnimation('Fuck2','guitar',false)
    end
end

function onUpdate(elapsed)
    if curStep == 336 then
        addLuaSprite('black',true)
        doTweenAlpha('iconoftheday','iconP2',0,1,'linear')
    end

    if curStep == 416 then
        removeLuaSprite('black', true);
        addLuaSprite('Fuck', false);
        addLuaSprite('Fuck2', false);
        triggerEvent('Change Character', 1, 'mouse');
        triggerEvent('Camera Follow Pos', 200, 1050);
        doTweenAlpha('iconoftheday','iconP2',1,1,'linear')
        setProperty('dad.x',-100)
	    setProperty('dad.y',980)
    end

    if curStep >= 338 and curStep <= 414 and getProperty('health') > 1 then
        setProperty('health',getProperty('health') - 0.002)
    end

    if curStep == 752 then
        guitarSolo = true
    end
    
    if curStep == 880 then
        guitarSolo = false
    end
end