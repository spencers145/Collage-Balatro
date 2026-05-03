// website template from here: https://github.com/notmario/balatrowebsitetemplate

let unpredictable = ["{X:mult,C:white}X1.5{} Mult", "{C:chips}+50{} Chips", "{C:mult}+10{} Mult", "{C:attention}+1{} hand size", "{C:red}+1{} discards", "{C:blue}+1{} Hands", "{C:money}+$7{} sell value", "{C:green}+1{} probability"]
let possibilities = ["{X:mult,C:white}X3{} Mult", "{C:chips}+250{} Chips", "{C:mult}+50{} Mult", "{C:attention}+2{} hand size", "{C:red}+3{} discards", "{C:blue}+2{} Hands", "{C:money}+$20{} sell value", "{C:green}+2{} probability", "Retrigger played cards"]

let suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
let ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
let faces = ["Jack", "Queen", "King"]

let poker_hands = ["High Card", "Pair", "Two Pair", "Three of a Kind", "Straight", "Flush", "Full House", "Four of a Kind", "Straight Flush", "Five of a Kind", "Flush House", "Flush Five"]

let printer_suit = suits[Math.floor(Math.random() * suits.length)]
let moai_suit = suits[Math.floor(Math.random() * suits.length)]

let jokers = [
  {
    name: "Summer",
    text: [
      "All played scoring",
      "{C:clubs}Club{} cards",
      "become {C:hearts}Hearts{}",
    ],
    image_url: "img/j/summer.png",
    rarity: "Common"
  },
  {
    name: "Fall",
    text: [
      "All played scoring",
      "{C:hearts}Heart{} cards",
      "become {C:spades}Spades{}",
    ],
    image_url: "img/j/fall.png",
    rarity: "Common"
  },
  {
    name: "Winter",
    text: [
      "All played scoring",
      "{C:spades}Spade{} cards",
      "become {C:diamonds}Diamonds{}",
    ],
    image_url: "img/j/winter.png",
    rarity: "Common"
  },
  {
    name: "Spring",
    text: [
      "All played scoring",
      "{C:diamonds}Diamond{} cards",
      "become {C:clubs}Clubs{}",
    ],
    image_url: "img/j/spring.png",
    rarity: "Common"
  },
  {
    name: "Four Seasons",
    text: [
      "All played scoring cards become the next suit",
      "{C:hearts,s:0.8}Hearts{s:0.8} > {C:spades,s:0.8}Spades{s:0.8} > {C:diamonds,s:0.8}Diamonds{s:0.8} > {C:clubs,s:0.8}Clubs",
    ],
    image_url: "img/j/four_seasons.png",
    rarity: "Uncommon"
  },
  {
    name: "Mitosis",
    text: [
      "When {C:attention}Blind{} is selected,",
      "duplicate {C:attention}1{} {C:hearts}Heart{}",
      "card in deck",
    ],
    image_url: "img/j/mitosis.png",
    rarity: "Common"
  },
  {
    name: "Invasion",
    text: [
      "When {C:attention}Blind{} is selected,",
      "add {C:attention}2{} {C:spades}Spade{}",
      "cards to deck",
    ],
    image_url: "img/j/invasion.png",
    rarity: "Common"
  },
  {
    name: "Purification",
    text: [
      "When {C:attention}Blind{} is selected,",
      "destroy {C:attention}1{} non-{C:diamonds}Diamond{}",
      "card in deck",
    ],
    image_url: "img/j/purification.png",
    rarity: "Common"
  },
  {
    name: "Overgrowth",
    text: [
      "When {C:attention}Blind{} is selected,",
      "convert {C:attention}1{} card",
      "in deck to {C:clubs}Clubs{}",
    ],
    image_url: "img/j/overgrowth.png",
    rarity: "Common"
  },
  {
    name: "Harmony",
    text: [
      "When {C:attention}Blind{} is selected, gain",
      "{C:mult}+2{} Mult and convert {C:attention}1{} card from",
      "your most common suit to your least",
    ],
    image_url: "img/j/harmony.png",
    rarity: "Common"
  },
  {
    name: "Imperfect Clone",
    text: [
      "Clones each give {C:chips}+35{} Chips, may appear multiple times",
    ],
    image_url: "img/j/imperfect_clone.png",
    rarity: "Common"
  },
  {
    name: "Uncanny Clone",
    text: [
      "Clones each give {C:mult}+15{} Mult, may appear multiple times",
    ],
    image_url: "img/j/uncanny_clone.png",
    rarity: "Uncommon"
  },
  {
    name: "Perfect Clone",
    text: [
      "Clones each give {X:mult,C:white}X1.5{} Mult, may appear multiple times",
    ],
    image_url: "img/j/perfect_clone.png",
    rarity: "Rare"
  },
  {
    name: "Tall Joker",
    text: [
      "{C:mult}+12{} Mult if sum",
        "of played ranks",
        "is at least {C:attention}40{}",
    ],
    image_url: "img/j/tall.png",
    rarity: "Common"
  },
  {
    name: "Short Joker",
    text: [
      "{C:chips}+100{} Chips if sum",
        "of played ranks",
        "is at most {C:attention}25{}",
    ],
    image_url: "img/j/short.png",
    rarity: "Common"
  },
  {
    name: "Hungry Joker",
    text: [
      "When {C:attention}Blind{} is selected,",
        "destroy {C:attention}2{} random",
        "cards in deck",
    ],
    image_url: "img/j/hungry.png",
    rarity: "Common"
  },
  {
    name: "All-Seeing Joker",
    text: [
      "{C:attention}+3{} hand size while",
        "opening {C:attention}Booster Packs{}",
    ],
    image_url: "img/j/all_seeing.png",
    rarity: "Common"
  },
  {
    name: "Resourceful Joker",
    text: [
      "{C:attention}+1{} option in {C:attention}Booster Packs{}",
    ],
    image_url: "img/j/resourceful.png",
    rarity: "Common"
  },
  {
    name: "Scavenging Joker",
    text: [
      "Take {C:attention}+1{} item from {C:attention}Booster Packs{}",
    ],
    image_url: "img/j/scavenging.png",
    rarity: "Uncommon"
  },
  {
    name: "Bully",
    text: [
      "{X:mult,C:white}X2{} Mult against {C:attention}Small Blinds{}"
    ],
    image_url: "img/j/bully.png",
    rarity: "Common"
  },
  // {
  //   name: "The Conspiracy",
  //   text: [
  //     "{X:mult,C:white}X4{} Mult if played",
  //       "hand is {C:attention}Secret",
  //   ],
  //   image_url: "img/j/the_conspiracy.png",
  //   rarity: "Rare"
  // },
  {
    name: "Homework",
    text: [
      "{X:mult,C:white}X4{} Mult if sum",
        "of played ranks is {C:attention}"+(2+Math.floor(Math.random() * 53))+"{}, sum changes every hand",
    ],
    image_url: "img/j/homework.png",
    rarity: "Uncommon"
  },
  {
    name: "Singularity",
    text: [
      "Gives {X:mult,C:white}X1{} Mult for each time you have played your least played {C:attention}poker hand{} this run",
    ],
    image_url: "img/j/singularity.png",
    rarity: "Rare"
  },
  {
    name: "Faster Than Light",
    text: [
      "Skip {C:attention}3 Blinds{}",
        "for {C:attention}-1{} Ante",
    ],
    image_url: "img/j/faster_than_light.png",
    rarity: "Rare"
  },
  {
    name: "Paperclip",
    text: [
      "{C:mult}+8{} Mult",
        "When {C:attention}Small Blind{} or {C:attention}Big Blind{} is selected, {C:attention}destroy{} a random Joker to create a copy of this one"
    ],
    image_url: "img/j/paperclip.png",
    rarity: "Common"
  },
  {
    name: "Spam",
    text: [
      "When round begins,",
        "add {C:attention}2{} random {C:attention}playing cards{} to your hand",
    ],
    image_url: "img/j/spam_base.png",
    soul_url: "img/j/spam_soul.png",
    rarity: "Common",
    soul: true
  },
  {
    name: "Hidden Joker",
    text: [
      "{C:red}+3{} discards each round, cards are drawn face down after discards",
    ],
    image_url: "img/j/hidden_base.png",
    soul_url: "img/j/hidden_soul.png",
    rarity: "Uncommon",
    soul: true
  },
  {
    name: "Cantrip",
    text: [
      "{C:blue}+1{} Hand if played hand is the first {C:attention}High Card{} of the round",
    ],
    image_url: "img/j/cantrip.png",
    rarity: "Common"
  },
  {
    name: "Password",
    text: [
      "{X:mult,C:white}X2{} Mult if poker hand contains a letter and a number",
    ],
    image_url: "img/j/password.png",
    rarity: "Uncommon"
  },
  {
    name: "Scam",
    text: [
      "{X:mult,C:white}X1.1{} Mult"
    ],
    image_url: "img/j/scam.png",
    rarity: "Common"
  },
  {
    name: "Elitist Joker",
    text: [
      "{C:blue}Common{C:attention} Jokers{} can't",
        "naturally appear",
    ],
    image_url: "img/j/elitist.png",
    rarity: "Rare"
  },
  {
    name: "Chosen One",
    text: [
      "Retrigger all cards",
        "played in {C:attention}Boss Blinds",
    ],
    image_url: "img/j/chosen_one.png",
    rarity: "Uncommon"
  },
  {
    name: "Anchor",
    text: [
      "{C:spades}Spade{} cards start at the bottom of the deck",
    ],
    image_url: "img/j/anchor.png",
    rarity: "Uncommon"
  },
  {
    name: "Ricochet",
    text: [
      "{C:green}1 in 2{} chance to retrigger played {C:diamonds}Diamonds{},",
        "{C:green}1 in 3{} chance to retrigger again,",
        "{C:green}1 in 4{} chance to retrigger again, etc",
    ],
    image_url: "img/j/ricochet.png",
    rarity: "Uncommon"
  },
  {
    name: "Unpredictable Joker",
    text: [
      unpredictable[Math.floor(Math.random() * unpredictable.length)],
      "ability changes at end of round"
    ],
    image_url: "img/j/unpredictable.png",
    rarity: "Common"
  },
  {
    name: "Possibility Space",
    text: [
      possibilities[Math.floor(Math.random() * possibilities.length)],
      "ability changes at end of round"
    ],
    image_url: "img/j/possibility_space.png",
    rarity: "Uncommon"
  },
  // todo: randomize abilities on reload
  {
    name: "Tapas",
    text: [
      "{C:chips}+50{} Chips", "{C:mult}+10{} Mult", "{C:attention}+1{} hand size",
      "lose {C:red}1{} effect each round",
    ],
    image_url: "img/j/tapas.png",
    rarity: "Common"
  },
  {
    name: "Unlucky Joker",
    text: [
      "{C:green}1 in 2{} chance to give {C:chips}+0{} Chips,",
        "gains {C:chips}+3{} Chips when a chance fails",
    ],
    image_url: "img/j/unlucky.png",
    rarity: "Uncommon"
  },
  {
    name: "Stargazer",
    text: [
          "Create a {C:planet}Planet{} card",
        "when {C:attention}Blind{} is selected",
        "{C:inactive}(Must have room)",
    ],
    image_url: "img/j/stargazer.png",
    rarity: "Common"
  },
  {
    name: "Gear Stick",
    text: [
      "{X:mult,C:white}+X0.2{} Mult for each joker to the right",
      "{X:mult,C:white}-X0.2{} Mult for each joker to the left",
    ],
    image_url: "img/j/gear_stick.png",
    rarity: "Uncommon"
  },
  {
    name: "Limbo",
    text: [
      "This Joker gains {C:mult}+1{} Mult per {C:attention}consecutive{} hand played that is not a {C:attention}High Card{}",
    ],
    image_url: "img/j/limbo.png",
    rarity: "Common"
  },
  {
    name: "Patent",
    text: [
      "Earn {C:money}$5{} when playing a {C:attention}poker hand{} for the first time",
    ],
    image_url: "img/j/patent.png",
    rarity: "Common"
  },
  {
    name: "Rule of Three",
    text: [
      "{X:mult,C:white}X3{} Mult every {C:attention}3rd{} scored {C:attention}3{}",
    ],
    image_url: "img/j/rule_of_three.png",
    rarity: "Uncommon"
  },
  {
    name: "Astral Transit",
    text: [
      "When a {C:planet}Planet{} card is used, also level up a random other {C:attention}poker hand{}",
    ],
    image_url: "img/j/astral_transit.png",
    rarity: "Common"
  },
  {
    name: "Death Star",
    text: [
      "{C:red}Removes{} all level ups from played {C:attention}poker hand{} and gains the removed {C:blue}Chips{} and {C:mult}Mult{}",
    ],
    image_url: "img/j/death_star.png",
    rarity: "Rare"
  },
  {
    name: "Infrastructure",
    text: [
      "When {C:attention}Blind{} is selected, randomly {C:enhanced}Enhance{} {C:attention}1{} card in deck",
    ],
    image_url: "img/j/infrastructure.png",
    rarity: "Common"
  },
  {
    name: "Printer",
    text: [
      "When {C:attention}Blind{} is selected, add a {C:attention}"+ranks[Math.floor(Math.random() * ranks.length)]+"{} of {C:"+printer_suit+"}"+printer_suit+"{} to deck",
    ],
    image_url: "img/j/printer.png",
    rarity: "Common"
  },
  {
    name: "The Sun",
    text: [
      "When {C:attention}Boss Blind{} is defeated, upgrade level of every {C:attention}poker hand",
    ],
    image_url: "img/j/sun_explode.png",
    rarity: "Uncommon"
  },
  {
    name: "Shackles",
    text: [
      "{C:dark_edition}+1{} Joker Slot,",
      "{X:mult,C:white}X0.5{} Mult",
    ],
    image_url: "img/j/shackles.png",
    rarity: "Common"
  },
  {
    name: "Stellar Void",
    text: [
      "{C:mult}+2{} Mult per {C:attention}poker hand{} you have never played",
    ],
    image_url: "img/j/stellar_void.png",
    rarity: "Common"
  },
  {
    name: "Stellar Cluster",
    text: [
      "{C:mult}+2{} Mult per different {C:attention}poker hand{} you have played",
    ],
    image_url: "img/j/stellar_cluster.png",
    rarity: "Common"
  },
  {
    name: "Taxes",
    text: [
      "{C:mult}+1{} Mult for every {C:money}$1{} you are below {C:money}$25{}",
    ],
    image_url: "img/j/taxes.png",
    rarity: "Common"
  },
  {
    name: "Knockoff",
    text: [
      "Copies ability of the lowest sell value {C:attention}Joker{}",
    ],
    image_url: "img/j/knockoff.png",
    rarity: "Uncommon"
  },
  {
    name: "Delivery",
    text: [
      "Earn {C:money}$8{} when {C:attention}Blind{} is skipped",
    ],
    image_url: "img/j/delivery.png",
    rarity: "Common"
  },
  {
    name: "Gambler",
    text: [
      "When {C:attention}High Card{} is played, gain {C:mult}+3{} Mult but {C:green}1 in 8{} chance to {C:red}self destruct{}",
    ],
    image_url: "img/j/gambler.png",
    rarity: "Common"
  },
  {
    name: "Coin Toss",
    text: [
      "When {C:attention}High Card{} is played, {C:attention}double{} sell value but {C:green}1 in 2{} chance to {C:red}self destruct{}",
    ],
    image_url: "img/j/coin_toss.png",
    rarity: "Common"
  },
  {
    name: "Oops! All 1s",
    text: [
      "Halves {C:green,E:1,S:1.1}probabilities{} but gains {C:mult}+1{} Mult when they succeed",
    ],
    image_url: "img/j/oops_all_1s.png",
    rarity: "Uncommon"
  },
  {
    name: "Call of the Void",
    text: [
      "Create a {C:spectral}Spectral{} card when {C:attention}Blind{} is selected, consumables can't be sold",
      "{C:inactive}(Must have room)",
    ],
    image_url: "img/j/call_of_the_void.png",
    rarity: "Rare"
  },
  {
    name: "Stone Tablet",
    text: [
      "{C:green}1 in 2{} chance to apply a {C:attention}Seal{} to scored {C:attention}Stone Cards{}",
    ],
    image_url: "img/j/stone_tablet.png",
    rarity: "Uncommon"
  },
  {
    name: "Globe",
    text: [
      "Allows {C:attention}Straights{} to wrap around",
      "{C:inactive}(ex: {C:attention}Q K A 2 3{C:inactive})",
    ],
    image_url: "img/j/globe.png",
    rarity: "Common"
  },
  {
    name: "Sector Map",
    text: [
      "When playing {C:attention}5{}-card {C:attention}poker hands{}, create the {C:planet}Planet{} for a {C:attention}5{}-card {C:attention}poker hand{}",
      "{C:inactive}(Must have room)",
    ],
    image_url: "img/j/sector_map.png",
    rarity: "Uncommon"
  },
  {
    name: "Whistleblower",
    text: [
      "When {C:attention}Blind{} is selected, create a Confidential {C:attention}Joker",
      "{C:inactive}(Must have room)",
    ],
    image_url: "img/j/whistleblower.png",
    rarity: "Common"
  },
  {
    name: "Bonus Joker",
    text: [
      "Retrigger all played {C:attention}Bonus{} cards"
    ],
    image_url: "img/j/bonus.png",
    rarity: "Uncommon"
  },
  {
    name: "Mult Joker",
    text: [
      "Retrigger all played {C:attention}Mult{} cards"
    ],
    image_url: "img/j/mult.png",
    rarity: "Uncommon"
  },
  {
    name: "Coloring Joker",
    text: [
       "All played scoring cards become {C:attention}random{} suits",
    ],
    image_url: "img/j/coloring.png",
    rarity: "Common"
  },
  {
    name: "Connect the Dots",
    text: [
        "Each played {C:attention}"+ranks[Math.floor(Math.random() * ranks.length)]+"{} earns {C:money}$1{} when scored",
        "{s:0.8}Rank decreases when scored"
    ],
    image_url: "img/j/connect_the_dots.png",
    rarity: "Common"
  },
  {
    name: "Rorschach Test",
    text: [
       "All played scoring cards become {C:attention}random{} ranks",
    ],
    image_url: "img/j/rorschach_test.png",
    rarity: "Common"
  },
  {
    name: "Tornado",
    text: [
        "{C:attention}+2{} hand size",
        "Discards held cards when hand is played",
    ],
    image_url: "img/j/tornado.png",
    rarity: "Uncommon"
  },
  {
    name: "Moai",
    text: [
        "{C:attention}Stone{} cards count as {C:attention}"+faces[Math.floor(Math.random() * faces.length)]+"{} of {C:"+moai_suit+"}"+moai_suit,
    ],
    image_url: "img/j/moai.png",
    rarity: "Uncommon"
  },
  {
    name: "Cryptogram",
    text: [
        "{C:attention}+2{} hand size",
        "First hand is drawn face down",
    ],
    image_url: "img/j/cryptogram.png",
    rarity: "Uncommon"
  },
  {
    name: "Cipher Wheel",
    text: [
        "{C:blue}+3{} Hands",
        "Cards drawn face down after each hand played",
    ],
    image_url: "img/j/cipher_wheel.png",
    rarity: "Uncommon"
  },
  {
    name: "Penrose Steps",
    text: [
        "When {C:attention}Blind{} is selected, increase the rank of {C:attention}all{} cards in deck by {C:attention}1{}",
    ],
    image_url: "img/j/penrose_steps.png",
    rarity: "Uncommon"
  },
  {
    name: "Gold Bar",
    text: [
        "Retrigger all played and held {C:attention}Gold{} cards"
    ],
    image_url: "img/j/gold_bar.png",
    rarity: "Uncommon"
  },
  {
    name: "Dyson Sphere",
    text: [
        "When a {C:attention}poker hand{} levels up, {C:green}1 in 3{} chance to instead level up your most played {C:attention}poker hand{}"
    ],
    image_url: "img/j/dyson_sphere.png",
    rarity: "Rare"
  },
  {
    name: "Eldritch Joker",
    text: [
        "No {C:planet}Planet{} or {C:tarot}Tarot{} cards in shop",
    ],
    image_url: "img/j/eldritch.png",
    rarity: "Uncommon"
  },
  {
    name: "Jimboel",
    text: [
        "{X:mult,C:white}X0.3{} Mult per {C:spectral}Spectral{} card used this run",
    ],
    image_url: "img/j/jimboel.png",
    rarity: "Rare"
  },
  {
    name: "Versatile Joker",
    text: [
        "{C:chips}+15{} Chips for each joker to the right",
        "{C:mult}+3{} Mult for each joker to the left",
    ],
    image_url: "img/j/versatile.png",
    rarity: "Common"
  },
  {
    name: "Book of the Dead",
    text: [
        "If {C:attention}first hand{} of round is a {C:attention}"+poker_hands[Math.floor(Math.random() * poker_hands.length)]+"{}, destroy it, poker hand changes at end of round",
    ],
    image_url: "img/j/book_of_the_dead.png",
    rarity: "Uncommon"
  },
  {
    name: "Ringworld",
    text: [
        "If {C:attention}poker hand{} is a {C:attention}"+poker_hands[Math.floor(Math.random() * poker_hands.length)]+"{}, level it up twice and poker hand changes to the next hand"
    ],
    image_url: "img/j/ringworld.png",
    rarity: "Uncommon"
  },
  {
    name: "Conveyor Belt",
    text: [
        "{C:blue}+4{} Hands",
        "Forces next {C:attention}5{} cards to be selected",
    ],
    image_url: "img/j/conveyor_belt.png",
    rarity: "Uncommon"
  },
  {
    name: "Clemens",
    text: [
        "{C:red}Bans{} sold cards",
        "{C:inactive}(Banned cards can't appear)",
    ],
    image_url: "img/j/clemens_bg.png",
    soul_url: "img/j/clemens_soul.png",
    rarity: "Legendary",
    soul: true
  },
  {
    name: "Orson",
    text: [
        "{C:purple}Legendary{C:attention} Jokers{} can naturally appear"
    ],
    image_url: "img/j/orson_bg.png",
    soul_url: "img/j/orson_soul.png",
    rarity: "Legendary",
    soul: true
  },
  {
    name: "Marshmallow",
    text: [
        "{X:mult,C:white}X3{} Mult",
        "destroyed by {C:attention}Fire{}",
    ],
    image_url: "img/j/marshmallow.png",
    rarity: "Uncommon"
  },
  {
    name: "Treasure Map",
    text: [
        "If hand has a {C:attention}Queen{} of {C:spades}Spades{}, {C:attention}9{} of {C:spades}Spades{}, {C:attention}Ace{} of {C:hearts}Hearts{}, {C:attention}2{} of {C:spades}Spades{} & {C:attention}Jack{} of {C:diamonds}Diamonds{}, earn {C:money}$30{} and destroy this card",
    ],
    image_url: "img/j/treasure_map.png",
    rarity: "Common"
  },
  {
    name: "Audience",
    text: [
        "When scored, played cards give {C:mult}+1{} Mult for each remaining card in {C:attention}deck{} with same {C:attention}rank{}",
    ],
    image_url: "img/j/audience.png",
    rarity: "Uncommon"
  },
  {
    name: "Mirror",
    text: [
        "If exactly {C:attention}2{} cards are discared, convert a random one into the other"
    ],
    image_url: "img/j/mirror.png",
    rarity: "Common"
  },
  {
    name: "Piggy Bank",
    text: [
        "Earn {C:money}$6{} at end of round, destroyed if money is spent"
    ],
    image_url: "img/j/piggy_bank.png",
    rarity: "Common"
  },
  {
    name: "Pillars",
    text: [
        "This Joker gains {C:mult}+2{} Mult when playing your least played {C:attention}poker hand",
    ],
    image_url: "img/j/pillars.png",
    rarity: "Common"
  },
  {
    name: "Sequel",
    text: [
        "Retrigger all played cards except the {C:attention}first{}",
    ],
    image_url: "img/j/sequel.png",
    rarity: "Rare"
  },
  {
    name: "Preserved Insect",
    text: [
        "{X:mult,C:white}X1.5{} Mult against {C:attention}Big Blinds{}",
        "{X:mult,C:white}X2{} Mult against {C:attention}Boss Blinds{}"
    ],
    image_url: "img/j/preserved_insect.png",
    rarity: "Uncommon"
  },
  {
    name: "Armory",
    text: [
        "{C:mult}+1{} Mult for each remaining {C:spades}Spade{} card in {C:attention}deck",
    ],
    image_url: "img/j/armory.png",
    rarity: "Common"
  },
  {
    name: "Compost",
    text: [
        "This Joker gains {C:mult}+2{} Mult for every {C:clubs}Club{} card discarded this round",
    ],
    image_url: "img/j/compost.png",
    rarity: "Common"
  },
  {
    name: "Red Joker",
    text: [
        "This Joker gains {C:mult}+3{} Mult on {C:attention}final hand{} of round",
    ],
    image_url: "img/j/red_joker.png",
    rarity: "Common"
  },
  {
    name: "The Rivals",
    text: [
        "{X:mult,C:white}X3{} Mult if played hand contains a {C:attention}Two Pair{}",
    ],
    image_url: "img/j/the_rivals.png",
    rarity: "Rare"
  },
  {
    name: "Reverse Card",
    text: [
        "Swap {C:chips}Chips{} and {C:mult}Mult{}"
    ],
    image_url: "img/j/reverse_card.png",
    rarity: "Uncommon"
  },
  {
    name: "Gold Ore",
    text: [
        "Played {C:attention}Stone{} and {C:attention}Gold{} cards give {C:chips}+25{} Chips and {C:gold}$2{} when scored"
    ],
    image_url: "img/j/gold_ore.png",
    rarity: "Uncommon"
  },
  {
    name: "Huge Joker",
    text: [
        "{C:red}-1{} Joker Slots,",
        "{X:mult,C:white}X2{} Mult",
    ],
    image_url: "img/j/joker.png",
    rarity: "Common"
  },
  {
    name: "Wooden Chest",
    text: [
        "After {C:attention}1{} round, sell this card to create an {C:green}Uncommon{} Joker",
    ],
    image_url: "img/j/wooden_chest.png",
    rarity: "Common"
  },
  {
    name: "Gilded Chest",
    text: [
        "After {C:attention}2{} rounds, sell this card to create a {C:red}Rare{} Joker",
    ],
    image_url: "img/j/gilded_chest.png",
    rarity: "Uncommon"
  },
  {
    name: "Hired Hand",
    text: [
        "Earn {C:money}$2{} per remaining {C:blue}hand{} at end of the round",
    ],
    image_url: "img/j/hired_hand.png",
    rarity: "Common"
  },
  {
    name: "Artifact",
    text: [
        "Create a {C:attention}Negative Tag{} when {C:attention}Boss Blind{} is defeated",
    ],
    image_url: "img/j/artifact.png",
    rarity: "Rare"
  },
  {
    name: "8-bit Joker",
    text: [
        "Each played {C:attention}2{}, {C:attention}4{}, or {C:attention}8{} gives {C:chips}+64{} Chips when scored",
    ],
    image_url: "img/j/8_bit_joker.png",
    rarity: "Uncommon"
  },
  {
    name: "Enhanced Joker",
    text: [
        "Played {C:attention}Enhanced{} cards give {C:mult}+5{} Mult when scored",
    ],
    image_url: "img/j/enhanced_joker.png",
    rarity: "Common"
  },
  {
    name: "Socialite",
    text: [
        "Every played {C:attention}Face Card{} permanently gains {C:white,X:mult}X0.1{} Mult when scored",
    ],
    image_url: "img/j/socialite.png",
    rarity: "Rare"
  },

  // {
  //   name: "",
  //   text: [
      
  //   ],
  //   image_url: "img/j/.png",
  //   rarity: "Common"
  // },
]

