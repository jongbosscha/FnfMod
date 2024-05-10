local angleshit = 1;
local anglevar = 1;
local followchars = true;
function onCreate()
    makeLuaSprite('front', 'chaos/main', 400, -500);
    setLuaSpriteScrollFactor('front', 0.9, 0.9);

    makeLuaSprite('back', 'chaos/back', 1000, -300);
    setLuaSpriteScrollFactor('back', 0.8, 0.8);

    makeLuaSprite('hill', 'chaos/hill', -500, 80);
    setLuaSpriteScrollFactor('hill', 0.2, 0.3);

    makeLuaSprite('sky', 'chaos/sky', -400, -300);
    setLuaSpriteScrollFactor('sky', 0.1, 0.1);

      setProperty('gf.visible',false)

      makeLuaSprite('bartop','',0,0)
    	makeGraphic('bartop',1280,100,'000000')

    	makeLuaSprite('barbot','',0,620)
    	makeGraphic('barbot',1280,100,'000000')
    	addLuaSprite('barbot',true)
    	setScrollFactor('bartop',0,0)
    	setScrollFactor('barbot',0,0)
    	setObjectCamera('bartop','hud')
    	setObjectCamera('barbot','hud')

    	  makeLuaSprite('lights', 'lights', 100, -300);
    	  setLuaSpriteScrollFactor('lights', 0.7, 0.7);
    		setBlendMode('lights','add')

	addLuaSprite('sky', false);
	addLuaSprite('hill', false);
	addLuaSprite('back', false);
	addLuaSprite('front', false);
  addLuaSprite('lights', true);
  addLuaSprite('bartop',true)
end
function onUpdate()
if curBeat == 0 then
  angleshit = anglevar;
end
if curStep == 63 then
  angleshit = -anglevar;
end
if curStep == 70 then
  angleshit = anglevar;
end
if curStep == 75 then
  angleshit = -anglevar;
end
if curBeat == 68 then
  angleshit = anglevar;
end
setProperty('camHUD.angle',angleshit*3)
setProperty('camGame.angle',angleshit*3)
setProperty('timeTxt.visible', false)
setProperty('timeBar.visible', false)
setProperty('timeBarBG.visible', false)
setProperty('healthBar.visible', true)
setProperty('healthBarBG.visible', true)
setProperty('iconP1.visible', true)
setProperty('iconP2.visible', true)
setProperty('scoreTxt.visible', false)
if mustHitSection == true then
		setProperty('defaultCamZoom',1.2)
		end
if mustHitSection == false then
    setProperty('defaultCamZoom',0.78)
    end
end
