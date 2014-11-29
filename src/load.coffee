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
{list} = require './load/list'
{game_files} = require './load/game_files'
{games} = require './games'
{make} = require './render/make'

queryString = require 'query-string' #https://github.com/sindresorhus/query-string

my.extend game_files, games

globals = ['kinds', 'shapes', 'actions']

set_shape = (sprite_dict) ->
  shapes = sprite_dict.shapes
  shape = sprite_dict.shape
  return unless shape
  paths = shapes.get(shape).all()
  my.assert paths, "No paths for #{shape} of #{sprite_dict}"
  sprite_dict.paths = paths

set_kind = (sprite_dict) ->
  kinds = sprite_dict.kinds
  kind = sprite_dict.kind
  return unless kind
  authority = kinds.get(kind)
  my.assert authority, "No kind #{kind} for #{sprite_dict}"
  sprite_dict.authority = authority
  # TODO: cache world-ified kinds here instead of creating one for each sprite
  
parse_level = (level, level_count) ->
  level_at = parseInt(level) - 1
  level_at = 0 if level_at < 0
  level_at = level_count - 1 unless level_at < level_count
  level_at
  
create_level = (world, level) ->
  game_levels = world.get 'levels'
  my.assert game_levels and world.is_array(game_levels)
  level_count = game_levels.length()
  level_at = parse_level(level, level_count)
  level_index = level_at + 1

  world.import_dict {
    level_index: level_index
    level_count: level_count
    next_url: (world) -> make.anchor('a', world.get 'next_params').href
    next_params: (world) ->
      if level_index < level_count 
        {game: world.get('game'), level: level_index + 1}
      else 
        {list: 'all'}
  }
  game_levels.at(level_at)

extend_globals = (root, dict) ->
  for key in globals
    parent = root.get key
    value = dict[key] or {}
    dict[key] = parent.add_child(value)

extend_world = (root, dict) ->
  extend_globals(root, dict)
  root.add_child dict
  
create_game = (root, game) ->
  game_dict = game_files[game]
  my.assert game_dict, "Can not load game #{game}"
  game_dict.game = game
  basis = game_dict.assume
  return extend_world(root, game_dict) unless basis
  parent = create_game(root, basis)
  extend_world(parent, game_dict)
  
exports.load = (rx, query) ->
  root = god(rx, {})
  return list(root, games) if query.list
  
  globals.map (key) -> root.put key, root.make_world({})
  world = create_game root, query.game
  world.put 'games', Object.keys games
  
  level = query.level
  level_world = extend_world world, create_level(world, level)
  console.log 'level_world', level_world.get('actions').doc.x
  for child in layout
    level_world.add_child child(level_world)

  sprites = level_world.get 'sprites'
  for sprite_dict in sprites.all()
    extend_globals(level_world, sprite_dict)
    set_shape(sprite_dict)
    set_kind(sprite_dict)
    level_world.send 'make_sprite', sprite_dict

  world.send(my.key.setup)
  world
