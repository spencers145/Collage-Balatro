G.FUNCS.collage_tutorial = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
    definition = collage_tutorial_ui()
    }
end

G.FUNCS.back_button_nope = function()
    play_area_status_text(localize('k_nope_ex'))
end

G.FUNCS.true_back_button = function()
    G.SETTINGS.paused = false
    G.SETTINGS.badge_tutorial = true
    G.SETTINGS.tutorial_complete = true -- kill jimbo 4ever
    G.FUNCS:exit_overlay_menu()
end

function collage_tutorial_ui()
    local overlay_colour = {0.32,0.36,0.41,0}
    t = {n=G.UIT.ROOT, config = {align = "cm", padding = 32.05, r=0.1, colour = overlay_colour, emboss = 0.05}, nodes={
        {n=G.UIT.R, config={align = "cm", minh = 1,r = 0.3, padding = 0.07, minw = 1, colour = G.C.JOKER_GREY, emboss = 0.1}, nodes={
            {n=G.UIT.C, config={align = "cm", minh = 1,r = 0.2, padding = 0.2, minw = 1, colour = G.C.L_BLACK}, nodes={
                {n=G.UIT.R, config={align = "cm",padding = 0.2, minw = 7}, nodes= {
                    {n=G.UIT.C, config={align = "cm",padding = 0.2}, nodes= {
                    {n=G.UIT.R, config={align = "cm", minh = 1,r = 0.3, padding = 0.07, colour = lighten(G.C.GREY, 0.5), emboss = 0.1}, nodes= {
                        {n=G.UIT.C, config={align = "cm", minh = 1,r = 0.2, padding = 0.2, colour = G.C.L_BLACK}, nodes={
                            {n=G.UIT.R, config={align = "cm"}, nodes= {
                                    {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                                        {n=G.UIT.T, config={align = "tm",scale = 0.5, text = localize('ui_collage_examplejoker'), colour = G.C.UI.TEXT_LIGHT}},
                                    }},
                                    {n=G.UIT.R, config={align = "cm", padding = 0.03}},
                                {n=G.UIT.R, config={align = "cm",colour = G.C.WHITE, r = 0.1, padding = 0.05, emboss = 0.05, minw = 1.5, minh = 0.4}, nodes= {
                                    {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes={
                                        {n=G.UIT.T, config={align = "cm",scale = 0.32, text = localize('ui_collage_desc1'), colour = G.C.L_BLACK}},
                                    }},
                                    {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes={
                                        {n=G.UIT.T, config={align = "cm",scale = 0.32, text = localize('ui_collage_desc2'), colour = G.C.L_BLACK}},
                                    }},
                                    {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes={
                                        {n=G.UIT.T, config={align = "cm",scale = 0.32, text = localize('ui_collage_desc3'), colour = G.C.L_BLACK}},
                                    }},
                                }},
                                    {n=G.UIT.R, config={align = "cm", padding = 0.03}},
                                {n=G.UIT.R, config={align = "cm",colour = G.C.BLUE, r = 0.2, padding = 0.03, emboss = 0.05}, nodes= {
                                    {n=G.UIT.R, config={align = "cm"}, nodes={
                                        {n=G.UIT.T, config={align = "tm",scale = 0.32, text = localize('ui_collage_cardtype'), colour = G.C.UI.WHITE}},
                                    }},
                                }},
                                {n=G.UIT.R, config={align = "cm",colour = HEX('8b61ad'), r = 0.2, padding = 0.03, emboss = 0.05}, nodes= {
                                    {n=G.UIT.R, config={align = "cm"}, nodes={
                                        {n=G.UIT.T, config={align = "tm",scale = 0.32, text = localize('ui_collage_modbadge'), colour = G.C.UI.WHITE}},
                                    }},
                                }},
                                }}
                            }}
                        }}
                    }},
                    {n=G.UIT.C, config={align = "cm",padding = 0.2}, nodes= {
                        {n=G.UIT.R, config={align = "cm", r, padding = 0.03}, nodes= {
                            {n=G.UIT.R, config={align = "cm"}, nodes={
                                {n=G.UIT.T, config={align = "tm",scale = 0.5, text = localize('ui_collage_modwarning'), maxw = 1, colour = G.C.UI.WHITE}},
                            }},
                        }},
                        {n=G.UIT.R, config={align = "cm", r, padding = 0.01}, nodes= {
                            {n=G.UIT.R, config={align = "cm"}, nodes={
                                {n=G.UIT.T, config={align = "tm",scale = 0.4, text = localize('ui_collage_modified1'), maxw = 1, colour = G.C.UI.WHITE}},
                            }},
                        }},
                        {n=G.UIT.R, config={align = "cm", r, padding = 0.01}, nodes= {
                            {n=G.UIT.R, config={align = "cm"}, nodes={
                                {n=G.UIT.T, config={align = "tm",scale = 0.4, text = localize('ui_collage_modified2'), maxw = 1, colour = G.C.UI.WHITE}},
                            }},
                        }},
                        {n=G.UIT.R, config={align = "cm", r, padding = 0.01}, nodes= {
                            {n=G.UIT.R, config={align = "cm"}, nodes={
                                {n=G.UIT.T, config={align = "tm",scale = 0.4, text = localize('ui_collage_modified3'), maxw = 1, colour = G.C.UI.WHITE}},
                            }},
                        }},
                    }},
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true, minw = 2.5}, nodes={
                UIBox_button({button = 'true_back_button', minw = 7.5, padding =0.1, r = 0.1, hover = true, colour = G.C.ORANGE, label = {"I UNDERSTAND THIS IS IMPORTANT!!!"}, id = 'back_button_nope'}),
                }},
            }},
        }},
        }}
    return t
