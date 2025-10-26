SMODS.Atlas {
  key = 'Jokers',
  path = 'Jokers.png',
  px = 71,
  py = 95 
}

local JokerAtlasKeys = {
  'burdenofgreatness',
  'cloverfield',
  'flipflop_even',
  'feather_precious',
  'feather_silky',
  
  'feather_vibrant',
  'sediment',
  'heirloom',
  'kintsugi',
  'lotteryticket',
  
  'microwave',
  'bankaccount',
  'truffle',
  'cleanslate',
  'waste_not',
  
  'flipflop_odd',
  'kintsugi_vase',
  'fabergeegg',
  'sextant',
  'hannysvoorwerp',
  
  'sputnik',
  'breakfast_cereal',
  'atom',
  'lady_of_the_lake',
  'kudzu'
}

local JokerAtlasTable = {}
for i, key in ipairs(JokerAtlasKeys) do
  JokerAtlasTable[key] = i - 1
end
JokerAtlasKeys = nil

function GetJokersAtlasTable(key)
  local pos = JokerAtlasTable[key]
  return { x = pos % 5, y = math.floor(pos / 5) }
end

SMODS.Atlas {
  key = 'Constellations',
  path = 'Constellations.png',
  px = 65,
  py = 95
}

local ConstellationAtlasKeys = {
  'aries',
  'taurus',
  'gemini',
  'cancer',
  'leo',
  'virgo',
  
  'libra',
  'scorpio',
  'sagittarius',
  'capricorn',
  'aquarius',
  'pisces',
  
  'pegasus',
  'cetus',
  'ophiuchus',
  'orion',
  'vulpecula',
  'chamaeleon'
}

local ConstellationAtlasTable = {}
for i, key in ipairs(ConstellationAtlasKeys) do
  ConstellationAtlasTable[key] = i - 1
end
ConstellationAtlasKeys = nil

function GetConstellationAtlasTable(key)
  local pos = ConstellationAtlasTable[key]
  return { x = pos % 6, y = math.floor(pos / 6) }
end

SMODS.Atlas {
  key = 'Seals',
  path = 'Seals.png',
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = 'Spectrals',
  path = 'Spectrals.png',
  px = 71,
  py = 95 
}

SMODS.Atlas {
  key = 'Tags',
  path = 'Tags.png',
  px = 34,
  py = 34
}