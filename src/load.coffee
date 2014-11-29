#
# game.coffee
#
# Role: concisely capture the unique properties of a game
#
# Responsibility:
# * require all valid game files 
# * load a game based on the query 
# * merge properties from baseline
# * set current level as the load's child
# * return the game dictionary 

{my} = require './my'
{god} = require './god'
{layout} = require './layout'
{game_files} = require './load/game_files'
{games} = require './games'
{make} = require './render/make'

my.extend game_files, games

globals = ['shapes', 'actions']

set_shape = (sprite_dict) ->
  shapes = sprite_dict.shapes
  shape = sprite_dict.shape
  paths = shapes.get(shape).all()
  my.assert paths, "No paths for #{shape} of #{sprite_dict}"
  sprite_dict.paths = paths
  
create_level = (game_levels, level) ->
  level_count = game_levels.length()
  level_at = parseInt(level) - 1
  level_at = 0 if level_at < 0
  level_at = level_count - 1 unless level_at < level_count

  level_dict = game_levels.at(level_at)
  level_dict.level_index = level_at + 1
  level_dict.level_count = level_count 
  level_dict

extend_globals = (root, dict) ->
  for key in globals
    parent = root.get key
    value = dict[key] or {}
    dict[key] = parent.add_child(value)

extend_world = (root, dict) ->
  extend_globals(root, dict)
  root.add_child dict
  
create_game = (root, file) ->
  game_dict = game_files[file]
  my.assert game_dict, "Can not load game #{file}"
  game_dict.file = file
  basis = game_dict.assume
  return extend_world(root, game_dict) unless basis
  parent = create_game(root, basis)
  extend_world(parent, game_dict)
  
exports.load = (rx, query) ->
  root = god(rx, {})
  globals.map (key) -> root.put key, root.make_world({})
  world = create_game root, query.file
  world.put 'games', Object.keys games
  
  game_levels = world.get 'levels'
  my.assert game_levels and world.is_array(game_levels)
  
  level = query.level
  level_world = extend_world world, create_level(game_levels, level)
  console.log 'level_world', level_world.get('actions').doc.x
  for child in layout
    level_world.add_child child(level_world)

  shapes = level_world.get 'shapes'
  sprites = level_world.get 'sprites'
  for sprite_dict in sprites.all()
    extend_globals(level_world, sprite_dict)
    set_shape(sprite_dict)
    level_world.send 'make_sprite', sprite_dict

  world.send(my.key.setup)
  world
