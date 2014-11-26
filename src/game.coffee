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
  
create_level = (game_levels, level) ->
  level_dict = game_levels.at(level)
  level_dict.level_index = level
  level_dict.level_count = game_levels.length()
  level_dict

create_game = (file) ->
  ""
  
exports.game = (rx, query) ->
  root = god(rx, {})
  world = create_game(root, query.file)
  
  game_dict = find_game query.file
  world = god(rx, game_dict)
  
  game_levels = world.get('levels')
  my.assert game_levels and world.is_array(game_levels)
  
  level = query.level or 0
  level_dict = create_level(game_levels, level)
  level_world = world.add_child level_dict
  for child in layout
    level_world.add_child child(level_dict)

  world.send(my.key.setup)
  world
