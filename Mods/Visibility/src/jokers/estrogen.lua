-- Estrogen
SMODS.Joker {
	key = 'estrogen',
	config = { extra = { } },
	blueprint_compat = false,
	eternal_compat = true,
	unlocked = true,
	discovered = false,
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 3, y = 1 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return { vars = {  } }
	end,
	calculate = function(self, card, context)
        if context.using_consumeable and (context.consumeable.ability.name == 'Strength' or context.consumeable.ability.name == 'c_vis_weakness') then
            for k, v in pairs(G.hand.highlighted) do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local suit_prefix = string.sub(v.base.suit, 1, 1)
                    v:set_base(G.P_CARDS[suit_prefix..'_Q'])
                return true end }))
            end
            return { message = 'Go Girls!' }
        end
    end,
}