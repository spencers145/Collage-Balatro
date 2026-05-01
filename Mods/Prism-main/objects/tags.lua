SMODS.Atlas({
    key = 'prismtags',
    path = 'tags.png',
    px = '34',
    py = '34'
})
function G.PRISM.Tag(table)
	if table.dependency or table.dependency == nil then
		SMODS.Tag(table)
	end
end

G.PRISM.Tag({
    dependency = G.PRISM.config.myth_enabled,
    key = 'myth',
    atlas = 'prismtags',
    pos = {x = 0, y = 0},
    discovered = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_prism_large_myth
    end,
    apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
			local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.GREEN,function() 
				local key = 'p_prism_large_myth'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
    end
})

G.PRISM.Tag({
    key = 'gold_foil',
    atlas = 'prismtags',
    pos = {x = 1, y = 0},
    discovered = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_prism_gold_foil
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' and not context.card.edition and not context.card.temp_edition then
            if context.card.ability.set == 'Joker' and context.card.config.center.blueprint_compat  then
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card:set_edition('e_prism_gold_foil', true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    context.card.temp_edition = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end
})

G.PRISM.Tag({
    dependency = G.PRISM.config.myth_enabled,
    key = 'gnome',
    atlas = 'prismtags',
    pos = {x = 2, y = 0},
    discovered = false,
    config = {dollars = 17},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.dollars}}
    end,
    in_pool = function(self)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            if G.GAME.last_blind and G.GAME.last_blind.boss then
                tag:yep('+', G.C.GOLD,function() 
                    return true
                end)
                tag.triggered = true
                return {
                    dollars = tag.config.dollars,
                    condition = localize('ph_defeat_the_boss'),
                    pos = tag.pos,
                    tag = self,
                }
            end
        end
    end
})