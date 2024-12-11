if not isClient() then
    return
end
require "ISUI/ISCollapsableWindowJoypad"
local PhunSpawn = PhunSpawn

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)

local FONT_SCALE = FONT_HGT_SMALL / 14
local HEADER_HGT = FONT_HGT_MEDIUM + 2 * 2

PhunStuffUIWelcome = ISCollapsableWindowJoypad:derive("PhunStuffUIWelcome");
PhunStuffUIWelcome.instances = {}
local UI = PhunStuffUIWelcome

function UI.OnOpenPanel(playerIndex, playerObj)

    if UI.instances[playerIndex] then
        -- there is already an instance of this panel for this player
        if not UI.instances[playerIndex]:isVisible() then
            UI.instances[playerIndex].panelIndex = 1
            UI.instances[playerIndex]:addToUIManager();

            UI.instances[playerIndex]:setVisible(true);
            UI.instances[playerIndex]:ensureVisible()

            return
        end
        return
    end

    local core = getCore()
    local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 14
    local width = 800 * FONT_SCALE
    local height = 590 * FONT_SCALE

    local x = (core:getScreenWidth() - width) / 2
    local y = (core:getScreenHeight() - height) / 2

    local pIndex = playerObj:getPlayerNum()
    UI.instances[playerIndex] = UI:new(x, y, width, height, playerObj);

    UI.instances[playerIndex]:initialise();

    UI.instances[playerIndex]:addToUIManager();
    UI.instances[playerIndex]:ensureVisible()
    UI.instances[playerIndex].panelIndex = 1

    return UI.instances[playerIndex];

end

function UI:new(x, y, width, height, player)
    local o = {};
    o = ISCollapsableWindowJoypad:new(x, y, width, height, player);
    setmetatable(o, self);
    self.__index = self;

    o.variableColor = {
        r = 0.9,
        g = 0.55,
        b = 0.1,
        a = 1
    };
    o.backgroundColor = {
        r = 0,
        g = 0,
        b = 0,
        a = 0.8
    };
    o.buttonBorderColor = {
        r = 0.7,
        g = 0.7,
        b = 0.7,
        a = 1
    };
    o.moveWithMouse = false;
    o.anchorRight = true
    o.anchorBottom = true
    o.player = player
    o.pIndex = player:getPlayerNum()
    o.zOffsetLargeFont = 25;
    o.zOffsetMediumFont = 20;
    o.zOffsetSmallFont = 6;
    o:setWantKeyEvents(true)
    o:setTitle("Scrapbook")
    return o;
end

function UI:close()
    self:removeFromUIManager();
    UI.instances[self.pIndex] = nil
end

function UI:navigateNext()
    local page = self.page.selected
    if page < #self.panelImages then
        page = page + 1
        self:navigate(page)
    end
end

function UI:navigatePrevious()
    local page = self.page.selected
    if page > 1 then
        page = page - 1
        self:navigate(page)
    end
end

