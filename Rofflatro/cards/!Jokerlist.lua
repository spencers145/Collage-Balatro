--joker list
local joker_list = {
    'thanksfortheprimes',
    'sevenssuck',
    'drawthediamonds',
    'wherefaces',
    'moralsupport',
    'grossmichael',
}
-- load all individual jokers
for _, key in ipairs(joker_list) do
    SMODS.load_file('cards/jokers/'..key..'.lua')()
end
