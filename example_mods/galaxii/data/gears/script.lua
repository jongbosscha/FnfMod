local Freddyg = false
local L = -1

function onCreate()
	setProperty('dad.x',120)
	setProperty('dad.y',5)
end

function onSongStart()
    if Freddyg then
        playSound('Gears_Voices',1,'cock')
        setSoundTime('cock', 221)
        Freddyg = false
    end
end

function opponentNoteHit()
	triggerEvent('Screen Shake','0.080,0.0024','0.080,0.0009')
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