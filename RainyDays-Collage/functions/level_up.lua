--override of the original function, changes pretty much everything, so not worth it to use lovely injects

function level_up_hand(card, hand, instant, level_up, chip_upgrade, mult_upgrade, money_upgrade)
  level_up_table(card, { hand }, nil, instant, level_up, chip_upgrade, mult_upgrade, money_upgrade)
end

function level_up_table_tailends(card, table_hands, description, instant, level_up, chip_upgrade, mult_upgrade, money_upgrade)
  --set init visual values
  local desc
  if #table_hands == 1 then
    local hand = table_hands[1]
    desc = { handname = localize(hand, 'poker_hands'), level = G.GAME.hands[hand].level, chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult }
  else
    desc = { handname = description, level = '', chips = '...', mult = '...' }
  end
  update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 }, desc)
  
  --upgrade
  level_up_table(card, table_hands, description, instant, level_up, chip_upgrade, mult_upgrade, money_upgrade)
  
  --set visual values after
  local hand_info
  if G.play and G.play.cards and #G.play.cards > 0 then
    local hand = (G.FUNCS.get_poker_hand_info(G.play.cards))
    hand_info = { handname = localize(hand, 'poker_hands'), level = G.GAME.hands[hand].level, chips = hand_chips, mult = mult }
  elseif G.hand and G.hand.highlighted and #G.hand.highlighted > 0 then
    local hand = (G.FUNCS.get_poker_hand_info(G.hand.highlighted))
    hand_info = { handname = localize(hand, 'poker_hands'), level = G.GAME.hands[hand].level, chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult }
  else
    hand_info = { handname = "", level = "", chips = 0, mult = 0 }
  end
   update_hand_text({ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 }, hand_info)
end
  
