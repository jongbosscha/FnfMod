local junk = math.random(0,1)
local onScreen = false
local waitingTime = 0
local posX = 0
local posY = 0
local whichText = 13
local staticHit = 0
local fuck = false

function onCreate()
	if not isStoryMode then
		makeAnimatedLuaSprite('cutscene', 'virginity_assets', -113, -70);
		setScrollFactor('cutscene', 0.0, 0.0);
		addAnimationByPrefix('cutscene','bop','fnafstatic',24,true)
		scaleObject('cutscene', 1.2, 1.2);

		addLuaSprite('cutscene',true)
		setObjectCamera('cutscene','camOther')
	end
end

function onUpdate()
	if curStep == 1 then
		doTweenAlpha('1','cutscene',0,5,'circInOut')
	end
	if curStep == 33 then
		removeLuaObject('cutscene',true)
	end
end

function onBeatHit()
	if curBeat > 72 then
		whichText = math.random(0,11)
		posX = math.random(0,860)
		posY = math.random(0,650)
		if whichText == 0 then
			makeLuaSprite('text', 'halloween/cold', posX, posY);
		end
		if whichText == 1 then
			makeLuaSprite('text', 'halloween/get_it', posX, posY);
		end
		if whichText == 2 then
			makeLuaSprite('text', 'halloween/https', posX, posY);
		end
		if whichText == 3 then
			makeLuaSprite('text', 'halloween/lose', posX, posY);
		end
		if whichText == 4 then
			makeLuaSprite('text', 'halloween/move', posX, posY);
		end
		if whichText == 5 then
			makeLuaSprite('text', 'halloween/near', posX, posY);
		end
		if whichText == 6 then
			makeLuaSprite('text', 'halloween/out', posX, posY);
		end
		if whichText == 7 then
			makeLuaSprite('text', 'halloween/pal', posX, posY);
		end
		if whichText == 8 then
			makeLuaSprite('text', 'halloween/punishment', posX, posY);
		end
		if whichText == 9 then
			makeLuaSprite('text', 'halloween/tiring', posX, posY);
		end
		if whichText == 10 then
			makeLuaSprite('text', 'halloween/voices', posX, posY);
		end
		if whichText == 11 then
			makeLuaSprite('text', 'halloween/way', posX, posY);
		end
		setScrollFactor('text', 0.0, 0.0);
		scaleObject('text', 1.0, 1.0);
		addLuaSprite('text',true)
		setObjectCamera('text','camOther')
	end
end

function onStepHit()
	if curStep > 671 then
		whichText = math.random(0,11)
		posX = math.random(0,860)
		posY = math.random(0,650)
		if whichText == 0 then
			makeLuaSprite('text', 'halloween/cold', posX, posY);
		end
		if whichText == 1 then
			makeLuaSprite('text', 'halloween/get_it', posX, posY);
		end
		if whichText == 2 then
			makeLuaSprite('text', 'halloween/https', posX, posY);
		end
		if whichText == 3 then
			makeLuaSprite('text', 'halloween/lose', posX, posY);
		end
		if whichText == 4 then
			makeLuaSprite('text', 'halloween/move', posX, posY);
		end
		if whichText == 5 then
			makeLuaSprite('text', 'halloween/near', posX, posY);
		end
		if whichText == 6 then
			makeLuaSprite('text', 'halloween/out', posX, posY);
		end
		if whichText == 7 then
			makeLuaSprite('text', 'halloween/pal', posX, posY);
		end
		if whichText == 8 then
			makeLuaSprite('text', 'halloween/punishment', posX, posY);
		end
		if whichText == 9 then
			makeLuaSprite('text', 'halloween/tiring', posX, posY);
		end
		if whichText == 10 then
			makeLuaSprite('text', 'halloween/voices', posX, posY);
		end
		if whichText == 11 then
			makeLuaSprite('text', 'halloween/way', posX, posY);
		end
		setScrollFactor('text', 0.0, 0.0);
		scaleObject('text', 1.0, 1.0);
		addLuaSprite('text',true)
		setObjectCamera('text','camOther')
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Static Note' then
		whichText = math.random(0,11)
		posX = math.random(0,860)
		posY = math.random(0,650)
		if whichText == 0 then
			makeLuaSprite('text', 'halloween/cold', posX, posY);
		end
		if whichText == 1 then
			makeLuaSprite('text', 'halloween/get_it', posX, posY);
		end
		if whichText == 2 then
			makeLuaSprite('text', 'halloween/https', posX, posY);
		end
		if whichText == 3 then
			makeLuaSprite('text', 'halloween/lose', posX, posY);
		end
		if whichText == 4 then
			makeLuaSprite('text', 'halloween/move', posX, posY);
		end
		if whichText == 5 then
			makeLuaSprite('text', 'halloween/near', posX, posY);
		end
		if whichText == 6 then
			makeLuaSprite('text', 'halloween/out', posX, posY);
		end
		if whichText == 7 then
			makeLuaSprite('text', 'halloween/pal', posX, posY);
		end
		if whichText == 8 then
			makeLuaSprite('text', 'halloween/punishment', posX, posY);
		end
		if whichText == 9 then
			makeLuaSprite('text', 'halloween/tiring', posX, posY);
		end
		if whichText == 10 then
			makeLuaSprite('text', 'halloween/voices', posX, posY);
		end
		if whichText == 11 then
			makeLuaSprite('text', 'halloween/way', posX, posY);
		end
		setScrollFactor('text', 0.0, 0.0);
		scaleObject('text', 1.0, 1.0);
		addLuaSprite('text',true)
		setObjectCamera('text','camOther')
	end
end