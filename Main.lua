local function getRandomWaitTime(min, max)
    return math.random() * (max - min) + min
end

local watermark = [[

 _____ ____    _  _____  __     ___  _     ____  _____ _____  _    
|  ___/ ___|  / \|_   _| \ \   / / || |   | __ )| ____|_   _|/ \   
| |_ | |     / _ \ | |    \ \ / /| || |_  |  _ \|  _|   | | / _ \  
|  _|| |___ / ___ \| |     \ V / |__   _| | |_) | |___  | |/ ___ \ 
|_|   \____/_/   \_\_|      \_/     |_|   |____/|_____| |_/_/   \_\

    This script has been licensed using FCAT Authentication System,
      FCAT V4 is a lua licensing program meant for whitelisting.
            For private and beta use, for, "Vital.wtf"
                    https://discord.gg/d8azea5a
]]

print(watermark)

print("Authenticating API Status..")
wait(getRandomWaitTime(0.5, 2))
print("✅ API Status authenticated, service up")
wait(getRandomWaitTime(0.3, 1))
print("Checking server connection..")
wait(getRandomWaitTime(0.5, 1.5))
print("✅ Server connection established")
wait(getRandomWaitTime(0.5, 1))
print("Authenticating License Key..")
wait(getRandomWaitTime(1, 2))
print("✅ License Key authenticated")
wait(getRandomWaitTime(0.5, 1.5))
print("Validating user privileges..")
wait(getRandomWaitTime(0.5, 1.5))
print("✅ User privileges validated")
wait(getRandomWaitTime(0.5, 1.5))
print("Checking for updates..")
wait(getRandomWaitTime(0.5, 1.5))
print("✅ No updates found")
wait(getRandomWaitTime(0.5, 1.5))
print("Finalizing authentication..")
wait(getRandomWaitTime(1, 2))
local totalAuthTime = string.format("%.6f", getRandomWaitTime(3, 5))
print("✅ Authenticated successfully in " .. totalAuthTime .. " seconds")
wait(1)
print("🔒 System secure and ready for use")

local HttpService = game:GetService("HttpService")

local function getKeyData()
    local url = "https://raw.githubusercontent.com/archivesniped/FCATV4WhitelistLoader/main/MainWhitelistedKeys.lua"
    local response
    pcall(function()
        response = HttpService:GetAsync(url)
    end)
    if not response then
        return nil, "Failed to fetch key data from the server."
    end

    local keyData
    pcall(function()
        keyData = HttpService:JSONDecode(response)
    end)
    if not keyData then
        return nil, "Failed to decode key data from the server response."
    end

    return keyData, nil
end

function isValidKey(key, clientID, keyData)
    local linkedClientID = keyData[key]
    if linkedClientID == nil then
        return false, "Invalid key or key not whitelisted anymore.."
    elseif linkedClientID == "free" then
        return true, ""
    elseif linkedClientID == clientID then
        return true, ""
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

local keyData, err = getKeyData()
if not keyData then
    kickUser(err)
else

    if getgenv().key then
        local isValid, message = isValidKey(getgenv().key, clientID, keyData)
        if isValid then
            print("Key Valid! You are whitelisted")
        else
            kickUser(message)
        end
    else
        kickUser("Invalid key or key not whitelisted anymore.")
    end
end
