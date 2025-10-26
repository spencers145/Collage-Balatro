SMODS.Joker{
   key = 'draw_diamonds',
   atlas = 'roffers',
   pos = {x = 3, y = 8},
   blueprint_compat = false,
   perishable_compat = false,
   discovered = false,
   rarity = 2,
   cost = 7,
   config = { extra = { interest_mod = 1, interest = 0, amount_scored = 0, }},
   loc_vars = function(self, info_queue, card)
      return {
         vars = { card.ability.extra.interest_mod, card.ability.extra.interest, card.ability.extra.amount_scored }
      }
   end,
   calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play and not context.blueprint then
         if context.other_card:is_suit('Diamonds') then
            local suits = {'Spades', 'Hearts', 'Clubs'}
            local interest_cap = G.GAME.interest_cap - (card.ability.extra.interest * 5)
            local kcard = context.other_card
            card.ability.extra.amount_scored = card.ability.extra.amount_scored + 1
            if card.ability.extra.amount_scored == 7 then
               card.ability.extra.interest = card.ability.extra.interest + card.ability.extra.interest_mod
               G.GAME.interest_cap = interest_cap + card.ability.extra.interest * 5
               card.ability.extra.amount_scored = 0
            end
            G.E_MANAGER:add_event(Event{
               trigger = 'after',
               delay = 0.8,
               func = function()
                  SMODS.change_base(kcard, suits[pseudorandom('diamonds', 1, 3)], nil)
                  kcard:juice_up()
                  return true
               end
            })
            if amount_scored == 7 then
               return {
                  message = 'Deposited!'
               }
            end
            if pseudorandom('diamonds') > 0.03 then
               return {
                  message = 'Diamonds!'
               }
            elseif pseudorandom('diamonds') > 0.5 then
               return {
                  message = 'Lapis Lazuli!'
               }
            else
               return {
                  message = 'Glow Lichen!'
               }
            end
         end
      end
      if (context.selling_card or context.remove_playing_cards) and context.card == card and not context.blueprint then
         G.GAME.interest_cap = G.GAME.interest_cap - (card.ability.extra.interest * 5)
      end
   end,
   set_badges = function(self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_art'), ROFF.C.credits.canicao_text, ROFF.C.credits.canicao, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}
