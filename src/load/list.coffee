{my} = require '../my'
{make} = require '../render/make'

exports.list = (root, games, filter) ->
  window.open my.feedback_url if my.beta unless filter == "test"

  list = root.add_child {
    name: 'Game Listings'
  }

  rows = []
  for key, value of games
    continue unless value
    dict = {game: key, level: 1}
    rows.push {_CHILDREN: [make.anchor value.name, dict]}
  list.add_child make.rows('games', rows)
  root