// works the same. 
let consumables = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Tarot"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Planet"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Spectral"
  // },
]

let card_modifications = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Enhancement"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Edition"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/sticker_example.png",
  //   rarity: "Seal"
  // },
]

let decks = [
  {
    name: "Average Deck",
    text: [
      "No {C:blue}Common{} or {C:red}Rare",
      "{C:attention}Jokers{} naturally appear"
    ],
    image_url: "img/b/average.png",
    rarity: "Deck"
  },
  {
    name: "VIP Deck",
    text: [
      "{C:attention}1{} card starts with a {C:attention}Seal{}, {C:enhanced}Enhancement{} and {C:dark_edition}Edition{}",
    ],
    image_url: "img/b/vip.png",
    rarity: "Deck"
  },
  {
    name: "Flow Deck",
    text: [
      "{C:attention}1{} free {C:green}Reroll{} per shop",
    ],
    image_url: "img/b/flow.png",
    rarity: "Deck"
  },
  {
    name: "Gravity Deck",
    text: [
      "Start run with a copy of {C:purple,E:1,T:c_black_hole}Black Hole{}"
    ],
    image_url: "img/b/gravity.png",
    rarity: "Deck"
  },
  {
    name: "Triangle Deck",
    text: [
      "Missing a {C:attention}Suit{}"
    ],
    image_url: "img/b/triangle.png",
    rarity: "Deck"
  },
  {
    name: "Rainbow Deck",
    text: [
      "Also has a {C:attention,T:e_wild}Wild{} card of each rank"
    ],
    image_url: "img/b/rainbow.png",
    rarity: "Deck"
  },
  {
    name: "Horror Deck",
    text: [
      "Prevents one death"
    ],
    image_url: "img/b/horror.png",
    rarity: "Deck"
  },
  {
    name: "Inverted Deck",
    text: [
      "Start run with a {C:attention}Negative Tag{} and a {C:attention}Clean Tag{}"
    ],
    image_url: "img/b/inverted.png",
    rarity: "Deck"
  },
  {
    name: "Royal Deck",
    text: [
      "Start run with {C:attention}2{} copies of each {C:attention}Face Card{}",
    ],
    image_url: "img/b/royal.png",
    rarity: "Deck"
  },
  {
    name: "Isometric Deck",
    text: [
      "{C:blue}Hands{} and {C:red}Discards{} carry over when {C:attention}Small{} or {C:attention}Big Blind{} is defeated",
      "Earn {C:money}$1{} per remaining {C:blue}Hand{} and {C:red}Discard{} when {C:attention}Boss Blind{} is defeated",
    ],
    image_url: "img/b/isometric.png",
    rarity: "Deck"
  },
  {
    name: "Ponzi Deck",
    text: [
      "Start with {C:attention}5{} copies",
      "of {C:joker,T:j_credit_card}Credit Card",
      "and {C:red}-$20",
    ],
    image_url: "img/b/ponzi.png",
    rarity: "Deck"
  },
]

