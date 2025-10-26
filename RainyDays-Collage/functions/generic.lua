--a function checks if given rank appears at least once in the given hand
function check_hand_for_match(hand, rank, exclude_debuffed)
  for i = 1, #hand do
    if check_card_for_match(hand[i], rank, exclude_debuffed) then
      return true
    end
  end
  return false
end

--check if specified card is of the given rank
function check_card_for_match(card, rank, exclude_debuffed)
  if not card.debuff or not exclude_debuffed then
    return card.base.value == rank and not SMODS.has_no_rank(card)
  end
  return false
end

--check if given card is in given hand
function check_card_in_hand(card, hand)
  for i = 1, #hand do
    if card == hand[i] then
      return true
    end
  end
  return false
end

--check if given table contain given value
function list_contains(list, value)
  for i = 1, #list do
    if list[i] == value then
      return true
    end
  end
  return false
end

--check if all the values in other table can be found in the given table 
function table_contains_all_values_of_other(table, other)
  for i = 1, #other do
    if not list_contains(table, other[i]) then
      return false
    end
  end
  return true
end

--a simple function for finding the position of a value and removing them at the same time. Can remove multiple entries if they have the same value.
function remove_by_value(list, value)
  for i = #list, 1, -1 do
    if list[i] == value then
      table.remove(list, i)
    end
  end
end

--returns a table with parts of a string, with no part being longer than the given length.
function splitString(string, maxLength)
  local parts = {}
  local currentPart = ""
  
  for word in string:gmatch("%S+") do
    if #currentPart + #word + 1 <= maxLength then
      if currentPart ~= "" then
        currentPart = currentPart .. " " .. word
      else
        currentPart = word
      end
    else
      if currentPart ~= "" then
        table.insert(parts, currentPart)
      end
      currentPart = word
    end
  end
  
  if currentPart ~= "" then
    table.insert(parts, currentPart)
  end
  
  return parts
end

--get joker position in joker line up
function GetJokerPosition(joker)
  for i = 1, #G.jokers.cards do
    if G.jokers.cards[i] == joker then
      return i
    end
  end
end