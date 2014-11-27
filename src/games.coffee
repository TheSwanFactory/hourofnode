#
# game_files.coffee
#
# Role: list all game modules, in no particular order
#

exports.games = {
  example: require("./games/example").game
  tutorial: require("./games/tutorial").game
}
