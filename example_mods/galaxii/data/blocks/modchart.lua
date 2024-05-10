local confirmRise = false
local junk = math.random(1,2)
local junk2 = math.random(20,40,60,80,100)
local junk3 = math.random(20,40,60,80,100)
local junk4 = math.random(20,40,60,80,100)
local junk5 = math.random(20,40,60,80,100)
local lmao1 = 0
local lmao2 = 0
local lmao3 = 0
local lmao4 = 0
local lmao5 = 0
local lmao6 = 0
local lmao7 = 0
local lmao8 = 0
local wasDownScroll = false
local songEnded = false

function onCreate()
	if downscroll then
		wasDownScroll = true
		setPropertyFromClass('ClientPrefs','downScroll',false)
	end
end

function onEndSong()
	songEnded = true
end