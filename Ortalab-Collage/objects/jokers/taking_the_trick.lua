SMODS.Joker({
    key = "taking_the_trick",
    atlas = "jokers",
    pos = {x = 2, y = 15},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {extra = {mult = 0, gain = 1}},
    artist_credits = {'crimson'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain, card.ability.extra.mult, localize(card.ability.extra.suit, 'suits_singular'), localize(card.ability.extra.rank..'', 'ranks'), colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if not G.jokers then
            card.ability.extra.suit = "Hearts"
            card.ability.extra.rank = "10"
        else
            card.ability.extra.suit = Ortalab.suit_from_deck('ortalab_trick_suit')
            card.ability.extra.rank = Ortalab.rank_from_deck('ortalab_trick_rank')
        end
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for _, _card in pairs(context.scoring_hand) do
                if _card:is_suit(card.ability.extra.suit) and _card.base.id > SMODS.Ranks[card.ability.extra.rank].id then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "mult",
                        scalar_value = "gain",
                        scaling_message = {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.RED,
                            message_card = card,
                            juice_card = _card
                        },
                        block_overrides = {
                            message = true
                        }
                    })
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.suit = Ortalab.suit_from_deck('ortalab_trick_suit')
            card.ability.extra.rank = Ortalab.rank_from_deck('ortalab_trick_rank')
            return {
                message = localize({set = 'Ortalab_Utility', key = 'taking_the_trick', type = 'raw_descriptions', vars= {localize(card.ability.extra.rank ..'', 'ranks'), localize(card.ability.extra.suit, 'suits_plural')}}),
                no_retrigger = true
            }
        end
    end    
})