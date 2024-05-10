function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Doubt Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'DOUBT_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Doubt Note' then
		if noteData == 0 then
			characterPlayAnim('dad', 'singLEFTmiss', true)
		end

		if noteData == 1 then
			characterPlayAnim('dad', 'singDOWNmiss', true)
		end

		if noteData == 2 then
			characterPlayAnim('dad', 'singUPmiss', true)
		end

		if noteData == 3 then
			characterPlayAnim('dad', 'singRIGHTmiss', true)
		end
	end
end