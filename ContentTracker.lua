
ADDONNAME = ...
ContentTracker = LibStub("AceAddon-3.0"):NewAddon("ContentTracker", "AceConsole-3.0")

function ContentTracker:OnInitialize()
    ContentTracker:BuildUI()

    -- register chat commands
    self:RegisterChatCommand("ct", "SlashCommand")
    self:RegisterChatCommand("contenttracker", "SlashCommand")
end

function ContentTracker:SlashCommand()
    if (INTERNAL["mainFrame"]:IsVisible()) then
        INTERNAL["mainFrame"]:Hide()
        return
    end
    INTERNAL["mainFrame"]:Show()
end
