local risingDamage = 0
function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Warning Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_warning'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Warning Note' then
		characterPlayAnim('boyfriend', 'dodge', false)
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Warning Note' then
		risingDamage = risingDamage + 0.075
		setProperty('health', getProperty('health') - risingDamage)
		triggerEvent('Screen Shake','0.1,0.012','0.1,0.010')
	end
end