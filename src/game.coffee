#
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
{god} = require './god'
{layout} = require './layout'
{game_files} = require './game/game_files'

game_cache = {}

extensible = ['language', 'shapes']

merge = (stock, custom) ->
  addons = {}
  extensible.map (key) ->
    addons[key] = my.extend {}, stock[key], custom[key]
  my.extend {}, stock, custom, addons

find_game = (name) -> game_cache[name] or load_game(name)

load_game = (name) ->
  new_game = game_files[name]
  my.assert new_game, "Can not load game #{name}"
  basis = new_game.assume
  return new_game unless basis
  console.log "load_game basis #{basis}"
  result = merge find_game(basis), new_game
  game_cache[name] = result
  result

exports.game = (rx, query) ->
  game_dict = find_game query.name
  level = query.level or 0
  my.assert game_dict.levels and _.isArray(game_dict.levels)
  world = god(rx, game_dict)
  
  level_dict = game_dict.levels[level]
  level_dict.level_index = level
  level_dict.level_count = game_dict.levels.length
  level_dict.game = game_dict.name 
  
  level_dict._CHILDREN = []
  for child in layout
    level_dict._CHILDREN.push child(level_dict)
  
  level_world = world.add_child level_dict
  world.send(my.key.setup)
  
  world
