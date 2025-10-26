return {
  descriptions = {
    --Back={},
    --Blind={},
    --Edition={},
    --Enhanced={},
    Joker = {
      j_pl_plantain = {
        name = 'Plantain',
        text = {
          '{C:chips}+#1#{} Chips',
          '{C:green}#2# in #3#{} chance this',
          'card is destroyed',
          'at end of round'
        }
      },
      j_pl_postcard = {
        name = 'Postcard',
        text = {
          'Gains {X:mult,C:white}X2{} Mult for',
          'each {C:attention}Postcard{}',
          'sold this run',
          '{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)',
        }
      },
      j_pl_mini_crossword = {
        name = 'Mini Crossword',
        text = {
          {'Gains {C:mult}+#1#{} Mult if played hand',
          'has exactly {C:attention}#2#{} cards',
          '{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)'},
          {'Chooses between 3, 4,',
          'or 5 cards every round'},
          
        }
      },
      j_pl_bingo_card = {
        name = 'Bingo Card',
        text = {
          {'Each played {C:attention}#1#{} and {C:attention}#2#{}',
          'gives {C:chips}+#3#{} Chips and {C:mult}+#4#{} Mult',
          'when scored'},
          {'Ranks change every round',
          '{C:inactive}(Number ranks only)'}
        }
      },
      j_pl_apple_pie = {
        name = 'Apple Pie',
        text = {
          {'Earn {C:money}$#1#{} when',
          'a hand is played'},
          {'Decrease by {C:money}$#2#{}',
          'after cashing out'},
        }
      },
      j_pl_grape_soda = {
        name = 'Grape Soda',
        text = {
          'Selecting {C:attention}Skip Blind',
          'gives the Skip Tag {C:attention}without',
          'skipping the Blind, and',
          'destroys this card'
        }
      },
      j_pl_matryoshka = {
        name = 'Matryoshka',
        text = {
          'Retrigger all scoring',
          'cards if played hand',
          'contains a {C:attention}Straight'
        }
      },
      j_pl_jim = {
        name = 'Jim',
        text = {
          'Retrigger all played',
          'cards {C:attention}without',
          'enhancements'
        }
      },
      j_pl_crystal_joker = {
        name = 'Crystal Joker',
        text = {
          'If played hand contains',
          'a {C:attention}Stone{}, {C:attention}Crystal{},',
          'or {C:attention}Ore{} card, create',
          'a random {C:tarot}Tarot{} card'
        }
      },
      j_pl_el_dorado = {
        name = 'El Dorado',
        text = {
          'Earn {C:money}$#1#{} for each {C:attention}Wild',
          'card in your {C:attention}full deck',
          'at end of round',
          '{C:inactive}(Currently {C:money}$#2#{C:inactive})'
        }
      },
      j_pl_black_cat = {
        name = 'Black Cat',
        text = {
          'Gains {C:chips}+#1#{} Chips each',
          'time a {C:attention}Lucky{} card',
          '{C:attention}fails{} to trigger',
          '{C:inactive}(Currently {C:chips}+#2# {C:inactive}Chips)'
        }
      },
      j_pl_mossy_joker = {
        name = 'Mossy Joker',
        text = {
          'Convert a random card',
          '{C:attention}held in hand{} into a',
          'random {C:attention}scored{} card'
        }
      },
      j_pl_nametag = {
        name = 'Nametag',
        text = {
          '{X:mult,C:white}X2{} Mult for every',
          '{C:attention}Joker{} with \'Joker\'',
          'in its name'
        }
      },
      j_pl_calculator = {
        name = 'Calculator',
        text = {
          'Each played card with',
          '{C:attention}#1#{} rank gives',
          '{X:mult,C:white}X#3#{} Mult when scored',
          '{s:0.8}Changes to #2# next round'
        }
      },
      j_pl_raw_meat = {
        name = 'Raw Meat',
        text = {
          'After defeating {C:attention}Boss Blind{},',
          'sell this Joker to',
          'go back 1 {C:attention}Ante',
          '{C:inactive}(#2#)'
        }
      },
      j_pl_croissant = {
        name = 'Croissant',
        text = {
          'Retrigger next {C:attention}#1#',
          'hand upgrades'
        }
      },
      j_pl_pop_up_joker = {
        name = 'Pop-Up Joker',
        text = {
          '{C:green}#1# in #2#{} chance to',
          'add a random {C:attention}Booster Pack',
          'to the shop after {C:attention}reroll'
        }
      },
      j_pl_lamp = {
        name = 'Lamp',
        text = {
          {'{C:mult}+#2#{} Mult when a',
          '{C:attention}Joker{} card is sold',
          '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'},
          {'{C:mult}-#3#{} Mult each round'}
          
        }
      },
      j_pl_odd_sock = {
        name = 'Odd Sock',
        text = {
          'Gains {C:chips}+#1#{} Chips if',
          '{C:attention}discarded{} hand',
          'contains no {C:attention}Pairs',
          '{C:inactive}(Currently {C:chips}+#2# {C:inactive}Chips)'
        }
      },
      j_pl_hot_air_balloon = {
        name = 'Hot Air Balloon',
        text = {
          {'Earn {C:money}$#1#{} at end of round'},
          {'Payout increases by {C:money}$#2#{} when',
          '{C:tarot}Tarot{} card used, with a {C:green}#3# in #4#',
          'chance this card is {C:attention}destroyed'}
        }
      },
      j_pl_three_body_problem = {
        name = 'Three Body Problem',
        text = {
          'If played hand is',
          '{C:attention}Three of a Kind{}, upgrade',
          'last played hand',
          '{C:inactive}(Currently {C:attention}#1#{C:inactive})'
        }
      },
      j_pl_loose_batteries = {
        name = 'Loose Batteries',
        text = {
          'Retrigger all played {C:attention}Aces,',
          '{C:green}#1# in #2#{} chance played Aces',
          'are retriggered {C:attention}again'
        }
      },
      j_pl_quarry = {
        name = 'Quarry',
        text = {
          {'Scored {C:attention}Stone{} and {C:attention}Luminice{}',
          'cards are destroyed'},
          {'Each time this happens,',
          'this Joker gains {X:mult,C:white}X#1#{} Mult',
          '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)'}
        }
      },
      j_pl_lasagna = {
        name = 'Lasagna',
        text = {
          {'{X:mult,C:white}X#1#{} Mult'},
          {'Loses {X:mult,C:white}X#2#{} Mult',
          'per card {C:attention}sold'}
        }
      },
    },
    Other={
      pl_lavender_seal = {
        name = 'Lavender Seal',
        text = {
            'If {C:attention}discarded hand',
            'contains this card, do not',
            'consume a {C:attention}discard'
        }
      },
    },
    --Planet={},
    Spectral={
      c_pl_spec_aether = {
        name = 'Aether',
        text = {
          "Add a {C:lavender}Lavender Seal{}",
          "to {C:attention}1{} selected",
          "card in your hand",
        },
      },
      c_pl_spec_rebirth = {
        name = 'Rebirth',
        text = {
          'Select {C:attention}3{} cards, destroy the',
          '{C:attention}middle{} card and give its rank',
          'to the {C:attention}left{} and {C:attention}right{} cards',
          '{C:inactive}(Drag to rearrange)'
        }
      },
    },
    --Stake={},
    --Tag={},
    --Tarot={},
    -- Voucher = {},
  },
  misc = {
    dictionary = {
      pl_downgrade = 'Downgrade',
      pl_even = 'even',
      pl_odd = 'odd',
      pl_inactive = 'Inactive',
      pl_active = 'Active',
      pl_plantain_cooked = 'Cooked!',
      pl_apple_pie_slice = 'Slice!',
      pl_apple_pie_sold_out = 'Sold Out!',
      pl_grape_soda_gulp = 'Gulp!',
      pl_raw_meat_ante_down = 'Ante Down!',
      pl_pop_up_joker_winner_1 = '100,000th Visitor!',
      pl_pop_up_joker_winner_2 = 'Congratulations!',
      pl_pop_up_joker_winner_3 = 'You Win!',
      pl_pop_up_joker_winner_4 = 'Free Antivirus!',
      pl_hot_air_balloon_pop = 'Pop!',
      pl_lasagna_mama_mia = 'Mama Mia!',
    },
  --achievement_descriptions={},
  -- achievement_names={},
  --blind_states={},
  -- challenge_names={},
  -- collabs={},
  --dictionary={},
  --high_scores={},
    labels={
      pl_lavender_seal = "Lavender Seal",
    },
  -- poker_hand_descriptions={},
  --  poker_hands={},
  --  quips={},
  --  ranks={},
  -- suits_plural={},
  -- suits_singular={},
  --  v_dictionary={},
  -- v_text={},
  },
}