-- line = soft break
-- br = hard break
-- text = normal text
local txts = {
    txt0 = "<H2><LEFT>Welcome <LINE><TEXT>This small guide will intro you to some of the unique and custom features of this server. <BR>You can open this window at any time by clicking the location widget: <BR><IMAGECENTRE:media/textures/PhunStuff_LocationWidget.png>",
    txt1 = "<H2><LEFT>The Hospital <LINE><TEXT>You have awoken in what appears to be an underground, hidden hopital room. <BR>This unique spawning system increases a sense of danger when exploring new areas. While encouraging community interation.",
    txt2 = "<H2><LEFT>First Loot <LINE><TEXT>When you awaken, all of the clothing and gear you would normally have spawned in with will be located in the drawers next to the bed. <BR>Gear is profession specific. Some professions get better gear than others.",
    txt3 = "<H2><LEFT>The Escape <LINE><TEXT>When you're ready to exit, you can escape through the vent. In case you want to avoid entering the world in the dark, check the clock first! You will then be prompted to choose which location you want to spawn in. <BR><LEFT><RGB:1,1,0>IMPORTANT: <LINE><TEXT>You can only ever spawn into the world at a vent you have discovered or crafted.",
    txt4 = "<H2><LEFT>Clues <LINE><TEXT>Since you can only spawn at vents, you will need to find or craft more as you explore Kentucky. <BR>To help find more vents, look for Clues that can drop from zeds. You can also craft vents through in the crafting window. <BR><RGB:1,1,0>Note: <LINE><TEXT>Although you can place a vent within your safehouse, you cannot claim a safehouse if the building has an existing vent (as it could allow others to spawn into the safehouse). Because you can't crawl from a vent into a vehicle, vents cannot place inside an RV.",
    txt5 = "<H2><LEFT>Sprinters <LINE><TEXT>Depending on where you are and how dark (or foggy) it is, you may encouter sprinters. <BR>These sprinters are faster than normal zeds and can be quite dangerous. <BR>Be cautious when exploring new areas. <BR><H2><LEFT><RGB:1,1,0>Tips <LINE><TEXT>- Sprinters look like skeletons <LINE>- Sprinters stop running if its light. <LINE>- Attach a flashlight to your belt, backpack or helmet to slow them down <LINE>- Keep an eye on your location, it will indicate the risk level of spawning sprinters",
    txt6 = "<H2><LEFT>A Cure? <LINE><TEXT>Hazmat zeds drop special Ampules which will can remove the Knox virus. Trouble is, it will go off and become ineffectual within a couple days. Best to keep refridgerated or frozen!",
    txt7 = "<H2><LEFT>Shopping <LINE><TEXT>Almost everything in game can be purchased at special vending machines scattered across the map. <BR>These machines take a variety of currency (most which drop from zeds) and let you buy things from cars to weapons to boosts and perks <BR><H2><LEFT>Currency <LINE><TEXT>The different coins you pick up go into your wallet which can be found on a tab in your health and skill window. <BR><IMAGECENTRE:media/textures/PhunStuff_TextWallet.png> <LINE><TEXT>If you die, you can recover your wallet from your body, though some coins will be lost.<BR><IMAGECENTRE:media/textures/PhunStuff_TextWalletPickup.png> ",
    txt8 = "<H2><LEFT>Safe Space <LINE><TEXT>The Michelles Crafts vending machine sells a special item called Repellent Paint which allows you to create a Safehouse from scratch or to extend an existing Safehouse",
    txt9 = "<H2><LEFT>Car Claims <LINE><TEXT>Want to protect your car and it's contents? Claim it! <BR>You can claim up to 5 cars. In order to claim, you need to craft a Mysterious Orb which you can find in the crafting window <BR><IMAGECENTRE:media/textures/PhunStuff_TextCraftOrb.png> ",
    txt10 = "<H2><LEFT>Solar <LINE><TEXT>Don't let climate change destroy your apocolypse! <BR>Keep an eye out for solar panels and related parts. They are critical for power generation after gas stations run dry!",
    txt11 = "<H2><LEFT>Join the discord! <LINE><TEXT>For important info, click here. <BR><H2><LEFT>Journaling <LINE><TEXT>Craft a Journal (search in the crafting window) to preserve most of your skills between spawns. <BR><IMAGECENTRE:media/textures/PhunStuff_TextCraftJournal.png>  <BR><H2><LEFT>Car Claims <LINE><TEXT>Claim up to 5 cars by crafting and applying a Mysterious Orb (search in the crafting window). <BR><H2><LEFT>Loot respawns <LINE><TEXT>Every few days as long as the container has been emptied and is not player made. Note that some map mods do their own thing. <BR><H2><LEFT>Vanishing Items <LINE><TEXT>With few exceptions, dropped loot will despawn. If you want something to stay on the floor, place it!"
}

