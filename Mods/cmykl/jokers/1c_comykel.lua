
SMODS.Joker{ --comykel
    key = "comykel",
    config = {
        extra = {
            rare_mod = 99999
        }
    },
    loc_txt = {
        ['name'] = '{C:planet}c{}o{C:legendary}m{}{C:money}y{}{X:white,C:default}k{}el',
        ['text'] = {
            '{X:red, C:white}HOW DID YOU GET THIS?!{}',
            'makes commons and uncommons impossible to get in shop',
            '{C:inactive}Unobtainable in normal runs.{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    no_collection = true,

    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },
    soul_pos = {
        x = 5,
        y = 1
    },
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' 
          or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,
    calculate = function(self, card, context)
        if card.edition and card.edition.key == "e_negative" then
            card.children.center:set_sprite_pos({x = 7, y = 2})
            card.children.floating_sprite:set_sprite_pos({x = 8, y = 2})
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.rare_mod = G.GAME.rare_mod + card.ability.extra.rare_mod
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.rare_mod = G.GAME.rare_mod - card.ability.extra.rare_mod
    end
}