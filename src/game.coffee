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

globals = ['shapes', 'words']
  
create_level = (game_levels, level) ->
  level_dict = game_levels.at(level)
  level_dict.level_index = level
  level_dict.level_count = game_levels.length()
  level_dict

extend_game = (root, dict) ->
  world = root.add_child dict
  for key in globals
    if value = dict[key] # TODO: use 'where'?
      parent = root.get key
      world.put(key, parent.add_child value)
  world 
  
create_game = (root, file) ->
  game_dict = game_files[file]
  my.assert game_dict, "Can not load game #{file}"
  basis = game_dict.assume
  return extend_game(root, game_dict) unless basis
  parent = create_game(root, basis)
  extend_game(parent, game_dict)
  
exports.game = (rx, query) ->
  root = god(rx, {})
  for key in globals
    root.put key, root.make_world({})
  world = create_game(root, query.file)
  
  game_levels = world.get('levels')
  my.assert game_levels and world.is_array(game_levels)
  
  level = query.level or 0
  level_dict = create_level(game_levels, level)
  level_world = world.add_child level_dict
  for child in layout
    level_world.add_child child(level_dict)

  world.send(my.key.setup)
  world