function UI:navigate(page)
    if self.page.selected ~= page then
        self.page.selected = page
    end
    self.imagePanel.texture = self.panelImages[page].texture

    local txt = getTextOrNull("IGUI_PhunStuff_WelcomeText" .. (page - 1)) or ""
    if txts["txt" .. (page - 1)] then
        txt = txts["txt" .. (page - 1)]
    end
    local link = getTextOrNull("IGUI_PhunStuff_WelcomeClick" .. (page - 1))
    self.description:setText(txt)
    self.description:paginate()

    self.previousDisable:setVisible(page <= 1)
    self.nextDisable:setVisible(page >= #self.panelImages)
end

function UI:onMouseMove(dx, dy)

    if self.downY and self.downX and not self.dragging then
        if math.abs(self.downX - dx) > 4 or math.abs(self.downY - dy) > 4 then
            self.dragging = true
            self:setCapture(true)
        end
    end

    if self.dragging then
        local dx = self:getMouseX() - self.downX
        local dy = self:getMouseY() - self.downY
        self.userPosition = true
        self:setX(self.x + dx)
        self:setY(self.y + dy)
    end
end

function UI:onMouseDown(x, y)
    self.downX = self:getMouseX()
    self.downY = self:getMouseY()
    return true
end

function UI:onMouseUp(x, y)
    self.downY = nil
    self.downX = nil
    if not self.dragging then
        if self.onClick then
            self:onClick(self.page.selected)
        end
    else
        self.dragging = false
        self:setCapture(false)
    end
    return true
end

function UI:onClick(page)

    local link = getTextOrNull("IGUI_PhunStuff_WelcomeClick" .. (page - 1))
    if not link then
        return
    end

    Clipboard.setClipboard(link);
    local w = 300
    local h = 150
    local modal = ISModalDialog:new(getCore():getScreenWidth() / 2 - w / 2, getCore():getScreenHeight() / 2 - h / 2, w,
        h, "Link Copied to your clipboard", false, nil, nil, nil);
    modal:initialise()
    modal:addToUIManager()

end

function UI:createChildren()

    ISCollapsableWindowJoypad.createChildren(self);

    if not self.panelImages then
        self.panelImages = {}
        for i = 1, 15 do
            local texture = getTexture("media/textures/PhunStuff_Welcome" .. (i - 1) .. ".png")
            if not texture then
                break
            end
            local backgroundWidth = texture:getWidth()
            local backgroundHeight = texture:getHeight()
            table.insert(self.panelImages, {
                texture = texture,
                width = backgroundWidth,
                height = backgroundHeight
            })
        end

    end

    local th = self:titleBarHeight()
    local rh = self:resizeWidgetHeight()

    local padding = 10
    local x = padding
    local y = th + padding

    self.imagePanel = ISImage:new(x, y, self.height - th - rh - 2, self.height - th - rh - 2,
        self.panelImages[1].texture);

    self.imagePanel.scaledWidth = self.imagePanel.width
    self.imagePanel.scaledHeight = self.imagePanel.height

    self.imagePanel.borderColor = {
        r = 0.7,
        g = 0.7,
        b = 0.7,
        a = 1
    };
    self.imagePanel.onMouseUp = function(x, y)
        self:onMouseUp(x, y)
    end
    self.imagePanel:initialise();
    self.imagePanel:instantiate();
    self:addChild(self.imagePanel);

    x = self.imagePanel.x + self.imagePanel.width + padding

    self.page = ISComboBox:new(x, y, 215, FONT_HGT_MEDIUM, self, function()
        self:navigate(self.page.selected)
    end);
    self.page:initialise()
    self:addChild(self.page)

    for i = 1, #self.panelImages do
        self.page:addOption(getTextOrNull("IGUI_PhunStuff_WelcomeTitle" .. (i - 1)) or "Page " .. i)
    end

    self.page.selected = 1

    y = y + self.page.height + padding

    -- description
    self.description = ISRichTextPanel:new(x, y, self.width - x - padding,
        self.height - (self.page.y - self.page.height - padding));
    self.description:initialise();
    self.description:instantiate();
    self.description.borderColor = {
        r = 0.7,
        g = 0.7,
        b = 0.7,
        a = 1
    };
    self.description.backgroundColor = {
        r = 0,
        g = 0,
        b = 0,
        a = 0.8
    };
    -- self.description.onMouseMove = self.onMouseMove
    -- self.description.onMouseDown = self.onMouseDown
    self.description.onMouseUp = function(x, y)
        self:onMouseUp(x, y)
    end
    self.description.borderColor = self.buttonBorderColor
    self.description.autosetheight = false
    self.description:setText(getText("IGUI_PhunStuff_WelcomeText0"))
    self.description:paginate()

    self:addChild(self.description);

    y = self.description.y + self.description.height + 10

    -- self.skipper = ISTickBox:new(x, self.height - 35, 25, 25, "", self, function()

    -- end)
    -- self.skipper:initialise();
    -- self.skipper:addOption("Skip this message");
    -- self.skipper.changeOptionMethod = function()
    --     local settings = ModData.getOrCreate(PhunSpawn.consts.settings)
    --     settings.skipExitConfirmation = self.skipper:isSelected(1)
    -- end
    -- self.skipper:setSelected(1, false)
    -- self:addChild(self.skipper);

    -- local btnWidth = ((self.description.width - padding) / 2)

    -- prev button
    -- self.previous = ISButton:new(x, y, btnWidth, 40, " < ", self, function()
    self.previous = ISButton:new(self.page.x + self.page.width + padding, self.page.y, self.page.height,
        self.page.height, " < ", self, function()
            self:navigatePrevious()
            -- if self.panelIndex > 1 then
            --     self.panelIndex = self.panelIndex - 1
            --     self.imagePanel.texture = self.panelImages[self.panelIndex].texture
            -- end
            -- if self.panelIndex == 1 then
            --     self.previousDisable:setVisible(true)
            -- else
            --     self.previousDisable:setVisible(false)
            -- end
            -- if self.panelIndex > (#self.panelImages - 1) then
            --     self.nextDisable:setVisible(true)
            -- end
        end)
    self.previous:initialise()
    self:addChild(self.previous)

    -- disabled cover for ok button
    self.previousDisable = ISPanel:new(self.previous.x, self.previous.y, self.previous.width, self.previous.height);
    self.previousDisable:initialise();
    self.previousDisable.backgroundColor = {
        r = 0,
        g = 0,
        b = 0,
        a = 0.8
    };
    self.previousDisable.borderColor = {
        r = 0,
        g = 0,
        b = 0,
        a = 0.8
    };
    self.previousDisable:setVisible(true)
    self:addChild(self.previousDisable)

    -- next button
    -- self.next = ISButton:new(x + btnWidth + padding, y, btnWidth, 40, " > ", self, function()
    self.next = ISButton:new(self.previous.x + self.previous.width + padding, self.previous.y, self.previous.width,
        self.previous.height, " > ", self, function()
            self:navigateNext()
            -- if self.panelIndex < #self.panelImages then
            --     self.panelIndex = self.panelIndex + 1
            --     self.imagePanel.texture = self.panelImages[self.panelIndex].texture
            -- end
            -- if self.panelIndex > (#self.panelImages - 1) then
            --     self.nextDisable:setVisible(true)
            -- else
            --     self.nextDisable:setVisible(false)
            -- end
            -- if self.panelIndex > 1 then
            --     self.previousDisable:setVisible(false)
            -- end
        end)
    self.next:initialise()
    self:addChild(self.next)
    -- disabled cover for ok button
    self.nextDisable = ISPanel:new(self.next.x, self.next.y, self.next.width, self.next.height);
    self.nextDisable:initialise();
    self.nextDisable.backgroundColor = {
        r = 0,
        g = 0,
        b = 0,
        a = 0.8
    };
    self.nextDisable.borderColor = {
        r = 0,
        g = 0,
        b = 0,
        a = 0.8
    };
    self.nextDisable:setVisible(false)
    self:addChild(self.nextDisable)
    -- close button
    -- self.closeButton = ISButton:new(self.width - 35, 10, 25, 25, "X", self, function()
    --     self:close()
    -- end)
    -- self.closeButton:initialise()
    -- self:addChild(self.closeButton)

    -- -- ok button
    -- self.ok = ISButton:new(self.width - 110, self.height - 35, 100, 25, "Ok", self, function()

    --     -- self.destination.map:doTele(self.destination.x, self.destination.y, self.destination.z)
    --     -- self.destination.map:close()

    --     self:close()

    -- end)
    -- self.ok:initialise()
    -- self:addChild(self.ok)

    -- -- disabled cover for ok button
    -- self.notOk = ISPanel:new(self.ok.x, self.ok.y, self.ok.width, self.ok.height);
    -- self.notOk:initialise();
    -- self.notOk.backgroundColor = {
    --     r = 0,
    --     g = 0,
    --     b = 0,
    --     a = 1
    -- };
    -- self.notOk.borderColor = {
    --     r = 0,
    --     g = 0,
    --     b = 0,
    --     a = 1
    -- };
    -- self.notOk:setVisible(true)
    -- self:addChild(self.notOk)

end

function UI:prerender()

    ISCollapsableWindowJoypad.prerender(self);
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g,
        self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g,
        self.borderColor.b);

    if not self.panelImages then
        self.panelImages = {}
        for i = 1, 10 do
            local texture = getTexture("media/textures/PhunStuff_Welcome" .. i .. ".png")
            if not texture then
                break
            end
            local backgroundWidth = texture:getWidth()
            local backgroundHeight = texture:getHeight()
            table.insert(self.panelImages, {
                texture = texture,
                width = backgroundWidth,
                height = backgroundHeight
            })
        end

    end

    local image = self.panelImages[self.panelIndex]

    -- self.imagePanel:drawTextureScaledAspect(image.texture, 0, 0, self.imagePanel.width, self.imagePanel.height, 1);
    -- local twidth = self.richText.backgroundImage:getWidth()
    -- local left = self.richText.width - twidth

    -- local bgX = left + 1
    -- local bgY = y + 1
    -- self:setStencilRect(x + 1, y, x2 - 2, y2)

    -- self:drawTexture(self.richText.backgroundImage, bgX, bgY, 0.5, 0.7, 0.7, 0.7);
    -- self:clearStencilRect()

end