end





local _orig_toggle_shop = G.FUNCS.toggle_shop

G.FUNCS.toggle_shop = function(e)
    G.GAME.collage_boosters_purchased_this_shop = 0
    _orig_toggle_shop(e)
end

G.ARGS.LOC_COLOURS['strawberry'] = HEX('FF6B7E')
G.ARGS.LOC_COLOURS['linked_group'] = HEX('1B691E')


table.insert(SMODS.calculation_keys, "collage_reduce_blind")
if SMODS.other_calculation_keys then
    table.insert(SMODS.other_calculation_keys, "collage_reduce_blind")
end

local collage_original_smods_calculate_individal_effect = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    if key == "collage_reduce_blind" then
        local final_chips = (G.GAME.blind.chips) * (1 - amount)
        local chip_mod -- iterate over ~45 ticks
        if type(G.GAME.blind.chips) ~= 'table' then
            chip_mod = math.ceil((G.GAME.blind.chips - final_chips) / 45)
        else
            chip_mod = ((G.GAME.blind.chips - final_chips) / 45):ceil()
        end
        local step = 0

        local fake_chips = G.GAME.blind.chips
        G.GAME.blind.chips = final_chips

        local shared_object = {}

        G.E_MANAGER:add_event(Event({trigger = 'after', blocking = false, func = function()
            fake_chips = fake_chips - G.SETTINGS.GAMESPEED * chip_mod
            if fake_chips > final_chips then
                G.GAME.blind.chip_text = number_format(fake_chips)
                if step % 5 == 0 then
                    play_sound('chips1', math.max(1.0 - (step * 0.01), 0.001))
                end
                step = step + 1
            else
                G.GAME.blind.chip_text = number_format(fake_chips)
                table.insert(shared_object, "done")
                return true
            end
        end}))

        card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus,
            'extra', nil, percent, nil, {message = "-" .. (amount*100) .. "%", colour = HEX('993283'), --[[sound = 'collage_reduce_blind', volume = 0.9]]})
        
        --[[G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
            if #shared_object > 0 then
                return true
            end
        end}))]]
    end

    return collage_original_smods_calculate_individal_effect(effect, scored_card, key, amount, from_edition)
end

SMODS.Sound({
    key = 'collage_reduce_blind',
    path = 'blind_reduce.wav'
})

SMODS.Sound({
    key = 'collage_band1',
    path = 'band1.wav'
})

SMODS.Sound({
    key = 'collage_band2',
    path = 'band2.wav'
})

