--- STEAMODDED HEADER
--- MOD_NAME: Virtues
--- MOD_ID: Virtues
--- MOD_AUTHOR: [someone23832, TiltedHat]
--- MOD_DESCRIPTION: Adds virtuous Jokers.
--- LOADER_VERSION_GEQ: 1.0.0
--- BADGE_COLOR: c7638f
--- PREFIX: sins
----------------------------------------------
------------MOD CODE -------------------------

-- put this helper somewhere near the top of Virtues.lua
local STAGGER = 0.8                 -- seconds between pop-ups

local function get_delay(card)
  -- on the first call each round card._stagger_i is nil → we treat it as 0
  card._stagger_i = (card._stagger_i or 0) + 1
  return (card._stagger_i - 1) * STAGGER
end

local Sounds = 2
if Sounds == 1 then
  SMODS.Sound{key = "Lust", path = "Lust1.ogg"}
  SMODS.Sound{key = "Greed",path = "Greed1.ogg"}
  SMODS.Sound{key = "Gluttony",path = "Gluttony1.ogg"}
  SMODS.Sound{key = "Wrath",path = "Wrath1.ogg"}
else
  SMODS.Sound{key = "Lust",path = "Lust1.ogg"}
  SMODS.Sound{key = "Greed",path = "Greed2.ogg"}
  SMODS.Sound{key = "Gluttony",path = "Gluttony2.ogg"}
  SMODS.Sound{key = "Wrath",path = "Wrath1.ogg"}
end

SMODS.Atlas{
  key = "virtues",
  path = "Virtue.png",
  px = 71,
  py = 95
}

SMODS.Joker{
  key = 'obedience',
  loc_txt = {
    name = 'Obedience',
    text = {
			{"{C:chips}+#2#{} Chips"},
      {"Increases by {C:chips}+#1#{} Chips",
      "for each {C:spades}♠Spade{} held",
      "in hand at end of round"},
      {"{C:red}Destroyed{} if a",
      "{C:spades}♠Spade{} is scored"},
    }
  },
  config = {extra = {chips_add = 10, chips = 0, broken = false}},
  no_pool_flag = "obedience_rebelled",
  rarity = 2,
  atlas = 'virtues',
  pos = {x = 0, y = 0},
  cost = 6,
  perishable_compat = false,
  eternal_compat = false,
  discovered = false,
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.chips_add, center.ability.extra.chips}}
  end,

  calculate = function(self, card, context)
    if context.setting_blind then
      card._stagger_i = 0
    end

    -- Upgrades the joker if Spades are in hand at the end of the round.
    if context.end_of_round and context.cardarea == G.hand and context.card_effects == effects and not context.blueprint then
      if context.other_card:is_suit('Spades') then 
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_add
        G.E_MANAGER:add_event(Event({
          trigger   = 'after',
          delay     = get_delay(card),
          blockable = false,
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgrade", colour = G.C.CHIPS, instant = true})
            play_sound('chips2')
          return true; end}))
        if not G.GAME.virtue_values then
          G.GAME.virtue_values = {}
        end
        G.GAME.virtue_values.Obedience = card.ability.extra.chips
      end
    end
    
  -- Give Chips value.
    if context.cardarea == G.jokers and context.joker_main then
      if card.ability.extra.chips > 0 then
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}},
          chip_mod = card.ability.extra.chips
        }
      end
    end
    
    -- Check for Spades in played hand.
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local suit = ""
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit('Spades') then card.ability.extra.broken = true end
      end
    end
    
    -- Remove from deck and ideally from game upon playing a Spade.
    if context.cardarea == G.jokers and context.after and not context.blueprint then
      if card.ability.extra.broken then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('sins_Wrath')
            card.T.r = -0.2
            card:juice_up(0.6, 0.9)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                G.jokers:remove_card(self)
                card:remove()
                card = nil
              return true; end}))
          return true end}))
      G.GAME.pool_flags.obedience_rebelled = true
      
      -- Checks to see if all flags have been enabled, if so, spawns a custom joker.
      -- Also has the event to delete this card after the hand is played.
      if G.GAME.pool_flags.chastity_defiled == true and G.GAME.pool_flags.obedience_rebelled == true and G.GAME.pool_flags.suppression_indulged == true and G.GAME.pool_flags.restraint_released == true and not G.GAME.pool_flags.fallen == true then
        G.GAME.pool_flags.fallen = true
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                local card = create_card("Jokers", G.jokers, nil, nil, nil,nil,"j_sins_decadence")
                card:set_edition({negative = true})
                card:add_to_deck()
                G.jokers:emplace(card)
              return true; end}))
          return true end}))
      end
      return {
        message = 'Rebelled',
        delay = 1, 
        colour = G.C.SPADES
        }
      end
    end
  end
}



