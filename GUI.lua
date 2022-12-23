INTERNAL = {
    MAIN = {
        mainFrame = CreateFrame("Frame", ADDONNAME.."_optionsFrame", UIParent, "BackdropTemplate")
    },
    POPUP = {}
}

--[[ MAIN FRAME ]]

function ContentTracker:BuildUI()
    INTERNAL["MAIN"]["mainFrame"]:SetPoint("CENTER", -400, 200)
    INTERNAL["MAIN"]["mainFrame"]:SetSize(750, 500)
    INTERNAL["MAIN"]["mainFrame"]:SetBackdrop({
        bgFile = "Interface/AchievementFrame/UI-Achievement-StatsBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16
    })

    -- status bar
    Shared_StatusBar(INTERNAL["MAIN"]["mainFrame"], false)
    -- new entry button
    Main_NewEntry(INTERNAL["MAIN"]["mainFrame"])
    -- close button
    Shared_CloseButton(INTERNAL["MAIN"]["mainFrame"])
end

function Main_NewEntry(parentFrame)
    local y = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
    y:SetPoint("TOPLEFT", 3, -3)
    y:SetSize(48, 32)
    y:SetText("New")
    y:SetScript("OnClick", function(self)
        print("clicked")
    end)
end

function NewEntry_PopUp()
    local x = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")

end

--[[ POPUP FRAME ]]

function ContentTracker:BuildPopUp()
    local x = CreateFrame("Frame", "CT_popupFrame", UIParent, "BackdropTemplate")
    tinsert(INTERNAL, x)
    
    -- parent frame settings
    INTERNAL["CT_popupFrame"]:SetPoint("CENTER")
    INTERNAL["CT_popupFrame"]:SetSize(350, 250)
    INTERNAL["CT_popupFrame"]:SetBackdrop(BACKDROP_TUTORIAL_16_16)
    INTERNAL["CT_popupFrame"]:EnableMouse(true)
    INTERNAL["CT_popupFrame"]:SetMovable(true)
    INTERNAL["CT_popupFrame"]:SetResizable(true)
    INTERNAL["CT_popupFrame"]:RegisterForDrag("LeftButton")
    INTERNAL["CT_popupFrame"]:SetResizeBounds(300, 200, 800, 500)

    -- status bar
    Shared_StatusBar(INTERNAL["CT_popupFrame"], true)
    -- close button
    Shared_CloseButton(INTERNAL["CT_popupFrame"])
    -- resize button
    PopUp_ResizeButton()
    -- tracking container
    PopUp_TrackerContainer()


    -- don't show main frame on creation
    --internal["mainFrame"]:Hide() -- debug
end

function PopUp_ResizeButton()
    local x = CreateFrame("Button", nil, INTERNAL["CT_popupFrame"])
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

function PopUp_TrackerContainer()
    local x = CreateFrame("ScrollFrame", nil, INTERNAL["CT_popupFrame"], "UIPanelScrollFrameTemplate")
    x:SetPoint("CENTER", -12, -8)
    x:SetSize((x:GetParent():GetWidth() - 36), (x:GetParent():GetHeight() - 48))

    local scrollChild = CreateFrame("Frame")
    x:SetScrollChild(scrollChild)
    scrollChild:SetWidth(x:GetWidth()-18)
    scrollChild:SetHeight(1)

    local footer = x:CreateFontString("ARTWORK", nil, "GameFontNormal")
    footer:SetPoint("TOP", 0, -5000)
    footer:SetText("This is 5000 below the top, so the scrollChild automatically expanded.")
end

function CreateEntry()

end

-- [[ SHARED UI ]]

function Shared_CloseButton(parentFrame)
    local x = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
    x:SetText("X")
    x:SetPoint("TOPRIGHT", -3, -3)
    x:SetSize(24, 24)
    x:SetScript("OnClick", function(self)
        self:GetParent():Hide()
    end)
end

function Shared_StatusBar(parentFrame, isDragable)
    local x = CreateFrame("StatusBar", nil, parentFrame)
    x:SetPoint("TOPLEFT", 48, 0)
    x:SetSize((x:GetParent():GetWidth() - 72), 32)
    if (isDragable) then
        x:SetScript("OnMouseDown", function (self)
            self:GetParent():StartMoving()
        end)
        x:SetScript("OnMouseUp", function (self)
            self:GetParent():StopMovingOrSizing()
        end)
        x:GetParent():SetScript("OnSizeChanged", function (self)
            self:SetSize((x:GetParent():GetWidth() - 24), 32)
        end)
    end
end