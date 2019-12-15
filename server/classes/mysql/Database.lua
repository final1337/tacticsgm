-- ****************************************************************************
-- *
-- *  PROJECT:     Hamburg Tactics
-- *  FILE:        server/classes/mysql/Database.lua
-- *  PURPOSE:     Database Settings (SQL-Connection, Gamemodesettings, ...)
-- *
-- ****************************************************************************

Database = inherit(Singleton)

function Database:constructor()
    handler = dbConnect("mysql", "dbname=tacticsgm;host=127.0.0.1;port=3306", "root", "", "share-1")
    self.m_HandlerName = handler

    print("Loading database-connection...")

    if handler then
        print("Database-connection loaded successfully!")
    else
        print("Failed to connect to database!")
        stopResource(getThisResource())
    end
end

function Database:query(query, callBackFunction, callBackArguments, ...)
    return dbQuery(self.m_HandlerName, query, callBackFunction, callBackArguments, ...)
end

function Database:poll(query, timeout)
    return dbPoll(query, timeout)
end

function Database:exec(query, ...)
    return dbExec(self.m_HandlerName, query, ...)
end
