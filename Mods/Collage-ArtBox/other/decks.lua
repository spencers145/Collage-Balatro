
  SMODS.Back {
    key = 'handmade',
    atlas = 'enhancers_atlas',
    pos = { x = 3, y = 0 },
    config = {
      vouchers = {
        'v_artb_pen_holder'
      },
    },

    unlocked = false,

    loc_vars = function(self, info_queue)
      return {
        vars = {
          localize { type = 'name_text', key = 'v_artb_pen_holder', set = 'Voucher' },
        }
      }
    end,

    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
			func = function()

        local edition = poll_edition('handmade', nil, true, true)
        ArtBox.create_collectable(edition)

        local valid_keys = {}
        for _, seal_center in pairs(G.P_CENTER_POOLS["Seal"]) do
            valid_keys[#valid_keys + 1] = seal_center.key
        end
		ArtBox.create_collectable(pseudorandom_element(valid_keys, pseudoseed("handmade")))

        local new_enhancement = SMODS.poll_enhancement({guaranteed = true, key = 'handmade'})
        ArtBox.create_collectable(new_enhancement)

			return true
		end
		}))
        
    end
  }

  SMODS.Back {
      key = 'box',
      atlas = 'enhancers_atlas',
      pos = { x = 4, y = 0 },
      config = {
        vouchers = {
          'v_ortalab_home_delivery'
        },
      },
      unlocked = false,

      loc_vars = function(self, info_queue)
        return {
          vars = {
            localize { type = 'name_text', key = 'v_ortalab_home_delivery', set = 'Voucher' },
            localize { type = 'name_text', key = 'c_artb_gros_michel_collectable', set = 'collectable' },
          }
        }
      end,

      apply = function (self, back)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    local added_card = SMODS.add_card({key = 'c_artb_gros_michel_collectable'})
                    added_card:add_sticker('perishable', true)
                end
                return true
            end
        }))
      end
  }
