Player = inherit(Object)

registerElementClass("player", Player)

function Player:setData(key, value, noSync)
    self.m_Data[key] = value
    if not noSync then
        setElementData(self, key, value)
    end
end

function Player:getData(key)
    return getElementData(self, key) or self.m_Data[key]
end

function Player:triggerEvent(event, ...)
    triggerClientEvent(self, event, self, ...)
end

function Player:sendMessage(msg, r, g, b, ...)
    outputChatBox(msg, self, r or 255, g or 255, b or 255, true)
end

function Player:sendNotification(msg, r, g, b, ...)
    if not r then
        r, g, b = 255, 255, 255
    end
    self:triggerEvent("Client:Notification:Show", msg, r, g, b)
end