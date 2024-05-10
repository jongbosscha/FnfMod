local songEnd = false
local xx = 520;
local yy = -200;
local xx2 = 1000;
local yy2 = 250;
local ofs = 60;
local followchars = true;
local del = 0;
local del2 = 0;
local wasDownScroll = false

function onUpdate()
	if curStep == 16 and wasDownScroll then
		noteTweenY('sex',0,20,0.7,'circInOut')
	end
	if curStep == 20 and wasDownScroll then
		noteTweenY('sexthesequel',3,20,0.7,'circInOut')
	end
	if curStep == 24 and wasDownScroll then
		noteTweenY('sexthethird',1,20,0.7,'circInOut')
	end
	if curStep == 28 and wasDownScroll then
		noteTweenY('sexthefinal',2,20,0.7,'circInOut')
	end
	if curStep == 32 and wasDownScroll then
		noteTweenY('love',4,20,0.7,'circInOut')
	end
	if curStep == 36 and wasDownScroll then
		noteTweenY('lovethesequel',5,20,0.7,'circInOut')
	end
	if curStep == 41 and wasDownScroll then
		noteTweenY('lovethethird',6,20,0.7,'circInOut')
	end
	if curStep == 44 and wasDownScroll then
		noteTweenY('kivethefinal',7,20,0.7,'circInOut')
	end
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
	    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end


function onCreate()
	setProperty('dad.x',0)
	setProperty('dad.y',-550)
		if downscroll then
		wasDownScroll = true
		setPropertyFromClass('ClientPrefs','downScroll',false)
	end
end

function onStepHit()
	if curStep == 64 and not songEnd then
		noteTweenX("NoteMove1", 0, 50, 0.1, circIn)
        noteTweenX("NoteMove2", 1, 200, 0.1, circIn)
		noteTweenX("NoteMove3", 2, 350, 0.1, circIn)
		noteTweenX("NoteMove4", 3, 500, 0.1, circIn)
	end
	if curStep == 128 and not songEnd then
		noteTweenX("NoteMove5", 4, 650, 0.1, circIn)
        noteTweenX("NoteMove6", 5, 800, 0.1, circIn)
		noteTweenX("NoteMove7", 6, 950, 0.1, circIn)
		noteTweenX("NoteMove8", 7, 1100, 0.1, circIn)
	end
	if curStep == 608 and not songEnd then
		noteTweenX("NoteMove29", 0, 50, 0.1, circIn)
        noteTweenX("NoteMove30", 1, 200, 0.1, circIn)
		noteTweenX("NoteMove31", 2, 350, 0.1, circIn)
		noteTweenX("NoteMove32", 3, 500, 0.1, circIn)
		noteTweenX("NoteMove33", 4, 650, 0.1, circIn)
        noteTweenX("NoteMove34", 5, 800, 0.1, circIn)
		noteTweenX("NoteMove35", 6, 950, 0.1, circIn)
		noteTweenX("NoteMove36", 7, 1100, 0.1, circIn)
		noteTweenY("NoteMove37", 0, 20, 0.1, circIn)
        noteTweenY("NoteMove38", 1, 20, 0.1, circIn)
		noteTweenY("NoteMove39", 2, 20, 0.1, circIn)
		noteTweenY("NoteMove40", 3, 20, 0.1, circIn)
		noteTweenY("NoteMove41", 4, 20, 0.1, circIn)
        noteTweenY("NoteMove42", 5, 20, 0.1, circIn)
		noteTweenY("NoteMove43", 6, 20, 0.1, circIn)
		noteTweenY("NoteMove44", 7, 20, 0.1, circIn)
        noteTweenAlpha("NoteAlpha1", 0, 1, 0.1, cubeInOut)
        noteTweenAlpha("NoteAlpha2", 1, 1, 0.1, cubeInOut)
        noteTweenAlpha("NoteAlpha3", 2, 1, 0.1, cubeInOut)
        noteTweenAlpha("NoteAlpha4", 3, 1, 0.1, cubeInOut)
	end
	if curStep == 336 and not songEnd then
		noteTweenX("NoteMove13", 4, 10, 0.1, circIn)
		noteTweenX("NoteMove14", 7, 1150, 0.1, circIn)
		noteTweenX("NoteMove15", 5, 110, 0.1, circIn)
		noteTweenX("NoteMove16", 6, 1050, 0.1, circIn)
		noteTweenX("NoteMove17", 0, 600, 0.1, circIn)
		noteTweenX("NoteMove18", 1, 600, 0.1, circIn)
		noteTweenX("NoteMove19", 2, 600, 0.1, circIn)
		noteTweenX("NoteMove20", 3, 600, 0.1, circIn)
		noteTweenY("NoteMove21", 4, 0, 0.1, circIn)
		noteTweenY("NoteMove22", 7, 0, 0.1, circIn)
		noteTweenY("NoteMove23", 5, 100, 0.1, circIn)
		noteTweenY("NoteMove24", 6, 100, 0.1, circIn)
		noteTweenY("NoteMove25", 0, 0, 0.1, circIn)
		noteTweenY("NoteMove26", 1, 0, 0.1, circIn)
		noteTweenY("NoteMove27", 2, 0, 0.1, circIn)
		noteTweenY("NoteMove28", 3, 0, 0.1, circIn)
		noteTweenAlpha("NoteAlpha1", 0, -1, 0.1, cubeInOut)
        noteTweenAlpha("NoteAlpha2", 1, -1, 0.1, cubeInOut)
        noteTweenAlpha("NoteAlpha3", 2, -1, 0.1, cubeInOut)
        noteTweenAlpha("NoteAlpha4", 3, -1, 0.1, cubeInOut)
	end
	if curStep == 1200 and not songEnd then
		noteTweenX("NoteMove29", 4, 1100, 0.1, circIn)
		noteTweenX("NoteMove30", 7, 650, 0.1, circIn)
		noteTweenX("NoteMove31", 5, 950, 0.1, circIn)
		noteTweenX("NoteMove32", 6, 800, 0.1, circIn)
	end
    if curStep == 1219 and not songEnd then
		noteTweenX("NoteMove33", 4, 650, 0.1, circIn)
        noteTweenX("NoteMove34", 5, 800, 0.1, circIn)
		noteTweenX("NoteMove35", 6, 950, 0.1, circIn)
		noteTweenX("NoteMove36", 7, 1100, 0.1, circIn)
	end
    if curStep == 1248 and not songEnd then
		noteTweenX("NoteMove37", 4, 1100, 0.1, circIn)
		noteTweenX("NoteMove38", 7, 650, 0.1, circIn)
		noteTweenX("NoteMove39", 5, 950, 0.1, circIn)
		noteTweenX("NoteMove40", 6, 800, 0.1, circIn)
	end
    if curStep == 1270 and not songEnd then
		noteTweenX("NoteMove41", 4, 650, 0.1, circIn)
        noteTweenX("NoteMove42", 5, 800, 0.1, circIn)
		noteTweenX("NoteMove43", 6, 950, 0.1, circIn)
		noteTweenX("NoteMove44", 7, 1100, 0.1, circIn)
	end
	if curStep == 1312 then
		songEnd = true
	end
end