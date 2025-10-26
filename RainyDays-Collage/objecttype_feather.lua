--to make sure players can collect enough feathers, even if they have lots of mods with high amounts of commons, we introduce our own rarity.
--this rarity will only spawn cards when the player already has at least one feather and there are still feathers left to collect.

--allows us to create a feather pool.
SMODS.ObjectType {
	key = 'Feather',
	default = 'j_RainyDays_feather_false'
}

--a special joker that transform into one of our absent feathers if spawned. this the one object with our special rarity, allowing us to easily control the feather amount.
SMODS.Joker {
  key = 'feather_false',
  name = 'RainyDays False Feather',
  atlas = 'Jokers',
  rarity = "RainyDays_feather",
  cost = 0,
  no_collection = true,
  unlocked = true, 
  discovered = true,
  pos = { x = 0, y = 0 },
}

--our custom rarity, consisting of just one card.
SMODS.Rarity {
  key = 'feather',
  loc_txt = { name = "Feather" },
  pools = { ["Joker"] = true },
  default_weight = 0.031,
  get_weight = function(self, weight, object_type)
    if GetFeatherCount() > 0 and #GetAbsentFeathers() > 0 then --we only spawn extra feathers if the player has at least one and feathers are available
      return 0.031 --if the player has no other extra rarities: then 0.031 / 1.031 * 100% = ~3% of jokers appearing will be feathers
    else
      return 0
    end
	end
}

--override of the create card. if the created card is our false feather, we transform it into a feather the player doesn't have yet
local old_func_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  local ret = old_func_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
  if ret.ability.name == 'RainyDays False Feather' then
    local absent_feathers = GetAbsentFeathers()
    if #absent_feathers > 0 then
      local feather_key = pseudorandom_element(absent_feathers, pseudoseed('Feathers' .. G.GAME.round_resets.ante))
      ret:set_ability(feather_key, true)
    else
      ret:set_ability('j_joker', true) --should never be reached, but lets play it safe
    end
    ret:set_cost()
  end
  return ret
end

function GetFeatherCount()
  local feather_count = 0
  if G.jokers and G.jokers.cards then
    for i = 1, #G.jokers.cards do
      local card = G.jokers.cards[i]
      local center = (type(card) == "string" and G.P_CENTERS[card]) or (card.config and card.config.center)
      if center and center.pools and center.pools.Feather then
        feather_count = feather_count + 1
      end
    end
  end
  return feather_count
end

function GetAbsentFeathers()
  local feathers_available = {}
  -- sometimes, the ccc feather is included...
  if math.random() > 0.75 then
    feathers_available = { --there probably is a function to simply pull all cards from the feather pool, but I am too tired to find out
      'j_RainyDays_feather_precious',
      'j_RainyDays_feather_silky',
      'j_RainyDays_feather_vibrant',
      'j_ccc_feather'
    }
  else
    local feathers_available = { --there probably is a function to simply pull all cards from the feather pool, but I am too tired to find out
      'j_RainyDays_feather_precious',
      'j_RainyDays_feather_silky',
      'j_RainyDays_feather_vibrant',
    }
  end
  
  if not next(SMODS.find_card('j_ring_master')) then --if the player has showman, feathers keep showing up at high rates and doubles will appear.
    for i = #feathers_available, 1, -1 do
      if G.GAME.used_jokers[feathers_available[i]] then --remove feathers already present in the game
        table.remove(feathers_available, i)
      end
    end
  end
  return feathers_available
end