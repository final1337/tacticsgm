RegisterLogin = inherit(Singleton)

screenWidth, screenHeight = guiGetScreenSize()

addEvent("Client:RegisterLogin:Register", true)

function RegisterLogin:constructor()
    triggerServerEvent("Server:RegisterLogin:CheckAccount", localPlayer)
    
    addEventHandler("Client:RegisterLogin:Register", root, bind(self.Event_Register, self))
end

function RegisterLogin:Event_Register()
    self.m_Window = DGSClass:createWindow(screenWidth/2 - 400/2, screenHeight/2 - 350/2, 400, 350, "Hamburg Tactics Login", false)

    self.m_Window:setMovable(false)
    self.m_Window:setSizable(false)
end