-- Artist Colours
G.ARGS.LOC_COLOURS['gappie'] = HEX('7BF2FF')
G.ARGS.LOC_COLOURS['eremel'] = HEX('F48CBA')
G.ARGS.LOC_COLOURS['kosze'] = HEX('4ecf21')
G.ARGS.LOC_COLOURS['tevi'] = HEX('18b57e')
G.ARGS.LOC_COLOURS['crimson'] = HEX('990000')
G.ARGS.LOC_COLOURS['salad'] = HEX('0AC400')
G.ARGS.LOC_COLOURS['alex'] = HEX('16db9d')
G.ARGS.LOC_COLOURS['cheese'] = HEX('a3a616')
G.ARGS.LOC_COLOURS['coro'] = HEX('9cb3e2')
G.ARGS.LOC_COLOURS['flare'] = HEX('fd5f55')
G.ARGS.LOC_COLOURS['flowwey'] = HEX('110663')
G.ARGS.LOC_COLOURS['golddisco'] = HEX('e6bb12')
G.ARGS.LOC_COLOURS['logan'] = HEX('ffff00')
G.ARGS.LOC_COLOURS['parchment'] = HEX('74293f')
G.ARGS.LOC_COLOURS['shinku'] = HEX('e36774')
G.ARGS.LOC_COLOURS['shai'] = HEX('fe0052')
G.ARGS.LOC_COLOURS['joey'] = HEX('2fe041')
G.ARGS.LOC_COLOURS['rowan'] = HEX('36013F')
G.ARGS.LOC_COLOURS['chvsau'] = HEX('008080')
G.ARGS.LOC_COLOURS['cejai'] = HEX('078446')
G.ARGS.LOC_COLOURS['heyyou'] = HEX('CC5500')
G.ARGS.LOC_COLOURS['superb'] = HEX('d68303')
G.ARGS.LOC_COLOURS['monty'] = HEX('ec0d0d')

function ortalab_artist_tooltip(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    localize{type = 'descriptions', set = 'Ortalab Artist', key = _c.key, nodes = desc_nodes, vars = specific_vars or _c.vars}
    desc_nodes['colour'] = G.ARGS.LOC_COLOURS[_c.key] or G.C.GREY
    desc_nodes.ortalab_artist = true
    desc_nodes.title = _c.title or localize('ortalab_artist')
end
local itfr = info_tip_from_rows
function info_tip_from_rows(desc_nodes, name)
    if desc_nodes.ortalab_artist then
        local t = {}
        for k, v in ipairs(desc_nodes) do
        t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes=v}
        end
        return {n=G.UIT.R, config={align = "cm", colour = darken(desc_nodes.colour, 0.15), r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "tm", minh = 0.36, padding = 0.03}, nodes={{n=G.UIT.T, config={text = desc_nodes.title, scale = 0.32, colour = G.C.UI.TEXT_LIGHT}}}},
            {n=G.UIT.R, config={align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = lighten(desc_nodes.colour, 0.5)}, nodes={{n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}}}
        }}
    elseif desc_nodes.tag then
        local t = {}
        for k, v in ipairs(desc_nodes) do
        t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes=v}
        end
        return {n=G.UIT.R, config={align = "cm", colour = lighten(G.C.GREY, 0.15), r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "tm", minh = 0.36, padding = 0.03}, nodes={{n=G.UIT.T, config={text = desc_nodes.title, scale = 0.32, colour = G.C.UI.TEXT_LIGHT}}}},
            {n=G.UIT.R, config={align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = G.C.WHITE}, nodes={{n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}}}
        }}
    else
        return itfr(desc_nodes, name)
    end
end

