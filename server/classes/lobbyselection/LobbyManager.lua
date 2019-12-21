-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        server/classes/lobbyselection/LobbyManager.lua
-- *  PURPOSE:     Lobby Manager
-- *
-- ****************************************************************************

LobbyManager = inherit(Object)

addEvent("Server:LobbyManager:Spawn", true)

function LobbyManager:constructor()
    addEventHandler("Server:LobbyManager:Spawn", root, bind(self.Event_Spawn, self))
    addCommandHandler("leave", bind(self.Leave, self))
end

function LobbyManager:Event_Spawn(lobby)
    if lobby == "dm" then
        DMLobby:Spawn(client)
    end
end

function LobbyManager:Leave(player)
    local lobby = player:getData("Lobby")
    player:setData("Lobby", "main")
    player:setData("Shader:BlackWhite", true)
    player:setDimension(0)
    player:setInterior(0)
    if lobby == "dm" then
        DMLobby:sendMessage(player:getName().." hat die Lobby verlassen!")
    end
    Timer(function(player)
        fadeCamera(player, true, 1)
        player:setPosition(0, 0, 0)
        player:setFrozen(true)
        showCursor(player, true)
        showChat(player, false)
        setPlayerHudComponentVisible(player, "radar", false)
    end, 2500, 1, player)
end