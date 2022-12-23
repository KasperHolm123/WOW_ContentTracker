INTERNAL = {
    mainFrame = CreateFrame("Frame", ADDONNAME.."_optionsFrame", UIParent, "BackdropTemplate")
}

function ContentTracker:BuildUI()
    -- parent frame settings
    INTERNAL["mainFrame"]:SetPoint("CENTER")
    INTERNAL["mainFrame"]:SetSize(350, 250)
    INTERNAL["mainFrame"]:SetBackdrop(BACKDROP_TUTORIAL_16_16)
    INTERNAL["mainFrame"]:EnableMouse(true)
    INTERNAL["mainFrame"]:SetMovable(true)
    INTERNAL["mainFrame"]:SetResizable(true)
    INTERNAL["mainFrame"]:RegisterForDrag("LeftButton")
    INTERNAL["mainFrame"]:SetResizeBounds(300, 200, 800, 500)

    -- status bar
    CTUI_StatusBar()
    -- close button
    CTUI_CloseButton()
    -- resize button
    CTUI_ResizeButton()
    -- tracking container
    CTUI_TrackerContainer()


    -- don't show main frame on creation
    --internal["mainFrame"]:Hide() -- debug
end

function CTUI_CloseButton()
    local x = CreateFrame("Button", nil, INTERNAL["mainFrame"], "UIPanelButtonTemplate")
    x:SetText("X")
    x:SetPoint("TOPRIGHT")
    x:SetSize(24, 24)
    x:SetScript("OnClick", function(self)
        self:GetParent():Hide()
    end)
end

function CTUI_ResizeButton()
    local x = CreateFrame("Button", nil, INTERNAL["mainFrame"])
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
    local x = CreateFrame("StatusBar", nil, INTERNAL["mainFrame"])
    x:SetPoint("TOPLEFT", 48, 0)
    x:SetSize((x:GetParent():GetWidth() - 72), 32)
    x:SetScript("OnMouseDown", function (self)
        self:GetParent():StartMoving()
    end)
    x:SetScript("OnMouseUp", function (self)
        self:GetParent():StopMovingOrSizing()
    end)
    x:GetParent():SetScript("OnSizeChanged", function (self)
        self:SetSize((x:GetParent():GetWidth() - 24), 32)
    end)

    -- "new" button is a part of the status bar
    local y = CreateFrame("Button", nil, INTERNAL["mainFrame"], "UIPanelButtonTemplate")
    y:SetPoint("TOPLEFT")
    y:SetSize(48, 32)
    y:SetText("New")
    y:SetScript("OnClick", function(self)
        print("clicked")
    end)
end

function CTUI_TrackerContainer()
    local x = CreateFrame("ScrollFrame", nil, INTERNAL["mainFrame"], "UIPanelScrollFrameTemplate")
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