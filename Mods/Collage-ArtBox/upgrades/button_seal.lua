SMODS.Seal {
    key = "button",
    badge_colour = HEX("4f6367"),
    atlas = "seal_atlas",
    pos = {x= 3, y= 0},
    discovered = false,

    calculate = function(self, card, context)

      if context.cardarea == G.play and context.main_scoring then
        local cards = {}
        local valid_targets
        if G.hand and G.hand.cards and #G.hand.cards > 0 then
            for k, v in ipairs(G.hand.cards) do
            if not v.base.suit~=card.base.suit then 
                valid_targets=true
            end
        end
        else
            valid_targets=false
        end

        if valid_targets==true then
          for k, v in ipairs(G.hand.cards) do
            if v.base.suit~=card.base.suit then cards[#cards + 1] = v end
            end
            local _card = pseudorandom_element(cards, pseudoseed('button'))
            if _card~=nil then
              G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                SMODS.change_base(_card, card.base.suit,nil)
                _card:juice_up(0.3, 0.5)
              return true end }))
            end
          
        end
      end
    end
}