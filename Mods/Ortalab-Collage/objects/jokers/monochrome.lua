
SMODS.Atlas({
    key = 'monochrome',
    path = 'monochrome_joker.png',
    px = '71',
    py = '95'
})
SMODS.Joker({
	key = "monochrome",
	atlas = "monochrome",
	pos = {x = 0, y = 0},
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    config = {extra = {dt = 0}},
    artist_credits = {'crimson','eremel'},
    set_sprites = function(self, card, front)
        if not card.config.center.discovered then return end
        card.children.center.atlas = {
            px = 71, py = 95, name = 'ortalab_monochrome',
            image_data = G.ASSET_ATLAS['ortalab_monochrome'].image_data:clone(),
            image = love.graphics.newImage(G.ASSET_ATLAS['ortalab_monochrome'].image_data, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})
        }
        recolour_atlases(card, HSL_RGB({((G.TIMERS.REAL % 360)/10), 0.2, 0.2, 1}))
    end,
    update = function(self, card, dt)
        card.ability.extra.dt = card.ability.extra.dt + dt
        if card.ability.extra.dt > 2 then
            card.ability.extra.dt = 0
            self:set_sprites(card)
        end
    end,
    draw = function(self, card, layer)
        card.children.center:draw_shader('voucher',nil, card.ARGS.send_to_shader)
    end
})

function recolour_atlases(card, new_colour)
    card.children.center.atlas.image_data = G.ASSET_ATLAS['ortalab_monochrome'].image_data:clone()
    card.children.center.atlas.image_data:mapPixel(function(x,y,r,g,b,a)
        return recolour_pixel(x,y,r,g,b,a,new_colour)
    end)
    card.children.center.atlas.image = love.graphics.newImage(card.children.center.atlas.image_data, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})
end

local dimension = {
    x_lower = {71*0.19, 142*0.19},
    x_upper = {71*0.81, 142*0.81},
    y_lower = {95*0.09, 190*0.09},
    y_upper = {95*0.91, 190*0.91}
}

function recolour_pixel(x,y,r,g,b,a,new_colour)
    if x < dimension.x_lower[G.SETTINGS.GRAPHICS.texture_scaling] 
    or x > dimension.x_upper[G.SETTINGS.GRAPHICS.texture_scaling]
    or y < dimension.y_lower[G.SETTINGS.GRAPHICS.texture_scaling]
    or y > dimension.y_upper[G.SETTINGS.GRAPHICS.texture_scaling] then
        return r,g,b,a
    end
    local hsl = HSL({r,g,b,a})
    r = r^2.2
    b = b^2.2
    g = g^2.2
    hsl[3] = (r+g+b)/3
    hsl[1] = HSL(new_colour)[1]
    local RGB = HSL_RGB(hsl)
    return RGB[1], RGB[2], RGB[3], RGB[4]
end

-- HSL from RGB
function HSL(rgb)
    local values = {}
    values.min = math.min(rgb[1], math.min(rgb[2], rgb[3]))
    values.max = math.max(rgb[1], math.max(rgb[2], rgb[3]))
    values.sum = values.min + values.max
    values.delta = values.max - values.min

    values.l = values.sum / 2
    if values.delta == 0 then
        values.h = 0
        values.s = 0
    else
        if values.l > 0.5 then
            values.s = values.delta / (2 - values.max - values.min)
        else
            values.s = values.delta / values.sum
        end
        if values.max == rgb[1] then
            values.h = (rgb[2] - rgb[3]) / values.delta
            if rgb[2] < rgb[3] then values.h = values.h + 6 end
        elseif values.max == rgb[2] then
            values.h = (rgb[3] - rgb[1]) / values.delta + 2
        else
            values.h = (rgb[1] - rgb[2]) / values.delta + 4
        end
        values.h = values.h / 6
    end
    return {values.h, values.s, values.l, rgb[4] or 1}        
end

function HSL_RGB(base_colour)
	if base_colour[2] < 0.0001 then return {base_colour[3], base_colour[3], base_colour[3], base_colour[4]} end
	local t = (base_colour[3] < 0.5 and (base_colour[2]*base_colour[3] + base_colour[3]) or (-1 * base_colour[2] * base_colour[3] + (base_colour[2]+base_colour[3])))
	local s = 2 * base_colour[3] - t

	return {HUE(s, t, base_colour[1] + (1/3)), HUE(s,t,base_colour[1]), HUE(s,t,base_colour[1] - (1/3)), base_colour[4]}
end

function HUE(s, t, h)
	local hs = (h % 1) * 6
	if hs < 1 then return (t-s) * hs + s end
	if hs < 3 then return t end
	if hs < 4 then return (t-s) * (4-hs) + s end
	return s
end