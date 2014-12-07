#
# game_files.coffee
#
# Role: list all game modules, in no particular order
#

exports.games = {
  tutorial: require("../games/tutorial").game
  edit: require("../games/edit").game
  example: require("../games/example").game
  sampler: require("../games/sampler").game
}
