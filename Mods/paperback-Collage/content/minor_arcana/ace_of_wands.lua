PB_UTIL.MinorArcana {
  key = 'ace_of_wands',
  config = {
    paperclip = 'paperback_red_clip',
    max_highlighted = 4
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 0, y = 2 },
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
