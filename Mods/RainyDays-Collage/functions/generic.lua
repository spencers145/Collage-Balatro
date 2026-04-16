--check if given table contain given value
function RainyDays.list_contains(list, entry)
  if list then
    for _, value in pairs(list) do
      if entry == value then
        return true
      end
    end
  end
  return false
end

--a simple function for finding the position of a value and removing them at the same time. Can remove multiple entries if they have the same value.
function RainyDays.remove_by_value(list, value)
  for i = #list, 1, -1 do
    if list[i] == value then
      table.remove(list, i)
    end
  end
end

function RainyDays.create_consumable(message_card, set, amount, key)
  amount = math.min(amount or 1, G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer))
  G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + amount
  if amount > 0 then
    local loc_key = (set == 'CN_Constellation' and 'rainydays_constellation')
      or (set == 'Planet' and 'k_planet')
      or (set == 'Spectral' and 'k_spectral') 
      or (set == 'Tarot' and 'k_tarot')
    return {
      message_card = message_card,
      message = localize('rainydays_plus') .. amount .. ' ' .. localize(loc_key),
      colour = G.C.SECONDARY_SET[set],
      func = function()
        G.E_MANAGER:add_event(Event({
          func = function()
            for i = 1, amount do 
              SMODS.add_card({ set = set, key = key })
            end
            G.GAME.consumeable_buffer = 0
            return true
          end
        }))
      end
    }
  end
end

--get joker position in joker line up
function RainyDays.GetJokerPosition(joker)
  if G.jokers and G.jokers.cards then
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i] == joker then
        return i
      end
    end
  end
end

function RainyDays.IsInPool(card, pool)
  local center = (type(card) == 'string' and G.P_CENTERS[card]) or (card.config and card.config.center)
  return (center and center.pools and center.pools[pool])
end

function RainyDays.Round(value, decimals)
  local precision = math.pow(10, decimals or 0)
  return math.floor(value * precision + 0.5) / precision
end

function RainyDays.Is_odd(card)
  return (card:get_id() >= 0 and card:get_id() <= 10 and card:get_id() % 2 == 1) or card:get_id() == 14 
end

function RainyDays.TableToString(table)
    local result = ''
    for k, v in pairs(table) do
        result = result .. tostring(k) .. ' = ' .. tostring(v) .. ', '
    end
    return result
end