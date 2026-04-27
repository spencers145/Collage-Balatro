PB_UTIL.MinorArcana {
  key = 'seven_of_swords',
  config = {
    max_highlighted = 3,
    paperclip = 'paperback_gold_clip'
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 6, y = 4 },
  paperback_credit = {
    coder = { 'dowfrin' }
  },
  in_pool = function ()
    return false
  end,

  paperback = {
    requires_paperclips = true
  }
}
