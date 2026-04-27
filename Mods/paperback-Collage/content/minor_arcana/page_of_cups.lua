PB_UTIL.MinorArcana {
  key = 'page_of_cups',
  config = {
    paperclip = 'paperback_white_clip',
    max_highlighted = 4
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 3, y = 1 },
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
