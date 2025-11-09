function PL_UTIL.wild_card_count()
  local count = 0
  if G.playing_cards then
    for k, v in pairs(G.playing_cards) do
      if v.config.center == G.P_CENTERS.m_wild then count = count + 1 end
    end
  end
  return count
end

function PL_UTIL.add_booster_pack()
  if not G.shop then return end
  local pack = SMODS.create_card({ set = 'Booster', key_append = 'pl_popup'..G.GAME.round_resets.ante })
  pack.T.w = G.CARD_W * 1.27
  pack.T.h = G.CARD_H * 1.27
  
  G.shop_booster:emplace(pack)

  create_shop_card_ui(pack, 'Booster', G.shop_booster)
  pack:start_materialize()
  pack:set_card_area(G.shop_booster)
  pack:juice_up()
end

function PL_UTIL.reroll_booster_packs(justone)
  if not G.shop then return end

  local pack_count = #G.shop_booster.cards

  if pack_count <= 0 then return end

  if justone then
    G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
    G.GAME.current_round.used_packs[1] = get_pack('shop_pack').key 
    local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2, G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[1]], {bypass_discovery_center = true, bypass_discovery_ui = true})
    create_shop_card_ui(card, 'Booster', G.shop_booster)
    card.ability.booster_pos = 1
    card:start_materialize()
    G.shop_booster:emplace(card)

    local c = G.shop_booster:remove_card(G.shop_booster.cards[1])
    c:remove()

    if G.GAME.collage_boosters_purchased_this_shop >= 2 and not G.GAME.used_vouchers['v_ortalab_catalog'] then
      card:set_debuff(true)
    end
  else
    for i=1, pack_count do
      G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
      G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key 
      local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2, G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[i]], {bypass_discovery_center = true, bypass_discovery_ui = true})
      create_shop_card_ui(card, 'Booster', G.shop_booster)
      card.ability.booster_pos = i
      card:start_materialize()
      G.shop_booster:emplace(card, i)

      local c = G.shop_booster:remove_card(G.shop_booster.cards[i])
      c:remove()
      c = nil
      if G.GAME.collage_boosters_purchased_this_shop >= 2 and not G.GAME.used_vouchers['v_ortalab_catalog'] then
        card:set_debuff(true)
      end

    end
  end
  


  

end

NametagCompatible = {}

function PL_UTIL.AddNametagJokerNames()
  NametagCompatible = {}

  for _, mod in ipairs(SMODS.mod_list) do
    if mod.can_load and NFS.getInfo(mod.path .. 'localization/en-us.lua') then
      local loc_file = assert(loadstring(NFS.read(mod.path .. 'localization/en-us.lua'))())
      if loc_file and loc_file.descriptions and loc_file.descriptions.Joker then
        for k, v in pairs(loc_file.descriptions.Joker) do
          if v.name then
            if string.find(v.name, "Joker") or string.find(v.name, "joker") then
              NametagCompatible[k] = k
            end
          end
        end
      end
    end
  end

  local vanilla_loc_file = assert(loadstring(love.filesystem.read('localization/en-us.lua'))())
  if vanilla_loc_file and vanilla_loc_file.descriptions and vanilla_loc_file.descriptions.Joker then
    for k, v in pairs(vanilla_loc_file.descriptions.Joker) do
      if v.name then
        if string.find(v.name, "Joker") or string.find(v.name, "joker") then
          NametagCompatible[k] = k
        end
      end
    end
  end
end