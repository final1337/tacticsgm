Core = {}

-- TODO: deactivate when real server is online
DEBUG = false

function Core:constructor()
	outputDebugString("Loading serverside core...")

	core = self

	startResource(dx)

    db = Database:new()
    
	outputDebugString("Serverside-Core has been loaded.")
end

function Core:destructor()

end