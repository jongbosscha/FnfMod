local sin, cos, pi, sqrt, abs, asin = math.sin, math.cos, math.pi, math.sqrt, math.abs, math.asin
		local eases = { 
			["linear"] = function(t, b, c, d) return c * t / d + b end,
			
			["k"] = function(t, b, c, d) t = t / d return c * t ^ 2 + b end,
			["j"] = function(t, b, c, d) t = t / d return -c * t * (t - 2) + b end,
			["h"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return c / 2 * t ^ 2 + b else return -c / 2 * ((t - 1) * (t - 3) - 1) + b end end,
			
			["cubein"] = function(t, b, c, d) t = t / d return c * t ^ 3 + b end,
			["cubeout"] = function(t, b, c, d) t = t / d - 1 return c * (t ^ 3 + 1) + b end,
			["cubeinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return c / 2 * t ^ 3 + b else t = t - 2 return c / 2 * (t ^ 3 + 2) + b end end,
			
			["quartin"] = function(t, b, c, d) t = t / d return c * t ^ 4 + b end,
			["quartout"] = function(t, b, c, d) t = t / d - 1 return -c * (t ^ 4 - 1) + b end,
			["quartinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return c / 2 * t ^ 4 + b else t = t - 2 return -c / 2 * (t ^ 4 - 2) + b end end,
			
			["quintin"] = function(t, b, c, d) t = t / d return c * t ^ 5 + b end,
			["quintout"] = function(t, b, c, d) t = t / d - 1 return c * (t ^ 5 + 1) + b end,
			["quintinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return c / 2 * t ^ 5 + b else t = t - 2 return c / 2 * (t ^ 5 + 2) + b end end,
			
			["quadin"] = function(t, b, c, d) return -c * cos(t / d * (pi / 2)) + c + b end,
			["quadout"] = function(t, b, c, d) return c * sin(t / d * (pi / 2)) + b end,
			["quadinout"] = function(t, b, c, d) return -c / 2 * (cos(pi * t / d) - 1) + b end,
			
			["expoin"] = function(t, b, c, d) if t == 0 then return b else return c * 2 ^ (10 * (t / d - 1)) + b - c * 0.001 end end,
			["expoout"] = function(t, b, c, d) if t == d then return b + c else return c * 1.001 * (-(2 ^ (-10 * t / d)) + 1) + b end end,
			["expoinout"] = function(t, b, c, d) if t == 0 then return b end if t == d then return b + c end t = t / d * 2 if t < 1 then return c / 2 * 2 ^ (10 * (t - 1)) + b - c * 0.0005 else t = t - 1 return c / 2 * 1.0005 * (-(2 ^ (-10 * t)) + 2) + b end end,
			
			["circin"] = function(t, b, c, d) t = t / d return(-c * (sqrt(1 - t ^ 2) - 1) + b) end,
			["circout"] = function(t, b, c, d) t = t / d - 1 return(c * sqrt(1 - t ^ 2) + b) end,
			["circinout"] = function(t, b, c, d) t = t / d * 2 if t < 1 then return -c / 2 * (sqrt(1 - t * t) - 1) + b else t = t - 2 return c / 2 * (sqrt(1 - t * t) + 1) + b end end,
		}
		local tweens = {{}, {}}
		
		--
		
		function tween_property(property, goal, duration, ease)
			ease = ease:lower()
			if eases[ease] then
				local start = getProperty(property)
				if start then
					tweens[1][property] = {(getSongPosition() / 1000) + duration, start, goal - start, duration, ease}
				end
			end
		end
		
		function get_tween_value(tag)
			local tween = tweens[2][tag]
			if tween then return tween[1] end
		end
		function tween_value(tag, start, goal, duration, ease)
			ease = ease:lower()
			if eases[ease] then
				tweens[2][tag] = {start, (getSongPosition() / 1000) + duration, start, goal - start, duration, ease}
			end
		end
		
		function update_tweens()
			for property, tween in pairs(tweens[1]) do
				if (getSongPosition() / 1000) <= tween[1] then setProperty(property, eases[tween[5]](tween[4] - (tween[1] - (getSongPosition() / 1000)), tween[2], tween[3], tween[4]))
				else tweens[1][property] = nil end
			end
			for tag, tween in pairs(tweens[2]) do
				if (getSongPosition() / 1000) then tween[1] = eases[tween[6]](tween[5] - (tween[2] - (getSongPosition() / 1000)), tween[3], tween[4], tween[5])
				else tweens[2][tag] = nil end
			end
		end
lastConductorPos = 0;
function onSongStart()
	ogposx0 = getPropertyFromGroup('opponentStrums', 0, 'x');
	ogposy0 = getPropertyFromGroup('opponentStrums', 0, 'y');
	ogposx1 = getPropertyFromGroup('opponentStrums', 1, 'x');
	ogposy1 = getPropertyFromGroup('opponentStrums', 1, 'y');
	ogposx2 = getPropertyFromGroup('opponentStrums', 2, 'x');
	ogposy2 = getPropertyFromGroup('opponentStrums', 2, 'y');
	ogposx3 = getPropertyFromGroup('opponentStrums', 3, 'x');
	ogposy3 = getPropertyFromGroup('opponentStrums', 3, 'y');
	ogposx4 = getPropertyFromGroup('playerStrums', 0, 'x');
	ogposy4 = getPropertyFromGroup('playerStrums', 0, 'y');
	ogposx5 = getPropertyFromGroup('playerStrums', 1, 'x');
	ogposy5 = getPropertyFromGroup('playerStrums', 1, 'y');
	ogposx6 = getPropertyFromGroup('playerStrums', 2, 'x');
	ogposy6 = getPropertyFromGroup('playerStrums', 2, 'y');
	ogposx7 = getPropertyFromGroup('playerStrums', 3, 'x');
	ogposy7 = getPropertyFromGroup('playerStrums', 3, 'y');
end
function onUpdate(elapsed)
	ballssimulatorroblox = getSongPosition();

			ballsx = getPropertyFromClass('openfl.Lib', 'application.window.x')
		ballsy = getPropertyFromClass('openfl.Lib', 'application.window.y')
		ballswidth = getPropertyFromClass('openfl.Lib', 'application.window.width')
		ballsheight = getPropertyFromClass('openfl.Lib', 'application.window.height')	
		xMultiply = (getPropertyFromClass('openfl.system.Capabilities', 'screenResolutionX') / 1920);
		yMultiply = (getPropertyFromClass('openfl.system.Capabilities', 'screenResolutionY') / 1080);if (5217.39130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 5217.39130434783) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -28, 0.1 , 'quadInOut');
			thecooly = -4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls15217.391304347830', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls25217.391304347830', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls35217.391304347830', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls45217.391304347830', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (5217.39130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (5217.39130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls15217.391304347830"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls25217.391304347830"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls35217.391304347830"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls45217.391304347830"))
			end
		end
		if (5217.39130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 5217.39130434783) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 34, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls15217.391304347833', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls25217.391304347833', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls35217.391304347833', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls45217.391304347833', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (5217.39130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (5217.39130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls15217.391304347833"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls25217.391304347833"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls35217.391304347833"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls45217.391304347833"))
			end
		end
		if (5380.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 5380.4347826087) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 4, 0.1 , 'quadInOut');
			thecooly = 106
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls15380.43478260871', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls25380.43478260871', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls35380.43478260871', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls45380.43478260871', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (5380.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (5380.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls15380.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls25380.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls35380.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls45380.43478260871"))
			end
		end
		if (5380.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 5380.4347826087) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls15380.43478260872', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls25380.43478260872', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls35380.43478260872', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls45380.43478260872', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (5380.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (5380.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls15380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls25380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls35380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls45380.43478260872"))
			end
		end
		if (5706.52173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 5706.52173913043) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls15706.521739130430', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls25706.521739130430', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls35706.521739130430', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls45706.521739130430', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (5706.52173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (5706.52173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls15706.521739130430"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls25706.521739130430"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls35706.521739130430"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls45706.521739130430"))
			end
		end
		if (5706.52173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 5706.52173913043) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls15706.521739130431', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls25706.521739130431', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls35706.521739130431', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls45706.521739130431', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (5706.52173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (5706.52173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls15706.521739130431"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls25706.521739130431"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls35706.521739130431"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls45706.521739130431"))
			end
		end
		if (5706.52173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 5706.52173913043) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls15706.521739130432', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls25706.521739130432', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls35706.521739130432', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls45706.521739130432', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (5706.52173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (5706.52173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls15706.521739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls25706.521739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls35706.521739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls45706.521739130432"))
			end
		end
		if (5706.52173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 5706.52173913043) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls15706.521739130433', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls25706.521739130433', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls35706.521739130433', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls45706.521739130433', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (5706.52173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (5706.52173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls15706.521739130433"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls25706.521739130433"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls35706.521739130433"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls45706.521739130433"))
			end
		end
		if (6032.60869565217 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6032.60869565217) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + -2, 0.1 , 'quadInOut');
			thecooly = -20
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16032.608695652172', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26032.608695652172', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36032.608695652172', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46032.608695652172', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6032.60869565217 / 1000 <= ballssimulatorroblox / 1000) then
			if (6032.60869565217 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16032.608695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26032.608695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36032.608695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46032.608695652172"))
			end
		end
		if (6195.65217391304 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6195.65217391304) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 2, 0.1 , 'quadInOut');
			thecooly = 40
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16195.652173913041', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26195.652173913041', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36195.652173913041', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46195.652173913041', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6195.65217391304 / 1000 <= ballssimulatorroblox / 1000) then
			if (6195.65217391304 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16195.652173913041"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26195.652173913041"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36195.652173913041"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46195.652173913041"))
			end
		end
		if (6358.69565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6358.69565217391) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16358.695652173910', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26358.695652173910', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36358.695652173910', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46358.695652173910', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6358.69565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (6358.69565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16358.695652173910"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26358.695652173910"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36358.695652173910"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46358.695652173910"))
			end
		end
		if (6358.69565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6358.69565217391) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16358.695652173911', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26358.695652173911', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36358.695652173911', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46358.695652173911', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6358.69565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (6358.69565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16358.695652173911"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26358.695652173911"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36358.695652173911"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46358.695652173911"))
			end
		end
		if (6358.69565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6358.69565217391) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16358.695652173912', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26358.695652173912', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36358.695652173912', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46358.695652173912', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6358.69565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (6358.69565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16358.695652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26358.695652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36358.695652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46358.695652173912"))
			end
		end
		if (6358.69565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6358.69565217391) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 34, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16358.695652173913', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26358.695652173913', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36358.695652173913', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46358.695652173913', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6358.69565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (6358.69565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16358.695652173913"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26358.695652173913"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36358.695652173913"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46358.695652173913"))
			end
		end
		if (6521.73913043478 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6521.73913043478) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -28, 0.1 , 'quadInOut');
			thecooly = -4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16521.739130434780', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26521.739130434780', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36521.739130434780', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46521.739130434780', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6521.73913043478 / 1000 <= ballssimulatorroblox / 1000) then
			if (6521.73913043478 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16521.739130434780"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26521.739130434780"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36521.739130434780"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46521.739130434780"))
			end
		end
		if (6521.73913043478 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6521.73913043478) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 34, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16521.739130434783', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26521.739130434783', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36521.739130434783', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46521.739130434783', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6521.73913043478 / 1000 <= ballssimulatorroblox / 1000) then
			if (6521.73913043478 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16521.739130434783"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26521.739130434783"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36521.739130434783"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46521.739130434783"))
			end
		end
		if (6684.78260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6684.78260869565) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 4, 0.1 , 'quadInOut');
			thecooly = 106
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16684.782608695651', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26684.782608695651', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36684.782608695651', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46684.782608695651', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6684.78260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (6684.78260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16684.782608695651"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26684.782608695651"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36684.782608695651"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46684.782608695651"))
			end
		end
		if (6684.78260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 6684.78260869565) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls16684.782608695652', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls26684.782608695652', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls36684.782608695652', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls46684.782608695652', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (6684.78260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (6684.78260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls16684.782608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls26684.782608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls36684.782608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls46684.782608695652"))
			end
		end
		if (7010.86956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7010.86956521739) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17010.869565217390', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27010.869565217390', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37010.869565217390', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47010.869565217390', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7010.86956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (7010.86956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17010.869565217390"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27010.869565217390"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37010.869565217390"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47010.869565217390"))
			end
		end
		if (7010.86956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7010.86956521739) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17010.869565217391', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27010.869565217391', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37010.869565217391', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47010.869565217391', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7010.86956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (7010.86956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17010.869565217391"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27010.869565217391"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37010.869565217391"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47010.869565217391"))
			end
		end
		if (7010.86956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7010.86956521739) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17010.869565217392', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27010.869565217392', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37010.869565217392', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47010.869565217392', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7010.86956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (7010.86956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17010.869565217392"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27010.869565217392"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37010.869565217392"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47010.869565217392"))
			end
		end
		if (7010.86956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7010.86956521739) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17010.869565217393', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27010.869565217393', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37010.869565217393', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47010.869565217393', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7010.86956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (7010.86956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17010.869565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27010.869565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37010.869565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47010.869565217393"))
			end
		end
		if (7336.95652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7336.95652173913) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + -2, 0.1 , 'quadInOut');
			thecooly = -20
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17336.956521739132', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27336.956521739132', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37336.956521739132', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47336.956521739132', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7336.95652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (7336.95652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17336.956521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27336.956521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37336.956521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47336.956521739132"))
			end
		end
		if (7500 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7500) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 2, 0.1 , 'quadInOut');
			thecooly = 40
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls175001', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls275001', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls375001', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls475001', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7500 / 1000 <= ballssimulatorroblox / 1000) then
			if (7500 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls175001"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls275001"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls375001"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls475001"))
			end
		end
		if (7663.04347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7663.04347826087) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17663.043478260870', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27663.043478260870', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37663.043478260870', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47663.043478260870', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7663.04347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (7663.04347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17663.043478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27663.043478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37663.043478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47663.043478260870"))
			end
		end
		if (7663.04347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7663.04347826087) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17663.043478260871', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27663.043478260871', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37663.043478260871', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47663.043478260871', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7663.04347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (7663.04347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17663.043478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27663.043478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37663.043478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47663.043478260871"))
			end
		end
		if (7663.04347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7663.04347826087) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17663.043478260872', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27663.043478260872', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37663.043478260872', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47663.043478260872', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7663.04347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (7663.04347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17663.043478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27663.043478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37663.043478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47663.043478260872"))
			end
		end
		if (7663.04347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7663.04347826087) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 34, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17663.043478260873', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27663.043478260873', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37663.043478260873', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47663.043478260873', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7663.04347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (7663.04347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17663.043478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27663.043478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37663.043478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47663.043478260873"))
			end
		end
		if (7826.08695652174 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7826.08695652174) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -4, 0.1 , 'quadInOut');
			thecooly = 26
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17826.086956521740', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27826.086956521740', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37826.086956521740', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47826.086956521740', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7826.08695652174 / 1000 <= ballssimulatorroblox / 1000) then
			if (7826.08695652174 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17826.086956521740"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27826.086956521740"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37826.086956521740"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47826.086956521740"))
			end
		end
		if (7989.13043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 7989.13043478261) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 2, 0.1 , 'quadInOut');
			thecooly = 58
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls17989.130434782611', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls27989.130434782611', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls37989.130434782611', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls47989.130434782611', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (7989.13043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (7989.13043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls17989.130434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls27989.130434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls37989.130434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls47989.130434782611"))
			end
		end
		if (8152.17391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 8152.17391304348) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 12, 0.1 , 'quadInOut');
			thecooly = 122
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls18152.173913043482', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls28152.173913043482', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls38152.173913043482', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls48152.173913043482', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (8152.17391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (8152.17391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls18152.173913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls28152.173913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls38152.173913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls48152.173913043482"))
			end
		end
		if (8315.21739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 8315.21739130435) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 12, 0.1 , 'quadInOut');
			thecooly = 196
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls18315.217391304353', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls28315.217391304353', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls38315.217391304353', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls48315.217391304353', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (8315.21739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (8315.21739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls18315.217391304353"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls28315.217391304353"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls38315.217391304353"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls48315.217391304353"))
			end
		end
		if (8478.26086956522 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 8478.26086956522) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 12, 0.1 , 'quadInOut');
			thecooly = 108
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls18478.260869565222', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls28478.260869565222', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls38478.260869565222', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls48478.260869565222', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (8478.26086956522 / 1000 <= ballssimulatorroblox / 1000) then
			if (8478.26086956522 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls18478.260869565222"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls28478.260869565222"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls38478.260869565222"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls48478.260869565222"))
			end
		end
		if (8641.30434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 8641.30434782609) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 10, 0.1 , 'quadInOut');
			thecooly = 80
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls18641.304347826092', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls28641.304347826092', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls38641.304347826092', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls48641.304347826092', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (8641.30434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (8641.30434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls18641.304347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls28641.304347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls38641.304347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls48641.304347826092"))
			end
		end
		if (8804.34782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 8804.34782608696) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 52
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls18804.347826086963', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls28804.347826086963', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls38804.347826086963', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls48804.347826086963', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (8804.34782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (8804.34782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls18804.347826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls28804.347826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls38804.347826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls48804.347826086963"))
			end
		end
		if (8967.39130434782 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 8967.39130434782) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 28
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls18967.391304347821', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls28967.391304347821', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls38967.391304347821', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls48967.391304347821', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (8967.39130434782 / 1000 <= ballssimulatorroblox / 1000) then
			if (8967.39130434782 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls18967.391304347821"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls28967.391304347821"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls38967.391304347821"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls48967.391304347821"))
			end
		end
		if (9130.43478260869 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 9130.43478260869) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -4, 0.1 , 'quadInOut');
			thecooly = 26
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls19130.434782608690', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls29130.434782608690', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls39130.434782608690', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls49130.434782608690', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (9130.43478260869 / 1000 <= ballssimulatorroblox / 1000) then
			if (9130.43478260869 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls19130.434782608690"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls29130.434782608690"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls39130.434782608690"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls49130.434782608690"))
			end
		end
		if (9293.47826086956 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 9293.47826086956) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 2, 0.1 , 'quadInOut');
			thecooly = 58
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls19293.478260869561', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls29293.478260869561', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls39293.478260869561', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls49293.478260869561', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (9293.47826086956 / 1000 <= ballssimulatorroblox / 1000) then
			if (9293.47826086956 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls19293.478260869561"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls29293.478260869561"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls39293.478260869561"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls49293.478260869561"))
			end
		end
		if (9456.52173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 9456.52173913043) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 12, 0.1 , 'quadInOut');
			thecooly = 122
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls19456.521739130432', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls29456.521739130432', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls39456.521739130432', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls49456.521739130432', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (9456.52173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (9456.52173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls19456.521739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls29456.521739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls39456.521739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls49456.521739130432"))
			end
		end
		if (9619.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 9619.5652173913) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 12, 0.1 , 'quadInOut');
			thecooly = 196
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls19619.56521739133', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls29619.56521739133', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls39619.56521739133', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls49619.56521739133', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (9619.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (9619.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls19619.56521739133"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls29619.56521739133"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls39619.56521739133"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls49619.56521739133"))
			end
		end
		if (9782.60869565217 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 9782.60869565217) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 12, 0.1 , 'quadInOut');
			thecooly = 108
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls19782.608695652172', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls29782.608695652172', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls39782.608695652172', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls49782.608695652172', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (9782.60869565217 / 1000 <= ballssimulatorroblox / 1000) then
			if (9782.60869565217 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls19782.608695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls29782.608695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls39782.608695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls49782.608695652172"))
			end
		end
		if (9945.65217391304 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 9945.65217391304) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 10, 0.1 , 'quadInOut');
			thecooly = 80
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls19945.652173913042', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls29945.652173913042', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls39945.652173913042', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls49945.652173913042', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (9945.65217391304 / 1000 <= ballssimulatorroblox / 1000) then
			if (9945.65217391304 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls19945.652173913042"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls29945.652173913042"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls39945.652173913042"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls49945.652173913042"))
			end
		end
		if (10108.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10108.6956521739) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 52
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110108.69565217393', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210108.69565217393', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310108.69565217393', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410108.69565217393', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10108.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (10108.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110108.69565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210108.69565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310108.69565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410108.69565217393"))
			end
		end
		if (10271.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10271.7391304348) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 28
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110271.73913043481', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210271.73913043481', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310271.73913043481', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410271.73913043481', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10271.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (10271.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110271.73913043481"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210271.73913043481"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310271.73913043481"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410271.73913043481"))
			end
		end
		if (10434.7826086957 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10434.7826086957) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -28, 0.1 , 'quadInOut');
			thecooly = -4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110434.78260869574', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210434.78260869574', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310434.78260869574', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410434.78260869574', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10434.7826086957 / 1000 <= ballssimulatorroblox / 1000) then
			if (10434.7826086957 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110434.78260869574"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210434.78260869574"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310434.78260869574"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410434.78260869574"))
			end
		end
		if (10434.7826086957 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10434.7826086957) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 34, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110434.78260869577', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210434.78260869577', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310434.78260869577', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410434.78260869577', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10434.7826086957 / 1000 <= ballssimulatorroblox / 1000) then
			if (10434.7826086957 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110434.78260869577"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210434.78260869577"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310434.78260869577"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410434.78260869577"))
			end
		end
		if (10434.7826086957 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10434.7826086957) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.2 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.2 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.2 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.2 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.2 , 'quadInOut');
		
			end
			tween_value('balls110434.78260869570', ballsx, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls210434.78260869570', ballsy, 0 * yMultiply, 0.2, 'quadInOut')
			tween_value('balls310434.78260869570', ballswidth, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls410434.78260869570', ballsheight, 0 * yMultiply, 0.2, 'quadInOut')
			end
	end
		if (10434.7826086957 / 1000 <= ballssimulatorroblox / 1000) then
			if (10434.7826086957 / 1000 >= (ballssimulatorroblox / 1000) - 0.2) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110434.78260869570"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210434.78260869570"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310434.78260869570"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410434.78260869570"))
			end
		end
		if (10434.7826086957 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10434.7826086957) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.2 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.2 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.2 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.2 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.2 , 'quadInOut');
		
			end
			tween_value('balls110434.78260869571', ballsx, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls210434.78260869571', ballsy, 0 * yMultiply, 0.2, 'quadInOut')
			tween_value('balls310434.78260869571', ballswidth, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls410434.78260869571', ballsheight, 0 * yMultiply, 0.2, 'quadInOut')
			end
	end
		if (10434.7826086957 / 1000 <= ballssimulatorroblox / 1000) then
			if (10434.7826086957 / 1000 >= (ballssimulatorroblox / 1000) - 0.2) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110434.78260869571"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210434.78260869571"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310434.78260869571"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410434.78260869571"))
			end
		end
		if (10516.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10516.3043478261) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.2 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.2 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.2 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.2 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.2 , 'quadInOut');
		
			end
			tween_value('balls110516.30434782612', ballsx, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls210516.30434782612', ballsy, 0 * yMultiply, 0.2, 'quadInOut')
			tween_value('balls310516.30434782612', ballswidth, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls410516.30434782612', ballsheight, 0 * yMultiply, 0.2, 'quadInOut')
			end
	end
		if (10516.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (10516.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.2) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110516.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210516.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310516.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410516.30434782612"))
			end
		end
		if (10516.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10516.3043478261) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.2 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.2 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.2 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.2 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.2 , 'quadInOut');
		
			end
			tween_value('balls110516.30434782613', ballsx, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls210516.30434782613', ballsy, 0 * yMultiply, 0.2, 'quadInOut')
			tween_value('balls310516.30434782613', ballswidth, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls410516.30434782613', ballsheight, 0 * yMultiply, 0.2, 'quadInOut')
			end
	end
		if (10516.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (10516.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.2) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110516.30434782613"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210516.30434782613"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310516.30434782613"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410516.30434782613"))
			end
		end
		if (10597.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10597.8260869565) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 4, 0.1 , 'quadInOut');
			thecooly = 106
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110597.82608695655', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210597.82608695655', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310597.82608695655', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410597.82608695655', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10597.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (10597.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110597.82608695655"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210597.82608695655"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310597.82608695655"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410597.82608695655"))
			end
		end
		if (10597.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10597.8260869565) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110597.82608695656', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210597.82608695656', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310597.82608695656', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410597.82608695656', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10597.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (10597.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110597.82608695656"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210597.82608695656"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310597.82608695656"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410597.82608695656"))
			end
		end
		if (10923.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10923.9130434783) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110923.91304347834', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210923.91304347834', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310923.91304347834', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410923.91304347834', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10923.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (10923.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110923.91304347834"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210923.91304347834"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310923.91304347834"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410923.91304347834"))
			end
		end
		if (10923.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10923.9130434783) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110923.91304347835', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210923.91304347835', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310923.91304347835', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410923.91304347835', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10923.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (10923.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110923.91304347835"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210923.91304347835"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310923.91304347835"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410923.91304347835"))
			end
		end
		if (10923.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10923.9130434783) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110923.91304347836', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210923.91304347836', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310923.91304347836', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410923.91304347836', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10923.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (10923.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110923.91304347836"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210923.91304347836"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310923.91304347836"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410923.91304347836"))
			end
		end
		if (10923.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 10923.9130434783) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls110923.91304347837', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls210923.91304347837', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls310923.91304347837', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls410923.91304347837', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (10923.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (10923.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls110923.91304347837"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls210923.91304347837"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls310923.91304347837"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls410923.91304347837"))
			end
		end
		if (11250 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11250) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + -2, 0.1 , 'quadInOut');
			thecooly = -20
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls1112506', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls2112506', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls3112506', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls4112506', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11250 / 1000 <= ballssimulatorroblox / 1000) then
			if (11250 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls1112506"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls2112506"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls3112506"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls4112506"))
			end
		end
		if (11413.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11413.0434782609) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 2, 0.1 , 'quadInOut');
			thecooly = 40
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111413.04347826095', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211413.04347826095', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311413.04347826095', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411413.04347826095', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11413.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (11413.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111413.04347826095"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211413.04347826095"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311413.04347826095"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411413.04347826095"))
			end
		end
		if (11576.0869565217 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11576.0869565217) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111576.08695652174', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211576.08695652174', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311576.08695652174', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411576.08695652174', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11576.0869565217 / 1000 <= ballssimulatorroblox / 1000) then
			if (11576.0869565217 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111576.08695652174"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211576.08695652174"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311576.08695652174"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411576.08695652174"))
			end
		end
		if (11576.0869565217 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11576.0869565217) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111576.08695652175', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211576.08695652175', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311576.08695652175', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411576.08695652175', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11576.0869565217 / 1000 <= ballssimulatorroblox / 1000) then
			if (11576.0869565217 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111576.08695652175"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211576.08695652175"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311576.08695652175"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411576.08695652175"))
			end
		end
		if (11576.0869565217 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11576.0869565217) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111576.08695652176', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211576.08695652176', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311576.08695652176', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411576.08695652176', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11576.0869565217 / 1000 <= ballssimulatorroblox / 1000) then
			if (11576.0869565217 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111576.08695652176"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211576.08695652176"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311576.08695652176"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411576.08695652176"))
			end
		end
		if (11576.0869565217 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11576.0869565217) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 34, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111576.08695652177', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211576.08695652177', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311576.08695652177', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411576.08695652177', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11576.0869565217 / 1000 <= ballssimulatorroblox / 1000) then
			if (11576.0869565217 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111576.08695652177"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211576.08695652177"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311576.08695652177"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411576.08695652177"))
			end
		end
		if (11739.1304347826 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11739.1304347826) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -28, 0.1 , 'quadInOut');
			thecooly = -4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111739.13043478264', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211739.13043478264', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311739.13043478264', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411739.13043478264', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11739.1304347826 / 1000 <= ballssimulatorroblox / 1000) then
			if (11739.1304347826 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111739.13043478264"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211739.13043478264"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311739.13043478264"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411739.13043478264"))
			end
		end
		if (11739.1304347826 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11739.1304347826) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 34, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111739.13043478267', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211739.13043478267', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311739.13043478267', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411739.13043478267', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11739.1304347826 / 1000 <= ballssimulatorroblox / 1000) then
			if (11739.1304347826 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111739.13043478267"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211739.13043478267"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311739.13043478267"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411739.13043478267"))
			end
		end
		if (11902.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11902.1739130435) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 4, 0.1 , 'quadInOut');
			thecooly = 106
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111902.17391304355', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211902.17391304355', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311902.17391304355', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411902.17391304355', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11902.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (11902.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111902.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211902.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311902.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411902.17391304355"))
			end
		end
		if (11902.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 11902.1739130435) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls111902.17391304356', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls211902.17391304356', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls311902.17391304356', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls411902.17391304356', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (11902.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (11902.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls111902.17391304356"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls211902.17391304356"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls311902.17391304356"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls411902.17391304356"))
			end
		end
		if (12228.2608695652 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12228.2608695652) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112228.26086956524', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212228.26086956524', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312228.26086956524', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412228.26086956524', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12228.2608695652 / 1000 <= ballssimulatorroblox / 1000) then
			if (12228.2608695652 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112228.26086956524"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212228.26086956524"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312228.26086956524"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412228.26086956524"))
			end
		end
		if (12228.2608695652 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12228.2608695652) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112228.26086956525', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212228.26086956525', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312228.26086956525', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412228.26086956525', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12228.2608695652 / 1000 <= ballssimulatorroblox / 1000) then
			if (12228.2608695652 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112228.26086956525"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212228.26086956525"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312228.26086956525"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412228.26086956525"))
			end
		end
		if (12228.2608695652 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12228.2608695652) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112228.26086956526', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212228.26086956526', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312228.26086956526', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412228.26086956526', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12228.2608695652 / 1000 <= ballssimulatorroblox / 1000) then
			if (12228.2608695652 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112228.26086956526"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212228.26086956526"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312228.26086956526"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412228.26086956526"))
			end
		end
		if (12228.2608695652 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12228.2608695652) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112228.26086956527', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212228.26086956527', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312228.26086956527', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412228.26086956527', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12228.2608695652 / 1000 <= ballssimulatorroblox / 1000) then
			if (12228.2608695652 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112228.26086956527"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212228.26086956527"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312228.26086956527"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412228.26086956527"))
			end
		end
		if (12554.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12554.347826087) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + -2, 0.1 , 'quadInOut');
			thecooly = -20
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112554.3478260876', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212554.3478260876', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312554.3478260876', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412554.3478260876', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12554.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (12554.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112554.3478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212554.3478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312554.3478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412554.3478260876"))
			end
		end
		if (12717.3913043478 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12717.3913043478) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 2, 0.1 , 'quadInOut');
			thecooly = 40
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112717.39130434785', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212717.39130434785', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312717.39130434785', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412717.39130434785', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12717.3913043478 / 1000 <= ballssimulatorroblox / 1000) then
			if (12717.3913043478 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112717.39130434785"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212717.39130434785"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312717.39130434785"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412717.39130434785"))
			end
		end
		if (12880.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12880.4347826087) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112880.43478260874', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212880.43478260874', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312880.43478260874', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412880.43478260874', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12880.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (12880.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112880.43478260874"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212880.43478260874"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312880.43478260874"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412880.43478260874"))
			end
		end
		if (12880.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12880.4347826087) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112880.43478260875', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212880.43478260875', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312880.43478260875', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412880.43478260875', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12880.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (12880.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112880.43478260875"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212880.43478260875"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312880.43478260875"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412880.43478260875"))
			end
		end
		if (12880.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12880.4347826087) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112880.43478260876', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212880.43478260876', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312880.43478260876', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412880.43478260876', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12880.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (12880.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112880.43478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212880.43478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312880.43478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412880.43478260876"))
			end
		end
		if (12880.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 12880.4347826087) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 34, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls112880.43478260877', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls212880.43478260877', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls312880.43478260877', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls412880.43478260877', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (12880.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (12880.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls112880.43478260877"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls212880.43478260877"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls312880.43478260877"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls412880.43478260877"))
			end
		end
		if (13043.4782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 13043.4782608696) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -4, 0.1 , 'quadInOut');
			thecooly = 26
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls113043.47826086964', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls213043.47826086964', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls313043.47826086964', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls413043.47826086964', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (13043.4782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (13043.4782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls113043.47826086964"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls213043.47826086964"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls313043.47826086964"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls413043.47826086964"))
			end
		end
		if (13206.5217391304 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 13206.5217391304) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 2, 0.1 , 'quadInOut');
			thecooly = 58
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls113206.52173913045', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls213206.52173913045', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls313206.52173913045', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls413206.52173913045', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (13206.5217391304 / 1000 <= ballssimulatorroblox / 1000) then
			if (13206.5217391304 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls113206.52173913045"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls213206.52173913045"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls313206.52173913045"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls413206.52173913045"))
			end
		end
		if (13369.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 13369.5652173913) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 12, 0.1 , 'quadInOut');
			thecooly = 122
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls113369.56521739136', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls213369.56521739136', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls313369.56521739136', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls413369.56521739136', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (13369.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (13369.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls113369.56521739136"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls213369.56521739136"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls313369.56521739136"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls413369.56521739136"))
			end
		end
		if (13532.6086956522 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 13532.6086956522) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 12, 0.1 , 'quadInOut');
			thecooly = 196
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls113532.60869565227', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls213532.60869565227', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls313532.60869565227', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls413532.60869565227', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (13532.6086956522 / 1000 <= ballssimulatorroblox / 1000) then
			if (13532.6086956522 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls113532.60869565227"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls213532.60869565227"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls313532.60869565227"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls413532.60869565227"))
			end
		end
		if (13695.652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 13695.652173913) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 12, 0.1 , 'quadInOut');
			thecooly = 108
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls113695.6521739136', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls213695.6521739136', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls313695.6521739136', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls413695.6521739136', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (13695.652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (13695.652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls113695.6521739136"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls213695.6521739136"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls313695.6521739136"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls413695.6521739136"))
			end
		end
		if (13858.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 13858.6956521739) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 10, 0.1 , 'quadInOut');
			thecooly = 80
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls113858.69565217396', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls213858.69565217396', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls313858.69565217396', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls413858.69565217396', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (13858.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (13858.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls113858.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls213858.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls313858.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls413858.69565217396"))
			end
		end
		if (14021.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 14021.7391304348) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 0, 0.1 , 'quadInOut');
			thecooly = 52
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls114021.73913043487', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls214021.73913043487', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls314021.73913043487', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls414021.73913043487', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (14021.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (14021.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls114021.73913043487"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls214021.73913043487"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls314021.73913043487"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls414021.73913043487"))
			end
		end
		if (14184.7826086956 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 14184.7826086956) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 28
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls114184.78260869565', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls214184.78260869565', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls314184.78260869565', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls414184.78260869565', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (14184.7826086956 / 1000 <= ballssimulatorroblox / 1000) then
			if (14184.7826086956 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls114184.78260869565"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls214184.78260869565"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls314184.78260869565"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls414184.78260869565"))
			end
		end
		if (14347.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 14347.8260869565) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -4, 0.1 , 'quadInOut');
			thecooly = 26
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls114347.82608695654', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls214347.82608695654', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls314347.82608695654', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls414347.82608695654', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (14347.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (14347.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls114347.82608695654"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls214347.82608695654"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls314347.82608695654"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls414347.82608695654"))
			end
		end
		if (14510.8695652174 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 14510.8695652174) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 2, 0.1 , 'quadInOut');
			thecooly = 58
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls114510.86956521745', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls214510.86956521745', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls314510.86956521745', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls414510.86956521745', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (14510.8695652174 / 1000 <= ballssimulatorroblox / 1000) then
			if (14510.8695652174 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls114510.86956521745"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls214510.86956521745"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls314510.86956521745"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls414510.86956521745"))
			end
		end
		if (14673.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 14673.9130434783) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 12, 0.1 , 'quadInOut');
			thecooly = 122
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls114673.91304347836', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls214673.91304347836', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls314673.91304347836', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls414673.91304347836', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (14673.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (14673.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls114673.91304347836"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls214673.91304347836"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls314673.91304347836"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls414673.91304347836"))
			end
		end
		if (14836.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 14836.9565217391) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 12, 0.1 , 'quadInOut');
			thecooly = 196
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls114836.95652173917', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls214836.95652173917', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls314836.95652173917', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls414836.95652173917', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (14836.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (14836.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls114836.95652173917"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls214836.95652173917"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls314836.95652173917"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls414836.95652173917"))
			end
		end
		if (15000 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15000) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 12, 0.1 , 'quadInOut');
			thecooly = 108
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls1150006', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls2150006', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls3150006', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls4150006', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (15000 / 1000 <= ballssimulatorroblox / 1000) then
			if (15000 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls1150006"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls2150006"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls3150006"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls4150006"))
			end
		end
		if (15163.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15163.0434782609) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 10, 0.1 , 'quadInOut');
			thecooly = 80
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls115163.04347826096', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls215163.04347826096', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls315163.04347826096', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls415163.04347826096', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (15163.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (15163.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115163.04347826096"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215163.04347826096"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315163.04347826096"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415163.04347826096"))
			end
		end
		if (15326.0869565217 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15326.0869565217) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 0, 0.1 , 'quadInOut');
			thecooly = 52
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls115326.08695652177', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls215326.08695652177', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls315326.08695652177', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls415326.08695652177', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (15326.0869565217 / 1000 <= ballssimulatorroblox / 1000) then
			if (15326.0869565217 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115326.08695652177"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215326.08695652177"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315326.08695652177"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415326.08695652177"))
			end
		end
		if (15489.1304347826 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15489.1304347826) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 28
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls115489.13043478265', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls215489.13043478265', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls315489.13043478265', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls415489.13043478265', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (15489.1304347826 / 1000 <= ballssimulatorroblox / 1000) then
			if (15489.1304347826 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115489.13043478265"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215489.13043478265"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315489.13043478265"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415489.13043478265"))
			end
		end
		if (15652.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15652.1739130435) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 0, 0.2 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.2 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.2 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.2 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.2 , 'quadInOut');
		
			end
			tween_value('balls115652.17391304354', ballsx, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls215652.17391304354', ballsy, 0 * yMultiply, 0.2, 'quadInOut')
			tween_value('balls315652.17391304354', ballswidth, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls415652.17391304354', ballsheight, 0 * yMultiply, 0.2, 'quadInOut')
			end
	end
		if (15652.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (15652.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.2) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115652.17391304354"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215652.17391304354"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315652.17391304354"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415652.17391304354"))
			end
		end
		if (15652.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15652.1739130435) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.2 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.2 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.2 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.2 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.2 , 'quadInOut');
		
			end
			tween_value('balls115652.17391304355', ballsx, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls215652.17391304355', ballsy, 0 * yMultiply, 0.2, 'quadInOut')
			tween_value('balls315652.17391304355', ballswidth, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls415652.17391304355', ballsheight, 0 * yMultiply, 0.2, 'quadInOut')
			end
	end
		if (15652.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (15652.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.2) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115652.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215652.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315652.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415652.17391304355"))
			end
		end
		if (15652.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15652.1739130435) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -28, 0.1 , 'quadInOut');
			thecooly = -4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls115652.17391304350', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls215652.17391304350', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls315652.17391304350', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls415652.17391304350', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (15652.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (15652.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115652.17391304350"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215652.17391304350"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315652.17391304350"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415652.17391304350"))
			end
		end
		if (15652.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15652.1739130435) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 34, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls115652.17391304353', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls215652.17391304353', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls315652.17391304353', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls415652.17391304353', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (15652.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (15652.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115652.17391304353"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215652.17391304353"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315652.17391304353"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415652.17391304353"))
			end
		end
		if (15733.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15733.6956521739) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 0, 0.2 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.2 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.2 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.2 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.2 , 'quadInOut');
		
			end
			tween_value('balls115733.69565217396', ballsx, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls215733.69565217396', ballsy, 0 * yMultiply, 0.2, 'quadInOut')
			tween_value('balls315733.69565217396', ballswidth, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls415733.69565217396', ballsheight, 0 * yMultiply, 0.2, 'quadInOut')
			end
	end
		if (15733.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (15733.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.2) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115733.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215733.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315733.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415733.69565217396"))
			end
		end
		if (15733.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15733.6956521739) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 0, 0.2 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.2 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.2 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.2 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.2 , 'quadInOut');
		
			end
			tween_value('balls115733.69565217397', ballsx, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls215733.69565217397', ballsy, 0 * yMultiply, 0.2, 'quadInOut')
			tween_value('balls315733.69565217397', ballswidth, 0 * xMultiply, 0.2, 'quadInOut')
			tween_value('balls415733.69565217397', ballsheight, 0 * yMultiply, 0.2, 'quadInOut')
			end
	end
		if (15733.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (15733.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.2) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115733.69565217397"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215733.69565217397"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315733.69565217397"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415733.69565217397"))
			end
		end
		if (15815.2173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15815.2173913043) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 4, 0.1 , 'quadInOut');
			thecooly = 106
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls115815.21739130431', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls215815.21739130431', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls315815.21739130431', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls415815.21739130431', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (15815.2173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (15815.2173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115815.21739130431"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215815.21739130431"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315815.21739130431"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415815.21739130431"))
			end
		end
		if (15815.2173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 15815.2173913043) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls115815.21739130432', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls215815.21739130432', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls315815.21739130432', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls415815.21739130432', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (15815.2173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (15815.2173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls115815.21739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls215815.21739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls315815.21739130432"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls415815.21739130432"))
			end
		end
		if (16141.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16141.3043478261) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116141.30434782610', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216141.30434782610', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316141.30434782610', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416141.30434782610', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16141.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (16141.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116141.30434782610"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216141.30434782610"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316141.30434782610"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416141.30434782610"))
			end
		end
		if (16141.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16141.3043478261) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116141.30434782611', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216141.30434782611', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316141.30434782611', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416141.30434782611', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16141.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (16141.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116141.30434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216141.30434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316141.30434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416141.30434782611"))
			end
		end
		if (16141.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16141.3043478261) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116141.30434782612', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216141.30434782612', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316141.30434782612', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416141.30434782612', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16141.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (16141.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116141.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216141.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316141.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416141.30434782612"))
			end
		end
		if (16141.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16141.3043478261) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116141.30434782613', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216141.30434782613', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316141.30434782613', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416141.30434782613', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16141.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (16141.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116141.30434782613"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216141.30434782613"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316141.30434782613"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416141.30434782613"))
			end
		end
		if (16467.3913043478 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16467.3913043478) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + -2, 0.1 , 'quadInOut');
			thecooly = -20
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116467.39130434782', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216467.39130434782', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316467.39130434782', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416467.39130434782', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16467.3913043478 / 1000 <= ballssimulatorroblox / 1000) then
			if (16467.3913043478 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116467.39130434782"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216467.39130434782"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316467.39130434782"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416467.39130434782"))
			end
		end
		if (16630.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16630.4347826087) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 2, 0.1 , 'quadInOut');
			thecooly = 40
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116630.43478260871', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216630.43478260871', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316630.43478260871', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416630.43478260871', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16630.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (16630.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116630.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216630.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316630.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416630.43478260871"))
			end
		end
		if (16793.4782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16793.4782608696) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116793.47826086960', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216793.47826086960', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316793.47826086960', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416793.47826086960', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16793.4782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (16793.4782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116793.47826086960"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216793.47826086960"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316793.47826086960"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416793.47826086960"))
			end
		end
		if (16793.4782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16793.4782608696) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116793.47826086961', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216793.47826086961', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316793.47826086961', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416793.47826086961', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16793.4782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (16793.4782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116793.47826086961"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216793.47826086961"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316793.47826086961"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416793.47826086961"))
			end
		end
		if (16793.4782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16793.4782608696) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116793.47826086962', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216793.47826086962', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316793.47826086962', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416793.47826086962', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16793.4782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (16793.4782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116793.47826086962"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216793.47826086962"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316793.47826086962"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416793.47826086962"))
			end
		end
		if (16793.4782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16793.4782608696) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 34, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116793.47826086963', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216793.47826086963', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316793.47826086963', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416793.47826086963', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16793.4782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (16793.4782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116793.47826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216793.47826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316793.47826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416793.47826086963"))
			end
		end
		if (16956.5217391304 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16956.5217391304) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -28, 0.1 , 'quadInOut');
			thecooly = -4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116956.52173913040', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216956.52173913040', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316956.52173913040', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416956.52173913040', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16956.5217391304 / 1000 <= ballssimulatorroblox / 1000) then
			if (16956.5217391304 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116956.52173913040"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216956.52173913040"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316956.52173913040"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416956.52173913040"))
			end
		end
		if (16956.5217391304 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 16956.5217391304) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 34, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls116956.52173913043', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls216956.52173913043', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls316956.52173913043', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls416956.52173913043', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (16956.5217391304 / 1000 <= ballssimulatorroblox / 1000) then
			if (16956.5217391304 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls116956.52173913043"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls216956.52173913043"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls316956.52173913043"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls416956.52173913043"))
			end
		end
		if (17119.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 17119.5652173913) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 4, 0.1 , 'quadInOut');
			thecooly = 106
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls117119.56521739131', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls217119.56521739131', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls317119.56521739131', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls417119.56521739131', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (17119.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (17119.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls117119.56521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls217119.56521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls317119.56521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls417119.56521739131"))
			end
		end
		if (17119.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 17119.5652173913) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls117119.56521739132', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls217119.56521739132', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls317119.56521739132', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls417119.56521739132', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (17119.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (17119.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls117119.56521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls217119.56521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls317119.56521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls417119.56521739132"))
			end
		end
		if (17445.652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 17445.652173913) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls117445.6521739130', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls217445.6521739130', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls317445.6521739130', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls417445.6521739130', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (17445.652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (17445.652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls117445.6521739130"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls217445.6521739130"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls317445.6521739130"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls417445.6521739130"))
			end
		end
		if (17445.652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 17445.652173913) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls117445.6521739131', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls217445.6521739131', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls317445.6521739131', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls417445.6521739131', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (17445.652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (17445.652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls117445.6521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls217445.6521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls317445.6521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls417445.6521739131"))
			end
		end
		if (17445.652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 17445.652173913) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls117445.6521739132', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls217445.6521739132', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls317445.6521739132', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls417445.6521739132', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (17445.652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (17445.652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls117445.6521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls217445.6521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls317445.6521739132"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls417445.6521739132"))
			end
		end
		if (17445.652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 17445.652173913) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls117445.6521739133', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls217445.6521739133', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls317445.6521739133', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls417445.6521739133', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (17445.652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (17445.652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls117445.6521739133"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls217445.6521739133"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls317445.6521739133"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls417445.6521739133"))
			end
		end
		if (17771.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 17771.7391304348) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + -2, 0.1 , 'quadInOut');
			thecooly = -20
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls117771.73913043482', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls217771.73913043482', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls317771.73913043482', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls417771.73913043482', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (17771.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (17771.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls117771.73913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls217771.73913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls317771.73913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls417771.73913043482"))
			end
		end
		if (17934.7826086957 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 17934.7826086957) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 2, 0.1 , 'quadInOut');
			thecooly = 40
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls117934.78260869571', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls217934.78260869571', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls317934.78260869571', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls417934.78260869571', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (17934.7826086957 / 1000 <= ballssimulatorroblox / 1000) then
			if (17934.7826086957 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls117934.78260869571"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls217934.78260869571"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls317934.78260869571"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls417934.78260869571"))
			end
		end
		if (18097.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18097.8260869565) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls118097.82608695650', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls218097.82608695650', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls318097.82608695650', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls418097.82608695650', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18097.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (18097.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls118097.82608695650"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls218097.82608695650"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls318097.82608695650"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls418097.82608695650"))
			end
		end
		if (18097.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18097.8260869565) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls118097.82608695651', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls218097.82608695651', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls318097.82608695651', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls418097.82608695651', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18097.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (18097.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls118097.82608695651"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls218097.82608695651"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls318097.82608695651"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls418097.82608695651"))
			end
		end
		if (18097.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18097.8260869565) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls118097.82608695652', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls218097.82608695652', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls318097.82608695652', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls418097.82608695652', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18097.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (18097.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls118097.82608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls218097.82608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls318097.82608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls418097.82608695652"))
			end
		end
		if (18097.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18097.8260869565) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 34, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls118097.82608695653', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls218097.82608695653', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls318097.82608695653', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls418097.82608695653', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18097.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (18097.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls118097.82608695653"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls218097.82608695653"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls318097.82608695653"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls418097.82608695653"))
			end
		end
		if (18260.8695652174 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18260.8695652174) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -4, 0.1 , 'quadInOut');
			thecooly = 26
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls118260.86956521740', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls218260.86956521740', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls318260.86956521740', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls418260.86956521740', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18260.8695652174 / 1000 <= ballssimulatorroblox / 1000) then
			if (18260.8695652174 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls118260.86956521740"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls218260.86956521740"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls318260.86956521740"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls418260.86956521740"))
			end
		end
		if (18423.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18423.9130434783) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 2, 0.1 , 'quadInOut');
			thecooly = 58
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls118423.91304347831', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls218423.91304347831', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls318423.91304347831', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls418423.91304347831', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18423.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (18423.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls118423.91304347831"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls218423.91304347831"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls318423.91304347831"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls418423.91304347831"))
			end
		end
		if (18586.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18586.9565217391) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 12, 0.1 , 'quadInOut');
			thecooly = 122
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls118586.95652173912', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls218586.95652173912', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls318586.95652173912', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls418586.95652173912', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18586.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (18586.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls118586.95652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls218586.95652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls318586.95652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls418586.95652173912"))
			end
		end
		if (18750 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18750) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 12, 0.1 , 'quadInOut');
			thecooly = 196
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls1187503', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls2187503', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls3187503', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls4187503', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18750 / 1000 <= ballssimulatorroblox / 1000) then
			if (18750 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls1187503"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls2187503"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls3187503"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls4187503"))
			end
		end
		if (18913.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 18913.0434782609) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 12, 0.1 , 'quadInOut');
			thecooly = 108
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls118913.04347826092', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls218913.04347826092', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls318913.04347826092', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls418913.04347826092', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (18913.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (18913.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls118913.04347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls218913.04347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls318913.04347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls418913.04347826092"))
			end
		end
		if (19076.0869565217 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 19076.0869565217) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 10, 0.1 , 'quadInOut');
			thecooly = 80
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls119076.08695652172', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls219076.08695652172', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls319076.08695652172', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls419076.08695652172', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (19076.0869565217 / 1000 <= ballssimulatorroblox / 1000) then
			if (19076.0869565217 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls119076.08695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls219076.08695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls319076.08695652172"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls419076.08695652172"))
			end
		end
		if (19239.1304347826 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 19239.1304347826) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 52
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls119239.13043478263', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls219239.13043478263', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls319239.13043478263', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls419239.13043478263', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (19239.1304347826 / 1000 <= ballssimulatorroblox / 1000) then
			if (19239.1304347826 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls119239.13043478263"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls219239.13043478263"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls319239.13043478263"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls419239.13043478263"))
			end
		end
		if (19402.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 19402.1739130435) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 28
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls119402.17391304351', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls219402.17391304351', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls319402.17391304351', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls419402.17391304351', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (19402.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (19402.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls119402.17391304351"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls219402.17391304351"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls319402.17391304351"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls419402.17391304351"))
			end
		end
		if (19565.2173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 19565.2173913043) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -4, 0.1 , 'quadInOut');
			thecooly = 26
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls119565.21739130430', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls219565.21739130430', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls319565.21739130430', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls419565.21739130430', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (19565.2173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (19565.2173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls119565.21739130430"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls219565.21739130430"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls319565.21739130430"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls419565.21739130430"))
			end
		end
		if (19728.2608695652 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 19728.2608695652) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 2, 0.1 , 'quadInOut');
			thecooly = 58
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls119728.26086956521', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls219728.26086956521', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls319728.26086956521', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls419728.26086956521', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (19728.2608695652 / 1000 <= ballssimulatorroblox / 1000) then
			if (19728.2608695652 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls119728.26086956521"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls219728.26086956521"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls319728.26086956521"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls419728.26086956521"))
			end
		end
		if (19891.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 19891.3043478261) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 12, 0.1 , 'quadInOut');
			thecooly = 122
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls119891.30434782612', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls219891.30434782612', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls319891.30434782612', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls419891.30434782612', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (19891.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (19891.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls119891.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls219891.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls319891.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls419891.30434782612"))
			end
		end
		if (20054.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 20054.347826087) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 12, 0.1 , 'quadInOut');
			thecooly = 196
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls120054.3478260873', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls220054.3478260873', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls320054.3478260873', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls420054.3478260873', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (20054.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (20054.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls120054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls220054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls320054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls420054.3478260873"))
			end
		end
		if (20217.3913043478 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 20217.3913043478) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 12, 0.1 , 'quadInOut');
			thecooly = 108
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls120217.39130434782', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls220217.39130434782', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls320217.39130434782', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls420217.39130434782', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (20217.3913043478 / 1000 <= ballssimulatorroblox / 1000) then
			if (20217.3913043478 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls120217.39130434782"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls220217.39130434782"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls320217.39130434782"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls420217.39130434782"))
			end
		end
		if (20380.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 20380.4347826087) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 10, 0.1 , 'quadInOut');
			thecooly = 80
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls120380.43478260872', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls220380.43478260872', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls320380.43478260872', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls420380.43478260872', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (20380.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (20380.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls120380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls220380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls320380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls420380.43478260872"))
			end
		end
		if (20543.4782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 20543.4782608696) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 52
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls120543.47826086963', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls220543.47826086963', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls320543.47826086963', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls420543.47826086963', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (20543.4782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (20543.4782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls120543.47826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls220543.47826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls320543.47826086963"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls420543.47826086963"))
			end
		end
		if (20706.5217391304 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 20706.5217391304) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 28
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls120706.52173913041', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls220706.52173913041', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls320706.52173913041', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls420706.52173913041', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (20706.5217391304 / 1000 <= ballssimulatorroblox / 1000) then
			if (20706.5217391304 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls120706.52173913041"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls220706.52173913041"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls320706.52173913041"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls420706.52173913041"))
			end
		end
		if (20869.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 20869.5652173913) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -28, 0.1 , 'quadInOut');
			thecooly = -4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls120869.56521739134', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls220869.56521739134', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls320869.56521739134', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls420869.56521739134', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (20869.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (20869.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls120869.56521739134"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls220869.56521739134"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls320869.56521739134"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls420869.56521739134"))
			end
		end
		if (20869.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 20869.5652173913) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 34, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls120869.56521739137', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls220869.56521739137', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls320869.56521739137', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls420869.56521739137', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (20869.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (20869.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls120869.56521739137"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls220869.56521739137"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls320869.56521739137"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls420869.56521739137"))
			end
		end
		if (21032.6086956522 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 21032.6086956522) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 4, 0.1 , 'quadInOut');
			thecooly = 106
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls121032.60869565225', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls221032.60869565225', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls321032.60869565225', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls421032.60869565225', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (21032.6086956522 / 1000 <= ballssimulatorroblox / 1000) then
			if (21032.6086956522 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls121032.60869565225"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls221032.60869565225"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls321032.60869565225"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls421032.60869565225"))
			end
		end
		if (21032.6086956522 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 21032.6086956522) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls121032.60869565226', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls221032.60869565226', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls321032.60869565226', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls421032.60869565226', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (21032.6086956522 / 1000 <= ballssimulatorroblox / 1000) then
			if (21032.6086956522 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls121032.60869565226"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls221032.60869565226"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls321032.60869565226"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls421032.60869565226"))
			end
		end
		if (21358.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 21358.6956521739) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls121358.69565217394', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls221358.69565217394', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls321358.69565217394', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls421358.69565217394', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (21358.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (21358.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls121358.69565217394"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls221358.69565217394"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls321358.69565217394"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls421358.69565217394"))
			end
		end
		if (21358.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 21358.6956521739) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls121358.69565217395', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls221358.69565217395', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls321358.69565217395', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls421358.69565217395', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (21358.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (21358.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls121358.69565217395"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls221358.69565217395"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls321358.69565217395"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls421358.69565217395"))
			end
		end
		if (21358.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 21358.6956521739) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls121358.69565217396', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls221358.69565217396', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls321358.69565217396', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls421358.69565217396', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (21358.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (21358.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls121358.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls221358.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls321358.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls421358.69565217396"))
			end
		end
		if (21358.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 21358.6956521739) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls121358.69565217397', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls221358.69565217397', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls321358.69565217397', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls421358.69565217397', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (21358.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (21358.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls121358.69565217397"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls221358.69565217397"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls321358.69565217397"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls421358.69565217397"))
			end
		end
		if (21684.7826086956 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 21684.7826086956) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + -2, 0.1 , 'quadInOut');
			thecooly = -20
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls121684.78260869566', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls221684.78260869566', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls321684.78260869566', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls421684.78260869566', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (21684.7826086956 / 1000 <= ballssimulatorroblox / 1000) then
			if (21684.7826086956 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls121684.78260869566"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls221684.78260869566"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls321684.78260869566"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls421684.78260869566"))
			end
		end
		if (21847.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 21847.8260869565) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 2, 0.1 , 'quadInOut');
			thecooly = 40
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls121847.82608695655', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls221847.82608695655', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls321847.82608695655', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls421847.82608695655', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (21847.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (21847.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls121847.82608695655"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls221847.82608695655"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls321847.82608695655"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls421847.82608695655"))
			end
		end
		if (22010.8695652174 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22010.8695652174) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122010.86956521744', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222010.86956521744', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322010.86956521744', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422010.86956521744', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22010.8695652174 / 1000 <= ballssimulatorroblox / 1000) then
			if (22010.8695652174 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122010.86956521744"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222010.86956521744"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322010.86956521744"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422010.86956521744"))
			end
		end
		if (22010.8695652174 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22010.8695652174) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122010.86956521745', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222010.86956521745', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322010.86956521745', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422010.86956521745', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22010.8695652174 / 1000 <= ballssimulatorroblox / 1000) then
			if (22010.8695652174 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122010.86956521745"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222010.86956521745"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322010.86956521745"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422010.86956521745"))
			end
		end
		if (22010.8695652174 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22010.8695652174) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122010.86956521746', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222010.86956521746', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322010.86956521746', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422010.86956521746', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22010.8695652174 / 1000 <= ballssimulatorroblox / 1000) then
			if (22010.8695652174 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122010.86956521746"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222010.86956521746"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322010.86956521746"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422010.86956521746"))
			end
		end
		if (22010.8695652174 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22010.8695652174) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 34, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122010.86956521747', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222010.86956521747', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322010.86956521747', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422010.86956521747', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22010.8695652174 / 1000 <= ballssimulatorroblox / 1000) then
			if (22010.8695652174 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122010.86956521747"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222010.86956521747"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322010.86956521747"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422010.86956521747"))
			end
		end
		if (22173.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22173.9130434783) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -28, 0.1 , 'quadInOut');
			thecooly = -4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122173.91304347834', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222173.91304347834', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322173.91304347834', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422173.91304347834', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22173.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (22173.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122173.91304347834"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222173.91304347834"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322173.91304347834"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422173.91304347834"))
			end
		end
		if (22173.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22173.9130434783) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 34, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122173.91304347837', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222173.91304347837', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322173.91304347837', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422173.91304347837', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22173.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (22173.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122173.91304347837"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222173.91304347837"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322173.91304347837"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422173.91304347837"))
			end
		end
		if (22336.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22336.9565217391) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 4, 0.1 , 'quadInOut');
			thecooly = 106
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122336.95652173915', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222336.95652173915', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322336.95652173915', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422336.95652173915', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22336.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (22336.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122336.95652173915"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222336.95652173915"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322336.95652173915"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422336.95652173915"))
			end
		end
		if (22336.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22336.9565217391) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122336.95652173916', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222336.95652173916', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322336.95652173916', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422336.95652173916', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22336.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (22336.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122336.95652173916"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222336.95652173916"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322336.95652173916"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422336.95652173916"))
			end
		end
		if (22663.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22663.0434782609) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122663.04347826094', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222663.04347826094', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322663.04347826094', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422663.04347826094', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22663.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (22663.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122663.04347826094"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222663.04347826094"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322663.04347826094"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422663.04347826094"))
			end
		end
		if (22663.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22663.0434782609) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122663.04347826095', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222663.04347826095', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322663.04347826095', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422663.04347826095', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22663.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (22663.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122663.04347826095"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222663.04347826095"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322663.04347826095"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422663.04347826095"))
			end
		end
		if (22663.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22663.0434782609) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122663.04347826096', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222663.04347826096', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322663.04347826096', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422663.04347826096', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22663.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (22663.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122663.04347826096"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222663.04347826096"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322663.04347826096"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422663.04347826096"))
			end
		end
		if (22663.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22663.0434782609) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 4, 0.1 , 'quadInOut');
			thecooly = 102
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122663.04347826097', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222663.04347826097', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322663.04347826097', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422663.04347826097', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22663.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (22663.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122663.04347826097"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222663.04347826097"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322663.04347826097"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422663.04347826097"))
			end
		end
		if (22989.1304347826 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 22989.1304347826) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + -2, 0.1 , 'quadInOut');
			thecooly = -20
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls122989.13043478266', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls222989.13043478266', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls322989.13043478266', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls422989.13043478266', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (22989.1304347826 / 1000 <= ballssimulatorroblox / 1000) then
			if (22989.1304347826 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls122989.13043478266"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls222989.13043478266"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls322989.13043478266"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls422989.13043478266"))
			end
		end
		if (23152.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23152.1739130435) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 2, 0.1 , 'quadInOut');
			thecooly = 40
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123152.17391304355', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223152.17391304355', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323152.17391304355', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423152.17391304355', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23152.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (23152.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123152.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223152.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323152.17391304355"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423152.17391304355"))
			end
		end
		if (23315.2173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23315.2173913043) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123315.21739130434', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223315.21739130434', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323315.21739130434', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423315.21739130434', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23315.2173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (23315.2173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123315.21739130434"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223315.21739130434"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323315.21739130434"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423315.21739130434"))
			end
		end
		if (23315.2173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23315.2173913043) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123315.21739130435', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223315.21739130435', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323315.21739130435', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423315.21739130435', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23315.2173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (23315.2173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123315.21739130435"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223315.21739130435"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323315.21739130435"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423315.21739130435"))
			end
		end
		if (23315.2173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23315.2173913043) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 20, 0.1 , 'quadInOut');
			thecooly = -2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123315.21739130436', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223315.21739130436', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323315.21739130436', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423315.21739130436', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23315.2173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (23315.2173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123315.21739130436"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223315.21739130436"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323315.21739130436"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423315.21739130436"))
			end
		end
		if (23315.2173913043 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23315.2173913043) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 34, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123315.21739130437', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223315.21739130437', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323315.21739130437', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423315.21739130437', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23315.2173913043 / 1000 <= ballssimulatorroblox / 1000) then
			if (23315.2173913043 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123315.21739130437"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223315.21739130437"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323315.21739130437"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423315.21739130437"))
			end
		end
		if (23478.2608695652 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23478.2608695652) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -4, 0.1 , 'quadInOut');
			thecooly = 26
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123478.26086956524', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223478.26086956524', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323478.26086956524', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423478.26086956524', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23478.2608695652 / 1000 <= ballssimulatorroblox / 1000) then
			if (23478.2608695652 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123478.26086956524"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223478.26086956524"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323478.26086956524"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423478.26086956524"))
			end
		end
		if (23641.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23641.3043478261) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 2, 0.1 , 'quadInOut');
			thecooly = 58
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123641.30434782615', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223641.30434782615', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323641.30434782615', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423641.30434782615', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23641.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (23641.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123641.30434782615"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223641.30434782615"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323641.30434782615"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423641.30434782615"))
			end
		end
		if (23804.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23804.347826087) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 12, 0.1 , 'quadInOut');
			thecooly = 122
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123804.3478260876', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223804.3478260876', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323804.3478260876', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423804.3478260876', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23804.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (23804.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123804.3478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223804.3478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323804.3478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423804.3478260876"))
			end
		end
		if (23967.3913043478 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 23967.3913043478) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 12, 0.1 , 'quadInOut');
			thecooly = 196
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls123967.39130434787', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls223967.39130434787', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls323967.39130434787', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls423967.39130434787', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (23967.3913043478 / 1000 <= ballssimulatorroblox / 1000) then
			if (23967.3913043478 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls123967.39130434787"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls223967.39130434787"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls323967.39130434787"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls423967.39130434787"))
			end
		end
		if (24130.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 24130.4347826087) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 12, 0.1 , 'quadInOut');
			thecooly = 108
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls124130.43478260876', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls224130.43478260876', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls324130.43478260876', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls424130.43478260876', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (24130.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (24130.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls124130.43478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls224130.43478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls324130.43478260876"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls424130.43478260876"))
			end
		end
		if (24293.4782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 24293.4782608696) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 10, 0.1 , 'quadInOut');
			thecooly = 80
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls124293.47826086966', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls224293.47826086966', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls324293.47826086966', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls424293.47826086966', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (24293.4782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (24293.4782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls124293.47826086966"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls224293.47826086966"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls324293.47826086966"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls424293.47826086966"))
			end
		end
		if (24456.5217391304 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 24456.5217391304) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 0, 0.1 , 'quadInOut');
			thecooly = 52
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls124456.52173913047', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls224456.52173913047', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls324456.52173913047', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls424456.52173913047', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (24456.5217391304 / 1000 <= ballssimulatorroblox / 1000) then
			if (24456.5217391304 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls124456.52173913047"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls224456.52173913047"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls324456.52173913047"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls424456.52173913047"))
			end
		end
		if (24619.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 24619.5652173913) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 28
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls124619.56521739135', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls224619.56521739135', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls324619.56521739135', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls424619.56521739135', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (24619.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (24619.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls124619.56521739135"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls224619.56521739135"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls324619.56521739135"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls424619.56521739135"))
			end
		end
		if (24782.6086956522 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 24782.6086956522) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -4, 0.1 , 'quadInOut');
			thecooly = 26
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls124782.60869565224', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls224782.60869565224', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls324782.60869565224', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls424782.60869565224', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (24782.6086956522 / 1000 <= ballssimulatorroblox / 1000) then
			if (24782.6086956522 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls124782.60869565224"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls224782.60869565224"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls324782.60869565224"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls424782.60869565224"))
			end
		end
		if (24945.652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 24945.652173913) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 2, 0.1 , 'quadInOut');
			thecooly = 58
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls124945.6521739135', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls224945.6521739135', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls324945.6521739135', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls424945.6521739135', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (24945.652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (24945.652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls124945.6521739135"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls224945.6521739135"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls324945.6521739135"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls424945.6521739135"))
			end
		end
		if (25108.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 25108.6956521739) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 12, 0.1 , 'quadInOut');
			thecooly = 122
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls125108.69565217396', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls225108.69565217396', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls325108.69565217396', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls425108.69565217396', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (25108.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (25108.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls125108.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls225108.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls325108.69565217396"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls425108.69565217396"))
			end
		end
		if (25271.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 25271.7391304348) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 12, 0.1 , 'quadInOut');
			thecooly = 196
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls125271.73913043487', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls225271.73913043487', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls325271.73913043487', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls425271.73913043487', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (25271.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (25271.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls125271.73913043487"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls225271.73913043487"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls325271.73913043487"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls425271.73913043487"))
			end
		end
		if (25434.7826086956 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 25434.7826086956) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 196, 0.1 , 'quadInOut');
			thecooly = 118
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls125434.78260869562', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls225434.78260869562', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls325434.78260869562', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls425434.78260869562', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (25434.7826086956 / 1000 <= ballssimulatorroblox / 1000) then
			if (25434.7826086956 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls125434.78260869562"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls225434.78260869562"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls325434.78260869562"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls425434.78260869562"))
			end
		end
		if (25434.7826086956 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 25434.7826086956) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + -192, 0.1 , 'quadInOut');
			thecooly = 114
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls125434.78260869565', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls225434.78260869565', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls325434.78260869565', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls425434.78260869565', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (25434.7826086956 / 1000 <= ballssimulatorroblox / 1000) then
			if (25434.7826086956 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls125434.78260869565"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls225434.78260869565"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls325434.78260869565"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls425434.78260869565"))
			end
		end
		if (25679.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 25679.347826087) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 420, 0.1 , 'quadInOut');
			thecooly = 228
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls125679.3478260870', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls225679.3478260870', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls325679.3478260870', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls425679.3478260870', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (25679.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (25679.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls125679.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls225679.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls325679.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls425679.3478260870"))
			end
		end
		if (25679.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 25679.347826087) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + -400, 0.1 , 'quadInOut');
			thecooly = 228
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls125679.3478260877', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls225679.3478260877', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls325679.3478260877', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls425679.3478260877', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (25679.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (25679.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls125679.3478260877"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls225679.3478260877"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls325679.3478260877"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls425679.3478260877"))
			end
		end
		if (26086.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 26086.9565217391) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls126086.95652173910', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls226086.95652173910', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls326086.95652173910', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls426086.95652173910', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (26086.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (26086.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls126086.95652173910"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls226086.95652173910"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls326086.95652173910"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls426086.95652173910"))
			end
		end
		if (26086.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 26086.9565217391) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls126086.95652173912', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls226086.95652173912', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls326086.95652173912', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls426086.95652173912', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (26086.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (26086.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls126086.95652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls226086.95652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls326086.95652173912"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls426086.95652173912"))
			end
		end
		if (26086.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 26086.9565217391) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls126086.95652173911', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls226086.95652173911', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls326086.95652173911', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls426086.95652173911', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (26086.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (26086.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls126086.95652173911"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls226086.95652173911"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls326086.95652173911"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls426086.95652173911"))
			end
		end
		if (26086.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 26086.9565217391) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls126086.95652173913', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls226086.95652173913', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls326086.95652173913', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls426086.95652173913', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (26086.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (26086.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls126086.95652173913"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls226086.95652173913"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls326086.95652173913"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls426086.95652173913"))
			end
		end
		if (26086.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 26086.9565217391) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls126086.95652173914', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls226086.95652173914', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls326086.95652173914', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls426086.95652173914', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (26086.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (26086.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls126086.95652173914"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls226086.95652173914"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls326086.95652173914"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls426086.95652173914"))
			end
		end
		if (26086.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 26086.9565217391) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls126086.95652173915', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls226086.95652173915', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls326086.95652173915', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls426086.95652173915', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (26086.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (26086.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls126086.95652173915"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls226086.95652173915"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls326086.95652173915"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls426086.95652173915"))
			end
		end
		if (26086.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 26086.9565217391) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls126086.95652173916', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls226086.95652173916', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls326086.95652173916', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls426086.95652173916', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (26086.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (26086.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls126086.95652173916"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls226086.95652173916"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls326086.95652173916"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls426086.95652173916"))
			end
		end
		if (26086.9565217391 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 26086.9565217391) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls126086.95652173917', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls226086.95652173917', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls326086.95652173917', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls426086.95652173917', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (26086.9565217391 / 1000 <= ballssimulatorroblox / 1000) then
			if (26086.9565217391 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls126086.95652173917"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls226086.95652173917"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls326086.95652173917"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls426086.95652173917"))
			end
		end
		if (49565.2173913044 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 49565.2173913044) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls149565.21739130441', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls249565.21739130441', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls349565.21739130441', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls449565.21739130441', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (49565.2173913044 / 1000 <= ballssimulatorroblox / 1000) then
			if (49565.2173913044 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls149565.21739130441"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls249565.21739130441"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls349565.21739130441"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls449565.21739130441"))
			end
		end
		if (49728.2608695653 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 49728.2608695653) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls149728.26086956532', ballsx, 133 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls249728.26086956532', ballsy, 100 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls349728.26086956532', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls449728.26086956532', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (49728.2608695653 / 1000 <= ballssimulatorroblox / 1000) then
			if (49728.2608695653 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls149728.26086956532"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls249728.26086956532"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls349728.26086956532"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls449728.26086956532"))
			end
		end
		if (50054.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50054.347826087) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls150054.3478260870', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls250054.3478260870', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls350054.3478260870', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls450054.3478260870', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (50054.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (50054.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150054.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250054.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350054.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450054.3478260870"))
			end
		end
		if (50054.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50054.347826087) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls150054.3478260871', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls250054.3478260871', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls350054.3478260871', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls450054.3478260871', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (50054.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (50054.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150054.3478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250054.3478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350054.3478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450054.3478260871"))
			end
		end
		if (50054.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50054.347826087) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls150054.3478260873', ballsx, 245 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls250054.3478260873', ballsy, 176 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls350054.3478260873', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls450054.3478260873', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (50054.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (50054.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450054.3478260873"))
			end
		end
		if (50380.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50380.4347826087) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls150380.43478260872', ballsx, 320 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls250380.43478260872', ballsy, 216 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls350380.43478260872', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls450380.43478260872', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (50380.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (50380.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350380.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450380.43478260872"))
			end
		end
		if (50788.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50788.0434782609) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls150788.04347826092', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls250788.04347826092', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls350788.04347826092', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls450788.04347826092', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (50788.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (50788.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150788.04347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250788.04347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350788.04347826092"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450788.04347826092"))
			end
		end
		if (50788.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50788.0434782609) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls150788.04347826093', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls250788.04347826093', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls350788.04347826093', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls450788.04347826093', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (50788.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (50788.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150788.04347826093"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250788.04347826093"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350788.04347826093"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450788.04347826093"))
			end
		end
		if (50869.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50869.5652173913) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls150869.56521739131', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls250869.56521739131', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls350869.56521739131', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls450869.56521739131', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (50869.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (50869.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150869.56521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250869.56521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350869.56521739131"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450869.56521739131"))
			end
		end
		if (50869.5652173913 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50869.5652173913) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -22, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls150869.56521739134', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls250869.56521739134', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls350869.56521739134', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls450869.56521739134', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (50869.5652173913 / 1000 <= ballssimulatorroblox / 1000) then
			if (50869.5652173913 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150869.56521739134"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250869.56521739134"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350869.56521739134"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450869.56521739134"))
			end
		end
		if (51032.6086956522 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 51032.6086956522) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls151032.60869565222', ballsx, 133 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls251032.60869565222', ballsy, 100 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls351032.60869565222', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls451032.60869565222', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (51032.6086956522 / 1000 <= ballssimulatorroblox / 1000) then
			if (51032.6086956522 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls151032.60869565222"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls251032.60869565222"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls351032.60869565222"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls451032.60869565222"))
			end
		end
		if (51358.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 51358.6956521739) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls151358.69565217390', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls251358.69565217390', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls351358.69565217390', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls451358.69565217390', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (51358.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (51358.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls151358.69565217390"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls251358.69565217390"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls351358.69565217390"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls451358.69565217390"))
			end
		end
		if (51358.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 51358.6956521739) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls151358.69565217391', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls251358.69565217391', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls351358.69565217391', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls451358.69565217391', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (51358.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (51358.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls151358.69565217391"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls251358.69565217391"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls351358.69565217391"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls451358.69565217391"))
			end
		end
		if (51358.6956521739 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 51358.6956521739) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls151358.69565217393', ballsx, 245 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls251358.69565217393', ballsy, 176 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls351358.69565217393', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls451358.69565217393', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (51358.6956521739 / 1000 <= ballssimulatorroblox / 1000) then
			if (51358.6956521739 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls151358.69565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls251358.69565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls351358.69565217393"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls451358.69565217393"))
			end
		end
		if (51684.7826086957 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 51684.7826086957) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls151684.78260869572', ballsx, 320 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls251684.78260869572', ballsy, 216 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls351684.78260869572', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls451684.78260869572', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (51684.7826086957 / 1000 <= ballssimulatorroblox / 1000) then
			if (51684.7826086957 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls151684.78260869572"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls251684.78260869572"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls351684.78260869572"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls451684.78260869572"))
			end
		end
		if (52173.9130434783 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 52173.9130434783) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls152173.91304347831', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls252173.91304347831', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls352173.91304347831', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls452173.91304347831', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (52173.9130434783 / 1000 <= ballssimulatorroblox / 1000) then
			if (52173.9130434783 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls152173.91304347831"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls252173.91304347831"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls352173.91304347831"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls452173.91304347831"))
			end
		end
		if (52336.9565217392 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 52336.9565217392) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls152336.95652173922', ballsx, 133 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls252336.95652173922', ballsy, 100 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls352336.95652173922', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls452336.95652173922', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (52336.9565217392 / 1000 <= ballssimulatorroblox / 1000) then
			if (52336.9565217392 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls152336.95652173922"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls252336.95652173922"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls352336.95652173922"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls452336.95652173922"))
			end
		end
		if (52663.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 52663.0434782609) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls152663.04347826090', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls252663.04347826090', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls352663.04347826090', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls452663.04347826090', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (52663.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (52663.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls152663.04347826090"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls252663.04347826090"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls352663.04347826090"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls452663.04347826090"))
			end
		end
		if (52663.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 52663.0434782609) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls152663.04347826091', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls252663.04347826091', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls352663.04347826091', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls452663.04347826091', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (52663.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (52663.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls152663.04347826091"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls252663.04347826091"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls352663.04347826091"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls452663.04347826091"))
			end
		end
		if (52663.0434782609 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 52663.0434782609) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls152663.04347826093', ballsx, 245 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls252663.04347826093', ballsy, 176 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls352663.04347826093', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls452663.04347826093', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (52663.0434782609 / 1000 <= ballssimulatorroblox / 1000) then
			if (52663.0434782609 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls152663.04347826093"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls252663.04347826093"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls352663.04347826093"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls452663.04347826093"))
			end
		end
		if (52989.1304347826 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 52989.1304347826) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls152989.13043478262', ballsx, 320 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls252989.13043478262', ballsy, 216 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls352989.13043478262', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls452989.13043478262', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (52989.1304347826 / 1000 <= ballssimulatorroblox / 1000) then
			if (52989.1304347826 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls152989.13043478262"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls252989.13043478262"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls352989.13043478262"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls452989.13043478262"))
			end
		end
		if (53396.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 53396.7391304348) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls153396.73913043482', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls253396.73913043482', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls353396.73913043482', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls453396.73913043482', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (53396.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (53396.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls153396.73913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls253396.73913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls353396.73913043482"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls453396.73913043482"))
			end
		end
		if (53396.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 53396.7391304348) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls153396.73913043483', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls253396.73913043483', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls353396.73913043483', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls453396.73913043483', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (53396.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (53396.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls153396.73913043483"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls253396.73913043483"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls353396.73913043483"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls453396.73913043483"))
			end
		end
		if (53478.2608695653 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 53478.2608695653) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls153478.26086956531', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls253478.26086956531', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls353478.26086956531', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls453478.26086956531', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (53478.2608695653 / 1000 <= ballssimulatorroblox / 1000) then
			if (53478.2608695653 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls153478.26086956531"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls253478.26086956531"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls353478.26086956531"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls453478.26086956531"))
			end
		end
		if (53478.2608695653 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 53478.2608695653) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls153478.26086956531', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls253478.26086956531', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls353478.26086956531', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls453478.26086956531', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (53478.2608695653 / 1000 <= ballssimulatorroblox / 1000) then
			if (53478.2608695653 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls153478.26086956531"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls253478.26086956531"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls353478.26086956531"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls453478.26086956531"))
			end
		end
		if (53641.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 53641.3043478261) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls153641.30434782612', ballsx, 133 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls253641.30434782612', ballsy, 100 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls353641.30434782612', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls453641.30434782612', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (53641.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (53641.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls153641.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls253641.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls353641.30434782612"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls453641.30434782612"))
			end
		end
		if (53967.3913043479 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 53967.3913043479) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls153967.39130434790', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls253967.39130434790', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls353967.39130434790', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls453967.39130434790', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (53967.3913043479 / 1000 <= ballssimulatorroblox / 1000) then
			if (53967.3913043479 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls153967.39130434790"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls253967.39130434790"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls353967.39130434790"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls453967.39130434790"))
			end
		end
		if (53967.3913043479 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 53967.3913043479) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls153967.39130434791', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls253967.39130434791', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls353967.39130434791', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls453967.39130434791', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (53967.3913043479 / 1000 <= ballssimulatorroblox / 1000) then
			if (53967.3913043479 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls153967.39130434791"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls253967.39130434791"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls353967.39130434791"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls453967.39130434791"))
			end
		end
		if (53967.3913043479 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 53967.3913043479) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls153967.39130434793', ballsx, 245 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls253967.39130434793', ballsy, 176 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls353967.39130434793', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls453967.39130434793', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (53967.3913043479 / 1000 <= ballssimulatorroblox / 1000) then
			if (53967.3913043479 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls153967.39130434793"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls253967.39130434793"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls353967.39130434793"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls453967.39130434793"))
			end
		end
		if (54293.4782608696 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 54293.4782608696) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls154293.47826086962', ballsx, 320 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls254293.47826086962', ballsy, 216 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls354293.47826086962', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls454293.47826086962', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (54293.4782608696 / 1000 <= ballssimulatorroblox / 1000) then
			if (54293.4782608696 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls154293.47826086962"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls254293.47826086962"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls354293.47826086962"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls454293.47826086962"))
			end
		end
		if (54782.6086956522 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 54782.6086956522) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls154782.60869565221', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls254782.60869565221', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls354782.60869565221', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls454782.60869565221', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (54782.6086956522 / 1000 <= ballssimulatorroblox / 1000) then
			if (54782.6086956522 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls154782.60869565221"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls254782.60869565221"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls354782.60869565221"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls454782.60869565221"))
			end
		end
		if (54945.6521739131 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 54945.6521739131) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls154945.65217391312', ballsx, 133 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls254945.65217391312', ballsy, 100 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls354945.65217391312', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls454945.65217391312', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (54945.6521739131 / 1000 <= ballssimulatorroblox / 1000) then
			if (54945.6521739131 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls154945.65217391312"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls254945.65217391312"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls354945.65217391312"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls454945.65217391312"))
			end
		end
		if (55271.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 55271.7391304348) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls155271.73913043480', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls255271.73913043480', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls355271.73913043480', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls455271.73913043480', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (55271.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (55271.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls155271.73913043480"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls255271.73913043480"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls355271.73913043480"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls455271.73913043480"))
			end
		end
		if (55271.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 55271.7391304348) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls155271.73913043481', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls255271.73913043481', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls355271.73913043481', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls455271.73913043481', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (55271.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (55271.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls155271.73913043481"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls255271.73913043481"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls355271.73913043481"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls455271.73913043481"))
			end
		end
		if (55271.7391304348 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 55271.7391304348) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls155271.73913043483', ballsx, 245 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls255271.73913043483', ballsy, 176 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls355271.73913043483', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls455271.73913043483', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (55271.7391304348 / 1000 <= ballssimulatorroblox / 1000) then
			if (55271.7391304348 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls155271.73913043483"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls255271.73913043483"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls355271.73913043483"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls455271.73913043483"))
			end
		end
		if (55597.8260869565 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 55597.8260869565) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls155597.82608695652', ballsx, 320 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls255597.82608695652', ballsy, 216 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls355597.82608695652', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls455597.82608695652', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (55597.8260869565 / 1000 <= ballssimulatorroblox / 1000) then
			if (55597.8260869565 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls155597.82608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls255597.82608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls355597.82608695652"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls455597.82608695652"))
			end
		end
		if (56005.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56005.4347826087) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls156005.43478260872', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls256005.43478260872', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls356005.43478260872', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls456005.43478260872', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56005.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (56005.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls156005.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls256005.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls356005.43478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls456005.43478260872"))
			end
		end
		if (56005.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56005.4347826087) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls156005.43478260873', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls256005.43478260873', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls356005.43478260873', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls456005.43478260873', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56005.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (56005.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls156005.43478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls256005.43478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls356005.43478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls456005.43478260873"))
			end
		end
		if (56086.9565217392 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56086.9565217392) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls156086.95652173921', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls256086.95652173921', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls356086.95652173921', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls456086.95652173921', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56086.9565217392 / 1000 <= ballssimulatorroblox / 1000) then
			if (56086.9565217392 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls156086.95652173921"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls256086.95652173921"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls356086.95652173921"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls456086.95652173921"))
			end
		end
		if (56086.9565217392 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56086.9565217392) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls156086.95652173921', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls256086.95652173921', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls356086.95652173921', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls456086.95652173921', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56086.9565217392 / 1000 <= ballssimulatorroblox / 1000) then
			if (56086.9565217392 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls156086.95652173921"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls256086.95652173921"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls356086.95652173921"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls456086.95652173921"))
			end
		end
		if (56250 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56250) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls1562502', ballsx, 133 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls2562502', ballsy, 100 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls3562502', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls4562502', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56250 / 1000 <= ballssimulatorroblox / 1000) then
			if (56250 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls1562502"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls2562502"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls3562502"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls4562502"))
			end
		end
		if (56576.0869565218 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56576.0869565218) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls156576.08695652180', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls256576.08695652180', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls356576.08695652180', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls456576.08695652180', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56576.0869565218 / 1000 <= ballssimulatorroblox / 1000) then
			if (56576.0869565218 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls156576.08695652180"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls256576.08695652180"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls356576.08695652180"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls456576.08695652180"))
			end
		end
		if (56576.0869565218 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56576.0869565218) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls156576.08695652181', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls256576.08695652181', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls356576.08695652181', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls456576.08695652181', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56576.0869565218 / 1000 <= ballssimulatorroblox / 1000) then
			if (56576.0869565218 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls156576.08695652181"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls256576.08695652181"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls356576.08695652181"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls456576.08695652181"))
			end
		end
		if (56576.0869565218 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56576.0869565218) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls156576.08695652183', ballsx, 245 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls256576.08695652183', ballsy, 176 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls356576.08695652183', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls456576.08695652183', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56576.0869565218 / 1000 <= ballssimulatorroblox / 1000) then
			if (56576.0869565218 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls156576.08695652183"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls256576.08695652183"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls356576.08695652183"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls456576.08695652183"))
			end
		end
		if (56902.1739130435 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 56902.1739130435) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls156902.17391304352', ballsx, 320 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls256902.17391304352', ballsy, 216 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls356902.17391304352', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls456902.17391304352', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (56902.1739130435 / 1000 <= ballssimulatorroblox / 1000) then
			if (56902.1739130435 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls156902.17391304352"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls256902.17391304352"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls356902.17391304352"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls456902.17391304352"))
			end
		end
		if (57391.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 57391.3043478261) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls157391.30434782611', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls257391.30434782611', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls357391.30434782611', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls457391.30434782611', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (57391.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (57391.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls157391.30434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls257391.30434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls357391.30434782611"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls457391.30434782611"))
			end
		end
		if (57554.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 57554.347826087) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls157554.3478260872', ballsx, 133 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls257554.3478260872', ballsy, 100 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls357554.3478260872', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls457554.3478260872', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (57554.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (57554.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls157554.3478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls257554.3478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls357554.3478260872"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls457554.3478260872"))
			end
		end
		if (57880.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 57880.4347826087) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls157880.43478260870', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls257880.43478260870', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls357880.43478260870', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls457880.43478260870', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (57880.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (57880.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls157880.43478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls257880.43478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls357880.43478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls457880.43478260870"))
			end
		end
		if (57880.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 57880.4347826087) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls157880.43478260871', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls257880.43478260871', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls357880.43478260871', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls457880.43478260871', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (57880.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (57880.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls157880.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls257880.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls357880.43478260871"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls457880.43478260871"))
			end
		end
		if (57880.4347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 57880.4347826087) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls157880.43478260873', ballsx, 245 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls257880.43478260873', ballsy, 176 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls357880.43478260873', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls457880.43478260873', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (57880.4347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (57880.4347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls157880.43478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls257880.43478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls357880.43478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls457880.43478260873"))
			end
		end
		if (58206.5217391305 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58206.5217391305) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158206.52173913052', ballsx, 320 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258206.52173913052', ballsy, 216 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358206.52173913052', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458206.52173913052', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58206.5217391305 / 1000 <= ballssimulatorroblox / 1000) then
			if (58206.5217391305 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158206.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258206.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358206.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458206.52173913052"))
			end
		end
		if (58614.1304347826 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58614.1304347826) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158614.13043478262', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258614.13043478262', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358614.13043478262', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458614.13043478262', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58614.1304347826 / 1000 <= ballssimulatorroblox / 1000) then
			if (58614.1304347826 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158614.13043478262"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258614.13043478262"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358614.13043478262"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458614.13043478262"))
			end
		end
		if (58614.1304347826 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58614.1304347826) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158614.13043478263', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258614.13043478263', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358614.13043478263', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458614.13043478263', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58614.1304347826 / 1000 <= ballssimulatorroblox / 1000) then
			if (58614.1304347826 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158614.13043478263"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258614.13043478263"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358614.13043478263"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458614.13043478263"))
			end
		end
		if (58695.6521739131 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58695.6521739131) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158695.65217391311', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258695.65217391311', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358695.65217391311', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458695.65217391311', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58695.6521739131 / 1000 <= ballssimulatorroblox / 1000) then
			if (58695.6521739131 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158695.65217391311"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258695.65217391311"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358695.65217391311"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458695.65217391311"))
			end
		end
		if (58695.6521739131 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58695.6521739131) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -22, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158695.65217391314', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258695.65217391314', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358695.65217391314', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458695.65217391314', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58695.6521739131 / 1000 <= ballssimulatorroblox / 1000) then
			if (58695.6521739131 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158695.65217391314"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258695.65217391314"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358695.65217391314"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458695.65217391314"))
			end
		end
		if (58695.6521739131 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58695.6521739131) then
			if  false == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158695.65217391311', ballsx, 13 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258695.65217391311', ballsy, 40 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358695.65217391311', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458695.65217391311', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58695.6521739131 / 1000 <= ballssimulatorroblox / 1000) then
			if (58695.6521739131 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158695.65217391311"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258695.65217391311"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358695.65217391311"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458695.65217391311"))
			end
		end
		if (58695.6521739131 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58695.6521739131) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + -22, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158695.65217391314', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258695.65217391314', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358695.65217391314', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458695.65217391314', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58695.6521739131 / 1000 <= ballssimulatorroblox / 1000) then
			if (58695.6521739131 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158695.65217391314"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258695.65217391314"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358695.65217391314"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458695.65217391314"))
			end
		end
		if (58695.6521739131 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58695.6521739131) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 42
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158695.65217391315', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258695.65217391315', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358695.65217391315', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458695.65217391315', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58695.6521739131 / 1000 <= ballssimulatorroblox / 1000) then
			if (58695.6521739131 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158695.65217391315"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258695.65217391315"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358695.65217391315"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458695.65217391315"))
			end
		end
		if (58695.6521739131 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58695.6521739131) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 2, 0.1 , 'quadInOut');
			thecooly = -24
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158695.65217391312', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258695.65217391312', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358695.65217391312', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458695.65217391312', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58695.6521739131 / 1000 <= ballssimulatorroblox / 1000) then
			if (58695.6521739131 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158695.65217391312"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258695.65217391312"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358695.65217391312"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458695.65217391312"))
			end
		end
		if (58695.6521739131 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 58695.6521739131) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 20, 0.1 , 'quadInOut');
			thecooly = 4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls158695.65217391313', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls258695.65217391313', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls358695.65217391313', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls458695.65217391313', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (58695.6521739131 / 1000 <= ballssimulatorroblox / 1000) then
			if (58695.6521739131 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls158695.65217391313"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls258695.65217391313"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls358695.65217391313"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls458695.65217391313"))
			end
		end
		if (59266.3043478261 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59266.3043478261) then
			if  false == true then noteTweenX('balls7', 7 , ogposx7 + 24, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159266.30434782617', ballsx, 457 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259266.30434782617', ballsy, 221 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359266.30434782617', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459266.30434782617', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59266.3043478261 / 1000 <= ballssimulatorroblox / 1000) then
			if (59266.3043478261 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159266.30434782617"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259266.30434782617"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359266.30434782617"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459266.30434782617"))
			end
		end
		if (59347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59347.8260869566) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 0, 0.1 , 'quadInOut');
			thecooly = -30
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159347.82608695666', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259347.82608695666', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359347.82608695666', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459347.82608695666', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (59347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159347.82608695666"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259347.82608695666"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359347.82608695666"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459347.82608695666"))
			end
		end
		if (59347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59347.8260869566) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 14, 0.1 , 'quadInOut');
			thecooly = 4
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159347.82608695667', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259347.82608695667', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359347.82608695667', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459347.82608695667', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (59347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159347.82608695667"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259347.82608695667"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359347.82608695667"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459347.82608695667"))
			end
		end
		if (59347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59347.8260869566) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + -16, 0.1 , 'quadInOut');
			thecooly = 2
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159347.82608695660', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259347.82608695660', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359347.82608695660', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459347.82608695660', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (59347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159347.82608695660"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259347.82608695660"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359347.82608695660"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459347.82608695660"))
			end
		end
		if (59347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59347.8260869566) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 38
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159347.82608695661', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259347.82608695661', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359347.82608695661', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459347.82608695661', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (59347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159347.82608695661"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259347.82608695661"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359347.82608695661"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459347.82608695661"))
			end
		end
		if (59347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59347.8260869566) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159347.82608695662', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259347.82608695662', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359347.82608695662', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459347.82608695662', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (59347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159347.82608695662"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259347.82608695662"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359347.82608695662"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459347.82608695662"))
			end
		end
		if (59347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59347.8260869566) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159347.82608695663', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259347.82608695663', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359347.82608695663', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459347.82608695663', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (59347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159347.82608695663"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259347.82608695663"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359347.82608695663"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459347.82608695663"))
			end
		end
		if (59347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59347.8260869566) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159347.82608695664', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259347.82608695664', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359347.82608695664', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459347.82608695664', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (59347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159347.82608695664"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259347.82608695664"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359347.82608695664"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459347.82608695664"))
			end
		end
		if (59347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 59347.8260869566) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls159347.82608695665', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls259347.82608695665', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls359347.82608695665', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls459347.82608695665', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (59347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (59347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls159347.82608695665"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls259347.82608695665"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls359347.82608695665"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls459347.82608695665"))
			end
		end
		if (60000.0000000001 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60000.0000000001) then
			if  true == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160000.00000000010', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260000.00000000010', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360000.00000000010', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460000.00000000010', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60000.0000000001 / 1000 <= ballssimulatorroblox / 1000) then
			if (60000.0000000001 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160000.00000000010"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260000.00000000010"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360000.00000000010"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460000.00000000010"))
			end
		end
		if (60000.0000000001 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60000.0000000001) then
			if  true == true then noteTweenX('balls1', 1 , ogposx1 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls21', 1 , ogposy1 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls31', 1 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls41', 1 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls51', 1, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160000.00000000011', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260000.00000000011', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360000.00000000011', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460000.00000000011', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60000.0000000001 / 1000 <= ballssimulatorroblox / 1000) then
			if (60000.0000000001 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160000.00000000011"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260000.00000000011"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360000.00000000011"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460000.00000000011"))
			end
		end
		if (60000.0000000001 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60000.0000000001) then
			if  true == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160000.00000000012', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260000.00000000012', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360000.00000000012', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460000.00000000012', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60000.0000000001 / 1000 <= ballssimulatorroblox / 1000) then
			if (60000.0000000001 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160000.00000000012"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260000.00000000012"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360000.00000000012"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460000.00000000012"))
			end
		end
		if (60000.0000000001 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60000.0000000001) then
			if  true == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160000.00000000013', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260000.00000000013', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360000.00000000013', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460000.00000000013', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60000.0000000001 / 1000 <= ballssimulatorroblox / 1000) then
			if (60000.0000000001 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160000.00000000013"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260000.00000000013"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360000.00000000013"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460000.00000000013"))
			end
		end
		if (60000.0000000001 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60000.0000000001) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160000.00000000014', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260000.00000000014', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360000.00000000014', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460000.00000000014', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60000.0000000001 / 1000 <= ballssimulatorroblox / 1000) then
			if (60000.0000000001 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160000.00000000014"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260000.00000000014"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360000.00000000014"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460000.00000000014"))
			end
		end
		if (60000.0000000001 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60000.0000000001) then
			if  true == true then noteTweenX('balls5', 5 , ogposx5 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls25', 5 , ogposy5 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls35', 5 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls45', 5 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls55', 5, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160000.00000000015', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260000.00000000015', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360000.00000000015', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460000.00000000015', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60000.0000000001 / 1000 <= ballssimulatorroblox / 1000) then
			if (60000.0000000001 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160000.00000000015"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260000.00000000015"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360000.00000000015"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460000.00000000015"))
			end
		end
		if (60000.0000000001 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60000.0000000001) then
			if  true == true then noteTweenX('balls6', 6 , ogposx6 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls26', 6 , ogposy6 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls36', 6 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls46', 6 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls56', 6, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160000.00000000016', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260000.00000000016', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360000.00000000016', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460000.00000000016', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60000.0000000001 / 1000 <= ballssimulatorroblox / 1000) then
			if (60000.0000000001 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160000.00000000016"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260000.00000000016"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360000.00000000016"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460000.00000000016"))
			end
		end
		if (60000.0000000001 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60000.0000000001) then
			if  true == true then noteTweenX('balls7', 7 , ogposx7 + 0, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls27', 7 , ogposy7 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls37', 7 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls47', 7 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls57', 7, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160000.00000000017', ballsx, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260000.00000000017', ballsy, 0 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360000.00000000017', ballswidth, 0 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460000.00000000017', ballsheight, 0 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60000.0000000001 / 1000 <= ballssimulatorroblox / 1000) then
			if (60000.0000000001 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160000.00000000017"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260000.00000000017"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360000.00000000017"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460000.00000000017"))
			end
		end
		if (60081.5217391305 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 60081.5217391305) then
			if  false == true then noteTweenX('balls0', 0 , ogposx0 + 24, 0.1 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.1 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.1 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.1 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.1 , 'quadInOut');
		
			end
			tween_value('balls160081.52173913050', ballsx, 240 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls260081.52173913050', ballsy, 135 * yMultiply, 0.1, 'quadInOut')
			tween_value('balls360081.52173913050', ballswidth, 1440 * xMultiply, 0.1, 'quadInOut')
			tween_value('balls460081.52173913050', ballsheight, 810 * yMultiply, 0.1, 'quadInOut')
			end
	end
		if (60081.5217391305 / 1000 <= ballssimulatorroblox / 1000) then
			if (60081.5217391305 / 1000 >= (ballssimulatorroblox / 1000) - 0.1) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls160081.52173913050"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls260081.52173913050"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls360081.52173913050"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls460081.52173913050"))
			end
		end
		if (71739.1304347827 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 71739.1304347827) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls171739.13043478272', ballsx, 242 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls271739.13043478272', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls371739.13043478272', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls471739.13043478272', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (71739.1304347827 / 1000 <= ballssimulatorroblox / 1000) then
			if (71739.1304347827 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls171739.13043478272"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls271739.13043478272"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls371739.13043478272"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls471739.13043478272"))
			end
		end
		if (72309.7826086957 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 72309.7826086957) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls172309.78260869572', ballsx, 240 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls272309.78260869572', ballsy, 221 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls372309.78260869572', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls472309.78260869572', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (72309.7826086957 / 1000 <= ballssimulatorroblox / 1000) then
			if (72309.7826086957 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls172309.78260869572"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls272309.78260869572"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls372309.78260869572"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls472309.78260869572"))
			end
		end
		if (73043.4782608697 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 73043.4782608697) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls173043.47826086972', ballsx, 242 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls273043.47826086972', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls373043.47826086972', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls473043.47826086972', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (73043.4782608697 / 1000 <= ballssimulatorroblox / 1000) then
			if (73043.4782608697 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls173043.47826086972"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls273043.47826086972"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls373043.47826086972"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls473043.47826086972"))
			end
		end
		if (73614.1304347827 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 73614.1304347827) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls173614.13043478272', ballsx, 240 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls273614.13043478272', ballsy, 221 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls373614.13043478272', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls473614.13043478272', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (73614.1304347827 / 1000 <= ballssimulatorroblox / 1000) then
			if (73614.1304347827 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls173614.13043478272"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls273614.13043478272"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls373614.13043478272"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls473614.13043478272"))
			end
		end
		if (74347.8260869566 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 74347.8260869566) then
			if  false == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls174347.82608695660', ballsx, 6 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls274347.82608695660', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls374347.82608695660', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls474347.82608695660', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (74347.8260869566 / 1000 <= ballssimulatorroblox / 1000) then
			if (74347.8260869566 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls174347.82608695660"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls274347.82608695660"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls374347.82608695660"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls474347.82608695660"))
			end
		end
		if (74836.9565217392 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 74836.9565217392) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls174836.95652173923', ballsx, 475 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls274836.95652173923', ballsy, 224 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls374836.95652173923', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls474836.95652173923', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (74836.9565217392 / 1000 <= ballssimulatorroblox / 1000) then
			if (74836.9565217392 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls174836.95652173923"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls274836.95652173923"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls374836.95652173923"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls474836.95652173923"))
			end
		end
		if (75326.0869565218 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 75326.0869565218) then
			if  false == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls175326.08695652180', ballsx, 6 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls275326.08695652180', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls375326.08695652180', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls475326.08695652180', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (75326.0869565218 / 1000 <= ballssimulatorroblox / 1000) then
			if (75326.0869565218 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls175326.08695652180"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls275326.08695652180"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls375326.08695652180"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls475326.08695652180"))
			end
		end
		if (75815.2173913044 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 75815.2173913044) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls175815.21739130443', ballsx, 475 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls275815.21739130443', ballsy, 224 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls375815.21739130443', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls475815.21739130443', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (75815.2173913044 / 1000 <= ballssimulatorroblox / 1000) then
			if (75815.2173913044 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls175815.21739130443"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls275815.21739130443"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls375815.21739130443"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls475815.21739130443"))
			end
		end
		if (76304.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 76304.347826087) then
			if  false == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls176304.3478260870', ballsx, 6 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls276304.3478260870', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls376304.3478260870', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls476304.3478260870', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (76304.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (76304.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls176304.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls276304.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls376304.3478260870"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls476304.3478260870"))
			end
		end
		if (76956.5217391305 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 76956.5217391305) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls176956.52173913052', ballsx, 242 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls276956.52173913052', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls376956.52173913052', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls476956.52173913052', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (76956.5217391305 / 1000 <= ballssimulatorroblox / 1000) then
			if (76956.5217391305 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls176956.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls276956.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls376956.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls476956.52173913052"))
			end
		end
		if (77527.1739130436 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 77527.1739130436) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls177527.17391304362', ballsx, 240 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls277527.17391304362', ballsy, 221 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls377527.17391304362', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls477527.17391304362', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (77527.1739130436 / 1000 <= ballssimulatorroblox / 1000) then
			if (77527.1739130436 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls177527.17391304362"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls277527.17391304362"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls377527.17391304362"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls477527.17391304362"))
			end
		end
		if (78260.8695652175 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 78260.8695652175) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls178260.86956521752', ballsx, 242 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls278260.86956521752', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls378260.86956521752', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls478260.86956521752', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (78260.8695652175 / 1000 <= ballssimulatorroblox / 1000) then
			if (78260.8695652175 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls178260.86956521752"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls278260.86956521752"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls378260.86956521752"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls478260.86956521752"))
			end
		end
		if (78831.5217391305 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 78831.5217391305) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls178831.52173913052', ballsx, 240 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls278831.52173913052', ballsy, 221 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls378831.52173913052', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls478831.52173913052', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (78831.5217391305 / 1000 <= ballssimulatorroblox / 1000) then
			if (78831.5217391305 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls178831.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls278831.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls378831.52173913052"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls478831.52173913052"))
			end
		end
		if (79565.2173913044 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 79565.2173913044) then
			if  false == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls179565.21739130440', ballsx, 6 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls279565.21739130440', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls379565.21739130440', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls479565.21739130440', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (79565.2173913044 / 1000 <= ballssimulatorroblox / 1000) then
			if (79565.2173913044 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls179565.21739130440"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls279565.21739130440"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls379565.21739130440"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls479565.21739130440"))
			end
		end
		if (80054.347826087 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 80054.347826087) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls180054.3478260873', ballsx, 475 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls280054.3478260873', ballsy, 224 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls380054.3478260873', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls480054.3478260873', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (80054.347826087 / 1000 <= ballssimulatorroblox / 1000) then
			if (80054.347826087 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls180054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls280054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls380054.3478260873"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls480054.3478260873"))
			end
		end
		if (80543.4782608697 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 80543.4782608697) then
			if  false == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls180543.47826086970', ballsx, 6 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls280543.47826086970', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls380543.47826086970', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls480543.47826086970', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (80543.4782608697 / 1000 <= ballssimulatorroblox / 1000) then
			if (80543.4782608697 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls180543.47826086970"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls280543.47826086970"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls380543.47826086970"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls480543.47826086970"))
			end
		end
		if (81032.6086956523 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 81032.6086956523) then
			if  false == true then noteTweenX('balls3', 3 , ogposx3 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls23', 3 , ogposy3 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls33', 3 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls43', 3 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls53', 3, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls181032.60869565233', ballsx, 475 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls281032.60869565233', ballsy, 224 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls381032.60869565233', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls481032.60869565233', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (81032.6086956523 / 1000 <= ballssimulatorroblox / 1000) then
			if (81032.6086956523 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls181032.60869565233"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls281032.60869565233"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls381032.60869565233"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls481032.60869565233"))
			end
		end
		if (81521.7391304349 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 81521.7391304349) then
			if  false == true then noteTweenX('balls0', 0 , ogposx0 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls20', 0 , ogposy0 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls30', 0 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls40', 0 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls50', 0, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls181521.73913043490', ballsx, 6 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls281521.73913043490', ballsy, 36 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls381521.73913043490', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls481521.73913043490', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (81521.7391304349 / 1000 <= ballssimulatorroblox / 1000) then
			if (81521.7391304349 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls181521.73913043490"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls281521.73913043490"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls381521.73913043490"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls481521.73913043490"))
			end
		end
		if (82173.9130434784 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 82173.9130434784) then
			if  false == true then noteTweenX('balls2', 2 , ogposx2 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls22', 2 , ogposy2 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls32', 2 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls42', 2 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls52', 2, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls182173.91304347842', ballsx, 240 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls282173.91304347842', ballsy, 135 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls382173.91304347842', ballswidth, 1440 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls482173.91304347842', ballsheight, 810 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (82173.9130434784 / 1000 <= ballssimulatorroblox / 1000) then
			if (82173.9130434784 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and true == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls182173.91304347842"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls282173.91304347842"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls382173.91304347842"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls482173.91304347842"))
			end
		end
		if (50788.5501154461 <= ballssimulatorroblox - 0.2) then
		if (lastConductorPos <= 50788.5501154461) then
			if  true == true then noteTweenX('balls4', 4 , ogposx4 + 0, 0.5 , 'quadInOut');
			thecooly = 0
				if (downscroll == true) then
					thecooly = -thecooly
				end
				noteTweenY('balls24', 4 , ogposy4 + thecooly , 0.5 , 'quadInOut');
			thecoolangle = 0
				if (downscroll == true) then
					thecoolangle = -thecoolangle
				end
				noteTweenAngle('balls34', 4 , thecoolangle , 0.5 , 'quadInOut');
			noteTweenAlpha('balls44', 4 , 1, 0.5 , 'quadInOut');
			thecooldir = 0
				if (downscroll == true) then
					thecooldir = -thecooldir
				end
				noteTweenDirection('balls54', 4, 90 + thecooldir , 0.5 , 'quadInOut');
		
			end
			tween_value('balls150788.55011544614', ballsx, 0 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls250788.55011544614', ballsy, 0 * yMultiply, 0.5, 'quadInOut')
			tween_value('balls350788.55011544614', ballswidth, 0 * xMultiply, 0.5, 'quadInOut')
			tween_value('balls450788.55011544614', ballsheight, 0 * yMultiply, 0.5, 'quadInOut')
			end
	end
		if (50788.5501154461 / 1000 <= ballssimulatorroblox / 1000) then
			if (50788.5501154461 / 1000 >= (ballssimulatorroblox / 1000) - 0.5) and false == true then
				setPropertyFromClass("openfl.Lib", "application.window.x", get_tween_value("balls150788.55011544614"))
				setPropertyFromClass("openfl.Lib", "application.window.y", get_tween_value("balls250788.55011544614"))
				setPropertyFromClass("openfl.Lib", "application.window.width", get_tween_value("balls350788.55011544614"))
				setPropertyFromClass("openfl.Lib", "application.window.height", get_tween_value("balls450788.55011544614"))
			end
		end
		
	lastConductorPos = getSongPosition();


	end
		function onUpdatePost(elapsed)
			update_tweens()
			noteCount = getProperty('notes.length');
		
			for i = 0, noteCount-1 do
		
				noteData = getPropertyFromGroup('notes', i, 'noteData')
				if getPropertyFromGroup('notes', i, 'isSustainNote') then
					if (getPropertyFromGroup('notes', i, 'mustPress')) then
						setPropertyFromGroup('notes', i, 'angle', getPropertyFromGroup('playerStrums', noteData, 'direction') - 90)
					else
						
						setPropertyFromGroup('notes', i, 'angle', getPropertyFromGroup('opponentStrums', noteData, 'direction') - 90)
					end	
				else
					if (noteData >= 4) then
						setPropertyFromGroup('notes', i, 'angle', getPropertyFromGroup('playerStrums', noteData, 'angle'))
					else
						setPropertyFromGroup('notes', i, 'angle', getPropertyFromGroup('opponentStrums', noteData, 'angle'))
					end	
				end
			end
		end
		--generated by methewhenmethe's modchart editor