SMODS.Joker{
  key = 'chastity',
  loc_txt = {
    name = 'Chastity',
    text = {
			{"{C:white,X:mult}X#2#{} Mult"},
      {"Increases by {C:white,X:mult}X#1#{} Mult ",
      "for each {C:hearts}♥Heart{} held",
      "in hand at end of round"},
      {"{C:red}Destroyed{} if a",
      "{C:hearts}♥Heart{} is scored"},
    }
  },
  config = {extra = {Xmult_add = 0.1, Xmult = 1, broken = false}},
  no_pool_flag = "chastity_defiled",
  rarity = 2,
  atlas = 'virtues',
  pos = {x = 1, y = 0},
  cost = 6,
  perishable_compat = false,
  eternal_compat = false,
  discovered = false,
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult_add, center.ability.extra.Xmult}}
  end,
   calculate = function(self, card, context)
    if context.setting_blind then
      card._stagger_i = 0
    end
    -- Upgrades the joker if Hearts are in hand at the end of the round.
    if context.end_of_round and context.cardarea == G.hand and context.card_effects == effects and not context.blueprint then
      if context.other_card:is_suit('Hearts') then 
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_add
        
        G.E_MANAGER:add_event(Event({
          trigger   = 'after',
          delay     = get_delay(card),
          blockable = false,
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.MULT, instant = true})
            play_sound('chips2')
          return true; end}))
        if not G.GAME.virtue_values then
          G.GAME.virtue_values = {}
        end
        G.GAME.virtue_values.Chastity = card.ability.extra.Xmult
      end
    end
    
  -- Multiply value by multiplier value.
    if context.cardarea == G.jokers and context.joker_main then
      if card.ability.extra.Xmult > 1 then
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}},
          Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
    
    -- Check for Hearts in played hand.
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local suit = ""
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit('Hearts') then card.ability.extra.broken = true end
      end
    end
    
    -- Remove from deck and ideally from game upon playing a Heart.
    if context.cardarea == G.jokers and context.after and not context.blueprint then
      if card.ability.extra.broken then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('sins_Lust')
            card.T.r = -0.2
            card:juice_up(0.6, 0.9)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                G.jokers:remove_card(self)
                card:remove()
                card = nil
              return true; end}))
          return true end}))
      G.GAME.pool_flags.chastity_defiled = true
      
      -- Checks to see if all flags have been enabled, if so, spawns a custom joker.
      -- Also has the event to delete this card after the hand is played.
      if G.GAME.pool_flags.chastity_defiled == true and G.GAME.pool_flags.obedience_rebelled == true and G.GAME.pool_flags.suppression_indulged == true and G.GAME.pool_flags.restraint_released == true and not G.GAME.pool_flags.fallen == true then
        G.GAME.pool_flags.fallen = true
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                local card = create_card("Jokers", G.jokers, nil, nil, nil,nil,"j_sins_decadence")
                card:set_edition({negative = true})
                card:add_to_deck()
                G.jokers:emplace(card)
              return true; end}))
          return true end}))
      end
      return {
        message = 'Defiled',
        delay = 1, 
        colour = G.C.HEARTS
        }
      end
    end
  end
}



