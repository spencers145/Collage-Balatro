SMODS.Joker {
  key = 'microwave',
  name = 'Microwave',
  atlas = 'Jokers',
  rarity = 1,
  cost = 6,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  pos = GetJokersAtlasTable('microwave'),
  config = {
    extra = {
      plus_mult = 0,
      plus_mult_add = 1,
      plus_mult_border = 20
    }
  },
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = {key = 'collage_popcorn_explainer', set = "Other"}
    return {
      vars = { 
        card.ability.extra.plus_mult,
        card.ability.extra.plus_mult_add,
        card.ability.extra.plus_mult_border
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      card.ability.extra.plus_mult = card.ability.extra.plus_mult + card.ability.extra.plus_mult_add
      return {
        mult_mod =  card.ability.extra.plus_mult,
        message = localize {
          type = 'variable',
          key = 'a_mult',
          vars = { card.ability.extra.plus_mult }
        },
        colour = G.C.MULT,
      }
    end

    if context.after then
        if card.ability.extra.plus_mult >= card.ability.extra.plus_mult_border then
          card:flip()
          return {
          func = function()
            if math.random() < 0.1 and G.SETTINGS.SOUND.game_sounds_volume > 0 and G.SETTINGS.SOUND.volume > 0 then
              local stored_music = G.SETTINGS.SOUND.music_volume
              G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 8 * G.SPEEDFACTOR,
                func = function ()
                  G.SETTINGS.SOUND.music_volume = 0
                  play_sound('collage_microwave_innocent', 1, 0.85)
                  return true
                end
              }))
              G.E_MANAGER:add_event(Event({
                func = function ()
                  G.SETTINGS.SOUND.music_volume = stored_music
                  card:set_ability('j_popcorn', true)
                  card:set_cost()
                  card:flip()
                  return true
                end
              }))
            else
              play_sound('RainyDays_microwave_ding', 0.7, 0.4)
              card:set_ability('j_popcorn', true)
              card:set_cost()
              card:flip()
            end
          end,
          message = localize('rainydays_beep'),
          colour = G.C.RED
        }
        else
          return {
            message = localize{type='variable', key='a_mult', vars= { card.ability.extra.plus_mult }},
            card = card,
            colour = G.C.RED
          }
        end
    end

    if context.pre_discard and card.ability.extra.ikeeptrackofdiscards ~= G.GAME.current_round.discards_left then
      card.ability.extra.plus_mult = card.ability.extra.plus_mult + card.ability.extra.plus_mult_add
      if card.ability.extra.plus_mult >= card.ability.extra.plus_mult_border then
        card:flip()
        return {
          func = function()
            if math.random() < 1 and G.SETTINGS.SOUND.game_sounds_volume > 0 and G.SETTINGS.SOUND.volume > 0 then
              local stored_music = G.SETTINGS.SOUND.music_volume
              G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 10 * G.SPEEDFACTOR,
                func = function ()
                  G.SETTINGS.SOUND.music_volume = 0
                  play_sound('collage_microwave_innocent', 1, 0.8)
                  return true
                end
              }))
              G.E_MANAGER:add_event(Event({
                func = function ()
                  G.SETTINGS.SOUND.music_volume = stored_music
                  card:set_ability('j_popcorn', true)
                  card:set_cost()
                  card:flip()
                  return true
                end
              }))
            else
              play_sound('RainyDays_microwave_ding', 0.7, 0.4)
              card:set_ability('j_popcorn', true)
              card:set_cost()
              card:flip()
            end
          end,
          message = localize('rainydays_beep'),
          colour = G.C.RED
        }
      else
        return {
          message = localize{type='variable', key='a_mult', vars= { card.ability.extra.plus_mult }},
          card = card,
          colour = G.C.RED
        }
      end
    end

    if context.pre_discard then
        card.ability.extra.ikeeptrackofdiscards = G.GAME.current_round.discards_left
    end
  end
}

SMODS.Sound {
  key = 'microwave_ding',
  path = 'microwave_ding.ogg'
}