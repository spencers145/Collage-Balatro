--see also lua injects

local game_init_game_object_ref = Game.init_game_object
function Game:init_game_object()
  local ret = game_init_game_object_ref(self)
  
  --hand vars
  for _, value in ipairs(G.handlist) do
    ret.hands[value].rd_discarded = 0
    ret.hands[value].rd_discarded_this_round = 0
    ret.hands[value].rd_discarded_this_ante = 0
    ret.hands[value].rd_secret = (not ret.hands[value].visible or type(ret.hands[value].visible) == 'function')
  end
  
  --ranks played
  ret.rd_ranks_played_this_round = {}
  ret.rd_ranks_scored_this_round = {}
  
  --consumeable use
  ret.rd_consumeable_usage_round = 0
  ret.rd_consumeable_usage_ante = 0
  
  --jokers acquired
  ret.rd_jokers_uniquelist = {}
  ret.rd_jokers_uniquelist_count = 0
  
  --misc
  ret.rd_cards_drawn_this_round = 0
  ret.rd_delirium_active = 0
  ret.rd_suit_count = 0
  for key in pairs(SMODS.Suits) do
    ret.rd_suit_count = ret.rd_suit_count + 1
  end
  
  return ret
end

local discard_cards_from_highlighted_ref = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
  local highlighted_count = math.min(#G.hand.highlighted, G.discard.config.card_limit - #G.play.cards)
  if highlighted_count > 0 then 
    local text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
    G.GAME.hands[text].rd_discarded = G.GAME.hands[text].rd_discarded + 1
    G.GAME.hands[text].rd_discarded_this_ante = G.GAME.hands[text].rd_discarded_this_ante + 1
    G.GAME.hands[text].rd_discarded_this_round = G.GAME.hands[text].rd_discarded_this_round + 1
    
    if RainyDays.delirium_check() then
      G.GAME.rd_delirium_active = G.GAME.rd_delirium_active + 1
    end
  end
  return discard_cards_from_highlighted_ref(e, hook)
end

local end_round_ref = end_round
function end_round()
  local ret = end_round_ref()
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function()
      --round values reset
      G.GAME.rd_delirium_active = 0
      G.GAME.rd_consumeable_usage_round = 0
      G.GAME.rd_cards_drawn_this_round = 0
      
      for key in pairs(G.GAME.rd_ranks_played_this_round) do
        G.GAME.rd_ranks_played_this_round[key] = nil
      end
      
      for key in pairs(G.GAME.rd_ranks_scored_this_round) do
        G.GAME.rd_ranks_scored_this_round[key] = nil
      end
      
      for _, value in pairs(G.GAME.hands) do
        value.rd_discarded_this_round = 0
      end
      
      --ante values reset
      if G.GAME.blind:get_type() == 'Boss' then
        G.GAME.rd_consumeable_usage_ante = 0
        for _, value in pairs(G.GAME.hands) do
          value.rd_discarded_this_ante = 0
        end
      end
      return true
    end
  }))
  return ret
end

function RainyDays.delirium_check()
  if #G.hand.highlighted >= 4 then
    local wild_card_count = 0
    local non_wild = {}
    local suits = {}
    
    for i = 1, #G.hand.highlighted do
      if not SMODS.has_no_suit(G.hand.highlighted[i]) then
        if SMODS.has_any_suit(G.hand.highlighted[i]) then
          wild_card_count = wild_card_count + 1
        else
          non_wild[#non_wild + 1] = G.hand.highlighted[i]
        end
      end
    end
    
    --check if cards of suit are discarded
    for i = 1, #non_wild do 
      for key, _ in pairs(SMODS.Suits) do
        if not suits[key] and non_wild[i]:is_suit(key, true) then
          suits[key] = true
          break
        end
      end
    end
    
    --count amount of suits
    local count = wild_card_count
    for key, _ in pairs(SMODS.Suits) do
      if suits[key] then
        count = count + 1
      end
    end
    
    if count >= 4 then
      return true 
    end
  end
  return false
end

--maintain list of unique jokers
local add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
  if G.GAME and self.ability.set == 'Joker' then
    if not G.GAME.rd_jokers_uniquelist[self.config.center.key] then
      G.GAME.rd_jokers_uniquelist[self.config.center.key] = true
      G.GAME.rd_jokers_uniquelist_count = G.GAME.rd_jokers_uniquelist_count + 1
      G.GAME.rd_jokers_uniquelist_added = G.GAME.rd_jokers_uniquelist_added or {}
      G.GAME.rd_jokers_uniquelist_added[#G.GAME.rd_jokers_uniquelist_added + 1] = self.config.center.key
      G.E_MANAGER:add_event(Event({
        func = function()
          if G.GAME.rd_jokers_uniquelist_added and #G.GAME.rd_jokers_uniquelist_added > 0 then
            SMODS.calculate_context({ rd_unique_joker_added = true, card_keys = G.GAME.rd_jokers_uniquelist_added })
            G.GAME.rd_jokers_uniquelist_added = nil
          end
          return true
        end
      }))
    end
  end
  return add_to_deck_ref(self, from_debuff)
end

local ref_add_tag = add_tag
function add_tag(_tag)
  local ret = ref_add_tag(_tag)
  G.GAME.rd_tag_count = (G.GAME.rd_tag_count or 0) + 1
  check_for_unlock({ type = 'rd_tag_count' })
  return ret
end