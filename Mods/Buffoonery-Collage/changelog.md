<sup>Supported languages:</sup> [![pt-br](https://img.shields.io/badge/lang-pt--br-green.svg)](https://github.com/pinkmaggit-hub/Buffoonery/blob/main/changelog.pt-br.md) [![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/pinkmaggit-hub/Buffoonery/blob/main/changelog.md)

# v1.2.0
### Additions
**Jokers:**
- Bitter Ex-Fan (Special)
- Echo of The Abyss (Special)
- Integral (Special)
- Kerman Reborn (Special)
- Supportive Joker (Special)
- Van (Special)
- JokerGebra (Uncommon)
- Sayajimbo (Uncommon)
- Tailored Suit (Uncommon)
- Let Me Solo Her (Rare)

**Stakes:**
- Palladium (after Gold Stake) and Spinel (After Palladium Stake)

**Deck / Sleeve:**
- Sandstone
### Polish
- _Jebediah Kerman_'s artwork now dynamically changes based on last planet used. All Vanilla planets included
- "Banish" mechanic from _Abyssal Prism_ replaced with "Exile". Exiled cards keep all their properties and Eternal ones can be exiled.
- Added custom gradients for Exponential Mult and Exponential Chips text
- Removed "Memory Card Performance Mode" toggle from settings, as it is no longer needed
- Special cards are now shown in collection by default
- All jokers are now undiscovered by default
- Added "Soul" card unlock requirement for _Maggit_
- Added an unlock requirement for _Galloping Deck_
- Added a Credits tab
### Balance
- Nerfed Roulette: money increases with chance, starts at $15
- Reverted Gold Fondue to $8/-$2
### Bugfixing
- Fixed _Clown_ upgrading by 20 the first time, instead of 15
- Fixed _Clown_'s scaling bugging out or being lost when starting a new run
- Fixed _Patronizing Joker_ not selecting cards during Cerulean Bell bossfight
- Fixed _Erosion_ not working properly with the _Porcelain Deck_
- Fixed _Memory Card / Clay Shooting_ shaking too much
- Fixed _Abyssal Prism_ not properly accounting for already-negative Jokers inside it when converting the others into negatives
- Fixed _Abyssal Prism_ crashing the game when continuing a run and trying to sell it
- Fixed _Galloping Deck + Sleeve_ showing 4 hands left before selecting the first blind, instead of 2


# v1.1.8
### New Language!
- Simplified Chinese localization by Ethylene

# v1.1.7
### Bugfixing
- Fixed Nobility crashing the game when trying to convert an already enhanced card into a (Royal) Porcelain Card, when Bunco is installed.
### Polish
- Made the "JOKER" text in Clay Shooting's artwork more closely follow its palette.

# v1.1.6
### Compatibility & bugfixing
- Fixed (Royal) Porcelain Cards copied by Extra Credit's Ship of Theseus breaking when they shouldn't
- Russian Roulette now destroys itself when adding a legendary Joker to make room for it

# v1.1.5
### New language!
- Russian localization by BurAndBY
### Bugfixing
- Fixed (royal) porcelain cards breaking randomly and erratically when kept in hand after play

# v1.1.4
### Fixes & Polish
- Fixed borked Emult jokers
- Clay Shooting now jiggles when relevant hand is current (Suggested by Lykrast)
- Dorkshire Tea no longer converts Royal Porcelain Cards to normal Porcelain Cards
- Porcelain Joker now only appears when the player has (Royal) Porcelain Cards in their deck

# v1.1.3
### Fixes
- Fixed Clay Shooting not updating when added mid round
- Added own emult sound

# v1.1.2
**REQUIREMENTS: STEAMODDED 1.0.0~ALPHA-1321c OR NEWER
### Compatibility
- <ins>***[Talisman](https://github.com/MathIsFun0/Talisman/) is now optional***</ins> but recommended for the xchips and emult sound fx.

*NOTE: If you decide to use Talisman, use v2.0.3. If it's not in the releases section of Talisman, download the source code and use that.*
- Fixed Patronizing Joker not selecting 5 cards with [Bunco](https://github.com/Firch/Bunco) installed
- Cards with a rank from [UnStable](https://github.com/kirbio/UnStable) that starts with "T" now work with *Dorkshire Tea/Gold*
### Balance
+ *Clown*: Chips & Chip gain 20(+20) --> 15(+15)
+ *Gold Fondue*: Gold $8 --> $9, Gold loss -$2 -> -$3
+ *Jebediah Kerman*: Mult gain +10 --> +8, Chance 1 in 5 --> 1 in 6
+ *Pertinent Argument*: chance 1 in 2 --> Always
### Polish & Fixes
- Artwork polish: *Nobility* and *Gold Fondue*
- *Clay Shooting* artwork polish
- *Russian Roulette* description text polish
- *Patronizing Joker* now Only plays the card selection sound once instead of 5 times
- Made *Patronizing Joker* deselect cards when sold
- Added Porcelain Card info to *Porcelain Joker*
- *Dorkshire Tea/Gold* now only shows the "Tea!" message if the relevant cards are played and only once. 

# v1.1.0
**REQUIREMENTS: STEAMODDED 1.0.0~ALPHA-1315b OR NEWER *AND* [TALISMAN](https://github.com/MathIsFun0/Talisman/)** 
### Additions
**Jokers:**
+ Adoring Fan (Common)
+ Gold Fondue (Common)
+ Camarosa (Common)
+ Clay Shooting (Common)
+ Porcelain Joker (Uncommon)
+ Dorkshire Tea (Rare)
+ Dorkshire Gold (Special)

**Enhancements:**
+ Porcelain Card
+ Royal Porcelain Card (Special)

*Tarot:*
+ Nobility

**Deck / Sleeve:**
+ Porcelain
### New config options
+ Show *Special* cards in collection (3 Jokers and 1 Enhancement)  **-- Default: off**
+ Show tooltips (arist credits and new mechanics explanations)       **-- Default: on**
+ Memory card performance mode                                                   **-- Default: off**
### Polish & Fixes
+ Aesthetic changes to some jokers' descriptions to better fit vanilla style
+ Made *Memory Card's* description better fit with [Bunco's](https://github.com/Firch/Bunco) suit icons if they're present
+ Made *Memory Card's* description compatible with [UnStable's](https://github.com/kirbio/UnStable) ranks
+ Fixed stray pixels and wrong spacing in some artworks
+ Fixed *Memory Card* crashing the game with modded enhancements
+ Rewrote *Clown* to fix buggy code
+ Fixed *Rerrolin'* bugging out with *Blueprint*
+ Fixed the text on jokers with "1 in X chance" to update with *Oops! All 6s*
+ All content is translated to Brazilian Portuguese
## v1.1.0-hotfix
+ Fixed an oversight in *Memory Card*'s code during development (it was memorizing not only during the first hand, as it should)
+ Add pseudo-compatibility between Memory Card and [Collector's Cards](https://github.com/Mathguy23/CollectorsCards) (crash prevention)

# v1.0.0
**REQUIREMENT: STEAMODDED 1.0.0~ALPHA-1103a OR NEWER**
## Additions
**Jokers:**
+ Russian Roulette (Uncommon)
+ Abyssal Prism (Rare)
### Polish & Fixes
+ Fully translated every piece of text in the mod to Brazilian Portuguese
+ Updated mod description
+ Added mod icon
+ Clown now tells player when upgraded
+ Memory Card now jiggles until a card is memorized
+ Fixed Korny not working
+ Fixed Memory Card keeping changes made after memorizing the card(s)
+ Fixed a game-crashing typo in Black Stallion's code
### Balance
+ Buffed Arstotzkan Denial and made its description more clear
+ Buffed Cashout Voucher to make it more useable early game
+ Slight buff to Korny
## v1.0.1
+ Patronizing Joker now always selects 5 cards, like the Cerulean Bell blind on steroids. This is the original intended effect.
+ Five Fingers now costs $5, for flavor purposes
+ Artwork polish (Jeb and Laidback)
+ pt_BR localization polish

# v0.9.0
### Additions:
- Special rarity

**Jokers:**
- Black Stallion (Special)
- Deluxe Memory Card (Special)

**Decks / Sleeves:**
- JimboStation
- Galloping


### Fixes & Polish
- Fixed Memory Card crashing the game when cards to convert > hand size
- Made Maggit's description more concise
- Added better color coding to Rerollin's description

# v0.8.0
### Additions
**Jokers:**
- Jebediah Kerman (Common)
- Arstotzkan Denial (Uncommon)
- Clown (Uncommon)
- Patronizing Joker (Rare)
- Maggit (Legendary)
### Fixes & Polish
- Laidback Joker now can't be bought if player has less than 2 free slots
- Added Talisman compatibility to Cashout Voucher
- Five fingers now accepts hands that contains a number of jokers that is a multiple of 5 (5,10,15,20...)
- Korny Joker now has truly random chances of dying, beacuse you don't know the chances... What if he should diiiiiiiiiiiiiiiiiiiiiiiie????
- Made Memory Card's art more compatible with stickers
- Made Rerollin's artwork less horrible and added "Joker" to it
- Made a placeholder art for jokers with unfinished art during development
- Updated Korny Joker's description to be less horizontal and more vertical
## v0.8.1
- Fixed Maggit crashing the game when creating a joker (whoops)
- Translated the jokers to Brazilian Portuguese
- Made Jeb's art better

# v0.5.0
### Additions:
**Jokers**
- Five Fingers (Common)
- Laidback Joker (Common)
- Pertinent Agrument (Uncommon)
### Fixes & Polish
- Added original artwork credits to cards that have an original artwork by someone else and edited by me (korny and rerollin)
- Updated Rerollin's description adding reroll count
- Updated Rerrolin's artwork, making pinky finger more rounded
- Updated Memory Card. It now copies cards' enhancements and editions (modded ones too)
## v0.5.1
- Minor tweaks to some of the artwork to better fit Balatro's artstyle
- Changed Five Fingers from uncommon ($6) to common ($4)
## v0.5.2
- Added modded suit compatibility to Memory Card.

# v0.2.0
### Additions:
**Jokers**
- Cashout Voucher (Common)
- Rerollin' (Uncommon)
- Memory Card (Rare)
## v0.2.2
- Updated README.md to better fit joker descriptions
- Added a flag to prevent Korny Joker from respawning
- Added memorized card counter and last card memorized info to Memory Card's description
- Added Xchips and Emult functionality
## v0.2.3
- Updated Memory Card's art (made the 8 higher res)
- Made Korny Joker and Memory Card's descriptions less verbose

# v0.1.0
### Additions:
**Jokers**
- Korny Joker (Common)
- White Pony (Uncommon)
