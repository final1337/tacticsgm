Main = inherit(Singleton)

function Main.Event_OnResourceStart()
	Core:new()
end
addEventHandler("onClientResourceStart", resourceRoot, Main.Event_OnResourceStart)

-- Todo: fix delete bug
function Main.Event_OnResourceStop()
	Core:delete()
end
addEventHandler("onClientResourceStop", resourceRoot, Main.Event_OnResourceStop)