SMODS.Atlas({key = "sillyconsumables", path = "consumables.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
if math.random() > 0.995 then
    SMODS.Consumable:take_ownership('magician', {
        pos = {x=0, y=0},
        atlas = 'sillyconsumables'
    }, true)
end

SMODS.Sound({
    key = 'collage_dollar_mult',
    path = 'collage_dollar_mult.wav'
})


SMODS.Sound({
    key = 'collage_pummel',
    path = 'pummel.wav'
})

SMODS.Sound({
    key = 'collage_alarm_clock',
    path = 'alarm_clock.wav'
})

SMODS.Sound({
    key = 'collage_microwave_innocent',
    path = 'innocent_microwave_noise.wav'
})

SMODS.Atlas({
    key = "collagejokers",
    path = "jonkers.png",
    px = 71,
    py = 95
})

SMODS.Atlas {
    key = "balatro",
    path = "logofull.png",
    px = 333,
    py = 216,
    prefix_config = { key = false }
}

local gameMainMenuRef = Game.main_menu
function Game:main_menu(change_context)
    gameMainMenuRef(self, change_context)
    UIBox({
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                colour = G.C.UI.TRANSPARENT_DARK
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        scale = 0.3,
                        text = "Collage v1.1.0a",
                        colour = G.C.UI.TEXT_LIGHT
                    }
                }
            }
        },
        config = {
            align = "tri",
            bond = "Weak",
            offset = {
                x = 0,
                y = 0.6
            },
            major = G.ROOM_ATTACH
        }
    })
    if not self.SETTINGS.badge_tutorial or not G.SETTINGS.tutorial_complete then
        G.FUNCS.collage_tutorial()
    end
end


local current_mod = SMODS.current_mod

function current_mod.process_loc_text()
    G.P_CENTERS['collage_petrify_tip'] = {key = 'collage_petrify_tip', set = 'Other'}
end

--- Eases pool weights by player experience.
--- @param min_progress number
--- @param max_progress number
--- @param weight number
--- @param unlock_all_mod number
--- @return number
function collage_ease_weight(min_progress, max_progress, weight, unlock_all_mod, win_gate)
    local progress = G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_antes + G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins * 8

    local mod = 1

    if G.PROFILES[G.SETTINGS.profile].all_unlocked and unlock_all_mod then
        mod = unlock_all_mod
    end

    if win_gate and G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins < win_gate then
        return 0
    end
    
    return math.min(1, mod * math.max(0, progress - min_progress)/math.max(1, max_progress - min_progress)) * weight
end

--- Eases pool inclusion by player experience.
--- @param min_progress number
--- @param max_progress number
--- @param weight number
--- @param unlock_all_mod number
--- @return boolean
function collage_ease_pool(min_progress, max_progress, unlock_all_mod, win_gate)
    local progress = G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_antes + G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins * 8

    local mod = 1

    if G.PROFILES[G.SETTINGS.profile].all_unlocked and unlock_all_mod then
        mod = unlock_all_mod
    end
    
    if win_gate and G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins < win_gate then
        return false
    end

    return pseudorandom(pseudoseed('collage_ease_pool')) <= math.min(1, mod * math.max(0, progress - min_progress)/math.max(1, max_progress - min_progress))
end

local ease_anteRef = ease_ante
function ease_ante(mod, ante_end)
	ease_anteRef(mod, ante_end)
    if mod > 0 then
        G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_antes = G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_antes or 0
        G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_antes = G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_antes + 1 -- not mod, purposefully
    end
end

COLLAGE_MODIFIED_TABLE_MINOR = {
    'b_znm_rewards',
    'b_znm_firewalk',
    'b_ortalab_shady',
    'b_ortalab_membership',
    'b_sarc_travelling',
    'b_losted_evolutionary',
    'm_buf_porcelain',
    'm_buf_porcelain_g',
    'm_bunc_cracker',
    'm_vis_brick',
    'm_vis_table_cloth',
    'm_vis_plastic',
    'm_artb_pinata',
    'm_sarc_flow',
    'm_sarc_luminice',
    'c_buf_nobility',
    'c_vis_calamity',
    'c_vis_chaos',
    'c_vis_vault',
    'c_aij_reshape',
    'c_tma_divinity',
    'c_tma_exhaustion',
    'c_vis_floppy_disk',
    'c_vis_coupon',
    'c_sarc_haven',
    'c_artb_art_auction',
    'v_ortalab_one_mans_trash',
    'v_ortalab_anothers_treasure',
    'vis_wooden_seal',
    'sleeve_vis_burnt',
    'sleeve_ccc_bside',
}

