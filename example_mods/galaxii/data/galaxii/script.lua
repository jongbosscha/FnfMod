function onCreate()
	setProperty('dad.x',80)
	setProperty('dad.y',180)
end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not acceptedStuff then
		makeLuaSprite('hell_nah', 'id/MechanicCard_Nova', 75, 0);
		setScrollFactor('hell_nah', 0, 0);
		addLuaSprite('hell_nah', true);
		allowPress = true
		return Function_Stop;
	end
	return Function_Continue;
end

function onUpdate(elapsed)
	if not acceptedStuff and allowPress then
		if keyJustPressed('accept') then
			acceptedStuff = true;
			removeLuaSprite('hell_nah', false);
		end
	end
	if acceptedStuff then
		startCountdown()
	end
end