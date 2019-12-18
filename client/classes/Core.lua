Core = inherit(Object)

function Core:constructor()
	outputDebugString("Clientside-Loading core...")

	core = self

	-- // init localplayer instance
	enew(localPlayer, LocalPlayer)
	
	bindKey("b", "up",
		function()
			showCursor(not isCursorShowing())
		end
	)
	
    DGS = exports.dgs
	loadstring(exports.dgs:dgsImportOOPClass())() -- Load DGS Class
	RegisterLogin:new()
	Notification:new()
	outputDebugString("Clientside-Core has been loaded.")
end

function Core:pastLogin()
	outputDebugString("Client] pastLogin-classes are loading...")	
	---------
	outputDebugString("Client] pastLogin-classes finished loading...")	
end

function Core:destructor()
	delete(config)
end

function getAbsoluteCursorPosition()
	local cx, cy = getCursorPosition()
	if not cx then return end
	return cx*screenWidth, cy*screenHeight
end

function table.clone(org)
  return {unpack(org)}
end