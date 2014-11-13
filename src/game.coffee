# game.coffee
#
# Role: concisely capture the unique properties of a game
#
# Responsibility:
# * require all valid game files 
# * load a game based on the query 
# * merge properties from baseline
# * set current level as the game's child
# * return the game dictionary 

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

exports.game = (query) ->
  game_dict = load_game query.name
  level = query.level or 0
  my.assert game_dict.levels and _.isArray(game_dict.levels)
  level_dict = game_dict.levels[level]
  level_dict.level_index = level
  level_dict.level_count = game_dict.levels.length
  level_dict.game = game_dict.name 
  game_dict[my.key.children] = [level_dict]
  game_dict