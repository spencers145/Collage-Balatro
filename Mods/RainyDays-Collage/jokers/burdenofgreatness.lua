SMODS.Joker {
  key = 'burdenofgreatness',
  atlas = 'Jokers',
  rarity = 3,
  cost = 7,
  unlocked = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('burdenofgreatness'),
  
  config = {
    extra = {
      plus_score = 5
    }
  },
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_charm
    return {
      vars = {
        card.ability.extra.plus_score
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
      G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * (1 + 0.01 * card.ability.extra.plus_score)
      G.E_MANAGER:add_event(Event({
        func = function()
          add_tag(Tag('tag_charm'))
          play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
          play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
          return true
        end
      }))
      return {
        message = localize('rainydays_plus') .. '1 ' .. localize('rainydays_charm_tag'),
        colour = G.C.SECONDARY_SET.Tarot,
        extra = {
          message = localize('rainydays_danger'),
          colour = G.C.PURPLE
        }
      }
    end
  end,
  
  check_for_unlock = function(self, args)
    return args.type == 'round_win' and G.GAME.blind.boss and G.GAME.chips / G.GAME.blind.chips >= to_big(3)
  end
}