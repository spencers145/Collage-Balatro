local config = SMODS.current_mod.config
SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = 'cm', minh = 1 },
                nodes = {
                    { n = G.UIT.T, config = { text = localize('cod_restart_required'), colour = G.C.RED, scale = 0.5 } }
                }
            },
            {
                n = G.UIT.R,
                config = { padding = 0.2 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cr" },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cr", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = "Enable Jokers",
                                        ref_table = config,
                                        ref_value = 'cod_jokers_enabled'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "cr", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = "Enable Blinds",
                                        ref_table = config,
                                        ref_value = 'cod_blinds_enabled'
                                    })
                                }
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "cr", padding = 0.01 },
                                nodes = {
                                    create_toggle({
                                        label = "Enable Tags",
                                        ref_table = config,
                                        ref_value = 'cod_tags_enabled'
                                    })
                                }
                            },
                        }
                    },
                }
            },
        }
    }
end