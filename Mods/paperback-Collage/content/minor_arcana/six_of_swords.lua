PB_UTIL.MinorArcana {
  key = 'six_of_swords',
  config = {
    max_highlighted = 4,
    paperclip = 'paperback_yellow_clip'
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 5, y = 4 },
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
