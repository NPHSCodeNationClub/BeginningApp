--start.lua

local physics = require "physics"
physics.start()

local composer = require "composer"
local scene = composer.newScene()

function scene:create(event)
	local screenGroup = self.view

	startButton = display.newImage("start-button.png")
	startButton.x = display.contentWidth * 0.5
	startButton.y = display.contentHeight * 0.5
	screenGroup:insert(startButton)
end

function beginGame(event)
	if (event.phase == "began") then
		
	end
end

function scene:show(event)
	if (event.phase == "will") then

	elseif (event.phase == "did") then
		startButton:addEventListener("touch", beginGame)
	end
end

function scene:hide(event)
	if (event.phase == "will") then
		startButton:removeEventListener("touch", beginGame)
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