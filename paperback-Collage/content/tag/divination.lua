SMODS.Tag {
  key = 'divination',
  atlas = 'tags_atlas',
  pos = { x = 2, y = 0 },
  discovered = false,
  paperback = {
    requires_minor_arcana = true
  },

  loc_vars = function(self, info_queue)
    info_queue[#info_queue + 1] = G.P_CENTERS.p_paperback_minor_arcana_mega
  end,

  apply = function(self, tag, context)
    if context.type == 'new_blind_choice' then
      tag:yep('+', G.C.PAPERBACK_MINOR_ARCANA, function()
        PB_UTIL.open_booster_pack('p_paperback_minor_arcana_mega')
        return true
      end)

      tag.triggered = true
      return true
    end
  end
}
