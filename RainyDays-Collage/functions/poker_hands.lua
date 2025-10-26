--find the most played poker hand
function most_played_poker_hand()
  local hand_most_played = nil
  if G.GAME then
    for key, value in ipairs(G.handlist) do
      if SMODS.is_poker_hand_visible(value) and (not hand_most_played or G.GAME.hands[value].played > G.GAME.hands[hand_most_played].played) then
        hand_most_played = value
      end
    end
    if G.GAME.hands[hand_most_played].played > 0 then
      return hand_most_played
    end
  end
  return nil
end

--find the least played poker hand
function least_played_poker_hand()
  local hand_least_played = nil
  if G.GAME then
    for key, value in ipairs(G.handlist) do
      if SMODS.is_poker_hand_visible(value) then
        if not hand_least_played or G.GAME.hands[value].played < G.GAME.hands[hand_least_played].played then
          hand_least_played = value
        end
      end
    end
    
    return hand_least_played
  end
  return nil
end

--find lowest level poker hand
function lowest_level_poker_hand()
  local hand_lowest_level = nil
  if G.GAME then
    for key, value in ipairs(G.handlist) do
      if SMODS.is_poker_hand_visible(value) then
        if not hand_lowest_level or G.GAME.hands[value].level < G.GAME.hands[hand_lowest_level].level then
          hand_lowest_level = value
        end
      end
    end
  end
  return hand_lowest_level
end

--find highest level poker hand
function highest_level_poker_hand()
  local hand_highest_level = nil
  if G.GAME then
    for key, value in ipairs(G.handlist) do
      if SMODS.is_poker_hand_visible(value) then
        if not hand_highest_level or G.GAME.hands[value].level >= G.GAME.hands[hand_highest_level].level then
          hand_highest_level = value
        end
      end
    end
  end
  return hand_highest_level
end

--check if hand is a secret hand
local game_init_game_object_ref = Game.init_game_object
function Game:init_game_object()
  local ret = game_init_game_object_ref(self)
  for key, value in ipairs(G.handlist) do
    ret.hands[value].secret = (not ret.hands[value].visible or type(ret.hands[value].visible) == 'function')
  end 
  return ret
end

function is_secret_pokerhand(hand)
  return  G.GAME.hands[hand].secret
end

function generate_main_end(text, colour)
  return {{
    n = G.UIT.C,
    config = { align = "bm", minh =  0.02 },
    nodes = {{
      n = G.UIT.C,
      config = {
        ref_table = card, 
        align = "m", 
        colour = colour,
        r = 0.05, 
        padding = 0.05 
      },
      nodes = {{ 
        n = G.UIT.T, 
        config = { 
          text = ' ' .. text .. ' ',
          colour = G.C.UI.TEXT_LIGHT, 
          scale = 0.3, 
          shadow = true 
        }
      }}
    }}
  }}
end