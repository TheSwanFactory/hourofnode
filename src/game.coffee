
games = {
  baseline: require("./game/baseline").game
  example: require("./game/example").game
}

choose_game = (query) -> games[query.name]

extensible = ['language', 'shapes']

merge = (stock, custom) ->
  addons = {}
  extensible.map (key) ->
    addons[key] = $.extend stock[key], custom[key]
  $.extend stock, custom, addons

exports.game = (query) ->
  baseline = choose_game({name: 'baseline'})
  new_game = choose_game query
  merge baseline, new_game