COLLAGE_MODIFIED_TABLE_MAJOR = {
    --'b_buf_porcelain',
    'b_prism_purple',
    'b_vis_poptart',
    'b_vis_heavenly',
    'b_vis_gardening',
    'b_artb_box',
    'b_znm_pinata',
    'b_ortalab_orange',
    'b_ortalab_neon',
    'b_ortalab_experimental',
    'b_ortalab_royal',
    'b_ortalab_sketched',
    'b_femtoLabsCollection_mural',
    'b_femtoLabsCollection_flc_slatedeck',
    'b_femtoLabsCollection_hue',
    'b_ExtraCredit_archeologydeck',
    'm_vis_notebook',
    'm_artb_stained',
    'm_sarc_slime',
    'e_bunc_fluorescent',
    'e_ortalab_anaglyphic',
    'c_aij_scopophobia',
    'c_tma_nightfall',
    'c_tma_burnout',
    'c_c_aij_reshapetma_parity',
    'c_tma_wonderland',
    'c_tma_preserve',
    'c_tma_research',
    'c_tma_morph',
    'c_tma_paradise',
    'c_tma_indulgence',
    'c_tma_glimmer',
    'c_tma_static',
    'c_vis_crystal_ball',
    'c_vis_echo',
    'c_vis_shore',
    'c_vis_weakness',
    'c_artb_art_appraisal',
    'v_bunc_cups_n_balls',
    'v_bunc_shell_game',
    'v_artb_used_supplies',
    'v_vis_warhead',
    'v_vis_fallout',
    'v_ortalab_catalog',
    'v_ortalab_ad_campaign',
    'vis_indigo_seal',
    'sleeve_prism_purplesleeve',
    'sleeve_vis_poptart',
    'sleeve_vis_gardening',
    'sleeve_vis_rolling',
}

