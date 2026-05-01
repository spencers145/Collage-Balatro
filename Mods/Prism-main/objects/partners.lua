SMODS.Atlas {
    key = 'prismpartner',
    path = "compat/partners.png",
    px = 46,
    py = 58
}

Partner_API.Partner{
    key = "blahaj",
    unlocked = false,
    discovered = true,
    pos = {x = 0, y = 0},
    individual_quips = true,
    loc_txt = {},
    atlas = "prismpartner",
    config = {extra = {}},
    link_config = {j_prism_shork = 1},
    loc_vars = function(self, info_queue, card)
        local link_level = self:get_link_level()
        local key = self.key
        info_queue[#info_queue+1] = G.P_CENTERS.tag_foil
        info_queue[#info_queue+1] = G.P_CENTERS.tag_holo
        info_queue[#info_queue+1] = G.P_CENTERS.tag_polychrome
        if link_level == 1 then key = key.."_"..link_level end
        return { key = key}
    end,
    calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition then
            local link_level = self:get_link_level()
            if (G.GAME.blind and (G.GAME.blind:get_type() == 'Boss')) or link_level == 1 then
                local tags = {"tag_holo","tag_foil","tag_polychrome"}
                local tag = pseudorandom_element(tags, pseudoseed('shorky'))
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = (function()
                        add_tag(Tag(tag))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('polychrome1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)}))
                return {
                    message = localize("k_blahaj"),
                    colour = G.C.DARK_EDITION,
                    card = card,
                }
            end
		end
	end,
    check_for_unlock = function(self, args)
        for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
            if v.key == "j_prism_shork" then
                if get_joker_win_sticker(v, true) >= 8 then
                    return true
                end
                break
            end
        end
    end,
}
Partner_API.Partner{
    key = "scopa",
    unlocked = false,
    discovered = true,
    pos = {x = 1, y = 0},
    individual_quips = true,
    loc_txt = {},
    atlas = "prismpartner",
    config = {extra = {mult = 3}},
    link_config = {j_prism_exotic_card = 1},
    loc_vars = function(self, info_queue, card)
        local benefits = 1
        if self:get_link_level() == 1 then benefits = 2 end
        return { vars = {card.ability.extra.mult*benefits} }
    end,
    calculate = function(self, card, context)
		if context.individual and context.other_card and context.scoring_hand and context.cardarea == G.play then
            if next(SMODS.get_enhancements(context.other_card)) then
                local benefits = 1
                if self:get_link_level() == 1 then benefits = 2 end
                return {
                    mult = card.ability.extra.mult*benefits,
                    colour = G.C.RED,
                    card = card
                }
            end
        end
	end,
    check_for_unlock = function(self, args)
        for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
            if v.key == "j_prism_exotic_card" then
                if get_joker_win_sticker(v, true) >= 8 then
                    return true
                end
                break
            end
        end
    end,
}