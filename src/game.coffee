{my} = require './my'

games = {
  baseline: require("./game/baseline").game
  example: require("./game/example").game
}

extensible = ['language', 'shapes']

merge = (stock, custom) ->
  addons = {}
  extensible.map (key) ->
    addons[key] = $.extend stock[key], custom[key]
  $.extend stock, custom, addons

load_game = (name) ->
  new_game = games[name]
  my.assert new_game, "Can not load game #{name}"
  basis = new_game.based_on
  return new_game unless basis
  merge load_game(basis), new_game

choose_game = (query) ->
  load_game query.name

exports.game = (query) ->
  choose_game query
