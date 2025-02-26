local addonName, addonTable = ...
local L = {}
addonTable.Localization = L

if GetLocale() == "enUS" then
    L["You have entered"]           = "You have entered"
    L["Current loot spec:"]         = "Current loot spec:"
    L["10-Man"]                     = "10-Man Normal"
    L["25-Man"]                     = "25-Man Normal"
    L["10-Man Heroic"]              = "10-Man Heroic"
    L["25-Man Heroic"]              = "25-Man Heroic"
    L["40-Man"]                     = "40-Man"
    L["Looking for Raid"]           = "Looking for Raid"
    L["Normal"]                     = "Normal"
    L["Heroic"]                     = "Heroic"
    L["Mythic"]                     = "Mythic"
    L["Timewalking"]                = "Timewalking"
    L["Unknown"]                    = "Unknown"
end

if GetLocale() == "ruRU" then
    L["You have entered"]           = "Вы вошли"
    L["Current loot spec:"]         = "Добыча для специализации:"
    L["10-Man"]                     = "10 человек, обычный"
    L["25-Man"]                     = "25 человек, обычный"
    L["10-Man Heroic"]              = "10 человек, героический"
    L["25-Man Heroic"]              = "25 человек, героический"
    L["40-Man"]                     = "40 человек"
    L["Looking for Raid"]           = "Поиск рейда"
    L["Normal"]                     = "Обычный"
    L["Heroic"]                     = "Героический"
    L["Mythic"]                     = "Эпохальный"
    L["Timewalking"]                = "Путешествие во времени"
    L["Unknown"]                    = "Неизвестно"
end