let stickers = [
  {
    name: "Dormant",
    text: [
      "Debuffed until {C:attention}2{} rounds pass",
    ],
    image_url: "img/sticker/dormant.png",
    rarity: "Sticker"
  },
  {
    name: "Envious",
    text: [
      "Debuffed if you have another {C:green}Envious{} card"
    ],
    image_url: "img/sticker/envy.png",
    rarity: "Sticker"
  },
  {
    name: "Claustrophobic",
    text: [
      "Debuffed if Joker Slots are full",
    ],
    image_url: "img/sticker/claustrophobic.png",
    rarity: "Sticker"
  },
  {
    name: "Confidential",
    text: [
      "Hides card",
    ],
    image_url: "img/sticker/confidential.png",
    rarity: "Sticker"
  },
  {
    name: "Expensive",
    text: [
      "Costs more",
    ],
    image_url: "img/sticker/expensive.png",
    rarity: "Sticker"
  },
  {
    name: "Imprisoned",
    text: [
      "Debuffed until a {C:attention}Blind{} is skipped"
    ],
    image_url: "img/sticker/imprisoned.png",
    rarity: "Sticker"
  },
]

let blinds = [
  {
    name: "The Innocent",
    text: [
      "Excess score is added to the requirement of future blinds",
    ],
    image_url: "img/bl/innocent.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Rot",
    text: [
      "First 5th of deck is debuffed",
    ],
    image_url: "img/bl/rot.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Spire",
    text: [
      "Last 25 cards of deck are debuffed",
    ],
    image_url: "img/bl/spire.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Snow",
    text: [
      "Every 3rd card is debuffed",
    ],
    image_url: "img/bl/snow.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Lost",
    text: [
      "Bans the winning hand's planet card",
    ],
    image_url: "img/bl/lost.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Ascetic",
    text: [
      "No reward money",
    ],
    image_url: "img/bl/ascetic.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Elk",
    text: [
      "Cards played previously this Ante are drawn face down",
    ],
    image_url: "img/bl/elk.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Vein",
    text: [
      "Debuffs the leftmost Joker",
    ],
    image_url: "img/bl/vein.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Elite",
    text: [
      "All un-enhanced cards are debuffed",
    ],
    image_url: "img/bl/elite.png",
    rarity: "Boss Blind"
  },
  {
    name: "The Collective",
    text: [
      "All enhanced cards are debuffed",
    ],
    image_url: "img/bl/collective.png",
    rarity: "Boss Blind"
  },
  // {
  //   name: "Violet Vessel",
  //   text: [
  //     "Very large blind",
  //     "{C:inactive}({C:red}6x{C:inactive} Base for {C:attention}$$$$$$$${C:inactive})",
  //     "{C:inactive}(Appears from Ante 8)"
  //   ],
  //   image_url: "img/violet_vessel.png",
  //   rarity: "Showdown"
  // },
]

