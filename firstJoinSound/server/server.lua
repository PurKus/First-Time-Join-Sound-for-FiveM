local ALWAYS_PLAY_DEBUG = false -- Set this to true to always play the sound on join (for testing purposes).
local SHOW_DEBUG_PRINTS = false -- Change this to false if you don't want debug prints.

-- Check if the player has joined for the first time.
local function isFirstTimeJoin(playerId, callback)
    local identifier = GetPlayerIdentifier(playerId, 0)
    
    exports.oxmysql:scalar("SELECT hasJoined FROM joined_players WHERE identifier = ?", { identifier }, function(hasJoined)
        if hasJoined then
            callback(false)
        else
            callback(true)
        end
    end)
end

-- Mark a player as having joined.
local function setPlayerAsJoined(playerId)
    local identifier = GetPlayerIdentifier(playerId, 0)
    
    exports.oxmysql:execute("INSERT INTO joined_players (identifier, hasJoined) VALUES (?, true) ON DUPLICATE KEY UPDATE hasJoined = true", { identifier })
end

RegisterServerEvent('firstJoinSound:playerJoined')
AddEventHandler('firstJoinSound:playerJoined', function()
    local _source = source
    if SHOW_DEBUG_PRINTS then print("[DEBUG] Player with ID: " .. GetPlayerIdentifier(_source, 0) .. " is trying to connect.") end
    
    isFirstTimeJoin(_source, function(isFirstTime)
        if isFirstTime or ALWAYS_PLAY_DEBUG then
            if SHOW_DEBUG_PRINTS then print("[DEBUG] Player with ID: " .. GetPlayerIdentifier(_source, 0) .. " is joining for the first time or ALWAYS_PLAY_DEBUG is true.") end
            TriggerClientEvent('firstJoinSound:playSound', _source)
            setPlayerAsJoined(_source)
        end
    end)
end)
