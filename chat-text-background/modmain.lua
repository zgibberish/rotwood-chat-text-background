local Image = require "widgets.image"

local bg_opacity = GetModConfigData("bg_opacity")

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