let shop_items = [
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Voucher"
  // },
  // {
  //   name: "Joker",
  //   text: [
  //     "{C:mult}+4{} Mult"
  //   ],
  //   image_url: "img/j_joker.png",
  //   rarity: "Pack"
  // },
]

let cols = {
  
  MULT: "#FE5F55",
  CHIPS: "#009dff",
  MONEY: "#f3b958",
  XMULT: "#FE5F55",
  FILTER: "#ff9a00",
  ATTENTION: "#ff9a00",
  BLUE: "#009dff",
  RED: "#FE5F55",
  GREEN: "#4BC292",
  PALE_GREEN: "#56a887",
  ORANGE: "#fda200",
  IMPORTANT: "#ff9a00",
  GOLD: "#eac058",
  YELLOW: "#ffff00",
  CLEAR: "#00000000", 
  WHITE: "#ffffff",
  PURPLE: "#8867a5",
  BLACK: "#374244",
  L_BLACK: "#4f6367",
  GREY: "#5f7377",
  CHANCE: "#4BC292",
  JOKER_GREY: "#bfc7d5",
  VOUCHER: "#cb724c",
  BOOSTER: "#646eb7",
  EDITION: "#ffffff",
  DARK_EDITION: "#5d5dff",
  ETERNAL: "#c75985",
  INACTIVE: "#ffffff99",
  HEARTS: "#f03464",
  DIAMONDS: "#f06b3f",
  SPADES: "#403995",
  CLUBS: "#235955",
  ENHANCED: "#8389DD",
  JOKER: "#708b91",
  TAROT: "#a782d1",
  PLANET: "#13afce",
  SPECTRAL: "#4584fa",
  VOUCHER: "#fd682b",
  EDITION: "#4ca893",
}

