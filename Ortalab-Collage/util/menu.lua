SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", colour = G.C.BLACK}, nodes = {
        {n=G.UIT.R, config = {align = 'cm'}, nodes={
            {n=G.UIT.C, config = {padding = 0.2, align = 'cm'}, nodes = {
                create_option_cycle({label = localize('ortalab_config_artists_pos'), current_option = Ortalab.config.credit_pos , options = localize('ortalab_config_artists_pos_options'), ref_table = Ortalab.config, ref_value = 'credit_pos', info = localize('ortalab_config_artists_pos_desc'), colour = Ortalab.badge_colour, w = 3.7*0.65/(5/6), h=0.8*0.65/(5/6), text_scale=0.5*0.65/(5/6), scale=5/6, no_pips = true, opt_callback = 'cycle_update'}),
            }},
            {n=G.UIT.C, config = {padding = 0.2, align = 'cm'}, nodes = {
                EremelUtility.create_toggle({label = localize('ortalab_config_reduced'), ref_table = Ortalab.config, ref_value = 'reduced_mod_badge', info = localize('ortalab_config_reduced_desc'), active_colour = Ortalab.badge_colour, left = true}),
            }}
        }},
        {n=G.UIT.R, config = {minh = 0.04, minw = 4, colour = G.C.L_BLACK}},
        {n=G.UIT.R, config = {align = 'cm', padding = 0.2}, nodes = {
            {n=G.UIT.T, config = {scale = 0.5, text = localize('ortalab_config_skip_animations'), colour = G.C.WHITE}}
        }},
        {n=G.UIT.R, config = {align = 'cm'}, nodes={
            {n=G.UIT.C, config = {padding = 0.2, align = 'cm'}, nodes = {
                EremelUtility.create_toggle({label = localize('ortalab_config_loteria_skip'), ref_table = Ortalab.config, ref_value = 'loteria_skip', info = localize('ortalab_config_loteria_skip_desc'), active_colour = Ortalab.badge_colour, left = true}),
            }},
            {n=G.UIT.C, config = {padding = 0.2, align = 'cm'}, nodes = {
                EremelUtility.create_toggle({label = localize('ortalab_config_enhancement_skip'), ref_table = Ortalab.config, ref_value = 'enhancement_skip', info = localize('ortalab_config_enhancement_skip_desc'), active_colour = Ortalab.badge_colour, left = true}),
            }},
            {n=G.UIT.C, config = {padding = 0.2, align = 'cm'}, nodes = {
                EremelUtility.create_toggle({label = localize('ortalab_config_zodiac_skip'), ref_table = Ortalab.config, ref_value = 'zodiac_skip', info = localize('ortalab_config_zodiac_skip_desc'), active_colour = Ortalab.badge_colour, left = true}),
            }},
            {n=G.UIT.C, config = {padding = 0.2, align = 'cm'}, nodes = {
                EremelUtility.create_toggle({label = localize('ortalab_config_wide_joker'), ref_table = Ortalab.config, ref_value = 'wide_joker', info = localize('ortalab_config_wide_joker_desc'), active_colour = Ortalab.badge_colour, left = true}),
            }}
        }},
        {n=G.UIT.R, config = {minh = 0.04, minw = 4, colour = G.C.L_BLACK}},
        {n=G.UIT.R, config = {align = 'cm'}, nodes = {
            {n=G.UIT.C, config={padding=0.2, align = 'cm'}, nodes={
                EremelUtility.create_toggle({label = localize('ortalab_config_ortalab_only'), ref_table = Ortalab.config, ref_value = 'ortalab_only', info = localize('ortalab_config_ortalab_only_desc'), active_colour = Ortalab.badge_colour, left = true}),
            }},
    
        }},
        {n=G.UIT.R, config = {minh = 0.04, minw = 4, colour = G.C.L_BLACK}},
        {n=G.UIT.R, config = {align = 'cm'}, nodes = {
            {n=G.UIT.C, config={padding=0.2, align = 'cm'}, nodes={
                EremelUtility.create_toggle({active_colour = Ortalab.badge_colour,
                        left = true, label = localize('ortalab_toggle_menu'), ref_table = Ortalab.config, ref_value = 'menu_toggle', callback = menu_refresh}),
            }},
        }}
    }}
