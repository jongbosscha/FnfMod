function onCreate()
	setProperty('dad.x',120)
	setProperty('dad.y',5)
end

function opponentNoteHit()
	triggerEvent('Screen Shake','0.080,0.0024','0.080,0.0009')
end