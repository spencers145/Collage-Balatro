local oldcalcseal = Card.calculate_seal
function Card:calculate_seal(context)
    local g = {oldcalcseal(self, context)}
    if next(g) then
        SMODS.calculate_context({cmykl_seal_trigger = true})
    end
    return unpack(g)
end