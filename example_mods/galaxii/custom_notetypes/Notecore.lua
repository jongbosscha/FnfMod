math.randomseed(os.time())
local color = 0
local time = 0

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Notecore' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_notecore'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end
-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Notecore' then
		setProperty('health', getProperty('health') - 0.5)
		color = math.random(1,12)
		time = 4
		if color == 1 then
			doTweenColor('nightcore', 'boyfriend', 'F1F3FB', 0.1, 'linear') --White
		end
		if color == 2 then
			doTweenColor('nightcore', 'boyfriend', 'FF3F3F', 0.1, 'linear') --Red
		end
		if color == 3 then
			doTweenColor('nightcore', 'boyfriend', 'ED6316', 0.1, 'linear') --Orange
		end
		if color == 4 then
			doTweenColor('nightcore', 'boyfriend', 'FFDE11', 0.1, 'linear') --Yellow
		end
		if color == 5 then
			doTweenColor('nightcore', 'boyfriend', '7EF60D', 0.1, 'linear') --Green
		end
		if color == 6 then
			doTweenColor('nightcore', 'boyfriend', '00FFF0', 0.1, 'linear') --Cyan
		end
		if color == 7 then
			doTweenColor('nightcore', 'boyfriend', '1A47FF', 0.1, 'linear') --Blue
		end
		if color == 8 then
			doTweenColor('nightcore', 'boyfriend', '9626FF', 0.1, 'linear') --Purple
		end
		if color == 9 then
			doTweenColor('nightcore', 'boyfriend', 'FD30FF', 0.1, 'linear') --Pink
		end
		if color == 10 then
			doTweenColor('nightcore', 'boyfriend', '181394', 0.1, 'linear') --Ultramarine/Nightcore
		end
		if color == 11 then
			doTweenColor('nightcore', 'boyfriend', '75837B', 0.1, 'linear') --Grey
		end
		if color == 12 then
			doTweenColor('nightcore', 'boyfriend', '171618', 0.1, 'linear') --Black
		end
	end
end

function onUpdate(elapsed)
	if time > 0 then
		time = time - 1 * elapsed
	end

	if time == 1 then
		doTweenColor('nightcore', 'boyfriend', '', 0.1, 'linear')
	end
end