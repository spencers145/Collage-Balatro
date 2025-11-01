return {
    misc = {
        dictionary = {
            artb_bonk = "Bonk!",
            artb_collectable_shine = 'Enable Collectable Shine',
            artb_caught = "Caught!",
            artb_wow = "WOW!",
            artb_miss = "Miss!",
            artb_arts_crafts_pack = "Arts & Crafts Pack",
            artb_plus_art = "Supplies!",
            artb_plus_tag = "+1 Tag",
            artb_wild = "Wild",
            artb_hungry="Hungry!",
            artb_fed="Fed!",
            artb_starved="Starved :(",
            artb_protoplanet="Protoplanet",
            artb_stolen="Stolen!",
            artb_null_hand_toggle = "Toggle Null Hand",
            artb_menu = "Toggle Custom Menu",
            artb_fill= "Fill!",
            artb_empty= "Empty",
            artb_fired= "Fired!",
            artb_wood = "Chipped!"
        },
        labels = {
            artb_ouroboros_seal = "Ouroboros Seal",
            artb_brick_seal = "Brick Seal",
            artb_button_seal = "Button Seal",
        },
        poker_hand_descriptions={
            ["artb_null"] = {'5 Rankless Cards'},
        },
        poker_hands={
            ["artb_null"] = "Null",
        },
    },
    descriptions = {
        Joker = {
            j_artb_collage = {
                name = 'Collage',
                text = {
                    "When any playing card is {C:attention}destroyed{},",
                    "gains {C:chips}+#1#{} Chips, {C:mult}+#3#{} Mult, or {X:mult,C:white}X#5#{} Mult",
                    "{C:inactive}(Currently: {C:chips}#2#{} {C:inactive}Chips/{C:mult}#4#{} {C:inactive}Mult/{X:mult,C:white}X#6#{} {C:inactive}Mult)"
                }
            },

            j_artb_halftone = {
                name = 'Halftone',
                text = {
                    "Retrigger all scored cards",
                    "if played hand",
                    "contains a {C:attention}Straight{}",
                }
            },

            j_artb_mitosis = {
                name = 'Mitosis',
                text = {
                    {"{C:mult}+#1#{} Mult"},
                    {"When {C:attention}blind{} is selected,",
                    "creates a copy of this Joker",
                    "{C:inactive}(Must have room)"},
                }
            },

            j_artb_bat = {
                name = 'Baseball Bat',
                text = {
                    "The first time each round",
                    "a hand is played containing",
                    "only {C:attention}one{} card, {C:red}destroy{} it",
                }
            },

            j_artb_rubberhose = {
                name = 'Rubber Hose',
                text = {
                    {
                        "Played cards with",
                        "{C:clubs}♣Club{} suit give",
                        "{C:mult}+#2#{} Mult when scored",
                    },
                    {
                        "Played cards with",
                        "{C:spades}♠Spade{} suit give",
                        "{C:chips}+#1#{} Chips when scored",
                    }
                }
            },

            j_artb_clawmachine = {
                name = 'Claw Machine',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "{C:green}#1# in #2#{} chance",
                    "to create a",
                    "{C:attention}Joker Collectable{}",
                }
            },

            j_artb_rorschach = {
                name = 'Rorschach',
                text = {
                    "All played {C:clubs}Club{} cards",
                    "become {C:attention}Wild Cards{}",
                    "when scored",
                }
            },

            j_artb_sadcube = {
                name = 'Sad Cube',
                text = {
                    "Gain {C:money}$#1#{} when",
                    "any probability {C:attention}fails{}",
                }
            },

            j_artb_transparent_joker = {
                name = '"Transparent" Joker',
                text = {
                    "Scored cards give",
                    "{C:mult}+#1#{} Mult for every",
                    "{C:attention}unscored card{}",
                    "in played hand"
                }
            },

            j_artb_minimalism = {
                name = 'Minimalism',
                text = {
                    "Retrigger all scored cards",
                    "if played hand has {C:attention}3{}",
			        "or less scored cards",
                }
            },

            j_artb_wooden_joker = {
                name = 'Wooden Joker',
                text = {
                    "Retrigger last card",
                    "held in hand {C:attention}#1#{} times",
                }
            },

            j_artb_random = {
                name = 'Random',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "transform all {C:attention}Jokers{}",
                    "to the right",
                    "into random Jokers",
                    "of the same rarity"
                }
            },

            j_artb_trixel = {
                name = 'Trixel',
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult",
                    "if played hand is",
                    "{C:attention}Three of a Kind{}",
                    "{C:inactive}(Currently: {C:mult}#2#{} {C:inactive}Mult)"
                }
            },

            j_artb_seven_nine = {
                name = '789',
                text = { {
                    "When {C:attention}7{} and {C:attention}9{} score",
                    "in the same hand,",
                    "destroy all {C:attention}9{}s",
                },
                {
                    "Scored {C:attention}7{}s give {C:mult}+#2#{} Mult for",
                    "each {C:attention}9{} destroyed by this card",
                    "{C:inactive}(Currently: {C:mult}+#1#{} {C:inactive}Mult)"
                } }
            },

            j_artb_collector = {
                name = 'Collector',
                text = { {
                    "When {C:attention}Blind{} is selected,",
                    "adds {C:money}$#3#{} of {C:attention}sell value{}",
                    "to a {C:attention}Joker{} or {C:attention}Consumable{}",
                    "to the right",
                },
                {
                    "Gives {X:mult,C:white}X#1#{} Mult times",
                    "total {C:attention}sell value{} of all owned",
                    "{C:attention}Jokers{} and {C:attention}Consumables{}",
                    "{C:inactive}(Currently: {X:mult,C:white}X#2#{} {C:inactive}Mult)"
                } }
            },

            j_artb_origami = {
                name = 'Origami',
                text = { {
                    "Create an {C:attention}Art{} card",
                    "when {C:attention}Blind{} is selected",
                    "{C:inactive}(Must have room){}"
                } }
            },

            j_artb_clownfish = {
                name = 'Clownfish',
                text = { 
                    {"{X:mult,C:white}X#1#{} Mult"},
                    {"Dies if no cards were",
                    "{C:money}sold{} before end of round",
                    "{C:inactive}(Currently: {C:red}hungry!{C:inactive}){}"}
                }
            },

            j_artb_clownfish_fed = {
                name = 'Clownfish',
                text = { 
                    {"{X:mult,C:white}X#1#{} Mult"},
                    {"Dies if no cards were",
                    "{C:money}sold{} before end of round",
                    "{C:inactive}(Currently: fed){}"}
                }
            },

            j_artb_energy_drink = {
                name = 'Energy Drink',
                text = { 
                    {
                        "Retriggers {C:attention}Joker{}",
                        "to the right"
                    },
                    {
                        "Consumed after",
                        "{C:attention}#2#{} round(s)"
                    }
                }
            },

            j_artb_lego_joker = {
                name = 'Lego Joker',
                text = { {
                    "Applying a {C:attention}Brick Seal{}",
                    "to a card that already",
                    "has one {C:attention}stacks{} them",
                    "{C:inactive}(Up to {C:attention}3{} {C:inactive}Seals stacked){}",
                },
                {
                    "Adds a {C:attention}Brick Seal Collectable{}",
                    "when this Joker is obtained",
                    "{C:inactive}(Must have room){}"
                } }
            },

            j_artb_ascii = {
                name = 'Ascii',
                text = { {
                    "Each card in hand gives",
                    "{C:mult}+#1#{} Mult for its and every",
                    "unique rank to the left"
                }}
            },

            j_artb_gold_plating = {
                name = 'Gold Plating',
                text = {{
                    "Gains {C:money}$#1#{} of {C:attention}sell value{}",
                    "at end of round"
                },
                {
                    "Sell this Joker",
                    "to give its {C:attention}sell value{}",
                    "to a Joker to the right"
                }}
            },

            j_artb_stained_glass = {
                name = 'Stained Glass',
                text = {{
                    "{C:attention}Glass Cards{} create an",
                    "{C:attention}Art card{} when scored, and a",
                    "{C:attention}Creative Tag{} when shattered"
                }}
            },

            j_artb_paint_chips = {
                name = 'Paint Chips',
                text = {{
                    "{X:chips,C:white}X#2#{} Chips",
                    "{X:mult,C:white}X#1#{} Mult",
                }}
            },

            j_artb_heist = {
                name = 'Heist',
                text = {{
                    "When {C:attention}Blind{} is selected,",
                    "steals the {C:attention}sell value{} of",
                    "the Joker to the right"
                },
                {
                    "Gives {C:mult}Mult{} equal to three",
                    "times this Joker's {C:attention}sell value{}",
                    "{C:inactive}(Currently: {C:mult}+#1#{} {C:inactive}Mult)"
                }}
            },

            j_artb_null_pointer = {
                name = 'Null Pointer',
                text = {{
                    "Fills all empty consumable",
                    "slots with random rankless",
                    "{C:attention}Collectable enhancements{}",
                    "when {C:attention}obtained{} or {C:attention}sold{}"
                }}
            },

            j_artb_card_binder = {
                name = 'Card Binder',
                text = {{
                    "{C:attention}+#1#{} hand size when",
                    "not in a {C:attention}Blind{}"
                }}
            },

            j_artb_paint_bucket = {
                name = 'Paint Bucket',
                text = {{
                    "For the next {C:attention}#1#{} hands",
                    "give one random {C:attention}Enhancement{}",
                    "to all scored cards with same",
                    "{C:attention}Rank{} as first scoring card"
                }}
            },

            j_artb_sparkledog = {
                name = 'Sparkledog',
                text = {{
                    "{C:chips}+#1#{} Chips for each",
                    "unique {C:attention}enhancement{}, {C:attention}seal{}",
                    "and {C:attention}edition{} in {C:attention}full deck{}",
                    "{C:inactive}(Currently: {C:chips}+#2#{} {C:inactive}Chips)"
                }}
            },



        },
        collectable = {
            c_artb_joker_collectable = {
                name = 'Joker Collectable',
                text = {
                    {"{C:attention}+1 consumable slot{}"},
                    {"If you already have",
                    "a {C:attention}Joker Collectable{}",
                    "destroy this and give",
                    "the other {C:money}+#1#{} sell value"}
                }
            },

            c_artb_limited_edition_collectable = {
                name = 'Limited Edition',
                text = {
                    {"{C:attention}+#2# consumable slots{}"},
                    {"If you already have",
                    "a {C:attention}Limited Edition{},",
                    "destroy this and give",
                    "the other {C:money}+#1#{} sell value",
                    "and {C:attention}+1 consumable slot{}"}
                }
            },
            c_artb_mod_collectable = {
                name = 'Modifier Collectable',
                text = {
                    {"Contains \"{C:attention}#1#{}\""},
                    {"{C:attention}Use{} to apply it to",
                    "a selected {C:attention}playing card"}
                }
            },

            c_artb_mod_collectable_empty = {
                name = 'Modifier Collectable',
                text = {
                    "Contains an {C:attention}Enhancement{},",
                    "{C:attention}Seal{}, or {C:dark_edition}Edition",
                    "{s:0.2} {}",
                    "{C:attention}Use{} to apply it to",
                    "a selected {C:attention}playing card"
                }
            },
            c_artb_gros_michel_collectable = {
                name = 'Gros Michel Collectable',
                text = {
                    {"{C:mult}+#1#{} Mult"},
                    {"If you already have",
                    "a {C:gros}Gros Michel Collectable{},",
                    "destroy this and give",
                    "the other {C:mult}+#2#{} Mult"}
                }
            },
            c_artb_cavendish_collectable = {
                name = 'Cavendish Collectable',
                text = {
                    {"{X:mult,C:white}X#1#{} Mult"},
                    {"If you already have",
                    "a {C:cavendish}Cavendish Collectable{},",
                    "destroy this and give",
                    "the other {X:mult,C:white}X#2#{} Mult"}
                }
            },

        },
        Tag = {
            tag_artb_creative = {
                name = "Creative Tag",
                text = {
                    "Gives a free",
                    "Mega Arts & Crafts Pack"
                }
            }
        },
        art = {
            c_artb_art_paper = {
                name = 'Paper',
                text = {
                    "Enchances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Pinata Cards{}",
                }
            },
            c_artb_art_art_block = {
                name = 'Art Block',
                text = {
                    "Enchances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Stained Cards{}",
                }
            },
            c_artb_art_glitter = {
                name = 'Glitter',
                text = {
                    'Add one of {C:dark_edition}Foil{},',
                    '{C:dark_edition}Holographic{}, {C:dark_edition}Glitter{}',
                    'or {C:dark_edition}Fluorescent{} to',
                    '{C:attention}1{} random card in hand'
                }
            },
            c_artb_art_blend = {
                name = 'Blend',
                text = {
                    'Select {C:attention}2{} cards,',
                    'they copy each others',
                    '{C:attention}enhancements{}, {C:attention}seals{} and {C:attention}editions{}',
                    '{C:inactive}(if they do not have one already){}'
                }
            },

            c_artb_art_auction = {
                name = 'Auction',
                text = {
                    {'Destroys {C:attention}1{} selected card'},
                    {'Gives {C:money}$#4#{} for the card,',
                    '{C:money}$#3#{} for the {C:attention}enhancement{},',
                    '{C:money}$#2#{} for the {C:attention}seal{},',
                    'and {C:money}$#1#{} for the {C:attention}edition{}'}
                }
            },

            c_artb_art_appraisal = {
                name = 'Appraisal',
                text = {
                    'Gives {C:attention}twice{} the total sell',
                    'value of all held consumables',
                    '{C:inactive}(currently {C:money}$#1#{}{C:inactive}){}',
                    '{C:inactive}(max of {C:money}$30{}{C:inactive})',
                }
            },

            c_artb_art_plastic = {
                name = 'Plastic',
                text = {
                    'Add a {C:mult}Brick Seal{}',
                    'to {C:attention}1{} selected',
                    'card in your hand'
                }
            },

            c_artb_art_thread = {
                name = 'Thread',
                text = {
                    'Add a Button Seal',
                    'to up to {C:attention}2{} selected',
                    'cards in your hand'
                }
            },

            c_artb_art_swatch = {
                name = 'Swatch',
                text = {
                    'Creates a random',
                    '{C:dark_edition}Negative{} {C:attention}Consumable{}',
                }
            },

            c_artb_art_carving = {
                name = 'Carving',
                text = {
                    "Enchances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Wood Cards{}",
                }
            },

            c_artb_art_scissors = {
                name = 'Scissors',
                text = {
                    {'Destroys {C:attention}1{} selected',
                    'playing card'},
                    {'Creates {C:attention}Collectables{}',
                    'of its {C:attention}Modifiers{}',
                    '{C:inactive}(Must have room)'}
                }
            },

            c_artb_art_imitation = {
                name = 'Imitation',
                text = {
                    'Select {C:attention}1{} playing card,',
                    'create an {C:attention}exact*{} copy',
                    '{C:inactive}*results may vary'
                }
            },

            c_artb_art_sculpting = {
                name = 'Sculpting',
                text = {
                    "Enchances {C:attention}#1#{}",
                    "selected playing card to",
                    "{C:attention}Marble Card{}",
                }
            },

            c_artb_art_mystery_box = {
                name = 'Mystery Box',
                text = {
                    "Fills all empty consumable",
                    "slots with random",
                    "{C:attention}Modifier Collectables{}",
                }
            },

            c_artb_art_still_life = {
                name = 'Still Life',
                text = {
                    {"{C:green}#1# in #2#{} chance to",
                    "create a {C:gros}Gros Michel Collectable",
                    "{C:inactive}(Must have room)"},
                    {"If you {C:attention}already own one{},",
                    "this is {C:attention}guaranteed{} and",
                    "room is not needed",}
                }
            },

            c_artb_art_pottery = {
                name = 'Pottery',
                text = {
                    "Enchances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Clay Cards{}",
                }
            },
        },
        Planet={
            c_artb_vesta={
                name="Vesta",
                text={
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}Null",
                    "{C:mult}+3{} Mult and",
                    "{C:chips}+40{} chips",
                },
            },
        },
        Spectral = {
            c_artb_infinity = {
                name = 'Infinity',
                text = {
                    'Add an {C:dark_edition}Ouroboros Seal{}',
                    'to {C:attention}1{} selected',
                    'card in your hand'
                }
            },
        },
        Enhanced = {
           m_artb_pinata = {
           name = 'Pinata Card',
           text = {
            '{C:green}#2# in #3#{} chance to',
            '{C:red}explode{} when played',
            "{s:0.2} {}",
            'When {C:attention}destroyed{},',
            'gain {C:money}$#1#{} and a',
            'random {C:attention}tag{}'
            }
          },
         m_artb_stained = {
        name = 'Stained Card',
        text = {
          "Does not score",
          "{s:0.2} {}",
          "When {C:attention}discarded{}, {C:green}#1# in #2#{} chance",
          "to create a {C:attention}Modifier Collectable{}",
          }
        },
        m_artb_wood = {
           name = 'Wood Card',
           text = {
            "While held in hand,",
            "{C:chips}+#1#{} permanent Chips",
            "to scoring cards"
            }
        },

            m_artb_marble = {
                name = 'Marble Card',
                text = {
                    "No rank or suit",
                    "{s:0.2} {}",
                    "Becomes {C:attention}Sculpted{} after",
                    "being played {C:attention}4{} times",
                    "{C:inactive}(Currently #2#/4){}",
                }
            },

            m_artb_clay = {
                name = 'Clay Card',
                text = {
                    "Gains {C:mult}+#1#{} Mult when drawn",
                    "{s:0.2} {}",
                    "If played score {C:attention}catches fire{}",
                    "while this card is held in hand,",
                    "{C:attention}double{} {C:mult}Mult{} and lose abilities"
                }
            },
            m_artb_clay_fired = {
                name = 'Fired Clay Card',
                text = {
                    "No special abilities"
                }
            },
        },
        Voucher = {
            v_artb_booster_stack = {
                name = 'Booster Stack',
                text = {
                    "{C:attention}+1 Booster Pack{}",
                    "slot in the shop"
                },
            },
            v_artb_booster_ritual = {
                name = 'Booster Ritual',
                text = {
                    "Whenever you reroll,",
                    "a random {C:attention}Booster Pack{}",
                    "is added in the shop"
                },
            },
            v_artb_pen_holder = {
                name = 'Pen Holder',
                text = {
                    "{C:attention}+1{} consumable slot",
                },
            },
            v_artb_used_supplies = {
                name = 'Used Supplies',
                text = {
                    "When a card is destroyed,",
                    '{C:green}#1# in #2#{} chance for each of its',
                    '{C:attention}enhancement{}, {C:attention}seal{}, and {C:attention}edition{}',
                    'to be gained as {C:dark_edition}Negative{} collectables'
                },
            },
        },

        Back = {
            b_artb_handmade = {
                name = "Handmade Deck",
                text = {
                    "Start run with the",
                    "{C:attention,T:v_artb_pen_holder}#1#{} voucher",
                    "and a random {C:attention}enhancement{},",
                    "{C:attention}seal{} and {C:attention}edition{} Collectable"
                },
                unlock = {
                    "Have a {C:attention}Stained Card",
                    "create an {C:dark_edition}Edition{}",
                    "{C:attention}Modifier Collectable"
                }
            },

            b_artb_box = {
                name = "Box Deck",
                text = {
                    "Start run with the",
                    "{C:attention,T:v_ortalab_home_delivery}#1#{} voucher and a",
                    "{C:attention}Perishable {C:gros,T:c_artb_gros_michel_collectable}#2#{}"
                },
                unlock = {
                    "Use {C:art}Appraisal{} for",
                    "at least {C:money}$8"
                }
            },
        },
        Other = {
            artb_sculpted = {
                name = 'Sculpted',
                text = {
                    "Is considered a {C:attention}Face Card{}",
                    "and gives {X:chips,C:white}X2{} Chips",
                }
            },

            artb_gros_michel_explainer = {
                name = 'Gros Michel Collectable',
                text = {
                    "{C:mult}+15{} Mult",
                    "{s:0.2} {}",
                    "If you already have",
                    "a {C:gros}Gros Michel Collectable{},",
                    "destroy this and give",
                    "the other {C:mult}+5{} Mult"
                }
            },

            artb_mod_collectable_explain = {
                name = 'Modifier Collectable',
                text = {
                    "Contains an {C:attention}Enhancement{},",
                    "{C:attention}Seal{}, or {C:dark_edition}Edition",
                    "{s:0.2} {}",
                    "{C:attention}Use{} to apply it to",
                    "a selected {C:attention}playing card"
                }
            },

            artb_ouroboros_seal = {
                name = 'Ouroboros Seal',
                text = {
                    'When this card is {C:attention}destroyed{},',
                    'an exact copy is added to the {C:attention}deck{}'
                }
            },

            artb_brick_seal = {
                name = 'Brick Seal',
                text = {
                    'This card gains',
                    '{C:mult}+#1#{} extra Mult',
                    'when scored'
                }
            },

            artb_button_seal = {
                name = 'Button Seal',
                text = {
                    'When scored, {C:attention}suit{}',
                    'of a random card in hand',
                    'changes to this card\'s {C:attention}suit{}'
                }
            },

            p_artb_arts_crafts_small_1 = {
                name = "Arts and Crafts Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to {C:attention}#2#",
                    "{C:be5e6e)}Art{} cards to use",
                },
            },

            p_artb_arts_crafts_small_2 = {
                name = "Arts and Crafts Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to {C:attention}#2#",
                    "{C:be5e6e)}Art{} cards to use",
                },
            },

            p_artb_arts_crafts_jumbo = {
                name = "Jumbo Arts and Crafts Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to {C:attention}#2#",
                    "{C:be5e6e)}Art{} cards to use",
                },
            },

            p_artb_arts_crafts_mega = {
                name = "Mega Arts and Crafts Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to {C:attention}#2#",
                    "{C:be5e6e)}Art{} cards to use",
                },
            },
        },
    }
}
