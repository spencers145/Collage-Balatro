RainyDays = SMODS.current_mod

function RainyDays.load_folder(folder)
  local filenames = SMODS.NFS.getDirectoryItems(RainyDays.path .. folder)
  for i = 1, #filenames do
    assert(SMODS.load_file(folder .. '/' .. filenames[i]))()
  end
end

--load mod files
assert(SMODS.load_file('atlas.lua'))()
assert(SMODS.load_file('challenge_bans.lua'))()
assert(SMODS.load_file('config_menu.lua'))()
assert(SMODS.load_file('objecttype_feather.lua'))()

RainyDays.load_folder('functions')
RainyDays.load_folder('jokers')
RainyDays.load_folder('jokers_unlockable')

--override and adds new vars to initalization
local old_func_init_game_object = Game.init_game_object
function Game:init_game_object()
	local ret = old_func_init_game_object(self)
  ret.current_round.RD_headhunter = 'j_joker'
	ret.current_round.RD_lotteryticket = { 'Ace', 'King', 'Queen', 'Jack', '10' }
  ret.current_round.RD_prairie_poker_hand = 'High Card'
  ret.current_round.RD_skip_interest = false --used for piggybank
  ret.current_round.RD_wishbone = 'c_fool'
	return ret
end

local old_func_start_run = Game.start_run
function Game:start_run(args)
  local ret = old_func_start_run(self, args)
  self.GAME.RD_init_complete = true
  return ret
end

--calls here in case we add more cards that need the same function
function RainyDays.reset_game_globals(run_start)
  --RainyDays.reset_game_globals_headhunter()
  reset_game_globals_lotteryticket()
  RainyDays.reset_game_globals_prairie()
  --RainyDays.reset_game_globals_wishbone()
end

RainyDays.balatro_hands = {
  'Flush Five', 'Flush House', 'Five of a Kind', 'Straight Flush', 'Four of a Kind', 'Full House',
  'Flush', 'Straight', 'Three of a Kind', 'Two Pair', 'Pair', 'High Card'
}

RainyDays.balatro_ranks = {
  'Ace', 'King', 'Queen', 'Jack', '10', '9', '8', '7', '6', '5', '4', '3', '2'
}

RainyDays.balatro_ranks_to_id = {}
local id = 15
for i = 1, #RainyDays.balatro_ranks do
  RainyDays.balatro_ranks_to_id[RainyDays.balatro_ranks[i]] = id - i
end  