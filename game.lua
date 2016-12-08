--game.lua

local physics = require "physics"
physics.start()

local composer = require "composer"
local scene = composer.newScene()

function scene:create(event)
	local screenGroup = self.view

	points = 0

	scoreTimer = timer.performWithDelay(100, pointsUpdate, 0)
	
	score = display.newText("0", display.contentWidth * 0.9, display.contentHeight * 0.9, native.systemFontBold, 40)
	score:setFillColor(0, 100, 0)
	screenGroup:insert(score)
end

function pointsUpdate()
	points = points + 1
	score.text = string.format("%d", points)
end

function scene:show(event)
	if (event.phase == "will") then
		composer.removeScene("start")

	elseif (event.phase == "did") then

	end
end

function scene:hide(event)
	if (event.phase == "will") then

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