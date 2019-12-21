-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        client/classes/lobbyselection/LobbySelectionGUI.lua
-- *  PURPOSE:     Lobby Selection
-- *
-- ****************************************************************************

LobbySelector = inherit(Object)

LobbySelector.Texts = {
    "Das "..PROJECT_NAME.." Script wird von FiNAL entwickelt!",
    "Zum Start bekommt jeder Spieler "..PLAYER_STARTMONEY.."$!",
    "Seit dem 17.12.2019 wird an dem Script zwischendurch gearbeitet.",
    "Mit /autologin werdet ihr beim nächsten Connecten automatisch eingeloggt.",
    "Solltet ihr beleidigen, werdet ihr automatisch gemutet und verliert 500$.",
}

local x, y = guiGetScreenSize()
local x, y = x/1920, y/1080

function LobbySelector:constructor()
    setPlayerHudComponentVisible("radar", false)

    self.m_CustomText = "Hamburg Tactics"

    self.m_1vs1R, self.m_1vs1G, self.m_1vs1B = 255, 255, 255
    self.m_TacticsR, self.m_TacticsG, self.m_TacticsB = 255, 255, 255
    self.m_DeathmatchR, self.m_DeathmatchG, self.m_DeathmatchB = 255, 255, 255
    self.m_DDR, self.m_DDG, self.m_DDB = 255, 255, 255

    addEventHandler("onClientRender", root, bind(self.Event_Render, self))
    addEventHandler("onClientClick", root, bind(self.Event_Select, self))
    Timer(function()
        self.m_CustomText = LobbySelector.Texts[math.random(1, #LobbySelector.Texts)]
    end, 5000, 0)
end

function LobbySelector.getPlayers(lobby)
    if lobby then
        counter = 0
        for k, v in pairs(getElementsByType("player")) do
            if v:getData("Lobby") == lobby then
                counter = counter+1
            end
        end
    end
    return counter
end

function LobbySelector:Event_Render()
    if localPlayer:getData("Lobby") == "main" then
        setCameraMatrix(1325.5030517578, -1250.5478515625, 33.938899993896, 1326.267578125, -1250.9506835938, 33.435646057129)
        dxDrawImage(x*149, y*292, x*385, y*449, ":tacticsgm/files/images/lobbys/1vs1.png", 0, 0, 0, tocolor(self.m_1vs1R, self.m_1vs1G, self.m_1vs1B, 255), false)
        dxDrawImage(x*553, y*292, x*385, y*449, ":tacticsgm/files/images/lobbys/tactics.png", 0, 0, 0, tocolor(self.m_TacticsR, self.m_TacticsG, self.m_TacticsB, 255), false)
        dxDrawImage(x*957, y*292, x*385, y*449, ":tacticsgm/files/images/lobbys/deathmatch.png", 0, 0, 0, tocolor(self.m_DeathmatchR, self.m_DeathmatchG, self.m_DeathmatchB, 255), false)
        dxDrawImage(x*1375, y*292, x*385, y*449, ":tacticsgm/files/images/lobbys/dd.png", 0, 0, 0, tocolor(self.m_DDR, self.m_DDG, self.m_DDB, 255), false)
        dxDrawRectangle(x*554, y*744, x*384, y*55, tocolor(0, 0, 0, 174), false)
        dxDrawRectangle(x*150, y*744, x*384, y*55, tocolor(0, 0, 0, 174), false)
        dxDrawText(tostring(LobbySelector.getPlayers("1vs1")).." Spieler", x*149, y*744, x*534, y*799, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawRectangle(x*957, y*744, x*384, y*55, tocolor(0, 0, 0, 174), false)
        dxDrawRectangle(x*1376, y*744, x*384, y*55, tocolor(0, 0, 0, 174), false)
        dxDrawText(tostring(LobbySelector.getPlayers("tactics")).." Spieler", x*554, y*744, x*939, y*799, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(tostring(LobbySelector.getPlayers("deathmatch")).." Spieler", x*957, y*744, x*1342, y*799, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(tostring(LobbySelector.getPlayers("dd")).." Spieler", x*1376, y*744, x*1761, y*799, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawRectangle(x*149, y*206, x*1611, y*76, tocolor(0, 0, 0, 174), false)
        dxDrawText(self.m_CustomText, x*149, y*206, x*1760, y*282, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
        
        if isCursorOnElement(x*149, y*292, x*385, y*449) then -- 1vs1
            self.m_1vs1R, self.m_1vs1G, self.m_1vs1B = 255, 255, 255
        else
            self.m_1vs1R, self.m_1vs1G, self.m_1vs1B = 200, 200, 200
        end
        if isCursorOnElement(x*553, y*292, x*385, y*449) then -- Tactics
            self.m_TacticsR, self.m_TacticsG, self.m_TacticsB = 255, 255, 255
        else
            self.m_TacticsR, self.m_TacticsG, self.m_TacticsB = 200, 200, 200
        end
        if isCursorOnElement(x*957, y*292, x*385, y*449) then -- DM
            self.m_DeathmatchR, self.m_DeathmatchG, self.m_DeathmatchB = 255, 255, 255
        else
            self.m_DeathmatchR, self.m_DeathmatchG, self.m_DeathmatchB = 200, 200, 200
        end
        if isCursorOnElement(x*1375, y*292, x*385, y*449) then -- DD
            self.m_DDR, self.m_DDG, self.m_DDB = 255, 255, 255
        else
            self.m_DDR, self.m_DDG, self.m_DDB = 200, 200, 200
        end
    end
end

function LobbySelector:Event_Select(button, state)
    if localPlayer:getData("Lobby") == "main" then
        if button == "left" and state == "up" then
            if isCursorOnElement(x*149, y*292, x*385, y*449) then -- 1vs1

            elseif isCursorOnElement(x*553, y*292, x*385, y*449) then -- Tactics
            
            elseif isCursorOnElement(x*957, y*292, x*385, y*449) then -- DM
                localPlayer:joinLobby("dm")
                localPlayer:sendMessage("Du bist nun in der DM-Arena!", 0, 200, 0)
            elseif isCursorOnElement(x*1375, y*292, x*385, y*449) then -- DD

            end
        end
    end
end