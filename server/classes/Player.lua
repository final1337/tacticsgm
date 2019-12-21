Player = inherit(Object)

registerElementClass("player", Player)

Player.DataTable = {"Money", "Playtime", "LastLogin", "Status"}

function Player:constructor()
    self.m_CurrentLobby = false
    self.m_LoggedIn = false
    self.m_Data = {}
end

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

function Player:getSQLData(from, where, name, data)
    if from and where and name and data then
        local query = dbQuery(handler, "SELECT * FROM "..from.." WHERE "..where.." = '"..name.."'")
        if query then
            local rows = dbPoll(query, -1)
            for k, v in pairs(rows) do
                return v[data]
            end
        end
    end
end

function Player:setLoginDatas()
    for k, v in ipairs(self.DataTable) do
        local data = self:getSQLData("userdata", "Name", self:getName(), v)
        self:setData(v, data)
        print("Loaded elementdata for player "..self:getName()..": "..self:getData(v))
    end
end

function Player:savePlayerDatas()
    if self:getData("loggedin") == 1 then
        for k, v in ipairs(Player.DataTable) do
            dbExec(handler, "UPDATE userdata SET ?? = ? WHERE Name = ?", v, self:getData(v), self:getName())
        end
    end
end
