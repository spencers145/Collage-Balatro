tes = SMODS.current_mod

G.FUNCS.tes_cycle_options = function(args)
    args = args or {}
    if args.cycle_config and args.cycle_config.ref_table and args.cycle_config.ref_value then
      args.cycle_config.ref_table[args.cycle_config.ref_value] = args.to_key
    end
end

local option_pos_start1
local option_pos_start2

SMODS.current_mod.config_tab = function()
  option_pos_start1 = tes.config.suppression_apple_pie
  option_pos_start2 = tes.config.suppression_plushie
  
  return {
    n = G.UIT.ROOT, 
    config = {
      align = "cm", 
      padding = 0.05, 
      colour = G.C.CLEAR
    },
    
    nodes = {
      create_toggle({
        label = localize('rebalance_name'),
        ref_table = tes.config,
        ref_value = 'rebalance'
      }),
    
      next(SMODS.find_mod('plantain')) and create_option_cycle({
        w = 7,
        info = not next(SMODS.find_mod('extracredit')) and localize('suppression_description') or nil,
        options = localize('suppress_apple_pie_options'),
        current_option = tes.config.suppression_apple_pie,
        colour = G.C.RED,
        text_scale = 0.5,
        ref_table = tes.config,
        ref_value = 'suppression_apple_pie',
        opt_callback = 'tes_cycle_options'
      }) or nil,
      
      next(SMODS.find_mod('extracredit')) and create_option_cycle({
        w = 7,
        info = localize('suppression_description'),
        options = localize('suppress_plushie_options'),
        current_option = tes.config.suppression_plushie,
        colour = G.C.RED,
        text_scale = 0.5,
        ref_table = tes.config,
        ref_value = 'suppression_plushie',
        opt_callback = 'tes_cycle_options'
      }) or nil
    }
  }
end

local old_func_exit = G.FUNCS.exit_mods
G.FUNCS.exit_mods = function(e)
  if (option_pos_start1 and option_pos_start1 ~= tes.config.suppression_apple_pie) or (option_pos_start2 and option_pos_start2 ~= tes.config.suppression_plushie) then
    SMODS.full_restart = 1
  end
  return old_func_exit(e)
end

--load mod files
local filenames = NFS.getDirectoryItems(SMODS.current_mod.path .. 'jokers')
for i = 1, #filenames do
    local file, exception = SMODS.load_file('jokers/' .. filenames[i])
    if exception then
      error(exception)
    end
    file()
end

SMODS.Atlas {
    key = 'T.Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

--jokerdisplay support
if JokerDisplay then
    SMODS.load_file('jokerdisplay.lua')()
end

if next(SMODS.find_mod('plantain')) and tes.config.suppression_apple_pie == 1 then
  SMODS.Joker:take_ownership('pl_apple_pie',
    {
      in_pool = function(self, args)
        return false
      end,
      no_collection = true
    },
    true
  )
end

if next(SMODS.find_mod('extracredit')) and tes.config.suppression_plushie == 1 then
  SMODS.Joker:take_ownership('ExtraCredit_plushie',
    {
      in_pool = function(self, args)
        return false
      end,
      no_collection = true
    },
    true
  )
end