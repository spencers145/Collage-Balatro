return {
  descriptions = {
    Joker = {
      j_tes_bismuth = {
        name = 'Bismuth',
        text = {
          "Retrigger each",
          "played {C:attention}Wild Card{} an",
          "additional {C:attention}#1#{} times"
        }
      },
          
      j_tes_blocks = {
        name = "Letter Blocks",
        text = {
          "This Joker gains {C:mult}+#1#{} Mult for",
          "each {C:attention}lettered{} card {C:inactive}(A, K, Q, J)",
          "scored in {C:attention}first hand{} of round",
          "{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)"
        }
      },
      
      j_tes_blue_java = {
        name = 'Blue Java',
        text = {
          "{C:chips}+#1#{} Chips"
        },
      },
      
      j_tes_chroma = {
        name = 'Chromatic Aberration',
        text = {
          "All played {C:attention}Wild Cards{} become",
          "{C:dark_edition}Polychrome{} when scored"
        }
      },
      
      j_tes_conduit = {
        name = 'Conduit',
        text = {
          "Played {C:attention}Bonus Cards{} give",
          "{C:mult}+#2#{} Mult when scored",
          "Played {C:attention}Mult Cards{} give",
          "{C:chips}+#1#{} Chips when scored"
        }
      },
      
      j_tes_dada = {
        name = 'Dada Joker',
        text = {
          "{C:white,X:mult}X#1#{} Mult for each",
          "{C:attention}Joker{} card"
        }
      },
      
      j_tes_impos = {
        name = 'Impossibility',
        text = {
          "{X:mult,C:white}X#1#{} Mult if poker hand",
          "contains a {C:attention}2{} and an {C:attention}8"
        }
      },
      
      j_tes_jimbette = {
        name = 'Jimbette',
        text = {
          "This Joker gains {C:mult}+#1#{} Mult",
          "every {C:attention}7 {C:inactive}[#3#]{} cards",
          "with {C:hearts}Heart{} suit scored",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
        }
      },
      
      j_tes_mahjong = {
        name = 'Mahjong Tile',
        text = {
          "Earn {C:money}$#1#{} if played",
          "hand contains a {C:attention}Pair"
        }
      },
      
      j_tes_mint = {
        name = 'Mint Condition',
        text = {
          "Earn {C:money}$#1#{} at end of round",
          "Reduce by {C:money}$#2#{} on {C:red}discard"
        }
      },
      
      j_tes_penrose = {
        name = 'Penrose',
        text = {
          "If played hand contains",
          "exactly {C:attention}three{} cards",
          "and one {C:attention}3{}, {C:attention}transform",
          "played cards into that",
          "{C:attention}3{} after scoring"
        }
      },
      
      j_tes_pie = {
        name = 'Apple Pie',
        text = {
          {"Earn {C:money}$#1#{} each",
          "played hand"},
          {"Reduce by {C:money}$#2#{}",
          "at end of round"}
        }
      },
      
      j_tes_pineapple = {
        name = 'Pineapple',
        text = {
          "{C:chips}+#1#{} Chips",
          "{C:chips}-#2#{} Chips at end of round",
          "if {C:attention}first hand{} of round",
          "doesn't beat the {C:attention}Blind"
        }
      },
      
      j_tes_reserve = {
        name = "Reserve Leaflet",
        text = {
          "{C:rare}Rare{} Jokers each",
          "give {X:mult,C:white}X#1#{} Mult"
        }
      },
      
      j_tes_waterfall = {
        name = 'Waterfall',
        text = {
          "{C:mult}+#1#{} discard each round",
          "This Joker gains {C:chips}+#2#{} Chips",
          "when a {C:attention}3{} or {C:attention}6{} is discarded",
          "{C:inactive}(Currently {C:chips}+#3#{} {C:inactive}chips)"
        }
      }
    }
  },
  
  misc = {
    dictionary = {
      suppress_apple_pie_options = {
        "Suppress Plantain's Apple Pie",
        "Suppress Mint Condition",
        "Take no action"
      },
      
      suppress_plushie_options = {
        "Suppress ExtraCredit's Plushie",
        "Suppress Dada Joker",
        "Take no action"
      },
      
      suppression_description = {
        "Resolve conflict between similar",
        "Jokers (Restart required)"
      },
      
      rebalance_name = "Rebalance Letter Blocks"
    }
  }
}