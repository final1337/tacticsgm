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
addEvent("Server:RegisterLogin:Login", true)

function RegisterLogin:constructor()
    addEventHandler("Server:RegisterLogin:CheckAccount", root, bind(self.Event_Check, self))
    addEventHandler("Server:RegisterLogin:Register", root, bind(self.Event_Register, self))
    addEventHandler("Server:RegisterLogin:Login", root, bind(self.Event_Login, self))
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
        dbExec(handler, "INSERT INTO userdata (Name, Password, Serial, IP, Money, Playtime, RegisterDate, LastLogin, Status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", client:getName(), hash, client:getSerial(), client:getIP(), PLAYER_STARTMONEY, 0, getTimestamp(), getTimestamp(), PROJECT_NAME.." Spieler")
    else
        client:sendMessage("Der Username ist bereits vergeben! Ändere ihn in den Settings und connecte neu!", 200, 0, 0)
    end
end

function RegisterLogin:Event_Login(password)
    local res = dbPoll(dbQuery(handler, "SELECT * FROM userdata WHERE Name = ?", client:getName()), -1)
    local hash = passwordHash(password, "bcrypt", {})

    if #res == 1 then
        if passwordVerify(password, hash) then
            client:sendMessage("Erfolgreich eingeloggt!", 0, 200, 0)
            client:setLoginDatas()
        else
            client:sendMessage("Du hast ein falsches Passwort angegeben!", 200, 0, 0)
        end
    else
        client:sendMessage("Ein Account mit dem Usernamen den du hast, existiert nicht.", 200, 0, 0)
    end
end