return {
    descriptions = {
        Joker = {
			j_buf_abyssalp = {
				name = "Abyssal Prism",
				text = {"Upon {C:attention}acquiring{} this joker, spawn an {C:buf_spc}Echo{}",
						"and {C:attention}exile{} all others. One becomes {C:dark_edition}Negative{}",
						"each 3 turns. Sell to return jokers",
						"{C:inactive}(#2#/3 Rounds. #1# negative Joker(s)){}",
						"{C:inactive,s:0.7}Must have room{}"
				}
			},
			j_buf_abyssalecho = { -- Special (Abyssal Prism)
				name = "Echo of The Abyss",
				text = {"Gives {C:mult}+#2#{} Mult",
						"for each Joker inside",
						"the {C:attention}Abyssal Prism{}",
						"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}",
						"{C:inactive,s:0.6}Destroyed when Abyssal Prism is removed{}"
				},
				unlock = {"Acquire an",
						"{C:attention}Abyssal Prism",
				}
			},
			j_buf_afan = {
				name = "Adoring Fan",
				text = {"{C:mult}+#1#{} Mult",
						"Costs {C:money}$6{} to be {C:attention}sold{}",
						"{C:green}#2# in #3#{} chance to {C:attention}return{}",
						"after being {C:attention}sold{}",
						"{C:buf_spc,s:0.7}Rejection-sensitive{}"}  
			},
			j_buf_afan_spc = {
				name = "Bitter Ex-Fan",  -- Special (Adoring Fan)
				text = {"Flips and shuffles all {C:attention}Jokers{} or",
						"{C:attention}playing cards{} each hand, at random",
						"Costs {C:money}$25{} to be sold",
						"In {C:attention}#1#{} rounds, sell price becomes positive",
				},
				unlock = {"Solve the {E:1,C:buf_spc}special{}",
						"requirement of",
						"{C:attention}Adoring Fan"
				}  
			},
			j_buf_argument = {
				name = "Pertinent Argument",
				text = {"Converts an unscored",
						"card into one of",
						"the scored ones, if",
						"{C:attention}poker hand{} is a {C:attention}Two Pair{}"
				}  
			},
			j_buf_cashout = {
				name = "Cashout Voucher",
				text = {"If {C:attention}winning hand{} triples the Blind's",
					"score {C:attention}requirement{}, earn 0.4% of it",
					"as {C:money}money{} and destroy this Joker",
					"{C:inactive}(Max of{} {C:money}$50{}{C:inactive}){}"
				}
			},
			j_buf_clays_alt = {
				name = "Clay Shooting",
				text = {"Earn {C:money}$#1#{} at",
						"end of round",
						"if you win in",
						"exactly {C:attention}#2#{} Hands",
						"{C:inactive,s:0.7}Changes each round{}"
				}
			},
			j_buf_clays = {
				name = "Clay Shooting",
				text = {"Earn {C:money}$#1#{} at",
						"end of round if you",
						"win in a specified",
						"number of hands",
						"{C:inactive,s:0.7}(Changes each round){}"
				}
			},
			j_buf_clown = {
				name = "Clown",
				text = {"This Joker gains {C:chips}+#1#{} Chips",
						"when another Joker is added",
						"{C:inactive}(Currently{} {C:chips}+#2#{} {C:inactive}Chips){}",
						"{C:buf_spc,s:0.7}Especially enjoys his own company{}"
				}
			},
			j_buf_van_alt = {
				name = "Van", -- Special (Clown) [ALT]
				text = {"This Joker gains {C:chips}+#1#{} Chips",
						"when another Joker is added",
						"{C:inactive}(Currently{} {C:chips}+#2#{} {C:inactive}Chips){}",
						"{C:inactive,s:0.7}Fits infinite Clowns{}"
				}
			},
			j_buf_van = {
				name = "Van", -- Special (Clown)
				text = {"This Joker gains {C:chips}Chips{}",
						"when another Joker is added",
						"Amount depends on how",
						"many {C:attention}Clowns{} are inside",
				},
				unlock = {"Solve the {E:1,C:buf_spc}special{}",
						"requirement of",
						"{C:attention}Clown"
				}
			},
			j_buf_denial = {
				name = "Arstotzkan Denial",
				text = {"{C:mult}+5{} Mult or {C:chips}+30{} Chips",
						"for each {C:red}Red{} or {C:blue}Blue{} seal",
						"in full deck, {C:attention}respectively{}",
						"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult /{} {C:chips}+#2#{} {C:inactive}Chips){}",
						}
			},
			j_buf_dorkshire = {
				name = "Dorkshire Tea",
				text = {"All {C:attention}2s{}, {C:attention}3s{} and {C:attention}10s{} become",
						"{C:attention}Porcelain Cards{} before",
						"scoring, if {C:attention}poker hand{}",
						"is a {C:attention}Three of a Kind{}",
				}
			},
			j_buf_dorkshire_alt = {
				name = "Dorkshire Tea",
				text = {"{C:attention}2s{}, {C:attention}3s{}, {C:attention}10s{}, {C:attention}12s{}, {C:attention}13s{}, {C:attention}21s{} and {C:attention}25s{}",
						"become {C:attention}Porcelain Cards{} before",
						"scoring, if {C:attention}poker hand{}",
						"is a {C:attention}Three of a Kind{}",
				}
			},
			j_buf_dorkshire_g = { -- Special (Dorkshire Tea) 
				name = "Dorkshire Gold",
				text = {"All {C:attention}2s{}, {C:attention}3s{} and {C:attention}10s{} become",
						"{C:buf_spc}Royal Porcelain Cards{} before",
						"scoring if poker hand",
						"is a {C:attention}Three of a Kind{}",
				},
				unlock = {"Start a run",
						"with {C:attention}Porcelain Deck",
						"and {C:attention}Porcelain Sleeve"
				}
			},
			j_buf_dorkshire_g_alt = { -- Special (Dorkshire Tea) [ALT]
				name = "Dorkshire Gold",
				text = {"{C:attention}2s{}, {C:attention}3s{}, {C:attention}10s{}, {C:attention}12s{}, {C:attention}13s{}, {C:attention}21s{} and {C:attention}25s{}",
						"become {C:buf_spc}Royal Porcelain Cards{} before",
						"scoring if poker hand",
						"is a {C:attention}Three of a Kind{}",
				},
				unlock = {"Start a run",
						"with {C:attention}Porcelain Deck",
						"and {C:attention}Porcelain Sleeve"
				}
			},
			j_buf_fivefingers = {
				name = "Five Fingers",
				text = {"{X:mult,C:white}X#1#{} Mult if you own a",
						"multiple of {C:attention}5 Jokers{}",
						"and scored hand",
						"has exactly {C:attention}5 cards{}"
				}
			},
			j_buf_gfondue = {
				name = "Gold Fondue",
				text = {
					{"On first hand of round,",
					"this card is {C:red}eaten{}"},
					{"Convert {C:attention}3 scored cards{}",
					"into {C:strawberry}Strawberry Cards{}"},
					{"Scored cards give {C:money}$#1#"},
				}
			},
			j_buf_camarosa = {
				name = "Camarosa",
				text = {
					{"{C:strawberry}Strawberry Cards{} held in",
					"hand give {C:white,X:mult}X#1#{} Mult"},
					{"{C:green}#2# in #3#{} chance this",
					"card is destroyed",
					"at end of round"}
					},
			},
			j_buf_kerman = {
				name = "Jebediah Kerman",
				text = {"Gains {C:mult}+#2#{} Mult every time",
						"any {C:planet}Planet{} card is used",
						"{C:green}#4# in #3#{} chance to {C:attention}EXPLODE{} on use",
						"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}",
						"{C:buf_spc,s:0.7}Scared of singularities{}",
				}
			},
			j_buf_kerman_spc = { -- Special (Jebediah Kerman)
				name = "Jebediah Reborn",
				text = {"Gains {C:mult}+#2#{} Mult every time",
						"any {C:planet}Planet{} card is used",
						"{C:spectral}Black Hole{} gives {C:attention}#3#%{} of total Mult",
						"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}",
				},
				unlock = {"Solve the {E:1,C:buf_spc}special{}",
						"requirement of",
						"{C:attention}Jebediah Kerman"
				}
			},
			j_buf_jokergebra = {
				name = "JokerGebra",
				text = {"Gives {C:attention}five times{}",
						"the amount of {C:mult}Mult{}",
						"given by the Joker",
						"to the {C:attention}left{} as {C:chips}Chips{}",
						"{C:buf_spc,s:0.7}#1# XMult!{}"
				}
			},
			j_buf_integral = { -- Special (JokerGebra)
				name = "Integral",
				text = {"Gives {X:expchips,C:white}^0.02{} Chips",
						"per {X:mult,C:white}X1{} Mult",
						"triggered before this",
						"Joker each hand",
				},
				unlock = {"Solve the {E:1,C:buf_spc}special{}",
						"requirement of",
						"{C:attention}JokerGebra"
				}
			},
			j_buf_korny = {
				name = "Korny Joker",
				text = {
					{"{C:white,X:mult}X#1#{} Mult during {C:attention}Small Blind{}",
					"{C:white,X:mult}X#2#{} Mult during {C:attention}Big Blind{}",
					"{C:white,X:mult}X#3#{} Mult during {C:attention}Boss Blind{}"},
					{"{C:green}Unknown{} chance to {C:red}explode",
					"at the end of round",
					"{C:inactive,s:0.7}You don't know the chances...{}"}
				}
			},
			j_buf_laidback = { 
				name = "Laidback Joker",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"Occupies 2 slots",
				},
			},
			j_buf_lemmesolo = { 
				name = "Let Me Solo Her",
				text = {
					"{C:mult}+#1#{} Mult, {C:mult}debuffed{} if not alone",
					"When a {C:attention}Boss Blind{} is defeated,",
					"create #2# random Jokers with at",
					"least #3# {C:mult}Rares{} and destroy this one",
				},
			},
			j_buf_maggit = { 
				name = "Maggit",
				text = {
					"{X:expmult,C:white}^#1#{} Mult if you own a",
					"{C:dark_edition}Nu Metal{} Joker. Otherwise,",
					"{C:attention}only once{}, create one",
					"when {C:attention}Blind{} is selected{}",
					"{C:inactive,s:0.7}(Must have room){}",
				},
				unlock = {'{E:1,s:1.3}?????'}
			},
			j_buf_maggit_alt = { 
				name = "Maggit",
				text = {
					"{X:expmult,C:white}^#1#{} Mult if you own a",
					"{C:dark_edition}Nu Metal{} Joker. Otherwise,",
					"{C:attention}only once{}, create one",
					"when {C:attention}Blind{} is selected{}",
					"{C:inactive,s:0.7}(Already created){}",
				},
			},
			j_buf_memcard = {
				name = "Memory Card",
				text = {"Memorizes the {C:attention}first{} scored card each {C:attention}round{}",  
						"up to {C:attention}8{} times. Sell to convert a card in",
						"hand into each memorized card, {C:attention}in order{}",
						"{C:inactive}Memorized #1#. Last: #3#{}{C:inactive}#2#{}",
						}
			},
			j_buf_dxmemcard = { -- Special (Memory Card)
				name = "Deluxe Memory Card",
				text = {"Memorizes the {C:attention}first{} scored card each {C:buf_spc}hand{}",  
						"up to {C:buf_spc}16{} times. Sell to convert a card in",
						"hand into each memorized card, {C:attention}in order{}",
						"{C:inactive}Memorized #1#. Last: #3#{}{C:inactive}#2#{}",
				},
				unlock = {"Start a run",
						"with {C:attention}JimboStation Deck",
						"and {C:attention}JimboStation Sleeve"
				}
			},
			j_buf_patronizing = {
				name = "Patronizing Joker",
				text = {"{X:chips,C:white}X#1#{} Chips",
						"{C:attention}Forces{} 5 cards to",
						"always be {C:attention}selected{}",
						"{C:buf_spc,s:0.7}Wants you to play a #2#{}"
				}
			},
			j_buf_supportive = { -- Special (Patronizing Joker)
				name = "Supportive Joker", 
				text = {"{X:chips,C:white}X#1#{} Chips",
						"Tells you the top",
						"3 cards in deck",
						"during the round"
				},
				unlock = {"Solve the {E:1,C:buf_spc}special{}",
						"requirement of",
						"{C:attention}Patronizing Joker"
				}
			},
			j_buf_supportive_alt = { -- Special (Patronizing Joker)[ALT]
				name = "Supportive Joker", 
				text = {"{X:chips,C:white}X#7#{} Chips",
						"{s:0.8}#1##4#{}",
						"{s:0.8}#2##5#{}",
						"{s:0.8}#3##6#{}",
				}
			},
			j_buf_porcelainj = {
				name = "Porcelain Joker",
				text = {"Gives {X:chips,C:white}X#2#{} Chips",
						"for every {C:attention}3 Porcelain Cards{}",
						"in your {C:attention}full deck{}",
						"{C:inactive}(Currently{} {X:chips,C:white}X#1#{} {C:inactive}Chips){}"
				}
			},
			j_buf_rerollin = {
				name = "Rerollin'",
				text = {"Earn {C:money}$#1#{} for",          
						"your fifth {C:green}reroll{}",
						"once per shop",
						"{C:inactive}({}{C:green}#3#{}{C:inactive} rerolls left){}"}
			},
			j_buf_roulette = {
				name = "Russian Roulette",
				text = {"When {C:attention}Blind{} is selected, earn {C:money}$#3#{}",          
						"{C:green}#1# in #2#{} chance you {E:1,C:mult}lose the game{} instead",
						"If chance reaches {C:green}#1# in 2{} and you win,",
						"create a random {C:legendary}Legendary{} Joker",
						"{C:inactive,s:0.7}(Chance and payout increase each round)"
				}
			},
			j_buf_sayajimbo = {
				name = "Sayajimbo",
				text = {"{C:chips}+#1#{} Chips",
						"Score at least {C:attention}#2#{} in one",
						"hand to {C:attention}transform{}",
						"{C:inactive}(Next level: {C:mult}+20{C:inactive} Mult)",
				}
			},
			j_buf_sayajimbo_s1 = {
				name = "Super Sayajimbo",
				text = {"{C:mult}+#1#{} Mult",
						"Score at least {C:attention}#6#{} in one",
						"hand #5# times to {C:attention}transform{}",
						"{C:inactive}(#4#/#5#, Next level: {X:mult,C:white}X3{C:inactive} Mult)",
				}
			},
			j_buf_sayajimbo_s2 = {
				name = "Super Sayajimbo 2",
				text = {"{X:mult,C:white}X#2#{} Mult",
						"Score at least {C:attention}#6#{} in one",
						"hand #5# times to {C:attention}transform{}",
						"{C:inactive}(#4#/#5#, Next level: {X:expmult,C:white}^1.3{C:inactive} Mult)",
				}
			},
			j_buf_sayajimbo_s3 = {
				name = "Super Sayajimbo 3",
				text = {"{X:expmult,C:white}^#3#{} Mult",
						"{C:inactive}Behold!"
				}
			},
			j_buf_tailored = {
				name = "Tailored Suit",
				text = {"Gives {X:mult,C:white}X#1#{} Mult times the",
						"the percentage of cards of the",
						"{C:attention}predominant suit{} in your {C:attention}full deck{}",
						"{C:inactive}(Currently #3#,{} {X:mult,C:white}X#2#{} {C:inactive}Mult){}",
				}
			},
			j_buf_whitepony = {
				name = "White Pony",
				text = {"{C:mult}+#1#{} Mult",
						"Doubles",
						"each {C:attention}Ante{}"
				}
			},
			j_buf_blackstallion = { -- Special (White Pony)
				name = "Black Stallion",
				text = {"{C:mult}+#1#{} Mult",
						"Doubles",
						"each {C:attention}Ante{}"
				},
				unlock = {"Start a run",
						"with the",
						"{C:attention}Galloping Deck"
				}
			},
        },
        Back = {
			b_buf_jstation = {
				name = "JimboStation Deck",
				text = {"Start run with the",
						"{C:red,T:j_buf_memcard}#1#{} Joker",
						"{C:attention}+1{} hand size"
				}
			},
			b_buf_galloping = {
				name = "Galloping Deck",
				text = {"Start run with the",
						"{C:buf_spc,T:j_buf_blackstallion}#1#{} Joker",
				},
				unlock = {"Reach Ante",
						  "level {C:attention}10"
				}
			},
			b_buf_porcelain = {
				name = "Porcelain Deck",
				text = {
					"Start run with a",
					"copy of {C:attention,T:c_buf_nobility}#1#{},",
					"1 less full {C:attention}Suit{},",
					"and a {C:attention,T:tag_vis_divine}Divine Tag"
				},
				unlock = {
					"Use a {C:attention}Brick Card",
					"to break a",
					"{C:attention}Porcelain Card",
				}
			},
			b_buf_sandstone = {
				name = "Sandstone Deck",
				text = {"Win on {C:attention}Ante 6{}",
						"{C:red}X2{} base Blind size"
				},
				unlock = {
					"Win {C:attention}6{} runs with",
					"{C:attention,E:1}Collage{} installed"
				}
			},
        },
        Tarot = {
			c_buf_nobility = {
				name = "Nobility",
				text = {
					{"Enhances {C:attention}#1#{} selected cards",
					"into {C:attention}Porcelain Cards{}"},
					{"If at least {C:money}$#2#{} is held,",
					"{C:attention}Royal Porcelain Cards{} instead"}
				}
			},
        },
        Stake = {
			stake_buf_palladium = {
                name = 'Palladium Stake',
                text = {
                    '{C:attention}Final{} Boss Blinds',
                    'appear {C:attention}twice{} as often',
					'{s:0.8}Applies all previous stakes'
                }
            },
			stake_buf_spinel = {
                name = 'Spinel Stake',
                text = {
                    'The game requires {C:attention}50% more',
					'{C:attention}Antes{} for you to win',
					'{s:0.8}Applies all previous stakes'
                }
            },
        },
        Other = {
		-------- STICKERS --------
			buf_palladium_sticker = {
                name = 'Palladium Sticker',
                text= {
                    'Used this Joker',
                    'to win on {C:attention}Palladium',
                    '{C:attention}Stake{} difficulty'
                }
            },
			buf_spinel_sticker = {
                name = 'Spinel Sticker',
                text= {
                    'Used this Joker',
                    'to win on {C:attention}Spinel',
                    '{C:attention}Stake{} difficulty'
                }
            },
		-------- INFO QUEUE --------
            korny_info = {
                name = "Credit",
                text = {
                    "Original art",
                    "by {C:green}Snakey{}",
                }
            },
			maggit_info = {
				name = "Nu Metal Jokers",
				text = {
					"Clown, Five Fingers",
					"Korny Joker, Rerollin'",
					"and White Pony"
				}
			},
			special_info = {
				name = "Special Joker",
				text = {
					"Normally unobtainable",
					"Given under {E:1,C:buf_spc}special{}",
					"conditions"
				}
			},
			banish_info = {
				name = "Exile",
				text = {
					"Exiled Jokers are",
					"{C:attention}temporarily{} removed and",
					"keep all their upgrades",
					"{C:attention}Eternal{} Jokers can be exiled"
				}
			},
			porc_info = {
				name = "Porcelain Card",
				text = {
						"{X:chips,C:white}X1.75{} Chips, is {C:red}Fragile",
						"{s:0.2} {}",
						"Earn {C:money}$3{} when destroyed"
				}
			},
			porcg_info = {
				name = "Royal Porcelain",
				text = {
						"{X:chips,C:white}X2{} Chips, is {C:red}Fragile{}",
						"and a {C:attention}Face Card",
						"{s:0.2} {}",
						"Earn {C:money}$6{} when destroyed"
				}
			},
			buf_fragile_info = {
				name = "Fragile",
				text = {
					"{C:red}Destroyed{} if played",
					"in a poker hand with",
					"more than {C:attention}3{} cards",
				}
			}
        },
        Sleeve = {
			sleeve_buf_jstation = {
				name = "JimboStation Sleeve",
				text = {"Start run with the",
						"{C:red,T:j_buf_memcard}#1#{} Joker",
						"{C:attention}+1{} hand size"
				}
			},
			sleeve_buf_jstation_alt = {
				name = "JimboStation Sleeve",
				text = {"Start run with the",
						"{C:buf_spc,T:j_buf_dxmemcard}#2#{} Joker instead",
						"{C:attention}+1{} hand size"
				}
			},
			sleeve_buf_galloping = {
				name = "Galloping Sleeve",
				text = {"Start run with the",
						"{C:buf_spc,T:j_buf_blackstallion}#1#{} Joker",
				}
			},
			sleeve_buf_galloping_alt = {
				name = "Galloping Sleeve",
				text = {"Start run with the",
						"{C:green,T:j_buf_whitepony}#2#{} Joker instead",
						"{C:blue}-2{} hands every round"
				}
			},
			sleeve_buf_porcelain = {
				name = "Porcelain Sleeve",
				text = {"Start run with the",
						"{C:red,T:j_buf_dorkshire}#1#{} Joker",
						"and 1 less",
						"full {C:attention}Suit{}"
				}
			},
			sleeve_buf_porcelain_alt = {
				name = "Porcelain Sleeve",
				text = {"Start run with the",
						"{C:buf_spc,T:j_buf_dorkshire_g}#2#{} Joker",
						"and 1 less",
						"full {C:attention}Suit{}"
				}
			},
			sleeve_buf_sandstone = {
				name = "Sandstone Sleeve",
				text = {"Win on {C:attention}Ante 6{}",
						"{C:red}Doubles{} Blind size"
				}
			},
			sleeve_buf_sandstone_alt = {
				name = "Sandstone Sleeve",
				text = {"Win on {C:attention}Ante 5{}",
						"{C:red}X3{} base Blind size"
				}
			},
        },
		Enhanced = {
			m_buf_porcelain = {
				name = "Porcelain Card",
				text = {"{X:chips,C:white}X1.75{} Chips,",
						"is {C:red}Fragile",
						"{s:0.2} {}",
						"Earn {C:money}$3{} when",
						"destroyed"
				}
			},
			m_buf_porcelain_g = {
				name = "Royal Porcelain Card",
				text = {"{X:chips,C:white}X2{} Chips, is {C:red}Fragile{}",
						"and a {C:attention}Face Card",
						"{s:0.2} {}",
						"Earn {C:money}$6{} when destroyed"
				}
			},
		},
    },
    misc = {
		dictionary = {
			-------- CONFIG --------
			buf_cf_info_info = {
				"Precisely: artist credits, special rarity",
				"tooltips and 'Exile' mechanic tooltip",
				"Restart required to take effect",
			},
			buf_cf_req_restart = {
				"3 Jokers & 1 Enchancement",
				"Restart required to take effect",
			},
			buf_cf_show_spc = "Show Special cards in collection",
			buf_cf_show_info = "Show info queue tooltips",
			-------- CREDITS --------
			buf_cr_artcode = "Art and Code",
			buf_cr_localization = "Localization",
			buf_cr_sfx = "Sound Effects",
			buf_cr_misc = "Miscellaneous",
			-------- CARD MESSAGES --------
			buf_korny_ok = "He's ok!",
			buf_korny_dd = "Dead!",
			buf_prism_eor1 = "Torment...",
			buf_prism_eor2 = "+1 Negative!",
			buf_prism_sck = "Begone!",
			buf_memory = "Memorized!",
			buf_memfull = "Memory Full!",
			buf_doubled = "Doubled!",
			buf_convert = "Converted!",
			buf_blowup = "B O O M !",
			buf_ydead = "You're dead...",
			buf_dry = "Dry fire!",		
			buf_afan_annoy1 = "But, but...",
			buf_afan_annoy2 = "Aw, Gee...",
			buf_afan_annoy3 = "You sure?",
			buf_afan_annoy4 = "Please, no!",
			buf_afan_monologue1 = "I WAS your fan!",
			buf_afan_monologue2 = "I liked you!",
			buf_afan_monologue3 = "You WERE my hero!",
			buf_tea = "Tea!",
			buf_gfondue_licked = "Licked!",
			buf_hit = "Hit!",
			buf_miss = "Miss!",
			buf_krakened = "I am Reborn!",
			buf_supergrade = "HUGE Upgrade!",
			buf_disilluison = "Disillusioned!",
			buf_defeated = "Defeated!",
			buf_hopin = "Hop in!",
			buf_patspc = "Nice play!",
			-------- MEMCARD STUFF --------
			buf_ready = "Ready",
			buf_Ace = "Ace",
			buf_Jack = "Jack",
			buf_Queen = "Queen",
			buf_King = "King",
			-- UnStable compat --
			buf_0 = "0",
			['buf_0.5'] = "Half",
			buf_1 = "1",
			buf_r2 = "Root 2",
			buf_e = "e",
			buf_Pi  = "Pi",
			buf_11 = "11",
			buf_12 = "12",
			buf_13 = "13",
			buf_21 = "21",
			buf_25 = "25",
			buf_161 = "161",
			["buf_???"] = "???",
			--------------------
			buf_of = " of ",
			buf_Spades = "Spades",
			buf_Hearts = "Hearts",
			buf_Clubs = "Clubs",
			buf_Diamonds = "Diamonds",
			-- Bunco/Paperback compat --
			buf_Fleurons = "Fleurons",
			buf_Halberds = "Halberds",
			buf_Crowns = "Crowns",
			buf_Stars = "Stars",
			-------- MISC --------
			k_buf_spc = "Special",
			k_buf_notyet = "(Must have room)",
			buf_uniform = "uniform",
		},
		v_dictionary = {
			a_buf_emult = "^#1# Mult",
			a_buf_xchips = "X#1# Chips",
			a_buf_echips = "^#1# Chips",
		},
    },
}