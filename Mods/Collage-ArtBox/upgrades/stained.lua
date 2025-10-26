SMODS.Enhancement({
  key = "stained",
  pos = { x = 1, y = 0 },
  discovered = true,
  no_rank = true,
  no_suit = true,
  replace_base_card = true,
  config = {
    extra = {
      odds = 2,
      destroy_odds = 10
    }
  },
  in_pool = function (self, args)
    return false
  end,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = {key = 'artb_mod_collectable_explain', set = 'Other'}
    local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'artb_stained')
    return {
      vars = {
        n,
        d,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.discard then
      if context.other_card == card then
        if SMODS.pseudorandom_probability(card, pseudoseed("artb_stained"), 1, card.ability.extra.odds, 'artb_stained') then
          if  #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            return {
              func = function()
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                --G.E_MANAGER:add_event(Event({
                  --func = (function()
                    G.E_MANAGER:add_event(Event({
                      func = function()
                        local chance = pseudorandom(pseudoseed("artb_stained_choice"))
                          if chance < 1/8 then
                            G.E_MANAGER:add_event(Event({
                              func = function()
                                unlock_card(G.P_CENTERS.b_artb_handmade)
                                local choice = poll_edition('artb_stained_edition', nil, true, true)
                                --print("got edition")
                                ArtBox.create_collectable(choice)
                                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                                return true
                              end
                            }))
                          elseif chance < 1/2 then
                            G.E_MANAGER:add_event(Event({
                              func = function()
                                local pool = get_current_pool('Seal')
                                local final_pool = {}
                                for k, value in pairs(pool) do
                                  if value ~= "UNAVAILABLE" and value ~= "vis_wooden" and value ~= "vis_mitosis" and value ~= "artb_ouroboros" then final_pool[k] = value end
                                end
                                --print(final_pool)

                                local choice = pseudorandom_element(final_pool, pseudoseed('artb_stained_seal'))
                                --print("got seal")
                                ArtBox.create_collectable(choice)
                                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                                return true
                              end
                            }))
                          else
                            G.E_MANAGER:add_event(Event({
                              func = function()
                                local pool = get_current_pool('Enhanced')
                                local final_pool = {}
                                for k, value in pairs(pool) do
                                  if value ~= "UNAVAILABLE" then final_pool[k] = value end
                                end
                                --print(final_pool)

                                local choice = pseudorandom_element(final_pool, pseudoseed('artb_stained_enhancement'))
                                --print("got enhancement")
                                ArtBox.create_collectable(choice)
                                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                                return true
                              end
                            }))
                          end
                        --[[SMODS.add_card {
                          set = 'art',
                          key_append = 'stained'
                        }
                        G.GAME.consumeable_buffer = 0]]
                        return true
                      end
                    }))
                    SMODS.calculate_effect({ message = localize('artb_plus_art'), colour = G.C.SET.DIVINE },
                      context.blueprint_card or card)
                    return true
                  --end)
                --}))
              end
            }
          end
          
        elseif SMODS.pseudorandom_probability(card, pseudoseed("artb_stained_destroy"), 1, card.ability.extra.odds, 'artb_stained_destroy') then
          -- maybe add back later
          --[[return {
            remove = true
          }]]
        end
        --[[if pseudorandom("stained") < G.GAME.probabilities.normal / card.ability.extra.super_odds then
          local tag = Tag("tag_artb_creative")
          add_tag(tag)
          return {
            message = localize('artb_plus_tag')
          }
        end]]
      end
    end
  end,
})

-- Render actual Stained sprite
SMODS.DrawStep {
  key = 'stained',
  order = 25,
  func = function(self, layer)
    if SMODS.has_enhancement(self, 'm_artb_stained') then
      if not ArtBox.stained_sprite then
        ArtBox.stained_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS['artb_enhancers_atlas'], { x = 1, y = 0 })
      end
      ArtBox.stained_sprite.role.draw_major = self
      if self.edition and not self.delay_edition then
        for k, v in pairs(G.P_CENTER_POOLS.Edition) do
          if self.edition[v.key:sub(3)] and v.shader then
            if type(v.draw) == 'function' then
              v:draw(self, layer)
            else
              ArtBox.stained_sprite:draw_shader(v.shader, nil, self.ARGS.send_to_shader, nil, self.children.center)
            end
          end
        end
        if self.edition.negative then
          ArtBox.stained_sprite:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil, self.children.center)
        end
      elseif not self:should_draw_base_shader() then
        -- Don't render base dissolve shader.
      elseif not self.greyed then
        ArtBox.stained_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' },
}

local shf = Card.should_hide_front
function Card:should_hide_front()
  if SMODS.has_enhancement(self, 'm_artb_stained') then return false end
  return shf(self)
end

-- Edition drawstep
SMODS.DrawStep {
    key = 'Stained_Edition',
    order = 21,
    func = function(self, layer)
        if self.edition and not self.delay_edition then
            for k, v in pairs(G.P_CENTER_POOLS.Edition) do
                if self.edition[v.key:sub(3)] and v.shader then
                    if type(v.draw) == 'function' then
                        v:draw(self, layer)
                    else
                        if self.children.front and SMODS.has_enhancement(self, 'm_artb_stained') then
                            self.children.front:draw_shader(v.shader, nil, self.ARGS.send_to_shader)
                        end
                    end
                end
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Debuff drawstep
SMODS.DrawStep {
    key = 'Stained_Debuff',
    order = 71,
    func = function(self, layer)
        if self.debuff and self.children.front and SMODS.has_enhancement(self, 'm_artb_stained') then
            self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Greyed drawstep
SMODS.DrawStep {
    key = 'Stained_Greyed',
    order = 81,
    func = function(self, layer)
        if self.greyed and self.children.front and SMODS.has_enhancement(self, 'm_artb_stained') then
            self.children.front:draw_shader('played', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}