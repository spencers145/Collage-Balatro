local threekanban = SMODS.Challenge({
    key = "threekanban",
    loc_txt = {
        name = "Simon Says"
    },
    rules = {
        custom = {
            {id = 'flc_purple_stake_scaling'}
        },
        modifiers = {
            {id = 'hands', value = 3},
            {id = 'joker_slots', value = 1},
        }
    },
    jokers = {
        {id = "j_femtoLabsCollection_kanban", eternal = true, edition = 'negative'},
        {id = "j_femtoLabsCollection_kanban", eternal = true, edition = 'negative'},
        {id = "j_femtoLabsCollection_kanban", eternal = true, edition = 'negative'},
    },
    restrictions = {
        banned_cards = {
            --{id = 'c_femtoLabsCollection_life'},
            --{id = 'c_femtoLabsCollection_presence'},
            {id = 'c_ectoplasm'},
        },
        banned_tags = {
            {id = 'tag_negative'},
        },
        banned_other = {
            {id = 'bl_femtoLabsCollection_flc_teal_tempest', type = 'blind'},
        }
    }
})

local start_runRef = Game.start_run

Game.start_run = function(self, args)
    start_runRef(self, args)
    if G.GAME.modifiers['flc_purple_stake_scaling'] then
        self.GAME.modifiers.scaling = 4
    end

    if G.GAME.modifiers['flc_empty_shop'] then
        change_shop_size(-1)
        G.GAME.pool_flags.empty_shop_enabled = true
    end
    
    if G.GAME.modifiers['flc_one_booster'] then
        G.GAME.modifiers.extra_boosters = -1;
    end
end

can_rerollRef = G.FUNCS.can_reroll

G.FUNCS.can_reroll = function(e)
    if G.GAME and G.GAME.pool_flags.empty_shop_enabled and G.GAME.shop.joker_max <= 0 then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        can_rerollRef(e)
    end
end

local HelloIAmScragglyOne = SMODS.Challenge({
    key = "HelloIAmScragglyOne",
    loc_txt = {
        name = "Hello! I am Scraggly1."
    },
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 2},
        }
    },
    vouchers = {
        {id = 'v_planet_merchant'},
        {id = 'v_tarot_merchant'},
    },
    jokers = {
        {id = "j_femtoLabsCollection_scraggly", eternal = true},
    },
    restrictions = {
    }
})


--[[local seveneightnineten = SMODS.Challenge({
    key = "seveneightnineten",
    loc_txt = {
        name = "Let's Learn Counting"
    },
    rules = {
        modifiers = {
        }
    },
    vouchers = {
        {id = 'v_planet_merchant'},
        {id = 'v_tarot_merchant'},
    },
    jokers = {
        {id = "j_femtoLabsCollection_sevenball", eternal = true},
        {id = "j_8_ball", eternal = true},
        {id = "j_cloud_9", eternal = true},
        {id = "j_femtoLabsCollection_cloud10", eternal = true},
    },
    restrictions = {
    }
})]]

local outofstock = SMODS.Challenge({
    key = "outofstock",
    loc_txt = {
        name = "Stockout"
    },
    rules = {
        custom = {
            {id = 'flc_empty_shop'},
            {id = 'flc_one_booster'},
        },
        modifiers = {
        }
    },
    jokers = {
    },
    restrictions = {
        banned_cards = {
            {id = 'v_overstock_plus'},
        },
    }
})

