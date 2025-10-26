SMODS.Tag {
  key = "nebula",
  atlas = 'Tags',
  pos = { x = 0, y = 0 },
  unlocked = true, 
  discovered = true,
  no_collection = true,
  
  in_pool = function(self, args)
    return false
  end,
  
  loc_vars = function(self, info_queue, tag)
    info_queue[#info_queue + 1] = G.P_CENTERS['p_celestial_normal_1']
    return {}
  end,
  
  apply = function(self, tag, context)
    if context.type == 'voucher_add' then
      tag:yep('+', G.C.SET.Planet, function()
        local packs = {
          'p_celestial_normal_1',
          'p_celestial_normal_2',
          'p_celestial_normal_3',
          'p_celestial_normal_4'
        }
        local pack = pseudorandom_element(packs, pseudoseed('nebula' .. G.GAME.round_resets.ante))
        local created_pack = SMODS.add_booster_to_shop(pack)
        created_pack.from_tag = true
        created_pack.ability.couponed = true
        created_pack:set_cost()
        return true
      end)
    tag.triggered = true
    end
  end
}