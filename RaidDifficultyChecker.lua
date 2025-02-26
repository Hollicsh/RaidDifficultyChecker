local addonName, addonTable = ... 
local L = addonTable.Localization

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")

local waitTable = {}
local waitFrame = nil

local function CheckerWait(delay, func, ...)
    if(type(delay) ~= "number" or type(func) ~= "function") then
        return false
    end
    if not waitFrame then
        waitFrame = CreateFrame("Frame", nil, UIParent)
        waitFrame:SetScript("OnUpdate", function(self, elapse)
            for i = #waitTable, 1, -1 do
                local waitRecord = tremove(waitTable, i)
                local d = waitRecord[1]
                local f = waitRecord[2]
                local p = waitRecord[3]
                if d > elapse then
                    tinsert(waitTable, i, {d - elapse, f, p})
                else
                    f(unpack(p))
                end
            end
        end)
    end
    tinsert(waitTable, {delay, func, {...}})
    return true
end

local function GetRaidDifficulty()
    local instanceName, _, difficultyID, _, _, _, _, instanceID, instanceGroupSize = GetInstanceInfo()
    local _, lootSpec = GetSpecializationInfoByID(GetLootSpecialization())
    local _, CurrentSpec = GetSpecializationInfo(GetSpecialization())

    if lootSpec == nil then
        lootSpec = CurrentSpec
    end
   
    local playerCount = (instanceGroupSize == 10 and L["10-Man"] or instanceGroupSize == 25 and L["25-Man"] or instanceGroupSize == 40 and L["40-Man"] or L["Unknown"])
    local difficulties = {
        [3] = L["10-Man"],
        [4] = L["25-Man"],
        [5] = L["10-Man Heroic"],
        [6] = L["25-Man Heroic"],
        [7] = L["Looking for Raid"],
        [9] = L["40-Man"],
        [14] = L["Normal"],
        [15] = L["Heroic"],
        [16] = L["Mythic"],
        [17] = L["Looking for Raid"],
        [33] = L["Timewalking"],
        [151] = L["Timewalking"]
    }
    -- Onyxia's Lair shows difficultyID as 0 and instanceGroupSize as 0 so it shows as unknown
    local difficultyText = difficulties[difficultyID] or L["Unknown"]

    return string.format("%s", difficultyText, playerCount)
end

local function ShowPopup(instanceName, difficulty, lootSpec)
    StaticPopupDialogs["RAID_DIFFICULTY_POPUP"] = {
        text = string.format("%s %s \n %s \n %s %s", L["You have entered"], instanceName, difficulty, L["Current loot spec:"], lootSpec),
        button1 = OKAY,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }
    StaticPopup_Show("RAID_DIFFICULTY_POPUP")
end

frame:SetScript("OnEvent", function()
    local instanceName, instanceType = GetInstanceInfo()
    if instanceType == "raid" then
        -- Add a delay of 2 seconds before showing the popup
        CheckerWait(2, function()
            local difficulty = GetRaidDifficulty()
            local _, lootSpec = GetSpecializationInfoByID(GetLootSpecialization())
            local _, CurrentSpec = GetSpecializationInfo(GetSpecialization())

            if lootSpec == nil then
                lootSpec = CurrentSpec
            end

            ShowPopup(instanceName, difficulty, lootSpec)
        end)
    end
end)
