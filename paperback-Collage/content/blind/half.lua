SMODS.Blind {
  key = 'half',
  boss = {
    min = 3
  },
  discovered = false,
  boss_colour = HEX('D1AB88'),
  atlas = 'music_blinds_atlas',
  pos = { y = 6 },
  dollars = 3,

  calculate = function(self, blind, context)
    if context.mod_probability then
      return {
        denominator = context.denominator * 2
      }
    end
  end
}
