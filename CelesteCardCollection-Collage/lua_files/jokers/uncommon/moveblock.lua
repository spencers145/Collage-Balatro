-- region Move Block

local moveblock = {
	name = "ccc_Move Block",
	key = "moveblock",
	config = {extra = {mult = 0, mult_scale = 1}},
	pos = {x = 5, y = 5},
	pixel_size = { w = 71, h = 91 },
	rarity = 2,
	cost = 5,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = "j_ccc_jokers",
	credit = {
		art = "9Ts",
		code = "toneblock",
		concept = "9Ts"
	},
    description = "+1 XMult per discard, resets if playing hand contains a pair"
}

moveblock.calculate = function(self, card, context)
	if context.discard then
		if not context.blueprint and context.other_card == context.full_hand[#context.full_hand] then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_scale
			return {
				card = card,
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult_scale}}
                        }
		end
	end
	if context.before and not context.blueprint then
		if next(context.poker_hands['Three of a Kind']) then
			card.ability.extra.mult = 0
			return {
				message = localize('k_reset')
			}
		end
	end
	if context.joker_main then
		if card.ability.extra.mult ~= 0 then
			return {
				message = localize {
					type = 'variable',
					key = 'a_mult',
					vars = { card.ability.extra.mult }
                		},
				mult_mod = card.ability.extra.mult
                	}
		end
	end
end

function moveblock.loc_vars(self, info_queue, card)
	return {vars = {card.ability.extra.mult_scale, card.ability.extra.mult}}
end

-- better way to do this probably
-- for now i'm the hookmaster

local mblockcupdref = Card.update
function Card:update(dt)
	
	if self.config.center.key == 'j_ccc_moveblock' then
		local _dt = G.TIMERS.REAL - (self.old_timer or G.TIMERS.REAL)
		self.moveblock_active = self.moveblock_active or 0
		if self.states.focus.is or self.states.drag.is or self.highlighted then
			self.moveblock_active = math.min(self.moveblock_active + _dt, 1)
		else
			self.moveblock_active = math.max(self.moveblock_active - _dt, 0)
		end
		self.old_timer = G.TIMERS.REAL
	end
	if mblockcupdref then
		mblockcupdref(self, dt)
	end
end

local mblockdrawref = Card.draw
function Card:draw(layer)
	if self.config.center.key == 'j_ccc_moveblock' then
		moveblock:set_sprites(self)
	end
	if mblockdrawref then
		mblockdrawref(self, layer)
	end
end

function moveblock.set_sprites(self, card, front)
	local _pr = G.ASSET_ATLAS["ccc_moveblock_pr"]
	local _rl = G.ASSET_ATLAS["ccc_moveblock_rl"]
	local pos = {x = 0, y = 0}
	local active = card.moveblock_active or 0
	local current = card.states.drag.is and _pr or _rl
	if active > 0.01 then
		active = tostring(math.floor((active * 100) - 1))
		active = #active < 2 and '0'..active or ''..active
		pos = {x = tonumber(string.sub(active, 2, 2)), y = tonumber(string.sub(active, 1, 1))}
	else
		pos = {x = 5, y = 5}
		current = G.ASSET_ATLAS["ccc_j_ccc_jokers"]
	end
	if not card.old_pos then card.old_pos = {x = pos.x, y = pos.y} end
	if not card.old_at then card.old_at = current end
	if card.old_pos.x ~= pos.x or card.old_pos.y ~= pos.y or card.old_at ~= current then
		card.children.center.atlas = current
		card.children.center:set_sprite_pos(pos)
	end
	card.old_pos.x = pos.x
	card.old_pos.y = pos.y
	card.old_at = current
end

return moveblock
-- endregion Move Block