COLLAGE_MODIFIED_TABLE = {
	"j_aij_a_young_hamlet",
	"j_aij_alexandre",
	"j_aij_alien_joker",
	"j_aij_animatronic",
	"j_aij_astrologer",
	"j_aij_bad_apple",
	"j_aij_bad_guy",
	"j_aij_baddata",
	"j_aij_birthday_clown",
	"j_aij_bonus_bob",
	"j_aij_bonus_round",
	"j_aij_candy_floss",
	--"j_aij_chippy",
	"j_aij_clowns_on_parade",
	"j_aij_columbina",
	"j_aij_comedy_of_errors",
	"j_aij_feedback_form",
	"j_aij_funny_money",
	"j_aij_fuzzy_joker",
	"j_aij_goofball",
	--"j_aij_guillaume",
	"j_aij_hofnarr_the_barbarian",
	"j_aij_honker",
	--"j_aij_jeff_the_joker",
	"j_aij_jester_zombie",
	"j_aij_kilroy",
	"j_aij_le_fils_de_banane",
	"j_aij_low_priest",
	--"j_aij_magic_mirror",
	"j_aij_mr_lonely",
	"j_aij_nature_tapes",
	"j_aij_null_joker",
	"j_aij_pell_mel",
	"j_aij_pinhead",
	"j_aij_planetarium",
	"j_aij_pompey",
	"j_aij_realty_sign",
	"j_aij_right_angle",
	"j_aij_scary_story",
	"j_aij_scorecard",
	"j_aij_silent_sam",
	"j_aij_skomorokh",
	"j_aij_square_eyes",
	"j_aij_stagehand",
	"j_aij_stargazer",
	"j_aij_string_theory",
	"j_aij_sudoku",
	"j_aij_teeny_joker",
	"j_aij_tetrominoker",
	"j_aij_the_clown_show",
	"j_aij_tipteerer",
	"j_aij_trypophobia",
	"j_aij_vitruvian_joker",
	"j_aij_word_art",
	"tag_aij_chaos",

	"j_buf_camarosa",
	"j_buf_fivefingers",
	"j_buf_gfondue",
	"j_buf_korny",
	"j_buf_laidback",
	"j_buf_maggit",
	--"j_buf_roulette",
	"j_buf_supportive",
	"j_buf_tailored",

    "j_bunc_pawn",
	"j_bunc_jumper",
    "j_bunc_juggalo",
    "j_bunc_wino",
    "j_bunc_envious",
    "j_bunc_proud",
    "j_bunc_unobtanium",

	"j_ccc_coreswitch",
	"j_ccc_miniheart",
	"j_ccc_waterfall",
	"j_ccc_bird",
	"j_ccc_collapsingbridge",
	"j_ccc_strongwinds",
	"j_ccc_theocrystal",
	"j_ccc_goldenstrawberry",
	"j_ccc_strawberry",
	"j_ccc_thecrowd",
	"j_ccc_wingedgoldenstrawberry",
	"j_ccc_wingedstrawberry",
	"j_ccc_cassetteblock",
    "j_ccc_chests",

    "j_ExtraCredit_turtle",
    "j_ExtraCredit_pridefuljoker",
    "j_ExtraCredit_shipoftheseus",
    "j_ExtraCredit_espresso",

    "j_femtoLabsCollection_flc_radioactive",
    "j_femtoLabsCollection_gyroscope",
    "j_femtoLabsCollection_cascade",
    --"j_femtoLabsCollection_savoury_cheese",
    "j_femtoLabsCollection_thecall",
    "j_femtoLabsCollection_coconut",
    "j_femtoLabsCollection_blindfold",
    "j_femtoLabsCollection_frightened",
    "j_femtoLabsCollection_snooze",
    "j_femtoLabsCollection_cityplan",

    "j_znm_pinhead",
    "j_znm_ealu",
    "j_znm_strawberryjam",
    "j_znm_spamemail",
    "j_znm_highstriker",
    "j_znm_canyon",
    "j_znm_minesweeper",
    "j_znm_tuna",
    --"j_znm_stepladder",
    "j_znm_crazyeights",
    "j_znm_peninsula",
    "j_znm_bugcave",
    "j_znm_fireworks",
    "j_znm_fireeater",
    "j_znm_volcano",
    "j_znm_pickuptwo",
    "j_znm_landfill",

    --"j_losted_doodle",
    "j_losted_jersey_10",
    "j_losted_jimbo_hood",
    "j_losted_jimboy",
    "j_losted_last_resort",
    --"j_losted_schrodinger",
    "j_losted_statue",
    "j_losted_welder",

    "j_mstg_ufo",
    "j_mstg_augment",

    "j_nflame_rapdog",

    "j_ortalab_art_gallery",
	"j_ortalab_attached",
	"j_ortalab_biker",
	"j_ortalab_black_friday",
	--j_ortalab_chameleon",
	"j_ortalab_collatz",
	"j_ortalab_dropout",
	--j_ortalab_false_phd",
	"j_ortalab_fine_wine",
	"j_ortalab_frowny_face",
	"j_ortalab_joker_miles",
	"j_ortalab_koko",
	"j_ortalab_kopi",
	"j_ortalab_multiplyers",
	"j_ortalab_scantron",
	"j_ortalab_scenic",
	"j_ortalab_triangle",
	"j_ortalab_vinyl",
	"j_ortalab_woo_all_1",

    "j_paperback_cherry_blossoms",
	"j_paperback_crispy_taco",
	"j_paperback_der_fluschutze",
	"j_paperback_derecho",
	"j_paperback_evergreens",
	"j_paperback_forlorn",
	"j_paperback_grand_strategy",
	"j_paperback_high_speed_rail",
	"j_paperback_ice_cube",
	"j_paperback_pear",
	"j_paperback_skydiver",
	"j_paperback_soft_taco",
	"j_paperback_surfer",
	"j_paperback_the_sun",
	"j_paperback_unholy_alliance",

    "j_pl_plantain",
	"j_pl_postcard",
	"j_pl_bingo_card",
	"j_pl_el_dorado",
	"j_pl_lamp",
	"j_pl_odd_sock",
	"j_pl_quarry",

	"j_prism_motherboard",
	"j_prism_sculptor",
	"j_prism_night",
	"j_prism_day",
	"j_prism_reverse_card",
	"j_prism_razor_blade",
	"j_prism_swiss",

--j_RainyDays_bankaccount
    "j_RainyDays_feather_precious",
    "j_RainyDays_feather_silky",
    "j_RainyDays_feather_vibrant",
    "j_RainyDays_sediment",
    "j_RainyDays_truffle",
	"j_RainyDays_microwave",

    "j_roff_grossmichael",
	"j_roff_primes",
	"j_roff_faces",
    "j_roff_draw_diamonds",

    "c_sarc_brutal_orchestra",
    "c_sarc_chicory",
    "c_sarc_haven",
    "c_sarc_kingdom",
    "c_sarc_plort",
    "j_sarc_beauty_of_the_sea",
    "j_sarc_council_of_shadows",
    "j_sarc_crash_message",
    "j_sarc_diversity",
    "j_sarc_garlic_bread",
    "j_sarc_green_carnation",
    "j_sarc_labrys",
    "j_sarc_orchid",
    "j_sarc_terrarrium",
    "j_sarc_watermelon_candy",

	"j_tess_blue_java",
	"j_tess_dada",
	"j_tess_impos",
	"j_tess_mahjong",
	"j_tess_mint",
	"j_tess_pie",
	"j_tess_pineapple",

	"j_vis_cave_man",
	"j_vis_flat_earth",
	"j_vis_ghost_print",
	"j_vis_handicap_parking",
	"j_vis_insomnia",
	"j_vis_job_application",
	"j_vis_monochromatic_joker",
	"j_vis_monolith",
	"j_vis_poker_face",
	"j_vis_russian_roulette",
	"j_vis_stoner_joker",
    --unemployed
	"j_vis_wholesale_card",

    "j_tma_Syringe",
	"j_tma_PlagueDoctor",
	"j_tma_LightlessFlame",
	"j_tma_Extinction",
	"j_tma_Panopticon",
	"j_tma_Lonely",
	"j_tma_Piper",
	"j_tma_Coffin",
	"j_tma_MechanicalJoker",
	"j_tma_Archivist",
	"j_tma_Marionette",
	"c_tma_the_rot",
	"c_tma_decay",

    "j_artb_minimalism",
	"j_artb_mitosis",
	"j_artb_paint_chips",
	"j_artb_trixel",
	"j_artb_lego_joker",

    "j_sins_suppression",
    "j_sins_chastity",
    "j_sins_restraint",
    "j_sins_obedience"
}

