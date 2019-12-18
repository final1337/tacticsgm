-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        server/classes/login/RegisterLogin.lua
-- *  PURPOSE:     Register Login
-- *
-- ****************************************************************************

RegisterLogin = inherit(Singleton)

addEvent("Server:RegisterLogin:CheckAccount", true)
addEvent("Server:RegisterLogin:Register", true)

function RegisterLogin:constructor()
    addEventHandler("Server:RegisterLogin:CheckAccount", root, bind(self.Event_Check, self))
    addEventHandler("Server:RegisterLogin:Register", root, bind(self.Event_Register, self))
end



function RegisterLogin:Event_Check()
    client:spawn(0, 0, 0, 0, 0, 0, 0)
    client:setFrozen(true)

    local res = dbPoll(dbQuery(handler, "SELECT * FROM userdata WHERE Serial = ?", client:getSerial()), -1)

    if #res == 0 then
        client:triggerEvent("Client:RegisterLogin:Register", client)
        print("[Client] Loaded register for "..client:getName())
    else
        client:triggerEvent("Client:RegisterLogin:Login", client)
        print("[Client] Loaded login for "..client:getName())
    end
end

function RegisterLogin:Event_Register(password)
    local res = dbPoll(dbQuery(handler, "SELECT * FROM userdata WHERE Name = ?", client:getName()), -1)
    local hash = passwordHash(password, "bcrypt", {})

    if #res == 0 then
        dbExec(handler, "INSERT INTO userdata (Name, Password, Serial, IP, Money, Playtime, RegisterDate, LastLogin, Status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", client:getName(), hash, client:getSerial(), client:getIP(), PLAYER_STARTMONEY, 0, getTimestamp(), getTimeStamp(), PROJECT_NAME.." Spieler")
    else
        client:sendNotification("Der Username ist bereits vergeben! Ändere ihn in den Settings und connecte neu!", 200, 0, 0)
    end
end