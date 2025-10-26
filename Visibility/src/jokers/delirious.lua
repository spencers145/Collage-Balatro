SMODS.Joker {
	key = "delirious",
	config = { vis_is_delirious = true, vis_saved = 1 },
	rarity = 2,
	discovered = false,
	unlocked = true,
	eternal_compat = true,
	blueprint_compat = false,
	pools = { ["Visibility"] = true },
	atlas = "TextureAtlasJokers",
	pos = { x = 9, y = 4 },
	credits = {
        idea = "StickieAnimates",
        art = "StickieAnimates",
		semi_remix = "Monachrome",
    },
	cost = 6
}

local joker_list = {
	"j_baron",
	"j_dna",
	"j_baseball",
	"j_stuntman",
	"j_ancient",
	"j_blueprint",
	"j_vagabond",
	"j_obelisk",
	"j_brainstorm",
}

function change_delirious_texture(card, restore)
	local atlas = "vis_TextureAtlasJokers"
	local x = 9
	if not restore then
		atlas = "vis_TextureAtlasDelirious"
		for i, j in ipairs(joker_list) do
			if j == card.config.center.key then
				x = i - 1
				break
			end
		end
	end
    card.children.center = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[atlas], { x = x, y = restore and 4 or 0 })
    card.children.center.states.hover = card.states.hover
    card.children.center.states.click = card.states.click
    card.children.center.states.drag = card.states.drag
    card.children.center.states.collide.can = false
    card.children.center:set_role({major = card, role_type = 'Glued', draw_major = card})
end

SMODS.Joker:take_ownership("dna", {
	calculate = function(self, card, context)
        if context.before and context.main_eval and (G.GAME.current_round.hands_played == 0 or card.ability.vis_is_delirious) and #context.full_hand == 1 then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local copy_card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            copy_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy_card)
            G.hand:emplace(copy_card)
            copy_card.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    copy_card:start_materialize()
                    return true
                end
            }))
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                func = function() -- This is for timing purposes, it runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                            return true
                        end
                    }))
                end
            }
        end
    end
}, true)

-- Implementation
local cja = SMODS.calculate_card_areas
function SMODS.calculate_card_areas(_type, context, return_table, args)
	local flags = cja(_type, context, return_table, args)
	if _type ~= "jokers" then return flags end
	if not context.after and not context.setting_blind then return flags end
	for _, _card in ipairs(G.jokers.cards) do
		local is_delirious = _card.ability.vis_is_delirious
		if not is_delirious then goto continue end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.35,
			func = function()
				change_joker(_card)
				return true
			end
		}))
		::continue::
	end
	return flags
end

local cl = Card.load
function Card:load(cardTable, other_card)
	local ret = cl(self, cardTable, other_card)
	if self.ability.vis_is_delirious then
		change_delirious_texture(self, self.config.center.key == "j_vis_delirious")
	end
	return ret
end

local e_round = end_round
function end_round()
	e_round()
	-- Restore delirious
	for _, _card in ipairs(G.jokers.cards) do
		if not _card.ability.vis_is_delirious then goto continue end
		if _card.ability.x_mult then _card.ability.vis_saved = _card.ability.x_mult end
		do_the_tony_hawk(_card, "j_vis_delirious")
		::continue::
	end
end

function change_joker(card)
	if G.GAME.chips >= G.GAME.blind.chips then return end -- Nuh uh
	local random_joker, random_joker_key = pseudorandom_element(joker_list, pseudoseed('j_vis_delirious'))
	if card.label == "Obelisk" then 
		card.ability.vis_saved = card.ability.x_mult
	end
	do_the_tony_hawk(card, random_joker)
	if random_joker == "j_obelisk" then
		card.ability.x_mult = card.ability.vis_saved or 2
	end
end

function do_the_tony_hawk(card, joker_to_set)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.15,
		func = function()
			play_sound('tarot1')
			card:flip()
			card:juice_up(0.3, 0.3)
			return true
		end
	}))
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.3,
		func = function()
			card:set_ability(G.P_CENTERS[joker_to_set])
			change_delirious_texture(card, joker_to_set == "j_vis_delirious")
			return true
		end
	}))
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.55,
		func = function()
			play_sound('tarot2')
			card:flip()
			card:juice_up(0.3, 0.3)
			return true
		end
	}))
end