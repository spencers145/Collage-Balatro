--a function checks if given rank appears at least once in the given hand
function check_hand_for_match(hand, rank, exclude_debuffed)
  for i = 1, #hand do
    if check_card_for_match(hand[i], rank, exclude_debuffed) then
      return true
    end
  end
  --automatically returns nil.
end

function check_card_for_match(card, rank, exclude_debuffed)
  if not card.debuff or not exclude_debuffed then
    return card.base.value == rank and not SMODS.has_no_rank(card)
  end
  --automatically returns nil.
end

function check_card_in_hand(card, hand)
  for i = 1, #hand do
    if card == hand[i] then
      return true
    end
  end
  --automatically returns nil.
end

--a simple function for finding the position of a value and removing them at the same time. Can remove multiple entries if they have the same value.
function remove_by_value(list, value)
  for i = #list, 1, -1 do
    if list[i] == value then
      table.remove(list, i)
    end
  end
end