math.randomseed(os.clock())
local randomsound = math.random (11)
function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'fleebfdeath');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', randomsound, 1);
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');
end

function onBeatHit()
	if curBeat == 6 then
  doTweenZoom('sadzoom', 'camGame', 1.0, 1.3, 'circInOut')
	setProperty('defaultCamZoom',1.1)
  followchars = false;
	end
end
