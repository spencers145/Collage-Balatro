function load_folder(folder)
  filenames = NFS.getDirectoryItems(SMODS.current_mod.path .. folder)
  for i = 1, #filenames do
    local file, exception = SMODS.load_file(folder .. '/' .. filenames[i])
    if exception then
      error(exception)
    end
    file()
  end
end

--load mod files
load_folder('functions')
assert(SMODS.load_file('atlas.lua'))()
assert(SMODS.load_file('objecttype_feather.lua'))()
load_folder('jokers')
--assert(SMODS.load_file('constellation_type.lua'))()
--load_folder('constellations')
--load_folder('seals')
--load_folder('spectrals')
--load_folder('tags')
load_folder('take_ownership')

--jokerdisplay support
if JokerDisplay then
  assert(SMODS.load_file('jokerdisplay.lua'))()
end

--override and adds new vars to initalization
local old_func_init_game_object = Game.init_game_object
function Game:init_game_object()
	local ret = old_func_init_game_object(self)
	ret.current_round.RD_lotteryticket = { 'Ace', 'King', 'Queen', 'Jack', '10' } --used for lottery ticket
  ret.current_round.RD_skip_interest = false --used for piggybank
	return ret
end

--calls here in case we add more cards that need the same function
function SMODS.current_mod.reset_game_globals(run_start)
  reset_game_globals_lotteryticket()
end