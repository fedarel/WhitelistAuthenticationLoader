-- Define your key data
local keyData = {
    ["test123"] = "ClientID123", -- Replace with actual valid key and corresponding client ID
    ["freeKey"] = "free",        -- Key that can be used by any client
    ["key"] = nil       -- Suspended key
}

-- Function to check if the key is valid and linked to the correct client ID
function isValidKey(key, clientID)
    if keyData[key] == nil then
        if keyData[key] == nil and key == "suspendedKey" then
            return false, "This key has been suspended for suspicious activity, please contact support for more information about this issue."
        else
            return false, "Invalid key or key not set. Access denied."
        end
    elseif keyData[key] == "free" then
        return true, ""
    elseif keyData[key] == clientID then
        return true, ""
    else
        return false, "This key is linked to a different client ID, please contact support if this is a recurring issue."
    end
end

-- Function to get the client ID using rbxanalyticsservice
function getClientID()
    local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
    return RbxAnalyticsService:GetClientId()
end

-- Function to kick the user with a message
function kickUser(message)
    local player = game.Players.LocalPlayer
    player:Kick(message)
end

-- Get the client ID
local clientID = getClientID()

-- Check if getgenv().key is set and if it's valid
if getgenv().key then
    local isValid, message = isValidKey(getgenv().key, clientID)
    if isValid then
        print("Key is valid! Proceeding with additional actions.")
        -- Your whitelisting mechanics and additional actions here
        -- Example:
        print("Executing additional actions...")
        -- Perform additional actions or load more scripts as needed
    else
        kickUser(message)
    end
else
    kickUser("Invalid key or key not set. Access denied.")
end