SMODS.Joker{
  key = 'suppression',
  loc_txt = {
    name = 'Suppression',
    text = {
      {"{C:mult}+#2#{} Mult"},
      {"Increases by {C:mult}+#1#{} Mult ",
      "for each {C:clubs}♣Club{} held",
      "in hand at end of round"},
      {"{C:red}Destroyed{} if a",
      "{C:clubs}♣Club{} is scored"},
    }
  },
  config = {extra = {mult_add = 2, mult = 0, broken = false}},
  no_pool_flag = "suppression_indulged",
  rarity = 2,
  atlas = 'virtues',
  pos = {x = 2, y = 0},
  cost = 6,
  perishable_compat = false,
  eternal_compat = false,
  discovered = false,
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.mult_add, center.ability.extra.mult}}
  end,
  calculate = function(self, card, context)
    if context.setting_blind then
      card._stagger_i = 0
    end
    
    -- Upgrades the joker if Clubs are in hand at the end of the round.
    if context.end_of_round and context.cardarea == G.hand and context.card_effects == effects and not context.blueprint then
      if context.other_card:is_suit('Clubs') then 
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
        
     G.E_MANAGER:add_event(Event({
          trigger   = 'after',
          delay     = get_delay(card),
          blockable = false,
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.MULT, instant = true})
            play_sound('chips2')
          return true; end}))
        if not G.GAME.virtue_values then
          G.GAME.virtue_values = {}
        end
        G.GAME.virtue_values.Suppression = card.ability.extra.mult
      end
    end
    
  -- Adds multiplier value.
    if context.cardarea == G.jokers and context.joker_main then
      if card.ability.extra.mult > 0 then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}},
          mult_mod = card.ability.extra.mult
        }
      end
    end
    
    -- Check for hearts in played hand.
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local suit = ""
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit('Clubs') then card.ability.extra.broken = true end
      end
    end
    
    -- Remove from deck and ideally from game upon playing a Club.
    if context.cardarea == G.jokers and context.after and not context.blueprint then
      if card.ability.extra.broken then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('sins_Gluttony')
            card.T.r = -0.2
            card:juice_up(0.6, 0.9)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                G.jokers:remove_card(self)
                card:remove()
                card = nil
              return true; end}))
          return true end}))
      G.GAME.pool_flags.suppression_indulged = true
      
      -- Checks to see if all flags have been enabled, if so, spawns a custom joker.
      -- Also has the event to delete this card after the hand is played.
      if G.GAME.pool_flags.chastity_defiled == true and G.GAME.pool_flags.obedience_rebelled == true and G.GAME.pool_flags.suppression_indulged == true and G.GAME.pool_flags.restraint_released == true and not G.GAME.pool_flags.fallen == true then
        G.GAME.pool_flags.fallen = true
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                local card = create_card("Jokers", G.jokers, nil, nil, nil,nil,"j_sins_decadence")
                card:set_edition({negative = true})
                card:add_to_deck()
                G.jokers:emplace(card)
              return true; end}))
          return true end}))
      end
      
      return {
        message = 'Indulged',
        delay = 1, 
        colour = G.C.CLUBS
        }
      end
    end
  end
}



