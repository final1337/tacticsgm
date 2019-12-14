LocalPlayer = inherit(Object)

registerElementClass("player", LocalPlayer)

addEvent("Client:OnPastLogin", true)

function LocalPlayer:constructor()
	toggleControl("next_weapon", false)
	toggleControl("previous_weapon", false)

	self.m_Lobby = false

	addEventHandler("Client:OnPastLogin", root, bind(self.Event_OnPastLogin, self))
end

function LocalPlayer:Event_OnPastLogin()
	-- Load core scripts first

	core:pastLogin()

	-- Than the localPlayer stuff
end

function LocalPlayer:sendMessage(msg, r, g, b, ...)
	if not r then
		r, g, b = 255, 255, 255
	end
	outputChatBox((msg):format(...), r,g,b)
end

function LocalPlayer:getData(value)
	return getElementData(self, value)
end

function LocalPlayer:destructor()

end