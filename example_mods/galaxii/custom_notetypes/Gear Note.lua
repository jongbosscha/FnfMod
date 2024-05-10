function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Gear Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTES_gears'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has no penalties
			end
		end
	end		
	makeLuaText('ratings', 'RATINGS DONT WORK IN THIS SONG!', 500, 880, 690)
    setTextSize('ratings', 16)
    addLuaText('ratings')
    setObjectCamera('ratings', 'camHUD')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Gear Note' and getProperty('songSpeed') < 10.0 then
		setProperty('songSpeed',getProperty('songSpeed') + 0.2)
	end
end

function noteMiss(id,noteData, noteType, isSustainNote)
	if noteType == 'Gear Note' and getProperty('songSpeed') > 1.5 then
		setProperty('songSpeed',getProperty('songSpeed') - 0.2)
	end
	if noteType == 'Gear Note' then
		setProperty('songMisses', getProperty('songMisses') - 1)
		setProperty('songScore', getProperty('songScore') + 10)
		characterPlayAnim('boyfriend', 'idle', false)
	end
end

function onUpdate()
    setProperty('ratingPercent', 0.07)
    setProperty('ratingString', 'Not available for this song')
end