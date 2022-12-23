
local addonName = ...
ContentTracker = LibStub("AceAddon-3.0"):NewAddon("ContentTracker", "AceConsole-3.0")
local internal = {
    mainFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
}

function ContentTracker:OnInitialize()
    ContentTracker:BuildUI()

    -- register chat commands
    self:RegisterChatCommand("ct", "SlashCommand")
end



function ContentTracker:BuildUI()
    -- parent frame settings
    internal["mainFrame"]:SetPoint("CENTER")
    internal["mainFrame"]:SetSize(300, 200)
    internal["mainFrame"]:SetBackdrop(BACKDROP_TUTORIAL_16_16)
    internal["mainFrame"]:EnableMouse(true)
    internal["mainFrame"]:SetMovable(true)
    internal["mainFrame"]:SetResizable(true)
    internal["mainFrame"]:RegisterForDrag("LeftButton")
    internal["mainFrame"]:SetResizeBounds(300, 200, 800, 500)

    -- status bar
    CTUI_StatusBar()
    -- close button
    CTUI_CloseButton()
    -- resize button
    CTUI_ResizeButton()

    -- don't show main frame on creation
    internal["mainFrame"]:Hide()
end

function CTUI_CloseButton()
    local x = CreateFrame("Button", addonName.."_optionsFrame", internal["mainFrame"], "UIPanelButtonTemplate")
    x:SetText("X")
    x:SetPoint("TOPRIGHT")
    x:SetSize(24, 24)
    x:SetScript("OnClick", function(self)
        self:GetParent():Hide()
    end)
end

function CTUI_ResizeButton()
    local x = CreateFrame("Button", nil, internal["mainFrame"])
    x:EnableMouse("true")
    x:SetPoint("BOTTOMRIGHT")
    x:SetSize(24, 24)
    x:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    x:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-HighLight")
    x:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    x:SetScript("OnMouseDown", function (self)
        self:GetParent():StartSizing("BOTTOMRIGHT")
    end)
    x:SetScript("OnMouseUp", function (self)
        self:GetParent():StopMovingOrSizing("BOTTOMRIGHT")
    end)
end

function CTUI_StatusBar()
    local x = CreateFrame("StatusBar", nil, internal["mainFrame"])
    x:SetPoint("TOPLEFT")
    x:SetSize((x:GetParent():GetWidth() - 24), 30)
    x:SetScript("OnMouseDown", function (self)
        self:GetParent():StartMoving()
    end)
    x:SetScript("OnMouseUp", function (self)
        self:GetParent():StopMovingOrSizing()
    end)
    x:GetParent():SetScript("OnSizeChanged", function (self)
        self:SetSize((x:GetParent():GetWidth() - 24), 30)
    end)
end

function ContentTracker:SlashCommand()
    internal["mainFrame"]:Show()
end
