local junk = math.random(0,1)
local horizontalMoment = math.random(0,1)
local verticalMoment = math.random(0,1)
local yougotIt = false
local cock = 0
local pussy = 0

function onCreate()
	addCharacterToList('aaron', 'dad')
	addCharacterToList('block-guy', 'dad')
	
	makeAnimatedLuaSprite('aaron','characters/Aaron',300,-20);
	addAnimationByPrefix('aaron','Idle','AaronIdle',24,false)
	setScrollFactor('aaron', 1.0, 1.0);
	scaleObject('aaron', 1.0, 1.0);
	makeAnimatedLuaSprite('block-guy','characters/Block_Guy_Assets',fuck,frick);
	addAnimationByPrefix('block-guy','Idle','Block Guy Idle',24,false)
	setScrollFactor('block-guy', 1.0, 1.0);
	scaleObject('block-guy', 1.0, 1.0);
	setProperty('dad.x', 275)
	setProperty('dad.y', 90)
	setProperty('gf.x',350)
	setProperty('gf.y',80)
	makeLuaSprite('Woah', 'Woah', 70, 195);
	setScrollFactor('Woah', 1.0, 1.0);
	scaleObject('Woah', 1.0, 1.0);

	addLuaSprite('Woah', false);
	addLuaSprite('aaron',true);
	addLuaSprite('block-guy',true);
	doTweenAlpha('blockGuyDelete', 'block-guy', 0, 0.00000001, 'linear')
	setObjectOrder('aaron',7)
	setObjectOrder('block-guy',8)
	setObjectOrder('Woah',7)
	removeLuaSprite('AaronDead',true)

	makeAnimatedLuaSprite('gearsweep', 'insanity/gearsweep', 3000, 0)
	addAnimationByPrefix('gearsweep', 'gearssweep', 'gearssweep', 24, true)
	objectPlayAnimation('gearsweep','gearssweep',true)
	scaleObject('gearsweep', 1.5, 1.5)
	addLuaSprite('gearsweep', true)
	setObjectCamera('gearsweep', 'hud')
end

function onStepHit()
	if not altAnim and yougotIt then
		doTweenAlpha('blockGuyToy', 'block-guy', 0, 0.00000001, 'linear')
		triggerEvent('Change Character', 1, 'block-guy');
		doTweenAlpha('blockGuyReturns', 'dad', 1, 1, 'linear')
		setProperty('dad.x',fuck)
		setProperty('dad.y',frick)
		setObjectOrder('dadGroup',8)
		yougotIt = false
	end
		
	if altAnim and not yougotIt then
		doTweenAlpha('blockGuyAppears', 'block-guy', 1, 0.000000001, 'linear')
		doTweenX('bgX', 'block-guy', fuck, 0.0000000001, 'linear')
		doTweenY('bgY', 'block-guy', frick, 0.0000000001, 'linear')
		doTweenAlpha('aaronDelete', 'aaron', 0, 0.00000001, 'linear')
		doTweenAlpha('blockGuyReturns', 'block-guy', 0, 1, 'linear')
		triggerEvent('Change Character', 1, 'aaron');
		setProperty('dad.x',300)
		setProperty('dad.y',-20)
		setObjectOrder('dadGroup',7)
		yougotIt = true
		doTweenX('gearcomein', 'gearsweep', -800, 0.005, 'linear')
		runTimer('gearsweep', 0.1, 1)
	end
end

function onUpdate(elapsed)
	fuck = getProperty('dad.x')
	frick = getProperty('dad.y')

	if curStep == 0 then
		triggerEvent('Alt Idle Animation', 'gf', '-alt');
	end

	if horizontalMoment == 0 and not altAnim and not yougotIt then
		setProperty('dad.x', fuck - 70 * elapsed)
		if fuck <= 135 then
			horizontalMoment = 1
		end
	end

	if horizontalMoment == 1 and not altAnim and not yougotIt then
		setProperty('dad.x', fuck + 70 * elapsed)
		if fuck >= 325 then
			horizontalMoment = 0
		end
	end

	if verticalMoment == 0 and not altAnim and not yougotIt then
		setProperty('dad.y', frick - 95 * elapsed)
		if frick <= 50 then
			verticalMoment = 1
		end
	end

	if verticalMoment == 1 and not altAnim and not yougotIt then
		setProperty('dad.y', frick + 95 * elapsed)
		if frick >= 150 then
			verticalMoment = 0
		end
	end

	if curStep == 239 or curStep == 511 or curStep == 767 or curStep == 1055 then
		doTweenAlpha('aaronReturns', 'aaron', 1, 0.00000001, 'linear')
		doTweenAlpha('Man', 'dad', 0, 0.00000001, 'linear')
	end
end

function onBeatHit()
	objectPlayAnimation('aaron','Idle',false)
	objectPlayAnimation('block-guy','Idle',false)
end

function opponentNoteHit()
	if altAnim then
		triggerEvent('Screen Shake','0.080,0.0024','0.080,0.0009')
	end
end

function gearSweep()
    doTweenX('lamo2', 'insanitygearsweep', 1500, 0.6, linear)
    runTimer('gearsweep', 3, 1)
	debugPrint('lmao')
end

function onTimerCompleted(timer, loops, loopsLeft)
    if timer == 'gearsweep' then
		doTweenX('geargoout', 'gearsweep', 1500, 1.5, linear)
    end
end