SMODS.Tag {
  key = 'creative',
  atlas = 'tags_atlas',
  pos = { x = 0, y = 0 },
  discovered = false,

  loc_vars = function(self, info_queue)
    info_queue[#info_queue + 1] = G.P_CENTERS.p_artb_arts_crafts_mega
  end,

  apply = function(self, tag, context)
    if context.type == "new_blind_choice" then
			local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
			tag:yep('+', HEX("be5e6e"),function() 
				unlock_card(G.P_CENTERS.b_femtoLabsCollection_mural)
				local key = 'p_artb_arts_crafts_mega'
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
}
