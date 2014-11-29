{my} = require '../my'
{make} = require '../render/make'

exports.list = (root, games) ->
  list = root.add_child {
    name: 'Game Listings'
    name_style: {font_size: 24}
    _AUTHORITY: {name_style: {font_size: 18}}
  }
   
  rows = []
  for key, value of games
    console.log "game", key, value
    break unless value
    dict = {game: key, level: 1}
    rows.push make.anchor " • #{value.name}", dict
  list.add_child make.rows('games', rows)
  root