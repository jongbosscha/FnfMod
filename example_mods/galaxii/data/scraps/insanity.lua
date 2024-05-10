function onCreate()
    if week == 'zInsanity' then
        makeAnimatedLuaSprite('insanitygearedge', 'insanity/gears', -100, 0)
        addAnimationByPrefix('insanitygearedge', 'corner gears', 'corner gearsB', 24, true)
        objectPlayAnimation('insanitygearedge','corner gears', true)
        scaleObject('insanitygearedge', 1.5, 1.5)
        addLuaSprite('insanitygearedge', true)
        setScrollFactor('insanitygearedge', 0.9, 0.9);
        setObjectCamera('insanitygearedge', 'hud')
    
        makeAnimatedLuaSprite('insanitygearsweep', 'insanity/gearsweep', 9000, 100)
        addAnimationByPrefix('insanitygearsweep', 'gearssweep', 'gearssweep', 24, true)
        objectPlayAnimation('insanitygearsweep','gearssweep',true)
        scaleObject('insanitygearsweep', 1.5, 1.5)
        addLuaSprite('insanitygearsweep', true)
        doTweenX('lamo', 'insanitygearsweep', 5000, 0.01, linear)
        setObjectCamera('insanitygearsweep', 'hud')
        runTimer('gearsweep', 3, 1)
    end
end

function onSongStart()
    if week == 'zInsanity' then
        gearLeft()
    end
end

function gearLeft()
    doTweenX('gearleft', 'insanitygearedge', -400, 0.5, linear)
    runTimer('gotogearright', 0.6, 1)
end

function gearRight()
    doTweenX('gearright', 'insanitygearedge', 200, 0.5, linear)
    runTimer('gotogearleft', 0.6, 1)
end

function gearSweep()
    doTweenX('lamo2', 'insanitygearsweep', 1500, math.random(1, 2.5), linear)
    runTimer('gearsweep', 3, 1)
end

function onTimerCompleted(timer, loops, loopsLeft)
	if timer == 'gotogearright' then
        gearRight()
    end
	if timer == 'gotogearleft' then
        gearLeft()
    end
    if timer == 'gearsweep' then
        doTweenX('lamo3', 'insanitygearsweep', -600, 0.01, linear)
        doTweenY('lamo4', 'insanitygearsweep', math.random(-150, 150), 0.01, linear)
        runTimer('gearsweep2', 0.02, 1)
    end
    if timer == 'gearsweep2' then
        gearSweep()
    end
end