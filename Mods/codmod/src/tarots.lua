-- No emperor looping
SMODS.Tarot:take_ownership('c_fool',
    {
	in_pool = function (self, args)
        if (args.source == 'emp') then
            return false
        end
        return true
    end
    },
    true
)

SMODS.Tarot:take_ownership('c_emperor',
    {
	in_pool = function (self, args)
        if (args.source == 'emp') then
            return false
        end
        return true
    end
    },
    true
)
