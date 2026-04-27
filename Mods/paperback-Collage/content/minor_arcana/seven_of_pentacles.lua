PB_UTIL.MinorArcana {
  key = 'seven_of_pentacles',
  config = {
    max_highlighted = 3,
    paperclip = 'paperback_green_clip'
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 6, y = 6 },
  paperback_credit = {
    artist = { 'ari' },
    coder = { 'metanite' }
  },
  in_pool = function ()
    return false
  end,

  paperback = {
    requires_paperclips = true
  }
}
