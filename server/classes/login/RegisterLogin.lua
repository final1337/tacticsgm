RegisterLogin = inherit(Singleton)

addEvent("Server:RegisterLogin:CheckAccount", true)

function RegisterLogin:constructor()
    addEventHandler("Server:RegisterLogin:CheckAccount", root, bind(self.Event_Check, self))
end

function RegisterLogin:Event_Check()
    local res = dbPoll(dbQuery(handler, "SELECT * FROM userdata WHERE Name = ?", client:getName()), -1)

    if #res == 0 then
        client:triggerEvent("Client:RegisterLogin:Register", client)
        print("[Client] Loaded register for "..client:getName())
    else
        client:triggerEvent("Client:RegisterLogin:Login", client)
        print("[Client] Loaded login for "..client:getName())
    end
end
