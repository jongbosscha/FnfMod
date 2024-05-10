local Freddyg = false
local L = -1

function onCreate()
	setProperty('dad.x',0)
	setProperty('dad.y',-350)

	makeAnimatedLuaSprite('Fuck', 'characters/Nathan_Be_Shootin_Assets', 1500, -130);
	setScrollFactor('Fuck', 1.0, 1.0);
	addAnimationByPrefix('Fuck','bop','Nathan Idle',24,false)
	addAnimationByPrefix('Fuck','gun','Nathan Shoot',24,false)
	scaleObject('Fuck', 1.0, 1.0);

	addLuaSprite('Fuck', false);
end

function onSongStart()
    if Freddyg then
        playSound('Scraps_Voices',1,'cock')
        setSoundTime('cock', 240)
        Freddyg = false
    end
end

function onBeatHit()
	objectPlayAnimation('Fuck','bop',false)
end

function goodNoteHit(d, noteData, noteType, isSustainNote)
	if noteType == 'Warning Note' then
		objectPlayAnimation('Fuck','gun',true)
	end
end

function opponentNoteHit()
	setProperty('health',getProperty('health') - 0.01)
	triggerEvent('Screen Shake','0.080,0.0041','0.080,0.0021')
end

function onUpdate(elapsed)
	L = L - 1 * elapsed
    if curStep == 0 then
        setProperty('vocals.volume', 1)
    end

	if L == 0 then
		setSoundVolume('cock', 1)
	end
end

function onPause()
    pauseSound('cock')
end

function onResume()
    resumeSound('cock')
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if not noteType == 'Gear Note' then
		setSoundVolume('cock', 0)
		L = 1
	end
end

function onGameOver()
	pauseSound('cock')
end