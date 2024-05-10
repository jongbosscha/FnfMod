local allowCountdown = false
local allowEnd = false
local lineCount = 0
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		if not lowQuality then
			makeAnimatedLuaSprite('bg', 'dialogue/dialogueBG_Assets', -305, -150);
			addAnimationByPrefix('bg','studio','week1',24,false)
			addAnimationByPrefix('bg','alley','week2',24,false)
			addAnimationByPrefix('bg','jail','week3',24,false)
			addAnimationByPrefix('bg','halloween','week4',24,false)
			addAnimationByPrefix('bg','freggy','week5',24,false)
			setScrollFactor('bg', 0, 0);
			scaleObject('bg', 1.3, 1.3);
			addLuaSprite('bg',true)
		end
		objectPlayAnimation('bg','alley',false)
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end

	if not acceptedStuff then
		makeLuaSprite('hell_nah', 'id/MechanicCard_Nathan', -100, -125);
		setScrollFactor('hell_nah', 0, 0);
		scaleObject('hell_nah',1.3,1.3);
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

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		if not lowQuality then
			startDialogue('dialogue', 'Finale_Like_UNDERTALE');
		else
			startDialogue('dialogue-lq', 'Finale_Like_UNDERTALE');
		end
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	lineCount = lineCount + 1
	if lineCount == 11 then
		doTweenAlpha('1', 'bg', 0, 0.8, 'linear')
	end
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end

function onEndSong()
	if not allowEnd and isStoryMode then
		lineCount = 12
		doTweenAlpha('1frcuffjk', 'bg', 1, 0.000000001, 'linear')
		noteTweenAlpha('2', '0', 0, 0.0000001,'linear')
		noteTweenAlpha('3', '1', 0, 0.0000001,'linear')
		noteTweenAlpha('4', '2', 0, 0.0000001,'linear')
		noteTweenAlpha('5', '3', 0, 0.0000001,'linear')
		noteTweenAlpha('6', '4', 0, 0.0000001,'linear')
		noteTweenAlpha('7', '5', 0, 0.0000001,'linear')
		noteTweenAlpha('8', '6', 0, 0.0000001,'linear')
		noteTweenAlpha('9', '7', 0, 0.0000001,'linear')
		setProperty('inCutscene', true);
		if not lowQuality then
			startDialogue('post-dialogue', 'Finale_Like_UNDERTALE');
		else
			startDialogue('post-dialogue-lq', 'Finale_Like_UNDERTALE');
		end
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end