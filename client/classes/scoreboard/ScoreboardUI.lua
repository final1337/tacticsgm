-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        client/classes/scoreboard/ScoreboardUI.lua
-- *  PURPOSE:     Scoreboard
-- *
-- ****************************************************************************

Scoreboard = inherit(Object)

local font = dxCreateFont(":tacticsgm/files/fonts/EkMukta.ttf", 17)

function Scoreboard:constructor()
    self.m_Opened = false
    self.m_Scroll = 0

    addEventHandler("onClientRender", root, bind(self.Event_Render, self))

    bindKey("TAB", "down", bind(self.openScoreboard, self))
    bindKey("TAB", "up", bind(self.closeScoreboard, self))
end

function Scoreboard:openScoreboard(key, state)
    if self.m_Opened == false then
        self.m_Opened = true
        self.updateDatas()
            
        bindKey("MOUSE_WHEEL_DOWN", "down", self.scrollDown)
        bindKey("MOUSE_WHEEL_UP", "down", self.scrollUp)
    end
end

function Scoreboard:closeScoreboard()
    if self.m_Opened == true then
        self.m_Opened = false

        unbindKey("MOUSE_WHEEL_DOWN", "down", self.scrollDown)
        unbindKey("MOUSE_WHEEL_UP", "down", self.scrollUp)
    end
end

function Scoreboard:scrollDown()
    if self.m_Opened == true then
        local players = #getElementsByType("player")
        if self.m_Scroll <= players-14 then
            self.m_Scroll = self.m_Scroll+2
        end
    end
end

function Scoreboard:scrollUp()
    if self.m_Opened == true then
        if self.m_Scroll <= 2 then
            self.m_Scroll = 0
        else
            self.m_Scroll = self.m_Scroll-2
        end
    end
end

function Scoreboard:Event_Render()
    if self.m_Opened == true then
        dxDrawRectangle(655, 353, 611, 374, tocolor(0, 0, 0, 125), false)
        dxDrawRectangle(655, 653, 611, 32, tocolor(0, 150, 255, 255), false)
        dxDrawText("Derzeit sind "..(#getElementsByType("player")).." Spieler online", 674, 653, 947, 685, tocolor(0, 0, 0, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawText("eigener Ping: 23ms", 957, 653, 1230, 685, tocolor(0, 0, 0, 255), 1.00, font, "right", "center", false, false, false, false, false)
        dxDrawText("VIP", 665, 353, 696, 380, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawRectangle(655, 380, 611, 1, tocolor(0, 150, 255, 255), false)
        dxDrawText("Name", 706, 353, 864, 380, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawText("Kills", 869, 353, 926, 380, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawText("Tode", 930, 353, 987, 380, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawText("Spielzeit", 993, 353, 1060, 380, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawText("Team", 1070, 353, 1127, 380, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawText("K/D", 1137, 353, 1194, 380, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawText("Ping", 1199, 353, 1256, 380, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
        dxDrawText("Mit /mystats kannst du Informationen über deine Statistiken einsehen!", 674, 690, 1230, 717, tocolor(210, 190, 0, 255), 1.00, font, "center", "center", false, false, false, true, false)
        
        local id = 0

        for i=1+self.m_Scroll, 17+self.m_Scroll do
            if tbl[i] then
                dxDrawText(tbl[i].name, 706, 386, 864, 413, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
                dxDrawText(tbl[i].kills, 869, 386, 926, 413, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
                dxDrawText(tbl[i].deaths, 930, 386, 987, 413, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
                dxDrawText(tbl[i].playtime, 993, 386, 1060, 413, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
                dxDrawText(tbl[i].team, 1070, 386, 1127, 413, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
                dxDrawText(tbl[i].kd, 1137, 386, 1194, 413, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
                dxDrawText((tbl[i].ping).."ms", 1199, 386, 1256, 413, tocolor(255, 255, 255, 255), 1.00, font, "left", "center", false, false, false, false, false)
                
                id = id+1
            end
        end
    end
end

function Scoreboard:updateDatas()
    tbl = {}
    local i = 1
    
    for id = -1, 11 do
        for k, v in ipairs(getElementsByType("player")) do
            if v:getData("loggedin") == 1 then
                tbl[i] = {}
                tbl[i].name = v:getName()
                tbl[i].kills = "0"
                tbl[i].deaths =  "0"
                tbl[i].playtime = "22"
                tbl[i].team =  "Triaden"
                tbl[i].kd = "3.33%"
                tbl[i].ping = v:getPing()
                
                i = i+1
            elseif id == -1 then
                tbl[i] = {}
                tbl[i].name = v:getName()
                tbl[i].kills = "-"
                tbl[i].deaths = "-"
                tbl[i].playtime = "-"
                tbl[i].team = "-"
                tbl[i].kd = "-"
                tbl[i].ping = v:getPing()
                
                i = i+1
            end
        end
    end
end
