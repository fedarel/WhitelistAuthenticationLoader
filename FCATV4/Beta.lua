-- Define your key data
local keyData = {
    ["test123"] = "ClientID123", 
    ["freeKey"] = "free",        
    ["key"] = nil     
}

function isValidKey(key, clientID)
    local linkedClientID = keyData[key]
    if linkedClientID == nil then
        return false, "This key has been suspended for suspicious activity, please contact support for more information about this issue."
    elseif linkedClientID == "free" then
        if keyData[key] ~= "free" and keyData[key] ~= clientID then
            return false, "This key is linked to a different client ID, please contact support if this is a recurring issue."
        end
        return true
    elseif linkedClientID == clientID then
        return true
    else
        return false, "This key is linked to a different client ID, please contact support if this is a recurring issue."
    end
end

function getClientID()
    local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
    return RbxAnalyticsService:GetClientId()
end

function kickUser(message)
    local player = game.Players.LocalPlayer
    player:Kick(message)
end

local clientID = getClientID()

if getgenv().key then
    local isValid, message = isValidKey(getgenv().key, clientID)
    if isValid then
        print("Key is valid! Proceeding with additional actions.")
        print("Executing additional actions...")
    else
        kickUser(message)
    end
else
    kickUser("Invalid key or key not set. Access denied.")
end