let rarities = {
  "Common": "#009dff", 
  "Uncommon": "#4BC292",
  "Rare": "#fe5f55",
  "Legendary": "#b26cbb",
  "Joker": "#708b91",
  "Tarot": "#a782d1",
  "Planet": "#13afce",
  "Spectral": "#4584fa",
  "Voucher": "#fd682b",
  "Pack": "#9bb6bd",
  "Enhancement": "#8389DD",
  "Edition": "#4ca893",
  "Seal": "#4584fa",
  "Deck": "#9bb6bd",
  "Sticker": "#5d5dff",
  "Boss Blind": "#5d5dff",
  "Showdown": "#4584fa",
}

regex = /{([^}]+)}/g;

let add_cards_to_div = (jokers, jokers_div) => {
  for (let joker of jokers) {
    console.log("adding joker", joker.name);
  
    joker.text = joker.text.map((line) => { return line + "{}"});
  
    joker.text = joker.text.join("<br/>");
    joker.text = joker.text.replaceAll("{}", "</span>");
    joker.text = joker.text.replace(regex, function replacer(match, p1, offset, string, groups) {
      let classes = p1.split(",");
  
      let css_styling = "";
  
      for (let i = 0; i < classes.length; i++) {
        let parts = classes[i].split(":");
        if (parts[0] === "C") {
          css_styling += `color: ${cols[parts[1].toUpperCase()]};`;
        } else if (parts[0] === "X") {
          css_styling += `background-color: ${cols[parts[1].toUpperCase()]}; border-radius: 5px; padding: 0 5px;`;
        }
      }
  
      return `</span><span style='${css_styling}'>`;
    });
  
    let joker_div = document.createElement("div");
    joker_div.classList.add("joker");
    if (joker.rarity === "Sticker" || joker.rarity == "Seal") {
      background = "hasback"
      if (joker.name == "Confidential") background = "redacted"
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" class="${background}" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else if (joker.soul) {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <span class="soulholder">
          <img src="${joker.image_url}" alt="${joker.name}" class="soul-bg" />
          <img src="${joker.soul_url}" alt="${joker.name}" class="soul-top" />
        </span>
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    } else {
      joker_div.innerHTML = `
        <h3>${joker.name}</h3>
        <img src="${joker.image_url}" alt="${joker.name}" />
        <h4 class="rarity" style="background-color: ${rarities[joker.rarity]}">${joker.rarity}</h4>
        <div class="text">${joker.text}</div>
      `;
    }
  
    jokers_div.appendChild(joker_div);
  }
}