SMODS.Joker{
  key = 'restraint',
  loc_txt = {
    name = 'Restraint',
    text = {
      {"{C:money}$#2#{} after each",
      "{C:attention}Boss Blind{}"},
      {"Increases by {C:money}$#1#{} for",
      "each {C:diamonds}♦Diamond{} held",
      "in hand at end of round"},
      {"{C:red}Destroyed{} if a",
      "{C:diamonds}♦Diamond{} is scored"},
    }
  },
  config = {extra = {money_add = 2, money = 0, broken = false}},
  no_pool_flag = "restraint_released",
  rarity = 2,
  atlas = 'virtues',
  pos = {x = 3, y = 0},
  cost = 6,
  perishable_compat = false,
  eternal_compat = false,
  discovered = false,
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.money_add, center.ability.extra.money}}
  end,
  calculate = function(self, card, context)
    if context.setting_blind then
      card._stagger_i = 0
    end
   
    -- Upgrades the joker if Diamonds are in hand at the end of the round.
    if context.end_of_round and context.cardarea == G.hand and context.card_effects == effects and not context.blueprint then
      if context.other_card:is_suit('Diamonds') then 
        card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_add
        
     G.E_MANAGER:add_event(Event({
          trigger   = 'after',
          delay     = get_delay(card),
          blockable = false,
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.GOLD, instant = true})
            play_sound('chips2')
          return true; end}))
        if not G.GAME.virtue_values then
          G.GAME.virtue_values = {}
        end
        G.GAME.virtue_values.Restraint = card.ability.extra.money
      end
    end
    
    -- Check for Diamonds in played hand.
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      local suit = ""
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit('Diamonds') then card.ability.extra.broken = true end
      end
    end
    
    -- Remove from deck and ideally from game upon playing a Diamond.
    if context.cardarea == G.jokers and context.after and not context.blueprint then
      if card.ability.extra.broken then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('sins_Greed')
            card.T.r = -0.2
            card:juice_up(0.6, 0.9)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                G.jokers:remove_card(self)
                card:remove()
                card = nil
              return true; end}))
          return true end}))
      G.GAME.pool_flags.restraint_released = true
      
      -- Checks to see if all flags have been enabled, if so, spawns a custom joker.
      -- Also has the event to delete this card after the hand is played.
      if G.GAME.pool_flags.chastity_defiled and G.GAME.pool_flags.obedience_rebelled and G.GAME.pool_flags.suppression_indulged and G.GAME.pool_flags.restraint_released and not G.GAME.pool_flags.fallen then
        G.GAME.pool_flags.fallen = true
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                local card = create_card("Jokers", G.jokers, nil, nil, nil,nil,"j_sins_decadence")
                card:set_edition({negative = true})
                card:add_to_deck()
                G.jokers:emplace(card)
              return true; end}))
          return true end}))
      end
      
      return {
        message = 'Released',
        timer = 5, 
        color = G.C.DIAMONDS
        }
      end
    end
  end,
  calc_dollar_bonus = function(self,card)
    if G.GAME.blind.boss then
      local bonus = card.ability.extra.money
      if bonus > 0 then return bonus end
    end
  end
}


SMODS.Joker{
  key = 'fallenobedience',
  loc_txt = {
    name = "Rebellion",
    text = {
      "{C:spades}Spades{} give {C:chips}+#2#{} Chips when scored",
      "Gains {C:chips}+#1#{} Chips for each {C:spades}Spade",
      "held in hand at {C:attention}end of round{}"
    }
  },
  config = {extra = {chips_add = 4, chips = 20}},
  yes_pool_flag = "fallen",
  rarity = 2,
  atlas = 'virtues',
  pos = {x = 0, y = 1},
  cost = 10,
  discovered = false,
  perishable_compat = false,
  eternal_compat = false,
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.chips_add, center.ability.extra.chips}}
  end,
  --Copies values from virtues that were broken if possible.
  add_to_deck = function(self, card, from_debuff)
    if not G.GAME.virtue_values then
      G.GAME.virtue_values = {}
    end
    card.ability.extra.chips = G.GAME.virtue_values.Obedience or 0
  end,
  set_card_type_badge = function(self, card, badges)
    badges[#badges+1] = create_badge("Fallen", G.C.PURPLE, G.C.WHITE)
  end,
  calculate = function(self, card, context)
    if context.setting_blind then
      card._stagger_i = 0
    end
   
    -- Upgrades the joker if Spades are in hand at the end of the round.
    if context.end_of_round and context.cardarea == G.hand and context.card_effects == effects and not context.blueprint then
      if context.other_card:is_suit('Spades') then 
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_add
     G.E_MANAGER:add_event(Event({
          trigger   = 'after',
          delay     = get_delay(card),
          blockable = false,
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.CHIPS, instant = true})
            play_sound('chips2')
          return true; end}))
      end
    end
    
    -- Triggers on Spades in scored hand.
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit('Spades') then
          return {
            chips = card.ability.extra.chips,
            card = context.other_card
          }
        end
    end
    
  end
}



