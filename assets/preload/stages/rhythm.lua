--Hello! This is your script, you may be confused but its really easy
--First, you need to have your image ready, read the tutorial about the thing here:
--Next, replace the word "Test", with the name of your image (capitalization matters).
--Open up the game and press 7 in any song, after that 

function onCreate()
	-- background
	
	makeLuaSprite('bg', 'bg', -380, -280);
	setScrollFactor('bg', 0.9, 0.9);
	scaleObject('bg', 1.1, 1.1);

	makeAnimatedLuaSprite('fan','characters/fan',50,350);
	luaSpriteAddAnimationByPrefix('fan','dance','fan_idle',24,true);
	objectPlayAnimation('fan','dance',false);
	setScrollFactor('fan', 1, 1);

	addLuaSprite('bg', false);
	addLuaSprite('fan', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end