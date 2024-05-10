function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Ivy Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTES_ivy'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
local ivyLasting = 0;
local ivyStrength = 0;

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Ivy Note' then
		ivyLasting = ivyLasting + 5;
		ivyStrength = ivyStrength + 0.043
		playSound('Ivy', 1)
	end
end

function onUpdate(elapsed)
	if ivyLasting > 0 then
		ivyLasting = ivyLasting - 1 * elapsed;
			setProperty('health', getProperty('health') - ivyStrength * elapsed);
	end

	if ivyLasting == 0 then
		ivyStrength = 0
	end
end

function onEndSong()
	ivyStrength = 0
	ivyLasting = 0
end