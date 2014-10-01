# Data model

class Item
  constructor: (data) ->
    @data = rx.cell(data)

exports.items = rx.array([
  new Item('Item the First')
  new Item('Item the Second')
])
