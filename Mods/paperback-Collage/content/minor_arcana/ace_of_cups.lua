PB_UTIL.MinorArcana {
  key = 'ace_of_cups',
  config = {
    paperclip = 'paperback_blue_clip',
    max_highlighted = 4
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 0, y = 0 },
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
