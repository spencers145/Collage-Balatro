SMODS.Joker {
  key = "tutor",
  rarity = 1,
  pos = { x = 4, y = 10 },
  atlas = "jokers_atlas",
  cost = 6,
  blueprint_compat = false,
  eternal_compat = true,
  discovered = false,
  perishable_compat = true,
}
local get_chip_bonus_ref = Card.get_chip_bonus
function Card.get_chip_bonus(self)
  if next(SMODS.find_card('j_paperback_tutor', false)) then
    local exponent = 0
    for i, k in ipairs(G.jokers.cards) do
      if k.config.center.key == 'j_paperback_tutor' then
        exponent = exponent + 1
      end
    end
    local multiplier = math.pow(2, exponent)
    if not self:is_face() then
      if self.ability.extra_enhancement then return self.ability.bonus * multiplier end

      if self.ability.effect == 'Stone Card' or self.config.center.replace_base_card then
        return self.ability.bonus + (self.ability.perma_bonus or 0)
      end
      return (self.base.nominal + self.ability.bonus + (self.ability.perma_bonus or 0)) * multiplier
    end
  end
  return get_chip_bonus_ref(self)
end
