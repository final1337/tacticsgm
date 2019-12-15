Core = inherit(Object)

-- TODO: deactivate when real server is online
DEBUG = false

function Core:constructor()
	outputDebugString("Loading serverside core...")

	core = self

	-- startResource(lib) -- // LOAD: DX-Lib

	db = Database:new()
	
	RegisterLogin:new()
    
	outputDebugString("Serverside-Core has been loaded.")
end

function Core:destructor()

end