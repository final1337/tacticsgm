-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        server/classes/lobbyselection/DM.lua
-- *  PURPOSE:     DM Lobby System
-- *
-- ****************************************************************************

DMLobby = inherit(Object)

addEvent("Server:LobbySystem:DM:Spawn", true)

DMLobby.Spawns = {
    ["LVPD"] = {
        {238.77481, 140.21446, 1003.0234, 3},
        {209.17209, 142.89963, 1003.0234, 3},
        {213.83867 ,171.11473 ,1003.02344, 3},
        {197.63321, 166.83607, 1003.0234, 3},
        {190.26958 ,157.72731, 1003.0234, 3},
        {190.47217 ,179.88687 ,1003.02344, 3},
        {229.54695, 182.46538, 1003.03125, 3},
        {263.07712, 171.43620, 1003.02344, 3},
        {288.69495, 169.52080 ,1007.1718, 3},
        {254.87534, 190.14284 ,1008.17188, 3} --LVPD
    };
}

function DMLobby:constructor()
    self.m_CurrentMap = "LVPD"
    self.wasteFunction = function(player) self:Event_OnWasted(player) end
    self.spawnFunction = function(player) self:Event_Spawn(player) end

    addEventHandler("Server:LobbySystem:DM:Spawn", root, bind(self.Event_Spawn, self))
end

function DMLobby:Event_Spawn(player)
    showCursor(player, false)
    setPlayerHudComponentVisible(player, "radar", true)

    removeEventHandler("onPlayerWasted", player, bind(self.Event_OnWasted, self))
    addEventHandler("onPlayerWasted", player, bind(self.Event_OnWasted, self))

    
    DMLobby:sendMessage(player:getName().." ist der Lobby beigetreten!")
    
    local tbl = DMLobby.Spawns
    local randomSpawn = math.random(1, #DMLobby.Spawns[self.m_CurrentMap])
    spawnPlayer(player, tbl[self.m_CurrentMap][randomSpawn][1], tbl[self.m_CurrentMap][randomSpawn][2], tbl[self.m_CurrentMap][randomSpawn][3], 0, math.random(120, 200), tbl[self.m_CurrentMap][randomSpawn][4], LobbyManager.m_Deathmatch_Dim)
    giveWeapon(player, 24, 999, true)
    giveWeapon(player, 25, 999)
    giveWeapon(player, 29, 999)
    giveWeapon(player, 34, 999)
    player:setArmor(100)
    player:setStat(71, 999)
    setCameraTarget(player)
end

function DMLobby:sendMessage(text)
    for k, v in ipairs(getElementsByType("player")) do
        if v:getData("Lobby") == "dm" then
            outputChatBox("[DM] #ffffff"..text, v, 0, 150, 255, true)
        end
    end
end

function DMLobby:Event_OnWasted(ammo, killer, weapon, bodypart, stealth)
    if source:getData("Lobby") == "dm" then
        Timer(self.spawnFunction, 2500, 1, source)
    end
end
