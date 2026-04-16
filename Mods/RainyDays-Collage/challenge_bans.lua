function RainyDays.challenge_add_bans(challenge, bans)
  for i = 1, #bans do
    G.CHALLENGES[challenge].restrictions.banned_cards[#G.CHALLENGES[challenge].restrictions.banned_cards + 1] = { id = bans[i] }
  end
end

if RainyDays.config.feathers then 
  RainyDays.challenge_add_bans(1, { 'j_RainyDays_feather_precious' }) --Jokers with payout
end

RainyDays.challenge_add_bans(8, { --Jokers that can't be eternal
  'j_RainyDays_avocado',
  'j_RainyDays_breakfast_cereal',
  'j_RainyDays_dealer',
  'j_RainyDays_grapes',
  'j_RainyDays_truffle',
  'j_RainyDays_wishbone'
})

RainyDays.challenge_add_bans(14, { 'j_RainyDays_primality' }) --jokers that add non-glass cards or can turn glass cards into non-glass
RainyDays.challenge_add_bans(16, { 'j_RainyDays_dealer' }) --Jokers that give extra hands
RainyDays.challenge_add_bans(17, { 'j_RainyDays_bazaar', 'j_RainyDays_overflow' }) --Joker that increase hand size
RainyDays.challenge_add_bans(18, { 'j_RainyDays_dealer' }) --Jokers that give extra hands