if (jokers.length === 0) {
  document.querySelector(".jokersfull").style.display = "none"
} else {
  let jokers_div = document.querySelector(".jokers");
  add_cards_to_div(jokers, jokers_div);
}

if (consumables.length === 0) {
  document.querySelector(".consumablesfull").style.display = "none"
} else {
  let consumables_div = document.querySelector(".consumables");
  add_cards_to_div(consumables, consumables_div);
}

if (card_modifications.length === 0) {
  document.querySelector(".cardmodsfull").style.display = "none"
} else {
  let cardmods_div = document.querySelector(".cardmods");
  add_cards_to_div(card_modifications, cardmods_div);
}

if (decks.length === 0) {
  document.querySelector(".decksfull").style.display = "none"
} else {
  let decks_div = document.querySelector(".decks");
  add_cards_to_div(decks, decks_div);
}

if (stickers.length === 0) {
  document.querySelector(".stickersfull").style.display = "none"
} else {
  let stickers_div = document.querySelector(".stickers");
  add_cards_to_div(stickers, stickers_div);
}

if (blinds.length === 0) {
  document.querySelector(".blindsfull").style.display = "none"
} else {
  let blinds_div = document.querySelector(".blinds");
  add_cards_to_div(blinds, blinds_div);
}

if (shop_items.length === 0) {
  document.querySelector(".shopitemsfull").style.display = "none"
} else {
  let shopitems_div = document.querySelector(".shopitems");
  add_cards_to_div(shop_items, shopitems_div);
}