local ortalab_card_h_popup_ortalab = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    local ret_val = ortalab_card_h_popup_ortalab(card)
    local AUT = card.ability_UIBox_table
    local obj = card.config.center or (card.config.tag and G.P_TAGS[card.config.tag.key])
    if AUT.mythos then
        table.insert(ret_val.nodes[1].nodes[1].nodes[1].nodes, #ret_val.nodes[1].nodes[1].nodes[1].nodes+(card.config.center.discovered and 0 or 1), desc_from_rows(AUT.mythos))
    end
    if obj and obj.mod and Ortalab.config.reduced_mod_badge then
        local badge = {n=G.UIT.R, config = {align = 'tm'}, nodes = {
            {n=G.UIT.T, config={
              text = localize('ortalab_mod_badge'),
              shadow = true,
              colour = G.C.UI.BACKGROUND_WHITE,
              scale = 0.27}},
              {n=G.UIT.O, config={
                object = DynaText({string = string.sub(obj.mod.display_name, 1, 20),
                    colours = {obj.mod.badge_colour},
                bump = true,
                silent = true,
                pop_in = 0,
                pop_in_rate = 4,
                shadow = true,
                y_offset = -0.6,
                scale =  0.27
                })
            }}
        }}
        table.insert(ret_val.nodes[1].nodes[1].nodes[1].nodes, badge)
    end
    if card.area and card.area.config.collection and not card.config.center.discovered then return ret_val end
    if obj and obj.artist_credits and Ortalab.config.credit_pos == 1 then
        table.insert(ret_val.nodes[1].nodes[1].nodes[1].nodes, artist_node(obj.artist_credits, localize('ortalab_art_credit')))
    end
    if card.edition and G.P_CENTERS[card.edition.key].artist_credits and Ortalab.config.credit_pos == 1 then
        table.insert(ret_val.nodes[1].nodes[1].nodes[1].nodes, artist_node(G.P_CENTERS[card.edition.key].artist_credits, localize('ortalab_shader_credit')))
    end
    if card.curse and Ortalab.Curses[card.curse].artist_credits and Ortalab.config.credit_pos == 1 then
        table.insert(ret_val.nodes[1].nodes[1].nodes[1].nodes, artist_node(Ortalab.Curses[card.curse].artist_credits, localize('ortalab_curse_credit')))
    end
    
    return ret_val
end

local ortalab_create_mod_badges_ortalab = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    if not SMODS.config.no_mod_badges and obj and obj.mod and obj.mod.display_name and not obj.no_mod_badges then
        if Ortalab.config.reduced_mod_badge then return end
        ortalab_create_mod_badges_ortalab(obj, badges)
    end
end

function artist_node(artists, first_string)
    local artist_node = {n=G.UIT.R, config = {align = 'tm'}, nodes = {
        {n=G.UIT.T, config={
            text = first_string,
            shadow = true,
            colour = G.C.UI.BACKGROUND_WHITE,
            scale = 0.27}}
    }}
    local total_artists = #artists
    for i, artist in ipairs(artists) do
        if total_artists > 1 and i > 1 then
            if i == total_artists then
                table.insert(artist_node.nodes,
                    {n=G.UIT.T, config={
                    text = localize('ortalab_celadon_and'),
                    shadow = true,
                    colour = G.C.WHITE,
                    scale = 0.27}}
                )
            else
                table.insert(artist_node.nodes,
                    {n=G.UIT.T, config={
                    text = ', ',
                    shadow = true,
                    colour = G.C.WHITE,
                    scale = 0.27}}
                )
            end
        end
        table.insert(artist_node.nodes,
            {n=G.UIT.O, config={
                object = DynaText({string = localize{type = 'raw_descriptions', set = 'Ortalab Artist', key = artist},
                colours = {G.ARGS.LOC_COLOURS[artist] or G.C.WHITE},
                bump = true,
                silent = true,
                pop_in = 0,
                pop_in_rate = 4,
                shadow = true,
                y_offset = -0.6,
                scale =  0.27
                })
            }}
        )
    end
    return artist_node
end

local ortalab_old_blind_popup = create_UIBox_blind_popup
function create_UIBox_blind_popup(blind, discovered, vars)
    local popup = ortalab_old_blind_popup(blind, discovered, vars)
    popup.config.colour = darken(G.C.BLACK, 0.1)
    popup.config.align = 'cm'
    if blind.mod then
        local badges = {}
        
        SMODS.create_mod_badges(blind, badges)
        for i=1, #badges do
            table.insert(popup.nodes, badges[i])
        end
        if Ortalab.config.reduced_mod_badge then
            local badge = {n=G.UIT.R, config = {align = 'tm'}, nodes = {
                {n=G.UIT.T, config={
                  text = localize('blind_credit'),
                  shadow = true,
                  colour = G.C.UI.BACKGROUND_WHITE,
                  scale = 0.27}},
                  {n=G.UIT.O, config={
                    object = DynaText({string = string.sub(blind.mod.display_name, 1, 20),
                    colours = {blind.mod.badge_colour},
                    bump = true,
                    silent = true,
                    pop_in = 0,
                    pop_in_rate = 4,
                    shadow = true,
                    y_offset = -0.6,
                    scale =  0.27
                    })
                }}
            }}
            table.insert(popup.nodes, badge)
        end
    end
    popup = {n=G.UIT.R, config={colour=lighten(G.C.JOKER_GREY, 0.5), align='cm', padding=0.05, emboss=0.07, r=0.12}, nodes = {
        {n=G.UIT.R, config={align = "cm", padding = 0.07, r = 0.1, colour = adjust_alpha(darken(G.C.BLACK, 0.1), 0.8)}, nodes=
            popup.nodes
        }}
    }
    return popup
  end 

local ortalab_blind_choice_uibox = create_UIBox_blind_choice
function create_UIBox_blind_choice(type, run_info)
    local box = ortalab_blind_choice_uibox(type, run_info)
    local blind = G.P_BLINDS[G.GAME.round_resets.blind_choices[type]]
    if blind.mod then
        local badges = {}
        
        SMODS.create_mod_badges(blind, badges)
        for i=1, #badges do
            table.insert(box.nodes[1].nodes[2].nodes, badges[i])
        end
        if Ortalab.config.reduced_mod_badge then
            local badge = {n=G.UIT.R, config = {align = 'tm'}, nodes = {
                {n=G.UIT.T, config={
                  text = localize('blind_credit'),
                  shadow = true,
                  colour = G.C.UI.BACKGROUND_WHITE,
                  scale = 0.27}},
                  {n=G.UIT.O, config={
                    object = DynaText({string = string.sub(blind.mod.display_name, 1, 20),
                    colours = {blind.mod.badge_colour},
                    bump = true,
                    silent = true,
                    pop_in = 0,
                    pop_in_rate = 4,
                    shadow = true,
                    y_offset = -0.6,
                    scale =  0.27
                    })
                }}
            }}
            table.insert(box.nodes[1].nodes[2].nodes, badge)
        end
    end
    return box
end

G.FUNCS.HUD_blind_badge = function(e)
    if G.GAME.blind.in_blind then
        if G.GAME.blind.config.blind.mod then
            e.states.visible = true
            local mod = G.GAME.blind.config.blind.mod
            if Ortalab.config.reduced_mod_badge and e.children[2] then
                e.children[2].config.text = string.sub(mod.display_name, 1, 20)
                e.children[2].config.colour = mod.badge_colour
            elseif e.children[1].children[1] then
                -- print({string.sub(mod.display_name, 1, 20)})
                e.children[1].children[1].config.colour = mod.badge_colour
                G.GAME.blind_badge.name = string.sub(mod.display_name, 1, 20)
                -- e.children[1].children[1].children[2].config.object.string = {string.sub(mod.display_name, 1, 20)}
                -- e.children[1].children[1].children[2].config.object:update()
                e.children[1].children[1].children[2].config.object.colours = {mod.badge_text_colour or G.C.WHITE}
            end
        else
            e.states.visible = false
        end
    end
end