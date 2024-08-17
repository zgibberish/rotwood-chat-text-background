local Image = require "widgets.image"

local bg_opacity_tbl = {
    [1] = 0,
    [2] = 0.1,
    [3] = 0.2,
    [4] = 0.3,
    [5] = 0.4,
    [6] = 0.5,
    [7] = 0.6,
    [8] = 0.7,
    [9] = 0.8,
    [10] = 0.9,
    [11] = 1,
}
local bg_opacity = bg_opacity_tbl[GetModConfigData("bg_opacity", true)]

AddClassPostConstruct("screens.playerhud", function(self)
    self.chat_history_background = self.chat_history_label:AddChild(Image("images/global/square.tex"))
        :SetName("Chat Background")
        :SetMultColor(GLOBAL.UICOLORS.BACKGROUND_DARK)
        :SetMultColorAlpha(bg_opacity) -- adjust this to change the opacity
        :SendToBack() -- put the background behind chat text
        :Hide()

    local original_ShowChatHistory = self.ShowChatHistory
    self.ShowChatHistory = function()
        original_ShowChatHistory(self)

        if GLOBAL.TheDungeon and GLOBAL.TheDungeon.components.chathistory and GLOBAL.next(GLOBAL.TheDungeon.components.chathistory:GetHistory()) == nil then
            -- dont show the background when theres no text yet, since theres
            -- no bounding box and it would just be a small, empty rectangle
            return
        end

        local x1, y1, x2, y2 = self.chat_history_label:GetBoundingBox()
        local w, h = x2 - x1, y2 - y1

        -- add padding
        w = w + 40
        h = h + 40

        self.chat_history_background
            :SetRect(x1, y1, w, h) -- sets the background's size to the chat text bounding box
            :SetPosition(0, 0) -- resets the background to the center of chat text
            :Show()
    end
end)