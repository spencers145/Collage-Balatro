return {
  descriptions = {
    Joker = {
      j_RainyDays_atom = {
        name = "Atom",
        text = {
          "When played {C:attention}#1#{} is",
          "scored, {C:green}#2# in #3#{} chance",
          "played {C:attention}poker hand",
          "gains {C:chips}+#4#{} Chips"
        }
      },
      j_RainyDays_accountant = {
        name = "Accountant",
        text = {
          "{C:mult}+#1#{} Mult for each",
          "card {C:attention}drawn{} this round",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
        },
        unlock = {
          "Defeat a Blind",
          "while the deck",
          "is {E:1,C:attention}empty"
        }
      },
      j_RainyDays_avocado = {
        name = "Avocado",
        text = {
          "{C:mult}+#1#{} Mult",
          "{C:mult}-#2#{} Mult when any",
          "{C:attention}Booster Pack{} is",
          "opened"
        }
      },
      j_RainyDays_balance = {
        name = "Balance",
        text = {
          "{X:mult,C:white}X#1#{} Mult for each",
          "unique {C:attention}poker hand",
          "played this round",
          "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        },
        unlock = {
          "During a run,",
          "play at least",
          "{E:1,C:attention}#1#{} different",
          "{E:1,C:attention}poker hands"
        }
      },
      j_RainyDays_bankaccount = {
        name = "Bank Account",
        text = {
          "{C:chips}+#1#{} Chips",
          "When you earn {C:attention}interest{},",
          "add it to this Joker's",
          "{C:attention}sell value{} instead"
        }
      },
      j_RainyDays_bazaar = {
        name = "Bazaar",
        text = {
          "{C:attention}+#1#{} hand size",
          "Played hands with fewer",
          "than {C:attention}#2#{} scoring cards",
          "are not scored"
        }
      },
      j_RainyDays_breakfast_cereal = {
        name = "Breakfast Cereal",
        text = {
          "Retrigger next {C:attention}#2#{} upgrades",
          "of {C:attention}#1#{}, earn {C:money}$#3#{} when",
          "this Joker is consumed"
        }
      },
      j_RainyDays_beanstalk = {
        name = "Beanstalk",
        text = {
          "This Joker gains {X:mult,C:white}X#1#{} Mult",
          "for each {C:attention}consecutive{} round",
          "a {C:attention}consumable{} card is used",
          "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
          "{s:0.8,C:inactive}({s:0.8,C:attention}#4#{s:0.8,C:inactive}#5#)"
        }
      },
      j_RainyDays_blood_moon = {
        name = "Blood Moon",
        text = {
          {"If played hand is a",
          "single {C:attention}card{}, destroy",
          "it, and {X:mult,C:white}X#1#{} Mult next",
          "played hand with",
          "{C:attention}multiple{} cards",
          "{C:inactive}(Currently {V:1}#2#{C:inactive})"},
          {"While {C:attention}active{}, cannot",
          "{C:red}destroy{} further cards"}
        }
      },
      j_RainyDays_bonsai = {
        name = "Bonsai",
        text = {
          "{C:mult}+#1#{} Mult for every",
          "{C:attention}#2#{} cards with {C:clubs}Club",
          "suit remaining in",
          "{C:attention}deck",
          "{C:inactive}(Currently {C:mult}+#3# {C:inactive}Mult)"
        },
        unlock = {
          "Have {E:1,C:attention}#1#{} or fewer",
          "cards with {E:1,C:clubs}Club",
          "suit in the deck"
        }
      },
      j_RainyDays_burdenofgreatness = {
        name = "Burden of Greatness",
        text = {
          "At end of round, create a",
          "{C:tarot}Charm Tag{} and increase all",
          "{C:attention}required scores{} by {C:attention}#1#%"
        },
        unlock = {
          "Defeat a Boss Blind",
          "scoring at least {E:1,C:attention}triple",
          "the required score"
        }
      },
      j_RainyDays_catalogue = {
        name = "Catalogue",
        text = {
          "Each discarded card",
          "has {C:green}#1# in #2#{} chance to",
          "{C:attention}randomize{} its rank"
        }
      },
      j_RainyDays_checklist = {
        name = "Checklist",
        text = {
          "Each played {C:attention}card{} with a",
          "{C:attention}rank{} already played this",
          "round gives {X:mult,C:white}X#1#{} Mult",
          "when scored"
        }
      },
      j_RainyDays_cleanslate = {
        name = "Clean Slate",
        text = {
          {"{C:mult}+#1#{} Mult"},
          {"Each discard, discard",
          "your {C:attention}entire{} hand"}
        }
      },
      
      j_RainyDays_cloverfield = {
        name = "Clover Field",
        text = {
          "This Joker gains {C:mult}+#1#{} Mult",
          "every {C:attention}#3# {C:inactive}[#4#]{} cards",
          "with {C:clubs}Club{} suit discarded",
          "{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)"
        }
      },
      j_RainyDays_conga_line = {
        name = "Conga Line",
        text = {
          "Retrigger each played",
          "card with {C:attention}odd{} rank",
          "{C:inactive}(A, 9, 7, 5, 3)"
        },
        unlock = {
          "Have {E:1,C:attention}#1#{} or more",
          "cards with {E:1,C:attention}odd",
          "rank in the deck"
        }
      },
      j_RainyDays_count_orlok = {
        name = "Count Orlok",
        text = {
          "If played hand contains {C:attention}#1#{} or",
          "more {C:attention}face{} cards, destroy one",
          "among them, and this Joker",
          "gains {X:mult,C:white}X#2#{} Mult",
          "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
        }
      },
      j_RainyDays_dancing_moves = {
        name = "Dancing Moves",
        text = {
          "Retrigger each played",
          "{C:attention}card{} if played hand",
          "contains a {C:attention}Wild Card"
        }
      },
      j_RainyDays_dealer = {
        name = "Dealer",
        text = {
          "Sell this or another",
          "{C:attention}Joker{} during a round",
          "to gain {C:blue}+#1#{} hands"
        },
        unlock = {
          "Defeat a Blind",
          "after playing",
          "{E:1,C:attention}#1#{} or more hands"
        }
      },
      j_RainyDays_desolate = {
        name = "Desolate",
        text = {
          "{X:mult,C:white}X#1#{} Mult if {C:attention}#2#{} or more",
          "different {C:attention}poker hands",
          "were {C:attention}discarded{} this run"
        }
      },
      j_RainyDays_equity = {
        name = "Equity",
        text = {
          "{C:mult}+#1#{} Mult if cards",
          "held in hand do not",
          "contain a {C:attention}#2#"
        }
      },
      j_RainyDays_fabergeegg = {
        name = "Fabergé Egg",
        text = {
          "Played {C:attention}face{} cards",
          "each add {C:money}$#1#{} of {C:attention}sell",
          "{C:attention}value{} to this Joker",
          "when scored"
        }
      },
      
      j_RainyDays_feather_precious = {
        name = "Precious Feather",
        text = {
          "Earn {C:money}$#1#{} at end",
          "of round for each",
          "owned {C:common}Common {C:attention}Joker{}",
          "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
        }
      },
      
      j_RainyDays_feather_silky = {
        name = "Silky Feather",
        text = {
          "{C:mult}+#1#{} Mult for each",
          "owned {C:common}Common {C:attention}Joker{}",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
        }
      },
      
      j_RainyDays_feather_vibrant = {
        name = "Vibrant Feather",
        text = {
          "{C:chips}+#1#{} Chips for each",
          "owned {C:common}Common {C:attention}Joker{}",
          "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
        }
      },
      
      j_RainyDays_flipflop_even = {
        name = "Flip-flop",
        text = {
          "This Joker alternates",
          "between {X:mult,C:white}X#1#{} Mult",
          "and {C:chips}+#2#{} Chips",
          "each played hand",
          "{C:inactive}(Next hand: {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
      },
      
      j_RainyDays_flipflop_odd = {
        name = "Flip-flop",
        text = {
          "This Joker alternates",
          "between {X:mult,C:white}X#1#{} Mult",
          "and {C:chips}+#2#{} Chips",
          "each played hand",
          "{C:inactive}(Next hand: {C:chips}+#2#{C:inactive} Chips)"
        }
      },
      j_RainyDays_golden_idol = {
        name = "Golden Idol",
        text = {
          "This Joker gains {X:mult,C:white}X#1#{} Mult",
          "when a {C:attention}Gold Card{} is drawn",
          "during a round",
          "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        }
      },
      j_RainyDays_goldfish = {
        name = "Goldfish",
        text = {
          "Earn {C:money}$#1#{} if played hand",
          "does not contain a {C:attention}#2#"
        }
      },
      j_RainyDays_grapes = {
        name = "Grapes",
        text = {
          "Next {C:attention}#1#{} played cards each",
          "give between {C:mult}+#2#{} and {C:mult}+#3#{} Mult",
          "when scored"
        }
      },
      j_RainyDays_grey_joker = {
        name = "Grey Joker",
        text = {
          "This Joker gains {X:mult,C:white}X#2#{} Mult",
          "if {C:attention}discard{} contains a {C:attention}#1#",
          "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
        },
        unlock = {
          "Have at least {E:1,C:attention}#1#",
          "{E:1,C:attention}Stone Cards{} in",
          "the deck"
        }
      },
      j_RainyDays_hannysvoorwerp = {
        name = "Hanny's Voorwerp",
        text =  {
          "This Joker gains {C:mult}+#1#{} Mult",
          "when a {C:planet}Planet{} card is {C:attention}sold",
          "{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)"
        }
      },
      
      j_RainyDays_heirloom = {
        name = "Heirloom",
        text = {
          "Each played card adjacent",
          "to a {C:attention}Bonus{} or {C:attention}Mult Card",
          "has {C:green}#1# in #2#{} chance to gain",
          "that {C:attention}enhancement"
        }
      },
      
      j_RainyDays_kintsugi = {
        name = "Kintsugi",
        text = {
          "Whenever a {C:attention}Glass Card",
          "is destroyed, shuffle",
          "a copy with a {C:attention}Gold",
          "{C:attention}Seal{} into the deck"
        }
      },
      
      j_RainyDays_kudzu = {
        name = "Kudzu",
        text = {
          "When {C:attention}Blind{} is selected,",
          "create another {C:attention}Kudzu{}.",
          "Then this Joker gains",
          "{C:mult}+#1#{} Mult for each {C:attention}Kudzu",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
          "{C:inactive}(Must have room)"
        },
        unlock = {
          "Have at least",
          "{E:1,C:attention}#1#{} copies of the",
          "same {E:1,C:attention}Joker"
        }
      },
      
      j_RainyDays_lady_in_waiting = {
        name = "Lady-in-waiting",
        text = {
          "When a {C:attention}#1#{} is drawn",
          "during a round, each",
          "card in the {C:attention}full deck",
          "permanently gains",
          "{C:chips}+#2#{} Chip"
        },
        unlock = {
          "Have {E:1,C:attention}#1#{} or",
          "more {E:1,C:attention}#2#s",
          "in the deck"
        }
      },

      j_RainyDays_lady_of_the_lake = {
        name = "Lady of the Lake",
        text = {
          "If played hand contains no",
          "{C:attention}enhanced{} cards, a random scoring",
          "card gains a random {C:attention}enhancement"
        }
      },
      
      j_RainyDays_lightning = {
        name = "Lightning",
        text = {
          "Each played {C:attention}Mult Card",
          "gives {C:mult}+#1#{} Mult instead",
          "of {C:mult}+#2#{} Mult when scored"
        },
        unlock = {
          "Have at least {E:1,C:attention}#1#",
          "{E:1,C:attention}Mult Cards{} in",
          "the deck"
        }
      },

      j_RainyDays_lotteryticket = {
        name = "Lottery Ticket",
        text = {
          {"Scored {C:attention}#1#s{}, {C:attention}#2#s{}, {C:attention}#3#s{},",
          "{C:attention}#4#s{}, and {C:attention}#5#s{} give {C:money}$#6#{}"},
          {"When a target {C:attention}rank{} is",
          "scored, remove it from this Joker",
          "and increase payout by {C:money}$#7#{}"},
          {"Resets payout and changes",
          "listed ranks each round"}
        }
      },

      j_RainyDays_metropolis = {
        name = "Metropolis",
        text = {
          "If played hand contains a",
          "{C:attention}#1#{}, {X:mult,C:white}X#2#{} Mult next",
          "{C:attention}#3#{} played hands",
          "{C:inactive}({V:1}#4# {C:inactive}#5#{V:1}#6#{C:inactive}#7#)"
        }
      },

      j_RainyDays_minimalist = {
        name = "Minimalist",
        text = {
          "{C:mult}+#1#{} Mult if",
          "a {C:attention}Joker Slot",
          "is empty"
        },
        unlock = {
          "Reach Ante {E:1,C:attention}#1#{} without",
          "ever having any {E:1,C:attention}Jokers"
        }
      },
      
      j_RainyDays_microwave = {
        name = "Microwave",
        text = {
          {"{C:mult}+#1#{} Mult"},
          {"{C:mult}+#2#{} Mult per {C:blue}hand",
          "played or {C:red}discard{} used"},
          {"At {C:mult}+#3#{} Mult,",
          "transform into {C:attention}Popcorn"}
        }
      },

      j_RainyDays_parrot = {
        name = "Parrot",
        text = {          
          "Copies ability of {C:attention}Joker",
          "to the right if it wasn't",
          "copied in {C:attention}previous{} rounds",
          "this {C:attention}Ante"
        }
      },

      j_RainyDays_plump_joker = {
        name = "\"Plump\" Joker",
        text = {
          "{C:mult}+#1#{} Mult for each",
          "{C:attention}consumable{} card",
          "used this {C:attention}Ante",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
        },
        unlock = {
          "During a run,",
          "use {E:1,C:attention}#1#{} or more",
          "{E:1,C:attention}consumable{} cards"
        }
      },

      j_RainyDays_prairie = {
        name = "Prairie",
        text = {
          {"This Joker gains {C:mult}+#1#{} Mult",
          "if played {C:attention}poker hand{} is",
          "not a {C:attention}#2#",
          "{C:inactive}(Currently {C:mult}+#3# {C:inactive}Mult)"},
          {"Set to most played poker",
          "hand at end of round"}
        }
      },

      j_RainyDays_purple_card = {
        name = "Purple Card",
        text = {
          "Create a {C:tarot}Tarot{} card",
          "when any {C:attention}Booster Pack",
          "is skipped",
          "{C:inactive}(Must have room)"
        }
      },

j_RainyDays_recycle = {
        name = "Recycle",
        text = {
          "Each discarded {C:attention}5{}, {C:attention}4{}, {C:attention}3{},",
          "or {C:attention}2{} permanently gains",
          "{C:mult}+#1#{} Mult and is shuffled",
          "back into the deck"
        }
      },

      j_RainyDays_roller_skates = {
        name = "Roller Skates",
        text = {
          "{X:mult,C:white}X#1#{} Mult if a {C:attention}discarded",
          "{C:attention}poker hand{} this round",
          "was a {C:attention}#2#{}",
          "or a {C:attention}#3#{}",
          "{C:inactive}(Currently #4#)"
        },
        unlock = {
          "During a run, discard",
          "at least {E:1,C:attention}#1#{} different",
          "{E:1,C:attention}poker hands"
        }
      },

      j_RainyDays_self_assembly = {
        name = "Self-assembly",
        text = {
          "This Joker gains {C:mult}+#1#{} Mult",
          "whenever a {C:attention}playing card",
          "gains a new {C:attention}enhancement",
          "{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)"     
        }
      },

      j_RainyDays_serial = {
        name = "Serial",
        text = {
          "First played card",
          "of each {C:attention}suit{} gives",
          "{C:chips}+#1#{} Chips when scored",
          "{C:inactive}(One suit per card)"
        }
      },

      j_RainyDays_sediment = {
        name = "Sediment",
        text = {
          {"{X:mult,C:white}X#1#{} Mult"},
          {"When {C:attention}Blind{} is selected,",
          "shuffle three random",
          "{C:attention}debuffed{} cards into",
          "the deck"}
        }
      },
      
      j_RainyDays_sextant = {
        name = "Sextant",
        text = {
          "Create a {C:constellation}Constellation",
          "card every {C:attention}#1#{} {C:inactive}[#2#]{} cards",
          "with {C:spades}Spade{} suit scored",
          "{C:inactive}(Must have room)"
        }
      },
      
      j_RainyDays_sputnik = {
        name = "Sputnik",
        text = {
          "Create a {C:constellation}Constellation{} card",
          "if {C:attention}poker hand{} hasn't been",
          "played yet, resets when",
          "{C:attention}Boss Blind{} is defeated",
          "{C:inactive}(Must have room)"
        }
      },

      j_RainyDays_theater = {
        name = "Theater",
        text = {
          {"Before scoring, draw",
          "to {C:attention}hand size{}"},
          {"Each {C:attention}face{} card held in",
          "hand gives {C:mult}+#1#{} Mult"},
        },
        unlock = {
          "Defeat a Blind",
          "while holding",
          "{E:1,C:attention}#1#{} or more {E:1,C:attention}face",
          "cards in hand"
        }
      },

      j_RainyDays_train_ticket = {
        name = "Train Ticket",
        text = {
          "This Joker gains {C:mult}+#1#{} Mult",
          "if played hand contains",
          "{C:attention}#2#{} or more cards with",
          "{C:attention}consecutive{} ranks",
          "{C:inactive}(Currently {C:mult}+#3# {C:inactive}Mult)"
        },
        unlock = {
          "During a run,",
          "play {E:1,C:attention}#1#{} or more",
          "{E:1,C:attention}#2#s"
        }
      },

      j_RainyDays_throne = {
        name = "Throne",
        text = {
          "{X:mult,C:white}X#1#{} Mult if only {C:attention}1",
          "{C:attention}face{} card is {C:attention}held in hand",
          "{C:inactive}(Currently {V:1}#2#{C:inactive})"
        }
      },
      
      j_RainyDays_truffle = {
        name = "Truffle",
        text = {
          "{X:mult,C:white}X#1#{} Mult,",
          "loses {X:mult,C:white}X#2#{} Mult for",
          "each card {C:attention}remaining{} in",
          "{C:attention}deck{} at end of round"
        }
      },
      
      j_RainyDays_waveform = {
        name = "Waveform",
        text = {
          "Each played {C:attention}card",
          "has {C:green}#1# in #2#{} chance",
          "to retrigger and",
          "gives {C:mult}+#3#{} Mult when",
          "{C:attention}retriggered"
        }
      },
    },
    
    Constellation = {
      c_RainyDays_aquarius = {
        name = 'Aquarius',
        text = {
          "{C:attention}#1#{} and higher",
          "ranking {C:attention}poker hands{} each",
          "gain {C:chips}+#2#{} Chips"
        }
      },
      
      c_RainyDays_aries = {
        name = "Aries",
        text = {
          "Each {C:attention}poker hand",
          "gains {C:chips}+#1#{} Chips"
        }
      },
      
      c_RainyDays_cancer = {
        name = 'Cancer',
        text = {
          "Upgrade most played",
          "{C:attention}poker hand{} and shuffle",
          "three random {C:attention}debuffed",
          "cards into the deck"
        }
      },
      
      c_RainyDays_capricorn = {
        name = 'Capricorn',
        text = {
          "Earn {C:money}$#1#{} for each level",
          "of highest level {C:attention}poker",
          "{C:attention}hand {C:inactive}(Max of {C:money}$#2#{C:inactive})",
          "{C:inactive}(Currently {C:money}$#3#{C:inactive})"
        }
      },
      
      c_RainyDays_cetus = {
        name = 'Cetus',
        text = {
          "{C:attention}#1#{} gains",
          "{C:mult}+#2#{} Mult for every",
          "{C:money}$#3#{} you have,",
          "does not reappear",
          "{C:inactive}(Currently {C:mult}+#4# {C:inactive}Mult)"
        }
      },
      
      c_RainyDays_chamaeleon = {
        name = "Chamaeleon",
        text = {
          "Create a copy of the",
          "last {C:constellation}Constellation{} card",
          "used this run",
          "{s:0.8, C:constellation}Chamaeleon{s:0.8} excluded"
        }
      },
      
      c_RainyDays_gemini = {
        name = 'Gemini',
        text = {
          "Create up to {C:attention}two",
          "random {C:planet}Planet{} cards",
          "{C:inactive}(Must have room)"
        }
      },
      
      c_RainyDays_leo = {
        name = 'Leo',
        text = {
          "Upgrade last played",
          "{C:attention}poker hand{} and destroy",
          "a random {C:attention}Joker"
        }
      },
      
      c_RainyDays_libra = {
        name = 'Libra',
        text = {
          "Random {C:attention}poker hand",
          "gains {C:chips}+#1#{} Chips",
          "and {C:mult}+#2#{} Mult"
        }
      },
      
      c_RainyDays_ophiuchus = {
        name = 'Ophiuchus',
        text = {
          "Each secret {C:attention}poker",
          "{C:attention}hand{} gains {C:chips}+#1#{} Chips",
          "and {C:mult}+#2#{} Mult"
        }
      },
      
      c_RainyDays_orion = {
        name = 'Orion',
        text = {
          "{C:attention}#1#{} gains",
          "{C:chips}+#2#{} Chip for each {C:tarot}Tarot",
          "card used this run,",
          "does not reappear",
          "{C:inactive}(Currently {C:chips}+#3# {C:inactive}Chips)"
        }
      },
      
      c_RainyDays_pegasus = {
        name = 'Pegasus',
        text = {
          "Earn {C:money}$#1#{}, decrease",
          "level of highest level",
          "{C:attention}poker hand{} by {C:attention}#2#"
        }
      },
      
      c_RainyDays_pisces = {
        name = 'Pisces',
        text = {
          "{C:attention}#1#{} and higher",
          "ranking {C:attention}poker hands{} each",
          "gain {C:mult}+#2#{} Mult"
        }
      },
      
      c_RainyDays_sagittarius = {
        name = "Sagittarius",
        text = {
          "{C:attention}#1#{} and higher",
          "ranking {C:attention}poker hands{} each",
          "earn {C:money}$#2#{} when played"
        }
      },
      
      c_RainyDays_scorpio = {
        name = "Scorpio",
        text = {
          "Each {C:attention}poker hand",
          "gains {C:mult}+#1#{} Mult",
          "and loses {C:chips}-#2#{} Chips"
        }
      },
      
      c_RainyDays_taurus = {
        name = "Taurus",
        text = {
          "Each {C:attention}poker hand",
          "gains {C:mult}+#1#{} Mult"
        }
      },
      
      c_RainyDays_virgo = {
        name = 'Virgo',
        text = {
          "Upgrade lowest level",
          "{C:attention}poker hand{} by {C:attention}#1#{} levels"
        }
      },
      
      c_RainyDays_vulpecula = {
        name = 'Vulpecula',
        text = {
          "Create a {C:planet}Nebula Tag"
        }
      }
    },
    
    Tag = {
      tag_RainyDays_edition = {
        name = "Edition Tag",
        text = {
          "Next base edition shop",
          "Joker is free and",
          "becomes {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
          "{C:dark_edition}Polychrome{}, or {C:dark_edition}Negative"
        }
      },
      
      tag_RainyDays_nebula = {
        name = "Nebula Tag",
        text = {
          "Add a free {C:planet}Celestial",
          "{C:planet}Pack{} to the next shop"
        }
      }
    },
    
    Spectral = {
      c_RainyDays_stigmata = {
        name = 'Stigmata',
        text = {
          "Add a {C:mint}Mint Seal",
          "to {C:attention}1{} selected",
          "card in your hand",
        }
      },
      
      c_RainyDays_witness = {
        name = 'Witness',
        text = {
          "Add an {C:ivory}Ivory Seal",
          "to {C:attention}1{} selected",
          "card in your hand",
        }
      }
    },
    
    Other = {
      collage_popcorn_explainer = {
        name = "Popcorn",
        text = {
          "{C:mult}+20{} Mult",
          "{C:mult}-4{} Mult per",
          "round played"
        }
      },

      rainydays_ivory_seal = {
        name = "Ivory Seal",
        text = {
          "Creates a {C:constellation}Constellation",
          "card if played in {C:attention}first",
          "hand of round",
          "{C:inactive}(Must have room)"
        }
      },
      
      rainydays_mint_seal = {
        name = "Mint Seal",
        text = {
          "If played, {C:green}X in #1#{} chance",
          "played {C:attention}poker hand{} gains",
          "{C:mult}+#2#{} Mult, where {C:green}X{} is the",
          "amount of scoring cards"
        }
      },
      
      --[[p_celestial_jumbo = {
        name = "Jumbo Celestial Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {C:constellation}Constellation{} or",
          "{C:planet}Planet{} cards to",
          "be used immediately"
        }
      },
      
      p_celestial_mega = {
        name = "Mega Celestial Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {C:constellation}Constellation{} or",
          "{C:planet}Planet{} cards to",
          "be used immediately"
        }
      },
        
      p_celestial_normal = {
        name = "Celestial Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {C:constellation}Constellation{} or",
          "{C:planet}Planet{} cards to",
          "be used immediately"
        }
      }]]
    }
  },
  
  misc = {
    dictionary = {
      rainydays_activated = "Active!",
      rainydays_active = "active",
      rainydays_active_cap = "Active",
      rainydays_beanstalk_grown = "Already grown this round",
      rainydays_beanstalk_or_will_reset = "or reset at end of round",
      rainydays_charm_tag = "Charm Tag",
      rainydays_constellation = "Constellation",
      rainydays_copied_before = "Copied Before",
      rainydays_currently = "Currently",
      rainydays_danger = "Danger increased!",
      rainydays_denied = "Denied!",
      rainydays_discover_all = "Discover all",
      rainydays_enhanced = "Enhanced!",
      rainydays_for_next = "for next",
      rainydays_full_clear = "Full Clear!",
      rainydays_hand = "hand",
      rainydays_hand_cap = "Hand",
      rainydays_hands = "hands",
      rainydays_hand_size = "Hand size",
      rainydays_hands_upgraded = "Hand upgraded!",
      rainydays_hidden = "hidden",
      rainydays_inactive = "inactive",
      rainydays_include_feathers = "Include Feather Jokers",
      rainydays_metallic_highlight_info1 = "As a purely visual effect, some Jokers have",
      rainydays_metallic_highlight_info2 = "metallic hightlights in their sprites",
      rainydays_more = "more",
      rainydays_more_dots = "more..",
      rainydays_must_play_hand_with_5_scoring_cards = "Must play hand with 5 scoring cards",
      rainydays_new_rank = "New Rank!",
      rainydays_plus = "+",
      rainydays_requires_restart = "(Requires restart)",
      rainydays_show_metallic_highlights = "Show metallic highlights",
      rainydays_unlock_all = "Unlock all",
      rainydays_wild = "Wild!"
    }
  }
}