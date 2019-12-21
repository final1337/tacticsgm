LocalPlayer = inherit(Object)

registerElementClass("player", LocalPlayer)

addEvent("Client:OnPastLogin", true)

function LocalPlayer:constructor()
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

function LocalPlayer:sendNotification(msg, r, g, b, ...)
	if not r then
		r, g, b = 255, 255, 255
	end	
	Notification.Event_Notification(msg, r, g, b)
	playSound("files/sounds/Message.mp3")
end

function LocalPlayer:getData(value)
	return getElementData(self, value)
end

function LocalPlayer:setData(data, value)
	setElementData(self, data, value)
end

function LocalPlayer:joinLobby(lobby)
    local currentLobby = self:getData("Lobby")
    if currentLobby == "main" then
		self:setData("Lobby", lobby)
		if lobby == "dm" then
			LobbyManager:joinLobby("dm")
		end
    end
end

function LocalPlayer:destructor()

end