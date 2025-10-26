local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.visibility_rate = 0 -- Poptart
    ret.last_spectral = nil -- Pact
    ret.last_divine = nil -- Mind
    return ret
end

-- Hook for Pact and Mind
local scu = set_consumeable_usage
function set_consumeable_usage(card)
    scu(card)
    if not (card.config.center_key and card.ability.consumeable) then return end
    if card.config.center.set == 'Spectral' then 
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.GAME.last_spectral = card.config.center_key
                        return true
                    end
                }))
                return true
            end
        }))
    end
    if card.config.center.set == 'Divine' then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.GAME.last_divine = card.config.center_key
                        return true
                    end
                }))
                return true
            end
        }))
    end
    G:save_settings()
end

-- Bugfix for Ankh in Black Market Pack
local cu = Card.check_use
function Card:check_use()
    if self.ability.name == "Ankh" and G.pack_cards and G.pack_cards.cards then
        for _, v in ipairs(G.pack_cards.cards) do
            if v == self then
                return false
            end
        end
    end
    
    local ret = cu(self)
    return ret
end

local function reset_impact_frame_card()
    G.GAME.current_round.vis_impact_frame_card = { rank = 'Ace', suit = 'Spades' }
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local idol_card = pseudorandom_element(valid_cards, pseudoseed('vis_impact_frame' .. G.GAME.round_resets.ante))
    if idol_card then
        G.GAME.current_round.vis_impact_frame_card.rank = idol_card.base.value
        G.GAME.current_round.vis_impact_frame_card.suit = idol_card.base.suit
        G.GAME.current_round.vis_impact_frame_card.id = idol_card.base.id
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_impact_frame_card()
end


-- This is stolen from Cryptid.
local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    smcmb(obj, badges)
    if not obj or not obj.credits then return end
    local function calc_scale_fac(text)
        local size = 0.9
        local font = G.LANG.font
        local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
        local calced_text_width = 0
        -- Math reproduced from DynaText:update_text
        for _, c in utf8.chars(text) do
            local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
                + 2.7 * 1 * G.TILESCALE * font.FONTSCALE
            calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
        end
        local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
        return scale_fac
    end
    local scale_fac = {}
    local scroll_text = { "Visibility" }
    if obj.credits then
        local min_scale_fac = 1
        for k, v in pairs(obj.credits) do
            if k == "developer" then
                scroll_text[#scroll_text+1] = "It's a self-insert!"
                goto continue
            end
            scroll_text[#scroll_text+1] = localize({type = "variable", key = "vis_"..k, vars = { v } })
            ::continue::
        end
        for i = 1, #scroll_text do
            scale_fac[i] = calc_scale_fac(scroll_text[i])
            min_scale_fac = math.min(min_scale_fac, scale_fac[i])
        end
        local ct = {}
        for i = 1, #scroll_text do
            ct[i] = {
                string = scroll_text[i],
            }
        end
        local badge = {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        colour = HEX("BDC3C7"),
                        r = 0.1,
                        minw = 2 / min_scale_fac,
                        minh = 0.36,
                        emboss = 0.05,
                        padding = 0.03 * 0.9,
                    },
                    nodes = {
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = ct or "ERROR",
                                    colours = { G.C.WHITE },
                                    silent = true,
                                    float = true,
                                    shadow = true,
                                    offset_y = -0.03,
                                    spacing = 1,
                                    scale = 0.33 * 0.9,
                                }),
                            },
                        },
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                    },
                },
            },
        }
        local function eq_col(x, y)
            for i = 1, 4 do
                if x[1] ~= y[1] then
                    return false
                end
            end
            return true
        end
        for i = 1, #badges do
            if eq_col(badges[i].nodes[1].config.colour, HEX("BDC3C7")) then
                badges[i].nodes[1].nodes[2].config.object:remove()
                badges[i] = badge
                break
            end
        end
    end

end

-- Graffiti
local has = SMODS.has_any_suit
function SMODS.has_any_suit(card)
    local ret = has(card)
    if #SMODS.find_card("j_vis_graffiti") < 1 then return ret end 
    for k, _ in pairs(SMODS.get_enhancements(card)) do
        if k == 'm_stone' or k == 'm_vis_brick' then return true end
    end
    return ret
end

local hns = SMODS.has_no_suit
function SMODS.has_no_suit(card)
    local ret = hns(card)
    if #SMODS.find_card("j_vis_graffiti") < 1 then return ret end 
    local is_suitless = false
    for k, _ in pairs(SMODS.get_enhancements(card)) do
        if k == 'm_stone' or k == 'm_vis_brick' then is_suitless = true end
    end
    return not is_suitless
end