SMODS.Joker{
  key = 'fallenchastity',
  loc_txt = {
    name = 'Defilement',
    text = {
      "{C:hearts}Hearts{} give {X:mult,C:white}X#2#{} Mult when scored",
      "Gains {X:mult,C:white}X#1#{} Mult for each {C:hearts}Heart",
      "held in hand at {C:attention}end of round{}"
    }
  },
  config = {extra = {Xmult_add = 0.025, Xmult = 1.25}},
  yes_pool_flag = "fallen",
  rarity = 2,
  atlas = 'virtues',
  pos = {x = 1, y = 1},
  cost = 10,
  discovered = false,
  perishable_compat = false,
  eternal_compat = false,
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult_add, center.ability.extra.Xmult}}
  end,
  --Copies values from virtues that were broken if possible.
  add_to_deck = function(self, card, from_debuff)
    if not G.GAME.virtue_values then
      G.GAME.virtue_values = {}
    end
    card.ability.extra.Xmult = G.GAME.virtue_values.Chastity or 1
  end,
  set_card_type_badge = function(self, card, badges)
    badges[#badges+1] = create_badge("Fallen", G.C.PURPLE, G.C.WHITE)
  end,
  calculate = function(self, card, context)
    if context.setting_blind then
      card._stagger_i = 0
    end
    
    -- Upgrades the joker if Hearts are in hand at the end of the round.
    if context.end_of_round and context.cardarea == G.hand and context.card_effects == effects and not context.blueprint then
      if context.other_card:is_suit('Hearts') then 
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_add
        
     G.E_MANAGER:add_event(Event({
          trigger   = 'after',
          delay     = get_delay(card),
          blockable = false,
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.MULT, instant = true})
            play_sound('chips2')
          return true; end}))
      end
    end
    
    -- Triggers on Hearts in scored hand.
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit('Hearts') then
          return {
            x_mult = card.ability.extra.Xmult,
            card = context.other_card
          }
        end
    end
    
  end
}



SMODS.Joker{
  key = 'fallensuppression',
  loc_txt = {
    name = "Indulgement",
    text = {
      "{C:clubs}Clubs{} give {C:mult}+#2#{} Mult when scored",
      "Gains {C:mult}+#1#{} Mult for each {C:clubs}Club",
      "held in hand at {C:attention}end of round"
    }
  },
  config = {extra = {mult_add = 1, mult = 0}},
  yes_pool_flag = "fallen",
  rarity = 2,
  atlas = 'virtues',
  pos = {x = 2, y = 1},
  cost = 10,
  discovered = false,
  perishable_compat = false,
  eternal_compat = false,
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.mult_add, center.ability.extra.mult}}
  end,
  --Copies values from virtues that were broken if possible.
  add_to_deck = function(self, card, from_debuff)
    if not G.GAME.virtue_values then
      G.GAME.virtue_values = {}
    end
    card.ability.extra.mult = G.GAME.virtue_values.Suppression or 0
  end,
  set_card_type_badge = function(self, card, badges)
    badges[#badges+1] = create_badge("Fallen", G.C.PURPLE, G.C.WHITE)
  end,
  calculate = function(self, card, context)
    if context.setting_blind then
      card._stagger_i = 0
    end
    
    -- Upgrades the joker if Clubs are in hand at the end of the round.
    if context.end_of_round and context.cardarea == G.hand and context.card_effects == effects and not context.blueprint then
      if context.other_card:is_suit('Clubs') then 
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
        
     G.E_MANAGER:add_event(Event({
          trigger   = 'after',
          delay     = get_delay(card),
          blockable = false,
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.MULT, instant = true})
            play_sound('chips2')
          return true; end}))
      end
    end
    
    -- Triggers on Clubs in scored hand.
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit('Clubs') then
          return {
            mult = card.ability.extra.mult,
            card = context.other_card
          }
        end
    end
    
  end
}



