local Image = require "widgets.image"
local lume = require "util.lume"

local BG_OPACITY = GetModConfigData("bg_opacity")
local SCROLLABLE_CHAT_MOD_ENABLED = GLOBAL.KnownModIndex:IsModEnabledAny("scrollable-chat")
local LINE_HEIGHT = 60
local PADDING = 40

AddClassPostConstruct("screens.playerhud", function(self)
    if SCROLLABLE_CHAT_MOD_ENABLED then
        -- cant have background as chat's child because we dont want it to get
        -- affected by scrollable chat mask
        self.chat_history_background = self.root:AddChild(Image("images/global/square.tex"))
            :SetRegistration("left","bottom")
            :SetAnchors("left", "bottom")
    else
        self.chat_history_background = self.chat_history_label:AddChild(Image("images/global/square.tex"))
    end
        
    self.chat_history_background
        :SetName("Chat Background")
        :SetMultColor(GLOBAL.UICOLORS.BACKGROUND_DARK)
        :SetMultColorAlpha(BG_OPACITY) -- adjust this to change the opacity
        :SendToBack()
        :SetClickable(false)
        :Hide()

    -- chat_history_background would be  chat_history_label's sibling if we
    -- have the scrollable chat mod, so we would have to manually match its opacity
    -- to chat's opacity
    if SCROLLABLE_CHAT_MOD_ENABLED then
        local original_OnUpdate = self.OnUpdate
        function self:OnUpdate(dt)
            original_OnUpdate(self, dt)
            local alpha = lume.lerp(0, BG_OPACITY, self.chat_history_label:GetMultColorAlpha())
            self.chat_history_background:SetMultColorAlpha(alpha)
        end
    end

    local original_ShowChatHistory = self.ShowChatHistory
    function self:ShowChatHistory(...)
        original_ShowChatHistory(self, ...)

        if GLOBAL.TheDungeon and GLOBAL.TheDungeon.components.chathistory and GLOBAL.next(GLOBAL.TheDungeon.components.chathistory:GetHistory()) == nil then
            -- dont show the background when theres no text yet, since theres
            -- no bounding box and it would just be a small, empty rectangle
            return
        end

        local x1, y1, x2, y2 = self.chat_history_label:GetBoundingBox()
        local w, h = 0, 0
        if SCROLLABLE_CHAT_MOD_ENABLED then
            w, h = x2 - x1, LINE_HEIGHT * math.min(self.chat_history_label:GetLines(), self.chat_history_label.chat_lines_shown)
        else
            w, h = x2 - x1, y2 - y1
        end

        -- add padding
        w = w + PADDING
        h = h + PADDING

        self.chat_history_background
            :SetRect(x1, y1, w, h) -- sets the background's size to the chat text bounding box
        if SCROLLABLE_CHAT_MOD_ENABLED then
            local origin_x, origin_y = self.chat_history_label.chat_origin_x, self.chat_history_label.chat_origin_y
            self.chat_history_background:SetPosition(origin_x-PADDING/2, origin_y-PADDING/2-6)
        else
            self.chat_history_background:SetPosition(0, 0)
        end

        self.chat_history_background:Show()
    end
end)
