function onStartCountdown()
	if not acceptedStuff then
		makeLuaSprite('hell_nah', 'id/MechanicCard_Freddy', 300, 44);
		setScrollFactor('hell_nah', 0, 0);
		scaleObject('hell_nah', 0.8, 0.8);
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