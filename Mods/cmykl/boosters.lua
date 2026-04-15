SMODS.Booster {
    key = 'mega_spectral_pack',
    loc_txt = {
        name = "Mega Spectral Pack",
        text = {
            "{C:money}HOLY{} {X:red,C:white}SHIT{}{C:red}?!?!/!{} IS THAT {C:spectral}TRINITY{} FROM THE HIT MOD {X:dark_edition,C:planet}C{}{X:dark_edition,C:legendary}M{}{X:dark_edition,C:gold}Y{}{X:edition}K{}{X:dark_edition,C:white}L{}{C:red}?!?!!!{}"
        },
        group_name = "k_spectral_pack"
    },
    config = { extra = 4, choose = 2 },
    cost = 8,
    weight = 0.07,
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    kind = 'Spectral',
    group_key = "k_spectral_pack",
    draw_hand = true,
    discovered = true,
     loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "Spectral",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            "cmykl_spe"
        }
    end,
}

