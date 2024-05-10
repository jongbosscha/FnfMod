--Hello! This is your script, you may be confused but its really easy
--First, you need to have your image ready, read the tutorial about the thing here:
--Next, replace the word "Test", with the name of your image (capitalization matters).
--Open up the game and press 7 in any song, after that 

function onCreate()
	-- background
	
	makeLuaSprite('back_test', 'back_test', -650, -460);
	setScrollFactor('back_test', 0.9, 0.9);
	scaleObject('back_test', 1.1, 1.1);


	addLuaSprite('back_test', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end