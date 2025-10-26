local jd_def = JokerDisplay.Definitions

jd_def["j_RainyDays_atom"] = {
  text = {
    { ref_table = "card.joker_display_values", ref_value = "numerator_out" },
    { text = " in " },
    { ref_table = "card.joker_display_values", ref_value = "denominator_out" },
  },
  text_config = { colour = G.C.GREEN },
  calc_function = function(card)
    card.joker_display_values.numerator_out, card.joker_display_values.denominator_out = SMODS.get_probability_vars(card, card.ability.extra.numerator_in, card.ability.extra.denominator_in)
  end
}

jd_def["j_RainyDays_bankaccount"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "plus_chips", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.CHIPS }
}

jd_def["j_RainyDays_breakfast_cereal"] = {
  text = {
    { ref_table = "card.ability.extra", ref_value = "upgrades_left" },
    { text = " left" }
  },
  text_config = { colour = G.C.FILTER }
}

jd_def["j_RainyDays_burdenofgreatness"] = {}

jd_def["j_RainyDays_cleanslate"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "plus_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_RainyDays_cloverfield"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.MULT },
  reminder_text = {
    { text = "(" },
    { ref_table = "card.ability.extra", ref_value = "discarded_counter" },
    { text = "/" },
    { ref_table = "card.ability.extra", ref_value = "per_discarded" },
    { text = ")" }
  }
}

jd_def["j_RainyDays_fabergeegg"] = {}

jd_def["j_RainyDays_feather_precious"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.joker_display_values", ref_value = "money" },
  },
  text_config = { colour = G.C.GOLD },
  calc_function = function(card)
    card.joker_display_values.money = card.ability.extra.plus_money * GetFeatherCount()
  end
}

jd_def["j_RainyDays_feather_silky"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
  },
  text_config = { colour = G.C.MULT },
  calc_function = function(card)
    card.joker_display_values.mult = card.ability.extra.plus_mult * GetFeatherCount()
  end
}

jd_def["j_RainyDays_feather_vibrant"] = {
  text = {
    { text = "+" },
    { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" },
  },
  text_config = { colour = G.C.CHIPS },
  calc_function = function(card)
    card.joker_display_values.chips = card.ability.extra.plus_chips * GetFeatherCount()
  end
}

jd_def["j_RainyDays_flipflop"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
      }
    },
    { text = " +", colour = G.C.CHIPS },
    { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS }
  },
  calc_function = function(card)
    card.joker_display_values.xmult = (card.ability.extra.state == 0) and card.ability.extra.plus_xmult or 1
    card.joker_display_values.chips = (card.ability.extra.state == 1) and card.ability.extra.plus_chips or 0
  end
}

jd_def["j_RainyDays_hannysvoorwerp"] = {}

jd_def["j_RainyDays_heirloom"] = {}

jd_def["j_RainyDays_kintsugi"] = {}

jd_def["j_RainyDays_kudzu"] = {}

jd_def["j_RainyDays_lady_of_the_lake"] = {}

jd_def["j_RainyDays_lotteryticket"] = {
  text = {
    { text = "+$" },
    { ref_table = "card.ability.extra", ref_value = "reward_money", retrigger_type = "mult" }
  },
  text_config = { colour = G.C.GOLD },
  reminder_text = {
    { text = "(" },
    { ref_table = "G.GAME.current_round.RD_lotteryticket", ref_value = 1 },
    { text = " " },
    { ref_table = "G.GAME.current_round.RD_lotteryticket", ref_value = 2 },
    { text = " " },
    { ref_table = "G.GAME.current_round.RD_lotteryticket", ref_value = 3 },
    { text = " " },
    { ref_table = "G.GAME.current_round.RD_lotteryticket", ref_value = 4 },
    { text = " " },
    { ref_table = "G.GAME.current_round.RD_lotteryticket", ref_value = 5 },
    { text = ")" }
  }
}

jd_def["j_RainyDays_microwave"] = {
  text = {
    { text = "+" },
    { ref_table = "card.ability.extra", ref_value = "plus_mult", retrigger_type = "mult" },
    { text = "/+" },
    { ref_table = "card.ability.extra", ref_value = "plus_mult_border" }
  },
  text_config = { colour = G.C.MULT }
}

jd_def["j_RainyDays_sediment"] = {
  text = {
    {
      border_nodes = {
        { text = "X" },
        { ref_table = "card.ability.extra", ref_value = "plus_xmult", retrigger_type = "exp" }
      }
    }
  }
}

jd_def["j_RainyDays_sextant"] = {
  text = {
    { text = "(" },
    { ref_table = "card.ability.extra", ref_value = "scored_counter" },
    { text = "/" },
    { ref_table = "card.ability.extra", ref_value = "per_scored" },
    { text = ")" }
  }
}

jd_def["j_RainyDays_sputnik"] = {}

jd_def["j_RainyDays_truffle"] = {
  text = {
    { ref_table = "card.ability.extra", ref_value = "amount" },
    { text = " left" }
  },
  text_config = { colour = G.C.FILTER }
}

jd_def["j_RainyDays_waste_not"] = {}