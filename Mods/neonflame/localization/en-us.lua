
return {
    descriptions = {
        Joker = {
		    j_nflame_jokerhelp = {
		        name = "Helping Hand",
				text = {
					"{C:blue}+#1#{} hand for each",
					"{C:common}Common {C:attention}Joker{}",
				}
		    },
	
		    j_nflame_hoarder = {
		        name = "Hoarder",
			text = {
			    "Gains {C:white,X:mult} X#1# {} Mult",
			    "for each {C:attention}Steam Level{}",
			    "{C:inactive}Currently {C:white,X:mult}X#2#{}"
			}
		    },
	
		    j_nflame_nflame = {
		        name = "Neonflame",
			text = {
			    "Gains {C:white,X:mult} X#1# {} Mult",
			    "for each {C:attention}new card added by Neonflame{}",
			    "Loses {C:white,X:mult} X#2# {} Mult for each day",
			    "since a new update",
			    "{C:inactive}Currently {C:white,X:mult}X#3#{}"
			}
		    },
	
		    j_nflame_forecast = {
		        name = "Forecast",
			text = {
			    "When booster pack is opened",
			    "draw #1# more cards",
			    "{s:0.8,C:inactive}Idea by badfontkeming{}",
			},
		    },
	
		    j_nflame_numberup = {
		        name = "Number Go Up",
			text = {
			    "Jokers give {C:white,X:mult}X#1#{}",
			    "If hand scored more than X#2# of blind score, lose all money",
			}
		    },
	
		    j_nflame_tjhenry = {
		        name = "TJ 'Henry' Yoshi",
			text = {
			    "If played hand has #1# or less cards",
			    "Scored cards gain {C:white,X:mult}X#2#{}",
			    "and are {C:attention}drawn to hand next round{}"
			}
		    },
	
		    j_nflame_stanleybucket = {
		        name = "Reassurance Bucket",
			text = {
			    "Siphons {C:purple}round score {C:attention}on discard{}",
			    "Adds {C:purple}stored round score{} when {C:attention}playing a hand{}",
			    "{C:inactive}(Currently {C:purple}+#1#{C:inactive} score){}",
			    "{s:0.8,C:inactive}Stanley and the bucket couragously bet all of their",
			    "{s:0.8,C:inactive}life savings on a poker game. Let's see how this turns out."
			}
		    },
	
		    j_nflame_acpart = {
		        name = "Agamemnon Counterpart",
			text = {
			    "If {C:attention}played hand{} contains an {C:attention}Ace{},",
			    "convert a {C:attention}random card in hand{} to an {C:attention}Ace{}",
			    "{C:inactive}a{}"
			}
		    },
	
		    j_nflame_opensource = {
		        name = "Open Source",
			text = {
			    "When a {C:cry_code}Green Seal{} is scored",
			    "Create a {C:cry_code}Commit, Rework, or Delete{} card",
			    "{C:inactive}(Must have room){}"
			}
		    },
	
		    j_nflame_miafey = {
		        name = "Mia Fey",
			text = {
			    "When {C:attention}Ghost Cards{} are played and unscored",
			    "{C:attention}Scored Cards{} gain the {C:white,X:mult}XMult{}",
			    "of the {C:attention}Ghost Cards{}"
			}
		    },
	
		    j_nflame_potatorevenge = {
		        name = "Cold Potato",
			text = {
			    "{C:attention}You aren't ready for this joker{}.",
			    "It is so {C:blue,E:1}#1#{}.",
			    "{s:1.2,C:red}IT WILL BLOW YOUR MIND{}.",
			    "It gets {E:1}better over time{}, too!",
			    "{C:inactive}(Currently #2#){}",
			    "{s:0.8,C:inactive}idea by astro{}",
			}
		    },
	
	        j_nflame_genplanet = {
	           name = "Blind Telescope",
	           text = {
	              "All hands are scored as {C:attention}Poker Hand All{}",
	              "All hand level ups also level {C:attention}Poker Hand All{}"
	           }
	        },
	
	        j_nflame_bakerfool = {
	           name = "Bakers Dozen",
	           text = {
	              "When {C:attention}Booster Pack{} is opened",
	              "create the {C:attention}default card{} for the set"
	           }
	        },
	
	        j_nflame_sappy = {
	           name = "Sappy",
	           text = {
	              "Discarded cards are {C:attention}drawn back to hand{}",
	              "with a bonus {C:white,X:mult}X#1#{} mult when held in hand",
	              "Draw an extra card for each discarded card"
	           }
	        },

			j_nflame_refund = {
				name = "Money Back Guarantee",
				text = {
				  "Sold consumables have a",
				  "{C:green}#1# in #2#{} chance to {C:attention}create a card{}",
				  "of the same {C:tarot}type{}",
				  "{C:inactive}(Cannot work twice){}"
				}
			},

			j_nflame_rapdog = {
				name = "PaRappa",
				text = {
					{"Gains {C:white,X:mult}X#1#{} if the {C:attention}first card{}",
					"this hand has the same {C:attention}rank{} as",
					"the card {C:attention}most recently{} scored",
					"{C:inactive}(Rank #3#, {C:white,X:mult}X#4#{C:inactive} Mult)",},
					-- "and hand contains {C:attention}two ranks{}",
					{"Triggers {C:attention}#2#{} times",
					"{C:inactive}oops- oops- oops- oops{}"},
				}
			}
	},
	Enhanced = {
	    m_nflame_snow = {
	        name = "Snow Card",
	        text = {
		    "Gains {C:mult}+#1#{} Mult {C:attention}permanently{}",
		    "for each {C:attention}Snow Card{} in hand",
		    "at end of round"
		}
	    },

	    m_nflame_rules = {
	        name = "Rouxls Kaard",
		text = {
		    "Decreases {C:attention}Blind Requirement{} by {C:attention}#1#%{}",
		    "{C:green}#2# in #3#{} chance to {C:attention}disable boss blind{}",
		    "{C:inactive,s:0.8}Thou thought me a {C:inactive,E:1,s:0.8}fool{C:inactive,s:0.8}, didest thou?",
		    "{C:inactive,E:1,s:0.8}Worms{C:inactive,s:0.8}, if thereseth one thingeth I'm {C:red,s:0.8}NOT{},",
		    "{C:inactive,s:0.8}its a {C:red,E:1}COURTETH JESTER.{}"
		}
	    },
	},

	Tarot = {
	    c_nflame_frost = {
	        name = "The Frost",
		text = {
		    "Enhances {C:attention}#1#{}",
		    "selected cards to",
		    "{C:attention}#2#{}"
		}
	    },
	    c_nflame_trabant = {
	        name = "The Trabant",
		text = {
		    "Enhances {C:attention}#1#{}",
		    "selected cards to",
		    "{C:attention}#2#{}"
		}
	    }
	}
    },

    misc = {
    	 challenge_names = {
	     c_nflame_moderntech = "Day-One Patches"
	 },

	 poker_hands = {
	     nflame_generic = "Poker Hand All"
	 },

	 poker_hand_descriptions = {
	     nflame_generic = { "Any cards." }
	 }
    }
}
