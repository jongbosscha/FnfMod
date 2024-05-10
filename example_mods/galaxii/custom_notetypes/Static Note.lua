local hitten = 0

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Static Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'STATICNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end

	makeAnimatedLuaSprite('virgin', 'virginity_assets', -113, -70);
	setScrollFactor('virgin', 0.0, 0.0);
	addAnimationByPrefix('virgin','bop','fnafstatic',24,true)
	scaleObject('virgin', 1.2, 1.2);
	doTweenAlpha('1','virgin',0,0.00001,'linear')
	setObjectCamera('virgin','camOther')
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Static Note' then
		hitten = hitten + 1;
	end
end

function onUpdate(elapsed)
	if hitten == 1 then
		addLuaSprite('virgin',true)
		doTweenAlpha('1','virgin',0.1,0.5,'linear')
	end

	if hitten == 2 then
		doTweenAlpha('1','virgin',0.2,0.5,'linear')
	end

	if hitten == 3 then
		doTweenAlpha('1','virgin',0.3,0.5,'linear')
	end

	if hitten == 4 then
		doTweenAlpha('1','virgin',0.4,0.5,'linear')
	end

	if hitten == 5 then
		doTweenAlpha('1','virgin',0.5,0.5,'linear')
	end

	if hitten == 6 then
		doTweenAlpha('1','virgin',0.6,0.5,'linear')
	end

	if hitten == 7 then
		doTweenAlpha('1','virgin',0.7,0.5,'linear')
	end

	if hitten == 8 then
		doTweenAlpha('1','virgin',0.8,0.5,'linear')
	end

	if hitten == 9 then
		doTweenAlpha('1','virgin',0.85,0.5,'linear')
	end

	if hitten == 10 then
		doTweenAlpha('1','virgin',0.9,0.5,'linear')
	end

	if hitten >= 11 then
		setProperty('health', 0);
	end
end