SMODS.Joker{
  key = 'fallensrestraint',
  loc_txt = {
    name = "Uncontrollable",
    text = {
      "{s:0.9,C:diamonds}Diamonds{s:0.9} give {s:0.9,C:mult}+#5#{s:0.9} Mult and {s:0.9,C:chips}+#6#{s:0.9} Chips when scored",
      "{s:0.9}Gains {s:0.9,C:chips}+#1#{s:0.9} Chips and {s:0.9,C:mult}+#2#{s:0.9} Mult for every {s:0.9,C:money}$#3#{s:0.9} you have",
      "{s:0.9}Each held {s:0.9,C:diamonds}Diamond{s:0.9} gives {s:0.9,C:money}$#4#{s:0.9} at {s:0.9,C:attention}end of round"
    }
  },
  config = {extra = {money = 5, chips = 8, mult = 2, moneygain = 1, moneyend = 0}},
  yes_pool_flag = "fallen",
  rarity = 2,
  atlas = 'virtues',
  pos = {x = 3, y = 1},
  cost = 10,
  discovered = false,
  perishable_compat = false,
  eternal_compat = false,
  loc_vars = function(self, info_queue, center)
    local times = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/center.ability.extra.money) or 1
    return {vars = {center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.money, center.ability.extra.moneygain, center.ability.extra.chips*times, center.ability.extra.mult*times}}
  end,
  --Copies values from virtues that were broken if possible.
  add_to_deck = function(self, card, from_debuff)
    if not G.GAME.virtue_values then
      G.GAME.virtue_values = {}
    end
    card.ability.extra.moneygain = G.GAME.virtue_values.Restraint or 1
  end,
  set_card_type_badge = function(self, card, badges)
    badges[#badges+1] = create_badge("Fallen", G.C.PURPLE, G.C.WHITE)
  end,
  calculate = function(self, card, context)
    if context.setting_blind then
      card._stagger_i = 0
    end
    
    -- Gives Money if Diamonds are in hand at the end of the round.
    if context.end_of_round and context.cardarea == G.hand and context.card_effects == effects and not context.blueprint then
      if context.other_card:is_suit('Diamonds') then 
        card.ability.extra.moneyend = card.ability.extra.moneyend + card.ability.extra.moneygain
        
     G.E_MANAGER:add_event(Event({
          trigger   = 'after',
          delay     = get_delay(card),
          blockable = false,
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.GOLD, instant = true})
            play_sound('chips2')
          return true; end}))
      end
    end
    
    -- Triggers on Diamonds in scored hand.
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit('Diamonds') then
        local times = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.money)
        if times > 0 then
          return {
            chips = card.ability.extra.chips * times,
            mult = card.ability.extra.mult * times,
            card = context.other_card
          }
        end
      end
    end
    
  end,
  --Giving money part 2.
  calc_dollar_bonus = function(self,card)
    local bonus = card.ability.extra.moneyend
    card.ability.extra.moneyend = 0
    if bonus > 0 then return bonus end
    end
}



