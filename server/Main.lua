-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        server/Main.lua
-- *  PURPOSE:     Main
-- *
-- ****************************************************************************

Main = {}

function Main.Event_OnResourceStart()
	Core:new()
end
addEventHandler("onResourceStart", resourceRoot, Main.Event_OnResourceStart)

-- Todo: fix delete bug
function Main.Event_OnResourceStop()
	delete(Core)
end
addEventHandler("onResourceStop", resourceRoot, Main.Event_OnResourceStop)