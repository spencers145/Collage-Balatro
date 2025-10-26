local magic_mirror = {
    object_type = "Joker",
    order = 202,

    key = "magic_mirror",
    config = {
      
    },
    rarity = 3,
    pos = { x = 15, y = 7},
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
        local active_text = localize('k_inactive')
        if G.GAME.jest_magic_mirror_trigger then 
            active_text = localize('k_active')
        else
            active_text = localize('k_inactive')
        end
        return { vars = {
            active_text
        }}
    end,
  
    calculate = function(self, card, context)
      if context.ante_end then
          G.GAME.jest_magic_mirror_trigger = true
      end
      if context.individual and context.cardarea == G.play then
        if G.GAME.jest_magic_mirror_trigger then
            local cardd = context.other_card
            if cardd:is_face() then
                G.GAME.jest_magic_mirror_trigger = false
                 G.E_MANAGER:add_event(Event({
                trigger = 'before', -- 'before' is good for effects during scoring
                delay = 0.2,      -- A small delay to let other effects resolve first
                func = function()
                    card:juice_up(0.6, 0.2)
                    cardd:juice_up(0.6, 0.2)
                    play_sound('negative', 1.5, 0.4)
                    cardd:set_edition({negative = true}, true, true) 
                    return true
                end
            }))
            end
        end
      end
    end
  
}
return { name = {"Jokers"}, items = {magic_mirror} }
