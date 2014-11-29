#
# game_files.coffee
#
# Role: list all game modules, in no particular order
#

exports.game_files = {
  geometry: require("./geometry").game
  kinds: require("./kinds").game
  shapes: require("./shapes").game
  actions: require("./actions").game
  baseline: require("./baseline").game
}