SMODS.Joker{
  key = 'decadence',
  loc_txt = {
    name = '{C:dark_edition}Decadence',
    text = {
      --"{s:0.8,C:dark_edition}Naturally Negative",
      "{C:attention}+1{} Joker Slot",
      "{C:attention}+#1#{} Hand Size",
      "Retriggers {V:1}#2#",
      "{C:inactive}Changes {C:attention}suits {C:inactive}at end of round"
    },
    unlock = {"I wonder what that", "laughter is about..."}
  },
  config = {extra = {h_size = 2, suit_rep = 1, cur_suit = "Spades", suit_num = 1,
    suit_order = {"Spades","Hearts","Clubs","Diamonds"}
    }},
  -- Can only spawn through special means.
  yes_pool_flag = "fallen_impossible",
  rarity = 3,
  atlas = 'virtues',
  pos = {x = 0, y = 2},
  cost = 20,
  perishable_compat = false,
  eternal_compat = false,
  unlocked = false,
  discovered = false,
  check_for_unlock = function(self, args)
    if args.type == 'modify_jokers' and G.jokers then
      for k, v in pairs(G.jokers.cards) do
        if v.ability.name == "j_sins_decadence" then
          unlock_card(self)
        end
      end
    end
  end,
  loc_vars = function(self, info_queue, center)
    return {vars = {center.ability.extra.h_size, center.ability.extra.cur_suit, colours = {G.C.SUITS[center.ability.extra.cur_suit]}}}
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 1
  -- Give starting suit.
    if not from_debuff then
      local suits = card.ability.extra.suit_order
      pseudoshuffle(suits,pseudoseed('decadence'))
      card.ability.extra.suit_order = suits
      card.ability.extra.cur_suit = card.ability.extra.suit_order[4]
      
       G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = 'The Fallen have ben released.',
                        scale = 0.7, 
                        hold = 8*G.SETTINGS.GAMESPEED,
                        major = G.play,
                        backdrop_colour = G.C.CLEAR,
                        align = 'cm',
                        offset = {x = 0, y = -3.5},
                        silent = true
                    })
                    return true 
                    end 
                }))
    end
  end,
  update = function(self, card, card_table, other_card)
    local suitpos = {y=2}
    if not card.config.center.unlocked then
      suitpos = {x = 8, y = 9}
    elseif card.ability.extra.cur_suit == "Spades" then
      suitpos.x = 0
    elseif card.ability.extra.cur_suit == "Hearts" then
      suitpos.x = 1
    elseif card.ability.extra.cur_suit == "Clubs" then
      suitpos.x = 2
    elseif card.ability.extra.cur_suit == "Diamonds" then
      suitpos.x = 3
    end
    card.children.center:set_sprite_pos(suitpos)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
  end,
 calculate = function(self, card, context)
--    Applies Repetition
    if context.cardarea == G.play and context.repetition and context.repetition_only ~= true then
      local suit_check = card.ability.extra.cur_suit
      if context.other_card:is_suit(suit_check) then
        return {
          message = 'Sinful!',
          repetitions = card.ability.extra.suit_rep,
          card = context.other_card
        }
      end
    end

--    Changes Suit
    if context.end_of_round and context.game_over == false and not context.blueprint then
      card:flip()
     G.E_MANAGER:add_event(Event({
          func = function()
            card:juice_up(0.7)
            card_eval_status_text(card,'extra',nil, nil, nil,{message = "Changing...", colour = G.C.PURPLE, instant = true})
            play_sound('cardFan2')
          return true; end}))
      card.ability.extra.cur_suit = card.ability.extra.suit_order[card.ability.extra.suit_num]
      card.ability.extra.suit_num = card.ability.extra.suit_num+1
      if card.ability.extra.suit_num == 5 then card.ability.extra.suit_num = 1 end
      --card:flip()
      
    end
  end,
  set_card_type_badge = function(self, card, badges)
    badges[#badges+1] = create_badge("Fallen", G.C.PURPLE, G.C.WHITE)
  end
}

----------------------------------------------
------------MOD CODE END----------------------