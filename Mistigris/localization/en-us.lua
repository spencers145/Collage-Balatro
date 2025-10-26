return {
    descriptions = {
        --- Decks
        Back = {
            b_mstg_temp = {
                name = "Temp Deck",
                text = {
                    "Allan please add details",
                }
            },
            b_mstg_tribute = {
                name = "Tribute Deck",
                text = {
                    "Every card is a",
                    "{C:attention}10{} of {C:spades}Spades{}"
                }
            },
            b_mstg_zany = {
                name = "Zany Deck",
                text = {
                    "{C:attention}Mistigris{} content is",
                    "{C:attention}3X{} more likely to appear"
                }
            },
            b_mstg_burning = {
                name = "Burning Deck",
                text = {
                    "{C:attention}+#1#{} Joker slots",
                    "{C:red}#2#{} Hand size",
                    "After round ends, {C:attention}destroy{} one",
                    "random card {C:attention}held in hand{}"
                }
            },
            b_mstg_plaid = {
                name = "Plaid Deck",
                text = {
                    "Start run with",
                    "{C:attention}26{C:clubs} Clubs{} and",
                    "{C:attention}26{C:diamonds} Diamonds{} in deck",
                },
            },
        },
        --- Blinds
        Blind = {
            bl_mstg_journey = {
                name = "The Journey",
                text = {
                    "Base hand score",
                    "must not be less",
                    "than previous",
                },
            },
            bl_mstg_joy = {
                name = "The Joy",
                text = {
                    "Jokers are",
                    "re-arranged using",
                    "the order from",
                    "the Collection"
                },
            },
            bl_mstg_day = {
                name = "The Day",
                text = {
                    "Held-in-hand",
                    "effects are",
                    "disabled",
                },
            },
            bl_mstg_yew = {
                name = "The Yew",
                text = {
                    "#1# in #2# cards",
                    "drawn face down,",
                    "flip after hand",
                    "is played"
                },
            },
            bl_mstg_elk = {
                name = "The Elk",
                text = {
                    "Playing a #1#",
                    "shatters played cards"
                }
            },
            bl_mstg_birch = {
                name = "The Birch",
                text = {
                    "Hands won't score",
                    "until you use",
                    "(one of) your",
                    "least played one(s)",
                }
            },
        },
        Edition = {},
        Enhanced = {},
        --- Jokers
        Joker = {
            --- Temporary Joker! Used for testing code and stuff
            j_mstg_allan = {
                name = "Allan please add details",
                text = {
                    "Allan please add details",
                },
            },
            --- Common
            j_mstg_diminishing_returns = {
                name = "Diminishing Returns",
                text = {
                    "{C:mult}+#1#{} Mult minus",
                    "{C:mult}-#2#{} Mult for each",
                    "card in played hand",
                },
            },
            j_mstg_peeking = {
                name = "Peeking Joker",
                text = {
                    "{C:mult}+#1#{} Mult if this is",
                    "the {C:attention}rightmost Joker{}"
                },
            },
            j_mstg_timesheet = {
                name = "Timesheet",
                text = {
                    "Earn {C:money}$#1#{} every time",
                    "a playing card is {C:attention}retriggered{}"
                },
            },
            j_mstg_up_to_eleven = {
                name = "Up To 11",
                text = {
                    "{C:attention}10{}s and {C:attention}Aces{}",
                    "are considered",
                    "{C:attention}face{} cards",
                },
            },
            j_mstg_paper_shredder = {
                name = "Paper Shredder",
                text = {
                    "If a card is {C:attention}debuffed{},",
                    "destroy it after scoring"
                },
            },
            j_mstg_losing_ticket = {
                name = "Losing Ticket",
                text = {
                    "Earn {C:money}$#2#{} when failing",
                    "{C:attention}#1#{}",
                },
            },
            j_mstg_feral = {
                name = "Feral Joker",
                text = {
                    "Adds one {C:attention}Wild{} card",
                    "to deck when",
                    "{C:attention}Blind{} is selected",
                },
            },
            j_mstg_jenga = {
                name = "Jenga",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:green}#2# in #3#{} chance to {C:attention}reset{}",
                    "Add {C:mult}+#4#{} Mult and",
                    "increase chance by {C:green}#5#{}",
                    "before scoring"
                },
            },
            j_mstg_sacrifice = {
                name = "Sacrifice",
                text = {
                    {"{X:mult,C:white} X#1# {} Mult"},
                    {"{C:attention}Destroys{} another",
                    "Joker if sold"},
                },
            },
            j_mstg_emergency = {
                name = "Emergency",
                text = {
                    "During the {C:attention}final hand{}",
                    "of a round, {C:attention}retrigger{}",
                    "all scoring {C:attention}Glass{} cards",
                    "and then {C:attention}break them{}"
                }
            },
            j_mstg_wallflower = {
                name = "Wallflower",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if this is",
                    "the {C:attention}leftmost Joker{}"
                }
            },
            j_mstg_diverse_portfolio = {
                name = "Diverse Portfolio",
                text = {
                    "Earn {C:money}$#1#{} if",
                    "no hand types are",
                    "{C:attention}repeated{} this round"
                }
            },
            --- Uncommon
            j_mstg_sleepy = {
                name = "Napping Joker",
                text = {
                    "Stores {X:mult,C:white} X#1# {} Mult",
                    "at the end of",
                    "the round, sell",
                    "to create",
                    "{C:attention}#2#{}",
                    "{C:inactive}(Will have {X:mult,C:white} X#3# {C:inactive} Mult)",
                },
            },
            j_mstg_awake = {
                name = "Awake Joker",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                },
            },
            j_mstg_boulder = {
                name = "Boulder",
                text = {
                    "{C:attention}+#1#{} free {C:green}Reroll{} every",
                    "time you leave a shop",
                    "without {C:attention}rerolling{}",
                    "{C:inactive}(Max of {C:green}#2#{C:inactive} Rerolls)",
                    "{C:inactive}(Currently {C:green}#3#{C:inactive} Rerolls)",
                },
            },
            j_mstg_comedian = {
                name = "Comedian",
                text = {
                    "Retrigger",
                    "each played",
                    "{C:attention}#1#{}, {C:attention}#2#{}, {C:attention}#3#{}, or {C:attention}#4#{}",
                },
            },
            j_mstg_banana_factory = {
                name = "Banana Factory",
                text = {
                    "Guarantees a {C:attention}#1#{}",
                    "in the next shop",
                    "{C:inactive}(If not owned){}",
                },
            },
            j_mstg_medusa = {
                name = "Medusa",
                text = {
                    "All played {C:attention}face{} cards",
                    "become {C:attention}Stone Cards{}",
                    "when scored",
                },
            },
            j_mstg_tortoise = {
                name = "Tortoise",
                text = {
                    "Gains {X:mult,C:white} X#1# {} Mult every time",
                    "a {C:attention}Blind{} is defeated with",
                    "{C:attention}0 hands{} and {C:attention}0 discards{}",
                    "remaining",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
            },
            j_mstg_leaky_soda = {
                name = "Leaky Soda",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:mult}-#2#{} Mult every hand",
                    "played",
                    "{C:mult}+#3#{} Mult every hand",
                    "remaining by the end",
                    "of the round",
                },
            },
            j_mstg_scythe = {
                name = "Scythe",
                text = {
                    "Creates {C:attention}Death{} if final",
                    "hand of the round",
                    "is a {C:attention}#1#{},",
                    "poker hand changes at",
                    "end of round",
                    "{C:inactive}(Must have room){}",
                },
            },
            j_mstg_cupid = {
                name = "Cupid",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if there",
                    "are an {C:attention}equal amount{} of",
                    "{C:hearts}#2#{} and {C:spades}#3#{}",
                    "in the deck",
                },
            },
            j_mstg_vortex = {
                name = "Vortex",
                text = {
                    "At the {C:attention}end of the shop{},",
                    "this Joker {C:attention}destroys{} a random",
                    "{C:attention}consumable{} to gain {X:mult,C:white} X#1# {} Mult",
                    "Otherwise, {S:1.1,C:red,E:2}self-destructs{}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
            },
            j_mstg_rover = {
                name = "Rover",
                text = {
                    "Gains {X:mult,C:white} X#1# {} Mult",
                    "if a {C:attention}#2#{} is",
                    "{C:attention}leveled up{},",
                    "poker hand changes",
                    "at end of round",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)"
                }
            },
            j_mstg_briefcase = {
                name = "Briefcase",
                text = {
                    "Sell this Joker to instantly",
                    "{C:attention}multiply{} your score by {C:attention}#1#{}"
                }
            },
            j_mstg_ufo = {
                name = "UFO",
                text = {
                    "{X:mult,C:white} X#1# {} Mult for every",
                    "{C:attention}hand type{} that has",
                    "been played this run",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
            },
            j_mstg_great_red_spot = {
                name = "Great Red Spot",
                text = {
                    "When a {C:attention}#1#{} is played,",
                    "remove {C:attention}#2#{} level from it",
                    "and add {X:mult,C:white} X#3# {} Mult",
                    "to this Joker",
                    "{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)",
                }
            },
            j_mstg_defaced = {
                name = "Defaced Joker",
                text = {
                    "Converts {C:attention}first discarded{}",
                    "hand of the round",
                    "into {C:hearts}#1#{}",
                },
            },
            j_mstg_missing_poster = {
                name = "Missing Poster",
                text = {
                    "{C:attention}Straights{} including a {C:attention}10{},",
                    "{C:attention}Jack{} or {C:attention}Queen{} can be",
                    "completed with an {C:attention}Ace{}",
                    "{C:inactive}(ex 1: {C:attention}A 10 9 8 7{C:inactive})",
                    "{C:inactive}(ex 2: {C:attention}A J 10 9 8{C:inactive})"
                },
            },
            j_mstg_benign = {
                name = "Benign Joker",
                text = {
                    "Adds one {C:attention}9{} to the deck",
                    "when {C:attention}Blind is selected",
                }
            },
            j_mstg_gauss = {
                name = "Gauss",
                text = {
                    "When played hand",
                    "contains a {C:attention}Straight{},",
                    "sum up included {C:attention}ranks{}",
                    "and add to {C:mult}Mult{}"
                }
            },
            j_mstg_plasma = {
                name = "Plasma Joker",
                text = {
                    "Up to {X:mult,C:white} X#1# {} Mult",
                    "depending on how balanced",
                    "{C:chips}Chips{} and {C:mult}Mult{} are",
                },
            },
            j_mstg_outcast = {
                name = "Outcast",
                text = {
                    "{X:mult,C:white} X#1# {} Mult for every",
                    "hand played that includes a",
                    "{C:attention}non-scoring{} card",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                },
            },
            j_mstg_sunk_cost = {
                name = "Sunk Cost Fallacy",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "steal {C:money}$#1#{} of sell value",
                    "from every other {C:attention}Joker{}",
                    "and {C:attention}Consumable{} card"
                }
            },
            j_mstg_know_your_worth = {
                name = "Know Your Worth",
                text = {
                    "Vouchers affect {C:attention}buy price{},",
                    "but not {C:attention}sell value{}",
                }
            },
            j_mstg_hot_potato = {
                name = "Hot Potato",
                text = {
                    "{C:white,X:mult}X#1#{} Mult if {C:attention}scoring hand{}",
                    "includes {C:attention}#2#{}, {C:red}self-destructs{} if",
                    "{C:attention}#2#{} is not scored within",
                    "the next {C:attention}#3#{} hands",
                    "{s:0.8}Rank changes once scored",
                    "{s:0.8}Countdown resets once scored"
                }
            },
            j_mstg_encore = {
                name = "Encore",
                text = {
                    "{C:attention}Retrigger{} each played",
                    "{V:1}#1#{}, suit changes at",
                    "the end of the round"
                }
            },
            --- Rare
            j_mstg_power_of_three = {
                name = "Power of Three",
                text = {
                    "Each {C:attention}scoring hand{} that",
                    "contains a {C:attention}#4#{} has a",
                    "{C:green}#1# in #2#{} chance to add",
                    "{X:mult,C:white} X#3# {} Mult to this Joker",
                    "{C:inactive}(Currently {X:mult,C:white} X#5# {C:inactive} Mult)",
                },
            },
            j_mstg_weighted_dice = {
                name = "Weighted Dice",
                text = {
                    "After {C:attention}Blind{} is selected,",
                    "sell this Joker to {C:attention}guarantee",
                    "{C:green}all probabilities{} until the",
                    "end of the round",
                },
            },
            j_mstg_conscription = {
                name = "Conscription",
                text = {
                    "When first hand is played,",
                    "{C:attention}destroy{} all {C:attention}unscoring cards{}",
                },
            },
            j_mstg_travel_miles = {
                name = "Travel Miles",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if you have",
                    "obtained at least",
                    "{C:attention}#2#{} unique Jokers",
                    "this run",
                    "{C:inactive}(Currently {C:attention}#3#{}){}",
                },
            },
            j_mstg_augment = {
                name = "AUgment",
                text = {
                    "{C:attention}Gold{} cards held in hand",
                    "pay out during hand"
                },
            },
            j_mstg_unstable_atom = {
                name = "Unstable Atom",
                text = {
                    "{C:green}#1# in #2#{} chance for {X:mult,C:white} X#3# {} Mult",
                    "{C:green}#1# in #4#{} chance to",
                    "{S:1.1,C:red,E:2}self-destruct{}"
                },
            },
            j_mstg_invitation_letter = {
                name = "Invitation Letter",
                text = {
                    "When round begins, {C:attention}duplicate{}",
                    "a random {C:attention}playing card{} from the suit",
                    "which you have {C:attention}the most of{}"
                },
            },
            j_mstg_resurrection = {
                name = "Resurrection",
                text = {
                    "Sell this {C:attention}Joker{} to create",
                    "a copy of the {C:attention}Joker{} that",
                    "was most recently",
                    "{C:attention}sold{} or {C:attention}destroyed{}",
                }
            },
            -- Legendary
            j_mstg_archibald = {
                name = "Archibald",
                text = {
                    "When this Joker is",
                    "{C:attention}sold{} or {C:attention}destroyed{},",
                    "go back {C:attention}#1# Antes{}",
                },
            }
        },
        Other = {},
        Planet = {},
        Sleeve = {
            sleeve_mstg_tribute = {
                name = "Tribute Sleeve",
                text = {
                    "Every card is a",
                    "{C:attention}10{} of {C:spades}Spades{}"
                }
            },
        },
        Spectral = {},
        Stake = {},
        Tag = {},
        Tarot = {},
        Voucher = {},
        Mod = {
            mistigris = {
                name = "Mistigris",
                text = {
                    "Mistigris is a mod for Balatro that",
                    "aims to {C:red}spice up{} the gameplay, while ensuring",
                    "that things are still relatively {C:purple}balanced{}!",
                    " ",
                    "Created by {C:attention}astrapboy{} with art by {C:attention}Gappie{}",
                    "{C:inactive}Full credits available in the mod's README{}"
                }
            }
        }
    },
    misc = {
        achievement_descriptions = {},
        achievement_names = {},
        blind_states = {},
        challenge_names = {},
        collabs = {},
        dictionary = {
            k_mstg_resurrection_none = "None",
            k_mstg_rigged_ex = "Rigged!",
            k_mstg_stone_ex = "Stone!",
            k_mstg_wakeup_ex = "Wake Up!",
            k_mstg_nightmare_ex = "Nightmare!",
            k_mstg_decay_ex = "Decayed!",
            k_mstg_closed_ex = "Closed!",
            k_mstg_plus_wild = "+1 Wild",
            k_mstg_plus_card = "+1 Card",
            k_mstg_val_down = "Value Down"
        },
        high_scores = {},
        labels = {},
        poker_hand_descriptions = {},
        poker_hands = {},
        ranks = {},
        suits_plural = {},
        suits_singular = {},
        tutorial = {},
        v_dictionary = {
            a_mstg_xscore = "X#1# Score"
        },
        v_text = {},
    },
}
