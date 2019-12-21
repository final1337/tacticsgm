-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        client/classes/deathsystem/DeathGraph.lua
-- *  PURPOSE:     Death system
-- *
-- ****************************************************************************

DeathGraph = inherit(Object)

local screenWidth, screenHeight = guiGetScreenSize()

local screenSource = dxCreateScreenSource(screenWidth, screenHeight)

function DeathGraph:constructor()
    addEventHandler("onClientPlayerWasted", localPlayer, bind(self.Event_Wasted, self))
end

function DeathGraph:Event_Wasted(killer, weapon, bodypart)
    setSoundVolume(playSound("files/sounds/Wasted.mp3"), 0.1)

    self.pX, self.pY, self.pZ = source:getPosition()
    self.m_DeathReason = DeathGraph:FormatToString(source, killer, weapon, bodypart)

    DeathGraph:showText(self.m_DeathReason)

    self.m_Shader, self.m_Tec = dxCreateShader("files/shader/old_film.fx")

    DeathGraph[1] = guiCreateStaticImage(0, 0, 1920, 220, "files/images/death/Rectangle.png", true)
    DeathGraph[2] = guiCreateStaticImage(0, 0, 1920, 220, "files/images/death/vignette1.dds", true)

    Timer(function()
        DeathGraph[1]:destroy()
        DeathGraph[2]:destroy()
        destroyElement(self.m_Shader)
        removeEventHandler("onClientRender", root, bind(self.Event_Render, self))
        removeEventHandler("onClientPreRender", root, bind(self.Event_UpdateShader, self))
    end, 5000, 1)
end

function DeathGraph:FormatToString(player, killer, weapon, bodypart)
    self.m_DeathText = ""
    if killer then
        self.m_DeathText = source:getName().." hat dich getötet mit der "..getWeaponNameFromID(weapon)
    else
        self.m_DeathText = "Du hast dich selbst umgelegt."
    end

    return self.m_DeathText
end

function DeathGraph:showText(text)
    addEventHandler("onClientRender", root, bind(self.Event_Render, self))
    addEventHandler("onClientPreRender", root, bind(self.Event_UpdateShader, self))
end

function DeathGraph:Event_Render()
    dxDrawText(self.m_DeathText, 0.5*screenWidth, 0.535*screenHeight, 0.5*screenWidth, 0.535*screenHeight, tocolor(255, 255, 255, 255), 1.5, "default-bold", "center", "center", false, false, true)
    dxDrawText("wasted", 0.5*screenWidth, 0.48*screenHeight, 0.5*screenWidth, 0.48*screenHeight, tocolor(225, 0, 0, 255), 4, "pricedown", "center", "center", false, false, true)
end

function DeathGraph:Event_UpdateShader()
    if self.m_Shader then
        dxUpdateScreenSource(screenSource)
        local flicker = math.random(100-0, 100)/100
        dxSetShaderValue(self.m_Shader, "ScreenSource", screenSource)
        dxSetShaderValue(self.m_Shader, "Flickering", flicker)
        dxDrawImage(0, 0, screenWidth, screenHeight, self.m_Shader)
    end
end