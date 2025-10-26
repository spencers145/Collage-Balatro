SMODS.Joker({
    key = "attached",
    atlas = "jokers",
    pos = {x = 7, y = 8},
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {xmult = 1.35, sticker = 'eternal'}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult, localize({type = 'name_text', set = 'Other', key = card.ability.extra.sticker})}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local area = G.jokers.cards
            for i=#area, 1, -1 do
                if area[i].ability.set == 'Joker' then
                    if not area[i].ability[card.ability.extra.sticker] then
                        return {
                            message = localize('ortalab_attached'),
                            message_card = area[i],
                            func = function()
                                card:juice_up()
                                area[i]:add_sticker(card.ability.extra.sticker, true)
                                if area[i].ability.perishable then area[i].ability.perishable = false end
                            end
                        }
                    end
                    return
                end
            end
        end
        if context.other_joker and context.other_joker.ability.eternal then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end    
})