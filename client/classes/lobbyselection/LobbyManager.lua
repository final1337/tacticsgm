-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        client/classes/lobbyselection/LobbyManager.lua
-- *  PURPOSE:     Lobby Selection
-- *
-- ****************************************************************************


LobbyManager = inherit(Object)

LobbyManager.m_Deathmatch_Dim = 3
LobbyManager.m_Tactics_Dim = 4
LobbyManager.m_1vs1_Dim = 5
LobbyManager.m_DD_Dim = 6

function LobbyManager:constructor()
    
end

function LobbyManager:joinLobby(lobby)
    if lobby == "dm" then
        localPlayer:setData("Lobby", "dm")
        triggerServerEvent("Server:LobbySystem:DM:Spawn", localPlayer, localPlayer)
        localPlayer:setData("Shader:BlackWhite", false)
    end
end