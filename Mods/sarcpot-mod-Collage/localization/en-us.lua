return {
    misc = {
        dictionary = {
            sarc_travel_pack = "Travel Pack",


            sarc_combat_roll_ex = "Combat Roll!",
            sarc_plus_one_discard = "+1 Discard!",
            sarc_stolen = "Stolen!",
            sarc_yoink = "Yoink!",
            sarc_lucky6 = "Lucky 6!",
            sarc_focus = "Focus!",
            sarc_scrapped = "Scrapped!",
            sarc_throw = 'Throw!',
            sarc_snap = 'Snap!',
            sarc_collapse = 'Collapse!',
            sarc_exhausted = 'Exhausted...',
            sarc_chips = 'Chips',
            sarc_mult = 'Mult',
            sarc_common = 'Common',
            sarc_uncommon = 'Uncommon',
            sarc_rare = 'Rare',
            sarc_2_random_hands = "2 Random Hands",
            sarc_plus_rerolls = '+3 Rerolls',
            sarc_minus_ante = "-1 Ante",
            sarc_active = "Active",
            sarc_inactive = "Inactive",
            sarc_disabled = "Disabled!",

            sarc_requires_restart = "Restart the game to apply changes",
            sarc_enable_vouchers = "Enable Vouchers",
            sarc_enable_jokers = "Enable Jokers",
            sarc_enable_consumables = "Enable Consumables",
            sarc_enable_decks = "Enable Decks"

            
        },
        v_dictionary = {
            sarc_progress = '#1#/#2#'
        }
    },
    descriptions = {
    Back = {
        b_sarc_travelling = {
        name = "Travelling Deck",
        text = {
            "Start run with the",
            "{C:attention,T:v_sarc_compass}#1#{} Voucher and a",
            "copy of {C:attention,T:c_sarc_haven}Rusted Poster",
            "{s:0.2} {}",
            "{C:attention}+#2#{} consumable slot",
        },
        unlock = {
            "Go back an {C:attention}Ante",
            "using {C:attention}...It's Still You"
        }
      },
    },
        --Blind={},
        --Edition={},
        travel = {
            c_sarc_brittle_hollow = {
                name = 'Tattered Postcard',
                text = {
                    {"Level up {C:attention}#1#{} random hands"},
                    {"After {C:attention}#3#{} uses, instead",
                    "{C:purple}collapse{} into {C:dark_edition}Black Hole",
                    "{C:inactive}(Currently #2#/#3#){}"},
                }
            },
            c_sarc_brutal_orchestra = {
                name = 'Vandalized Conscription',
                text = {
                    --[["{C:attention}Add{} a {C:red}Red{}, {C:blue}Blue{}, {C:purple}Purple{} or {C:gold}Gold{} seal" ,
                    "to {C:attention}#1#{} selected card in your hand",]]
                    "Create a {C:attention}Standard Tag{}",
                }
            },
            c_sarc_celeste = {
                name = 'Postcard from Mt.Celeste',
                text = {
                    "Enhances {C:attention}#1#{} selected",
                    "cards to {C:strawberry}Strawberry Cards{}",
                    "{s:0.8,C:inactive}(Strawberry cards recharge by{}",
                    "{s:0.8,C:inactive}not being played for a round){}"
                }
            },
            c_sarc_chicory = {
                name = 'Coloring Card',
                text = {
                    {"Converts up to {C:attention}#1#{}",
                    "selected cards into",
                    "{C:attention}distinct{} suits"},
                    {"Gain {C:money}$#2#{} per",
                    "card converted"}
                }
            },
            c_sarc_deaths_door = {
                name = 'Grey Memento',
                text = {
                    {"Select up to {C:attention}#1#{} cards"},
                    {"Destroy the leftmost",
                    "to convert the others into",
                    "the destroyed card's {C:attention}suit{}"},
                }
            },
            c_sarc_going_under = {
                name = 'Soulless Marketing',
                text = {
                    {"Create a {C:attention}Voucher Tag{}"},
                    {"Gain {C:money}+#1#${}"}
                }
            },
            c_sarc_greenpath = {
                name = '"View from Greenpath"',
                text = {
                    "Create an {C:uncommon}Uncommon Tag{}",
                }
            },
            c_sarc_haven= {
                name = 'Rusted Poster',
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:blue}Flow Cards{}"
                }
            },
            c_sarc_isaac = {
                name = "Kid's Drawing",
                text = {
                    "{C:green}+#1#{} Free Rerolls"
                }
            },
            c_sarc_kingdom = {
                name = "Monarch's Funds",
                text = {
                    {"Gain {C:money}+#1#${}"},
                    {"{C:money}+$5{} more each use",
                    "{C:inactive}(Max of {C:money}#2#${}{C:inactive}){}"}
                }
            },
            c_sarc_loop_hero = {
                name = 'Memory of a Road',
                text = {
                    {"Destroys up to {C:attention}#1#{}",
                    "random cards in hand"},
                    {"Immediately draw",
                    "replacements from",
                    "the deck"}
                }
            },
            c_sarc_magic_survival = {
                name = 'Wartorn Journal',
                text = {
                    {"Enhances up to {C:attention}#2#{}",
                    "random cards in hand",
                    "with random enhancements"},
                    {"Increases with each ante",
                    "{C:inactive}(Max of #1#){}"}
                }
            },
            c_sarc_obra_dinn = {
                name = 'Morbid Pocketwatch',
                text = {
                    {"Select up to {C:attention}#1#{} cards"},
                    {"Destroy the leftmost",
                    "to convert the others into",
                    "the destroyed card's {C:attention}rank{}"},
                }
            },
            c_sarc_plort = {
                name = 'Pink Plort',
                text = {
                    "{C:money}+#1#${} after hand",
                }
            },
            c_sarc_slay_the_spire = {
                name = '"Top Tips to \nConquer the Spire!"',
                text = {
                    "Creates up to {C:attention}#1#{} {V:1}Travel{} Cards",
                    "{C:inactive}(Must have room){}"
                }
            },
            c_sarc_slime_rancher = {
                name = 'Colorful Brochure',
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:red}Slime Cards{}"
                }
            },
            c_sarc_ultrakill = {
                name = 'Divine Intervention',
                text = {
                    {"Destroy {C:attention}#1#{} selected card"},
                    {"If it has a {C:attention}Seal{}, give it to",
                    "{C:attention}#2#{} random cards in hand"}
                }
            },
            c_sarc_undertale = {
                name = "...It's Still You",
                text = {
                    {"After {C:attention}#3#{} uses, {C:attention}-1 Ante{}",
                    "{C:inactive}(Currently #1#/#3#){}"},
                    {"Required uses increases by {C:attention}#2#{}",
                    "after triggering{}"}
                }
            },
            c_sarc_wildfrost = {
                name = 'Frozen Diary',
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected card to a",
                    "{C:blue}Luminice Card{}"
                }
            },
            
        },
        Enhanced={
            m_sarc_flow= {
                name = 'Flow Card',
                text = {
                    "{X:chips,C:white}X1{} Chips",
                    "+{X:chips,C:white}X0.25{} per scoring",
                    "{C:blue}Flow Card{} to the {C:attention}left{}"
                }
            },
            m_sarc_luminice= {
                name = 'Luminice Card',
                text = {
                    "Always scores,",
                    "no rank or suit",
                    "{s:0.2} {}",
                    "Gives {C:mult}+#1#{} Mult",
                    "to other scored cards",
                }
            },
            m_sarc_slime= {
                name = 'Slime Card',
                text = {
                    "When held in hand,",
                    "{C:green}#1# in #2#{} chance to give {C:money}$2{}",
                    "by creating a {C:attention}Pink Plort{}",
                    "{C:inactive}(Must have room)",
                    "{C:inactive}(Once per round)"
                }
            },
            m_sarc_strawberry = {
                name = 'Strawberry Card',
                text = {
                    "Retriggers {C:attention}#1#{} times",
                    "{s:0.2} {}",
                    "Needs to recharge",
                    "after scoring",
                }
            }
        },
        Joker = {
            j_sarc_garlic_bread = {
                name = 'Garlic Bread',
                text = {
                    "If first hand of round",
                    "is a {C:attention}single card{}",
                    "convert it into an Ace"
                }
            },
             j_sarc_aksnes = {
                name = 'Aksnes',
                text = {
                    "{C:attention}Retrigger{} the first",
                    "{C:clubs}Club{}, {C:hearts}Heart{} and {C:spades}Spade{}",
                    "card in scored hand",
                }
            },
            j_sarc_artemis = {
                name = 'Artemis',
                text = {
                    {"{C:attention}Debuffs{} all {C:hearts}Hearts{} cards"},
                    {"Gives {X:mult,C:white}X#1#{} Mult",
                    "per card debuffed",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult)"}
                }
            },
            j_sarc_beauty_of_the_sea = {
                name = 'Beauty of the Sea',
                text = {
                    {"{C:red}-#1# discard{} on selecting blind"},
                    {"This Joker gains {C:mult}+#2#{} Mult",
                    "every round",
                    "{C:inactive}(Currently {C:mult}+#3#{} {C:inactive}Mult){}"}
                }
            },
            j_sarc_council_of_shadows = {
                name = 'Council of Shadows',
                text = {
                    {"{C:attention}-#1#{} hand size"},
                    {"{C:white,X:money}X#2#{} interest"},
                }
            },
            j_sarc_cracked_egg = {
                name = 'Cracked Egg',
                text = {
                    "When sold, transform joker",
                    "to the right into",
                    "a {C:attention}#1#{} Joker",
                    "Rarity increases every",
                    "{C:attention}Boss Blind{} defeated",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/2)"
                }
            },
            j_sarc_crash_message = {
                name = 'Crash Message',
                text = {
                    "Gives {C:mult}+#1#{} Mult for each",
                    "{C:attention}Rankless{} card in your deck",
                    "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult){}"
                }
            },
            j_sarc_diversity = {
                name = 'Diversity',
                text = {
                    "{C:mult}+#1#{} Mult per suit with",
                    "{C:attention}#2#{} cards or more in your deck",
                    "{C:inactive}(Currently {C:mult}+#3#{} {C:inactive}Mult){}",
                }
            },
            j_sarc_double_crescent = {
                name = 'Double Crescent',
                text = {
                    "If your hand contains a {C:attention}Pair{},",
                    "{C:green}#1# in #2#{} chance",
                    "to generate a {C:planet}Planet{} card",
                }
            },
            j_sarc_green_carnation = {
                name = 'Green Carnation',
                text = {
                    "Scored Kings", 
                    "give {C:chips}+#1#{} Chips for every",
                    "previously scored King"
                }
            },
            j_sarc_halbschwert = {
                name = "Halbschwert",
                text = {
                    "This Joker gives {X:mult,C:white}X#1#{} Mult",
                    "after you use {C:attention}10{} {C:planet}Planet{} cards",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#3#{}"
                }
            },
            j_sarc_inventor_dice_travel = {
                name = 'Inventor Dice',
                text = {
                    "Destroy a consumable when",
                    "exiting the shop to create a",
                    "{C:tarot}Tarot{}, {C:planet}Planet{} or {V:1}Travel{} Card",
                    "{C:green}#1# in #2#{} to gain a {C:spectral}Spectral{} Card instead",
                }
            },
            j_sarc_inventor_dice_no_travel = {
                name = 'Inventor Dice',
                text = {
                    "Destroy a consumable when",
                    "exiting the shop to create a",
                    "{C:tarot}Tarot{} or {C:planet}Planet{} card",
                    "{C:green}#1# in #2#{} to gain a {C:spectral}Spectral{} Card instead",
                }
            },
            j_sarc_jester_dice = {
                name = 'Jester Dice',
                text = {
                    "{C:green}#1# in #2#{} chance to gain",
                    "{C:blue}+1{} hand when playing or discarding",
                    "cards with {C:attention}matching ranks{}"
                }
            },
            j_sarc_labrys = {
                name = 'Labrys',
                text = {
                    "Scored Queens",
                    "give {C:mult}+#1#{} Mult for every",
                    "previously scored Queen"
                }
            },
            j_sarc_lil_guy = {
                name = "Lil' Guy",
                text = {
                    "{C:blue}-#1# Hand{} on selecting blind,",
                    "This Joker gains {C:chips}+#2#{} Chips",
                    "every round",
                    "{C:inactive}(Currently {C:chips}+#3#{} {C:inactive}Chips){}"
                }
            },
            j_sarc_none_of_the_above = {
                name = 'None of the Above',
                text = {
                    "{C:attention}Wild Cards{} have a {C:green}#1# in #2#{} chance",
                    "to give: {C:mult}+#3#{} Mult, {C:chips}+#4#{} Chips,",
                    "{C:money}+#5#${} or {X:mult,C:white}X#6#{} Mult",
                    "{C:inactive}(Multiple effects may trigger)"
                }
            },
            j_sarc_orchid = {
                name = 'Orchid',
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult per",
                    "hand played with a",
                    "scoring {C:attention}Jack{}",
                    "{C:inactive}(Currently {C:mult}+#2#{}{C:inactive} Mult){}"
                }
            },
            j_sarc_pancake = {
                name = 'Pancake',
                text = {
                    "After playing the next {C:attention}#2#{} hands,",
                    "convert all cards played to {C:attention}Wild Cards{}",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)"
                }
            },
            j_sarc_phase_shift = {
                name = 'Phase Shift',
                text = {
                    "Played {V:1}#1#{} and {V:2}#2#",
                    "Balance {C:attention}#3#%{} of {C:mult}Mult{} and {C:chips}Chips{}",
                    "when {C:attention}scored{}",
                  
                
                }
            },
            j_sarc_robot_dice = {
                name = 'Robot Dice',
                text = {
                    "This Joker gains {C:mult}#5#{} Mult when",
                    "{C:attention}played hand{} value adds to {C:attention}#3#{}",
                    "{C:green}#1# in #2#{} to increase mult by {C:attention}6{} times more",
                    "{C:inactive}(Currently {C:mult}#4#{} {C:inactive}Mult,{}",
                    "{C:inactive}Value Changes every hand){}"
                }
            },
            j_sarc_rocky_geode = {
                name = 'Rocky Geode',
                text = {
                    "Gives Mult equal to the number of",
                    "{C:hearts}Hearts{} and {C:attention}Stone{} Cards in your deck",
                    "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult){}"
                }
            },
            j_sarc_strange_fluid = {
                name = "Strange Fluid",
                text = {
                    {"{C:chips}#1#{} #2# {C:mult}#3#{} #4#"},
                    {"Effect changes",
                    "based on whether",
                    "{C:blue}Hands{} or {C:red}Discards{} are higher"}
                }
            },
            j_sarc_stray_pixel = {
                name = "Stray Pixel",
                text = {
                    "When obtained, gains",
                    "{C:dark_edition}Polychrome{} edition",
                    "if it doesn't have an edition",
                }
            },
            j_sarc_sunflower = {
                name = "Sunflower",
                text = {
                    "After skipping a blind",
                    "{C:attention}disable{} the {C:attention}Boss Blind{}",
                    "{C:inactive}(#1#){}"
                }
            },
            j_sarc_terrarrium = {
                name = 'Terrarrium',
                text = {
                    {
                        "{C:attention}+#3#{} consumable slot"
                    },
                    {
                    "{X:mult,C:white}X#1#{} Mult for each",
                    "{C:attention}unique{} consumable",
                    "you have",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{} {C:inactive}Mult){}"
                    }
                }
            },
            j_sarc_thief_dice = {
                name = 'Thief Dice',
                text = {
                    
                        "{C:green}#1# in #2#{} chance to gain a",
                        "{C:dark_edition}negative perishable common{} Joker",
                        "or a random {C:attention}consumable{}",
                        "when exiting the shop",
                        "{C:inactive}(Multiple effects may trigger)"
                    
                }
            },
            j_sarc_warrior_dice = {
                name = 'Warrior Dice',
                text = {
                    {
                        "{C:green}#1# in #2#{} chance to gain ",
                        "a {C:green}reroll{} when {C:attention}discarding{}",
                    },
                    {
                        "{C:green}#1# in #2#{} chance to gain a {C:attention}temporary",
                        "discard{} when {C:green}rerolling{}", 
                    }
                    
                }
            },
            j_sarc_watermelon_candy = {
                name = 'Watermelon Candy',
                text = {
                    "{C:white,X:mult}X#1#{} Mult",
                    "Consumed after",
                    "{C:attention}#2#{} round(s)"
                    
                }
            },
            j_sarc_welch = {
                name = 'Welch',
                
                text = {
                    {
                    "Unenhanced cards give {C:mult}+#1#{} Mult",
                    "for every {C:attention}enhanced card in{}",
                    "scored hand"
                    },
                    {
                    "Enhanced cards give {C:mult}+#1#{} Mult",
                    "for every {C:attention}unenhanced card in{}",
                    "scored hand"
                    }
                }
            },
            j_sarc_witch_dice = {
                name = 'Witch Dice',
                text = {
                    "{C:green}#1# in #2#{} chance to add",
                    "{C:chips}#3#{} Chips when playing or",
                    "discarding a card",
                    "{C:inactive}(Currently {C:chips}#4#{} {C:inactive}Chips){}"
                }
            },
        },
        Tag = {
            tag_sarc_cardinal = {
                name = "Cardinal Tag",
                text = {
                    "Gives a free",
                    "{V:1}Mega Travel Pack{}"
                }
            }
        },
        Voucher = {
            v_sarc_advantage = {
                name = 'Advantage',
                text = {
                    "{X:green,C:white}X1.5{} to all listed probabilities"
                },
            },
            v_sarc_nat_20 = {
                name = 'Nat 20!',
                text = {
                    "{X:green,C:white}X2{} to all listed probabilities"
                },
            },
             v_sarc_compass = {
                name = 'Compass',
                text = {
                    "Create a {V:1}Cardinal Tag{} after",
                    "defeating the {C:attention}Boss Blind{}"
                },
                unlock = {
                    "Open a",
                    "{C:attention}Travel Pack{}"
                }
            },
            v_sarc_journey= {
                name = 'Journey',
                text = {
                    "{V:1}Travel{} cards now appear",
                    "in the shop"
                },
            }
        },
        Other = {
            sarc_strawberry_deactivated = {
                name = "Deactivated",
                text = {
                    "Don't play this card",
                    "for {C:attention}1{} round to",
                    "recharge it"
                },
            },
            collage_slime_info = {
                name = "Fed",
                text = {
                    "Cannot make",
                    "another {C:attention}Plort{}",
                    "this round"
                },
            },
            sarc_collapse_tip = {
                name = "Collapsing...",
                text = {
                    "Destroys itself to",
                    "give a {C:spectral}Black Hole{}"
                },
            },
        p_sarc_travel_small = {
            name = "Travel Pack",
            text = {
              "Choose {C:attention}#1#{} of up to {C:attention}#2#",
              "{C:G.SP.C.travel_1}Travel{} cards to use",
              
            },
        },
         p_sarc_travel_jumbo= {
                name = "Jumbo Travel Pack",
                text = {
                  "Choose {C:attention}#1#{} of up to {C:attention}#2#",
                  "{C:G.SP.C.travel_1}Travel{} cards to use",
                  
                }
              },
            p_sarc_travel_mega= {
                name = "Mega Travel Pack",
                text = {
                  "Choose {C:attention}#1#{} of up to {C:attention}#2#",
                  "{C:G.SP.C.travel_1}Travel{} cards to use",
                  
                }
              },
},
    --achievement_descriptions={},
    -- achievement_names={},
    --blind_states={},
    -- challenge_names={},
    -- collabs={},
    --high_scores={},
    -- labels={},
    -- poker_hand_descriptions={},
    --  poker_hands={},
    --  quips={},
    --  ranks={},
    -- suits_plural={},
    -- suits_singular={},
    --  v_dictionary={},
    -- v_text={},
    --},
}
    }
