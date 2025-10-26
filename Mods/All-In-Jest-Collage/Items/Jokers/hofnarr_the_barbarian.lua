local hofnarr_the_barbarian = {
    object_type = "Joker",
    order = 222,

    key = "hofnarr_the_barbarian",
    config = {
      extra = {
        xmult = 1.5,
        bigxmult = 6
      }
    },
    rarity = 2,
    pos = { x = 11, y = 8},
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_blind'}
      return { vars = {card.ability.extra.xmult, card.ability.extra.bigxmult} }
    end,

    calculate = function(self, card, context)
      if context.setting_blind and not self.getting_sliced and context.blind.boss and math.fmod(G.GAME.round_resets.ante, 8) == 0 then
        G.E_MANAGER:add_event(Event({func = function()
          G.E_MANAGER:add_event(Event({func = function()
              G.GAME.blind:disable()
              play_sound('timpani')
              delay(0.4)
              return true end }))
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
      return true end }))

      end
      if context.joker_main then
        if math.fmod(G.GAME.round_resets.ante, 8) == 0 and G.GAME.blind:get_type() == 'Boss' then
          return {
            xmult = card.ability.extra.bigxmult,
          }
        else
          return {
            xmult = card.ability.extra.xmult,
          }
        end
      end
    end

}
return { name = {"Jokers"}, items = {hofnarr_the_barbarian} }