--new function that allows upgrading multiple hands at once
function level_up_table(card, table_hands, description, instant, level_up, chip_upgrade, mult_upgrade, money_upgrade, repetitions)
  --create local tables
  local hands_upgraded = repetitions and repetitions[1].hands or table_hands
  
  --set vars
  local play_hand, play_chips, play_mult
  if not repetitions then
    --special case: level up hands while and hand is being played
    if G.play and G.play.cards and #G.play.cards > 0 then
      play_hand = (G.FUNCS.get_poker_hand_info(G.play.cards))
      play_chips = G.GAME.hands[play_hand].chips
      play_mult = G.GAME.hands[play_hand].mult
    end
    level_up = level_up or 1
    chip_upgrade = chip_upgrade or 0
    mult_upgrade = mult_upgrade or 0
    money_upgrade = money_upgrade or 0

  --set start position for repetitions
  elseif not instant then
    card_eval_status_text(repetitions[1].source, 'jokers', nil, nil, nil, { message = localize('k_again_ex') })
    
    local desc
    local hand_description = #hands_upgraded == 1 and localize(hands_upgraded[1], 'poker_hands') or (repetitions and repetitions[1].description or description)
    if #hands_upgraded == 1 then
      local hand = hands_upgraded[1]
      desc = { handname = hand_description, level = G.GAME.hands[hand].level, chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult }
    else
      desc = { handname = hand_description, level = '', chips = '...', mult = '...' }
    end
    update_hand_text({ delay = 0 }, desc)
  end
  
  --jokers trigger with upgrade additions
  local joker_bonus = {}
  if G.jokers and G.jokers.cards then
    local context_sent = {
      hand_upgrade_additions = true,
      card = card,
      hands_upgraded = hands_upgraded,
      level_up = level_up,
      chip_upgrade = chip_upgrade,
      mult_upgrade = mult_upgrade,
      money_upgrade = money_upgrade
    }
    for i = 1, #G.jokers.cards do
      local eval = eval_card(G.jokers.cards[i], context_sent)
      if next(eval) then
        joker_bonus[#joker_bonus + 1] = { 
          source = G.jokers.cards[i],
          hands = eval.jokers.hands or nil,
          level_bonus = eval.jokers.level_bonus or nil,
          chips_bonus = eval.jokers.chips_bonus or nil,
          mult_bonus = eval.jokers.mult_bonus or nil,
          money_bonus = eval.jokers.money_bonus or nil
        }
      end
    end
  end
  
  --inventory of bonuses for all hands
  local juicing_jokers = { level_bonus = {}, chips_bonus = {}, mult_bonus = {}, money_bonus = {} }
  local joker_bonus_total = { level_bonus = 0, chips_bonus = 0, mult_bonus = 0, money_bonus = 0 }  
  joker_bonus_total.level_bonus = sum_joker_bonus(joker_bonus, 'level_bonus', hands_upgraded, juicing_jokers)
  joker_bonus_total.chips_bonus = sum_joker_bonus(joker_bonus, 'chips_bonus', hands_upgraded, juicing_jokers)
  joker_bonus_total.mult_bonus = sum_joker_bonus(joker_bonus, 'mult_bonus', hands_upgraded, juicing_jokers)
  joker_bonus_total.money_bonus = sum_joker_bonus(joker_bonus, 'money_bonus', hands_upgraded, juicing_jokers)
    
  --upgrade all hands
  local individual_hand_money_change = false
  for i = 1, #hands_upgraded do
    
    --apply bonuses for individual hands
    local joker_individual_bonus_total = { level_bonus = 0, chips_bonus = 0, mult_bonus = 0, money_bonus = 0 }
    joker_individual_bonus_total.level_bonus = sum_joker_bonus_individual(joker_bonus, 'level_bonus', hands_upgraded[i], juicing_jokers)
    joker_individual_bonus_total.chips_bonus = sum_joker_bonus_individual(joker_bonus, 'chips_bonus', hands_upgraded[i], juicing_jokers)
    joker_individual_bonus_total.mult_bonus = sum_joker_bonus_individual(joker_bonus, 'mult_bonus', hands_upgraded[i], juicing_jokers)
    joker_individual_bonus_total.money_bonus = sum_joker_bonus_individual(joker_bonus, 'money_bonus', hands_upgraded[i], juicing_jokers)

    if joker_individual_bonus_total.money_bonus ~= 0 then
      individual_hand_money_change = true
    end
    
    local hand = G.GAME.hands[hands_upgraded[i]]
    
    --apply bonus chips and mult
    hand.chips_bonus = (hand.chips_bonus or 0) + chip_upgrade + joker_bonus_total.chips_bonus + joker_individual_bonus_total.chips_bonus
    hand.mult_bonus = (hand.mult_bonus or 0) + mult_upgrade + joker_bonus_total.mult_bonus + joker_individual_bonus_total.mult_bonus
    
    --apply levelup and bonus
    hand.level = math.max(1, hand.level + level_up + joker_bonus_total.level_bonus + joker_individual_bonus_total.level_bonus)
    hand.chips = hand.s_chips + hand.chips_bonus + hand.l_chips * (hand.level - 1)
    hand.mult = hand.s_mult + hand.mult_bonus + hand.l_mult * (hand.level - 1)
    hand.money = (hand.money or 0) + money_upgrade + joker_bonus_total.money_bonus + joker_individual_bonus_total.money_bonus
    
    --alter game info page if needed
    if hand.money ~= 0 then 
      G.GAME.money_bonus_given = true
    end
    
    --prevent negative scores
    if to_big(hand.chips) < to_big(0) then
      hand.chips_bonus = hand.chips_bonus - hand.chips
      hand.chips = 0
    end
    if to_big(hand.mult) < to_big(1) then
      hand.mult_bonus = hand.mult_bonus - hand.mult + 1
      hand.mult = 1
    end
  end

  --animation
  if not instant then    
    --description vars II: post upgrade
    local rep_card = repetitions and repetitions[1].source or nil
    local desc_level_up, desc_chips_up, desc_mult_up
    if #hands_upgraded ~= 1 then
      local level_change =  level_up + joker_bonus_total.level_bonus
      if level_change == 0 then
        local chips_change = chip_upgrade + joker_bonus_total.chips_bonus
        local mult_change = mult_upgrade + joker_bonus_total.mult_bonus
        desc_chips_up = chips_change ~= 0 and (chips_change > 0 and '+' .. chips_change or '-' .. math.abs(chips_change)) or nil
        desc_mult_up = mult_change ~= 0 and (mult_change > 0 and '+' .. mult_change or '-' .. math.abs(mult_change)) or nil
      else
        desc_level_up = level_change > 0 and '+' .. level_change or '-' .. math.abs(level_change)
        desc_chips_up = level_change > 0 and '+' or '-'
        desc_mult_up = level_change > 0 and '+' or '-'
      end
    else
      desc_level_up = G.GAME.hands[hands_upgraded[1]].level
      desc_chips_up = G.GAME.hands[hands_upgraded[1]].chips
      desc_mult_up = G.GAME.hands[hands_upgraded[1]].mult
    end
    
    --update values visual
    --mult
    G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function()
      return shakeit(card, rep_card, juicing_jokers.mult_bonus, true) end 
    }))
    update_hand_text({ delay = 0 }, { mult = desc_mult_up, StatusText = true })
    
    --chips
    G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.9, func = function()
      return shakeit(card, rep_card, juicing_jokers.chips_bonus, true) end
    }))
    update_hand_text({ delay = 0 }, { chips = desc_chips_up, StatusText = true })
    
    --money
    local money_change = money_upgrade + joker_bonus_total.money_bonus
    if money_change ~= 0 or individual_hand_money_change then
      local desc_money_up = money_change ~= 0 and ((money_change > 0 and '+' or '-') .. localize('$') .. math.abs(money_change)) or localize('$')
      G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.9, func = function()
        return shakeit_money(desc_money_up, card, rep_card, juicing_jokers.money_bonus, true) end 
      }))
    end
    
    --level
    G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.9, func = function()
      return shakeit(card, rep_card, juicing_jokers.level_bonus, nil) end 
    }))
    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = desc_level_up })
    
    delay(1.3)
  end
  
  --check if any jokers if rewards as result of a hand upgrade
  if G.jokers and G.jokers.cards then
    local context_sent = {
      hand_upgrade_response = true,
      card = card,
      hands_upgraded = hands_upgraded,
      level_up = level_up,
      chip_upgrade = chip_upgrade,
      mult_upgrade = mult_upgrade,
      money_upgrade = money_upgrade
    }
    for i = 1, #G.jokers.cards do
      eval_card(G.jokers.cards[i], context_sent)
    end
  end
  
  --check amount of repetitions if no repetitions table exists
  if not repetitions then
    repetitions = {}
    if G.jokers and G.jokers.cards then
      local context_sent = {
        hand_upgrade_repetitions = true,
        card = card,
        hands_upgraded = hands_upgraded,
        level_up = level_up,
        chip_upgrade = chip_upgrade,
        mult_upgrade = mult_upgrade,
        money_upgrade = money_upgrade
      }
      for i = 1, #G.jokers.cards do
        local eval = eval_card(G.jokers.cards[i], context_sent)
        if next(eval) then
          repetitions[#repetitions + 1] = {
            source = G.jokers.cards[i],
            count = eval.jokers.repetitions,
            hands = eval.jokers.hands or nil,
            hands_description = eval.jokers.hands_description or nil,
            func = eval.jokers.func
          }
        end
      end
    end
  else
    --after all repetition of joker are done run stored function if existing
    if repetitions[1].func and repetitions[1].count == 1 then
      repetitions[1].func()
    end
  
    --remove one repetition
    if #repetitions > 0 then
      if repetitions[1].count > 1 then
        repetitions[1].count = repetitions[1].count - 1
      else
        table.remove(repetitions, 1)
      end
    end
  end

  --perform repetitions
  if #repetitions > 0 then
    level_up_table(card, table_hands, description, instant, level_up, chip_upgrade, mult_upgrade, money_upgrade, repetitions)
  elseif not instant then
    --achievement check
    if level_up > 0 then
      for i = 1, #hands_upgraded do
      local hand = G.GAME.hands[hands_upgraded[i]]
        G.E_MANAGER:add_event(Event({
          trigger = 'immediate',
          func = function()
            check_for_unlock{ type = 'upgrade_hand', hand = hands_upgraded[i], level = G.GAME.hands[hands_upgraded[i]].level } 
            return true 
          end
        }))
      end
    end
  end
  
  --special case: hand is being played
  if G.play and G.play.cards and #G.play.cards > 0 then
    hand_chips = hand_chips + G.GAME.hands[play_hand].chips - play_chips
    mult = mult + G.GAME.hands[play_hand].mult - play_mult
  end
