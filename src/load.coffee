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
{changelog} = require './layout/changelog'

queryString = require 'query-string' #https://github.com/sindresorhus/query-string

_.extend game_files, games

globals = ['kinds', 'shapes', 'actions']

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
    previous_params: (world) ->
      if level_index > 1
        {game: world.get('game'), level: level_index - 1}
      else
        {list: 'all'}
    next_params: (world) ->
      if level_index < level_count
        {game: world.get('game'), level: level_index + 1}
      else
        {list: 'all'}
  }
  level = game_levels.at(level_at)
  $.extend true, level, get_custom_level()

get_custom_level = ->
  query  = queryString.parse(location.search)
  custom = query.custom

  return unless custom?

  try
    custom = decodeURIComponent custom
    custom = JSON.parse custom
    changelog.set_custom custom
    custom
  catch
    console.error 'unable to read custom JSON'
    null

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
  root = god(rx, my)
  return list(root, games, query.list) if query.list

  globals.map (key) -> root.put key, root.make_world({})
  world = create_game root, query.game
  world.put 'games', Object.keys games

  level = query.level
  level_world = extend_world world, create_level(world, level)
  for child in layout
    level_world.add_child child(level_world)

  sprites = level_world.get 'sprites'
  for sprite_dict in sprites.all()
    level_world.put 'kinds', sprite_dict.kinds
    extend_globals(level_world, sprite_dict)
    level_world.send 'make_sprite', sprite_dict

  world.send(my.key.setup)
  world
