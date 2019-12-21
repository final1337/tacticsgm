function isValidSkin( thePlayer, command, specifiedSkin )  -- Define the function
    if ( specifiedSkin ) then -- If skin specified
        local allSkins = getValidPedModels ( ) -- Get valid skin IDs
        local result = false -- Define result, it is currently false
        for key, skin in ipairs( allSkins ) do -- Check all skins
            if skin == tonumber( specifiedSkin ) then -- If skin equals specified one, it is valid
                result = skin -- So set it as result
                break --stop looping through a table after we found the skin
            end
        end
        if ( result ) then -- If we got results
            outputChatBox( result .. " is a valid skin ID.", thePlayer, 0, 255, 0 ) -- It is valid, output it
        else -- If we didn't get results
            outputChatBox( specifiedSkin .. " is not a valid skin ID.", thePlayer, 0, 255, 0 ) -- No result, it is not valid
        end
    else -- If no skin specified
        outputChatBox( "Please specify a skin ID to check!", thePlayer, 255, 0, 0 ) -- Tell it to the player
    end
end
addCommandHandler("checkskin",isValidSkin) -- bind 'checkskin' command to 'isValidSkin' function