end

--payout of the money bonus
local old_func_evaluate = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(e)
  local poker_hand = G.FUNCS.get_poker_hand_info(G.play.cards)
  if G.GAME.hands[poker_hand] and G.GAME.hands[poker_hand].money and G.GAME.hands[poker_hand].money ~= 0 then
    ease_dollars(G.GAME.hands[poker_hand].money)
    card_eval_status_text(G.play, 'extra', nil, nil, nil, {
      message = localize('rainydays_money_bonus') .. ': ' .. localize('$') .. G.GAME.hands[poker_hand].money,
      colour = G.C.MONEY,
      no_juice = true
    })
    delay(0.6)
  end
  return old_func_evaluate(e)
end

function sum_joker_bonus(joker_bonus, bonus_type, hands_upgraded, juice_jokers)
  local sum = 0
  for i = 1, #joker_bonus do
    if joker_bonus[i][bonus_type] and (not joker_bonus[i].hands or table_contains_all_values_of_other(joker_bonus[i].hands, hands_upgraded)) then
      joker_bonus[i].hands = nil
      sum = sum + joker_bonus[i][bonus_type]
      if not list_contains(juice_jokers[bonus_type], joker_bonus[i].source) then 
        juice_jokers[bonus_type][#juice_jokers[bonus_type] + 1] = joker_bonus[i].source
      end
    end
  end
  return sum
end

function sum_joker_bonus_individual(joker_bonus, bonus_type, hand, juice_jokers)
  local sum = 0
  for i = 1, #joker_bonus do
    if joker_bonus[i].hands and list_contains(joker_bonus[i].hands, hand) then
      if joker_bonus[i][bonus_type] and joker_bonus[i][bonus_type] ~= 0 then
        sum = sum + joker_bonus[i][bonus_type]
        if not list_contains(juice_jokers[bonus_type], joker_bonus[i].source) then 
          juice_jokers[bonus_type][#juice_jokers[bonus_type] + 1] = joker_bonus[i].source
        end
      end
    end
  end
  return sum
end

function shakeit(card, rep_card, juicing_jokers, stat_type, tarot_pulse)
  play_sound('tarot1')
  if card then
    card:juice_up(0.8, 0.5)
  end
  if rep_card then
    rep_card:juice_up(0.8, 0.5)
  end
  for i = 1, #juicing_jokers do
    if juicing_jokers[i] then
      juicing_jokers[i]:juice_up(0.8, 0.5)
    end
  end
  G.TAROT_INTERRUPT_PULSE = tarot_pulse
  return true
end

function shakeit_money(money_text, card, rep_card, juicing_jokers, stat_type, tarot_pulse)
  attention_text({ 
    text = money_text, 
    scale = 0.8, 
    hold = 1, 
    cover = G.hand_text_area.handname.parent, 
    cover_colour = G.C.MONEY, 
    emboss = 0.05, 
    align = 'cm', 
    cover_align = 'cm'
  })
  return shakeit(card, rep_card, juicing_jokers, stat_type, tarot_pulse)
end