end

function menu_refresh()
    if G.SPLASH_BACK then G.SPLASH_BACK:remove(); G.SPLASH_BACK = nil end
    G.SPLASH_BACK = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 2, y = 0})
    G.SPLASH_BACK:set_alignment({
        major = G.ROOM_ATTACH,
        type = 'cm',
        offset = {x=0,y=0}
    })
    local splash_args = {mid_flash = change_context == 'splash' and 1.6 or 0.}
    ease_value(splash_args, 'mid_flash', -(change_context == 'splash' and 1.6 or 0), nil, nil, nil, 4)

    G.SPLASH_BACK:define_draw_steps({{
        shader = Ortalab.config.menu_toggle and 'ortalab_background' or 'splash',
        send = {
            {name = 'time', ref_table = G.TIMERS, ref_value = 'REAL_SHADER'},
            {name = 'vort_speed', val = 0.4},
            {name = 'colour_1', ref_table = Ortalab.config.menu_toggle and G.ARGS.LOC_COLOURS or G.C, ref_value = Ortalab.config.menu_toggle and 'Ort_menu_colourA' or 'RED'},
            {name = 'colour_2', ref_table = Ortalab.config.menu_toggle and G.ARGS.LOC_COLOURS or G.C, ref_value = Ortalab.config.menu_toggle and 'Ort_menu_colourB' or 'BLUE'},
            {name = 'mid_flash', ref_table = splash_args, ref_value = 'mid_flash'},
            {name = 'vort_offset', val = 0},
        }}})
    
    local SC_scale = 1.1*(G.debug_splash_size_toggle and 0.8 or 1)
    local CAI = {
        TITLE_TOP_W = G.CARD_W,
        TITLE_TOP_H = G.CARD_H,
    }
    G.SPLASH_LOGO = Sprite(0, 0, 
        13*SC_scale, 
        13*SC_scale*(G.ASSET_ATLAS[Ortalab.config.menu_toggle and 'ortalab_logo' or "balatro"].py/G.ASSET_ATLAS[Ortalab.config.menu_toggle and 'ortalab_logo' or "balatro"].px),
        G.ASSET_ATLAS[Ortalab.config.menu_toggle and 'ortalab_logo' or "balatro"], {x=0,y=0})

    G.SPLASH_LOGO:set_alignment({
        major = G.title_top,
        type = 'cm',
        bond = 'Strong',
        offset = {x=0,y=0}
    })
    G.SPLASH_LOGO:define_draw_steps({{
            shader = 'dissolve',
        }})

    G.SPLASH_LOGO.dissolve_colours = {G.C.WHITE, G.C.WHITE}
    G.SPLASH_LOGO.dissolve = 1   
    ease_value(G.SPLASH_LOGO, 'dissolve', -1, nil, nil, nil, 0.9)

    G.title_top.cards[1]:set_edition(Ortalab.config.menu_toggle and 'e_negative' or nil, true, true)
end

G.FUNCS.cycle_update = function(args)
    args = args or {}
    if args.cycle_config and args.cycle_config.ref_table and args.cycle_config.ref_value then
        args.cycle_config.ref_table[args.cycle_config.ref_value] = args.to_key
    end
end

function artist_toggle()
    if not Ortalab.config.artist_credits and Ortalab.config.full_credits then
        Ortalab.config.full_credits = false
    end
end

function full_toggle()
    if Ortalab.config.full_credits and not Ortalab.config.artist_credits then
        Ortalab.config.artist_credits = true
    end
end



Ortalab.zodiac_area = nil

EremelUtility = EremelUtility or {}

