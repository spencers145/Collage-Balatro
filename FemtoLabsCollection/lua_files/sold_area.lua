femtoLabsCollection.SoldArea = CardArea:extend()

function femtoLabsCollection.SoldArea:init(...)
    CardArea.init(self, ...)
    table.insert(G.I.CARDAREA, self)

    self.states.collide.can = false
    self.states.hover.can = false
    self.states.click.can = false

    self.being_hovered = false
    self.send_active = false
    self.selecting_shop = false
    self.override_show = 0

    self.ARGS.invisible_area_types = {sold_area = 1} --wtf is this for?
end

function femtoLabsCollection.SoldArea:draw()

end