--[[SMODS.Joker{
	key = "multiplication_table",
    loc_txt = {
        name = 'Multiplication Table',
        text = {
        "If scoring hand contains",
        "both a {C:attention}5{} and a {C:attention}10{}, scored",
        "{C:attention}5s{} and {C:attention}10s{} give {C:white,X:chips}X#1#{} Chips"
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 3,
	atlas = "basejokers",
	pos = { x = 0, y = 0 },
	cost = 8,
	config = { extra = { xchips = 1.25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
            local has5 = false
            local has10 = false
            for key, value in pairs(context.scoring_hand) do
                if value:get_id() == 5 then
                    has5 = true
                elseif value:get_id() == 10 then
                    has10 = true
                end

                if has5 and has10 then break end
            end

            if has5 and has10 and (context.other_card:get_id() == 5 or context.other_card:get_id() == 10) then
                return {
                    xchips = card.ability.extra.xchips
                }
            end
		end
	end
}]]

SMODS.Joker{
	key = "jetpack",
    loc_txt = {
        name = 'Jetpack',
        text = {
            {"If scored hand has",
            "exactly {C:attention}4{} cards,",
            "the {C:attention}first{} and {C:attention}last{}",
            "scored cards give {C:white,X:mult}X#1#{} Mult",
            "{C:inactive,s:0.8}(Cell phones are crazy nowadays!)"}, 
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 3,
	atlas = "collagejokers",
	pos = { x = 1, y = 0 },
	cost = 8,
	config = { extra = { xmult = 1.75 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.scoring_hand and #context.scoring_hand == 4 then
            for index, value in ipairs(context.scoring_hand) do
                if (index == 1 or index == 4) and value == context.other_card then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
	end
}

SMODS.Joker{
	key = "weaklifter",
    loc_txt = {
        name = 'Weaklifter',
        text = {
            {"Does nothing yet..."},
            {"Needs you to play a",
            "specific {C:attention}secret hand"},
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
	rarity = 1,
	atlas = "collagejokers",
	pos = { x = 2, y = 0 },
	cost = 2,
    credit = {
        art = "AstraLuna",
        code = "base4",
        concept = "base4 & AstraLuna"
    },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'collage_heavyweight_tip', set = 'Other' }
    end,
	calculate = function(self, card, context)
        if context.before and context.scoring_name then
            if not context.blueprint then
                if context.poker_hands and next(context.poker_hands['vis_heavyweight']) then
                    -- thanks for the free util function paperback
                    PB_UTIL.destroy_joker(card, function()
                        SMODS.add_card {
                            key = "j_collage_weightlifter",
                            edition = card.edition
                        }
                    end)
                    unlock_card(G.P_CENTERS.b_femtoLabsCollection_flc_slatedeck)
                    return {
                        message = "Bulk up!",
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end
        end
	end
}

SMODS.Joker{
	key = "weightlifter",
    loc_txt = {
        name = 'Weightlifter',
        text = {
            {"This Joker gains {C:white,X:mult}X#2#{} Mult",
            "if hand contains a {C:attention}Heavyweight{}",
            "{C:inactive}(Currently: {C:white,X:mult}X#1#{C:inactive} Mult)"},
            {"Loses {C:white,X:mult}X#3#{} Mult each round",
            "a {C:attention}Heavyweight{} is not played",
            "{C:inactive}(Currently: #4#)"}
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
	rarity = 3,
	atlas = "collagejokers",
	pos = { x = 3, y = 0 },
	cost = 12,
    credit = {
        art = "AstraLuna",
        code = "base4",
        concept = "base4 & AstraLuna"
    },
	config = { extra = { xmult = 2.5, bonus = 0.5, loss = 0.75, played_this_round = true } },
    in_pool = function (self, args)
        return false
    end,
	loc_vars = function(self, info_queue, card)
        local played = card.ability.extra.played_this_round and "played" or "NOT PLAYED!"
		return { vars = { card.ability.extra.xmult, card.ability.extra.bonus, card.ability.extra.loss, played } }
	end,
	calculate = function(self, card, context)
		if context.before and context.scoring_name then
            if not context.blueprint then
                if context.poker_hands and next(context.poker_hands['vis_heavyweight']) then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.bonus
                    card.ability.extra.played_this_round = true
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('k_upgrade_ex'),
                    })
                end
            end
        end

        if context.joker_main then
            if card.ability.extra.xmult > 1 then
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end

        if context.end_of_round and not context.repetition and not context.individual then
            if not card.ability.extra.played_this_round then
                card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.loss
                if card.ability.extra.xmult <= 1 then
                    -- thanks for the free util function paperback
                    PB_UTIL.destroy_joker(card, function()
                        SMODS.add_card {
                            key = "j_collage_weaklifter",
                            edition = card.edition
                        }
                    end)
                else
                    card.ability.extra.played_this_round = false
                end
                return {
                    message = 'Out of Shape...',
                }
            else
                card.ability.extra.played_this_round = false
            end
        end
	end
}

SMODS.Consumable ({
    object_type = "Consumable",
    atlas = 'sillyconsumables',
	key = 'art_blank',
	set = 'art',
	name = 'Blank',
	pos = { x = 1, y = 0 },
	cost = 4,
	unlocked = true,
	discovered = false,
    calculate = function (self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == "art" then
			return {
				card = card,
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							card.T.r = -0.2
							card:juice_up(0.5, 0.4)
							card.states.drag.is = true
							card.children.center.pinch.x = true
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.3,
								blockable = false,
								func = function()
									card:remove()
									local copy = copy_card(context.consumeable)
									copy:add_to_deck()
									G.consumeables:emplace(copy)
									copy:start_materialize()
									return true
								end
							}))
							return true
						end
					}))
				end
			}
		end
	end
})