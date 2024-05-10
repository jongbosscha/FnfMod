function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Glass Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'glass_notes'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
	makeLuaSprite('Ahhhh', 'glass', 0, 0);
	setScrollFactor('Ahhhh', 0.0, 0.0);
	scaleObject('Ahhhh', 1.0, 1.0);
	addLuaSprite('Ahhhh', true);
	setObjectCamera('Ahhhh','camOther')
	doTweenAlpha('1','Ahhhh',0,0.000000001,'linear')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
local crackLasting = 0;

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Glass Note' then
		crackLasting = 4;
		playSound('A5_09285', 1)
		doTweenAlpha('1','Ahhhh',1,0.000000001,'linear')
		triggerEvent('Screen Shake','0.1,0.0095','0.1,0.0033')
	end
end

function onUpdate(elapsed)
	if crackLasting > 0 then
		crackLasting = crackLasting - 1 * elapsed;
		if crackLasting <= 1 then
			doTweenAlpha('1','Ahhhh',0,1,'linear')
		end
	end
end