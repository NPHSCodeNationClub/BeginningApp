--game.lua

local physics = require "physics"
physics.start()

local composer = require "composer"
local scene = composer.newScene()

function scene:create(event)
	local screenGroup = self.view

	points = 0

	scoreTimer = timer.performWithDelay(100, pointsUpdate, 0)

	score = display.newText("0", display.contentWidth * 0.5, display.contentHeight * 0.5, native.systemFontBold, 40)
    
    player = display.newImage("unicorn.png")
    player.x = display.contentWidth * 0.5
    player.y = display.contentHeight * 0.5
    physics.addBody(player, "static", {density=.08,  bounce=0.1, friction=0.2})
    transition.to(player, {time=100, x = display.contentWidth * 0.5, y = display.contentHeight * 0.5, onComplete = playerReady()})
    screenGroup:insert(player)
    
    floor = display.newImage("rectangle.png")
    floor.x = display.contentWidth * 0.5
    floor.y = display.contentHeight
    physics.addBody(floor, "static", {density=.08,  bounce=0.1, friction=0.2})
    screenGroup:insert(floor)
    
    ceiling = display.newImage("rectangle.png")
    ceiling.x = display.contentWidth * 0.5
    ceiling.y = 0
    physics.addBody(ceiling, "static", {density=.08,  bounce=0.1, friction=0.2})
    screenGroup:insert(ceiling)
    
end

function pointsUpdate()
	points = points + 1
	score.text = string.format("%d", points)
end

function playerReady() 
    player.bodyType = "dynamic"
end

function activatePlayer(self, event)
    self:applyForce(0, -7, self.x, self.y)
end

function touchScreen(event)
    if event.phase == "began" then
        player.enterFrame = activatePlayer
        Runtime:addEventListener("enterFrame", player)
    elseif event.phase == "ended" then
        Runtime:removeEventListener("enterFrame", player)
    end
end

function gameOver()
    composer.gotoScene("start", "fade", 500)
end

function playerHit()
    player.isVisible = false
    timer.performWithDelay(100, gameOver, 1)
end

function onCollision(event)
    if event.phase == "began" then
        player.collided = true
        player.bodyType = "static"
        playerHit()
    end
end

function scene:show(event)
	if (event.phase == "will") then
		composer.removeScene("start")

	elseif (event.phase == "did") then
		Runtime:addEventListener("touch", touchScreen)
        Runtime:addEventListener("collision", onCollision)
	end
end

function scene:hide(event)
	if (event.phase == "will") then
        Runtime:removeEventListener("touch", touchScreen)
        Runtime:removeEventListener("collision", onCollision)

	elseif (event.phase == "did") then

	end
end

function scene:destroy(event)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
