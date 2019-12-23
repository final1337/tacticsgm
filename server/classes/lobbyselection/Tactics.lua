TacticsLobby = inherit(Object)

TacticsLobby.Maps = {}

function TacticsLobby:constructor()
    self.m_Maps = {}
    self.m_MapInt = {}
    self.m_TacticsPlayerTable = {}
    self.m_Player = 0
    self.m_KillTimer = {}
    self.m_Started = {}

    self.m_TacticsTimer = {
        ["Display"] = {},
        ["Countdown"] = {},
        ["Freeze"] = {},
    }
    self.m_NextMap = false

    for k, v in ipairs(getResources()) do
        if string.find(v:getName(), "arena_") then
            if v:getState() == "loaded" then
                self.m_MapInt = self.m_MapInt+1
                self.m_Maps[self.m_MapInt] = v:getName()
                print("[Server] [Lobby] [Tactics] "..(self.m_MapInt).." wurden geladen!")
            end
        end
    end
end