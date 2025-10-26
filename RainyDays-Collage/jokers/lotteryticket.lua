SMODS.Joker {
  key = 'lotteryticket',
  name = 'Lottery Ticket',
  atlas = 'Jokers',
  rarity = 1,
  cost = 5,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('lotteryticket'),
  config = {
    lottery_string = "",
    extra = {
      reward_money_start = 1,
      reward_money = 1,
      payout_increase = 1,
      ranks_played = {}
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(G.GAME.current_round.RD_lotteryticket[1], 'ranks'),
        localize(G.GAME.current_round.RD_lotteryticket[2], 'ranks'),
        localize(G.GAME.current_round.RD_lotteryticket[3], 'ranks'),
        localize(G.GAME.current_round.RD_lotteryticket[4], 'ranks'),
        localize(G.GAME.current_round.RD_lotteryticket[5], 'ranks'),
        card.ability.extra.reward_money,
        card.ability.extra.payout_increase
      }
    }
  end,
  
  update = function(self, card, dt)
    if card.ability then
      card.ability.lottery_string = generate_lottery_string(card)
    end
  end,
  
  calculate = function(self, card, context)
    --clear on round start
    if context.first_hand_drawn then
      card.ability.extra.ranks_played = {}
    end
    
    --check if rank is special and has been played yet.
    if context.individual and context.cardarea == G.play and not context.other_card.debuff and not SMODS.has_no_rank(context.other_card) then
      if list_contains(G.GAME.current_round.RD_lotteryticket, context.other_card.base.value) then
        if not list_contains(card.ability.extra.ranks_played, context.other_card.base.value) then
          card.ability.extra.ranks_played[#card.ability.extra.ranks_played + 1] = context.other_card.base.value
          return {
            func = function()
              ease_dollars(card.ability.extra.reward_money)
              card.ability.extra.reward_money = card.ability.extra.reward_money + card.ability.extra.payout_increase
            end,
            message = localize('$') .. card.ability.extra.reward_money,
            colour = G.C.MONEY
          }
        end
      end
    end
    
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      if card.ability.extra.reward_money > card.ability.extra.reward_money_start then
        card.ability.extra.reward_money = card.ability.extra.reward_money_start
        card.ability.extra.ranks_played = {}
        return {
          message = localize('k_reset'),
          colour = G.C.RED
        }
      end
    end
  end
}

--this function updates the listed ranks every round.
function reset_game_globals_lotteryticket()  
  --add ranks from cards in deck to pool for picking, ranks can be added multiple times, so more common ranks get chosen more often
  local ranks_in_deck = {}
  for i = 1, #G.playing_cards do
		if not SMODS.has_no_rank(G.playing_cards[i]) then
			ranks_in_deck[#ranks_in_deck + 1] = G.playing_cards[i].base.id --numbers from 14 to 2, converting to proper ranks later.
		end
	end
  
  --pick ranks five times, removing ranks already chosen.
  local picked_ranks = {}
  local unchosen_ranks = { 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 } --second list of all unchosen options, only used if first list is empty
  for i = 1, #G.GAME.current_round.RD_lotteryticket do
    if ranks_in_deck[1] then
      picked_ranks[i] = pseudorandom_element(ranks_in_deck, pseudoseed('Lottery' .. G.GAME.round_resets.ante))
      remove_by_value(ranks_in_deck, picked_ranks[i])
      remove_by_value(unchosen_ranks, picked_ranks[i])
    else --If no possible ranks left in deck, pick from all unchosen ranks.
      picked_ranks[i] = pseudorandom_element(unchosen_ranks, pseudoseed('Lottery' .. G.GAME.round_resets.ante))
      remove_by_value(unchosen_ranks, picked_ranks[i])
    end
  end
  unchosen_ranks = nil
  
  --order the ranks chosen from ace to 2
  table.sort(picked_ranks, function(a,b) return a > b end)
  
  --now convert our ids to the ranks and set them as values.
  for i = 1, #G.GAME.current_round.RD_lotteryticket do
    if picked_ranks[i] <= 10 then
      G.GAME.current_round.RD_lotteryticket[i] = tostring(picked_ranks[i])
    elseif picked_ranks[i] == 11 then
      G.GAME.current_round.RD_lotteryticket[i] = 'Jack'
    elseif picked_ranks[i] == 12 then
      G.GAME.current_round.RD_lotteryticket[i] = 'Queen'
    elseif picked_ranks[i] == 13 then
      G.GAME.current_round.RD_lotteryticket[i] = 'King'
    elseif picked_ranks[i] == 14 then --do you miss switch statements yet?
      G.GAME.current_round.RD_lotteryticket[i] = 'Ace'
    end
  end
  picked_ranks = nil
end

function generate_lottery_string(card)
  local string = ""
  for i = 1, #G.GAME.current_round.RD_lotteryticket do
    if not list_contains(card.ability.extra.ranks_played, G.GAME.current_round.RD_lotteryticket[i]) then
      local sub = string.sub(G.GAME.current_round.RD_lotteryticket[i], 1, 1)
      if sub ~= "1" then
        string = string .. sub
      else
        string = string .. "10"
      end
      
      if i ~= #G.GAME.current_round.RD_lotteryticket then
        string = string  .. " "
      end
    end
  end
  
  if string == "" then
    string = localize('rainydays_full_clear')
  end
  
  return string
end

--here we draw our lottery ticket ranks onto our card. It's far from perfect, but it's the best I can manage. 
--issues: text hovers over editions, text wobbles a bit, text moves as you move the joker around the screen (sometimes outside the box).
--if you have any how to solve one or more of these issues, your help is most welcome on either github or discord.
SMODS.DrawStep {
  key = 'lotteryticket_text',
  order = 21,
  conditions = { vortex = false, facing = 'front' },
  func = function(self, layer)
    if self.ability and self.ability.lottery_string and self.children.center then
      --drawing the string
      prep_draw(self.children.center, 0.015)
      if self.edition and self.edition.negative then
        love.graphics.setColor(1 - 79 / 255, 1 - 99 / 255, 1 - 103 / 255, 1) --not the right color, but it looks cool
      else
        love.graphics.setColor(79 / 255, 99 / 255, 103 / 255, 1)
      end
      love.graphics.print(self.ability.lottery_string, -40, -10, 0)
      love.graphics.pop()
    end
  end
}