-- Based on the Nopeus mod, with minor adaptations for the Lost Edition mod.
-- Credits to the Nopeus creators (jenwalter666, stupxd).

LostedSpeed = {}
function LostedSpeed.FF()
    return G.SETTINGS.FASTFORWARD
end

G.FUNCS.change_statustext = function(args)
    G.SETTINGS.STATUSTEXT = (
        args.to_val == localize('k_status_text_less_annoying') and 1 or
        args.to_val == localize('k_status_text_no_misc') and 2 or
        args.to_val == localize('k_status_text_none') and 3 or
        0
    )
end

function G.UIDEF.lostedspeed_options()
    local speeds = create_option_cycle({
        label = localize('b_set_gamespeed'),
        scale = 0.8,
        options = {0.25, 0.5, 1, 2, 3, 4, 8, 16, 32, 64, 128},
        opt_callback = 'change_gamespeed',
        current_option = (
            G.SETTINGS.GAMESPEED == 0.25 and 1 or
            G.SETTINGS.GAMESPEED == 0.5 and 2 or
            G.SETTINGS.GAMESPEED == 1 and 3 or
            G.SETTINGS.GAMESPEED == 2 and 4 or
            G.SETTINGS.GAMESPEED == 3 and 5 or
            G.SETTINGS.GAMESPEED == 4 and 6 or
            G.SETTINGS.GAMESPEED == 8 and 7 or
            G.SETTINGS.GAMESPEED == 16 and 8 or
            G.SETTINGS.GAMESPEED == 32 and 9 or
            G.SETTINGS.GAMESPEED == 64 and 10 or
            G.SETTINGS.GAMESPEED == 128 and 11 or
            3
        )
    })
    return speeds
end

function G.UIDEF.lostedspeed_statustext_options()
    if not G.SETTINGS.STATUSTEXT then G.SETTINGS.STATUSTEXT = 0 end
    local st = create_option_cycle({
        label = localize('k_status_text_label'),
        w = 5,
        scale = 0.8,
        options = {
            localize('k_status_text_all'),
            localize('k_status_text_less_annoying'),
            localize('k_status_text_no_misc'),
            localize('k_status_text_none')
        },
        opt_callback = 'change_statustext',
        current_option = G.SETTINGS.STATUSTEXT + 1
    })
    return st
end

local cest = card_eval_status_text
function card_eval_status_text(card, eval_type, amt, percent, dir, extra)
    if (G.SETTINGS.STATUSTEXT and G.SETTINGS.STATUSTEXT == 3) or (G.SETTINGS.FASTFORWARD and G.SETTINGS.FASTFORWARD > 2) then
        return
    end

    if G.SETTINGS.STATUSTEXT and G.SETTINGS.STATUSTEXT == 2 then
        if eval_type == 'extra' then return end
    end

    if G.SETTINGS.STATUSTEXT and G.SETTINGS.STATUSTEXT >= 1 then
        local msg = ((extra or {}).message or '')
        if msg == localize('k_again_ex') or msg == 'Again?' or msg == localize('k_upgrade_ex') then
            return
        end
    end

    return cest(card, eval_type, amt, percent, dir, extra)
end

local gfecr = G.FUNCS.end_consumeable
if gfecr then
    G.FUNCS.end_consumeable = function(e, delayfac)
        delayfac = delayfac or 1
        gfecr(e, delayfac)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2*delayfac,
            blocking = true,
            blockable = false,
            func = function()
                if G.pack_cards then
                    G.pack_cards:remove()
                    G.pack_cards = nil
                end
            return true
        end}))
    end
end