math.randomseed(os.clock())
local randomsound = math.random (11)
function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'fleebfdeath');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', randomsound, 1);
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');
end