function EremelUtility.create_toggle(args)
    args = args or {}
    args.active_colour = args.active_colour or G.C.RED
    args.inactive_colour = args.inactive_colour or G.C.BLACK
    args.w = args.w or 3
    args.h = args.h or 0.5
    args.scale = args.scale or 1
    args.label = args.label or 'TEST?'
    args.label_scale = args.label_scale or 0.4
    args.ref_table = args.ref_table or {}
    args.ref_value = args.ref_value or 'test'
    args.left = args.left or false
    args.right = not args.left
    args.info_above = args.info_above or false

    local error = {n=G.UIT.C, config = {r=0.1, colour = G.C.RED, align = 'cm', padding = 0.1}, nodes = {}}

    if args.left and args.right then
        error.nodes[#error.nodes + 1] = {n=G.UIT.R, nodes = {{n=G.UIT.T, config = {text = 'Left and Right selected', scale = args.scale, colour = G.C.BLACK, shadow = true}}}}
    end

    if #error.nodes > 0 then return error end

    local check = Sprite(0,0,0.5*args.scale,0.5*args.scale,G.ASSET_ATLAS["icons"], {x=1, y=0})
    check.states.drag.can = false
    check.states.visible = false

    local info = nil
    if args.info then 
        info = {}
        for k, v in ipairs(args.info) do 
            table.insert(info, {n=G.UIT.R, config={align = "cm", minh = 0.05}, nodes={
            {n=G.UIT.T, config={text = v, scale = 0.25, colour = G.C.UI.TEXT_LIGHT}}
            }})
        end
        info =  {n=G.UIT.R, config={align = "cm", minh = 0.05}, nodes=info}
    end

    local toggle = {n=G.UIT.C, config = {align = 'cm', minw = 0.3*args.w}, nodes = {
        {n=G.UIT.C, config = {align = 'cm', r=0.1, colour = G.C.BLACK}, nodes={
            {n=G.UIT.C, config={align = "cm", r = 0.1, padding = 0.03, minw = 0.4*args.scale, minh = 0.4*args.scale, outline_colour = args.outline or G.C.WHITE, outline = 1.2*args.scale, line_emboss = 0.5*args.scale, ref_table = args,
                colour = args.inactive_colour,
                button = 'toggle_button', button_dist = 0.2, hover = true, toggle_callback = args.callback, func = 'toggle', focus_args = {funnel_to = true}}, nodes={
                {n=G.UIT.O, config={object = check}},
            }}
        }}
    }}

    local label = {n=G.UIT.C, config={align = args.left and 'cr' or 'cl', colour = args.label_bg or G.C.CLEAR, r = 0.1,},  nodes={
        {n=G.UIT.B, config={w = 0.1, h = 0.1}},
        {n=G.UIT.T, config={text = args.label, scale = args.label_scale, colour = args.label_colour or G.C.UI.TEXT_LIGHT}},
        {n=G.UIT.B, config={w = 0.1, h = 0.1}},
    }}

    local t = 
        {n=args.col and G.UIT.C or G.UIT.R, config={align = args.left and 'cr' or 'cl', padding = 0.1, r = 0.1, colour = G.C.CLEAR, focus_args = {funnel_from = true}}, nodes={
            args.left and label or nil,
            toggle,
            args.right and label or nil
        }}

    if args.info then 
        t = {n=args.col and G.UIT.C or G.UIT.R, config={align = "cm"}, nodes={
        args.info_above and info or nil,
        t,
        args.info_above and nil or info,
        }}
    end
    return t
end

G.FUNCS.close_initial_config = function()
    -- Ortalab.config.initial_setup_demo_3 = false
    Ortalab.zodiac_area:remove()
    Ortalab.joker_area:remove()
    Ortalab.blind_area:remove()
    SMODS.save_mod_config(Ortalab)
    G.FUNCS:exit_overlay_menu()
    -- G:main_menu()
end
