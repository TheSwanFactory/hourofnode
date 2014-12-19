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

{my}         = require './my'
{god}        = require './god'
{layout}     = require './layout'
{list}       = require './load/list'
{game_files} = require './load/game_files'
{games}      = require './games'
{make}       = require './render/make'
{changelog}  = require './layout/changelog'
{utils}      = require './utils'

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
    last_level:  level_index >= level_count
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
  extend_level level, level_at
  $.extend true, level, get_custom_level()

extend_level = (level, level_index) ->
  level.level_name = level.name
  delete level.name

  level._EXPORTS ?= []
  level._EXPORTS.push 'edit'
  level._EXPORTS.push 'save'

  level.edit_mode    = false
  level.level_edited = false
  level.edit      = (world, args) ->
    world.put 'edit_mode', true
  level.save      = (world, args) ->
    world.put 'edit_mode',    false
    world.put 'level_edited', true

  add_splash_dialog level, level_index
  add_stored_properties level

add_splash_dialog = (level, level_index) ->
  level.init = (world) ->
    $splash = $('<div class="splash">')
    if level_index == 0
      if world.get('description', false)?
        $splash.append "<div class='description'>#{world.get 'description', false}</div>"
      $splash.append "
        <div class='info'>
          <span>Please enter your</span>
          <div><input class='name' placeholder='Initials' /></div>
          <span>and</span>
          <div><input class='color' placeholder='Favorite Color' /></div>
        </div>
      "
    if world.get('level_name', false)? && splash_allowed()
      $splash.append "<div class='level_name'>#{world.get 'level_name', false}</div>"

    if $splash.children().length > 0
      $splash.dialog
        modal:   true
        buttons: [{text: 'Ok', click: -> $(this).dialog('close')}]
        width:   400
        create:  ->
          $pane = $splash.dialog('widget').find '.ui-dialog-buttonpane'
          $pane.prepend "
            <label><small>
              Don't show hints
              <input class='dont-show' type='checkbox' />
            </small></label>"
        beforeClose: ->
          store_me  world, $splash
          dont_show world, $splash

splash_allowed = ->
  !(utils.fetch('hide_dialogs') || document.referrer == location.toString())

store_me = (world, $splash) ->
  name  = $splash.find('.name').val()
  color = $splash.find('.color').val()
  return unless name? and color?
  world.send 'store_me', name: name, color: color

dont_show = (world, $splash) ->
  return unless $splash.dialog('widget').find('.dont-show').is(':checked')

  utils.store hide_dialogs: true

add_stored_properties = (level) ->
  [name, color] = utils.fetch ['name', 'color']
  sprite = _.findWhere level.sprites, kind: 'turtle'
  return unless sprite?
  sprite.name  = name
  sprite.color = color

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
