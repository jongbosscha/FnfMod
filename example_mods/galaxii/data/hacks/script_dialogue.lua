function onStartCountdown()
	if not acceptedStuff then
		makeLuaSprite('hell_nah', 'id/MechanicCard_Hacz', 65, 150);
		setScrollFactor('hell_nah', 0, 0);
		scaleObject('hell_nah',1.1, 1.1);
		addLuaSprite('hell_nah', true);
		setObjectCamera('hell_nah','camOther')
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