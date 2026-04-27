PB_UTIL.MinorArcana {
  key = 'three_of_cups',
  config = {
    paperclip = 'paperback_black_clip',
    max_highlighted = 3
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 2, y = 0 },
  paperback_credit = {
    coder = { 'srockw' }
  },
  in_pool = function ()
    return false
  end,

  paperback = {
    requires_paperclips = true
  }
}
