return {
	["misc"] = {
		["dictionary"] = {
			['ui_collage_examplejoker'] = 'The Clown Show',
			['ui_collage_desc1'] = '+8 Chips per Joker',
			['ui_collage_desc2'] = 'purchased this run',
			['ui_collage_desc3'] = '(Currently +0 Chips)',
			['ui_collage_cardtype'] = 'Common',
			['ui_collage_modbadge'] = 'All In Jest*',
			['ui_collage_modwarning'] = 'THANK YOU FOR INSTALLING!',
			['ui_collage_modified1'] = 'Real quick:',
			['ui_collage_modified2'] = 'Collage marks CHANGED content with an * symbol',
			['ui_collage_modified3'] = 'on the mod badge! Example on the left.',
		},
	},
	["descriptions"] = {
		Back = {
			b_black = {
				name = "Black Deck",
				text = {
					"{C:attention}+1{} Joker slot",
					"{C:blue}-1{} hand",
					"every round",
					"{s:0.2} {}",
					"After defeating each",
					"{C:attention}Boss Blind{}, gain {C:money}$1{} for",
					"each open Joker slot"
				}
			}
		},
		art = {
			c_collage_art_blank = {
                name = 'Blank',
                text = {
                    "Copies the next",
                    "used {C:art}Art Card{}"
                }
            },
		},
		Stake = {
			stake_gold = {
				name = "Gold Stake",
				text = {
					'{C:attention}Final{} Boss Blinds',
                    'appear {C:attention}twice{} as often',
					'{s:0.8}Applies all previous stakes'
				}
			},
			stake_blue = {
				name = "Blue Stake",
				text = {
					"Shop can have {C:attention}Perishable{} Jokers",
					"{C:inactive,s:0.8}(Debuffed after 5 Rounds)",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_orange = {
				name = "Orange Stake",
				text = {
					"Shop can have {C:attention}Rental{} Jokers",
					"{C:inactive,s:0.8}(Lose $2-$4 each round)",
					"{s:0.8}Applies all previous Stakes"
				}
			},
		},
		Other = {
			collage_pack_notifier = {
                name = 'Shop booster',
                text = {
                    'May only purchase',
                    '{C:attention}2{} each shop, excluding',
					'{C:attention}free{} boosters',
                    '{C:inactive}(#1# left)'
                }
            },

            collage_voucher_notifier = {
                name = 'Shop voucher',
                text = {
                    'May only purchase',
                    '{C:attention}1{} each ante, except',
                    'from {C:attention}Voucher Tags{}'
                }
            },

			collage_heavyweight_tip = {
				name = '???',
				text = {
					'A {C:attention}Full House{} of',
					'{C:attention}Enhancements{} instead of {C:attention}ranks{},',
					'with at least 2 {C:attention}suitless{} cards'
				}
			},

			collage_petrify_tip = {
				name = "Petrification",
				text = {
					'{C:attention}Face Cards{} become',
					'{C:attention,T:m_artb_marble}Marble Cards{}, numbered cards',
					'become {C:attention}Stone Cards'
				}
			}
		}
	},
}
