function onCreate()
	-- background shit
	makeLuaSprite('galaxiibgback_Night', 'studio/galaxiibgback_Night', 40, -410);
	setScrollFactor('galaxiibgback_Night', 1.0, 1.0);
	scaleObject('galaxiibgback_Night', 0.8, 0.8);
	
	makeLuaSprite('galaxiibgfront_Night', 'studio/galaxiibgfront_Night', 40, -510);
	setScrollFactor('galaxiibgfront_Night', 1.0, 1.0);
	scaleObject('galaxiibgfrontb_Night', 1.5, 1.5);
		
	addLuaSprite('galaxiibgback_Night', false);
	addLuaSprite('galaxiibgfront_Night', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end