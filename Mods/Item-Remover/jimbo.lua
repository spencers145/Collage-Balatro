--- STEAMODDED HEADER
--- MOD_NAME: Item Remover
--- MOD_ID: ItemRemover
--- MOD_AUTHOR: [elial1]
--- MOD_DESCRIPTION: Prevent certain things from spawning, click on an item in the collection, or create and use custom presets in Config
--- PRIORITY: -1


local dontDisable = {
    bl_small = true,
    bl_big = true,
    j_joker = true,
    tag_handy = true,
    v_blank = true,
    c_incantation = true,
    c_pluto = true,
    c_strength = true,
    c_base,
    e_base,
    p_buffoon_normal_1
}


local mod = SMODS.current_mod
--config stuff
    if not mod.config["Disabled Things"] then
        mod.config["Disabled Things"]  = {

        }
    end
    mod.config["Disabled Things"] = mod.config["Disabled Things"] or {}

    if not mod.config["Presets"] then
        mod.config["Presets"]  = {

        }
    end
    mod.config["Presets"] = mod.config["Presets"] or {}



    SMODS.load_mod_config(mod)



    if not mod.config["Disabled Things"] then
        mod.config["Disabled Things"]  = {

        }
    end
    mod.config["Disabled Things"] = mod.config["Disabled Things"] or {}

    if not mod.config["Presets"] then
        mod.config["Presets"]  = {

        }
    end
    mod.config["Presets"] = mod.config["Presets"] or {}
--

