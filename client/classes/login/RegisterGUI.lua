RegisterLogin = inherit(Singleton)

screenWidth, screenHeight = guiGetScreenSize()

addEvent("Client:RegisterLogin:Register", true)

function RegisterLogin:constructor()
    triggerServerEvent("Server:RegisterLogin:CheckAccount", localPlayer)
    
    setCameraMatrix(1325.5030517578, -1250.5478515625, 33.938899993896, 1326.267578125, -1250.9506835938, 33.435646057129)
    fadeCamera(true, 3)
    self.m_ScreenSource = dxCreateScreenSource(screenWidth, screenHeight)
    self.m_ScreenShader, self.m_ScreenTec = dxCreateShader("files/shader/blackwhite.fx")    

    addEventHandler("Client:RegisterLogin:Register", root, bind(self.Event_RegisterWindow, self))

    addEventHandler("onClientPreRender", root, bind(self.Event_ScreenShader, self))

    Timer(function() -- // Ensure that login has been loaded
        addEventHandler("onDgsMouseClickUp", self.m_Login, bind(self.Event_Register, self))
    end, 2000, 1)
end

function RegisterLogin:Event_RegisterWindow()
    showCursor(true)
    DGS:dgsSetSystemFont("files/fonts/EkMukta.ttf", 18)

    self.m_Window = DGS:dgsCreateWindow(screenWidth/2 - 400/2, screenHeight/2 - 350/2, 400, 350, PROJECT_NAME, false)

    self.m_Text = DGS:dgsCreateLabel(0.05, 0.05, 1, 1, "Willkommen, "..localPlayer:getName(), true, self.m_Window)
    local dsm = dxCreateFont("files/fonts/EkMukta.ttf", 18)
    DGS:dgsSetFont(self.m_Text, dsm)


    self.m_Text2 = DGS:dgsCreateLabel(0.05, 0.125, 1, 0.05, "Fülle alle Felder aus um dich zu registrieren.", true, self.m_Window)
    local dsm2 = dxCreateFont("files/fonts/EkMukta.ttf", 14)
    DGS:dgsSetFont(self.m_Text2, dsm2)

    self.m_Text3 = DGS:dgsCreateLabel(0.05, 0.2, 1, 0.05, "Passwort", true, self.m_Window)
    local dsm3 = dxCreateFont("files/fonts/EkMukta.ttf", 17)
    DGS:dgsSetFont(self.m_Text3, dsm)

    self.m_PwEditBox = DGS:dgsCreateEdit(0.05, 0.28, 0.8, 0.1, "", true, self.m_Window)
    DGS:dgsEditSetMasked(self.m_PwEditBox, true)

    self.m_Text4 = DGS:dgsCreateLabel(0.05, 0.4, 1, 0.05, "Passwort wiederholen", true, self.m_Window)
    local dsm3 = dxCreateFont("files/fonts/EkMukta.ttf", 17)
    DGS:dgsSetFont(self.m_Text4, dsm)

    self.m_Pw2EditBox = DGS:dgsCreateEdit(0.05, 0.48, 0.8, 0.1, "", true, self.m_Window)
    DGS:dgsEditSetMasked(self.m_Pw2EditBox, true)

    self.m_Text5 = DGS:dgsCreateLabel(0.05, 0.6, 1, 1, "Möchtest du Autologin aktivieren?", true, self.m_Window)
    DGS:dgsSetFont(self.m_Text5, dsm2)

    self.m_AutologinYes = DGS:dgsCreateButton(0.05, 0.7, 0.3, 0.1, "Speichern", true, self.m_Window)
    self.m_AutologinNo = DGS:dgsCreateButton(0.4, 0.7, 0.4, 0.1, "Nicht speichern", true, self.m_Window)
    DGS:dgsSetFont(self.m_AutologinYes, dsm2)
    DGS:dgsSetFont(self.m_AutologinNo, dsm2)

    self.m_Login = DGS:dgsCreateButton(0.05, 0.825, 0.6, 0.1, "Registration abschließen", true, self.m_Window)
    DGS:dgsSetFont(self.m_Login, dsm)

    DGS:dgsWindowSetMovable(self.m_Window, false)
    DGS:dgsWindowSetSizable(self.m_Window, false)

end

function RegisterLogin:Event_ScreenShader()
    if self.m_ScreenShader then
        dxUpdateScreenSource(self.m_ScreenSource)
        dxSetShaderValue(self.m_ScreenShader, "screenSource", self.m_ScreenSource)
        dxDrawImage(0, 0, screenWidth, screenHeight, self.m_ScreenShader)
    end
end

function RegisterLogin:Event_Register()
    if DGS:dgsGetText(self.m_PwEditBox) == DGS:dgsGetText(self.m_Pw2EditBox) then
        if DGS:dgsGetText(self.m_PwEditBox):len() >= 6 then
            triggerServerEvent("Server:RegisterLogin:Register", localPlayer, DGS:dgsGetText(self.m_PwEditBox))
        else
            localPlayer:sendMessage("Das Passwort muss mindestens 6 Zeichen beinhalten!", 200, 0, 0)
        end
    else
        localPlayer:sendMessage("Gebe ein Passwort an, welches identisch ist!", 200, 0, 0)
    end
end

function RegisterLogin:Event_RegisterWindow()
    showCursor(true)
    DGS:dgsSetSystemFont("files/fonts/EkMukta.ttf", 18)

    self.m_Window = DGS:dgsCreateWindow(screenWidth/2 - 400/2, screenHeight/2 - 350/2, 400, 350, PROJECT_NAME, false)

    self.m_Text = DGS:dgsCreateLabel(0.05, 0.05, 1, 1, "Willkommen zurück, "..localPlayer:getName(), true, self.m_Window)
    local dsm = dxCreateFont("files/fonts/EkMukta.ttf", 18)
    DGS:dgsSetFont(self.m_Text, dsm)


    self.m_Text2 = DGS:dgsCreateLabel(0.05, 0.125, 1, 0.05, "Tippe dein Passwort zum Einloggen ein.", true, self.m_Window)
    local dsm2 = dxCreateFont("files/fonts/EkMukta.ttf", 14)
    DGS:dgsSetFont(self.m_Text2, dsm2)

    self.m_Text3 = DGS:dgsCreateLabel(0.05, 0.2, 1, 0.05, "Passwort", true, self.m_Window)
    local dsm3 = dxCreateFont("files/fonts/EkMukta.ttf", 17)
    DGS:dgsSetFont(self.m_Text3, dsm)

    self.m_PwEditBox = DGS:dgsCreateEdit(0.05, 0.28, 0.8, 0.1, "", true, self.m_Window)
    DGS:dgsEditSetMasked(self.m_PwEditBox, true)

    self.m_Login = DGS:dgsCreateButton(0.05, 0.825, 0.6, 0.1, "Einloggen", true, self.m_Window)
    DGS:dgsSetFont(self.m_Login, dsm)

    DGS:dgsWindowSetMovable(self.m_Window, false)
    DGS:dgsWindowSetSizable(self.m_Window, false)

end