--debuff stuff
    local oldfunc = Card.click
    function Card:click()
        local ret = oldfunc(self)
        --print(self.config and self.config.center and self.config.center.key and self.config.center.key)
        --print(self.config and self.config.blind and self.config.blind)
        
        local antiVal = nil
        if self.config.card then antiVal = self.config.center.key end
        if self.config.blind then antiVal = self.config.blind.key end
        if self.edition then antiVal = nil end

        if G.your_collection and G.your_collection[1] and G.your_collection[1].cards and self.config and antiVal and not dontDisable[antiVal] then
            for j = 1, #G.your_collection do
                for i = #G.your_collection[j].cards,1, -1 do
                if G.your_collection[j].cards[i] == self then
                    self.debuff = not self.debuff
                    mod.config["Disabled Things"][antiVal] = not mod.config["Disabled Things"][antiVal] or self.debuff
                    --print(mod.config["Disabled Things"][antiVal])
                    SMODS.save_mod_config(mod)
                end
                end
            end
        end
        return ret
    end

    local oldfunc = get_new_boss
    function get_new_boss()
        
        local ret = oldfunc()
        if mod.config['Disabled Things'][ret] then
            local num = 0
            for k,v in pairs(G.P_BLINDS) do
                if mod.config['Disabled Things'][k] then
                    num = num+1
                end
            end
            if num == #G.P_BLINDS - 2 then
                return 'bl_big'
            end
            return get_new_boss()
        end
        
        return ret
    end

    local oldfunc = get_pack
    function get_pack(_key, _type)
        local ret = oldfunc(_key, _type)
        if ret and ret.key and mod.config["Disabled Things"][ret.key] == true then
            return get_pack(_key, _type)
        end
        return ret
    end

    local oldfunc = Card.init
    function Card:init(X, Y, W, H, card, center, params)
        local ret = oldfunc(self,X, Y, W, H, card, center, params)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.05,
            blocking = false,
            blockable = false,
            func = (function()
                local antiVal = nil
                if self.config.card then antiVal = self.config.center.key end
                if self.config.blind then antiVal = self.config.blind.key end
                if mod.config["Disabled Things"][antiVal] and (self.area and self.area.config and self.area.config.collection) then
                    self.debuff = mod.config["Disabled Things"][antiVal]
                end
                return true
            end)
        }))
        return ret
    end


    local oldfunc = get_current_pool
    function get_current_pool(_type, _rarity, _legendary, _append)
        local _pool,_poolkey = oldfunc(_type,_rarity,_legendary,_append)
        local truepool = {}
        local truepoolsize = 0
        for i = 1, #_pool do
            if 
                (next(find_joker(_pool[i])) 
                and next(find_joker("Showman")))
                
                or (not (mod.config["Disabled Things"][_pool[i]] 
                    and mod.config["Disabled Things"][_pool[i]] == true)) 
            then
		truepool[#truepool+1] = _pool[i]
                if _pool[i] ~= 'UNAVAILABLE' then 
                    truepoolsize = truepoolsize+1
                end
            else
                --print(truepoolsize)
                --print(_pool[i])
            end
        end
        --print(#truepool)
        if truepoolsize == 0 and not next(find_joker("Showman")) then
            if _type == 'Tarot' or _type == 'Tarot_Planet' then truepool[#truepool + 1] = "c_strength"
            elseif _type == 'Planet' then truepool[#truepool + 1] = "c_pluto"
            elseif _type == 'Spectral' then truepool[#truepool + 1] = "c_incantation"
            elseif _type == 'Joker' then truepool[#truepool + 1] = "j_joker"
            elseif _type == 'Demo' then truepool[#truepool + 1] = "j_joker"
            elseif _type == 'Voucher' then truepool[#truepool + 1] = "v_blank"
            elseif _type == 'Tag' then truepool[#truepool + 1] = "tag_handy"
            else truepool[#truepool + 1] = "j_joker"
            end
            truepoolsize = truepoolsize+1
        end
        return truepool,_poolkey
    end
--






G.FUNCS.enable_all = function(e)
    mod.config["Disabled Things"]  = {

    }
    SMODS.save_mod_config(mod)
end

G.FUNCS.preset_vanilla_jokers = function(e)
    for k,v in pairs(G.P_CENTER_POOLS.Joker) do
        if not v.mod then
            mod.config['Disabled Things'][v.key] = true
        end
    end
end

function create_UIBOX_preset_type(args)
    if not args.name then args.name = 'Test' end
    if not args.items then args.items = {} end
    
    local types = {
        
    }
    for k,v in pairs(args.items) do
        if G.P_CENTERS[k] and G.P_CENTERS[k].set and
        G.P_CENTERS[k].set ~= 'Back' and
        G.P_CENTERS[k].set ~= 'Enhanced' and
        G.P_CENTERS[k].set ~= 'Default' and
        G.P_CENTERS[k].set ~= 'Edition' and
        G.P_CENTERS[k].set ~= 'Other' and
        G.P_CENTERS[k].set ~= 'Sleeve' then
            
            types[G.P_CENTERS[k].set] = true
        end
    end

    for k,v in pairs(args.items) do
        if G.P_BLINDS[k] then
            types['Blind'] = true
        end
    end


    local buttons = {}
    if args.items.is_custom then
        buttons[1] = UIBox_button({
            button = 'destroy_' .. args.items.name, 
            label = {'Destroy Preset'}, 
            minw = 3.5, 
            minh = 1,
            colour = G.C.BLUE,
            padding = 0.05,
            scale = 0.7, 
            id = 'destroy_' .. args.items.name
        })
        G.FUNCS['destroy_' .. args.items.name] = function(e)
            for i = 1, #mod.config['Presets'] do
                if mod.config['Presets'][i] == args.items then
                    table.remove(mod.config['Presets'], i)
                    SMODS.save_mod_config(mod)
                    G.SETTINGS.paused = true
                    G.FUNCS.overlay_menu{
                        definition = create_UIBox_preset_disables(),
                    }
                end
            end
        end
    end

    local itemcount = 0
    G.FUNCS['disable_all_' .. args.name] = function(e)
        for k,v in pairs(args.items) do
            if k ~= 'name' and (G.P_CENTERS[k] or G.P_BLINDS[k]) and not dontDisable[k] then
                mod.config['Disabled Things'][k] = true
                itemcount = itemcount+1
            end
        end
        SMODS.save_mod_config(mod)
    end
    for k,v in pairs(args.items) do
        if k ~= 'name' and (G.P_CENTERS[k] or G.P_BLINDS[k]) and not dontDisable[k] then
            itemcount = itemcount+1
        end
    end
    buttons[#buttons+1] = UIBox_button({button = 'disable_all_' .. args.name, label = {'Disable All Items'}, count = {tally = itemcount, of = itemcount},  minw = 5, minh = 1.7, scale = 0.6, id = 'disable_all_' .. args.name})

    for set,obj in pairs(types) do
        local count = 0
        G.FUNCS['disable_' .. set .. '_' .. args.name] = function(e)
            for k,v in pairs(args.items) do
                if k ~= 'name' and not dontDisable[k] and ((G.P_CENTERS[k] and G.P_CENTERS[k].set and G.P_CENTERS[k].set == set) or G.P_BLINDS[k] and set == 'Blind')  then
                    mod.config['Disabled Things'][k] = true
                end
            end
            SMODS.save_mod_config(mod)
        end
        for k,v in pairs(args.items) do
            if k ~= 'name' and not dontDisable[k] and G.P_CENTERS[k] and G.P_CENTERS[k].set and G.P_CENTERS[k].set == set then
                count = count+1
            end
        end
        buttons[#buttons+1] = UIBox_button({
            button = 'disable_' .. set .. '_' .. args.name, 
            label = {'Disable ' .. set .. 's'}, 
            count = {tally = count, of = count},  
            minw = 5, 
            minh = 1, 
            scale = 0.6, 
            id = 'disable_' .. set .. '_' .. args.name
        })
    end

    local t =  create_UIBox_generic_options({ 
        back_func = 'presets', 
        contents = {
            {
                n=G.UIT.R, 
                config={
                    align = "cm", 
                    r = 0.1, 
                    padding = 0.05,
                    colour = G.C.BLACK, 
                    emboss = 0.05
                }, 
                nodes=buttons
            }, 
            {
                n=G.UIT.R, 
                config={align = "cm"}, 
                nodes={
                    
                }
            }
        }
    })
  return t
end


G.FUNCS.preset_type = function(e, args)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = create_UIBOX_preset_type(args),
    }
end

G.FUNCS.presets_pageOLD = function(args)
        if not args or not args.cycle_config then return end
        print('hoi')
        --[[
        for j = 1, #G.your_collection do
            for i = #G.your_collection[j].cards,1, -1 do
                local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
                c:remove()
                c = nil
            end
        end]]
        G.deck_tables = {}
        --[[
        for i = 1, 3 do
            for j = 1, #G.your_collection do
                local center = G.P_CENTER_POOLS["Joker"][i+(j-1)*5 + (5*#G.your_collection*(args.cycle_config.current_option - 1))]
                if not center then break end
                local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
                card.sticker = get_joker_win_sticker(center)
                G.your_collection[j]:emplace(card)
            end
        end
        ]]
        for j = 1, 5 do
            --[[G.your_collection[j] = CardArea(
                G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
                5*G.CARD_W,
                0.95*G.CARD_H, 
                {card_limit = 5, type = 'title', highlight_limit = 0, collection = true}
            )]]
            table.insert(
                G.deck_tables, 
                {
                    n=G.UIT.R, 
                    config={align = "cm", padding = 0.07, no_fill = true}, 
                    nodes={
                        --{n=G.UIT.O, config={object = G.your_collection[j]}}
                        UIBox_button({
                            button = 'preset_vanilla_jokers', 
                            label = {'Disable Vanilla Jokers'.. math.random(1,3)}, 
                            minw = 5, 
                            minh = 2, 
                            scale = 0.7, 
                            id = 'preset_vanilla_jokers'
                        }),
                    }
                }
            )
        end
        INIT_COLLECTION_CARD_ALERTS()
end

G.FUNCS.presets_page = function(args)
    if not args or not args.cycle_config then return end
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = create_UIBox_preset_disables(args),
    }
end

G.FUNCS.create_custom_preset = function(e)
    mod.config['Presets'][#mod.config['Presets']+1] = mod.config['Disabled Things']
    mod.config['Presets'][#mod.config['Presets']].is_custom = true
    mod.config['Presets'][#mod.config['Presets']].name = G.preset_custom_name or 'Custom_Preset'
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = create_UIBox_preset_disables(),
    }
    SMODS.save_mod_config(mod)
end


function create_UIBox_preset_disables(args)
    if not args or not args.cycle_config then
        args = {}
        args.cycle_config = {current_option = 1}
    end
    --PRESET STUFF
        local customPresets = {}
        for k,v in pairs(mod.config['Presets']) do
            if v.is_custom then
                customPresets[#customPresets+1] = v
            end
        end


        mod.config['Presets'] = customPresets
        local tablethingy = {}
        for k,v in pairs(G.P_CENTERS) do
            if not v.mod and not dontDisable[v.key] then
                tablethingy[v.key] = true
                --mod.config['Disabled Things'][v.key] = true
            end
        end
        tablethingy.name = 'Vanilla Jokers'
        mod.config['Presets'][#customPresets+1] = tablethingy
        
        for k,v in pairs(G.P_CENTERS) do
            if v.mod and v.mod.name then
                --mod.config['Presets'][v.mod.name] = mod.config['Presets'][v.mod.name] or {}
                local reset = true
                for i = 1, #mod.config['Presets'] do
                    
                    if mod.config['Presets'][i].name == v.mod.name then
                        reset = false
                        mod.config['Presets'][i][v.key] = true
                    end
                end
                if reset == true then
                    mod.config['Presets'][#mod.config['Presets']+1] = {name = v.mod.name}
                    mod.config['Presets'][#mod.config['Presets']][v.key] = true
                end
            end
        end
        --[[
        local button_nodes = {}
        for k,v in pairs(mod.config['Presets']) do
            G.FUNCS['preset_' .. k] = function(e)
                for k_,v_ in pairs(v) do
                    --if not v.mod then
                        mod.config['Disabled Things'][v_.key] = true
                    --end
                end
            end

            button_nodes[#button_nodes+1] = UIBox_button({
                button = 'preset_' .. k, 
                label = {'Disable ' .. k}, 
                minw = 5, 
                minh = 2, 
                scale = 0.7, 
                id = 'preset_' .. k
            })
        end]]
        local button_nodes = {}
        local button_amt = 6
        for i = 1, button_amt do
            local mod_selected = mod.config['Presets'][i + (button_amt*(args.cycle_config.current_option - 1))]
            if mod_selected then


                button_nodes[#button_nodes+1] = UIBox_button({
                    button = 'preset_' .. mod_selected.name, 
                    label = {'Disable ' .. mod_selected.name}, 
                    minw = 3.5, 
                    minh = 1,
                    colour = mod_selected and mod_selected.is_custom and G.C.BLUE or nil,
                    padding = 0.05,
                    scale = 0.7, 
                    id = 'preset_' .. mod_selected.name
                })



                G.FUNCS['preset_' .. mod_selected.name] = function(e)
                    G.SETTINGS.paused = true
                    G.FUNCS.overlay_menu{
                      definition = create_UIBOX_preset_type({
                        name = mod_selected.name,
                        items = mod_selected
                      }),
                    }
                    --[[
                    for k_,v_ in pairs(mod_selected) do
                        if k_ ~= 'name' then
                            mod.config['Disabled Things'][k_] = true
                        end
                    end]]
                end
            end
        end
    --
    
    G.deck_tables = {}

    G.your_collection = {}
    for j = 1, button_amt do
        --[[G.your_collection[j] = CardArea(
            G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
            5*G.CARD_W,
            0.95*G.CARD_H, 
            {card_limit = 5, type = 'title', highlight_limit = 0, collection = true}
        )]]
        table.insert(
            G.deck_tables, 
            {
                n=G.UIT.R, 
                config={align = "cm", padding = 0.1, no_fill = true}, 
                nodes={
                    --{n=G.UIT.O, config={object = G.your_collection[j]}}
                    --[
                    UIBox_button({
                        button = 'preset_vanilla_jokers', 
                        label = {'Disable Vanilla Jokers' .. math.random(1,3)}, 
                        minw = 5, 
                        minh = 2, 
                        scale = 0.7, 
                        id = 'preset_vanilla_jokers'
                    }),
                    --]]
                }
            }
        )
    end

    local joker_options = {}
    for i = 1, math.ceil(#mod.config['Presets']/(button_amt)) do
    --for i = 1, math.ceil(3) do
        table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#mod.config['Presets']/(button_amt))))
        --table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(1))
    end
    --[[
    for i = 1, 5 do
        for j = 1, #G.your_collection do
        local center = G.P_CENTER_POOLS["Joker"][i+(j-1)*5]
        local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
        card.sticker = get_joker_win_sticker(center)
        G.your_collection[j]:emplace(card)
        end
    end
    --]]
    G.preset_custom_name = ''
    INIT_COLLECTION_CARD_ALERTS()

    local thingything = create_text_input({max_length = 25, extended_corpus = true, all_caps = false, ref_table = G, ref_value = 'preset_custom_name', localize('k_enter_name')})

    local t =  create_UIBox_generic_options({ 
        back_func = 'mods_button', 
        contents = {
            {
                n=G.UIT.R, 
                config={
                    align = "cm", 
                    r = 0.1, 
                    colour = G.C.BLACK, 
                    emboss = 0.05
                }, 
                nodes={
                    thingything,
                    UIBox_button({
                        button = 'create_custom_preset', 
                        label = {'New Preset'}, 
                        minw = 2.5, 
                        minh = 1, 
                        scale = 0.5, 
                        id = 'create_custom_preset'
                    }),
                }
            }, 
            {
                n=G.UIT.R, 
                config={
                    align = "cm", 
                    r = 0.1, 
                    colour = G.C.BLACK, 
                    emboss = 0.05
                }, 
                nodes=button_nodes
            }, 
            {
                n=G.UIT.R, 
                config={align = "cm"}, 
                nodes={
                    create_option_cycle({
                        options = joker_options, 
                        w = 4.5, cycle_shoulders = true, 
                        opt_callback = 'presets_page', 
                        current_option = args.cycle_config.current_option or 1, 
                        colour = G.C.RED, 
                        no_pips = true, 
                        focus_args = {
                            snap_to = true, 
                            nav = 'wide'
                        }
                    }),
                }
            }, 
            --[[{
                n=G.UIT.R, 
                config={align = "cm"}, 
                nodes={
                    create_text_input({max_length = 15, all_caps = false, ref_table = G, ref_value = 'preset_custom_name', prompt_text = 'Custom Preset Name'}),
                    UIBox_button({
                        button = 'create_custom_preset', 
                        label = {'New Preset'}, 
                        minw = 2, 
                        minh = 1, 
                        scale = 0.5, 
                        id = 'create_custom_preset'
                    }),
                }
            }]]
        }
    })
    --thingything:recalculate(true)
  return t
end

function create_UIBox_preset_disablesOLD()
    local t = create_UIBox_generic_options(
        {
            back_func = 'mods_button', 
            contents = {
                {
                    n=G.UIT.C, 
                    config={
                        align = "cm", 
                        padding = 0.15
                    }, 
                    nodes={
                        create_option_cycle({
                            options = 'Shit', 
                            w = 4.5, 
                            cycle_shoulders = true, 
                            opt_callback = 'presets', 
                            current_option = 1, 
                            colour = G.C.RED, 
                            no_pips = true, 
                            focus_args = {
                                snap_to = true, 
                                nav = 'wide'
                            }
                        }),
                        UIBox_button({
                            button = 'preset_vanilla_jokers', 
                            label = {'Disable Vanilla Jokers'}, 
                            minw = 5, 
                            minh = 2, 
                            scale = 0.7, 
                            id = 'preset_vanilla_jokers'
                        }),
                        --UIBox_button({button = 'your_collection_decks', label = {localize('b_decks')}, count = G.DISCOVER_TALLIES.backs, minw = 5}),
                        --UIBox_button({button = 'your_collection_vouchers', label = {localize('b_vouchers')}, count = G.DISCOVER_TALLIES.vouchers, minw = 5, id = 'your_collection_vouchers'}),
                    }
                },
            }
        }
    )
    return t
end

G.FUNCS.presets = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = create_UIBox_preset_disables(),
    }
end


local jimboTabs = function() return {
	{
		label = "Config",
		chosen = true,
		tab_definition_function = function()
			jimbo_nodes = {}
			settings = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} }

            settings.nodes[#settings.nodes + 1] =
                UIBox_button({button = 'enable_all', label = {"Reset Disabled"},  minw = 5, minh = 1.7, scale = 0.6, id = 'enable_all'})
            settings.nodes[#settings.nodes + 1] =
                UIBox_button({button = 'presets', label = {"Presets"},  minw = 5, minh = 1.7, scale = 0.6, id = 'presets'})
            
            
			config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
			jimbo_nodes[#jimbo_nodes + 1] = config
			return {
				n = G.UIT.ROOT,
				config = {
					emboss = 0.05,
					minh = 6,
					r = 0.1,
					minw = 10,
					align = "cm",
					padding = 0.2,
					colour = G.C.BLACK,
				},
				nodes = jimbo_nodes,
			}
		end,
	},
} 
end
SMODS.current_mod.extra_tabs = jimboTabs



----------------------------------------------
------------MOD CODE END----------------------
